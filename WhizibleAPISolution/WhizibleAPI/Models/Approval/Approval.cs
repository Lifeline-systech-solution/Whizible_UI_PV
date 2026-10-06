using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//using WorkFlowGeneral.DefinitionDetails;
namespace WhizibleAPI.Models.Approval
{
    public class Approval
    {


    }
    public class Definition
    {
        public interface IGlobal
        {

            double TagID { get; set; }
            string FromWhere { get; }
            int RoleLevel { set; }
            bool returnHTML { get; set; }
            string TableStyle { get; set; }
            string clsTable { get; set; }
            string clsTR { get; set; }
            string UseHashTable { get; set; }
            string UserName { get; set; }
            double LoginID { get; set; }
            bool IsCustomerCreated { get; set; }
            double ParentTagID { get; set; }
            string LoginType { get; set; }
            double UserID { get; set; }
            double RoleID { get; set; }
            double ProjectID { get; set; }
            double LCID { get; set; }
        }

        public event After_SubmitEventHandler After_Submit;

        public event MailSendEventHandler MailSend;

        public event After_RejectEventHandler After_Reject;

        public event Before_RejectEventHandler Before_Reject;

        public event After_ApproveEventHandler After_Approve;
        public event Before_ApproveEventHandler Before_Approve;
        public event Before_SubmitEventHandler Before_Submit;

        public struct WAF_ProcessStageDetails
        {
            string ProcessID;
            string PreviousStagID;
            string StageID;
            string NextStageID;
            string PreviousActionID;
            string ActionID;
            string NextActionID;
            string StageType;
            int PageID;
            string TableName;
            string PrimaryKeyName;
            string ActionType;
            double UserID;
            string LoginType;
            int VersionID;
        }
       

        public class WorkflowEmails : EventArgs
        {

            //public sub new();
            public string MailTo { get; set; }
            public string MailCC { get; set; }
            public string MailFrom { get; set; }
            public string Subject { get; set; }
            public string Body { get; set; }
            public string MailBCC { get; set; }
            public bool ShowPopup { get; set; }




        }
        public void Approval()
            {
            }

        public void Initialize() { }

        public void FillWorkFlowDefinition(IGlobal Global, string PrimaryKey) { }
        //protected override void Finalize() { }
        //~Car()
        protected virtual void Dispose() { }

        //public Approval UpdateWorkFlowData(IGlobal Global, string PrimaryKeyValue, string WorkFlowOption, string ActionID, string InstanceID)
        //{
        //    return Approval; 
        //}
        
          public delegate void After_RejectEventHandler(ref WAF_ProcessStageDetails refType, IGlobal global );

        public delegate void Before_SubmitEventHandler(ref bool Cancel, ref WAF_ProcessStageDetails refType, IGlobal global);
        public delegate void After_SubmitEventHandler(ref WAF_ProcessStageDetails refType, IGlobal global);
        public delegate void Before_ApproveEventHandler(ref bool Cancel, ref WAF_ProcessStageDetails refType, IGlobal global);
        public delegate void After_ApproveEventHandler(ref WAF_ProcessStageDetails refType, IGlobal global);
        public delegate void Before_RejectEventHandler(ref bool Cancel , ref WAF_ProcessStageDetails refType, IGlobal global);

        public delegate void MailSendEventHandler(ref  WorkflowEmails refType, string InstanceID , ref WAF_ProcessStageDetails refType1, string Action,string PrimaryKeyValue);

    }
}