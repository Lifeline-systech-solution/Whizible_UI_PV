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
    public class RM_InfraGroupController : ApiController
    { 
        ////Added by imran on 19-08-2022  
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetInfraGroups([FromBody]  IGFilterParameter iGFilterParameter)
        {
            var groupList = new List<RM_InfraGroup>();
            string filterParms = "";
            try
            {
                if (iGFilterParameter != null && iGFilterParameter.IGWhereClause != null && !string.IsNullOrEmpty(iGFilterParameter.IGWhereClause))
                {                    
                    // filterParms = vTFilter.VTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(iGFilterParameter.IGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_RM_InfraGroupMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_RM_InfraGroupMaster";
                }


                DataTable IGTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (IGTable != null)
                {
                    groupList = IGTable.ToList<RM_InfraGroup>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, groupList);
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
        public HttpResponseMessage SaveInfraGroupDetails([FromBody] RM_InfraGroup rM_InfraGroup)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (rM_InfraGroup != null)
                {
                    if (rM_InfraGroup.InfraGroupId > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraGroupMaster " + rM_InfraGroup.InfraGroupId + ", '" + rM_InfraGroup.InfraGroupName + "', '" +rM_InfraGroup.Status + "' , '" + rM_InfraGroup.CreatedBy + "' ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraGroupMaster " + rM_InfraGroup.InfraGroupId + ", '" + rM_InfraGroup.InfraGroupName + "', '" + rM_InfraGroup.Status + "' , '" + rM_InfraGroup.CreatedBy + "' ";
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
        public HttpResponseMessage DeleteInfraGroupDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_InfraGroup_Del_tbl_RM_InfraGroupMaster '" + itemUniqueID + "'";
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
