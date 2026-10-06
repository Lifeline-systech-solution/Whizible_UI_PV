using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WhizibleAPI.Models.PM
{
    public class PM_ProjectHealthSheet
    {
        public class projectparameter_input
        {
            public int UserID { get; set; }
            public string LoginType { get; set; }
        }


        public class projectlist_output
        {
            public int ProjectID { get; set; }
            public string ProjectName { get; set; }
           


        }



        public class activeresource_input
        {
            public int ProjectID { get; set; }
        }


        public class activeresource_output
        {
            public string Resource { get; set; }
            public string StartDate { get; set; }
            public string EndDate { get; set; }
            public string Work { get; set; }
            public string ActualWork { get; set; }

        }



        public class milestonedetail_input
        {
            public int ProgramID { get; set; }
            public int ProjectID { get; set; }
            public int ProjectTypID { get; set; }
            public int BusinessGroupID { get; set; }
            public int LocationID { get; set; }
            public string EndDate { get; set; }
            public int UserID { get; set; }


        }

        public class milestonedetail_output
        {
            public string ProjectName { get; set; }
            public string Milestone { get; set; }
            public bool IsReadyForBilling { get; set; }
            public string  BillAmount { get; set; }
            public string PlannedStartDate { get; set; }
            public string PlannedEndDate { get; set; }
            public string ActualStartDate { get; set; }
            public string ActualEndDate { get; set; }
            public int Slippage { get; set; }
            public string Milestonestatus { get; set; }
            public int ISSlipping { get; set; }

        }

        public class fetchTaskVsComplete_input
        {
            public int ProjectID { get; set; }
            public  string CurrentDate { get; set; }
        }

        public class fetchTaskVsComplete_output
        {
            public string ActualPercentComplete { get; set;}
            public int TotalTasks { get; set; }

        }

        public class FetchDelayInDays_input
        {
            public int ProjectID { get; set; }
            public string CurrentDate { get; set; }
        }



        public class FetchDelayInDays_output
        {
            public string DelayInterval { get; set; }
            public int DelayCount { get; set; }
        }

        public class FetchMonthlyResourceCost_input
        {
            public int ProjectID { get; set; }
            public string CurrentDate { get; set; }
        }

        public class FetchMonthlyResourceCost_output
        {
                public string Month { get; set; }
                public decimal ResourceCost { get; set; }
        }



        public class FetchPHSInformation_input
        {
            public int UserID { get; set; }
            public string LoginType { get; set; }
            public int ProjectID { get; set; }
            public string CurrentDate { get; set; }
        }

        public class FetchPHSInformation_output
        {          
           public string FromDate { get; set; }
           public string ToDate { get; set; }
           public string ProjectName { get; set; }
           public string ProjectType { get; set; }
           public string BusinessGroup { get; set; }
           public string Location { get; set; }
           public string ProjectGroupName { get; set; }
            public int ProjectTypeID { get; set; }
            public int ProjectGroupID { get; set; }
            public int BusinessGroupID { get; set; }
            public int LocationID { get; set; }



        }

        public class FilterDataDisplay
        {
            
            public int ProjectTypeID { get; set; }
            public int ProjectGroupID { get; set; }
            public int BusinessGroupID { get; set; }
            public int LocationID { get; set; }


        }




        public class PM_ProjectHealthSheetFilter_input
        {
            public int SelectedBG { get; set; }
            public int UserID { get; set; }
            public string LoginType { get; set; }
        }



        public class FetchListOfPractice
        {
            public int TypeId { get; set; }
            public string ProjectType { get; set; }
        }

        public class FetchListOfBG
        {
            public int BusinessGroupID { get; set; }
            public string  BusinessGroup { get; set; }
        }

        public class FetchListOfOU
        {
            public int LocationID { get; set; }
            public string Location { get; set; }
        }

        public class FetchListPG
        {
            public int ProjectGroupID { get; set; }
            public string ProjectGroupName { get; set; }
        }



        public class FrequencyDetails
        {
            public string Frequency { get; set; }
            public int FrequencyID { get; set; }
        }



        public class FilterProjectList
        {
            public int ProjectID { get; set; }
            public string ProjectName { get; set; }
            public string ExpectedStartDate { get; set; }
            public string ExpectedEndDate { get; set; }
        }


        public class FilterProjectlist_input
        {
            public int PracticeID { get; set; }
            public int BusinessID { get; set; }
            public int LocationID { get; set; }
            public int ProjectGroupID { get; set; }
            public int UserID { get; set; }
            public int ProjectID { get; set; }
            public string LoginType { get; set; }
            //Added By dipali V n 10th feb 2022 for get list of till not project
            public int ProgramID { get; set; }
            public int CategoryID { get; set; }
            public int OrganizationID { get; set; }
            public string ReportingEndDate { get; set; }
            //End of Added By dipali V n 10th feb 2022 for get list of till not project


        }



        public class SaveFilter_inputparamerter
        {
            public int TagID { get; set; }
            public int ProjectID { get; set; }
            public int UserID { get; set; }
            public int FilterID { get; set; }
            public int FilterFlag { get; set; }
            public string QueryText { get; set; }
            public string LoginType { get; set; }
            public string UserName { get; set; }
            public string FilterName { get; set; }
        }



        public class MyFilterlist_input
        {
            public int ProjectID { get; set; }
            public int TagID { get; set; }
            public string LoginType { get; set; }
            public int UserID { get; set; }
        }


        public class MyFilter_output
        {
            public int FilterId { get; set; }
            public string FilterName { get; set; }
            public bool SetDefault { get; set; }
            public string QueryText { get; set; }
            public int EmployeeID { get; set; }
        }


        public class ChcekFilter_input
        {
            public int FilterID { get; set; }
        }

        public class CheckFilter_output
        {
            public int FilterID { get; set; }
            public string FilterName { get; set; }
            public string WhereClause { get; set; }
        }


        public class DefaultFilter_input
        {
           
            public int ProjectID { get; set; }
            public string LoginType { get; set; }
            public int UserID { get; set; }
            public int TagID { get; set; }
            public int FilterID { get; set; }
            public int Flag { get; set; }

        }


        public class getDefaultFilterStatus_output
        {
            public int FilterID { get; set; }
            public int ProjectID { get; set; }
            public bool SetDefault { get; set; }
        }

        public class GetPHSDefaultFilter_output
        {
            public string FilterName { get; set; }
            public int FilterID { get; set; }
            public string QueryText { get; set; }
        }

        public class GetSQERTDetails_input
        {
            public int ProjectID { get; set; }
            public string CurrentDate { get; set; }
            public int UserID { get; set; }
            public string LoginType { get; set; }
            public int TagValue { get; set; }


        }
        public class GetSQERTDetails_output
        {
            public int ProjectID { get; set; }
            public string ProjectName { get; set; }
            public string ReportingDate { get; set; }
            public decimal Scope { get; set; }
            public decimal Quality { get; set; }
            public decimal Effort { get; set; }
            public decimal Risk { get; set; }
            public decimal Time { get; set; }
            public string ExpectedStartDate { get; set; }
            public string ExpectedEndDate { get; set; }

        }

        public class getSQERTRange_output
        {
            public int RangeID { get; set; }
            public int LowerLow { get; set; }
            public int LowerHigh { get; set; }
            public int MiddleLow { get; set; }
            public int MiddleHigh { get; set; }
            public int UpperLow { get; set; }
            public int UpperHigh { get; set; }
        }

        public class getSQERTSection_output
        {
            public float Scope { get; set; }
            public float Quality { get; set; }
            public float Effort { get; set; }
            public float Risk { get; set; }
            public float Time { get; set; }
            public string ScopeDesc { get; set; }
            public string QualityDesc { get; set; }
            public string EffortDesc { get; set; }
            public string RiskDesc { get; set; }
            public string TimeDesc { get; set; }
        }

        public class getSQERTDataInsideWindow_output
        {
            public int SQERTID { get; set; }
            public float Quality { get; set; }
            public float Scope { get; set; }
            public float Effort { get; set; }
            public float Risk { get; set; }
            public float Time { get; set; }
            public string QualityDesc { get; set; }
            public string ScopeDesc { get; set; }
            public string EffortDesc { get; set; }
            public string RiskDesc { get; set; }
            public string TimeDesc { get; set; }
            public bool Locked { get; set; }
            public string GeneralRemarks { get; set; }
            public string Escalations { get; set; }
        }


        public class getEffortTimeRisk_input
        {
            public int ProjectID { get; set; }
            public string CurrentDate { get; set; }
        }

        public class getEffortTimeRisk_output
        {
            public string title { get; set; }
            public decimal titleValue { get; set; }
        }


        public class saveSQERTValue_input
        {
            public int ProjectID { get; set; }
            public string  CurrentDate { get; set; }
            public float Scope { get; set; }
            public float Quality { get; set; }
            public float Effort { get; set; }
            public float Risk { get; set; }
            public float Time { get; set; }
            public string QualityDesc { get; set; }
            public string ScopeDesc { get; set; }
            public string EffortDesc { get; set; }
            public string RiskDesc { get; set; }
            public string TimeDesc { get; set; }
            public int UserID { get; set; }
            public string GeneralRemarks { get; set; }
            public string Escalations { get; set; }
            public string SQERTID { get; set; }
        }
       
        public class showhistory_output
        {
            public int ProjectID { get; set; }
            public int SQERTID { get; set; }
            public string ReportingDate { get; set; }
            public float Scope { get; set; }
            public float Quality { get; set; }           
            public float Effort { get; set; }
            public float Risk { get; set; }
            public float Time { get; set; }
            public string ScopeDesc { get; set; }
            public string QualityDesc { get; set; }         
            public string EffortDesc { get; set; }
            public string RiskDesc { get; set; }
            public string TimeDesc { get; set; }
            public string CreatedBy { get; set; }
            public string CreatedDate { get; set; }
            public bool Locked { get; set; }
            public string LockedDate { get; set; }
            public string GeneralRemarks { get; set; }
            public string Escalations { get; set; }
        }


        public class KeyAchievement_input
        {
            public int ProgramID { get; set; }
            public int ProjectID { get; set; }
            public int CategoryID { get; set; }
            public int BusinessID { get; set; }
            public int OrganizationID { get; set; }
            public string ReportingEndDate { get; set; }
            public int UserID { get; set; }
        }

        public class keyAchievement_output
        {         
            public int CompletedTasks  { get; set; }
            public int TobeCompletedTasks  { get; set; }
            public int SlippingTasks  { get; set; }
            public int TotalPlannedTasks  { get; set; }
            public int CompletedDeliverables { get; set; }
            public int SlippingDeliverables { get; set; }
            public int TobeCompletedDeliverables { get; set; }
            public int TotalPlannedDeliverables { get; set; }


        }


        public class issuedetail_output
        {
            public string Type { get; set; }
            public int totalissues { get; set; }
            public int openissues { get; set; }
            public int closeissues { get; set; }
            public int OTHERSissues  { get; set; }
            public int LessThanFive  { get; set; }
            public int BetweenFiveAndTen { get; set; }
            public int MoreThanTen { get; set; }
            public int OverDueIssues  { get; set; }
            public int ShownToCustomer { get; set; }

        }

        public class individualIssuedetail_output
        {
               public int IssueID { get; set; }
            public string ProjectName { get; set; }
            public string Summary { get; set; }
            public string ReportedDate { get; set; }
            public string Type { get; set; }
            public string SubType { get; set; }
            public string Priority { get; set; }
            public string Severity { get; set; }
            public string Status { get; set; }
            public string DueDate { get; set; }
            public string ReportedBy { get; set; }
        }

        public class individualIssuedetail_input
        {
            public int ProgramID { get; set; }
            public int ProjectID { get; set; }
            public int CategoryID { get; set; }
            public int BusinessID { get; set; }
            public int OrganizationID { get; set; }
            public string ReportingEndDate { get; set; }
            public int UserID { get; set; }
            public int Flag { get; set; }
            public string StrIssueType { get; set; }
        }


        public class baseline_input
        {
            public int ProgramID { get; set; }
            public int ProjectID { get; set; }
            public int ProjectTypID { get; set; }
            public int BusinessGroupID { get; set; }
            public int LocationID { get; set; }
            public string EndDate { get; set; }
            public int UserID { get; set; }


        }

        public class baseline_output
        {
            public string ProjectName { get; set; }
            public string ReasonForRevision { get; set; }
            public string RevisionDate { get; set; }
            public float EstimatedEffort { get; set; }
            public string ExpectedEnddate { get; set; }
        }

        public class EVDetails
        {
            public string ReportingStartDate { get; set; }
            public string ReportingEndDate { get; set; }
            public int ProjectID { get; set; }
            public string ProjectStartDate { get; set; }
            public DataTable EVReportDetails { get; set; }
            public DataTable ACReportDetails { get; set; }
            public DataTable PVandTotalBudgetReportDetails { get; set; }
        }
    }

}