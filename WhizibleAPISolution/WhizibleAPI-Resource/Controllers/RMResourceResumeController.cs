using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Net;
using System.Net.Http;
using System.Configuration;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.IO;
using System.Xml;




namespace WhizibleAPI.Controllers
{

    public class RMResourceResumeController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResourceResume([FromBody] OU_Params OuOuParameter)
        {

            EmployeeResume employeeResume = new EmployeeResume();
            try
            {
                if (OuOuParameter.EmployeeID > 0)
                {

                    DataTable EmployeeInfoData = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_EmployeeInfo " + OuOuParameter.EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeQaulificationData = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_sel_tbl_PM_EmployeeQualificationMatrix NULL,NULL,NULL," + OuOuParameter.EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeCeryificationData = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_sel_tbl_PM_EmployeeCertificationMatrix NULL,NULL,NULL," + OuOuParameter.EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeSkillData = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_sel_tbl_PM_EmployeeSkillMatrix NULL,NULL,NULL," + OuOuParameter.EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeAssignmentData = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_sel_tbl_CurrentAssignmentsForEmployee " + OuOuParameter.EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeePreviousAssignmentData = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_tbl_PM_EmployeeHistory_Projects " + OuOuParameter.EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeHistoryData = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_tbl_PM_EmployeeHistory NULL,NULL," + OuOuParameter.EmployeeID, true, CommonController.connectionString);

                    string strSQL = "usp_Whizible2_Sel_tbl_OU_EmployeeImage " + OuOuParameter.EmployeeID;
                    var emplyeeImage = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    employeeResume.ProfileImage = emplyeeImage;
                    foreach (DataRow taskStatusRow in EmployeeInfoData.Rows)
                    {
                        OU_EmployeeInfo empInfo = new OU_EmployeeInfo()
                        {
                            EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeID"], "0")),
                            PostID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["PostID"], "0")),
                            EmployeeCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeCode"], "")),
                            EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeName"], "")),
                            Address = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Address"], "")),
                            City = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["City"], "")),
                            State = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["State"], "")),
                            Country = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Country"], "")),
                            PinCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["PinCode"], "")),
                            Phone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Phone"], "")),
                            EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmailID"], "")),
                            Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Designation"], "")),
                            JoiningDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["JoiningDate"], "")),
                            BirthDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["BirthDate"], "")),

                        };
                        empInfo.DOB = empInfo.BirthDate.ToString("dd/MM/yyyy");
                        employeeResume.EmployeeInfo = empInfo;

                    }
                    List<EmployeeQualificationMatrix> lstEmpQl = new List<EmployeeQualificationMatrix>();
                    foreach (DataRow taskStatusRow in EmployeeQaulificationData.Rows)
                    {
                        EmployeeQualificationMatrix empQl = new EmployeeQualificationMatrix()
                        {
                            EmployeeQualificationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeQualificationID"], "0")),
                            QualificationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["QualificationName"], "")),
                            University = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["University"], "")),
                            EmployeeClass = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Class"], "")),
                            Percentage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Percentage"], "")),
                            PassoutYear = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["PassoutYear"], "")),
                            QualificationDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["QualificationDetails"], ""))

                        };

                        lstEmpQl.Add(empQl);
                    }
                    employeeResume.EmployeeQualificationlst = lstEmpQl;

                    List<EmployeeCertificationMatrix> lstEmpCert = new List<EmployeeCertificationMatrix>();
                    foreach (DataRow taskStatusRow in EmployeeCeryificationData.Rows)
                    {
                        EmployeeCertificationMatrix empcert = new EmployeeCertificationMatrix()
                        {
                            CertificationDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CertificationDate"], "")),

                            EmployeeCertificationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeCertificationID"], "0")),
                            CertificationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CertificationName"], "")),
                            // CertValidDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ValidUpto"], "")),
                            CertValidDate = String.Format("{0:dd/MM/yyyy}", taskStatusRow["ValidUpto"]),
                            ActualScore = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualScore"], "")),
                            TotalScore = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TotalScore"], "")),
                            CertificationDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CertificationDetails"], "")),


                        };
                        empcert.CertDate = empcert.CertificationDate.ToString("dd/MM/yyyy");
                        //if (empcert.CertValidDate != null && empcert.CertValidDate != "")
                        //{
                        //    empcert.CertValidDate = empcert.ValidUpto.ToString("dd/MM/yyyy");
                        //}


                        lstEmpCert.Add(empcert);
                    }
                    employeeResume.EmployeeCertificationlst = lstEmpCert;

                    List<EmployeeSkillMatrix> lstSkills = new List<EmployeeSkillMatrix>();
                    foreach (DataRow taskStatusRow in EmployeeSkillData.Rows)
                    {
                        EmployeeSkillMatrix empskill = new EmployeeSkillMatrix()
                        {

                            EmployeeSkillID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeSkillID"], "0")),
                            Tool = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Tool"], "")),
                            YearsOfExperiance = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["YearsOfExperience"], "")),
                            MonthsOfExperiance = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["MonthsOfExperience"], "")),
                            TrainingHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TrainingHours"], "")),
                            TechnicalSkills = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TechnicalSkills"], "")),

                        };

                        lstSkills.Add(empskill);
                    }
                    employeeResume.EmployeeSkillslst = lstSkills;

                    List<CurrentAssignmentsForEmployee> lstAssignments = new List<CurrentAssignmentsForEmployee>();
                    foreach (DataRow taskStatusRow in EmployeeAssignmentData.Rows)
                    {
                        CurrentAssignmentsForEmployee empassignment = new CurrentAssignmentsForEmployee()
                        {

                            TeamSize = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TeamSize"], "0")),
                            ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectName"], "")),
                            ProjectCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectCode"], "")),
                            Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Description"], "")),
                            RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RoleDescription"], "")),
                            Responsibility = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Responsibility"], "")),
                            AssignmentStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["AssignmentStatus"], "")),
                            ProjectStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectStatus"], "")),
                            Tools = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Tools"], "")),
                            Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Duration"], "")),
                            ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualStartDate"], "")),
                            ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualEndDate"], "")),
                            StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["StartDate"], "")),
                            EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EndDate"], ""))

                        };
                        empassignment.DurationText = GetDurationWithDate(empassignment.StartDate, empassignment.EndDate, empassignment.Duration).DurationText;
                        lstAssignments.Add(empassignment);
                    }
                    employeeResume.CurrentAssignments = lstAssignments;

                    List<PreviousAssignmentsForEmployee> lstoldAssignments = new List<PreviousAssignmentsForEmployee>();
                    foreach (DataRow taskStatusRow in EmployeePreviousAssignmentData.Rows)
                    {
                        PreviousAssignmentsForEmployee empassignment = new PreviousAssignmentsForEmployee()
                        {

                            EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeID"], "0")),
                            TeamSize = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TeamSize"], "0")),
                            ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectName"], "")),
                            Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Description"], "")),
                            Role = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Role"], "")),
                            Environment = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Environment"], "")),
                            SkillSet = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["SkillSet"], "")),
                            Duration = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Duration"], "0")),
                            CalculatedDuration = Convert.ToInt16(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CalculatedDuration"], "0")),


                            //ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualStartDate"], "")),
                            //ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualEndDate"], "")),
                            //DurationText= Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["strDuration"], ""))


                        };
                        //if (!string.IsNullOrEmpty(empassignment.ActualStartDate)  && empassignment.ActualStartDate !=null && string.IsNullOrEmpty(empassignment.ActualEndDate) && empassignment.ActualEndDate!=null)
                        //{
                        //    empassignment.DurationText = GetDurationWithDate(empassignment.ActualStartDate, DateTime.Now.ToString(), null).DurationText;
                        //}
                        //else if (!string.IsNullOrEmpty(empassignment.ActualStartDate) && empassignment.ActualStartDate != null && !string.IsNullOrEmpty(empassignment.ActualEndDate) && empassignment.ActualEndDate != null)
                        //{
                        //    empassignment.DurationText = GetDurationWithDate(empassignment.ActualStartDate, empassignment.ActualEndDate, null).DurationText;
                        //}
                        //else
                        //{
                        //  empassignment.DurationText = string.Concat(empassignment.Duration > 0 ? empassignment.Duration.ToString() : "0", " Year(s)");
                        //}
                        if (empassignment != null && empassignment.Duration > 0 && empassignment.CalculatedDuration == 0)
                        {

                            empassignment.DurationText = GetFormatedDuration(empassignment.Duration.ToString());
                            //string msg = string.Format("{0} Year(s) {1} Month(s)", "", "");
                        }
                        if (empassignment != null && empassignment.CalculatedDuration > 0 && empassignment.Duration == 0)
                        {
                            empassignment.DurationText = GetDurationUsingDays(empassignment.CalculatedDuration);
                        }

                        lstoldAssignments.Add(empassignment);
                    }
                    employeeResume.PreviousAssignments = lstoldAssignments;


                    List<EmployeeHistory> lstEmpHistory = new List<EmployeeHistory>();
                    foreach (DataRow taskStatusRow in EmployeeHistoryData.Rows)
                    {
                        EmployeeHistory empHistory = new EmployeeHistory()
                        {
                            EmployeeHistoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["EmployeeHistoryID"], "0")),
                            OrganizationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["OrganizationName"], "")),
                            WorkProfileNature = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["WorkProfileNature"], "")),
                            AnnualSalaryRange = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["AnnualSalaryRange"], "0")),
                            PositionHeld = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["PositionHeld"], "")),
                            WorkedFrom = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["WorkedFrom"], "")),
                            WorkedTill = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["WorkedTill"], "")),
                            PreviousWorkExperiance = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["PreviousWorkExperiance"], ""))

                        };



                        lstEmpHistory.Add(empHistory);
                    }
                    employeeResume.EmployeeHistorylst = lstEmpHistory;

                    return Request.CreateResponse(HttpStatusCode.OK, employeeResume);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "Bad Request found");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        private ResourceDuration GetDurationWithDate(string StartDate, string EndDate, string Duration = null)
        {
            string str = string.Empty;
            ResourceDuration objDuration = new ResourceDuration();
            if (!string.IsNullOrEmpty(StartDate) && !string.IsNullOrEmpty(EndDate))
            {
                DateTime startDate;
                DateTime.TryParse(StartDate, out startDate);
                DateTime endDate;
                DateTime.TryParse(EndDate, out endDate);
                TimeSpan ts = endDate - startDate;
                var years = ts.Days / 365;
                var months = (ts.Days % 365) / 31;
                var totalDays = ts.Days; //(endDate - startDate).TotalDays;
                var totalYears = years;// Math.Truncate(totalDays / 365);
                var totalMonths = months; //Math.Truncate((totalDays % 365) / 30);
                var remainingDays = (totalDays % 365) % 31;// Math.Truncate((totalDays % 365) % 30);

                if (remainingDays > 0)
                {
                    totalMonths = totalMonths + 1;
                }
                if (totalMonths >= 12)
                {
                    totalYears = totalYears + 1;
                }
                var durationinyrmnth = "";
                if (totalYears > 0 && totalMonths < 12)
                {
                    if (Duration != null)
                    {
                        durationinyrmnth = "(" + totalYears + " Year(s) and " + totalMonths + " Month(s))";
                    }
                    else
                    {
                        durationinyrmnth = totalYears + " Year(s) and " + totalMonths + " Month(s)";
                    }

                }
                else if (totalYears == 0 && totalMonths < 12)
                {
                    if (Duration != null)
                    {
                        durationinyrmnth = "(" + totalMonths + " Month(s))";
                    }
                    else
                    {
                        durationinyrmnth = totalMonths + " Month(s)";
                    }

                }
                //else
                //{
                //    durationinyrmnth = "(" + totalMonths + " Months)";
                //}
                if (Duration != null)
                {
                    objDuration.DurationText = string.Concat(Duration, " ", durationinyrmnth);
                }
                else
                {
                    objDuration.DurationText = durationinyrmnth;
                }



                //objDuration.DurationFormat = "From " + startDate.ToString("dd MMMM yyyy") + " To " + endDate.ToString("dd MMMM yyyy");


            }
            return objDuration;

        }

        private string GetFormatedDuration(string Duartion)
        {

            string strDurationYear = string.Empty;
            string strDurationMonth = string.Empty;
            string strDuration = string.Empty;
            if (!string.IsNullOrEmpty(Duartion))
            {
                var DurationArr = Duartion.Split('.');
                if (DurationArr[0] != "0")
                {
                    strDurationYear = DurationArr[0] + " Years(s) ";
                }
                if (DurationArr.Length > 1 && DurationArr[1] != "0")
                {
                    strDurationMonth = DurationArr[1] + " Month(s) ";
                }
                if (!string.IsNullOrEmpty(strDurationYear) && !string.IsNullOrEmpty(strDurationMonth))
                {
                    strDuration = string.Concat(strDurationYear, "and ", strDurationMonth);
                }
                else if (string.IsNullOrEmpty(strDurationYear) && !string.IsNullOrEmpty(strDurationMonth))
                {
                    strDuration = strDurationMonth;
                }
                else if (!string.IsNullOrEmpty(strDurationYear) && string.IsNullOrEmpty(strDurationMonth))
                {
                    strDuration = strDurationYear;
                }
                else
                {
                    strDuration = "0 Year(s)";
                }
            }

            return strDuration;
        }
        private string GetDurationUsingDays(int Days)
        {
            string strDUration = string.Empty;
            var totalDays = Days; //(endDate - startDate).TotalDays;
            var totalYears = Days / 365;
            var totalMonths = (Days % 365) / 31;
            var remainingDays = (totalDays % 365) % 31;// Math.Truncate((totalDays % 365) % 30);

            if (remainingDays > 0)
            {
                totalMonths = totalMonths + 1;
            }
            if (totalMonths >= 12)
            {
                totalYears = totalYears + 1;
            }
            if (totalYears > 0 && totalMonths < 12)
            {

                strDUration = totalYears + " Year(s) and " + totalMonths + " Month(s)";

            }
            else if (totalYears == 0 && totalMonths < 12)
            {
                strDUration = totalMonths + " Month(s)";
            }

            return strDUration;

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

        public class ResourceDuration
        {
            public string DurationText { get; set; }
            public string DurationFormat { get; set; }
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

    }



}