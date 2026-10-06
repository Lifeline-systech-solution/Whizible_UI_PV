using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_VisaTypeMaster
    {
       // public int UniqueID { get; set; }
        public int VisaTypeID { get; set; }
        public string VisaType { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
    }

    public class VTFilterParameter : RM_VisaTypeMaster
    {
        //public int UniqueID { get; set; }       
        public string VTWhereClause { get; set; }
    }
}