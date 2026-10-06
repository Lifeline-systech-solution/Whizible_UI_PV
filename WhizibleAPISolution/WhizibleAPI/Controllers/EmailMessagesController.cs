using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http.ExceptionHandling;
using System.Web.Http;
using System.Text;
using System.Net.Mail;
using CommonFunctions;
using System.IO;
using System.Configuration;
using System.Net.Http;
using System.Threading.Tasks;
//using Interop.CDO;

using WhizibleAPI.Models.EmailMessages;
using Microsoft.VisualBasic;
using WhizibleAPI.Models.Project_Review;
using EASendMail;
using Microsoft.Identity.Client;
using Newtonsoft.Json;

namespace WhizibleAPI.Controllers
{
    public class EmailMessagesController : ApiController
    {
        // Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery
        private static string tenantId = ConfigurationManager.AppSettings["tenantId_Email"]?.ToString();
        private static string clientId = ConfigurationManager.AppSettings["ClientID_Email"]?.ToString();
        private static string clientSecret = ConfigurationManager.AppSettings["clientSecret_Email"]?.ToString();
        private static string userApi = ConfigurationManager.AppSettings["UserAPI_Email"]?.ToString();

        private static bool IsSMTPEnabled()
        {
            string isSMTPEnable = ConfigurationManager.AppSettings["IsSMTPEnable"];
            if (string.IsNullOrWhiteSpace(isSMTPEnable))
            {
                return true;
            }

            bool parsedValue;
            if (bool.TryParse(isSMTPEnable, out parsedValue))
            {
                return parsedValue;
            }

            return true;
        }

        // Added By Vyankat B. on 03-07-2026 for Azure Email failure logging in common ATTACHMENTS/Log folder
        private static string GetAzureEmailLogFolder()
        {
            try
            {
                if (HttpContext.Current != null)
                {
                    string mappedPath = HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/");
                    if (!string.IsNullOrWhiteSpace(mappedPath))
                        return mappedPath.TrimEnd('\\', '/');
                }
            }
            catch { }

            string baseDir = AppDomain.CurrentDomain.BaseDirectory.TrimEnd('\\', '/');
            string[] relativePaths = new[]
            {
                @"..\..\..\ATTACHMENTS\Log",
                @"..\..\..\..\ATTACHMENTS\Log"
            };

            foreach (string relativePath in relativePaths)
            {
                try
                {
                    string candidatePath = Path.GetFullPath(Path.Combine(baseDir, relativePath));
                    string parentFolder = Path.GetDirectoryName(candidatePath);
                    if (!string.IsNullOrWhiteSpace(parentFolder) && Directory.Exists(parentFolder))
                        return candidatePath;
                }
                catch { }
            }

            return Path.Combine(baseDir, "ATTACHMENTS", "Log");
        }

        private static string FormatGraphApiFailureReason(int statusCode, string reasonPhrase, string responseBody, string requestUrl)
        {
            string parsedReason = responseBody ?? string.Empty;

            if (!string.IsNullOrWhiteSpace(responseBody))
            {
                try
                {
                    dynamic errObj = JsonConvert.DeserializeObject(responseBody);
                    if (errObj != null && errObj.error != null)
                    {
                        string code = errObj.error.code != null ? errObj.error.code.ToString() : "";
                        string graphMessage = errObj.error.message != null ? errObj.error.message.ToString() : responseBody;
                        parsedReason = string.IsNullOrWhiteSpace(code) ? graphMessage : code + " - " + graphMessage;
                    }
                }
                catch
                {
                    parsedReason = responseBody;
                }
            }

            return statusCode + " " + (reasonPhrase ?? "Error") + " | API: " + requestUrl + " | " + parsedReason;
        }

        private static string GetAzureEmailFailureReason(Exception ex)
        {
            if (ex == null)
                return "Unknown error";

            string message = ex.Message ?? "Unknown error";
            const string graphPrefix = "Graph API error:";

            if (message.IndexOf(graphPrefix, StringComparison.OrdinalIgnoreCase) >= 0)
            {
                string jsonPart = message.Substring(message.IndexOf(graphPrefix, StringComparison.OrdinalIgnoreCase) + graphPrefix.Length).Trim();
                try
                {
                    dynamic errObj = JsonConvert.DeserializeObject(jsonPart);
                    if (errObj != null && errObj.error != null)
                    {
                        string code = errObj.error.code != null ? errObj.error.code.ToString() : "";
                        string graphMessage = errObj.error.message != null ? errObj.error.message.ToString() : jsonPart;
                        return string.IsNullOrWhiteSpace(code) ? graphMessage : code + " - " + graphMessage;
                    }
                }
                catch
                {
                    return jsonPart;
                }
            }

            if (ex.InnerException != null && !string.IsNullOrWhiteSpace(ex.InnerException.Message))
                return message + " | " + ex.InnerException.Message;

            return message;
        }

        private static void WriteAzureEmailFailureLog(string logFolder, string source, string reason,
            string to = "", string cc = "", string from = "", string subject = "")
        {
            try
            {
                if (string.IsNullOrWhiteSpace(logFolder))
                    logFolder = GetAzureEmailLogFolder();

                if (!Directory.Exists(logFolder))
                    Directory.CreateDirectory(logFolder);

                string logFile = Path.Combine(logFolder, "AzureEmailLog_" + DateTime.Now.ToString("yyyyMMdd") + ".txt");

                using (StreamWriter sw = new StreamWriter(logFile, true))
                {
                    sw.WriteLine("--------------------------------------------------");
                    sw.WriteLine("Time   : " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss tt"));
                    sw.WriteLine("Source : " + source);
                    sw.WriteLine("To     : " + to);
                    sw.WriteLine("CC     : " + cc);
                    sw.WriteLine("From   : " + from);
                    sw.WriteLine("Subject: " + subject);
                    sw.WriteLine("Reason : " + reason);
                    sw.WriteLine("--------------------------------------------------");
                    sw.Flush();
                }
            }
            catch { }
        }

        private static void WriteAzureEmailFailureLog(string logFolder, string source, Exception ex,
            string to = "", string cc = "", string from = "", string subject = "")
        {
            WriteAzureEmailFailureLog(logFolder, source, GetAzureEmailFailureReason(ex), to, cc, from, subject);
        }
        // End of Added By Vyankat B. on 03-07-2026 for Azure Email failure logging in common ATTACHMENTS/Log folder

        public static async Task<string> GetAccessToken()
        {
            var app = ConfidentialClientApplicationBuilder.Create(clientId)
                .WithClientSecret(clientSecret)
                .WithAuthority($"https://login.microsoftonline.com/{tenantId}")
                .Build();

            var scopes = new[] { "https://graph.microsoft.com/.default" };
            var result = await app.AcquireTokenForClient(scopes).ExecuteAsync().ConfigureAwait(false);
            return result.AccessToken;
        }

        public static async Task SendEmailUsingAzure(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody)
        {
            const string logSource = "WhizibleAPI.EmailMessagesController";
            string azureLogFolder = GetAzureEmailLogFolder();
            try
            {
            string strTempToEmailId = General.CheckIsNothing(strToEmailID);
            string strTempCCEmailID = General.CheckIsNothing(strCCEmailID);
            List<object> toRecipientsList = new List<object>();
            List<object> ccRecipientsList = new List<object>();

            if (strTempToEmailId != "")
            {
                strTempToEmailId = strTempToEmailId.Replace(";;", ";").Replace("; ;", ";").Replace(";", ",");
                if (strTempToEmailId.Substring(strTempToEmailId.Length - 1, 1) == ";" | strTempToEmailId.Substring(strTempToEmailId.Length - 1, 1) == ",")
                    strTempToEmailId = strTempToEmailId.Trim().Remove(strTempToEmailId.Trim().Length - 1);

                var emailArray = strTempToEmailId.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var email in emailArray)
                {
                    if (!string.IsNullOrWhiteSpace(email))
                    {
                        toRecipientsList.Add(new { emailAddress = new { address = email.Trim() } });
                    }
                }
            }

            if (strTempCCEmailID != "")
            {
                strTempCCEmailID = strCCEmailID.Replace(";", ",");
                if (strTempCCEmailID.Substring(strTempCCEmailID.Trim().Length - 1, 1) == ";" || strTempCCEmailID.Substring(strTempCCEmailID.Trim().Length - 1, 1) == ",")
                    strTempCCEmailID = strTempCCEmailID.Trim().Remove(strTempCCEmailID.Length - 1);
                else
                    strTempCCEmailID = strTempCCEmailID.Trim();

                var ccEmailArray = strTempCCEmailID.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var email in ccEmailArray)
                {
                    if (!string.IsNullOrWhiteSpace(email))
                    {
                        ccRecipientsList.Add(new { emailAddress = new { address = email.Trim() } });
                    }
                }
            }

            string emailContentType = "TEXT";
            if (!string.IsNullOrWhiteSpace(CommonFunctions.Application.EmailFormat) && CommonFunctions.Application.EmailFormat.ToUpper() == "HTML")
            {
                emailContentType = "HTML";
            }

            // Added By Vyankat B. on 1st July 2026 - build Graph sendMail URL from request From email
            string senderMailbox = General.CheckIsNothing(strFromEmailID).Trim();
            if (string.IsNullOrWhiteSpace(senderMailbox))
            {
                throw new Exception("From email address is required for Azure Graph email delivery.");
            }

            string sendMailApi = userApi.TrimEnd('/') + "/" + senderMailbox + "/sendMail";
            // End of Added By Vyankat B. on 1st July 2026 - build Graph sendMail URL from request From email

            var token = await GetAccessToken().ConfigureAwait(false);

            var mailData = new
            {
                message = new
                {
                    subject = strSubject,
                    body = new { contentType = emailContentType, content = strEmailBody },
                    toRecipients = toRecipientsList.ToArray(),
                    ccRecipients = ccRecipientsList.ToArray()
                },
                saveToSentItems = true
            };

            var json = JsonConvert.SerializeObject(mailData);

            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Authorization =
                    new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);

                var content = new StringContent(json, Encoding.UTF8, "application/json");
                var response = await client.PostAsync(sendMailApi, content).ConfigureAwait(false);

