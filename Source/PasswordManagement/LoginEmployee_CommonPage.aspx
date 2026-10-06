<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LoginEmployee_CommonPage.aspx.vb" Inherits="PbNIT.LoginEmployee_CommonPage" %>

<%-- Added By Bharat Tekade on 28th-Oct-2016 For Euronet Password Policy Customization --%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<Script type="text/javascript">

    //Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization
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
    //Modified By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration    
    var EnablePreviousPassCheck = '<%=m_blnEnablePreviousPassCheck%>';
    //End of Modified By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
    var PreviousPassCount = '<%=m_intPreviousPassCount%>';
    var EnablePassLockoutDuration = '<%=m_blnEnablePassLockoutDuration%>';
    var PassLockoutDuration = '<%=m_intPassLockoutDuration%>';
    var EnableLockUserID = '<%=m_blnEnableLockUserID%>';
    var PassLockingCount = '<%=m_intPassLockingCount%>';
    var PassCaptchaCount = '<%=m_intPassCaptchaCount%>';
    //End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    //Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration    
    var IsAutoPasswordCreation = '<%=m_blnIsAutoPasswordCreation%>';
    //End of Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration

    var intCurrAlphaCount = 0;
    var intCurrNumCount = 0;
    var intCurrSpecCount = 0;
    var intAsciiValue;
    var strAlertMsg;
    var AuthenticationType = '<%=strAuthenticationType%>';
    var stralphacharset = '65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122';
    var strnumeralcharset = '48 49 50 51 52 53 54 55 56 57';
    var strspecialcharset = '32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 58 59 60 61 62 63 64 91 92 93 94 95 96 123 124 125 126 127';

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
</Script>
<%-- End of Added By Bharat Tekade on 28th-Oct-2016 For Euronet Password Policy Customization --%>
