using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Skill
{
    public class RM_Skill
    {
        public Int64 ToolID { get; set; }
        public string Description { get; set; }
        public bool RequiredForMatricCalc { get; set; }
        public int ConfiguredDays { get; set; }
        public int Tools_CategoryID { get; set; }
        public string CategoryName { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
    }
    public class RM_ToolsCategory
    {
        public int Tools_CategoryID { get; set; }
        public string CategoryName { get; set; }

    }
    public class SklFilterParameter : RM_Skill
    {
        //public int ProjectId { get; set; }
        //public int BusinessGroupID { get; set; }
        public int UniqueID { get; set; }
        //public bool IsActive { get; set; }
        // public string BusinessGroup { get; set; }

        //public string BusinessGroupCode { get; set; }
        public String SklWhereClause { get; set; }
    }

}