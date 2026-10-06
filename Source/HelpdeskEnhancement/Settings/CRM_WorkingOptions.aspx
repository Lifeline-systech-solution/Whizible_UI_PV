<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_WorkingOptions.aspx.vb" Inherits="PbNIT.CRM_WorkingOptions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<title></title>--%>
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Working Options")%>--%>
    <%--<script src="../../../EnhancementFiles/OnlineFiles/js/jquery/2.1.4/jquery.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../General/CommonFunctions.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
	<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <link href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <%--<link href="../../../EnhancementFiles/OnlineFiles/css/Jquery.ui.css" rel="stylesheet" />--%>
    <%--<link href="../../../Plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    
	<%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="../../../EnhancementFiles/css/newequest.css" rel="stylesheet" />
    <style>
        .clsHeight {
            height: 100%;
        }
        .clsWidth {
            width: 54px;
        }
        #txtDaysPerPersonMonth, #txtAutoclose, #txtSMTPServerPort {
             width: 54px;
        }
        #cboInstallationType, #cboEmailFormat, #cboZoneGMT {
            height: 23px;
        }
        #txtSMTPServerPort, #txtSMTPDomain, #cboInstallationType, #txtSMTPServer, #txtSMTPPassword, #cboEmailFormat
        {
            margin-bottom: 5px;
        }
        #btnSave {
            margin-right: 12px;
            /*float:right;*/
        }

        .right {
            margin-right:-1%!important;
            margin-top:6%!important;
        }
        .clsSections {
            font-weight: bold !important;
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
            width: 150px !important;
        }
        .clsDetailsSection, .form-control {
            font-weight: normal;
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
            margin-top: 0px!important;
        }
         .form-group {
            border:none!important;
        }
        label {
            font-weight: 500;
            font-size: 12px;
        }
        input[type=checkbox]{
             margin-top:0px!important;
        }
        .reqeustor .editor .form-control {
            padding: 8px 12px;
            height: auto;
        }
        #collapseGeneralSettings , #collapseLeaveSettings, #collapseMailServerSettings, #collapseTimeZoneSettings{
            margin-top: 2%!important;
        }
        .bottom-bar input {
            width: 292px;
            /*height: 23px;*/
            padding: 0;
            font-size: 11px;
            border-radius: 3px;
            padding-left: 10px;
            border-color: #bbb; 
        }
        .form-control {
            display: block;
            width: 100%;
            height: 34px;
             padding: 0px 0px; 
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        }
         input.form-control, input.form-control, select {
            height: 23px;
        }
          .alertify-notifier {
           font-family: "Open Sans",sans-serif!important;
           font-size: 14px !important;
        }
           .panel-heading {
            /*border:1px solid!important;*/
            /*border-color: #42b1bf!important;*/
        }

             .panel-heading span{

                 font-weight:100!important;
             }

        .bottom-bar .panel-heading {
             border:none!important;
        }

    </style>
    <script>
        var CompanyInfoID = 0;
        var DecryptedPassword;
        var EncryptedPassword;

        $(document).ready(function () {
            RefreshPage();
            getCompanyInfoID();
            getWorkingOptions();
            minimizePanel();
            /*Added by yasmin for pagination alignment on 18 july 2018*/
            $('[data-toggle="tooltip"]').tooltip();
        });
        /*Added by yasmin for pagination alignment on 18 july 2018*/
      
        function minimizePanel() {
            $("#collapseGeneralSettings").css("display", "none");
            $("#collapseLeaveSettings").css("display", "none");
            $("#collapseMailServerSettings").css("display", "none");
            $("#collapseTimeZoneSettings").css("display", "none");
            $(".fa-minus").css("display", "none");
            $(".fa-plus").css("display", "block");
        }
        function getCompanyInfoID() {
            //debugger;
            var url = "CRM_WorkingOptions.aspx/GetCompanyInfoID"


            //data = JSON.stringify({ CompanyInfoID: 1 });
            //CustomAJAXCall(url, data, BindDropDownCompanyInfo);
            CustomAJAXCallwithoutData(url, BindDropDownCompanyInfo);
        }
        function BindDropDownCompanyInfo(result) {
            CompanyInfoID = result.d;
        }
        function getWorkingOptions() {
            //debugger;
            var url = "CRM_WorkingOptions.aspx/Get_WorkingOptions"
            if (CompanyInfoID == "") {
                CompanyInfoID = 0;
            }

            data = JSON.stringify({ CompanyInfoID: CompanyInfoID });
            CustomAJAXCall(url, data, BindDropDownGet_WorkingOptions);
        }
        function BindDropDownGet_WorkingOptions(result) {
            //  debugger;
            var strArray = String(result.d).split("|")
            


            $.each(JSON.parse(strArray[0]), function (id, obj) {
                
                $("#txtDaysPerPersonMonth").val(obj.DaysPerPersonMonth);

                if (obj.ShowPasswordLinks == true)
                    $("#ChkShowPasswordLinks").prop("checked", true);
                else
                    $("#ChkShowPasswordLinks").prop("checked", false);

                if (obj.PhysicalDeletionOfDocuments == true)
                    $("#ChkDeleteAttachment").prop("checked", true);
                else
                    $("#ChkDeleteAttachment").prop("checked", false);

                if (obj.AutoServiceForPassword == true)
                    $("#ChkAutoemailService").prop("checked", true);
                else
                    $("#ChkAutoemailService").prop("checked", false);

                if (obj.ShowMyProfile == true)
                    $("#ChkShowMyProfile").prop("checked", true);
                else
                    $("#ChkShowMyProfile").prop("checked", false);
                
                if (obj.EnableProductExecution == true)
                    $("#ChkEnableProductExecution").prop("checked", true);
                else
                    $("#ChkEnableProductExecution").prop("checked", false);
                
                if (obj.IsAllowExistingAttachment == true)
                    $("#ChkAttachFilestoMail").prop("checked", true);
                else
                    $("#ChkAttachFilestoMail").prop("checked", false);

                if (obj.IsAllowNewAttachment == true)
                    $("#ChkSaveFilesAttached").prop("checked", true);
                else
                    $("#ChkSaveFilesAttached").prop("checked", false);

                $("#txtAutoclose").val(obj.NoofDaysAutoclose);
                if (obj.IsProRataEnabled == true)
                    $("#ChkProrataEnabled").prop("checked", true);
                else
                    $("#ChkProrataEnabled").prop("checked", false);
                $("#cboEmailFormat").val(obj.EmailFormat);
                //alert($("#cboEmailFormat").val(obj.EmailFormat));
                if (obj.IsSSLEnabled == true)
                    $("#ChkUseSSL").prop("checked", true);
                else
                    $("#ChkUseSSL").prop("checked", false);

                $("#txtSMTPServerPort").val(obj.SMTPServerPort);
                
                $("#txtSMTPDomain").val(obj.SMTPDomainName);
                $("#txtSMTPUserName").val(obj.SMTPUserName);
                decryptKey(obj.SMTPPassword);
                //alert(DecryptString(obj.SMTPPassword));

             
                $("#txtSMTPPassword").val(DecryptedPassword);
                $("#txtSMTPServer").val(obj.SMTPServer);
                $("#cboInstallationType").val(obj.SMTPServer_InstallationType);

                $("#cboZoneGMT").val(obj.TimeZoneID);

                $("#CboApplySLAOn").val(obj.ApplySLAON);
                // $("#DRequestType").val($("#DRequestType option:first").val());
                //var objOption = document.createElement("OPTION");
                //objCbo.options.add(objOption);
                //objOption.text = obj.UserName;
                //objOption.value = obj.EmployeeID;

            });
        }
        function decryptKey(encryptedpassword) {
            var url = "CRM_WorkingOptions.aspx/DecryptPassword"
            //debugger;
           
            data = JSON.stringify({ EncryptedPassword: encryptedpassword });
           CustomAJAXCall(url, data, BindDropDownDecryptPassword);
           
        }
        function BindDropDownDecryptPassword(result) {
            DecryptedPassword = result.d;
            //alert(DecryptedPassword);
        }
        function encryptKey(originalpassword) {
            var url = "CRM_WorkingOptions.aspx/EncryptPassword"
            //debugger;

            data = JSON.stringify({ OriginalPassword: originalpassword });
            CustomAJAXCall(url, data, BindDropDownEncryptPassword);

        }
        function BindDropDownEncryptPassword(result) {
            EncryptedPassword = result.d;
            //alert(EncryptedPassword);
        }
        
        function CustomAJAXCall(url, data, method) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                timeout: 180000,
                async: false,
                success: function (result) {
                    method(result);
                    //Stop();
                },
                error: function (xhr, status, error) {
                    // Stop();
                    //  StopAjaxLoader("body");
                    console.log(xhr.responseText);
                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

        }
        function CustomAJAXCallwithoutData(url, method) {
            $.ajax({
                type: "POST",
                url: url,             
                dataType: "json",
                contentType: "application/json",
                timeout: 180000,
                async: false,
                success: function (result) {
                    method(result);
                    //Stop();
                },
                error: function (xhr, status, error) {
                    // Stop();
                    //  StopAjaxLoader("body");
                    console.log(xhr.responseText);
                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

        }
        function isNormalInteger(str) {
            var n = Math.floor(Number(str));
            return String(n) === str && n >= 0;
        }

        //commented and added by Usha Pandit on 18.12.2017 for validation of auto close request 
        //function ValidateWorkingOptions() {
        //    var chkVal = 0;
        //    var strmsg = "";
        //    var errorMsg = "<ul>"

        //    //var DaysPerPersonMonth = $("#txtDaysPerPersonMonth").val();
        //    //var DepartmentCode = $("#txtDepartmentCode").val();
        //    var isNumber = isNormalInteger($("#txtDaysPerPersonMonth").val());
        //    if (isNumber == false) {
        //        strmsg = strmsg + "- Please enter only positive Integer.";
        //        errorMsg += "<li>" + strmsg + "</li></n>";
        //        chkVal = 1;
        //    }
        //    isNumber = isNormalInteger($("#txtSMTPServerPort").val());
        //    if (isNumber == false) {
        //        strmsg = strmsg + "- Please enter only positive numeric value for 'SMTP Server Port'.";
        //        errorMsg += "<li>" + strmsg + "</li></n>";
        //        chkVal = 1;
        //    }

        //    if ($("#txtSMTPUserName").val() != "" && $("#txtSMTPPassword").val() == "") {
        //        strmsg = strmsg + "- SMTP Password should be mandatory !";
        //        errorMsg += "<li>" + strmsg + "</li></n>";
        //        chkVal = 1;
        //    }

        //    if ($("#txtDaysPerPersonMonth").val() == "") {
        //        strmsg = strmsg + "- 'Days per Person Month' should not be left blank.";
        //        errorMsg += "<li>" + strmsg + "</li></n>";
        //        chkVal = 1;
        //    }


        //    if ($("#txtSMTPServerPort").val() == "") {
        //        strmsg = strmsg + "- 'SMTP Server Port' should not be left blank.";
        //        errorMsg += "</n><li>" + strmsg + "</li>";
        //        chkVal = 1;
        //    }

        //    if ($("#txtSMTPServer").val() == "") {
        //        strmsg = strmsg + "- 'SMTP Server' should not be left blank.";
        //        errorMsg += "</n><li>" + strmsg + "</li>";
        //        chkVal = 1;
        //    }            
           
        //    errorMsg += "</ul>";
        //    if (strmsg != "") {
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.notify(strmsg, 'error');
        //    }

        //    return chkVal;
        //}

        function ValidateWorkingOptions() {
            var chkVal = 0;
            var strmsg = "";
            var errorMsg = "<ul>"

            //var DaysPerPersonMonth = $("#txtDaysPerPersonMonth").val();
            //var DepartmentCode = $("#txtDepartmentCode").val();



            if ($("#txtSMTPUserName").val() != "" && $("#txtSMTPPassword").val() == "") {
                strmsg = "- SMTP Password should be mandatory !";
                errorMsg += "<li>" + strmsg + "</li></n>";
                chkVal = 1;
            }

            if ($("#txtDaysPerPersonMonth").val() == "") {
                strmsg = "- 'Days per Person Month' should not be left blank.";
                errorMsg += "<li>" + strmsg + "</li></n>";
                chkVal = 1;
            }

            if ($("#txtDaysPerPersonMonth").val() != "") {
                var isNumber = isNormalInteger($("#txtDaysPerPersonMonth").val());
                if (isNumber == false) {
                    strmsg = "- Please enter only positive Integer.";
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }
            }
            if ($("#txtSMTPServerPort").val() == "") {
                strmsg = "- 'SMTP Server Port' should not be left blank.";
                errorMsg += "</n><li>" + strmsg + "</li></n>";
                chkVal = 1;
            }

            if ($("#txtSMTPServerPort").val() != "") {
                isNumber = isNormalInteger($("#txtSMTPServerPort").val());
                if (isNumber == false) {
                    strmsg = "- Please enter only positive numeric value for 'SMTP Server Port'.";
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }
            }

            if ($("#txtAutoclose").val() != "") {
                isNumber = isNormalInteger($("#txtAutoclose").val());
                if (isNumber == false) {
                    strmsg = "- Please enter only positive numeric value for 'Autoclose Request Days'.";
                    errorMsg += "<li>" + strmsg + "</li></n>";
                    chkVal = 1;
                }
                else if (isNumber == true) {
                    if ($("#txtAutoclose").val() <= 1) {
                        strmsg = "- The value of 'Autoclose Request Days' should be > 1.";
                        errorMsg += "<li>" + strmsg + "</li></n>";
                        chkVal = 1;
                    }
                }
            }

            if ($("#txtSMTPServer").val() == "") {
                strmsg = "- 'SMTP Server' should not be left blank.";
                errorMsg += "</n><li>" + strmsg + "</li></n>";
                chkVal = 1;
            }

            errorMsg += "</ul>";
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error');
            }

            return chkVal;
        }

        // End of addition by Usha Pandit on 18.12.2017 for validation of auto close request 

        function SaveWorkingOptions() {
            if (ValidateWorkingOptions() == 0) {
                //debugger;
                var url = "CRM_WorkingOptions.aspx/SaveWorkingOptions"
                if (CompanyInfoID == "") {
                    CompanyInfoID = 0;
                }
                var isShowPasswordLinks = 0;
                var isPhysicalDeletionOfDocuments = 0;
                var isAutoServiceForPassword = 0;
                var isShowMyProfile = 0;
                var isEnableProductExecution = 0;
                var isAllowExistingAttachment = 0;
                var isAllowNewAttachment = 0;
                var isProRataEnabled = 0;
                var isSSLEnabled = 0;

                if ($('#ChkShowPasswordLinks').is(":checked")) {
                    isShowPasswordLinks = 1
                }
                if ($('#ChkDeleteAttachment').is(":checked")) {
                    isPhysicalDeletionOfDocuments = 1
                }
                if ($('#ChkAutoemailService').is(":checked")) {
                    isAutoServiceForPassword = 1
                }
                if ($('#ChkShowMyProfile').is(":checked")) {
                    isShowMyProfile = 1
                }
                if ($('#ChkEnableProductExecution').is(":checked")) {
                    isEnableProductExecution = 1
                }
                if ($('#ChkAttachFilestoMail').is(":checked")) {
                    isAllowExistingAttachment = 1
                }
                if ($('#ChkSaveFilesAttached').is(":checked")) {
                    isAllowNewAttachment = 1
                }
                if ($('#ChkProrataEnabled').is(":checked")) {
                    isProRataEnabled = 1
                }
                if ($("#ChkUseSSL").is(":checked")) {
                    isSSLEnabled = 1
                }
                encryptKey($("#txtSMTPPassword").val());
                var SLAAppliedON = $("#CboApplySLAOn").val();
                var msg2 = { "clsWorkingOptionsData": { "CompanyInfoID": CompanyInfoID, "DaysPerPersonMonth": $("#txtDaysPerPersonMonth").val(), "ShowPasswordLinks": isShowPasswordLinks, "PhysicalDeletionOfDocuments": isPhysicalDeletionOfDocuments, "AutoServiceForPassword": isAutoServiceForPassword, "ShowMyProfile": isShowMyProfile, "EnableProductExecution": isEnableProductExecution, "IsAllowExistingAttachment": isAllowExistingAttachment, "IsAllowNewAttachment": isAllowNewAttachment, "NoofDaysAutoclose": $("#txtAutoclose").val(), "IsProRataEnabled": isProRataEnabled, "SMTPServerPort": $("#txtSMTPServerPort").val(), "SMTPDomainName": $("#txtSMTPDomain").val(), "SMTPServer_InstallationType": $("#cboInstallationType").val(), "SMTPUserName": $("#txtSMTPUserName").val(), "SMTPServer": $("#txtSMTPServer").val(), "SMTPPassword": EncryptedPassword, "EmailFormat": $("#cboEmailFormat").val(), "IsSSLEnabled": isSSLEnabled, "TimeZoneID": $("#cboZoneGMT").val(), "SLAAppliedON": SLAAppliedON } };

                data = JSON.stringify(msg2);
                CustomAJAXCall(url, data, BindDropDownSaveResult);
            }
        }
        function BindDropDownSaveResult(result) {
              //debugger;
           
              if (result.d == "Success") {
                  alertify.set('notifier', 'position', 'top-right');
                  alertify.notify('Working Options Settings saved successfully', 'success');
            }
        }
        function ShowHideGeneralSettings() {
            var isHidden = document.getElementById("collapseGeneralSettings").style.display == "none";
          
            if (isHidden) {
                $("#collapseGeneralSettings").css("display", "block");
                $("#faplusGeneral").css("display", "none");
                $("#faminusGeneral").css("display", "block");
                //if (btnAddClick == 0) {
                //    $("#cboDepartmentHead").css("visibility", "visible");
                //    $("#lblDepartmentHead").css("visibility", "visible");
                //}
            }
            else {
                $("#collapseGeneralSettings").css("display", "none");

                $("#faplusGeneral").css("display", "block");
                $("#faminusGeneral").css("display", "none");

                //$("#cboDepartmentHead").css("visibility", "hidden");
                //$("#lblDepartmentHead").css("visibility", "hidden");
            }
        }
        function ShowHideLeaveSettings() {
            var isHidden = document.getElementById("collapseLeaveSettings").style.display == "none";
            if (isHidden) {
                $("#collapseLeaveSettings").css("display", "block");
                $("#faplusLeave").css("display", "none");
                $("#faminusLeave").css("display", "block");
            }
            else {
                $("#collapseLeaveSettings").css("display", "none");

                $("#faplusLeave").css("display", "block");
                $("#faminusLeave").css("display", "none");
            }
        }
        function ShowHideMailServerSettings() {
            var isHidden = document.getElementById("collapseMailServerSettings").style.display == "none";
            if (isHidden) {
                $("#collapseMailServerSettings").css("display", "block");
                $("#faplusMailServer").css("display", "none");
                $("#faminusMailServer").css("display", "block");
            }
            else {
                $("#collapseMailServerSettings").css("display", "none");

                $("#faplusMailServer").css("display", "block");
                $("#faminusMailServer").css("display", "none");
            }
        }
        function ShowHideTimeZoneSettings() {
            var isHidden = document.getElementById("collapseTimeZoneSettings").style.display == "none";
            if (isHidden) {
                $("#collapseTimeZoneSettings").css("display", "block");
                $("#faplusTimeZone").css("display", "none");
                $("#faminusTimeZone").css("display", "block");
            }
            else {
                $("#collapseTimeZoneSettings").css("display", "none");

                $("#faplusTimeZone").css("display", "block");
                $("#faminusTimeZone").css("display", "none");
            }
        }
        function RefreshPage() {

            var strResult, data;
            var GridParameter = {};

            //debugger;
            var DivId;
            var DivSerach;

            DivId = "divDepartment";
            DivSerach = "SearchRequestDepartment";

            var TypeDiv; var accordion;
            //TypeDiv = document.getElementById('divRequestTypes');
            //accordion = document.getElementById('accordion');
            var intDivGridHeight
            //    if (TypeDiv != null && accordion != null) {
            //if (WhichBrowser() == "IE") {
            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {

            //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
            //    }
            //    else {

            //        intDivGridListHeight = parseInt(window.innerHeight) - 250;
            //    }

            //    //$('.panel-body').css('height', intDivGridListHeight + "px");
            //    //$('#accordion').css('height', intDivGridListHeight - 20 + "px");
            //    $("#divMainBlock").css('height', intDivGridListHeight + "px");
            //    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);

            //}
            //else {

            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
            //        //alert("222");
            //        intDivGridListHeight = parseInt(window.innerHeight) - 500;

            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                   
            //        intDivGridListHeight = parseInt(window.innerHeight) - 500;
            //       // alert(intDivGridListHeight);
            //        $("#divMainBlock").css('height', intDivGridListHeight + 230 + "px");
            //    }

            //    else {
            //       // alert("ssss");

            //        intDivGridListHeight = (window.innerHeight / 3) - 5;

            //    }

            //    //$('#accordion').css('height', intDivGridListHeight - 20 + "px");
            //   // $("#divMainBlock").css('height', intDivGridListHeight + 250 + "px");
            //    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);

            //}


            var intDivGridHeight, intDivGridListHeight
            intDivGridListHeight = parseInt(window.innerHeight);
            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                $("#divMainBlock").css('height', intDivGridListHeight - 280 + "px");
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

                $("#divMainBlock").css('height', intDivGridListHeight - 320 + "px");
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                $("#divMainBlock").css('height', intDivGridListHeight - 280 + "px");
            }
            else {
                $("#divMainBlock").css('height', intDivGridListHeight - 280 + "px");
            }

            //datatables(DivId, DivSerach);
            //setWidthDatatable("DivList");

        }
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
    </script>
</head>
    
<body>
    <form id="form1" runat="server">
        <div>
            <% PlotHTML()%>
        </div>
    </form>
</body>
</html>
