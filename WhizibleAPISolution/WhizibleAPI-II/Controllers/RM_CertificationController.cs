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
    public class RM_CertificationController : ApiController
    {

        ////Added by imran on 19-08-2022  
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022 
        [HttpPost]
        public HttpResponseMessage GetCertificateDetails([FromBody] CRTFilterParameter cRTFilter)
        {
            var certificationList = new List<RM_Certification>();
            string filterParms = "";
            try
            {
                if (cRTFilter != null && cRTFilter.CRTWhereClause != null && !string.IsNullOrEmpty(cRTFilter.CRTWhereClause))
                {
                   // filterParms = cRTFilter.CRTWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(cRTFilter.CRTWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");
                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_Certifications '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_Certifications";
                }


                DataTable CertificateTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (CertificateTable != null)
                {
                    certificationList = CertificateTable.ToList<RM_Certification>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, certificationList);

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
        public HttpResponseMessage SaveCertificationDetails([FromBody] RM_Certification rM_Certification)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (rM_Certification != null)
                {
                    if (rM_Certification.CertificationID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Certifications " + rM_Certification.CertificationID + ", '" + rM_Certification.CertificationName.Trim() + "' , '" + rM_Certification.CreatedBy +"' ";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Certifications " + rM_Certification.CertificationID + ", '" + rM_Certification.CertificationName.Trim() + "' , '" + rM_Certification.CreatedBy+"' ";
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
        public HttpResponseMessage DeleteCertificationDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_Certifications '" + itemUniqueID + "'";
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
