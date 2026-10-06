using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_InfraStatus
    {
        
        public int InfraStatusId { get; set; }
        public string InfraStatus { get; set; }
        public bool Status { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
    }
    public class ISFilterParameter : RM_InfraStatus
    {     
        public string ISWhereClause { get; set; }
    }
}