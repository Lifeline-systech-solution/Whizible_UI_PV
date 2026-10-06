using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;
 
namespace WhizibleAPI.Controllers
{
    public class RM_InfraStatusController : ApiController
    {
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 19-08-2022 
        [HttpPost]
        public HttpResponseMessage GetInfraStatus([FromBody]  ISFilterParameter isFilterParameter)
        {
            var statusList = new List<RM_InfraStatus>();
            string filterParms = "";
            try
            {
                if (isFilterParameter != null && isFilterParameter.ISWhereClause != null && !string.IsNullOrEmpty(isFilterParameter.ISWhereClause))
                {
                    // filterParms = vTFilter.VTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(isFilterParameter.ISWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_RM_InfraStatusMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_RM_InfraStatusMaster";
                }


                DataTable ISTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (ISTable != null)
                {
                    statusList = ISTable.ToList<RM_InfraStatus>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, statusList);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveInfraStatusDetails([FromBody] RM_InfraStatus rM_InfraStatus)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (rM_InfraStatus != null)
                {
                    if (rM_InfraStatus.InfraStatusId > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraStatusMaster " + rM_InfraStatus.InfraStatusId + ", '" + rM_InfraStatus.InfraStatus + "', '" + rM_InfraStatus.Status + "' , '" + rM_InfraStatus.CreatedBy + "' ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraStatusMaster " + rM_InfraStatus.InfraStatusId + ", '" + rM_InfraStatus.InfraStatus + "', '" + rM_InfraStatus.Status + "' , '" + rM_InfraStatus.CreatedBy + "' ";
                    }
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    if (strtResult != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                    }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, strtResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteInfraStatusDetails([FromBody] string Parameters)
        {
            try
            {
                string strResult = "";
                int delete = 0;
                int notDelete = 0;
                if (Parameters != null)
                {
                    var splitParmas = Parameters.Split(',').ToList();
                    foreach (var itemUniqueID in splitParmas)
                    {
                        string strSQL = "Exec usp_Whizible2_InfraStatus_Del_tbl_RM_InfraStatusMaster '" + itemUniqueID + "'";
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
}
