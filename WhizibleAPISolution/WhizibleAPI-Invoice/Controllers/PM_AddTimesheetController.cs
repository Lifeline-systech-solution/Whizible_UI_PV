using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using System.Data;
using System.IO;
using Newtonsoft.Json;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    //Controller Name : PM_AddTimesheet
    //Created By : Dipali V
    //Created Date : 22th Sep 2023
    public class PM_AddTimesheetController : ApiController
    {
        ProjectDetail OnLoadFunctions = new ProjectDetail();
        ProjectDetail OnFromDateToDateValidation = new ProjectDetail();
        //Added By Dipali V For Get Project Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public HttpResponseMessage GetProjectDetails([FromBody] ProjectDetail Parameters)
        {
            string strSQL, FromDate, ToDate;
            int OUID;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {

                strSQL = "";
                strSQL = "usp_Whizible2_Sel_InfoForGenerateTimesheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                OnLoadFunctions.GetProjectDetail = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow sdr in OnLoadFunctions.GetProjectDetail.Rows)
                {
                    OUID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LocationID"].ToString(), "0"));

                    strSQL = "usp_Whizible2_GetDatesForTimeSheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                    OnLoadFunctions.GetDatesForTimeSheet = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    foreach (DataRow sdr1 in OnLoadFunctions.GetDatesForTimeSheet.Rows)
                    {
                        FromDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr1["FromDate"].ToString(), ""));
                        ToDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr1["ToDate"].ToString(), ""));
                        string query = "";
                        query = "DECLARE @intDays INT " + System.Environment.NewLine;

                        query += "EXEC usp_Whizible2_GetOUWorkingDays " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", '"
                            + FromDate + "','" + ToDate + "', @intDays OUTPUT" + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) + ", 0, "
                            + OUID + ", 'C' SELECT ' Days' = @intDays";
                        OnLoadFunctions.GetOUWorkingDay = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);
                    }
                }
                strSQL = "usp_Whizible2_Sel_RateMethods " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                OnLoadFunctions.RateMethods = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, OnLoadFunctions);
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        //Added By Dipali V For For Get Rate metbod


        //Added By Dipali V For Get Project Rate Methods
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectRateMethod([FromBody] TimesheetParameter Parameters)
        {
            try
            {
                DataTable RateMehods;
                string query = "";
                query = "EXEC usp_Whizible2_Sel_RateMethods " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                RateMehods = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return RateMehods;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V For Get TS Fill Not Fill Resource
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTSFillNotFillResource([FromBody] ProjectDetail Parameters)
        {
            DataTable GetTSFill;
            DataTable GetTSNotFill;
            DataTable GetTSVerified;
            DataSet ds = new DataSet();
            try
            {
                string query = "";

                query = "usp_Whizible2_Sel_CheckPendingTimesheetResources " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'";
                GetTSFill = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                query = "USP_Whizible2_GetVerifiedResourceTimesheetDetails " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'";
                GetTSVerified = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);


                query = "usp_Whizible2_EmployeenotFilledDA " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'";
                GetTSNotFill = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            ds.Tables.Add(GetTSFill); // Fill TS which not Verified
            ds.Tables.Add(GetTSVerified); // Fill TS with Verified
            ds.Tables.Add(GetTSNotFill); // TS not fill
            return ds;
        }


        ////Added By Dipali V For GetProjectSiteCalenderDetails
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectSiteCalenderDetails([FromBody] ProjectDetail Parameters)
        {
            try
            {
                var strSQL = "";
                IDataReader drGetHolidayList;
                var strDates = ",";
                var m_strTimeSheetNo = ",";
                if (Parameters.m_strFromTimeSheet == "1")
                {
                    if (Parameters.Month != "0" && Parameters.Year != "0")
                    {
                        strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day_Freeze " + Parameters.ProjectSiteID + "," + Parameters.Month + "," + Parameters.Year;
                    }
                    else
                    {
                        strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day_Freeze " + Parameters.ProjectSiteID + "," + Parameters.Month + "," + Parameters.Year;

                    }
                }
                else
                {

                    if (Parameters.Month != "0" && Parameters.Year != "0")
                    {
                        strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day_Freeze " + Parameters.ProjectSiteID + "," + Parameters.Month + "," + Parameters.Year;
                    }
                    else
                    {
                        strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Day_Freeze " + Parameters.ProjectSiteID + "," + Parameters.Month + "," + Parameters.Year;

                    }

                }
                drGetHolidayList = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (Parameters.m_strFromTimeSheet == "1")
                {
                    if ((Parameters.TimesheetNo) == "")
                    {
                        m_strTimeSheetNo = "0";
                    }
                    else
                    {
                        m_strTimeSheetNo = Parameters.TimesheetNo;
                    }
                    IDataReader drInter;
                    var strInterSQL = "";
                    strInterSQL = "usp_sel_Tbl_PM_SiteCal_Intermediate_Day " + m_strTimeSheetNo;
                    drInter = CommonFunctions.Data.GetDataReader(strInterSQL, true, CommonController.connectionString);
                    while (drInter.Read())
                    {
                        strDates += CommonFunctions.Data.CheckIsDBNull(drInter["Day"], "") + ",";
                    }
                }
                var m_strHolidayList = "";
                var m_NormalDays = "";
                var WeekDays = "";
                var StartingWeek = "";
                while (drGetHolidayList.Read())
                {
                    if (Parameters.m_strFromTimeSheet == "1")
                    {
                        if (strDates == ",")
                        {
                            if (Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Holiday"], "0")) == "True")
                            {
                                m_strHolidayList = m_strHolidayList + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Day"], "")) + ",";

                            }
                            else
                            {
                                m_NormalDays = m_NormalDays + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Day"], "")) + ",";
                            }
                        }
                        else
                        {
                            if (strDates.IndexOf("," + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Day"], "")) + ",") > -1)
                            {
                                if (Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Holiday"], "0")) == "True")
                                {
                                    m_strHolidayList = m_strHolidayList + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Day"], "")) + ",";
                                }
                                else
                                {
                                    m_NormalDays = m_NormalDays + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Day"], "")) + ",";
                                }
                            }


                        }
                    }
                    else
                    {
                        if (Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Holiday"], "0")) == "True")
                        {
                            m_strHolidayList = m_strHolidayList + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Day"], "")) + ",";
                        }
                        else
                        {
                            m_NormalDays = m_NormalDays + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drGetHolidayList["Day"], "")) + ",";
                        }


                    }
                }

                var strGetHolidays = "";
                IDataReader drHolidays;
                if (Parameters.Month != "0" && Parameters.Year != "0")
                {
                    strGetHolidays = "Exec usp_GetOULevelHolidays " + Parameters.ProjectID + "," + Parameters.Month + "," + Parameters.Year + "," + Parameters.ProjectSiteID + "";
                }
                else
                {
                    strGetHolidays = "Exec usp_GetOULevelHolidays " + Parameters.ProjectID + "," + Parameters.Month + "," + Parameters.Year + "," + Parameters.ProjectSiteID + "";
                }
                drHolidays = CommonFunctions.Data.GetDataReader(strGetHolidays, true, CommonController.connectionString);

                while (drHolidays.Read())
                {
                    m_strHolidayList = m_strHolidayList + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drHolidays["Day"], "")) + ",";
                }

              
                return m_strHolidayList + "&&&&" + m_NormalDays;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////Added By Dipali V For GetProjectSiteDetails
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectSiteCalDetails([FromBody] ProjectDetail Parameters)
        {
            try
            {

                ProjectTimesheetDetails ProjectTimesheet = new ProjectTimesheetDetails();

                // SiteCalendar_Day
                ProjectTimesheet.SiteCalenderList = new List<SiteCalenderList>();

                DataTable dt_Employee = CommonFunctions.Data.GetDataTable("usp_sel_tbl_PM_ProjectSiteCalendar_Day " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectSiteID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.Month)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.Year)) + "", true, CommonController.connectionString);
                foreach (DataRow FilterRow in dt_Employee.Rows)
                {
                    SiteCalenderList SiteCalender = new SiteCalenderList()
                    {
                        SiteCalendarDayID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["SiteCalendarDayID"], "0")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["ProjectID"], "")),
                        SiteID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["SiteID"], "")),
                        Holiday = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["Holiday"], "")),
                        Freeze = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["Freeze"], "")),
                        Day = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Day"], "")),
                        NormalHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Day"], "")),
                        ExtraHours = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["Day"], "")),
                    };
                    ProjectTimesheet.SiteCalenderList.Add(SiteCalender);
                }

                ProjectTimesheet.StartingDayOfWeek = new List<StartingDayOfWeek>();

                DataTable dt_StartingDayOfWeek = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ProjectSites_StartingDayOfWeek_WeekDays " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectSiteID)) + "", true, CommonController.connectionString);
                foreach (DataRow FilterRow in dt_StartingDayOfWeek.Rows)
                {
                    StartingDayOfWeek SiteCalender = new StartingDayOfWeek()
                    {

                        WeekDays = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["WeekDays"], "")),
                        StartingWeek = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["StartingDayOfWeek"], "")),
                        //Commeneted & Added By Dipali V On 27th Oct 2023 For Get HH:MM
                        WorkHrs = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["WorkHrs"], "")),
                        ExtraHoursCap = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["ExtraHoursCap"], ""))
                        //WorkHrs = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FilterRow["WorkHrs"], "")),
                        //ExtraHoursCap = ToInt32.ToDouble(CommonFunctions.Data.CheckIsDBNull(FilterRow["ExtraHoursCap"], ""))
                        //End of Commeneted & Added By Dipali V On 27th Oct 2023 For Get HH:MM
                    };
                    ProjectTimesheet.StartingDayOfWeek.Add(SiteCalender);
                }

                return  ProjectTimesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For Get Project Sites
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectSites([FromBody] TimesheetParameter Parameters)
        {
            try
            {
                DataTable ProjectSites;
                string query = "";
                query = "EXEC usp_Whizible2_GetProjectSites " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                ProjectSites = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return ProjectSites;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //End of Added By Dipali V For For Get Project Sites
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ConvertDecimalToHourViceVersa([FromBody] WorkingDaysParameter Parameters)
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
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V For For Convert Decimal To Hour ViceVersa
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object Validatedate([FromBody] WorkingDaysParameter Parameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_CheckConversionRateDefinedOrNot "
                       + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'"
                       + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceDate)) + "'";
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V For For Convert Decimal To Hour ViceVersa
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ShowMessagesForNodata([FromBody] WorkingDaysParameter Parameters)
        {
            try
            {

                string strSQL = "";
                string IsNoData = "0";

                strSQL = "Exec usp_Whizible2_ViewTimeSheet '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) + ",0";

                WorkingDaysParameter Information = new WorkingDaysParameter();
                IDataReader CmpInformation;
                CmpInformation = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (CmpInformation.Read())
                {
                    IsNoData = "1";

                }

                return IsNoData.ToString();
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V For For Convert Decimal To Hour ViceVersa
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public HttpResponseMessage OnFromDateToDateValidationsCall([FromBody] ProjectDetail Parameters)
        {
            string strSQL, FromDate, ToDate;
            int OUID;
            HttpRequestMessage request = new HttpRequestMessage();
            try
            {
                strSQL = "";
                strSQL = "usp_Whizible2_Sel_tbl_PM_CompanyInformation_OverlapValidation ";
                OnFromDateToDateValidation.OverlapValidation = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                strSQL = "usp_Whizible2_Sel_DailyActivityCheck " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                OnFromDateToDateValidation.EntryFound = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                strSQL = "usp_Whizible2_sel_tbl_PM_TimeSheetInvoice_FromDate_ToDate_ProjectID " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                OnFromDateToDateValidation.TimeSheetInvoiceDates = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, OnFromDateToDateValidation);
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //Added By Dipali V For For GetRestrictByMinHours_MinHoursForDAEntry
        //get min hours for da Entry
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
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For Get Project Start Date EndDate
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectStartDateEndDate([FromBody] int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_StartDate_EndDate_tbl_PM_project " + ProjectID;

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For Get Project Start Date EndDate
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GenerateProjectTimesheet([FromBody] WorkingDaysParameter Parameters)
        {
            try
            {
                bool blnNoData = false;
                string stremployeename = "", strSQL;
                string intTimeSheetNo = "";
                int IsAllValuesInSiteCurrency = 0;
                //Added and commented by Vishal Mane on 04/03/2025 to fix Prod Issue
                //IDataReader drTImeSheet;
                DataTable drTImeSheet;
                //End of Added and commented by Vishal Mane on 04/03/2025 to fix Prod Issue
                int TimesheetInvoiceID;
                string dblWorkingHrsPerDay = "";
                string dblMonthlyHr = "";
                object DAPresentForPeriod = CommonFunctions.Data.GetDataScalar("EXEC usp_Whizible2_Sel_CheckDailyActivity_For_Given_Date '" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.ProjectID + "," + Parameters.RateMethod, true, CommonController.connectionString);
                if (DAPresentForPeriod.ToString().ToUpper() == "ND")
                {
                    blnNoData = true;
                }
                else
                {
                    blnNoData = false;
                }
                stremployeename = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + Parameters.UserID, true, CommonController.connectionString));

                if (blnNoData == false)
                {
                    strSQL = "usp_Whizible2_GenerateTimeSheet '" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.ProjectID + ", 0,'" + stremployeename + "'," + Parameters.RateMethod + "";
                    //Added and commented by Vishal Mane on 04/03/2025 to fix Prod Issue
                    //drTImeSheet = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                    drTImeSheet = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    //if (drTImeSheet.Read())
                    //{
                    //    intTimeSheetNo = Convert.ToString(drTImeSheet["TimeSheetNo"]);
                    //    IsAllValuesInSiteCurrency = Convert.ToInt32(drTImeSheet["IsAllValuesInSiteCurrency"]);
                    //}
                    if (drTImeSheet != null && drTImeSheet.Rows.Count > 0)
                    {
                        intTimeSheetNo = Convert.ToString(drTImeSheet.Rows[0]["TimeSheetNo"]);
                        IsAllValuesInSiteCurrency = drTImeSheet.Rows[0]["IsAllValuesInSiteCurrency"] != DBNull.Value
                            ? Convert.ToInt32(drTImeSheet.Rows[0]["IsAllValuesInSiteCurrency"])
                            : 0;  
                    }
                    //End of Added and commented by Vishal Mane on 04/03/2025 to fix Prod Issue

                    //For Generate TS
                    strSQL = "usp_Ins_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.ContractType + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.OUWorkingDays + ",'" + Parameters.WorkingHrsPerDay + "'," + Parameters.BufferPercentage + ",'" + Parameters.MonthlyHr + "'," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "'," + Parameters.EffortToConsider + "," + Parameters.ProjectCurrency + ",'" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + Parameters.RateMethod;

                    if (Parameters.InvoiceDate == "NULL")
                    {
                        strSQL += ",NULL," + intTimeSheetNo.ToString();
                    }
                    else
                    {
                        strSQL += ",'" + Parameters.InvoiceDate + "'," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + "";
                    }

                    TimesheetInvoiceID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    //---------------------------------T & M By Resource Hourly----------------------------
                    if ((Convert.ToString(Parameters.ContractType) == "2" || Convert.ToString(Parameters.ContractType) == "6" || Convert.ToString(Parameters.ContractType) == "1") && Convert.ToString(Parameters.RateMethod) == "1")
                    {


                        //strSQL = "usp_Ins_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.ContractType + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.OUWorkingDays + ",'" + Parameters.WorkingHrsPerDay + "'," + Parameters.BufferPercentage + ",'" + Parameters.MonthlyHr + "'," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "'," + Parameters.EffortToConsider + "," + Parameters.ProjectCurrency + ",'" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + Parameters.RateMethod;

                        //if (Parameters.InvoiceDate == "NULL")
                        //{
                        //    strSQL += ",NULL," + intTimeSheetNo.ToString();
                        //}
                        //else
                        //{
                        //    strSQL += ",'" + Parameters.InvoiceDate + "'," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + "";
                        //}

                        //TimesheetInvoiceID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_Resource " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //T & M By Resource Daily
                    else if ((Convert.ToString(Parameters.ContractType) == "2" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "6" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "1") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "2")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_Resource " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }

                    //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=1
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "2" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "6" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "1") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" &&   Convert.ToString(Parameters.FixedMonthlyRate) == "Yes" && Convert.ToString(Parameters.OnsiteFull) == "1")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=0
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "2" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "6" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "1") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes" && Convert.ToString(Parameters.OnsiteFull) == "0")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //T & M Resource Monthly FixedMonthlyRate=1
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "2" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "6" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "1") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_Resource " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //T & M Resource  Monthly ActualDayBilling=1
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "2" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "6" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "1") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.ActualDayBilling) == "Yes")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_Resource " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //---------------------------------T & M Role Hourly----------------------------
                    else if ((Convert.ToString(Parameters.ContractType) == "3" || Convert.ToString(Parameters.ContractType) == "7") && Convert.ToString(Parameters.RateMethod) == "1")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_ByRole " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //Daily
                    else if ((Convert.ToString(Parameters.ContractType) == "3" || Convert.ToString(Parameters.ContractType) == "7") && Convert.ToString(Parameters.RateMethod) == "2")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_ByRole " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    // T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=1
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "3" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "7") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes" && Convert.ToString(Parameters.OnsiteFull) == "1")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    // T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=0
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "3" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "7") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes" && Convert.ToString(Parameters.OnsiteFull) == "0")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //T & M Resource Monthly FixedMonthlyRate=1
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "3" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "7") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_ByRole " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //T & M Resource Monthly ActualDayBilling=1
                    else if ((HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "3" || HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "7") && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.ActualDayBilling) == "Yes")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_ByRole " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }

                    //---------------------------------------------------FixedFree
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "5" && IsAllValuesInSiteCurrency == 0)
                    {
                        //Parameters.Flag = 2;
                        //Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        //dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        //strSQL = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Parameters.Discount + ",'NULL','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Parameters.Discount + ",'Yes','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "5" && IsAllValuesInSiteCurrency == 1)
                    {
                        //Parameters.Flag = 2;
                        //Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        //dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        //strSQL = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Parameters.Discount + ",'NULL','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_FixedFree_SiteCurrency " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Parameters.Discount + ",'Yes','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //---------------------------------------------------Project Site Hourly
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "4" && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "1")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_SiteBilling " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";

                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //---------------------------------------------------Project Site Daily
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "4" && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "2")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_SiteBilling " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";

                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //---------------------------------------------------Project Site Monthly FixedMonthlyRate=1 & OnSiteFull=1
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "4"  && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes" && Convert.ToString(Parameters.OnsiteFull) == "1")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //---------------------------------------------------Project Site Monthly FixedMonthlyRate=1 & OnSiteFull=0
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "4" && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes" && Convert.ToString(Parameters.OnsiteFull) == "0")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //Project Site Monthly FixedMonthlyRate=1
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "4" && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.FixedMonthlyRate) == "Yes")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_SiteBilling " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }
                    //Project Site Monthly ActualDayBilling=1
                    else if (HttpUtility.UrlDecode(Convert.ToString(Parameters.ContractType)) == "4"  && HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) == "3" && Convert.ToString(Parameters.ActualDayBilling) == "Yes")
                    {
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.WorkingHrsPerDay;
                        dblWorkingHrsPerDay = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        Parameters.Flag = 2;
                        Parameters.WorkHrs = Parameters.MonthlyHr;
                        dblMonthlyHr = Convert.ToString(ConvertDecimalToHourViceVersa(Parameters));
                        strSQL = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_SiteBilling " + Parameters.ProjectID + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + Parameters.RateMethod + "," + Parameters.OUWorkingDays + ",'" + dblWorkingHrsPerDay.ToString() + "'," + Parameters.BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + Parameters.EffortToConsider + "," + Parameters.Discount + ",'" + Parameters.ActualDayBilling + "','" + Parameters.FixedMonthlyRate + "'," + Parameters.OnsiteFull + "," + intTimeSheetNo.ToString() + "," + Parameters.SiteValidation.ToString() + "," + Parameters.CapConsider.ToString() + "," + Parameters.CapHoliday.ToString() + ",'" + Parameters.InvoiceDate + "'," + TimesheetInvoiceID.ToString() + "";
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    }

                }


                return intTimeSheetNo;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 26th Sep 2023  For Get ProjectTimesheetList
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ViewTaskList([FromBody] WorkingDaysParameter Parameters)
        {
            try
            {
                DataTable result;
                string query = "";
                query = "EXEC usp_Whizible2_ViewTimeSheet '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RateMethod)) + "";
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }

        //Added By Dipali V For For Get Project Start Date EndDate
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetOUDuration([FromBody] WorkingDaysParameter Parameters)
        {
            object result;
            try
            {
                string query = "";
                query = "DECLARE @intDays INT " + System.Environment.NewLine;
                query += "EXEC usp_Whizible2_GetOUWorkingDays " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", '"
                                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','"
                                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "', @intDays OUTPUT" + ", "
                                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID)) + ", 0, "
                                    + HttpUtility.UrlDecode(Convert.ToString(Parameters.OrganizationUnit)) + ", 'C' SELECT ' Days' = @intDays";
                result = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);
                return result;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
    }
}
