using System;

namespace WhizibleAPI.Models.PM
{
    public class PM_TrainingPlan
    {
        public int TagID { get; set; }
        public int ProjectID { get; set; }
        public int ToolID { get; set; }
        public float TrainingDuration { get; set; }
        public int DayFormat { get; set; }
        public string TrainingArea { get; set; }
        public string WaiverCriteria { get; set; }
        public bool IsSubTagID { get; set; }
        public int UniqueID { get; set; }
        public string Result { get; set; }
        public bool Completed { get; set; }
        public string Hours { get; set; }
        public int EmployeeId { get; set; }
        public int ResourceID { get; set; }

        // For Filter
        public int UserId { get; set; }
        public string WhereClause { get; set; }
        public char LoginType { get; set; }
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string TrainingDurationF { get; set; }

        // For Convert to Task
        public int IsActive { get; set; }
        public string ModuleName { get; set; }
        public int BaselineDuration { get; set; }
        public int Duration { get; set; }
        public string CreatedDate { get; set; }
        public int IsDeferredTask { get; set; }

        // For Module Dropdown
        public char ModuleMode { get; set; }
        public int ModuleTaskID { get; set; }
        public int ModuleProjectID { get; set; }

        // For Milestone Dropdown
        public int MilestoneProjectID { get; set; }
        public char MilestoneMode { get; set; }
        public int MilestoneTaskID { get; set; }

        // For Sub-Project Dropdown
        public char SubProjectMode { get; set; }
        public int SubProjectTaskID { get; set; }
        public int? UserStoryID { get; set; }

        public int? TaskID { get; set; }
        public string TaskName { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public float? Work { get; set; }
        public string WhichTask { get; set; }
        public int BillableYN { get; set; }
        public string TaskNotes { get; set; }
        public string Flag { get; set; }


        public string TaskType { get; set; }
        public DateTime? BaselineStart { get; set; }
        public DateTime? BaselineEnd { get; set; }
        public float? BaselineWork { get; set; }
        public string Priority { get; set; }
        public int? PhaseID { get; set; }
        public string Phase { get; set; }
        public int? ModuleID { get; set; }
        public string Module { get; set; }
        public int SubProjectID { get; set; }
        public string SubProject { get; set; }
        public int? MilestoneID { get; set; }
        public string Milestone { get; set; }
        public int OtherTaskID { get; set; }
        public int ChangeRequestID { get; set; }
        public int ProjectFeatureID { get; set; }
        public int ProjectEstimationTypeID { get; set; }
        public int DeliverableID { get; set; }
        public int MitigationPlanID { get; set; }
        public int TrainingResourceID { get; set; }
        public int TrainingID { get; set; }
        public bool Void { get; set; }
        public bool OnHold { get; set; }
        public string CreatedBy { get; set; }
        public int IsUserStoryTask { get; set; }
        public int? StoryPoints { get; set; }
        public string DeliverableStageID { get; set; }
        public int ParentTaskID { get; set; }

        public int ScheduleID { get; set; }
        public int ScheduleTypeID { get; set; }

        public string TaskDataJSON { get; set; }

    }

        public class CustomFieldModel
        {
            public int UserID { get; set; }
            public string LoginType { get; set; }
            public int RoleId { get; set; }
            public int IsActive { get; set; }
            public string strEntityName { get; set; }
            public int Type { get; set; }
            public string EntityName { get; set; }
            public object CustomValidation { get; set; }
            public int TaskID { get; set; }
            public int ProjectID { get; set; }
            public int TagID { get; set; }
            public string CustomFieldName { get; set; }
            public string FieldID { get; set; }
            public string FieldName { get; set; }
            public string strTaskType { get; set; }
   
    }

    internal class ValidationData_AssignedTask
        {
            public string ValidationID { get; internal set; }
            public string ValidationDescription { get; internal set; }
            public string ValidationMessage { get; internal set; }
            public string FieldID { get; internal set; }
            public string FieldName { get; internal set; }
            public string CreatedBy { get; internal set; }
            public string CreatedDate { get; internal set; }
            public int OrderNumber { get; internal set; }
            public int IsComparisonRule { get; internal set; }
        }


        public class CustomFieldPloat_AssignedTask
        {
            public int UserID { get; set; }
            public string LoginType { get; set; }
            public int RoleID { get; set; }
            public int IsActive { get; set; }
            public int UniqueID { get; set; }
            public int ProjectID { get; set; }
            public string EntityName { get; set; }
            public int Type { get; set; }
            public string UserGivenCaption { get; set; }
            public string ValidationRules { get; set; }
            public string DatabaseFieldName { get; set; }
            public int RowNumber { get; set; }
            public int ColumnNumber { get; set; }
            public string IsCustomFieldAssigned { get; set; }
            public string DefaultValue { get; set; }
            public string DefaultType { get; set; }
            public string ControlHeight { get; set; }
            public string ControlWidth { get; set; }
            public string MaxLength { get; set; }
            public string MaxValue { get; set; }
            public string MinValue { get; set; }
        }

}