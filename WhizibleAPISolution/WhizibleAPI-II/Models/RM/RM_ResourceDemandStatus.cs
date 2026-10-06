using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_ResourceDemandStatus
    {
    }

    public class DemandStatusDetail
    {
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public int StatusID { get; set; }
        public int OrderNo { get; set; }
        public string StatusName { get; set; }
        public string QueryText { get; set; }
        public string LoginType { get; set; }
        public string UserName { get; set; }
        public string FilterName { get; set; }
        public string CreatedBy { get; set; }
        public int FilterID { get; set; }
        public int Flag { get; set; }
        //public Boolean IsDrop { get; set; }
        //public Boolean IsReopen { get; set; }
        //public Boolean IsClosure { get; set; }
        //public Boolean IsInitiated { get; set; }
        //public Boolean IsOnHold { get; set; }
        public string IsDrop { get; set; }
        public string IsReopen { get; set; }
        public string IsClosure { get; set; }
        public string IsInitiated { get; set; }
        public string IsOnHold { get; set; }
    }

    public class QueryLists
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
        public string SQL { get; set; }
        public int ControlID { get; set; }
        public string ControlValue { get; set; }


    }

}