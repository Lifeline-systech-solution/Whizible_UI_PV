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
    public class PM_IssueSeverityController : ApiController
    {
        /// <summary>
        /// Created Date    :   22nd Oct 2019
        /// Purpose         :   To get the result of project issue severity
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectIssueSeverityActions([FromBody]PMConfigParameters pmcsParameters)
        {
            try
            {
                if (pmcsParameters.Severity == null || pmcsParameters.CorporateSeverity == null)
                {
                    DataTable pmIssueSeverity = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_IssueSeverityActions " +
                        "@Severity='" + HttpUtility.UrlDecode(pmcsParameters.Severity) + "', " +
                        "@CorporateSeverity='" + HttpUtility.UrlDecode(pmcsParameters.CorporateSeverity) + "', " +
                        "@DefaultSeverity=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DefaultSeverity)) + ", " +
                        "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                        "@intProjectSeverityID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectSeverityID)) + ", " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmIssueSeverity;
                }
                else
                {
                    DataTable pmIssueSeverity = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_IssueSeverityActions " +
                       "@Severity='" + HttpUtility.UrlDecode(pmcsParameters.Severity.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "', " +
                       "@CorporateSeverity='" + HttpUtility.UrlDecode(pmcsParameters.CorporateSeverity.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "', " +
                       "@DefaultSeverity=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DefaultSeverity)) + ", " +
                       "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                       "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                       "@intProjectSeverityID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectSeverityID)) + ", " +
                       "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmIssueSeverity;
                }
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
        public object New_ProjectIssueSeverityActions([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                if (pmcsParameters.Severity == null || pmcsParameters.CorporateSeverity == null)
                {
                    DataTable pmIssueSeverity = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_IssueSeverityActions " +
                        "@Severity='" + HttpUtility.UrlDecode(pmcsParameters.Severity) + "', " +
                        "@CorporateSeverity='" + HttpUtility.UrlDecode(pmcsParameters.CorporateSeverity) + "', " +
                        "@DefaultSeverity=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DefaultSeverity)) + ", " +
                        "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                        "@intProjectSeverityID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectSeverityID)) + ", " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmIssueSeverity;
                }
                else
                {
                    DataTable pmIssueSeverity = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_IssueSeverityActions " +
                       "@Severity='" + HttpUtility.UrlDecode(pmcsParameters.Severity.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "', " +
                       "@CorporateSeverity='" + HttpUtility.UrlDecode(pmcsParameters.CorporateSeverity.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "', " +
                       "@DefaultSeverity=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DefaultSeverity)) + ", " +
                       "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                       "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                       "@intProjectSeverityID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectSeverityID)) + ", " +
                       "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmIssueSeverity;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End of Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting

        /// <summary>
        /// Created Date    :   22nd Oct 2019
        /// Purpose         :   To delete the selected severity details.
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectIssueSeverityDelete([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmIssueSeverity = CommonFunctions.Data.GetDataTable("usp_Whizible2_Del_tbl_IB_Project_Severity " +
                    "@UniqueIDs ='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)), true, CommonController.connectionString);
                return pmIssueSeverity;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        public class PMConfigParameters
        {
            public int ProjectSeverityID { get; set; }
            public string UniqueIDs { get; set; }
            public int ProjectID { get; set; }
            public string Severity { get; set; }
            public string CorporateSeverity { get; set; }
            public bool DefaultSeverity { get; set; }
            public string CreatedBy { get; set; }
            public string Command { get; set; }
        }
    }
}
