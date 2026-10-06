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
    public class RM_QualificationGroupController : ApiController
    {
         
        [HttpPost]
        ////Added by imran on 19-08-2022  
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022  
        public HttpResponseMessage GetQualificationGroup([FromBody] QGFilterParameter filterParameter)
        {
            
            try
            {
                List<RM_QualificationGroup> listQualificationGroup = new List<RM_QualificationGroup>();
                string filterParms = "";
                if (filterParameter != null && filterParameter.QGWhereClause != null && !string.IsNullOrEmpty(filterParameter.QGWhereClause))
                {
                    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.QGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_QualificationGroupMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_QualificationGroupMaster";
                }


                DataTable WPTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (WPTable != null)
                {

                    foreach (DataRow item in WPTable.Rows)
                    {
                        RM_QualificationGroup objGradeMaster = new RM_QualificationGroup()
                        {
                            QualificationGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["QualificationGroupID"], "0")),
                            QualificationGroupName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["QualificationGroupName"], "")),
                        };

                        listQualificationGroup.Add(objGradeMaster);
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK, listQualificationGroup);
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
        public HttpResponseMessage SaveQualificationGroupDetails([FromBody] RM_QualificationGroup rM_QualificationGroup)
        {
           
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                if (rM_QualificationGroup != null)
                {
                    if (rM_QualificationGroup.QualificationGroupID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_QG_Upd_tbl_PM_QualificationGroupMaster " + rM_QualificationGroup.QualificationGroupID + ",'" + rM_QualificationGroup.QualificationGroupName +  "','" + rM_QualificationGroup.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_QG_Ins_tbl_PM_QualificationGroupMaster " + rM_QualificationGroup.QualificationGroupID + ",'" + rM_QualificationGroup.QualificationGroupName + "','" + rM_QualificationGroup.CreatedBy + "'";
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
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteQGDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_QG_Del_tbl_PM_QualificationGroupMaster '" + itemUniqueID + "'";
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
