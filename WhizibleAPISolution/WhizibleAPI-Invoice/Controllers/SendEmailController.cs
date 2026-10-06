using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.Email;
using WhizibleAPI.Models.EmailMessages;
//using WhizibleAPI.Commonfunction.WorkFlow;

namespace WhizibleAPI.Controllers
{

    //Controller Name : SendEmail
    //Created By : Dipali V
    //Created Date : 1st Oct 2023
    public class SendEmailController : ApiController
    {
        /// <summary>
        /// Added By Dipali V For Project Timesheet , Send for approval Mail pop up
        /// </summary>
        /// <param name="sendEmailParameters"></param>
        /// <returns></returns>
        [HttpPost]
        [Authorize]
        public List<SendEmail> GetEmailMessageInfo([FromBody] SendEmailParameters sendEmailParameters)
        {
            string strFromEmailID = "";
            string strToEmailID = "";
            string strCCToEmailID = "";
            string strSubject = "", strMessage = "";
            var MSGID = sendEmailParameters.msgID;
            switch (MSGID)
            {
                case 3:
                    EmailMessagesController.GetEmailMessage_3(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.TimesheetID, sendEmailParameters.intProjectID, sendEmailParameters.LoginUserID);
                    break;
                // Added By Dipali On 7th Nov 2023 For Submit IR
                case 51:
                    EmailMessagesController.GetEmailMessage_51(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RFID, sendEmailParameters.intProjectID, sendEmailParameters.LoginUserID);
                    break;
                default:
                    break;

            }

     

            List<SendEmail> EmailMessageList = new List<SendEmail>();
            SendEmail EmailInformation = new SendEmail()
            {
                FromEmailID = strFromEmailID,
                ToEmailID = strToEmailID,
                CCToEmailID = strCCToEmailID,
                Subject = strSubject,
                Message = strMessage,
            };

            EmailMessageList.Add(EmailInformation);
            return EmailMessageList;

        }

        //Added By Dipali V On 26th Dec 2023 For Send Mail
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SendEmailMessage([FromBody] EParameters eParameters)
        {
            try
            {
                string path = HttpContext.Current.Server.MapPath("~/ErrorLog.txt");
                if (eParameters.IsAttachment == 1)
                {

                    List<string> strAttachmentlisteds = new List<string>();
                    strAttachmentlisteds.Add(HttpUtility.UrlDecode(eParameters.FileName));
                    EmailMessagesController.SendEmailWithAttachment(eParameters.strToEmailID, eParameters.strCCToEmailID, eParameters.strFromEmailID, eParameters.strSubject, eParameters.strMessage, null, strAttachmentlisteds.ToArray());
                }
                else
                {

                    EmailMessagesController.SendEmailWithCC(eParameters.strToEmailID, eParameters.strCCToEmailID, eParameters.strFromEmailID, eParameters.strSubject, eParameters.strMessage);
                }
                return "";
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }

        //End of Added By Dipali V On 26th Dec 2023 For Send Mail
        public class SendEmailParameters
        {

            public int ProjectID;
            public int RoleID;
            public int EmployeeID;
            public int msgID { get; set; }
            public int RFID { get; set; } // Added By Dipali On 7th Nov 2023 For Submit IR
            public int LoginUserID { get; set; }
            public string strTitle { get; set; }
            public string FromDate { get; set; }
            public string ToDate { get; set; }
            public int TimesheetID { get; set; }
            public int intProjectID { get; set; }
            public int intEmployeeID { get; set; }
            public string intUserID { get; set; }
            public string m_strcomments { get; set; }
            public string UserName { get; set; }

        }
        //Added By Dipali V On 26th Dec 2023 For Send Mail
        public class EParameters
        {
            public string strToEmailID { get; set; }
            public string strCCToEmailID { get; set; }
            public string strFromEmailID { get; set; }
            public string strSubject { get; set; }
            public string strMessage { get; set; }
            public int IsAttachment { get; set; }
            public string FileName { get; set; }
        }

    }

}
