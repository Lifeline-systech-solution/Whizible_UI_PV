using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class ProjectList
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string ProjectCode { get; set; }
        public int ProjectStatusID { get; set; }
        public string ProjectStatus { get; set; }
        public int OUID { get; set; }
        public string OUName { get; set; }
        public string ExpectedStateDate { get; set; }
        public string ExpectedEndDate { get; set; }
        public string Duration { get; set; }
        public double PercentageCompletion { get; set; }
        public string ProjectType { get; set; }
        public float CostPercentage { get; set; }
        public float SchedulePercentage { get; set; }
        public float EffortPercentage { get; set; }
        public string DraftOrConverted { get; set; }
        public List<ApprovalStatus> lstApprovalStatus { get; set; }
        //Added By Usha Pandit On 13.04.2020 For checking if project is in use or not
        public string ProjectIsInUse { get; set; }
        public string CurrentWFStatus { get; set; } //Added By Dipali V On 7th Oct 2025 For Get WF Current Status
        //End Of Added By Usha Pandit On 13.04.2020 For checking if project is in use or not
    }

    public class ApprovalStatus
    {
        public int StageId { get; set; }
        public string StageName { get; set; }
        public string ApproverName { get; set; }
        public int ApprovalStatusId { get; set; }
    }

    public class ProjectScheduleDetails
    {
        public Int32 ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string ProjectStatus { get; set; }
        public DateTime ExpectedStartDate { get; set; }
        public DateTime ExpectedEndDate { get; set; }
        public string RecordLevel { get; set; }
        public Int32 YearHeader { get; set; }
        public Int32 MonthHeader { get; set; }
    }

    public class ProjectScheduleDetail
    {
        public List<ProjectScheduleDetails> ProjectScheduleDetailList { get; set; }
        public List<ProjectScheduleDetails> ProjectScheduleMilestoneList { get; set; }
        public List<ProjectScheduleDetails> ProjectScheduleReviewList { get; set; }
        public List<ProjectScheduleDetails> ProjectSchedulePhaseList { get; set; }
    }

    public class WorkflowEntityDetail
    {
        public string RequestStage { get; set; }
        public int OrderNo { get; set; } 
        public int IsCurrentStage { get; set; }
        public string ApproverList { get; set; }
        public int IsDelayed { get; set; }
        public string CreatedBy { get; set; }
    }
       
    public class WorkflowApprovalHistory
    {
        public string RequestStage { get; set; }
        public string WorkflowName { get; set; }
        public string EventDate { get; set; }
        public string EventDateTime { get; set; }
        public string ActionType { get; set; }
        public string FromStage { get; set; }
        public string ToStage { get; set; }
        public string UserName { get; set; }
        public string Comments { get; set; }
    }

    public class QueryList
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
    }

    public class PagingInfo
    {
        public int CurrentPage { get; set; }
        public int TotalRecords { get; set; }
        public bool IsNextPage { get; set; } 
    }

    public class ProjectListDetails
    {
        public PagingInfo pagingInfo { get; set; }
        public List<ProjectList> projectList { get; set; }
    }

    public class HealthThreshold
    {
        public float CostThreshold { get; set; }
        public float ScheduleThreshold { get; set; }
        public float EffortThreshold { get; set; }
    }

    public class ProjectHealthThreshold
    {
        public string Item { get; set; }
        public string RedCriteria { get; set; }
        public string AmberCriteria { get; set; }
        public string GreenCriteria { get; set; }
    }
}