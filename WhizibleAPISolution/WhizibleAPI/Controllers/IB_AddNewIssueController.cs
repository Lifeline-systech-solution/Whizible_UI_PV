using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Configuration;
using WhizibleAPI.Models.Issue;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.Web;
using System.IO;
using System.Xml;
////Added By Dipali V On 25th Nov 2021 For File Upload
using System.Runtime.InteropServices;
// End of Added By Dipali V On 25th Nov 2021 For File Upload
namespace WhizibleAPI.Controllers
{
    public class IB_AddNewIssueController : ApiController
    {
        string SpecialCharacters;

        string[] lstSpecialCharacters;

        /// <summary>
        /// create  constructor for initialize the  value  
        /// </summary>
        /// <param name=""></param>
        /// <returns></returns>
        /// 
        public IB_AddNewIssueController()
        {
            SpecialCharacters = ConfigurationManager.AppSettings["SpecialCharactersList"];
            lstSpecialCharacters = Regex.Split(SpecialCharacters, ",");

        }
        /// <summary>
        /// generate token
        /// </summary>
        /// <param>validatedparameter</param>
        /// <returns>validatetoken</returns>
         //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object generateToken([FromBody]string validatedparameter)
        {
            try { 
            string generatetoken = CommonFunctions.Security.Token.GetToken(validatedparameter);

            // object validatetoken = CommonFunctions.Security.Token.ValidateToken(validatedparameter, generatetoken);

            return generatetoken;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        // IB_NewIssueController newIssueList = new IB_NewIssueController();
        /// <summary>
        /// Expectdstatr&endDate - Get the expected date  and expectd end date from given ProjectId
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <returns></returns>
        /// 


        /// <summary>
        /// get Issuecontrol list from using Layout id for plaoting control with give attribute
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        int LayOutId;
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<LayoutControl_NewIssue> IssueControlLists([FromBody] newIssueLayOutcontrol_NewIssue layOutcontrol)
        public object IssueControlLists([FromBody] newIssueLayOutcontrol_NewIssue layOutcontrol)
        {
            try { 
            List<LayoutControl_NewIssue> lstLayoutControl = new List<LayoutControl_NewIssue>();



            object[] inputstring = { layOutcontrol.ProjectId, layOutcontrol.RoleId.ToString() };


            LayoutControl_NewIssue layoutControl1 = new LayoutControl_NewIssue();

            bool result1 = ChkSpecialChar(inputstring);
            if (result == true)
            {

                layoutControl1.ResultFlag = result1;
                lstLayoutControl.Add(layoutControl1);
            }
            else
            {
                string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + layOutcontrol.ProjectId + "," + layOutcontrol.RoleId + ", '" + layOutcontrol.Type + "'";

                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in taskListTable1.Rows)
                {
                    //LayoutFlag layoutControlProjectFlag = new LayoutFlag()
                    //{
                    //    layoutProjectFlag = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Flag"].ToString(), "0"))

                    //};
                    LayOutId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LayoutID"], "0"));


                }


                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_IssueEntry_Layout_Details NULL," + LayOutId + ",Null,Null,'Add'";
                    //   List<LayoutControl> lstLayoutControl = new List<LayoutControl>();


                    //DataTable sdr;
                    //sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //   lstLayoutControl = (from l in taskListTable select  new LayoutControl { FieldName = l[1] }).ToList();

                //DataRow[] dataRows = taskListTable.Select().OrderBy(u => u["EmailId"]).ToArray();
                foreach (DataRow sdr in taskListTable.Rows)
                {
                    LayoutControl_NewIssue layoutControl = new LayoutControl_NewIssue()
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
                        //Added By Dipali V On 6th April 2023 For Check Mandatory Flag
                        MandatoryInAdd = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MandatoryInAdd"].ToString(), "")),
                        MandatoryInEdit = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MandatoryInEdit"].ToString(), "")),
                        //End of Added By Dipali V On 6th April 2023 For Check Mandatory Flag
                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
                        TableFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["TableFieldName"].ToString(), "")),
                        ControlWidth = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ControlWidth"].ToString(), "0")),
                        Active = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Active"].ToString(), "0")),
                        ResultFlag = result1
                    };
                    lstLayoutControl.Add(layoutControl);

                    //lstLayoutControl.ToList().ForEach(val1 => {
                    //    lstspecialcharacters.tolist().foreach (val2 =>
                    //    {
                    //        result = val1.tostring().contains(val2);
                    //        if (result == true)
                    //        {
                    //            array.clear(val, 0, val.length);

                    //        }
                    //    }) ;

                    //});
                    string[] field = { "Description" };
                    // IDictionary<string, string> dict = new Dictionary<string, string>();
                }

            }

