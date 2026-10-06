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
    public class PM_ProjectWorkflowController : ApiController
    {
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 12-09-2022
        public object GetProjectWorkFlowData([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_v_tbl_IM_ProjectNatureofDemand " + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.AttributeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.IsActive));
                DataTable ProjectWorkflowDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowDataTable;
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
        public object ProjectWorkflowGetLatestVersion([FromBody] int ProjectNatureofDemandID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Get_LatestVersion_forWorkflow " + HttpUtility.UrlDecode(Convert.ToString(ProjectNatureofDemandID));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
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
        public object GetInheritableProjectWorkflows([FromBody] int ProjectID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_v_tbl_IM_NatureofDemand_Inherit " + HttpUtility.UrlDecode(Convert.ToString(ProjectID));
                DataTable ProjectWorkflowDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowDataTable;
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
        public object InheritProjectWorkflows([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_INS_tbl_IM_ProjectNatureOfDemand_InheritWorkflows " + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(ProjectWorkFlowParameter.CreatedBy) + "','" + HttpUtility.UrlDecode(ProjectWorkFlowParameter.WorkflowIds) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
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
        public object ProjectWorkflowGetLatestVersionLinkValidation([FromBody] int ProjectNatureofDemandID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_DisableLink_GetlatestVersion " + HttpUtility.UrlDecode(Convert.ToString(ProjectNatureofDemandID));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        /// <summary>
        /// Added  By Dipali V On 12th June 2020 For Check Selected WF Active or not
        /// </summary>
        /// <param name="ProjectNatureofDemandID"></param>
        /// <returns></returns>
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object CheckWFActiveorNOt([FromBody] int ProjectNatureofDemandID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_sel_tbl_IM_ProjectNatureOfDemand_IsActive " + HttpUtility.UrlDecode(Convert.ToString(ProjectNatureofDemandID));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// End of Added  By Dipali V On 12th June 2020 For Check Selected WF Active or not

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetProjectWorkflowStages([FromBody] int ProjectNatureofDemandID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_V_Tbl_IM_ProjectNatureOfDemand_Stage " + HttpUtility.UrlDecode(Convert.ToString(ProjectNatureofDemandID));
                DataTable ProjectWorkflowStagesDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowStagesDataTable;
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
        public object ProjectWorkflowGetApproverRoles([FromBody] int ProjectNatureOfDemandStageID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_IM_ProjectNatureOfDemand_Stage_stakeHolders " + HttpUtility.UrlDecode(Convert.ToString(ProjectNatureOfDemandStageID)) + ",N'-1',''";
                DataTable ProjectWorkflowApproverRolesDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowApproverRolesDataTable;
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
        public object ProjectWorkflowGetApproverRolesStage([FromBody] int RequestStageID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Get_RequestStage " + HttpUtility.UrlDecode(Convert.ToString(RequestStageID));
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
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
        public object ProjectWorkflowSaveApproverRoles([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_INS_UPD_tbl_IM_ProjectNatureOfDemand_StageDetails "
                            + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.NatureOfDemandID)) + ",'"
                            + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.RequestStageID)) + "','"
                            + HttpUtility.UrlDecode(ProjectWorkFlowParameter.strApproverID) + "',N'',N'',N'"
                            + HttpUtility.UrlDecode(ProjectWorkFlowParameter.CreatedBy) + "','"
                            + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.intUserID)) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
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
        public object ProjectWorkflowDefineRuleGetWorkflowName([FromBody] int NatureOfDemandID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Get_Workflow " + HttpUtility.UrlDecode(Convert.ToString(NatureOfDemandID)) + ",'P'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
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
        public object ProjectWorkflowGetDefineRules([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_Tbl_IM_ProjectNatureOfDemand_Stage_Rule " + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.NatureOfDemandID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.RequestStageID));
                DataTable ProjectWorkflowDefineRulesDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowDefineRulesDataTable;
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
        public object ProjectWorkflowGetAlternateApprovers([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                if (ProjectWorkFlowParameter.AlternateApproverName == "NULL")
                {
                    strSQL = "Exec usp_Sel_Tbl_IM_ProjectNatureOfDemand_StageDetails "
                        + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.ProjectID)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.NatureOfDemandID)) + ","
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.RoleID) + ","
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.BusinessGroupID) + ","
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.OrganizationUnitID) + ",N'-1',''";
                }
                else
                {
                    strSQL = "Exec usp_Sel_Tbl_IM_ProjectNatureOfDemand_StageDetails "
                        + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.ProjectID)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.NatureOfDemandID)) + ","
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.RoleID) + ","
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.BusinessGroupID) + ","
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.OrganizationUnitID) + ",N'-1','"
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.AlternateApproverName) + "'";
                }
                DataTable ProjectWorkflowDefineRulesDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowDefineRulesDataTable;
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
        public object SaveProjectWorkflowAlternateApprover([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_INS_UPD_tbl_IM_ProjectApproversNatureOfDemand_StageDetails " + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.NatureOfDemandID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.RequestStageID)) + "','" + HttpUtility.UrlDecode(ProjectWorkFlowParameter.strApproverID) + "',N'" + HttpUtility.UrlDecode(ProjectWorkFlowParameter.CreatedBy) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
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
        public object ProjectWorkflowGetOrganizationUnitDropdownData([FromBody] string BusinessGroupID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_GetOrganizationUnit " + HttpUtility.UrlDecode(BusinessGroupID);
                DataTable OrganizationUnitDropdownData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return OrganizationUnitDropdownData;
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
        public object ProjectWorkflowSelectStagesData([FromBody] int NatureOfDemandID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_IM_ProjectNatureOfDemand_Stage " + HttpUtility.UrlDecode(Convert.ToString(NatureOfDemandID));
                DataTable ProjectWorkflowSelectStagesData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectWorkflowSelectStagesData;
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
        public object SaveProjectWorkflowSelectStageData([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Ins_tbl_IM_ProjectNatureOfDemand_Stage "
                        + HttpUtility.UrlDecode(Convert.ToString(ProjectWorkFlowParameter.NatureOfDemandID)) + ",'"
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.strStageID) + "',N'"
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.strOrderNo) + "',N'"
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.strChecklist) + "',N'"
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.strCompletionDays) + "',N'"
                        + HttpUtility.UrlDecode(ProjectWorkFlowParameter.CreatedBy) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
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
        public object SaveProjectWorkflow([FromBody] ClassProjectWorkFlow ProjectWorkFlowParameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Whizible2_Upd_tbl_IM_NatureofDemand " + HttpUtility.UrlDecode(ProjectWorkFlowParameter.SQLStatement) + ",N'" + HttpUtility.UrlDecode(ProjectWorkFlowParameter.SQLXML) + "'";
                object Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        public class ClassProjectWorkFlow
        {
            public int ProjectID { get; set; }
            public string AttributeID { get; set; }
            public string IsActive { get; set; }
            public int intUserID { get; set; }
            public int NatureOfDemandID { get; set; }
            public int RequestStageID { get; set; }
            public string CreatedBy { get; set; }
            public string WorkflowIds { get; set; }
            public string strApproverID { get; set; }
            public string AlternateApproverName { get; set; }
            public string RoleID { get; set; }
            public string BusinessGroupID { get; set; }
            public string OrganizationUnitID { get; set; }
            public string strStageID { get; set; }
            public string strOrderNo { get; set; }
            public string strChecklist { get; set; }
            public string strCompletionDays { get; set; }
            public string SQLStatement { get; set; }
            public string SQLXML { get; set; }
        }
    }
}
