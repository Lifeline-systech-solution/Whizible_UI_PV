using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WhizibleAPI.Models.PM
{
    //Model Name : PM_ProjectTimesheetlist
    //Created By : Dipali V
    //Created Date : 21th Sep 2023

    public class PM_ProjectTimesheetlist
    { }

    public class EmployeeList
    {
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
    }

    public class SiteList
    {
        public string SiteID { get; set; }
        public string SiteName { get; set; }
    }

    public class TimesheetList
    {
        public string TimeSheetID { get; set; }
        public string TimeSheetText { get; set; }
       
    }

    public class OtherAttributes
    {
        public string TimeSheetNo { get; set; }
        public string ProjectID { get; set; }
        public string HighLights { get; set; }
        public string Sleepage { get; set; }
        public string Suggetion { get; set; }
        public string Issues { get; set; }
        public string Activities { get; set; }
        public string WSRFileName { get; set; }
        public string FileDescription { get; set; }

    }

    public class WSRDetails
    {
        public string CreatedDate { get; set; }
        public string CustomerName { get; set; }
        public string ProjectName { get; set; }
        public string FromDate { get; set; }
        public string CompanyID { get; set; }
        public string ToDate { get; set; }
        public string Subject { get; set; }
        public string NextPeriodToDate { get; set; }


    }
    public class WSR_Activities
    {
        public string TaskID { get; set; }
        public string Task { get; set; }
        public string WorkHrs { get; set; }
        public string Status { get; set; }
        public string SumDuration { get; set; }


    }


    public class ProjectTimesheet
    {
        public List<SiteList> SiteLists { get; set; }
        public List<EmployeeList> EmployeeLists { get; set; }
        public List<TimesheetList> TimesheetLists { get; set; }
        public List<WSRDetails> WSRDetails { get; set; }
        public List<OtherAttributes> OtherAttributes { get; set; }
        public List<WSR_Activities> WSR_Activities { get; set; }
        public int ProjectID { get; set; }
        public int TimesheetNo { get; set; }
        public string UniqueIDs { get; set; }
        public string ReportFormat { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string ActualWork { get; set; }
        public string TimesheetID { get; set; }
        public string SiteID { get; set; }
        public string EmployeeID { get; set; }
        public string Status { get; set; }
        public string FilterName { get; set; }
        public string LoginType { get; set; }
        public string QueryText { get; set; }
        public string UserName { get; set; }
        public int TagID { get; set; }
        public int UserID { get; set; }
        public int Flag { get; set; }
        public int FilterID { get; set; }
        //Added By Dipali V On 1st Nov 2023 For Project Setting
        public int IsRate_CorporateValidation { get; set; }
        public int IsTS_WorkingDayCorporateValidation { get; set; }
        //public int IsIR_TimesheetExpense { get; set; }
        public int IsIR_FinalValue { get; set; }
        public int IsAllowSmartEdit { get; set; }
        public int ProjectIRGenerator { get; set; }
        public int ProjectIRApprover { get; set; }
        public int ProjectTimesheetApprover { get; set; }
        public int IsAllValuesInSiteCurrency { get; set; } //Added By Dipali V On 27th Dec 2023 For Which Currency Consider for Calculation on billing Information Page
        public int IsIR_Approved { get; set; }
        public int IsIR_Rejected { get; set; }
        //End of Added By Dipali V On 1st Nov 2023 For Project Setting
        //public int Flag { get; set; }
    }



    public class FilterQuery
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
        public string SQL { get; set; }
        public int ControlID { get; set; }
        public string ControlValue { get; set; }
        public string Error { get; set; }
    }
}