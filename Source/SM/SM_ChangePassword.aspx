<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<script src="../PasswordManagement/Ajax_XMLHttp.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    #PageDiv table:first-child tr td:last-child
    {
      /*Commented by Yogesh Jalamkar on 27-OCT-2016*/
        /*text-align:center;*/ /*Added By Vaijat K ON 23/11/2015*/
       
    }
    @media only screen and (max-width: 767px)
    {
        .footerMenuTable
        {
            position: relative !important;
            bottom: 0px !important;
            /* right: 2px; */
            visibility: visible !important;
        }
    }

     /*Added by Yogesh Jalamkar on 27-OCT-2016 Purpose: Euronet Customization*/
    #PageDiv .clsTable {
        border-collapse:separate;
        border-spacing:1em;
        font-size:14px;
    }
    #PageDiv .clsTable td {
      font-size:14px !important;
    }
     label#lblError
    {
        color: #ff0000 !important;
        width: 100% !important;
        height: 12px ;
        font-family: Arial, Helvetica, sans-serif !important;
        font-size: 12px !important;
        text-decoration: none !important;
        font-weight:lighter;
    }
    td.clsTDGroupFooter
     {
            background:none !important;
     }
    /*End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose: Euronet Customization*/
    /*Added by Dhanashri S on 28 Nov 2015*/
    /*#PageDiv
    {
        height: 125px !important;
    }*/
    /*End of Addition by Dhanashri S on 28 Nov 2015*/
</style>

<script type="text/javascript">


</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_ChangePassword.aspx.vb" Inherits="PbNIT.SM_ChangePassword" %>

