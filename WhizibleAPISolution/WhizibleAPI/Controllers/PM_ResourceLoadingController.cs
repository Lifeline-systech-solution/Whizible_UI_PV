using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using WhizibleAPI.Models.PM;
using System.Web;

namespace WhizibleAPI.Controllers
{
    public class PM_ResourceLoadingController : ApiController
    {

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 01-09-2022
        public object GetProjectEmployeeRoleID([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                object ProjectEmployeeRoleID;
                string strSQL = "Exec usp_Whizible2_sel_Tbl_PM_ProjectEmployeeRole_ProjectEmployeeRoleID " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.ProjectID));

                ProjectEmployeeRoleID = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return ProjectEmployeeRoleID;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetEmployeeInfo([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "";
                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_Employee_ProjectEmployeeRoleID " + ResourceParameters.ProjectEmployeeRoleID;

                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetEmployeeData([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "Exec usp_Sel_tbl_PM_Employee_ProjectEmployeeInfo " + ResourceParameters.EmployeeID;
                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetResourceData([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_ResourceLoading " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.CurrentYear)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.IsPieChart));
                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //To Get the total capa
        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetTotalCapacityOfResource([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                string strSQL = "Exec usp_Whizible2_Sel_GetYearlyTotalCapacity " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.CurrentYear)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID));
                DataTable dtable;
                dtable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return dtable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }


        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetStartMonth([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                object StartMonth;
                string strSQL = "Exec usp_Whizible2_sel_tbl_PM_companyInformation_StartMonth ";

                StartMonth = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                return StartMonth;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 01-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 01-09-2022
        public object GetResourceLoading([FromBody] ResourcesParameter ResourceParameters)
        {
            try
            {
                DataTable ResorLoadingDataTable;
                string strSQL = "Exec usp_Whizible2_Sel_ResourceLoading " + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.CurrentYear)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.EmployeeID)) + ",0," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.intUserID)) + "," + HttpUtility.UrlDecode(Convert.ToString(ResourceParameters.intRoleLevel));

                ResorLoadingDataTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                return ResorLoadingDataTable;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }
}
