using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;
using WhizibleAPI.Models.TimesheetEntry;
using System.Configuration;

namespace WhizibleAPI.Controllers
{

    public class TimesheetEntryNewController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTaskData([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_whizible2_Sel_Projects_tbl_PM_DailyActivity " + obj.intEmployeeID + ",'" + obj.dtFromDate + "','" + obj.dtToDate + "','" + obj.WhereClause + "'";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object PlotTaskDetails([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_sel_tbl_PM_DailyActivity_Updated " + obj.intEmployeeID + ",'" + obj.dtFromDate + "','" + obj.dtToDate + "','" + obj.ProjectID + "','" + obj.WhereClause + "'";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTimeSheetWeekHeaderDetails([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_GetTimeSheetWeekHeaderDetails " + obj.intEmployeeID + ",'" + obj.dtFromDate + "','" + obj.dtToDate + "'";

                //DataSet ds = CommonFunction.Data.GetDataSet(strSQL, "TEMP", , , MyBase.UseSQL);
                DataSet ds = CommonFunctions.Data.GetDataSet(strSQL.ToString(), "TimeSheetWeekHeader", 0, 0, System.Convert.ToBoolean(true), CommonController.connectionString);

                return ds;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetAssignedProjects([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                //strSQL = "usp_whizible2_Sel_Project_tbl_PM_ProjectTasks " + obj.intEmployeeID;
                strSQL = "usp_Whizible2_Sel_AccessibleProjects_ForNewTimesheet " + obj.intEmployeeID + ",NULL,1";

                DataTable ProjectListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ProjectListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectsFilterDataset([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_whizible2_Sel_Project_FilterDataset " + obj.intEmployeeID + ",'" + obj.ProjectIDs + "'";
                DataSet ProjectFilterDataset = CommonFunctions.Data.GetDataSet(strSQL, "Table", 0, 0, true, CommonController.connectionString);

                return ProjectFilterDataset;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveFilter([FromBody] TimesheetEntry obj)
        {
            try
            {
                //   string filterValuesJson = Newtonsoft.Json.JsonConvert.SerializeObject(obj.WhereClause);
                string strSQL;
                //strSQL = "usp_whizible2_Ins_Upd_TimesheetFilter " + obj.intEmployeeID+",'" + filterValuesJson + "','" + obj.CreatedBy + "'";
                strSQL = "usp_whizible2_Ins_Upd_TimesheetFilter " + obj.intEmployeeID + ",'" + obj.WhereClause + "','" + obj.CreatedBy + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTSSaveFilter([FromBody] TimesheetEntry obj)
        {
            try
            {

                string strSQL;
                strSQL = "usp_whizible2_Sel_TimesheetFilter " + obj.intEmployeeID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDailyActivity(IEnumerable<DAParams> DAParams)
        {
            try
            {
                string jsonData = JsonConvert.SerializeObject(DAParams);

                DataTable countTable;
                int ResourceTimesheetID = 0;

                countTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet null," + DAParams.First().EmployeeID + ",'" + DAParams.First().dtFromDate + "','" + DAParams.First().dtToDate + "'", true, CommonController.connectionString);
                foreach (DataRow countRow in countTable.Rows)
                {
                    ResourceTimesheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(countRow["TimesheetID"], "0"));
                }

                string Message = "0";
                foreach (var param in DAParams)
                {
                    // Validate each row before insert so batch save enforces 24h/day like per-row saves did (Vishal Mane 03/06/2026).
                    //var validationMessage = ValidateDailyActivityRow(param);
                    //if (!string.IsNullOrWhiteSpace(validationMessage))
                    //{
                    //    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, validationMessage);
                    //}

                    if (param.DailyActivityEntryID == 0)
                    {
                        Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity NULL," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + ",NULL," + param.IsTaskComplete + ",NULL,NULL,NULL,NULL," + param.StoryPoint + "," + ResourceTimesheetID + "," + param.ProxyResourceID, true, CommonController.connectionString), ""));  //Added ProxyResourceID by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                    }
                    else
                    {
                        Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity " + param.DailyActivityEntryID + "," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + ",NULL," + param.IsTaskComplete + ",NULL,NULL,NULL,NULL," + param.StoryPoint + ", " + ResourceTimesheetID + "," + param.ProxyResourceID, true, CommonController.connectionString), ""));  //Added ProxyResourceID by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                    }
                }
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        //Added by Vishal Mane on 04/06/2026 for Quick Entry insertion due to Rate Limit changes
        [HttpPost]
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDailyActivity_QuickEntry(IEnumerable<DAParams> DAParams)
        {
            try
            {
                string jsonData = JsonConvert.SerializeObject(DAParams);

                DataTable countTable;
                int ResourceTimesheetID = 0;

                countTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet null," + DAParams.First().EmployeeID + ",'" + DAParams.First().dtFromDate + "','" + DAParams.First().dtToDate + "'", true, CommonController.connectionString);
                foreach (DataRow countRow in countTable.Rows)
                {
                    ResourceTimesheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(countRow["TimesheetID"], "0"));
                }

                string Message = "0";
                foreach (var param in DAParams)
                {
                    //Added or modified by Vishal Mane on 29/04/2026 to safely read RateLimit_Enabled setting
                    var enabled = ConfigurationManager.AppSettings["RateLimit_Enabled"];
                    if (string.Equals(enabled, "false", StringComparison.OrdinalIgnoreCase)
                        || string.Equals(enabled, "0", StringComparison.OrdinalIgnoreCase))
                    {
                        if (param.DailyActivityEntryID == 0)
                        {
                            Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity NULL," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + ",NULL," + param.IsTaskComplete + ",NULL,NULL,NULL,NULL," + param.StoryPoint + "," + ResourceTimesheetID + "," + param.ProxyResourceID, true, CommonController.connectionString), ""));  //Added ProxyResourceID by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                        }
                        else
                        {
                            Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity " + param.DailyActivityEntryID + "," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + ",NULL," + param.IsTaskComplete + ",NULL,NULL,NULL,NULL," + param.StoryPoint + ", " + ResourceTimesheetID + "," + param.ProxyResourceID, true, CommonController.connectionString), ""));  //Added ProxyResourceID by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                        }
                    }
                    else
                    {
                        //End of Added or modified by Vishal Mane on 29/04/2026 to safely read RateLimit_Enabled setting
                        var validationMessage = ValidateDailyActivityRow(param);
                        if (!string.IsNullOrWhiteSpace(validationMessage))
                        {
                            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, validationMessage);
                        }

                        if (param.DailyActivityEntryID == 0)
                        {
                            Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity NULL," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + ",NULL," + param.IsTaskComplete + ",NULL,NULL,NULL,NULL," + param.StoryPoint + "," + ResourceTimesheetID + "," + param.ProxyResourceID, true, CommonController.connectionString), ""));  //Added ProxyResourceID by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                        }
                        else
                        {
                            Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity " + param.DailyActivityEntryID + "," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "'," + param.Duration + ",'" + param.Description + "',NULL," + param.SubTasktypeID + ",NULL," + param.IsTaskComplete + ",NULL,NULL,NULL,NULL," + param.StoryPoint + ", " + ResourceTimesheetID + "," + param.ProxyResourceID, true, CommonController.connectionString), ""));  //Added ProxyResourceID by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                        }
                    }

                }
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }
        //Added by Vishal Mane on 04/06/2026 for Quick Entry insertion due to Rate Limit changes

        //Added by Ajit L on 27/11/2024      
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDescription_OnClick([FromBody] DAParams param)
        {
            try
            {
                string Message = "0";
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Upd_tbl_PM_DailyActivity " + param.DailyActivityEntryID + "," + param.TaskID + "," + param.ProjectID + "," + param.EmployeeID + "," + param.Duration + ",'" + param.Description + "'," + param.ProxyResourceID + "", true, CommonController.connectionString), "")); //Added ProxyResourceID by Vishal Mane on 19/08/2025 to update Proxy Resource ID in tbl_pm_DailyActivity
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Ajit L on 26/11/2024 for live Project List against selected date
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object BindProject([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Sel_ListOfProject_QuickTask " + obj.intEmployeeID + ",'" + obj.CTselectdate + "'";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by Ajit L on 26/11/2024 for Task Type List against selected Project
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object BindTaskType([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "Usp_Whizible2_Sel_TaskType_QuickTask " + obj.ProjectID + "";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by Ajit L on 26/11/2024 for Sub Task Type List against selected Task Type
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object BindSubTaskType([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Sel_SubTasks_QuickTask " + obj.ProjectID + "," + obj.FilterTaskTypeID + "";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Ajit L on 26/11/2024 for Binding Priority Dropdown
        [HttpPost]
        [Authorize]
        public object BindPriority([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Sel_tbl_IB_Priorities 1";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Ajit L on 27/11/2024 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateCreateTask([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_CreateTask '" + taskParameters.dtFromDate + "'," + taskParameters.ProjectID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.Duration + "'", true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Ajit L on 27/11/2024            
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateCreateTask_Work([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;
                if (taskParameters.intSubTaskTypeID == 0)
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_CreateTask_WorkHrs " + HttpUtility.UrlDecode(Convert.ToString(taskParameters.ProjectID)) + "," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.Duration)) + "','" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.TaskName)) + "'," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.CTselectdate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(taskParameters.intEmployeeID)) + ",NULL", true, CommonController.connectionString), ""));
                }
                else
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_CreateTask_WorkHrs " + HttpUtility.UrlDecode(Convert.ToString(taskParameters.ProjectID)) + "," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.Duration)) + "','" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.TaskName)) + "'," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.CTselectdate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(taskParameters.intEmployeeID)) + "," +
                        "" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.intSubTaskTypeID)) + "", true, CommonController.connectionString), ""));
                }


                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Ajit L on 27/11/2024      
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveCreateTask([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectAssignedTasks_From_QuickTasks " + taskParameters.intEmployeeID + "," + taskParameters.ProjectID + ",'" + taskParameters.TaskName + "','" + taskParameters.Duration + "'," + taskParameters.FilterTaskTypeID + "," + taskParameters.SubTasktypeID + ",'" + taskParameters.CreatedBy + "','" + taskParameters.dtFromDate + "'," + taskParameters.PriorityID + "," + taskParameters.ActualPercentComplete + ",'" + taskParameters.Description + "'," + taskParameters.bitFlag, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Ajit L on 27/11/2024      
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTaskDetails([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Sel_TaskDetails " + taskParameters.intEmployeeID + "," + taskParameters.TaskID + " ";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CopyDailyActivity(TimesheetEntry DAParams)
        {
            try
            {
                string Message = "0";
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_DailyActivity_Copy " + DAParams.intEmployeeID + ",'" + DAParams.dtFromDate + "','" + DAParams.dtToDate + "'", true, CommonController.connectionString), ""));
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object ExportDocument([FromBody] TaskParameter taskParameters)
        {
            try
            {
                string strSQL;
                string strFilePath;
                //string strFormat;
                //string strCaptions;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = taskParameters.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                if (taskParameters.StatusCode != "Null")
                {
                    if (taskParameters.intProxyUserID == 0)
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList Null," + taskParameters.employeeID + ",'" + taskParameters.StatusCode + "'";
                    }
                    else
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",'" + taskParameters.StatusCode + "'";
                    }
                }
                else
                {
                    if (taskParameters.intProxyUserID == 0)
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList Null," + taskParameters.employeeID + ",Null";
                    }
                    else
                    {
                        strSQL = "usp_Whizible2_CRW_Sel_tbl_PM_ResourceTimesheetReportList " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",Null";
                    }
                }


                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                m_lngReportID = 22272;
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                // get a unique file name
                m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                // add extn to file name based on format requested
                switch (ReportFormat)
                {
                    case "PDF": m_strFileName += ".pdf"; break;
                    case "HTML": m_strFileName += ".htm"; break;
                    case "RTF": m_strFileName += ".rtf"; break;
                    case "EXCEL": m_strFileName += ".xls"; break;
                    case "CSV": m_strFileName += ".csv"; break;
                    case "TEXT": m_strFileName += ".txt"; break;
                    case "XML": m_strFileName += ".xml"; break;
                    default: m_strFileName += ".pdf"; break;
                }
                IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_SEL_Tbl_PM_CompanyInformation", CommonController.connectionString);

                while (drCompInfo.Read())
                {
                    CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompInfo["CompanyName"], "").ToString();
                    DateFormatID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drCompInfo["DateFormatID"], "0"));
                }

                // create object of Adhoc reports
                oRpt = new AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));

                oRpt.UseMSSQL = true;
                oRpt.DefaultLCID = lngDefaultLCID;
                oRpt.LCID = lngCurrentThreadUICultureID;
                oRpt.UseHashTables = true;
                oRpt.DateFormat = DateFormatID;
                oRpt.CompanyName = CompanyName;
                oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");

                //' generate the report in requested format
                AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;
                switch (ReportFormat)
                {
                    case "PDF": oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                    case "HTML": oRpt.GenerateReport(AdHocReports.Format.HTML); break;
                    case "RTF": oRpt.GenerateReport(AdHocReports.Format.RTF); break;
                    case "EXCEL": oRpt.GenerateReport(AdHocReports.Format.EXCEL); break;
                    case "CSV": oRpt.GenerateReport(AdHocReports.Format.CSV); break;
                    case "TEXT": oRpt.GenerateReport(AdHocReports.Format.TEXT); break;
                    case "XML": oRpt.GenerateReport(AdHocReports.Format.XML); break;
                    default: oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                }

                oRpt = null;
                return m_strFileName;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        //End of comment by Rehan on 19-10-2022
        public object GenerateTimesheet([FromBody] TaskParameter taskParameters)
        {
            try
            {
                int timesheetID;
                //timesheetID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_Whizible2_GenerateResourceTimesheet " + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                if (taskParameters.intProxyUserID == 0)
                {
                    timesheetID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet Null," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                else
                {
                    timesheetID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                //Change Status to Regenerated in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.GetDataScalar("Exec usp_WhizibleTS2_Upd_ResouceTimesheetStatus  " + timesheetID + ", '" + taskParameters.StatusCode + "', " + taskParameters.intProxyUserID, true, CommonController.connectionString);

                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;

                //Getting Email messages
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 434", true, CommonController.connectionString);
                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            if (taskParameters.intMobileView == 1)
                            {
                                EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, timesheetID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                                Flag = "1";
                            }
                            else
                            {
                                Flag = "1";
                            }

                        }
                        else
                        {

                            EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, timesheetID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }
                return Flag + '$' + timesheetID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        //End of comment by Rehan on 19-10-2022
        public object GenerateMyTimesheet([FromBody] TaskParameter taskParameters)
        {
            try
            {

                int timesheetid;
                if (taskParameters.intProxyUserID == 0)
                {
                    timesheetid = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet Null," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                else
                {
                    timesheetid = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("usp_WhizibleTS2_GenerateResourceTimeSheet " + taskParameters.intProxyUserID + "," + taskParameters.employeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                }
                //Change Status to Regenerated in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.GetDataScalar("Exec usp_WhizibleTS2_Upd_ResouceTimesheetStatus  " + taskParameters.intTimesheetID + ",'" + taskParameters.StatusCode + "', " + taskParameters.intProxyUserID, true, CommonController.connectionString);

                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;

                //Getting Email messages

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 434", true, CommonController.connectionString);
                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            Flag = "1";
                        }
                        else
                        {

                            EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intTimesheetID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }
                //return (message);
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        public class TaskParameter
        {
            public int employeeID { get; set; }
            public int intProxyUserID { get; set; }
            public string StatusCode { get; set; }
            public int intTimesheetID { get; set; }
            public string dtFromDate { get; set; }
            public string dtToDate { get; set; }
            public string ReportFormat { get; set; }
            public int intMobileView { get; set; } = 0;

        }

        //Added by Vishal Mane on 04/06/2026 for Quick Entry insertion due to Rate Limit changes
        private static string ValidateDailyActivityRow(DAParams param)
        {
            var isTaskComplete = param.IsTaskComplete ? 1 : 0;
            var totalDuration = param.Duration.ToString(System.Globalization.CultureInfo.InvariantCulture);
            return Convert.ToString(CommonFunctions.Data.CheckIsDBNull(
                CommonFunctions.Data.GetDataScalar(
                    "usp_Whizible2_ValidateDA " + param.ProjectID + "," + param.EmployeeID + ",'" + param.EntryDate + "','" + param.Duration + "','" + totalDuration + "'," + param.TaskID + "," + isTaskComplete + "," + param.SubTasktypeID,
                    true,
                    CommonController.connectionString),
                ""));
        }
        //End of Added by Vishal Mane on 04/06/2026 for Quick Entry insertion due to Rate Limit changes

        [HttpPost]
        //Commented for parameter mismatch issue for Expleo on 05/08/2025
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        public object ValidateDA([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;
                if (taskParameters.Flag != "Responsive")
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_ValidateDA " + taskParameters.ProjectID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.Duration + "','" + taskParameters.TotalDuration + "'," + taskParameters.TaskID + "," + taskParameters.IsTaskComplete + "," + taskParameters.SubTasktypeID + "", true, CommonController.connectionString), ""));
                }
                else
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_ValidateDA_Responsive " + taskParameters.ProjectID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.Duration + "','" + taskParameters.TotalDuration + "'," + taskParameters.TaskID + "," + taskParameters.IsTaskComplete + "," + taskParameters.SubTasktypeID + "", true, CommonController.connectionString), ""));
                }
                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTaskDataOnCopy([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_sel_tbl_PM_DailyActivity_CV " + obj.intEmployeeID + ",'" + obj.dtFromDate + "','" + obj.dtToDate + "','" + obj.WhereClause + "'";

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return taskListTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTimesheetStatus([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Get_tbl_PM_ResourceTimesheet null," + obj.intEmployeeID + ",'" + obj.dtFromDate + "','" + obj.dtToDate + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateTimesheet([FromBody] TimesheetEntry taskParameters)
        {
            try
            {
                string strmsg;
                strmsg = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_ValidateMyTimesheet " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString));
                return (strmsg);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        public object ValidateStoryPoint([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string strsql = "";
                string strResult = "";
                strsql = "EXEC usp_Whizible2_chk_ValidateStoryPoint " + taskParameters.TaskID + "," + taskParameters.StoryPoint + ",'" + taskParameters.dtFromDate + "'";

                strResult = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql, true, CommonController.connectionString), ""));

                return strResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ConvertDecimalToHourViceVersa([FromBody] RequestParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_ConvertDecimalToHourViceVersa '"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.WorkHrs)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Flag));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Ajit L on 27/11/2024            
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateCreateTask_WorkNew([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string Message;
                if (taskParameters.intSubTaskTypeID == 0)
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_TimesheetTask_WorkHrs " + HttpUtility.UrlDecode(Convert.ToString(taskParameters.ProjectID)) + "," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.Duration)) + "','" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.TaskName)) + "'," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.CTselectdate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(taskParameters.intEmployeeID)) + ",NULL", true, CommonController.connectionString), ""));
                }
                else
                {
                    Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_TimesheetTask_WorkHrs " + HttpUtility.UrlDecode(Convert.ToString(taskParameters.ProjectID)) + "," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.Duration)) + "','" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.TaskName)) + "'," +
                        "'" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.CTselectdate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(taskParameters.intEmployeeID)) + "," +
                        "" + HttpUtility.UrlDecode(Convert.ToString(taskParameters.intSubTaskTypeID)) + "", true, CommonController.connectionString), ""));
                }


                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object PlotMyTimesheetList([FromBody] TaskParameters RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_WhizibleTS2_sel_tbl_PM_ResourceTimesheet_Updated "
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intEmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Flag)) + "'";
                object dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetMyTimesheetHistory([FromBody] TaskParameters RequestParameters)
        {
            try
            {
                DataTable TimesheetHistoryTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_ResourceTimesheetStatus_History " + RequestParameters.intTimesheetID + "", true, CommonController.connectionString);
                return TimesheetHistoryTable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteMyTimesheet([FromBody] TaskParameters taskParameters)
        {
            try
            {
                string msg;
                msg = Convert.ToString(CommonFunctions.Data.InsertOrUpdateData("usp_Whizible2_Del_tbl_PM_ResourceTimesheet " + taskParameters.intTimesheetID + "", true, CommonController.connectionString));

                return (msg);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added and modified by Vishal Mane on 09/09/2025 to apply base solution changes to practus
        [HttpPost]
        [Authorize]
        public object IsDailyActivityFilled([FromBody] TimesheetEntry obj)
        {

            string strSQL = "";
            try
            {
                strSQL = "usp_Whizible2_Sel_IsDailyActivityFilled " + obj.intEmployeeID + ",'" + obj.dtFromDate + "'," + obj.ProjectID + "," + obj.TaskID + "";
                string dt = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added and modified by Vishal Mane on 09/09/2025 to apply base solution changes to practus

        //Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object bindProxyUsers([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Sel_tbl_CNF_ProxyUser_Mapping_Detail " + obj.intEmployeeID;
                DataTable resourceList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return resourceList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Vishal Mane on 04/08/2025 to plot proxy users drop down for Expleo

        //Added by Vishal Mane on 18/08/2025 to delete filter entry for that resourec if it is clicked on project tab of applied filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object deleteFilter([FromBody] TimesheetEntry obj)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Del_PM_TimesheetFilter " + obj.intEmployeeID;
                string resourceList = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                return resourceList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added and modified by Vishal Mane on 09/09/2025 to apply base solution changes to practus to delete filter entry for that resourec if it is clicked on project tab of applied filter


        //Added by Vishal Mane on 20/08/2025 to get Proxy Resource related Timesheet Data
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object PlotMyTimesheetList_Proxy([FromBody] TimesheetEntry RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_WhizibleTS2_sel_tbl_PM_ResourceTimesheet_Proxy "
                       + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProxyResourceID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Flag)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.intEmployeeID)) + "";
                object dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Vishal Mane on 20/08/2025 to get Proxy Resource related Timesheet Data


        //Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization
        //Mobile View - View Timesheet - Week Days (Added by Swapnagandha K.)
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object BindWeekDays([FromBody] TaskParameters taskParameters)
        {
            try
            {
                List<VTWeek_MV> WeekDaysList = new List<VTWeek_MV>();
                DataTable WeekDaysTable;
                if (taskParameters.intTimesheetID == 0)
                {   //Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                    //WeekDaysTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "',NULL,'" + taskParameters.ViewTimesheetPageLoad + "'", true, CommonController.connectionString);
                    WeekDaysTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "',NULL", true, CommonController.connectionString);
                    //End of Added and Modified by Vishal Mane on 20/11/2025to fix crash on edit mode.
                }
                else
                {
                    WeekDaysTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.intTimesheetID + "", true, CommonController.connectionString);

                }
                //WeekDaysTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','"+ taskParameters.dtToDate +"'", true, CommonController.connectionString);
                foreach (DataRow projectFilterRow in WeekDaysTable.Rows)
                {
                    VTWeek_MV weekDays = new VTWeek_MV()
                    {
                        Total = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Total"], "")),
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["EntryDate"], "")),
                        Day = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Day"], "")),
                        DayName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["DayName"], "")),
                        Year = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Year"], "")),
                        MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["MonthName"], "")),
                        AllTotal = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["AllTotal"], "")),
                        ExpectedHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ExpectedHours"], "")),
                        CurrentDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["CurrentDate"], "")),
                        Period = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["Period"], "")),
                        //IsWorking = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["IsWorking"], "")),
                    };
                    WeekDaysList.Add(weekDays);
                }
                return WeekDaysList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object PostTimesheetData([FromBody] TaskParameters1 taskParameters)
        {
            try
            {
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                string TimesheetID; //Added By Dipali V On 26th March 2020 For Status Issues
                string strFromDate, strToDate, strRemarks, TaskStatusFlag;
                int intDailyActivityID, intVerified;
                bool blnSendEmail, blnShowPopup;
                DataTable ResourceTimesheetTable;
                // if (taskParameters.intTaskID == 0)
                //{
                ResourceTimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ResourceTimesheetDADetails " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",null", true, CommonController.connectionString);
                //}
                //else
                //{
                //    ResourceTimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ResourceTimesheetDADetails " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ","+ taskParameters.intTaskID +"", true, CommonController.connectionString);
                //}

                foreach (DataRow taskRow in ResourceTimesheetTable.Rows)
                {
                    if ((Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["IsDisabled"], "0"))) == "0")
                    {
                        strFromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["FromDate"], Convert.ToString(DateTime.Now)));
                        strToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["ToDate"], Convert.ToString(DateTime.Now)));
                        intDailyActivityID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskRow["DailyActivityEntryID"], "0"));
                        intVerified = 1;
                        strRemarks = "";
                        TaskStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["TimesheetStatusFlag"], "Not Set"));
                        //Added By Dipali V On 26th March 2020 For Status Issues
                        TimesheetID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["TimesheetID"], ""));
                        //End of Added By Dipali V On 26th March 2020 For Status Issues
                        // Execute sp to update verification details to Daily Activity Table
                        if (taskParameters.Status == "V")
                        {
                            if (TaskStatusFlag != "J")
                            {
                                //Commented And Added By Dipali V On 26th March 2020 For Status Issues
                                //CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'", true, CommonController.connectionString);
                                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + TimesheetID + "", true, CommonController.connectionString);
                                //End of Added By Dipali V On 26th March 2020 For Status Issues
                            }

                        }
                        //Commented And Added By Riddhesh Patil for Timesheet reject Functionality Issue
                        //else if (taskParameters.Status == "J")
                        //{
                        //    if (TaskStatusFlag != "V")
                        //    {
                        //        //Commented And Added By Dipali V On 26th March 2020 For Status Issues
                        //        //CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'", true, CommonController.connectionString);
                        //        CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + TimesheetID + "", true, CommonController.connectionString);
                        //        //End of Added By Dipali V On 26th March 2020 For Status Issues
                        //    }
                        //}
                        else if (taskParameters.Status == "J")
                        {
                            CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "',''," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + TimesheetID + "", true, CommonController.connectionString);
                        }
                        //End of Commented And Added By Riddhesh Patil for Timesheet reject Functionality Issue
                    }
                }
                //Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Upd_tbl_PM_ResourceTimesheetStatus " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.Status + "'", true, CommonController.connectionString);
                //If Resource TimeSheet are verified then change the status to 'verified' 
                DataTable ResourceTimesheetStatusTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_ResourceTimesheet_GetVerifiedTasksStatus " + taskParameters.intTimesheetID + "", true, CommonController.connectionString);
                // drVerify = CommonFunctions.Data.GetDataReader("Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus 3847", CommonFunctions.General.GetApplicationKeySetting("UseSQL"));
                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Upd_ResouceTimesheetStatus " + taskParameters.intTimesheetID + ",'" + taskParameters.Status + "','" + taskParameters.strComment.Replace("'", "''") + "','" + taskParameters.intAllowToResubmit + "'", true, CommonController.connectionString);

                //GetEmailMessage_435(taskParameters.intEmployeeID, taskParameters.dtFromDate, taskParameters.dtToDate);
                ////Email
                ///
                DataTable EmailDataTable;
                if (taskParameters.Status == "V")
                {
                    EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 435", true, CommonController.connectionString);
                }
                else
                {
                    EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 436", true, CommonController.connectionString);
                }

                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            //Added By Usha Pandit On 27.03.2020 For integrating missing code
                            if (taskParameters.intMobileView == 1)
                            {
                                if (taskParameters.Status == "V")
                                {
                                    EmailMessagesController.GetEmailMessage_435(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, Convert.ToDateTime(taskParameters.dtFromDate), Convert.ToDateTime(taskParameters.dtToDate), taskParameters.intTimesheetID);
                                    EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                                }
                                else
                                {
                                    EmailMessagesController.GetEmailMessage_436(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, taskParameters.intTimesheetID);
                                    EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                                }
                            }
                            else
                            {

                            }
                            //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
                            Flag = "1";
                        }
                        else
                        {
                            if (taskParameters.Status == "V")
                            {
                                EmailMessagesController.GetEmailMessage_435(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, Convert.ToDateTime(taskParameters.dtFromDate), Convert.ToDateTime(taskParameters.dtToDate), taskParameters.intTimesheetID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                            }
                            else
                            {
                                EmailMessagesController.GetEmailMessage_436(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, taskParameters.intEmployeeID, taskParameters.intResourceID, taskParameters.intTimesheetID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                            }
                            Flag = "0";

                        }
                    }
                    else { return "1"; }
                }
                return Flag;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End of Added by Vishal Mane on 14/10/2025 to have saperate MyTimesheet api end points in TimesheetEntry Controller
        public class VTWeek_MV
        {
            public string Total { get; set; }
            public string EntryDate { get; set; }
            public string Day { get; set; }
            public string DayName { get; set; }
            public string Year { get; set; }
            public string MonthName { get; set; }
            public string AllTotal { get; set; }
            public string ExpectedHours { get; set; }
            public string CurrentDate { get; set; }
            public string Period { get; set; }
            public string IsWorking { get; set; }
        }
        //End of Added by Vishal Mane on 18/11/2025 for 4 and 8 Hrs Timesheet Alert Validation for Expleo Customization
        //Added by vikas T for merge as per W26
        public class TaskParameters1
        {
            public int intEmployeeID { get; set; }
            public string dtFromDate { get; set; }
            public string dtToDate { get; set; }
            public int intTimesheetID { get; set; }
            public string Status { get; set; }
            public string strComment { get; set; }
            public int intAllowToResubmit { get; set; } = 0;
            public int intTaskID { set; get; } = 0;
            public int intResourceID { get; set; } = 0;
            //Added By Usha Pandit On 27.03.2020 For integrating missing code
            public int intMobileView { get; set; } = 0;
            //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
            //Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
            public int intApproverID { get; set; } = 0;
            //End of Added by Vishal Mane on 31/01/2025 to fix issue if Timesheet has 2 Approvers
        }
        //Ended by vikas T for merge as per W26
    }


}
