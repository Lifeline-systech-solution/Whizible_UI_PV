using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models;
using System.Web.Http;
using System.Web;
using System.IO;
using System.Configuration;
using System.Xml;
using Newtonsoft.Json;

namespace WhizibleAPI.Controllers
{
    public class SM_AvancedSettingController : ApiController
    {
        ////Get Resource Allocation Level
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetResourceAllocationLevel([FromBody] GetRAL GetResourceAllocationLevel)
        {
            try
            {
                string strSQL = "";
                string strSQLSem = "";

                strSQL = "Exec usp_Whizible2_tbl_PM_CompanyInformation_ResourceAllocationLevel 'RESOURCE_ALLOCATION'";
                System.Data.DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object InsertResourceAllocationLevel([FromBody] GetRAL GetResourceAllocationLevel)
        {
            try
            {
                string strSQL = "";
                string StrSQL_SEM = "";

                StrSQL_SEM = "Exec usp_ins_tbl_pm_companyinformation_SM_AdvancedSettings_History '" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourceAllocationLevel)) + "'," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.AllowResourceAllocation)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourcePool)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.UserName)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(StrSQL_SEM, true, CommonController.connectionString);


                strSQL = "Exec usp_Upd_Whizible2_tbl_PM_CompanyInformation_ResourceAllocationLevel '" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourceAllocationLevel)) + "'," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.AllowResourceAllocation)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourcePool));
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                strSQL = "Exec usp_upd_tbl_SEM_Settings " + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourceAllocationValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourcePool)) + ",0,0,0,0";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                return "Resource Allocation Workflow Settings Saved Successfully";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SaveWeightedAverageDetails([FromBody] GetRAL GetResourceAllocationLevel)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Upd_tbl_Whizible2_PM_ProjectSettings_AdvancedSetting " + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.Cost)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.Schedule)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.Efforts)) + "";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                strSQL = "Exec usp_Upd_tbl_tbl_Whizible2_PM_ThresholdValues '" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.CostOnTrack)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ScheduletOnTrack)) + "','"
                    + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.EffortsOnTrack)) + "','" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.CostWarning)) + "', '" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ScheduleWarning)) + "','" +

                    "" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.EffortsWarning)) + "','" +

                    "" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.CostOffTrack)) + "','" +

                    "" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ScheduleOffTrack)) + "','" +

                    "" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.EffortsOffTrack)) + "','" +

                    "" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.UserName)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);

                return "Weighted Average Details Saved Successfully";

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }




        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object InsertResourceAllocation([FromBody] GetRAL GetResourceAllocationLevel)
        {
            try
            {
                string strSQL = "";
                string StrSQL_SEM = "";
                StrSQL_SEM = "Exec usp_ins_SEM_Settings_tbl_Whizible2_SM_AdvancedSettings_History " + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourceAllocationValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourcePool)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.UserName)) + "'";
                CommonFunctions.Data.InsertOrUpdateData(StrSQL_SEM, true, CommonController.connectionString);


                strSQL = "Exec usp_upd_tbl_SEM_Settings " + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourceAllocationValue)) + "," + HttpUtility.UrlDecode(Convert.ToString(GetResourceAllocationLevel.ResourcePool)) + ",0,0,0,0";
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);





                return "Resource Allocation Percentage Saved Successfully";


            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        }

    public class GetRAL
    {
        public string ResourceAllocationLevel { get; set; }
        public string AllowResourceAllocation { get; set; }
        public string ResourcePool  { get; set; }
        public string Cost { get; set; }
        public string Schedule { get; set; }
        public string Efforts { get; set; }
        public string ResourceAllocationValue { get; set; }


        public string CostOnTrack { get; set; }
        public string ScheduletOnTrack { get; set; }
        public string EffortsOnTrack { get; set; }


        public string CostWarning { get; set; }
        public string ScheduleWarning { get; set; }
        public string EffortsWarning { get; set; }



        public string CostOffTrack { get; set; }
        public string ScheduleOffTrack { get; set; }
        public string EffortsOffTrack { get; set; }
        public string UserName { get; set; }


    }
}
