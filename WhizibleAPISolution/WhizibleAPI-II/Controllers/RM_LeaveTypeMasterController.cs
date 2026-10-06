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
    public class RM_LeaveTypeMasterController:ApiController
    {
        [HttpPost]
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        //End of comment by imran on 19-08-2022
        public HttpResponseMessage GetLeaveTypes([FromBody] LeaveFilterParameter filterParameter)
        {
            List<RM_LeaveTypeMaster> listLeaves = new List<RM_LeaveTypeMaster>();
            string filterParms = "";
            try
            {
                if (filterParameter != null && filterParameter.LeaveWhereClause != null && !string.IsNullOrEmpty(filterParameter.LeaveWhereClause))
                {
                    //filterParms = filterParameter.GMWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.LeaveWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_LeaveTypeMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_LeaveTypeMaster";
                }


                DataTable LeaveTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (LeaveTable != null)
                {

                    foreach (DataRow item in LeaveTable.Rows)
                    {
                        RM_LeaveTypeMaster objLeaveMaster = new RM_LeaveTypeMaster()
                        {
                            LeaveTypeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["LeaveTypeID"], "0")),
                            LeaveType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["LeaveType"], "")),
                            CarryForward = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(item["CarryForward"], "")),

                        };

                        listLeaves.Add(objLeaveMaster);
                    }


                }
                return Request.CreateResponse(HttpStatusCode.OK, listLeaves);
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
        public HttpResponseMessage SaveLeaveTypeMaster([FromBody] RM_LeaveTypeMaster rM_LeaveType)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (rM_LeaveType != null)
                {
                    if (rM_LeaveType.LeaveTypeId > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_LeaveTypeMaster " + rM_LeaveType.LeaveTypeId + ",'" + rM_LeaveType.LeaveType + "'," + rM_LeaveType.CarryForward + ",'" + rM_LeaveType.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_LeaveTypeMaster '" + rM_LeaveType.LeaveType + "'," + rM_LeaveType.CarryForward + ",'" + rM_LeaveType.CreatedBy + "'";
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
        public HttpResponseMessage DeleteLeaveTypeMaster([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_Del_tbl_PM_LeaveTypeMaster '" + itemUniqueID + "'";
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