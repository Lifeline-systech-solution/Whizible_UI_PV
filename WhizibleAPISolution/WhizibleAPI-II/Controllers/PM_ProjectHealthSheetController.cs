using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

using static WhizibleAPI.Models.PM.PM_ProjectHealthSheet;


namespace WhizibleAPI.Controllers
{
    public class PM_ProjectHealthSheetController : ApiController
    {
        ////Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<projectlist_output> FetchListOfProject([FromBody]projectparameter_input parameters)
        public object FetchListOfProject([FromBody] projectparameter_input parameters)

        {
            try
            {
                List<projectlist_output> listOfProject = new List<projectlist_output>();

                DataTable FetchProject = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_GetProjectList " + parameters.UserID + "," + parameters.LoginType

                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in FetchProject.Rows)
                {
                    projectlist_output CC = new projectlist_output();

                    CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                    CC.ProjectName = dr["ProjectName"].ToString();


                    listOfProject.Add(CC);
                }
                return listOfProject;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<FetchPHSInformation_output> FetchPHSInformation([FromBody] FetchPHSInformation_input parameters)
        public object FetchPHSInformation([FromBody] FetchPHSInformation_input parameters)

        {
            try
            {
                List<FetchPHSInformation_output> listOfProject = new List<FetchPHSInformation_output>();

                //string strSQL = "select ISNULL(Convert(varchar,expectedStartdate, 106),'''')";
                string strSql = Convert.ToString(parameters.CurrentDate);



                DataTable FetchInformation = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_GetProjectHealthSheetInformation " + parameters.UserID + ","
                                                                                     + parameters.LoginType + "," + parameters.ProjectID + "," + "'" + strSql + "'"
                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in FetchInformation.Rows)
                {
                    FetchPHSInformation_output CC = new FetchPHSInformation_output();

                    CC.FromDate = dr["FromDate"].ToString();
                    CC.ToDate = dr["ToDate"].ToString();
                    CC.ProjectName = dr["ProjectName"].ToString();
                    CC.ProjectType = dr["ProjectType"].ToString();
                    CC.BusinessGroup = dr["BusinessGroup"].ToString();
                    CC.Location = dr["Location"].ToString();
                    CC.ProjectGroupName = dr["ProjectGroupName"].ToString();
                    CC.ProjectTypeID = Convert.ToInt32(dr["ProjectTypeID"].ToString());
                    CC.ProjectGroupID = Convert.ToInt32(dr["ProjectGroupID"].ToString());
                    CC.BusinessGroupID = Convert.ToInt32(dr["BusinessGroupID"].ToString());
                    CC.LocationID = Convert.ToInt32(dr["LocationID"].ToString());

                    listOfProject.Add(CC);
                }
                return listOfProject;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<FilterDataDisplay> FilterDataDisplay([FromBody]FetchPHSInformation_input parameters)
        public object FilterDataDisplay([FromBody] FetchPHSInformation_input parameters)

        {
            try
            {
                List<FilterDataDisplay> listOfProject = new List<FilterDataDisplay>();

                DataTable FetchInformation = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_GetProjectHealthSheetInformation " + parameters.UserID + ","
                                                                                     + parameters.LoginType + "," + parameters.ProjectID + "," + "'" + parameters.CurrentDate + "'"
                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in FetchInformation.Rows)
                {
                    FilterDataDisplay CC = new FilterDataDisplay();

                    CC.ProjectTypeID = Convert.ToInt32(dr["ProjectTypeID"].ToString());
                    CC.ProjectGroupID = Convert.ToInt32(dr["ProjectGroupID"].ToString());
                    CC.BusinessGroupID = Convert.ToInt32(dr["BusinessGroupID"].ToString());
                    CC.LocationID = Convert.ToInt32(dr["LocationID"].ToString());


                    listOfProject.Add(CC);
                }
                return listOfProject;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<activeresource_output> FetchListOfActiveResource([FromBody] activeresource_input parameters)
        public object FetchListOfActiveResource([FromBody] activeresource_input parameters)

        {
            try
            {
                List<activeresource_output> listOfActiveResource = new List<activeresource_output>();

                DataTable FetchActiveResource = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ResourceDetailsForProject " + parameters.ProjectID
                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in FetchActiveResource.Rows)
                {
                    activeresource_output CC = new activeresource_output();


                    CC.Resource = dr["Resource"].ToString();
                    CC.StartDate = dr["StartDate"].ToString();
                    CC.EndDate = dr["EndDate"].ToString();
                    CC.Work = dr["Work"].ToString();
                    CC.ActualWork = dr["ActualWork"].ToString();


                    listOfActiveResource.Add(CC);
                }
                return listOfActiveResource;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<milestonedetail_output> FetchListOfMileStone([FromBody] milestonedetail_input parameters)
        public object FetchListOfMileStone([FromBody] milestonedetail_input parameters)

