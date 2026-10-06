using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models;

namespace WhizibleAPI.Controllers
{
    public class HRM_Management_DashboardController : ApiController
    {


        //ENDPOINT FOR FETCHING ALL THOSE DEPARTMENT FOR WHICH THE LOGGED IN PERSON IS HRM
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDepartmentsForHRM([FromBody] ResourcesParameters resourceParameters)

        { 
            string strSQL;
            try 
            {
                // strSQL = "EXEC usp_Sel_DepartmentOfHRMPerson '" + HttpUtility.UrlDecode(resourceParameters.UserName) + "', " + resourceParameters.UserId;
                // strSQL = "EXEC usp_Whizible2_sel_DepartmentOfHRMPerson '" + HttpUtility.UrlDecode(resourceParameters.UserName) + "', " + resourceParameters.UserId;
                strSQL = "EXEC usp_Whizible2_sel_DepartmentOfHRMPersonWithSelectDepartmentOnId "+ resourceParameters.UserId;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT




        //ENDPOINT FOR FETCHING ALL THE TICKETS OF THE DEPARTMENT OF WHICH THE PERSON IS HRM
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketsForAllDepartmentsOfHRM([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {   
                //strSQL = "EXEC usp_Sel_TicketsForMultipleDepartments '" + HttpUtility.UrlDecode(resourceParameters.DepartmentName) + "'";
                strSQL = "EXEC usp_Whizible2_sel_TicketsForMultipleDepartmentsByDeptID "+ resourceParameters.Id ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT



        //f1
        //ENDPOINT TO FIND OUT SLA BREACHES COUNT TODAY OF THE SLECTED DEPARTMENT AND IT IS PREFERRED ONE 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSLABreachesCountForDepartmentOnDate([FromBody] ResourcesParameters resourceParameters)
        {        
            string strSQL;
            try
            {
                //usp_Whizible2_sel_SLACategoryCounts_Department_Date_Wise
                //strSQL = "EXEC usp_Sel_SLACategoryCounts_Department_Date_Wise " + resourceParameters.Id + ", '" + resourceParameters.OnDate.ToString("yyyy-MM-dd HH:mm:ss.fff") + "'";
                strSQL = "EXEC usp_Whizible2_sel_SLACategoryCounts_Department_Date_Wise " + resourceParameters.Id + ", '" + resourceParameters.OnDate.ToString("yyyy-MM-dd HH:mm:ss.fff") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT







        //ENDPOINT TO RETRIEVE THE COUNT RELATED TO THE CSAT SECTION
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetFeedBackCountOfMonthOfDepartment([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {
               // string ids = string.Join(",", resourceParameters.Ids);

                strSQL = "EXEC usp_Whizible2_Sel_CalculateFeedbackCountsForMonthOfDepartment @OnDate = '" + resourceParameters.OnDate.ToString("yyyy-MM") + "', @IDs = '" + resourceParameters.SIDs + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT




    
        //ENDPOINT TO FETCH ALL THE FEEDBACKS OF THE CUSTOMER WHO HAVE CHECKED THE ALLOWED SLA HELP-DESK CHECKBOX
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetFeedBacks([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_FeedbackDetails_AllowedSLAHelpDesk " + resourceParameters.Id ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT




        //ENDPOINT TO FETCH ALL THE FEEDBACKS OF THE CUSTOMER WHO HAVE CHECKED THE ALLOWED SLA HELP-DESK CHECKBOX
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetFeedBacksFoCSAT([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_FeedbackDetails_AllowedSLAHelpDesk_CSAT " + resourceParameters.Id + ",'"+resourceParameters.OnDate.ToString("yyyy-MM-dd")+"'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT




        //f1
        //ENDPOINT TO FETCH THE THRESHOLD VALUE WHICH IS REQUIRED FOR THE EVALUATION OF THE SLA WHICH IS ABOUT TO BREACH
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetThresholdValue()
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_ProjectSettingsThreshold";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT


  
        //ENDPOINT FOR THE FETCHING OF THE SLA DATA OF A SINGLE REQUEST OR TICKET AT A TIME
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSLADataOfTicket([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {   // THIS IS A EXISTING SP WHICH IM CALLING HERE
                strSQL = "EXEC usp_PM_CalculateSLAForHelpDesk_Query_Details " + resourceParameters.Id;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT




        //ENDPOINT TO FIND OUT SLA BREACHES COUNT TODAY OF THE SLECTED DEPARTMENT AND IT IS PREFERRED ONE
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSLADataOfAllTicketForDepartmentOnDate([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {
                
                //strSQL = "EXEC usp_Sel_CalculateSLAForHelpDesk_Query_Details_Department_Date_Wise " + resourceParameters.Id + ", '" + resourceParameters.OnDate.ToString("yyyy-MM-dd HH:mm:ss.fff") + "'";
                strSQL = "EXEC usp_Whizible2_sel_CalculateSLAForHelpDesk_Query_Details_Department_Date_Wise " + resourceParameters.Id + ", '" + resourceParameters.OnDate.ToString("yyyy-MM-dd HH:mm:ss.fff") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT





        //ENDPOINT FOR FETCHING OPEN TICKETS FOR THE SELECTED DEPARTMENT FROM THE DROPDOWN
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetAllOpenTicketsForDepartment([FromBody ] ResourcesParameters resourcesParameters)
        {
            string strSQl;
            try
            { 
                //strSQl = "EXEC usp_Sel_OpenTicketsByDepartment '" + resourcesParameters.DepartmentName + "'";
                strSQl = "EXEC usp_Whizible2_sel_OpenTicketsByDepartmentID " + resourcesParameters.Id ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQl, true, CommonController.connectionString);

                return dt;
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request Found");
            }
        }
        //END OF ABOVE ENDPOINT



        //f1
        //ENDPOINT FOR FETCHING FEEDBACK PARAMETER WHICH ARE CONFIGURED WITHIN THE SYSTEM
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetFeedbackParameters( )
        {
            string strSQl;
            try
            { 
                strSQl = "EXEC usp_Whizible2_Sel_tbl_CRM_FeedbackDesc ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQl, true, CommonController.connectionString);

                return dt;
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request Found");
            }
        }
        //END OF ABOVE ENDPOINT






        //ENDPOINT FOR FETCHING EMPLOYEE FUTURE LEAVE DETAILS WHO ARE NOT ON LEAVE TODAY
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetEmployeesDetailWhoNotOnLeaveToday([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {               
                //strSQL = "EXEC usp_EmployeeWhoAreNotOnLeaveTodayDetailsAll '" + resourceParameters.DepartmentName + "', '" + resourceParameters.OnDate.ToString("yyyy-MM-dd") + "'";
                strSQL = "EXEC usp_Whizible2_sel_EmployeeWhoAreNotOnLeaveTodayDetailsAllByDeptID " + resourceParameters.Id + ", '" + resourceParameters.OnDate.ToString("yyyy-MM-dd") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                // Return an error response in case of an exception
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT





        //ENDPOINT FOR FETCHING EMPLOYEE ONLINE COUNT
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetEmployeesOnlineCount([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                //strSQL = "EXEC usp_EmployeeWhoAreNotOnLeaveTodayCount '" + resourceParameters.DepartmentName + "', '" + resourceParameters.OnDate.ToString("yyyy-MM-dd") + "'";
                strSQL = "EXEC usp_Whizible2_sel_EmployeeWhoAreNotOnLeaveTodayCountByDeptID " + resourceParameters.Id + ", '" + resourceParameters.OnDate.ToString("yyyy-MM-dd") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                // Return an error response in case of an exception
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT






        //ENDPOINT FOR FETCHING EMPLOYEE LEAVE DETAILS OF TODAY FOR THE EMPLOYEE WHO ARE ON LEAVE TODAY
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetEmployeesDetailWhoOnLeaveToday([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {   
                //strSQL = "EXEC usp_EmployeeWhoAreOnLeaveTodayDetails '" + resourceParameters.DepartmentName + "', '" + resourceParameters.OnDate.ToString("yyyy-MM-dd") + "'";
                strSQL = "EXEC usp_Whizible2_sel_EmployeeWhoAreOnLeaveTodayDetailsByDeptID " + resourceParameters.Id + ", '" + resourceParameters.OnDate.ToString("yyyy-MM-dd") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                // Return an error response in case of an exception
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT



        //FUNCTION TO FETCH LATEST OPEN TICKETS FOR DROPDOWN CHANGE IN OFFCANVAS SECTION
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetLatestOpenTicketsByDepartmentForOffcanvas([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {
                // Construct the SQL query to execute the stored procedure
                strSQL = "EXEC usp_Whizible2_sel_LatestTicketsOpenByDepartmentIDForOffcanvas " + resourceParameters.Id + ", '" + resourceParameters.CustomerName + "', '" + resourceParameters.FromDate.ToString("yyyy-MM-dd") + "', '" + resourceParameters.ToDate.ToString("yyyy-MM-dd") + "'";

                // Execute the query and get the result as a DataTable
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                // Return an error response in case of an exception
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //END OF ABOVE ENDPOINT



        //FUNCTION TO FETCH UNASSIGNED TICKETS FOR DROPDOWN CHANGE IN OFFCANVAS SECTION
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetUnassignedTicketsByDepartmentForOffcanvas([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                // Construct the SQL query to execute the stored procedure
                strSQL = "EXEC usp_Whizible2_sel_UnassignedTicketsByDepartmentIDForOffcanvas " + resourceParameters.Id + ", '" + resourceParameters.CustomerName + "'";

                // Execute the query and get the result as a DataTable
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                // Return an error response in case of an exception
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //END OF ABOVE ENDPOINT


        //FUNCTION TO FETCH OPEN TICKETS FOR DROPDOWN CHANGE IN OFFCANVAS SECTION
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetOpenTicketsByDepartmentForOffcanvas([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_OpenTicketsByDepartmentIDForOffcanvas " + resourceParameters.Id + ", '" + resourceParameters.CustomerName + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //END OF ABOVE ENDPOINT


        //FUNCTTION TO FETCH CR TICKETS FOR DROPDOWN CHANGE IN OFFCANVAS SECTION
         [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCRTicketsByDepartmentForOffcanvas([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                // Construct the SQL query to execute the stored procedure
                strSQL = "EXEC usp_Whizible2_sel_CRTicketsByDepartmentIDOffCanvas '" + resourceParameters.Id + "', '" + resourceParameters.CustomerName + "'";

                // Execute the query and get the result as a DataTable
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                // Return an error response in case of an exception
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF THE ABOVE ENDPOINT


        //FUNCTTION TO FETCH CR TICKETS FOR DROPDOWN CHANGE IN OFFCANVAS SECTION
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTopPriorityTicketsByDepartmentForOffcanvas([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                // Construct the SQL query to execute the stored procedure
                strSQL = "EXEC usp_Whizible2_sel_TopPriorityTicketsByDepartmentIDOffCanvas " + resourceParameters.Id + ", '" + resourceParameters.CustomerName + "'";

                // Execute the query and get the result as a DataTable
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                // Return an error response in case of an exception
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF THE ABOVE ENDPOINT



        //FUNCTION TO FETCH MOST OF THE DASHBOARD COUNT

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetHRMDBCounts([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                // Construct the SQL string to execute the stored procedure
                strSQL = "EXEC usp_Whizible2_sel_HRMDBCountsByDeptID " + resourceParameters.Id + ", '" +
                    resourceParameters.FromDate.ToString("yyyy-MM-dd") + "', '" +
                    resourceParameters.ToDate.ToString("yyyy-MM-dd") + "'";

                // Execute the SQL string and get the results into a DataTable
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                // Return the DataTable as the result
                return dt;
            }
            catch (Exception ex)
            {
                // Handle any errors and return a 500 status code with an error message
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //END OF ABOVE ENDPOINT


        //TICKETS CREATED IN CURRENT WEEK
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketsCreatedOnCurrentWeekForDepartment([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                // Construct the SQL string to execute the stored procedure
                strSQL = "EXEC usp_Whizible2_Sel_TicketsCreatedOnCurrentWeekForDepartmentID'" + resourceParameters.FromDate.ToString("yyyy-MM-dd") + "', '" +
                    resourceParameters.ToDate.ToString("yyyy-MM-dd") + "', " +
                    resourceParameters.Id ;

                // Execute the SQL string and get the results into a DataTable
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                // Return the DataTable as the result
                return dt;
            }
            catch (Exception ex)
            {
                // Handle any errors and return a 500 status code with an error message
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END



        //TICKET CLOSED IN CURRENT WEEK
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTicketsClosedOnCurrentWeekForDepartment([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_TicketsClosedOnCurrentWeekForDepartmentID '" + resourceParameters.FromDate.ToString("yyyy-MM-dd") + "', '" +
                    resourceParameters.ToDate.ToString("yyyy-MM-dd") + "', " +
                    resourceParameters.Id ;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END


        //FUNCTION TO FETCH ALL QUERY ID BY DEPARTMENT 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetALLQueryIDsByDepartment([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_AllQueryIDsByDepartmentID " + resourceParameters.Id;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //END


        //FUNCTION TO FETCH ALL CUSTOMERS MAPPERD TO THE HRM DEPARTMENT
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCustomersByHRMDepartmentIDs([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                
                //strSQL = "EXEC usp_Whizible2_sel_CustomersByHRMDepartmentIDs '" + resourceParameters.SIDs + "'";
                strSQL = "EXEC usp_Whizible2_sel_CustomersByHRMDepartmentIDsWithSelectCustomer '" + resourceParameters.SIDs + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END


        //FUNCTION TO FETCH ALL CLOSED TICKET OF THE SELECTED DEPARTMENT FOR THE ENTIRE WEEK
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetClosedTicketsByDepartmentidForWeek([FromBody] ResourcesParameters resourceParameters)
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_ClosedTicketsByDepartmentIDForWeek " +
                         resourceParameters.Id + ", '" +
                         resourceParameters.FromDate.ToString("yyyy-MM-dd") + "', '" +
                         resourceParameters.ToDate.ToString("yyyy-MM-dd") + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT 



        //FUNCTION TO FETCH ALL CLOSED TICKET OF THE SELECTED DEPARTMENT FOR THE ENTIRE WEEK
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetConfiguredPrioritiesForTicket()
        {

            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whzible2_sel_GetCRM_Priority ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //END OF ABOVE ENDPOINT


        //ENDPOINT FOR THE FILTERING OF THE CUSTOMER TICKETS OPEN
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object FilterCustomeOpenTicket([FromBody] ResourcesParameters resourceParameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_OnlyCustomerOpenTicketsByDepartmentIDForOffcanvas '" + resourceParameters.DepartmentName + "', '" + resourceParameters.CustomerName + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //END
    }
}


