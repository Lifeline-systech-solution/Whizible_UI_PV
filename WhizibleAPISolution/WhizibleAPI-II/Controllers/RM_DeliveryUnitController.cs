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

namespace WhizibleAPI.Controllers
{
    public class RM_DeliveryUnitController : ApiController
    {

        [HttpPost]
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]   
        //End of comment by imran on 19-08-2022
        public HttpResponseMessage GetDeliveryUnitData([FromBody] DUFilterParameter DuFilterParameter)
        {
            string filterParms = null;
            List<RM_DeliveryUnit> deliveryUnitList = new List<RM_DeliveryUnit>();
            try
            {
                 if (DuFilterParameter != null && DuFilterParameter.DUWhereClause != null && !string.IsNullOrEmpty(DuFilterParameter.DUWhereClause))
                {
                    //  filterParms  = filterParms + DuFilterParameter.DUWhereClause;
                    filterParms = HttpUtility.UrlDecode(DuFilterParameter.DUWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }

                string strSQL = "";
                if (filterParms!=null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_DU_DeliveryUnit "+ DuFilterParameter.ManagerID +",'" + filterParms + "'";
                   //strSQL = "usp_Whizible2_sel_tbl_OU_OrganizationUnit " + OuFilterParameter.ManagerID +", "+ filterParms;
                }
                else
                {
                    strSQL ="usp_Whizible2_sel_tbl_DU_DeliveryUnit " + DuFilterParameter.ManagerID;
                }
                DataTable DeliveryUnit = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                if (DeliveryUnit != null)
                {
                   deliveryUnitList = DeliveryUnit.ToList<RM_DeliveryUnit>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, deliveryUnitList);


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
        public HttpResponseMessage GetDUDeliveryTeams(DU_Params DuOuParameter)
        {           
            var DuDeliveryTeamsList = new List<DU_DeliveryTeam>();
            try
            {
                if (DuOuParameter.ResourcePoolID > 0)
                {
                    //usp_Whizible2_Sel_tbl_BG_v_tbl_CNF_BusinessGroup_OUPools_OrgUnits
                    string strSQL = "usp_Whizible2_sel_tbl_DU_DeliveryTeams " + DuOuParameter.ResourcePoolID;
                    DataTable DuDeliveryTeamsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (DuDeliveryTeamsListTable != null)
                    {
                        DuDeliveryTeamsList = DuDeliveryTeamsListTable.ToList<DU_DeliveryTeam>();
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, DuDeliveryTeamsList);
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
        public HttpResponseMessage GetDUManagers(DU_Params DuMangerParameter)
        {
            var DuManagerList = new List<DU_Manager>();
            try
            {
                if (DuMangerParameter.ResourcePoolID > 0)
                {
                    string strSQL = "usp_Whizible2_sel_tbl_DU_Managers " + DuMangerParameter.ResourcePoolID ;
                    DataTable DuManagerTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (DuManagerTable != null)
                        DuManagerList = DuManagerTable.ToList<DU_Manager>();

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, DuManagerList);

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
        public HttpResponseMessage GetDUResources(DU_Params DU_ResourceParameters)
        {
            var DU_ResourceList = new List<DU_Resource>();
            try
            {
                //Commented and added by Chetan M on 5 Jul 2021 for Filter Issue
                //if (DU_ResourceParameters != null && DU_ResourceParameters.ResourcePoolID > 0 && DU_ResourceParameters.RoleID > 0)
                if (DU_ResourceParameters != null && DU_ResourceParameters.ResourcePoolID > 0)
                //End of Commented and added by Chetan M on 5 Jul 2021 for Filter Issue
                {
                    string strSQL = "usp_Whizible2_sel_tbl_DU_Resources " + DU_ResourceParameters.ResourcePoolID + "," + DU_ResourceParameters.RoleID ;
                    DataTable DU_ResourceTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (DU_ResourceTable != null)
                        DU_ResourceList = DU_ResourceTable.ToList<DU_Resource>();
                    return Request.CreateResponse(HttpStatusCode.OK, DU_ResourceList);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            //return Request.CreateResponse(HttpStatusCode.OK, BG_ResourceList);
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetDUManager(DU_Params DU_ResourceParameters)
        {
            var duManagerList = new List<RM_DU_Manager>();
            RM_DU_Manager dU_Manager = new RM_DU_Manager();
            try
            {
                DataTable DuManagerTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_DU_ManagerByUniqueID " + DU_ResourceParameters.UniqueID, true, CommonController.connectionString);
                if (DuManagerTable != null && DuManagerTable.Rows.Count > 0)
                {
                    DataRow taskListRow = DuManagerTable.Rows[0];


                    dU_Manager.UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["UniqueID"], "0"));
                    dU_Manager.ManagerID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ManagerID"], "0"));
                    dU_Manager.Manager = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Manager"], ""));
                    dU_Manager.IsPrimaryResponsible = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsPrimaryResponsible"], "false"));
                    dU_Manager.ResourcePoolID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourcePoolID"], "0"));
                    dU_Manager.Responsibilities = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Responsibilities"], ""));

                    duManagerList.Add(dU_Manager);
                    // return oU_Manager;
                }
                else
                {
                    return null;
                }
                // BgManagerList = OuManagerTable.ToList<OU_Manager>();
                return Request.CreateResponse(HttpStatusCode.OK, dU_Manager);
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteDUanager([FromBody] string DU_ManagerParameters)
        {
            try
            {
                 
                if (DU_ManagerParameters != null)
                {
                    string Result = "";
                    var DU_MGRLIST = DU_ManagerParameters.Split(',').ToList();
                    //usp_Whizible2_Del_tbl_BG_Manager
                    foreach (var itemMGID in DU_MGRLIST)
                    {
                        //string strSQL = "Exec usp_Whizible2_Del_tbl_BG_Manager '" + BG_ManagerParameters + "'";
                        string strSQL = "usp_Whizible2_Del_tbl_DU_Manager " + itemMGID;
                        var  srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                          if (srtResult!="Deleted")
                        {
                            Result += srtResult;
                        }
                    }

                    return Request.CreateResponse(HttpStatusCode.OK, Result);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.InternalServerError);
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
        public HttpResponseMessage SaveDUManagers([FromBody] RM_DU_Manager DU_ManagerParameters)
        {
            string strtResult = string.Empty;
            try
            {
                if (DU_ManagerParameters != null && DU_ManagerParameters.ManagerID > 0 && DU_ManagerParameters.ResourcePoolID > 0)
                {
                    //string strSQL = "Exec usp_Whizible2_InsUpd_tbl_BG_Manager " + BG_ManagerParameters.UniqueID + "," + BG_ManagerParameters.BusinessGroupID + "," + BG_ManagerParameters.ManagerID + ",'" + BG_ManagerParameters.IsPrimaryResponsible + "'";
                    //Commented and added by Chetan M on 11 Aug 2021 for History
                    //string strSQL = "Exec usp_Whizible2_InsUpd_tbl_DU_Manager " + DU_ManagerParameters.UniqueID + "," + DU_ManagerParameters.ResourcePoolID + "," + DU_ManagerParameters.ManagerID + " ," + DU_ManagerParameters.NewManagerID + ",'" + DU_ManagerParameters.IsPrimaryResponsible + "'";
                    string strSQL = "Exec usp_Whizible2_InsUpd_tbl_DU_Manager " + DU_ManagerParameters.UniqueID + "," + DU_ManagerParameters.ResourcePoolID + "," + DU_ManagerParameters.ManagerID + " ," + DU_ManagerParameters.NewManagerID + ",'" + DU_ManagerParameters.IsPrimaryResponsible + "','"+ DU_ManagerParameters.ModifiedBy+ "'";
                    //End of Commented and added by Chetan M on 11 Aug 2021 for History
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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveDUManager([FromBody] RM_DU_Manager DU_ManagerParameters)
        {
            try
            {
                if (DU_ManagerParameters != null)
                {
                    var flag = 0;
                    if (DU_ManagerParameters.IsPrimaryResponsible)
                    {
                        flag = 1;
                    }
                    string strSQL = "EXEC usp_Whizible2_Ins_tbl_DU_Manager " + DU_ManagerParameters.ResourcePoolID + "," + DU_ManagerParameters.ManagerID + "," + flag;
                   
                    var result  = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    return Request.CreateResponse(HttpStatusCode.OK, result);
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UpdateDUManager([FromBody] RM_DU_Manager DU_ManagerParameters)
        {
            try
            {
                if (DU_ManagerParameters != null)
                {
                    var flag = 0;
                    if (DU_ManagerParameters.IsPrimaryResponsible)
                    {
                        flag = 1;
                    }
                    // string strSQL = "EXEC sp_executeSQL N'INSERT INTO tbl_PM_OUPool_Managers(OUPoolID,ManagerID,IsPrimaryResponsible)VALUES (" + OU_ManagerParameters.OrganizationUnitID + "," + OU_ManagerParameters.ManagerID + "," + flag + ")Select ''PK'' = SCOPE_IDENTITY() '";
                    string strSQL = "EXEC usp_Whizible2_Upd_tbl_DU_Manager " + DU_ManagerParameters.UniqueID + "," + DU_ManagerParameters.ManagerID + "," + flag;
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
        public HttpResponseMessage GetDUResourceRoleGraph(DU_Params DU_GraphParameters)
        {
            var BG_RolesGraphList = new List<DU_RolesGraph>();
            try
            {
                if (DU_GraphParameters != null && DU_GraphParameters.ResourcePoolID > 0)
                {
                    DataTable BG_GraphTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_DU_Roles_Graph " + DU_GraphParameters.ResourcePoolID + "", true, CommonController.connectionString);
                    if (BG_GraphTable != null && BG_GraphTable.Rows.Count > 0)
                    {
                        decimal totalCount = Convert.ToDecimal(BG_GraphTable.Compute("Sum(RoleCount)", "RoleCount > 0"));

                        var DU_RolesGraph = new DU_RolesGraph();
                        DU_RolesGraph.LstLabel = new List<string>();
                        DU_RolesGraph.LstColor = new List<string>();
                        DU_RolesGraph.LstData = new List<int>();
                        foreach (DataRow bgGraphRow in BG_GraphTable.Rows)
                        {
                            var count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["RoleCount"], "0"));
                            decimal perc = count > 0 ? (count * 100) / totalCount : 0;
                            string roleDec = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(bgGraphRow["RoleDescription"], ""));
                            string RoleDecPerce = string.Concat(roleDec, "(", perc.ToString("0.00") + "%", ")");
                            DU_RolesGraph.LstLabel.Add(RoleDecPerce);
                            DU_RolesGraph.LstData.Add(count);
                            DU_RolesGraph.LstColor.Add(GetBGRoleColor());
                        }

                        BG_RolesGraphList.Add(DU_RolesGraph);
                    }
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, BG_RolesGraphList);
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

        #endregion

        [HttpPost]
        public HttpResponseMessage GetResourceResume(int EmployeeID)
        {

            EmployeeResume employeeResume = new EmployeeResume();
            try
            {
                if (EmployeeID > 0)
                {
                    DataTable EmployeeInfoData = CommonFunctions.Data.GetDataTable("Exec usp_tbl_Sel_EmployeeInfo " + EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeQaulificationData = CommonFunctions.Data.GetDataTable("Exec usp_Sel_tbl_PM_EmployeeQualificationMatrix NULL,NULL,NULL," + EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeCeryificationData = CommonFunctions.Data.GetDataTable("Exec usp_Sel_tbl_PM_EmployeeCertificationMatrix NULL,NULL,NULL," + EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeSkillData = CommonFunctions.Data.GetDataTable("Exec usp_Sel_tbl_PM_EmployeeSkillMatrix NULL,NULL,NULL," + EmployeeID, true, CommonController.connectionString);
                    DataTable EmployeeAssignmentData = CommonFunctions.Data.GetDataTable("Exec usp_sel_CurrentAssignmentsForEmployee " + EmployeeID, true, CommonController.connectionString);
                    //string strSQL = "SELECT '../../Images/Photo/' + SystemFilename FROM tbl_RM_EmployeeMaintenance_Attachment  WHERE EmployeeID=" + EmployeeID +";"+
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
                            JoiningDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["JoiningDate"], "")),
                            BirthDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["BirthDate"], "")),

                        };
                        var DOB = empInfo.BirthDate.ToString("MM/dd/yyyy");
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
                            ValidUpto = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ValidUpto"], "")),
                            ActualScore = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ActualScore"], "")),
                            TotalScore = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TotalScore"], "")),
                            CertificationDetails = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CertificationDetails"], "")),


                        };
                          empcert.CertDate = empcert.CertificationDate.ToString("dd/MM/yyyy");
                        empcert.CertValidDate = empcert.ValidUpto.ToString("dd/MM/yyyy");
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

                        };

                        lstAssignments.Add(empassignment);
                    }
                    employeeResume.CurrentAssignments = lstAssignments;
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
    }
}