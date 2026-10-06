using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models
{
    //public class RR_SiteReport
    //{
    //    public string ResourceName { get; set; }
    //    public string ProjectName { get; set; }
    //    public string SiteName { get; set; }
    //    public DateTime Date { get; set; }
    //    public double NormalHours { get; set; }
    //    public double NormalRate { get; set; }
    //    public double TotalNormalWage { get; set; } //Normal Billing Total 
    //    public double ExtraHours { get; set; }
    //    public double ExtraRate { get; set; }
    //    public double TotalExtraWage { get; set; } //Extra Billing Total
    //    public double TotalBillableHours { get; set; } // Billable Hours
    //    public double TotalBillableWage { get; set; } // Billable Total
    //    public double NonBillableHours { get; set; }
    //    public double TotalNonBillableWage { get; set; }

    //}
    public class RR_SiteReport
    {
        public string ResourceName { get; set; }
        public string ProjectName { get; set; }
        public string SiteName { get; set; }
        //Commented and added by imran on 05-01-2022 to show only date on report
       //public DateTime Date { get; set; }
        public string Date { get; set; }
        //End comment by imran on 05-01-2022
        public double NormalHours { get; set; }
        public double NormalRate { get; set; }
        public double NormalBillingTotal { get; set; } //Normal Billing Total 
        public double ExtraHour { get; set; }
        public double ExtraRate { get; set; }
        public double ExtraBillingTotal { get; set; } //Extra Billing Total
        public double BillableHours { get; set; } // BillableHours
        public double BillableTotal { get; set; } // BillableTotal
        public double NonBillableHours { get; set; }
        public double NonBillableTotal { get; set; } //TotalNonBillableWage

    }
    public class RR_SiteParameters
    {
        public string ReportFormat { get; set; }
        public string BySiteResource { get; set; }
        public int LocationID { get; set; }
        public int EmployeeID { get; set; }
        public int ProjectID { get; set; }
        public int SiteID { get; set; }
       
    }


    public class RR_ProjectSites
    {
        public int ProjectSiteID { get; set; }
        public string Name { get; set; }
    }
    public class RR_ProjectEmployee
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
    }
    public class RR_ResourceList
    {
        public string SiteName { get; set; }
        public string ResourceName { get; set; }
        public List<RR_SiteReport> lstResourceReport { get; set; }
    }


}