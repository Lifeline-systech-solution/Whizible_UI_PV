using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Issue
{
    public class IB_IssueDetails
    {

       
        public List<GetIssueDetails> GetIssueDetailsData { get; set; }
        public List<FlagDateStatusDetails> FlagDateStatusData { get; set; }
        public List<ProductFieldStatusDetails> ProductFieldStatusData { get; set; }
        public List<CommonTypeDetails> CommonTypeData { get; set; }
        public List<CommonSubTypeDetails> CommonSubTypeData { get; set; }
        public List<LayoutDetails> Ldetails { get; set; }
    }

    public class GetIssueDetails
    {
        public int IssueID { get; set; }
        public int ProjectID { get; set; }
        public string Type { get; set; }
        public string Corporate_Type { get; set; }
        public string SubType { get; set; }
        public string CorporateSubType { get; set; }
        public string Priority { get; set; }
        public string CorporatePriority { get; set; }
        public string Status { get; set; }
        public string CorporateStatus { get; set; }
        public string ProjectName { get; set; }
        public string Severity { get; set; }
        public string CorporateSeverity { get; set; }
        public string ReportedBy { get; set; }
        public int AssignTo { get; set; }
        public string ResonsibleAssignTo { get; set; }
        public string ReportedDate { get; set; }
        public string CreatedDate { get; set; }
        public string CustomerIssueID { get; set; }
        public string Summary { get; set; }
        public string Description { get; set; }
        public string ModuleName { get; set; }
        public string ShowToCustomer { get; set; }
        public string LoginType { get; set; }
        public string IssueCode { get; set; }
        public string RepartedTime { get; set; }
        public string StatusChangeTime { get; set; }
        public string StatusChangeDate { get; set; }
        public string LastUpdatedDate { get; set; }
        public int ProductVersionID { get; set; }
        public int CustomerID { get; set; }
        public int ComponentID { get; set; }
        public string Complexity { get; internal set; }
        public string ResponsiblePerson { get; internal set; }
        public string ReportedTime { get; internal set; }
        public int DeliverableID { get; internal set; }
        public string ImportID { get; internal set; }
        public string ReleaseID { get; internal set; }
        public string IterationID { get; internal set; }
        public string UserStoryID { get; internal set; }
        public string RootCauseID { get; internal set; }
        public string ChangeRequestID { get; internal set; }
        public string CodedBy { get; internal set; }
        public string ReportedInVersion { get; internal set; }
        public string CorrectedInVersion { get; internal set; }
        public string Phase { get; internal set; }
        public string FoundInPhase { get; internal set; }
        public string FixedInPhase { get; internal set; }
        public string Hardware { get; internal set; }
        public string OS { get; internal set; }
        public string Kernel { get; internal set; }
        public string Keywords { get; internal set; }
        public string CRMQueryID { get; internal set; }
        public string Flag { get; internal set; }
        public string Duedate { get; set; } 
    }
    public class FlagDateStatusDetails
    {
        public string FlagDateStatus { get; set; }
    }
    public class ProductFieldStatusDetails
    {
       public int Customer { get; set; }
        public int ProductVersionID { get; set; }
        public string CustomerName { get; set; }
        public string ProductVersion { get; set; }
        public int CompoanentID { get; set; }
        public string Component { get; set; }
        

    }


    public class CommonTypeDetails
    {
      
        public string FieldID { get; set; }
        public string FieldName { get; set; }
        public string Type { get; set; }
    }
    public class CommonSubTypeDetails
    {

        public string FieldID { get; set; }
        public string FieldName { get; set; }
        public string Type { get; set; }
        public string UserName { get; set; }

    }

    public class LayoutDetails
    {
        public int LayoutSrNO { get; set; }
        public int LayoutID { get; set; }
        public int RowNumber { get; set; }
        public int ColumnNumber { get; set; }
        public int ReadOnly { get; set; }
        public int UniqueID { get; set; }
        public int ShowInAddMode { get; set; }
        public int ReadOnlyInAddMode { get; set; }
        public int ShowInEditMode { get; set; }
        public int ReadOnlyInEditMode { get; set; }
        public int Mandatory { get; set; }
        public int Active { get; set; }
        public string UserFriendlyName { get; set; }
        public string FieldName { get; set; }
        public string TableFieldName { get; set; }
        public int ControlWidth { get; set; }
}


    public class Issue
    {
        public List<ProjectFilter> ProjectFilterLists { get; set; }
        public List<HeaderColumn> headerColumns { get; set; }
        public List<IssueList> issueLists { get; set; }
    }

    //public class ProjectFilter
    //{
    //    public int ProjectID { get; set; }
    //    public string ProjectName { get; set; }
    //}
    //public class SearchOption
    //{
    //    public string Id { get; set; }
    //    public string Value { get; set; }
    //}
    //public class HeaderColumn
    //{
    //    public string ColumnName { get; set; }
    //}
    //public class IssueList
    //{
    //    public long IssueId { get; set; }
    //}
    //public class ViewDetails
    //{
    //    public int ViewId { get; set; }
    //    public string ViewName { get; set; }
    //    public string FieldList { get; set; }
    //    public string UserFriendlyNameList { get; set; }
    //    public string OrderBy { get; set; }
    //}
    //public class ViewList
    //{
    //    public static int Title { get; internal set; }
    //    public int ViewId { get; set; }
    //    public string ViewName { get; set; }
    //    public int ProjectID { get; set; }
    //    public int EmployeeID { get; set; }
    //    public string Fields { get; set; }
    //    public string SortBy { get; set; }
    //    public string CreatedDate { get; set; }
    //    public string CreatedBy { get; set; }
    //    public int DefaultViewId { get; set; }
    //    public string ViewType { get; set; }
    //}
    //public class ProjectViewFieldList
    //{
    //    public string FieldID { get; set; }
    //    public string FieldName { get; set; }
    //    public string ActualFieldName { get; set; }
    //    public bool IsCustomField { get; set; }
    //}
    //public class QueryList
    //{
    //    public int QueryID { get; set; }
    //    public string QueryName { get; set; }
    //    public string QueryText { get; set; }
    //    public string QueryType { get; set; }
    //    public int ProjectID { get; set; }
    //    public int EmployeeID { get; set; }
    //    public String CreatedDate { get; set; }
    //    public bool IsDefault { get; set; }
    //}
    //public class QueryField
    //{
    //    public string FieldID { get; set; }
    //    public string FieldName { get; set; }
    //}
    //public class Operator
    //{
    //    public string Key { get; set; }
    //    public string Value { get; set; }
    //}
    //public class FilterControl
    //{
    //    public string Type { get; set; }
    //    public List<ControlCombo> lstControlCombo { get; set; }
    //    //public string Textbox { get; set; }
    //}
    //public class SearchOptionControl
    //{
    //    public string Type { get; set; }
    //    public List<ControlCombo> lstControlCombo { get; set; }
    //    //public string Textbox { get; set; }
    //}
    //public class ControlCombo
    //{
    //    public string Key { get; set; }
    //    public string Value { get; set; }
    //}
    public class LayoutControl
    {
        public int LayOutSrNo { get; set; }
        public int LayOutID { get; set; }
        public int ColumnNo { get; set; }
        public int RowNo { get; set; }
        public bool ReadOnly { get; set; }
        public int UniqueId { get; set; }
        public bool AddMode { get; set; }
        public bool ReadOnlyAddMode { get; set; }
        public bool EditMode { get; set; }
        public bool ReadonlyEditMode { get; set; }
        public bool Mandatory { get; set; }
        public string UserFriendlyName { get; set; }
        public string FieldName { get; set; }
        public string TableFieldName { get; set; }
        public int ControlWidth { get; set; }
        public bool Active { get; set; }
        public bool ResultFlag { get; set; }
        public string ControlType { get; set; }
        public string Query { get; set; }

    }
    public class LayoutFlag
    {
        public bool layoutProjectFlag { get; set; }

    }
    public class newIssueLayOutcontrol
    {

        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public string FieldID { get; set; }
        public string FieldName { get; set; }
        public string Type { get; set; }
        public int ReleaseID { get; set; }
        public string ReleaseName { get; set; }
        public CommonProperty commonProperty { get; set; }
        public string ReleaseFromProject { get; set; }//module componet
        public int ComponentID { get; set; }
        public string Component { get; set; }
        public int ScheduleID { get; set; }//Deliverable
        public string LabelSchedule { get; set; }
        public int ChangeRequestID { get; set; }
        public string ChangeRequestSummary { get; set; }
        public bool ResultFlag { get; set; }
    }

    public class CustomValidate {

        public int ProjectId { get; set; }
        public int IssueID { get;  set; }
    }


    public class CustomFiledPloat
    {
        public CustomFiledPloat()
        {
            Caption = new List<string>();

            Value = new List<string>();
            //IscustomfileAssigned = new List<String>();
            commonProperty = new CommonProperty();
        }



        //  public int ProjectId { get; set; }
        public CommonProperty commonProperty { get; set; }
        // public string [] Caption { get; set; }
        public List<string> Caption { get; set; }
        public List<bool> IscustomfileAssigned { get; set; }
        public string Type { get; set; }
        public string DatabaseFieldName { get; set; }
        public List<string> Value { get; set; }
        public object ValidationRules { get; internal set; }
        public object Rownumber { get; internal set; }
        public int RowNumber { get; internal set; }
        public int UniqueID { get; internal set; }
        public string UserGivenCaption { get; internal set; }
        public int ColumnNumber { get; internal set; }
        public string IsCustomFieldAssigned { get; set; }
        public string FieldID { get; set; }
        public string FieldName { get; internal set; }
        public string CustomFieldID { get; internal set; }
        public string DefaultValue { get; internal set; }
        public string DefaultType { get; internal set; }
        //added By Chetan M On 27th Mar 2020 For Issue ID 23059
        public string MaxLength { get; internal set; }
        public string MinValue { get; internal set; }
        public string MaxValue { get; internal set; }
        //End Of added By Chetan M On 27th Mar 2020 For Issue ID 23059
        //Added By Nikhil Adkar for showing saved vaue 
        public string SavedValue { get; internal set; }
        public int ProjectId { get; internal set; }
        public int IssueID { get; internal set; }
        //End of Added By Nikhil Adkar
    }
    public class CommonProperty
    {
        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public int EmployeeId { get; set; }
        public string LoginType { get; set; }
        public int LoginId { get; set; }
        public string strMode { get; set; }
        public string DatabaseFieldName { get; internal set; }
        public int IssueID { get; set; }
    }

    public class CopyIssueIDs
    {
        public int issueid { get; set; }
        public string strFieldName { get; set; }
        public object GetValue { get; set; }

    }

    public class UpdateIssueData
    {
        public int issueid { get; set; }
        public object AllData { get; set; }
        public object ExtData { get; set; }
    }

    public class RepotreBY
    {
        public string REP_ID { get; set; }
        public string REP_NAME { get; set; }
        public string EmployeeName { get; set; }
        public int EmployeeID { get; set; }
        public string UserName { get; set; }

    }

    public class ProductField
    {
        public int ProductVersionID { get; set; }
        public string ProductVersion { get; set; }
        public int ComponentID { get; set; }
        public string Component { get; set; }
        public CommonProperty commonProperty { get; set; }
        public int MyProperty { get; set; }
        public bool FildFlag { get; set; }
        public int Customerid { get; set; }

    }

    public class ResultInfo
    {
        public string actionResult { get; set; }
        public bool ResultFlag { get; set; }

    }

    public class ProjectList
    {
        public string ProjectId { get; set; }
        public string ProjectName { get; set; }
        public string ScheduleID { get; set; }
        public string LabelSchedule { get; set; }
        public bool ResultFlag { get; set; }

    }

    /*Added By Swapnagandha to get SLA Details*/
    public class SLADetails
    {
        public string SLAName { get; set; }
        public string NormDate { get; set; }
        public string NormHours { get; set; }
        public string UnitOfNorm { get; set; }
        public string ActualHours { get; set; }
        public string IsMet { get; set; }

    }
    /*End Added By Swapnagandha to get SLA Details*/

}







