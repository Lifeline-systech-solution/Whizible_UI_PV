using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class QuantitativeObjectivesParameters
    {
        public int PMIID { get; set; }
        public int ProjectID { get; set; }
    }

    public class ProjectParameters
    {
        public int ProjectID { get; set; }
    }

    public class QuantitativeObjective
    {  
        public int MatricID { get; set; }
        public string ProjectValue { get; set; }
        public string Above { get; set; }
        public string Below { get; set; }
        public string Objective { get; set; }
        public string CategoryName { get; set; }
        public string Name { get; set; }
        public string UnitName { get; set; }
        public int Active { get; set; }
    }

    public class PMIInformation
    {
        public string CategoryName { get; set; }
        public string Name { get; set; }
        public string Above { get; set; }
        public string Below { get; set; }
        public string UnitName { get; set; }
        public int MetricID { get; set; }
        public int Active { get; set; }
    }

    public class QuantitativeObjectivesDetails
    {
        public List<QuantitativeObjective> objectives { get; set; }
        public string objectiveValue { get; set; }
    }

    public class PMIInformationParameters
    {
        public int PMIID { get; set; }
        public int? ProjectID { get; set; }
    }

    public class SaveQuantitativeObjectivesParameters
    {
        public int PMIID { get; set; }
        public int ProjectID { get; set; }
        public string Objective { get; set; }
        public string Data { get; set; }
        public string UserName { get; set; }
        public List<ObjectiveData> Objectives { get; set; }
    }

    public class ObjectiveData
    {
        public int MetricID { get; set; }
        public string Norms { get; set; }
    }

    public class AddMetricsParameters
    {
        public int ProjectID { get; set; }
        public List<int> MetricIDs { get; set; }
    }

    public class AccessibleProjectsParameters
    {
        public int UserID { get; set; }
        public string LoginType { get; set; }
        public bool? ShowReleasedProjects { get; set; }
        public int? LoginID { get; set; }
        public string WhereCriteria { get; set; }
        public string OrderBy { get; set; }
    }

    public class MetricProjectValueParameters
    {
        public int PMIID { get; set; }
        public int ProjectID { get; set; }
        public int MetricID { get; set; }
    }

    public class MetricProjectValueForGridParameters
    {
        public int ProjectID { get; set; }
        public int MetricID { get; set; }
    }

    public class SaveTargetValueParameters
    {
        public int PMIID { get; set; }
        public int ProjectID { get; set; }
        public int MetricID { get; set; }
        public float ProjectValue { get; set; }
        public string Description { get; set; }
    }

    public class SaveStrategyParameters
    {
        public int PMIID { get; set; }
        public int ProjectID { get; set; }
        public string Objective { get; set; }
    }
}
