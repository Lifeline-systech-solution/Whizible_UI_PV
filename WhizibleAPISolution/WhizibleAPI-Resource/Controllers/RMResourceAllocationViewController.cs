using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Net;
using System.Net.Http;
using System.Configuration;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.IO;
using System.Xml;




namespace WhizibleAPI.Controllers
{

    public class RMResourceAllocationViewController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetFromDateToDate([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_SEL_FromAndToDates_ForReasourceAllocation " + ResourceParameters.View + ",'" + ResourceParameters.Period + "','" + ResourceParameters.FromDate + "'";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex) {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDetailsView([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_SEL_ResourceAllocation_Dashboard_ResourceDetails_RAV " + ResourceParameters.LoginEmployeeID + ",'" + ResourceParameters.LoginType + "','" + ResourceParameters.UserName + "',"+ ResourceParameters .LoginID+ ",'" + ResourceParameters.View + "','" + ResourceParameters.FromDate + "','" + ResourceParameters.ToDate + "'," + ResourceParameters.EmployeeID + "";
                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object ExportToReport([FromBody] ResourcesDetails ResourceParameters)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName = "";
                long m_ReportID = 35026;
                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                string ProjectId = HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                string CompanyName = "";
                int DateFormatID = 0;
                AdHocReports.Report.AdHocReport oRpt;
                IDataReader drReport;

                strSQL = "EXEC usp_Whizible2_SEL_ResourceAllocation_Dashboard_ResourceDetails_RAV " + ResourceParameters.LoginEmployeeID + ",'" + ResourceParameters.LoginType + "','" + ResourceParameters.UserName + "'," + ResourceParameters.LoginID + ",'" + ResourceParameters.View + "','" + ResourceParameters.FromDate + "','" + ResourceParameters.ToDate + "'," + ResourceParameters.EmployeeID + "";
                drReport = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drReport.Read())
                {
                    CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                    CommonEngines.HashTables.Culture.FillCultureHashTable();
                    strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                    m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                    switch (ResourceParameters.ReportFormat)
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

                    switch (ResourceParameters.ReportFormat)
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





        public class ResourcesDetails
        {
            public string ProjectID { get; set; }
            public string FromDate { get; set; }
            public string LoginEmployeeID { get; set; }
            public string View { get; set; }
            public string Period { get; set; }
            public string ToDate { get; set; }
            public string LoginID { get; set; }
            public string LoginType { get; set; }
            public string UserName { get; set; }
            public string RequestID { get; set; }
            public string Fromwhereclause { get; set; }
            public string Comments { get; set; }
            public string Status { get; set; }
            public string ProjectName { get; set; }
            public string OrderBy { get; set; }
            public string WhichTab { get; set; }
            public int EmployeeID { get; set; }
            public String ReportFormat { get; set; }

            public int ProjectEmployeeRoleID { get; set; }
        }

        public class SkillGraph
        {
            public string Description { get; set; }
            public int NoOfResources { get; set; }
        }

    }


}