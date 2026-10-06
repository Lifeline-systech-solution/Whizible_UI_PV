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
    public class PM_ProjectConfigurationSettingsController : ApiController
    {
        /// <summary>
        /// Created Date    :   19th Oct 2019
        /// Purpose         :   To update the project configuration details 
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 06-09-2022        
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateProjectConfigurationData([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                PM_ConfigSettings pmConfigSettings = new PM_ConfigSettings();
                pmConfigSettings.ProjectConfigDetailsLists = new List<ProjectConfigDetailsList>();
                if (pmcsParameters.IssueAgingDurration == "")
                {
                    pmcsParameters.IssueAgingDurration = "NULL";
                }
                DataTable pmConfigSettingsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_DetailsOfProjectConfiguration '"
                                + HttpUtility.UrlDecode(pmcsParameters.IssueLayoutType) + "',"
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.LayoutID)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.IBHistoryOn)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ShareIBwithinProjectGroup)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.SendResponsiblePersonMail)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.AssignIssueToResponsiblePerson)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ResponsiblePersonForIssue)) + ",'"
                                + HttpUtility.UrlDecode(pmcsParameters.PercentCalculation) + "',"
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.TimeSheetAuthenticatorID)) + ",'"
                                + HttpUtility.UrlDecode(pmcsParameters.TimeSheetAuthenticatedBy) + "',"
                                + HttpUtility.UrlDecode(pmcsParameters.PurchaseOrderNumber) + ",'"
                                + HttpUtility.UrlDecode(pmcsParameters.PurchaseOrderDate) + "','"
                                + HttpUtility.UrlDecode(pmcsParameters.GLAccountCode) + "',"
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DefaultCrossRefNo)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.DeliverableLevelCustomer)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.IsProductDevelopementProject)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.EnforceConstraints)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.MSPFileOwner)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.BackDatingEmployeeID)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.MSPIntegrationMethod)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ResourceValidation)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ResourceLevelTaskCompletion)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.HaveSubTaskTypes)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ApplyEffortDistribution)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.EVApplicable)) + ","
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.IsIssueSLAApplicable)) + ",'"
                                + HttpUtility.UrlDecode(pmcsParameters.ModifiedBy) + "',"
                                + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ",'"
                            + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.Command)) + "','"
                            //Added By Dipali V On 5th April 2023 for issue againg issue
                            + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.IssueAgingDurration)) + "'", true, CommonController.connectionString);

                foreach (DataRow taskHistoryRow in pmConfigSettingsTable.Rows)
                {
                    ProjectConfigDetailsList prmProjectConfigDetailsList = new ProjectConfigDetailsList()
                    {
                        ack = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskHistoryRow["ack"], "0"))
                    };
                    pmConfigSettings.ProjectConfigDetailsLists.Add(prmProjectConfigDetailsList);
                }
                return pmConfigSettings;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// Created Date    :   22nd Oct 2019
        /// Purpose         :   To set the details of project configuration that is already exists
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        //[App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetProjectConfigurationData([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                PM_ConfigSettings pmConfigSettings = new PM_ConfigSettings();
                pmConfigSettings.ProjectConfigSetDetailsLists = new List<ProjectConfigSetDetailsList>();
                DataTable pmConfigSettingsTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_upd_PM_DetailsOfProjectConfiguration @intProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)) + ", @Command='" + HttpUtility.UrlDecode(pmcsParameters.Command) + "'", true, CommonController.connectionString);
                return pmConfigSettingsTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// Created Date    :   22nd Oct 2019
        /// Purpose         :   To get the details of project timersheet approver
        /// <returns></returns> 
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetProjectTimesheetApprover([FromBody] PMConfigParameters pmcsParameters)
        {
            try
            {
                DataTable getProjectTimesheetApproverTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ProjectTimesheetApprovers @ProjectID=" + HttpUtility.UrlDecode(Convert.ToString(pmcsParameters.ProjectID)), true, CommonController.connectionString);
                return getProjectTimesheetApproverTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        ////Added by Chetan M. on 02/12/2019  While doing accessible page Integration testing
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetResponsiblePersonForIssue([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'AssignTo'," + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ResponsiblePersonForIssue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ResponsiblePersonForIssue;
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
        public object GetMSPFileOwner([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                // Commented & Added By Rutuja D. 6 Jan 2020 For Change Existing Sp to Whizible2 Sp
                //strSQL = "Exec usp_Sel_tbl_PM_ProjectEmployeeRoleForMSPOwnership null," + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRoleForMSPOwnership null," + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                // Commented & Added By Rutuja D. 6 Jan 2020 For Change Existing Sp to Whizible2 Sp
                DataTable MSPFileOwner = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return MSPFileOwner;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Rutuja D 6 Jan 2020 For Binding Authentication Type Drop Down.
        [HttpPost]
        [Authorize]
        public object FillAuthenticationTypeCombo()
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_RTS_ProjectSpecificControlData  'AuthenticationType'";
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of addition By Rutuja D 6 Jan 2020 For Binding Authentication Type Drop Down.

        //Added By Chetan M on 26th Oct 2020 For get the ISProductExecutionProject is on or not
        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetISProductExecutionProject([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_ISProductExecutionProject_tbl_PRS_ProjectTypes " + ProjectID;
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Chetan M on 26th Oct 2020 For get the ISProductExecutionProject is on or not

        [HttpPost]
        //Added by imran on 06-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 06-09-2022
        public object GetResponsiblePersonForTimesheetBlocking([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Employee_Project_Resources " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ResponsiblePersonForTimesheetBlocking = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ResponsiblePersonForTimesheetBlocking;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //End of addition By Chetan M.
        }

    public class PM_ConfigSettings
    {
        public List<ProjectConfigDetailsList> ProjectConfigDetailsLists { get; set; }
        public List<ProjectConfigSetDetailsList> ProjectConfigSetDetailsLists { get; set; }

    }

    public class ProjectConfigDetailsList
    {
        public string ack { get; set; }
    }
    public class ProjectConfigSetDetailsList
    {
        public string ack { get; set; }
    }

    public class PMConfigParameters
    {
        public string IssueLayoutType { get; set; }
        public int LayoutID { get; set; }
        public bool IBHistoryOn { get; set; }
        public bool ShareIBwithinProjectGroup { get; set; }
        public bool SendResponsiblePersonMail { get; set; }
        public bool AssignIssueToResponsiblePerson { get; set; }
        public int ResponsiblePersonForIssue { get; set; }
        public string PercentCalculation { get; set; }
        public int TimeSheetAuthenticatorID { get; set; }
        public string TimeSheetAuthenticatedBy { get; set; }
        public string PurchaseOrderNumber { get; set; }
        public string PurchaseOrderDate { get; set; }//DateTime
        public string GLAccountCode { get; set; }
        public int DefaultCrossRefNo { get; set; }
        public bool DeliverableLevelCustomer { get; set; }
        public bool IsProductDevelopementProject { get; set; }
        public bool EnforceConstraints { get; set; }
        public int MSPFileOwner { get; set; }
        public int BackDatingEmployeeID { get; set; }
        public int MSPIntegrationMethod { get; set; }
        public bool ResourceValidation { get; set; }
        public bool ResourceLevelTaskCompletion { get; set; }
        public bool HaveSubTaskTypes { get; set; }
        public bool ApplyEffortDistribution { get; set; }
        public bool EVApplicable { get; set; }
        public bool IsIssueSLAApplicable { get; set; }
        public string ModifiedBy { get; set; }
        public int ProjectID { get; set; }
        public string Command { get; set; }
        //Added By Dipali V On 5th April 2023 For Issue Aging setting
        public string IssueAgingDurration { get; set; }
    }
}