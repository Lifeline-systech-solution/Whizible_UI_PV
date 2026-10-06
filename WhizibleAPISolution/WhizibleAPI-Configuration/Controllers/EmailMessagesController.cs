using CommonFunctions;
using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Mail;

namespace WhizibleAPI.Controllers
{
    public class EmailMessagesController : ApiController
    {
        //Added By Aditya J. on 06-11-2024 For VAPT
        public static void GetEmailMessageRes_443(ref string strFromEmailID, ref string strToEmailID, ref string strSubject,
    ref string strEmailMessage, string strLoginName, string strBuildPassword, string strGeneratedKey, ref string strLog)
        {           
            string strReceiverMailID = string.Empty;
            string strReceiverNames = string.Empty;
            string strQuery;
            IDataReader dr;
            string ID = string.Empty;
            string strSenderEmailID = string.Empty;

            var strMessage = new System.Text.StringBuilder();
            var strEmailSubject = new System.Text.StringBuilder();

            strFromEmailID = CommonFunctions.General.CheckIsNothing(funcGetCompanyMailID());

            strQuery = $"EXEC usp_Sel_CustGetLoginUserEmailInfo '{strLoginName}'";
            //dr = CommonFunctions.Data.GetDataReader(strQuery,
            //    Convert.ToBoolean(CommonFunctions.General.GetApplicationKeySetting("UseSQL")),CommonController.connectionString);

            dr = CommonFunctions.Data.GetDataReader(strQuery,
                true, CommonController.connectionString);

            while (dr.Read())
            {
                strReceiverMailID = CommonFunctions.Data.CheckIsDBNull(dr["EmailID"], "").ToString();
                ID = CommonFunctions.Data.CheckIsDBNull(dr["ID"], "").ToString();
            }
            CommonFunctions.Data.DisposeDataReader(ref dr);

            strQuery = "EXEC usp_Sel_SenderInformation 7";
            dr = CommonFunctions.Data.GetDataReader(strQuery,
                true,CommonController.connectionString);

            while (dr.Read())
            {
                strSenderEmailID = CommonFunctions.Data.CheckIsDBNull(dr["UserName"], "").ToString();
            }
            CommonFunctions.Data.DisposeDataReader(ref dr);

            //string stOriginHost = CommonFunctions.General.GetApplicationKeySetting("HostName").ToString();
            string stOriginHost = ConfigurationManager.AppSettings["HostName"];
            //string strVirtualDirectoryName = CommonFunctions.General.GetApplicationKeySetting("VirtualDirectoryName").ToString();
            string strVirtualDirectoryName = ConfigurationManager.AppSettings["VirtualDirectoryName"];
            //Commented & Added by Ajit L on 23/09/2025 for Reset Password issue
           // string strLoginID = CommonFunctions.General.EncryptString(ID);
           // string strLoginID = CommonFunctions.General.EncryptString(ID.Trim().Trim('\''));
            string strLoginID = CommonFunctions.General.EncryptString(ID.Trim().Trim('\'').Replace("'", ""));
            //End of Commented & Added by Ajit L on 23/09/2025 for Reset Password issue

            string restPWDLink;

            if (HttpContext.Current.Request.IsSecureConnection)
            {
                restPWDLink = $"https://{stOriginHost}/{strVirtualDirectoryName}/Source/General/ResetPassword.aspx?Key={strGeneratedKey}&MSID={strLoginID}";
            }
            else
            {
                restPWDLink = $"http://{stOriginHost}/{strVirtualDirectoryName}/Source/General/ResetPassword.aspx?Key={strGeneratedKey}&MSID={strLoginID}";
            }

            strQuery = "EXEC usp_Sel_GetCompanyInfo";
            dr = CommonFunctions.Data.GetDataReader(strQuery,
                true,CommonController.connectionString);

            string strSystemFileNameLog = string.Empty;
            while (dr.Read())
            {
                strLog = CommonFunctions.Data.CheckIsDBNull(dr["SystemFileName"], "").ToString();
                strSystemFileNameLog = CommonFunctions.Data.CheckIsDBNull(dr["OriginalFileName"], "").ToString();
            }

            CommonFunctions.Data.DisposeDataReader(ref dr);

            if (string.IsNullOrWhiteSpace(strReceiverMailID))
            {
                strToEmailID = funcGetCompanyMailID();
            }
            else
            {
                strToEmailID = strReceiverMailID;
            }

            try
            {
                strMessage.Append("<!DOCTYPE html>");
                strMessage.Append("<html><head>");
                strMessage.Append("<meta charset='utf-8'>");
                strMessage.Append("<meta http-equiv='X-UA-Compatible' content='IE=edge'>");
                strMessage.Append("<title>Dashboard</title>");
                strMessage.Append("<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>");
                strMessage.Append("<style>");
                strMessage.Append("body {font-family:Arial, Helvetica, sans-serif;color: #545454; font-size:14px; line-height:20px;}");
                strMessage.Append("p a {color: #1359a6;font-family:Arial, Helvetica, sans-serif;}");
                strMessage.Append(".h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {font-family:Arial, Helvetica, sans-serif;}");
                strMessage.Append("a {color: #1359a6;}");
                strMessage.Append("a:hover{ text-decoration:none}");
                strMessage.Append(".mailtemp_container{ max-width:600px; margin:20px auto; border:1px solid #eee;}");
                strMessage.Append(".mailhead h1{ color:#ffffff;}");
                strMessage.Append(".tdclass { background-image: linear-gradient(to top, #055e92, #056297, #05679c, #056ba1, #0570a6);}");
                strMessage.Append("ul li{ margin:0 0 10px;}");
                strMessage.Append("h3 {margin: 0;}");
                strMessage.Append("</style>");
                strMessage.Append("</head>");
                strMessage.Append("<body class=''>");
                strMessage.Append("<div class='mailtemp_container'>");
                strMessage.Append("<table cellpadding='10' cellspacing='0' border='0'>");

                strMessage.Append("<tr>");
                strMessage.Append("<td colspan='2'>");
                strMessage.Append("<p>");
                strMessage.Append($"<strong style='font-size:16px;'>Dear {strLoginName}, </strong><br />");
                strMessage.Append("Click on the following link to Create New Password for your <strong style='color:#333333;'>Whizible</strong> account");
                strMessage.Append("</p>");
                strMessage.Append("</td>");
                strMessage.Append("</tr>");

                strMessage.Append("<tr>");
                //Commented & Added by Ajit L on 24/09/2025 for Reset Project URL Encryption issue
                //strMessage.Append($"<td colspan='2'><h3><a href='{restPWDLink}' title='Click here to Create New Password'>Create New Password</a></h3></td>");
                strMessage.Append($"<td colspan='2'><h3><a href={restPWDLink} title='Click here to Create New Password'>Create New Password</a></h3></td>");
                //End of Commented & Added by Ajit L on 24/09/2025 for Reset Project URL Encryption issue
                strMessage.Append("</tr>");

                strMessage.Append("<tr>");
                strMessage.Append(" <td colspan='2'>");
                strMessage.Append(" <p><strong>If the above link doesn't work, try the following:</strong></p>");
                strMessage.Append(" <ul style='margin:10px 0 20px; list-style-type:circle;'>");
                strMessage.Append(" <li>");
                strMessage.Append("Mozilla Users- Right click on the 'Create New Password' link. Select 'Copy link location’ & paste the URL in the address bar.");
                strMessage.Append(" </li>");
                strMessage.Append(" <li>");
                strMessage.Append("Internet Explorer Users - Right click on the 'Create New Password' link. Select 'Open in New Window/Tab' option..");
                strMessage.Append(" </li>");
                strMessage.Append("</ul>");

                strMessage.Append("<p style='font-size:13px'><strong>Note:</strong>This link will be functional for one-time use</p>");
                strMessage.Append("</td>");
                strMessage.Append("</tr>");

                strMessage.Append("<tr><td colspan='2' height='10px'></td></tr>");

                strMessage.Append("<tr>");
                strMessage.Append("<td colspan='2'>");
                strMessage.Append("Regards,<br />");
                strMessage.Append($" <strong style='font-size:16px; color:#333333;'>{strSenderEmailID}</strong>");
                strMessage.Append("</td>");
                strMessage.Append("</tr>");

                strMessage.Append("</table>");
                strMessage.Append("</div>");
                strMessage.Append("</body>");
                strMessage.Append("</html>");
            }
            catch (Exception ex)
            {
                throw new Exception("CommonFunctions->EmailMessages->PMMessages->GetEmailMessage_443: " + ex.Message);
            }

            strSubject = "Reset Password";
            strEmailMessage = strMessage.ToString();
            string image = "Images/" + strLog;
            strLog = HttpContext.Current.Server.MapPath(image);
        }
        //End of Added By Aditya J. on 06-11-2024 For VAPT

