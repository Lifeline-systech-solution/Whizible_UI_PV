using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models
{
    public class WBSNew
    {
        public List<NodeAccessList> NodeAccessLists { get; set; }
    }

    public class WbsParameter
    {
        public int SetBaselineFlag { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public int TagID { get; set; }
        public int MessageID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public int ProjectID { get; set; }
        public string LoginType { get; set; }        
        public string QueryText { get; set; }
        public string UserName { get; set; }
        public string FilterName { get; set; }
        public string CreatedBy { get; set; }
        public int FilterID { get; set; }
        public int Flag { get; set; }
        public int Type { get; set; }
        public int IsActive { get; set; }
        public string strEntityName { get; set; }
        public string CustomFieldName { get; set; }
        public string FieldID { get; set; }
        public object ValidationRule { get; set; }
        public object arrDynamicFields { get; set; }
        public int SubProjectID { get; set; }
        public int ModuleID { get; set; }
        public int PhaseID { get; set; }
        public int MilestoneID { get; set; }
        public string FieldNames { get; set; }
        public string FieldValues { get; set; }
        public string FieldNameValue { get; set; }
        public string WorkHour { get; set; }
        public string WorkMinute { get; set; }
        public string SubProjectCustomFieldsName { get; set; }
        public int UniqueID { get; set; }
        public int TaskFlag { get; set; }
        public int TaskID { get; set; }
        public int ScheduleID { get; set; }
        public string strScheduleID { get; set; }
        public int ScheduleTypeID { get; set; }
        public string SQL { get; set; }
        public string DocumentNo { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Efforts { get; set; }
        public string RevenueReDate { get; set; }
        public string StartTime { get; set; }
        public string CompletionTime { get; set; }
        public int Priority { get; set; }
        public string RequestedBy { get; set; }
        public int Responsible { get; set; }
        public string Status { get; set; }
        public int Billable { get; set; }
        public int OnHold { get; set; }
        public int Void { get; set; }
        public int RevisionNo { get; set; }
        public string BillAmount { get; set; }
        public int TemplateID { get; set; }
        public string Classification { get; set; }
        public int Impact { get; set; }
        public int Approvedby { get; set; }
        public string ReasonOfchanges { get; set; }
        public string ImpactApprovedDate { get; set; }
        public string ImpactDate { get; set; }
        public string Remarks { get; set; }
       // public string FilterID { get; set; }
        public int ImpactApprovedby { get; set; }
        public int IsStausonchange { get; set; }
       // public string WBSFlag { get; set; }
        public string ImpactAnalysisApprovedByCustomer { get; set; }
        public string WBSFlag { get; set; }

        public string m_strPrimaryKeyValue { get; set; }
        public string m_strcomments { get; set; }
        public int WorkFlowInstance;
        public string intUserID { get; set; }
        //public string UserName { get; set; }

    }

    public class WBSWorkFlow
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
        //public int strPrimaryKey { get; set; }
        public int WBSID { get; set; }
        
    }
    public class CustomFiledPloat_SubProject
    {
        public CustomFiledPloat_SubProject()
        {
            Caption = new List<string>();

            Value = new List<string>();
            //IscustomfileAssigned = new List<String>();
            //commonProperty = new CommonProperty_BulkUpdate();
        }


        // public CommonProperty_BulkUpdate commonProperty { get; set; }

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
        public string ControlHeight { get; internal set; }
        public string ControlWidth { get; internal set; }
        
    }

    internal class ValidationData_SubProject
    {
        public string ValidationID { get; internal set; }
        public string ValidationDescription { get; internal set; }
        public string ValidationMessage { get; internal set; }
        public string FieldID { get; internal set; }
        public string FieldName { get; internal set; }
        public string CreatedBy { get; internal set; }
        public string CreatedDate { get; internal set; }
        public int OrderNumber { get; internal set; }
        public int IsComparisonRule { get; internal set; }
    }
    public class NodeAccessList
    {
        public int Add { get; set; }
        public int Delete { get; set; }
        public int Edit { get; set; }
        public int View { get; set; }
    }
    public class CompanyInformation
    {
        public Boolean RestrictByMinHours { get; set; }
        //Commented And Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
        //public float MinHoursForDAEntry { get; set; }
        public string MinHoursForDAEntry { get; set; }
        //End Of Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
    }
    public class QueryList
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
        public string SQL { get; set; }
        public int ControlID { get; set; }
        public string ControlValue { get; set; }
    }

    public class GetCombovalues
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
        public string SQL { get; set; }
        public int ControlID { get; set; }
        public string ControlValue { get; set; }
    }

    
    public class PhaseRequiredData
    {
        //public PhaseRequiredData() {
        //    Phaselist = new List<string>();

        //    OrderNo = new List<string>();
        //}
        public string expectedStartdate { get; set; }
        public string expectedEnddate { get; set; }
        public object PercentageEfforts { get; set; } 
        //public string PhaseRestrictByMinHours { get; set; }
        //public string PhaseMinHoursForDAEntry { get; set; }
        //public List<string> Phaselist { get; set; }
        //public List<string> OrderNo { get; set; }


    }
    //public class PhaseAttribute
    //{
    //   public PhaseAttribute()
    //    {
    //         wbsParamete = new WbsParameter();
    //    }
    //    public int ProjectID { get; set; }
    //    public string Phase { get; set; }
    //    public string EstimatedStartDate { get; set; }
    //    public string EstimatedEndDate { get; set; }
    //    public float PlannedResources { get; set; }
    //    public float PercentEfforts { get; set; }
    //    public bool CurrentPhase { get; set; }
    //    public int ResponsiblePerson { get; set; }
    //    public int ordernumber { get; set; }
    //    public string CreatedBy { get; set; }
    //    public string EstimatedEfforts { get; set; }
    //    public int Flag { get; set; }
    //    public int PhaseId { get; set; }
    //    public WbsParameter wbsParamete { get; set; }



    //}


    public class PhaseAttribute
    {
        public PhaseAttribute()
        {
            wbsParamete = new WbsParameter();
        }
        public int ProjectID { get; set; }
        public string Phase { get; set; }
        public string EstimatedStartDate { get; set; }
        public string EstimatedEndDate { get; set; }
        public float PlannedResources { get; set; }
        public float PercentEfforts { get; set; }
        //Commented & Added By Dipali V On 31st March 2023 For Crash
        //public bool CurrentPhase { get; set; }
        public string CurrentPhase { get; set; }
        //End of Commented & Added By Dipali V On 31st March 2023 For Crash
        public int ResponsiblePerson { get; set; }
        public int ordernumber { get; set; }
        public string CreatedBy { get; set; }
        public string EstimatedEfforts { get; set; }
        public int Flag { get; set; }
        public int PhaseId { get; set; }
        public int SubProjectID { get; set; }
        public int UniqueID { get; set; }
        public WbsParameter wbsParamete { get; set; }

        //Added By Riddhesh Patil on 21st March 2023
        public int TagID { get; set; }
        public int RoleID { get; set; }
        //End of Added By Riddhesh Patil on 21st March 2023
    }

    public class PhaseDocument
    {
        public PhaseDocument()
        {
            wbsParamete = new WbsParameter();
            phaseAttribute = new PhaseAttribute();
        }

        public string Description { get; set; }
        public string Category { get; set; }
        public string SubCategory { get; set; }
        public string FileName { get; set; }
        public string UploadedDate { get; set; }
        public int UniqueID { get; set; }
        public string UploadedBy { get; set; }
        public WbsParameter wbsParamete { get; set; }
        public PhaseAttribute phaseAttribute { get; set; }
        public string DirectoryName { get; set; }
        public string CreatedDate { get; set; }
        public string LastModifiedDate { get; set; }
        public float FileSize { get; set; }
        public string FileExtension { get; set; }
        //public int SubCategoryID { get; set; }
        public string CodeTemplate { get; set; }
        public string CategoryName { get; set; }
        public string SubCategoryName { get; set; }
        public int ProjectID { get; set; }
    }

    public class Document
    {
        public Document()
        {
            WBSParameters = new WbsParameter();

        }

        public string Description { get; set; }
        public int Category { get; set; }
        public int SubCategory { get; set; }
        public string FileName { get; set; }
        public string UploadedDate { get; set; }
        public int UniqueID { get; set; }
        public string UploadedBy { get; set; }
        public WbsParameter WBSParameters { get; set; }
        public string DirectoryName { get; set; }
        public string CreatedDate { get; set; }
        public string LastModifiedDate { get; set; }
        public float FileSize { get; set; }
        public string FileExtension { get; set; }
        public string CodeTemplate { get; set; }
        public string CategoryName { get; set; }
        public string SubCategoryName { get; set; }
        public int ProjectID { get; set; }


    }

    //Added By Usha Pandit On 25.10.2019 for discussion panel
    public class WBSDiscussionsParameter
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
    public class GetWBSDiscussions
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
    //End Of Added By Usha Pandit On 25.10.2019 for discussion panel
}