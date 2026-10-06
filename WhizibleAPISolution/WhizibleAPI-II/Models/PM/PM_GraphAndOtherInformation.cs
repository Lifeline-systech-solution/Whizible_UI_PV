using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_GraphAndOtherInformation
    {
        public List<Project_Information_Output> ProjectInformation { get; set; }
        public List<Active_Resources_output> ActiveResources { get; set; }
        public List<Phase_Details_output> PhaseDetails { get; set; }
        public List<Module_Details_output> ModuleDetails { get; set; }
        public List<SubProject_Details_output> SubProjectDetails { get; set; }
        public List<Milestone_Details_output> MilestoneDetails { get; set; }
        public List<Planned_vs_Completed_Task_output> PlannedvsCompletedDetail { get; set; }
        public List<Open_Issue_for_Project_output> OpenIssueDetail { get; set; }
        public List<Task_Status_by_Resource_output> TaskStatusDetail { get; set; }
        public List<Cumulative_vs_Completed_Task_output> CumulativevsCompletedDetail { get; set; }
    }
    public class Project_Information_input
    {
        public int ProjectID { get; set; }
    }

    public class Project_Information_Output
    {
        public string ProjectName { get; set; }
        public string Practice { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }


    public class Planned_vs_Completed_Task_output
    {
        public string Tasks { get; set; }
        public int Total { get; set; }


    }
    public class Open_Issue_for_Project_output
    {
        public string type { get; set; }
        public int Count { get; set; }

    }

    public class Task_Status_by_Resource_output
    {
        public string ResourceName { get; set; }
        public int TasksCompleted { get; set; }
        public int TasksInProgress { get; set; }
        public int TasksNotYetStarted { get; set; }

    }

    public class Cumulative_vs_Completed_Task_output
    {
        public string Months { get; set; }
        public int Cumulative { get; set; }
        public int TasksComplete { get; set; }

    }
    public class Active_Resources_output
    {
        public string Resource { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string WorkHrs { get; set; }
        public string ActualWorkHrs { get; set; }
    }

    public class Phase_Details_output
    {
        public string RequirementAnalysis { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string WorkHrs { get; set; }
        public string ActualWorkHrs { get; set; }
        public string WorkRatio { get; set; }
        public string PlannedTasks { get; set; }
        public string CompletedTasks { get; set; }
        public string TaskRatio { get; set; }

    }

    public class Module_Details_output
    {
        public string Module { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string WorkHrs { get; set; }
        public string ActualWorkHrs { get; set; }
        public string WorkRatio { get; set; }
        public string PlannedTasks { get; set; }
        public string CompletedTasks { get; set; }
        public string TaskRatio { get; set; }
    }

    public class SubProject_Details_output
    {
        public string SubProject { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string WorkHrs { get; set; }
        public string ActualWorkHrs { get; set; }
        public string WorkRatio { get; set; }
        public string PlannedTasks { get; set; }
        public string CompletedTasks { get; set; }
        public string TaskRatio { get; set; }
    }
    public class Milestone_Details_output
    {
        public string Milestone { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string WorkHrs { get; set; }
        public string ActualWorkHrs { get; set; }
        public string WorkRatio { get; set; }
        public string PlannedTasks { get; set; }
        public string CompletedTasks { get; set; }
        public string TaskRatio { get; set; }


    }
}