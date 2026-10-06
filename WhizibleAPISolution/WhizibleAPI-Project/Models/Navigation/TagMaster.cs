using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Navigation
{
    //
    public class TagMaster
    {
        public int TagID { get; set; }
        public string TemplateID { get; set; }
        public string DisplayPageName { get; set; }
        public string DisplayTagName { get; set; }
        public int ParentTagId { get; set; }
        public int IsParent { get; set; }
        public string Image { get; set; }
        public int IsDefaultPage { get; set; }
        public string DisplayHeader { get; set; }
        public int AllowResponsive { get; set; }
        public string ResponsivePageName { get; set; }
        public string ActiveResponsiveImage { get; set; }
        public string NonActiveResponsiveImage { get; set; }

        public int IsLandingPage { get; set; }

    }
    public class Employee
    {
        public int EmployeeID { get; set; }
        public int RoleID { get; set; }
        public string EmployeeName { get; set; }
        public string Role { get; set; }
        public string EmployeeImage { get; set; }
    }
    public class CompanyInformation
    {
        public int StartingDayOfWeek { get; set; }
        public string FinancialYearStart { get; set; }
        public string FinancialYearEnd { get; set; }
        public string SMTPUserName { get; set; }
        public string SMTPPassword { get; set; }
        public string SMTPDomainName { get; set; }
        public int SMTPServerPort { get; set; }
        public string EmailFormat { get; set; }
        public string SMTPServer { get; set; }
        public int AllowResourceAllocation { get; set; }
    }
}