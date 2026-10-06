using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_BulkExtensionApproval
    {
        public int ContractID { get; set; }
        public int ProjectID { get; set; }
        public string Status { get; set; }
        public int ProjectApprovalID { get; set; }
        public string ProjectApprovalIDs { get; set; }
        public string ResourceApprovalIDs { get; set; }
        //public string ApprovalComments { get; set; }
        //public string RejectionComments { get; set; } 
        public string Remarks { get; set; }
        public int ApprovedBy { get; set; }
        public string ApprovalStatus { get; set; }
        public int EmployeeID { get; set; }
        public int ResourceID { get; set; }
        public int ResourceApprovalID { get; set; }
    }
}