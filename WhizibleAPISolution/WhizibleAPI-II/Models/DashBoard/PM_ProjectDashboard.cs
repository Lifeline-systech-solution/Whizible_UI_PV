using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

//namespace WhizibleAPI.Models.PM
namespace WhizibleAPI.Models.PM_ProjectDashboard
{
    public class PM_ProjectDashboard
    {
        public NetProfitability NetProfitability { get; set; }
        public PriorityProjects PriorityProjects { get; set; }
        public List<ProjectData> ProjectData { get; set; }
    } 

    public class PM_ProjectGrid
    {
        public List<ProjectData> ProjectData { get; set; }

    }

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

    public class PM_ProjectDashboardFilter
    {
        public string ProjectFilter { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int LoginID { get; set; }
    }

    public class PriorityProjects
    {
        public string[] Type { get; set; }
        public int[] TypeData { get; set; }
    }


    public class NetProfitability
    {
        public string[] Projects { get; set; }
        //Added By Dipali V on 21th Jan 2022 For Get % in float
        //public int[] ProfitRange { get; set; }
        public string[] ProfitRange { get; set; }
        //End of Added By Dipali V on 21th Jan 2022 For Get % in float
    }


    public class ListOfProjectParameter
    {
       
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public string ProjectFilter { get; set; }
        public string Flag { get; set; }


    }

    public class FillProjectParameters
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string WhichType { get; set; }
        
    
    }


    public class PriorityChartDisplays
    {
        public string Type { get; set; }
        public int TypeData { get; set; }

    }

    public class PriorityChartParameters
    {
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public string ProjectFilter { get; set; }
        public string Flag { get; set; }
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

    public class UserDataOutputParameter
    {
        public string EmployeeName { get; set; }
        public int EmployeeId { get; set; }
    }


    public class userDataParameter
    {
        public string Flag { get; set; }
    }


    public class PM_CommercialDashboardFilter
    {
        public string ProjectFilter { get; set; }
        public int ProjectID { get; set; }
        public string UserID { get; set; }
        public string LoginID { get; set; }
        public int Flag { get; set; }
        public int Rowcount { get; set; }
    }

    public class GridParameters
    {
        public int UserID { get; set; }
        public int LoginID { get; set; }
        public string ProjectFilter { get; set; }
        public string Flag { get; set; }

    }



    public class GridProjectData
    {
        public string ProjectName { get; set; }
        public int ProjectID { get; set; }
        public string WhichType { get; set; }
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
        //public long ID { get; set; }
        //public string ProjectName { get; set; }
        //public int PlannedEfforts { get; set; }
        //public int ActualEfforts { get; set; }
        //public string ProjectDetails { get; set; }
        //public string HealthIndicator { get; set; }
        //public int StaffTurnover { get; set; }
        //public int ScopeCRRequest { get; set; }
        //public int DefectDensity { get; set; }
        //public int Risks { get; set; }
        //public int Color { get; set; }
        //public int OverAllShedule { get; set; }
        //public int PlannedShedule { get; set; }
        //public int ActualShedule { get; set; }
        //public int ScheduleCariance { get; set; }
        //public int CostVariance { get; set; }
        //public int BillingActualPlanned { get; set; }
        //public int NetProfitability { get; set; }
        public string ProjectName { get; set; }
        public int ProjectID { get; set; }
        public string WhichType { get; set; }
        public string PlannedEfforts { get; set; }
        public string ActualEfforts { get; set; }
        public string EffortPercentage { get; set; }
        public string ProjectDetails { get; set; }
        //Added By Dipali V On 17th Jan 2022 For Details Of Projects
        public string Baseline { get; set; }
        public string Planned { get; set; }
        public string Actual { get; set; }
        //End of Added By Dipali V On 17th Jan 2022 For Details Of Projects
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
        // Added By Dipali V On 17th Jan 2022 For Details Of Projects
        //public int ActualShedule { get; set; }
        //public int ScheduleVariance { get; set; }
        ///Get Correct Values
        public string ActualShedule { get; set; }
        public string ScheduleVariance { get; set; }
        //public int CostVariance { get; set; }
        public string CostVariance { get; set; }
       // Get Correct Values
        public int BillingActualPlanned { get; set; }
        //Added By Dipali V On 22nd Jan 2022 For Get Project Profatability
        //public int NetProfitability { get; set; }
        public string NetProfitability { get; set; }
        //End of Added By Dipali V On 22nd Jan 2022 For Get Project Profatability
    }


}