        {
            try
            {
                List<milestonedetail_output> listOfMileStone = new List<milestonedetail_output>();

                DataTable FetchMileStone = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ProjectHealthSheet_MilestoneDetails " + parameters.ProgramID + "," +
                                                                                parameters.ProjectID + "," + parameters.ProjectTypID + "," + parameters.BusinessGroupID + "," + parameters.LocationID + "," + "'" + parameters.EndDate + "'" + "," + parameters.UserID
                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in FetchMileStone.Rows)
                {
                    milestonedetail_output CC = new milestonedetail_output();


                    CC.ProjectName = dr["ProjectName"].ToString();
                    CC.Milestone = dr["Milestone"].ToString();
                    CC.IsReadyForBilling = Convert.ToBoolean(dr["IsReadyForBilling"].ToString());
                    CC.BillAmount = dr["BillAmount"].ToString();
                    CC.PlannedStartDate = dr["PlannedStartDate"].ToString();
                    CC.PlannedEndDate = dr["PlannedEndDate"].ToString();
                    CC.ActualStartDate = dr["ActualStartDate"].ToString();
                    CC.ActualEndDate = dr["ActualEndDate"].ToString();
                    CC.Slippage = Convert.ToInt32(dr["Slippage"].ToString());
                    CC.Milestonestatus = dr["Milestonestatus"].ToString();
                    CC.ISSlipping = Convert.ToInt32(dr["ISSlipping"].ToString());

                    listOfMileStone.Add(CC);
                }
                return listOfMileStone;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<fetchTaskVsComplete_output> FetchGraphTaskVsComplete([FromBody]fetchTaskVsComplete_input parameters)
        public object FetchGraphTaskVsComplete([FromBody] fetchTaskVsComplete_input parameters)

        {
            try
            {

                List<fetchTaskVsComplete_output> listOfTaskVsComplete = new List<fetchTaskVsComplete_output>();

                DataTable FetchTaskVsComplete = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_TotalTasksVsTaskStatus " + parameters.ProjectID + "," + "'" + parameters.CurrentDate + "'"

                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in FetchTaskVsComplete.Rows)
                {
                    fetchTaskVsComplete_output CC = new fetchTaskVsComplete_output();


                    CC.ActualPercentComplete = dr["ActualPercentComplete"].ToString();
                    CC.TotalTasks = Convert.ToInt32(dr["TotalTasks"].ToString());

                    listOfTaskVsComplete.Add(CC);
                }
                return listOfTaskVsComplete;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<FetchDelayInDays_output> FetchDelayInDays([FromBody] FetchDelayInDays_input parameters)
        public object FetchDelayInDays([FromBody] FetchDelayInDays_input parameters)

