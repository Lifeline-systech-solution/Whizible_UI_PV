using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_DeliveryTeam
    {
        public int GroupID { get; set; }
        public string GroupCode{ get; set; }
        public string GroupName { get; set; }
        public int ResourceHeadID { get; set; }
        public bool Active { get; set; }
        public DateTime CretedDate { get; set; }
        public string CretedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
    }
    public class RM_DT_Resouces
    {
        public int GroupID { get; set; }
        public string GroupName { get; set; }
        public string EmployeeName { get; set; }
        public string RoleDescription { get; set; }
        public int RoleID { get; set; }
        public string Location { get; set; }
        public string Department { get; set; }
        public string EmailID { get; set; }
        public int EmployeeID { get; set; }
        public string Resume { get; set; }

    }
    public class RM_DeliveryTeamResourcePoolGraph
    {
        public List<string> LstLabel { get; set; }
        public List<string> LstColor { get; set; }
        public List<int> LstData { get; set; }
    }    
    public class DTparams
    {
        public int GroupID { get; set; }
    }

    public class DTFilterParameter : RM_DeliveryTeam
    {
        public string DTWhereClause { get; set; }
        public bool IsFromDTHead { get; set; }


    }

    public class  RM_DeliveryTeamHead
    {
        public int GroupID { get; set; }
        public int EmployeeID { get; set; }
        public string UserName { get; set; }

    }
}