using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RR_ResourceAllocationReport
    {
        public string ProjectName { get; set; }
        public string EmployeeName { get; set; }
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public double Rate { get; set; }
        public double Cost { get; set; }
        public string Role { get; set; }


    }
    public class RR_ResourceAllocationByProject
    {
        public string ProjectName { get; set; }
        public string EmployeeName { get; set; }
        public List<RR_ResourceAllocationReport> lstRAProjectReport { get; set; }
    }
        public class RAFilterParameter : RR_ResourceAllocationReport
    {
        //public int ProjectId { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public int ProjectTypeID { get; set; }
        public string RAWhereClause { get; set; }
    }

    public class RA_Filter_params : RA_ReportParams
    {
        //public int BusinessGroupID { get; set; }
        //public int LocationID { get; set; }
        //public int TypeID { get; set; }
        public string RAWhereClause { get; set; }

    }
    public class RA_ReportParams
    {
        public string ReportFormat { get; set; }
        public string ReportTab { get; set; }

    }
    
   

}