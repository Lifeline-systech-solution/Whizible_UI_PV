using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_Proficiency
    {
        public int ParameterID { get; set; }
        public int ParameterGroupID { get; set; }
        public string ParameterValue { get; set; }
        public string ParameterDescription { get; set; }
        public int OrderNumber { get; set; }
        public bool DeleteFlag { get; set; }
        public int ReviewPeriodDays { get; set; }       
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public bool SkillCompetencyApplicable { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
    }
    public class PROFilterParameter : RM_Proficiency
    {
        public string ProWhereClause { get; set; }

    }
}