using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_wbs_card
    {
        public int TaskID { get; set; }
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string ActualWork { get; set; }
        public string ActualPercentComplete { get; set; }
        public string ActualEndDate { get; set; }
        public string ActualStartDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string DaysRemaining { get; set; }
        public string Priority { get; set; }
        public string IsActive { get; set; }
        public bool IsTaskComplete { get; set; }
        public string SubTaskTypes { get; set; }
        public string TaskName { get; set; }
        public string StageID { get; set; }
        public string OrderNo { get; set; }
        public string OrderNoString { get; set; }
        public string StageName { get; set; }
        public string WhichTask { get; set; }
        public string MasterStageID { get; set; }
        public string DragStageID { get; set; }
        public string WorkInHours { get; set; }
        public string ImpactedStageID { get; set; }
        public string LoginID { get; set; }
        public string TaskNotes { get; set; }
        public string ReportFormat { get; set; }
        public string RoleAccess { get; set; }

        public string IsTaskBillable { get; set; }
        public int DeliverableID { get; set; }
        public int PhaseID { get; set; }
        public int ModuleId { get; set; }
        public int SubProjectID { get; set; }
        public int MileStoneId { get; set; }
        public int ChangeRequestID { get; set; }
        public int ProjectFeatureID { get; set; }
        public int ProjectEstimationTypeID { get; set; }
        public int NextGen_ReleaseID { get; set; }
        public int NextGen_IterationID { get; set; }
        public int UserStoryID { get; set; }
        public int taskOrder { get; set; }
        public string TaskTypeName { get; set; }

        public string Phase { get; set; }
        public string Module { get; set; } 
        public string SubProject { get; set; }
        public string MileStone { get; set; }

        public int OtherTaskID { get; set; }
        public int MitigationPlanID { get; set; }
        public int TrainingResourceID { get; set; }
        public int TrainingID { get; set; }
        public int Void { get; set; }
        public int OnHold { get; set; }
        public string CreatedBy { get; set; }
        public int IsUserStoryTask { get; set; }
        public int StoryPoints { get; set; }
        public string DeliverableStageID { get; set; }
        public int ParentTaskID { get; set; }
        public int TaskTypeID { get; set; }
		public string IsVoid { get; set; }
    }

    public class PM_wbs_card_parameters
    {


        public string TaskID { get; set; }
        public string ProjectID { get; set; }
        //added by Vishal Mahajan  09-01-2020
        public int UniqueID { get; set; }
        public string RoleID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public string LoginType { get; set; }
        public string ProjectName { get; set; }
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string ActualWork { get; set; }
        public string ActualPercentComplete { get; set; }
        public string ActualEndDate { get; set; }
        public string ActualStartDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string DaysRemaining { get; set; }
        public string Priority { get; set; }
        public string IsActive { get; set; }
        public string IsTaskComplete { get; set; }
        public string SubTaskTypes { get; set; }
        public string TaskName { get; set; }
        public string StageID { get; set; }
        public string OrderNo { get; set; }
        public string OrderNoString { get; set; }
        public string StageName { get; set; }
        public string WhichTask { get; set; }
        public string MasterStageID { get; set; }
        public string DragStageID { get; set; }
        public string WorkInHours { get; set; }
        public string ImpactedStageID { get; set; }
        public string LoginID { get; set; }
        public string TaskNotes { get; set; }
        public string RoleAccess { get; set; }
        public int TaskTypeID { get; set; }
		public int UserStoryID { get; set; }
        //Added By Dipali v On 25th Jan 2020 For Flag
        public int TaskFlagID { get; set; }
        public string FlagDate { get; set; }
        public int TaskUserID { get; set; }
        //public int IsActive { get; set; }
        //End of Added By Dipali v On 25th Jan 2020 For Flag
    }

    public class ScrumeStages
    {
        public string StageID { get; set; }
        public string StageName { get; set; }
        public string OrderNO { get; set; }
        public string IsCustom { get; set; }
        public string ProjectID { get; set; }
        public string ColorID { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public string ModifiedDate { get; set; }
        public string Icon { get; set; }
        public string MasterStageID { get; set; }

    }

    public class RoleAccess
    {
        public string RoleID { get; set; }
        public string TagID { get; set; }
        public string AddRole { get; set; }
        public string EditRole { get; set; }
        public string DeleteRole { get; set; }
        public string ViewRole { get; set; }
    }

    public class TokenGeneration
    {
        public string tagId { get; set; }
        public string projectID { get; set; }
        public string userId { get; set; }
        public string Token { get; set; }
    }

    public class AssignTaskInBulk
    {
        public string userId { get; set; }
        public string projectId { get; set; }
        public string ExcelFeildName { get; set; }
        public string WBSFieldName { get; set; }
        public string Stage { get; set; }
        public string FieldOrder { get; set; }
    }

    public class FileUploadParameters
    {
        //public string FileName { get; set; }
        //public string FilePath { get; set; }
        [JsonProperty(PropertyName = "Task Name")]
        public string TaskName { get; set; }
        [JsonProperty(PropertyName = "Task Notes")]
        public string TaskNotes { get; set; }
        public string Resources { get; set; }
		//Added By Dipali V On 26th Feb 2020 For Get Count of Excel column
        public string ExcelNoColumn { get; set; }
        //End of Added By Dipali V On 26th Feb 2020 For Get Count of Excel column
        [JsonProperty(PropertyName = "Estimation Type")]
        public string EstimationType { get; set; }
        public string Work { get; set; }

        [JsonProperty(PropertyName = "Start Date")]
        public string StartDate { get; set; }

        [JsonProperty(PropertyName = "End Date")]
        public string EndDate { get; set; }
        public string Priority { get; set; }


        [JsonProperty(PropertyName = "Task Type")]
        public string TaskType { get; set; }


		[JsonProperty(PropertyName = "Sub Task Type")]
        public string SubTaskType { get; set; }
        [JsonProperty(PropertyName = "Sub Project")]
        public string SubProject { get; set; }


        [JsonProperty(PropertyName = "Change Request")]
        public string ChangeRequest { get; set; }
        public string Release { get; set; }

        [JsonProperty(PropertyName = "Story Point")]
        public string StoryPoint { get; set; }
        public string Feature { get; set; }
        //Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21827
        //public string Bilable { get; set; }
        public string Billable { get; set; }
        //End of Commented and added by Chetan M on 10th Feb 2020 for IssueID = 21827
        public string Deliverable { get; set; }
        public string Module { get; set; }
        public string Milestone { get; set; }


        [JsonProperty(PropertyName = "User Story")]
        public string UserStory { get; set; }
        public string Sprint { get; set; }
        public string Phase { get; set; }

        [JsonProperty(PropertyName = "Error Message")]
        public string ErrorMessage { get; set; }

        [JsonProperty(PropertyName = "Select")]
        public string Select { get; set; }
        //public string ValidRecords { get; set; }
        //public string InvalidRecords { get; set; }
    }
    public class TaskUploadViewModel
    {
        public List<FileUploadParameters> lisFileUploadParameters = new List<FileUploadParameters>();
        public string ProjectID { get; set; }
        public string CreatedBy { get; set; }
    }

    public class ExcelDictionary
    {
        public string ExcelFeildName { get; set; }
        public string WBSFieldName { get; set; }
        public int? CheckOrder { get; set; }
    }

    public class ProjectSettings
    {
        public string ProjectID { get; set; }
        public bool isAgileProject { get; set; }
        public bool ShowPhaseInAt { get; set; }
        public bool PhaseMandatoryinAT { get; set; }
        public bool ShowModuleInAt { get; set; }
        public bool ModuleMandatoryinAT { get; set; }
        public bool ShowSubProjectInAT { get; set; }
        public bool SubProjectMandatoryInAT { get; set; }
        public bool ShowMilestoneInAT { get; set; }
        public bool MilestoneMandatoryInAT { get; set; }
        public bool ShowChangeRequestInAT { get; set; }
        public bool ChangeRequestMandatoryInAT { get; set; }
        public bool ShowFeatureInAT { get; set; }
        public bool FeatureMandatoryInAT { get; set; }
        public bool ShowEstimationTypeInAT { get; set; }
        public bool EstimationTypeMandatoryInAT { get; set; }
    }

    //added by Vishal M 08-01-2020
    public class PM_WBS_Task 
    {
        public int TaskID { get; set; }
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string ActualWork { get; set; }
        public string ActualPercentComplete { get; set; }
        public string ActualEndDate { get; set; }
        public string ActualStartDate { get; set; }
        public string TaskStartDate { get; set; }
        public string TaskEndDate { get; set; }
        public string BaselineEndDate { get; set; }
        public string BaselineStartDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string DaysRemaining { get; set; }
        public string Priority { get; set; }
        public string IsActive { get; set; }
        public bool IsTaskComplete { get; set; }
        public string SubTaskTypes { get; set; }
        public string TaskName { get; set; }
        public string StageID { get; set; }
        public string OrderNo { get; set; }
        public string OrderNoString { get; set; }
        public string StageName { get; set; }
        public string WhichTask { get; set; }
        public string MasterStageID { get; set; }
        public string DragStageID { get; set; }
        public string WorkInHours { get; set; }
        public string ImpactedStageID { get; set; }
        public string LoginID { get; set; }
        public string TaskNotes { get; set; }
        public string ReportFormat { get; set; }
        public string RoleAccess { get; set; }
        public int IsUserStoryTask { get; set; }
        public bool BillableYN { get; set; }
        public string ModuleName { get; set; }
        public string Duration { get; set; }
        public string WorkHourMinute { get; set; }
        public string ActualWorkHourMinute { get; set; }
        public string BaselineWorkHourMinute { get; set; }
        public string BaselineDuration { get; set; }
        public string ActualDuration { get; set; }
        public string BaselineWork { get; set; }

        public int LocationID { get; set; }
        public int DepartmentID { get; set; }
        public int GroupID { get; set; }
        public int DeliverableID { get; set; }
        public int DeliverableTypeID { get; set; }
        public int SystemID { get; set; }
        public int MPPTaskID { get; set; }
        public string MPPTask { get; set; }
        public int TaskTypeID { get; set; }
        public bool TaskOnHold { get; set; } 
        public int WBSID { get; set; }
        public string Phase { get; set; }
        public int PhaseID { get; set; }
        public string Module { get; set; }
        public int ModuleID { get; set; }
        public string SubProject { get; set; }
        public int SubProjectID { get; set; }
        public string Milestone { get; set; }
        public int MilestoneID { get; set; }
        public int ChangeRequestID { get; set; }
        public int ProjectFeatureID { get; set; }
        public int ProjectEstimationTypeID { get; set; }
        public int IsDeferredTask { get; set; }
        public bool RestrictByMinHours { get; set; }

        public int OtherTaskID { get; set; }
        public int MitigationPlanID { get; set; }
        public int TrainingResourceID { get; set; }
        public int TrainingID { get; set; }
        public int Void { get; set; }
        public string DeliverableStageID { get; set; }
        public int ParentTaskID { get; set; }

        public string ProjectStartDate { get; set; }
        public string ProjectEndDate { get; set; }
        public bool HaveSubTaskTypes { get; set; }
        public bool ApplyEffortDistribution { get; set; }
        public double HoursPerDay { get; set; }
        public long WeekDays { get; set; }
        public double TotalAllocatedTaskLCE { get; set; }
        public double TotalLCE { get; set; }

        public string ResourceStartDate { get; set; }
        public string ResourceEndDate { get; set; }
        public int ResourceValidation { get; set; }
		//Added By Dipali V On 10th Feb 2020 For US Of Task
        public int UserStoryID { get; set; }
        public int StoryPoint { get; set; }//Added By Dipali V On 11th Feb 2020 For get StoryPoint value
        //End of Added By Dipali V On 10th Feb 2020 For US Of Task
    }

    public class Deliverables
    {
        public int ScheduleID { get; set; }
        public string Title { get; set; }

    }

    public class Modules
    {
        public int ModuleID { get; set; }
        public string ModuleName { get; set; }

    }

    public class SubProjects
    {
        public int SubProjectId { get; set; }
        public string SubProjectName { get; set; }

    }
    public class Milestones
    { 
        public int MilestoneID { get; set; }
        public string Milestone { get; set; }

    }

    public class Resources
    {
        public int EmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public ResourcesExpectedDate ResourcesExpectedDates { get; set; }  
    }

    public class ResourcesExpectedDate
    {
        public int EmployeeId { get; set; }
        public string ExpectedStartDate { get; set; }
        public string ExpectedEndDate { get; set; }
    }

    public class Project_Phases
    {
        public int ProjectPhaseID { get; set; }
        public string Phase { get; set; }

    }

    public class UserStory 
    {
        public int UserStoryID { get; set; }
        public String UserStoryName { get; set; }
    }

    public class ModuleParameter
    {
        public int ProjectID { get; set; }
        public int ModuleID { get; set; }
        public String Mode { get; set; }
        public int TaskID { get; set; }
    }

    public class SubProjectParameter
    {
        public int ProjectID { get; set; }
        public int SubProjectID { get; set; }
        public String Mode { get; set; }
        public int TaskID { get; set; }
    }

    public class MilestoneParameter
    {
        public int ProjectID { get; set; }
        public String Mode { get; set; }
        public int TaskID { get; set; }
    }

    public class EstimationType
    {
        public int ProjectEstimationTypeID { get; set; }
        public string EstimationTypeName { get; set; }
    }

    public class Feature
    {
        public int ProjectFeatureID { get; set; }
        public string FeatureName { get; set; }
    }

    public class Document
    {
        public Document()
        {
            Parameters = new PM_wbs_card_parameters();
        }

        public string Description { get; set; }
        public string Category { get; set; }
        public string SubCategory { get; set; }
        public string FileName { get; set; }
        public string UploadedDate { get; set; }
        public int UniqueID { get; set; }
        public string UploadedBy { get; set; }
        public PM_wbs_card_parameters Parameters { get; set; }
        public string DirectoryName { get; set; }
        public string CreatedDate { get; set; }
        public string LastModifiedDate { get; set; }
        public float FileSize { get; set; }
        public string FileExtension { get; set; }
        public string CodeTemplate { get; set; }
        public string CategoryName { get; set; }
        public string SubCategoryName { get; set; }
        public int ProjectID { get; set; }


    }

    public class PM_WBS_TaskConfigure
    { 
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string LoginID { get; set; }
        public string ProjectStartDate { get; set; }
        public string ProjectEndDate { get; set; }
        public bool HaveSubTaskTypes { get; set; }
        public bool ApplyEffortDistribution { get; set; }
        public double HoursPerDay { get; set; }
        public long WeekDays { get; set; }
        public double TotalAllocatedTaskLCE { get; set; }
        public double TotalLCE { get; set; }

        public int ResourceValidation { get; set; }
        public bool RestrictByMinHours { get; set; }
    }

	//add by omkar 28/01/2020
    public class FillProjectParameters
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }
    //end of add by omkar 28/01/2020
}