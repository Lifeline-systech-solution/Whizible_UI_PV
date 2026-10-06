using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using System.Data;
using System.IO;
using Newtonsoft.Json;
using WhizibleAPI.Models;
using WhizibleAPI.Models.SM;
using System.Web.Security;
using Authentication;
using System.Globalization;
using System.Threading;
using System.Text;
using System.Xml;
//using PbNIT.CommonFunction.General;

using CommonFunctions.Security;
using System.Data.SqlClient;
using System.Configuration;

namespace WhizibleAPI.Controllers
{
    public static class XMLHttp
    {
        // Static hashtable equivalent to VB's shared m_LoginHashTable
        public static Hashtable m_LoginHashTable = new Hashtable();
    }
    public class SM_DefaultController : ApiController
    {
        private string strUserName;
        private string m_strIsValid;

        //public static class XMLHttp
        //{
        //    public static Dictionary<string, string> m_LoginHashTable = new Dictionary<string, string>();
        //}
        //For CHECKLASTENTEREDPWDS
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object CHECKLASTENTEREDPWDS([FromBody] EmployeeDetails parameters)
        {
            try
            {

                string strResult;
                string strEncryptedKey = "";
                string NewPassword = "";
                string LoginName = "";
                string strEncryptedLength = "";
                string strUniqueId = "";
                bool isValid = false;
                NewPassword = parameters.NewPassword;
                LoginName = parameters.LoginName;
                strEncryptedLength = CommonFunctions.General.CheckIsNothing(parameters.AuthNo, "0");
                //strUniqueId = XMLHttp.m_LoginHashTable[parameters.LoginName] as string;
                strEncryptedKey = parameters.NewPassword.Substring(1, int.Parse(strEncryptedLength));

                string[] strPwd1 = NewPassword.Split('|');
                NewPassword = "";
                for (int i = 0; i < strPwd1.Length - 1; i++)
                {
                    NewPassword += strPwd1[i].Substring(0, 1);
                }
                NewPassword = new string(NewPassword.ToCharArray().Reverse().ToArray());

                var objEncryptNewPassword = new Authentication.PWEncryption(LoginName, NewPassword);
                NewPassword = objEncryptNewPassword.Encrypt();

                strResult = CommonFunctions.General.CheckIsNothing(
                    CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_Check_LastEnteredPwds '" + LoginName + "','" + NewPassword + "'", true, CommonController.connectionString))
                );

                return strResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //For ForcefullyChangePassword

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ForcefullyChangePassword([FromBody] EmployeeDetails parameters)
        {
            if (parameters == null || string.IsNullOrEmpty(parameters.LoginName) || string.IsNullOrEmpty(parameters.Password))
            {
                return BadRequest("Invalid parameters.");
            }

            try
            {
                bool isFirstTimeLogin = false;
                //Commented and Added by Riddhesh Patil on 11 Nov 2024 for decrypting Encrypted parameters
                //string loginName = parameters.LoginName.Replace("'", "''");
                //string password = parameters.Password.Replace("'", "''");
                string loginName = CommonFunctions.General.DecryptString(parameters.LoginName).Replace("'", "''");
                string password = CommonFunctions.General.DecryptString(parameters.Password).Replace("'", "''");
                //End of Commented and Added by Riddhesh Patil on 11 Nov 2024 for decrypting Encrypted parameters
                //var objPW = new PWEncryption(loginName, password);
                //string encryptedPassword = objPW.ToString();
                var objPW = new Authentication.PWEncryption(loginName, password);
                string encryptedPassword = objPW.Encrypt();
                objPW = null; // Dispose if needed, depending on implementation

                string strSQL = "usp_Sel_tbl_PM_Login_Isfirsttimelogin '" + loginName + "','" + encryptedPassword + "'";
                isFirstTimeLogin = (bool)CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Ok(isFirstTimeLogin ? "1" : "0"); // Return appropriate response
            }
            catch (Exception ex)
            {
                // Log the exception (consider using a logging framework)
                return InternalServerError(new Exception("An error occurred while changing the password.", ex));
            }
        }

        //For PasswordChangeDays
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public string GetPwdChangeDays([FromBody] EmployeeDetails parameters)
        {
            if (string.IsNullOrEmpty(parameters.LoginName))
            {
                return "Invalid login name.";
            }

            try
            {
                string strLoginName = CommonFunctions.General.CheckIsNothing(parameters.LoginName, string.Empty);

                var result = CommonFunctions.Data.GetDataScalar("Usp_sel_ChangePwd_Days '" + strLoginName + "'", true, CommonController.connectionString);
                string strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(result));

                return strResult;
            }
            catch (Exception ex)
            {
                // Log the exception (consider using a logging framework)
                return "An error occurred while retrieving password change days.";
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public  string ValidateUserName([FromBody] EmployeeDetails parameters)
        {
            string strResult = string.Empty;
            string uniqueID;
            string strToken;

            try
            {
                // Generate a new unique ID and encrypt it
                uniqueID = Guid.NewGuid().ToString();
                SM_DefaultController SMFunctions = new SM_DefaultController();
                string encryptedUniqueID = SMFunctions.GetUserNameToken(uniqueID);

                strResult = encryptedUniqueID;
               
                // Get the token for the provided username
                strToken = Token.GetToken(parameters.UserName);
             
                //XMLHttp XMLHttp = new CommonFunctions.General.XMLHttp()
                //if (XMLHttp.m_LoginHashTable.ContainsKey(parameters.UserName))
                //{
                //    XMLHttp.m_LoginHashTable.Remove(parameters.UserName);
                //}
                //XMLHttp.m_LoginHashTable.Add(parameters.UserName, uniqueID);


                return $"{strResult}||{strToken}";
            }
            catch (Exception ex)
            {

                return strResult; // Return what you have so far
            }
        }



        //Added By Aditya J. on 06-11-2024 For VAPT
        //[Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateHeaders]
        [HttpPost]
        public IHttpActionResult ReSetPassword([FromBody] EmployeeDetails parameters)
        {
            try
            {
                int counter;
                string strBuildPassword;
                string strLogin = string.Empty;
                string strSqlQuery = string.Empty;
                string strToEmailId = string.Empty;
                string strCCToEmailId = string.Empty;
                string strSubject = string.Empty;
                string strEmailMessage = string.Empty;
                string strRndNumber = new Random().Next(0, 10).ToString();
                string strLoginName = parameters.UserName;

                for (counter = 1; counter <= 1; counter++)
                {
                    strRndNumber += strRndNumber + new Random().Next(0, 1000).ToString();
                }

                var objCreateNewPassword = new CreateNewPassword();
                strBuildPassword = objCreateNewPassword.CreatePassword();

                // Password Encryption
                var objPW = new PWEncryption(strLoginName, strBuildPassword);
                string strEncryptedPW = objPW.Encrypt();
                objPW = null;

                string strMailStatus = string.Empty;
                string m_strValidEmailID = string.Empty;
                IDataReader dr;

                string strEmailStatusQuery = "EXEC usp_Sel_GetLoginUserEmailInfo '" + strLoginName.Trim() + "'";
                dr = CommonFunctions.Data.GetDataReader(strEmailStatusQuery, true, CommonController.connectionString);
               
                string strUserName = string.Empty;
                
                if(dr.Read())
                {
                    strMailStatus = dr["EmailID"].ToString() + "";
                    strUserName = dr["UserName"].ToString() + "";  
                }

                //while (dr.Read())
                //{
                //    strMailStatus = CommonFunctions.Data.CheckIsDBNull(dr["EmailID"], "").ToString();
                //    strUserName = CommonFunctions.Data.CheckIsDBNull(dr["UserName"], "").ToString();
                //}
                CommonFunctions.Data.DisposeDataReader(ref dr);                

                if (!string.IsNullOrEmpty(strMailStatus))
                {
                    if (parameters.EmailID.Trim() != strMailStatus.Trim())
                    {
                        return Ok(new { hidForgetPassword = "4" });
                    }
                }

                if (parameters.UserName.Trim() != strUserName.Trim())
                {
                    return Ok(new { hidForgetPassword = "2" });
                }

                if (!string.IsNullOrEmpty(strMailStatus))
                {
                    strSqlQuery = "DECLARE @intReturn INT\n";
                    strSqlQuery += "EXEC usp_upd_ActivePassword '" + strLoginName + "','" + strEncryptedPW + "', @intReturn OUTPUT\n";
                    strSqlQuery += "SELECT 'Status' = @intReturn";
                    m_strIsValid = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSqlQuery, true, CommonController.connectionString));
                    m_strValidEmailID = "1";
                }
                else
                {
                    strSqlQuery = "DECLARE @intReturn INT\n";
                    strSqlQuery += "EXEC usp_sel_validlogin '" + strLoginName + "', @intReturn OUTPUT\n";
                    strSqlQuery += "SELECT 'Status' = @intReturn";
                    m_strIsValid = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSqlQuery, true, CommonController.connectionString));
                    m_strValidEmailID = "0";
                }

                if (m_strIsValid == "1" && m_strValidEmailID == "1")
                {
                    string strFromEmailId = string.Empty;
                    bool blnSendMail = false;
                    bool blnShowPopUp = false;

                    string strSQL = "usp_Sel_tbl_PM_EmailMessages 443";
                    IDataReader objDr;

                    try
                    {
                        objDr = CommonFunctions.Data.GetDataReader(strSQL, true,CommonController.connectionString);
                        if (objDr.Read())
                        {
                            blnSendMail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDr["SendMail"], "0"));
                            blnShowPopUp = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDr["ShowPopup"], "0"));
                        }
                        CommonFunctions.Data.DisposeDataReader(ref objDr);

