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
    public class PM_PrioritiesController : ApiController
    {
        /// <summary>
        /// Created Date    :   22nd Oct 2019
        /// Purpose         :   To get the result of project priorities
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectPrioritiesActions([FromBody]PMConfigParameters pmcsParameters)
        {
            try
            {
                if (pmcsParameters.Priority == null)
                {
                    DataTable pmPriorities = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_PrioritiesActions " +
                    "@Priority='" + HttpUtility.UrlDecode(pmcsParameters.Priority) + "', " +
                    "@CorporatePriority='" + HttpUtility.UrlDecode(pmcsParameters.CorporatePriority) + "', " +
                    "@DefaultPriority=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DefaultPriority)) + ", " +
                    // Commented & Added By Rutuja D. on 24 March 2020 For pass FixInDays as String issueid=23015
                    //"@FixInDays=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.FixInDays)) + ", " +
                    "@FixInDays='" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.FixInDays)) + "', " +
                    //End Commented & Added By Rutuja D. on 24 March 2020 For pass FixInDays as String issueid=23015
                    "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                    "@intProjectPriorityID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectPriorityID)) + ", " +
                    "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmPriorities;
                }
                else
                {
                    DataTable pmPriorities = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_PrioritiesActions " +
                    "@Priority='" + HttpUtility.UrlDecode(pmcsParameters.Priority.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "', " +
                    //Commented And Added By Usha Pandit On 11.06.2020 For escaping quotes in string
                    //"@CorporatePriority='" + HttpUtility.UrlDecode(pmcsParameters.CorporatePriority) + "', " +
                    "@CorporatePriority='" + HttpUtility.UrlDecode(pmcsParameters.CorporatePriority).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " +
                    //End Of Added By Usha Pandit On 11.06.2020 For escaping quotes in string
                    "@DefaultPriority=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DefaultPriority)) + ", " +
                    // Commented & Added By Rutuja D. on 24 March 2020 For pass FixInDays as String issueid=23015
                    //"@FixInDays=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.FixInDays)) + ", " +
                    "@FixInDays='" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.FixInDays)) + "', " +
                    //End Commented & Added By Rutuja D. on 24 March 2020 For pass FixInDays as String issueid=23015
                    "@CreatedBy ='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", " +
                    "@intProjectPriorityID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectPriorityID)) + ", " +
                    "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmPriorities;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// Created Date    :   05 Nov 2019
        /// Purpose         :   To delete the selected priorities details.
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectPrioritiesDelete([FromBody]PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmPriorities = CommonFunctions.Data.GetDataTable("usp_Whizible2_Del_tbl_IB_Project_Priority " +
                    "@UniqueIDs ='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)), true, CommonController.connectionString);
                return pmPriorities;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
       
        //Added By Rutuja D 6 Jan 2020 For Binding Corporate Priority Drop Down.
        [HttpPost]
        [Authorize]
        public object FillCorporatePriorityCombo()
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Priorities";
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of addition By Rutuja D 6 Jan 2020 For Binding Authentication Type Drop Down.

        public class PMConfigParameters
        {
            public int ProjectID { get; set; }
            public string UniqueIDs { get; set; }
            public int ProjectPriorityID { get; set; }
            public string Priority { get; set; }
            public string CorporatePriority { get; set; }
            public bool DefaultPriority { get; set; }
            //Commented & Added By Rutuja D. on 24 March 2020 For pass FixInDays as String issueid=23015
            //public int FixInDays { get; set; }
            public string FixInDays { get; set; }
            //End Commented & Added By Rutuja D. on 24 March 2020 For pass FixInDays as String issueid=23015
            public string CreatedBy { get; set; }
            public string Command { get; set; }
        }
    }
}
