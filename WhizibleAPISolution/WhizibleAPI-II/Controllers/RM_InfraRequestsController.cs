using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;
using System.Data.SqlClient;
 
  
namespace WhizibleAPI.Controllers
{
    public class RM_InfraRequestsController : ApiController
    {
        ////Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetAll([FromBody] InfraFilterParameter infraFilterParameter)
        {
            var rM_InfraRequests = new List<RM_InfraRequest>();
            string filterParms = "";
            IDataReader drQuery, drQueryL;
            string RoleDescription = "";
            // bool IsInfraApprover=false;
            //bool IsManagerExist=false;
            int LocationId = 0;
            string strSQL2 = "";
            try
            {
                if (infraFilterParameter != null && infraFilterParameter.WhereClause != null && !string.IsNullOrEmpty(infraFilterParameter.WhereClause))
                {
                    filterParms = HttpUtility.UrlDecode(infraFilterParameter.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }

                if (infraFilterParameter.LoginUserID > 0)
                {
                    strSQL2 = "select * from v_tbl_PM_OUPool_Managers where  ManagerID=" + infraFilterParameter.LoginUserID;
                    drQueryL = CommonFunctions.Data.GetDataReader(strSQL2, true, CommonController.connectionString);
                    if (drQueryL.Read())
                    {

                        LocationId = Convert.ToInt32(drQueryL["OUPoolID"]);
                        CommonFunctions.Data.DisposeDataReader(ref drQueryL);
                    }

                    var strSQLProb = "usp_Whizible2_Sel_tbl_Role_InfraRoleApprover '" + infraFilterParameter.LoginUserID + "'," + infraFilterParameter.RoleID + "";
                    ///var strSQLProb = "select * from tbl_PM_Role Where RoleID=" + infraFilterParameter.RoleID + "";
                    drQuery = CommonFunctions.Data.GetDataReader(strSQLProb, true, CommonController.connectionString);
                    if (drQuery.Read())
                    {
                        //RoleDescription = Convert.ToString(drQuery["RoleDescription"]);
                        //IsInfraApprover = Convert.ToBoolean(drQuery["IsInfraApprover"]);
                        var IsManagerExist = Convert.ToBoolean(drQuery["IsManagerExist"]);
                        if (IsManagerExist)
                        {
                            RoleDescription = "Resource Manager"; //Approver 
                        }
                        else
                        {
                            RoleDescription = "Project Manager"; //Requester
                            
                        }
                        CommonFunctions.Data.DisposeDataReader(ref drQuery);
                    }
                }


                var strSQL = "Exec usp_Whizible2_Sel_Infra_GetRequests '" + filterParms + "'," + infraFilterParameter.LoginUserID + "," + LocationId + "";
                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                //if (infraDataTable != null)
                //{

                //    rM_InfraRequests = infraDataTable.ToList<RM_InfraRequest>();
                //}
                foreach (DataRow taskStatusRow in infraDataTable.Rows)
                {
                    RM_InfraRequest infraReq = new RM_InfraRequest();

                    infraReq.RequestId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RequestId"], "0"));
                    infraReq.InfraName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["InfraName"], ""));
                    infraReq.ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectName"], ""));
                    infraReq.Requested = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Requested"], "0"));
                    infraReq.Allocated = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Allocated"], "0"));
                    infraReq.RequestedDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RequestedDate"], ""));
                    infraReq.FromDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["FromDate"], ""));
                    infraReq.ToDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ToDate"], ""));
                    infraReq.AvailableLicenses = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["AvailableLicenses"], "0"));
                    infraReq.Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Status"], ""));
                    infraReq.ProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectId"], "0"));
                    infraReq.RequestedBy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RequestedBy"], ""));
                    infraReq.RoleName = RoleDescription;
                    //infraReq.IsInfraApprover = IsInfraApprover;
                    //infraReq.IsManagerExist = IsManagerExist;
                    //Added by Rutuja D. on 8 Feb 2022
                    infraReq.IsApproverManager = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["IsApproverManager"], "0"));
                    //End of Added by Rutuja D. on 8 Feb 2022

                    rM_InfraRequests.Add(infraReq);
                }
                return Request.CreateResponse(HttpStatusCode.OK, rM_InfraRequests);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }
        

        [HttpPost]
        public HttpResponseMessage GetById(int requestId, int loggedUserID)
        {
            var infraRequest = new RM_InfraRequest();
            var infraRequestApprovers = new List<RequestApprovers>();
            try
            {
                var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraRequestById '" + requestId + "'," + loggedUserID + "";
                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (infraDataTable != null)
                {
                    infraRequest = infraDataTable.ToList<RM_InfraRequest>().FirstOrDefault();
                }

                //IDataReader drQuery;
                //drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                //if (drQuery.Read())
                //{
                //    if (drQuery["RequestId"] != null)
                //    {
                //        infraRequest.Requested = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["RequestId"], "0"));
                //        infraRequest.InfraName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["ProjectName"], " "));
                //        infraRequest.Allocated = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["Allocated"], "0"));
                //        infraRequest.RequestedDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drQuery["RequestedDate"], ""));
                //        infraRequest.FromDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drQuery["FromDate"], ""));
                //        infraRequest.ToDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drQuery["ToDate"], ""));
                //        infraRequest.AvailableLicenses = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["AvailableLicenses"], "0"));
                //        infraRequest.Status = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["Status"], " "));
                //        infraRequest.ProjectId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["ProjectId"], "0"));
                //        infraRequest.Comments = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["Comments"], " "));

                //        infraRequest.AllocatedDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drQuery["AllocatedDate"], ""));

                //        infraRequest.ApprovalDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drQuery["ApprovalDate"], ""));
                //        infraRequest.RequestedUserId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["RequestedUserId"], "0"));
                //    }
                //}
                //drQuery.Close();

                //var strApproverSQL = "Exec usp_Whizible2_sel_Infra_Request_Approver_By_ProjectID " + infraRequest.ProjectId;
                var strApproverSQL = "Exec usp_Whizible2_sel_Infra_Request_Approver_By_ProjectID " + infraRequest.InfraResourceId;
                DataTable infraApproversDataTable = CommonFunctions.Data.GetDataTable(strApproverSQL, true, CommonController.connectionString);

                if (infraApproversDataTable != null)
                {
                    infraRequestApprovers = infraApproversDataTable.ToList<RequestApprovers>();
                    infraRequest.RequestApprovers = infraRequestApprovers;

                }
                return Request.CreateResponse(HttpStatusCode.OK, infraRequest);
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
        public HttpResponseMessage GetSmiliarRequests([FromBody] ResourceWeekWiseDetails resourceWeekWise, int requestId)
        {
            List<ResourceMonth> resourceMonths = new List<ResourceMonth>();
            var strSQL = "";
            try
            {
                List<ResourceWeekWiseDetails> infraRequests = new List<ResourceWeekWiseDetails>();
                if (resourceWeekWise.MonthDateTime != null && resourceWeekWise.MonthDateTime != "")
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraSimilarRequests '" + requestId + "','" + resourceWeekWise.MonthDateTime + "'";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraSimilarRequests '" + requestId + "'";
                }

                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (infraDataTable != null)
                {
                    foreach (DataRow taskStatusRow in infraDataTable.Rows)
                    {
                        ResourceWeekWiseDetails resourceWeekWiseDetails = new ResourceWeekWiseDetails()
                        {
                            Month = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Month"], "")),
                            MonthDateTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["MonthDateTime"], "")),
                            Week = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Week"], "")),
                            Count = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Count"], "0")),
                            WeekStartDateTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["WeekStartDateTime"], "")),
                            WeekEndDateTime = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["WeekEndDateTime"], ""))
                        };

                        infraRequests.Add(resourceWeekWiseDetails);
                    }


                    // var infraRequests = infraDataTable.ToListCast<ResourceWeekWiseDetails>();
                    if (infraRequests != null && infraRequests.Any())
                    {
                        var months =
                        from c in infraRequests
                        group c by new
                        {
                            c.Month,
                            c.MonthDateTime
                        } into gcs
                        select new ResourceMonth()
                        {
                            MonthName = gcs.Key.Month,
                            MonthDateTime = gcs.Key.MonthDateTime
                        };

                        if (months != null)
                        {
                            foreach (var month in months)
                            {
                                ResourceMonth resourceMonth = new ResourceMonth
                                {
                                    MonthName = month.MonthName,
                                    MonthDateTime = month.MonthDateTime,
                                    ResourceWeekWiseDetails = infraRequests.Where(i => i.Month == month.MonthName).ToList()
                                };
                                resourceMonths.Add(resourceMonth);
                            }
                        }
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, resourceMonths);
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
        public HttpResponseMessage GetSmiliarRequestsDetails([FromBody] ResourceWeekWiseDetails resourceWeekWise, int requestId)
        {
            List<RM_InfraRequest> rM_InfraRequests = new List<RM_InfraRequest>();
            try
            {
                var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraSimilarRequests_Details " + requestId + ", '" + resourceWeekWise.WeekStartDateTime + "', '" + resourceWeekWise.WeekEndDateTime + "'";
                // var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraSimilarRequests_Details " + requestId + ", '" + resourceWeekWise.WeekStartDateTime + "'";
                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (infraDataTable != null)
                {
                    rM_InfraRequests = infraDataTable.ToList<RM_InfraRequest>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, rM_InfraRequests);
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
        public HttpResponseMessage UpdateRequestStatus([FromBody] RM_InfraRequestUpdateStatus IrParameter)
        {
            string strtResult;
            var strSQL = "";
            try
            {

                if (IrParameter != null)
                {

                    if (IrParameter.IsFromEdit)
                    {
                        //Commented And Added By Reshma Chavan on 14th Dec 2021 Getting Page Crash While entering Comment
                        // strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateStatus " + IrParameter.RoleID + ", '" + IrParameter.UserID + "' ,'" + IrParameter.InfraRequestId + "','" + IrParameter.InfraResourceId + "' , "
                        //+ IrParameter.Quantity + " ,'" + IrParameter.StartDate + "' , '" + IrParameter.EndDate + "', '" + IrParameter.Status + "' ,'" + IrParameter.ModifiedBy + "' , '" + IrParameter.RequestedDate + "' , '"
                        //+ IrParameter.RequestedBy + "' ,'" + IrParameter.Approvalby + "' , '" + IrParameter.Comments + "', '" + IrParameter.AllocatedDate + "' ,'" + IrParameter.AllocatedBy + "' ,'"
                        //+ IrParameter.ApprovalDate + "' ,'" + IrParameter.RequestApprover + "' , '" + IrParameter.AllocatedQuantity + "', " + IrParameter.IsFromEdit + " ";
                        strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateStatus " + IrParameter.RoleID + ", '" + IrParameter.UserID + "' ,'" + IrParameter.InfraRequestId + "','" + IrParameter.InfraResourceId + "' , "
                       + IrParameter.Quantity + " ,'" + IrParameter.StartDate + "' , '" + IrParameter.EndDate + "', '" + IrParameter.Status + "' ,'" + IrParameter.ModifiedBy + "' , '" + IrParameter.RequestedDate + "' , '"
                       + IrParameter.RequestedBy + "' ,'" + IrParameter.Approvalby + "' , '" + IrParameter.Comments.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', '" + IrParameter.AllocatedDate + "' ,'" + IrParameter.AllocatedBy + "' ,'"
                       + IrParameter.ApprovalDate + "' ,'" + IrParameter.RequestApprover + "' , '" + IrParameter.AllocatedQuantity + "', " + IrParameter.IsFromEdit + " ";
                    }
                    else
                    {
                        //  strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateStatus " + IrParameter.RoleID + ", '" + IrParameter.UserID + "' ,'" + IrParameter.InfraRequestId + "','" + IrParameter.InfraResourceId + "' , "
                        //+ IrParameter.Quantity + " ,NULL,NULL, '" + IrParameter.Status + "' ,'" + IrParameter.ModifiedBy + "' , NULL , '"
                        //+ IrParameter.RequestedBy + "' ,'" + IrParameter.Approvalby + "' , '" + IrParameter.Comments + "', NULL ,'" + IrParameter.AllocatedBy + "' ,'"
                        //+ IrParameter.ApprovalDate + "' ,'" + IrParameter.RequestApprover + "' , '" + IrParameter.Quantity + "', True ";
                        strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateStatus " + IrParameter.RoleID + ", '" + IrParameter.UserID + "' ,'" + IrParameter.InfraRequestId + "','" + IrParameter.InfraResourceId + "' , "
                       + IrParameter.Quantity + " ,NULL,NULL, '" + IrParameter.Status + "' ,'" + IrParameter.ModifiedBy + "' , NULL , '"
                       + IrParameter.RequestedBy + "' ,'" + IrParameter.Approvalby + "' , '" + IrParameter.Comments.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', NULL ,'" + IrParameter.AllocatedBy + "' ,'"
                       + IrParameter.ApprovalDate + "' ,'" + IrParameter.RequestApprover + "' , '" + IrParameter.AllocatedQuantity + "', False ";

                        //End of Commented And Added By Reshma Chavan on 14th Dec 2021 Getting Page Crash While entering Comment
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
        public HttpResponseMessage UpdateRequestStatusMulti([FromBody] RM_InfraRequestUpdateStatusMuliti IrParameter)
        {
            try
            {
                int delete = 0;
                int notDelete = 0;
                if (IrParameter != null && IrParameter.InfraRequestIds != null && IrParameter.InfraRequestIds.Length > 0)
                {
                    string strResult = "";
                    var RM_IrRequestIDs = IrParameter.InfraRequestIds.Split(',').ToList();
                    foreach (var itemReqId in RM_IrRequestIDs)
                    {
                        IrParameter.IsFromEdit = false;
                        IDataReader StrdrQuery;
                        string strStatus = "";
                        int AllocatedQuantity = 0;
                        //Commented And Added By Reshma Chavan on 14th Dec 2021 Getting Page Crash While entering Comment
                        // var strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateStatus " + IrParameter.RoleID + ", '" + IrParameter.UserID + "' ,'" + itemReqId + "','" + IrParameter.InfraResourceId + "' , "
                        //+ IrParameter.Quantity + " ,NULL , NULL, '" + IrParameter.Status + "' ,'" + IrParameter.ModifiedBy + "' , NULL , '"
                        //+ IrParameter.RequestedBy + "' ,'" + IrParameter.Approvalby + "' , '" + IrParameter.Comments + "', NULL ,'" + IrParameter.AllocatedBy + "' ,NULL,'" + IrParameter.RequestApprover + "' , '" + IrParameter.AllocatedQuantity + "', " + IrParameter.IsFromEdit + " ";
                        var strSQL1 = "SELECT Status,ISNULL(AllocatedQuantity,0) As AllocatedQuantity From tbl_RM_InfraResourceRequests where InfraRequestId = " + itemReqId;
                        //var strStatus = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL1, true, CommonController.connectionString));
                        StrdrQuery = CommonFunctions.Data.GetDataReader(strSQL1, true, CommonController.connectionString);
                        if (StrdrQuery.Read())                        {

                            AllocatedQuantity = Convert.ToInt32(StrdrQuery["AllocatedQuantity"]);
                            strStatus = Convert.ToString(StrdrQuery["Status"]);
                            CommonFunctions.Data.DisposeDataReader(ref StrdrQuery);
                        }
                        var strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateStatus " + IrParameter.RoleID + ", '" + IrParameter.UserID + "' ,'" + itemReqId + "','" + IrParameter.InfraResourceId + "' , "
                       + IrParameter.Quantity + " ,NULL , NULL, '" 
                       //+ IrParameter.Status +
                       + strStatus +
                       "' ,'" + IrParameter.ModifiedBy + "' , NULL , '"
                       + IrParameter.RequestedBy + "' ,'" + IrParameter.Approvalby + "' , '" + IrParameter.Comments.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") + "', NULL ,'" + IrParameter.AllocatedBy + "' ,NULL,'" + IrParameter.RequestApprover + "' , '" 
                       //+ IrParameter.AllocatedQuantity 
                       + AllocatedQuantity
                       + "', " + IrParameter.IsFromEdit + " ";
                        //End of Commented And Added By Reshma Chavan on 14th Dec 2021 Getting Page Crash While entering Comment


                        if (AllocatedQuantity != 0)
                        {
                            strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        }
                        if (strResult == "Updated sucessfully.")
                        {
                            delete++;
                        }
                        else
                        {
                            notDelete++;
                        }

                        //string strSQL = "Exec usp_Whizible2_Del_tbl_BG_Manager '" + itemReqId + "'";
                        //var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        //if (srtResult != "Deleted")
                        //{
                        //    Result += srtResult;
                        //}
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




