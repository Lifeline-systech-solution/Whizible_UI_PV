using System; 
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PMDashboard;

namespace WhizibleAPI.Controllers
{
    public class PMDshBoardController : ApiController
    {
        [Authorize]
        [HttpPost]
        public object GetCurrentDate()
        {
            try
            {
                DateTime date = DateTime.Now; 
                string Result = date.ToString("dd MMM yyyy");
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetPreviousWeekDate()
        {
            try

            {
                DateTime date = DateTime.Now;
                DateTime mondayOfLastWeek = date.AddDays(-(int)date.DayOfWeek - 6);
                string Fromdate = mondayOfLastWeek.ToString("dd MMM yyyy");
                string Todate = mondayOfLastWeek.AddDays(6).ToString("dd MMM yyyy");

                string Result = Fromdate + "~" + Todate;
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetThisWeekDate()
        {
            try
            {
                DateTime date = DateTime.Now;
                DateTime mondayOfLastWeek = date.AddDays(-(int)date.DayOfWeek + 1);
                string Fromdate = mondayOfLastWeek.ToString("dd MMM yyyy");
                string Todate = mondayOfLastWeek.AddDays(6).ToString("dd MMM yyyy");

                string Result = Fromdate + "~" + Todate;
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetNextWeekDate()
        {
            try
            {
                DateTime date = DateTime.Now;
                DateTime mondayOfLastWeek = date.AddDays(-(int)date.DayOfWeek + 8);
                string Fromdate = mondayOfLastWeek.ToString("dd MMM yyyy");
                string Todate = mondayOfLastWeek.AddDays(6).ToString("dd MMM yyyy");

                string Result = Fromdate + "~" + Todate;
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetDate([FromBody] PMDashboard P)
        {
            try
            {
                string Todate = "";
                DateTime date = Convert.ToDateTime(P.FromDate);
                if (P.Flag == 2)
                {                   
                    date = date.AddDays(0);
                }
                else if(P.Flag ==0)
                {
                    Todate = date.AddDays(-1).ToString("dd MMM yyyy");
                    date = date.AddDays(-1);
                }
                else
                {
                    Todate = date.AddDays(1).ToString("dd MMM yyyy");
                    date = date.AddDays(1);
                }
                string strFullDayName = date.ToString("dddd");
                string Result = Todate+"~"+ strFullDayName;
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
         
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ToDoListFill([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "";

                if (P.FromDate=="")
                {
                    P.FromDate = null;
                }

                if (P.ToDate == "")
                {
                    P.ToDate = null;
                }

                if (P.OrderByClause == "")
                {
                    P.OrderByClause = null;
                }

                if (P.WhereClause == "")
                {
                    P.WhereClause = null;
                }
                if (P.Querytype == 7)
                {
                    if (P.WhereClause == "" || P.WhereClause == null)
                    {
                        strsql = "Exec usp_DB_Whizible2_MenuOptions " + P.UserID + "," + P.Querytype + ",'" + P.OrderByClause + "' ";
                    }
                    else
                    {
                        strsql = "Exec usp_DB_Whizible2_MenuOptions " + P.UserID + "," + P.Querytype + ",'" + P.OrderByClause + "','" + P.WhereClause + "' ";
                    }
                }
                else if (P.Querytype ==8)
                {
                    if(P.WhereClause =="" || P.WhereClause == null)
                    {
                        P.OrderByClause = "ORDER BY [IsReviewee], R.ReviewType ASC', '1 = 1 AND  (Reviewee +'','' Like ''%" + P.UserName + "%'') OR (ReviewedBy +'','' Like ''%" + P.UserName + "%'')";
                    }
                    else
                    {
                        P.OrderByClause = "ORDER BY [IsReviewee], R.ReviewType ASC', ' " + P.WhereClause + " AND(Reviewee +'','' Like ''%" + P.UserName + "%'') OR (ReviewedBy +'','' Like ''%" + P.UserName + "%'')";
                    }
                    
                    strsql = "Exec usp_DB_Whizible2_MenuOptions " + P.UserID + "," + P.Querytype + ",'" + P.OrderByClause + "' ";
                }
                else if (P.Querytype == 5)
                {
                    if (P.WhereClause == "" || P.WhereClause == null)
                    {
                        strsql = "Exec usp_DB_Whizible2_MenuOptions " + P.UserID + "," + P.Querytype + ",'" + P.OrderByClause + "' ";
                    }
                    else
                    {
                        strsql = "Exec usp_DB_Whizible2_MenuOptions " + P.UserID + "," + P.Querytype + ",'" + P.OrderByClause + "','" + P.WhereClause + "' ";
                    }
                    
                }
                else
                {
                    strsql = "Exec usp_DB_Whizible2_MenuOptions " + P.UserID + "," + P.Querytype + ",'" + P.OrderByClause + "','" + P.WhereClause + "'," + P.GetProjectCount + ",'" + P.FromDate + "','" + P.ToDate + "' ";
                }
                //string strsql = "Exec usp_DB_Whizible2_MenuOptions " + P.UserID + ","+P.Querytype + ",'"+P.OrderByClause + "','"+P.WhereClause +"',"+P.GetProjectCount +",'"+ P.FromDate +"','"+ P.ToDate + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillDeliverable([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "";
                if (P.WhereClause=="" || P.WhereClause==null)
                {
                    strsql = "Exec usp_sel_Whizible2_deliverable_details " + P.UserID + ",'" + P.OrderByClause + "' ";
                }
                else
                {
                    strsql = "Exec usp_sel_Whizible2_deliverable_details " + P.UserID + ",'" + P.OrderByClause + "','" + P.WhereClause + "' ";
                }                
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillMyProject([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_ProjectStatus_ForEmployee " + P.UserID + ",'" + P.OrderByClause + "'," + P.Flag + " ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object IssueAgingFill([FromBody] PMDashboard P)
        {
            try
            { 
                string strsql = "Exec usp_DB_Project_Whizible2_BTSAginganalysis " + P.UserID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillDays([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_Missing_DA_Dates_for_Employee " + P.UserID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillPendingEntries([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_tbl_PM_DailyActivity_ForSimpleDA " + P.UserID + ",NULL, NULL, NULL,'" + P.FromDate + "' ,'" + P.FromDate + "', NULL, NULL, 1";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillPendingEntriesTotal([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_tbl_PM_DailyActivity_ForSimpleDA_TotalHHMM " + P.UserID + ",NULL, NULL, NULL,'" + P.FromDate + "' ,'" + P.FromDate + "', NULL, NULL, 1";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillTrackingDetails([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_MyeDashboard_ContextName " + P.TaskID + ",'" + P.FromWhere + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillDocument([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_Documents_Attached " + P.UserID + "," + P.ProjectID + "," + P.UniqueID + "," + P.TagID + ",'" + P.Paging + "','" + P.SortBy + "','" + P.SortOrder + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillFlagTo([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_whizible2_FlagTo_ComboFill_PMDashboard ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillTrackingDetailsInformation([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_sel_Whizible2_TrackingDtls_Edit " + P.TaskID + ",'" + P.FromWhere + "'," + P.UserID + " ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillIssueDocumentList([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_Documents_Attached_For_Issue " + P.ProjectID + ",'" + P.TaskID + "'," + P.TagID + " ,'" + P.Paging + "','" + P.SortBy + "','" + P.SortOrder + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveIssueFlagDetails([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_ins_TrackingDtls " + P.UserID + ",'" + P.Flagg + "'," + P.IssueID + " ," + P.ProjectID + ",'" + P.FlagTo + "','" + P.DueDate + "'," + P.isComplete + " ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ClearFlagDetails([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_del_TrackingDtls " + P.UniqueID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ShowDeliverableReport([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_Sel_DeliverableReport " + P.ScheduleID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ShowMilestoneReport([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_Sel_MilestoneReport " +  P.ProjectID +","+ P.AnalysisID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillProjectName([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_Sel_PM_ProjectName '" + P.ProjecIDs + "' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public string ExportToReport([FromBody] PMDashboard Parameters)
        {
            string strSQL = "";
            string strFilePath;
            string m_strFileName = "";
            long m_lngRiskReportID = Parameters.ReportID; 
            int lngDefaultLCID;
            int lngCurrentThreadUICultureID;
            //string ProjectId = HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
            lngDefaultLCID = 1033;
            lngCurrentThreadUICultureID = 1033;
            string CompanyName = "";
            int DateFormatID = 0;
            AdHocReports.Report.AdHocReport oRpt;
            IDataReader drReport;

            if(Parameters.ReportID == 1895)
            {
                strSQL = "usp_rpt_Deliverable_Report " + Parameters.DeliverableUniqueid;
            }
            else if (Parameters.ReportID == 746)
            {
                strSQL = "usp_Sel_ProjectStatus " + Parameters.DeliverableUniqueid;
            }
            else if (Parameters.ReportID == 640)
            {
                strSQL = "usp_Whizible2_CRW_PRS_Milestone_Main " + Parameters.DeliverableUniqueid;
            } 
            drReport = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (drReport.Read())
            {
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                switch (Parameters.ReportFormat)
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
                                 
                oRpt = new AdHocReports.Report.AdHocReport(m_lngRiskReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));
                 
                oRpt.UseMSSQL = true;
                oRpt.DefaultLCID = lngDefaultLCID;
                oRpt.LCID = lngCurrentThreadUICultureID;

                oRpt.UseHashTables = true;

                oRpt.DateFormat = DateFormatID;
                oRpt.CompanyName = CompanyName;
                oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");
                AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;

                switch (Parameters.ReportFormat)
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
            else
                return "0";
        }

        //To-Do-List Code Comment As per Saji sir Discuss
        //[Authorize, App_Start.ValidateHeaders]
        //[HttpPost]
        //public object FillToDoListProjectList([FromBody] PMDashboard P)
        //{
        //    try
        //    {
        //        string strsql = "Exec usp_Sel_Whizible2_Project_For_DA_Active_InActive_Projects " + P.UserID + ", NULL,'" + DateTime.Now.ToString("dd MMM yyyy") + "' ,'' ";
        //        DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
        //        return dt;
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}

        //[Authorize, App_Start.ValidateHeaders]
        //[HttpPost]
        //public object FillToDoListData([FromBody] PMDashboard P)
        //{
        //    try
        //    {
        //        string strsql = "Exec usp_Sel_Whizible2_GetTaskDetails " + P.TaskID;
        //        DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
        //        return dt;
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}

        //[Authorize, App_Start.ValidateHeaders]
        //[HttpPost]
        //public object FillToDoListTask([FromBody] PMDashboard P)
        //{
        //    try
        //    {
        //        string strsql = "Exec usp_Sel_Whizible2_tbl_PM_ProjectTasks_ForDA " + P.ProjectID +","+ P.UserID + ",NULL,NULL,NULL," +P.AssignedTasksFlag + ",NULL,NULL,NULL," +P.GetConcatenatedTaskID + ",NULL,'ORDER BY A.TaskName', NULL,'" + DateTime.Now.ToString("dd MMM yyyy") + "' ";
        //        DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
        //        return dt;
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}

        //[Authorize, App_Start.ValidateHeaders]
        //[HttpPost]
        //public object FillToDoListActivity([FromBody] PMDashboard P)
        //{
        //    try
        //    {
        //        string strsql = "Exec usp_sel_ProjectTaskType_SubTaskType_For_DA " + P.ProjectID + "," + P.Flag + " ";
        //        DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
        //        return dt;
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}

        //[Authorize, App_Start.ValidateHeaders]
        //[HttpPost]
        //public object FillToDoListSavevalidation([FromBody] PMDashboard P)
        //{
        //    try
        //    {
        //        string strsql = "Exec usp_Sel_Whizible2_Project_For_DA_Active_InActive_WorkflowProjects " + P.UserID ;
        //        DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
        //        return dt;
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillETCAuthentication([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_sel_Whizible2_tbl_TasksToAutheticate " + P.ETCID + ",'"+ P.Flagg + "',NULL,'T.TaskName','ASC' ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillETCProjectStatus([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_getProjectStatus " + P.ProjectID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ETCAuthSave([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_tbl_ETCAuthenticateInsertion " + P.ETCID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ETCAuthDelete([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Del_tbl_PM_ProjectTaskETC " + P.ETCID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeletePendingTaskEntry([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Whizible2_Del_tbl_PM_DailyActivity " + P.DailyActivityEntryID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ProjectidAccessiable([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_QRB_RoleLevelAccessFilter 'ProjectID'," + P.UserID + ",'" + P.LoginType +"',2,1,NULL ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetMileStoneAnalysisID([FromBody] PMDashboard P)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_GetMilestoneAnalysisID " + P.ProjectID + ","+ P.MileStoneID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }
}