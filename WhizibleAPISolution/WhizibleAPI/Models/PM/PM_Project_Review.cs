using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Project_Review
{
    public class PM_Project_Review
    {
        public string ReviewStatisticsID { get; set; }
        public string ProjectId { get; set; }
        //[JsonProperty(PropertyName = "Type")]
        public string ReviewType { get; set; }
        public string ProjectPhase { get; set; }
        public string NoOfReviews { get; set; }
        //[JsonProperty(PropertyName = "Work(hrs)")]
        public string ReviewEffort { get; set; }
        public string NoOfDefects { get; set; }

        //[JsonProperty(PropertyName = "Reviewer")]
        public string ReviewedBy { get; set; }
        public string ReviewedDate { get; set; }
        public string ReviewNotes { get; set; }
        public string MeasurementNumber { get; set; }
        public string MeasurementUnit { get; set; }
        //[JsonProperty(PropertyName = "Reviewee")]
        public string Reviewee { get; set; }
        public string CReviewType { get; set; }
        public string CreatedBy { get; set; }
        public string CReviewTypeID { get; set; }
        public string PReviewTypeID { get; set; }
        public string ReviewStatus { get; set; }
        public string IsPlannedReview { get; set; }
        public string WorkProductType { get; set; }
        public string WorkProductName { get; set; }
        public string Conclusion { get; set; }
        public string ModuleID { get; set; }
        public string DeliverableID { get; set; }
        public string DeliverableTypeID { get; set; }
        public string ChecklistTypeId { get; set; }
        public string IssueIds { get; set; }

        //[JsonProperty(PropertyName = "Review Title")]
        public string ReviewTitle { get; set; }
        //[JsonProperty(PropertyName = "From Date")]
        public string ReviewStartDate { get; set; }
        //[JsonProperty(PropertyName = "To Date")]
        public string ReviewEndDate { get; set; }
        public string ActualStartDate { get; set; }
        public string ActualEndDate { get; set; }
        public string IsOfflineReview { get; set; }
        public string IsReviewBillable { get; set; }
        public string ModifiedBy { get; set; }
        public string FastTrackReviewName { get; set; }
        public string UserStoryID { get; set; }
        public string IterationID { get; set; }
        public string ReleaseID { get; set; }
        public string IsCarryForwardedReview { get; set; }
        public string WhatWentWrong { get; set; }
        public string WhatWasRight { get; set; }

        [JsonProperty(PropertyName = "Send Cancellation")]
        public string SendCancellation { get; set; }

        public string SubProjectID { get; set; }
        public string MilestoneID { get; set; }
        public string PhaseID { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string TimeZone { get; set; }
        public string IsSendReviewInvite { get; set; }
        public string SelectedReviewerIDs { get; set; }
        public string SelectedRevieweeIDs { get; set; }

        public int UniqueID { get; set; }
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }
        //added by Vishal M 31-12-2019
        public string IsReviewInviteCancelled { get; set; }
    }

    public class ReviewTypes
    {
        public int PReviewTypeID { get; set; }
        public string PReviewType { get; set; }
        public int CReviewTypeID { get; set; }
        public string CReviewType { get; set; }
        public int ProjectID { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }

    }

    public class Reviwer
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public int ProjectID { get; set; }
    }

    public class Reviwee
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public int ProjectID { get; set; }
    }

    public class Timezone
    {
        public int GMTID { get; set; }
        public string GMTZone { get; set; }
    }

    public class Deliverables
    {
        public int ScheduleID { get; set; }
        public string Title { get; set; }

    }

    public class Modules
    {
        public int ModuleID { get; set; }
        public string ModuleName { get; set; }

    }

    public class SubProjects
    {
        public int SubProjectId { get; set; }
        public string SubProjectName { get; set; }

    }
    public class Milestones
    {
        public int MileStoneID { get; set; }
        public string MileStone { get; set; }

    }

    public class Project_Phases
    {
        public int ProjectPhaseID { get; set; }
        public string Phase { get; set; }

    }

    public class ProjectCheckList
    {
        public string ProjectCheckListID { get; set; }
        public string CheckListShortName { get; set; }
    }

    public class ProductType
    {
        public string WorkProductType { get; set; }
    }

    public class ProjectIteration
    {
        public int IterationID { get; set; }
        public string IterationName { get; set; }
    }

    public class Causes
    {
        public string PReviewCauseID { get; set; }
        public string PReviewCause { get; set; }
        public string CReviewCauseID { get; set; }
        public string CReviewCause { get; set; }
        public string PReviewTypeID { get; set; }
        public string PReviewType { get; set; }
        public string Used { get; set; }
    }

    public class ReviewActions
    {
        public string ReviewActionID { get; set; }
        public string ReviewStatisticsID { get; set; }
        public string ProjectID { get; set; }
        public string PReviewType { get; set; }
        public string CReviewType { get; set; }
        public string PReviewCauseID { get; set; }
        public string CReviewCauseID { get; set; }
        public string Action { get; set; }
        public string IssueID { get; set; }
        public string TaskID { get; set; }
        public string CReviewCause { get; set; }
        public string Reviewee { get; set; }
        public string ReviewObservationID { get; set; }
        public string RevieweeComments { get; set; }
        public string Reference { get; set; }
        public string CreatedBy { get; set; }
        public string TypeOfReview { get; set; }
        public bool ConvertTaskChecked { get; set; }
        public bool ConvertIssueChecked { get; set; }
        public string WorkInHours { get; set; }
        public string ConvertedActionID { get; set; }
        public string TrackToNextReview { get; set; }
        public string Closed { get; set; }
        //Added By Rutuja D.For IssueId = 21074
        public string PReviewCause { get; set; }
        //End Added By Rutuja D. For IssueId = 21074
        //Added By Reshma on 31st Dec 2019 For IssueID-21111
        public string  Type { get; set; }
        public string CorporateType  { get; set; }
        //End Added By Reshma on 31st Dec 2019 For IssueID-21111
    }

    public class Observations
    {
        public int ReviewObservationID { get; set; }
        public string ReviewStatisticsID { get; set; }
        public int ProjectID { get; set; }
        public string PReviewType { get; set; }
        public string CReviewType { get; set; }
        public string Reviewee { get; set; }
        public string Observation { get; set; }
        public string TrackToNextReview { get; set; }
        public int ParentObservationID { get; set; }
        public string Closed { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public int ReviewActionID { get; set; }
        public string RevieweeComments { get; set; }

    }
    public class IB_Issues
    {
        public string IssueID { get; set; }
        public string Summary { get; set; }
        public string Type { get; set; }
        public string Status { get; set; }
    }
    
    public class FillProjectParameters
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }

    //added by Vishal Mahajan 19-11-2019
    public class PM_Project_ReviewParameter
    {
        public int projectID { get; set; }
        public string IsPlannedReview { get; set; }
        public string FilterQuery { get; set; }
    }

    public class QueryList
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
    }

    public class ProjectReviewFilterParameter
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
        public bool IsPlannedReview { get; set; }
    }

    public class ProjectReviewFilterResult
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


    public class ProjectReviews_Advance_filter_parameters
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

    public class ProjectReviews_BasicPage_filter_parameters
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
    //end by Vishal Mahajan 19-11-2019
    public class ExpectedStartEndDates
    {
        public string UserName { get; set; }
        public int EmployeeID { get; set; }
        public DateTime ExpectedStartDate { get; set; }
        public DateTime ExpectedEndDate { get; set; }
    }
    //Added By Chetan M on 4 Dec 2019
    public class ProjectReviewCheckListClass
    {
        public int ReviewStaticID { get; set; }
        public int ProjectID { get; set; }
        public int ChecklistTypeID { get; set; }
        public int ProjectCheckListItemId { get; set; }
        public int ResponseId { get; set; }
        public int NegativeResponseId { get; set; }
        public string UserName { get; set; }
        public string Type { get; set; }
        public string Remarks { get; set; }
        public string IssueType { get; set; }
        public string IssueSubType { get; set; }
        public string CorporateSubType { get; set; }
        public string Staus { get; set; }
        public string CorporateStaus { get; set; }

    }
    //End of addition by Chetan M.

    //Added by Vishal Mahajan 18-12-2019
    public class CheckListIssues
    {
        public string ReviewStatisticsID { get; set; }
        public string IssueID { get; set; }
        public string Summary { get; set; }
        public string Type { get; set; }
        public string Status { get; set; }
        public string IssueIDs { get; set; }
    }

    public class ReviewInviteMailParameter
    {
        public int ProjectID { get; set; }
        //start vishal Mahajan 10-12-2019
        public string LoginID { get; set; }
        //end vishal Mahajan 10-12-2019
        public string ProjectName { get; set; }
        public int MessageID { get; set; }
        public string ReviewStatisticsID { get; set; }
        public string Summary { get; set; }
        public string Location { set; get; }

        public string SenderName { get; set; }
        public string ReviewEffort { get; set; }
        public string ReviewType { get; set; }
        public string WorkProductType { get; set; }
        public string ReviewedBy { get; set; }
        public string Reviewee { get; set; }
        public string ReviewTitle { get; set; }
        public DateTime StartDate { set; get; }
        public DateTime EndDate { set; get; }
        public DateTime strStartDate { set; get; }
        public DateTime strEndDate { set; get; }
        public string ReviewStartDate { get; set; }
        public string ReviewEndDate { get; set; }
        public string OldReviewStartDate { get; set; }
        public string OldReviewEndDate { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string TimeZone { get; set; }

        public string strSubject { set; get; }
        public string strMessage { set; get; }
        public string strToEmailID { get; set; }
        public string strCCToEmailID { get; set; }
        public string strFromEmailID { get; set; }

        public bool IsSendReviewInvite { get; set; }
        public bool IsResendReviewInvite { get; set; }
        public bool ReviewCancellation { get; set; }
        //added by Vishal Mahajan 18-12-2019
        public string GMTZone { get; set; }
    }

    public class PM_Document
    {
        public PM_Document()
        {
            PMParameters = new PM_Project_Review();
        }

        public string Description { get; set; }
        public string Category { get; set; }
        public string SubCategory { get; set; }
        public string FileName { get; set; }
        public string UploadedDate { get; set; }
        public int UniqueID { get; set; }
        public string UploadedBy { get; set; }
        public PM_Project_Review PMParameters { get; set; }
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
    //end by Vishal Mahajan 18-12-2019
}