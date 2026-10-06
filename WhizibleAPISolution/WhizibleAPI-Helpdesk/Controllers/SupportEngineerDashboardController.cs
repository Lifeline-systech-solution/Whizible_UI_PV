using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models;




namespace WhizibleAPI.Controllers
{
    public class SupportEngineerDashboardController : ApiController
    {

        //Added By Vyankat B on 12 Jan 2025 for They are calculate the Unassigned Tickets Count
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UnassignedTicketsCount([FromBody] SupportEngineerDashModel Parameters)
        {
            try
            {
                string result = "";
                
                
                    string strSQL;

                    strSQL = "usp_Whizible2_Sel_tbl_CRM_Query_Master_UnassignedTicketsCount '" + Parameters.EmployeeID + "' ";

                    result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found" + ex.Message);
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for They are calculate the Unassigned Tickets Count

        //Added By Vyankat B on 12 Jan 2025 for  They are get Unassigned Tickets Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetUnassignedTicketsDetails([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_CRM_Query_Master_UnassignedTicketsDetails  '" + Parameters.EmployeeID.ToString() + "','" + Parameters.Department + "','" + Parameters.CustomerID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for  They are get Unassigned Tickets Details

        //Added By Vyankat B on 12 Jan 2025 for  They are get Open Tickets Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetOpenTicketDetails([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_CRM_Query_Master_OpenTicketsDetails '" + Parameters.EmployeeID.ToString() + "','" + Parameters.Department + "','" + Parameters.CustomerID + "'  ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for  They are get Open Tickets Details

        //Added By Vyankat B on 12 Jan 2025 for To get Monthly  CSAT Ticket Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetCSATTicketDetails([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_CSAT_Monthly_Details_tbl_CRM_Query_Master '" + Parameters.EmployeeID.ToString() + "','" + Parameters.Department + "','" + Parameters.CustomerID + "'  ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To get Monthly  CSAT Ticket Details

        // Added By Vyankat B on 12 Jan 2025 for To Get the Customer  Open Ticket Details  
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetCustOpenicketDetails([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Cust_Of_Open_Tick_Details_tbl_CRM_Query_Master '" + Parameters.EmployeeID.ToString() + "','" + Parameters.Department + "','" + Parameters.CustomerID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the Customer  Open Ticket Details  

        //Added By Vyankat B on 12 Jan 2025 for To Get the High Priority Tickets Count
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object HighPriorityTicketsCount([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                string result = "";

                
               

                strSQL = "Exec usp_Whizible2_Sel_tbl_CRM_Query_Master_HighPriorityTicketsPercentage '" + Parameters.EmployeeID.ToString() + "'";

                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found" + ex.Message);
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the High Priority Tickets Count

        // Added By Vyankat B on 12 Jan 2025 for To Get the High Priority Tickets Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object HighPriorityTicketsDetails([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_tbl_CRM_Query_Master_HighPriorityTicketsDetails '" + Parameters.EmployeeID.ToString() + "','" + Parameters.Department + "','" + Parameters.CustomerID + "'  ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the High Priority Tickets Details

        //Added By Vyankat B on 12 Jan 2025 for To Get the Open Tickets Count 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetOpenTickets([FromBody] SupportEngineerDashModel Parameters)
        {

            try
            {
                string result = "";

                    
                string strSQL;

                strSQL = "EXEC usp_Whizible2_Sel_tbl_CRM_Query_Master_OpenTicketsCount '" + Parameters.EmployeeID + "' ";

                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return result;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the Open Tickets Count 

        // Added By Vyankat B on 12 Jan 2025 for To Get the Open Tickets Priority
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetOpenTickPrior([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Prior_Of_Open_Tick_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        // End of Added By Vyankat B on 12 Jan 2025 for To Get the Open Tickets Priority

        // Added By Vyankat B on 12 Jan 2025 for To Get the Customer Open Tickets Count
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCutOpenTickCount([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Cust_Of_Open_Tick_Acc_Emp_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the Customer Open Tickets Count

        // Added By Vyankat B on 12 Jan 2025 for To Get the Resolved  and Closed Tickets Count
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetResCloTickCount([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Resol_Clos_Tick_Acc_Emp_tbl_CRM_Query_Master '" + Parameters.EmployeeID.ToString() + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the Resolved  and Closed Tickets Count

        // Added By Vyankat B on 12 Jan 2025 for To Get the New ticket vs Closed Tickets Count
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetNewticketvsClosTickCount([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Newticket_vs_Clos_Tick_Acc_Emp_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the New ticket vs Closed Tickets Count

        // Added By Vyankat B on 12 Jan 2025 for To calculate the overall CSAT percentage 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetOverallCSAT([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC  usp_Whizible2_Sel_Overall_CSAT_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To calculate the overall CSAT percentage 

        // Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Target Today
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetSLATargetToday([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC   usp_Whizible2_Sel_CalculateSLABreaches_Resp_Close '" + Parameters.STRResultQueryId + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Target Today

        // Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Target Today
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetSLARecentlyBreachedTickets([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {



                //Commented and Added By Vyankat B 12 Aug 2025 for the W21_PointWest Upgrade

                //strSQL = "EXEC   usp_Whizible2_Sel_RecentlyBreachedSLA '" + Parameters.STRResultQueryId + "' ";

                strSQL = "EXEC   usp_Whizible2_Sel_RecentlyBreachedSLA_New '" + Parameters.EmployeeID + "'," + Parameters.Flag + " ";

                //End of Commented and Added By Vyankat B 12 Aug 2025 for the W21_PointWest Upgrade 

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        // End of Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Target Today

        // Added By Vyankat B on 12 Jan 2025 for To calculate the SLA QueryID of Employee 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetSLAQueryID_Tick_Acc_Emp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try  
            {
                strSQL = "EXEC usp_Whizible2_Sel_QueryID_Tick_Acc_Emp_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To calculate the SLA QueryID of Employee 

        // Added By Vyankat B on 12 Jan 2025 for  To calculate the SLA Priority of Tickets 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSel_SLAPrior_Tick_Acc_Emp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_NewSLAPrior_Tick_Acc_Emp_tbl_CRM_Query_Master '" + Parameters.AssignToName.ToString() + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for  To calculate the SLA Priority of Tickets 

        // Added By Vyankat B on 12 Jan 2025 for To calculate the Monthly CSAT of Tickets 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSelMonthlyCSATAcc_Emp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Monthly_CSAT_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To calculate the Monthly CSAT of Tickets 

        // Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Active BreachedCount 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSLAActiveBreachedCount([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                //Commented and Added by Riddhesh Patil on 24 Apr 2025 for Performance issue
                //strSQL = "EXEC   usp_Whizible2_Sel_CalculateSLABreached_Count '" + Parameters.STRResultQueryId + "' ";
                strSQL = "EXEC   usp_Whizible2_Sel_CalculateSLABreached_Count_New '" + Parameters.EmployeeID + "',"+ Parameters.Flag+ " ";
                //End of Commented and Added by Riddhesh Patil on 24 Apr 2025 for Performance issue
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Active BreachedCount 

        // Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Breached QueryID of Tickets
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSLABreachedQueryIDTickAccEmp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_SLA_Breached_QueryID_Tick_Acc_Emp_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To calculate the SLA Breached QueryID of Tickets

        // Added By Vyankat B on 12 Jan 2025 for To get the Customer feedback and also rating of customer
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetCustomerFeedbackAccEmp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Customer_Feed_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To get the Customer feedback and also rating of customer

        // Added By Vyankat B on 12 Jan 2025 forTo get the Customer feedback percentage
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetCustomerFeedbackPercentageAccEmp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Customer_Feed_Percent_tbl_CRM_Query_Master '" + Parameters.EmployeeID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 forTo get the Customer feedback percentage

        // Added By Vyankat B on 12 Jan 2025 for To get Unbreached Tickets Details 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetUnbreachedTicketsDetailsAccEmp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Unbreached_Tick_Details_tbl_CRM_Query_Master '" + Parameters.STRResultQueryId + "', '" + Parameters.Department + "','" + Parameters.CustomerID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To get Unbreached Tickets Details 

        // Added By Vyankat B on 12 Jan 2025 for To get Breached Tickets Details 
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetBreachedTicketDetailsAccEmp([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Breached_Tick_Details_tbl_CRM_Query_Master '" + Parameters.STRResultQueryId + "', '" + Parameters.Department + "','" + Parameters.CustomerID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        // End of Added By Vyankat B on 12 Jan 2025 for To get Breached Tickets Details 

        // Added By Vyankat B on 12 Jan 2025 for To Get the Profile Details
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]

        public object GetProfileDetails([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_Employee_Profile_tbl_PM_Employee '" + Parameters.EmployeeID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To Get the Profile Details

        // Added By Vyankat B on 12 Jan 2025 for To verify whether HRM is logged in or not
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetHRMLogin([FromBody] SupportEngineerDashModel Parameters)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_HRM_Login '" + Parameters.CustomerID + "' ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To verify whether HRM is logged in or not

        // Added By Vyankat B on 12 Jan 2025 for To find the HRMID
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetHRMID()
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_Sel_HRM_Id ";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for To find the HRMID

        // Added By Vyankat B on 12 Jan 2025 for the get all department value
        [HttpPost]
        public object GetDepartments()
        {
            try
            {
                // Construct the SQL query string with the input parameters
                string strSQL = "EXEC usp_Sel_Whizible2_Dept_Dropdown_tbl_CRM_Query_Master";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for the get all department value

        // Added By Vyankat B on 12 Jan 2025 for the get all customer value
        [HttpPost]
        public object GetCustomers()
        {
            try
            {
                // Construct the SQL query string with the input parameters
                string strSQL = "EXEC usp_Sel_Whizible2_Cust_Dropdown_tbl_CRM_Query_Master";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Vyankat B on 12 Jan 2025 for the get all customer value

    }
}