        {
            try
            {

                List<FetchDelayInDays_output> listOfDelayInDays = new List<FetchDelayInDays_output>();

                DataTable FetchTaskVsComplete = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_TotalTasksVSCompletionTime_Graph " + parameters.ProjectID + "," + "'" + parameters.CurrentDate + "'", true, CommonController.connectionString);
                foreach (DataRow dr in FetchTaskVsComplete.Rows)
                {
                    FetchDelayInDays_output CC = new FetchDelayInDays_output();
                    //commented and added by imran on 15-12-2021 Crash comming when converting null value to Int
                    //CC.DelayInterval = dr["DelayInterval"].ToString();
                    //CC.DelayCount = Convert.ToInt32(dr["DelayCount"].ToString());
                    CC.DelayInterval = dr["DelayInterval"].ToString();
                    if (dr["DelayCount"].ToString() == null || dr["DelayCount"].ToString() == "")
                    {
                        CC.DelayCount = 0;
                    }
                    else
                    {
                        CC.DelayCount = Convert.ToInt32(dr["DelayCount"].ToString());
                    }
                    //End Comment by imran 15-12-2021

                    listOfDelayInDays.Add(CC);
                }
                return listOfDelayInDays;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<FetchMonthlyResourceCost_output> FetchMonthlyResourceCost([FromBody]FetchMonthlyResourceCost_input parameters)
        public object FetchMonthlyResourceCost([FromBody] FetchMonthlyResourceCost_input parameters)

        {
            try
            {
                List<FetchMonthlyResourceCost_output> listOfDelayInDays = new List<FetchMonthlyResourceCost_output>();

                DataTable FetchResourceMonthlyCost = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_TotalEffortsMonthVSResourceCost_Graph " + parameters.ProjectID + "," + "'" + parameters.CurrentDate + "'", true, CommonController.connectionString);
                foreach (DataRow dr in FetchResourceMonthlyCost.Rows)
                {
                    FetchMonthlyResourceCost_output CC = new FetchMonthlyResourceCost_output();
                    CC.Month = dr["Month"].ToString();
                    //commented and added by imran on 15-12-2021 Crash comes when null value convert to int
                    // CC.ResourceCost = Convert.ToDecimal(dr["ResourceCost"].ToString());
                    if (dr["ResourceCost"].ToString() == null || dr["ResourceCost"].ToString() == "")
                    {
                        CC.ResourceCost = 0;
                    }
                    else
                    {
                        CC.ResourceCost = Convert.ToDecimal(dr["ResourceCost"].ToString());
                    }
                    //End Comment by imran 15-12-2021   
                    listOfDelayInDays.Add(CC);
                }
                return listOfDelayInDays;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<FetchListOfPractice> GetPHSFilterData([FromBody] PM_ProjectHealthSheetFilter_input parameters)
        public object GetPHSFilterData([FromBody] PM_ProjectHealthSheetFilter_input parameters)

        {
            try
            {
                List<FetchListOfPractice> listOFPRAC = new List<FetchListOfPractice>();

                DataTable Practicelist = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_tbl_CNF_Practice " + parameters.UserID + "," + parameters.LoginType
                                                                                   , true, CommonController.connectionString);
                foreach (DataRow dr in Practicelist.Rows)
                {
                    FetchListOfPractice CC = new FetchListOfPractice();
                    CC.TypeId = Convert.ToInt32(dr["TypeId"].ToString());
                    CC.ProjectType = dr["ProjectType"].ToString();

                    listOFPRAC.Add(CC);
                }
                return listOFPRAC;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        //public List<FetchListOfBG> GetPHSBGFilter([FromBody] PM_ProjectHealthSheetFilter_input parameters)
        public object GetPHSBGFilter([FromBody] PM_ProjectHealthSheetFilter_input parameters)

        {
            try
            {
                List<FetchListOfBG> listOFBG = new List<FetchListOfBG>();

                DataTable Practicelist = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_tbl_CNF_BusinessGroup " + parameters.UserID + "," + parameters.LoginType

                                                                                   , true, CommonController.connectionString);


                foreach (DataRow dr in Practicelist.Rows)
                {
                    FetchListOfBG CC = new FetchListOfBG();
                    CC.BusinessGroupID = Convert.ToInt32(dr["BusinessGroupID"].ToString());
                    CC.BusinessGroup = dr["BusinessGroup"].ToString();

                    listOFBG.Add(CC);
                }
                return listOFBG;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //Added by imran on 15-09-2022
            [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<FetchListOfOU> GetPHSOUFilter([FromBody] PM_ProjectHealthSheetFilter_input parameters)
        {
            List<FetchListOfOU> listOFOU = new List<FetchListOfOU>();

            DataTable OULIST = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_pm_LocationList " + parameters.SelectedBG + ","+
                                                                    parameters.UserID + "," + parameters.LoginType

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in OULIST.Rows)
            {
                FetchListOfOU CC = new FetchListOfOU();
                CC.LocationID = Convert.ToInt32(dr["LocationID"].ToString());
                CC.Location = dr["Location"].ToString();

                listOFOU.Add(CC);
            }
            return listOFOU;

        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<FetchListPG> GetPHSProjectGroupFilter([FromBody] PM_ProjectHealthSheetFilter_input parameters)
        {
            List<FetchListPG> listOFPG = new List<FetchListPG>();

            DataTable Pglist = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_tbl_CNF_ProjectGroup " +
                                                                    parameters.UserID + "," + parameters.LoginType

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in Pglist.Rows)
            {
                FetchListPG CC = new FetchListPG();
                CC.ProjectGroupID = Convert.ToInt32(dr["ProjectGroupID"].ToString());
                CC.ProjectGroupName = dr["ProjectGroupName"].ToString();

                listOFPG.Add(CC);
            }
            return listOFPG;

        }

        [Authorize]
        [HttpPost]
        public List<FrequencyDetails> GetPHSReportingPeriod()
        {
            List<FrequencyDetails> listOFFrequency = new List<FrequencyDetails>();

            DataTable freq = CommonFunctions.Data.GetDataTable("usp_Whizible2_SEL_Tbl_PM_companyInformation_ResourceTimeSheetFrequency "                                                                    
                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in freq.Rows)
            {
                FrequencyDetails CC = new FrequencyDetails();
                CC.Frequency = dr["Frequency"].ToString();
                CC.FrequencyID = Convert.ToInt32(dr["FrequencyID"].ToString());
                

                listOFFrequency.Add(CC);
            }
            return listOFFrequency;

        }

        //Added By dipali V n 10th feb 2022 for get list of till not project
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<FilterProjectList> ProjectLockingBinding([FromBody] FilterProjectlist_input parameters)
        {
            List<FilterProjectList> listofProjectAccFilter = new List<FilterProjectList>();

            //DataTable FilterProjectDataTable =
            //    CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_GetProjectNameList_Lock " +
            //    "" + parameters.ProgramID + "," + parameters.ProjectID + "," +
            //    "" + parameters.CategoryID + "," + parameters.BusinessID + "," + parameters.OrganizationID + ",NULL,'" + parameters.ReportingEndDate + "',0,"+ parameters.UserID + "," + parameters.ProjectID + ","
            //    + parameters.LoginType, true, CommonController.connectionString);

            DataTable FilterProjectDataTable =
               CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_GetProjectNameList_Lock  NULL,NULL,NULL,NULL,NULL,NULL,'" + parameters.ReportingEndDate + "',0," + parameters.UserID + "," + parameters.ProjectID + ","
               + parameters.LoginType, true, CommonController.connectionString);


            foreach (DataRow dr in FilterProjectDataTable.Rows)
            {
                FilterProjectList CC = new FilterProjectList();
                //CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                CC.ProjectName = dr["ProjectName"].ToString();
                CC.ExpectedStartDate = dr["ExpectedStartDate"].ToString();
                CC.ExpectedEndDate = dr["ExpectedEndDate"].ToString();

                listofProjectAccFilter.Add(CC);
            }
            return listofProjectAccFilter;

        }

        //End of Added By dipali V n 10th feb 2022 for get list of till not project



        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<FilterProjectList> GetFilterListOfProject([FromBody] FilterProjectlist_input parameters)
        {
            List<FilterProjectList> listofProjectAccFilter = new List<FilterProjectList>();

            DataTable FilterProjectDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_GetProjectNameList " + parameters.PracticeID + ","+ parameters.BusinessID + "," +parameters.LocationID + "," +
                                                                parameters.ProjectGroupID + "," +     parameters.UserID + "," + parameters.ProjectID + "," + parameters.LoginType

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in FilterProjectDataTable.Rows)
            {
                FilterProjectList CC = new FilterProjectList();
                CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                CC.ProjectName = dr["ProjectName"].ToString();
                CC.ExpectedStartDate = dr["ExpectedStartDate"].ToString();
                CC.ExpectedEndDate = dr["ExpectedEndDate"].ToString();

                listofProjectAccFilter.Add(CC);
            }
            return listofProjectAccFilter;

        }

        //Resource save filter
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SavedFilters([FromBody]  SaveFilter_inputparamerter parameters)
        {
            string strSQL = "";

            strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(parameters.ProjectID)) + ","
                                                                + HttpUtility.UrlDecode(Convert.ToString(parameters.UserID)) + ", '" + HttpUtility.UrlDecode(parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', '"
                                                                + HttpUtility.UrlDecode(parameters.LoginType) + "' ," + "'" + HttpUtility.UrlDecode(parameters.QueryText) + "'"
            + ",'" + HttpUtility.UrlDecode(parameters.UserName) + "'," + HttpUtility.UrlDecode(Convert.ToString(parameters.FilterFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(parameters.FilterID));


            object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
            return dt;

        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public List<MyFilter_output> MyFilterList([FromBody] MyFilterlist_input parameters)
        {
            List<MyFilter_output> listOfMyFilter= new List<MyFilter_output>();

            DataTable FilterProjectDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_Whizible2_Filter_Query " + parameters.ProjectID + "," + parameters.TagID + "," + parameters.LoginType + "," +
                                                                  parameters.UserID 

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in FilterProjectDataTable.Rows)
            {
                MyFilter_output CC = new MyFilter_output();
                CC.FilterId = Convert.ToInt32(dr["FilterId"].ToString());
                CC.FilterName = dr["FilterName"].ToString();
                CC.SetDefault = Convert.ToBoolean(dr["SetDefault"].ToString());
                CC.QueryText = dr["QueryText"].ToString();
                CC.EmployeeID= Convert.ToInt32(dr["EmployeeID"].ToString());

                listOfMyFilter.Add(CC);
            }
            return listOfMyFilter;

        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public List<CheckFilter_output> CheckFilter([FromBody] ChcekFilter_input parameters)
        {
            List<CheckFilter_output> listOfCheckFilter = new List<CheckFilter_output>();

            DataTable FilterCheckDataTable = CommonFunctions.Data.GetDataTable("usp_sel_ByFilterID_tbl_Whizible2_Filter_Query " + parameters.FilterID 
                                                               
                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in FilterCheckDataTable.Rows)
            {
                CheckFilter_output CC = new CheckFilter_output();
                CC.FilterID = Convert.ToInt32(dr["FilterID"].ToString());
                CC.FilterName = dr["FilterName"].ToString();               
                CC.WhereClause = dr["WhereClause"].ToString();
                

                listOfCheckFilter.Add(CC);
            }
            return listOfCheckFilter;

        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public string SetDefaultFilter([FromBody] DefaultFilter_input parameters)
        {
            string result = "";
            string strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(parameters.ProjectID));
            strSQL += ",'" + HttpUtility.UrlDecode(parameters.LoginType);
            strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(parameters.UserID));
            strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(parameters.TagID));
            strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(parameters.FilterID));
            strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(parameters.Flag));
            CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
            if (parameters.Flag == 0)
            {
                result = "Set Default Filter Successfully";
            }
            else
            {
                result = "Default Filter Cleared Successfully";
            }
            return result;
        }

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public List<getDefaultFilterStatus_output> CheckDefaultFilterSetOrNot([FromBody] MyFilterlist_input parameters)
        {
            List<getDefaultFilterStatus_output> listOfDefaultFilter = new List<getDefaultFilterStatus_output>();
            DataTable FilterCheckDefaultDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_GetDefaultFilter " + parameters.TagID + "," + parameters.LoginType + "," + parameters.UserID, true, CommonController.connectionString);
            foreach (DataRow dr in FilterCheckDefaultDataTable.Rows)
            {
                getDefaultFilterStatus_output CC = new getDefaultFilterStatus_output();
                CC.FilterID = Convert.ToInt32(dr["FilterID"].ToString());
                //comment and added by imran on 05-01-2021
                // CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                if (dr["ProjectID"].ToString() == null || dr["ProjectID"].ToString() == "")
                {
                    CC.ProjectID = 0;
                }
                else
                {
                    CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                }
                //End comment by imran on 05-01-2021
                CC.SetDefault = Convert.ToBoolean(dr["SetDefault"].ToString());
                listOfDefaultFilter.Add(CC);
            }
            return listOfDefaultFilter;
        }

        // EDIT FILTER 
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public List<CheckFilter_output> EditFilter([FromBody] ChcekFilter_input parameters)
        {
            List<CheckFilter_output> listOfCheckFilter = new List<CheckFilter_output>();

            DataTable FilterCheckDataTable = CommonFunctions.Data.GetDataTable("usp_sel_ByFilterID_tbl_Whizible2_Filter_Query " + parameters.FilterID

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in FilterCheckDataTable.Rows)
            {
                CheckFilter_output CC = new CheckFilter_output();
                CC.FilterID = Convert.ToInt32(dr["FilterID"].ToString());
                CC.FilterName = dr["FilterName"].ToString();
                CC.WhereClause = dr["WhereClause"].ToString();


                listOfCheckFilter.Add(CC);
            }
            return listOfCheckFilter;

        }

        //  DELETE FILTER
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public string DeleteFilter([FromBody] ChcekFilter_input parameters) {

            string strSQL = "";

            strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(parameters.FilterID));

            CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

            return "Filter Deleted Successfully";
        }

