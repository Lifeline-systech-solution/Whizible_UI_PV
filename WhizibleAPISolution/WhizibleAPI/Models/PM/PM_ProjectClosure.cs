using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_ProjectClosure
    {
        public List<Post_Skills> Post_Skill { get; set; }
        public List<SkillAllocateToProject> SkillAllocateToProject { get; set; }
        public List<PostSkillExperiance> PostSkillExperiance { get; set; }
    }
    public class Post_Skills
    {
        //public string ToolID { get; set; }
        public string Description { get; set; }
        public string loggedPerson { get; set; }
        public int IsSkill { get; set; }
        //public string CreatedDate { get; set; }
    }
    public class SkillAllocateToProject
    {
        public string ProjectID { get; set; }
        public string ParameterId { get; set; }
        public string Version { get; set; }
        public string PercentageUtilization { get; set; }
        public string IsCustomerSupplied { get; set; }
        public string IsCritical { get; set; }
        public string IsProcured { get; set; }
        public string BriefDescription { get; set; }
        public string NumberOfCopies { get; set; }
        public string PlannedInDate { get; set; }
        public string PlannedOutDate { get; set; }
        public string ToolIDS { get; set; }
        public string CreatedBy { get; set; }
    }
    public class PostSkillExperiance
    {
        public int ProjectID { get; set; }
        public int EmployeeID                {get;set;}
        public int ToolID                    {get;set;}
        public int YearsOfExperience         {get;set;}
        public int MonthsOfExperience        {get;set;}
        public string YearsExperience { get; set; }
        public string ActualEndate { get; set; }
        public string MonthsExperience { get; set; }
        public bool blnAddToExistingExperience{get;set;}
        public int blnAddNewSkill { get; set; }
        public int IsProjectOver { get; set; }
        

    }

    public class CheckListClass
    {
        public int ProjectCheckListId { get; set; }
        public int ContextID { get; set; }
        public int ProjectID { get; set; }
        public string RespondedBy { get; set; }
        public string ResponseID { get; set; }
        public string Remarks { get; set; }
        public string ActualEndate { get; set; }
        public string LoggedaPersonEmailID { get; set; }
        public string LoggedPersonID { get; set; }
    }

    public class CloseProjectCLass
    {
        public int ProjectID { get; set; }
        public string LoggedaPersonEmailID { get; set; }
    }

    public class ProjectOverViewData
    {
        //public int ProjectId { get; set; }
        public DataTable ProjectOverview { get; set; }
        public DataTable ProjectSize { get; set; }
        public DataTable ProjectPlannedVsActual { get; set; }
        public string SumOfWork { get; set; }
        public string SumOfActualWork { get; set; }
        public bool CloseProject { get; set; }
        public DataTable ProjectReviewStatistics { get; set; }
        public string SumOfReivew { get; set; }
        public string SumOfReviewEfforts { get; set; }
        public int SumOfDefects { get; set; }
    }

    public class ProjectData
    {
        public string StartDate { get; set; }
        public int m_intYearsToBeShown { get; set; }
        public int m_intMonthsToBeShown { get; set; }
        public DataTable TasksForCompletion { get; set; }
        public DataTable TasksForVoiding { get; set; }
        public DataTable TasksForMPPing { get; set; }
    }
    public class ProjectCloser
    {
       public ProjectCloser()
        {
            Taskids = new List<string>();
        }
        public int ProjectId { get; set; }
        public string LocationType { get; set; }
        public DataTable ProjectClosureCount { get; set; }
        public DataTable ProjectClosureDetails { get; set; }
        public List<string> Taskids { get; set; }
        // Added By Dipali V On 20th May 2026 - Purpose:-Comma-separated task IDs for batch close/void API (ProjectTaskCloseOrVoid); used when 100+ tasks sent from PM_Project_Closure.aspx
        public string TaskIdsCsv { get; set; }
    }
    
     public class LessonLearnt
    {
        public int ProjectId { get; set; }
        public int LessonId  { get; set; }
        public int DocumentID  { get; set; }
        public int ProjectID { get; set; }
        public string Description { get; set; }
        public string ProblemType { get; set; }
        public string Solution { get; set; }
        public string PreventiveAction { get; set; }
        public string CreatedBy { get; set; }
        public string LoginType { get; set; }
        public int PTKM { get; set; }
        public int UserID { get; set; }
        public DataTable LessonLearntData { get; set; }
        public DataTable LessonLearntDocument { get; set; }
        public string[] deletedFileCnt { get; set; }

    }
    public class TokenParameter
    {
        public int TagID { get; set; }
        public int DocumnetID { get; set; }
        public int LessonID { get; set; }
        public int ProjectID { get; set; }
    }


    public class ReOpenProjectParameter {
        public int ProjectId { get; set; }
        public string Comment { get; set; }
        public string UserId { get; set; }
    }
    public class PM_ClosureReportParameter
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
}