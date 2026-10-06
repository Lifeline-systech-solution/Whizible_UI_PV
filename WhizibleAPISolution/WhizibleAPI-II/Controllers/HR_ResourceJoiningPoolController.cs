using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Extensions;
using System.Web;
using System.Data;
using System.IO;

namespace WhizibleAPI.Controllers
{
    public class HR_ResourceJoiningPoolController : ApiController
    {
        ////Get  List
        [HttpPost]
        //Added by imran on 29-08-2022 
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetResourceDetailList([FromBody] int EmployeeID)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_Employee_Offered ";
                if (EmployeeID != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(EmployeeID));
                }
                else
                {
                    strSQL += "NULL";
                }
                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetResourceSkillDetailList([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_Employee_OfferedSkillMatrix ";
                if (Parameter.EmployeeID != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID));
                }
                else
                {
                    strSQL += "NULL";
                }
                if (Parameter.EmployeeSkillID != 0)
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeSkillID));
                }
                else
                {
                    strSQL += ", NULL";
                }
                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetAllSkillList([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Tools_FillCombo " + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID)); ;
                if (Parameter.EmployeeSkillID != 0)
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeSkillID));
                }
                else
                {
                    strSQL += ", NULL";
                }
                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveOrUpdateResource([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_Upd_tbl_PM_Employee_Offered '"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeName)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Address)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Contact)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Role)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Designation)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.JoiningDate)) + "'";

                if (Parameter.EmployeeID != 0)
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID));
                }
                else
                {
                    strSQL += ",NULL";
                }

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveOrUpdateSkill([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_Upd_tbl_PM_Employee_OfferedSkillMatrix "
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.SkillID)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.MonthOfExp)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.YearOfExp)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProficiancyID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.CoreCompentency)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Note)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeSkillID)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.LoginType)) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteEmployee([FromBody] int EmployeeID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_ResourcePoolMasterEmployee "
                + HttpUtility.UrlDecode(Convert.ToString(EmployeeID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteSkillDetail([FromBody] int EmployeeSkillID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_Employee_OfferedSkillMatrix "
                + HttpUtility.UrlDecode(Convert.ToString(EmployeeSkillID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetQualificationDetailList([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_Employee_OfferedQualificationMatrix ";
                if (Parameter.EmployeeID != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID));
                }
                else
                {
                    strSQL += "NULL";
                }
                if (Parameter.EmployeeQualificationID != 0)
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeQualificationID));
                }
                else
                {
                    strSQL += ", NULL";
                }
                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveOrUpdateQualification([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_Upd_tbl_PM_Employee_OfferedQualificationMatrix "
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.QualificationID)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.University)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.PassoutYear)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Class)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Percentage)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeQualificationID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetWorkExpDetailList([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeHistory_Offered ";
                if (Parameter.EmployeeID != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID));
                }
                else
                {
                    strSQL += "NULL";
                }
                if (Parameter.EmployeeHistoryID != 0)
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeHistoryID));
                }
                else
                {
                    strSQL += ", NULL";
                }
                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveOrUpdateExp([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_Upd_tbl_PM_EmployeeHistory_Offered "
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.OrganizationName)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.WorkedFrom)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.WorkedTill)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.PositionHeld)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.WorkProfile)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Summery)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeHistoryID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object ValidateQualificationName([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Validate_tbl_PM_Employee_OfferedQualificationMatrix "
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.QualificationID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeQualificationID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteQualiDetail([FromBody] int EmployeeQualificationID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_Employee_OfferedQualificationMatrix "
                + HttpUtility.UrlDecode(Convert.ToString(EmployeeQualificationID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetBusinessGroupsLocation([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_GetBusinessGroupsForLocation "
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.BusinessGroupID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID)) + ",0";


                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetResourcePoolForLocation([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_GetResourcePoolForLocation "
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.LocationID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID));


                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetDeliveryTeam([FromBody] ResourceJoiningPoolDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_GetDeliveryTeam "
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.LocationID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeID));


                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteExpDetail([FromBody] int EmployeeHistoryID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_EmployeeHistory_Offered "
                + HttpUtility.UrlDecode(Convert.ToString(EmployeeHistoryID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        public HttpResponseMessage UploadEmpXlsxFile()
        {
            try
            {
                var httpRequest = HttpContext.Current.Request;
                var server = HttpContext.Current.Server;
                string FilePath = string.Empty;
                DataTable dtXlsx = null;
                var RU_EmpsXlsxList = new List<RM_XslxEmployee>();
                if (httpRequest.Files.Count > 0)
                {
                    var postedDocumentFile = httpRequest.Files[0];
                    var CurrentDate = string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);// DateTime.UtcNow;
                    string extension = Path.GetExtension(postedDocumentFile.FileName).ToLower();
                    string connString = "";
                    var FolderPath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Content/Uploads"));
                    string[] FileNameArr = postedDocumentFile.FileName.Split('.');
                    string FileName = string.Concat(FileNameArr[0], CurrentDate, '.', FileNameArr[1]);

                    FilePath = string.Format("{0}/{1}", FolderPath, FileName);

                    XlsxUtility.CreateDocDirectory(FolderPath);
                    if (XlsxUtility.IsValidFileFile(extension))
                    {
                        XlsxUtility.DeleteFileIfExist(FilePath);
                        postedDocumentFile.SaveAs(FilePath);
                        var FileExtension = extension.Trim();
                        string ConStringXsl = "";
                        string ConStringXslx = "";
                        if (Environment.Is64BitOperatingSystem)
                        {
                            ConStringXsl = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";
                            ConStringXslx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";

                        }
                        else
                        {
                            ConStringXsl = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                            ConStringXslx = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";
                        }
                        switch (FileExtension)
                        {
                            case ".csv":
                                dtXlsx = XlsxUtility.ConvertCSVtoDataTable(FilePath);
                                break;
                            case ".xls":
                                connString = ConStringXsl;
                                dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);
                                break;
                            case ".xlsx":
                                connString = ConStringXslx;
                                dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);
                                break;
                        }

                        RU_EmpsXlsxList = SetXslxValues(dtXlsx);
                    }
                    else
                    {
                        Request.CreateResponse(HttpStatusCode.Created, "File format not supported");
                    }
                }
                else
                {
                    Request.CreateResponse(HttpStatusCode.BadRequest, "Please select the file ");
                }

                return Request.CreateResponse(HttpStatusCode.Created, RU_EmpsXlsxList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            private List<RM_XslxEmployee> SetXslxValues(DataTable dtSetValues)
        {
            string Message = string.Empty;
            string[] ColumnName = new string[6] { "Employee Name", "Role", "Designation", "Tentative Joining Date", "Primary Skills", "Other Skills" };
            int ColsHeaderNamecheck = 0;

            var ObjXlsx = new RM_XslxEmployee();

            var ObjXlsxList = new List<RM_XslxEmployee>();
            var columnNames = dtSetValues.Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();

            for (int i = 0; i < columnNames.Count; i++)
            {
                if (i > 5)
                {
                }
                else
                {
                    if (columnNames[i] == ColumnName[i])
                    {
                        ColsHeaderNamecheck += 1;
                    }
                }
            }

            if (columnNames.Count != 6)
            {
                Message += string.Concat(':', "{0} Please Check Excel Column Configuration");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (ColsHeaderNamecheck != 6)
            {
                Message += string.Concat(':', "{0} Excel Column Header Not Match");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else
            {

                foreach (DataRow itemRow in dtSetValues.Rows)
                {
                    ObjXlsx = new RM_XslxEmployee();
                    foreach (var itemcl in columnNames)
                    {
                        var CurrentValue = itemRow[itemcl].ToString();
                        switch (itemcl)
                        {

                            case XlsxEmpHeaderNameConst.EmployeeName:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Employee Name should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.EmployeeName = CurrentValue;
                                }
                                continue;

                            case XlsxEmpHeaderNameConst.Role:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Role should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.Role = CurrentValue;
                                }
                                continue;

                            case XlsxEmpHeaderNameConst.Designation:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Designation should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.Designation = CurrentValue;
                                }
                                continue;

                            case XlsxEmpHeaderNameConst.JoiningDate:
                                if (XlsxUtility.IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Tentative Joining Date should not be left blank.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    string tdt = CurrentValue.Replace(" 00:00:00", "");
                                    DateTime dt = Convert.ToDateTime(tdt);
                                    ObjXlsx.JoiningDate = dt.ToString("dd MMM yyyy");
                                }
                                continue;

                            case XlsxEmpHeaderNameConst.PrimarySkill:
                                ObjXlsx.PrimarySkill = CurrentValue;
                                continue;

                            case XlsxEmpHeaderNameConst.OtherSkill:
                                ObjXlsx.OtherSkill = CurrentValue;
                                continue;
                        }
                    }

                    #region Validate values
                    ///Check user exist in table using Code and UserName
                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.Role) && !XlsxUtility.IsEmptyfield(ObjXlsx.Designation))
                    {
                        #region Get Ids for bg type etc using name

                        var strSQL = "Exec usp_Whizible2_ValidateResourcePoolExcelData '"
                        + ObjXlsx.Role + "','" + ObjXlsx.Designation + "','" + ObjXlsx.PrimarySkill + "','" + ObjXlsx.OtherSkill + "'";

                        IDataReader drQuery;
                        drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                        int RoleId = 0, DesignationId = 0;
                        string StrPrimarySkills = "", StrOtherSkills = "";
                        if (drQuery.Read())
                        {
                            DesignationId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["Designation"], "0"));
                            RoleId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["Role"], "0"));
                            StrPrimarySkills = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["PrimarySkillErrorMsg"], "0"));
                            StrOtherSkills = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["OtherSkillErrorMsg"], ""));
                        }

                        if (RoleId > 0)
                        {
                            ObjXlsx.Role = Convert.ToString(RoleId);
                        }
                        else
                        {
                            // Message += string.Concat(':', "Role not found for " + ObjXlsx.ReportingTo);
                            if (!XlsxUtility.IsEmptyfield(ObjXlsx.Role))
                            {
                                Message += string.Concat(':', "{0} Role does not exists.");
                                ObjXlsx.ColumnError = Message;
                            }
                        }

                        if (DesignationId > 0)
                        {
                            ObjXlsx.Designation = Convert.ToString(DesignationId);
                        }
                        else
                        {
                            //Message += string.Concat(':', "Designation not found for " + ObjXlsx.Designation);
                            if (!XlsxUtility.IsEmptyfield(ObjXlsx.Designation))
                            {
                                Message += string.Concat(':', "{0} Designation does not exists.");
                                ObjXlsx.ColumnError = Message;
                            }
                        }

                        if (!XlsxUtility.IsEmptyfield(StrPrimarySkills))
                        {
                            Message += string.Concat(':', "{0} " + StrPrimarySkills);
                            ObjXlsx.ColumnError = Message;
                        }

                        if (!XlsxUtility.IsEmptyfield(StrOtherSkills))
                        {
                            Message += string.Concat(':', "{0} " + StrOtherSkills);
                            ObjXlsx.ColumnError = Message;
                        }

                        #endregion

                    }

                    else
                    {
                        //Message += string.Concat(':', "{1}  User/Employee Code should not left blank.");
                        //ObjXlsx.ColumnError = Message;
                    }
                    #endregion
                    ObjXlsxList.Add(ObjXlsx);
                }
            }
            return ObjXlsxList;
        }

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UploadXlsxRecord(List<RM_XslxEmployee> XlsxEmpListParams)
        {
            try
            {
                foreach (var itemXlsx in XlsxEmpListParams)
                {
                    if (itemXlsx != null)
                    {
                        string strParms = "@EmployeeName='" + itemXlsx.EmployeeName.Trim() + "'," + "@PostID=" + itemXlsx.Role + ",@DesignationID=" + itemXlsx.Designation + ",@JoiningDate='" + itemXlsx.JoiningDate + "'";

                        var strSQL = "EXEC usp_Whizible2_Ins_Upd_tbl_PM_Employee_Offered " + strParms;
                        
                        var strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strtResult != null)
                        {
                            string strSQL1;
                            strSQL1 = "Exec usp_Whizible2_Ins_tbl_PM_Employee_OfferedSkillMatrix_ExcelUpload "
                            + strtResult + ",'" + itemXlsx.PrimarySkill.Trim() + "'";

                            CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString);
                            
                            // return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            return Request.CreateResponse(HttpStatusCode.Created, "");
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object MoveEmployeesFromJoinPool([FromBody] MoveEmployeeFromJoinPool parameter)
        {
            try
            {
                string strSQL;
                strSQL = "EXEC usp_Whizible2_Ins_EmployeeFromResourcePool '"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.EmployeeName)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.EmployeeCode)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.UserName)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.IsLDAP)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.BirthDate)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Gender)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.EmailID)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.BloodGroup)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.PerAddress)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.CurAddress)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.PerCity)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.CurCity)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.PerState)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.CurrState)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.PerPinCode)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.CurrPinCode)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.PerPhone)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.CurrPhone)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Role)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Designation)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Department)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.EmployeeType)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.ReportingTo)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.JoiningDate)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.RatePerHR)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.CostPerHR)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.CostToCompany)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Currency)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Deployable)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.BusinessGroup)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(parameter.OrganizationUnit)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(parameter.DeliveryUnit)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(parameter.DeliveryTeam)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Facility)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.ExtNo)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Grade)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.MobileNo)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.MgrID)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.PassportNumber)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.PlaceOfIssue)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.DateOfIssue)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.Expirydate)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.FullName)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.RelativeName)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.NoofPagesLeft)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(parameter.LoginUserName)) + "'";

                object EmployeeID = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                if (EmployeeID != null)
                {
                    string strSQL1;
                    strSQL1 = "EXEC usp_Whizible2_Ins_tbl_PM_Employee_FromJoinPool "
                        + HttpUtility.UrlDecode(Convert.ToString(parameter.ResourcePoolEmployeeID)) + ","
                        + EmployeeID + ",'"
                        + HttpUtility.UrlDecode(Convert.ToString(parameter.LoginUserName)) + "'";
                    CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString);

                }
                return "Employee Moved Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object ValidateUserNameOrUserCode([FromBody] MoveEmployeeFromJoinPool Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_Validate_tbl_PM_Employee '"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserName)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.EmployeeCode)) + "'";


                object dtable = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        public class ResourceJoiningPoolDetail
        {
            public int BusinessGroupID { get; set; }
            public int LocationID { get; set; }
            public int EmployeeHistoryID { get; set; }
            public int WorkProfile { get; set; }

            public string WorkedTill { get; set; }
            public string Summery { get; set; }
            public string PositionHeld { get; set; }
            public string WorkedFrom { get; set; }
            public string OrganizationName { get; set; }

            public string EmployeeName { get; set; }
            public string Address { get; set; }
            public string Contact { get; set; }
            public string JoiningDate { get; set; }
            public string LoginType { get; set; }

            public int Role { get; set; }
            public int Designation { get; set; }
            public int EmployeeID { get; set; }
            public int EmployeeSkillID { get; set; }
            public int SkillID { get; set; }
            public int ProficiancyID { get; set; }
            public string YearOfExp { get; set; }
            public Boolean CoreCompentency { get; set; }
            public string MonthOfExp { get; set; }
            public string Note { get; set; }


            public string Percentage { get; set; }
            public string Class { get; set; }
            public string QualificationName { get; set; }
            public string PercentageDetails { get; set; }
            public string University { get; set; }
            public int EmployeeQualificationID { get; set; }
            public int QualificationID { get; set; }
            public int PassoutYear { get; set; }
        }

        public class RM_XslxEmployee
        {
            public string ColumnError { get; set; }
            public string EmployeeName { get; set; }
            public string JoiningDate { get; set; }
            public string PrimarySkill { get; set; }
            public string OtherSkill { get; set; }
            public string Role { get; set; }
            public string Designation { get; set; }
        }

        public static class XlsxEmpHeaderNameConst
        {
            public const string EmployeeName = "Employee Name";
            public const string Role = "Role";
            public const string Designation = "Designation";
            public const string JoiningDate = "Tentative Joining Date";
            public const string PrimarySkill = "Primary Skills";
            public const string OtherSkill = "Other Skills";
        }

        public class MoveEmployeeFromJoinPool
        {
            public int ResourcePoolEmployeeID { get; set; }
            public int ReportingTo { get; set; }
            public int Designation { get; set; }
            public int Department { get; set; }
            public int DeliveryTeam { get; set; }
            public int DeliveryUnit { get; set; }
            public int OrganizationUnit { get; set; }
            public int BusinessGroup { get; set; }
            public int Role { get; set; }
            public int PerPinCode { get; set; }
            public int CurrPinCode { get; set; }
            public int NoofPagesLeft { get; set; }
            public string LoginUserName { get; set; }
            public string Expirydate { get; set; }
            public string RelativeName { get; set; }
            public string FullName { get; set; }
            public string PlaceOfIssue { get; set; }
            public string DateOfIssue { get; set; }
            public string InstantMsgID { get; set; }
            public string PassportNumber { get; set; }
            public string MgrID { get; set; }
            public string MobileNo { get; set; }
            public string Grade { get; set; }
            public string Deployable { get; set; }
            public string ExtNo { get; set; }
            public string Facility { get; set; }
            public string Currency { get; set; }
            public string CostToCompany { get; set; }
            public string CostPerHR { get; set; }
            public string RatePerHR { get; set; }
            public string JoiningDate { get; set; }
            public string EmployeeType { get; set; }
            public string PerPhone { get; set; }
            public string CurrPhone { get; set; }
            public string CurrState { get; set; }
            public string PerState { get; set; }
            public string PerCity { get; set; }
            public string CurCity { get; set; }
            public string CurAddress { get; set; }
            public string PerAddress { get; set; }
            public string Gender { get; set; }
            public string BloodGroup { get; set; }
            public string EmailID { get; set; }
            public string EmployeeName { get; set; }
            public string EmployeeCode { get; set; }
            public string UserName { get; set; }
            public string BirthDate { get; set; }
            public Boolean IsLDAP { get; set; }
        }

        
    }
}
