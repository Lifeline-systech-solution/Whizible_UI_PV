using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.Invoice;
using System.IO;
using Newtonsoft.Json;
//using WhizibleAPI.Models.RM;

namespace WhizibleAPI.Controllers
{
    public class RFI_IR_PIRController : ApiController
    {
        /*
     Created By : Vishal Mane
     Created Date : 03/11/2023
     Purpose : To dispaly the list of IR/PIR's for selected project
     */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetIRPIRList([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                var Status = "";
                if (RequestParameters.Status == "")
                {
                    Status = "Select Status";
                }
                else
                {
                    Status = RequestParameters.Status;
                }
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIs " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFITypeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Status)) + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /*
       Created By : Vishal Mane
       Created Date : 06/11/2023
       Purpose : To get Status Type List 
       */
        [HttpPost]
        [Authorize]
        public object GetStatusType()
        {
            try
            {
                var strSQL = "usp_Whizible2_Sel_tbl_PM_RFIStatus";
                DataTable StatusTypes = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return StatusTypes;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        /*
         Created By : Vishal Mane
         Created Date : 06/11/2023
         Purpose : To save filter query for IR/PIR filter
         */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SaveFilterQuery([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strtResult = string.Empty;
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_RFIs_Filters " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.BillingCurrencyAmount)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.IsProforma)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIRaisedOn)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Status)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFITypeID)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.BaseCurrencyAmount)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.EquivAmount)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.FilterName)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.FilterID)) + "', '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.CreatedBy)) + "', '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.IsOnlyApplyFlag)) + "', '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.BillingCurrencyCode)) + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
       Created By : Vishal Mane
       Created Date : 03/11/2023
       Purpose : To dispaly the list of IR/PIR's for selected project
       */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetIRPIRListforFilter([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIsFilterData " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Status)) + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 03/11/2023
        Purpose : To dispaly the list of IR/PIR's for filtered data
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ApplyFilterData([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strParms = "";
                string strSQL;
                strParms = RequestParameters.whereClause.Replace("'", "''");
                //strParms = "@StrParam='" + strParms + "'";

                //strParms = "@StrParam='" + strParms + "'";

                //strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIsFilterData " + strParms;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIsFilterData '" + strParms + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 03/11/2023
        Purpose : To bind filter list of IR/PIR's for selected project
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetFilterList([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIs_Filters " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetProjectCurrency([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Project_Currency " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));
                //Modified by Vishal Mane to get Project currency and its code on 22/12/23
                //string PCurrency = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                //return PCurrency;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
                //End of Modified by Vishal Mane to get Project currency and its code on 22/12/23
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*
        Created By : Vishal Mane
        Created Date : 07/11/2023
        Purpose : To set dafault filter
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultFilter([FromBody] RFI_IR_PIR RequestParameters)
        {

            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_RFIsFilter " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.FilterID)) + "";

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 07/11/2023
        Purpose : To get dafault filter WhereClase
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDefaultWhereClase([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIs_FiltersWhereClase " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.FilterID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*
        Created By : Vishal Mane
        Created Date : 07/11/2023
        Purpose : To delete filter 
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteFilterById([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Del_RFIs_Filters " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.FilterID));

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 08/11/2023
        Purpose : To select the RFI checklist items.
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIChecklistItems([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIChecklist_Items_ForInvoiceGeneration " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetCurrencyCodes()
        {
            try
            {
                string query = "";
                string BaseCurncy = "";
                string BaseCurncyID = "";

                string LocalCurncy = "";
                string CorpCurrencySymbol = "";
                DataTable result = null;
                query = "EXEC usp_Whizible2_Sel_InvoiceDB_GetBaseCurrencyInfo";
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                if (result.Rows.Count > 0)
                {
                    DataRow row = result.Rows[0];
                    BaseCurncy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["CurrencyCode"], "0"));
                    BaseCurncyID = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["CurrencyID"], "0"));
                    CorpCurrencySymbol = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["CurrencySymbol"], "0"));
                }

                query = "EXEC usp_Whizible2_Sel_tbl_PM_CurrencyMaster_GetLocalCurrency";
                result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                if (result.Rows.Count > 0)
                {
                    DataRow row = result.Rows[0];
                    LocalCurncy = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["CurrencyCode"], "0"));
                }

                var currencyInfo = new
                {
                    BaseCurncy,
                    BaseCurncyID,
                    LocalCurncy,
                    CorpCurrencySymbol
                };

                return currencyInfo;
                //   return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetRFITypes()
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_RFITypesMaster null,1";
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCurrencyDetails([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_sel_GetCurrencyDetails '" + rFI_IR_PIR.CurrencyCode + "' ";
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIProjectCurrency([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                string Strsql = "";
                int result = 0;
                query = "EXEC usp_Whizible2_Validation_IR_BillingBaseLocalCompanyBaseCurrency  " + rFI_IR_PIR.ProjectID;
                DataTable dataTable = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                if (dataTable.Rows.Count > 0)
                {
                    DataRow row = dataTable.Rows[0];
                    result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["BillingCurrencyID"], "0"));
                }

                Strsql = "usp_Whizible2_Sel_tbl_PM_CurrencyMaster " + result;
                DataTable dt = CommonFunctions.Data.GetDataTable(Strsql, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIProjectbillingCurrency([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                int result = 0;
                query = "EXEC usp_Whizible2_Validation_IR_BillingBaseLocalCompanyBaseCurrency  " + rFI_IR_PIR.ProjectID;
                DataTable dataTable = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                if (dataTable.Rows.Count > 0)
                {
                    DataRow row = dataTable.Rows[0];
                    result = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(row["BillingCurrencyID"], "0"));
                }


                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetProjectDetails([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_Project  " + rFI_IR_PIR.ProjectID;
                //  string result = "";
                // RFI_IR_PIR Information = new RFI_IR_PIR();
                DataTable dataTable = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                //if (dataTable.Rows.Count > 0)
                //{
                //    DataRow row = dataTable.Rows[0];
                //    Information.ProjectType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["Type"], ""));
                //    Information.ContractType = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["ContractType"], "0"));
                //    Information.ProjectName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(row["ProjectName"], ""));
                //}

                return dataTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateIRConfiguration([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {

            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Validation_IR_BillingBaseLocalCompanyBaseCurrency  " + rFI_IR_PIR.ProjectID;
                DataTable dataTable = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);

                return dataTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFIContactPerson([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_CustomerContactPersons  " + rFI_IR_PIR.CustomerID;
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize]
        [HttpPost]
        public object GetRFICustomer()
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_Customer_RFI null,'Project'";
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFIProjectCustomer([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {

            try
            {
                string query = "";
                int CustomerID = 0;
                DataTable Customer = null;
                query = "EXEC usp_Whizible2_Sel_tbl_PM_Project " + rFI_IR_PIR.ProjectID;
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                foreach (DataRow opRow in result.Rows)
                {
                    CustomerID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["CustomerID"], "0"));
                }
                if (CustomerID > 0)
                {
                    query = "EXEC usp_Whizible2_Sel_tbl_PM_Customer_RFI " + CustomerID;
                    Customer = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                }
                return Customer;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFICustomerPrjAddress([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_Customer_PrjAddresses " + rFI_IR_PIR.CustomerID;
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFICustomerDefaultPrjAddress([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_Customer_GetDefaultAddress " + rFI_IR_PIR.CustomerID + "," + rFI_IR_PIR.ProjectID;
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFICustomerAddress([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {

            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_Customer_Addresses " + rFI_IR_PIR.CustomerID + "," + rFI_IR_PIR.CustomerAddrID;
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFIContract([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {

            try
            {
                string query = "";
                if (rFI_IR_PIR.ContractTypeID == 0)
                {
                    query = "EXEC usp_Whizible2_sel_tbl_PM_ContractMasterTypes " + rFI_IR_PIR.CustomerID;
                }
                else
                {
                    query = "EXEC usp_Whizible2_sel_tbl_PM_ContractMasterTypes " + rFI_IR_PIR.CustomerID + "," + rFI_IR_PIR.ContractTypeID;
                }
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFIContractDocument([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";

                query = "EXEC usp_Whizible2_Sel_tbl_PM_ContractTypeDoc " + rFI_IR_PIR.ContractID;
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFIContractType([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_ContractTypeMaster " + rFI_IR_PIR.CustomerID;
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFIContactEmail([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                query = "EXEC usp_Whizible2_Sel_tbl_PM_CustomerContactPersons_EmailID " + rFI_IR_PIR.CustomerID + "," + rFI_IR_PIR.CustomerContactID + "";
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetRFISalesPerson([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {

            try
            {
                string query = "";
                if (rFI_IR_PIR.SalesPerson == "" && rFI_IR_PIR.SalesPersCommision == "")
                {
                    query = "EXEC usp_Whizible2_sel_tbl_PM_Project_SalesPersons " + rFI_IR_PIR.ProjectID;
                }
                else
                {
                    query = "EXEC usp_Whizible2_sel_tbl_PM_Project_SalesPersons " + rFI_IR_PIR.ProjectID + ",'" + rFI_IR_PIR.SalesPerson + "','" + rFI_IR_PIR.SalesPersCommision + "'";
                }
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSalesPeriodDetails([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                DataTable getSalesPeriods = CommonFunctions.Data.GetDataTable("usp_Whizible2_sel_tbl_PM_SalesPeriodMaster " + HttpUtility.UrlDecode(Convert.ToString(Parameters.IsOpen)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodYear)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodMonth)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodStartDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.salesPeriodEndDate)) + "'", true, CommonController.connectionString);
                return getSalesPeriods;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]        
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object CreateIRItem([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";
                //Modified by Vishal on 25/12/23
                string strSQL = "";
                //End of Modified by Vishal on 25/12/23
                query = "EXEC usp_Whizible2_Ins_tbl_PM_RFIs " + rFI_IR_PIR.RFID + "," 
                    + rFI_IR_PIR.ProjectID + "," 
                    + rFI_IR_PIR.IsProforma + "," 
                    + rFI_IR_PIR.RFITypeID + "," 
                    + rFI_IR_PIR.CustomerID +"," 
                    + rFI_IR_PIR.CustomerContactID+ "," 
                    + rFI_IR_PIR.CustomerAddrID + "," 
                    + rFI_IR_PIR.BillingCurrencyID + "," 
                    + rFI_IR_PIR.CreditDays + "," 
                    + rFI_IR_PIR.LOC +",'" 
                    + rFI_IR_PIR.ConfirmEmailID + "'," 
                    + rFI_IR_PIR.MilestoneID + "," 
                    + rFI_IR_PIR.ContractID + ",'" 
                    + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.RFIHeader)) + "'," 
                    + rFI_IR_PIR.SalesPeriodID + ",'" 
                    + rFI_IR_PIR.CreatorOrModifier + "','" 
                    + rFI_IR_PIR.InvoiceDate + "'";
                object Result = CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString);

                //Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status
                if (rFI_IR_PIR.Status == "Rejected")
                {
                     strSQL = "EXEC usp_Whizible2_Upd_tbl_PM_RFIs_ChangeRFIStatus " + Result + "," + rFI_IR_PIR.ProjectID + ",'Rejected',NULL," + rFI_IR_PIR.CreatorOrModifier + "";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }
                else
                {
                     strSQL = "EXEC usp_Whizible2_Upd_tbl_PM_RFIs_ChangeRFIStatus " + Result + "," + rFI_IR_PIR.ProjectID + ",'Draft',NULL," + rFI_IR_PIR.CreatorOrModifier + "";
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                }
                //End of Modified by Vishal on 25/12/23 to update Rejected status, as it is updating only Draft status

                // if (rFI_IR_PIR.SalesPersonIDs !="" && rFI_IR_PIR.SalesPersonIDs != ",")
                if (rFI_IR_PIR.SalesPersonIDs != "")
                {
                    strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_RFI_SalesPersons_SaveAll " + Result + "," + rFI_IR_PIR.ProjectID + ",'," + rFI_IR_PIR.SalesPersonIDs + ",','" + rFI_IR_PIR.CreatorOrModifier + "'";
                }
                else
                {
                    strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_RFI_SalesPersons_SaveAll " + Result + "," + rFI_IR_PIR.ProjectID + ", ', ' , '" + rFI_IR_PIR.CreatorOrModifier + "'";
                }
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_RFI_Tools_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.ProjectID)) + ",',','" + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.CreatorOrModifier)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                strSQL = "EXEC usp_Whizible2_Ins_tbl_PM_RFI_OS_SaveAll " + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.ProjectID)) + ",',','" + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.CreatorOrModifier)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                WorkingDaysParameter Information = new WorkingDaysParameter();
                IDataReader CmpInformation;
                if (Result != "0")
                {

                    CmpInformation = CommonFunctions.Data.GetDataReader("usp_Whizible2_Sel_tbl_PM_RFIs_Status " + HttpUtility.UrlDecode(Convert.ToString(Result)), true, CommonController.connectionString);
                    if (CmpInformation.Read())
                    {
                        Information.m_intChecklistID = Convert.ToString(CmpInformation["ChecklistID"]);
                        Information.m_intChecklistInstanceID = CommonFunctions.Data.CheckIsDBNull(CmpInformation["ChecklistInstanceID"], "0").ToString();
                        Information.RFID = Convert.ToInt32(Result);
                    }

                }
                return Information;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            //return Result;
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetIrDetails([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_RFIs_Status " + rFI_IR_PIR.RFID;
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetSalesPerson([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string strSQL = "EXEC usp_Whzible2_Sel_tbl_PM_RFI_SalesPersons " + rFI_IR_PIR.RFID;
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIItemsDetail([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string strSQL = "";
                if (rFI_IR_PIR.RFIItemID == 0)
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_RFI_Items NULL," + rFI_IR_PIR.RFID;
                }
                else
                {
                    strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_RFI_Items " + rFI_IR_PIR.RFIItemID;
                }
                DataTable result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
         Created By : Vishal Mane
         Created Date : 05/10/2023
         Purpose : To insert selected RFIChecklistItems
         */
        [HttpPost]
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        public object SaveRFIChecklistItems([FromBody] /*RFI_CheckList_Items*/ RFI_IR_PIR RequestParameters)
        {
            string strtResult = string.Empty;

            try
            {
                string strSQL;
                strSQL = "Exec usp_Ins_tbl_PM_RFIChecklistInstances_Items " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistInstanceItemID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistInstanceID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistItemID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistItemResponse)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ChecklistComment)) + "', '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.CreatedBy)) + "'";
                strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

            return Request.CreateResponse(HttpStatusCode.OK, strtResult);
        }



        /*
        Created By : Vishal Mane
        Created Date : 07/11/2023
        Purpose : To delete filter 
        */
        [HttpPost]
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object GetChecklistInstanceID([FromBody] RFI_CheckList_Items RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_RFIChecklistInstance '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistInstanceID)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.InvoiceID)) + "'";

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetMileStones([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Whizible2_Sel_milestones " + Parameters.ProjectID + "," + Parameters.RFIID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveMileStones([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {

                string strSQL = "";
                string strResult = string.Empty;
                strSQL = "";

                strSQL = "usp_Whizible2_INS_tbl_PM_RFI_ItemswithMilestone " + Parameters.RFIID + ",'" + Parameters.MileStoneID + "'";
                strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                if (strResult != null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, strResult);
                }

                return Request.CreateResponse(HttpStatusCode.OK, strResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDeliverables([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec Usp_Whizible2_Sel_RFIDeliverables " + Parameters.ProjectID + "," + Parameters.RFIID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveProjectDeliverables([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                string strResult = string.Empty;

                strSQL = "";

                strSQL = "usp_Whizible2_INS_tbl_PM_RFI_ItemswithDeliverable " + Parameters.RFIID + ",'" + Parameters.DeliverableID + "'";
                strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                if (strResult != null)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, strResult);
                }

                return Request.CreateResponse(HttpStatusCode.OK, strResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ShowProjectExpense([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_ProjectExpenses_IR " + Parameters.ProjectID + "," + Parameters.RFIID + "," + Parameters.intCurrencyID + "," + Parameters.intCostHeadID + "," + Parameters.intResourceID + "," + Parameters.Flag + "";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                strSQL = "Exec usp_Whizible2_Sel_ProjectExpenses_IR_CurrencyWise_Total " + Parameters.ProjectID + "," + Parameters.RFIID + "," + Parameters.intCurrencyID + "," + Parameters.intCostHeadID + "," + Parameters.intResourceID + "," + Parameters.Flag + "";

                DataTable dataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);


                strSQL = "Exec usp_Whizible2_Sel_ProjectExpenses_IR_Total " + Parameters.ProjectID + "," + Parameters.RFIID + "," + Parameters.intCurrencyID + "," + Parameters.intCostHeadID + "," + Parameters.intResourceID + "," + Parameters.Flag + "";

                DataTable data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                // Return an anonymous object with both DataTables
                return new
                {
                    ProjectExpenses = dt,
                    ProjectExpensesCurrencyWiseTotal = dataTable,
                    ProjectExpensesTotal = data
                };
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCurrencyType([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectExpenses_Currency " + Parameters.ProjectID + ", " + Parameters.RFIID + "";
                DataTable CurrencyCode = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return CurrencyCode;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
        [Authorize]
        public object GetProExpStatusType([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "usp_Whizible2_Sel_ProjectExpenses_StatusHeader";
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResources([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_ProjectResources " + Parameters.ProjectID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCostHeads([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_ProjectExpenses_Currency_CostHead " + Parameters.ProjectID + ", " + Parameters.RFIID + "";


                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateExpenseCurrencyIDs([FromBody] RFI_IR_PIR Parameters)
        {
            string strSQL = "";
            string strResult = string.Empty;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_Exp_Base_CurrencyConversion '" + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceConversionDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(Parameters.ExpencesCurrencyIDs)) + "','" + Parameters.CorpBaseCurrencyID + "'," + Parameters.ProjectID + "," + Parameters.RFIID + "";
                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public HttpResponseMessage SaveProExpences([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                string strResult = string.Empty;

                strSQL = "";

                strSQL = "usp_Whizible2_Ins_ProjectExpenses_RFIItems " + Parameters.ProjectID + "," + Parameters.RFIID + ",'" + Parameters.ExpensesEntryIDs + "'," + Parameters.CreatedBy + "";
                strResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return Request.CreateResponse(HttpStatusCode.OK, strResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ShowHistory([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Whizible2_Sel_RFIs_AuditTrail " + Parameters.ProjectID + "," + Parameters.RFIID + "," + Parameters.UserId + ",'" + Parameters.FieldName + "'";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetModifiedField([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_IR_PIR_ModifiedField " + Parameters.ProjectID + ", " + Parameters.RFIID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetModifiedBy([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_IR_PIR_ModifiedBy " + Parameters.ProjectID + ", " + Parameters.RFIID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIDetails([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                string TotalAmount = "";
                DataTable dt = new DataTable();
                List<RFIAmount> Parameter = new List<RFIAmount>();

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIs_Status " + Parameters.RFIID + "";

                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFI_Items_Amount_Sum " + Parameters.RFIID + "";
                // TotalAmount = string.Format("{0:0.00}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0")));
                //TotalAmount = string.Format("{0:N3}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0")));
                TotalAmount = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString), "0"));

                foreach (DataRow opRow in dt.Rows)
                {


                    RFIAmount IRPIRItemDetails = new RFIAmount()
                    {

                        //CompanyBaseCurrencyAmount = string.Format("{0:0.00}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(opRow["CompanyBaseCurrencyAmount"], "0"))),
                        //BaseCurrencyAmount = string.Format("{0:0.00}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(opRow["BaseCurrencyAmount"], "0"))),

                        //CompanyBaseCurrencyAmount = string.Format("{0:N3}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(opRow["CompanyBaseCurrencyAmount"], "0"))),
                        CompanyBaseCurrencyAmount =  Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["CompanyBaseTotalCurrencyAmount"], "0")),
                       // BaseCurrencyAmount = string.Format("{0:N3}", Convert.ToDecimal(CommonFunctions.Data.CheckIsDBNull(opRow["BaseCurrencyAmount"], "0"))),
                        BaseCurrencyAmount =  Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["BaseCurrencyTotalAmount"], "0")),
                        TotalAmountINR = TotalAmount
                    };
                    Parameter.Add(IRPIRItemDetails);
                }

                return Parameter;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetOrderNumbers([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_sel_tbl_PM_RFI_Items_OrderNumber " + Parameters.RFIID + "," + Parameters.OrderNum + "";

                //   DataTable dt = new DataTable();
                DataTable OrderNum = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return OrderNum;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetNextOrderNumber([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFI_Items_GetNextOrderNumber " + Parameters.RFIID + "";

                //   DataTable dt = new DataTable();
                int OrderNum = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return OrderNum;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIItemAttributes([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFITypes_ItemAttributes " + Parameters.RFITypeID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetProjectSettingsDetails([FromBody] RFI_ProjectSettingsDetails projectSettingsDetails)
        {

            try
            {
                string strQuery = "";
                DataTable dt;
                List<RFI_ProjectSettingsDetails> PrjSettingsDetails = new List<RFI_ProjectSettingsDetails>();

                strQuery = "usp_Whizible2_sel_tbl_PM_Project_TaskCaseStructure " + projectSettingsDetails.ProjectID.ToString();

                dt = CommonFunctions.Data.GetDataTable(strQuery, true, CommonController.connectionString);

                foreach (DataRow opRow in dt.Rows)
                {
                    RFI_ProjectSettingsDetails projectSettings = new RFI_ProjectSettingsDetails()
                    {
                        UseActivities = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["HaveSubTaskTypes"], "False")),
                        ApplyEffortDistribution = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["ApplyEffortDistribution"], "False")),
                        LocationID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["LocationID"], "0")),
                        ProjectStartDate = CommonFunctions.Dates.GetDate(Convert.ToDateTime(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedStartDate"], "")))),
                        ProjectEndDate = CommonFunctions.Dates.GetDate(Convert.ToDateTime(Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["ExpectedEndDate"], "")))),
                        HaveSubTaskTypes = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["HaveSubTaskTypes"], "False")),
                        ResourceValidation = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["ResourceValidation"], "False")),
                        IsBillable = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["Billable"], "False")),
                        ISProjectActive = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(opRow["Over"], "False")),
                    };
                    PrjSettingsDetails.Add(projectSettings);
                }

                return PrjSettingsDetails;
                //  CommonFunctions.Data.DisposeDataReader(drProjectSettings);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }







        [HttpPost]
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsUpdRFIItems([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                if (Parameters.RFIItemID == 0)
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_RFI_Items NULL," + Parameters.RFIID + ",'" + Parameters.ItemDesc + "'," + Parameters.Quantity + "," + Parameters.Rate + ",'" + Parameters.CustomField1 + "','" + Parameters.CustomField2 + "','" + Parameters.CustomField3 + "','" + Parameters.CustomField4 + "'," + Parameters.OrderNum + "," + Parameters.BaseCurrencyAmount + ",0, " + Parameters.BillingToBaseConversionRate + ",0," + Parameters.CompanyBaseCurrencyAmount + "," + Parameters.CompanyBaseCurrencyConversionRate + "," + Parameters.CreatedBy + "," + Parameters.IsDiscount + "," + Parameters.Amount + "";
                }
                else
                {
                    strSQL = "Exec usp_Whizible2_Ins_tbl_PM_RFI_Items " + Parameters.RFIItemID + "," + Parameters.RFIID + ",'" + Parameters.ItemDesc + "'," + Parameters.Quantity + "," + Parameters.Rate + ",'" + Parameters.CustomField1 + "','" + Parameters.CustomField2 + "','" + Parameters.CustomField3 + "','" + Parameters.CustomField4 + "'," + Parameters.OrderNum + "," + Parameters.BaseCurrencyAmount + ",0, " + Parameters.BillingToBaseConversionRate + ",0," + Parameters.CompanyBaseCurrencyAmount + "," + Parameters.CompanyBaseCurrencyConversionRate + "," + Parameters.CreatedBy + "," + Parameters.IsDiscount + "," + Parameters.Amount + "";
                }

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ShowTimeSheet([FromBody] RFI_IR_PIR Parameters)
        {

            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_TimeSheetInvoice_Details " + Parameters.ProjectID +"," + Parameters.RFIID;

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetTimesheetDetails([FromBody] RFI_IR_PIR Parameters)
        {

            try
            {
                string strSQL = ""; 
                strSQL = "Exec USP_Whizible2_Sel_Tbl_TimeSheetInvoiceAdvise '" + Parameters.TimeSheetIDs+"' ";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object InsertTimeSheet([FromBody] RFI_IR_PIR Parameters)
        {

            try
            {
                string strSQL = "";
                string Result = "";
                strSQL = "Exec usp_Whizible2_Ins_PrjTimesheet_RFIItems " + Parameters.ProjectID + "," + Parameters.RFIID + ",'" + Parameters.AdvisedIDs + "','" + Parameters.CreatedBy + "'";

                Result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

                return Result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }



        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteIRPIRItems([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Del_tbl_PM_RFI_Items '" + RequestParameters.RFIItemIDs + "'";

                DataTable result = new DataTable();
                result = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return result;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }







        /*
       Created By : Vishal Mane
       Created Date : 11/11/2023
       Purpose : To printIR Report and Invoice Report for selected IR/PIR.
       */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ExportToReport([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                string strFilePath;
                string m_strFileName = "";
                long m_ReportID = 802;
                int lngDefaultLCID;
                int lngCurrentThreadUICultureID;

                lngDefaultLCID = 1033;
                lngCurrentThreadUICultureID = 1033;
                string CompanyName = "";
                int DateFormatID = 0;
                AdHocReports.Report.AdHocReport oRpt;
                IDataReader drReport;

                strSQL = "usp_CRW_Invoice_Main " + HttpUtility.UrlDecode(Convert.ToString(Parameters.InvoiceNumber));

                drReport = CommonFunctions.Data.GetDataReader(strSQL, true, CommonController.connectionString);
                if (drReport.Read())
                {
                    CommonEngines.HashTables.Culture.ConnectionString = CommonController.connectionString;
                    CommonEngines.HashTables.Culture.FillCultureHashTable();
                    strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../Reports/"));
                    m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName().Trim();
                    switch (Parameters.ReportFormat)
                    {
                        case "PDF": m_strFileName += ".pdf"; break;
                        case "HTML": m_strFileName += ".htm"; break;
                        case "RTF": m_strFileName += ".rtf"; break;
                        case "EXCEL": m_strFileName += ".xls"; break;
                        case "CSV": m_strFileName += ".csv"; break;
                        case "TEXT": m_strFileName += ".txt"; break;
                        case "XML": m_strFileName += ".xml"; break;
                        default: m_strFileName += ".pdf"; break;
                    }
                    IDataReader drCompInfo = CommonFunctions.Data.GetSQLDataReader("usp_SEL_Tbl_PM_CompanyInformation", CommonController.connectionString);

                    while (drCompInfo.Read())
                    {
                        CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompInfo["CompanyName"], "").ToString();
                        DateFormatID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(drCompInfo["DateFormatID"], "0"));
                    }

                    oRpt = new AdHocReports.Report.AdHocReport(m_ReportID, strSQL, CommonController.connectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Log/")));

                    oRpt.UseMSSQL = true;
                    oRpt.DefaultLCID = lngDefaultLCID;
                    oRpt.LCID = lngCurrentThreadUICultureID;

                    oRpt.UseHashTables = true;

                    oRpt.DateFormat = DateFormatID;
                    oRpt.CompanyName = CompanyName;
                    oRpt.GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../../Images/");
                    AdHocReports.HashTables.CreateHashTables.ConnectionString = CommonController.connectionString;

                    switch (Parameters.ReportFormat)
                    {
                        case "PDF": oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                        case "HTML": oRpt.GenerateReport(AdHocReports.Format.HTML); break;
                        case "RTF": oRpt.GenerateReport(AdHocReports.Format.RTF); break;
                        case "EXCEL": oRpt.GenerateReport(AdHocReports.Format.EXCEL); break;
                        case "CSV": oRpt.GenerateReport(AdHocReports.Format.CSV); break;
                        case "TEXT": oRpt.GenerateReport(AdHocReports.Format.TEXT); break;
                        case "XML": oRpt.GenerateReport(AdHocReports.Format.XML); break;
                        default: oRpt.GenerateReport(AdHocReports.Format.PDF); break;
                    }
                    oRpt = null;
                    return m_strFileName;
                }
                else
                    return "0";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*
       Created By : Vishal Mane
       Created Date : 08/11/2023
       Purpose : To get Invoice list for selected IR/PIR.
       */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetInvoiceList([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIInvoicesAgainstIRID " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
    Created By : Vishal Mane
    Created Date : 11/11/2023
    Purpose : To Get IR/PIR Status History
    */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIStatusHistory([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFI_StatusHistory " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 16/11/2023
        Purpose : To insert Submit IR Details  
        */
        [HttpPost]
        //[Authorize, App_Start.ValidateHeaders]
        [Authorize]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SumbitIRDetails([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strtResult;
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_RFI_StatusHistory " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Status)) + "'," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.CreatedBy)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.SubmitIRComments)) + "'";

                strtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
            //strtResult = "1";
            return Request.CreateResponse(HttpStatusCode.OK, strtResult);
        }


        /*
        Created By : Vishal Mane
        Created Date : 20/11/2023
        Purpose : To copy RFI (IR/PIR) 
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object CopyRFI([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                strSQL = "Exec usp_Ins_tbl_PM_RFIs_CopyRFI " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.CreatedBy)) + "'";

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
         Created By : Vishal Mane
         Created Date : 20/11/2023
         Purpose : To update the RFI status and insert the RFI status change history record. 
         */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object UpdateRFIStatus([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strtResult = string.Empty;
                string strSQL;
                strSQL = "Exec usp_Upd_tbl_PM_RFIs_ChangeRFIStatus " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.Status)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.SubmitIRComments)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.CreatedBy)) + "'";

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
      Created By : Vishal Mane
      Created Date : 08/11/2023
      Purpose : To delete the IR/PIR records.
      */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteIRPIR([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            List<string> results = new List<string>();

            string[] RFIIDs = RequestParameters.RFIIDs.Split(',');

            for (int i = 0; i < RFIIDs.Length; i++)
            {
                int RFIID = Convert.ToInt32(RFIIDs[i]);
                try
                {
                    strSQL = "Exec usp_Whizible2_Del_tbl_PM_RFIs " + HttpUtility.UrlDecode(Convert.ToString(RFIID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "";

                    string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                    results.Add(result);
                }
                catch (Exception ex)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                }
            }
            return results;
        }

        /*
       Created By : Vishal Mane
       Created Date : 20/11/2023
       Purpose : To set dafault filter
       */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object ApplyDefaultFilter([FromBody] RFI_IR_PIR RequestParameters)
        {

            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_RFIsApplyFilter " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.FilterID)) + "";

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*
       Created By : Vishal Mane
       Created Date : 20/11/2023
       Purpose : To set dafault filter
       */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        //[App_Start.ValidateRateLimit]   //Commented by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateDefaultFilter([FromBody] RFI_IR_PIR RequestParameters)
        {

            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Upd_tbl_PM_RFIsUpdateDefaultFilter " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFIAccessOnProject([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                //&Session("intUserID") & ",'" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",
                string query = "";
                query = "EXEC usp_Whizible2_Sel_AccessibleProject_RFIs " + rFI_IR_PIR.RFIID + "," + rFI_IR_PIR.UserId + ",'" + rFI_IR_PIR.LoginType + "',1,0,'[Over] = ''0''','ProjectName ASC' ";
                string StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(query, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
       Created By : Vishal Mane
       Created Date : 23/11/2023
       Purpose : To validate filter name
       */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateFilterName([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "usp_Whizible2_Sel_tbl_PM_RFIs_ValidateFilterName '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.FilterName)) + "'";

                String StrtResult = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return StrtResult;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /*
         Created By : Vishal Mane
         Created Date : 30/11/2023
         Purpose : To validate Project Expense currency IDs 
         */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateProjectCurrency([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            string strtResult = string.Empty;
            try
            {
                strSQL = "Exec usp_Whizible2_tbl_PM_Currency_Detail_ValidateProjectCurrencyRate '" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ExpencesCurrencyIDs)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.InvoiceConversionDate)) + "','" + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.BaseCurrencyCode)) + "'";
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ShowItemHistory([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec Usp_Whizible2_Sel_RFI_Items_AuditTrail " + Parameters.RFIID + "," + Parameters.RFIItemID + "," + Parameters.UserId + ",'" + Parameters.FieldName + "'";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetItemModifiedField([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_IR_PIR_Item_ModifiedField " + Parameters.RFIID + ", " + Parameters.RFIItemID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetItemModifiedBy([FromBody] RFI_IR_PIR Parameters)
        {
            try
            {
                string strSQL = "";

                strSQL = "Exec usp_Whizible2_Sel_IR_PIR_Items_ModifiedBy " + Parameters.RFIID + ", " + Parameters.RFIItemID + "";

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 08/11/2023
        Purpose : To get RFI Check List Instance ID
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFICheckListInstanceID([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIChecklistInstancesID " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIID)) + "," + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) + "";

                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        /*
        Created By : Vishal Mane
        Created Date : 08/11/2023
        Purpose : To get RFI Check List Instance ID
        */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetRFICheckListInstances([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIChecklistInstances " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFIChecklistInstanceID));

                DataTable dt = new DataTable();
                dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
            /*
          Created By : Ajit L 
          Created Date : 22/12/2023
          Purpose : To Timesheet Generation Date
          */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateTSGenrationDate([FromBody] RFI_IR_PIR RequestParameters)
        {
            string[] TimesheetIds = RequestParameters.TimesheetIds.Split(',');
            DataTable dt = new DataTable();

            for (int i = 0; i < TimesheetIds.Length; i++)
            {
                int TimesheetId = Convert.ToInt32(TimesheetIds[i]);
                try
                {
                   string strSQL = "Exec Usp_Whizible2_Sel_TimeSheetGenerationDate " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID)) +  "," + HttpUtility.UrlDecode(Convert.ToString(TimesheetId)) + "";

                   
                    dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                    return dt;
                }
                catch (Exception ex)
                {
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
                }
            }
            return dt;
        }

        /*
       Created By : Vishal Mane
       Created Date : 12/12/2023
       Purpose : To get current status
       */
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetCurrentStatus([FromBody] RFI_IR_PIR RequestParameters)
        {
            string strSQL;
            try
            {
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_RFIs_CurrentStatus " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.RFID));

                //DataTable dt = new DataTable();
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*
       Created By : Vishal Mane
       Created Date : 12/12/2023
       Purpose : To get RFIContract details
       */
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object ShowRFIContract([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {

            try
            {
                string query = "";
                if (rFI_IR_PIR.ContractTypeID == 0)
                {
                    query = "EXEC usp_Whizible2_sel_tbl_PM_ContractMaster " + rFI_IR_PIR.CustomerID;
                }
                else
                {
                    query = "EXEC usp_Whizible2_sel_tbl_PM_ContractMaster " + rFI_IR_PIR.CustomerID + "," + rFI_IR_PIR.ContractTypeID;
                }
                DataTable result = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        /*
     Created By : Vishal Mane
     Created Date : 12/12/2023
     Purpose : To Get Customer Name
     */
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetCustomerName([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string query = "";                
                DataTable Customer = null;
                query = "EXEC usp_Whizible2_Sel_tbl_PM_Customer_RFI " + rFI_IR_PIR.CustomerID;
                Customer = CommonFunctions.Data.GetDataTable(query, true, CommonController.connectionString);
               
                return Customer;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
     Created By : Vishal Mane
     Created Date : 12/12/2023
     Purpose : To set customer address
     */
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object SetDefaultCustomerAddress([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_Upd_tbl_PM_Customer_Addresses " + rFI_IR_PIR.CustomerID + "," + rFI_IR_PIR.CustomerAddrID;
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
        Created By : Vishal Mane
        Created Date : 12/12/2023
        Purpose : To get Billing CurrencyID,CorporateBaseCurrencyID, CompanyBaseCurrencyID
        */

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetGlobalCurrencies([FromBody] RFI_IR_PIR RequestParameters)
        {
            try
            {
                string strSQL;
                strSQL = "Exec usp_Whizible2_Validation_IR_CorporateBaseCompanyBaseBillingLocalCurrency " + HttpUtility.UrlDecode(Convert.ToString(RequestParameters.ProjectID));                
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;                
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        /*
     Created By : Vishal Mane
     Created Date : 29/12/2023
     Purpose : To set customer address
     */
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetCreditDays([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_Customer_CreditDays " + rFI_IR_PIR.CustomerID;
                string result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString));
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        } 
        
        
        
        [Authorize, App_Start.ValidateHeaders]
        [HttpPost]
        public object GetIRCurrency([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string strSQL = "";
                strSQL = "EXEC usp_Whizible2_Sel_tbl_PM_Rfis_Currency " + rFI_IR_PIR.RFIID;
                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        //Added By Riddhesh Patil


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateContractValues([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                //string IsValidateContractValues = Convert.ToString(CommonFunctions.Data.GetDataScalar("USP_Whizible2_ValidateContractValues " + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.ContractTypeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.AdvisedIDs)) + "'", true, CommonController.connectionString));
                string IsValidateContractValues = Convert.ToString(CommonFunctions.Data.GetDataScalar("USP_Whizible2_ValidateIRContractValues " + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.ContractTypeID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.AdvisedIDs)) + "',"+ HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.RFIID)) + "", true, CommonController.connectionString));
                return IsValidateContractValues;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateExpenseCurrencyValues([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                string IsValidateContractValues = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_ExpenseCurrency_Validation '" + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.ExpencesCurrencyIDs)) + "'," + rFI_IR_PIR.ProjectID, true, CommonController.connectionString));
                return IsValidateContractValues;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        } 
        
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateExpRate([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {
                

                DataTable dt = CommonFunctions.Data.GetDataTable("usp_Whizible2_Sel_ExpenseCurrency_Exists '" + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.ExpencesCurrencyIDs)) + "'," + rFI_IR_PIR.ProjectID, true, CommonController.connectionString);
                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

        
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object ValidateTimesheetRate([FromBody] RFI_IR_PIR rFI_IR_PIR)
        {
            try
            {

                string ValidateTimesheetCurrency = Convert.ToString(CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_TimesheetCurrency_Exists '" + HttpUtility.UrlDecode(Convert.ToString(rFI_IR_PIR.AdvisedIDs)) + "'," + rFI_IR_PIR.ProjectID + "," + rFI_IR_PIR.RFIID, true, CommonController.connectionString));
                return ValidateTimesheetCurrency;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


    }
}
