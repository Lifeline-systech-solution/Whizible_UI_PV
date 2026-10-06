using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    public class PM_WF_BaseMetricReportController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSessionProjDetails([FromBody] PM_WF_BaseMetricReport Parameters)
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
        // [Authorize]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTemplatewiseAccessibleProject([FromBody] PM_WF_BaseMetricReport Parameters)
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
        // [Authorize]
        //[Authorize, App_Start.ValidateHeaders]
        public object GetBaseMetricValues([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                //strSQL = "Exec usp_marlabs_sel_BaseMetric '" + Parameters.UserID + "','" + Parameters.LoginType + "', 1, 0,'[Over] = ''0''','ProjectName ASC'," + Parameters.TemplateID + "";
                strSQL = $"Exec usp_marlabs_sel_BaseMetric {Parameters.ProjectID}, {Parameters.TemplateID}";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveMetricValues([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                //strSQL = "Exec usp_marlabs_sel_BaseMetric '" + Parameters.UserID + "','" + Parameters.LoginType + "', 1, 0,'[Over] = ''0''','ProjectName ASC'," + Parameters.TemplateID + "";
                //strSQL = $"usp_Marlab_ins_Upd_BaseMetric 286,1,254,5,'19',1,NULL,'ADMIN',NULL";
                strSQL = $"usp_Marlab_ins_Upd_BaseMetric {Parameters.ProjectID},{Parameters.TemplateID},{Parameters.MilestoneID},{Parameters.DataPointID},'{Parameters.DataPointvalue}',{Parameters.CategoeryID},NULL,'{Parameters.UserName}',NULL, {Parameters.IsblankSave}";
                //strSQL = $"usp_Marlab_ins_Upd_BaseMetric {Parameters.ProjectID},{Parameters.PMIID},{P},5,'19',1,NULL,'ADMIN',NULL";
                string strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return strResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ShowHistory([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlab_Sel_BaseMetric_AuditTrail  " + Parameters.MilestoneID + ",'" + Parameters.ModifiedField + "', '" + Parameters.HisModifiedBy + "'";

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
        public object GetModifiedField([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlabs_Sel_BaseMetric_ModifiedField " + Parameters.MilestoneID;

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
        public object GetModifiedBy([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlabs_Sel_BaseMetric_ModifiedBy " + Parameters.MilestoneID;

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
        public object GetDerivedMetricIsFreezed([FromBody] PM_WF_BaseMetricReport Parameters)
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

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetBaseMetricIsCopied([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_marlabs_sel_BaseMetric_IsCopied " + Parameters.TemplateID + "," + Parameters.ProjectID + "," + Parameters.MilestoneID + "";

                //string Result = Convert.(CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString));
                object Result = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CopyPrevMilestone([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            string strSQL = "";
            try
            {
                string Result = "";
                strSQL = "Exec usp_Marlab_Ins_Upd_CopyPrevMSBaseMetric " + Parameters.OldMilestoneId + "," + Parameters.NewMilestoneId + ",'" + Parameters.UserName + "'";

                Result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRoleDetails([FromBody] PM_WF_BaseMetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlab_Sel_Role " + Parameters.UserID + "," + Parameters.ProjectID;

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
}
