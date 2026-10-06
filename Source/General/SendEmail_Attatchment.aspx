<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SendEmail_Attatchment.aspx.vb" Inherits="PbNIT.SendEmail_Attatchment" %>
<!DOCTYPE HTML>
<html>
 	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmSendEmail_Attatchment"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
		var objform=GetFormReference('frmSendEmail_Attatchment');
		var objdivlist=GetObjectReference('frmSendEmail_Attatchment','DivBody');
		'<%MyBase.InitializeResources("AppResources.SendEmail", "AppResources")%>';
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}			
		}
		
		function window_onresize()		
		{
			
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		function Send_OnClick()
			{
           
				var objTxt;
				var flag;
				
				objTxt = GetObjectReference('frmSendEmail_Attatchment','txtFromEmailID');
				if(objTxt.disabled==false)
				{
					flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_FROM_MAILID_EMPTY")%>',true);
					if(flag==true)
						return;
					
					flag = ValidateEmailID(objTxt.value);
					if(flag==false)
					{	
						alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
						objTxt.focus();
						return;
					}						
				}
					
				objTxt = GetObjectReference('frmSendEmail_Attatchment','txtToEmailID');
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_MAILID_EMPTY")%>',true);
				if(flag==true)
					return;
				
				flag = ValidateEmailID(objTxt.value);
				if(flag==false)
				{	
					alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
					objTxt.focus();
					return;
				}
				
				objTxt = GetObjectReference('frmSendEmail_Attatchment','txtCCToEmailID');
				if(objTxt.value!=" " || objTxt.value!="")
				{
					flag = ValidateEmailID(objTxt.value);
					if(flag==false)
					{	
						alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
						objTxt.focus();
						return;
					}
				}
				
				objTxt = GetObjectReference('frmSendEmail_Attatchment','txtSubject');
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_SUBJECT_EMPTY")%>',true);
				if(flag==true)
					return;
				
				objTxt = GetObjectReference('frmSendEmail_Attatchment','txtMessage');
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_MESSAGE_EMPTY")%>',true);
				if(flag==true)
					return;
				
				if(flag==false)
				{
					objform.action = "SendEmail_Attatchment.aspx?Action=<%=CONST_ACTION_SEND%>&Mode=<%=CONST_MAIL%>&MessageID=<%=m_lngMessageID%>&IssueID=<%=m_lngIssueID%>&QueryID=<%=m_lngQueryID%>";
					objform.submit();
				}
			}
			
			function ValidateEmailID(strEmailList)
			{			
				var strEmailArray;
				var intCtr
				var strNewEmailList;
				if( strEmailList == "")
				{
					return false;
				}
			    //Added By NikitaD of Send Mail functionality in 4.0
                if (strEmailList.charAt(strEmailList.length - 1) == ";") {
                    //Added By Reshma Chavan on 20th Dec 2021 Invalid email Msg
                    strEmailList = strEmailList.substring(0, strEmailList.length - 1);
                    //End of Added By Reshma Chavan on 20th Dec 2021 Invalid email Msg
				    strNewEmailList = strEmailList.substr(0, strEmailList.length - 2);
				}
				else {
				    strNewEmailList = strEmailList;
                }
                if (strEmailList.charAt(strEmailList.trim().length - 1) == ",") {
                    strNewEmailList = strEmailList.substr(0, strEmailList.trim().length - 1);
                }
				strNewEmailList = strNewEmailList.replace(/ /g, '');
			    //End Added By NikitaD of Send Mail functionality in 4.0
				objRegularExp = new RegExp("[\\,,\\ ,\\;]")						
				strEmailArray = strEmailList.split(objRegularExp);
				
				if ( strEmailArray.length == 0 )
					return false;
				
				for(intCtr = 0; intCtr < strEmailArray.length; intCtr++)
				{				
					if(isEmail(strEmailArray[intCtr]) == false)
					{
						//alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
						return false;
					}				
				}				
				return true;				
			}	
			
			function isEmail(str) 
			{
				/*
				'=====================================================================
				' Procedure Name        :   isEmail
				' Description           :   Generic function which validates if the Email Id entered by the user
				'							is in a proper format.	
				' Purpose               :   To Validate the email id is in proper format or not
				' Parameters Passed     :   Email ID which is to be validated
				' Returns               :
				' Parameters Affected   :   None
				' Assumptions           :
				' Dependencies          :
				' Author                :   UmaB
				' Created               :   11th September 2000
				' Revisions             :
				'=====================================================================
				*/		
					// Are regular expressions supported ?
					var supported = 0;
					
					if (window.RegExp) 
					{
						var tempStr = "a";
						var tempReg = new RegExp(tempStr);
						if (tempReg.test(tempStr)) supported = 1;
					}
					
					if (!supported) 
						return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);
					
					var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
					var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");
					
					return (!r1.test(str) && r2.test(str));
					
				}	
				
				function OpenFile(FileName)
				{
					//Added by PrashantSJ on 6th June 2007 For WhizibleSEM 7.0 Build3 
					//Purpose: To avoid crash when filename having special character (encodeURIComponent)
					window.open("../RFI/RFI_Viewinvoice.aspx?FileName=" + encodeURIComponent(FileName),"_popup"); 
					//End of addition by PrashantSJ on 6th June 2007
				}
				

		
	</Script>
  </body>
</html>
