using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{
    public class RM_QualificationController : ApiController
    {

        [HttpPost]
        //Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders] 
        ////End of comment by imran on 19-08-2022 
        public HttpResponseMessage GetQualifications([FromBody] QFilterParameter filterParameter)
        {
           
            try
            {
                List<RM_Qualification> listQualifications = new List<RM_Qualification>();
                string filterParms = "";
                if (filterParameter != null && filterParameter.QWhereClause != null && !string.IsNullOrEmpty(filterParameter.QWhereClause))
                {
                    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.QWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_Qualifications '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_Qualifications";
                }


                DataTable QualificationTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (QualificationTable != null)
                {

                    foreach (DataRow item in QualificationTable.Rows)
                    {
                        RM_Qualification objGradeMaster = new RM_Qualification()
                        {
                            QualificationID= Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["QualificationID"], "0")),
                            QualificationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["QualificationName"], "")),
                            QualificationGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["QualificationGroupID"], "0")),

                        };

                        listQualifications.Add(objGradeMaster);
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, listQualifications);
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
        public HttpResponseMessage SaveQualification([FromBody] RM_Qualification rM_Qualification)
        {
            
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                if (rM_Qualification != null)
                {
                    if (rM_Qualification.QualificationID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_Qualification " + rM_Qualification.QualificationID + ",'" + rM_Qualification.QualificationName + "'," +rM_Qualification.QualificationGroupID +",'"+ rM_Qualification.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Qualification '" + rM_Qualification.QualificationName + "'," + rM_Qualification.QualificationGroupID + ",'" + rM_Qualification.CreatedBy + "'";
                    }

                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
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
                  return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
          
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteQualifications([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_Qualification '" + itemUniqueID + "'";
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
                  return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }

        }
    }
}
