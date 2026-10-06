using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{

    public class RM_EmployeeMaster
    {
        public int EmplpoyeeID { get; set; }
        public string BirthDate { get; set; }
        public string Email { get; set; }
        public string EmployeeName { get; set; }
        public string Deployable { get; set; }
        public string UserName { get; set; }
        public string Gender { get; set; }
        public string JoiningDate { get; set; }
        public bool IsLDAPAuthntication { get; set; }
        public string EmployeeCode { get; set; }
        public string BloodGroup { get; set; }
        public int DepartmentID { get; set; }
        public int RoleID { get; set; }
        public int DesignationID { get; set; }
        public string EmployeeType { get; set; }
        public int ReportingTo { get; set; }
        // Added by Dipali V on 6th May 2026 for vendor management - mandatory vendor mapping in Employee Master
        public int VendorID { get; set; }
        public int GradeID { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public int ResourcePoolID { get; set; }
        public int GroupID { get; set; }
        public int FacilityID { get; set; }
        public string ExtensionNo { get; set; }
        public decimal CostPerHr { get; set; }
        public decimal RatePerHr { get; set; }
        public string CostToCompany { get; set; }
        public int CurrencyID { get; set; }
        public string TentativeLeavingDate { get; set; }
        public string LeavingDate { get; set; }
        public string MessangerID { get; set; }
        public string CreatedBy { get; set; }
        public string StatusNew { get; set; }
        public int Status { get; set; }
        //new fields
        public int DeliveryUnitId { get; set; }
        public int DeliveryTeamId { get; set; }

        public string CurrentAddress { get; set; }
        public string CurrentCity { get; set; }
        public string CurrentState { get; set; }
        public string CurrentPinCode { get; set; }
        public string CurrentPhone { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PinCode { get; set; }
        public string Phone { get; set; }

        public string PassportNumber { get; set; }
        public string PP_PlaceOfIssue { get; set; }
        public string PP_DateOfIssue { get; set; }
        public string PP_ExpiryDate { get; set; }
        public string PP_FullName { get; set; }
        public string PP_RelativeName { get; set; }
        public string NoofPagesLeft { get; set; }
        public string ProfilePicURL { get; set; }
        public HttpPostedFileBase ProfileImage { set; get; }

        //Added By Divya J on 26 August 2025 For PointWest Customization
        public string SpecimenSignaturePicURL { get; set; }
        public string PassportIDPictureURL { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Nickname { get; set; }
        public string VotersID { get; set; }
        public string PAGIBIG { get; set; }
        public string FunctionalRoleID { get; set; }
        public string PhilHealthNo { get; set; }
        public string TIN { get; set; }
        public string SSSNo { get; set; }
        public string Agency { get; set; }
        public string ReasonForLeaving { get; set; }
        public string RegularizationDate { get; set; }

        //End of Added By Divya J on 26 August 2025 For PointWest Customization
        //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
        public int IsVendorMandatory { get; set; }
        //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag



    }

    public class lisEmpSaveRelease
    {
        public List<RM_EmployeeSaveRelease> Op_Parameters { get; set; }
    }
    public class RM_EmployeeSaveRelease
    {
        public int EmployeeID { get; set; }
        public int ProjectID { get; set; }
        public int ProjectRes { get; set; }
        public int ApprovalRes { get; set; }
        public int IRGenerator { get; set; }
        public int IRApprover { get; set; }
        public string ActualEndDate { get; set; }
        public string UserName { get; set; }
        // public bool MarkInActive { get; set; }
        public int WorkflowApprover { get; set; }

    }

    public class RM_EmployeeCostDetails
    {
        public int EmployeeCostID { get; set; }
        public int EmployeeID { get; set; }
        public double CostPerHour { get; set; }
        //public DateTime StartDate { get; set; }
        public string StartDate { get; set; }
        public string CreatedBy { get; set; }
    }

    public class RM_EmployeeCostSymbol
    { public string CurrencySymbol { get; set; } }
    public class RM_EmployeeSkillsDetails
    {
        public int EmployeeSkillID { get; set; }
        public int EmployeeID { get; set; }
        public int ToolID { get; set; }
        public string Description { get; set; }
        public int Proficiency { get; set; }
        public int YearsOfExperience { get; set; }
        public int MonthsOfExperience { get; set; }
        public bool HasCoreCompetency { get; set; }
        public string Notes { get; set; }
        public string ParameterValue { get; set; }

    }
    public class RM_EmployeeCurrentAssignment
    {

        public string ProjectName { get; set; }
        public string RoleDescription { get; set; }
        public string ExpectedStartDate { get; set; }
        public string ExpectedEndDate { get; set; }
        public string ActualStartDate { get; set; }
        public string ActualEndDate { get; set; }
        //Commented And Added By Reshma Chavan on 23 Feb 2022
        //public double PlannedEffort { get; set; }
        //public double ActualEffort { get; set; }
        public string PlannedEffort { get; set; }
        public string ActualEffort { get; set; }
        //End of Commented And Added By Reshma Chavan on 23 Feb 2022
        public string IsActive { get; set; }

    }

    public class RM_CurrentAssignment
    {

        public int EmployeeID { get; set; }
        public string Accessible { get; set; }
        public string Status { get; set; }
        public string IsActive { get; set; }
        public string PageNumber { get; set; }

    }

    public class RM_EmployeeGroups
    {
        public int UniqueID { get; set; }
        public int UserID { get; set; }
        public int GroupID { get; set; }
        public string LoginType { get; set; }
        public string GroupName { get; set; }
        //Added By Dipali V On 2nd March 2022 For Get Skill in edit mode
        public string EmployeeSkillID { get; set; }



    }
    public class RM_EmployeeRelease
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string PM { get; set; }
        public bool IsProjectRes { get; set; }
        public bool IsApprovalRes { get; set; }
        public bool IsInvoiceGenRes { get; set; }
        public bool IsIR_PIRAppRes { get; set; }
        public int HaveResponsibility { get; set; }
        public bool IsWorkflowApprovalRes { get; set; }
        //public string PER_DA_MAX_Date { get; set; }

    }
    public class RM_EmployeeRelList
    {
        public int EmployeeID { get; set; }
        public string EmployeeName { get; set; }
        public string IsExternal { get; set; }
        public string LastApprover { get; set; }
    }
    public class RM_EmployeeReleaseApprovers
    {
        public int EmployeeID { get; set; }
        public int EMPLOYEEID { get; set; }//Added by Divya J on 26 August for Pointwest customisation
        public string UserName { get; set; }
        //Added By Imran M. on 11 Feb 2022
        public string EmployeeName { get; set; }
        public string USERNAME { get; set; }//Added by Divya J on 26 August for Pointwest customisation
        //End of Added By Imran M. on 11 Feb 2022
        public string IsExternal { get; set; }
    }
    public class RM_EmployeeReleaseApproval
    {
        public int ProjectID { get; set; }
        public string ApproverID { get; set; }//EmployeeID
        public bool IsProjLevel { get; set; }
    }
    public class RM_EmpGroups
    {

        public int RoleID { get; set; }
        public string RoleDescription { get; set; }


    }
    public class RM_QualificationDetails
    {
        public int QualificationID { get; set; }
        public int EmployeeID { get; set; }
        public int EmployeeQualificationID { get; set; }
        public string QualificationName { get; set; }
        public string University { get; set; }
        public int PassoutYear { get; set; }
        public string Class { get; set; }
        public string PercentageDetails { get; set; }
        public double Percentage { get; set; }
        public string CreatedBy { get; set; }
    }

    //public class RM_SkillDetails
    //{
    //    public int QualificationID { get; set; }
    //    public int EmployeeID { get; set; }
    //    public int EmployeeQualificationID { get; set; }
    //    public string QualificationName { get; set; }
    //    public string University { get; set; }
    //    public string PassoutYear { get; set; }
    //    public string Class { get; set; }
    //    public string PercentageDetails { get; set; }
    //    public string Percentage { get; set; }
    //}
    public class RM_EmployeeFilterParams
    {
        public string EmpWhereClause { get; set; }
    }

    // Added by Dipali V on 6th May 2026 for vendor management - vendor dropdown params and response model
    public class RM_EmployeeVendorFilter
    {
        public int IncludeVendorID { get; set; }
    }

    public class RM_EmployeeVendorDropdown
    {
        public int VendorID { get; set; }
        public string VendorName { get; set; }
    }
    //Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag
    public class RM_EmployeeVendorMandatoryConfig
    {
        public int EmployeeID { get; set; }
    }
    //End of Added by Vishal Mane on 28/05/2026 To Make Vendor Dropdown Mandatory or Non Mandatory on Employee Master Based on Configurable Flag


    public class RM_EmployeeList //: RM_EmployeeMaster
    {
        public int EmployeeID { get; set; }
        public string RoleName { get; set; }
        public string Department { get; set; }
        public string EmailID { get; set; }
        public string Location { get; set; }
        public string UserName { get; set; }
        public string EmployeeName { get; set; }

        //public new DateTime JoiningDate { get; set; }
        //public new DateTime BirthDate { get; set; }
        //public new DateTime LeavingDate { get; set; }
        //public new decimal CostToCompany { get; set; }

    }

    public class RM_EmployeeVisaList
    {
        public int EmployeeID { get; set; }
        public int CountryID { get; set; }
        public int VisaTypeID { get; set; }
        //Commented & Added By Dipali V On 30th March 2023 For Visa Crash Issue
        //comment and added by imran on 24-08-2022
        public DateTime ValidFrom { get; set; }
        public DateTime ValidUpto { get; set; }
        //public string ValidFrom { get; set; }
        //public string ValidUpto { get; set; }
        //End of comment by imran on 24-08-2022
        //End of Commented & Added By Dipali V On 30th March 2023 For Visa Crash Issue
        public string Remarks { get; set; }
        public string CountryName { get; set; }
        public string VisaType { get; set; }

        public int EmployeeVisaID { get; set; }
        //Commented & Added By Dipali V On 30th March 2023 For Visa Crash Issue
        //comment and added by imran on 24-08-2022
        public DateTime dtValidFrom { get; set; }
        public DateTime dtValidUpto { get; set; }
        // public string dtValidFrom { get; set; }
        //public string dtValidUpto { get; set; }
        //End of comment by imran on 24-08-2022
        //End of Commented & Added By Dipali V On 30th March 2023 For Visa Crash Issue

        public string CreatedBy { get; set; }
    }

    public class RM_EmployeePreAssignmentList
    {
        public int EmployeeID { get; set; }
        public string ProjectName { get; set; }
        public int EmployeeHistoryProjectID { get; set; }
        public double Duration { get; set; }
        public int TeamSize { get; set; }
        public string Role { get; set; }
        public string Environment { get; set; }
        public string SkillSet { get; set; }
        public string Description { get; set; }
        public string CreatedBy { get; set; }
    }
    public class RM_EmployeePreWorkExperienceList
    {
        public int EmployeeID { get; set; }
        public string OrganizationName { get; set; }
        public int EmployeeHistoryID { get; set; }
        //Commented & Added By Dipali V On 30th March 2023 For Visa Crash Issue
        //comment and added by imran on 24-08-2022
        public DateTime WorkedFrom { get; set; }
        public DateTime WorkedTill { get; set; }
        //public string WorkedFrom { get; set; }
        //public string WorkedTill { get; set; }
        //End of comment by imran on 24-08-2022
        //End of Commented & Added By Dipali V On 30th March 2023 For Visa Crash Issue
        public int WorkProfileNature { get; set; }
        public string WorkProfileNatureText { get; set; }
        public string PositionHeld { get; set; }
        public string Summary { get; set; }
    }
    public class RMFilterParameter : RM_EmployeeList
    {
        public String RMWhereClause { get; set; }
    }
    public class RM_EmployeeHistory
    {
        public int EmployeeHistoryId { get; set; }
        public int EmployeeId { get; set; }
        public string FieldName { get; set; }
        public string OldValue { get; set; }
        public string NewValue { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
    }
    public class RM_Certifications
    {
        public int EmployeeID { get; set; }
        public int CertificationID { get; set; }
    }
    public class RM_EmpCertifications
    {
        public int EmployeeCertificationID { get; set; }
        public int EmployeeID { get; set; }
        public int CertificationID { get; set; }
        public string CertificationName { get; set; }
        public string CertificationDate { get; set; }
        public string ValidUpto { get; set; }
        public int Score { get; set; }
        public int TotalScore { get; set; }
        public int ActualScore { get; set; }

        public string CreatedBy { get; set; }
    }

    public class RM_XslxEmployee
    {
        //field column name
        //select EmployeeName, UserName (user), EmployeeCode, Gender, Email, BirthDate, Role(PostId), 
        //RportingTo(ID), joiningDate, BusinessGroup(BusinessGroupId), Oganization Unit(LocationID)
        //Designation(DesignationID) , Department(DepartmentID),EmployeeType,Cost To Company
        //Rate Per Hour, RateperHour(),
        //Cost Per Hour(CostPerHour) ,Deployble,Currency(CurrencyID)

        //public int EmplpoyeeID { get; set; }
        public string EmployeeName { get; set; }
        public string UserName { get; set; }
        public string EmployeeCode { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string BirthDate { get; set; }
        public int RoleID { get; set; }
        public int ReportingToId { get; set; }
        public string JoiningDate { get; set; }
        public int BusinessGroupID { get; set; }
        public int LocationID { get; set; }
        public int DesignationID { get; set; }
        public int DepartmentID { get; set; }
        public string EmployeeType { get; set; }
        public decimal CostToCompany { get; set; }
        public decimal RatePerHr { get; set; }
        public decimal CostPerHr { get; set; }
        public string Deployable { get; set; }
        public int CurrencyID { get; set; }
        public string ColumnError { get; set; }
        /// <summary>
        /// Text field to get IDs BG TO Role
        /// </summary>
        public string BusinessGroup { get; set; }
        public string OrganizationUnit { get; set; }
        public string Designation { get; set; }
        public string Department { get; set; }
        public string Currency { get; set; }
        public string RoleName { get; set; }
        public string ReportingTo { get; set; }
        public string UploadedBy { get; set; }
    }
    public class Emp_ReturnID
    {
        public string Message { get; set; }
        public int EmployeeID { get; set; }
    }
    public class RM_ReleaseResource
    {
        public int EmployeeId { get; set; }
        public int ReportingToId { get; set; }
        public DateTime LeavingDate { get; set; }
        //Added by reshma on 03-03-2022
        public string CreatedBy { get; set; }
        public string ReasonForLeaving { get; set; } //Added by Dipali V On 18th Aug 2022
        //End of comment 03-03-2022
    }

    public class RM_SubTab
    {
        public int EmployeeId { get; set; }
        public int ContractTypeID { get; set; }
        public int EmpContractTypeId { get; set; }
        public string EffectiveFrom { get; set; }
        public string EffectiveTo { get; set; }
        public string Remarks { get; set; }
        public string UserName { get; set; }
        public int EmployeeTrainingID { get; set; }
        public int TrainingID { get; set; }
        public string SponseredBy { get; set; }
        public string Achivements { get; set; }
        public string TrainingCost { get; set; }
        public string ConductedBy { get; set; }

        public int BusinessGroupID { get; set; }
        public int OrganizationUnitID { get; set; }
        public int DeliveryUnitID { get; set; }
        public int UniqueID { get; set; }
        public int OldDesignationID { get; set; }
        public int NewDesignationID { get; set; }
        public int MovementTypeID { get; set; }
        public string EffectiveDate { get; set; }
        public int OldPracticeID { get; set; }
        public int NewPracticeID { get; set; }
        public int OldBusinessGroupID { get; set; }
        public int NewBusinessGroupID { get; set; }
        public int OldOrganizationUnitID { get; set; }
        public int NewOrganizationUnitID { get; set; }
        public int OldDeliveryUnitID { get; set; }
        public int NewDeliveryUnitID { get; set; }
        public string NewRate { get; set; }
        public string Comments { get; set; }
        public string ExpectedReturnDate { get; set; }
        public char LoginType { get; set; }


    }
}