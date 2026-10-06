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
    public class RM_DesignationController : ApiController
    {

        [HttpPost]
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders] 
        //End of comment by imran on 19-08-2022  
        public HttpResponseMessage GetDesignation([FromBody] DsgFilterParameter filterParameter)
        {
            List<RM_Designation> listDesignation = new List<RM_Designation>();
            string filterParms = "";
            try
            {
                if (filterParameter != null && filterParameter.DsgWhereClause != null && !string.IsNullOrEmpty(filterParameter.DsgWhereClause))
                {
                    //filterParms = filterParameter.DsgWhereClause;// HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");// DecodeWhereClause(BgFilterParameter.BGWhereClause);///HttpUtility.UrlDecode(BgFilterParameter.BGWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "'";
                    filterParms = HttpUtility.UrlDecode(filterParameter.DsgWhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                else
                {
                    filterParms = null;
                }
                string strSQL = "";
                if (filterParms != null)
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_DesignationMaster '" + filterParms + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_sel_tbl_PM_DesignationMaster";
                }


                DataTable WPTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (WPTable != null)
                {

                    foreach (DataRow item in WPTable.Rows)
                    {
                        RM_Designation objDesignation = new RM_Designation()
                        {
                            DesignationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["DesignationID"], "0")),
                            DesignationName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["DesignationName"], "")),
                                                   };

                        listDesignation.Add(objDesignation);
                    }


                }
                return Request.CreateResponse(HttpStatusCode.OK, listDesignation);
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
        public HttpResponseMessage SaveDesignationDetails([FromBody] RM_Designation rM_Designation)
        {
            string strtResult = string.Empty;
            string strSQL;
            try
            {
                if (rM_Designation != null)
                {
                    if (rM_Designation.DesignationID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Designation_Upd_tbl_PM_DesignationMaster " + rM_Designation.DesignationID + ",'" + rM_Designation.DesignationName +  "','" + rM_Designation.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Designation_Ins_tbl_PM_DesignationMaster " + rM_Designation.DesignationID + ",'" + rM_Designation.DesignationName + "','" + rM_Designation.CreatedBy + "'";
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
        
        
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage DeleteDesignationDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_Designation_Del_tbl_PM_DesignationMaster '" + itemUniqueID + "'";
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

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetDesignationLeaves(RM_DesignationLeaves Op_parameters)
        {
            var LeavesList = new List<RM_DesLeaves>();
            try
            {
                if (Op_parameters.DesignationID > 0)
                {
                    string strSQL = "usp_Whizible2_Sel_GetLeaveMaster " + Op_parameters.DesignationID;
                    DataTable LeavesTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (LeavesTable != null)
                        foreach (DataRow item in LeavesTable.Rows)
                        {
                            RM_DesLeaves objDesLeaves = new RM_DesLeaves()
                            {
                                UniqueID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["UniqueID"], "0")),
                                LeaveTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["LeaveTypeID"], "0")),
                                Role = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(item["Role"], "0")),
                                LeaveType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(item["LeaveType"], "")),
                                ProRata = string.Format("{0:0.0}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(item["ProRata"], "0"))),
                                NoOfLeaves = string.Format("{0:0.0}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(item["NoOfLeaves"], "0")))
                            };

                            LeavesList.Add(objDesLeaves);
                        }

                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, LeavesList);

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
        public HttpResponseMessage SaveLeaves([FromBody] RM_DesLeaves Op_parameters)
        {
            string strtResult = string.Empty;
            string strSQL="";
            try
            {
                if (Op_parameters != null)
                {
                    if(Op_parameters.ProRata=="" || Op_parameters.ProRata == " ")
                    {
                        Op_parameters.ProRata = "0";
                    }
                    if (Op_parameters.UniqueID > 0)
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_PM_LeaveMaster " + Op_parameters.UniqueID + "," + Op_parameters.Role + "," + Op_parameters.LeaveTypeID + "," + Op_parameters.NoOfLeaves + "," + Op_parameters.ProRata + ",'" + Op_parameters.CreatedBy + "'";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Ins_tbl_PM_LeaveMaster " + Op_parameters.Role + "," + Op_parameters.LeaveTypeID + "," + Op_parameters.NoOfLeaves + ","+Op_parameters.ProRata+",'"+Op_parameters.CreatedBy+"'";
                    }

                    //int Result = CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                    strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    if (strtResult != null)
                    {
                        string strSQLProb = "EXEC usp_Whizible2_Ins_tbl_PM_EmployeeLeaveMaster " + Op_parameters.LeaveTypeID + "," + Op_parameters.Role;
                        CommonFunctions.Data.InsertOrUpdateData(strSQLProb, true, CommonController.connectionString);
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
        public HttpResponseMessage DeleteLeaveDetails([FromBody] string Parameters)
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
                        string strSQL = "Exec usp_Whizible2_del_tbl_PM_LeaveMaster '" + itemUniqueID + "'";
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
