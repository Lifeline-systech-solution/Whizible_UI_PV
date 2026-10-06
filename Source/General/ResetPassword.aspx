<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResetPassword.aspx.vb" Inherits="PbNIT.WebForm1" %>

<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Reset Password</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            color: #545454;
            font-size: 14px;
            line-height: 20px;
        }

        p a {
            color: #1359a6;
            font-family: Arial, Helvetica, sans-serif;
        }

        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            font-family: Arial, Helvetica, sans-serif;
        }

        a {
            color: #1359a6;
        }

            a:hover {
                text-decoration: none
            }

        .mailtemp_container {
            max-width: 480px;
            margin: 40px auto;
            border-radius: 40px;
        }

        .mailhead h1 {
            color: #ffffff;
        }

        ul li {
            margin: 0 0 10px;
        }

        h3 {
            margin: 0;
        }

        /*Resetpassform*/
        .text-center {
            text-align: center;
        }

        .resetpassform {
            padding: 40px;
            font-family: Arial, Helvetica, sans-serif;
            background: #fafafa;
            box-shadow: 0 0 10px 1px #ccc;
            border-radius: 40px;
        }

        .resFormpanel {
            max-width: 360px;
            margin: 40px auto 0;
        }

        .form-group {
            clear: both;
            margin: 0 0 15px;
        }

        .form-control {
            font-size: 14px;
            border: 1px solid #545454;
            padding: 8px;
            width: 100%;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
            background: #ffffff;
            border-radius: 4px;
            height: 34px;
        }

        input:focus::placeholder {
            color: transparent;
        }

        .form-group label {
            font-weight: bold;
            margin: 0 0 5px;
            display: block;
        }

        .btnyellow {
            background: #fbb03b;
            color: #fff;
            transition: 0.4s ease-in-out 0s;
            padding: 4px 16px;
            line-height: inherit;
            text-decoration: none;
            font-family: Arial, Helvetica, sans-serif;
        }

            .btnyellow:hover, .btnyellow:focus {
                background: #de9d38;
            }

        .btnyellowBig {
            padding: 10px 20px;
            display: block;
            text-align: center;
            font-size: 18px;
            border-radius: 6px;
        }
    </style>
</head>

<body class="">
    <form id="frmResetPassword" action="Source/General/ResetPassword.aspx" method="post" autocomplete="off">
        <%If IsActivetoken <> "0" Then%>
        <div class="mailtemp_container">

            <div class="resetpassform">
                <div class="text-center">
                    <%--Whizible2.0/dist/--%>
                    <%--  <img src="../img/Whizible-app-logo.png" width="150px" alt="Whizible" title="Whizible" border="0">--%>
                    <img src="../../Images/<%= strLogo%>" width="150px" alt="Whizible" title="Whizible" border="0">
                </div>
                <br />

                <div class="text-center">
                    <!--<img src="images/reset.png" alt="" border="0">-->
                    <h2 class="text-center" style="margin-bottom: 0;">Reset Password</h2>
                    <p>You can reset your password here.</p>
                </div>

                <div class="resFormpanel">
                    <div class="form-group">
                        <label>New Password</label>
                        <%--<input class="form-control" type="text" placeholder="Create your New Password" required id="txtOldPassword">--%>
                        <input id="txtNewPassword" name="txtNewPassword" type="password" class="form-control" placeholder="New Password" onkeyup="ClearSpan('txtNewPassword','SpanNewPassword')" oncopy="return false" oncut="return false" onpaste="return false" />
                        <span style="color: #dd1037; font-size: 12px;" id="SpanNewPassword"></span>

                    </div>
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <%--<input class="form-control" type="text" placeholder="Confirm your Password" required>--%>
                        <input id="txtConfirmPassword" name="txtConfirmPassword" type="password" class="form-control" placeholder="Confirm Password" onkeyup="ClearSpan('txtNewPassword','SpanCPassword')" oncopy="return false" oncut="return false" onpaste="return false" />
                        <span style="color: #dd1037; font-size: 12px;" id="SpanCPassword"></span>
                        <input type="hidden" id="NonDatabase3" />
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <a href="javascript:;" class="btnyellow btnyellowBig" title="Reset Password" onclick="ChangePassword()">Reset Password</a>
                    </div>


                </div>
            </div>

        </div>
        <%Else%>
        <div class="mailtemp_container">

            <div class="resetpassform">
                <div class="text-center">

                    <p>Token was invalid,Please login again</p>
                    <p><a href="../../Default.aspx" style="float: right">Login </a></p>
                </div>
            </div>
        </div>

        <%End If %>
    </form>
