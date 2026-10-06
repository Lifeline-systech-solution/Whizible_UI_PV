using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_QualificationGroup
    {
        public int QualificationGroupID { get; set; }
        public string QualificationGroupName { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
    public class QGFilterParameter : RM_QualificationGroup
    {
        public string QGWhereClause { get; set; }
    }
}