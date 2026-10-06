using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_InfraType
    {
        public int InfraTypeId { get; set; }
        public string InfraTypeName { get; set; }
        public bool Status { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
    }
    public class ITFilterParameter : RM_InfraType
    {
        public string ITWhereClause { get; set; }
    }
}