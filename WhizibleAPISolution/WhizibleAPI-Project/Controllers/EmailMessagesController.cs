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
using System.Net;
using System.Net.Http;
using System.Configuration;
using System.Threading.Tasks;
using WhizibleAPI.Models.EmailMessages;
using Microsoft.VisualBasic;
using Microsoft.Identity.Client;
using Newtonsoft.Json;

//using WhizibleAPI.Models.Project_Review;

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
            const string logSource = "WhizibleAPI-Project.EmailMessagesController";
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
                                strCCToEmailID += strEmailID + ", ";
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
                //Commented by Vishal Mane on on 01/06/2026 to fix email server issue
                //if ((isSSLEnabled != true))
                //{
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
                //    SendEmailSSLCompatible(withBlock, isWithCC, isWithBCC, ref successMessage);
                //}
                //End of Commented by Vishal Mane on on 01/06/2026 to fix email server issue
            }
        }       
        public static void SendEmailWithAttachment(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody, HttpFileCollection strAttachments, string[] strAttachmentlisteds)
        {
            HttpContext Context = HttpContext.Current;
            // Create the my message object
            string g_strSmtpServerPort;
            string g_strSmtpServerIP;
            string strFrom;
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

            System.Net.Mail.MailMessage MyMessage = new System.Net.Mail.MailMessage(strFromEmailID, strTempToEmailId, strSubject, strEmailBody);
            System.Net.Mail.SmtpClient SmtpClient = new System.Net.Mail.SmtpClient();

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
                    for (int i = 0; i <= strAttachments.Count - 1; i++)
                    {
                        intIndex = (HttpPostedFile)strAttachments[i];
                        strFilePath = (Stream)intIndex.InputStream;
                        if (strFilePath.Length != 0)
                            MyMessage.Attachments.Add(new System.Net.Mail.Attachment(strFilePath, intIndex.FileName));
                    }
                }
            }

            // End of Added by Dipali V 26th Oct 2017 For Attachfile During Sending mail

            // Added by Dipali V 26th Oct 2017 For Already Attach file
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
                SmtpClient.Port = Convert.ToInt32(g_strSmtpServerPort);
                SmtpClient.EnableSsl = isSSLEnabled;
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

        public static void GetEmailMessage_20004(ref string FromEmailID, ref string ToEmailID, ref string CCToEmailID, ref string Subject, ref string EmailMessage, long RequestID, string IsShowToCustomer, string LoginType, string strComment, int IssueID, int projectID, string strUserName, int UserID)
        {
            try
            {
                string ProjectName = "";
                IDataReader dr;
                IDataReader drAssign;
                int intMessageID;
                bool blnUseSQL = true;
                System.Text.StringBuilder strMessage;
                System.Text.StringBuilder strEmailSubject;

                intMessageID = 20004;

                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + intMessageID, true, CommonController.connectionString);
                if (dr.Read())
                {
                    Subject = dr["Subject"].ToString();
                    EmailMessage = dr["Body"].ToString() + "";
                }
                //CommonFunctions.Data.DisposeDataReader(dr);
                strMessage = new System.Text.StringBuilder("");
                strEmailSubject = new System.Text.StringBuilder("");
                strMessage.Append(EmailMessage);
                strEmailSubject.Append(Subject);

                // strUserName = Session("strUserName").ToString;

                GetSenderInfo(ref strUserName, ref FromEmailID, UserID.ToString());

                strMessage.Replace("<SENDER_NAME>", strUserName);
                dr = CommonFunctions.Data.GetDataReader("usp_Whizible2_Sel_ProjectName " + IssueID, blnUseSQL, CommonController.connectionString);
                if (dr.Read())
                    ProjectName = dr["ProjectName"].ToString();
                //CommonFunctions.Data.DisposeDataReader(dr);
                strMessage.Replace("<REQUEST_ID>", RequestID.ToString());
                strMessage.Replace("<PROJECT_NAME>", ProjectName);
                strMessage.Replace("<ISSUE_ID>", IssueID.ToString());
                strMessage.Replace("<DISCUSSION_THREAD>", strComment.ToString());
                CCToEmailID = FromEmailID;
                strUserName = "";

                dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_MailTo_list " + RequestID.ToString() + ",20004,NULL," + IsShowToCustomer.ToString(), blnUseSQL, CommonController.connectionString);

                while (dr.Read())
                {
                    if ((dr["EMailID"].ToString() + "") != "" & Strings.UCase(Strings.Trim(FromEmailID + "")) != ((dr["EMailID"].ToString() + "")))
                    {
                        ToEmailID += "," + dr["EMailID"].ToString() + "";
                        strUserName += "," + dr["UserName"].ToString() + "";
                    }
                }
                //CommonFunctions.Data.DisposeDataReader(dr);

                drAssign = CommonFunctions.Data.GetDataReader("usp_CRM_Get_MailTo_list_FromCopyToIssue " + IssueID.ToString() + "," + projectID.ToString(), blnUseSQL, CommonController.connectionString);
                while (drAssign.Read())
                {
                    if ((drAssign["EMailID"].ToString() + "") != "" & Strings.UCase(Strings.Trim(FromEmailID + "")) != ((drAssign["EMailID"].ToString() + "")))
                    {
                        ToEmailID += "," + drAssign["EMailID"].ToString() + "";
                        strUserName += "," + drAssign["UserName"].ToString() + "";
                    }
                }
                if (ToEmailID == "")

                    ToEmailID = "," + FromEmailID;

                strUserName = "";
                if (Strings.Trim(ToEmailID + "") != "")
                    ToEmailID = Strings.Right(ToEmailID, Strings.Len(ToEmailID) - 1);

                if (Strings.Trim(strUserName + "") != "")
                    strUserName = Strings.Right(strUserName, Strings.Len(strUserName) - 1);
                if (ToEmailID == "")
                    ToEmailID = FromEmailID;

                strEmailSubject.Replace("<REQUEST_ID>", RequestID.ToString());
                strEmailSubject.Replace("<ISSUE_ID>", IssueID.ToString());
                EmailMessage = strMessage.ToString();
                Subject = strEmailSubject.ToString();
                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }
        }

        public static void GetEmailMessage_20003(ref string FromEmailID, ref string ToEmailID, ref string CCToEmailID, ref string Subject, ref string EmailMessage, long RequestID, string IsShowToCustomer, string LoginType, string strComment, int IssueID, int projectID, string strUserName, int UserID)
        {
            try
            {
                string ProjectName = "";
            IDataReader dr;
            IDataReader drAssign;
            int intMessageID;
            bool blnUseSQL = true;
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 20003;

            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages " + intMessageID, true, CommonController.connectionString);
            if (dr.Read())
            {
                Subject = dr["Subject"].ToString();
                EmailMessage = dr["Body"].ToString() + "";
            }
            //CommonFunctions.Data.DisposeDataReader(dr);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(EmailMessage);
            strEmailSubject.Append(Subject);

            // strUserName = Session("strUserName").ToString;

            GetSenderInfo(ref strUserName, ref FromEmailID, UserID.ToString());

            strMessage.Replace("<SENDER_NAME>", strUserName);
            dr = CommonFunctions.Data.GetDataReader("usp_Whizible2_Sel_ProjectName " + IssueID, blnUseSQL, CommonController.connectionString);
            if (dr.Read())
                ProjectName = dr["ProjectName"].ToString();
            //CommonFunctions.Data.DisposeDataReader(dr);
            strMessage.Replace("<REQUEST_ID>", RequestID.ToString());
            strMessage.Replace("<PROJECT_NAME>", ProjectName);
            strMessage.Replace("<ISSUE_ID>", IssueID.ToString());
            strMessage.Replace("<DISCUSSION_THREAD>", strComment.ToString());
            CCToEmailID = FromEmailID;
            strUserName = "";

            dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_MailTo_list " + RequestID.ToString() + ",20004,NULL," + IsShowToCustomer.ToString(), blnUseSQL, CommonController.connectionString);

            while (dr.Read())
            {
                if ((dr["EMailID"].ToString() + "") != "" & Strings.UCase(Strings.Trim(FromEmailID + "")) != ((dr["EMailID"].ToString() + "")))
                {
                    ToEmailID += "," + dr["EMailID"].ToString() + "";
                    strUserName += "," + dr["UserName"].ToString() + "";
                }
            }
            //CommonFunctions.Data.DisposeDataReader(dr);

            drAssign = CommonFunctions.Data.GetDataReader("usp_CRM_Get_MailTo_list_FromCopyToIssue " + IssueID.ToString() + "," + projectID.ToString(), blnUseSQL, CommonController.connectionString);
            while (drAssign.Read())
            {
                if ((drAssign["EMailID"].ToString() + "") != "" & Strings.UCase(Strings.Trim(FromEmailID + "")) != ((drAssign["EMailID"].ToString() + "")))
                {
                    ToEmailID += "," + drAssign["EMailID"].ToString() + "";
                    strUserName += "," + drAssign["UserName"].ToString() + "";
                }
            }
            if (ToEmailID == "")

                ToEmailID = "," + FromEmailID;

            strUserName = "";
            if (Strings.Trim(ToEmailID + "") != "")
                ToEmailID = Strings.Right(ToEmailID, Strings.Len(ToEmailID) - 1);

            if (Strings.Trim(strUserName + "") != "")
                strUserName = Strings.Right(strUserName, Strings.Len(strUserName) - 1);
            if (ToEmailID == "")
                ToEmailID = FromEmailID;

            strEmailSubject.Replace("<REQUEST_ID>", RequestID.ToString());
            strEmailSubject.Replace("<ISSUE_ID>", IssueID.ToString());
            EmailMessage = strMessage.ToString();
            Subject = strEmailSubject.ToString();
            strMessage = null;
            strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }
        }

         public static void GetEmailMessage_15(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intProjectEmployeeRoleID, string intProjectID, string intUserID, string intEmployeeID)
        {
            try
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
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }
        }

        public static void GetEmailMessage_16(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intProjectEmployeeRoleID, string intProjectID, string intUserID)
        {
            try
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
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }
        }

        public static void GetEmailMessage_503(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intResourceRequestId, string strEmployeeIDs, string intUserID)
        {
            try
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
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }
        }

        public static void GetEmailMessage_203(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intEmployeeID, string intRequestID)
        {
            try
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
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_498(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string strResourceRequestID, string intProjectID, string intUserID)
        {
            try
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
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }
        }
        public static void GetEmailMessage_80(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string strResourceRequestID, string intProjectID, string intUserID)
        {
            try
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
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_75(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intResourceRequestId)
        {
            try
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
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_76(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, string intRequestID, string strEmployeeIDs, string userId)
        {
            bool blnUseSQL = System.Convert.ToBoolean(true);
            string strUserName = "";
            string strTo = "";
            string strListOfEmployeeIDs = "";
            long intToEmployeeID = 0;
            long intMessageID = 0;
            string strQuery = "";
            IDataReader drTemp;
            string strTemp = "";
            string[] arrEmployeeIds;
            string strEmployeeNames = "";
            int intCnt = 0;

            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 76;

            // Get the message body, and subject.
            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID.ToString();
            drTemp = CommonFunctions.Data.GetDataReader(strQuery, blnUseSQL, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTemp, "") != "")
            {
                if (drTemp.Read())
                {
                    strEmailMessage = "" + drTemp["Body"].ToString();
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = "" + drTemp["Subject"].ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                    strListOfEmployeeIDs = "" + drTemp["ListOfEmployees"].ToString();
                    strListOfEmployeeIDs = CommonFunctions.General.UnBuildQueryString(strListOfEmployeeIDs);
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTemp);


            // 2. Code for String Builder Changes - IssueID - 6052 
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            // Get Request Details	
            strQuery = "usp_sel_tbl_PM_ResourceRequestDetails " + intRequestID.ToString();
            drTemp = CommonFunctions.Data.GetDataReader(strQuery, blnUseSQL, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTemp, "") != "")
            {
                if (drTemp.Read())
                {
                    // Project Name
                    strTemp = "" + drTemp["Project"].ToString();
                    strEmailSubject.Replace("<PROJECTNAME>", strTemp);
                    strEmailSubject.Replace("<REQUEST_ID>", intRequestID.ToString());

                    // Configured Days
                    strTemp = "" + drTemp["ConfiguredMaxDays"].ToString();
                    if (strTemp.Trim() != "" && strTemp.Trim() != "0")
                    {
                        strTemp = "Please note that these resources would be reverted if not assigned within " + strTemp + " days.";
                        strMessage.Replace("<CONFIGUREDDAYS>", strTemp);
                    }
                    else
                        strMessage.Replace("<CONFIGUREDDAYS>", "");

                    intToEmployeeID = System.Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(drTemp["RequestorID"], "0"));
                    // Retrieve information about the Receiver.		
                    GetEmployeeInfo(intToEmployeeID, ref strUserName, ref strToEmailID);
                    // strEmailMessage = Replace(strEmailMessage, "<NAME>", strUserName)
                    strMessage.Replace("<REQUEST_ID>", intRequestID.ToString());
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drTemp);

            // Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, userId);
            strMessage.Replace("<SENDER>", strUserName);
            // " & ExpenseSheetID.ToString() & "," & intApproverID.ToString()
            arrEmployeeIds = strEmployeeIDs.Split(System.Convert.ToChar(","));
            strEmployeeNames = "";
            for (intCnt = 0; intCnt <= arrEmployeeIds.Length - 1; intCnt++)
            {
                strQuery = "Exec usp_Sel_tbl_PM_EmployeeNameForAllocation " + arrEmployeeIds[intCnt] + "," + intRequestID.ToString();
                strUserName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, blnUseSQL, CommonController.connectionString));
                strEmployeeNames += strUserName + ", ";
            }
            strEmployeeNames = Strings.Replace(strEmployeeNames, ",", Environment.NewLine);
            strMessage.Replace("<RESOURCENAME>", strEmployeeNames);

            // Added By JayavantK, On - 25-Aug-2004 - Start
            strCCToEmailID = "";
            drTemp = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_Employee_ResourceAllocation_EmailCc " + intRequestID.ToString(), blnUseSQL, CommonController.connectionString);
            while (drTemp.Read())
                strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drTemp["EmailID"], "").ToString() + ", ";
            CommonFunctions.Data.DisposeDataReader(ref drTemp);
            strCCToEmailID += strFromEmailID;

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strMessage = null;
            strEmailSubject = null;
        }
        public static void GetEmailMessage_426(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intEmployeeID, long intRequestID)
        {
            try
            {
                int intMessageID = 0;
                IDataReader drEscalationResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                IDataReader drSkills;
                string strSkills = "";
                string strTemp = "";
                string strUserName = "";
                string strQuery = "";
                // Dim strName As String = ""

                // 1. Code for String Builder Changes - IssueID - 6052 
                System.Text.StringBuilder strMessage;
                System.Text.StringBuilder strEmailSubject;

                intMessageID = 426;

                strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
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


                strMessage.Replace("<SENDER>", strUserName);
                strMessage.Replace("<REQUESTNO>", intRequestID.ToString());

                strQuery = "usp_sel_tbl_PM_ResourceRequestDetails " + intMessageID;
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
                {
                    if (drResourseRequest.Read())
                    {
                        strMessage.Replace("<ROLE>", drResourseRequest["Role"].ToString());
                        strMessage.Replace("<FROMDATE>", CommonFunctions.Dates.CGetDate(System.Convert.ToDateTime(drResourseRequest["FromDate"])).ToString());
                        strMessage.Replace("<TODATE>", CommonFunctions.Dates.CGetDate(System.Convert.ToDateTime(drResourseRequest["ToDate"])).ToString());
                        // Cc the Email to the Requestor
                        strCCToEmailID = drResourseRequest["EmailID"].ToString() + ",";
                    }
                }
                CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
                strCCToEmailID += strFromEmailID;

                strQuery = "usp_sel_tbl_PM_ResourceRequestDetails " + intMessageID;
                drSkills = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drSkills) != "")
                {
                    if (drSkills.Read())
                    {
                        //strSkills += drSkills["Description"].ToString() + Space(50 - Len(drSkills["Description"].ToString()) - 1);
                        strTemp = "Years " + drSkills["ExpYrs"].ToString();
                        strTemp += " Months " + drSkills["ExpMonths"].ToString();
                        strSkills += "Years " + drSkills["ExpYrs"].ToString();
                        //strSkills += " Months " + drSkills["ExpMonths"].ToString() + Space(5 + (18 - Len(strTemp.ToString())) - 1);
                        strSkills += drSkills["ParameterValue"].ToString();
                    }
                }
                strMessage.Replace("<SKILL>", strSkills);
                CommonFunctions.Data.DisposeDataReader(ref drSkills);

                strQuery = "usp_Sel_Resource_Request_Escalation " + intRequestID.ToString();
                drEscalationResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (drEscalationResource.Read())
                {
                    strMessage.Replace("<REASON>", drEscalationResource["EscalationComments"].ToString());
                }
                drEscalationResource.Close();
                CommonFunctions.Data.DisposeDataReader(ref drEscalationResource);

                strToEmailID = "";
                strQuery = "usp_Sel_Resource_Pool_Manager " + intEmployeeID.ToString();
                drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                while (drApprover.Read())
                {
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";
                }
                drApprover.Close();
                CommonFunctions.Data.DisposeDataReader(ref drApprover);

                // 4. Code for String Builder Changes - IssueID - 6052 
                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                // 5. Code for String Builder Changes - IssueID - 6052 
                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_427(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intEmployeeID, long intRequestID)
        {
            int intMessageID = 0;
            IDataReader drEscalationResource;
            IDataReader drEmailMessage;
            IDataReader drApprover;
            IDataReader drResourseRequest;
            string strQuery = "";
            string strUserName = "";
            // Dim strName As String = ""
            long lngProjectID = 0;

            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 427;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
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
            drEmailMessage.Close();
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            // Retrieve information about the Sender.
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER>", strUserName);
            strMessage.Replace("<REQUESTNO>", intRequestID.ToString());

            strQuery = "usp_sel_tbl_PM_ResourceRequestDetails " + intRequestID;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strMessage.Replace("<ROLE>", drResourseRequest["Role"].ToString());
                    strMessage.Replace("<FROMDATE>", CommonFunctions.Dates.CGetDate(System.Convert.ToDateTime(drResourseRequest["FromDate"])).ToString());
                    strMessage.Replace("<TODATE>", CommonFunctions.Dates.CGetDate(System.Convert.ToDateTime(drResourseRequest["ToDate"])).ToString());
                    strCCToEmailID = drResourseRequest["EmailID"].ToString();
                    lngProjectID = System.Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ProjectID"], "0"));
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            strQuery = "usp_Sel_tbl_PM_ResourceRequest_ResourcePoolEscalationComments " + intRequestID;
            drEscalationResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEscalationResource) != "")
            {
                if (drEscalationResource.Read())
                {
                    strMessage.Replace("<REASON>", drEscalationResource["ResourcePoolEscalationComments"].ToString());
                }
            }
            strMessage.Replace("<REQUESTNO>", intRequestID.ToString());
            drEscalationResource.Close();
            CommonFunctions.Data.DisposeDataReader(ref drEscalationResource);

            // Cc the Email to the Team Manager also
            strQuery = "usp_Sel_GetTeamHead_EmailID " + lngProjectID;
            drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drApprover) != "")
            {
                if (drApprover.Read())
                {
                    strCCToEmailID += "," + CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString();
                }
            }
            // strEmailMessage = Replace(strEmailMessage, "<NAME>", strName)
            drApprover.Close();
            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            // 4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;

        }

        public static void GetEmailMessage_432(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intEmployeeID, long intRequestID)
        {
            int intMessageID = 0;
            string strUserName = "";
            IDataReader drCommonDataReader;
            string strQuery = "";
            string strSkills = "";
            long lngProjectID = 0;

            string strResourceAllocationLevel = "";

            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 432;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    //strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["Body"], "").ToString();
                    //strEmailMessage = Replace(strEmailMessage, "<REQUESTNO>", intRequestID.ToString());
                    //strSubject = CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["Subject"], "").ToString();
                    //strSubject = Replace(strSubject, "<REQUESTNO>", intRequestID.ToString());

                    strEmailMessage = drCommonDataReader["Body"].ToString() + "";
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = drCommonDataReader["Subject"].ToString() + "";
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);

                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            // 2. Code for String Builder Changes - IssueID - 6052 
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            // Retrieve information about the Sender. 
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER>", strUserName);


            strQuery = "usp_sel_tbl_PM_ResourcePreponeRequestDetails " + intRequestID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    strMessage.Replace("<ROLE>", drCommonDataReader["Role"].ToString());
                    strMessage.Replace("<REQUESTNO>", drCommonDataReader["RequestID"].ToString());
                    strMessage.Replace("<FROMDATE>", CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["FromDate"], "").ToString());
                    strMessage.Replace("<TODATE>", CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["ToDate"], "").ToString());
                    strCCToEmailID = drCommonDataReader["EmailID"].ToString();
                    lngProjectID = System.Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["ProjectID"], "0"));
                    strMessage.Replace("<PROJECTNAME>", drCommonDataReader["Project"].ToString());
                    strMessage.Replace("<NO>", drCommonDataReader["NoOfResources"].ToString());
                    strEmailSubject.Replace("<PROJECTNAME>", drCommonDataReader["Project"].ToString());
                    strEmailSubject.Replace("<REQUESTNO>", drCommonDataReader["RequestID"].ToString());
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);


            strQuery = "usp_sel_resourcesrequestkills " + intRequestID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    //strSkills += Constants.vbCrLf;
                    strSkills += drCommonDataReader["Skills"].ToString();
                }
            }
            strMessage.Replace("<SKILL>", strSkills);
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            strQuery = "usp_Sel_BGResourcePool_RequestEscalationComments " + intRequestID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    strMessage.Replace("<REASON>", drCommonDataReader["BGPoolEscalationComments"].ToString());
                }
            }
            strMessage.Replace("<REQUESTNO>", intRequestID.ToString());
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            strQuery = "usp_Sel_Global_Resource_Pool_Managers ";
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                while (drCommonDataReader.Read())
                {
                    if (Strings.InStr("," + strToEmailID, "," + CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() + ",") == 0)
                    {
                        strToEmailID += CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() + ",";
                    }
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            strResourceAllocationLevel = GetResourceAllocationLevel();
            if (strResourceAllocationLevel == "ODC")
            {
                strQuery = "usp_Sel_tbl_PM_OUPool_Managers_GetEmailIDs " + intRequestID.ToString();
                drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
                {
                    while (drCommonDataReader.Read())
                    {
                        if (Strings.InStr("," + strToEmailID, "," + CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() + ",") == 0 && Strings.InStr("," + strCCToEmailID + ",", "," + CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() + ",") == 0)
                        {
                            strCCToEmailID += "," + CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString();
                        }
                    }
                }
                drCommonDataReader.Close();
                CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);
            }

            if (Strings.InStr("," + strCCToEmailID + ",", "," + strFromEmailID + ",") == 0)
            {
                strCCToEmailID += "," + strFromEmailID;
            }

            // 4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage_430(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intEmployeeID, long intRequestID)
        {
            int intMessageID = 0;
            string strUserName = "";
            IDataReader drCommonDataReader;
            string strQuery = "";
            string strSkills = "";
            long lngProjectID = 0;

            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 430;

            // 2. Code for String Builder Changes - IssueID - 6052 
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    strMessage.Append(CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["Body"], "").ToString());
                    strMessage.Replace("<REQUESTNO>", intRequestID.ToString());
                    strEmailSubject.Append(CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["Subject"], "").ToString());
                    strEmailSubject.Replace("<REQUESTNO>", intRequestID.ToString());
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER>", strUserName);

            strQuery = "usp_sel_tbl_PM_ResourcePreponeRequestDetails " + intRequestID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    strMessage.Replace("<ROLE>", drCommonDataReader["Role"].ToString());
                    strMessage.Replace("<FROMDATE>", CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["FromDate"], "").ToString());
                    strMessage.Replace("<TODATE>", CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["ToDate"], "").ToString());
                    strMessage.Replace("<NO>", drCommonDataReader["NoOfResources"].ToString());
                    strCCToEmailID = drCommonDataReader["EmailID"].ToString();
                    lngProjectID = System.Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["ProjectID"], "0"));
                    strMessage.Replace("<PROJECTNAME>", drCommonDataReader["Project"].ToString());
                    strEmailSubject.Replace("<PROJECTNAME>", drCommonDataReader["Project"].ToString());
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            strQuery = "usp_sel_resourcesrequestkills " + intRequestID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    strSkills += drCommonDataReader["Skills"].ToString();
                }
            }
            strMessage.Replace("<SKILL>", strSkills);
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            strQuery = "usp_Sel_BGResourcePool_Request_Escalation " + intRequestID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                if (drCommonDataReader.Read())
                {
                    strMessage.Replace("<REASON>", drCommonDataReader["OUPoolEscalationComments"].ToString());
                }
            }
            strMessage.Replace("<REQUESTNO>", intRequestID.ToString());
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            strToEmailID = "";
            strQuery = "usp_Sel_tbl_CNF_BusinessGroup_Managers_GetEmailIDs " + intRequestID;
            drCommonDataReader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drCommonDataReader) != "")
            {
                //if (drCommonDataReader.Read())
                //{
                //    if (CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() != strCCToEmailID)
                //    {
                //        strToEmailID += CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() + ",";
                //    }
                //}

                while (drCommonDataReader.Read())
                {
                    if (CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() != strCCToEmailID)
                    {
                        strToEmailID += CommonFunctions.Data.CheckIsDBNull(drCommonDataReader["EmailID"], "").ToString() + ",";
                    }
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drCommonDataReader);

            // 4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;

        }

        public static void GetEmailMessage_541(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intEmployeeID, long intResourceRequestId)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            int intToEmployeeID = 0;
            string strUserName = "";
            string strQuery = "";
            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 541;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);


            strQuery = "usp_sel_tbl_PM_ResourcePreponeRequestDetails " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strEmailSubject.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<STARTDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromDate"], "").ToString());
                    strMessage.Replace("<AENDDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ToDate"], "").ToString());
                    strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strMessage.Replace("<RESOURCENAME>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());

                    strMessage.Replace("<ALLOCATION>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["AllocationValue"], "").ToString());
                    intToEmployeeID = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestorID"], "0"));

                    GetEmployeeInfo(intToEmployeeID, ref strUserName, ref strToEmailID);
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER>", strUserName);
            strCCToEmailID = "";

            strQuery = "usp_Sel_tbl_PM_Employee_ResourceAllocation_EmailCc " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                while (drResourseRequest.Read())
                {
                    strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            strCCToEmailID += strFromEmailID;
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;
        }
        public static void GetEmailMessage_542(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intResourceRequestId)
        {
            long intToEmployeeID = 0;
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            string strQuery;
            string strUserName = "";

            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 542;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            strQuery = "usp_sel_tbl_PM_ResourcePreponeRequestDetails " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strEmailSubject.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<STARTDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromDate"], "").ToString());
                    strMessage.Replace("<PENDDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ToDate"], "").ToString());
                    strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strMessage.Replace("<RESOURCENAME>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());
                    strMessage.Replace("<ENDDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ExpectedEndDate"], "").ToString());
                    strMessage.Replace("<ALLOCATION>", drResourseRequest["AllocationValue"].ToString());
                    strMessage.Replace("<REJECTCOMMENTS>", drResourseRequest["RejectComment"].ToString());
                    intToEmployeeID = System.Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestorID"], "0"));
                    GetEmployeeInfo(intToEmployeeID, ref strUserName, ref strToEmailID);
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            GetSenderInfo(ref strUserName, ref strFromEmailID, intToEmployeeID.ToString());
            strMessage.Replace("<SENDER>", strUserName);
            strCCToEmailID = "";

            strQuery = "usp_Sel_tbl_PM_Employee_ResourceAllocation_EmailCc " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                while (drResourseRequest.Read())
                {
                    strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            strCCToEmailID += strFromEmailID;
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage_543(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intResourceRequestId)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            IDataReader drApprover;
            string strQuery;

            // 1.Code for String Builder Changes
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 543;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                }
            }
            drEmailMessage.Close();
            // 2.Code for String Builder Changes
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            strQuery = "usp_sel_tbl_PM_ResourcepreponeRequestDetails " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strEmailSubject.Replace("<REQUESTID>", drResourseRequest["RequestID"].ToString());
                    strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strMessage.Replace("<ENDDATE>", drResourseRequest["ToDate"].ToString());
                    strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strMessage.Replace("<RESOURCENAME>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());
                    strMessage.Replace("<ALLOCATION>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["AllocationValue"], "0").ToString());
                    strMessage.Replace("<SENDER>", drResourseRequest["Requestor"].ToString());
                    strMessage.Replace("<STARTDATE>", drResourseRequest["FromDate"].ToString());
                    strFromEmailID = drResourseRequest["EmailID"].ToString();

                    if (drResourseRequest["Type"].ToString() == "HPD")
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
            }
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            strToEmailID = "";
            strQuery = "usp_Sel_tbl_PM_Employee_ResourceRequest_EmailTo " + intResourceRequestId;
            drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drApprover) != "")
            {
                while (drApprover.Read())
                {
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ", ";
                }
            }
            drApprover.Close();
            CommonFunctions.Data.DisposeDataReader(ref drApprover);

            if (strToEmailID != "")
            {
                strToEmailID = strToEmailID.Trim();
                strToEmailID = Strings.Left(strToEmailID, strToEmailID.Length - 1);
            }
            strMessage.Replace("<NAME>", "");

            // 4.Code for String Builder Changes
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5.Code for String Builder Changes
            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage_539(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID, long intRequestID)
        {
            string strUserName = "";
            string strListOfEmployeeIDs = "";
            long intMessageID = 0;
            string strQuery = "";
            IDataReader drTemp;
            string strTemp = "";
            string strMessage = "";

            intMessageID = 539;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drTemp = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTemp) != "")
            {
                if (drTemp.Read())
                {
                    strEmailMessage = "" + drTemp["Body"].ToString();
                    strEmailMessage = CommonFunctions.General.UnBuildQueryString(strEmailMessage);
                    strSubject = "" + drTemp["Subject"].ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                    strListOfEmployeeIDs = "" + drTemp["ListOfEmployees"].ToString();
                    strListOfEmployeeIDs = CommonFunctions.General.UnBuildQueryString(strListOfEmployeeIDs);
                }
            }
            drTemp.Close();
            CommonFunctions.Data.DisposeDataReader(ref drTemp);

            strQuery = "usp_sel_tbl_PM_ResourceRequestDetails " + intRequestID;
            drTemp = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drTemp) != "")
            {
                if (drTemp.Read())
                {
                    strTemp = "" + drTemp["Project"].ToString();
                    strEmailMessage = strEmailMessage.Replace("<PROJECTNAME>", strTemp);
                    strEmailMessage = strEmailMessage.Replace("<REQUEST_ID>", intRequestID.ToString());
                    strSubject = strSubject.Replace("<PROJECTNAME>", strTemp);
                    strSubject = strSubject.Replace("<REQUEST_ID>", intRequestID.ToString());
                }
            }
            drTemp.Close();
            CommonFunctions.Data.DisposeDataReader(ref drTemp);

            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            string intUserID = "";
            IDataReader dr;
            string strSender = "";
            intUserID = intEmployeeID.ToString();

            strQuery = "usp_sel_EmailIDsForDeclineRequest " + intRequestID + "," + intUserID;
            dr = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(dr) != "")
            {
                if (dr.Read())
                {
                    strFromEmailID = dr["FromID"].ToString();
                    strToEmailID = dr["ToID"].ToString();
                    strCCToEmailID = dr["CcID"].ToString();
                    strMessage = dr["CancelComment"].ToString();
                    strSender = dr["Sender"].ToString();
                }
            }
            dr.Close();
            CommonFunctions.Data.DisposeDataReader(ref dr);
            strEmailMessage = strEmailMessage.Replace("<Decline_Comments>", strMessage);
            strEmailMessage = strEmailMessage.Replace("<SENDER>", strSender);
        }

        public static void GetEmailMessage_499(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intResourceRequestId, int intEmployeeID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            string strQuery = "";
            int intToEmployeeID = 0;
            string strUserName = "";
            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 499;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }
            drEmailMessage.Close();
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            // 2. Code for String Builder Changes - IssueID - 6052 
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            strQuery = "usp_sel_tbl_PM_ResourcePreponeRequestDetails " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strEmailSubject.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<STARTDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromDate"], "").ToString());
                    strMessage.Replace("<AENDDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ToDate"], "").ToString());
                    strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strMessage.Replace("<RESOURCENAME>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());
                    intToEmployeeID = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestorID"], "0"));
                    GetEmployeeInfo(intToEmployeeID, ref strUserName, ref strToEmailID);
                }
            }
            drResourseRequest.Close();
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER>", strUserName);

            strCCToEmailID = "";
            strQuery = "usp_Sel_tbl_PM_Employee_ResourceAllocation_EmailCc " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                while (drResourseRequest.Read())
                {
                    strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
            }
            drResourseRequest.Close();
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            strCCToEmailID += strFromEmailID;

            // 4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;
        }

        public static void GetEmailMessage_502(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intResourceRequestId, int intEmployeeID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            string strUserName = "";

            int intToEmployeeID = 0;
            string strQuery = "";
            // 1. Code for String Builder Changes - IssueID - 6052 
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 502;

            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }
            drEmailMessage.Close();
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            // 2. Code for String Builder Changes - IssueID - 6052 
            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strQuery = "usp_sel_tbl_PM_ResourcePreponeRequestDetails " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strEmailSubject.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strEmailSubject.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<REQUESTID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<STARTDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromDate"], "").ToString());
                    strMessage.Replace("<AENDDATE>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ToDate"], "").ToString());
                    strMessage.Replace("<PROJECTNAME>", drResourseRequest["Project"].ToString());
                    strMessage.Replace("<RESOURCENAME>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ResourceName"], "").ToString());
                    intToEmployeeID = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestorID"], "0"));
                    GetEmployeeInfo(intToEmployeeID, ref strUserName, ref strToEmailID);
                }
            }
            drResourseRequest.Close();
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            GetSenderInfo(ref strUserName, ref strFromEmailID, intEmployeeID.ToString());
            strMessage.Replace("<SENDER>", strUserName);

            strCCToEmailID = "";
            strQuery = "usp_Sel_tbl_PM_Employee_ResourceAllocation_EmailCc " + intResourceRequestId;
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                while (drResourseRequest.Read())
                {
                    strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
            }
            drResourseRequest.Close();
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);
            strCCToEmailID += strFromEmailID;
            // 4. Code for String Builder Changes - IssueID - 6052 
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            // 5. Code for String Builder Changes - IssueID - 6052 
            strMessage = null;
            strEmailSubject = null;

        }

        private static string GetResourceAllocationLevel()
        {
            string strQuery = "";
            string strReturn = "";

            strQuery = "SELECT ResourceAllocationLevel FROM tbl_PM_CompanyInformation";
            strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString), "");

            return strReturn;
        }

        //Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose(IntQueryMessageID == 51)
        public static void GetEmailMessage_51(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intRFIID, int intProjectID, int intEmployeeID)
        {
            try
            {
                string Approver = "Approver";
                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();

                intMessageID = 51;

                //strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

                //strMessage.Append(strEmailMessage);
                //strEmailSubject.Append(strSubject);

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

                strQuery = "usp_Sel_tbl_PM_Project " + intProjectID;
                drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
                {
                    if (drEmailMessage.Read())
                    {
                        strEmailSubject.Replace("<PROJECT_NAME>", drEmailMessage["ProjectName"].ToString());
                        strEmailSubject.Replace("<RFI_ID>", intRFIID.ToString());
                    }
                }

                strQuery = "usp_Sel_ProjectIRApproverAndGeneratorDetails " + intProjectID + ", 'Approver'";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (drResourseRequest.Read())
                {
                    //strMessage.Replace("<NAME>", drResourseRequest["UserName"].ToString());
                    strMessage.Replace("<NAME>", drResourseRequest["UserName"].ToString() + ",");                    
                    //strMessage.Replace("<RFI_ID>", intRFIID.ToString());
                   
                }
                strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }

                strToEmailID = "";
                               
                strQuery = "usp_Sel_ProjectIRApproverAndGeneratorDetails " + intProjectID + ", 'Approver'";
                drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                while (drApprover.Read())
                strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";

                //strQuery = "usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailCc " + intRequestID;
                //drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                //while (drApprover.Read())
                //    strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";

               

                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }
        //End of Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose

        //Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose(IntQueryMessageID == 51)
        public static void GetEmailMessage_55(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intRFIID, int intProjectID, int intEmployeeID)
        {
            try
            {
                string Approver = "Approver";
                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();

                intMessageID = 55;

                //strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

                //strMessage.Append(strEmailMessage);
                //strEmailSubject.Append(strSubject);

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

                strQuery = "usp_Sel_tbl_PM_Project " + intProjectID;
                drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
                {
                    if (drEmailMessage.Read())
                    {
                        strEmailSubject.Replace("<PROJECT_NAME>", drEmailMessage["ProjectName"].ToString());
                        strEmailSubject.Replace("<RFI_ID>", intRFIID.ToString());
                    }
                }

                strQuery = "usp_Sel_ProjectIRApproverAndGeneratorDetails " + intProjectID + ", 'Approver'";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (drResourseRequest.Read())
                {
                    //strMessage.Replace("<NAME>", drResourseRequest["UserName"].ToString());
                    strMessage.Replace("<NAME>", drResourseRequest["UserName"].ToString() + ",");
                    //strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                }
                strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }

                strToEmailID = "";

                strQuery = "usp_Sel_ProjectIRApproverAndGeneratorDetails " + intProjectID + ", 'Approver'";
                drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                while (drApprover.Read())
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";

                //strQuery = "usp_Whizible2_Sel_tbl_PM_Employee_ResourceRequest_EmailCc " + intRequestID;
                //drApprover = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                //while (drApprover.Read())
                //    strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drApprover["EmailID"], "").ToString() + ",";



                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }
        //End of Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose

        
        public static void GetEmailMessage_35009(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int LoginUserID, int ProjectID, string RequestID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            string strUserName = "";

            int intToEmployeeID = 0;
            string strQuery = "";
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 35009;
            var ToMail = "";
            var FromMail = "";
            var CC = "";



            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }
            drEmailMessage.Close();
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strQuery = "Usp_Marlab_Sel_RequestDetails '" + RequestID + "'," + ProjectID + ",1";
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strMessage.Replace("<ProjectName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ProjectName"], "").ToString());
                    strMessage.Replace("<SprintName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SprintName"], "").ToString());
                    strMessage.Replace("<SenderComment>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SenderComment"], "").ToString());
                    strMessage.Replace("<RequestID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<SenderName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["Sender"], "").ToString());
                    strMessage.Replace("<Approver>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["Approver"], "").ToString());
                    strEmailSubject.Replace("<SprintName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SprintName"], "").ToString());
                   // strEmailSubject.Replace("<Approver>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["Approver"], "").ToString());
                    ToMail = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["TOMailID"], ""));
                    FromMail = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromID"], ""));
                    CC = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["CC"], ""));

                }
            }

            drResourseRequest.Close();
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            //  GetSenderInfo(ref strUserName, ref strFromEmailID, LoginUserID.ToString());
            // strMessage.Replace("<ProjectManager>", strUserName);

            strCCToEmailID = "";
            if (CC != "")
            {
            strCCToEmailID += CC + ',' + FromMail;
            }
            else
            {
                strCCToEmailID += FromMail;
            }
            // strFromEmailID += FromMail;
            strToEmailID += ToMail;
            strFromEmailID += FromMail;

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;

        }


        public static void GetEmailMessage_35010(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int LoginUserID, int ProjectID, string RequestID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            string strUserName = "";

            int intToEmployeeID = 0;
            string strQuery = "";
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 35010;
            var ToMail = "";
            var FromMail = "";
            var CC = "";



            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }
            drEmailMessage.Close();
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strQuery = "Usp_Marlab_Sel_RequestDetails '" + RequestID + "'," + ProjectID + ",2";
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strMessage.Replace("<ProjectName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ProjectName"], "").ToString());
                    strMessage.Replace("<SprintName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SprintName"], "").ToString());
                    strMessage.Replace("<ApprovalComment>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SenderComment"], "").ToString());
                    strMessage.Replace("<RequestID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<Sender>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["Sender"], "").ToString());
                    strMessage.Replace("<Approver>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["Approver"], "").ToString());
                    strEmailSubject.Replace("<SprintName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SprintName"], "").ToString());
                    ToMail = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["TOMailID"], ""));
                    FromMail = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromID"], ""));
                    CC = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["CC"], ""));

                }
            }

            drResourseRequest.Close();
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            //  GetSenderInfo(ref strUserName, ref strFromEmailID, LoginUserID.ToString());
            // strMessage.Replace("<ProjectManager>", strUserName);

            strCCToEmailID = "";
            //strCCToEmailID += CC + ',' + FromMail;
            if (CC != "")
            {
                strCCToEmailID += CC + ',' + FromMail;
            }
            else
            {
                strCCToEmailID += FromMail;
            }
            // strFromEmailID += FromMail;
            strToEmailID += ToMail;
            strFromEmailID += FromMail;

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;

        }

        public static void GetEmailMessage_35011(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int LoginUserID, int ProjectID, string RequestID)
        {
            int intMessageID;
            IDataReader drResourseRequest;
            IDataReader drEmailMessage;
            string strUserName = "";

            int intToEmployeeID = 0;
            string strQuery = "";
            System.Text.StringBuilder strMessage;
            System.Text.StringBuilder strEmailSubject;

            intMessageID = 35011;
            var ToMail = "";
            var FromMail = "";
            var CC = "";



            strQuery = "usp_Sel_tbl_PM_EmailMessages " + intMessageID;
            drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
            {
                if (drEmailMessage.Read())
                {
                    strEmailMessage = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Body"]).ToString();
                    strSubject = CommonFunctions.Data.CheckIsDBNull(drEmailMessage["Subject"]).ToString();
                    strSubject = CommonFunctions.General.UnBuildQueryString(strSubject);
                }
            }
            drEmailMessage.Close();
            CommonFunctions.Data.DisposeDataReader(ref drEmailMessage);

            strMessage = new System.Text.StringBuilder("");
            strEmailSubject = new System.Text.StringBuilder("");
            strMessage.Append(strEmailMessage);
            strEmailSubject.Append(strSubject);

            strQuery = "Usp_Marlab_Sel_RequestDetails '" + RequestID + "'," + ProjectID + ",3";
            drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (CommonFunctions.General.CheckIsNothing(drResourseRequest) != "")
            {
                if (drResourseRequest.Read())
                {
                    strMessage.Replace("<ProjectName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["ProjectName"], "").ToString());
                    strMessage.Replace("<SprintName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SprintName"], "").ToString());
                    strMessage.Replace("<RejectComment>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SenderComment"], "").ToString());
                    strMessage.Replace("<RequestID>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["RequestID"], "").ToString());
                    strMessage.Replace("<Sender>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["Sender"], "").ToString());
                    strMessage.Replace("<Approver>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["Approver"], "").ToString());
                    strEmailSubject.Replace("<SprintName>", CommonFunctions.Data.CheckIsDBNull(drResourseRequest["SprintName"], "").ToString());
                    ToMail = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["TOMailID"], ""));
                    FromMail = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["FromID"], ""));
                    CC = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drResourseRequest["CC"], ""));

                }
            }
            drResourseRequest.Close();
            CommonFunctions.Data.DisposeDataReader(ref drResourseRequest);

            //  GetSenderInfo(ref strUserName, ref strFromEmailID, LoginUserID.ToString());
            // strMessage.Replace("<ProjectManager>", strUserName);

            strCCToEmailID = "";

            //strCCToEmailID += CC + ',' + FromMail;
            if (CC != "")
            {
                strCCToEmailID += CC + ',' + FromMail;
            }
            else
            {
                strCCToEmailID += FromMail;
            }
            // strFromEmailID += FromMail;
            strToEmailID += ToMail;
            strFromEmailID += FromMail;

            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();

            strMessage = null;
            strEmailSubject = null;

        }

        //Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
        public static void GetEmailMessage_35013(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID)
        {
            try
            {

                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();
                string strUserName = "";

                intMessageID = 35013;

                //strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

                //strMessage.Append(strEmailMessage);
                //strEmailSubject.Append(strSubject);

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

                //strQuery = "usp_Sel_tbl_PM_Project " + intProjectID;
                //drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                //if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
                //{
                //    if (drEmailMessage.Read())
                //    {
                //        strEmailSubject.Replace("<PROJECT_NAME>", drEmailMessage["ProjectName"].ToString());
                //        strEmailSubject.Replace("<RFI_ID>", intRFIID.ToString());
                //    }
                //}

                strToEmailID = "";
                strQuery = "usp_Whizible2_Sel_ProjectExtensionApproverDetails ";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                //Commented and added by Vishal Mane on 14/08/2025 to fix multiple users ids concatenation
                //while (drResourseRequest.Read())
                //{
                //    strMessage.Replace("<NAME>", drResourseRequest["UserName"].ToString() + ",");
                //    //strMessage.Replace("<RFI_ID>", intRFIID.ToString());
                //    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ",";
                //}

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<NAME>", strUserName + "");
                //End of Commented and added by Vishal Mane on 14/08/2025 to fix multiple users ids concatenation

                //strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }

                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        //Added by Vishal Mane on 14/08/2025 to fix Approval Email Issue dut to integration
        public static void GetEmailMessage_35014(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID, string strEmployeeID)
        {
            try
            {

                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                string strUserName = "";
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();

                intMessageID = 35014;

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


                strToEmailID = "";
                strQuery = "EXEC usp_Whizible2_Sel_ProjectExtensionSubmitterDetails '" + strEmployeeID + "'";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<Requestor>", strUserName + "");


                //strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }

                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_35015(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID, string strEmployeeID)
        {
            try
            {

                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                string strUserName = "";
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();

                intMessageID = 35015;

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


                strToEmailID = "";
                strQuery = "EXEC usp_Whizible2_Sel_ProjectExtensionSubmitterDetails '" + strEmployeeID + "'";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<Requestor>", strUserName + "");


                //strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }

                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_35016(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID)
        {
            try
            {

                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                string strUserName = "";
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();

                intMessageID = 35016;

                //strEmailMessage = funcGetEmailMessageForProject(0, intMessageID, ref strSubject);

                //strMessage.Append(strEmailMessage);
                //strEmailSubject.Append(strSubject);

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

                //strQuery = "usp_Sel_tbl_PM_Project " + intProjectID;
                //drEmailMessage = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                //if (CommonFunctions.General.CheckIsNothing(drEmailMessage) != "")
                //{
                //    if (drEmailMessage.Read())
                //    {
                //        strEmailSubject.Replace("<PROJECT_NAME>", drEmailMessage["ProjectName"].ToString());
                //        strEmailSubject.Replace("<RFI_ID>", intRFIID.ToString());
                //    }
                //}

                strToEmailID = "";
                strQuery = "usp_Whizible2_Sel_ResourceExtensionApproverDetails ";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (drResourseRequest.Read())
                {
                    //Commented and Added by Riddhesh Patil for username not binding issue
                    while (drResourseRequest.Read())
                    {
                        strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                        strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                    }

                    //strMessage.Replace("<NAME>", drResourseRequest["UserName"].ToString());
                    //strMessage.Replace("<NAME>", drResourseRequest["UserName"].ToString() + ",");
                    ////strMessage.Replace("<RFI_ID>", intRFIID.ToString());
                    //strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ",";
                    strUserName = strUserName.TrimEnd(',', ' ');
                    strMessage.Replace("<NAME>", strUserName + "");
                    //End of Commented and Added by Riddhesh Patil for username not binding issue
                }


                //strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }






                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_35017(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID, string strEmployeeID)
        {
            try
            {

                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                string strUserName = "";
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();

                intMessageID = 35017;

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


                strToEmailID = "";
                strQuery = "EXEC usp_Whizible2_Sel_ProjectExtensionSubmitterDetails '" + strEmployeeID + "'";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<Requestor>", strUserName + "");


                //strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }

                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_35018(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID, string strEmployeeID)
        {
            try
            {

                int intMessageID;
                string strQuery, strEmailId = "";
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drApprover;
                IDataReader drResourseRequest;
                string strSkills;
                string strTemp;
                string strUserName = "";
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();

                intMessageID = 35018;

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


                strToEmailID = "";
                strQuery = "EXEC usp_Whizible2_Sel_ProjectExtensionSubmitterDetails '" + strEmployeeID + "'";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<Requestor>", strUserName + "");


                //strMessage.Replace("<RFI_ID>", intRFIID.ToString());

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }

                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                //strCCToEmailID += strFromEmailID;

                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }
        //End of Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration

        //Added by Vishal Mane on 09/02/2026 to send Session EmployeeID for silent mail
        public static void GetEmailMessage_36100(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID, int ProjectID, int RoleID, int FromStageID, int ToStageID)
        {
            try
            {
                int intMessageID;
                string strQuery;
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drResourseRequest;
                IDataReader drProjectData;
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();
                string strUserName = "";
                intMessageID = 36100;
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

                strToEmailID = "";
                strQuery = "usp_Whizible2_Sel_BulkExt_ApproverEmailsIDs " + RoleID;
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<NAME>", strUserName + "");

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_Whizible2_Sel_BulkExt_Email_ProjectDetails " + intEmployeeID + "," + ProjectID + "," + ToStageID + "";
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                        strMessage.Replace("<PROJECT_NAME>", drFromResource["ProjectName"].ToString());
                        strMessage.Replace("<PROJECT_ID>", drFromResource["ProjectID"].ToString());
                        strMessage.Replace("<CURRENT_STAGE_NAME>", drFromResource["ToStage"].ToString());
                    }
                }
                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        public static void GetEmailMessage_36101(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID,
            ref string strSubject, ref string strEmailMessage, int intEmployeeID, int ProjectID, int RoleID, int FromStageID, int ToStageID)
        {
            try
            {
                int intMessageID;
                string strQuery;
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drResourseRequest;
                IDataReader drProjectData;
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();
                string strUserName = "";
                intMessageID = 36101;
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

                strToEmailID = "";
                strQuery = "usp_Whizible2_Sel_BulkExt_ApproverEmailsIDs " + RoleID + "," + ProjectID + "";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ", ";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<NAME>", strUserName + "");

                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_Whizible2_Sel_BulkExt_Approval_Email_ProjectDetails " + intEmployeeID + "," + ProjectID + "," + FromStageID + "," + ToStageID + "";
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                        strMessage.Replace("<PROJECT_NAME>", drFromResource["ProjectName"].ToString());
                        strMessage.Replace("<PROJECT_ID>", drFromResource["ProjectID"].ToString());
                        strMessage.Replace("<CURRENT_STAGE_NAME>", drFromResource["ToStage"].ToString());
                        strMessage.Replace("<PREVIOUS_STAGE_NAME>", drFromResource["FromStage"].ToString());
                        strMessage.Replace("<ORIGINAL_SUBMITTER>", drFromResource["OriginalSubmitter"].ToString());
                    }
                }
                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }
        }
        public static void GetEmailMessage_36102(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID,
            ref string strSubject, ref string strEmailMessage, int intEmployeeID, int ProjectID, int RoleID, int FromStageID, int ToStageID, int WorkflowID)
        {
            try
            {
                int intMessageID;
                string strQuery;
                IDataReader drCCResource;
                IDataReader drEmailMessage;
                IDataReader drResourseRequest;
                IDataReader drProjectData;
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();
                string strUserName = "";
                intMessageID = 36102;
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

                strToEmailID = "";
                strQuery = "usp_Whizible2_Sel_BulkExt_ApproverEmailsIDs " + RoleID + "," + ProjectID + "," + WorkflowID + "";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString() + ", ";
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString() + ",";
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<NAME>", strUserName + "");


                strCCToEmailID = "";
                strQuery = "usp_Whizible2_Sel_BulkExt_Approver_CC_EmailsIDs " + WorkflowID;
                drCCResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                while (drCCResource.Read())
                {
                    strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drCCResource["EmailID"], "").ToString() + ",";
                }

                strFromEmailID = "";
                strQuery = "usp_Whizible2_Sel_BulkExt_Rejection_Email_ProjectDetails " + intEmployeeID + "," + ProjectID + "," + FromStageID + "," + ToStageID + "";
                drProjectData = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drProjectData) != "")
                {
                    if (drProjectData.Read())
                    {
                        strFromEmailID = drProjectData["EmailID"].ToString();
                        //strCCToEmailID = drProjectData["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drProjectData["UserName"].ToString());
                        strMessage.Replace("<PROJECT_NAME>", drProjectData["ProjectName"].ToString());
                        strMessage.Replace("<PROJECT_ID>", drProjectData["ProjectID"].ToString());

                        strMessage.Replace("<STAGE_NAME>", drProjectData["ToStage"].ToString());
                        strMessage.Replace("<APPROVER_NAME>", drProjectData["ApproverName"].ToString());
                        strMessage.Replace("<REJECT_COMMENT>", drProjectData["RejectedComment"].ToString());
                    }
                }
                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();

                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }
        public static void GetEmailMessage_36103(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, int intEmployeeID, int ProjectID)
        {
            try
            {
                int intMessageID;
                string strQuery;
                IDataReader drFromResource;
                IDataReader drEmailMessage;
                IDataReader drResourseRequest;
                string strUserName = "";
                StringBuilder strMessage = new StringBuilder();
                StringBuilder strEmailSubject = new StringBuilder();
                intMessageID = 36103;
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
                strToEmailID = "";
                strQuery = "EXEC usp_Whizible2_Sel_BulkExt_SubmitterDetails " + ProjectID + "";
                drResourseRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                while (drResourseRequest.Read())
                {
                    strUserName += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["UserName"], "").ToString();
                    strToEmailID += CommonFunctions.Data.CheckIsDBNull(drResourseRequest["EmailID"], "").ToString();
                    strMessage.Replace("<PROJECT_NAME>", drResourseRequest["ProjectName"].ToString());
                    strMessage.Replace("<PROJECT_ID>", drResourseRequest["ProjectID"].ToString());
                }
                strUserName = strUserName.TrimEnd(',', ' ');
                strMessage.Replace("<Requestor>", strUserName + "");
                strFromEmailID = "";
                strCCToEmailID = "";
                strQuery = "usp_tbl_Sel_EmployeeInfo " + intEmployeeID;
                drFromResource = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drFromResource) != "")
                {
                    if (drFromResource.Read())
                    {
                        strFromEmailID = drFromResource["EmailID"].ToString();
                        strCCToEmailID = drFromResource["EmailID"].ToString();
                        strMessage.Replace("<SENDER_NAME>", drFromResource["UserName"].ToString());
                    }
                }
                if (strToEmailID != "")
                {
                    strToEmailID = strToEmailID.Trim();
                    strToEmailID = strToEmailID.Substring(0, strToEmailID.Length - 1);
                }
                strEmailMessage = strMessage.ToString();
                strSubject = strEmailSubject.ToString();
                strMessage = null;
                strEmailSubject = null;
            }
            catch (Exception ex)
            {
                Console.Write("Bad Request found");
            }

        }

        //End of Added by Vishal Mane on 09/02/2026  to send Session EmployeeID for silent mail
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
