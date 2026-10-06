using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_InfraRequest
    {
        public int RequestId { get; set; }
        public int ProjectId { get; set; }
        public string InfraName { get; set; }
        public int RequestedUserId { get; set; }
        public string ProjectName { get; set; }
        public decimal Requested { get; set; }
        public int Allocated { get; set; }
        public decimal NoOfResources { get; set; }
        public DateTime ? RequestedDate { get; set; }
        public DateTime ? FromDate { get; set; }
        public DateTime ? ToDate { get; set; }
        public DateTime? ApprovalDate { get; set; }
        public DateTime? AllocatedDate { get; set; }
        public decimal AvailableLicenses { get; set; }
        public string Status { get; set; }
        public string RequestedBy { get; set; }
        public string Comments { get; set; }
        public int AllocatedQuantity { get; set; }
        public List<RequestApprovers> RequestApprovers { get; set; }
        public string RoleName { get; set; }
        //public bool IsInfraApprover { get; set; }
        public bool IsApproverManager { get; set; } //Added By Rutuja D. on 1 Feb 2022
        public int InfraResourceId { get; set; }
        public string RequestedUserName { get; set; }
        public string Approvalby { get; set; }
        //public bool IsManagerExist { get; set; }
    }

    public class RequestApprovers
    {
        public string EmployeeName { get; set; }
        public string EmailID { get; set; }
    }
    public class ResourceMonth
    {
        public string MonthName { get; set; }
        public string MonthDateTime { get; set; }
        public List<ResourceWeekWiseDetails> ResourceWeekWiseDetails { get; set; }
    }
    public class ResourceWeekWiseDetails
    {
        public string Month { get; set; }
        public string MonthDateTime { get; set; }
        public string Week { get; set; }
        public int Count { get; set; }
        public string WeekStartDateTime { get; set; }
        public string WeekEndDateTime { get; set; }
    }

    public class RM_InfraRequestUpdateStatus
    {

        public int RoleID { get; set; }
        public int UserID { get; set; }

        public int InfraRequestId { get; set; }
        public int InfraResourceId { get; set; }
        public Decimal Quantity { get; set; }

        //public DateTime? StartDate { get; set; }


        //public DateTime? EndDate { get; set; }
        //public DateTime? RequestedDate { get; set; }
        //public string StartDate { get; set; }
        public DateTime? StartDate { get; set; }

        //public string EndDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string RequestedDate { get; set; }
        public string Status { get; set; }

        public string ModifiedBy { get; set; }

       
        public string RequestedBy { get; set; }
        public string Approvalby { get; set; }
        public string Comments { get; set; }
        public DateTime? AllocatedDate { get; set; }

        public string AllocatedBy { get; set; }

        public DateTime?  ApprovalDate { get; set; }
        public string  RequestApprover { get; set; }  //it may not need
        public int AllocatedQuantity { get; set; }
        public bool IsFromEdit { get; set; }


    }

    public class RM_InfraRequestUpdateStatus_N
    {

        public int RoleID { get; set; }
        public int UserID { get; set; }

        public int InfraRequestId { get; set; }
        public int InfraResourceId { get; set; }
        public Decimal Quantity { get; set; }

        public DateTime? StartDate { get; set; }


        public DateTime? EndDate { get; set; }
        public DateTime? RequestedDate { get; set; }
      
        public string Status { get; set; }

        public string ModifiedBy { get; set; }


        public string RequestedBy { get; set; }
        public string Approvalby { get; set; }
        public string Comments { get; set; }
        public DateTime? AllocatedDate { get; set; }

        public string AllocatedBy { get; set; }

        public DateTime? ApprovalDate { get; set; }
        public string RequestApprover { get; set; }  //it may not need
        public int AllocatedQuantity { get; set; }
        public bool IsFromEdit { get; set; }


    }

    public class RM_InfraRequestUpdateStatusMuliti: RM_InfraRequestUpdateStatus
    {
        public string InfraRequestIds { get; set; }
        //public string Approvalby { get; set; }
        //public string Status { get; set; }
        //public int RoleID { get; set; }
        //public bool IsFromEdit { get; set; }
    }

}