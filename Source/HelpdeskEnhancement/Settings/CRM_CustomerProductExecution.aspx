<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_CustomerProductExecution.aspx.vb" Inherits="PbNIT.CRM_CustomerProductExecution" %>

<!DOCTYPE html>
<html lang="en">

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head>
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="description" content="" />
    <meta name="author" content="" />
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Customer Product Association")%>--%>
    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
    <meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
    <meta name='vs_defaultClientScript' content='JavaScript'>
    <meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Pragma" content="no-cache">

   <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <!-- Bootstrap core CSS -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <%--<link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />--%>
    <%--<link href="../../../EnhancementFiles/OnlineFiles/css/Jquery.ui.css" rel="stylesheet" />
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../General/CommonFunctions.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>
    <script src="../../../EnhancementFiles/js/editor.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <link href='../../../General/loaderStylesheet.css' rel='stylesheet' />--%>
    <script src="../../../EnhancementFiles/OnlineFiles/datepicker/bootstrap-datepicker.js"></script>
    <link href="../../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />
    
</head>

    <style>
        /*Added By Yasmin on 25th july 2018*/
     .ui-tooltip {
	        padding: 5px!important;
	        position: absolute;
	        z-index: 9999;
	        max-width: 300px;
            background: #000 !important;
            color: #fff !important;
	        -webkit-box-shadow: 0!important;
	        box-shadow: 0 !important;
            border:none!important;
            font-size:11.5px!important;
        }
        .ui-tooltip-content::after, .ui-tooltip-content::before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
}

.bottom .ui-tooltip-content::after {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.bottom .ui-tooltip-content::before {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.top .ui-tooltip-content::after {
    top: -6px;
    left: 50%;
    border-bottom-color: #000;
    
    border-width: 0 6px 6px;
    margin-left: -6px;
}

.top .ui-tooltip-content::before {
     border-color: rgba(118, 118, 118, 0);
     border-bottom-color: #000;
     top: -6px;
     left: 50%;
     border-width: 0 6px 6px;
     margin-left: -6px;
 }
        .v-tabs .tabcontent {
            float: left;
            padding: 0;
            border-style: solid;
            border-color: #647ea8;
            border-width: 0px 0px 0px 0px !important;
            width: 100%;
            border-left: none;
            height: 1214px;
        }

        .tablinks.active, .tablinks1.active, .h-tabs div.tab button.tablinks1.active, .h-tabs div.tab button.tablinks2.active, .h-tabs div.tab button.tablinks3.active {
            color: #4caac0 !important;
            border: none !important;
            text-decoration: underline !important;
        }

        .content-wrapper {
            margin-left: 0px !important;
            padding-left: 0px !important;
        }

        #collapseOne .panel-body {
            OVERFLOW: auto;
            HEIGHT: 246PX;
        }

        .h-tabs div .panel-heading {
            height: 21px;
            border-style: solid;
            border-color: #e3e2e2;
            border-width: 1px 0 1px 0;
            background: #cbddfa;
        }

        .table-responsive .btn-default.btn {
            padding: 0;
            background: none;
            border: none;
        }

        .table-responsive .fa {
            font-size: 15px;
        }

        .clsTRColumnHeader th:nth-child(2) {
            text-align: center;
        }

        .clsTRColumnHeader th:nth-child(3) {
            text-align: center;
        }

        .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }


        .table-responsive {
            overflow: hidden;
        }

        .control-label {
            font-weight: normal !important;
        }

        .dataTables_paginate {
            float: right !important;
        }

        .pagination {
            margin: 5px 0 !important;
        }

        .dataTables_info {
            margin-top: 8px;
        }

        .pagination > .active > span:hover {
            z-index: 2;
            color: #fff;
            cursor: default;
            background-color: #cbddfa;
            border-color: #cbddfa;
        }

        .page-item.active .page-link {
            z-index: 2;
            color: #fff;
            background-color: #cbddfa;
            border-color: #cbddfa;
        }

        .edit-bt {
            background: transparent;
            border: none;
            font-size: 22px;
            position: relative;
            top: -3px;
            color: #1e88e5;
        }

        .h-tabs input[type=checkbox] {
            outline: none;
        }

        .h-type .table-responsive table.table thead th :nth-child(4) {
            padding-left: 0px;
        }

        .h-tabs .table-responsive {
            border-bottom: none;
        }

        #divCustomerProduct .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divCustomerProduct .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            position: relative;
        }


        .dataTables_info {
            font-size: 13px;
        }

        #frmType {
            width: 100%;
        }

        #divCustomerProduct .dataTables_wrapper {
            padding-right: 15px;
            padding-left: 0px;
            margin-right: auto;
            margin-left: auto;
        }

        #accordion {
            overflow: hidden;
        }

        .fa-pencil-square-o {
            color: #4caac0 !important;
        }


        #idPanelBody {
            overflow: auto;
            height: 175px;
            width: 103%;
            padding-right: 2%;
        }

        #divEntity .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divEntity .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        .form-control {
            font-weight: 100;
        }

        .form-horizontal {
            width: 100%;
            line-height: 2;
        }


        .container-fluid {
            min-height: 0px !important;
        }


        #idSearchHistory {
            position: absolute;
            margin-top: 8px;
            margin-left: 4px;
        }

        .panel-group {
            margin-bottom: 0px !important;
        }



        .setting-src {
            padding: 0px !important;
        }

        .selected_user {
            background: #cbddfa;
        }

        td {
            font-family: Verdana !important;
            font-size: 12px !important;
        }

        .bottom-bar input {
            /*height: 23px;*/
            /*padding: 0;*/
            font-size: 11px;
            border-radius: 0;
            padding-left: 10px;
            border: 1px solid #bbb;
            border-radius: 3px;
        }

        .form-group {
            border-bottom: 1px solid #ebedf2;
        }

        .control-label {
            font-size: 12px !important;
        }

        .form-control {
            /* display: block; */
            /*width: 71% !important;*/
            height: 29px !important;
            padding: 6px 12px;
            font-size: 12px !important;
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

        #divScroll {
            width: 102%;
            padding-right: 2%;
            overflow: auto;
        }



        #divCustomerProductGrid .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        #divCustomerProductGrid .dataTables_paginate {
            float: right !important;
        }

        #divEntityGrid .dataTables_paginate ul {
            margin-top: 2% !important;
            margin-left: -5% !important;
        }

        #divCustomerProductGrid .dataTables_scrollBody {
            overflow: auto !important;
            width: 101.5% !important;
            /*height: 132px!important;*/
            padding-right: 1.8% !important;
        }

        #divCustomerProductGrid .dataTables_scroll {
            overflow: hidden !important;
            width: 100% !important;
        }

        #divCustomerProductGrid table tr th {
            border: 1px solid #ddd !important;
        }

        #ProductFilter {
            padding-bottom: 15px !important;
        }

        .editor textarea, input[type="text"] {
            padding-left: 18px !important;
        }

        #divCustomerProductGrid .fa-sort {
            display: none !important;
        }

        #ProductFilter {
            /*margin-top: -3%;*/
        }

        #idPlus {
            display: inline-block !important;
        }

        .form-control:-ms-input-placeholder { /* IE 10+ */
            color: #bbb !important;
        }

        #txtDescription {
            height: 56px !important;
        }

        .clsBold {
            font-weight: 200;
        }

        #DivHorizontal .h-tabs div.tab button {
            border-bottom: 1px solid #ddd;
        }

        .h-tabs {
            padding: 0 0 5px 0px !important;
        }

        .tablinks1 li a {
            font-size: 12px;
            font-weight: 600;
            border: none;
            background: none;
            /*margin-right: 38px;*/
        }

        .tab-content {
            margin-top: 20px;
        }

        .clsBold {
            font-weight: bold !important;
        }

        #idCalender {
            position: relative;
            top: 10px !important;
            /* right: -144px !important; */
            float: right;
            margin-left: 5PX;
            /*margin-right: 8% !important;*/
        }

        #panelModuleComponent .panel-body {
            padding-top: 0px !important;
        }

        #panelModuleComponent {
            padding-top: 0px !important;
        }

        #txtComponentDescription {
            height: 50px !important;
        }

        #panelModuleComponent .clsBold {
            white-space: nowrap;
        }

        .request-details-pg {
            min-height: 100% !important;
        }

        #cboCurrency {
            width: 200px !important;
        }

        #cboResponsiblePerson {
            width: 200px !important;
        }

        #txtAMCDescription {
            height: 50px !important;
        }

        #panelLicense select {
            width: 200px !important;
        }

        .clstxtArea {
            height: 50PX !important;
        }

        .form-control {
            margin-top: 0px !important;
        }

        .bottom-bar ul.right .fa-plus {
            color: #647ea8 !important;
            padding-left: 5px;
        }
        #idProductComponent .modal-content {
            height: auto !important;
        }
    </style>

