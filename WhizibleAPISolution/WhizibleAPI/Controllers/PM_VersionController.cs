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
    public class PM_VersionController : ApiController
    {
        /// <summary>
        /// Created Date    :   06th Nov 2019
        /// Purpose         :   To get the result of project version
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectVersionActions([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                if (pmcsParameters.Version == null)
                {
                    DataTable pmVersion = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_VersionActions " +
                        "@Version='" + HttpUtility.UrlDecode(pmcsParameters.Version) + "', " +
                        "@CurrentVersion=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.CurrentVersion)) + ", " +
                        "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                        "@intProjectVersionID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectVersionID)) + ", " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmVersion;
                }
                else
                {
                    DataTable pmVersion = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_VersionActions " +
                        "@Version='" + HttpUtility.UrlDecode(pmcsParameters.Version.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "', " +
                        "@CurrentVersion=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.CurrentVersion)) + ", " +
                        "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                        "@intProjectVersionID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectVersionID)) + ", " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmVersion;
                }
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            /// <summary>
            /// Created Date    :   06th Nov 2019
            /// Purpose         :   To delete the selected version details.
            /// <returns></returns> 
            [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectVersionDelete([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmVersion = CommonFunctions.Data.GetDataTable("usp_Whizible2_Del_tbl_IB_Project_Version " +
                    "@UniqueIDs ='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)), true, CommonController.connectionString);
                return pmVersion;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        public class PMConfigParameters
        {
            public int ProjectID { get; set; }
            public string UniqueIDs { get; set; }
            public int ProjectVersionID { get; set; }
            public string Version { get; set; }
            public bool CurrentVersion { get; set; }
            public string CreatedBy { get; set; }
            public string Command { get; set; }
        }
    }
}
