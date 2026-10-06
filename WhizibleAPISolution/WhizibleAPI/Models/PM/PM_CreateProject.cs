using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_CreateProject
    {


    }


    //Added By Dipali V On 21st Dec 2019 For Workflow
    public class ProjectWorkFlow
    {

        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public int ProjectID { get; set; }
        public int strPrimaryKey { get; set; }
        public string LoginType { get; set; }
        public string strPrimaryKeyName { get; set; }
        public string Remarks { get; set; }
        public string strtablename { get; set; }
        public string strPageName { get; set; }
        public string strLinkName { get; set; }
        public string UserName { get; set; }
        public string WhichFlag { get; set; }
        //public int strPrimaryKey { get; set; }
        public int WBSID { get; set; }
        //Added By Dipali V On 7th Jan 2020 For WF
        public string Status { get; set; }
        public string GlobalUniqueID { get; set; }
        //End of Added By Dipali V On 7th Jan 2020 For WF
    }
    //End of Added By Dipali V On 21st Dec 2019 For Workflow


        //Added By Dipali V On 31st July 2020 For Altttech Customzation
    public class ConfigureControlPlot
    {
        public string ISDUEnabled { get; internal set; }
        public string ISDTEnabled { get; internal set; }
        public string ISDUMandetory { get; internal set; }
        public string ISDTMandetory { get; internal set; }
        public string ISDUDTDependent { get; internal set; }
    }



    public class DeliveryUnit
    {
        public string DTID { get; internal set; }
        public string DTName { get; internal set; }
        public string DUID { get; internal set; }
        public string DUName { get; internal set; }
    }
    //End of Added By Dipali V On 31st July 2020 For Altttech Customzation


    public class Location
    {
        public string LocationID { get; internal set; }
        public string LocationName { get; internal set; }
    }

    public class ProjectPracitce
    {

        public string ProjectType { get; internal set; }
    }

    public class OUHours
    {

        public string WorkingDays { get; internal set; }
        public string WorkingHours { get; internal set; }
    }

    public class ProjectCode
    {
        public string ErrorCode { get; internal set; }
        public string strProjectCode { get; internal set; }
    }
    public class ProjectPercentageSettings
    {
        public int SettingsId { get; set; }
        public double ResourceCostPercent { get; set; }
        public double ProfitMarginPercent { get; set; }
    }
    //Added By Usha Pandit On 12.11.2019 for discussion panel
    public class ProjectDiscussionsParameter
    {
        public int ProjectId { get; set; }
        public int DiscussionID { get; set; }
        public int UniqueID { get; set; }
        public int ParentID { get; set; }
        public int LoginID { get; set; }
        public int ReplyIndex { get; set; }
        public int IsShowToCustomer { get; set; }
        public String DiscussionThread { get; set; }
        public String SubmittedBy { get; set; }
        public String SubmittedDate { get; set; }
        public String LoginType { get; set; }
        public String DiscussionLevel { get; set; }
        public String Flag { get; set; }
    }
    public class GetProjectDiscussions
    {
        public int ProjectId { get; set; }
        public int DiscussionID { get; set; }
        public int UniqueID { get; set; }
        public int ParentID { get; set; }
        public int LoginID { get; set; }
        public int ReplyIndex { get; set; }
        public int IsShowToCustomer { get; set; }
        public String DiscussionThread { get; set; }
        public String SubmittedBy { get; set; }
        public String SubmittedDate { get; set; }
        public String LoginType { get; set; }
        public int ReplyCount { get; set; }
        public String DiscussionLevel { get; set; }
        public String Flag { get; set; }
    }
    //End Of Added By Usha Pandit On 12.11.2019 for discussion panel
    public class ProjectSiteDetails
    {
        public int ProjectSiteID { get; set; }
        public int ProjectID { get; set; }
        public string FromWhichMode { get; set; }
        public string WhichAction { get; set; }
        public string Remarks { get; set; }
        public int CurrencyID { get; set; }
        public int RateMethod { get; set; }
        public int StartingDayOfWeek { get; set; }
        public double WorkHrs { get; set; }
        public double WorkHoursCapPerDay { get; set; }
        public int WeekDays { get; set; }
        public double HoursPerMonth { get; set; }
        public string Name { get; set; }
        public string ShortName { get; set; }
        public string Address { get; set; }
        public string Address1 { get; set; }
        public string State { get; set; }
        public int CountryID { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string EmailID { get; set; }
        public int IsOffshore { get; set; }
        //Added By Usha Pandit On 14.01.2020 For Getting Freeze site details
        public int Freeze { get; set; }
        //End Of Added By Usha Pandit On 14.01.2020 For Getting Freeze site details
        public string EndDate { get; set; }
        public string SelectedDate { get; set; }
        public string StrUserName { get; set; }
        public string MilestoneStatus { get; set; }
        public int IsClosed { get; set; }
        public string CompletionPercentage { get; set; }
        public string ProjectValue { get; set; }
    }
    public class ProjectRateCardDetails
    {
        public int ProjectSiteID { get; set; }
        public int ProjectID { get; set; }
        public string FromWhichMode { get; set; }
        public string WhichAction { get; set; }
        public int ProjectSiteRoleID { get; set; }
        public int RoleID { get; set; }
        public int TemplateID { get; set; }
        public string TemplateName { get; set; }
        public int SiteCount { get; set; }
        public double NormalRate { get; set; }
        public double ExtraRate { get; set; }
        public int IsApplied { get; set; }
        public double CTC { get; set; }
        public double HolidayRate { get; set; }
        public int CurrencyID { get; set; }
        public int CustomerID { get; set; }
        public string CurrencyCode { get; set; }
        public int IsConvertedToProject { get; set; }
        public string RoleDescription { get; set; }
        public string UserName { get; set; }
    }
    public class ContractTypeDetails
    {
        public int ContractTypeID { get; set; }
        public string WhichAction { get; set; }
        public int MilestoneActive { get; set; }
        public int SiteActive { get; set; }
    }
    public class ProjectCostDetails
    {
        public int WorkOrderCostID { get; set; }
        public int ProjectID { get; set; }
        public int CostHeadID { get; set; }
        public int CurrencyID { get; set; }
        public string CurrencySymbol { get; set; }
        public string CurrencyCode { get; set; }
        public int IsActive { get; set; }
        public string WhichAction { get; set; }
        public string Description { get; set; }
        public string CostHead { get; set; }
        public string CostGroup { get; set; }
        public int CostGroupID { get; set; }
        //Commented & Added By Dipali V On 26th Oct 2023 For Convert double
        //public double CostToCompany { get; set; }
        public string CostToCompany { get; set; }
        //public double Reimbersable { get; set; }
        public string Reimbersable { get; set; }
        public string Billable { get; set; }
        //public double Billable { get; set; }
        public int IsSetByUser { get; set; }
        //public double TotalCostToCompany { get; set; }
        public string TotalCostToCompany { get; set; }
        //public double TotalReimbersable { get; set; }
        public string TotalReimbersable { get; set; }
        //public double TotalBillable { get; set; }
        //End of Commented & Added By Dipali V On 26th Oct 2023 For Convert double
        public string TotalBillable { get; set; }
        public int IsConvertedToProject { get; set; }
        public string UserName { get; set; }
    }
    public class ProjectCostHeadDetails
    {
        public int WorkOrderCostID { get; set; }
        public int WorkOrderCostDetailID { get; set; }
        public string WorkOrderCostDetailIDList { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        //31.12.2019
        public string FirstDate { get; set; }
        public int FirstDateId { get; set; }
        //31.12.2019
        public string LastDate { get; set; }
        public int LastDateId { get; set; }

        public int IsPublic { get; set; }
        public int Billable { get; set; }
        public int UserCanOverride { get; set; }
        public string IsPublic_YesNo { get; set; }
        public string UserCanOverride_YesNo { get; set; }
        public string Billable_YesNo { get; set; }
        public string WhichAction { get; set; }
        public int IsConvertedToProject { get; set; }
        public string UserName { get; set; }
    }
    public class LinkStatus
    {
        public string Flag { get; set; }
        public string IsEnabled { get; set; }
    }
}