using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_GradeMaster
    {
        public int GradeID { get; set; }
        public string Grade { get; set; }
        public string GradeDescription { get; set; }
        public int LevelID { get; set; }
        public string weightage { get; set; } 
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
    }
    public class GMFilterParameter : RM_GradeMaster
    {
        public string GMWhereClause { get; set; }

    }
}