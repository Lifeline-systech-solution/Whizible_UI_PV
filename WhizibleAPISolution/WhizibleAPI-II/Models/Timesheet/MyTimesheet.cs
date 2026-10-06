using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Timesheet
{
    public class MyTimesheet
    {
        public List<ApprovalStatus> ApprovalStatus { get; set; }
        public List<MyTimesheetDetail> MyTimesheetLists { get; set; }
        public List<MyTimesheetHistoryList> MyTimesheetHistoryLists { get; set; }
   
    }
    public class ApprovalStatus
    {
        public string StatusCode { get; set; }
        public string StatusDescription { get; set; }
    }
    public class MyTimesheetDetail
    {
        public int TimeSheetID { get; set; }
        public string CreatedDate { get; set; }
        public string Period { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string ActualHours { get; set; }
        public string StatusDescription { get; set; }
        public string Comment { get; set; }
        public string ExpectedHours { get; set; }
    }
    public class MyTimesheetHistoryList
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