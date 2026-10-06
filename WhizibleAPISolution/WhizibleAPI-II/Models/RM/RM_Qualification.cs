using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_Qualification
    {
        public int QualificationID { get; set; }
        public string QualificationName { get; set; }
        public bool DeleteFlag { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public int QualificationGroupID { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
    public class QFilterParameter : RM_Qualification
    {
        public string QWhereClause { get; set; }
    }
}