using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.PM;

namespace WhizibleAPI.Controllers
{
    
    public class PM_ProjectKeywordsController : ApiController
    {
        private int TagID = 531;

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        ////public List<PM_ProjectKeywords> GetProjectKeywords([FromBody] ProjectKeywordParameters projectKeywordParameters)
        public object GetProjectKeywords([FromBody] ProjectKeywordParameters projectKeywordParameters)

        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_Sel_tbl_IB_Project_Keywords " + projectKeywordParameters.ProjectID;
                List<PM_ProjectKeywords> lstKeywords = new List<PM_ProjectKeywords>();
                DataTable OpTable;
                OpTable = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
                foreach (DataRow opRow in OpTable.Rows)
                {
                    PM_ProjectKeywords keywords = new PM_ProjectKeywords
                    {
                        ProjectKeywordID = Convert.ToInt32(CommonFunctions.Data.CheckIsDBNull(opRow["ProjectKeywordID"], "")),
                        Keyword = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(opRow["Keyword"], ""))
                    };
                    lstKeywords.Add(keywords);
                }
                return lstKeywords;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object DeleteProjectKeywords([FromBody] ProjectKeywordParameters projectKeywordParameters)
        {
            try
            {
                var list = projectKeywordParameters.selectedList.Split(',');
                string result = "";
                for (int i = 0; i < list.Length; i++)
                {
                    string strSQL = "EXEC usp_Whizible2_Del_tbl_IB_Project_KeyWords " + list[i] + "," + projectKeywordParameters.ProjectID;
                    var res = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);
                    result += res.ToString() + ", ";
                }
                return result;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //Added by imran on 16-09-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by imran on 16-09-2022
        [HttpPost]
        [App_Start.ValidateRateLimit]   //Added by Vishal Mane on 03/06/2026 for Rate Limiting 
        public object AddEditProjectKeywords([FromBody] ProjectKeywordParameters projectKeywordParameters)
        {
            try
            {
                string strSQL = "EXEC usp_Whizible2_INS_tbl_IB_Project_Keywords " + projectKeywordParameters.ProjectKeywordID + "," + projectKeywordParameters.ProjectID + ",'" + projectKeywordParameters.ProjectKeyword.Replace("'", "''") + "','" + projectKeywordParameters.UserName + "'";
                var result = CommonFunctions.Data.GetDataScalar(strSQL, true, CommonController.connectionString);

                return result.ToString();
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        }

    public class ProjectKeywordParameters
    {
        public int intEmployeeID { get; set; }
        public int ProjectID { get; set; }
        public string LoginType { get; set; }
        public int ProjectKeywordID { get; set; }
        public string ProjectKeyword { get; set; }
        public string UserName { get; set; }
        public string selectedList { get; set; }
    }
}
