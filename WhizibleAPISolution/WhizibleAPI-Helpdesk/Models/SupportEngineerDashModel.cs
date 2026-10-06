using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models
{
    public class SupportEngineerDashModel
    {
        public string CustomerName { get; set; }
        public string AssignToName { get; set; }

        public string STRResultQueryId { get; set; }
        public string Department { get; set; }
        public string CustomerID { get; set; }

        public string EmployeeID { get; set; }

        public string PageNo { get; set; }

        //Added by Riddhesh Patil on 24 Apr 2025 for Performance issue

        public string Flag { get; set; }

        //End of Added by Riddhesh Patil on 24 Apr 2025 for Performance issue






    }
}