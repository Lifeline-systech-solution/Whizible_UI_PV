using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Timesheet
{
    public class Timesheet
    {
        public TaskCount TaskCount { get; set; }
        public List<TimesheetList> timesheetLists { get; set; }
        public List<ProjectFilter> ProjectFilterLists { get; set; }
        public Filters filters { get; set; }
        public List<TaskCategoryFilter> TaskCategoryFilterLists { get; set; }
        public List<TaskStatusFilter> TaskStatusFilterLists { get; set; }
        public List<TaskPriorityFilter> TaskPriorityFilterLists { get; set; }
        public List<BillableFilter> BillableFilterLists { get; set; }
        public List<WeekTotal> WeekTotalLists { get; set; }
        public List<HeaderColumn> headerColumns { get; set; }
        public Access Access { get; set; }
        public List<VTWeek_MV> WeekDays { get; set; }
    }
    public class TaskCount
    {
        public int CriticalTask { get; set; }
        public int PendingTask { get; set; }
        public int SlippageTask { get; set; }
        public int ScheduledTask { get; set; }
    }
    public class ProjectFilter
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }
    public class TaskTypeFilter
    {
        public int TaskTypeID { get; set; }
        public string TaskType { get; set; }
    }
    public class TaskCategoryFilter
    {
        public string ID { get; set; }
        public string Value { get; set; }
    }
    public class TaskStatusFilter
    {
        public int StatusID { get; set; }
        public string Status { get; set; }
    }
    public class TaskPriorityFilter
    {
        public int PriorityID { get; set; }
        public string Priority { get; set; }
    }
    public class BillableFilter
    {
        public int ID { get; set; }
        public string Value { get; set; }
    }
    public class PhaseFilter
    {
        public int PhaseID { get; set; }
        public string Phase { get; set; }
    }
    public class MileStoneFilter
    {
        public int MileStoneId { get; set; }
        public string MileStone { get; set; }
    }
    public class DeliverableFilter
    {
        public int DeliverableID { get; set; }
        public string Title { get; set; }
    }
    public class SubProjectFilter
    {
        public int SubProjectId { get; set; }
        public string SubProjectName { get; set; }
    }
    public class ModuleFilter
    {
        public int ModuleId { get; set; }
        public string ModuleName { get; set; }
    }
    public class SubTaskList
    {
        public int SubTaskTypeID { get; set; }
        public string SubTaskType { get; set; }
        public string TaskName { get; set; }
        public string ProjectName { get; set; }
    }
    public class ScheduleTSEntry
    {
        public int TaskID { get; set; }
        public float PostWorkHrs { get; set; }
        public string StartDate { get; set; }
        public string PostEndDate { get; set; }
        public string ProjectName { get; set; }
        public string TaskName { get; set; }
        public string SubTaskType { get; set; }
        public float work { get; set; }
        public int IsTaskComplete { get; set; }
    }
    public class AdditionalRequestTime
    {
        public int TaskID { get; set; }
        public int ProjectID { get; set; }
        public string StartDate { get; set; }
        public string ProjectName { get; set; }
        public string TaskName { get; set; }
        public string SubTaskType { get; set; }
        public float work { get; set; }
        public float ETC { get; set; }
        public string Reason { get; set; }
        public float ActualWork { get; set; }
    }
    public class TimesheetList
    {
        public int TaskID { get; set; }
        public string TaskName { get; set; }
        public string SubTaskType { get; set; }
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string Description { get; set; }
        public int MonDAID { get; set; }
        public int TueDAID { get; set; }
        public int WedDAID { get; set; }
        public int ThuDAID { get; set; }
        public int FriDAID { get; set; }
        public int SatDAID { get; set; }
        public int SunDAID { get; set; }
        //Commented & Added By Dipali V On 21st Oct 2021 For Conversion & Get Exact Hours
        //public float Mon { get; set; }
        //public float Tue { get; set; }
        //public float Wed { get; set; }
        //public float Thu { get; set; }
        //public float Fri { get; set; }
        //public float Sat { get; set; }
        //public float Sun { get; set; }

        public string Mon { get; set; }
        public string Tue { get; set; }
        public string Wed { get; set; }
        public string Thu { get; set; }
        public string Fri { get; set; }
        public string Sat { get; set; }
        public string Sun { get; set; }
        //End of Commented & Added By Dipali V On 21st Oct 2021 For Conversion & Get Exact Hours
        public int MonStoryPoint { get; set; }
        public int TueStoryPoint { get; set; }
        public int WedStoryPoint { get; set; }
        public int ThuStoryPoint { get; set; }
        public int FriStoryPoint { get; set; }
        public int SatStoryPoint { get; set; }
        public int SunStoryPoint { get; set; }
        public string MonDescription { get; set; }
        public string TueDescription { get; set; }
        public string WedDescription { get; set; }
        public string ThuDescription { get; set; }
        public string FriDescription { get; set; }
        public string SatDescription { get; set; }
        public string SunDescription { get; set; }
        //Added & Commented By Dipali V On  4th OCt 2021 For Get 2 digit Work Hours
        //public float ActualWork { get; set; }
        public string ActualWork { get; set; }
        //End of Added & Commented By Dipali V On  4th OCt 2021 For Get 2 digit Work Hours
        public string ActualStartDate { get; set; }
        public string ActualEndDate { get; set; }
        public float ActualPercentComplete { get; set; }
        public float ResourcePercentComplete { get; set; }
        public int IsTaskComplete { get; set; }
        public string WhichTask { get; set; }
        public int SubTaskTypeID { get; set; }
        public int IsProject { get; set; }
        public float Percentage { get; set; }
        public string Tasknotes { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public float Work { get; set; }
        public string MileStone { get; set; }
        public string Phase { get; set; }
        public string SubProjectName { get; set; }
        public string DeliverableName { get; set; }
        public string ModuleName { get; set; }
        public string Issue { get; set; }
        public float Duration { get; set; }
        public string DayName { get; set; }
        public string ProjectCode { get; set; }
        public string ProjectStartDate { get; set; }
        public string ProjectEndDate { get; set; }
        public int IsAgileProject { get; set; }
        public int ResourceLevelTaskCompletion { get; set; }
        public int ApplyEffortDistribution { get; set; }
        public int DAID { get; set; }
        public int StoryPoint { get; set; }
        public int TimesheetID { get; set; }
        public string MonStatusFlag { get; set; }
        public string TueStatusFlag { get; set; }
        public string WedStatusFlag { get; set; }
        public string ThuStatusFlag { get; set; }
        public string FriStatusFlag { get; set; }
        public string SatStatusFlag { get; set; }
        public string SunStatusFlag { get; set; }
        public int MonAllowToResubmit { get; set; }
        public int TueAllowToResubmit { get; set; }
        public int WedAllowToResubmit { get; set; }
        public int ThuAllowToResubmit { get; set; }
        public int FriAllowToResubmit { get; set; }
        public int SatAllowToResubmit { get; set; }
        public int SunAllowToResubmit { get; set; }
        public int AllowToResubmit { get; set; }
        public string StatusFlag { get; set; }
        public int RestrictByMinHours { get; set; }
       //public float TaskActualWork { get; set; }
        public string TaskActualWork { get; set; }
        public string TaskStatusFlag { get; set; }
        public int IsApprover { get; set; }
        public int AllowActivityLevelDA { get; set; }
        public int IsSubTaskFilled { get; set; }
    }
    public class WeekTotal
    {
        public float Total { get; set; }
        public string EntryDate { get; set; }
        //Commented And Added By Reshma Chavan on 11th Nov 2021 getting Correct Weekly total
        //public float AllTotal { get; set; }
        public string AllTotal { get; set; }
        //End of Commented And Added By Reshma Chavan on 11th Nov 2021 getting Correct Weekly total
        public int WeekDays { get; set; }
    }
    public class HeaderColumn
    {
        public string EntryDate { get; set; }
        public string DayName { get; set; }
        public int IsWorking { get; set; }
        public string Day { get; set; }
        public string DayNameFirst { get; set; }
        public string MonthName { get; set; }
        public string Year { get; set; }
        public string CurrentDate { get; set; }
        public int IsTodayDate { get; set; }
    }
    public class Access
    {
        public int intAccess { get; set; }
    }
    public class Filters
    {
        public List<TaskTypeFilter> TaskTypeFilterLists { get; set; }
        public List<PhaseFilter> PhaseFilterLists { get; set; }
        public List<MileStoneFilter> MileStoneFilterLists { get; set; }
        public List<DeliverableFilter> DeliverableFilterLists { get; set; }
        public List<SubProjectFilter> SubProjectFilterLists { get; set; }
        public List<ModuleFilter> ModuleFilterLists { get; set; }
    }
    public class ListParams
    {
        public List<DAParams> daParams { get; set; }
    }
    public class DAParams
    {
        public int DailyActivityEntryID { get; set; }
        public int TaskID { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public string EntryDate { get; set; }
        public Decimal Duration { get; set; }
        public string Description { get; set; }
        public int SubTasktypeID { get; set; }
        public bool IsDurationChange { get; set; }
        public bool IsTaskComplete { get; set; }
        public float ActualPercentComplete { get; set; }
        public bool bitResourceTaskComplete { get; set; }
        public int StoryPoint { get; set; }
        //2021
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        //2021

        public string DAType { get; set; }
    }
    //public class DAParams
    //{
    //    public int DailyActivityEntryID { get; set; }
    //    public int TaskID { get; set; }
    //    public int ProjectID { get; set; }
    //    public int EmployeeID { get; set; }
    //    public string EntryDate { get; set; }
    //    public string Duration { get; set; }
    //    public string Description { get; set; }
    //    public int SubTasktypeID { get; set; }
    //    public int IsDurationChange { get; set; }
    //    public int IsTaskComplete { get; set; }
    //    public string ActualPercentComplete { get; set; }
    //    public int bitResourceTaskComplete { get; set; }
    //    public int StoryPoint { get; set; }
    //    //2021
    //    public string dtFromDate { get; set; }
    //    public string dtToDate { get; set; }
    //    //2021
    //}
    public class VTWeek_MV
    {
        public string Total { get; set; }
        public string EntryDate { get; set; }
        public string Day { get; set; }
        public string DayName { get; set; }
        public string Year { get; set; }
        public string MonthName { get; set; }
        public string AllTotal { get; set; }
        public string ExpectedHours { get; set; }
        public string CurrentDate { get; set; }
        public string Period { get; set; }
    }

}