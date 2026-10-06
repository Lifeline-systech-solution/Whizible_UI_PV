using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models;
using WhizibleAPI.Models;
using System.Web.Http;
using System.Web;
using System.IO;
using System.Configuration;
using System.Xml;
using Newtonsoft.Json;

namespace WhizibleAPI.Controllers
{
    public class ProjectDashboardController : ApiController
    {
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 16-09-2022
        [HttpPost]
        public object GetProjectTabeAccess([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                string strSQL = "usp_Whizible2_GetRoleAcessDashboard " + DashProject.RoleID + "";

                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetProjectList([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                //string strSQL = "";
                //Commented By Nilesh to get the project ShortJobTitle field appending on 11-01-2020
                //string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserID)) + "";

                //Added By Nilesh to get the project ShortJobTitle field appending on 11-01-2020
                string strSQL = "Exec usp_Whizible2_SelAccessibleProjectsForDashboard " + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserID)) + "";
                //End By Nilesh to get the project ShortJobTitle field appending on 11-01-2020


                //ControlID Added By Nilesh to reject the selectproject
                if (DashProject.ProjectID == 0)
                {
                    strSQL = strSQL + ", 0, 0, NULL, Null ,'" + HttpUtility.UrlDecode(DashProject.LoginType) + "', 1, 0, 0, 0, NULL, NULL, '" + HttpUtility.UrlDecode(Convert.ToString(DashProject.ControlID)) + "'";
                }
                else
                {
                    strSQL = strSQL + ", 0, 0, NULL, Null, '" + HttpUtility.UrlDecode(DashProject.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(DashProject.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(DashProject.ControlID)) + "'";
                }

                DataTable ProjectList;
                ProjectList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ProjectList;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetYearList([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                //string strSQL = "";

                string strSQL = "Exec usp_Whizible2_v_tbl_CNF_FinancialYear_Master ";
                DataTable Yearlist;
                Yearlist = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Yearlist;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetWeekList([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                //string strSQL = "";

                string strSQL = "Exec usp_sel_Week_tbl_Whizible2_SnapshotDetails " + DashProject.FinancialYearID + "";
                DataTable Weeklist;
                Weeklist = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Weeklist;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetTabWidgetDetails([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                //string strSQL = "";
                //Commented & Added By Dipali V On 15th Jan 2020 For LevelWise Graph
                //string strSQL = "Exec usp_Whizible2_ProjectWidgetDetails " + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserID)) + "," + HttpUtility.UrlDecode(Convert.ToString(DashProject.WhichTab)) + "";
                string strSQL = "Exec usp_Whizible2_ProjectWidgetDetails " + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserID)) + "," + HttpUtility.UrlDecode(Convert.ToString(DashProject.WhichTab)) + "," + HttpUtility.UrlDecode(Convert.ToString(DashProject.IsMyPluse)) + "";
                //End of Commented & Added By Dipali V On 15th Jan 2020 For LevelWise Graph
                DataTable WidgetDetails;
                WidgetDetails = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return WidgetDetails;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        public object GetAllGraphs([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                //string strSQL = "";
                //Commented & Added By Dipali V On 15th Jan 2020 For LevelWise Graph
                //string strSQL = "Exec usp_Sel_Whizible_GetAllGraphs " + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserID)) + "," + HttpUtility.UrlDecode(Convert.ToString(DashProject.WhichTab)) + "";
                string strSQL = "Exec usp_Sel_Whizible_GetAllGraphs " + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserID)) + "," + HttpUtility.UrlDecode(Convert.ToString(DashProject.WhichTab)) + "," + HttpUtility.UrlDecode(Convert.ToString(DashProject.IsMyPluse)) + "";
                //end of Commented & Added By Dipali V On 15th Jan 2020 For LevelWise Graph
                DataTable GetAllGraphs;
                GetAllGraphs = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return GetAllGraphs;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertAccessWiseWidg([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                string strSQL = "Exec usp_Ins_Upd_Whizible2_tbl_Whizible2_Tran_ProjectDashboard " + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserID));
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(DashProject.WID));
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(DashProject.WhichTab));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(DashProject.IsEnabledDisabled));
                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(DashProject.UserName));
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(DashProject.Isaccssible));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            //to GetProjectOverviewGraph

            //Added by imran on 16-09-2022
            [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object GetProjectOverviewGraph([FromBody] ProjectDashBaord DashProject)
        {
        	//Added By Usha Pandit On 25.08.2020 For Connection timeout exception
			try
			{
			//End Of Added By Usha Pandit On 25.08.2020 For Connection timeout exception
            string strSQL = "usp_Whizible2_Sel_ProjectEarnedValueOnTrackOffTrack ";
            if (DashProject.ProjectID == 0)
                strSQL += " NULL";
            else
                strSQL += "" + DashProject.ProjectID + "";

            strSQL += "," + DashProject.EmployeeID + "";

            if (DashProject.YearID == 0)
                strSQL += ",NULL";
            else
                strSQL += "," + DashProject.YearID + "";

            if (DashProject.WeekNo == 0)
                strSQL += ",NULL";
            else
                strSQL += "," + DashProject.WeekNo + "";

            strSQL += ",'" + DashProject.Command + "'";
            //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
            System.Data.DataTable dtable;
            dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            return dtable;
            //Added By Usha Pandit On 25.08.2020 For Connection timeout exception
        	}
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            //End Of Added By Usha Pandit On 25.08.2020 For Connection timeout exception
        }
        // to GetTaskOnTrackOverdueGraph

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object GetTaskOnTrackOverdueGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTask_OnTrackandOverDue ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getTasksFunnelGraph

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getTasksFunnelGraph([FromBody] ProjectDashBaord DashProject)
        {
            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectYetToStartAndOnHold ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To GetOverDueTaskByPriorityGraph
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object GetOverDueTaskByPriorityGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTask_PriorityWiseOverdue ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To getEffortStatusGraph
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getEffortStatusGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTask_EffortStatus ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getIssueStatusGraph

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getIssueStatusGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTask_IssueStatus ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getProjectTimeAndCostGraph
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getProjectTimeAndCostGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTask_ProjectTimeAndCost ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getProjectEffortVarienceGraph

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getProjectEffortVarienceGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTask_ProjectEffortVariance ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To getProjectSceduleVarienceGraph
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getProjectSceduleVarienceGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ScheduleVariancePercentage ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getProjectSPIGraph
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getProjectSPIGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_SchedulePerformanceIndicator_SPI ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getProjectCostVarienceGraph
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getProjectCostVarienceGraph([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_CostVariancePercentage ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To getProjectCompletionAndPaymentPercentage
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getProjectCompletionAndPaymentPercentage([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_sel_ProjectCompletion_PaymentPercentage ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getRiskMatrix

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getRiskMatrix([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTask_ProjectRiskMatrix ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getDefectDensity

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getDefectDensity([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectDefectDensity ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getTaskOverDueByResource        
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getTaskOverDueByResource([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectOverDueByResource ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To getTaskOverDueByDays
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getTaskOverDueByDays([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectOverDueByDays ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To getTaskOverAging
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        // public List<TaskAging> getTaskOverAging([FromBody] ProjectDashBaord DashProject)
        public object getTaskOverAging([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectOverDueAging ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                int GreaterThan5;
                int Between5To10;
                int Between10To15;
                int Between15To30;
                int BetweenLessThan30;
                List<TaskAging> taskAgingList = new List<TaskAging>();

                foreach (DataRow taskcountRow in dtable.Rows)
                {
                    TaskAging taskAging = new TaskAging()
                    {
                        GreaterThan5 = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["<5"], "0")),
                        Between5To10 = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["5-10"], "0")),
                        Between10To15 = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow["10-15"], "0")),
                        Between15To30 = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow[">15"], "0")),
                        BetweenLessThan30 = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskcountRow[">30"], "0"))
                    };
                    taskAgingList.Add(taskAging);
                }
                return taskAgingList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To getTaskStatusByProject
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getTaskStatusByProject([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectTaskStatusByProject ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To getMilestoneRevenueForecast
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getMilestoneRevenueForecast([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_MilestonesCommercialValueReport ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                //strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //To getRevenueRecognizationAndRealizationTrend
        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        public object getRevenueRecognizationAndRealizationTrend([FromBody] ProjectDashBaord DashProject)
        {

            try
            {
                string strSQL = "usp_Whizible2_Sel_MilestonesRevenueRecognitionRealizationReport ";
                if (DashProject.YearID == 0)
                    strSQL += "NULL";
                else
                    strSQL += "" + DashProject.YearID + "";

                if (DashProject.WeekNo == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.WeekNo + "";

                if (DashProject.ProjectID == 0)
                    strSQL += ",NULL";
                else
                    strSQL += "," + DashProject.ProjectID + "";

                strSQL += "," + DashProject.EmployeeID + "";



                //strSQL += ",'" + DashProject.Command + "'";
                //object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }
    public class TaskAging
    {
        public int GreaterThan5 { get; set; }
        public int Between5To10 { get; set; }
        public int Between10To15 { get; set; }
        public int Between15To30 { get; set; }
        public int BetweenLessThan30 { get; set; }
    }
    public class ProjectDashBaord
    {
        public int EmployeeID { get; set; }
        public int UserID { get; set; }
        public int RoleID { get; set; }
        public int ProjectID { get; set; }
        public string LoginType { get; set; }
        public string UserName { get; set; }
        public int WhichTab { get; set; }
        public int WID { get; set; }
        public int IsEnabledDisabled { get; set; }
        public int Isaccssible { get; set; }
        public int FinancialYearID { get; set; }
        public int YearID { get; set; }
        public int WeekNo { get; set; }
        public string Command { get; set; }
        public string ControlID { get; set; }
        public int IsMyPluse { get; set; }//Added By Dipali V On 15th Jan 2020 For LevelWise Graph Plotting


    }
}
