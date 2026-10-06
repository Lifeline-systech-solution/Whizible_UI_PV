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
    public class RM_ResourceDemandStatusController : ApiController
    {

        ////Get Milestones List  
        [HttpPost] 
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object GetDemandStatusList([FromBody]DemandStatusDetail Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_v_tbl_CNF_OpportunityStatus ";
                if (Parameters.StatusID != 0)
                {
                    strSQL += HttpUtility.UrlDecode(Convert.ToString(Parameters.StatusID));
                }
                else
                {
                    strSQL += "NULL";
                }
                if (Parameters.QueryText == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {

                    strSQL += ",'" + HttpUtility.UrlDecode(Parameters.QueryText) + "'";
                }

                DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            

        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveOrUpdateDemandStatus([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_tbl_CNF_OpportunityStatus '"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.StatusName)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.OrderNo)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.IsDrop)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.IsReopen)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.IsClosure)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.IsInitiated)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.IsOnHold)) + ",'"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserName)) + "'";

                if (Parameter.StatusID != 0)
                {
                    strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.StatusID));
                }
                else
                {
                    strSQL += ",NULL";
                }

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

            
        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object ValidateStatusNameOrderNO([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Validate_tbl_CNF_OpportunityStatus '"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.StatusName)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.OrderNo)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.StatusID)); ;

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteStatus([FromBody]int StatusID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_CNF_OpportunityStatus "
                + HttpUtility.UrlDecode(Convert.ToString(StatusID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }


        //Filter part start from here
        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object chkFilterExists([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists_ForWBS '"
                 + HttpUtility.UrlDecode(Convert.ToString(Parameter.Flag)) + "','"
                 + HttpUtility.UrlDecode(Convert.ToString(Parameter.FilterID)) + "','"
                 + HttpUtility.UrlDecode(Parameter.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', "
                 + HttpUtility.UrlDecode(Convert.ToString(Parameter.TagID)) + ",0,"
                 + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID));

                string Flag;

                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Flag;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SavedFilters([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query_ForResourceDemand " + Parameter.TagID + ",0,"
                               + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID)) + ", '"
                               + HttpUtility.UrlDecode(Parameter.FilterName) + "', '"
                               + HttpUtility.UrlDecode(Parameter.LoginType) + "' ,'"
                               + HttpUtility.UrlDecode(Parameter.QueryText) + "','"
                               + HttpUtility.UrlDecode(Parameter.UserName) + "',"
                               + HttpUtility.UrlDecode(Convert.ToString(Parameter.Flag)) + ","
                               + HttpUtility.UrlDecode(Convert.ToString(Parameter.FilterID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            

        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object GetWhereClauseFilter([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(Parameter.FilterID));
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            

        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object AllStageFilters([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query 0,"
                    + Parameter.TagID + ",'"
                    + HttpUtility.UrlDecode(Parameter.LoginType) + "' ,"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilter([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameter.FilterID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object GetDefaultFilter([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter 0,"
                    + Parameter.TagID + ",'"
                    + HttpUtility.UrlDecode(Parameter.LoginType) + "' ,"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID));

                QueryLists DefaultQuery = new QueryLists();
                IDataReader DefaultQueryFilter;
                DefaultQueryFilter = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (DefaultQueryFilter.Read())
                {
                    DefaultQuery.FilterID = Convert.ToInt32(DefaultQueryFilter["FilterID"]);
                    DefaultQuery.FilterName = Convert.ToString(DefaultQueryFilter["FilterName"]);
                    DefaultQuery.QueryText = Convert.ToString(DefaultQueryFilter["QueryText"]);
                }
                return DefaultQuery;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }

        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody]DemandStatusDetail Parameter)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter 0,'"
                    + HttpUtility.UrlDecode(Parameter.LoginType) + "' ,"
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID)) + ","
                    + Parameter.TagID + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.FilterID)) + ","
                    + HttpUtility.UrlDecode(Convert.ToString(Parameter.Flag));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
          
        }

        //Edit filter data.
        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object EditFilterData([FromBody]int FilterID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_sel_ByFilterID_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(FilterID));

                System.Data.DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }


        //Filter part End here
        public class GetDefaultFilterResourceDemandStatus
        {
            public int GetDefaultFilter { get; set; }
        }
    }
}
