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
    public class RM_GradeMasterController : ApiController
    {

        [HttpPost]
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        //End of comment by imran on 19-08-2022
        public HttpResponseMessage GetGradeMaster([FromBody] GMFilterParameter filterParameter)
        {
            List<RM_GradeMaster> listWorkProfile = new List<RM_GradeMaster>();
            string filterParms = "";
            try
            {
                if (filterParameter != null && filterParameter.GMWhereClause != null && !string.IsNullOrEmpty(filterParameter.GMWhereClause))
                {
                    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.GMWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_GradeMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_GradeMaster";
                }


                DataTable WPTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (WPTable != null)
                {

                    foreach (DataRow item in WPTable.Rows)
                    {
                        RM_GradeMaster objGradeMaster = new RM_GradeMaster()
                        {
                            GradeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["GradeID"], "0")),
                            LevelID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["LevelID"], "0")),
                            GradeDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["GradeDescription"], "")),
                            Grade = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["Grade"], "")),
                            weightage = string.Format("{0:0.0}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(item["weightage"],"0")))
                        };

                        listWorkProfile.Add(objGradeMaster);
                    }


                }
                return Request.CreateResponse(HttpStatusCode.OK, listWorkProfile);
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
        public HttpResponseMessage SaveGradeMasterDetails([FromBody] RM_GradeMaster rM_GradeMaster)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (rM_GradeMaster != null)
                {
                    if (rM_GradeMaster.GradeID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_GM_Upd_tbl_PM_GradeMaster " + rM_GradeMaster.GradeID +",'" + rM_GradeMaster.Grade + "','" + rM_GradeMaster.GradeDescription + "', '" + rM_GradeMaster.weightage + "','" + rM_GradeMaster.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_GM_Ins_tbl_PM_GradeMaster " + rM_GradeMaster.GradeID + ",'" + rM_GradeMaster.Grade + "','" + rM_GradeMaster.GradeDescription + "', '" + rM_GradeMaster.weightage + "','" + rM_GradeMaster.CreatedBy + "'";
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
        public HttpResponseMessage DeleteGMDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_GM_Del_tbl_PM_GradeMaster '" + itemUniqueID + "'";
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
