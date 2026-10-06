using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM_CommercialDashboard
{
    public class PM_CommercialDashboard
    {
        public OverallScore OverallScore { get; set; }
        public NetGrossProfitability NetGrossProfitability { get; set; }
        public AcruedRevenueCost AcruedRevenueCost { get; set; }
        public DelayinRealization DelayinRealization { get; set; }
        public List<CommercialProjectData> ProjectData { get; set; }
    }


    public class FillProjectParameters
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string WhichType { get; set; }
    }

    public class PM_CommercialDashboardFilter
    {
        
        public string Whichgraph { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public string ProjectFilter { get; set; }
        public string Flag { get; set; }
        public int Count { get; set; }
    }


    // ADDED BY VIDHI FOR POP UP WINDOW

    public class PM_ProjectBG
    {
        public int BusinessGroupID { get; set; }
        public string BusinessGroup { get; set; }

    }


    public class PM_ProjectOU
    {
        public int LocationID { get; set; }
        public string Location { get; set; }

    }


    public class PM_GetProjectStatus
    {
        public int ProjectID { get; set; }
        public bool Premium { get; set; }
        public string Priority { get; set; }
    }

    public class DisplayGridDataInsidePopUP_outputParameters
    {
        public string ProjectName { get; set; }
        public int ProjectID { get; set; }
        public string Description { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }

    public class DisplayGridDataInsidePopUP_InputParameters
    {
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public string Flag { get; set; }

    }





    public class FetchDataAccordingtoBG_outputParameters
    {
        public string ProjectName { get; set; }
        public int ProjectID { get; set; }
        public string Description { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public int LocationID { get; set; }

    }

    public class FetchDataAccordingtoBG_inputParameters
    {
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public int BusinessGroupID { get; set; }


    }


    public class InsertDataIntoTable_InputParameter
    {
        public int ProjectID { get; set; }
        public int CreatedBy { get; set; }
        public int Priority { get; set; }
        public int Premium { get; set; }

    }
    // END BY VIDHI FOR POP UP WINDOW











    public class OverallScore
    {
        public Double Scroreno { get; set; }
        public Double Revenue { get; set; }

        public Double Effort { get; set; }
        public Double Cost { get; set; }
        public Double Schedule { get; set; }

        public Double ScoreEffort { get; set; }
        public Double ScoreCost { get; set; }
        public Double ScoreSchedule { get; set; }


        public Double ActualEffort { get; set; }
        public Double ActualRevenue { get; set; }
        public Double ActualCost { get; set; }


        public Double plannedEffort { get; set; }
        public Double plannedRevenue { get; set; }
        public Double plannedCost { get; set; }


        public Double OverallRevenue { get; set; }
        public Double OverallCost { get; set; }
        public Double OverallEfforts { get; set; }
    }

    public class NetGrossProfitability
    {
        public string[] Projects { get; set; }
        public int[] Gross { get; set; }
        public int[] Net { get; set; }
        public string[] WhichType { get; set; }
        public string[] CurrencySymbol { get; set; }
    }

    public class AcruedRevenueCost
    {
        public string[] Projects { get; set; }
        public int[] Gross { get; set; }
        public int[] Net { get; set; }
        public string[] WhichType { get; set; }
        public int[] AccruedRevenue { get; set; }
        public int[] AccruedCost { get; set; }
        public string[] CurrencySymbol { get; set; }
        

    }

    public class DelayinRealization
    {
        public string[] DaysAging { get; set; }
        public string[] Days { get; set; }
    }

    public class CommercialProjectData
    {

        public string Whichgraph { get; set; }
       
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public string Flag { get; set; }
        public int ProjectID { get; set; }
        public int ID { get; set; }
        public string WhichType { get; set; }
        public string ProjectName { get; set; }
        public string Type { get; set; }
        public int TotalMilestone { get; set; }
        public string Customer { get; set; }
        public string OnOff { get; set; }
        public int On { get; set; }
        public int Off { get; set; }
        public string MilestoneBilling { get; set; }
        public string TotalBilling { get; set; }
        public string ProjectTotalAmount { get; set; }
        public string RPP { get; set; }
        public string AcruedRevenue { get; set; }
        public string AcruedCost { get; set; }
        public int GrossProfitability { get; set; }
        public int NetProfitability { get; set; }
        public int Overhead { get; set; }
        public int BufferEfforts { get; set; }
        public int DelayinRealization { get; set; }
        public string CustomerContactName { get; set; }
        public string CustomerConatctEmail { get; set; }
        public string CurrencySymbol { get; set; }
        public string CustomerMobileNumber { get; set; }

        public string RealizationBelowThreshold { get; set; }
        public string RealizationAboveThreshold { get; set; }



    }

    public class defaultFilterParameters    
    {
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int QueryID { get; set; }
        public string LoginType { get; set; }
        public string ProjectFilter { get; set; }
        public string Flag { get; set; }
        public string LoginID { get; set; }
        public string  Whichgraph { get; set; }
        public int EmployeeID { get; set; }
        public string Count { get; set; }
    }

    //public class FillProjectParameters
    //{
    //    public int ProjectID { get; set; }
    //    public string ProjectName { get; set; }
    //}

    public class UserData
    {
        public string EmployeeName { get; set; }
        public int EmployeeID { get; set; }
    }



    public class PM_ProjectDashboard
    {
        public NetProfitability NetProfitability { get; set; }
        public PriorityProjects PriorityProjects { get; set; }
        public List<ProjectData> ProjectData { get; set; }
    }

    public class PM_ProjectDashboardFilter
    {
        public string ProjectFilter { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public string Whichgraph { get; set; }
        public int Count { get; set; }
        public string Flag { get; set; }
       
    }

    public class PriorityProjects
    {
        public string[] Type { get; set; }
        public int[] TypeData { get; set; }
    }


    public class NetProfitability
    {
        public string[] Projects { get; set; }
        public int[] ProfitRange { get; set; }
    }



    public class GridProjectData
    {
        //public long ID { get; set; }
        public string ProjectName { get; set; }
        public string PlannedEfforts { get; set; }
        public string ActualEfforts { get; set; }
        public string ProjectDetails { get; set; }
        public int ExpectedDuration { get; set; }
        public int ActualDuration { get; set; }
        public string HealthIndicator { get; set; }
        public int StaffTurnover { get; set; }
        public int ScopeCRRequest { get; set; }
        public int DefectDensity { get; set; }
        public int Risks { get; set; }
        public string Color { get; set; }
        public int OverAllShedule { get; set; }
        public int PlannedShedule { get; set; }
        public int ActualShedule { get; set; }
        public int ScheduleVariance { get; set; }
        public int CostVariance { get; set; }
        public int BillingActualPlanned { get; set; }
        public int NetProfitability { get; set; }
    }


    public class ProjectData
    {
        public long ID { get; set; }
        public string ProjectName { get; set; }
        public int PlannedEfforts { get; set; }
        public int ActualEfforts { get; set; }
        public string ProjectDetails { get; set; }
        public string HealthIndicator { get; set; }
        public int StaffTurnover { get; set; }
        public int ScopeCRRequest { get; set; }
        public int DefectDensity { get; set; }
        public int Risks { get; set; }
        public int Color { get; set; }
        public int OverAllShedule { get; set; }
        public int PlannedShedule { get; set; }
        public int ActualShedule { get; set; }
        public int ScheduleCariance { get; set; }
        public int CostVariance { get; set; }
        public int BillingActualPlanned { get; set; }
        public int NetProfitability { get; set; }

        public string CustomerContactName { get; set; }
        public string CustomerConatctEmail { get; set; }
    }


}


namespace WhizibleAPI.Models.PM.Projects
{
    public class ProjectData
    {
        public long ID { get; set; }
        public string ProjectName { get; set; }
        public int PlannedEfforts { get; set; }
        public int ActualEfforts { get; set; }
        public string ProjectDetails { get; set; }
        public string HealthIndicator { get; set; }
        public int StaffTurnover { get; set; }
        public int ScopeCRRequest { get; set; }
        public int DefectDensity { get; set; }
        public int Risks { get; set; }
        public int Color { get; set; }
        public int OverAllShedule { get; set; }
        public int PlannedShedule { get; set; }
        public int ActualShedule { get; set; }
        public int ScheduleCariance { get; set; }
        public int CostVariance { get; set; }
        public int BillingActualPlanned { get; set; }
        public int NetProfitability { get; set; }
    }

}


