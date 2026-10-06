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
    public class PM_DeliverableSettingsController : ApiController
    {
        //
        /// <summary>
        /// Created Date    :   14th Nov 2019
        /// Purpose         :   To get the result of Deliverable Settings Actions 
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
       public object ProjectDeliverableSettingsActions([FromBody]PMConfigParameters pmcsParameters)
        {
            try
            {
                ////Commented And Added By Usha Pandit On 12.06.2020 For escaping quotes in string 
                //DataTable pmdsl = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_DeliverableSettingsActions " +
                //    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " +
                //    "@UniqueIDs='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                //    "@intUniqueID =" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intUniqueID)) + ", " +
                //    "@intScheduleTypeID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleTypeID)) + ", " +
                //    "@intScheduleID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleID)) + ", " +
                //    "@intSerialNo=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intSerialNo)) + ", " +
                //    "@IssueType='" + HttpUtility.UrlDecode(pmcsParameters.IssueType) + "', " +
                //    "@intTemplateID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intTemplateID)) + ", " +
                //    "@CreatedBy='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                //    "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                //return pmdsl;
                if (pmcsParameters.IssueType == null)
                {
                    DataTable pmdsl = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_DeliverableSettingsActions " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " +
                        "@UniqueIDs='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                        "@intUniqueID =" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intUniqueID)) + ", " +
                        "@intScheduleTypeID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleTypeID)) + ", " +
                        "@intScheduleID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleID)) + ", " +
                        "@intSerialNo=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intSerialNo)) + ", " +
                        "@IssueType='" + HttpUtility.UrlDecode(pmcsParameters.IssueType) + "', " +
                        "@intTemplateID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intTemplateID)) + ", " +
                        "@CreatedBy='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmdsl;
                }
                else
                {
                    DataTable pmdsl = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_DeliverableSettingsActions " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " +
                        "@UniqueIDs='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                        "@intUniqueID =" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intUniqueID)) + ", " +
                        "@intScheduleTypeID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleTypeID)) + ", " +
                        "@intScheduleID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleID)) + ", " +
                        "@intSerialNo=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intSerialNo)) + ", " +
                         "@IssueType='" + HttpUtility.UrlDecode(pmcsParameters.IssueType).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " +
                        "@intTemplateID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intTemplateID)) + ", " +
                        "@CreatedBy='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmdsl;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            //End Of Added By Usha Pandit On 12.06.2020 For escaping quotes in string

        }


        //Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object New_ProjectDeliverableSettingsActions([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                if (pmcsParameters.IssueType == null)
                {
                    DataTable pmdsl = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_DeliverableSettingsActions " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " +
                        "@UniqueIDs='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                        "@intUniqueID =" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intUniqueID)) + ", " +
                        "@intScheduleTypeID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleTypeID)) + ", " +
                        "@intScheduleID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleID)) + ", " +
                        "@intSerialNo=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intSerialNo)) + ", " +
                        "@IssueType='" + HttpUtility.UrlDecode(pmcsParameters.IssueType) + "', " +
                        "@intTemplateID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intTemplateID)) + ", " +
                        "@CreatedBy='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmdsl;
                }
                else
                {
                    DataTable pmdsl = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_DeliverableSettingsActions " +
                        "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " +
                        "@UniqueIDs='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "', " +
                        "@intUniqueID =" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intUniqueID)) + ", " +
                        "@intScheduleTypeID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleTypeID)) + ", " +
                        "@intScheduleID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleID)) + ", " +
                        "@intSerialNo=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intSerialNo)) + ", " +
                         "@IssueType='" + HttpUtility.UrlDecode(pmcsParameters.IssueType).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " +
                        "@intTemplateID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intTemplateID)) + ", " +
                        "@CreatedBy='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "', " +
                        "@Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                    return pmdsl;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            //End Of Added By Usha Pandit On 12.06.2020 For escaping quotes in string

        }
        //End of Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting


        /// <summary>
        /// Created Date    :   15Nov Nov 2019
        /// Purpose         :   To delete the selected DeliverableSettings.
        /// <returns></returns>         
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectDeliverableSettingsDelete([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable pmVersion = CommonFunctions.Data.GetDataTable("usp_Whizible2_Del_tbl_PM_ProjectSchedules " +
                    "@UniqueIDs ='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "'", true, CommonController.connectionString);
                return pmVersion;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        /// Created Date    :   15th Nov 2019
        /// Purpose         :   To refresh the selected DeliverableSettings resource access.
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectDeliverableSettingsResourceAccess([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                object pmRefresh = CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DeliverableType_RoleMapping_Refresh " +
                    "@intScheduleTypeID =" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleTypeID)) + ", " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " +
                    "@strUserName='" + HttpUtility.UrlDecode(pmcsParameters.CreatedBy) + "'", true, CommonController.connectionString);
                return pmRefresh;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        /// Created Date    :   15th Nov 2019
        /// Purpose         :   To save the selected DeliverableSettings resource access.
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectDeliverableSettingsResourceSave([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                object pmSave = CommonFunctions.Data.GetDataScalar("usp_Whizible2_Del_tbl_PM_DeliverableType_RoleMapping " +
                    "@intScheduleTypeID =" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intScheduleTypeID)) + ", " +
                    "@intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " +
                    "@strUniqueIDList='" + HttpUtility.UrlDecode(pmcsParameters.UniqueIDs) + "'", true, CommonController.connectionString);
                return pmSave;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetProjectDeliverableType([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_CompanySchedule " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ProjectDeliverableType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectDeliverableType;
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
        public object GetProjectIssueTypes([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Type_ForDeliverableSettings " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ProjectIssueTypes = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectIssueTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Commented And Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id
        //[HttpPost]
        //[Authorize]
        //public DataTable GetExecutionTemplateData([FromBody]int ProjectID)
        //{
        //    string strSQL = "";
        //    strSQL = "Exec usp_Whizible2_Sel_tbl_PRS_PhaseTask_Template_List " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
        //    DataTable ExecutionTemplateData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
        //    return ExecutionTemplateData;
        //}  

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetExecutionTemplateData([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PRS_PhaseTask_Template_List " + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.intUniqueID));
                DataTable ExecutionTemplateData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ExecutionTemplateData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 12.06.2020 For passing current Deliverable Type Id
        //End of addition By Chetan M.


        public class PMConfigParameters
        {
            public int intProjectID { get; set; }
            public string UniqueIDs { get; set; }
            public int intUniqueID { get; set; }
            public int intScheduleTypeID { get; set; }
            public int intScheduleID { get; set; }
            public int intSerialNo { get; set; }
            public string IssueType { get; set; }
            public int intTemplateID { get; set; }
            public string CreatedBy { get; set; }
            public string Command { get; set; }
            public string strUserName { get; set; }


        }
    }
}
