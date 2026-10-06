using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Issue
{
    //public class Issue
    //{
    //    public List<ProjectFilter> ProjectFilterLists { get; set; }
    //    public List<HeaderColumn> headerColumns { get; set; }
    //}

    public class ProjectFilter
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }
    public class SearchOption
    {
        public string Id { get; set; }
        public string Value { get; set; }
    }
    public class HeaderColumn
    {
        public string ColumnName { get; set; }
    }
    public class IssueList
    {
        public long IssueId { get; set; }
    }
    public class ViewDetails
    {
        public int ViewId { get; set; }
        public string ViewName { get; set; }
        public string FieldList { get; set; }
        public string UserFriendlyNameList { get; set; }
        public string OrderBy { get; set; }
    }
    public class ViewList
    {
        public int ViewId { get; set; }
        public string ViewName { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public string Fields { get; set; }
        public string SortBy { get; set; }
        public string CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public int DefaultViewId { get; set; }
        public string ViewType { get; set; }
    }
    public class ProjectViewFieldList
    {
        public string FieldID { get; set; }
        public string FieldName { get; set; }
        public string ActualFieldName { get; set; }
        public bool IsCustomField { get; set; }
    }
    public class QueryList
    {
        public int QueryID {get;set;}
        public string QueryName { get; set; }
        public string QueryText { get; set; }
        public string QueryType { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public String CreatedDate { get; set; }
        public bool IsDefault { get; set; }
    }
    public class QueryField
    {
        public string FieldID { get; set; }
        public string FieldName { get; set; }
    }
    public class Operator
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }
    public class FilterControl
    {
        public string Type { get; set; }
        public List<ControlCombo> lstControlCombo { get; set; }
        //public string Textbox { get; set; }
    }
    public class SearchOptionControl
    {
        public string Type { get; set; }
        public List<ControlCombo> lstControlCombo { get; set; }
        //public string Textbox { get; set; }
    }
    public class ControlCombo
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }
    //Added by Swapnagandha K.
    public class Tracking
    {
        public int UniqueID { get; set; }
        public int EmployeeID { get; set; }
        public string ContextType { get; set; }
        public int ContextID { get; set; }
        public String DueDate { get; set; }
        public string FlagTo { get; set; }
        public int IsComplete { get; set; }
    }
}