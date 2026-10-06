using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{


    public class HelpdeskViewSettingController : ApiController
    {
        private int TagID = 36079;

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetCustomerByDept([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                if (Parameter.DeptCustClientMappingID == "0")
                {
                    Parameter.DeptCustClientMappingID = "null";
                }
                string strSQL = "";
                strSQL = "Exec usp_sel_whizible2_tbl_PM_Customer_Customer " + Parameter.DeptID + "," + Parameter.DeptCustClientMappingID + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetClientByCustomer([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                if (Parameter.DeptCustClientMappingID == "0")
                {
                    Parameter.DeptCustClientMappingID = "null";
                }
                string strSQL = "";
                strSQL = "Exec usp_Sel_whizible2_AllClientsByCustomer " + Parameter.Customer + "," + Parameter.DeptCustClientMappingID + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object getHelpdeskViewDetails([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_sel_whizible2_v_tbl_PM_DeptCustClientMapping_HelpdeskViewSetting " + Parameter.DeptID + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object InsHelpdeskViewDetails([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Ins_Whizible2_tbl_PM_DeptCustClientMapping " + Parameter.DepartmentID + "," + Parameter.CustomerID + "," + Parameter.ClientID + "," + Parameter.View_HD + "," + Parameter.View_Email + ",'" + Parameter.CreatedBy + "'," + Parameter.flag + "," + Parameter.ID + "," + Parameter.ID + "";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object DelHelpdeskViewDetails([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Del_Whizible2_tbl_PM_DeptCustClientMapping " + Parameter.ID + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetCustomerByDeptForFilter([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                if (Parameter.DeptID == 0)
                {
                    Parameter.DeptID = 0;
                }
                string strSQL = "";
                strSQL = "Exec usp_sel_whizible2_tbl_PM_Customer_Customer " + Parameter.DeptID + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetClientByCustomerForFilter([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                if (Parameter.Customer == 0)
                {
                    Parameter.Customer = 0;
                }
                string strSQL = "";
                strSQL = "Exec usp_Sel_whizible2_AllClientsByCustomer " + Parameter.Customer + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object getHelpdeskViewDetailsbyFilter([FromBody] ProgramFetaureParameters Parameter)
        {

            //var EmployeeList = new List<RM_EmployeeList>();

            try
            {
                string filterParms = "";
                if (Parameter != null && Parameter.EmpWhereClause != null && !string.IsNullOrEmpty(Parameter.EmpWhereClause))
                {
                    // filterParms = vTFilter.VTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(Parameter.EmpWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Sel_whizible2_HelpdeskFilter '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Sel_whizible2_HelpdeskFilter";
                }
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveFilter([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                string strSQL = "";
                string strQueryID = Parameter.FilterID.ToString();
                if (Parameter.FilterID == 0)
                {
                    strQueryID = "NULL";
                }
                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + TagID + ","
                                                                    + Parameter.ProjectID + ","
                                                                    + Parameter.intEmployeeID + ", '" + Parameter.fltFilterName + "', '"
                                                                    + Parameter.LoginType + "' ," + "'" + Parameter.QueryText + "'"
                + ",'" + Parameter.UserName + "'," + Parameter.Flag + "," + strQueryID;


                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetFilters([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_Whizible2_Filter_Query " + Parameter.ProjectID + "," + TagID + ",'"
                                                                      + Parameter.LoginType + "' ," + Parameter.intEmployeeID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public string SetDefaultFilter([FromBody] ProgramFetaureParameters Parameter)
        {
            try 
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + Parameter.ProjectID;
                strSQL += ",'" + Parameter.LoginType;
                strSQL += "'," + Parameter.intEmployeeID;
                strSQL += "," + TagID;
                strSQL += "," + Parameter.QueryID;
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return "Success";
            }
            catch (Exception ex)
            {
                return "Bad Request found" ;
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public QueryList GetFilterById([FromBody] ProgramFetaureParameters Parameter)
        {

            string strSQL = "EXEC usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query ";
            strSQL += +Parameter.QueryID;

            QueryList Query = new QueryList();
            IDataReader drQuery;
            drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (drQuery.Read())
            {
                Query.FilterID = Convert.ToInt32(drQuery["FilterID"]);
                Query.FilterName = Convert.ToString(drQuery["FilterName"]);
                Query.QueryText = Convert.ToString(drQuery["WhereClause"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref drQuery);
            return Query;
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public string DeleteFilter([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Del_tbl_Whizible2_Filter_Query " + Parameter.QueryID.ToString();
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return "Success";
            }
            catch (Exception ex)
            {
                return "Bad Request found";
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetAuditTrailHistory([FromBody] ProgramFetaureParameters Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_PM_DeptCustClientMapping_AuditTrail " + Parameter.DeptID + " ";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public QueryList GetDefaultFilter([FromBody] ProgramFetaureParameters projectParameters)
        {

            string strSQL = "EXEC usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter ";
            strSQL += +projectParameters.ProjectID;
            strSQL += "," + TagID;
            strSQL += ",'" + projectParameters.LoginType;
            strSQL += "'," + projectParameters.intEmployeeID;

            QueryList defaultQuery = new QueryList();
            IDataReader drDefaultQuery;
            drDefaultQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (drDefaultQuery.Read())
            {
                defaultQuery.FilterID = Convert.ToInt32(drDefaultQuery["FilterID"]);
                defaultQuery.FilterName = Convert.ToString(drDefaultQuery["FilterName"]);
                defaultQuery.QueryText = Convert.ToString(drDefaultQuery["QueryText"]);
            }
            CommonFunctions.Data.DisposeDataReader(ref drDefaultQuery);
            return defaultQuery;
        }
    }

    public class QueryList
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
    }
    public class ProgramFetaureParameters
    {
        public int FilterID { get; set; }
        public int DeptID { get; set; }
        public int Customer { get; set; }
        public string DeptCustClientMappingID { get; set; }
        public int DepartmentID { get; set; }
        public int CustomerID { get; set; }
        public int ClientID { get; set; }
        public int View_HD { get; set; }
        public int View_Email { get; set; }
        public string CreatedBy { get; set; }
        public string CreatedDate { get; set; }
        public int flag { get; set; }
        public int ID { get; set; }
        public string EmpWhereClause { get; set; }
        public int intEmployeeID { get; set; }
        public int QueryID { get; set; }
        public string fltFilterName { get; set; }
        public string QueryText { get; set; }
        public string LoginType { get; set; }
        public string UserName { get; set; }
        public int Flag { get; set; }
        public int ProjectID { get; set; }
        public string FilterName { get; set; }
       // public int FilterID { get; set; }

    }
}
