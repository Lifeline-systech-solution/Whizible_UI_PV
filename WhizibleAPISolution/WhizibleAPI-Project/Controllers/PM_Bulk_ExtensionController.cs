using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http.ExceptionHandling;
using System.Web.Http;
using System.Text;
using System.Net.Mail;
using CommonFunctions;
using System.IO;
using WhizibleAPI.Models.PM;
using System.Net;
using System.Net.Http;
using WhizibleAPI.Models.EmailMessages;
using Microsoft.VisualBasic;
using System.Configuration;
using Newtonsoft.Json;

namespace WhizibleAPI.Controllers
{
    public class PM_Bulk_ExtensionController : ApiController
    {

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetProjectData([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";

                string strSQL = $"usp_Whizible2_sel_tbl_pm_project_BulkExtension_Paginated {PM_Bulk_Extension.ContractID},'{PM_Bulk_Extension.UserID}','{PM_Bulk_Extension.LoginType}', 1, {PM_Bulk_Extension.LoginID},{PM_Bulk_Extension.PageNo},10";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetContractData([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";

                string strSQL = $"usp_Expleo_Sel_tbl_Expelio_Contract_details {PM_Bulk_Extension.ContractID}";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetProjectDataCount([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";

                string strSQL = $"usp_Whizible2_sel_tbl_pm_project_BulkExtensionCount {PM_Bulk_Extension.ContractID},'{PM_Bulk_Extension.UserID}','{PM_Bulk_Extension.LoginType}', 1, {PM_Bulk_Extension.LoginID}";

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                String GetProjectDataCount = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return GetProjectDataCount;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetProjectStatus()
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";
                //usp_Whizible2_sel_tbl_CNF_ProjectStatus_ddl_ProjExt
                string strSQL = $"usp_Whizible2_sel_tbl_CNF_ProjectStatus_ddl_ProjExt";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetProjectNewEffort([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";
                //usp_Whizible2_sel_tbl_CNF_ProjectStatus_ddl_ProjExt
                string strSQL = $"usp_Whizible2_sel_CalculateNewProjectHours {PM_Bulk_Extension.ProjectID},'{PM_Bulk_Extension.StartDate}','{PM_Bulk_Extension.EndDate}',{PM_Bulk_Extension.UserID},'{PM_Bulk_Extension.ExistingWorkhours}'";

                String NewEffort = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return NewEffort;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetProjectRevisionHistory([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";
                //usp_Whizible2_sel_tbl_CNF_ProjectStatus_ddl_ProjExt
                //string strSQL = $"usp_Whizible2_GetProjectRevisionHistoryDetails_ProjExt {PM_Bulk_Extension.ProjectID}";
                string strSQL = $"usp_Whizible2_GetProjectRevisionHistoryDetails {PM_Bulk_Extension.ProjectID}";

                //String RevisionData = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetResourceData([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";
                //Commented & Added by Ajit L on 29/01/2025
                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles_ResExt {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles_ResExt {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID},'{PM_Bulk_Extension.Status}'";
                //End of Commented & Added by Ajit L on 29/01/2025
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetProjectDataDDl([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";
                //usp_Whizible2_sel_tbl_CNF_ProjectStatus_ddl_ProjExt
                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                string strSQL = $"usp_Whizible2_sel_tbl_pm_project_BulkExtensionRes {PM_Bulk_Extension.ContractID},'{PM_Bulk_Extension.UserID}','{PM_Bulk_Extension.LoginType}', 1, {PM_Bulk_Extension.LoginID}";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertProjectEmployeeRole([FromBody] List<ProjectEmployeeRoleModel> approvalData)
        {
            if (approvalData == null || !approvalData.Any())
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "No data to insert.");
            }
             
            // Serialize the data to JSON
            var jsonData = JsonConvert.SerializeObject(approvalData);
            try
            {
                //Added by Ajit L on 4th July 2025 for to prevent string breakdown
                jsonData = jsonData.Replace("'", "''"); // SQL escape for single quotes
                //End of Added by Ajit L on 4th July 2025 for to prevent string breakdown
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + "";
                //string interpolatedString = $"Hello, {name}! You have {messages} new messages.";
                //usp_Whizible2_sel_tbl_CNF_ProjectStatus_ddl_ProjExt
                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                //string strSQL = $"usp_Whizible2_sel_tbl_pm_project_BulkExtensionRes {PM_Bulk_Extension.ContractID},'{PM_Bulk_Extension.UserID}','{PM_Bulk_Extension.LoginType}', 1, {PM_Bulk_Extension.LoginID}";
                string strSQL = $"EXEC usp_Whizible2_ins_tbl_Whizible2_Resource_BulkResourceExtension_Approval '{jsonData}'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //if (dt.Rows.Count > 0 && dt.Rows[0]["Result"].ToString() == "Success")
                //{
                //    return Ok(new { message = "Data inserted successfully." });
                //}
                //else
                //{
                //    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Failed to insert data.");
                //}

                if (dt.Rows.Count > 0)
                {
                    var result = dt.Rows[0]["Status"].ToString();

                    if (result == "Inserted Successfully")
                    {
                        return Ok(new { message = "Data inserted successfully." });
                    }
                    else if (result == "Already Exists")
                    {
                        return Ok(new { message = "Some records already exist." });
                    }
                    else
                    {
                        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found.");
                    }
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Failed to insert data.");
                }


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object CheckResourceReqExistence([FromBody] ProjectEmployeeRoleModel ProjectEmployeeRoleModel)
        {
            try
            {
                
                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                string strSQL = $"usp_Whizible2_Check_ResourceApproval_Exists {ProjectEmployeeRoleModel.ProjectEmployeeRoleID}";
                string ExistFlag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ExistFlag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertProjectExtensionRequest([FromBody] List<ProjectApprovalModel> projectExtensions)
        {
            if (projectExtensions == null || projectExtensions.Count == 0)
            {
                return BadRequest("No data provided.");
            }
            try
            {
                string jsonData = Newtonsoft.Json.JsonConvert.SerializeObject(projectExtensions);
                //Added by Ajit L on 4th July 2025 for to prevent string breakdown
                jsonData = jsonData.Replace("'", "''"); // SQL escape for single quotes
                //End of Added by Ajit L on 4th July 2025 for to prevent string breakdown


                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                string strSQL = $"usp_Whizible2_ins_ProjectBulkExtensionApproval '{jsonData}'";
                string ExistFlag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ExistFlag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object CheckProjectReqExistence([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {

                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                string strSQL = $"usp_CheckProjectBulkExtensionApprovalRequest {PM_Bulk_Extension.ProjectID}";
                string ExistFlag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ExistFlag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object CheckIsProjectExtensionApprover([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {

                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                string strSQL = $"usp_Whizible2_GetIsProjectExtensionApprover {PM_Bulk_Extension.RoleID},{PM_Bulk_Extension.Flag}";
                string ExistFlag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ExistFlag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetContractValue([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {

                //string strSQL = $"usp_Whizible2_sel_GetProjectEmployeeRoles {PM_Bulk_Extension.ContractID} ,{PM_Bulk_Extension.ProjectID},{PM_Bulk_Extension.RoleId},{PM_Bulk_Extension.DesignationID}";
                string strSQL = $"usp_Whizible2_GetContractValue {PM_Bulk_Extension.ContractID}";
                string ContractValue = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ContractValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 3rd March 2025 For Check Resource Allocation
        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object CheckResourceAllocations([FromBody] ProjectEmployeeRoleModel ProjectEmployeeRoleModel)
        {
            try
            {

                string strSQL = "usp_Whizible2_Validate_ResourceAllocation " + ProjectEmployeeRoleModel.ProjectEmployeeRoleID + ",'" + ProjectEmployeeRoleModel.ResourceNewEndDate + "','" + ProjectEmployeeRoleModel.ExpectedStartDate + "','" + ProjectEmployeeRoleModel.TentativeDateOfRelieving + "'";
                //string StrResourceAllocationMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V On 3rd March 2025 For Check Resource Allocation

        //Added By Riddhesh Patil On 5 March 2025 to check invoice amount validation

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetIRAmountValidation([FromBody] PM_Bulk_Extension PM_Bulk_Extension)
        {
            try
            {
                string strResult = "";
                string strSQL = "USP_Whizible2_Sel_IRAmountValidation " + PM_Bulk_Extension.ProjectID + ",'" + PM_Bulk_Extension.ProjectValue + "'";
                strResult = (string)CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return strResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Riddhesh Patil On 5 March 2025 to check invoice amount validation
        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetPrjExtensionHistory([FromBody] ProjectApprovalModel projectApprovalModel)
        {
            try
            {

                string strSQL = "usp_Expleo_Sel_tbl_Whizible2_ProjectBulkExtension_AuditTrail " + projectApprovalModel.ProjectApprovalId;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Vishal Mane on 23/06/2025 to get Project Approval History
        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetProjectApprovalHistory([FromBody] ProjectApprovalModel projectApprovalModel)
        {
            try
            {

                string strSQL = "usp_sel_BulkExtension_ApprovalStatus_History " + projectApprovalModel.ProjectApprovalId;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetResourceApprovalHistory([FromBody] ProjectEmployeeRoleModel ProjectEmployeeRoleModel)
        {
            try
            {

                string strSQL = "usp_sel_BulkExt_Res_ApprovalHistory " + ProjectEmployeeRoleModel.ProjectEmployeeRoleID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Vishal Mane on 23/06/2025 to get Project Approval History
        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetResExtensionHistory([FromBody] ProjectEmployeeRoleModel ProjectEmployeeRoleModel)
        {
            try
            {

                string strSQL = "usp_Expleo_Sel_tbl_Whizible2_Resource_BulkExtension_AuditTrail " + ProjectEmployeeRoleModel.ProjectEmployeeRoleID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
         [Authorize, App_Start.ValidateHeaders]
        public object GetResReqDetails([FromBody] ProjectEmployeeRoleModel ProjectEmployeeRoleModel)
        {
            try
            {

                string strSQL = "usp_Expleo_sel_tbl_PM_ResourceRequestDetails " + ProjectEmployeeRoleModel.ProjectID + ", " + ProjectEmployeeRoleModel.ProjectEmployeeRoleID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetWorkflowStatusMaster(PM_Bulk_Extension model)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExtension_StatusMaster_Stages " + model.WorkflowID + ", " + model.ProjectID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetWorkflowDetails(PM_Bulk_Extension model)
        {
            try
            {
                string strSQL = "Exec usp_Sel_Bulk_Ext_Workflows_By_ProjectID " + model.ProjectID;

                DataSet ds = CommonFunctions.Data.GetDataSet(
                    strSQL, "WorkFlowMaster", 0, 0, true, CommonController.connectionString
                );

                var result = new
                {
                    Workflows = ds.Tables[0],   // dropdown list
                    Header = ds.Tables[1]    // workflow names + practice/BU/OU
                };

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }


        [HttpPost]
        [Authorize]
        public object SubmitWorkflowForApproval(PM_Bulk_Extension model)
        {
            try
            {
                string jsonWorkflowAttributes = Newtonsoft.Json.JsonConvert.SerializeObject(model.WorkflowAttributes);
                string strSQL = "Exec usp_Ins_tbl_Whizible2_BulkExt_WFMaster_ApprovalStatus " + model.UserID + ",'" + model.SubmitterRemark + "','" + jsonWorkflowAttributes + "'";
                string Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRejectedWorkflowDetails(PM_Bulk_Extension model)
        {
            try
            {
                string strSQL = "Exec usp_Sel_Bulk_Ext_Rejected_Workflows_By_ProjectID " + model.ProjectID;

                DataSet ds = CommonFunctions.Data.GetDataSet(
                    strSQL, "WorkFlowMaster", 0, 0, true, CommonController.connectionString
                );

                var result = new
                {
                    Workflows = ds.Tables[0],   // dropdown list
                    Header = ds.Tables[1]    // workflow names + practice/BU/OU
                };

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CheckIsRoleActiveEmployee(PM_Bulk_Extension model)
        {
            try
            {
                string strSQL = "Exec usp_Sel_Bulk_Ext_RoleEmployees " + model.RoleID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize]
        public object SilentMailWorkFowSubmision(PM_Bulk_Extension model)
        {
            try
            {
                string Result = "Success";

                if (model == null || model.ApproverRoles == null || model.ApproverRoles.Count == 0)
                    return "No approver data received";

                var groupedRoles = model.ApproverRoles.GroupBy(x => x.RoleID).ToList();

                foreach (var roleGroup in groupedRoles)
                {
                    int roleId = roleGroup.Key;
                    var projects = roleGroup.ToList();

                    string strFromEmailID = "";
                    string strToEmailID = "";
                    string strCCToEmailID = "";
                    string strSubject = "";
                    string strEmailMessage = "";

                    StringBuilder projectBlock = new StringBuilder();
                    string senderName = "";
                    string originalSubmitter = "";

                    var first = projects.First();

                    // 🔵 Get template first (only once per role)

                    EmailMessagesController.GetEmailMessage_36100(
                        ref strFromEmailID,
                        ref strToEmailID,
                        ref strCCToEmailID,
                        ref strSubject,
                        ref strEmailMessage,
                        model.UserID,
                        first.ProjectID,
                        roleId,
                        first.FromStageID,
                        first.ToStageID
                    );


                    // 🔵 Now fetch project details for each project
                    foreach (var p in projects)
                    {
                        string strQuery = $"usp_Whizible2_Sel_BulkExt_Approval_Email_ProjectDetails {model.UserID},{p.ProjectID},{p.FromStageID},{p.ToStageID}";
                        IDataReader dr = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                        if (dr.Read())
                        {
                            projectBlock.Append($@"
Project Name : {dr["ProjectName"]}
Project Code : {dr["ProjectCode"]}
Current Stage: {dr["ToStage"]}
Submitted By : {dr["OriginalSubmitter"]}
--------------------------------------------");

                            senderName = dr["UserName"].ToString();
                            originalSubmitter = dr["OriginalSubmitter"].ToString();
                        }

                        CommonFunctions.Data.DisposeDataReader(ref dr);
                    }

                    // 🔵 Replace placeholders once
                    strEmailMessage = strEmailMessage.Replace("<PROJECT_LIST>", projectBlock.ToString());
                    strEmailMessage = strEmailMessage.Replace("<SENDER_NAME>", senderName);
                    strEmailMessage = strEmailMessage.Replace("<ORIGINAL_SUBMITTER>", originalSubmitter);

                    // 🔵 Send only once per role
                    if (!string.IsNullOrEmpty(strToEmailID))
                    {
                        EmailMessagesController.SendEmailWithCC(
                            strToEmailID,
                            strCCToEmailID,
                            strFromEmailID,
                            strSubject,
                            strEmailMessage
                        );
                    }
                }
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }


        //End of Added by Vishal Mane on 09/02/2026  to open off canvas for Send For Approval Screen

    }
}
