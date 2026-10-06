using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RM_MyFilterController : ApiController
    {
        ////Added by imran on 29-08-2022  
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 29-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveMyFilter([FromBody]ApplyFilterParameter Parameters)
        {
            
            try
            {
                string strSQL = "", Message = "";
                if (Parameters.FilterID == 0)
                {
                    ///strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + DecodeUrl(Parameters.TagID) + "," + DecodeUrl(Parameters.ProjectID) + "," + DecodeUrl(Parameters.EmployeeID) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + DecodeWhereClause(Parameters.WhereClause) + "','" + DecodeUrl(Parameters.CreatedBy) + "', " + DecodeUrl(Parameters.Flag) + ", NULL";
                    //strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", NULL";
                    strSQL = "Exec usp_Whizible2_RM_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", NULL";
                }
                else
                {

                    //strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));
                    strSQL = "Exec usp_Whizible2_RM_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + ",'" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "','" + HttpUtility.UrlDecode(Parameters.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.CreatedBy) + "', " + HttpUtility.UrlDecode(Parameters.Flag) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID));
                }
                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return Request.CreateResponse(HttpStatusCode.OK, Message);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
                       
        }

        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [HttpPost]
        public HttpResponseMessage ExistMyFilter([FromBody]ApplyFilterParameter Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists '" + HttpUtility.UrlDecode(Parameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID));
                //string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists '" + DecodeWhereClause(Parameters.FilterName) + "', " + DecodeUrl(Parameters.TagID) + ", " + DecodeUrl(Parameters.ProjectID) + ", " + DecodeUrl(Parameters.EmployeeID);

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return Request.CreateResponse(HttpStatusCode.OK, Flag);
                //return Flag;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteMyFilter([FromBody]int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + DecodeUrl(FilterID);

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }


            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [HttpPost]
        public HttpResponseMessage GetMyFilters([FromBody]ApplyFilterParameter Parameters)
        {
           
            try
            {
                var myFilterLists = new List<MyFilterParameter>();
                string strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query NULL, " + DecodeUrl(Parameters.TagID) + ",'" + DecodeUrl(Parameters.LoginType) + "'," + DecodeUrl(Parameters.EmployeeID);

                DataTable myFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                if (myFilterListTable != null)
                {
                    myFilterLists = myFilterListTable.ToList<MyFilterParameter>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, myFilterLists);
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");

            }


        }

        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [HttpPost]
        public object EditMyFilter([FromBody]int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query  " + DecodeUrl(FilterID);

                DataTable myFilterListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<MyFilterParameter> myFilterLists = new List<MyFilterParameter>();

                foreach (DataRow myFilterList in myFilterListTable.Rows)
                {
                    MyFilterParameter myFilterListQuery = new MyFilterParameter()
                    {
                        FilterId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterID"], "0")),
                        FilterName = CommonFunctions.Data.CheckIsDBNull(myFilterList["FilterName"], "").ToString(),
                        QueryText = CommonFunctions.Data.CheckIsDBNull(myFilterList["WhereClause"], "").ToString(),
                    };
                    myFilterLists.Add(myFilterListQuery);
                }
                return myFilterLists;
            }


            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [HttpPost]
        public object GetMyWhereClauseOfFilter([FromBody]int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(FilterID));

                Object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }


            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }

        //To set default filter
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetMyDefaultFilter([FromBody]ApplyFilterParameter Parameters)
        {

          
            try
            {
                string strSQL;
                object dt;
                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter NULL," + HttpUtility.UrlDecode(Parameters.LoginType) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.FilterID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.Flag));

                dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {

                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


            
        }

        #region my private method

        private string DecodeWhereClause(string Clause)
        {
            ///string sdafd= HttpUtility.UrlDecode(Clause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
            return HttpUtility.UrlDecode(Clause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
        }

        private string DecodeUrl(int Url)
        {
            return HttpUtility.UrlDecode(Convert.ToString(Url));
        }
        private string DecodeUrl(string Url)
        {
            return HttpUtility.UrlDecode(Convert.ToString(Url));
        }
        #endregion
    }
}
