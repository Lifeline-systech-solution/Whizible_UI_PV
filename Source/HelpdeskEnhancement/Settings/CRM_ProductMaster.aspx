<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_ProductMaster.aspx.vb" Inherits="PbNIT.CRM_ProductMaster" %>

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
    <%--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
    <%--<link href="../../../EnhancementFiles/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <%--<link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../General/CommonFunctions.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>

    <script src="../../../EnhancementFiles/js/editor.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
	<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../EnhancementFiles/OnlineFiles/datepicker/bootstrap-datepicker.js"></script>
    <link href="../../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />
</head>

    <style>
           /*Added By Yasmin on 25th july 2018*/
        .dataTables_paginate {
        float:right!important;
        }
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
            /*float: right !important;*/      /*Commented by Usha Pandit on 24 JAN 2018 for pagination alignment issue*/
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

        .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        .dataTables_wrapper .dataTables_paginate ul li {
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

        .dataTables_wrapper {
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



        .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        .dataTables_paginate {
            /*float: right !important;*/      /*Commented by Usha Pandit on 24 JAN 2018 for pagination alignment issue*/ 
        }

            .dataTables_paginate ul {
                margin-top: 2% !important;
                /*margin-left: -5% !important;*/       /*Commented by Usha Pandit on 31 JAN 2018 for pagination alignment issue*/ 
            }

        .dataTables_scrollBody {
            overflow: auto !important;
            width: 103% !important;
            /*height: 132px!important;*/
            padding-right: 1.8% !important;
        }

        .dataTables_scroll {
            overflow: hidden !important;
            width: 100% !important;
        }

        table tr th {
            border: 1px solid #ddd !important;
        }

        #ProductFilter {
            padding-bottom: 15px !important;
        }

        .editor textarea, input[type="text"] {
            padding-left: 18px !important;
        }

        #divProductMasterGrid .fa-sort {
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


        tr.group,
        tr.group:hover {
            background-color: #ddd !important;
        }

        .request-details-pg {
            min-height: 100% !important;
        }

        #cboProductLine, #cboPriceUnit {
            margin-top: 6px !important;
        }

        #panelProductVersion .panel-body, #panelProductVersion {
            padding-top: 0px !important;
        }

            #panelProductVersion .col-sm-4 {
                white-space: nowrap !important;
            }

        #txtComponentDescription {
            height: 50px !important;
        }

        #txtProductVersionDescription {
            height: 50PX !important;
        }

        #divProductMasterGrid table tr td:nth-child(2) {
            width: 40% !important;
            word-break: break-all !important;
        }

        #divProductMasterGrid table tr td:nth-child(1) {
            width: 40% !important;
            word-break: break-all !important;
        }

        .bottom-bar ul.right .fa-plus {
            color: #647ea8 !important;
            padding-left: 5px;
        }

        #idProductComponent .modal-content {
            height: auto !important;
        }
        .clsselectmodule {
            text-decoration:underline;
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
    <div id="idProductComponent" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Product Version Component Selection</span>
                <span onclick="document.getElementById('idProductComponent').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="form-group  top-bar">
                <ul style='display: inline-block;'>
                    <li class='left search-bar'>
                        <div class='left search-bar'><i class='fa fa-search faSettingSearch' style='color: black!important' aria-hidden='true'></i>
                            <input type='text' id='txtSearchComponent' placeholder='Search in table' style='margin-top: 3px!important;'></div>
                    </li>

                </ul>
                <%-- <ul style='display: inline-block;float:right'>
            <li class='left '>
            <button type='button' id='SaveProductComponents' class='btn btn-default save' onclick='SaveProductComponents_Onclick()' style='background-color: #343660; color: #ffffff' title='Save'>Save</button>
            </li>

            </ul>--%>
            </div>
            <div class="container-fluid" id="Componentmodalbody" style="overflow: auto; height: auto;">
              

            </div>
             <div class='form-group' style='border-bottom: none; margin-top: 5px;padding-right:30px'>
                    <div class='right'>
                        <button type='button' id='SaveProductComponents' class='btn btn-default save' onclick="SaveProductComponents_Onclick()" style='background-color: #343660; color: #ffffff;font-size:11px' >Save</button>

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
        //$('.modal').draggable();

    });
    var strPageName = "CRM_ProductMaster.aspx";
    var ProductIDGlobal = 0;
    var ProductVersionGlobal = 0;
    var curProductVersionID = 0;         //Added by Usha Pandit on 25 JAN 2018 for Save Issue
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

        DivId = "divProductMasterGrid";
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
            $("#divScroll").css('height', intDivGridListHeight + 400 + "px");
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
            $("#divScroll").css('height', intDivGridListHeight + 300 + "px");
            //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);

        }
        datatables(DivId, DivSerach);

        //Added by Usha Pandit on 01 FEB 2018 for pagination alignment
        if (WhichBrowser() == "CR") {
            $(".dataTables_paginate").css("float", "right");
        }
        //End of Added by Usha Pandit on 01 FEB 2018 for pagination alignment
    }
    function datatables(divID, txtBoxID) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({
            columnDef: [
         { "visible": false, "targets": 0 }
            ],
            "order": [[0, 'asc']],
            responsive: true, "pageLength": 3,

            //scrollY: '120px',
            pagingType: "simple_numbers",
            //scrollX: true,
            language: {

            },
            //drawCallback: function (settings) {
            //    var api = this.api();
            //    var rows = api.rows({ page: 'current' }).nodes();
            //    var last = null;

            //    api.column(0, { page: 'current' }).data().each(function (group, i) {
            //        if (last !== group) {
            //            $(rows).eq(i).before(
            //                '<tr class="group"><td colspan="5">' + group + '</td></tr>'
            //            );

            //            last = group;
            //        }
            //    });
            //}

        });
        //$('#' + divID +' tbody').on('click', 'tr.group', function () {
        //    var currentOrder = table.order()[0];
        //    if (currentOrder[0] === 0 && currentOrder[1] === 'asc') {
        //        table.order([0, 'desc']).draw();
        //    }
        //    else {
        //        table.order([0, 'asc']).draw();
        //    }
        //});
        // debugger;
        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
        //$(".clsTROdd td:first-child").html("");
        //$(".clsTREvenRow td:first-child").html("");
    }
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
    function ProductLineOnChange(obj) {
        var data;
        var strResult;
        data = JSON.stringify({ ProductLine: obj.value })
        strResult = AJAXCallWithResult(strPageName + "/ProductLineChange", data, false);
        if (strResult.d != null) {

            $("#divProductMaster").html("");
            $("#divProductMaster").html(strResult.d);
            RefreshPage();
        }
    }
    function ProductEdit_OnClick(ProductID) {
        var DivId;
        var DivSerach;
        var strResult, data;
        ProductIDGlobal = ProductID;

        data = JSON.stringify({ ProductID: ProductID })
        strResult = AJAXCallWithResult(strPageName + "/PlotProductDetails", data, false);
        if (strResult.d != null) {
            $("#divSubTypeBottom").html("");
            $("#divSubTypeBottom").html(strResult.d);
        }
        $("#divSubTypeBottom").css("display", "block")
        $("#ProductFilter").css("display", "none")
        $("#divSubTypeBottom").css('height', 'auto');
        $("#collapseOne2").addClass('in');
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto !important');
            $("#collapseOne2").addClass('in');
        }
        $("#ProductFilter").css("display", "none")
        $("#divProductMaster").css("display", "none")
        DivId = "divProductVersionGrid";
        DivSerach = "";
        datatablesSubTag(DivId, DivSerach);
        DivId = "divCompetitorGrid";
        DivSerach = "";
        datatablesSubTag(DivId, DivSerach);

        RefreshPage();

        //Added by Usha Pandit on 25 JAN 2018 for Sub Tab Plotting Issue
        var data;
        var strResult;

        curProductVersionID = 0;
        data = JSON.stringify({ ProductVersionID: curProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/GetProductVersion", data, false);
        if (strResult.d != null) {
            $("#panelProductVersion").html("");
            $("#panelProductVersion").html(strResult.d);
            $("#accordionProductVersion").css("display", "block");
            RefreshPage();
            $("#txtProductVersionCode").focus();
        }



        data = JSON.stringify({ ProductCompetitiorId: '', ProductID: ProductIDGlobal })
        strResult = AJAXCallWithResult(strPageName + "/GetCompetitor", data, false);
        if (strResult.d != null) {
            $("#panelCompetitor").html("");
            $("#panelCompetitor").html(strResult.d);
            $("#accordionCompetitor").css("display", "block");
            RefreshPage();
            $("#cboCompetitor").focus();
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

        //End of Added by Usha Pandit on 25 JAN 2018 for Sub Tab Plotting Issue
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

        });


        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }
    function Cancel_Product() {
        $("#divSubTypeBottom").css("display", "none");

        $("#ProductFilter").css("display", "block");
        $("#divProductMaster").css("display", "block")

        RefreshGrid();

    }
    function RefreshGrid() {
        var data;
        var strResult;
        var strProductLineID = $("#cboProductLineID").val();
        data = JSON.stringify({});
        if (strProductLineID == "" || null) {

            data = JSON.stringify({ ProductLineID: "" })
        }
        else {
            data = JSON.stringify({ ProductLineID: strProductLineID })
        }
        strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);
        if (strResult.d != null) {

            $("#divProductMaster").html("");
            $("#divProductMaster").html(strResult.d);
            RefreshPage();
        }
    }
    function SaveProduct(ProductID) {
        if (ProductID == undefined) {
            ProductID = "";
        }
        var data;
        var strResult;
        var strProductCode;
        var strProductLine;
        var strProduct;
        var strDescription;
        if (ValidateProduct(ProductID) == 0) {
            strProduct = $("#txtProduct").val();
            strProductCode = $("#txtProductCode").val();
            strProductLine = $("#cboProductLine").val();
            strDescription = $("#txtDescription").val();

            data = JSON.stringify({ ProductID: ProductID, Product: strProduct, ProductCode: strProductCode, Description: strDescription, ProductLineID: strProductLine })
            strResult = AJAXCallWithResult(strPageName + "/SaveProductDetails", data, false);
            if (strResult.d != null) {
                if (strResult.d != "0") {
                    if (ProductID != 0 || ProductID != "") {
                        alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Updated Successfully.", 'success');
                    }
                    else {
                        alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Saved Successfully.", 'success');
                        RefreshGrid();

                        ProductEdit_OnClick(strResult.d);
                    }

                }
            }
        }
    }
    function ValidateProduct(ProductID) {
        var chkVal = 0;
        var strMsg = "";
        var data;
        var strResult;
        var strProduct;
        var strProductCode;

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        var blnProductCodeInValid = false;
        var blnProductInValid = false;
        var blnProductLineInValid = false;
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        strProduct = $("#txtProduct").val();
        strProductCode = $("#txtProductCode").val();
        if (disallowBlank(GetObjectReference("", "txtProductCode"))) {
            strMsg += "<li>- Product Code should not be left blank. </li><br>";
            chkVal = 1;
            blnProductCodeInValid = true;     //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        //Commented by Usha Pandit on 01 FEB 2018 for allowing special characters
        //else if (disallowSpecialCharacters(GetObjectReference("", "txtProductCode"))) {
        //    strMsg += '<li>- A Product Code cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
        //    chkVal = 1;
        //    blnProductCodeInValid = true;      //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        //}
        //End of Commented by Usha Pandit on 01 FEB 2018 for allowing special characters


        if (disallowBlank(GetObjectReference("", "txtProduct"))) {
            strMsg += "<li>- Product should not be left blank. </li><br>";
            chkVal = 1;
            blnProductInValid = true;       //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }

        //Commented by Usha Pandit on 01 FEB 2018 for allowing special characters
        //else if (disallowSpecialCharacters(GetObjectReference("", "txtProduct"), '', true)) {

        //    strMsg += '<li>- A Product cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
        //    chkVal = 1;
        //    blnProductInValid = true;         //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        //}
        //End of Commented by Usha Pandit on 01 FEB 2018 for allowing special characters

        if (ProductID == undefined || ProductID == "") {

            if (chkVal == 0) {
                data = JSON.stringify({ strProduct: strProduct, strProductCode: strProductCode })
                strResult = AJAXCallWithResult(strPageName + "/CheckDuplicates", data, false);
                if (strResult.d != null) {
                    var arresult = strResult.d.split("||")
                    if (arresult[0] == "1") {
                        strMsg += '<li>- Product already exists. </li><br>';
                        chkVal = 1;
                        blnProductInValid = true;       //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                    }
                    if (arresult[1] == "1") {
                        strMsg += '<li>- Product Code already exists. </li><br>';
                        chkVal = 1;
                        blnProductCodeInValid = true;     //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                    }
                }
            }
        }



        if (disallowBlank(GetObjectReference("", "cboProductLine"))) {
            strMsg += '<li>- Product Line should not be left blank.</li><br>';
            chkVal = 1;
            blnProductLineInValid = true    //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field    
        }

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnProductCodeInValid == true) {
            $('#txtProductCode').focus();
        }
        if (blnProductInValid == true) {
            if ($('#txtProductCode').is(':focus') == true) {

            }
            else {
                $("#txtProduct").focus();
            }
        }

        if (blnProductLineInValid == true) {
            if ($('#txtProductCode').is(':focus') == true || $('#txtProduct').is(':focus') == true) {

            }
            else {
                $("#cboProductLine").focus();
            }
        }
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field


        if (disallowMaxlengthViolation(GetObjectReference("", "txtDescription"), 2000)) {
            strMsg += '<li>- Max Length of Description is 2000 characters.\r\nYou have entered ' + GetObjectReference("", "txtDescription").value.length + ' characters..</li><br>';
            chkVal = 1;
            //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            if ($('#txtProduct').is(':focus') == true || $('#txtProductCode').is(':focus') == true || $('#cboProductLine').is(':focus') == true) {

            }
            else {
                $("#txtDescription").focus();
            }
            //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '-');
        if (strMsg != "") {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }

        return chkVal;
    }

    //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
    function disallowSpecialCharacters(obj) {
        if (obj == null) { return false; }
        if (isBlank(getInputValue(obj))) { return false; }
        var msg = (arguments.length > 1) ? arguments[1] : "";
        msg = replaceSubstring(msg, "&#39;", "'");
        var dofocus = (arguments.length > 2) ? arguments[2] : true;
        var spChars = (arguments.length > 3) ? arguments[3] : "[/:*?+\"><|,\\\\]";
        if (hasSpecialCharacters(getInputValue(obj), spChars)) {
            if (!isBlank(msg)) { alert(msg); }

            return true;
        }
        return false;
    }

    function disallowMaxlengthViolation(obj, maxLength) {
        if (obj == null) { return false; }
        if (isBlank(getInputValue(obj))) { return false; }
        var msg = (arguments.length > 2) ? arguments[2] : "";
        msg = replaceSubstring(msg, "&#39;", "'");
        //Added By - Ninad : Req ID - WAF3_PB_48 : Dt 21 May 2007
        var lngth = getInputValue(obj).length.toString();
        msg = replaceSubstring(msg, "<L>", lngth);
        //End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 21 May 2007
        var dofocus = (arguments.length > 3) ? arguments[3] : true;
        if (parseFloat(getInputValue(obj).length) > parseFloat(maxLength)) {
            if (!isBlank(msg)) { alert(msg); }

            return true;
        }
        return false;
    }

    function disallowBlank(obj) {
        if (obj == null) { return false; }
        var msg = (arguments.length > 1) ? arguments[1] : "";
        msg = replaceSubstring(msg, "&#39;", "'");
        var dofocus = (arguments.length > 2) ? arguments[2] : true;
        if (isBlank(getInputValue(obj))) {
            if (!isBlank(msg)) { alert(msg); }
            if (dofocus) {

                if (obj.type == 'select-one') {
                    obj.selectedIndex = -1;//Modified By ShrikantB On 21-OCT-2010 For 
                    //obj.click();
                    //obj.style.backgroundColor="#000066";
                }
            }
            return true;
        }
        return false;
    }
    //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

    function AddProduct() {

        var strResult, data;


        data = JSON.stringify({})
        strResult = AJAXCallWithResult(strPageName + "/AddProduct", data, false);
        if (strResult.d != null) {
            $("#divSubTypeBottom").html("");
            $("#divSubTypeBottom").html(strResult.d);
        }
        $("#divSubTypeBottom").css("display", "block")
        $("#ProductFilter").css("display", "none")
        $("#divProductMaster").css("display", "none")
        $("#divSubTypeBottom").css('height', 'auto');
        $("#collapseOne2").addClass('in');
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto !important');
            $("#collapseOne2").addClass('in');
        }
    }

    function ProductVersionEdit_OnClick(ProductVersionID) {
        var data;
        var strResult;

        data = JSON.stringify({ ProductVersionID: ProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/GetProductVersion", data, false);
        if (strResult.d != null) {
            $("#panelProductVersion").html("");
            $("#panelProductVersion").html(strResult.d);
            $("#accordionProductVersion").css("display", "block");
            RefreshPage();
            $("#txtProductVersionCode").focus();
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function AddProductVersion_Onclick(ProductID) {
        curProductVersionID = 0;     //Added by Usha Pandit on 25 JAN 2018 for Save Issue
        var data;
        var strResult;

        data = JSON.stringify({ ProductVersionID: '' })
        strResult = AJAXCallWithResult(strPageName + "/GetProductVersion", data, false);
        if (strResult.d != null) {
            $("#panelProductVersion").html("");
            $("#panelProductVersion").html(strResult.d);
            $("#accordionProductVersion").css("display", "block");
            RefreshPage();
            $("#txtProductVersionCode").focus();
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }

    //Commented and Added by Usha Pandit on 25 JAN 2018 for Save Issue
    //function SaveProductVersion(ProductVersionID) {
    //    var data;
    //    var strResult;
    //    var strProductVersion = "";
    //    var strProductVersionCode = "";
    //    var strDescription = "";
    //    var strPriceUnit = "";
    //    var strListPrice = "";
    //    var strDiscountPer = "";
    //    if (ValidateProductVersion(ProductVersionID) == 0) {
    //        strProductVersion = $("#txtProductVersion").val();
    //        strProductVersionCode = $("#txtProductVersionCode").val();
    //        strDescription = $("#txtProductVersionDescription").val();
    //        strPriceUnit = $("#cboPriceUnit").val();
    //        strListPrice = $("#txtListPrice").val();

    //        strDiscountPer = $("#txtDiscountPer").val();
    //        data = JSON.stringify({ ProductID: ProductIDGlobal, ProductVersionID: ProductVersionID, ProductVersion: strProductVersion, ProductVersionCode: strProductVersionCode, Description: strDescription, PriceUnit: strPriceUnit, ListPrice: strListPrice, DiscountPercentage: strDiscountPer })
    //        strResult = AJAXCallWithResult(strPageName + "/SaveProductversionDetails", data, false);
    //        if (strResult.d != null) {
    //            if (strResult.d == "1") {
    //                if (ProductVersionID != 0 || ProductVersionID != "") {
    //                    alertify.set('notifier', 'position', 'top-right');
    //                    alertify.notify("Data Updated Successfully.", 'success');
    //                }
    //                else {
    //                    alertify.set('notifier', 'position', 'top-right');
    //                    alertify.notify("Data Saved Successfully.", 'success');
    //                }
    //                RefreshProductVersionGrid(ProductIDGlobal);
    //            }
    //        }
    //    }

    //}

    function SaveProductVersion(ProductVersionID) {
        var data;
        var strResult;
        var strProductVersion = "";
        var strProductVersionCode = "";
        var strDescription = "";
        var strPriceUnit = "";
        var strListPrice = "";
        var strDiscountPer = "";


        if (ValidateProductVersion(curProductVersionID) == 0) {
            strProductVersion = $("#txtProductVersion").val();
            strProductVersionCode = $("#txtProductVersionCode").val();
            strDescription = $("#txtProductVersionDescription").val();
            strPriceUnit = $("#cboPriceUnit").val();
            strListPrice = $("#txtListPrice").val();

            strDiscountPer = $("#txtDiscountPer").val();
            data = JSON.stringify({ ProductID: ProductIDGlobal, ProductVersionID: curProductVersionID, ProductVersion: strProductVersion, ProductVersionCode: strProductVersionCode, Description: strDescription, PriceUnit: strPriceUnit, ListPrice: strListPrice, DiscountPercentage: strDiscountPer })
            strResult = AJAXCallWithResult(strPageName + "/SaveProductversionDetails", data, false);
            if (strResult.d != null) {
                if (strResult.d != "") {

                    var newProductVersionID = strResult.d;

                    if (curProductVersionID == 0) {
                        alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Saved Successfully.", 'success');
                    }
                    else {
                        alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Updated Successfully.", 'success');
                    }
                    curProductVersionID = newProductVersionID
                    RefreshProductVersionGrid(ProductIDGlobal);
                }
            }
        }

    }

    //End of Added by Usha Pandit on 25 JAN 2018 for Save Issue

    function ValidateProductVersion(ProductVersionID) {
        var chkVal = 0;
        var strMsg = "";
        var data;
        var strResult;

        var blnProductVersionInValid = false;     //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        var blnProductVersionCodeInValid = false;     //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if (disallowBlank(GetObjectReference("", "txtProductVersionCode"))) {
            strMsg += "<li>- Product Version Code should not be left blank. </li><br>";
            chkVal = 1;
            blnProductVersionCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        else if (disallowSpecialCharacters(GetObjectReference("", "txtProductVersionCode"))) {
            strMsg += '<li>- A Product Version Code cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
            blnProductVersionCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        if (disallowBlank(GetObjectReference("", "txtProductVersion"))) {
            strMsg += '<li>- Product Version should not be left blank. </li><br>';
            chkVal = 1;
            blnProductVersionInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        else if (disallowSpecialCharacters(GetObjectReference("", "txtProductVersion"), '', true)) {
            strMsg += '<li>- A Product Version cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
            blnProductVersionInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        var strProductVersion = GetObjectReference("", "txtProductVersion").value;
        var strProductVersionCode = GetObjectReference("", "txtProductVersionCode").value;

        //Commented and Added by Usha Pandit on 25 JAN 2018 for Save Issue
        //if (ProductVersionID == undefined || ProductVersionID == "") {

        //    if (chkVal == 0) {
        //        data = JSON.stringify({ ProductVersion: strProductVersion, ProductVersionCode: strProductVersionCode })
        //        strResult = AJAXCallWithResult(strPageName + "/CheckProductVersionDuplicates", data, false);
        //        if (strResult.d != null) {
        //            var arresult = strResult.d.split("||")
        //            if (arresult[0] == "1") {
        //                strMsg += '<li>- Product Version already exists. </li><br>';
        //                chkVal = 1;
        //            }
        //            if (arresult[1]) {
        //                strMsg += '<li>- Product Version Code already exists. </li><br>';
        //                chkVal = 1;
        //            }
        //        }
        //    }
        //}

        if (strProductVersion != "") {
            data = JSON.stringify({ ProductVersion: strProductVersion, ProductVersionCode: "", Flag: "ProductVersion", ProductVersionID: ProductVersionID });
            var strResult1 = AJAXCallWithResult(strPageName + "/CheckProductVersionDuplicates", data, false);
            //alert(EditRequestTypeID);

            if (strResult1.d == "1") {
                strMsg += '<li> Product Version already exists. </li><br>';
                chkVal = 1;
                blnProductVersionInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

            }
        }


        if (strProductVersionCode != "") {
            data = JSON.stringify({ ProductVersion: "", ProductVersionCode: strProductVersionCode, Flag: "ProductVersionCode", ProductVersionID: ProductVersionID });
            var strResult1 = AJAXCallWithResult(strPageName + "/CheckProductVersionDuplicates", data, false);
            //alert(EditRequestTypeID);


            if (strResult1.d == "1") {
                strMsg += '<li> Product Version Code already exists. </li><br>';
                chkVal = 1;
                blnProductVersionCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            }
        }

        //End of Added by Usha Pandit on 25 JAN 2018 for Save Issue

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnProductVersionCodeInValid == true) {
            $("#txtProductVersionCode").focus();
        }
        if (blnProductVersionInValid == true) {
            if ($('#txtProductVersionCode').is(':focus') == true) {

            }
            else {
                $("#txtProductVersion").focus();
            }
        }
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if (disallowMaxlengthViolation(GetObjectReference("", "txtProductVersionDescription"), 2000, '', true)) {
            strMsg += '<li>- Max Length of Description is 2000 characters.\r\nYou have entered ' + GetObjectReference("", "txtProductVersionDescription").value.length + ' characters. </li><br>';
            chkVal = 1;
        }


        if (disallowBlank(GetObjectReference("", "cboPriceUnit"))) {
            strMsg += '<li>- Price Unit should not be left blank. </li><br>';
            chkVal = 1;
            //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            if ($('#txtProductVersionCode').is(':focus') == true || $('#txtProductVersion').is(':focus') == true) {

            }
            else {
                $("#cboPriceUnit").focus();
            }
            //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        if (disallowBlank(GetObjectReference("", "txtListPrice"))) {
            strMsg += '<li>- List Price should not be left blank. </li><br>';
            chkVal = 1;
            //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            if ($('#txtProductVersionCode').is(':focus') == true || $('#txtProductVersion').is(':focus') == true || $('#cboPriceUnit').is(':focus') == true) {

            }
            else {
                $("#txtListPrice").focus();
            }
            //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }

        if (disallowNegativeNumeric(GetObjectReference("", "cboPriceUnit"), '', true)) {
            strMsg += '<li>- Please enter only positive numeric value for List Price </li><br>';
            chkVal = 1;
        }



        if (disallowSpecialCharacters(GetObjectReference("", "txtDiscountPer"))) {
            strMsg += '<li>- A &#39;Discount Percentage cannot contain any of these /\\:*?<>|,"+- characters. </li><br>';
            chkVal = 1;
        }

        if (disallowValueRangeViolation(GetObjectReference("", "txtDiscountPer"), 0, 100)) {
            strMsg += '<li>- The value of Discount Percentage should be in the range of (0-100). </li><br>';
            chkVal = 1;
        }
        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '-');
        if (strMsg != "") {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }

        return chkVal;
    }
    function AddComponent(ProductVersionID) {
        var data;
        var strResult;

        data = JSON.stringify({ ProductVersionID: ProductVersionID })
        strResult = AJAXCallWithResult(strPageName + "/AddComponent", data, false);
        if (strResult.d != null) {
            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Successfully added as component.', 'success');
            }
        }
    }
    function CompetitorEdit_OnClick(ProductCompetitiorId) {
        var data;
        var strResult;

        data = JSON.stringify({ ProductCompetitiorId: ProductCompetitiorId, ProductID: ProductIDGlobal })
        strResult = AJAXCallWithResult(strPageName + "/GetCompetitor", data, false);
        if (strResult.d != null) {
            $("#panelCompetitor").html("");
            $("#panelCompetitor").html(strResult.d);
            $("#accordionCompetitor").css("display", "block");
            RefreshPage();
            $("#cboCompetitor").focus();
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SaveCompetitor(ProductCompetitiorId) {
        var chkVal = 0;
        var strMsg = "";
        var data;
        var strResult;
        var strListPriceCompetitor = "";
        var strCompetitor = "";
        var strcboPriceUnit = "";

        if (disallowBlank(GetObjectReference("", "cboCompetitor"))) {
            strMsg += '<li>- Competitor should not be left blank. </li><br>';
            chkVal = 1;
            $("#cboCompetitor").focus();      //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }


        if (disallowNegativeNumeric(GetObjectReference("", "txtListPriceCompetitor"))) {
            strMsg += '<li>- Please enter only positive numeric value for List Price </li><br>';
            chkVal = 1;
            //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            if ($('#cboCompetitor').is(':focus') == true) {

            }
            else {
                $("#txtListPriceCompetitor").focus();
            }
            //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }

        if (disallowSpecialCharacters(GetObjectReference("", "txtListPriceCompetitor"))) {
            strMsg += '<li>- A List Price cannot contain any of these /\\:*?<>|,"+- characters.</li><br>';
            chkVal = 1;
            //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            if ($('#cboCompetitor').is(':focus') == true) {

            }
            else {
                $("#txtListPriceCompetitor").focus();
            }
            //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        if (disallowBlank(GetObjectReference("", "cboPriceUnit"))) {
            strMsg += '<li>- Price Unit should not be left blank.</li><br>';
            chkVal = 1;
            //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            if ($('#cboCompetitor').is(':focus') == true || $('#txtListPriceCompetitor').is(':focus') == true) {

            }
            else {
                $("#cboPriceUnit").focus();
            }
            //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }

        if (chkVal == 0) {
            strListPriceCompetitor = $("#txtListPriceCompetitor").val();
            strCompetitor = $("#cboCompetitor").val();
            strcboPriceUnit = $("#cboPriceUnit").val();
            data = JSON.stringify({ ProductID: ProductIDGlobal, ProductCompetitiorId: ProductCompetitiorId, ListPriceCompetitor: strListPriceCompetitor, strCompetitor: strCompetitor, strcboPriceUnit: strcboPriceUnit })
            strResult = AJAXCallWithResult(strPageName + "/SaveProductCompetitor", data, false);
            if (strResult.d != null) {
                if (strResult.d == "1") {
                    if (ProductCompetitiorId != 0 || ProductCompetitiorId != "") {
                        alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Updated Successfully.", 'success');
                    }
                    else {
                        alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Data Saved Successfully.", 'success');
                    }
                    RefreshCompetitorGrid(ProductIDGlobal);
                }
            }
        }
        else {
            strMsg = strMsg.substr(0, strMsg.length - 1);
            strMsg = strMsg.replace(/<li>|_/g, '');
            if (strMsg != "") {
                alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strMsg, 'error');
            }
        }

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function DeleteMultiple_Product() {
        var table = $('#divProductMasterGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllProduct').checked == true) {

            $('[name="chkProductDelete"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkProductDelete"]', rows).prop('checked', false);
        }
    }
    function DeleteProduct() {



        var table = $('#divProductMasterGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();


        var strProductIDs = $("[name='chkProductDelete']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strProductIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least one Product for deletion', 'error');
            return;
        }
        data = JSON.stringify({ ProductIDs: strProductIDs });
        strResult = AJAXCallWithResult(strPageName + "/DeleteProduct", data, false);
        if (strResult.d != '') {
            var arrResult = strResult.d.split("##");
            arrResult = arrResult.slice(0, arrResult.length - 1);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('' + arrResult + '', 'success');
            RefreshGrid();
        }


    }

    function SelectAll_ProductVersion() {
        var table = $('#divProductVersionGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllProductVersion').checked == true) {

            $('[name="chkProductVersion"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkProductVersion"]', rows).prop('checked', false);
        }
    }
    function DeleteProductVersion_Onclick(ProductID) {
        var table = $('#divProductVersionGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();


        var strProductVersionIDs = $("[name='chkProductVersion']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strProductVersionIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least one Product version for deletion', 'error');
            return;
        }
        data = JSON.stringify({ ProductVersionIDs: strProductVersionIDs });
        strResult = AJAXCallWithResult(strPageName + "/DeleteProductVersion", data, false);
        if (strResult.d != '') {
            var arrResult = strResult.d.split("##");
            arrResult = arrResult.slice(0, arrResult.length - 1);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('' + arrResult + '', 'success');
            RefreshProductVersionGrid(ProductID);
        }

    }
    function RefreshProductVersionGrid(ProductID) {
        var data;
        var strResult;
        data = JSON.stringify({ ProductID: ProductID })
        strResult = AJAXCallWithResult(strPageName + "/RefreshProductVersionGrid", data, false);
        if (strResult.d != null) {

            $("#divProductVersionGrid").html("");
            $("#divProductVersionGrid").html(strResult.d);
            datatablesSubTag("divProductVersionGrid", "");
        }
    }
    function SelectAll_Competitor() {
        var table = $('#divCompetitorGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllCompetitor').checked == true) {

            $('[name="chkCompetitor"]', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('[name="chkCompetitor"]', rows).prop('checked', false);
        }
    }
    function CompetitorDelete_Onclick(ProductID) {
        var table = $('#divCompetitorGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();


        var strCompetitorIDs = $("[name='chkCompetitor']:checked", rows).map(function () {
            return $(this).val();
        }).get().join(',');


        if (strCompetitorIDs.length <= 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please select at least one Product version for deletion', 'error');
            return;
        }
        data = JSON.stringify({ CompetitorIDs: strCompetitorIDs });
        strResult = AJAXCallWithResult(strPageName + "/DeleteCompetitor", data, false);
        if (strResult.d != '') {
            if (strResult.d == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Competitor deleted successfully', 'success');
            }



            RefreshCompetitorGrid(ProductID);
            $("#accordionCompetitor").css("display", "none");
        }

    }
    function RefreshCompetitorGrid(ProductID) {
        var data;
        var strResult;
        data = JSON.stringify({ ProductID: ProductID })
        strResult = AJAXCallWithResult(strPageName + "/RefreshCompetitorGrid", data, false);
        if (strResult.d != null) {

            $("#divCompetitorGrid").html("");
            $("#divCompetitorGrid").html(strResult.d);
            datatablesSubTag("divCompetitorGrid", "");
        }
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function SelectModuleComponent_Onclick(ProductVersionID) {
        ProductVersionGlobal = ProductVersionID;
        data = JSON.stringify({ ProductVersionID: ProductVersionID })
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




        data = JSON.stringify({ ProductVersionID: ProductVersionGlobal, ProductComponentIDS: strchkComponents })
        strResult = AJAXCallWithResult(strPageName + "/SaveProductComponents", data, false);
        if (strResult.d != null) {
            if (strResult.d == "1") {
                strchkComponents = "";
                //ProductVersion_OnClick(CustomerProductVersionIDGlobal);
                //CustomerProductVersionIDGlobal = "";
                //document.getElementById('idProductComponent').style.display = 'none';
            }
        }

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    }
    function Cancel_ProductVersion() {
        $("#accordionProductVersion").css("display", "none");
        curProductVersionID = 0;     //Added by Usha Pandit on 25 JAN 2018 for Save Issue
    }
    function Cancel_Competitor() {
        $("#accordionCompetitor").css("display", "none");
    }

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

</script>
