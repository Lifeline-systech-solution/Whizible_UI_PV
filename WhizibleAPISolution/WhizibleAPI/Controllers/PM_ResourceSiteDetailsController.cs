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
    public class PM_ResourceSiteDetailsController : ApiController
    {

        //Get Project list for Accessible Project
        ////Get Project list for Accessible Project
        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetProjectID([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.UserID));


                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "";

                if (ResourceSiteDetailParameter.ProjectID == 0)
                {
                    strSQL = strSQL + ", 0, 0, NULL,1, '" + HttpUtility.UrlDecode(ResourceSiteDetailParameter.LoginType) + "', 1, 0, 0, 0, NULL, NULL";
                }
                else
                {
                    strSQL = strSQL + ", 0, 0, NULL,1, '" + HttpUtility.UrlDecode(ResourceSiteDetailParameter.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID));
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
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object FillSiteCombo([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {

                string strSQL;

                strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeBillingInfo_Site " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID));


                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetResourceSiteList([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                //Comment And Added By Riddhesh Patil on 21st March 2023
                //if (ResourceSiteDetailParameter.SiteName != "null")
                if (ResourceSiteDetailParameter.SiteName != "")   //End of Comment And Added By Riddhesh Patil on 21st March 2023
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeBillingInfo " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.SiteName)) + "'";
                }
                else if (ResourceSiteDetailParameter.EmployeeID != 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeBillingInfo " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID));

                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeBillingInfo " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID));

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
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetEmployeeBillingRateHistory([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                if (ResourceSiteDetailParameter.EmployeeBillingInfoID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_d_tbl_PM_EmployeeBillingInfo " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID));

                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_d_tbl_PM_EmployeeBillingInfo " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeBillingInfoID));

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
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetEmployeeSiteHistory([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                if (ResourceSiteDetailParameter.EmployeeSiteID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeSiteDetails " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID));

                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeSiteDetails " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeSiteID));

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
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetEmpSite([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectSite " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetEmpRole([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_Role " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateEmpSiteHistory([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeSiteDetails " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.RoleID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.StartDate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeSiteID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


            //[Authorize]
            //[HttpPost]
            //public List<ResourceSiteDetail> GetUnsuccessFullTransfer([FromBody]ResourceSiteDetail ResourceSiteDetailParameter)

            //{

            //    List<ResourceSiteDetail> ListUnsuccessFullTransfer = new List<ResourceSiteDetail>();


            //    string strSQL = "Exec usp_Whizible2_sel_Employees_For_UnsuccessFullTransfer "
            //        + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ",'"
            //        + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID)) + "','"
            //        + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.StartDate))+"'";

            //    IDataReader sdr;
            //    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

            //    while (sdr.Read())
            //    {
            //        ResourceSiteDetail UnsuccessFullTransfer = new ResourceSiteDetail()
            //        {
            //            ReasonID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ReasonID"].ToString(), "0")),
            //            EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EmployeeName"], "")),
            //            EmpReason = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["EmpReason"], "")),


            //        };
            //        ListUnsuccessFullTransfer.Add(UnsuccessFullTransfer);

            //    }
            //    return ListUnsuccessFullTransfer;
            //}
            ResourceSiteDetail ResourceSiteDetail = new ResourceSiteDetail();

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public HttpResponseMessage GetUnsuccessFullTransfer([FromBody]ResourceSiteDetail ResourceSiteDetailParameter)
        {
            string strSQL;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_Employees_For_UnsuccessFullTransfer "
                         + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ",'"
                         + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.strEmployeeID)) + "','"
                         + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.StartDate)) + "'";

                ResourceSiteDetail.UnsuccessFullTransfer = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "Exec usp_whizible2_checkForUnsusseccfulTransfer "
                        + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ",'"
                        + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.strEmployeeID)) + "','"
                        + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.StartDate)) + "'";

                ResourceSiteDetail.checkForUnsusseccfulTransfer = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, ResourceSiteDetail);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetProRole([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_EmployeeBillingInfo_EmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeBillingInfoID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateBillingRateHistory([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                //strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeBillingInfo "
                //       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ",'"
                //       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.NormalRate)) + "','"
                //       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ExtraRate)) + "','"
                //       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.HolidayRate)) + "','"
                //       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.strEmployeeBillingInfoID)) + "'";

                strSQL = "usp_Whizible2_Upd_tbl_PM_EmployeeBillingInfo "
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ","
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID)) + ","
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeBillingInfoID)) + ","
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeSiteID)) + ","
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.RoleID)) + ",'"
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.StartDate)) + "',"
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.NormalRate)) + ","
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ExtraRate)) + ","
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.HolidayRate)) + ",0,"
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.UserID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ResourceSiteTransfer([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_ProjectSiteResources "
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ","
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.intTransferSiteID)) + ",'"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.strEmployeeID)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.RoleID)) + ",'"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.StartDate)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.BillingPercentage));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteEmployeeBillingRateHistory([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeBillingInfo '"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.strEmployeeBillingInfoID)) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteEmployeeSiteHistory([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeSiteDetails '"
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.strEmployeeSiteID)) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object CheckDuplicateBillingInfo([FromBody] ResourceSiteDetail ResourceSiteDetailParameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_CheckDuplicateRecordInBillingInfo "
                       + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.ProjectID)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeSiteID)) + ","
                         + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.EmployeeID)) + ","
                          + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.RoleID)) + ",'"
                           + HttpUtility.UrlDecode(Convert.ToString(ResourceSiteDetailParameter.StartDate)) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object ProjectIsOver([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_Project_IsOver "
                       + HttpUtility.UrlDecode(Convert.ToString(ProjectID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 05-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 05-09-2022
        public object GetProjectEndDate([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_ProjectStartAndEndDate "
                       + HttpUtility.UrlDecode(Convert.ToString(ProjectID)) + ",'EndDate'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }
}
