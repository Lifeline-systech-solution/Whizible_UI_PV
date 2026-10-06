using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class MyFilter
    {

    }

    public class ApplyFilterParameter
    {
        public int TagID { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public String FilterName { get; set; }
        public String LoginType { get; set; }
        public String CreatedBy { get; set; }
        public String WhereClause { get; set; }
        public String Flag { get; set; }
        public int FilterID { get; set; }
    }


    public class MyFilterParameter
    {
        public int FilterId { get; set; }
        public String FilterName { get; set; }
        public bool SetDefault { get; set; }
        public String QueryText { get; set; }
        public int EmployeeID { get; set; }
    }
}