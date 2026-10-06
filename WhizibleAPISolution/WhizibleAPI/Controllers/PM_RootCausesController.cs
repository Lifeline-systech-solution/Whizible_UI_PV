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
    public class PM_RootCausesController : ApiController
    {
        /// <summary>
        /// Created Date    :   07th Nov 2019
        /// Purpose         :   To get the result of root causes using command GET and insert into the project root causes table using command POST
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectRootCausesActions([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmVersion = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_RootCausesActions " +
                    "@intRootCauseIDs='" + HttpUtility.UrlDecode(pmcsParameters.intRootCauseIDs) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                    "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                    "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                return pmVersion;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object New_ProjectRootCausesActions([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmVersion = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_RootCausesActions " +
                    "@intRootCauseIDs='" + HttpUtility.UrlDecode(pmcsParameters.intRootCauseIDs) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                    "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                    "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                return pmVersion;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting

        /// <summary>
        /// Created Date    :   07th Nov 2019
        /// Purpose         :   To delete the selected project root causes details.
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectRootCausesDelete([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmVersion = CommonFunctions.Data.GetDataTable("usp_Whizible2_Del_tbl_IB_Project_RootCause_Mapping " +
                    "@UniqueIDs ='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + "", true, CommonController.connectionString);
                return pmVersion;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        public class PMConfigParameters
        {
            public string UniqueIDs { get; set; }
            public int ProjectID { get; set; }
            public string intRootCauseIDs { get; set; }
            public string CreatedBy { get; set; }
            public string Command { get; set; }
        }

    }
}
