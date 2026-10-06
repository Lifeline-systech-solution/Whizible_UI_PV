using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    public class RequesterCustomerClientController : ApiController
    {
        //Method to get all count for Function fetchTicketCountForCustomerSelected
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetTicketCountForCustomerSelected([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_AllTicketsCount_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get Priority for Function fetchPriorityChart
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetPriorityPieChart([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {
                
                strSQL = "Exec usp_Whizible2_Sel_Priority_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //    //Method to get severity for Function fetchSeverityChart
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSeverityPieChart([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_Ticket_Severity_Wise_Count " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to get CR for Function loadCRData
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCRData([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_CR_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get New Tickets Created Monthly As Per Priority for Function fetchMonthlyPriorData
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetMonthlyPriorData([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_Monthly_Priority_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //    //Method to get Current Month data for Function fetchCurrentMonthData
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCurrentMonthData([FromBody] GetTicketCountRequest request)
        {
            try
            {
                
                string strSQL = "EXEC usp_Whizible2_sel_CurrMonth_tbl_CRM_Query_Master " + request.CustomerID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get Avg.FRT This Week for Function fetchGetAvgFRTThisWeek
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetAvgFRTThisWeek([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_AvgFRTThisWeek_tbl_CRM_Query_Master " + request.CustomerID;
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;
            }

            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get Avg.Resoultion This Week for Function fetchGetAvgResolThisWeek
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetAvgResolThisWeek([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_AvgResolThisWeek_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }

            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get Avg.Response This Week for Function fetchGetPerResLastWeek
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResLastWeek([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                

                strSQL = "Exec usp_Whizible2_Sel_ResLastWeek_tbl_CRM_Query_Master " + request.CustomerID;
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;
            }

            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get Avg.Resoultion This Week for Function fetchGetPerResolLastWeek
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResolLastWeek([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_ResolLastWeek_tbl_CRM_Query_Master " + request.CustomerID;
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;
            }

            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //    //Method to get Submitted Ticket Volume for Function fetchSubmittedStatMonthlyData
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSubStatMonthlyData([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {
                
                strSQL = "Exec usp_Whizible2_Sel_Stat_Subm_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get closed Ticket Volume for Function fetchClosedStatMonthlyData 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetClosedStatMonthlyData([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_stat_Closed_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //    //Method to get Resolved Ticket Volume for Function fetchResolvedStatMonthlyData 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResolvedStatMonthlyData([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

                
                strSQL = "Exec usp_Whizible2_Sel_stat_resolved_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //    //Method to get Due Ticket Volume for Function fetchDueStatMonthlyData 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDueStatMonthlyData([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {

               

                strSQL = "Exec usp_Whizible2_Sel_stat_Due_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //    //Method to get Open Ticket Volume for Function fetchOpenMonthlyData 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetOpenStatMonthlyData([FromBody] GetTicketCountRequest request)
        {
            string strSQL;
            try
            {
                
                strSQL = "Exec usp_Whizible2_Sel_stat_Open_tbl_CRM_Query_Master " + request.CustomerID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to details of get details of Total Per This Week tickets for Function loadGetTicketDetailsforTotalperThisweekTickets


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforTotalperThisweekTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
                

                string strSQL = "EXEC usp_Whizible2_Sel_TotalperThisWeekRequestDetail_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //    //Method to details for Unassigned Tickets for Function fetchTicketDetailsforUnassignedTickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforUnassignedTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_Sel_UnassignedTicketDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;  
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to details for open status for Function fetchGetTicketDetailsforOpenStatus

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforOpenStatusTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_SeL_OpenStatusDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get details of Resolved status Ticket for Function fetchGetTicketDetailsforResolvedStatus 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforResolvedStatusTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_SeL_ResolvedStatusDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to details of details for closed status for Function loadGetTicketDetailsforClosedStatus

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforClosedStatusTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
                
                string strSQL = "EXEC usp_Whizible2_SeL_ClosedStatusDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //    //Method to details for all tickets for Function fetchTicketDetailsforTickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
                
                string strSQL = "EXEC usp_Whizible2_sel_TicketDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;  // Return the ticket details as JSON response
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to details for Backlog tickets for Function fetchGetTicketDetailsforBacklogTickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforBacklogTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               

                string strSQL = "EXEC usp_Whizible2_Sel_BacklogTicketsDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //    //Method to details for Inflow this month tickets for Function fetchGetTicketDetailsforinflowThisMonthTickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforinflowThisMonthTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_sel_InflowsThisMonthsDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //    //Method to details of Resolved This Month tickets for Function fetchGetTicketDetailsforResolvedThisMonthTickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforresolvedInMonthTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_Sel_ResolvedThisMonthDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get details for Priority for Function fetchGetTicketDetailsforPriority

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforPriorityTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_sel_PriorityDetail_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

       // Method to get details for Severity for Function loadGetTicketDetailsforSeverity
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforSeverityTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_sel_SeverityDetail_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get details for CR Tickets for Function fetchGetTicketDetailsforCR
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforCRTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_sel_CRDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to get details for New Tickets Created Monthly As Per Priority for Function fetchGetTicketDetailsfornewTickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforNewTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_sel_NewTicketDetail_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to get details for Key Times for Function fetchGetTicketDetailsforKeyTimes
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforKeyTimes([FromBody] GetTicketCountRequest request)
        {
            try
            {
                
                string strSQL = "EXEC usp_Whizible2_Sel_KeyTimedetails " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID + "," + request.DetailsQueryIDs; 

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get details of SLA for Current Month for Function loadTicketDetailsforSlaDataForCustomer
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDetailsforCurrentMonth([FromBody] GetTicketCountRequest request)
        {
            try
            {
               
                string strSQL = "EXEC usp_Whizible2_Sel_GetCurrentMonthDetail " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID + "," + request.DetailsQueryIDs;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to get details for Submitted Ticket Volume for Function loadSubmittedMonthlyDatadetails 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforTicketVolume([FromBody] GetTicketCountRequest request)
        {
            try
            {            

                // Prepare SQL query to call the stored procedure
                string strSQL = "EXEC usp_Whizible2_Sel_ticketVolume_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID + ",'" + request.StatusFlag  + "'";

                // Execute the query and get the result (assuming CommonFunctions.Data.GetData will handle this)
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;  // Return the ticket details as JSON response
            }
            catch (Exception ex)
            {
                // Log the exception details and return a 500 error
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get count of Overdue  for Function fetchGetOverdueTicketsByCustomer
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetOverdueTickets([FromBody] GetTicketCountRequest request)
        {
            string strSQL;

            try
            {               
                strSQL = "Exec usp_Whizible2_sel_OverdueTickets_tbl_CRM_Query_Master " + request.CustomerID;
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to get Resolved In Time count for Customer Selected for Function fetchResolvedInTimeForCustomer
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResolvedInTimeForCustomer([FromBody] GetTicketCountRequest request)
        {
            string strSQL;

            try
            {                
                strSQL = "Exec usp_Whizible2_Sel_ResolvedInTime_tbl_CRM_Query_Master " + request.CustomerID;
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to details details of Overdue tickets for Function fetchGetDetailsforOverdueTickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforOverdueTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_OverdueTicketDetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID + "," + request.OverDueID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Method to get count of SLA Breach Per Going to Breach for Function fetchGetslBreachPerGoingToBreach
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetslaBreachPerGoingtoBreach([FromBody] GetTicketCountRequest request)
        {
            
            try
            {
                
                string strSQL = "EXEC usp_Whizible2_Sel_PM_SLA " + request.CustomerID;

                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;

            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Method to get details for SLA Breach for Function fetchGetDetailsforBreach
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforBreachTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {
                
                string strSQL = "EXEC usp_Whizible2_Sel_GetBreachDetail " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID + "," + request.DetailsQueryIDs;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Method to details of of Resolved In Time tickets tickets for Function fetchGetDetailsforResolvedInTimeTickets

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketDetailsforresolvedInTimeTickets([FromBody] GetTicketCountRequest request)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_ResolvedInTimedetails_tbl_CRM_Query_Master " + request.CustomerID + "," + request.DepartmentID + "," + request.NewCustomerID + "," + request.ResInTimeIDs;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Method to get Current Month data for Function fetchCurrentMonthData Durgesh
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCurrentMonthDataOfSla([FromBody] GetTicketCountRequest request)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_sel_SLADataForAllQueryOfCurrentMonthOfSelectedCustomer " + request.CustomerID + ", '" + request.OnDate.ToString("yyyy-MM") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //

        //Method to get Current Month data for Function fetchCurrentMonthData for offcanvas Durgesh
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCurrentMonthDataOfSlaOffCanvas([FromBody] GetTicketCountRequest request)
        {
            try
            {
                // Construct the SQL query string with the input parameters
                string strSQL = "EXEC usp_Whizible2_sel_SLADataForAllQueryOfCurrentMonthOfSelectedCustomerOffCanvas '"
                                + request.CustomerID + "', '"
                                + request.OnDate.ToString("yyyy-MM") + "', '"
                                + request.DepartmentID + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //


    }



    //Model Class for RequesterCustomerClient
    public class GetTicketCountRequest
    {
        public string CustomerID { get; set; }

        public string DepartmentID { get; set; }

        public string NewCustomerID { get; set; }

        public string StatusFlag { get; set; }

        public string Status { get; set; }

        public DateTime OnDate { get; set; }

        public string OverDueID { get; set; }

        public string ResInTimeIDs { get; set; }

        public string DetailsQueryIDs { get; set; }

        
    }
}