                        string strGeneratedKey;
                        string strUniqueID = Guid.NewGuid().ToString();
                        string strGetGeneratedKey;

                        string strNewGenUserName;
                        string strNewGenUniqueID;

                        strBuildPassword = objCreateNewPassword.CreatePassword();
                        var strGenUserName = new PWEncryption(strUserName, strBuildPassword);
                        strNewGenUserName = strGenUserName.Encrypt();

                        var strGenUniqueID = new PWEncryption(strUniqueID, strBuildPassword);
                        strNewGenUniqueID = strGenUniqueID.Encrypt();

                        strGeneratedKey = strNewGenUserName + strEncryptedPW + strNewGenUniqueID;
                        strGetGeneratedKey = strGeneratedKey;

                        string logo = string.Empty;
                        EmailMessagesController.GetEmailMessageRes_443(
                            ref strFromEmailId, ref strToEmailId, ref strSubject, ref strEmailMessage, strLoginName,
                            strBuildPassword, strGetGeneratedKey, ref logo);

                        //CommonFunctions.Emails.AppSendEmailWithAttachmentCC(
                        //    strToEmailId, strCCToEmailId, strFromEmailId, strSubject,
                        //    strEmailMessage, logo);

                        EmailMessagesController.AppSendEmailWithAttachmentCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject,
                            strEmailMessage, logo);

                        strSQL = $"usp_Ins_tbl_PM_ResetPasswordDetails '{strEncryptedPW}', '{strUniqueID}', '{strUserName}', '{strGetGeneratedKey}', '{strBuildPassword}'";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                        return Ok(new { hidForgetPassword = "1" });
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                        return Ok(new { hidForgetPassword = "0" });
                    }
                }
                else if (m_strIsValid != "1")
                {
                    return Ok(new { hidForgetPassword = "2" });
                }
                else if (m_strValidEmailID == "0" && m_strIsValid == "1")
                {
                    return Ok(new { hidForgetPassword = "3" });
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return InternalServerError(ex);
            }

            return BadRequest("No valid response.");
        }
        //End of Added By Aditya J. on 06-11-2024 For VAPT

        //Added by Aditya J. on 06-11-2024 for VAPT
        //[Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateHeaders]
        [HttpPost]
        public IHttpActionResult ReSetPasswordMobile([FromBody] EmployeeDetails parameters)
        {
            try
            {
                int counter;
                string strbuildpassword;
                string strlogin = "";
                string strSqlquery = "";
                string strToEmailId = "";
                string strCCToEmailId = "";
                string strSubject = "";
                string strEmailMessage = "";
                string strRndNumber = ((int)(new Random().NextDouble() * 10)).ToString();
                string strloginName = parameters.UserName;

                for (counter = 1; counter <= 1; counter++)
                {
                    strRndNumber += strRndNumber + ((int)(new Random().NextDouble() * 1000)).ToString();
                }

                CreateNewPassword objCreateNewPassword = new CreateNewPassword();
                strbuildpassword = objCreateNewPassword.CreatePassword();

                //// Password Encryption
                //PWEncryption objPW = new PWEncryption(strloginName, strbuildpassword);
                //string strEncryptedPW = objPW.Encrypt.ToString();
                //objPW = null;

                // Password Encryption
                var objPW = new PWEncryption(strloginName, strbuildpassword);
                string strEncryptedPW = objPW.Encrypt();
                objPW = null;

                string strmailstatus = "";
                string m_strvalidemailID = "";
                string strUserName = "";

                string stremailstatusquery = "EXEC usp_Sel_GetLoginUserEmailInfo '" + strloginName.Trim() + "'";
                using (IDataReader dr = CommonFunctions.Data.GetDataReader(stremailstatusquery, true,CommonController.connectionString))
                {
                    while (dr.Read())
                    {
                        strmailstatus = CommonFunctions.Data.CheckIsDBNull(dr["EmailID"], "").ToString();
                        strUserName = CommonFunctions.Data.CheckIsDBNull(dr["UserName"], "").ToString();
                    }
                }

                if (strloginName.Trim() != strUserName.Trim())
                {
                    return Ok(new { hidForgetPasswordMobile = "2" });
                }

                if (!string.IsNullOrEmpty(strmailstatus) && parameters.EmailID.Trim() != strmailstatus.Trim())
                {
                    return Ok(new { hidForgetPasswordMobile = "4" });
                }

                if (!string.IsNullOrEmpty(strmailstatus))
                {
                    strSqlquery = "DECLARE @intReturn INT\n";
                    strSqlquery += "EXEC usp_upd_ActivePassword '" + strloginName + "','" + strEncryptedPW + "', @intReturn OUTPUT\n";
                    strSqlquery += "SELECT 'Status' = @intReturn";
                    m_strIsValid = CommonFunctions.Data.GetDataScalar(strSqlquery, true,CommonController.connectionString).ToString();
                    m_strvalidemailID = "1";
                }
                else
                {
                    strSqlquery = "DECLARE @intReturn INT\n";
                    strSqlquery += "EXEC usp_sel_validlogin '" + strloginName + "', @intReturn OUTPUT\n";
                    strSqlquery += "SELECT 'Status' = @intReturn";
                    m_strIsValid = CommonFunctions.Data.GetDataScalar(strSqlquery, true,CommonController.connectionString).ToString();
                    m_strvalidemailID = "0";
                }

                if (m_strIsValid == "1" && m_strvalidemailID == "1")
                {
                    string strFromEmailId=string.Empty;
                    bool blnSendMail = false;
                    bool blnShowPopUp = false;

                    string strSQL = "usp_Sel_tbl_PM_EmailMessages 443";
                    using (IDataReader objDr = CommonFunctions.Data.GetDataReader(strSQL, true,CommonController.connectionString))
                    {
                        if (objDr.Read())
                        {
                            blnSendMail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDr["SendMail"], "0"));
                            blnShowPopUp = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(objDr["ShowPopup"], "0"));
                        }
                    }

                    string strUniuqeID = Guid.NewGuid().ToString();
                    strbuildpassword = objCreateNewPassword.CreatePassword();
                    PWEncryption strGenUserName = new PWEncryption(strUserName, strbuildpassword);
                    string strNewGenUserName = strGenUserName.Encrypt();

                    PWEncryption strGenUniuqeID = new PWEncryption(strUniuqeID, strbuildpassword);
                    string strNewgenUniuqeID = strGenUniuqeID.Encrypt();

                    string strGenratedKey = strNewGenUserName + strEncryptedPW + strNewgenUniuqeID;

                    string logo = string.Empty;                    

                    EmailMessagesController.GetEmailMessageRes_443(
                            ref strFromEmailId, ref strToEmailId, ref strSubject, ref strEmailMessage, strloginName,
                            strbuildpassword, strGenratedKey, ref logo);
                 
                    EmailMessagesController.AppSendEmailWithAttachmentCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject,
                        strEmailMessage, logo);

                    strSQL = $"usp_Ins_tbl_PM_ResetPasswordDetails '{strEncryptedPW}', '{strUniuqeID}', '{strUserName}', '{strGenratedKey}', '{strbuildpassword}'";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true);

                    return Ok(new { hidForgetPasswordMobile = "1" });
                }
                else if (m_strIsValid != "1")
                {
                    return Ok(new { hidForgetPasswordMobile = "2" });
                }
                else if (m_strvalidemailID == "0" && m_strIsValid == "1")
                {
                    return Ok(new { hidForgetPasswordMobile = "3" });
                }
            }
            catch (Exception ex)
            {
                return Redirect("Default.aspx");
            }

            return Ok(new { hidForgetPasswordMobile = "0" });
        }


        //End of Added by Aditya J. on 06-11-2024 for VAPT

        //Added by Aditya J. on 06-11-2024 for VAPT
        //[Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateHeaders]
        [HttpPost]
        public IHttpActionResult SetPassword([FromBody] EmployeeDetails parameters)
        {
            // Encrypt the password

            // Retrieve form data
            string strOldPassword = parameters.OldPassword;
            string strNewPassword = parameters.NewPassword;
            string strCount = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form["NonDatabase3"]);
            string strencryptedkey = "";
            string strencryptedlength = "";
            string struniqueid = "";
            bool IsValid = false;
            string result = "";

            // Check LDAP Login
            struniqueid = XMLHttp.m_LoginHashTable[parameters.UserName] as string;

            // Password encryption
            //strencryptedkey = strNewPassword.Substring(1, Convert.ToInt32(strCount));

            // Process new password
            string[] strpwd1 = strNewPassword.Split('|');
            strNewPassword = "";
            for (int i = 0; i < strpwd1.Length - 1; i++)
            {
                strNewPassword += strpwd1[i].Substring(0, 1);
            }
            strNewPassword = new string(strNewPassword.Reverse().ToArray());

            // Process old password
            string[] strpwd2 = strOldPassword.Split('|');
            strOldPassword = "";
            for (int i = 0; i < strpwd2.Length - 1; i++)
            {
                strOldPassword += strpwd2[i].Substring(0, 1);
            }
            strOldPassword = new string(strOldPassword.Reverse().ToArray());

            // Encryption of passwords
            var objEncryptOldPassword = new Authentication.PWEncryption(parameters.UserName, strOldPassword);
            var objEncryptNewPassword = new Authentication.PWEncryption(parameters.UserName, strNewPassword);

            string strEncryptedOldPassword = objEncryptOldPassword.Encrypt();
            string strEncryptedNewPassword = objEncryptNewPassword.Encrypt();

            // Dispose encryption objects
            objEncryptOldPassword = null;
            objEncryptNewPassword = null;

            // Change the password
            string strSQL = "DECLARE @intReturn INT\n";
            strSQL += $"EXEC usp_ChangePassword '{parameters.UserName}', '{strEncryptedOldPassword}', '{strEncryptedNewPassword}', @intReturn OUTPUT\n";
            strSQL += "SELECT 'Status' = @intReturn";

            string m_strStatus = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true,CommonController.connectionString));

            // Check if password change was successful
            if (m_strStatus == "1")
            {
                strSQL = $"EXEC usp_Upd_ChangeIsloginforfirsttime_False '{CommonFunctions.General.CheckIsNothing(parameters.UserName)}', '{strEncryptedNewPassword}'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true,CommonController.connectionString);
            }

            //HttpContext.Current.Response.Write($"<input type='hidden' id='hidChangePassword' value='{m_strStatus}'/>");
            return Ok(new { hidChangePassword = m_strStatus });
        }
        //End of Added by Aditya J. on 06-11-2024 for VAPT

        //Added by Aditya J. on 06-11-2024 for VAPT
        //[Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateHeaders]
        [HttpPost]
        public IHttpActionResult SetPasswordMobile([FromBody] EmployeeDetails parameters)
        {
            // Retrieve form data
            string strOldPassword = parameters.OldPassword;
            string strNewPassword = parameters.NewPassword;
            string strCount = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form["NonDatabase3Mobile"]);
            string strencryptedkey = "";
            string strencryptedlength = "";
            string struniqueid = "";
            bool IsValid = false;
            string m_strStatus = "";

            // Retrieve unique ID from the shared Hashtable
            struniqueid = XMLHttp.m_LoginHashTable[parameters.UserName] as string;

            // Encrypt new password
            //strencryptedkey = strNewPassword.Substring(1, int.Parse(strCount));

            // Process the new password
            string[] strpwd1 = strNewPassword.Split('|');
            strNewPassword = "";
            for (int i = 0; i < strpwd1.Length - 1; i++)
            {
                strNewPassword += strpwd1[i].Substring(0, 1);
            }
            strNewPassword = ReverseString(strNewPassword);

            // Process the old password
            string[] strpwd2 = strOldPassword.Split('|');
            strOldPassword = "";
            for (int i = 0; i < strpwd2.Length - 1; i++)
            {
                strOldPassword += strpwd2[i].Substring(0, 1);
            }
            strOldPassword = ReverseString(strOldPassword);

            // Encrypt passwords
            var objEncryptOldPassword = new Authentication.PWEncryption(parameters.UserName, strOldPassword);
            var objEncryptNewPassword = new Authentication.PWEncryption(parameters.UserName, strNewPassword);
            string strEncryptedOldPassword = objEncryptOldPassword.Encrypt();
            string strEncryptedNewPassword = objEncryptNewPassword.Encrypt();

            // Change the password
            string strSQL = "DECLARE @intReturn INT\n";
            strSQL += $"EXEC usp_ChangePassword '{parameters.UserName}', '{strEncryptedOldPassword}', '{strEncryptedNewPassword}', @intReturn OUTPUT\n";
            strSQL += "SELECT 'Status' = @intReturn";

            m_strStatus = CommonFunctions.Data.GetDataScalar(strSQL, true,CommonController.connectionString)?.ToString();

            // Update password policy status
            if (m_strStatus == "1")
            {
                strSQL = $"EXEC usp_Upd_ChangeIsloginforfirsttime_False '{CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form["txtLoginNameMobile"])}', '{strEncryptedNewPassword}'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true,CommonController.connectionString);
            }

            // Return the result in JSON format
            return Ok(new { hidChangePasswordMobile = m_strStatus });
        }

        private string ReverseString(string input)
        {
            char[] charArray = input.ToCharArray();
            Array.Reverse(charArray);
            return new string(charArray);
        }
        //End of Added by Aditya J. on 06-11-2024 for VAPT

        public string GetUserNameToken(string pageUrl)
        {

            const string SECRET_CODE = "H3#@*LLSlifeline31q4l1ncL#123456789@RFHF#N3fNM><#WH$O@#!FN#LNl33N#LNFl#J#Y$#IOHhnf;123456789;3qrthl3qFramework123456789"; // Replace with your actual secret code
            string strToken = string.Empty;

            try
            {
                // Combine the secret code and the page URL
                string strInput = $"{SECRET_CODE}{pageUrl}{SECRET_CODE}";

                // Create a SHA256 hash of the input
                using (var sha256Hasher = System.Security.Cryptography.SHA256.Create())
                {
                    byte[] hashBytes = sha256Hasher.ComputeHash(System.Text.Encoding.UTF8.GetBytes(strInput));
                    strToken = Convert.ToBase64String(hashBytes).TrimEnd('=');

                    // Remove unwanted characters from the token
                    strToken = strToken.Replace("+", string.Empty)
                                       .Replace("#", string.Empty)
                                       .Replace("&", string.Empty);
                }
            }
            catch (Exception ex)
            {
                // Log the exception (consider using a logging framework)
                strToken = string.Empty; // Optionally reset the token in case of an error
            }

            return strToken;
        }


    }

    //Added by Aditya J. on 06-11-2024 for VAPT
    public class CreateNewPassword
    {
        private int minStringLength;
        private int m_intNumberOfAlpha;
        private int m_intNumberOfNumerals;
        private int m_intNumberOfSpecialChars;
        private bool m_blnEnableAlphaNumSpeChar;
        private string strSpecialCharacters;

        public string CreatePassword()
        {
            int extraCharCount = minStringLength - (m_intNumberOfAlpha + m_intNumberOfNumerals + m_intNumberOfSpecialChars);
            string strRandomAlphabates;
            string strRandomNumerals;
            string strRandomSpecialChars;
            string strRandomExtraChars;
            string finalString;

            if (m_blnEnableAlphaNumSpeChar)
            {
                // Specific number of Random Alphabets
                strRandomAlphabates = RandomString(m_intNumberOfAlpha);

                // Specific number of Random Numerals
                strRandomNumerals = RandomNumbers(m_intNumberOfNumerals);

                // Specific number of Random Special Characters
                strRandomSpecialChars = RandomSpecialCharacters(m_intNumberOfSpecialChars);

                // Random extra characters if needed
                strRandomExtraChars = RandomExtraCharacters(extraCharCount);
            }
            else
            {
                // Default values for Random Alphabets, Numerals, and Special Characters
                strRandomAlphabates = RandomString(3);
                strRandomNumerals = RandomNumbers(2);
                strRandomSpecialChars = RandomSpecialCharacters(1);
                strRandomExtraChars = string.Empty;
            }

            // Combine all parts of the password
            finalString = strRandomAlphabates + strRandomNumerals + strRandomSpecialChars + strRandomExtraChars;

            // Shuffle the final string to randomize the order of characters
            finalString = ShuffleString(finalString);

            return finalString;
        }

        private string RandomString(int count)
        {
            Random prng = new Random();

            // Valid chars in random string
            const string randCH = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < count; i++)
            {
                sb.Append(randCH[prng.Next(randCH.Length)]);
            }
            return sb.ToString();
        }

        private string RandomNumbers(int count)
        {
            Random prng = new Random();

            // Valid numbers in random string
            const string randCH = "1234567890";

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < count; i++)
            {
                sb.Append(randCH[prng.Next(randCH.Length)]);
            }
            return sb.ToString();
        }

        private string RandomSpecialCharacters(int count)
        {
            Random prng = new Random();
            strSpecialCharacters = ConfigurationManager.AppSettings["SpecialCharactersList"];

            string randCH = strSpecialCharacters;

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < count; i++)
            {
                sb.Append(randCH[prng.Next(randCH.Length)]);
            }
            return sb.ToString();
        }

        private string RandomExtraCharacters(int count)
        {
            Random prng = new Random();

            // Valid chars in random string
            string randCH = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890" + strSpecialCharacters;

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < count; i++)
            {
                sb.Append(randCH[prng.Next(randCH.Length)]);
            }
            return sb.ToString();
        }


        private string ShuffleString(string strInput)
        {
            string strOutput = string.Empty;
            Random rand = new Random();

            while (strInput.Length > 0)
            {
                int intPlace = rand.Next(strInput.Length);
                strOutput += strInput[intPlace];
                strInput = strInput.Remove(intPlace, 1);
            }

            return strOutput;
        }

    }
    //End of Added by Aditya J. on 06-11-2024 for VAPT
}
