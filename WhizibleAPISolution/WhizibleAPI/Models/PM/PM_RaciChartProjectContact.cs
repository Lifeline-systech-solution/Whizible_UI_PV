using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RaciChart
{
    public class RaciChartProjectContact
    {
        public int ProjectContactID { get; set; }
        public string Name { get; set; }
        public bool Status { get; set; }
        public string Designation { get; set; }
        public string TypeOfContact { get; set; }
    }

    public class RaciChartProjectContactParameter
    {
        public int projectID { get; set; }
        public string type { get; set; }
    }

    public class Milstones
    {
        public string MileStoneID { get; set; }
        public int projectID { get; set; }
        public string MileStone { get; set; }
        public string Name { get; set; }
        public int ID { get; set; }

        public string Type { get; set; }
        public string StakeholderType { get; set; }
        public List<Stakeholder> listStakeholder { get; set; }

    }

    public class WBS
    {

        public string WBSName { get; set; }
    }

    public class RACISEL
    {
        public int projectID { get; set; }
        public string RACIName { get; set; }

    }

    public class SubProjects
    {
        public int projectID { get; set; }
        public string SubProjectId { get; set; }
        public string SubProjectName { get; set; }
        public string ProcedureName { get; set; }
        public string Name { get; set; }
        public int ID { get; set; }
        public string Type { get; set; }
        public string StakeholderType { get; set; }
        public List<Stakeholder> listStakeholder { get; set; }
        public string ReportFormat { get; set; }


    }

    public class RACI
    {
        public string strRaci { get; set; }
    }

    public class Resources
    {
        public string strResources { get; set; }
    }

    public class RaciWBS
    {
        //public string ProjectID { get; set; }
        public string strWBS { get; set; }
        public List<RACI> listRaci = new List<RACI>();
        public List<Resources> lisResources = new List<Resources>();

    }

    public class RaciParameters
    {
        public string ProjectID { get; set; }
        public string UserID { get; set; }
        public string UserName { get; set; }
        public string Type { get; set; }
        public List<RaciWBS> listRaciWbs { get; set; }
    }


    public class RaciData
    {
        public int StakeholderID { get; set; }
        public int WBSID { get; set; }
        public string Responsible { get; set; }
        public string Accountable { get; set; }
        public string Consulted { get; set; }
        public string Informed { get; set; }
    }

    public class Stakeholder
    {
        public int StakeholderID { get; set; }
        public string[] RACI { get; set; }
    }

    public class defaultFilterParameters
    {
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int QueryID { get; set; }
        public string LoginType { get; set; }


    }

    public class FillProjectParameters
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }




}
