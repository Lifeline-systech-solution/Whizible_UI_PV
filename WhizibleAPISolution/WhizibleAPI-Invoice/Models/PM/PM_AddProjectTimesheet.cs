using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WhizibleAPI.Models.PM
{   //Model Name : PM_AddProjectTimesheet
    //Created By : Dipali V
    //Created Date : 22th Sep 2023
    public class PM_AddProjectTimesheet
    { }

    public class ProjectDetail
    {
        public DataTable GetProjectDetail { get; set; }
        public DataTable GetDatesForTimeSheet { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int ContractTypeID { get; set; }
        public string TimesheetNo { get; set; }
        public string SalesPersonName { get; set; }
        public string SaleCommision { get; set; }
        public int OrganizationUnit { get; set; }
        public string ToDate { get; set; }
        public string InvoiceDate { get; set; }
        public string SalesPersonIDs { get; set; }
        public int ProjectSiteID { get; set; }
        public int CustomerID { get; set; }
        public int ChecklistID { get; set; }
        public int CustomerAddrId { get; set; }
        public string Year { get; set; }
        public string Month { get; set; }
        public string FromDate { get; set; }
        public string salesPeriodEndDate { get; set; }
        public string salesPeriodStartDate { get; set; }
        public string salesPeriodMonth { get; set; }
        public string ProjectOrProduct { get; set; }
        public string salesPeriodYear { get; set; }
        public string IsOpen { get; set; }
        public string m_strFromTimeSheet { get; set; }
        public object GetOUWorkingDay { get; set; }

        public object OverlapValidation { get; set; }
        public object EntryFound { get; set; }
        public DataTable TimeSheetInvoiceDates { get; set; }
        public DataTable RateMethods { get; set; }
        public string RFID { get; set; }
        public string IsProforma { get; set; }
        public string RFITypeID { get; set; }
        public string CustomerContactID { get; set; }
        public string CustomerAddressID { get; set; }
        public string BillingCurrencyID { get; set; }
        public string CreditDays { get; set; }
        public string MilestoneID { get; set; }
        public string ContractID { get; set; }
        public string SalesPeriodID { get; set; }
        public string LOC { get; set; }
        public string CreatorOrModifier { get; set; }
        public string ConfirmEmailID { get; set; }
        public string RFIHeader { get; set; }
        public string strAdvisedIDs { get; set; }
        public string ChecklistItemID { get; set; }
        public string RFIChecklistComments { get; set; }
        public string RFIChecklistResponse { get; set; }
        //Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes
        public string IRConversionDate { get; set; }
        //End of Added By Dipali V On 10th Jan 2024 For Currency Conversion Changes

    }

    public class WorkingDaysParameter
    {
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public string UserName { get; set; }
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
        public string ToDate { get; set; }
        public string FromDate { get; set; }
        public string ActualDayBilling { get; set; }
        public string FixedMonthlyRate { get; set; }
        public string InvoiceDate { get; set; }
        public Boolean RestrictByMinHours { get; set; }
        public string MinHoursForDAEntry { get; set; }
        public string WorkHrs { get; set; }
        public int Flag { get; set; }
        public int InvoiceTimesheetID { get; set; }
        public int TimesheetID { get; set; }
        public int ContractTypeID { get; set; }
        public int CurrencyID { get; set; }
        public string SiteValidation { get; set; }
        public string CapConsider { get; set; }
        public string CapHoliday { get; set; }
        public string m_intChecklistID { get; set; }
        public string m_intChecklistInstanceID { get; set; }
        public string RFID { get; set; }
    }

    public class TimesheetParameter
    {
        public int TimesheetID { get; set; }
        public int UserID { get; set; }
        public int SiteID { get; set; }
        public int EmployeeID { get; set; }
        public int ProjectID { get; set; }
        public int OUID { get; set; }
        public string ToDate { get; set; }
        public string FromDate { get; set; }
        public string Remarks { get; set; }
        public string PMEditValue { get; set; }
        public string PMFinalEditDiffValue { get; set; }
        public int AdviceID { get; set; }
        public int RoleID { get; set; }
        public int CapConsider { get; set; }
        public int CapHoliday { get; set; }
        public int RFID { get; set; }

        public string OUWorkingDays { get; set; }
        public string WorkingHrsPerDay { get; set; }
        public string BufferPercentage { get; set; }
        public string MonthlyHr { get; set; }
        public string Discount { get; set; }
        public string EffortToConsider { get; set; }
        public string ActualDayBilling { get; set; }
        public string FixedMonthlyRate { get; set; }
        public string InvoiceDate { get; set; }
        public int OnsiteFull { get; set; }
        public int RateMethod { get; set; }
        public string SiteValidation { get; set; }
        public int ContractTypeID { get; set; }
        public int CurrencyID { get; set; }
        public int InvoiceTimesheetID { get; set; }
        public string BillingRate { get; set; }
        public string ActualRate { get; set; }
        public int WorkingDays { get; set; }
        public string NoDayWorked { get; set; }
        public string DailyRate { get; set; }
        public string InvoiceAmount { get; set; }
        public string FinalAmount { get; set; }
        public string EditAmount { get; set; }
        public string PMEditDifference { get; set; }
        public string PMReamrks { get; set; }

        public string EditedActualHrs { get; set; }
        public string OldInvoiceAmount { get; set; }
        public string OldNoDayWorked { get; set; }
        public string fltDiscount { get; set; }
        public string IRCommets { get; set; }
        public string IRStatus { get; set; }
        public string UserName { get; set; }

    }

}