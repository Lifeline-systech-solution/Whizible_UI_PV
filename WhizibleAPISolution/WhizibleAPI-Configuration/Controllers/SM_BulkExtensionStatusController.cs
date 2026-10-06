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
    public class SM_BulkExtensionStatusController : ApiController
    {
        [HttpPost]
        [Authorize]
        public object GetStatusMasterDetails()
        {

            try
            { 
                string strSQL = "";
                strSQL = "Exec usp_Sel_tbl_Whizible2_BulkExtension_StatusMaster";
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
        public object SaveStatusDetails([FromBody] SM_BulkExtensionStatus obj)
        {
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                if (obj != null)
                {
                    if (obj.StatusID > 0)
                    {
                        strSQL = "Exec usp_Upd_tbl_Whizible2_BulkExtension_StatusMaster " + obj.StatusID + ", '" + obj.Status.Trim() + "' ,'" + obj.SystemStatus.Trim() + "' , '" + obj.CreatedBy + "' ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Ins_tbl_Whizible2_BulkExtension_StatusMaster " + obj.StatusID + ", '" + obj.Status.Trim() + "' ,'" + obj.SystemStatus.Trim() + "' , '" + obj.CreatedBy + "'";
                    }
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                }
                return strtResult;
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
                        string strSQL = "Exec usp_Del_tbl_Whizible2_BulkExtension_StatusMaster '" + itemUniqueID + "'";
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
    }

    public class SM_BulkExtensionStatus
    {
        public int StatusID { get; set; }
        public string Status { get; set; }
        public string SystemStatus { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
    }
}
