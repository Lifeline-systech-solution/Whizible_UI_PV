using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Issue
{
    public class BulkUpdate
    {
        public List<GetSelectedQuery> IssueLists { get; set; }

    }
    public class GetSelectedQuery
    {
        public int ProjectId { get; set; }
        public String QueryID { get; set; }
        public int IssueID { get; set; }
        public String QueryName { get; set; }
        public String Summary { get; set; }
        public String Description { get; set; }
        public String Type { get; set; }
        public String Subtype { get; set; }
        public String Status { get; set; }
        public String Priority { get; set; }
        public String Severity { get; set; }
        public String QueryText { get; set; }
        public String ReportedDate { get; set; }
        public String StartDate { get; set; }
        public String EndDate { get; set; }
        public String DueDate { get; set; }
        public int EmployeeID { get; set; }
    }

    public class IssueLayOutcontrol_BulkUpdate
    {

        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public string FieldID { get; set; }
        public string FieldName { get; set; }
        public string Type { get; set; }
        public int ReleaseID { get; set; }
        public string ReleaseName { get; set; }
        public int IterationID { get; set; }
        public string IterationName { get; set; }
        public int UserStoryID { get; set; }
        public string UserStoryName { get; set; }
        public CommonProperty commonProperty { get; set; }
        public string ReleaseFromProject { get; set; }//module componet
        public int ComponentID { get; set; }
        public string Component { get; set; }
        public int ScheduleID { get; set; }//Deliverable
        public string LabelSchedule { get; set; }
        public int ChangeRequestID { get; set; }
        public string ChangeRequestSummary { get; set; }
        public string Title { get; set; }
        public bool ResultFlag { get; set; }
        public string SubType { get; set; }
        public int SubTypeID { get; set; }
        public int StatusID { get; set; }
        public string Status { get; set; }

    }

    public class LayoutControl_BulkUpdate
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

    public class CustomFiledPloat_BulkUpdate
    {
        public CustomFiledPloat_BulkUpdate()
        {
            Caption = new List<string>();

            Value = new List<string>();
            //IscustomfileAssigned = new List<String>();
            commonProperty = new CommonProperty_BulkUpdate();
        }


        public CommonProperty_BulkUpdate commonProperty { get; set; }

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
        public object CustomFieldName { get; set; }
        public object CustomValidation { get; set; }
        public string FieldName { get; internal set; }
        public string CustomFieldID { get; internal set; }
        public string DefaultValue { get; internal set; }
        public string DefaultType { get; internal set; }
        public string MaxLength { get; internal set; }
        public string MinValue { get; internal set; }
        public string MaxValue { get; internal set; }
        public string ProjectId { get; set; }
        public string Mandatory { get; set; }

    }


    public class CommonProperty_BulkUpdate
    {
        public int ProjectId { get; set; }
        public int RoleId { get; set; }
        public int EmployeeId { get; set; }
        public string LoginType { get; set; }
        public int LoginId { get; set; }
        public string strMode { get; set; }

    }

    public class BulkUpdateProperty
    {
        public string IssueID { get; set; }
        public int QueryID { get; set; }
        public int ProjectId { get; set; }
        public string UserName { get; set; }
        public int RoleId { get; set; }
        public string strUpdateSQL { get; set; }
    }



}