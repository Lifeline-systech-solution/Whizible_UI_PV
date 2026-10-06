<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SendEmail.aspx.vb" Inherits="PbNIT.SendEmail1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
         <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Send Mail")%> 
<head>
<%--<meta name="SKYPE_TOOLBAR" content="SKYPE_TOOLBAR_PARSER_COMPATIBLE" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Send Mail</title>
    
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="../../General/loaderStylesheet.css" rel="stylesheet" />

</head>
<style>
    table {
        border: solid 1px #0056a2;
        margin: 20px auto;
        line-height: 20px;
        color: #666;
    }

        table tr td {
            padding: 10px;
            font-size: 13px;
        }

    .border-top {
        border-top: solid 1px #d7d7d7;
    }

    .social_links a {
        display: inline-block;
        margin-left: 5px;
    }

    a:hover {
        text-decoration: none;
        color: #ccc;
    }
</style>

<body>
    <form id="frmSendEmail" name="frmSendEmail">
        <!--bootstrap_Alertify-->
            <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg" hidden="hidden">
                <button type="button" class="close">×</button>
                <p id="alertMsg"></p>
            </div>
            <!--bootstrap_Alertify-->
<table style=" border:1px solid #ddd;; background:#fafafa; margin:20px auto;line-height:20px;color:#666; font-family:Arial, Helvetica, sans-serif; max-width:600px;" width="100%" cellpadding="10" cellspacing="0">
  <tbody>
    <tr bgcolor="#e7edf0">
      <td colspan="3" align="left" style="padding:10px 16px; font-size:16px; font-weight:bold;">Send Email</td>
    </tr>
    <tr bgcolor="#e7edf0">
      <td style="padding:1px;"></td>
      <td style="padding:1px;"></td>
	  <td style="padding:1px;"></td>
    </tr>
	
	<tr>
      <td></td>
      <td></td>
	  <td align="right">
	  <a title="send" onclick="SendMail()" style="background: #e29214; font-weight: bold; color: #fff; padding:6px 12px; border-radius:4px; border:none; display:inline-block; cursor:pointer;">
	  <img src="../../../Whizible2.0-new/dist/img/send.png" width="16px" style="float: left;margin-right: 10px;margin-top: 2px;"> Send</a>
	  <a title="Close" style="background: #1359a6; font-weight: bold;color: #fff; padding:6px 12px;  border-radius:4px; border:none; display:inline-block; cursor:pointer;" onclick="window.close()">
	  <img src="../../../Whizible2.0-new/dist/img/cancel.png" width="16px" style="float: left;margin-right: 10px;margin-top: 2px;"> Close</a>
	  </td>
      
    </tr>
    <tr>
      <td></td>
      <td></td>
	  <td></td>
    </tr>

	<tr>
      <td width="15%"><strong>From</strong></td>
      <td>:</td>
	  <td width="80%">
         <%-- <input type="text" id="txtFromEmailID" value="" style="width:94%; padding:6px 10px;" disabled="disabled"/>--%>
           <%CommonFunctions.HTMLControls.DrawTextBox("txtFromEmailID", "txtFromEmailID", "form-control", , , , , "width:94%; padding:6px 10px;", , , , , "disabled='disabled'", , , , , , , )%>

	  </td>
    </tr>
	
	<tr>
      <td width="15%"><strong>To</strong></td>
      <td>:</td>
	  <td width="80%">
        <%--  <input type="text" value="" id="txtToEmailID" style="width:94%; padding:6px 10px;" />--%>
          <%CommonFunctions.HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", "form-control", , , , , "width:94%; padding:6px 10px;", , , , , , , , , , , , )%>

	  </td>
    </tr>
	
	<tr>
      <td width="15%"><strong>CC</strong></td>
      <td>:</td>
	  <td width="80%">
         <%-- <input type="text" value="" id="txtCCEmailID" style="width:94%; padding:6px 10px;">--%>
     <%CommonFunctions.HTMLControls.DrawTextBox("txtCCEmailID", "txtCCEmailID", "form-control", , , , , "width:94%; padding:6px 10px;", , , , , , , , , , , , )%>

	  </td>
    </tr>
	
	
	<tr>
      <td width="15%"><strong>Subject</strong></td>
      <td>:</td>
	  <td width="80%">
          <%--<input type="text" value="" id="txtSubject" style="width:94%; padding:6px 10px;">--%>
           <%CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", "form-control", , , , , "width:94%; padding:6px 10px;", , , , , , , , , , , , )%>

	  </td>
    </tr>
	
		<tr>
      <td valign="top" width="15%"><strong>Note</strong></td>
      <td>:</td>
	  <td width="80%">The valid separators for the Email IDs are space(" "), comma(",") and semi-colon(";").</td>
    </tr>
	
	<tr>
      <td valign="top" width="15%"><strong>Message</strong></td>
      <td valign="top">:</td>
	  <td width="80%">
         <%-- <textarea id="txtMessage" style="padding:6px 10px;width:94%;min-height:100px;"></textarea>--%>
           <% CommonFunctions.HTMLControls.DrawTextArea("txtMessage", "txtMessage", , "form-control", , , , , , , , , , "padding:6px 10px;width:94%;min-height:100px;", ,, , , , , , )%>
	  </td>
    </tr>
       <tr id="tr_tblFiles" >  
          <td colspan="3">
          <table id="tblFiles" style="width:90%;" class="clsGridTable table">
                <thead class="clsTRColumnHeader" align="left">
                <tr>
                <th>Attachment Files</th>  
                <th>Remove</th>  
                </tr>
                </thead>
                <tbody id="tbody_tblFiles">
                </tbody>
                </table>
           </td>
      </tr>
	<tr bgcolor="#fafafa">
      <td style="padding:5px 1px;"></td>
      <td style="padding:5px 1px;"></td>
    </tr>
	
	
    <tr bgcolor="#fafafa">
      <td style="padding:5px 1px;"></td>
      <td style="padding:5px 1px;"></td>
    </tr>
    
  </tbody>
