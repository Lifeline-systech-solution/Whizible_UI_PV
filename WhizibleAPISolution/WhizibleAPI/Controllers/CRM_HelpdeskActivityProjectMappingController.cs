using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    public class CRM_HelpdeskActivityProjectMappingController : ApiController
    {

        [HttpPost]
        [Authorize]
        public object GetHelpdeskResourcesList([FromBody] RequestParameters RequestParameters)
        {
            try
            {

                string strSQL = "";

                strSQL = "usp_Whizible2_Sel_Resources_HelpdeskActivity_ProjectMapping " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intUserID)) + ",'',NUll,Null,Null";

                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetHelpdeskProject([FromBody] RequestParameters RequestParameters)
        {
            try
            {

                string strSQL = "";
                int ProjectID;
                strSQL = "usp_Whizible2_Sel_HelpDesk_Project " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intEmployeeID));


                ProjectID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return ProjectID;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetHelpdeskProjectList([FromBody] RequestParameters RequestParameters)
        {
            try
            {

                string strSQL = "";

                strSQL = "usp_Whizible2_Sel_ProjectForHelpDeskProject " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intEmployeeID)) + ",'E'";

                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveHelpdeskProjectActivitymapping([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL = "EXEC Usp_Whizible2_Ins_tbl_CRM_Employee_ProjectMapping '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.strEmpolyeeIDs)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.strProjectIDs)) + "'";
                int result;
                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetHelpdeskProjectHistory([FromBody] RequestParameters RequestParameters)
        {
            try
            {

                string strSQL = "";

                strSQL = "usp_Whizible2_Sel_tbl_CRM_Employee_ProjectMapping_History " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intEmployeeID));

                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        public class RequestParameters
        {
            public int intUserID { get; set; }
            public string strEmployeeName { get; set; }
            public int BGID { get; set; }
            public int OUID { get; set; }
            public int intRoleID { get; set; }
            public int intEmployeeID { get; set; }
            public string strEmpolyeeIDs { get; set; }
            public string strProjectIDs { get; set; }
        }

      
    }
}
