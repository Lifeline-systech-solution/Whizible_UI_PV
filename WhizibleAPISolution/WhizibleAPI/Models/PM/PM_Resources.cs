using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_Resources
    {
    }
    public class ResourcesParameter
    {
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public int ProjectID { get; set; }
        public string QueryText { get; set; }
        public string LoginType { get; set; }
        public string UserName { get; set; }
        public string FilterName { get; set; }
        public string CreatedBy { get; set; }
        public int FilterID  { get; set; }
        public int FilterFlag { get; set; }
        public int CurrentYear { get; set; }
        public int EmployeeID { get; set; }
        public int IsPieChart { get; set; }
        public int Flag { get; set; }
        public int intUserID { get; set; }
        public int intRoleLevel { get; set; }
        public int ProjectEmployeeRoleID { get; set; }
        public string ExpectedStartDate { get; set; }
        public string ExpectedEndDate { get; set; }
        public int ToolID { get; set; }
        public string strTaskID { get; set; }
        public string WorkflowApprover { get; set; }
        public string intYrs { get; set; }
        public string intMnths { get; set; }
        public int IsProjectOver { get; set; }
        public int YearsOfExperience { get; set; }
        public int MonthsOfExperience { get; set; }
        public int RequestID { get; set; }
        public string StrFlag { get; set; }
       
        public int PageSize  { get; set; }
        public int PageNumber { get; set; }




        public string ResourcePercentage { get; set; }
        public string ProjectRoleID { get; set; }
        public string BudgetedHours { get; set; }
        public string Responsibility { get; set; }
        public string ResourceStatus { get; set; }
        public string IsResourceBillable { get; set; }
        public string ReportingTo { get; set; }
        //public string StrFlag { get; set; }

    }

    public class ARQueryList
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
    }


    public class ApproverList
    {
        public int intEmployeeID { get; set; }
        public int intEmployeeYears { get; set; }
        public int intEmployeeMonths { get; set; }
        public int ToolID { get; set; }
        public string strDescription { get; set; }

    }

    public class TaskApproverList
    {
        public string m_TimesheetApprovee { get; set; }
        public string m_ExpenseApprovee { get; set; }
        public string m_strDeliverableList { get; set; }
        public string m_strIssueList { get; set; }
        public string m_ResponsiblePersonForIssue { get; set; }
        public string m_ResponsiblePersonForInvoice { get; set; }
        public string m_MSPFileOwner { get; set; }
        public string m_strRisksList { get; set; }
        public string m_PersonResponsibleForTimesheetblocking { get; set; }
        public string m_strTimesheetDefaultApprover { get; set; }
        public string m_strExpenseDefaultApprover { get; set; }
        public string m_StrIRApprover { get; set; }
        public string m_strInvoiceGenerator { get; set; }
        public string m_TimesheetAuthenticator { get; set; }

    }

    public class ProjectEmployeeWorkPeriod
    {
        public int m_lngEmployeeID { get; set; }
        public string m_strUserName { get; set; }
        public int m_intTotalDays { get; set; }
        public string m_strEmployeeName { get; set; }
        public int m_Currntdays { get; set; }


    }

    public class ProjectDetails
    {
        public string StartDate { get; set; }
        public string TodayDate { get; set; }
    }

    public class ProjectResourceData
    {
        public string StartDate { get; set; }
        public int m_intYearsToBeShown { get; set; }
        public int m_intMonthsToBeShown { get; set; }
    }

    public class RequestParameters
    {  //Added by Dipali V on 6th May 2026 for vendor management - request vendor and dropdown include ID
        public int VendorID { get; set; }
        public int IncludeVendorID { get; set; }
        public int RequestID { get; set; }
        public int EmployeeID { get; set; }
        public string UniqueComment { get; set; }
        public int Flag { get; set; }
        public string LoginType { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int ProjectEmployeeRoleID { get; set; }
        public DataTable ProjectEmployeeRolePrepone { get; set; }
        public DataTable ResourceRequestPreponeType { get; set; }
        public DataTable GetOldAllocationDetails { get; set; }
        public DataTable GetChangeAllocationRequestList { get; set; }
        public DataTable drProjectEmployeeRole { get; set; }
        public DataTable drProjectEmployee { get; set; }
        public DataTable drPreponeRequestDetail { get; set; }
        public DataTable drExtendBookingDetail { get; set; }
        public object drProjectResourceAllocation { get; set; }
        public object SettingValue { get; set; }
        public object ProjectEndDate { get; set; }
        public int MyProperty { get; set; }
        public string UserName { get; set; }
        public string RequestedStartDate { get; set; }
        public string RequestedEndDate { get; set; }
        public string Specialrequest { get; set; }
        public int ResourcePoolID { get; set; }
        public int RoleID { get; set; }
        public decimal WorkHour { get; set; }
        public int ProjectEmployeeID { get; set; }
        public object drResourcePoolAndRoleId { get; set; }
        public int Priority { get; set; }
        public string RequestType { get; set; }
        public float PrevAllocation { get; set; }
        public float NewAllocation { get; set; }
        public float Hours { get; set; }
        public string StrEndDate { get; set; }
        public float Percentage { get; set; }
        public float TotalWorkHrs { get; set; }
        public string WorkHrs { get; set; }

        public int m_IsProjectResourceAllocation { get; set; }
        public int intRequestID { get; set; }
        public string strRequestID  { get; set; }
        public string strType { get; set; }
        //Added By Dipali V On 15th May 2024 For Compared With DA
        public string EffectiveDate { get; set; }
        public string NewAllocationPre { get; set; }
        public string NewEndDate { get; set; }



    }

    public class ResourceCompanyInformation  
    {
        public Boolean RestrictByMinHours { get; set; }
        //Commented And Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
        //public float MinHoursForDAEntry { get; set; }
        public string MinHoursForDAEntry { get; set; }
        //End Of Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
    }

    public class ResourceSelectionParameter
    {
        public string Role { get; set; }
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string UserName { get; set; }
        public string BusinessGroup { get; set; }
        public string BusinessUnit { get; set; }
        public string Department { get; set; }
        public string Location { get; set; }
        public string RoleDescription { get; set; }
        public string DesignationName { get; set; }
        public string Deployable { get; set; }

       
    }


}