            return lstLayoutControl;
        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        /// get Layout flag for some control depend on flag using project id
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        //string Project_Flag
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public object[] GetLayoutProjectFlag([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetLayoutProjectFlag([FromBody] CommonProperty_NewIssue commonProperty)
        {
            try
            {
                //string layoutid;
                int MaxRow = 0, MaxColoumn = 0, layoutid = 0;
                string strSQL = "Usp_Whizible2_Sel_ProjectTypeInfo " + commonProperty.ProjectId;
                //  List<LayoutFlag> LayoutProjectFlag = new List<LayoutFlag>();
                //DataTable sdr;
                //sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                //DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                object Project_Flag = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                strSQL = "usp_sel_Whizible2_tbl_PM_Project_IsIssueSLAApplicable " + commonProperty.ProjectId;
                object IsIssueSLAApplicable = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "false"));
                //foreach (DataRow sdr in taskListTable.Rows)
                //{
                //    //LayoutFlag layoutControlProjectFlag = new LayoutFlag()
                //    //{
                //    //    layoutProjectFlag = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Flag"].ToString(), "0"))

                //    //};
                //    Project_Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Flag"].ToString(), "0"));
                //}
              
              
              
              
                string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + commonProperty.ProjectId + "," + commonProperty.RoleId + ", '" + commonProperty.Type + "'";
                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in taskListTable1.Rows)
                {
                    //LayoutFlag layoutControlProjectFlag = new LayoutFlag()
                    //{
                    //    layoutProjectFlag = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Flag"].ToString(), "0"))

                    //};
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

        /// <summary>
        /// get ExpectedStartDate,ExpectedEndDate current project id show on aspx page
        /// </summary>
        /// <param></param>
        /// <returns></returns>
       
   //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> GetStartEndDate([FromBody]int ProjectId)
        public object GetStartEndDate([FromBody] int ProjectId)
        {
            try
            {
                string ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_GetStartendDate ";


                strSQL += ProjectId;

                List<string> lstprojectstartenddate = new List<string>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {

                    ExpectedStartDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedStartDate"].ToString(), ""));
                    ExpectedEndDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedEndDate"].ToString(), ""));


                    lstprojectstartenddate.Add(ExpectedStartDate);
                    lstprojectstartenddate.Add(ExpectedEndDate);
                }
                return lstprojectstartenddate;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        /// get current date time expected format (04/19/20019 04:50 PM)
        /// </summary>
        /// <param></param>
        /// <returns></returns>
        [Authorize]
        [HttpGet]
        //public string[] GetCurrentDateTime()
        public object GetCurrentDateTime()
        {
            try
            {
                // string strSQL = "Exec usp_Whizible2_Sel_CurrentDate";
                string strSQL = "Exec usp_Whizible2_sel_SMALLDATETIME";
                // IDataReader sdr;
                object serverdate = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                strSQL = "Exec usp_Whizible2_sel_GetDate";
                object servertime = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                //serverdate = serverdate;
                string[] getdatatime = { serverdate.ToString(), servertime.ToString() };

                return getdatatime;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }



        /// <summary>
        ///get reported by using project id
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <returns></returns>
        string strSQL;
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetReportedBy([FromBody]CommonProperty_NewIssue commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                //string strSQL = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', "+commonProperty.ProjectId+","+commonProperty.EmployeeId+",1,NULL,NULL,'"+commonProperty.LoginType+ "','New',0";
                object[] inputstring = { commonProperty.ProjectId.ToString(), commonProperty.EmployeeId.ToString(), commonProperty.LoginType.ToString() };




                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {

                    return true;
                }
                else
                {

                    if (commonProperty.strMode == "New")
                    {
                        strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + commonProperty.ProjectId + "," + commonProperty.EmployeeId + ",1,NULL,NULL,'" + commonProperty.LoginType + "','New',0";
                    }
                    else if (commonProperty.strMode == "CopyIssue")
                    {
                        strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + commonProperty.ProjectId + "," + commonProperty.EmployeeId + ",1,NULL,NULL,'" + commonProperty.LoginType + "','CopyIssue',0";

                    }
                    //strSQL += ProjectId;

                    // List<RepotreBY> lstRepotreBY = new List<RepotreBY>();
                    List<string> lstRepotreBY = new List<string>();
                    string UserName;

                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        //Commented And Added By Usha Pandit On 04.05.2021 For crash on customer login
                        //UserName = sdr["UserName"].ToString();

                        //lstRepotreBY.Add(UserName);
                        if (commonProperty.LoginType == "E")
                        {
                            UserName = sdr["UserName"].ToString();
                            lstRepotreBY.Add(UserName);
                        }
                        else
                        {
                            UserName = sdr["CustomerID"].ToString();
                            lstRepotreBY.Add(UserName);
                        }
                        //End Of Added By Usha Pandit On 04.05.2021 For crash on customer login
                    }
                    return lstRepotreBY;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        ///get login Employee name using EmployeeID
        /// </summary>
        /// <param name="EmployeeID"></param>
        /// <returns></returns>

        [Authorize]
        [HttpPost]

        public object GetEmployeeName([FromBody]int EmployeeID)
        {
            try
            {
                RepotreBY repotreBY = new RepotreBY();


                string strSQL = "select * from tbl_PM_Employee where EmployeeID=" + EmployeeID;
                // strSQL += ProjectId;

                //List<string> lstprojectstartenddate = new List<string>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {

                    repotreBY.EmployeeName = CommonFunctions.Data.CheckIsDBNull(sdr["EmployeeName"].ToString(), "").ToString();

                }
                return repotreBY.EmployeeName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get list of Type of current project 
        /// </summary>
        /// <param name="newIssue"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetType([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetType([FromBody] CommonProperty_NewIssue commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                //string strSQL = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + commonProperty.ProjectId + ", 'T',Null,Null,Null,Null,Null," + commonProperty.RoleId;
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + commonProperty.ProjectId + ", 'T',Null,Null,Null,Null,Null," + commonProperty.RoleId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol_NewIssue> lstType = new List<newIssueLayOutcontrol_NewIssue>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol_NewIssue type = new newIssueLayOutcontrol_NewIssue()
                    {
                        FieldID = sdr["FieldID"].ToString(),
                        FieldName = sdr["FieldName"].ToString(),


                    };
                    lstType.Add(type);
                }

                return lstType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        bool result;
        /// <summary>
        ///get list of subType of current Type
        /// </summary>
        /// <param name="newIssue"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetSubType([FromBody]newIssueLayOutcontrol_NewIssue newIssue)
        public object GetSubType([FromBody] newIssueLayOutcontrol_NewIssue newIssue)

        // public string GetSubType([FromBody]newIssueLayOutcontrol newIssue)
        {
            try
            {

                List<newIssueLayOutcontrol_NewIssue> lstSubType = new List<newIssueLayOutcontrol_NewIssue>();



                object[] inputstring = { newIssue.ProjectId.ToString(), newIssue.Type };


                newIssueLayOutcontrol_NewIssue subtype1 = new newIssueLayOutcontrol_NewIssue();

                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {

                    subtype1.ResultFlag = result1;
                    lstSubType.Add(subtype1);
                }
                else
                {
                    // string strSQL = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + newIssue.ProjectId + ", 'S','" + newIssue.Type + "'";
                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + newIssue.ProjectId + ", 'S','" + newIssue.Type + "'";
                    //   strSQL += ProjectId;

                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        newIssueLayOutcontrol_NewIssue subtype = new newIssueLayOutcontrol_NewIssue()
                        {
                            FieldID = sdr["FieldID"].ToString(),
                            FieldName = sdr["FieldName"].ToString(),
                            Type = sdr["Type"].ToString(),
                            ResultFlag = result1

                        };
                        lstSubType.Add(subtype);

                    }


                }

                return lstSubType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        ///get list of Status of current Type
        /// </summary>
        /// <param name="newIssue"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022

        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetStatus([FromBody]newIssueLayOutcontrol_NewIssue newIssue)
        public object GetStatus([FromBody] newIssueLayOutcontrol_NewIssue newIssue)
        {
            try
            {

                List<newIssueLayOutcontrol_NewIssue> lstStatus = new List<newIssueLayOutcontrol_NewIssue>();



                object[] inputstring = { newIssue.ProjectId.ToString(), newIssue.Type, newIssue.RoleId.ToString() };


                newIssueLayOutcontrol_NewIssue Status1 = new newIssueLayOutcontrol_NewIssue();

                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {

                    Status1.ResultFlag = result1;
                    lstStatus.Add(Status1);
                }
                else
                {

                    // DateTime ExpectedStartDate, ExpectedEndDate;

                    // string strSQL = "Exec usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " + newIssue.ProjectId + ",'" + newIssue.Type + "'," + newIssue.RoleId;
                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Projdboect_Type_Status_OpenStatus " + newIssue.ProjectId + ",'" + newIssue.Type + "'," + newIssue.RoleId;
                    //   strSQL += ProjectId;
                    //Added & Commented by dipali v on 12nd Noov 2019 For Status Dropdown 
                    //string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + newIssue.ProjectId + ",'" + newIssue.Type + "',Null, Null" + "," + newIssue.RoleId;
                    //string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + newIssue.ProjectId + ",'" + newIssue.Type + "'";
                    //End of Added & Commented by dipali v on 12nd Noov 2019 For Status Dropdown 
                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        newIssueLayOutcontrol_NewIssue Status = new newIssueLayOutcontrol_NewIssue()
                        {
                            FieldID = sdr["FieldID"].ToString(),
                            FieldName = sdr["FieldName"].ToString(),
                            Type = sdr["Type"].ToString(),
                            ResultFlag = result1

                        };
                        lstStatus.Add(Status);
                    }
                }

                return lstStatus;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //bool IsProductExecutionProject, EnableProductExecution;
        bool IsProductDevelopementProject;
        /// <summary>
        ///get GelProductExecutionProject flag for show and hide product felids on page
        /// </summary>
        /// <param name="newIssue"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetProductExecutionProject([FromBody]newIssueLayOutcontrol_NewIssue newIssue)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;
                object[] inputstring = { newIssue.ProjectId.ToString() };




                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {

                    return true;
                }
                else
                {
                    string strSQL = "Exec  usp_Whizible2_get_ProductExecutionProject " + newIssue.ProjectId;
                    //   strSQL += ProjectId;
                    //  List<bool> getflag = new List<bool>();
                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        //IsProductExecutionProject = Convert.ToBoolean(sdr["IsProductExecutionProject"].ToString());
                        //EnableProductExecution = Convert.ToBoolean(sdr["EnableProductExecution"].ToString());
                        IsProductDevelopementProject = Convert.ToBoolean(sdr["IsProductDevelopementProject"].ToString());
                        //getflag.Add(IsProductDevelopementProject);
                        //  getflag.Add(EnableProductExecution);
                    }

                    return IsProductDevelopementProject;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        List<int> CustomfileId = new List<int>();
        /// <summary>
        ///ploat custom filed control on design page
        /// </summary>
        /// <param name="customFiled"></param>
        /// <returns></returns>

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public CustomFiledPloat_NewIssue PloatCustomFiled([FromBody]CustomFiledPloat_NewIssue customFiled)
        {
            CustomFiledPloat_NewIssue cfp = new CustomFiledPloat_NewIssue();

            // DateTime ExpectedStartDate, ExpectedEndDate;
            //if (cfp.Type!=null) {
            // string strSQL = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + customFiled.commonProperty.ProjectId + "," + customFiled.commonProperty.RoleId + "," + customFiled.commonProperty.EmployeeId + ",'" + customFiled.commonProperty.LoginType + "'";
            string strSQL = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + customFiled.commonProperty_NewIssue.ProjectId + "," + customFiled.commonProperty_NewIssue.RoleId + "," + customFiled.commonProperty_NewIssue.EmployeeId + ",'" + customFiled.commonProperty_NewIssue.LoginType + "'";
            //    //   strSQL += ProjectId;

            IDataReader sdr;
            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

            while (sdr.Read())
            {
                CustomfileId.Add(Convert.ToInt32(sdr["CustomFieldID"]));

            }

            if (customFiled.Type != null)
            {
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.commonProperty_NewIssue.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                //   strSQL += ProjectId;

                IDataReader sdr2;
                sdr2 = CommonFunctions.Data.GetDataReader(strSQL1, true, CommonController.connectionString);
                string val, val1;
                bool val2;
                int UniqueID;
                while (sdr2.Read())
                {
                    //cfp.Type = sdr["Type"].ToString();
                    //cfp.Caption[i] = sdr2["UserGivenCaption"].ToString();
                    //cfp.DatabaseFieldName[i] = sdr2["DatabaseFieldName"].ToString();
                    //cfp.IscustomfileAssigned[i] = Convert.ToBoolean(sdr2["IsCustomFieldAssigned"]);
                    UniqueID = Convert.ToInt32(sdr2["UniqueID"].ToString());
                    if (CustomfileId.Contains(UniqueID))
                    {
                        val = sdr2["UserGivenCaption"].ToString();
                        cfp.Caption_NewIssue.Add(val);
                        val1 = sdr2["DatabaseFieldName"].ToString();
                        cfp.DatabaseFieldName_NewIssue.Add(val1);
                        val2 = Convert.ToBoolean(sdr2["IsCustomFieldAssigned"]);
                        cfp.IscustomfileAssigned_NewIssue.Add(val2);
                    }



                }

                if (cfp.DatabaseFieldName_NewIssue.Contains("CustomFieldCombo1"))
                {


                    // string strSQL2 = "Exec usp_Sel_tbl_IB_CustomFields_Details 'CustomFieldCombo1'," + customFiled.commonProperty.ProjectId;
                    string strSQL2 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details 'CustomFieldCombo1'," + customFiled.commonProperty_NewIssue.ProjectId;
                    //   strSQL += ProjectId;
                    string value;
                    IDataReader sdr3;
                    sdr3 = CommonFunctions.Data.GetDataReader(strSQL2, true, CommonController.connectionString);

                    while (sdr3.Read())
                    {
                        //cfp.Type = sdr["Type"].ToString();
                        value = sdr3["Value"].ToString();
                        cfp.Value_NewIssue.Add(value);

                    }

                }



            }

            return cfp;
        }

        /// <summary>
        ///ploat custom filed control on design page
        /// </summary>
        /// <param name="customFiled"></param>
        /// <returns></returns>

        [Authorize]
        [HttpPost]
        public void PloatCustomFiledsample([FromBody]CustomFiledPloat_NewIssue customFiled)
        {

        }


        /// <summary>
        ///get list of Kernel of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> GetKernel([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetKernel([FromBody] CommonProperty_NewIssue commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Kernels " + commonProperty.ProjectId;
                //   strSQL += ProjectId;
                string kernel1;
                List<string> lstKernel = new List<string>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {

                    kernel1 = sdr["Kernels"].ToString();



                    lstKernel.Add(kernel1);
                }

                return lstKernel;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get list of Severity of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetSeverity([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetSeverity([FromBody] CommonProperty_NewIssue commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Severity " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol_NewIssue> lstseverity = new List<newIssueLayOutcontrol_NewIssue>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol_NewIssue severity = new newIssueLayOutcontrol_NewIssue()
                    {
                        FieldID = sdr["FieldId"].ToString(),
                        FieldName = sdr["FieldName"].ToString(),


                    };
                    lstseverity.Add(severity);
                }

                return lstseverity;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        /// <summary>
        ///get list of Priorities of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetPriorities([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetPriorities([FromBody] CommonProperty_NewIssue commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Priorities " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol_NewIssue> lstPriorities = new List<newIssueLayOutcontrol_NewIssue>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol_NewIssue Priorities = new newIssueLayOutcontrol_NewIssue()
                    {
                        FieldID = sdr["FieldId"].ToString(),
                        FieldName = sdr["FieldName"].ToString(),


                    };
                    lstPriorities.Add(Priorities);
                }

                return lstPriorities;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }





        /// <summary>
        ///get list of Deliverable of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetDeliverable([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetDeliverable([FromBody] CommonProperty_NewIssue commonProperty)
        {
            try
            {
                {
                    // DateTime ExpectedStartDate, ExpectedEndDate;

                    //  string strSQL = "Exec usp_Sel_tbl_PM_ProjectSchedule " + commonProperty.ProjectId;
                    // string strSQL = "Exec usp_Whizible2_sel_tbl_PM_OtherSchedules " + commonProperty.ProjectId;
                    //Commented & added By Dipali V On 12th Sep 2019 For Deliveriable comes instead to Deliveriable type
                    // string strSQL = "Exec usp_Whizible_2_Sel_tbl_PM_ProjectSchedule " + commonProperty.ProjectId;
                    string strSQL = "Exec usp_Whizible2_sel_tbl_PM_OtherSchedules " + commonProperty.ProjectId;
                    //End of Commented & added By Dipali V On 12th Sep 2019 For Deliveriable comes instead to Deliveriable type
                    //   strSQL += ProjectId;

                    List<newIssueLayOutcontrol_NewIssue> lstDeliverable = new List<newIssueLayOutcontrol_NewIssue>();

                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        newIssueLayOutcontrol_NewIssue Deliverable = new newIssueLayOutcontrol_NewIssue()
                        {
                            ScheduleID = Convert.ToInt32(sdr["ScheduleID"].ToString()),
                            // Title = sdr["Title"].ToString(),
                            LabelSchedule = sdr["Title"].ToString(),


                        };
                        lstDeliverable.Add(Deliverable);
                    }

                    return lstDeliverable;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ///// <summary>
        /////get list of Kernel of current project 
        ///// </summary>
        ///// <param name="commonProperty.ProjectID"></param>
        ///// <returns></returns>

        //[Authorize]
        //[HttpPost]
        //public List<string> GetKernel([FromBody]CommonProperty commonProperty)
        //{
        //    // DateTime ExpectedStartDate, ExpectedEndDate;

        //    string strSQL = "Exec usp_Sel_tbl_PM_ProjectSchedule " + commonProperty.ProjectId;
        //    //   strSQL += ProjectId;

        //    List<string> lstKernel = new List<string>();
        //    string Kernel;
        //    IDataReader sdr;
        //    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

        //    while (sdr.Read())
        //    {


        //            Kernel = sdr["Kernels"].ToString();



        //        lstKernel.Add(Kernel);
        //    }

        //    return lstKernel;
        //}

        /// <summary>
        ///get list of Release of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetRelease([FromBody]newIssueLayOutcontrol_NewIssue layOutcontrol)
        //public object GetRelease([FromBody] newIssueLayOutcontrol_NewIssue layOutcontrol)
        public object GetRelease([FromBody] CommonProperty_NewIssue commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                // string strSQL = "Exec usp_sel_tbl_PM_ScrumRelease_ReleaseID " + layOutcontrol.commonProperty.ProjectId;
                //string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseID " + layOutcontrol.commonProperty.ProjectId;
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseID " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol_NewIssue> lstrelease = new List<newIssueLayOutcontrol_NewIssue>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol_NewIssue release = new newIssueLayOutcontrol_NewIssue()
                    {
                        ReleaseID = Convert.ToInt32(sdr["ReleaseID"].ToString()),
                        ReleaseName = sdr["ReleaseName"].ToString(),


                    };
                    lstrelease.Add(release);
                }

                return lstrelease;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get list of Componet of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        [Authorize]
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetComponet([FromBody]newIssueLayOutcontrol_NewIssue layOutcontrol)
        public object GetComponet([FromBody] newIssueLayOutcontrol_NewIssue layOutcontrol)

        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_sel_tbl_PM_ScrumRelease_ReleaseID " + layOutcontrol.commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol_NewIssue> lstrelease = new List<newIssueLayOutcontrol_NewIssue>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol_NewIssue release = new newIssueLayOutcontrol_NewIssue()
                    {
                        ReleaseID = Convert.ToInt32(sdr["ReleaseID"].ToString()),
                        ReleaseName = sdr["ReleaseName"].ToString(),


                    };
                    lstrelease.Add(release);
                }

                return lstrelease;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        /// <summary>
        ///get ProductFiled flag for check customer contorl show or not of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public ProductField_NewIssue ProductFiledFlag([FromBody]ProductField_NewIssue productField)
        public ProductField_NewIssue ProductFiledFlag([FromBody] CommonProperty_NewIssue commonProperty)
        {
            ProductField_NewIssue field = new ProductField_NewIssue();
            string[] inputstring = { commonProperty.ProjectId.ToString() };
            bool result1 = ChkSpecialChar(inputstring);
            if (result == true)
            {

                field.FildFlag = result1;

            }
            else
            {
                //string strSQL = "Exec usp__Whizible2_sel_tbl_PM_Project_DeliverableLevelCustomer " + productField.commonProperty.ProjectId;
                string strSQL = "Exec usp__Whizible2_sel_tbl_PM_Project_DeliverableLevelCustomer " + commonProperty.ProjectId;
                //   strSQL += ProjectId;



                // IDataReader sdr;
                field.FildFlag = Convert.ToBoolean(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //while (sdr.Read())
                //{

                //    field.FildFlag = Convert.ToBoolean(sdr["DeliverableLevelCustomer"]);


                //}
            }

            return field;
        }


        /// <summary>
        ///get Productlist bind droup down list
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        // public  List<ProductField> GetProductList([FromBody]ProductField productField)
        //public object GetProductList([FromBody]ProductField_NewIssue productField)
          public object GetProductList([FromBody] CommonProperty_IssueNew commonProperty)
        {
            string strSQL;
            try
            {
                List<ProductField_NewIssue> lstfield = new List<ProductField_NewIssue>();
                //string[] inputstring = { productField.commonProperty.EmployeeId.ToString(), productField.commonProperty.LoginType, productField.commonProperty.LoginId.ToString(), productField.Customerid.ToString() };
                string[] inputstring = { commonProperty.EmployeeId.ToString(), commonProperty.LoginType, commonProperty.LoginId.ToString(), commonProperty.Customerid.ToString() };

                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    //ProductField field = new ProductField();
                    //field.flag = result1;
                    //lstfield.Add(field);
                    return true;

                }
                else
                {

                    if (commonProperty.FildFlag == 1)
                    {
                        // strSQL = "Exec usp_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId+","+productField.Customerid+ ",NULL,'ProductVersions',NULL";
                        //strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + "," + productField.Customerid + ",NULL,'ProductVersions',NULL";
                        strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + commonProperty.ProjectId + "," + commonProperty.Customerid + ",NULL,'ProductVersions',NULL";

                    }
                    else
                    {
                        //strSQL = "Exec usp_Whizible2_Sel_tbl_PRD_ProductVersion_CustomerWise " + productField.commonProperty.EmployeeId + ",'" + productField.commonProperty.LoginType + "'," + productField.commonProperty.LoginId + ",1,NULL,NULL," + productField.commonProperty.ProjectId;
                        strSQL = "Exec usp_Whizible2_Sel_tbl_PRD_ProductVersion_CustomerWise " + commonProperty.EmployeeId + ",'" + commonProperty.LoginType + "'," + commonProperty.LoginId + ",1,NULL,NULL," + commonProperty.ProjectId;


                    }

                    //   strSQL += ProjectId;



                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        ProductField_NewIssue field = new ProductField_NewIssue()
                        {
                            ProductVersionID = Convert.ToInt32(sdr["ProductVersionID"]),
                            ProductVersion = sdr["ProductVersion"].ToString()
                        };
                        lstfield.Add(field);
                    }
                    return lstfield;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        /// <summary>
        ///get Componetlist bind to the droup down list
        /// </summary>
        /// <param name="productField"></param>
        /// <returns></returns>

   
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<ProductField_NewIssue> GetComponetList([FromBody]ProductField_NewIssue productField)
        //public object GetComponetList([FromBody] ProductField_NewIssue productField)
        //public object GetComponetList([FromBody] CommonProperty_NewIssue commonProperty)
        public object GetComponetList([FromBody] CommonProperty_IssueNew commonProperty)
        {
            string strSQL;
            try
            {
                List<ProductField_NewIssue> lstfield = new List<ProductField_NewIssue>();
               // string[] inputstring = { productField.commonProperty.EmployeeId.ToString(), productField.commonProperty.LoginType, productField.commonProperty.LoginId.ToString(), productField.Customerid.ToString() };
                string[] inputstring = { commonProperty.EmployeeId.ToString(), commonProperty.LoginType, commonProperty.LoginId.ToString(), commonProperty.Customerid.ToString() };
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    ProductField_NewIssue field = new ProductField_NewIssue();
                    //CommonProperty_NewIssue field = new CommonProperty_NewIssue();
                    field.FildFlag = result1;
                    lstfield.Add(field);
                }
                else
                {
                    //if (productField.FildFlag == true)
                    if (commonProperty.FildFlag == 1)
                    {
                        // strSQL = "Exec usp_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + "," + productField.Customerid + ","+productField.ProductVersionID+ ",NULL,'ProductVersions_Components'";
                        //strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + "," + productField.Customerid + "," + productField.ProductVersionID + ",NULL,'ProductVersions_Components'";
                        strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + commonProperty.ProjectId + "," + commonProperty.Customerid + "," + commonProperty.ProductVersionID + ",NULL,'ProductVersions_Components'";
                    }
                    else
                    {
                        //strSQL = "Exec usp_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + ",NULL," + productField.ProductVersionID + ",NULL,'ProductVersions_Components'";
                        //strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + ",NULL," + productField.ProductVersionID + ",NULL,'ProductVersions_Components'";
                        strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + commonProperty.ProjectId + ",NULL," + commonProperty.ProductVersionID + ",NULL,'ProductVersions_Components'";

                    }

                    //   strSQL += ProjectId;

                    // List<ProductField> lstfield = new List<ProductField>();

                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        ProductField_NewIssue field = new ProductField_NewIssue()
                        {
                            ComponentID = Convert.ToInt32(sdr["ComponentID"]),
                            Component = sdr["Component"].ToString()
                        };
                        lstfield.Add(field);
                    }
                }
                return lstfield;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get list IssueID of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetIssueIds([FromBody] CommonProperty_IssueNew commonProperty)
        {
            string strSQL;
            try
            {
                List<ProductField_NewIssue> lstfield = new List<ProductField_NewIssue>();
                string[] inputstring = { commonProperty.ProjectId.ToString(), commonProperty.EmployeeId.ToString() };
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    return true;
                }
                else
                {

                    strSQL = "Exec usp_Whizible2_Sel_v_tbl_IB_Issue " + commonProperty.ProjectId + "," + commonProperty.EmployeeId;
                    //   strSQL += ProjectId;

                    List<int> lstIssueId = new List<int>();
                    int issueid;
                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {

                        issueid = Convert.ToInt32(sdr["IssueID"].ToString());




                        lstIssueId.Add(issueid);
                    }

                    return lstIssueId;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        /// Get Field Value name by selected issued id
        /// </summary>
        /// <param name="copyIssueIDs.issueid,copyIssueIDs.strFieldName"></param>
        /// <returns></returns>
        CopyIssueIDs_NewIssue issueIDs = new CopyIssueIDs_NewIssue();
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetFieldValueForIssue([FromBody]CopyIssueIDs_NewIssue copyIssueIDs)
        {
            try
            {
                //Comment and added by imran on 26-02-2022
                //string[] strfield = new string[] { "Type", "CustomerID", "ProductVersionID", "ComponentID", "SubType", "Status", "Priority", "Kernel", "DeliverableID", "CustomFieldCombo1", "CustomFieldTextArea1", "CustomFieldDate1" };
                //string[] strfield = new string[] { "Type", "SubType", "Priority", "Status", "Severity", "ReportedBy", "AssignTo", "ModuleName", "OS", "Hardware", "Kernel", "Phase", "FoundInPhase", "FixedInPhase", "CodedBy", "ShowToCustomer", "CustomFieldText1", "CustomFieldCombo1", "CustomFieldDate1", "CustomFieldTextArea1", "RootCauseID", "DeliverableID", "Complexity", "ProductVersionID", "ComponentID", "CustomerID", "ReleaseID", "IterationID", "UserStoryID" };

                //if (strfield.Contains(copyIssueIDs.strFieldName) == true)
                //{
                //    strSQL = "Exec usp_sel_GetFieldValueForIssue " + copyIssueIDs.issueid + ",'" + copyIssueIDs.strFieldName + "'";
                //}

                strSQL = "Exec usp_sel_GetFieldValueForIssue " + copyIssueIDs.issueid + ",'" + copyIssueIDs.strFieldName + "'";
                issueIDs.GetValue = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                //End by imran on 26-02-2022


                return issueIDs.GetValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///get coded by using project id
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <returns></returns>
        //  string strSQL;
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<RepotreBY_NewIssue> GetCodedBy([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetCodedBy([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                if (commonProperty.strMode == "New")
                {
                    strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " + commonProperty.ProjectId + "," + " NULL ,NULL, NULL, NULL ," + commonProperty.LoginType + ",'New',0";
                }
                else if (commonProperty.strMode == "CopyIssue")
                {

                    strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " + commonProperty.ProjectId + "," + " NULL ,NULL, NULL, NULL ," + commonProperty.LoginType + ",'CopyIssue',0";

                }

                List<RepotreBY_NewIssue> lstcodedby = new List<RepotreBY_NewIssue>();


                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    RepotreBY_NewIssue codedby = new RepotreBY_NewIssue()
                    {
                        EmployeeID = Convert.ToInt32(sdr["EmployeeID"]),
                        UserName = sdr["UserName"].ToString()
                    };

                    lstcodedby.Add(codedby);
                }

                return lstcodedby;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get coded by using project id
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <returns></returns>
        //  string strSQL;
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<RepotreBY_NewIssue> AssignTo([FromBody]CommonProperty_NewIssue commonProperty)
        public object AssignTo([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                //Commented by dipali V On 18th Sep 2019 for Issue responsible person should come by default
                // strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " + commonProperty.ProjectId + "," + "NULL";
                strSQL = "Exec usp_Whizible2_Sel_ResponsiblePersonForIssue  " + commonProperty.ProjectId + "";
                //End of Commented by dipali V On 18th Sep 2019 for Issue responsible person should come by default

                List<RepotreBY_NewIssue> lstAssignTo = new List<RepotreBY_NewIssue>();


                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    RepotreBY_NewIssue AssignTo = new RepotreBY_NewIssue()
                    {
                        //Commented by dipali V On 18th Sep 2019 for Issue responsible person should come by default
                        //EmployeeID = Convert.ToInt32(sdr["EmployeeID"]),
                        //UserName = sdr["UserName"].ToString()
                        EmployeeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ResponsiblePersonForIssue"], "0")),
                        UserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserName"], ""))
                        //End of Commented by dipali V On 18th Sep 2019 for Issue responsible person should come by default
                    };

                    lstAssignTo.Add(AssignTo);
                }

                return lstAssignTo;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }






        /// <summary>
        ///get list of ProjectRootCause of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022

        [HttpPost]
        public List<newIssueLayOutcontrol_NewIssue> GetProjectRootCause([FromBody] CommonProperty_IssueNew commonProperty)
        {
            // DateTime ExpectedStartDate, ExpectedEndDate;

            string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_RootCause " + commonProperty.ProjectId;
            //   strSQL += ProjectId;

            List<newIssueLayOutcontrol_NewIssue> lstProjectRootCause = new List<newIssueLayOutcontrol_NewIssue>();

            IDataReader sdr;
            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

            while (sdr.Read())
            {
                newIssueLayOutcontrol_NewIssue ProjectRootCause = new newIssueLayOutcontrol_NewIssue()
                {
                    FieldID = sdr["FieldId"].ToString(),
                    FieldName = sdr["FieldName"].ToString(),


                };
                lstProjectRootCause.Add(ProjectRootCause);
            }

            return lstProjectRootCause;
        }


        /// <summary>
        ///get list of Module of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> GetModule([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetModule([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Module_ProjectGroup " + commonProperty.ProjectId + ",NULL";
                //   strSQL += ProjectId;

                List<string> lstmodule = new List<string>();
                string modulename;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    //newIssueLayOutcontrol ProjectRootCause = new newIssueLayOutcontrol()
                    //{
                    //    FieldID = sdr["FieldId"].ToString(),
                    //    FieldName = sdr["FieldName"].ToString(),
                    modulename = sdr["ModuleName"].ToString();

                    //};

                    lstmodule.Add(modulename);
                }

                return lstmodule;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///get list of ChangeRequest_Master of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetChangeRequestMaster([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetChangeRequestMaster([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Sel_tbl_PM_ChangeRequest_Master " + commonProperty.ProjectId + ",NULL";
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol_NewIssue> lstChangeRequestMaster = new List<newIssueLayOutcontrol_NewIssue>();
                // string modulename;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol_NewIssue ChangeRequestMaster = new newIssueLayOutcontrol_NewIssue()
                    {
                        ChangeRequestID = Convert.ToInt32(sdr["ChangeRequestID"]),
                        ChangeRequestSummary = sdr["ChangeRequestSummary"].ToString(),
                        //modulename = sdr["ModuleName"].ToString();

                    };

                    lstChangeRequestMaster.Add(ChangeRequestMaster);
                }

                return lstChangeRequestMaster;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get list of Project_Version of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> GetProjectVersion([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetProjectVersion([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                //  string strSQL = "Exec usp_Sel_tbl_IB_Project_Version " + commonProperty.ProjectId ;
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Version " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<string> lstProjectVersion = new List<string>();
                string ProjectVersion;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    //newIssueLayOutcontrol ProjectRootCause = new newIssueLayOutcontrol()
                    //{
                    //    FieldID = sdr["FieldId"].ToString(),
                    //    FieldName = sdr["FieldName"].ToString(),
                    ProjectVersion = sdr["Versions"].ToString();

                    //};

                    lstProjectVersion.Add(ProjectVersion);
                }

                return lstProjectVersion;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///get list of Phase of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> GetPhase([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetPhase([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<string> lstPhase = new List<string>();
                string Phase;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    //newIssueLayOutcontrol ProjectRootCause = new newIssueLayOutcontrol()
                    //{
                    //    FieldID = sdr["FieldId"].ToString(),
                    //    FieldName = sdr["FieldName"].ToString(),
                    Phase = sdr["Phase"].ToString();

                    //};

                    lstPhase.Add(Phase);
                }

                return lstPhase;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get list of Hardware of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> GetHardware([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetHardware([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectHardware " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<string> lstHardware = new List<string>();
                string Hardware;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    //newIssueLayOutcontrol ProjectRootCause = new newIssueLayOutcontrol()
                    //{
                    //    FieldID = sdr["FieldId"].ToString(),
                    //    FieldName = sdr["FieldName"].ToString(),
                    Hardware = sdr["Hardware"].ToString();

                    //};

                    lstHardware.Add(Hardware);
                }

                return lstHardware;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///get list of OS of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<string> GetOS([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetOS([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_OS " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<string> lstOS = new List<string>();
                string OS;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    //newIssueLayOutcontrol ProjectRootCause = new newIssueLayOutcontrol()
                    //{
                    //    FieldID = sdr["FieldId"].ToString(),
                    //    FieldName = sdr["FieldName"].ToString(),
                    OS = sdr["OS"].ToString();

                    //};

                    lstOS.Add(OS);
                }

                return lstOS;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///get all value by selectd issueid
        /// </summary>
        /// <param name="IssueId"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object GetValueByIssuid([FromBody] IssueParameters Issuepara)
        {
            try
            {
                string strSQL;

                string[] inputstring = { Issuepara.IssueID.ToString(), Issuepara.ProjectID.ToString() };
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {


                    return true;

                }
                else
                {
                    string strSQL1 = "Exec usp_whizible2_sel_tbl_ib_TypeResponsiblePerson " + Issuepara.ProjectID;
                    object AssignTo = CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString);
                    strSQL = "Exec usp_whizible2_Sel_tbl_IB_Issue " + Issuepara.IssueID;

                    DataTable dt = new DataTable();
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    //Added & Commented by dipali V on 12th Sep 2019 
                    //dt.Columns["AssignTo"] = AssignTo.ToString();
                    //End of Added & Commented by dipali V on 12th Sep 2019 
                    dt.Columns["AssignTo"].SetOrdinal(15);
                    dt.Columns["CustomerID"].SetOrdinal(78);
                    dt.Columns["ProductVersionID"].SetOrdinal(79);
                    dt.Columns["ComponentID"].SetOrdinal(80);
                    // dt.Columns["ComponentID"].ColumnName = "Module";
                    //foreach (var column in dt.Columns.Cast<DataColumn>().ToArray())
                    //{
                    //    if (dt.AsEnumerable().All(dr => dr.IsNull(column)))
                    //        dt.Columns.Remove(column);
                    //}
                    dt.AcceptChanges();
                    return dt;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        /// <summary>
        ///drow table details by selectd ProjectId
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        public object CreateCustomFiledTable([FromBody] int ProjectId)
        {
            try
            {
                string strSQL;

                string[] inputstring = { ProjectId.ToString() };
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {


                    return true;

                }
                else
                {

                    strSQL = "Exec usp_sel_tbl_IB_CustomFields_Master_RowNumber " + ProjectId;

                    DataTable dt = new DataTable();
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    return dt;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        /// <summary>
        ///drow table details by selectd ProjectId
        /// </summary>
        /// <param name="ProjectId"></param>
        /// <returns></returns>

        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public object customfiledPloat([FromBody]CustomFiledPloat_NewIssue customFiled)
        public object customfiledPloat([FromBody] CommonProperty_IssueNew commonProperty_NewIssue)
        {
            try
            {
                string strSQL;
                // int[] CustomfiledId;
                // int i;
                //string[] inputstring = { customFiled.Type, customFiled.commonProperty_NewIssue.ProjectId.ToString(), customFiled.commonProperty_NewIssue.LoginId.ToString(), customFiled.commonProperty_NewIssue.LoginType.ToString(), customFiled.commonProperty_NewIssue.RoleId.ToString() };
                string[] inputstring = { commonProperty_NewIssue.Type, commonProperty_NewIssue.ProjectId.ToString(), commonProperty_NewIssue.LoginId.ToString(), commonProperty_NewIssue.LoginType.ToString(), commonProperty_NewIssue.RoleId.ToString() };
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {


                    return true;

                }
                else
                {

                    //strSQL = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.commonProperty_NewIssue.ProjectId + ",NULL,1," + customFiled.Type;
                    strSQL = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + commonProperty_NewIssue.ProjectId + ",NULL,1," + commonProperty_NewIssue.Type;

                    DataTable dt = new DataTable();
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    return dt;
                }
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
        //public List<CustomFiledPloat1_NewIssue> PloatCustomFiled1([FromBody]CustomFiledPloat1_NewIssue customFiled)
        //public object PloatCustomFiled1([FromBody] CustomFiledPloat1_NewIssue customFiled)
        public object PloatCustomFiled1([FromBody] CommonProperty_IssueNew commonProperty)

        {
            try {

            List<CustomFiledPloat1_NewIssue> cfp = new List<CustomFiledPloat1_NewIssue>();
            List<CustomFiledPloat1_NewIssue> CustomFieldIDs = new List<CustomFiledPloat1_NewIssue>();

            //DateTime ExpectedStartDate, ExpectedEndDate;

            //string strSQL = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + customFiled.commonProperty.ProjectId + "," + customFiled.commonProperty.RoleId + "," + customFiled.commonProperty.EmployeeId + ",'" + customFiled.commonProperty.LoginType + "'";
            string strSQL = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + commonProperty.ProjectId + "," + commonProperty.RoleId + "," + commonProperty.EmployeeId + ",'" + commonProperty.LoginType + "'";

            IDataReader sdr1;
            int IsCustomeFieldAccessible = 0;
            sdr1 = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

            while (sdr1.Read())
            {
                CustomfileId1.Add(Convert.ToInt32(sdr1["CustomFieldID"]));


            }

            //    DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            //    foreach (DataRow sdr in taskListTable1.Rows)
            //    {
            //    CustomFiledPloat layoutControl1 = new CustomFiledPloat()
            //    {
            //        CustomFieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CustomFieldID"].ToString(), "0")),
            //    };
            //    CustomFieldIDs.Add(layoutControl1);
            //}



            //if (customFiled.Type != null)
            if (commonProperty.Type != null)
            {
              //  string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.commonProperty.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + commonProperty.ProjectId + ",NULL,1," + "'" + commonProperty.Type + "'";
                //   strSQL += ProjectId;
                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    if (CustomfileId1.Contains(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0"))))
                    {
                        CustomFiledPloat1_NewIssue layoutControl = new CustomFiledPloat1_NewIssue()
                        {

                            UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                            UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserGivenCaption"].ToString(), "")),
                            DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")),
                            RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                            ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                            IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),
                            ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationRules"].ToString(), "")),
                            DefaultValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultValue"].ToString(), "")),
                            //added By Chetan M On 27th Mar 2020 For Issue ID 23059
                            MaxLength = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxLength"].ToString(), "")),
                            MinValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MinValue"].ToString(), "")),
                            MaxValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxValue"].ToString(), "")),
                            //Added by imran on 14-02-2022 for set Default value or static value
                            DefaultType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultType"].ToString(), "")),
                            //End by imran on 14-02-2022 for set Default value or static value
                            //End Of added By Chetan M On 27th Mar 2020 For Issue ID 23059
                            // IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),

                        };
                        cfp.Add(layoutControl);

                        if (CustomfileId1.Contains(layoutControl.UniqueID))
                        {
                            continue;
                        }
                        else
                        {
                            //   layoutControl.IsCustomFieldAssigned = "0";
                        }
                    }
                }
            }
            else
            {

                //string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.commonProperty.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + commonProperty.ProjectId + ",NULL,1," + "'" + commonProperty.Type + "'";
                //   strSQL += ProjectId;
                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    if (CustomfileId1.Contains(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0"))))
                    {
                        CustomFiledPloat1_NewIssue layoutControl = new CustomFiledPloat1_NewIssue()
                        {

                            UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                            UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserGivenCaption"].ToString(), "")),
                            DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")),
                            RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                            ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                            IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),
                            ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationRules"].ToString(), "")),
                            DefaultValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultValue"].ToString(), "")),
                            //IsCustomFieldAssigned = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),

                        };
                        cfp.Add(layoutControl);

                        if (CustomfileId1.Contains(layoutControl.UniqueID))
                        {
                            continue;
                        }
                        else
                        {
                            //layoutControl.IsCustomFieldAssigned = "0";
                        }

                    }
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
        //  public List<CustomFiledPloat1_NewIssue> GetComboboxValues([FromBody]CustomFiledPloat1_NewIssue customFiled)
        public object GetComboboxValues([FromBody]CustomFiledPloat1_NewIssue customFiled)
        {
            try
            {
                //List<CustomFiledPloat1> cfp = new List<CustomFiledPloat1>();
                //string[] inputstring = { customFiled.DatabaseFieldName, customFiled.commonProperty.ProjectId.ToString() };
                string[] inputstring = { customFiled.DatabaseFieldName, customFiled.ProjectId.ToString() };
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {


                    return true;

                }
                else
                {



                    //string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details " + "'" + customFiled.DatabaseFieldName + "'," + customFiled.commonProperty.ProjectId;
                    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details " + "'" + customFiled.DatabaseFieldName + "'," + customFiled.ProjectId;
                    //   strSQL += ProjectId;
                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                    //added by omkar 20/3/2020 issue id  23039
                    if (taskListTable.Columns.Count == 1)
                    {
                        taskListTable.Columns[0].ColumnName = "CustomerName";

                    }
                    //end of added by omkar 20/3/2020 issue id 23039

                    //foreach (DataRow sdr in taskListTable.Rows)
                    //{
                    //    CustomFiledPloat1 layoutControl = new CustomFiledPloat1()
                    //    {
                    //        FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldID"].ToString(), "")),
                    //        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
                    //        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),

                    //    };
                    //    cfp.Add(layoutControl);

                    //}

                    return taskListTable;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///Get Iteration Name List DropDown Combo
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<IterationList_NewIssue> GetIterationName([FromBody]Parameter_NewIssue issueParameters)
        public object GetIterationName([FromBody] Parameter_NewIssue issueParameters)
        {
            try
            {
                List<IterationList_NewIssue> IterationLists = new List<IterationList_NewIssue>();

                {
                    //Commented And Added By Reshma Chavan on 23rd Dec 2021 for not showing sprint in edit mode
                    //DataTable IterationListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " + issueParameters.intReleaseID, true, CommonController.connectionString);
                    String StrSQL = "";
                    if (issueParameters.IntIssueId == 0)
                    {
                        StrSQL = "usp_Whizible2_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " + issueParameters.intReleaseID + ",NULL";
                    }
                    else
                    {
                        StrSQL = "usp_Whizible2_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " + issueParameters.intReleaseID + "," + issueParameters.IntIssueId + "";
                    }

                    DataTable IterationListTable = CommonFunctions.Data.GetDataTable(StrSQL, true, CommonController.connectionString);


                    //End of Commented And Added By Reshma Chavan on 23rd Dec 2021 for not showing sprint in edit mode

                    foreach (DataRow iterationlistRow in IterationListTable.Rows)
                    {
                        IterationList_NewIssue iterationlist = new IterationList_NewIssue()
                        {
                            IntIterationId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["IterationID"], "0")),
                            StrIterationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(iterationlistRow["IterationName"], "0"))

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


        /// <summary>
        ///Get Iteration Name List DropDown Combo
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022                      
        [HttpPost]
        //        public List<UserStoryList_NewIssue> GetUserStoryName([FromBody]Parameter_NewIssue issueParameters)
        public object GetUserStoryName([FromBody] Parameter_NewIssue issueParameters)
        {
            try
            {
                List<UserStoryList_NewIssue> UserStoryLists = new List<UserStoryList_NewIssue>();

                {
                    DataTable userStoryListTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_ScrumUserStory_IterationWise_UserStoryID_UserStoryName " + issueParameters.intIterationID, true, CommonController.connectionString);

                    foreach (DataRow userStorylistRow in userStoryListTable.Rows)
                    {
                        UserStoryList_NewIssue userStoryListlist = new UserStoryList_NewIssue()
                        {
                            IntUserStoryId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userStorylistRow["UserStoryID"], "0")),
                            StrUserStory = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userStorylistRow["UserStoryName"], "0"))

                        };
                        UserStoryLists.Add(userStoryListlist);
                    }
                }

                return UserStoryLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //[Authorize]
        //[HttpPost]
        //public string GetDefaultVersion([FromBody]CommonProperty_NewIssue commonProperty)
        //{
        //    string strSQL = "usp_Whizible2_Sel_tbl_IB_Project_Version " + commonProperty.ProjectId + ",NULL,1 ";

        //    int DefaultReportedVersion = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

        //    return DefaultReportedVersion.ToString();
        //}


        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol_NewIssue> GetDefaultVersion([FromBody]CommonProperty_NewIssue commonProperty)
        public object GetDefaultVersion([FromBody] CommonProperty_IssueNew commonProperty)
        {
            try {
                string strSQL = "usp_Whizible2_Sel_tbl_IB_Project_Version " + commonProperty.ProjectId + ",NULL,1 ";

                List<newIssueLayOutcontrol_NewIssue> lstType = new List<newIssueLayOutcontrol_NewIssue>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol_NewIssue type = new newIssueLayOutcontrol_NewIssue()
                    {

                        FieldName = sdr["Versions"].ToString(),


                    };
                    lstType.Add(type);
                }

                return lstType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///check file content and MIME Type
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        //Commented and added by Chetan M on 5 May 2021 for Sonata Issue fixing
         //string MimeType;
       
        [Authorize]
        [HttpPost]
        public object GetFileType()
        {
            try
            {
                bool fileUploadFlag = false;
                string MimeType = "";
                string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                if (HttpContext.Current.Request.Files.AllKeys.Any())
                {
                    for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                    {

                        // Stream xmlStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                        // Stream txtStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                        // string filePath = System.Web.HttpContext.Current.Request.Files[filecount].FileName;
                        // string filename = Path.GetFileName(filePath);
                        // string ext = Path.GetExtension(filename);
                        // ext = ext.Substring(1, ext.Length - 1);
                        //  string contenttype = String.Empty;
                        //  Stream checkStream = System.Web.HttpContext.Current.Request.Files[filecount].InputStream;
                        //  BinaryReader chkBinary = new BinaryReader(checkStream);
                        //  Byte[] chkbytes = chkBinary.ReadBytes(0x10);

                        //Comment and Added by Riddhesh on 25/1/2023
                        string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                        string fileName = HttpContext.Current.Request.Files[filecount].FileName;
                        string fileName1 = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, true, true, true, true);
                        string ValidateFileName = ConfigurationManager.AppSettings["ValidateFileName"];
                        string[] CharList;
                        CharList = ValidateFileName.Split(',');
                        for (int i = 0; i <= CharList.Length - 1; i++)
                        {
                            if (fileName.Contains(CharList[i].ToString()))
                            {
                                fileName1 = fileName.Replace(CharList[i].ToString(), "");
                                break;
                            }
                        }
                        int IsFileValid = 1;
                        //Commented & Added By Dipali V On 6th April 2023 For Comment Double Extension 
                        //string[] extensionList;
                        //extensionList = fileName.Split('.');
                        //if (extensionList.Length > 2)
                        //{
                        //    IsFileValid = 0;
                        //}
                        //End of Commented & Added By Dipali V On 6th April 2023 For Comment Double Extension 

                        if (fileName == fileName1 && IsFileValid == 1)
                        {
                            string ContentType = String.Empty;
                            byte[] buffer = new byte[257];

                            //string MimeType = "";
                            HttpPostedFile file = System.Web.HttpContext.Current.Request.Files[filecount];
                            //var strFileType = "";
                            var strFileType = getMimeFromFile(HttpContext.Current.Request.Files[filecount]);
                            file.InputStream.Read(buffer, 0, 256);
                            file.InputStream.Position = 0;
                            string magicNumber = BitConverter.ToString(buffer);
                            magicNumber = magicNumber.Replace("-", " ");
                            XmlDocument xmlDoc = new XmlDocument();
                            string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                            xmlDoc.Load(xmlPath + "MIMEType.xml");
                            XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                            string xMagicNumber = "";
                            string xContentType = "";
                            string extfromContentType = "";


                            //string fileNameExtention = HttpContext.Current.Request.Files[filecount].FileName;
                            //string ext1 = Path.GetExtension(fileNameExtention);
                            //int count = ext1.Split('.').Length - 1;
                            //int count2 = fileNameExtention.Split('.').Length - 1;
                            //if (count > 1)
                            //{
                            //    MimeType = "";
                            //}
                            //if (count == 1 && count2 == 1)
                            //{
                            foreach (XmlNode node in nodes)
                            {
                                xContentType = node.SelectSingleNode("ContentType").InnerText;
                                if (strFileType == xContentType)
                                {
                                    fileName = HttpContext.Current.Request.Files[filecount].FileName;
                                    string ext = Path.GetExtension(fileName);
                                    ext = ext.Substring(1, ext.Length - 1).ToLower();
                                    extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower();
                                    if (extfromContentType.IndexOf(ext) > -1)
                                    {
                                        MimeType = strFileType;
                                        break;
                                    }
                                }
                            }
                            //}
                            // End of comment by Riddhesh on 25-01-2023
                        }
                        else
                        {
                            MimeType = "";
                        }

                        if (MimeType == "" || MimeType == null)
                        {
                            MimeType = "unknown/unknowns";
                            fileUploadFlag = false;
                        }
                        if (strListofTypes.IndexOf(MimeType) > -1)
                        {
                            fileUploadFlag = true;
                        }
                    }

                }

                return fileUploadFlag;
            //        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
            //        //Dim response As String = String.Empty
            //        //    Dim file As HttpPostedFile = Context.Request.Files(count)
            //        //    Dim buffer As Byte() = New Byte(256) { }
            //        //Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            //        //    Dim MimeType As String
            //        //    file.InputStream.Read(buffer, 0, 256)
            //        //    'Added By Bharat Tekade on 26th-Aug-2016 to solve file upload issue
            //        //    file.InputStream.Position = 0
            //        //try
            //        //{


                //        if (HttpContext.Current.Request.Files.AllKeys.Any())
                //        {
                //            for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                //            {

                //                CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                //                //-------Commented By Dipali V On 31st Oct 2022 For Check validating Contenet type-----------
                //                //Stream xmlStream = System.Web.HttpContext.Current.Request.Files[0].InputStream;
                //                //Stream txtStream = System.Web.HttpContext.Current.Request.Files[0].InputStream;
                //                //string filePath = System.Web.HttpContext.Current.Request.Files[0].FileName;
                //                //string filename = Path.GetFileName(filePath);
                //                //string ext = Path.GetExtension(filename);
                //                //ext = ext.Substring(1, ext.Length - 1);
                //                string ContentType = String.Empty;
                //                //Stream checkStream = System.Web.HttpContext.Current.Request.Files[0].InputStream;
                //                //BinaryReader chkBinary = new BinaryReader(checkStream);
                //                //Byte[] chkbytes = chkBinary.ReadBytes(0x10);
                //                //string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                //                //string magicNumber = BitConverter.ToString(chkbytes);
                //                //string magicCheck = magicNumber.Substring(0, 11);
                //                //magicNumber = magicNumber.Replace("-", " ");
                //                //magicCheck = magicCheck.Replace("-", " ");
                //                //XmlDocument xmlDoc = new XmlDocument();
                //                ////string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory);
                //                //string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                //                //xmlDoc.Load(xmlPath + "MIMEType.xml");
                //                //XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                //                //string xMagicNumber = "";
                //                //string xContentType = "";

                //                //for (int i = 0; i < nodes.Count; i++)
                //                //{
                //                //    xMagicNumber = nodes[i].SelectSingleNode("MagicNumber").InnerText;
                //                //    int strlength = xMagicNumber.Length;
                //                //    //string xsubstring  = magicNumber.Substring(0, strlength);
                //                //    //If xsubstring = xMagicNumber Then
                //                //    if (xMagicNumber.IndexOf(magicCheck) != -1 || magicCheck.IndexOf(xMagicNumber) != -1)
                //                //    {
                //                //        MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                //                //        fileUploadFlag = true;
                //                //        break;
                //                //    }
                //                //    else
                //                //    {
                //                //        if (ext == xMagicNumber)
                //                //        {
                //                //            MimeType = nodes[i].SelectSingleNode("ContentType").InnerText;
                //                //            fileUploadFlag = false;
                //                //        }

                //                //    }

                //                //}
                //                string strListofTypes = ConfigurationManager.AppSettings["FileContentType"];
                //                string fileName = HttpContext.Current.Request.Files[filecount].FileName;
                //                string fileName1 = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, true, true, true);
                //                string ValidateFileName = ConfigurationManager.AppSettings["ValidateFileName"];
                //                string[] CharList;
                //                CharList = ValidateFileName.Split(',');
                //                for (int i = 0; i <= CharList.Length - 1; i++)
                //                {
                //                    if (fileName.Contains(CharList[i].ToString()))
                //                    {
                //                        fileName1 = fileName1.Replace(CharList[i].ToString(), "");
                //                    }
                //                }
                //                int IsFileValid = 1;
                //                string[] extensionList;
                //                extensionList = fileName.Split('.');
                //                if (extensionList.Length > 2)
                //                {
                //                    IsFileValid = 0;
                //                }

                //                if (fileName == fileName1 && IsFileValid == 1)
                //                {
                //                    byte[] buffer = new byte[257];

                //                    string MimeType = "";
                //                    HttpPostedFile file = System.Web.HttpContext.Current.Request.Files[0];
                //                    //var strFileType = "";
                //                    var strFileType = getMimeFromFile(HttpContext.Current.Request.Files[0]);
                //                    file.InputStream.Read(buffer, 0, 256);
                //                    file.InputStream.Position = 0;
                //                    string magicNumber = BitConverter.ToString(buffer);
                //                    magicNumber = magicNumber.Replace("-", " ");
                //                    XmlDocument xmlDoc = new XmlDocument();
                //                    //string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory);
                //                    string xmlPath = CommonFunctions.FileDirectory.CleanPath(System.IO.Directory.GetParent(System.IO.Directory.GetParent(System.AppDomain.CurrentDomain.BaseDirectory).FullName).FullName);
                //                    xmlDoc.Load(xmlPath + "MIMEType.xml");
                //                    XmlNodeList nodes = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME");
                //                    string xMagicNumber = "";
                //                    string xContentType = "";
                //                    string extfromContentType = "";



                //                    foreach (XmlNode node in nodes)
                //                    {
                //                        xContentType = node.SelectSingleNode("ContentType").InnerText;
                //                        if (strFileType == xContentType)
                //                        {
                //                            fileName = HttpContext.Current.Request.Files[0].FileName;
                //                            string ext = Path.GetExtension(fileName);
                //                            ext = ext.Substring(1, ext.Length - 1).ToLower();
                //                            extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower();
                //                            if (extfromContentType.IndexOf(ext) > -1)
                //                            {
                //                                MimeType = strFileType;
                //                                break;
                //                            }
                //                        }
                //                    }

                //                    // End of comment by imran on 02-01-2022
                //                }
                //                else
                //                {
                //                    MimeType = "";
                //                }
                //                if (MimeType == "" || MimeType == null)
                //                {
                //                    MimeType = "unknown/unknowns";
                //                    fileUploadFlag = false;
                //                }
                //                if (strListofTypes.IndexOf(MimeType) > -1)
                //                {
                //                    fileUploadFlag = true;
                //                }
                //                //    if (MimeType == null || MimeType == "")
                //                //{
                //                //    MimeType = "unknown/unknowns";
                //                //    fileUploadFlag = false;
                //                //}
                //                ////if (strListofTypes.IndexOf(MimeType) > -1)
                //                //if (strListofTypes.IndexOf(MimeType) == -1)
                //                //{
                //                //    fileUploadFlag = false;
                //                //}
                //                //else
                //                //{
                //                //    fileUploadFlag = true;
                //                //}
                //                //Else condition added by Chetan M on 15th Feb 2021 for upload file 


                //            }
                //            //}
                //            //catch (Exception)
                //            //{
                //            //    fileUploadFlag = false;

                //            //}
                //        }

                //        return fileUploadFlag;
                }
            catch (Exception ex)
            {
                return ex;
                // return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 31st Oct 2022 For Check File Content Type
        //[DllImport("urlmon.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = false)]
        //[System.Security.SecuritySafeCritical()]

        //public static int FindMimeFromData(IntPtr pBC, [MarshalAs(UnmanagedType.LPWStr)] string pwzUrl, [MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.I1, SizeParamIndex = 3)] byte[] pBuffer, int cbSize, [MarshalAs(UnmanagedType.LPWStr)] string pwzMimeProposed, int dwMimeFlags, ref IntPtr ppwzMimeOut, int dwReserved)
        //{
        //}

        [DllImport("urlmon.dll", CharSet = CharSet.Unicode, ExactSpelling = true, SetLastError = false)]
        static extern int FindMimeFromData(IntPtr pBC, [MarshalAs(UnmanagedType.LPWStr)] string pwzUrl, [MarshalAs(UnmanagedType.LPArray, ArraySubType = UnmanagedType.I1, SizeParamIndex = 3)] byte[] pBuffer, int cbSize, [MarshalAs(UnmanagedType.LPWStr)] string pwzMimeProposed, int dwMimeFlags, out IntPtr ppwzMimeOut, int dwReserved);

        [System.Security.SecuritySafeCritical()]
        public static string getMimeFromFile(HttpPostedFile file)
        {
            IntPtr mimeout; int MaxContent = (int)file.ContentLength;
            if (MaxContent > 200)
                MaxContent = 200;
            byte[] buf = new byte[MaxContent];
            file.InputStream.Read(buf, 0, MaxContent);
            int result = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, null, 0, out mimeout, 0);
            if (result != 0)
            {
                Marshal.FreeCoTaskMem(mimeout); return "";
            }
            string mime = Marshal.PtrToStringUni(mimeout);
            Marshal.FreeCoTaskMem(mimeout); return mime.ToLower();
        }

        /// <summary>
        ///Get Iteration Name List DropDown Combo
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        string Filed, Type, ProjectId, CorporateValue;
        bool IsCurrentProjectStatus;
        string Value;
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public object SaveIssue([FromBody] object[] Allvalue)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveIssue([FromBody] string Allvalue)
        {
            try {
                //string Type;
                // string ProjectId;
                string[] allvalue;
                allvalue = Allvalue.Split(',');
                for (int i = 0; i < allvalue.Length; i++)
            {
                //string getvalue = allvalue[i].ToString();
                string getvalue = allvalue[i];
                int endvalue = getvalue.IndexOf("=");
                string getFiled = getvalue.Substring(0, endvalue).ToString();
                if (getFiled == "CustomerIssueID1")
                {
                    getFiled = "CustomerIssueID";
                }
                Filed += getFiled + ",";

                string getFiledValue = getvalue.Substring(endvalue + 1, getvalue.Length - endvalue - 1).ToString();
                getFiledValue = HttpUtility.UrlDecode(getFiledValue);
                //Added By Dipali V On 3rd Feb 2026 For encodeURI issue - decode Summary/Description until stable to handle single or double encoding
                if (getFiled == "Summary" || getFiled == "Description")
                {
                    string prev = "";
                    while (prev != getFiledValue)
                    {
                        prev = getFiledValue;
                        getFiledValue = HttpUtility.UrlDecode(getFiledValue);
                    }
                }
                if (getFiled == "ShowToCustomer" || getFiled == "ProjectID" || getFiled == "CustomerIssueID" || getFiled == "CustomerID" || getFiled == "Product" || getFiled == "Module" || getFiled == "CodedBy" || getFiled == "AssignTo" || getFiled == "RootCauseID" || getFiled == "DeliverableID" || getFiled == "ProductVersionID" || getFiled == "ComponentID" || getFiled == "CustomerID" || getFiled == "ReleaseID" || getFiled == "IterationID" || getFiled == "UserStoryID" || getFiled == "Module" || getFiled == "ChangeRequestID" || getFiled == "CustomerIssueID1")
                {
                    if (getFiled == "ProjectID")
                    {
                        ProjectId = getFiledValue;
                    }
                    //For CustomIssue ID saving Issue by Dipali V On 18th Sep 2019 
                    if (getFiled == "CustomerIssueID")
                    {
                        if (getFiledValue == "null")
                        {
                            Value += "NULL" + ",";
                        }
                        else
                        {
                            Value += "'" + getFiledValue + "'" + ",";
                        }
                        //Value += "'" + getFiledValue + "'" + ",";
                    }
                    else
                    {
                        if (getFiledValue == "null")
                        {
                            Value += "NULL" + ",";
                        }
                        else
                        {
                            Value += getFiledValue + ",";
                        }
                        //Value += getFiledValue + ",";
                    }
                    //End of For CustomIssue ID saving Issue by Dipali V On 18th Sep 2019 
                }
                else
                {
                    if (getFiled == "ReportedBy")
                    {

                        Filed += "CreatorOrModifier" + ",";
                        Value += "'" + getFiledValue + "'" + "," + "'" + getFiledValue + "'" + ",";


                    }
                    //else if (getFiled == "ReportedDate" || getFiled == "ReportedTime") { 

                    //    if (getFiled == "ReportedDate")
                    //    {
                    //        Filed += "StatusChangeDate" + ",";
                    //        Value += "'" + getFiledValue + "'" + "," + "'" + getFiledValue + "'" + ",";
                    //    }
                    //    if (getFiled == "ReportedTime")
                    //    {
                    //        Filed += "StatusChangeTime" + ",";
                    //        Value += "'" + getFiledValue + "'" + "," + "'" + getFiledValue + "'" + ",";
                    //    }


                    else if (getFiled == "Type" || getFiled == "SubType" || getFiled == "Priority" || getFiled == "Status" || getFiled == "Severity" || getFiled == "Complexity")
                    {
                        if (getFiled == "Type")
                        {
                            strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Type','" + getFiledValue + "'," + ProjectId;
                            Type = getFiledValue;
                        }
                        if (getFiled == "SubType")
                        {
                            strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'SubType','" + getFiledValue + "'," + ProjectId + ",'" + Type + "'";
                        }
                        if (getFiled == "Status")
                        {
                            strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Status','" + getFiledValue + "'," + ProjectId + ",'" + Type + "'";
                        }
                        if (getFiled == "Priority")
                        {
                            strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Priority','" + getFiledValue + "'," + ProjectId;
                        }
                        if (getFiled == "Severity")
                        {
                            strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Severity','" + getFiledValue + "'," + ProjectId;
                        }
                        if (getFiled == "Complexity")
                        {
                            strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Complexity','" + getFiledValue + "'," + ProjectId;
                        }
                        DataTable GetCorporateValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                        foreach (DataRow rowCorporateValue in GetCorporateValue.Rows)
                        {

                            CorporateValue = CommonFunctions.Data.CheckIsDBNull(rowCorporateValue["CorporateValue"], "0").ToString();
                            IsCurrentProjectStatus = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowCorporateValue["IsCurrentProjectStatus"], "false"));


                        }
                        if (IsCurrentProjectStatus == true)
                        {
                            Filed += "Corporate" + getFiled + ",";
                            if (getFiledValue == "null")
                            {
                                Value += "NULL" + "," + "NULL" + ",";

                            }
                            else
                            {
                                Value += "'" + getFiledValue + "'" + "," + "'" + CorporateValue + "'" + ",";
                            }

                        }

                        //   Filed += "Corporate" + getFiled + ",";
                        // Value += "'" + getFiledValue + "'" + "," + "'" + getFiledValue + "'" + ",";

                    }
                    else
                    {
                        if (getFiledValue == "null")
                        {
                            Value += "NULL" + ",";
                        }
                        else
                        {
                            Value += "'" + getFiledValue + "'" + ",";
                        }
                    }


                }
            }
            //object issueid="";
            Filed += "ReviewActionID";
            //Filed = Filed.Remove(Filed.Length - 1);
            Value += "'" + 0 + "'";
            //Value = Value.Remove(Value.Length - 1);



            //Commented & Added By Dipali V On 3rd Sepp 2020 For Inline Query to SP Conversion
            //string strquery = "INSERT INTO tbl_IB_Issue (" + Filed + ")VALUES(" + Value + "); Select SCOPE_IDENTITY()";
            string strquery = "usp_whizible2_Ins_tbl_ib_issue '" + Filed + "','" + Value.Replace("'", "''") + "'";
            object issueid = CommonFunctions.Data.GetDataScalar(strquery, true, CommonController.connectionString);
            //End of Commented & Added By Dipali V On 3rd Sepp 2020 For Inline Query to SP Conversion
            //Getting Email messages
            string Flag = "0";
            string strFromEmailID = "";
            string strToEmailID = "";
            string strCCToEmailID = "";
            string strSubject = "", strMessage = "";
            bool blnSendEmail, blnShowPopup;
            DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 8", true, CommonController.connectionString);
            foreach (DataRow mailRow in EmailDataTable.Rows)
            {
                blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                if (blnSendEmail == true)
                {
                    if (blnShowPopup == true)
                    {
                        Flag = "1";
                    }
                    else
                    {

                        EmailMessagesController.GetEmailMessage_8(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, Convert.ToInt32(issueid), Convert.ToInt32(ProjectId), 61);
                        EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                    }

                }
            }

            return issueid;
        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }






        /// <summary>
        ///File Upload 
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        //public HttpResponseMessage FileUplaod()
        string filename;
        [Authorize]
        [HttpPost]
        public object FileUplaod()
        {
            try
            {
                // string[] NewfileName = new string[5];
                HttpResponseMessage result = null;

                var httpRequest = HttpContext.Current.Request;
                var filesNames = new List<string>();
                // Check if files are available
                if (httpRequest.Files.Count > 0)
                {

                    var files = new List<string>();

                    // interate the files and save on the server
                    foreach (string file in httpRequest.Files)
                    {

                        var postedFile = httpRequest.Files[file];
                        // string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()+"."+postedFile.FileName.Remove(0,postedFile.FileName.IndexOf(".")-1);
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        filename = postedFile.FileName;
                        //sa = sa.Select(s => s.Replace("\"", "")).ToArray();
                        filename = filename.Replace(filename.Substring(0, filename.IndexOf(".") - 1), strFileName);
                        //File.Move(postedFile.FileName, strFileName);
                        //  var filePath = HttpContext.Current.Server.MapPath("~/" + postedFile.FileName);
                        var filePath = HttpContext.Current.Server.MapPath("~/" + filename);
                        filePath = filePath.Replace("WhizibleAPIService", "ATTACHMENTS\\BTS");
                        postedFile.SaveAs(filePath);
                        filesNames.Add(filename);
                        files.Add(filePath);

                    }


                    result = Request.CreateResponse(HttpStatusCode.Created, files);
                }
                else
                {


                    result = Request.CreateResponse(HttpStatusCode.BadRequest);
                }

                return filesNames;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /// <summary>
        ///File Upload 
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        //public HttpResponseMessage FileUplaod()
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]
        //public object FileUplaodSaveDB([FromBody]object[] UploadFileParameter)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object FileUplaodSaveDB([FromBody] UploadFileParameter uploadFileParameter)
        {
            try
            {
                //strSQL = "exec usp_Whizible2_Ins_tbl_IB_Attachments " + Convert.ToInt32(UploadFileParameter[0].ToString()) + ",NULL ," + Convert.ToInt32(UploadFileParameter[1].ToString()) + ",'" + UploadFileParameter[2].ToString() + "','" + UploadFileParameter[3].ToString() + "','" + UploadFileParameter[4].ToString() + "','" + UploadFileParameter[5].ToString().Replace("'", "''") + "'";
                strSQL = "exec usp_Whizible2_Ins_tbl_IB_Attachments " + Convert.ToInt32(uploadFileParameter.issueid.ToString()) + ",NULL ," + Convert.ToInt32(uploadFileParameter.EmployeeId.ToString()) + ",'" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.LoginType.ToString(), "") + "','" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.NewFileName.ToString(), "") + "','" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.oldFileName.ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.comment.ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "',0," + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.DocumentTypeID.ToString(), "0") + "," + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.DocumentSubTypeID.ToString(), "0") + "";
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return "Successfully uploaded file";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /// <summary>
        ///Defualt value 
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        //public HttpResponseMessage FileUplaod()
        string DefaultType, DefaultSubType, DefaultStatus, SubType, Status, Priority, ResponsiblePerson, DefaultPriority, Severity, DefaultSeverity, Complexity, DefaultComplexity, Phase, CurrentPhase;
        bool checkDefault;
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object DefaultValue([FromBody] ParameterDeafultValue parameter)
        {
            try {
               // string ProjectId = parameter.ProjectId.ToString();
                //Added by Rehan C for Version Upgrade Issues on 13th Feb 2023
                string type = "";
                type =  parameter.Type;
                //End of by Rehan C for Version Upgrade Issues on 13th Feb 2023
                DataTable GetDefaultValue;
                if (parameter.ProjectId == null)
                {
                     

                    //strSQL = "exec usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'T'," + Convert.ToInt32(ProjectId);
                    strSQL = "exec usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'T'," + Convert.ToInt32(parameter.ProjectId);
                    GetDefaultValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    foreach (DataRow rowDefaultValue in GetDefaultValue.Rows)
                    {

                        Type = CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["Type"], "0").ToString();
                        checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultType"], "false"));


                    }
                    if (checkDefault == true)
                    {
                        DefaultType = Type;

                    }
                    GetDefaultValue.Clear();
                }
                else
                {
                    Type = type; //Added by Rehan C for Version Upgrade Issues on 13th Feb 2023
                    DefaultType = Type;
                }
                //strSQL = "exec usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'S'," + Convert.ToInt32(ProjectId) + ",'" + Type + "'";
                strSQL = "exec usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'S'," + Convert.ToInt32(parameter.ProjectId) + ",'" + Type + "'";
                GetDefaultValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow rowDefaultValue in GetDefaultValue.Rows)
                {

                    SubType = CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["SubType"], "0").ToString();
                    checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultSubType"], "false"));


                }
                if (checkDefault == true)
                {
                    DefaultSubType = SubType;

                }
                GetDefaultValue.Clear();
                //strSQL = "exec usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'ST'," + Convert.ToInt32(ProjectId) + ",'" + Type + "'";
                strSQL = "exec usp_Whizible2_Sel_IB_GetDefault_Type_Status_SubType 'ST'," + Convert.ToInt32(parameter.ProjectId) + ",'" + Type + "'";
                GetDefaultValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow rowDefaultValue in GetDefaultValue.Rows)
                {

                    Status = CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["Status"], "0").ToString();
                    checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultStatus"], "false"));


                }
                if (checkDefault == true)
                {
                    DefaultStatus = Status;

                }
                //strSQL = "exec usp_Whizible2_sel_tbl_ib_TypeResponsiblePerson " + Convert.ToInt32(ProjectId);
                strSQL = "exec usp_Whizible2_sel_tbl_ib_TypeResponsiblePerson " + Convert.ToInt32(parameter.ProjectId);
                ResponsiblePerson = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();

                GetDefaultValue.Clear();

                //strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Priorities " + Convert.ToInt32(ProjectId) + ",1";
                strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Priorities " + Convert.ToInt32(parameter.ProjectId) + ",1";
                GetDefaultValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow rowDefaultValue in GetDefaultValue.Rows)
                {

                    Priority = CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["Priority"], "0").ToString();
                    checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultPriority"], "false"));


                }
                if (checkDefault == true)
                {
                    DefaultPriority = Priority;

                }

                GetDefaultValue.Clear();

                //strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Severity " + Convert.ToInt32(ProjectId) + ",1";
                strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Severity " + Convert.ToInt32(parameter.ProjectId) + ",1";
                GetDefaultValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow rowDefaultValue in GetDefaultValue.Rows)
                {

                    Severity = CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["Severity"], "0").ToString();
                    checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultSeverity"], "false"));


                }
                if (checkDefault == true)
                {
                    DefaultSeverity = Severity;

                }

                GetDefaultValue.Clear();

                //strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Complexity " + Convert.ToInt32(ProjectId) + ",1";
                strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Complexity " + Convert.ToInt32(parameter.ProjectId) + ",1";
                GetDefaultValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow rowDefaultValue in GetDefaultValue.Rows)
                {

                    Complexity = CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["Complexity"], "0").ToString();
                    checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultComplexity"], "false"));


                }
                if (checkDefault == true)
                {
                    DefaultComplexity = Complexity;

                }

                GetDefaultValue.Clear();


                //strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup " + Convert.ToInt32(ProjectId);
                strSQL = "exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup " + Convert.ToInt32(parameter.ProjectId);

                GetDefaultValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                foreach (DataRow rowDefaultValue in GetDefaultValue.Rows)
                {

                    Phase = CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["Phase"], "0").ToString();
                    checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["CurrentPhase"], "false"));


                }
                if (checkDefault == true)
                {
                    CurrentPhase = Phase;

                }

                string[] Defaultvalue = { DefaultType, DefaultSubType, DefaultStatus, ResponsiblePerson, DefaultPriority, DefaultSeverity, DefaultComplexity, CurrentPhase };
                return Defaultvalue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex);
            }
        }


        /// <summary>
        ///Defualt value 
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        //public HttpResponseMessage FileUplaod()

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetMailData([FromBody]MailData_NewIssue mailData)
        {
            try
            {
                MailData_NewIssue maildata = new MailData_NewIssue();
                DataTable data;
                ////string To, From, CC, Subject, MessageBody;
                //strSQL = "exec usp_tbl_Sel_EmployeeInfo " + Convert.ToInt32(mailData.EmployeeId);
                //data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //foreach (DataRow rowValue in data.Rows)
                //{

                //    maildata.From = CommonFunctions.Data.CheckIsDBNull(rowValue["EmailID"], "abc@gmail.com").ToString();
                //    //checkDefault = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowDefaultValue["DefaultStatus"], "false"));

                //}
                //data.Clear();
                //strSQL = "SELECT ISNULL(EmailID,'') FROM tbl_PM_Employee WITH (NOLOCK) WHERE ISNULL(Status,0) = 0 AND EmployeeID ="+mailData.CodeBy;
                //maildata.To =CommonFunctions.Data.GetDataScalar(strSQL,true,CommonController.connectionString).ToString();
                strSQL = "exec  usp_Whizible2_Sel_tbl_PM_EmailMessages 8," + mailData.ProjectId;
                data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow row in data.Rows)
                {
                    maildata.SendMail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(row["SendMail"], "false"));
                    maildata.ShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(row["ShowPopup"], "false"));
                }

                return maildata;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///check special charter 
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private bool ChkSpecialChar(object[] val)
        {
            for (int j = 0; j < val.Length; j++)
            {
                if (val[j] != null)
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
            }

            //int cnt = 0;
            //val.ToList().ForEach(val1=> {
            //    lstSpecialCharacters.ToList().ForEach(val2=> {
            //        result = val1.ToString().Contains(val2);
            //        if (result==true)
            //        {
            //            Array.Clear(val, 0, val.Length);

            //        }
            //    });
            //});


            return result;
        }



    }

    public class Parameterversion
    {
        public int intProjectID { get; set; }

    }
}
