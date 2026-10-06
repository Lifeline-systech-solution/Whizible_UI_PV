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
    public class PM_TaskTypeController : ApiController
    {

        /// <summary>
        /// Created Date    :   11 Nov 2019
        /// Purpose         :   To get the result of task and subtask type details
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Commented by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectTaskTypeActions([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmTT = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_TaskSubTaskTypeActions " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                    "@intTaskTypeID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intTaskTypeID)) + ", " +
                    "@intSubTaskTypeID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intSubTaskTypeID)) + ", " +
                    "@ProjectSubTaskTypeIDs = '" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectSubTaskTypeIDs)) + "', " +
                    "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                return pmTT;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// Created Date    :   11 Nov 2019
        /// Purpose         :   To delete the task type details
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectDeleteTaskType([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmDelTT = CommonFunctions.Data.GetDataTable("usp_Whizible2_Del_tbl_PM_ProjectTaskTypes " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                    "@UniqueIDs = '" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.UniqueIDs)) + "'", true, CommonController.connectionString);
                return pmDelTT;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetTaskTypeData([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_TaskTypes_PopulateCombo " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable TaskTypeDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return TaskTypeDataTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectName([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_pm_Project_GetProjectName " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable TaskTypeDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return TaskTypeDataTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //[HttpPost]
        //[Authorize]
        //public object GetProjectName([FromBody]int ProjectId)
        //{
        //    string strSQL ="";
        //        strSQL = "usp_Whizible2_Sel_tbl_pm_Project_GetProjectName " + HttpUtility.UrlDecode(Convert.ToString(ProjectId));
        //        object ProjectName = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
        //}

        public class PMConfigParameters
        {
            public int ProjectID { get; set; }
            public int intTaskTypeID { get; set; }
            public int intSubTaskTypeID { get; set; }
            public string UniqueIDs { get; set; }
            public string ProjectSubTaskTypeIDs { get; set; }
            public string Command { get; set; }
        }
    }
}