        // Get default filter 
        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public List<GetPHSDefaultFilter_output> GetPHSDefaultFilter([FromBody] DefaultFilter_input parameters)
        {
            List<GetPHSDefaultFilter_output> listOfCheckFilter = new List<GetPHSDefaultFilter_output>();

            DataTable FilterCheckDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter " + parameters.ProjectID + "," + parameters.TagID + ","+
                                                                                    parameters.LoginType + "," + parameters.UserID

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in FilterCheckDataTable.Rows)
            {
                GetPHSDefaultFilter_output CC = new GetPHSDefaultFilter_output();
                CC.FilterID = Convert.ToInt32(dr["FilterID"].ToString());
                CC.FilterName = dr["FilterName"].ToString();
                CC.QueryText = dr["QueryText"].ToString();


                listOfCheckFilter.Add(CC);
            }
            return listOfCheckFilter;

        }

        //CHECK FILTER NAME EXIST OR NOT
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public String chkFilterExists([FromBody]SaveFilter_inputparamerter Parameters)
        {
            string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists '" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UserID));

            string Flag;

            Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

            return Flag;
        }

        // SQERT DETAILS
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<GetSQERTDetails_output> GetSQERTDetails([FromBody] GetSQERTDetails_input parameters)
        {
            List<GetSQERTDetails_output> listOfSQERT = new List<GetSQERTDetails_output>();

            DataTable SQERTkDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_GetSQERTList " + "null" + "," + parameters.ProjectID + "," + "null" +"," + "null" +"," +" null"+ "," + "null" +","+
                                                                                   "'"+ parameters.CurrentDate +"'" + "," + parameters.TagValue + "," + parameters.UserID + "," + "null" + "," + parameters.LoginType

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in SQERTkDataTable.Rows)
            {
                GetSQERTDetails_output CC = new GetSQERTDetails_output();
                CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());
                CC.ProjectName = dr["ProjectName"].ToString();
                CC.ReportingDate = dr["ReportingDate"].ToString();
                CC.Scope = Convert.ToDecimal(dr["Scope"].ToString());
                CC.Quality = Convert.ToDecimal(dr["Quality"].ToString());
                CC.Effort = Convert.ToDecimal(dr["Effort"].ToString());
                CC.Risk = Convert.ToDecimal(dr["Risk"].ToString());
                CC.Time = Convert.ToDecimal(dr["Time"].ToString());
                CC.ExpectedStartDate = dr["ExpectedStartDate"].ToString();
                CC.ExpectedEndDate = dr["ExpectedEndDate"].ToString();


