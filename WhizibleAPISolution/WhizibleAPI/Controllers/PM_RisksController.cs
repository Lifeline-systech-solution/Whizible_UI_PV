using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models;
using WhizibleAPI.Models.PM;
using System.Configuration;
using System.Xml;
using System.IO;
using Newtonsoft.Json;
using System.Runtime.InteropServices;

namespace WhizibleAPI.Controllers
{
    public class PM_RisksController : ApiController
    {
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetTabAccess([FromBody] AccessParameter accessParameters)
        {
            try
            {
                string strSQL = "usp_Sel_tbl_UserAccess " + HttpUtility.UrlDecode(Convert.ToString(accessParameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(accessParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(accessParameters.UserID)) + ",'" + HttpUtility.UrlDecode(accessParameters.LoginType) + "'";

                object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return TabAccess;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetProjectQuery> GetProjectID([FromBody] PMParameter Parameters)
        public object GetProjectID([FromBody] PMParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "";

                if (Parameters.ProjectId == 0)
                {
                    strSQL = strSQL + ", 0, 0, NULL, 1, '" + HttpUtility.UrlDecode(Parameters.LoginType) + "', 1, 0, 0, 0, NULL, NULL";
                }
                else
                {
                    strSQL = strSQL + ", 0, 0, NULL, 1, '" + HttpUtility.UrlDecode(Parameters.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));
                }

                DataTable projectListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetProjectQuery> ProjectLists = new List<GetProjectQuery>();

                foreach (DataRow projList in projectListTable.Rows)
                {
                    GetProjectQuery projListQuery = new GetProjectQuery()
                    {
                        ProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projList["ProjectID"], "0")),
                        ProjectName = CommonFunctions.Data.CheckIsDBNull(projList["ProjectName"], "").ToString(),
                    };
                    ProjectLists.Add(projListQuery);
                }
                return ProjectLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetProjectResponsiblePerson> GetResponsiblePerson([FromBody]PMParameter Parameters)
        public object GetResponsiblePerson([FromBody] PMParameter Parameters)

        {
            try
            {
                string strSQL = "";

                if (Parameters.RiskID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_Risks_PersonResponsible " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_Risks_PersonResponsible " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + ", '" + HttpUtility.UrlDecode(Parameters.Parameter) + "'";
                }
                DataTable projectRespPersonTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetProjectResponsiblePerson> RespPersonLists = new List<GetProjectResponsiblePerson>();

                foreach (DataRow projRespPersonList in projectRespPersonTable.Rows)
                {
                    GetProjectResponsiblePerson projRespPersonListQuery = new GetProjectResponsiblePerson()
                    {
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projRespPersonList["EmployeeID"], "0")),
                        UserName = CommonFunctions.Data.CheckIsDBNull(projRespPersonList["UserName"], "").ToString(),
                    };
                    RespPersonLists.Add(projRespPersonListQuery);
                }
                return RespPersonLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object ExportToReport([FromBody] PMReportParameter Parameters)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName = "";
                long m_lngRiskReportID = 749;
                long m_lngFilterRisksReportID = 22278;
                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                string ProjectId = HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                string CompanyName = "";
                int DateFormatID = 0;
                AdHocReports.Report.AdHocReport oRpt;
                IDataReader drReport;
                if (Parameters.RiskID == 0)
                {
                    strSQL = "Usp_Whizible2_Sel_tbl_PM_Project_Risks " + ProjectId;

                    if (Parameters.RiskCategoryId == 0)
                    {
                        strSQL += ", NULL";
                    }
                    else
                    {
                        strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskCategoryId)) + "";
                    }

                    if (Parameters.Status == "")
                    {
                        strSQL += ", NULL";
                    }
                    else
                    {
                        strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Status) + "'";
                    }

