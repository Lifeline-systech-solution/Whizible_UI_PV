using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.DashBoard;

namespace WhizibleAPI.Controllers
{
    public class DashBoardInfoController : ApiController
    {
        [HttpPost]
        [Authorize]
        public DashBoardDemo GetResourceUtilization([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.DashboardCustLists = new List<DashBoardCustomerDetails>();

            DashboardTable = CommonFunctions.Data.GetDataTable("usp_Sel_CDE_ResourceUtilizationDetails_Customer " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intWeek + "," + dashboardParameters.intCustomerID + "," + dashboardParameters.Flag + "", true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                DashBoardCustomerDetails DashboardCList = new DashBoardCustomerDetails()
                {
                    Monthname = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "")),
                    CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["CustomerName"], "")),
                    Available = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Available"], "0")),
                    Utilization = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Utilization"], "0")),
                    Invoiced = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Invoiced"], "0")),
                    WeekNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["WeekNumber"], "0")),
                };

                dashBoard.DashboardCustLists.Add(DashboardCList);
            }

            return dashBoard;
        }

        [HttpPost]
        [Authorize]
        public DashBoardDemo GetResourceUtilizationSkill([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.DashboardSkillLists = new List<DashBoardSkillDetails>();
            if (dashboardParameters.Flag == "week")
            {
                DashboardTable = CommonFunctions.Data.GetDataTable("usp_Sel_ResourceskillUtilizationDetails_weekly_Skills_Graph " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intWeek + "," + dashboardParameters.intSkillID + "", true, CommonController.connectionString);
                foreach (DataRow drDashBoardRow in DashboardTable.Rows)
                {
                    DashBoardSkillDetails DashboardSList = new DashBoardSkillDetails()
                    {
                        SkillName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Skillname"], "")),
                        WeekNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["weeknumber"], "0")),
                        ResourceCapacity = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceCapacity"], "0")),
                        ResourceAllocated = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceAllocated"], "0")),
                        OpportunityReq = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["OpportunityReq"], "0")),
                        ResourceBench = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceBench"], "0")),
                        //Commented & Added By Dipali V on 4th July 2019 For Dashboard Conversion Issue
                        //ResourceRelease = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceRelease"], "")),
                        ResourceRelease = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceRelease"], "0")),
                        //End of Commented & Added By Dipali V on 4th July 2019 For Dashboard Conversion Issue
                        ResourceShort_Surplus = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceShort_Surplus"], "0")),
                    };

                    dashBoard.DashboardSkillLists.Add(DashboardSList);
                }
            }
            else
            {
                DashboardTable = CommonFunctions.Data.GetDataTable("usp_SEL_ResourceStaffingPlan_Monthly_Skills_Graph " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intSkillID + "", true, CommonController.connectionString);
                foreach (DataRow drDashBoardRow in DashboardTable.Rows)
                {
                    DashBoardSkillDetails DashboardSList = new DashBoardSkillDetails()
                    {
                        SkillName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Skillname"], "")),
                        MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "0")),
                        ResourceCapacity = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceCapacity"], "")),
                        ResourceAllocated = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceAllocated"], "0")),
                        OpportunityReq = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["OpportunityReq."], "0")),
                        ResourceBench = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceBench"], "0")),
                        ResourceRelease = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceRelease"], "0")),
                        ResourceShort_Surplus = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ResourceShort_Surplus"], "0")),
                    };

                    dashBoard.DashboardSkillLists.Add(DashboardSList);
                }
            }


            return dashBoard;
        }


        [HttpPost]
        [Authorize]
        public DashBoardDemo GetResourceUtilizationSkill_Short_Surplus([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.DashboardSurplusLists = new List<DashBoardSkillShortSurplusDetails>();
            if (dashboardParameters.Flag == "week")
            {
                DashboardTable = CommonFunctions.Data.GetDataTable("usp_Sel_ResourceskillCostDetails_weekly_Skills_Graph " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intWeek + "," + dashboardParameters.intSkillID + "", true, CommonController.connectionString);

                foreach (DataRow drDashBoardRow in DashboardTable.Rows)
                {
                    DashBoardSkillShortSurplusDetails DashboardSurplusList = new DashBoardSkillShortSurplusDetails()
                    {
                        SkillName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Skillname"], "")),
                        WeekNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["weeknumber"], "0")),
                        MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "")),
                        SumofCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["SumofCost"], "0")),
                        SumofLostBillability = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["SumofLostBillability"], "0")),

                    };

                    dashBoard.DashboardSurplusLists.Add(DashboardSurplusList);
                }
            }
            else
            {
                DashboardTable = CommonFunctions.Data.GetDataTable("usp_SEL_ResourceStaffing_Short_Surplus_Cost_Billablity_Monthly_Skills_Graph " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intSkillID + "", true, CommonController.connectionString);

                foreach (DataRow drDashBoardRow in DashboardTable.Rows)
                {
                    DashBoardSkillShortSurplusDetails DashboardSurplusList = new DashBoardSkillShortSurplusDetails()
                    {
                        SkillName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Skillname"], "")),
                        //WeekNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["weeknumber"], "0")),
                        MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "")),
                        SumofCost = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["SumofCost"], "0")),
                        SumofLostBillability = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["SumofLostBillability"], "0")),

                    };

                    dashBoard.DashboardSurplusLists.Add(DashboardSurplusList);
                }
            }
            return dashBoard;
        }


        [HttpPost]
        [Authorize]
        public DashBoardDemo GetProjectRevenue_Projection([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.DashboardProjectRevenueLists = new List<DashBoardProjectRevenue_ProjectionDetails>();

            DashboardTable = CommonFunctions.Data.GetDataTable("usp_Sel_ProjectRevenue_Projection " + dashboardParameters.intYear + "," + dashboardParameters.Quarter + "," + dashboardParameters.strMonth + "," + dashboardParameters.intWeek + ",'"+ dashboardParameters.Flag +"'", true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                DashBoardProjectRevenue_ProjectionDetails DashboardProjectRevenueList = new DashBoardProjectRevenue_ProjectionDetails()
                {
                   
                    CountQuarterMilestone = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["CountQuarterMilestone"], "0")),
                    Commercial_Value = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Commercial_Value"], "0")),
                    MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "")),
                    CountMonthMileStone = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["CountMonthMileStone"], "0")),
                    WeekNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["WeekNumber"], "0")),
                    Quarter = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Quarter"], "")),

                };

                dashBoard.DashboardProjectRevenueLists.Add(DashboardProjectRevenueList);
            }

            return dashBoard;
        }

        [HttpPost]
        [Authorize]
        public DashBoardDemo GetProjectRevenue_Recognition([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.DashboardProjectRevenueRecogLists = new List<DashBoardProjectRevenue_RecognitionDetails>();

            DashboardTable = CommonFunctions.Data.GetDataTable("USP_SEL_Revenue_Recognition " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intProjectID + ","+ dashboardParameters.intWeek + ",'"+ dashboardParameters.Flag +"'", true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                DashBoardProjectRevenue_RecognitionDetails DashboardProjectRevenueRecogList = new DashBoardProjectRevenue_RecognitionDetails()
                {
                    MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "")),
                    Quarter = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Quarter"], "")),
                    //ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["ProjectName"], "")),
                    //commented and Added B y Nikhil A on 27-May-2020 for solving the exponertial value crash 
                    //Amount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Amount"], "0")),
                    Amount = float.Parse(Convert.ToDouble((CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Amount"], "0"))).ToString()),
                    //End commented and Added B y Nikhil A on 27-May-2020 for solving the exponertial value crash 
                    //TotalAmount = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["QuarterTotal"], "0")),
                };

                dashBoard.DashboardProjectRevenueRecogLists.Add(DashboardProjectRevenueRecogList);
            }

            return dashBoard;
        }

        [HttpPost]
        [Authorize]
        public DashBoardDemo GetProjectRevenue_Realization([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.DashboardProjectRevenueRealLists = new List<DashBoardProjectRevenue_RealizationDetails>();

            DashboardTable = CommonFunctions.Data.GetDataTable("usp_sel_RevenueRealization " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intProjectID + ","+ dashboardParameters.intWeek +",'"+ dashboardParameters.Flag +"'", true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                DashBoardProjectRevenue_RealizationDetails DashboardProjectRevenueRealList = new DashBoardProjectRevenue_RealizationDetails()
                {
                    MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "")),
                    Quarter = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Quarter"], "")),
                    //ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Projectname"], "")),
                    InvoicePayment = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["InvoicePayment"], "0")),
                    //TotalInvoicePayment = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["TotalSumInvoicePayment"], "0")),
                };

                dashBoard.DashboardProjectRevenueRealLists.Add(DashboardProjectRevenueRealList);
            }

            return dashBoard;
        }

        [HttpPost]
        [Authorize]
        public DashBoardDemo GetProjectCompletion_Payment([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.DashboardProjectCompl_PayLists = new List<DashBoardProjectCompletion_PaymentDetails>();

            DashboardTable = CommonFunctions.Data.GetDataTable("usp_sel_ProjectCompletion_PaymentPercentage " + dashboardParameters.intYear + "," + dashboardParameters.intMonth + "," + dashboardParameters.intProjectID + ","+ dashboardParameters.intWeek +",'"+ dashboardParameters.Flag +"'", true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                DashBoardProjectCompletion_PaymentDetails DashboardProjectCompl_PayList = new DashBoardProjectCompletion_PaymentDetails()
                {
                    MonthName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["MonthName"], "")),
                    ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Projectname"], "")),
                    WeekNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["WeekNumber"], "")),
                    CountMileStone = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["CountMileStone"], "0")),
                    Sum_CompletionPercentage = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["TotalSum_CompletionPercentage"], "0")),
                    Sum_PaymentPercentage = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["TotalSum_PaymentPercentage"], "0")),

                };

                dashBoard.DashboardProjectCompl_PayLists.Add(DashboardProjectCompl_PayList);
            }

            return dashBoard;
        }

        //Get values of dependent combobox
        [HttpPost]
        [Authorize]
        public DashBoardDemo GetDependent_ComboBox([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.objDependent_ComboBox = new List<Dependent_ComboBox>();
            string strSQL;
            strSQL = "usp_sel_tbl_PM_ResourceUtilizationDetails_Weekly_Customer_Year_Month_Week '"+ dashboardParameters.cboType +"'";

            if (dashboardParameters.intYear != null)
            {
                strSQL += "," + dashboardParameters.intYear + "";
            }
            if(dashboardParameters.intMonth != null)
            {
                strSQL += "," + dashboardParameters.intMonth + "";
            }
            DashboardTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                Dependent_ComboBox Dashboard_Cbo = new Dependent_ComboBox()
                {
                    CboID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Value"], "0")),
                    CboName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["UniqueText"], "")),
                    
                };

                dashBoard.objDependent_ComboBox.Add(Dashboard_Cbo);
            }

            return dashBoard;
        }


        //Get values of dependent combobox
        [HttpPost]
        [Authorize]
        public DashBoardDemo GetDependent_ComboBoxSkill([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.objDependent_ComboBox = new List<Dependent_ComboBox>();
            string strSQL;
            strSQL = "usp_sel_tbl_PM_ResourceSkillDetails_Weekly_Skill_Year_Month_Week '" + dashboardParameters.cboType + "'";

            if (dashboardParameters.intYear != null)
            {
                strSQL += "," + dashboardParameters.intYear + "";
            }
            if (dashboardParameters.intMonth != null)
            {
                strSQL += "," + dashboardParameters.intMonth + "";
            }
            DashboardTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                Dependent_ComboBox Dashboard_Cbo = new Dependent_ComboBox()
                {
                    CboID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Value"], "0")),
                    CboName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["UniqueText"], "")),

                };

                dashBoard.objDependent_ComboBox.Add(Dashboard_Cbo);
            }

            return dashBoard;
        }

        [HttpPost]
        [Authorize]
        public DashBoardDemo GetDependent_ComboBoxRev([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.objDependent_ComboBox = new List<Dependent_ComboBox>();
            string strSQL;
            strSQL = "usp_Sel_ProjectRevenue_Recognition_Realization_Year_Quarter_Project '" + dashboardParameters.cboType + "'";

            if (dashboardParameters.intYear != null)
            {
                strSQL += "," + dashboardParameters.intYear + "";
            }
            if (dashboardParameters.intMonth != null)
            {
                strSQL += "," + dashboardParameters.intMonth + "";
            }
            DashboardTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                Dependent_ComboBox Dashboard_Cbo = new Dependent_ComboBox()
                {
                    CboID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Value"], "0")),
                    CboName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["UniqueText"], "")),

                };

                dashBoard.objDependent_ComboBox.Add(Dashboard_Cbo);
            }

            return dashBoard;
        }

        [HttpPost]
        [Authorize]
        public DashBoardDemo GetDependent_ComboBoxMile([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.objDependent_ComboBox = new List<Dependent_ComboBox>();
            string strSQL;
            strSQL = "usp_Sel_ProjectRevenue_Projection_Year_Quarter_Month '" + dashboardParameters.cboType + "'";

            if (dashboardParameters.intYear != null)
            {
                strSQL += "," + dashboardParameters.intYear + "";
            }
            if (dashboardParameters.Quarter != null)
            {
                strSQL += ",'" + dashboardParameters.Quarter + "'";
            }
            if (dashboardParameters.intMonth != null)
            {
                strSQL += "," + dashboardParameters.intMonth + "";
            }
            DashboardTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                Dependent_ComboBox Dashboard_Cbo = new Dependent_ComboBox()
                {
                    CboID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Value"], "0")),
                    CboName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["UniqueText"], "")),

                };

                dashBoard.objDependent_ComboBox.Add(Dashboard_Cbo);
            }

            return dashBoard;
        }


        [HttpPost]
        [Authorize]
        public DashBoardDemo GetDependent_ComboBoxCompl([FromBody]DashBoardParameter dashboardParameters)
        {
            DataTable DashboardTable;
            DashBoardDemo dashBoard = new DashBoardDemo();

            dashBoard.objDependent_ComboBox = new List<Dependent_ComboBox>();
            string strSQL;
            strSQL = "usp_Sel_ProjectCompletion_Payment_Year_Month_Project '" + dashboardParameters.cboType + "'";

            if (dashboardParameters.intYear != null)
            {
                strSQL += "," + dashboardParameters.intYear + "";
            }
            if (dashboardParameters.intMonth != null)
            {
                strSQL += "," + dashboardParameters.intMonth + "";
            }
            DashboardTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            foreach (DataRow drDashBoardRow in DashboardTable.Rows)
            {
                Dependent_ComboBox Dashboard_Cbo = new Dependent_ComboBox()
                {
                    CboID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["Value"], "0")),
                    CboName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drDashBoardRow["UniqueText"], "")),

                };

                dashBoard.objDependent_ComboBox.Add(Dashboard_Cbo);
            }

            return dashBoard;
        }


        public class DashBoardParameter
        {
            public int intYear { get; set; }
            public int intMonth { get; set; }
            public int intWeek { get; set; }
            public int intCustomerID { get; set; }
            public int intSkillID { get; set; }
            public string Quarter { get; set; }
            public string strMonth { get; set; }
            public int intProjectID { get; set; }
            public string Flag { get; set; }
            public string cboType { get; set; }
        }

    }
}
