using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_SkillCategory
    {
        public int Tools_CategoryID { get; set; }
        public string CategoryName { get; set; }
        public string Description { get; set; }
        public string CreatedBy { get; set; }
    }
    public class SCFilterParameter : RM_SkillCategory
    {
        public string SCWhereClause { get; set; }
    }
    public class SkillCategories
    {
        public int Tools_CategoryID { get; set; }
        public string ToolID { get; set; }
        public string AllToolID { get; set; } //Added By Dipali V On 14th April 2023
    }

    public class SkillsMapping
    {
        public int ToolID { get; set; }
        public string Description { get; set; }
        public bool SelCheckBox { get; set; }
    }

    
}