using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Text;
//using System.IO;
using WhizibleAPI.Models.Timesheet;
using System.Net.Http;
using System.Net;

namespace WhizibleAPI.Controllers
{
    public class TimesheetApprovalDetailController : ApiController
    {
        [HttpPost]
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by Rehan on 19-10-2022
        public object GetTimesheetApprovalData([FromBody] TimesheetApprovalDetailTaskParameters taskParameters)
        {
            try
            {
                TimesheetApprovalDetail timesheetApprovalDetail = new TimesheetApprovalDetail();
                DataTable countTable;
                //Get ActualHours ,ExpectedHours and Status Of selected Timesheet
                if (taskParameters.intTimesheetID == 0)
                {
                    countTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet null," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                }
                else
                {
                    if (taskParameters.PageFlag == 3)
                    {
                        countTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet_Approval " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.intApproverID + "", true, CommonController.connectionString);
                    }
                    else
                    {
                        countTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                    }

                }

                foreach (DataRow countRow in countTable.Rows)
                {
                    GetActualExpectedHours countObject = new GetActualExpectedHours();
                    countObject.ActualHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(countRow["ActualHours"], "0"));
                    countObject.ExpectedHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(countRow["ExpectedHours"], "0"));
                    countObject.Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(countRow["Status"], "Not Submitted"));
                    countObject.EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(countRow["EmployeeName"], ""));
                    timesheetApprovalDetail.GetActualExpectedHours = countObject;
                }

                //To get Table header
                timesheetApprovalDetail.headerColumns = new List<TimesheetApprovalHeaderColumn>();
                DataTable headerDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetTSWeekHeader " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);

