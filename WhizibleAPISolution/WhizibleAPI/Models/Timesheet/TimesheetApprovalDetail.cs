using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Timesheet
{
    public class TimesheetApprovalDetail
    {
        public GetActualExpectedHours GetActualExpectedHours { get; set; }

        public List<TimesheetApprovalHeaderColumn> headerColumns { get; set; }
        public List<TAWeekTotal> WeekTotalLists { get; set; }
        public List<TimesheetDetailList> timesheetLists { get; set; }
        //Added By Usha Pandit On 27.03.2020 For integrating missing code
        public List<VTStatus_MV> VTStatus { get; set; }
        //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
    }
    public class GetActualExpectedHours
    {
        public string ActualHours { get; set; }
        public string ExpectedHours { get; set; }
        public string Status { get; set; }
        public string EmployeeName { get; set; }
    }
    public class TimesheetApprovalHeaderColumn
    {
        public string EntryDate { get; set; }
        public string DayName { get; set; }
        public int IsWorking { get; set; }
    }
    public class TAWeekTotal
    {
        public float Total { get; set; }
        public string EntryDate { get; set; }
        public float AllTotal { get; set; }
        public int WeekDays { get; set; }
    }
    public class TimesheetDetailList
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
        //Added By Usha Pandit On 27.03.2020 For integrating missing code
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
        //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
        //Commented & Added By Dipali V on 21st Oct 2021 For Get Actual Work Hours
        //public float ActualWork { get; set; }
        public string ActualWork { get; set; }
        //End of Commented & Added By Dipali V on 21st Oct 2021 For Get Actual Work Hours
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
        public int IsVerified { get; set; }
        public int IsApprover { get; set; }
        public string StatusFlag { get; set; }
        //Commented & Added By Dipali V On 21st Oct 2021 For Get Work Hour 
        //public float TaskActualWork { get; set; }
        public string TaskActualWork { get; set; }
        //End of Commented & Added By Dipali V On 21st Oct 2021 For Get Work Hour 
    }
    //Added By Usha Pandit On 27.03.2020 For integrating missing code
    public class VTStatus_MV
    {
        public int TimesheetID { get; set; }
        public string ActualHours { get; set; }
        public string ExpectedHours { get; set; }
        public string Status { get; set; }
        public string EmployeeName { get; set; }
    }
    //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
}