                listOfSQERT.Add(CC);
            }
            return listOfSQERT;

        }

        [Authorize]
        [HttpPost]
        public List<getSQERTRange_output> GetSQERTRange()
        {
            DataTable FillBGDatatable;
            List<getSQERTRange_output> listOfRange = new List<getSQERTRange_output>();
            string strSQL = "usp_Whizible2_ProjectHealthSheet_sel_SQERT_tbl_PRS_SQERT_Ranges";

            FillBGDatatable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            foreach (DataRow dr in FillBGDatatable.Rows)
            {
                getSQERTRange_output CC = new getSQERTRange_output();
                CC.RangeID = Convert.ToInt32(dr["RangeID"].ToString());
                CC.LowerLow = Convert.ToInt32(dr["LowerLow"].ToString());
                CC.LowerHigh = Convert.ToInt32(dr["LowerHigh"].ToString());
                CC.MiddleLow = Convert.ToInt32(dr["MiddleLow"].ToString());
                CC.MiddleHigh = Convert.ToInt32(dr["MiddleHigh"].ToString());
                CC.UpperLow = Convert.ToInt32(dr["UpperLow"].ToString());
                CC.UpperHigh = Convert.ToInt32(dr["UpperHigh"].ToString());
                
                listOfRange.Add(CC);
            }
            return listOfRange;
        }

