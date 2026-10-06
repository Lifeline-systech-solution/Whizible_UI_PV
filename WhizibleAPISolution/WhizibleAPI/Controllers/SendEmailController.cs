using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using WhizibleAPI.Models.Email;
using WhizibleAPI.Models.EmailMessages;
using System.IO;
//using WhizibleAPI.Commonfunction.WorkFlow;

namespace WhizibleAPI.Controllers
{
    public class SendEmailController : ApiController
    {
        //EmailMessagesController.GetEmailMessage_435(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, 468, 504,Convert.ToDateTime("1/25/2016"),Convert.ToDateTime("1/31/2016"));
        //EmailMessagesController.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage);
        [HttpPost]
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        ////public List<SendEmail> GetEmailMessageInfo([FromBody]SendEmailParameters sendEmailParameters)
        public object GetEmailMessageInfo([FromBody] SendEmailParameters sendEmailParameters)

        {
            try { 
            string strFromEmailID = "";
            string strToEmailID = "";
            string strCCToEmailID = "";
            string strSubject = "", strMessage = "";
            string fileName = "";
            var MSGID = sendEmailParameters.msgID;
            var WorkFlowInstance = sendEmailParameters.WorkFlowInstance;
            if (Convert.ToString(WorkFlowInstance) != "" && Convert.ToString(WorkFlowInstance) != "0")
            {
                switch (MSGID)
                {
                    //case "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"

                    //WorkFlow//
                    case 1:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 2:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 3:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;

                    case 4:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 5:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 6:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 7:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 8:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 9:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 10:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;

                    case 11:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 12:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 13:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    //case 8:
                    //    EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.m_strMsgID, sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName);
                    //    break;
                    //case 9:
                    //    EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                    //    break;
                    case 14:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 15:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 16:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 17:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 18:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 19:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 20:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;
                    case 21:
                        EmailMessagesController.GetEmailMessage(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.msgID.ToString(), sendEmailParameters.m_strPrimaryKeyValue, sendEmailParameters.m_strcomments, sendEmailParameters.UserName, sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.WorkFlowInstance);
                        break;

                    default:
                        break;
                }
            }
            else
            {

                switch (MSGID)
                {
                    case 435:
                        EmailMessagesController.GetEmailMessage_435(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.LoginUserID, sendEmailParameters.ResourseID, Convert.ToDateTime(sendEmailParameters.FromDate), Convert.ToDateTime(sendEmailParameters.ToDate), sendEmailParameters.TimesheetID);
                        break;
                    case 436:
                        EmailMessagesController.GetEmailMessage_436(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.LoginUserID, sendEmailParameters.ResourseID, sendEmailParameters.TimesheetID);
                        break;
                    case 434:
                        EmailMessagesController.GetEmailMessage_434(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.TimesheetID);
                        break;
                    case 20047:
                        //Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                        //EmailMessagesController.GetEmailMessage_20047(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intETCRequestID);
                        EmailMessagesController.GetEmailMessage_20047(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intETCRequestID, sendEmailParameters.intProjectID);
                        //End of Commented And Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                        break;
                    case 8:
                        EmailMessagesController.GetEmailMessage_8(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.IssueID, sendEmailParameters.intProjectID, sendEmailParameters.LoginUserID);
                        break;
                    case 473:
                        EmailMessagesController.GetEmailMessage_473(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intProjectID, sendEmailParameters.IssueID, sendEmailParameters.msgID, sendEmailParameters.intEmployeeID);
                        break;
                    case 33:
                        EmailMessagesController.GetEmailMessage_33(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.IssueID, sendEmailParameters.intProjectID, sendEmailParameters.msgID, sendEmailParameters.intEmployeeID);
                        break;
                    case 14://Added By Dipali V On 4th Jun 2020 For Assign issue mail should send
                        //Commented And Added By Reshma Chavan on 28th oct 2021 Getting From emailID Wrong on mail popup
                        //EmailMessagesController.GetEmailMessage_14(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.IssueID, sendEmailParameters.intProjectID, sendEmailParameters.msgID, sendEmailParameters.intEmployeeID);
                        EmailMessagesController.GetEmailMessage_14(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.IssueID, sendEmailParameters.intProjectID, sendEmailParameters.msgID, sendEmailParameters.intEmployeeID, sendEmailParameters.LoginUserID, sendEmailParameters.SelectedEmployeeID);
                        //End of Commented And Added By Reshma Chavan on 28th oct 2021 Getting From emailID Wrong on mail popup
                        break;

                    case 483:
                        EmailMessagesController.GetEmailMessage_483(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intModuleID, sendEmailParameters.strProjectID, sendEmailParameters.strEmployeeID);
                        break;
                    case 484:
                        EmailMessagesController.GetEmailMessage_484(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intModuleID, sendEmailParameters.strProjectID, sendEmailParameters.strEmployeeID);
                        break;
                    case 487:
                        EmailMessagesController.GetEmailMessage_487(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intMilestoneID, sendEmailParameters.strProjectID, sendEmailParameters.intEmployeeID);
                        break;
                    case 488://For Reoprn milestone
                        EmailMessagesController.GetEmailMessage_488(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intMilestoneID, sendEmailParameters.strProjectID, sendEmailParameters.intEmployeeID);
                        break;
                    //Added By  Dipali V On 14th  Oct 2021 For Ready for billing milestone
                    case 22:
                        EmailMessagesController.GetEmailMessage_22(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intMilestoneID.ToString(), sendEmailParameters.strProjectID, sendEmailParameters.intEmployeeID.ToString());
                        break;
                    //End of Added By  Dipali V On 14th  Oct 2021 For Ready for billing milestone
                    case 485:
                        EmailMessagesController.GetEmailMessage_485(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.SubProjectID, sendEmailParameters.ProjectID, sendEmailParameters.EmployeeID);
                        break;
                    case 486:
                        EmailMessagesController.GetEmailMessage_486(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.SubProjectID, sendEmailParameters.ProjectID, sendEmailParameters.EmployeeID);
                        break;
                    case 470:
                        EmailMessagesController.GetEmailMessage_470(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.Comment, sendEmailParameters.ProjectID.ToString(), sendEmailParameters.EmployeeID.ToString(), sendEmailParameters.RoleID.ToString());
                        break;
                    case 471:
                        EmailMessagesController.GetEmailMessage_471(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strScheduleID, sendEmailParameters.strProjectID, sendEmailParameters.strEmployeeID);
                        break;
                    case 439:
                        EmailMessagesController.GetEmailMessage_439(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strScheduleID, sendEmailParameters.strProjectID, sendEmailParameters.strEmployeeID);
                        break;

                    case 17:
                        EmailMessagesController.GetEmailMessage_CloseProject_17(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.ProjectID, sendEmailParameters.EmployeeID, sendEmailParameters.RoleID);
                        break;
                    case 79:
                        //Commented & Added By Dipali V On 27th Nov 2021 For Getting Task Detials
                        // EmailMessagesController.GetEmailMessage_79(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strParentTaskIDs, sendEmailParameters.strProjectID, sendEmailParameters.strEmployeeID, sendEmailParameters.strTitle);
                        EmailMessagesController.GetEmailMessage_79(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strParentTaskIDs, sendEmailParameters.strProjectID, sendEmailParameters.strEmployeeID, sendEmailParameters.strTitle, sendEmailParameters.LoginUserID);
                        break;
                    //End of Commented & Added By Dipali V On 27th Nov 2021 For Getting Task Detials
                    case 34:
                        EmailMessagesController.GetEmailMessage_34(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.IssueID, sendEmailParameters.intProjectID, sendEmailParameters.LoginUserID);
                        break;

                    //end vishal mahajan 04-12-2019

                    //start vishal mahajan 04-12-2019 for 34 ISSUE STATUS CHANGED
                    case 29:
                        string FileName = "";
                        EmailMessagesController.GetEmailMessage_29(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ref FileName, sendEmailParameters.ReviewStatisticsID, Convert.ToString(sendEmailParameters.LoginUserID));
                        sendEmailParameters.FileName = FileName;
                        break;

                    //end vishal mahajan 04-12-2019

                    //start vishal mahajan 04-12-2019 for 34 ISSUE STATUS CHANGED
                    case 30:
                        fileName = "";
                        EmailMessagesController.GetEmailMessage_30(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ref fileName, sendEmailParameters.ReviewStatisticsID, Convert.ToString(sendEmailParameters.LoginUserID), sendEmailParameters.OldReviewStartDate, sendEmailParameters.OldReviewEndDate);
                        sendEmailParameters.FileName = fileName;
                        break;
                    case 20049:
                        fileName = "";
                        EmailMessagesController.GetEmailMessage_20049(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ref fileName, sendEmailParameters.ReviewStatisticsID, Convert.ToString(sendEmailParameters.LoginUserID));
                        sendEmailParameters.FileName = fileName;
                        break;
                    // Added By Rutuja Desai for Requested Resource 
                    case 203:
                        EmailMessagesController.GetEmailMessage_203(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strEmployeeID, sendEmailParameters.intRequestID);
                        break;
                    case 503:
                        EmailMessagesController.GetEmailMessage_503(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intRequestID, sendEmailParameters.strEmployeeID, sendEmailParameters.intUserID);
                        break;
                    case 75:
                        EmailMessagesController.GetEmailMessage_75(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intRequestID);
                        break;
                    //End Added By Rutuja Desai for Requested Resource 

                    //Added By Reshma on 4th Nov 2019 For Resource Release Mail Popup
                    //Added By  Dipali V On 8th Feb 2021 For Re-Assign Resource 
                    case 15:
                        //EmailMessagesController.GetEmailMessage_15(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intProjectEmployeeRoleID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        EmailMessagesController.GetEmailMessage_15(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intProjectEmployeeRoleID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID, Convert.ToString(sendEmailParameters.intEmployeeID));
                        break;
                    //End of Added By  Dipali V On 8th Feb 2021 For Re-Assign Resource 
                    case 16:
                        EmailMessagesController.GetEmailMessage_16(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.intProjectEmployeeRoleID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        break;
                    case 498:
                        EmailMessagesController.GetEmailMessage_498(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strResourceRequestID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        break;
                    case 543:
                        EmailMessagesController.GetEmailMessage_543(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strResourceRequestID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        break;
                    case 80:
                        EmailMessagesController.GetEmailMessage_80(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, sendEmailParameters.strResourceRequestID, sendEmailParameters.strProjectID, sendEmailParameters.intUserID);
                        break;

                    //End Added By Reshma on 4th Nov 2019 For Resource Release Mail Popup
                    default:
                        break;
                        //End of WorkFlow//
                }
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
            //start by vishal Mahajan 10-12-2019
            //if (MSGID == 17)
            //{
            //    EmailInformation.IsAttachment = true;
            //    EmailInformation.FileName = sendEmailParameters.FileName;
            //    EmailInformation.FilePath = HttpContext.Current.Server.MapPath("../../../Reports/") + sendEmailParameters.FileName;
            //}
            //if (MSGID == 29)
            //{
            //    EmailInformation.IsAttachment = true;
            //    EmailInformation.FileName = sendEmailParameters.FileName;
            //    EmailInformation.FilePath = HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Reviews/ICSFiles/") + sendEmailParameters.FileName;
            //}
            if (MSGID == 17)
            {
                if (!string.IsNullOrEmpty(sendEmailParameters.FileName))
                {
                    EmailInformation.IsAttachment = true;
                    EmailInformation.FileName = sendEmailParameters.FileName;
                    EmailInformation.FilePath = HttpContext.Current.Server.MapPath("../../../Reports/") + sendEmailParameters.FileName;
                }
                else
                {
                    EmailInformation.IsAttachment = false;
                    EmailInformation.FileName = sendEmailParameters.FileName;
                    EmailInformation.FilePath = "";
                }
            }
            if (MSGID == 29 || MSGID == 30 || MSGID == 20049)
            {
                if (!string.IsNullOrEmpty(sendEmailParameters.FileName))
                {
                    EmailInformation.IsAttachment = true;
                    EmailInformation.FileName = sendEmailParameters.FileName;
                    EmailInformation.FilePath = HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Reviews/ICSFiles/") + sendEmailParameters.FileName;
                }
                else
                {
                    EmailInformation.IsAttachment = false;
                    EmailInformation.FileName = sendEmailParameters.FileName;
                    EmailInformation.FilePath = "";
                }
            }
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
        //Added by riddhesh on 14-10-2022
        [Authorize, App_Start.ValidateHeaders]
        //End of comment by riddhesh on 14-10-2022
        public object SendEmailMessage([FromBody]EParameters eParameters)
        {
            try
            {
                string path = HttpContext.Current.Server.MapPath("~/ErrorLog.txt");
                //start by vishal Mahajan 10-12-2019
                if (eParameters.IsAttachment == 1)
                {

                    List<string> strAttachmentlisteds = new List<string>();
                    strAttachmentlisteds.Add(HttpUtility.UrlDecode(eParameters.FileName));
                    EmailMessagesController.SendEmailWithAttachment(eParameters.strToEmailID, eParameters.strCCToEmailID, eParameters.strFromEmailID, eParameters.strSubject, eParameters.strMessage, null, strAttachmentlisteds.ToArray());
                }
                //end by vishal Mahajan 10-12-2019
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
        [HttpPost]
        [Authorize]
        public object GetEmailShowPopupFlagForProject(SendEmailParameters SendEmailParametersObj)
        {
            try
            {
                int strShowPopup = 1;
                strShowPopup = EmailMessagesController.funcGetEmailShowPopupFlagForProject(SendEmailParametersObj.ProjectID, SendEmailParametersObj.msgID);
                return strShowPopup;
            }
            //catch (Exception)
            //{
            //    return 1;
            //}
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }
        }
        [HttpPost]
        [Authorize]
        public object SendSilentEmailWithAttachment([FromBody]SendEmailParameters sendEmailParameters)
        {
            try
            {
                string strFromEmailID = "";
                string strToEmailID = "";
                string strCCToEmailID = "";
                string strSubject = "", strMessage = "";
                string fileName = "";
                var MSGID = sendEmailParameters.msgID;
                var WorkFlowInstance = sendEmailParameters.WorkFlowInstance;
                switch (MSGID)
                {
                    //start vishal mahajan 04-12-2019 for 34 ISSUE STATUS CHANGED
                    case 29:
                        string FileName = "";
                        EmailMessagesController.GetEmailMessage_29(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ref FileName, sendEmailParameters.ReviewStatisticsID, Convert.ToString(sendEmailParameters.LoginUserID));
                        sendEmailParameters.FileName = FileName;
                        break;

                    //end vishal mahajan 04-12-2019

                    //start vishal mahajan 04-12-2019 for 34 ISSUE STATUS CHANGED
                    case 30:
                         fileName = "";
                        EmailMessagesController.GetEmailMessage_30(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ref fileName, sendEmailParameters.ReviewStatisticsID, Convert.ToString(sendEmailParameters.LoginUserID), sendEmailParameters.OldReviewStartDate, sendEmailParameters.OldReviewEndDate);
                        sendEmailParameters.FileName = fileName;
                        break;

                    case 20049:
                        fileName = "";
                        EmailMessagesController.GetEmailMessage_20049(ref strFromEmailID, ref strToEmailID, ref strCCToEmailID, ref strSubject, ref strMessage, ref fileName, sendEmailParameters.ReviewStatisticsID, Convert.ToString(sendEmailParameters.LoginUserID));
                        sendEmailParameters.FileName = fileName;
                        break;
                    //end vishal mahajan 04-12-2019
                   
                    default:
                        break;
                        //End of WorkFlow//
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
                if (MSGID == 29 || MSGID == 30 || MSGID == 20049)
                {
                    if (!string.IsNullOrEmpty(sendEmailParameters.FileName))
                    {
                        EmailInformation.IsAttachment = true;
                        EmailInformation.FileName = sendEmailParameters.FileName;
                        EmailInformation.FilePath = HttpContext.Current.Server.MapPath("../../../ATTACHMENTS/Reviews/ICSFiles/") + sendEmailParameters.FileName;
                    }
                    else
                    {
                        EmailInformation.IsAttachment = false;
                        EmailInformation.FileName = sendEmailParameters.FileName;
                        EmailInformation.FilePath = "";
                    }
                }
                List<string> strAttachmentlisteds = new List<string>();
                strAttachmentlisteds.Add(EmailInformation.FilePath);
                EmailMessagesController.SendEmailWithAttachment(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage, null, strAttachmentlisteds.ToArray());
                return 1;
            }
            //catch (Exception)
            //{
            //    return 0;
            //}
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Bad Request found");
            }

        }

    }
    public class SendEmailParameters
    {
        public int SubProjectID;
        public int ProjectID;
        public int RoleID;
        public int EmployeeID;
      
        public int WorkFlowInstance;
        public int msgID { get; set; }
        public string Comment { get; set; }
        //public int intParentTaskID { get; set; }
        public string strParentTaskIDs { get; set; }
        public string SelectedEmployeeID { get; set; }
        public int LoginUserID { get; set; }
        public int ResourseID { get; set; } 
        public string strTitle { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public int TimesheetID { get; set; }
        public int intETCRequestID { get; set; }
        public int IssueID { get; set; }
        public int intProjectID { get; set; }
        public int intEmployeeID { get; set; }
        public string strProjectID { get; set; }
        public string strEmployeeID { get; set; }
        public string WhichFlag { get; set; }
        //public string SelectedEmployeeID { get; set; }
        public string intUserID { get; set; }
        public int intMilestoneID { get; set; }
      //  public int EmployeeID { get; set; }
        public string intModuleID { get; set; }
        public string strScheduleID { get; set; }
        //public string msgID { get; set; }
        public string m_strPrimaryKeyValue { get; set; }
        public string m_strcomments { get; set; }
        public int ScheduleID { get; set; }
        public string UserName { get; set; }

        //start by vishal Mahajan 11-12-2019
        public string FileName { get; set; }
        public string ReviewStatisticsID { get; set; }
        public string SenderName { get; set; }
        public string OldReviewStartDate { get; set; }
        public string OldReviewEndDate { get; set; }
        //end by vishal Mahajan 11-12-2019  
        //Added By Reshma on 17th Dec 2019
        public string strResourceRequestID { get; set; }
        public string intProjectEmployeeRoleID { get; set; }
        public string intRequestID { get; set; }
        //End Added By Reshma on 17th Dec 2019
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
