using System;
using System.Data;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    public class DashboardController : ApiController
    {
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillProject([FromBody] Dashboard Params)
        {
            try
            {
                //string strsql = "Exec usp_sel_filldropdown ";
                string strsql = "Exec usp_Sel_Whizible2_Dashboard_Project  " + Params.UserId +","+ Params.ProjectGroupID;

            //strsql = $"{strsql} '{HttpUtility.UrlDecode(Params.UserId.ToString())}' ";
            //Console.WriteLine(strsql);
            DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillProjectGroup([FromBody] Dashboard Params)
        {

            try
            {
            string strsql = "Exec usp_sel_Whizible2_DashBoard_ProjectGroup " + Params.UserId;
            DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillBG([FromBody] Dashboard Params)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_Dashboard_BusinessGroup " + Params.ProjectID;
            DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillOU([FromBody] Dashboard Params)
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_DashBoard_OrganizationUnit " + Params.ProjectID; 
            DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillProfitListTbl([FromBody] Dashboard Params)
        {
            try
            {
                string strsql;
                if (Params.ProjectGroupID is 0)
                {
                    strsql = "Exec usp_seL_tbl_pm_ProjectProfitability_ProjectProfit_forProjectGroup_currency Null,Null,'" + Params.strproject + "',Null,0,1, " + Params.CurrencyID;
                }
                else if (Params.ProjectID is 0)
                {
                    strsql = "Exec usp_seL_tbl_pm_ProjectProfitability_ProjectProfit_forProjectGroup_currency Null,Null,'" + Params.strproject + "',Null,0, " + Params.ProjectGroupID + ", " + Params.CurrencyID;
                }
                else
                {
                    strsql = "Exec usp_seL_tbl_pm_ProjectProfitability_ProjectProfit_forProjectGroup_currency " + Params.BusinessGroupID + "," + Params.LocationId + ",'" + Params.strproject + "'," + Params.ProjectID + ",0, " + Params.ProjectGroupID + ", " + Params.CurrencyID;
                }

                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillProfitbyCustomer([FromBody] Dashboard Params)
        {
            try
            {
                string strsql = "Exec usp_SEL_Tbl_PM_ProjectProfitability_ByCustomer " + Params.ProjectID +"," + Params.Customer +",0";
            DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        public object FillCustomer()
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_Dashboard_Customer ";
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        public object FillCurrency()
        {
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_Dashboard_Currency ";
            DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillProjectforCustomer([FromBody] Dashboard Params)
        {
            //string strsql = "Exec usp_sel_filldropdown ";
            try
            {
                string strsql = "Exec usp_Sel_Whizible2_Dashboard_ProjectforCustomer  " + Params.Customer;

                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object FillDU([FromBody] Dashboard Params)
        {
            try
            {
                //string strsql = "Exec usp_sel_filldropdown ";
                string strsql = "Exec usp_Sel_Delivery_Unit_forDashboard  " + Params.LocationId;

                //strsql = $"{strsql} '{HttpUtility.UrlDecode(Params.UserId.ToString())}' ";
                //Console.WriteLine(strsql);
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        public object FillEMP()
        {
            try
            {
                //string strsql = "Exec usp_sel_filldropdown ";
                string strsql = "Select EmployeeID,EmployeeName  from tbl_PM_Employee where LeavingDate is null";

                //strsql = $"{strsql} '{HttpUtility.UrlDecode(Params.UserId.ToString())}' ";
                //Console.WriteLine(strsql);
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        public object FillPeriod()
        {
            try
            {

                //string strsql = "Exec usp_sel_filldropdown ";
                string strsql = "SELECT UniqueID,Description FROM tbl_CRW_DateRanges WHERE  (1=1)  AND  (1=1) AND (1=1) ORDER BY 2";

                //strsql = $"{strsql} '{HttpUtility.UrlDecode(Params.UserId.ToString())}' ";
                //Console.WriteLine(strsql);
                DataTable dt = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }


    public class Dashboard
    {
        public int UserId { get; set; }
        public int BusinessGroupID { get; set; }
        public int ProjectID { get; set; }
        public int SessionProjectID { get; set; }
        public int ProjectGroupID { get; set; }
        public int LoginID { get; set; }
        public string LoginType { get; set; }
        public int Customer { get; set; }
        public string CustomerName { get; set; }
        public string strproject{get; set;}
        public int LocationId { get; set; }

        public int CurrencyID { get; set; }
        //public string Currency { get; set; }


    }

}