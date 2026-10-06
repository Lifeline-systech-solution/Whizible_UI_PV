using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Http;
//using WhizibleAPI.Models.PM;
using WhizibleAPI.Models.PM_CommercialDashboard;
using System.Data.SqlClient;
using System.Linq;
using System.Configuration;
using System.Globalization;
using System.Net.Http;
using System.Net;

namespace WhizibleAPI.Controllers
{
    public class PM_ProjectCommercialDashboardController : ApiController
    {

        //Added by RehanC on 7th April 2023
        [Authorize, App_Start.ValidateHeaders]
        //End of Comment by RehanC on 7th April 2023
        [HttpPost]

        ////public List<FillProjectParameters> GetProjectListDependingOnSelection([FromBody]defaultFilterParameters parameters)
        public object GetProjectListDependingOnSelection([FromBody] defaultFilterParameters parameters)

        {
            try
            {
                DataTable FillProjectDatatable;
                List<FillProjectParameters> listProjectName = new List<FillProjectParameters>();

                string strSQL = "usp_Whizible2_ProjectDashboard_GetComericalDashboardDetails" + "";
                strSQL = strSQL + "'" + HttpUtility.UrlDecode(parameters.UserID.ToString()) + "', '" + HttpUtility.UrlDecode(parameters.LoginID.ToString()) + "', " + HttpUtility.UrlDecode(parameters.Flag.ToString()) + " ";
                FillProjectDatatable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                // FillProjectDatatable = CommonFunctions.Data.GetDataTable(strSql, true, CommonController.connectionString);
                foreach (DataRow dr in FillProjectDatatable.Rows)
                {
                    FillProjectParameters CC = new FillProjectParameters()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(dr["ID"], "")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["ProjectName"], "")),
                        WhichType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dr["WhichType"], "")),
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
        // code ended here



        //Added by RehanC on 7th April 2023
        [Authorize, App_Start.ValidateHeaders]
        //End of Comment by RehanC on 7th April 2023
        [HttpPost]
        public object GetCommercialDetails([FromBody] PM_CommercialDashboardFilter filter)
        {


