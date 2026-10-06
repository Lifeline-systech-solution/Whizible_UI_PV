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
    public class PM_WorkflowSettingsController : ApiController
    {
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 12-09-2022
        public object GetProjectWorkflowSettingsData([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_tbl_IM_ProjectAttributes " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ProjectWorkflowSettingsDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowSettingsDataTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveProjectWorkFlowSettings([FromBody] ProjectWorkFlowSettings ProjectWorkFlowSettingsParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Upd_tbl_IM_ProjectAttributes " + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowSettingsParameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(ProjectWorkFlowSettingsParameter.CheckedCheckboxesID) + "','" + HttpUtility.UrlDecode(ProjectWorkFlowSettingsParameter.UnCheckedCheckboxesID) + "',N'" + HttpUtility.UrlDecode(ProjectWorkFlowSettingsParameter.CreatedBy) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        public class ProjectWorkFlowSettings
        {
            public int ProjectID { get; set; }
            public string CheckedCheckboxesID { get; set; }
            public string UnCheckedCheckboxesID { get; set; }
            public string CreatedBy { get; set; }
        }

    }
}
