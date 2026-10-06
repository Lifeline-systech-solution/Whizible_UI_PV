using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Invoice
{
    public class RFI_IR_PIR
    {
        public int ProjectID { get; set; }
        public string ContractType { get; set; }
        public int CustomerID { get; set; }
        // public int IsProforma { get; set; }
        public int RFID { get; set; }
        public string IsOpen { get; set; }
        public string salesPeriodYear { get; set; }
        public string salesPeriodMonth { get; set; }
        public string salesPeriodStartDate { get; set; }
        public string salesPeriodEndDate { get; set; }
        public int CustomerAddrID { get; set; }
        public int ContractTypeID { get; set; }
        public int ContractID { get; set; }
        public int CustomerContactID { get; set; }
        public string RFIID { get; set; }
        public string RFITypeID { get; set; }
        // public string ProjectID { get; set; }
        // public string RFIID { get; set; }
        //  public string RFITypeID { get; set; }
        public string ProjectName { get; set; }
        public string RFITypeName { get; set; }
        public string RFIRaisedOn { get; set; }
        public string BillingCurrencyCode { get; set; }
        public string BillingCurrencyAmount { get; set; }
        public string EquivAmount { get; set; }
        public string BaseCurrencyCode { get; set; }
        public string BaseCurrencyAmount { get; set; }
        public string Status { get; set; }
        public string SalesPerson { get; set; }
        public string SalesPersCommision { get; set; }
        public string ConfirmEmailID { get; set; }
        public string RFIHeader { get; set; }
        public string CreatorOrModifier { get; set; }
        public string SalesPersonIDs { get; set; }
        public string InvoiceDate { get; set; }
        public int BillingCurrencyID { get; set; }
        public int CreditDays { get; set; }
        public int LOC { get; set; }
        public int MilestoneID { get; set; }
        public int SalesPeriodID { get; set; }

        public string IsProforma { get; set; }
        public string FilterName { get; set; }
        public string FilterID { get; set; }
        public string CreatedBy { get; set; }
        public string InvoiceGenerated { get; set; }
        public int InvoiceNumber { get; set; }
        public string ReportFormat { get; set; }
        public string SubmitIRComments { get; set; }
        public string whereClause { get; set; }

        public string IsOnlyApplyFlag { get; set; }

        public string MileStoneID { get; set; }

        public string DeliverableID { get; set; }

        public string intCurrencyID { get; set; }

        public string intCostHeadID { get; set; }

        public int intResourceID { get; set; }

        public string ExpensesEntryIDs { get; set; }
        public string CompanyBaseCurrencyAmount { get; set; }
        public string BillingToBaseConversionRate { get; set; }
        public string TotalAmountINR { get; set; }
        public string CompanyBaseCurrencyConversionRate { get; set; }
        public int IsDiscount { get; set; }
        public string ProjectType { get; set; }
        public string ItemDesc { get; set; }
        public string Quantity { get; set; }
        public string Rate { get; set; }
        public string CustomField1{ get; set; }
        public string CustomField2{ get; set; }
        public string CustomField3{ get; set; }
        public string CustomField4 { get; set; }
        public int OrderNum { get; set; }
        public int RFIItemID { get; set; }
        public int UserId { get; set; }
        public string RFIItemIDs { get; set; }
        public string FieldName { get; set; }
        public int TimeSheetID { get; set; }
        public string TimeSheetIDs { get; set; }
        public string AdvisedIDs { get; set; }
        public string CurrencyCode { get; set; }
        public string RFIIDs { get; set; }
        public string LoginType { get; set; }
        public string ExpencesCurrencyIDs { get; set; }
        public int CorpBaseCurrencyID { get; set; }
        public string InvoiceConversionDate { get; set; }

        public int RFIChecklistID { get; set; }
        public string RFIChecklistItemID { get; set; }

        public int RFIChecklistInstanceItemID { get; set; }
        public int RFIChecklistInstanceID { get; set; }
        public string RFIChecklistItem { get; set; }
        public string ChecklistComment { get; set; }
        public int RFIChecklistItemResponse { get; set; }
        public int Flag { get; set; }
        public string TimesheetIds { get; set; }
        public string Amount { get; set; }


    }
    public class RFI_CheckList_Items
    {
        public string ProjectID { get; set; }
        public string RFIID { get; set; }
        public int RFIChecklistID { get; set; }
        public string RFIChecklistItemID { get; set; }
        public string RFIChecklistItem { get; set; }
        public string RFIChecklistInstanceID { get; set; }
        public RFIChecklistItems[] RFIChecklistItems { get; set; }
        public string InvoiceID { get; set; }
        public string CreatedBy { get; set; }

    }
    public class RFIChecklistItems
    {

        public int RFIChecklistInstanceItemID { get; set; }
        public int RFIChecklistInstanceID { get; set; }
        public int RFIChecklistItemID { get; set; }
        public string RFIChecklistItem { get; set; }
        public string ChecklistComment { get; set; }
        public int RFIChecklistItemResponse { get; set; }
    }

    public class WorkingDaysParameter
    {
        public string m_intChecklistID { get; set; }
        public string m_intChecklistInstanceID { get; set; }
        public int RFID { get; set; }
    }
    
    public class RFIAmount
    {
        public string CompanyBaseCurrencyAmount { get; set; }
        public string TotalAmountINR { get; set; }
        public string BaseCurrencyAmount { get; set; }
    }

    public class RFI_ProjectSettingsDetails
    {
        public int ProjectID { get; set; }
        public bool UseActivities { get; set; }
        public bool ApplyEffortDistribution { get; set; }
        public int LocationID { get; set; }
        public string ProjectStartDate { get; set; }
        public string ProjectEndDate { get; set; }
        public string workhrs { get; set; }
        public bool HaveSubTaskTypes { get; set; }
        public bool ResourceValidation { get; set; }
        public bool IsBillable { get; set; }
        public bool ISProjectActive { get; set; }
        public string RestrictByMinHrs { get; set; }

    }
  public class RFIIDs
    {
        public int RFIID { get; set; }
      
    }

}