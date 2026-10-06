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
using Microsoft.Identity.Client;
using Newtonsoft.Json;

namespace WhizibleAPI.Controllers
{
    //Controller Name : EmailMessages
    //Created By : Dipali V
    //Created Date : 1st Oct 2023
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
            const string logSource = "WhizibleAPI-Invoice.EmailMessagesController";
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

        /// Added By Dipali V For Project Timesheet , Send for approval Mail pop up
        public static void GetEmailMessage_3(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intTimeSheetID, int intProjectID,int EmployeeID)
        {

            string strUserName = "";
            string strProjectName = "";
            string strListOfReceivers = "";
            IDataReader drTSAuthenticatedBy, drReciever;
            int intMessageID = 3;
           
            string strStartDate;
            string strEndDate;

            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;
            strEmailMessage = funcGetEmailMessageForProject(intProjectID, intMessageID, ref strSubject );

         

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);
        
            GetProjectInfo(ref strProjectName, ref strCCToEmailID, intProjectID, intMessageID, EmployeeID.ToString());
            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            //Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(EmployeeID));
           
            strEmailSubject.Replace("<PROJECT_NAME>", strProjectName + " [Timesheet No : " + intTimeSheetID + "]");

            
            strMessage.Replace("<SENDER_NAME>", strUserName);

              drTSAuthenticatedBy =  CommonFunctions.Data.GetDataReader("EXEC usp_Sel_TimeSheetAuthenticationType " + intTimeSheetID.ToString(), true, CommonController.connectionString);

            if (drTSAuthenticatedBy.Read())
            {
                if (drTSAuthenticatedBy["AuthenticatedBy"].ToString() == "C")
                {

                   
                    IDataReader drCustProjectTimesheet;
                    drCustProjectTimesheet = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_CustomerEmailIDForProjectTimeSheet " + intProjectID, true, CommonController.connectionString);
                    while (drCustProjectTimesheet.Read())
                    {
                        if (drCustProjectTimesheet["EmailID"].ToString() != "")
                        {
                            strToEmailID = strToEmailID + drCustProjectTimesheet["EmailID"].ToString() + ";";
                            strListOfReceivers = strListOfReceivers + drCustProjectTimesheet["CustomerName"].ToString() + ",";
                        }
                    }
                    CommonFunctions.Data.DisposeDataReader(ref drCustProjectTimesheet);
                

                    
                    drReciever = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_CustomerEmailIDForTimeSheet " + intProjectID, true, CommonController.connectionString);
                    while (drReciever.Read())
                    {
                        if (drReciever["EmailID"].ToString() != "")
                            strToEmailID = strToEmailID + drReciever["EmailID"].ToString() + ";";
                       
                        strListOfReceivers = strListOfReceivers + drReciever["EmployeeName"].ToString() + ",";
                    }
                    CommonFunctions.Data.DisposeDataReader(ref drReciever );
                }
                else
                {
                    
                    drReciever = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_InternalAuthenticatorForTimeSheet " + intTimeSheetID.ToString(), true, CommonController.connectionString);
                    while (drReciever.Read())
                    {
                        if (drReciever["EmailID"].ToString() != "")
                            strToEmailID = strToEmailID + drReciever["EmailID"].ToString() + ";";
                        strListOfReceivers = strListOfReceivers + drReciever["EmployeeName"].ToString() + ",";
                    }
                    CommonFunctions.Data.DisposeDataReader(ref drReciever);
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTSAuthenticatedBy);

            if (strListOfReceivers != null)
            {
                if (strListOfReceivers.Trim() == "")
                    strListOfReceivers = "All";
            }
            else
                strListOfReceivers = "All";

           
            strStartDate = CommonFunctions.Dates.GetDate(System.Convert.ToDateTime(CommonFunctions.Data.GetDataScalar("SELECT FromDate  FROM tbl_PM_TimesheetInvoice WHERE TimeSheetNo=" + intTimeSheetID.ToString(), true, CommonController.connectionString)));
            strEndDate = CommonFunctions.Dates.GetDate(System.Convert.ToDateTime(CommonFunctions.Data.GetDataScalar("SELECT ToDate  FROM tbl_PM_TimesheetInvoice WHERE TimeSheetNo=" + intTimeSheetID.ToString(), true, CommonController.connectionString)));
            strMessage.Replace("<START_DATE>", strStartDate);
            strMessage.Replace("<END_DATE>", strEndDate);
          


         
            strMessage.Replace("<NAME>", strListOfReceivers);
          


           
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
  
            strMessage = null;
            strEmailSubject = null;
        }
        /// End of Added By Dipali V For Project Timesheet , Send for approval Mail pop up
        