<body class="" id="page-top">
    <div class="content-wrapper" style="margin-left: 0px !important;" id="divScroll">
        <div id='Type' class='tabcontent1 h-type clsSettingstabs'>


            <div class="container-fluid">
                <div class="request-details-pg clsSettings">
                    <div class="v-tabs1">
                        <div id="" class="tabcontent">

                            <div class="h-tabs" id="divMain">
                                <%WritePage()%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- Select Product Modal --%>
    <div id="idProduct" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Select Product</span>
                <span onclick="document.getElementById('idProduct').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="form-group type-top-bar top-bar" style="margin-top: 5px;">
                <label class="control-label col-sm-2 clslabel" style="margin-top: 5px;" for="request type">Customer</label>
                <div class="col-sm-4">
                    <%=CommonFunctions.HTMLControls.DrawComboBox("cboCustomerSelection", "usp_sel_tbl_PM_Customer ", 300, , "onChange='CustomerSelectionOnChange(this)'", True, True, "form-control")%>
                </div>
                <div class="col-sm-4" style="float: right">
                    <button type='button' id='SaveProduct' class='btn btn-default save' onclick='SaveProduct_Onclick()' style='background-color: #343660; color: #ffffff' >Save</button>
                </div>
            </div>
            <div class="container-fluid" id="modalbody" style="overflow: auto; height: 245px;">
            </div>
        </form>
    </div>
    <%-- End of select product modal --%>
    <div id="idProductComponent" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Customer Level Version Components</span>
                <span onclick="document.getElementById('idProductComponent').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="form-group type-top-bar top-bar" style="margin-top: 5px;">
                <ul style='display: inline-block;'>
                    <li class='left search-bar'>
                        <div class='left search-bar'>
                            <i class='fa fa-search faSettingSearch' style='color: black!important' aria-hidden='true'></i>
                            <input type='text' id='txtSearchComponent' placeholder='Search in table'  style='margin-top: 3px!important;'>
                        </div>
                    </li>

                </ul>
               <%-- <ul style='display: inline-block; float: right'>
                    <li class='left '>
                        <button type='button' id='SaveProductComponents' class='btn btn-default save' onclick='SaveProductComponents_Onclick()' style='background-color: #343660; color: #ffffff' title='Save'>Save</button>
                    </li>

                </ul>--%>
            </div>
            <div class="container-fluid" id="Componentmodalbody" style="overflow: auto; height:auto;">
            </div>
             <div class='form-group' style='border-bottom: none; margin-top: 5px;padding-right:30px'>
                    <div class='right'>
                      <button type='button' id='SaveProductComponents' class='btn btn-default save' onclick='SaveProductComponents_Onclick()' style='background-color: #343660; color: #ffffff; font-size:11px'>Save</button>

                    </div>
                </div>
        </form>
    </div>
