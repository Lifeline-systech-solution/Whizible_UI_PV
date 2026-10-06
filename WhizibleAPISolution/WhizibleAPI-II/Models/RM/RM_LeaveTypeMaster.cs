using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_LeaveTypeMaster
    {
        public int LeaveTypeId { get; set; }
        public string LeaveType { get; set; }
        public bool CarryForward { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
    }
    public class LeaveFilterParameter : RM_LeaveTypeMaster
    {
        public string LeaveWhereClause { get; set; }
    }
}