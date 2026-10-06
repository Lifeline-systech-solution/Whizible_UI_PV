using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_BulkExtensionApprovalController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetBulkExtensionApprovalGrid([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_BulkExtensionApproval " + parameters.ContractID + "," + parameters.ProjectID + ",'" + parameters.Status + "'," + parameters.EmployeeID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FillProjectDropdown([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_Projects_OnChangeContract " + parameters.ContractID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetStatusColors()
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_StatusDropdown";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ProjectExtensionApprovalDetails([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_ProjectExtensionApproval_Details_Edit " + parameters.ProjectApprovalID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ProjectExtensionApprovalRejectRequests([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                
                strSQL = "Exec usp_Expleo_UPD_ProjectExtensionApprovalRejectRequests '" + parameters.ProjectApprovalIDs + "','" + parameters.Remarks.Replace("'", "''") + "'," + parameters.ApprovedBy +",'" + parameters.ApprovalStatus + "'";
                //CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                //return Request.CreateResponse(HttpStatusCode.OK);
                string result=Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ResourceExtensionApprovalRejectRequests([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                String strResult = "";
                strSQL = "Exec usp_Expleo_UPD_Resource_ExtensionApprovalRejectRequests '" + parameters.ResourceApprovalIDs + "','" + parameters.Remarks.Replace("'", "''") + "'," + parameters.ApprovedBy + ",'" + parameters.ApprovalStatus + "'";
                //CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                //return Request.CreateResponse(HttpStatusCode.OK);
                //strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                //return strResult; 
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FillResourceDropdown([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_ResourceExtensionApproval_Res_Drpdwn " + parameters.ProjectID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResourceExtensionGrid([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_Resource_ExtensionApproval " + parameters.ContractID + "," + parameters.ProjectID + "," + parameters.ResourceID + ",'" + parameters.Status + "'," + parameters.EmployeeID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ResourceExtensionApprovalDetails([FromBody] PM_BulkExtensionApproval parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Expleo_Sel_ResourceExtensionApproval_Details_Edit " + parameters.ResourceApprovalID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Vishal Mane on 08/10/2025 to show contract details 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetContractData([FromBody] PM_BulkExtensionApproval PM_Bulk_Extension)
        {
            try
            {                

                string strSQL = $"usp_Expleo_Sel_tbl_Expelio_Contract_details {PM_Bulk_Extension.ContractID}";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Vishal Mane on 08/10/2025 to show contract details 


        //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        [HttpPost]
        [Authorize]
        public object GetWorkflowStatusMaster(PM_Bulk_Extension model)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExt_Approved_Stages " + model.ProjectID + "";

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
        public object GetWorkflowDetails(PM_Bulk_Extension model)
        {
            try
            {
                string strSQL = "Exec usp_Sel_Bulk_Ext_Approved_Workflows_By_ProjectID " + model.ProjectID;

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
        [Authorize]
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
                    Header = ds.Tables[1],   // workflow names + practice/BU/OU
                    SubmittedWorkflow = ds.Tables[2]
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
        public object GetRejectedWorkflowStatusMaster(PM_Bulk_Extension model)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExt_Rejected_Stages " + model.ProjectID + "";

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
        public object SilentMailWorkFowApproval(PM_Bulk_Extension model)
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
                    if (roleId == 0)
                    {
                        EmailMessagesController.GetEmailMessage_36103(
                            ref strFromEmailID,
                            ref strToEmailID,
                            ref strCCToEmailID,
                            ref strSubject,
                            ref strEmailMessage,
                            model.UserID,
                            first.ProjectID
                        );
                    }
                    else
                    {
                        EmailMessagesController.GetEmailMessage_36101(
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
                    }

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
Previous Stage: {dr["FromStage"]}
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
        public object SilentMailWorkFowRejection(PM_Bulk_Extension model)
        {
            try
            {
                string Result = "Success";

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
                    var first = projects.First();
                    EmailMessagesController.GetEmailMessage_36102(
                            ref strFromEmailID,
                            ref strToEmailID,
                            ref strCCToEmailID,
                            ref strSubject,
                            ref strEmailMessage,
                            model.UserID,
                            first.ProjectID,
                            roleId,
                            first.FromStageID,
                            first.ToStageID,
                            first.WorkflowID
                        );

                    // 🔵 Now fetch project details for each project
                    foreach (var p in projects)
                    {
                        //string strQuery = $"usp_Whizible2_Sel_BulkExt_Approval_Email_ProjectDetails {model.UserID},{p.ProjectID},{p.FromStageID},{p.ToStageID}";
                        string strQuery = $"usp_Whizible2_Sel_BulkExt_Rejection_Email_ProjectDetails {model.UserID},{p.ProjectID},{p.FromStageID},{p.ToStageID}";
                        IDataReader dr = CommonFunctions.Data.GetDataReader(strQuery, true, CommonController.connectionString);

                        if (dr.Read())
                        {
                            projectBlock.Append($@"
Project Name : {dr["ProjectName"]}
Project Code : {dr["ProjectCode"]}
From Stage   : {dr["FromStage"]}
Rejected By  : {dr["ApproverName"]}
Rejected Comment  : {dr["RejectedComment"]}
--------------------------------------------");

                            senderName = dr["UserName"].ToString();
                        }

                        CommonFunctions.Data.DisposeDataReader(ref dr);
                    }

                    // 🔵 Replace placeholders once
                    strEmailMessage = strEmailMessage.Replace("<PROJECT_LIST>", projectBlock.ToString());
                    strEmailMessage = strEmailMessage.Replace("<SENDER_NAME>", senderName);

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

                //if (model == null || model.ApproverRoles == null || model.ApproverRoles.Count == 0)
                //    return "No approver data received";
                //foreach (var item in model.ApproverRoles)
                //{
                //    string strFromEmailID = "";
                //    string strToEmailID = "";
                //    string strCCToEmailID = "";
                //    string strSubject = "";
                //    string strEmailMessage = "";
                //    // 🔵 Get mail template + users based on role/project
                //    // (modify SP if needed to accept ProjectID & RoleID)
                //    EmailMessagesController.GetEmailMessage_36102(
                //        ref strFromEmailID,
                //        ref strToEmailID,
                //        ref strCCToEmailID,
                //        ref strSubject,
                //        ref strEmailMessage,
                //        model.UserID,
                //        item.ProjectID,   
                //        item.RoleID,
                //        item.FromStageID,
                //        item.ToStageID,
                //        item.WorkflowID
                //    );
                //    // 🔵 send mail only if TO exists
                //    if (!string.IsNullOrEmpty(strToEmailID))
                //    {
                //        EmailMessagesController.SendEmailWithCC(
                //            strToEmailID,
                //            strCCToEmailID,
                //            strFromEmailID,
                //            strSubject,
                //            strEmailMessage
                //        );
                //    }
                //}

                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        //End of Added by Vishal Mane  on 09/02/2026 to open off canvas for Send For Approval Screen
    }
}
