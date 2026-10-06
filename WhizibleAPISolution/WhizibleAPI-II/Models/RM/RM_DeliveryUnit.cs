using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_DeliveryUnit
    {
            public int ResourcePoolID { get; set; }
            public string ResourcePoolCode { get; set; }
            public string ResourcePoolName { get; set; }
            public int ManagerID { get; set; }
            public bool Active { get; set; }
            public DateTime CretedDate { get; set; }
            public string CretedBy { get; set; }
        
    }

    public class DU_DeliveryTeam
    {
        public int ResourcePoolID { get; set; }
        public int UniqueID { get; set; }
        public int GroupID { get; set; }
        public string GroupName { get; set; }
        public string GroupCode { get; set; }
        public string ResourceHead { get; set; }
        
    }

    public class DU_Manager
    {
        public int ResourcePoolID { get; set; }
        public int UniqueID { get; set; }
        public int ManagerID { get; set; }
        public string Manager { get; set; }
        public bool IsPrimaryResponsible { get; set; }
        public string Responsibilities { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CretedDate { get; set; }
        public string CretedBy { get; set; }
    }

    public class DU_Resource
    {
        public int ResourcePoolID { get; set; }
        public int RoleID { get; set; }
        public string EmployeeName { get; set; }
        public string RoleDescription { get; set; }
        public string Location { get; set; }
        public string Department { get; set; }
        public string EmailID { get; set; }

        public int EmployeeID { get; set; }
        public string Resume { get; set; }

    }

    public class RM_DU_Manager
    {

        public int ResourcePoolID { get; set; }
        public int UniqueID { get; set; }
        public int ManagerID { get; set; }
        public int NewManagerID { get; set; }
        public string Manager { get; set; }
        public bool IsPrimaryResponsible { get; set; }
        public string Responsibilities { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CretedDate { get; set; }
        public string CretedBy { get; set; }
    }

    public class DU_RolesGraph
    {
        public List<string> LstLabel { get; set; }
        public List<string> LstColor { get; set; }
        public List<int> LstData { get; set; }
    }

    public class DU_Params
    {
        public int ManagerID { get; set; }
        public int UniqueID { get; set; }
        public int RoleID { get; set; }
        public int ResourcePoolID { get; set; }

    }

    public class DUFilterParameter: DU_Params
    {
        public String DUWhereClause { get; set; }
    }
}