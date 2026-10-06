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
                    //Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose(IntQueryMessageID == 51)
                    case 51:
                        EmailMessagesController.GetEmailMessage_51(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RFIID, sendEmailParameters.ProjectID, sendEmailParameters.intEmployeeID);
                        break;
                    //End of Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose
                    case 55:
                        EmailMessagesController.GetEmailMessage_55(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RFIID, sendEmailParameters.ProjectID, sendEmailParameters.intEmployeeID);
                        break;
                    //End of Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose

                    case 15:
                        EmailMessagesController.GetEmailMessage_15(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intProjectEmployeeRoleID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID, Convert.ToString(sendEmailParameters.intEmployeeID));
                        break;
                    case 16:
                        EmailMessagesController.GetEmailMessage_16(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intProjectEmployeeRoleID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        break;
                    case 203:
                        EmailMessagesController.GetEmailMessage_203(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strEmployeeID, sendEmailParameters.intRequestID);
                        break;
                    case 503:
                        EmailMessagesController.GetEmailMessage_503(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intRequestID, sendEmailParameters.strEmployeeID, sendEmailParameters.intUserID);
                        break;
                    case 75:
                        EmailMessagesController.GetEmailMessage_75(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intRequestID);
                        break;
                    case 76:
                        EmailMessagesController.GetEmailMessage_76(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intRequestID, sendEmailParameters.strEmployeeID, sendEmailParameters.intUserID);
                        break;
                    case 498:
                        EmailMessagesController.GetEmailMessage_498(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strResourceRequestID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        break;
                    case 80:
                        EmailMessagesController.GetEmailMessage_80(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strResourceRequestID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        break;

                    //sonata Customization 27-12-2022
                    case 426:
                        EmailMessagesController.GetEmailMessage_426(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.RequestId);
                        break;
                    case 427:
                        EmailMessagesController.GetEmailMessage_427(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.RequestId);
                        break;
                    case 430:
                        EmailMessagesController.GetEmailMessage_430(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.RequestId);
                        break;
                    case 432:
                        EmailMessagesController.GetEmailMessage_432(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.RequestId);
                        break;
                    case 541:
                        EmailMessagesController.GetEmailMessage_541(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.RequestId);
                        break;
                    case 542:
                        EmailMessagesController.GetEmailMessage_542(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId);
                        break;
                    case 543:
                        EmailMessagesController.GetEmailMessage_543(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId);
                        break;
                    case 539:
                        EmailMessagesController.GetEmailMessage_539(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.RequestId);
                        break;
                    case 499:
                        EmailMessagesController.GetEmailMessage_499(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId, sendEmailParameters.intEmployeeID);
                        break;
                    case 502:
                        EmailMessagesController.GetEmailMessage_502(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId, sendEmailParameters.intEmployeeID);
                        break;
                    //End of sonata customization 27-12-2022
                    //added by dipali V on 5th Dec 2022 For Copy to issue From HD
                    case 20004:
                        EmailMessagesController.GetEmailMessage_20004(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId, sendEmailParameters.ShowToCustomer, sendEmailParameters.LoginType, sendEmailParameters.Comments, sendEmailParameters.IssueID, sendEmailParameters.ProjectID, sendEmailParameters.StrUserName, sendEmailParameters.LoginUserID);
                        break;
                    case 20003:
                        EmailMessagesController.GetEmailMessage_20003(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.RequestId, sendEmailParameters.ShowToCustomer, sendEmailParameters.LoginType, sendEmailParameters.Comments, sendEmailParameters.IssueID, sendEmailParameters.ProjectID, sendEmailParameters.StrUserName, sendEmailParameters.LoginUserID);
                        break;
                         case 35009:
                        EmailMessagesController.GetEmailMessage_35009(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.EmployeeID, sendEmailParameters.ProjectID, sendEmailParameters.RequestId.ToString());
                        break;
                    case 35010:
                        EmailMessagesController.GetEmailMessage_35010(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.EmployeeID, sendEmailParameters.ProjectID, sendEmailParameters.RequestId.ToString());
                        break;
                    case 35011:
                        EmailMessagesController.GetEmailMessage_35011(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.EmployeeID, sendEmailParameters.ProjectID, sendEmailParameters.RequestId.ToString());
                        break;
                    //Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
                    case 35013:
                        EmailMessagesController.GetEmailMessage_35013(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID);
                        break;                    

                    case 35014:
                        EmailMessagesController.GetEmailMessage_35014(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.strEmployeeID);
                        break;
                    case 35015:
                        EmailMessagesController.GetEmailMessage_35015(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.strEmployeeID);
                        break;
                    case 35016:
                        EmailMessagesController.GetEmailMessage_35016(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID);
                        break;
                    case 35017:
                        EmailMessagesController.GetEmailMessage_35017(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.strEmployeeID);
                        break;
                    case 35018:
                        EmailMessagesController.GetEmailMessage_35018(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intEmployeeID, sendEmailParameters.strEmployeeID);
                        break;
                    default:
                        break;
                        //End of Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration


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
        [Authorize]
        public object SendEmailMessage([FromBody] EParameters eParameters)
        {
            try
            {
                if (eParameters.IsAttachment)
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
        public int RFIID { get; set; }
        public int EmployeeID { get; set; }
         public string Remark { get; set; }
    }


    public class EParameters
    {
        public string strToEmailID { get; set; }
        public string strCCToEmailID { get; set; }
        public string strFromEmailID { get; set; }
        public string strSubject { get; set; }
        public string strMessage { get; set; }
        //start by vishal Mahajan 10-12-2019
        public bool IsAttachment { get; set; }
        public string FileName { get; set; }
        //end by vishal Mahajan 10-12-2019
    }


}
