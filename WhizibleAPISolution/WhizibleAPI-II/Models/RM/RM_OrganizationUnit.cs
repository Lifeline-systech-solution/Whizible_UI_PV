
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_OrganizationUnit
    {
         public int LocationID { get; set; }
         public string Location { get; set; }
        public string LocationCode { get; set; }
        public bool Active { get; set; }
    }

    public class RM_OU_RolesGraph
    {
        public List<string> LstLabel { get; set; }
        public List<string> LstColor { get; set; }
        public List<int> LstData { get; set; }
    }

    public class RM_OU_DeliveryUnit
    {
        public int OUPoolID { get; set; }
        public int ResourcePoolID { get; set; }
        public string ResourcePoolCode { get; set; }
        public string ResourcePoolName { get; set; }
    }

    public class RM_OrganizationUnitManagers
    {
        public int OUPoolID { get; set; }
        public int ManagerID { get; set; }
        public int UniqueID { get; set; }
        public string EmployeeName { get; set; }
        public string Responsibilities { get; set; }
        public bool IsPrimaryResponsible { get; set; }
    }

    public class RM_OU_Manager
    {

        public int OrganizationUnitID { get; set; }
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

    public class RM_OU_ManagerParams
    {
        public int BusinessGroupID { get; set; }
        public int UniqueID { get; set; }
        public int ManagerID { get; set; }

    }

    public class RM_OU_Resouces
    {
        public int OUPoolID { get; set; }
        public string EmployeeName { get; set; }
        public string RoleDescription { get; set; }
        public string Location { get; set; }
        public string Department { get; set; }
        public string EmailID { get; set; }
        public int EmployeeID { get; set; }
        public string Resume { get; set; }

    }

    public class RM_OU_Role
    {
        public int RoleID { get; set; }
        public string RoleDescription { get; set; }
    }

    public class OU_EmployeeInfo
    {
        public string EmployeeCode { get; set; }
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public int PostID { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Country { get; set; }
        public string PinCode { get; set; }
        public string Phone { get; set; }
        public string JoiningDate { get; set; }
        public DateTime BirthDate { get; set; }
        public string EmailID { get; set; }
        public string DOB { get; set; }
        public string Designation { get; set; }
       
    }

 

    public class EmployeeQualificationMatrix
    {
        public int EmployeeQualificationID { get; set; }
        public string QualificationName { get; set; }
        public string University { get; set; }
        public string EmployeeClass { get; set; }
        public string Percentage { get; set; }
        public string PassoutYear { get; set; }
        public string QualificationDetails { get; set; }
    }

    public class EmployeeCertificationMatrix
    {
        public int EmployeeCertificationID { get; set; }
        public string CertificationName { get; set; }
        public DateTime CertificationDate { get; set; }
        public DateTime ValidUpto { get; set; }
        public string ActualScore { get; set; }
        public string TotalScore { get; set; }
        public string CertificationDetails { get; set; }
        public string CertDate { get; set; }
        public string CertValidDate { get; set; }
    }

    public class EmployeeSkillMatrix
    {
        public int EmployeeSkillID { get; set; }
        public string Tool { get; set; }
        public string YearsOfExperiance { get; set; }
        public string MonthsOfExperiance { get; set; }
        public string TrainingHours { get; set; }
        public string TechnicalSkills { get; set; }
    }

    public class EmployeeHistory
    {
        public int EmployeeHistoryID { get; set; }
        public string OrganizationName { get; set; }
        public string WorkProfileNature { get; set; }
        public int AnnualSalaryRange { get; set; }
        public string PositionHeld { get; set; }
        public string WorkedFrom { get; set; }
        public string WorkedTill { get; set; }
        public string PreviousWorkExperiance { get; set; }
    }

    public class CurrentAssignmentsForEmployee
    {
        public string ProjectName { get; set; }
        public string ProjectCode { get; set; }
        public string Description { get; set; }
        public string RoleDescription { get; set; }
        public int TeamSize { get; set; }
        public string ActualStartDate { get; set; }
        public string ActualEndDate { get; set; }
        public string Responsibility { get; set; }
        public string AssignmentStatus { get; set; }
        public string ProjectStatus { get; set; }
        public string Tools { get; set; }
        public string Duration { get; set; }
        public string DurationText { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }



    }

    public class PreviousAssignmentsForEmployee
    {
        public int EmployeeID { get; set; }
        public string ProjectName { get; set; }
        public decimal Duration { get; set; }
        public string Environment { get; set; }
        public string SkillSet { get; set; }
        public string Role { get; set; }
        public string Description { get; set; }
        public int TeamSize { get; set; }
        public string ActualStartDate { get; set; }
        public string ActualEndDate { get; set; }
        public string DurationText { get; set; }
        public string DurationFormat { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public int CalculatedDuration { get; set; }
    }

    public class EmployeeHistory_Projects
    {
        public int EmployeeID { get; set; }
        public string ProjectName { get; set; }
        public string Duration { get; set; }
        public string Environment { get; set; }
        public string SkillSet { get; set; }
        public string Role { get; set; }
        public string Description { get; set; }
        public string TeamSize { get; set; }

    }

    public class EmployeeVisaInfo
    {
        public int EmployeeID { get; set; }
        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public int VisaTypeID { get; set; }
        public string VisaType { get; set; }
        public string ValidFrom { get; set; }
        public string ValidUpto { get; set; }
        public string Remarks { get; set; }
        public int EmployeeVisaID { get; set; }
        public string ValidDetails { get; set; }

    }

    public class EmployeeResume
    {
        public OU_EmployeeInfo EmployeeInfo { get; set; }
        public List<EmployeeQualificationMatrix> EmployeeQualificationlst { get; set; }
        public List<EmployeeCertificationMatrix> EmployeeCertificationlst { get; set; }
        public List<EmployeeSkillMatrix> EmployeeSkillslst { get; set; }
        public List<EmployeeHistory> EmployeeHistorylst { get; set; }
        public List<CurrentAssignmentsForEmployee> CurrentAssignments { get; set; }
        public List<PreviousAssignmentsForEmployee> PreviousAssignments { get; set; }
        public List<EmployeeHistory_Projects> EmployeeHistory_Projects { get; set; }
        public EmployeeVisaInfo EmployeeVisaInfo { get; set; }
        public string ProfileImage { get; set; }

    }

      public class OU_Params
    {
        public int ManagerID { get; set; }
        public int UniqueID { get; set; }
        public int RoleID { get; set; }
        public int OUPoolID { get; set; }
        public int OrganizationUnitID { get; set; }
        public int EmployeeID { get; set; }

    }
    public class OUFilterParameter: OU_Params
    {
        public String OUWhereClause { get; set; }
    }
}