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
    public class PM_ProjectEffortsTestingController : ApiController
    {

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectDetails([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Marlab_Sel_ProjectDetails  " + Parameters.ProjectID;
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
        public object GetTemplatewiseAccessibleProject([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlab_sel_Accessible_TemplateWise_Project '" + Parameters.UserID + "','" + Parameters.LoginType + "', 1, 0,'[Over] = ''0''','ProjectName ASC',"+Parameters.TemplateID+""; 

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
        public object GetProjectEffortDetails([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_marlabs_sel_tbl_Marlab_TestingAgile_ProjectEffort  " + Parameters.ProjectID +"," + Parameters.TemplateID ;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        
        //[HttpPost]
        //[Authorize, App_Start.ValidateHeaders]
        //public object GetProjectMileStoneCount([FromBody] PM_MetricReport Parameters)
        //{
        //    try
        //    {
        //        string strSQL = "";
        //        string Result = "";
        //        strSQL = "Exec usp_marlabs_sel_ProjectMilestoneCount  " + Parameters.ProjectID;
        //        Result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
        //        return Result;

        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
        //    }
        //}

        
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectMileStoneList([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_sel_tbl_Marlab_TestingAgile_MilestoneList  " + Parameters.ProjectID;
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
        public object SaveProjectEffort([FromBody] PM_MetricReport Parameters)
        {
            string strSQL = "";
            try
            {
                string Result = "";
                strSQL = "Exec usp_Marlab_ins_upd_TestingAgile_ProjectEffort " + Parameters.ProjectID + "," + Parameters.TemplateID + "," + Parameters.MileStoneID + "," + Parameters.ResourceID + ",'" + Parameters.AttributeValue + "'," + Parameters.IsCreated + ",'" + Parameters.CreatedBy + "'";

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
        public object UpdateMilestoneOrder([FromBody] PM_MetricReport Parameters)
        {
            string strSQL = "";
            try
            {
                string Result = "";
                strSQL = "Exec usp_Marlab_Update_MilestoneOrder_ProEfft_TestingAgile " + Parameters.ProjectID + "," + Parameters.NewMilestoneId + "," + Parameters.NewOrder + "," + Parameters.OldMilestoneId + "," + Parameters.OldOrder + ",'" + Parameters.CreatedBy + "'";

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
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CopyPrevMilestone([FromBody] PM_MetricReport Parameters)
        {
            string strSQL = "";
            try
            {
                string Result = "";
                strSQL = "Exec usp_Marlab_Ins_Upd_CopyPrevMilestone_ProEfft_TestingAgile " + Parameters.OldMilestoneId + ","+Parameters.NewMilestoneId + ",'" + Parameters.CreatedBy + "'";

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
        public object ShowHistory([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlab_Sel_tbl_Marlab_TestingAgile_ProjectEffort_AuditTrail  " + Parameters.MileStoneID + ",'" + Parameters.ModifiedField + "', '" + Parameters.HisModifiedBy + "'";

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
        public object GetModifiedField([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlabs_Sel_tbl_Marlab_TestingAgile_ProjectEffort_ModifiedField " + Parameters.MileStoneID;

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
        public object GetModifiedBy([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlabs_Sel_tbl_Marlab_TestingAgile_ProjectEffort_ModifiedBy " + Parameters.MileStoneID;

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
        public object GetRoleDetails([FromBody] PM_MetricReport Parameters)
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

        [HttpPost]
        [Authorize]
        public object CheckCopyIsEnableorNot([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                string Result = "";
                strSQL = "Exec usp_Marlab_Sel_EnableCopyFlag";

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
        public object CopyStatus([FromBody] PM_MetricReport Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Marlab_Sel_TestingAgile_ProjectEffortIsSprintCopied " + Parameters.MileStoneID + "";

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
        public object GetMilestoneDetails([FromBody] PM_MetricReport Parameters)
        {
            string strSQL = "";
            try
            {
                strSQL = "Exec usp_marlabs_sel_MilestoneDetails " + Parameters.MileStoneID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        
       
    }
}
