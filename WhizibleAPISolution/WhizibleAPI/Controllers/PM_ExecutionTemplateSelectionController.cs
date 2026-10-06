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
    public class PM_ExecutionTemplateSelectionController : ApiController
    {
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 12-09-2022
        public object GetExeTempSelList([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";
                if (ExeTempSelPrameters.ProjectPhaseTaskTemplateID != 0)
                {
                    strSql = "Exec usp_Whizible2_Sel_v_tbl_PM_Project_PhaseTask_Template " + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectPhaseTaskTemplateID));

                }
                else
                {
                    strSql = "Exec usp_Whizible2_Sel_v_tbl_PM_Project_PhaseTask_Template " + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectID)) + ",NULL";
                }
                DataTable dt = CommonFunctions.Data.GetDataTable(strSql, true, CommonController.connectionString);
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
        public object GetIsCopyTemplate([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";
                strSql = "Exec usp_Whizible2_Sel_tbl_PM_Project_PhaseTask_Template_IsCopyTemplate " + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectPhaseTaskTemplateID));
                object dt = CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString);
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
        public object GetLatestRevision([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";
                strSql = "Exec usp_Whizible2_Upd_Project_PhaseTaskTemplate_GetLatest " + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectPhaseTaskTemplateID));
                object dt = CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString);
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
        public object GetIsRevised([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";
                strSql = "Exec usp_Whizible2_Sel_Execution_Template_Revision " + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectPhaseTaskTemplateID));
                object dt = CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString);
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
        public object GetAssociatedTaskList([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";
                if (ExeTempSelPrameters.ProjectTemplateEffort != 0)
                {
                    strSql = "Exec usp_Whizible2_Sel_v_tbl_PM_Project_PhaseTask_Template_Effort " + "NULL," + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectTemplateEffort));

                }
                else
                {
                    strSql = "Exec usp_Whizible2_Sel_v_tbl_PM_Project_PhaseTask_Template_Effort " + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.TemplateID)) + ",NULL";

                }


                DataTable dt = CommonFunctions.Data.GetDataTable(strSql, true, CommonController.connectionString);
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
        public object UpdateExeTempSel([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string StrSQl = "";
                StrSQl = "Exec usp_Whizible2_Upd_tbl_PM_Project_PhaseTask_Template '"
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.TailoringComments)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "','"
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.DeviationComments)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.IsActive)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectPhaseTaskTemplateID));
                object dt = CommonFunctions.Data.GetDataScalar(StrSQl, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Calculate Sum Of Effort(%)
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetSumOfEffortInPercent([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string StrSQl = "";
                StrSQl = "Exec usp_Whizible2_Sel_v_tbl_PM_Project_PhaseTask_Template_Effort_SumOfEffort "
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.TemplateID)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectTemplateEffort));
                object dt = CommonFunctions.Data.GetDataScalar(StrSQl, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        // Update Associated Task
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateAssociatedTask([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string StrSQl = "";
                StrSQl = "Exec usp_Whizible2_Upd_tbl_PM_Project_PhaseTask_Template_Effort "
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.Duration)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.Effort)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.Mandatory)) + ","
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectTemplateEffort)) + ","
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.TemplateID));

                object dt = CommonFunctions.Data.GetDataScalar(StrSQl, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        // Get Template List

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetTemplateList([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";

                strSql = "Exec usp_Whizible2_Sel_v_tbl_Select_Template_for_project "
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSql, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        // Update Associated Task
        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateSelectedTemplate([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string StrSQl = "";
                StrSQl = "Exec usp_Whizible2_Upd_tbl_PM_Project_AssociatePractice "
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectID)) + ",NULL,'"
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.UserName)) + "',"
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.TemplateID));
                object dt = CommonFunctions.Data.GetDataScalar(StrSQl, true, CommonController.connectionString);
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
        public object GetApprovedByOrRevisedBy([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";
                strSql = "Exec usp_Whizible2_Sel_tbl_PM_ProjectEmployeeRole_PracticeSelection "
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectID)) + ",'"
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ApprovedByOrRevisedBy)) + "'";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSql, true, CommonController.connectionString);
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
        public object PublishTemplate([FromBody] ExeTempSelPrameters ExeTempSelPrameters)
        {
            try
            {
                string strSql = "";
                strSql = "Exec usp_Whizible2_Ins_tbl_PM_Project_Template_Revision '"
                        + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.RevisionDate)) + "','"
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.RevisedBy)) + "',"
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ProjectID)) + ",'"
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.ApprovedBy)) + "',"
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.TemplateID)) + ",'"
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.Reason)).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "',"
                         + HttpUtility.UrlDecode(Convert.ToString(ExeTempSelPrameters.@RevisionNo));
                object RevisionID = CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString);
                //return dt;


                strSql = "Exec usp_Whizible2_Upd_PublishProjectDeliverableTemplate " + RevisionID;
                object dt = CommonFunctions.Data.GetDataScalar(strSql, true, CommonController.connectionString);

                return Ok("Template Publish Successfully.");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        }
}
