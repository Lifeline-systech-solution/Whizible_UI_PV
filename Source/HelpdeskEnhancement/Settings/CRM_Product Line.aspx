<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_Product Line.aspx.vb" Inherits="PbNIT.CRM_Product_Line" %>

<!DOCTYPE html>
<html lang="en">

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head>
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="description" content="" />
    <meta name="author" content="" />
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Product Line")%>--%>
    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
    <meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
    <meta name='vs_defaultClientScript' content='JavaScript'>
    <meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Pragma" content="no-cache">

<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

    <!-- Bootstrap core CSS -->
    <%--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
 <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <%--<link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css"rel="stylesheet" />

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
            float: right!important;
    padding-right: 17px!important;
        }
        .pagination {
         padding-right: 0px!important;
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
            /*float: right !important;*/          /*Commented by Usha Pandit on 24 JAN 2018 for pagination alignment issue*/
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

        #divProductLine .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divProductLine .dataTables_wrapper .dataTables_paginate ul li {
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

        #divProductLine .dataTables_wrapper {
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
            height: 23px;
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



        #divProductLineGrid .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        #divProductLineGrid .dataTables_paginate {
            /*float: right !important;*/            /*Commented by Usha Pandit on 24 JAN 2018 for pagination alignment issue*/
        }

        #divEntityGrid .dataTables_paginate ul {
            margin-top: 2% !important;
            margin-left: -5% !important;
        }

        #divProductLineGrid .dataTables_scrollBody {
            overflow: auto !important;
            width: 101.5% !important;
            /*height: 132px!important;*/
            padding-right: 1.8% !important;
        }

        #divProductLineGrid .dataTables_scroll {
            overflow: hidden !important;
            width: 100% !important;
        }

        #divProductLineGrid table tr th {
            border: 1px solid #ddd !important;
        }

        #ProductFilter {
            padding-bottom: 15px !important;
        }

        .editor textarea, input[type="text"] {
            padding-left: 18px !important;
        }

        #divProductLineGrid .fa-sort {
            display: none !important;
        }

        #ProductFilter {
            margin-top: -3%;
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
          #ShowHistoryGrid .dataTables_scrollBody {

            margin-top:-4%;
        }
            #ShowHistoryGrid .dataTables_scrollBody {
            margin-top:-4%;
            background-color:white!important;
            overflow:auto;
            width:100%;
	    }
             #ShowHistoryGrid table tr th {
           width:130px!important;
           text-align:center!important;
	    }

          #ShowHistoryGrid table tr td {
           width:130px!important;
            text-align:center!important;
	    }

             #ShowHistoryGrid table tr td:nth-child(4) {
          word-break:break-all!important;
	    }

           /*#ShowHistoryGrid .clsTRColumnHeader {
           background-color:#641a02 !important;
           color:white!important;
	    }*/

	    #ShowHistoryGrid .dataTable no-footer {
            width:651px!important;
	    }

	    #ShowHistoryGrid {
	        overflow: auto !Important;
	        
	        padding-right: -1%!important;
	        width: 105%!important;
	        height: 221px!important;
	        padding-right: 2%!important;
	    }

	    #modalbody {
            overflow:hidden!important;
	    }
      
        #divProductLineGrid .dataTables_scrollBody {
            width:100%!important;
        }
          #divProductLineGrid  table tr td:nth-child(2)
        {
               width:40%!important;
             word-break:break-all!important;
            
        }
         #divProductLineGrid  table tr td:nth-child(1)
        {
               width:40%!important;
             word-break:break-all!important;
            
        }
          /*'/*Added by 10 July Kashish for ui change*/
	    .search-bar {
	        margin-left:-7px!important;
	    }
    </style>

