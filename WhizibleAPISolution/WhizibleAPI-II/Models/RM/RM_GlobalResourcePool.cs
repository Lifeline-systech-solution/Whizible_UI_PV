using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{   
        public class RM_GlobalResource
        {
            public int GlobalResourcePoolID { get; set; }
            public string GlobalResourcePoolCode { get; set; }
            public string GlobalResourcePoolName { get; set; }
            public string CreatedDate { get; set; }
            public string CreatedBy { get; set; }
            public string ModifiedDate { get; set; }
            public string ModifiedBy { get; set; }
        }
        public class RM_GlobalResourcePoolManager
        {
            public int UniqueID { get; set; }
            public int GlobalResourcePoolID { get; set; }
            public int ManagerID { get; set; }
            public int NewManagerID { get; set; }
            public bool IsPrimaryResponsible { get; set; }
            public string Manager { get; set; }
            public string CreatedDate { get; set; }
            public string CreatedBy { get; set; }
            public string ModifiedDate { get; set; }
            public string ModifiedBy { get; set; }
        }

        public class RM_GlobalResourcePoolManagerList
        {
            public int UniqueID { get; set; }
            public bool IsPrimaryResponsible { get; set; }
            public string Manager { get; set; }
            public int ManagerID { get; set; }
    }
        public class RM_GlobalResourcePoolGraph
        {
            public List<string> LstLabel { get; set; }
            public List<string> LstColor { get; set; }
            public List<int> LstData { get; set; }
        }

    public class GRP_Params
    {
        public int GlobalResourcePoolID { get; set; }       

    }

    #region GRP filter

    public class GRPFilterParameter : RM_GlobalResource
    {
        //public int UniqueID { get; set; }       
        public String GRPWhereClause { get; set; }
    }


    #endregion
}