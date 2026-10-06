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
    //Controller Name : PM_ProjectTimesheetDetails
    //Created By : Dipali V
    //Created Date : 26th Sep 2023
    public class PM_ProjectTimesheetDetailsController : ApiController
    {


        //Added By Dipali V On 26th Sep 2023  For Employee 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetEmployeeDetails([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {


                ProjectTimesheetDetails ProjectTimesheet = new ProjectTimesheetDetails();

                // Employee
                ProjectTimesheet.EmployeeDetails = new List<EmployeeDetails>();
                DataTable dt_Employee = CommonFunctions.Data.GetDataTable("usp_Whizible2_tbl_PM_EmployeeTimeSheetFilter " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "", true, CommonController.connectionString);
                foreach (DataRow FilterRow in dt_Employee.Rows)
                {
                    EmployeeDetails EmployeeFilter = new EmployeeDetails()
                    {
                        EmployeeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["EmployeeName"], ""))
                    };
                    ProjectTimesheet.EmployeeDetails.Add(EmployeeFilter);
                }

                return ProjectTimesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 26th Sep 2023  For Get ProjectTimesheetList
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetViewProjectTimsheet([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                DataTable result;
                string query = "";
                query = "EXEC usp_Whizible2_Sel_TimeSheetForGivenTimeSheetNo " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "";
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Added By Dipali V On 11th Oct 2023  For Save Description 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDescription([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string strSQL = "";
                string strSQL_New = "";
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_TimeSheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + ", '"
                                                                + Parameters.Description + "',"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualWork));

                object dt = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);


                //---------------------- After Re Generated New Should Insert
                string fromdate = "";
                string ToDate = "";
                int RateMethod = 0, OUWorkingDays = 0;
                string WorkHrsperday = "";
                string BufferPercentage = "";
                string SiteValidation = "";
                string InvoiceDate = "";
                int TimeSheetId = 0;
                int ProjectID = 0;
                int CapHoliday = 0;
                int IsAllValuesInSiteCurrency = 0;
                int CapConsider = 0;
                string dblMonthlyHr = "";
                string EffortToConsider = "";
                string Discount = "";
                string OnsiteFull = "";
                string ActualDayBilling = "";
                string FixedMonthlyRate = "";
                int InvoiceTimesheetID = 0;
                int ContractType = 0;
                IDataReader drTimeSheetDetails;
                strSQL = "usp_Whizible2_Sel_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.TimesheetNo + "";
                drTimeSheetDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drTimeSheetDetails.Read())
                {
                    fromdate = drTimeSheetDetails["FromDate"].ToString();
                    ToDate = drTimeSheetDetails["ToDate"].ToString();
                    RateMethod = Convert.ToInt16(drTimeSheetDetails["RateMethod"]);
                    OUWorkingDays = Convert.ToInt16(drTimeSheetDetails["OUWorkingDays"]);
                    WorkHrsperday = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["WorkHrsperday"], "0");
                    BufferPercentage = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["BufferPercentage"], "0");
                    SiteValidation = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["SiteValidation"], "");
                    InvoiceDate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["InvoiceDate"], "");
                    TimeSheetId = Convert.ToInt16(drTimeSheetDetails["TimeSheetNo"]);
                    ProjectID = Convert.ToInt16(drTimeSheetDetails["ProjectID"]);
                    EffortToConsider = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["Efforts"], "0");
                    Discount = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["DiscountPercentage"], "0");
                    ActualDayBilling = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["ActualDayBilling"], "");
                    FixedMonthlyRate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["FixedMonthlyRate"], "");
                    OnsiteFull = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["OnsiteFull"], "");
                    dblMonthlyHr = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["MonthlyHr"], "0");
                    InvoiceTimesheetID = Convert.ToInt16(drTimeSheetDetails["InvoiceTimesheetId"]);
                    ContractType = Convert.ToInt16(drTimeSheetDetails["ContractTypeID"]);
                    CapConsider = Convert.ToInt16(drTimeSheetDetails["CapConsider"]);
                    CapHoliday = Convert.ToInt16(drTimeSheetDetails["CapHoliday"]);
                    IsAllValuesInSiteCurrency = Convert.ToInt16(drTimeSheetDetails["IsAllValuesInSiteCurrency"]);

                }

                if (SiteValidation == "True")
                {
                    SiteValidation = "1";
                }
                else {
                    SiteValidation = "0";
                }
                //---------------------------------T & M By Resource Hourly----------------------------
                if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //---------------------------------T & M By Resource Daily----------------------------
                if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=0
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource  Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------T & M Role Hourly----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------T & M Role Daily----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------T & M Role Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------T & M Role Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }

                //---------------------------------------------------FixedFree
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 0)
                {
                   // strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------------------------FixedFree
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 1)
                {
                    // strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree_SiteCurrency " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Hourly----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Daily----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------Project Site Biiling Monthly FixedMonthlyRate=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------Project Site Biiling Monthly ActualDayBilling=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------- End of After Re Generated New Should Insert
                CommonFunctions.Data.InsertOrUpdateData(strSQL_New, true, CommonController.connectionString);
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
        public object GetShowHistory([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                DataTable result;
                string query = "";
                query = "EXEC usp_Whizible2_tbl_PM_AuditTrail_ProjectTimesheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "";
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        
        // Added By Dipali V On 27th Sep 2023  For Save WSR Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GenerateWSR([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible_Ins_Upd_tbl_PM_WSROtherAttributes " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + ",'"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.Highlights)) + "','"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.Issues)) + "','"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.Suggestions)) + "','"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.Slippage)) + "','"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.NextWeekActivites)) + "'";

                object dt = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
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
        public object GetWSRActivitiesDetails([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                DataTable result;
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_WSROtherAttributes " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "";
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 27th Sep 2023  For Get Show History Details
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetEasyEditTaskDetails([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                DataTable result;
                string query = "";
                query = "EXEC usp_Whizible2_sel_TimeSheetForGivenTimeSheetNo_EasyEntry " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'";
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

       
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost,Caching(true)]
        public object GetMINDAValidation([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_tbl_pm_companyinformation_MinHoursForDAEntry ";
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For send for approval
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object validateSFA([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                IDataReader drTSAuthenticatedBy;
                IDataReader drReciever;
                int count = 0;
                int intc = 0;
                var m_strAuthenticatedBy = "";
                var strApproverName = "";
                var ApproverName = "";
                drTSAuthenticatedBy = CommonFunctions.Data.GetDataReader("usp_Sel_TimeSheetAuthenticationType " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)), true, CommonController.connectionString);
                if (drTSAuthenticatedBy.Read())
                {
                    m_strAuthenticatedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drTSAuthenticatedBy["AuthenticatedBy"], "I"));
                    if (drTSAuthenticatedBy["AuthenticatedBy"].ToString() == "C")
                    {
                        drReciever = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_CustomerEmailIDForTimeSheet " + Parameters.ProjectID.ToString(), true);



                        while (drReciever.Read())
                        {
                            if (count == 0)
                            {
                                ApproverName = ApproverName + drReciever["EmployeeName"].ToString();
                            }
                            else
                            {
                                if (count == 0)
                                {
                                    ApproverName = ApproverName + ";" + drReciever["EmployeeName"].ToString() + ";";
                                }
                                else
                                {
                                    ApproverName = ApproverName + drReciever["EmployeeName"].ToString() + ";";
                                }
                                intc = intc + 1;
                            }
                            count = count + 1;
                        }
                        //Added By Dipali V On 25th Oct 2023 For Remove Space
                        //strApproverName = "   Customer : " + ApproverName;
                        strApproverName = " Customer : " + ApproverName;
                        //Added By Dipali V On 25th Oct 2023 For Remove Space
                    }
                    else
                    {
                        drTSAuthenticatedBy = CommonFunctions.Data.GetDataReader("usp_Sel_InternalAuthenticatorForTimeSheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)), true, CommonController.connectionString);
                        while (drTSAuthenticatedBy.Read())
                        {
                            if (count == 0)
                            {
                                ApproverName = ApproverName + ";" + drTSAuthenticatedBy["EmployeeName"].ToString() + ";";
                            }
                            else
                            {
                                ApproverName = ApproverName + drTSAuthenticatedBy["EmployeeName"].ToString() + ";";
                            }
                        }
                        //Added By Dipali V On 25th Oct 2023 For Remove Space
                       // strApproverName = "   Customer : " + ApproverName;
                        strApproverName = " Customer : " + ApproverName;
                        //End of Added By Dipali V On 25th Oct 2023 For Remove Space
                    }
                }

                return m_strAuthenticatedBy + "&&" + strApproverName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For send for approval
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SendForApproval([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string result;
                IDataReader drRT;
                string query = "";
                query = "EXEC usp_del_tbl_PM_SiteResourceTimesheet_TimeSheetID " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo));
                CommonFunctions.Data.InsertOrUpdateData(query, true, CommonController.connectionString);

                string strSQLTM = "";
                strSQLTM = "EXEC usp_sel_tbl_PM_SiteResourceTimesheet_TimeSheetID " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo));
                drRT = CommonFunctions.Data.GetDataReader(strSQLTM, true, CommonController.connectionString);
                if (!drRT.Read())
                {
                    strSQLTM = "Exec usp_Sel_GetSiteResourceTimesheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo));
                    drRT = CommonFunctions.Data.GetDataReader(strSQLTM, true, CommonController.connectionString);
                    while (drRT.Read())
                    {
                        strSQLTM = "usp_Ins_tbl_PM_SiteResourceTimesheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "," + CommonFunctions.Data.CheckIsDBNull(drRT["SiteID"]) + ",'" + CommonFunctions.Data.CheckIsDBNull(drRT["Name"]) + "'," + CommonFunctions.Data.CheckIsDBNull(drRT["EmployeeID"]) + ",'" + CommonFunctions.Data.CheckIsDBNull(drRT["EmployeeName"]) + "','" + CommonFunctions.Data.CheckIsDBNull(drRT["Date"]) + "'," + CommonFunctions.Data.CheckIsDBNull(drRT["NormalHours"]) + "," + CommonFunctions.Data.CheckIsDBNull(drRT["ExtraHours"]) + "," + CommonFunctions.Data.CheckIsDBNull(drRT["NonBillableHours"]);
                        CommonFunctions.Data.InsertOrUpdateData(strSQLTM, true, CommonController.connectionString);
                    }
                    CommonFunctions.Data.DisposeDataReader(ref drRT);
                }
                CommonFunctions.Data.DisposeDataReader(ref drRT);


                strSQLTM = "Exec usp_Sel_AccruedGetSiteResourceTimesheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo));
                CommonFunctions.Data.InsertOrUpdateData(strSQLTM, true, CommonController.connectionString);
                string strEmployeeName = "";
                strEmployeeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("EXEC usp_sel_tbl_PM_Employee_EmployeeName " + Parameters.UserID.ToString(), true, CommonController.connectionString));
                //Commented & Added By Dipali V On 30th Oct 2023 For Change Exiting SP To New SP for history issue
                //string strUpdateQuery = "usp_upd_tbl_PM_TimeSheetInvoice_ForReadyToAuthenticate " + Parameters.TimesheetNo + ",'" + strEmployeeName + "'";
                string strUpdateQuery = "usp_Whizible2_upd_tbl_PM_TimeSheetInvoice_ForReadyToAuthenticate " + Parameters.TimesheetNo + ",'" + strEmployeeName + "'";
                //End of Commented & Added By Dipali V On 30th Oct 2023 For Change Exiting SP To New SP  for history issue
                CommonFunctions.Data.InsertOrUpdateData(strUpdateQuery, true, CommonController.connectionString);
                string ststrDescription = "";
                string intDuration = "0";
                string blnShowPopup = "False";
                string blnSendEmail = "False";
                IDataReader drEmailMessage;

                drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 3", true, CommonController.connectionString);
                if (drEmailMessage.Read())
                {
                    blnSendEmail = drEmailMessage["SendMail"].ToString();
                    blnShowPopup = drEmailMessage["ShowPopup"].ToString();
                }

                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "";

                string strMessage = "";
                string TimsheetStatus = "";

                IDataReader drTimeSheet;
                string strSQL = "EXEC usp_Whizible2_Sel_TimeSheetForGivenTimeSheetNo " + Parameters.TimesheetNo;
                drTimeSheet = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                if (drTimeSheet.Read())
                {

                    TimsheetStatus = drTimeSheet["TimsheetStatus"].ToString();
                    if (blnSendEmail == "True" && blnShowPopup == "False")
                    {
                        EmailMessagesController.GetEmailMessage_3(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, Parameters.TimesheetNo, Parameters.ProjectID, Parameters.UserID);
                        EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                    }
                }
                return blnShowPopup + "&&" + TimsheetStatus;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For send for approval
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetTimesheetDurationDetails([FromBody] ProjectTimesheetDetails Parameters)
        {
            IDataReader drEditTimeSheet;
            string strDescription = "", strEntryDateName = "", strEmployeeName = "";
            int intDuration = 0, intTaskDuration = 0;
            double intSumDurationOld = 0;
            try
            {
                string strSQL = "EXEC usp_Sel_tbl_PM_TimeSheet " + Parameters.TimesheetID;
                drEditTimeSheet = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drEditTimeSheet.Read())
                {
                    strDescription = drEditTimeSheet["Description"].ToString();
                    intDuration = Convert.ToInt32(drEditTimeSheet["Duration"]);
                    intTaskDuration = Convert.ToInt32(drEditTimeSheet["Duration"]);
                }

                string SQL;
                string strSQL_Duration = "EXEC usp_Whizible2_sel_tbl_PM_Timesheet_DurationCheck " + Parameters.TimesheetID + "," + Parameters.TimesheetNo + "";
                drEditTimeSheet = CommonFunctions.Data.GetDataReader(strSQL_Duration, true, CommonController.connectionString);
                if (drEditTimeSheet.Read())
                {
                    intSumDurationOld = Convert.ToDouble(drEditTimeSheet["Duration"]);
                    strEntryDateName = Convert.ToString(drEditTimeSheet["EntryDate"]);
                    strEmployeeName = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + drEditTimeSheet["EmployeeID"], true, CommonController.connectionString));
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

            return intSumDurationOld + "&&&&" + intTaskDuration.ToString() + "&&&&" + strEmployeeName.ToString() + "&&&&" + strEntryDateName.ToString();
        }

        //Added By Dipali V For For Re-Generate PT
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object RegenrateTimesheet([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {


                int TimesheetNo = 0;
                string strSQL = "";
                IDataReader drTimesheet;
                //---------------------- After Re Generated New Should Insert
                string fromdate = "";
                string ToDate = "";
                string strSQL_New = "";
                int RateMethod = 0, OUWorkingDays = 0;
                string WorkHrsperday = "";
                string BufferPercentage = "";
                string SiteValidation = "";
                string InvoiceDate = "";
                int TimeSheetId = 0;
                string intTimeSheetNo = "0";
                int ProjectID = 0;
                int CapHoliday = 0;
                int IsAllValuesInSiteCurrency = 0;
                int CapConsider = 0;
                int TimesheetInvoiceID = 0;
                string dblMonthlyHr = "";
                string EffortToConsider = "";
                string Discount = "";
                string OnsiteFull = "";
                string ActualDayBilling = "";
                string FixedMonthlyRate = "";
                string stremployeename = "";
                int InvoiceTimesheetID = 0;
                int ContractType = 0;
                int ProjectCurrency = 0;
                IDataReader drTimeSheetDetails;


                strSQL = "usp_Whizible2_Sel_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.TimesheetNo + "";
                drTimeSheetDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drTimeSheetDetails.Read())
                {
                    fromdate = drTimeSheetDetails["FromDate"].ToString();
                    ToDate = drTimeSheetDetails["ToDate"].ToString();
                    RateMethod = Convert.ToInt16(drTimeSheetDetails["RateMethod"]);
                    OUWorkingDays = Convert.ToInt16(drTimeSheetDetails["OUWorkingDays"]);
                    WorkHrsperday = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["WorkHrsperday"], "0");
                    BufferPercentage = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["BufferPercentage"], "0");
                    SiteValidation = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["SiteValidation"], "");
                    InvoiceDate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["InvoiceDate"], "");
                    TimeSheetId = Convert.ToInt16(drTimeSheetDetails["TimeSheetNo"]);
                    ProjectID = Convert.ToInt16(drTimeSheetDetails["ProjectID"]);
                    EffortToConsider = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["Efforts"], "0");
                    Discount = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["DiscountPercentage"], "0");
                    ActualDayBilling = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["ActualDayBilling"], "");
                    FixedMonthlyRate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["FixedMonthlyRate"], "");
                    OnsiteFull = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["OnsiteFull"], "");
                    dblMonthlyHr = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["MonthlyHr"], "0");
                    InvoiceTimesheetID = Convert.ToInt16(drTimeSheetDetails["InvoiceTimesheetId"]);
                    ContractType = Convert.ToInt16(drTimeSheetDetails["ContractTypeID"]);
                    CapConsider = Convert.ToInt16(drTimeSheetDetails["CapConsider"]);
                    ProjectCurrency = Convert.ToInt16(drTimeSheetDetails["CurrencyID"]);
                    CapHoliday = Convert.ToInt16(drTimeSheetDetails["CapHoliday"]);
                    CapHoliday = Convert.ToInt16(drTimeSheetDetails["CapHoliday"]);
                    IsAllValuesInSiteCurrency = Convert.ToInt16(drTimeSheetDetails["IsAllValuesInSiteCurrency"]);
                }

                if (SiteValidation == "True")
                {
                    SiteValidation = "1";
                }
                else
                {
                    SiteValidation = "0";
                }
                IDataReader drTImeSheet;
                stremployeename = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Employee_EmployeeName " + Parameters.UserID, true, CommonController.connectionString));
                //--------------------------------- Create New TS when Regenrate TS
                strSQL = "usp_Whizible2_GenerateTimeSheet '" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + ProjectID + ", 0,'" + stremployeename + "'," + RateMethod + "";
                drTImeSheet = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drTImeSheet.Read())
                {
                    intTimeSheetNo = Convert.ToString(drTImeSheet["TimeSheetNo"]);
                }

                //--------------------------------- Create New TS new table when Regenrate TS
                strSQL = "usp_Ins_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + ContractType + ",'" + Parameters.FromDate + "','" + Parameters.ToDate + "'," + OUWorkingDays + ",'" + WorkHrsperday + "'," + BufferPercentage + ",'" + dblMonthlyHr + "'," + Discount + ",'" + ActualDayBilling + "'," + EffortToConsider + "," + ProjectCurrency + ",'" + FixedMonthlyRate + "'," + OnsiteFull + "," + RateMethod;

                if (Parameters.InvoiceDate == "NULL")
                {
                    strSQL += ",NULL," + intTimeSheetNo.ToString();
                }
                else
                {
                    strSQL += ",'" + InvoiceDate + "'," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + "";
                }

                TimesheetInvoiceID = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                /////////////////////////////////////////////////////////////////////////////////
                //Purpose : To Reset the flag for freeze when TimeSheet is regenerated.
                strSQL = "Usp_Upd_tbl_PM_Timesheet_IsFreezed " + intTimeSheetNo.ToString() + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",0";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                strSQL = "";
                //Remove the entries from the intermediate table for site calendar
                strSQL = "usp_del_tbl_PM_SiteCal_Intermediate_TimeSheetNo " + intTimeSheetNo.ToString();
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);


                strSQL = "";
                String strEmployeeName = "";
                strSQL = "EXEC usp_sel_tbl_PM_Employee_EmployeeName " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID));
                strEmployeeName = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //Commented By Dipali V On 1st Nov 2o23 For Regenerate Logic change
                strSQL = "";
                //strSQL = "usp_ReGenerateTimeSheet '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + ",'" + strEmployeeName + "'";
                strSQL = "usp_Whizible2_ReGenerateTimeSheet '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.FromDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ToDate)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + intTimeSheetNo.ToString() + ",'" + strEmployeeName + "'";
                drTimesheet = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drTimesheet.Read())
                {
                    TimesheetNo = Convert.ToInt32(drTimesheet["TimeSheetNo"]);

                }
                //--------------------------------- End of Create New TS when Regenrate TS
                //---------------------------------Hourly----------------------------
                if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //Daily 
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "2")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=0
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //T & M Resource  Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //---------------------------------T & M Role Hourly----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //---------------------------------T & M Role Daily----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //----------------------------------T & M Role Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //----------------------------------T & M Role Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //---------------------------------------------------FixedFree
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 0)
                {
                    //For Fixed Free it will take actual day billing = 'Yes'
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 1)
                {
                    //For Fixed Free it will take actual day billing = 'Yes'
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree_SiteCurrency " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + intTimeSheetNo.ToString() + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //---------------------------------Project Site Biiling Hourly----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //---------------------------------Project Site Biiling Daily----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";
                }
                //----------------------------------Project Site Biiling Monthly FixedMonthlyRate=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //----------------------------------Project Site Biiling Monthly ActualDayBilling=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + intTimeSheetNo.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + TimesheetInvoiceID + "";

                }
                //---------------------- End of After Re Generated New Should Insert
                CommonFunctions.Data.InsertOrUpdateData(strSQL_New, true, CommonController.connectionString);



                //Delete  Earlier TS 
                strSQL = "usp_Whizible2_Del_tbl_PM_TimeSheet_AfterRegenerate " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return TimesheetNo;
                //End of Commented By Dipali V On 1st Nov 2o23 For Regenerate Logic change

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }


        // Added By Dipali V On 11th Oct 2023  For Save Description 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SaveBillingInformation([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {

                //---------------------- After Re Generated New Should Insert
                string fromdate = "";
                string ToDate = "";
                string strSQL = "", strSQL_New = "";
                int RateMethod = 0, OUWorkingDays = 0;
                string WorkHrsperday = "";
                string BufferPercentage = "";
                string SiteValidation = "";
                string InvoiceDate = "";
                int TimeSheetId = 0;
                int ProjectID = 0;
                int CapHoliday = 0;
                int IsAllValuesInSiteCurrency = 0;
                int CapConsider = 0;
                string dblMonthlyHr = "";
                string EffortToConsider = "";
                string Discount = "";
                string OnsiteFull = "";
                string ActualDayBilling = "";
                string FixedMonthlyRate = "";
                int InvoiceTimesheetID = 0;
                int ContractType = 0;
                IDataReader drTimeSheetDetails;
                strSQL = "usp_Whizible2_Sel_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.TimesheetNo + "";
                drTimeSheetDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drTimeSheetDetails.Read())
                {
                    fromdate = drTimeSheetDetails["FromDate"].ToString();
                    ToDate = drTimeSheetDetails["ToDate"].ToString();
                    RateMethod = Convert.ToInt16(drTimeSheetDetails["RateMethod"]);
                    OUWorkingDays = Convert.ToInt16(drTimeSheetDetails["OUWorkingDays"]);
                    WorkHrsperday = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["WorkHrsperday"], "0");
                    BufferPercentage = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["BufferPercentage"], "0");
                    SiteValidation = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["SiteValidation"], "");
                    InvoiceDate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["InvoiceDate"], "");
                    TimeSheetId = Convert.ToInt16(drTimeSheetDetails["TimeSheetNo"]);
                    ProjectID = Convert.ToInt16(drTimeSheetDetails["ProjectID"]);
                    EffortToConsider = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["Efforts"], "0");
                    Discount = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["DiscountPercentage"], "0");
                    ActualDayBilling = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["ActualDayBilling"], "");
                    FixedMonthlyRate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["FixedMonthlyRate"], "");
                    OnsiteFull = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["OnsiteFull"], "");
                    dblMonthlyHr = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["MonthlyHr"], "0");
                    InvoiceTimesheetID = Convert.ToInt16(drTimeSheetDetails["InvoiceTimesheetId"]);
                    ContractType = Convert.ToInt16(drTimeSheetDetails["ContractTypeID"]);
                    CapConsider = Convert.ToInt16(drTimeSheetDetails["CapConsider"]);
                    CapHoliday = Convert.ToInt16(drTimeSheetDetails["CapHoliday"]);
                    IsAllValuesInSiteCurrency = Convert.ToInt16(drTimeSheetDetails["IsAllValuesInSiteCurrency"]);
                }

                if (SiteValidation == "True")
                {
                    SiteValidation = "1";
                }
                else
                {
                    SiteValidation = "0";
                }

                if (ActualDayBilling == "True")
                {
                    ActualDayBilling = "1";
                }
                else
                {
                    ActualDayBilling = "0";
                }

                if (FixedMonthlyRate == "True")
                {
                    FixedMonthlyRate = "1";
                }
                else
                {
                    FixedMonthlyRate = "0";
                }
                //---------------------------------Hourly T & M By Resource----------------------------
                if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //---------------------------------Daily T & M By Resource ----------------------------
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=0
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource  Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------T & M Role Hourly----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------T & M Role Daily----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------T & M Role Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------T & M Role Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------------------------FixedFree
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 0)
                {
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 1)
                {
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree_SiteCurrency " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Hourly----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Daily----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------Project Site Biiling Monthly FixedMonthlyRate=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------Project Site Biiling Monthly ActualDayBilling=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------- End of After Re Generated New Should Insert
                CommonFunctions.Data.InsertOrUpdateData(strSQL_New, true, CommonController.connectionString);
                return 1;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        // Added By Dipali V On 11th Oct 2023  For Save Description 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveEasyEdit([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string strSQL = "";
                string strSQL_New = "";
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_TimeSheet_EasyEdit " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetID)) + ", '"
                                                                + HttpUtility.UrlDecode(Parameters.Description) + "','"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualWork)) + "',"
                                                                + HttpUtility.UrlDecode(Convert.ToString(Parameters.WSRCheckedCheckbox));

               

                //if (Convert.ToString(Parameters.WSRCheckedCheckbox) == "1") {
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    //---------------------- After Re Generated New Should Insert
                    string fromdate = "";
                    string ToDate = "";
                    int RateMethod = 0, OUWorkingDays = 0;
                    string WorkHrsperday = "";
                    string BufferPercentage = "";
                    string SiteValidation = "";
                    string InvoiceDate = "";
                    int TimeSheetId = 0;
                    int ProjectID = 0;
                    int CapHoliday = 0;
                    int IsAllValuesInSiteCurrency = 0;
                    int CapConsider = 0;
                    string dblMonthlyHr = "";
                    string EffortToConsider = "";
                    string Discount = "";
                    string OnsiteFull = "";
                    string ActualDayBilling = "";
                    string FixedMonthlyRate = "";
                    int InvoiceTimesheetID = 0;
                    int ContractType = 0;
                    IDataReader drTimeSheetDetails;
                    strSQL = "usp_Whizible2_Sel_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.TimesheetNo + "";
                    drTimeSheetDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                    if (drTimeSheetDetails.Read())
                    {
                        fromdate = drTimeSheetDetails["FromDate"].ToString();
                        ToDate = drTimeSheetDetails["ToDate"].ToString();
                        RateMethod = Convert.ToInt16(drTimeSheetDetails["RateMethod"]);
                        OUWorkingDays = Convert.ToInt16(drTimeSheetDetails["OUWorkingDays"]);
                        WorkHrsperday = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["WorkHrsperday"], "0");
                        BufferPercentage = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["BufferPercentage"], "0");
                        SiteValidation = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["SiteValidation"], "");
                        InvoiceDate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["InvoiceDate"], "");
                        TimeSheetId = Convert.ToInt16(drTimeSheetDetails["TimeSheetNo"]);
                        ProjectID = Convert.ToInt16(drTimeSheetDetails["ProjectID"]);
                        EffortToConsider = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["Efforts"], "0");
                        Discount = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["DiscountPercentage"], "0");
                        ActualDayBilling = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["ActualDayBilling"], "");
                        FixedMonthlyRate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["FixedMonthlyRate"], "");
                        OnsiteFull = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["OnsiteFull"], "");
                        dblMonthlyHr = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["MonthlyHr"], "0");
                        InvoiceTimesheetID = Convert.ToInt16(drTimeSheetDetails["InvoiceTimesheetId"]);
                        ContractType = Convert.ToInt16(drTimeSheetDetails["ContractTypeID"]);
                        CapConsider = Convert.ToInt16(drTimeSheetDetails["CapConsider"]);
                        CapHoliday = Convert.ToInt16(drTimeSheetDetails["CapHoliday"]);
                    IsAllValuesInSiteCurrency = Convert.ToInt16(drTimeSheetDetails["IsAllValuesInSiteCurrency"]);
                }

                    if (SiteValidation == "True")
                    {
                        SiteValidation = "1";
                    }
                    else
                    {
                        SiteValidation = "0";
                    }
                //---------------------------------Hourly----------------------------
                if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //---------------------------------Daily----------------------------
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=0
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource  Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------T & M Role Hourly----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------T & M Role Daily----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------T & M Role Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------T & M Role Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------------------------FixedFree
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 0)
                {
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 1)
                {
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree_SiteCurrency " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Hourly----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Daily----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------Project Site Biiling Monthly FixedMonthlyRate=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------Project Site Biiling Monthly ActualDayBilling=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------- End of After Re Generated New Should Insert
                CommonFunctions.Data.InsertOrUpdateData(strSQL_New, true, CommonController.connectionString);
                   

                //}
                return "1";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

            
        }

    

        //Added By Dipali V For For Re-Generate PT
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetTimesheetGenerateCount([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                DataTable result;

                string StrSQL = "";
                StrSQL = "EXEC usp_Whizible2_sel_tbl_PM_TimeSheet_TimesheetID " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo));
                result = CommonFunctions.Data.GetDataTable(StrSQL, true, CommonController.connectionString);
                return result;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For Update WSR
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object UpdateWSR([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                int result;

                string StrSQL = "";
                if (HttpUtility.UrlDecode(Convert.ToString(Parameters.WSRCheckedCheckbox)) != "")
                {
                    StrSQL = "EXEC usp_Whizible2_tbl_PM_TimeSheet_UpdateWSR " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.WSRCheckedCheckbox)) + "'";
                }
                else
                {
                    StrSQL = "usp_upd_tbl_PM_TimeSheetInvoice_WeeklyStatusEntry " + Parameters.TimesheetNo;

                }
                CommonFunctions.Data.InsertOrUpdateData(StrSQL, true, CommonController.connectionString);
                return 1;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Added By Dipali V For For Easy Edit Filter
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRoleEmployeeNameFilter([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                ProjectTimesheetDetails ProjectTimesheet = new ProjectTimesheetDetails();

                // Employee
                ProjectTimesheet.EmployeeDetails = new List<EmployeeDetails>();
                DataTable dt_Employee = CommonFunctions.Data.GetDataTable("usp_Sel_TimeSheetForGivenTimeSheetNo_EasyEntry_PageFilter " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + ",1,NULL", true, CommonController.connectionString);
                foreach (DataRow FilterRow in dt_Employee.Rows)
                {
                    EmployeeDetails EmployeeFilter = new EmployeeDetails()
                    {
                        EmployeeID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["EmployeeName"], ""))
                    };
                    ProjectTimesheet.EmployeeDetails.Add(EmployeeFilter);
                }


                // Role
                ProjectTimesheet.RoleList = new List<RoleList>();
                DataTable dt_Role = CommonFunctions.Data.GetDataTable("usp_Sel_TimeSheetForGivenTimeSheetNo_EasyEntry_PageFilter " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + ",2,NULL", true, CommonController.connectionString);
                foreach (DataRow FilterRow in dt_Role.Rows)
                {
                    RoleList RoleFilter = new RoleList()
                    {
                        RoleID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["RoleID"], "0")),
                        RoleDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(FilterRow["RoleDescription"], ""))
                    };
                    ProjectTimesheet.RoleList.Add(RoleFilter);
                }

                return ProjectTimesheet;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For Re-Generate PT
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectTimesheetTask([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string StrSQL = "";
                string strSQL_New = "";
                StrSQL = "EXEC USP_Whizible2_Del_tbl_PM_TimeSheet_ForTimeSheetID '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimsheetIDs)) + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(StrSQL, true, CommonController.connectionString);


                //---------------------- After Re Generated New Should Insert
                string fromdate = "";
                string ToDate = "";
                int RateMethod = 0, OUWorkingDays = 0;
                string WorkHrsperday = "";
                string BufferPercentage = "";
                string SiteValidation = "";
                string InvoiceDate = "";
                int TimeSheetId = 0;
                int ProjectID = 0;
                int CapHoliday = 0;
                int CapConsider = 0;
                string dblMonthlyHr = "";
                string EffortToConsider = "";
                string Discount = "";
                string OnsiteFull = "";
                string ActualDayBilling = "";
                string FixedMonthlyRate = "";
                int InvoiceTimesheetID = 0;
                int ContractType = 0;
                int IsAllValuesInSiteCurrency = 0;
                IDataReader drTimeSheetDetails;
                StrSQL = "usp_Whizible2_Sel_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.TimesheetNo + "";
                drTimeSheetDetails = CommonFunctions.Data.GetDataReader(StrSQL, true, CommonController.connectionString);
                if (drTimeSheetDetails.Read())
                {
                    fromdate = drTimeSheetDetails["FromDate"].ToString();
                    ToDate = drTimeSheetDetails["ToDate"].ToString();
                    RateMethod = Convert.ToInt16(drTimeSheetDetails["RateMethod"]);
                    OUWorkingDays = Convert.ToInt16(drTimeSheetDetails["OUWorkingDays"]);
                    WorkHrsperday = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["WorkHrsperday"], "0");
                    BufferPercentage = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["BufferPercentage"], "0");
                    SiteValidation = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["SiteValidation"], "");
                    InvoiceDate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["InvoiceDate"], "");
                    TimeSheetId = Convert.ToInt16(drTimeSheetDetails["TimeSheetNo"]);
                    ProjectID = Convert.ToInt16(drTimeSheetDetails["ProjectID"]);
                    EffortToConsider = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["Efforts"], "0");
                    Discount = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["DiscountPercentage"], "0");
                    ActualDayBilling = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["ActualDayBilling"], "");
                    FixedMonthlyRate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["FixedMonthlyRate"], "");
                    OnsiteFull = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["OnsiteFull"], "");
                    dblMonthlyHr = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["MonthlyHr"], "0");
                    InvoiceTimesheetID = Convert.ToInt16(drTimeSheetDetails["InvoiceTimesheetId"]);
                    ContractType = Convert.ToInt16(drTimeSheetDetails["ContractTypeID"]);
                    CapConsider = Convert.ToInt16(drTimeSheetDetails["CapConsider"]);
                    CapHoliday = Convert.ToInt16(drTimeSheetDetails["CapHoliday"]);
                    IsAllValuesInSiteCurrency = Convert.ToInt16(drTimeSheetDetails["IsAllValuesInSiteCurrency"]);
                    
                }

                if (SiteValidation == "True")
                {
                    SiteValidation = "1";
                }
                else
                {
                    SiteValidation = "0";
                }
                //---------------------------------Hourly----------------------------
                if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //---------------------------------Daily----------------------------
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=0
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource  Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------T & M Role Hourly----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------T & M Role Daily----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------T & M Role Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------T & M Role Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------------------------FixedFree
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 0)
                {
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 1)
                {
                    //strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree_SiteCurrency " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }

                //---------------------------------Project Site Biiling Hourly----------------------------
                else if (Convert.ToString(ContractType) == "4"  && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Daily----------------------------
                else if (Convert.ToString(ContractType) == "4"  && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if (Convert.ToString(ContractType) == "4"  && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if (Convert.ToString(ContractType) == "4"  && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------Project Site Biiling Monthly FixedMonthlyRate=1
                else if (Convert.ToString(ContractType) == "4"  && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------Project Site Biiling Monthly ActualDayBilling=1
                else if (Convert.ToString(ContractType) == "4"  && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }

                //---------------------- End of After Re Generated New Should Insert
                CommonFunctions.Data.InsertOrUpdateData(strSQL_New, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V For For Re-Generate PT
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetResourceDuration([FromBody] ProjectTimesheetDetails Parameters)
        {
            try
            {
                string result;

                string StrSQL = "";
                StrSQL = "EXEC usp_Whizible2_GetResourceDurationWithRespectiveTimesheet " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo))+ "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualWork)) + "'";
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(StrSQL, true, CommonController.connectionString));
                return result;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added By Dipali V For For Re-Generate PT
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ApplyDurationResource([FromBody] ProjectTimesheetDetails Parameters)
        {
            string result;
            string StrSQL = "";
            string strSQL_New = "";
            try
            {
               
                StrSQL = "EXEC usp_Whizible2_UPD_tbl_PM_TimeSheet_SmartEdit " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TimesheetNo)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ActualWork)) + "'";
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(StrSQL, true, CommonController.connectionString));
                //---------------------- After Re Generated New Should Insert
                string fromdate = "";
                string ToDate = "";
                int RateMethod = 0, OUWorkingDays = 0;
                string WorkHrsperday = "";
                string BufferPercentage = "";
                string SiteValidation = "";
                string InvoiceDate = "";
                int TimeSheetId = 0;
                int ProjectID = 0;
                int IsAllValuesInSiteCurrency = 0;
                int CapHoliday = 0;
                int CapConsider = 0;
                string dblMonthlyHr = "";
                string EffortToConsider = "";
                string Discount = "";
                string OnsiteFull = "";
                string ActualDayBilling = "";
                string FixedMonthlyRate = "";
                int InvoiceTimesheetID = 0;
                int ContractType = 0;
                IDataReader drTimeSheetDetails;
                StrSQL = "usp_Whizible2_Sel_Tbl_whizible2_Generated_ProjectTimeSheet " + Parameters.ProjectID + "," + Parameters.TimesheetNo + "";
                drTimeSheetDetails = CommonFunctions.Data.GetDataReader(StrSQL, true, CommonController.connectionString);
                if (drTimeSheetDetails.Read())
                {
                    fromdate = drTimeSheetDetails["FromDate"].ToString();
                    ToDate = drTimeSheetDetails["ToDate"].ToString();
                    RateMethod = Convert.ToInt16(drTimeSheetDetails["RateMethod"]);
                    OUWorkingDays = Convert.ToInt16(drTimeSheetDetails["OUWorkingDays"]);
                    WorkHrsperday = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["WorkHrsperday"], "0");
                    BufferPercentage = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["BufferPercentage"], "0");
                    SiteValidation = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["SiteValidation"], "");
                    InvoiceDate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["InvoiceDate"], "");
                    TimeSheetId = Convert.ToInt16(drTimeSheetDetails["TimeSheetNo"]);
                    ProjectID = Convert.ToInt16(drTimeSheetDetails["ProjectID"]);
                    EffortToConsider = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["Efforts"], "0");
                    Discount = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["DiscountPercentage"], "0");
                    ActualDayBilling = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["ActualDayBilling"], "");
                    FixedMonthlyRate = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["FixedMonthlyRate"], "");
                    OnsiteFull = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["OnsiteFull"], "");
                    dblMonthlyHr = CommonFunctions.General.CheckIsNothing(drTimeSheetDetails["MonthlyHr"], "0");
                    InvoiceTimesheetID = Convert.ToInt16(drTimeSheetDetails["InvoiceTimesheetId"]);
                    ContractType = Convert.ToInt16(drTimeSheetDetails["ContractTypeID"]);
                    CapConsider = Convert.ToInt16(drTimeSheetDetails["CapConsider"]);
                    CapHoliday = Convert.ToInt16(drTimeSheetDetails["CapHoliday"]);
                    IsAllValuesInSiteCurrency = Convert.ToInt16(drTimeSheetDetails["IsAllValuesInSiteCurrency"]);
                    
                }

                if (SiteValidation == "True")
                {
                    SiteValidation = "1";
                }
                else
                {
                    SiteValidation = "0";
                }
                //---------------------------------T & M Resource Hourly----------------------------
                if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //---------------------------------T & M Resource Daily----------------------------
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //---------------------------------T & M Resource Montly----------------------------
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1 & OnSiteFull=0
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //T & M Resource  Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "2" || Convert.ToString(ContractType) == "6" || Convert.ToString(ContractType) == "1") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_Resource " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------T & M Role Hourly----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //---------------------------------T & M Role Daily----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //--------------------------------- T & M Role Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID.ToString() + "";
                }
                //----------------------------------T & M Role Monthly FixedMonthlyRate=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------T & M Role Monthly ActualDayBilling=1
                else if ((Convert.ToString(ContractType) == "3" || Convert.ToString(ContractType) == "7") && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_TM_ByRole " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------------------------------------FixedFree
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 0)
                {
                     // strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                      strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                else if (Convert.ToString(ContractType) == "5" && IsAllValuesInSiteCurrency == 1)
                {
                    // strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'NULL','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_FixedFree_SiteCurrency " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",Null,NULL,'" + dblMonthlyHr.ToString() + "',NULL," + Discount + ",'Yes','NULL',NULL," + TimeSheetId + ",1," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Hourly----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Hourly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //---------------------------------Project Site Biiling Daily----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "2")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Daily_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=1----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "1")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //--------------------------------- Project Site Biiling Monthly FixedMonthlyRate=1 & OnSiteFull=0----------------------------
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes" && Convert.ToString(OnsiteFull) == "0")
                {

                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_OnSiteAtual_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";
                }
                //----------------------------------Project Site Biiling Monthly FixedMonthlyRate=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(FixedMonthlyRate) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_FixedMonthlyRate_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //----------------------------------Project Site Biiling Monthly ActualDayBilling=1
                else if (Convert.ToString(ContractType) == "4" && Convert.ToString(RateMethod) == "3" && Convert.ToString(ActualDayBilling) == "Yes")
                {
                    strSQL_New = "USP_Ins_ProjectTnM_BillingInfo_RateMethod_Monthly_SiteBilling " + ProjectID + ",'" + fromdate + "','" + ToDate + "'," + RateMethod + "," + OUWorkingDays + ",'" + WorkHrsperday.ToString() + "'," + BufferPercentage + ",'" + dblMonthlyHr.ToString() + "'," + EffortToConsider + "," + Discount + ",'" + ActualDayBilling + "','" + FixedMonthlyRate + "'," + OnsiteFull + "," + TimeSheetId.ToString() + "," + SiteValidation.ToString() + "," + CapConsider.ToString() + "," + CapHoliday.ToString() + ",'" + InvoiceDate + "'," + InvoiceTimesheetID + "";

                }
                //---------------------- End of After Re Generated New Should Insert
                CommonFunctions.Data.InsertOrUpdateData(strSQL_New, true, CommonController.connectionString);

                return "1";

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

    }
}