        //SQERT Section
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<getSQERTSection_output> GetSQERTSection([FromBody] GetSQERTDetails_input parameters)
        {
            List<getSQERTSection_output> listOfSQERT = new List<getSQERTSection_output>();

            DataTable SQERTDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_SQERT " + parameters.ProjectID + "," +
                                                                                   "'" + parameters.CurrentDate + "'" + "," + parameters.UserID + ","  + parameters.LoginType

                                                                               , true, CommonController.connectionString);


            foreach (DataRow dr in SQERTDataTable.Rows)
            {
                getSQERTSection_output CC = new getSQERTSection_output();
               
                CC.Scope = Convert.ToInt32(dr["Scope"].ToString());
                CC.Quality = Convert.ToInt32(dr["Quality"].ToString());
                CC.Effort = Convert.ToInt32(dr["Effort"].ToString());
                CC.Risk = Convert.ToInt32(dr["Risk"].ToString());
                CC.Time = Convert.ToInt32(dr["Time"].ToString());
                CC.ScopeDesc = dr["ScopeDesc"].ToString();
                CC.QualityDesc = dr["QualityDesc"].ToString();
                CC.EffortDesc= dr["EffortDesc"].ToString();
                CC.RiskDesc = dr["RiskDesc"].ToString();
                CC.TimeDesc = dr["TimeDesc"].ToString();
              
                listOfSQERT.Add(CC);
            }
            return listOfSQERT;

        }

        // UPDATE SQERT SECTION WINDOW
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<getSQERTDataInsideWindow_output> DataonUpdateSQERTClick([FromBody] GetSQERTDetails_input parameters)
        {
            List<getSQERTDataInsideWindow_output> listOfSQERT = new List<getSQERTDataInsideWindow_output>();

            DataTable SQERTDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_GetSQERTValues_inSideWindow " + parameters.ProjectID 
                                                                                 , true, CommonController.connectionString);


            foreach (DataRow dr in SQERTDataTable.Rows)
            {
                getSQERTDataInsideWindow_output CC = new getSQERTDataInsideWindow_output();

                CC.SQERTID = Convert.ToInt32(dr["SQERTID"].ToString());             
                CC.Quality = Convert.ToInt32(dr["Quality"].ToString());
                CC.Scope = Convert.ToInt32(dr["Scope"].ToString());
                CC.Effort = Convert.ToInt32(dr["Effort"].ToString());
                CC.Risk = Convert.ToInt32(dr["Risk"].ToString());
                CC.Time = Convert.ToInt32(dr["Time"].ToString());          
                CC.QualityDesc = dr["QualityDesc"].ToString();
                CC.ScopeDesc = dr["ScopeDesc"].ToString();
                CC.EffortDesc = dr["EffortDesc"].ToString();
                CC.RiskDesc = dr["RiskDesc"].ToString();
                CC.TimeDesc = dr["TimeDesc"].ToString();
                CC.Locked = Convert.ToBoolean(dr["Locked"].ToString());
                CC.GeneralRemarks = dr["GeneralRemarks"].ToString();
                CC.Escalations = dr["Escalations"].ToString();

                listOfSQERT.Add(CC);
            }
            return listOfSQERT;

        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<getEffortTimeRisk_output> GetEffortTimeRisk([FromBody] GetSQERTDetails_input parameters)
        {
            List<getEffortTimeRisk_output> listOfSQERT = new List<getEffortTimeRisk_output>();

            DataTable SQERTDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Sel_EarnedValueReportvalues " +  "'"+ parameters.CurrentDate +"'"+ ","+  parameters.ProjectID
                                                                                 , true, CommonController.connectionString);


            foreach (DataRow dr in SQERTDataTable.Rows)
            {
                getEffortTimeRisk_output CC = new getEffortTimeRisk_output();
                CC.title = dr["title"].ToString();
                CC.titleValue = Convert.ToDecimal(dr["titleValue"].ToString());                            
                listOfSQERT.Add(CC);
            }
            return listOfSQERT;

        }

        // SAVE SQERT VALUE
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public void SaveSQERTValue([FromBody]saveSQERTValue_input parameters)
        {
            CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_InsertSQERTValues " + parameters.ProjectID + "," + "'" + parameters.CurrentDate + "'" + "," + parameters.Scope + "," + parameters.Quality + ","
                                                                                  + parameters.Effort + "," + parameters.Risk + "," + parameters.Time +"," + "'" + parameters.ScopeDesc +"'" + "," + "'"+ parameters.QualityDesc +"'" +"," + "'"+ parameters.EffortDesc +"'" + ","
                                                                                  + "'" + parameters.RiskDesc  +"'" + "," + "'" + parameters.TimeDesc  +"'" + "," + parameters.UserID + "," + "'"+  parameters.GeneralRemarks +"'" + "," + "'" + parameters.Escalations + "'" +"," + parameters.SQERTID
                                                                               , true, CommonController.connectionString);

        }

        // SHOW HISTORY
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<showhistory_output> ShowHistory([FromBody] GetSQERTDetails_input parameters)
        {
            List<showhistory_output> listOfSQERT = new List<showhistory_output>();

            DataTable SQERTDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_ShowHistory " +  parameters.ProjectID
                                                                                 , true, CommonController.connectionString);


