using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.Issue;
using CommonFunctions;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Web;
using System.IO;
using Newtonsoft.Json;

using System.Runtime.InteropServices;



namespace WhizibleAPI.Controllers
{

    public class IB_IssueDetailsController : ApiController
    {


        string SpecialCharacters;

        string[] lstSpecialCharacters;

        public IB_IssueDetailsController()
        {
            SpecialCharacters = ConfigurationManager.AppSettings["SpecialCharactersList"];
            lstSpecialCharacters = Regex.Split(SpecialCharacters, ",");

        }



        /// <summary>
        /// generate token
        /// </summary>
        /// <param>validatedparameter</param>
        /// <returns>validatetoken</returns>
         ////Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        [HttpPost]

        public object generateToken([FromBody]string validatedparameter)
        {
            try
            {
                string generatetoken = CommonFunctions.Security.Token.GetToken(validatedparameter);

                // object validatetoken = CommonFunctions.Security.Token.ValidateToken(validatedparameter, generatetoken);

                return generatetoken;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }





        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ValidatedToken([FromBody]string validatedparameter)
        {
            try
            {
                string generatetoken = CommonFunctions.Security.Token.GetToken(validatedparameter);

                object validatetoken = CommonFunctions.Security.Token.ValidateToken(validatedparameter, generatetoken);

                return validatetoken;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        // =====================================================================
        // Function Name         : 
        // Purpose               : Display Issue Detilas
        //Description            : same as above
        // Parameters Passed     : None
        // Returns               : string
        // Parameters Affected   : 
        // Assumptions           : 
        // Dependencies          : 
        // Author                :Chetan Muley
        // Created               : 
        // Revisions             :
        //=====================================================================
        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        public object GetIssueDetails([FromBody]IssuesPara IssueDetailsPass)
        {
            try
            {
                DataTable IssueDetailsData;
                IB_IssueDetails AllIssueDetails = new IB_IssueDetails();

                AllIssueDetails.GetIssueDetailsData = new List<GetIssueDetails>();

                IssueDetailsData = CommonFunctions.Data.GetDataTable("usp_whizible2_Sel_tbl_IB_Issue " + IssueDetailsPass.intIssueidID + "," + IssueDetailsPass.EmployeeID + "", true, CommonController.connectionString);

                foreach (DataRow drIssueDetailList in IssueDetailsData.Rows)
                {
                    GetIssueDetails IssueDetailList = new GetIssueDetails()
                    {
                        ProjectID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ProjectID"], " ")),


                        Summary = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Summary"], " ")),
                        Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Description"], "")),
                        ReportedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ReportedBy"], "")),
                        ReleaseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ReleaseID"], " ")),
                        IterationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["IterationID"], " ")),
                        UserStoryID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["UserStoryID"], " ")),
                        ReportedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ReportedDate"], "")),
                        Duedate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Duedate"], "")),
                        Type = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Type"], "")),
                        ReportedTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ReportedTime"], "")),
                        Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Status"], "")),
                        SubType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["SubType"], "")),
                        StatusChangeDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["StatusChangeDate"], "")),
                        StatusChangeTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["StatusChangeTime"], "")),
                        CRMQueryID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["CRMQueryID"], "")),

                        Priority = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Priority"], "")),
                        Severity = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Severity"], "")),
                        Complexity = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Complexity"], "")),
                        RootCauseID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["RootCauseID"], "")),
                        DeliverableID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["DeliverableID"], "0")),
                        ModuleName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ModuleName"], "")),
                        ChangeRequestID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ChangeRequestID"], "")),
                        CodedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["CodedBy"], "")),
                        //AssignTo = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["AssignTo"], "")),
                        AssignTo = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["AssignTo"], "0")),
                        ReportedInVersion = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ReportedInVersion"], "")),
                        CorrectedInVersion = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["CorrectedInVersion"], "")),
                        Phase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Phase"], "")),
                        FoundInPhase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["FoundInPhase"], "")),
                        FixedInPhase = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["FixedInPhase"], "")),
                        ImportID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ImportID"], " ")),
                        CustomerIssueID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["CustomerIssueID"], " ")),
                        ProductVersionID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ProductVersionID"], "0")),
                        //ShowToCustomer =Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ProductVersionID"], "true")),
                        ShowToCustomer = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ShowToCustomer"], " ")),
                        Hardware = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Hardware"], " ")),
                        OS = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["OS"], " ")),
                        Kernel = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Kernel"], " ")),
                        Keywords = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Keywords"], " ")),
                        Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["Flag"], "")),

                        //Added by imran on 23-11-2021 to set value to combobox of Product Fields 
                        CustomerID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["CustomerID"], "0")),
                        ComponentID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ComponentID"], "0")),
                        //End comment by imran 23-11-2021
                        //Added BY Rutuja D. on 10 Feb 2022
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drIssueDetailList["ProjectName"], "")),
                        //End of Added BY Rutuja D. on 10 Feb 2022
                    };

                    AllIssueDetails.GetIssueDetailsData.Add(IssueDetailList);
                }

                return AllIssueDetails;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



       [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object valdateTokendata([FromBody]IssuesPara ValidateTokenDetails)
        {
            try
            {
                string m_ValidateAccess = "";

                //string Access = "";
                bool str1 = (ValidateTokenDetails.m_strToken == "") && (Convert.ToString(ValidateTokenDetails.strIssue) != "0");
                bool str2 = (Convert.ToString(ValidateTokenDetails.strIssue) != "0") && (CommonFunctions.Security.Token.ValidateToken((Convert.ToString(ValidateTokenDetails.strIssue)) + (Convert.ToString(ValidateTokenDetails.EmployeeID)) + "0" + "0", Convert.ToString(ValidateTokenDetails.m_strToken)) == false);
                if (str1 || str2)
                {
                    //Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Details", 0, 0, "Issue ID", CType(m_strIssueID, String))
                    m_ValidateAccess = "1";


                }

                return m_ValidateAccess;
            }            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        int LayOutId;
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<LayoutControl> IssueControlLists([FromBody]newIssueLayOutcontrol layOutcontrol)
        public object IssueControlLists([FromBody] newIssueLayOutcontrol layOutcontrol)

        {
            try
            {
                List<LayoutControl> lstLayoutControl = new List<LayoutControl>();



                object[] inputstring = { layOutcontrol.ProjectId, layOutcontrol.RoleId.ToString() };


                LayoutControl layoutControl1 = new LayoutControl();

                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {

                    layoutControl1.ResultFlag = result1;
                    lstLayoutControl.Add(layoutControl1);
                }
                else
                {
                    string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + layOutcontrol.ProjectId + "," + layOutcontrol.RoleId + ", ''";

                    DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                    foreach (DataRow sdr in taskListTable1.Rows)
                    {
                        //LayoutFlag layoutControlProjectFlag = new LayoutFlag()
                        //{
                        //    layoutProjectFlag = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Flag"].ToString(), "0"))

                        //};
                        LayOutId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["LayoutID"], "0"));


                    }


                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_IssueEntry_Layout_Details NULL," + LayOutId + ",Null,Null,'Edit'";
                    //   List<LayoutControl> lstLayoutControl = new List<LayoutControl>();


                    //DataTable sdr;
                    //sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                    //   lstLayoutControl = (from l in taskListTable select  new LayoutControl { FieldName = l[1] }).ToList();

                    //DataRow[] dataRows = taskListTable.Select().OrderBy(u => u["EmailId"]).ToArray();
                    foreach (DataRow sdr in taskListTable.Rows)
                    {
                        LayoutControl layoutControl = new LayoutControl()
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



        List<int> CustomfileId1 = new List<int>();
        //int CustomFieldID;
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<CustomFiledPloat> PloatCustomFiled([FromBody]CustomFiledPloat customFiled)
        //public object PloatCustomFiled([FromBody] CustomFiledPloat customFiled)
        public object PloatCustomFiled([FromBody] CommonProperty commonProperty)

        {
            try
            {
                List<CustomFiledPloat> cfp = new List<CustomFiledPloat>();
                List<CustomFiledPloat> CustomFieldIDs = new List<CustomFiledPloat>();

                //DateTime ExpectedStartDate, ExpectedEndDate;

                //  string strSQL = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + customFiled.commonProperty.ProjectId + "," + customFiled.commonProperty.RoleId + "," + customFiled.commonProperty.EmployeeId + ",'" + customFiled.commonProperty.LoginType + "'";
                string strSQL = "Exec usp_Whizible2_sel_tbl_IB_RoleCustomFieldSecurity " + commonProperty.ProjectId + "," + commonProperty.RoleId + "," + commonProperty.EmployeeId + ",'" + commonProperty.LoginType + "'";

                IDataReader sdr1;
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
                   // string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.commonProperty.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + commonProperty.ProjectId + ",NULL,1," + "'" + commonProperty.Type + "'";
                    //   strSQL += ProjectId;
                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                    foreach (DataRow sdr in taskListTable.Rows)
                    {
                        if (CustomfileId1.Contains(Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0"))))
                        {
                            CustomFiledPloat layoutControl = new CustomFiledPloat()
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
                                //added By Chetan M On 27th Mar 2020 For Issue ID 23059
                                MaxLength = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxLength"].ToString(), "")),
                                MinValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MinValue"].ToString(), "")),
                                MaxValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxValue"].ToString(), "")),
                                //End Of added By Chetan M On 27th Mar 2020 For Issue ID 23059
                                //IsCustomFieldAssigned = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),
                                //Added By Nikhil Adkar on 19-Jul-2023 for taking the saved value
                                SavedValue = Convert.ToString(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_sel_GetCustomFieldValueForIssue " + commonProperty.IssueID + ",'" + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")) + "'", true, CommonController.connectionString))
                                //End of Added By Nikhil Adkar for taking the saved value

                            };
                            cfp.Add(layoutControl);


                            if (CustomfileId1.Contains(layoutControl.UniqueID))
                            {
                                continue;
                            }
                            else
                            {
                                layoutControl.IsCustomFieldAssigned = "0";
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
                            CustomFiledPloat layoutControl = new CustomFiledPloat()
                            {

                                UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                                UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserGivenCaption"].ToString(), "")),
                                ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationRules"].ToString(), "")),
                                DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")),
                                RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                                ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                                IsCustomFieldAssigned = Convert.ToString(false),
                                //
                                SavedValue = Convert.ToString(CommonFunctions.Data.GetDataScalar("Exec usp_Whizible2_sel_GetCustomFieldValueForIssue " + commonProperty.IssueID + ",'" + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")) + "'", true, CommonController.connectionString))

                                //IsCustomFieldAssigned = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),

                            };
                            cfp.Add(layoutControl);

                            if (CustomfileId1.Contains(layoutControl.UniqueID))
                            {
                                continue;
                            }
                            else
                            {
                                layoutControl.IsCustomFieldAssigned = "0";
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



        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<CustomFiledPloat> GetCustomFiledComboboxValues([FromBody]CustomFiledPloat customFiled)
        //public object GetCustomFiledComboboxValues([FromBody] CustomFiledPloat customFiled)
        public object GetCustomFiledComboboxValues([FromBody] CommonProperty commonProperty)
        {
            try
            {
                List<CustomFiledPloat> cfp = new List<CustomFiledPloat>();

                //string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details " + "'" + customFiled.DatabaseFieldName + "'," + customFiled.commonProperty.ProjectId;
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details " + "'" + commonProperty.DatabaseFieldName + "'," + commonProperty.ProjectId;

                //   strSQL += ProjectId;
                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    CustomFiledPloat layoutControl = new CustomFiledPloat()
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




        List<int> CustomfileId2 = new List<int>();
        //int CustomFieldID;
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<CustomFiledPloat> PloatExtendedCustomFileds([FromBody]CustomFiledPloat customFiled)
        public object PloatExtendedCustomFileds([FromBody] CommonProperty customFiled)
        {
            try
            {
                List<CustomFiledPloat> cfp = new List<CustomFiledPloat>();
                List<CustomFiledPloat> CustomFieldIDs = new List<CustomFiledPloat>();

                //DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_sel_tbl_IB_RoleExtendedCustomFieldSecurity " + customFiled.ProjectId + "," + customFiled.RoleId + "," + customFiled.EmployeeId + ",'" + customFiled.LoginType + "'";

                   //added By Nikhil Adkar on 18-Jul-2023
                string strSavedValue = "";
               
                //End of Added By Nikhil Adkar 18-Jul-2023

                IDataReader sdr1;
                sdr1 = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr1.Read())
                {
                    CustomfileId2.Add(Convert.ToInt32(sdr1["CustomFieldID"]));

                }



                if (customFiled.Type != null)
                {
                    //string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtendedCustomFields " + customFiled.commonProperty.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtendedCustomFields " + customFiled.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                    //   strSQL += ProjectId;
                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                    foreach (DataRow sdr in taskListTable.Rows)
                    {
                        CustomFiledPloat layoutControl = new CustomFiledPloat()
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
                            //Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                            MaxLength = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxLength"].ToString(), "")),
                            MinValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MinValue"].ToString(), "")),
                            MaxValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxValue"].ToString(), "")),
                            //End Of Added By Usha Pandit On 08.04.2021 for MaxLength, MinValue,MaxValue validation
                            //IsCustomFieldAssigned = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),
                            SavedValue = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_GetExtendedCustomFieldValueForIssue " + customFiled.IssueID.ToString() + ",'" + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")) + "'", true, CommonController.connectionString))

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
                }
                else
                {
                    //string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.commonProperty.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master " + customFiled.ProjectId + ",NULL,1," + "'" + customFiled.Type + "'";
                    //   strSQL += ProjectId;
                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                    foreach (DataRow sdr in taskListTable.Rows)
                    {
                        CustomFiledPloat layoutControl = new CustomFiledPloat()
                        {

                            UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                            UserGivenCaption = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserGivenCaption"].ToString(), "")),
                            ValidationRules = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationRules"].ToString(), "")),
                            DatabaseFieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")),
                            RowNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["RowNumber"].ToString(), "0")),
                            ColumnNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["ColumnNumber"].ToString(), "0")),
                            IsCustomFieldAssigned = Convert.ToString(false),
                            SavedValue = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_sel_GetExtendedCustomFieldValueForIssue " + customFiled.IssueID.ToString() + ",'" + Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DatabaseFieldName"].ToString(), "")) + "'", true, CommonController.connectionString))

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
        //public List<CustomFiledPloat> GetExtendedCustomFieldComboboxValues([FromBody]CustomFiledPloat customFiled)
        //Commented & Added By Dipali V On 6th April 2023 For Custom Fileds Values 
          //public object GetExtendedCustomFieldComboboxValues([FromBody] CustomFiledPloat customFiled)
          public object GetExtendedCustomFieldComboboxValues([FromBody] CommonProperty commonProperty)
        //End of Commented & Added By Dipali V On 6th April 2023 For Custom Fileds Values 
        {
            try
            {
                List<CustomFiledPloat> cfp = new List<CustomFiledPloat>();


                //Commented & Added By Dipali V On 6th April 2023 For Custom Fileds Values 
                //string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtendedCustomFields_Details " + "'" + customFiled.DatabaseFieldName.Replace("'", "''") + "'," + customFiled.commonProperty.ProjectId;
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtendedCustomFields_Details " + "'" + commonProperty.DatabaseFieldName.Replace("'", "''") + "'," + commonProperty.ProjectId;
                //End of Commented & Added By Dipali V On 6th April 2023 For Custom Fileds Values 
                //   strSQL += ProjectId;
                DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                //Added By Usha Pandit On 10.09.2020 For getting Default value for extended custom field
                bool blnDefaultValue = false;
                foreach (DataColumn col in taskListTable.Columns)
                {
                    if (col.ColumnName == "DefaultValue")
                    {
                        blnDefaultValue = true;
                    }
                }
                //End Of Added By Usha Pandit On 10.09.2020 For getting Default value for extended custom field

                foreach (DataRow sdr in taskListTable.Rows)
                {
                    //Commented And Added By Usha Pandit On 10.08.2020 For getting Default value for extended custom field

                    //CustomFiledPloat layoutControl = new CustomFiledPloat()
                    //{
                    //    FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldID"].ToString(), "")),
                    //    FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
                    //    Commented And Added By Usha Pandit On 03.04.2020 For Blank field issue
                    //    UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                    //    UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0").ToString() != "" ? CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0") : "0"),
                    //    End Of Added By Usha Pandit On 03.04.2020 For Blank field issue               
                    //};
                    //cfp.Add(layoutControl);
                    if (blnDefaultValue == true)
                    {
                        CustomFiledPloat layoutControl = new CustomFiledPloat()
                        {
                            FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldID"].ToString(), "")),
                            FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["FieldName"].ToString(), "")),
                            //Commented And Added By Usha Pandit On 03.04.2020 For Blank field issue
                            //UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0")),
                            UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0").ToString() != "" ? CommonFunctions.Data.CheckIsDBNull(sdr["UniqueID"].ToString(), "0") : "0"),
                            //End Of Added By Usha Pandit On 03.04.2020 For Blank field issue

                            DefaultValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DefaultValue"].ToString(), "")),
                        };
                        cfp.Add(layoutControl);
                    }
                    else
                    {
                        CustomFiledPloat layoutControl = new CustomFiledPloat()
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

                    //End Of Added By Usha Pandit On 10.09.2020 For getting Default value for extended custom field                

                }
                return cfp;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

            
        }

        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetValidationForCustomFields([FromBody]string ValidationRule)
        {
            try
            {
                ValidationRule = ValidationRule.Replace(",", "");

                List<ValidationData> ValidationData = new List<ValidationData>();

                string strsql = "Exec usp_Whizible2_sel_tbl_UI_Validation_ValidationID ";

                DataTable ValidationDataTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);

                foreach (DataRow sdr in ValidationDataTable.Rows)
                {
                    ValidationData ValidationDataControl = new ValidationData()
                    {

                        ValidationID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationID"].ToString(), "")),
                        //ValidationDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationDescription"].ToString(), "")),
                        ValidationMessage = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ValidationMessage"].ToString(), "")),
                        //CreatedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CreatedBy"].ToString(), "")),
                        //CreatedDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["CreatedDate"].ToString(), "")),
                        //OrderNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["OrderNumber"].ToString(), "0")),
                        //IsComparisonRule = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsComparisonRule"].ToString(), "0")),

                    };


                    if (ValidationDataControl.ValidationID == ValidationRule)
                    {
                        ValidationData.Add(ValidationDataControl);
                    }
                    else
                    {

                    }

                }
                return ValidationData;
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
        public object GetAttachmentDetails([FromBody]int IssueID)
        {
            try
            {
                List<IssueData> lstLayoutControl = new List<IssueData>();
                IssueData Status1 = new IssueData();
                string query = "EXEC usp_Whizible2_Sel_tbl_IB_Attachments " + IssueID;
                DataTable AttachmentData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return AttachmentData;
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
        //public object DeleteAttachment([FromBody]int[] AttachmentID)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteAttachment([FromBody]string AttachmentID)
        {
            try
            {
               string[] AttachmentId= AttachmentID.Split(',');
                //Added By Usha Pandit On 22.03.2020 for getting correct result
                object result = "";
                //End Of Added By Usha Pandit On 22.03.2020 for getting correct result
                for (int i = 0; i < AttachmentId.Length; i++)
                {
                    string query = "EXEC usp_Whizible2_Del_tbl_IB_Attachments  NULL," + AttachmentId[i];
                    //string query = "EXEC usp_Whizible2_Del_tbl_IB_Attachments  NULL," + AttachmentId;
                    result = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);
                }
                return result;//2020
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
        public object GetAttachmentForDiscussion([FromBody]int DiscussionID)
        {
            try
            {
                string query = "EXEC usp_Whizible2_Sel_tbl_IB_Discussion_Attachments " + DiscussionID;
                DataTable AttachmentData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return AttachmentData;
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
        //string Project_Flag;
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetLayoutProjectFlag([FromBody]CommonProperty commonProperty)
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
                object IsIssueSLAApplicable = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                //foreach (DataRow sdr in taskListTable.Rows)
                //{
                //    //LayoutFlag layoutControlProjectFlag = new LayoutFlag()
                //    //{
                //    //    layoutProjectFlag = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["Flag"].ToString(), "0"))

                //    //};
                //    Project_Flag = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Flag"].ToString(), "0"));


                //}
                string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + commonProperty.ProjectId + "," + commonProperty.RoleId + ", ''";

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



        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetCustomFieldMasterRowNumber([FromBody]int ProjectID)
        {
            try
            {
                //string layoutid;
                int MaxRow = 0, MaxColoumn = 0;

                string strsql = "Exec usp_Whizible2_sel_tbl_IB_CustomFields_Master_RowNumber " + ProjectID;

                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in CustomControlTable.Rows)
                {
                    MaxRow = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxRows"], "0"));
                    MaxColoumn = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxCols"], "0"));
                }
                object[] GetValue = { MaxRow, MaxColoumn };

                return GetValue;
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
        public object GetExtendedCustomFieldRowNumber([FromBody]int ProjectID)
        {
            try
            {
                //string layoutid;
                int MaxRow = 0, MaxColoumn = 0;

                string strsql = "Exec usp_Whizible2_sel_tbl_IB_ExtendedCustomFields_RowNumber " + ProjectID;

                DataTable CustomControlTable = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in CustomControlTable.Rows)
                {
                    MaxRow = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxRows"], "0"));
                    MaxColoumn = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["MaxCols"], "0"));
                }
                object[] GetValue = { MaxRow, MaxColoumn };

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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<string> GetStartEndDate([FromBody]int ProjectId)
        public object GetStartEndDate([FromBody] int ProjectId)
        {
            try
            {
                DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_GetStartendDate ";
                strSQL += ProjectId;

                List<string> lstprojectstartenddate = new List<string>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {

                    ExpectedStartDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedStartDate"].ToString(), ""));
                    ExpectedEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(sdr["ExpectedEndDate"].ToString(), ""));


                    lstprojectstartenddate.Add(ExpectedStartDate.ToString("dd/MM/yyyy"));
                    lstprojectstartenddate.Add(ExpectedEndDate.ToString("dd/MM/yyyy"));
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpGet]
        public object GetReportedDateTime()
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetReportedBy([FromBody]CommonProperty commonProperty)
        public object GetReportedBy([FromBody] CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                //string strSQL = "Exec usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', "+commonProperty.ProjectId+","+commonProperty.EmployeeId+",1,NULL,NULL,'"+commonProperty.LoginType+ "','New',0";

                if (commonProperty.strMode == "New")
                {
                    strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + commonProperty.ProjectId + "," + commonProperty.EmployeeId + ",1,NULL,NULL,'" + commonProperty.LoginType + "','Edit'," + commonProperty.IssueID;
                }
                else if (commonProperty.strMode == "CopyIssue")
                {
                    strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + commonProperty.ProjectId + "," + commonProperty.EmployeeId + ",1,NULL,NULL,'" + commonProperty.LoginType + "','CopyIssue',0";

                }
                //strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstReportedBy = new List<newIssueLayOutcontrol>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol reportedBy = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["UserName"].ToString(),
                        FieldName = sdr["UserName"].ToString(),
                    };
                    lstReportedBy.Add(reportedBy);
                }

                return lstReportedBy;
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

        //[Authorize]
        //[HttpPost]

        //public string GetEmployeeName([FromBody]int EmployeeID)
        //{

        //    RepotreBY repotreBY = new RepotreBY();


        //    string strSQL = "select * from tbl_PM_Employee where EmployeeID=" + EmployeeID;
        //    // strSQL += ProjectId;

        //    //List<string> lstprojectstartenddate = new List<string>();

        //    IDataReader sdr;
        //    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

        //    while (sdr.Read())
        //    {

        //        repotreBY.EmployeeName = CommonFunctions.Data.CheckIsDBNull(sdr["EmployeeName"].ToString(), "").ToString();

        //    }
        //    return repotreBY.EmployeeName;
        //}

        /// <summary>
        ///get list of Type of current project 
        /// </summary>
        /// <param name="newIssue"></param>
        /// <returns></returns>

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetTypes([FromBody]CommonProperty commonProperty)
        public object GetTypes([FromBody] CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                //string strSQL = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + commonProperty.ProjectId + ", 'T',Null,Null,Null,Null,Null," + commonProperty.RoleId;
                //string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + layOutcontrol.commonProperty.ProjectId + ", 'T',Null,Null,Null,Null,Null," + layOutcontrol.commonProperty.RoleId;
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + commonProperty.ProjectId + ", 'T',Null,Null,Null,Null,Null," + commonProperty.RoleId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstType = new List<newIssueLayOutcontrol>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol type = new newIssueLayOutcontrol()
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

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetSubType([FromBody]newIssueLayOutcontrol newIssue)
        public object GetSubType([FromBody] newIssueLayOutcontrol newIssue)
        // public string GetSubType([FromBody]newIssueLayOutcontrol newIssue)

        {
            try
            {

                List<newIssueLayOutcontrol> lstSubType = new List<newIssueLayOutcontrol>();



                object[] inputstring = { newIssue.ProjectId.ToString(), newIssue.Type };


                newIssueLayOutcontrol subtype1 = new newIssueLayOutcontrol();

                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {

                    subtype1.ResultFlag = result1;
                    lstSubType.Add(subtype1);
                }
                else
                {
                    //Added By Usha Pandit On 20.03.2020 For getting subtype
                    // string strSQL = "Exec usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + newIssue.ProjectId + ", 'S','" + newIssue.Type + "'";
                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + newIssue.ProjectId + ", 'S','" + newIssue.Type + "'";
                    //   strSQL += ProjectId;
                    //End Of Added By Usha Pandit On 20.03.2020 For getting subtype
                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        newIssueLayOutcontrol subtype = new newIssueLayOutcontrol()
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

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetStatus([FromBody]newIssueLayOutcontrol newIssue)
        public object GetStatus([FromBody] newIssueLayOutcontrol newIssue)
        {

            try
            {
                List<newIssueLayOutcontrol> lstStatus = new List<newIssueLayOutcontrol>();



                object[] inputstring = { newIssue.ProjectId.ToString(), newIssue.Type, newIssue.RoleId.ToString() };


                newIssueLayOutcontrol Status1 = new newIssueLayOutcontrol();

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
                    //string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + newIssue.ProjectId + ",'" + newIssue.Type + "',Null, Null,Null" + "," + newIssue.RoleId;
                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + newIssue.ProjectId + ",'" + newIssue.Type + "',Null, Null" + "," + newIssue.RoleId + ",'" + newIssue.Status + "'";
                    //   strSQL += ProjectId;



                    IDataReader sdr;
                    sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    while (sdr.Read())
                    {
                        newIssueLayOutcontrol Status = new newIssueLayOutcontrol()
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

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetProductExecutionProject([FromBody]newIssueLayOutcontrol newIssue)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

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
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        /// <summary>
        ///get list of Kernel of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetKernel([FromBody]CommonProperty commonProperty)
        public object GetKernel([FromBody] CommonProperty commonProperty)
        {
            try
            {
                List<newIssueLayOutcontrol> lstKernel = new List<newIssueLayOutcontrol>();
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Kernels " + commonProperty.ProjectId;

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol kernel1 = new newIssueLayOutcontrol()
                    {
                        FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Kernels"].ToString(), "")),
                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Kernels"].ToString(), "")),
                    };

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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]

        //public List<newIssueLayOutcontrol> GetSeverity([FromBody]CommonProperty commonProperty)
        public object GetSeverity([FromBody] CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Severity " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstseverity = new List<newIssueLayOutcontrol>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol severity = new newIssueLayOutcontrol()
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetComplexity([FromBody]CommonProperty commonProperty)
        public object GetComplexity([FromBody] CommonProperty commonProperty)
        {
            try { 
            // DateTime ExpectedStartDate, ExpectedEndDate;

            string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Complexity " + commonProperty.ProjectId;
            //   strSQL += ProjectId;

            List<newIssueLayOutcontrol> lstComplexity = new List<newIssueLayOutcontrol>();

            IDataReader sdr;
            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

            while (sdr.Read())
            {
                newIssueLayOutcontrol severity = new newIssueLayOutcontrol()
                {
                    FieldID = sdr["FieldId"].ToString(),
                    FieldName = sdr["FieldName"].ToString(),


                };
                lstComplexity.Add(severity);
            }

            return lstComplexity;
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetPriorities([FromBody]CommonProperty commonProperty)
        public object GetPriorities([FromBody] CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Priorities " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstPriorities = new List<newIssueLayOutcontrol>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol Priorities = new newIssueLayOutcontrol()
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

        List<DeliverableClass> DeliverableValues = new List<DeliverableClass>();
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetDeliverable([FromBody]CommonProperty commonProperty)
        public object GetDeliverable([FromBody] CommonProperty commonProperty)
        {
            try { 

            {
                //string strSQL = "Exec usp_Whizible2_sel_tbl_PM_OtherSchedules_Title_ScheduleID " + DeliverableId;
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_OtherSchedules " + commonProperty.ProjectId;

                List<newIssueLayOutcontrol> lstDeliverable = new List<newIssueLayOutcontrol>();


                //object sdr = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                DataTable DeliverableData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow userlistRow in DeliverableData.Rows)
                {
                    newIssueLayOutcontrol DeliverableObj = new newIssueLayOutcontrol()
                    {
                        FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["ScheduleID"], "")),
                        FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Title"], "")),
                    };
                    lstDeliverable.Add(DeliverableObj);
                }


                return lstDeliverable;
            }
        }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        List<IterationClass> IterationValues = new List<IterationClass>();
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetIteration([FromBody]CommonProperty commonProperty)
        public object GetIteration([FromBody] CommonProperty commonProperty)

        {
            try
            {
                {

                    List<newIssueLayOutcontrol> IterationValues = new List<newIssueLayOutcontrol>();
                    string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumIteration_IterationID_IterationName " + commonProperty.IssueID;

                    DataTable IterationData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in IterationData.Rows)
                    {
                        newIssueLayOutcontrol IterationObj = new newIssueLayOutcontrol()
                        {
                            FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["IterationID"], "")),
                            FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["IterationName"], "")),
                        };
                        IterationValues.Add(IterationObj);
                    }


                    return IterationValues;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        List<UserStoryClass> UserStoryValues = new List<UserStoryClass>();
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetUserStory([FromBody] CommonProperty commonProperty)
        public object GetUserStory([FromBody]CommonProperty commonProperty)
        {
            try
            {
                {

                    List<newIssueLayOutcontrol> UserStoryValues = new List<newIssueLayOutcontrol>();
                    string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumUserStory_UserStoryID_UserStoryName " + commonProperty.IssueID;

                    DataTable IterationData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in IterationData.Rows)
                    {
                        newIssueLayOutcontrol UserStoryObj = new newIssueLayOutcontrol()
                        {
                            FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["UserStoryID"], "")),
                            FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["UserStoryName"], "")),
                        };
                        UserStoryValues.Add(UserStoryObj);
                    }


                    return UserStoryValues;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }






        List<DepartmentClass> DepartmentValues = new List<DepartmentClass>();
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetDepartment([FromBody]int ProjectID)
        {
            try
            {
                {

                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details 'CustomFieldCombo1'," + ProjectID;

                    //string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumUserStory_UserStoryID_UserStoryName " + IssueID;

                    DataTable DepartmentData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in DepartmentData.Rows)
                    {
                        DepartmentClass DepartmentObj = new DepartmentClass();

                        DepartmentObj.UniqueID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["UniqueID"], ""));
                        DepartmentObj.FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["FieldName"], ""));

                        DepartmentValues.Add(DepartmentObj);
                    }


                    return DepartmentValues;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        List<CustomerClass> CustomerValues = new List<CustomerClass>();
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetCustomer([FromBody]int ProjectID)
        {
            try
            {
                {

                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details 'CustomFieldCombo2'," + ProjectID;


                    //string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumUserStory_UserStoryID_UserStoryName " + IssueID;

                    DataTable DepartmentData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in DepartmentData.Rows)
                    {
                        CustomerClass CustomerObj = new CustomerClass();

                        CustomerObj.CustomerName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["FieldName"], ""));
                        //DepartmentObj.FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["FieldName"], ""));

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



        List<ModuleNameClass> ModuleNameValues = new List<ModuleNameClass>();
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetModuleNames([FromBody]int ProjectID)
        {
            try
            {
                {

                    string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Details 'CustomFieldCombo3'," + ProjectID;

                    //string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumUserStory_UserStoryID_UserStoryName " + IssueID;

                    DataTable DepartmentData = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in DepartmentData.Rows)
                    {
                        ModuleNameClass ModuleNameObj = new ModuleNameClass();

                        ModuleNameObj.FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["FieldID"], ""));
                        ModuleNameObj.FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["FieldName"], ""));

                        ModuleNameValues.Add(ModuleNameObj);
                    }


                    return ModuleNameValues;
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetRelease([FromBody] CommonProperty commonProperty)
        public object GetRelease([FromBody]CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                // string strSQL = "Exec usp_sel_tbl_PM_ScrumRelease_ReleaseID " + layOutcontrol.commonProperty.ProjectId;
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseID " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstrelease = new List<newIssueLayOutcontrol>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol release = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["ReleaseID"].ToString(),
                        FieldName = sdr["ReleaseName"].ToString(),
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetComponet([FromBody] newIssueLayOutcontrol layOutcontrol)
        {
            try { 
            // DateTime ExpectedStartDate, ExpectedEndDate;

            string strSQL = "Exec usp_sel_tbl_PM_ScrumRelease_ReleaseID " + layOutcontrol.commonProperty.ProjectId;
            //   strSQL += ProjectId;

            List<newIssueLayOutcontrol> lstrelease = new List<newIssueLayOutcontrol>();

            IDataReader sdr;
            sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

            while (sdr.Read())
            {
                newIssueLayOutcontrol release = new newIssueLayOutcontrol()
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

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
       // public object ProductFiledFlag([FromBody]ProductField productField)
        public object ProductFiledFlag([FromBody] CommonProperty commonProperty)
        {

            try
            {
               // string strSQL = "Exec usp__Whizible2_sel_tbl_PM_Project_DeliverableLevelCustomer " + productField.commonProperty.ProjectId;
                string strSQL = "Exec usp__Whizible2_sel_tbl_PM_Project_DeliverableLevelCustomer " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                ProductField field = new ProductField();

                // IDataReader sdr;
                field.FildFlag = Convert.ToBoolean(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //while (sdr.Read())
                //{

                //    field.FildFlag = Convert.ToBoolean(sdr["DeliverableLevelCustomer"]);


                //}

                return field;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///get Productlist bind droup down list
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<ProductField> GetProductList([FromBody]ProductField productField)
        //public object GetProductList([FromBody] ProductField productField)
        public object GetProductList([FromBody] CommonProperty commonProperty)

        { 
            try
            {
                string strSQL;

                if (commonProperty.FildFlag == true)
                {
                    // strSQL = "Exec usp_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId+","+productField.Customerid+ ",NULL,'ProductVersions',NULL";
                    //strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + "," + productField.Customerid + ",NULL,'ProductVersions',NULL";
                    strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + commonProperty.ProjectId + "," + commonProperty.Customerid + ",NULL,'ProductVersions',NULL";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_PRD_ProductVersion_CustomerWise " + commonProperty.EmployeeId + ",'" + commonProperty.LoginType + "'," + commonProperty.LoginId + ",1,NULL,NULL," + commonProperty.ProjectId;

                }

                //   strSQL += ProjectId;

                List<ProductField> lstfield = new List<ProductField>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProductField field = new ProductField()
                    {
                        ProductVersionID = Convert.ToInt32(sdr["ProductVersionID"]),
                        ProductVersion = sdr["ProductVersion"].ToString()
                    };
                    lstfield.Add(field);
                }

                return lstfield;
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

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<ProductField> GetComponetList([FromBody] ProductField productField)
        public object GetComponetList([FromBody]ProductField productField)
        {
            string strSQL;
            try
            {
                CommonProperty commonProperty = new CommonProperty();
                if (productField.FildFlag == true)
                {
                    // strSQL = "Exec usp_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + "," + productField.Customerid + ","+productField.ProductVersionID+ ",NULL,'ProductVersions_Components'";
                    // strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + "," + productField.Customerid + "," + productField.ProductVersionID + ",NULL,'ProductVersions_Components'";
                    strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + commonProperty.ProjectId + "," + productField.Customerid + "," + productField.ProductVersionID + ",NULL,'ProductVersions_Components'";
                }
                else
                {
                    //strSQL = "Exec usp_Sel_ProductVersions_AND_Components " + productField.commonProperty.ProjectId + ",NULL," + productField.ProductVersionID + ",NULL,'ProductVersions_Components'";
                    strSQL = "Exec usp_Whizible2_Sel_ProductVersions_AND_Components " + commonProperty.ProjectId + ",NULL," + productField.ProductVersionID + ",NULL,'ProductVersions_Components'";

                }

                //   strSQL += ProjectId;

                List<ProductField> lstfield = new List<ProductField>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProductField field = new ProductField()
                    {
                        ComponentID = Convert.ToInt32(sdr["ComponentID"]),
                        Component = sdr["Component"].ToString()
                    };
                    lstfield.Add(field);
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<int> GetIssueIds([FromBody]CommonProperty commonProperty)
          public object GetIssueIds([FromBody] CommonProperty commonProperty)
        {

            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_v_tbl_IB_Issue " + commonProperty.ProjectId + "," + commonProperty.EmployeeId;
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
        CopyIssueIDs issueIDs = new CopyIssueIDs();

        public string FieldID { get; private set; }
        public string FieldName { get; private set; }

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object GetFieldValueForIssue([FromBody]CopyIssueIDs copyIssueIDs)
        {
            try
            {
                //string[] strfield = new string[] { "CustomerID", "ProductVersionID", "ComponentID", "Priority", "CustomFieldCombo1", "CustomFieldCombo2", "CustomFieldCombo3","CustomFieldTextArea1", "CustomFieldDate1" };
                string[] strfield = new string[] { "CustomerID", "ProductVersionID", "ComponentID", "CustomFieldText1", "CustomFieldText2", "CustomFieldText3", "CustomFieldText4", "CustomFieldText5", "CustomFieldText6", "CustomFieldText7", "CustomFieldText8", "CustomFieldText9", "CustomFieldText10", "CustomFieldCombo1", "CustomFieldCombo4", "CustomFieldCombo2", "CustomFieldCombo3", "CustomFieldCombo5", "CustomFieldCombo6", "CustomFieldCombo7", "CustomFieldCombo8", "CustomFieldCombo9", "CustomFieldCombo10", "CustomFieldTextArea1", "CustomFieldTextArea2", "CustomFieldTextArea3", "CustomFieldDate1", "CustomFieldDate2", "CustomFieldDate3", "CustomFieldDate4", "CustomFieldDate5" };
                if (strfield.Contains(copyIssueIDs.strFieldName) == true)
                {
                    strSQL = "Exec usp_Whizible2_sel_GetCustomFieldValueForIssue " + copyIssueIDs.issueid + ",'" + copyIssueIDs.strFieldName + "'";
                }

                issueIDs.GetValue = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);



                return issueIDs.GetValue;
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
        public object GetExtFieldValueForIssue([FromBody]CopyIssueIDs copyIssueIDs)
        {
            try
            {
                strSQL = "Exec usp_Whizible2_sel_GetExtendedCustomFieldValueForIssue " + copyIssueIDs.issueid + ",'" + copyIssueIDs.strFieldName + "'";

                issueIDs.GetValue = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetCodedBy([FromBody]CommonProperty commonProperty)
        public object GetCodedBy([FromBody] CommonProperty commonProperty)
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

                List<newIssueLayOutcontrol> lstcodedby = new List<newIssueLayOutcontrol>();


                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol codedby = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["EmployeeID"].ToString(),
                        FieldName = sdr["UserName"].ToString(),
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



        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<RepotreBY> GetResponsiblePerson([FromBody]newIssueLayOutcontrol newIssue)
        public object GetResponsiblePerson([FromBody] newIssueLayOutcontrol newIssue)
        {
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " + newIssue.ProjectId + "," + " NULL ,NULL, NULL, NULL ,'" + newIssue.Type + "','New',0";


                List<RepotreBY> lstcodedby = new List<RepotreBY>();


                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    RepotreBY codedby = new RepotreBY()
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
        ///get list of ProjectRootCause of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetProjectRootCause([FromBody]CommonProperty commonProperty)
        public object GetProjectRootCause([FromBody] CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_RootCause " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstProjectRootCause = new List<newIssueLayOutcontrol>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol ProjectRootCause = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["FieldId"].ToString(),
                        FieldName = sdr["FieldName"].ToString(),


                    };
                    lstProjectRootCause.Add(ProjectRootCause);
                }

                return lstProjectRootCause;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /// <summary>
        ///get list of Module of current project 
        /// </summary>
        /// <param name="commonProperty.ProjectID"></param>
        /// <returns></returns>
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetModule([FromBody]CommonProperty commonProperty)
        public object GetModule([FromBody] CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Module_ProjectGroup " + commonProperty.ProjectId + ",NULL";
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstmodule = new List<newIssueLayOutcontrol>();
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol module = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["ModuleName"].ToString(),
                        FieldName = sdr["ModuleName"].ToString(),
                    };

                    lstmodule.Add(module);
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetChangeRequestMaster([FromBody] CommonProperty commonProperty)
        public object GetChangeRequestMaster([FromBody]CommonProperty commonProperty)
        {
            try
            {
                // DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master " + commonProperty.ProjectId + ",NULL";
                //   strSQL += ProjectId;

                List<newIssueLayOutcontrol> lstChangeRequestMaster = new List<newIssueLayOutcontrol>();
                // string modulename;
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol ChangeRequestMaster = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["ChangeRequestID"].ToString(),
                        FieldName = sdr["ChangeRequestSummary"].ToString(),
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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetProjectVersion([FromBody] CommonProperty commonProperty)
        public object GetProjectVersion([FromBody]CommonProperty commonProperty)
        {
            try
            {
                List<newIssueLayOutcontrol> lstProjectVersion = new List<newIssueLayOutcontrol>();
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Version " + commonProperty.ProjectId;

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol ProjectVersion = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["Versions"].ToString(),
                        FieldName = sdr["Versions"].ToString(),
                    };

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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetPhase([FromBody]CommonProperty commonProperty)
        public object GetPhase([FromBody] CommonProperty commonProperty)
        {
            try
            {
                List<newIssueLayOutcontrol> lstPhase = new List<newIssueLayOutcontrol>();
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup " + commonProperty.ProjectId;

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol Phase = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["Phase"].ToString(),
                        FieldName = sdr["Phase"].ToString(),
                    };

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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<newIssueLayOutcontrol> GetHardware([FromBody]CommonProperty commonProperty)
        public object GetHardware([FromBody] CommonProperty commonProperty)
        {
            try
            {
                List<newIssueLayOutcontrol> lstHardware = new List<newIssueLayOutcontrol>();
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectHardware " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol Hardware = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["Hardware"].ToString(),
                        FieldName = sdr["Hardware"].ToString(),
                    };

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
        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetOS([FromBody]CommonProperty commonProperty)
        {
            try
            {
                List<newIssueLayOutcontrol> lstOS = new List<newIssueLayOutcontrol>();

                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_OS " + commonProperty.ProjectId;
                //   strSQL += ProjectId;

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    newIssueLayOutcontrol os = new newIssueLayOutcontrol()
                    {
                        FieldID = sdr["OS"].ToString(),
                        FieldName = sdr["OS"].ToString(),
                    };

                    lstOS.Add(os);
                }

                return lstOS;
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
                    for (int i = 0; i < lstSpecialCharacters.Length; i++)
                    {
                        result = val[j].ToString().Contains(lstSpecialCharacters[i]);
                        if (result == true)
                        {
                            break;
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

        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpGet]
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
                string[] getdatatime = { Convert.ToDateTime(serverdate).ToString("dd MMM yyyy"), servertime.ToString() };

                return getdatatime;
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
        //public object SaveDiscussionDetails([FromBody]object[] DataValues)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDiscussionDetails([FromBody] SaveDiscussionClass saveDiscussionClass)
        {
            try
            {

                //List<DiscussionDetails> DiscussionObj = new List<DiscussionDetails>();

                //object[] inputstring = { newIssue.IssueID.ToString(), newIssue.UserName, newIssue.CommentTextAreaValue.ToString(), newIssue.ShowToCustomerVal.ToString() };
                //DiscussionDetails Status1 = new DiscussionDetails();            

                //string strSQL = "Exec usp_Whizible2_Ins_tbl_IB_Discussion " + DataValues[0] + ",'" + DataValues[1] + "','" + HttpUtility.UrlDecode(DataValues[2].ToString().Replace("'", "''")) + "','" + HttpUtility.UrlDecode(DataValues[3].ToString().Replace("'", "''")) + "'," + DataValues[4];
                string strSQL = "Exec usp_Whizible2_Ins_tbl_IB_Discussion " + saveDiscussionClass.IssueID + ",'" + saveDiscussionClass.UserName + "','" + HttpUtility.UrlDecode(saveDiscussionClass.CommentTextAreaValue.ToString().Replace("'", "''")) + "','" + HttpUtility.UrlDecode(saveDiscussionClass.StatusValue.ToString().Replace("'", "''")) + "'," + saveDiscussionClass.ShowToCustomerVal;

                object resultDis = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                DataTable EmailDataTable;
                EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 33", true, CommonController.connectionString);
                bool blnSendEmail;
                bool blnShowPopup;
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                string Flag = "";
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
                            Flag = "0";
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }
                    }
                }
                return resultDis + "&&" + Flag;
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
        public object FileUplaod()
        {
            try
            {
                // string[] NewfileName = new string[5];
                HttpResponseMessage result = null;
                var httpRequest = HttpContext.Current.Request;
                int i = 0;
                //Commented & Added By Dipali V On 5th April 2023 For double File Upload
                //string[] FileNames = new string[httpRequest.Files.Count + httpRequest.Files.Count];
                string[] FileNames = new string[httpRequest.Files.Count];
                //End of Commented & Added By Dipali V On 5th April 2023 For double File Upload

                // Check if files are available

                if (httpRequest.Files.Count > 0)
                {

                    var files = new List<string>();

                    // interate the files and save on the server
                    foreach (string file in httpRequest.Files)
                    {
                        var postedFile = httpRequest.Files[file];

                        //Added by Vishal Mane on 10/03/2026 to restrict invalid executable files from server side
                        string validationError;
                        if (!ValidateUploadedFile(postedFile, out validationError))
                        {
                            return Request.CreateResponse(HttpStatusCode.BadRequest, validationError);
                        }
                        //End of Added by Vishal Mane on 10/03/2026 to restrict invalid executable files from server side

                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        //Commented And Added By Usha Pandit On 01.09.2020 For showing only file name in attachment in IE browser
                        //filename = postedFile.FileName;
                        filename = postedFile.FileName;
                        string fileNameIndex = Convert.ToString(Convert.ToInt32(filename.ToString().LastIndexOf("\\")) + 1);
                        filename = filename.Substring(Convert.ToInt32(fileNameIndex));
                        //End Of Added By Usha Pandit On 01.09.2020 For showing only file name in attachment in IE browser
                        //FileNames[i] = filename;
                        //i++;
                        //sa = sa.Select(s => s.Replace("\"", "")).ToArray();
                        //filename = filename.Replace(filename.Substring(0, filename.IndexOf(".") - 1), strFileName);
                        //filename = filename.Replace(filename.Substring(0, filename.IndexOf(".") - 1), filename);
                        //File.Move(postedFile.FileName, strFileName);
                        //  var filePath = HttpContext.Current.Server.MapPath("~/" + postedFile.FileName);
                        var filePath = HttpContext.Current.Server.MapPath("~/" + filename);
                        filePath = filePath.Replace("WhizibleAPIService", "ATTACHMENTS\\BTS");
                        postedFile.SaveAs(filePath);

                        files.Add(filePath);
                        //Commented  & added by dipali V on 9th Sep 2019 for File path Truncated
                        //FileNames[i] = filePath;
                        FileNames[i] = filename;
                        //End of Commented  & added by dipali V on 9th Sep 2019 for File path Truncated
                        i++;
                    }


                    result = Request.CreateResponse(HttpStatusCode.Created, files);
                }

                else
                {


                    result = Request.CreateResponse(HttpStatusCode.BadRequest);
                }


                return FileNames;
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

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        // public object FileUplaodSaveDB([FromBody]object[] UploadFileParameter)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object FileUplaodSaveDB([FromBody] UploadFileParameter uploadFileParameter)
        {
            try 
            {
                //Comment And Added by imran on 18-10-2022
                //strSQL = "exec usp_Whizible2_Ins_tbl_IB_Discussion_Attachments " + Convert.ToInt32(UploadFileParameter[6].ToString()) + "," + Convert.ToInt32(UploadFileParameter[0].ToString()) + ",NULL ," + Convert.ToInt32(UploadFileParameter[1].ToString()) + ",'" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[2].ToString(),"") + "','" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[3].ToString(),"") + "','" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[4].ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[5].ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "'";
                //strSQL = "exec usp_Whizible2_Ins_tbl_IB_Discussion_Attachments " + Convert.ToInt32(UploadFileParameter[6].ToString()) + "," + Convert.ToInt32(UploadFileParameter[0].ToString()) + ",NULL ," + Convert.ToInt32(UploadFileParameter[1].ToString()) + ",'" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[2].ToString(),"") + "','" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[3].ToString(),"") + "','" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[4].ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','" + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[5].ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "',0," + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[7].ToString(), "0") + "," + CommonFunctions.Data.CheckIsDBNull(UploadFileParameter[8].ToString(), "0") + "";
                strSQL = "exec usp_Whizible2_Ins_tbl_IB_Discussion_Attachments " + Convert.ToInt32(uploadFileParameter.DiscussionID.ToString()) + "," + Convert.ToInt32(uploadFileParameter.issueid.ToString()) + ",NULL ," + Convert.ToInt32(uploadFileParameter.EmployeeId.ToString()) + ",'" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.LoginType.ToString(),"") + "','" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.NewFileName.ToString(),"") + "','" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.oldFileName.ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "','" + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.comment.ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n")) + "',0," + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.DocumentTypeID.ToString(), "0") + "," + CommonFunctions.Data.CheckIsDBNull(uploadFileParameter.DocumentSubTypeID.ToString(), "0") + "";
            //End of comment by imran on 18-10-2022
            object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return "Successfully uploaded file";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Vishal Mane on 10/03/2026 to restrict invalid executable files from server side
        public static bool ValidateUploadedFile(HttpPostedFile postedFile, out string errorMessage)
        {
            errorMessage = "";
            try
            {
                if (postedFile == null || postedFile.ContentLength == 0)
                {
                    errorMessage = "File is empty.";
                    return false;
                }

                string fileName = Path.GetFileName(postedFile.FileName);

                // ❗ Prevent multiple extensions (file.php.jpg)
                string[] extensions = fileName.Split('.');
                if (extensions.Length > 2)
                {
                    errorMessage = "Invalid file extension.";
                    return false;
                }

                // ❗ Validate filename characters
                string invalidChars = ConfigurationManager.AppSettings["ValidateFileName"];
                if (!string.IsNullOrEmpty(invalidChars))
                {
                    string[] charList = invalidChars.Split(',');
                    foreach (string ch in charList)
                    {
                        if (fileName.Contains(ch))
                        {
                            errorMessage = "Invalid characters in file name.";
                            return false;
                        }
                    }
                }

                // ❗ Read file header (magic number)
                byte[] buffer = new byte[256];
                postedFile.InputStream.Read(buffer, 0, 256);
                postedFile.InputStream.Position = 0;

                string mimeType = GetMimeFromFile(buffer);

                if (string.IsNullOrEmpty(mimeType))
                    mimeType = "unknown/unknown";

                string allowedTypes = ConfigurationManager.AppSettings["FileContentType"];
                var allowedList = allowedTypes.Split(',')
                                              .Select(t => t.Trim().ToLower())
                                              .ToList();

                string ext = Path.GetExtension(fileName).ToLower();
                string[] allowedExtensions =
                {
                    ".jpg",".jpeg",".png",".pdf",".doc",".docx",
                    ".xls",".xlsx",".ppt",".pptx",".zip",".rar",".txt"
                };

                if (!allowedExtensions.Contains(ext))
                {
                    errorMessage = "Invalid file extension.";
                    return false;
                }
                if (!allowedList.Contains(mimeType.ToLower()) && mimeType != "application/octet-stream")
                {
                    errorMessage = "Invalid file content.";
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
                return false;
            }
        }

        [DllImport("urlmon.dll", CharSet = CharSet.Auto)]
        private static extern uint FindMimeFromData(
            IntPtr pBC,
            [MarshalAs(UnmanagedType.LPWStr)] string pwzUrl,
            [MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 3)] byte[] pBuffer,
            uint cbSize,
            [MarshalAs(UnmanagedType.LPWStr)] string pwzMimeProposed,
            uint dwMimeFlags,
            out IntPtr ppwzMimeOut,
            uint dwReserved
        );
        public static string GetMimeFromFile(byte[] file)
        {
            try
            {
                IntPtr mimeTypePtr;
                FindMimeFromData(IntPtr.Zero, null, file, 256, null, 0, out mimeTypePtr, 0);

                string mime = Marshal.PtrToStringUni(mimeTypePtr);

                Marshal.FreeCoTaskMem(mimeTypePtr);

                return mime;
            }
            catch
            {
                return "unknown/unknown";
            }
        }









        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateIssueStatus([FromBody]object[] DataValues)
        {
            try
            {
                string strSQL = "UPDATE TBL_IB_ISSUE SET Status = '" + DataValues[0] + "', CorporateStatus ='" + DataValues[1] + "' ,  CreatorOrModifier = '" + DataValues[2] + "' ,  LoginType = '" + DataValues[3] + "'  ,  StatusChangeDate = '" + DataValues[4] + "' ,  StatusChangeTime = '" + DataValues[5] + "'   Where IssueID = " + DataValues[6];
                //string strSQL = "Exec usp_Whizible2_Ins_tbl_IB_Discussion " + DataValues[0] + ",'" + DataValues[1] + "','" + DataValues[2] + "'," + DataValues[3];

                object resultDis = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return resultDis;
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
        //public List<DiscussionClass> ShowDiscussionDetails([FromBody]CommonProperty commonProperty)
        public object ShowDiscussionDetails([FromBody] CommonProperty commonProperty)

        {
            try
            {

                List<DiscussionClass> DicussionDetails = new List<DiscussionClass>();


                string strSQL1 = "Exec usp_Whizible2_Sel_IB_tbl_IB_Discussion " + commonProperty.IssueID + ",'" + commonProperty.LoginType + "'";

                DataTable DiscussionTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                foreach (DataRow sdr in DiscussionTable.Rows)
                {
                    DiscussionClass layoutControl = new DiscussionClass()
                    {

                        DiscussionID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["DiscussionID"].ToString(), "0")),
                        DiscussionDate = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["DateOfDiscussion"].ToString(), "")),
                        Comments = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["Comments"].ToString(), "")),
                        UserName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["UserName"].ToString(), "")),
                        ShowToCustomer = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ShowToCustomer"].ToString(), "")),
                        ImageName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ImageName"].ToString(), "")),
                        IsDeleteable = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["IsDeleteable"].ToString(), "0")),
                        //Added By Nikhil Adkar for getting the count of attachment each discussion wise
                        AttachmentCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["AttachmentCount"].ToString(), "0")),
                        //End of added By Nikhil Adkar

                    };
                    DicussionDetails.Add(layoutControl);

                }
                return DicussionDetails;
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
        public object DeleteDiscussion([FromBody]int DiscussionID)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Del_IB_tbl_IB_Discussion " + DiscussionID;

                object resultDis = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return 1;
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
        //public List<ProjectList> GetProjectsForDeliverable([FromBody]int ProjectID)
        public object GetProjectsForDeliverable([FromBody] int ProjectID)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_Project_cboProject ";

                List<ProjectList> Projectdata = new List<ProjectList>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectList Project = new ProjectList()
                    {
                        ProjectId = sdr["ProjectId"].ToString(),
                        ProjectName = sdr["ProjectName"].ToString(),

                    };
                    Projectdata.Add(Project);
                }

                return Projectdata;
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
        //public List<ProjectList> GetDeliverableTypes([FromBody]int ProjectID)
        public object GetDeliverableTypes([FromBody] int ProjectID)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectSchedules_ScheduleID_LabelSchedule " + ProjectID;

                List<ProjectList> DeliverableData = new List<ProjectList>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ProjectList Project = new ProjectList()
                    {
                        ScheduleID = sdr["ScheduleID"].ToString(),
                        LabelSchedule = sdr["LabelSchedule"].ToString(),

                    };
                    DeliverableData.Add(Project);
                }

                return DeliverableData;
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
        //public List<ExpectedDate> GetExpectedStartAndEndDate([FromBody]int ProjectID)
        public object GetExpectedStartAndEndDate([FromBody] int ProjectID)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_Project_ExpectedStartDate_ExpectedEndDate_EstimatedEfforts " + ProjectID;

                List<ExpectedDate> ExpextedDateList = new List<ExpectedDate>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ExpectedDate Dates = new ExpectedDate()
                    {
                        ExpectedStartDate = sdr["ExpectedStartDate"].ToString(),
                        ExpectedEndDate = sdr["ExpectedEndDate"].ToString(),

                    };
                    ExpextedDateList.Add(Dates);
                }

                return ExpextedDateList;
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
        public object ValidateDate([FromBody]GetSelectedQuery Parameters)
        {
            try
            {
                string Strup = "Exec usp_Whizible2_Validate_Project_StartEndDateForAssignIssue " + Parameters.ProjectId + ',' + "'" + Parameters.StartDate + "'";
                string StrSql = Convert.ToString(CommonFunctions.Data.GetDataScalar(Strup, true, CommonController.connectionString));
                return StrSql;
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
        public object ValidateAssignDate([FromBody]GetSelectedQuery Parameters)
        {
            try
            {
                string strReturn = "";
                DateTime dtStartDate = Convert.ToDateTime(Parameters.StartDate);
                DateTime dtEndDate = Convert.ToDateTime(Parameters.EndDate);
                DateTime dtDueDate = Convert.ToDateTime(Parameters.DueDate);
                DateTime dtReportedDate = Convert.ToDateTime(Parameters.ReportedDate);

                if (dtDueDate < dtReportedDate)
                {
                    strReturn = "Due Date should not be less than Reported Date" + "|3";
                }
                else if (dtStartDate > dtEndDate)
                {
                    strReturn = "Start Date should not be greater than End Date" + "|1";
                }
                else if (dtEndDate > dtDueDate)
                {
                    strReturn = "End Date should not be greater than Due Date" + "|2";
                }
                else if (dtStartDate < dtReportedDate)
                {
                    strReturn = "Start Date should not be less than Reported Date" + "|1";
                }
                else
                {

                    //Commented & Added By Dipali V On 5th jan 2022 For Validate Assign Issue with End date of Project & Resource
                    //string strSQL = "Exec usp_Whizible2_Validate_Project_StartEndDateForAssignIssue " + Parameters.ProjectId + ", '" + Parameters.StartDate + "', " + Parameters.EmployeeID;
                    string strSQL = "Exec usp_Whizible2_Validate_Project_StartEndDateForAssignIssue " + Parameters.ProjectId + ", '" + Parameters.StartDate + "', '" + Parameters.EndDate + "'," + Parameters.EmployeeID;
                    strReturn = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    //End of Commented & Added By Dipali V On 5th jan 2022 For Validate Assign Issue with End date of Project & Resource
                    if (strReturn != "")
                    {
                        // strReturn = strReturn;
                    }
                    //strReturn += "|1";
                }

                return strReturn;
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
        public object SaveDeliverable([FromBody]newIssueLayOutcontrol newIssue)
        {
            try
            {
                string strSQL;
                object sdr;
                {
                    //Commented  & Added By Usha P On 3rd April 2020 For Replace space
                    //strSQL = "Insert Into tbl_PM_otherSchedules(ScheduleTypeID,ProjectID,DepartmentID,DocumentNo,CustomerRefNo,Title,DeliverableLCE, StartDate,EarliestStartDate,LatestCompletionDate,ProjectSiteID,Priority,DeliverableSize,DeliverableSizeUnitID,ComplexityID,IncludeInMeasurement,RequestedBy,ResponsiblePerson,Status,IsAcceptanceTestingRequired,PackageID , CustomFieldText1,CustomFieldText2,CustomFieldText3,CustomFieldText4,CustomFieldText5,CustomFieldNumeric1,CustomFieldNumeric2,CustomFieldNumeric3,CustomFieldNumeric4,CustomFieldNumeric5,CustomFieldDate1, CustomFieldDate2, CustomFieldDate3, CustomFieldDate4, CustomFieldDate5, Description)values(" + newIssue.ScheduleTypeID + "," + newIssue.ProjectId + ",null,null,null,'" + newIssue.Title + "',null,'" + newIssue.StartDate + "',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'" + newIssue.Description + "'); Select SCOPE_IDENTITY()";
                    //strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_OtherSchedules @IssueID = " + newIssue.IssueID + ", @ScheduleTypeID = " + newIssue.ScheduleTypeID + ", @ProjectID = " + newIssue.ProjectId + ", @Title = '" + HttpUtility.UrlDecode(newIssue.Title) + "', @StartDate = '" + newIssue.StartDate + "', @Description = '" + HttpUtility.UrlDecode(newIssue.Description) + "', @UserName = '" + newIssue.UserName + "'";
                    strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_OtherSchedules @IssueID = " + newIssue.IssueID + ", @ScheduleTypeID = " + newIssue.ScheduleTypeID + ", @ProjectID = " + newIssue.ProjectId + ", @Title = '" + HttpUtility.UrlDecode(newIssue.Title).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', @StartDate = '" + newIssue.StartDate + "', @Description = '" + HttpUtility.UrlDecode(newIssue.Description) + "', @UserName = '" + newIssue.UserName + "'";
                    sdr = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    //End of Commented  & Added By Usha P On 3rd April 2020 For Replace space
                }

                //strSQL = "UPDATE tbl_IB_Issue SET DeliverableID=" + sdr + "where IssueID =" + newIssue.IssueID;
                //object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                //Added by dipali V On 12th Sep 2019 For Mail pop should be come conditionally
                DataTable EmailDataTable;
                EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 473", true, CommonController.connectionString);
                bool blnSendEmail;
                bool blnShowPopup;
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                string Flag = "";
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
                            Flag = "0";
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }
                    }
                }
                return sdr + "&&" + Flag;
                //End of Added by dipali V On 12th Sep 2019 For Mail pop should be come conditionally
                //return sdr;
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
       // public object GetHistoryInfo([FromBody]string[] historyInfo)
        public object GetHistoryInfo([FromBody] HistoryInfo historyInfo)
        {
            try
            {
                //string Para1 = HistoryInfo[0];
                string Para1 = historyInfo.IssueID;
                string Para2 = "NULL";
                string Para3 = "NULL";
                //if (HistoryInfo[1] != "0")
                if (historyInfo.FieldName != "0")
                {
                    //Para2 = "'" + HistoryInfo[1] + "'";
                    Para2 = "'" + historyInfo.FieldName + "'";
                }
               // if (HistoryInfo[2] != "0")
                if (historyInfo.ChangedBy != "0")
                {
                    Para3 = "'" + historyInfo.ChangedBy + "'";
                }
                string query = "EXEC usp_Whizible2_Sel_tb_IB_HistoryInfo " + Para1 + "," + Para2 + "," + Para3;
                DataTable HistoryData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                return HistoryData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

       [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetHistoryDetails([FromBody]int IssueID)
        {
            try
            {
                string query = "EXEC usp_Whizible2_Sel_tb_IB_History " + IssueID;
                DataTable HistoryData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                HistoryData.Columns.Remove("HistoryID");
                HistoryData.Columns.Remove("IssueID");

                HistoryData.Columns["DateOfChange"].SetOrdinal(0);
                HistoryData.Columns["ChangedBy"].SetOrdinal(1);
                HistoryData.Columns["FieldName"].SetOrdinal(2);
                HistoryData.Columns["Value"].SetOrdinal(3);
                HistoryData.Columns["Description"].SetOrdinal(4);
                return HistoryData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 12th May 2020 For ISSUe ID 24234


        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object CheckDAFillOrnot([FromBody]int IssueID)
        {
            try
            {
                String ISdata = "";
                string query = "EXEC usp_Sel_tbl_PM_DailyActivity_For_Issue " + IssueID;
                // DataTable HistoryData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                ISdata = Convert.ToString(CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString));
                return ISdata;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //End of Added By Dipali V On 12th May 2020 For ISSUe ID 24234


        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetHistoryDetailsByFields([FromBody]string[] FieldName)
        {
            try
            {
                string query = "EXEC usp_Whizible2_Sel_tb_IB_History_By_Fields " + FieldName[0] + ",'" + FieldName[1] + "'";
                DataTable HistoryData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                HistoryData.Columns.Remove("HistoryID");
                HistoryData.Columns.Remove("IssueID");

                HistoryData.Columns["DateOfChange"].SetOrdinal(0);
                HistoryData.Columns["ChangedBy"].SetOrdinal(1);
                HistoryData.Columns["FieldName"].SetOrdinal(2);
                HistoryData.Columns["Value"].SetOrdinal(3);
                HistoryData.Columns["Description"].SetOrdinal(4);

                return HistoryData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetHistoryDetailsByChangedBy([FromBody]string[] FieldName)
        {
            try
            {
                string query = "EXEC usp_Whizible2_Sel_tb_IB_History_By_ChangedBy " + FieldName[0] + ",'" + FieldName[1] + "'";
                DataTable HistoryData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                HistoryData.Columns.Remove("HistoryID");
                HistoryData.Columns.Remove("IssueID");

                HistoryData.Columns["DateOfChange"].SetOrdinal(0);
                HistoryData.Columns["ChangedBy"].SetOrdinal(1);
                HistoryData.Columns["FieldName"].SetOrdinal(2);
                HistoryData.Columns["Value"].SetOrdinal(3);
                HistoryData.Columns["Description"].SetOrdinal(4);

                return HistoryData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


       [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetHistoryDetailsByFieldNameChangedBy([FromBody]string[] FieldName)
        {
            try
            {
                string query = "EXEC usp_Whizible2_Sel_tb_IB_History_By_ChangedByAndFieldName " + FieldName[0] + ",'" + FieldName[1] + "','" + FieldName[2] + "'";
                DataTable HistoryData = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                HistoryData.Columns.Remove("HistoryID");
                HistoryData.Columns.Remove("IssueID");

                HistoryData.Columns["DateOfChange"].SetOrdinal(0);
                HistoryData.Columns["ChangedBy"].SetOrdinal(1);
                HistoryData.Columns["FieldName"].SetOrdinal(2);
                HistoryData.Columns["Value"].SetOrdinal(3);
                HistoryData.Columns["Description"].SetOrdinal(4);

                return HistoryData;
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
        //public List<HistoryClass> GetFiledsForHistory([FromBody]int IssueID)
        public object GetFiledsForHistory([FromBody] int IssueID)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_History_FieldName " + IssueID;

                List<HistoryClass> FieldNames = new List<HistoryClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    HistoryClass Dates = new HistoryClass()
                    {
                        FieldName = sdr["FieldName"].ToString(),

                    };
                    FieldNames.Add(Dates);
                }

                return FieldNames;
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
        //public List<HistoryClass> GetModifiedBy([FromBody]int IssueID)
        public object GetModifiedBy([FromBody] int IssueID)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_IB_History_ChangedBy " + IssueID;

                List<HistoryClass> ModifiedByNames = new List<HistoryClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    HistoryClass Dates = new HistoryClass()
                    {
                        ModifiedBy = sdr["ChangedBy"].ToString(),

                    };
                    ModifiedByNames.Add(Dates);
                }

                return ModifiedByNames;
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
        //public List<ResourcesClass> GetResources([FromBody]string[] ResourcesParameter)
        public object GetResources([FromBody] ParameterGetResources parameter)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'AssignTo'," + parameter.ProjectId + ",NULL,Null,'-1','" + parameter.Typeproject + "','" + parameter.LoginType + "','Edit'," + parameter.IssueID + ",1 ";

                List<ResourcesClass> ResourcesData = new List<ResourcesClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ResourcesClass ResourcesObj = new ResourcesClass()
                    {
                        EmployeeID = sdr["EmployeeID"].ToString(),
                        UserName = sdr["UserName"].ToString(),
                        Location = sdr["Location"].ToString(),
                        RoleDescription = sdr["RoleDescription"].ToString(),

                    };
                    ResourcesData.Add(ResourcesObj);
                }

                return ResourcesData;
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
        //public List<AttachmentClass> AttachmentsOriginalFileName([FromBody]int IssueID)
        public object AttachmentsOriginalFileName([FromBody] int IssueID)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_sel_tbl_IB_Attachments_OriginalFileName " + IssueID + "";

                List<AttachmentClass> AttachmentObj = new List<AttachmentClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    AttachmentClass AttObj = new AttachmentClass()
                    {
                        OriginalFileName = sdr["OriginalFileName"].ToString(),
                        FilePath = sdr["FilePath"].ToString(),

                    };
                    AttachmentObj.Add(AttObj);
                }

                return AttachmentObj;
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
        //public List<TaskTypeClass> GetTaskTypes([FromBody]int ProjectID)
        //public List<TaskTypeClass> GetTaskTypes([FromBody]int[] data)
        public object GetTaskTypes([FromBody] ParameterGetTaskTypesAddNew parameter)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_TaskTypes_Names " + parameter.ProjectId + "," + parameter.Data;

                List<TaskTypeClass> TaskTypes = new List<TaskTypeClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    TaskTypeClass ObjTaskTypeClass = new TaskTypeClass()
                    {
                        TaskTypeID = sdr["TaskTypeID"].ToString(),
                        TaskType = sdr["TaskType"].ToString(),
                    };
                    TaskTypes.Add(ObjTaskTypeClass);
                }

                return TaskTypes;
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
        //public List<TaskTypeClass> GetTaskTypes([FromBody]int ProjectID)
        //public List<TaskTypeClass> GetDefaultTaskTypes([FromBody]int[] data)
        public object GetDefaultTaskTypes([FromBody] ParameterGetDefaultTaskType parameter)


        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_DefaultTaskTypes_Names " + parameter.ProjectId + "," + parameter.IssueID;

                List<TaskTypeClass> TaskTypes = new List<TaskTypeClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    TaskTypeClass ObjTaskTypeClass = new TaskTypeClass()
                    {
                        TaskTypeID = sdr["TaskTypeID"].ToString(),
                        TaskType = sdr["TaskType"].ToString(),
                    };
                    TaskTypes.Add(ObjTaskTypeClass);
                }

                return TaskTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        //public List<SubTaskTypeClass> GetSubTaskTypes([FromBody]int[] Data)
        public object GetSubTaskTypes([FromBody] int[] Data)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_TaskSubTypes_Names " + Data[0] + ", " + Data[1] + " ";

                List<SubTaskTypeClass> SubTaskTypes = new List<SubTaskTypeClass>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    SubTaskTypeClass ObjSubTaskTypeClass = new SubTaskTypeClass()
                    {
                        SubTaskTypeID = sdr["SubTaskTypeID"].ToString(),
                        SubTaskType = sdr["SubTaskType"].ToString(),
                    };
                    SubTaskTypes.Add(ObjSubTaskTypeClass);
                }

                return SubTaskTypes;
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
        public object SaveAssignIssue([FromBody] AssignIssue AssignIssue)
        {
            try
            {
                //string strSQL = "Exec usp_Whizible2_Ins_IB_AssignIssueToResource " + AssignIssue.IssueId + "," + AssignIssue.ProjectId + "," + AssignIssue.EmployeeId + "," + AssignIssue.Duration + ",'" + AssignIssue.StartDate + "','" + AssignIssue.EndDate + "'," + AssignIssue.BillableYN + "," + AssignIssue.TaskTypeId + "," + AssignIssue.SubTaskTypeId + ",'" + HttpUtility.UrlDecode(AssignIssue.Summary) + "','" + HttpUtility.UrlDecode(AssignIssue.Description) + "','" + HttpUtility.UrlDecode(AssignIssue.ModuleName) + "' ";
                //Commented And Added By Usha Pandit On 14.05.2020 For escaping quotes from assign issue
                //string strSQL = "Exec usp_Whizible2_Ins_IB_AssignIssueToResource " + AssignIssue.IssueId + "," + AssignIssue.ProjectId + "," + AssignIssue.EmployeeId + "," + AssignIssue.Duration + ",'" + AssignIssue.StartDate + "','" + AssignIssue.EndDate + "'," + AssignIssue.BillableYN + "," + AssignIssue.TaskTypeId + ",null,'" + HttpUtility.UrlDecode(AssignIssue.Summary) + "','" + HttpUtility.UrlDecode(AssignIssue.Description) + "','" + HttpUtility.UrlDecode(AssignIssue.ModuleName) + "' ";
                string strSQL = "Exec usp_Whizible2_Ins_IB_AssignIssueToResource " + AssignIssue.IssueId + "," + AssignIssue.ProjectId + "," + AssignIssue.EmployeeId + "," + AssignIssue.Duration + ",'" + AssignIssue.StartDate + "','" + AssignIssue.EndDate + "'," + AssignIssue.BillableYN + "," + AssignIssue.TaskTypeId + ",null,'" + HttpUtility.UrlDecode(AssignIssue.Summary).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(AssignIssue.Description).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(AssignIssue.ModuleName) + "' ";
                //End Of Added By Usha Pandit On 14.05.2020 For escaping quotes from assign issue
                object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                //Added By Dipali V On 4th June 2020 For Mail should be open when Issue assign

                //Added By Rutuja D. on 2 Nov 2021 For When Task is void then Mail Popup Don't  show
                string StrSQL1 = "usp_Whizible2_Sel_IsActive_tbl_PM_ProjectTasks " + AssignIssue.ProjectId + "," + AssignIssue.EmployeeId + "," + AssignIssue.IssueId;
                string result1 = Convert.ToString(CommonFunctions.Data.GetDataScalar(StrSQL1, true, CommonController.connectionString));
                //End of Added By Rutuja D. on 2 Nov 2021 For When Task is void then Mail Popup Don't  show

                DataTable EmailDataTable;
                EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 14", true, CommonController.connectionString);
                bool blnSendEmail;
                bool blnShowPopup;
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                string Flag = "";
                foreach (DataRow mailRow in EmailDataTable.Rows)
                {
                    blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                    blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));
                    //Added By Rutuja D. on 2 Nov 2021 For When Task is void then Mail Popup Don't  show
                    if (result1 == "0")
                    {
                        blnSendEmail = false;
                    }
                    //End of Added By Rutuja D. on 2 Nov 2021 For When Task is void then Mail Popup Don't  show
                    if (blnSendEmail == true)
                    {
                        if (blnShowPopup == true)
                        {
                            Flag = "1";
                        }
                        else
                        {
                            Flag = "0";
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }
                    }
                }
                return result + "&&" + Flag;

                //End of Added By Dipali V On 4th June 2020 For Mail should be open when Issue assign


                // return result;
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
        public object UpdateIssueTable([FromBody] AssignIssue AssignIssue)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_IB_Issue_DueDateAndDuration " + AssignIssue.IssueId + "," + AssignIssue.Duration + ",'" + AssignIssue.DueDate + "','" + AssignIssue.CreatedBy + "'";

                object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return result;
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
        public object GetAssignedIssueDetails([FromBody] int IssueID)
        {
            try {
                string strSQL = "Exec usp_Whizible2_Sel_tbl_PM_ProjectTasks_IssueTasks " + IssueID;

                DataTable AssignedIssue;
                AssignedIssue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return AssignedIssue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by Swapnagandha K On 22 Oct 2019 To Validate Assigned Issue
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object ValidateDeleteAssignedIssue([FromBody] AssignIssue AssignedIssue)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_ValidateDelete_tbl_PM_ProjectTasks_IssueTasks " + AssignedIssue.IssueId + "," + AssignedIssue.ProjectId + "," + AssignedIssue.EmployeeId + "";

                object result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Added by Swapnagandha K On 22 Oct 2019 To Validate Assigned Issue

        //Added by Rehan on 07-12-2022
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteAssignedIssue([FromBody] AssignIssue AssignedIssue)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Del_tbl_PM_ProjectTasks_IssueTasks " + AssignedIssue.IssueId + "," + AssignedIssue.ProjectId + "," + AssignedIssue.EmployeeId + "";

                object result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        string[] filepaths = new string[10];
        //string[] filepaths;
        string sourceFile, destFile, NewFilePath, OldFilePath, file;

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object DownloadZip([FromBody]int intDiscussionID)
        {
            try
            {
                int i = 0;
                var filePath = HttpContext.Current.Server.MapPath("~/" + "Request_" + intDiscussionID);

                filePath = filePath.Replace("WhizibleAPIService", "ATTACHMENTS\\BTS\\ZIPFile");
                NewFilePath = filePath;
                OldFilePath = filePath.Replace("ZIPFile\\Request_" + intDiscussionID, "");
                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Discussion_Attachments " + intDiscussionID;
                DataTable drAttachment = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                string strDirectoryPath1 = filePath;
                string strdirectory1 = strDirectoryPath1.Replace(@"\\", @"\");
                if (System.IO.Directory.Exists(strdirectory1))
                {
                    System.IO.Directory.Delete(strdirectory1, true);
                }
                foreach (DataRow row in drAttachment.Rows)
                {
                    filepaths[i] = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["FilePath"], "Null"));
                    file = filepaths[i].ToString();
                    file = file.Replace(@"\", @"//");
                    file = Path.GetFileName(file);
                    try
                    {
                        // string strDirectoryPath = System.IO.Path.GetDirectoryName(filePath);
                        string strDirectoryPath = filePath;
                        string strdirectory = strDirectoryPath.Replace(@"\\", @"\");
                        if (!System.IO.Directory.Exists(strdirectory))
                        {
                            System.IO.Directory.CreateDirectory(strdirectory);
                        }
                        sourceFile = System.IO.Path.Combine(OldFilePath, file);
                        destFile = System.IO.Path.Combine(strDirectoryPath, file);
                        System.IO.File.Copy(sourceFile, destFile, true);

                    }
                    catch (Exception)
                    {


                    }

                    i++;
                }
                string strArchiveFileName = filePath + ".zip";
                try
                {
                    if (File.Exists(strArchiveFileName))
                    {
                        File.Delete(strArchiveFileName);
                    }
                    //System.IO.Compression..CreateFromDirectory(strFilePath_New, strArchiveFileName);
                    //  System.IO.Compression.GZipStream
                    System.IO.Compression.ZipFile.CreateFromDirectory(NewFilePath, strArchiveFileName);

                }
                catch (Exception)
                {

                    //throw;
                }

                return strArchiveFileName;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        string[] filepathsA = new string[10];
        //string[] filepaths;
        //string sourceFile, destFile, NewFilePath, OldFilePath, file;

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        public object DownloadZipAttachments([FromBody]int intIssueID)
        {
            try
            {

                int i = 0;
                var filePath = HttpContext.Current.Server.MapPath("~/" + "Request_" + intIssueID);

                filePath = filePath.Replace("WhizibleAPIService", "ATTACHMENTS\\BTS\\ZIPFile");
                NewFilePath = filePath;
                OldFilePath = filePath.Replace("ZIPFile\\Request_" + intIssueID, "");
                //strSQL = "EXEC usp_Whizible2_Sel_tbl_IB__Attachments " + intIssueID;
                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Attachments " + intIssueID;
                DataTable drAttachment = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                string strDirectoryPath1 = filePath;
                string strdirectory1 = strDirectoryPath1.Replace(@"\\", @"\");
                if (System.IO.Directory.Exists(strdirectory1))
                {
                    System.IO.Directory.Delete(strdirectory1, true);
                }
                foreach (DataRow row in drAttachment.Rows)
                {
                    filepathsA[i] = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["FilePath"], "Null"));
                    file = filepathsA[i].ToString();
                    file = file.Replace(@"\", @"//");
                    file = Path.GetFileName(file);
                    try
                    {
                        // string strDirectoryPath = System.IO.Path.GetDirectoryName(filePath);
                        string strDirectoryPath = filePath;
                        string strdirectory = strDirectoryPath.Replace(@"\\", @"\");
                        if (!System.IO.Directory.Exists(strdirectory))
                        {
                            System.IO.Directory.CreateDirectory(strdirectory);
                        }
                        sourceFile = System.IO.Path.Combine(OldFilePath, file);
                        destFile = System.IO.Path.Combine(strDirectoryPath, file);
                        System.IO.File.Copy(sourceFile, destFile, true);

                    }
                    catch (Exception)
                    {


                    }

                    i++;
                }
                string strArchiveFileName = filePath + ".zip";
                try
                {
                    if (File.Exists(strArchiveFileName))
                    {
                        File.Delete(strArchiveFileName);
                    }
                    //System.IO.Compression..CreateFromDirectory(strFilePath_New, strArchiveFileName);
                    //  System.IO.Compression.GZipStream
                    System.IO.Compression.ZipFile.CreateFromDirectory(NewFilePath, strArchiveFileName);

                }
                catch (Exception)
                {

                    //throw;
                }

                return strArchiveFileName;
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
        string Filed, Type, ProjectId, IssueID, CorporateValue;
        bool IsCurrentProjectStatus;
        string Value;

        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public object UpdateIssue([FromBody]object[] Allvalue)
        public object UpdateIssue([FromBody] UpdateIssueData issueData)
        {
            try
            {
                object[] IssueDataval;
                IssueDataval = issueData.Allvalue.Split(',');
                //string Type;UpdateIssueData
                // string ProjectId;

                //Array.Copy(Allvalue, AllIssueData, Allvalue.Length);
                //List<object> AllIssueData = Allvalue.OfType<object>().ToList();
                //List<object> AllIssueDataOriginal = Allvalue.OfType<object>().ToList();
               // Array.Copy(IssueDataval, AllIssueData, IssueDataval.Length);
                List<object> AllIssueData = IssueDataval.OfType<object>().ToList();
                List<object> AllIssueDataOriginal = IssueDataval.OfType<object>().ToList();

                AllIssueData.RemoveAt(AllIssueData.Count - 1);

                for (int i = 0; i < AllIssueData.Count; i++) // Loop through List with for
                {
                    string ObjAllIssueData = AllIssueDataOriginal[i].ToString(); ;
                    if (ObjAllIssueData.IndexOf("chkShowToCustomer") != -1)
                    {
                        AllIssueData.Remove(ObjAllIssueData);
                    }
                }


                //for (int i = 0; i < Allvalue.Length; i++)
                for (int i = 0; i < IssueDataval.Length; i++)
                {
                    //string getvalue = Allvalue[i].ToString();
                    string getvalue = IssueDataval[i].ToString();
                    int endvalue = getvalue.IndexOf("=");
                    string getFiled = getvalue.Substring(0, endvalue).ToString();
                    string getFiledValue = getvalue.Substring(endvalue + 1, getvalue.Length - endvalue - 1).ToString();

                    getFiledValue = HttpUtility.UrlDecode(getFiledValue);

                    if (getFiled == "IssueID")
                    {
                        IssueID = getFiledValue;
                       // Array.Resize(ref Allvalue, Allvalue.Length - 1);
                        Array.Resize(ref IssueDataval, IssueDataval.Length - 1);
                    }

                    if (getFiled == "CustomerIssueID1")
                    {
                        getFiled = "CustomerID";
                    }

                    if (getFiled == "ComponentID")
                    {
                        if (getFiledValue == "'undefined'")
                        {
                            getFiledValue = "0";
                        }
                    }

                    Filed += getFiled + ",";

                    if (getFiled == "ShowToCustomer" || getFiled == "IssueID" || getFiled == "ProjectID" || getFiled == "CustomerID" || getFiled == "Product" || getFiled == "Module" || getFiled == "CodedBy" || getFiled == "AssignTo" || getFiled == "RootCauseID" || getFiled == "DeliverableID" || getFiled == "ProductVersionID" || getFiled == "ComponentID" || getFiled == "CustomerID" || getFiled == "ReleaseID" || getFiled == "IterationID" || getFiled == "UserStoryID" || getFiled == "Module" || getFiled == "ChangeRequestID" || getFiled == "CustomerIssueID1")
                    {
                        if (getFiled == "ProjectID")
                        {
                            ProjectId = getFiledValue;
                        }
                    }
                    else
                    {
                        //if (getFiled == "ReportedBy")
                        //{
                        //    string FiledName = "CreatorOrModifier";
                        //    string FieldValue = "" + getFiledValue + "" + "";
                        //    string Arrayele = FiledName + "=" + FieldValue;

                        //    AllIssueData.Add(Arrayele);
                        //}
                        //else if (getFiled == "ReportedDate" || getFiled == "ReportedTime")
                        //{

                        //    if (getFiled == "ReportedDate")
                        //    {
                        //        string FiledName = "StatusChangeDate";
                        //        string FieldValue = "" + getFiledValue + "" + "";
                        //        string Arrayele = FiledName + "=" + FieldValue;

                        //        AllIssueData.Add(Arrayele);

                        //    }
                        //    if (getFiled == "ReportedTime")
                        //    {

                        //        string FiledName = "StatusChangeTime";
                        //        string FieldValue = "" + getFiledValue + "" + "";
                        //        string Arrayele = FiledName + "=" + FieldValue;

                        //        AllIssueData.Add(Arrayele);
                        //    }

                        //}
                        //Commented And Added By Usha Pandit On 01.04.2020 For adding Corporate Sub Type
                        //if (getFiled == "Type" || getFiled == "Priority" || getFiled == "Status" || getFiled == "Severity" || getFiled == "Complexity")
                        //{
                        if (getFiled == "Type" || getFiled == "SubType" || getFiled == "Priority" || getFiled == "Status" || getFiled == "Severity" || getFiled == "Complexity")
                        {
                            //End Of Added By Usha Pandit On 01.04.2020 For adding Corporate Sub Type
                            if (getFiled == "Type")
                            {
                                strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Type'," + getFiledValue + "," + ProjectId;
                                Type = getFiledValue;
                            }
                            if (getFiled == "SubType")
                            {
                                strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'SubType'," + getFiledValue + "," + ProjectId + "," + Type + "";
                            }
                            if (getFiled == "Status")
                            {
                                strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Status'," + getFiledValue + "," + ProjectId + "," + Type + "";
                            }
                            if (getFiled == "Priority")
                            {
                                strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Priority'," + getFiledValue + "," + ProjectId;
                            }
                            if (getFiled == "Severity")
                            {
                                strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Severity'," + getFiledValue + "," + ProjectId;
                            }
                            if (getFiled == "Complexity")
                            {
                                strSQL = "Exec usp_Whizible2_Sel_IB_GetCorporateValue " + "'Complexity'," + getFiledValue + "," + ProjectId;
                            }
                            DataTable GetCorporateValue = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                            foreach (DataRow rowCorporateValue in GetCorporateValue.Rows)
                            {
                                //Commented And Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                //CorporateValue = CommonFunctions.Data.CheckIsDBNull(rowCorporateValue["CorporateValue"], "0").ToString();
                                CorporateValue = CommonFunctions.Data.CheckIsDBNull(rowCorporateValue["CorporateValue"], "0").ToString().Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                                //End Of Added By Usha Pandit On 17.06.2020 For escaping quotes in string
                                IsCurrentProjectStatus = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(rowCorporateValue["IsCurrentProjectStatus"], "false"));
                            }
                            if (IsCurrentProjectStatus == true)
                            {
                                string FiledName = "Corporate" + getFiled;
                                string FieldValue = "'" + CorporateValue + "'" + "";
                                string Arrayele = FiledName + "=" + FieldValue;

                                AllIssueData.Add(Arrayele);
                            }
                        }
                    }
                }


                string strquery = "";

                //Added By Dipali V On 3rd Feb 2026 For encodeURI issue - decode Summary/Description until stable to handle single or double encoding
                foreach (var item in AllIssueData)
                {
                    string decoded = item.ToString();
                    if (decoded.StartsWith("Summary=", StringComparison.OrdinalIgnoreCase) || decoded.StartsWith("Description=", StringComparison.OrdinalIgnoreCase))
                    {
                        string prev = "";
                        while (prev != decoded)
                        {
                            prev = decoded;
                            decoded = HttpUtility.UrlDecode(decoded);
                        }
                    }
                    else
                    {
                        decoded = HttpUtility.UrlDecode(decoded);
                    }
                    strquery += decoded + ",";
                }
                strquery = strquery.Remove(strquery.Length - 1);
                string Query = "UPDATE tbl_Ib_Issue SET " + strquery + "WHERE IssueID =" + IssueID;
                object issueid = CommonFunctions.Data.InsertOrUpdateData(Query, true, CommonController.connectionString);

                ////start vishal mahajan 04-12-2019 for ISSUE STATUS CHANGED
                return IssueID;
                ////end vishal mahajan 04-12-2019 for ISSUE STATUS CHANGED
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
        //public object UpdateExtFields([FromBody]object[] ExtFields)
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateExtFields([FromBody] UpdateIssueData  ExtFields)
        {
            try
            {
                object[] IssueDataval;
                IssueDataval = ExtFields.CustomFieldsdata.Split(',');
                //List<object> ExtFieldsData = ExtFields.OfType<object>().ToList();
                List<object> ExtFieldsData = ExtFields.CustomFieldsdata.OfType<object>().ToList();

                ExtFieldsData.RemoveAt(ExtFieldsData.Count - 1);


                //for (int i = 0; i < ExtFields.Length; i++)
                for (int i = 0; i < IssueDataval.Length; i++)
                {
                    //string getvalue = ExtFields[i].ToString();
                    string getvalue = IssueDataval[i].ToString();
                    int endvalue = getvalue.IndexOf("=");
                    string getFiled = getvalue.Substring(0, endvalue).ToString();
                    string getFiledValue = getvalue.Substring(endvalue + 1, getvalue.Length - endvalue - 1).ToString();

                    getFiledValue = HttpUtility.UrlDecode(getFiledValue);

                    if (getFiled == "IssueID")
                    {
                        IssueID = getFiledValue;
                    }
                }

                string strquery = "";

                //foreach (var item in ExtFields)
                foreach (var item in IssueDataval)
                {
                   strquery += "@" + HttpUtility.UrlDecode(item.ToString()) + ",";
                    //strquery +=  HttpUtility.UrlDecode(item.ToString()) + ",";
                }
                strquery = strquery.Remove(strquery.Length - 1);
                string Query = "EXEC usp_Whizible2_Ins_tbl_IB_Issue_ExtendedCustomFields " + strquery;
                object issueid = CommonFunctions.Data.InsertOrUpdateData(Query, true, CommonController.connectionString);

                return issueid;
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
        public object CheckDeliverableNodeAccess([FromBody]CommonProperty commonProperty)
        {
            try
            {
                bool HasAccess = false;
                string strquery = "@intTagID = 2133, @intRoleID = " + commonProperty.RoleId + ", @intProjectID = " + commonProperty.ProjectId + ", @intEmployeeID = " + commonProperty.EmployeeId;
                string Query = "EXEC usp_Whizible2_Check_DeliverableNode_Access " + strquery;
                HasAccess = Convert.ToBoolean(CommonFunctions.Data.GetDataScalar(Query, true, CommonController.connectionString));

                return HasAccess;
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
        public object ShowIssueAssignmentLink([FromBody]CommonProperty commonProperty)
        {
            try
            {
                bool blnRet = false;
                string strsql = "Exec usp_Whizible2_Sel_tbl_IB_GetIssueLayoutToBeApplied " + commonProperty.ProjectId + "," + commonProperty.RoleId;
                DataTable taskListTable1 = CommonFunctions.Data.GetDataTable(strsql, true, CommonController.connectionString);
                foreach (DataRow sdr in taskListTable1.Rows)
                {
                    blnRet = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["ShowIssueAssignmentLink"], "0"));
                }
                return blnRet;
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
        public object IsProjectOnHold([FromBody]int issueId)
        {
            try
            {
                string strSQL;
                object sdr;
                {
                    //strSQL = "Insert Into tbl_PM_otherSchedules(ScheduleTypeID,ProjectID,DepartmentID,DocumentNo,CustomerRefNo,Title,DeliverableLCE, StartDate,EarliestStartDate,LatestCompletionDate,ProjectSiteID,Priority,DeliverableSize,DeliverableSizeUnitID,ComplexityID,IncludeInMeasurement,RequestedBy,ResponsiblePerson,Status,IsAcceptanceTestingRequired,PackageID , CustomFieldText1,CustomFieldText2,CustomFieldText3,CustomFieldText4,CustomFieldText5,CustomFieldNumeric1,CustomFieldNumeric2,CustomFieldNumeric3,CustomFieldNumeric4,CustomFieldNumeric5,CustomFieldDate1, CustomFieldDate2, CustomFieldDate3, CustomFieldDate4, CustomFieldDate5, Description)values(" + newIssue.ScheduleTypeID + "," + newIssue.ProjectId + ",null,null,null,'" + newIssue.Title + "',null,'" + newIssue.StartDate + "',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,'" + newIssue.Description + "'); Select SCOPE_IDENTITY()";
                    strSQL = "EXEC usp_Whizible2_sel_ProjectIssue_Status @intIssueID = " + issueId;

                    sdr = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                }
                return sdr;
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
        public object GetProjectWorkHours([FromBody]int projectId)
        {
            try
            {
                string strSQL;
                strSQL = "EXEC usp_Whizible2_Sel_PM_DepartmentBalanceLCE @ProjectID = " + projectId;
                AssignHours ObjAssignHours = new AssignHours();
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    ObjAssignHours.AllocatedLCETotal = CommonFunctions.Data.CheckIsDBNull(sdr["AllocatedLCETotal"], "0").ToString();
                    ObjAssignHours.LCETotal = CommonFunctions.Data.CheckIsDBNull(sdr["LCETotal"], "0").ToString();
                }

                CommonFunctions.Data.DisposeDataReader(ref sdr);

                return (object)ObjAssignHours;
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
        public object GetCheckAssignIssueProjectWorkHours([FromBody] AssignIssue AssignIssue)
        //public object GetCheckAssignIssueProjectWorkHours([FromBody]int projectId, int Resource, int TaskTypeId, string ModuleName, int IssueID)
        {
            try
            {
                string strSQL;
                string Result;
                // strSQL = "EXEC usp_Whizible2_Sel_PM_DepartmentBalanceLCE @ProjectID = " + projectId;
                strSQL = "EXEC usp_Whizible2_Sel_PM_DepartmentBalanceLCE_issue " + AssignIssue.ProjectId + ",NULL," + AssignIssue.EmployeeId + " ," + AssignIssue.IssueId + "," + AssignIssue.TaskTypeId + ",'" + AssignIssue.Duration + "'";
                //AssignHours ObjAssignHours = new AssignHours();
                //IDataReader sdr;
                Result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                //while (sdr.Read())
                //{
                //    ObjAssignHours.AllocatedLCETotal = CommonFunctions.Data.CheckIsDBNull(sdr["AllocatedLCETotal"], "0").ToString();
                //    ObjAssignHours.LCETotal = CommonFunctions.Data.CheckIsDBNull(sdr["LCETotal"], "0").ToString();
                //}

                //CommonFunctions.Data.DisposeDataReader(ref sdr);

                return Result.ToString();
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
        public object GetMinHoursForDAEntry([FromBody]int projectId)
        {
            string strSQL;
            try
            {
                strSQL = "EXEC usp_Whizible2_sel_tbl_PM_CompanyInformation_PM ";
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                //Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                string RestrictByMinHours = "";
                //End Of Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                string MinHrs = "";
                while (sdr.Read())
                {
                    //Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                    RestrictByMinHours = sdr["RestrictByMinHours"].ToString();
                    //End Of Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                    MinHrs = sdr["MinHoursForDAEntry"].ToString();
                }
                CommonFunctions.Data.DisposeDataReader(ref sdr);

                //Commented And Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
                //return MinHrs;
                return RestrictByMinHours + "$$" + MinHrs;
                //End Of Added By Usha Pandit On 03.04.2020 For getting RestrictByMinHours flag
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*Added by Swapnagandha K. to get SLA Details*/
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<SLADetails> GetProjectIssueSLA([FromBody]int IssueID)
        public object GetProjectIssueSLA([FromBody] int IssueID)

        {
            try
            {
                string strSQL = "Exec usp_Whizible2_CalculateSLAForProjectIssues " + IssueID;

                List<SLADetails> IssueSLAdata = new List<SLADetails>();

                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr.Read())
                {
                    SLADetails SLA = new SLADetails()
                    {
                        SLAName = sdr["SLAName"].ToString(),
                        NormDate = sdr["RequestFromDate"].ToString(),
                        NormHours = sdr["PlanDuration"].ToString(),
                        UnitOfNorm = sdr["UnitOfNorm"].ToString(),
                        ActualHours = sdr["ActualDuration"].ToString(),
                        IsMet = sdr["MET/NOTMET"].ToString(),

                    };
                    IssueSLAdata.Add(SLA);
                }

                return IssueSLAdata;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /*End Added by Swapnagandha K. to get SLA Details*/
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        [HttpPost]
        //public List<AllComboValues> GetAllComboValues([FromBody] IssueComboParameters issueComboParameters)
        //public object GetAllComboValues([FromBody] IssueComboParameters issueComboParameters)
        public object GetAllComboValues([FromBody] CommonProperty commonProperty)

        {
            try
            {
                List<AllComboValues> lstAllComboValues = new List<AllComboValues>();
               // CommonProperty commonProperty = issueComboParameters.commonProperty;
               // string[] combo = issueComboParameters.ComboNameList.Split(',');
                string[] combo = commonProperty.ComboNameList.Split(',');
                DataTable cmbTable = new DataTable();
                for (int i = 0; i < combo.Length; i++)
                {
                    List<ComboValues> lstComboValues = new List<ComboValues>();
                    AllComboValues allComboValues = new AllComboValues();
                    string comboname = combo[i].ToUpper();
                    switch (comboname)
                    {
                        case "COMPLEXITY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Complexity " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "HARDWARE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_PM_ProjectHardware " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "CODEDBYNAME":
                            cmbTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'CodedBy', " + commonProperty.ProjectId + "," + " NULL ,NULL, NULL, NULL ,'" + commonProperty.LoginType + "','New',0", true, CommonController.connectionString);
                            break;
                        case "STATUS":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Status_for_issuelist " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "DELIVERABLEID":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_OtherSchedules " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "FIXEDINPHASE":
                        case "FOUNDINPHASE":
                        case "PHASE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Phases_ProjectGroup " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "KERNEL":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Kernels " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "MODULENAME":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_PM_Module_ProjectGroup " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "COMPONENT":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC USP_Whizible2_SEL_Tbl_PRD_ProductVersion_Component NULL, NULL, " + commonProperty.ProjectId + "," + commonProperty.EmployeeId + ",'" + commonProperty.LoginType + "', 1", true, CommonController.connectionString);
                            break;
                        case "OS":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_OS " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "PRIORITY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Priorities " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "PRODUCTVERSION":
                        case "REPORTEDINVERSION":
                        case "CORRECTEDINVERSION":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Version " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "REPORTEDBY":
                            cmbTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " + commonProperty.ProjectId + "," + commonProperty.EmployeeId + ",1,NULL,NULL,'" + commonProperty.LoginType + "','Edit'," + commonProperty.IssueID, true, CommonController.connectionString);
                            break;
                        case "ASSIGNTONAME":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_IB_Project_Resources " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "ROOTCAUSEID":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_IB_Project_RootCause " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "SEVERITY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Severity " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "SUBTYPE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_SUB_TYPE " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "TYPE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_TYPE " + commonProperty.ProjectId + "," + commonProperty.RoleId, true, CommonController.connectionString);
                            break;
                        case "RELEASE":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumRelease_ReleaseID " + commonProperty.ProjectId, true, CommonController.connectionString);
                            break;
                        case "ITERATION":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumIteration_IterationID_IterationName " + commonProperty.IssueID, true, CommonController.connectionString);
                            break;
                        case "USERSTORY":
                            cmbTable = CommonFunctions.Data.GetDataTable("EXEC usp_Whizible2_sel_tbl_PM_ScrumUserStory_UserStoryID_UserStoryName " + commonProperty.IssueID, true, CommonController.connectionString);
                            break;
                        case "CHANGEREQUESTNAME":
                            cmbTable = CommonFunctions.Data.GetDataTable("Exec usp_Whizible2_Sel_tbl_PM_ChangeRequest_Master " + commonProperty.ProjectId + ",NULL", true, CommonController.connectionString);
                            break;
                        default:
                            break;
                    }
                    switch (comboname)
                    {
                        case "COMPLEXITY":
                        case "HARDWARE":
                        case "CODEDBYNAME":
                        case "CORRECTEDINVERSION":
                        case "CREATORORMODIFIER":
                        case "DELIVERABLEID":
                        case "FIXEDINPHASE":
                        case "FOUNDINPHASE":
                        case "KERNEL":
                        case "MODULENAME":
                        case "COMPONENT":
                        case "OS":
                        case "PRIORITY":
                        case "PRODUCTVERSION":
                        case "REPORTEDINVERSION":
                        //case "CORRECTEDINVERSION":
                        case "ASSIGNTONAME":
                        case "ROOTCAUSEID":
                        case "SEVERITY":
                        case "PHASE":
                        case "STATUS":
                        case "SUBTYPE":
                        //case "SUBTYPE":
                        case "TYPE":
                        case "RELEASE":
                        case "ITERATION":
                        case "USERSTORY":
                        case "CHANGEREQUESTNAME":
                            foreach (DataRow cmbRow in cmbTable.Rows)
                            {
                                ComboValues controlCombo = new ComboValues()
                                {
                                    FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[0], "")),
                                    FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[1], "")),
                                };

                                lstComboValues.Add(controlCombo);
                            }
                            allComboValues.lstComboValues = lstComboValues;
                            allComboValues.ComboName = combo[i];
                            break;
                        case "REPORTEDBY":
                            foreach (DataRow cmbRow in cmbTable.Rows)
                            {
                                ComboValues controlCombo = new ComboValues()
                                {
                                    FieldID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[0], "")),
                                    FieldName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(cmbRow[0], "")),
                                };

                                lstComboValues.Add(controlCombo);
                            }
                            allComboValues.lstComboValues = lstComboValues;
                            allComboValues.ComboName = combo[i];
                            break;
                    }
                    lstAllComboValues.Add(allComboValues);
                }

                return lstAllComboValues;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        public object UpdateIssueTrackingFlag([FromBody]IssuesPara IssueDetailsPass)
        {
            string flag="";
            string strSQL;
            try
            {
                strSQL = "EXEC usp_whizible2_Sel_tbl_PM_FlagForTracking_IB " + IssueDetailsPass.intIssueidID + "," + IssueDetailsPass.EmployeeID + "";
                IDataReader sdr;
                sdr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                while (sdr.Read())
                {
                    flag = sdr["Flag"].ToString();
                }
                CommonFunctions.Data.DisposeDataReader(ref sdr);

                return flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //Added By Usha Pandit On 03.04.2020 For getting decimal hours
        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        public object getDecimalHours([FromBody]string HMHours)
        {
            try
            {
                string fltHours;

                //if (HMHours == "0" | HMHours == "")
                //    HMHours = "00:00";

                //if (HMHours.IndexOf(":") == HMHours.Length - 1)
                //    HMHours = HMHours + "00";

                //string strDecimal = "";
                //string strBeforeDecimal = "";
                //strBeforeDecimal = HMHours.Substring(0, HMHours.IndexOf(":"));
                //strDecimal = HMHours.Substring(HMHours.IndexOf(":") + 1, 2);
                //HMHours = strBeforeDecimal + ":" + strDecimal;                
                string strSQL = "select dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMHours + "',2) ";
                fltHours = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                //fltHours = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMHours + "',2)", true));


                return fltHours.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public DataTable GetDocumentSubType([FromBody] AssignIssue Parameter)
        {
            string strSQL;

            strSQL = "Exec usp_Sel_tbl_PM_DocumentSubCategory "
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.DocumentTypeID)) + ",NULL,"
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectId));


            DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            return dt;

        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public DataTable GetDocumentType([FromBody] AssignIssue Parameter)
        {
            string strSQL;

            strSQL = "Exec usp_Whizible2_Sel_tbl_PM_DocumentCategory_ForRole "
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.RoleID)) + ","
                + HttpUtility.UrlDecode(Convert.ToString(Parameter.ProjectId));


            DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

            return dt;

        }
        //End Of Added By Usha Pandit On 03.04.2020 For getting decimal hours

        //Added By Usha Pandit On 03.04.2020 For getting decimal hours
        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        public object getHMHours([FromBody]string DecHours)
        {
            try
            {
                string HMHours;

                //if (HMHours == "0" | HMHours == "")
                //    HMHours = "00:00";

                //if (HMHours.IndexOf(":") == HMHours.Length - 1)
                //    HMHours = HMHours + "00";

                //string strDecimal = "";
                //string strBeforeDecimal = "";
                //strBeforeDecimal = HMHours.Substring(0, HMHours.IndexOf(":"));
                //strDecimal = HMHours.Substring(HMHours.IndexOf(":") + 1, 2);
                //HMHours = strBeforeDecimal + ":" + strDecimal;                

                string strSQL = "select dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + DecHours + "',1) ";
                HMHours = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                //HMHours = Convert.ToString(CommonFunctions.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + DecHours + "',1)", true));

                return HMHours.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End Of Added By Usha Pandit On 03.04.2020 For getting decimal hours

        //Commented and Added by Riddhesh Patil on 20 July 2023 for performance Issue
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ExtCustomFiledValidtion([FromBody] CustomValidate customFiled)

        {
            try
            {
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_ExtCustomFields_validate " + customFiled.ProjectId + "," + customFiled.IssueID + "";
                //   strSQL += ProjectId;
               // string strResult = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), ""));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);


                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //End of Commented and Added by Riddhesh Patil on 20 July 2023 for performance Issue
        //Added By Dipali V On 25th july 2023 for performance issue
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object CustomFiledValidtion([FromBody] CustomValidate customFiled)

        {
            try
            {
                string strSQL1 = "Exec usp_Whizible2_Sel_tbl_IB_CustomFields_Master_validate " + customFiled.ProjectId + "," + customFiled.IssueID + "";
                //   strSQL += ProjectId;
                // string strResult = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), ""));
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);


                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        //End of Added By Dipali V On 25th july 2023 for performance issue

        public class UploadFileParameter
        {
            public string issueid { get; set; }
            public string EmployeeId { get; set; }
            public string DiscussionID { get; set; }
            public string DocumentTypeID { get; set; }
            public string DocumentSubTypeID { get; set; }
            public string LoginType { get; set; }
            public string NewFileName { get; set; }
            public string oldFileName { get; set; }
            public string comment { get; set; }
        }
        public class IssueData
        {
            public int IssueId { get; set; }
            public int ImportID { get; set; }
            public int ProjectID { get; set; }
            public string ProjectName { get; set; }
            public string Type { get; set; }
            public string CorporateType { get; set; }
            public string SubType { get; set; }
            public string CorporateSubType { get; set; }
            public string Priority { get; set; }
            public string CorporatePriority { get; set; }
            public string Status { get; set; }
            public string CorporateStatus { get; set; }
            public string Severity { get; set; }
            public string CorporateSeverity { get; set; }
            public string ReportedBy { get; set; }
            public string ReportedDate { get; set; }
            //public string AssignTo { get; set; }
            public int AssignTo { get; set; }
            public string AssignToName { get; set; }
            public string CreatedDate { get; set; }
            public string CustomerIssueID { get; set; }
            public string ReportedInVersion { get; set; }
            public string Summary { get; set; }
            public string Description { get; set; }
            public string ModuleName { get; set; }
            public string OS { get; set; }
            public string Hardware { get; set; }
            public string Kernel { get; set; }
            public string Duration { get; set; }
            public DateTime DeuDate { get; set; }
            public string Phase { get; set; }
            public string FoundInPhase { get; set; }
            public string FixedInPhase { get; set; }
            public string CodedBy { get; set; }
            public string CodedByName { get; set; }
            public string ShowToCustomer { get; set; }
            public string Keywords { get; set; }
            public string CreatorOnModifier { get; set; }
            public string ClosedDate { get; set; }
            public string LoginType { get; set; }
            public string ReviewActionID { get; set; }
            public string ChangeRequestID { get; set; }
            public string ChangeRequestName { get; set; }
            public string[] CustomFieldText { get; set; }
            public string[] CustomFieldCombo { get; set; }
            public string[] CustomFieldDate { get; set; }
            public string[] CustomFieldTextArea { get; set; }
            public string IssueCode { get; set; }
            public string ReportedTime { get; set; }
            public string RootCauseID { get; set; }
            public string RootCause { get; set; }
            public string DeliverableId { get; set; }
            public string Deliverable { get; set; }
            public string Complexity { get; set; }
            public string CorporateComplexity { get; set; }
            public string ProductVersionID { get; set; }
            public string ProductVersion { get; set; }
            public string ComponentID { get; set; }
            public string Component { get; set; }
            public string CustomerID { get; set; }
            public string Customer { get; set; }
            public string StatusChangeDate { get; set; }
            public string StatusChangeTime { get; set; }
            public string LastUpdatedDate { get; set; }
            public string Release { get; set; }
            public string Iteration { get; set; }
            public string UserStory { get; set; }
            public int NoOfIssues { get; internal set; }
            public bool ResultFlag { get; internal set; }
            public string Category { get; set; }
            public string UserName { get; set; }
            

            
        }

        public class UpdateIssueData
        {
            public string Allvalue { get; set; }
            public string CustomFieldsdata { get; set; }
        }
        public class SaveDiscussionClass
        {
            public string IssueID { get; set;}
            public string UserName { get; set;}
            public string CommentTextAreaValue { get; set;}
            public string StatusValue { get; set;}
            public bool ShowToCustomerVal { get; set;}
        }

        public class HistoryInfo
        {
            public string IssueID { get; set; }
            public string FieldName { get; set; }
            public string ChangedBy { get; set; }
        }
            public class ComboValues
        {
            public string FieldID { get; set; }
            public string FieldName { get; set; }
        }

        public class AllComboValues
        {
            public string ComboName { get; set; }
            public List<ComboValues> lstComboValues { get; set; }
        }

        public class IssueComboParameters
        {
            public string ComboNameList { get; set; }
            public IB_IssueDetailsController.CommonProperty commonProperty { get; set; }
        }
        public class IssuesPara
        {
            public int intIssueidID { get; set; }
            public int EmployeeID { get; set; }
            public int intProjectID { get; set; }
            public string LoginType { get; set; }
            public int LoginID { get; set; }
            public int CustomerID { get; set; }
            public int ProductVersionID { get; set; }
            public string strIssue { get; set; }
            public string m_strToken { get; set; }
            public string field { get; set; }
            public string UserName { get; set; }
            public int roleID { get; set; }
            

        }

        public class CommonProperty
        {
            public int ProjectId { get; set; }
            public int RoleId { get; set; }
            public int EmployeeId { get; set; }
            public string LoginType { get; set; }
            public int LoginId { get; set; }
            public string strMode { get; set; }
            public int IssueID { get; set; }
            public string ComboNameList { get; set; }
            public string Type { get; set; }
            public string DatabaseFieldName { get; set; }
            public bool FildFlag { get; set; }
            public int Customerid { get; set; }
           // public int SavedValue { get; set; }
        } 

        public class LayoutControl
        {
            public int LayOutSrNo { get; set; }
            public int LayOutID { get; set; }
            public int ColumnNo { get; set; }
            public int RowNo { get; set; }
            public bool ReadOnly { get; set; }
            public int UniqueId { get; set; }
            public bool AddMode { get; set; }
            public bool ReadOnlyAddMode { get; set; }
            public bool EditMode { get; set; }
            public bool ReadonlyEditMode { get; set; }
            public bool Mandatory { get; set; }
            public string UserFriendlyName { get; set; }
            public string FieldName { get; set; }
            public string TableFieldName { get; set; }
            public int ControlWidth { get; set; }
            public bool Active { get; set; }
            public bool ResultFlag { get; set; }
            public string ControlType { get; set; }
            public string Query { get; set; }

        }
        public class newIssueLayOutcontrol
        {

            public int ProjectId { get; set; }
            public int RoleId { get; set; }
            public string FieldID { get; set; }
            public string FieldName { get; set; }
            public string Type { get; set; }
            public int ReleaseID { get; set; }
            public string ReleaseName { get; set; }
            public CommonProperty commonProperty { get; set; }
            public string ReleaseFromProject { get; set; }//module componet
            public int ComponentID { get; set; }
            public string Component { get; set; }
            public int ScheduleID { get; set; }//Deliverable
            public string LabelSchedule { get; set; }
            public int ChangeRequestID { get; set; }
            public string ChangeRequestSummary { get; set; }
            public bool ResultFlag { get; set; }
            public string Description { get;  set; }
            public int ScheduleTypeID { get;  set; }
            public string Title { get;  set; }
            public string StartDate { get;  set; }
            public string IssueID { get;  set; }
            public string UserName { get; set; }
            public string Status { get; set; }
        }
    }

    public class AssignIssue
    {
        public string IssueId { get;  set; }
        public string ProjectId { get;  set; }
        public string EmployeeId { get;  set; }
        public string Duration { get;  set; }
        public string StartDate { get;  set; }
        public string EndDate { get;  set; }
        public string BillableYN { get;  set; }
        public string TaskTypeId { get;  set; }
        public string SubTaskTypeId { get;  set; }
        public string Summary { get;  set; }
        public string Description { get;  set; }
        public string ModuleName { get;  set; }
        public string DueDate { get;  set; }
        public string CreatedBy { get;  set; }
        public string DocumentTypeID { get; set; }
        public string DocumentSubTypeID { get; set; }
        public string RoleID { get; set; }
    }

    public class SubTaskTypeClass
    {
        public string SubTaskTypeID { get; internal set; }
        public string SubTaskType { get; internal set; }
    }

    public class TaskTypeClass
    {
        public string TaskTypeID { get; internal set; }
        public string TaskType { get; internal set; }
    }

    public class ResourcesClass
    {
        public string EmployeeID { get; internal set; }
        public string UserName { get; internal set; }
        public string Location { get; internal set; }
        public string RoleDescription { get; internal set; }
    }

    public class AttachmentClass
    {
        public string OriginalFileName { get; internal set; }
        public string FilePath { get; internal set; }
    }

    public class HistoryClass
    {
        public string FieldName { get; internal set; }
        public string ModifiedBy { get; internal set; }
    }

    public class ExpectedDate
    {
        public string ExpectedStartDate { get; internal set; }
        public string ExpectedEndDate { get; internal set; }
    }

    public class DiscussionClass
    {
        public int DiscussionID { get; internal set; }
        public string DiscussionDate { get; internal set; }
        public string Comments { get; internal set; }
        public string UserName { get; internal set; }
        public string ShowToCustomer { get; internal set; }
        public string ImageName { get; internal set; }
        public int IsDeleteable { get; internal set; }
        public int AttachmentCount { get; internal set; }
    }

    public class AssignHours
    {
        public string AllocatedLCETotal { get; set; }
        public string LCETotal { get; set; }
        public string ProjectBalanceEfforts { get; set; }
    }

    internal class ValidationData
    {
        public string ValidationID { get; internal set; }
        public string ValidationDescription { get; internal set; }
        public string ValidationMessage { get; internal set; }
        public string CreatedBy { get; internal set; }
        public string CreatedDate { get; internal set; }
        public int OrderNumber { get; internal set; }
        public int IsComparisonRule { get; internal set; }
    }

    internal class ModuleNameClass
    {
        public string FieldID { get; internal set; }
        public string FieldName { get; internal set; }
    }

    internal class CustomerClass
    {
        public string CustomerName { get; internal set; }
    }

    internal class DepartmentClass
    {
        public string FieldName { get; internal set; }
        public string UniqueID { get; internal set; }
    }

    internal class UserStoryClass
    {
        public string UserStoryID { get; internal set; }
        public string UserStoryName { get; internal set; }
    }

    internal class IterationClass
    {
        public string IterationID { get; internal set; }
        public string IterationName { get; internal set; }
    }

    internal class DeliverableClass
    {
        public string ScheduleID { get; internal set; }
        public string Title { get; internal set; }
    }
}



















