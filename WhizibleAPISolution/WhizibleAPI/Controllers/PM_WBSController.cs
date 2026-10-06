using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models;
using System.Web.Http;
using System.Web;
using System.IO;
using System.Configuration;
using System.Xml;
using Newtonsoft.Json;
using System.Runtime.InteropServices;

namespace WhizibleAPI.Controllers
{
    public class PM_WBSController : ApiController
    {

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetTabAccess([FromBody]WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "usp_Sel_tbl_UserAccess " + WBSParameters.RoleID + "," + WBSParameters.TagID + "," + WBSParameters.UserID + ",'" + WBSParameters.LoginType + "'";

                object TabAccess = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return TabAccess;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        //public List<NodeAccessList> GetNodesPlotAccess([FromBody]WbsParameter WBSParameters)
        public object GetNodesPlotAccess([FromBody] WbsParameter WBSParameters)

        {
            try
            {
                string strSQL = "usp_Sel_tbl_UI_NodeAccess " + WBSParameters.TagID + "," + WBSParameters.RoleID + "," + WBSParameters.UserID + ",'" + WBSParameters.LoginType + "'," + WBSParameters.ProjectID;

                List<NodeAccessList> NodeAccessLists = new List<NodeAccessList>();

                DataTable AccessTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow sdr in AccessTable.Rows)
                {
                    NodeAccessList nodeAccess = new NodeAccessList()
                    {
                        Add = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["A"], "0")),
                        Delete = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["D"], "0")),
                        Edit = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["E"], "0")),
                        View = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(sdr["V"], "0")),
                    };
                    NodeAccessLists.Add(nodeAccess);
                }

                return NodeAccessLists;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Get Max Items to show

        [Authorize]
        [HttpPost]
        public object GetMaxItemsToShow([FromBody] WbsParameter WbsParameter)
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


        //*****************************************************************************************************
        //Milestone code starts from here

        //Get Milestones List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object MilestoneList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                if (WBSParameters.QueryText == "Null")
                {
                    strSQL = "Exec usp_Whizible2_v_tbl_PM_Milestones " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",Null";
                }
                else
                {

                    strSQL = "Exec usp_Whizible2_v_tbl_PM_Milestones " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'";
                }

                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetProjectCurrency([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                strSQL = "Exec usp_Whizible2_ProjectCurreny " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "";
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Responsible Person on Project level for Deliverables
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetMLResponsiblePerson([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Responsible Person on Project level for Deliverables
        [HttpPost]
        public object GetAnalysisStatus()
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_Milestones_AnalysisStatus";

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Responsible Person on Project level for Deliverables
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetEditMLResponsiblePerson([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_sel_MileStone_ResponsiblePerson " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));

                DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //milestone save 

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object MilestoneSavedFilters([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ","
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ", '" + HttpUtility.UrlDecode(WBSParameters.FilterName) + "', '"
                                                                    + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'"
                + ",'" + HttpUtility.UrlDecode(WBSParameters.UserName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));


                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object MilestoneFilters([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + ",'"
                                                                      + HttpUtility.UrlDecode(WBSParameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetMLDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter ";
                strSQL += HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID));
                strSQL += ",'" + HttpUtility.UrlDecode(WBSParameters.LoginType);
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));

                QueryList defaultQuery = new QueryList();
                IDataReader drDefaultQuery;
                drDefaultQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drDefaultQuery.Read())
                {
                    defaultQuery.FilterID = Convert.ToInt32(drDefaultQuery["FilterID"]);
                    defaultQuery.FilterName = Convert.ToString(drDefaultQuery["FilterName"]);
                    defaultQuery.QueryText = Convert.ToString(drDefaultQuery["QueryText"]);
                }
                return defaultQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Set Default filter for Milestone tab
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetMLDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                strSQL += ",'" + HttpUtility.UrlDecode(WBSParameters.LoginType);
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Set Default Filter Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Click on Apply tick on MyFilters Milestone tab Filter data
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetWhereClause([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
                //IDataReader dt;
                //dt =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object MilestoneEditFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));

                QueryList EditQuery = new QueryList();
                IDataReader EditQueryFilter;
                EditQueryFilter = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (EditQueryFilter.Read())
                {
                    EditQuery.FilterID = Convert.ToInt32(EditQueryFilter["FilterID"]);
                    EditQuery.FilterName = Convert.ToString(EditQueryFilter["FilterName"]);
                    EditQuery.QueryText = Convert.ToString(EditQueryFilter["WhereClause"]);
                }
                return EditQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete Milestone Filter
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteMilestoneFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get sum of completion Percentage for all milestones for project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSumOfCompletionPercentage([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                int Sum;
                strSQL = "Exec usp_Whizible2_Sel_SumOf_CompletionPercentageOf_AllMilestones " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));

                Sum = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));

                return Sum;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get sum of Bill Amount for all milestones for project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSumOfBillAmount([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string strSQL1 = "";

                strSQL = "Exec usp_Whizible2_Sel_SumOf_AllBillAmountOf_Milestones " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + " ," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));
                object sumofBillAmount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                strSQL1 = "Exec usp_Whizible2_Sel_ProjectValue " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                //Added By Dipali V On 14th April 2020 For More data then Crash issue
                //object ProjectValue = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), "0"));
                object ProjectValue = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), "0"));
                //End of Added By Dipali V On 14th April 2020 For More data then Crash issue
                object[] GetValue = { sumofBillAmount, ProjectValue };
                return GetValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get sum of Bill Amount for all milestones for project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetProjectSumOfBillAmount([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string strSQL1 = "";
                if (WBSParameters.WBSFlag == "Sub")
                {
                    strSQL = "Exec usp_Whizible2_Sel_SumOf_AllBillAmountOfWBSAttribute " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.WBSFlag));

                }


                object sumofBillAmount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                strSQL1 = "Exec usp_Whizible2_Sel_ProjectValue " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                //Commented And Added By Usha Pandit On 15.04.2020 For converting Int to double
                //object ProjectValue = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), "0"));
                object ProjectValue = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), "0"));
                //End Of Added By Usha Pandit On 15.04.2020 For converting Int to double
                object[] GetValue = { sumofBillAmount, ProjectValue };
                return GetValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetProjectHours([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL1 = "";

                strSQL1 = "Exec usp_Whizible2_ProjectHours " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                object ProjectValue = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString), "0"));


                return ProjectValue;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Delete milestone milestones for project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteMilestone([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string strMsg;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_Milestones " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                strMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return strMsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //validation for Dates
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDateValidate([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string strMsg;
                strSQL = "Exec usp_Whizible2_Validate_StartAndEndDate " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.StartDate) + "','" + HttpUtility.UrlDecode(WBSParameters.EndDate) + "'";

                strMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return strMsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Add new Milestone
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertNewMilestone([FromBody] object[] objInsMilestone)
        {
            try
            {

                string strSQL;
                string result;


                strSQL = "EXEC Usp_Whizible2_Ins_tbl_PM_Milestones " + Convert.ToInt32(objInsMilestone[0]);
                if (objInsMilestone[1].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + Convert.ToInt32(objInsMilestone[1]);
                }

                strSQL += ",'" + objInsMilestone[2].ToString().Replace("'", "''") + "'";
                strSQL += ",'" + objInsMilestone[3].ToString() + "'";
                strSQL += ",'" + objInsMilestone[4].ToString() + "'";
                strSQL += ",'" + objInsMilestone[5].ToString().Replace("'", "''") + "'";

                if (objInsMilestone[6].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objInsMilestone[6];
                }

                strSQL += ",'" + objInsMilestone[7] + "'";
                strSQL += ",'" + objInsMilestone[8] + "'";
                strSQL += ",'" + objInsMilestone[9] + "'";

                if (objInsMilestone[10].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += ",'" + objInsMilestone[10] + "'";
                }

                if (objInsMilestone[11].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += ",'" + objInsMilestone[11] + "'";
                }
                if (objInsMilestone[12].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += ",'" + objInsMilestone[12] + "'";
                }
                if (objInsMilestone[13].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objInsMilestone[13];
                }
                if (objInsMilestone[14].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objInsMilestone[14];
                }

                strSQL += ",'" + objInsMilestone[15].ToString() + "'";

                if (objInsMilestone[16].ToString() == "Null")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += ",'" + objInsMilestone[16] + "'";
                }


                if (objInsMilestone[17].ToString() == "0")
                {
                    strSQL += ",Null";
                }
                else
                {
                    strSQL += "," + objInsMilestone[17] + "";
                }

                //strSQL = "EXEC Usp_Whizible2_Ins_tbl_PM_Milestones " + Convert.ToInt32(objInsMilestone[0]) + "," + Convert.ToInt32(objInsMilestone[1]) + ",'" + objInsMilestone[2].ToString().Replace("'", "''") + "','" + objInsMilestone[3].ToString() + "','" + objInsMilestone[4].ToString() + "','" + objInsMilestone[5].ToString().Replace("'", "''") + "'," + objInsMilestone[6] + ",'" + objInsMilestone[7] + "','" + objInsMilestone[8] + "','" + objInsMilestone[9] + "','" + objInsMilestone[10] + "','" + objInsMilestone[11] + "'," + objInsMilestone[12] + "," + objInsMilestone[13] + "," + objInsMilestone[14] + ",'" + objInsMilestone[15].ToString() + "','"+ objInsMilestone[16] + "'";

                //result =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);            
                //return result;

                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                // string NewResult;
                String[] spearator = { "&&" };
                String[] NewResult = result.ToString().Split(spearator, 2, StringSplitOptions.None);

                if (NewResult[0] == "Milestone Closed Successfully")
                {
                    string Flag = "0";
                    string strFromEmailID = "";
                    string strToEmailID = "";
                    string strCCToEmailID = "";
                    string strSubject = "", strMessage = "";
                    bool blnSendEmail, blnShowPopup;
                    string strProjectID = Convert.ToString(objInsMilestone[0]);
                    int intMilestoneID = Convert.ToInt32(objInsMilestone[1]);
                    int intEmployeeID = Convert.ToInt32(objInsMilestone[17]);
                    //Getting Email messages

                    DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 487", true, CommonController.connectionString);
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

                                EmailMessagesController.GetEmailMessage_487(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intMilestoneID, strProjectID, intEmployeeID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                            }

                        }
                    }
                    return Flag;
                }
                else
                {
                    return NewResult[0] + "||" + NewResult[1];
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Task details for Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetMLTaskDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_f_tbl_PM_ProjectAttributeTasks " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added By Dipali V On 17th Oct 2019 For Re-Open Functionality of Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GetMilestoneReOpen([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string result = "";
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;
                int intMilestoneID = Convert.ToInt32(WBSParameters.MilestoneID);
                string strProjectID = Convert.ToString(WBSParameters.ProjectID);
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_MileStone_ReOpenMileStone " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID)) + "";
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 488", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_488(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intMilestoneID, strProjectID, WBSParameters.UserID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }

                return Flag;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V On 17th Oct 2019 For Re-Open Functionality of Milestone

        //Get the Tasks related to the Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object ResourceDetailsForMilestone([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_PB_RD_ResourceDetailsForMilestone " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));
                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return tasktable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object CloseTask([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Upd_AssignedTasks_Updation_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskID));
                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize]
        [HttpPost]
        public object CloseMilestone([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Upd_tbl_PM_Milestone_CloseMilestone " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));
                CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return "Closed Milestone Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get History details for Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetMLHistoryDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_Milestones_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));


                DataTable Historytable;
                Historytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Historytable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Task details for Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetMLBaselineDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_PM_MileStones_RelatedDataSection " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));

                DataTable Baselinetable;
                Baselinetable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Baselinetable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Set Milestone Baselined
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetMilestoneBaselined([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Milestone_SetBaseline " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Set Milestone Baselined Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //clear Milestone Baselined
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ClearMilestoneBaselined([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Milestone_ClearBaseline " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Clear Baselined Milestone Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Milestone Revision details for Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetMLRevisionDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_PM_MilestonesRevision_Details " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));

                DataTable Revisiontable;
                Revisiontable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Revisiontable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        //commented and added by Aditya J. on 20-08-2026 for showing the closed projects in the dropdown
        //public object GetProjectList([FromBody] WbsParameter WBSParameters)
        //{
        //    try
        //    {
        //        //string strSQL = "";

        //        string strSQL = "Exec usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + "";

        //        if (WBSParameters.ProjectID == 0)
        //        {
        //            strSQL = strSQL + ", 0, 0, NULL, 1 ,'" + HttpUtility.UrlDecode(WBSParameters.LoginType) + "', 1, 0, 0, 0, NULL, NULL";
        //        }
        //        else
        //        {
        //            strSQL = strSQL + ", 0, 0, NULL, 1, '" + HttpUtility.UrlDecode(WBSParameters.LoginType) + "', 1, 0, 0, 0, NULL, " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
        //        }

        //        DataTable ProjectList;
        //        ProjectList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //        return ProjectList;

        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}
        public object GetProjectList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string UserID = HttpUtility.UrlDecode(
                    Convert.ToString(WBSParameters.UserID)
                );

                string LoginType = HttpUtility.UrlDecode(
                    WBSParameters.LoginType
                );

                string SessionProjectID = HttpUtility.UrlDecode(
                    Convert.ToString(WBSParameters.ProjectID)
                );

                string strSQL = "EXEC usp_Whizible2_Sel_AccessibleProjects_WithSelected " +
                                UserID + ",'" +
                                LoginType + "',1,0,'[Over] = ''0''','ProjectName ASC'," +
                                SessionProjectID;

                DataTable ProjectList = CommonFunctions.Data.GetDataTable(
                    strSQL,
                    true,
                    CommonController.connectionString
                );

                return ProjectList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(
                    HttpStatusCode.InternalServerError,
                    "Bad Request found"
                );
            }
        }
        //End of commented and added by Aditya J. on 20-08-2026 for showing the closed projects in the dropdown

        //Get Milestone Details in Edit Mode
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetMLEditDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Edit_v_tbl_PM_Milestones " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Milestone code ends here
        //***************************************************************************************************

        //*************************************************************************************************
        //Phase code starts here



        //Get Phase List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object PhaseList([FromBody] WbsParameter WBSParameters)
        {
            try{
                string strSQL;
                //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

                if (WBSParameters.QueryText == "" || WBSParameters.QueryText == "null")
                {
                    strSQL = "Exec usp_Whizible2_v_tbl_IB_Project_Phases " + HttpUtility.UrlDecode(WBSParameters.ProjectID.ToString()) + ",Null";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_v_tbl_IB_Project_Phases " + HttpUtility.UrlDecode(WBSParameters.ProjectID.ToString()) + "," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'";

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

        //To get the list of filter for logged user.
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetMyPhaseFiltersList([FromBody] WbsParameter WbsParameters)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(WbsParameters.ProjectID.ToString()) + "," + HttpUtility.UrlDecode(WbsParameters.TagID.ToString()) + ",'" + HttpUtility.UrlDecode(WbsParameters.LoginType) + "','" + HttpUtility.UrlDecode(WbsParameters.UserID.ToString()) + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            string strSQL;


        //Save the basic filter
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object PhaseSaveandUpdateBasicFilter([FromBody] WbsParameter WbsParameters)
        {
            try {
                string strSQL;

                if (WbsParameters.Flag == 1)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(WbsParameters.TagID.ToString()) + "," + HttpUtility.UrlDecode(WbsParameters.ProjectID.ToString()) + "," + HttpUtility.UrlDecode(WbsParameters.UserID.ToString()) + ",'" + HttpUtility.UrlDecode(WbsParameters.FilterName) + "','" + HttpUtility.UrlDecode(WbsParameters.LoginType) + "'," + "'" + HttpUtility.UrlDecode(WbsParameters.QueryText) + "'" + ",'" + HttpUtility.UrlDecode(WbsParameters.CreatedBy) + "'," + HttpUtility.UrlDecode(WbsParameters.Flag.ToString()) + " ," + HttpUtility.UrlDecode(WbsParameters.FilterID.ToString()) + "";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(WbsParameters.TagID.ToString()) + "," + HttpUtility.UrlDecode(WbsParameters.ProjectID.ToString()) + "," + HttpUtility.UrlDecode(WbsParameters.UserID.ToString()) + ",'" + HttpUtility.UrlDecode(WbsParameters.FilterName) + "','" + HttpUtility.UrlDecode(WbsParameters.LoginType) + "'," + "'" + HttpUtility.UrlDecode(WbsParameters.QueryText) + "'" + ",'" + HttpUtility.UrlDecode(WbsParameters.CreatedBy) + "'";
                }
                //strSQL.Replace("/", "");

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object CheckDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter " + HttpUtility.UrlDecode(WBSParameters.ProjectID.ToString()) + "," + HttpUtility.UrlDecode(WBSParameters.TagID.ToString()) + ",'"
                                                                                    + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + HttpUtility.UrlDecode(WBSParameters.UserID.ToString());

                QueryList DefaultQuery = new QueryList();
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



        //Edit saved filter data.
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetWhereClauseOfFilter([FromBody] int FilterID)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(FilterID.ToString());

                Object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //To set default filter
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody] WbsParameter WbsParameters)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(WbsParameters.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(WbsParameters.LoginType) + "'," + HttpUtility.UrlDecode(WbsParameters.UserID.ToString()) + "," + HttpUtility.UrlDecode(WbsParameters.TagID.ToString()) + "," + HttpUtility.UrlDecode(WbsParameters.FilterID.ToString()) + "," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.Flag));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Delete the filter
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteMyFilter([FromBody] int FilterID)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(FilterID.ToString());

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////Edit saved filter data.
        //[HttpPost]
        //[Authorize]
        //public DataTable EditFilterData([FromBody]int FilterID)
        //{
        //    string strSQL;
        //    strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(FilterID.ToString());

        //    DataTable dt =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetPhaseList([FromBody] int ProjectId)
        {
            try {
                string strSQL;
                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Phases_NotPresent " + HttpUtility.UrlDecode(ProjectId.ToString());

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetPhaseFilterList([FromBody] int ProjectId)
        {
            try {
                string strSQL;
                strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_PhaseeFilters " + HttpUtility.UrlDecode(ProjectId.ToString());

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //get validation filed applied
        //  [HttpPost]
        //[Authorize]
        //public DataTable getValidationFiled([FromBody]WbsParameter WBSParameters)
        //public DataTable getValidationFiled([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL;
        //    //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

        //    strSQL = "exec usp_Whizible2_Sel_v_tbl_UI_ControlTagMaster " + HttpUtility.UrlDecode(WBSParameters.TagID.ToString());

        //    DataTable dt = new DataTable();
        //    dt =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetRequiredPhaseFiled([FromBody] WbsParameter WBSParameters)
        {
            try {
                PhaseRequiredData requiredData = new PhaseRequiredData();
                string strSQL;
                //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;
                // ISNULL(Convert(varchar, f_tbl_PM_ProjectAttributeTasks.StartDate, 106),'''') as StartDate
                strSQL = "select ISNULL(Convert(varchar,expectedStartdate, 106),'''') as expectedStartdate,ISNULL(Convert(varchar,expectedenddate, 106),'''') as expectedenddate from tbl_PM_project where ProjectID=" + HttpUtility.UrlDecode(WBSParameters.ProjectID.ToString());

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow row in dt.Rows)
                {
                    requiredData.expectedStartdate = row["expectedStartDate"].ToString();
                    requiredData.expectedEnddate = row["expectedEnddate"].ToString();

                }
                strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Phases_SumOf_PercentEfforts " + HttpUtility.UrlDecode(WBSParameters.ProjectID.ToString());

                // DataTable dt1 = new DataTable();
                requiredData.PercentageEfforts = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                //foreach (DataRow row in dt1.Rows)
                //{
                //    requiredData.Phaselist.Add( row["Phase"].ToString());


                //}
                //strSQL = "";
                //strSQL = "SELECT ordernumber FROM v_tbl_IB_Project_Phases WHERE ProjectID=" + HttpUtility.UrlDecode(WBSParameters.ProjectID.ToString());

                //DataTable dt2 = new DataTable();
                //dt2 =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //foreach (DataRow row in dt2.Rows)
                //{
                //    requiredData.OrderNo.Add( row["ordernumber"].ToString());


                //}
                //strSQL = "";
                //strSQL = "SELECT RestrictByMinHours,MinHoursForDAEntry FROM tbl_PM_CompanyInformation";

                //DataTable dt3 = new DataTable();
                //dt3 =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //foreach (DataRow row in dt3.Rows)
                //{
                //    requiredData.PhaseRestrictByMinHours = row["RestrictByMinHours"].ToString();
                //    requiredData.PhaseMinHoursForDAEntry = row["MinHoursForDAEntry"].ToString();


                //}
                return requiredData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //insert phase
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SavePhase([FromBody] PhaseAttribute phaseAttribute)
        {
            try {
                HttpResponseMessage response;
                string strSQL;
                //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;
                try
                {

                    strSQL = "select dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HttpUtility.UrlDecode(phaseAttribute.EstimatedEfforts.ToString()) + "',2) ";
                    string EstimatedEfforts = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                    strSQL = "";
                    strSQL = "Exec usp_Whizible2_Ins_tbl_IB_Project_Phases " + HttpUtility.UrlDecode(phaseAttribute.ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(phaseAttribute.Phase) + "','" + HttpUtility.UrlDecode(phaseAttribute.EstimatedStartDate.ToString()) + "','" + HttpUtility.UrlDecode(phaseAttribute.EstimatedEndDate.ToString()) + "'," + HttpUtility.UrlDecode(phaseAttribute.PlannedResources.ToString()) + "," + HttpUtility.UrlDecode(phaseAttribute.PercentEfforts.ToString()) + "," + HttpUtility.UrlDecode(phaseAttribute.CurrentPhase.ToString()) + "," + HttpUtility.UrlDecode(phaseAttribute.ResponsiblePerson.ToString()) + "," + HttpUtility.UrlDecode(phaseAttribute.ordernumber.ToString()) + ",'" + HttpUtility.UrlDecode(phaseAttribute.CreatedBy) + "'," + float.Parse(HttpUtility.UrlDecode(EstimatedEfforts)) + "," + HttpUtility.UrlDecode(phaseAttribute.Flag.ToString()) + "," + HttpUtility.UrlDecode(phaseAttribute.PhaseId.ToString());
                    int PhaseId = int.Parse(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString());
                    response = Request.CreateResponse(HttpStatusCode.OK, PhaseId);

                }
                catch (Exception e)
                {

                    response = Request.CreateResponse(HttpStatusCode.BadRequest, e.Message);
                    // return response;
                }
                return response;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //insert phase
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public HttpResponseMessage GetPhaseData([FromBody] int PhaseId)
        {
            HttpResponseMessage response;
            string strSQL;
            //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;
            try
            {

                strSQL = "exec usp_Whizible2_sel_tbl_IB_Project_Phases_UsingPhaseId " + HttpUtility.UrlDecode(PhaseId.ToString());
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                response = Request.CreateResponse(HttpStatusCode.OK, dt);

                return response;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get validation filed applied
        //[HttpPost]
        //[Authorize]
        //public DataTable GetExistingNames([FromBody]string Query)
        //{
        //    string strSQL;
        //    //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

        //    strSQL = HttpUtility.UrlDecode(Query);

        //    DataTable dt = new DataTable();
        //    dt =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}
        //get phase responsible person edit mode
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetPhaseResponsiblePersonForEdit([FromBody] PhaseAttribute phaseAttribute)
        {
            try {
                string strSQL = "EXEC usp_Whizible2_sel_Phases_ResponsiblePerson " + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.PhaseId));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // deleted phase using Phase id
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeletePhase([FromBody] PhaseAttribute phaseAttribute)
        {
            try {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Del_tbl_IB_Project_Phases " + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.PhaseId)) + "," + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.ProjectID));
                //IDataReader dt;
                //dt =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //[Authorize]
        //[HttpPost]
        //public CompanyInformation GetRestrictByMinHours_MinHoursForDAEntry()
        //{
        //    string strSQL = "";
        //    strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";
        //    CompanyInformation Information = new CompanyInformation();
        //    IDataReader CmpInformation;
        //    CmpInformation =  CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
        //    if (CmpInformation.Read())
        //    {
        //        Information.RestrictByMinHours = Convert.ToBoolean(CmpInformation["RestrictByMinHours"]);
        //        Information.MinHoursForDAEntry = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0")), 2).ToString());
        //    }
        //    return Information;
        //}

        //get phase Task List

        [Authorize]
        [HttpPost]
        public object GetPhaseTaskList([FromBody] PhaseAttribute phaseAttribute)
        {
            try {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectAttributeTasks " + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.PhaseId)) + "," + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get phase Document List

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetPhaseDocumnetList([FromBody] PhaseAttribute phaseAttribute)
        {
            try {

                //Comment And Added By Riddhesh Patil on 9th March 2023 For Getting List of Attachment After Uploading  
                //string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.PhaseId)) + "," + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.wbsParamete.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.wbsParamete.RoleID));
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.PhaseId)) + "," + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(phaseAttribute.RoleID));
                //End of Comment And Added By Riddhesh Patil on 9th March 2023 For Getting List of Attachment After Uploading  
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get phase Document Category List
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetPhaseDocumnetCategoryList([FromBody] WbsParameter wbsParamete)
        {
            try {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentCategory_ForRole " + HttpUtility.UrlDecode(Convert.ToString(wbsParamete.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(wbsParamete.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get phase Document sub Category List
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetPhaseDocumnetSubCategoryList([FromBody] PhaseDocument phaseDocument)
        {
            try {

                //string strSQL = "EXEC usp_Sel_tbl_PM_DocumentSubCategory " + HttpUtility.UrlDecode(Convert.ToString(phaseDocument.Category)) + ", null ," + HttpUtility.UrlDecode(Convert.ToString(phaseDocument.wbsParamete.ProjectID));
                string strSQL = "EXEC usp_Sel_tbl_PM_DocumentSubCategory " + HttpUtility.UrlDecode(Convert.ToString(phaseDocument.Category)) + ", null ," + HttpUtility.UrlDecode(Convert.ToString(phaseDocument.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get phase Document sub Category List
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertDocumnetAttachment()
        {
            try {
                string msg = "";
                if (GetFileType())
                {
                    var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];
                    //var listAttachedDocuments = JsonConvert.DeserializeObject<List<WhizibleAPI.Models.Stakeholder.AttachedFileData>>(AttachedFileData);
                    var listAttachedDocuments = JsonConvert.DeserializeObject<List<PhaseDocument>>(AttachedFileData);
                    for (int i = 0; i < listAttachedDocuments.Count; i++)
                    {
                        var httpPostedFile = HttpContext.Current.Request.Files[i];
                        var SubCategory = "";
                        var Category = listAttachedDocuments[i].Category;
                        var ProjectID = listAttachedDocuments[i].wbsParamete.ProjectID;
                        if (listAttachedDocuments[i].SubCategory != null)
                        {
                            SubCategory = listAttachedDocuments[i].SubCategory;
                        }
                        else {
                            //SubCategory = null;

                        }

                        string DirectoryName;
                        if (SubCategory != "0")
                        {
                            DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName + "\\" + listAttachedDocuments[i].SubCategoryName;
                        }
                        else
                        {
                            DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName;
                        }

                        //var dateAttached = listAttachedDocuments[i].DateAttached;
                        var description = listAttachedDocuments[i].Description;
                        var CreatedDate = DateTime.Now;
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        float FileSize = httpPostedFile.ContentLength;
                        FileSize = FileSize / 1024;
                        string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                        FileExtention = FileExtention.Replace(".", "");
                        string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);
                        int UserId = listAttachedDocuments[i].wbsParamete.UserID;
                        string LoginType = listAttachedDocuments[i].wbsParamete.LoginType;

                        int TagID = listAttachedDocuments[i].wbsParamete.TagID;
                        int PhaseId = listAttachedDocuments[i].phaseAttribute.UniqueID;
                        string strCodeTemplate = "SETPL/" + listAttachedDocuments[i].CategoryName + "_/<Job Code>/<Serial Number>";
                        string categoryName = listAttachedDocuments[i].CategoryName;
                        string subcategoryName = listAttachedDocuments[i].SubCategoryName;
                        var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                        DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\SETPL_WHIZ_SM_-0208");
                        //if (!Directory.Exists(DirectoryPath+"\\"+categoryName))
                        //{
                        //    Directory.CreateDirectory(Path.GetDirectoryName(DirectoryPath + "\\" + categoryName));
                        //   // DirectoryPath = DirectoryPath  + categoryName;
                        //    if (Category!=0)
                        //    {

                        //Commented And Added By Usha Pandit On 16.06.2020 For creating folder for sub category, only if it exists
                        //string dir = DirectoryPath + categoryName + "\\" + subcategoryName;
                        string dir = "";
                        if (SubCategory != "0")
                        {
                            dir = DirectoryPath + categoryName + "\\" + subcategoryName;
                        }
                        else
                        {
                            dir = DirectoryPath + categoryName;
                        }
                        //End Of Added By Usha Pandit On 16.06.2020 For creating folder for sub category, only if it exists

                        if (!Directory.Exists(dir))
                        {

                            DirectoryInfo di = Directory.CreateDirectory(dir);

                        }


                        string ChangeRequestID = "NULL";





                        //var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);Ency
                        var fileName = httpPostedFile.FileName;
                        //+ System.IO.Path.GetExtension(httpPostedFile.FileName);
                        var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                        var attachmentId = 0;
                        filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);

                        //httpPostedFile.SaveAs(filePath);

                        //Commented and added by Chetan M on 8 june 2021 for Issue in Downloading zip and excel file
                        //FileUpload.cUpload cUpload;

                        //cUpload = new FileUpload.cUpload(Convert.ToString(HttpContext.Current.Request.Files.Keys[i]), dir);
                        //cUpload.OverwriteIfExists = false;
                        //cUpload.UploadFile();
                        httpPostedFile.SaveAs(filePath);
                        //End of Commented and added by Chetan M on 8 june 2021 for Issue in Downloading zip and excel file
                        //fileName = cUpload.
                        //string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + cUpload.UploadedFileName.Substring(0, cUpload.UploadedFileName.IndexOf('.')) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(PhaseId.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + fileName.Substring(0, fileName.IndexOf('.')) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(PhaseId.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        //string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(PhaseId.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                        msg = "File Uploaded Successfully";
                    }
                }
                else
                {
                    // msg = "Please upload valid files only";
                    msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                }
                return msg;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeletePhaseDocumnet([FromBody] int DocumentId)
        {
            try {

                string strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(DocumentId));
                // DataTable dt = new DataTable();
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object chkFilterExists([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "Exec usp_Whizible2_chk_FilterName_Exists_ForWBS '" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag)) + "','" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID)) + "','" + HttpUtility.UrlDecode(WBSParameters.FilterName).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ", " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));

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
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetPhaseHistoryList([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_Phase_AuditTrail " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UniqueID));

                DataTable HistoryList;
                HistoryList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return HistoryList;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Phase code ends here
        //*******************************************************************************************************************


        //******************************************************************************************************



        //************************************************************************************************
        //Sub Project code starts from here



        //************************************************************************************************
        //Sub Project code starts from here


        //Get SubProject List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object SubProjectList([FromBody] WbsParameter WBSParameters)
        {
            try{
                string strSQL;
                //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

                if (HttpUtility.UrlDecode(Convert.ToString(WBSParameters.QueryText)) == "" || HttpUtility.UrlDecode(Convert.ToString(WBSParameters.QueryText)) == "null")
                {
                    strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",Null";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + "'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.QueryText)) + "'";

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



        //Save the basic filter
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveSubProjectBasicFilter([FromBody] WbsParameter WbsParameters)
        {
            try {
                string strSQL;

                if (WbsParameters.Flag == 1)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.UserID)) + ",'" + HttpUtility.UrlDecode(WbsParameters.FilterName) + "','" + HttpUtility.UrlDecode(WbsParameters.LoginType) + "'," + "'" + HttpUtility.UrlDecode(WbsParameters.QueryText) + "'" + ",'" + HttpUtility.UrlDecode(WbsParameters.CreatedBy) + "'," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.Flag)) + " ," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.FilterID)) + "";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.UserID)) + ",'" + HttpUtility.UrlDecode(WbsParameters.FilterName) + "','" + HttpUtility.UrlDecode(WbsParameters.LoginType) + "'," + "'" + HttpUtility.UrlDecode(WbsParameters.QueryText) + "'" + ",'" + HttpUtility.UrlDecode(WbsParameters.CreatedBy) + "'";
                }
                //strSQL.Replace("/", "");

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //To get the list of filter for logged user.
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetMySubProjectFiltersList([FromBody] WbsParameter WbsParameters)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.TagID)) + ",'" + HttpUtility.UrlDecode(WbsParameters.LoginType) + "','" + HttpUtility.UrlDecode(Convert.ToString(WbsParameters.UserID)) + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Delete the filter
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteSubProjectFilter([FromBody] int FilterID)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + FilterID;

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Edit saved filter data.
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object EditSubProjectFilterData([FromBody] int FilterID)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query " + FilterID;

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Edit saved filter data.
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSubProjectWhereClauseOfFilter([FromBody] int FilterID)
        {
            try {
                string strSQL;
                strSQL = "Exec usp_Whizible2_tbl_Whizible2_Filter_Query_GetWhereClause " + FilterID;

                Object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetSubProjectDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",'" + WBSParameters.LoginType + "' ,"
                                                                                     + WBSParameters.UserID + "," + WBSParameters.TagID + "," + WBSParameters.FilterID + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object CheckSubProjectDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + ",'"
                                                                                    + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));

                QueryList DefaultQuery = new QueryList();
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
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetWhereClauseFilter([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_tbl_Whizible2_Filter_Query_GetWhereClause " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
                //IDataReader dt;
                //dt =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object SubProjectGetResponsiblePerson([FromBody] WbsParameter WBSParameters)
        {
            try {

                string strSQL = "EXEC  usp_Whizible2_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetResponsiblePhasePerson([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "EXEC  usp_Whizible2_GetResponsiblePerson " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get phase Document Category List
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetSubProjectDocumentCategoryList([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentCategory_ForRole " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object SubProjectGetCustomFieldMasterRowNumber([FromBody] WbsParameter WBSParameters)
        {
            try {
                //string layoutid;
                int MaxRow = 0, MaxColoumn = 0;

                string strsql = "Exec usp_Whizible2_Sel_tbl_PM_CustomFields_Master_MaxRows " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Type)) + ",'" + HttpUtility.UrlDecode(WBSParameters.strEntityName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.IsActive)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.LoginType) + "'";

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



            List<int> CustomfileId1 = new List<int>();
        //int CustomFieldID;
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        //public List<CustomFiledPloat_SubProject> SubProjectPloatCustomFields([FromBody]WbsParameter WBSParameters)
        public object SubProjectPloatCustomFields([FromBody] WbsParameter WBSParameters)

        {
            try {

                List<CustomFiledPloat_SubProject> cfp = new List<CustomFiledPloat_SubProject>();
                List<CustomFiledPloat_SubProject> CustomFieldIDs = new List<CustomFiledPloat_SubProject>();

                //DateTime ExpectedStartDate, ExpectedEndDate;

                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_RoleCustomFieldSecurity " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.strEntityName) + "','" + HttpUtility.UrlDecode(WBSParameters.LoginType) + "'";

                IDataReader sdr1;
                sdr1 = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                while (sdr1.Read())
                {
                    CustomfileId1.Add(Convert.ToInt32(sdr1["CustomFieldID"]));

                }

                if (WBSParameters.Type != null)
                {
                    string strSQL1 = "Exec usp_Whizible2_Sel_tbl_PM_CustomFields_Master " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",NULL," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.IsActive)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Type)) + ",'" + HttpUtility.UrlDecode(WBSParameters.strEntityName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.LoginType)) + "'";
                    //   strSQL += ProjectId;
                    DataTable taskListTable = CommonFunctions.Data.GetDataTable(strSQL1, true, CommonController.connectionString);

                    foreach (DataRow sdr in taskListTable.Rows)
                    {
                        CustomFiledPloat_SubProject layoutControl = new CustomFiledPloat_SubProject()
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
                            ControlHeight = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ControlHeight"].ToString(), "")),
                            ControlWidth = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["ControlWidth"].ToString(), "")),
                            //Added By Usha Pandit On 21.04.2020 For getting MaxLength property for custom fields
                            MaxLength = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxLength"].ToString(), "0")),
                            //End Of Added By Usha Pandit On 21.04.2020 For getting MaxLength property for custom fields
                            //IsCustomFieldAssigned = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(sdr["IsCustomFieldAssigned"].ToString(), "0")),
                            //Commented & Added By Rutuja D. on 17 Jun 2021 for Max & Min Value Validation Not Working for CustomField IssueID = 30162
                            MaxValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MaxValue"].ToString(), "0")),
                            MinValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(sdr["MinValue"].ToString(), "0")),
                            //End Of Commented & Added By Rutuja D. on 17 Jun 2021 for Max & Min Value Validation Not Working for CustomField IssueID = 30162

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


                return cfp;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //To get the validation message for custom fields.
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetValidationForCustomFields([FromBody] CustomFiledPloat_SubProject customFiled)
        {
            try {
                string VALIDATION;
                VALIDATION = Convert.ToString(customFiled.CustomValidation).Replace("[", "").Replace("]", "").Replace("\"", string.Empty).Trim();//.Replace(",", "").

                List<ValidationData_SubProject> ValidationData = new List<ValidationData_SubProject>();

                string strsql = "Exec usp_Whizible2_sel_tbl_UI_Validation_ValidationID ";

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
                        ValidationData_SubProject ValidationDataControl = new ValidationData_SubProject()
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


        //get validation filed applied
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object getValidationFiled([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL;
                //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

                strSQL = "exec usp_Whizible2_Sel_v_tbl_UI_ControlTagMaster " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID));

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        ////get validation filed applied
        //[HttpPost]
        //[Authorize]
        //public DataTable GetExistingNames([FromBody]string Query)
        //{
        //    string strSQL;
        //    //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

        //    strSQL = Query;

        //    DataTable dt = new DataTable();
        //    dt =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}


        //Get the Start Date and End Date for Particular Sub Project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetProjectStartDateEndDate([FromBody] int ProjectID)
        {
            try {
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


        //For Delete the Sub Project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteSubProject([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Del_tbl_PM_SubProject " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //To save the sub project into table
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AddNewSubProject([FromBody] WbsParameter WBSParameters)
        {
            try {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_SubProject '" + HttpUtility.UrlDecode(WBSParameters.FieldNames) + "','" + HttpUtility.UrlDecode(WBSParameters.FieldValues) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Update the SubProject Fields.
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateSubProject([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_SubProject '" + HttpUtility.UrlDecode(WBSParameters.FieldNameValue.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Update the estimated effort for Sub Project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateEstimatedEffortsForWBS([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_upd_EstimatedEffortsForWBS " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.WorkHour)) + "','" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.WorkMinute)) + "',2";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


            //Get the sub project data to display in Edit mode.
            [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSubProjectData([FromBody] int SubProjectID)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_EditSubProject_v_tbl_PM_SubProject " + SubProjectID;

                object dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Get the Custom Field Values for Edit Purpose
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSubProjectCustomFieldValues([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Select ";
                if ((WBSParameters.SubProjectCustomFieldsName).IndexOf("Date") > -1)
                {
                    strSQL += "ISNULL(Convert(varchar,";
                    strSQL += WBSParameters.SubProjectCustomFieldsName + ",106), '') as ";
                }
                strSQL += WBSParameters.SubProjectCustomFieldsName;
                strSQL += " From tbl_PM_SubProject where SubProjectId = " + WBSParameters.SubProjectID;

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Get the Tasks related to the Sub Project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object ResourceDetailsForSubProjects([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_PB_RD_ResourceDetailsForSubProjects " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object ResourceDetailsForPhase([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_PB_RD_ResourceDetailsForPhase " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.PhaseID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        ////Get the Tasks related to the Sub Project
        //[HttpPost]
        //[Authorize]
        //public DataTable GetTaskList([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL = "";

        //    strSQL = "Exec usp_Whizible2_f_tbl_PM_ProjectAttributeTasks " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));


        //    DataTable tasktable;
        //    tasktable =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return tasktable;

        //}


        //Get the History for Sub Project
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSubProjectHistory([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_SubProject_AuditTrail " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        ////Get the History Filter options for Sub Project
        //[HttpPost]
        //[Authorize]
        //public DataTable GetSubProjectHistoryFilter([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL = "";
        //    strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_SubProject_AuditTrail_HistoryFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag));
        //    DataTable tasktable;
        //    tasktable =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
        //    return tasktable;
        //}


        //Get Baseline details for SubProject
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSubProjectBaselineDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_PM_SubProject_RelatedDataSection " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));

                DataTable Baselinetable;
                Baselinetable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Baselinetable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Set SubProject Baselined
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetSubProjectBaselined([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_upd_tbl_pm_subproject_SetBaseLineDates " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Set SubProject Baselined Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //clear SubProject Baselined
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ClearSubProjectBaselined([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_upd_tbl_pm_subproject_ClearBaseLineDates " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Clear Baselined SubProject Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //[Authorize]
        //[HttpPost]
        //public object CloseTask([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL = "Exec usp_Upd_AssignedTasks_Updation_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskID));
        //    object result =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

        //    return result;
        //}





        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CloseSubProject([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_PM_SubProject_CloseSubProject " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));
                CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);


                DataTable EmailDataTable;
                EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 485", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_485(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, WBSParameters.SubProjectID, WBSParameters.ProjectID, WBSParameters.UserID);

                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                        }
                    }
                }
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ReopenSubProject([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_PM_SubProject_ReOpenSubProject " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));
                CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                DataTable EmailDataTable;
                EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 486", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_486(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, WBSParameters.SubProjectID, WBSParameters.ProjectID, WBSParameters.UserID);

                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                        }
                    }
                }
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetSendMailForReadyBilling([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                DataTable EmailDataTable;
                EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 22", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_22(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, WBSParameters.MilestoneID.ToString(), WBSParameters.ProjectID.ToString(), WBSParameters.UserID.ToString());

                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);

                        }
                    }
                }
                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //Sub Project code ends here
        //*****************************************************************************************************


        //Module Code Starts here


        //Get Milestones List
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object ModuleList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                if (WBSParameters.QueryText == "Null")
                {
                    strSQL = "Exec usp_Whizible2_v_tbl_PM_Module " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",Null";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_v_tbl_PM_Module " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + "'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.QueryText)) + "'";
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

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ModuleSavedFilters([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + WBSParameters.TagID + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ","
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ", '" + HttpUtility.UrlDecode(WBSParameters.FilterName) + "', '"
                                                                    + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'"
                                                                    + ",'" + HttpUtility.UrlDecode(WBSParameters.UserName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object ModuleFilters([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + WBSParameters.TagID + ",'"
                                                                      + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
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
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ModuleSetDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ,"
                                                                                     + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + "," + WBSParameters.TagID + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object ModuleGetDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + WBSParameters.TagID + ",'"
                                                                                    + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));

                QueryList DefaultQuery = new QueryList();
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
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ModuleDeleteFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec   usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
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
        [Authorize]
        public object ModuleEditFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                //string strSQL = "";

                //strSQL = "Exec   usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query " + WBSParameters.FilterID;
                //DataTable dt = new DataTable();
                //dt =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                //return dt;
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_sel_ByFilterID_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));

                QueryList EditQuery = new QueryList();
                IDataReader EditQueryFilter;
                EditQueryFilter = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (EditQueryFilter.Read())
                {
                    EditQuery.FilterID = Convert.ToInt32(EditQueryFilter["FilterID"]);
                    EditQuery.FilterName = Convert.ToString(EditQueryFilter["FilterName"]);
                    EditQuery.QueryText = Convert.ToString(EditQueryFilter["WhereClause"]);
                }
                return EditQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Dipali V On 17th Oct 2019 For Re-Open Functionality of Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetModuleReOpen([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string result = "";
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;
                int intMilestoneID = Convert.ToInt32(WBSParameters.MilestoneID);
                string strProjectID = Convert.ToString(WBSParameters.ProjectID);
                strSQL = "Exec usp_Upd_tbl_PM_Module_ReOpenModule " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MilestoneID)) + "";
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 484", true, CommonController.connectionString);
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
                            EmailMessagesController.GetEmailMessage_488(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intMilestoneID, strProjectID, WBSParameters.UserID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }

                return Flag;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        //End of Added By Dipali V On 17th Oct 2019 For Re-Open Functionality of Milestone
        //Get the Tasks related to the Milestone


        //Module code ends here
        //************************************************************************************

        //New Added Code
        //************************************************************************************


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetResponsiblePerson([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "EXEC  usp_Whizible2_tbl_PM_ProjectEmployeeRole " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
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
        [HttpPost]

        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertNewModule([FromBody] object[] ObjModuleValues)
        {
            try
            {

                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_Module " + Convert.ToInt32(ObjModuleValues[0].ToString()) + "," + ObjModuleValues[1].ToString() + "," + ObjModuleValues[2].ToString() + "," + ObjModuleValues[3].ToString() + ","
                                                                 + ObjModuleValues[4].ToString() + "," + ObjModuleValues[5].ToString() + "," + ObjModuleValues[6].ToString() + "," + ObjModuleValues[7].ToString()
                                                                 + "," + ObjModuleValues[8].ToString() + ",'" + ObjModuleValues[9].ToString() + "'," + ObjModuleValues[10].ToString() + "," + ObjModuleValues[11].ToString();

                object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return result;
                //  String[] spearator = { "&&" };
                //String[] NewResult = result.ToString().Split(spearator, 2, StringSplitOptions.None);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




            [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteModule([FromBody]WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Del_tbl_PM_Modules " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                //IDataReader dt;
                //dt =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object EditModule([FromBody] int ModuleID)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_EditModule_v_tbl_PM_Module " + HttpUtility.UrlDecode(Convert.ToString(ModuleID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetResponsiblePersonForEdit([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_sel_Module_ResponsiblePerson " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get validation filed applied
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetExistingNames([FromBody] string Query)
        {
            try
            {
                string strSQL;
                //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

                strSQL = Query;

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////validation for Dates
        //[HttpPost]
        //[Authorize]
        //public string GetDateValidate([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL = "";
        //    string strMsg;
        //    if (WBSParameters.StartDate == "" || WBSParameters.EndDate == "")
        //    {
        //        strSQL = "Exec usp_Whizible2_Validate_StartAndEndDate " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",NULL,NULL";

        //    }
        //    else
        //    {
        //        strSQL = "Exec usp_Whizible2_Validate_StartAndEndDate " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.StartDate) + "','" + HttpUtility.UrlDecode(WBSParameters.EndDate) + "'";
        //    }

        //    strMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

        //    return strMsg;
        //}

        //Get Task details for Module
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetTaskList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_f_tbl_PM_ProjectAttributeTasks " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get the Tasks related to the Module
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object ResourceDetailsForModule([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_PB_RD_ResourceDetailsForModule " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get History details for Module
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetHistoryList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_Module_AuditTrail " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UniqueID));

                DataTable HistoryList;
                HistoryList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return HistoryList;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get History details for Module
        [HttpPost]
        [Authorize]
        public object GetComplexity()
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_Module_Complexity ";

                DataTable Complexity;
                Complexity = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Complexity;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get History Filter List details for Module
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetHistoryFilterList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_Module_AuditTrail_HistoryFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UniqueID)) + ","
                                                                                                   + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ","
                                                                                                   + WBSParameters.Flag;

                DataTable HistoryFilter;
                HistoryFilter = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return HistoryFilter;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get BaseLine details for Module
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetBaseLineDetailList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_PM_Module_RelatedDataSection " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID));

                DataTable BaselineDetailList;
                BaselineDetailList = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return BaselineDetailList;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Set Module Baselined
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetModuleBaselined([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible_Upd_tbl_PM_Module_SetBaseline " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Set Module Baselined Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //clear Milestone Baselined
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ClearModuleBaselined([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Module_ClearBaseline " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Clear Baselined Module Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //get phase Document sub Category List
        [Authorize]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertSubProjectDocumnetAttachment()
        {
            try
            {
                string msg = "";
                if (GetFileType())
                {
                    var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];
                    //var listAttachedDocuments = JsonConvert.DeserializeObject<List<WhizibleAPI.Models.Stakeholder.AttachedFileData>>(AttachedFileData);
                    var listAttachedDocuments = JsonConvert.DeserializeObject<List<PhaseDocument>>(AttachedFileData);
                    for (int i = 0; i < listAttachedDocuments.Count; i++)
                    {
                        var httpPostedFile = HttpContext.Current.Request.Files[i];
                        var Category = listAttachedDocuments[i].Category;
                        var ProjectID = listAttachedDocuments[i].wbsParamete.ProjectID;
                        var SubCategory = listAttachedDocuments[i].SubCategory;
                        string DirectoryName;
                        if (SubCategory != "0")
                        {
                            DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName + "\\" + listAttachedDocuments[i].SubCategoryName;
                        }
                        else
                        {
                            DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName;
                        }

                        //var dateAttached = listAttachedDocuments[i].DateAttached;
                        var description = listAttachedDocuments[i].Description;
                        var CreatedDate = DateTime.Now;
                        string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
                        float FileSize = httpPostedFile.ContentLength;
                        FileSize = FileSize / 1000;
                        string FileExtention = Path.GetExtension(httpPostedFile.FileName);
                        FileExtention = FileExtention.Replace(".", "");
                        string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);
                        int UserId = listAttachedDocuments[i].wbsParamete.UserID;
                        string LoginType = listAttachedDocuments[i].wbsParamete.LoginType;

                        int TagID = listAttachedDocuments[i].wbsParamete.TagID;
                        int SubProjectID = listAttachedDocuments[i].phaseAttribute.SubProjectID;
                        string strCodeTemplate = "SETPL/" + listAttachedDocuments[i].CategoryName + "_/<Job Code>/<Serial Number>";
                        string categoryName = listAttachedDocuments[i].CategoryName;
                        string subcategoryName = listAttachedDocuments[i].SubCategoryName;
                        var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
                        DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\SETPL_WHIZ_SM_-0208");
                        //if (!Directory.Exists(DirectoryPath+"\\"+categoryName))
                        //{
                        //    Directory.CreateDirectory(Path.GetDirectoryName(DirectoryPath + "\\" + categoryName));
                        //   // DirectoryPath = DirectoryPath  + categoryName;
                        //    if (Category!=0)
                        //    {
                        string dir = DirectoryPath + categoryName + "\\" + subcategoryName;
                        if (!Directory.Exists(dir))
                        {

                            DirectoryInfo di = Directory.CreateDirectory(dir);
                            //  Directory.CreateDirectory(Path.GetDirectoryName(DirectoryPath + "\\" + categoryName ));
                            //DirectoryPath= DirectoryPath+ "\\" + subcategoryName;
                            //if (SubCategory != 0)
                            //{
                            //    dir = dir + "\\" + subcategoryName;
                            //    if (!Directory.Exists(dir))
                            //    {

                            //        Directory.CreateDirectory(Path.GetDirectoryName(dir));

                            //    }

                            //}
                        }
                        //else
                        //{
                        //    if (SubCategory!=0)
                        //    {
                        //       string subdir = DirectoryPath +  categoryName+"\\" + subcategoryName;
                        //        if (!Directory.Exists(subdir))
                        //        {
                        //            DirectoryInfo di = Directory.CreateDirectory(subdir);
                        //            // Directory.CreateDirectory(Path.GetDirectoryName(subdir));

                        //        }

                        //    }
                        //}

                        //    }
                        //}

                        string ChangeRequestID = "NULL";

                        //var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                        //var fileName = httpPostedFile.FileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
                        var fileName = httpPostedFile.FileName;
                        var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
                        var attachmentId = 0;
                        filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);
                        // httpPostedFile.SaveAs(filePath);
                        FileUpload.cUpload cUpload;

                        cUpload = new FileUpload.cUpload(Convert.ToString(HttpContext.Current.Request.Files.Keys[i]), dir);
                        cUpload.OverwriteIfExists = false;
                        cUpload.UploadFile();
                        //fileName = cUpload.
                        string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + cUpload.UploadedFileName.Substring(0, cUpload.UploadedFileName.IndexOf('.')) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(SubProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        //string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description.Replace("'", "''")) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(SubProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
                        object result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                        //msg = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Ins_tbl_PM_ProjectContacts_Attachments "
                        //                                                                    + projectid + ","
                        //                                                                     + ProjectContactID + ",'"
                        //                                                                    + httpPostedFile.FileName + "','"
                        //                                                                    + fileName + "','"
                        //                                                                    + AttachedBy + "','"
                        //                                                                    + LoginType + "','"
                        //                                                                    + description + "', " +
                        //                                                                    attachmentId + " ",
                        //                                                                    true, CommonController.connectionString
                        //                                                                    ));
                        msg = "File Uploaded Successfully";
                    }
                }
                else
                {
                    msg = "Only files with extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE are  allowed!!!";
                }
                return msg;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        //[Authorize]
        //[HttpPost]
        //public object CloseTask([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL = "Exec usp_Upd_AssignedTasks_Updation_ProjectClosure " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskFlag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TaskID));
        //    object result =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

        //    return result;
        //}

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CloseModule([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Module_CloseModule " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID));
                CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                //return "Closed Module Successfully";
                string Flag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string intModuleID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ModuleID));
                string strProjectID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                string strEmployeeID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                string strSubject = "", strMessage = "";

                bool blnSendEmail, blnShowPopup;

                //Getting Email messages

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 483", true, CommonController.connectionString);
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

                            EmailMessagesController.GetEmailMessage_483(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intModuleID, strProjectID, strEmployeeID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }
                return Flag;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //*****************************************************************************************************
            //Project Deliverables code starts from here

            //Get Project Deliverables List
            [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDeliverablesList([FromBody]WbsParameter WBSParameters)
        {
            try { 
            string strSQL = "";
            if (WBSParameters.QueryText == "Null")
            {
                strSQL = "Exec usp_Whizible2_v_tbl_PM_OtherSchedules " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",Null";
            }
            else
            {
                strSQL = "Exec usp_Whizible2_v_tbl_PM_OtherSchedules " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'";
            }

            System.Data.DataTable dt = new System.Data.DataTable();
            dt =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Responsible Person on Project level for Deliverables
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDlvResponsiblePerson([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_sel_Deliverable_ResponsiblePerson " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Requested By on Project level for Deliverables
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDlvRequestedBy([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_sel_Deliverable_RequestedBy " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Project Sites on Project level for Deliverables
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDlvProjectSites([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectSites_ForDeliverable " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get deliverable status
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDlvProjectStatus([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_IB_Project_Type_Status_Deliverables Null," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(WBSParameters.UserName) + "',Null";
                DataTable DlvStatus;

                DlvStatus = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return DlvStatus;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Work Package on Project level for Deliverables
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDlvWorkPackage([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectPackagesFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDelivarablRequestedBy([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_sel_OtherSchedules_RequestedBy " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDelivarablResponsiblePerson([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_sel_Deliverable_ResponsiblePersondetails " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetDelivarablStatus([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Type_Status_DeliverablesDetails " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserName) + "'");

                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeliverableSavedFilters([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Ins_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ","
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ", '" + HttpUtility.UrlDecode(WBSParameters.FilterName) + "', '"
                                                                    + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'"
                                                                    + ",'" + HttpUtility.UrlDecode(WBSParameters.UserName) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get deliverables filter list
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDlvFiltersList([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_sel_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + ",'"
                                                                      + HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                System.Data.DataTable dt;
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Set Default filter for Deliverable tab
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDeliverableDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Upd_tbl_Whizible2_Filter_Query_SetDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                strSQL += ",'" + HttpUtility.UrlDecode(WBSParameters.LoginType);
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Set Default Filter Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Default filter for Deliverable tab
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetDlvDefaultFilter([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_tbl_Whizible2_Filter_Query_GetDefaultFilter ";
                strSQL += HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                strSQL += "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID));
                strSQL += ",'" + HttpUtility.UrlDecode(WBSParameters.LoginType);
                strSQL += "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));

                QueryList defaultQuery = new QueryList();
                IDataReader drDefaultQuery;
                drDefaultQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drDefaultQuery.Read())
                {
                    defaultQuery.FilterID = Convert.ToInt32(drDefaultQuery["FilterID"]);
                    defaultQuery.FilterName = Convert.ToString(drDefaultQuery["FilterName"]);
                    defaultQuery.QueryText = Convert.ToString(drDefaultQuery["QueryText"]);
                }
                return defaultQuery;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get Default filter for Deliverable tab
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetDeliverableType([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_ProjectSchedules " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                DataTable DlvType;
                DlvType = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return DlvType;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Default filter for Deliverable tab
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetDlvScheduleFieldConfig([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_tbl_CNF_ScheduleFieldConfig " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID));
                DataTable DlvField;
                DlvField = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return DlvField;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetCombovalues([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL;
                strSQL = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SQL));
                DataTable DlvField;
                DlvField = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                DlvField.Columns[0].ColumnName = "ControlID";
                DlvField.Columns[1].ColumnName = "ControlValue";
                return DlvField;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetCodeTemplate([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "EXEC Usp_Whizible2_Chk_CodeTemplateEditable " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object IsDuplicatecodetempalte([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_IsDuplicate_DocumentNo " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.DocumentNo.Replace("'", "''"))) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object IsDuplicateTitle([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_IsDuplicate_Title " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Title.Replace("'", "''"))) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        [Authorize]
        ////Added by imran on 12-09-2022
        //[Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDelivarable([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string strUniqueID = "";
                string result = "";

                strSQL = "Exec usp_Whizible2_Upd_Ins_tbl_PM_OtherSchedules " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID)) + ",'"
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.DocumentNo.Replace("'", "''"))) + "', '" + HttpUtility.UrlDecode(WBSParameters.Title.Replace("'", "''")) + "', '"
                                                                    + HttpUtility.UrlDecode(WBSParameters.Description.Replace("'", "''")) + "' ," + "'" + HttpUtility.UrlDecode(WBSParameters.StartDate) + "'"
                                                                    + ",'" + HttpUtility.UrlDecode(WBSParameters.StartTime) + "','" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.EndDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.CompletionTime)) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Efforts)) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Priority)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RequestedBy)) + "',"
                + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Responsible)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Status)) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Billable)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.OnHold)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Void)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.BillAmount)) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID))
                + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));

                // object dtnew =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                // object arrDynamicFields = WBSParameters.arrDynamicFields;

                // string NewResult;
                String[] spearator = { "&&" };
                String[] NewResult = result.ToString().Split(spearator, 2, StringSplitOptions.None);
                if (NewResult[0] != "")
                {
                    CommonFunctions.Data.InsertOrUpdateData("usp_upd_tbl_PM_OtherSchedule_CodeTemplate " + NewResult[0], true, CommonController.connectionString);


                }

                string strSQL1 = "";

                strSQL1 = "Exec usp_Whizible2_UPD_tbl_PM_OtherSchedules '" + HttpUtility.UrlDecode(WBSParameters.FieldNameValue) + "'," + NewResult[0] + "";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString);


                string Flag = "0";
                string IsChangestatusFlag = "0";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string ScheduleID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));
                string strProjectID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                string strEmployeeID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                string strSubject = "", strMessage = "";

                bool blnSendEmail, blnShowPopup;

                //Getting Email messages

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 471", true, CommonController.connectionString);
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

                            EmailMessagesController.GetEmailMessage_471(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ScheduleID, strProjectID, strEmployeeID);
                            EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }
                // return Flag;
                if (WBSParameters.IsStausonchange == 1)
                {

                    DataTable StatusEmailDataTable = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_tbl_PM_EmailMessages 439", true, CommonController.connectionString);
                    foreach (DataRow mailRow in StatusEmailDataTable.Rows)
                    {
                        blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                        blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                        if (blnSendEmail == true)
                        {
                            if (blnShowPopup == true)
                            {
                                IsChangestatusFlag = "1";
                            }
                            else
                            {

                                EmailMessagesController.GetEmailMessage_439(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ScheduleID, strProjectID, strEmployeeID);
                                EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                            }

                        }
                    }
                }

                return result + "&&" + Flag + "&&" + IsChangestatusFlag;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDeliveriableCustomFieldValues([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Select ";
                if ((WBSParameters.SubProjectCustomFieldsName).IndexOf("date") > -1)
                {
                    strSQL += "ISNULL(Convert(varchar,";
                    strSQL += WBSParameters.SubProjectCustomFieldsName + ",106), '') as ";
                }
                strSQL += WBSParameters.SubProjectCustomFieldsName;
                strSQL += " From tbl_PM_OtherSchedules where ScheduleID = " + WBSParameters.ScheduleID;

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDeliverablesDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible_tbl_PM_OtherSchedules " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeletedSchedule([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string strMsg;
                string strResult = "";

                strSQL = "Exec usp_Whizible2_Del_tbl_PM_OtherSchedules " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));

                strMsg = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                //if (strMsg == "1") {
                //    strResult = "Project Deliverables Deleted Succesfully";
                //}
                //else {
                //    strResult = "Project Deliverables can not deleted , is in Used";
                //}

                return strMsg;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object ResourceDetailsForDeli([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_PB_RD_ResourceDetailsForDeliverable " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object CheckDeliverablesOnholdVoid([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_whizible2_tbl_PM_OtherSchedulesIsVoidOnHold " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object CheckDeliverablesPlanedOrNot([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_Check_For_ActiveTasks_For_Deliverable " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object CheckProjectPractice([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_CheckProjectPractice " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));


                DataTable tasktable;
                tasktable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return tasktable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Get History details for Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDelHistoryDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_Whizible2_PM_Deli_AuditTrail_History " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));


                DataTable Historytable;
                Historytable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Historytable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize]
        public object GetPlanDeliverable([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_ExcuDeliverableDetails " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID));


                DataTable PlnDeli;
                PlnDeli = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return PlnDeli;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetExcTemplate([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Get_TemplateName_Published " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));


                DataTable ExcTemplDeli;
                ExcTemplDeli = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ExcTemplDeli;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetResources_ExpectedDates([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_Deliverable_Template_Role_Resource_Tasks " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TemplateID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RevisionNo));


                DataTable ExcTemplDeli;
                ExcTemplDeli = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return ExcTemplDeli;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetImpactImpactBy([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string ImapactBy = "";

                ImapactBy = "Exec usp_Whizible2_tbl_PM_ProjectEmployeeRole_DeliveibaleImpact " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                //+"," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TemplateID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RevisionNo));


                DataTable ExcImapactBy;
                ExcImapactBy = CommonFunctions.Data.GetDataTable(ImapactBy, true, CommonController.connectionString);
                return ExcImapactBy;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetClasscification([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string SQLClassification = "";

                SQLClassification = "Exec usp_Whizible2_Sel_tbl_IB_Project_Sub_Type_Classification " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));
                //+"," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TemplateID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RevisionNo));


                DataTable Classification;
                Classification = CommonFunctions.Data.GetDataTable(SQLClassification, true, CommonController.connectionString);
                return Classification;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetApprovedBy([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string SQLApprovedby = "";

                SQLApprovedby = "Exec usp_Whizible2_sel_app_tbl_PM_CustomerContact " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                //+"," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TemplateID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RevisionNo));

                DataTable Approvedby;
                Approvedby = CommonFunctions.Data.GetDataTable(SQLApprovedby, true, CommonController.connectionString);
                return Approvedby;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveImpact([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";
                string strUniqueID = "";
                string result = "";
                strSQL = "Exec usp_Whizible2_Upd_Ins_tbl_PM_OtherSchedulesimpact " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleTypeID)) + ",'"
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Classification)) + "', " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Impact)) + ", '"
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ImpactDate)) + "' ," + "'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ReasonOfchanges.Replace("'", "''"))) + "'"
                                                                    + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ImpactApprovedby)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ImpactApprovedDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Remarks.Replace("'", "''"))) + "','"
                + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ImpactAnalysisApprovedByCustomer)) + "'," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));


                result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                // object arrDynamicFields = WBSParameters.arrDynamicFields;

                // string NewResult;
                //String[] spearator = { "&&" };
                //String[] NewResult = result.ToString().Split(spearator, 2, StringSplitOptions.None);

                return result;


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        public object GetImpactAnylsisdetails([FromBody] int GlobalScheduleID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_sel_StartDate_EndDate_tbl_PM_project " + GlobalScheduleID;

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
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDeliverablesCustAMC([FromBody] int ScheduleID)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_whizible2_v_tbl_CRM_Customer_Deliverable_TimeSpan " + ScheduleID;

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //*****************************************************************************************************
        //Project Deliverables code Ends here




        //*****************************************************************************************************
        //Common controller for all tab

        //Delete Filter
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilterData([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_del_tbl_Whizible2_Filter_Query " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));

                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Filter Deleted Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Edit filter data.
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object EditFilterData([FromBody] int FilterID)
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


        ////get validation filed applied
        //[HttpPost]
        //[Authorize]
        //public DataTable getValidationFiled([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL;
        //    //strSQL = "Exec usp_Whizible2_v_tbl_PM_SubProject " + WBSParameters.ProjectID;

        //    strSQL = "exec usp_Whizible2_Sel_v_tbl_UI_ControlTagMaster " + WBSParameters.TagID;

        //    DataTable dt = new DataTable();
        //    dt =  CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

        //    return dt;
        //}

        //get min hours for da Entry

        [HttpPost]
        public object GetRestrictByMinHours_MinHoursForDAEntry()
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_RestrictByMinHours_MinHoursForDAEntry ";
                CompanyInformation Information = new CompanyInformation();
                IDataReader CmpInformation;
                CmpInformation = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (CmpInformation.Read())
                {
                    Information.RestrictByMinHours = Convert.ToBoolean(CmpInformation["RestrictByMinHours"]);
                    //Commented And Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                    //Information.MinHoursForDAEntry = float.Parse(Math.Round(Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0")), 2).ToString());
                    Information.MinHoursForDAEntry = CommonFunctions.Data.CheckIsDBNull(CmpInformation["MinHoursForDAEntry"], "0").ToString();
                    //End Of Added By Usha Pandit On 18.06.2020 For getting exact value for MinHoursForDAEntry
                }
                return Information;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //get Documents List
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetDocumentsList([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RoleID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get  Document Category List
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetDocumnetCategoryList([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_DocumentCategory_ForRole " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.RoleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //get Document sub Category List
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GetDocumnetSubCategoryList([FromBody] Document AttachmentDocuments)
        {
            try
            {

                string strSQL = "EXEC usp_Sel_tbl_PM_DocumentSubCategory " + HttpUtility.UrlDecode(Convert.ToString(AttachmentDocuments.Category)) + ", null ," + HttpUtility.UrlDecode(Convert.ToString(AttachmentDocuments.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            ////Insert Document
            //[Authorize]
            //[HttpPost]
            //public object InsertDocumentAttachment()
            //{

            //    string msg = "";
            //    if (GetFileType())
            //    {
            //        var AttachedFileData = HttpContext.Current.Request["AttachedFileData"];
            //        var listAttachedDocuments = JsonConvert.DeserializeObject<List<Document>>(AttachedFileData);
            //        for (int i = 0; i < listAttachedDocuments.Count; i++)
            //        {
            //            var httpPostedFile = HttpContext.Current.Request.Files[i];
            //            var Category = listAttachedDocuments[i].Category;
            //            var ProjectID = listAttachedDocuments[i].WBSParameters.ProjectID;
            //            int SubCategory = listAttachedDocuments[i].SubCategory;
            //            string DirectoryName;
            //            if (SubCategory != 0)
            //            {
            //                DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName + "\\" + listAttachedDocuments[i].SubCategoryName;
            //            }
            //            else
            //            {
            //                DirectoryName = "SETPL_WHIZ_SM_-0208\\" + listAttachedDocuments[i].CategoryName;
            //            }

            //            var description = listAttachedDocuments[i].Description;
            //            var CreatedDate = DateTime.Now;
            //            string strFileName =  CommonFunctions.FileDirectory.GetUniqueFileName();
            //            float FileSize = httpPostedFile.ContentLength;
            //            FileSize = FileSize / 1000;
            //            string FileExtention = Path.GetExtension(httpPostedFile.FileName);
            //            string OriginalFileName = Path.GetFileName(httpPostedFile.FileName);
            //            int UserId = listAttachedDocuments[i].WBSParameters.UserID;
            //            string LoginType = listAttachedDocuments[i].WBSParameters.LoginType;

            //            int TagID = listAttachedDocuments[i].WBSParameters.TagID;
            //            int UniqueID = listAttachedDocuments[i].WBSParameters.UniqueID;
            //            string strCodeTemplate = "SETPL/" + listAttachedDocuments[i].CategoryName + "_/<Job Code>/<Serial Number>";
            //            string categoryName = listAttachedDocuments[i].CategoryName;
            //            string subcategoryName = listAttachedDocuments[i].SubCategoryName;
            //            var DirectoryPath = HttpContext.Current.Server.MapPath("~/" + "");
            //            DirectoryPath = DirectoryPath.Replace("WhizibleAPIService", "Documents\\SETPL_WHIZ_SM_-0208");
            //            string dir = DirectoryPath + categoryName + "\\" + subcategoryName;
            //            if (!Directory.Exists(dir))
            //            {

            //                DirectoryInfo di = Directory.CreateDirectory(dir);

            //            }

            //            string ChangeRequestID = "NULL";
            //            var fileName = strFileName + System.IO.Path.GetExtension(httpPostedFile.FileName);
            //            var filePath = HttpContext.Current.Server.MapPath("~/" + fileName);
            //            filePath = filePath.Replace("WhizibleAPIService", "Documents\\" + DirectoryName);
            //            httpPostedFile.SaveAs(filePath);
            //            string strSQL = "Exec usp_Whizible2_Ins_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Category.ToString()) + "," + HttpUtility.UrlDecode(ProjectID.ToString()) + ",'" + HttpUtility.UrlDecode(DirectoryName) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(CreatedDate.ToString()) + "','" + HttpUtility.UrlDecode(description.Replace("'","''")) + "'," + HttpUtility.UrlDecode(FileSize.ToString()) + ",'" + HttpUtility.UrlDecode(FileExtention) + "','" + HttpUtility.UrlDecode(fileName.Substring(0, fileName.IndexOf('.'))) + "'," + HttpUtility.UrlDecode(UserId.ToString()) + ",'" + HttpUtility.UrlDecode(LoginType) + "'," + HttpUtility.UrlDecode(ChangeRequestID) + "," + HttpUtility.UrlDecode(SubCategory.ToString()) + "," + HttpUtility.UrlDecode(TagID.ToString()) + "," + HttpUtility.UrlDecode(UniqueID.ToString()) + ",'" + HttpUtility.UrlDecode(strCodeTemplate) + "'";
            //            object result =  CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

            //            msg = "File Upload Successfully";
            //        }
            //    }
            //    else
            //    {

            //        msg = "Only Files With Extensions PDF, XLS, XLSX, ZIP, RAR, XML, LOG, PNG, JPEG, JPG, DOC, DOCX, TXT, EXE Are Allowed";

            //    }
            //    return msg;

            //}

            public bool GetFileType()
        {
            bool fileUploadFlag = false;
            string MimeType = "";
            string strFileName = CommonFunctions.FileDirectory.GetUniqueFileName();
            if (HttpContext.Current.Request.Files.AllKeys.Any())
            {
                for (int filecount = 0; filecount < HttpContext.Current.Request.Files.Count; filecount++)
                {
                   //Added by Riddhesh on 30-01-2023
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
                        }
                    }
                    int IsFileValid = 1;
                    string[] extensionList;
                    extensionList = fileName.Split('.');
                    if (extensionList.Length > 2)
                    {
                        IsFileValid = 0;
                    }
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
                       // }
                        // End of comment by Riddhesh on 30-01-2023
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
                    else
                    {
                        fileUploadFlag = false;
                        break;
                    }
                }

            }

            return fileUploadFlag;
        }

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

        //deleted Document 
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteDocument([FromBody] int DocumentId)
        {
            try
            {

                string strSQL = "EXEC usp_Whizible2_Del_tbl_PM_ProjectDocuments " + HttpUtility.UrlDecode(Convert.ToString(DocumentId));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetExcucationTemplate([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Get_TemplateName_Published " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",null";
                // + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID)) + ", '" + HttpUtility.UrlDecode(WBSParameters.FilterName) + "', '"
                //+ HttpUtility.UrlDecode(WBSParameters.LoginType) + "' ," + "'" + HttpUtility.UrlDecode(WBSParameters.QueryText) + "'"
                // + "," + HttpUtility.UrlDecode(WBSParameters.UserName) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.Flag)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.FilterID));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //*****************************************************************************************************
        //End Common controller for all tab
        //----------------------------------------------------------------------------------------- WorkFlow Links
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public object PlotWorkflowLinks([FromBody] WBSWorkFlow WBSParametersWorkFlows)
        {
            try
            {
                // ------- For plotting Approve, Reject Submit Links for cofigurable workflows defined
                string strLinks = "";
                string strSQL = "usp_get_WorkflowLinkAccess ";
                System.Text.StringBuilder sbScript = new System.Text.StringBuilder();
                //IDataReader drAttributeDetails;
                string strPrimaryKeyName = "";
                string strtablename = "";
                var strPageName = "";
                string strLinkName = "";
                string strIsApproverConfigured = "";
                string strRequestStage = "";
                string WFID = "";
                int iIsDocumentUploaded = 0;
                string WorkflowInstanceID = "";
                //IDataReader dr;

                if (WBSParametersWorkFlows.strPrimaryKey.ToString() != "")
                {
                    strSQL += WBSParametersWorkFlows.strPrimaryKey;
                    strSQL += "," + WBSParametersWorkFlows.TagID;
                    strSQL += "," + WBSParametersWorkFlows.UserID;
                    // strSQL += "," +  CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), 0).ToString
                    strSQL += "," + WBSParametersWorkFlows.ProjectID;
                    strSQL += "," + WBSParametersWorkFlows.RoleID;

                    // strLinks =  CommonFunctions.General.CheckIsNothing( CommonFunctions.Data.CheckIsDBNull( CommonFunctions.Data.GetDataScalar(strSQL, True), ""), "")

                    //drAttributeDetails =  CommonFunctions.Data.GetDataReader(strSQL, true);

                    //if (drAttributeDetails.Read)
                    //{
                    //    strPrimaryKeyName = drAttributeDetails["PrimaryKeyName"];
                    //    strtablename = drAttributeDetails["tablename"];
                    //    strPageName = drAttributeDetails["PageName"];
                    //    strLinkName = drAttributeDetails["LinkName"];
                    //defaultQuery.FilterID = Convert.ToInt32(drDefaultQuery["FilterID"]);
                    //defaultQuery.FilterName = Convert.ToString(drDefaultQuery["FilterName"]);
                    //defaultQuery.QueryText = Convert.ToString(drDefaultQuery["QueryText"]);
                    //}

                    IDataReader drAttributeDetails;
                    drAttributeDetails = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                    if (drAttributeDetails.Read())
                    {
                        strPrimaryKeyName = Convert.ToString(drAttributeDetails["PrimaryKeyName"]);
                        strtablename = Convert.ToString(drAttributeDetails["tablename"]);
                        strPageName = Convert.ToString(drAttributeDetails["PageName"]);
                        strLinkName = Convert.ToString(drAttributeDetails["LinkName"]);
                    }

                    switch (strLinkName)
                    {
                        case "APPROVE":
                            {
                                strSQL = "usp_whizible2_sel_IsApproverConfigured_forStage ";
                                strSQL += WBSParametersWorkFlows.strPrimaryKey;
                                strSQL += "," + WBSParametersWorkFlows.TagID;
                                strSQL += ",'A'";
                                strSQL += "," + WBSParametersWorkFlows.UserID;
                                IDataReader dr;
                                //dr =  CommonFunctions.Data.GetDataReader(strSQL, true);
                                dr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                                while (dr.Read())
                                {
                                    strIsApproverConfigured = Convert.ToString(dr["IsAppSelected"]);
                                    strRequestStage = Convert.ToString(dr["Stage"]);
                                    iIsDocumentUploaded = Convert.ToInt32(dr["IsDocumentUploaded"]);
                                    WFID = Convert.ToString(dr["WFID"]);
                                    WorkflowInstanceID = Convert.ToString(dr["WorkflowInstanceID"]);
                                }

                                //  dr = null/* TODO Change to default(_) if this is not a reference type */;

                                // strIsApproverConfigured =  CommonFunctions.General.CheckIsNothing( CommonFunctions.Data.CheckIsDBNull( CommonFunctions.Data.GetDataScalar(strSQL, True), "1"), "1")
                                // strRequestStage()

                                // sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Approve_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "'," + strIsApproverConfigured.ToString + ",'" + strRequestStage.ToString + "')"" Title=""Approve"" >Approve Revision</A> ")
                                sbScript.Append("<a class='nobtnstyle - xs' id ='btnApproved_" + WBSParametersWorkFlows.TagID + "' onclick=\"Javascript:Approve_Onclick(" + WFID + "," + WorkflowInstanceID + "," + +WBSParametersWorkFlows.TagID + ", " + WBSParametersWorkFlows.strPrimaryKey + ",'Approve','" + strPrimaryKeyName.ToString() + "'," + strIsApproverConfigured.ToString() + ",'" + strRequestStage.ToString() + "')\"  data-bs-toggle='modal' data-bs-target='#divAppReject' >Approve Revision</a>");
                                // sbScript.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHidIDU", "txtHidIDU", null/* Conversion error: Set to default value for this argument */, null/* Conversion error: Set to default value for this argument */, null/* Conversion error: Set to default value for this argument */, iIsDocumentUploaded.ToString(), null/* Conversion error: Set to default value for this argument */, null/* Conversion error: Set to default value for this argument */, null/* Conversion error: Set to default value for this argument */, null/* Conversion error: Set to default value for this argument */, null/* Conversion error: Set to default value for this argument */, true, null/* Conversion error: Set to default value for this argument */, true));

                                strSQL = "usp_whizible2_sel_IsApproverConfigured_forStage ";
                                strSQL += WBSParametersWorkFlows.strPrimaryKey;
                                strSQL += "," + WBSParametersWorkFlows.TagID;
                                strSQL += ",'R'";
                                strSQL += "," + WBSParametersWorkFlows.UserID;

                                strIsApproverConfigured = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                                // dr = CommonFunctions.Data.GetDataReader(strSQL, true);
                                dr = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                                while (dr.Read())
                                {
                                    strIsApproverConfigured = Convert.ToString(dr["IsAppSelected"]);
                                    strRequestStage = Convert.ToString(dr["Stage"]);
                                    WFID = Convert.ToString(dr["WFID"]);
                                    WorkflowInstanceID = Convert.ToString(dr["WorkflowInstanceID"]);
                                }
                                sbScript.Append("<a class='nobtnstyle - xs' id ='btnRejectApproved_" + WBSParametersWorkFlows.TagID + "' style='margin-left: 4px;' onclick=\"Javascript:Reject_Onclick(" + WFID + "," + WorkflowInstanceID + "," + WBSParametersWorkFlows.TagID + "," + WBSParametersWorkFlows.strPrimaryKey + ",'Reject','" + strPrimaryKeyName.ToString() + "'," + strIsApproverConfigured.ToString() + ",'" + strRequestStage.ToString() + "')\"  data-bs-toggle='modal' data-bs-target='#divAppReject' >Reject Revision</a>");
                                break;
                            }

                        case "SUBMIT":
                            {
                                if (WBSParametersWorkFlows.strPrimaryKey.ToString() == "")
                                    // sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "','ADD_NEW')"" Title=""Submit"" >Send for Approval</A> ")
                                    sbScript.Append("<a class='nobtnstyle - xs' id ='btnSendforApproval_" + WBSParametersWorkFlows.TagID + "' onclick=\"Javascript:Submit_Onclick(" + WBSParametersWorkFlows.TagID + ",'Send for Approval','" + WBSParametersWorkFlows.strPrimaryKey + "','ADD_NEW')\"  data-bs-toggle='modal' data-bs-target='' >Send for Approval</a>");
                                else
                                    // sbScript.Append("| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + lngTagID.ToString + "," + strPrimaryKey.ToString + ",'" + strPageName.ToString + "','" + strPrimaryKeyName.ToString + "','Edit')"" Title=""Submit"" >Send for Approval</A> ")
                                    sbScript.Append("<a class='nobtnstyle - xs' id ='btnSendforApproval_" + WBSParametersWorkFlows.TagID + "' onclick=\"Javascript:Submit_Onclick(" + WBSParametersWorkFlows.TagID.ToString() + ",'Send for Approval','" + WBSParametersWorkFlows.strPrimaryKey + "','Edit')\"  data-bs-toggle='modal' data-bs-target='' >Send for Approval</a>");
                                break;
                            }
                    }
                }


                //CommonFunctions.Data.DisposeDataReader(drAttributeDetails);
                //CommonFunctions.Data.DisposeDataReader(dr);

                //  PlotWorkflowLinks = sbScript.ToString();

                return sbScript.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public object RevisionLink([FromBody] WBSWorkFlow WBSParametersWorkFlows)
        {
            try
            {
                //  string strResult = "";
                System.Text.StringBuilder sbScript = new System.Text.StringBuilder();
                string strSql = "";
                string strResult = "";
                int strPrimaryKey = 0;
                strSql = "usp_Show_RevisionLink " + WBSParametersWorkFlows.strPrimaryKey + "," + WBSParametersWorkFlows.TagID + "," + WBSParametersWorkFlows.UserID + "," + WBSParametersWorkFlows.ProjectID;
                //strResult = CommonFunctions.Data.GetDataScalar(strSql, True);
                strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString));
                if (strResult == "1")
                {
                    sbScript.Append("<a class='nobtnstyle - xs' id ='btnRevision_" + WBSParametersWorkFlows.TagID + "' onclick=\"Javascript:RevisionOnclick(" + WBSParametersWorkFlows.strPrimaryKey + "," + WBSParametersWorkFlows.TagID + ")\" data-bs-toggle='modal' data-bs-target='#divRevision'>Revision</a>");//data-toggle='modal' data-target='#divRevision'
                }
                return sbScript.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object PerformRevision([FromBody] WBSWorkFlow WBSParametersWorkFlows)
        {
            try
            {



                string strSQL = "";
                strSQL = "Usp_Upd_BaseLineStatus " + WBSParametersWorkFlows.strPrimaryKey + "," + WBSParametersWorkFlows.TagID + ",'" + WBSParametersWorkFlows.UserName + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                strSQL = "";
                strSQL = "usp_Whizible2_ins_tbl_whizible2_RevisionDetails " + WBSParametersWorkFlows.TagID + "," + WBSParametersWorkFlows.UserID + "," + WBSParametersWorkFlows.ProjectID + "," + WBSParametersWorkFlows.WBSID + ",'" + WBSParametersWorkFlows.Remarks + "','" + WBSParametersWorkFlows.UserName + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                if (Convert.ToString(WBSParametersWorkFlows.TagID) == "34")
                {
                    strSQL = "";
                    strSQL = "usp_Ins_tbl_PM_MilestonesRevision_Revision " + WBSParametersWorkFlows.strPrimaryKey + ",'" + WBSParametersWorkFlows.UserName + "'";
                }


                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);


                // string strSQL = "usp_Del_tbl_App_AuditTrail_Entity " + WBSParametersWorkFlows.strPrimaryKey + "," + WBSParametersWorkFlows.TagID + "";
                // CommonFunctions.Data.GetDataScalar(strSQL, True)
                //strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return "1";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public object SaveLinksCondition([FromBody] WBSWorkFlow WBSParametersWorkFlows)
        {
            try
            {

                string strLinks = "";
                string strSQL = "usp_get_Workflow_SaveLinkAccess ";
                string intDisplaySaveLink = "";
                string strUniqueID = "";

                //IDataReader dr;
                //if (Convert.ToString(WBSParametersWorkFlows.strPrimaryKey) == "")
                //{
                //    strUniqueID = "0";
                //}
                //else {
                strUniqueID = Convert.ToString(WBSParametersWorkFlows.strPrimaryKey);
                //}


                strSQL += strUniqueID;
                strSQL += "," + WBSParametersWorkFlows.TagID;
                strSQL += "," + WBSParametersWorkFlows.UserID;
                strSQL += "," + WBSParametersWorkFlows.ProjectID;
                strSQL += "," + WBSParametersWorkFlows.RoleID;

                //strSQL += WBSParametersWorkFlows.strPrimaryKey;
                //strSQL += "," + WBSParametersWorkFlows.TagID;
                intDisplaySaveLink = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return intDisplaySaveLink.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        // public string PlotWorkflowLinks([FromBody] WBSParametersWorkFlow )
        public object GetWorkFlowStatus([FromBody] WBSWorkFlow WBSParametersWorkFlows)
        {
            try
            {
                string strLinks = "";
                string strSQL = "usp_get_WorkflowActionStatus ";
                string intDisplaySaveLink = "";
                string strUniqueID = "";


                strUniqueID = Convert.ToString(WBSParametersWorkFlows.strPrimaryKey);



                strSQL += strUniqueID;
                strSQL += "," + WBSParametersWorkFlows.TagID;
                //strSQL += "," + WBSParametersWorkFlows.UserID;
                strSQL += "," + WBSParametersWorkFlows.ProjectID;
                strSQL += ",NULL";
                strSQL += ",'" + WBSParametersWorkFlows.LoginType + "'";

                //strSQL += WBSParametersWorkFlows.strPrimaryKey;
                //strSQL += "," + WBSParametersWorkFlows.TagID;
                intDisplaySaveLink = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return intDisplaySaveLink.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetWorkFlow([FromBody] WbsParameter WBSParameters)
        {
            try
            {

                string strSQL = "EXEC usp_whizible2_sel_ProjectWorkflows " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID));
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        [HttpPost]
        public object GetWorkFlowMailCondition([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string Flag = "";
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                bool blnSendEmail, blnShowPopup;
                string MessageID;
                string m_strPrimaryKeyValue;
                string m_strcomments;
                string UserID;
                string WorkFlowInstance;
                string UserName;

                MessageID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MessageID));
                m_strPrimaryKeyValue = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.m_strPrimaryKeyValue));
                m_strcomments = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.m_strcomments));
                UserID = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserID));
                WorkFlowInstance = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.WorkFlowInstance));
                UserName = HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UserName));
                if (Convert.ToString(MessageID) == "88")
                {
                    MessageID = "8";
                }

                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_IM_EmailMessages " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.MessageID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.TagID)) + "", true, CommonController.connectionString);
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
                            //EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage,ref MessageID, ref m_strPrimaryKeyValue, ref m_strcomments, ref UserName, ref UserID.ToString(), ref WorkFlowInstance);
                            ////EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, intMilestoneID, strProjectID, intEmployeeID);
                            //EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
                        }

                    }
                }

                return Flag.ToString();

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //For CheckList Response 
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        public object GetCheckListEnabled([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string Flag = "";

                string strSQL = "usp_Whizible2_get_LinkAccess_ConfigurableWorkflow_Actions ";


                strSQL += Convert.ToString(WBSParameters.ProjectID);
                strSQL += "," + WBSParameters.UserID;
                strSQL += "," + WBSParameters.TagID;
                strSQL += ",'CR'";

                Flag = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));


                return Flag.ToString();

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetWBSWorkHours([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_WBSHoursValidation " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ProjectID)) + ",'"
                                                                    + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.WBSFlag)) + "'";

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Get Task details for Milestone
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDelBaselineDetails([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_PM_OtherSchedules_RelatedDataSection " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID));

                DataTable Baselinetable;
                Baselinetable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return Baselinetable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Set SubProject Baselined
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDelBaselined([FromBody] WbsParameter WBSParameters)
        {
            try
            {
                string strSQL = "Exec usp_whizible2_upd_tbl_PM_OtherSchedules_SetBaseline " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.ScheduleID)) + "," + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SetBaselineFlag));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Set SubProject Deliverable Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        ////clear SubProject Baselined
        //[Authorize]
        //[HttpPost]
        //public string ClearDelBaselined([FromBody]WbsParameter WBSParameters)
        //{
        //    string strSQL = "Exec usp_Whizible2_upd_tbl_pm_subproject_ClearBaseLineDates " + HttpUtility.UrlDecode(Convert.ToString(WBSParameters.SubProjectID));
        //    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

        //    return "Clear Baselined Deliverable Successfully";
        //}



        //*****************************************************************************************************

        //Added By Usha Pandit On 25.10.2019 for discussion panel   
        //Get Discussion Details

        //Added by imran on 12-09-2022

        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        //public List<GetWBSDiscussions> GetDiscussions([FromBody]WBSDiscussionsParameter Parameters)
        public object GetDiscussions([FromBody] WBSDiscussionsParameter Parameters)

        {
            try
            {
                string strSQL = "";
                string currentFlag = "";
                currentFlag = HttpUtility.UrlDecode(Parameters.Flag);

                if (currentFlag == "Milestone")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_Milestone_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID));
                }
                if (currentFlag == "SubProject")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_SubProject_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID));
                }
                if (currentFlag == "Module")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_Module_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID));
                }
                if (currentFlag == "Deliverable")
                {
                    strSQL = "Exec Usp_Whizible2_Sel_tbl_Whizible2_Deliverable_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID));
                }
                DataTable DiscussionsListTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                List<GetWBSDiscussions> DiscussionsLists = new List<GetWBSDiscussions>();

                foreach (DataRow DiscussionsList in DiscussionsListTable.Rows)
                {
                    GetWBSDiscussions DiscussionsListQuery = new GetWBSDiscussions()
                    {
                        DiscussionID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionID"], "0")),
                        UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["UniqueID"], "0")),
                        ParentID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ParentID"], "0")),
                        LoginID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["LoginID"], "0")),
                        ReplyIndex = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ReplyIndex"], "0")),
                        IsShowToCustomer = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["IsShowToCustomer"], "0")),
                        DiscussionThread = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionThread"], "").ToString(),
                        SubmittedBy = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["SubmittedBy"], "").ToString(),
                        SubmittedDate = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["SubmittedDate"], "").ToString(),
                        LoginType = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["LoginType"], "").ToString(),
                        ReplyCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(DiscussionsList["ReplyCount"], "0")),
                        DiscussionLevel = CommonFunctions.Data.CheckIsDBNull(DiscussionsList["DiscussionLevel"], "").ToString(),
                    };
                    DiscussionsLists.Add(DiscussionsListQuery);
                }
                return DiscussionsLists;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Save Discussion Details
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDiscussion([FromBody] WBSDiscussionsParameter Parameters)
        {
            try
            {
                string strSQL = "";
                string currentFlag = "";
                currentFlag = HttpUtility.UrlDecode(Parameters.Flag);

                if (currentFlag == "Milestone")
                {
                    strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_Milestone_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";
                }
                if (currentFlag == "SubProject")
                {
                    strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_SubProject_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";
                }
                if (currentFlag == "Module")
                {
                    strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_Module_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";
                }
                if (currentFlag == "Deliverable")
                {
                    strSQL = "Exec Usp_Whizible2_Ins_tbl_Whizible2_Deliverable_DiscussionThreads " + HttpUtility.UrlDecode(Convert.ToString(Parameters.UniqueID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ParentID)) + "," + HttpUtility.UrlDecode(Convert.ToString(Parameters.LoginID)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionThread).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','" + HttpUtility.UrlDecode(Parameters.SubmittedBy) + "','" + HttpUtility.UrlDecode(Parameters.LoginType) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsShowToCustomer)) + ",'" + HttpUtility.UrlDecode(Parameters.DiscussionLevel) + "'," + HttpUtility.UrlDecode(Convert.ToString(Parameters.ReplyIndex)) + "";
                }

                string Message;

                Message = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));

                return Message;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

            //End Of Added By Usha Pandit On 25.10.2019 for discussion panel
            //*****************************************************************************************************
        }
}