                if (!response.IsSuccessStatusCode)
                {
                    var error = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                    string failureReason = FormatGraphApiFailureReason((int)response.StatusCode, response.ReasonPhrase, error, sendMailApi);
                    WriteAzureEmailFailureLog(azureLogFolder, logSource, failureReason, strToEmailID, strCCEmailID, strFromEmailID, strSubject);
                    throw new Exception("Graph API error: " + error);
                }
            }

            }
            catch (Exception ex)
            {
                WriteAzureEmailFailureLog(azureLogFolder, logSource, ex, strToEmailID, strCCEmailID, strFromEmailID, strSubject);
                throw;
            }
        }
        // End of Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery

        [Authorize]
        [HttpPost]
        public static void GetEmailMessage_435(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intVerifiedByID, int intResourceID, DateTime dteFromDate, DateTime dteToDate, int TimesheetID)
        {
            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;
            string Comment = "";
            IDataReader objDr;
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 435;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            //Get from email id.. ID of the person who verified the timesheet
            GetEmployeeInfo(intVerifiedByID, ref strUserName, ref strFromEmailID);

            //Commented & Added By Dipali V on 28th Nov 2021 for Approve Comment
            //objDr = CommonFunctions.Data.GetDataReader("usp_Whizible2_Get_tbl_PM_ResourceTimesheet " + TimesheetID + "", true, CommonController.connectionString);
            objDr = CommonFunctions.Data.GetDataReader("usp_Whizible2_Get_tbl_PM_ResourceTimesheet_Comment " + TimesheetID + "", true, CommonController.connectionString);
            //End of Commented & Added By Dipali V on 28th Nov 2021 for Approve Comment
            if (objDr.Read())
            {
                Comment = objDr["Comment"].ToString() + "";
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            strMessage.Replace("<SENDER_NAME>", strUserName);


            strEmailSubject.Replace("<FROM_DATE>", CommonFunctions.Dates.CGetDate(dteFromDate));
            strEmailSubject.Replace("<TO_DATE>", CommonFunctions.Dates.CGetDate(dteToDate));

            strMessage.Replace("<FROM_DATE>", CommonFunctions.Dates.CGetDate(dteFromDate));
            strMessage.Replace("<TO_DATE>", CommonFunctions.Dates.CGetDate(dteToDate));
            strMessage.Replace("<REMARK>", Comment);
            //Get To Email ID .. ID of the resource whose timesheet is getting verified
            GetEmployeeInfo(intResourceID, ref strUserName, ref strToEmailID);
            strMessage.Replace("<NAME>", strUserName);


            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage_436(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intVerifiedByID, int intResourceID, int TimesheetID)
        {
            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;
            string Comment = "";
            IDataReader objDr;

            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 436;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            //Get from email id.. ID of the person who verified the timesheet
            GetEmployeeInfo(intVerifiedByID, ref strUserName, ref strFromEmailID);
            //Commented &Added By Dipai V On 28th Nov 2021 For Getting Comments
            //objDr = CommonFunctions.Data.GetDataReader("usp_Whizible2_Get_tbl_PM_ResourceTimesheet " + TimesheetID + "", true, CommonController.connectionString);
            objDr = CommonFunctions.Data.GetDataReader("usp_Whizible2_Get_tbl_PM_ResourceTimesheet_Comment " + TimesheetID + "", true, CommonController.connectionString);
            //End of Commented &Added By Dipai V On 28th Nov 2021 For Getting Comments
            if (objDr.Read())
            {
                Comment = objDr["Comment"].ToString() + "";
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            strMessage.Replace("<SENDER_NAME>", strUserName);
            strMessage.Replace("<REMARK>", Comment);

            //strEmailSubject.Replace("<FROM_DATE>", CommonFunctions.Dates.CGetDate(dteFromDate));
            //strEmailSubject.Replace("<TO_DATE>", CommonFunctions.Dates.CGetDate(dteToDate));

            //strMessage.Replace("<FROM_DATE>", CommonFunctions.Dates.CGetDate(dteFromDate));
            //strMessage.Replace("<TO_DATE>", CommonFunctions.Dates.CGetDate(dteToDate));

            //Get To Email ID .. ID of the resource whose timesheet is getting verified
            GetEmployeeInfo(intResourceID, ref strUserName, ref strToEmailID);
            strMessage.Replace("<NAME>", strUserName);


            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }
        public static void GetEmailMessage_434(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intTimesheetID)
        {
            IDataReader drSenderInfo;
            IDataReader drRecieverInfo;
            string strSenderName = "";
            string strSQLQuery;
            string strSenderEmail;
            string strReciverEmail;
            string strRecieverName = "";
            string strReportingTo;
            IDataReader drTimesheet;
            string strFromDate = "";
            string strToDate = "";
            int intMessageID;
            string strSubmitter = "";


            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;
            // HttpContext Context = HttpContext.Current;
            // Context.Cuure
            intMessageID = 434;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);



            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strSQLQuery = "EXEC usp_GetResourceTimesheetApprovers " + intTimesheetID;
            drRecieverInfo = CommonFunctions.Data.GetDataReader(strSQLQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drRecieverInfo) != "")
            {
                if (drRecieverInfo.Read())
                {
                    strToEmailID = drRecieverInfo["DefaultApprovers"].ToString() + "";
                    strRecieverName = drRecieverInfo["ApproverNames"].ToString() + "";
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drRecieverInfo);


            if (intTimesheetID != 0)
            {
                strSQLQuery = "Select FromDate, ToDate,EmployeeID From tbl_PM_ResourceTimesheet Where TimesheetID = " + intTimesheetID;
                drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, true, CommonController.connectionString);

                if (CommonFunctions.General.CheckIsNothing(drTimesheet) != "")
                {

                    if (drTimesheet.Read())
                    {
                        strFromDate = drTimesheet["FromDate"].ToString() + "";
                        strToDate = drTimesheet["ToDate"].ToString() + "";
                        strSubmitter = drTimesheet["EmployeeID"].ToString() + "";
                    }
                }
                CommonFunctions.Data.DisposeDataReader(ref drTimesheet);


                strSQLQuery = "Select EmailID,EmployeeName,ReportingTo from tbl_PM_Employee with (NoLock) Where ISNULL(Status,0) = 0 AND EmployeeID = " + strSubmitter;

                drSenderInfo = CommonFunctions.Data.GetDataReader(strSQLQuery, true, CommonController.connectionString);

                if (CommonFunctions.General.CheckIsNothing(drSenderInfo) != "")
                {
                    if (drSenderInfo.Read())
                    {
                        strFromEmailID = drSenderInfo["EmailID"].ToString() + "";
                        strSenderName = drSenderInfo["EmployeeName"].ToString() + "";
                        strReportingTo = drSenderInfo["ReportingTo"].ToString() + "";
                    }
                }
                CommonFunctions.Data.DisposeDataReader(ref drSenderInfo);
            }

            strEmailSubject.Replace("<SENDER_NAME>", strSenderName);
            strEmailSubject.Replace("<FROMDATE>", CommonFunctions.Dates.CGetDate(Convert.ToDateTime(strFromDate)));
            strEmailSubject.Replace("<TODATE>", CommonFunctions.Dates.CGetDate(Convert.ToDateTime(strToDate)));

            if (strRecieverName != "")
            {

                strMessage.Replace("<NAME>", strRecieverName);
            }

            if (strSenderName != "")
            {

                strMessage.Replace("<SENDER_NAME>", strSenderName);
            }

            if (strFromDate != "")
            {

                strMessage.Replace("<FROMDATE>", CommonFunctions.Dates.CGetDate(Convert.ToDateTime(strFromDate)));

            }

            if (strToDate != "")
            {

                strMessage.Replace("<TODATE>", CommonFunctions.Dates.CGetDate(Convert.ToDateTime(strToDate)));
            }

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;

        }
        public static void GetEmailMessage_20047(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intETCRequestID,int intProjectID)
        {
            string strUserName = "", strProjectName = "";
            IDataReader drETCRequest;
            int ProjectID = 0, EmployeeID = 0;
            float dblETCHours = 0;
            string strTaskName = "", strReason = "";
            int intMessageID;
            int UserID = 0;

            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strFromEmailID = "";
            strToEmailID = "";
            strCCToEmailID = "";
            intMessageID = 20047;

            //Retrieve the ETC Request details.
            //Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
            //drETCRequest = CommonFunctions.Data.GetDataReader("usp_Whizible2_sel_tbl_TasksToAutheticate Null, NULL, " + intETCRequestID.ToString(), true, CommonController.connectionString);
            drETCRequest = CommonFunctions.Data.GetDataReader("usp_Whizible2_sel_tbl_TasksToAutheticate " + intProjectID.ToString() + ", NULL, " + intETCRequestID.ToString(), true, CommonController.connectionString);
            //End of Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
            // If there exists an ETC Request, then...
            if (drETCRequest.Read())
            {
                ProjectID = Convert.ToInt32(drETCRequest["ProjectID"]);
                EmployeeID = Convert.ToInt32(drETCRequest["EmployeeID"]);
                dblETCHours = Convert.ToSingle(drETCRequest["ETC"]);
                strFromEmailID = Convert.ToString(drETCRequest["EmailID"]);
                strTaskName = Convert.ToString(drETCRequest["TaskName"]);
                strReason = Convert.ToString(drETCRequest["Reason"]);
                UserID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drETCRequest["ApproverID"], "0"));
            }

            CommonFunctions.Data.DisposeDataReader(ref drETCRequest);

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //Retrieve information about the Project.
            GetProjectInfo(ref strProjectName, ref strCCToEmailID, ProjectID, intMessageID, EmployeeID.ToString());
            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            //Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(EmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);

            //Retrieve information about the Receiver.
            GetEmployeeInfo(UserID, ref strUserName, ref strToEmailID);
            strMessage.Replace("<NAME>", strUserName);

            strMessage.Replace("<HOURS>", Convert.ToString(dblETCHours));
            strMessage.Replace("<TASK_NAME>", strTaskName);
            strMessage.Replace("<REASON>", strReason);

            //4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            //5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;
        }
        public static void GetEmailMessage_8(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intIssueID, int IssueProjectID, int intEmployeeID)
        {
            string strUserName = "";
            string strProjectName = "";
            IDataReader drReceiver;
            IDataReader drIssue;
            string strListOfReceivers = "";
            int intMessageID = 8;

            //added by dipali v on 31st march 2021 for if login type C then Tomail ID
            string LoginType = "";
            string strProjectIssueType = "";
            string strProjectIssueStatus = "";
            bool blnShowToCustomer = false;
            string strMailToEmployeeIDList = "";
            string strMailCCToEmployeeIDList = "";
            IDataReader drEmployee;
            //  int IssueProjectID = 1121;
            int intProjectID = 0;
            //   int intEmployeeID = 61;
            string strReportedBy = "";
            string strReportedByPersonEmail = "";
            IDataReader objDr;
            string intResponsible = "";
            string strResponsiblePersonEmail = "";


            //1. Code for String Builder Changes - IssueID - 6052 

            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            // Get the message body, and subject.



            // 'Purpose:If mail is getting fired fro place other than issue base then consider project in session
            if (IssueProjectID != 0)
            {
                strEmailMessage = funcGetEmailMessageForProject(IssueProjectID, intMessageID, ref strSubject);
            }
            else
            {
                strEmailMessage = funcGetEmailMessageForProject(intProjectID, intMessageID, ref strSubject);
            }



            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //' Retrieve information about the Project.

            //  'Call GetProjectInfo(CType(HttpContext.Current.Session("intProjectID"), Long), strProjectName, intMessageID, strCCToEmailID)


            //  'Purpose:If mail is getting fired fro place other than issue base then consider project in session
            if (IssueProjectID != 0)
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, IssueProjectID, intMessageID, intEmployeeID.ToString());
            }
            else
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, IssueProjectID, intMessageID, intEmployeeID.ToString());
            }


            //      'strEmailMessage = Replace(strEmailMessage, "<PROJECT_NAME>", strProjectName)
            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            // 'strSubject = Replace(strSubject, "<PROJECT_NAME>", strProjectName)
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);


            // ' Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());


            //  'strEmailMessage = Replace(strEmailMessage, "<SENDER_NAME>", strUserName)
            strMessage.Replace("<SENDER_NAME>", strUserName);
            if (strListOfReceivers.Trim() == "")
            {
                strListOfReceivers = "All";
            }



            //    'strEmailMessage = Replace(strEmailMessage, "<NAME>", strListOfReceivers)
            strMessage.Replace("<NAME>", strListOfReceivers);

            //   ' If the Issue ID is not specified, then exit the subroutine.
            if (intIssueID == 0)
            {
                return;
            }

            //' Retrieve the Issue details.
            //Added & Commented By dipali v On 16th Sep 2019 for New SP
            // drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " + intIssueID.ToString(), true, CommonController.connectionString);
            drIssue = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_Sel_tbl_IB_IssueEmailDetails " + intIssueID.ToString(), true, CommonController.connectionString);
            //End of Added & Commented By dipali v On 16th Sep 2019 for New SP
            //  ' If the Issue exists, then...
            if (drIssue.Read())
            {


                strMessage.Replace("<ISSUE_TYPE>", drIssue["Type"].ToString().Trim());
                strMessage.Replace("<ISSUE_ID>", intIssueID.ToString());
                strMessage.Replace("<SUMMARY>", drIssue["Summary"].ToString().Trim());
                strEmailSubject.Replace("<SUMMARY>", drIssue["Summary"].ToString().Trim());
                strMessage.Replace("<DESCRIPTION>", drIssue["Description"].ToString().Trim());
                strProjectIssueType = drIssue["Type"].ToString().Trim();
                strProjectIssueStatus = drIssue["Status"].ToString().Trim();
                blnShowToCustomer = Convert.ToBoolean(drIssue["ShowToCustomer"]);

                //added by dipali v on 31st march 2021 for if login type C then Tomail ID
                LoginType = drIssue["LoginType"].ToString().Trim();
                //End  of added by dipali v on 31st march 2021 for if login type C then Tomail ID
                strReportedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["ReportedBy"], ""));
                strReportedBy = strReportedBy.Trim();
                intResponsible = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["AssignTO"].ToString(), ""));


            }
            CommonFunctions.Data.DisposeDataReader(ref drIssue);

            // ' Get the list of users to whom the mail must be sent.

            if (IssueProjectID != 0)
            {
                //Added & Commented By Dipali V On 16th Sep 2019 For New SP
                drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                //drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                //End of Added & Commented By Dipali V On 16th Sep 2019 For New SP
            }
            else
            { //Added & Commented By Dipali V On 16th Sep 2019 For New SP
                drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                //drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                //End of Added & Commented By Dipali V On 16th Sep 2019 For New SP
            }

            if (drIssue.Read())
            {
                strMailToEmployeeIDList = drIssue["MailToEmployeeIDList"].ToString();
                strMailCCToEmployeeIDList = drIssue["MailCCToEmployeeIDList"].ToString();
            }
            CommonFunctions.Data.DisposeDataReader(ref drIssue);

            if (IssueProjectID != 0)
            {
                //Added & Commented By dipali V On 16th Sep 2019 For NEW SP
                //drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);
                drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);
                //End of Added & Commented By dipali V On 16th Sep 2019 For NEW SP
            }
            else
            {
                //Added & Commented By dipali V On 16th Sep 2019 For NEW SP
                //drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);
                drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + intProjectID, true, CommonController.connectionString);
                //End of Added & Commented By dipali V On 16th Sep 2019 For NEW SP
            }
            while (drEmployee.Read())
            {
                if (drEmployee["EmailID"].ToString().Trim() != "")
                {
                    if (blnShowToCustomer == true || (blnShowToCustomer == false && (drEmployee["ResourceType"].ToString() == "E" || drEmployee["ResourceType"].ToString() == "CE")))
                    {
                        //Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                        //if (strMailToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                        if (Strings.InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                            {
                            //if (strToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                            if (Strings.InStr(strToEmailID, drEmployee["EmailID"].ToString()) == 0)
                            //End of Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                            {
                                //Added By Dipali V For Getting duplicated TO Mail ID

                                if (strToEmailID != "")
                                {
                                    //Commented And Added By Dipali Vekhande on 27 Sep 2021 To EmailID shold not Override
                                    //strToEmailID = drEmployee["EmailID"].ToString().Trim();
                                    //commented And Added By Reshma Chavan on 1st Nov 2021 Getting Double Semi Colon
                                    //strToEmailID = strToEmailID + ";" + drEmployee["EmailID"].ToString().Trim() + "; ";
                                    strToEmailID = strToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                    //End of commented And Added By Reshma Chavan on 1st Nov 2021 Getting Double Semi Colon
                                }
                                else
                                {
                                    //Commented And Added By Dipali Vekhande on 27 Sep 2021 To EmailID shold not Override
                                    //strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + "; ";
                                    strToEmailID = drEmployee["EmailID"].ToString().Trim();
                                }
                               
                                //End of Added By Dipali V For Getting duplicated TO Mail ID


                            }
                        }
                            //Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                            //if (strMailCCToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                            if (Strings.InStr(strMailCCToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                           
                            {
                           // if (strCCToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                            if (Strings.InStr(strCCToEmailID, drEmployee["EmailID"].ToString().Trim()) == 0)
                                {
                                //Added By Dipali V For Getting duplicated TO Mail ID
                                //Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                                //if (strCCToEmailID != "")
                                //{
                                //    strCCToEmailID = drEmployee["EmailID"].ToString().Trim();
                                //}
                                //else
                                //{
                                //    strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();

                                //}

                                //End of Added By Dipali V For Getting duplicated TO Mail ID
                                //Commented & Added By Rutuja D. on 25 Oct 2021 For Remove Space into CC Mail Issue
                                //strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();
                                strCCToEmailID = strCCToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                //End of Commented & Added By Rutuja D. on 25 Oct 2021 For Remove Space into CC Mail Issue
                                //End of Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                            }
                        }
                    }
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drEmployee);

            if (intResponsible.ToString() != "")
            {
                //Added & Commented By Dipali V On 16th Sep 2019 For SQL Injection
                // strResponsiblePersonEmail = CType(CommonFunctions.Data.GetDataScalar("SELECT ISNULL(EmailID,'') FROM tbl_PM_Employee WHERE EmployeeID = " + intResponsible.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
                strResponsiblePersonEmail = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_IB_tbl_PM_EmployeeEmails " + intResponsible.ToString(), true, CommonController.connectionString));
                //End of Added & Commented By Dipali V On 16th Sep 2019 For SQL Injection

            }

            if ((strCCToEmailID.IndexOf(strResponsiblePersonEmail) == 0) && (strToEmailID.IndexOf(strResponsiblePersonEmail) == 0))
            {
                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
            }

            if (strReportedBy != "")
            {

                if (IssueProjectID != 0)
                {
                    //Added & Commented By Dipali V On 16th Sep 2019 For New SP
                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + IssueProjectID, true, CommonController.connectionString);
                    // objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + IssueProjectID, true, CommonController.connectionString);
                    //End of Added & Commented By Dipali V On 16th Sep 2019 For New SP
                }
                else
                {    //Added & Commented By Dipali V On 16th Sep 2019 For New SP
                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "', " + IssueProjectID, true, CommonController.connectionString);
                    // objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //End of Added & Commented By Dipali V On 16th Sep 2019 For New SP
                }
                if (objDr.Read())
                {
                    strReportedByPersonEmail = objDr["EmailID"].ToString();
                }
                CommonFunctions.Data.DisposeDataReader(ref objDr);
            }



            if ((strCCToEmailID.IndexOf(strReportedByPersonEmail) == 0) && (strToEmailID.IndexOf(strReportedByPersonEmail) == 0))
            {
                if (strCCToEmailID != "")
                {
                    strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail;
                }
                else
                {
                    strCCToEmailID = strReportedByPersonEmail;
                }

                if (strToEmailID == "")
                {
                    //strToEmailID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_IssueResponsiblePerson_forDTmail " + IssueProjectID, true, CommonController.connectionString), ""), "");
                    strToEmailID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_IssueResponsiblePerson_forDTmail " + IssueProjectID, true, CommonController.connectionString), ""), "");

                }

                if (strToEmailID == "")
                {
                    strToEmailID = strFromEmailID;
                }


            }
            //Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
            if ((strCCToEmailID.IndexOf(strResponsiblePersonEmail) == 0) && (strToEmailID.IndexOf(strResponsiblePersonEmail) == 0))
            {
                //End Of Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
                if (strToEmailID != "")
                {
                    ////////////////////////////////////////////
                    if (strToEmailID.EndsWith(";"))
                    {
                        strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                    }
                    //////////////////////////////////////
                    strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
            }
            else
            {
                //Added By Dipali V For Getting duplicated TO Mail ID
                if (strToEmailID != "")
                {
                    //if (strToEmailID != strResponsiblePersonEmail) {
                    if (strToEmailID.Contains(strResponsiblePersonEmail))
                    {
                        // strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail;
                    }
                    else
                    {
                        strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                    }

                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
                //Added By Dipali V For Getting duplicated TO Mail ID
            }

            //added by dipali v on 31st march 2021 for if login type C then Tomail ID
            if (LoginType == "C")
            {
                if (strReportedByPersonEmail != "")
                {
                    if (strToEmailID != "")
                    {
                        if (strToEmailID.EndsWith(";"))
                        {
                            strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                        }
                        strToEmailID = strToEmailID + ";" + strReportedByPersonEmail;
                    }
                    else
                    {
                        strToEmailID = strReportedByPersonEmail;
                    }
                }
                else
                {
                    strToEmailID = strToEmailID;
                }
                //End of added by dipali v on 31st march 2021 for if login type C then Tomail ID

            }

            //4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            //5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;
        }

        //start vishal mahajan 04-12-2019 for 34 ISSUE STATUS CHANGED
        public static void GetEmailMessage_34(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intIssueID, int IssueProjectID, int intEmployeeID, string strFrom = "")
        {
            int intMessageID = 34;
            string strUserName = "", strProjectName = "", strLoginType = "";
            int intProjectID;
            IDataReader drIssue;
            string strIssueSummary = "";
            string strIssueStatus = "";
            string strProjectIssueType = "";
            string strMailToEmployeeIDList = "";
            string strMailCCToEmployeeIDList = "";
            IDataReader drEmployee;
            bool blnShowToCustomer = false;
            string strResponsiblePerson = "";
            string strReportedBy = "";
            // Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006

            // Added by SavitaS on 01 June 2006
            bool blnShowDTToCustomer = false;
            int intIndex = 0;
            int intCust = 1;
            // End Integration
            string LoginType = "";
            // Added by PadmanabhA for whiziblesem version 6 Issue base Email Configuration Issue ID.2338
            string strResponsiblePersonEmail = "";
            string strReportedByPersonEmail = "";
            int intReportedBy = 0;
            // End Addition

            // 1. Code for String Builder Changes - IssueID - 6052 

            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            // If the Issue ID is not specified, then exit the subroutine.
            if (intIssueID == 0)
                return;

            // Get the details of the Issue.
            drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_Issue " + intIssueID + "," + intEmployeeID + "", true, CommonController.connectionString);
            if (drIssue.Read())
            {
                strIssueSummary = drIssue["Summary"].ToString().Trim();
                intProjectID = System.Convert.ToInt32(drIssue["ProjectID"]);
                strProjectIssueType = drIssue["Type"].ToString().Trim();
                strIssueStatus = drIssue["Status"].ToString().Trim();
                LoginType= drIssue["LoginType"].ToString().Trim();  
                blnShowToCustomer = System.Convert.ToBoolean(drIssue["ShowToCustomer"]);
                // Added by PadmanabhA for whiziblesem version 6 Issue base Email Configuration Issue ID.2338
                // code modified by harshada d for whiziblesem 6 for resolving the crash issue on 27 th april 2006
                // strResponsiblePerson = CType(drIssue["AssignTo"), String)
                strResponsiblePerson = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["AssignTo"], "")).Trim();
                // strReportedBy = CType(drIssue["ReportedBy"), String).Trim
                strReportedBy = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["ReportedBy"], "")).Trim();
            }

            CommonFunctions.Data.DisposeDataReader(ref drIssue);
            // Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006

            // Added by SavitaS on 01 June 2006  for FourSoft IssueID 2002
            // get the details of discussion thread
            string strSQL = "";
            IDataReader objDr;
            // Code integrated by SavitaS on 23 Aug 2006 for SP7 integration
            // Code Added By PradipK on 8-June-2006
            // Purpose:To Check ShowToCustomer condition from Discussion Thread(DT) table if Mail is from DT.
            if (strFrom == "DT")
            {
                // End Addition By PradipK on 8-June-2006
                // End of Code integrated by SavitaS on 23 Aug 2006 for SP7 integration
                strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Discussion " + intIssueID.ToString();
                objDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                while (objDr.Read())
                {
                    if (!(string.IsNullOrEmpty(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["UserName"], "")))))
                    {
                        // Added by VidyaJ on 2nd June 2005
                        if (intIndex == 0)
                            // blnShowDTToCustomer = CType(objDr("ShowToCustomer"), Boolean)
                            blnShowDTToCustomer = System.Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDr["ShowToCustomer"], "0"));
                        intIndex = intIndex + 1;
                    }
                }
                CommonFunctions.Data.DisposeDataReader(ref objDr);
            }
            // End Addition By PradipK on 8-June-2006
            // End of Code integrated by SavitaS on 23 Aug 2006 for SP7 integration

            // End Addition by SavitaS on 01 June 2006  for FourSoft IssueID 2002

            // Added by PadmanabhA for whiziblesem version 6 Issue base Email Configuration Issue ID.2338
            // User Id is taken usng reportedBy value
            drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + System.Convert.ToString(IssueProjectID), true, CommonController.connectionString);
            if (drIssue.Read())
                strReportedByPersonEmail = drIssue["EmailID"].ToString();
            CommonFunctions.Data.DisposeDataReader(ref drIssue);
            // code modified by harshada d for whiziblesem 6 for resolving the crash issue on 27 th april 2006
            if (strResponsiblePerson != "")
                // end of code modification by harshada d for whiziblesem 6 for resolving the crash issue on 27 th april 2006
                strResponsiblePersonEmail = System.Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT ISNULL(EmailID,'') FROM tbl_PM_Employee WHERE EmployeeID = " + strResponsiblePerson, true, CommonController.connectionString));
            else
                strResponsiblePersonEmail = "";
            // end of code modification by harshada d for whiziblesem 6 for resolving the crash issue on 27 th april 2006

            // End Addition
            // If the Project ID not found, exit the subroutine.
            // NOTE: This case can come if the Issue was not found in the table.
            if (IssueProjectID == 0)
                return;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(IssueProjectID, intMessageID, ref strSubject);

            // 2. Code for String Builder Changes - IssueID - 6052 

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            // Retrieve information about the Sender.            
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER_NAME>", strUserName);

            // Retrieve information about the Project.
            GetProjectInfo(ref strProjectName, ref strCCToEmailID, IssueProjectID, intMessageID, intEmployeeID.ToString());
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);

            // Insert the Issue ID.
            strMessage.Replace("<ISSUE_ID>", intIssueID.ToString());
            strEmailSubject.Replace("<ISSUE_ID>", intIssueID.ToString());

            // Insert the Issue Summary.
            strMessage.Replace("<ISSUE_SUMMARY>", strIssueSummary);

            // Insert the Issue Status.
            strMessage.Replace("<ISSUE_STATUS>", strIssueStatus);

            // Insert the Date.
            strMessage.Replace("<DATE>", CommonFunctions.Dates.CGetDateTime(DateTime.Now));

            // Get the list of users to whom the mail must be sent.		
            drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID.ToString() + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strIssueStatus) + "'", true, CommonController.connectionString);
            if (drIssue.Read())
            {
                strMailToEmployeeIDList = drIssue["MailToEmployeeIDList"].ToString().Trim();
                strMailCCToEmployeeIDList = drIssue["MailCCToEmployeeIDList"].ToString().Trim();
            }
            CommonFunctions.Data.DisposeDataReader(ref drIssue);
            // strMailToEmployeeIDList = strMailToEmployeeIDList.Substring(0, strMailToEmployeeIDList.Length - 1)

            // Get the employee email ids.
            drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID.ToString(), true, CommonController.connectionString);
            while (drEmployee.Read())
            {
                if (drEmployee["EmailID"].ToString().Trim() != "")
                {
                    // Modified By			: Santosh Pawar on 05 Aug 2004
                    // If blnShowToCustomer = True Or (blnShowToCustomer = False And (drEmployee["ResourceType").ToString().Trim() = "E" Or drEmployee["ResourceType").ToString().Trim() = "CE")) Then
                    if (blnShowToCustomer == true | (blnShowToCustomer == false & (drEmployee["ResourceType"].ToString().Trim() == "E" | drEmployee["ResourceType"].ToString().Trim() == "CE" | drEmployee["ResourceType"].ToString().Trim() == "OT" | drEmployee["ResourceType"].ToString().Trim() == "CC")))
                    {
                        // Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006

                        // Added by SavitaS on 01 June 2006  for FourSoft IssueID 2002
                        if ((blnShowDTToCustomer == false & drEmployee["ResourceType"].ToString().Trim() == "C"))
                        {
                            // TRUPTI()
                            if (blnShowToCustomer != false & strFrom != "DT")
                            {
                                // TRUPTI
                                // If InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID").ToString().Trim() & ",") <> 0 Then
                                if (Strings.InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                                {
                                    if (Strings.InStr(strToEmailID, drEmployee["EmailID"].ToString()) == 0)
                                        //Added & Commented By Dipali V On 24th Nov 2021 For Remove Extra Space
                                        //strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + "; ";
                                        strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + ";"; 
                                    //End of Added & Commented By Dipali V On 24th Nov 2021 For Remove Extra Space


                                }
                                if (Strings.InStr(strMailCCToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                                {
                                    if (Strings.InStr(strCCToEmailID, drEmployee["EmailID"].ToString().Trim()) == 0)
                                        //Commented & Added By Dipali V On 24th Nov 2021 For Removed Extra Space
                                        // strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();
                                        strCCToEmailID = strCCToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                       //End of Commented & Added By Dipali V On 24th Nov 2021 For Removed Extra Space
                                }
                            }
                        }
                        else if ((drEmployee["ResourceType"].ToString().Trim() == "C"))
                        {
                            if (Strings.InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                            {
                                if (Strings.InStr(strToEmailID, drEmployee["EmailID"].ToString()) == 0)
                                    intCust = 1;
                            }
                            if (Strings.InStr(strMailCCToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                            {
                                if (Strings.InStr(strCCToEmailID, drEmployee["EmailID"].ToString().Trim()) == 0)
                                    intCust = 0;
                            }
                        }

                        else if ((drEmployee["ResourceType"].ToString().Trim() == "CC" | drEmployee["ResourceType"].ToString().Trim() == "CE"))
                        {
                            // If strFrom = "DT" Then
                            if ((strFrom == "DT" & blnShowDTToCustomer == false))
                            {
                            }
                            else if (blnShowToCustomer != false)
                            {
                                // TRUPTI
                                // If InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID").ToString().Trim() & ",") <> 0 Then
                                if (Strings.InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                                {
                                    if (Strings.InStr(strToEmailID, drEmployee["EmailID"].ToString()) == 0)
                                        //Added & Commented By Dipali V On 24th Nov 2021 For Remove Extra Space
                                        //strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + "; ";
                                        strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + ";";
                                    //End of Added & Commented By Dipali V On 24th Nov 2021 For Remove Extra Space
                                }
                                if (Strings.InStr(strMailCCToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                                {
                                    if (Strings.InStr(strCCToEmailID, drEmployee["EmailID"].ToString().Trim()) == 0)
                                        //Commented & Added By Dipali V On 24th Nov 2021 For Removed Extra Space
                                        // strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();
                                        strCCToEmailID = strCCToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                        //End of Commented & Added By Dipali V On 24th Nov 2021 For Removed Extra Space
                                }
                            }
                        }
                        else
                        {
                            // End Addition by SavitaS
                            // End Integration
                            // Modification Complete 
                            if (Strings.InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                            {
                                if (Strings.InStr(strToEmailID, drEmployee["EmailID"].ToString()) == 0)
                                    //Added & Commented By Dipali V On 24th Nov 2021 For Remove Extra Space
                                    // strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + "; ";
                                    strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + ";";
                                //End of Added & Commented By Dipali V On 24th Nov 2021 For Remove Extra Space
                            }
                            if (Strings.InStr(strMailCCToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                            {
                                if (Strings.InStr(strCCToEmailID, drEmployee["EmailID"].ToString().Trim()) == 0)
                                    //Commented & Added By Dipali V On 24th Nov 2021 For Removed Extra Space
                                    //strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();
                                    strCCToEmailID = strCCToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                //End of Commented & Added By Dipali V On 24th Nov 2021 For Removed Extra Space
                            }
                        }
                    }
                }
            }


            CommonFunctions.Data.DisposeDataReader(ref drEmployee);
            // Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006

            // Commented and Modified by SavitaS on 01 June 2006  for FourSoft IssueID 2002

            // 'Added by PadmanabhA for whiziblesem version 6 Issue base Email Configuration Issue ID.2338
            // If (Strings.InStr(strCCToEmailID, strReportedByPersonEmail) = 0) And (Strings.InStr(strToEmailID, strReportedByPersonEmail) = 0) Then
            // strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail
            // End If

            // If (Strings.InStr(strCCToEmailID, strResponsiblePersonEmail) = 0) And (Strings.InStr(strToEmailID, strResponsiblePersonEmail) = 0) Then
            // strCCToEmailID = strCCToEmailID + ";" + strResponsiblePersonEmail
            // End If

            IDataReader dr;
            string strCustEmail = "";
            int ReportedBy;
            string strCust = "";
            strCust = "Select tbl_pm_project.CustomerID,tbl_pm_customer.EmailID  from tbl_pm_project,tbl_pm_customer where tbl_pm_project.CustomerID=tbl_pm_customer.Customer and  tbl_pm_project.projectid=" + IssueProjectID.ToString();

            dr = CommonFunctions.Data.GetDataReader(strCust, true, CommonController.connectionString);
            if (dr.Read())
                strCustEmail = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["EmailID"], ""));
            CommonFunctions.Data.DisposeDataReader(ref dr);

            strSQL = "Select CustomerID from tbl_PM_Customer where CustomerID in ('" + strReportedBy + "')";
            dr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (dr.Read())
                ReportedBy = 1;
            else
                ReportedBy = 0;

            if ((ReportedBy == 1 & blnShowDTToCustomer == false))
            {
                if ((Strings.InStr(strCCToEmailID, strResponsiblePersonEmail) == 0) & (Strings.InStr(strToEmailID, strResponsiblePersonEmail) == 0))
                {
                    // Commented and Modified by SavitaS on 22 Aug 2006 for SP7 Integration
                    // strCCToEmailID = strCCToEmailID + ";" + strResponsiblePersonEmail
                    if (strToEmailID != "")
                    {
                        ////////////////////////////////////////////
                        if (strToEmailID.EndsWith(";"))
                        {
                            strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                        }
                        //////////////////////////////////////
                        strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                    }
                    else
                    {
                        strToEmailID = strResponsiblePersonEmail;
                    }
                }
            }
            else
                // Added by PadmanabhA for whiziblesem version 6 Issue base Email Configuration Issue ID.2338
                if ((Strings.InStr(strCCToEmailID, strReportedByPersonEmail) == 0) & (Strings.InStr(strToEmailID, strReportedByPersonEmail) == 0))
            {
                if (intCust == 1)
                {
                    if (strToEmailID != "")
                    {
                        ////////////////////////////////////////////
                        if (strToEmailID.EndsWith(";"))
                        {
                            strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                        }
                        //////////////////////////////////////
                        strToEmailID = strToEmailID + ";" + strReportedByPersonEmail;
                    }
                    else
                    {
                        strToEmailID = strReportedByPersonEmail;
                    }
                }
                else if (strCCToEmailID != "")
                    strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail;
                else
                    strCCToEmailID = strReportedByPersonEmail;
            }
            // End addition

            // Added by SavitaS on 21 aug 2006 for Whiziblesem SP7 Integration
            if ((Strings.InStr(strCCToEmailID, strResponsiblePersonEmail) == 0) & (Strings.InStr(strToEmailID, strResponsiblePersonEmail) == 0))
            {
                // Commented and Modified by SavitaS on 22 Aug 2006 for SP7 Integration
                // strCCToEmailID = strCCToEmailID + ";" + strResponsiblePersonEmail
                if (strToEmailID != "")
                {
                    ////////////////////////////////////////////
                    if (strToEmailID.EndsWith(";"))
                    {
                        strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                    }
                    //////////////////////////////////////
                    strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
            }
            // End of Added by SavitaS on 21 aug 2006 for Whiziblesem SP7 Integration

            // End Modification on 01 June 2006  for FourSoft IssueID 2002
            if ((blnShowToCustomer == true))
            {
                if ((blnShowDTToCustomer == true))
                {
                    if (System.Convert.ToString(strLoginType) != "C")
                    {
                        // If ReportedBy <> 1 Then
                        if (intCust == 1)
                        {
                            if (strToEmailID != "")
                            {
                                if ((Strings.InStr(strToEmailID, strCustEmail) == 0) & (Strings.InStr(strCCToEmailID, strCustEmail) == 0))
                                    strToEmailID = strToEmailID + ";" + strCustEmail;
                            }
                            else
                                strToEmailID = strCustEmail;
                        }
                        else if (strCCToEmailID != "")
                        {
                            if ((Strings.InStr(strToEmailID, strCustEmail) == 0) & (Strings.InStr(strCCToEmailID, strCustEmail) == 0))
                                strCCToEmailID = strCCToEmailID + ";" + strCustEmail;
                        }
                        else
                            strCCToEmailID = strCustEmail;
                    }
                }
            }

            //Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
            if ((strCCToEmailID.IndexOf(strResponsiblePersonEmail) == 0) && (strToEmailID.IndexOf(strResponsiblePersonEmail) == 0))
            {
                //End Of Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
            }
            //Added By Dipali V On 29th Nov 2021 For If Responsible & Reported By Same then To should not be blank
            else {
                if (strToEmailID != "")
                {
                    if (strToEmailID.Contains(strResponsiblePersonEmail))
                    {
                        // strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail;
                    }
                    else
                    {
                        // strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                        strToEmailID = strToEmailID + " " + strResponsiblePersonEmail;
                    }

                } 
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }

            }

            //End ofAdded By Dipali V On 29th Nov 2021 For If Responsible & Reported By Same then To should not be blank

            // End addition on 01 June 2006  for FourSoft IssueID 2002
            // End Integration

            //added by dipali v on 31st march 2021 for get To mail id if customer login
            if (LoginType == "C")
            {
                if (strReportedByPersonEmail != "")
                {
                    if (strToEmailID != "")
                    {
                    	if (strToEmailID.EndsWith(";"))
                        {
                            strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                        }
                        strToEmailID = strToEmailID + ";" + strReportedByPersonEmail;
                    }
                    else
                    {
                        strToEmailID = strReportedByPersonEmail;
                    }
                }
                else
                {
                    strToEmailID = strToEmailID;
                }
            }
            //End of added by dipali v on 31st march 2021 for get To mail id if customer login


            // 4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;
        }

        private static void GetSenderInfo(ref string strLoginType, ref string strUserName, ref string strEmailID, string UserID)
        {
            long lngUserid;
            IDataReader objDr;
            string strSQL;
            strSQL = "SELECT LoginType FROM TBL_PM_lOGIN WHERE EmployeeID=" + UserID;
            objDr = Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
            {
                strLoginType = Convert.ToString(objDr["LoginType"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            // strLoginType = "C";
            lngUserid = System.Convert.ToInt64(UserID);

            if (strLoginType == "C")
                GetCustomerInfo(lngUserid, ref strUserName, ref strEmailID);
            else if (strLoginType == "E")
                GetEmployeeInfo(lngUserid, ref strUserName, ref strEmailID);
            if (strEmailID == "")
                strEmailID = funcGetCompanyMailID();
        }

        //end vishal mahajan 04-12-2019 for 34 ISSUE STATUS CHANGED

        //start vishal mahajan 07-12-2019 for get message body for project review
        public static string GetEmailMessageForProject(long lngProjectID, long lngMsgID)
        {
            string strSubject = "";
            return funcGetEmailMessageForProject(lngProjectID, lngMsgID, ref strSubject);
        }

        public static string GetProjectName(long lngProjectID)
        {
            IDataReader objDr;
            string strProjectName = "";
            string strSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " + lngProjectID.ToString();
            objDr = Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
            {
                strProjectName = Convert.ToString(objDr["ProjectName"]);
            }
            return strProjectName;
        }
        //end vishal mahajan 07-12-2019 for get message body for project review

        private static string funcGetEmailMessageForProject(long lngProjectID, long lngMsgID, ref string strSubject)
        {
            string strSQL;
            IDataReader objDr;
            bool blnUseSQL;
            string strBody;

            strBody = "";
            blnUseSQL = System.Convert.ToBoolean(true);

            strSQL = "usp_Sel_tbl_PM_EmailMessages " + lngMsgID.ToString();
            if (lngProjectID > 0)
                strSQL += "," + lngProjectID.ToString();

            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, CommonController.connectionString);
            if (objDr.Read())
            {
                strBody = objDr["Body"].ToString() + "";
                strSubject = objDr["subject"].ToString() + "";
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            return strBody;
        }

        private static void GetProjectInfo(ref string strProjectName, ref string strCCToEmailID, int ProjectID, int intMessageID, string lngUserID)
        {
            string strEmployeeList = "";
            string[] strTempArray;
            int intCtr;
            string strEmailID = "";
            IDataReader objDr;
            string strSQL;
            bool blnUseSQL;
            string strLoginType;

            int intIndex;
            string strUserName = "";

            if (strCCToEmailID == null)
            {
                strCCToEmailID = "";
            }
            strSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " + ProjectID.ToString();
            objDr = Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
            {
                strProjectName = Convert.ToString(objDr["ProjectName"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            //get the CC email ID list
            strSQL = "usp_Sel_tbl_PM_ProjectEmails " + ProjectID.ToString() + ", " + intMessageID.ToString();
            objDr = Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
            {
                strEmployeeList = Convert.ToString(objDr["CCToUsersList"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            if (strEmployeeList != "")
            {
                strTempArray = strEmployeeList.Split(',');
                for (intCtr = 0; intCtr <= strTempArray.Length - 1; intCtr++)
                {
                    if (strTempArray[intCtr].Trim() != "")
                    {
                        GetEmployeeInfo(Convert.ToInt32(strTempArray[intCtr]), ref strUserName, ref strEmailID);
                        if (strEmailID != "")
                        {
                            intIndex = strCCToEmailID.IndexOf(strEmailID);
                            if (intIndex < 0)
                            {
                                strCCToEmailID += strEmailID + ",";
                            }
                        }
                        strEmailID = "";
                    }
                }
            }

            //if (strMailToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",")
            if (strEmployeeList.IndexOf("," + lngUserID.ToString() + ",") != 0)
            {
                //Call GetSenderInfo("", strEmailID)
                GetSenderInfo(ref strUserName, ref strEmailID, lngUserID);
                intIndex = strCCToEmailID.IndexOf(strEmailID);
                if (intIndex < 0)
                {
                    strCCToEmailID += strEmailID;
                }
            }
            // return strCCToEmailID;
        }
        private static void GetSenderInfo(ref string strUserName, ref string strEmailID, string UserID)
        {
            string strLoginType = "";
            long lngUserid;
            IDataReader objDr;
            string strSQL;
            strSQL = "SELECT LoginType FROM TBL_PM_lOGIN WHERE EmployeeID=" + UserID;
            objDr = Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
            {
                strLoginType = Convert.ToString(objDr["LoginType"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            // strLoginType = "C";
            lngUserid = System.Convert.ToInt64(UserID);

            if (strLoginType == "C")
                GetCustomerInfo(lngUserid, ref strUserName, ref strEmailID);
            else if (strLoginType == "E")
                GetEmployeeInfo(lngUserid, ref strUserName, ref strEmailID);
            if (strEmailID == "")
                strEmailID = funcGetCompanyMailID();
        }
        public static void GetSenderInfo(ref string strEmailID, string UserID)
        {
            string strUserName = "";
            string strLoginType = "";
            long lngUserid;
            IDataReader objDr;
            string strSQL;
            strSQL = "SELECT LoginType FROM TBL_PM_lOGIN WHERE EmployeeID=" + UserID;
            objDr = Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
            {
                strLoginType = Convert.ToString(objDr["LoginType"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            // strLoginType = "C";
            lngUserid = System.Convert.ToInt64(UserID);

            if (strLoginType == "C")
                GetCustomerInfo(lngUserid, ref strUserName, ref strEmailID);
            else if (strLoginType == "E")
                GetEmployeeInfo(lngUserid, ref strUserName, ref strEmailID);
            if (strEmailID == "")
                strEmailID = funcGetCompanyMailID();
        }
        private static void GetCustomerInfo(long lngCustomerID, ref string strCustomerName, ref string strEmailid)
        {
            string strSQL;
            IDataReader objDr;
            string strLoginType;
            bool blnUseSQL;

            blnUseSQL = System.Convert.ToBoolean(true);
            strSQL = "usp_Sel_tbl_PM_Customer " + lngCustomerID.ToString() + ",NULL,'C'";
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, CommonController.connectionString);
            if (objDr.Read())
            {
                strCustomerName = objDr["CustomerID"].ToString() + "";
                strEmailid = objDr["Emailid"].ToString() + "";
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);
        }
        public static void GetEmployeeInfo(long lngUserID, ref string strUserName, ref string strEmailid)
        {
            string strSQL;
            IDataReader objDr;
            bool blnUseSQL;

            blnUseSQL = System.Convert.ToBoolean(true);

            strSQL = "usp_tbl_Sel_EmployeeInfo " + lngUserID.ToString();
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, CommonController.connectionString);
            if (objDr.Read())
            {
                strUserName = objDr["UserName"].ToString() + "";
                strEmailid = objDr["EmailID"].ToString() + "";
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);
        }
        public static string funcGetCompanyMailID()
        {
            string strSQL;
            IDataReader objDr;
            bool blnUseSQL;
            string strEmailID = "";
            blnUseSQL = System.Convert.ToBoolean(true);

            strSQL = "Select Email From tbl_PM_CompanyInformation";
            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, CommonController.connectionString);
            if (objDr.Read())
                strEmailID = objDr["Email"].ToString() + "";
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            return strEmailID.Trim();
        }

        public static void SendEmailWithCC(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody)
        {
            // Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery
            try
            {
                if (!IsSMTPEnabled())
                {
                    SendEmailUsingAzure(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strEmailBody).GetAwaiter().GetResult();
                    return;
                }
            }
            catch (Exception)
            {
                throw;
            }
            // End of Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery

            try//Added By Dipali V On 20th OCt 2020 For Release Resource Crash  for Silent Mail Pop UP
            {
               
                string SMTPUserName = "";
                string SMTPPassword = "";
                string SMTPDomainName = "";
                bool SSlEnabled = false;
                string SMTPServer = "";
                string SMTPServerPort = "";
                MyMessage Mail = new MyMessage();
                bool isWithCC;
                bool isWithBCC;
                string successMessage;
                
                System.Net.Mail.MailMessage MyMessage;


               


                    bool isSSLEnabled = false;//System.Convert.ToBoolean(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetSQLDataScalar("SELECT IsSSLEnabled FROM tbl_APP_CompanyInformation",  ConnectionString:connectionString), "0"), "0"));
                string strTempToEmailId = General.CheckIsNothing(strToEmailID);
                string strTempCCEmailID = General.CheckIsNothing(strCCEmailID);
                //SM.WriteLine("In SendEmailWithCC " + System.DateTime.Now);
              
                if (strTempToEmailId != "")
                {
                    strTempToEmailId = strTempToEmailId.Replace(";;", ";");
                    strTempToEmailId = strTempToEmailId.Replace("; ;", ";");

                    strTempToEmailId = strTempToEmailId.Replace(";", ",");

                    if (strTempToEmailId.Substring(strTempToEmailId.Length - 1, 1) == ";" || strTempToEmailId.Substring(strTempToEmailId.Length - 1, 1) == ",")
                        strTempToEmailId = strTempToEmailId.Trim().Remove(strTempToEmailId.Trim().Length - 1);
                    else
                        strTempToEmailId = strTempToEmailId;
                }

                //try
                //{
                if (strTempToEmailId != "")
                {
                    

                    

                    IDataReader drSMTPInfo = CommonFunctions.Data.GetSQLDataReader("usp_SEL_Tbl_PM_CompanyInformation", CommonController.connectionString);

                    while (drSMTPInfo.Read())
                    {
                        SMTPUserName = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPUserName"], "").ToString();
                        // SMTPPassword = CommonFunctions.General.DecryptString(CommonFunctions.Data.CheckIsDBNull(drSMTPInfo("SMTPPassword").ToString(), ""))

                        SMTPPassword = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPPassword"], "").ToString();
                        SMTPPassword = CommonFunctions.General.DecryptString(SMTPPassword);

                        SMTPDomainName = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPDomainName"], "").ToString();
                        SSlEnabled = Convert.ToBoolean(drSMTPInfo["IsSSLEnabled"]);
                        isSSLEnabled = SSlEnabled;
                        SMTPServer = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPServer"], "").ToString();
                        SMTPServerPort = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPServerPort"], "0").ToString();
                    }

                    //Added By Nikhil A For Seting the SMTP userName as From Email ID
                    //strFromEmailID = SMTPUserName;
                    //End Of Added By Nikhil A 
                    MyMessage = new System.Net.Mail.MailMessage(strFromEmailID.Trim(), strTempToEmailId.Trim(), strSubject.Replace(System.Environment.NewLine, ""), strEmailBody);

                    if (strTempCCEmailID != "")
                    {
                        strTempCCEmailID = strCCEmailID.Replace(";", ",");
                        if (strTempCCEmailID.Substring(strTempCCEmailID.Trim().Length - 1, 1) == ";" || strTempCCEmailID.Substring(strTempCCEmailID.Trim().Length - 1, 1) == ",")
                            strTempCCEmailID = strTempCCEmailID.Trim().Remove(strTempCCEmailID.Length - 1);
                        else
                            strTempCCEmailID = strTempCCEmailID.Trim();

                        MyMessage.CC.Add(strTempCCEmailID);
                    }
                    if (Application.EmailFormat == "HTML")
                        MyMessage.IsBodyHtml = true;
                    else
                        MyMessage.IsBodyHtml = false;

                    System.Net.Mail.SmtpClient SmtpClient = new System.Net.Mail.SmtpClient(SMTPServer,587);

                    if (SMTPServer != null)
                        SmtpClient.Host = SMTPServer;
                    else
                        SmtpClient.Host = "localhost";


                    System.Net.NetworkCredential basicCredential = new
                    System.Net.NetworkCredential(SMTPUserName.ToString(), SMTPPassword.ToString());
                    SmtpClient.EnableSsl = true;
                    SmtpClient.UseDefaultCredentials = false;
                    SmtpClient.Credentials = basicCredential;
                   
                   
                   
                    try
                    {
                        SmtpClient.Send(MyMessage);
                        
                    }
                    catch (Exception ex)
                    {
                        
                        
                        //SM.WriteLine("Smtp Exception "+ e.Message + System.DateTime.Now);
                        //throw e;
                    }

                    
                    //SmtpClient.Port = System.Convert.ToInt32(SMTPServerPort);

                    //if ((isSSLEnabled != true))
                    //{
                    //    if (SMTPServer != null)
                    //        SmtpClient.Host = SMTPServer;
                    //    else
                    //        SmtpClient.Host = "localhost";

                    //    SmtpClient.Port = System.Convert.ToInt32(SMTPServerPort);
                    //    if (SMTPUserName != "")
                    //    {
                    //        System.Net.NetworkCredential SMTPUserInfo = new System.Net.NetworkCredential();
                    //        SMTPUserInfo.UserName = SMTPUserName;
                    //        SMTPUserInfo.Password = SMTPPassword;

                    //        if (SMTPDomainName != "")
                    //            SMTPUserInfo.Domain = SMTPDomainName;

                    //        SmtpClient.UseDefaultCredentials = false;
                    //        SmtpClient.Credentials = SMTPUserInfo;
                    //        SmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                    //    }
                    //    SmtpClient.Send(MyMessage);
                    //}
                    //else
                    //{

                    //    var withBlock = Mail;
                    //    withBlock.ToEmailID = strToEmailID.Trim();
                    //    withBlock.CCEmailID = strCCEmailID.Trim();
                    //    withBlock.BCCEmailID = string.Empty;
                    //    withBlock.FromEmailID = strFromEmailID.Trim();
                    //    withBlock.Subject = strSubject;
                    //    withBlock.EmailBody = strEmailBody;
                    //    withBlock.IsBodyHtml = false;
                    //    withBlock.SMTPServer = SMTPServer;
                    //    withBlock.Port = System.Convert.ToInt32(SMTPServerPort);
                    //    withBlock.IsSSLEnabled = isSSLEnabled;
                    //    withBlock.UseName = SMTPUserName;
                    //    withBlock.Password = SMTPPassword;
                    //    withBlock.SMTPDomainName = SMTPDomainName;

                    //    isWithCC = true;
                    //    isWithBCC = false;
                    //    successMessage = string.Empty;
                    //    // Commented By And Added By Rutuja D.on 29 Oct 2021 for TLS
                    //    //SM.WriteLine("Before SendEmailSSLCompatible " + System.DateTime.Now);
                    //    SendEmailSSLCompatible(withBlock, isWithCC, isWithBCC, ref successMessage);

                    //   //End of Commented By And Added By Rutuja D.on 29 Oct 2021 for TLS

                    //}

                    //SM.WriteLine("Before EASendMail Block " + System.DateTime.Now);
                    //Added By Nikhil A 
                    //try
                    //{
                    //    SM.WriteLine("Inside EASendMail Block " + System.DateTime.Now);
                    //    EASendMail.SmtpMail oMail = new EASendMail.SmtpMail("TryIt");
                    //    oMail.From = strFromEmailID.Trim();
                    //    oMail.To = strTempToEmailId.Trim();
                    //    oMail.Cc = strTempCCEmailID.Trim(); ;
                    //    oMail.Subject = strSubject.Replace(System.Environment.NewLine, "");
                    //    oMail.TextBody = strEmailBody;
                    //    SM.WriteLine("oMail Object Created " + System.DateTime.Now);
                    //    EASendMail.SmtpServer oServer = SMTPServer;
                    //    oServer.User = SMTPUserName;
                    //    oServer.Password = SMTPPassword;
                    //    oServer.Port = System.Convert.ToInt32(SMTPServerPort);
                    //    oServer.ConnectType = SmtpConnectType.ConnectSSLAuto;
                    //    SM.WriteLine("oServer Object Created " + System.DateTime.Now);
                    //    EASendMail.SmtpClient oSmtp = new EASendMail.SmtpClient();
                    //    oSmtp.SendMail(oServer, oMail);
                    //    SM.WriteLine("SendMail Called " + System.DateTime.Now);
                    //}
                    //catch (Exception e)
                    //{
                    //    SM.WriteLine("Exception  " +" "+e.Message.ToString()+""+ System.DateTime.Now);
                    //    Console.WriteLine(Convert.ToString(e.Message));
                    //}
                    //End of Added by Nikhil A
                }
                //SM.WriteLine("SMTP Client Sent mail" + DateTime.Now);
                //SM.Close();
            }
            catch (Exception ex)//Added By Dipali V On 20th OCt 2020 For Release Resource Crash  for Silent Mail Pop UP
            {
                //SM.WriteLine("Smtp Exception " + ex.Message + System.DateTime.Now);
            }
            finally//Added By Dipali V On 20th OCt 2020 For Release Resource Crash  for Silent Mail Pop UP
            {
                //MyMessage = null;
                //SmtpClient = null;
            }
            //SM.Close();
            //End of Added By Dipali V On 20th OCt 2020 For Release Resource Crash  for Silent Mail Pop UP
        }
        /// <summary>
        /// vishal mahajan 07-12-2019 for review invite send attachment
        /// </summary>
        /// <param name="strToEmailID"></param>
        /// <param name="strCCEmailID"></param>
        /// <param name="strFromEmailID"></param>
        /// <param name="strSubject"></param>
        /// <param name="strEmailBody"></param>
        /// <param name="strAttachments"></param>
        /// <param name="strAttachmentlisteds"></param>
        public static void SendEmailWithAttachment(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody, HttpFileCollection strAttachments, string[] strAttachmentlisteds)
        {
            HttpContext Context = HttpContext.Current;
            // Create the my message object
            string g_strSmtpServerPort;
            string g_strSmtpServerIP;
            string strFrom;
            string m_strFilePath = AppDomain.CurrentDomain.BaseDirectory;
           
            m_strFilePath = HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/CRMSenEmailAttachment/");
            int Position=0;
            string FileExt = "";
            string strTempFileName = "";
            string[] arrTemFile;
            arrTemFile = new string[1] {""};
            bool isSSLEnabled = System.Convert.ToBoolean(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT IsSSLEnabled FROM tbl_PM_CompanyInformation", true, CommonController.connectionString), "0"), "0"));
            string g_strSmtpServerUserId;
            string g_strSmtpServerPW;

            string strTempToEmailId = General.CheckIsNothing(strToEmailID).Trim();
            string strTempCCEmailID = General.CheckIsNothing(strCCEmailID).Trim();
            if (strTempToEmailId != "")
            {
                strTempToEmailId = Strings.Replace(strTempToEmailId, ";", ",");
                if (strTempToEmailId[strTempToEmailId.Length - 1] == ';' | strTempToEmailId[strTempToEmailId.Length - 1] == ',')
                    strTempToEmailId = strTempToEmailId.Trim().Remove(strTempToEmailId.Length - 1);
                else
                    strTempToEmailId = strTempToEmailId;
            }

           

            // g_strSmtpServerIP = "smtp.lifeline-sys.com"
            g_strSmtpServerIP = System.Convert.ToString(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT smtpServer from tbl_PM_CompanyInformation", true, CommonController.connectionString), ""), ""));
            // strFrom = "swapnil.aswale@lifeline-sys.com"
            // g_strSmtpServerPort = "25"
            g_strSmtpServerPort = System.Convert.ToString(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT smtpServerPort from tbl_PM_CompanyInformation", true, CommonController.connectionString), ""), ""));
            // g_strSmtpServerUserId = "swapnil.aswale@lifeline-sys.com"
            g_strSmtpServerUserId = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT smtpUserName from tbl_PM_CompanyInformation", true, CommonController.connectionString), ""), "");
            // g_strSmtpServerPW = "lenovo@1234"
            g_strSmtpServerPW = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT smtpPAssword from tbl_PM_CompanyInformation", true, CommonController.connectionString), ""), "");
            if (g_strSmtpServerPW != "")
                g_strSmtpServerPW = CommonFunctions.General.DecryptString(g_strSmtpServerPW);
           
            //Added by imran on 10-01-2022
            if(g_strSmtpServerPort !="587")
            {
                g_strSmtpServerPort = "587";
            }
            //End by Imran on 10-01-2022

            //Added By Nikhil A For Setting the From Email ID as SMTP user name 
           // strFromEmailID = g_strSmtpServerUserId;
            //End Of Added By Nikhil A For Setting the From Email ID as SMTP user name 
            System.Net.Mail.MailMessage MyMessage = new System.Net.Mail.MailMessage(strFromEmailID, strTempToEmailId, strSubject, strEmailBody);
            System.Net.Mail.SmtpClient SmtpClient = new System.Net.Mail.SmtpClient();
            if (strTempCCEmailID != "")
            {
                strTempCCEmailID = Strings.Replace(strCCEmailID, ";", ",");
                if (strTempCCEmailID[strTempCCEmailID.Length - 1] == ';' | strTempCCEmailID[strTempCCEmailID.Length - 1] == ',')
                    strTempCCEmailID = strTempCCEmailID.Trim().Remove(strTempCCEmailID.Length - 1);
                else
                    strTempCCEmailID = strTempCCEmailID;
                MyMessage.CC.Add(strTempCCEmailID);
            }
            // Added by Dipali V 26th Oct 2017 For Attachfile During Sending mail
            if (strAttachments != null)
            {
                if (strAttachments.Count > 0)
                {
                    Stream strFilePath;
                    // Dim intLastIndex As Integer = strAttachments.Length - 1
                    HttpPostedFile intIndex;
                    // For Each intIndex As HttpPostedFile In strAttachments.Item
                    //Commented And Mofified BY Nikhil A on 24-Nov-2021 fro Sending Mail Over TLS
                    for (int i = 0; i <= strAttachments.Count - 1; i++)
                    {
                        intIndex = (HttpPostedFile)strAttachments[i];
                        strFilePath = (Stream)intIndex.InputStream;
                        if (strFilePath.Length != 0)
                        {
                            Position = intIndex.FileName.IndexOf(".");
                            FileExt = intIndex.FileName.Substring(Position);
                            strTempFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                            strAttachments[i].SaveAs(m_strFilePath + "\\" + strTempFileName + FileExt);
                            arrTemFile[i] = strTempFileName + FileExt;
                            var oldArrTemFile = arrTemFile;
                            if (oldArrTemFile != null)
                            {
                                Array.Copy(oldArrTemFile, arrTemFile, i + 1);
                            }
                               
                        }
                    }
                    //MyMessage.Attachments.Add(new System.Net.Mail.Attachment(strFilePath, intIndex.FileName));

                    //End Of Commented And Mofified BY Nikhil A on 24-Nov-2021 fro Sending Mail Over TLS

                }
            }

            // End of Added by Dipali V 26th Oct 2017 For Attachfile During Sending mail

            //Added by Dipali V 26th Oct 2017 For Already Attach file
            if (strAttachmentlisteds != null)
            {
                if (strAttachmentlisteds.Length > 0)
                {
                    string strFilePath1;
                    int intLastIndex = strAttachmentlisteds.Length - 1;
                    int intIndex;
                    for (intIndex = 0; intIndex <= intLastIndex; intIndex++)
                    {
                        if (!string.IsNullOrEmpty(strAttachmentlisteds[intIndex]))
                        {
                            strFilePath1 = strAttachmentlisteds[intIndex].Trim();
                            if (System.IO.File.Exists(strFilePath1))
                            {
                                if (strFilePath1 != "")
                                    MyMessage.Attachments.Add(new System.Net.Mail.Attachment(strFilePath1));
                            }
                            else
                            {
                            }
                        }
                    }
                }
            }
            // End of Added by Dipali V 26th Oct 2017 For Already Attach file


            MyMessage.BodyEncoding = System.Text.Encoding.UTF8;
            MyMessage.IsBodyHtml = true;
            if (CommonFunctions.Application.EmailFormat == "HTML")
                MyMessage.IsBodyHtml = true;
            else
                MyMessage.IsBodyHtml = false;

            // Check the applicatin variable smtp server
            if (!string.IsNullOrEmpty(CommonFunctions.Application.SMTPServer))
            {
                SmtpClient.Host = CommonFunctions.Application.SMTPServer;
            }
            else
            {
                SmtpClient.Host = "localhost";
                //SmtpClient.Host = "dedrelay.secureserver.net";
            }

            //SmtpClient.Port = System.Convert.ToInt32(CommonFunctions.Application.SMTPServerPort);

            try
            {
                SmtpClient.UseDefaultCredentials = false;

                System.Net.NetworkCredential SMTPUserInfo = new System.Net.NetworkCredential();
                SMTPUserInfo.UserName = g_strSmtpServerUserId.ToString();
                SMTPUserInfo.Password = g_strSmtpServerPW.ToString();
                //SMTPUserInfo.Domain = "smtp.lifeline-sys.com";
                SmtpClient.Credentials = SMTPUserInfo;
                //SmtpClient.Credentials = new System.Net.NetworkCredential(g_strSmtpServerUserId.ToString(), g_strSmtpServerPW.ToString());
                //SmtpClient.Port = Convert.ToInt32(g_strSmtpServerPort);
                SmtpClient.Port = 587;
                SmtpClient.EnableSsl = true;
                SmtpClient.Host = g_strSmtpServerIP.ToString();
                SmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                SmtpClient.Send(MyMessage);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                MyMessage = null;
                SmtpClient = null;
            }
            //Added By Nikhil A on 24-0v-2021 for Sending Mail Over TLS
            //////////try
            //////////{
            //////////    EASendMail.SmtpMail oMail = new EASendMail.SmtpMail("TryIt");
            //////////    oMail.From = strFromEmailID;
            //////////    oMail.To = strTempToEmailId.Trim();
            //////////    oMail.Cc = strTempCCEmailID.Trim();
            //////////    oMail.Subject = strSubject;
            //////////    oMail.TextBody = strEmailBody;
            //////////    if (strAttachmentlisteds != null)
            //////////    {
            //////////        if (strAttachmentlisteds.Length > 0)
            //////////        {
            //////////            string strFilePath1;
            //////////            int intLastIndex = strAttachmentlisteds.Length - 1;
            //////////            int intIndex;
            //////////            for (intIndex = 0; intIndex <= intLastIndex; intIndex++)
            //////////            {
            //////////                if (!string.IsNullOrEmpty(strAttachmentlisteds[intIndex]))
            //////////                {
            //////////                    strFilePath1 = strAttachmentlisteds[intIndex].Trim();
            //////////                    if (System.IO.File.Exists(strFilePath1))
            //////////                    {
            //////////                        if (strFilePath1 != "")
            //////////                            oMail.AddAttachment(strFilePath1);
            //////////                    }
            //////////                    else
            //////////                    {
            //////////                    }
            //////////                }
            //////////            }
            //////////        }
            //////////        if (strAttachments != null)
            //////////        {
            //////////            if (arrTemFile.Length > 0)
            //////////            {
            //////////                for (int intIndex = 0; intIndex <= arrTemFile.Length; intIndex++)
            //////////                {
            //////////                    if (System.IO.File.Exists(m_strFilePath + "\\" + arrTemFile[intIndex]))
            //////////                    {
            //////////                        oMail.AddAttachment(m_strFilePath + "\\" + arrTemFile[intIndex]);
            //////////                    }
            //////////                }
            //////////            }
            //////////        }
                       

            //////////    }
            //////////    EASendMail.SmtpServer oServer = g_strSmtpServerIP;
            //////////    oServer.User = g_strSmtpServerUserId.ToString(); 
            //////////    oServer.Password = g_strSmtpServerPW.ToString(); 
            //////////    oServer.Port = Convert.ToInt32(g_strSmtpServerPort);
            //////////    oServer.ConnectType = SmtpConnectType.ConnectSSLAuto;
            //////////    EASendMail.SmtpClient oSmtp = new EASendMail.SmtpClient();
            //////////    oSmtp.SendMail(oServer, oMail);
            //////////}
            //////////catch (Exception e)
            //////////{
            //////////    Console.WriteLine(Convert.ToString(e.Message));
            //////////}
            //End of Added By Nikhil A on 24-0v-2021 for Sending Mail Over TLS
        }
        public static string SendEmailSSLCompatible(MyMessage mail, bool isWithCC, bool isWithBCC, ref string successMessage)
        {
            // ============================================================================
            // Procedure Name		: SendEmailSSLCompatible
            // Description		: Send mail with SSl Compatible settings....
            // ============================================================================
            StreamWriter SM = new StreamWriter(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/CRMSenEmailAttachment/SendEmailSSLCompatible.txt"));
            try
            {
            
            SM.WriteLine("SendEmailSSLCompatible Start" + System.DateTime.Now);
            CDO.Message Message = new CDO.Message();
            CDO.Configuration iConf = new CDO.Configuration();
            iConf.Fields[CDO.CdoConfiguration.cdoSendUsingMethod].Value = CDO.CdoSendUsing.cdoSendUsingPort;
            iConf.Fields[CDO.CdoConfiguration.cdoSMTPServerPort].Value = mail.Port.ToString();
            iConf.Fields[CDO.CdoConfiguration.cdoSMTPServer].Value = mail.SMTPServer;
            iConf.Fields[CDO.CdoConfiguration.cdoSMTPAuthenticate].Value = CDO.CdoProtocolsAuthentication.cdoBasic;
            iConf.Fields[CDO.CdoConfiguration.cdoSendUserName].Value = mail.UseName;
            iConf.Fields[CDO.CdoConfiguration.cdoSendPassword].Value = mail.Password;
            iConf.Fields[CDO.CdoConfiguration.cdoSMTPUseSSL].Value = mail.IsSSLEnabled;
            iConf.Fields.Update();
            Message.Configuration = iConf;
            Message.AutoGenerateTextBody = true;
            Message.From = mail.FromEmailID;
            Message.To = mail.ToEmailID;

            if (isWithCC)
                Message.CC = mail.CCEmailID;
            if (isWithBCC)
                Message.BCC = mail.BCCEmailID;
            Message.Subject = mail.Subject;
            if (mail.IsBodyHtml)
                Message.HTMLBody = mail.EmailBody;
            else
                Message.TextBody = mail.EmailBody;

            Message.Send();
            successMessage = "SUCCESS";
                SM.Close();
                return "";
            }

            catch (Exception ex)
            {
                SM.WriteLine("SendEmailSSLCompatible Exception  " + ex.Message +", "+ System.DateTime.Now);
                SM.Close();
                return ex.Message;
                successMessage = "ERROR";
            }
           
            //finally
            //{
            //}
        }

        static int codedBy;
        static string ProjectName, Summary, Type, Description, UserName, Subject, Message;
        static string Discussion, strDiscussionDate, Comments;
        static DateTime DiscussionDate;
        [Authorize]
        [HttpPost]
        public static void GetEmailMessage_473(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intProjectID, int intIssueID, int intMessageID, int intEmployeeID)
        {
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;
            IDataReader drIssue;
            string strUserName = "";
            string strProjectName = "";
            string strReportedBy = "";
            string strReportedByPersonEmail = "";
            IDataReader objDr;
            string intResponsible = "";
            string strResponsiblePersonEmail = "";
            string strSQL = "";

            if (intProjectID != 0)
            {
                strEmailMessage = funcGetEmailMessageForProject(intProjectID, intMessageID, ref strSubject);
            }
            else
            {
                strEmailMessage = funcGetEmailMessageForProject(intProjectID, intMessageID, ref strSubject);
            }

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER_NAME>", strUserName);

            drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_Issue_Mail " + intIssueID.ToString(), true, CommonController.connectionString);

            //  ' If the Issue exists, then...
            if (drIssue.Read())
            {
                strMessage.Replace("<TITLE>", drIssue["Summary"].ToString().Trim());
                strEmailSubject.Replace("<TITLE>", drIssue["Summary"].ToString().Trim());

                strReportedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["ReportedBy"], ""));
                strReportedBy = strReportedBy.Trim();
                intResponsible = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["AssignTO"].ToString(), ""));
            }

            if (strReportedBy != "")
            {

                if (intProjectID != 0)
                {
                    //commented & added By dipali V On 16th Sep 2019 For New Sp
                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //End of commented & added By dipali V On 16th Sep 2019 For New Sp
                }
                else
                { //commented & added By dipali V On 16th Sep 2019 For New Sp
                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //End of commented & added By dipali V On 16th Sep 2019 For New Sp
                }
                if (objDr.Read())
                {
                    strReportedByPersonEmail = objDr["EmailID"].ToString();
                }
                CommonFunctions.Data.DisposeDataReader(ref objDr);
            }

            if (intResponsible != "0" && intResponsible != "")
            {

                //commented & added By dipali V On 16th Sep 2019 For SQl Injection
                strSQL = "usp_Whizible2_sel_IB_tbl_PM_EmployeeEmails " + intResponsible;
                //End of commented & added By dipali V On 16th Sep 2019 For SQl Injection
                strResponsiblePersonEmail = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "").ToString();
                strSQL = string.Empty;
            }

            if (intProjectID != 0)
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, intProjectID, intMessageID, intEmployeeID.ToString());
            }
            else
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, intProjectID, intMessageID, intEmployeeID.ToString());
            }

            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            strSubject = strEmailSubject.ToString();
            strEmailMessage = strMessage.ToString();
            //Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
            if ((strCCToEmailID.IndexOf(strResponsiblePersonEmail) == 0) && (strToEmailID.IndexOf(strResponsiblePersonEmail) == 0))
            {
                //End Of Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
                strToEmailID = strToEmailID + strResponsiblePersonEmail + ";";
            }
            //Added by Dipali V On 7th July 2020 
            if (strToEmailID == "") {
                strToEmailID = strResponsiblePersonEmail;
            }
            //End of Added by Dipali V On 7th July 2020 
        }




        [Authorize]
        [HttpPost]
        public static void GetEmailMessage_33(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intIssueID, int IssueProjectID, int intMessageID, int intEmployeeID)
        {



            string strUserName = "";
            string strProjectName = "";
            IDataReader drReceiver;
            IDataReader drIssue;
            string strListOfReceivers = "";
            //int intMessageID = 33;
            string strProjectIssueType = "";
            string strProjectIssueStatus = "";
            bool blnShowToCustomer = false;
            string strMailToEmployeeIDList = "";
            string strMailCCToEmployeeIDList = "";
            IDataReader drEmployee;
            //  int IssueProjectID = 1121;
            int intProjectID = 0;
            //   int intEmployeeID = 61;
            int intCust = 1;
            string strReportedBy = "";
            string strReportedByPersonEmail = "";
            IDataReader objDr;
            string intResponsible = "";
            string strResponsiblePersonEmail = "";
            System.Text.StringBuilder strMessage;
            string strSQL = "";
            System.Text.StringBuilder strEmailSubject;

            //Added By Usha Pandit On 04.05.2021 For getting login type details
            string strLoginType = "";           
            IDataReader objDr1;
            string strSQL1;
            strSQL1 = "SELECT LoginType FROM TBL_PM_lOGIN WHERE CustomerID=" + intEmployeeID;
            objDr1 = Data.GetDataReader(strSQL1, true, CommonController.connectionString);
            if (objDr1.Read())
            {
                strLoginType = Convert.ToString(objDr1["LoginType"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr1);
            //End Of Added By Usha Pandit On 04.05.2021 For getting login type details


            //string strSQL = "exec usp_Whizible2_tbl_Sel_EmployeeInfo " + intEmployeeID;
            //data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            //foreach (DataRow rowValue in data.Rows)
            //{

            //    strFromEmailID = CommonFunctions.Data.CheckIsDBNull(rowValue["EmailID"], "abc@gmail.com").ToString();
            //    UserName = CommonFunctions.Data.CheckIsDBNull(rowValue["UserName"], " ").ToString();
            //    //checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultStatus"], "false"));

            //}
            //data.Clear();
            //strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project " + intProjectID;
            //data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            //foreach (DataRow rowValue in data.Rows)
            //{

            //    ProjectName = CommonFunctions.Data.CheckIsDBNull(rowValue["ProjectName"], " ").ToString();
            //    //checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultStatus"], "false"));

            //}
            //data.Clear();
            //Added By Dipali V On 12th Sep 2019 For Email Comes blank
            if (IssueProjectID != 0)
            {
                strEmailMessage = funcGetEmailMessageForProject(IssueProjectID, intMessageID, ref strSubject);
            }
            else
            {
                strEmailMessage = funcGetEmailMessageForProject(IssueProjectID, intMessageID, ref strSubject);
            }

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER_NAME>", strUserName);
            //End of Added By Dipali V On 12th Sep 2019 For Email Comes blank


            //Added By Dipali V On 12th Sep 2019 For Email Comes blank
            //Commented & Added By Dipali V 16th Sep 2019 for New SP
            //drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " + intIssueID.ToString(), true, CommonController.connectionString);
            drIssue = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_Sel_tbl_IB_IssueEmailDetails " + intIssueID.ToString(), true, CommonController.connectionString);
            //End of Commented & Added By Dipali V 16th Sep 2019 for New SP
            //  ' If the Issue exists, then...
            if (drIssue.Read())
            {


                strMessage.Replace("<ISSUE_TYPE>", drIssue["Type"].ToString().Trim());
                strMessage.Replace("<ISSUE_ID>", drIssue["IssueID"].ToString().Trim());
                strMessage.Replace("<ISSUE_SUMMARY>", drIssue["Summary"].ToString().Trim());
                strEmailSubject.Replace("<ISSUE_SUMMARY>", drIssue["Summary"].ToString().Trim());
                //Added By Dipali V ON 3rd April 2020 For Issue ID placeholder should replace
                strEmailSubject.Replace("<ISSUE_ID>", drIssue["IssueID"].ToString().Trim());
                //End of Added By Dipali V ON 3rd April 2020 For Issue ID placeholder should replace
                strMessage.Replace("<DESCRIPTION>", drIssue["Description"].ToString().Trim());
                strProjectIssueType = drIssue["Type"].ToString().Trim();
                strProjectIssueStatus = drIssue["Status"].ToString().Trim();
                blnShowToCustomer = Convert.ToBoolean(drIssue["ShowToCustomer"]);


                strReportedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["ReportedBy"], ""));
                strReportedBy = strReportedBy.Trim();
                intResponsible = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssue["AssignTO"].ToString(), ""));


            }
            //End of Added By Dipali V On 12th Sep 2019 For Email Comes blank

            if (strReportedBy != "")
            {

                if (IssueProjectID != 0)
                {
                    //Added & Commented  By Dipali V On 17th April 2020 For Get Reported By With Specific Project
                    //commented & added By dipali V On 16th Sep 2019 For New Sp
                    // objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //End of commented & added By dipali V On 16th Sep 2019 For New Sp
                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + IssueProjectID, true, CommonController.connectionString);
                    //End of Added & Commented  By Dipali V On 17th April 2020 For Get Reported By With Specific Project

                }
                else
                {

                    //Added & Commented  By Dipali V On 17th April 2020 For Get Reported By With Specific Project
                    //commented & added By dipali V On 16th Sep 2019 For New Sp
                    //objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //End of commented & added By dipali V On 16th Sep 2019 For New Sp

                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + IssueProjectID, true, CommonController.connectionString);
                    //Endd of Added & Commented  By Dipali V On 17th April 2020 For Get Reported By With Specific Project
                }
                if (objDr.Read())
                {
                    strReportedByPersonEmail = objDr["EmailID"].ToString();
                }
                CommonFunctions.Data.DisposeDataReader(ref objDr);
            }

            if (intResponsible != "0" && intResponsible != "")
            {
                //commented & added By dipali V On 16th Sep 2019 For SQl Injection
                //strSQL = "SELECT ISNULL(EmailID,'') FROM tbl_PM_Employee WITH (NOLOCK) WHERE ISNULL(Status,0) = 0 AND EmployeeID = " + intResponsible;

                strSQL = "usp_Whizible2_sel_IB_tbl_PM_EmployeeEmails " + intResponsible;
                //End of commented & added By dipali V On 16th Sep 2019 For SQl Injection
                strResponsiblePersonEmail = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "").ToString();
                //strResponsiblePersonEmail = strResponsiblePersonEmail;
                strSQL = string.Empty;
                //strSQL = "exec usp_Whizible2_sel_IssueResponsiblePerson_forDTmail " + intProjectID;
                // strCCToEmailID = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
            }




            //Added By Dipali V On 12th Sep 2019 For Email Comes blank
            if (IssueProjectID != 0)
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, IssueProjectID, intMessageID, intEmployeeID.ToString());
            }
            else
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, IssueProjectID, intMessageID, intEmployeeID.ToString());
            }


            //      'strEmailMessage = Replace(strEmailMessage, "<PROJECT_NAME>", strProjectName)
            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            // 'strSubject = Replace(strSubject, "<PROJECT_NAME>", strProjectName)
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);

            // ' Retrieve information about the Sender.



            //  'strEmailMessage = Replace(strEmailMessage, "<SENDER_NAME>", strUserName)
            //End of Added By Dipali V On 12th Sep 2019 For Email Comes blank
            DataTable data;
            strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Discussion " + intIssueID;
            data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            string strDiscussion = "";
            foreach (DataRow rowValue in data.Rows)
            {
                strUserName = CommonFunctions.Data.CheckIsDBNull(rowValue["UserName"], " ").ToString();
                DiscussionDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(rowValue["DiscussionDate"], ""));
                Comments = CommonFunctions.Data.CheckIsDBNull(rowValue["Comments"], " ").ToString();

                strDiscussion += "Comment added by " + strUserName + " On " + DiscussionDate.ToString("dd MMM yyyy hh:mm tt");
                strDiscussion += "\r\n";
                strDiscussion += Comments;
                strDiscussion += "\r\n\r\n";
            }

            strMessage = strMessage.Replace("<DISCUSSION_THREAD>", strDiscussion.ToString());
            if (strListOfReceivers.Trim() == "")
            {
                strListOfReceivers = "All";
            }

            strMailToEmployeeIDList = "";
            strMailCCToEmployeeIDList = "";
            //Added By Dipali V On 12th Sep 2019 For Email Comes blank
            if (IssueProjectID != 0)
            {
                //Added & commnetd by dipali V On 16th sep 2019 for New SP
                drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);

               // drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible_Sel_tbl_IB_IssueBaseMails NULL, " + intProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                // drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                //End of Added & commnetd by dipali V On 16th sep 2019 for New SP
            }
            else
            {
                //Added & commnetd by dipali V On 16th sep 2019 for New SP
                drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible_Sel_tbl_IB_IssueBaseMails NULL, " + IssueProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);

               // drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Whizible_Sel_tbl_IB_IssueBaseMails NULL, " + intProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                //  drIssue = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails NULL, " + intProjectID + ", '" + CommonFunctions.General.BuildQueryString(strProjectIssueType) + "', '" + CommonFunctions.General.BuildQueryString(strProjectIssueStatus) + "'", true, CommonController.connectionString);
                //End of Added & commnetd by dipali V On 16th sep 2019 for New SP
            }

            if (drIssue.Read())
            {
                strMailToEmployeeIDList = drIssue["MailToEmployeeIDList"].ToString();
                strMailCCToEmployeeIDList = drIssue["MailCCToEmployeeIDList"].ToString();
            }
            CommonFunctions.Data.DisposeDataReader(ref drIssue);

            if (strMailCCToEmployeeIDList != "")
            {
                strMailCCToEmployeeIDList += ";";
            }




            bool blnShowDTToCustomer = false;
            if (IssueProjectID != 0)
            {
                //added & commented by dipali V On 16th Sep 2019 For New SP
                // drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + intProjectID, true, CommonController.connectionString);
                drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);

                // drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);
                //End of added & commented by dipali V On 16th Sep 2019 For New SP
            }
            else
            {
                //added & commented by dipali V On 16th Sep 2019 For New SP
                //drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + intProjectID, true, CommonController.connectionString);
                drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);

                // drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList " + intProjectID, true, CommonController.connectionString);
                //End of added & commented by dipali V On 16th Sep 2019 For New SP
            }

            while (drEmployee.Read())
            {
                if (drEmployee["EmailID"].ToString().Trim() != "")
                {
                    if (blnShowToCustomer == true || (blnShowToCustomer == false && (drEmployee["ResourceType"].ToString() == "E" || drEmployee["ResourceType"].ToString() == "CE")))
                    {
                        //Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                        //if (strMailToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                        if (Strings.InStr(strMailToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                        {
                            //if (strToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                            if (Strings.InStr(strToEmailID, drEmployee["EmailID"].ToString()) == 0)
                            //End of Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                            {
                                //Added By Dipali V For Getting duplicated TO Mail ID

                                if (strToEmailID != "")
                                {
                                    //Commented And Added By Dipali Vekhande on 27 Sep 2021 To EmailID shold not Override
                                    //strToEmailID = drEmployee["EmailID"].ToString().Trim();
                                    //commented And Added By Reshma Chavan on 1st Nov 2021 Getting Double Semi Colon
                                    //strToEmailID = strToEmailID + ";" + drEmployee["EmailID"].ToString().Trim() + "; ";
                                    strToEmailID = strToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                    //End of commented And Added By Reshma Chavan on 1st Nov 2021 Getting Double Semi Colon
                                }
                                else
                                {
                                    //Commented And Added By Dipali Vekhande on 27 Sep 2021 To EmailID shold not Override
                                    //strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + "; ";
                                    strToEmailID = drEmployee["EmailID"].ToString().Trim();
                                }

                                //End of Added By Dipali V For Getting duplicated TO Mail ID


                            }
                        }
                        //Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                        //if (strMailCCToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                        if (Strings.InStr(strMailCCToEmployeeIDList, "," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)

                        {
                            // if (strCCToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                            if (Strings.InStr(strCCToEmailID, drEmployee["EmailID"].ToString().Trim()) == 0)
                            {
                                //Added By Dipali V For Getting duplicated TO Mail ID
                                //Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                                //if (strCCToEmailID != "")
                                //{
                                //    strCCToEmailID = drEmployee["EmailID"].ToString().Trim();
                                //}
                                //else
                                //{
                                //    strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();

                                //}

                                //End of Added By Dipali V For Getting duplicated TO Mail ID
                                //Commented & Added By Rutuja D. on 25 Oct 2021 For Remove Space into CC Mail Issue
                                //strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();
                                strCCToEmailID = strCCToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                //End of Commented & Added By Rutuja D. on 25 Oct 2021 For Remove Space into CC Mail Issue
                                //End of Commented and Added By Reshma Chavan on 14th Sep 2021 For Configure CC mail issue
                            }
                        }
                    }
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drEmployee);

            if (intResponsible.ToString() != "")
            {
                //Added & Commented By Dipali V On 16th Sep 2019 For SQL Injection
                // strResponsiblePersonEmail = CType(CommonFunctions.Data.GetDataScalar("SELECT ISNULL(EmailID,'') FROM tbl_PM_Employee WHERE EmployeeID = " + intResponsible.ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
                strResponsiblePersonEmail = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_IB_tbl_PM_EmployeeEmails " + intResponsible.ToString(), true, CommonController.connectionString));
                //End of Added & Commented By Dipali V On 16th Sep 2019 For SQL Injection

            }

            if ((strCCToEmailID.IndexOf(strResponsiblePersonEmail) == 0) && (strToEmailID.IndexOf(strResponsiblePersonEmail) == 0))
            {
                if (strToEmailID != "")
                {
                    if (strToEmailID.EndsWith(";"))
                    {
                        strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                    }
                    strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
            }

            if (strReportedBy != "")
            {

                if (IssueProjectID != 0)
                {
                    //Added & Commented By Dipali V On 16th Sep 2019 For New SP
                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "'," + IssueProjectID, true, CommonController.connectionString);
                    // objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + IssueProjectID, true, CommonController.connectionString);
                    //End of Added & Commented By Dipali V On 16th Sep 2019 For New SP
                }
                else
                {    //Added & Commented By Dipali V On 16th Sep 2019 For New SP
                    objDr = CommonFunctions.Data.GetDataReader("Exec usp_whizible2_sel_tbl_IB_Issue_reportedByEmail '" + strReportedBy + "', " + IssueProjectID, true, CommonController.connectionString);
                    // objDr = CommonFunctions.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue_reportedBy '" + strReportedBy + "'," + intProjectID, true, CommonController.connectionString);
                    //End of Added & Commented By Dipali V On 16th Sep 2019 For New SP
                }
                if (objDr.Read())
                {
                    strReportedByPersonEmail = objDr["EmailID"].ToString();
                }
                CommonFunctions.Data.DisposeDataReader(ref objDr);
            }



            if ((strCCToEmailID.IndexOf(strReportedByPersonEmail) == 0) && (strToEmailID.IndexOf(strReportedByPersonEmail) == 0))
            {
                if (strCCToEmailID != "")
                {
                    if (strCCToEmailID.EndsWith(";"))
                    {
                        strCCToEmailID = strCCToEmailID.Remove(strCCToEmailID.Length - 1);
                    }
                    strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail;
                }
                else
                {
                    strCCToEmailID = strReportedByPersonEmail;
                }

                if (strToEmailID == "")
                {
                    //strToEmailID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_IssueResponsiblePerson_forDTmail " + IssueProjectID, true, CommonController.connectionString), ""), "");
                    strToEmailID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_IssueResponsiblePerson_forDTmail " + IssueProjectID, true, CommonController.connectionString), ""), "");

                }

                if (strToEmailID == "")
                {
                    strToEmailID = strFromEmailID;
                }


            }
            //Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
            if ((strCCToEmailID.IndexOf(strResponsiblePersonEmail) == 0) && (strToEmailID.IndexOf(strResponsiblePersonEmail) == 0))
            {
                //End Of Added By Usha Pandit On 02.04.2020 for preventing duplicate insertion of Email Id in To Email textbox
                if (strToEmailID != "")
                {
                    if (strToEmailID.EndsWith(";"))
                    {
                        strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                    }
                    strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
            }
            else
            {
                //Added By Dipali V For Getting duplicated TO Mail ID
                if (strToEmailID != "")
                {
                    if (strToEmailID.Contains(strResponsiblePersonEmail))
                    {
                        // strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail;
                    }
                    else
                    {
                        if (strToEmailID.EndsWith(";"))
                        {
                            strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                        }
                        strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                    }

                }
                else
                {
                    strToEmailID = strResponsiblePersonEmail;
                }
                //Added By Dipali V For Getting duplicated TO Mail ID
            }

            //added by dipali v on 31st march 2021 for if login type C then Tomail ID
            //if (LoginType == "C")
            //{
            //    if (strReportedByPersonEmail != "")
            //    {
            //        if (strToEmailID != "")
            //        {
            //            strToEmailID = strToEmailID + ";" + strReportedByPersonEmail;
            //        }
            //        else
            //        {
            //            strToEmailID = strReportedByPersonEmail;
            //        }
            //    }
            //    else
            //    {
            //        strToEmailID = strToEmailID;
            //    }
            //    //End of added by dipali v on 31st march 2021 for if login type C then Tomail ID

            //}



            //End of Added By Dipali V On 12th Sep 2019 For Email Comes blank

            //Added By Usha Pandit On 04.05.2021 For get To mail id if customer login
            if (strLoginType == "C")
            {
                if (strReportedByPersonEmail != "")
                {
                    if (strToEmailID.Contains(strResponsiblePersonEmail))
                    {
                        // strCCToEmailID = strCCToEmailID + ";" + strReportedByPersonEmail;
                    }
                    else
                    {
                        if (strToEmailID.EndsWith(";"))
                        {
                            strToEmailID = strToEmailID.Remove(strToEmailID.Length - 1);
                        }
                        strToEmailID = strToEmailID + ";" + strResponsiblePersonEmail;
                    }
                }
                else
                {
                    strToEmailID = strToEmailID;
                }
            }
            //End Of Added By Usha Pandit On 04.05.2021 For get To mail id if customer login


            //4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            //5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;



        }

        //Added By Dipali V On 4th Jun 2020 For  Assign issue Mail pop up should open
        [Authorize]
        [HttpPost]
        //Commented And Added By Reshma chavan on 28th oct 2021
        ////public static void GetEmailMessage_14(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intIssueID, int IssueProjectID, int intMessageID, int intEmployeeID)
        public static void GetEmailMessage_14(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intIssueID, int IssueProjectID, int intMessageID, int intEmployeeID, int LoginUserID, string SelectedEmployeeID)
        {




            string strUserName = "";
            string strProjectName = "";
            IDataReader drReceiver;
            IDataReader drIssue;
            string strListOfReceivers = "";
            //int intMessageID = 33;
            string strProjectIssueType = "";
            string strProjectIssueStatus = "";
            bool blnShowToCustomer = false;
            string strMailToEmployeeIDList = "";
            string strMailCCToEmployeeIDList = "";
            IDataReader drEmployee;
            //  int IssueProjectID = 1121;
            int intProjectID = 0;
            //   int intEmployeeID = 61;
            int intCust = 1;
            string strReportedBy = "";
            string strReportedByPersonEmail = "";
            IDataReader objDr;
            IDataReader objDrTask;
            string intResponsible = "";
            string strResponsiblePersonEmail = "";
            System.Text.StringBuilder strMessage;
            string strSQL = "";
            int lngTaskID = 0;
            System.Text.StringBuilder strEmailSubject;
            //string strToEmailID;
            IDataReader objDrReceiver;
            string strTempArray = "";
            // strTempArray = Split(strEmployeeIDList, ",");
            //string[] Result = strTempArray.Split(',');
            //int intCtr = 0;
            // strTempArray = strListOfEmployeeIDs.Replace(" ", string.Empty).Trim();

            //Commented And Added by Reshma chavan on 28th oct 2021
            //string[] Result = strTempArray.Split(',');
            //int i = 0;
            //string strReceiverList = "";
            //for (i = 0; i <= Result.Length - 1; i++) {

            //    if ((Result[i] + "") != "")
            //    {
            //        intEmployeeID = Convert.ToInt16(Result[i].ToString());
            //        // Retrieve information about the RECEIVER.
            //        strSQL = "usp_tbl_Sel_EmployeeInfo " + Result[i].ToString();
            //        objDrReceiver = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            //        if (objDrReceiver.Read())
            //        {
            //            //Get the Email ID of the resource.
            //            //strToEmailID += Data.CheckIsDBNull(objDrReceiver("EmailID"), "").ToString() + ";";
            //            strToEmailID= Convert.ToString(CommonFunctions.Data.CheckIsDBNull(objDrReceiver["EmailID"], ""));
            //            // Get the name of the resource.
            //            strReceiverList += objDrReceiver["UserName"].ToString() + ",";
            //        }
            //        //Data.DisposeDataReader(objDrReceiver);

            //    }

            //}

            //if (strReceiverList != "")
            //{
            //    strReceiverList = strReceiverList + "," + strReceiverList;
            //    //Left(strReceiverList, InStrRev(strReceiverList, ",") - 1);
            //}

            

            // Retrieve information about the RECEIVER.
            string strReceiverList = "";
            //Commented & Added By Dipali V On 29th Nov 2021  For Selected Resource Details
            //strSQL = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID.ToString();
            strSQL = "usp_tbl_Sel_EmployeeInfo " + SelectedEmployeeID.ToString();
            //End of Commented & Added By Dipali V On 29th Nov 2021  For Selected Resource Details
            objDrReceiver = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDrReceiver.Read())
            {
                //Get the Email ID of the resource.                
                strToEmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(objDrReceiver["EmailID"], ""));
                //Get the name of the resource.
                strReceiverList = objDrReceiver["UserName"].ToString();
            }
            if (strReceiverList != "") {
                // strReceiverList = strReceiverList + "," + strReceiverList;
                strReceiverList = strReceiverList;
                //Left(strReceiverList, InStrRev(strReceiverList, ",") - 1);
            }





            IDataReader objDrIssue;
            string strEmailID = "";
            //Retrieve the associated TaskID for the Issue.	
            strSQL = "usp_Sel_IB_GetAssociatedTaskIDForIssue " + intIssueID.ToString() + "," + SelectedEmployeeID.ToString();
            objDrIssue = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDrIssue.Read())
            {
                //lngTaskID = Convert.ToString(Data.CheckIsDBNull(objDrIssue["Type"].ToString()),"");
                //IssueProjectID = Convert.ToString(Data.CheckIsDBNull(objDrIssue["ProjectID"].ToString()), "");
               //Commented & Added By Dipali V on 29th July 2020 For Task Related get info
               //lngTaskID = Convert.ToInt32(objDrIssue["TYPE"].ToString());
                lngTaskID = Convert.ToInt32(objDrIssue["TaskID"].ToString());
                IssueProjectID = Convert.ToInt16(objDrIssue["ProjectID"].ToString());
                //End of Commented & Added By Dipali V on 29th July 2020 For Task Related get info
            }
            //Data.DisposeDataReader(objDrIssue);
            if (IssueProjectID != 0)
            {
                strEmailMessage = funcGetEmailMessageForProject(IssueProjectID, intMessageID, ref strSubject);
            }
            else
            {
                strEmailMessage = funcGetEmailMessageForProject(IssueProjectID, intMessageID, ref strSubject);
            }

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strMessage.Replace("<NAME>", strReceiverList);

            strMessage.Replace("<ISSUE_ID>", intIssueID.ToString());
            strEmailSubject.Replace("<ISSUE_ID>", intIssueID.ToString());
            if (IssueProjectID != 0)
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, IssueProjectID, intMessageID, intEmployeeID.ToString());
            }
            else
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, IssueProjectID, intMessageID, intEmployeeID.ToString());
            }


            //      'strEmailMessage = Replace(strEmailMessage, "<PROJECT_NAME>", strProjectName)
            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            // 'strSubject = Replace(strSubject, "<PROJECT_NAME>", strProjectName)
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);

            //A CC needs to be sent to the Responsible Person as well.
            string strCustomerIssueID = "";
            strSQL = "Exec usp_Sel_tbl_IB_Issue " + intIssueID.ToString();
            objDrIssue = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDrIssue.Read())
            {
                if (objDrIssue["AssignTo"] != "") {
                    string AssignTo = Convert.ToInt32(objDrIssue["AssignTo"]).ToString();
                    //Commented And Added By Dipali V  on 29th Nov 2021 Getting Wrong To EmailID
                   // GetEmployeeInfo(Int64.Parse(AssignTo), ref strUserName, ref strToEmailID);
                    GetEmployeeInfo(Int64.Parse(SelectedEmployeeID), ref strUserName, ref strToEmailID);
                    // GetEmployeeInfo(Int64.Parse(intEmployeeID.ToString()), ref strUserName, ref strToEmailID);
                    //End of Commented And Added By Dipali V  on 29th Nov 2021 Getting Wrong To EmailID
                    if (strEmailID != "") {
                        if(strToEmailID!= strEmailID && strCCToEmailID!= strEmailID) { 
                        //if (InStr(1, strToEmailID, strEmailID) = 0 && InStr(1, strCCToEmailID, strEmailID) = 0) {
                            strCCToEmailID += ";" + strEmailID;
                        }
                    }
                    

                }
                strCustomerIssueID = Data.CheckIsDBNull(objDrIssue["CustomerIssueID"], "0").ToString();
            }
            //Data.DisposeDataReader(objDrIssue);


            if (strCustomerIssueID != "0")
            {
                strEmailSubject.Replace("<CUSTOMER_ISSUE_ID>", "; Customer Issue ID: " + strCustomerIssueID + "");
            }
            else {

                strEmailSubject.Replace("<CUSTOMER_ISSUE_ID>", "");
            }




            if (strCustomerIssueID != "0")
            {
                strMessage.Replace("<CUSTOMER_ISSUE_ID>", "Customer Issue ID : " + strCustomerIssueID + "");
            }
            else
            {

                strMessage.Replace("<CUSTOMER_ISSUE_ID>", "");
            }



            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(intEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);
            if ((Convert.ToInt32(intIssueID)) <= 0) {
                return;   
             }

            // Retrieve the task details.
            strSQL = "usp_Sel_tbl_PM_ProjectTasks " + IssueProjectID.ToString() + "," + lngTaskID.ToString();
            objDrTask = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDrTask.Read()) {
                strMessage.Replace("<TASK_NAME>", objDrTask["TaskName"].ToString() + "");
            }
            //Data.DisposeDataReader(objDrTask);
                //4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

                //5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;



        }






        public static void GetEmailMessage_483(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intModuleID, string strProjectID, string strEmployeeID)
        {
            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;
            string strProjectName = "";
            string strModuleName = "";
            string strQuery, strEmailId = "", strListOfEmployeeNames = "";
            IDataReader objDr;
            DataTable objSPDr;
            DataTable objSPDr1;
            IDataReader drTempWork;
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 483;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            //Get from email id.. ID of the person who verified the timesheet
            //GetEmployeeInfo(intEmployeeID, ref strUserName, ref strFromEmailID);


            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID.ToString();
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString().Trim();
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString().Trim();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }


            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            strMessage = new StringBuilder("");
            strEmailSubject = new StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            GetModuleInfo(Convert.ToInt32(strProjectID), ref strProjectName, ref strModuleName, intModuleID);
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<MODULE_NAME>", strModuleName);
            strEmailSubject.Replace("<MODULE_NAME>", strModuleName);



            // Get the info about Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(strEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);

            // Get the info about EmailID for TO section

            strQuery = Convert.ToString("usp_Sel_tbl_PM_Module_MailTo " + intModuleID + ",") + Convert.ToInt32(strProjectID);
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                while (drTempWork.Read())
                {
                    if (drTempWork["EmailID"].ToString().Trim() != "")
                    {
                        if (strEmailId.IndexOf(drTempWork["EmailID"].ToString().Trim()) == -1)
                        {
                            strEmailId = Convert.ToString(strEmailId) + drTempWork["EmailID"].ToString().Trim() + ",";
                            strListOfEmployeeNames = Convert.ToString(strListOfEmployeeNames) + drTempWork["EmployeeName"].ToString().Trim() + ",";
                        }
                    }

                }
            }
            if (strFromEmailID.ToString().Trim() != "")
            {
                if (strEmailId.IndexOf(strFromEmailID.ToString().Trim()) == -1)
                    strCCToEmailID = strFromEmailID;
            }
            if (strEmailId.ToString().Trim() != "")
                strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","));
            if (strListOfEmployeeNames.ToString().Trim() != "")
                strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","));
            strMessage.Replace("<NAME>", strListOfEmployeeNames);
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strToEmailID = strEmailId;
            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage_484(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intModuleID, string strProjectID, string strEmployeeID)
        {
            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;
            string strProjectName = "";
            string strModuleName = "";
            string strQuery, strEmailId = "", strListOfEmployeeNames = "";
            IDataReader objDr;
            DataTable objSPDr;
            DataTable objSPDr1;
            IDataReader drTempWork;
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 484;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            //Get from email id.. ID of the person who verified the timesheet
            //GetEmployeeInfo(intEmployeeID, ref strUserName, ref strFromEmailID);


            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID.ToString();
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString().Trim();
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString().Trim();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }


            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            strMessage = new StringBuilder("");
            strEmailSubject = new StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            GetModuleInfo(Convert.ToInt32(strProjectID), ref strProjectName, ref strModuleName, intModuleID);
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<MODULE_NAME>", strModuleName);
            strEmailSubject.Replace("<MODULE_NAME>", strModuleName);



            // Get the info about Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(strEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);

            // Get the info about EmailID for TO section

            strQuery = Convert.ToString("usp_Sel_tbl_PM_Module_MailTo " + intModuleID + ",") + Convert.ToInt32(strProjectID);
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                while (drTempWork.Read())
                {
                    if (drTempWork["EmailID"].ToString().Trim() != "")
                    {
                        if (strEmailId.IndexOf(drTempWork["EmailID"].ToString().Trim()) == -1)
                        {
                            strEmailId = Convert.ToString(strEmailId) + drTempWork["EmailID"].ToString().Trim() + ",";
                            strListOfEmployeeNames = Convert.ToString(strListOfEmployeeNames) + drTempWork["EmployeeName"].ToString().Trim() + ",";
                        }
                    }

                }
            }
            if (strFromEmailID.ToString().Trim() != "")
            {
                if (strEmailId.IndexOf(strFromEmailID.ToString().Trim()) == -1)
                    strCCToEmailID = strFromEmailID;
            }
            if (strEmailId.ToString().Trim() != "")
                strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","));
            if (strListOfEmployeeNames.ToString().Trim() != "")
                strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","));
            strMessage.Replace("<NAME>", strListOfEmployeeNames);
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strToEmailID = strEmailId;
            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage_487(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intMilestoneID, string intProjectID, int intEmployeeID)
        {
            string strUserName = "";
            string strProjectName = "";
            string strMileStoneName = "";
            IDataReader drTempWork;
            string strQuery = "";
            string strEmailId = "";
            int intMessageID = 0;
            string strListOfEmployeeNames = "";

            intMessageID = 487;
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            //Get the message body, and subject.

            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);


                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //Get the info about Project and Module.

            GetMilestoneInfo(Convert.ToInt32(intProjectID), ref strProjectName, ref strMileStoneName, Convert.ToInt32(intMilestoneID));
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<MILESTONE_NAME>", strMileStoneName);
            strEmailSubject.Replace("<MILESTONE_NAME>", strMileStoneName);

            // Get the info about Sender.

            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(intEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);

            // Get the info about EmailID for TO section

            strQuery = Convert.ToString("usp_Sel_tbl_PM_Milestone_MailTo " + intMilestoneID + ",") + Convert.ToInt32(intProjectID);
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                while (drTempWork.Read())
                {
                    if (drTempWork["EmailID"].ToString().Trim() != "")
                    {
                        if (strEmailId.IndexOf(drTempWork["EmailID"].ToString().Trim()) == -1)
                        {
                            strEmailId = Convert.ToString(strEmailId) + drTempWork["EmailID"].ToString().Trim() + ",";
                            strListOfEmployeeNames = Convert.ToString(strListOfEmployeeNames) + drTempWork["EmployeeName"].ToString().Trim() + ",";
                        }
                    }
                }
            }
            if (strFromEmailID.ToString().Trim() != "")
            {
                if (strEmailId.IndexOf(strFromEmailID.ToString().Trim()) == -1)
                    strCCToEmailID = strFromEmailID;
            }
            // strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","))
            // strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","))
            if (strEmailId.ToString().Trim() != "")
                strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","));
            if (strListOfEmployeeNames.ToString().Trim() != "")
                strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","));

            strMessage.Replace("<NAME>", strListOfEmployeeNames);
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strToEmailID = strEmailId;
            strMessage = null;
            strEmailSubject = null;

        }

        public static void GetEmailMessage_488(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intMilestoneID, string intProjectID, int intEmployeeID)
        {
            string strUserName = "";
            string strProjectName = "";
            string strMileStoneName = "";
            IDataReader drTempWork;
            string strQuery = "";
            string strEmailId = "";
            int intMessageID = 0;
            string strListOfEmployeeNames = "";

            intMessageID = 488;
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            //Get the message body, and subject.

            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);


                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //Get the info about Project and Module.

            GetMilestoneInfo(Convert.ToInt32(intProjectID), ref strProjectName, ref strMileStoneName, Convert.ToInt32(intMilestoneID));
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<MILESTONE_NAME>", strMileStoneName);
            strEmailSubject.Replace("<MILESTONE_NAME>", strMileStoneName);

            // Get the info about Sender.

            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(intEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);

            // Get the info about EmailID for TO section

            strQuery = Convert.ToString("usp_Sel_tbl_PM_Milestone_MailTo " + intMilestoneID + ",") + Convert.ToInt32(intProjectID);
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                while (drTempWork.Read())
                {
                    if (drTempWork["EmailID"].ToString().Trim() != "")
                    {
                        if (strEmailId.IndexOf(drTempWork["EmailID"].ToString().Trim()) == -1)
                        {
                            strEmailId = Convert.ToString(strEmailId) + drTempWork["EmailID"].ToString().Trim() + ",";
                            strListOfEmployeeNames = Convert.ToString(strListOfEmployeeNames) + drTempWork["EmployeeName"].ToString().Trim() + ",";
                        }
                    }
                }
            }
            if (strFromEmailID.ToString().Trim() != "")
            {
                if (strEmailId.IndexOf(strFromEmailID.ToString().Trim()) == -1)
                    strCCToEmailID = strFromEmailID;
            }
            // strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","))
            // strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","))
            if (strEmailId.ToString().Trim() != "")
                strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","));
            if (strListOfEmployeeNames.ToString().Trim() != "")
                strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","));

            strMessage.Replace("<NAME>", strListOfEmployeeNames);
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strToEmailID = strEmailId;
            strMessage = null;
            strEmailSubject = null;

        }


        //(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.Comment, sendEmailParameters.ProjectID, sendEmailParameters.EmployeeID);

        public static void GetEmailMessage_470(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string Comment, string ProjectID, string EmployeeID,string RoleID)
        {
            // =====================================================================
            // Procedure Name		:	GetEmailMessage_470 (PROJECT Reopen)
            // Parameters Passed     :	strToEmailID		:- The EmailID of the person to whom the message will be returned.
            // strSubject		:- The Subject of the Email Message.
            // strEmailMessage	:- The body of the Email Message.	
            // Returns               :	
            // Parameters Affected   :	strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
            // Description           :	Generate the email message as defined in the System Email Messages table in the database.
            // Purpose               :	Generate the email message as defined in the System Email Messages table in the database.
            // Assumptions           :	The message ID exists in the database.
            // The message does not contain any other parameters besides the following :
            // 1.	<NAME>
            // 2.	<SENDER_NAME>
            // 3.	<PROJECT_NAME> 
            // 4.	<DESIGNATION>
            // 5.	<EXPERIENCE>	
            // Dependencies          :	None.
            // Author                :	Jayavant
            // Created               :	12-Mar-2004
            // Revisions             :
            // =====================================================================	

            string strUserName = "";
            string strProjectName = "";
            IDataReader drTempWork;
            string strQuery = "";
            int intEmployeeYears = 0;
            int intEmployeeMonths = 0;
            string strDescription = "";
            string strEmailId = "";

            int intCtr = 0;

            string strEmployeeExperience = "";
            string strEmployeeName = "";
            string strListOfEmployeeIDs = "";
            string strListOfEmployeeNames = "";
            string strListOfEmailIDs = "";
            string[] strTempArray;
            int intMessageID = 0;
            string strReopenComment;
            // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;
            // end of addition by SnehalV

            intMessageID = 470;

            // Get the message body, and subject.
            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID.ToString();
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery,true,CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString().Trim();
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString().Trim();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                    strListOfEmployeeIDs = drTempWork["ListOfEmployees"].ToString().Trim();
                    strListOfEmployeeIDs = CommonFunctions.General.UnBuildQueryString(strListOfEmployeeIDs);
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);

            // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
            // 2. Code for String Builder Changes - IssueID - 6052 
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);
            // end of addition by SnehalV

            // Retrieve information about the Project.
            GetProjectInfo(ref strProjectName, ref strCCToEmailID,Convert.ToInt32(ProjectID) ,intMessageID, EmployeeID);
            // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
            // 3. Code for String Builder Changes - IssueID - 6052 
            // strEmailMessage = Replace(strEmailMessage, "<PROJECT_NAME>", strProjectName)
            // strSubject = Replace(strSubject, "<PROJECT_NAME>", strProjectName)
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            // end of addition by SnehalV

            // Modified By RajaniR on 27th February 2002.
            GetSenderInfo(ref strFromEmailID,EmployeeID);
            // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
            // 3. Code for String Builder Changes - IssueID - 6052 
            // strEmailMessage = Replace(strEmailMessage, "<SENDER_NAME>", strUserName)
            strMessage.Replace("<SENDER_NAME>", strUserName);
            // end of addition by SnehalV

            strQuery = "usp_Sel_tbl_PM_Role " + RoleID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {       
                if (drTempWork.Read())
                    // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
                    // 3. Code for String Builder Changes - IssueID - 6052 
                    // strEmailMessage = Replace(strEmailMessage, "<DESIGNATION>", CommonFunctions.General.UnBuildQueryString(drTempWork["RoleDescription").ToString().Trim()))
                    strMessage.Replace("<DESIGNATION>", CommonFunctions.General.UnBuildQueryString(drTempWork["RoleDescription"].ToString().Trim()));
            }
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);

            // Retrieve information about the experience gained by the employees in the various tools used in the project.
            strQuery = "Exec usp_Sel_tbl_PM_EmployeeSkillMatrix_Detail " + ProjectID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                while (drTempWork.Read())
                {
                    intEmployeeYears = System.Convert.ToInt32("0" + CommonFunctions.Data.CheckIsDBNull(drTempWork["YearsOfExperience"]).ToString());
                    intEmployeeMonths = System.Convert.ToInt32("0" + CommonFunctions.Data.CheckIsDBNull(drTempWork["MonthsOfExperience"]).ToString());
                    strUserName = drTempWork["UserName"].ToString().Trim();
                    strUserName = CommonFunctions.General.UnBuildQueryString(strUserName);
                    strDescription = drTempWork["Description"].ToString().Trim();
                    strDescription = CommonFunctions.General.UnBuildQueryString(strDescription);

                    // Display the employee name.
                    if (strEmployeeName != strUserName)
                    {
                        strEmployeeExperience = strEmployeeExperience + strUserName;
                        strEmployeeName = strUserName;
                    }
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);

            // Insert the formatted experience in the mail body.

            // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
            // 3. Code for String Builder Changes - IssueID - 6052 
            // strEmailMessage = Replace(strEmailMessage, "<EXPERIENCE>", strEmployeeExperience)
            strMessage.Replace("<EXPERIENCE>", strEmployeeExperience);
            // end of addition by SnehalV


            // Get the list of employees to whom the mail must be sent.
            strTempArray = Strings.Split(strListOfEmployeeIDs, ",");

            for (intCtr = Information.LBound(strTempArray); intCtr <= Information.UBound(strTempArray); intCtr++)
            {
                if (Strings.Trim(strTempArray[intCtr] + "") != "")
                {
                    strQuery = "usp_tbl_Sel_EmployeeInfo " + strTempArray[intCtr];
                    drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                    if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
                    {
                        if (drTempWork.Read())
                        {
                            strEmailId = CommonFunctions.General.UnBuildQueryString(drTempWork["EmailID"].ToString().Trim());
                            strListOfEmployeeNames += CommonFunctions.General.UnBuildQueryString(drTempWork["UserName"].ToString().Trim()) + ",";
                            if (strEmailId != "")
                                strListOfEmailIDs += strEmailId + ";";
                        }
                    }
                    CommonFunctions.Data.DisposeDataReader(ref drTempWork);
                }
            }

            // Commented by TruptiK on 6-Oct-2007

            // If Right(strListOfEmployeeNames, 2) = ", " Then

            // strListOfEmployeeNames = Left(strListOfEmployeeNames, Len(strListOfEmployeeNames) - 2)

            // End If

            // If Trim(strListOfEmployeeNames) = "" Then

            strListOfEmployeeNames = "All";

            // End If

            // End of commented by TruptiK


            strToEmailID = strListOfEmailIDs;
            // Added by TruptiK on 9-Sep-2007
            // Purpose:-To add IDS of Resources configure in configuration.
            // strToEmailID = CommonFunction.General.CheckIsNothing(CType(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_PM_ToMailList_ProjectClosure " + HttpContext.Current.Session("intProjectID").ToString(), True), String), "")
            strToEmailID = CommonFunctions.General.CheckIsNothing(System.Convert.ToString(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_PM_ToMailList_ProjectClosure " + ProjectID + ", 470", true, CommonController.connectionString)), "");
            strCCToEmailID = CommonFunctions.General.CheckIsNothing(System.Convert.ToString(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_PM_CCMailList_ProjectClosure " + ProjectID, true, CommonController.connectionString)), "");
            strReopenComment = CommonFunctions.General.CheckIsNothing(System.Convert.ToString(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_tbl_PM_ProjectClosureComments " + ProjectID, true, CommonController.connectionString)), "");

            // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
            // 3. Code for String Builder Changes - IssueID - 6052 
            // strEmailMessage = Replace(strEmailMessage, "<REOPEN_COMMENT>", strReopenComment)
            // strEmailMessage = Replace(strEmailMessage, "<NAME>", strListOfEmployeeNames)
            strMessage.Replace("<REOPEN_COMMENT>", strReopenComment);
            strMessage.Replace("<NAME>", strListOfEmployeeNames);
            // end of addition by SnehalV

            // Addition By SnehalV for WhizibleSEM SP8 integration on 2nd Nov 2006
            // 4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;
        }


        public static void GetEmailMessage_471(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intScheduleID, string intProjectID, string intEmployeeID)
        {
            string strUserName = "";
            string strProjectName = "";
            string strMileStoneName = "";
            IDataReader drTempWork;
            string strQuery = "";
            string strEmailId = "";
            int intMessageID = 471;
            string strListOfEmployeeNames = "";


            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            string strRequestedBy = "";
            //string strProjectName = "";
            string strResponsiblePerson = "";
            string strResponsiblePersonName = "";
            // string intProjectID = "";

            string strStartDate = "";
            string strEarliestCompletionDate = "";
            string strTitle = "";
            string strEstimatedEfforts = "";
            string strRequestedByEmailID = "";
            //Get the message body, and subject.

            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);


                }
            }


            strQuery = "usp_Sel_tbl_PM_ProjectDeliverables " + intProjectID + "," + intScheduleID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strTitle = drTempWork["Title"].ToString() + "";
                    strRequestedBy = drTempWork["RequestedBy"].ToString() + "";
                    strRequestedByEmailID = drTempWork["RequestedByEmailID"].ToString() + "";
                    strResponsiblePerson = drTempWork["ResponsiblePerson"].ToString() + "";
                    strStartDate = drTempWork["StartDate"].ToString() + "";
                    strEarliestCompletionDate = drTempWork["EarliestStartDate"].ToString() + "";
                    strEstimatedEfforts = drTempWork["EstimatedEffortsInDays"].ToString() + "";
                    strResponsiblePersonName = drTempWork["ResponsiblePersonName"].ToString() + "";

                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //Get the info about Project and Module.

            strEmailMessage = funcGetEmailMessageForProject(Convert.ToInt32(intProjectID), intMessageID, ref strSubject);
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(intEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);

            if (intProjectID != "0")
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, Convert.ToInt32(intProjectID), Convert.ToInt32(intMessageID), intEmployeeID.ToString());
            }
            else
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, Convert.ToInt32(intProjectID), intMessageID, intEmployeeID.ToString());
            }



            if (strCCToEmailID != "" && strRequestedByEmailID != "")
            {
                //strCCToEmailID = strCCToEmailID + ";" + strRequestedByEmailID + ";";
                //strCCToEmailID = strCCToEmailID + ";";
            }
            else if (strCCToEmailID == "" && strRequestedByEmailID != "")
            {

                //strCCToEmailID = strCCToEmailID + strRequestedByEmailID + ";";
                strCCToEmailID = strRequestedByEmailID + ";";
            }
            //else if (strCCToEmailID == "" )
            //{

            //    strCCToEmailID = strCCToEmailID + strRequestedByEmailID + ";";
            //    //strCCToEmailID = strCCToEmailID + ";";
            //}



            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<TITLE>", strTitle);
            strEmailSubject.Replace("<TITLE>", strTitle);

            // Get the info about Sender.


            //   strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<TITLE>", strTitle);
            strMessage.Replace("<START_DATE>", strStartDate);
            strMessage.Replace("<END_DATE>", strEarliestCompletionDate);
            strMessage.Replace("<EFFORTS>", strEstimatedEfforts);
            strMessage.Replace("<RESPONSIBLE_PERSON>", strResponsiblePersonName);

            if (strResponsiblePersonName != "")
            {
                strToEmailID = strToEmailID + strResponsiblePerson + ";";
            }
            else
            {
                strToEmailID = strToEmailID + strResponsiblePerson;
            }




            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strToEmailID = strToEmailID;
            strMessage = null;
            strEmailSubject = null;

        }

        public static void GetEmailMessage_439(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intScheduleID, string intProjectID, string intEmployeeID)
        {
            string strUserName = "";
            string strProjectName = "";
            string strMileStoneName = "";
            IDataReader drTempWork;
            string strQuery = "";
            string strEmailId = "";
            int intMessageID = 439;
            string strListOfEmployeeNames = "";
            string strMailToEmployeeIDList = "";
            //string strMailCCToEmployeeIDList = "";

            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            bool blnShowToCustomer = false;
            //string strMailToEmployeeIDList = "";
            string strRequestedByEmailID = "";
            string strMailCCToEmployeeIDList = "";
            IDataReader drEmployee;

            // string intProjectID = "";

            string Status = "";
            string IssueType = "";
            string strTitle = "";

            //Get the message body, and subject.

            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);


                }
            }


            strQuery = "usp_Sel_tbl_PM_Deliverable_IssUeType " + intScheduleID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strTitle = drTempWork["Title"].ToString() + "";
                    Status = drTempWork["Status"].ToString() + "";
                    IssueType = drTempWork["IssueType"].ToString() + "";


                }
            }




            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //Get the info about Project and Module.

            strEmailMessage = funcGetEmailMessageForProject(Convert.ToInt32(intProjectID), intMessageID, ref strSubject);
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(intEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);

            if (intProjectID != "0")
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, Convert.ToInt32(intProjectID), Convert.ToInt32(intMessageID), intEmployeeID.ToString());
            }
            else
            {
                GetProjectInfo(ref strProjectName, ref strCCToEmailID, Convert.ToInt32(intProjectID), intMessageID, intEmployeeID.ToString());
            }



            //if (strCCToEmailID != "" && strRequestedByEmailID != "")
            //{
            //    strCCToEmailID = strCCToEmailID + ";" + strRequestedByEmailID + ";";
            //}
            //else if (strCCToEmailID == "" && strRequestedByEmailID != "")
            //{

            //    strCCToEmailID = strCCToEmailID + strRequestedByEmailID + ";";
            //}


            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<TITLE>", strTitle);
            strEmailSubject.Replace("<TITLE>", strTitle);

            // Get the info about Sender.


            //   strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<STATUS>", Status);
            DateTime now = DateTime.Now;
            strMessage.Replace("<DATE>", now.ToString());



            strQuery = "usp_Sel_tbl_IB_IssueBaseMails NULL ," + intProjectID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strMailToEmployeeIDList = drTempWork["MailToEmployeeIDList"].ToString() + "";
                    strMailCCToEmployeeIDList = drTempWork["MailCCToEmployeeIDList"].ToString() + "";


                }
            }


            if (intProjectID != "0")
            {
                //Added & Commented By dipali V On 16th Sep 2019 For NEW SP
                //drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);
                drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + intProjectID, true, CommonController.connectionString);
                //End of Added & Commented By dipali V On 16th Sep 2019 For NEW SP
            }
            else
            {
                //Added & Commented By dipali V On 16th Sep 2019 For NEW SP
                //drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueBaseMails_EmployeeList " + IssueProjectID, true, CommonController.connectionString);
                drEmployee = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_IB_IssueBaseMails_EmployeeList " + intProjectID, true, CommonController.connectionString);
                //End of Added & Commented By dipali V On 16th Sep 2019 For NEW SP
            }
            while (drEmployee.Read())
            {
                if (drEmployee["EmailID"].ToString().Trim() != "")
                {
                    if (blnShowToCustomer == true || (blnShowToCustomer == false && (drEmployee["ResourceType"].ToString() == "E" || drEmployee["ResourceType"].ToString() == "CE")))
                    {
                        if (strMailToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                        {
                            if (strToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                            {
                                strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + ";";
                            }
                        }
                        if (strMailCCToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                        {
                            if (strCCToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                            {

                                if (strCCToEmailID == "")
                                {
                                    //Added & Commented By Dipali V On Removed Extra Space
                                    //strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();
                                    strCCToEmailID = strCCToEmailID + ";" + drEmployee["EmailID"].ToString().Trim();
                                    //End of Added & Commented By Dipali V On Removed Extra Space
                                }
                                else
                                {
                                    strCCToEmailID = drEmployee["EmailID"].ToString().Trim();
                                }
                            }
                        }
                    }
                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drEmployee);
            string strResponsiblePerson = "";
            strQuery = "usp_Sel_tbl_PM_ProjectDeliverables " + intProjectID + "," + intScheduleID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strResponsiblePerson = drTempWork["ResponsiblePerson"].ToString() + "";
                    if (strResponsiblePerson != "")
                    {
                        strToEmailID += strResponsiblePerson + ";";

                    }

                }
            }




            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strToEmailID = strToEmailID;
            strMessage = null;
            strEmailSubject = null;

        }
       

        private static void GetModuleInfo(int lngProjectID, ref string strProjectName, ref string strModuleName, string lngModuleID)
        {
            IDataReader objDr;
            string strSQL;
            bool blnUseSQL;

            blnUseSQL = System.Convert.ToBoolean(true);

            // retrieve info about the project
            strSQL = "usp_Sel_tbl_PM_Project " + lngProjectID.ToString();
            objDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
                strProjectName = objDr["ProjectName"].ToString() + "";
            CommonFunctions.Data.DisposeDataReader(ref objDr);
            // Retrieve info about module
            strSQL = "usp_Sel_tbl_PM_Module " + lngProjectID.ToString() + "," + lngModuleID.ToString();
            objDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
                strModuleName = objDr["ModuleName"].ToString() + "";
            CommonFunctions.Data.DisposeDataReader(ref objDr);
        }

        private static void GetMilestoneInfo(int lngProjectID, ref string strProjectName, ref string strMilestoneName, int lngMilestoneID)
        {
            IDataReader objDr;
            string strSQL;
            //bool blnUseSQL;

            //blnUseSQL = Convert.ToBoolean(General.GetApplicationKeySetting("UseSQL"));

            // retrieve info about the project
            strSQL = "usp_Sel_tbl_PM_Project " + lngProjectID.ToString();
            objDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
                strProjectName = objDr["ProjectName"].ToString() + "";
            CommonFunctions.Data.DisposeDataReader(ref objDr);
            // Retrieve info about module
            strSQL = "usp_Sel_tbl_PM_Milestone " + lngMilestoneID.ToString();
            objDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (objDr.Read())
                strMilestoneName = objDr["Milestone"].ToString() + "";
            CommonFunctions.Data.DisposeDataReader(ref objDr);
        }

        public static void GetEmailMessage_485(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intSubProjectID, int intProjectID, int intEmployeeID)
        {

            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;
            string ProjectName = "";
            string SubProjectName = "";
            IDataReader objDr;
            DataTable objSPDr;
            DataTable objSPDr1;
            string strEmailId = "";
            string strListOfEmployeeNames = "";
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 485;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            //Get from email id.. ID of the person who verified the timesheet
            GetEmployeeInfo(intEmployeeID, ref strUserName, ref strFromEmailID);


            objDr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + intProjectID + "", true, CommonController.connectionString);
            if (objDr.Read())
            {
                ProjectName = objDr["ProjectName"].ToString() + "";
            }

            objSPDr = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_SubProject_MailTo " + intSubProjectID + "," + intProjectID + "", true, CommonController.connectionString);
            foreach (DataRow sdr in objSPDr.Rows)
            {
                strToEmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EmailID"], ""));
                //Added By Nikhil A
                strListOfEmployeeNames = strListOfEmployeeNames + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EmployeeName"], ""));
                //End Of Added By Nikhil A
            }

            objSPDr1 = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_SubProject " + intProjectID + "," + intSubProjectID + "", true, CommonController.connectionString);
            foreach (DataRow sdr in objSPDr1.Rows)
            {
                SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["SubProjectName"], ""));
            }

            CommonFunctions.Data.DisposeDataReader(ref objDr);
            objSPDr1.Dispose();
            objSPDr.Dispose();

            strMessage.Replace("<SENDER_NAME>", strUserName);
            strEmailSubject.Replace("<PROJECT_NAME>", ProjectName);
            strEmailSubject.Replace("<SUBPROJECT_NAME>", SubProjectName);
            strMessage.Replace("<PROJECT_NAME>", ProjectName);
            strMessage.Replace("<SUBPROJECT_NAME>", SubProjectName);
            //strMessage.Replace("<NAME>", strUserName);



            if (strFromEmailID.ToString().Trim() != "")
            {
                if (strEmailId.IndexOf(strFromEmailID.ToString().Trim()) == -1)
                    strCCToEmailID = strFromEmailID;
            }
            // strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","))
            // strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","))
            if (strEmailId.ToString().Trim() != "")
                strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","));
            if (strListOfEmployeeNames.ToString().Trim() != "")
            {
                if(strListOfEmployeeNames.LastIndexOf(",") > -1)
                {
                    strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","));
                }
                
            }
               

            strMessage.Replace("<NAME>", strListOfEmployeeNames);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }

        //Added By  Dipali V On 14th  Oct 2021 For Ready for billing milestone
        public static void GetEmailMessage_22(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intMilestoneID, string strProjectID, string strEmployeeID)
        {
            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;

            string strProjectName = "";
            string strModuleName = "";
            string strQuery, strEmailId = "", strListOfEmployeeNames = "";
            IDataReader objDr;
            IDataReader objDr1;
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 22;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);
            string strMileStoneName = "";

            //Get from email id.. ID of the person who verified the timesheet

            GetProjectInfo(ref strProjectName, ref strCCToEmailID, Convert.ToInt32(strProjectID), intMessageID, strEmployeeID.ToString());
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(strEmployeeID));

            strMessage.Replace("<SENDER_NAME>", strUserName);
            objDr1 = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + strProjectID, true, CommonController.connectionString);

            int intAuthenticatorID = 0;
            if (objDr1.Read())
                intAuthenticatorID = Convert.ToInt32(objDr1["TimeSheetAuthenticatorID"]);
                if (intAuthenticatorID !=0)
                {
                GetEmployeeInfo(intAuthenticatorID, ref strUserName, ref strToEmailID);
                    strMessage.Replace("<NAME>", strUserName);
                }
                else
                {
                    strMessage.Replace("<NAME>", "All");
                }
          

            string strSQL = "";
            if (intMilestoneID != "0") {

                strSQL = "usp_Sel_tbl_PM_Milestone " + intMilestoneID.ToString();
                objDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (objDr.Read())
                    strMileStoneName = objDr["Milestone"].ToString() + "";
            }
            // Retrieve information about the MILESTONE.
            GetMilestoneInfo(Convert.ToInt32(strProjectID), ref strProjectName, ref strMileStoneName, Convert.ToInt32(intMilestoneID));
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);
            strMessage.Replace("<MILESTONE_NAME>", strMileStoneName);
            strEmailSubject.Replace("<MILESTONE_NAME>", strMileStoneName);



            

            //CommonFunctions.Data.DisposeDataReader(ref drTempWork);
           // strMessage = new StringBuilder("");
           // strEmailSubject = new StringBuilder("");
            //strMessage.Append(strEmailMessage);
            //strEmailSubject.Append(strSubject);


            
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            //strToEmailID = strEmailId;
            strMessage = null;
            strEmailSubject = null;
        }



        public static void GetEmailMessage_486(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intSubProjectID, int intProjectID, int intEmployeeID)
        {
            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;
            string ProjectName = "";
            string SubProjectName = "";
            IDataReader objDr;
            DataTable objSPDr;
            DataTable objSPDr1;
            string strEmailId = "";
            string strListOfEmployeeNames = "";
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 486;

            // Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            //Get from email id.. ID of the person who verified the timesheet
            GetEmployeeInfo(intEmployeeID, ref strUserName, ref strFromEmailID);


            objDr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + intProjectID + "", true, CommonController.connectionString);
            if (objDr.Read())
            {
                ProjectName = objDr["ProjectName"].ToString() + "";
            }

            objSPDr = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_SubProject_MailTo " + intSubProjectID + "," + intProjectID + "", true, CommonController.connectionString);
            foreach (DataRow sdr in objSPDr.Rows)
            {
                strToEmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EmailID"], ""));
                //Added By Nikhil A
                strListOfEmployeeNames = strListOfEmployeeNames + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EmployeeName"], ""));
                //End Of Added By Nikhil A
            }

            objSPDr1 = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_SubProject " + intProjectID + "," + intSubProjectID + "", true, CommonController.connectionString);
            foreach (DataRow sdr in objSPDr1.Rows)
            {
                SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["SubProjectName"], ""));
            }

            CommonFunctions.Data.DisposeDataReader(ref objDr);
            objSPDr1.Dispose();
            objSPDr.Dispose();

            strMessage.Replace("<SENDER_NAME>", strUserName);
            strEmailSubject.Replace("<PROJECT_NAME>", ProjectName);
            strEmailSubject.Replace("<SUBPROJECT_NAME>", SubProjectName);
            strMessage.Replace("<PROJECT_NAME>", ProjectName);
            strMessage.Replace("<SUBPROJECT_NAME>", SubProjectName);
            //Commneted By Nikhil A
            //strMessage.Replace("<NAME>", strUserName);
            //End Of Commneted By Nikhil A
            if (strFromEmailID.ToString().Trim() != "")
            {
                if (strEmailId.IndexOf(strFromEmailID.ToString().Trim()) == -1)
                    strCCToEmailID = strFromEmailID;
            }
            // strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","))
            // strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","))
            if (strEmailId.ToString().Trim() != "")
                strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","));
            if (strListOfEmployeeNames.ToString().Trim() != "")
            {
                if(strListOfEmployeeNames.LastIndexOf(",") > -1)
                {
                    strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","));
                }
                
            }
             //End Of Modified By Nikhil A   

            strMessage.Replace("<NAME>", strListOfEmployeeNames);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }


        //For Task Details From Plan Deliverable page
        public static void GetEmailMessage_79(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string strParentTaskIDs, string intProjectID, string intEmployeeID, string strTitle, int LoginUserID)
        {
            string strUserName = "";
            string strListOfReceivers;
            int intMessageID;
            string strProjectName = "";
            // string SubProjectName = "";
            IDataReader objDr;

            string strEmailId = "";

            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 79;
            IDataReader drTempWork;
            string strQuery = "";
            // Get the message body, and subject.
            //strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            //strMessage.Append(strEmailMessage);
            //strEmailSubject.Append(strSubject);


            ////Get from email id.. ID of the person who verified the timesheet
            //GetEmployeeInfo(intEmployeeID, ref strUserName, ref strFromEmailID);


            objDr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + intProjectID + "", true, CommonController.connectionString);
            if (objDr.Read())
            {
                strProjectName = objDr["ProjectName"].ToString() + "";
            }


            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);


                }
            }
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strEmailSubject.Replace("<DELIVERABLE_NAME>", " New Task Assigned [Project :- " + strProjectName + "] [Deliverable :- " + strTitle + " ]");

            //GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(intEmployeeID));
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(LoginUserID));
            
            strMessage.Replace("<SENDER_NAME>", strUserName);


            IDataReader drEmployeeDetails;
            IDataReader drTaskInformation;
            strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
            drEmployeeDetails = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drEmployeeDetails) != "")
            {
                if (drEmployeeDetails.Read())
                {
                    strMessage.Replace("<NAME>", Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drEmployeeDetails["EmployeeName"], "")));


                    if (Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drEmployeeDetails["EmailID"], "")) != "")
                    {
                        strToEmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drEmployeeDetails["EmailID"], ""));
                    }
                    else
                    {
                        strToEmailID = "";
                    }

                }
            }


            int intCounter = 1;
            string strTaskDetails = "";
            strQuery = "usp_sel_tbl_PM_ProjectTasks_ResourceParentTaskWise " + intEmployeeID + ",'" + strParentTaskIDs + "'";
            drTaskInformation = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTaskInformation) != "")
            {
                if (drTaskInformation.Read())
                {
                    strTaskDetails += intCounter + ". " + " Task Name  : " + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drTaskInformation["TaskName"], ""));
                    strTaskDetails += "\n";
                    strTaskDetails += "Start Date" + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drTaskInformation["strStartDate"], ""));
                    strTaskDetails += "\n";
                    strTaskDetails += "End Date: " + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drTaskInformation["strEndDate"], ""));

                    intCounter += 1;

                }
            }




            //strMessage.Replace("<NAME>", strListOfEmployeeNames);
            strMessage.Replace("<TASK_INFORMATION>", strTaskDetails);
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }

        //Added By  Dipali V On 8th Frb 2021 For Re-Assign Resource Mail
        //public static void GetEmailMessage_15(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intProjectEmployeeRoleID, string intProjectID, string intUserID)
        public static void GetEmailMessage_15(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intProjectEmployeeRoleID, string intProjectID, string intUserID, string intEmployeeID)
        {
            string strUserName = "";
            string strProjectName = "";
            IDataReader drTask;
            int intMessageID;
            string strSQL;
            string strTeamMemberList = "";

            //Initialize the variables.
            strFromEmailID = "";
            strToEmailID = "";
            strCCToEmailID = "";

            StringBuilder strMessage = new StringBuilder();

            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 15;

            //Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(Convert.ToInt32(intProjectID), intMessageID, ref strSubject);

            strMessage = new StringBuilder();

            strEmailSubject = new StringBuilder();

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //Retrieve information about the Project.
            GetProjectInfo(ref strProjectName, ref strCCToEmailID, Convert.ToInt32(intProjectID), intMessageID, intUserID);

            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);

            //Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, intUserID);
            strMessage.Replace("<SENDER_NAME>", strUserName);
            GetEmployeeInfo(Convert.ToInt32(intEmployeeID), ref strUserName, ref strToEmailID);
            strMessage.Replace("<NAME>", strUserName);
            if (intProjectEmployeeRoleID.Trim() == "")
            {
                return;
            }

            strSQL = "Exec usp_Sel_tbl_PM_Role " + intProjectEmployeeRoleID;
            drTask = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTask) != "")
            {
                if (drTask.Read())
                {

                    strMessage.Replace("<ROLE_NAME>", drTask["RoleDescription"].ToString() + "");
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTask);

            strSQL = "Exec usp_Sel_EmployeeEmailAddresses " + intProjectID;
            drTask = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTask) != "")
            {
                while (drTask.Read())
                {
                    if (drTask["EmployeeID"].ToString() != intEmployeeID)
                    {
                        //strMessage.Replace("<NAME>", drTask["EmployeeName"].ToString() + "");
                        // strToEmailID = drTask["EmailID"].ToString() + "";
                        if (strTeamMemberList != "")
                        {
                            strTeamMemberList = strTeamMemberList + CommonFunctions.Data.CheckIsDBNull(drTask["EmployeeName"]).ToString() + "= " + CommonFunctions.Data.CheckIsDBNull(drTask["RoleDescription"]).ToString() + Environment.NewLine;
                        }
                        else
                        {
                            strTeamMemberList = CommonFunctions.Data.CheckIsDBNull(drTask["EmployeeName"]).ToString() + "= " + CommonFunctions.Data.CheckIsDBNull(drTask["RoleDescription"]).ToString() + Environment.NewLine;

                        }
                    }
                }


            }
            strMessage.Replace("<TEAM_MEMBERS>", strTeamMemberList);

            CommonFunctions.Data.DisposeDataReader(ref drTask);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;

        }
        //End of Added By  Dipali V On 8th Frb 2021 For Re-Assign Resource Mail

        //Added By Reshma on 4th Nov 2019 For Resource Release
        public static void GetEmailMessage_16(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intProjectEmployeeRoleID, string intProjectID, string intUserID)
        {
            string strUserName = "";
            string strProjectName = "";
            IDataReader drTask;
            int intMessageID;
            string strSQL;


            //Initialize the variables.
            strFromEmailID = "";
            strToEmailID = "";
            strCCToEmailID = "";

            StringBuilder strMessage = new StringBuilder();

            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 16;

            //Get the message body, and subject.
            strEmailMessage = funcGetEmailMessageForProject(Convert.ToInt32(intProjectID), intMessageID, ref strSubject);

            strMessage = new StringBuilder();
            strEmailSubject = new StringBuilder();

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            //Retrieve information about the Project.
            GetProjectInfo(ref strProjectName, ref strCCToEmailID, Convert.ToInt32(intProjectID), intMessageID, intUserID);

            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);

            //Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, intUserID);
            strMessage.Replace("<SENDER_NAME>", strUserName);

            if (intProjectEmployeeRoleID.Trim() == "")
            {
                return;
            }

            strSQL = "Exec usp_Sel_EmployeeEmailAddresses_New " + intProjectEmployeeRoleID;
            drTask = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTask) != "")
            {
                if (drTask.Read())
                {

                    strMessage.Replace("<NAME>", drTask["EmployeeName"].ToString() + "");
                    strToEmailID = drTask["EmailID"].ToString() + "";
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTask);

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;

        }
        //Added By Reshma 23-Dec-2019
        //Prepone Release
        public static void GetEmailMessage_498(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string strResourceRequestID, string intProjectID, string intUserID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            IDataReader drApprover;

            //Code for String Builder Changes - IssueID - 6052                
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 498;

            //1.Get the message body, and subject.

            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages " + intMessageID, true, CommonController.connectionString);
            if (drEmailMessage.Read())
            {
                strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString() + "";
                strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString() + "";
            }


            //2.Code for String Builder Changes - IssueID - 6052 

            strMessage = new StringBuilder();
            strEmailSubject = new StringBuilder();

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            drResourseRequest = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_ResourcePreponeRequestDetails " + strResourceRequestID, true, CommonController.connectionString);
            if (drResourseRequest.Read())
            {
                strEmailSubject.Replace("<REQUESTID>", Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<REQUESTID>", Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                strMessage.Replace("<STARTDATE>", Data.CheckIsDBNull(drResourseRequest["FromDate"], "").ToString());
                strMessage.Replace("<PENDDATE>", Data.CheckIsDBNull(drResourseRequest["ToDate"], "").ToString());
                strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<RESOURCENAME>", Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());
                strMessage.Replace("<ENDDATE>", Data.CheckIsDBNull(drResourseRequest["EndDate"], "").ToString());
                strMessage.Replace("<SENDER>", drResourseRequest["Requestor"].ToString());
                strFromEmailID = drResourseRequest["EmailID"].ToString() + "";
                strCCToEmailID = strFromEmailID;
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            strToEmailID = "";
            drApprover = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_Employee_ResourceRequest_EmailTo " + strResourceRequestID, true, CommonController.connectionString);
            while (drApprover.Read())
                strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";

            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            if (strToEmailID != "")
            {
                strToEmailID = strToEmailID.Trim();
                strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
            }

            //4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            //5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;

        }


        //Change Allocation
        public static void GetEmailMessage_543(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string strResourceRequestID, string intProjectID, string intUserID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            IDataReader drApprover;



            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();


            intMessageID = 543;

            // Get the message body, and subject.
            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages " + intMessageID, true, CommonController.connectionString);
            if (drEmailMessage.Read())
            {
                strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"], "").ToString();
                strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"], "").ToString();
            }


            strMessage = new StringBuilder();
            strEmailSubject = new StringBuilder();

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            drResourseRequest = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_ResourcepreponeRequestDetails " + strResourceRequestID, true, CommonController.connectionString);
            if (drResourseRequest.Read())
            {
                strEmailSubject.Replace("<REQUESTID>", drResourseRequest["RequestID"].ToString());
                strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<ENDDATE>", drResourseRequest["ToDate"].ToString());
                strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<RESOURCENAME>", Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());
                strMessage.Replace("<ALLOCATION>", Data.CheckIsDBNull(drResourseRequest["AllocationValue"], "0").ToString());
                strMessage.Replace("<SENDER>", drResourseRequest["Requestor"].ToString());
                strMessage.Replace("<STARTDATE>", drResourseRequest["FromDate"].ToString());
                strFromEmailID = drResourseRequest["EmailID"].ToString() + "";

                if (Convert.ToString(drResourseRequest["Type"]) == "HPD")
                {
                    strMessage.Replace("<ExtRequestType>", "Extra Work Hours Per Day");
                    strMessage.Replace("<RequestType>", "Per Day");
                }
                else if (drResourseRequest["Type"].ToString() == "TH")
                {
                    strMessage.Replace("<ExtRequestType>", "Extra Total Hours");
                    strMessage.Replace("<RequestType>", "Total Hours");
                }
                else if (drResourseRequest["Type"].ToString() == "P")
                {
                    strMessage.Replace("<ExtRequestType>", "Extra % Of Day");
                    strMessage.Replace("<RequestType>", "% Of Day");
                }

                strCCToEmailID = strFromEmailID;
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            strToEmailID = "";
            drApprover = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_Employee_ResourceRequest_EmailTo " + strResourceRequestID, true, CommonController.connectionString);
            while (drApprover.Read())
                strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";

            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            if (strToEmailID != "")
            {
                strToEmailID = strToEmailID.Trim();
                strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
            }
            strMessage.Replace("<NAME>", "");


            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }


        //Extend Booking
        public static void GetEmailMessage_80(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string strResourceRequestID, string intProjectID, string intUserID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            IDataReader drApprover;


            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 80;

            //Get the message body, and subject.
            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages " + intMessageID, true, CommonController.connectionString);
            if (drEmailMessage.Read())
            {
                strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"], "").ToString();
                strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"], "").ToString();

            }


            strMessage = new StringBuilder();
            strEmailSubject = new StringBuilder();

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            drResourseRequest = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_ResourcepreponeRequestDetails " + strResourceRequestID, true, CommonController.connectionString);
            if (drResourseRequest.Read())
            {
                strEmailSubject.Replace("<REQUESTID>", drResourseRequest["RequestID"].ToString());
                strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<ENDDATE>", drResourseRequest["ToDate"].ToString());
                strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<RESOURCENAME>", Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());
                strMessage.Replace("<WORKHOURS>", Data.CheckIsDBNull(drResourseRequest["WorkHours"], "0").ToString());
                strMessage.Replace("<SENDER>", drResourseRequest["Requestor"].ToString());
                strMessage.Replace("<STARTDATE>", drResourseRequest["FromDate"].ToString());
                strMessage.Replace("<CURRENTDATE>", drResourseRequest["EndDate"].ToString());
                strFromEmailID = drResourseRequest["EmailID"].ToString();
                strCCToEmailID = strFromEmailID;
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);


            strToEmailID = "";
            drApprover = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_Employee_ResourceRequest_EmailTo " + strResourceRequestID, true, CommonController.connectionString);
            while (drApprover.Read())
                strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";


            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            if (strToEmailID != "")
            {
                strToEmailID = strToEmailID.Trim();
                strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
            }
            strMessage.Replace("<NAME>", "");


            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }

        //End Added By Reshma For Resource Release 23-Dec-2019

        //////////////////////////////////////////////////////  WorkFlow //////////////////////////////////
        //Added By Rutuja On 4th Dec 2019 For Resource Request List Page Reject Resource
        public static void GetEmailMessage_203(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intEmployeeID, string intRequestID)
        {
            int intMessageID;

            string strQuery, strEmailId = "";

            IDataReader drAssignedResource;
            IDataReader drEmailMessage;
            IDataReader drApprover;
            IDataReader drResourseRequest;
            string strSkills;
            string strTemp;
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();

            intMessageID = 203;

            strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = drEmailMessage["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drEmailMessage["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            strQuery = "usp_Whizible2_sel_tbl_PM_ResourceRequestDetails " + intRequestID;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (drResourseRequest.Read())
            {
                strMessage.Replace("<SENDER>", drResourseRequest["Requestor"].ToString());
                strFromEmailID = drResourseRequest["EmailID"].ToString();
            }

            strQuery = "usp_Whizible2_Sel_RejectResourceDetails_ForEmailMessage " + intEmployeeID + "," + intRequestID;
            drAssignedResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);


            if (drAssignedResource.Read())
            {
                strMessage.Replace("<RESOURCE_NAME>", drAssignedResource["EmployeeName"].ToString());
                strEmailSubject.Replace("<RESOURCE_NAME>", drAssignedResource["EmployeeName"].ToString());
                strMessage.Replace("<REQUEST_ID>", drAssignedResource["RequestID"].ToString());
                strEmailSubject.Replace("<REQUEST_ID>", drAssignedResource["RequestID"].ToString());
                strMessage.Replace("<PROJECT_NAME>", drAssignedResource["ProjectName"].ToString());
                strMessage.Replace("<REASONS>", drAssignedResource["RejectComments"].ToString());
            }
            drAssignedResource.Close();

            strToEmailID = "";
            strCCToEmailID = "";

            strQuery = "usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailTo " + intRequestID;
            drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            while (drApprover.Read())
                strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";

            strQuery = "usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailCc " + intRequestID;
            drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            while (drApprover.Read())
                strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";

            if (strToEmailID != "")
            {
                strToEmailID = strToEmailID.Trim();
                strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
            }
            strCCToEmailID += strFromEmailID;

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;


        }
        //End Of Added By Rutuja
        //Added By Rutuja On 4th Dec 2019 For Resource Request List Page Assign Resource
        public static void GetEmailMessage_503(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intResourceRequestId, string strEmployeeIDs, string intUserID)
        {

            int intMessageID;
            string strQuery;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            IDataReader drApprover;
            int intToEmployeeID = 0;
            string strUserName = "";
            string strResource = "";
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 503;

            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = drEmailMessage["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drEmailMessage["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            strQuery = "usp_Whizible2_sel_tbl_PM_ResourcePreponeRequestDetails " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (drResourseRequest.Read())
            {
                strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());

                strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                intToEmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestorID"], "0"));

            }

            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            strQuery = "usp_Whizible2_Sel_Resourceforassignment " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            while (drResourseRequest.Read())
            {
                strResource += "";
                strResource += drResourseRequest["Resource"].ToString();
            }

            strMessage.Replace("<RESOURCES>", strResource);
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            GetSenderInfo(ref strUserName, ref strFromEmailID, intUserID.ToString());
            strMessage.Replace("<SENDER>", strUserName);
            strToEmailID = "";

            strQuery = "usp_Whizible2_Sel_tbl_PM_Employee_ResourceAssignment_EmailTo " + strEmployeeIDs;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            while (drResourseRequest.Read())
                strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ",";
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            strCCToEmailID = "";

            strCCToEmailID += strFromEmailID;

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;

        }
        //Added By Rutuja On 4th Dec 2019 For Resource Request List Page Send Email Functionality
        public static void GetEmailMessage_75(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intResourceRequestId)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            IDataReader drSkills;
            IDataReader drApprover;
            string strSkills = "";
            string strTemp;
            string strQuery;


            StringBuilder strMessage;
            StringBuilder strEmailSubject;

            intMessageID = 75;


            strQuery = "usp_Whizible2_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = drEmailMessage["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drEmailMessage["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            strQuery = "usp_Whizible2_sel_tbl_PM_ResourcePreponeRequestDetails " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (drResourseRequest.Read())
            {
                strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<NO>", drResourseRequest["NoOfResources"].ToString());
                strMessage.Replace("<FROMDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromDate"], "").ToString());
                strMessage.Replace("<TODATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ToDate"], "").ToString());
                strMessage.Replace("<ROLE>", drResourseRequest["Role"].ToString());
                strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                strMessage.Replace("<SENDER>", drResourseRequest["Requestor"].ToString());
                strMessage.Replace("<REQUESTID>", drResourseRequest["RequestID"].ToString());
                strFromEmailID = drResourseRequest["EmailID"].ToString();
            }

            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            drSkills = CommonFunctions.Data.GetDataReader("usp_Whizible2_sel_resourcesrequestkills " + intResourceRequestId.ToString(), true, CommonController.connectionString);

            while (drSkills.Read())
            {
                strSkills += "";
                strSkills += drSkills["Skills"].ToString();
            }

            strMessage.Replace("<SKILL>", strSkills);
            CommonFunctions.Data.DisposeDataReader(ref drSkills);

            strToEmailID = "";
            strCCToEmailID = "";
            drApprover = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailTo " + intResourceRequestId.ToString(), true, CommonController.connectionString);
            while (drApprover.Read())
                strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";
            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            drApprover = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailCc " + intResourceRequestId.ToString(), true, CommonController.connectionString);
            while (drApprover.Read())
                strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";
            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            //Commented and added by Chetan M on 8 Jul 2021 for get only Non Primary Responsible Person Mail in CC
            //drApprover = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailConfigureCc ", true, CommonController.connectionString);
            drApprover = CommonFunctions.Data.GetDataReader("Exec usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailConfigureCc " + intResourceRequestId.ToString(), true, CommonController.connectionString);
            //Commented and added by Chetan M on 8 Jul 2021 for get only Non Primary Responsible Person Mail in CC
            while (drApprover.Read())
                strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";
            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            if (strToEmailID != "")
            {
                strToEmailID = strToEmailID.Trim();
                strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);

            }
            strCCToEmailID += strFromEmailID;

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;
        }


        public static void GetEmailMessage_CloseProject_17(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intProjectID, int intEmployeeID, int intRoleID)
        {
            string strUserName = "";

            int intMessageID;
            string ProjectName = "";
            string Designation = "";

            IDataReader objDr;
            IDataReader drTempWork;
            DataTable objSPDr;

            string strEmailId = "";
            string strListOfEmployeeNames = "";
            string strListOfResources = "";

            string strDescription = "";
            string strEmployeeExperience = "";
            string strEmployeeName = "";
            string strListOfEmployeeIDs = "";
            //string strListOfEmployeeNames = "";
            string strListOfEmailIDs = "";
            intMessageID = 17;
            string strTempArray = "";
            string strQuery = "";
            // Get the message body, and subject.
            //strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

            //strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID.ToString();
            //    drTempWork = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            //    If CommonFunctions.General.CheckIsNothing(drTempWork) <> "" Then
            //        If drTempWork.Read() Then
            //            strEmailMessage = drTempWork.Item("Body").ToString().Trim()
            //            strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage)
            //            strSubject = drTempWork.Item("Subject").ToString().Trim()
            //            strSubject = CommonFunctions.General.UnBuildQueryString(strSubject)
            //            strListOfEmployeeIDs = drTempWork.Item("ListOfEmployees").ToString().Trim()
            //            strListOfEmployeeIDs = CommonFunctions.General.UnBuildQueryString(strListOfEmployeeIDs)
            //        End If
            //    End If

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID.ToString();
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString().Trim();
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString().Trim();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                    strListOfEmployeeIDs = drTempWork["ListOfEmployees"].ToString().Trim();
                    strListOfEmployeeIDs = CommonFunctions.General.UnBuildQueryString(strListOfEmployeeIDs);
                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            StringBuilder strMessage = new StringBuilder();
            StringBuilder strEmailSubject = new StringBuilder();
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            string strProjectName = "";
            GetProjectInfo(ref strProjectName, ref strCCToEmailID, intProjectID, intMessageID, intEmployeeID.ToString());
            strMessage.Replace("<PROJECT_NAME>", strProjectName);
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName);

            //Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(intEmployeeID));
            strMessage.Replace("<SENDER_NAME>", strUserName);


            //Get from email id.. ID of the person who verified the timesheet
            // GetEmployeeInfo(intEmployeeID, ref strUserName, ref strFromEmailID);
            strQuery = "usp_Sel_tbl_PM_Role " + intRoleID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strMessage.Replace("<DESIGNATION>", CommonFunctions.General.UnBuildQueryString(drTempWork["RoleDescription"].ToString().Trim()));
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTempWork);





            //objDr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + intProjectID + "", true, CommonController.connectionString);
            //if (objDr.Read())
            //{
            //    ProjectName = objDr["ProjectName"].ToString() + "";
            //}
            //objSPDr = CommonFunctions.Data.GetDataTable("usp_whizible2_Sel_tbl_PM_EmployeeSkillMatrix_Detail " + intProjectID, true, CommonController.connectionString);
            //strListOfResources = String.Join("\n", objSPDr.AsEnumerable().Select(x => x.Field<string>("UserName").ToString()).ToArray());

            //objDr1 = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Role " + intRoleID, true, CommonController.connectionString);
            //if (objDr1.Read())
            //{
            //    Designation = objDr1["RoleDescription"].ToString() + "";
            //}

            string intEmployeeMonths = "";
            string intEmployeeYears = "";
            // Retrieve information about the experience gained by the employees in the various tools used in the project.
            strQuery = "Exec usp_Sel_tbl_PM_EmployeeSkillMatrix_Detail " + intProjectID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                while (drTempWork.Read())
                {
                    // Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drTaskInformation["StartDate"], ""));
                    intEmployeeYears = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drTempWork["YearsOfExperience"], ""));
                    intEmployeeMonths = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drTempWork["MonthsOfExperience"], ""));
                    strUserName = drTempWork["UserName"].ToString().Trim();
                    strUserName = CommonFunctions.General.UnBuildQueryString(strUserName);
                    strDescription = drTempWork["Description"].ToString().Trim();
                    strDescription = CommonFunctions.General.UnBuildQueryString(strDescription);


                    if (strEmployeeName != strUserName)
                    {
                        strEmployeeExperience = strEmployeeExperience; //+ "/n" + strUserName;
                        strEmployeeExperience += "\n";
                        strEmployeeExperience += strUserName;
                        strEmployeeName = strUserName;
                    }
                }
            }

            CommonFunctions.Data.DisposeDataReader(ref drTempWork);
            strMessage.Replace("<EXPERIENCE>", strEmployeeExperience);
            int i = 0;
            //String[] spearator = { "," };
            //String[] strlist = strTempArray.Split(spearator,"", StringSplitOptions.RemoveEmptyEntries);
            strTempArray = strListOfEmployeeIDs.Replace(" ", string.Empty).Trim();
            string[] Result = strTempArray.Split(',');
            for (i = 0; i <= Result.Length - 1; i++)
            {
                if ((Result[i] + "") != "")
                {
                    strQuery = "usp_tbl_Sel_EmployeeInfo " + Result[i];
                    drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                    if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
                    {
                        if (drTempWork.Read())
                        {
                            strEmailId = CommonFunctions.General.UnBuildQueryString(drTempWork["EmailID"].ToString().Trim());
                            strListOfEmployeeNames += CommonFunctions.General.UnBuildQueryString(drTempWork["UserName"].ToString().Trim()) + ",";
                            if (strEmailId != "")
                            {
								//comment and added by imran on 20-12-2021 Space added in to
                                //strListOfEmailIDs += strEmailId + "; ";
                                strListOfEmailIDs += strEmailId + ";";
								//End Comment by imran on 2012-2021
                            }

                        }
                    }
                    CommonFunctions.Data.DisposeDataReader(ref drTempWork);
                }
            }


            strListOfEmployeeNames = "All";
            strToEmailID = strListOfEmailIDs;
            //CommonFunctions.Data.GetDataScalar(strSQLNew, true, CommonController.connectionString))
            strToEmailID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_PM_ToMailList_ProjectClosure " + intProjectID.ToString() + ",17", true, CommonController.connectionString));
            //added by imran on 20-12-2021 Space remove
            strToEmailID = strToEmailID.Replace(" ","");
            //End Comment by imran on 2012-2021

            strCCToEmailID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_PM_CCMailList_ProjectClosure " + intProjectID.ToString(), true, CommonController.connectionString));
            //added by imran on 20-12-2021 Space remove
            strCCToEmailID = strCCToEmailID.Replace(" ", "");
            //End Comment by imran on 2012-2021
            strMessage.Replace("<NAME>", strListOfEmployeeNames);



            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            //    strMessage.Replace("<SENDER_NAME>", strUserName);
            //strMessage.Replace("<NAME>", "All");
            //strEmailSubject.Replace("<PROJECT_NAME>", ProjectName);
            //strMessage.Replace("<PROJECT_NAME>", ProjectName);
            //strMessage.Replace("<NAME>", strUserName);
            //strMessage.Replace("<EXPERIENCE>", strListOfResources);
            //strMessage.Replace("<DESIGNATION>", Designation);

            ////if (strFromEmailID.ToString().Trim() != "")
            ////{
            ////    if (strEmailId.IndexOf(strFromEmailID.ToString().Trim()) == -1)
            ////        strCCToEmailID = strFromEmailID;
            ////}            
            //if (strEmailId.ToString().Trim() != "")
            //    strEmailId = strEmailId.Substring(0, strEmailId.LastIndexOf(","));
            //if (strListOfEmployeeNames.ToString().Trim() != "")
            //    strListOfEmployeeNames = strListOfEmployeeNames.Substring(0, strListOfEmployeeNames.LastIndexOf(","));

            //strMessage.Replace("<NAME>", strListOfEmployeeNames);

            //strEmailMessage = strMessage.ToString();
            //strSubject = strEmailSubject.ToString();


            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intMessageID, string WorkFlowPrimaryKey, string m_strcomments, string strUserName, string UserID, int WorkFlowInstance)
        {
            //string strUserName = "";
            string strProjectName = "";
            string strMileStoneName = "";
            IDataReader drTempWork;
            string strQuery = "";
            string strEmailId = "";
            string intPKvalue = "";
            string strRFIRaisedBy = "";
            string strMailToNames = "";
            //  string strProjectName = "";
            string strEmployeeNames = "";
            // string strListOfEmployeeNames = "";
            string strMailToEmployeeIDList = "";
            //string strMailCCToEmployeeIDList = "";

            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            bool blnShowToCustomer = false;
            //string strMailToEmployeeIDList = "";
            string strRequestedByEmailID = "";
            string strMailCCToEmployeeIDList = "";
            IDataReader drEmployee;
            intPKvalue = Convert.ToString(WorkFlowPrimaryKey);
            // string intProjectID = "";
            if (intMessageID == "88")
            {

                intMessageID = "8";
            }
            //if (intMessageID == "177")
            //{

            //    intMessageID = "17";
            //}
            // string strCRMComments = "";
            //Get the message body, and subject.

            strQuery = "usp_Sel_IM_EmailMessages " + intMessageID;
            drTempWork = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

            if (CommonFunctions.General.CheckIsNothing(drTempWork) != "")
            {
                if (drTempWork.Read())
                {
                    strEmailMessage = drTempWork["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drTempWork["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);


                }
            }
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);


            if (m_strcomments == "0")
            {
                m_strcomments = "";
            }


            strEmailMessage = strEmailMessage.Replace("<SENDER_NAME>", strUserName);
            strEmailMessage = strEmailMessage.Replace("<USER COMMENTS>", HttpUtility.UrlDecode(m_strcomments.ToString()));




            IDataReader drPlaceHolders;

            // string strCRMComments = "";
            if (Convert.ToString(intMessageID) == "19" || Convert.ToString(intMessageID) == "20" || Convert.ToString(intMessageID) == "21")
            {
                string strSQL = "usp_Replace_PlaceHolders " + WorkFlowPrimaryKey.ToString();
                drPlaceHolders = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                string strSQLNew = "SELECT top 1 comments FROM tbl_WF_Event INNER JOIN  tbl_IM_WorkFlowInstance ON tbl_WF_Event.InstanceID=tbl_IM_WorkFlowInstance.InstanceID WHERE WorkflowInstanceID=" + WorkFlowPrimaryKey.ToString() + " AND ProcessID='C6FCF802-8FB7-49DB-A4D2-1EB521BBEE84' order by EventTime desc";
                //strCRMComments = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                string strCRMComments = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLNew, true, CommonController.connectionString)));

                if (drPlaceHolders.Read())
                {
                    strEmailMessage = strEmailMessage.Replace("<CRM REQUEST NAME>", drPlaceHolders["Subject"].ToString());
                    strEmailMessage = strEmailMessage.Replace("<ARTICLE CONTENT>", CommonFunctions.General.FormatString(drPlaceHolders["Article content"].ToString(), false));
                    strEmailMessage = strEmailMessage.Replace("<SEARCH LABELS> ", drPlaceHolders["Search Labels"].ToString());
                    strEmailMessage = strEmailMessage.Replace("<SYNOPSIS>", drPlaceHolders["Synopsis"].ToString());
                    strEmailMessage = strEmailMessage.Replace("<TITLE>", drPlaceHolders["Title"].ToString());
                    strEmailMessage = strEmailMessage.Replace("<COMMENTS>", HttpUtility.UrlDecode(strCRMComments.ToString()));
                    strSubject = strSubject.Replace("<CRM REQUEST NAME>", drPlaceHolders["Subject"].ToString());
                }

            }
            funcReplacePlaceHolders(ref intMessageID, ref intPKvalue, ref strEmailMessage);
            funcReplacePlaceHolders(ref intMessageID, ref intPKvalue, ref strSubject);
            //strMessage.Append(strEmailMessage);
            //strEmailSubject.Append(strSubject);

            IDataReader drApprover;
            drApprover = CommonFunctions.Data.GetDataReader("usp_Sel_EntityWorkFlowTOCCEmailList " + WorkFlowPrimaryKey, true, CommonController.connectionString);

            string strS = "usp_Sel_tbl_IM_WorkflowInstance_ProjectID " + WorkFlowPrimaryKey;
            string strValue = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strS, true, CommonController.connectionString)));


            while (drApprover.Read())
            {
                strToEmailID = strToEmailID + CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drApprover["ToEmailIDList"], ""), "").ToString() + ";";
                strCCToEmailID = strCCToEmailID + CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drApprover["CcEmailIDList"], ""), "").ToString() + ";";


                //if (drEmployee["EmailID"].ToString().Trim() != "")
                //{
                //    if (blnShowToCustomer == true || (blnShowToCustomer == false && (drEmployee["ResourceType"].ToString() == "E" || drEmployee["ResourceType"].ToString() == "CE")))
                //    {
                //        if (strMailToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                //        {
                //            if (strToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                //            {
                //                strToEmailID = strToEmailID + drEmployee["EmailID"].ToString().Trim() + "; ";
                //            }
                //        }
                //        if (strMailCCToEmployeeIDList.IndexOf("," + drEmployee["EmployeeID"].ToString().Trim() + ",") != 0)
                //        {
                //            if (strCCToEmailID.IndexOf(drEmployee["EmailID"].ToString().Trim()) == 0)
                //            {
                //                strCCToEmailID = strCCToEmailID + "; " + drEmployee["EmailID"].ToString().Trim();
                //            }
                //        }
                //    }
                //}
            }
            if (strCCToEmailID == ";")
            {
                strCCToEmailID = strCCToEmailID.Replace(";", "");
            }






            GetSenderInfo(ref strUserName, ref strFromEmailID, UserID);

            strEmailMessage = strEmailMessage.Replace("<SENDER_NAME>", strUserName);
            //strEmailMessage = strMessage.ToString();
            strSubject = strSubject.ToString();
            //strToEmailID = strEmailId;
            strMessage = null;
            strEmailSubject = null;

        }




        public static void funcReplacePlaceHolders(ref string MsgID, ref string PrimaryKeyValue, ref string strEmailMessage)
        {
            string strSQL;
            IDataReader objEMDr;
            bool blnUseSQL;
            string strTempMessage;
            string strDropDownEditSQL = "";
            string strPlaceHolder = "";
            string strFieldvalue = "";
            string strTempFieldvalue = "";
            string strReplace = "";
            DataSet objDS;
            string RecParsed = "";
            int initial;
            int next1;
            int tempNext1;
            string EMessage = "";
            string strFieldvalue1;
            strPlaceHolder = strEmailMessage;
            strTempMessage = strPlaceHolder;

            blnUseSQL = true;
            if (strPlaceHolder.Length > 0)
            {
                while (strPlaceHolder.Length > 0)
                {
                    initial = strPlaceHolder.IndexOf("<", 0); // '
                    next1 = strPlaceHolder.IndexOf(">", initial + 1);
                    tempNext1 = next1;

                    if (next1 <= 0)
                        next1 = strPlaceHolder.Length - 1;
                    if (tempNext1 != -1)
                    {
                        RecParsed = strPlaceHolder.Substring(initial + 1, next1 - (initial)).Trim();
                        RecParsed = RecParsed.Substring(0, RecParsed.Length - 1); // LEFT(@RecParsed,Len(@RecParsed)-1)''

                        strSQL = "usp_Replace_PlaceHolders_UFFieldValue " + MsgID.ToString() + "," + PrimaryKeyValue.ToString() + ",N'" + CommonFunctions.General.BuildQueryString(RecParsed) + "'";
                        objEMDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                        while (objEMDr.Read())
                        {
                            strFieldvalue = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(objEMDr["ActualFieldValue"]));
                            strDropDownEditSQL = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(objEMDr["DropDownEditSQL"]));
                        }
                        // Added By vijaYD On 24 August 2009
                        //if (CommonFunctions.General.BuildQueryString(RecParsed).Contains("START DATE") == true & MsgID == "1")
                        //{
                        //    strFieldvalue = CommonFunctions.Dates.CGetDate((DateTime)strFieldvalue);
                        //    strFieldvalue1 = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ExpectedStartDate From tbl_PM_Project Where ProjectID=" + System.Convert.ToString(HttpContext.Current.Session("intProjectID")), true));
                        //    strFieldvalue = strFieldvalue + Constants.vbTab + "  Before  Revision : " + CommonFunctions.Dates.CGetDate((DateTime)strFieldvalue1);
                        //}

                        //if (CommonFunctions.General.BuildQueryString(RecParsed).Contains("END DATE") == true & MsgID == "1")
                        //{
                        //    strFieldvalue = CommonFunctions.Dates.CGetDate((DateTime)strFieldvalue);
                        //    strFieldvalue1 = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ExpectedEndDate From tbl_PM_Project Where ProjectID=" + System.Convert.ToString(HttpContext.Current.Session("intProjectID")), true));
                        //    strFieldvalue = strFieldvalue + Constants.vbTab + "  Before  Revision : " + CommonFunctions.Dates.CGetDate((DateTime)strFieldvalue1);
                        //}

                        //if (CommonFunctions.General.BuildQueryString(RecParsed).Contains("WORK (HRS)") == true & MsgID == "1")
                        //{
                        //    strFieldvalue1 = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select EstimatedEfforts From tbl_PM_Project Where ProjectID=" + System.Convert.ToString(HttpContext.Current.Session("intProjectID")), true));
                        //    strFieldvalue = strFieldvalue + Constants.vbTab + "  Before  Revision : " + strFieldvalue1;
                        //}
                        //if (CommonFunctions.General.BuildQueryString(RecParsed).Contains("DURATION (DAYS)") == true & MsgID == 1)
                        //{
                        //    strFieldvalue1 = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ExpectedDuration From tbl_PM_Project Where ProjectID=" + System.Convert.ToString(HttpContext.Current.Session("intProjectID")), true));
                        //    strFieldvalue = strFieldvalue + Constants.vbTab + "  Before  Revision : " + strFieldvalue1;
                        //}
                        // End Addition By vijaYD On 24 August 2009
                        CommonFunctions.Data.DisposeDataReader(ref objEMDr);

                        //if (strDropDownEditSQL != "")
                        //{
                        //    objDS = CommonFunctions.Data.GetDataSet(CommonFunctions.General.ReplacePlaceHolders(strDropDownEditSQL, true), "EmailMessage", null/* Conversion error: Set to default value for this argument */, null/* Conversion error: Set to default value for this argument */, blnUseSQL);

                        //    objDS.Tables(0).Columns(0).ColumnName = objDS.Tables(0).Columns(0).ColumnName.Replace(" ", "");

                        //    foreach (DataRow objdataRow in objDS.Tables(0).Select("" + objDS.Tables(0).Columns(0).ColumnName + "='" + strFieldvalue + "'"))
                        //    {
                        //        if (objDS.Tables(0).Columns.Count < 2)
                        //            strTempFieldvalue = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(objdataRow.Item(0)));
                        //        else
                        //            strTempFieldvalue = System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(objdataRow.Item(1)));
                        //    }

                        //    strFieldvalue = strTempFieldvalue;
                        //}

                        strReplace = "<" + RecParsed + ">";
                        // If strFieldvalue <> "" Then
                        strTempMessage = strTempMessage.Replace(strReplace, strFieldvalue);
                    }
                    strPlaceHolder = strPlaceHolder.Substring((next1 + 1), strPlaceHolder.Length - (next1 + 1)); // '' Instead of length it will be length-1
                                                                                                                 // strPlaceHolder = strPlaceHolder.Substring((next1), strPlaceHolder.Length - (next1))  ''' Instead of length it will be length-1
                    strFieldvalue = "";
                    strDropDownEditSQL = "";
                    strTempFieldvalue = "";
                }
            }

            objDS = null/* TODO Change to default(_) if this is not a reference type */;
            //funcReplacePlaceHolders = strTempMessage;
            strEmailMessage = strTempMessage;
            // CommonFunctions.Data.DisposeDataReader(ref strTempMessage);
            ////////////////////////////////////////////////////////////////////////////////////
        }
        public static void GetEmailMessage_29(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, ref string FileName, string ReviewStatisticsID, string LoginID)
        {
            int intMessageID = 29;
            string strUserName = "", strProjectName = "", strLoginType = "";
            ReviewInviteMailParameter ReviewInviteMailParameterObj = PM_Project_ReviewController.GetReviewForInvitation(ReviewStatisticsID);
            if (ReviewInviteMailParameterObj != null)
            {
                TimeSpan startTimeSpan = TimeSpan.Parse(ReviewInviteMailParameterObj.StartTime);
                TimeSpan endTimeSpan = TimeSpan.Parse(ReviewInviteMailParameterObj.EndTime);
                ReviewInviteMailParameterObj.ReviewTitle = ReviewInviteMailParameterObj.ReviewTitle + " - " + ReviewStatisticsID;
                ReviewInviteMailParameterObj.LoginID = LoginID;
                ReviewInviteMailParameterObj.ProjectName = EmailMessagesController.GetProjectName(ReviewInviteMailParameterObj.ProjectID);
                ReviewInviteMailParameterObj.strToEmailID = ReviewInviteMailParameterObj.ReviewedBy + "," + ReviewInviteMailParameterObj.Reviewee;
                if (intMessageID == 29)
                {
                    ReviewInviteMailParameterObj.Summary = ReviewInviteMailParameterObj.ReviewTitle + " Invitation";
                }

                ReviewInviteMailParameterObj.StartDate = Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewStartDate).Add(startTimeSpan);
                ReviewInviteMailParameterObj.EndDate = Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewEndDate).Add(endTimeSpan);

                GetSenderInfo(ref strUserName, ref strFromEmailID, ReviewInviteMailParameterObj.LoginID);
                ReviewInviteMailParameterObj.strFromEmailID = strFromEmailID;
                ReviewInviteMailParameterObj.SenderName = strUserName;


                // Get the message body, and subject.
                ReviewInviteMailParameterObj.strMessage = EmailMessagesController.GetEmailMessageForProject(ReviewInviteMailParameterObj.ProjectID, intMessageID);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_TYPE>", ReviewInviteMailParameterObj.ReviewType);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_START_DATE>", Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewStartDate).ToString("dd MMM yyyy"));
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_END_DATE>", Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewEndDate).ToString("dd MMM yyyy"));
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<OLD_REVIEW_START_DATE>", ReviewInviteMailParameterObj.OldReviewStartDate);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<OLD_REVIEW_END_DATE>", ReviewInviteMailParameterObj.OldReviewEndDate);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<NAME>", "");
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<PROJECT_NAME>", ReviewInviteMailParameterObj.ProjectName);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<DURATION_IN_HOURS>", ReviewInviteMailParameterObj.ReviewEffort);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEWER_NAME>", ReviewInviteMailParameterObj.ReviewedBy);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEWEE_NAME>", ReviewInviteMailParameterObj.Reviewee);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<WORK_PRODUCT_TYPE>", ReviewInviteMailParameterObj.WorkProductType);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<SENDER_NAME>", strUserName);
                FileName = CreateICSFile(ReviewInviteMailParameterObj, false, false);
                ReviewInviteMailParameterObj.strToEmailID = string.Join(",", GetEmailIDsByUserNames(ReviewInviteMailParameterObj.ReviewedBy + "," + ReviewInviteMailParameterObj.Reviewee));
                strToEmailID = ReviewInviteMailParameterObj.strToEmailID;
				//Added By Usha Pandit On 11.05.2020 for getting unique Email Id's
                List<string> uniqueToEmailIDs = strToEmailID.ToLower().Split(',').Distinct().ToList();
                strToEmailID = string.Join(",", uniqueToEmailIDs);
                //End Of Added By Usha Pandit On 11.05.2020 for getting unique Email Id's
                strSubject = ReviewInviteMailParameterObj.Summary;
                strEmailMessage = ReviewInviteMailParameterObj.strMessage;
                //Added By Usha Pandit On 23.07.2020 For getting CC Email Id
                if (strCCToEmailID == "")
                {
                    strCCToEmailID = strFromEmailID;
                }
                //End Of Added By Usha Pandit On 23.07.2020 For getting CC Email Id
                //for send review invitation
                if (ReviewInviteMailParameterObj.IsSendReviewInvite)
                {
                    int result = 0;
                    result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                                  (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_tbl_PM_ReviewStatistics_SendReviewInvite "
                                                  + ReviewStatisticsID + " "
                                                  , true, CommonController.connectionString)
                                                  , "0"));
                }
                else
                {
                    FileName = "";
                }
            }
        }

        public static void GetEmailMessage_30(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, ref string FileName, string ReviewStatisticsID, string LoginID, string OldReviewStartDate, string OldReviewEndDate)
        {
            int intMessageID = 30;
            string strUserName = "", strProjectName = "", strLoginType = "";
            ReviewInviteMailParameter ReviewInviteMailParameterObj = PM_Project_ReviewController.GetReviewForInvitation(ReviewStatisticsID);
            if (ReviewInviteMailParameterObj != null)
            {
                TimeSpan startTimeSpan = TimeSpan.Parse(ReviewInviteMailParameterObj.StartTime);
                TimeSpan endTimeSpan = TimeSpan.Parse(ReviewInviteMailParameterObj.EndTime);
                ReviewInviteMailParameterObj.ReviewTitle = ReviewInviteMailParameterObj.ReviewTitle + " - " + ReviewStatisticsID;
                ReviewInviteMailParameterObj.OldReviewStartDate = OldReviewStartDate;
                ReviewInviteMailParameterObj.OldReviewEndDate = OldReviewEndDate;
                ReviewInviteMailParameterObj.LoginID = LoginID;
                ReviewInviteMailParameterObj.ProjectName = EmailMessagesController.GetProjectName(ReviewInviteMailParameterObj.ProjectID);
                ReviewInviteMailParameterObj.IsResendReviewInvite = true;
                ReviewInviteMailParameterObj.strToEmailID = ReviewInviteMailParameterObj.ReviewedBy + "," + ReviewInviteMailParameterObj.Reviewee;
                if (intMessageID == 30)
                {
                    ReviewInviteMailParameterObj.Summary = ReviewInviteMailParameterObj.ReviewTitle + " Re-Invitation";
                }
                ReviewInviteMailParameterObj.StartDate = Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewStartDate).Add(startTimeSpan);
                ReviewInviteMailParameterObj.EndDate = Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewEndDate).Add(endTimeSpan);

                GetSenderInfo(ref strUserName, ref strFromEmailID, ReviewInviteMailParameterObj.LoginID);
                ReviewInviteMailParameterObj.strFromEmailID = strFromEmailID;
                ReviewInviteMailParameterObj.SenderName = strUserName;


                // Get the message body, and subject.
                ReviewInviteMailParameterObj.strMessage = EmailMessagesController.GetEmailMessageForProject(ReviewInviteMailParameterObj.ProjectID, intMessageID);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_TYPE>", ReviewInviteMailParameterObj.ReviewType);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_START_DATE>", Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewStartDate).ToString("dd MMM yyyy"));
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_END_DATE>", Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewEndDate).ToString("dd MMM yyyy"));
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<OLD_REVIEW_START_DATE>", ReviewInviteMailParameterObj.OldReviewStartDate);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<OLD_REVIEW_END_DATE>", ReviewInviteMailParameterObj.OldReviewEndDate);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<NAME>", "");
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<PROJECT_NAME>", ReviewInviteMailParameterObj.ProjectName);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<DURATION_IN_HOURS>", ReviewInviteMailParameterObj.ReviewEffort);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEWER_NAME>", ReviewInviteMailParameterObj.ReviewedBy);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEWEE_NAME>", ReviewInviteMailParameterObj.Reviewee);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<WORK_PRODUCT_TYPE>", ReviewInviteMailParameterObj.WorkProductType);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<SENDER_NAME>", strUserName);
                FileName = CreateICSFile(ReviewInviteMailParameterObj, false, true);
                ReviewInviteMailParameterObj.strToEmailID = string.Join(",", GetEmailIDsByUserNames(ReviewInviteMailParameterObj.ReviewedBy + "," + ReviewInviteMailParameterObj.Reviewee));
                strToEmailID = ReviewInviteMailParameterObj.strToEmailID;
                strSubject = ReviewInviteMailParameterObj.Summary;
                strEmailMessage = ReviewInviteMailParameterObj.strMessage;
                //for send review invitation 02-01-2020 new
                if (ReviewInviteMailParameterObj.IsSendReviewInvite)
                {
                    int result = 0;
                    result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                                  (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_tbl_PM_ReviewStatistics_SendReviewInvite "
                                                  + ReviewStatisticsID + " "
                                                  , true, CommonController.connectionString)
                                                  , "0"));
                }
                //for send review invitation
                if (!ReviewInviteMailParameterObj.IsSendReviewInvite)
                {
                    FileName = "";
                }
            }
        }

        public static void GetEmailMessage_20049(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, ref string FileName, string ReviewStatisticsID, string LoginID)
        {
            int intMessageID = 20049;
            string strUserName = "", strProjectName = "", strLoginType = "";
            ReviewInviteMailParameter ReviewInviteMailParameterObj = PM_Project_ReviewController.GetReviewForInvitation(ReviewStatisticsID);
            if (ReviewInviteMailParameterObj != null)
            {
                TimeSpan startTimeSpan = TimeSpan.Parse(ReviewInviteMailParameterObj.StartTime);
                TimeSpan endTimeSpan = TimeSpan.Parse(ReviewInviteMailParameterObj.EndTime);
                ReviewInviteMailParameterObj.ReviewTitle = ReviewInviteMailParameterObj.ReviewTitle + " - " + ReviewStatisticsID;
                ReviewInviteMailParameterObj.LoginID = LoginID;
                ReviewInviteMailParameterObj.ProjectName = EmailMessagesController.GetProjectName(ReviewInviteMailParameterObj.ProjectID);
                ReviewInviteMailParameterObj.strToEmailID = ReviewInviteMailParameterObj.ReviewedBy + "," + ReviewInviteMailParameterObj.Reviewee;
                ReviewInviteMailParameterObj.Summary = ReviewInviteMailParameterObj.ReviewTitle + " Invitation Cancellation";

                ReviewInviteMailParameterObj.StartDate = Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewStartDate).Add(startTimeSpan);
                ReviewInviteMailParameterObj.EndDate = Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewEndDate).Add(endTimeSpan);

                GetSenderInfo(ref strUserName, ref strFromEmailID, ReviewInviteMailParameterObj.LoginID);
                ReviewInviteMailParameterObj.strFromEmailID = strFromEmailID;
                ReviewInviteMailParameterObj.SenderName = strUserName;


                // Get the message body, and subject.
                ReviewInviteMailParameterObj.strMessage = EmailMessagesController.GetEmailMessageForProject(ReviewInviteMailParameterObj.ProjectID, intMessageID);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_TYPE>", ReviewInviteMailParameterObj.ReviewType);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_START_DATE>", Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewStartDate).ToString("dd MMM yyyy"));
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEW_END_DATE>", Convert.ToDateTime(ReviewInviteMailParameterObj.ReviewEndDate).ToString("dd MMM yyyy"));
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<OLD_REVIEW_START_DATE>", ReviewInviteMailParameterObj.OldReviewStartDate);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<OLD_REVIEW_END_DATE>", ReviewInviteMailParameterObj.OldReviewEndDate);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<NAME>", "");
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<PROJECT_NAME>", ReviewInviteMailParameterObj.ProjectName);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<DURATION_IN_HOURS>", ReviewInviteMailParameterObj.ReviewEffort);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEWER_NAME>", ReviewInviteMailParameterObj.ReviewedBy);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<REVIEWEE_NAME>", ReviewInviteMailParameterObj.Reviewee);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<WORK_PRODUCT_TYPE>", ReviewInviteMailParameterObj.WorkProductType);
                ReviewInviteMailParameterObj.strMessage = ReviewInviteMailParameterObj.strMessage.Replace("<SENDER_NAME>", strUserName);
                FileName = CreateICSFile(ReviewInviteMailParameterObj, true, false);
                ReviewInviteMailParameterObj.strToEmailID = string.Join(",", GetEmailIDsByUserNames(ReviewInviteMailParameterObj.ReviewedBy + "," + ReviewInviteMailParameterObj.Reviewee));
                strToEmailID = ReviewInviteMailParameterObj.strToEmailID;
                //Added By Usha Pandit On 23.10.2020 For getting unique Email Id's
                List<string> uniqueToEmailIDs = strToEmailID.ToLower().Split(',').Distinct().ToList();
                strToEmailID = string.Join(",", uniqueToEmailIDs);
                //End Of Added By Usha Pandit On 23.10.2020 For getting unique Email Id's
                strSubject = ReviewInviteMailParameterObj.Summary;
                strEmailMessage = ReviewInviteMailParameterObj.strMessage;
                //Added By Usha Pandit On 23.10.2020 For getting CC Email Id
                if (strCCToEmailID == "")
                {
                    strCCToEmailID = strFromEmailID;
                }
                //End Of Added By Usha Pandit On 23.10.2020 For getting CC Email Id
                //for send review invitation cancellation
                if (intMessageID == 20049)
                {
                    int result = 0;
                    result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull
                                                  (CommonFunctions.Data.GetDataScalar("usp_Whizible2_upd_tbl_PM_ReviewStatistics_ReviewInviteCancelled "
                                                  + HttpUtility.UrlDecode(ReviewStatisticsID) + " "
                                                  , true, CommonController.connectionString)
                                                  , "0"));
                }
                else
                {
                    FileName = "";
                }
            }
        }


        public static string CreateICSFile(ReviewInviteMailParameter objApptEmail, bool isCancelled, bool isUpdate)
        {
            //string timeZone = objApptEmail.TimeZone;
            string timeZone = objApptEmail.GMTZone;
            //TimeZoneInfo timeZoneInfo = TimeZoneInfo.GetSystemTimeZones().Where(x => x.DisplayName.Contains(timeZone) || x.DisplayName.Contains(timeZone.Replace("GMT","UTC"))).FirstOrDefault();
            string timeZoneName = TimeZoneInfo.GetSystemTimeZones().Where(x => x.DisplayName.Contains(timeZone) || x.DisplayName.Contains(timeZone.Replace("GMT", "UTC"))).Select(x => x.StandardName).FirstOrDefault();

            if (string.IsNullOrEmpty(timeZoneName))
                timeZoneName = "India Standard Time";

            //create a new stringbuilder instance
            StringBuilder sb = new StringBuilder();

            //start the calendar item
            sb.AppendLine("BEGIN:VCALENDAR");
            sb.AppendLine("VERSION:2.0");
            sb.AppendLine("PRODID:-//" + objApptEmail.strFromEmailID);
            sb.AppendLine("CALSCALE:GREGORIAN");

            if (isCancelled)
            {
                sb.AppendLine("METHOD:CANCEL");
            }
            else if (isUpdate)
            {
                sb.AppendLine("METHOD:REQUEST");
            }
            else
            {
                sb.AppendLine("METHOD:PUBLISH");
            }

            ////create a time zone if needed, TZID to be used in the event itself
            //sb.AppendLine("BEGIN:VTIMEZONE");
            //sb.AppendLine("TZID:Europe/Amsterdam");
            //sb.AppendLine("BEGIN:STANDARD");
            //sb.AppendLine("TZOFFSETTO:+0100");
            //sb.AppendLine("TZOFFSETFROM:+0100");
            //sb.AppendLine("END:STANDARD");
            //sb.AppendLine("END:VTIMEZONE");

            //add the event
            sb.AppendLine("BEGIN:VEVENT");

            //with time zone specified
            //sb.AppendLine("DTSTART;TZID=Europe/Amsterdam:" + DateStart.ToString("yyyyMMddTHHmm00"));
            //sb.AppendLine("DTEND;TZID=Europe/Amsterdam:" + DateEnd.ToString("yyyyMMddTHHmm00"));
            sb.AppendLine("DTSTART;TZID=" + timeZoneName + ":" + objApptEmail.StartDate.ToString("yyyyMMddTHHmm00"));
            sb.AppendLine(string.Format("DTSTAMP:{0:yyyyMMddTHHmmssZ}", (objApptEmail.EndDate - objApptEmail.StartDate).Minutes.ToString()));
            sb.AppendLine("DTEND;TZID=" + timeZoneName + ":" + objApptEmail.EndDate.ToString("yyyyMMddTHHmm00"));


            //or without
            //sb.AppendLine(string.Format("DTSTART:{0:yyyyMMddTHHmmssZ}", objApptEmail.StartDate.ToUniversalTime().ToString("yyyyMMdd\\THHmmss\\Z")));
            //sb.AppendLine(string.Format("DTSTAMP:{0:yyyyMMddTHHmmssZ}", (objApptEmail.EndDate - objApptEmail.StartDate).Minutes.ToString()));
            //sb.AppendLine(string.Format("DTEND:{0:yyyyMMddTHHmmssZ}", objApptEmail.EndDate.ToUniversalTime().ToString("yyyyMMdd\\THHmmss\\Z")));

            sb.AppendLine("LOCATION:" + objApptEmail.Location);
            sb.AppendLine(string.Format("DESCRIPTION:{0}", objApptEmail.strMessage));
            sb.AppendLine(string.Format("X-ALT-DESC;FMTTYPE=text/html:{0}", objApptEmail.strMessage));
            sb.AppendLine(string.Format("SUMMARY:{0}", objApptEmail.Summary));
            sb.AppendLine(string.Format("UID:{0}", objApptEmail.ReviewStatisticsID));


            sb.AppendLine(string.Format("ORGANIZER:MAILTO:{0}", objApptEmail.strFromEmailID));

            sb.AppendLine(string.Format("ATTENDEE;CN=\"{0}\";RSVP=TRUE:mailto:{1}", "Vishalmah17@gmail.com", "Vishalmah17@gmail.com"));
            sb.AppendLine("BEGIN:VALARM");
            sb.AppendLine("TRIGGER:-PT17M");
            sb.AppendLine("ACTION:DISPLAY");
            sb.AppendLine("DESCRIPTION:Reminder");
            sb.AppendLine("END:VALARM");

            sb.AppendLine("END:VEVENT");

            //end calendar item
            sb.AppendLine("END:VCALENDAR");

            //create a string from the stringbuilder
            string CalendarItem = sb.ToString();

            string completeFilePath = "";
            //string filePath = HostingEnvironment.MapPath("~/ICSFiles/");
            string filePath = HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Reviews/ICSFiles/");
            if (!Directory.Exists(filePath))
                Directory.CreateDirectory(filePath);
            string filename = Convert.ToString(objApptEmail.ReviewTitle).Trim() + ".ics";
            if (string.IsNullOrEmpty(objApptEmail.ReviewTitle))
                filename = Guid.NewGuid() + ".ics";
            completeFilePath = @"" + filePath + filename;
            try
            {
                //if (File.Exists(completeFilePath))
                //    File.Delete(completeFilePath);
                int i = 1;
                string file = Convert.ToString(objApptEmail.ReviewTitle).Trim();
                filename = Convert.ToString(objApptEmail.ReviewTitle).Trim() + "_" + i + ".ics";
                completeFilePath = @"" + filePath + filename;
                while (File.Exists(completeFilePath))
                {
                    i++;
                    filename = Convert.ToString(objApptEmail.ReviewTitle).Trim() + "_" + i + ".ics";
                    completeFilePath = @"" + filePath + filename;
                }

            }
            catch (Exception)
            {
                filename = " " + Convert.ToString(objApptEmail.ReviewTitle).Trim() + ".ics";
                completeFilePath = @"" + filePath + filename;
            }


            System.IO.File.WriteAllText(completeFilePath, CalendarItem);

            return filename;
        }
        public static List<string> GetEmailIDsByUserNames(string userNames)
        {
            DataTable EmailIDs = new DataTable();
            string strEmailID = "";
            List<string> getEmailIDsByUserNames = new List<string>();
            string strSQL = "usp_Whizible2_sel_EmailIDs_tbl_PM_Employee '" + userNames + "'";
            EmailIDs = Data.GetDataTable(strSQL, true, CommonController.connectionString);
            foreach (DataRow drEmailID in EmailIDs.Rows)
            {
                strEmailID = Convert.ToString(drEmailID["EmailID"]);
                getEmailIDsByUserNames.Add(strEmailID);
            }
            return getEmailIDsByUserNames;
        }

        public static int funcGetEmailShowPopupFlagForProject(long lngProjectID, long lngMsgID)
        {
            string strSQL;
            IDataReader objDr;
            bool blnUseSQL;
            int strShowPopup = 0;
            blnUseSQL = System.Convert.ToBoolean(true);

            strSQL = "usp_Sel_tbl_PM_EmailMessages " + lngMsgID.ToString();
            if (lngProjectID > 0)
                strSQL += "," + lngProjectID.ToString();

            objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL, CommonController.connectionString);
            if (objDr.Read())
            {
                strShowPopup = Convert.ToInt32(objDr["ShowPopup"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref objDr);

            return strShowPopup;
        }

    }
    //start by Vishal Mahajan 11-12-2019 for review invitation
    
    //end by Vishal Mahajan 11-12-2019
    public class EmailParameters
    {

        public long intVerifiedByID { get; set; }
        public int intResourceID { get; set; }
        public string dteFromDate { get; set; }
        public string dteToDate { get; set; }
        public long intProjectID { get; set; }
    }
    public class EmailMessage
    {
        public long lngProjectID { get; set; }
        public long lngMsgID { get; set; }

    }
    public class EmployeeInfo
    {
        public long lngUserID { get; set; }
        //public string strUserName { get; set; }
        //public string strEmailid { get; set; }
    }
    public class SendEmailWithCc
    {
        public string strFromEmailID { get; set; }
        public string strToEmailID { get; set; }
        public string strCCEmailID { get; set; } = "";
        public string strSubject { get; set; }
        public string strEmailBody { get; set; }
        //public string strEmailMessage { get; set; }
        //public long lngMsgID { get; set; }
    }


    public struct MyMessage
    {
        public string ToEmailID { get; set; }
        public string CCEmailID { get; set; }
        public string BCCEmailID { get; set; }
        public string FromEmailID { get; set; }
        public string Subject { get; set; }
        public string EmailBody { get; set; }
        public bool IsBodyHtml { get; set; }
        public string SMTPServer { get; set; }
        public int Port { get; set; }
        public bool IsSSLEnabled { get; set; }
        public string UseName { get; set; }
        public string Password { get; set; }
        public string SMTPDomainName { get; set; }
    }

    public struct Email_ErrorInfo
    {
        public string SMTPServer { get; set; }
        public string SMTPServer_InstallationType { get; set; }
        public string SMTPServerPort { get; set; }
    }
}