            foreach (DataRow dr in SQERTDataTable.Rows)
            {
                showhistory_output CC = new showhistory_output();
               CC.SQERTID = Convert.ToInt32(dr["SQERTID"].ToString());              
               CC.ProjectID = Convert.ToInt32(dr["ProjectID"].ToString());              
                CC.ReportingDate = dr["ReportingDate"].ToString();
                CC.Scope = Convert.ToInt32(dr["Scope"].ToString());
                CC.Quality = Convert.ToInt32(dr["Quality"].ToString());
                CC.Effort = Convert.ToInt32(dr["Effort"].ToString());
                CC.Risk = Convert.ToInt32(dr["Risk"].ToString());
                CC.Time = Convert.ToInt32(dr["Time"].ToString());
                CC.ScopeDesc = dr["ScopeDesc"].ToString();
                CC.QualityDesc = dr["QualityDesc"].ToString();
                CC.EffortDesc = dr["EffortDesc"].ToString();
                CC.RiskDesc = dr["RiskDesc"].ToString();
                CC.TimeDesc = dr["TimeDesc"].ToString();
                CC.CreatedBy = dr["CreatedBy"].ToString();
                CC.CreatedDate = dr["CreatedDate"].ToString();
                CC.Locked = Convert.ToBoolean(dr["Locked"].ToString());
                CC.LockedDate = dr["LockedDate"].ToString();
                CC.GeneralRemarks = dr["GeneralRemarks"].ToString();
                CC.Escalations = dr["Escalations"].ToString();




                listOfSQERT.Add(CC);
            }
            return listOfSQERT;

        }

        // KEY ACHIEVEMENT IN NOTICE PERIOD
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<keyAchievement_output> KeyAchievement([FromBody] KeyAchievement_input parameters)
        {
            List<keyAchievement_output> listOfSQERT = new List<keyAchievement_output>();

            DataTable SQERTDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_GetNoOfTaskCompletedForPeriod_Count " + parameters.ProgramID + "," + parameters.ProjectID +","+ parameters.CategoryID + "," + parameters.BusinessID + ","  + 
                                                                          parameters.OrganizationID  + ","  + "'" + parameters.ReportingEndDate + "'" + "," + parameters.UserID
                                                                                 , true, CommonController.connectionString);


            foreach (DataRow dr in SQERTDataTable.Rows)
            {
                keyAchievement_output CC = new keyAchievement_output();
               CC.CompletedTasks = Convert.ToInt32(dr["CompletedTasks"].ToString());
                CC.TobeCompletedTasks = Convert.ToInt32(dr["TobeCompletedTasks"].ToString());
                CC.SlippingTasks= Convert.ToInt32(dr["SlippingTasks"].ToString());
                CC.TotalPlannedTasks= Convert.ToInt32(dr["TotalPlannedTasks"].ToString());
                CC.CompletedDeliverables= Convert.ToInt32(dr["CompletedDeliverables"].ToString());
                CC.SlippingDeliverables= Convert.ToInt32(dr["SlippingDeliverables"].ToString());
                CC.TobeCompletedDeliverables= Convert.ToInt32(dr["TobeCompletedDeliverables"].ToString());
                CC.TotalPlannedDeliverables= Convert.ToInt32(dr["TotalPlannedDeliverables"].ToString());
               
                listOfSQERT.Add(CC);
            }
            return listOfSQERT;

        }

        // ISSUE DETAILS
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<issuedetail_output> IssueDetails([FromBody] KeyAchievement_input parameters)
        {
            List<issuedetail_output> listOfIssue = new List<issuedetail_output>();

            DataTable IssueDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Get_OpenAndClosedIssuestypes " + parameters.ProgramID + "," + parameters.ProjectID + "," + parameters.CategoryID + "," + parameters.BusinessID + "," +
                                                                          parameters.OrganizationID + "," + "'" + parameters.ReportingEndDate + "'" + "," + parameters.UserID
                                                                                 , true, CommonController.connectionString);


