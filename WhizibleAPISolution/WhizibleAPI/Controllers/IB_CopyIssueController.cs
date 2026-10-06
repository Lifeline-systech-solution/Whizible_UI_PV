using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Web.Http;
using System.Web;
using WhizibleAPI.Models.Issue;
using System.Globalization;

namespace WhizibleAPI.Controllers
{
    public class IB_CopyIssueController : ApiController
    {
        string SpecialCharacters;
        string[] lstSpecialCharacters;
        bool result;
        //// constructor for initialize the  value   

        public IB_CopyIssueController()
        {
            SpecialCharacters = ConfigurationManager.AppSettings["SpecialCharactersList"];
            lstSpecialCharacters = Regex.Split(SpecialCharacters, ",");
        }

        //// Get Issue List by Project selected From DropDown
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        //public List<IssueList_Copy> GetIssueList([FromBody]Parameter issueParameters)
        public object GetIssueList([FromBody] Parameter issueParameters)

        {
            try
            {
                List<IssueList_Copy> IssueLists = new List<IssueList_Copy>();

                object[] inputstring = { issueParameters.intProjectID };
                bool result1 = ChkSpecialChar(inputstring);
                IssueList_Copy issuelist1 = new IssueList_Copy();
                if (result == true)
                {
                    issuelist1.ResultFlag = result1;
                    IssueLists.Add(issuelist1);
                }
                else
                {
                    DataTable IssueListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_IssueList_ByProject " + issueParameters.intProjectID + "", true, CommonController.connectionString);

                    foreach (DataRow issuelistRow in IssueListTable.Rows)
                    {
                        IssueList_Copy issuelist = new IssueList_Copy()
                        {
                            IntIssueId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(issuelistRow["IssueID"], "0")),
                            StrSummary = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Summary"], "0")),
                            StrDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Description"], "0")),
                            StrType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Type"], "0")),
                            StrSubType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["SubType"], "0")),
                            StrStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Status"], "0")),
                            StrPriority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Priority"], "0")),
                            StrSeverity = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(issuelistRow["Severity"], "0")),
                            ResultFlag = result1

                        };

