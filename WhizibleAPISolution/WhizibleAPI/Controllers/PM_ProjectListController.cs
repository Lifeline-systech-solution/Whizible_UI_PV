using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_ProjectListController : ApiController
    {
        private int TagID = 32;
        #region "Main Page"
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        // public List<ProjectList> GetProjectList([FromBody]ProjectParameters projectParameters)
        public object GetProjectList([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                string strQueryText = projectParameters.QueryText;
                if (strQueryText.IndexOf("[Over]") > 0)
                {
                    int overloc = strQueryText.IndexOf("[Over]");
                    string strover = strQueryText.Substring(overloc, 12);
                }
                int rolelevel = 0;
                rolelevel = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("EXEC usp_Whizible2_sel_tbl_PM_Role_RoleID " + projectParameters.intEmployeeID.ToString(), true, CommonController.connectionString), "0"));

                string strProjects = GetCommaSeparatedProjects(projectParameters.intEmployeeID, projectParameters.LoginType, rolelevel, true, projectParameters.LoginID, "");

                string strSQL = "SELECT P.ProjectID, P.ProjectCode, P.ProjectName, P.ProjectStatusID, P.ProjectStatus, P.LocationID, P.Location, P.ExpectedStartDate, P.ExpectedEndDate, P.ExpectedDuration, P.PercentageComplete, P.ProjectType FROM f_tbl_PM_ProjectRevision P WITH (NOLOCK) WHERE 1=1";
                if (strProjects != "")
                {
                    strSQL += " AND ProjectID IN (" + strProjects + ")";
                }
                if (strQueryText != "")
                {
                    strSQL += " AND " + projectParameters.QueryText;
                }
                strSQL = strSQL.Replace("''", "'");
                List<ProjectList> lstProject = new List<ProjectList>();
                DataTable OpTable;
                OpTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow opRow in OpTable.Rows)
                {
                    ProjectList project = new ProjectList();

                    project.ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectID"], ""));
                    project.ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectName"], ""));
                    project.ProjectCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectCode"], ""));
                    project.ProjectStatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectStatusID"], ""));
                    project.ProjectStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectStatus"], ""));
                    project.OUID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["LocationID"], ""));
                    project.OUName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Location"], ""));
                    project.ExpectedStateDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedStartDate"], ""));
                    project.ExpectedEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedEndDate"], ""));
                    project.Duration = "" + "/" + Convert.ToString(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedDuration"], "")));
                    project.PercentageCompletion = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(opRow["PercentageComplete"], "0"));
                    project.DraftOrConverted = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["DraftOrConverted"], ""));
                    lstProject.Add(project);
                }
                return lstProject;
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
        public ProjectListDetails GetProjectListPaging([FromBody]ProjectParameters projectParameters)
        {
            string strQueryText = projectParameters.QueryText;
            string strOrderBy = projectParameters.OrderBy;
            int rolelevel = 0;
            rolelevel = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("EXEC usp_Whizible2_sel_tbl_PM_Role_RoleID " + projectParameters.intEmployeeID.ToString(), true, CommonController.connectionString), "0"));

            if(strOrderBy == "")
            {
                strOrderBy = "ProjectName ASC";
            }

            string strSQL = "";
            strSQL = "EXEC usp_Whizible2_Sel_ProjectListPaging " + projectParameters.intEmployeeID + ",'" + projectParameters.UserName + "','" + projectParameters.LoginType + "', " + rolelevel + ",1," + projectParameters.LoginID + ",'" + strQueryText + "','" + strOrderBy + "'," + projectParameters.PageNumber + "," + projectParameters.PageSize;

            ProjectListDetails projectListDetails = new ProjectListDetails();
            

            DataSet dataSet = CommonFunctions.Data.GetDataSet(strSQL, "ProjectList", 0, 0, true, CommonController.connectionString);
            PagingInfo pagingInfo = new PagingInfo();
            DataTable pgTable = dataSet.Tables[0];
            foreach(DataRow prow in pgTable.Rows)
            {
                pagingInfo = new PagingInfo
                {
                    CurrentPage = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(prow["CurrentPage"], "")),
                    TotalRecords = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(prow["TotalRecords"], "")),
                    IsNextPage = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(prow["IsNextPage"], "0")),
                };
            }

            List<ProjectList> lstProject = new List<ProjectList>();
            DataTable OpTable = dataSet.Tables[1];
            foreach (DataRow opRow in OpTable.Rows)
            {
                ProjectList project = new ProjectList();

                project.ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectID"], "0"));
                project.ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectName"], ""));
                project.ProjectCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectCode"], ""));
                project.ProjectStatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectStatusID"], "0"));
                project.ProjectStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectStatus"], ""));
                project.OUID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["LocationID"], "0"));
                project.OUName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Location"], ""));
                project.ExpectedStateDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedStartDate"], ""));
                project.ExpectedEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedEndDate"], ""));
                //project.Duration = Convert.ToString(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ActualDuration"], ""))) + "/" + Convert.ToString(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedDuration"], "")));
                //project.PercentageCompletion = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(opRow["PercentageComplete"], "0"));
                //double percentageCompletion = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(opRow["PercentageComplete"], "0"));
                int expectedDuration = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedDuration"], "0"));
                int actualDuration = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ActualDuration"], "0"));
                //if (percentageCompletion == 0)
                //{
                double percentageCompletion = 0;
                if (expectedDuration != 0)
                {
                    percentageCompletion = (actualDuration * 100) / expectedDuration;
                }
                //}
                project.PercentageCompletion = percentageCompletion;
                project.Duration = Convert.ToString(actualDuration) + "/" + Convert.ToString(expectedDuration);
                project.CostPercentage = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(opRow["CostPercentage"], "0")), 2).ToString());
                project.SchedulePercentage = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(opRow["SchedulePercentage"], "0")), 2).ToString());
                project.EffortPercentage = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(opRow["EffortPercentage"], "0")), 2).ToString());
                project.DraftOrConverted = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["DraftOrConverted"], ""));
                //Added By Usha Pandit On 13.04.2020 For checking if project is in use or not
                project.ProjectIsInUse = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectIsInUse"], "0"));
                //Added By Dipali V On 7th Oct 2025 For Get WF Current Status
                project.CurrentWFStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CurrentWFStatus"], "0"));
                //End of Added By Dipali V On 7th Oct 2025 For Get WF Current Status
                //End Of Added By Usha Pandit On 13.04.2020 For checking if project is in use or not
                lstProject.Add(project);
            }
            projectListDetails.projectList = lstProject;
            projectListDetails.pagingInfo = pagingInfo;
            return projectListDetails;
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public HealthThreshold GetHealthThreshold([FromBody]ProjectParameters projectParameters)
        {

            string strSQL = "EXEC usp_Whizible2_Sel_tbl_Whizible2_PM_ThresholdCostScheduleEfforts";
            
            HealthThreshold healthThreshold = new HealthThreshold();
            IDataReader drHealth;
            drHealth = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (drHealth.Read())
            {
                healthThreshold.CostThreshold = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drHealth["CostPercentage"], "0")), 2).ToString());
                healthThreshold.ScheduleThreshold = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drHealth["SchedulePercentage"], "0")), 2).ToString());
                healthThreshold.EffortThreshold = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drHealth["EffortPercentage"], "0")), 2).ToString());
            }
            CommonFunctions.Data.DisposeDataReader(ref drHealth);
            return healthThreshold;
        }

        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public List<ProjectHealthThreshold> GetProjectHealthThreshold([FromBody]ProjectParameters projectParameters)
        {

            string strSQL = "EXEC usp_Whizible2_Sel_tbl_Whizible2_PM_ThresholdValues '''Cost'',''Schedule'',''Effort'''";

            List<ProjectHealthThreshold> healthThreshold = new List<ProjectHealthThreshold>();
            DataTable dtHealth = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            foreach (DataRow dataRow in dtHealth.Rows)
            {
                ProjectHealthThreshold health = new ProjectHealthThreshold()
                {
                    Item = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dataRow["Item"], "")),
                    RedCriteria = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dataRow["RedCriteria"], "")),
                    AmberCriteria = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dataRow["AmberCriteria"], "")),
                    GreenCriteria = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dataRow["GreenCriteria"], "")),
                };
                healthThreshold.Add(health);
            }
            return healthThreshold;
        }

        #endregion

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 01-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProject([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                string strSQL;
                strSQL = "DECLARE @strReturn VARCHAR(1000) " + System.Environment.NewLine;
                strSQL += "Exec usp_Whizible2_Del_tbl_PM_Project " + HttpUtility.UrlDecode(Convert.ToString(projectParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(projectParameters.DraftOrConverted)) + "', @strReturn OUTPUT";
                strSQL += " SELECT ' Status' = @strReturn";
                object dt = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #region "Filters"
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetFilters([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_Filter_Query " + projectParameters.ProjectID + "," + TagID + ",'"
                                                                      + projectParameters.LoginType + "' ," + projectParameters.intEmployeeID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveFilter([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                string strSQL = "";
                string strQueryID = projectParameters.QueryID.ToString();
                if (projectParameters.QueryID == 0)
                {
                    strQueryID = "NULL";
                }
                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + TagID + ",NULL,"
                                                                    + projectParameters.intEmployeeID + ", '" + projectParameters.QueryName + "', '"
                                                                    + projectParameters.LoginType + "' ," + "'" + projectParameters.QueryText + "'"
                + ",'" + projectParameters.UserName + "'," + projectParameters.Flag + "," + strQueryID;


                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
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
        public object DeleteFilter([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Del_tbl_Whizible2_Filter_Query " + projectParameters.QueryID.ToString();
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return "Success";
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
        public object SetDefaultFilter([FromBody] ProjectParameters projectParameters)
        {
            try
            {

                string strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + projectParameters.ProjectID;
                strSQL += ",'" + projectParameters.LoginType;
                strSQL += "'," + projectParameters.intEmployeeID;
                strSQL += "," + TagID;
                strSQL += "," + projectParameters.QueryID;
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return "Success";
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
        //  public QueryList GetDefaultFilter([FromBody]ProjectParameters projectParameters)
        public object GetDefaultFilter([FromBody] ProjectParameters projectParameters)
        {

            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter ";
                strSQL += +projectParameters.ProjectID;
                strSQL += "," + TagID;
                strSQL += ",'" + projectParameters.LoginType;
                strSQL += "'," + projectParameters.intEmployeeID;

                QueryList defaultQuery = new QueryList();
                IDataReader drDefaultQuery;
                drDefaultQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drDefaultQuery.Read())
                {
                    defaultQuery.FilterID = Convert.ToInt32(drDefaultQuery["FilterID"]);
                    defaultQuery.FilterName = Convert.ToString(drDefaultQuery["FilterName"]);
                    defaultQuery.QueryText = Convert.ToString(drDefaultQuery["QueryText"]);
                }
                CommonFunctions.Data.DisposeDataReader(ref drDefaultQuery);
                return defaultQuery;
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
        // public QueryList GetFilterById([FromBody]ProjectParameters projectParameters)
        public object GetFilterById([FromBody] ProjectParameters projectParameters)
        {

            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query ";
                strSQL += +projectParameters.QueryID;

                QueryList Query = new QueryList();
                IDataReader drQuery;
                drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drQuery.Read())
                {
                    Query.FilterID = Convert.ToInt32(drQuery["FilterID"]);
                    Query.FilterName = Convert.ToString(drQuery["FilterName"]);
                    Query.QueryText = Convert.ToString(drQuery["WhereClause"]);
                }
                CommonFunctions.Data.DisposeDataReader(ref drQuery);
                return Query;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            #endregion

            [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
       // public ProjectScheduleDetail GetProjectScheduleDetails([FromBody] ProjectParameters projectParameters)
        public object GetProjectScheduleDetails([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                string strParameters = projectParameters.ProjectID.ToString();

                ProjectScheduleDetail projectScheduleDetailInfo = new ProjectScheduleDetail();

                //Project Schedule Details
                projectScheduleDetailInfo.ProjectScheduleDetailList = new List<ProjectScheduleDetails>();
                DataSet ProjectScheduleDetailListData = CommonFunctions.Data.GetDataSet("usp_Whizible2_Sel_ProjectScheduleDetails " + strParameters, "ENTITY", 0, 0, true, CommonController.connectionString);
                DataTable ProjectScheduleDetailListTable = ProjectScheduleDetailListData.Tables[0];
                foreach (DataRow ProjectDetailRow in ProjectScheduleDetailListTable.Rows)
                {
                    ProjectScheduleDetails projectScheduleDetails = new ProjectScheduleDetails()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["ProjectID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["ProjectName"], "")),
                        ProjectStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["ProjectStatus"], "")),
                        ExpectedStartDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["ExpectedStartDate"], "")),
                        ExpectedEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["ExpectedEndDate"], "")),
                        RecordLevel = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["RecordLevel"], "")),
                        YearHeader = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["YearHeader"], "")),
                        MonthHeader = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectDetailRow["MonthHeader"], "")),
                    };
                    projectScheduleDetailInfo.ProjectScheduleDetailList.Add(projectScheduleDetails);
                }

                //Project Milestone Details
                projectScheduleDetailInfo.ProjectScheduleMilestoneList = new List<ProjectScheduleDetails>();
                DataTable ProjectScheduleMilestoneListTable = ProjectScheduleDetailListData.Tables[1];
                foreach (DataRow ProjectMilestoneRow in ProjectScheduleMilestoneListTable.Rows)
                {
                    ProjectScheduleDetails projectScheduleDetails = new ProjectScheduleDetails()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectMilestoneRow["ProjectID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectMilestoneRow["ProjectName"], "")),
                        ExpectedEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(ProjectMilestoneRow["ExpectedEndDate"], "")),
                        RecordLevel = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectMilestoneRow["RecordLevel"], "")),
                    };
                    projectScheduleDetailInfo.ProjectScheduleMilestoneList.Add(projectScheduleDetails);
                }

                //Project Phase Details
                projectScheduleDetailInfo.ProjectSchedulePhaseList = new List<ProjectScheduleDetails>();
                DataTable ProjectSchedulePhaseListTable = ProjectScheduleDetailListData.Tables[2];
                foreach (DataRow ProjectPhaseRow in ProjectSchedulePhaseListTable.Rows)
                {
                    ProjectScheduleDetails projectScheduleDetails = new ProjectScheduleDetails()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectPhaseRow["ProjectID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectPhaseRow["ProjectName"], "")),
                        ExpectedEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(ProjectPhaseRow["ExpectedEndDate"], "")),
                        RecordLevel = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectPhaseRow["RecordLevel"], "")),
                    };
                    projectScheduleDetailInfo.ProjectSchedulePhaseList.Add(projectScheduleDetails);
                }

                //Project Review Details
                projectScheduleDetailInfo.ProjectScheduleReviewList = new List<ProjectScheduleDetails>();
                DataTable ProjectScheduleReviewListTable = ProjectScheduleDetailListData.Tables[3];
                foreach (DataRow ProjectReviewRow in ProjectScheduleReviewListTable.Rows)
                {
                    ProjectScheduleDetails projectScheduleDetails = new ProjectScheduleDetails()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectReviewRow["ProjectID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectReviewRow["ProjectName"], "")),
                        ExpectedEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(ProjectReviewRow["ExpectedEndDate"], "")),
                        RecordLevel = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectReviewRow["RecordLevel"], "")),
                    };
                    projectScheduleDetailInfo.ProjectScheduleReviewList.Add(projectScheduleDetails);
                }
                return projectScheduleDetailInfo;
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
        // public List<WorkflowEntityDetail> GetApprovalStatus([FromBody]ProjectParameters projectParameters)
        public object GetApprovalStatus([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                List<WorkflowEntityDetail> lstApprovalStatus = new List<WorkflowEntityDetail>();
                string strSQL = "Exec usp_Whizible2_Get_WorkflowEntity_Details 0, " + projectParameters.ProjectID + ", 32";
                DataTable OpTable;
                OpTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    WorkflowEntityDetail approvalStatus = new WorkflowEntityDetail
                    {
                        RequestStage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["RequestStage"], "")),
                        OrderNo = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["OrderNo"], "")),
                        IsCurrentStage = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["IsCurrentStage"], "0")),
                        IsDelayed = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["IsDelayed"], "0")),
                        ApproverList = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ApproverList"], "")),
                        CreatedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CreatedBy"], ""))
                    };
                    lstApprovalStatus.Add(approvalStatus);
                }
                return lstApprovalStatus;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        //public List<WorkflowApprovalHistory> GetApprovalHistory([FromBody]ProjectParameters projectParameters)
        public object GetApprovalHistory([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                List<WorkflowStageDetails> lstStageDetails = new List<WorkflowStageDetails>();
                string strSQL = "Exec usp_Whizible2_Get_WorkflowEntity_StageDetails 0, " + projectParameters.ProjectID + ", 32";
                DataTable OpTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    WorkflowStageDetails stage = new WorkflowStageDetails
                    {
                        FromStage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["FromStage"], "")),
                        ToStage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ToStage"], "")),
                        Date = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["EventDate"], "")),
                        ApprovedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ApprovedBy"], "")),
                        ApproverList = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ApproverList"], "")),
                        IsCurrentStage = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["IsCurrentStage"], "0")),
                        IsDelayed = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["IsDelayed"], "0")),
                        //Added By Dipali V On 8th Oct 2025 For Manage Project List WF Changes W26
                        StageStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["StageStatus"], "0")),
                        RequestStageID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["RequestStageID"], "0")),
                        ActionType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActionType"], "0"))
                        //End of Added By Dipali V On 8th Oct 2025 For Manage Project List WF Changes W26
                    };
                    lstStageDetails.Add(stage);
                }
                return lstStageDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //[HttpPost]
        ////Added by imran on 01-09-2022
        //[Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 01-09-2022
        ////public List<WorkflowApprovalHistory> GetApprovalHistory([FromBody]ProjectParameters projectParameters)
        //public object GetApprovalHistory([FromBody] ProjectParameters projectParameters)
        //{
        //    try
        //    {
        //        List<WorkflowApprovalHistory> lstApprovalStatus = new List<WorkflowApprovalHistory>();
        //        string strSQL = "Exec usp_Whizible2_Sel_WorkflowApproval_History 0, " + projectParameters.ProjectID + ", 32";
        //        DataTable OpTable;
        //        OpTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
        //        foreach (DataRow opRow in OpTable.Rows)
        //        {
        //            WorkflowApprovalHistory approvalStatus = new WorkflowApprovalHistory
        //            {
        //                RequestStage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["RequestStage"], "")),
        //                WorkflowName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["WorkflowName"], "")),
        //                EventDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["EventDate"], "")),
        //                EventDateTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["EventDateTime"], "")),
        //                ActionType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ActionType"], "")),
        //                FromStage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["FromStage"], "")),
        //                ToStage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ToStage"], "")),
        //                UserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["UserName"], "")),
        //                Comments = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Comments"], "")),
        //            };
        //            lstApprovalStatus.Add(approvalStatus);
        //        }
        //        return lstApprovalStatus;
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}

        //End of Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas
        #region "Private Functions"
        private string GetCommaSeparatedProjects(int EmployeeId, string LoginType, int RoleLevel, bool ShowReleasedProjects, int LoginId, string ProjectOver)
        {
            string strProjects = "";
            string strover = ProjectOver == "" ? "NULL" : ProjectOver;
            string strSQL = "EXEC usp_Whizible2_Sel_ProjectList " + EmployeeId + ",'" + LoginType + "', " + RoleLevel + "," + ShowReleasedProjects + "," + LoginId + "," + strover;
            IDataReader drProjectList;
            drProjectList = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            while (drProjectList.Read())
            {
                strProjects = strProjects + "'" + Convert.ToString(drProjectList["ProjectID"]) + "',";

            }
            CommonFunctions.Data.DisposeDataReader(ref drProjectList);
            if (strProjects.Length > 0)
            {
                strProjects = strProjects.TrimEnd(',');
            }
            return strProjects;
        }
        //Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectDetails([FromBody] ProjectParameters projectParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_ProjectDetails " + projectParameters.ProjectID;

                ProjectDetails_List ProjectDetails_List = new ProjectDetails_List();
                IDataReader drProject;
                drProject = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drProject.Read())
                {
                    ProjectDetails_List.ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drProject["ProjectID"], "0"));
                    ProjectDetails_List.ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["ProjectName"], ""));
                    ProjectDetails_List.ProjectCode = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["ProjectCode"], ""));
                    ProjectDetails_List.WorkflowName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["WorkflowName"], ""));
                    ProjectDetails_List.ExpectedStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["ExpectedStartDate"], ""));
                    ProjectDetails_List.ExpectedEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["ExpectedEndDate"], ""));
                    ProjectDetails_List.Efforts = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["Efforts"], ""));
                    ProjectDetails_List.BusinessGroup = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["BusinessGroup"], ""));
                    ProjectDetails_List.OrganizationUnit = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["OrganizationUnit"], ""));
                    ProjectDetails_List.RevisionNo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drProject["RevisionNo"], ""));
                 }

                CommonFunctions.Data.DisposeDataReader(ref drProject);
                return ProjectDetails_List;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas
        #endregion

    }
    //Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas
    public class ProjectDetails_List
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
        public string ProjectCode { get; set; }
        public string WorkflowName { get; set; }
        public string ExpectedEndDate { get; set; }
        public string ExpectedStartDate { get; set; }
        public string Efforts { get; set; }
        public string BusinessGroup { get; set; }
        public string OrganizationUnit { get; set; }
        public string RevisionNo { get; set; }
       
    }

    public class WorkflowStageDetails
    {
        public string FromStage { get; set; }
        public string ToStage { get; set; }
        public string Date { get; set; }
        public string ApprovedBy { get; set; }
        public string ApproverList { get; set; }
        public string StageStatus { get; set; }//Added By Dipali V On 8th Oct 2025 
        public string ActionType { get; set; }//Added By Dipali V On 8th Oct 2025 
        public int IsCurrentStage { get; set; }
        public int IsDelayed { get; set; }
        public int RequestStageID { get; set; }
    }
    //End of Added by Dipali V on 6th OCT 2025 (W26): Project Details Offcanvas
    public class ProjectParameters
    {
        public int intEmployeeID { get; set; }
        public int ProjectID { get; set; }
        public string LoginType { get; set; }

        public int LoginID { get; set; }
        public bool IsAccessible { get; set; }
        public int RoleId { get; set; }
        public int PostId { get; set; }
        public string DisplayMode { get; set; }
        public string UserName { get; set; }
        public int QueryID { get; set; }
        public string QueryName { get; set; }
        public string QueryText { get; set; }
        public string QueryType { get; set; }
        public string ControlName { get; set; }
        public int Flag { get; set; }
        public string OrderBy { get; set; }
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public string DraftOrConverted { get; set; }
    }
}
