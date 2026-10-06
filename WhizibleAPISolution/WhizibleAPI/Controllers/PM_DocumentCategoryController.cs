using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    public class PM_DocumentCategoryController : ApiController
    {

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        ////End of comment by imran on 12-09-2022
        public object GetDocCategoryList([FromBody] DocCategoryParameter DocCategoryPrameters)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Sel_v_tbl_PM_DocumentCategory " + HttpUtility.UrlDecode(Convert.ToString(DocCategoryPrameters.ProjectID));

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        public object GetDocCategoryID([FromBody] DocCategoryParameter DocCategoryPrameters)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Sel_tbl_PM_projectDocumentCategory_CategoryID " + HttpUtility.UrlDecode(Convert.ToString(DocCategoryPrameters.ProjectID)) + "," + HttpUtility.UrlDecode(Convert.ToString(DocCategoryPrameters.CategoryID.ToString()));

                object dt = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        [HttpPost]
        //Added by imran on 12-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 12-09-2022
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object UpdateDocCategoryDetail([FromBody] DocCategoryParameter DocCategoryPrameters)
        {
            try
            {
                string strSQL;

                strSQL = "Exec usp_Whizible2_Ins_tbl_PM_Project_DocumentCategory " + HttpUtility.UrlDecode(Convert.ToString(DocCategoryPrameters.ProjectID)) + ",'" + HttpUtility.UrlDecode(Convert.ToString(DocCategoryPrameters.CategoryIDs)) + "'";

                DataTable dt = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);

                return dt;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        }
    public class DocCategoryParameter
    {
        public int ProjectID { get; set; }
        public string CategoryIDs { get; set; }
        public int CategoryID { get; set; }
    }
}
