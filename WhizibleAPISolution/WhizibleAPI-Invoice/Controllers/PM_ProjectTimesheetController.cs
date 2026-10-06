using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Web;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    //Controller Name : PM_ProjectTimesheet
    //Created By : Dipali V
    //Created Date : 26th Sep 2023
    public class PM_ProjectTimesheetController : ApiController
    {
        //Added By Dipali V For Get Project Timesheet List
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object PM_ProjectTimesheetList([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable result;
            string query = "";
            query = "EXEC usp_Whizible2_tbl_PM_TimeSheetInvoice " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualWork)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.Status)) + "'";
            result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
            return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For Get Delete Timesheet List
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectTimesheetDetails([FromBody] ProjectTimesheet Parameters)
        {
            try
            {

                DataTable dt = CommonFunctions.Data.GetDataTable("USP_Whizible2_Del_tbl_PM_ProjectTimesheet '" + HttpUtility.UrlDecode(Parameters.UniqueIDs) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "", true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Get ProjectTimesheetApproveReject Comments
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectTimesheetComments([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable dt = CommonFunctions.Data.GetDataTable("USP_Whizible2_tbl_PM_TimeSheetInvoicecomments " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 27th Sep 2023  For Get Show History Details
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetTimesheetInformation([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                DataTable result;
                string query = "";
                query = "EXEC usp_Whizible2_CSP_ProjectResourceHHMMWage_1 " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectSiteID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetAdvisedID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID)) + ""; //TimesheetAdvisedID
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //Added By Dipali V For Check Filter Name Exists or not
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object chkFilterExists([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string Flag;
            string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists_ForWBS '"
            + HttpUtility.UrlDecode(Convert.ToString(Parameters.Flag)) + "','"
            + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID)) + "','"
            + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', "
            + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",0,"
            + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID));
            Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
            return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        // Added By Dipali V For Check Saved Filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SavedFilters([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + Parameters.TagID + ",0,"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) + ", '"
                                                                + HttpUtility.UrlDecode(Parameters.FilterName) + "', '"
                                                                + HttpUtility.UrlDecode(Parameters.LoginType) + "' ,'"
                                                                + HttpUtility.UrlDecode(Parameters.QueryText) + "','"
                                                                + HttpUtility.UrlDecode(Parameters.UserName) + "',"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.Flag)) + ","
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V  For Check Edit Filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object EditFilterData([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL;
            strSQL = "Exec usp_sel_ByFilterID_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));
            System.Data.DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Print Report 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object PrintReport([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                ProjectTimesheet ProjectTimesheet = new ProjectTimesheet();
            //ProjectTimesheet.EmployeeLists = new List<EmployeeList>();

            // Employee
            ProjectTimesheet.EmployeeLists = new List<EmployeeList>();
            DataTable dt_Employee = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_EmployeeTimeSheetBilling " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
            foreach (DataRow FilterRow in dt_Employee.Rows)
            {
                EmployeeList EmployeeFilter = new EmployeeList()
                {
                    EmployeeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["EmployeeID"], "0")),
                    EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["EmployeeName"], ""))
                };
                ProjectTimesheet.EmployeeLists.Add(EmployeeFilter);
            }


            // Site
            ProjectTimesheet.SiteLists = new List<SiteList>();
            DataTable dt_Site = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_SiteTimeSheetBilling " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
            foreach (DataRow FilterRow in dt_Site.Rows)
            {
                SiteList SiteFilter = new SiteList()
                {
                    SiteID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["SiteID"], "0")),
                    SiteName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["SiteName"], ""))
                };
                ProjectTimesheet.SiteLists.Add(SiteFilter);
            }

            // Site
            ProjectTimesheet.TimesheetLists = new List<TimesheetList>();
            DataTable dt_Timesheet = CommonFunctions.Data.GetDataTable("usp_Whizible2_v_tbl_PM_TimeSheetID " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
            foreach (DataRow FilterRow in dt_Timesheet.Rows)
            {
                TimesheetList TimesheetFilter = new TimesheetList()
                {
                    TimeSheetID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["TimeSheetID"], "0")),
                    TimeSheetText = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["TimeSheetText"], ""))
                };
                ProjectTimesheet.TimesheetLists.Add(TimesheetFilter);
            }

            


            return ProjectTimesheet;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Added By Dipali V For Print Report 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetWSRDetails([FromBody] ProjectTimesheet Parameters)
        {
            try
            {

                ProjectTimesheet WSRDetails = new ProjectTimesheet();
            //ProjectTimesheet.EmployeeLists = new List<EmployeeList>();

            // Project Details
            WSRDetails.WSRDetails = new List<WSRDetails>();
            DataTable DTWSR = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_WSR_ProjectInformationGrid " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
            foreach (DataRow FilterRow in DTWSR.Rows)
            {
                WSRDetails WSR = new WSRDetails()
                {
                    CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["CustomerName"], "0")),
                    CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["CreatedDate"], "")),
                    ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["ProjectName"], "")),
                    FromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["FromDate"], "")),
                    ToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["ToDate"], "")),
                    CompanyID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["CompanyID"], "")),
                    Subject = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Subject"], "")),
                    NextPeriodToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["NextPeriodToDate"], ""))
                };
                WSRDetails.WSRDetails.Add(WSR);
            }


            // OtherAttributes
            WSRDetails.OtherAttributes = new List<OtherAttributes>();
            DataTable dt_OtherAttributes = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_WSROtherAttributes " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
            foreach (DataRow FilterRow in dt_OtherAttributes.Rows)
            {
                OtherAttributes Filter = new OtherAttributes()
                {
                    TimeSheetNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["TimeSheetNo"], "0")),
                    ProjectID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["ProjectID"], "")),
                    HighLights = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["HighLights"], "")),
                    Sleepage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Sleepage"], "")),
                    Suggetion = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Suggetion"], "")),
                    Activities = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Activities"], "")),
                    WSRFileName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["WSRFileName"], "")),
                    FileDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["FileDescription"], "")),
                    Issues = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Issues"], ""))
                };
                WSRDetails.OtherAttributes.Add(Filter);
            }

            // WSR_Activities
            WSRDetails.WSR_Activities = new List<WSR_Activities>();
            DataTable dt_WSR_Activities = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_WSR_Activities " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
            foreach (DataRow FilterRow in dt_WSR_Activities.Rows)
            {
                WSR_Activities TimesheetFilter = new WSR_Activities()
                {
                     TaskID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["TaskID"], "0")),
                     Task = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Task"], "")),
                     WorkHrs = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["WorkHrs"], "")),
                     Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Status"], "")),
                     SumDuration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["SumDuration"], ""))
                };
                WSRDetails.WSR_Activities.Add(TimesheetFilter);
            }

            return WSRDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Save TimesheetDetails
        [Authorize]
        [HttpPost]
        public object GetProjectTimesheetDetails([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable result;

                string query = "";
                query = "EXEC usp_Whizible2_Sel_Tbl_whizible2_Generated_ProjectTimeSheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID));
                //+ HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID));
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ExportToReport([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName = "";
                long m_ReportID = 1889;
                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                string CompanyName = "";
                int DateFormatID = 0;
                AdHocReports.Report.AdHocReport oRpt;
                IDataReader drReport;
               
                strSQL = "USP_CSP_ProjectResourceWage_1 " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.SiteID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "";
                //strSQL = "usp_Whizible2_CSP_ProjectResourceWage_1 " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.SiteID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "";
                
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

                    oRpt = new AdHocReports.Report.AdHocReport(m_ReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));
                    
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
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        // Added By Dipali V For Get All My Save Filter

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object AllMyFilters([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL = "";
            strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query 0,"
            + Parameters.TagID + ",'"
            + HttpUtility.UrlDecode(Parameters.LoginType) + "' ,"
            + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID));
            DataTable dt = new DataTable();
            dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Dipali V For Delete Filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilter([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL = "";
            strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));
            DataTable dt = new DataTable();
            dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Conver tDecimal To Hour ViceVersa
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ConvertDecimalToHourViceVersa([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_ConvertDecimalToHourViceVersa '"
                       + HttpUtility.UrlDecode(Convert.ToString(Parameters.WorkHrs)) + "',"
                       + HttpUtility.UrlDecode(Convert.ToString(Parameters.Flag));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Delete Record from Advised Table
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteAdvice([FromBody] TimesheetParameter Parameters)
        {
            try
            {
                string result;

            string query = "";
            query = "EXEC USP_Whizible2_Del_Tbl_whizible2_TimeSheetInvoiceAdvise " + HttpUtility.UrlDecode(Convert.ToString(Parameters.AdviceID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID));
            result = Convert.ToString(CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString));
            return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Saved All Details of billing information page
        [Authorize]//, App_Start.ValidateHeaders
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveGridDetails([FromBody] TimesheetParameter Parameters)
        {
            string result;
            try
            {
                string query = "";
                query = "EXEC USP_Whizible2_Upd_Tbl_whizible2_TimeSheetInvoiceAdviseGridDetails "
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.AdviceID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID)) + ",'"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.BillingRate)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualRate)) + "',"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.WorkingDays)) + ",'"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.NoDayWorked)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.DailyRate)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceAmount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.fltDiscount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.FinalAmount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.EditAmount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.PMEditDifference)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.Remarks)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "',"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.OUWorkingDays)) + ",'"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.WorkingHrsPerDay)) + "',"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.BufferPercentage)) + ",'"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.MonthlyHr)) + "',"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.Discount)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualDayBilling)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.EffortToConsider)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.FixedMonthlyRate)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.OnsiteFull)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.SiteValidation)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.CapConsider)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.CapHoliday)) + ",'"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceDate)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.OldNoDayWorked)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.OldInvoiceAmount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.EditedActualHrs)) + "'";
                result = Convert.ToString(CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString));



                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Added By Dipali V For Convert tDecimal To Hour ViceVersa
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveUpdateAdviceDetails([FromBody] TimesheetParameter Parameters)
        {
            string result;
            try
            {
                string query = "";
                query = "EXEC USP_Whizible2_Upd_Tbl_whizible2_TimeSheetInvoiceAdvise " + HttpUtility.UrlDecode(Convert.ToString(Parameters.AdviceID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.PMEditValue)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.PMFinalEditDiffValue)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.Remarks)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceAmount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.OldInvoiceAmount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.Discount)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.NoDayWorked)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.OldNoDayWorked)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualRate)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.EditedActualHrs)) + "','"
                    //Added By Dipali V On 26th Dec 2023 for To Update Final Amount Value
                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.FinalAmount)) + "'";
                //End of Added By Dipali V On 26th Dec 2023 for To Update Final Amount Value
                result = Convert.ToString(CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString));

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Added By Dipali V To Set Default Applied Filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter 0,'"
                + HttpUtility.UrlDecode(Parameters.LoginType) + "' ,"
                + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) + ","
                + Parameters.TagID + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameters.Flag));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        // Added By Dipali V For Get Default Applied Filter
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetDefaultFilter([FromBody] ProjectTimesheet Parameter)
        {
            string strSQL = "";
            try
            {
                IDataReader DefaultQueryFilter;
            FilterQuery DefaultQuery = new FilterQuery();

            strSQL = "Exec usp_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter 0,"
            + Parameter.TagID + ",'"
            + HttpUtility.UrlDecode(Parameter.LoginType) + "' ,"
            + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID));

            DefaultQueryFilter = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (DefaultQueryFilter.Read())
            {
                DefaultQuery.FilterID = Convert.ToInt32(DefaultQueryFilter["FilterID"]);
                DefaultQuery.FilterName = Convert.ToString(DefaultQueryFilter["FilterName"]);
                DefaultQuery.QueryText = Convert.ToString(DefaultQueryFilter["QueryText"]);
                DefaultQuery.Error = Convert.ToString("ok");
            }
            return DefaultQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Dipali V For Get Billing Information
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetTimesheetBillingDetails([FromBody] TimesheetParameter Parameters)
        {
            DataTable result;
            try
            {
                string query = "";
                query = "EXEC USP_Whizible2_Sel_Tbl_whizible2_TimeSheetInvoiceAdvise " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceTimesheetID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID));

                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 24th Sep 2023 For get min hours for da Entry
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRestrictByMinHours_MinHoursForDAEntry()
        {
            try
            {
                string strSQL = "";
            strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";
            WorkingDaysParameter Information = new WorkingDaysParameter();
            IDataReader CmpInformation;
            CmpInformation = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (CmpInformation.Read())
            {
                Information.RestrictByMinHours = Convert.ToBoolean(CmpInformation["RestrictByMinHours"]);
                Information.MinHoursForDAEntry = CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0").ToString();
            }
            return Information;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 24th Sep 2023 For Check TImesheet Status
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetTimesheetReadyToAuthenticateFlag([FromBody] TimesheetParameter Parameters)
        {
            DataTable result;
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_sel_tbl_PM_TimeSheetInvoice_ReadyToAuthenticate " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID));
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        // Added By Dipali V For Invoice Setting at Project Level
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectSettingDetails([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Tbl_whizible2_InvoiceSettingProjectLevel " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) +"";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Dipali V For Saved Invoice Setting at Project Level
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SaveProjectLevelSettings([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                string strSQL = "";
                //Added By Dipali V On 27th Dec 2023 For Which Currency Consider for Calculation on billing Information Page
                strSQL = "Exec usp_UPD_Whizible2_Tbl_whizible2_InvoiceSettingProjectLevel " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsRate_CorporateValidation)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsTS_WorkingDayCorporateValidation)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsIR_FinalValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsAllowSmartEdit)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsIR_Approved)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsIR_Rejected)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsAllValuesInSiteCurrency)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectTimesheetApprover)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectIRApprover)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectIRGenerator)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserName)) + "'";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Dipali V On 2nd Nov 2023 For Get TS Approver
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
       
        public object GetProjectTimesheetApprover([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable getProjectTimesheetApproverTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ProjectTimesheetApprovers @ProjectID=" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)), true, CommonController.connectionString);
                return getProjectTimesheetApproverTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Dipali V On 2nd Nov 2023 For Get IR Approver
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectIRApprover([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable getProjectTimesheetApproverTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_RFIApprover " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)), true, CommonController.connectionString);
                return getProjectTimesheetApproverTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Dipali V On 2nd Nov 2023 For Get IR Generator
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectIRGenerator([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable getProjectTimesheetApproverTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_ProjectIRGenerator " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)), true, CommonController.connectionString);
                return getProjectTimesheetApproverTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 2nd Nov 2023 For ValidateIRSetting
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateIRConfiguration([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable getProjectTimesheetApproverTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Validation_IR_BillingBaseLocalCompanyBaseCurrency " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)), true, CommonController.connectionString);
                return getProjectTimesheetApproverTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        ////Added By Dipali V On 3rd Jan 2024 For ValidateContractValues

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateContractValues([FromBody] ProjectDetail Parameters)
        {
            try
            {
                string IsValidateContractValues = Convert.ToString(CommonFunctions.Data.GetDataScalar("USP_Whizible2_ValidateContractValues " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractTypeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.strAdvisedIDs)) + "'", true, CommonController.connectionString));
                return IsValidateContractValues;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V For Get Project Rate Methods
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectRateMethod([FromBody] TimesheetParameter Parameters)
        {
            try
            {
                DataTable RateMehods;
                string query = "";
                query = "EXEC usp_Whizible2_Sel_RateMethods " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID));

                RateMehods = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return RateMehods;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V On 2nd Nov 2023 For ValidateIRSetting
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CheckIRGenerationRateValidation([FromBody] ProjectTimesheet Parameters)
        {
            try
            {
                DataTable getProjectTimesheetApproverTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Timsheet_IR_Billing " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", NULL ," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)), true, CommonController.connectionString);
                return getProjectTimesheetApproverTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 2nd Nov 2023 For Get All Dropdown While Create IR
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetAllDropdown([FromBody] ProjectDetail Parameters)
        {
            DataTable GetType;
            DataTable GetCustomer_RFI;
            DataTable GetContactPersons;
            DataTable GetContactPersonsEmailID;
            DataTable GetAddress;
            DataTable GetContractType;
            DataSet ds = new DataSet();
            try
            {
                string query = "";


                query = "usp_Sel_tbl_PM_RFITypesMaster NULL,1 ";
                GetType = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                query = "usp_Sel_tbl_PM_Customer_RFI NULL, '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectOrProduct)) + "'";
                GetCustomer_RFI = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);


                query = "usp_Sel_tbl_PM_CustomerContactPersons " + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "";
                GetContactPersons = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                query = "usp_Sel_tbl_PM_CustomerContactPersons_EmailID " + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "";
                GetContactPersonsEmailID = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                
                query = "usp_Sel_tbl_PM_Customer_Addresses_ForProject " + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "";
                GetAddress = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                query = "usp_Whizible2_Sel_tbl_PM_ContractTypeMaster " + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "";
                GetContractType = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            ds.Tables.Add(GetType); // Fill GetType
            ds.Tables.Add(GetContactPersons); //ContactPersons
            ds.Tables.Add(GetCustomer_RFI); // Customer_RFI
             ds.Tables.Add(GetContactPersonsEmailID); // GetContactPersonsEmailID
             ds.Tables.Add(GetAddress); // GetContactPersonsEmailID
             ds.Tables.Add(GetContractType); // GetContactPersonsEmailID
            return ds;
        }

        //Added By Dipali V On 3rd Nov 2023 For Get Customer Address Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCustomerAddress([FromBody] ProjectDetail Parameters)
        {
            try
            {
                DataTable getProjectTimesheetApproverTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_Customer_Addresses " + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerAddrId)), true, CommonController.connectionString);
                return getProjectTimesheetApproverTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 3rd Nov 2023 For Get Sales Period Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSalesPeriodDetails([FromBody] ProjectDetail Parameters)
        {
            try
            {
                DataTable getSalesPeriods = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_SalesPeriodMaster " + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsOpen)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodYear)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodMonth)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodStartDate))  + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodEndDate)) +"'", true, CommonController.connectionString);
                return getSalesPeriods;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 3rd Nov 2023 For Get Sales Period Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSalesPersonDetails([FromBody] ProjectDetail Parameters)
        {
            try
            {
                DataTable getSalesPerson = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_Project_SalesPersons " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.SalesPersonName)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.SaleCommision)) + "'", true, CommonController.connectionString);
                return getSalesPerson;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 3rd Nov 2023 For Get Sales Period Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetContract([FromBody] ProjectDetail Parameters)
        {
            try
            {
                DataTable getContractType = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ContractMaster " + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractTypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.BillingCurrencyID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.IRConversionDate)) + "'", true, CommonController.connectionString);
                return getContractType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Dipali V For Get Contact Person Mail ID
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetContactPersonEmail([FromBody] ProjectDetail Parameters)
        {
            try
            {
                string getCustomerEmailID = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_tbl_PM_CustomerContactPersons_EmailID " + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerContactID)) + "", true, CommonController.connectionString));
                return getCustomerEmailID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //Added By Dipali V For Get RFI Contract Documents
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFIContractDocument([FromBody] ProjectDetail Parameters)
        {
            try
            {
                string query = "";
            query = "EXEC usp_Whizible2_Sel_tbl_PM_ContractTypeDoc " + Parameters.ContractID;
            DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
            return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For 28th Dec 2023 For Get Values in Billing Currency if Site Currency Flag Set
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetValueIntoBillingCurrency([FromBody] ProjectDetail Parameters)
        {
            try
            {
                string query = "";
                query = "EXEC USP_Whizible2_GetConvertedValuesInBillingCurrency " + Parameters.ProjectID + "," + Parameters.TimesheetNo + ",'" + Parameters.InvoiceDate +"'";
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V For 28th Dec 2023 For Get Values in Billing Currency if Site Currency Flag Set
        //Added By Dipali V For Create IR-PIR & IR Items
        [Authorize]//, App_Start.ValidateHeaders
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CreateIRItem([FromBody] ProjectDetail Parameters)
        {
            try
            {
                string result;
                string query = "";
                query = "EXEC usp_Whizible2_Ins_tbl_PM_RFIs " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsProforma)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFITypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerContactID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.CustomerAddressID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.BillingCurrencyID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreditDays)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.LOC)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ConfirmEmailID)) + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.MilestoneID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFIHeader)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.SalesPeriodID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceDate)) + "'";
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString));
                Parameters.RFID = result;
                
                //query = "EXEC usp_Upd_tbl_PM_RFIs_ChangeRFIStatus " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'Draft','-','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                query = "EXEC usp_Whizible2_Upd_tbl_PM_RFIs_ChangeRFIStatus " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'Draft','-','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);


                // query = "EXEC usp_Ins_tbl_PM_RFI_SalesPersons_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",',','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                //query = "EXEC usp_Ins_tbl_PM_RFI_SalesPersons_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.SalesPersonIDs)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                query = "EXEC usp_Whizible2_Ins_tbl_PM_RFI_SalesPersons_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.SalesPersonIDs)) + ",','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);

               // query = "EXEC usp_Ins_tbl_PM_RFI_Tools_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",',','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                query = "EXEC usp_Whizible2_Ins_tbl_PM_RFI_Tools_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",',','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);

               // query = "EXEC usp_Ins_tbl_PM_RFI_OS_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",',','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                query = "EXEC usp_Whizible2_Ins_tbl_PM_RFI_OS_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",',','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);

                //----- IR Item Creation
                query = "EXEC usp_Whizible2_Ins_ProjectTimesheet_RFIItems " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.CreatorOrModifier)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.strAdvisedIDs)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);
                //return result;
                WorkingDaysParameter Information = new WorkingDaysParameter();
                IDataReader CmpInformation;
                if (Parameters.RFID != "0")
                {
                  
                    CmpInformation = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_RFIs " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)), true, CommonController.connectionString);
                    if (CmpInformation.Read())
                    {
                        Information.m_intChecklistID = Convert.ToString(CmpInformation["ChecklistID"]);
                        Information.m_intChecklistInstanceID = CommonFunctions.Data.CheckIsDBNull(CmpInformation["ChecklistInstanceID"], "0").ToString();
                        Information.RFID = Parameters.RFID;
                    }
                    
                }
                return Information;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Get Checklist Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCheckListItemsDetails([FromBody] ProjectDetail Parameters)
        {
            try
            {
                DataTable getchecklist= CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_RFIChecklist_Items_ForInvoiceGeneration " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ChecklistID)) + "", true, CommonController.connectionString);
                return getchecklist;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For Save Checklist Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveChecklistItems([FromBody] ProjectDetail Parameters)
        {
            try
            {
                int m_intChecklistInstanceID = 0;
                string query = "EXEC usp_Ins_tbl_PM_RFIChecklistInstances NULL , " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ChecklistID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + ", NULL ";
                m_intChecklistInstanceID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString));
                if (Parameters.RFID != "0")
                {

                    if (m_intChecklistInstanceID != 0)
                    {
                        string[] strChecklistItem;
                        string[] strRFIChecklistComments;
                        string[] strRFIChecklistResponse;
                        int intCtr;
                        
                        strChecklistItem = Parameters.ChecklistItemID.Split(',');
                        strRFIChecklistComments = Parameters.RFIChecklistComments.Split(',');
                        strRFIChecklistResponse = Parameters.RFIChecklistResponse.Split(',');
                        for (intCtr = 0; intCtr <= strChecklistItem.Length - 1; intCtr++)
                        {

                            query = "EXEC usp_Ins_tbl_PM_RFIChecklistInstance_Items  NULL , " + m_intChecklistInstanceID + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + Parameters.ChecklistID + "," + HttpUtility.UrlDecode(Convert.ToString(strChecklistItem[intCtr])) + "," + strRFIChecklistResponse[intCtr] + ",'" + HttpUtility.UrlDecode(Convert.ToString(strRFIChecklistComments[intCtr])) + "','" + Parameters.CreatorOrModifier + "'";
                            CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);

                        }

                        query = "EXEC usp_Whizible2_Upd_tbl_PM_RFIs_ChecklistInstanceID " + m_intChecklistInstanceID + "," + Parameters.RFID + "";
                        CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);

                    }
                }

                return "1";
            }
            
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Dipali V For Submit IR
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SubmitIR([FromBody] TimesheetParameter Parameters)
        {
            try
            {
                string result;

                string query = "";
                query = "EXEC usp_Whizible2_INS_tbl_PM_RFI_Status '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.IRStatus)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.IRCommets)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RFID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserName)) + "'";
                result = Convert.ToString(CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString));
                //return result;
                string blnShowPopup = "False";
                string blnSendEmail = "False";
                IDataReader drEmailMessage;
                string strMessage = "";
                drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 51", true, CommonController.connectionString);
                if (drEmailMessage.Read())
                {
                    blnSendEmail = drEmailMessage["SendMail"].ToString();
                    blnShowPopup = drEmailMessage["ShowPopup"].ToString();
                }

                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "";

                if (blnSendEmail == "True" && blnShowPopup == "False")
                {
                    EmailMessagesController.GetEmailMessage_51(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, Parameters.RFID, Parameters.ProjectID, Parameters.UserID);
                    EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                }
                return blnShowPopup;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }
}
