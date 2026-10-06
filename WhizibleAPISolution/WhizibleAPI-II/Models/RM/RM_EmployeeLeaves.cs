using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_EmployeeLeaves
    {
        public int EmployeeID { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public int DesignationID { get; set; }
        public string EmployeeName { get; set; }
        public string  EmailID { get; set; }
        public string Phone { get; set; }
        public double NoOfLeaves { get; set; }
        public double LeaveBalance { get; set; }

    }
    public class EmpFilterParameter 
    {
        public string EmpWhereClause { get; set; }
        public int EmployeeID { get; set; }
    }
    public class RM_EmployeeLeaveType
    {
        public int EmployeeID { get; set; }
        public int UniqueID { get; set; }
        public string  LeaveType { get; set; }
        public double NoOfLeaves { get; set; }
        public double LeaveBalance { get; set; }
        public double ProRata { get; set; }
        public int LeaveTypeID { get; set; }
    }
    public class RM_EmpLeaves
    {
        public int UniqueID { get; set; }
        public int EmployeeID { get; set; }
        public double ProRata { get; set; }
        public double NoOfLeaves { get; set; }
        public double LeaveBalance { get; set; }       
        public int LeaveTypeID { get; set; }
        public string CreatedBy { get; set; }
    }
    //public class EmpLeaveApprovers
    //{
    //    public List<LeaveApproverName> lstApproverName { get;set;}
    //}
    public class EmpLeaveApprovers
    {
        public string Approver { get; set; }
        public List<LeaveEmployeeName> lstEmployeeName { get; set; }
    }
    public class LeaveEmployeeName
    {
        public string Approver { get; set; }
        public string EmployeeName { get; set; }
    }
    public class RM_XslxEmployeeLeaves //for saving
    {
         public string ColumnError { get; set; }
        public string EmployeeName { get; set; }

        public int EmployeeID { get; set; }
        public string LeaveOrWFH { get; set; }
        public int LeaveTypeID { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string HalfDay { get; set; }
        public string Reason { get; set; }
        public int LeaveStatusID { get; set; }
        public string AppliedDate { get; set; }
        public string ApprovedDate { get; set; }
        public double ActualDuration { get; set; }

        //save
        public string EmployeeCode { get; set; }
        public string RequestType { get; set; }
        public string LeaveType { get; set; }
        public string NumberOfDays { get; set; }
        public string Status { get; set; }
    }
    //public class RM_XslxEmployeeLeaves
    //{
    //    public string  EmployeeCode { get; set; }
    //    public string EmployeeName { get; set; }
    //    public string RequestType { get; set; }
    //    public string LeaveType { get; set; }
    //    public string FromDate { get; set; }
    //    public string ToDate { get; set; }
    //    public bool HalfDay { get; set; }
    //    public string Reason { get; set; }
    //    public string Status { get; set; }
    //    public string AppliedDate { get; set; }
    //    public string ApprovedDate { get; set; }
    //    public string NumberOfDays { get; set; }

    //}


    public class RM_XslxEmpLeaves //for saving
    {
       // public string EmployeeCode { get; set; }
        public string EmployeeName { get; set; }

        public int EmployeeID { get; set; }
        public string LeaveOrWFH { get; set; }
        public int LeaveTypeID { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public bool HalfDay { get; set; }
        public string Reason { get; set; }
        public int LeaveStatusID { get; set; }
        public DateTime AppliedDate { get; set; }
        public DateTime ApprovedDate { get; set; }
        public double ActualDuration { get; set; }

        //save
        public string EmployeeCode { get; set; }
        public string RequestType { get; set; }
        public string LeaveType { get; set; }
        public string NumberOfDays { get; set; }
    }

}