using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

using WhizibleAPI.Models.Issue;

namespace WhizibleAPI.Controllers
{
    public class IB_BulkUpdateController : ApiController
    {
        [HttpPost]
        public object GetPKToken([FromBody] string Parameters)
        {
            try
            {
                string PKToken = CommonFunctions.Security.Token.GetToken(Parameters);

                return PKToken;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////Get MaximumItems to show
        //[Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetMaximumItemsToShowInList([FromBody]Parameter Parameters)
        {
            try
            {
                int StrSql;
                StrSql = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Sel_MaxItemToShowInList ", true, CommonController.connectionString));
                return StrSql;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object ValidateDate([FromBody]GetSelectedQuery Parameters)
        {
            try
            {

                string Strup = "Exec usp_Whizible2_Validate_Project_StartendDate " + Parameters.ProjectId + ',' + "'" + Parameters.ReportedDate + "'";
                string StrSql = Convert.ToString(CommonFunctions.Data.GetDataScalar(Strup, true, CommonController.connectionString));
                return StrSql;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<GetSelectedQuery> GetProjectID([FromBody]Parameter Parameters)
        public object GetProjectID([FromBody] Parameter Parameters)

        {
            try
            {
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_Query Null," + Parameters.ProjectId + ",0,''," + HttpUtility.UrlDecode(Parameters.LoginType) + ",'A'";

                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                List<GetSelectedQuery> IssueLists = new List<GetSelectedQuery>();


                foreach (DataRow queryList in taskListTable1.Rows)
                {
                    GetSelectedQuery Query = new GetSelectedQuery()
                    {
                        QueryID = queryList["QueryID"].ToString(),
                        QueryName = queryList["QueryName"].ToString(),


                    };
                    IssueLists.Add(Query);

                }
                return IssueLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //public List<GetSelectedQuery> GetProjectIssueList([FromBody]Parameter Parameters)
        public object GetProjectIssueList([FromBody] Parameter Parameters)
        {
            try
            {
                //string strWhereClause = "SELECT IssueID,Summary,Description,Type,SubType,Status,Priority,Severity FROM v_tbl_IB_Issue where 1=1 And " + Parameters.QueryText + "And ProjectID="+  Parameters.ProjectId;

                List<GetSelectedQuery> IssueLists = new List<GetSelectedQuery>();
                string strWhereClause = "usp_Whizible2_Sel_tbl_IB_Issue_ByProject " + Parameters.ProjectId;


                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strWhereClause, true, CommonController.connectionString);

                foreach (DataRow issuelistRow in taskListTable1.Rows)
                {
                    GetSelectedQuery issuelist = new GetSelectedQuery()
                    {
                        IssueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(issuelistRow["IssueID"], "0")),
                        Summary = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Summary"], "0")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Description"], "0")),
                        Type = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Type"], "0")),
                        Subtype = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Subtype"], "0")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Status"], "0")),
                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Priority"], "0")),
                        Severity = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Severity"], "0"))


                    };

                    IssueLists.Add(issuelist);
                }

                return IssueLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<GetSelectedQuery> PlotIssueList([FromBody]Parameter Parameters)
        public object PlotIssueList([FromBody] Parameter Parameters)

        {
            try
            {
                //string strWhereClause = "SELECT IssueID,Summary,Description,Type,SubType,Status,Priority,Severity FROM v_tbl_IB_Issue where 1=1 And " + Parameters.QueryText + "And ProjectID="+  Parameters.ProjectId;

                List<GetSelectedQuery> IssueLists = new List<GetSelectedQuery>();
                string strWhereClause = "usp_Whizible2_Sel_tbl_IB_Issue_ByQuery " + HttpUtility.UrlDecode(Convert.ToString(Parameters.QueryID)) + ',' + HttpUtility.UrlDecode(Convert.ToString(Parameters.ProjectId));


                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strWhereClause, true, CommonController.connectionString);

                foreach (DataRow issuelistRow in taskListTable1.Rows)
                {
                    GetSelectedQuery issuelist = new GetSelectedQuery()
                    {
                        IssueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(issuelistRow["IssueID"], "0")),
                        Summary = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Summary"], "0")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Description"], "0")),
                        Type = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Type"], "0")),
                        Subtype = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Subtype"], "0")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Status"], "0")),
                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Priority"], "0")),
                        Severity = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Severity"], "0"))


                    };

                    IssueLists.Add(issuelist);
                }

                return IssueLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }


        }

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetLayoutProjectFlag([FromBody]CommonProperty commonProperty)
        {
            try
            {
                int MaxRow = 0, MaxColoumn = 0, layoutid = 0;

                string strSQL = "Usp_Whizible2_Sel_ProjectTypeInfo " + commonProperty.ProjectId;

                object Project_Flag = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                strSQL = "usp_sel_Whizible2_tbl_PM_Project_IsIssueSLAApplicable " + commonProperty.ProjectId;
                object IsIssueSLAApplicable = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "false"));

                string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + commonProperty.ProjectId + "," + commonProperty.RoleId + ", ''";

                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in taskListTable1.Rows)
                {
                    layoutid = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LayoutID"], "0"));
                    MaxRow = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxRows"], "0"));
                    MaxColoumn = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxCols"], "0"));

                }
                object[] GetValue = { Project_Flag, IsIssueSLAApplicable, layoutid, MaxRow, MaxColoumn };

                return GetValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        int LayOutId;
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<LayoutControl_BulkUpdate> IssueControlLists([FromBody]IssueLayOutcontrol_BulkUpdate layOutcontrol)
        public object IssueControlLists([FromBody] IssueLayOutcontrol_BulkUpdate layOutcontrol)


        {
            try
            {
                List<LayoutControl_BulkUpdate> lstLayoutControl = new List<LayoutControl_BulkUpdate>();



                object[] inputstring = { layOutcontrol.ProjectId, layOutcontrol.RoleId.ToString() };


                LayoutControl_BulkUpdate layoutControl1 = new LayoutControl_BulkUpdate();


                string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + layOutcontrol.ProjectId + "," + layOutcontrol.RoleId + ", ''";

                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in taskListTable1.Rows)
                {

                    LayOutId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LayoutID"], "0"));


                }



                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_IssueEntry_Layout_Details NULL," + LayOutId + ",Null,Null,'Edit'";


                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                foreach (DataRow sdr in taskListTable.Rows)
                {
                    LayoutControl_BulkUpdate layoutControl = new LayoutControl_BulkUpdate()
                    {
                        LayOutSrNo = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LayoutSrNo"].ToString(), "0")),
                        LayOutID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LayOutID"].ToString(), "0")),
                        ColumnNo = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                        RowNo = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                        ReadOnly = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["ReadOnly"].ToString(), "0")),
                        UniqueId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueId"].ToString(), "0")),
                        AddMode = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["ShowInAddMode"].ToString(), "0")),
                        ReadOnlyAddMode = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["ReadOnlyInAddMode"].ToString(), "0")),
                        EditMode = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["ShowInEditMode"].ToString(), "0")),
                        ReadonlyEditMode = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["ReadonlyInEditMode"].ToString(), "0")),
                        Mandatory = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Mandatory"].ToString(), "0")),
                        UserFriendlyName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserFriendlyName"].ToString(), "")),

                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
                        TableFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["TableFieldName"].ToString(), "")),
                        ControlWidth = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ControlWidth"].ToString(), "0")),
                        Active = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Active"].ToString(), "0")),

                    };
                    lstLayoutControl.Add(layoutControl);



                }


                return lstLayoutControl;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Get Default Sub Type and Status List DropDown Combo
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<IssueLayOutcontrol_BulkUpdate> DefaultSubTypeAndStatus([FromBody]IssueLayOutcontrol_BulkUpdate Parameters)
        public object DefaultSubTypeAndStatus([FromBody] IssueLayOutcontrol_BulkUpdate Parameters)

        {
            try
            {
                List<IssueLayOutcontrol_BulkUpdate> ListsSubType = new List<IssueLayOutcontrol_BulkUpdate>();

                DataTable SubTypeTableList = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'S'," + Parameters.ProjectId + ",'" + Parameters.Type + "'", true, CommonController.connectionString);

                foreach (DataRow subtypelistRow in SubTypeTableList.Rows)
                {
                    IssueLayOutcontrol_BulkUpdate listSubType = new IssueLayOutcontrol_BulkUpdate()
                    {
                        SubTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(subtypelistRow["SubTypeID"], "0")),
                        SubType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subtypelistRow["SubType"], "0")),

                    };

                    ListsSubType.Add(listSubType);

                }

                DataTable StatusListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'ST'," + Parameters.ProjectId + ",'" + Parameters.Type + "'", true, CommonController.connectionString);

                foreach (DataRow statuslistRow in StatusListTable.Rows)
                {
                    IssueLayOutcontrol_BulkUpdate ListStatus = new IssueLayOutcontrol_BulkUpdate()
                    {
                        StatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(statuslistRow["ProjectTypeStatusID"], "0")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(statuslistRow["Status"], "0")),

                    };

                    ListsSubType.Add(ListStatus);

                }
                return ListsSubType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<IssueLayOutcontrol_BulkUpdate> GetSubType([FromBody]IssueLayOutcontrol_BulkUpdate Parameters)
        public object GetSubType([FromBody] IssueLayOutcontrol_BulkUpdate Parameters)


        {
            try
            {
                List<IssueLayOutcontrol_BulkUpdate> ListSubType = new List<IssueLayOutcontrol_BulkUpdate>();

                object[] inputstring = { Parameters.ProjectId.ToString(), Parameters.Type };


                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + Parameters.ProjectId + ", 'S','" + Parameters.Type + "'";

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    IssueLayOutcontrol_BulkUpdate subtype = new IssueLayOutcontrol_BulkUpdate()
                    {
                        FieldID = sdr["FieldID"].ToString(),
                        FieldName = sdr["FieldName"].ToString(),
                        Type = sdr["Type"].ToString(),


                    };
                    ListSubType.Add(subtype);

                }




                return ListSubType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        // public List<IssueLayOutcontrol_BulkUpdate> GetStatus([FromBody]IssueLayOutcontrol_BulkUpdate Parameters)
        public object GetStatus([FromBody] IssueLayOutcontrol_BulkUpdate Parameters)


        {
            try
            {
                List<IssueLayOutcontrol_BulkUpdate> ListSubType = new List<IssueLayOutcontrol_BulkUpdate>();



                object[] inputstring = { Parameters.ProjectId.ToString(), Parameters.Type, Parameters.RoleId.ToString() };

                //Added By Swapnagandha K. On 18-Oct-2019 To Add Status Parameter
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + Parameters.ProjectId + ",'" + Parameters.Type + "',NULL, Null" + "," + Parameters.RoleId + ",'" + Parameters.Status + "'";
                //End Added By Swapnagandha K. On 18-Oct-2019 To Add Status Parameter
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    IssueLayOutcontrol_BulkUpdate subtype = new IssueLayOutcontrol_BulkUpdate()
                    {
                        FieldID = sdr["FieldID"].ToString(),
                        FieldName = sdr["FieldName"].ToString(),
                        Type = sdr["Type"].ToString(),


                    };
                    ListSubType.Add(subtype);

                }

                return ListSubType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Get Iteration Name List DropDown Combo
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<IssueLayOutcontrol_BulkUpdate> GetIteration([FromBody]IssueLayOutcontrol_BulkUpdate Parameters)
        public object GetIteration([FromBody] IssueLayOutcontrol_BulkUpdate Parameters)

        {
            try
            {
                List<IssueLayOutcontrol_BulkUpdate> IterationLists = new List<IssueLayOutcontrol_BulkUpdate>();
                string StrSql = "usp_Whizible2_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " + Parameters.ReleaseID;
                DataTable IterationListTable = CommonFunctions.Data.GetDataTable(StrSql, true, CommonController.connectionString);

                {

                    foreach (DataRow iterationlistRow in IterationListTable.Rows)
                    {
                        IssueLayOutcontrol_BulkUpdate iterationlist = new IssueLayOutcontrol_BulkUpdate()
                        {
                            IterationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["IterationID"], "0")),
                            IterationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["IterationName"], "0"))

                        };
                        IterationLists.Add(iterationlist);
                    }
                }

                return IterationLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<IssueLayOutcontrol_BulkUpdate> GetUserStory([FromBody] IssueLayOutcontrol_BulkUpdate Parameters)

        public object GetUserStory([FromBody]IssueLayOutcontrol_BulkUpdate Parameters)
        {
            try
            {
                List<IssueLayOutcontrol_BulkUpdate> UserStoryLists = new List<IssueLayOutcontrol_BulkUpdate>();
                string StrSql = "usp_Whizible2_sel_tbl_PM_ScrumUserStory_IterationWise_UserStoryID_UserStoryName " + Parameters.IterationID;
                DataTable IterationListTable = CommonFunctions.Data.GetDataTable(StrSql, true, CommonController.connectionString);

                {

                    foreach (DataRow iterationlistRow in IterationListTable.Rows)
                    {
                        IssueLayOutcontrol_BulkUpdate iterationlist = new IssueLayOutcontrol_BulkUpdate()
                        {
                            UserStoryID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["UserStoryID"], "0")),
                            UserStoryName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["UserStoryName"], "0"))

                        };
                        UserStoryLists.Add(iterationlist);
                    }
                }

                return UserStoryLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        List<int> CustomfileId1 = new List<int>();
        //int CustomFieldID;
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<CustomFiledPloat_BulkUpdate> PloatCustomFiled([FromBody]CustomFiledPloat_BulkUpdate customFiled)
        public object PloatCustomFiled([FromBody] CustomFiledPloat_BulkUpdate customFiled)

        {
            try
            {
                List<CustomFiledPloat_BulkUpdate> customFiledPloat = new List<CustomFiledPloat_BulkUpdate>();
                // List<CustomFiledPloat> CustomFieldIDs = new List<CustomFiledPloat>();

                //DateTime ExpectedStartDate, ExpectedEndDate;
                //Added by Swapnagandha K. On 07 nov 2019 For Issue -Null was passing instead of EmployeeID 
                // string strSQLForCustom = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + customFiled.commonProperty.ProjectId + "," + customFiled.commonProperty.RoleId + ",NULL ,'" + customFiled.commonProperty.LoginType + "'";
                
                //Added By Riddhesh Patil on 31st March 2023
                //string strSQLForCustom = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + customFiled.commonProperty.ProjectId + "," + customFiled.commonProperty.RoleId + ", " + customFiled.commonProperty.EmployeeId + " ,'" + customFiled.commonProperty.LoginType + "'";
                string strSQLForCustom = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + customFiled.ProjectId + "," + customFiled.RoleId + ", " + customFiled.EmployeeId + " ,'" + customFiled.LoginType + "'";
                //End of Added By Riddhesh Patil on 31st March 2023
                //Added by Swapnagandha K. On 07 nov 2019 For Issue -Null was passing instead of EmployeeID 
                IDataReader Isdr;
                Isdr = CommonFunctions.Data.GetDataReader(strSQLForCustom, true, CommonController.connectionString);

                while (Isdr.Read())
                {
                    CustomfileId1.Add(Convert.ToInt32(Isdr["CustomFieldID"]));

                }
                //Added By Riddhesh Patil on 31st March 2023
                //string strQuery = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.commonProperty.ProjectId + ",NULL,1,NULL";
                string strQuery = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.ProjectId + ",NULL,1,NULL";
                //End of Added By Riddhesh Patil on 31st March 2023
                // "'" + customFiled.Type + "'

                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    CustomFiledPloat_BulkUpdate layoutControl = new CustomFiledPloat_BulkUpdate()
                    {

                        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                        UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserGivenCaption"].ToString(), "")),
                        ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationRules"].ToString(), "")),
                        DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")),
                        RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                        ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                        IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "")),
                        DefaultValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultValue"].ToString(), "")),
                        DefaultType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultType"].ToString(), "")),
                        MaxLength = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxLength"].ToString(), "")),
                        MinValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MinValue"].ToString(), "")),
                        MaxValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxValue"].ToString(), "")),
                        //Mandatory = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Mandatory"].ToString(), "0")),

                    };
                    customFiledPloat.Add(layoutControl);

                    if (CustomfileId1.Contains(layoutControl.UniqueID))
                    {
                        layoutControl.IsCustomFieldAssigned = "1";
                        continue;
                    }
                    else
                    {
                        // layoutControl.IsCustomFieldAssigned = "0";
                    }

                }

                return customFiledPloat;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        List<int> CustomfileId2 = new List<int>();
        //int CustomFieldID;
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<CustomFiledPloat_BulkUpdate> PloatExtendedCustomFileds([FromBody]CustomFiledPloat_BulkUpdate customFiled)
        public object PloatExtendedCustomFileds([FromBody] CustomFiledPloat_BulkUpdate customFiled)

        {
            try
            {

                List<CustomFiledPloat_BulkUpdate> cfp = new List<CustomFiledPloat_BulkUpdate>();
                List<CustomFiledPloat_BulkUpdate> CustomFieldIDs = new List<CustomFiledPloat_BulkUpdate>();

                //DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_sel_tbl_IB_RoleExtendedCustomFieldSecurity " + customFiled.commonProperty.ProjectId + "," + customFiled.commonProperty.RoleId + "," + customFiled.commonProperty.EmployeeId + ",'" + customFiled.commonProperty.LoginType + "'";

                IDataReader sdr1;
                sdr1 = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr1.Read())
                {
                    CustomfileId2.Add(Convert.ToInt32(sdr1["CustomFieldID"]));

                }


                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtendedCustomFields " + customFiled.commonProperty.ProjectId + ",NULL,1,NULL";
                //   strSQL += ProjectId;
                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    CustomFiledPloat_BulkUpdate layoutControl = new CustomFiledPloat_BulkUpdate()
                    {

                        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                        UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserGivenCaption"].ToString(), "")),
                        ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationRules"].ToString(), "")),
                        DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")),
                        RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                        ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                        IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "")),
                        DefaultValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultValue"].ToString(), "")),
                        DefaultType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultType"].ToString(), "")),

                        //IsCustomFieldAssigned = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),

                    };
                    cfp.Add(layoutControl);

                    if (CustomfileId2.Contains(layoutControl.UniqueID))
                    {
                        continue;
                    }
                    else
                    {
                        layoutControl.IsCustomFieldAssigned = "0";
                    }

                }




                return cfp;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<CustomFiledPloat_BulkUpdate> GetExtendedCustomFieldComboboxValues([FromBody]CustomFiledPloat_BulkUpdate customFiled)
        public object GetExtendedCustomFieldComboboxValues([FromBody] CustomFiledPloat_BulkUpdate customFiled)

        {
            try
            {
                List<CustomFiledPloat_BulkUpdate> cfp = new List<CustomFiledPloat_BulkUpdate>();



                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtendedCustomFields_Details " + "'" + customFiled.DatabaseFieldName + "'," + customFiled.commonProperty.ProjectId;
                //   strSQL += ProjectId;
                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    CustomFiledPloat_BulkUpdate layoutControl = new CustomFiledPloat_BulkUpdate()
                    {
                        FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldID"].ToString(), "")),
                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
                        //Commented And Added By Usha Pandit On 03.04.2020 For Blank field issue
                        //UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0").ToString() != "" ? CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0") : "0"),
                        //End Of Added By Usha Pandit On 03.04.2020 For Blank field issue

                    };
                    cfp.Add(layoutControl);

                }

                return cfp;
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
        public object GetValidationForCustomFields([FromBody]CustomFiledPloat_BulkUpdate customFiled)
        {
            try
            {
                string VALIDATION;
                string CustomFieldName;
                VALIDATION = Convert.ToString(customFiled.CustomValidation).Replace("[", "").Replace("]", "").Replace("\"", string.Empty).Trim();//.Replace(",", "").
                CustomFieldName = Convert.ToString(customFiled.CustomFieldName).Replace("'", "''").Trim();//.Replace(",", "").

                List<ValidationData_BulkUpdate> ValidationData = new List<ValidationData_BulkUpdate>();
                //Added & Commented By Dipali v On 2nd july For Validation for customfiled
                //string strsql = "Exec usp_Whizible2_sel_tbl_UI_Validation '" + customFiled.FieldID + "','" + customFiled.CustomFieldName + "','" + VALIDATION + "'";
                string strsql = "Exec usp_Whizible2_sel_tbl_UI_Validation '" + customFiled.FieldID + "','" + CustomFieldName + "','" + VALIDATION + "'";
                //End of Added & Commented By Dipali v On 2nd july For Validation for customfiled
                DataTable ValidationDataTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);

                if (VALIDATION.IndexOf("\n") != -1)
                {
                    VALIDATION = VALIDATION.Replace("\n", "").Trim();

                }



                if (VALIDATION.IndexOf("\r") != -1)
                {
                    VALIDATION = VALIDATION.Replace("\r", "").Trim();

                }
                VALIDATION = VALIDATION.Replace(" ", string.Empty).Trim();
                string[] Result = VALIDATION.Split(',');
                //Result = Result.Replace("\n", " ");
                foreach (string r in Result)
                {
                    foreach (DataRow sdr in ValidationDataTable.Rows)
                    {
                        ValidationData_BulkUpdate ValidationDataControl = new ValidationData_BulkUpdate()
                        {

                            ValidationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationID"].ToString(), "")),
                            ValidationMessage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationMessage"].ToString(), "")),
                            FieldName = Convert.ToString(customFiled.CustomFieldName),
                            FieldID = Convert.ToString(customFiled.FieldID)
                        };


                        if (Convert.ToString(ValidationDataControl.ValidationID) == Convert.ToString(r))
                        {
                            ValidationData.Add(ValidationDataControl);

                        }
                        else
                        {

                        }
                    }

                }

                return ValidationData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        List<CustomerClass_BulkUpdate> CustomerValues = new List<CustomerClass_BulkUpdate>();
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetCustomer([FromBody]int ProjectID)
        {
            try
            {
                {

                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details 'CustomFieldCombo2'," + ProjectID;

                    DataTable DepartmentData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in DepartmentData.Rows)
                    {
                        CustomerClass_BulkUpdate CustomerObj = new CustomerClass_BulkUpdate();

                        CustomerObj.CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["CustomerName"], ""));

                        CustomerValues.Add(CustomerObj);
                    }


                    return CustomerValues;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<CustomFiledPloat_BulkUpdate> GetComboboxCustomFiledValues([FromBody]CustomFiledPloat_BulkUpdate customFiled)
        public object GetComboboxCustomFiledValues([FromBody] CustomFiledPloat_BulkUpdate customFiled)

        {
            try
            {

                List<CustomFiledPloat_BulkUpdate> CustomField = new List<CustomFiledPloat_BulkUpdate>();



                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details '" + customFiled.DatabaseFieldName + "'," + customFiled.ProjectId;
                //   strSQL += ProjectId;
                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    CustomFiledPloat_BulkUpdate layoutControl = new CustomFiledPloat_BulkUpdate()
                    {
                        FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldID"].ToString(), "")),
                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
                        //Commented And Added By Usha Pandit On 03.04.2020 For Blank field issue
                        //UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0").ToString() != "" ? CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0") : "0"),
                        //End Of Added By Usha Pandit On 03.04.2020 For Blank field issue

                    };
                    CustomField.Add(layoutControl);

                }

                return CustomField;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Copy Issues from dropdown Selected Project to Selected Project from Issuelist
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        public object UpdateFields([FromBody] BulkUpdateProperty UpdatedField)
        {
            try
            {

                string strSQL;
                int result;


                strSQL = "EXEC usp_Whizible2_Update_V_tbl_IB_Issue '" + UpdatedField.IssueID + "'," + UpdatedField.ProjectId + ",'" + HttpUtility.UrlDecode(UpdatedField.UserName) + "'," + UpdatedField.RoleId + ", '" + HttpUtility.UrlDecode(UpdatedField.strUpdateSQL) + "'";


                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return Ok("Issues are Updated Successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetProjectlevelSetting([FromBody]int selectedProjectID)
        {
            try
            {
                string Strup = "Exec usp_sel_tbl_Whizible2_IB_ProjectSetting " + selectedProjectID;
                string StrSql = Convert.ToString(CommonFunctions.Data.GetDataScalar(Strup, true, CommonController.connectionString));
                return StrSql;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


    }
    public class Parameter
    {
        public String ProjectId { get; set; }
        public int QueryID { get; set; }
        public int EmployeeID { get; set; }
        public String PageNumber { get; set; }
        public String LoginType { get; set; }
        public String Mode { get; set; }
        public string QueryText { get; set; }
        public int FieldID { get; set; }
        public string FieldName { get; set; }
        public string Rules { get; set; }
    }
}

internal class CustomerClass_BulkUpdate
{
    public string CustomerName { get; internal set; }
}
internal class ValidationData_BulkUpdate
{
    public string ValidationID { get; internal set; }
    public string ValidationDescription { get; internal set; }
    public string ValidationMessage { get; internal set; }
    public string FieldID { get; internal set; }
    public string FieldName { get; internal set; }
    public string CreatedBy { get; internal set; }
    public string CreatedDate { get; internal set; }
    public int OrderNumber { get; internal set; }
    public int IsComparisonRule { get; internal set; }
}

