using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Web;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.Issue;
using System.Web.SessionState;

using System.Data.OleDb;
using System.Data.SqlClient;
using System.Text;


namespace WhizibleAPI.Controllers
{
   
    public class IssueController : ApiController
    {
        #region "Main Page"
        /// <summary>
        /// GetRole - To get the role of employee
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        /// 
      
        
        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022

        public object GetRole([FromBody]IssueParameters issueParameters)
        {
            try
            {
                int role = 0;
                int corporaterole = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("EXEC usp_Whizible2_sel_tbl_PM_Role_RoleID " + issueParameters.intEmployeeID.ToString(), true, CommonController.connectionString), "0"));

                if (corporaterole != 1 && corporaterole != 2 && issueParameters.ProjectID > 0)
                {

                    role = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("EXEC usp_Whizible2_sel_tbl_PM_Role_role " + issueParameters.ProjectID.ToString() + "," + issueParameters.intEmployeeID.ToString(), true, CommonController.connectionString), "0"));
                }

                return role;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        /// GetIsAgileMethodologyApplied
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetIsAgileMethodologyApplied([FromBody]IssueParameters issueParameters)
        {
            try
            {
                int Flag = 0;
                Flag = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("EXEC usp_Whizible2_Sel_ProjectTypeInfo " + issueParameters.ProjectID + "", true, CommonController.connectionString), "0"));

                return Flag;
            }            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        /// GetProjectDropdownValues - Get the list of Projects available to the Employee
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
         //Added by riddhesh   on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<ProjectFilter> GetProjectDropdownValues([FromBody]IssueParameters issueParameters)
        public object GetProjectDropdownValues([FromBody] IssueParameters issueParameters)


        {
            try
            {
                Boolean Sesson_Project_Status;
                string ShowAllProjects_IB;
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
                string strSQL = "EXEC  usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList ";
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

        /// <summary>
        /// GetDefaultQuery - Get the Default Query for the Employee for Specific Project, Login Type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetDefaultQuery([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_DefaultQuery ";
                strSQL += issueParameters.intEmployeeID;
                strSQL += "," + issueParameters.ProjectID;
                strSQL += ",'" + issueParameters.LoginType + "'";
                QueryList defaultQuery = new QueryList();
                IDataReader drDefaultQuery;
                drDefaultQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drDefaultQuery.Read())
                {
                    defaultQuery.QueryID = Convert.ToInt32(drDefaultQuery["QueryID"]);
                    defaultQuery.QueryName = Convert.ToString(drDefaultQuery["QueryName"]);
                    defaultQuery.QueryText = Convert.ToString(drDefaultQuery["QueryText"]);
                    defaultQuery.QueryType = Convert.ToString(drDefaultQuery["Type"]);
                    CommonFunctions.Data.DisposeDataReader(ref drDefaultQuery);
                }

                return defaultQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetSearchOptions - Get the list of Search Options for specific Login Type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
     //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]//Added By Dipali V On 27th July 2023 For Issue Performance
        //public List<SearchOption> GetSearchOptions([FromBody]IssueParameters issueParameters)
        public object GetSearchOptions([FromBody] IssueParameters issueParameters)

        {
            try
            {
                List<SearchOption> searchOptionLists = new List<SearchOption>();
                DataTable SearchOption;
                SearchOption = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_IssueBaseSearchOptions " + issueParameters.LoginType, true, CommonController.connectionString);


                foreach (DataRow SearchOptionRow in SearchOption.Rows)
                {
                    SearchOption searchOption = new SearchOption()
                    {
                        Id = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(SearchOptionRow["Id"], "")),
                        Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(SearchOptionRow["Value"], ""))
                    };
                    searchOptionLists.Add(searchOption);
                }
                return searchOptionLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetIssueHeader - Get the comma separated user friendly names for default view or Project view, and other view details such as name, field list, Sort By
        /// for the Employee and Role Type
        /// which will be shown as column headers
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetIssueHeader([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string strSQL = "";
                ViewDetails viewDetails = new ViewDetails();
                if (issueParameters.ViewID == 0)
                {

                    strSQL = "Exec usp_Whizible2_Sel_tbl_IB_DefaultView " + issueParameters.intEmployeeID + "," + issueParameters.ProjectID + ",'" + issueParameters.LoginType + "'";
                    viewDetails = GetViewDetails(strSQL, issueParameters.ViewID);
                }
                else
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Views NULL,NULL,NULL," + issueParameters.ViewID.ToString();
                    viewDetails = GetViewDetails(strSQL, issueParameters.ViewID);
                }

                viewDetails.UserFriendlyNameList = GetUserFriendlyFieldNames(viewDetails.FieldList);
                return viewDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetIssueData - This is the main Method to get Issue Data
        /// SQL statement is formed based on various parameter values such as login type, Display Mode (Static Filters), Query Text, Search Text
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetIssueData([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string FieldList = issueParameters.FieldList;
                //string strSQLMyIB = "";
                //string strQueryText = "";
                //string strSQL = "SELECT ";

                //strSQL += "IssueID as IID, ";

                //strSQL += FieldList + ", ";
                ////Added & Commented By Dipali V On 17th April 2020 For History ID Should not be same as Issue ID
                ////strSQL += " LastUpdatedDate, IssueID as History, ";
                //strSQL += "  LastUpdatedDate, '' as History,";
                ////End of Added & Commented By Dipali V On 17th April 2020 For History ID Should not be same as Issue ID
                //strSQL = FormatDateFields(strSQL);
                //strSQL = FormatNullFields(strSQL);
                //strSQL = strSQL.Replace("ShowToCustomer", "CASE WHEN ShowToCustomer=1 THEN 'Yes' ELSE 'No' END as ShowToCustomer");
                //strSQL += " (select Case When IsComplete=1 then 'B' When (Datediff(dd,tbl_PM_FlagForTracking.DDate,Getdate())>0 AND IsComplete=0) then 'L'    ";
                //strSQL += "	   When (Datediff(dd,tbl_PM_FlagForTracking.DDate,Getdate())<0 AND IsComplete=0) then 'G' ";
                //strSQL += "	 When (Datediff(dd,tbl_PM_FlagForTracking.DDate,Getdate())=0 AND IsComplete=0) then 'S' else ''  ";
                //strSQL += " End ) as Flag,";
                //strSQL += " (SELECT COUNT(DiscussionID) FROM tbl_IB_Discussion WHERE IssueId = v_tbl_IB_Issue.IssueId ";
                //if (issueParameters.LoginType == "C")
                //{
                //    strSQL += " AND tbl_IB_Discussion.ShowToCustomer = 1";
                //}
                //strSQL += " ) as Discussions, ";
                ////Added by Swapnagandha to get Count Of Attachments 
                ////   strSQL += " (SELECT COUNT(AttachmentId) FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId) as Attachments ";
                //strSQL += " (select  count(*) from(SELECT AttachmentId FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId";
                //strSQL += " union all SELECT AttachmentId FROM tbl_IB_Discussion_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId) as tem) as Attachments ";




                //End Added by Swapnagandha to get Count Of Attachments 
                //strSQL += " FROM v_tbl_IB_Issue ";
                //strSQL += " LEFT JOIN d_tbl_PM_FlagForTracking AS tbl_PM_FlagForTracking";
                //strSQL += " ON v_tbl_IB_Issue.IssueID = tbl_PM_FlagForTracking.ContextID AND ContextType = 'IB' AND EmployeeID =";
                //strSQL += issueParameters.intEmployeeID.ToString();

                //strSQL += " WHERE 1 = 1";
                //if (issueParameters.LoginType == "C")
                //{
                //    strSQL += " AND ShowToCustomer = 1 ";
                //}
                //strSQL += " AND v_tbl_IB_Issue.ProjectID IN(" + issueParameters.ProjectID +")  ";

                //string strTypes = GetCommaSeparatedTypes(issueParameters.ProjectID, issueParameters.RoleId);
                //if (strTypes != "")
                //{
                //    strSQL += "AND Type in (" + strTypes + ")";
                //}
                //if(issueParameters.LoginType == "E" )
                //{
                //    if (issueParameters.DisplayMode == "M")
                //    {
                //        strSQLMyIB = " AND (AssignToName='" + CommonFunctions.General.BuildQueryString(issueParameters.UserName);
                //        strSQLMyIB += "' OR IssueID IN (Select OtherTaskID From Tbl_PM_ProjectTasks where IsActive=1 AND WhichTask ='B' AND EmployeeID=";
                //        strSQLMyIB += issueParameters.intEmployeeID.ToString() + " AND ProjectID = " + issueParameters.ProjectID + ")) ";
                //    }
                //    else if (issueParameters.DisplayMode == "S")
                //    {
                //        strSQLMyIB = " AND (ReportedBy ='" + CommonFunctions.General.BuildQueryString(issueParameters.UserName);
                //        strSQLMyIB += "') ";
                //    }
                //}
                //if(issueParameters.DisplayMode == "F")
                //{
                //    strSQL += " AND IssueID IN (SELECT ContextID FROM tbl_PM_FlagForTracking WHERE ProjectID = v_tbl_IB_Issue.ProjectID ";
                //    strSQL += " AND ContextID = v_tbl_IB_Issue.IssueID AND tbl_PM_FlagForTracking.ContextType = 'IB' ";
                //    strSQL += " AND tbl_PM_FlagForTracking.EmployeeID = " + issueParameters.intEmployeeID + ")";
                //}
                //if(issueParameters.QueryID > 0)
                //{
                //    strQueryText = " AND (" + GetQueryText(issueParameters.QueryID);
                //    strQueryText = FormatDateCriteriaFields(strQueryText);
                //    strQueryText += ") ";
                //}
                //if(issueParameters.QueryText.Trim() != "")
                //{
                //    strQueryText = " AND (" + issueParameters.QueryText.Replace("''","'");
                //    strQueryText = FormatDateCriteriaFields(strQueryText);
                //    strQueryText += ") ";
                //}
                //if (issueParameters.SearchText.Trim() != "")
                //{
                //    if (issueParameters.SearchText.IndexOf("Discussion") > -1)
                //    {
                //        strQueryText += " AND (" + issueParameters.SearchText.Replace("Discussion", "IssueID IN (Select IssueID from tbl_IB_Discussion WHERE Comments ");// + ")) ";
                //        if (issueParameters.LoginType == "C")
                //        {
                //            strQueryText += " AND tbl_IB_Discussion.ShowToCustomer = 1";
                //        }
                //        strQueryText += "))";
                //    }
                //    else
                //    {
                //        strQueryText += " AND (" + issueParameters.SearchText + ") ";
                //    }
                //}

                //strSQL += strSQLMyIB;
                //strSQL += strQueryText;


                //strSQL += GenerateCriteria(issueParameters);
                //strSQL += " Order By ";
                //strSQL += FormatDateSortFields(issueParameters.OrderBy);
                string strSQL = "";
                strSQL = "" +
                    " EXEC usp_whizible2_Sel_tbl_IB_Issuelist '" + FieldList + "' ,'" + issueParameters.LoginType + "','";
                strSQL = FormatDateFields(strSQL);
                strSQL = FormatNullFields(strSQL);
                //Commented and Added By Usha Pandit On 11.09.2020 For crash due to single quote escape 
                //strSQL = strSQL.Replace("ShowToCustomer", "CASE WHEN ShowToCustomer=1 THEN 'Yes' ELSE 'No' END as ShowToCustomer");
                strSQL = strSQL.Replace("ShowToCustomer", "CASE WHEN ShowToCustomer=1 THEN ''Yes'' ELSE ''No'' END as ShowToCustomer");
                //End Of Added By Usha Pandit On 11.09.2020 For crash due to single quote escape
                strSQL += GenerateCriteria(issueParameters);
                strSQL += " Order By ";
                strSQL += FormatDateSortFields(issueParameters.OrderBy);

                //strSQL += issueParameters.pageNumber +",";
                //strSQL += issueParameters.pagsize + "

                //Added By Nikhil A
                //Commented And Added By Reshma Chavan on 25th oct 2021 For Export Report Change
                // strSQL += " OFFSET (" + issueParameters.pageNumber + "- 1) * " + issueParameters.pagsize + " ROWS FETCH NEXT " + issueParameters.pagsize + " ROWS ONLY";
                //strSQL += "'";

                if (issueParameters.IsExport == 0)
                {
                    strSQL += " OFFSET (" + issueParameters.pageNumber + "- 1) * " + issueParameters.pagsize + " ROWS FETCH NEXT " + issueParameters.pagsize + " ROWS ONLY";
                    strSQL += "'";
                }
                else
                {
                    strSQL += "'";
                }
                //End of Commented And Added By Reshma Chavan on 25th oct 2021 For Export Report Change
                //End of Added By Nikhil A
                //strSQL += (issueParameters.OrderBy == "" ? "IssueID Desc" : issueParameters.OrderBy);

                DataTable issues = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                // int colCount = issues.Columns.Count;
                // System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                // List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                // Dictionary<string, object> row;
                // //HttpContext.Current.Session[]
                //// int strProj = (int)HttpContext.Current.Session["intProjectID"];

                // // Session["IssueSQL"] = strSQL;
                // foreach (DataRow issue in issues.Rows)
                // {
                //     row = new Dictionary<string, object>();
                //     foreach (DataColumn col in issues.Columns)
                //     {
                //         row.Add(col.ColumnName, issue[col]);
                //     }
                //     rows.Add(row);
                // }

                // //return issues;
                // return serializer.Serialize(rows) +"_&&_"+ strSQL;

                for (int i = 0; i < issues.Columns.Count; i++)
                {
                    //cols += "Col" + i.ToString() +",";
                    issues.Columns[i].ColumnName = "Col" + i.ToString();
                }
                //string cols = "";
                //cols = cols.Substring(0, cols.Length - 1);
                //string[] collist = cols.Split(',');
                //DataTable dt;
                //System.Data.DataView view = new System.Data.DataView(issues);
                //dt = new DataView(issues).ToTable(false, collist);
                issueDatawithQuery obj = new issueDatawithQuery();
                obj.issuedata = issues;
                obj.strselect = strSQL;
                return obj;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetIssueCount([FromBody]IssueParameters issueParameters)
        {
            try
            {
                //string strSQL = "SELECT COUNT(IssueID) ";
                string strSQL = "usp_whizible2_Sel_tbl_GetISsueCount '" + GenerateCriteria(issueParameters) + "'";

                int RecordCount = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                return RecordCount.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetSearchOptionControl - Get the Search Option control along with it's Values and Type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
         //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetSearchOptionControl([FromBody]IssueParameters issueParameters)
        {
            try
            {
                SearchOptionControl searchControl = new SearchOptionControl();
                List<ControlCombo> lstControlCombo = new List<ControlCombo>();
                string cname = issueParameters.ControlName.ToUpper();
                DataTable cmbTable = new DataTable();
                switch (cname)
                {
                    case "DELIVERABLES":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_OtherSchedules_QueryBuilder " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "SUBMITTED BY":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_ReportedBy " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "RESPONSIBLE PERSON":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_Project_Resources " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "SHOW TO CUSTOMER":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_QueryBuilder_YesNo ", true, CommonController.connectionString);
                        break;
                    case "STATUS":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "ISSUE TYPE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_TYPE " + issueParameters.ProjectID + "," + issueParameters.RoleId, true, CommonController.connectionString);
                        break;
                    default:
                        break;
                }

                switch (cname)
                {
                    case "DELIVERABLES":
                    case "SUBMITTED BY":
                    case "RESPONSIBLE PERSON":
                    case "SHOW TO CUSTOMER":
                    case "STATUS":
                    case "ISSUE TYPE":
                        foreach (DataRow cmbRow in cmbTable.Rows)
                        {
                            ControlCombo controlCombo = new ControlCombo()
                            {
                                Key = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[0], "")),
                                Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[1], "")),
                            };
                            lstControlCombo.Add(controlCombo);
                        }
                        searchControl.lstControlCombo = lstControlCombo;
                        searchControl.Type = "C";
                        break;
                    case "ISSUE ID":
                    case "SUMMARY":
                    case "DESCRIPTION":
                        searchControl.Type = "T";
                        break;
                    case "REPORTED DATE":
                    case "LAST UPDATED":
                        searchControl.Type = "D";
                        break;
                }


                return searchControl;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// DeleteIssues - Delete the Issue(s)
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteIssues([FromBody]IssueParameters issueParameters)
        {
            try
            {

                string strIssueIDNotDeleted = "";
                string issueList = issueParameters.IssueList.Trim();
                string[] arrIssueList = issueList.Split(',');
                for (int cnt = 0; cnt < arrIssueList.Length; cnt++)
                {
                    string strResult = "";
                    string IssueId = arrIssueList[cnt];
                    string strSQL1 = "Exec usp_Whizible2_Del_IB_tbl_IB_Issue " + IssueId;
                    strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));

                    if (strResult == "")
                    {
                        //if (CommonFunctions.Application.PhysicalDeletionOfDocuments)
                        //{
                        //    IDataReader drAttachments;
                        //    drAttachments = CommonFunctions.Data.GetDataReader("EXEC usp_Whizible2_Sel_tbl_IB_Attachment " + IssueId + ",0", true, CommonController.connectionString);
                        //    while (drAttachments.Read())
                        //    {
                        //        // System.IO.File Attachment;
                        //        //string AttachmentPath = Server.MapPath("../../Attachments/BTS") + "\\" + drAttachments["FilePath"] + "";
                        //        //if (Attachment.Exists(AttachmentPath))
                        //        //{
                        //        //    Attachment.Delete(AttachmentPath);
                        //        //}
                        //        var mappedPath = System.Web.Hosting.HostingEnvironment.MapPath("../../Attachments/BTS" + "\\" + drAttachments["FilePath"]);
                        //        if (System.IO.File.Exists(mappedPath))
                        //        {
                        //            System.IO.File.Delete(mappedPath);
                        //        }
                        //    }
                        //    CommonFunctions.Data.DisposeDataReader(ref drAttachments);
                        //}

                    }
                    else
                    {
                        strIssueIDNotDeleted += strIssueIDNotDeleted + "," + strResult;
                    }
                }
                if (strIssueIDNotDeleted != "")
                {
                    return "Failed for " + strIssueIDNotDeleted;
                }
                return "Success";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion
        #region "Views Related"
        /// <summary>
        /// GetViewList - Get list of View Details for specified project, Employee and login type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<ViewList> GetViewList([FromBody]IssueParameters issueParameters)
        public object GetViewList([FromBody] IssueParameters issueParameters)

        {
            try
            {
                List<ViewList> viewLists = new List<ViewList>();
                DataTable ViewListTable;
                ViewListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Project_Views_All " + issueParameters.ProjectID + ",'" + issueParameters.LoginType + "'," + issueParameters.intEmployeeID + ",-1,NULL, 'ORDER BY ViewType, CreatedDate DESC'", true, CommonController.connectionString);

                foreach (DataRow viewRow in ViewListTable.Rows)
                {
                    ViewList viewList = new ViewList()
                    {
                        ViewId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(viewRow["ProjectViewID"], "0")),
                        ViewName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(viewRow["ViewName"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(viewRow["ProjectID"], "0")),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(viewRow["EmployeeID"], "0")),
                        Fields = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(viewRow["Fields"], "")),
                        SortBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(viewRow["SortBy"], "")),
                        CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(viewRow["CreatedDate"], "")),
                        CreatedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(viewRow["EmployeeName"], "")),
                        DefaultViewId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(viewRow["DefaultViewID"], "0")),
                        ViewType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(viewRow["ViewType"], ""))
                    };
                    viewLists.Add(viewList);
                }
                return viewLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// SetAsDefaultView - Set the view as Default for specified Project, Employee and login type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetAsDefaultView([FromBody]IssueParameters issueParameters)
        {
            try{
                string strSQL = "Exec usp_Whizible2_Upd_IB_SetDefaultView " + issueParameters.ProjectID;
                strSQL += ",'" + issueParameters.LoginType;
                strSQL += "'," + issueParameters.intEmployeeID;
                strSQL += "," + (issueParameters.ViewID != 0 ? issueParameters.ViewID.ToString() : "NULL");
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Success";
            }            
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// DeleteProjectView - delete view(s)
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectView([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string viewList = issueParameters.ViewList.Trim();
                string[] arrViewList = viewList.Split(',');
                for (int cnt = 0; cnt < arrViewList.Length; cnt++)
                {
                    string ViewId = arrViewList[cnt];
                    string strSQL1 = "Exec usp_Whizible2_Del_tbl_IB_Project_Views " + ViewId;
                    CommonFunctions.Data.InsertOrUpdateData(strSQL1, true, CommonController.connectionString);
                }
                return "Success";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetProjectView_FieldList - get the list of fields used while creating view with details name, actual name and iscustom field
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<ProjectViewFieldList> GetProjectView_FieldList([FromBody]IssueParameters issueParameters)
        public object GetProjectView_FieldList([FromBody] IssueParameters issueParameters)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_ProjectViews_GetFieldList ";
                strSQL += issueParameters.ProjectID;
                strSQL += "," + (issueParameters.ViewID != 0 ? issueParameters.ViewID.ToString() : "NULL");
                strSQL += ",'" + issueParameters.ListType;
                strSQL += "'," + (issueParameters.IsAccessible == true ? "1" : "0");
                strSQL += ",'" + issueParameters.LoginType;
                strSQL += "'," + issueParameters.RoleId;
                strSQL += "," + issueParameters.intEmployeeID;

                List<ProjectViewFieldList> lstProjectViewFieldList = new List<ProjectViewFieldList>();
                DataTable FieldTable;
                FieldTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow fieldRow in FieldTable.Rows)
                {
                    ProjectViewFieldList projectViewFieldList = new ProjectViewFieldList()
                    {
                        FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(fieldRow["FieldID"], "")),
                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(fieldRow["FieldName"], "")),
                        ActualFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(fieldRow["ActualFieldName"], ""))
                        //IsCustomField = Convert.ToBoolean(CommonFunctions.General.CheckIsNothing(fieldRow["IsCustomField" +
                        //"" +
                        //""]))
                    };
                    lstProjectViewFieldList.Add(projectViewFieldList);
                }
                return lstProjectViewFieldList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// SaveView - Save the view
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveView([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Ins_tbl_IB_Project_Views ";
                strSQL += (issueParameters.ViewID != 0 ? issueParameters.ViewID.ToString() : "NULL");
                strSQL += "," + issueParameters.ProjectID;
                strSQL += ",'" + issueParameters.LoginType;
                strSQL += "'," + issueParameters.intEmployeeID;
                //Commented And Added By Usha Pandit On 16.03.2020 For crash if single quote is enter in view name
                //strSQL += "," + (issueParameters.ViewName != "" ? "'" + issueParameters.ViewName.Trim() + "'" : "NULL");
                strSQL += "," + (issueParameters.ViewName != "" ? "'" + issueParameters.ViewName.Trim().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'" : "NULL");
                //End Of Added By Usha Pandit On 16.03.2020 For crash if single quote is enter in view name
                strSQL += "," + (issueParameters.FieldList != "" ? "'" + issueParameters.FieldList.Trim() + "'" : "NULL");
                strSQL += "," + (issueParameters.SortList != "" ? "'" + issueParameters.SortList.Trim() + "'" : "NULL");
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Success";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        #endregion
        #region "Query Related"
        /// <summary>
        /// GetQueryList - Get list of Queries (Filters) created for the specified Project, employee, login type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        [Authorize]
        [HttpPost]
        //public List<QueryList> GetQueryList([FromBody]IssueParameters issueParameters)
        public object GetQueryList([FromBody] IssueParameters issueParameters)


        {
            try
            {
                //Commented & Added By Dipali V On 3rd Sep 2020 For inline to SP conversion
                //string strSQL = "SELECT ISNULL(DefaultQueryID,0) DefaultQueryID FROM tbl_IB_DefaultSettings";
                //strSQL += " WHERE ProjectID=" + issueParameters.ProjectID;
                //strSQL += " AND EmployeeID=" + issueParameters.intEmployeeID;
                //strSQL += " AND LoginType='" + issueParameters.LoginType + "'";

                string strSQL = "usp_whizible2_Sel_tbl_IB_GetDefaultSettings " + issueParameters.ProjectID + "," + issueParameters.intEmployeeID + ",'" + issueParameters.LoginType + "'";
                //End of Commented & Added By Dipali V On 3rd Sep 2020 For inline to SP conversion
                int DefaultId = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                if (DefaultId == 0) DefaultId = -1;

                List<QueryList> queryLists = new List<QueryList>();
                DataTable queryListTable;
                queryListTable = CommonFunctions.Data.GetDataTable("Usp_Whizible2_Sel_tbl_IB_Query   " + (issueParameters.QueryID == 0 ? "NULL" : issueParameters.QueryID.ToString()) + "," + issueParameters.ProjectID + "," + issueParameters.intEmployeeID + ",'','" + issueParameters.LoginType + "','" + issueParameters.ListType + "'", true, CommonController.connectionString);

                foreach (DataRow queryRow in queryListTable.Rows)
                {
                    QueryList queryList = new QueryList()
                    {
                        QueryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(queryRow["QueryID"], "0")),
                        QueryName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(queryRow["QueryName"], "")),
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(queryRow["ProjectID"], "0")),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(queryRow["EmployeeID"], "0")),
                        QueryText = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(queryRow["QueryText"], "")),
                        CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(queryRow["CreatedDate"], "")),
                        QueryType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(queryRow["Type"], "")),
                        IsDefault = (Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(queryRow["QueryID"], "0")) == DefaultId ? true : false),
                    };
                    queryLists.Add(queryList);
                }
                return queryLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Addition by Manjiri

        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        //public List<IssueParameters> Getmyfilterquery([FromBody] IssueParameters statusparameter)
        public object Getmyfilterquery([FromBody] IssueParameters statusparameter)

        {
            try { 
            List<IssueParameters> userlist = new List<IssueParameters>();
            DataTable ulist;
            if (statusparameter.QueryID == 0)
            {
                ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Query_for_IssueList NULL," + statusparameter.ProjectID + " , " + statusparameter.intEmployeeID + ",'" + statusparameter.strpagenumber + "','" + statusparameter.LoginType + "','A'", true, CommonController.connectionString);
            }
            else
            {
                ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Query_for_IssueList " + statusparameter.QueryID + "," + statusparameter.ProjectID + " , " + statusparameter.intEmployeeID + ",'" + statusparameter.strpagenumber + "','" + statusparameter.LoginType + "'", true, CommonController.connectionString);
            }

            foreach (DataRow userlistRow in ulist.Rows)
            {
                IssueParameters usrlist = new IssueParameters();

                usrlist.QueryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["QueryID"], "0"));
                usrlist.QueryName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["QueryName"], ""));
                usrlist.ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["ProjectID"], "0"));
                usrlist.intEmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["EmployeeID"], "0"));
                usrlist.QueryText = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["QueryText"], ""));
                usrlist.CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["CreatedDate"], ""));
                usrlist.QueryType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Type"], ""));
                userlist.Add(usrlist);
            }
            return userlist;
            }
                        
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        /// SetAsDefaultQuery - Set the Query(filter) as default for specified project, employee, login type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetAsDefaultQuery([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_IB_SetDefaultQuery " + issueParameters.ProjectID;
                strSQL += ",'" + issueParameters.LoginType;
                strSQL += "'," + issueParameters.intEmployeeID;
                strSQL += "," + (issueParameters.QueryID != 0 ? issueParameters.QueryID.ToString() : "NULL");
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Success";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// DeleteQuery - Delete Query(filter)
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteQuery([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string strSQL1 = "Exec usp_Whizible2_Del_tbl_IB_Query " + issueParameters.QueryID.ToString();
                CommonFunctions.Data.InsertOrUpdateData(strSQL1, true, CommonController.connectionString);
                return "Success";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// SaveQuery - insert or update query (filter) based on query id is 0 (to be created) or existing
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveQuery([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string strReturn = "";
                string strSQL = "";
                ////Added by Swapnagandha K. On 31 Jul 2019 To Add Validate Query
                //string strSQLQuery = "";
                //Boolean blnIsValidQuery;
                //string myRef = "";
                //string QueryText = "";
                //QueryText = issueParameters.QueryText;
                //QueryText = QueryText.Replace("\n", "");
                //QueryText = QueryText.Replace("\r", "");

                ////Create the SQL query
                //strSQLQuery = "SELECT * FROM v_tbl_IB_Issue WHERE " + QueryText.Trim();
                //strSQLQuery += " ORDER BY IssueID , ImportID , ProjectID , Type , CorporateType , SubType , CorporateSubType , Priority , CorporatePriority , Status , CorporateStatus ,";
                //strSQLQuery += " Severity , CorporateSeverity , ReportedBy , AssignTo , ReportedDate , CreatedDate , CustomerIssueID , ReportedInVersion , CorrectedInVersion , ";
                //strSQLQuery += " Summary ,  ModuleName , OS , Hardware , Kernel , Duration , Duedate , Phase , FoundInPhase , FixedInPhase , CodedBy , ShowToCustomer , ";
                //strSQLQuery += " Keywords , CreatorOrModifier , CustomFieldText1 , CustomFieldText2 , CustomFieldText3 , CustomFieldText4 , CustomFieldText5 , CustomFieldText6 , ";
                //strSQLQuery += " CustomFieldText7 , CustomFieldText8 , CustomFieldText9 , CustomFieldText10 , CustomFieldCombo1 , CustomFieldCombo2 , CustomFieldCombo3 ,";
                //strSQLQuery += " CustomFieldCombo4 , CustomFieldCombo5 , CustomFieldCombo6 , CustomFieldCombo7 , CustomFieldCombo8 , CustomFieldCombo9 , CustomFieldCombo10 , ";
                //strSQLQuery += " CustomFieldDate1 , CustomFieldDate2 , CustomFieldDate3 , CustomFieldDate4 , CustomFieldDate5 , CustomFieldTextArea3 , ClosedDate , ProjectName ";

                ////validate the query
                //blnIsValidQuery = CommonFunctions.Data.ValidateQuery(strSQLQuery, true, CommonController.connectionString,ref myRef);

                ////End by Swapnagandha K. On 31 Jul 2019 To Add Validate Query
                if (issueParameters.QueryID > 0)
                {
                    strSQL += "Exec usp_Whizible2_Upd_tbl_IB_Query ";
                    strSQL += issueParameters.QueryID + ", ";
                }
                else
                {
                    strSQL += "Exec usp_Whizible2_Ins_tbl_IB_Query ";
                }
                strSQL += issueParameters.ProjectID;
                strSQL += "," + issueParameters.intEmployeeID;
                strSQL += "," + (issueParameters.QueryName != "" ? "'" + issueParameters.QueryName.Trim() + "'" : "NULL");
                strSQL += "," + (issueParameters.QueryText != "" ? "'" + issueParameters.QueryText.Trim() + "'" : "NULL");
                strSQL += ",'" + issueParameters.LoginType + "'";
                strSQL += ",'" + issueParameters.QueryType + "'";

                strReturn = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return strReturn;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetQueryFieldList - Get the list of fields to create query for specified project, employee, role
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<QueryField> GetQueryFieldList([FromBody]IssueParameters issueParameters)
        public object GetQueryFieldList([FromBody] IssueParameters issueParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Issue_GetFieldList_InOrder ";
                strSQL += issueParameters.ProjectID;
                strSQL += "," + issueParameters.RoleId;
                strSQL += "," + issueParameters.ExcludeCorporateField;
                strSQL += "," + issueParameters.intEmployeeID;

                List<QueryField> lstQueryField = new List<QueryField>();
                DataTable FieldTable;
                FieldTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow fieldRow in FieldTable.Rows)
                {
                    QueryField queryField = new QueryField()
                    {
                        FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(fieldRow["FieldID"], "")),
                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(fieldRow["FieldName"], "")),

                    };
                    lstQueryField.Add(queryField);
                }
                return lstQueryField;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetOperatorList - Get list of operators used to build the query(filter)
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
       
       
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]//Added By Dipali V On 27th July 2023 For Issue Performance
        //public List<Operator> GetOperatorList([FromBody]IssueParameters issueParameters)
        public object GetOperatorList([FromBody] IssueParameters issueParameters)

        {
            try
            {
                List<Operator> lstOperator = new List<Operator>();
                DataTable OpTable;
                OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_queryBuilder_Operator", true, CommonController.connectionString);

                foreach (DataRow opRow in OpTable.Rows)
                {
                    Operator Operator = new Operator()
                    {
                        Key = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Key"], "")),
                        Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Value"], "")),

                    };
                    lstOperator.Add(Operator);
                }
                return lstOperator;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        /// GetFilterControl - Get the filter Control along with it's values and type
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
         //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetFilterControl([FromBody]IssueParameters issueParameters)
        {
            try
            {
                FilterControl filterControl = new FilterControl();
                List<ControlCombo> lstControlCombo = new List<ControlCombo>();
                string cname = issueParameters.ControlName.ToUpper();
                DataTable cmbTable = new DataTable();
                switch (cname)
                {
                    case "COMPLEXITY":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Complexity " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "HARDWARE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_PM_ProjectHardware " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "CODEDBYNAME":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_Project_Resources " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "STATUS":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status_for_issuelist " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "CUSTOMER":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_SEL_Tbl_PM_Customer_forQueryBuilder " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "DELIVERABLE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_OtherSchedules_QueryBuilder " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "FIXEDINPHASE":
                    case "FOUNDINPHASE":
                    case "PHASE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "KERNEL":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Kernels " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "KEYWORDS":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Keywords " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "MODULENAME":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_PM_Module_Filter_And_Query " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "COMPONENT":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC USP_Whizible2_SEL_Tbl_PRD_ProductVersion_Component NULL, NULL, " + issueParameters.ProjectID + "," + issueParameters.intEmployeeID + ",'" + issueParameters.LoginType + "', 1", true, CommonController.connectionString);
                        break;
                    case "OS":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_OS " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "PRIORITY":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Priorities " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "PRODUCTVERSION":
                    case "REPORTEDINVERSION":
                    case "CORRECTEDINVERSION":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Version " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "REPORTEDBY":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_ReportedBy " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "ASSIGNTONAME":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_Project_Resources " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "ROOTCAUSE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_IB_Project_RootCause_QueryBuilder " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "SEVERITY":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Severity " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "SHOWTOCUSTOMER":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_QueryBuilder_YesNo ", true, CommonController.connectionString);
                        break;

                    case "SUBTYPE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_SUB_TYPE " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "TYPE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_TYPE " + issueParameters.ProjectID + "," + issueParameters.RoleId, true, CommonController.connectionString);
                        break;
                    case "SCRUMRELEASE":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumRelease_Release " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "SCRUMITERATION":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumIteration_IterationName " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    case "SCRUMUSERSTORY":
                        cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumUserStory_UserStoryName " + issueParameters.ProjectID, true, CommonController.connectionString);
                        break;
                    default:
                        break;
                }

                switch (cname)
                {
                    case "COMPLEXITY":
                    case "HARDWARE":
                    case "CODEDBYNAME":
                    case "CORPORATEPRIORITY":
                    case "CORPORATESEVERITY":
                    case "CORPORATESTATUS":
                    case "CORPORATESUBTYPE":
                    case "CORPORATETYPE":
                    case "CORRECTEDINVERSION":
                    case "CREATORORMODIFIER":
                    case "CUSTOMER":
                    case "DELIVERABLE":
                    case "FIXEDINPHASE":
                    case "FOUNDINPHASE":
                    case "KERNEL":
                    case "KEYWORDS":
                    case "MODULENAME":
                    case "COMPONENT":
                    case "OS":
                    case "PRIORITY":
                    case "PRODUCTVERSION":
                    case "REPORTEDBY":
                    case "REPORTEDINVERSION":
                    case "ASSIGNTONAME":
                    case "ROOTCAUSE":
                    case "SEVERITY":
                    case "SHOWTOCUSTOMER":
                    case "PHASE":
                    case "STATUS":
                    case "SUBTYPE":
                    case "TYPE":
                    case "SCRUMRELEASE":
                    case "SCRUMITERATION":
                    case "SCRUMUSERSTORY":
                        foreach (DataRow cmbRow in cmbTable.Rows)
                        {
                            ControlCombo controlCombo = new ControlCombo()
                            {
                                Key = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[0], "")),
                                Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[1], "")),
                            };

                            lstControlCombo.Add(controlCombo);
                        }
                        filterControl.lstControlCombo = lstControlCombo;
                        filterControl.Type = "C";
                        break;
                    case "CHANGEREQUESTNAME":
                    case "CUSTOMERISSUEID":
                    case "DELIVERABLEID":
                    case "DESCRIPTION":
                    case "IMPORTID":
                    case "ISSUECODE":
                    case "ISSUEID":
                    case "ITERATION":
                    case "PROJECTNAME":
                    case "RELEASE":
                    case "REPORTEDTIME":
                    case "ROOTCAUSEID":
                    case "SUMMARY":
                    case "USERSTORY":
                    case "DURATION":
                    case "STATUSCHANGETIME":
                        filterControl.Type = "T";
                        break;
                    case "CREATEDDATE":
                    case "DUEDATE":
                    case "CLOSEDDATE":
                    case "REPORTEDDATE":
                    case "STATUSCHANGEDATE":
                        filterControl.Type = "D";
                        break;
                }
                return filterControl;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


   
        
       
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]//Added By Dipali V On 27th July 2023 For Issue Performance
        //public List<FilterControl> GetAllFilterControls([FromBody]IssueParameters issueParameters)
        public object GetAllFilterControls([FromBody] IssueParameters issueParameters)

        {
            try
            {
                List<FilterControl> lstFilterControl = new List<FilterControl>();
                string[] arrControls = issueParameters.ControlName.Split(',');
                for (int i = 0; i < arrControls.Length; i++)
                {
                    FilterControl filterControl = new FilterControl();
                    List<ControlCombo> lstControlCombo = new List<ControlCombo>();
                    string cname = arrControls[i].ToUpper();
                    DataTable cmbTable = new DataTable();
                    switch (cname)
                    {
                        case "COMPLEXITY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Complexity " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "HARDWARE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_PM_ProjectHardware " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "CODEDBYNAME":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_Project_Resources " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "STATUS":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status_for_issuelist " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "CUSTOMER":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_SEL_Tbl_PM_Customer_forQueryBuilder " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "DELIVERABLE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_OtherSchedules_QueryBuilder " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "FIXEDINPHASE":
                        case "FOUNDINPHASE":
                        case "PHASE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "KERNEL":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Kernels " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "KEYWORDS":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Keywords " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "MODULENAME":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_PM_Module_Filter_And_Query " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "COMPONENT":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC USP_Whizible2_SEL_Tbl_PRD_ProductVersion_Component NULL, NULL, " + issueParameters.ProjectID + "," + issueParameters.intEmployeeID + ",'" + issueParameters.LoginType + "', 1", true, CommonController.connectionString);
                            break;
                        case "OS":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_OS " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "PRIORITY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Priorities " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "PRODUCTVERSION":
                        case "REPORTEDINVERSION":
                        case "CORRECTEDINVERSION":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Version " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "REPORTEDBY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_ReportedBy " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "ASSIGNTONAME":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_Project_Resources " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "ROOTCAUSE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_IB_Project_RootCause_QueryBuilder " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "SEVERITY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Severity " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "SHOWTOCUSTOMER":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_QueryBuilder_YesNo ", true, CommonController.connectionString);
                            break;

                        case "SUBTYPE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_SUB_TYPE " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "TYPE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_TYPE " + issueParameters.ProjectID + "," + issueParameters.RoleId, true, CommonController.connectionString);
                            break;
                        case "SCRUMRELEASE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumRelease_Release " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "SCRUMITERATION":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumIteration_IterationName " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        case "SCRUMUSERSTORY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumUserStory_UserStoryName " + issueParameters.ProjectID, true, CommonController.connectionString);
                            break;
                        default:
                            break;
                    }

                    switch (cname)
                    {
                        case "COMPLEXITY":
                        case "HARDWARE":
                        case "CODEDBYNAME":
                        case "CORPORATEPRIORITY":
                        case "CORPORATESEVERITY":
                        case "CORPORATESTATUS":
                        case "CORPORATESUBTYPE":
                        case "CORPORATETYPE":
                        case "CORRECTEDINVERSION":
                        case "CREATORORMODIFIER":
                        case "CUSTOMER":
                        case "DELIVERABLE":
                        case "FIXEDINPHASE":
                        case "FOUNDINPHASE":
                        case "KERNEL":
                        case "KEYWORDS":
                        case "MODULENAME":
                        case "COMPONENT":
                        case "OS":
                        case "PRIORITY":
                        case "PRODUCTVERSION":
                        case "REPORTEDBY":
                        case "REPORTEDINVERSION":
                        case "ASSIGNTONAME":
                        case "ROOTCAUSE":
                        case "SEVERITY":
                        case "SHOWTOCUSTOMER":
                        case "PHASE":
                        case "STATUS":
                        case "SUBTYPE":
                        case "TYPE":
                        case "SCRUMRELEASE":
                        case "SCRUMITERATION":
                        case "SCRUMUSERSTORY":
                            foreach (DataRow cmbRow in cmbTable.Rows)
                            {
                                ControlCombo controlCombo = new ControlCombo()
                                {
                                    Key = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[0], "")),
                                    Value = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[1], "")),
                                };

                                lstControlCombo.Add(controlCombo);
                            }
                            filterControl.lstControlCombo = lstControlCombo;
                            filterControl.Type = arrControls[i];
                            break;
                    }
                    lstFilterControl.Add(filterControl);
                }
                return lstFilterControl;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        #endregion

        #region "Private Methods"
        /// <summary>
        /// GetUserFriendlyFieldNames - Get user friendly field names for the specified field list
        /// </summary>
        /// <param name="fieldList"></param>
        /// <returns></returns>
        private string GetUserFriendlyFieldNames(string fieldList)
        {
            string userFriendlyName = "";
            IDataReader drFieldList;
            drFieldList = CommonFunctions.Data.GetDataReader("EXEC usp_Whizible2_Sel_tbl_IB_DataDictionary_UserFriendlyName '" + fieldList + "'", true, CommonController.connectionString);
            if (drFieldList.Read())
            {
                userFriendlyName = Convert.ToString(drFieldList["UserFriendlyName"]);
                CommonFunctions.Data.DisposeDataReader(ref drFieldList);
            }
            else
            {
                userFriendlyName = fieldList;
            }
            return userFriendlyName;
        }
        /// <summary>
        /// GetViewDetails - Get view details
        /// </summary>
        /// <param name="strSQL"></param>
        /// <param name="ViewID"></param>
        /// <returns></returns>
        
        [HttpGet]//Added By Dipali V On 27th July 2023 For Issue Performance
        private ViewDetails GetViewDetails(string strSQL,int ViewID)
        {
            ViewDetails viewDetails = new ViewDetails();
            IDataReader drDefaultView;
            drDefaultView = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (drDefaultView.Read())
            {
                viewDetails.ViewId = Convert.ToInt32(drDefaultView["ProjectViewID"]);
                viewDetails.ViewName = Convert.ToString(drDefaultView["ViewName"]);
                viewDetails.FieldList = Convert.ToString(drDefaultView["Fields"]);
                viewDetails.OrderBy = Convert.ToString(drDefaultView["SortBy"]);
                CommonFunctions.Data.DisposeDataReader(ref drDefaultView);
            }
            else
            {
                if (ViewID == 0)
                {
                    strSQL = "EXEC usp_Whizible2_sel_tbl_PM_CompanyInformation_PM";
                }
                else
                {
                    strSQL = "EXEC usp_Whizible2_sel_DefaultView_tbl_PM_CompanyInformation";
                }
                IDataReader drCorporateView;
                drCorporateView = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drCorporateView.Read())
                {
                    viewDetails.ViewName = "Corporate View";
                    viewDetails.FieldList = Convert.ToString(drCorporateView["IBDefaultView"]);
                    CommonFunctions.Data.DisposeDataReader(ref drCorporateView);
                }
            }
            return viewDetails;
        }
        /// <summary>
        /// GetQueryText - get the Query Text, which is appended to form the sql statement for getting issue list
        /// </summary>
        /// <param name="QueryID"></param>
        /// <returns></returns>
        private string GetQueryText(int QueryID)
        {
            string strQuery = "";
            string strSQL = "EXEC Usp_Whizible2_Sel_tbl_IB_Query " + QueryID.ToString();
            IDataReader drQuery;
            drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
            if (drQuery.Read())
            {
                strQuery += Convert.ToString(drQuery["QueryText"]);
                CommonFunctions.Data.DisposeDataReader(ref drQuery);
            }
            return strQuery;
        }
        /// <summary>
        /// FormatDateFields - format the date fields in dd-MMM-yyyy format
        /// </summary>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        private string FormatDateFields(string strSQL)
        {
            //Commented & Added By Dipali V On 3rd Sepp 2020 For Inline to SP Conversion
            //strSQL = strSQL.Replace("CreatedDate", "ISNULL(Convert(varchar, CreatedDate, 106),'') as CreatedDate");
            //strSQL = strSQL.Replace("Duedate", "ISNULL(Convert(varchar, Duedate, 106),'') as Duedate");
            //strSQL = strSQL.Replace("ClosedDate", "ISNULL(Convert(varchar, ClosedDate, 106),'') as ClosedDate");
            //strSQL = strSQL.Replace("ReportedDate", "ISNULL(Convert(varchar, ReportedDate, 106),'') as ReportedDate");
            ////strSQL = strSQL.Replace("LastUpdatedDate", "ISNULL(Convert(varchar, LastUpdatedDate, 106),'-') as LastUpdatedDate");
            //strSQL = strSQL.Replace("LastUpdatedDate", "ISNULL(Convert(varchar, LastUpdatedDate, 106),'') + ' ' + ISNULL(replace(replace(ltrim(Right(Convert(varchar, LastUpdatedDate, 100),7)), 'AM', ' AM'), 'PM', ' PM'),'') as LastUpdatedDate");
            strSQL = strSQL.Replace("CreatedDate", "ISNULL(Convert(varchar, CreatedDate, 106),'''') as CreatedDate");
            strSQL = strSQL.Replace("Duedate", "ISNULL(Convert(varchar, Duedate, 106),'''') as Duedate");
            strSQL = strSQL.Replace("ClosedDate", "ISNULL(Convert(varchar, ClosedDate, 106),'''') as ClosedDate");
            strSQL = strSQL.Replace("ReportedDate", "ISNULL(Convert(varchar, ReportedDate, 106),'''') as ReportedDate");
            //strSQL = strSQL.Replace("LastUpdatedDate", "ISNULL(Convert(varchar, LastUpdatedDate, 106),'-') as LastUpdatedDate");
            strSQL = strSQL.Replace("LastUpdatedDate", "ISNULL(Convert(varchar, LastUpdatedDate, 106),'''') + ' ' + ISNULL(replace(replace(ltrim(Right(Convert(varchar, LastUpdatedDate, 100),7)), 'AM', ' AM'), 'PM', ' PM'),'''') as LastUpdatedDate");
            //End of Commented & Added By Dipali V On 3rd Sepp 2020 For Inline to SP Conversion

            //Commented And Added By Usha Pandit On 22.09.2020 For crash due to single quote
            //strSQL = strSQL.Replace("CustomFieldDate1", "FORMAT(CustomFieldDate1,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate2", "FORMAT(CustomFieldDate2,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate3", "FORMAT(CustomFieldDate3,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate4", "FORMAT(CustomFieldDate4,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate5", "FORMAT(CustomFieldDate5,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate6", "FORMAT(CustomFieldDate6,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate7", "FORMAT(CustomFieldDate7,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate8", "FORMAT(CustomFieldDate8,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate9", "FORMAT(CustomFieldDate9,'dd MMM yyyy')");
            //strSQL = strSQL.Replace("CustomFieldDate10", "FORMAT(CustomFieldDate10,'dd MMM yyyy')");

            strSQL = strSQL.Replace("CustomFieldDate1", "FORMAT(CustomFieldDate1,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate2", "FORMAT(CustomFieldDate2,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate3", "FORMAT(CustomFieldDate3,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate4", "FORMAT(CustomFieldDate4,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate5", "FORMAT(CustomFieldDate5,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate6", "FORMAT(CustomFieldDate6,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate7", "FORMAT(CustomFieldDate7,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate8", "FORMAT(CustomFieldDate8,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate9", "FORMAT(CustomFieldDate9,''dd MMM yyyy'')");
            strSQL = strSQL.Replace("CustomFieldDate10", "FORMAT(CustomFieldDate10,''dd MMM yyyy'')");

            //End Of Added By Usha Pandit On 22.09.2020 For crash due to single quote

            return strSQL;
        }
        /// <summary>
        /// FormatDateCriteriaFields - format the date criteria fields to simple format of MM/dd/yyyy
        /// </summary>
        /// <param name="strQueryText"></param>
        /// <returns></returns>
        private string FormatDateCriteriaFields(string strQueryText)
        {
            strQueryText = strQueryText.Replace("CREATEDDATE", "Dateadd(d, 0, convert(varchar, CreatedDate, 101))");
            strQueryText = strQueryText.Replace("DUEDATE", "Dateadd(d, 0, convert(varchar, DueDate, 101))");
            strQueryText = strQueryText.Replace("CLOSEDDATE", "Dateadd(d, 0, convert(varchar, ClosedDate, 101))");
            strQueryText = strQueryText.Replace("REPORTEDDATE", "Dateadd(d, 0, convert(varchar, ReportedDate, 101))");
            return strQueryText;
        }
        private string FormatDateSortFields(string strSort)
        {
            strSort = strSort.Replace("CreatedDate", "v_tbl_IB_Issue.CreatedDate");
            strSort = strSort.Replace("DueDate", "v_tbl_IB_Issue.DueDate");
            strSort = strSort.Replace("ClosedDate", "v_tbl_IB_Issue.ClosedDate");
            strSort = strSort.Replace("ReportedDate", "v_tbl_IB_Issue.ReportedDate");
            strSort = strSort.Replace("ChangeRequest", "v_tbl_IB_Issue.ChangeRequestName");
            //strSort = strSort.Replace("AssignedTo", "v_tbl_IB_Issue.AssignedToName");
            strSort = strSort.Replace("ResponsiblePerson", "v_tbl_IB_Issue.AssignToName");
            //Commented And Added By Usha Pandit On 09.05.2021 For Sort issue
            //strSort = strSort == "" ? "IssueID Desc" : strSort;
            //strSort = strSort == "" ? "COALESCE(IssueID, 0) Desc" : strSort;
            strSort = strSort + " Desc";
            //End Of Added By Usha Pandit On 09.05.2021 For Sort issue
            return strSort;
        }
        /// <summary>
        /// FormatNullFields - set all null fields to ''
        /// </summary>
        /// <param name="strSQL"></param>
        /// <returns></returns>
        private string FormatNullFields(string strSQL)
        {

            //Added &  Commented By Dipali V On 3rd Sep 2020 For Inline Query into SP formate
            strSQL = strSQL.Replace("ChangeRequestName", "ISNULL(ChangeRequestName,'''') as ChangeRequestName");
            strSQL = strSQL.Replace("CodedByName", "ISNULL(CodedByName,'''') as CodedByName");
            strSQL = strSQL.Replace("Complexity", "ISNULL(Complexity,'''') as Complexity");
            strSQL = strSQL.Replace("CorrectedInVersion", "ISNULL(CorrectedInVersion,'''') as CorrectedInVersion");
            strSQL = strSQL.Replace(",Customer,", ",ISNULL(Customer,'''') as Customer,");
            strSQL = strSQL.Replace("Deliverable", "ISNULL(Deliverable,'''') as Deliverable");
            strSQL = strSQL.Replace("Description", "ISNULL(Description,'''') as Description");
            strSQL = strSQL.Replace("FixedInPhase", "ISNULL(FixedInPhase,'''') as FixedInPhase");
            strSQL = strSQL.Replace("FoundInPhase", "ISNULL(FoundInPhase,'''') as FoundInPhase");
            strSQL = strSQL.Replace("Hardware", "ISNULL(Hardware,'''') as Hardware");
            strSQL = strSQL.Replace("IssueCode", "ISNULL(IssueCode,'''') as IssueCode");
            strSQL = strSQL.Replace("Iteration", "ISNULL(Iteration,'''') as Iteration");
            strSQL = strSQL.Replace("Kernel", "ISNULL(Kernel,'''') as Kernel");
            strSQL = strSQL.Replace("Keywords", "ISNULL(Keywords,'''') as Keywords");
            strSQL = strSQL.Replace("ModuleName", "ISNULL(ModuleName,'''') as ModuleName");
            strSQL = strSQL.Replace("Component", "ISNULL(Component,'''') as Component");
            strSQL = strSQL.Replace(",OS", ",ISNULL(OS,'''') as OS");
            //Commented and added by Nilesh P on 27 Jul 2020 for issue ID : 25706 (This change is done for default priority of practice setting) 
            //strSQL = strSQL.Replace("Priority", "ISNULL(Priority,'') as Priority");
            strSQL = strSQL.Replace("Priority", "ISNULL(Priority, ISNULL((SELECT TOP(1) Priority FROM tbl_IB_Project_Priorities PR WHERE PR.Projectid = v_tbl_IB_Issue.ProjectID AND PR.DefaultPriority = 1), '''')) as Priority");
            //End of Commented added by Nilesh P on 27 Jul 2020 for issue ID : 25706 
            //Added & Commented By Dipali V On 7th Dec 2020 for Crash issue
            ////strSQL = strSQL.Replace("ProductVersion", "ISNULL(ProductVersion,'') as ProductVersion");
            strSQL = strSQL.Replace("ProductVersion", "ISNULL(ProductVersion,'''') as ProductVersion");
            //End of Added & Commented By Dipali V On 7th Dec 2020 for Crash issue
            strSQL = strSQL.Replace("ProjectName", "ISNULL(ProjectName,'''') as ProjectName");
            strSQL = strSQL.Replace("Release", "ISNULL(Release,'''') as Release");
            strSQL = strSQL.Replace("ReportedBy", "ISNULL(ReportedBy,'''') as ReportedBy");
            strSQL = strSQL.Replace("ReportedInVersion", "ISNULL(ReportedInVersion,'''') as ReportedInVersion");
            strSQL = strSQL.Replace("AssignToName", "ISNULL(AssignToName,'''') as AssignToName");
            strSQL = strSQL.Replace("RootCause", "ISNULL(RootCause,'''') as RootCause");
            strSQL = strSQL.Replace("Severity", "ISNULL(Severity,'''') as Severity");
            strSQL = strSQL.Replace(",Phase", ",ISNULL(Phase,'''') as Phase");
            strSQL = strSQL.Replace("Status", "ISNULL(Status,'''') as Status");
            strSQL = strSQL.Replace("SubType", "ISNULL(SubType,'''') as SubType");
            strSQL = strSQL.Replace("Summary", "ISNULL(Summary,'''') as Summary");
            strSQL = strSQL.Replace(",Type", ",ISNULL(Type,'''') as Type");
            strSQL = strSQL.Replace("UserStory", "ISNULL(UserStory,'''') as UserStory");
            strSQL = strSQL.Replace("CustomerIssueID", "ISNULL(CustomerIssueID,'''') as CustomerIssueID");
            strSQL = strSQL.Replace("ImportID", "ISNULL(ImportID,'''') as ImportID");



            //strSQL = strSQL.Replace("ChangeRequestName", "ISNULL(ChangeRequestName,'') as ChangeRequestName");
            //strSQL = strSQL.Replace("CodedByName", "ISNULL(CodedByName,'') as CodedByName");
            //strSQL = strSQL.Replace("Complexity", "ISNULL(Complexity,'') as Complexity");
            //strSQL = strSQL.Replace("CorrectedInVersion", "ISNULL(CorrectedInVersion,'') as CorrectedInVersion");
            //strSQL = strSQL.Replace(",Customer,", ",ISNULL(Customer,'') as Customer,");
            //strSQL = strSQL.Replace("Deliverable", "ISNULL(Deliverable,'') as Deliverable");
            //strSQL = strSQL.Replace("Description", "ISNULL(Description,'') as Description");
            //strSQL = strSQL.Replace("FixedInPhase", "ISNULL(FixedInPhase,'') as FixedInPhase");
            //strSQL = strSQL.Replace("FoundInPhase", "ISNULL(FoundInPhase,'') as FoundInPhase");
            //strSQL = strSQL.Replace("Hardware", "ISNULL(Hardware,'') as Hardware");
            //strSQL = strSQL.Replace("IssueCode", "ISNULL(IssueCode,'') as IssueCode");
            //strSQL = strSQL.Replace("Iteration", "ISNULL(Iteration,'') as Iteration");
            //strSQL = strSQL.Replace("Kernel", "ISNULL(Kernel,'') as Kernel");
            //strSQL = strSQL.Replace("Keywords", "ISNULL(Keywords,'') as Keywords");
            //strSQL = strSQL.Replace("ModuleName", "ISNULL(ModuleName,'') as ModuleName");
            //strSQL = strSQL.Replace("Component", "ISNULL(Component,'') as Component");
            //strSQL = strSQL.Replace(",OS", ",ISNULL(OS,'') as OS");
            ////Commented and added by Nilesh P on 27 Jul 2020 for issue ID : 25706 (This change is done for default priority of practice setting) 
            ////strSQL = strSQL.Replace("Priority", "ISNULL(Priority,'') as Priority");
            //strSQL = strSQL.Replace("Priority", "ISNULL(Priority, ISNULL((SELECT TOP(1) Priority FROM tbl_IB_Project_Priorities PR WHERE PR.Projectid = v_tbl_IB_Issue.ProjectID AND PR.DefaultPriority = 1), '')) as Priority");
            ////End of Commented added by Nilesh P on 27 Jul 2020 for issue ID : 25706 
            //strSQL = strSQL.Replace("ProductVersion", "ISNULL(ProductVersion,'') as ProductVersion");
            //strSQL = strSQL.Replace("ProjectName", "ISNULL(ProjectName,'') as ProjectName");
            //strSQL = strSQL.Replace("Release", "ISNULL(Release,'') as Release");
            //strSQL = strSQL.Replace("ReportedBy", "ISNULL(ReportedBy,'') as ReportedBy");
            //strSQL = strSQL.Replace("ReportedInVersion", "ISNULL(ReportedInVersion,'') as ReportedInVersion");
            //strSQL = strSQL.Replace("AssignToName", "ISNULL(AssignToName,'') as AssignToName");
            //strSQL = strSQL.Replace("RootCause", "ISNULL(RootCause,'') as RootCause");
            //strSQL = strSQL.Replace("Severity", "ISNULL(Severity,'') as Severity");
            //strSQL = strSQL.Replace(",Phase", ",ISNULL(Phase,'') as Phase");
            //strSQL = strSQL.Replace("Status", "ISNULL(Status,'') as Status");
            //strSQL = strSQL.Replace("SubType", "ISNULL(SubType,'') as SubType");
            //strSQL = strSQL.Replace("Summary", "ISNULL(Summary,'') as Summary");
            //strSQL = strSQL.Replace(",Type", ",ISNULL(Type,'') as Type");
            //strSQL = strSQL.Replace("UserStory", "ISNULL(UserStory,'') as UserStory");
            //strSQL = strSQL.Replace("CustomerIssueID", "ISNULL(CustomerIssueID,'') as CustomerIssueID");
            //strSQL = strSQL.Replace("ImportID", "ISNULL(ImportID,'') as ImportID");
            //End of Commented By Dipali V On 3rd Sep 2020 For Inline Query into SP formate

            return strSQL;
        }
        /// <summary>
        /// GetCommaSeparatedTypes - get comma separated isssue types for specified project and role
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <param name="RoleId"></param>
        /// <returns></returns>
        private string GetCommaSeparatedTypes(int ProjectId, int RoleId)
        {
            string strtypes = "";
            IDataReader drTypeList;
            drTypeList = CommonFunctions.Data.GetDataReader("EXEC usp_Whizible2_sel_tbl_ib_typerolesecurity_GetRecordSet " + ProjectId + "," + RoleId, true, CommonController.connectionString);
            while (drTypeList.Read())
            {
                //Commented And Added By Usha Pandit On 12.06.2020 For escaping quotes in string
                //strtypes = strtypes + "'" + Convert.ToString(drTypeList["TypeName"]) + "',";
                //added by dipali v on 3rd sep 2020 for inline to Sp conversion
                //strtypes = strtypes + "'" + Convert.ToString(drTypeList["TypeName"]).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',";
                strtypes = strtypes + "''" + Convert.ToString(drTypeList["TypeName"]).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'',";
                //end added by dipali v on 3rd sep 2020 for inline to Sp conversion
                //End Of Added By Usha Pandit On 12.06.2020 For escaping quotes in string
            }
            CommonFunctions.Data.DisposeDataReader(ref drTypeList);
            if (strtypes.Length > 0)
            {
                strtypes = strtypes.TrimEnd(',');
            }
            return strtypes;
        }
        /// <summary>
        /// GenerateCriteria - Generate FROM and WHERE criteria for getting Issue Data
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        private string GenerateCriteria(IssueParameters issueParameters)
        {
            string strSQLMyIB = "";
            string strQueryText = "";
            string strSQL = "";
            string IsContainSinglequote = "0";
            strSQL += " FROM v_tbl_IB_Issue ";
            strSQL += " LEFT JOIN d_tbl_PM_FlagForTracking AS tbl_PM_FlagForTracking";
            //Commented & Added By Dipali V on 7th Dec 2020 For Resective Person Data should list Out
            //Commented And Added By Usha Pandit On 24.09.2020 to remove employeeid AND condition while fetching flag details
            strSQL += " ON v_tbl_IB_Issue.IssueID = tbl_PM_FlagForTracking.ContextID AND ContextType = ''IB''";
            //Added By Dipali V On 31st March 2021 For Customer login issues list should display
            if (issueParameters.LoginType == "E")
            {
                strSQL += "AND tbl_PM_FlagForTracking.EmployeeID = " + issueParameters.intEmployeeID.ToString();
            }
            else {

                strSQL += "AND tbl_PM_FlagForTracking.EmployeeID = " + issueParameters.intEmployeeID.ToString();
            }
            
            //End of Added By Dipali V On 31st March 2021 For Customer login issues list should display
            
            //strSQL += " ON v_tbl_IB_Issue.IssueID = tbl_PM_FlagForTracking.ContextID AND ContextType = ''IB'' ";
            //End Of Added By Usha Pandit On 24.09.2020 to remove employeeid AND condition while fetching flag details
            //End of Commented & Added By Dipali V on 7th Dec 2020 For Resective Person Data should list Out
            strSQL += " WHERE 1 = 1";
            if (issueParameters.LoginType == "C")
            {
                strSQL += " AND ShowToCustomer = 1 ";
            }


            strSQL += " AND v_tbl_IB_Issue.ProjectID IN(" + issueParameters.ProjectID + ")  ";


            string strTypes = GetCommaSeparatedTypes(issueParameters.ProjectID, issueParameters.RoleId);
            if (strTypes != "")
            {
                strSQL += "AND Type in (" + strTypes + ")";
            }
            if (issueParameters.LoginType == "E")
            {
                if (issueParameters.DisplayMode == "M")
                {
                    strSQLMyIB = " AND (AssignToName=''" + CommonFunctions.General.BuildQueryString(issueParameters.UserName);
                    strSQLMyIB += "'' OR IssueID IN (Select OtherTaskID From Tbl_PM_ProjectTasks where IsActive=1 AND WhichTask =''B'' AND EmployeeID=";
                    strSQLMyIB += issueParameters.intEmployeeID.ToString() + " AND ProjectID = " + issueParameters.ProjectID + ")) ";
                }
                else if (issueParameters.DisplayMode == "S")
                {
                    strSQLMyIB = " AND (ReportedBy =''" + CommonFunctions.General.BuildQueryString(issueParameters.UserName);
                    strSQLMyIB += "'') ";
                }
            }
            if (issueParameters.DisplayMode == "F")
            {
                strSQL += " AND IssueID IN (SELECT ContextID FROM tbl_PM_FlagForTracking WHERE ProjectID = v_tbl_IB_Issue.ProjectID ";
                strSQL += " AND ContextID = v_tbl_IB_Issue.IssueID AND tbl_PM_FlagForTracking.ContextType = ''IB'' ";
                strSQL += " AND tbl_PM_FlagForTracking.EmployeeID = " + issueParameters.intEmployeeID + ")";
            }
            if (issueParameters.QueryID > 0)
            {
                strQueryText = " AND (" + GetQueryText(issueParameters.QueryID);
                strQueryText = FormatDateCriteriaFields(strQueryText);
                strQueryText += ") ";
            }
            if (issueParameters.QueryText.Trim() != "")
            {
                IsContainSinglequote = "1";
                strQueryText = " AND (" + issueParameters.QueryText.Replace("''", "''");
                strQueryText = FormatDateCriteriaFields(strQueryText);
                strQueryText += ") ";
            }
            if (issueParameters.SearchText.Trim() != "")
            {
                IsContainSinglequote = "1";  //Added By Reshma Chavan on 2nd Nov 2021 getting Crash on Clear All filter
                if (issueParameters.SearchText.IndexOf("Discussion") > -1)
                {
                    strQueryText += " AND (" + issueParameters.SearchText.Replace("Discussion", "IssueID IN (Select IssueID from tbl_IB_Discussion WHERE Comments ");// + ")) ";
                    if (issueParameters.LoginType == "C")
                    {
                        strQueryText += " AND tbl_IB_Discussion.ShowToCustomer = 1";
                    }
                    strQueryText += "))";
                }
                else
                {
                    strQueryText += " AND (" + issueParameters.SearchText + ") ";
                }
            }

            strSQL += strSQLMyIB;
            if (IsContainSinglequote == "1") {
                strSQL += strQueryText;
            }
            else {
                strSQL += strQueryText.Replace("'", "''");//Added By Dipali V On 4th Sep 2020 Crash Issue
            }

            //Added by imran 25-10-2021
            if (issueParameters.FilterQuery == "" || issueParameters.FilterQuery == null)
            { }
            else
            {
                strSQL += " And " + issueParameters.FilterQuery.Replace("`", "''");
            }
            //End by imran 25-10-2021   

            return strSQL;
        }

        #endregion
        /// <summary>
        /// GetTrackingDetails - to get Tracking Flag Details
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        /// Added by Swapnagandha K.
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<Tracking> GetTrackingDetails([FromBody]IssueParameters issueParameters)
        public object GetTrackingDetails([FromBody] IssueParameters issueParameters)

        {
            try
            {
                List<Tracking> lstTracking = new List<Tracking>();
                DataTable OpTable;
                OpTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_TrackingDtls_Edit " + issueParameters.ContextID + ", 'IB', " + issueParameters.intEmployeeID + "", true, CommonController.connectionString);

                foreach (DataRow opRow in OpTable.Rows)
                {
                    Tracking Tracking = new Tracking()
                    {
                        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["UniqueID"], "")),
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["EmployeeID"], "")),
                        ContextType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ContextType"], "")),
                        ContextID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ContextID"], "")),
                        DueDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["DueDate"], "")),
                        FlagTo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["FlagTo"], "")),
                        IsComplete = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["IsComplete"], "")),

                    };
                    lstTracking.Add(Tracking);
                }
                return lstTracking;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        /// SaveView - Save the view
        /// </summary>
        /// <param name="issueParameters"></param>
        /// <returns></returns>
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveTrackingDetails([FromBody]IssueParameters issueParameters)
        {
            try
            {
                DateTime dtDuedate = Convert.ToDateTime(issueParameters.DueDate);
                string isComplete = "0";
                isComplete = issueParameters.IsComplete;
                if (dtDuedate < DateTime.Now.Date)
                {
                    isComplete = "1";
                }
                ////string strSQL = "Exec usp_Whizible2_ins_TrackingDtls " + issueParameters.intEmployeeID +",'IB',"+ issueParameters.IssueID +","+ issueParameters.ProjectID +",'"+ issueParameters.FlagTo +"','"+ issueParameters.DueDate +"',"+issueParameters.IsComplete+"";
                string strSQL = "Exec usp_Whizible2_ins_TrackingDtls " + issueParameters.intEmployeeID + ",'IB'," + issueParameters.IssueID + "," + issueParameters.ProjectID + ",'" + issueParameters.FlagTo + "','" + issueParameters.DueDate + "'," + isComplete + "";

                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Success";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ClearTrackingDetails([FromBody]IssueParameters issueParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_del_TrackingDtls " + issueParameters.UniqueID;
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Success";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get the Start Date and End Date for Particular Project
        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        public object GetProjectStartDateEndDate([FromBody]int ProjectID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_StartDate_EndDate_tbl_PM_project " + ProjectID;

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
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
        public  string CreatedDate { get; set; }
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
    public class issueDatawithQuery
    {
        public DataTable issuedata { get; set; }
        public string strselect { get; set; }
    }
}
