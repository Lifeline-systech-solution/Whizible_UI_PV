using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.RM;
using WhizibleAPI.Extensions;

namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RR_ForeCastingController : ApiController
    {
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]  
        ////End of comment by imran on 30-08-2022
        [HttpPost]
        public object ExportDocument([FromBody]RR_ForeCastingReport filterParameter)
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


                if (filterParameter.ByWeekOrMonth == "Weekly")
                {
                    //strSQL = "Exec usp_Whizible2_ForeCastingReportWeeks " + filterParameter.intUserID;    
                    if (filterParameter.RoleID == 0)
                    {
                        strSQL = "Exec usp_Whizible2_ForeCastingReportWeeks " + filterParameter.intUserID + ",NULL";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_ForeCastingReportWeeks " + filterParameter.intUserID + "," + filterParameter.RoleID;
                    }
                }
                else
                {
                    // strSQL = "Exec usp_Whizible2_ForeCastingReport 0";
                    if (filterParameter.RoleID == 0)
                    {
                        strSQL = "Exec usp_Whizible2_ForeCastingReport 0,NULL";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_ForeCastingReport 0," + filterParameter.RoleID;
                    }
                }

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                if (filterParameter.ByWeekOrMonth == "Weekly")
                {
                    m_lngReportID = 35021;
                }
                else
                {
                    m_lngReportID = 35020;
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

        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        [HttpPost]
        public HttpResponseMessage GetForeCastingByWeekly([FromBody] RR_ForeCastingReport filterParameter)
        {
          
            try
            {
                List<string> columnNames = new List<string>();
                List<RR_ForeCastingWeek> listReportWeek = new List<RR_ForeCastingWeek>();
                string strSQL = "";
                if (filterParameter != null)
                {
                    if (filterParameter.ByWeekOrMonth == "Weekly")
                    {
                        if(filterParameter.RoleID==0)
                        {
                            strSQL = "Exec usp_Whizible2_ForeCastingReportWeeks " + filterParameter.intUserID + ",NULL";
                        }
                        else
                        {
                            strSQL = "Exec usp_Whizible2_ForeCastingReportWeeks " + filterParameter.intUserID + "," + filterParameter.RoleID;
                        }
                       
                    }
                    //else
                    //{
                    //    strSQL = "Exec usp_Whizible2_ForeCastingReport";
                    //}

                    //DataTable RRTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    //if (RRTable != null)
                    //{
                    //    listReport = RRTable.ToList<RR_ForeCastingWeek>();
                    //}
                    DataSet RRTable = CommonFunctions.Data.GetDataSet(strSQL, "ForeCastWeek", ConnectionString: CommonController.connectionString);
                    // DataSet CapacityPlanDSet = CommonFunctions.Data.GetDataSet(strSQL, "CP_listView", ConnectionString: CommonController.connectionString);
                    //DataTable ResourceTable = RRTable.Tables[0];
                    if (RRTable.Tables.Count > 0)
                    {
                        var monthNames = RRTable.Tables[1];
                        foreach (DataRow itemHeader in monthNames.Rows)
                        {
                            columnNames.Add(Convert.ToString(itemHeader["name"]));
                        }
                        foreach (DataRow itemResource in RRTable.Tables[0].Rows)
                        {
                            listReportWeek.Add(GetRrResourceWeek(itemResource, string.Empty));
                        }

                        //listReportWeek = RRTable.Tables[0].ToList<RR_ForeCastingWeek>();
                       

                    }
                }
                else
                {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { listReport = listReportWeek, MonthColumn = columnNames });
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        [HttpPost]
        public HttpResponseMessage GetForeCastingByMonthly([FromBody] RR_ForeCastingReport filterParameter)
        {
            try
            {
                List<RR_ForeCastingMonth> listReport = new List<RR_ForeCastingMonth>();
                List<string> columnNames = new List<string>();
                var RrResorceList = new List<ForeCastMothWeek>();
                string strSQL = "";
                if (filterParameter != null)
                {
                    if (filterParameter.ByWeekOrMonth == "Monthly")
                    {
                        if (filterParameter.RoleID == 0)
                        {
                            strSQL = "Exec usp_Whizible2_ForeCastingReport 1,NULL";
                        }
                        else
                        {
                            strSQL = "Exec usp_Whizible2_ForeCastingReport 1, " + filterParameter.RoleID;
                        }
                       
                    }
                    

                    DataSet RRTable = CommonFunctions.Data.GetDataSet(strSQL, "ForeCastMonth", ConnectionString: CommonController.connectionString);
                    // DataSet CapacityPlanDSet = CommonFunctions.Data.GetDataSet(strSQL, "CP_listView", ConnectionString: CommonController.connectionString);
                    //DataTable ResourceTable = RRTable.Tables[0];
                    if (RRTable.Tables.Count > 0)
                    {
                        var monthNames = RRTable.Tables[1];
                        foreach (DataRow itemHeader in monthNames.Rows)
                        {
                            columnNames.Add(Convert.ToString(itemHeader["name"]));
                        }
                        //  columnNames = RRTable.Tables[0].Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                        // columnNames.RemoveRange(0,1);
                        foreach (DataRow itemResource in RRTable.Tables[0].Rows)
                        {
                            RrResorceList.Add(GetRrResourceMonth(itemResource, string.Empty));
                        }

                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.BadRequest);
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK, new { listReport = RrResorceList, MonthColumn = columnNames });
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
         
        }

        private ForeCastMothWeek GetRrResourceMonth(DataRow TblRows, string Name = null)
        {
            var RrProjectMonths = new ForeCastMothWeek();
           
            RrProjectMonths.ResourceName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ResourceName"].ToString();
            RrProjectMonths.Month_1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[1], "0"));
            RrProjectMonths.Month_Ph1 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[2], "0"));
            RrProjectMonths.Month_2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[3], "0"));
            RrProjectMonths.Month_Ph2 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            RrProjectMonths.Month_3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            RrProjectMonths.Month_Ph3 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            RrProjectMonths.Month_4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            RrProjectMonths.Month_Ph4 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            RrProjectMonths.Month_5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            RrProjectMonths.Month_Ph5 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            RrProjectMonths.Month_6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            RrProjectMonths.Month_Ph6 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            RrProjectMonths.Month_7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            RrProjectMonths.Month_Ph7 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            RrProjectMonths.Month_8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            RrProjectMonths.Month_Ph8 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            RrProjectMonths.Month_9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            RrProjectMonths.Month_Ph9 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "0"));
            RrProjectMonths.Month_10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[19], "0"));
            RrProjectMonths.Month_Ph10 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[20], "0"));
            RrProjectMonths.Month_11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[21], "0"));
            RrProjectMonths.Month_Ph11 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[22], "0"));
            RrProjectMonths.Month_12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[23], "0"));
            RrProjectMonths.Month_Ph12 = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(TblRows[24], "0"));

            return RrProjectMonths;
        }
        private RR_ForeCastingWeek GetRrResourceWeek(DataRow TblRows, string Name = null)
        {
            var RrProjectQuarter = new RR_ForeCastingWeek();
            RrProjectQuarter.ResourceName = !string.IsNullOrEmpty(Name) ? Name : TblRows["ResourceName"].ToString();
            RrProjectQuarter.W1 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[1], "0"));
            RrProjectQuarter.W1_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[2], "0"));
            RrProjectQuarter.W2 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[3], "0"));
            RrProjectQuarter.W2_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[4], "0"));
            RrProjectQuarter.W3 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[5], "0"));
            RrProjectQuarter.W3_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[6], "0"));
            RrProjectQuarter.W4 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[7], "0"));
            RrProjectQuarter.W4_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            RrProjectQuarter.W5 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            RrProjectQuarter.W5_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            RrProjectQuarter.W6 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            RrProjectQuarter.W6_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            RrProjectQuarter.W7 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            RrProjectQuarter.W7_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            RrProjectQuarter.W8 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            RrProjectQuarter.W8_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            RrProjectQuarter.W9 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            RrProjectQuarter.W9_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "0"));
            RrProjectQuarter.W10 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[19], "0"));
            RrProjectQuarter.W10_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[20], "0"));

            RrProjectQuarter.W11 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[21], "0"));
            RrProjectQuarter.W11_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[22], "0"));
            RrProjectQuarter.W12 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[23], "0"));
            RrProjectQuarter.W12_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[24], "0"));
            RrProjectQuarter.W13 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[25], "0"));
            RrProjectQuarter.W13_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[26], "0"));
            RrProjectQuarter.W14 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[27], "0"));
            RrProjectQuarter.W14_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[28], "0"));
            RrProjectQuarter.W15 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[29], "0"));
            RrProjectQuarter.W15_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[30], "0"));
            RrProjectQuarter.W16 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[31], "0"));
            RrProjectQuarter.W16_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[32], "0"));
            RrProjectQuarter.W17 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[33], "0"));
            RrProjectQuarter.W17_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[34], "0"));
            RrProjectQuarter.W18 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[35], "0"));
            RrProjectQuarter.W18_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[36], "0"));
            RrProjectQuarter.W19 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[37], "0"));
            RrProjectQuarter.W19_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[38], "0"));
            RrProjectQuarter.W20 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[39], "0"));
            RrProjectQuarter.W20_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[40], "0"));

            RrProjectQuarter.W21 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[41], "0"));
            RrProjectQuarter.W21_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[42], "0"));
            RrProjectQuarter.W22 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[43], "0"));
            RrProjectQuarter.W22_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[44], "0"));
            RrProjectQuarter.W23 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[45], "0"));
            RrProjectQuarter.W23_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[46], "0"));
            RrProjectQuarter.W24 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[47], "0"));
            RrProjectQuarter.W24_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[48], "0"));
            RrProjectQuarter.W25 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[49], "0"));
            RrProjectQuarter.W25_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[50], "0"));
            RrProjectQuarter.W26 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[51], "0"));
            RrProjectQuarter.W26_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[52], "0"));
            RrProjectQuarter.W27 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[53], "0"));
            RrProjectQuarter.W27_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[54], "0"));
            RrProjectQuarter.W28 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[55], "0"));
            RrProjectQuarter.W28_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[56], "0"));
            RrProjectQuarter.W29 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[57], "0"));
            RrProjectQuarter.W29_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[58], "0"));
            RrProjectQuarter.W30 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[59], "0"));
            RrProjectQuarter.W30_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[60], "0"));

            RrProjectQuarter.W31 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[61], "0"));
            RrProjectQuarter.W31_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[62], "0"));
            RrProjectQuarter.W32 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[63], "0"));
            RrProjectQuarter.W32_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[64], "0"));
            RrProjectQuarter.W33 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[65], "0"));
            RrProjectQuarter.W33_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[66], "0"));
            RrProjectQuarter.W34 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[67], "0"));
            RrProjectQuarter.W34_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[68], "0"));
            RrProjectQuarter.W35 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[69], "0"));
            RrProjectQuarter.W35_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[70], "0"));
            RrProjectQuarter.W36 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[71], "0"));
            RrProjectQuarter.W36_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[72], "0"));
            RrProjectQuarter.W37 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[73], "0"));
            RrProjectQuarter.W37_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[74], "0"));
            RrProjectQuarter.W38 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[75], "0"));
            RrProjectQuarter.W38_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[76], "0"));
            RrProjectQuarter.W39 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[77], "0"));
            RrProjectQuarter.W39_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[78], "0"));
            RrProjectQuarter.W40 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[79], "0"));
            RrProjectQuarter.W40_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[80], "0"));

            RrProjectQuarter.W41 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[81], "0"));
            RrProjectQuarter.W41_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[82], "0"));
            RrProjectQuarter.W42 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[83], "0"));
            RrProjectQuarter.W42_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[84], "0"));
            RrProjectQuarter.W43 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[85], "0"));
            RrProjectQuarter.W43_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[86], "0"));
            RrProjectQuarter.W44 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[87], "0"));
            RrProjectQuarter.W44_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[88], "0"));
            RrProjectQuarter.W45 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[89], "0"));
            RrProjectQuarter.W45_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[90], "0"));
            RrProjectQuarter.W46 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[91], "0"));
            RrProjectQuarter.W46_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[92], "0"));
            RrProjectQuarter.W47 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[93], "0"));
            RrProjectQuarter.W47_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[94], "0"));
            RrProjectQuarter.W48 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[95], "0"));
            RrProjectQuarter.W48_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[96], "0"));
            RrProjectQuarter.W49 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[97], "0"));
            RrProjectQuarter.W49_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[98], "0"));
            RrProjectQuarter.W50 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[99], "0"));
            RrProjectQuarter.W50_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[100], "0"));

            RrProjectQuarter.W51 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[101], "0"));
            RrProjectQuarter.W51_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[102], "0"));
            RrProjectQuarter.W52 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[103], "0"));
            RrProjectQuarter.W52_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[104], "0"));
            RrProjectQuarter.W53 = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[103], "0"));
            RrProjectQuarter.W53_Ah = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(TblRows[104], "0"));
            return RrProjectQuarter;
        }
    }
}