            foreach (DataRow dr in IssueDataTable.Rows)
            {
                issuedetail_output CC = new issuedetail_output();
                CC.Type = dr["Type"].ToString();
                CC.totalissues = Convert.ToInt32(dr["totalissues"].ToString());
                CC.openissues = Convert.ToInt32(dr["openissues"].ToString());
                CC.closeissues = Convert.ToInt32(dr["closeissues"].ToString());
                CC.OTHERSissues = Convert.ToInt32(dr["OTHERSissues"].ToString());
                CC.LessThanFive = Convert.ToInt32(dr["LessThanFive"].ToString());
                CC.BetweenFiveAndTen = Convert.ToInt32(dr["BetweenFiveAndTen"].ToString());
                CC.MoreThanTen = Convert.ToInt32(dr["MoreThanTen"].ToString());
                CC.OverDueIssues = Convert.ToInt32(dr["OverDueIssues"].ToString());
                CC.ShownToCustomer = Convert.ToInt32(dr["ShownToCustomer"].ToString());


                listOfIssue.Add(CC);
            }
            return listOfIssue;

        }

        // INDIVIDUAL ISSUE DETAILS
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<individualIssuedetail_output> IndividualIssueDetails([FromBody] individualIssuedetail_input parameters)
        {
            List<individualIssuedetail_output> listOfIssue = new List<individualIssuedetail_output>();

            DataTable IssueDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_Get_IndividualCountDetails " + parameters.ProgramID + "," + parameters.ProjectID + "," + parameters.CategoryID + "," + parameters.BusinessID + "," +
                                                                          parameters.OrganizationID + "," + "'" + parameters.ReportingEndDate + "'" + "," + parameters.UserID + "," + parameters.Flag + "," + "'" + parameters.StrIssueType + "'"
                                                                                 , true, CommonController.connectionString);


            foreach (DataRow dr in IssueDataTable.Rows)
            {
                individualIssuedetail_output CC = new individualIssuedetail_output();
                CC.IssueID = Convert.ToInt32(dr["IssueID"].ToString());
                CC.ProjectName = dr["ProjectName"].ToString();
                CC.Summary = dr["Summary"].ToString();
                CC.ReportedDate = dr["ReportedDate"].ToString();
                CC.Type = dr["Type"].ToString();
                CC.SubType = dr["SubType"].ToString();
                CC.Priority = dr["Priority"].ToString();
                CC.Severity = dr["Severity"].ToString();
                CC.Status = dr["Status"].ToString();
                CC.DueDate = dr["DueDate"].ToString();
                CC.ReportedBy = dr["ReportedBy"].ToString();


                listOfIssue.Add(CC);
            }
            return listOfIssue;

        }

        //BASE LINE
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public List<baseline_output> FetchBaseLine([FromBody] baseline_input parameters)
        {
            List<baseline_output> listOfIssue = new List<baseline_output>();

            DataTable IssueDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_ProjectHealthSheet_BaselineDetails " + parameters.ProgramID + "," + parameters.ProjectID + "," + parameters.ProjectTypID + "," + parameters.BusinessGroupID + "," +
                                                                          parameters.LocationID + "," + "'" + parameters.EndDate + "'" + "," + parameters.UserID 
                                                                                 , true, CommonController.connectionString);


            foreach (DataRow dr in IssueDataTable.Rows)
            {
                baseline_output CC = new baseline_output();
               
                CC.ProjectName = dr["ProjectName"].ToString();
                CC.ReasonForRevision = dr["ReasonForRevision"].ToString();
                CC.RevisionDate = dr["RevisionDate"].ToString();
                CC.EstimatedEffort = Convert.ToInt32(dr["EstimatedEffort"].ToString());
                CC.ExpectedEnddate = dr["ExpectedEnddate"].ToString();


                listOfIssue.Add(CC);
            }
            return listOfIssue;

        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public DataTable GetEVDetails([FromBody]EVDetails EVDetails)
        {

            string strSQL = "EXEC usp_Whizible2_Sel_EarnedValueReport '" + HttpUtility.UrlDecode(Convert.ToString(EVDetails.ReportingStartDate)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(EVDetails.ReportingEndDate)) + "'," 
                + HttpUtility.UrlDecode(Convert.ToString(EVDetails.ProjectID));
            DataTable dt = new DataTable();
            dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            return dt;

        }

        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        [HttpPost]
        public object GetEvIsApplicable([FromBody]EVDetails EVDetails)
        {

            string strSQL = "EXEC usp_Whizible2_sel_EVApp_tbl_PM_Project " + HttpUtility.UrlDecode(Convert.ToString(EVDetails.ProjectID));
            object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
            return dt;

        }

       
        string ProjectStartDate = "";
        EVDetails EVGraphDetails = new EVDetails();

        [HttpPost]
        //Added by imran on 15-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 15-09-2022
        public HttpResponseMessage GetReportGraphForEV(EVDetails EVDetails)
        {
            HttpRequestMessage request = new HttpRequestMessage();
            
            string strSQL1 = "";
            string strSQL = "";
            string strSQL2 = "";

            try
            {
                DataTable dt = CommonFunctions.Data.GetDataTable("usp_Whizible2_RPT_GetProjectandProgramdetails " + HttpUtility.UrlDecode(Convert.ToString(EVDetails.ProjectID)), true, CommonController.connectionString);

                foreach (DataRow dr in dt.Rows)
                {

                    ProjectStartDate = dr["ExpectedStartDate"].ToString();

                    strSQL = "Exec usp_Whizible2_CRW_EarnedValueReportDetails "
                        + HttpUtility.UrlDecode(Convert.ToString(EVDetails.ProjectID))
                        + ",'" + ProjectStartDate + "','"
                        + HttpUtility.UrlDecode(Convert.ToString(EVDetails.ReportingEndDate)) + "'";

                    strSQL1 = strSQL + ",2"; // For EV
                    strSQL2 = strSQL + ",3"; // For AC
                    strSQL = strSQL + ",1"; // For PV and Total Budget  
                    EVGraphDetails.PVandTotalBudgetReportDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    EVGraphDetails.EVReportDetails = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);
                    EVGraphDetails.ACReportDetails = CommonFunctions.Data.GetDataTable(strSQL2, true, CommonController.connectionString);
                    
                }

                
                var configuration = new HttpConfiguration();
                request.SetConfiguration(configuration);
                return request.CreateResponse(HttpStatusCode.OK, EVGraphDetails);
            }
            catch (Exception e)
            {

                return request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
            }

        }
    }
}
