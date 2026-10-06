
using System;
using System.Security.Permissions;

namespace WhizibleAPI.Models.RM
{
    public class RM_InfraResourceVM
    {
        public int InfraResourceId { get; set; }
        public string InfraTypeName { get; set; }
        public string InfraGroupName { get; set; }
        public string InfraName { get; set; }
        public string BusinessGroup { get; set; }
        public string AvaliableFrom { get; set; }
        public string AvaliableTill { get; set; }
        //  public string SharedResource { get; set; }
        public string InfraStatus { get; set; }
    }
    public class InfraFilterParameter
    {
        public string WhereClause { get; set; }
        public int RoleID { get; set; }
        public int LoginUserID { get; set; }
        
    }
    public class RM_InfraResource
    {
        public int InfraResourceId { get; set; }
        public string InfraName { get; set; }
        public string Description { get; set; }
        public int InfraTypeId { get; set; }
        public int InfraGroupId { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public decimal MaxAllocationPerDay { get; set; }
        public decimal TotalQuantity { get; set; }
        public decimal CostPerHour { get; set; }
        public decimal RatePerHour { get; set; }
        public decimal TotalCostOfAcquisition { get; set; }
        public decimal DepreciationRate { get; set; }
        public string AvaliableFrom { get; set; }
        public string AvaliableTill { get; set; }
        public string RetiredOn { get; set; }
        public string Shared { get; set; }
        public int InfraStatusId { get; set; }
        public string CreatedBy { get; set; }
        public bool IsActive { get; set; }
    }
    public class RM_InfraRenewalVM
    {
        public string TypeOfSubscription { get; set; }
        public string BillingPeriod { get; set; }
        public string DateOfRenewal { get; set; }
        public string NextBillingDate { get; set; }
        public decimal Amount { get; set; }
        public decimal TotalQuantity { get; set; }
        public string CurrencyName { get; set; }//Added BY Rutuja D. on 23 July 2021 For Display Currency Name
    }
    public class RM_InfraRenewal
    {
        public int InfraRenewalId { get; set; }
        public int InfraResourceId { get; set; }
        public decimal TotalQuantity { get; set; }
        public string TypeOfSubscription { get; set; }
        public string BillingPeriod { get; set; }
        public string DateOfRenewal { get; set; }
        public int CurrencyId { get; set; }
        public decimal Amount { get; set; }
        public string NextBillingDate { get; set; }
        public string CreatedBy { get; set; }
    }
    public class RM_InfraResourceHistory
    {
        public int InfraResourceHistoryId { get; set; }
        public int InfraResourceId { get; set; }
        public string FieldName { get; set; }
        public string OldValue { get; set; }
        public string NewValue { get; set; }
        public string CreatedBy { get; set; }
        //Commented & Added BY Rutuja D. on 14 Dec 2021 For Change the Date Format
        //public DateTime CreatedDate { get; set; }
        public string CreatedDate { get; set; }
        //End Commented & Added BY Rutuja D. on 14 Dec 2021 For Change the Date Format

    }
    public class RM_InfraResourceRequest
    {
        public int InfraResourceId { get; set; }
        public string InfraName { get; set; }
        public string Description { get; set; }
        public int InfraTypeId { get; set; }
        public int InfraGroupId { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public decimal MaxAllocationPerDay { get; set; }
        public decimal TotalQuantity { get; set; }
        public decimal CostPerHour { get; set; }
        public decimal RatePerHour { get; set; }
        public decimal TotalCostOfAcquisition { get; set; }
        public decimal DepreciationRate { get; set; }
        public string AvaliableFrom { get; set; }
        public string AvaliableTill { get; set; }
        public string RetiredOn { get; set; }
        public string Shared { get; set; }
        public int InfraStatusId { get; set; }
        public string CreatedBy { get; set; }
        public bool IsActive { get; set; }
    }
    public class RM_InfraAssignments
    {
        public int Date { get; set; }
        public string Day { get; set; }
        public int Count { get; set; }
        public DateTime ActualDate { get; set; }
        public int InfraResourceId { get; set; }

    }

    public class RM_InfraFilter
    {
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public int ResourceID { get; set; }

    }
    public class RM_InfraAssign
    {
        public int InfraResourceId { get; set; }
        public string ActualDate { get; set; }

    }
    public class RM_InfraProjectAvailablity
    {
        public string ProjectName { get; set; }
        public int AllocatedQuantity { get; set; }
        public string  StartDate { get; set; }
        public string EndDate { get; set; }
        public decimal CostPerHour { get; set; }
        public decimal RatePerHour { get; set; }
    }
    public class RM_AssignmentDates
    {
        public int InfraResourceId { get; set; }
        public  string AssignDate { get; set; }
    }

    public class ITparam
    {
      public int InfraTypeId { get; set; }
      public int InfraGroupId { get; set; }
      public int InfraStatusId { get; set; }
    }
    #region Dropdown list 

    public class It_InfraTypeCbo
    {
        public int InfraTypeId { get; set; }
        public string InfraTypeName { get; set; }
    }
    public class It_InfraGroupCbo
    {
        public int InfraGroupId { get; set; }
        public string InfraGroupName { get; set; }
    }
    public class It_InfraStatusCbo
    {
        public int InfraStatusId { get; set; }
        public string InfraStatus { get; set; }
    }

    #endregion

    public class ReportParameter
    {
        public int employeeID { get; set; }
        public int intProxyUserID { get; set; }
        public string StatusCode { get; set; }
        public int InfraResourceId { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public string ReportFormat { get; set; }
        public int intMobileView { get; set; } = 0;

        //Added by imran on 14-12-2021
        public string filterWhereClause { get; set; }        
        //End by imran on 14-12-2021
    }

    public class RM_InfraResourceXlsx : RM_InfraResource
    {
        public string ColumnError { get; set; }

        public string Type { get; set; }
        public string InfraGroup { get; set; }
        public string BusinessGroup { get;  set; }
        public string OrganizationUnit { get;  set; }
        public string InfraStatus { get;  set; }
        public string Active { get;  set; }
    }

   public class RM_InfraResourceXlsx2
    {
        public string ColumnError { get; set; }

        public string Type { get; set; }
        public string InfraGroup { get; internal set; }
        public string BusinessGroup { get; internal set; }
        public string OrganizationUnit { get; internal set; }
        public string InfraStatus { get; internal set; }
        public string Active { get; internal set; }
    }

    public class IR_Activestatus
    {
        public string Status { get; set; }
        public int InfraResourceId { get; set; }
        public string Message { get; set; }
    }
}