<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Change Password")%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmChangePassword" method="post" runat="server">
			<%PageInit%>
            <input type="hidden" name="NonDataBase3" id="NonDatabase3" />
		</form>
		<script type="text/javascript">
		var objform=GetFormReference('frmChangePassword');
		var objdivlist=GetObjectReference('frmChangePassword','PageDiv');
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist != null) {
			    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 23;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop-24;
			    if (intDivHeight < 100) intDivHeight = 100;
			    
                //Commented and Added by Dhanashri S on 7 Dec 2015
			    //objdivlist.style.height = intDivHeight - 200 + 'px';
			  
			    objdivlist.style.height = intDivHeight + 'px';
                //End of Comment and Addition by Dhanashri S on 7 Dec 2015
			    
			}
			setFocus(GetObjectReference('frmChangePassword', 'txtLoginName'));

			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 23;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 24;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}
		}	
		function SetPassword_OnClick()
		{
		  	if (Validate() == true)
			{
			   var objtxtLoginName = GetObjectReference('frmChangePassword','txtLoginName'); 
			    if(objtxtLoginName != null) 
			    {
			        objtxtLoginName.disabled=false;
			    }
		  	    //Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
			    var MenuTags = document.getElementsByTagName('A');
			    for (i = 0; i < MenuTags.length; i++) {
			        if (MenuTags[i].className == "Menu") {
			            //MenuTags[i].style.display= "none";
			            MenuTags[i].parentNode.style.display = "none";
			        }
			    }
			    setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
		  	    //End Of Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
			    objform.action = "../SM/SM_ChangePassword.aspx?Mode=SetPassword&FirstTimeLogin=<%=Request.QueryString("FirstTimeLogin")%>";
				objform.submit();
				
			}
		}
		function Validate()
		{
            var blnEnablePassLength = '<%=m_blnEnablePassLength %>';
			var intMinPassLen = '<%=m_intMinPassLen %>';
			var intMaxPassLen = '<%=m_intMaxPassLen %>';
			var blnEnableAlphaNumSpeChar = '<%=m_blnEnableAlphaNumSpeChar %>';
			var intNumberOfAlpha = '<%=m_intNumberOfAlpha %>';
			var intNumberOfNumerals = '<%=m_intNumberOfNumerals %>';
			var intNumberOfSpecialChars = '<%=m_intNumberOfSpecialChars %>';
		    var blnAllowSameLoginPwd = '<%=m_blnAllowSameLoginPwd %>';

		    //Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
		    var EnablePassPharsesDays = '<%=m_blnEnablePassPharsesDays%>';
		    var PassPharsesDays = '<%=m_intPassPharsesDays%>';
		    var EnablePreviousPassCheck = '<%=m_blnEnablePreviousPassCheck%>'; 
		    var PreviousPassCount = '<%=m_intPreviousPassCount%>';
		    var EnablePassLockoutDuration = '<%=m_blnEnablePassLockoutDuration%>';
		    var PassLockoutDuration = '<%=m_intPassLockoutDuration%>';
		    var EnableLockUserID = '<%=m_blnEnableLockUserID%>';
		    var PassLockingCount = '<%=m_intPassLockingCount%>';
		    var PassCaptchaCount = '<%=m_intPassCaptchaCount%>';
		    //End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization

			var intCurrAlphaCount=0;
			var intCurrNumCount=0;
			var intCurrSpecCount=0;
			var intAsciiValue;
			var strAlertMsg; 
			var AuthenticationType='<%=strAuthenticationType %>';
			var stralphacharset = '65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122';
			var strnumeralcharset = '48 49 50 51 52 53 54 55 56 57';
			var strspecialcharset = '32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 58 59 60 61 62 63 64 91 92 93 94 95 96 123 124 125 126 127';
		
			var objLoginName = GetObjectReference('frmChangePassword', 'txtLoginName');
			var objOldPwd = GetObjectReference('frmChangePassword', 'txtOldPassword');
			var objNewPwd = GetObjectReference('frmChangePassword', 'txtNewPassword');
			var objConfirmPwd = GetObjectReference('frmChangePassword', 'txtConfirmPassword');
		    <%MyBase.InitializeResources("Resources.SM_ChangePassword", "Resources")%>

		    var hdCount = GetObjectReference("frmCommonPage", "NonDatabase3");
		    //Added By Vaijat K ON 24/07/2017 For Password Encryption
		    var strEncryptionKey = "";
		    var strEncryptedNewPwd = "";
		    var strEncryptedOldPwd = "";
		    var strEncryptedConPwd = "";
		    $.ajax({
		        type: "GET",
		        contentType: "application/json; charset=utf-8",
		        url: "../General/XmlHTTP.aspx?TagID=99999&Action=ValidateUserName&UserName=" + objLoginName.value,
		        async: false,
		        success: function (data) {

		            strEncryptionKey = data;
		        },
		        error: function (result) {

		        }
		    })

		    if (hdCount != null)
		        hdCount.value = strEncryptionKey.length;
		    //End Added By Vaijat K ON 24/07/2017 For Password Encryption


            //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		  //if (objLoginName != null && disallowBlank(objLoginName, '<%=MyBase.GetResourceString("VALIDATION_MSG1")%>') == true)
			//{
			//	return false;
			//}
		    if (objLoginName != null && objLoginName.value == '')
		    {
		        lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG1")%>'.replace("&#39; ", "' ").replace("&#39;", "'");
		    	return false;
		    }
				//if (objOldPwd != null && disallowBlank(objOldPwd, '<%=MyBase.GetResourceString("VALIDATION_MSG2")%>') == true)
			//{
			//	return false;
		    //}
		    if (objOldPwd != null && objOldPwd.value == '')
		    {
		        lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG2")%>'.replace("&#39; ", "' ").replace("&#39;", "'");
		        return false;
		    }
			//if (objNewPwd != null && disallowBlank(objNewPwd, '<%=MyBase.GetResourceString("VALIDATION_MSG3")%>') == true)
			//{
			//	return false;
		    //}
		    if (objNewPwd != null && objNewPwd.value=='')
		    {
		        lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG3")%>'.replace("&#39; ", "' ").replace("&#39;", "'");
		        return false;
		    }
			//if (objConfirmPwd != null && disallowBlank(objConfirmPwd, '<%=MyBase.GetResourceString("VALIDATION_MSG4")%>') == true)
			//{
			//	return false;
			//}
		    if (objConfirmPwd != null && objConfirmPwd.value == '') {
		        lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG4")%>'.replace("&#39; ", "' ").replace("&#39;", "'");
		        return false;
		    }
			//if (objNewPwd != null && objConfirmPwd != null && disallowValue1NotEqualToValue2(objConfirmPwd, objNewPwd, '<%=MyBase.GetResourceString("VALIDATION_MSG6")%>') == true)
			//{
			//	return false;
		    //}
		    if (objNewPwd != null && objConfirmPwd != null && objNewPwd.value != objConfirmPwd.value) {
		        lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG6")%>'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39; ", "' ").replace("&#39;", "'");
		        return false;
		    }
		    var strNewPass = objNewPwd.value;
		    var strConPass = objConfirmPwd.value;
		    var strOldPass = objOldPwd.value;
		    //Added By Vaijat K ON 24/07/2017 For Password Encryption
		    for (var i = strOldPass.length - 1, len = 0; i >= 0; i--) {
		        strEncryptedOldPwd += strOldPass[i] + strEncryptionKey + '|';
		    }

		    for (var i = strNewPass.length - 1, len = 0; i >= 0; i--) {
		        strEncryptedNewPwd += strNewPass[i] + strEncryptionKey + '|';
		        strEncryptedConPwd += strConPass[i] + strEncryptionKey + '|';
		    }
		    //End Added By Vaijat K ON 24/07/2017 For Password Encryption

		    //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label

		    if (objOldPwd != null && objNewPwd != null && objOldPwd.value == objNewPwd.value) {
		        lblError.textContent = 'The &#39;Old Password&#39; and &#39;New Password&#39; fields should not be same.'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39; ", "' ").replace("&#39;", "'");
		        return false;
		    }

			 <% If ((strAuthenticationType = "N" OrElse strAuthenticationType = "M") AndAlso blnFirstTimeLogin = True) Then%>
		    //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		        // if (objOldPwd != null  && objNewPwd != null && disallowValue1EqualToValue2(objOldPwd, objNewPwd, '<%=MyBase.GetResourceString("VALIDATION_MSG11")%>') == true)
			//{
			//	return false;
		    //}
		    if (objOldPwd != null && objNewPwd != null && objOldPwd.value == objNewPwd.value)
		    {
		        lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG11")%>'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39;", "'");
		    	return false;
		    }
		    //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
            <%End If %>
            
			 <% If ((strAuthenticationType = "N" OrElse strAuthenticationType = "M") AndAlso m_blnAllowSameLoginPwd = True) Then%>
		    //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		     //  if (objLoginName != null  && objNewPwd != null && disallowValue1EqualToValue2(objLoginName, objNewPwd, '<%=MyBase.GetResourceString("VALIDATION_MSG10")%>') == true)
			//{
			//	return false;
		    //   }
		    if (objLoginName != null && objNewPwd != null && objLoginName.value == objNewPwd.value) {
		        lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG10")%>'.replace("&#39; ", "' ").replace("&#39;", "'");
		        return false;
		    }
		    //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
            <%End If %>
            
            //  Added by SujitG on 03 Sep 2010
	
		    if ((AuthenticationType == 'N' || AuthenticationType == 'M') && blnEnablePassLength == 'True') {
		        if (objNewPwd != null && intMinPassLen > TrimAll(objNewPwd.value).length) {
		            strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG7")%>';
		            strAlertMsg = strAlertMsg.replace('<MINPASSWORDLENGTH>', intMinPassLen);
		            //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		            //alert(strAlertMsg);
                    lblError.textContent = strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'");
		            //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		            objNewPwd.focus();
		            return false;
		        }
		        if (objNewPwd != null && intMaxPassLen < TrimAll(objNewPwd.value).length) {
		            strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG8")%>';
		            strAlertMsg = strAlertMsg.replace('<MAXPASSWORDLENGTH>', intMaxPassLen);
		            //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
                   //  alert(strAlertMsg);
		            lblError.textContent = strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'");
		            //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		            objNewPwd.focus();
		            return false;
		        }
		    }
		    else {
		        if (objNewPwd != null && TrimAll(objNewPwd.value).length < 6) {
		            //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		          //  alert('<%=MyBase.GetResourceString("VALIDATION_MSG5")%>');	        
                 lblError.textContent = '<%=MyBase.GetResourceString("VALIDATION_MSG5")%>'.replace("&#39; ", "' ").replace("&#39;", "'");
		         //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
                			    setFocus(objNewPwd);
                			    return false;
                			}
		    }
            
		    if ((AuthenticationType == 'N' || AuthenticationType == 'M') && blnEnableAlphaNumSpeChar == 'True')
            {
                if(objNewPwd!=null)
                {
                    newPass = objNewPwd.value;
                    for(i=0;i<newPass.length;i++)
                    {
                        intAsciiValue = newPass.charCodeAt(i);
                        if (stralphacharset.indexOf(intAsciiValue) >= 0) 
                        {
                            intCurrAlphaCount = parseInt(intCurrAlphaCount)+1;    
                        }
                        if (strnumeralcharset.indexOf(intAsciiValue) >= 0) 
                        {
                            intCurrNumCount = parseInt(intCurrNumCount)+1;    
                        }
                        if (strspecialcharset.indexOf(intAsciiValue) >= 0) 
                        {
                            intCurrSpecCount = parseInt(intCurrSpecCount)+1;    
                        }
                    }   
                }      
                if(intCurrAlphaCount < intNumberOfAlpha || intCurrNumCount < intNumberOfNumerals || intCurrSpecCount < intNumberOfSpecialChars)
                {
                    strAlertMsg='<%=MyBase.GetResourceString("VALIDATION_MSG9")%>';
		            strAlertMsg=strAlertMsg.replace('<NUMBEROFALPHABETS>',intNumberOfAlpha);
		            strAlertMsg=strAlertMsg.replace('<NUMBEROFNUMERALS>',intNumberOfNumerals);
		            strAlertMsg=strAlertMsg.replace('<NUMBEROFSPECIALCHAR>',intNumberOfSpecialChars);

		            strAlertMsg = strAlertMsg.replace('alphabets', 'alphabet(s)');
		            strAlertMsg = strAlertMsg.replace('numerals', 'numeral(s)');
		            strAlertMsg = strAlertMsg.replace('characters', 'character(s)');
                    //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
                    //  alert(strAlertMsg);
		            lblError.textContent = strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'");
                    //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
                    objNewPwd.focus();
                   
                    return false;
                }
            }
            
		    //  End of intCurrAlphaCount by SujitG on 03 Sep 2010
		    //Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization
		    if (('<%=strAuthenticationType%>' == 'N' || '<%=strAuthenticationType%>' == 'M') && (EnablePreviousPassCheck == 'True')) {
		        //Commented And Added By Vaijat K ON 24/02/2017 
		        //var strURL = 'Action=CHECKLASTENTEREDPWDS&LoginName=' + objLoginName.value + '&NewPassword=' + objNewPwd.value + '';
		        var strURL = 'Action=CHECKLASTENTEREDPWDS&LoginName=' + objLoginName.value + '&NewPassword=' + strEncryptedNewPwd + "&AuthNo=" + strEncryptionKey.length;
		        //End Commented And Added By Vaijat K ON 24/02/2017 
		        var strResult = ValidateData(strURL, 0, 0, 0);

		        if (strResult == '1') {
		            //Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		           // alert("Password should not be same as last " + PreviousPassCount + " passwords!");
		            //lblError.textContent = "Password should not be same as last " + PreviousPassCount + " passwords!";
		            lblError.textContent = "As per password policy, New password should not be same as previous " + PreviousPassCount + " passwords!";
		            //End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Show validation msgs on Label
		            return false;
		        }		       
		    }
		    //End of Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization
		    objNewPwd.value = strEncryptedNewPwd;
		    objConfirmPwd.value = strEncryptedConPwd;
		    objOldPwd.value = strEncryptedOldPwd;
			return true;
		}
		    //Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization

		    var g_sResponseText = '';
		    var g_oValidateXMLHttp;
		    function ValidateData(strURL, MasterTagID, ParentTagID, strFocusOnControl) {
		        //start .Added mode option in parameter list to the function         
		        var blnPROGFlag = (arguments.length > 5) ? arguments[5] : 0;
		        //End
		        var strResult;
		        var strNavigator;
		        g_sResponseText = '';
		        strNavigator = navigator.appName;
		        strNavigator = strNavigator.toUpperCase();
		        var browser = isIE();


		        strURL = "../PasswordManagement/Ajax_XMLHttp.aspx?MasterTagID=" + MasterTagID + "&ParentTagID=" + ParentTagID + "&" + strURL;


		        if (browser == 'IE') {
		            g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
		            //hook the event handler
		            g_oValidateXMLHttp.onreadystatechange = GetResponseText;
		            //prepare the call, http method=GET, false=asynchronous call
		            g_oValidateXMLHttp.open("GET", strURL, false);
		            //finally send the call
		            g_oValidateXMLHttp.send();
		        }
		        else {
		            // Mozilla - based browser 
		            g_oValidateXMLHttp = new XMLHttpRequest();
		            //hook the event handler
		            g_oValidateXMLHttp.onreadystatechange = GetResponseText();
		            //prepare the call, http method=GET, false=asynchronous call
		            g_oValidateXMLHttp.open("GET", strURL, false);
		            //finally send the call
		            g_oValidateXMLHttp.send(null);
		        }

		        if (g_oValidateXMLHttp.responseText != null) {
		            strResult = g_oValidateXMLHttp.responseText;
		        }
		        return strResult;
		    }



		    function GetResponseText() {
		        if (g_oValidateXMLHttp.readyState == 4) {
		            if (g_oValidateXMLHttp.responseText != null) {
		                g_sResponseText = g_oValidateXMLHttp.responseText;
		            }
		        }
		    }
		    //End of Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization
		    //Added By Bharat T on 28th-Oct-2016 for Euronet Password Policy Customization
		    function LoginAgain_OnClick()
            {
		        window.location.href = '../../default.aspx';
            }
		    //End of Added By Bharat T on 28th-Oct-2016 for Euronet Password Policy Customization
		</script>
	</body>
</HTML>
