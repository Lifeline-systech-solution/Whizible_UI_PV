using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;
using WhizibleAPI.Models.Timesheet;

namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RM_OrganizationUnitController : ApiController
    {

        [HttpPost]
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        //End of comment by imran on 19-08-2022
        public HttpResponseMessage GetOrganizationUnitData([FromBody] OUFilterParameter OuFilterParameter)
        {
            string filterParms = null;
            List<RM_OrganizationUnit> organizationUnitList = new List<RM_OrganizationUnit>();
            try
            {
                if (OuFilterParameter != null && OuFilterParameter.OUWhereClause != null && !string.IsNullOrEmpty(OuFilterParameter.OUWhereClause))
                {
                    //filterParms = "ManagerID = "+ OuFilterParameter.ManagerID + " AND ";
                    // filterParms = filterParms + OuFilterParameter.OUWhereClause;
                    filterParms = HttpUtility.UrlDecode(OuFilterParameter.OUWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }

                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_OU_OrganizationUnit " + OuFilterParameter.ManagerID + ",'" + filterParms + "'";
                    //strSQL = "usp_Whizible2_sel_tbl_OU_OrganizationUnit " + OuFilterParameter.ManagerID +", "+ filterParms;
                }
                else
                {
                    strSQL = "usp_Whizible2_sel_tbl_OU_OrganizationUnit " + OuFilterParameter.ManagerID;
                }

                DataTable OrganizationUnit = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (OrganizationUnit != null)
                {
                    organizationUnitList = OrganizationUnit.ToList<RM_OrganizationUnit>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, organizationUnitList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");

            }
            


        }

        [HttpPost]
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        public HttpResponseMessage GetOrganizationUnitManagerData(OU_Params OuOuParameter)
        {

            List<RM_OrganizationUnitManagers> organizationUnitManagerList = new List<RM_OrganizationUnitManagers>();
            try
            {
                DataTable OrganizationUnitManager = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_OU_Managers " + OuOuParameter.OUPoolID, true, CommonController.connectionString);

                organizationUnitManagerList = OrganizationUnitManager.ToList<RM_OrganizationUnitManagers>();

                return Request.CreateResponse(HttpStatusCode.OK, organizationUnitManagerList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            


        }

        [HttpPost]
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        public HttpResponseMessage GetOrganizationResouceData(OU_Params OuOuParameter)
        {

            List<RM_OU_Resouces> organizationResourcerList = new List<RM_OU_Resouces>();
            try
            {
                DataTable OrganizationResource = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_OU_Resources " + OuOuParameter.OUPoolID + ", " + OuOuParameter.RoleID, true, CommonController.connectionString);

                organizationResourcerList = OrganizationResource.ToList<RM_OU_Resouces>();

                return Request.CreateResponse(HttpStatusCode.OK, organizationResourcerList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");

            }
            


        }

        [HttpPost]
        // [Authorize]
        public HttpResponseMessage GetOrganizationRoles()
        {

            List<RM_OU_Role> organizationRoleList = new List<RM_OU_Role>();

            try
            {
                DataTable OrganizationRole = CommonFunctions.Data.GetDataTable("Select RoleDescription,RoleID From tbl_PM_Role Where RoleID <> 23 and IsUserGroup=0 Order By RoleDescription", true, CommonController.connectionString);

                //End of Added By Dipali V On 26th March 2020 For Timehseet not listout
                foreach (DataRow taskStatusRow in OrganizationRole.Rows)
                {
                    RM_OU_Role orgrole = new RM_OU_Role()
                    {
                        RoleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RoleID"], "0")),
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RoleDescription"], ""))


                    };

                    organizationRoleList.Add(orgrole);
                }

                return Request.CreateResponse(HttpStatusCode.OK, organizationRoleList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");

            }
            


        }


        [HttpPost]
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveOUManager([FromBody] RM_OU_Manager OU_ManagerParameters)
        {
            try
            {
                if (OU_ManagerParameters != null)
                {
                    var flag = 0;
                    if (OU_ManagerParameters.IsPrimaryResponsible)
                    {
                        flag = 1;
                    }
                    string strSQL = "EXEC usp_Whizible2_Ins_tbl_OU_Manager " + OU_ManagerParameters.OrganizationUnitID + "," + OU_ManagerParameters.ManagerID + "," + flag;
                    // string strSQL = "Exec usp_Whizible2_InsUpd_tbl_BG_Manager " + BG_ManagerParameters.UniqueID + "," + BG_ManagerParameters.BusinessGroupID + "," + BG_ManagerParameters.ManagerID + ",'" + BG_ManagerParameters.IsPrimaryResponsible + "'";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    return Request.CreateResponse(HttpStatusCode.OK, "Success");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "Input Model is Null");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage SaveOUManagers([FromBody] RM_OU_Manager OU_ManagerParameters)
        {
            
            try
            {
                string strtResult = string.Empty;
                if (OU_ManagerParameters != null && OU_ManagerParameters.ManagerID > 0 && OU_ManagerParameters.OrganizationUnitID > 0)
                {
                    //string strSQL = "Exec usp_Whizible2_InsUpd_tbl_BG_Manager " + BG_ManagerParameters.UniqueID + "," + BG_ManagerParameters.BusinessGroupID + "," + BG_ManagerParameters.ManagerID + ",'" + BG_ManagerParameters.IsPrimaryResponsible + "'";
                    string strSQL = "Exec usp_Whizible2_InsUpd_tbl_OU_Manager " + OU_ManagerParameters.UniqueID + "," + OU_ManagerParameters.OrganizationUnitID + "," + OU_ManagerParameters.ManagerID + " ," + OU_ManagerParameters.NewManagerID + ",'" + OU_ManagerParameters.IsPrimaryResponsible + "'";
                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }
                    //else
                    //{
                    //    return Request.CreateResponse(HttpStatusCode.Created, "Updated");
                    //}

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }


        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteOUManager([FromBody] string UniqueIDs)
        {

            string Result = "";
            try
            {
                if (UniqueIDs != null)
                {
                    //u can delete in clause or on bye one and notify the user
                    var splitParmas = UniqueIDs.Split(',');

                    foreach (var itemMGID in splitParmas)
                    {
                        string strSQL = "usp_Whizible2_Del_tbl_OU_Manager " + itemMGID;
                        var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (srtResult != "Deleted")
                        {
                            Result += srtResult;
                        }
                    }

                    //// string strSQL = "Exec usp_Whizible2_Del_tbl_BG_Manager " + itemUniqueID + " ";
                    //string strSQL = "usp_Whizible2_Del_tbl_OU_Manager " + UniqueIDs;
                    //    var outParms=  CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    // strResult = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.InsertOrUpdateData("usp_Whizible2_Del_tbl_BG_Manager " + itemUniqueID, true, CommonController.connectionString), ""));
                    return Request.CreateResponse(HttpStatusCode.OK, Result);

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "Input Model is Null");
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetOUManager(OU_Params OuOuParameter)
        {
            var OuManagerList = new List<RM_OU_Manager>();
            RM_OU_Manager oU_Manager = new RM_OU_Manager();
            try
            {
                DataTable OuManagerTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_OU_ManagerByUniqueID " + OuOuParameter.UniqueID, true, CommonController.connectionString);
                if (OuManagerTable != null && OuManagerTable.Rows.Count > 0)
                {
                    DataRow taskListRow = OuManagerTable.Rows[0];


                    oU_Manager.UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["UniqueID"], "0"));
                    oU_Manager.ManagerID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ManagerID"], "0"));
                    oU_Manager.Manager = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["EmployeeName"], ""));
                    oU_Manager.IsPrimaryResponsible = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsPrimaryResponsible"], "false"));
                    oU_Manager.OrganizationUnitID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["OUPoolID"], "0"));
                    oU_Manager.Responsibilities = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Responsibilities"], ""));

                    OuManagerList.Add(oU_Manager);
                    // return oU_Manager;
                }
                else
                {
                    return null;
                }
                // BgManagerList = OuManagerTable.ToList<OU_Manager>();
                return Request.CreateResponse(HttpStatusCode.OK, oU_Manager);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }


        [HttpPost]
        public HttpResponseMessage GetOUResourceRoleGraph(OU_Params OuOuParameter)
        {
            var OU_RolesGraphList = new List<RM_OU_RolesGraph>();
            try
            {
                DataTable OU_GraphTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_OU_Roles_Graph " + OuOuParameter.OrganizationUnitID + "", true, CommonController.connectionString);
                if (OU_GraphTable != null && OU_GraphTable.Rows.Count > 0)
                {
                    decimal totalCount = Convert.ToDecimal(OU_GraphTable.Compute("Sum(RoleCount)", "RoleCount > 0"));
                    var OU_RolesGraph = new RM_OU_RolesGraph();
                    OU_RolesGraph.LstLabel = new List<string>();
                    OU_RolesGraph.LstColor = new List<string>();
                    OU_RolesGraph.LstData = new List<int>();
                    foreach (DataRow ouGraphRow in OU_GraphTable.Rows)
                    {
                        var count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ouGraphRow["RoleCount"], "0"));
                        decimal perc = count > 0 ? (count * 100) / totalCount : 0;
                        string roleDec = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ouGraphRow["RoleDescription"], ""));
                        string RoleDecPerce = string.Concat(roleDec, "(", perc.ToString("0.00") + "%", ")");
                        OU_RolesGraph.LstLabel.Add(RoleDecPerce);
                        OU_RolesGraph.LstData.Add(count);
                        OU_RolesGraph.LstColor.Add(GetBGRoleColor());
                    }

                    OU_RolesGraphList.Add(OU_RolesGraph);
                }
                return Request.CreateResponse(HttpStatusCode.OK, OU_RolesGraphList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            

        }

        [HttpPost]
        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        public HttpResponseMessage GetOrganizationUnitDeliveryData(OU_Params OuOuParameter)
        {

            List<RM_OU_DeliveryUnit> organizationUnitDeliveryList = new List<RM_OU_DeliveryUnit>();

            try
            {
                DataTable OrganizationUnitDelivery = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_OU_DeliveryUnit " + OuOuParameter.OUPoolID, true, CommonController.connectionString);

                organizationUnitDeliveryList = OrganizationUnitDelivery.ToList<RM_OU_DeliveryUnit>();

                return Request.CreateResponse(HttpStatusCode.OK, organizationUnitDeliveryList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
            
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateOUManager([FromBody] RM_OU_Manager OU_ManagerParameters)
        {
            try
            {
                if (OU_ManagerParameters != null)
                {
                    var flag = 0;
                    if (OU_ManagerParameters.IsPrimaryResponsible)
                    {
                        flag = 1;
                    }
                    // string strSQL = "EXEC sp_executeSQL N'INSERT INTO tbl_PM_OUPool_Managers(OUPoolID,ManagerID,IsPrimaryResponsible)VALUES (" + OU_ManagerParameters.OrganizationUnitID + "," + OU_ManagerParameters.ManagerID + "," + flag + ")Select ''PK'' = SCOPE_IDENTITY() '";
                    string strSQL = "EXEC usp_Whizible2_Upd_tbl_OU_Manager " + OU_ManagerParameters.UniqueID + "," + OU_ManagerParameters.ManagerID + "," + flag;
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    return Request.CreateResponse(HttpStatusCode.OK, "Success");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "Input Model is Null");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        public HttpResponseMessage GetResourceResume(OU_Params OuOuParameter)
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

                    //    +";" +
                    //   "Exec usp_Sel_tbl_PM_EmployeeQualificationMatrix NULL,NULL,NULL," + EmployeeID + ";" +
                    //    "Exec usp_Sel_tbl_PM_EmployeeCertificationMatrix NULL,NULL,NULL," + EmployeeID + ";" +
                    //    "Exec usp_Sel_tbl_PM_EmployeeSkillMatrix NULL,NULL,NULL," + EmployeeID + ";" +
                    //    "Exec usp_Sel_tbl_PM_EmployeeHistory NULL,NULL," + EmployeeID + ";" +
                    //    "Exec usp_sel_CurrentAssignmentsForEmployee " + EmployeeID + ";" +
                    //    "Exec usp_Sel_tbl_PM_EmployeeHistory_Projects " + EmployeeID + ";" +
                    //    "Exec usp_tbl_Sel_EmployeeVisaInfo " + EmployeeID + ";" +
                    //    "SELECT SystemFilename FROM tbl_RM_EmployeeMaintenance_Attachment  WHERE EmployeeID=" + EmployeeID;




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
                    return Request.CreateResponse(HttpStatusCode.OK, "Input Model is Null");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        #region Private method

        private string GetBGRoleColor()
        {
            var RandomBgGraph = new Random();
            Thread.Sleep(20);
            var ColorBGGraph = $"#{RandomBgGraph.Next(8, 0xFFFFFF):X6}";
            return ColorBGGraph;
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


            #endregion
        }

    }
}
public class ResourceDuration
{
    public string DurationText { get; set; }
    public string DurationFormat { get; set; }
}