</table>
        </form>
 <%--     <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
	  <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
      <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
      <script src="../../General/CommonFunctions.js"></script>--%>
     <script type="text/javascript">
         var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
         var strUrl1 = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';

         var EmailParameters;
         var SessionEmployeeId = '<%= Session("intUserId") %>';
         var IntQueryMessageID = '<%= Request.QueryString("MessageID")%>';
         var IRFlag = '<%= Request.QueryString("IRFlag")%>';
         var IntQueryMessageID = parseInt(IntQueryMessageID);
         jQuery(document).ready(function () {
             
             //start by Vishal Mahajan 10-12-2019
             $("#tr_tblFiles").hide();
             //end by Vishal Mahajan 10-12-2019
             if (IntQueryMessageID == 20004 || IntQueryMessageID == 20003) {
                 strUrl_Project = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>';
                 var Parameters = AddParameters(<%= Request.QueryString("MessageID")%>);
                 $.ajax({
                     url: strUrl_Project + '/api/SendEmail/GetEmailMessageInfo',
                     type: "POST",
                     <%--data: JSON.stringify(AddParameters(<%= Request.QueryString("MessageID")%>)),--%>
                     data: JSON.stringify(Parameters),
                     dataType: "json",
                     contentType: "application/json;charset-utf=8",
                     beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Issue"));
                         if (Parameters) {
                             xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                         }
                     },
                     success: function (data) {
                         console.log(data);
                         EmailMessageList = data;
                         PlotEmailSection(EmailMessageList);
                         var browser = isIE();
                         if (browser == 'IE') {
                             setTimeout('self.focus()', 2);
                         }
                     },
                     error: function (err) {
                         console.log(err);
                     }
                 });
             }
             else if (IntQueryMessageID == 493 || IntQueryMessageID == 494 || IntQueryMessageID == 35002 || IntQueryMessageID == 35001 || IntQueryMessageID == 35003) {
                 var Parameters = AddParameters(<%= Request.QueryString("MessageID")%>);
                 $.ajax({
                     url: strUrl1 + '/api/SendEmail/GetEmailMessageInfo',
                     type: "POST",
                     <%--data: JSON.stringify(AddParameters(<%= Request.QueryString("MessageID")%>)),--%>
                     data: JSON.stringify(Parameters),
                     dataType: "json",
                     contentType: "application/json;charset-utf=8",
                     beforeSend: function (xhr) {
                         xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                         if (Parameters) {
                             xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                         }
                     },
                     success: function (data) {
                         console.log(data);
                         EmailMessageList = data;
                         PlotEmailSection(EmailMessageList);
                         var browser = isIE();
                         if (browser == 'IE') {
                             setTimeout('self.focus()', 2);
                         }
                     },
                     error: function (err) {
                         console.log(err);
                     }
                 });
             }
             else {
                  // debugger
                         //Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose(IntQueryMessageID == 51)
                           // if (IntQueryMessageID == 76 || IntQueryMessageID == 426 || IntQueryMessageID == 427 || IntQueryMessageID == 430 || IntQueryMessageID == 432 || IntQueryMessageID == 541 || IntQueryMessageID == 542 || IntQueryMessageID == 539 || IntQueryMessageID == 502 || IntQueryMessageID == 499 || IntQueryMessageID == 51) {
                 //Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
                 if (IntQueryMessageID == 76 || IntQueryMessageID == 426 || IntQueryMessageID == 427 || IntQueryMessageID == 430 || IntQueryMessageID == 432 || IntQueryMessageID == 541 || IntQueryMessageID == 542 || IntQueryMessageID == 539 || IntQueryMessageID == 502 || IntQueryMessageID == 499 || IntQueryMessageID == 35009 || IntQueryMessageID == 35010 || IntQueryMessageID == 35011 || IntQueryMessageID == 35013 || IntQueryMessageID == 35016 || IntQueryMessageID == 35014 || IntQueryMessageID == 35015 || IntQueryMessageID == 35017 || IntQueryMessageID == 35018) {
                             var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
                         }
                            //End of Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose
                      
                 
                 //Added By Dipali V On June 2021 For Invoice Customzation
                 //Uncommented by Riddhesh Patil for Authorization Issue on 25 Sep 2024
                else
                //End of Uncommented by Riddhesh Patil for Authorization Issue on 25 Sep 2024
                 if (IntQueryMessageID == 3 || IntQueryMessageID == 51 || IntQueryMessageID == 55) {
                     if (IRFlag != 1) {
                         var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
                     }
                     else {
                         var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
                     }
                 }
                 else {
                     var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
                 }
                 
        
                 var Parameters = AddParameters(<%= Request.QueryString("MessageID")%>);
                 $.ajax({
                     url: strUrl + '/api/SendEmail/GetEmailMessageInfo',
                     type: "POST",
                     <%--data: JSON.stringify(AddParameters(<%= Request.QueryString("MessageID")%>)),--%>
                     data: JSON.stringify(Parameters),
                     dataType: "json",
                     contentType: "application/json;charset-utf=8",
                     beforeSend: function (xhr) {
                        //Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
                         if (IntQueryMessageID == 76 || IntQueryMessageID == 426 || IntQueryMessageID == 427 || IntQueryMessageID == 430 || IntQueryMessageID == 432 || IntQueryMessageID == 541 || IntQueryMessageID == 542 || IntQueryMessageID == 539 || IntQueryMessageID == 502 || IntQueryMessageID == 499 || IntQueryMessageID == 35009 || IntQueryMessageID == 35010 || IntQueryMessageID == 35011 || IntQueryMessageID == 35013 || IntQueryMessageID == 35016 || IntQueryMessageID == 35014 || IntQueryMessageID == 35015 || IntQueryMessageID == 35017 || IntQueryMessageID == 35018) {
                             xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                             if (Parameters) {
                                 xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                             }
                         }
                          //Commented & Added By Dipali V On 2nd Oct 2023 For Project Timesheet SFA
                         //else {
                         //    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                         //    if (Parameters) {
                         //        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                         //    }
                         //}

                         else if (IntQueryMessageID == 3 || IntQueryMessageID == 51 || IntQueryMessageID == 55) { // Added By Dipali On 7th Nov 2023 For Submit IR
                             if (IRFlag != 1) {
                                 xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                             }
                             else {
                                 xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                                 if (Parameters) {
                                     xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                                 }
                             }
                            
                         } else {
                             //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Invoice"));
                            
                             xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                         }
                          //End of Commented & Added By Dipali V On 2nd Oct 2023 For Project Timesheet SFA
                         if (Parameters) {
                             xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                         }

                     },
                     success: function (data) {
                         console.log(data);
                         EmailMessageList = data;
                         PlotEmailSection(EmailMessageList);
                         //Added By Usha Pandit On 09.08.2020 For setting focus in IE browser
                         var browser = isIE();
                         if (browser == 'IE') {
                             setTimeout('self.focus()', 2);
                         }
                         //End Of Added By Usha Pandit On 09.08.2020 For setting focus in IE browser
                     },
                     error: function (err) {
                         console.log(err);
                     }
                 });
             }
         });
         function AddParameters(MSGID) {
             
             //Added By Dipali V On 25th Jun 2024 For Matrix Send For Approval
             if (MSGID == 35009) {
                 EmailParameters = {
                     msgID: MSGID,
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                     ProjectID: '<%= Request.QueryString("ProjectID")%>',
                     EmployeeID: '<%= Request.QueryString("EmployeeID")%>'.toString()
                  };

             }

             //Added By Dipali V On 25th Jun 2024 For Matrix Send For Approval
             if (MSGID == 35010) {
                 EmailParameters = {
                     msgID: MSGID,
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                     ProjectID: '<%= Request.QueryString("ProjectID")%>',
                     EmployeeID: '<%= Request.QueryString("EmployeeID")%>'.toString()
                 };

             }

             //Added By Dipali V On 25th Jun 2024 For Matrix Approve & Rejected
             if (MSGID == 35011) {
                 EmailParameters = {
                     msgID: MSGID,
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                     ProjectID: '<%= Request.QueryString("ProjectID")%>',
                     EmployeeID: '<%= Request.QueryString("EmployeeID")%>'.toString()
                 };

             }
               //End of Added By Dipali V On 25th Jun 2024 For Matrix Send For Approval
             //Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose
             if (IRFlag == 1) {
                 if (MSGID == 51 || MSGID == 55) {
                     EmailParameters = {
                         msgID: MSGID,
                         RFIID: '<%= Request.QueryString("RFIID")%>',
                         ProjectID: '<%= Request.QueryString("ProjectID")%>',
                         intEmployeeID: '<%= Request.QueryString("intEmployeeID")%>',
                     };
                 }
             }
             //End of Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose
         
             if (MSGID == 435 || MSGID == 436) {

                 EmailParameters = {
                     msgID: MSGID,
                     LoginUserID: '<%= Request.QueryString("VerifiedBy")%>',
                     ResourseID: '<%= Request.QueryString("ResourceID")%>',
                     FromDate: '<%= Request.QueryString("FromDate")%>'.toString(),
                     ToDate: '<%= Request.QueryString("ToDate")%>'.toString(),
                     TimesheetID: '<%= Request.QueryString("TimesheetID")%>'
                 };
             }

             if (MSGID == 434) {
                 EmailParameters = {
                     msgID: MSGID,
                     TimesheetID: '<%= Request.QueryString("TimesheetID")%>',
                 };
             }
             if (MSGID == 20047) {
                 EmailParameters = {
                     msgID: MSGID,
                     intETCRequestID: '<%= Request.QueryString("intETCRequestID")%>',
                      //Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                     intProjectID: '<%= Request.QueryString("intProjectID")%>',
                      //End of Added By Reshma Chavan on 7th Dec 2020 For Incorrect To EmailID on Mail Popup
                    
                 };
             }
             if (MSGID == 493) {
                 
                 EmailParameters = {
                     msgID: MSGID,
                     OpportunityID: '<%= Request.QueryString("OpportunityID")%>',
                      LoginUserID: SessionEmployeeId
                 };
             }
             if (MSGID == 494) {
                 
                 EmailParameters = {
                     msgID: MSGID,
                     OpportunityID: '<%= Request.QueryString("OpportunityID")%>',
                 };
             }
             if (MSGID == 35002) {
                 
                 EmailParameters = {
                     msgID: MSGID,
                     LoginUserID: SessionEmployeeId,
                     RequestId: '<%= Request.QueryString("RequestId")%>',
                 };
             }
             if (MSGID == 35001) {

                 EmailParameters = {
                     msgID: MSGID,
                     LoginUserID: SessionEmployeeId,
                     RequestId: '<%= Request.QueryString("RequestId")%>',
                 };
             }
                   if (MSGID == 35003) {
                 
                 EmailParameters = {
                     msgID: MSGID,
                     LoginUserID: SessionEmployeeId,
                     RequestId: '<%= Request.QueryString("RequestId")%>',
                  };
                  
             }
            /* Added By Dipali V On 5th Dec 2022 For Copy To Issue Changes*/
             if (MSGID == 20004) {
                 //
                 EmailParameters = {
                     msgID: MSGID,
                     LoginUserID: SessionEmployeeId,
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                     Comments: '<%= Request.QueryString("Comments")%>',
                     ProjectID: '<%= Request.QueryString("ProjectID")%>',
                     ShowToCustomer: '<%= Request.QueryString("ShowToCustomer")%>',
                     IssueID: '<%= Request.QueryString("IssueID")%>',
                 };

             }
             if (MSGID == 20003) {
                 //
                 EmailParameters = {
                     msgID: MSGID,
                     LoginUserID: SessionEmployeeId,
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                     Comments: '<%= Request.QueryString("Comments")%>',
                     ProjectID: '<%= Request.QueryString("ProjectID")%>',
                     ShowToCustomer: '<%= Request.QueryString("ShowToCustomer")%>',
                     IssueID: '<%= Request.QueryString("IssueID")%>',
                 };

             }

             
             /*End of  Added By Dipali V On 5th Dec 2022 For Copy To Issue Changes*/
              if (MSGID == 8 && '<%= Request.QueryString("workflow")%>' != 1) {
            
                // 
                 //Commented & Added By Rutuja D. on 16 March 2020 For issueid 23174 
                // $(document).removeAttr("title", "");
                 //Added & Commented By Dipali V On 16th April 2020 For Title Should be correct
                 //$(document).attr("title", "ISSUE MODEL");
                 //$(document).attr("title", "Issue Module");
                 //Commented Added By Dipali V On 16th April 2020 For Title Should be correct
                 //End Commented & Added By Rutuja D. on 16 March 2020 For issueid 23174 
                 var Issue = '<%= Request.QueryString("IssueID")%>';
                 var LoginUserID = '<%= Request.QueryString("EmployeeID")%>';
                 var ProjectID = '<%= Request.QueryString("ProjectID")%>';
                 //alert(Issue + " " + LoginUserID + " " + ProjectID);
                 EmailParameters = {
                     msgID: MSGID,
                     IssueID: Issue,
                     LoginUserID: LoginUserID ,
                     intProjectID: ProjectID,
                 };
             }

             //start vishal mahajan 04-12-2019 for ISSUE STATUS CHANGED
             if (MSGID == 34) {
                   //  $(document).removeAttr("title", "");
                 //$(document).attr("title", "ISSUE MODEL");
                  //Added & Commented By Dipali V On 16th April 2020 For Title Should be correct
                 //$(document).attr("title", "ISSUE MODEL");
                 //$(document).attr("title", "Issue Module");
                 //Commented Added By Dipali V On 16th April 2020 For Title Should be correct
                 var Issue = '<%= Request.QueryString("IssueID")%>';
                 var LoginUserID = '<%= Request.QueryString("EmployeeID")%>';
                 var ProjectID = '<%= Request.QueryString("ProjectID")%>';
                 EmailParameters = {
                     msgID: MSGID,
                     IssueID: Issue,
                     LoginUserID: LoginUserID ,
                     intProjectID: ProjectID,
                 };
             }
             //end vishal mahajan 04-12-2019
            

             if (MSGID == 470) {
                  
                 var Comment = '<%= Request.QueryString("Comment")%>';
                 var EmployeeID = parseInt('<%= Session("intUserID")%>');
                 var ProjectID = '<%= Session("intProjectID")%>';
                  var RoleID = '<%= Session("intPostID")%>';
                 EmailParameters = {
                     msgID: MSGID,
                     Comment: Comment,
                     EmployeeID: EmployeeID ,
                     ProjectID: ProjectID,
                     RoleID: RoleID
                 };
             }


             if (MSGID == 473) {
                    //  $(document).removeAttr("title", "");
                 //$(document).attr("title", "ISSUE MODEL");
                  //Added & Commented By Dipali V On 16th April 2020 For Title Should be correct
                 //$(document).attr("title", "ISSUE MODEL");
                 ////$(document).attr("title", "Issue Module");
                 //Commented Added By Dipali V On 16th April 2020 For Title Should be correct
                 EmailParameters = {
                     msgID: MSGID,
                     IssueID: '<%= Request.QueryString("IssueID")%>',
                     intProjectID: '<%= Request.QueryString("ProjectID")%>',
                     intEmployeeID: '<%= Request.QueryString("EmployeeID")%>',

                 };
             }
             if (MSGID == 33) {
                // $(document).removeAttr("title", "");
                  //   $(document).removeAttr("title", "");
                 ////$(document).attr("title", "ISSUE MODEL");
                  //Added & Commented By Dipali V On 16th April 2020 For Title Should be correct
                 //$(document).attr("title", "ISSUE MODEL");
                // $(document).attr("title", "Issue Module");
                 //Commented Added By Dipali V On 16th April 2020 For Title Should be correct
                 EmailParameters = {
                     msgID: MSGID,
                     IssueID: '<%= Request.QueryString("IssueID")%>',
                     intProjectID: '<%= Request.QueryString("ProjectID")%>',
                     intEmployeeID: '<%= Request.QueryString("EmployeeID")%>',

                 };
             }

             if (MSGID == 14 && '<%= Request.QueryString("workflow")%>' != 1) {

                 EmailParameters = {
                     msgID: MSGID,
                     IssueID: '<%= Request.QueryString("IssueID")%>',
                     intProjectID: '<%= Request.QueryString("ProjectID")%>',
                     intEmployeeID: '<%= Request.QueryString("EmployeeID")%>',
                     LoginUserID: '<%= Request.QueryString("LoginUserID")%>',//Added By Reshma chavan on 28th Oct 2021
                     SelectedEmployeeID: '<%= Request.QueryString("SelectedEmployeeID")%>',
                     

                 };
             }
               //start by Vishal Mahajan 11-12-2019
             if (MSGID == 29) {
                // 
               

                // $(document).removeAttr("title", "");
                 //$(document).attr("title", "ISSUE MODEL");
                  //Added & Commented By Dipali V On 20th May 2020 For Title Should be correct
                 //$(document).attr("title", "ISSUE MODEL");
                // $(document).attr("title", "Project Review");
                   //End of Added & Commented By Dipali V On 20th May 2020 For Title Should be correct
                     EmailParameters = {
                         msgID: MSGID,
                         ReviewStatisticsID: '<%= Request.QueryString("ReviewStatisticsID")%>',
                         LoginUserID: '<%= Request.QueryString("LoginUserID")%>',
                     };
                 }
             if (MSGID == 30) {
                   //      $(document).removeAttr("title", "");
                  //   $(document).removeAttr("title", "");
                 //$(document).attr("title", "ISSUE MODEL");
                  //Added & Commented By Dipali V On 20th May 2020 For Title Should be correct
                 //$(document).attr("title", "ISSUE MODEL");
                // $(document).attr("title", "Project Review");
                   //End of Added & Commented By Dipali V On 20th May 2020 For Title Should be correct
                     EmailParameters = {
                         msgID: MSGID,
                         ReviewStatisticsID: '<%= Request.QueryString("ReviewStatisticsID")%>',
                         LoginUserID: '<%= Request.QueryString("LoginUserID")%>',
                         OldReviewStartDate: '<%= Request.QueryString("OldReviewStartDate")%>'.replace("_", " ").replace("_", " "),
                         OldReviewEndDate: '<%= Request.QueryString("OldReviewEndDate")%>'.replace("_", " ").replace("_", " "),
                };
             }

             //end by Vishal Mahajan 11-12-2019
             if (MSGID == 483 || MSGID == 484) {
               //    $(document).removeAttr("title", "");
                    
               //  $(document).attr("title", "Module");
                 EmailParameters = {
                     msgID: MSGID,
                     intModuleID: '<%= Request.QueryString("ModuleID")%>',
                     strProjectID: '<%= Request.QueryString("ProjectID")%>',
                     strEmployeeID: '<%= Request.QueryString("EmployeeID")%>',
                 };
             }
             if (MSGID == 79) {
               
                 //$(document).removeAttr("title", "");
                 //$(document).attr("title", "Task");
                 EmailParameters = {
                     msgID: MSGID,
                      //Commented & Added By Dipali V On 27th Nov 2021 For Getting Task Detials
                    // intParentTaskID: '<%= Request.QueryString("ParentTaskID")%>',
                     strParentTaskIDs: '<%= Request.QueryString("ParentTaskID")%>',
                    
                      //End of Commented & Added By Dipali V On 27th Nov 2021 For Getting Task Detials
                     strProjectID: '<%= Request.QueryString("ProjectID")%>',
                     strEmployeeID: '<%= Request.QueryString("EmployeeID")%>',
                     strTitle: '<%= Request.QueryString("Title")%>',
                       LoginUserID : '<%= Session("intUserID")%>',
                 };
             }



             if (MSGID == 17 && '<%= Request.QueryString("workflow")%>' != 1) {
                 //Added By Usha Pandit On 20.04.2020 For incorrect heading in send mail pop up
                // $(document).removeAttr("title", "");
                // $(document).attr("title", "Project Closure");
                 //End Of Added By Usha Pandit On 20.04.2020 For incorrect heading in send mail pop up
                     EmailParameters = {
                         msgID: MSGID,
                         ProjectID: '<%= Request.QueryString("ProjectID")%>',
                         EmployeeID: parseInt('<%= Request.QueryString("EmployeeID")%>'),
                         RoleID: '<%= Request.QueryString("RoleID")%>',
                         FileName: '<%= Request.QueryString("FileName")%>',
                     };
                 }
             if (MSGID == 20049) {
                     EmailParameters = {
                         msgID: MSGID,
                         ReviewStatisticsID: '<%= Request.QueryString("ReviewStatisticsID")%>',
                         LoginUserID: '<%= Request.QueryString("LoginUserID")%>',
                     };
                 }
             // 
             // var uri_dec = decodeURIComponent(uri_enc);
             // getUrlVars()
             //var WorkFlowInstance = getUrlVars()["WorkFlowInstance"].replace(/%20/g, " ").replace(/%E2%80%93/g, "-").replace(/#/g, " ");
             //var UserID = getUrlVars()["UserID"];
             //var UserName = getUrlVars()["UserName"].replace(/%20/g, " ").replace(/%E2%80%93/g, "-").replace(/#/g, " ");
             //var m_strcomments = getUrlVars()["m_strcomments"];
             //var m_strPrimaryKeyValue = getUrlVars()["WorkFlowInstance"].replace(/%20/g, " ").replace(/%E2%80%93/g, "-").replace(/#/g, " ");
             <%--alert('<%= Request.QueryString("WhichFlag")%>');
             --%>
             //Commented & Added By Rutuja D. on 16 March 2020 For issueid 23174 
             //if ('<%= Request.QueryString("WhichFlag")%>' != 'CloseProject' && '<%= Request.QueryString("WhichFlag")%>' == '')//WhichFlag

            // 

              if ('<%= Request.QueryString("WhichFlag")%>' != 'CloseProject' && '<%= Request.QueryString("WorkFlowInstance")%>' != '')//WhichFlag
             //End Commented & Added By Rutuja D. on 16 March 2020 For issueid 23174 
             {
                 if (MSGID != 79) {
                     //$(document).removeAttr("title", "");
                    // $(document).attr("title", "WorkFlow");
                     if (MSGID == 1 || MSGID == 2 || MSGID == 3 || MSGID == 88 || MSGID == 4 || MSGID == 10 || MSGID == 13 || MSGID == 7 || MSGID == 5 || MSGID == 6 || MSGID == 11 || MSGID == 12 || MSGID == 8 || MSGID == 9 || MSGID == 14 || MSGID == 15 || MSGID == 17 || MSGID == 18 || MSGID == 19) {

                         var strcomments = "";
                         if ('<%= Request.QueryString("m_strcomments")%>'.toString() == 'null') {

                             strcomments = "";
                         }
                         else {
                             strcomments = '<%= Request.QueryString("m_strcomments")%>'.toString();
                         }
                         EmailParameters = {
                             msgID: MSGID,
                             WorkFlowInstance: parseInt('<%= Request.QueryString("WorkFlowInstance")%>'),
                             EmployeeID: parseInt('<%= Request.QueryString("UserID")%>'),
                             UserName: '<%= Request.QueryString("UserName")%>'.toString(),
                             //m_strcomments: '<%= Request.QueryString("m_strcomments")%>'.toString(),
                             m_strcomments: strcomments,
                             //  m_strcomments: decodeURIComponent(Strm_strcomments),

                             m_strPrimaryKeyValue: '<%= Request.QueryString("PrimaryKeyValue")%>'
                             //WorkFlowInstance: WorkFlowInstance,
                             //EmployeeID: EmployeeID,
                             //UserName: UserName,
                             //Strm_strcomments: Strm_strcomments,
                             // m_strPrimaryKeyValue: m_strPrimaryKeyValue,


                         };
                         //alert(m_strcomments);
                     }
                 }
             }

             if (MSGID == 471 || MSGID == 439) {
                   // $(document).removeAttr("title", "");
                    //   $(document).attr("title", "Deliverable");
                 EmailParameters = {
                      msgID: MSGID,
                      strProjectID: '<%= Request.QueryString("ProjectID")%>',
                      strScheduleID: '<%= Request.QueryString("ScheduleID")%>',
                      strEmployeeID:'<%= Request.QueryString("EmployeeID")%>',
                 };
             }
             if (MSGID == 487 || MSGID == 488) {
                 // $(document).removeAttr("title", "");
                    //   $(document).attr("title", "Milestone");
                 EmailParameters = {
                      msgID: MSGID,
                      strProjectID: '<%= Request.QueryString("ProjectID")%>',
                      intMilestoneID: '<%= Request.QueryString("MilestoneID")%>',
                      intEmployeeID:'<%= Request.QueryString("EmployeeID")%>',
                 };
             }
              //Added By  Dipali V On 14th  Oct 2021 For Ready for billing milestone
              if (MSGID == 22) {
                 EmailParameters = {
                      msgID: MSGID,
                      strProjectID: '<%= Request.QueryString("ProjectID")%>',
                      intMilestoneID: '<%= Request.QueryString("MilestoneID")%>',
                      intEmployeeID:'<%= Request.QueryString("EmployeeID")%>',
                 };
             }
              //End of  Added By  Dipali V On 14th  Oct 2021 For Ready for billing milestone
             if (MSGID == 485 || MSGID == 486) { 
                  // $(document).removeAttr("title", "");
                // $(document).attr("title", "Sub Project");
                 EmailParameters = {
                     msgID: MSGID,
                     SubProjectID: '<%= Request.QueryString("SubProjectID")%>',
                     ProjectID: '<%= Request.QueryString("ProjectID")%>',
                     EmployeeID: parseInt('<%= Request.QueryString("EmployeeID")%>'),
                     LoginType : '<%= Session("LoginType") %>'
                 };
             }

             
              //Added By Reshma on 4th Dec 2019 For resource Release
             if (MSGID == 16) {
                // $(document).removeAttr("title", "");
                // $(document).attr("title", "Release Resource");
                 EmailParameters = {
                      msgID: MSGID,
                      intProjectEmployeeRoleID: '<%= Request.QueryString("ProjectEmployeeRoleID")%>',
                      strProjectID: '<%= Request.QueryString("ProjectID")%>',
                      intUserID:'<%= Request.QueryString("UserID")%>',
                 };
             }
             //Added By Dipali V On 8th Feb 2021 For Re-Assign Resource Mail
             if (MSGID == 15 && '<%= Request.QueryString("workflow")%>' != 1) {
                 EmailParameters = {
                      msgID: MSGID,
                      intProjectEmployeeRoleID: '<%= Request.QueryString("ProjectEmployeeRoleID")%>',
                      strProjectID: '<%= Request.QueryString("ProjectID")%>',
                     intUserID: '<%= Request.QueryString("UserID")%>',
                      intEmployeeID : '<%= Request.QueryString("EmployeeID")%>',  //Added By Nikhil A.
                 };
                 //End of Added By Dipali V On 8th Feb 2021 For Re-Assign Resource Mail
             }


             //Prepone Request
                 if (MSGID == 498) {
                     //$(document).removeAttr("title", "");
                     //$(document).attr("title", "Prepone Request");
                     EmailParameters = {
                         msgID: MSGID,
                         strResourceRequestID: '<%= Request.QueryString("ResourcePreponeRequestID")%>',
                         strProjectID: '<%= Request.QueryString("ProjectID")%>',
                         intUserID: '<%= Request.QueryString("UserID")%>',
                     };
                 }
                   //Change Allocation Request
                 if (MSGID == 543) {
                    // $(document).removeAttr("title", "");
                     //$(document).attr("title", "Change Allocation");
                     EmailParameters = {
                         msgID: MSGID,
                         strResourceRequestID: '<%= Request.QueryString("ResourceCARequestID")%>',
                         strProjectID: '<%= Request.QueryString("ProjectID")%>',
                         intUserID: '<%= Request.QueryString("UserID")%>',
                     };
                 }
                 //Extend Booking
             if (MSGID == 80) {
                 // $(document).removeAttr("title", "");
                 //$(document).attr("title", "Extend Booking");
                 EmailParameters = {
                     msgID: MSGID,
                     strResourceRequestID: '<%= Request.QueryString("ResourceExtendRequestID")%>',
                     strProjectID: '<%= Request.QueryString("ProjectID")%>',
                     intUserID: '<%= Request.QueryString("UserID")%>',
                 };
             }

           
             //For Lessonlearnt
             //For Lessonlearnt

             // Added By Rutuja on 4th Dec 2019 
             // Added for For Resource Request List Assign And Reject Functionality
             if (MSGID == 203 || MSGID == 503) {
                 if (MSGID == 503) {
                     // $(document).removeAttr("title", "");
                     // $(document).attr("title", "Resource Assignment");
                 }
                 else {
                     //$(document).removeAttr("title", "");
                     // $(document).attr("title", "Resource Rejection");
                 }
                 EmailParameters = {
                     msgID: MSGID,
                     intRequestID: '<%= Request.QueryString("RequestID")%>',
                     strEmployeeID: '<%= Request.QueryString("EmployeeID")%>',
                     intUserID: '<%= Request.QueryString("UserID")%>'
                 };
             }
             // End For Resource Request List Assign And Reject Functionality

             // Added for For Resource Request List Send Email Functionality
             if (MSGID == 75) {
                 //$(document).removeAttr("title", "");
                 //$(document).attr("title", "Resource Allocation Request");
                 EmailParameters = {
                     msgID: MSGID,
                     intRequestID: '<%= Request.QueryString("RequestID")%>',
                 };
             }
              // End For Resource Request List Send Email Functionality
             // End Added By Rutuja on 4th Dec 2019 
             //Added on 27-12-2022
             if (MSGID == 426 || MSGID == 427 || MSGID == 430 || MSGID == 432 || MSGID == 539 || MSGID == 499 || MSGID == 502) {
                 EmailParameters = {
                     msgID: MSGID,
                     intEmployeeID: '<%= Request.QueryString("EmployeeID")%>',
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                 };
             }

             //Change Allocation Request
             if (MSGID == 543) {
                 // $(document).removeAttr("title", "");
                 //$(document).attr("title", "Change Allocation");
                 EmailParameters = {
                     msgID: MSGID,
                     strResourceRequestID: '<%= Request.QueryString("ResourceCARequestID")%>',
                         strProjectID: '<%= Request.QueryString("ProjectID")%>',
                         intUserID: '<%= Request.QueryString("UserID")%>',
                     };
             }

             //Comment and added by Riddhesh Patil on 21 Feb 2023
               //if (MSGID == 542 || MSGID == 543) {
                // EmailParameters = {
                  //   msgID: MSGID,
                 //    RequestId: '<%= Request.QueryString("RequestID")%>',
                // };
            // }
             //End of Comment and added by Riddhesh Patil on 21 Feb 2023

             if (MSGID == 542) {
                 EmailParameters = {
                     msgID: MSGID,
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                 };
             }
           
             if (MSGID == 541) {
                 EmailParameters = {
                     intEmployeeID: '<%= Request.QueryString("EmployeeID")%>',
                     msgID: MSGID,
                     RequestId: '<%= Request.QueryString("RequestID")%>',
                 };
             }
             if (MSGID == 76) {
                 EmailParameters = {
                     msgID: MSGID,
                     strEmployeeID: '<%= Request.QueryString("EmployeeID")%>',
                     intRequestID: '<%= Request.QueryString("RequestId")%>',
                      intUserID: '<%= Session("intUserID")%>'
                  };
             }

             //Added By Dipali V On 2nd Oct 2023 For Send For Approval
             if (MSGID == 3) {

                 var UserID = '<%= Request.QueryString("UserID")%>';
                 var TimeSheetID = '<%= Request.QueryString("TimeSheetID")%>';
                 var ProjectID = '<%= Request.QueryString("ProjectID")%>';

                 EmailParameters = {
                     msgID: MSGID,
                     TimeSheetID: TimeSheetID,
                     LoginUserID: UserID,
                     intProjectID: ProjectID,
                 };
             }
             // Added By Dipali On 7th Nov 2023 For Submit IR
             if (IRFlag != 1) {
                 if (MSGID == 51 ) {

                     var UserID = '<%= Request.QueryString("UserID")%>';
                     var RFID = '<%= Request.QueryString("RFID")%>';
                     var ProjectID = '<%= Request.QueryString("ProjectID")%>';

                     EmailParameters = {
                         msgID: MSGID,
                         RFID: RFID,
                         LoginUserID: UserID,
                         intProjectID: ProjectID,
                     };
                 }

             }

             //Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
             if (MSGID == 35013 || MSGID == 35016) {

                 EmailParameters = {
                     msgID: MSGID,
                     intEmployeeID: SessionEmployeeId,
                 };
             }
             if (MSGID == 35014 || MSGID == 35015 || MSGID == 35017 || MSGID == 35018) {

                 EmailParameters = {
                     msgID: MSGID,
                     intEmployeeID: SessionEmployeeId,
                     strEmployeeID: '<%= Request.QueryString("SubmitterIDs")%>',
                 };
             }
             //End of Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
              
             return EmailParameters;

         }    

            function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];

            }
            return vars;
        }
         function PlotEmailSection(EmailMessageList) {
             // 
             for (var i = 0; i < EmailMessageList.length; i++) {
                 var EmailObject = EmailMessageList[i];
                 var FromEmailID = EmailObject.FromEmailID;
                 var ToEmailID = EmailObject.ToEmailID.replace(" ","");
                 var CCToEmailID = EmailObject.CCToEmailID;
                 var Subject = EmailObject.Subject;
                 var Message = EmailObject.Message;
                 //alert(FromEmailID);

                 $("#txtFromEmailID").val(FromEmailID);
                 $("#txtToEmailID").val(ToEmailID);
                 $("#txtCCEmailID").val(CCToEmailID);
                 $("#txtSubject").val(Subject);
                 $("#txtMessage").val(Message);
                 if (EmailObject.IsAttachment) {
                     $("#tr_tblFiles").show();
                     $("#tbody_tblFiles").html('');
                     var tbody = "";
                     tbody = '<tr class="clsTREven" id="FILENAME0">';
                     tbody += '<td title="File Name">' + EmailObject.FileName + '</td>';
                     tbody += '<td><a class="" style="" href="Javascript:RemoveAttachement(0)" title="Remove Attachment">(Remove)</a></td></tr>';
                     tbody += '<input type="hidden" id="hdncount" value="1">';
                     tbody += '<input type="hidden" name="txtFilePath" id="txtFilePath" class="clsTextBox" style="text-align:Left" value="' + EmailObject.FilePath + '">';
                     tbody += '<input type="hidden" name="txtFileHref" id="txtFileHref" class="clsTextBox" style="text-align:Left" value="">';
                     tbody += '<input type="hidden" name="txtFileName" id="txtFileName" class="clsTextBox" style="text-align:Left" value="">';
                     tbody += '<input type="hidden" name="txtParameter" id="txtParameter" class="clsTextBox" style="text-align:Left" value="">';
                     $("#tbody_tblFiles").html(tbody);
                 } else {
                     $("#tr_tblFiles").hide();
                     $("#tbody_tblFiles").html('');
                 }
             }
         }

           //function RemoveAttachement(FileNO) {

           //     var objTR = document.getElementById('FILENAME' + FileNO);
           //     var toRemoveFileControl = document.getElementById('txtFileName' + FileNO);
           //     var objFileGrid = document.getElementById('tblFiles');

           //     objFileGrid.deleteRow(objTR.rowIndex);

           //     if(toRemoveFileControl !=null)
           //         toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
           //     document.getElementById("txtFileName" + FileCount).disabled = false;;

           //     if (objFileGrid.rows.length == 1) {
           //         objFileGrid.style.display = 'none';
           //     }

           //     FileCount_toDisable--;
           // }
         function RemoveAttachement(FileNO) {

             var objTR = document.getElementById('FILENAME' + FileNO);
             var toRemoveFileControl = document.getElementById('txtFileName' + FileNO);
             var objFileGrid = document.getElementById('tblFiles');

             objFileGrid.deleteRow(objTR.rowIndex);

             if (toRemoveFileControl != null)
                 toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);

             if (objFileGrid.rows.length == 1) {
                 objFileGrid.style.display = 'none';
             }
         }
        
         //end vishal Mahajan 10-12-2019
         function SendMail() {
             if (IntQueryMessageID == 20004 || IntQueryMessageID == 20003) {
                 strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>';
             }
             //Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose(IntQueryMessageID == 51)
             else if (IntQueryMessageID == 76 || IntQueryMessageID == 426 || IntQueryMessageID == 427 || IntQueryMessageID == 430 || IntQueryMessageID == 432 || IntQueryMessageID == 541 || IntQueryMessageID == 542 || IntQueryMessageID == 539 || IntQueryMessageID == 502 || IntQueryMessageID == 499 || IntQueryMessageID == 51 || IntQueryMessageID == 55) {
                 var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
             }
              //End of Added by Vishal on 16th Nov 2023 for IR/PIR Send Email purpose
             else if (IntQueryMessageID == 3 || IntQueryMessageID == 51 || IntQueryMessageID == 55) { // Added By Dipali On 7th Nov 2023 For Submit IR
                 if (IRFlag != 1) {
                     var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
                 }
                 else {
                     var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
                 }
             }
             //Added by Ajit L 27/04/2024 for Metric
             else
                 if ( IntQueryMessageID == 35009 || IntQueryMessageID == 35010 || IntQueryMessageID == 35011) {
                     strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
                 }
                 //End of Added by Ajit L 27/04/2024 for Metric 
                 else
             {
                 var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
             }

             var FromEmailID = $("#txtFromEmailID").val();
             var ToEmailID = $("#txtToEmailID").val();
             var CCToEmailID = $("#txtCCEmailID").val();
             var Subject = $("#txtSubject").val();
             var Message = $("#txtMessage").val();
             var isAttachment = $("#tbody_tblFiles tr").length > 0 ? true : false;

             if (isAttachment == true) {
                 isAttachment = 1;
             }
             else {
                 isAttachment = 0;
             }


                 if (ValidateSendEmail() == true) {
                 //setFrameLoader();
                 var SendEmailParameters = {
                     strToEmailID: ToEmailID,
                     strCCToEmailID: CCToEmailID,
                     strFromEmailID: FromEmailID,
                     strSubject: Subject,
                     strMessage: Message,
                      IsAttachment: isAttachment,
                     FileName:isAttachment? URLEncode($("#txtFilePath").val()):"",
                     }
                    
                 $.ajax({
                     url: strUrl + '/api/SendEmail/SendEmailMessage',
                     type: "POST",
                     data: JSON.stringify(SendEmailParameters),
                     dataType: "json",
                     contentType: "application/json;charset-utf=8",
                     beforeSend: function (xhr) {
                         
                         if (IntQueryMessageID == 20004 || IntQueryMessageID == 20003) {
                             xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Issue"));
                             if (SendEmailParameters) {
                                 xhr.setRequestHeader("Params", encryptString(isJson(SendEmailParameters) ? SendEmailParameters : JSON.stringify(SendEmailParameters)));
                             }
                         }
                         else if (IntQueryMessageID == 76 || IntQueryMessageID == 426 || IntQueryMessageID == 427 || IntQueryMessageID == 430 || IntQueryMessageID == 432 || IntQueryMessageID == 541 || IntQueryMessageID == 542 || IntQueryMessageID == 539 || IntQueryMessageID == 502 || IntQueryMessageID == 499) {
                             xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                             if (SendEmailParameters) {
                                 xhr.setRequestHeader("Params", encryptString(isJson(SendEmailParameters) ? SendEmailParameters : JSON.stringify(SendEmailParameters)));
                             }
                         }
                         else if (IntQueryMessageID == 3 || IntQueryMessageID == 51 || IntQueryMessageID == 55) // Added By Dipali On 7th Nov 2023 For Submit IR
                         {

                             //Added By Dipali V On 2nd Oct 2023 For Project Timesheet SFA
                             if (IRFlag != 1) {
                                 xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                                 if (SendEmailParameters) {
                                     xhr.setRequestHeader("Params", encryptString(isJson(SendEmailParameters) ? SendEmailParameters : JSON.stringify(SendEmailParameters)));
                                 }
                             }
                             else {
                                 xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                                 if (SendEmailParameters) {
                                     xhr.setRequestHeader("Params", encryptString(isJson(SendEmailParameters) ? SendEmailParameters : JSON.stringify(SendEmailParameters)));
                                 }
                             }
                             //End of Added By Dipali V On 2nd Oct 2023 For Project Timesheet SFA

                         }    //Added by Ajit L on 27/09/2024 Start
                         else
                             if ( IntQueryMessageID == 35009 || IntQueryMessageID == 35010 || IntQueryMessageID == 35011) {
                                 xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                                 if (SendEmailParameters) {
                                     xhr.setRequestHeader("Params", encryptString(isJson(SendEmailParameters) ? SendEmailParameters : JSON.stringify(SendEmailParameters)));
                                 }
                             } //Added by Ajit L on 27/09/2024 End



                         else {
                             xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                             if (SendEmailParameters) {
                                 xhr.setRequestHeader("Params", encryptString(isJson(SendEmailParameters) ? SendEmailParameters : JSON.stringify(SendEmailParameters)));
                             }
                         }
                     },
                     success: function (data) {
                         console.log(data);
                         //alert(data)
                        // RemoveFrameLoader();

                         window.close();

                     },
                     error: function (err) {
                         console.log(err);
                           //alert(data)
                         //alert(data)
                         //Added By Usha Pandit On 11.05.2020 For loader continuously showing
                        // RemoveFrameLoader();
                         errMsg = "Failure Sending Mail.\n Unable to connect to remote server";
                         var errMsg = errMsg.replace(/\n/g, "<br />");
                         alertify.set('notifier', 'position', 'top-right');
                         alertify.error(errMsg);
                         //End Of Added By Usha Pandit On 11.05.2020 For loader continuously showing

                     }
                 });
             }


         }

         function ValidateSendEmail() {
             if ($("#txtToEmailID").val() == "") {
                 showAlert('To EmailID should not left blank.', 'alert-danger', 'btnSave')
                 $("#txtToEmailID").focus();
                 return false;
             }
             if ($("#txtSubject").val() == "") {
                 showAlert('Subject should not left blank.', 'alert-danger', 'btnSave')
                 $("#txtSubject").focus();
                 return false;
             }
             if ($("#txtMessage").val() == "") {

                 showAlert('Message Body should not left blank.', 'alert-danger', 'btnSave')
                 $("#txtSubject").focus();
                 return false;
             }
             if ($("#txtToEmailID").val() != "") {
                 if (validateMultipleEmailsCommaSeparated($("#txtToEmailID"), ',') == false) {
                     showAlert('Invalid Email ID.', 'alert-danger', 'btnSave')
                     $("#txtToEmailID").focus();
                     return false;
                 }
             }
             if ($("#txtCCEmailID").val() != "") {
                 if (validateMultipleEmailsCommaSeparated($("#txtCCEmailID"), ',') == false) {
                     showAlert('Invalid Email ID.', 'alert-danger', 'btnSave')
                     $("#txtCCEmailID").focus();
                     return false;
                 }
             }
             return true;

         }

         function validateMultipleEmailsCommaSeparated(check1, seperator) {
             //
             //
             var value = check1.val();
             var strEmailArray;
             ////Added By Rutuja D. on 17 March 2020 For accept ';' also in MailID issueid = 23174
             //if (value.indexOf(";") > -1) {
             //        value  = value.replace(";", ",");
             //    } else {
             //        value = value;
             //}
             ////End Added By Rutuja D. on 17 March 2020 For accept ';' also in MailID issueid = 23174
             if (value.charAt(value.trim().length - 1) == ";") {
                 strNewEmailList = value.substr(0, value.trim().length - 1);
             }
             //Ended
             else {
                 strNewEmailList = value;
             }


             if (strNewEmailList != '') {

                 if (strNewEmailList.indexOf(",") >= 1) {

                     var result = strNewEmailList.split(",");

                     for (var i = 0; i < result.length; i++) {

                         if (result[i] != '') {
                             if (!validateEmail(result[i])) {
                                 check1.focus();
                                 return false;
                             }
                         }
                 }
                 }
                 else if (strNewEmailList.indexOf(";") >= 1) {

                     var result = strNewEmailList.split(";");
                     for (var i = 0; i < result.length; i++) {

                         if (result[i] != '') {
                             if (!validateEmail(result[i])) {
                                 check1.focus();
                                 return false;
                             }
                         }
                 }
                 }
                 else {
                     var result = strNewEmailList;
                     if (!validateEmail(result)) {
                                 check1.focus();
                                 return false;
                             }
                 }
                 
             }





             //if (value.charAt(value.trim().length - 1) == ";") {
             //       strNewEmailList = value.substr(0, value.trim().length - 1);
             //   }
             //       //Ended
             //   else {
             //       strNewEmailList = value;
             //   }


             //if (strNewEmailList != '') {
             //    var result = strNewEmailList.split(seperator);

             //    for (var i = 0; i < result.length; i++) {

             //        if (result[i] != '') {
             //            if (!validateEmail(result[i])) {
             //                check1.focus();
             //                return false;
             //            }
             //        }
             //    }
             //}
             return true;
         }

         function validateEmail(field) {
             var regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
             return (regex.test(field)) ? true : false;
         }

         function showAlert(Msg, className, id) {
             $('.ClosaeblealertMsg').show();
             if (id != undefined) {
                 $('#' + id).prop("disabled", true);
             }
             if (className == 'alert-danger') {
                 $('#CloseableAlert').removeClass("alert-success");
                 $('#CloseableAlert').addClass("alert-danger");
             }
             else if (className == 'alert-success') {
                 $('#CloseableAlert').removeClass("alert-danger");
                 $('#CloseableAlert').addClass("alert-success");
             }
             $('#alertMsg').html(Msg);
             $('.ClosaeblealertMsg').delay(5000).fadeOut("fast", function () {
                 if (id != undefined) {
                     $('#' + id).prop("disabled", false);
                 }
             });
         }
     </script>
</body>
    
</html>