            try
            {
                PM_CommercialDashboard CommercialDetails = new PM_CommercialDashboard();
                DataTable CommercialDetailsDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_CommercialDashboard_GetOverallScoreDetails '" + filter.ProjectFilter + "',"
                                                                                    + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
                                                                                  , true, CommonController.connectionString);
                // for get OverallScore
                foreach (DataRow commercialRow in CommercialDetailsDataTable.Rows)
                {
                    OverallScore OverallScoreObj = new OverallScore
                    {




                        //Scroreno = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(commercialRow["Scroreno"], "0")),
                        //Schedule = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(commercialRow["Schedule"], "0")),
                        //Effort = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(commercialRow["Effort"], "0")),
                        //Cost = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(commercialRow["Cost"], "0")),

                        Scroreno = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["Scroreno"], "0")),
                        Schedule = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["Schedule"], "0")),
                        Effort = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["Effort"], "0")),
                        Cost = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["Cost"], "0")),



                        ScoreSchedule = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["ScoreSchedule"], "0")),
                        ScoreEffort = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["ScoreEffort"], "0")),
                        ScoreCost = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["ScoreCost"], "0")),


                        plannedCost = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["plannedCost"], "0")),
                        plannedRevenue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["plannedRevenue"], "0")),
                        plannedEffort = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["plannedEffort"], "0")),


                        ActualCost = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["ActualCost"], "0")),
                        ActualRevenue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["ActualRevenue"], "0")),
                        ActualEffort = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["ActualEffort"], "0")),




                        OverallRevenue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["OverallRevenue"], "0")),
                        OverallCost = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["OverallCost"], "0")),
                        OverallEfforts = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["OverallEfforts"], "0")),


                        OverallProjectRevenues = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["OverallProjectRevenues"], "0")),
                        OverallProjectCosts = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["OverallProjectCosts"], "0")),
                        OverallProjectEfforts = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(commercialRow["OverallProjectEfforts"], "0")),

                        //Quality = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(commercialRow["Quality"], "0"))
                    };
                    CommercialDetails.OverallScore = OverallScoreObj;
                }



                // for get NetGrossProfitability 
                DataTable NetGrossProfitabilityDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_CommercialDashboard_GetProfitabilityDetails '" + filter.ProjectFilter + "','" + filter.Whichgraph + "',"
                                                                                + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID + "," + filter.Count
                                                                                  , true, CommonController.connectionString);

                List<string> Projects = new List<string>();
                //Commented & Added By Dipali V On 4th Feb 2022 For Get Correct Value
                //List<int> Gross = new List<int>();
                //List<int> Net = new List<int>();
                List<string> Gross = new List<string>();
                List<string> Net = new List<string>();
                //End of Commented & Added By Dipali V On 4th Feb 2022 For Get Correct Value
                List<int> AccruedRevenue = new List<int>();
                List<int> AccruedCost = new List<int>();
                List<string> CurrencySymbol = new List<string>();
                //List<string> TotalProjectCount = new List<string>();

                foreach (DataRow netGrossProfitabilityRow in NetGrossProfitabilityDataTable.Rows)
                {
                    Projects.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["FlagDetailsName"], "")));
                    //Commented & Added By Dipali V On 4th Feb 2022 For Get Correct Value
                    Gross.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["Gross"], "0")));
                    //Gross.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["Gross"], "0")));
                    Net.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["Net"], "0")));
                    //Net.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["Net"], "0")));

                    CurrencySymbol.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["CurrencySymbol"], "")));
                    //Commented & Added By Dipali V On 4th Feb 2022 For Get Correct Value
                    //TotalProjectCount.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["TotalProjectCount"], "")));




                }
                CommercialDetails.NetGrossProfitability = new NetGrossProfitability
                {
                    Projects = Projects.ToArray(),
                    Gross = Gross.ToArray(),
                    Net = Net.ToArray(),
                    CurrencySymbol = CurrencySymbol.ToArray()
                };
                // for get AcruedRevenueCost
                DataTable AcruedRevenueCostDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_CommercialDashboard_GetAcruedRevenueCostDetails '" + filter.ProjectFilter + "','" + filter.Whichgraph + "'," + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID + "," + filter.Count
                                                                             , true, CommonController.connectionString);

                Projects = new List<string>();
                AccruedRevenue = new List<int>();
                AccruedCost = new List<int>();
                CurrencySymbol = new List<string>();
                foreach (DataRow acruedRevenueCostRow in AcruedRevenueCostDataTable.Rows)
                {
                    Projects.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(acruedRevenueCostRow["FlagDetailsName"], "")));
                    AccruedRevenue.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(acruedRevenueCostRow["AccruedRevenue"], "0")));
                    AccruedCost.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(acruedRevenueCostRow["AccruedCost"], "0")));
                    CurrencySymbol.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(acruedRevenueCostRow["CurrencySymbol"], "")));

                }
                CommercialDetails.AcruedRevenueCost = new AcruedRevenueCost
                {
                    Projects = Projects.ToArray(),
                    AccruedRevenue = AccruedRevenue.ToArray(),
                    AccruedCost = AccruedCost.ToArray(),
                    CurrencySymbol = CurrencySymbol.ToArray()
                };

                // for get DelayinRealization
                DataTable DelayinRealizationDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_CommercialDashboard_GetDelayinRealizationDetails '" + filter.ProjectFilter + "',"
                                                                               + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
                                                                             , true, CommonController.connectionString);

                List<string> DaysAging = new List<string>();
                List<string> Days = new List<string>();
                foreach (DataRow delayinRealizationRow in DelayinRealizationDataTable.Rows)
                {
                    DaysAging.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(delayinRealizationRow["DaysAging"], "")));
                    Days.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(delayinRealizationRow["Days"], "0")));
                }
                CommercialDetails.DelayinRealization = new DelayinRealization
                {
                    DaysAging = DaysAging.ToArray(),
                    Days = Days.ToArray()
                };

                // for get project data
                DataTable ProjectDataDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_CommercialDashboard_GetProjectDetails '" + filter.ProjectFilter + "',"
                                                                              + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
                                                                            , true, CommonController.connectionString);

                CommercialDetails.ProjectData = new List<CommercialProjectData>();
                foreach (DataRow projectRow in ProjectDataDataTable.Rows)
                {
                    CommercialProjectData CommercialProjectDataObj = new CommercialProjectData
                    {
                        ID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["ID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["ProjectName"], "")),
                        Type = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["Type"], "")),
                        TotalMilestone = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["TotalMilestone"], "0")),
                        Customer = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["Customer"], "")),
                        //OnOff = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["OnOff"], "")),
                        On = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["On"], "0")),
                        Off = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["Off"], "0")),
                        MilestoneBilling = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["MilestoneBilling"], "0")),
                        TotalBilling = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["TotalBilling"], "0")),
                        ProjectTotalAmount = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["ProjectTotalAmount"], "0")),
                        CurrencySymbol = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["CurrencySymbol"], "0")),

                        RPP = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["RPP"], "")),
                        AcruedRevenue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["AcruedRevenue"], "")),
                        AcruedCost = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["AcruedCost"], "")),
                        //Commented & Added By Dipali V On 4th Feb 2022 For Get Correct Value
                        //GrossProfitability = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["GrossProfitability"], "0")),
                        // NetProfitability = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["NetProfitability"], "0")),
                        GrossProfitability = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(projectRow["GrossProfitability"], "0")),
                        NetProfitability = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(projectRow["NetProfitability"], "0")),
                        //End of Commented & Added By Dipali V On 4th Feb 2022 For Get Correct Value
                        Overhead = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["Overhead"], "0")),
                        BufferEfforts = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["BufferEfforts"], "0")),
                        DelayinRealization = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectRow["DelayinRealization"], "0")),
                        CustomerConatctEmail = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["CustomerConatctEmail"], "")),
                        CustomerContactName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["CustomerContactName"], "")),
                        CustomerMobileNumber = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["CustomerMobileNumber"], "")),
                        RealizationBelowThreshold = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["RealizationBelowThreshold"], "")),
                        RealizationAboveThreshold = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectRow["RealizationAboveThreshold"], "")),

                    };
                    CommercialDetails.ProjectData.Add(CommercialProjectDataObj);

                }

                return CommercialDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        // METHODS ADDED BY VIDHI FOR POP UP WINDOW 

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







        //Added by RehanC on 7th April 2023
        [Authorize, App_Start.ValidateHeaders]
        //End of Comment by RehanC on 7th April 2023
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

        //Added by RehanC on 7th April 2023
        [Authorize, App_Start.ValidateHeaders]
        //End of Comment by RehanC on 7th April 2023
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
        //Added by RehanC on 7th April 2023
        [Authorize, App_Start.ValidateHeaders]
        //End of Comment by RehanC on 7th April 2023
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public void InsertDataIntoTable([FromBody]InsertDataIntoTable_InputParameter parameters)
        {
            CommonFunctions.Data.GetDataTable("usp_Whizible2_Ins_tbl_Whizible2_ProjectDashboard_PremiumProjects " + parameters.ProjectID + ","
                                                                                  + parameters.CreatedBy + "," + parameters.Priority + "," + parameters.Premium
                                                                               , true, CommonController.connectionString);

        }






        // END OF METHOD ADDED BY VIDHI FOR POP UPWINDOW 





















        //[Authorize]
        //[HttpPost]
        //public PM_CommercialDashboard GetDetailsTogglewise([FromBody]PM_CommercialDashboardFilter filter)
        //{
        //    PM_CommercialDashboard CommercialDetails = new PM_CommercialDashboard();
        //    // for get NetGrossProfitability 
        //    DataTable NetGrossProfitabilityDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_CommercialDashboard_GetProfitabilityDetails " + filter.ProjectFilter + ","
        //                                                                    + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
        //                                                                  , true, CommonController.connectionString);

        //    List<string> Projects = new List<string>();
        //    List<int> Gross = new List<int>();
        //    List<int> Net = new List<int>();
        //    foreach (DataRow netGrossProfitabilityRow in NetGrossProfitabilityDataTable.Rows)
        //    {
        //        Projects.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["Project"], "")));
        //        Gross.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["Gross"], "0")));
        //        Net.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(netGrossProfitabilityRow["Net"], "0")));
        //    }
        //    CommercialDetails.NetGrossProfitability = new NetGrossProfitability
        //    {
        //        Projects = Projects.ToArray(),
        //        Gross = Gross.ToArray(),
        //        Net = Net.ToArray()
        //    };


        //    // for get AcruedRevenueCost
        //    DataTable AcruedRevenueCostDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_CommercialDashboard_GetAcruedRevenueCostDetails " + filter.ProjectFilter + ","
        //                                                                   + filter.ProjectID + "," + filter.UserID + "," + filter.LoginID
        //                                                                 , true, CommonController.connectionString);

        //    Projects = new List<string>();
        //    Gross = new List<int>();
        //    Net = new List<int>();
        //    foreach (DataRow acruedRevenueCostRow in AcruedRevenueCostDataTable.Rows)
        //    {
        //        Projects.Add(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(acruedRevenueCostRow["Project"], "")));
        //        Gross.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(acruedRevenueCostRow["Gross"], "0")));
        //        Net.Add(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(acruedRevenueCostRow["Net"], "0")));
        //    }
        //    CommercialDetails.AcruedRevenueCost = new AcruedRevenueCost
        //    {
        //        Projects = Projects.ToArray(),
        //        Gross = Gross.ToArray(),
        //        Net = Net.ToArray()
        //    };

        //    CommercialDetails.ProjectData.Add(CommercialProjectDataObj);
        //    return CommercialDetails;
        //}

    }
      
}