using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_WF_DerivedMetricReport
    {
        public int ProjectID { get; set; }
        public int PMIID { get; set; }
        public string ProjectCode { get; set; }
        public string CustomerName { get; set; }
        public string ProjectType { get; set; }
        public string TemplateName { get; set; }
        public int UserID { get; set; }
        public int RequestID { get; set; }
        public int TemplateID { get; set; }
        public int Flag { get; set; }
        public string LoginType { get; set; }
        public int MilestoneID { get; set; }
        public string StrUserName { get; set; }
        public string Remarks { get; set; }
        public string FromWhichAction { get; set; }
        public int SprintID { get; set; }
        public int StatusID { get; set; }
        public string DataPointValue { get; set; }
        public string SenderRemarks { get; set; }
    }
}