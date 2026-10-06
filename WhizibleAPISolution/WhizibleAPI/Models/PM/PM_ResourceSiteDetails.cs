using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_ResourceSiteDetails
    {
    }
    public class ResourceSiteDetail
    {
        public int ProjectID{ get; set; }
        public int EmployeeID { get; set; }
        public int EmployeeSiteID { get; set; }
        public int RoleID { get; set; }
        public string StartDate { get; set; }
        public int ReasonID { get; set; }
        public string EmployeeName { get; set; }
        public string EmpReason { get; set; }
        public int EmployeeBillingInfoID { get; set; }
        public double NormalRate { get; set; }
        public double ExtraRate { get; set; }
        public double HolidayRate { get; set; }
        public int intTransferSiteID { get; set; }
        public int BillingPercentage { get; set; }
        public DataTable UnsuccessFullTransfer { get; set; }
        public object checkForUnsusseccfulTransfer { get; set; }
        public string strEmployeeID { get; set; }
        public string SiteName { get; set; }
        public string strEmployeeBillingInfoID { get; set; }
        public string strEmployeeSiteID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }


    }
}