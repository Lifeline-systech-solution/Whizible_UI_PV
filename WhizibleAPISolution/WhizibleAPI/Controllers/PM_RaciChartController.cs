using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.RaciChart;

namespace WhizibleAPI.Controllers
{
    public class PM_RaciChartController : ApiController
    {

        #region[Get Methods]
        /// <summary>
        /// Created Date    :   16 Aug 2019
        /// Purpose         :   Get Racichart Project Contacts
        /// <returns></returns> 
        ////Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        //public List<RaciChartProjectContact> GetRaciChartProjectContact([FromBody] RaciChartProjectContactParameter objRaciChartProjectContactParameter)
        public object GetRaciChartProjectContact([FromBody] RaciChartProjectContactParameter objRaciChartProjectContactParameter)

        {
            try
            {
                DataTable Raci_Table;
                List<RaciChartProjectContact> listRaciChartProjectContact = new List<RaciChartProjectContact>();
                Raci_Table = CommonFunctions.Data.GetDataTable("Usp_Whizible2_sel_tbl_Raci_ProjectContacts " + HttpUtility.UrlDecode(objRaciChartProjectContactParameter.projectID.ToString()) + ",'" + HttpUtility.UrlDecode(objRaciChartProjectContactParameter.type.ToString()) + "' ", true, CommonController.connectionString);
                foreach (DataRow drProjectTask in Raci_Table.Rows)
                {
                    RaciChartProjectContact RA = new RaciChartProjectContact()
                    {
                        ProjectContactID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ProjectContactID"], "")),
                        Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Name"], "")),
                        Designation = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["Designation"], "")),
                        TypeOfContact = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProjectTask["TypeOfContact"], "")),
                        Status = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drProjectTask["ActiveStatus"], ""))
                    };


                    listRaciChartProjectContact.Add(RA);
                }
                return listRaciChartProjectContact;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetProjectMilstones]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        //public List<Milstones> GetProjectMilstones([FromBody] Milstones objMilstones)
        public object GetProjectMilstones([FromBody] Milstones objMilstones)

        {
            try
            {
                /*Get raci of resources WBS wise*/
                List<RaciData> listRaciData = new List<RaciData>();
                DataTable RACITable = new DataTable();
                RACITable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_whizible2_racichart  " + HttpUtility.UrlDecode(objMilstones.projectID.ToString()) + ",'Milestone', '" + HttpUtility.UrlDecode(objMilstones.Type) + "' ", true, CommonController.connectionString);
                for (int i = 0; i < RACITable.Rows.Count; i++)
                {
                    RaciData objRaciData = new RaciData();
                    objRaciData.StakeholderID = Convert.ToInt32(RACITable.Rows[i]["StakeholderID"]);
                    objRaciData.WBSID = Convert.ToInt32(RACITable.Rows[i]["WBSID"]);
                    objRaciData.Responsible = RACITable.Rows[i]["Responsible"].ToString();
                    objRaciData.Accountable = RACITable.Rows[i]["Accountable"].ToString();
                    objRaciData.Consulted = RACITable.Rows[i]["Consulted"].ToString();
                    objRaciData.Informed = RACITable.Rows[i]["Informed"].ToString();
                    listRaciData.Add(objRaciData);

                }
                var groupWBS = listRaciData.GroupBy(x => x.WBSID).ToList();
                var groupStakeholders = listRaciData.GroupBy(x => x.StakeholderID).ToList();


                DataTable MilstoneTable;
                List<Milstones> listMilstones = new List<Milstones>();
                MilstoneTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_MilestonesRaciView " + objMilstones.projectID.ToString() + " ", true, CommonController.connectionString);
                for (int i = 0; i < MilstoneTable.Rows.Count; i++)
                {
                    Milstones RA = new Milstones();
                    RA.ID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(MilstoneTable.Rows[i]["ID"], ""));
                    RA.Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(MilstoneTable.Rows[i]["Name"], ""));
                    List<Stakeholder> listStakeholder = new List<Stakeholder>();

                    for (int j = 0; j < groupStakeholders.Count(); j++)
                    {
                        string[] RACI = new string[4];
                        Stakeholder objStakeholder = new Stakeholder();
                        objStakeholder.StakeholderID = groupStakeholders[j].Key;
                        var getRACI = listRaciData.Where(x => x.WBSID == RA.ID && x.StakeholderID == groupStakeholders[j].Key).FirstOrDefault();
                        if (getRACI != null)
                        {
                            if (getRACI.Responsible.ToLower() == "true")
                            {
                                RACI[0] = "1";
                            }
                            if (getRACI.Accountable.ToLower() == "true")
                            {
                                RACI[1] = "2";
                            }
                            if (getRACI.Consulted.ToLower() == "true")
                            {
                                RACI[2] = "3";
                            }
                            if (getRACI.Informed.ToLower() == "true")
                            {
                                RACI[3] = "4";
                            }
                        }
                        else
                        {
                            RACI[0] = "0";
                            RACI[1] = "0";
                            RACI[2] = "0";
                            RACI[3] = "0";
                        }

                        objStakeholder.RACI = RACI;
                        listStakeholder.Add(objStakeholder);
                    }
                    RA.listStakeholder = listStakeholder;

                    listMilstones.Add(RA);
                }
                return listMilstones;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetWBS]
        [HttpPost]
        //public List<WBS> GetWBS([FromBody] WBS objWBS)
        public object GetWBS([FromBody] WBS objWBS)

        {
            try
            {
                DataTable WBSTable;
                List<WBS> listWBS = new List<WBS>();
                WBSTable = CommonFunctions.Data.GetDataTable("usp_db_Sel_WBS ", true, CommonController.connectionString);
                foreach (DataRow drRaciViewss in WBSTable.Rows)
                {
                    WBS RA = new WBS()
                    {
                        WBSName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drRaciViewss["NAME"], "")),
                    };


                    listWBS.Add(RA);
                }
                return listWBS;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetRACIFromTableRACICHART]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        //public List<RACISEL> GETRACI([FromBody] RACISEL objRACI)
        public object GETRACI([FromBody] RACISEL objRACI)

        {
            try
            {
                DataTable RACITable;
                List<RACISEL> listRACI = new List<RACISEL>();
                RACITable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_whizible2_racichart ", true, CommonController.connectionString);
                foreach (DataRow drRaciViewss in RACITable.Rows)
                {
                    RACISEL RA = new RACISEL()
                    {
                        //RACIName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drRaciViewss["NAME"], "")),
                    };


                    listRACI.Add(RA);
                }
                return listRACI;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[GetWBSProjects]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        //public List<SubProjects> GetWBSProjects([FromBody] SubProjects objSubProjects)
        public object GetWBSProjects([FromBody] SubProjects objSubProjects)

        {
            try
            {

                /*Get raci of resources WBS wise*/
                List<RaciData> listRaciData = new List<RaciData>();
                DataTable RACITable = new DataTable();
                RACITable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_whizible2_racichart  " + HttpUtility.UrlDecode(objSubProjects.projectID.ToString()) + "," + HttpUtility.UrlDecode(objSubProjects.Type) + ", '" + HttpUtility.UrlDecode(objSubProjects.StakeholderType) + "' ", true, CommonController.connectionString);
                for (int i = 0; i < RACITable.Rows.Count; i++)
                {
                    RaciData objRaciData = new RaciData();
                    objRaciData.StakeholderID = Convert.ToInt32(RACITable.Rows[i]["StakeholderID"]);
                    objRaciData.WBSID = Convert.ToInt32(RACITable.Rows[i]["WBSID"]);
                    objRaciData.Responsible = RACITable.Rows[i]["Responsible"].ToString();
                    objRaciData.Accountable = RACITable.Rows[i]["Accountable"].ToString();
                    objRaciData.Consulted = RACITable.Rows[i]["Consulted"].ToString();
                    objRaciData.Informed = RACITable.Rows[i]["Informed"].ToString();
                    listRaciData.Add(objRaciData);

                }
                var groupWBS = listRaciData.GroupBy(x => x.WBSID).ToList();
                var groupStakeholders = listRaciData.GroupBy(x => x.StakeholderID).ToList();


                DataTable SubProjectsTable;
                List<SubProjects> listSubProjects = new List<SubProjects>();
                SubProjectsTable = CommonFunctions.Data.GetDataTable(objSubProjects.ProcedureName + " " + objSubProjects.projectID.ToString() + " ", true, CommonController.connectionString);
                for (int i = 0; i < SubProjectsTable.Rows.Count; i++)
                {
                    SubProjects RA = new SubProjects();
                    RA.ID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(SubProjectsTable.Rows[i]["ID"], ""));
                    RA.Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(SubProjectsTable.Rows[i]["Name"], ""));
                    List<Stakeholder> listStakeholder = new List<Stakeholder>();

                    for (int j = 0; j < groupStakeholders.Count(); j++)
                    {
                        string[] RACI = new string[4];
                        Stakeholder objStakeholder = new Stakeholder();
                        objStakeholder.StakeholderID = groupStakeholders[j].Key;
                        var getRACI = listRaciData.Where(x => x.WBSID == RA.ID && x.StakeholderID == groupStakeholders[j].Key).FirstOrDefault();
                        if (getRACI != null)
                        {
                            if (getRACI.Responsible.ToLower() == "true")
                            {
                                RACI[0] = "1";
                            }
                            if (getRACI.Accountable.ToLower() == "true")
                            {
                                RACI[1] = "2";
                            }
                            if (getRACI.Consulted.ToLower() == "true")
                            {
                                RACI[2] = "3";
                            }
                            if (getRACI.Informed.ToLower() == "true")
                            {
                                RACI[3] = "4";
                            }
                        }
                        else
                        {
                            RACI[0] = "0";
                            RACI[1] = "0";
                            RACI[2] = "0";
                            RACI[3] = "0";
                        }

                        objStakeholder.RACI = RACI;
                        listStakeholder.Add(objStakeholder);
                    }
                    RA.listStakeholder = listStakeholder;
                    listSubProjects.Add(RA);
                }

                return listSubProjects;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion

        #region[SaveRACIProjectContacts]

        /// <summary>
        /// Created Date    :   18 July 2019
        /// Created By      :   Imran Mulla
        /// Purpose         :   Save Stakeholder Project Contacts
        /// </summary>
        /// <param name="raciparameters"></param>
        /// <returns></returns>
        //Added by imran on 16-09-2022
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveRacichartProjectContacts([FromBody] RaciParameters raciparameters)
        {
            try
            {
                int intProjectContactID = Convert.ToInt32(raciparameters.ProjectID);
                int intUserId = Convert.ToInt32(raciparameters.UserID);
                string CreatedBy = raciparameters.UserName;
                string ModifiedBy = raciparameters.UserName;
                string sql = "";
                foreach (var item in raciparameters.listRaciWbs)
                {

                    for (int i = 0; i < item.lisResources.Count(); i++)
                    {
                        var StakeholderID = item.lisResources[i].strResources;
                        var RACI = item.listRaci[i].strRaci;
                        string[] arrayRaci = RACI.Split(',');
                        var WBS = item.strWBS;
                        if (raciparameters.Type.ToLower() == "milestone")
                        {
                            sql = "usp_whizible2_ins_tbl_Racichart_ProjectContacts "
                                       + "' '" + ","
                                       + intProjectContactID + ","
                                       + StakeholderID + ","
                                       + WBS + ","
                                       + "' '" + ","
                                       + "' '" + ","
                                       + "' '" + ","
                                       + "' '" + ",'"
                                       + arrayRaci[0] + "','"
                                       + arrayRaci[1] + "','"
                                       + arrayRaci[2] + "','"
                                       + arrayRaci[3] + "',"
                                       + intUserId + ",'"
                                       + CreatedBy + "',"
                                       + "' '" + ",'"
                                       + ModifiedBy + "',"
                                       + "' '" + "";
                        }
                        else if (raciparameters.Type.ToLower() == "phase")
                        {
                            sql = "usp_whizible2_ins_tbl_Racichart_ProjectContacts "
                                       + "' '" + ","
                                       + intProjectContactID + ","
                                       + StakeholderID + ","
                                       + "''" + ","
                                       + WBS + ","
                                       + "' '" + ","
                                       + "' '" + ","
                                       + "' '" + ",'"
                                       + arrayRaci[0] + "','"
                                       + arrayRaci[1] + "','"
                                       + arrayRaci[2] + "','"
                                       + arrayRaci[3] + "',"
                                       + intUserId + ",'"
                                       + CreatedBy + "',"
                                       + "' '" + ",'"
                                       + ModifiedBy + "',"
                                       + "' '" + "";
                        }
                        else if (raciparameters.Type.ToLower() == "subprojects")
                        {
                            sql = "usp_whizible2_ins_tbl_Racichart_ProjectContacts "
                                       + "' '" + ","
                                       + intProjectContactID + ","
                                       + StakeholderID + ","
                                       + "''" + ","
                                       + "''" + ","
                                       + WBS + ","
                                       + "' '" + ","
                                       + "' '" + ",'"
                                       + arrayRaci[0] + "','"
                                       + arrayRaci[1] + "','"
                                       + arrayRaci[2] + "','"
                                       + arrayRaci[3] + "',"
                                       + intUserId + ",'"
                                       + CreatedBy + "',"
                                       + "' '" + ",'"
                                       + ModifiedBy + "',"
                                       + "' '" + "";
                        }
                        else if (raciparameters.Type.ToLower() == "deliverables")
                        {
                            sql = "usp_whizible2_ins_tbl_Racichart_ProjectContacts "
                                       + "' '" + ","
                                       + intProjectContactID + ","
                                       + StakeholderID + ","
                                       + "''" + ","
                                       + "''" + ","
                                       + "''" + ","
                                       + WBS + ","
                                       + "' '" + ",'"
                                       + arrayRaci[0] + "','"
                                       + arrayRaci[1] + "','"
                                       + arrayRaci[2] + "','"
                                       + arrayRaci[3] + "',"
                                       + intUserId + ",'"
                                       + CreatedBy + "',"
                                       + "' '" + ",'"
                                       + ModifiedBy + "',"
                                       + "' '" + "";
                        }
                        else if (raciparameters.Type.ToLower() == "module")
                        {
                            sql = "usp_whizible2_ins_tbl_Racichart_ProjectContacts "
                                       + "' '" + ","
                                       + intProjectContactID + ","
                                       + StakeholderID + ","
                                       + "''" + ","
                                       + "''" + ","
                                       + "''" + ","
                                       + "''" + ","
                                       + WBS + ",'"
                                       + arrayRaci[0] + "','"
                                       + arrayRaci[1] + "','"
                                       + arrayRaci[2] + "','"
                                       + arrayRaci[3] + "',"
                                       + intUserId + ",'"
                                       + CreatedBy + "',"
                                       + "' '" + ",'"
                                       + ModifiedBy + "',"
                                       + "' '" + "";
                        }

                        var result = CommonFunctions.Data.GetDataScalar(sql, true, CommonController.connectionString);
                        intProjectContactID = Convert.ToInt32(intProjectContactID);
                    }

                }

                return intProjectContactID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #endregion

        #region[ExportDocument]
        /// <summary>
        /// Created Date    :   22-08-2019
        /// Purpose         :   ExportDocument
        /// Author          :   Chandashekhar Salar=gar.
        /// </summary>
        /// <param name="pm_Wbs_Card"></param>
        /// <returns></returns>
        /// //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object ExportDocument([FromBody] SubProjects rptRacichart)
        {
            try
            {
                string strSQL;
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = rptRacichart.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                strSQL = "usp_Whizible2_sel_tbl_whizible2_racichart_Report  " + rptRacichart.projectID.ToString() + "," + rptRacichart.Type + ", '" + rptRacichart.StakeholderType + "' ";
                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                m_lngReportID = 22280;
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

        #region[GetProject]
        /// <summary>
        /// Created Date    :   29 July 2019
        /// Purpose         :   GetProject
        /// <returns></returns>
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        //public List<FillProjectParameters> GetProjectDropDown([FromBody] defaultFilterParameters parameters)
        public object GetProjectDropDown([FromBody] defaultFilterParameters parameters)

        {
            try
            {
                DataTable FillProjectDatatable;
                List<FillProjectParameters> listProjectName = new List<FillProjectParameters>();
                FillProjectDatatable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee_Stakeholders "
                                                                                + HttpUtility.UrlDecode(parameters.UserID.ToString()) + ","
                                                                                     + HttpUtility.UrlDecode(parameters.ProjectID.ToString()) + "",
                                                                                     true, CommonController.connectionString);
                foreach (DataRow dr in FillProjectDatatable.Rows)
                {
                    FillProjectParameters CC = new FillProjectParameters()
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

        }

}