        //Added By Aditya J. on 06-11-2024 For VAPT
        public static void AppSendEmailWithAttachmentCC(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody, string logo)
        {
            HttpContext Context = HttpContext.Current;
            System.Net.Mail.MailMessage MyMessage;
            bool isWithCC;
            bool isWithBCC;
            string successMessage;
            bool isSSLEnabled = Convert.ToBoolean(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT IsSSLEnabled FROM tbl_PM_CompanyInformation", true, CommonController.connectionString), "0"), "0"));
            string SMTPServer=string.Empty;
            System.Text.StringBuilder strMainMessage = new System.Text.StringBuilder("");
            string strTempToEmailId = General.CheckIsNothing(strToEmailID);
            string strTempCCEmailID = General.CheckIsNothing(strCCEmailID);
            string SMTPUserName = "";
            string SMTPPassword = "";
            string SMTPDomainName = "";
            bool SSlEnabled ;
            string SMTPServerPort = "";
            //Added by Ajit L on 24/09/2025 for Email Format issue
            string EmailFormat = "";
            //End of Added by Ajit L on 24/09/2025 for Email Format issue
            if (!string.IsNullOrEmpty(strTempToEmailId))
            {
                strTempToEmailId = strTempToEmailId.Replace(";;", ";").Replace("; ;", ";").Replace(";", ",").Trim();

                if (strTempToEmailId[strTempToEmailId.Length - 1] == ';' || strTempToEmailId[strTempToEmailId.Length - 1] == ',')
                {
                    strTempToEmailId = strTempToEmailId.Remove(strTempToEmailId.Length - 1);
                }

                try
                {
                    MyMessage = new System.Net.Mail.MailMessage(strFromEmailID.Trim(), strTempToEmailId.Trim(), strSubject.Replace("\r\n", ""), strEmailBody);

                    System.Text.StringBuilder strImageMessage = new System.Text.StringBuilder("");
                    //string stOriginHost = CommonFunctions.General.GetApplicationKeySetting("HostName").ToString();
                    string stOriginHost = ConfigurationManager.AppSettings["HostName"];
                    //string strVirtutalDirectoryName = CommonFunctions.General.GetApplicationKeySetting("VirtualDirectoryName").ToString();
                    string strVirtutalDirectoryName = ConfigurationManager.AppSettings["VirtualDirectoryName"];

                    strImageMessage.Append("<table cellpadding='10' cellspacing='0' border='0'>");
                    strImageMessage.Append("<tr>");
                    strImageMessage.Append("<td class='tdclass' style='background-color:#056297;color:white'>");
                    strImageMessage.Append("<div class=''><h1 style='margin: 0;'>Reset Password</h1></div>");
                    strImageMessage.Append("</td>");
                    strImageMessage.Append("<td width='40%' align='center'><img src=cid:MyImage  id='img' alt='' style='float:right' /></td>");
                    strImageMessage.Append("</tr>");
                    strImageMessage.Append("</table>");

                    if (!string.IsNullOrEmpty(strTempToEmailId))
                    {
                        strMainMessage.Append("<table style='width:100%'>");
                        strMainMessage.Append("<tr>");
                        strMainMessage.Append("<td>");
                        strMainMessage.Append(strImageMessage);
                        strMainMessage.Append("</td>");
                        strMainMessage.Append("</tr>");
                        strMainMessage.Append("<tr>");
                        strMainMessage.Append("<td>");
                        strMainMessage.Append(strEmailBody);
                        strMainMessage.Append("</td>");
                        strMainMessage.Append("</tr>");
                        strMainMessage.Append("</table>");
                    }

                    MyMessage = new System.Net.Mail.MailMessage(strFromEmailID.Trim(), strTempToEmailId.Trim(), strSubject.Replace(Environment.NewLine, ""), strMainMessage.ToString());

                    if (!string.IsNullOrEmpty(strTempCCEmailID))
                    {
                        strTempCCEmailID = strCCEmailID.Replace(";", ",").Trim();

                        if (strTempCCEmailID[strTempCCEmailID.Length - 1] == ';' || strTempCCEmailID[strTempCCEmailID.Length - 1] == ',')
                        {
                            strTempCCEmailID = strTempCCEmailID.Remove(strTempCCEmailID.Length - 1);
                        }

                        MyMessage.CC.Add(strTempCCEmailID);
                    }

                    //SMTPServer = CommonFunctions.Application.SMTPServer ?? "localhost";
                    //System.Net.Mail.SmtpClient SmtpClient = new System.Net.Mail.SmtpClient(CommonFunctions.Application.SMTPServer, 587)
                    //{
                    //    Host = CommonFunctions.Application.SMTPServer ?? "localhost",
                    //    EnableSsl = true,
                    //    UseDefaultCredentials = false,
                    //    //Credentials = new System.Net.NetworkCredential(CommonFunctions.Application.SMTPUserName, CommonFunction.Application.SMTPPassword)
                    //    Credentials = new System.Net.NetworkCredential(SMTPUserName.ToString(), SMTPPassword.ToString())

                    //};

                    //MyMessage.IsBodyHtml = true;
                    //SmtpClient.Send(MyMessage);
                    if (strTempToEmailId != "")
                    {




                        IDataReader drSMTPInfo = CommonFunctions.Data.GetSQLDataReader("usp_SEL_Tbl_PM_CompanyInformation", CommonController.connectionString);

                        while (drSMTPInfo.Read())
                        {
                            SMTPUserName = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPUserName"], "").ToString();
                            // SMTPPassword = CommonFunctions.General.DecryptString(CommonFunctions.Data.CheckIsDBNull(drSMTPInfo("SMTPPassword").ToString(), ""))
                            //Added By Dipali V 27th April 2026 for  SBI Life Security to encrypt SMTP UserName 
                            //SMTPUserName = CommonFunctions.General.DecryptString(SMTPUserName);
                            //End of Added By Dipali V 27th April 2026 for  SBI Life Security to encrypt SMTP UserName 
                            SMTPPassword = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPPassword"], "").ToString();
                            SMTPPassword = CommonFunctions.General.DecryptString(SMTPPassword);

                            SMTPDomainName = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPDomainName"], "").ToString();
                            SSlEnabled = Convert.ToBoolean(drSMTPInfo["IsSSLEnabled"]);
                            isSSLEnabled = SSlEnabled;
                            SMTPServer = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPServer"], "").ToString();
                            // Added By Dipali V 27th April 2026 for  SBI Life Security to encrypt SMTPServer
                            //SMTPServer = CommonFunctions.General.DecryptString(SMTPServer);
                            // End of Added By Dipali V 27th April 2026 for  SBI Life Security to encrypt SMTPServer
                            SMTPServerPort = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["SMTPServerPort"], "0").ToString();
                            EmailFormat = CommonFunctions.Data.CheckIsDBNull(drSMTPInfo["EmailFormat"], "0").ToString();
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
                        //Commented & Added by Ajit L on 24/09/2025 for Email Format issue
                        //if (Application.EmailFormat == "HTML")
                        //    MyMessage.IsBodyHtml = true;
                        //else
                        //    MyMessage.IsBodyHtml = false;
                        if (EmailFormat == "HTML")
                            MyMessage.IsBodyHtml = true;
                        else
                            MyMessage.IsBodyHtml = false;
                        //End of Commented & Added by Ajit L on 24/09/2025 for Email Format issue

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
                    string Message = $"Time: {DateTime.Now:dd/MM/yyyy hh:mm:ss tt}\n-----------------------------------------------------------\n\n-------------------Generate Reset Link----------------------------------------\nMessage: {ex.Message}\nStackTrace: {ex.StackTrace}\nSource: {ex.Source}\nTargetSite: {ex.TargetSite}\n-----------------------------------------------------------\n";
                    string Path = HttpContext.Current.Server.MapPath("~/ResetLink.txt");
                    using (System.IO.StreamWriter objWriter = new System.IO.StreamWriter(Path))
                    {
                        objWriter.Write(Message);
                    }
                }
            }
        }
        //End of Added By Aditya J. on 06-11-2024 For VAPT

        //Added By Aditya J. on 06-11-2024 For VAPT
        public static string funcGetCompanyMailID()
        {
            //string strSQL = "Select * From tbl_PM_CompanyInformation";
            //IDataReader objDr;
            //bool blnUseSQL = Convert.ToBoolean(General.GetApplicationKeySetting("UseSQL"));
            //string strEmailID = string.Empty;

            //objDr = Data.GetDataReader(strSQL, blnUseSQL,CommonController.connectionString);
            //if (objDr.Read())
            //{
            //    strEmailID = objDr["Email"].ToString();
            //}
            //Data.DisposeDataReader(ref objDr);

            //return strEmailID.Trim();

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
        //End of Added By Aditya J. on 06-11-2024 For VAPT
    }
}
