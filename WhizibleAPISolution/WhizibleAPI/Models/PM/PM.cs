using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM
    {
        public Project OrganazationDetails { get; set; }
        public List<ProjectModules> ProjectModulesLists { get; set; }
        public ProjectStatus projectStatus { get; set; }
        public List<ReviewTasksStatus> ReviewTasksStatusLists { get; set; }
    }

    public class Project
    {
        public string ProjectName { get; set; }
        public string CustomerName { get; set; }
        public double Remaining { get; set; }
        public double EngineeringEffort { get; set; }
        public double Spent { get; set; }
        public string Description { get; set; }
        public double Projectbudget { get; set; }
        public double QoutedPricing { get; set; }
        public string ProjectManager { get; set; }
        public string ProjectCurrency { get; set; }
    }
    public class ProjectModules
    {
        public int ModuleID { get; set; }
        public string ModuleName { get; set; }
        public string ResponsiblePersonName { get; set; }
        public string ModuleStatus { get; set; }
    }
    public class ProjectStatus
    {
        public string ProjectStatusClass { get; set; }
    }
    public class ReviewTasksStatus
    {
        public string ShortDescription { get; set; }
        public string Description { get; set; }
        public string Area { get; set; }
        public string RevieweeName { get; set; }
        public float Expected { get; set; }
        public string TaskStatus { get; set; }
    }
}