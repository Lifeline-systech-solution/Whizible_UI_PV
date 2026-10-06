using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_ProjectEffortsTesting
    {

        public int UserID { get; set; }
        public int IsCreated { get; set; }
        public int ProjectID { get; set; }
        public int TemplateID { get; set; }
        public int MileStoneID { get; set; }
        public int NewMilestoneId { get; set; }
        public int OldMilestoneId { get; set; }
        public int NewOrder { get; set; }
        public int OldOrder { get; set; }
        public int ResourceID { get; set; }
        public string AttributeValue { get; set; }
        public string LoginType { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedField { get; set; }
        public string HisModifiedBy { get; set; }
        public int ReleaseID { get; set; }
        public string ReleaseName { get; set; }
        public string PlanStartDate { get; set; }
        public string PlanEndDate { get; set; }
        public string ActualStartDate { get; set; }
        public string ActualEndDate { get; set; }
        public string MileStoneIDs { get; set; }


    }
}