using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Timesheet
{
    public class TimesheetApproval
    {
        public GetWeekCount GetWeekCount { get; set; }
        public List<TimesheetStatus> TimesheetStatusLists { get; set; }
        public List<TimesheetApprovalEmployeeFilter> TimesheetEmployeeList { get; set; }
        public List<TimesheetApprovalList> TimesheetApprovalLists { get; set; }
        public List<TimesheetHistoryList> TimesheetHistoryLists { get; set; }
    }
    public class GetWeekCount
    {
        public int WeekNumber { get; set; }
        public string Year { get; set; }
    }
    public class TimesheetStatus
    {
        public int StatusID { get; set; }
        public string StatusCode { get; set; }
        public string StatusDescription { get; set; }
    }
    public class TimesheetApprovalEmployeeFilter
    {
        public int EmployeeID { get; set; }
        public String EmployeeName { get; set; }
    }
    public class TimesheetApprovalList
    {
        public int TimeSheetID { get; set; }
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string Period { get; set; }
        public string StatusCode { get; set; }
        public string StatusDescription { get; set; }
        public string ActualHours { get; set; }
        public string ExpectedHours { get; set; }
        public string Comment { get; set; }
    }
    public class TimesheetHistoryList
    {
        public int ResourceTimesheetStatusHistoryID { get; set; }
        public string DateAndTime { get; set; }
        public string ModifiedBy { get; set; }
        public string Field { get; set; }
        public string OldValue { get; set; }
        public string NewValue { get; set; }
        public string Status { get; set; }
        public string CreatedDate { get; set; }
        public string UpdatedDate { get; set; }
        public string ActionTakenBy { get; set; }
        public string ActionTaken { get; set; }
        public string ApproverName { get; set; }
    }
  
}