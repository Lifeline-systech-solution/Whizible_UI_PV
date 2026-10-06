using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
   
        public class RR_ResourceListReport
        {
            public string Location { get; set; }
            public string BusinessGroup { get; set; }
            public int EmployeeID { get; set; }
            public string EmployeeCode { get; set; }
            public string EmployeeName { get; set; }
            public string Phone { get; set; }
            public string EmailID { get; set; }
            public string JoiningDate { get; set; }
            public string Address { get; set; }
            public string City { get; set; }
            public string State { get; set; }
            public string Country { get; set; }
            public string BirthDate { get; set; }
            public string BloodGroup { get; set; }
            public string RoleDescription { get; set; }

    }
        public class ResourceFilter
        {
            public string ByOUBG { get; set; }
            public string RWhereClause { get; set; }
            public string ReportFormat { get; set; }
            public string ReportTab { get; set; }
    }
        public class RR_ResourceList
        {
            public string Location { get; set; }
            public string BusinessGroup { get; set; }
            public List<RR_ResourceListReport> lstResourceReport { get; set; }
        }
    
}