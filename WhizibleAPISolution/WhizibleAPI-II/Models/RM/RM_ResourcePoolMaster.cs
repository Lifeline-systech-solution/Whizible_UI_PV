using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_ResourcePoolMaster
    {

        public int ResourcePoolID { get; set; }
        public string ResourcePoolCode { get; set; }
        public string ResourcePoolName { get; set; }
        public string Description { get; set; }
        public string OtherAttribute { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string SkillIds { get; set; }
        public string ModifiedBy { get; set; }
        public int EmployeeID { get; set; }
    }
       
        public class FilterParameter
        {
            public int UniqueID { get; set; }
            public String WhereClause { get; set; }
        }
        public class RPM_Params
        {
            public int UniqueID { get; set; }
            public int ResourcePoolID { get; set; }
            public int RoleID { get; set; }
            public string WhereClause { get; set; }
    }
    public class RPM_Resource
    {
        public int ResourcePoolDetailID { get; set; }
        public int ResourcePoolID { get; set; }
        public string ResourcePoolName { get; set; }
        public int EmployeeID { get; set; }       
        public string EmployeeName { get; set; }
        public string BusinessGroup { get; set; }
        public string Location { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public string EmailID { get; set; }
        public int PostID { get; set; }
        public string RoleDescription { get; set; }
        public string ReportingTo { get; set; }
        public bool IsResourceActive { get; set; }
        public string Resume { get; set; }

    }
    public class RPM_Manager
    {
        public int UniqueID { get; set; }
        public int ResourcePoolManagerID { get; set; }
        public int ResourcePoolID { get; set; }       
        public int EmployeeID { get; set; }
        public string UserName { get; set; }
        public string EmployeeName { get; set; }
        public string Department { get; set; }
        public int DepartmentID { get; set; }
        public int BusinessGroupID { get; set; }
        public string BusinessGroup { get; set; }
        public string Location { get; set; }
        public int LocationID { get; set; }
        public int RoleID { get; set; }
        public string RoleDescription { get; set; }
        public string DesignationName { get; set; }
        public int DesignationID { get; set; }
        public DateTime JoiningDate { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Primaryskills { get; set; }
        public double TotalExp { get; set; }
        public int Skill { get; set; }
        public int FacilityID { get; set; }
        public string ManagerName { get; set; }
        public string EmailID { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CretedDate { get; set; }
        public string CretedBy { get; set; }
    }
    public class RPM_ResourceSelection
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string UserName { get; set; }
        public string EmployeeCode { get; set; }
        public string RoleDescription { get; set; }
        public decimal TotalExp { get; set; }
        public decimal CurrentExp { get; set; }
        public string TotalExpText { get; set; }
        public string CurrentExpText { get; set; }
        public string PrimarySkills { get; set; }
        

    }
    public class RPM_SelectedResource
    {
        public int ResourcePoolID { get; set; }
        public string EmployeeID { get; set; }
        public string From { get; set; }
    }
    public class RPM_ShowSelected
    {
        public int ResourcePoolID { get; set; }
        public bool IsShowSelected { get; set; }
        public string WhereClause { get; set; }
    }

    public class RPM_ManagerSelection
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string BusinessGroup { get; set; }
        public string Location { get; set; }
        public string DesignationName { get; set; }      
        public string RoleDescription { get; set; }    
    }
    public class RPM_BG
    {
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
    }
}