                foreach (DataRow headerRow in headerDataTable.Rows)
                {
                    TimesheetApprovalHeaderColumn headerColumn = new TimesheetApprovalHeaderColumn()
                    {
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["EntryDate"], "")),
                        DayName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(headerRow["DayName"], "")),
                        IsWorking = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(headerRow["IsWorking"], "0")),
                    };
                    timesheetApprovalDetail.headerColumns.Add(headerColumn);
                }

                //Week Total
                timesheetApprovalDetail.WeekTotalLists = new List<TAWeekTotal>();
                //Commented And Added By Usha Pandit On 27.03.2020 For integrating missing code
                //DataTable WeekTotalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                DataTable WeekTotalTable;
                if (taskParameters.intTimesheetID == 0)
                {
                    WeekTotalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                }
                else
                {
                    WeekTotalTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Detail " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.intTimesheetID + "", true, CommonController.connectionString);
                }
                //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
                foreach (DataRow weekTotalRow in WeekTotalTable.Rows)
                {
                    TAWeekTotal weekTotal = new TAWeekTotal()
                    {
                        Total = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["Total"], "0")),
                        EntryDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["EntryDate"], "")),
                        AllTotal = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["AllTotal"], "0")),
                        WeekDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(weekTotalRow["WeekDays"], "0"))
                    };
                    timesheetApprovalDetail.WeekTotalLists.Add(weekTotal);
                }

                //Timesheet Detail List
                timesheetApprovalDetail.timesheetLists = new List<TimesheetDetailList>();
                string strSQL;
                if (taskParameters.intTimesheetID == 0)
                {
                    strSQL = "usp_Whizible2_Sel_tbl_PM_MyTimeSheetDetails " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'";

                }
                else
                {
                    strSQL = "usp_Whizible2_sel_tbl_PM_ResourceTimesheetApproval_Detail " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.intApproverID + "";

                }

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskListRow in taskListTable.Rows)
                {
                    TimesheetDetailList timesheetList = new TimesheetDetailList()
                    {
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskID"], "0")),
                        TaskName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskName"], "")),
                        SubTaskType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubTaskType"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ProjectName"], "")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Description"], "")),
                        MonDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonDAID"], "0")),
                        TueDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueDAID"], "0")),
                        WedDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedDAID"], "0")),
                        ThuDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuDAID"], "0")),
                        FriDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriDAID"], "0")),
                        SatDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatDAID"], "0")),
                        SunDAID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunDAID"], "0")),
                        //Commented & Added By Dipali V On 21st Oct 2021 For Conversion & Get Exact Hours
                        //Mon = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Mon"], "0")),
                        //Tue = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tue"], "0")),
                        //Wed = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Wed"], "0")),
                        //Thu = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Thu"], "0")),
                        //Fri = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Fri"], "0")),
                        //Sat = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sat"], "0")),
                        //Sun = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sun"], "0")),
                        Mon = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Mon"], "0")),
                        Tue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tue"], "0")),
                        Wed = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Wed"], "0")),
                        Thu = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Thu"], "0")),
                        Fri = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Fri"], "0")),
                        Sat = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sat"], "0")),
                        Sun = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Sun"], "0")),
                        //End of Commented & Added By Dipali V On 21st Oct 2021 For Conversion & Get Exact Hours

                        MonStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonStoryPoint"], "0")),
                        TueStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueStoryPoint"], "0")),
                        WedStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedStoryPoint"], "0")),
                        ThuStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuStoryPoint"], "0")),
                        FriStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriStoryPoint"], "0")),
                        SatStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatStoryPoint"], "0")),
                        SunStoryPoint = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunStoryPoint"], "0")),
                        MonDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonDescription"], "")),
                        TueDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueDescription"], "")),
                        WedDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedDescription"], "")),
                        ThuDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuDescription"], "")),
                        FriDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriDescription"], "")),
                        SatDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatDescription"], "")),
                        SunDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunDescription"], "")),
                        //Added By Usha Pandit On 27.03.2020 For integrating missing code
                        MonStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonStatusFlag"], "")),
                        TueStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueStatusFlag"], "")),
                        WedStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedStatusFlag"], "")),
                        ThuStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuStatusFlag"], "")),
                        FriStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriStatusFlag"], "")),
                        SatStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatStatusFlag"], "")),
                        SunStatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SunStatusFlag"], "")),
                        MonAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["MonAllowToResubmit"], "0")),
                        TueAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["TueAllowToResubmit"], "0")),
                        WedAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["WedAllowToResubmit"], "0")),
                        ThuAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ThuAllowToResubmit"], "0")),
                        FriAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["FriAllowToResubmit"], "0")),
                        SatAllowToResubmit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SatAllowToResubmit"], "0")),
                        //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
                        //Commented And Added By Dipali V On 21st Oct 2021 For getting correct Actual Work
                        //ActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                        ActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualWork"], "0")),
                        //End Added By Dipali V On 21st Oct 2021 For getting correct Actual Work
                        ActualStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualStartDate"], "")),
                        ActualEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualEndDate"], "")),
                        ActualPercentComplete = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ActualPercentComplete"], "0")),
                        ResourcePercentComplete = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourcePercentComplete"], "0")),
                        IsTaskComplete = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsTaskComplete"], "0")),
                        WhichTask = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["WhichTask"], "")),
                        SubTaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubTaskTypeID"], "0")),
                        IsProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsProject"], "0")),
                        Percentage = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Percentage"], "0")),
                        Tasknotes = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Tasknotes"], "")),
                        StartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["StartDate"], "")),
                        EndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["EndDate"], "")),
                        Work = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["Work"], "0")),
                        MileStone = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["MileStone"], "")),
                        Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Phase"], "")),
                        SubProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["SubProjectName"], "")),
                        DeliverableName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["DeliverableName"], "")),
                        ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["ModuleName"], "")),
                        Issue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["Issue"], "")),
                        IsAgileProject = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsAgileProject"], "0")),
                        ResourceLevelTaskCompletion = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ResourceLevelTaskCompletion"], "0")),
                        ApplyEffortDistribution = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["ApplyEffortDistribution"], "0")),
                        IsVerified = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsVerified"], "0")),
                        IsApprover = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskListRow["IsApprover"], "0")),
                        StatusFlag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["StatusFlag"], "")),
                        //Commented & Addeed By  Dipali V On 21st Oct 2021 For Getting Workhours As per DB i.e with digit 2
                        //TaskActualWork = Convert.ToSingle(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskActualWork"], "0")),
                        TaskActualWork = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskListRow["TaskActualWork"], "0")),
                        //End of Commented & Addeed By Dipali V On 21st Oct 2021 For Getting Workhours As per DB i.e with digit 2
                    };
                    timesheetApprovalDetail.timesheetLists.Add(timesheetList);
                }

                return timesheetApprovalDetail;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //End of comment by Rehan on 19-10-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveApproveRejectTask([FromBody] TimesheetApprovalDetailTaskParameters taskParameters)
        {
            try
            {
                string strFromDate, strToDate, strRemarks;
                int intDailyActivityID, intVerified;
                DataTable ResourceTimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ResourceTimesheetDADetails " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + "," + taskParameters.intTaskID + "", true, CommonController.connectionString);
                foreach (DataRow taskRow in ResourceTimesheetTable.Rows)
                {
                    //  if ((Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["IsDisabled"], "0"))) == "0")
                    //  {
                    strFromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["FromDate"], Convert.ToString(DateTime.Now)));
                    strToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskRow["ToDate"], Convert.ToString(DateTime.Now)));
                    intDailyActivityID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskRow["DailyActivityEntryID"], "0"));
                    //2021
                    var fromWhere = taskParameters.FromWhere;
                    //2021
                    if (taskParameters.Status == "V")
                    {
                        intVerified = 0;
                    }
                    else
                    {
                        intVerified = 1;
                    }

                    strRemarks = taskParameters.strComment;

                    // Execute sp to update verification details to Daily Activity Table
                    //2021
                    //CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "','" + taskParameters.strComment + "'," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + taskParameters.intTimesheetID + "", true, CommonController.connectionString);
                    if (fromWhere == "")
                    {
                        CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "','" + taskParameters.strComment + "'," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + taskParameters.intTimesheetID + ", NULL", true, CommonController.connectionString);
                    }
                    else
                    {
                        CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_upd_tbl_PM_ResourceTimesheetVerification " + intDailyActivityID + "," + intVerified + "," + taskParameters.intEmployeeID + ",'" + DateTime.Now + "','" + taskParameters.strComment + "'," + taskParameters.intAllowToResubmit + ",'" + taskParameters.Status + "'," + taskParameters.intTimesheetID + ", '" + fromWhere + "'", true, CommonController.connectionString);
                    }
                    //2021
                    //   }
                    if (taskParameters.TaskCompleteChecked == 1)
                    {
                        CommonFunctions.Data.GetDataScalar("EXEC usp_Upd_AssignedTasks_Updation '" + taskParameters.intTaskID + "','O'", true, CommonController.connectionString);
                    }
                }
                //Added & Commented By Dipali V On 25th May 2020 For Update status of Timesheet
                //if (taskParameters.Status == "J")
                //{
                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Upd_tbl_PM_ResourceTimesheetStatus " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.Status + "'", true, CommonController.connectionString);
                CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Upd_ResouceTimesheetStatus " + taskParameters.intTimesheetID + ",'" + taskParameters.Status + "','" + taskParameters.strComment.Replace("'", "''") + "','" + taskParameters.intAllowToResubmit + "'", true, CommonController.connectionString);
                // }
                //End of Added & Commented By Dipali V On 25th May 2020 For Update status of Timesheet
                return "1";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object UpdateTaskCompleted([FromBody] TimesheetApprovalDetailTaskParameters taskParameters)
        {
            try
            {
                string TaskList = taskParameters.TaskList;
                CommonFunctions.Data.GetDataScalar("EXEC usp_Upd_AssignedTasks_Updation '" + TaskList + "','O'", true, CommonController.connectionString);
                return "1";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Rehan on 19-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by Rehan on 19-10-2022
        public object ExportDocument([FromBody] TimesheetApprovalDetailTaskParameters taskParameters)
        {
            try
            {
                string strSQL;
                string strFilePath;
                string strFormat;
                string strCaptions;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                //Added By Usha Pandit On 27.03.2020 For integrating missing code
                IDataReader drReport;
                //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
                string ReportFormat = taskParameters.ReportFormat;
                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                if (taskParameters.intTimesheetID == 0)
                {
                    strSQL = "usp_Whizible2_CRW_sel_tbl_PM_ResourceTimesheetView_Detail " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'";
                }
                else
                {
                    //Commented & Added BY Rutuja D. on 17 April 2020 For IssueID = 23580
                    //strSQL = "usp_Whizible2_CRW_sel_tbl_PM_ResourceTimesheetApproval_Detail " + taskParameters.intTimesheetID + "";
                    strSQL = "usp_Whizible2_CRW_sel_tbl_PM_ResourceTimesheetApproval_Detail " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'";
                    //Commented & Added BY Rutuja D. on 17 April 2020 For IssueID = 23580

                }
                //Added By Usha Pandit On 27.03.2020 For integrating missing code
                drReport = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drReport.Read())
                {
                    //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
                    m_lngReportID = 22271;
                    //Added By Usha Pandit On 27.03.2020 For integrating missing code
                    CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                    CommonEngines.HashTables.Culture.FillCultureHashTable();
                    //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
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

                    //Added By Usha Pandit On 27.03.2020 For integrating missing code
                }
                else
                {
                    return "0";
                }
                //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //}
        //Uncommented By Dipali V On 9th march 2021 for Getting Timesheet Status
        //Added By Usha Pandit On 27.03.2020 For integrating missing code
        //Mobile View - View Timesheet - GetTimesheetStatus (Added by Swapnagandha K.)
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<VTStatus_MV> GetTimesheetStatus_MV([FromBody] TimesheetApprovalDetailTaskParameters taskParameters)
        public object GetTimesheetStatus_MV([FromBody] TimesheetApprovalDetailTaskParameters taskParameters)

        {
            try
            {
                List<VTStatus_MV> TimesheetList = new List<VTStatus_MV>();
                DataTable TimesheetTable;
                if (taskParameters.intTimesheetID == 0)
                {
                    TimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet null," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                }
                else
                {
                    if (taskParameters.PageFlag == 3)
                    {
                        TimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet_Approval " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'," + taskParameters.intApproverID + "", true, CommonController.connectionString);
                    }
                    else
                    {
                        TimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_tbl_PM_ResourceTimesheet " + taskParameters.intTimesheetID + "," + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                    }

                }


                //commented By Dipali V On 9th march 2021 for Getting Timesheet Status
                //TimesheetTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_GetWeekTotalForEmployee_Mobile " + taskParameters.intEmployeeID + ",'" + taskParameters.dtFromDate + "','" + taskParameters.dtToDate + "'", true, CommonController.connectionString);
                //End of commented By Dipali V On 9th march 2021 for Getting Timesheet Status
                foreach (DataRow TRow in TimesheetTable.Rows)
                {
                    VTStatus_MV TimesheetData = new VTStatus_MV()
                    {
                        TimesheetID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(TRow["TimesheetID"], "0")),
                        ActualHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TRow["ActualHours"], "0")),
                        ExpectedHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TRow["ExpectedHours"], "0")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TRow["Status"], "Not Submitted")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(TRow["EmployeeName"], "")),
                    };
                    TimesheetList.Add(TimesheetData);
                }
                return TimesheetList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }
    //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
    //End of Uncommented By Dipali V On 9th march 2021 for Getting Timesheet Status
    public class TimesheetApprovalDetailTaskParameters
    {
        public int intEmployeeID { get; set; }
        public string dtFromDate { get; set; }
        public string dtToDate { get; set; }
        public int intTimesheetID { get; set; } = 0;
        public string ReportFormat { get; set; }
        public int intApproverID { get; set; }
        public int intTaskID { get; set; }
        public string Status { get; set; }
        public string strComment { get; set; }
        public int intAllowToResubmit { get; set; } = 0;
        public string TaskList { get; set; }
        public int TaskCompleteChecked { get; set; }
        //Added By Usha Pandit On 27.03.2020 For integrating missing code
        public int PageFlag { get; set; }
        //End Of Added By Usha Pandit On 27.03.2020 For integrating missing code
        //2021
        public string FromWhere { get; set; }
        //2021
    }
}
