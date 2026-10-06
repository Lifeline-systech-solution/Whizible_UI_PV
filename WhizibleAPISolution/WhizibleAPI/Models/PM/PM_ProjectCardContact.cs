using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.ProjectCard
{
    public class PM_ProjectCardContact
    {
        public int ProjectContactID { get; set; }
        public string Name { get; set; }
        public bool Status { get; set; }
        public string Designation { get; set; }
        public string EmailID { get; set; }
        public string Mobile { get; set; }
        public string TypeOfContact { get; set; }
        public string Photo { get; set; }
      
    }
    public class ProjectCardContactParameter
    {
        public int projectID { get; set; }
        public string type { get; set; }
        public string ReportFormat { get; set; }
    }

    public class ProjectCardReportParameters
    {
        public int projectID { get; set; }
        public string ContractType { get; set; }
        public string ReportFormat { get; set; }
    }

    public class FillProjectParameters
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }

    public class defaultFilterParameters
    {
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public int TagID { get; set; }
        public int QueryID { get; set; }
        public string LoginType { get; set; }


    }
}