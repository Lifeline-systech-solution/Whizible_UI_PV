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
    public class RM_WorkProfileController : ApiController
    {

        //Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        ////End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetWorkProfile([FromBody] WPFilterParameter filterParameter)
        {
            
            try
            {
                List<RM_WorkProfile> listWorkProfile = new List<RM_WorkProfile>();
                string filterParms = "";
                if (filterParameter != null && filterParameter.WPWhereClause != null && !string.IsNullOrEmpty(filterParameter.WPWhereClause))
                {
                   // filterParms = filterParameter.WPWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.WPWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_v_h_tbl_HR_Parameters '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_v_h_tbl_HR_Parameters";
                }


                DataTable WPTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (WPTable != null)
                {

                    foreach (DataRow item in WPTable.Rows)
                    {
                        RM_WorkProfile objWorkProfile = new RM_WorkProfile()
                        {
                            ParameterID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["ParameterID"], "0")),
                            ParameterGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["ParameterGroupID"], "0")),
                            ParameterValue = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["ParameterValue"], "")),
                            ParameterDescription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["ParameterDescription"], "")),
                            OrderNumber = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["OrderNumber"], "")),
                        };

                        listWorkProfile.Add(objWorkProfile);
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
        public HttpResponseMessage SaveWorkProfileDetails([FromBody] RM_WorkProfile rM_WorkProfile)
        {
           
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                if (rM_WorkProfile != null)
                {
                    if (rM_WorkProfile.ParameterID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_WP_Upd_tbl_HR_Parameters " + rM_WorkProfile.ParameterID + "," + rM_WorkProfile.ParameterGroupID + ",'" + rM_WorkProfile.ParameterValue + "', '" + rM_WorkProfile.ParameterDescription + "'," + rM_WorkProfile.OrderNumber + ",'" + rM_WorkProfile.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_WP_Ins_tbl_HR_Parameters " + rM_WorkProfile.ParameterID + "," + rM_WorkProfile.ParameterGroupID + ",'" + rM_WorkProfile.ParameterValue + "', '" + rM_WorkProfile.ParameterDescription + "'," + rM_WorkProfile.OrderNumber + ",'" + rM_WorkProfile.CreatedBy + "'";
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
        public HttpResponseMessage DeleteWPDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_WP_Del_tbl_HR_Parameters '" + itemUniqueID + "'";
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