        // Added By Dipali On 7th Nov 2023 For Submit IR        
        public static void GetEmailMessage_51(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intRFIID, int intProjectID, int EmployeeID)
        {

            string strUserName = "";
            bool blnUseSQL = System.Convert.ToBoolean(CommonFunctions.General.GetApplicationKeySetting("UseSQL"));
            int intMessageID = 0;
            IDataReader drEmailMessage;
            IDataReader drRFI;
            IDataReader drProject;
            IDataReader drRaisedBy;
            IDataReader drApprover;
            int intApproverID = 0;
            //int intProjectID=0;
            string strRFIRaisedBy="";
            string strMailToNames = "";
            string strProjectName = "";
            string strEmployeeNames = "";

         
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 51;

            // Get the message body, and subject.
            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages " + intMessageID, true, CommonController.connectionString);
            if (drEmailMessage.Read())
            {
                strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
            }
            drEmailMessage.Close();
            
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            // 2. Code for String Builder Changes - IssueID - 6052 
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            drRFI = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_RFIs " + intRFIID.ToString(), true, CommonController.connectionString);
            if (drRFI.Read())
            {
                intProjectID = System.Convert.ToInt32(drRFI["ProjectID"]);
                strRFIRaisedBy = drRFI["RFIRaisedBy"].ToString();
            }
            drRFI.Close();
            CommonFunctions.Data.DisposeDataReader(ref drRFI);

            strEmailSubject.Replace("<RFI_ID>", intRFIID.ToString());
            strMessage.Replace("<RFI_ID>", intRFIID.ToString());

            drProject = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + intProjectID.ToString(), true, CommonController.connectionString);
            if (drProject.Read())
                strEmailSubject.Replace("<PROJECT_NAME>", drProject["ProjectName"].ToString());
            drProject.Close();
            CommonFunctions.Data.DisposeDataReader(ref drProject);


            GetProjectInfo(ref strProjectName, ref strCCToEmailID, intProjectID, intMessageID, EmployeeID.ToString());
            strMessage.Replace("<PROJECT_NAME>", strProjectName);

            //Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(EmployeeID));

            strMessage.Replace("<SENDER_NAME>", strUserName);


           
            strRFIRaisedBy = Strings.Replace(strRFIRaisedBy, "'", "''");
           
            drRaisedBy = CommonFunctions.Data.GetDataReader("usp_Whizible2_Sel_tbl_PM_Employee_Username '" + strRFIRaisedBy + "'", true, CommonController.connectionString);
         
            while (drRaisedBy.Read())
                strMailToNames = strMailToNames + drRaisedBy["UserName"].ToString() + ",";
            drRaisedBy.Close();
            CommonFunctions.Data.DisposeDataReader(ref drRaisedBy);
              drApprover = CommonFunctions.Data.GetDataReader("usp_Sel_ProjectIRApproverAndGeneratorDetails " + intProjectID.ToString() + ",'Approver'", true, CommonController.connectionString);
          
            while (drApprover.Read())
            {
                strToEmailID = strToEmailID + drApprover["EMailID"].ToString() + ";";
                if (strMailToNames.IndexOf(drApprover["UserName"].ToString()) < 0)
                    strMailToNames = strMailToNames + drApprover["UserName"].ToString() + ",";
            }
            drApprover.Close();
            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            strMessage.Replace("<NAME>", strMailToNames);

           
           
            //GetProjectInfo(ref strProjectName, ref strCCToEmailID, intProjectID, intMessageID, EmployeeID.ToString());
            //strMessage.Replace("<PROJECT_NAME>", strProjectName);

            ////Retrieve information about the Sender.
            //GetSenderInfo(ref strUserName, ref strFromEmailID, Convert.ToString(EmployeeID));

            if (strToEmailID.IndexOf(strFromEmailID) >= 0)
                strToEmailID = strToEmailID.Replace(strFromEmailID + ";", "");
            if (strToEmailID.Length == 0)
            {
                strToEmailID = strFromEmailID;
                strCCToEmailID = strCCToEmailID.Replace(strFromEmailID, "");
            }
            
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

           
            strMessage = null;
            strEmailSubject = null;
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
                System.Net.Mail.MailMessage MyMessage = new System.Net.Mail.MailMessage();
                System.Net.Mail.SmtpClient SmtpClient = new System.Net.Mail.SmtpClient();

