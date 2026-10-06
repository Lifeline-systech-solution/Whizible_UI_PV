using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PlannedVSActual
{
    public class PlannedVSActual
    {
        public int PageNo { get; set; }
        public int PageSize { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int Month { get; set; }
        public int Year { get; set; }
        public int EmpID { get; set; }
        public int IsBillable { get; set; }
        public int IsActive { get; set; }
        public int Period { get; set; }
        public int MyTeam { get; set; }

        public string BGID { get; set; }
        public string OUID { get; set; }
        public string DUID { get; set; }
        public string DTID { get; set; }
        public string RoleID { get; set; }
        public string Designation { get; set; }
        public string Skill { get; set; }
        public string EmployeeType { get; set; }
        public string Department { get; set; }
        public string PoolID { get; set; }
        public string Deployable { get; set; }
       
        public string strName { get; set; }
        public string CurrentDayOneMonthYear { get; set; }
        public string CurrentlastDayMonthYear { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string TaskType { get; set; }
        public string TaskProjectID { get; set; }
        public string ProjectName { get; set; }
        public string EmployeeName { get; set; }
        public string ReportingTo { get; set; }
        //Added by Vishal Mane on 19/12/2025 to improve performance for W26
        public int ReportMode { get; set; }
        public int ReportingToLevel { get; set; }
        public int IsFilter { get; set; }
        //End of Added by Vishal Mane on 19/12/2025 to improve performance for W26
        //Added by Vishal Mane on 30/12/2025 for Timesheet Compliance Export functionality
        public string ReportFormat { get; set; }
        //End of Added by Vishal Mane on 30/12/2025 for Timesheet Compliance Export functionality

    }
}