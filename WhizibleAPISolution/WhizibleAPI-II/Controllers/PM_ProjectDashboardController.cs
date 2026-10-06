//using Caching;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Caching;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM_ProjectDashboard;
//using WhizibleAPI.Models.PM;
using System.Configuration;
using System.Globalization;
using System.Net.Http;
using System.Net;

namespace WhizibleAPI.Controllers
{
   
    public class PM_ProjectDashboardController : ApiController
    {

        #region[GetProject]
        /// <summary>
        /// Created Date    :   05 March 2020
        /// Purpose         :   GetProject
        /// <returns></returns>
        /// // 
        /// 


        #endregion




        //// currently we are not using this functionality of user selection 
        #region[GetProjectUser]
        /// <summary>
        /// Created Date    :   05 March 2020
        /// Purpose         :   GetProjectUser
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        public object GetProjectUserDropDown([FromBody] userDataParameter parameters)
        {
            try
            {
                DataTable FillUsersDatatable;
                List<UserDataOutputParameter> listUsers = new List<UserDataOutputParameter>();
                string strSQL = "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList_selectedProject_User_vidhi" + "";
                strSQL = strSQL + " '" + HttpUtility.UrlDecode(parameters.Flag.ToString()) + "' ";
                FillUsersDatatable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                foreach (DataRow dr in FillUsersDatatable.Rows)
                {
                    UserDataOutputParameter CC = new UserDataOutputParameter();


                    CC.EmployeeName = dr["EmployeeName"].ToString();
                    CC.EmployeeId = Convert.ToInt32(dr["EmployeeId"].ToString());
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

        [Authorize]
        [HttpPost]
        public object DisplayBG()
        {
            try
            {
                DataTable FillBGDatatable;
                List<PM_ProjectBG> listOfBG = new List<PM_ProjectBG>();
                string strSQL = "usp_Sel_tbl_CNF_BusinessGroup";

                FillBGDatatable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow dr in FillBGDatatable.Rows)
                {
                    PM_ProjectBG CC = new PM_ProjectBG();
                    CC.BusinessGroupID = Convert.ToInt32(dr["BusinessGroupID"].ToString());
                    CC.BusinessGroup = dr["BusinessGroup"].ToString();
                    listOfBG.Add(CC);
                }
                return listOfBG;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object DisplayOU()
        {
            try
            {
                DataTable FillBGDatatable;
                List<PM_ProjectOU> listOfOU = new List<PM_ProjectOU>();
                string strSQL = "usp_Whizible2_ProjectDashboard_GetOU";

                FillBGDatatable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow dr in FillBGDatatable.Rows)
                {
                    PM_ProjectOU CC = new PM_ProjectOU();
                    CC.LocationID = Convert.ToInt32(dr["LocationID"].ToString());
                    CC.Location = dr["Location"].ToString();
                    listOfOU.Add(CC);
                }
                return listOfOU;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetProjectStatus()
        {
            try
            {
                DataTable FillGetStatus;
                List<PM_GetProjectStatus> listOfStatus = new List<PM_GetProjectStatus>();
                string strSQL = "usp_Whizible2_GetPremiumStatus";
                FillGetStatus = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow dr in FillGetStatus.Rows)
                {
                    PM_GetProjectStatus CC = new PM_GetProjectStatus();
                    CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                    CC.Premium = Convert.ToBoolean(dr["Premium"].ToString());
                    CC.Priority = dr["Priority"].ToString();
                    listOfStatus.Add(CC);
                }
                return listOfStatus;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }







        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object DisplayGridDataInsidePopUP([FromBody] DisplayGridDataInsidePopUP_InputParameters parameters)
        {
            try
            {
                List<DisplayGridDataInsidePopUP_outputParameters> listOfProject = new List<DisplayGridDataInsidePopUP_outputParameters>();

                DataTable ProjectDashboardDataTableInsidePopup = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectDashboard_Get_ProjectGrid_Inside_Popup_Window " + parameters.UserID + ","
                                                                                      + parameters.LoginID + "," + parameters.Flag
                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in ProjectDashboardDataTableInsidePopup.Rows)
                {
                    DisplayGridDataInsidePopUP_outputParameters CC = new DisplayGridDataInsidePopUP_outputParameters();
                    CC.ProjectName = dr["ProjectName"].ToString();
                    CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                    CC.Description = dr["Description"].ToString();
                    CC.StartDate = dr["StartDate"].ToString();
                    CC.EndDate = dr["EndDate"].ToString();

                    listOfProject.Add(CC);
                }
                return listOfProject;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FetchDataAccordingtoBG([FromBody] FetchDataAccordingtoBG_inputParameters parameters)
        {
            try
            {
                List<FetchDataAccordingtoBG_outputParameters> listOfProjectAccordingtoBG = new List<FetchDataAccordingtoBG_outputParameters>();

                DataTable FetchProjectDataAccordingToBG = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectDashboard_Get_ProjectGrid_ByBusinessGroup " + parameters.UserID + ","
                                                                                      + parameters.LoginID + "," + parameters.BusinessGroupID
                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in FetchProjectDataAccordingToBG.Rows)
                {
                    FetchDataAccordingtoBG_outputParameters CC = new FetchDataAccordingtoBG_outputParameters();
                    CC.ProjectName = dr["ProjectName"].ToString();
                    CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                    CC.Description = dr["Description"].ToString();
                    CC.StartDate = dr["StartDate"].ToString();
                    CC.EndDate = dr["EndDate"].ToString();
                    CC.LocationID = Convert.ToInt32(dr["LocationID"].ToString());
                    listOfProjectAccordingtoBG.Add(CC);
                }
                return listOfProjectAccordingtoBG;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void  InsertDataIntoTable([FromBody]InsertDataIntoTable_InputParameter parameters)
        {
            CommonFunctions.Data.GetDataTable("usp_Whizible2_Ins_tbl_Whizible2_ProjectDashboard_PremiumProjects " + parameters.ProjectID + ","
                                                                                  + parameters.CreatedBy + "," + parameters.Priority +"," + parameters.Premium
                                                                               , true, CommonController.connectionString);

        }








        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectDashboardDetails([FromBody] PM_CommercialDashboardFilter filter)
        {
            try
            {
                PM_ProjectDashboard ProjectDashboardDetails = new PM_ProjectDashboard();

                // for get Priority Projects data
                // mainSp is usp_Whizible2_ProjectDashboard_GetPriorityProjectsDetails_vidhi
                DataTable PriorityProjectsDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectDashboard_PriorityProjectsDetails " + filter.UserID + ","
                                                                                     + filter.LoginID + "," + filter.ProjectFilter + "," + filter.Flag
                                                                                  , true, CommonController.connectionString);
                List<string> Type = new List<string>();
                List<int> TypeData = new List<int>();
                foreach (DataRow priorityProjectsRow in PriorityProjectsDataTable.Rows)
                {
                    Type.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(priorityProjectsRow["Type"], "")));
                    TypeData.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(priorityProjectsRow["TypeData"], "0")));
                }
                ProjectDashboardDetails.PriorityProjects = new PriorityProjects
                {
                    Type = Type.ToArray(),
                    TypeData = TypeData.ToArray()
                };

                // for get Net Profitability data
                DataTable ProfitabilityDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectDashboard_GetNetProfitabilityDetail " + filter.UserID + ","
                                                                                     + filter.LoginID + "," + filter.ProjectFilter + "," + filter.Flag + "," + filter.Rowcount
                                                                                  , true, CommonController.connectionString);
                List<string> Project = new List<string>();
                //Added By Dipali V on 21th Jan 2022 For Get % in float
                //List<int> ProfitRange = new List<int>();
                List<string> ProfitRange = new List<string>();
                //End of Added By Dipali V on 21th Jan 2022 For Get % in float
                foreach (DataRow profitabilityRow in ProfitabilityDataTable.Rows)
                {
                    Project.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(profitabilityRow["Project"], "")));
                    //Added By Dipali V on 21th Jan 2022 For Get % in float
                    //ProfitRange.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(profitabilityRow["ProfitRange"], "0")));
                    ProfitRange.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(profitabilityRow["ProfitRange"], "0")));
                    //Added By Dipali V on 21th Jan 2022 For Get % in float
                }
                ProjectDashboardDetails.NetProfitability = new NetProfitability
                {
                    Projects = Project.ToArray(),
                    ProfitRange = ProfitRange.ToArray()
                };
                return ProjectDashboardDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object DisplayGrid([FromBody] GridParameters parameters)
        {
            try
            {
                PM_ProjectGrid ProjectDashboardDetails = new PM_ProjectGrid();
                DataTable ProjectDashboardDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectDashboard_GetProjectDashboardDetail " + parameters.UserID + ","
                                                                                      + parameters.LoginID + "," + parameters.Flag
                                                                                   , true, CommonController.connectionString);

                ProjectDashboardDetails.ProjectData = new List<ProjectData>();
                // ProjectDashboardDetails.GridProjectData = new List<GridProjectData>();
                foreach (DataRow projectDashboardRow in ProjectDashboardDataTable.Rows)
                {
                    ProjectData ProjectDataObj = new ProjectData
                    {

                        ProjectName = projectDashboardRow["ProjectName"].ToString(),
                        ProjectID = Convert.ToInt32(projectDashboardRow["ProjectID"]),
                        WhichType = projectDashboardRow["WhichType"].ToString(),
                        PlannedEfforts = projectDashboardRow["PlannedEfforts"].ToString(),
                        ActualEfforts = projectDashboardRow["ActualEfforts"].ToString(),
                        EffortPercentage = projectDashboardRow["EffortPercentage"].ToString(),
                        ProjectDetails = projectDashboardRow["ProjectDetails"].ToString(),
                        //Added By Dipali V On 17th Jan 2022 For Details Of Projects
                        Baseline = projectDashboardRow["Baseline"].ToString(),
                        Planned = projectDashboardRow["Planned"].ToString(),
                        Actual = projectDashboardRow["Actual"].ToString(),
                        //End of Added By Dipali V On 17th Jan 2022 For Details Of Projects
                        ExpectedDuration = Convert.ToInt32(projectDashboardRow["ExpectedDuration"]),
                        ActualDuration = Convert.ToInt32(projectDashboardRow["ActualDuration"].ToString()),
                        HealthIndicator = projectDashboardRow["HealthIndicator"].ToString(),
                        StaffTurnover = Convert.ToInt32(projectDashboardRow["StaffTurnover"].ToString()),
                        ScopeCRRequest = Convert.ToInt32(projectDashboardRow["ScopeCRRequest"].ToString()),
                        DefectDensity = Convert.ToInt32(projectDashboardRow["DefectDensity"].ToString()),
                        Risks = Convert.ToInt32(projectDashboardRow["Risks"].ToString()),
                        Color = projectDashboardRow["Color"].ToString(),
                        OverAllShedule = Convert.ToInt32(projectDashboardRow["OverAllShedule"].ToString()),
                        PlannedShedule = Convert.ToInt32(projectDashboardRow["PlannedShedule"].ToString()),
                        //Added By Dipali V On 17th Jan 2022 For Get Correct Values
                        //ActualShedule = Convert.ToInt32(projectDashboardRow["ActualShedule"].ToString()),
                        //ScheduleVariance = Convert.ToInt32(projectDashboardRow["ScheduleVariance"].ToString()),
                        //CostVariance = Convert.ToInt32(projectDashboardRow["CostVariance"].ToString()),
                        ActualShedule = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectDashboardRow["ActualShedule"].ToString(), "0")),
                        ScheduleVariance = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectDashboardRow["ScheduleVariance"].ToString(), "0")),
                        CostVariance = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectDashboardRow["CostVariance"].ToString(), "0")),
                        //End of Added By Dipali V On 17th Jan 2022 For Get Correct Values
                        BillingActualPlanned = Convert.ToInt32(projectDashboardRow["BillingActualPlanned"].ToString()),
                        //Added By Dipali V On 22nd Jan 2022 For Get Project Profatability,
                        // NetProfitability = Convert.ToInt32(projectDashboardRow["NetProfitability"].ToString())
                        NetProfitability = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectDashboardRow["NetProfitability"].ToString(), "0"))
                        //End of Added By Dipali V On 22nd Jan 2022 For Get Project Profatability
                    };
                    ProjectDashboardDetails.ProjectData.Add(ProjectDataObj);

                }
                return ProjectDashboardDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }











        }
}