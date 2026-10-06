using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace WhizibleAPI.Models.Issue
{
    public class IB_Add_Issue
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
    public class LayoutControl_NewIssue
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
        //Added By Dipali V On 6th April 2023 For Check Mandatory Flag
        public string MandatoryInEdit { get; set; }
        public string MandatoryInAdd { get; set; }
        //End of Added By Dipali V On 6th April 2023 For Check Mandatory Flag

    }
    public class LayoutFlag_NewIssue
    {
        public bool layoutProjectFlag { get; set; }

    }

    public class UploadFileParameter
    {
        public string issueid { get; set; }
        public string EmployeeId { get; set; }
        public string DocumentTypeID { get; set; }
        public string DocumentSubTypeID { get; set; }
        public string LoginType { get; set; }
        public string NewFileName { get; set; }
        public string oldFileName { get; set; }
        public string comment { get; set; }
        public string DiscussionID { get; set; }
    }
    public class newIssueLayOutcontrol_NewIssue
    {

        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public string FieldID { get; set; }
        public string FieldName { get; set; }
        public string Type { get; set; }
        public int ReleaseID { get; set; }
        public string ReleaseName { get; set; }
        public string Mode { get; set; }
        //Commented Added By Dipali V On 3rd April 2023 For Model Ref
        //public CommonProperty_NewIssue commonProperty { get; set; }
        public CommonProperty_IssueNew commonProperty { get; set; }
        //End of Commented Added By Dipali V On 3rd April 2023 For Model Ref
        public string ReleaseFromProject { get; set; }//module componet
        public int ComponentID { get; set; }
        public string Component { get; set; }
        public int ScheduleID { get; set; }//Deliverable
        public string LabelSchedule { get; set; }
        public int ChangeRequestID { get; set; }
        public string ChangeRequestSummary { get; set; }
        public string Title { get; set; }
        public bool ResultFlag { get; set; }
    }
    public class CustomFiledPloat_NewIssue
    {
        public CustomFiledPloat_NewIssue()
        {
            Caption_NewIssue = new List<string>();
            DatabaseFieldName_NewIssue = new List<string>();
            Value_NewIssue = new List<string>();
            IscustomfileAssigned_NewIssue = new List<bool>();
            //Commented Added By Dipali V On 3rd April 2023 For Model Ref
            //commonProperty_NewIssue = new CommonProperty_NewIssue();
            commonProperty_NewIssue = new CommonProperty_IssueNew();
            //End of Commented Added By Dipali V On 3rd April 2023 For Model Ref
        }
        //  public int ProjectId { get; set; }
        //Commented Added By Dipali V On 3rd April 2023 For Model Ref
        //public CommonProperty_NewIssue commonProperty_NewIssue { get; set; }
        public CommonProperty_IssueNew commonProperty_NewIssue { get; set; }
        //End of Commented Added By Dipali V On 3rd April 2023 For Model Ref
        // public string [] Caption { get; set; }
        public List<string> Caption_NewIssue { get; set; }
        public List<bool> IscustomfileAssigned_NewIssue { get; set; }
        public string Type { get; set; }
        public List<string> DatabaseFieldName_NewIssue { get; set; }
        public List<string> Value_NewIssue { get; set; }
    }
    //Commented Added By Dipali V On 3rd April 2023 For Model Ref
    public class CommonProperty_IssueNew
    {
        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public int EmployeeId { get; set; }
        public string LoginType { get; set; }
        public int LoginId { get; set; }
        public string strMode { get; set; }
       // public bool FildFlag { get; set; }
        public int FildFlag { get; set; }
        public int Customerid { get; set; }
        public string Type { get; set; }
        public int ProductVersionID { get; set; }


    }

    //public class CommonProperty_NewIssue
    //{
    //    public int ProjectId { get; set; }
    //    public int RoleId { get; set; }
    //    public int EmployeeId { get; set; }
    //    public string LoginType { get; set; }
    //    public int LoginId { get; set; }
    //    public string strMode { get; set; }
    //    // public bool FildFlag { get; set; }
    //    public int FildFlag { get; set; }
    //    public int Customerid { get; set; }
    //    public string Type { get; set; }


    //}
    //End of Commented Added By Dipali V On 3rd April 2023 For Model Ref
    public class CopyIssueIDs_NewIssue
    {
        public int issueid { get; set; }
        public string strFieldName { get; set; }
        public object GetValue { get; set; }

    }

    public class RepotreBY_NewIssue
    {
        public string REP_ID { get; set; }
        public string REP_NAME { get; set; }
        public string EmployeeName { get; set; }
        public int EmployeeID { get; set; }
        public string UserName { get; set; }

    }

    public class ProductField_NewIssue
    {
        public int ProductVersionID { get; set; }
        public string ProductVersion { get; set; }
        public int ComponentID { get; set; }
        public string Component { get; set; }
        //Commented Added By Dipali V On 3rd April 2023 For Model Ref
        //public CommonProperty_NewIssue commonProperty { get; set; }
        public CommonProperty_IssueNew commonProperty { get; set; }
        //End of Commented Added By Dipali V On 3rd April 2023 For Model Ref
        public int MyProperty { get; set; }
        public bool FildFlag { get; set; }
        public int Customerid { get; set; }
        public bool flag { get; set; }

    }

    public class ResultInfo_NewIssue
    {
        public string actionResult { get; set; }
        public bool ResultFlag { get; set; }

    }

    public class CustomFiledPloat1_NewIssue
    {
        public CustomFiledPloat1_NewIssue()
        {
            Caption = new List<string>();

            Value = new List<string>();
            //IscustomfileAssigned = new List<String>();
            //Commented Added By Dipali V On 3rd April 2023 For Model Ref
            //commonProperty = new CommonProperty_NewIssue();
            commonProperty = new CommonProperty_IssueNew();
            //End of Commented Added By Dipali V On 3rd April 2023 For Model Ref
        }



        public int ProjectId { get; set; }
        //Commented Added By Dipali V On 3rd April 2023 For Model Ref
        //public CommonProperty_NewIssue commonProperty { get; set; }
        public CommonProperty_IssueNew commonProperty { get; set; }
        //End of Commented Added By Dipali V On 3rd April 2023 For Model Ref
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
        public object DefaultValue { get; internal set; }
        //added By Chetan M On 27th Mar 2020 For Issue ID 23059
        public string MaxLength { get; internal set; }
        public string MinValue { get; internal set; }
        public string MaxValue { get; internal set; }
        //End Of added By Chetan M On 27th Mar 2020 For Issue ID 23059

        //Added by imran on 14-02-2022 for set Default value or static value
        public string DefaultType { get; internal set; }
        //End by imran on 14-02-2022 for set Default value or static value
    }

    public class IterationList_NewIssue
    {
        public int IntIterationId { get; set; }
        public string StrIterationName { get; set; }
    }
    public class UserStoryList_NewIssue
    {
        public int IntUserStoryId { get; set; }
        public string StrUserStory { get; set; }
    }
    public class Parameter_NewIssue
    {
        public int intProjectID { get; set; }
        public int intUserID { get; set; }
        public int intRoleID { get; set; }
        public string StrProjectName { get; set; }
        public string StrResponsible { get; set; }
        public int IntIssueId { get; set; }
        public string StrSummary { get; set; }
        public string StrDescription { get; set; }
        public string strType { get; set; }
        public string StrSubType { get; set; }
        public string StrStatus { get; set; }
        public string StrPriority { get; set; }
        public string StrSeverity { get; set; }
        public int IntTypeID { get; set; }
        public int IntSubTypeID { get; set; }
        public string StrReportedBy { get; set; }
        public string DtReportedDate { get; set; }
        public string DtReportedTime { get; set; }
        public string strLoginType { get; set; }
        public int intLayOutID { get; set; }
        public int intReleaseID { get; set; }
        public int intIterationID { get; set; }

    }
    public class ParameterDeafultValue {
        public string ProjectId { get; set; }
        public string Type { get; set; }


    }
    public class ParameterGetDefaultTaskType
    {
        public string ProjectId { get; set; }
        public string IssueID { get; set; }

    }
    public class ParameterGetTaskTypesAddNew 
    { 
        public string ProjectId { get; set; }
        public string Data { get; set; }


    }
    public class ParameterGetResources 
    { 
        public string ProjectId { get; set; }
        public string Typeproject { get; set; }
        public string LoginType { get; set; }
        public string IssueID { get; set; }


    }
    public class MailData_NewIssue
    {
        public string From { get; set; }
        public string To { get; set; }
        public string CC { get; set; }
        public string Subject { get; set; }
        public string Message { get; set; }
        public string Responsible { get; set; }
        public string SenderName { get; set; }
        public int UserId { get; set; }
        public int RoleId { get; set; }
        public string Summary { get; set; }
        public string ProjectName { get; set; }
        public string IssueId { get; set; }
        public string Type { get; set; }
        public string Description { get; set; }
        public string EmployeeId { get; set; }
        public int ProjectId { get; set; }
        public int CodeBy { get; set; }
        public bool SendMail { get; set; }
        public bool ShowPopup { get; set; }

    }

    //public class UploadFileParameter
    //{
    //    public string issueid { get; set; }
    //    public string EmployeeId { get; set; }
    //    public string DocumentTypeID { get; set; }
    //    public string DocumentSubTypeID { get; set; }
    //    public string LoginType { get; set; }
    //    public string NewFileName { get; set; }
    //    public string oldFileName { get; set; }
    //    public string comment { get; set; }
    //    public string DiscussionID { get; set; }
    //}

    //public class Release
    //{
    //    public int issueID { get; set; }
    //    public string Summary { get; set; }
    //}
}