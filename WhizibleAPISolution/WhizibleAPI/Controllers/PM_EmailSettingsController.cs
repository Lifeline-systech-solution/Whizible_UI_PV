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
    public class PM_EmailSettingsController : ApiController
    {
        //usp_Whizible2_upd_PM_EmailSettingsActions
        //usp_Whizible2_Sel_ProjectEmailMessages
        ////usp_Whizible2_Sel_ProjectEmployeeEmailMessages

        /// <summary>
        /// Created Date    :   08 Nov 2019
        /// Purpose         :   To get the result of Email Settings for the select result for bind, insert, update and delete
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectEmailSettingsActions([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmPriorities = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_EmailSettingsActions " +
                    "@CCToUsersList='" + HttpUtility.UrlDecode(pmcsParameters.CCToUsersList) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                    "@intMsgID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.MsgID)) + ", " +
                    "@intProjectMailID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectMailID)) + ", " +
                    "@ProjectMailIDs='" + HttpUtility.UrlDecode(pmcsParameters.ProjectMailIDs) + "', " +
                    "@Subject ='" + HttpUtility.UrlDecode(pmcsParameters.Subject) + "', " +
                    "@Body='" + HttpUtility.UrlDecode(pmcsParameters.Body) + "', " +
                    "@CreatedBy='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                    "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                return pmPriorities;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetProjectEmployees([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_ProjectEmployeeEmailMessages " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ProjectEmployees = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectEmployees;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public object GetProjectEmailMessages([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_ProjectEmailMessages " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ProjectEmailMessages = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectEmailMessages;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of addition By Chetan M.

        public class PMConfigParameters
        {
            public string CCToUsersList { get; set; }
            public int ProjectID { get; set; }
            public int MsgID { get; set; }
            public int ProjectMailID { get; set; }
            public string ProjectMailIDs { get; set; }
            public string Subject { get; set; }
            public string Body { get; set; }
            public string CreatedBy { get; set; }
            public string Command { get; set; }
        }
    }
}
