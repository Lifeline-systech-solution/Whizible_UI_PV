using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.SM;

namespace WhizibleAPI.Controllers
{
    public class TeamsAccessController : ApiController
    {
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]   
        public object GetEmployeeList([FromBody] TeamsAccess Parameter)
        {
            try
            {
                DataTable EmployeeList;
                string query = "";
                query = "EXEC usp_Whizible2_Sel_Timesheet_AccessibleEmployee " + Parameter.RoleID + "," + Parameter.OUID + "";

                EmployeeList = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return EmployeeList;
            }
            catch (Exception e)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveEmployeeDetails([FromBody] TeamsAccess Parameters)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Ins_Emp_TeamAccess  '" + Parameters.EmployeeIDs + "', '" + Parameters.LoginType + "'," + Parameters.UserId + "";
                String result = Convert.ToString(CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }
}
