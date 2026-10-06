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
    public class RM_InfraTypeController : ApiController
    {
        ////Added by imran on 19-08-2022  
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetInfraType([FromBody]  ITFilterParameter iTFilterParameter)
        {
            var typeList = new List<RM_InfraType>();
            string filterParms = "";
            try
            {
                if (iTFilterParameter != null && iTFilterParameter.ITWhereClause != null && !string.IsNullOrEmpty(iTFilterParameter.ITWhereClause))
                {
                    // filterParms = vTFilter.VTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(iTFilterParameter.ITWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_RM_InfraTypeMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_RM_InfraTypeMaster";
                }


                DataTable ITTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (ITTable != null)
                {
                    typeList = ITTable.ToList<RM_InfraType>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, typeList);
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
        public HttpResponseMessage SaveInfraTypeDetails([FromBody] RM_InfraType rM_InfraType)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (rM_InfraType != null)
                {
                    if (rM_InfraType.InfraTypeId > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraTypeMaster " + rM_InfraType.InfraTypeId + ", '" + rM_InfraType.InfraTypeName + "', '" + rM_InfraType.Status + "' , '" + rM_InfraType.CreatedBy + "' ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraTypeMaster " + rM_InfraType.InfraTypeId + ", '" + rM_InfraType.InfraTypeName + "', '" + rM_InfraType.Status + "' , '" + rM_InfraType.CreatedBy + "' ";
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
        public HttpResponseMessage DeleteInfraTypeDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_InfraType_Del_tbl_RM_InfraTypeMaster '" + itemUniqueID + "'";
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
