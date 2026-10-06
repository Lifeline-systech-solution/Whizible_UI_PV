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
using WhizibleAPI.Models.EmailMessages;
using Microsoft.VisualBasic;
using EASendMail;
using Microsoft.Identity.Client;
using Newtonsoft.Json;

namespace WhizibleAPI.Controllers
{
    //Added by Vishal Mane on 26/08/2025 to add Email Logic for Excel Upload feature
    public class EmailMessagesController : ApiController
    {
        // Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Timesheet API
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
            const string logSource = "WhizibleAPI-Timesheet.EmailMessagesController";
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
        // End of Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Timesheet API
        //[Authorize]
        //[HttpPost]
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
        //Added by vikas T 
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
        public static void SendEmailWithCC(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody)
        {

            // Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Timesheet API
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
            // End of Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Timesheet API

            try
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

                bool isSSLEnabled = false;
                string strTempToEmailId = General.CheckIsNothing(strToEmailID);
                string strTempCCEmailID = General.CheckIsNothing(strCCEmailID);

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
                
                if (strTempToEmailId != "")
                {
                    IDataReader drSMTPInfo = CommonFunctions.Data.GetSQLDataReader("usp_SEL_Tbl_PM_CompanyInformation", CommonController.connectionString);
                    while (drSMTPInfo.Read())
                    {
                        SMTPUserName = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPUserName"], "").ToString();
                        SMTPPassword = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPPassword"], "").ToString();
                        SMTPPassword = CommonFunctions.General.DecryptString(SMTPPassword);
                        SMTPDomainName = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPDomainName"], "").ToString();
                        SSlEnabled = Convert.ToBoolean(drSMTPInfo["IsSSLEnabled"]);
                        isSSLEnabled = SSlEnabled;
                        SMTPServer = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPServer"], "").ToString();
                        SMTPServerPort = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPServerPort"], "0").ToString();
                    }
                    strFromEmailID = "";
                    //Commented by Vishal Mane on 29/09/2025 to allow silent email logic as it gives null reference error
                    //string NewFromMail = ConfigurationManager.AppSettings["FromEmailID"].ToString();
                    //strFromEmailID = NewFromMail;
                    //End of Commented by Vishal Mane on 29/09/2025 to allow silent amil logic as it gives null reference error
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

                    System.Net.Mail.SmtpClient SmtpClient = new System.Net.Mail.SmtpClient(SMTPServer, 587);

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
                }
            }
            catch (Exception ex)
            {
                //SM.WriteLine("Smtp Exception " + ex.Message + System.DateTime.Now);
            }
            finally
            {
                //MyMessage = null;
                //SmtpClient = null;
            }            
        }

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
    }
    //Added by Vishal Mane on 26/08/2025 to add Email Logic for Excel Upload feature
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
    
    public class SendEmailWithCc
    {
        public string strFromEmailID { get; set; }
        public string strToEmailID { get; set; }
        public string strCCEmailID { get; set; } = "";
        public string strSubject { get; set; }
        public string strEmailBody { get; set; }
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

    //End of Added by Vishal Mane on 26/08/2025 to add Email Logic for Excel Upload feature

}
