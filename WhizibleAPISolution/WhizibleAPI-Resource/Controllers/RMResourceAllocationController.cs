using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Net;
using System.Net.Http;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.IO;
using System.Xml;
using CommonFunctions;
using System.Collections;
using Microsoft.Identity.Client;

namespace WhizibleAPI.Controllers
{

    public class RMResourceAllocationController : ApiController
    {
        // Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Resource API
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
            const string logSource = "WhizibleAPI-Resource.RMResourceAllocationController";
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
        // End of Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Resource API

        /// <summary>Purpose: Apply probable/exact-match vendor filter when result set exposes VendorID (same semantics as Search More vendor filter).</summary>
        private static DataTable FilterAllocationTableByVendorId(DataTable source, int vendorId)
        {
            if (source == null || vendorId == 0)
            {
                return source;
            }
            if (!source.Columns.Contains("VendorID"))
            {
                return source;
            }
            DataRow[] matches = source.Select("VendorID = " + vendorId);
            if (matches.Length == 0)
            {
                return source.Clone();
            }
            return matches.CopyToDataTable();
        }

        [HttpPost]
        [Authorize,App_Start.ValidateHeaders]
        public object GetExtendRequest([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "";
                if (Convert.ToString(ResourceParameters.Status) != "D")
                {
                    if (Convert.ToString(ResourceParameters.Status) == "P")
                    {
                        strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequests_PreponeAllocation " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                    }
                    else if (Convert.ToString(ResourceParameters.Status) == "CHANGE")
                    {
                        strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequests_ChangeAllocation " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                    }
                    else if (Convert.ToString(ResourceParameters.Status) == "R" || Convert.ToString(ResourceParameters.Status) == "Replace" || Convert.ToString(ResourceParameters.Status) == "NBD")
                    {
                        //strSQL = "EXEC usp_Sel_tbl_PM_ResourceRequests " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                        strSQL = "EXEC usp_whizible2_Sel_tbl_PM_ResourceRequests " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                    }
                    else
                    {
                        strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequestsAllocation " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                    }
                }
                else
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequests_Deferred_Allocation " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "";
                }



                if (Convert.ToString(ResourceParameters.Fromwhereclause) != "")
                {
                    if (Convert.ToString(ResourceParameters.Status) == "Replace")
                    {
                        ResourceParameters.Fromwhereclause += " AND TypeofRequirement=2 ";
                    }
                    else if (Convert.ToString(ResourceParameters.Status) == "NBD")
                    {
                        ResourceParameters.Fromwhereclause += " AND TypeofRequirement=3 ";
                    }
                    //else if (Convert.ToString(ResourceParameters.Status) == "R")
                    //{
                    //    ResourceParameters.Fromwhereclause += " AND ISNULL(TypeofRequirement,1)=1 ";
                    //}
                    strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.Fromwhereclause)) + "'";

                }
                else
                {
                    if (Convert.ToString(ResourceParameters.Status) == "Replace")
                    {
                        strSQL += ",' TypeofRequirement=2 '";
                    }
                    else if (Convert.ToString(ResourceParameters.Status) == "NBD")
                    {
                        strSQL += ",' TypeofRequirement=3 '";
                    }
                    //else if (Convert.ToString(ResourceParameters.Status) == "R")
                    //{
                    //    strSQL += ", ' ISNULL(TypeofRequirement,1)=1 ' ";
                    //}
                    else
                    {
                        strSQL += ", NULL";
                    }

                }

                if (Convert.ToString(ResourceParameters.Status) == "Replace" || Convert.ToString(ResourceParameters.Status) == "NBD")
                {
                    ResourceParameters.Status = "R";
                }

                if (Convert.ToString(ResourceParameters.Status) == "CHANGE")
                {
                    strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.OrderBy)) + "'";
                }
                else
                {
                    strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.Status)) + "','" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.OrderBy)) + "'";

                }

                if (Convert.ToString(ResourceParameters.ProjectName) != "")
                {
                    strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectName)) + "'";

                }
                else
                {
                    strSQL += ", NULL";
                }

                if (Convert.ToString(ResourceParameters.RequestID) != "")
                {
                    strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "'";

                }
                else
                {
                    strSQL += ", NULL";
                }

                if (Convert.ToString(ResourceParameters.NatureOfRequest) != "")
                {
                    strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.NatureOfRequest)) + "'";

                }
                else
                {
                    strSQL += ", NULL";
                }


                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetDetails([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "";
                if (Convert.ToString(ResourceParameters.WhichTab) == "Extend")
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequest_ExtensionBooking_allocation NULL," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "";
                }
                else if (Convert.ToString(ResourceParameters.WhichTab) == "ChangeAllocation")
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequest_ChangeAllocationType NULL," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "";
                }
                else if (Convert.ToString(ResourceParameters.WhichTab) == "Allocation")
                {
                    strSQL = "EXEC usp_Whizible2_sel_tbl_PM_ResourceRequestDetailsAllocation NULL,'A.RequestID= " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "'";
                }
                else if (Convert.ToString(ResourceParameters.WhichTab) == "Prepone")
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequest_ExtensionBookingAllocation NULL," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "";
                }
                else if (Convert.ToString(ResourceParameters.WhichTab) == "Close")
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ResourceRequest_CloseAllocation " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "";
                }
                else
                {
                    //strSQL = "EXEC usp_sel_tbl_PM_ResourceRequestDetails NULL,'A.RequestID=" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "'";
                    strSQL = "EXEC usp_Whizible2_sel_tbl_PM_ResourceRequestDetailsAllocation NULL,'A.RequestID=" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "'";

                }
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object DeclineRequest([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Upd_tbl_PM_ResourceRequest_RejectRequest " + ResourceParameters.RequestID + ",'" + ResourceParameters.Comments.Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                string result;
                string Flag="0";
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                //return result;
                string strSubject = "", strMessage = "", intUserID = "";

                bool blnSendEmail, blnShowPopup;

                //Getting Email messages
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 539", true, CommonController.connectionString);
                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            Flag = "1";
                        }
                        else
                        {
                            //EmailMessagesController.GetEmailMessage_539(strFromEmailID, strToEmailID, strCCToEmailID, strMailSubject, strEmailMessage, m_lngRequestId, strEmployeeIdList)
                            // EmailMessagesController.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strMailSubject, strEmailMessage)
                        }
                    }
                }

                return Flag;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }




        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetNewAllocationValue([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Sel_ProjectEmployeeRole_ChangeAllocation " + ResourceParameters.ProjectEmployeeRoleID + "," + ResourceParameters.ProjectID + "";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetOldAllocationDetails([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_getOldAllocationDetails " + ResourceParameters.ProjectEmployeeRoleID + "," + ResourceParameters.RequestID + "";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetCurrentFinalcialYear()
        {
            try
            {
                string strSQL = "EXEC Usp_GetCurrentFinalcialYear ";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }




        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GettabsDetails([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_Request_type " + ResourceParameters.EmployeeID + "";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }



         [HttpPost, Authorize]
        public object AllocateRequest([FromBody] ResourcesDetails ResourceParameters)
        {
            string strQuery = "EXEC usp_Sel_GetResourceBalanceHours '" + ResourceParameters.PStartDate + "','" + ResourceParameters.PEndDate + "'," + ResourceParameters.SelectedProjectRoleID + "";
            return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
        }



        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetMaxUnits([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Get_MaxUnits_For_AllocationType '" + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestType)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetConfigureDays([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Get_tbl_PM_ResourceRequestConfiguredMaxDays " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.RequestID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID)) + ",'" + ResourceParameters.m_strResourceAllocationLevel + "'";
                object dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveBGEsaclations([FromBody] ConfigureDaysParam request)
        {
            try
            {
                string strQuery = "EXEC usp_Whizible2_UPD_tbl_PM_ResourceRequestEscalationComments '" + request.Comments + "'," + request.RequestID + ",'" + request.m_strResourceAllocationLevel + "'," + request.IsEscalateToGRP + "";
                return CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetApproverForEscalation([FromBody] ConfigureDaysParam request)
        {
            try
            {
                string strQuery = "EXEC usp_Whizible2_sel_approvers " + request.RequestID + ",'" + request.m_strResourceAllocationLevel + "'";
                return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

         [Authorize,App_Start.ValidateHeaders]
        public object ConvertDecimalToHourViceVersa([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_ConvertDecimalToHourViceVersa '"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.WorkHrs)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.Flag));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        List<SkillGraph> Data = new List<SkillGraph>();
        [HttpPost]
        //public List<SkillGraph> GetSkillGraph([FromBody] object[] StatusData)
        public object GetSkillGraph([FromBody] int requestId)
        {
            try
            {
                string query = "EXEC usp_Whizible_sel_SkillGraphv_QRB_TotalEmployeeSkillsView  " + (requestId == 0 ? "" : requestId.ToString());
                DataTable DataStatus = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                foreach (DataRow userlistRow in DataStatus.Rows)
                {
                    SkillGraph usrlist = new SkillGraph();

                    usrlist.Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Description"], ""));
                    usrlist.NoOfResources = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["NoOfResources"], "0"));

                    Data.Add(usrlist);
                }

                return Data;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

         [HttpPost, Authorize]
        public object GetSkills([FromBody] int requestId)
        {
            string strQuery = "EXEC usp_Sel_tbl_PM_ResourceRequestDetails_Skills " + requestId;
            return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
        }

         [HttpPost, Authorize]
        public object GetAllocatedResources([FromBody] int requestId)
        {
            string strQuery = "EXEC usp_Whizible2_Sel_tbl_PM_AssignedResources " + requestId;
            return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
        }

         [HttpPost, Authorize]
        public object GetSimilarRequest([FromBody] SimilerRequestParam request)
        {
            string strQuery = "EXEC usp_Sel_SimilarRequests " + request.RequestID + "," + request.UserId;
            return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
        }

         [HttpPost, Authorize]
        public object GetProbableResources([FromBody] ParallelResourceParam request)
        {
            //Commented & Added By Dipali V On 11th May 2023 SP Rename for SP logic Change
            //string strQuery = "EXEC usp_Sel_GetResourcesForAllocation " + request.RequestID + "," + request.UserId + ",'EmployeeID'";
            //string strQuery = "EXEC usp_Sel_GetResourcesForAllocation " + request.RequestID + "," + request.UserId + ",'EmployeeID',0,0,null, NULL,'"+ request.m_strFromDate + "','" + request.m_strToDate + "' ";
            string strQuery = "EXEC usp_Whizible2_Sel_GetResourcesForAllocation " + request.RequestID + "," + request.UserId + ",'EmployeeID',0,0,null, NULL,'"+ request.m_strFromDate + "','" + request.m_strToDate + "' ";
            // Added by Dipali V on 13th May 2026 - Purpose:-Last SP argument = vendor from Probable tab dropdown (0 / NULL = no vendor filter; implement filter inside usp_Whizible2_Sel_GetResourcesForAllocation).
            if (request.VendorID != 0)
            {
                strQuery += "," + request.VendorID.ToString();
            }
            else
            {
                strQuery += ", NULL";
            }
            //End of Commented & Added By Dipali V On 11th May 2023 SP Rename for SP logic Change
            DataTable dt = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
            if (request.EmployeeName != "")
            {
                if (dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").Length > 0)
                    return dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").CopyToDataTable();
                else
                    return new ArrayList();
            }
            return dt;
        }

         [HttpPost, Authorize]
        public object GetExactResources([FromBody] ParallelResourceParam request)
        {
            string strQuery = "EXEC usp_Sel_GetResourcesForAllocationExact " + request.RequestID + "," + request.UserId + ",'EmployeeID'";
            DataTable dt = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
            // Added by Dipali V on 13th May 2026 - Purpose:-Filter exact-match resources by vendor chosen on Exact Match tab (VendorID column when returned by SP).
            dt = FilterAllocationTableByVendorId(dt, request.VendorID);
            if (request.EmployeeName != "")
            {
                if (dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").Length > 0)
                    return dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").CopyToDataTable();
                else
                    return new ArrayList();
            }
            return dt;
        }

         [HttpPost, Authorize]
        public object SaveConfigureDays([FromBody] ConfigureDaysParam request)
        {
            string strQuery = "EXEC usp_Upd_tbl_PM_ResourceRequest_ConfiguredDays " + request.RequestID + "," + request.ConfigureDays + "";
            return CommonFunctions.Data.InsertOrUpdateData(strQuery, true, CommonController.connectionString);
        }

         [HttpPost, Authorize]
        public object GetMinAllocation([FromBody] AllocationProperties request)
        {
            double minAllocation = 0;
            string TYPE_PER_DAY = "HPD";
            string TYPE_PERCENT_WORKHOURS = "P";
            string strQuery = "EXEC usp_Sel_MinAllocation_For_Employee " + request.EmployeeId + ",'" + request.FromDate + "','" + request.ToDate + "'," + request.ProjectId + "";
            IDataReader reader = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (reader.Read())
            {
                if (request.m_strType == TYPE_PER_DAY)
                    minAllocation = Convert.ToDouble(reader["MinAvailablePerDayHrs"]);
                else if (request.m_strType == TYPE_PERCENT_WORKHOURS)
                    minAllocation = Convert.ToDouble(reader["MinAvailablePercentage"]);
            }
            return minAllocation;
        }

         [HttpPost, Authorize]
        public object GetProjectInformation([FromBody] RequestProperties requestProperties)
        {
            IDataReader drProject;
            string strQuery = "";
            string m_strProjectStartDate = "";
            string m_strProjectEndDate = "";
            long m_lngRequestTeamID = 0;
            double m_dblProjectWorkHours = 0;
            strQuery = "EXEC usp_Sel_tbl_PM_ProjectExpectedDates " + requestProperties.ProjectId.ToString();
            drProject = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (drProject.Read())
            {
                m_strProjectStartDate = drProject["ExpectedStartDate"].ToString();
                //m_strProjectStartDate = CommonFunctions.Dates.GetDate(System.Convert.ToDateTime(m_strProjectStartDate));
                m_strProjectEndDate = drProject["ExpectedEndDate"].ToString();
                //m_strProjectEndDate = CommonFunctions.Dates.GetDate(Convert.ToDateTime(drProject["ExpectedEndDate"].ToString()));
                m_lngRequestTeamID = System.Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(drProject["ResourceGroupID"], "0"));
            }
            CommonFunctions.Data.DisposeDataReader(ref drProject);

            strQuery = "Exec usp_Sel_tbl_PM_GetWorkingHours " + requestProperties.ProjectId.ToString();
            m_dblProjectWorkHours = System.Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString), "0"));
            strQuery = "usp_tbl_pm_assignedresources_workhours " + requestProperties.RequestID;
            double TotalHours = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString), "0"));
            return new
            {
                m_strProjectStartDate = m_strProjectStartDate,
                m_strProjectEndDate = m_strProjectEndDate,
                m_lngRequestTeamID = m_lngRequestTeamID,
                m_dblProjectWorkHours = m_dblProjectWorkHours,
                TotalHours = TotalHours
            };
        }

        [HttpPost, Authorize]
        public object AllocateResources([FromBody] AllocateResource request)
        {
            bool blnShowPopup = false;
            bool blnSendEmail = false;
            string strToEmailID = "", strCCToEmailID = "", strFromEmailID = "", strMailSubject = "", strEmailMessage = "";
            string query = "Exec usp_Sel_tbl_PM_EmailMessages 76";
            IDataReader drEmail = CommonFunctions.Data.GetDataReader(query, true, CommonController.connectionString);
            if (drEmail.Read())
            {
                blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drEmail["SendMail"], "False"));
                blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drEmail["ShowPopup"], "False"));
            }
            CommonFunctions.Data.DisposeDataReader(ref drEmail);
            string strTempMessage = "";
            int m_lngRequestId = 0;
            string strEmployeeIdList = "";
            foreach (var item in request.allocateResourceParams)
            {
                m_lngRequestId = item.RequestID;
                string strQuery = "";
                int lngEmployeeId = item.EmployeeId;
                if (strEmployeeIdList == "")
                {
                    strEmployeeIdList = lngEmployeeId.ToString();
                }
                else
                {
                    strEmployeeIdList += "," + lngEmployeeId.ToString();
                }
                strQuery = "Exec usp_Ins_tbl_PM_AssignedResources " + item.RequestID.ToString();
                strQuery += ", " + item.ProjectID;
                strQuery += ", " + lngEmployeeId.ToString();
                strQuery += ", '" + item.FromDate + "'";
                strQuery += ", '" + item.ToDate + "'";
                strQuery += ", '" + item.WorkHours + "'";
                strQuery += ", NULL, " + item.ProjectRoleId.ToString();
                strQuery += ",'" + item.status + "'";

                string strTemp = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, true, CommonController.connectionString));
                if (strTemp != "")
                {
                    strTempMessage += "<li>" + strTemp + "</li>";
                }
            }
            if (blnSendEmail)
            {
                if (blnShowPopup)
                {
                    return new { message = strTempMessage, isError = false, EmployeeIds = strEmployeeIdList, blnShowPopup = blnShowPopup };
                }
                else
                {
                    GetEmailMessage_76(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strMailSubject, ref strEmailMessage, m_lngRequestId, strEmployeeIdList);
                    SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strMailSubject, strEmailMessage);
                }
            }
            return new { message = strTempMessage, isError = true, blnShowPopup = false, EmployeeIds = "" };
        }

        [HttpPost, Authorize]
        public object GetSkillsSearchMore([FromBody] RequestProperties requestProperties)
        {
            string sqlQuery = "EXEC usp_Sel_tbl_PM_ProjectSkills " + requestProperties.ProjectId.ToString() + ", " + requestProperties.RequestID.ToString();
            return CommonFunctions.Data.GetDataTable(sqlQuery, true, CommonController.connectionString);
        }

        [HttpPost, Authorize]
        public object GetProbableResourcesSearchMore([FromBody] ParallelResourceParam request)
        {
            string strTempQuery = "";
            IDataReader drSkills;
            string strQuery = "";
            string[] arrSkillID;
            int intCnt = 0;
            string strName = "";
            int intExpYrs, intExpMonths, intRating;
            // Following are the strings containing comma seperated values entered by user for filters 
            // corresponding to the skills
            string strSkillIds = "";
            string strExpYrs = "";
            string strExpMonths = "";
            string strRatings = "";

            strQuery = "Exec usp_Sel_GetResourcesForAllocation_SearchMore  " + request.RequestID.ToString();
            // Logged in Users ID
            if (request.UserId != 0)
                strQuery += "," + request.UserId;
            else
                strQuery += ", null";
            // Sorting
            //strQuery += ", 'EmployeeId'";
            strQuery += ", 'Role ASC'";

            if (request.m_intSelectEmployeeType == 3)
                strQuery += ",1,1";
            else
                strQuery += ",0,1";
            if (request.m_lngRoleId != 0)
                strQuery += "," + request.m_lngRoleId.ToString();
            else
                strQuery += ", NULL";
            if (request.m_lngLocationId != 0 && request.flag == 'S')
                strQuery += "," + request.m_lngLocationId.ToString();
            else
                strQuery += ", NULL";

            strQuery += ",'" + request.m_strFromDate + "'";
            strQuery += ",'" + request.m_strToDate + "'";

            if (request.m_dblWorkHoursForFilter != -1)
                strQuery += "," + request.m_dblWorkHoursForFilter.ToString();
            else
                strQuery += ", -1";
            if (request.m_strType != "")
                strQuery += ",'" + request.m_strType + "'";
            else
                strQuery += ", NULL";

            //if (request.m_lngDepartmentId != 0)
            //    strQuery += "," + request.m_lngDepartmentId.ToString();
            //else
                strQuery += ", 0";
            if (request.IsPostBack == true)
            {
                strSkillIds = request.strSkillIds;
                strExpYrs = request.strExpYrs;
                strExpMonths = request.strExpMonths;
                strRatings = request.strRatings;
            }
            //if (request.Fromwhere == "1")
            //{
            //    strSkillIds = request.strSkillIds;
            //    strExpYrs = request.strExpYrs;
            //    strExpMonths = request.strExpMonths;
            //    strRatings = request.strRatings;
            //}


            else
            {
                strTempQuery = "EXEC usp_Sel_tbl_PM_ResourceRequestDetails_Skills " + request.RequestID.ToString();
                drSkills = CommonFunctions.Data.GetDataReader(strTempQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drSkills) != "")
                {
                    while (drSkills.Read())
                    {
                        intExpYrs = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["ExpYrs"], "0"));
                        intExpMonths = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["ExpMonths"], "0"));
                        intRating = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["Rating"], "0"));
                        if (!(intRating == 0 & intExpYrs == 0 & intExpMonths == 0))
                        {
                            strSkillIds += System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["SkillID"], "0")) + ",";
                            strExpYrs += intExpYrs.ToString() + ",";
                            strExpMonths += intExpMonths.ToString() + ",";
                            strRatings += intRating.ToString() + ",";
                        }
                    }

                    //Commented & Added By Dipali V On 16th March 2023 For Crash Issue
                    strSkillIds = request.strSkillIds;
                    strExpYrs = request.strExpYrs;
                    strExpMonths = request.strExpMonths;
                    strRatings = request.strRatings;

                    ////if (strSkillIds != "")
                    //{
                    //    strSkillIds = strSkillIds.Remove(strSkillIds.Length - 1);
                    //}
                    //if (strExpYrs != "")
                    //{
                    //    strExpYrs = strExpYrs.Remove(strExpYrs.Length - 1);
                    //}
                    //if (strExpMonths != "")
                    //{
                    //    strExpMonths = strExpMonths.Remove(strExpMonths.Length - 1);
                    //}
                    //if (strRatings != "")
                    //{
                    //    strRatings = strRatings.Remove(strRatings.Length - 1);
                    //}


                    //Added by imran on 30-12-2022
                    ////strSkillIds = strSkillIds.Remove(strSkillIds.Length - 1);
                    ////strExpYrs = strExpYrs.Remove(strExpYrs.Length - 1);
                    ////strExpMonths = strExpMonths.Remove(strExpMonths.Length - 1);
                    ////strRatings = strRatings.Remove(strRatings.Length - 1);
                    //End of comment by imran on 30-12-2022
                    //End of Commented & Added By Dipali V On 16th March 2023 For Crash Issue
                }
                CommonFunctions.Data.DisposeDataReader(ref drSkills);
            }
            strQuery += ",'" + strSkillIds + "'";
            strQuery += ",'" + strExpYrs + "'";
            strQuery += ",'" + strExpMonths + "'";
            strQuery += ",'" + strRatings + "'";

            // Business Group
            if (request.m_lngBusinessGroupId != 0)
                strQuery += "," + request.m_lngBusinessGroupId.ToString();
            else
                strQuery += ", null";

            // Resource Group
            if (request.m_lngResourceGroupId != 0)
                strQuery += "," + request.m_lngResourceGroupId.ToString();
            else
                strQuery += ", null";
            //Added By Nikhil Adkar for Adding Page numnber;
            if (request.EmployeeName != "")
                strQuery += ",'" + request.EmployeeName.ToString() + "'";
            else
                strQuery += ",null";

            if (request.PageNo != 0)
                strQuery += "," + request.PageNo.ToString();
            else
                strQuery += ", 0";
            //End of Added By Nikhil Adkar for Adding Page numnber;
            // Vendor filter (RM_ResourceAllocation.aspx passes VendorID from cboVendor_1)
            if (request.VendorID != 0)
                strQuery += "," + request.VendorID.ToString();
            else
                strQuery += ", NULL";
            DataTable dt = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
            //if (request.EmployeeName != "")
            //{
            //    if (dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").Length > 0)
            //        return dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").CopyToDataTable();
            //    else
            //        return new ArrayList();
            //}
            return dt;
        }

        //Added By Nikhil Adkar
        [HttpPost, Authorize]
        public object GetProbableResourcesSearchMore_Count([FromBody] ParallelResourceParam request)
        {
            string strTempQuery = "";
            IDataReader drSkills;
            string strQuery = "";
            string[] arrSkillID;
            int intCnt = 0;
            string strName = "";
            int intExpYrs, intExpMonths, intRating;
            // Following are the strings containing comma seperated values entered by user for filters 
            // corresponding to the skills
            string strSkillIds = "";
            string strExpYrs = "";
            string strExpMonths = "";
            string strRatings = "";
            strQuery = "Exec usp_Sel_GetResourcesForAllocation_SearchMore_Count  " + request.RequestID.ToString();
            // Logged in Users ID
            if (request.UserId != 0)
                strQuery += "," + request.UserId;
            else
                strQuery += ", null";
            // Sorting
            //strQuery += ", 'EmployeeId'";
            strQuery += ", 'Role ASC'";

            if (request.m_intSelectEmployeeType == 3)
                strQuery += ",1,1";
            else
                strQuery += ",0,1";
            if (request.m_lngRoleId != 0)
                strQuery += "," + request.m_lngRoleId.ToString();
            else
                strQuery += ", NULL";
            if (request.m_lngLocationId != 0 && request.flag == 'S')
                strQuery += "," + request.m_lngLocationId.ToString();
            else
                strQuery += ", NULL";
            strQuery += ",'" + request.m_strFromDate + "'";
            strQuery += ",'" + request.m_strToDate + "'";

            if (request.m_dblWorkHoursForFilter != -1)
                strQuery += "," + request.m_dblWorkHoursForFilter.ToString();
            else
                strQuery += ", -1";
            if (request.m_strType != "")
                strQuery += ",'" + request.m_strType + "'";
            else
                strQuery += ", NULL";

            //if (request.m_lngDepartmentId != 0)
            //    strQuery += "," + request.m_lngDepartmentId.ToString();
            //else
            strQuery += ", 0";
            if (request.IsPostBack == true)
            {
                strSkillIds = request.strSkillIds;
                strExpYrs = request.strExpYrs;
                strExpMonths = request.strExpMonths;
                strRatings = request.strRatings;
            }
            else
            {
                strTempQuery = "EXEC usp_Sel_tbl_PM_ResourceRequestDetails_Skills " + request.RequestID.ToString();
                drSkills = CommonFunctions.Data.GetDataReader(strTempQuery, true, CommonController.connectionString);
                if (CommonFunctions.General.CheckIsNothing(drSkills) != "")
                {
                    while (drSkills.Read())
                        {
                        intExpYrs = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["ExpYrs"], "0"));
                        intExpMonths = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["ExpMonths"], "0"));
                        intRating = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["Rating"], "0"));
                        if (!(intRating == 0 & intExpYrs == 0 & intExpMonths == 0))
                        {
                            strSkillIds += System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drSkills["SkillID"], "0")) + ",";
                            strExpYrs += intExpYrs.ToString() + ",";
                            strExpMonths += intExpMonths.ToString() + ",";
                            strRatings += intRating.ToString() + ",";
                        }
                    }
                    strSkillIds = request.strSkillIds;
                    strExpYrs = request.strExpYrs;
                    strExpMonths = request.strExpMonths;
                    strRatings = request.strRatings;

                    
                }
                CommonFunctions.Data.DisposeDataReader(ref drSkills);
            }
            strQuery += ",'" + strSkillIds + "'";
            strQuery += ",'" + strExpYrs + "'";
            strQuery += ",'" + strExpMonths + "'";
            strQuery += ",'" + strRatings + "'";

            // Business Group
            if (request.m_lngBusinessGroupId != 0)
                strQuery += "," + request.m_lngBusinessGroupId.ToString();
            else
                strQuery += ", null";

            // Resource Group
            if (request.m_lngResourceGroupId != 0)
                strQuery += "," + request.m_lngResourceGroupId.ToString();
            else
                strQuery += ", null";

            if (request.EmployeeName != "")
                strQuery += ",'" + request.EmployeeName.ToString() + "'";
            else
                strQuery += ",null";


            // Vendor filter (RM_ResourceAllocation.aspx passes VendorID from cboVendor_1)
            if (request.VendorID != 0)
                strQuery += "," + request.VendorID.ToString();
            else
                strQuery += ", NULL";

            DataTable dt = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
            //if (request.EmployeeName != "")
            //{
            //    if (dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").Length > 0)
            //        return dt.Select("EmployeeName like '%" + request.EmployeeName + "%'").CopyToDataTable();
            //    else
            //        return new ArrayList();
            //}
            if(dt.Rows.Count > 0)
            {
                intCnt = dt.Rows.Count;
            }
            else
            {
                intCnt = 0;
            }
            return intCnt;
        }
        //End of Added By Nikhil Adkar

        [HttpPost, Authorize]
        public object GetRequestInformation([FromBody] int m_lngRequestId)
        {
            object data = null;
            string strQuery = "EXEC usp_sel_tbl_PM_ResourceRequestDetails " + m_lngRequestId.ToString();
            IDataReader drRequest = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);
            if (drRequest.Read())
            {
                var result = new
                {
                    m_lngRoleId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drRequest["RoleID"], "0")),
                    m_lngLocationId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drRequest["LocationID"], "0")),
                    m_strFromDate = CommonFunctions.Dates.GetDate(Convert.ToDateTime(drRequest["FromDate"].ToString())),
                    m_strToDate = CommonFunctions.Dates.GetDate(Convert.ToDateTime(drRequest["ToDate"].ToString())),
                    m_dblWorkHours = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(drRequest["WorkHours"], "0")),
                    m_strType = CommonFunctions.General.UnBuildQueryString(drRequest["Type"].ToString()),
                    m_intTotalResourcesAssigned = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drRequest["TotalAssignedResources"], "0")),
                    m_intTotalResourcesRequested = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drRequest["NoOfResources"], "0")),
                    m_lngDepartmentId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drRequest["DepartmentID"], "0")),
                    m_lngVendorId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drRequest["VendorID"], "0")),
                    m_lngProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drRequest["ProjectID"], "0"))
                };
                data = result;
            }
            CommonFunctions.Data.DisposeDataReader(ref drRequest);
            return data;
        }

        // Added by Dipali V on 15th May 2026 - Purpose:-Project-scoped vendor dropdown for RM_ResourceAllocation (same SP as PM_RequestedResources GetVendorDropdown).
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetVendorDropdown([FromBody] VendorDropdownParameters requestParameters)
        {
            try
            {
                int includeVendorID = 0;
                int projectID = 0;
                if (requestParameters != null)
                {
                    includeVendorID = requestParameters.IncludeVendorID;
                    projectID = requestParameters.ProjectID;
                }
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectVendorDropdown " + projectID + "," + includeVendorID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost, Authorize]
        public object GetYears()
        {
            string strQuery = "Exec usp_Sel_GetYears 0,30";
            return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
        }

        [HttpPost, Authorize]
        public object GetMonths()
        {
            string strQuery = "Exec usp_Sel_GetYears 0,11";
            return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
        }

        [HttpPost, Authorize]
        public object GetRatings()
        {
            string strQuery = "Exec usp_Sel_tbl_HR_Parameters 7";
            return CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);
        }

        public static void SendEmailWithCC(string strToEmailID, string strCCEmailID, string strFromEmailID, string strSubject, string strEmailBody)
        {
            // Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Resource API
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
            // End of Added By Vyankat B. on 30th June 2026 for configurable SMTP / Azure Graph email delivery in Resource API

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
                    }

                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
            }
        }
        public static void GetEmailMessage_76(ref string strFromEmailID, ref string strToEmailID, ref string strCCToEmailID, ref string strSubject, ref string strEmailMessage, long intRequestID, string strEmployeeIDs)
        {
            // =====================================================================
            // Procedure Name		:	GetEmailMessage_76(Resource Assignment Notification)
            // Parameters Passed     :	strToEmailID	:- The EmailID of the person to whom the message will be returned.
            // strSubject		:- The Subject of the Email Message.
            // strEmailMessage	:- The body of the Email Message.	
            // intRequestID	:- The project ID of the new project.
            // strEmployeeIDS  :- comma seperated Employee IDS 						
            // Returns               :	
            // Parameters Affected   :	strToEmailID, strSubject, strEmailMessage :- These values are returned by the subroutine by reference.
            // Description           :	Generate the email message as defined in the System Email Messages table in the database.
            // Purpose               :	Generate the email message as defined in the System Email Messages table in the database.
            // Assumptions           :	The message ID exists in the database.
            // The message does not contain any other parameters besides the following :
            // 1.	<NAME>
            // 2.	<RESOURCENAME>
            // 3.	<CONFIGUREDDAYS>	
            // 

            // Dependencies          :	None.
            // Author                :   JayavantK
            // Created               :	12-April-2004
            // Revisions             :
            // =====================================================================		
            bool blnUseSQL = true;
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
            GetSenderInfo(ref strUserName, strFromEmailID);
            strMessage.Replace("<SENDER>", strUserName);
            // " & ExpenseSheetID.ToString() & "," & intApproverID.ToString()
            arrEmployeeIds = strEmployeeIDs.Split(System.Convert.ToChar(","));
            strEmployeeNames = "";
            for (intCnt = 0; intCnt <= arrEmployeeIds.Length - 1; intCnt++)
            {
                strQuery = "Exec usp_Sel_tbl_PM_EmployeeNameForAllocation " + arrEmployeeIds[intCnt] + "," + intRequestID.ToString();
                strUserName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, blnUseSQL));
                strEmployeeNames += strUserName + ", ";
            }
            strEmployeeNames = strEmployeeNames.Replace(",", System.Environment.NewLine);
            strMessage.Replace("<RESOURCENAME>", strEmployeeNames);

            // Added By JayavantK, On - 25-Aug-2004 - Start
            strCCToEmailID = "";
            drTemp = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_Employee_ResourceAllocation_EmailCc " + intRequestID.ToString(), blnUseSQL);
            while (drTemp.Read())
                strCCToEmailID += CommonFunctions.Data.CheckIsDBNull(drTemp["EmailID"], "").ToString() + ", ";
            CommonFunctions.Data.DisposeDataReader(ref drTemp);
            strCCToEmailID += strFromEmailID;
            strEmailMessage = strMessage.ToString();
            strSubject = strEmailSubject.ToString();
            strMessage = null;
            strEmailSubject = null;
        }
        public static void GetSenderInfo(ref string strEmailID, string UserID)
        {
            string strUserName = "";
            string strLoginType = "";
            long lngUserid;
            IDataReader objDr;
            string strSQL;
            strSQL = "SELECT LoginType FROM TBL_PM_lOGIN WHERE EmployeeID=" + UserID;
            objDr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
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
        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetFreeHoursForExtendedBooking([FromBody] ResourcesDetails RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_FreeHours_ExtendBooking '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetFreeHours([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_FreeHours_PreponeBooking '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateExtendedRequest([FromBody] ResourcesDetails RequestParameters)
        {
            try
            {

                string strSQL;
                string strSQL1;
                bool m_blnEnableResourceAllocation = false;
                var Flag = "";
                string intProjectID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                string intUserID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID));

                m_blnEnableResourceAllocation = Convert.ToBoolean(CommonFunctions.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " + intProjectID, true, CommonController.connectionString));



                strSQL1 = "usp_Ins_tbl_PM_AssignedResourcesForExtendBooking "
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ",'"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Hours)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.TotalWorkHrs)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Percentage)) + "";


                CommonFunctions.Data.InsertOrUpdateData(strSQL1, true, CommonController.connectionString);

                if (RequestParameters.SpecialRequest == "0")
                {
                    RequestParameters.SpecialRequest = "";
                }
                //strSQL = "usp_Whizible2_Ins_tbl_PM_ResourceRequest "
                strSQL = "usp_Ins_tbl_PM_ResourceRequest "
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ","
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Hours)) + ",'"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.SpecialRequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Priority)) + ",'"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",A,"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",null,'E',"
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.TotalWorkHrs)) + ","
                            + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Percentage));


                if (m_blnEnableResourceAllocation == true)
                {
                    strSQL += ",1";

                }
              
                string msg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
               
                return msg  + "||"  + m_blnEnableResourceAllocation.ToString();


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }


        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdatePreponeRequest([FromBody] ResourcesDetails RequestParameters)
        {
            try
            {
                string strSQL;
                string strSQL1;
                string Flag = "";

                DateTime RequestedStartDate = Convert.ToDateTime(RequestParameters.sdate); //11 April 2020 4:00:12
                DateTime EmployeeStartDate = Convert.ToDateTime(Convert.ToDateTime(RequestParameters.date)); //11 May 2020 5:20:28
                TimeSpan diff1 = EmployeeStartDate - RequestedStartDate; //DateTime - DateTime 
                TimeSpan diff2 = RequestedStartDate - DateTime.Now.Date; //DateTime - DateTime 


                //if (DateDiff("d", RequestParameters.RequestedStartDate, RequestParameters.EmployeeStartDate) == 0)
                if (Convert.ToInt32(diff1.Days) == 0)
                {
                    strSQL1 = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + Convert.ToString(RequestParameters.RequestID) + "," + Convert.ToString(RequestParameters.ProjectID) + ",";
                    strSQL1 += Convert.ToString(RequestParameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(RequestParameters.RequestedStartDate) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "'," + Convert.ToString(RequestParameters.Hours) + "," + Convert.ToString(RequestParameters.ProjectEmployeeRoleID) + ",'L' ";
                }
                //else if (DateDiff("d", RequestParameters.RequestedStartDate, DateTime.Now.Date) == 0)
                else if (Convert.ToInt32(diff2.Days) == 0)
                {
                    strSQL1 = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + Convert.ToString(RequestParameters.RequestID) + "," + Convert.ToString(RequestParameters.ProjectID) + ",";
                    strSQL1 += Convert.ToString(RequestParameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(RequestParameters.RequestedStartDate) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "'," + Convert.ToString(RequestParameters.Hours) + "," + Convert.ToString(RequestParameters.ProjectEmployeeRoleID) + ",'L' ";
                }
                else
                {
                    strSQL1 = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + Convert.ToString(RequestParameters.RequestID) + "," + Convert.ToString(RequestParameters.ProjectID) + ",";
                    strSQL1 += Convert.ToString(RequestParameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(RequestParameters.RequestedStartDate) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "'," + Convert.ToString(RequestParameters.Hours) + "," + Convert.ToString(RequestParameters.ProjectEmployeeRoleID) + ",'A' ";
                }
                CommonFunctions.Data.InsertOrUpdateData(strSQL1, true, CommonController.connectionString);


                string intProjectID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                string intUserID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID));
                if (RequestParameters.SpecialRequest == "0")
                {
                    RequestParameters.SpecialRequest = "";
                }
                //strSQL = "Exec usp_Whizible2_Ins_tbl_PM_PreponeResourceRequest "
                strSQL = "Exec usp_Ins_tbl_PM_PreponeResourceRequest "
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ","
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Hours)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.SpecialRequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',NULL,'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",A,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",1,null,'P'";

                string msg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return msg;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateChangeAllocation([FromBody] ResourcesDetails RequestParameters)
        {
            try
            {
                string strSQL = "";
                string strSQL_Assign = "";
                var Flag = "";


                DateTime RequestedStartDate = Convert.ToDateTime(RequestParameters.sdate); //11 April 2020 4:00:12
                DateTime EmployeeStartDate = Convert.ToDateTime(Convert.ToDateTime(RequestParameters.date)); //11 May 2020 5:20:28
                TimeSpan diff1 = EmployeeStartDate - RequestedStartDate; //DateTime - DateTime 
                TimeSpan diff2 = RequestedStartDate - DateTime.Now.Date; //DateTime - DateTime 

                if (Convert.ToInt32(diff1.Days) == 0)
                {
                    strSQL_Assign = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + Convert.ToString(RequestParameters.RequestID) + "," + Convert.ToString(RequestParameters.ProjectID) + ",";
                    strSQL_Assign += Convert.ToString(RequestParameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(RequestParameters.RequestedStartDate) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "'," + Convert.ToString(RequestParameters.Hours) + "," + Convert.ToString(RequestParameters.ProjectEmployeeRoleID) + ",'L' ";
                }
                else if (Convert.ToInt32(diff2.Days) == 0)
                {
                    strSQL_Assign = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + Convert.ToString(RequestParameters.RequestID) + "," + Convert.ToString(RequestParameters.ProjectID) + ",";
                    strSQL_Assign += Convert.ToString(RequestParameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(RequestParameters.RequestedStartDate) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "'," + Convert.ToString(RequestParameters.Hours) + "," + Convert.ToString(RequestParameters.ProjectEmployeeRoleID) + ",'L' ";
                }
                else
                {
                    strSQL_Assign = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + Convert.ToString(RequestParameters.RequestID) + "," + Convert.ToString(RequestParameters.ProjectID) + ",";
                    strSQL_Assign += Convert.ToString(RequestParameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(RequestParameters.RequestedStartDate) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "'," + Convert.ToString(RequestParameters.Hours) + "," + Convert.ToString(RequestParameters.ProjectEmployeeRoleID) + ",'A'";
                }
                CommonFunctions.Data.InsertOrUpdateData(strSQL_Assign, true, CommonController.connectionString);


                string intProjectID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                string intUserID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID));

                if (RequestParameters.SpecialRequest == "0") {
                    RequestParameters.SpecialRequest = "";
                }

                //strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ResourceRequest_Allocation "
                strSQL = "Exec usp_Ins_tbl_PM_ChangeAllocationResourceRequest "
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ","
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Hours)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.SpecialRequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',NUll "
                     // + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Priority)) + ",'"
                      + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",A,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",1,null,'C'";

                string msg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return msg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetAllWorkHours([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                if (RequestParameters.WorkHour == "0")
                {
                    strSQL = "Exec usp_Whizible2_sel_ProponeRelease_Workhours '"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ","
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",NULL,'"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.StrEndDate)) + "'";

                }
                else
                {

                    strSQL = "Exec usp_Whizible2_sel_ProponeRelease_Workhours '"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ","
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHour)) + "','"
                             + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.StrEndDate)) + "'";

                }

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetResourcePoolAndRoleId([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_resourcepool_tbl_pm_resourcerequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetFreeHoursForChangeAllocation([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_FreeHours_ChangeAllocation '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

         [Authorize,App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRestrictByMinHours_MinHoursForDAEntry()
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";
                ResourceCompanyInformation Information = new ResourceCompanyInformation();
                IDataReader CmpInformation;
                CmpInformation = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (CmpInformation.Read())
                {
                    Information.RestrictByMinHours = Convert.ToBoolean(CmpInformation["RestrictByMinHours"]);
                    Information.MinHoursForDAEntry = CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0").ToString();
                }
                return Information;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetEmployeeId([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_get_resource_tbl_pm_resourcerequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));

                string dt = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
         [Authorize,App_Start.ValidateHeaders]
        public object GetExtraHours([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_get_ExtrahrsRequired_Prepone '"
                     + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                     + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                     + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.PrevAllocation)) + ","
                     + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.NewAllocation)) + ",'"
                     + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',"
                     + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ","
                     + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        public class ResourceCompanyInformation
        {
            public Boolean RestrictByMinHours { get; set; }
            public string MinHoursForDAEntry { get; set; }

        }

        // Added by Dipali V on 15th May 2026 - Purpose:-Parameters for GetVendorDropdown on resource allocation page.
        public class VendorDropdownParameters
        {
            public int ProjectID { get; set; }
            public int IncludeVendorID { get; set; }
        }

        public class RequestParameters
        {
            public int RequestID { get; set; }
            public int EmployeeID { get; set; }
            public string UniqueComment { get; set; }
            public int Flag { get; set; }
            public string LoginType { get; set; }
            public int ProjectID { get; set; }
            public int UserID { get; set; }
            public int ProjectEmployeeRoleID { get; set; }
            public DataTable ProjectEmployeeRolePrepone { get; set; }
            public DataTable ResourceRequestPreponeType { get; set; }
            public DataTable GetOldAllocationDetails { get; set; }
            public DataTable GetChangeAllocationRequestList { get; set; }
            public DataTable drProjectEmployeeRole { get; set; }
            public DataTable drProjectEmployee { get; set; }
            public DataTable drPreponeRequestDetail { get; set; }
            public DataTable drExtendBookingDetail { get; set; }
            public object drProjectResourceAllocation { get; set; }
            public object SettingValue { get; set; }
            public object ProjectEndDate { get; set; }
            public int MyProperty { get; set; }
            public string UserName { get; set; }
            public string RequestedStartDate { get; set; }
            public string RequestedEndDate { get; set; }
            public string Specialrequest { get; set; }
            public int ResourcePoolID { get; set; }
            public int RoleID { get; set; }
            //public decimal WorkHour { get; set; }
            public string WorkHour { get; set; }
            public int ProjectEmployeeID { get; set; }
            public object drResourcePoolAndRoleId { get; set; }
            public int Priority { get; set; }
            public string RequestType { get; set; }
            public float PrevAllocation { get; set; }
            public float NewAllocation { get; set; }
            public float Hours { get; set; }
            public string StrEndDate { get; set; }
            public float Percentage { get; set; }
            public float TotalWorkHrs { get; set; }
            public string WorkHrs { get; set; }

            public int m_IsProjectResourceAllocation { get; set; }
            public int intRequestID { get; set; }
            public string strRequestID { get; set; }
            public string strType { get; set; }


        }
        public class ResourcesDetails
        {
            public string ProjectID { get; set; }
            public string SpecialRequest { get; set; }
            public string NatureOfRequest { get; set; }
            public string EmployeeStartDate { get; set; }
            public string ResourcePoolID { get; set; }
            public string TotalWorkHrs { get; set; }
            public string Percentage { get; set; }
            public string RoleID { get; set; }
            public string Hours { get; set; }
            public string Priority { get; set; }
            public string UserName { get; set; }
            public string RequestedStartDate { get; set; }
            public string RequestedEndDate { get; set; }
            public string RequestType { get; set; }
            public string m_strResourceAllocationLevel { get; set; }
            public string Flag { get; set; }
            public string WorkHrs { get; set; }
            public string SelectedProjectRoleID { get; set; }
            public string PStartDate { get; set; }
            public string PEndDate { get; set; }
            public string FromDate { get; set; }
            public string ToDate { get; set; }
            public string RequestID { get; set; }
            public string Fromwhereclause { get; set; }
            public string Comments { get; set; }
            public string Status { get; set; }
            public string ProjectName { get; set; }
            public string OrderBy { get; set; }
            public string WhichTab { get; set; }
            public int EmployeeID { get; set; }
            public int UserID { get; set; }
            public string sdate { get; set; }
            public string date { get; set; }
            public int ProjectEmployeeRoleID { get; set; }
        }

        public class SkillGraph
        {
            public string Description { get; set; }
            public int NoOfResources { get; set; }
        }
        public class SimilerRequestParam
        {
            public int RequestID { get; set; }
            public int UserId { get; set; }
        }

        public class ParallelResourceParam
        {
            public int RequestID { get; set; }
            public int UserId { get; set; }
            public string EmployeeName { get; set; }
            public int m_intSelectEmployeeType { get; set; }
            public int m_lngRoleId { get; set; }
            public int m_lngLocationId { get; set; }
            public string m_strFromDate { get; set; }
            public string Fromwhere { get; set; }
            public string m_strToDate { get; set; }
            public double m_dblWorkHoursForFilter { get; set; }
            public string m_strType { get; set; }
            public long m_lngDepartmentId { get; set; }
            public string strSkillIds { get; set; }
            public string strExpYrs { get; set; }
            public string strExpMonths { get; set; }
            public string strRatings { get; set; }
            public long m_lngBusinessGroupId { get; set; }
            public long m_lngResourceGroupId { get; set; }
            public bool IsPostBack { get; set; }
            public char flag { get; set; }
            public int PageNo { get; set; }
            /// <summary>Vendor filter from RM_ResourceAllocation.aspx (Search More: cboVendor_1; Probable/Exact tabs: cboVendorProbable*).</summary>
            public int VendorID { get; set; }
        }

        public class ConfigureDaysParam
        {
            public int RequestID { get; set; }
            public int ConfigureDays { get; set; }
            public string Comments { get; set; }
            public string IsEscalateToGRP { get; set; }
            public string m_strResourceAllocationLevel { get; set; }
        }
        public class RequestProperties
        {
            public int RequestID { get; set; }
            public int ProjectId { get; set; }
        }

        public class AllocationProperties
        {
            public int EmployeeId { get; set; }
            public string FromDate { get; set; }
            public string ToDate { get; set; }
            public int ProjectId { get; set; }
            public string m_strType { get; set; }
        }

        public class AllocateResource
        {
            public List<AllocateResourceParam> allocateResourceParams { get; set; }
        }

        public class AllocateResourceParam
        {
            public int RequestID { get; set; }
            public int EmployeeId { get; set; }
            public string FromDate { get; set; }
            public string ToDate { get; set; }
            public string WorkHours { get; set; }
            public string ProjectID { get; set; }
            public int ProjectRoleId { get; set; }
            public string status { get; set; }
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

    }


}