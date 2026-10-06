using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    //Created by Vishal Mane on 01/02/2026 to implement bulk extension workflow for Expleo
    public class SM_BulkExtensionWorkflowController : ApiController
    {
        [HttpPost]
        [Authorize]
        public object GetWorkflowMasterDetails()
        {

            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExt_WorkflowMaster";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }

        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SaveWorkflowDetails([FromBody] SM_BulkExtensionWFMaster obj)
        {
            try
            {
                string strtResult = string.Empty;
                DataTable dt = new DataTable();
                string strSQL;
                if (obj != null)
                {
                    if (obj.WorkflowID > 0)
                    {
                        strSQL = "Exec usp_Upd_tbl_Whizible2_BulkExt_WorkflowMaster " + obj.WorkflowID + ", '" + obj.WorkflowName.Trim() + "' ,'" + obj.WorkflowCode.Trim() + "' ," + obj.IsActive + " , '" + obj.CreatedBy + "' ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Ins_tbl_Whizible2_BulkExt_WorkflowMaster " + obj.WorkflowID + ", '" + obj.WorkflowName.Trim() + "' ,'" + obj.WorkflowCode.Trim() + "' ," + obj.IsActive + " , '" + obj.CreatedBy + "' ";
                    }
                    //strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    
                }
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public HttpResponseMessage DeleteStatusDetails([FromBody] string Parameters)
        {
            try
            {
                if (Parameters != null)
                {
                    string strResult = "";
                    int delete = 0;
                    int notDelete = 0;
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Del_tbl_Whizible2_BulkExt_WorkflowMaster '" + itemUniqueID + "'";
                        strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strResult == "deleted")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }
                    }
                    return Request.CreateResponse(HttpStatusCode.OK, new { deletedCount = delete, notDeletedCount = notDelete });
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetLocation([FromBody] SM_BulkExtensionWFMaster obj)

        {
            try
            {
                string strSQL = "";
                if (obj.BussinessGroupID == 0)
                {
                    //strSQL = "Exec usp_Whizible2_Sel_Tbl_PM_Location";  
                    strSQL = "Exec usp_Whizible2_Sel_OU_BulkExtension_WF_All '" + obj.WorkflowID + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_OU_BulkExtension_WF '" + obj.BussinessGroupID + "','" + obj.WorkflowID + "'";
                }
                
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize]
        public object GetPracticeType([FromBody] SM_BulkExtensionWFMaster obj)
        {
            try
            {
                string strSQL = "";
                
                strSQL = "Exec usp_Whizible2_Sel_ProjectTypes_BulkExtension_WF '" + obj.WorkflowID + "'";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize]
        public object GetBusinessGroup([FromBody] SM_BulkExtensionWFMaster obj)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_BG_BulkExtension_WF '" + obj.WorkflowID + "'";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize]
        public object SaveApplicableAttributes(SM_BulkExtensionWFMaster model)
        {
            try
            {
                string jsonAttributes = Newtonsoft.Json.JsonConvert.SerializeObject(model.Attributes);
                string strSQL = "Exec usp_Upd_tbl_Whizible2_BulkExt_WFMaster_Attributes " + model.WorkflowID + ",'" + model.CreatedBy + "','" + jsonAttributes + "'";                
                string Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetWorkflowAttribute(SM_BulkExtensionWFMaster model)
        {
            try
            {  
                string strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExt_WFMaster_Attributes " + model.WorkflowID + "";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetWorkflowStatusMaster(SM_BulkExtensionWFMaster model)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExtension_StatusMaster_Dropdown " + model.WorkflowID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetWorkflowRoles(SM_BulkExtensionWFMaster model)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Role_BulkExt_WFMaster " + model.WorkflowID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetWorkflowStages(SM_BulkExtensionWFMaster model)
        {
            try
            {
                string strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExt_WFMaster_Stage " + model.WorkflowID + "";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize]
        public object SaveWorkflowStages(SM_BulkExtensionWFMaster model)
        {
            try
            {
                string jsonStageAttributes = Newtonsoft.Json.JsonConvert.SerializeObject(model.StageAttributes);
                string strSQL = "Exec usp_Ins_tbl_Whizible2_BulkExt_WFMaster_Stage " + model.WorkflowID + ",'" + model.CreatedBy + "','" + jsonStageAttributes + "'";
                string Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object PublishWorkflowStages(SM_BulkExtensionWFMaster obj)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Ins_tbl_Whizible2_BulkExt_WorkflowMaster_PublishStages " + obj.WorkflowID + ",'" + obj.CreatedBy + "'";

                //DataTable dt = new DataTable();
                //dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                //return dt;

                string Result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString).ToString();
                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CheckIsRoleActiveEmployee(StageAttribute model)
        {
            try
            {
                string strSQL = "Exec usp_Sel_Bulk_Ext_RoleEmployees " + model.RoleID;
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
    public class SM_BulkExtensionWFMaster
    {
        public int WorkflowID { get; set; }
        public string WorkflowName { get; set; }
        public string WorkflowCode { get; set; }
        public int IsActive { get; set; }
        public int RevisionNumber { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public int BussinessGroupID { get; set; }
        public List<ApplicableAttribute> Attributes { get; set; }
        public List<StageAttribute> StageAttributes { get; set; }
    }
    public class ApplicableAttribute
    {
        public int PracticeID { get; set; }
        public int BusinessGroupID { get; set; }
        public int OrganizationUnitID { get; set; }
        public int OrderNo { get; set; }
        public int IsApplicable { get; set; }
    }
    public class StageAttribute
    {
        public int OrderNo { get; set; }
        public int StageID { get; set; }
        public int RoleID { get; set; }
        public int IsMandatory { get; set; }
        
        public int IsApplicable { get; set; }
    }
}
