using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_TestWF_BaseMetricReport
    {
        public string ProjectCode { get; set; }
        public string CustomerName { get; set; }
        public string ProjectType { get; set; }
        public string TemplateName { get; set; }
        public int ProjectID { get; set; }
        public int UserID { get; set; }
        public string UserName { get; set; }
        public int TemplateID { get; set; }
        public int MilestoneID { get; set; }
        public int OldMilestoneId { get; set; }
        public int NewMilestoneId { get; set; }
        public int IsblankSave { get; set; }

        public int DataPointID { get; set; }
        public string DataPointvalue { get; set; }
        public int CategoeryID { get; set; }
        public string ModifiedField { get; set; }
        public string HisModifiedBy { get; set; }
        public string FromWhere { get; set; }



        public string LoginType { get; set; }
    }
}