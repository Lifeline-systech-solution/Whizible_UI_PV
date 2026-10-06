using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models;

namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RR_SiteReportController : ApiController
    {

        ////Added by imran on 19-08-2022  
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 19-08-2022
        [HttpPost]

        public object ExportDocument([FromBody]RR_SiteParameters filterParameter)
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
                if (filterParameter.LocationID > 0)
                {
                    //Commeneted and added by Chetan M on 18 Aug 2021 for show report header
                    //strSQL = "Exec usp_Whizible2_CSP_ProjectResourceWage " + filterParameter.ProjectID + " ," + filterParameter.SiteID + "," + filterParameter.EmployeeID + " ," + filterParameter.LocationID;
                    strSQL = "Exec usp_Whizible2_CSP_ProjectResourceWage " + filterParameter.ProjectID + " ," + filterParameter.SiteID + "," + filterParameter.EmployeeID + " ," + filterParameter.LocationID + ",'" + filterParameter.BySiteResource + "'";
                    //End of Commeneted and added by Chetan M on 18 Aug 2021 for show report header
                }
                else
                {
                    //Commeneted and added by Chetan M on 18 Aug 2021 for show report header
                    //strSQL = "Exec usp_Whizible2_CSP_ProjectResourceWage " + filterParameter.ProjectID + " ," + filterParameter.SiteID + "," + filterParameter.EmployeeID + " , NULL";
                    strSQL = "Exec usp_Whizible2_CSP_ProjectResourceWage " + filterParameter.ProjectID + " ," + filterParameter.SiteID + "," + filterParameter.EmployeeID + " , NULL,'" + filterParameter.BySiteResource + "'";
                    //End of Commeneted and added by Chetan M on 18 Aug 2021 for show report header
                }

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                var ReportTab = filterParameter.BySiteResource;
                switch (ReportTab)
                {
                    case "Site":
                        m_lngReportID = 35012;
                        break;
                    case "Resource":
                        m_lngReportID = 35013;
                        break;
                    default:
                        m_lngReportID = 35012;
                        break;
                }
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));//FOR DEV ENV
                                                                                                                               //strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../../Reports/")); //FOR LOCAL ENV
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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetResourceListBySiteResource([FromBody] RR_SiteParameters filterParameter)
        {
           
            try
            {
                List<RR_SiteReport> listReport = new List<RR_SiteReport>();
                List<RR_ResourceList> listByOUBG = new List<RR_ResourceList>();
                string filterParms = "";
                //if (filterParameter != null && filterParameter.RWhereClause != null && !string.IsNullOrEmpty(filterParameter.RWhereClause))
                //{
                //    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                //    filterParms = HttpUtility.UrlDecode(filterParameter.RWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                //}

                string strSQL = "";
                if (filterParms != null)
                {
                    string strParms = "@intProjectID =" + filterParameter.ProjectID + ",@intEmployeeID = " + filterParameter.EmployeeID + "," + "@intSiteID=" + filterParameter.SiteID + ",";
                    if (!string.IsNullOrEmpty(filterParameter.LocationID.ToString()) && filterParameter.LocationID >0)
                    {
                        strParms += "@intLocationID=" + filterParameter.LocationID + ",";
                    }
                    //if (!string.IsNullOrEmpty(filterParameter.SiteID.ToString()) && filterParameter.SiteID >0)
                    //{
                    //    strParms += "@intSiteID=" + filterParameter.SiteID + ",";
                    //}
                    strParms = strParms.TrimEnd(',');
                    //Commeneted and added by Chetan M on 18 Aug 2021 for show report header
                    //strSQL = "Exec usp_Whizible2_CSP_ProjectResourceWage " + strParms; 
                    strSQL = "Exec usp_Whizible2_CSP_ProjectResourceWage " + strParms + ",@BySiteResource ='" + filterParameter.BySiteResource+ "'";
                    //End of Commeneted and added by Chetan M on 18 Aug 2021 for show report header



                    DataTable RRTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (RRTable != null)
                    {
                        listReport = RRTable.ToList<RR_SiteReport>();
                    }
                    if (filterParameter.BySiteResource == "Site")
                    {
                        var resWisedata = listReport.GroupBy(x => x.SiteName).Select(g => new RR_SiteReport { SiteName = g.FirstOrDefault().SiteName }).ToList();
                        foreach (var item in resWisedata)
                        {
                            RR_ResourceList obj = new RR_ResourceList();
                            obj.lstResourceReport = new List<RR_SiteReport>();
                            // RR_ResourceList objOUBG = new RR_ResourceList();
                            var objOUBG = listReport.Where(x => x.SiteName == item.SiteName).ToList();
                            obj.SiteName = item.SiteName;
                            obj.lstResourceReport.AddRange(objOUBG);
                            listByOUBG.Add(obj);
                        }

                    }
                    if (filterParameter.BySiteResource == "Resource")
                    {
                        var resWisedata = listReport.GroupBy(x => x.ResourceName).Select(g => new RR_SiteReport { ResourceName = g.FirstOrDefault().ResourceName }).ToList();
                        foreach (var item in resWisedata)
                        {
                            RR_ResourceList obj = new RR_ResourceList();
                            obj.lstResourceReport = new List<RR_SiteReport>();
                            // RR_ResourceList objOUBG = new RR_ResourceList();
                            var objOUBG = listReport.Where(x => x.ResourceName == item.ResourceName).ToList();
                            obj.ResourceName = item.ResourceName;
                            obj.lstResourceReport.AddRange(objOUBG);
                            listByOUBG.Add(obj);
                        }
                    }
                }

                return Request.CreateResponse(HttpStatusCode.OK, listByOUBG);
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
        public HttpResponseMessage GetSites([FromBody] RR_SiteParameters filterParameter)
        {

            try
            {
                List<RR_ProjectSites> SiteList = new List<RR_ProjectSites>();
                var strSQL = "usp_Whizible2_Sel_ProjectSites " + filterParameter.ProjectID;

                DataTable SiteTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (SiteTable != null)
                {
                    SiteList = SiteTable.ToList<RR_ProjectSites>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, SiteList);
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
        public HttpResponseMessage GetProjectResources([FromBody] RR_SiteParameters filterParameter)
        {

            
            try
            {
                List<RR_ProjectEmployee> SiteList = new List<RR_ProjectEmployee>();
                var strSQL = "usp_Whizible2_Sel_ProjectEmployees " + filterParameter.ProjectID;

                DataTable EmpTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (EmpTable != null)
                {
                    SiteList = EmpTable.ToList<RR_ProjectEmployee>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, SiteList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            


        }
    }
}