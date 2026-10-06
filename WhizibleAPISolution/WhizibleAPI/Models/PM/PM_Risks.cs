using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_Risks
    {
    }
    public class AccessParameter
    {
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public int ProjectID { get; set; }
        public string LoginType { get; set; }
        public string QueryText { get; set; }
        public string FilterName { get; set; }
        public string CreatedBy { get; set; }
        public int FilterID { get; set; }
    }
    public class RiskNodeAccessList
    {
        public int Add { get; set; }
        public int Delete { get; set; }
        public int Edit { get; set; }
        public int View { get; set; }
    }
    public class GetProjectQuery
    {
        public int ProjectId { get; set; }
        public String ProjectName { get; set; }
    }
    public class GetProjectResponsiblePerson
    {
        public int EmployeeID { get; set; }
        public String UserName { get; set; }
    }
    public class GetSelectedProjectRisks
    {
        public int ProjectRiskID { get; set; }
        public int RiskSourceId { get; set; }
        public bool IsTaskAssigned { get; set; }
        public int RiskID { get; set; }
        public String Description { get; set; }
        public String DateIdentified { get; set; }
        public String RiskCategory { get; set; }
        public String Probability { get; set; }
        public String Weight { get; set; }
        public String Severity { get; set; }
        public String Status { get; set; }
        public String PersonResponsible { get; set; }
        public int PersonResponsibleId { get; set; }
        public int ReviewerId { get; set; }
        public String ReviewNotificationDate { get; set; }        
        public String ShowReport { get; set; }
        public int RiskCategoryID { get; set; }
        public String OriginalPriority { get; set; }
        public String ChangePriority { get; set; }
        public String Notes { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public String RiskSource { get; set; }
        public String UserName { get; set; }
    }
    public class PMParameter
    {
        public int ProjectId { get; set; }
        public int QueryID { get; set; }
        public int RiskCategoryId { get; set; }
        public String Status { get; set; }
        public int EmployeeID { get; set; }
        public String PageNumber { get; set; }
        public String LoginType { get; set; }
        public String Mode { get; set; }
        public String QueryText { get; set; }
        public String Parameter { get; set; }
        public int RiskID { get; set; }
        public int ProjectRiskID { get; set; }
        public int TagID { get; set; }
        public int RoleID { get; set; }
    }
    public class PMReportParameter
    {
        public int ProjectId { get; set; }
        public int RiskID { get; set; }
        public int TagID { get; set; }
        public String ReportFormat { get; set; }
        public String Status { get; set; }
        public int RiskCategoryId { get; set; }
        public String StaticFilter { get; set; }
        public String WhereClause { get; set; }
    }
    public class PMDiscussionsParameter
    {
        public int ProjectId { get; set; }
        public int RiskDiscussionID { get; set; }
        public int RiskID { get; set; }
        public int ParentID { get; set; }
        public int LoginID { get; set; }
        public int ReplyIndex { get; set; }
        public int IsShowToCustomer { get; set; }
        public String DiscussionThread { get; set; }
        public String SubmittedBy { get; set; }
        public String SubmittedDate { get; set; }
        public String LoginType { get; set; }
        public String DiscussionLevel { get; set; }
    }
    public class GetDiscussions
    {
        public int ProjectId { get; set; }
        public int RiskDiscussionID { get; set; }
        public int RiskID { get; set; }
        public int ParentID { get; set; }
        public int LoginID { get; set; }
        public int ReplyIndex { get; set; }
        public int IsShowToCustomer { get; set; }
        public String DiscussionThread { get; set; }
        public String SubmittedBy { get; set; }
        public String SubmittedDate { get; set; }
        public String LoginType { get; set; }
        public int ReplyCount { get; set; }
        public String DiscussionLevel { get; set; }
    }
    public class PMHistoryParameter
    {
        public int ProjectId { get; set; }        
        public int RiskID { get; set; }
        public int TagID { get; set; }
    }
    public class PMPlanParameter
    {
        public int RiskID { get; set; }
        public int PlanID { get; set; }
        public int ProjectID { get; set; }
        public String Flag { get; set; }
    }
    public class PMEarlyWarningsParameter
    {
        public int WarningID { get; set; }
        public int RiskID { get; set; }
        public int ProjectID { get; set; }
        public String Warning { get; set; }
        public String WarningStatus { get; set; }
        public int EarlyWarningFlag { get; set; }
        public String UserName { get; set; }
    }

    public class GetEarlyWarningsDetails
    {
        public int WarningID { get; set; }
        public int RiskID { get; set; }
        public int ProjectID { get; set; }
        public String Warning { get; set; }
        public String WarningStatus { get; set; }
        public int EarlyWarningFlag { get; set; }
        public String UserName { get; set; }
    }
    public class PMDocumentParameter
    {
        public PMDocumentParameter()
        {
            PMParam = new PMParameter();
        }
        //Commented and Modified By RehanC for parameter mismatch issue on 6th April 2023
        //public int ProjectID { get; set; }
        public string ProjectID { get; set; }
        //End of Comment By RehanC for parameter mismatch issue on 6th April 2023
        public string Phase { get; set; }
        public string EstimatedStartDate { get; set; }
        public string EstimatedEndDate { get; set; }
        public float PlannedResources { get; set; }
        public float PercentEfforts { get; set; }
        public bool CurrentPhase { get; set; }
        public int ResponsiblePerson { get; set; }
        public int ordernumber { get; set; }
        public string CreatedBy { get; set; }
        public string EstimatedEfforts { get; set; }
        public int Flag { get; set; }
        public int RiskID { get; set; }
        public PMParameter PMParam { get; set; }
        //Added By RehanC for parameter mismatch issue on 6th April 2023
        public string TagID {get;set;}
        public string RoleID { get; set; }
        //End of Comment By RehanC for parameter mismatch issue on 6th April 2023
    }

    public class RiskDocument
    {
        public RiskDocument()
        {
            PMParam = new PMParameter();
            PMDocumentParam= new PMDocumentParameter();
        }

        public string Description { get; set; }
        public int Category { get; set; }
        public int SubCategory { get; set; }
        public string FileName { get; set; }
        public string UploadedDate { get; set; }
        public int UniqueID { get; set; }
        public string UploadedBy { get; set; }
        public PMParameter PMParam { get; set; }
        public PMDocumentParameter PMDocumentParam { get; set; }
        public string DirectoryName { get; set; }
        public string CreatedDate { get; set; }
        public string LastModifiedDate { get; set; }
        public float FileSize { get; set; }
        public string FileExtension { get; set; }
        //Commented and Modified By RehanC for parameter mismatch issue on 6th April 2023
        //public int SubCategoryID { get; set; }
        public string SubCategoryName { get; set; }
        public string ProjectID { get; set; }
        //End of Comment By RehanC for parameter mismatch issue on 6th April 2023
        public string CodeTemplate { get; set; }
        public string CategoryName { get; set; }

    }
    public class GetRiskMatrixDetails
    {
        public int Probability { get; set; }
        public int Impact { get; set; }
        public int RiskCount { get; set; }
    }
    public class PMModuleParameter
    {
        public int ProjectID { get; set; }
        public int ModuleID { get; set; }
        public String Mode { get; set; }
        public int TaskID { get; set; }
    }
    public class GetModuleDetails
    {
        public int ModuleID { get; set; }
        public String ModuleName { get; set; }
    }

    public class PMSubProjectParameter
    {
        public int ProjectID { get; set; }
        public int SubProjectID { get; set; }
        public String Mode { get; set; }
        public int TaskID { get; set; }
    }
    public class GetSubProjectDetails
    {
        public int SubProjectID { get; set; }
        public String SubProjectName { get; set; }
    }
    public class PMMilestoneParameter
    {
        public int ProjectID { get; set; }        
        public String Mode { get; set; }
        public int TaskID { get; set; }
    }
    public class GetMilestoneDetails
    {
        public int MilestoneID { get; set; }
        public String Milestone { get; set; }
    }

    public class PMChangeRequestParameter
    {
        public int ProjectID { get; set; }
    }
    public class GetChangeRequestDetails
    {
        public int ChangeRequestID { get; set; }
        public String ChangeRequestSummary { get; set; }
    }

    public class PMUserStoryParameter
    {
        public int ProjectID { get; set; }
    }
    public class GetUserStoryDetails
    {
        public int UserStoryID { get; set; }
        public String UserStoryName { get; set; }
    }
    public class PMFeatureParameter
    {
        public int ProjectFeatureID { get; set; }
        public int ProjectID { get; set; }
    }
    public class GetFeatureDetails
    {
        public int ProjectFeatureID { get; set; }
        public String FeatureName { get; set; }
    }    
    public class PMContingencyPlanParameter
    {
        public int RiskID { get; set; }
        public int ProjectID { get; set; }
        public String ContingencyPlan { get; set; }
        public String Responsibility { get; set; }
        public String TaskType { get; set; }
        public String DateOfPlan { get; set; }
        public int ExpectedDuration { get; set; }
        public String ExpectedWork { get; set; }
        public String UserName { get; set; }
        public int ContingencyPlanID { get; set; }
    }
    public class PMMitigationPlanParameter
    {
        public int RiskID { get; set; }
        public int ProjectID { get; set; }
        public String Action { get; set; }
        public String Responsibility { get; set; }
        public String TaskType { get; set; }
        public String DateOfPlan { get; set; }
        public int ExpectedDuration { get; set; }
        public String ExpectedWork { get; set; }
        public String UserName { get; set; }
        public int MitigationPlanID { get; set; }
    }
    public class GetPlanDetails
    {
        public int RiskID { get; set; }
        public int ContingencyPlanID { get; set; }
        public int ProjectID { get; set; }
        public String ContingencyPlan { get; set; }
        public String Responsibility { get; set; }
        public String TaskType { get; set; }
        public String DateOfPlan { get; set; }
        public String AssignTask { get; set; }
        public int TaskID { get; set; }
        public String EmployeeName { get; set; }
        public int ExpectedDuration { get; set; }
        public String ExpectedWork { get; set; }
    }
    public class GetMitigationPlanDetails
    {
        public int RiskID { get; set; }
        public int MitigationPlanID { get; set; }
        public int ProjectID { get; set; }
        public String Action { get; set; }
        public String Responsibility { get; set; }
        public String TaskType { get; set; }
        public String DateOfPlan { get; set; }
        public String AssignTask { get; set; }
        public int TaskID { get; set; }
        public String EmployeeName { get; set; }
        public int ExpectedDuration { get; set; }
        public String ExpectedWork { get; set; }
    }
    public class PMTaskTypeParameter
    {
        public int GetDefaultTaskType { get; set; }
        public int ProjectID { get; set; }
        public int RiskID { get; set; }
    }
    public class PMTaskTypeDetails
    {
        public int TaskTypeID { get; set; }
        public String TaskType { get; set; }
    }
    public class GetCompanyDetails
    {
        public int ID { get; set; }
        public int RestrictByMinHours { get; set; }
        public Double MinHoursForDAEntry { get; set; }
    }
        public class GetHistoryDetails
    {
        public String FieldName { get; set; }
        public String Date { get; set; }
        public String Value { get; set; }
        public String NewValue { get; set; }
        public String ModifiedBy { get; set; }
        public String Details { get; set; }
    }
    public class PMFilterParameter
    {
        public int ProjectId { get; set; }
        public int RiskID { get; set; }
        public int RiskCategoryId { get; set; }
        public String Status { get; set; }
        public String Flag { get; set; }
        public int ProjectRiskID { get; set; }
        public String Description { get; set; }
        public String Notes { get; set; }
        public String DateIdentified { get; set; }
        public String OriginalPriority { get; set; }
        public String ChangePriority { get; set; }
        public String Probability { get; set; }
        public String Weight { get; set; }
        public String Severity { get; set; }
        public int RiskSourceId { get; set; }
        public String PersonResponsible { get; set; }
        public String StatusText { get; set; }
        public String ProjectRiskWhereClause { get; set; }
    }
    public class ApplyFilterParameter
    {
        public int TagID { get; set; }
        public int ProjectID { get; set; }       
        public int EmployeeID { get; set; }
        public String FilterName { get; set; }
        public String LoginType { get; set; }
        public String CreatedBy { get; set; }
        public String WhereClause { get; set; }
        public String Flag { get; set; }
        public int FilterID { get; set; }
    }
    public class MyFilterParameter
    {
        public int FilterId { get; set; }
        public String FilterName { get; set; }
        public String SetDefault { get; set; }
        public String QueryText { get; set; }
        public int EmployeeID { get; set; }
    }
    public class getProjectImpactStatus
    {
        public int ProbabilityStatus { get; set; }
        public int WeightStatus { get; set; }
        public int SeverityStatus { get; set; }
    }
}