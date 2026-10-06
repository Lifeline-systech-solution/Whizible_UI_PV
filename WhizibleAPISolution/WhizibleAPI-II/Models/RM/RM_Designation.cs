using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_Designation
    {
        public int DesignationID { get; set; }
        public string DesignationName { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }

    }
    public class DsgFilterParameter : RM_Designation
    {
        public string DsgWhereClause { get; set; }

    }
    public class RM_DesignationLeaves
        {
        public int DesignationID { get; set; }
        }
    public class RM_DesLeaves
    {
        public int UniqueID { get; set; }
        public string LeaveType { get; set; }
        public string ProRata { get; set; }
        public string NoOfLeaves { get; set; }
        public int Role { get; set; }
        public int LeaveTypeID { get; set; }
        public string CreatedBy { get; set; }
    }

}