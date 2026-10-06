using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RBG
{
    /// <summary>
    /// Busseness group 
    /// </summary>
    public class BG_BusinessGroup
    {

        public string BusinessGroup { get; set; }
        public int BusinessGroupID { get; set; }
        public string BusinessGroupCode { get; set; }
        public int ManagerID { get; set; }
        public string ModifiedBy { get; set; }
        public bool Active { get; set; }
        public DateTime CretedDate { get; set; }
        public string CretedBy { get; set; }
    }
    /// <summary>
    /// Busseness group list object
    /// </summary>
    public class BusinessGroups
    {
        List<BG_BusinessGroup> lstBusinessGroups { get; set; }
    }


    #region BG_Manager
    /// <summary>
    /// BG-Manager
    /// </summary>
    public class BG_Manager
    {
        public int BusinessGroupID { get; set; }
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

    public class BG_Params
    {
        public int BusinessGroupID { get; set; }
        public int UniqueID { get; set; }
        public int ManagerID { get; set; }

        public int RoleID { get; set; }

    }

    #endregion

    #region BG_OrganizationUnit

    public class BG_OrganizationUnit
    {
        public int BusinessGroupID { get; set; }
        public int UniqueID { get; set; }
        public int OUPoolID { get; set; }
        public string Location { get; set; }
        public string LocationCode { get; set; }
        //public string ModifiedBy { get; set; }
        //public DateTime CretedDate { get; set; }
        //public string CretedBy { get; set; }
    }

    #endregion

    #region BG_Resource

    public class BG_Resource
    {
        public int OUPoolID { get; set; }
        public int RoleID { get; set; }
        public string EmployeeName { get; set; }
        public string RoleDescription { get; set; }
        public string Location { get; set; }
        public string Department { get; set; }
        public string EmailID { get; set; }

        public int EmployeeID { get; set; }
        public string Resume { get; set; }

    }
    #endregion


    #region BG_Role_Graph

    public class BG_RolesGraph
    {
        public List<string> LstLabel { get; set; }
        public List<string> LstColor { get; set; }
        public List<int> LstData { get; set; }
    }

    #endregion


    #region Bg filter

    public class BGFilterParameter: BG_BusinessGroup
    {
        //public int ProjectId { get; set; }
        //public int BusinessGroupID { get; set; }
        public int UniqueID { get; set; }
        //public bool IsActive { get; set; }
       // public string BusinessGroup { get; set; }

        //public string BusinessGroupCode { get; set; }
        public String BGWhereClause { get; set; }
    }


    public class ApplyFilterParameter
    {
        public int TagID { get; set; }
        public int ProjectID { get; set; }
        public int EmployeeID { get; set; }
        public String FilterName { get; set; }
        public String LoginType { get; set; }
        public String CreatedBy { get; set; }
        public String WhereClause { get; set; }
        public String Flag { get; set; }
        public int FilterID { get; set; }
    }


    public class MyFilterParameter
    {
        public int FilterId { get; set; }
        public String FilterName { get; set; }
        public bool SetDefault { get; set; }
        public String QueryText { get; set; }
        public int EmployeeID { get; set; }
    }
    #endregion

    #region Dropdown list 

    public class Bg_MangerCbo
    {
        public int EmployeeID { get; set; }
        public string UserName { get; set; }
    }
    #endregion

}