using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Extensions;
using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{
    [Authorize]
    public class RM_ProjectInfraResourcesController : ApiController
    {
        /// <summary>
        /// Book resource 
        /// </summary>
        /// <param name="ProjinfraResource"></param>
        /// <returns></returns>
        ///  //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage AddOrUpdateInfraRequest([FromBody] RM_ProjIrRequest ProjinfraResource)// resource book
        {
           
            try
            {
                string strSQL;
                string strtResult;
                // we may need to check the date for that source and project: i.e already allocated for that date in sp
                if (ProjinfraResource != null)
                {
                    if(ProjinfraResource.IsUpdate=="Book")
                    {
                        strSQL = "Exec usp_Whizible2_InsUpd_tbl_RM_InfraResource_BookResource "
                            + ProjinfraResource.InfraRequestId + " ,'" + ProjinfraResource.InfraResourceId + "' ,'" + ProjinfraResource.ProjectId + "' ," + ProjinfraResource.Quantity + " ,'" + ProjinfraResource.StartDate + "' ,'" + ProjinfraResource.EndDate + "' ,NULL,NULL,'" + ProjinfraResource.Status + "' ,'" + ProjinfraResource.CreatedBy + "',NULL,NULL,NULL, '" + ProjinfraResource.RequestedBy + "'," + ProjinfraResource.RequestedUserId;

                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_InsUpd_tbl_RM_InfraResource_UpdateResource "
                            + ProjinfraResource.InfraRequestId + " ," + ProjinfraResource.Quantity + " ," + ProjinfraResource.AllocatedQuantity + " ,'" + ProjinfraResource.AllocatedDate + "', '" + ProjinfraResource.AlloctedBy + "' ,'" + ProjinfraResource.Comments + "', '" + ProjinfraResource.Approvalby + "','" + ProjinfraResource.@ApprovalDate+ "','"+ProjinfraResource.ModifiedBy+"'";

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
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
          
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetTotalQuantityForResourceId([FromBody] RM_ProjIrRequest ProjinfraResource)// resource book
        {
          
            try
            {
                string strSQL;
                int AvailableQuantity = 0;
                var IrRM_ProjIrResource = new List<RM_InfraResource>();
                if (ProjinfraResource != null && ProjinfraResource.InfraResourceId > 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceMasterByResourceId " + ProjinfraResource.InfraResourceId + " ";
                    //if (ProjinfraResource.StartDate != null && ProjinfraResource.StartDate != DateTime.MinValue && ProjinfraResource.EndDate != null && ProjinfraResource.EndDate != DateTime.MinValue)
                    //{
                    //    strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceMasterByResourceId " + ProjinfraResource.InfraResourceId + ", '" + ProjinfraResource.StartDate + "','" + ProjinfraResource.EndDate + "' ";
                    //}
                    //else
                    //{
                    //    strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceMasterByResourceId " + ProjinfraResource.InfraResourceId + ",NULL,NULL ";
                    //}

                    IDataReader drQuery;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    if (drQuery.Read())
                    {
                        if (drQuery["AvailableQuantity"] != null)
                        {
                            AvailableQuantity = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["AvailableQuantity"], "0"));
                        }
                    }
                    drQuery.Close();
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, AvailableQuantity);
            }
            catch (Exception ex)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
           
        }

        /// <summary>
        /// Get project details to check project start and end date :this method not required now  we have check the date in insert sp
        /// </summary>
        /// <param name="ProjinfraResource"></param>
        /// <returns></returns>
        [HttpPost]
        public HttpResponseMessage GetProjectDetailsByProjectId([FromBody] RM_ProjIrRequest ProjinfraResource)// resource book
        {
           
            try
            {
                string strSQL;
                RM_IrProjectStartEndDate ObjStartnEndDate = new RM_IrProjectStartEndDate();
                if (ProjinfraResource != null && ProjinfraResource.ProjectId > 0)
                {
                    strSQL = "Exec usp_Whizible2_Sel_tbl_Pm_ProjectByProjectId " + ProjinfraResource.ProjectId + " ";
                    IDataReader drQuery;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                    if (drQuery.Read())
                    {
                        if (drQuery["ProjectStartDate"] != null && drQuery["ProjectEndDate"] != null)
                        {
                            ObjStartnEndDate.ProjectStartDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drQuery["ProjectStartDate"], "0"));
                            ObjStartnEndDate.ProjectEndDate = Convert.ToDateTime(CommonFunctions.Data.CheckIsDBNull(drQuery["ProjectEndDate"], "0"));
                        }
                    }
                    drQuery.Close();
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return Request.CreateResponse(HttpStatusCode.OK, ObjStartnEndDate);
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
        public HttpResponseMessage GetDateCompanyDateFormat([FromBody] string UseID)
        {
          
            try
            {
                string strSQL;
                string InputDateFormat = string.Empty;
                var Dateformats = new InOutDateFormats();
                strSQL = "Exec usp_Whizible2_sel_tbl_PM_CompanyInformation_GetInOutDateFormats ";
                IDataReader drQuery;
                drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);

                if (drQuery.Read())
                {
                    if (drQuery["InputDateFormat"] != null &&  drQuery["OutDateFormat"] !=null)
                    {
                        Dateformats.InputDateFormat = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["InputDateFormat"], "mm/dd/yyyy"));
                        Dateformats.OutDateFormat = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["OutDateFormat"], "mm/dd/yyyy"));
                    }
                    else
                    {
                        Dateformats.InputDateFormat= "mm/dd/yyyy";
                        Dateformats.OutDateFormat= "mm/dd/yyyy";
                    }
                }
                drQuery.Close();
                return Request.CreateResponse(HttpStatusCode.OK, Dateformats);
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
        public HttpResponseMessage GetIrProjectAllocation([FromBody] RM_IrParmas ProjinfraResource)
        {
          
           
            try
            {
                var IrRequestAllocatedList = new List<RM_IrProjectAllocation>();
                List<string> columnNames = null;
                //DataTable IrProjectAllocationTable = new DataTable();
                if (ProjinfraResource.ProjectId > 0)
                {
                    string strSQL = string.Empty;
                    if (ProjinfraResource.CurrentDate==null || string.IsNullOrEmpty(ProjinfraResource.CurrentDate) )
                    {
                       strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequests_AllocatedView " + ProjinfraResource.ProjectId + " ";
                    }
                    else
                    {
                         strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequests_AllocatedView " + ProjinfraResource.ProjectId + ", '"+ ProjinfraResource.CurrentDate + "'  ";
                    }

                    //string strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequests_AllocatedView " + ProjinfraResource.ProjectId + ",'" + ProjinfraResource.CurrentMonth + "'";
                    DataTable  IrProjectAllocationTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    columnNames = IrProjectAllocationTable.Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                    
                    columnNames.RemoveRange(0, 8);
                    var LastMonthIndex = columnNames.IndexOf("ResourceId_2") ;
                    var LastIndex = LastMonthIndex + 1;
                    columnNames.RemoveRange(LastMonthIndex, LastIndex);
                    if (IrProjectAllocationTable.Rows.Count > 0 && IrProjectAllocationTable!=null)
                    {
                        foreach (DataRow itemttotalstrength in IrProjectAllocationTable.Rows)
                        {
                            IrRequestAllocatedList.Add(GetIrProjectAllocationObject(itemttotalstrength, columnNames));
                        }
                    }
                    else
                    {
                        return this.Request.CreateResponse(HttpStatusCode.OK, new { IrProjectAllocationList = IrRequestAllocatedList, IrDayListHeader = columnNames });
                    }

                }
                //IrProjectAllocationTable.Dispose();
                return this.Request.CreateResponse(HttpStatusCode.OK, new { IrProjectAllocationList = IrRequestAllocatedList, IrDayListHeader = columnNames });
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
        public HttpResponseMessage UpdateResourceInfraResource([FromBody] RM_InfraRequestUpdateResource ProjinfraResource)// resource book
        {
            
            try
            {
                string strSQL;
                string strtResult;
                if (ProjinfraResource != null)
                {
                    if (ProjinfraResource.IsFromEdit)  /// to check relese or allocation chnages
                    {
                        strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateResource "
                             + ProjinfraResource.RoleID + " ,'" + ProjinfraResource.UserID + "','" + ProjinfraResource.ProjectId + "' ,'" + ProjinfraResource.InfraResourceId + "',"+ ProjinfraResource.InfraRequestId + ", NULL,NULL,'" + ProjinfraResource.Status + "' ,'" + ProjinfraResource.Comments + "','" + ProjinfraResource.ModifiedBy + "','" + ProjinfraResource.IsFromEdit + "'";
                    }
                    else
                    {
                        //change alloaction  ie add new request with extended date 
                        //ProjinfraResource.InfraRequestId = 0;
                        //ProjinfraResource.StartDate = ProjinfraResource.EndDate).AddDays(1);
                        strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateResource "
                         + ProjinfraResource.RoleID + " ,'" + ProjinfraResource.UserID + "' ,'" + ProjinfraResource.ProjectId + "' ," + ProjinfraResource.InfraResourceId + " , " + ProjinfraResource.InfraRequestId + " ,'" + ProjinfraResource.StartDate + "' ,'" + ProjinfraResource.EndDate + "' ,NULL,'" + ProjinfraResource.Comments + "' ,'" + ProjinfraResource.ModifiedBy + "','" + ProjinfraResource.IsFromEdit + "' ";
                        //strSQL = "Exec usp_Whizible2_Upd_tbl_RM_InfraResourceRequests_UpdateResource "
                        //     + ProjinfraResource.RoleID + " ,'" + ProjinfraResource.UserID + "','" + ProjinfraResource.ProjectId + "','" + ProjinfraResource.InfraResourceId + "' ,NULL,NULL,'" + ProjinfraResource.Status + "' ,'" + ProjinfraResource.Comments + "','" + ProjinfraResource.ModifiedBy + "','" + ProjinfraResource.IsFromEdit + "'";
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
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
           
        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetResourcesByResourceId(RM_ProjIrRequest ProjinfraResource)
        {
          
            try
            {
                var IrResourcesList = new List<RM_InfraRequestUpdateStatus_N>();
                if (ProjinfraResource.ProjectId>0 && ProjinfraResource.InfraResourceId>0)
                {
                    string strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequestsByResourceId '" + ProjinfraResource.InfraResourceId + "','" + ProjinfraResource.ProjectId + "'";
                    //var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequestsByResourceId '" + ProjinfraResource.InfraResourceId + "','" + ProjinfraResource.ProjectId + "'";
                    DataTable IrresourceDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    if (IrresourceDataTable != null && IrresourceDataTable.Rows.Count > 0)
                    {
                        IrResourcesList = IrresourceDataTable.ToList<RM_InfraRequestUpdateStatus_N>();
                    }
                }
                return Request.CreateResponse(HttpStatusCode.OK, IrResourcesList);
            }
            catch (Exception ex)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
          
        }

        private RM_IrProjectAllocation GetIrProjectAllocationObject(DataRow TblRows, List<string> DayNames)
        {

            var TotalColumns = DayNames.Count();
            var IrProjectAllocation = new RM_IrProjectAllocation();
            string ClBooked = "PRpercentage LabelBooked";
            string ClPartialBooked = "PRpercentage Labelorange";
            string ClNotBooked = "PRpercentage";
            string ClSatSun = "PRpercentage LabelForSat";
            var DayTxtForSat = "Sat";
            var DayTxtForSun = "Sun";
            IrProjectAllocation.InfraResourceId = Convert.ToInt16(TblRows["ResourceId"]);  
            IrProjectAllocation.ResourceName = Convert.ToString(TblRows["ResourceName"]);
            IrProjectAllocation.MaxAllocationPerDay = Convert.ToInt16(TblRows["MaxAllocationPerDay"]);
            var MxAllocationDay = IrProjectAllocation.MaxAllocationPerDay;
            IrProjectAllocation.TotalQuantityForMonth = Convert.ToInt16(TblRows["TotalQuantityForMonth"]);
            IrProjectAllocation.TotalAllocatedQuantityForProject = Convert.ToInt16(CommonFunctions.Data.CheckIsDBNull(TblRows["TotalAllocatedQuantityForProject"], "0"));
            IrProjectAllocation.TotalAllocatedQuantityForallProject = Convert.ToInt16(CommonFunctions.Data.CheckIsDBNull(TblRows["TotalAllocatedQuantityForallProject"], "0"));
            int AvailableCount = IrProjectAllocation.TotalQuantityForMonth - IrProjectAllocation.TotalAllocatedQuantityForallProject ;
            IrProjectAllocation.AvailableCount =AvailableCount > 0 ?AvailableCount: 0;
            IrProjectAllocation.MonthName = Convert.ToString(TblRows["MonthName"]);
            IrProjectAllocation.MontDate = Convert.ToDateTime(TblRows["MonthDate"]);

            IrProjectAllocation.Day_1 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            var Day_1 = DayNames[0].Split('_')[0];
            IrProjectAllocation.GDay_1 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_1"], "0"));
            IrProjectAllocation.ClDay_1 = (IrProjectAllocation.Day_1 > 0 && IrProjectAllocation.GDay_1 < MxAllocationDay) ?  ClPartialBooked : IrProjectAllocation.GDay_1 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_2 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));

            var Day_2 = DayNames[1].Split('_')[0];
            IrProjectAllocation.GDay_2 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_2"], "0"));
            IrProjectAllocation.ClDay_2 = IrProjectAllocation.Day_2 > 0 && IrProjectAllocation.GDay_2 < MxAllocationDay ?  ClPartialBooked : IrProjectAllocation.GDay_2 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_3 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));

            var Day_3 = DayNames[2].Split('_')[0];
            IrProjectAllocation.GDay_3 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_3"], "0"));
            IrProjectAllocation.ClDay_3 = IrProjectAllocation.Day_3 > 0 && IrProjectAllocation.GDay_3 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_3 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_4 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));

            var Day_4 = DayNames[3].Split('_')[0];
            IrProjectAllocation.GDay_4 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_4"], "0"));
            IrProjectAllocation.ClDay_4 = IrProjectAllocation.Day_4 > 0 && IrProjectAllocation.GDay_4 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_4 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_5 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));

            var Day_5 = DayNames[4].Split('_')[0];
            IrProjectAllocation.GDay_5 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_5"], "0"));
            IrProjectAllocation.ClDay_5 = IrProjectAllocation.Day_5 > 0 && IrProjectAllocation.GDay_5 <MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_5 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_6 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));

            var Day_6 = DayNames[5].Split('_')[0];
            IrProjectAllocation.GDay_6 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_6"], "0"));
            IrProjectAllocation.ClDay_6 = IrProjectAllocation.Day_6 > 0 && IrProjectAllocation.GDay_6 <MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_6 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_7 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));

            var Day_7 = DayNames[6].Split('_')[0];
            IrProjectAllocation.GDay_7 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_7"], "0"));
            IrProjectAllocation.ClDay_7 = IrProjectAllocation.Day_7 > 0 && IrProjectAllocation.GDay_7 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_7 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_8 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));

            var Day_8 = DayNames[7].Split('_')[0];
            IrProjectAllocation.GDay_8 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_8"], "0"));
            IrProjectAllocation.ClDay_8 = IrProjectAllocation.Day_8 > 0 && IrProjectAllocation.GDay_8 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_8 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_9 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));

            var Day_9 = DayNames[8].Split('_')[0];
            IrProjectAllocation.GDay_9 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_9"], "0"));
            IrProjectAllocation.ClDay_9 = IrProjectAllocation.Day_9 > 0 && IrProjectAllocation.GDay_9 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_9 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_10 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));

            var Day_10 = DayNames[9].Split('_')[0];
            IrProjectAllocation.GDay_10 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_10"], "0"));
            IrProjectAllocation.ClDay_10 = IrProjectAllocation.Day_10 > 0 && IrProjectAllocation.GDay_10< MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_10 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_11 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "0"));

            var Day_11 = DayNames[10].Split('_')[0];
            IrProjectAllocation.GDay_11 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_11"], "0"));
            IrProjectAllocation.ClDay_11 = IrProjectAllocation.Day_11 > 0 && IrProjectAllocation.GDay_11 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_11 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_12 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[19], "0"));

            var Day_12 = DayNames[11].Split('_')[0];
            IrProjectAllocation.GDay_12 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_12"], "0"));
            IrProjectAllocation.ClDay_12 = IrProjectAllocation.Day_12 > 0 && IrProjectAllocation.GDay_12 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_12 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_13 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[20], "0"));

            var Day_13 = DayNames[12].Split('_')[0];
            IrProjectAllocation.GDay_13 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_13"], "0"));
            IrProjectAllocation.ClDay_13 = IrProjectAllocation.Day_13 > 0 && IrProjectAllocation.GDay_13 <= MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_13 >= MxAllocationDay ? ClBooked : ClNotBooked; 
            IrProjectAllocation.Day_14 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[21], "0"));

            var Day_14 = DayNames[13].Split('_')[0];
            IrProjectAllocation.GDay_14 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_14"], "0"));
            IrProjectAllocation.ClDay_14 = IrProjectAllocation.Day_14 > 0 && IrProjectAllocation.GDay_14 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_14 >= MxAllocationDay ? ClBooked : ClNotBooked; 
            IrProjectAllocation.Day_15= Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[22], "0"));

            var Day_15 = DayNames[14].Split('_')[0];
            IrProjectAllocation.GDay_15 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_15"], "0"));
            IrProjectAllocation.ClDay_15 = IrProjectAllocation.Day_15 > 0 && IrProjectAllocation.GDay_15 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_15 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_16 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[23], "0"));

            var Day_16 = DayNames[15].Split('_')[0];
            IrProjectAllocation.GDay_16 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_16"], "0"));
            IrProjectAllocation.ClDay_16 = IrProjectAllocation.Day_16 > 0 && IrProjectAllocation.Day_16 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_16 >= MxAllocationDay ? ClBooked : ClNotBooked; 
            IrProjectAllocation.Day_17 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[24], "0"));

            var Day_17 = DayNames[16].Split('_')[0];
            IrProjectAllocation.GDay_17 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_17"], "0"));
            IrProjectAllocation.ClDay_17 = IrProjectAllocation.Day_17 > 0 && IrProjectAllocation.Day_17 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_17 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_18 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[25], "0"));

            var Day_18 = DayNames[17].Split('_')[0];
            IrProjectAllocation.GDay_18 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_18"], "0"));
            IrProjectAllocation.ClDay_18 = IrProjectAllocation.Day_18 > 0 && IrProjectAllocation.Day_18 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_18 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_19 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[26], "0"));

            var Day_19 = DayNames[18].Split('_')[0];
            IrProjectAllocation.GDay_19 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_19"], "0"));
            IrProjectAllocation.ClDay_19 = IrProjectAllocation.Day_19 > 0 && IrProjectAllocation.Day_19 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_19 >= MxAllocationDay ? ClBooked : ClNotBooked; ;
            IrProjectAllocation.Day_20 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[27], "0"));

            var Day_20 = DayNames[19].Split('_')[0];
            IrProjectAllocation.GDay_20 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_20"], "0"));
            IrProjectAllocation.ClDay_20 = IrProjectAllocation.Day_20 > 0 && IrProjectAllocation.GDay_20 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_20 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_21 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[28], "0"));

            var Day_21 = DayNames[20].Split('_')[0];
            IrProjectAllocation.GDay_21 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_21"], "0"));
            IrProjectAllocation.ClDay_21 = IrProjectAllocation.Day_21 > 0 && IrProjectAllocation.Day_21 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_21 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_22 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[29], "0"));

            var Day_22 = DayNames[21].Split('_')[0];
            IrProjectAllocation.GDay_22 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_22"], "0"));
            IrProjectAllocation.ClDay_22 = IrProjectAllocation.Day_22 > 0 && IrProjectAllocation.Day_22 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_21 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_23 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[30], "0"));

            var Day_23 = DayNames[22].Split('_')[0];
            IrProjectAllocation.GDay_23 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_22"], "0"));
            IrProjectAllocation.ClDay_23 = IrProjectAllocation.Day_23 > 0 && IrProjectAllocation.GDay_23 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_23 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_24 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[31], "0"));

            var Day_24 = DayNames[23].Split('_')[0];
            IrProjectAllocation.GDay_24 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_24"], "0"));
            IrProjectAllocation.ClDay_24 = IrProjectAllocation.Day_24 > 0 && IrProjectAllocation.GDay_24 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_24 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_25 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[32], "0"));

            var Day_25 = DayNames[24].Split('_')[0];
            IrProjectAllocation.GDay_25 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_25"], "0"));
            IrProjectAllocation.ClDay_25 = IrProjectAllocation.Day_25 > 0 && IrProjectAllocation.GDay_25 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_25 >= MxAllocationDay  ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_26 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[33], "0"));

            var Day_26 = DayNames[25].Split('_')[0];
            IrProjectAllocation.GDay_26 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_26"], "0"));
            IrProjectAllocation.ClDay_26 = IrProjectAllocation.Day_26 > 0 && IrProjectAllocation.GDay_26 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_26 >= MxAllocationDay ? ClBooked : ClNotBooked;
            IrProjectAllocation.Day_27 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[34], "0"));

            var Day_27 = DayNames[26].Split('_')[0];
            IrProjectAllocation.GDay_27 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_27"], "0"));
            IrProjectAllocation.ClDay_27 = IrProjectAllocation.Day_27 > 0 && IrProjectAllocation.GDay_27 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_27 >= MxAllocationDay ? ClBooked : ClNotBooked;

            if (TblRows != null && TotalColumns > 27)
            {
                IrProjectAllocation.Day_28 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[35], "0"));
                var Day_28 = DayNames != null && DayNames.Count > 27 ? DayNames[27].Split('_')[0] : "0";
                IrProjectAllocation.GDay_28 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_28"], "0"));
                IrProjectAllocation.ClDay_28 = IrProjectAllocation.Day_28 > 0 && IrProjectAllocation.GDay_28 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_28 >= MxAllocationDay ? ClBooked : ClNotBooked; ;

            }

            if (TblRows != null && TotalColumns > 28)
            {

                IrProjectAllocation.Day_29 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[36], " "));
                var Day_29 = DayNames != null && DayNames.Count > 28 ? DayNames[28].Split('_')[0] : "0";
                IrProjectAllocation.GDay_29 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_29"], "0"));
                IrProjectAllocation.ClDay_29 = IrProjectAllocation.Day_29 > 0 && IrProjectAllocation.GDay_29 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_29 >= MxAllocationDay ? ClBooked : ClNotBooked;
            }

            if (TblRows != null && TotalColumns > 29)
            {
                
                IrProjectAllocation.Day_30 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[37], ""));
                var Day_30 = DayNames != null && DayNames.Count > 29 ? DayNames[29].Split('_')[0] : "";
                IrProjectAllocation.GDay_30 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_30"], "0"));
                IrProjectAllocation.ClDay_30 = IrProjectAllocation.Day_30 > 0 && IrProjectAllocation.GDay_30 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_30 >= MxAllocationDay ? ClBooked : ClNotBooked;

            }

            if (TblRows!=null && TotalColumns>30)
            {
                IrProjectAllocation.Day_31 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[38], "0"));
                var Day_31 = DayNames != null && DayNames.Count > 30 ? DayNames[30].Split('_')[0] : " ";
                IrProjectAllocation.GDay_31 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows["G_31"], "0"));
                IrProjectAllocation.ClDay_31 = IrProjectAllocation.Day_31 > 0 && IrProjectAllocation.GDay_31 < MxAllocationDay ? ClPartialBooked : IrProjectAllocation.GDay_31 >= MxAllocationDay ? ClBooked : ClNotBooked;

            }

            return IrProjectAllocation;
        }



        #region Available 

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetIrResourceAvailablity([FromBody] RM_IrParmas ProjinfraResource)
        {
           
            try
            {
                var IrRequestAvailableList = new List<RM_IrProjectAllocation>();
                List<string> columnNames = null;
                string strSQL = string.Empty;
                    if (ProjinfraResource.CurrentDate == null || string.IsNullOrEmpty(ProjinfraResource.CurrentDate))
                    {
                        strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequests_AvailableView  NULL";
                    }
                    else
                    {
                        strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequests_AvailableView '" + ProjinfraResource.CurrentDate + "'  ";
                    }

                    //string strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceRequests_AllocatedView " + ProjinfraResource.ProjectId + ",'" + ProjinfraResource.CurrentMonth + "'";
                    DataTable IrAvailbleTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    columnNames = IrAvailbleTable.Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                    columnNames.RemoveRange(0, 8);
                    if (IrAvailbleTable.Rows.Count > 0 && IrAvailbleTable != null)
                    {
                        foreach (DataRow itemttotalstrength in IrAvailbleTable.Rows)
                        {
                            IrRequestAvailableList.Add(GetIrAvailableObject(itemttotalstrength, columnNames));
                        }
                    }
                    else
                    {
                        return this.Request.CreateResponse(HttpStatusCode.OK, new { IrProjectAvailableList = IrRequestAvailableList, IrAvailableDayListHeader = columnNames });
                    }
                return this.Request.CreateResponse(HttpStatusCode.OK, new { IrAvailableList = IrRequestAvailableList, IrAvailableDayListHeader = columnNames });
            }
            catch (Exception ex)
            {
               return Request.CreateErrorResponse(HttpStatusCode.InternalServerError,"Bad Request found");
            }
            
        }

        private RM_IrAvailability GetIrAvailableObject(DataRow TblRows, List<string> DayNames)
        {
            int TotalColumns = DayNames.Count();
            var IrAvailability = new RM_IrAvailability();
            string ClBooked = "PRpercentage LabelBooked";
            string ClPartialBooked = "PRpercentage Labelorange";
            string ClNotBooked = "PRpercentage";
            string ClSatSun = "PRpercentage LabelForSat";
            var DayTxtForSat = "Sat";
            var DayTxtForSun = "Sun";
            IrAvailability.InfraResourceId = Convert.ToInt16(TblRows["ResourceId"]);
            IrAvailability.ResourceName = Convert.ToString(TblRows["ResourceName"]);
            IrAvailability.MaxAllocationPerDay = Convert.ToInt16(TblRows["MaxAllocationPerDay"]);
            var MxAllocationDay = IrAvailability.MaxAllocationPerDay;
            IrAvailability.TotalQuantityForMonth = Convert.ToInt16(TblRows["TotalQuantityForMonth"]);
            IrAvailability.TotalAllocatedQuantityForProject = Convert.ToInt16(CommonFunctions.Data.CheckIsDBNull(TblRows["TotalAllocatedQuantityForProject"], "0"));
            IrAvailability.TotalAllocatedQuantityForallProject = Convert.ToInt16(CommonFunctions.Data.CheckIsDBNull(TblRows["TotalAllocatedQuantityForallProject"], "0"));
            int AvailableCount = IrAvailability.TotalQuantityForMonth - IrAvailability.TotalAllocatedQuantityForallProject;
            IrAvailability.AvailableCount = AvailableCount > 0 ? AvailableCount : 0;
            IrAvailability.MonthName = Convert.ToString(TblRows["MonthName"]);
            IrAvailability.MontDate = Convert.ToDateTime(TblRows["MonthDate"]);
            IrAvailability.Day_1 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[8], "0"));
            var Day_1 = DayNames[0].Split('_')[0];
            IrAvailability.ClDay_1 = (IrAvailability.Day_1 <=0) ? ClBooked : (Day_1 == DayTxtForSat || Day_1 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_2 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[9], "0"));
            var Day_2 = DayNames[1].Split('_')[0];
            IrAvailability.ClDay_2 = IrAvailability.Day_2 <=0 ? ClBooked : (Day_2 == DayTxtForSat || Day_2 == DayTxtForSun) ? ClNotBooked : ClNotBooked; ;
            IrAvailability.Day_3 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[10], "0"));
            var Day_3 = DayNames[2].Split('_')[0];
            IrAvailability.ClDay_3 = IrAvailability.Day_3 <= 0 ? ClBooked : (Day_3 == DayTxtForSat || Day_3 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_4 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[11], "0"));
            var Day_4 = DayNames[3].Split('_')[0];
            IrAvailability.ClDay_4 = IrAvailability.Day_4 <= 0 ? ClBooked : (Day_1 == DayTxtForSat || Day_1 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_5 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[12], "0"));
            var Day_5 = DayNames[4].Split('_')[0];
            IrAvailability.ClDay_5 = IrAvailability.Day_5 <= 0 ? ClBooked : (Day_5 == DayTxtForSat || Day_5 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_6 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[13], "0"));
            var Day_6 = DayNames[5].Split('_')[0];
            IrAvailability.ClDay_6 = IrAvailability.Day_6 <= 0  ? ClBooked : (Day_6 == DayTxtForSat || Day_6 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_7 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[14], "0"));
            var Day_7 = DayNames[6].Split('_')[0];
            IrAvailability.ClDay_7 = IrAvailability.Day_7 <= 0 ? ClBooked : (Day_7 == DayTxtForSat || Day_7 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_8 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[15], "0"));
            var Day_8 = DayNames[7].Split('_')[0];
            IrAvailability.ClDay_8 = IrAvailability.Day_8 <= 0 ? ClBooked : (Day_8 == DayTxtForSat || Day_8 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_9 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[16], "0"));
            var Day_9 = DayNames[8].Split('_')[0];
            IrAvailability.ClDay_9 = IrAvailability.Day_9 <= 0 ? ClBooked : (Day_9 == DayTxtForSat || Day_9 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_10 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[17], "0"));
            var Day_10 = DayNames[9].Split('_')[0];
            IrAvailability.ClDay_10 = IrAvailability.Day_10 <= 0 ? ClBooked : (Day_10 == DayTxtForSat || Day_10 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_11 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[18], "0"));
            var Day_11 = DayNames[10].Split('_')[0];
            IrAvailability.ClDay_11 = IrAvailability.Day_11 <= 0 ? ClBooked : (Day_11 == DayTxtForSat || Day_11 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_12 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[19], "0"));
            var Day_12 = DayNames[11].Split('_')[0];
            IrAvailability.ClDay_12 = IrAvailability.Day_12 <= 0 ? ClBooked : (Day_12 == DayTxtForSat || Day_12 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_13 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[20], "0"));
            var Day_13 = DayNames[12].Split('_')[0];
            IrAvailability.ClDay_13 = IrAvailability.Day_13 <= 0 ? ClBooked : (Day_13 == DayTxtForSat || Day_13 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_14 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[21], "0"));
            var Day_14 = DayNames[13].Split('_')[0];
            IrAvailability.ClDay_14 = IrAvailability.Day_14 <= 0 ? ClBooked : (Day_14 == DayTxtForSat || Day_14 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_15 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[22], "0"));
            var Day_15 = DayNames[14].Split('_')[0];
            IrAvailability.ClDay_15 = IrAvailability.Day_15 <= 0 ? ClBooked : (Day_15 == DayTxtForSat || Day_15 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_16 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[23], "0"));
            var Day_16 = DayNames[15].Split('_')[0];
            IrAvailability.ClDay_16 = IrAvailability.Day_16 <= 0 ? ClBooked : (Day_16 == DayTxtForSat || Day_16 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_17 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[24], "0"));
            var Day_17 = DayNames[16].Split('_')[0];
            IrAvailability.ClDay_17 = IrAvailability.Day_17 <= 0 ? ClBooked : (Day_17 == DayTxtForSat || Day_17 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_18 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[25], "0"));
            var Day_18 = DayNames[17].Split('_')[0];
            IrAvailability.ClDay_18 = IrAvailability.Day_18 <= 0 ? ClBooked : (Day_18 == DayTxtForSat || Day_18 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_19 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[26], "0"));
            var Day_19 = DayNames[18].Split('_')[0];
            IrAvailability.ClDay_19 = IrAvailability.Day_19 <= 0 ? ClBooked : (Day_19 == DayTxtForSat || Day_19 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_20 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[27], "0"));
            var Day_20 = DayNames[19].Split('_')[0];
            IrAvailability.ClDay_20 = IrAvailability.Day_20 <= 0 ? ClBooked : (Day_20 == DayTxtForSat || Day_20 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_21 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[28], "0"));
            var Day_21 = DayNames[20].Split('_')[0];
            IrAvailability.ClDay_21 = IrAvailability.Day_21 <=0 ? ClBooked : (Day_21 == DayTxtForSat || Day_21 == DayTxtForSun) ? ClNotBooked : ClNotBooked; ;
            IrAvailability.Day_22 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[29], "0"));
            var Day_22 = DayNames[21].Split('_')[0];
            IrAvailability.ClDay_22 = IrAvailability.Day_22 <= 0 ? ClBooked : (Day_22 == DayTxtForSat || Day_22 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_23 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[30], "0"));
            var Day_23 = DayNames[22].Split('_')[0];
            IrAvailability.ClDay_23 = IrAvailability.Day_23 <= 0 ? ClBooked : (Day_23 == DayTxtForSat || Day_23 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_24 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[31], "0"));
            var Day_24 = DayNames[23].Split('_')[0];
            IrAvailability.ClDay_24 = IrAvailability.Day_24 <=0 ? ClBooked : (Day_24 == DayTxtForSat || Day_24 == DayTxtForSun) ? ClNotBooked : ClNotBooked; ;
            IrAvailability.Day_25 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[32], "0"));
            var Day_25 = DayNames[24].Split('_')[0];
            IrAvailability.ClDay_25 = IrAvailability.Day_25 <= 0 ? ClBooked : (Day_25 == DayTxtForSat || Day_25 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_26 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[33], "0"));
            var Day_26 = DayNames[25].Split('_')[0];
            IrAvailability.ClDay_26 = IrAvailability.Day_26 <= 0 ? ClBooked : (Day_26 == DayTxtForSat || Day_26 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            IrAvailability.Day_27 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[34], "0"));
            var Day_27 = DayNames[26].Split('_')[0];
            IrAvailability.ClDay_27 = IrAvailability.Day_27 <= 0 ? ClBooked : (Day_27 == DayTxtForSat || Day_27 == DayTxtForSun) ? ClNotBooked : ClNotBooked;

            if (TblRows != null && TotalColumns > 27)
            {
                IrAvailability.Day_28 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[35], "0"));
                var Day_28 = DayNames != null && DayNames.Count > 27 ? DayNames[27].Split('_')[0] : "0";
                IrAvailability.ClDay_28 = IrAvailability.Day_28 <= 0 ? ClBooked : (Day_28 == DayTxtForSat || Day_28 == DayTxtForSun) ? ClNotBooked : ClNotBooked;

            }
            if (TblRows != null  && TotalColumns> 28)
            {
                IrAvailability.Day_29 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[36], " "));
                var Day_29 = DayNames != null && DayNames.Count > 28 ? DayNames[28].Split('_')[0] : "0";
                IrAvailability.ClDay_29 = IrAvailability.Day_29 <= 0 ? ClBooked : (Day_29 == DayTxtForSat || Day_29 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            }

            if (TblRows != null && TotalColumns > 29)
            {
                IrAvailability.Day_30 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[37], ""));
                var Day_30 = DayNames != null && DayNames.Count > 29 ? DayNames[29].Split('_')[0] : "";
                IrAvailability.ClDay_30 = IrAvailability.Day_30 <= 0 ? ClBooked : (Day_30 == DayTxtForSat || Day_30 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            }
            if (TblRows!=null  && TotalColumns > 30)
            {
                IrAvailability.Day_31 = Convert.ToInt64(CommonFunctions.Data.CheckIsDBNull(TblRows[38], "0"));
                var Day_31 = DayNames != null && DayNames.Count > 30 ? DayNames[30].Split('_')[0] : " ";
                IrAvailability.ClDay_31 = IrAvailability.Day_31 <= 0 ? ClBooked : (Day_31 == DayTxtForSat || Day_31 == DayTxtForSun) ? ClNotBooked : ClNotBooked;
            }

            return IrAvailability;
        }
        #endregion




        public DateTime NextMonth(DateTime date)
        {
            if (date.Day != DateTime.DaysInMonth(date.Year, date.Month))
                return date.AddMonths(1);
            else
                return date.AddDays(1).AddMonths(1).AddDays(-1);
        }

    }
   
}