                bool isSSLEnabled = false;//System.Convert.ToBoolean(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetSQLDataScalar("SELECT IsSSLEnabled FROM tbl_APP_CompanyInformation",  ConnectionString:connectionString), "0"), "0"));
                string strTempToEmailId = General.CheckIsNothing(strToEmailID);
                string strTempCCEmailID = General.CheckIsNothing(strCCEmailID);
                if (strTempToEmailId != "")
                {
                    strTempToEmailId = strTempToEmailId.Replace(";;", ";");
                    strTempToEmailId = strTempToEmailId.Replace("; ;", ";");

                    strTempToEmailId = strTempToEmailId.Replace(";", ",");

                    if (strTempToEmailId.Substring(strTempToEmailId.Length - 1, 1) == ";" | strTempToEmailId.Substring(strTempToEmailId.Length - 1, 1) == ",")
                        strTempToEmailId = strTempToEmailId.Trim().Remove(strTempToEmailId.Trim().Length - 1);
                    else
                        strTempToEmailId = strTempToEmailId;
                }

                //try
                //{
                if (strTempToEmailId != "")
                {
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
                    if (SMTPServer != null)
                        SmtpClient.Host = SMTPServer;
                    else
                        SmtpClient.Host = "localhost";

                    SmtpClient.Port = System.Convert.ToInt32(SMTPServerPort);

                    if ((isSSLEnabled != true))
                    {
                        if (SMTPServer != null)
                            SmtpClient.Host = SMTPServer;
                        else
                            SmtpClient.Host = "localhost";

                        SmtpClient.Port = System.Convert.ToInt32(SMTPServerPort);
                        if (SMTPUserName != "")
                        {
                            System.Net.NetworkCredential SMTPUserInfo = new System.Net.NetworkCredential();
                            SMTPUserInfo.UserName = SMTPUserName;
                            SMTPUserInfo.Password = SMTPPassword;

                            if (SMTPDomainName != "")
                                SMTPUserInfo.Domain = SMTPDomainName;

                            SmtpClient.UseDefaultCredentials = false;
                            SmtpClient.Credentials = SMTPUserInfo;
                            SmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                        }
                        SmtpClient.Send(MyMessage);
                    }
                    else
                    {

                        var withBlock = Mail;
                        withBlock.ToEmailID = strToEmailID.Trim();
                        withBlock.CCEmailID = strCCEmailID.Trim();
                        withBlock.BCCEmailID = string.Empty;
                        withBlock.FromEmailID = strFromEmailID.Trim();
                        withBlock.Subject = strSubject;
                        withBlock.EmailBody = strEmailBody;
                        withBlock.IsBodyHtml = false;
                        withBlock.SMTPServer = SMTPServer;
                        withBlock.Port = System.Convert.ToInt32(SMTPServerPort);
                        withBlock.IsSSLEnabled = isSSLEnabled;
                        withBlock.UseName = SMTPUserName;
                        withBlock.Password = SMTPPassword;
                        withBlock.SMTPDomainName = SMTPDomainName;

                        isWithCC = true;
                        isWithBCC = false;
                        successMessage = string.Empty;
                        SendEmailSSLCompatible(withBlock, isWithCC, isWithBCC, ref successMessage);
                    }
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                //MyMessage = null;
                //SmtpClient = null;
            }
           
        }

        public static string SendEmailSSLCompatible(MyMessage mail, bool isWithCC, bool isWithBCC, ref string successMessage)
        {
            // ============================================================================
            // Procedure Name		: SendEmailSSLCompatible
            // Description		: Send mail with SSl Compatible settings....
            // ============================================================================
            //try
            //{
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
            return "";
            //}

            //catch (Exception ex)
            //{
            //    return ex.Message;
            //    successMessage = "ERROR";
            //}

            //finally
            //{
            //}
        }
        public static string GetEmailMessageForProject(long lngProjectID, long lngMsgID)
        {
            string strSubject = "";
            return funcGetEmailMessageForProject(lngProjectID, lngMsgID, ref strSubject);
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
        //Added By Dipali V On 26th Dec 2023 For Send Mail
        public static void SendEmailWithAttachment(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody, HttpFileCollection strAttachments, string[] strAttachmentlisteds)
        {
            HttpContext Context = HttpContext.Current;
            // Create the my message object
            string g_strSmtpServerPort;
            string g_strSmtpServerIP;
            string strFrom;
            string m_strFilePath = AppDomain.CurrentDomain.BaseDirectory;

            m_strFilePath = HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/CRMSenEmailAttachment/");
            int Position = 0;
            string FileExt = "";
            string strTempFileName = "";
            string[] arrTemFile;
            arrTemFile = new string[1] { "" };
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
            if (g_strSmtpServerPort != "587")
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
}
