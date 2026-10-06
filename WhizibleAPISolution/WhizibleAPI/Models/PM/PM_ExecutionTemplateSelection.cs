using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_ExecutionTemplateSelection
    {
    }
    public class ExeTempSelPrameters
    {
        public int ProjectID { get; set; }
        public int ProjectPhaseTaskTemplateID { get; set; }
        public int TemplateID { get; set; }
        public int ProjectTemplateEffort { get; set; }
        public string TailoringComments { get; set; }
        public string DeviationComments { get; set; }
        public string IsActive { get; set; }
        public int Duration { get; set; }
        public string Effort { get; set; }
        public string Mandatory { get; set; }
        public string UserName { get; set; }
        public string ApprovedByOrRevisedBy { get; set; }
        public string RevisionDate { get; set; }
        public string RevisedBy { get; set; }
        public string ApprovedBy { get; set; }
        public string Reason { get; set; }
        public int RevisionNo { get; set; }
    }
}