<body class="" id="page-top">

    <div id='Type' class='tabcontent1 h-type clsSettingstabs'>

        <div class="content-wrapper" style="margin-left: 0px !important;" id="divScroll">
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
      <div id="idShowHistory" class="modal">

        <form class="modal-content animate" action="/action_page.php">
            <div class="imgcontainer">
                <span class="appro-title">Show History</span>
                <span onclick="document.getElementById('idShowHistory').style.display='none'" class="close" title="Close ">&times;</span>
            </div>
            <div class="container-fluid">
                <div class="form-group" style="margin-top:5px;">
                    <label class="control-label col-sm-2 clslabel" style="margin-top:5px;" for="request type">Modified Field</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedField", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedFieldFilter " & Request.QueryString("MasterTagID"), 150, "", "onchange = ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                    <label class="control-label col-sm-2 clslabel" style="margin-top:5px;" for="request type code">Modified By</label>
                    <div class="col-sm-4">
                        <%=CommonFunctions.HTMLControls.DrawComboBox("cboModifiedBy", "usp_NG2_sel_tbl_PM_AuditTrail_ModifiedByFilter " & Request.QueryString("MasterTagID"), 150, "", "onchange=ModifiedFieldFilter_Change()", True, True, "form-control", False, , , 1).ToString.Replace("'", "")%>
                    </div>

                </div>
                <div class="container-fluid" id="modalbody" style="overflow-y: auto!important;overflow-x:hidden!important; height: 245px;">
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
        RefreshGridDetails();
    });
    $('.modal').draggable();
    var strPageName = "CRM_Product Line.aspx";
    var arrSelectedCheck = new Array();
    var EditProductLineID = "";
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
    function AddProductLine() {
        RefreshGrid();
        $("#divProductLine").css("display", "none");

        $("#ProductFilter").css("display", "none"); //Added by Usha Pandit on 23 JAN 2018 for hiding add delete buttons
    }
    function Cancel_Product() {
        // alert(Flag);

        $("#divProductLine").css("display", "block");
        $("#ProductFilter").css("display", "block");
        EditProductLineID = ''
        /*Added By Dipali v on 21st Nov 2017 For Panel Minimize n Max Issue*/
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto');
            $("#collapseOne2").addClass('in');
            EditProductLineID = "";
        }

    }
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
    function RefreshGrid() {

        var strResult, data;
   
        //alert(Status)

        //data = JSON.stringify({ GridParameter: GridParameter });
        data = JSON.stringify({})

        strResult = AJAXCallWithResult(strPageName + "/RefreshPlotGrid", data, false);
        var DivId;
        var DivSerach;
        //  alert(strResult.d);
        if (strResult.d != '') {

            DivId = "divMain";
            DivSerach = "txtSearchHistory";

            $("#divMain").html("");
            $("#divMain").html(strResult.d);

            $(".table-responsive:first table").addClass("table");
        }
        RefreshGridDetails();
    }
    function RefreshGridDetails() {
        //  debugger;

        var strResult, data;
        var GridParameter = {};
        var DivId;
        var DivSerach;

        DivId = "divProductLineGrid";
        DivSerach = "txtSearchHistory";

        var TypeDiv; var accordion;
        var intDivGridHeight

        if (WhichBrowser() == "IE") {
            intDivGridHeight = (window.innerHeight / 2);

            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                intDivGridListHeight = parseInt(window.innerHeight) - 500;
                // $('#divEntity').css('height', intDivGridListHeight - 140 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }

            else if ((parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024)) {

                intDivGridListHeight = parseInt(window.innerHeight) - 355;
                // $('#divEntity').css('height', intDivGridListHeight - 150 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                intDivGridListHeight = parseInt(window.innerHeight) - 200;
            }
            else {

                intDivGridListHeight = parseInt(window.innerHeight) - 100;

            }
            // $('#divEntity').css('height', intDivGridListHeight - 600 + 'px');
            $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
        }
        else {
            intDivGridHeight = (window.innerHeight / 2);

            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
                //alert(1);
                intDivGridListHeight = parseInt(window.innerHeight) - 370;
                // $('#divEntity').css('height', intDivGridListHeight - 140 + 'px');
                $('#divScroll').css('height', intDivGridListHeight + 290 + 'px');
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
                //alert(2);
                intDivGridListHeight = parseInt(window.innerHeight) - 360;
                // $('#divEntity').css('height', intDivGridListHeight - 140 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                //alert(3);
                intDivGridListHeight = parseInt(window.innerHeight) - 470;
                // $('#divEntity').css('height', intDivGridListHeight - 80 + 'px');

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }
            else {
                //alert(4);
                intDivGridListHeight = parseInt(window.innerHeight) - 570;

                //$('#divEntity').css('height', intDivGridListHeight - 100 + "px");

                $('#divScroll').css('height', intDivGridListHeight + 450 + 'px');
            }



            //    $('#Type').css('height', intDivGridListHeight + 500  + "px");
        }

        //   $(".table-responsive:first table").addClass("table");
        datatables(DivId, DivSerach, intDivGridListHeight);
        //setWidthDatatable(DivId);


        //Added by Usha Pandit on 01 FEB 2018 for pagination alignment
        if (WhichBrowser() == "CR") {
            $(".dataTables_paginate").css("float", "right");
            $(".pagination").css("padding-right", "17px");
        }
        //End of Added by Usha Pandit on 01 FEB 2018 for pagination alignment
    }
    function datatables(divID, txtBoxID) {
        $('#' + divID + ' > table').removeClass("clsGridTable");
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        var table = $('#' + divID + ' > table').DataTable({

            responsive: true, "pageLength": 3,
            scrollY: '120px',
            pagingType: "simple_numbers",
            scrollX: true,
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
    function ProductLine_OnClick(ProductLineID) {


        EditProductLineID = ProductLineID;
        var strResult, data;

        data = JSON.stringify({ ProductLineID: ProductLineID })
        strResult = AJAXCallWithResult(strPageName + "/PlotProductLineDetails", data, false);
        if (strResult.d != '') {
            $("#collapseOne2").html("");
            $("#collapseOne2").html(strResult.d);
        }

        $("#divProductLine").css("display", "none")
        $("#ProductFilter").css("display", "none")
        $("#collapseOne2").css('height', 'auto');
        $("#collapseOne2").addClass('in');
        if ($("#Addaccordion").hasClass("collapsed")) {
            $("#Addaccordion").removeClass("collapsed");
            $("#collapseOne2").css('height', 'auto !important');
            $("#collapseOne2").addClass('in');
        }

    }
    function SaveProductLine() {

        //debugger;
        if (ValidateProduct() == 0) {
            var ProductLineID = EditProductLineID;
            var strProductLineCode;
            var strProductLine
            var strDescription;
            var dataSave;

            strProductLineCode = $("#txtProductLineCode").val();
            strProductLine = $("#txtProductLine").val();
            strDescription = $("#txtDescription").val();

            dataSave = JSON.stringify({ ProdcutLineID: ProductLineID, ProductLineCode: strProductLineCode, ProductLine: strProductLine, Description: strDescription });
            //  alert(data);
            strResult = AJAXCallWithResult(strPageName + "/SaveProductLine", dataSave, false);

            if (strResult.d == "1") {
                alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data saved successfully', 'success');
                RefreshGrid();
           
            }
        }

    }
    function SaveAndProductLine() {
        if (ValidateProduct() == 0) {
            var ProductLineID = EditProductLineID;
            var strProductLineCode;
            var strProductLine
            var strDescription;
            var dataSave;

            strProductLineCode = $("#txtProductLineCode").val();
            strProductLine = $("#txtProductLine").val();
            strDescription = $("#txtDescription").val();

            dataSave = JSON.stringify({ ProdcutLineID: ProductLineID, ProductLineCode: strProductLineCode, ProductLine: strProductLine, Description: strDescription });
            //  alert(data);
            strResult = AJAXCallWithResult(strPageName + "/SaveProductLine", dataSave, false);

            if (strResult.d == "1") {
                alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Data saved successfully', 'success');
                RefreshGrid();
           

                AddProductLine();
            }
        }


    }
    function ValidateProduct() {

        var chkVal = 0;
        var strMsg = "";

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        var blnProductLineInValid = false;
        var blnProductLineCodeInValid = false;
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if (disallowBlank(GetObjectReference("", "txtProductLine"))) {
            strMsg += "<li>- Product Line should not be left blank.</li><br>";
            chkVal = 1;
            blnProductLineInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        else if (disallowSpecialCharacters(GetObjectReference("", "txtProductLine"))) {
            strMsg += '<li>"- A Product Line  cannot contain any of these /\\:*?<>|,"+- characters." </li><br>';
            chkVal = 1;
            blnProductLineInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        if (disallowBlank(GetObjectReference("", "txtProductLineCode"))) {
            strMsg += "<li>- Product Line Code should not be left blank.</li><br>";
            chkVal = 1;
            blnProductLineCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        else if (disallowSpecialCharacters(GetObjectReference("", "txtProductLineCode"))) {
            strMsg += '<li>"- A Product Line Code cannot contain any of these /\\:*?<>|,"+- characters." </li><br>';
            chkVal = 1;
            blnProductLineCodeInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        if (EditProductLineID == "") {
            dataSave = JSON.stringify({ ProductLineCode: $("#txtProductLineCode").val(), ProductLine: $("#txtProductLine").val() });
            //  alert(data);
            strResult = AJAXCallWithResult(strPageName + "/CheckDuplicate", dataSave, false);
            if (strResult.d != null) {
                var arrResult = strResult.d.split("||");
                if (arrResult[0] == "1") {
                    strMsg += "<li>- Product Line already exists. </li><br>";
                    chkVal = 1;
                    blnProductLineInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
                if (arrResult[1] == "1") {
                    strMsg += "<li>- Product Line Code already exists. </li><br>";
                    chkVal = 1;
                    blnProductLineInValid = true; //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
                }
            }
        }

        //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        if (blnProductLineCodeInValid == true) {
            $("#txtProductLineCode").focus();
        }
        if (blnProductLineCodeInValid == true) {
            if ($('#txtProductLineCode').is(':focus') == true) {

            }
            else {
                $("#txtProductLine").focus();
            }
        }
        //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field

        if (disallowMaxlengthViolation(GetObjectReference("", "txtDescription"), 2000)) {
            strMsg += '<li>-Max Length of Description is 2000 characters.\r\nYou have entered '+GetObjectReference("", "txtDescription").value.length+' characters. </li><br>';
            chkVal = 1;

            //Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
            if ($('#txtProductLineCode').is(':focus') == true || $('#txtProductLine').is(':focus') == true) {

            }
            else {
                $("#txtDescription").focus();
            }
            //End of Added by Usha Pandit on 23 JAN 2018 for giving focus to mandatory field
        }
        strMsg = strMsg.substr(0, strMsg.length - 1);
        strMsg = strMsg.replace(/<li>|_/g, '');
        if (strMsg != "") {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strMsg, 'error');
        }

        return chkVal;

    }
    function DeleteMultiple_Product() {
        var table = $('#divProductLineGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();

        if (document.getElementById('chkAllProduct').checked == true) {
            // $("input[name=chkEntityDelete]:not(:disabled)").prop('checked', true);
            $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
        }
        else {
            // $("input[name=chkEntityDelete]").prop('checked', false);
            $('input[type="checkbox"]', rows).prop('checked', false);
        }
    }
    function DeleteProductLine() {

      

        var table = $('#divProductLineGrid table').DataTable();
        var rows = table.rows({ 'search': 'applied' }).nodes();
        var strProductIDs;
        if (document.getElementById('chkAllProduct').checked == true) {
            strProductIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                return this.value;
            }).get().join(',');
        }
        else {
            strProductIDs = arrSelectedCheck.join();
        }
        if (strProductIDs.length <= 0) {
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');         
            alertify.notify('Please select at least one Role for deletion', 'error');  
            return;
        }
        data = JSON.stringify({ ProductIDs: strProductIDs });
        strResult = AJAXCallWithResult(strPageName + "/DeleteProductLine", data, false);
        if (strResult.d != '') {
            var arrResult = strResult.d.split("##");
            arrResult = arrResult.slice(0, arrResult.length - 1);
            alertify.dismissAll(); //Added by Usha Pandit on 23 JAN 2018 for multiple popup issue
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(''+arrResult+'', 'success');
         
        }


    }
    function select_checkbox(obj) {
        if (obj.checked) {
            arrSelectedCheck.push(obj.value);	// record the value of the checkbox to valArray
        } else {
            arrSelectedCheck.pop(obj.value);	// remove the recorded value of the checkbox
        }
    }
    function ShowHistory_OnClick()
    {
        var obj = { "UniqueID": EditProductLineID};
        var myJSON = JSON.stringify(obj);
   

        var result = AJAXCallWithResult(strPageName + "/ShowHistory", myJSON, false)

        $("#idShowHistory #modalbody").html(result.d);
        document.getElementById('idShowHistory').style.display = 'block';
        datatables("ShowHistoryGrid", 'txtSearchHistory');
    }
    function ModifiedFieldFilter_Change(Flag) {


        var ModifiedField = $('#cboModifiedField :selected').text();
        var ModifiedBy = $('#cboModifiedBy :selected').text();

        var obj = { "newModifiedField": ModifiedField, "UniqueID": EditProductLineID, "newModifiedBy": ModifiedBy };
        var myJSON = JSON.stringify(obj);

        var url = strPageName + "/FilteredHistory"
        var result = AJAXCallWithResult(url, myJSON, false)


            $("#idShowHistory #modalbody").html(result.d);

            datatables("ShowHistoryGrid", 'txtSearchHistory');

            document.getElementById('idShowHistory').style.display = 'block';
     
      
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
</html>