                    if (Parameters.StaticFilter == "")
                    {
                        strSQL += ", NULL, NULL, NULL, NULL";
                    }
                    else
                    {
                        strSQL += ", 0, NULL, NULL";
                        strSQL += ", '" + HttpUtility.UrlDecode(Parameters.StaticFilter) + "'";
                    }
                    if (Parameters.WhereClause != "")
                    {
                        strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + ProjectId;
                        strSQL = strSQL + ", NULL";
                        strSQL = strSQL + ", NULL";
                        strSQL = strSQL + ", 1";  //Filter Flag
                        strSQL = strSQL + ",'" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    }
                }
                else
                {
                    strSQL = "usp_CRW_Risks_Main " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID));
                }
                drReport = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drReport.Read())
                {
                    CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                    CommonEngines.HashTables.Culture.FillCultureHashTable();
                    strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                    m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                    switch (Parameters.ReportFormat)
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

                    if (Parameters.RiskID == 0)
                    {
                        oRpt = new AdHocReports.Report.AdHocReport(m_lngFilterRisksReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));
                    }
                    else
                    {
                        oRpt = new AdHocReports.Report.AdHocReport(m_lngRiskReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));
                    }
                    oRpt.UseMSSQL = true;
                    oRpt.DefaultLCID = lngDefaultLCID;
                    oRpt.LCID = lngCurrentThreadUICultureID;

                    oRpt.UseHashTables = true;

                    oRpt.DateFormat = DateFormatID;
                    oRpt.CompanyName = CompanyName;
                    oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");
                    AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;

                    switch (Parameters.ReportFormat)
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

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetSelectedProjectRisks> GetRiskDetails([FromBody] PMFilterParameter Parameters)
        public object GetRiskDetails([FromBody] PMFilterParameter Parameters)

        {
            try
            {
                string strSQL = "";
                if (Parameters.Flag == "0" && Parameters.RiskID == 0 && Parameters.StatusText == "")
                {
                    if (Parameters.RiskCategoryId != 0 && Parameters.Status != "")
                    {
                        strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskCategoryId)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.Status)) + "'";
                    }
                    if (HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskCategoryId)) == "0" && HttpUtility.UrlDecode(Parameters.Status) == "")
                    {
                        strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + Parameters.ProjectId;
                    }
                    if (HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskCategoryId)) != "0" && HttpUtility.UrlDecode(Parameters.Status) == "")
                    {
                        strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskCategoryId)) + ",NULL";
                    }
                    if (HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskCategoryId)) == "0" && HttpUtility.UrlDecode(Parameters.Status) != "")
                    {
                        strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId)) + ",NULL,'" + HttpUtility.UrlDecode(Parameters.Status) + "'";
                    }
                }
                else if (Parameters.Flag == "0" && Parameters.RiskID != 0 && Parameters.StatusText == "")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + Parameters.ProjectId + ", NULL, NULL, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID));
                }
                else if (Parameters.Flag == "0" && Parameters.RiskID == 0 && Parameters.StatusText != "")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + Parameters.ProjectId + ", NULL, NULL, 0, NULL, NULL, '" + HttpUtility.UrlDecode(Parameters.StatusText) + "'";
                }
                else
                {
                    strSQL = strSQL + "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));
                    strSQL = strSQL + ", NULL";
                    strSQL = strSQL + ", NULL";
                    strSQL = strSQL + ", 1";  //Filter Flag
                    strSQL = strSQL + ",'" + HttpUtility.UrlDecode(Parameters.ProjectRiskWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }

                DataTable RiskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetSelectedProjectRisks> RiskDetails = new List<GetSelectedProjectRisks>();

                foreach (DataRow RiskList in RiskListTable.Rows)
                {
                    GetSelectedProjectRisks QueryRiskDtl = new GetSelectedProjectRisks()
                    {
                        ProjectRiskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskList["ProjectRiskID"], "0")),
                        RiskSourceId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskList["RiskSourceId"], "0")),
                        IsTaskAssigned = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(RiskList["IsTaskAssigned"], "false")),
                        RiskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskList["RiskID"], "0")),
                        Description = CommonFunctions.Data.CheckIsDBNull(RiskList["Description"], "").ToString(),
                        DateIdentified = CommonFunctions.Data.CheckIsDBNull(RiskList["DateIdentified"], "").ToString(),
                        RiskCategory = CommonFunctions.Data.CheckIsDBNull(RiskList["RiskCategory"], "").ToString(),
                        Probability = CommonFunctions.Data.CheckIsDBNull(RiskList["Probability"], "").ToString(),
                        Weight = CommonFunctions.Data.CheckIsDBNull(RiskList["Weight"], "").ToString(),
                        Severity = CommonFunctions.Data.CheckIsDBNull(RiskList["Severity"], "").ToString(),
                        Status = CommonFunctions.Data.CheckIsDBNull(RiskList["Status"], "").ToString(),
                        PersonResponsible = CommonFunctions.Data.CheckIsDBNull(RiskList["PersonResponsible"], "").ToString(),
                        PersonResponsibleId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskList["ResponsiblePersonID"], "0")),
                        ReviewerId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskList["ReviewerID"], "0")),
                        ReviewNotificationDate = CommonFunctions.Data.CheckIsDBNull(RiskList["ReviewNotificationDate"], "").ToString(),
                        ShowReport = CommonFunctions.Data.CheckIsDBNull(RiskList["Show Report"], "").ToString(),
                        RiskCategoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskList["RiskCategoryID"], "0")),
                        OriginalPriority = CommonFunctions.Data.CheckIsDBNull(RiskList["OriginalPriority"], "").ToString(),
                        ChangePriority = CommonFunctions.Data.CheckIsDBNull(RiskList["ChangePriority"], "").ToString(),
                        Notes = CommonFunctions.Data.CheckIsDBNull(RiskList["Notes"], "").ToString(),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskList["ProjectID"], "0")),
                        RiskSource = CommonFunctions.Data.CheckIsDBNull(RiskList["RiskSource"], "").ToString(),
                    };
                    RiskDetails.Add(QueryRiskDtl);
                }
                return RiskDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //public List<GetCompanyDetails> GetCompayInformation()
        public object GetCompayInformation()

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";

                DataTable compInfoListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetCompanyDetails> compInfoLists = new List<GetCompanyDetails>();

                foreach (DataRow compInfoList in compInfoListTable.Rows)
                {
                    GetCompanyDetails compInfoListQuery = new GetCompanyDetails()
                    {
                        RestrictByMinHours = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(compInfoList["RestrictByMinHours"], "0")),
                        MinHoursForDAEntry = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(compInfoList["MinHoursForDAEntry"], "0.0")),
                    };
                    compInfoLists.Add(compInfoListQuery);
                }
                return compInfoLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveFilterDetails([FromBody] ApplyFilterParameter Parameters)
        {
            try
            {
                string strSQL = "";

                if (Parameters.FilterID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", NULL";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));
                }
                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To Save Project Risk Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveRiskDetails([FromBody] GetSelectedProjectRisks Parameters)
        {
            try
            {
                string strSQL = "";


                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_Project_Risks " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectRiskID)) + ",'" + HttpUtility.UrlDecode(Parameters.Description).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                if (Parameters.Notes == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Notes).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                }

                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskCategoryID)) + "";

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.DateIdentified) + "'";

                if (Parameters.OriginalPriority == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.OriginalPriority) + "'";
                }

                if (Parameters.ChangePriority == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.ChangePriority) + "'";
                }

                if (Parameters.Probability == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Probability) + "'";
                }
                if (Parameters.Weight == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Weight) + "'";
                }
                if (Parameters.Severity == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Severity) + "'";
                }
                if (Parameters.RiskSourceId == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskSourceId)) + "";
                }

                strSQL += ", '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.Status)) + "'";

                if (Parameters.PersonResponsible == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.PersonResponsible) + "'";
                }

                if (Parameters.PersonResponsibleId == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.PersonResponsibleId)) + "";
                }

                if (Parameters.ReviewerId == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReviewerId)) + "";
                }

                if (Parameters.ReviewNotificationDate == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.ReviewNotificationDate) + "'";
                }

                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "";

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.UserName) + "'";

                if (Parameters.RiskID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "";
                }
                //+ "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To Save Project Risk Plan Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SavePlanDetails([FromBody] PMContingencyPlanParameter Parameters)
        {
            try
            {
                string strSQL = "";


                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_ContingencyPlans " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Parameters.ContingencyPlan).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.Responsibility) + "','" + HttpUtility.UrlDecode(Parameters.TaskType) + "'";

                if (Parameters.DateOfPlan == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.DateOfPlan) + "'";
                }

                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ExpectedDuration)) + "";

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.ExpectedWork) + "'";

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.UserName) + "'";

                if (Parameters.ContingencyPlanID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ContingencyPlanID)) + "";
                }

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To Save Risk Early Warnings Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveRiskEarlyWarningsDetails([FromBody] PMEarlyWarningsParameter Parameters)
        {
            try
            {
                string strSQL = "";


                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_EarlyWarnings " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + ",'" + HttpUtility.UrlDecode(Parameters.Warning).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.WarningStatus).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EarlyWarningFlag));

                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "";

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.UserName) + "'";

                if (Parameters.WarningID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.WarningID)) + "";
                }

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To Save Project Risk Plan Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveContingencyPlanTaskDetails([FromBody] PMPlanParameter Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_ProjectTasks_ContingencyPlans " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "";

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveMitigationPlanDetails([FromBody] PMMitigationPlanParameter Parameters)
        {
            try
            {
                string strSQL = "";


                strSQL = "Exec Usp_Whizible2_Ins_tbl_PM_MitigationPlans " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Parameters.Action).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";

                if (Parameters.Responsibility == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Responsibility) + "'";
                }

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.TaskType) + "'";

                if (Parameters.DateOfPlan == "")
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", '" + HttpUtility.UrlDecode(Parameters.DateOfPlan) + "'";
                }

                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ExpectedDuration)) + "";

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.ExpectedWork) + "'";

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.UserName) + "'";

                if (Parameters.MitigationPlanID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.MitigationPlanID)) + "";
                }

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object chkFilterExists([FromBody] ApplyFilterParameter Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists '" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID));

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<MyFilterParameter> GetMyFilters([FromBody] ApplyFilterParameter Parameters)
        public object GetMyFilters([FromBody] ApplyFilterParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",'" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID));

                DataTable myFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<MyFilterParameter> myFilterLists = new List<MyFilterParameter>();

                foreach (DataRow myFilterList in myFilterListTable.Rows)
                {
                    MyFilterParameter myFilterListQuery = new MyFilterParameter()
                    {
                        FilterId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterId"], "0")),
                        FilterName = CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterName"], "").ToString(),
                        SetDefault = CommonFunctions.Data.CheckIsDBNull(myFilterList["SetDefault"], "").ToString(),
                        QueryText = CommonFunctions.Data.CheckIsDBNull(myFilterList["QueryText"], "").ToString(),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(myFilterList["EmployeeID"], "0")),
                    };
                    myFilterLists.Add(myFilterListQuery);
                }
                return myFilterLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Risk Matrix Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetRiskMatrixDetails> GetRiskMatrix([FromBody]PMParameter Parameters)
        public object GetRiskMatrix([FromBody] PMParameter Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Get_RiskMatrix_ProjectPulse " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));

                DataTable RiskMatrixListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetRiskMatrixDetails> RiskMatrixLists = new List<GetRiskMatrixDetails>();

                foreach (DataRow RiskMatrixList in RiskMatrixListTable.Rows)
                {
                    GetRiskMatrixDetails RiskMatrixListQuery = new GetRiskMatrixDetails()
                    {
                        Probability = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskMatrixList["Probability"], "0")),
                        Impact = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskMatrixList["Impact"], "0")),
                        RiskCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskMatrixList["RiskCount"], "0")),
                    };
                    RiskMatrixLists.Add(RiskMatrixListQuery);
                }
                return RiskMatrixLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Risk History Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetHistoryDetails> GetRiskHistory([FromBody] PMHistoryParameter Parameters)
        public object GetRiskHistory([FromBody] PMHistoryParameter Parameters)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_Project_Risks_History " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID));

                DataTable RiskHistoryListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetHistoryDetails> RiskHistoryLists = new List<GetHistoryDetails>();

                foreach (DataRow RiskHistoryList in RiskHistoryListTable.Rows)
                {
                    GetHistoryDetails RiskHistoryListQuery = new GetHistoryDetails()
                    {
                        FieldName = CommonFunctions.Data.CheckIsDBNull(RiskHistoryList["FieldName"], "").ToString(),
                        Date = CommonFunctions.Data.CheckIsDBNull(RiskHistoryList["Date"], "").ToString(),
                        Value = CommonFunctions.Data.CheckIsDBNull(RiskHistoryList["Value"], "").ToString(),
                        NewValue = CommonFunctions.Data.CheckIsDBNull(RiskHistoryList["NewValue"], "").ToString(),
                        ModifiedBy = CommonFunctions.Data.CheckIsDBNull(RiskHistoryList["ModifiedBy"], "").ToString(),
                        Details = CommonFunctions.Data.CheckIsDBNull(RiskHistoryList["Details"], "").ToString()
                    };
                    RiskHistoryLists.Add(RiskHistoryListQuery);
                }
                return RiskHistoryLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Risk Plan Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetPlanDetails> GetRiskPlans([FromBody]PMPlanParameter Parameters)
        public object GetRiskPlans([FromBody] PMPlanParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ContingencyPlans " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID));

                DataTable RiskPlansListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetPlanDetails> RiskPlansLists = new List<GetPlanDetails>();

                foreach (DataRow RiskPlansList in RiskPlansListTable.Rows)
                {
                    GetPlanDetails RiskPlansListQuery = new GetPlanDetails()
                    {
                        ContingencyPlanID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskPlansList["ContingencyPlanID"], "0")),
                        ContingencyPlan = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["ContingencyPlan"], "").ToString(),
                        Responsibility = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["Responsibility"], "").ToString(),
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskPlansList["TaskID"], "0")),
                        TaskType = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["TaskType"], "").ToString(),
                        DateOfPlan = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["DateOfPlan"], "").ToString(),
                        ExpectedDuration = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskPlansList["ExpectedDuration"], "0")),
                        ExpectedWork = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["ExpectedWork"], "").ToString(),
                        EmployeeName = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["EmployeeName"], "").ToString(),
                        AssignTask = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["Hyperlink1"], "").ToString()
                    };
                    RiskPlansLists.Add(RiskPlansListQuery);
                }
                return RiskPlansLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Risk Early Warning Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetEarlyWarningsDetails> GetRiskEarlyWarning([FromBody] PMEarlyWarningsParameter Parameters)
        public object GetRiskEarlyWarning([FromBody] PMEarlyWarningsParameter Parameters)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_PM_EarlyWarnings " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID));
                if (Parameters.WarningID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.WarningID)) + "";
                }
                DataTable RiskPlansListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetEarlyWarningsDetails> RiskPlansLists = new List<GetEarlyWarningsDetails>();

                foreach (DataRow RiskPlansList in RiskPlansListTable.Rows)
                {
                    GetEarlyWarningsDetails RiskPlansListQuery = new GetEarlyWarningsDetails()
                    {
                        WarningID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskPlansList["WarningID"], "0")),
                        RiskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskPlansList["RiskID"], "0")),
                        Warning = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["Warning"], "").ToString(),
                        WarningStatus = CommonFunctions.Data.CheckIsDBNull(RiskPlansList["WarningStatus"], "").ToString(),
                        EarlyWarningFlag = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskPlansList["EarlyWarningFlag"], "0")),
                    };
                    RiskPlansLists.Add(RiskPlansListQuery);
                }
                return RiskPlansLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Risk Discussion Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetDiscussions> GetRiskDiscussions([FromBody]PMDiscussionsParameter Parameters)
        public object GetRiskDiscussions([FromBody] PMDiscussionsParameter Parameters)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_Risk_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID));

                DataTable DiscussionsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetDiscussions> DiscussionsLists = new List<GetDiscussions>();

                foreach (DataRow DiscussionsList in DiscussionsListTable.Rows)
                {
                    GetDiscussions DiscussionsListQuery = new GetDiscussions()
                    {
                        RiskDiscussionID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["RiskDiscussionID"], "0")),
                        RiskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["RiskID"], "0")),
                        ParentID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ParentID"], "0")),
                        LoginID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["LoginID"], "0")),
                        ReplyIndex = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ReplyIndex"], "0")),
                        IsShowToCustomer = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["IsShowToCustomer"], "0")),
                        DiscussionThread = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionThread"], "").ToString(),
                        SubmittedBy = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["SubmittedBy"], "").ToString(),
                        SubmittedDate = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["SubmittedDate"], "").ToString(),
                        LoginType = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["LoginType"], "").ToString(),
                        ReplyCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ReplyCount"], "0")),
                        DiscussionLevel = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionLevel"], "").ToString(),
                    };
                    DiscussionsLists.Add(DiscussionsListQuery);
                }
                return DiscussionsLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Get Discussion Reply Count

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetDiscussionReplyCount([FromBody] PMDiscussionsParameter Parameters)
        {
            try
            {
                string strSQL;

                strSQL = "Exec Usp_Whizible2_Sel_Risk_DiscussionReplyCount " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskDiscussionID)) + "";

                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Save Risk Discussion Details

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDiscussion([FromBody] PMDiscussionsParameter Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_Risk_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";


                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Document List
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetDocumentList([FromBody] PMDocumentParameter Parameters)
        {
            try
            {   //Commented and Modified By RehanC for parameter mismatch issue on 6th April 2023
                //string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.PMParam.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.PMParam.RoleID));
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID));
                //End of Comment By RehanC for parameter mismatch issue on 6th April 2023
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Document Category List
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetDocumentCategoryList([FromBody] PMParameter Parameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentCategory_ForRole " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Document Sub Category List
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetDocumentSubCategoryList([FromBody] RiskDocument Parameters)
        {
            try
            {
                //Commented and Modified By RehanC for parameter mismatch issue on 12th April 2023
                //string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentSubCategory " + HttpUtility.UrlDecode(Convert.ToString(Parameters.Category)) + ", null ," + HttpUtility.UrlDecode(Convert.ToString(Parameters.PMParam.ProjectId));
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentSubCategory " + HttpUtility.UrlDecode(Convert.ToString(Parameters.Category)) + ", null ," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));
                //End of Comment By RehanC By RehanC on 12th April 2023
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //insert Document Attachment

        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertDocumentAttachment()
        {
            try
            {
                string msg = "";
                if (GetFileType())
                {
                    var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];
                    //var listAttachedDocuments = JsonConvert.DeserializeObject<List<WhizibleAPI.Models.Stakeholder.AttachedFileData>>(AttachedFileData);
                    var listAttachedDocuments = JsonConvert.DeserializeObject<List<RiskDocument>>(AttachedFileData);
                    for (int i = 0; i < listAttachedDocuments.Count; i++)
                    {
                        var httpPostedFile = HttpContext.Current.Request.Files[i];
                        var Category = listAttachedDocuments[i].Category;
                        var ProjectID = listAttachedDocuments[i].PMParam.ProjectId;
                        int SubCategory = listAttachedDocuments[i].SubCategory;
                        string DirectoryName;
                        if (SubCategory != 0)
                        {
                            DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName + "\\" + listAttachedDocuments[i].SubCategoryName;
                        }
                        else
                        {
                            DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName;
                        }

                        var description = listAttachedDocuments[i].Description;
                        var CreatedDate = DateTime.Now;
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        float FileSize = httpPostedFile.ContentLength;
                        FileSize = FileSize / 1024;
                        string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                        FileExtention = FileExtention.Replace(".", "");
                        string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);
                        int UserId = listAttachedDocuments[i].PMParam.EmployeeID;
                        string LoginType = listAttachedDocuments[i].PMParam.LoginType;

                        int TagID = listAttachedDocuments[i].PMParam.TagID;
                        int PhaseId = listAttachedDocuments[i].PMDocumentParam.RiskID;
                        string strCodeTemplate = "SETPL/" + listAttachedDocuments[i].CategoryName + "_/<Job Code>/<Serial Number>";
                        string categoryName = listAttachedDocuments[i].CategoryName;
                        string subcategoryName = listAttachedDocuments[i].SubCategoryName;
                        var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                        DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\SETPL_WHIZ_SM_-0208");

                        string dir = DirectoryPath + categoryName + "\\" + subcategoryName;
                        if (!Directory.Exists(dir))
                        {
                            DirectoryInfo di = Directory.CreateDirectory(dir);
                        }

                        string ChangeRequestID = "NULL";

                        //var fileName = httpPostedFile.FileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                        var fileName = httpPostedFile.FileName;
                        //var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);

                        var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);

                        filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);
                        httpPostedFile.SaveAs(filePath);
                        string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(PhaseId.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                        msg = "file save successfully";
                    }
                }
                else
                {
                    //msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                    msg = "Please upload valid file.";
                }
                return msg;
            }
            catch (Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            public bool GetFileType()
        {
            bool fileUploadFlag = false;
            string MimeType = "";
            string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                {
                    //               Stream xmlStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //               Stream txtStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //               string filePath = System.Web.HttpContext.Current.Request.Files[filecount].FileName;
                    //               string filename = Path.GetFileName(filePath);
                    //               string ext = Path.GetExtension(filename);
                    //ext = ext.Substring(1, ext.Length - 1);
                    //               string contenttype = String.Empty;
                    //               Stream checkStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                    //               BinaryReader chkBinary = new BinaryReader(checkStream);
                    //               Byte[] chkbytes = chkBinary.ReadBytes(0x10);
                    //               string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    //               string magicNumber = BitConverter.ToString(chkbytes);
                    //               string magicCheck = magicNumber.Substring(0, 11);
                    //               magicNumber = magicNumber.Replace("-", " ");
                    //               magicCheck = magicCheck.Replace("-", " ");
                    //               XmlDocument xmlDoc = new XmlDocument();                    
                    //               string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                    //               xmlDoc.Load(xmlPath + "MIMEType.xml");
                    //               XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                    //               string xMagicNumber = "";
                    //               for (int i = 0; i < nodes.Count; i++)
                    //               {
                    //                   xMagicNumber = nodes[i].SelectSingleNode("MagicNumber").InnerText;
                    //                   int strlength = xMagicNumber.Length;

                    //                   if (xMagicNumber.IndexOf(magicCheck) != -1 || magicCheck.IndexOf(xMagicNumber) != -1)
                    //                   {
                    //                       MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                    //                       fileUploadFlag = true;
                    //                       break;
                    //                   }
                    //                   else
                    //                   {
                    //                       if (ext == xMagicNumber)
                    //                       {
                    //                           MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                    //                           fileUploadFlag = false;
                    //                       }
                    //                   }
                    //               }

                    string fileName = HttpContext.Current.Request.Files[filecount].FileName;
                    string fileName1 = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, true, true, true);
                    string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                    string ValidateFileName = ConfigurationManager.AppSettings["ValidateFileName"];
                    string[] CharList;
                    CharList = ValidateFileName.Split(',');
                    for (int i = 0; i <= CharList.Length - 1; i++)
                    {
                        if (fileName.Contains(CharList[i].ToString()))
                        {
                            fileName1 = fileName1.Replace(CharList[i].ToString(), "");
                        }
                    }
                    int IsFileValid = 1;
                    string[] extensionList;
                    extensionList = fileName.Split('.');
                    if (extensionList.Length > 2)
                    {
                        IsFileValid = 0;
                    }
                    if (fileName == fileName1 && IsFileValid == 1)
                    {
                        string ContentType = String.Empty;
                        byte[] buffer = new byte[257];
                        //string MimeType = "";
                        HttpPostedFile file = System.Web.HttpContext.Current.Request.Files[filecount];
                        //var strFileType = "";
                        var strFileType = getMimeFromFile(HttpContext.Current.Request.Files[filecount]);
                        file.InputStream.Read(buffer, 0, 256);
                        file.InputStream.Position = 0;
                        string magicNumber = BitConverter.ToString(buffer);
                        magicNumber = magicNumber.Replace("-", " ");
                        XmlDocument xmlDoc = new XmlDocument();
                        string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                        xmlDoc.Load(xmlPath + "MIMEType.xml");
                        XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                        string xMagicNumber = "";
                        string xContentType = "";
                        string extfromContentType = "";

                        // Added by imran on 02-01-2023
                        //string fileNameExtention = HttpContext.Current.Request.Files[filecount].FileName;
                        //string ext1 = Path.GetExtension(fileNameExtention);
                        //int count = ext1.Split('.').Length - 1;
                        //int count2 = fileNameExtention.Split('.').Length - 1;
                        //if (count > 1)
                        //{
                        //    MimeType = "";
                        //}
                        // End of comment by imran on 02-01-2022

                        //if (count == 1 && count2 == 1)
                        //{
                            foreach (XmlNode node in nodes)
                            {
                                xContentType = node.SelectSingleNode("ContentType").InnerText;
                                if (strFileType == xContentType)
                                {
                                    fileName = HttpContext.Current.Request.Files[filecount].FileName;
                                    string ext = Path.GetExtension(fileName);
                                    ext = ext.Substring(1, ext.Length - 1).ToLower();
                                    extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower();
                                    if (extfromContentType.IndexOf(ext) > -1)
                                    {
                                        MimeType = strFileType;
                                        break;
                                    }
                                }
                            }
                        //}
                    }
                    else
                    {
                        MimeType = "";
                    }

                    if (MimeType == "" || MimeType == null)
                    {
                        MimeType = "unknown/unknowns";
                        fileUploadFlag = false;
                    }
                    if (strListofTypes.IndexOf(MimeType) > -1)
                    {
                        fileUploadFlag = true;
                    }
                    else
                    {
                        fileUploadFlag = false;
                        break;
                    }
                }
            }

            return fileUploadFlag;
        }

        [DllImport("urlmon.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = false)]
        static extern int FindMimeFromData(IntPtr pBC, [MarshalAs(UnmanagedType.LPWStr)] string pwzUrl, [MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.I1, SizeParamIndex = 3)] byte[] pBuffer, int cbSize, [MarshalAs(UnmanagedType.LPWStr)] string pwzMimeProposed, int dwMimeFlags, out IntPtr ppwzMimeOut, int dwReserved);

        [System.Security.SecuritySafeCritical()]
        public static string getMimeFromFile(HttpPostedFile file)
        {
            IntPtr mimeout; int MaxContent = (int)file.ContentLength;
            if (MaxContent > 200)
                MaxContent = 200;
            byte[] buf = new byte[MaxContent];
            file.InputStream.Read(buf, 0, MaxContent);
            int result = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, null, 0, out mimeout, 0);
            if (result != 0)
            {
                Marshal.FreeCoTaskMem(mimeout); return "";
            }
            string mime = Marshal.PtrToStringUni(mimeout);
            Marshal.FreeCoTaskMem(mimeout); return mime.ToLower();
        }
        //delete risk Document 
        //Added By RehanC on 12th April 2023
        [Authorize, App_Start.ValidateHeaders]
        //End of Comment By RehanC on 12 April 2023
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteRiskDocument([FromBody] int DocumentId)
        {
            string strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(DocumentId));

            object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

            return dt;
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetMitigationPlanDetails> GetRiskMitigationPlans([FromBody] PMPlanParameter Parameters)
        public object GetRiskMitigationPlans([FromBody] PMPlanParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_MitigationPlans " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID));

                DataTable RiskMitigationPlansListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetMitigationPlanDetails> RiskMitigationPlansLists = new List<GetMitigationPlanDetails>();

                foreach (DataRow RiskMitigationPlansList in RiskMitigationPlansListTable.Rows)
                {
                    GetMitigationPlanDetails RiskMitigationPlansListQuery = new GetMitigationPlanDetails()
                    {
                        MitigationPlanID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["MitigationPlanID"], "0")),
                        Action = CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["Action"], "").ToString(),
                        Responsibility = CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["Responsibility"], "").ToString(),
                        TaskID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["TaskID"], "0")),
                        TaskType = CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["TaskType"], "").ToString(),
                        DateOfPlan = CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["DateOfPlan"], "").ToString(),
                        ExpectedDuration = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["ExpectedDuration"], "0")),
                        ExpectedWork = CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["ExpectedWork"], "").ToString(),
                        EmployeeName = CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["EmployeeName"], "").ToString(),
                        AssignTask = CommonFunctions.Data.CheckIsDBNull(RiskMitigationPlansList["Hyperlink1"], "").ToString()
                    };
                    RiskMitigationPlansLists.Add(RiskMitigationPlansListQuery);
                }
                return RiskMitigationPlansLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Validate Date of Plan Falls Between Project Start-End Date
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object ValidateDateOfPlan([FromBody] PMContingencyPlanParameter Parameters)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Chk_DateOfPlan_FallsBetween_Project_StartEndDate " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Parameters.DateOfPlan) + "'";

                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Task Types
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetPlanDetails> GetProjectTaskTypes([FromBody]PMTaskTypeParameter Parameters)
        public object GetProjectTaskTypes([FromBody] PMTaskTypeParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_TaskTypes_Name " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.GetDefaultTaskType));

                DataTable RiskPMTaskTypeListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetPlanDetails> RiskPMTaskTypeLists = new List<GetPlanDetails>();

                foreach (DataRow RiskPMTaskTypeList in RiskPMTaskTypeListTable.Rows)
                {
                    GetPlanDetails RiskPMTaskTypListQuery = new GetPlanDetails()
                    {
                        //TaskTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(RiskPMTaskTypeList["TaskTypeID"], "0")),
                        TaskType = CommonFunctions.Data.CheckIsDBNull(RiskPMTaskTypeList["TaskType"], "").ToString(),
                    };
                    RiskPMTaskTypeLists.Add(RiskPMTaskTypListQuery);
                }
                return RiskPMTaskTypeLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Modules
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetModuleDetails> GetProjectModules([FromBody] PMModuleParameter Parameters)
        public object GetProjectModules([FromBody] PMModuleParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Module_Details " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                if (Parameters.ModuleID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ModuleID)) + "";
                }

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Mode) + "'";

                if (Parameters.TaskID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID)) + "";
                }

                DataTable ModuleListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetModuleDetails> ModuleLists = new List<GetModuleDetails>();

                foreach (DataRow ModuleList in ModuleListTable.Rows)
                {
                    GetModuleDetails ModuleListQuery = new GetModuleDetails()
                    {
                        ModuleID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ModuleList["ModuleID"], "0")),
                        ModuleName = CommonFunctions.Data.CheckIsDBNull(ModuleList["ModuleName"], "").ToString(),
                    };
                    ModuleLists.Add(ModuleListQuery);
                }
                return ModuleLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Sub Project Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetSubProjectDetails> GetSubProjectDetails([FromBody]PMSubProjectParameter Parameters)
        public object GetSubProjectDetails([FromBody] PMSubProjectParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_SubProject_Details " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                if (Parameters.SubProjectID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.SubProjectID)) + "";
                }

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Mode) + "'";

                if (Parameters.TaskID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID)) + "";
                }

                DataTable SubProjectListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetSubProjectDetails> SubProjectLists = new List<GetSubProjectDetails>();

                foreach (DataRow SubProjectList in SubProjectListTable.Rows)
                {
                    GetSubProjectDetails SubProjectListQuery = new GetSubProjectDetails()
                    {
                        SubProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(SubProjectList["SubProjectID"], "0")),
                        SubProjectName = CommonFunctions.Data.CheckIsDBNull(SubProjectList["SubProjectName"], "").ToString(),
                    };
                    SubProjectLists.Add(SubProjectListQuery);
                }
                return SubProjectLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Milestone Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetMilestoneDetails> GetMilestoneDetails([FromBody] PMMilestoneParameter Parameters)
        public object GetMilestoneDetails([FromBody] PMMilestoneParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Milestone_Details " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                strSQL += ", '" + HttpUtility.UrlDecode(Parameters.Mode) + "'";

                if (Parameters.TaskID == 0)
                {
                    strSQL += ", NULL";
                }
                else
                {
                    strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TaskID)) + "";
                }

                DataTable MilestoneListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetMilestoneDetails> MilestoneLists = new List<GetMilestoneDetails>();

                foreach (DataRow MilestoneList in MilestoneListTable.Rows)
                {
                    GetMilestoneDetails MilestoneListQuery = new GetMilestoneDetails()
                    {
                        MilestoneID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(MilestoneList["MilestoneID"], "0")),
                        Milestone = CommonFunctions.Data.CheckIsDBNull(MilestoneList["Milestone"], "").ToString(),
                    };
                    MilestoneLists.Add(MilestoneListQuery);
                }
                return MilestoneLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Change Request Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetChangeRequestDetails> GetChangeRequestDetails([FromBody] PMChangeRequestParameter Parameters)
        public object GetChangeRequestDetails([FromBody] PMChangeRequestParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                DataTable ChangeRequestListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetChangeRequestDetails> ChangeRequestLists = new List<GetChangeRequestDetails>();

                foreach (DataRow ChangeRequestList in ChangeRequestListTable.Rows)
                {
                    GetChangeRequestDetails ChangeRequestListQuery = new GetChangeRequestDetails()
                    {
                        ChangeRequestID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ChangeRequestList["ChangeRequestID"], "0")),
                        ChangeRequestSummary = CommonFunctions.Data.CheckIsDBNull(ChangeRequestList["ChangeRequestSummary"], "").ToString(),
                    };
                    ChangeRequestLists.Add(ChangeRequestListQuery);
                }
                return ChangeRequestLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get User Story Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetUserStoryDetails> GetUserStoryDetails([FromBody]PMUserStoryParameter Parameters)
        public object GetUserStoryDetails([FromBody] PMUserStoryParameter Parameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ScrumUserStory " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                DataTable UserStoryListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetUserStoryDetails> UserStoryLists = new List<GetUserStoryDetails>();

                foreach (DataRow UserStoryList in UserStoryListTable.Rows)
                {
                    GetUserStoryDetails UserStoryListQuery = new GetUserStoryDetails()
                    {
                        UserStoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(UserStoryList["UserStoryID"], "0")),
                        UserStoryName = CommonFunctions.Data.CheckIsDBNull(UserStoryList["UserStoryName"], "").ToString(),
                    };
                    UserStoryLists.Add(UserStoryListQuery);
                }
                return UserStoryLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Feature Details
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        //public List<GetFeatureDetails> GetFeatureDetails([FromBody] PMFeatureParameter Parameters)
        //public List<GetFeatureDetails> GetFeatureDetails([FromBody] PMFeatureParameter Parameters)
        public object GetFeatureDetails([FromBody] PMFeatureParameter Parameters)


        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_Features ";

                if (Parameters.ProjectFeatureID == 0)
                {
                    strSQL += " NULL";
                }
                else
                {
                    strSQL += " " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectFeatureID)) + "";
                }

                strSQL += ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID));

                DataTable FeatureListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetFeatureDetails> FeatureLists = new List<GetFeatureDetails>();

                foreach (DataRow FeatureList in FeatureListTable.Rows)
                {
                    GetFeatureDetails FeatureListQuery = new GetFeatureDetails()
                    {
                        ProjectFeatureID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(FeatureList["ProjectFeatureID"], "0")),
                        FeatureName = CommonFunctions.Data.CheckIsDBNull(FeatureList["FeatureName"], "").ToString(),
                    };
                    FeatureLists.Add(FeatureListQuery);
                }
                return FeatureLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Edit saved filter data.
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetWhereClauseOfFilter([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(FilterID));

                Object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To set default filter
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody] ApplyFilterParameter Parameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.Flag));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Edit saved filter data.
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object EditFilterData([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query  " + HttpUtility.UrlDecode(Convert.ToString(FilterID));

                DataTable myFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<MyFilterParameter> myFilterLists = new List<MyFilterParameter>();

                foreach (DataRow myFilterList in myFilterListTable.Rows)
                {
                    MyFilterParameter myFilterListQuery = new MyFilterParameter()
                    {
                        FilterId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterID"], "0")),
                        FilterName = CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterName"], "").ToString(),
                        QueryText = CommonFunctions.Data.CheckIsDBNull(myFilterList["WhereClause"], "").ToString(),
                    };
                    myFilterLists.Add(myFilterListQuery);
                }
                return myFilterLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the filter
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilter([FromBody] int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(FilterID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the risk details
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteRisk([FromBody] PMParameter Parameters)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @intReturn INT " + System.Environment.NewLine;
                strSQL += "Exec usp_Whizible2_Del_tbl_PM_Risks " + HttpUtility.UrlDecode(Convert.ToString(Parameters.RiskID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId)) + ", @intReturn OUTPUT";
                strSQL += " SELECT ' Status' = @intReturn";
                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the Plan details
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeletePlan([FromBody] PMPlanParameter Parameters)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @strResult VARCHAR(3000) " + System.Environment.NewLine;

                if (Parameters.Flag == "Contingency")
                {
                    strSQL += "Exec usp_Whizible2_Del_tbl_PM_ContingencyPlans " + HttpUtility.UrlDecode(Convert.ToString(Parameters.PlanID)) + ", @strResult OUTPUT";
                }
                if (Parameters.Flag == "Mitigation")
                {
                    strSQL += "Exec usp_Whizible2_Del_tbl_PM_MitigationPlans " + HttpUtility.UrlDecode(Convert.ToString(Parameters.PlanID)) + ", @strResult OUTPUT";
                }

                strSQL += " SELECT ' Status' = @strResult";

                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete the early warning details
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteEarlywarning([FromBody] PMEarlyWarningsParameter Parameters)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @intReturn INT " + System.Environment.NewLine;
                strSQL += "Exec usp_Whizible2_Del_tbl_PM_EarlyWarnings " + HttpUtility.UrlDecode(Convert.ToString(Parameters.WarningID)) + ", @intReturn OUTPUT";
                strSQL += " SELECT ' Status' = @intReturn";
                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetProjectRiskId([FromBody] PMParameter Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_ProjectRiskCount " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        //public List<getProjectImpactStatus> GetProjectRiskImpactStatus([FromBody] PMParameter Parameters)
        public object GetProjectRiskImpactStatus([FromBody] PMParameter Parameters)

        {
            try
            {
                string strSQL = "Exec Usp_Whizible2_Sel_Probability_Impact_Magnitude_Status " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));

                DataTable ListProjectRiskImpact = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<getProjectImpactStatus> ProjectRiskImpactLists = new List<getProjectImpactStatus>();

                foreach (DataRow queryProjectRiskImpactList in ListProjectRiskImpact.Rows)
                {
                    getProjectImpactStatus QueryProjectRiskImpact = new getProjectImpactStatus()
                    {
                        ProbabilityStatus = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(queryProjectRiskImpactList["ProbabilityStatus"], "0")),
                        WeightStatus = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(queryProjectRiskImpactList["WeightStatus"], "0")),
                        SeverityStatus = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(queryProjectRiskImpactList["SeverityStatus"], "0")),
                    };
                    ProjectRiskImpactLists.Add(QueryProjectRiskImpact);

                }
                return ProjectRiskImpactLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetRiskStatus()
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RiskStatus ";

                DataTable ListRiskStatus = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetSelectedProjectRisks> RiskStatusLists = new List<GetSelectedProjectRisks>();


                foreach (DataRow queryRiskStatusList in ListRiskStatus.Rows)
                {
                    GetSelectedProjectRisks QueryRiskStatus = new GetSelectedProjectRisks()
                    {
                        Status = queryRiskStatusList["Status"].ToString(),
                    };
                    RiskStatusLists.Add(QueryRiskStatus);

                }
                return RiskStatusLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }
}
