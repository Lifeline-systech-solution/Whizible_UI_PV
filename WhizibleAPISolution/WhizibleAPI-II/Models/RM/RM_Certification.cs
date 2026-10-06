using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_Certification
    {
        public int CertificationID { get; set; }
        public string CertificationName { get; set; }
        public bool DeleteFlag { get; set; }
        public string CreatedBy { get; set; }

        public DateTime CreatedDate { get; set; }
    }

    public class  CRTFilterParameter : RM_Certification
    {   
        public string CRTWhereClause { get; set; }
    }
}