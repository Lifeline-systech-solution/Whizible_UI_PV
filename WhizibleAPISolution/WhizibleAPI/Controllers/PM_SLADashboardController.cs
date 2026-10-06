using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.DashBoard;

namespace WhizibleAPI.Controllers
{
    public class PM_SLADashboardController : ApiController
    {
        #region[GetProject]
        /// <summary>
        /// Created Date    :   05 March 2020
        /// Purpose         :   GetProject
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        //public List<FillProjectParametersNew> GetProjectDropDown([FromBody]defaultFilterParametersNew parameters)
        public object GetProjectDropDown([FromBody] defaultFilterParametersNew parameters)

        {
            try
            {
                DataTable FillProjectDatatable;
                List<FillProjectParametersNew> listProjectName = new List<FillProjectParametersNew>();
                FillProjectDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee_Stakeholders "
                                                                                + HttpUtility.UrlDecode(parameters.UserID.ToString()) + ","
                                                                                     + HttpUtility.UrlDecode(parameters.ProjectID.ToString()) + "",
                                                                                     true, CommonController.connectionString);
                foreach (DataRow dr in FillProjectDatatable.Rows)
                {
                    FillProjectParametersNew CC = new FillProjectParametersNew()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ProjectID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ProjectName"], "")),
                    };

                    listProjectName.Add(CC);
                }
                return listProjectName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion


        #region[GetProjectUser]
        /// <summary>
        /// Created Date    :   05 March 2020
        /// Purpose         :   GetProjectUser
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        //public List<UserDataNew> GetProjectUserDropDown([FromBody] defaultFilterParametersNew parameters)
        public object GetProjectUserDropDown([FromBody] defaultFilterParametersNew parameters)
        {
            try
            {
                DataTable FillUsersDatatable;
                List<UserDataNew> listUsers = new List<UserDataNew>();
                FillUsersDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Users_ByProject "
                                                                                + HttpUtility.UrlDecode(parameters.ProjectID.ToString()) + "",
                                                                                     true, CommonController.connectionString);
                foreach (DataRow dr in FillUsersDatatable.Rows)
                {
                    UserDataNew CC = new UserDataNew()
                    {
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["EmployeeID"], "0")),
                        EmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["EmployeeName"], "")),
                    };
                    listUsers.Add(CC);
                }
                return listUsers;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            #endregion

            [HttpPost]
        [Authorize]
        public PM_SLADashboard GetSLADetails([FromBody]PM_CommercialDashboardFilterNew filter)
        {
            PM_SLADashboard SLADetails = new PM_SLADashboard();
            try
            {
                // //for get SLA common data
                DataTable SLADetailsDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_SLADashboard_GetSLADashboardDetails " + filter.ProjectFilter + ","
                                                                               + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
                                                                             , true, CommonController.connectionString);
                foreach (DataRow slaDetailsRow in SLADetailsDataTable.Rows)
                {
                    SLADetails.SLALikelyToMiss = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(slaDetailsRow["SLALikelyToMiss"], "0"));
                    SLADetails.SLAMissed = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(slaDetailsRow["SLAMissed"], "0"));
                    SLADetails.MySLATicketsInActive = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(slaDetailsRow["MySLATicketsInActive"], "0"));
                    SLADetails.TotalActiveTickets = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(slaDetailsRow["TotalActiveTickets"], "0"));
                }

                // for get Ticket Distribution
                DataTable TicketDistributionDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_SLADashboard_GetTicketDistributionDetails " + filter.ProjectFilter + ","
                                                                              + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
                                                                            , true, CommonController.connectionString);
                List<string> Type = new List<string>();
                List<int> TypeData = new List<int>();
                List<string> ColorCode = new List<string>();
                foreach (DataRow ticketDistributionRow in TicketDistributionDataTable.Rows)
                {
                    Type.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ticketDistributionRow["Type"], "")));
                    TypeData.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ticketDistributionRow["TypeData"], "0")));
                    ColorCode.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ticketDistributionRow["ColorCode"], "")));
                }
                SLADetails.TicketDistribution = new TicketDistribution
                {
                    Type = Type.ToArray(),
                    TypeData = TypeData.ToArray(),
                    ColorCode = ColorCode.ToArray()
                };

                // for get SLA project data 
                DataTable SLAProjectDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_SLADashboard_GetSLAProjectDetails " + filter.ProjectFilter + ","
                                                                             + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
                                                                           , true, CommonController.connectionString);

                SLADetails.ProjectData = new List<SLAProjectData>();
                foreach (DataRow slaProjectRow in SLAProjectDataTable.Rows)
                {
                    SLAProjectData SLAProjectDataObj = new SLAProjectData
                    {
                        ID = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["ID"], "0")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Status"], "")),
                        Subject = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Subject"], "")),
                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Priority"], "")),
                        RequestType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["RequestType"], "")),
                        Requestor = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Requestor"], "")),
                        RequestedOn = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["RequestedOn"], "")),
                        LastUpdated = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["LastUpdated"], "")),
                        AssignedTo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["AssignedTo"], "")),
                        AssignedToFullName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["AssignedToFullName"], ""))
                    };
                    SLADetails.ProjectData.Add(SLAProjectDataObj);
                }
            }
            catch (Exception e){ }
            return SLADetails;
        }

        #region[GetGridSLATicketsDataOnTabClick]
        /// <summary>
        /// Created Date    :   14th May 2020
        /// Purpose         :   To Get the SLA details call from the tab click and load SLA clicked tab data
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public object GetGridSLATicketsDataOnTabClick([FromBody]PM_CommercialDashboardFilterNew filter)
        {
            
                DataTable FillDataTable;
                List<SLAProjectData> SLAGridData = new List<SLAProjectData>();
            try
            {
                FillDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_SLADashboard_GetSLAProjectDetails " + filter.ProjectFilter + ","
                                                                           + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
                                                                         , true, CommonController.connectionString);

                foreach (DataRow slaProjectRow in FillDataTable.Rows)
                {
                    SLAProjectData CC = new SLAProjectData()
                    {
                        ID = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["ID"], "0")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Status"], "")),
                        Subject = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Subject"], "")),
                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Priority"], "")),
                        RequestType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["RequestType"], "")),
                        Requestor = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["Requestor"], "")),
                        RequestedOn = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["RequestedOn"], "")),
                        LastUpdated = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["LastUpdated"], "")),
                        AssignedTo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["AssignedTo"], "")),
                        AssignedToFullName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(slaProjectRow["AssignedToFullName"], ""))
                    };
                    SLAGridData.Add(CC);
                }
                return SLAGridData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }
        #endregion

        public string ExportDocument([FromBody]ReportParam taskParameters)
        {
            string strSQL;
            string strFilePath;
            //string strFormat;
            //string strCaptions;
            string m_strFileName;
            long m_lngReportID;
            int DateFormatID = 0;
            string CompanyName = "";
            string ReportFormat = taskParameters.ReportFormat;
            AdHocReports.Report.AdHocReport oRpt;

            strSQL = "usp_Whizible2_rpt_SLADashboard_GetSLADashboardDetails " + taskParameters.UserID;

            //IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
            //if (drCompInfo1.Read() == false)
            //{
            //    return "";
            //}
            m_lngReportID = 22293;// 22272;

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
            oRpt.DefaultLCID = 2125;
            oRpt.LCID = 2125;
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

    }
}