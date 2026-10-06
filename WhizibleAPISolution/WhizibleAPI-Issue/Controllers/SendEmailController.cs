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
    public class SendEmailController : ApiController
    {

        //EmailMessagesController.GetEmailMessage_435(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, 468, 504,Convert.ToDateTime("1/25/2016"),Convert.ToDateTime("1/31/2016"));
        //EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
        [HttpPost]
        [Authorize]
        //public List<SendEmail> GetEmailMessageInfo([FromBody] SendEmailParameters sendEmailParameters)
        public object GetEmailMessageInfo([FromBody] SendEmailParameters sendEmailParameters)
        {
            string strFromEmailID = "";
            string strToEmailID = "";
            string strCCToEmailID = "";
            string strSubject = "", strMessage = "";
            string fileName = "";
            var MSGID = sendEmailParameters.msgID;
            var WorkFlowInstance = sendEmailParameters.WorkFlowInstance;
            try
            {
                switch (MSGID)
                {


                    
                    //End of sonata customization 27-12-2022
                    //added by dipali V on 5th Dec 2022 For Copy to issue From HD
                    case 20004:
                        EmailMessagesController.GetEmailMessage_20004(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId, sendEmailParameters.ShowToCustomer, sendEmailParameters.LoginType, sendEmailParameters.Comments, sendEmailParameters.IssueID, sendEmailParameters.ProjectID, sendEmailParameters.StrUserName, sendEmailParameters.LoginUserID);
                        break;
                    case 20003:
                        EmailMessagesController.GetEmailMessage_20003(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId, sendEmailParameters.ShowToCustomer, sendEmailParameters.LoginType, sendEmailParameters.Comments, sendEmailParameters.IssueID, sendEmailParameters.ProjectID, sendEmailParameters.StrUserName, sendEmailParameters.LoginUserID);
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

                //end by vishal Mahajan 10-12-2019
                EmailMessageList.Add(EmailInformation);
                return EmailMessageList;
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }
        [HttpPost]
        [Authorize, App_Start.ValidateHeaders]
        public object SendEmailMessage([FromBody] EParameters eParameters)
        {
            try
            {
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

      

       
    }
    public class SendEmailParameters
    {
      
        public int WorkFlowInstance;
        public int msgID { get; set; }
      
        public string intRequestID { get; set; }
        public string Comments { get; set; }
        public string LoginType { get; set; }
        public string StrUserName { get; set; }
        public int OpportunityID { get; set; }
        public int RequestId { get; set; }
        public int ProjectID { get; set; }
        public int IssueID { get; set; }
        public int LoginUserID { get; set; }
        public string FileName { get; set; }
        public string ShowToCustomer { get; set; }
        //blic string ShowToCustomer { get; set; }
        public string strResourceRequestID { get; set; }
        public string intProjectEmployeeRoleID { get; set; }
        public int intProjectID { get; set; }
        public int intEmployeeID { get; set; }
        public string strProjectID { get; set; }
        public string intUserID { get; set; }
        public string strEmployeeID { get; set; }
    }


    public class EParameters
    {
        public string strToEmailID { get; set; }
        public string strCCToEmailID { get; set; }
        public string strFromEmailID { get; set; }
        public string strSubject { get; set; }
        public string strMessage { get; set; }
        //start by vishal Mahajan 10-12-2019
        //public bool IsAttachment { get; set; }
        public int IsAttachment { get; set; }

        public string FileName { get; set; }
        //end by vishal Mahajan 10-12-2019
    }


}
