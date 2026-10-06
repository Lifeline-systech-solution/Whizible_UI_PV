using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;
namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RM_EmployeeLeavesController : ApiController
    {

        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetApprovedEmployees([FromBody] EmpFilterParameter filterParameter)
        {
            List<RM_EmployeeLeaves> listEmpLeaves = new List<RM_EmployeeLeaves>();
            string filterParms = "";
            try
            {
                if (filterParameter != null && filterParameter.EmpWhereClause != null && !string.IsNullOrEmpty(filterParameter.EmpWhereClause))
                {
                    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.EmpWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null && filterParameter.EmployeeID != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_EmployeeLeaves '" + filterParms + "',"+ filterParameter.EmployeeID + "";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_EmployeeLeaves NULL,"+ filterParameter.EmployeeID + "";
                }


                DataTable LeaveTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (LeaveTable != null)
                {

                    foreach (DataRow item in LeaveTable.Rows)
                    {
                        RM_EmployeeLeaves objEmpLeave = new RM_EmployeeLeaves()
                        {
                            EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["EmployeeID"], "0")),
                            BusinessGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["BusinessGroupID"], "0")),
                            LocationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["LocationID"], "0")),
                            DesignationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["DesignationID"], "0")),
                            EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["EmployeeName"], "")),
                            EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["EmailID"], "")),
                            Phone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["Phone"], "")),
                            NoOfLeaves = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(item["NoOfLeaves"], "0")),
                            LeaveBalance = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(item["LeaveBalance"], "0")),

                        };

                        listEmpLeaves.Add(objEmpLeave);
                    }


                }
                return Request.CreateResponse(HttpStatusCode.OK, listEmpLeaves);
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
        public HttpResponseMessage GetEmployeeLeaveTypes([FromBody] int EmployeeID)
        {
            List<RM_EmployeeLeaveType> listEmpLeavesType = new List<RM_EmployeeLeaveType>();

            try
            {
                if (EmployeeID > 0)
                {
                    string strSQL = "";
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_EmployeeLeavesByID " + EmployeeID + "";

                    DataTable LeaveTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (LeaveTable != null)
                    {

                        foreach (DataRow item in LeaveTable.Rows)
                        {
                            RM_EmployeeLeaveType objEmpLeaveType = new RM_EmployeeLeaveType()
                            {
                                EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["EmployeeID"], "0")),
                                UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["UniqueID"], "0")),
                                LeaveType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["LeaveType"], "")),
                                NoOfLeaves = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(item["NoOfLeaves"], "0")),
                                LeaveBalance = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["LeaveBalance"], "0")),
                                ProRata = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["ProRata"], "0")),
                                LeaveTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["LeaveTypeID"], "")),

                            };

                            listEmpLeavesType.Add(objEmpLeaveType);
                        }
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK, listEmpLeavesType);
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
        public HttpResponseMessage DeleteEmployeeLeaves([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_del_EmployeesLeaveTypes '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
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

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveLeaves([FromBody] RM_EmpLeaves Op_parameters)
        {
            string strtResult = string.Empty;
            string strSQL = "";
            try
            {
                if (Op_parameters != null)
                {
                    //if (Op_parameters.ProRata == "" || Op_parameters.ProRata == " ")
                    //{
                    //    Op_parameters.ProRata = "0";
                    //}
                    if (Op_parameters.UniqueID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_EmployeeLeves " + Op_parameters.UniqueID + "," + Op_parameters.NoOfLeaves + "," + Op_parameters.LeaveBalance + "," + Op_parameters.ProRata + ",'" + Op_parameters.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_tbl_Whizible2_Ins_PM_EmployeeLeaveMaster " + Op_parameters.EmployeeID + "," + Op_parameters.LeaveTypeID + "," + Op_parameters.NoOfLeaves + "," + Op_parameters.LeaveBalance + "," + Op_parameters.ProRata + ",'" + Op_parameters.CreatedBy + "'";
                    }

                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

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

        public HttpResponseMessage GetLeaveApprovers()
        {
            List<LeaveEmployeeName> listEmpApprovers = new List<LeaveEmployeeName>();
            List<EmpLeaveApprovers> listEmpLeaveApprovers = new List<EmpLeaveApprovers>();

            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_Employee_LeaveApprovers ";

                DataTable LeaveTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (LeaveTable != null)
                {

                    foreach (DataRow item in LeaveTable.Rows)
                    {
                        LeaveEmployeeName objEmpLeaveType = new LeaveEmployeeName()
                        {
                            Approver = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["Approver"], "")),
                            EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["EmployeeName"], "")),

                        };
                        listEmpApprovers.Add(objEmpLeaveType);


                    }
                    var empdata = listEmpApprovers.GroupBy(x => x.Approver).Select(g => new EmpLeaveApprovers { Approver = g.FirstOrDefault().Approver }).ToList();
                    foreach (var itemLeave in empdata)
                    {
                        EmpLeaveApprovers objLeave = new EmpLeaveApprovers();
                        objLeave.lstEmployeeName = new List<LeaveEmployeeName>();
                        LeaveEmployeeName objEmpName = new LeaveEmployeeName();
                        var objname = listEmpApprovers.Where(x => x.Approver == itemLeave.Approver).ToList();
                        objLeave.Approver = itemLeave.Approver;
                        objLeave.lstEmployeeName.AddRange(objname);
                        listEmpLeaveApprovers.Add(objLeave);
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK, listEmpLeaveApprovers);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        private bool IsEmptyfield(string Value)
        {
            if (string.IsNullOrEmpty(Value))
            {
                return true;
            }
            return false;
        }
        private bool IsNumeric(string Value)
        {
            return IsNumeric(Value);
        }

        private bool IsDecimal(string value)
        {
            try
            {
                Decimal.Parse(value);
                return true;
            }
            catch
            {
                return false;
            }
        }
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UploadEmpXlsxFile()
        {
            try
            {
                var httpRequest = HttpContext.Current.Request;
                var server = HttpContext.Current.Server;
                string FilePath = string.Empty;
                DataTable dtXlsx = null;
                var RU_EmpsXlsxList = new List<RM_XslxEmployeeLeaves>();
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
                            ConStringXslx = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                            //string ConStringXslx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
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
        private List<RM_XslxEmployeeLeaves> SetXslxValues(DataTable dtSetValues)
        
        {
           
            //Added by imran 24-08-2021  To check Excel header
            string Message = string.Empty;
            string[] ColumnName = new string[12] { "Employee Code", "Employee Name", "Request Type", "Leave Type", "From Date", "To Date", "Half Day", "Reason", "Status", "Applied Date", "Approved Date", "Number Of Days" };
            int ColsHeaderNamecheck = 0;
            //End by imran 24-08-2021

            var ObjXlsx = new RM_XslxEmployeeLeaves();
            var ObjXlsxList = new List<RM_XslxEmployeeLeaves>();
            var columnNames = dtSetValues.Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();

            string ExcelStrSQL = "Select ISNULL(ExcelUploadRenge,0) from tbl_Whizible2_PM_ProjectSettings";
            object ExcelUploadRenge = CommonFunctions.Data.GetDataScalar(ExcelStrSQL, true, CommonController.connectionString);

            //Added by imran 24-08-2021  To check validation of columns
            for (int i=0; i< columnNames.Count; i++)
            {
                if(i > 11)
                {}
                else
                {
                    if (columnNames[i] == ColumnName[i])
                    { ColsHeaderNamecheck += 1; }
                }                            
            }

            if(columnNames.Count !=12)
            {
                Message += string.Concat(':', "{0} Please Check Excel Column Configuration");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (ColsHeaderNamecheck != 12)
            {
                Message += string.Concat(':', "{0} Excel Column Header Not Match");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count == 0)
            {
                Message += string.Concat(':', "{0} Uploaded Excel File is Blank");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count > Convert.ToInt32(ExcelUploadRenge))
            {
                Message += string.Concat(':', "{0} Please upload " + ExcelUploadRenge + " record");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count > 500)
            {
                Message += string.Concat(':', "{0} Uploaded file should not be greater than 500 record.");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else
            {
                //End by imran 24-08-2021

                foreach (DataRow itemRow in dtSetValues.Rows)
                {
                    ObjXlsx = new RM_XslxEmployeeLeaves();

                    foreach (var itemcl in columnNames)
                    {
                        var CurrentValue = itemRow[itemcl].ToString();
                        switch (itemcl)
                        {
                            case XlsxEmpHeaderNameConst.EmployeeName:
                                ObjXlsx.EmployeeName = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.EmployeeCode:
                                ObjXlsx.EmployeeCode = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.RequestType:
                                ObjXlsx.RequestType = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.LeaveType:
                                ObjXlsx.LeaveType = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.FromDate:
                                ObjXlsx.FromDate = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.ToDate:
                                ObjXlsx.ToDate = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.HalfDay:
                                ObjXlsx.HalfDay = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.Reason:
                                ObjXlsx.Reason = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.LeaveStatus:
                                ObjXlsx.Status = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.AppliedDate:
                                ObjXlsx.AppliedDate = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.ApprovedDate:
                                ObjXlsx.ApprovedDate = CurrentValue;
                                continue;
                            case XlsxEmpHeaderNameConst.NumberOfDays:
                                ObjXlsx.NumberOfDays = CurrentValue;
                                continue;
                        }
                    }

                    ///Check user exist in table using Code and UserName
                    //var IsExistUser = false;
                    //var strSQLIsExistr = "SELECT COUNT(EmployeeCode) FROM tbl_PM_Employee WHERE EmployeeCode= '" + ObjXlsx.EmployeeCode.Trim() + "'  ";
                    //var Result = Convert.ToInt64(CommonFunctions.Data.GetDataScalar(strSQLIsExistr, true, CommonController.connectionString));
                    //IsExistUser = Result > 0 ? true : false;
                    //if (!IsExistUser)
                    //{

                    string tdFromDate = "", tdToDate = "";
                    DateTime dtFromDate, dtToDate;
                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.FromDate))
                    {
                        if (ObjXlsx.FromDate != null || ObjXlsx.FromDate != "")
                    {
                        tdFromDate = ObjXlsx.FromDate.Replace(" 00:00:00", "");
                        dtFromDate = Convert.ToDateTime(tdFromDate);
                        ObjXlsx.FromDate = dtFromDate.ToString("dd MMM yyyy");
                        tdFromDate = "";
                    }
                }
                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.ToDate))
                    {
                        if (ObjXlsx.ToDate != null || ObjXlsx.ToDate != "")
                        {
                            tdToDate = ObjXlsx.ToDate.Replace(" 00:00:00", "");
                            dtToDate = Convert.ToDateTime(tdToDate);
                            ObjXlsx.ToDate = dtToDate.ToString("dd MMM yyyy");
                            tdToDate = "";
                        }
                    }
                    //Added by imran 26-08-2021 to convert date
                    string tdt = "";
                    DateTime dt;
                    if (ObjXlsx.AppliedDate != null || ObjXlsx.AppliedDate != "")
                    {
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.AppliedDate))
                        {
                            tdt = ObjXlsx.AppliedDate.Replace(" 00:00:00", "");
                            dt = Convert.ToDateTime(tdt);
                            ObjXlsx.AppliedDate = dt.ToString("dd MMM yyyy");
                            tdt = "";
                        }
                    }
                    if (ObjXlsx.ApprovedDate != null || ObjXlsx.ApprovedDate != "")
                    {
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.ApprovedDate))
                        {
                            tdt = ObjXlsx.ApprovedDate.Replace(" 00:00:00", "");
                            dt = Convert.ToDateTime(tdt);
                            ObjXlsx.ApprovedDate = dt.ToString("dd MMM yyyy");
                            tdt = "";
                        }
                    }
                    if (ObjXlsx.FromDate != null || ObjXlsx.FromDate != "")
                    {
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.FromDate))
                        {
                            tdt = ObjXlsx.FromDate.Replace(" 00:00:00", "");
                            dt = Convert.ToDateTime(tdt);
                            ObjXlsx.FromDate = dt.ToString("dd MMM yyyy");
                            tdt = "";
                        }
                    }
                    if (ObjXlsx.ToDate != null || ObjXlsx.ToDate != "")
                    {
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.ToDate))
                        {
                            tdt = ObjXlsx.ToDate.Replace(" 00:00:00", "");
                            dt = Convert.ToDateTime(tdt);
                            ObjXlsx.ToDate = dt.ToString("dd MMM yyyy");
                            tdt = "";
                        }
                    }
                    //End by imran 26-08-2021
                    

                    if (XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeName))
                    {
                        Message += string.Concat(':', "{0}  Employee Name should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (ObjXlsx.EmployeeName != null)
                    {
                        if (ObjXlsx.EmployeeName.Length > 50)
                        {
                            Message += string.Concat(':', "{1}  Employee Name should not greater than 50 characters. ");
                            ObjXlsx.ColumnError = Message;
                        }
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeCode))
                    {
                        Message += string.Concat(':', "{0} Employee Code should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (ObjXlsx.EmployeeCode != null)
                    {
                        if (XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeCode) && ObjXlsx.EmployeeCode.Length > 10)
                        {
                            Message += string.Concat(':', "{0}  Employee Code should not greater than 10 characters. ");
                            ObjXlsx.ColumnError = Message;
                        }
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.RequestType))
                    {
                        Message += string.Concat(':', "{0}  Request Type should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.LeaveType))
                    {
                        Message += string.Concat(':', "{0}  Leave Type should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.FromDate))
                    {
                        Message += string.Concat(':', "{0}  From Date should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.ToDate))
                    {
                        Message += string.Concat(':', "{0}  To Date should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.HalfDay))
                    {
                        Message += string.Concat(':', "{0}  Half Day should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.Status))
                    {
                        Message += string.Concat(':', "{0}  Status should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.AppliedDate))
                    {
                        Message += string.Concat(':', "{0} Applied Date should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.ApprovedDate))
                    {
                        Message += string.Concat(':', "{0} Approved Date should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    //Added By Rutuja D. on 4 Feb 2022 For missing validation
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.NumberOfDays))
                    {                        
                        Message += string.Concat(':', "{0} Number Of Days should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }
                    //End of Added By Rutuja D. on 4 Feb 2022 For missing validation

                    //if (ObjXlsx.Reason != null || ObjXlsx.Reason == "")
                    if (XlsxUtility.IsEmptyfield(ObjXlsx.Reason))
                    {
                        Message += string.Concat(':', "{0} Reason should not left blank. ");
                        ObjXlsx.ColumnError = Message;
                    }                  

                    //Added by imran 24-08-2021 To check null
                    if (ObjXlsx.NumberOfDays != null)
                    {
                       
                        if (IsDigitsOnly(ObjXlsx.NumberOfDays) == false)
                        {
                            Message += string.Concat(':', "{0} Number Of Days must be digit only. ");
                            ObjXlsx.ColumnError = Message;
                        }
                    }
                    //Added by imran 24-08-2021 To check null

                    //Added by imran 24-08-2021 To check null
                    if (ObjXlsx.HalfDay != null)
                    {
                        if (IsDigitsOnly(ObjXlsx.HalfDay) == false)
                        {
                            Message += string.Concat(':', "{0} Half Day must be digit only. ");
                            ObjXlsx.ColumnError = Message;
                        }
                    }
                    //Added by imran 24-08-2021 To check null

                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.AppliedDate))
                    {
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.ApprovedDate))
                        {
                            if (Convert.ToDateTime(ObjXlsx.ApprovedDate) < Convert.ToDateTime(ObjXlsx.AppliedDate))
                            {
                                Message += string.Concat(':', "{0} The 'Approved Date' should not be less than 'Applied Date'. ");
                                ObjXlsx.ColumnError = Message;
                            }
                        }

                    }

                    if (!XlsxUtility.IsEmptyfield(ObjXlsx.LeaveType) && !XlsxUtility.IsEmptyfield(ObjXlsx.Status) 
                        && !XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeCode) && !XlsxUtility.IsEmptyfield(ObjXlsx.RequestType)
                        && !XlsxUtility.IsEmptyfield(ObjXlsx.FromDate) && !XlsxUtility.IsEmptyfield(ObjXlsx.ToDate)
                        && !XlsxUtility.IsEmptyfield(ObjXlsx.EmployeeName) && !XlsxUtility.IsEmptyfield(ObjXlsx.NumberOfDays))
                    {

                        var strSQLIsExistr = " EXEC usp_Whizible2_Sel_EmpLeave_Validation '"
                        + ObjXlsx.EmployeeCode.Replace("'", "''") + "','"
                        + ObjXlsx.FromDate + "','"
                        + ObjXlsx.ToDate + "','"
                        + ObjXlsx.EmployeeName.Replace("'", "''") + "','"
                        + ObjXlsx.RequestType.Replace("'", "''") + "','"
                        + ObjXlsx.NumberOfDays + "'";
                        var Result = CommonFunctions.Data.GetDataScalar(strSQLIsExistr, true, CommonController.connectionString);


                        if (Result == null || Result == "")
                        {

                            string strParms = "@LeaveType='" + ObjXlsx.LeaveType.Replace("'", "''") + "'," + "@Status='" + ObjXlsx.Status.Replace("'", "''") + "'," + "@EmployeeCode='" + ObjXlsx.EmployeeCode.Replace("'", "''") + "'";
                            var strSQL = "Exec usp_Whizible2_Select_IDs_EmployeeID_ByName " + strParms;

                            IDataReader drQuery;
                            drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                            int LeaveTypeID = 0, StatusID = 0, EmployeeID = 0;
                            if (drQuery.Read())
                            {
                                LeaveTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["LeaveTypeID"], "0"));
                                StatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["StatusID"], "0"));
                                EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["EmployeeID"], "0"));
                            }
                            if (!drQuery.IsClosed)
                            {
                                drQuery.Close();
                            }

                            if (LeaveTypeID > 0)
                            {
                                ObjXlsx.LeaveTypeID = LeaveTypeID;
                            }
                            else
                            {
                                // Message += string.Concat(':', "Leave Type not found for " + ObjXlsx.LeaveType);
                                //if (!XlsxUtility.IsEmptyfield(LeaveTypeID))
                                if (LeaveTypeID.ToString() == "0" || LeaveTypeID == 0)
                                {
                                    Message += string.Concat(':', "Leave Type does not exist.");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                            ///ObjXlsx.DepartmentID = 1;
                            if (StatusID > 0)
                            {
                                ObjXlsx.LeaveStatusID = StatusID;
                            }
                            else
                            {
                                //   Message += string.Concat(':', "Status not found for " + ObjXlsx.Status);
                                //if (!XlsxUtility.IsEmptyfield(StatusID))
                                    if (StatusID.ToString() == "0" || StatusID == 0)
                                    {
                                        Message += string.Concat(':', "Status does not exist.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                            }
                            if (EmployeeID > 0)
                            {
                                ObjXlsx.EmployeeID = EmployeeID;
                            }
                            else
                            {
                                //Message += string.Concat(':', "Employee not found for " + ObjXlsx.EmployeeCode);
                                //if (!XlsxUtility.IsEmptyfield(EmployeeID))
                                if (EmployeeID.ToString() == "0" || EmployeeID == 0)
                                {
                                    Message += string.Concat(':', "Employee Code does not exist.");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }

                        }
                        else
                        {
                            if (!XlsxUtility.IsEmptyfield(ObjXlsx.RequestType))
                            {
                                Message += string.Concat(':', "{1} " + Result);
                                ObjXlsx.ColumnError = Message;
                            }
                        }
                    }
                    else { }

                    ObjXlsxList.Add(ObjXlsx);
                }
            }           
            return ObjXlsxList;
        
        }
        //Added by imran 24-08-2021 To check Digit Only
        bool IsDigitsOnly(string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9')
                    return false;
            }

            return true;
        }
        //End by imran 24-08-2021
       

        //[HttpPost]
        //public HttpResponseMessage UploadXlsxRecord(List<RM_XslxEmpLeaves> XlsxEmpListParams)
        //{
        //    try
        //    {
        //        foreach (var itemXlsx in XlsxEmpListParams)
        //        {
        //            if (itemXlsx != null)
        //            {
        //                string strParms = "@EmployeeName='" + itemXlsx.EmployeeName + "'," + "@UserName='" + itemXlsx.UserName.Trim() + "',"
        //                + "@EmployeeCode='" + itemXlsx.EmployeeCode.Trim() + "'," + "@Gender='" + itemXlsx.Gender + "',"
        //                + "@EmailID='" + itemXlsx.Email + "'," + "@BirthDate='" + itemXlsx.BirthDate + "'," + "@PostID='" + itemXlsx.RoleID + "',"
        //                + "@ReportingTo='" + itemXlsx.ReportingToId + "'," + "@JoiningDate='" + itemXlsx.JoiningDate + "',"
        //                + "@BusinessGroupID='" + itemXlsx.BusinessGroupID + "'," + "@LocationID='" + itemXlsx.LocationID + "'," + "@DesignationID='" + itemXlsx.DesignationID + "',"
        //                + "@DepartmentID='" + itemXlsx.DepartmentID + "'," + "@EmployeeType='" + itemXlsx.EmployeeType + "',"
        //                + "@CostToCompany='" + itemXlsx.CostToCompany + "'," + "@RatePerHour='" + itemXlsx.RatePerHr + "'," + "@CostPerHour='" + itemXlsx.CostPerHr + "',"
        //                + "@Deployable='" + itemXlsx.Deployable + "'," + "@CurrencyID='" + itemXlsx.CurrencyID + "',"
        //                + "@Status=0,@IsLDAPAuthentication=0,@CreatedBy='" + itemXlsx.UploadedBy + "' ";

        //                var strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_EmployeeMaster " + strParms;


        //                var strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
        //                if (strtResult != null)
        //                {
        //                    // return Request.CreateResponse(HttpStatusCode.OK, strtResult);
        //                }
        //            }
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
        //    }
        //    return Request.CreateResponse(HttpStatusCode.Created, "");
        //}

        public static class XlsxEmpHeaderNameConst
        {
            public const string EmployeeCode = "Employee Code";
            public const string EmployeeName = "Employee Name";
            public const string RequestType = "Request Type";
            public const string LeaveType = "Leave Type";
            public const string FromDate = "From Date";
            public const string ToDate = "To Date";
            public const string HalfDay = "Half Day";
            public const string Reason = "Reason";
            public const string LeaveStatus = "Status";
            public const string AppliedDate = "Applied Date";
            public const string ApprovedDate = "Approved Date";
            public const string NumberOfDays = "Number Of Days";

        }

        //Added by imran on 19-08-2022
       // [Authorize, App_Start.ValidateHeaders]
        [Authorize]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveLeavesDetails(List<RM_XslxEmployeeLeaves> XlsxEmpListParams)
        {
            string strtResult = string.Empty;
            string strSQL = "";
            try
            {
                foreach (var Op_parameters in XlsxEmpListParams)
                {
                    if (Op_parameters != null)
                    {
                        // DateTime sdate = Op_parameters.FromDate;
                        // Op_parameters.FromDate = sdate.ToString("yyyy-MM-dd");

                        Op_parameters.ToDate = Convert.ToDateTime(Op_parameters.ToDate).ToString("yyyy-MM-dd");
                        Op_parameters.FromDate = Convert.ToDateTime(Op_parameters.FromDate).ToString("yyyy-MM-dd");
                        Op_parameters.AppliedDate = Convert.ToDateTime(Op_parameters.AppliedDate).ToString("yyyy-MM-dd");
                        Op_parameters.ApprovedDate = Convert.ToDateTime(Op_parameters.ApprovedDate).ToString("yyyy-MM-dd");
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_EmployeeLeaveDetails " + Op_parameters.EmployeeID + ",'" + Op_parameters.RequestType + "'," + Op_parameters.LeaveTypeID + ",'" + Op_parameters.FromDate + "','" + Op_parameters.ToDate + "','" + Op_parameters.HalfDay + "','" + Op_parameters.Reason.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + Op_parameters.LeaveStatusID + ",'" + Op_parameters.AppliedDate + "','" + Op_parameters.ApprovedDate + "'," + Op_parameters.ActualDuration;


                        //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                        strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                        if (strtResult != null)
                        {
                            return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                        }
                    }
                }

            return Request.CreateResponse(HttpStatusCode.OK, strtResult);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


    }

}