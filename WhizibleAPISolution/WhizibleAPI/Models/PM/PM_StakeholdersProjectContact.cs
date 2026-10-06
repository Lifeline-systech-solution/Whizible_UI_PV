using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Stakeholder
{
    public class PM_StakeholdersProjectContact
    {
        public int ProjectContactID { get; set; }
        public string Name { get; set; }
        public bool Status { get; set; }
        public string Designation { get; set; }
        public string ContactInfo { get; set; }
        public string TypeOfContact { get; set; }
        public string ContactCategory { get; set; }
        public string CategoryType { get; set; }
        public int CountofCustomers { get; set; }
        public int CountofOrganization { get; set; }
        public int CountofOthers { get; set; }

        public int ContactCategoryID { get; set; }
        public int TypeOfContactID { get; set; }
        public string ContactType { get; set; }
        public bool IsCorporateContact { get; set; }
        public int SiteID { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string State { get; set; }
        public int CountryID { get; set; }
        public bool CorrespondenceAddress { get; set; }
        public string Phone1 { get; set; }
        public string Phone2 { get; set; }
        public string Ext1 { get; set; }
        public string Ext2 { get; set; }
        public string Fax { get; set; }
        public string Mobile { get; set; }
        public string EmailID { get; set; }
        public string URL { get; set; }
        public bool ActiveStatus { get; set; }
        public int ProjectID { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public int EmployeeID { get; set; }
        public bool PrincipalContact { get; set; }
        public string OrganizationName { get; set; }
        public string Notes { get; set; }
        public int ClientId { get; set; }
        public string InheritedClientID { get; set; }

        //ProjectContactsRIsks
        public int RiskID { get; set; }
        public string RiskName { get; set; }
        public string RiskDescription { get; set; }
        public bool RiskFrom { get; set; }
        //RequiredReports
        public int ReportID { get; set; }
        public int TagID { get; set; }
        public string Frequency { get; set; }
        public string ReportDescription { get; set; }
        public bool LastReminderSentOn { get; set; }


    }

    public class StakeholdersProjectContactParameter
    {
        public int projectID { get; set; }
        public string FilterQuery { get; set; }

    }

    public class StakeholderFilterParameter
    {
        public int TagID { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int FilterID { get; set; }
        public string LoginType { get; set; }
        public string QueryText { get; set; }
        public string UserName { get; set; }
        public string FilterName { get; set; }
        public string CreatedBy { get; set; }
        public int Flag { get; set; }
        public int Type { get; set; }
        public int IsActive { get; set; }
    }

    public class stakeholderFilterResult
    {
        public int FilterID { get; set; }
        public int QueryID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }
        public string FilterName { get; set; }
        public string FilterQuery { get; set; }
        public bool IsBasicFilter { get; set; }
        public string UserFriendlyFilterQuery { get; set; }
        public bool IsDatabaseFilter { get; set; }

        public bool defaultQuery { get; set; }
    }

    public class StakeholdersContactCategory
    {
        public int ContactCategoryID { get; set; }
        public string ContactCategory { get; set; }
    }

    public class StakeholdersTypeOfContact
    {
        public int TypeOfContactID { get; set; }
        public string TypeOfContact { get; set; }
    }

    public class Stakeholders_Advance_filter_parameters
    {
        public string FilterID { get; set; }
        public string UserID { get; set; }
        public string LoginType { get; set; }
        public string TagID { get; set; }
        public string FilterName { get; set; }
        public string FilterQuery { get; set; }
        public string IsBasicFilter { get; set; }
        public string ActualFilterQuery { get; set; }
        public string IsDatabaseFilter { get; set; }


        public string QuiryID { get; set; }
        public string ProjectID { get; set; }
    }

    public class Stakeholders_BasicPage_filter_parameters
    {

        public string FilterID { get; set; }
        public string UsrID { get; set; }
        public string TagID { get; set; }
        public string ControlName { get; set; }
        public string Value { get; set; }
        public string OperatorName { get; set; }
        public string OperatorValue { get; set; }
        public string LoginType { get; set; }
    }

    public class AdvanceFilterResults
    {

        public int QueryID { get; set; }
        public int ProjectID { get; set; }

        public int FilterID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }
        public int TagID { get; set; }
        public string FilterName { get; set; }
        public string FilterQuery { get; set; }

    }

    public class basicFilterResult
    {
        public string ControlName { get; set; }
        public string Value { get; set; }
        public string LoginType { get; set; }
    }

    public class basicFilterparamerter
    {
        public string FilterId { get; set; }

        public string UserId { get; set; }
    }

    public class defaultFilterParameters
    {
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int QueryID { get; set; }
        public string LoginType { get; set; }
        public int EmployeeID { get; set; }

    }

    public class typeOfContactParameters
    {
        public int ProjectContactID { get; set; }
        public int GroupID { get; set; }
    }

    public class TypeOfContactResult
    {
        public int TypeOfContactID { get; set; }
        public string TypeOfContact { get; set; }
    }


    public class Stakeholders
    {
        public int ProjectContactID { get; set; }
        public int ContactCategoryID { get; set; }
        public string Name { get; set; }
        public string CustomerName { get; set; }
        public string Designation { get; set; }
        public int TypeOfContactID { get; set; }
        public string ContactType { get; set; }
        public string IsCorporateContact { get; set; }
        public string SiteID { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string State { get; set; }
        public string CountryID { get; set; }
        public string CorrespondenceAddress { get; set; }
        public string Phone1 { get; set; }
        public string Phone2 { get; set; }
        public string Ext1 { get; set; }
        public string Ext2 { get; set; }
        public string Fax { get; set; }
        public string Mobile { get; set; }
        public string EmailID { get; set; }
        public string URL { get; set; }
        public string ActiveStatus { get; set; }
        public string ProjectID { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public string EmployeeID { get; set; }
        public string PrincipalContact { get; set; }
        public string OrganizationName { get; set; }
        public string Notes { get; set; }
        public string ClientId { get; set; }
        public string InheritedClientID { get; set; }

    }

    public class OrganizationResult
    {
        public int EmployeeId { get; set; }
        public string EmployeeName { get; set; }
    }

    public class ClientResult
    {
        public int ClientId { get; set; }
        public string ClientName { get; set; }
    }

    public class AdvanceFilterSelectFiledResult
    {
        public string ControlName { get; set; }
        public int ControlTypeID { get; set; }
        public string ControlCaption { get; set; }
    }

    public class AdvanceFilterCheckboxResult
    {
        public int ActVal { get; set; }
        public string ChkVal { get; set; }
    }

    public class AdvanceFilterOperationResult
    {
        public string value { get; set; }
    }

    //public class SaveStakeholderAttachmentsparam
    //{
    //    public int ProjectID { get; set; }
    //    public int AttachmentID { get; set; }
    //    public string OrignalFileName { get; set; }
    //    public string SystemFileName { get; set; }
    //    public string AttachedBy { get; set; }
    //    public string LoginType { get; set; }
    //    public string DateAttached { get; set; }
    //    public string Description { get; set; }      
    //    public int ConversationID { get; set; }


    //}

    public class StakeholdersProjectContactSaveParam
    {
        public int ProjectContactID { get; set; }
        public int ContactCategoryID { get; set; }
        public string Name { get; set; }
        public string Designation { get; set; }
        public int TypeOfContactID { get; set; }
        public string ContactType { get; set; }
        public bool IsCorporateContact { get; set; }
        public int SiteID { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string State { get; set; }
        public int CountryID { get; set; }
        public bool CorrespondenceAddress { get; set; }
        public string Phone1 { get; set; }
        public string Phone2 { get; set; }
        public string Ext1 { get; set; }
        public string Ext2 { get; set; }
        public string Fax { get; set; }
        public string Mobile { get; set; }
        public string EmailID { get; set; }
        public string URL { get; set; }
        public bool ActiveStatus { get; set; }
        public int ProjectID { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public int EmployeeID { get; set; }
        public bool PrincipalContact { get; set; }
        public string OrganizationName { get; set; }
        public string Notes { get; set; }
        public int ClientId { get; set; }


        public List<int> ReportTagID { get; set; }
        public List<string> Frequency { get; set; }
        public List<string> ReportDescription { get; set; }

        public List<string> RiskName { get; set; }
        public List<string> RiskDescription { get; set; }
        public List<string> RiskFrom { get; set; }

    }

    public class DeleteStakeHolderParams
    {
        public int ProjectContactID { get; set; }
    }

    public class DeleteStakeHolderAttachment
    {
        public int AttachmentID { get; set; }
    }

    public class RoleAccess
    {
        public string RoleID { get; set; }
        public string TagID { get; set; }
        public string AddRole { get; set; }
        public string EditRole { get; set; }
        public string DeleteRole { get; set; }
        public string ViewRole { get; set; }
    }

    public class FillProjectParameters
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }

    public class StakeholdersProjectContactExportParameter
    {
        public int projectID { get; set; }
        public string ReportFilterQuery { get; set; }
        public string ReportFormat { get; set; }

    }

    public class StakeholdersAttachment
    {
        public int AttachmentID { get; set; }
        public int ProjectContactID { get; set; }
        public string OrignalFileName { get; set; }
        public string SystemFileName { get; set; }
        public string AttachedBy { get; set; }
        public string LoginType { get; set; }
        public string DateAttached { get; set; }
        public string Description { get; set; }
        public int ProjectID { get; set; }
        public int ConversationID { get; set; }
        public string FileSize { get; set; }
    }

    public class AttachedFileData
    {
        public int ProjectID { get; set; }
        public string Description { get; set; }
        public DateTime DateAttached { get; set; }
        public string LoginType { get; set; }
        public string UserName { get; set; }
        public int ProjectContactID { get; set; }
    }

    public class StakeholderEmployeeDetails
    {
        public int EmployeeID { get; set; }
        public string DesignationName { get; set; }
        public string Phone { get; set; }
        public string CurrentPhone { get; set; }
        public string ExtensionNo { get; set; }
        public string MobileNumber { get; set; }
        public string EmailID { get; set; }
        public string Address { get; set; }
        public string CurrentAddress { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PinCode { get; set; }
        public string Country { get; set; }

    }

    public class Conversations
    {
        public string ConversationID { get; set; }
        public string ProjectContactID { get; set; }
        public string ParentConversationID { get; set; }
        public string Description { get; set; }
        public string PostedBy { get; set; }
        public string PostedDate { get; set; }
        public string initials { get; set; }
        public List<subConversations> listSubConversations { get; set; }
        public Conversations()
        {
            listSubConversations = new List<subConversations>();
        }
    }


    public class subConversations
    {
        public string ConversationID { get; set; }
        public string ProjectContactID { get; set; }
        public string ParentConversationID { get; set; }
        public string Description { get; set; }
        public string PostedBy { get; set; }
        public string PostedDate { get; set; }
        public string initials { get; set; }

    }

    public class StakeholdersCommentSaveParam
    {
        public int ProjectContactID { get; set; }
        public int ParentConversationID { get; set; }
        public string Description { get; set; }
        public string UserName { get; set; }
        public int postedID { get; set; }
    }

    public class DuplicateStakeHolderName
    {
        public int ProjectContactID { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public string Name { get; set; }
    }

    public class CheckPrincipleContactParam
    {
        public int ProjectContactID { get; set; }
        public int ProjectID { get; set; }
        public int TypeOfContactID { get; set; }
    }

    public class OrganizationStakeHolderName
    {
        public int ProjectContactID { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public string Name { get; set; }
    }

    public class CustomerStakeHolderName
    {
        public string CustomerName { get; set; }
    }

    public class QueryList
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
    }

    public class StakeholderEmployeeOrCustomerDetails
    {
        public int EmployeeID { get; set; }
        public int ProjectID { get; set; }
        public bool IsEmployeeID { get; set; }
        public string DesignationName { get; set; }
        public string Phone { get; set; }
        public string CurrentPhone { get; set; }
        public string ExtensionNo { get; set; }
        public string MobileNo { get; set; }
        public string Country { get; set; }
        public string Fax { get; set; }
        public string EmailID { get; set; }
        public string Address { get; set; }
        public string CurrentAddress { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PinCode { get; set; }
    }

    public class StakeholderRiskDetails
    {
        public int RiskID { get; set; }
        public int ProjectContactID { get; set; }
        public string RiskName { get; set; }
        public string RiskDescription { get; set; }
        public bool RiskFrom { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
    }

    public class StakeholderRequiredReports
    {
        public int ReportID { get; set; }
        public string ReportTitle { get; set; }
        public int ProjectContactID { get; set; }
        public int TagID { get; set; }
        public string Frequency { get; set; }
        public string ReportDescription { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public bool IsInheritedClientID { get; set; }
        public int ProjectID { get; set; }
    }

    public class StakeholderFrequency
    {
        public string Frequency { get; set; }
    }


    public class StakeholderReportTagMaster
    {
        public int TagID { get; set; }
        public string ReportTitle { get; set; }
    }

    //Added By Usha Pandit On 04.11.2019 for discussion panel
    public class DiscussionsParameter
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
    }
    public class GetDiscussions
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
    }
    //End Of Added By Usha Pandit On 04.11.2019 for discussion panel

    public class TokenParameter
    {
        public int TagID { get; set; }
        public int DocumnetID { get; set; }
        public int StakeHolderID { get; set; }
        public int ProjectID { get; set; }
    }

    public class StakeholdersProjectContactSaveParamForClient
    {
        public int ProjectContactID { get; set; }
        public string ClientIDs { get; set; }
        public int ProjectID { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
    }
}