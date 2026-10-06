using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_OpportunityRequest
    {

    }

    #region Resource plan 

    public class OR_ResourcePlan
    {
        public int PipelineID { get; set; }
        public int RoleID { get; set; }
        public string ToolID { get; set; }
        public int OpportunityID { get; set; }
        public string Skill { get; set; }
        public float TotalFTE { get; set; }
        public DateTime TentativeStartDate { get; set; }
        public DateTime TentativeEndDate { get; set; }
        public DateTime? CoolingOf { get; set; }
        public string Description { get; set; }
        public string Distribution { get; set; }
        public string SoftBooking { get; set; }
        public string Title { get; set; }
        public string RoleDescription { get; set; }
        public string Status { get; set; }
    }
    public class OR_Params
    {
        public int PipelineID { get; set; } = 0;
        public int OpportunityID { get; set; }
    }
    public class OR_ParamsSave : OR_Params
    {
        public int ToolID { get; set; }
        public int RoleID { get; set; }
        //Commented and Added By RehanC for Date Conversion Issue on 23rd Mar 2023
        // public DateTime TentativeStartDate { get; set; }
        public string TentativeStartDate { get; set; }
        // public DateTime TentativeEndDate { get; set; }
        public string TentativeEndDate { get; set; }
        //public DateTime CoolingOf { get; set; }
        //End Of Comment By RehanC
        public string CoolingOf { get; set; }
        public string CreatedBy { get; set; }
        //public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        //public DateTime ModifiedDate { get; set; }
        public float TotalFTE { get; set; }
        public string Description { get; set; } //this is special request
        public string Status { get; set; }
    }

    public class OR_ResourcePlanDistribution: OR_Params
    {
        public int DistributionID { get; set; }
        public int Year { get; set; }
        public decimal ?  Jan { get; set; }
        public decimal? Feb { get; set; }
        public decimal? Mar { get; set; }
        public decimal? Apr { get; set; }
        public decimal? May { get; set; }
        public decimal? Jun { get; set; }
        public decimal? Jul { get; set; }
        public decimal? Aug { get; set; }
        public decimal? Sep { get; set; }
        public decimal? Oct { get; set; }
        public decimal? Nov { get; set; }
        public decimal? Dec { get; set; }
    }
    public class OR_SoftbookingParams
    {
        public int RoleID { get; set; }
        public int BusinessGropupID { get; set; }
        public int OrganizationUnitID { get; set; }
        public int FacilityID { get; set; }
        public string PrimarySkills { get; set; }
        public string ResourceName { get; set; }

    }
    public class Softbooking
    {
        //public int UniqueID { get; set; }
        //public string ResourceName { get; set; }
        //public string BusinessGroup { get; set; }
        //public string OrganizationUnit { get; set; }
        //public string Role { get; set; }
        //public string PrimarySkills { get; set; }
        //public decimal TotalExperience{ get; set; }


        //public int UniqueID { get; set; }
        public int RoleId { get; set; }
        public string UserName { get; set; }
        public string EmployeeName { get; set; }
        public int EmployeeID { get; set; }
        public string BusinessGroup { get; set; }
        public string Location { get; set; }
        public string RoleDescription { get; set; }
        public string Primaryskills { get; set; }
        public string TotalExp { get; set; }

    }

    public class OR_SoftbookingSave: OR_Params
    {   //Commented and Added By RehanC on 23rd Mar 2023
        //public List<int> EmployeeIDs { get; set; }
        public string EmployeeIDs { get; set; }
        //End Of Comment By RehanC
        public string UserName { get; set; }
    }
    public class OR_SodtBoonkingFilter : OR_Params
    {
        public string WhereClause { get; set; }
    }

    public class TaskParameter
    {
        public int employeeID { get; set; }
        public int intProxyUserID { get; set; }
        public string StatusCode { get; set; }
        public int OpportunityID { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public string ReportFormat { get; set; }
        public int intMobileView { get; set; } = 0;

    }

    #endregion

    public class OpportunityRequest
    {
        public int OpportunityID { get; set; }
        public string Prospect { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public double Size { get; set; }
        public string Address { get; set; }
        public string PinCode { get; set; }
        public int CountryID { get; set; }
        public int CurrencyID { get; set; }
        public int RegionID { get; set; }
        public int ProspectID { get; set; }
        public int RaisedBy { get; set; }
        public string RaisedDate { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public int ResourcePoolID { get; set; }
        public int GroupID { get; set; }
        public int ReviewFrequency { get; set; }
        public string CoolingOf { get; set; }
        public int StatusID { get; set; }
        public string ApprovedStatus { get; set; }
        public bool IsApprovedOnce { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public int CustomerID { get; set; }
        public string ApproxStartDate { get; set; }
        public double ApproxDuration { get; set; }
        public DateTime ApproxEndDate { get; set; }
        public int ConvertedToProject { get; set; }
        public int ProjectID { get; set; }
        public int ProductID { get; set; }
        public int IntUserId { get; set; }
        public string ProbabilityCurrent { get; set; }
        public string ProbabilityComment { get; set; }
    }

    public class RM_ORGetModel : OpportunityRequest
    {
        public string OpportunityStatus { get; set; }
        public int IsConvertedToProject { get; set; }
        public string EmployeeName { get; set; }
        public string ApprovedStatusFilter { get; set; }
        public string ProjectName { get; set; }
        public string FrequencyName { get; set; }
        public string CustomerName { get; set; }
        public int IsDemandApprover { get; set; }
    }

    public class OR_Filter : OP_Filter
    {
        public string WhereClause { get; set; }
        public int IntUserID { get; set; }
     
    }

    public class OP_Customer
    {
        public string CustomerName { get; set; }
        public int Customer { get; set; }
        public string CustomerID { get; set; }
        public DateTime DateSigned { get; set; }
        public string AccountNumber { get; set; }
        public string ProjectOrProductCustomer { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string EmailID { get; set; }

        public bool IsActiveLogin { get; set; }

    }
    public class OP_Approver
    {
        public string EmployeeName { get; set; }
        
    }

    public class OP_BusinessGroupLocation
    {
        public int OUPoolID { get; set; }
        public string Location { get; set; }
        public int Ordinaery { get; set; }
    }

    public class OP_ResourcePoolLocation
    {
        public int ResourcePoolID { get; set; }
        public string ResourcePoolName { get; set; }
        
    }
    public class OP_BusinessGroups
    {
        public int BusinessGroupID { get; set; }
        public string BusinessGroup { get; set; }
    }
    public class OP_DeliveryTeam
    {
        public int GroupID { get; set; }
        public string GroupName { get; set; }
    }

      public class OP_SendForApprovalParams : OpportunityRequest
    {
        //public int OpportunityID { get; set; }
        public string Comment { get; set; }
        public string StatusChangeDate { get; set; }
        public string FromStatus { get; set; }
        public string ToStatus { get; set; }
        public int statusChangedBy { get; set; }
    }

    public class OP_Project
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public int CustomerID { get; set; }
    }

    public class OP_SendForApprovalRevision
    {
         public bool IsSendForApproval { get; set; }
         public bool IsRevision { get; set; }
         public string OprStatus { get; set; }
    }

    public class OP_Filter
    {
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public int OprID { get; set; }
        public int DUID { get; set; }
        public int DTID { get; set; }
    }

    public class OP_Activestatus
    {
        public string Status { get; set; }
        public int OprID { get; set; }
    }
    //Added By RehanC for Parameter Mismatch Issue on 6th April 2023
    public class OP_FillProjectByCustomerID
    { 
        public int CustomerID { get; set; }
    }
    //End of Comment By RehanC on 6th April 2023
}