                        IssueLists.Add(issuelist);
                    }
                }
                return IssueLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Get Issue List by Project selected From DropDown
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        public object GetIssueList1([FromBody]Parameter issueParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_IB_IssueList_ByProject " + issueParameters.intProjectID;

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Project name in dropdown on step 2
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<ProjectList_Copy> GetProjectName([FromBody]Parameter issueParameters)
        public object GetProjectName([FromBody] Parameter issueParameters)

        {
            try
            {
                List<ProjectList_Copy> ProjectLists = new List<ProjectList_Copy>();
                object[] inputstring = { issueParameters.intProjectID };
                bool result1 = ChkSpecialChar(inputstring);
                ProjectList_Copy projectlist1 = new ProjectList_Copy();
                if (result == true)
                {
                    projectlist1.ResultFlag = result1;
                    ProjectLists.Add(projectlist1);
                }
                else
                {
                    DataTable Projecttable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Get_ProjectNames " + issueParameters.intProjectID + "", true, CommonController.connectionString);
                    foreach (DataRow ProjectRow in Projecttable.Rows)
                    {
                        ProjectList_Copy ProFilter = new ProjectList_Copy()
                        {
                            ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ProjectRow["ProjectID"], "0")),
                            StrProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ProjectRow["ProjectName"], "")),
                            ResultFlag = result1
                        };
                        ProjectLists.Add(ProFilter);
                    }
                }
                return ProjectLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Max Items to show
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object CheckProjectOver([FromBody]Parameter issueParameters)
        {
            try
            {
                int strmsg;
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_sel_tbl_PM_Project_IsOver " + issueParameters.intProjectID + "", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////get Project start and end date
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> ProjectStartEndDates([FromBody] Parameter issueParameters)

        public object ProjectStartEndDates([FromBody]Parameter issueParameters)
        {
            try
            {
                DateTime dtStartDate, dtEndDate;
                List<string> lstprojectstartenddate = new List<string>();
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader("usp_Whizible2_Sel_tbl_PM_Project_GetStartendDate " + issueParameters.intProjectID + "", true, CommonController.connectionString);
                while (sdr.Read())
                {

                    dtStartDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedStartDate"].ToString(), ""));
                    dtEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedEndDate"].ToString(), ""));


                    lstprojectstartenddate.Add(dtStartDate.ToString("dd/MMM/yyyy"));
                    lstprojectstartenddate.Add(dtEndDate.ToString("dd/MMM/yyyy"));
                }
                return lstprojectstartenddate;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //validate Project start and end date
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object validateDates([FromBody]Parameter issueParameters)
        {
            try
            {

                string strmsg;
                strmsg = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Validate_Project_StartendDate " + issueParameters.intProjectID + ",'" + issueParameters.DtReportedDate + "'", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Max Items to show
        //Commented & Added By Dipali V On 31st March 2023 For Security
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        [HttpPost]
        //End of Commented & Added By Dipali V On 31st March 2023 For Security
        public object GetMaxItemsToShow([FromBody]Parameter issueParameters)
        {
            try
            {
                int strmsg;
                strmsg = Convert.ToInt32(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_Sel_MaxItemToShowInList ", true, CommonController.connectionString));
                return strmsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Responsible Person on Project level
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<ResponsiblePerson> GetResPerson([FromBody]int project)
        public object GetResPerson([FromBody] int project)

        {
            try
            {
                List<ResponsiblePerson> EmployeeLists = new List<ResponsiblePerson>();

                DataTable Employeelist = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_ResponsiblePersonForIssue " + project + "", true, CommonController.connectionString);

                foreach (DataRow ResList in Employeelist.Rows)
                {
                    ResponsiblePerson ResFilter = new ResponsiblePerson()
                    {
                        ResponsiblePersonID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(ResList["ResponsiblePersonForIssue"], "0")),
                        UserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(ResList["UserName"], ""))
                    };
                    EmployeeLists.Add(ResFilter);
                }

                return EmployeeLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Layout ID on selected Project 
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetIssueLayout([FromBody]Parameter issueParameters)
        {
            try
            {
                int MaxRow = 0, MaxColoumn = 0, layoutid = 0;
                string strSQL = "Usp_Whizible2_Sel_ProjectTypeInfo " + issueParameters.intProjectID;
                object Project_Flag = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                strSQL = "usp_sel_Whizible2_tbl_PM_Project_IsIssueSLAApplicable " + issueParameters.intProjectID;
                object IsIssueSLAApplicable = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "false"));

                string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + issueParameters.intProjectID + "," + issueParameters.intRoleID + ", ''";

                DataTable LayoutTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in LayoutTable.Rows)
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

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<CopyLayoutControl> GetControlLists([FromBody]Parameter issueParameters)
        public object GetControlLists([FromBody] Parameter issueParameters)

        {
            try
            {
                List<CopyLayoutControl> LayoutControlLists = new List<CopyLayoutControl>();

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_IssueEntry_Layout_Details NULL," + issueParameters.intLayOutID + ",Null,Null,'Add'";

                DataTable LayoutControlTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow sdr in LayoutControlTable.Rows)
                {
                    CopyLayoutControl layoutControl = new CopyLayoutControl()
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
                    LayoutControlLists.Add(layoutControl);
                }

                return LayoutControlLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        //Get Project Practices
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetPractises([FromBody]Parameter issueParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_tbl_pm_projectRevision_ProjectGroup " + issueParameters.intProjectID;
                object mstrselectedPractiseID = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                strSQL = "Exec usp_Whizible2_sel_tbl_pm_projectRevision_ProjectGroup " + issueParameters.intCurrentProjectID;
                object mstrcurrentPractiseID = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                object[] GetPractises = { mstrselectedPractiseID, mstrcurrentPractiseID };

                return GetPractises;
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
        //public List<SubTypeList> GetDefaultSubTypeAndStatus([FromBody]Parameter issueParameters)
        public object GetDefaultSubTypeAndStatus([FromBody] Parameter issueParameters)

        {
            try
            {
                List<SubTypeList> SubTypeLists = new List<SubTypeList>();

                DataTable SubTypeListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'S'," + issueParameters.intProjectID + ",'" + issueParameters.strType + "'", true, CommonController.connectionString);

                foreach (DataRow subtypelistRow in SubTypeListTable.Rows)
                {
                    SubTypeList subtypelist = new SubTypeList()
                    {
                        subTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(subtypelistRow["SubTypeID"], "0")),
                        StrSubType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subtypelistRow["SubType"], "0")),

                    };

                    SubTypeLists.Add(subtypelist);

                }

                DataTable StatusListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'ST'," + issueParameters.intProjectID + ",'" + issueParameters.strType + "'", true, CommonController.connectionString);

                foreach (DataRow statuslistRow in StatusListTable.Rows)
                {
                    SubTypeList statuslist = new SubTypeList()
                    {
                        TypeStatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(statuslistRow["ProjectTypeStatusID"], "0")),
                        StrStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(statuslistRow["Status"], "0")),

                    };

                    SubTypeLists.Add(statuslist);

                }
                return SubTypeLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Sub Type List DropDown Combo
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<SubTypeList> GetSubType([FromBody]Parameter issueParameters)
        public object GetSubType([FromBody] Parameter issueParameters)

        {
            try
            {
                List<SubTypeList> SubTypeLists = new List<SubTypeList>();
                object[] inputstring = { issueParameters.intProjectID, issueParameters.strType };
                bool result1 = ChkSpecialChar(inputstring);
                SubTypeList subTypeList1 = new SubTypeList();
                if (result == true)
                {
                    subTypeList1.ResultFlag = result1;
                    SubTypeLists.Add(subTypeList1);
                }
                else
                {
                    DataTable SubTypeListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + issueParameters.intProjectID + ",'S','" + issueParameters.strType + "'", true, CommonController.connectionString);

                    foreach (DataRow subtypelistRow in SubTypeListTable.Rows)
                    {
                        SubTypeList subtypelist = new SubTypeList()
                        {
                            strFieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subtypelistRow["FieldID"], "0")),
                            strFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subtypelistRow["FieldName"], "0")),
                            strType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(subtypelistRow["Type"], "0")),
                            ResultFlag = result1

                        };

                        SubTypeLists.Add(subtypelist);
                    }

                }
                return SubTypeLists;
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
        //public List<SubTypeList> GetStatus([FromBody]Parameter issueParameters)
        public object GetStatus([FromBody] Parameter issueParameters)

        {
            try
            {
                List<SubTypeList> StatusLists = new List<SubTypeList>();
                object[] inputstring = { issueParameters.intProjectID, issueParameters.strType };
                bool result1 = ChkSpecialChar(inputstring);
                SubTypeList statusList1 = new SubTypeList();
                if (result == true)
                {
                    statusList1.ResultFlag = result1;
                    StatusLists.Add(statusList1);
                }
                else
                {
                    string strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + issueParameters.intProjectID + ",'" + issueParameters.strType + "', NULL, NULL, " + issueParameters.intRoleID + "";
                    //DataTable StatusListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_IB_Projdboect_Type_Status_OpenStatus " + issueParameters.intProjectID + ",'" + issueParameters.strType + "'," + issueParameters.intRoleID + "", true, CommonController.connectionString);
                    DataTable StatusListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    foreach (DataRow statuslistRow in StatusListTable.Rows)
                    {
                        SubTypeList statuslist = new SubTypeList()
                        {
                            strFieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(statuslistRow["FieldID"], "0")),
                            strFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(statuslistRow["FieldName"], "0")),
                            strType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(statuslistRow["Type"], "0")),
                            ResultFlag = result1

                        };

                        StatusLists.Add(statuslist);
                    }

                }
                return StatusLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Current date and time
        [Authorize, App_Start.ValidateHeaders]
        [HttpGet]
        public object GetCurrentDateTime()
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_SMALLDATETIME";
                object serverdate = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                strSQL = "Exec usp_Whizible2_sel_GetDate";
                object servertime = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                string[] getdatatime = { serverdate.ToString(), servertime.ToString() };

                return getdatatime;
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
        //public List<IterationList> GetIterationName([FromBody]Parameter issueParameters)
        public object GetIterationName([FromBody] Parameter issueParameters)

        {
            try
            {
                List<IterationList> IterationLists = new List<IterationList>();
                object[] inputstring = { issueParameters.intReleaseID };
                bool result1 = ChkSpecialChar(inputstring);
                IterationList IterationList1 = new IterationList();
                if (result == true)
                {
                    IterationList1.ResultFlag = result1;
                    IterationLists.Add(IterationList1);
                }
                else
                {
                    DataTable IterationListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " + issueParameters.intReleaseID, true, CommonController.connectionString);

                    foreach (DataRow iterationlistRow in IterationListTable.Rows)
                    {
                        IterationList iterationlist = new IterationList()
                        {
                            IntIterationId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["IterationID"], "0")),
                            StrIterationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["IterationName"], "0")),
                            ResultFlag = result1

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

        //Get Iteration Name List DropDown Combo
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<UserStoryList> GetUserStoryName([FromBody]Parameter issueParameters)
        public object GetUserStoryName([FromBody] Parameter issueParameters)

        {
            try
            {
                List<UserStoryList> UserStoryLists = new List<UserStoryList>();
                object[] inputstring = { issueParameters.intIterationID };
                bool result1 = ChkSpecialChar(inputstring);
                UserStoryList userStorylist1 = new UserStoryList();
                if (result == true)
                {
                    userStorylist1.ResultFlag = result1;
                    UserStoryLists.Add(userStorylist1);
                }
                else
                {
                    DataTable userStoryListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ScrumUserStory_IterationWise_UserStoryID_UserStoryName " + issueParameters.intIterationID, true, CommonController.connectionString);

                    foreach (DataRow userStorylistRow in userStoryListTable.Rows)
                    {
                        UserStoryList userStorylist = new UserStoryList()
                        {
                            IntUserStoryId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userStorylistRow["UserStoryID"], "0")),
                            StrUserStory = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userStorylistRow["UserStoryName"], "0")),
                            ResultFlag = result1

                        };
                        UserStoryLists.Add(userStorylist);
                    }
                }

                return UserStoryLists;
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
        //public object CopyIssues([FromBody] object[] objCopyIssue)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CopyIssues([FromBody] string objcopyIssue)
        {
            try
            {
                //Added By Riddhesh Patil on 31st March 2023
                string[] objCopyIssue;
                objCopyIssue = objcopyIssue.Split(',');
                
                objCopyIssue[1] = objCopyIssue[1].Replace(' ', ',');
                //End of Added By Riddhesh Patil on 31st March 2023
                string strSQL;
                int result;
                string Project_Flag = Convert.ToString(CommonFunctions.Data.GetDataScalar("Exec Usp_Whizible2_Sel_ProjectTypeInfo " + Convert.ToInt32(objCopyIssue[0].ToString()), true, CommonController.connectionString));


                if (Project_Flag == "1")
                {
                    strSQL = "EXEC usp_Whizible2_Ins_tbl_IB_Issue_CopyBulkIssues " + Convert.ToInt32(objCopyIssue[0].ToString()) + ",'" + HttpUtility.UrlDecode(objCopyIssue[1].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[2].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[3].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[4].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[5].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[6].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[7].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[8].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[9].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[10].ToString()) + "'," + objCopyIssue[11].ToString() + "," + objCopyIssue[12].ToString() + "," + objCopyIssue[13].ToString() + "";

                }
                else
                {
                    strSQL = "EXEC usp_Whizible2_Ins_tbl_IB_Issue_CopyBulkIssues " + Convert.ToInt32(objCopyIssue[0].ToString()) + ",'" + HttpUtility.UrlDecode(objCopyIssue[1].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[2].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[3].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[4].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[5].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[6].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[7].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[8].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[9].ToString()) + "','" + HttpUtility.UrlDecode(objCopyIssue[10].ToString()) + "'";

                }


                result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return Ok("Issues are Copied Successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }

        //Generate Token
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public string GenerateToken([FromBody]string Parameters)
        {
            string generatetoken = CommonFunctions.Security.Token.GetToken(Parameters);

            return generatetoken;
        }
        private bool ChkSpecialChar(object[] val)
        {
            for (int j = 0; j < val.Length; j++)
            {
                for (int i = 0; i < lstSpecialCharacters.Length; i++)
                {
                    result = val[j].ToString().Contains(lstSpecialCharacters[i]);
                    if (result == true)
                    {
                        break;
                    }
                }
            }
            return result;
        }
        public class Parameter
        {
            public int intProjectID { get; set; }
            public int intCurrentProjectID { get; set; }
            public int intUserID { get; set; }
            public int intRoleID { get; set; }
            public string StrProjectName { get; set; }
            public string StrResponsible { get; set; }
            public int IntIssueId { get; set; }
            public string StrSummary { get; set; }
            public string StrDescription { get; set; }
            public string strType { get; set; }
            public string StrSubType { get; set; }
            public string StrStatus { get; set; }
            public string StrPriority { get; set; }
            public string StrSeverity { get; set; }
            public int IntTypeID { get; set; }
            public int IntSubTypeID { get; set; }
            public string StrReportedBy { get; set; }
            public string DtReportedDate { get; set; }
            public string DtReportedTime { get; set; }
            public string strLoginType { get; set; }
            public int intLayOutID { get; set; }
            public int intReleaseID { get; set; }
            public int intIterationID { get; set; }

        }


    }
}
