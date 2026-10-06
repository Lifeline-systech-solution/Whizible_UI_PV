using System;
using System;
using System.Collections.Generic;
using System.Data;
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
    public class RR_TimeSheetStorageController : ApiController
    {
 
        ////Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetByTimeSheetStorage([FromBody] RR_TimesSheetStorageFilter filterParameter)
        {
            try
            {
                List<RR_TimesSheetStorage> listStorage = new List<RR_TimesSheetStorage>();
                List<RR_TimesSheetStorageList> listStorageList = new List<RR_TimesSheetStorageList>();
                string filterParms = "";

                string strSQL = "";
                if (filterParameter.LocationID >0)
                {
                    strSQL = "Exec usp_Whizible2_rpt_TimesheetSummaryReport '" + filterParameter.LocationID + "','" + filterParameter.StartDate + "','" + filterParameter.EndDate + "',"+ filterParameter.intUserID;
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_rpt_TimesheetSummaryReport NULL,'" + filterParameter.StartDate + "','" + filterParameter.EndDate + "'," + filterParameter.intUserID;
                }
                DataTable RRTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (RRTable != null)
                {
                    listStorage = RRTable.ToList<RR_TimesSheetStorage>();
                }
                var resWisedata = listStorage.GroupBy(x => x.OrganizationUnit).Select(g => new RR_TimesSheetStorage { OrganizationUnit = g.FirstOrDefault().OrganizationUnit }).ToList();
                    foreach (var item in resWisedata)
                    {
                        RR_TimesSheetStorageList obj = new RR_TimesSheetStorageList();
                        obj.lstTSReport = new List<RR_TimesSheetStorage>();
                        // RR_ResourceList objOUBG = new RR_ResourceList();
                        var objOUBG = listStorage.Where(x => x.OrganizationUnit == item.OrganizationUnit).ToList();
                        obj.OrganizationUnit = item.OrganizationUnit;
                        obj.lstTSReport.AddRange(objOUBG);
                        listStorageList.Add(obj);
                    }
                return Request.CreateResponse(HttpStatusCode.OK, listStorageList);
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
        public object ExportDocument([FromBody]RR_TimesSheetStorageFilter filterParameter)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = filterParameter.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                if (filterParameter.StartDate == null || filterParameter.StartDate == "")
                {
                    filterParameter.StartDate = "NULL";
                    filterParameter.EndDate = "NULL";
                }
                if (filterParameter.LocationID > 0)
                {
                    strSQL = "Exec usp_Whizible2_rpt_TimesheetSummaryReport " + filterParameter.LocationID + ",'" + filterParameter.StartDate + "','" + filterParameter.EndDate + "'," + filterParameter.intUserID;
                }
                else
                {
                    if (filterParameter.StartDate != "NULL" || filterParameter.EndDate != "NULL")
                    {
                        strSQL = "Exec usp_Whizible2_rpt_TimesheetSummaryReport NULL,'" + filterParameter.StartDate + "','" + filterParameter.EndDate + "'," + filterParameter.intUserID;

                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_rpt_TimesheetSummaryReport NULL," + filterParameter.StartDate + "," + filterParameter.EndDate + "," + filterParameter.intUserID;
                    }
                }

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }

                m_lngReportID = 35011;
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));//FOR DEV ENV
                                                                                                                               // strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../../Reports/")); //FOR LOCAL ENV
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
                    //case "DOC": m_strFileName += ".doc"; break;
                    default: m_strFileName += ".pdf"; break;
                }
                IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_Whizible2_sel_tbl_PM_CompanyInformation", CommonController.connectionString);

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
                    // case "DOC": oRpt.GenerateReport(AdHocReports.Format.DOC); break;
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
    }
}
