using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.DashBoard
{
    public class PM_SLADashboard
    {
        public int SLALikelyToMiss { get; set; }
        public int SLAMissed { get; set; }
        public int MySLATicketsInActive { get; set; }
        public int TotalActiveTickets { get; set; }
        public TicketDistribution TicketDistribution { get; set; }
        public List<SLAProjectData> ProjectData { get; set; }
    }

    public class PM_SLADashboardFilter
    { 
        public string ProjectFilter { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int LoginID { get; set; }
    }

    public class TicketDistribution
    {
        public string[] Type { get; set; } 
        public int[] TypeData { get; set; }
        public string[] ColorCode { get; set; }
    } 


    public class SLAProjectData
    { 
        public long ID { get; set; }
        public string Status { get; set; }
        public string Subject { get; set; }
        public string Priority { get; set; }
        public string RequestType { get; set; }
        public string Requestor { get; set; }
        public string RequestedOn { get; set; }
        public string LastUpdated { get; set; }
        public string AssignedTo { get; set; }
        public string AssignedToFullName { get; set; }
        public string ProjectName { get; set; }
    }
    public class ReportParam
    {
        public string Filter { get; set; }
        public string ReportFormat { get; set; }
        public int UserID { get; set; }
    }

    //Added by Nilesh Pingale On 16 Jul 2020 to build independant 
    public class FillProjectParametersNew
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }
    public class UserDataNew
    {
        public string EmployeeName { get; set; }
        public int EmployeeID { get; set; }
    }

    public class defaultFilterParametersNew
    {
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int QueryID { get; set; }
        public string LoginType { get; set; }
        public int EmployeeID { get; set; }

    }

    public class PM_CommercialDashboardFilterNew
    {
        public string ProjectFilter { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int LoginID { get; set; }
    }
    //End of Added by Nilesh Pingale On 16 Jul 2020 to build independant 
}
