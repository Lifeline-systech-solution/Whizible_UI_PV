using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;

namespace WhizibleAPI.Controllers
{
    public class HR_ResourceSkillDetailsController : ApiController
    {
        ////Get  List
        [HttpPost] 
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 29-08-2022 
        public DataTable GetSkillDetailList([FromBody]ResourceSkillDetails Parameters)
        {
            string strSQL = "";
            strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_EmployeeHistory_Skills ";            
            if (Parameters.OrganizationUnitID == 0)
            {
                strSQL += "Null";
            }
            else
            {

                strSQL += HttpUtility.UrlDecode(Convert.ToString(Parameters.OrganizationUnitID));
            }
            if (Parameters.CategoryID == 0)
            {
                strSQL += ",Null";
            }
            else
            {

                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.CategoryID));
            }
            if (Parameters.Skill == "Null")
            {
                strSQL += ",Null";
            }
            else
            {

                strSQL += ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.Skill)) + "'";
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

        //Get  List
        [HttpPost]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetOrganizationStructure()
        {
            try { 
            string strSQL = "";
            strSQL = "Exec usp_Whizible2_Get_Resource_BG_OU ";           
            DataTable dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Filter part start from here
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [HttpPost]
        public object chkFilterExists([FromBody]ResourceSkillDetails Parameter)
        {
            try { 
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
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SavedFilters([FromBody]ResourceSkillDetails Parameter)
        {
            try { 
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
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetWhereClauseFilter([FromBody]ResourceSkillDetails Parameter)
        {
            try { 
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
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object AllResourceFilters([FromBody]ResourceSkillDetails Parameter)
        {
            try { 
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
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilter([FromBody]ResourceSkillDetails Parameter)
        {
            try { 
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

        [Authorize]
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        public object GetDefaultFilter([FromBody]ResourceSkillDetails Parameter)
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
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody]ResourceSkillDetails Parameter)
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
        //Added by imran on 29-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 29-08-2022
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


    }

    public class ResourceSkillDetails
    {
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public int EmployeeID { get; set; }
        public int OrganizationUnitID { get; set; }
        public int CategoryID { get; set; }
        public string QueryText { get; set; }
        public string Skill { get; set; }
        public string LoginType { get; set; }
        public string UserName { get; set; }
        public string FilterName { get; set; }
        public string CreatedBy { get; set; }
        public int FilterID { get; set; }
        public int Flag { get; set; }
        
    }
    public class QueryLists
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
        public string SQL { get; set; }
        public int ControlID { get; set; }
        public string ControlValue { get; set; }


    }
}
