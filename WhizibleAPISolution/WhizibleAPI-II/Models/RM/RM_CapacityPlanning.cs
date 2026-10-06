using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_CapacityPlanning
    {

    }

    public class RM_CapacityPlanning_Header
    {
        public decimal TotalStrength { get; set; }
        public decimal Allocated { get; set; }
        public decimal Bench { get; set; }
        public decimal ProjectRequests { get; set; }
        public string SummaryCost { get; set; }
        public string ForecastRevenue { get; set; }
        public string Currency { get; set; }
    }

    public class RM_CapacityPlannings
    {
        public int RoleID { get; set; }
        public string RoleDescription { get; set; }
        //public List<string> CpMonthHeader { get; set; }

        public List<RM_CpQuarterMonths> Cp_list { get; set; }
        public List<RM_CpMonthWeeks> Cp_list_Weeks { get; set; }
       

        public List<RM_CpQuarterRoleMonthsSummary> Cp_listSummary { get; set; }
        public List<RM_CpMonthWeeksSummary> Cp_WeeklistSummary { get; set; }
    }
    public class RM_CpQuarterMonths : CPQRoleMonths
    {
        public int RoleID { get; set; }
        public string RoleDescription { get; set; }

    }

     public class RM_CpMonthWeeks : CPQRoleWeeks
    {
        public int RoleID { get; set; }
        public string RoleDescription { get; set; }

    }

   

    public class RM_CapacityPlanningsSkill
    {
        public int ToolID { get; set; }
        public string Description { get; set; }
        //public List<string> CpMonthHeader { get; set; }

        public List<RM_CpQuarterMonthsSkill> Cp_Skilllist { get; set; }
        public List<RM_CpSkillMonthWeeks> Cp_list_Skill_Weeks { get; set; }
        //public List<RM_CpQuarterMonthsSummary> Cp_listSummarySkill { get; set; }
    }
    

    public class RM_CpQuarterMonthsSkill : CPQRoleMonths
    {
        public int ToolID { get; set; }
        public string Description { get; set; }

    }
      public class RM_CpSkillMonthWeeks : CPQRoleWeeks
    {
        public int ToolID { get; set; }
        public string Description { get; set; }

    }

    public class CPQRoleMonths
    {
        public string Name { get; set; }
        public decimal Month_1 { get; set; }
        public decimal Month_2 { get; set; }
        public decimal Month_3 { get; set; }
        public decimal Month_4 { get; set; }
        public decimal Month_5 { get; set; }
        public decimal Month_6 { get; set; }
        public decimal Month_7 { get; set; }
        public decimal Month_8 { get; set; }
        public decimal Month_9 { get; set; }
        public decimal Month_10 { get; set; }
        public decimal Month_11 { get; set; }
        public decimal Month_12 { get; set; }
    }

    /// <summary>
    /// Used for headr of quarter 
    /// </summary>
    class RM_CpQuarterMonthHeader
    {
        public int Month { get; set; }
        public string Name { get; set; }
        public string Year { get; set; }
        public string Quarter { get; set; }
        public DateTime MonthDate { get; set; }
    }

    public class RM_CpMonthHeader
    {
         public int WkRowNo { get; set; }
         public int WkYear { get; set; }
         public int WkMonth { get; set; }
         public string WkMonthName { get; set; }
         public int WkOfMonth { get; set; }
         public int WkNo { get; set; }
         public DateTime WkStartDate { get; set; }
         public DateTime WkEndDate { get; set; }
    }
    



    public class RM_CpQuarterRoleMonthsSummary : RM_CpSummaryMonths
    {
        public int RoleID { get; set; }
        public string RoleDescription { get; set; }
      
       
    }

    public class RM_CP_SurplusDeficit
    {
        public decimal CurrentTotal { get; set; }
        public decimal FutureTotal { get; set; }
        public decimal SurplusDeficit { get; set; }
    }

    public class SrDfCurrentTotal
    {
        public decimal CurrentTotal_1 { get; set; }
        public decimal CurrentTotal_2 { get; set; }
        public decimal CurrentTotal_3 { get; set; }
        public decimal CurrentTotal_4 { get; set; }
        public decimal CurrentTotal_5 { get; set; }
        public decimal CurrentTotal_6 { get; set; }
        public decimal CurrentTotal_7 { get; set; }
        public decimal CurrentTotal_8 { get; set; }
        public decimal CurrentTotal_9 { get; set; }
        public decimal CurrentTotal_10 { get; set; }
        public decimal CurrentTotal_11 { get; set; }
        public decimal CurrentTotal_12 { get; set; }
        public decimal CurrentTotal_13 { get; set; }
        public decimal CurrentTotal_14 { get; set; }
        public decimal CurrentTotal_15 { get; set; }
    }

    public class SrDfFutureTotal
    {
        public decimal FutureTotal_1 { get; set; }
        public decimal FutureTotal_2 { get; set; }
        public decimal FutureTotal_3 { get; set; }
        public decimal FutureTotal_4 { get; set; }
        public decimal FutureTotal_5 { get; set; }
        public decimal FutureTotal_6 { get; set; }
        public decimal FutureTotal_7 { get; set; }
        public decimal FutureTotal_8 { get; set; }
        public decimal FutureTotal_9 { get; set; }
        public decimal FutureTotal_10 { get; set; }
        public decimal FutureTotal_11 { get; set; }
        public decimal FutureTotal_12 { get; set; }
        public decimal FutureTotal_13 { get; set; }
        public decimal FutureTotal_14 { get; set; }
        public decimal FutureTotal_15 { get; set; }
    }

     public class SurplusDeficit
    {
        public decimal SurplusDeficit_1 { get; set; }
        public decimal SurplusDeficit_2 { get; set; }
        public decimal SurplusDeficit_3 { get; set; }
        public decimal SurplusDeficit_4 { get; set; }
        public decimal SurplusDeficit_5 { get; set; }
        public decimal SurplusDeficit_6 { get; set; }
        public decimal SurplusDeficit_7 { get; set; }
        public decimal SurplusDeficit_8 { get; set; }
        public decimal SurplusDeficit_9 { get; set; }
        public decimal SurplusDeficit_10 { get; set; }
        public decimal SurplusDeficit_11 { get; set; }
        public decimal SurplusDeficit_12 { get; set; }
        public decimal SurplusDeficit_13 { get; set; }
        public decimal SurplusDeficit_14 { get; set; }
        public decimal SurplusDeficit_15 { get; set; }
    }

    public class SurplusDeficit_Month
    {
        public SrDfCurrentTotal CurrentTotalMonth { get; set; }
        public SrDfFutureTotal FutureTotalMonth { get; set; }
    }

     public class RM_CpMonthWeeksSummary: RM_CpSummaryWeeks
    {
        public int RoleID { get; set; }
        public string RoleDescription { get; set; }
       
    }

      public class RM_CpMonthWeeksSkillSummary: RM_CpSummaryWeeks
    {
        public int ToolID { get; set; }
        public string Description { get; set; }
       
    }
    public class RM_CpQuarterSkillMonthsSummary : RM_CpSummaryMonths
    {
        public int ToolID { get; set; }
        public string Description { get; set; }

    }


    public class RM_CpSummaryMonths
    {
        public string Name { get; set; }
        public decimal Month_1Sum { get; set; }
        public decimal Month_2Sum { get; set; }
        public decimal Month_3Sum { get; set; }
        public decimal Month_4Sum { get; set; }
        public decimal Month_5Sum { get; set; }
        public decimal Month_6Sum { get; set; }
        public decimal Month_7Sum { get; set; }
        public decimal Month_8Sum { get; set; }
        public decimal Month_9Sum { get; set; }
        public decimal Month_10Sum { get; set; }
        public decimal Month_11Sum { get; set; }
        public decimal Month_12Sum { get; set; }
    }

    public class RM_CpSummaryWeeks
    {
        public string Name { get; set; }
        public decimal Week_1Sum { get; set; }
        public decimal Week_2Sum { get; set; }
        public decimal Week_3Sum { get; set; }
        public decimal Week_4Sum { get; set; }
        public decimal Week_5Sum { get; set; }
        public decimal Week_6Sum { get; set; }
        public decimal Week_7Sum { get; set; }
        public decimal Week_8Sum { get; set; }
        public decimal Week_9Sum { get; set; }
        public decimal Week_10Sum { get; set; }
        public decimal Week_11Sum { get; set; }
        public decimal Week_12Sum { get; set; }
        public decimal Week_13Sum { get; set; }
        public decimal Week_14Sum { get; set; }
        public decimal Week_15Sum { get; set; }
    }

    public class RM_ProjectRequestToolTip
    {
        public string ProjectName { get; set; }
        public string RoleDescription { get; set; }
        public int NoOfResources { get; set; }
        public Double ProjectCost { get; set; }
    }

    public class ProjectRequestToolTip
    {
       public  List<RM_ProjectRequestToolTip> ProjectRequestToolTipList { get; set; }
       public Double TotalProjectCost { get; set; }
       public int TotalNoOfResources { get; set; }
        public string RoleDescription { get; set; }
    }

    public class CapacityPlanning_Params
    {
         public int RoleID { get; set; }
         public int SkillID { get; set; }
         public int UserID { get; set; }
        //Commented & Added By Dipali V On 30th March 2023 For Crash Issue
        //public string StartDate { get; set; }
        //public string EndDate { get; set; }


        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        //End of Commented & Added By Dipali V On 30th March 2023 For Crash Issue
        public string Month { get; set; }
         public int Days { get; set; }
        public bool RoleOrSkill { get; set; }
        public bool WeekOrMonth { get; set; }
        //public string RoleOrSkill { get; set; }
        //public string WeekOrMonth { get; set; }
        public string BGOUType { get; set; }
         public string BGOUFilter { get; set; }
         public string SkillList { get; set; }
        
       
    }

    public class CP_Filter_params: CP_ReportParams
    {
         public string BGOUType { get; set; }
         public string BGOUFilter { get; set; }
         public string SkillList { get; set; }

    }
    public class CP_ReportParams
    {
        public string ReportFormat { get; set; }
        public string ReportTab { get; set; }

    }

    public class AllocatedToProject
    {
         public string ProjectName { get; set; }
         public string ResourceName { get; set; }
         public string ProjectRole { get; set; }
         public int CostPerHour { get; set; }
         public int RatePerHour { get; set; }

    }

    public class AllocatedToProjectToolTip
    {
        public  List<AllocatedToProject> AllocatedToProjectToolTipList { get; set; }
        public int TotalCostPerHour { get; set; }
        public int TotalRatePerHour { get; set; }
        public string RoleDescription { get; set; }
    }

    public class OpportunityRequestData
    {
         public string OpportunityName { get; set; }
         public int NoOfResources { get; set; }
         public double OpportunityCost { get; set; }
         public double OpportunityRate { get; set; }

    }

     public class OpportunityRequestToolTip
    {
        public  List<OpportunityRequestData> OpportunityRequestToolTipList { get; set; }
        public double TotalOpportunityCost { get; set; }
        public double TotalOpportunityRate { get; set; }
        public string RoleDescription { get; set; }
    }

    public class Bench
    {
         public string ResourceName { get; set; }
         public string SkillOrRole { get; set; }
         public double BenchCost { get; set; }

    }

    public class BenchToolTip
    {
        public  List<Bench> BenchToolTipList { get; set; }
        public double TotalBenchCost { get; set; }
        public string RoleDescription { get; set; }
       
    }
    
    public class AnticipatedExits
    {
         public string ResourceName { get; set; }
         public string DateOfLeaving { get; set; }
         public string RoleOrSkill { get; set; }

    }
     public class AnticipatedExitsToolTip
    {
        public  List<AnticipatedExits> AnticipatedExitsToolTipList { get; set; }
        public int NoOfResources { get; set; }
        public string RoleDescription { get; set; }
       
    }

    public class JoiningPool
    {
        public int NoOfResources { get; set; }
        public double ExpectedCost { get; set; }
        public string RoleOrSkill { get; set; }


    }
    public class JoiningPoolToolTip
    {
        public  List<JoiningPool> JoiningPoolToolTipList { get; set; }
        public double TotalExpectedCost { get; set; }
        public string RoleDescription { get; set; }
       
    }

    public class CapacityPlan_BG
    {
        public int BusinessGroupID { get; set; }
        public string BusinessGroup { get; set; }
    }

    public class CapacityPlan_OU
    {
        public int LocationID { get; set; }
        public string Location { get; set; }
    }

    public class CapacityPlan_Skill
    {
        public int ToolID { get; set; }
        public string Description { get; set; }
    }

     public class CPQRoleWeeks
    {
        public string Name { get; set; }
        public decimal Week_1 { get; set; }
        public decimal Week_2 { get; set; }
        public decimal Week_3 { get; set; }
        public decimal Week_4 { get; set; }
        public decimal Week_5 { get; set; }
        public decimal Week_6 { get; set; }
        public decimal Week_7 { get; set; }
        public decimal Week_8 { get; set; }
        public decimal Week_9 { get; set; }
        public decimal Week_10 { get; set; }
        public decimal Week_11 { get; set; }
        public decimal Week_12 { get; set; }
        public decimal Week_13 { get; set; }
        public decimal Week_14 { get; set; }
        public decimal Week_15 { get; set; }
    }
    

}