using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CommonFunctions;
////using PbNIT;

namespace WhizibleAPI.Controllers
{
    public class ApprovalController : ApiController
    {
        [HttpPost, Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public string EntityApproval([FromBody]EntityApprovalParameters eaP)
        {
            string strPrimaryKey = "";
            int intEntityID = eaP.intEntityID;
            int MasterTagID = eaP.MasterTagID;
            string Status = eaP.Status;
            int ProjectID = eaP.ProjectID;
            string Remarks = eaP.Remarks;
            string UserName = eaP.UserName;
            int RoleID = eaP.RoleID;
            int UserID = eaP.UserID;
            string LoginType = eaP.LoginType;
            int rowCount = eaP.rowCount;
            string WorkflowID = eaP.WorkflowID;

            WorkFlowGeneral.DefinitionDetails.Definition objWorkFlowDefinition;
            CommonFunctions.Application.ConnectionString = CommonFunctions.General.BuildConnectionString(ConfigurationManager.AppSettings["ConnectionString"]);
            try
            {
                WebPages.Template.IGlobal m_objGlobalObject = new WebPages.Template.WhizGlobal(UserName, MasterTagID, RoleID, UserID, LoginType);
                if (ProjectID != null)
                {
                    int IsComplete;
                    string NewstrSql;
                    System.Text.StringBuilder sbScript_Deliverable = new System.Text.StringBuilder();
                    if (ProjectID == null)
                        ProjectID = 0;

                    string strWorkflowoption = "";
                    if (Status != null)
                    {
                        if (Status == "A")
                            strWorkflowoption = "SYS_APPROVE";
                        else if (Status == "R")
                            strWorkflowoption = "SYS_REJECT";
                        else if (Status == "S")
                            strWorkflowoption = "SYS_SUBMIT";
                    }
                    string strPrimaryKeyvalue;
                    if (strWorkflowoption.ToUpper().ToString() == "SYS_APPROVE")
                    {
                        NewstrSql = "usp_Get_Deliverable_Stage_Details " + intEntityID.ToString();
                        IsComplete = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(NewstrSql, true));
                        // If IsComplete.ToString <> "2" Then
                        if (IsComplete.ToString() == "1")
                        {
                            sbScript_Deliverable.Append("<Script language=javascript>");
                            sbScript_Deliverable.Append("alert('Some tasks from this stage are incomplete.Please complete the task!');");
                            sbScript_Deliverable.Append("</Script>");
                            return (sbScript_Deliverable.ToString());
                        }
                    }

                    strPrimaryKeyvalue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_ins_UPD_tbl_IM_WorkflowInstance " + intEntityID.ToString() + "," + MasterTagID.ToString() + "," + ProjectID + "," + WorkflowID + ",'" + UserName + "'", true)), ""));
                    // CommonFunction.WhizibleWorkflow.UpdateWhizibleWorkflowData(m_objGlobalObject, intEntityID, strWorkflowoption, MasterTagID.ToString)
                    // Public Shared Sub UpdateWhizibleWorkflowData(ByVal m_GlobalObject As WebPages.Template.IGlobal, ByVal PrimaryKeyValue As String, ByVal strAction As String, ByVal strTagID As String, Optional ByVal strWorkflowOption As String = "", Optional ByVal FromWhere As String = "", Optional ByVal ActionComments As String = "", Optional ByVal FromMobileApprovals As Boolean = False)
                    // =============================================
                    // Procedure Name		: UpdateWhizibleWorkflowData
                    // Description           : perform approve reject submit actions
                    // Purpose               : 
                    // Parameters Passed     : 
                    // Parameters Affected   :
                    // Assumptions           :
                    // Dependencies          :
                    // Author                : PurvaJ
                    // Created               : April 30 2008
                    // Revisions             :
                    // ==============================================
                    string m_strToEmailID = "";
                    string m_strCCEmailID = "";
                    string m_strSubject = "";
                    string m_strMessage = "";
                    string m_strFromEmailID = "";
                    string FromWhere = "";
                    string strTagID = MasterTagID.ToString();
                    string strAction = strWorkflowoption;
                    string strActionID = "";
                    string strInstanceID = "";
                   
                    string m_strStageConditionError = "";
                    string strRequestStageID = "";
                    string strProjectNODID = "";
                    IDataReader dr;
                    string strComments = "";
                    DataSet objDS;
                    System.Text.StringBuilder sb_UWW = new System.Text.StringBuilder();
                    int iMsgID = 0;
                    string ActionComments = "";
                    bool FromMobileApprovals = false;
                    // 'Added by PrashantSJ on 14th Apr 2009 : WhizibleSEM 8.0
                    if (ActionComments != "")
                        //added & Commented by dipali V on 7th Nov 2019 For Quote Issue
                       // strComments = ActionComments
                        strComments = ActionComments.Replace("'","''");
                    //End of added & Commented by dipali V on 7th Nov 2019 For Quote Issue
                    else
                       // strComments = CommonFunctions.General.CheckIsNothing(Remarks, "").ToString();
                        strComments = Remarks.Replace("'", "''");
                    // strComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments_hidden"), "").ToString
                    // 'End of addition and comment by PrashantSJ on 14th Apr 2009

                    dr = CommonFunctions.Data.GetDataReader("usp_get_WorkflowDetails " + intEntityID.ToString() + "," + strTagID + ",'" + strAction + "'", true);
                    if (dr.Read())
                    {
                        strPrimaryKey = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr["PrimaryKey"], ""), "").ToString();
                        strActionID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr["ActionID"], ""), "").ToString();
                        strInstanceID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr["InstanceID"], ""), "").ToString();
                        strRequestStageID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr["RequestStageID"], ""), "").ToString();
                        strProjectNODID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr["ProjectNatureOfDemandID"], ""), "").ToString();
                    }

                    CommonFunctions.Data.DisposeDataReader(ref dr);

                    objWorkFlowDefinition = new WorkFlowGeneral.DefinitionDetails.Definition();
                    objWorkFlowDefinition.Initialize();

                    objWorkFlowDefinition.m_strConnString = CommonFunctions.General.BuildConnectionString(ConfigurationManager.AppSettings["ConnectionString"]);

                    objWorkFlowDefinition.FillWorkFlowDefinition(m_objGlobalObject, strPrimaryKey);

                    m_objGlobalObject.TagID = 3929;

                    if (intEntityID.ToString() != "")
                    {
                        if (strAction != "")
                        {
                            /// <Summary>
                            ///                         '''Author   :   PrashantSJ
                            ///                         '''Date     :   10 May 2008
                            ///                         '''Date     :   To return the Action Type MsgID w.r.t TagID
                            ///                         '''</Summary>
                            sb_UWW.Append("usp_Sel_IM_EmailMessages NULL ");
                            sb_UWW.Append("," + strTagID);

                            objDS = CommonFunctions.Data.GetDataSet(sb_UWW.ToString(), "ActionMessage", 0/* Conversion error: Set to default value for this argument */, 0/* Conversion error: Set to default value for this argument */, System.Convert.ToBoolean(true));
                            foreach (DataRow objdataRow in objDS.Tables[0].Select("ActionType='" + strAction + "'"))
                                iMsgID = System.Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(objdataRow["MsgID"], "0"));

                            sb_UWW.Remove(0, sb_UWW.Length);

                            /// End of addition by PrashantSJ on 10 May 2008

                            if (strAction == "SYS_SUBMIT")
                            {
                                //strPrimaryKeyvalue = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_ins_UPD_tbl_IM_WorkflowInstance " + intEntityID.ToString() + "," + MasterTagID + "," + ProjectID + "," + WorkflowID + ",'" + UserName + "'",true), "").ToString();
                                m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobalObject, strPrimaryKey, "SUBMIT", strActionID, "");
                                if (objWorkFlowDefinition.m_strInstanceID != "")
                                    CommonFunction.UpdateEvent(CommonFunctions.General.CheckIsNothing(objWorkFlowDefinition.m_strInstanceID, "").ToUpper(), strComments);
                            }

                            else if (strAction == "SYS_APPROVE")
                            {
                                 m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobalObject, strPrimaryKey, "APPROVE", strActionID, strInstanceID);
                                if (strInstanceID != "")
                                {
                                    CommonFunction.UpdateEvent(CommonFunctions.General.CheckIsNothing(strInstanceID, "").ToUpper(), strComments);
                                }

                            }
                            else if (strAction == "SYS_REJECT")
                            {
                                m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobalObject, strPrimaryKey, "REJECT", strActionID, strInstanceID);
                                // If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
                                if (strInstanceID != "")
                                    CommonFunction.UpdateEvent(CommonFunctions.General.CheckIsNothing(strInstanceID, "").ToUpper(), strComments);
                            }

                            if (m_strStageConditionError == "" || m_strStageConditionError == null)
                            {
                                if (strTagID == Convert.ToString(32))
                                    UpdateProjectRevisionDetails(intEntityID.ToString(), strAction, strTagID, strRequestStageID, strProjectNODID, strWorkflowoption, strComments,UserName);
                                else
                                    UpdateOtherEntityRevisions(intEntityID.ToString(), strAction, strTagID, strRequestStageID, strProjectNODID, strWorkflowoption,UserName,ProjectID.ToString());

                                // Chaned by DarshanK on 4-Aug-2008
                                // If FromWhere = "" Then
                                // 'End of Change by DarshanK on 4-Aug-2008
                                // CommonFunction.WhizibleWorkflow.SendWorkflowEmails(iMsgID, strPrimaryKey, strComments, FromMobileApprovals)
                                // 'If strPrimaryKey = PrimaryKeyValue Then

                                // 'Added By Amol Changle On: 24 Apr 2009
                                // 'Purpose: Not to refresh parent page when method is called from WhizibleMobile application
                                // If Not FromMobileApprovals Then
                                // 'End Addition By Amol Changle
                                // '''To refresh Workflow Approval page after specified action
                                // sb_UWW.Append("<script language='javascript'>" & vbCrLf)
                                // sb_UWW.Append("if (window.opener!=null )" & vbCrLf)
                                // sb_UWW.Append("{" & vbCrLf)
                                // sb_UWW.Append("refreshParent('frmDM_WorkFlowApprovals','DM_WorkFlowApprovals.aspx','../DM/DM_WorkFlowApprovals.aspx',true);" & vbCrLf)
                                // sb_UWW.Append("}" & vbCrLf)
                                // sb_UWW.Append("</script>" & vbCrLf)
                                // CommonFunction.General.WriteHTML(sb_UWW.ToString)
                                // End If
                                // End If
                                if (Convert.ToInt32(rowCount) > 1)
                                {
                                    
                                    ConfigurableWorkflowMessages.GetEmailMessage(ref m_strFromEmailID, ref m_strToEmailID, ref m_strCCEmailID, ref m_strSubject, ref m_strMessage, iMsgID, strPrimaryKey, strComments,UserName,ProjectID.ToString(),LoginType,UserID.ToString());
                                   // if (m_strToEmailID != "" & m_strToEmailID != ";") ;
                                        //CommonFunction.Emails.SendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage);
                                        //CommonFunctions.Emails.AppSendEmailWithCC(m_strToEmailID.Trim(), m_strCCEmailID, m_strFromEmailID.Trim(), m_strSubject, m_strMessage);
                                }
                            }
                        }
                    }
                    objDS = null/* TODO Change to default(_) if this is not a reference type */;
                    sb_UWW = null;
                    objWorkFlowDefinition = null;
                    m_objGlobalObject.TagID = Convert.ToInt64(strTagID);
                }
            }
            catch (Exception ex)
            {
            }

            return strPrimaryKey + "||" + WorkflowID;
        }


        public static void UpdateProjectRevisionDetails(string PrimaryKeyValue, string WorkflowAction, string TagID, string RequestStageID, string ProjectNatureOfDemandID, string strWorkflowOption, string ActionComment,string UserName)
        {
            // ============================================================================
            // Procedure Name		: UpdateProjectRevisionDetails
            // Description           : To update project revision table w.r.t. Stage action
            // Purpose               : same as purpose
            // Parameters Passed     : PrimaryKeyvalue,WorkflowAction (i.e Submit,Approve,Reject)
            // Parameters Affected   :
            // Assumptions           :
            // Dependencies          :
            // Author                : PrashantSJ
            // Created               : May 20, 2008
            // Revisions             :
            // =====================================================================
            System.Text.StringBuilder strSQLQuery = new System.Text.StringBuilder();
            int intRevisionReasonID = 0;
            string strRevisionRequestStageID = "";
            string strNextStageID = "";
            DataSet ds;

            strSQLQuery.Append("usp_Sel_WorkflowsStages "  );
            strSQLQuery.Append(PrimaryKeyValue  );
            strSQLQuery.Append("," + TagID);
            strSQLQuery.Append("," + PrimaryKeyValue  );

            ds = CommonFunctions.Data.GetDataSet(strSQLQuery.ToString(), "Revision", 0/* Conversion error: Set to default value for this argument */, 0/* Conversion error: Set to default value for this argument */, System.Convert.ToBoolean(true));

            foreach (DataRow objdataRow in ds.Tables[0].Select("ProjectNatureOfDemandID=" + ProjectNatureOfDemandID))
            {
                strRevisionRequestStageID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(objdataRow["RevisionRequestStageID"], ""), "").ToString();
                strNextStageID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(objdataRow["NextStageID"], ""), "").ToString();
            }

            ds = null/* TODO Change to default(_) if this is not a reference type */;
            strSQLQuery.Remove(0, strSQLQuery.Length);

            switch (WorkflowAction.ToUpper().Trim())
            {
                case "SYS_SUBMIT":
                    {
                        strSQLQuery.Append("EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason "  );
                        strSQLQuery.Append("N'" + PrimaryKeyValue + "'"  );
                        strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(ActionComment) + "'"  );
                        strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(UserName)) + "'");
                        strSQLQuery.Append(",N'S'");

                        intRevisionReasonID = System.Convert.ToInt32(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString(), System.Convert.ToBoolean(true)), "0"), "0"));
                        strSQLQuery.Remove(0, strSQLQuery.Length);

                        if (intRevisionReasonID > 0)
                        {
                            strSQLQuery.Append("EXEC usp_Upd_tbl_PM_ProjectRevision_BaselineStatus "  );
                            strSQLQuery.Append(PrimaryKeyValue  );
                            strSQLQuery.Append(", N'S'");

                            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString(), System.Convert.ToBoolean(true));

                            strSQLQuery.Remove(0, strSQLQuery.Length);

                            // Update the field SentForApprovalBy field value with the logged in user's name
                            strSQLQuery.Append("EXEC usp_Upd_tbl_PM_ProjectRevision_SentForApprovalBy "  );
                            strSQLQuery.Append(PrimaryKeyValue  );
                            strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(UserName)) + "'");

                            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString(), System.Convert.ToBoolean(true));
                            strSQLQuery.Remove(0, strSQLQuery.Length);
                        }

                        break;
                    }

                case "SYS_APPROVE":
                    {
                        if ((strRevisionRequestStageID == RequestStageID & strNextStageID != RequestStageID))
                        {
                            strSQLQuery.Append("EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason "  );
                            strSQLQuery.Append("N'" + PrimaryKeyValue + "'"  );
                            strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(ActionComment) + "'"  );
                            strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(UserName) ) + "'");
                            strSQLQuery.Append(",N'A' ");

                            intRevisionReasonID = System.Convert.ToInt32(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString(), System.Convert.ToBoolean(true)), "0"), "0"));
                            strSQLQuery.Remove(0, strSQLQuery.Length);
                        }

                        break;
                    }

                case "SYS_REJECT":
                    {
                        if (strRevisionRequestStageID == RequestStageID & strNextStageID != RequestStageID)
                        {
                            strSQLQuery.Append("EXEC usp_Ins_tbl_PM_ProjectBaselineRejectionReason "  );
                            strSQLQuery.Append("N'" + PrimaryKeyValue + "'"  );
                            strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(ActionComment) + "'"  );
                            strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(UserName)) + "'");

                            intRevisionReasonID = System.Convert.ToInt32(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString(), System.Convert.ToBoolean(true)), "0"), "0"));
                            strSQLQuery.Remove(0, strSQLQuery.Length);
                        }

                        break;
                    }
            }

            strSQLQuery = null;
        }
        public static void UpdateOtherEntityRevisions(string PrimaryKeyValue, string WorkflowAction, string TagID, string RequestStageID, string ProjectNatureOfDemandID, string strWorkflowOption,string userName,string ProjectID)
        {
            // ============================================================================
            // Procedure Name		: UpdateOtherEntityRevisions
            // Description           : To update other entity (i.e Milestones,Deliverables etc.) revision table w.r.t. Stage action
            // Purpose               : same as purpose
            // Parameters Passed     : PrimaryKeyvalue,WorkflowAction (i.e Submit,Approve,Reject)
            // Parameters Affected   :
            // Assumptions           :
            // Dependencies          :
            // Author                : PrashantSJ
            // Created               : June 04, 2008
            // Revisions             :
            // =====================================================================
            System.Text.StringBuilder strSQLQuery = new System.Text.StringBuilder();
            int intRevisionReasonID = 0;
            string strRevisionRequestStageID = "";
            string strNextStageID = "";
            DataSet ds;

            strSQLQuery.Append("usp_Sel_WorkflowsStages "  );
            strSQLQuery.Append(ProjectID);
            strSQLQuery.Append("," + TagID);
            strSQLQuery.Append("," + PrimaryKeyValue  );

            ds = CommonFunctions.Data.GetDataSet(strSQLQuery.ToString(), "Revision", 0/* Conversion error: Set to default value for this argument */, 0/* Conversion error: Set to default value for this argument */, System.Convert.ToBoolean(true));

            foreach (DataRow objdataRow in ds.Tables[0].Select("ProjectNatureOfDemandID=" + ProjectNatureOfDemandID))
            {
                strRevisionRequestStageID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(objdataRow["RevisionRequestStageID"], ""), "").ToString();
                strNextStageID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(objdataRow["NextStageID"], ""), "").ToString();
            }

            ds = null/* TODO Change to default(_) if this is not a reference type */;
            strSQLQuery.Remove(0, strSQLQuery.Length);

            switch (WorkflowAction.ToUpper().Trim())
            {
                case "SYS_SUBMIT":
                    {
                        strSQLQuery.Append("EXEC usp_Upd_EntityRevision_BaselineStatus "  );
                        strSQLQuery.Append("N'" + PrimaryKeyValue + "'"  );
                        strSQLQuery.Append("," + TagID  );
                        strSQLQuery.Append(",N'S'");
                        strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(userName)) + "'");
                        break;
                    }

                case "SYS_APPROVE":
                    {
                        if ((strRevisionRequestStageID == RequestStageID & strNextStageID != RequestStageID) | (strWorkflowOption == "JUMPTOSTAGE"))
                        {
                            strSQLQuery.Append("EXEC usp_Upd_EntityRevision_BaselineStatus "  );
                            strSQLQuery.Append("N'" + PrimaryKeyValue + "'"  );
                            strSQLQuery.Append("," + TagID  );
                            strSQLQuery.Append(",N'B'");
                            strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(userName)) + "'");
                        }

                        break;
                    }

                case "SYS_REJECT":
                    {
                        if (strRevisionRequestStageID == RequestStageID & strNextStageID != RequestStageID)
                        {
                            strSQLQuery.Append("EXEC usp_Upd_EntityRevision_BaselineStatus ");
                            strSQLQuery.Append("N'" + PrimaryKeyValue + "'" );
                            strSQLQuery.Append("," + TagID  );
                            strSQLQuery.Append(",N'R'");
                            strSQLQuery.Append(",N'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(userName) ) + "'");
                        }

                        break;
                    }
            }

            if (strSQLQuery.ToString() != "")
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString(), System.Convert.ToBoolean(true));

            strSQLQuery = null;
        }

    }

    public class EntityApprovalParameters
    {
        public int intEntityID { get; set; }
        public int MasterTagID { get; set; }
        public string Status { get; set; }
        public int ProjectID { get; set; }
        public string Remarks { get; set; }
        public string UserName { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }
        public int rowCount { get; set; }
        public string WorkflowID { get; set; }
    }
}
