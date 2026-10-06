using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_RequestedResourcesController : ApiController
    {
        ////Get Project list for Accessible Project
        [HttpPost]
        [Authorize]
        public object GetProjectID([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID));


                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "";

                if (RequestParameters.ProjectID == 0)
                {
                    strSQL = strSQL + ", 0, 0, NULL,1, '" + HttpUtility.UrlDecode(RequestParameters.LoginType) + "', 1, 0, 0, 0, NULL, NULL";
                }
                else
                {
                    strSQL = strSQL + ", 0, 0, NULL, 1, '" + HttpUtility.UrlDecode(RequestParameters.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
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
        [Authorize]
        public object GetRequestedResourcesList([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object ResourceRequest_GetStatusString([FromBody] int RequestID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest_GetStatusString " + HttpUtility.UrlDecode(Convert.ToString(RequestID));

                object Status = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return Status;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetPriority([FromBody] int GroupID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_HR_Parameters " + HttpUtility.UrlDecode(Convert.ToString(GroupID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetResourcePool()
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourcePoolMaster_ForCombo ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            [HttpPost]
        [Authorize]
        public object GetResourceType()
        {
            string strSQL;
            strSQL = "Exec usp_Whizible2_Sel_RequestedType_tbl_PM_ResourceRequest ";

            DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            return dt;
        }

        [HttpPost]
        [Authorize]
        public object EditRequestResource([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                if (RequestParameters.Flag == 1)
                {
                    strSQL = "Exec usp_Whizible2_Sel_d_tbl_PM_ResourceRequest_EditRequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)); ;

                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL, " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)); ;

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
        [Authorize]
        public object GetChangeRequestList([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest_ChangeRequest " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project list for Accessible Project
        [HttpPost]
        [Authorize]
        public object SaveLinkPlotting([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest_SaveLinkDisable " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID));

                object LinkAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return LinkAccess;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get the Start Date and End Date for Particular Project
        [HttpPost]
        [Authorize]
        public object GetProjectStartDateEndDate([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_StartDate_EndDate_tbl_PM_project " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get min hours for da Entry
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
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
                    //Commented And Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                    //Information.MinHoursForDAEntry = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0")), 2).ToString());
                    Information.MinHoursForDAEntry = CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0").ToString();
                    //End Of Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                }
                return Information;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize]
        [HttpPost]

        //Commented and Added By Reshma on 10th Jan 2020 For IssueID-21364
        //public object InsertAndUpdateRequest([FromBody]object[] ObjRequestValues)
        //{


        //    string strSQL = "EXEC usp_Whizible2_Upd_tbl_PM_ResourceRequest " + Convert.ToInt32(ObjRequestValues[0].ToString()) + "," + ObjRequestValues[1].ToString() + "," + ObjRequestValues[2].ToString() + "," + ObjRequestValues[3].ToString() + ","
        //                                                      + ObjRequestValues[4].ToString() + "," + ObjRequestValues[5].ToString() + "," + ObjRequestValues[6].ToString() + "," + ObjRequestValues[7].ToString()
        //                                                      + "," + ObjRequestValues[8].ToString() + "," + ObjRequestValues[9].ToString() + "," + ObjRequestValues[10].ToString();


        //    object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

        //    string StrSql1 = "usp_Whizible2_upd_RequestWorkHrs_Details " + ObjRequestValues[10].ToString();
        //    object result1 = CommonFunctions.Data.GetDataScalar(StrSql1, true, CommonController.connectionString);

        //    return result;


        //}

        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertAndUpdateRequest([FromBody] object[] ObjRequestValues)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Upd_tbl_PM_ResourceRequest " + Convert.ToInt32(ObjRequestValues[0].ToString()) + "," + ObjRequestValues[1].ToString() + ",'" + ObjRequestValues[2].ToString() + "'," + ObjRequestValues[3].ToString() + ","
                                                                  + ObjRequestValues[4].ToString() + "," + ObjRequestValues[5].ToString() + "," + ObjRequestValues[6].ToString() + "," + ObjRequestValues[7].ToString()
                                                                  + "," + ObjRequestValues[8].ToString() + "," + ObjRequestValues[9].ToString() + "," + ObjRequestValues[10].ToString();


                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                string StrSql1 = "usp_Whizible2_upd_RequestWorkHrs_Details " + ObjRequestValues[10].ToString();
                object result1 = CommonFunctions.Data.GetDataScalar(StrSql1, true, CommonController.connectionString);

                return result;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize]
        public object GetVendorDropdown([FromBody] RequestParameters requestParameters)
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
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End  Added By Reshma on 10th Jan 2020 For IssueID-21364
        [HttpPost]
        [Authorize]
        public object GetAssignedResourcesList([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                if (RequestParameters.EmployeeID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_AssignedResources " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ",NULL";

                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_AssignedResources " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));

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
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AssignedResource([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectEmployeeRole_Assigned " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                //return dt;
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string intRequestID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID));
                //long intRequestID = long.Parse(RequestID);
                string EmployeeID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));
                string strSubject = "", strMessage = "", intUserID = "";

                bool blnSendEmail, blnShowPopup;

                //Getting Email messages
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 203", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_503(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intRequestID, EmployeeID, intUserID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
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
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CloseRequest([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_ResourceRequest_CloseRequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ",'" + HttpUtility.UrlDecode(RequestParameters.UniqueComment).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ApplyRejectResource([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_RejectResource " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ",'" + HttpUtility.UrlDecode(RequestParameters.UniqueComment).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";

                CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);



                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string intRequestID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID));
                string EmployeeID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));
                string strSubject = "", strMessage = "";

                bool blnSendEmail, blnShowPopup;

                //Getting Email messages

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 203", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_203(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, EmployeeID, intRequestID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
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
        [Authorize]
        public object SendEmail([FromBody] RequestParameters RequestParameters)
        {
            try
            {

                //return dt;
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                string intRequestID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID));

                bool blnSendEmail, blnShowPopup;

                //Getting Email messages
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 75", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_75(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intRequestID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
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
        [Authorize]
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


            RequestParameters PreponeBooking = new RequestParameters();

        [HttpPost]
        [Authorize]
        public HttpResponseMessage GetPreponeRequestList([FromBody]RequestParameters RequestParameters)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
               
                strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_ApproveorRejectRequest_tbl_PM_ResourceRequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID));
                int intRequestID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_ProjectEmployeeRole_Prepone " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                PreponeBooking.ProjectEmployeeRolePrepone = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_sem_settings_SettingValue ";
                PreponeBooking.SettingValue = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_Sel_IsProjectResourceAllocation " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString());
                PreponeBooking.drProjectResourceAllocation = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                if (intRequestID == 0)
                {
                    strSQL = "";
                    strSQL = "usp_Whizible2_Sel_tbl_PM_ResourceRequest_PreponeType NULL," + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString());
                    PreponeBooking.ResourceRequestPreponeType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    strSQL = "";
                    strSQL = "usp_Whizible2_sel_getOldAllocationDetails " + HttpUtility.UrlDecode(RequestParameters.ProjectEmployeeRoleID.ToString());
                    PreponeBooking.GetOldAllocationDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                }
                else
                {
                    strSQL = "";
                    strSQL = "usp_Whizible2_Sel_tbl_PM_ResourceRequest_PreponeType " + HttpUtility.UrlDecode(RequestParameters.ProjectEmployeeRoleID.ToString());
                    PreponeBooking.ResourceRequestPreponeType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    strSQL = "";
                    strSQL = "usp_Whizible2_sel_getOldAllocationDetails " + HttpUtility.UrlDecode(RequestParameters.ProjectEmployeeRoleID.ToString()) + "," + intRequestID;
                    PreponeBooking.GetOldAllocationDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL, " + intRequestID; ;
                    PreponeBooking.drPreponeRequestDetail = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                
                }

                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_PM_project_ChangeAllocationType_expectedenddate " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString());
                PreponeBooking.ProjectEndDate = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);



                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, PreponeBooking);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdatePreponeRequest([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                string Flag = "";
                string intProjectID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                string intUserID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID));
                if (RequestParameters.RequestID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_PreponeResourceRequest Null,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHour)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Specialrequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',NULL,'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",R,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",0,null,'P','"
                      //Added By Dipali V On 21st May 2024 For Allocation
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.NewAllocationPre)) + "'";
                    string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    string ResourceRequestID = result;

                    string strFromEmailID = "";
                    string strToEmailID = "";
                    string strCCToEmailID = "";
                    string strSubject = "";
                    var strEmailMessage = "";
                    bool blnSendEmail, blnShowPopup;

                    //Getting Email messages

                    DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 498", true, CommonController.connectionString);
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
                                Flag = "0";
                                EmailMessagesController.GetEmailMessage_498(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strEmailMessage, ResourceRequestID, intProjectID, intUserID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage);
                            }

                        }
                    }
                    return Flag + "||" + ResourceRequestID;
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_PreponeResourceRequest "
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ","
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHour)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Specialrequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',NULL,'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",R,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",0,null,'P','"
                      //Added By Dipali V On 21st May 2024 For Allocation
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.NewAllocationPre)) + "'";
                    string msg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    return msg;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



            RequestParameters ChangeAllocation = new RequestParameters();

        [HttpPost]
        [Authorize]
        public HttpResponseMessage GetChangeAllocationRequestData([FromBody]RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();
                try
                {
                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_Sel_IsProjectResourceAllocation " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                    ChangeAllocation.m_IsProjectResourceAllocation = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_sel_ApproveorRejectRequest_tbl_PM_ResourceRequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",1";
                    int intRequestID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                    strSQL = "";
                    strSQL = "usp_Whizible2_Sel_tbl_PM_project_ChangeAllocationType_expectedenddate " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString());
                    ChangeAllocation.ProjectEndDate = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_sel_tbl_sem_settings_SettingValue ";
                    ChangeAllocation.SettingValue = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                    if (RequestParameters.ProjectEmployeeRoleID != 0)
                    {
                        strSQL = "";
                        strSQL = "Exec usp_Whizible2_Sel_ProjectEmployeeRole_ChangeAllocation " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                        ChangeAllocation.drProjectEmployee = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                        strSQL = "";
                        strSQL = "Exec usp_Whizible2_sel_resourcepool_tbl_pm_resourcerequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));
                        ChangeAllocation.drResourcePoolAndRoleId = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    }


                    if (intRequestID != 0)
                    {
                        strSQL = "";
                        strSQL = "usp_Whizible2_Sel_tbl_PM_ResourceRequest_ChangeAllocationType NULL," + intRequestID;
                        ChangeAllocation.drProjectEmployeeRole = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                        strSQL = "";
                        strSQL = "usp_Whizible2_sel_getOldAllocationDetails " + HttpUtility.UrlDecode(RequestParameters.ProjectEmployeeRoleID.ToString()) + "," + intRequestID;
                        ChangeAllocation.GetOldAllocationDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    }
                    else
                    {
                        strSQL = "";
                        strSQL = "usp_Whizible2_Sel_tbl_PM_ResourceRequest_ChangeAllocationType " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID));
                        ChangeAllocation.drProjectEmployeeRole = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                        strSQL = "";
                        strSQL = "usp_Whizible2_sel_getOldAllocationDetails " + HttpUtility.UrlDecode(RequestParameters.ProjectEmployeeRoleID.ToString());
                        ChangeAllocation.GetOldAllocationDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    }
                    var configuration = new HttpConfiguration();
                    request.SetConfiguration(configuration);
                    return request.CreateResponse(HttpStatusCode.OK, ChangeAllocation);
                }
                catch (Exception e)
                {

                    return request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateChangeAllocation([FromBody]RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                var Flag = "";
                string intProjectID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                string intUserID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID));
                if (RequestParameters.RequestID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ResourceRequest_Allocation Null,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHour)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Specialrequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Priority)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                        + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",R,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",null,C";

                    string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    string ResourceRequestID = result;

                    string strFromEmailID = "";
                    string strToEmailID = "";
                    string strCCToEmailID = "";
                    string strSubject = "";
                    var strEmailMessage = "";
                    bool blnSendEmail, blnShowPopup;

                    //Getting Email messages

                    DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 543", true, CommonController.connectionString);
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
                                Flag = "0";
                                EmailMessagesController.GetEmailMessage_498(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strEmailMessage, ResourceRequestID, intProjectID, intUserID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage);
                            }

                        }
                    }
                    return Flag + "||" + ResourceRequestID;

                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ResourceRequest_Allocation "
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ","
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHour)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Specialrequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Priority)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                        + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",R,"
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                      + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",null,C";

                    string msg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    return msg;

                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize]
        public object GetresourceHrs([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_tbl_sem_settings_SettingValue ";
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetProjectBalHrs([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_PM_ProjectBalanceLCE " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",NULL,NULL";
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetLocationWorkingHours([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Location_WorkHours " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetMaxUnits([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Get_MaxUnits_For_AllocationType '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize]
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
        [Authorize]
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

        [HttpPost]
        [Authorize]
        public object GetAllWorkHours([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_ProponeRelease_Workhours '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHour)) + ",'"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.StrEndDate)) + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 18th March 2025 For Resource Change Allocation
        //Added By Dipali V On 18th March 2025,Prepone release will be allowed if max time entry is not there 
        [HttpPost]
        [Authorize]
        public object ValidateDAWithEffectiveDate([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                string Result;
                strSQL = "Exec usp_Whizible2_ValidateWithDA '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EffectiveDate)) + "','"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.NewEndDate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID)) + "";
                Result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return Result;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //End of Added By Dipali V On 18th March 2025,Prepone release will be allowed if max time entry is not there 
        //End of Added By Dipali V On 18th March 2025 For Resource Change Allocation

        RequestParameters ExtendRequest = new RequestParameters();

        [HttpPost]
        [Authorize]
        public HttpResponseMessage GetExtendRequesttData([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                HttpRequestMessage request = new HttpRequestMessage();
                try
                {
                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_Sel_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID.ToString())) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                    ExtendRequest.drProjectEmployee = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_sel_ApproveorRejectRequest_tbl_PM_ResourceRequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",1";
                    int intRequestID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_sel_resourcepool_tbl_pm_resourcerequest " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EmployeeID));
                    ExtendRequest.drResourcePoolAndRoleId = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_sel_tbl_sem_settings_SettingValue ";
                    ExtendRequest.SettingValue = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);



                    if (intRequestID != 0)
                    {
                        strSQL = "";
                        strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL, " + intRequestID;
                        ExtendRequest.drExtendBookingDetail = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                        strSQL = "";
                        strSQL = "usp_Whizible2_sel_getOldAllocationDetails " + HttpUtility.UrlDecode(RequestParameters.ProjectEmployeeRoleID.ToString()) + "," + intRequestID;
                        ExtendRequest.GetOldAllocationDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    }
                    else
                    {
                        strSQL = "";
                        strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ResourceRequest_ExtensionBooking " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID));

                        ExtendRequest.drExtendBookingDetail = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                        strSQL = "";
                        strSQL = "usp_Whizible2_sel_getOldAllocationDetails " + HttpUtility.UrlDecode(RequestParameters.ProjectEmployeeRoleID.ToString());
                        ExtendRequest.GetOldAllocationDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    }

                    strSQL = "";
                    strSQL = "usp_Whizible2_Sel_tbl_PM_project_ChangeAllocationType_expectedenddate " + HttpUtility.UrlDecode(RequestParameters.ProjectID.ToString());
                    ExtendRequest.ProjectEndDate = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                    var configuration = new HttpConfiguration();
                    request.SetConfiguration(configuration);
                    return request.CreateResponse(HttpStatusCode.OK, ExtendRequest);
                }
                catch (Exception e)
                {

                    return request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateExtendedRequest([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                var Flag = "";
                string intProjectID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                string intUserID = HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID));
                if (RequestParameters.RequestID == 0)
                {
                    strSQL = "usp_Whizible2_Ins_tbl_PM_ResourceRequest Null,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Hours)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Specialrequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Priority)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",R,"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",null,'E',"
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.TotalWorkHrs)) + ","
                           + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Percentage));

                    string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    string ResourceRequestID = result;

                    string strFromEmailID = "";
                    string strToEmailID = "";
                    string strCCToEmailID = "";
                    string strSubject = "";
                    var strEmailMessage = "";
                    bool blnSendEmail, blnShowPopup;

                    //Getting Email messages

                    DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 80", true, CommonController.connectionString);
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
                                Flag = "0";
                                EmailMessagesController.GetEmailMessage_80(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strEmailMessage, ResourceRequestID, intProjectID, intUserID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage);
                            }

                        }
                    }
                    return Flag + "||" + ResourceRequestID;
                }
                else
                {
                    strSQL = "usp_Whizible2_Ins_tbl_PM_ResourceRequest "
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestID)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedStartDate)) + "','"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestedEndDate)) + "',NULL,1,"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Hours)) + ",'"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Specialrequest)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Priority)) + ",'"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserName)) + "',"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.UserID)) + ",'"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RequestType)) + "',NULL,"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID)) + ",R,"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ResourcePoolID)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RoleID)) + ",null,'E',"
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.TotalWorkHrs)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Percentage));

                    string msg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    return msg;
                }


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetFreeHoursForExtendedBooking([FromBody] RequestParameters RequestParameters)
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
        [Authorize]
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

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //End of comment by riddhesh on 14-10-2022
        public object ConvertDecimalToHourViceVersa([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_ConvertDecimalToHourViceVersa '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHrs)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Flag));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Reshma On 16th Dec 2019
        [HttpPost]
        [Authorize]
        public object GetRequestType([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Select RequestType From tbl_PM_ResourceRequest Where ProjectEmployeeRoleID= " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectEmployeeRoleID));

                string dt = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Rutuja D for Get EmployeeID in PreponeRequest
        [HttpPost]
        [Authorize]
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


        //End Added By Rutuja D for Get EmployeeID in PreponeRequest

        //Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory Or Not
        [Authorize]
        [HttpPost]
        public object CheckResourcePoolMandatory([FromBody] int ProjectID)
        {
            try
            {
                int strmsg;
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_tbl_SEM_Settings_ResourcePoolMandatory ", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory Or Not

        //Added By Rutuja D. 16 Jan 2020 For Cancel Request
        [Authorize]
        [HttpPost]
        public object CancelRequest([FromBody] int RequestID)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Cancel_Resourcerequest " + HttpUtility.UrlDecode(Convert.ToString(RequestID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //Added By Rutuja D. 16 Jan 2020 For Cancel Request
        }
}
