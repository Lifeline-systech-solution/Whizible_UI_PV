using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    /// <summary>
    /// Ir:InfraResource
    /// </summary>
    public class RM_IrRequestApproval
    {

    }

    /// <summary>
    /// Ussed for bind project list
    /// </summary>
    public class IR_RequestApprovalProjects
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }

    public class IR_RequestAppParams
    {
        public int UserID { get; set; }
        public string WhereClause { get; set; }
    }
    public class IR_RequestApprovalListParams: IR_RequestAppParams
    {
        public int InfraRequestId { get; set; }
        public DateTime PrevDate { get; set; } //map the prev
        public DateTime NextDate { get; set; } // map the next date
    }

    public class IR_RequestsApprovalRequest
    {
        public int InfraRequestId { get; set; }
        public int InfraResourceId { get; set; }
        public int ProjectID { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public string Status { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public DateTime RequestedDate { get; set; }
        public string RequestedBy { get; set; }

    }

    public class IR_RequestsApprovalRequestWeek
    {
        public int InfraRequestId { get; set; }
        public int InfraResourceId { get; set; }
        public int ProjectID { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public String FirstMonthYear { get; set; }  // manage the month and year here in sp  for 3 month or we will need add for each week field
        public String SecondMonthYear { get; set; }
        public String ThirdMonthYear { get; set; }
        public string Week1  { get; set; } //manage week list at client side for e.g if week count is 13 or 14 or 15 using html string
        public string Week2 { get; set; }
        public string Week3 { get; set; }
        public string Week4 { get; set; }
        public string Week5 { get; set; }
        public string Week6 { get; set; }
        public string Week7 { get; set; }
        public string Week8 { get; set; }
        public string Week9 { get; set; }
        public string Week10 { get; set; }
        public string Week11 { get; set; }
        public string Week12 { get; set; }
        public string Week13 { get; set; }
        public string Week14 { get; set; }
        public string Week15 { get; set; }

    }

}