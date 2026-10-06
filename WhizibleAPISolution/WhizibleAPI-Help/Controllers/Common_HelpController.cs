using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    public class Common_HelpController : ApiController
    {
        string strSQL = "";

        //Added by imran on 20-01-2022
        [HttpPost]
        public HttpResponseMessage SaveLikeDislike([FromBody] HelpParameter helpParameter)
        {
            List<HelpParameter> listgradeResult = new List<HelpParameter>();
            HelpParameter gradeResult = new HelpParameter();
            strSQL = "usp_INS_tbl_Whizible2_Help_LikeDislike " + helpParameter.TagID + "," + helpParameter.EmployeeID + "," + helpParameter.Liked + "," + helpParameter.DisLiked +",'" + helpParameter.LoginType + "','" + helpParameter.IsCreatedByCustomer + "'";
            try
            {
                CommonFunctions.Data.InsertOrUpdateData(strSQL, true, CommonController.connectionString);
                DataTable ResultGradeMaster = CommonFunctions.Data.GetDataTable("usp_sel_tbl_Whizible2_Help_LikeDislike " + helpParameter.TagID + "," + helpParameter.EmployeeID + ",'" + helpParameter.LoginType + "','" + helpParameter.IsCreatedByCustomer + "'", true, CommonController.connectionString);
                if (ResultGradeMaster.Rows.Count > 0)
                {
                    foreach (DataRow dt in ResultGradeMaster.Rows)
                    {
                        gradeResult.Liked = Convert.ToInt16(CommonFunctions.Data.CheckIsDBNull(dt["Likes"], ""));
                        gradeResult.DisLiked = Convert.ToInt16(CommonFunctions.Data.CheckIsDBNull(dt["DisLikes"], ""));
                        gradeResult.comments = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(dt["Comments"], ""));
                        listgradeResult.Add(gradeResult);
                    }

                }
                return Request.CreateResponse(HttpStatusCode.OK, listgradeResult);
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }

        }
        //End by imran on 20-01-2022

        //Added by imran on 20-01-2022
        [HttpPost]
        public DataTable PostComments([FromBody] HelpParameter helpParameter)
        {
            strSQL = "usp_Ins_tbl_Whizible2_Help_PostComments " + helpParameter.TagID + "," + helpParameter.EmployeeID + ",'" + helpParameter.comments + "','"+ helpParameter.LoginType+"' ";
            DataTable Data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Data;
        }
        //End by imran on 20-01-2022

        //Added by imran on 20-01-2022
        [HttpPost]
        public DataTable GetLikeDislikeCount([FromBody]HelpParameter helpParameter)
        {
            strSQL = "Exec usp_sel_tbl_Whizible2_Help_LikeDislike " + helpParameter.TagID + "," + helpParameter.EmployeeID + ",'"+ helpParameter.LoginType + "','" + helpParameter.IsCreatedByCustomer + "' ";
            DataTable Data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Data;
        }
        //End by imran on 20-01-2022

        //Added by imran on 20-01-2022
        [HttpPost]
        public DataTable GetAllCommentByUser([FromBody]HelpParameter helpParameter)
        {
            strSQL = "Exec usp_sel_tbl_Whizible2_Help_Comments " + helpParameter.TagID + "," + helpParameter.EmployeeID + ",'" + helpParameter.LoginType + "' ";
            DataTable Data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Data;
        }
        //End by imran on 20-01-2022

        //Added by imran on 20-01-2022
        [HttpPost]
        public DataTable GetMostVisitedPages([FromBody]HelpParameter helpParameter)
        {
            strSQL = "Exec usp_sel_tbl_Whizible2_Help_MostVisitedPages ";
            DataTable Data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Data;
        }
        //End by imran on 20-01-2022

        //Added by imran on 04-02-2022
        [HttpPost]
        public DataTable GetMostVisitedLikes([FromBody]HelpParameter helpParameter)
        {
            strSQL = "Exec usp_sel_tbl_Whizible2_Help_MostLikePages ";
            DataTable Data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Data;
        }
        //End by imran on 04-02-2022

        //Added by imran on 04-02-2022
        [HttpPost]
        public DataTable GetMostRecentUpdated([FromBody]HelpParameter helpParameter)
        {
            strSQL = "Exec usp_sel_tbl_Whizible2_Help_MostRecentUpdated ";
            DataTable Data = CommonFunctions.Data.GetDataTable(strSQL, true, CommonController.connectionString);
            return Data;
        }
        //End by imran on 04-02-2022
    }
    public class HelpParameter
    {
        public int TagID { get; set; }
        public int EmployeeID { get; set; }
        public int Liked { get; set; }
        public int DisLiked { get; set; }
        public string comments { get; set; }
        public string LoginType { get; set; }
        public Boolean IsCreatedByCustomer { get; set; }
    }   
}