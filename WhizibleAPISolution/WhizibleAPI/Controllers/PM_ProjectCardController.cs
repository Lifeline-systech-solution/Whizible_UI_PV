using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.ProjectCard;

namespace WhizibleAPI.Controllers
{
    public class PM_ProjectCardController : ApiController
    {
        #region[Get Methods]
        /// <summary>
        /// Created Date    :   16 Aug 2019
        /// Purpose         :   Get Racichart Project Contacts
        /// <returns></returns> 
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        ////public List<PM_ProjectCardContact> GetProjectCardContact([FromBody] ProjectCardContactParameter objProjectCardContactParameter)
        public object GetProjectCardContact([FromBody] ProjectCardContactParameter objProjectCardContactParameter)

        {
            try
            {
                DataTable ProjectCardContactData;
                List<PM_ProjectCardContact> listRaciChartProjectContact = new List<PM_ProjectCardContact>();
                ProjectCardContactData = CommonFunctions.Data.GetDataTable("Usp_sel_tbl_Whizible2_ProjectCard " + objProjectCardContactParameter.projectID.ToString() + ",'" + objProjectCardContactParameter.type.ToString() + "' ", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in ProjectCardContactData.Rows)
                {
                    PM_ProjectCardContact PC = new PM_ProjectCardContact()
                    {
                        ProjectContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ProjectContactID"], "")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Name"], "")),
                        Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Designation"], "")),
                        EmailID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["EmailID"], "")),
                        Mobile = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Mobile"], "")),
                        TypeOfContact = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["TypeOfContact"], "")),
                        Status = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ActiveStatus"], "")),
                        Photo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Photo"], ""))
                    };


                    listRaciChartProjectContact.Add(PC);
                }
                return listRaciChartProjectContact;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[ExportDocument]
        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   
        /// Purpose         :   Get Clients
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ExportDocument([FromBody] ProjectCardReportParameters projectCardReportParameters)
        {
            try
            {
                string strSQL;
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = projectCardReportParameters.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                strSQL = "Usp_sel_tbl_Whizible2_ProjectCard " + projectCardReportParameters.projectID + ",'" + projectCardReportParameters.ContractType.ToString() + "'";
                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                m_lngReportID = 22281;
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
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

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            #endregion
        }
}
