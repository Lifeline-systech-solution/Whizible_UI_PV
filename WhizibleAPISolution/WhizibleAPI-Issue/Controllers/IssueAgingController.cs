using System;
using System.Collections.Generic;
using System.Data; 
using System.Web;
using System.Web.Http;
using System.Net;
using System.Net.Http;

namespace WhizibleAPI.Controllers
{
    public class IssueAgingController : ApiController
    {  

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetVersionList([FromBody] IssueAging Parameter)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_ResourcewiseIssueAging " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameter.Status)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameter.CustomerID))
                        + "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProductVersionID))
                        + "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.ComponentID))
                        + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameter.ModuleName))
                        + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameter.SubType))
                        + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameter.Assign))
                        + "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.IterationID))
                        + "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserStoryID))
                        + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameter.TypeName))
                        + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameter.CorporateStatus))
                        + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameter.Priority))
                        + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameter.Severity)) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID)) + "";
            DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
       // public List<ProjectFilter> GetProjectDropdownValues([FromBody] IssueParameters issueParameters)
        public  object GetProjectDropdownValues([FromBody] IssueParameters issueParameters)
        {
            Boolean Sesson_Project_Status;
            string ShowAllProjects_IB;
            try
            {
                if (issueParameters.ProjectID != 0)
                {
                    Sesson_Project_Status = Convert.ToBoolean(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_OVER " + issueParameters.ProjectID, true, CommonController.connectionString));

                }
                else
                {
                    Sesson_Project_Status = false;
                }
                if (Sesson_Project_Status == true)
                {
                    ShowAllProjects_IB = "1";
                }
                else
                {
                    ShowAllProjects_IB = "0";
                }
                //string strSQL = "EXEC  usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList ";
                string strSQL = "EXEC  usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList_IssueAging ";
                strSQL += " " + issueParameters.intEmployeeID;
                strSQL += ", 0, 0, NULL, 1";
                strSQL += ", '" + issueParameters.LoginType;
                strSQL += "', 1";
                strSQL += ", " + issueParameters.LoginID;
                strSQL += ", 0";

                if (ShowAllProjects_IB == "1")
                {
                    strSQL += ",0";
                    strSQL += ",NULL," + issueParameters.SessionProjectID + "";
                }
                else
                {
                    strSQL += ",0";
                    strSQL += ",NULL,NULL";
                }

                List<ProjectFilter> projectFilterLists = new List<ProjectFilter>();
                DataTable ProjectFilterTable;
                // ProjectFilterTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + issueParameters.intEmployeeID + ",NULL", true, CommonController.connectionString);
                ProjectFilterTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                foreach (DataRow projectFilterRow in ProjectFilterTable.Rows)
                {
                    ProjectFilter projectFilter = new ProjectFilter()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectID"], "0")),
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(projectFilterRow["ProjectName"], ""))
                    };
                    projectFilterLists.Add(projectFilter);
                }
                return projectFilterLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders] 
        [HttpPost]
        //public QueryList1 GetDefaultFilter([FromBody] IssueAging Parameter)
        public object GetDefaultFilter([FromBody] IssueAging Parameter)
        {
            string strSQL = "";
            IDataReader DefaultQueryFilter;
            QueryList1 DefaultQuery = new QueryList1();
            try
            {
                strSQL = "Exec usp_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter 0,"
            + Parameter.TagID + ",'"
            + HttpUtility.UrlDecode(Parameter.LoginType) + "' ,"
            + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID));

                DefaultQueryFilter = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (DefaultQueryFilter.Read())
                {
                    DefaultQuery.FilterID = Convert.ToInt32(DefaultQueryFilter["FilterID"]);
                    DefaultQuery.FilterName = Convert.ToString(DefaultQueryFilter["FilterName"]);
                    DefaultQuery.QueryText = Convert.ToString(DefaultQueryFilter["QueryText"]);
                    DefaultQuery.Error = Convert.ToString("ok");
                }
                return DefaultQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object chkFilterExists([FromBody] IssueAging Parameter)
        {
            string Flag;
            try
            {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists_ForWBS '"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.Flag)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.FilterID)) + "','"
                + HttpUtility.UrlDecode(Parameter.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', "
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.TagID)) + ",0,"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.UserID));
                Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SavedFilters([FromBody] IssueAging Parameter)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + Parameter.TagID + ",0,"
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
        [Authorize, App_Start.ValidateHeaders]
        public object EditFilterData([FromBody] IssueAging Parameter)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_sel_ByFilterID_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(Parameter.FilterID));
                System.Data.DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object AllMyFilters([FromBody] IssueAging Parameter)
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
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilter([FromBody] IssueAging Parameter)
        {
            string strSQL = "";
            try
            {
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
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody] IssueAging Parameter)
        {
            string strSQL = "";
            try
            {
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

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetProductDropdownValues([FromBody] IssueAging Parameter)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_ProductVersions " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.CustomerID)) + ",NULL," + "'ProductVersions'" + ",NULL";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetModuleDropdownValues([FromBody] IssueAging Parameter)
        {
            string strSQL;
            try
            {

                strSQL = "Exec usp_Whizible2_Sel_Project_componant " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.CustomerID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProductID)) + ",NULL," + "'ProductVersions_Components'";
            DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetSLADetail([FromBody] IssueAging Parameter)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_CalculateSLAForProjectIssues " + HttpUtility.UrlDecode(Convert.ToString(Parameter.IssueID));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object IssueAgingDay([FromBody] IssueAging Parameter)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_IssueAgingDay " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID));
            DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSubTypeDropdownValues([FromBody] IssueAging Parameter)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_SubTaskTypes " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID)) + ",S,'" + HttpUtility.UrlDecode(Convert.ToString(Parameter.TypeName)) + "'";
                System.Data.DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectOnchange([FromBody] IssueAging Parameter)
        {
            string strSQL;
            DataTable dt;

            try
            {
                if (Parameter.FromWhich == "ProjectStatus")
                {
                    strSQL = "Exec usp_Whizible2_Sel_ProjectStatus " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameter.TypeName)) + "'";
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                else if (Parameter.FromWhich == "Module")
                {
                    strSQL = "Exec usp_Whizible2_Sel_Module " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID));
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                else if (Parameter.FromWhich == "Type")
                {
                    strSQL = "Exec usp_Whizible2_Sel_Type " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID));
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                else if (Parameter.FromWhich == "Iteration")
                {
                    strSQL = "Exec usp_Whizible2_Sel_Iteration " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID));
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                else if (Parameter.FromWhich == "UserstoryID")
                {
                    strSQL = "Exec usp_Whizible2_Sel_UserstoryID " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID));
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                else if (Parameter.FromWhich == "ResponsiblePerson")
                {

                    strSQL = "Exec usp_Whizible2_Sel_ResponsiblePerson " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID));
                    //strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'AssignTo'," + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID))+ ",NULL";
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                else
                {
                    strSQL = "Select";
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetIterationIDUserStory([FromBody] IssueAging Parameter)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_ByIterationID " + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameter.IterationID)) + "'";
                System.Data.DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
    }

    public class IssueAging
    {
        //public int Status { get; set; }
        public string Status { get; set; }
        public int ProductVersionID { get; set; }
        public int ComponentID { get; set; }
        //public int ModuleName { get; set; }
        public string ModuleName { get; set; }
        //public int SubType { get; set; }
        public string SubType { get; set; }
        public int Assign { get; set; }
        public int IterationID { get; set; }
        public int UserStoryID { get; set; }
        public int Type { get; set; }
        public int TagID { get; set; }
        public int ProjectID { get; set; }
        public int CustomerID { get; set; }
        public int ProductID { get; set; }
        public int RoleID { get; set; }
        public int IssueID { get; set; }       
        public int UserID { get; set; }       
        public int Flag { get; set; }
        public int FilterID { get; set; }
        public string FromWhich { get; set; }
        public string CorporateStatus { get; set; }
        public string Priority { get; set; }
        public string Severity { get; set; }
        public string TypeName { get; set; }
        public string FilterName { get; set; }
        public string UserName { get; set; }
        public string LoginType { get; set; }
        public string QueryText { get; set; }
    }
    public class QueryList1
    {
        public string FilterName { get; set; }
        public int FilterID { get; set; }
        public string QueryText { get; set; }
        public string SQL { get; set; }
        public int ControlID { get; set; }
        public string ControlValue { get; set; }
        public string Error { get; set; }
    }
    public class ProjectFilter
    {
        public int ProjectID { get; set; }
        public string ProjectName { get; set; }
    }

    public class IssueParameters
    {
        public int intEmployeeID { get; set; }
        public int ProjectID { get; set; }
        public string LoginType { get; set; }

        public int SessionProjectID { get; set; }
        public int LoginID { get; set; }
        public string ViewName { get; set; }
        public int ViewID { get; set; }
        public string FieldList { get; set; }
        public string SortList { get; set; }
        public string IssueList { get; set; }
        public string ViewList { get; set; }
        public string ListType { get; set; }
        public bool IsAccessible { get; set; }
        public int RoleId { get; set; }
        public int PostId { get; set; }
        public string DisplayMode { get; set; }
        public string UserName { get; set; }
        public int QueryID { get; set; }
        public string QueryName { get; set; }
        public string QueryText { get; set; }
        public string QueryType { get; set; }
        public int ExcludeCorporateField { get; set; }
        public string ControlName { get; set; }
        public int count { get; set; }
        public string SearchText { get; set; }
        public string OrderBy { get; set; }
        public string CreatedDate { get; set; }
        public string strpagenumber { get; set; }

        public string IssueSQL { get; set; }
        public int ContextID { get; set; }
        public string DueDate { get; set; }
        public string IssueID { get; set; }
        public string FlagTo { get; set; }
        public string IsComplete { get; set; }
        public int UniqueID { get; set; }
        //Added By Nikhil A
        public int pagsize { get; set; }
        public int pageNumber { get; set; }
        //End Of Added By Nikhil A
        //Added By Reshma Chavan on 25th oct 2021 For Export Report Change
        public int IsExport { get; set; }
        //End of Added By Reshma Chavan on 25th oct 2021 For Export Report Change
        //Added by imran 25-10-2021
        public string FilterQuery { get; set; }
        //End by imran 25-10-2021 
    }
}
