using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Configuration;
using System.Text.RegularExpressions;

namespace WhizibleAPI.Controllers
{

    public class IB_DashboardController : ApiController
    {
        bool result;
        string SpecialCharacters;

        string[] lstSpecialCharacters;
        public IB_DashboardController() {
            SpecialCharacters = ConfigurationManager.AppSettings["SpecialCharactersList"];
            lstSpecialCharacters = Regex.Split(SpecialCharacters, ",");
        }
        ////string str = "SERVER=LSSDESK043\\SQLEXPRESS2014R2;UID=sa;PWD=sa@1234$;DATABASE=Whizible_2_vendor;Network=dbmssocn;Max Pool Size=80000";



        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<MyDashboardParameter> GetCorporateStatusGraph([FromBody]MyDashboardParameter statusparameter)
        public object GetCorporateStatusGraph([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                //Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_CountStatus_Dashboard_IssueStatus_ib_issue " + statusparameter.intUserID + "," + statusparameter.intViewBy + "," + statusparameter.intDuration + "", true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_CountStatus_Dashboard_IssueStatus_ib_issue " + statusparameter.intUserID + "," + statusparameter.intViewBy + "," + statusparameter.intDuration + ",0,0,NULL,0, '" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);
                //End of Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also

                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    if (statusparameter.intViewBy != 0)
                    {

                        usrlist.Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Name"], ""));
                        usrlist.op = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["op"], "0"));
                        usrlist.res = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["res"], "0"));
                        usrlist.onhold = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["onhold"], "0"));
                        usrlist.resol = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["resol"], "0"));
                        usrlist.ack = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["ack"], "0"));
                        // usrlist.Cl = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Close"], "0"));


                    }


                    else
                    {
                        ////Added By Usha Pandit On 02.04.2020 For getting Name of the field to show on dashboard
                        //usrlist.Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Name"], ""));
                        ////End Of Added By Usha Pandit On 02.04.2020 For getting Name of the field to show on dashboard
                        usrlist.X_AXIS = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["X_AXIS"], ""));
                        usrlist.Y_AXIS = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Y_AXIS"], "0"));

                    }

                    userlist.Add(usrlist);
                }
                return userlist;
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

        //public List<MyDashboardParameter> GetAssignedCorporateStatusGraph([FromBody]MyDashboardParameter statusparameter)
        public object GetAssignedCorporateStatusGraph([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                //Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also

                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("Usp_Whizible2_Sel_Dashboard_Assigntome_IssueStatus_ib_Issue " + statusparameter.intUserID + "," + statusparameter.intViewBy + "," + statusparameter.intDuration + "", true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("Usp_Whizible2_Sel_Dashboard_Assigntome_IssueStatus_ib_Issue " + statusparameter.intUserID + "," + statusparameter.intViewBy + "," + statusparameter.intDuration + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);

                //End of Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also

                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();
                    if (statusparameter.intViewBy != 0)
                    {

                        usrlist.Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Name"], ""));
                        usrlist.ack = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Acknowledgement"], "0"));
                        usrlist.Cl = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Close"], "0"));
                        usrlist.onhold = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["On Hold"], "0"));
                        usrlist.op = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Open"], "0"));
                        usrlist.resol = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Resolved"], "0"));
                        usrlist.res = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Response"], "0"));

                    }

                    else
                    {
                        //Added By Usha Pandit On 02.04.2020 For getting Name of the field to show on dashboard
                        //usrlist.Name = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Name"], ""));
                        //End Of Added By Usha Pandit On 02.04.2020 For getting Name of the field to show on dashboard
                        usrlist.X_AXIS = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["X_AXIS"], ""));
                        usrlist.Y_AXIS = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Y_AXIS"], "0"));

                    }

                    userlist.Add(usrlist);
                }
                return userlist;
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
        //public List<MyDashboardParameter> GetInRateandOutRateGraph([FromBody]MyDashboardParameter statusparameter)
        public object GetInRateandOutRateGraph([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentYear_InRate_Out " + statusparameter.intUserID , true, CommonController.connectionString);
                //Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also

                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out " + statusparameter.intUserID + "," + statusparameter.intDuration, true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out " + statusparameter.intUserID + "," + statusparameter.intDuration + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);

                //End of Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also

                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Duration"], ""));
                    usrlist.InRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["InRate"], "0"));
                    usrlist.OutRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Outrate"], "0"));
                    usrlist.OutStanding = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["OutStanding"], "0"));

                    userlist.Add(usrlist);
                }
                return userlist;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //New Controller for year Dropdown
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<MyDashboardParameter> GetInRateandOutRateGraph1([FromBody]MyDashboardParameter statusparameter)
        public object GetInRateandOutRateGraph1([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentYear_InRate_Out " + statusparameter.intUserID , true, CommonController.connectionString);
                //Added & Commented By Dipali V On 1st April 2021 For Custoomer & Client login data should get
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out_for_Years " + statusparameter.intUserID + "," + statusparameter.intDuration, true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out_for_Years " + statusparameter.intUserID + "," + statusparameter.intDuration + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);
                //End of Added & Commented By Dipali V On 1st April 2021 For Custoomer & Client login data should get
                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Duration"], ""));
                    usrlist.InRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["InRate"], "0"));
                    usrlist.OutRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Outrate"], "0"));
                    usrlist.OutStanding = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["OutStanding"], "0"));
                    userlist.Add(usrlist);
                }
                return userlist;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Controller for Month Dropdown
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<MyDashboardParameter> GetInRateandOutRateGraph2([FromBody]MyDashboardParameter statusparameter)
        public object GetInRateandOutRateGraph2([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentYear_InRate_Out " + statusparameter.intUserID , true, CommonController.connectionString);
                //Added & Commented By Dipali V On 1st April 2021 For Custoomer & Client login data should get
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out_Month " + statusparameter.intUserID + "," + statusparameter.intDuration, true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out_Month " + statusparameter.intUserID + "," + statusparameter.intDuration + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);

                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Duration"], ""));
                    usrlist.InRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["InRate"], "0"));
                    usrlist.OutRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Outrate"], "0"));
                    usrlist.OutStanding = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["OutStanding"], "0"));

                    userlist.Add(usrlist);
                }
                return userlist;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Controller for Month Dropdown
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<MyDashboardParameter> GetInRateandOutRateGraph3([FromBody] MyDashboardParameter statusparameter)

        public object GetInRateandOutRateGraph3([FromBody] MyDashboardParameter statusparameter)
        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentYear_InRate_Out " + statusparameter.intUserID , true, CommonController.connectionString);
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_Quarter " + statusparameter.intUserID + ",'" + statusparameter.Intyear + "', " + statusparameter.intqtrduration, true, CommonController.connectionString);
                //Commented and added by Chetan M on 14 April 2021 for crash on change of quarter dropdown
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_Quarter " + statusparameter.intUserID + "," + statusparameter.Intyear + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_Quarter " + statusparameter.intUserID + "," + statusparameter.Intyear + "," + statusparameter.intqtrduration +",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_Quarter " + statusparameter.intUserID + ",'" + statusparameter.Intyear + "'," + statusparameter.intqtrduration + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);
                //End of Commented and added by Chetan M on 14 April 2021 for crash on change of quarter dropdown
                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Duration"], ""));
                    usrlist.InRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["InRate"], "0"));
                    usrlist.OutRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Outrate"], "0"));
                    usrlist.OutStanding = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["OutStanding"], "0"));

                    userlist.Add(usrlist);
                }
                return userlist;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Controller for dependent month dropdown

        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<MyDashboardParameter> GetInRateandOutRateGraph4([FromBody]MyDashboardParameter statusparameter)
        public object GetInRateandOutRateGraph4([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentYear_InRate_Out " + statusparameter.intUserID , true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_Quarter_month '" + statusparameter.Intyear + "'," + statusparameter.intqtrduration, true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_Quarter_month " + statusparameter.Intyear + "," + statusparameter.intqtrduration + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);

                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["MonthName"], ""));
                    //usrlist.InRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["InRate"], "0"));
                    //usrlist.OutRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Outrate"], "0"));
                    //usrlist.OutStanding = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["OutStanding"], "0"));

                    userlist.Add(usrlist);
                }
                return userlist;
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
        //public List<MyDashboardParameter> GetInRateandOutRateGraph5([FromBody]MyDashboardParameter statusparameter)
        public object GetInRateandOutRateGraph5([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();

                // Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out_Month_Onchange " + statusparameter.intUserID + "," + statusparameter.years + ", " + statusparameter.intqtrduration + "," + statusparameter.intmonth + "", true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentMonth_InRate_Out_Month_Onchange " + statusparameter.intUserID + "," + statusparameter.years + "," + statusparameter.intqtrduration + "," + statusparameter.intmonth + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);

                //End of Added & Commented bY Dipali V On 1st April 2021 For Get Detailswith Respective Customer or client login type also

                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Duration"], ""));
                    usrlist.InRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["InRate"], "0"));
                    usrlist.OutRate = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["Outrate"], "0"));
                    usrlist.OutStanding = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["OutStanding"], "0"));

                    userlist.Add(usrlist);
                }
                return userlist;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //for Quarter Dropdown
        [HttpPost]
        [Authorize]
        //public List<MyDashboardParameter> GetInRateandOutRateGraph6([FromBody]MyDashboardParameter statusparameter)
        public object GetInRateandOutRateGraph6([FromBody] MyDashboardParameter statusparameter)

        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentYear_InRate_Out " + statusparameter.intUserID , true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_Dashboard_IB_issue_Quarter", true, CommonController.connectionString);
                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Duration = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Value"], ""));
                    userlist.Add(usrlist);
                }
                return userlist;
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
        //public List<MyDashboardParameter> GetParetoAnalysisGraph([FromBody]MyDashboardParameter statusparameter)
        public object GetParetoAnalysisGraph([FromBody] MyDashboardParameter statusparameter)


        {
            try
            {
                List<MyDashboardParameter> userlist = new List<MyDashboardParameter>();
                // DataTable ulist = CommonFunctions.Data.GetDataTable("usp_sel_countstatus_tbl_ib_issue_Manjiri " + mdb.ProjectId + "", true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_CurrentYear_InRate_Out " + statusparameter.intUserID , true, CommonController.connectionString);
                //DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_ParetoAnalysis " + statusparameter.intUserID + "," + statusparameter.intViewBy, true, CommonController.connectionString);
                DataTable ulist = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_Dashboard_ib_issue_ParetoAnalysis " + statusparameter.intUserID + "," + statusparameter.intViewBy + ",0,0,NULL,0,'" + statusparameter.StrLoginType + "'", true, CommonController.connectionString);

                foreach (DataRow userlistRow in ulist.Rows)
                {
                    MyDashboardParameter usrlist = new MyDashboardParameter();

                    usrlist.Entity = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Entity"], ""));
                    usrlist.EntityCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["EntityCount"], "0"));
                    usrlist.PercentCount = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["PercentCount"], "0"));
                    //   usrlist.OutStanding = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["OutStanding"], "0"));

                    userlist.Add(usrlist);
                }
                return userlist;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }










        string ProjectName;
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        public object GetSessionProjectName([FromBody] int ProjectID)
        {
            try
            {
                object[] inputstring = { ProjectID };

                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    return result;
                }
                else
                {
                    // string str = "SERVER=LSSDESK043\\SQLEXPRESS2014R2;UID=sa;PWD=sa@1234$;DATABASE=NextGen_Enhancement_Trng;Network=dbmssocn;Max Pool Size=80000";

                    string query = "EXEC usp_Whizible2_Get_SessionProjectName  " + ProjectID;

                    Object sdr = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);

                    ProjectName = sdr.ToString();
                    return ProjectName;
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        List<ViewClass> ViewData = new List<ViewClass>();
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
        //public List<ViewClass> GetViews([FromBody]object[] ProjectData)
        public object GetViews([FromBody] DBData ProjectData)
        //End of Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
        {
            try
            {
                // List<ViewClass> lstStatus = new List<ViewClass>();
                //Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                //object[] inputstring = { ProjectData[0].ToString(), ProjectData[1].ToString(), ProjectData[2].ToString() };
                object[] inputstring = { ProjectData.ProjectID.ToString(), ProjectData.LoginType, ProjectData.UserId.ToString() };
                //End of Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                ViewClass Status1 = new ViewClass();
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    Status1.ResultFlag = result1;
                    ViewData.Add(Status1);
                }
                else
                {

                    string query1 = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Views  " + ProjectData.ProjectID.ToString() + ",'" + ProjectData.LoginType.ToString() + "'" + ",'" + ProjectData.UserId.ToString() + "',NULL," + 4 + ",'" + -1 + "'";

                    DataTable DataStatus = CommonFunctions.Data.GetDataTable(query1, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in DataStatus.Rows)
                    {
                        ViewClass ViewList = new ViewClass();

                        ViewList.ViewName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["ViewName"], ""));
                        ViewList.ProjectViewID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["ProjectViewID"], ""));

                        ViewData.Add(ViewList);
                    }

                }
                return ViewData;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        List<Issue1> issueList1 = new List<Issue1>();
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
       // public object GetIssues([FromBody] object[] data1)
        public object GetIssues([FromBody] Update Update)
        {
            try
            {
                DataTable dt;
                //Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                //object[] inputstring = { StatusData[0].ToString(), StatusData[1].ToString(), StatusData[2].ToString() };
                object[] inputstring = { Update.FromStatus.ToString(), Update.ToStatus,ToString(), Update.FromDate.ToString(), Update.ToDate.ToString(), Update.view.ToString(), Update.ProjectID.ToString(), Update.LoginType.ToString(), Update.coloumNames.ToString() };
                //End of Commented & Added By Dipali V On 3rd April 2023 For Crash Issue

                Issue1 Status1 = new Issue1();
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    Status1.ResultFlag = result1;
                    issueList1.Add(Status1);


                    dt = new DataTable();
                    dt.Columns.Add("result", typeof(bool));

                    // Here we add five DataRows.
                    dt.Rows.Add(result);


                }
                else
                {
                    string fields = Update.coloumNames.ToString();
                    fields = fields.Replace('{', ' ');
                    fields = fields.Replace('}', ' ');
                    fields = fields.Replace('[', ' ');
                    fields = fields.Replace(']', ' ');
                    fields = fields.Replace('\r', ' ');
                    fields = fields.Replace('\n', ' ');
                    fields = fields.Replace('\"', ' ');
                    fields = fields.Replace('\\', ' ');
                    fields = fields.Replace(" ", String.Empty);
                    string[] data2 = fields.Split(',');

                    int c = 0;
                    data2.ToList().ForEach(sa1 =>
                    {
                        if (sa1.IndexOf('1') != -1)
                        {
                            sa1 = sa1.Substring(0, sa1.IndexOf('1') + 1);
                            data2[c] = sa1;
                        }
                        c += 1;
                    });
                    //Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                    //string query = "EXEC usp_Whizible2_IB_IssueList_StatusChanged " + "'" + data1[0].ToString() + "'" + ",'" + data1[1].ToString() + "'" + ",'" + Convert.ToDateTime(data1[2].ToString()) + "'" + ",'" + Convert.ToDateTime(data1[3].ToString()) + "'" + ",'" + Convert.ToInt32(data1[4].ToString()) + "'" + ",'" + Convert.ToInt32(data1[5].ToString()) + "'" + ",'" + data1[6].ToString() + "'";
                    //string query = "EXEC usp_Whizible2_IB_IssueList_StatusChanged " + "'" + Update.FromStatus.ToString() + "'" + ",'" + Update.Tost.ToString() + "'" + ",'" + data1[2].ToString() + "'" + ",'" + data1[3].ToString() + "'" + ",'" + Convert.ToInt32(data1[4].ToString()) + "'" + ",'" + Convert.ToInt32(data1[5].ToString()) + "'" + ",'" + data1[6].ToString() + "'";
                    string query = "EXEC usp_Whizible2_IB_IssueList_StatusChanged " + "'" + Update.FromStatus.ToString() + "'" + ",'" + Update.ToStatus.ToString() + "'" + ",'" + Update.FromDate.ToString() + "'" + ",'" + Update.ToDate.ToString() + "'" + ",'" + Convert.ToInt32(Update.view.ToString()) + "'" + ",'" + Convert.ToInt32(Update.ProjectID.ToString()) + "'" + ",'" + Update.LoginType.ToString() + "'";
                    DataTable ulist = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                    //End of Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                    System.Data.DataView view = new System.Data.DataView(ulist);
                    dt = new DataView(ulist).ToTable(false, data2);
                }
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        List<string> strFieldNames = new List<string>();
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022

        public object GetDataByView([FromBody] int viewID)
        {
            try {

                object[] inputstring = { viewID };

                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    return result;
                }
                else
                {

                    // string str = "SERVER=LSSDESK043\\SQLEXPRESS2014R2;UID=sa;PWD=sa@1234$;DATABASE=NextGen_Enhancement_Trng;Network=dbmssocn;Max Pool Size=80000";
                    if (viewID != 0)
                    {
                        string query = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Views NULL,NULL,NULL, " + viewID;

                        IDataReader sdr = CommonFunctions.Data.GetDataReader(query, true, CommonController.connectionString);
                        while (sdr.Read())
                        {
                            strFieldNames.Add(sdr["Fields"].ToString());
                        }
                        return strFieldNames;
                    }
                    else
                    {
                        string query = "EXEC usp_Whizible2_Sel_tbl_IB_Project_CorporateView";
                        IDataReader sdr = CommonFunctions.Data.GetDataReader(query, true, CommonController.connectionString);
                        while (sdr.Read())
                        {
                            strFieldNames.Add(sdr["Fields"].ToString());
                        }
                        return strFieldNames;
                    }
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        List<StatusBasedReport> Data = new List<StatusBasedReport>();
        [HttpPost]
        //Added by riddhesh on 17-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 17-10-2022
        //public List<StatusBasedReport> GetStatusBasedReport([FromBody]object[] StatusData)
        //public object GetStatusBasedReport([FromBody] object[] StatusData)
        public object GetStatusBasedReport([FromBody] DBData StatusData)

        {
            try
            {

                //Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                //object[] inputstring = { StatusData[0].ToString(), StatusData[1].ToString(), StatusData[2].ToString() };
                object[] inputstring = { StatusData.ProjectID.ToString(), StatusData.LoginType, StatusData.SelectedChangedFromStatus.ToString() };
                //End of Commented & Added By Dipali V On 3rd April 2023 For Crash Issue
                ViewClass Status1 = new ViewClass();
                bool result1 = ChkSpecialChar(inputstring);
                if (result == true)
                {
                    Status1.ResultFlag = result1;
                    ViewData.Add(Status1);
                }
                else
                {

                    string query = "EXEC usp_Whizible2_GetIssueReport  " + StatusData.ProjectID.ToString() + ",'" + StatusData.SelectedChangedFromStatus.ToString() + "'" + ",'" + StatusData.LoginType.ToString() + "'";

                    DataTable DataStatus = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                    foreach (DataRow userlistRow in DataStatus.Rows)
                    {
                        StatusBasedReport usrlist = new StatusBasedReport();

                        usrlist.Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(userlistRow["Status"], ""));
                        usrlist.NoOfIssues = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(userlistRow["NoOfIssues"], "0"));

                        Data.Add(usrlist);
                    }
                }
                return Data;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
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
    }



    public class ViewClass
    {
        public string ViewName { get; set; }
        public int ProjectViewID { get; set; }
        public object ResultFlag { get; internal set; }
    }

    public class MyDashboardParameter
    {
        //ProjectId p
        //public int MyProperty { get; set; }
        //public int EmployeeId
        public int intUserID { get; set; }
        public int ProjectId { get; set; }
        public string X_AXIS { get; set; }
        public int Y_AXIS { get; set; }
        public int intViewBy { get; set; }
        public int intDuration { get; set; }
        public string customer { get; set; }
        public string corporatetype { get; set; }
        public string CorporateSubType { get; set; }
        public string priority { get; set; }
        public string username { get; set; }
        public int op { get; set; }
        public int Cl { get; set; }
        public int res { get; set; }
        public int onhold { get; set; }
        public int resol { get; set; }
        public int ack { get; set; }
        public string Name { get; set; }
        public string Duration { get; set; }
        public int InRate { get; set; }
        public int OutRate { get; set; }
        public int OutStanding { get; set; }
        public string Intyear { get; set; }
        public int intqtrduration { get; set; }
        public int years { get; set; }
        public int intmonth { get; set; }
        public string Entity { get; set; }
        public int EntityCount { get; set; }
        public int PercentCount { get; set; }
        //Added By Dipali V On 1st April 2021 For Get graph if customer or client login
        public string StrLoginType { get; set; }
        //End of Added By Dipali V On 1st April 2021 For Get graph if customer or client login
    }

    //public class MyDashboardParameter
    //{
    //    //ProjectId p
    //    //public int MyProperty { get; set; }
    //    //public int EmployeeId
    //    public int intUserID { get; set; }
    //    public int ProjectId { get; set; }
    //    public string X_AXIS { get; set; }
    //    public int Y_AXIS { get; set; }
    //    public int intViewBy { get; set; }
    //    public int intDuration { get; set; }

    //}
    public class StatusBasedReport
    {
        public string Status { get; set; }
        public int NoOfIssues { get; set; }
    }
    public class Update
    {
        public string FromStatus { get; set; }
        public string ToStatus { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string view { get; set; }
        public string ProjectID { get; set; }
        public string LoginType { get; set; }
        public string coloumNames { get; set; }

    }
    public class Issue1
    {
        public int IssueId { get; set; }
        public int ImportID { get; set; }
        public int ProjectID{ get; set; }
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
        public string AssignTo { get; set; }
        public string AssignToName { get; set; }
        public string CreatedDate { get; set; }
        public string CustomerIssueID { get; set; }
        public string ReportedInVersion { get; set; }
        public string Summary { get; set; }
        public string Description { get; set; }
        public string ModuleName { get; set; }
        public string OS{ get; set; }
        public string Hardware { get; set; }
        public string Kernel{ get; set; }
        public string Duration{ get; set; }
        public string Phase{ get; set; }
        public string FoundInPhase{ get; set; }
        public string FixedInPhase{ get; set; }
        public string CodedBy{ get; set; }
        public string CodedByName { get; set; }
        public string ShowToCustomer { get; set; }
        public string Keywords{ get; set; }
        public string CreatorOnModifier{ get; set; }
        public string ClosedDate{ get; set; }
        public string LoginType{ get; set; }
        public string ReviewActionID{ get; set; }
        public string ChangeRequestID{ get; set; }
        public string ChangeRequestName{ get; set; }
        public string[] CustomFieldText{ get; set; }
        public string[] CustomFieldCombo{ get; set; }
        public string[] CustomFieldDate{ get; set; }
        public string[] CustomFieldTextArea { get; set; }
        public string IssueCode { get; set; }
        public string ReportedTime{ get; set; }
        public string RootCauseID{ get; set; }
        public string RootCause{ get; set; }
        public string DeliverableId{ get; set; }
        public string Deliverable{ get; set; }
        public string Complexity{ get; set; }
        public string CorporateComplexity { get; set; }
        public string ProductVersionID{ get; set; }
        public string ProductVersion { get; set; }
        public string ComponentID { get; set; }
        public string Component{ get; set; }
        public string CustomerID { get; set; }
        public string Customer { get; set; }
        public string StatusChangeDate{ get; set; }
        public string StatusChangeTime{ get; set; }
        public string LastUpdatedDate { get; set; }
        public string Release{ get; set; }
        public string Iteration{ get; set; }
        public string UserStory{ get; set; }
        public int NoOfIssues { get; internal set; }
        public bool ResultFlag { get; internal set; }
    }

    public class DBData
    {
        public int ProjectID { get; set; }
        public string LoginType { get; set; }
        public string SelectedChangedFromStatus { get; set; }
        public int UserId { get; set; }
   


    }
}
