using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Net;
using System.Net.Http;
using System.Configuration;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.IO;
using System.Xml;

namespace WhizibleAPI.Controllers
{
    public class IssueToCopyController : ApiController
    {
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object GetDetails([FromBody] HDDetails HDParameters)
        {

            try
            {
                var strSQL = "";
                strSQL = "EXEC usp_Whizible2_SEL_TBL_CRM_QUERY_MASTER_CRMQueryID " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + "";
                DataTable dt;
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
        public object GetDiscussionDetails([FromBody] HDDetails HDParameters)
        {
            try
            {
                var strSQL = "";
                strSQL = "EXEC usp_Whizible_Sel_CRM_Discussions_Copy " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + "";
                DataTable dt;
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
        public object GetAttachmentDetails([FromBody] HDDetails HDParameters)
        {
            try
            {
                var strSQL = "";
                strSQL = "EXEC USP_Whizible2_SEL_tbl_crm_attachments_Copy " + HttpUtility.UrlDecode(Convert.ToString(HDParameters.CRMRequestID)) + "";
                DataTable dt;
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
        public object CopyToIssue([FromBody] HDDetails HDParameters)
        {
            string strSQLAttachment = "";
            string strSQLDiscussion = "";
            string result = "";
            string Flag = "0";
            bool blnSendEmail, blnShowPopup;
            try
            {

                if (HDParameters.Mode == "CopyToIssue")
                {
                    if (HDParameters.AttachementList != "")
                    {
                        strSQLAttachment = "EXEC USP_Whizible2_INS_TBL_IB_Attachment_Copy " + HDParameters.CRMRequestID + "," + HDParameters.IssueID + "," + HDParameters.UserID + ",'" + HDParameters.AttachementList + "'";
                        result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLAttachment, true, CommonController.connectionString));
                        
                    }
                    if (HDParameters.CommentsList != "")
                    {
                        if (HDParameters.IsSeparatelyCopyDiscussion != "True") {
                            strSQLDiscussion = "EXEC USP_Whizible2_INS_TBL_IB_ISSUE_DISCUSSION " + HDParameters.IssueID + ",'" + HDParameters.comments + "'," + HDParameters.UserID + "";
                            result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLDiscussion, true, CommonController.connectionString));
                        }
                        else {
                            //string[] arrCommentsList = HDParameters.CommentsList.ToString().Split(',');
                            //string[] arrCommentsList = HDParameters.CommentsList.ToString().Split('$');
                            string[] arrCommentsList = HDParameters.CommentsList.Split(new string[] { "$$****$$," }, StringSplitOptions.None);

                            foreach (var itemComments in arrCommentsList)
                            {
                                if (itemComments != null && !string.IsNullOrEmpty(itemComments))
                                {
                                    strSQLDiscussion = "EXEC USP_Whizible2_INS_TBL_IB_ISSUE_DISCUSSION " + HDParameters.IssueID + ",'" + itemComments + "'," + HDParameters.UserID + "";
                                    result = Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQLDiscussion, true, CommonController.connectionString));
                                }
                            }
                        }
                       
                   }

                    DataTable EmailDataTable = CommonFunctions.Data.GetDataTable("usp_Sel_tbl_PM_EmailMessages 20004", true, CommonController.connectionString);
                    foreach (DataRow mailRow in EmailDataTable.Rows)
                    {
                        blnSendEmail = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["SendMail"], "0"));
                        blnShowPopup = Convert.ToBoolean(CommonFunctions.Data.CheckIsDBNull(mailRow["ShowPopup"], "0"));

                     
                        if (blnSendEmail == true)
                        {
                            //Call CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_20004(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestID"), 0), 1, HttpContext.Current.Session("LoginType").ToString, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Comments"), 0), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueID"), 0), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), 0))
                            //EmailMessagesController.GetEmailMessage_20047(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, Convert.ToInt32(Message), Convert.ToInt32(ProjectID));

                            if (blnShowPopup == true)
                            {
                                Flag = "1";
                            }
                        }
                    }
                }
                else { 
                
                }

                return Flag;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }


    }
    public class HDDetails
    {
        public string ProjectID { get; set; }
        public string CRMRequestID { get; set; }
        public string Mode { get; set; }
        public string IssueID { get; set; }
        public string comments { get; set; }
        public string UserID { get; set; }
        public string LoginType { get; set; }
        public string AttachementList { get; set; }
        public string CommentsList { get; set; }
        public string ShowToCustomer { get; set; }
        public string IsSeparatelyCopyDiscussion { get; set; }

    }
}