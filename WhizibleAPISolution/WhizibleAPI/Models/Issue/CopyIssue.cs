using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Issue
{
    public class CopyIssue
    {
        public List<IssueList> IssueLists { get; set; }
        public List<SubTypeList> SubTypeLists { get; set; }
        public List<ProjectList> ProjectLists { get; set; }
        public List<ResponsiblePerson> EmployeeLists { get; set; }
        public List<IterationList> IterationLists { get; set; }
        public List<UserStoryList> UserStoryLists { get; set; }
        public List<CopyLayoutControl> LayoutControlLists { get; set; }
    }

    public class UserStoryList
    {
        public int IntUserStoryId { get; set; }
        public string StrUserStory { get; set; }
        public bool ResultFlag { get; set; }
    }

    public class IterationList
    {
        public int IntIterationId { get; set; }
        public string StrIterationName { get; set; }
        public bool ResultFlag { get; set; }
    }

    public class IssueList_Copy
    {
        public string StrProjectName { get; set; }
        public string StrResponsible { get; set; }
        public int IntIssueId { get; set; }
        public string StrSummary { get; set; }
        public string StrDescription { get; set; }
        public string StrType { get; set; }
        public string StrSubType { get; set; }
        public string StrStatus { get; set; }
        public string StrPriority { get; set; }
        public string StrSeverity { get; set; }
        public int IntTypeID { get; set; }
        public int IntSubTypeID { get; set; }
        public string StrReportedBy { get; set; }
        public string DtReportedDate { get; set; }
        public string DtReportedTime { get; set; }
        public bool ResultFlag { get; set; }
    }

    public class SubTypeList
    {
        public string strFieldID { get; set; }
        public string strFieldName { get; set; }
        public string strType { get; set; }
        public string StrSubType { get; set; }
        public int subTypeID { get; set; }
        public int TypeStatusID { get; set; }
        public string StrStatus { get; set; }
        public bool ResultFlag { get; set; }
    }

    public class ProjectList_Copy
    {
        public int ProjectID { get; set; }
        public string StrProjectName { get; set; }
        public bool ResultFlag { get; set; }

    }
    public class ResponsiblePerson
    {
        public int ResponsiblePersonID { get; set; }
        public string UserName { get; set; }
        public int EmployeeID { get; set; }
    }


    public class CopyLayoutControl
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


}
