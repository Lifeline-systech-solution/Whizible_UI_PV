using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WhizibleAPI.Models.PM
{
    public class PM_ProjectTimesheetDetails
    { }
    public class EmployeeDetails
    {
        public string EmployeeID { get; set; }
        public string EmployeeName { get; set; }
    }

    public class RoleList
    {
        public string RoleID { get; set; }
        public string RoleDescription { get; set; }
    }
    public class SiteCalenderList
    {
        public int SiteCalendarDayID { get; set; }
        public int ProjectID { get; set; }
        public int SiteID { get; set; }
        public int Holiday { get; set; }
        public int Freeze { get; set; }
        public string Day { get; set; }
        public string NormalHours { get; set; }
        public string ExtraHours { get; set; }
    }

    public class SiteOULevelHolidaysList
    {

        public string m_strHolidayList { get; set; }
        public string m_NormalDays { get; set; }

    }


    public class StartingDayOfWeek
    {

        public int StartingWeek { get; set; }
        public int WeekDays { get; set; }
        //public int ExtraHoursCap { get; set; }
        //public int WorkHrs { get; set; }
        public string ExtraHoursCap { get; set; }
        public string WorkHrs { get; set; }

    }
  
    public class ProjectTimesheetDetails
    {
      
        public List<EmployeeDetails> EmployeeDetails { get; set; }
        public List<RoleList> RoleList { get; set; }
        public List<SiteCalenderList> SiteCalenderList { get; set; }
        public List<SiteOULevelHolidaysList> SiteOULevelHolidaysList { get; set; }
        //public SiteOULevelHolidaysList SiteOULevelHolidaysList { get; set; }
        public List<StartingDayOfWeek> StartingDayOfWeek { get; set; }
        public int ProjectID { get; set; }
        public int TimesheetAdvisedID { get; set; }
        public int TimesheetNo { get; set; }
        public int ProjectSiteID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public string EmployeeID { get; set; }
        public string TimsheetIDs { get; set; }
        public string UniqueIDs { get; set; }
        public string WSRCheckedCheckbox { get; set; }
        public string ReportFormat { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string ActualWork { get; set; }
        public string TimesheetID { get; set; }
        public string Description { get; set; }
        public string UserName { get; set; }
        public string NextWeekActivites { get; set; }
        public string Issues { get; set; }
        public string Suggestions { get; set; }
        public string Slippage { get; set; }
        public string Highlights { get; set; }
        public string WorkHrs { get; set; }
        public string Flag { get; set; }



       //' ------------
         public int OrganizationUnit { get; set; }
        public int ProjectCurrency { get; set; }
        public int OnsiteFull { get; set; }
        public int RateMethod { get; set; }
        public string ContractType { get; set; }
        public string OUWorkingDays { get; set; }
        public string WorkingHrsPerDay { get; set; }
        public string BufferPercentage { get; set; }
        public string MonthlyHr { get; set; }
        public string Discount { get; set; }
        public string EffortToConsider { get; set; }
       
        public string ActualDayBilling { get; set; }
        public string FixedMonthlyRate { get; set; }
        public string InvoiceDate { get; set; }
        public Boolean RestrictByMinHours { get; set; }
        public string MinHoursForDAEntry { get; set; }
     
        public int InvoiceTimesheetID { get; set; }

        public int ContractTypeID { get; set; }
        public int CurrencyID { get; set; }
        public string SiteValidation { get; set; }
        public string CapConsider { get; set; }
        public string CapHoliday { get; set; }



    }



    
}