using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_InfraGroup
    {
        public int InfraGroupId { get; set; }
        public string InfraGroupName { get; set; }
        public bool Status { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
    }
    public class IGFilterParameter : RM_InfraGroup
    {
        //public int UniqueID { get; set; }       
        public string IGWhereClause { get; set; }
    }
}