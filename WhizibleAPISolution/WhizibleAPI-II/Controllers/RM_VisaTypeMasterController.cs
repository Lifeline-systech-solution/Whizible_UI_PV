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
    [Authorize]
    public class RM_VisaTypeMasterController : ApiController
    {

        //Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        ////End of comment by imran on 19-08-2022 
        [HttpPost]
        public HttpResponseMessage GetVisaTypeDetails([FromBody] VTFilterParameter vTFilter)
        {
           
            try
            {
                var visaList = new List<RM_VisaTypeMaster>();
                string filterParms = "";
                if (vTFilter != null && vTFilter.VTWhereClause != null && !string.IsNullOrEmpty(vTFilter.VTWhereClause))
                {
                    // filterParms = vTFilter.VTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(vTFilter.VTWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_VisaTypeMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_VisaTypeMaster";
                }


                DataTable VisaTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (VisaTable != null)
                {
                    visaList = VisaTable.ToList<RM_VisaTypeMaster>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, visaList);
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
        public HttpResponseMessage SaveVisaTypeDetails([FromBody] RM_VisaTypeMaster rM_Visa)
        {

            try
            {
                string strtResult = string.Empty;
                string strSQL;
                if (rM_Visa != null)
                {
                    if (rM_Visa.VisaTypeID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_VisaTypeMaster " + rM_Visa.VisaTypeID + ", '" + rM_Visa.VisaType.Trim() + "' , '" + rM_Visa.CreatedBy +"' ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_VisaTypeMaster " + rM_Visa.VisaTypeID + ", '" + rM_Visa.VisaType.Trim() + "' , '" + rM_Visa.CreatedBy + "'";
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
        public HttpResponseMessage DeleteVisaTypeDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_VisaTypeMaster '" + itemUniqueID + "'";
                        //CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
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
