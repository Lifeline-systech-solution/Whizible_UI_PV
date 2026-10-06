using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_DerivedMetricReportController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSessionProjDetails([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "Exec Usp_Marlab_Sel_ProjectDetails " + Parameters.ProjectID + "";
                DataTable SessionProjDetailsDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                var data = SessionProjDetailsDataTable;
                return data;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTemplatewiseAccessibleProject([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlab_sel_Accessible_TemplateWise_Project '" + Parameters.UserID + "','" + Parameters.LoginType + "', 1, 0,'[Over] = ''0''','ProjectName ASC'," + Parameters.TemplateID + "";

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
        public object GetDerivedMetricDetails([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec USP_Marlab_Sel_DerivedMetric " + Parameters.ProjectID + "";

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
        public object GetDerivedMetricIsFreezed([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec USP_Marlab_Sel_DerivedMetric_IsFreezed " + Parameters.ProjectID + "," + Parameters.MilestoneID + "";

                //string Result = Convert.(CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString));
                object Result = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        //Added By Dipali V on 20th June 2024
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CheckPMSQA([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Sel_CheckPMSQA " + Parameters.ProjectID + "," + Parameters.UserID + "";

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
        public object GetSprintName([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Sel_GetProjectSprints " + Parameters.ProjectID + "," + Parameters.RequestID + "";

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
        public object GetWFList([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Sel_Tbl_Marlab_Maxtric_WF " + Parameters.RequestID + "," + Parameters.ProjectID + "," + Parameters.TemplateID + "," + Parameters.UserID + "";

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
        public object GetWFStageDetails([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Use_Sel_Tbl_Marlab_Maxtric_WFDetails " + Parameters.RequestID + "," + Parameters.ProjectID + "," + Parameters.TemplateID + "," + Parameters.UserID + ",'" + Parameters.FromWhichAction + "'," + Parameters.StatusID + "";

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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveDetails([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Ins_Upd_Tbl_Marlab_Maxtric_WF " + Parameters.RequestID + "," + Parameters.ProjectID + "," + Parameters.SprintID + "," + Parameters.TemplateID + "," + Parameters.UserID + ",'" + Parameters.Remarks + "'," + Parameters.Flag + ",'" + Parameters.StrUserName + "'," + Parameters.UserID + ",'" + Parameters.SenderRemarks + "'";

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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SubmitDetails([FromBody] PM_DerivedMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Ins_Upd_Tbl_Marlab_Maxtric_WFDetails " + Parameters.RequestID + "," + Parameters.ProjectID + "," + Parameters.TemplateID + "," + Parameters.Flag + "," + Parameters.UserID + ",'" + Parameters.Remarks + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                //return dt;
                bool blnSendEmail, blnShowPopup;
                string MessageID = "";
                string Flag="0";
                if (Parameters.Flag == 1) {  // Submit
                    MessageID = "35009";
                }
                else if (Parameters.Flag == 2)  // Approve
                {
                    MessageID = "35010";
                }
                else if(Parameters.Flag == 3) {  // Reject
                    MessageID = "35011";
                }
                DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages " + MessageID  + "", true, CommonController.connectionString);
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


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost] 
        public object ConvertDecimalToHourViceVersa([FromBody] PM_DerivedMetricReport pM_DerivedMetricReport)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_ConvertDecimalToHourViceVersa '" + pM_DerivedMetricReport.DataPointValue + "'," + pM_DerivedMetricReport.Flag;
                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost] 
        public object GetWFStageActions([FromBody] PM_DerivedMetricReport pM_DerivedMetricReport)
        {
            try
            {
                string strSQL;
                strSQL = "Exec Usp_Marlabs_Sel_Tbl_Maxtric_WFAction " + pM_DerivedMetricReport.ProjectID+","+ pM_DerivedMetricReport.RequestID;
                object dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


    } 
}
