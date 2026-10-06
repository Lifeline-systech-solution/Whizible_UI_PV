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
    public class RR_ResourceAllocationReportController : ApiController
    {
         
        ////Added by imran on 19-08-2022  
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022 
        [HttpPost]
        public HttpResponseMessage GetResourceAllocationByProject(RAFilterParameter filterParameter)
        {
          
            try
            {
                List<RR_ResourceAllocationReport> list = new List<RR_ResourceAllocationReport>();
                List<RR_ResourceAllocationByProject> listByProj = new List<RR_ResourceAllocationByProject>();

                string filterParms = "";
                if (filterParameter != null && filterParameter.RAWhereClause != null && !string.IsNullOrEmpty(filterParameter.RAWhereClause))
                {
                //    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.RAWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                   filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                   strSQL = "Exec usp_Whizible2_ResourceAllocation_ByProject '" + filterParms + "'";
                }
               else
                {
                strSQL = "Exec usp_Whizible2_ResourceAllocation_ByProject";
                }


                DataTable RRTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (RRTable != null)
                {
                    list = RRTable.ToList<RR_ResourceAllocationReport>();
                }
                var projWisedata = list.GroupBy(x => x.ProjectName).Select(g => new RR_ResourceAllocationByProject { ProjectName = g.FirstOrDefault().ProjectName }).ToList();
                foreach (var item in projWisedata)
                {
                    RR_ResourceAllocationByProject obj = new RR_ResourceAllocationByProject();
                    obj.lstRAProjectReport = new List<RR_ResourceAllocationReport>();
                    RR_ResourceAllocationReport objName = new RR_ResourceAllocationReport();
                    var objname = list.Where(x => x.ProjectName == item.ProjectName).ToList();
                    obj.ProjectName = item.ProjectName;
                    obj.lstRAProjectReport.AddRange(objname);
                    listByProj.Add(obj);
                }
                return Request.CreateResponse(HttpStatusCode.OK, listByProj);
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
        public HttpResponseMessage GetResourceAllocationByResource(RAFilterParameter filterParameter)
        {
           
            try
            {
                List<RR_ResourceAllocationReport> list = new List<RR_ResourceAllocationReport>();
                List<RR_ResourceAllocationByProject> listByRes = new List<RR_ResourceAllocationByProject>();

                string filterParms = "";
                if (filterParameter != null && filterParameter.RAWhereClause != null && !string.IsNullOrEmpty(filterParameter.RAWhereClause))
                {
                    //    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.RAWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_ResourceAllocation_ByResource '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_ResourceAllocation_ByResource";
                }


                DataTable RRTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (RRTable != null)
                {
                    list = RRTable.ToList<RR_ResourceAllocationReport>();
                }
                var resWisedata = list.GroupBy(x => x.EmployeeName).Select(g => new RR_ResourceAllocationByProject { EmployeeName = g.FirstOrDefault().EmployeeName }).ToList();
                foreach (var item in resWisedata)
                {
                    RR_ResourceAllocationByProject obj = new RR_ResourceAllocationByProject();
                    obj.lstRAProjectReport = new List<RR_ResourceAllocationReport>();
                    RR_ResourceAllocationReport objName = new RR_ResourceAllocationReport();
                    var objname = list.Where(x => x.EmployeeName == item.EmployeeName).ToList();
                    obj.EmployeeName = item.EmployeeName;
                    obj.lstRAProjectReport.AddRange(objname);
                    listByRes.Add(obj);
                }
                return Request.CreateResponse(HttpStatusCode.OK, listByRes);
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
        public object ExportDocument([FromBody]RA_Filter_params rA_Filter_Params)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = rA_Filter_Params.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                //if (taskParameters.OpportunityID > 0)
                //{
                //    //strSQL = "usp_RPT_StaffingPlan";
                //}
                // strSQL = "usp_Whizible2_Sel_CapacityPlanning_RoleWise_Qtr_View '" + CapacityFilterparams.BGOUType + "','" + CapacityFilterparams.BGOUFilter + "','" + CapacityFilterparams.SkillList + "',0";//  "usp_Whizible2_Sel_CapacityPlaningListView ";
                if (rA_Filter_Params.ReportTab == "Project")
                {
                    if (rA_Filter_Params.RAWhereClause != null && !string.IsNullOrEmpty(rA_Filter_Params.RAWhereClause))
                    {
                        strSQL = "Exec usp_Whizible2_ResourceAllocation_ByProject '" + rA_Filter_Params.RAWhereClause + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_ResourceAllocation_ByProject";
                    }
                }
                else
                {
                    if (rA_Filter_Params.RAWhereClause != null)
                    {
                        strSQL = "Exec usp_Whizible2_ResourceAllocation_ByResource '" + rA_Filter_Params.RAWhereClause + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_ResourceAllocation_ByResource";
                    }
                }
                // strSQL = "usp_Whizible2_Sel_RaExportReport '" + rA_Filter_Params.BusinessGroupID + "','" + rA_Filter_Params.LocationID + "','" + rA_Filter_Params.ProjectTypeID + "','" + rA_Filter_Params.ReportTab + "',0";//  "usp_Whizible2_Sel_CapacityPlaningListView ";

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                var ReportTab = rA_Filter_Params.ReportTab;
                switch (ReportTab)
                {
                    case "Project":
                        m_lngReportID = 905;
                        break;
                    case "Resource":
                        m_lngReportID = 906;
                        break;
                    default:
                        m_lngReportID = 905;
                        break;
                }

                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));//FOR DEV ENV
                                                                                                                               //  strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../../Reports/")); //FOR LOCAL ENV
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