</body>
</html>


<script src="CommonFunctions.js"></script>
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<%--<script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script>

    var Key = "";
    var MSID = "";
    $(document).ready(function () {
        //debugger;
        params = getParams();
        Key = unescape(params["Key"]);
        MSID = unescape(params["MSID"]);
        //alert(Key);
        //alert(MSID);
    });
    function ChangePassword() {

        if (validate() == true) {


            var objfrm;
            objfrm = GetFormReference('frmResetPassword');
            objfrm.action = "ResetPassword.aspx?Mode=ResetPassword&Key=" + Key + "&MSID=" + MSID
            objfrm.submit();

        }
    }

    function reverseString(str) {
        return str.split("").reverse().join("");

    }

    function validate() {
        //var objNewPwd = GetObjectReference('frmResetPassword', 'txtNewPassword');
        //var objConfirmPwd = GetObjectReference('frmResetPassword', 'txtConfirmPassword');
        //var objtxtConfirmPassword = $('#txtNewPassword');
        //var objtxtNewPassword = $('#txtConfirmPassword');

        //var objtxtspanConfirmPassword = $('#SpantxtConfirmPassword');
        //var objtxtspanNewPassword = $('#SpanNewPassword');

        //if (objNewPwd != null && objtxtNewPassword.value == '') {
        //    objtxtNewPassword.css('border-color', '#fecc00');
        //    objtxtNewPassword.css('border-width', '2px');
        //    objtxtspanNewPassword.text('New Password should not be left blank');
        //    return false;
        //} else {
        //    objtxtNewPassword.css('border-color', '#d8dade');
        //    objtxtNewPassword.css('border-width', '1px');
        //    objtxtspanNewPassword.text("");
        //}



        //if (objConfirmPwd != null && objConfirmPwd.value == '') {
        //    objtxtConfirmPassword.css('border-color', '#fecc00');
        //    objtxtConfirmPassword.css('border-width', '2px');
        //    objtxtspanConfirmPassword.text('Confirm Password should not be left blank'));
        //    return false;
        //} else {
        //    objtxtConfirmPassword.css('border-color', '#d8dade');
        //    objtxtConfirmPassword.css('border-width', '1px');
        //    objtxtspanConfirmPassword.text("");
        //}

        //return true;
        //debugger;

        var blnEnablePassLength = '<%=m_blnEnablePassLength %>';
       var intMinPassLen = '<%=m_intMinPassLen %>';
       var intMaxPassLen = '<%=m_intMaxPassLen %>';
       var blnEnableAlphaNumSpeChar = '<%=m_blnEnableAlphaNumSpeChar %>';
       var intNumberOfAlpha = '<%=m_intNumberOfAlpha %>';
       var intNumberOfNumerals = '<%=m_intNumberOfNumerals %>';
       var intNumberOfSpecialChars = '<%=m_intNumberOfSpecialChars %>';
       var blnAllowSameLoginPwd = '<%=m_blnAllowSameLoginPwd %>';
       var EnablePassPharsesDays = '<%=m_blnEnablePassPharsesDays%>';
       var PassPharsesDays = '<%=m_intPassPharsesDays%>';
       var EnablePreviousPassCheck = '<%=m_blnEnablePreviousPassCheck%>';
       var PreviousPassCount = '<%=m_intPreviousPassCount%>';
       var EnablePassLockoutDuration = '<%=m_blnEnablePassLockoutDuration%>';
       var PassLockoutDuration = '<%=m_intPassLockoutDuration%>';
       var EnableLockUserID = '<%=m_blnEnableLockUserID%>';
       var PassLockingCount = '<%=m_intPassLockingCount%>';
       var PassCaptchaCount = '<%=m_intPassCaptchaCount%>';
       var intCurrAlphaCount = 0;
       var intCurrNumCount = 0;
       var intCurrSpecCount = 0;
       var intAsciiValue;
       var strAlertMsg;
       var objLoginName
       var AuthenticationType = '<%=strAuthenticationType %>';
       var stralphacharset = '65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122';
       var strnumeralcharset = '48 49 50 51 52 53 54 55 56 57';
       var strspecialcharset = '32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 58 59 60 61 62 63 64 91 92 93 94 95 96 123 124 125 126 127';


       var hdCount = GetObjectReference("frmResetPassword", "NonDatabase3");
       var objSpanConfirmPassword = $('#SpanCPassword');
       objLoginName =  '<%=globalUserName %>';
       //var objSpanUserID = $('#SpanUserID');
       //var objNewPwd = document.getElementById('#txtNewPassword');
       //var objConfirmPwd = document.getElementById('#txtConfirmPassword');
       var objNewPwd = GetObjectReference('frmResetPassword', 'txtNewPassword');
       var objConfirmPwd = GetObjectReference('frmResetPassword', 'txtConfirmPassword');
       var objtxtOldPassword = $('#txtOldPassword');
       var objSpanCPassword = $('#SpanCPassword');
       var objtxtNewPassword = $('#txtNewPassword');
       var objSpanNewPassword = $('#SpanNewPassword');
       var objtxtConfirmPassword = $('#txtConfirmPassword');

            //}


                <%MyBase.InitializeResources("Resources.SM_ChangePassword", "Resources")%>

       var strEncryptionKey = "";
       var strEncryptedNewPwd = "";
       var strEncryptedOldPwd = "";
       var strEncryptedConPwd = "";

       $.ajax({
           type: "POST",
           contentType: "application/json; charset=utf-8",
           url: "ResetPassword.aspx/ValidateUName",
           data: JSON.stringify({ UserName: objLoginName }),
           async: false,
           success: function (data) {

               var strResult = String(data.d).split("||");
               strEncryptionKey = strResult[0];
           },
           error: function (result) {
               console.log(result);
           }
       })

       if (hdCount != null)
           hdCount.value = strEncryptionKey.length;

     <%--   objSpanConfirmPassword.text("");
        if (objLoginName != null && objLoginName.value == '') {
            objtxtLoginName.css('border-color', '#fecc00');
            objtxtLoginName.css('border-width', '2px');
            // objSpanUserID.text('<%=MyBase.GetResourceString("VALIDATION_MSG1")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
                objSpanUserID.text('The User ID field should not be left blank.'.replace("&#39; ", "' ").replace("&#39;", "'"));
                return false;
            }
            else {
                objtxtLoginName.css('border-color', '#d8dade');
                objtxtLoginName.css('border-width', '1px');
                objSpanUserID.text("");
            }--%>

          <%--  if (objOldPwd != null && objOldPwd.value == '') {
                objtxtOldPassword.css('border-color', '#fecc00');
                objtxtLoginName.css('border-width', '2px');
                objSpanCPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG2")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));

                return false;
            }
            else {
                objtxtOldPassword.css('border-color', '#d8dade');
                objtxtOldPassword.css('border-width', '1px');
                objSpanCPassword.text("");
            }--%>

       if (objNewPwd != null && objNewPwd.value == '') {
           objtxtNewPassword.css('border-color', '#fecc00');
           objtxtNewPassword.css('border-width', '2px');
           objSpanNewPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG3")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
           return false;
       }
       else {
           objtxtNewPassword.css('border-color', '#d8dade');
           objtxtNewPassword.css('border-width', '1px');
           objSpanNewPassword.text("");
       }
       if (objConfirmPwd != null && objConfirmPwd.value == '') {
           objtxtConfirmPassword.css('border-color', '#fecc00');
           objtxtConfirmPassword.css('border-width', '2px');
           objSpanConfirmPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG4")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
           return false;
       } else {
           objtxtConfirmPassword.css('border-color', '#d8dade');
           objtxtConfirmPassword.css('border-width', '1px');
           objSpanConfirmPassword.text("");
       }


       if (objNewPwd != null && objConfirmPwd != null && objNewPwd.value != objConfirmPwd.value) {
           objtxtConfirmPassword.css('border-color', '#fecc00');
           objtxtConfirmPassword.css('border-width', '2px');
           objSpanConfirmPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG6")%>'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39; ", "' ").replace("&#39;", "'"));
           return false;
       }
       else {
           objtxtConfirmPassword.css('border-color', '#d8dade');
           objtxtConfirmPassword.css('border-width', '1px');
           objSpanConfirmPassword.text("");
       }



       var strNewPass = $("#txtNewPassword").val();
       var strConPass = $("#txtConfirmPassword").val();

       //strNewPass = reverseString(strNewPass);
       strNewPass = strNewPass;
       var NewEncyNewPwd = "";
       if (strNewPass != "") {
           $.ajax({
               type: "POST",
               contentType: "application/json; charset=utf-8",
               url: "ResetPassword.aspx/GetEncyNewPwd",
               data: JSON.stringify({ strNewPass: strNewPass, UserName: '<%=globalUserName %>' }),
               async: false,
               success: function (data) {

                   var strResult = String(data.d).split("||");
                   NewEncyNewPwd = strResult[0];
               },
               error: function (result) {
                   console.log(result);
               }
           })

       }
       var objOldPwd = '<%=strOldPassword %>';


       //for (var i = strOldPass.length - 1, len = 0; i >= 0; i--) {
       //    strEncryptedOldPwd += strOldPass[i] + strEncryptionKey + '|';
       //}

       for (var i = strNewPass.length - 1, len = 0; i >= 0; i--) {
           strEncryptedNewPwd += strNewPass[i] + strEncryptionKey + '|';
           strEncryptedConPwd += strConPass[i] + strEncryptionKey + '|';
       }
       if (objOldPwd != null && objNewPwd != null && objOldPwd == NewEncyNewPwd) {
           objtxtConfirmPassword.css('border-color', '#fecc00');
           objtxtConfirmPassword.css('border-width', '2px');
           objSpanConfirmPassword.text('The &#39;Old Password&#39; and &#39;New Password&#39; fields should not be same.'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39; ", "' ").replace("&#39;", "'"))
           return false;
       }


          <% If ((strAuthenticationType = "N" OrElse strAuthenticationType = "M") AndAlso blnFirstTimeLogin = True) Then%>
       if (objOldPwd != null && objNewPwd != null && objOldPwd == NewEncyNewPwd) {
           objtxtConfirmPassword.css('border-color', '#fecc00');
           objtxtConfirmPassword.css('border-width', '2px');
           objSpanConfirmPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG11")%>'.replace("&#39; ", "' ").replace("&#39;", "'").replace("&#39;", "'"));
           return false;
       }
       else {
           objtxtConfirmPassword.css('border-color', '#d8dade');
           objtxtConfirmPassword.css('border-width', '1px');
           objSpanConfirmPassword.text("");

       }
        <%End If%>

                <% If ((strAuthenticationType = "N" OrElse strAuthenticationType = "M") AndAlso m_blnAllowSameLoginPwd = True) Then%>
       if (objLoginName != null && objNewPwd != null && objLoginName == NewEncyNewPwd) {
           objtxtNewPassword.css('border-color', '#fecc00');
           objtxtNewPassword.css('border-width', '2px');
           objSpanNewPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG10")%>'.replace(" &#39;", " '").replace("&#39; ", "' ").replace("&#39;Password&#39;", "'Password'"));
           return false;
       }
       else {
           objtxtNewPassword.css('border-color', '#d8dade');
           objtxtNewPassword.css('border-width', '1px');
           objSpanNewPassword.text("");

       }
                <%End If%>
       if ((AuthenticationType == 'N' || AuthenticationType == 'M') && blnEnablePassLength == 'True') {
           if (objNewPwd != null && intMinPassLen > ($("#txtNewPassword").val().trim().length)) {
               strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG7")%>';
                    strAlertMsg = strAlertMsg.replace('<MINPASSWORDLENGTH>', intMinPassLen);
                    objtxtNewPassword.css('border-color', '#fecc00');
                    objtxtNewPassword.css('border-width', '2px');
                    objSpanNewPassword.text(strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'"));
                    objNewPwd.focus();
                    return false;
                }
                else {
                    objtxtNewPassword.css('border-color', '#d8dade');
                    objtxtNewPassword.css('border-width', '1px');
                    objSpanNewPassword.text("");

                }
                if (objNewPwd != null && intMaxPassLen < ($("#txtNewPassword").val().trim().length)) {
                    strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG8")%>';
                    strAlertMsg = strAlertMsg.replace('<MAXPASSWORDLENGTH>', intMaxPassLen);
                    objSpanNewPassword.text(strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'"));
                    objtxtNewPassword.css('border-color', '#fecc00');
                    objtxtNewPassword.css('border-width', '2px');
                    objNewPwd.focus();
                    return false;
                }
                else {
                    objtxtNewPassword.css('border-color', '#d8dade');
                    objtxtNewPassword.css('border-width', '1px');
                    objSpanNewPassword.text("");

                }
            }
            else {
                if (objNewPwd != null && ($("#txtNewPassword").val().trim().length) < 6) {
                    objSpanNewPassword.text('<%=MyBase.GetResourceString("VALIDATION_MSG5")%>'.replace("&#39; ", "' ").replace("&#39;", "'"));
               objtxtNewPassword.css('border-color', '#fecc00');
               objtxtNewPassword.css('border-width', '2px');
               objNewPwd.focus();
               return false;
           }
       }

       if ((AuthenticationType == 'N' || AuthenticationType == 'M') && blnEnableAlphaNumSpeChar == 'True') {
           if (objNewPwd != null) {
               newPass = $("#txtNewPassword").val();
               for (i = 0; i < newPass.length; i++) {
                   intAsciiValue = newPass.charCodeAt(i);
                   if (stralphacharset.indexOf(intAsciiValue) >= 0) {
                       intCurrAlphaCount = parseInt(intCurrAlphaCount) + 1;
                   }
                   if (strnumeralcharset.indexOf(intAsciiValue) >= 0) {
                       intCurrNumCount = parseInt(intCurrNumCount) + 1;
                   }
                   if (strspecialcharset.indexOf(intAsciiValue) >= 0) {
                       intCurrSpecCount = parseInt(intCurrSpecCount) + 1;
                   }
               }
           }
           if (intCurrAlphaCount < intNumberOfAlpha || intCurrNumCount < intNumberOfNumerals || intCurrSpecCount < intNumberOfSpecialChars) {
               strAlertMsg = '<%=MyBase.GetResourceString("VALIDATION_MSG9")%>';
               strAlertMsg = strAlertMsg.replace('<NUMBEROFALPHABETS>', intNumberOfAlpha);
               strAlertMsg = strAlertMsg.replace('<NUMBEROFNUMERALS>', intNumberOfNumerals);
               strAlertMsg = strAlertMsg.replace('<NUMBEROFSPECIALCHAR>', intNumberOfSpecialChars);
               strAlertMsg = strAlertMsg.replace('alphabets', 'alphabet(s)');
               strAlertMsg = strAlertMsg.replace('numerals', 'numeral(s)');
               strAlertMsg = strAlertMsg.replace('characters', 'character(s)');
               objSpanNewPassword.text(strAlertMsg.replace("&#39; ", "' ").replace("&#39;", "'"));
               objtxtNewPassword.css('border-color', '#fecc00');
               objtxtNewPassword.css('border-width', '2px');
               objNewPwd.focus();
               return false;
           }
       }
       if (('<%=strAuthenticationType%>' == 'N' || '<%=strAuthenticationType%>' == 'M') && (EnablePreviousPassCheck == 'True')) {

            var strResult
            var strURL = 'Action=CHECKLASTENTEREDPWDS&LoginName=' + objLoginName + '&NewPassword=' + strEncryptedNewPwd + "&AuthNo=" + strEncryptionKey.length;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'Default.aspx/CHECKLASTENTEREDPWDS',
                data: JSON.stringify({ LoginName: objLoginName, NewPassword: strEncryptedNewPwd, AuthNo: strEncryptionKey.length }),
                async: false,
                success: function (data) {
                    strResult = data.d;
                },
                error: function (result) {
                    console.log(result.statusText);
                }
            })
            if (strResult == '1') {
                objSpanNewPassword.text("As per password policy, New password should not be same as previous " + PreviousPassCount + " passwords!");
                objtxtNewPassword.css('border-color', '#fecc00');
                objtxtNewPassword.css('border-width', '2px');
                return false;
            }
            else {
                objtxtNewPassword.css('border-color', '#d8dade');
                objtxtNewPassword.css('border-width', '1px');
                objSpanNewPassword.text("");
            }
        }
        //return;
        objNewPwd.value = strEncryptedNewPwd;
        objConfirmPwd.value = strEncryptedConPwd;
        //objOldPwd.value = strEncryptedOldPwd;
        return true;
    }


    function getParams() {
        var params = {},
            pairs = document.URL.split('?')
                .pop()
                .split('&');
        for (var i = 0, p; i < pairs.length; i++) {
            p = pairs[i].split('=');
            params[p[0]] = p[1];
        }
        return params;
    }



    function ClearSpan(txt, span) {


        if ($('#' + txt).val() == "") {
        }
        else {
            $('#' + txt).css('border-color', '#d8dade');
            $('#' + txt).css('border-width', '1px');
            $('#' + span).text("");
        }
    }
</script>