</body>
<script>
    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    })
    $(document).ready(function () {
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
		    <%End If%>
        RefreshPage();

    });
    $(function () {
        $("#dtInstallOn").datepicker();

    });

    $(function () {
        $(document).tooltip({
            position: {
                my: "center bottom-20",
                at: "center top",
                using: function (position, feedback) {
                    $(this).css(position);
                    $(this)
                        .addClass(feedback.vertical);
                }
            }
        });

    });
    $("[title]").click(function () {
        $('.ui-tooltip').fadeOut('fast', function () {
            $('.ui-tooltip').remove();
        });
    });

    //$('.modal').draggable();
    var modal = document.getElementById('idProduct');

    // When the user clicks anywhere outside of the modal, close it
    //window.onclick = function (event) {
    //    if (event.target == modal) {
    //        modal.style.display = "none";
    //    }
    //}
    var strPageName = "CRM_CustomerProductExecution.aspx";
    var arrSelectedCheck = new Array();
    var CustomerIDGlobal;
    var CustomerProductVersionIDGlobal;
    function openCity(evt, cityName, strTabURL) {

        $(".btnSettingTab").removeClass("active");
        evt.currentTarget.className += " active";

        setFrameLoader();

        $("#frmSettingsTabs").attr("src", "" + strTabURL + "");

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
    function RefreshPage() {

        var strResult, data;
        var GridParameter = {};


        var DivId;
        var DivSerach;

        DivId = "divCustomerProductGrid";
        DivSerach = "txtSearchHistory";

        var TypeDiv; var accordion;
        //TypeDiv = document.getElementById('divRequestTypes');
        //accordion = document.getElementById('accordion');
        var intDivGridHeight
        //    if (TypeDiv != null && accordion != null) {
        if (WhichBrowser() == "IE") {
            intDivGridHeight = (window.innerHeight / 2);

            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {

                intDivGridListHeight = parseInt(window.innerHeight) - 500;
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                intDivGridListHeight = parseInt(window.innerHeight) - 500;
            }
            else {

                //intDivGridListHeight = parseInt(window.innerHeight) - parseInt($('#' + DivId).offset().top) - 250;
                intDivGridListHeight = (window.innerHeight / 3) - 5;
            }

            //$('.panel-body').css('height', intDivGridListHeight + "px");
            //$('#accordion').css('height', intDivGridListHeight - 20 + "px");
            $("#divScroll").css('height', intDivGridListHeight + 445 + "px");
            //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);

        }
        else {

            intDivGridHeight = (window.innerHeight / 2);

            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {

                intDivGridListHeight = parseInt(window.innerHeight) - 500;

            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                intDivGridListHeight = parseInt(window.innerHeight) - 500;

            }

            else {

                intDivGridListHeight = (window.innerHeight / 3) - 5;

            }

            //$('#accordion').css('height', intDivGridListHeight - 20 + "px");
            $("#divScroll").css('height', intDivGridListHeight + 345 + "px");
            //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);

        }

        datatables(DivId, DivSerach);
        //setWidthDatatable("DivList");

    }
    function RefreshCustomerProductGrid() {
        data = JSON.stringify({ CustomerID: "" })
        strResult = AJAXCallWithResult(strPageName + "/FilterData", data, false);
        if (strResult.d != null) {
            $("#divCustomerProduct").html("");
            $("#divCustomerProduct").html(strResult.d);
        }
        RefreshGridDetails();
    }
    function RefreshGridDetails() {
        //  debugger;

        RefreshPage();

    }
    function datatables(divID, txtBoxID) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({

            responsive: true, "pageLength": 3,
            //scrollY: '120px',
            pagingType: "simple_numbers",
            //scrollX: true,
            language: {

            },
        });
        // debugger;
        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }
    $("#frmSettingsTabs").load(function () {
        RemoveFrameLoader();
    });
    var AjaxResult;
    function AJAXCallWithResult(url, data, async) {
        console.log(url);
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout: 180000,
            async: async,
            success: function (result) {
                AjaxResult = result;
                $(".loadingoverlay", parent.document).css("display", "none");
                //Stop();
            },
            error: function (xhr, status, error) {
                //Stop();
                //StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

        return AjaxResult;
    }
    function CustomerOnChange(obj) {
        var strResult, data;
        CustomerIDGlobal = obj.val;
        data = JSON.stringify({ CustomerID: obj.value })
        strResult = AJAXCallWithResult(strPageName + "/FilterData", data, false);
        if (strResult.d != null) {
            $("#divCustomerProduct").html("");
            $("#divCustomerProduct").html(strResult.d);
        }
        RefreshGridDetails();
    }
    function ProductVersion_OnClick(CustomerProductVersionID) {
        var DivId;
        var DivSerach;
        var strResult, data;
        CustomerProductVersionIDGlobal = CustomerProductVersionID

        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/PlotCustomerProduct", data, false);
        if (strResult.d != null) {
            $("#divSubTypeBottom").html("");
            $("#divSubTypeBottom").html(strResult.d);
        }
        $("#divSubTypeBottom").css("display", "block")
        $("#divCustomerProduct").css("display", "none")
        $("#ProductFilter").css("display", "none")
        $("#divSubTypeBottom").css('height', 'auto');
        $("#collapseOne2").addClass('in');
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto !important');
            $("#collapseOne2").addClass('in');
        }
        $("#dtInstallOn").datepicker();
        DivId = "divComponentGrid";
        DivSerach = "";
        datatablesSubTag(DivId, DivSerach);
        DivId = "divAMCGrid";
        DivSerach = "";
        datatablesSubTag(DivId, DivSerach);
        DivId = "divLicenseGrid";
        DivSerach = "";
        datatablesSubTag(DivId, DivSerach);
        DivId = "divReleaseGrid";
        DivSerach = "";
        datatablesSubTag(DivId, DivSerach);
        AMCEdit_OnClick('', CustomerProductVersionID);
        LicenseEdit_OnClick('', CustomerProductVersionID);
        ReleaseEdit_OnClick('', CustomerProductVersionID);
        RefreshGridDetails();

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function datatablesSubTag(divID, txtBoxID) {

        //debugger;
        var ColumnLength = 4;

        $('#' + divID + ' table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' table').DataTable({
            responsive: true,
            pageLength: 3,
            //scrollY: '130px',

            pagingType: "simple_numbers",
            //   scrollX: true,
            //language: {
            //    paginate: {
            //        first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
            //        next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
            //        previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
            //        last: '<i class="fa fa-angle-right" title="Last"></i>'
            //    }
            //},
            //"columnDefs": [{
            //    targets: ColumnLength
            // }]
            // "bstateSave": true,
            //scrollX: true
        });

        //alert(2);
        // debugger;

        //$("#" + divID + " .dataTables_length").parent().css("display", "none");

        //$("#" + divID + " .dataTables_scrollHeadInner table th:first-child").css("width", "25%");
        //$("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("width", "25%");
        //$("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(3)").css("width", "50%");

        //$("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("text-align", "LEFT");
        //$("#" + divID + " .dataTables_scrollHeadInner table").css("width", "100%");
        //$("#" + divID + " .dataTables_scrollBody table").css("width", "100%");
        //$("#" + divID + " .dataTables_scrollBody table td:first-child").css("width", "25%");
        //$("#" + divID + " .dataTables_scrollBody table td:nth-child(2)").css("width", "25%");
        //$("#" + divID + " .dataTables_scrollBody table td:nth-child(3)").css("width", "50%");
        // $("#" + divID + " .dataTables_scrollBody table").css("table-layout", "fixed");
        //  $("#" + divID + " .dataTables_scrollHeadInner table").css("table-layout", "fixed");

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }
    function Cancel_Product() {
        $("#divSubTypeBottom").css("display", "none");
        $("#divCustomerProduct").css("display", "block")
        $("#ProductFilter").css("display", "block");
        RefreshGrid();
        RefreshGridDetails();

    }
    function SaveCustomerProduct(CustomerProductId) {
        var dtInstallOn;
        var strResult, data;
        var strinstallDate;
        var isCurrentVersion;
        if (document.getElementById("dtInstallOn") != null) {
            dtInstallOn = document.getElementById("dtInstallOn").value;
            if (dtInstallOn == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Installation Date should not be left blank.', 'error');
                return;
            }
            try {
                strinstallDate = $.datepicker.parseDate('mm/dd/yy', dtInstallOn);
                // Notice 'yy' indicates a 4-digit year value
            } catch (e) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(dtInstallOn + " is not valid.Format must be MM/DD/YYYY ", 'error');

            }
            if ($("#chkIsCurrentVersion").prop('checked')) {
                isCurrentVersion = 1;
            }
            else {
                isCurrentVersion = 0;
            }
            data = JSON.stringify({ CustomerProductId: CustomerProductId, InstallationDate: dtInstallOn, IsCurrentVersion: isCurrentVersion })
            strResult = AJAXCallWithResult(strPageName + "/UpdateCustomerProduct", data, false);
            if (strResult.d != null) {
                if (strResult.d == "1") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Data saved successfully.', 'success');

                }
            }


        }
    }
    function SelectProduct(CustomerID) {
        var strCustomerID
        if (CustomerID != null || CustomerID != undefined)
        { strCustomerID = CustomerID }
        else
        {
            strCustomerID = $("#cboCustomerSelection").val();
        }

        data = JSON.stringify({ CustomerID: strCustomerID })
        strResult = AJAXCallWithResult(strPageName + "/SelectProduct", data, false);
        if (strResult.d != null) {
            $("#modalbody").html("");
            $("#modalbody").html(strResult.d);
        }
        $("#cboCustomerSelection").val(strCustomerID);
        document.getElementById('idProduct').style.display = 'block';

        $("#cboCustomerSelection").val(strCustomerID);

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function CustomerSelectionOnChange(obj) {

        setFrameLoader();
        data = JSON.stringify({ CustomerID: obj.value })
        strResult = AJAXCallWithResult(strPageName + "/SelectProduct", data, false);
        if (strResult.d != null) {
            $("#modalbody").html("");
            $("#modalbody").html(strResult.d);
        }
        RemoveFrameLoader();
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SelectAll_Product(obj) {

        setTimeout(function () {
            // $("input[name=chkEntityDelete]:not(:disabled)").prop('checked', true);
            if (obj.checked) {
                $('#modalbody input[type="checkbox"]').prop('checked', true);
            }
            else {
                $('#modalbody input[type="checkbox"]').prop('checked', false);
            }
        }

    , 100);

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SaveProduct_Onclick() {
        var strResult;
        var strSelectProductIDs;
        var strCustomerID = $("#cboCustomerSelection").val();
        if (document.getElementById('chkAllSelectProduct').checked == true) {
            strSelectProductIDs = $('input[type="checkbox"]:not(:disabled)').map(function () {
                return this.value;
            }).get().join(',');
        }
        else {
            strSelectProductIDs = arrSelectedCheck.join();
        }
        if (strSelectProductIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please select the Product Version to be mapped to Customer ', 'error');
            return;
        }
        if (strCustomerID == "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Customer Name Must be Selected ', 'error');
            return;
        }
        data = JSON.stringify({ CustomerID: strCustomerID, selectProductIDs: strSelectProductIDs })
        strResult = AJAXCallWithResult(strPageName + "/SaveProduct", data, false);
        if (strResult.d != null) {
            if (strResult.d == "1") {

                strSelectProductIDs = "";
                RefreshGrid();
                RefreshGridDetails();
                SelectProduct(strCustomerID);

            }
        }
    }

    function selectProduct_checkbox(obj) {
        if (obj.checked) {
            arrSelectedCheck.push(obj.value);	// record the value of the checkbox to valArray
        } else {
            arrSelectedCheck.pop(obj.value);	// remove the recorded value of the checkbox
        }
    }
    function RefreshGrid() {
        var data;
        var strResult;
        var strselectedcustomer = $("#cboCustomer").val();
        if (strselectedcustomer == "" || null) {
        
            data = JSON.stringify({ Customer: "" })
        }
        else
        {
            data = JSON.stringify({ Customer: strselectedcustomer })
        }
      
        strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);
        if (strResult.d != null) {

            $("#divCustomerProduct").html("");
            $("#divCustomerProduct").html(strResult.d);

        }
    }
    function SelectModuleComponent_Onclick(CustomerProductVersionID, CustomerID) {
        CustomerProductVersionIDGlobal = CustomerProductVersionID
        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/SelectProductComponent", data, false);
        if (strResult.d != null) {
            $("#Componentmodalbody").html("");
            $("#Componentmodalbody").html(strResult.d);
        }

        datatablesSubTag('divProductComponentGrid', 'txtSearchComponent')
        document.getElementById('idProductComponent').style.display = 'block';

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SaveProductComponents_Onclick() {
        var data;
        var strResult;
        var strchkComponents;
        var table = $('#divProductComponentGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();


        strchkComponents = $('input[type="checkbox"]:checked', rows).map(function () {
            return this.value;
        }).get().join(',');




        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal, ProductComponentIDS: strchkComponents })
        strResult = AJAXCallWithResult(strPageName + "/SaveProductComponents", data, false);
        if (strResult.d != null) {
            if (strResult.d == "1") {
                strchkComponents = "";
                ProductVersion_OnClick(CustomerProductVersionIDGlobal);
                CustomerProductVersionIDGlobal = "";
                document.getElementById('idProductComponent').style.display = 'none';
            }
        }
    }
    function SelectAll_ProductComponent(obj) {
        var table = $('#divProductComponentGrid table').DataTable();
        var rows = table.cells().nodes();
        var data;
        var strResult;



        // $("input[name=chkEntityDelete]:not(:disabled)").prop('checked', true);
        if (obj.checked) {
            //$('#Componentmodalbody input[type="checkbox"]', rows).prop('checked', true);
            $(rows).find('input[type="checkbox"]').prop('checked', true);
        }
        else {
            //$('#Componentmodalbody input[type="checkbox"]', rows).prop('checked', false);
            $(rows).find('input[type="checkbox"]').prop('checked', false);
        }

    }
    function ProductComponent_OnClick(UniqueID) {
        var data;
        var strResult;

        data = JSON.stringify({ UniqueID: UniqueID })
        strResult = AJAXCallWithResult(strPageName + "/GetComponentDetails", data, false);
        if (strResult.d != null) {
            $("#panelModuleComponent").html("");
            $("#panelModuleComponent").html(strResult.d);
            $("#accordion33").css("display", "block");
            $("#panelComponentAdd").css("display", "block");
            
            RefreshGridDetails();
            //if ($("#divTabs .tablinks1 li").length > 0) {
            //    $("#divTabs .tablinks1").css("border", "none");
            //}
            //else {
            //    $("#divTabs .tablinks1").css("border-bottom", "1px solid #ddd");
            //}
        }
    }

    function Cancel_Module() {
        $("#accordion33").css("display", "none");
    }
    function UpdateComponent(UniqueID) {
        var data;
        var strResult;
        var strDescription = $("#txtComponentDescription").val();
        if (disallowMaxlengthViolation(GetObjectReference("frmCommonPage", "txtComponentDescription"), 2000)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(' Max Length of Description is 2000 characters.\r\nYou have entered ' + strDescription.length + ' characters. ', 'error');

            return false;
        }

        data = JSON.stringify({ UniqueID: UniqueID, Description: strDescription })
        strResult = AJAXCallWithResult(strPageName + "/UpdateComponentDetails", data, false);
        if (strResult.d != null) {
            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data updated successfully. ', 'success');
            }
        }
    }
    function SelectAll_Module(obj) {
        var table = $('#divComponentGrid table').DataTable();
        var rows = table.cells().nodes();
        var data;
        var strResult;



        // $("input[name=chkEntityDelete]:not(:disabled)").prop('checked', true);
        if (obj.checked) {
            //$('#Componentmodalbody input[type="checkbox"]', rows).prop('checked', true);
            $(rows).find('input[type="checkbox"]').prop('checked', true);
        }
        else {
            //$('#Componentmodalbody input[type="checkbox"]', rows).prop('checked', false);
            $(rows).find('input[type="checkbox"]').prop('checked', false);
        }
    }
    function AMCEdit_OnClick(ID, CustomerProductVersionID) {
        var data;
        var strResult;
        data = JSON.stringify({ UniqueID: ID, CustomerProductVersionID: CustomerProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/GetAMCDetails", data, false);
        if (strResult.d != null) {
            $("#panelAMC").html("");
            $("#panelAMC").html(strResult.d);
            $("#accordion34").css("display", "block");
            $("#panelAMCAdd").css("display", "block");
            
            RefreshGridDetails();
            $("#dtAMCFrom").datepicker();
            $("#dtAMCTo").datepicker();
            $("#dtAMCDueDate").datepicker(); 
            $("#dtProductValidity").datepicker();


        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SaveAMCDetails(UniqueID) {
        var data;
        var strResult;
        var strAMCFrom = ""
        var strAMCTo = "";
        var strDueDate = "";
        var strProductValidity = "";
        var strCurrency = "";
        var strAmount = "";
        var strResponsiblePerson = "";
        var strDescription = "";
        if (ValidateAMC() == 0) {

            strAMCFrom = $("#dtAMCFrom").val();
            strAMCTo = $("#dtAMCTo").val();
            strDueDate = $("#dtAMCDueDate").val();
            strProductValidity = $("#dtProductValidity").val();
            strCurrency = $("#cboCurrency").val();
            strAmount = $("#txtAMCAmount").val();
            strResponsiblePerson = $("#cboResponsiblePerson").val();
            strDescription = $("#txtAMCDescription").val();
            data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal, UniqueID: UniqueID, AMCFrom: strAMCFrom, AMCTo: strAMCTo, DueDate: strDueDate, ProductValidity: strProductValidity, Currency: strCurrency, Amount: strAmount, ResponsiblePerson: strResponsiblePerson, Description: strDescription })
            strResult = AJAXCallWithResult(strPageName + "/SaveAMCDetails", data, false);
            if (strResult.d != null) {
                if (strResult.d == "1") {
                    if (UniqueID != 0 || UniqueID != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Updated Successfully.", 'success');
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Saved Successfully.", 'success');
                    }
                    RefreshAMCGrid(CustomerProductVersionIDGlobal)
                }
            }
        }

    }
    function Cancel_AMC() {
        $("#accordion34").css("display", "none");
    }
    function ValidateAMC() {
        var objFromDate = GetObjectReference("", "dtAMCFrom");
        var objToDate = GetObjectReference("", "dtAMCTo");
        var objNonDatabase1 = GetObjectReference("", "NonDatabase1");
        var dtFromdate = getDateFromFormat(objFromDate.value);
        var dtToDate = getDateFromFormat(objToDate.value);
        var chkVal = 0;
        var strMsg = "";
        if (objNonDatabase1 != null) {
            for (i = 1; i < objNonDatabase1.length; i++) {
                var dtFrom = getDateFromFormat(objNonDatabase1[i].value);
                var dtTo = getDateFromFormat(objNonDatabase1[i].text);



                if ((dtFromdate >= dtFrom && dtFromdate <= dtTo) || (dtToDate >= dtFrom && dtToDate <= dtTo) || (dtFromdate < dtFrom && dtToDate > dtTo) || (dtFromdate <= dtFrom && dtToDate > dtFrom)) {
                    strMsg += "<li>- AMC is already defined for this date range. </li><br>";
                    chkVal = 1;
                }
            }
        }


        //if (disallowBlank(GetObjectReference("", "dtAMCFrom"))) {
        //    strMsg += "<li>- AMC From should not be left blank. </li><br>";
        //    chkVal = 1;
        //}

        if ($("#dtAMCFrom").val()=="")
        {
            strMsg += "<li>- AMC From should not be left blank. </li><br>";
            chkVal = 1;
        }
        if ($("#dtAMCTo").val() == "") {
            strMsg += "<li>- AMC To should not be left blank. </li><br>";
            chkVal = 1;
        }
        if ($("#dtAMCDueDate").val() == "") {
            strMsg += "<li>- AMC Due Date should not be left blank. </li><br>";
            chkVal = 1;
        }
        //if (disallowBlank(GetObjectReference("", "dtAMCTo"))) {
        //    strMsg += "<li>- AMC To should not be left blank. </li><br>";
        //    chkVal = 1;
        //}


        //if (disallowBlank(GetObjectReference("", "dtAMCDueDate"))) {
        //    strMsg += "<li>- AMC Due Date should not be left blank. </li><br>";
        //    chkVal = 1;
        //}

        var objAMCDueDate = GetObjectReference('', 'dtAMCDueDate');
        var objProductValidity = GetObjectReference('', 'dtProductValidity');

        var AmcDueDate = getDateFromFormat(objAMCDueDate.value);
        var ProductValidity = getDateFromFormat(objProductValidity.value);

        if (ProductValidity < AmcDueDate) {

            strMsg += "<li>- Product Validity Date should be greater than Or Equal To AMC Due date. </li><br>";
            chkVal = 1;

        }

        if ($("#dtProductValidity").val() == "") {
            strMsg += "<li>- Product Validity should not be left blank. </li><br>";
            chkVal = 1;
        }
      

        if (disallowBlank(GetObjectReference("", "cboCurrency"))) {
            strMsg += "<li>- Currency should not be left blank. </li><br>";
            chkVal = 1;
        }

        var objAMCAmount = GetObjectReference("", "txtAMCAmount");
        //var objTotal = GetObjectReference("", "NonDatabase2");

        //if (parseInt(objAMCAmount.value) < parseInt(objTotal.value)) {
        //    alert('AMC Amount is less than Total Collection ' + objTotal.value);
        //    return;
        //}


        if (disallowBlank(GetObjectReference("", "txtAMCAmount"))) {
            strMsg += "<li>- AMC Amount should not be left blank. </li><br>";
            chkVal = 1;
        }

        if (disallowNegativeNumeric(GetObjectReference("", "AMCAmount"))) {
            strMsg += "<li>- Please enter only positive numeric value for AMC Amount </li><br>";
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "AMCAmount"))) {
            strMsg += '<li>- A AMC Amount cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "cboResponsiblePerson"))) {
            strMsg += '<li>- Responsible Person should not be left blank. </li><br>';
            chkVal = 1;
        }


        if (disallowMaxlengthViolation(GetObjectReference("", "Description"), 200)) {
            strMsg += '<li>- Max Length of Description is 200 characters.\r\nYou have entered <L> characters. </li><br>';
            chkVal = 1;
        }
        var objFromDt1 = GetObjectReference("", "dtAMCFrom");
        var objToDt1 = GetObjectReference("", "dtAMCTo");
        var objDueDt = GetObjectReference("", "dtAMCDueDate");

        if (disallowDate1GreaterThanDate2(objFromDt1, objToDt1) == true) {
            strMsg += '<li>- AMC To Date Cannot be Less than AMC From Date. </li><br>';
            chkVal = 1;
        }

        if (disallowDate1GreaterThanDate2(objFromDt1, objDueDt) == true) {
            strMsg += '<li>- AMC Due Date Cannot be out side the Date Range. </li><br>';
            chkVal = 1;
        }


        if (disallowDate1GreaterThanDate2(objDueDt, objToDt1) == true) {
            strMsg += '<li>-AMC Due Date Cannot be out side the Date Range ' + objFromDt1.value + ' To ' + objToDt1.value + '  </li><br>';
            chkVal = 1;
        }
        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '');
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }
        return chkVal;
    }
    function RefreshAMCGrid(CustomerProductVersionIDGlobal) {
        var data;
        var strResult;
        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal })
        strResult = AJAXCallWithResult(strPageName + "/RefreshAMCGrid", data, false);
        if (strResult.d != null) {

            $("#divAMCGrid").html("");
            $("#divAMCGrid").html(strResult.d);
            datatablesSubTag("divAMCGrid", "");
        }
    }

    function LicenseEdit_OnClick(LicenseID, CustomerProductVersionID) {
        var data;
        var strResult;

        data = JSON.stringify({ LicenseID: LicenseID, CustomerProductVersionID: CustomerProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/GetLicenseDetails", data, false);
        if (strResult.d != null) {
            $("#panelLicense").html("");
            $("#panelLicense").html(strResult.d);
            $("#accordion35").css("display", "block");
            $("#panellicenseAdd").css("display", "block");
            
            RefreshGridDetails();
            $("#dtReference").datepicker();



        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SaveLicenseDetails(LicenseID) {
        var data;
        var strResult;
        var strReferenceCode = "";
        var strReferencedate = "";
        var strQuantity = "";
        var strPriceUnit = "";
        var strCurrency = "";
        var strPricePerUnit = "";
        var strDiscount = "";
        var strDescription = "";

        if (ValidateLicense() == 0) {

            strReferenceCode = $("#txtReferenceCode").val();
            strReferencedate = $("#dtReference").val();
            strQuantity = $("#txtLicenseQuantity").val();
            strPriceUnit = $("#cboPriceUnitLicense").val();
            strPricePerUnit = $("#txtPricePerUnitLicense").val();
            strCurrency = $("#cboCurrencyLicense").val();
            strDiscount = $("#txtDiscountLicense").val();
            strDescription = $("#txtLicenseDescription").val();

            data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal, LicenseID: LicenseID, ReferenceCode: strReferenceCode, Referencedate: strReferencedate, Quantity: strQuantity, PriceUnit: strPriceUnit, PricePerUnit: strPricePerUnit, Currency: strCurrency, Discount: strDiscount, Description: strDescription })
            strResult = AJAXCallWithResult(strPageName + "/SaveLicenseDetails", data, false);
            if (strResult.d != null) {
                if (strResult.d == "1") {
                    if (LicenseID != 0 || LicenseID != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Updated Successfully.", 'success');
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Saved Successfully.", 'success');
                    }
                    RefreshLicenseGrid(CustomerProductVersionIDGlobal)
                }
            }
        }
    }
    function ValidateLicense() {
        var chkVal = 0;
        var strMsg = "";



        if (disallowSpecialCharacters(GetObjectReference("", "txtReferenceCode"), '', true)) {
            strMsg += '<li>- A Reference Code cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
        }


        //if (disallowBlank(GetObjectReference("", "dtReference"))) {
        //    strMsg += '<li>- Reference Date should not be left blank. </li><br>';
        //    chkVal = 1;
        //}
        if ($("#dtReference").val() == "")
        {
            strMsg += '<li>- Reference Date should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowBlank(GetObjectReference("", "txtLicenseQuantity"))) {
            strMsg += '<li>- Quantity should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtLicenseQuantity"), '', true)) {
            strMsg += '<li>-A Quantity cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
        }

        if (disallowMinValueViolation(GetObjectReference("", "txtLicenseQuantity"), 1)) {
            strMsg += '<li>- The value of Quantity should not be less than 1. </li><br>';
            chkVal = 1;
        }

        if (disallowNegativeInteger(GetObjectReference("", "txtLicenseQuantity"))) {
            strMsg += '<li>- Please enter only positive Integer. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "cboPriceUnitLicense"))) {
            strMsg += '<li>- Price Unit  should not be left blank. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "cboCurrencyLicense"))) {
            strMsg += '<li>- Currency should not be left blank. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "txtPricePerUnitLicense"))) {
            strMsg += '<li>- Price Per Unit should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowNegativeNumeric(GetObjectReference("", "txtPricePerUnitLicense"))) {
            strMsg += '<li>- Please enter only positive numeric value for Price Per Unit. </li><br>';
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtPricePerUnitLicense"))) {
            strMsg += '<li>- A Price Per Unit cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
        }

        if (disallowMinValueViolation(GetObjectReference("", "txtPricePerUnitLicense"), 1)) {
            strMsg += '<li>-The value of Price Per Unit should not be less than 1. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "txtDiscountLicense"))) {
            strMsg += '<li>- Discount should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowNegativeNumeric(GetObjectReference("", "txtDiscountLicense"))) {
            strMsg += '<li>- Please enter only positive numeric value for </li><br>';
            chkVal = 1;
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtDiscountLicense"), '', true)) {
            strMsg += '<li>- A Discount % cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
        }

        if (disallowValueRangeViolation(GetObjectReference("", "txtDiscountLicense"), 0, 100)) {
            strMsg += '<li>- The value of Discount  should be in the range of (0-100).</li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "txtLicenseDescription"))) {
            strMsg += '<li>- Description should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowMaxlengthViolation(GetObjectReference("", "txtLicenseDescription"), 2000)) {
            strMsg += '<li>-Max Length of Description is 2000 characters.\r\nYou have entered ' + GetObjectReference("", "txtLicenseDescription").value.length + ' characters.</li><br>';
            chkVal = 1;
        }

        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '');
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }
        return chkVal;
    }
    function RefreshLicenseGrid(CustomerProductVersionIDGlobal) {
        var data;
        var strResult;
        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal })
        strResult = AJAXCallWithResult(strPageName + "/RefreshLicenseGrid", data, false);
        if (strResult.d != null) {

            $("#divLicenseGrid").html("");
            $("#divLicenseGrid").html(strResult.d);
            datatablesSubTag("divLicenseGrid", "");
            $("#accordion35").css("display", "none");
        }
    }
    function Cancel_License() {
        $("#accordion35").css("display", "none");
    }
    function ReleaseEdit_OnClick(ReleaseID, CustomerProductVersionID) {
        var data;
        var strResult;

        data = JSON.stringify({ ReleaseID: ReleaseID, CustomerProductVersionID: CustomerProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/GetReleaseDetails", data, false);
        if (strResult.d != null) {
            $("#panelRelease").html("");
            $("#panelRelease").html(strResult.d);
            $("#accordion36").css("display", "block");
            $("#panelReleaseAdd").css("display", "block");
            
            RefreshGridDetails();
            $("#dtreleasedate").datepicker();



        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SaveReleaseDetails(ReleaseID) {
        var data;
        var strResult;
        var strSubject = "";
        var strRelaseDate = "";
        var strObjectives = "";
        var strReleaseItems = "";
        var strKnownProblems = "";
        var strIssues = "";
        var strTestingSummary = "";
        var strInstallation = "";
        if (ValidateRelease() == 0) {

            strSubject = $("#txtRelaseSubject").val();
            strRelaseDate = $("#dtreleasedate").val();
            strObjectives = $("#txtObjectives").val();
            strReleaseItems = $("#txtReleaseItems").val();
            strKnownProblems = $("#txtKnownProblems").val();
            strIssues = $("#txtRelaseIssues").val();
            strTestingSummary = $("#txttestingsummary").val();
            strInstallation = $("#txtinstallation").val();
            data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal, ReleaseID: ReleaseID, Subject: strSubject, Objectives: strObjectives, ReleaseItems: strReleaseItems, KnowmProblems: strKnownProblems, Issues: strIssues, TestingSummary: strTestingSummary, Installation: strInstallation })
            strResult = AJAXCallWithResult(strPageName + "/SavereleaseDetails", data, false);
            if (strResult.d != null) {
                if (strResult.d == "1") {
                    if (ReleaseID != 0 || ReleaseID != "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Updated Successfully.", 'success');
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Saved Successfully.", 'success');
                    }
                    RefreshreleaseGrid(CustomerProductVersionIDGlobal)
                }
            }
        }
    }
    function ValidateRelease() {

        var chkVal = 0;
        var strMsg = "";



        if (disallowBlank(GetObjectReference("", "txtRelaseSubject"))) {
            strMsg += '<li>- Subject should not be left blank. </li><br>';
            chkVal = 1;
        }


        if (disallowSpecialCharacters(GetObjectReference("", "txtRelaseSubject"))) {
            strMsg += '<li>- A Subject cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "txtObjectives"))) {
            strMsg += '<li>- Objectives should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowMaxlengthViolation(GetObjectReference("", "txtObjectives"), 2000)) {
            strMsg += '<li>- Max Length of Objectives is 2000 characters.\r\nYou have entered ' + GetObjectReference("", "Objectives").value.length + ' characters. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "txtReleaseItems"))) {
            strMsg += '<li>- Details about release items should not be left blank. </li><br>';
            chkVal = 1;
        }


        if (disallowMaxlengthViolation(GetObjectReference("", "txtReleaseItems"), 800)) {
            strMsg += '<li>-Max Length of Details about release items is 800 characters.\r\nYou have entered ' + GetObjectReference("", "Details").value.length + ' characters. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "txtKnownProblems"))) {
            strMsg += '<li>- Known Problems should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowMaxlengthViolation(GetObjectReference("", "txtKnownProblems"), 2000)) {
            strMsg += '<li>- Max Length of Known Problems is 2000 characters.\r\nYou have entered ' + GetObjectReference("", "KnownProblems").value.length + ' characters. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "txtRelaseIssues"))) {
            strMsg += '<li>- Issues should not be left blank. </li><br>';
            chkVal = 1;
        }

        if (disallowMaxlengthViolation(GetObjectReference("", "txtRelaseIssues"), 1500)) {
            strMsg += '<li>- Max Length of Issues is 1500 characters.\r\nYou have entered ' + GetObjectReference("", "Issues").value.length + ' characters. </li><br>';
            chkVal = 1;
        }


        if (disallowMaxlengthViolation(GetObjectReference("", "txttestingsummary"), 2000)) {
            strMsg += '<li>- Max Length of Testing Summar is 2000 characters.\r\nYou have entered ' + GetObjectReference("", "TestingSummary").value.length + ' characters. </li><br>';
            chkVal = 1;
        }


        if (disallowMaxlengthViolation(GetObjectReference("", "txtinstallation"), 800)) {
            strMsg += '<li>- Max Length of Installation is 800 characters.\r\nYou have entered ' + GetObjectReference("", "Installation").value.length + ' characters. </li><br>';
            chkVal = 1;
        }
        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '');
        if (strMsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }
        return chkVal;
    }
    function RefreshreleaseGrid(CustomerProductVersionIDGlobal) {
        var data;
        var strResult;
        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal })
        strResult = AJAXCallWithResult(strPageName + "/RefreshReleaseGrid", data, false);
        if (strResult.d != null) {

            $("#divReleaseGrid").html("");
            $("#divReleaseGrid").html(strResult.d);
            datatablesSubTag("divReleaseGrid", "");
            $("#accordion36").css("display", 'none');
        }
    }
    function DeleteProduct() {

        var table = $('#divCustomerProductGrid  table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();


        var strProductIDs = $("[name='chkProductDelete']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strProductIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least record to delete', 'error');
            return;
        }
        data = JSON.stringify({ ProductIDs: strProductIDs });
        strResult = AJAXCallWithResult(strPageName + "/DeleteProduct", data, false);
        if (strResult.d != '' || strResult.d != '') {
            var arrResult = strResult.d.split("##");
            arrResult = arrResult.slice(0, arrResult.length - 1);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('' + arrResult + '', 'success');
            RefreshCustomerProductGrid();
        }


    }
    function DeleteMultiple_Product() {
        var table = $('#divCustomerProductGrid  table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllProduct').checked == true) {

            $('[name="chkProductDelete"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkProductDelete"]', rows).prop('checked', false);
        }
    }
    function SelectAll_Module(obj) {
        var table = $('#divComponentGrid   table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllSelectModule').checked == true) {

            $('[name="chkComponentDelete"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkComponentDelete"]', rows).prop('checked', false);
        }
    }
    function DeleteModuleComponent_Onclick() {
        var table = $('#divComponentGrid  table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();


        var strProductIDs = $("[name='chkComponentDelete']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strProductIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least record to delete', 'error');
            return;
        }
        data = JSON.stringify({ ProductIDs: strProductIDs });
        strResult = AJAXCallWithResult(strPageName + "/DeleteModuleComponent", data, false);
        if (strResult.d != '' || strResult.d != '') {
            var arrResult = strResult.d.split("##");
            arrResult = arrResult.slice(0, arrResult.length - 1);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('' + arrResult + '', 'success');
            RefreshComponentGrid();
        }
    }
    function RefreshComponentGrid() {
        var data;
        var strResult;
        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal })
        strResult = AJAXCallWithResult(strPageName + "/RefreshComponentDetails", data, false);
        if (strResult.d != null) {

            $("#divComponentGrid").html("");
            $("#divComponentGrid").html(strResult.d);
            datatablesSubTag("divComponentGrid", "");
        }
    }
    function SelectAll_Module(obj) {
        var table = $('#divComponentGrid   table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllSelectModule').checked == true) {

            $('[name="chkComponentDelete"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkComponentDelete"]', rows).prop('checked', false);
        }
    }
    function SelectAll_AMC(obj) {
        var table = $('#divAMCGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllSelectAMC').checked == true) {

            $('[name="chkAMCDelete"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkAMCDelete"]', rows).prop('checked', false);
        }
    }
    function DeleteAMC_Onclick() {
        var table = $('#divAMCGrid  table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        var strProductIDs = $("[name='chkAMCDelete']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strProductIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least record to delete', 'error');
            return;
        }
        data = JSON.stringify({ ProductIDs: strProductIDs });
        strResult = AJAXCallWithResult(strPageName + "/AMCDelete", data, false);
        if (strResult.d != '' || strResult.d != null) {
            var arrResult = strResult.d.split("##");
            arrResult = arrResult.slice(0, arrResult.length - 1);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('' + arrResult + '', 'success');
            RefreshAMCGrid();
        }
    }
    function RefreshAMCGrid() {
        var data;
        var strResult;
        data = JSON.stringify({ CustomerProductVersionID: CustomerProductVersionIDGlobal })
        strResult = AJAXCallWithResult(strPageName + "/RefreshAMCGrid", data, false);
        if (strResult.d != null) {

            $("#divAMCGrid").html("");
            $("#divAMCGrid").html(strResult.d);
            datatablesSubTag("divAMCGrid", "");
            $("#accordion34").css('display', 'none');
        }
    }
    function SelectAll_License(obj) {
        var table = $('#divLicenseGrid  table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllSelectLicense').checked == true) {

            $('[name="chkLicenseDelete"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkLicenseDelete"]', rows).prop('checked', false);
        }
    }
    function DeleteLicense_Onclick() {
        var table = $('#divLicenseGrid  table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        var strProductIDs = $("[name='chkLicenseDelete']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strProductIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least record to delete', 'error');
            return;
        }
        data = JSON.stringify({ ProductIDs: strProductIDs });
        strResult = AJAXCallWithResult(strPageName + "/LicenseDelete", data, false);
        if (strResult.d != '' || strResult.d != '') {
            var arrResult = strResult.d.split("##");
            arrResult = arrResult.slice(0, arrResult.length - 1);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('' + arrResult + '', 'success');
            RefreshLicenseGrid(CustomerProductVersionIDGlobal)
        }
    }
    function SelectAll_Release(obj) {
        var table = $('#divReleaseGrid   table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllRelease').checked == true) {

            $('[name="chkReleaseDelete"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkReleaseDelete"]', rows).prop('checked', false);
        }
    }
    function DeleteRelease_Onclick() {
        var table = $('#divReleaseGrid  table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        var strProductIDs = $("[name='chkReleaseDelete']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strProductIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least record to delete', 'error');
            return;
        }
        data = JSON.stringify({ ProductIDs: strProductIDs });
        strResult = AJAXCallWithResult(strPageName + "/ReleaseDelete", data, false);
        if (strResult.d != '' || strResult.d != '') {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Record deleted successfully', 'success');
            RefreshreleaseGrid(CustomerProductVersionIDGlobal)
        }
    }
</script>
