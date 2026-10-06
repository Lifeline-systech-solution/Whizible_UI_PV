<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SendEmail.aspx.vb" Inherits="Whizible.SendEmail" %>

<!DOCTYPE HTML>
<html>
<head>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%>--%> 
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
	<script type="text/javascript" src="../../responsive/responsive.js"></script>
    <style>
        @media only screen and (min-width: 767px) {
            form > table:last-child {
                display: table;
            }
        }
		 
        @media only screen and (max-width: 767px) {
            form > table:last-child {
                display: none;
            }
        }
    </style>
</head>
<%--commented ended by Shamkant s--%>
<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
<body ms_positioning="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmSendEmail" name="frmSendEmail" method="post" runat="server">
        <%PageInit()%>
        <input type="hidden" name="hdToken" id="hdToken" value="<%=Session("CSRFTokenSM")%>" />
    </form>
    <script language="javascript">
        var objdivlist;
        var objform;

        objform = GetFormReference('frmSendEmail');
        objdivlist = GetObjectReference('frmSendEmail', 'DivBody');

        //Modified By NileshD on 8th Sep 2005
        '<%MyBase.InitializeResources("Resources.SendEmail", "Resources")%>';
			//End Of Modification By NileshD on 8th Sep 2005


			//Added by Dhanashri S on 11 Dec 2015 for IssueID:2530
			function WhichBrowser() {

			    var brwser = '';
			    var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
			    if (/trident/i.test(M[1])) {
			        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
			        //return 'IE '+(tem[1] || '');
			        return 'IE';
			    }
			    if (M[1] === 'Chrome') {
			        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
			        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
			        brwser = 'CR';
			    }
			    else if (M[1] === 'Firefox') {
			        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
			        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
			        brwser = 'FF';
			    }
			    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
			    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
			    //return M.join(' ');
			    return brwser;
			}
			//End of Addition by Dhanashri S on 11 Dec 2015

			function window_onload() {
			    //Commented and Added Dhanashri S on 11 Dec 2015 for IssueID:2530

			    //var intDivHeight ;
			    //var intDivHeightRisk;
			    //if (navigator.appName == 'Netscape')
			    //{
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 15;
			    //   // window.innerHeight
			    //}
			    //else
			    //{
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //    alert(intDivHeight)
			    //}
			    //if (intDivHeight < 100)
			    //intDivHeight = 100;
			    ////objdivlist.style.height = intDivHeight;
			    //objdivlist.style.height = intDivHeight + 'px';


			    var intDivHeight;
			    var intDivHeightRisk;

			    if (WhichBrowser() == 'IE') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;

			    }
			    else if (WhichBrowser() == 'FF') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;

			    }
			    else if (WhichBrowser() == 'CR') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
			    }
			    else {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;
			    }
			    if (intDivHeight < 100)
			        intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + 'px';
			    //End of Comment and Addition by Dhanashri S on 11 Dec 2015

                //Added By Usha Pandit On 09.08.2020 For setting focus in IE browser
                var browser = isIE();
                if (browser == 'IE') {
                    setTimeout('self.focus()', 2);
                }
                //End Of Added By Usha Pandit On 09.08.2020 For setting focus in IE browser
			}
			function window_onresize() {
			    //Commented and Added Dhanashri S on 11 Dec 2015 for IssueID:2530

			    //var intDivHeight;
			    //var intDivHeightRisk;
			    //	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //if (intDivHeight < 100)
			    //	intDivHeight = 100;
			    //objdivlist.style.height = intDivHeight;

			    var intDivHeight;
			    var intDivHeightRisk;

			    if (WhichBrowser() == 'IE') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;

			    }
			    else if (WhichBrowser() == 'FF') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;

			    }
			    else if (WhichBrowser() == 'CR') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
			    }
			    else {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;
			    }
			    if (intDivHeight < 100)
			        intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + 'px';
			    //End of Comment and Addition by Dhanashri S on 11 Dec 2015
			}
		function Send_OnClick() {
			//debugger;
			    var objTxt;
			    var flag;

			    objTxt = GetObjectReference('frmSendEmail', 'txtFromEmailID');
			    if (objTxt.disabled == false) {
			        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_FROM_MAILID_EMPTY")%>', true);
				    if (flag == true)
				        return;

				    flag = ValidateEmailID(objTxt.value);
				    if (flag == false) {
				        alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
					    objTxt.focus();
					    return;
					}
                }

                objTxt = GetObjectReference('frmSendEmail', 'txtToEmailID');
                flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_MAILID_EMPTY")%>', true);
				if (flag == true)
				    return;

				flag = ValidateEmailID(objTxt.value);
				if (flag == false) {
				    alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
				    objTxt.focus();
				    return;
				}

                objTxt = GetObjectReference('frmSendEmail', 'txtCCToEmailID');
                if (objTxt.value != '') {
                    flag = ValidateEmailID(objTxt.value);
                    if (flag == false) {
                        alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
					    objTxt.focus();
					    return;
					}
                }

                objTxt = GetObjectReference('frmSendEmail', 'txtSubject');
                flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_SUBJECT_EMPTY")%>', true);
				if (flag == true)
				    return;

				objTxt = GetObjectReference('frmSendEmail', 'txtMessage');
				flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_MESSAGE_EMPTY")%>', true);
				if (flag == true)
				    return;

				if (flag == false) {
				    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
				    var MenuTags = document.getElementsByTagName('A');
				    for (i = 0; i < MenuTags.length; i++) {
				        if (MenuTags[i].className == "Menu") {
				            //MenuTags[i].style.display= "none";
				            MenuTags[i].parentNode.style.display = "none";
				        }
				    }
				    setFrameLoader();
				    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
                    objform.action = "SendEmail.aspx?MasterTagID=-303&Action=<%=CONST_ACTION_SEND%>&Mode=<%=CONST_MAIL%>&MessageID=<%=m_lngMessageID%>&IssueID=<%=m_lngIssueID%>&QueryID=<%=m_lngQueryID%>";
				    objform.submit();
                }
            }

            function ValidateEmailID(strEmailList) {
                var strEmailArray;
                var intCtr
                var strNewEmailList
                if (strEmailList == "") {
                    return false;
                }
                //Added By NikitaD of Send Mail functionality in 4.0
                //Added by swapnil aswale on 31/3/2016
                //if (strEmailList.charAt(strEmailList.length - 2) == ";") {
                if (strEmailList.charAt(strEmailList.trim().length - 1) == ";") {
                    strNewEmailList = strEmailList.substr(0, strEmailList.trim().length - 1);
                }
                    //Ended
                else {
                    strNewEmailList = strEmailList;
                }
                //Added By Nikhil A for removing comma at the end of Eamil Address
                if (strEmailList.charAt(strEmailList.trim().length - 1) == ",") {
                    strNewEmailList = strEmailList.substr(0, strEmailList.trim().length - 1);
                }
                    
                 //End Of Added By Nikhil A for removing comma at the end of Eamil Address
                strNewEmailList = strNewEmailList.replace(/ /g, '');
                //End Added By NikitaD of Send Mail functionality in 4.0
                objRegularExp = new RegExp("[\\,,\\ ,\\;]")
                strEmailArray = strNewEmailList.split(objRegularExp);

                if (strEmailArray.length == 0)
                    return false;

                for (intCtr = 0; intCtr < strEmailArray.length; intCtr++) {
                    if (isEmail(strEmailArray[intCtr]) == false) {
                        //alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
                        return false;
                    }
                    //Added By Aniruddh Gujar on 20-Sep-2017 Purpose::To validate the mail domains
                    isValidEmailDomain(strEmailArray[intCtr]);
                    //End of Added By Aniruddh Gujar on 20-Sep-2017 Purpose::To validate the mail domains
                }
                return true;
            }
            //Added By Aniruddh Gujar on 20-Sep-2017 Purpose::To validate the mail domains
            function isValidEmailDomain(str) {
                var strValidEmailDomain;
                var strDomainArray;
                var domain;

                strValidEmailDomain = "<%= CommonFunctions.General.GetApplicationKeySetting("ValidEmailDomain")%>"
		        strDomainArray = strValidEmailDomain.split(',')

		        var n = str.lastIndexOf('.');
		        domain = str.substring(n + 1);

		        if (strDomainArray.indexOf(domain) == -1) {
		            alert('Please enter valid domain for email id - ' + str + '.');
		            return false;
		        }
            }
            //End of Added By Aniruddh Gujar on 20-Sep-2017 Purpose::To validate the mail domains
            function isEmail(str) {
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

                if (window.RegExp) {
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
            //Added By Vaijat K ON 21/12/2015 Issue ID-2797
            function ShowDescription_onClick() {
                var objTR = GetObjectReference('frmDashboard', 'Description');
                var objImg = GetObjectReference('', 'imgSummaryShowHide');
                var IsCollapse = objImg.getAttribute("Collapse");

                if (IsCollapse == "Y") {
                    objImg.src = '../../Images/plus.gif';
                    objTR.style.display = 'none';
                    objImg.setAttribute("Collapse", "N");
                }
                else if (IsCollapse == "N") {
                    objImg.src = '../../Images/minus.gif';
                    objTR.style.display = '';
                    objImg.setAttribute("Collapse", "Y");
                }

            }
            //Ended
    </script>
    </TABLE>
</body>
</html>
