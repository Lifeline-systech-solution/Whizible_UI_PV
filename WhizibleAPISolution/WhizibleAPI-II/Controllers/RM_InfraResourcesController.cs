using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
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
    public class RM_InfraResourcesController : ApiController
    {

        //Added by imran on 19-08-2022 
        [Authorize, App_Start.ValidateHeaders]  
        //End of comment by imran on 19-08-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage AddOrUpdate([FromBody] RM_InfraResourceRequest infraResource)
        {
           
            try
            {
                IR_Activestatus IR_status = new IR_Activestatus();
                string strSQL;
                string strtResult;
                if (infraResource != null)
                {
                    string activeStatus = GetInactiveActiveStautsforInfra(infraResource);
                    IR_status.Status = activeStatus;
                    if (activeStatus == "Active")
                    {
                        if(infraResource.AvaliableTill == "" && infraResource.RetiredOn != "")
                        {
                            strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraResource "
                                    + infraResource.InfraResourceId +
                                    " ,'" + infraResource.InfraName + "' ,'" + infraResource.Description + "' ," + infraResource.InfraTypeId + " ," + infraResource.InfraGroupId + " ," + infraResource.BusinessGroupID + " ," + infraResource.LocationID + " ," + infraResource.MaxAllocationPerDay + " ," + infraResource.TotalQuantity + " ," + infraResource.CostPerHour + " ," + infraResource.RatePerHour + " ," + infraResource.TotalCostOfAcquisition + " ," + infraResource.DepreciationRate + " ,'" + infraResource.AvaliableFrom + "' , NULL ,'" + infraResource.RetiredOn + "' ,'" + infraResource.Shared + "' ," + infraResource.InfraStatusId + "," + infraResource.IsActive + " ,'" + infraResource.CreatedBy + "'";
                        }
                        else if (infraResource.RetiredOn == "" && infraResource.AvaliableTill != "")
                        {
                            strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraResource "
                                   + infraResource.InfraResourceId +
                                   " ,'" + infraResource.InfraName + "' ,'" + infraResource.Description + "' ," + infraResource.InfraTypeId + " ," + infraResource.InfraGroupId + " ," + infraResource.BusinessGroupID + " ," + infraResource.LocationID + " ," + infraResource.MaxAllocationPerDay + " ," + infraResource.TotalQuantity + " ," + infraResource.CostPerHour + " ," + infraResource.RatePerHour + " ," + infraResource.TotalCostOfAcquisition + " ," + infraResource.DepreciationRate + " ,'" + infraResource.AvaliableFrom + "' ,'" + infraResource.AvaliableTill + "' ,  NULL  ,'" + infraResource.Shared + "' ," + infraResource.InfraStatusId + "," + infraResource.IsActive + " ,'" + infraResource.CreatedBy + "'";

                        }
                        else if (infraResource.RetiredOn == "" && infraResource.AvaliableTill == "")
                        {
                            strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraResource "
                                   + infraResource.InfraResourceId +
                                   " ,'" + infraResource.InfraName + "' ,'" + infraResource.Description + "' ," + infraResource.InfraTypeId + " ," + infraResource.InfraGroupId + " ," + infraResource.BusinessGroupID + " ," + infraResource.LocationID + " ," + infraResource.MaxAllocationPerDay + " ," + infraResource.TotalQuantity + " ," + infraResource.CostPerHour + " ," + infraResource.RatePerHour + " ," + infraResource.TotalCostOfAcquisition + " ," + infraResource.DepreciationRate + " ,'" + infraResource.AvaliableFrom + "' , NULL ,  NULL  ,'" + infraResource.Shared + "' ," + infraResource.InfraStatusId + "," + infraResource.IsActive + " ,'" + infraResource.CreatedBy + "'";

                        }
                        else
                        {
                            strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraResource "
                                    + infraResource.InfraResourceId +
                                    " ,'" + infraResource.InfraName + "' ,'" + infraResource.Description + "' ," + infraResource.InfraTypeId + " ," + infraResource.InfraGroupId + " ," + infraResource.BusinessGroupID + " ," + infraResource.LocationID + " ," + infraResource.MaxAllocationPerDay + " ," + infraResource.TotalQuantity + " ," + infraResource.CostPerHour + " ," + infraResource.RatePerHour + " ," + infraResource.TotalCostOfAcquisition + " ," + infraResource.DepreciationRate + " ,'" + infraResource.AvaliableFrom + "' ,'" + infraResource.AvaliableTill + "' ,'" + infraResource.RetiredOn + "' ,'" + infraResource.Shared + "' ," + infraResource.InfraStatusId + "," + infraResource.IsActive + " ,'" + infraResource.CreatedBy + "'";
                        }
                        IDataReader drQuery;
                        drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                        if (drQuery.Read())
                        {
                            //objOPR.ApproxStartDate = String.Format("{0:dd MMMM yyyy}", drQuery["ApproxStartDate"]);
                            IR_status.InfraResourceId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraResourceId"], "0"));
                            IR_status.Message = Convert.ToString(drQuery["Message"]);
                        }
                        //int Result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                        //IR_status.InfraResourceId = Result;
                        
                        return Request.CreateResponse(HttpStatusCode.OK, IR_status);
                        
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, IR_status);
                    }
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        ////Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        [HttpPost]
        public HttpResponseMessage GetAll([FromBody] InfraFilterParameter infraFilterParameter)
        {
            
            try
            {
                var infraResourcesList = new List<RM_InfraResourceVM>();
                string filterParms = "";
                if (infraFilterParameter != null && infraFilterParameter.WhereClause != null && !string.IsNullOrEmpty(infraFilterParameter.WhereClause))
                {
                    filterParms = HttpUtility.UrlDecode(infraFilterParameter.WhereClause).Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n");

                }
                var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResources '" + filterParms + "'";
                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in infraDataTable.Rows)
                {
                    RM_InfraResourceVM empskill = new RM_InfraResourceVM()
                    {
                        InfraResourceId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["InfraResourceId"], "0")),
                        InfraName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["InfraName"], "")),
                        BusinessGroup = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["BusinessGroup"], "")),
                        AvaliableFrom = String.Format("{0:dd MMMM yyyy}", taskStatusRow["AvaliableFrom"]),
                        AvaliableTill = String.Format("{0:dd MMMM yyyy}", taskStatusRow["AvaliableTill"]),
                        InfraTypeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["InfraTypeName"], "")),
                        InfraGroupName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["InfraGroupName"], "")),
                        InfraStatus = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["InfraStatus"], "")),
                    };
                    infraResourcesList.Add(empskill);
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraResourcesList);
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
        public HttpResponseMessage GetById([FromBody] string resourceId)
        {
           
            try
            {
                var infraResource = new RM_InfraResource();
                var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourceById '" + resourceId + "'";
                IDataReader drQuery;
                drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drQuery.Read())
                {
                    infraResource.InfraResourceId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraResourceId"], "0"));
                    infraResource.InfraName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraName"], ""));
                    infraResource.Description = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(drQuery["Description"], ""));
                    infraResource.IsActive = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(drQuery["IsActive"], ""));
                    infraResource.BusinessGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["BusinessGroupID"], "0"));
                    infraResource.LocationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["LocationID"], "0"));
                    infraResource.AvaliableFrom = String.Format("{0:dd MMMM yyyy}", drQuery["AvaliableFrom"]);
                    infraResource.AvaliableTill = String.Format("{0:dd MMMM yyyy}", drQuery["AvaliableTill"]);
                    infraResource.InfraTypeId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraTypeId"], ""));
                    infraResource.InfraGroupId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraGroupId"], ""));
                    infraResource.InfraStatusId = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraStatusId"], ""));
                    infraResource.MaxAllocationPerDay = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["MaxAllocationPerDay"], ""));
                    infraResource.CostPerHour = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["CostPerHour"], ""));
                    infraResource.RatePerHour = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["RatePerHour"], ""));
                    infraResource.TotalCostOfAcquisition = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["TotalCostOfAcquisition"], ""));
                    infraResource.DepreciationRate = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["DepreciationRate"], ""));
                    infraResource.RetiredOn = String.Format("{0:dd MMMM yyyy}", drQuery["RetiredOn"]);
                    infraResource.TotalQuantity = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(drQuery["TotalQuantity"], ""));
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraResource);
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
        public HttpResponseMessage GetRenewals([FromBody] string resourceId)
        {
           
            try
            {
                var infraResourceRenewal = new List<RM_InfraRenewalVM>();
                var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraRenewals '" + resourceId + "'";
                DataTable infraRenwDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                //if (infraDataTable != null)
                //{
                //    infraResourceRenewal = infraDataTable.ToList<RM_InfraRenewalVM>();
                //}
                foreach (DataRow taskStatusRow in infraRenwDataTable.Rows)
                {
                    RM_InfraRenewalVM renewalVM = new RM_InfraRenewalVM()
                    {
                        TypeOfSubscription = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TypeOfSubscription"], "")),
                        BillingPeriod = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["BillingPeriod"], "")),
                        DateOfRenewal = String.Format("{0:dd MMMM yyyy}", taskStatusRow["DateOfRenewal"]),
                        NextBillingDate = String.Format("{0:dd MMMM yyyy}", taskStatusRow["NextBillingDate"]),
                        Amount = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["Amount"], "")),
                        TotalQuantity = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["TotalQuantity"], "")),
                        CurrencyName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CurrencyName"], "")),//Added BY Rutuja D> on 23 July 2021 For Display Currency Name
                    };
                    infraResourceRenewal.Add(renewalVM);
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraResourceRenewal);
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
        public HttpResponseMessage AddRenewal([FromBody] RM_InfraRenewal infraRenewal)
        {
          
            try
            {
                string strSQL;
                string strtResult;
                if (infraRenewal != null)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraRenewals "
                        + infraRenewal.InfraRenewalId +
                        " ," + infraRenewal.InfraResourceId + " ," + infraRenewal.TotalQuantity + " ,'" + infraRenewal.TypeOfSubscription + "' ,'" + infraRenewal.BillingPeriod + "' ,'" + infraRenewal.DateOfRenewal + "' ," + infraRenewal.CurrencyId + " ," + infraRenewal.Amount + " ,'" + infraRenewal.NextBillingDate + "' ,'" + infraRenewal.CreatedBy + "'";
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
        public HttpResponseMessage GetHistory([FromBody] string resourceId)
        {
          
            try
            {
                var infraResourceHistory = new List<RM_InfraResourceHistory>();
                var strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraResourcesHistory '" + resourceId + "'";
                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (infraDataTable != null)
                {
                    infraResourceHistory = infraDataTable.ToList<RM_InfraResourceHistory>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraResourceHistory);
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
        public HttpResponseMessage GetAssignments([FromBody] RM_AssignmentDates Op_InputParameter)
        //public HttpResponseMessage GetAssignments([FromBody] string resourceId)
        {
          
            try
            {
                var infraAssignments = new List<RM_InfraAssignments>();
                var strSQL = "Exec usp_Whizible2_Sel_InfraAssignments '" + Op_InputParameter.InfraResourceId + "','" + Op_InputParameter.AssignDate + "'";
                //var strSQL = "Exec usp_Whizible2_Sel_InfraAssignments '" + resourceId + "'";
                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (infraDataTable != null)
                {
                    infraAssignments = infraDataTable.ToList<RM_InfraAssignments>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraAssignments);
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
        public HttpResponseMessage GetProjectsAssignments([FromBody] RM_InfraAssign infraAssign)
        {
           
            try
            {
                var infraAssignments = new List<RM_InfraProjectAvailablity>();
                var strSQL = "Exec usp_Whizible2_Sel_InfraProjectAssignments '" + infraAssign.ActualDate + "','" + infraAssign.InfraResourceId + "'";
                DataTable infraDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow taskStatusRow in infraDataTable.Rows)
                {
                    RM_InfraProjectAvailablity infraProject = new RM_InfraProjectAvailablity()
                    {
                        ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["ProjectName"], "")),
                        AllocatedQuantity = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["AllocatedQuantity"], "0")),
                        StartDate = String.Format("{0:dd MMMM yyyy}", taskStatusRow["StartDate"]),
                        EndDate = String.Format("{0:dd MMMM yyyy}", taskStatusRow["EndDate"]),
                        CostPerHour = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["CostPerHour"], "")),
                        RatePerHour = Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(taskStatusRow["RatePerHour"], ""))

                    };
                    infraAssignments.Add(infraProject);
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraAssignments);
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
        public HttpResponseMessage GetBusinessGroups([FromBody] RM_InfraFilter RM_FilterParam)
        {

          
            try
            {
                List<OP_BusinessGroups> BgList = new List<OP_BusinessGroups>();
                var strSQL = "usp_Whizible2_sel_BG " + RM_FilterParam.LocationID + "," + RM_FilterParam.ResourceID;

                DataTable BgTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (BgTable != null)
                {
                    BgList = BgTable.ToList<OP_BusinessGroups>();
                }

                return Request.CreateResponse(HttpStatusCode.OK, BgList);
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
        public HttpResponseMessage GetBusinessGroupsLocation([FromBody] RM_InfraFilter RM_FilterParam)
        {

           
            try
            {
                List<OP_BusinessGroupLocation> BusinessGroupsLocationList = new List<OP_BusinessGroupLocation>();
                var strSQL = "usp_Whizible2_Sel_OU " + RM_FilterParam.BusinessGroupID + "," + RM_FilterParam.ResourceID + "," + 0;

                DataTable BusinessGroupsLocationTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (BusinessGroupsLocationTable != null)
                {
                    BusinessGroupsLocationList = BusinessGroupsLocationTable.ToList<OP_BusinessGroupLocation>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, BusinessGroupsLocationList);
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
        public HttpResponseMessage DeleteInfraRequest([FromBody] string resourceId)
        {
            try
            {
                if (resourceId != null)
                {
                    string Result = "";


                    string strSQL = "Exec usp_Whizible2_Del_InfraResourceMaster " + resourceId;
                    var srtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                    return Request.CreateResponse(HttpStatusCode.OK, srtResult);
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
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
        public HttpResponseMessage GetToFillInfraType([FromBody] ITparam tparam)
        {
           
            try
            {
                var infraTypeList = new List<It_InfraTypeCbo>();
                string strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraType " + tparam.InfraTypeId + "";
                DataTable Table = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (Table != null)
                {
                    infraTypeList = Table.ToList<It_InfraTypeCbo>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraTypeList);
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
        public HttpResponseMessage GetToFillInfraGroup([FromBody] ITparam tparam)
        {
          
            try
            {
                var infraGrpList = new List<It_InfraGroupCbo>();
                string strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraGroup " + tparam.InfraGroupId + "";
                DataTable Table = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (Table != null)
                {
                    infraGrpList = Table.ToList<It_InfraGroupCbo>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraGrpList);
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
        public HttpResponseMessage GetToFillInfraStatus([FromBody] ITparam tparam)
        {
            
            try
            {
                var infraStatusList = new List<It_InfraStatusCbo>();
                string strSQL = "Exec usp_Whizible2_Sel_tbl_RM_InfraStatus " + tparam.InfraStatusId + "";
                DataTable Table = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                if (Table != null)
                {
                    infraStatusList = Table.ToList<It_InfraStatusCbo>();
                }
                return Request.CreateResponse(HttpStatusCode.OK, infraStatusList);
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
        public object ExportDocument([FromBody]ReportParameter reportParameter)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName;
                long m_lngReportID;
                int DateFormatID = 0;
                string CompanyName = "";
                string ReportFormat = reportParameter.ReportFormat;

                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;
                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                AdHocReports.Report.AdHocReport oRpt;
                //if (reportParameter.InfraResourceId > 0)
                //{
                //Commented And Added by imran on 15-12-2021 for pdf download as per criteria
                //strSQL = "USP_Whizible2_CRW_SEL_INFRARESOURCE_DETAILS ";
                strSQL = "USP_Whizible2_CRW_SEL_INFRARESOURCE_DETAILS " + reportParameter.filterWhereClause;
                //End Comment by imran on 15-12-2021
                //}

                IDataReader drCompInfo1 = CommonFunctions.Data.GetSQLDataReader(strSQL, CommonController.connectionString);
                if (drCompInfo1.Read() == false)
                {
                    return "";
                }
                //m_lngReportID = 22286;  //22272
                m_lngReportID = 35004;
                CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                CommonEngines.HashTables.Culture.FillCultureHashTable();
                // The reports are created in the "Reports" folder
                strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));//FOR DEV ENV
                                                                                                                               // strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../../Reports/")); //FOR LOCAL ENV
                                                                                                                               // get a unique file name
                m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                // add extn to file name based on format requested
                switch (ReportFormat)
                {
                    case "PDF": m_strFileName += ".pdf"; break;
                    case "HTML": m_strFileName += ".htm"; break;
                    case "RTF": m_strFileName += ".rtf"; break;
                    case "EXCEL": m_strFileName += ".xls"; break;
                    case "CSV": m_strFileName += ".csv"; break;
                    case "TEXT": m_strFileName += ".txt"; break;
                    case "XML": m_strFileName += ".xml"; break;
                    //case "DOC": m_strFileName += ".doc"; break;
                    default: m_strFileName += ".pdf"; break;
                }
                IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_Whizible2_sel_tbl_PM_CompanyInformation", CommonController.connectionString);

                while (drCompInfo.Read())
                {
                    CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompInfo["CompanyName"], "").ToString();
                    DateFormatID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drCompInfo["DateFormatID"], "0"));
                }

                // create object of Adhoc reports
                oRpt = new AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));

                oRpt.UseMSSQL = true;
                oRpt.DefaultLCID = lngDefaultLCID;
                oRpt.LCID = lngCurrentThreadUICultureID;
                oRpt.UseHashTables = true;
                oRpt.DateFormat = DateFormatID;
                oRpt.CompanyName = CompanyName;
                oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");

                //' generate the report in requested format
                AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;
                switch (ReportFormat)
                {
                    case "PDF": oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                    case "HTML": oRpt.GenerateReport(AdHocReports.Format.HTML); break;
                    case "RTF": oRpt.GenerateReport(AdHocReports.Format.RTF); break;
                    case "EXCEL": oRpt.GenerateReport(AdHocReports.Format.EXCEL); break;
                    case "CSV": oRpt.GenerateReport(AdHocReports.Format.CSV); break;
                    case "TEXT": oRpt.GenerateReport(AdHocReports.Format.TEXT); break;
                    case "XML": oRpt.GenerateReport(AdHocReports.Format.XML); break;
                    // case "DOC": oRpt.GenerateReport(AdHocReports.Format.DOC); break;
                    default: oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                }

                oRpt = null;
                return m_strFileName;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

           

        }

        //Added by imran on 19-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 19-08-2022
        public string GetInactiveActiveStautsforInfra(RM_InfraResourceRequest ir_Parameters)
        {
            string activeStatus = "";
            try
            {

                if (ir_Parameters != null)
                {
                    string strSQL = "usp_Whizible2_sel_ActiveInactiveStatusForInfra " + ir_Parameters.BusinessGroupID + "," + ir_Parameters.LocationID;
                    activeStatus = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                }
            }
            catch (Exception ex)
            {
                return null;
            }
            return activeStatus;
        }


        public HttpResponseMessage Post()
        {
            try
            {
                HttpResponseMessage result = null;
                var httpRequest = HttpContext.Current.Request;
                if (httpRequest.Files.Count > 0)
                {
                    var docfiles = new List<string>();
                    foreach (string file in httpRequest.Files)
                    {
                        var postedFile = httpRequest.Files[file];
                        var filePath = HttpContext.Current.Server.MapPath("~/" + postedFile.FileName);
                        postedFile.SaveAs(filePath);
                        docfiles.Add(filePath);
                    }
                    result = Request.CreateResponse(HttpStatusCode.Created, docfiles);
                }
                else
                {
                    result = Request.CreateResponse(HttpStatusCode.BadRequest);
                }
                return result;
            }


            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }


        [HttpPost]
        public HttpResponseMessage UploadXlsxFile()
        {
            try
            {
                var httpRequest = HttpContext.Current.Request;
                var server = HttpContext.Current.Server;
                string FilePath = string.Empty;
                DataTable dtXlsx = null;

                var RM_InfraRequestsXlsxList = new List<RM_InfraResourceXlsx>();
                if (httpRequest.Files.Count > 0)
                {
                    var postedDocumentFile = httpRequest.Files[0];
                    var CurrentDate = string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);// DateTime.UtcNow;
                    string extension = Path.GetExtension(postedDocumentFile.FileName).ToLower();
                    string connString = "";
                    var FolderPath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Content/Uploads"));
                    string[] FileNameArr = postedDocumentFile.FileName.Split('.');
                    string FileName = string.Concat(FileNameArr[0], CurrentDate, '.', FileNameArr[1]);
                    string GetFullFileName = FileNameArr[0];
                    string LogfileName = "";
                    LogfileName = FolderPath + "Log.txt";
                    FilePath = string.Format("{0}/{1}", FolderPath, FileName);
                    using (StreamWriter writer = new StreamWriter(LogfileName))
                    {
                        writer.Write("Log Start Here.");
                    }
                    XlsxUtility.CreateDocDirectory(FolderPath);
                    if (XlsxUtility.IsValidFileFile(extension))
                    {
                        XlsxUtility.DeleteFileIfExist(FilePath);
                        postedDocumentFile.SaveAs(FilePath);
                        var FileExtension = extension.Trim();
                        string ConStringXsl = "";
                        string ConStringXslx = "";
                        if (Environment.Is64BitOperatingSystem)
                        {
                            ConStringXsl = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";
                            ConStringXslx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties='Excel 12.0;Xml;HDR=Yes;IMEX=1'";

                        }
                        else
                        {
                            ConStringXsl = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                            ConStringXslx = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=1\"";
                            //ConStringXslx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FilePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                        }
                        try
                        {
                            using (StreamWriter writer = new StreamWriter(LogfileName))
                            {
                                writer.Write("Inside Try Block." + FileExtension);
                            }
                            switch (FileExtension)
                            {
                                case ".csv":
                                    dtXlsx = XlsxUtility.ConvertCSVtoDataTable(FilePath);
                                    break;
                                case ".xls":
                                    connString = ConStringXsl;


                                    dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);
                                    break;
                                case ".xlsx":
                                    connString = ConStringXslx;
                                    using (StreamWriter writer = new StreamWriter(LogfileName))
                                    {
                                        writer.Write("Inside XLSX");
                                    }
                                    try
                                    {
                                        dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);

                                    }
                                    catch (Exception ex)
                                    {
                                        return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                                        //using (StreamWriter writer = new StreamWriter(LogfileName))
                                        //{
                                        //    writer.Write("Inside XLSX exception" + ex.Message);
                                        //}
                                    }
                                    break;
                            }
                        }
                        catch (Exception ex)
                        {
                            return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                            //using (StreamWriter writer = new StreamWriter(LogfileName))
                            //{
                            //    writer.Write("Inside Exception. " + ex.Message);
                            //}
                        }


                        //switch (FileExtension)
                        //{
                        //    case ".csv":
                        //        dtXlsx = XlsxUtility.ConvertCSVtoDataTable(FilePath);
                        //        break;
                        //    case ".xls":
                        //        connString = ConStringXsl;


                        //        dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);
                        //        break;
                        //    case ".xlsx":
                        //        connString = ConStringXslx;
                        //        dtXlsx = XlsxUtility.ConvertXSLXtoDataTable(FilePath, connString);
                        //        break;
                        //}

                        //RM_InfraRequestsXlsxList = SetXslxValues(dtXlsx);     
                        RM_InfraRequestsXlsxList = SetXslxValues(dtXlsx, GetFullFileName);
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, new { Message = "File format not supported" });
                    }
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                }

                return Request.CreateResponse(HttpStatusCode.Created, RM_InfraRequestsXlsxList);
            }


            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage UploadXlsxRecord(List<RM_InfraResourceXlsx> XlsxListParams)
        {
            try
            {
             
                foreach (var itemXlsx in XlsxListParams)
                {
                    if (itemXlsx != null)
                    {
                        var infraResource = new RM_InfraResourceRequest();
                        ///We will send it from UI
                        var strSQLReader = "Exec usp_Whizible2_Select_IDs_BG_INFRA_STATUS_OU_ByName '" + itemXlsx.InfraGroup + "',  '" + itemXlsx.Type + "',  '" + itemXlsx.InfraStatus + "', '" + itemXlsx.OrganizationUnit + "' ,'" + itemXlsx.BusinessGroup + "'";

                        IDataReader drQuery;
                        drQuery = CommonFunctions.Data.GetDataReader(strSQLReader, true, CommonController.connectionString);
                        int BusinessGroupID = 0, InfraTypeID = 0, InfraStatusID = 0, OrganizationID = 0; int GroupID = 0;
                        if (drQuery.Read())
                        {
                            BusinessGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["BusinessGroupID"], "0"));
                            InfraTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraTypeID"], "0"));
                            InfraStatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraStatusID"], "0"));
                            OrganizationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["OrganizationID"], "0"));
                            GroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["GroupID"], "0"));
                            itemXlsx.BusinessGroupID = BusinessGroupID;
                            itemXlsx.InfraTypeId = InfraTypeID;
                            itemXlsx.InfraStatusId = InfraStatusID;
                            itemXlsx.LocationID = OrganizationID;
                            itemXlsx.InfraGroupId = GroupID;

                        }
                        drQuery.Close();
                        string IsActiveDb = "";
                        IsActiveDb = itemXlsx.IsActive.ToString();
                       if (IsActiveDb.Trim().ToLower()=="true")
                        {
                            itemXlsx.IsActive = true;
                        }
                        else
                        {
                            itemXlsx.IsActive = false;

                        }

                       if(itemXlsx.AvaliableFrom == "null")
                        {
                            itemXlsx.AvaliableFrom = "";
                        }
                        else
                        {
                            itemXlsx.AvaliableFrom = String.Format("{0:dd-MMM-yyyy}", itemXlsx.AvaliableFrom);
                        }
                        if(itemXlsx.AvaliableTill == "null")
                        {
                            itemXlsx.AvaliableTill = "";
                        }
                        if(itemXlsx.RetiredOn == "null")
                        {
                            itemXlsx.RetiredOn = "";
                        }


                        var strSQL = "Exec usp_Whizible2_Ins_tbl_RM_InfraResource "
                                 + itemXlsx.InfraResourceId +
                                 " ,'" + itemXlsx.InfraName.Replace("'", "''") + "' ,'" + itemXlsx.Description.Replace("'", "''") + "' ," + itemXlsx.InfraTypeId + " ," + itemXlsx.InfraGroupId + " ," + itemXlsx.BusinessGroupID + " ," + itemXlsx.LocationID + " ," + itemXlsx.MaxAllocationPerDay + " ," + itemXlsx.TotalQuantity + " ," + itemXlsx.CostPerHour + " ," + itemXlsx.RatePerHour + " ," + itemXlsx.TotalCostOfAcquisition + " ," + itemXlsx.DepreciationRate + " ,'" + itemXlsx.AvaliableFrom + "' ,'" + itemXlsx.AvaliableTill + "' ,'" + itemXlsx.RetiredOn + "' ,'" + itemXlsx.Shared + "' ," + itemXlsx.InfraStatusId + "," + itemXlsx.IsActive + " ,'" + itemXlsx.CreatedBy + "'";

                        var strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                        if (strtResult != null)
                        {
                           // return Request.CreateResponse(HttpStatusCode.OK, strtResult);
                        }
                    }
                }
                
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            return Request.CreateResponse(HttpStatusCode.Created, "");
        }


        private object validateXlsx(DataTable dtInput)
        {
            try
            {
                var dtXls = new DataTable();
                var columnNames = dtInput.Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
                foreach (DataRow itemRow in dtInput.Rows)
                {
                    foreach (var itemcl in columnNames)
                    {
                        var ObjXlsx = new RM_InfraResourceXlsx();
                        String IsEmptyValue = String.Format(" {0} Should not be blank", "columnName");
                        String IsIntValue = String.Format(" {0} Should not be blank", "columnName");
                        String IsIntSizeValue = String.Format(" {0} Should not be blank", "columnName");
                        var CurrentValue = itemRow[itemcl].ToString();
                        if (!IsEmptyfield(CurrentValue) && (itemcl != "active" || itemcl != "Description" || itemcl != "Total Cost of Acquisition" || itemcl != "Depreciation Rate" || itemcl != "Available Till" || itemcl != "Retired on"))
                        {
                            var Message = IsEmptyValue.Replace("columnName", itemcl);
                            ObjXlsx.ColumnError = Message;
                        }

                        //check int  value 
                        if (itemcl == "Max Allocation Per Day(Hrs)" || itemcl == "Cost Per Hr" || itemcl == "Rate Per Hr" || itemcl == "Total Cost of Acquisition" || itemcl == "Total Quantity / No. of Licenses")
                        {
                            if (!IsNumeric(CurrentValue))
                            {
                                var Message = IsIntValue.Replace("columnName", itemcl);
                                ObjXlsx.ColumnError = Message;
                            }
                        }
                        //check decimal value
                        if (itemcl == "Depreciation Rate")
                        {

                        }
                        //check valid date value
                        if (itemcl == "Available From" || (itemcl == "Available Till" && !string.IsNullOrEmpty(itemcl)))
                        {

                        }

                    }
                }

                return dtXls;
            }


            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        private bool IsEmptyfield(string Value)
        {
            if (string.IsNullOrEmpty(Value))
            {
                return true;
            }
            return false;
        }
        private bool IsNumeric(string Value)
        {
            return IsNumeric(Value);
        }

        private bool IsDecimal(string value)
        {
            try
            {
                Decimal.Parse(value);
                return true;
            }
            catch
            {
                return false;
            }
        }


        private object IsFileExtensionValid(HttpPostedFile postedDocumentFile)
        {
            try
            {
                //check file extension
                var ext = new FileInfo(postedDocumentFile.FileName).Extension?.Replace('.', ' ')?.Trim();
                if (ConfigurationManager.AppSettings["filetypenotallowed"].Split(',').Contains(ext))
                    return false;
                return true;
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            
        }

        private void CreateDocDirectory(string path)
        {
            bool exists = Directory.Exists(path);
            if (!exists)
                Directory.CreateDirectory(path);
        }

        private object compareValues(int value1, int value2)
        {
            try
            {
                if (value1 > value2)
                {

                    return true;
                }
                else
                {
                    return false;
                }
            }

            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
           
        }

        private void InsertCSVRecords(DataTable csvdt)
        {
            //connection();
            //creating object of SqlBulkCopy    
            SqlBulkCopy objbulk = new SqlBulkCopy(CommonController.connectionString);
            //assigning Destination table name    
            objbulk.DestinationTableName = "Employee";
            //Mapping Table column    
            objbulk.ColumnMappings.Add("Name", "Name");
            objbulk.ColumnMappings.Add("City", "City");
            objbulk.ColumnMappings.Add("Address", "Address");
            objbulk.ColumnMappings.Add("Designation", "Designation");
            //inserting Datatable Records to DataBase    
            //con.Open();
            objbulk.WriteToServer(csvdt);
            ///con.Close();
        }

        private List<RM_InfraResourceXlsx> SetXslxValues(DataTable dtSetValues, string FileName)  //Get list object
        {
            //Added by imran 24-08-2021  To check Excel header
            string Message = string.Empty;
            //string[] ColumnName = new string[17] { "Infra Name", "Description", "Active", "Type", "Infra Group", "Business Group", "Organization Unit", "Max Allocation Per Day(Hrs)", "Infra Status", "Cost Per Hr", "Rate Per Hr", "Total Cost of Acquisition", "Depreciation Rate", "Available From", "Available Till", "Retired on", "Total Quantity / No. of Licenses" };
            string[] ColumnName = new string[17] { "Infrastructure Name", "Description", "Active", "Infrastructure Type", "Infrastructure Group", "Business Group", "Organization Unit", "Max Allocation Per Day(Hrs)", "Infrastructure Status", "Cost Per Hr", "Rate Per Hr", "Total Cost of Acquisition", "Depreciation Rate", "Available From", "Available Till", "Retired on", "Total Quantity / No. of Licenses" };
            int ColsHeaderNamecheck = 0;
            var ObjXlsx = new RM_InfraResourceXlsx();
            //End by imran 24-08-2021

            var ObjXlsxList = new List<RM_InfraResourceXlsx>();
            var columnNames = dtSetValues.Columns.Cast<DataColumn>().Select(x => x.ColumnName).ToList();
            var ExcelColumnCount = dtSetValues.Columns.Count.ToString();
            var TotalCount = "17".ToString();
            //if (TotalCount != ExcelColumnCount)
            //{
            //    var ObjXls = new RM_InfraResourceXlsx();
            //    ObjXls.ColumnError = "Please Check Excel Column Configuration.";
            //    ObjXlsxList.Add(ObjXls);
            //}
            //else
            //{
            //Added by imran 24-08-2021 To check null
            string ExcelStrSQL = "Select ISNULL(ExcelUploadRenge,0) from tbl_Whizible2_PM_ProjectSettings";
            object ExcelUploadRenge = CommonFunctions.Data.GetDataScalar(ExcelStrSQL, true, CommonController.connectionString);

            for (int i = 0; i < columnNames.Count; i++)
            {
                if (i > 16)
                {
                }
                else
                {
                    if (columnNames[i].ToString().Replace("#",".") == ColumnName[i].ToString())
                    {
                        ColsHeaderNamecheck += 1;
                    }
                }
            }
            //Added By Rutuja D, on 27 Jan 2022 For check Exact template file name
            if (FileName.Trim() != "InfrastructureResourceManagement")
            {
                Message += string.Concat(':', "The uploaded file name should be same as the Template.");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            //End Added By Rutuja D, on 27 Jan 2022 For check Exact template file name
            else if (columnNames.Count != 17)
            {
                Message += string.Concat(':', "{0} Please Check Excel Column Configuration");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (ColsHeaderNamecheck != 17)
            {
                Message += string.Concat(':', "{0} Excel Column Header Not Match");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count == 0)
            {
                Message += string.Concat(':', "{0} Uploaded Excel File is Blank");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count > Convert.ToInt32(ExcelUploadRenge))
            {
                Message += string.Concat(':', "{0} Please upload " + ExcelUploadRenge + " record");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else if (dtSetValues.Rows.Count > 500)
            {
                Message += string.Concat(':', "{0} Uploaded file should not be greater than 500 record.");
                ObjXlsx.ColumnError = Message;
                ObjXlsxList.Add(ObjXlsx);
            }
            else
            {
                //end by imran 24-08-2021
                foreach (DataRow itemRow in dtSetValues.Rows)
                {
                    ObjXlsx = new RM_InfraResourceXlsx();
                    foreach (var itemcl in columnNames)
                    {
                        var CurrentValue = itemRow[itemcl].ToString();
                        if (itemcl == XlsxHeaderNameConst.InfraName)
                        {
                            ObjXlsx.InfraName = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.InfraName))
                            {
                                ////Message += string.Concat(':', "{0}  Infra Name should not be left blank. ");
                                Message += string.Concat(':', "{0}  Infrastructure Name should not be left blank. ");
                                ObjXlsx.ColumnError = Message;
                            }
                            if (ObjXlsx.InfraName.Length > 50)
                            {
                                //Message += string.Concat(':', "{1}  Infra Name should not greater than 50 characters. ");
                                Message += string.Concat(':', "{1}  Infrastructure Name should not greater than 50 characters. ");
                                ObjXlsx.ColumnError = Message;
                            }

                        }
                        if (itemcl == XlsxHeaderNameConst.Description)
                        {
                            ObjXlsx.Description = CurrentValue;

                            if (ObjXlsx.Description.Length > 200)
                            {
                                Message += string.Concat(':', "{0}  Description should not greater than 200 characters. ");
                                ObjXlsx.ColumnError = Message;
                            }


                        }
                        if (itemcl == XlsxHeaderNameConst.Active)
                        {
                            ObjXlsx.IsActive = CurrentValue.ToLower() == "true" ? true : false;
                            if (!IsEmptyfield(CurrentValue.ToLower()))
                            {
                                if (CurrentValue.ToLower() == "true") { }
                                else if (CurrentValue.ToLower() == "false") { }
                                else
                                {
                                    Message += string.Concat(':', "{0}  Active should be 'true or false'.");
                                    ObjXlsx.ColumnError = Message;
                                }
                                
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.Type)
                        {
                            //get name using ID
                            //ObjXlsx.InfraTypeId = 10;
                            ObjXlsx.Type = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.Type))
                            {
                                //Message += string.Concat(':', "{0} Infra Type should not be left blank. ");
                                Message += string.Concat(':', "{0} Infrastructure Type should not be left blank. ");
                                ObjXlsx.ColumnError = Message;
                            }

                        }
                        if (itemcl == XlsxHeaderNameConst.InfraGroup)
                        {
                            ObjXlsx.InfraGroup = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.InfraGroup))
                            {
                                //Message += string.Concat(':', "{0} Infra Group should not be left blank. ");
                                Message += string.Concat(':', "{0} Infrastructure Group should not be left blank. ");
                                ObjXlsx.ColumnError = Message;
                            }

                        }
                        if (itemcl == XlsxHeaderNameConst.BusinessGroup)
                        {

                            ObjXlsx.BusinessGroup = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.BusinessGroup))
                            {
                                Message += string.Concat(':', "{0} Business Group should not be left blank. ");
                                ObjXlsx.ColumnError = Message;
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.OrganizationUnit)
                        {
                            //ObjXlsx.LocationID = 10;
                            ObjXlsx.OrganizationUnit = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.OrganizationUnit))
                            {
                                Message += string.Concat(':', "{0} Organization Unit should not be left blank. ");
                                ObjXlsx.ColumnError = Message;
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.MaxAllocationPerDay || itemcl.Contains("Max Allocation Per Day"))
                        {
                            if (CurrentValue != null && CurrentValue != "")
                            {
                                if (IsDigitsOnly(CurrentValue.ToString()) == false )
                                {
                                    Message += string.Concat(':', "{0}  Max Allocation Per Day must be digit only. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.MaxAllocationPerDay = Convert.ToInt32(CurrentValue);

                                    if (IsEmptyfield(ObjXlsx.MaxAllocationPerDay.ToString()))
                                    {
                                        Message += string.Concat(':', "{0}  Max Allocation Per Day should not be left blank. ");
                                        ObjXlsx.ColumnError = Message;
                                    }

                                    if (ObjXlsx.MaxAllocationPerDay > 24)
                                    {
                                        Message += string.Concat(':', "Max Allocation Per Day should not greater than 24 hrs.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                    if (ObjXlsx.MaxAllocationPerDay == 0 || ObjXlsx.MaxAllocationPerDay < 0)
                                    {
                                        Message += string.Concat(':', "{0} Max Allocation Per Day must be greater than 0 ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                            }
                            else
                            {
                                if (IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Max Allocation Per Day should not be left blank. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.InfraStatus)
                        {
                            ObjXlsx.InfraStatus = CurrentValue;
                        }
                        if (itemcl == XlsxHeaderNameConst.CostPerHour)
                        {
                            if (CurrentValue != null && CurrentValue != "")
                            {
                                if (!IsDecimal(CurrentValue.ToString()))
                                {
                                    Message += string.Concat(':', "{0}  Cost Per Hour should be in decimal. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.CostPerHour = Convert.ToDecimal(CurrentValue);
                                    if (IsEmptyfield(ObjXlsx.CostPerHour.ToString()))
                                    {
                                        Message += string.Concat(':', "{0}  Cost Per Hour should not be left blank. ");
                                        ObjXlsx.ColumnError = Message;
                                    }

                                    if (Convert.ToDouble(CurrentValue) > 999.99)
                                    {
                                        Message += string.Concat(':', "{0}  Enter Cost Per Hour 6 digit intger number. ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                    if (ObjXlsx.CostPerHour == 0 || ObjXlsx.CostPerHour < 0)
                                    {
                                        Message += string.Concat(':', "{0}  Cost per Hour must be greater than 0 ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                            }
                            else
                            {
                                if (IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Cost per Hour should not be left blank. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.RatePerHour)
                        {
                            if (CurrentValue != null && CurrentValue != "")
                            {
                                if (!IsDecimal(CurrentValue.ToString()))
                                {
                                    Message += string.Concat(':', "Rate Per Hour should be in decimal. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.RatePerHour = Convert.ToDecimal(CurrentValue);
                                    if (IsEmptyfield(ObjXlsx.RatePerHour.ToString()))
                                    {
                                        Message += string.Concat(':', "Rate Per Hour should not be left blank. ");
                                        ObjXlsx.ColumnError = Message;
                                    }

                                    if (Convert.ToDouble(CurrentValue) > 999.99)
                                    {
                                        Message += string.Concat(':', "Rate per Hour should not greater than 999.99");
                                        ObjXlsx.ColumnError = Message;
                                    }

                                    if (ObjXlsx.RatePerHour == 0 || ObjXlsx.RatePerHour < 0)
                                    {
                                        Message += string.Concat(':', "{0}  Rate per Hour must be greater than 0 ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                            }
                            else
                            {
                                if (IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Rate per Hour should not be left blank. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                        }

                        if (itemcl == XlsxHeaderNameConst.TotalCostOfAcquisition)
                        {
                            if (CurrentValue != null && CurrentValue != "")
                            {
                                if (!IsDecimal(CurrentValue.ToString()))
                                {
                                    Message += string.Concat(':', "{0}  Total Cost of Acquisition must be digit only. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    if (CurrentValue != null && CurrentValue != "")
                                    {
                                        ObjXlsx.TotalCostOfAcquisition = Convert.ToDecimal(CurrentValue);
                                    }
                                    if (CurrentValue != null && CurrentValue != "")
                                    {
                                        if (Convert.ToDouble(CurrentValue) > 999999999.99)
                                        {
                                            Message += string.Concat(':', "Total Cost of Acquisition should not greater than 999999999.99");
                                            ObjXlsx.ColumnError = Message;
                                        }
                                    }
                                }
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.DepreciationRate)
                        {
                            if (CurrentValue != null && CurrentValue != "")
                            {
                                //ObjXlsx.DepreciationRate = Convert.ToDecimal(CurrentValue);
                                if (!IsDecimal(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Depreciation Rate Should be in decimal. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.DepreciationRate = Convert.ToDecimal(CurrentValue);

                                    if (Convert.ToDouble(CurrentValue) > 100)
                                    {
                                        Message += string.Concat(':', "Depreciation Rate' Should not be more that 100%.");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }

                            }
                        }

                        if (itemcl == XlsxHeaderNameConst.AvaliableFrom)
                        {
                            ObjXlsx.AvaliableFrom = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.AvaliableFrom.ToString()) || ObjXlsx.AvaliableFrom.ToString()=="null" || ObjXlsx.AvaliableFrom.ToString() == "")
                            {
                                Message += string.Concat(':', "{0}  Avaliable From should not be left blank. ");
                                ObjXlsx.ColumnError = Message;
                            }
                            else
                            {
                                try
                                {
                                    //Added by imran 26-08-2021 to convert date
                                    string tdt = CurrentValue.Replace(" 00:00:00", "");
                                    DateTime dt = Convert.ToDateTime(tdt);
                                    ObjXlsx.AvaliableFrom = dt.ToString("dd MMM yyyy");
                                    //End by imran 26-08-2021
                                }
                                catch
                                {
                                    Message += string.Concat(':', "{0} Available From Date Is Invalid Date Format Or Invalid Date. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.AvaliableTill)
                        {
                            ObjXlsx.AvaliableTill = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.AvaliableTill.ToString()) || ObjXlsx.AvaliableTill.ToString() == "null" || ObjXlsx.AvaliableTill.ToString() == "")
                            { }
                            else
                            {
                                try
                                {
                                    //Added by imran 26-08-2021 to convert date
                                    string tdt = CurrentValue.Replace(" 00:00:00", "");
                                    DateTime dt = Convert.ToDateTime(tdt);
                                    ObjXlsx.AvaliableTill = dt.ToString("dd MMM yyyy"); ;
                                    //End by imran 26-08-2021
                                }
                                catch
                                {
                                    Message += string.Concat(':', "{0} Available Till Date Is Invalid Date Format Or Invalid Date. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                            
                        }
                        if (itemcl == XlsxHeaderNameConst.RetiredOn)
                        {
                            ObjXlsx.RetiredOn = CurrentValue;
                            if (IsEmptyfield(ObjXlsx.RetiredOn.ToString()) || ObjXlsx.RetiredOn.ToString() == "null" || ObjXlsx.RetiredOn.ToString() == "")
                            {}
                            else
                            {
                                try
                                {
                                    //Added by imran 26-08-2021 to convert date
                                    string tdt = CurrentValue.Replace(" 00:00:00", "");
                                    DateTime dt = Convert.ToDateTime(tdt);
                                    ObjXlsx.RetiredOn = dt.ToString("dd MMM yyyy"); ;
                                    //End by imran 26-08-2021
                                }
                                catch
                                {
                                    Message += string.Concat(':', "{0} Retired On Date Is Invalid Date Format Or Invalid Date. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }
                        }
                        if (itemcl == XlsxHeaderNameConst.TotalQuantity || itemcl == "Total Quantity / No# of Licenses" || itemcl.Contains("Total Quantity"))
                        {
                            if (CurrentValue != null && CurrentValue != "")
                            {
                                if (IsDigitsOnly(CurrentValue.ToString()) == false)
                                {
                                    Message += string.Concat(':', "{0}  Total Quantity / No. of Licenses must be digit only. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                                else
                                {
                                    ObjXlsx.TotalQuantity = Convert.ToDecimal(CurrentValue);

                                    if (IsEmptyfield(ObjXlsx.TotalQuantity.ToString()))
                                    {
                                        Message += string.Concat(':', "{0}  Total Quantity should not be left blank. ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                    if (ObjXlsx.TotalQuantity == 0 || ObjXlsx.TotalQuantity < 0)
                                    {
                                        Message += string.Concat(':', "{0}  Total Quantity must be greater than 0 ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                            }
                            else
                            {
                                
                                if (IsEmptyfield(CurrentValue))
                                {
                                    Message += string.Concat(':', "{0}  Total Quantity should not be left blank. ");
                                    ObjXlsx.ColumnError = Message;
                                }
                            }


                        }


                    }
                    #region Get Ids for bg type etc using name

                    var strSQL = "Exec usp_Whizible2_Select_IDs_BG_INFRA_STATUS_OU_ByName '" + ObjXlsx.InfraGroup.Replace("'", "''") + "',  '" + ObjXlsx.Type.Replace("'", "''") + "',  '" + ObjXlsx.InfraStatus.Replace("'", "''") + "', '" + ObjXlsx.OrganizationUnit.Replace("'", "''") + "' ,'" + ObjXlsx.BusinessGroup.Replace("'", "''") + "'";

                    IDataReader drQuery;
                    drQuery = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                    int BusinessGroupID = 0, InfraTypeID = 0, InfraStatusID = 0, OrganizationID = 0; int GroupID = 0;
                    if (drQuery.Read())
                    {
                        BusinessGroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["BusinessGroupID"], "0"));
                        InfraTypeID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraTypeID"], "0"));
                        InfraStatusID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["InfraStatusID"], "0"));
                        OrganizationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["OrganizationID"], "0"));
                        GroupID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drQuery["GroupID"], "0"));
                    }
                    drQuery.Close();
                    if (BusinessGroupID > 0)
                    {
                        ObjXlsx.BusinessGroupID = BusinessGroupID;
                    }
                    else
                    {
                        //Message += string.Concat(':', "BusinessGroup  not found for " + ObjXlsx.BusinessGroup);
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.BusinessGroup))
                        {
                            Message += string.Concat(':', "Business Group does not exist.");
                            ObjXlsx.ColumnError = Message;
                        }
                    }
                    if (InfraTypeID > 0)
                    {
                        ObjXlsx.InfraTypeId = InfraTypeID;
                    }
                    else
                    {
                        //Message += string.Concat(':', "InfraType  not found for " + ObjXlsx.Type);
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.Type))
                        {
                            //Message += string.Concat(':', "Infra Type does not exist.");
                            Message += string.Concat(':', "Infrastructure Type does not exist.");
                            ObjXlsx.ColumnError = Message;
                        }                        
                    }

                    if (InfraStatusID > 0)
                    {
                        ObjXlsx.InfraStatusId = InfraStatusID;
                    }
                    else
                    {
                       // Message += string.Concat(':', "InfraStatus  not found for " + ObjXlsx.InfraStatus);
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.InfraStatus))
                        {
                            //Message += string.Concat(':', "Infra Status does not exist.");
                            Message += string.Concat(':', "Infrastructure Status does not exist.");
                            ObjXlsx.ColumnError = Message;
                        }
                    }

                    if (OrganizationID > 0)
                    {
                        ObjXlsx.LocationID = OrganizationID;
                    }
                    else
                    {
                        //Message += string.Concat(':', "OrganizationUnit not found for " + ObjXlsx.OrganizationUnit);
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.OrganizationUnit))
                        {
                            Message += string.Concat(':', "Business Group and Organization Unit are not associated with each other. ");
                            ObjXlsx.ColumnError = Message;
                        }
                        ObjXlsx.ColumnError = Message;
                    }
                    if (GroupID > 0)
                    {
                        ObjXlsx.InfraGroupId = GroupID;
                    }
                    else
                    {
                        //Message += string.Concat(':', "InfraGroup not found for " + ObjXlsx.OrganizationUnit);
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.InfraGroup))
                        {
                            //Message += string.Concat(':', "Infra Group does not exist.");
                            Message += string.Concat(':', "Infrastructure Group does not exist.");
                            ObjXlsx.ColumnError = Message;
                        }
                    }

                    if (ObjXlsx.CostPerHour > 0 && ObjXlsx.RatePerHour > 0)
                    {
                        if (ObjXlsx.CostPerHour > ObjXlsx.RatePerHour)
                        {
                            Message += string.Concat(':', "{0}  Cost Per Hour Should Not be greater than Rate Per Hour. ");
                            ObjXlsx.ColumnError = Message;
                        }
                    }
                    if (ObjXlsx.TotalCostOfAcquisition > 0 && ObjXlsx.CostPerHour > 0)
                    {
                        if (ObjXlsx.TotalCostOfAcquisition < ObjXlsx.CostPerHour)
                        {
                            Message += string.Concat(':', "Total Cost of Acquisition' Should be greater than 'Cost Per Hr");
                            ObjXlsx.ColumnError = Message;
                        }
                        
                    }

                    if (!string.IsNullOrEmpty(ObjXlsx.AvaliableFrom) && ObjXlsx.AvaliableFrom != null && !string.IsNullOrEmpty(ObjXlsx.AvaliableTill) && ObjXlsx.AvaliableTill != null)
                    {
                        if (!XlsxUtility.IsEmptyfield(ObjXlsx.AvaliableFrom))
                        {
                            if (!XlsxUtility.IsEmptyfield(ObjXlsx.AvaliableTill))
                            {
                                try
                                {
                                    if (Convert.ToDateTime(ObjXlsx.AvaliableFrom) > Convert.ToDateTime(ObjXlsx.AvaliableTill))
                                    {
                                        Message += string.Concat(':', "{0} 'Available From' Should not be greater than 'Available Till'. ");
                                        ObjXlsx.ColumnError = Message;
                                    }
                                }
                                catch { }
                            }

                        }
                    }
                    if (!string.IsNullOrEmpty(ObjXlsx.RetiredOn) && ObjXlsx.RetiredOn != null && !string.IsNullOrEmpty(ObjXlsx.AvaliableTill) && ObjXlsx.AvaliableTill != null)
                    {
                        try
                        {
                            var RetiredOn = Convert.ToDateTime(ObjXlsx.RetiredOn);
                            var AvaliableTill = Convert.ToDateTime(ObjXlsx.AvaliableTill);

                            if (RetiredOn > AvaliableTill)
                            {
                                Message += string.Concat(':', "Retired On' Should not be greater than 'Available Till");
                                ObjXlsx.ColumnError = Message;
                            }
                        }
                        catch { }

                    }


                    #endregion
                    ObjXlsxList.Add(ObjXlsx);

                }
            }
            //}
            return ObjXlsxList;
        }

        //Added By Reshma Chavan on 1st Feb 2022 for getting validation
        [HttpPost]
        //Added by imran on 30-08-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 30-08-2022
        public object GetMaxAvailableLicences([FromBody] int infraResourceID)
        {
            try
            {
                double result;
                string strSQL = "Exec usp_Whizible2_Sel_GetMaxAvailableLicences " + infraResourceID;
                result = Convert.ToDouble(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), ""));
                return result;
            }


            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        
        }

        //Added by imran 24-08-2021 To check Digit Only
        bool IsDigitsOnly(string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9')
                    return false;
            }

            return true;
        }
        //End by imran 24-08-2021
    }


    public static class Utility
    {
        public static DataTable ConvertCSVtoDataTable(string strFilePath)
        {
            DataTable dt = new DataTable();
            using (StreamReader sr = new StreamReader(strFilePath))
            {
                string[] headers = sr.ReadLine().Split(',');
                foreach (string header in headers)
                {
                    dt.Columns.Add(header);
                }

                while (!sr.EndOfStream)
                {
                    string[] rows = sr.ReadLine().Split(',');
                    if (rows.Length > 1)
                    {
                        DataRow dr = dt.NewRow();
                        for (int i = 0; i < headers.Length - 1; i++)
                        {
                            if (rows != null && rows[i] != null)
                            {
                                dr[i] = rows[i].Trim();
                            }

                        }
                        dt.Rows.Add(dr);
                    }
                }

            }


            return dt;
        }

        public static DataTable ConvertXSLXtoDataTable(string strFilePath, string connString)
        {
            OleDbConnection oledbConn = new OleDbConnection(connString);
            DataTable dt = new DataTable();
            try
            {

                oledbConn.Open();
                using (OleDbCommand cmd = new OleDbCommand("SELECT * FROM [Sheet1$]", oledbConn))
                {
                    OleDbDataAdapter oleda = new OleDbDataAdapter();
                    oleda.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    oleda.Fill(ds);

                    dt = ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {

                oledbConn.Close();
            }

            return dt;

        }
    }


    public static class XlsxHeaderNameConst
    {
        //public static string InfraName = "Infra Name";
        public static string InfraName = "Infrastructure Name";
        public static string Description = "Description";
        public static string Active = "Active";
        //public static string Type = "Type";
        public static string Type = "Infrastructure Type";
        //public static string InfraGroup = "Infra Group";
        public static string InfraGroup = "Infrastructure Group";
        public static string BusinessGroup = "Business Group";
        public static string OrganizationUnit = "Organization Unit";
        public static string MaxAllocationPerDay = "Max Allocation Per Day (Hrs)";
        //public static string InfraStatus = "Infra Status";
        public static string InfraStatus = "Infrastructure Status";
        public static string CostPerHour = "Cost Per Hr";
        public static string RatePerHour = "Rate Per Hr";
        public static string TotalCostOfAcquisition = "Total Cost of Acquisition";
        public static string DepreciationRate = "Depreciation Rate";
        public static string AvaliableFrom = "Available From";
        public static string AvaliableTill = "Available Till";
        public static string RetiredOn = "Retired on";
        public static string TotalQuantity = "Total Quantity / No.of Licenses";
    }
   
}







