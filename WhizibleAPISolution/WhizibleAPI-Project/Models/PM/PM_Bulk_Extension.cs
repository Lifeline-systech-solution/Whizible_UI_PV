using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_Bulk_Extension
    {
        public int ContractID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }
        public int LoginID { get; set; }
        public int ProjectID { get; set; }
        public int RoleId { get; set; }
        public int DesignationID { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }

        //public int ExistingWorkhours { get; set; }
        public string ExistingWorkhours { get; set; }
        public int PageNo { get; set; }
        public int RoleID { get; set; }
        public int Flag { get; set; }

        public string Status { get; set; } //Added by Ajit L on 29/01/2025
        //public float ContractValue { get; set; }

        //public int ProjectEmployeeRoleID { get; set; }
        //public string ApprovalRemark { get; set; }
        //public DateTime NewResourceNewEndDate { get; set; }

        public string ProjectValue { get; set; }
        //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        public int WorkflowID { get; set; }
        public string CreatedBy { get; set; }
        public List<WorkflowAttribute> WorkflowAttributes { get; set; }
        public string SubmitterRemark { get; set; }
        public List<ApproverRoleList> ApproverRoles { get; set; }
        //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen

    }
    //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
    public class WorkflowAttribute
    {
        public int WorkflowID { get; set; }
        public int StageID { get; set; }
        public int ProjectID { get; set; }
        public string ActionType { get; set; }
        public int ProjectApprovalID { get; set; }
        public int FromStage { get; set; }

    }

    public class ApproverRoleList
    {
        
        public int ProjectID { get; set; }        
        public int RoleID { get; set; }
        public int FromStageID { get; set; }
        public int ToStageID { get; set; }

        public int WorkflowID { get; set; }

    }
    //End of Added by Vishal  Mane on 09/02/2026 to open off canvas for Send For Approval Screen
    public class ProjectEmployeeRoleModel
    {
        public int ProjectEmployeeRoleID { get; set; }
        //public DateTime? ResourceNewEndDate { get; set; }
        //public DateTime? ExpectedStartDate { get; set; }
        //public DateTime? TentativeDateOfRelieving { get; set; }
        public string ResourceNewEndDate { get; set; }
        public string ExpectedStartDate { get; set; }
        public string TentativeDateOfRelieving { get; set; }
        public string SubmitterComments { get; set; }
        //public DateTime? EffectiveFromDate { get; set; }
        public string EffectiveFromDate { get; set; }
        public string ApprovalStatus { get; set; }
        public string RequestId { get; set; }
        public int ProjectID { get; set; }
        public int IsResubmit { get; set; }
        public string UserName { get; set; }
    }

    public class ProjectApprovalModel
    {
        public int ProjectID { get; set; }
        //public int ProjectValue { get; set; }
        //public int ProjectNewEffort { get; set; }
        public string ProjectValue { get; set; }
        public string ProjectNewEffort { get; set; }
        public int ProjectStatus { get; set; }
        public string NewEndDate { get; set; }
        public string ApprovalStatus { get; set; }
        public string SubmitterRemark { get; set; }
        public string SubmittedBy { get; set; }
        public string RequestId { get; set; }
        public int IsResubmit { get; set; }
        public int ProjectApprovalId { get; set; }

    }
     



}