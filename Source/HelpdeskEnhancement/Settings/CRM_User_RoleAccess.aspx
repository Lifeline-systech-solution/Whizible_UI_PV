<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_User_RoleAccess.aspx.vb" Inherits="PbNIT.CRM_User_RoleAccess" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("Role Access")%>
<head runat="server">
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <%--<title>Role Access</title>--%>
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Role Access")%>--%>
    <!-- Bootstrap core CSS -->
     <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <!-- Custom fonts for this template -->
    <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->


    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

    <style>
        /*Commented By Yasmin on 18th july 2018*/
        .ui-tooltip {
	        padding: 4px!important;
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

        .dataTables_wrapper .row:first-child {
            visibility: hidden;
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
        }

        .panel-body {
            OVERFLOW: auto !important;
            /*HEIGHT: 161PX!important;*/
            /*commented By Kashish for ui change*/
            /*width: 106%;*/
            padding-left: 4% !important;
        }

        .pannel-section {
            overflow: auto !important;
            /*height: 454px;*/
            overflow-x: hidden !important;
            width: 101% !important;
            /*padding-right: 9%!important;*/
            /* padding-left: 0%; */
        }

        #cboDepartment {
            height: 29px !important;
        }

        #CboRole {
            height: 29px !important;
        }

        #CboStatus {
            height: 29px !important;
        }

        .h-tabs .bottom-bar .form-group {
            padding: 0px 0 !important;
        }

        .clsGridTable {
            width: 100% !important;
        }

        .clsTRColumnHeader th:nth-child(4) {
            text-align: center;
        }

        .clsTRColumnHeader th:nth-child(5) {
            text-align: center;
        }
        /*.table-responsive table tbody {
        overflow:auto;
        }*/
        #divRole .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }


        .table-responsive {
            overflow: hidden;
        }

        /*#divRole .table-bordered .row:nth-child(1) {
            display:none!important;
        }*/
        #divRole .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        #divRole .dataTables_paginate {
            float: right !important;
        }
        /*Commented by yasmin for pagination alignment on 3rd july 2018*/
        /*#divRole .dataTables_paginate ul {
             margin-top: 2%!important;
             margin-left: -5%!important;
        }*/
        .h-form .form-horizontal .control-label {
            font-weight: 100 !important;
            margin-top: 1% !important;
        }

        .fa-pencil-square-o {
            color: #4caac0 !important;
        }

        #divRole .dataTables_scrollBody {
            overflow: auto !important;
            width: 101% !important;
            padding-right: 2PX;
            padding-right: 1.8% !important;
        }

        #divRole .dataTables_scroll {
            overflow: hidden !important;
            width: 100% !important;
        }

        #divEmployee .dataTables_scrollBody {
            overflow: auto !important;
            width: 100% !important;
            height: 132px !important;
            padding-right: 2% !important;
        }

        #divEmployee .dataTables_scroll {
            overflow: hidden !important;
            width: 100% !important;
        }

        #divEmployee .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divEmployee .dataTables_scrollBody .clsTRColumnHeader {
            display: none !important;
        }

        #divEmployee .dataTables_paginate {
            float: right !important;
        }

            #divEmployee .dataTables_paginate ul {
                margin-top: 1% !important;
                margin-left: -5% !important;
            }

        .h-tabs div#headingOne {
            height: 36px !important;
        }

        #divEmployee .dataTables_paginate {
            float: right !important;
        }

        .form-control {
            font-weight: 100 !important;
        }

        #divRole table tr th:nth-child(3) {
            text-align: center;
        }

        #divRole table tr td:nth-child(3) {
            text-align: center;
        }


        #divRole table tr th {
            border: 1px solid #ddd !important;
        }

        .h-tabs .top-bar {
            padding: 11px 13px 1px 16px !important;
        }

        div.tab {
            margin-left: -2% !important;
        }

        .bottom-bar {
            width: 97% !important;
        }

        .h-tabs .table-responsive {
            border-bottom: 1px solid white !important;
        }

        .panel {
            margin-left: 1.4% !important;
        }

        .h-tabs .bottom-bar .form-group {
            margin-left: -4% !important;
        }

        #CboDepartmentUnitEdit {
            height: 29px !important;
        }

        #CboRoleEdit {
            height: 29px !important;
        }

        #CboReportingTo {
            height: 29px !important;
        }

        #CboEmplyeeType {
            height: 29px !important;
        }

        #BusinessGroupID {
            height: 29px !important;
        }

        #CboOrganizationUnit {
            height: 29px !important;
        }

        .dataTables_info {
            margin-top: 2% !important;
            font-size: 13px !important;
        }

        .right {
            margin-right: 5% !important;
        }


        #CboRoleDepartMent {
            height: 32px !important;
        }

        #CboModule {
            height: 32px !important;
        }

        #Cbolevel {
            height: 32px !important;
        }

        /*.faSettingSearch {
    position: absolute;
    margin-top: 14px;
    margin-left: 10px;
}*/
        .v-tabs .h-tabs div.tab button.tablinks1 {
            width: 11% !important;
        }

        .top-bar {
            padding-top: 0px !important;
        }

        #RoleMaster {
            width: 100%;
            overflow: hidden;
        }

        #divRoleScroll {
            width: 102%;
            padding-right: 2%;
            overflow: auto;
        }
        /*Added by yasmin for pagination alignment on 3rd july 2018*/
        .dataTables_paginate {
            margin-right: 9PX;
            margin-top: -10px;
            float: right;
        }

        .top-bar .right {
            margin-right: 0PX !important;
        }

        #TextCost {
            /*width: 49px !important;*/
            font-weight: 100 !important;
        }

        #DefaultModuleDiv {
            margin-top: 5px !important;
        }
        /*Added by Usha Pandit on 16.12.2017 for alignment */
        #RoleDescription {
            margin-top: 0px !important;
            height: 32px;
        }
        /*End of addition*/
        #divRoleStatus .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            position: relative;
        }

        #divRoleStatus .dataTables_wrapper {
            padding-right: 15px;
            padding-left: 0px;
            margin-right: auto;
            margin-left: auto;
        }

        #divRoleStatus .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divRoleStatus .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #divRoleStatus .clsTRColumnHeader TH:nth-child(2) {
            text-align: center;
        }

        #divList td, #divRoleStatus td {
            border: none !important;
            font-family: "Open Sans",sans-serif !important;
            font-size: 12px !important;
        }

        #Statusheading1 {
            margin-bottom: -40px;
            margin-top: 30px;
        }

        #tblRoleStatus {
            margin-top: 50px;
        }

        .right {
            margin-top: 20px;
        }
        /*#isSaveandAdd{
        float: right;
        margin-top: 5px;
        margin-left: 5px;
        display:block!important;
        background-color:white!important;
        color:white;
    }*/
        #idPlus {
            display: inline-block !important;
        }
        /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
            color: #bbb !important;
        }


        .container-fluid {
            min-height: auto !important;
        }
    </style>

    <body class="" id="page-top">

        <input type="hidden" id="hdnMode" name="hdnMode" value="" />
        <input type="hidden" id="hdnEmployeeID" name="hdnEmployeeID" value="" />
        <input type="hidden" id="hdnRoleID" name="hdnRoleID" value="" />
        <input type="hidden" id="hdnLoadFilterID" name="hdnLoadFilterID" value="" />
        <% WriteTabsControls("", "Load", "")%>
    </body>
    <!-- ----- Request Type inherit status flow button popup---------------------------->


    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>


    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>


    <%--<script src="js/editor.js"></script>--%>
    <script src="../../../EnhancementFiles/js/editor.js"></script>



    <!-- Time picker -->
    <%--<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>--%>
    <script src="../../../EnhancementFiles/js/timepicker.js"></script>
    <script src="../../../EnhancementFiles/js/timepicker.min.js"></script>

    <%--<script src="../../General/CommonFunctions.js"></script>
	<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <!-- Time picker -->
    <script src="js/timepicker.min.js"></script>
    <script src="js/timepicker.js"></script>
    <script>
        $(function () {
            //$('#Bdate').timepicker();
            //$('#DateIssue').timepicker();

            //$('#ExDate').timepicker();
        });
    </script>

    <!-- End of time picker -->
    <script>
        $(function () {

            $('#Bdate').datepicker();
            $('#DateIssue').datepicker();
            $('#ExDate').datepicker();
            $('#JoiningDate').datepicker();

        });
        /*Added By Yasmin on 25th july 2018*/

       
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
        //$(document).click(function () {
        //    $(this).tooltip("close");
        //});
     
       
    </script>


    <script>

        $(document).click(function () {
            //alert(window.parent.parent.parent.location);
            $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
            $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

        })
        $(document).ready(function () {

            //$("#txtEditor").Editor();
            //$("#txtEditor1").Editor();
            //$("#txtEditor2").Editor();
            //$("#txtEditor3").Editor();
            $('[data-toggle="tooltip"]').tooltip();
        });



        var globalCityName, globalEmployeeID, globalRoleID, intDivGridListHeight;
        $(document).ready(function () {

            datatables("divEmployee", 'SearchRquestType');
            //setWidthEmployee();
            $('[data-toggle="tooltip"]').tooltip();
            $('.fa').tooltip();

            $(".dataTables_scrollHeadInner").each(function () {
                // $(this).css("width", dtwidth);
            });
            RefreshPagePlot();
        });


        // document.getElementById('hdnEmployeeID').value = "0"
        function openCity(evt, cityName) {
            var i, tabcontent3, tablinks3;
            globalCityName = cityName;
            tabcontent3 = document.getElementsByClassName("tabcontent3");
            for (i = 0; i < tabcontent3.length; i++) {
                tabcontent3[i].style.display = "none";
            }
            tablinks3 = document.getElementsByClassName("tablinks3");
            for (i = 0; i < tablinks3.length; i++) {
                tablinks3[i].className = tablinks3[i].className.replace(" active", "");
            }

            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.className += " active";
            PlotGridControls(cityName);

        }
        // Get the element with id="defaultOpen" and click on it
        //document.getElementById("defaultOpen3").click();


        //function Page_OnClick(PageNumber) {
        //    var strMode = $("#hdnMode").val();
        //  //  RefreshGrid(globalCityName);
        //}
        //function PreviousePage(PageNumber) {

        //    if (PageNumber < 1 ) {
        //        //alert("You are on the First page");
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.notify('You are on the First page!', 'success');
        //    }
        //    else {
        //        $("#hdnCurrentPage").val(PageNumber);
        //        Page_OnClick(PageNumber);
        //    }
        //}
        //function NextPage(PageNumber) {
        //    debugger;
        //    var TotalNoOfPages = $("#hidNoOfPages").val();

        //    alert(TotalNoOfPages);
        //    if (PageNumber > TotalNoOfPages) {
        //        //alert("You are on the last page");
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.notify('You are on the last page!', 'success');
        //    }
        //    else {
        //        $("#hdnCurrentPage").val(PageNumber);
        //        Page_OnClick(PageNumber);
        //    }
        //}
        //function FirstPage(PageNumber) {	       
        //    var TotalNoOfPages = $("#hidNoOfPages").val();


        //    if (PageNumber == $("#hdnCurrentPage").val()) {
        //        //alert("You are on the First page");
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.notify('You are on the First page!', 'success');
        //    }
        //    else {
        //        $("#hdnCurrentPage").val(PageNumber);
        //        Page_OnClick(PageNumber);
        //    }
        //}
        //function LastPage(PageNumber) {
        //    var TotalNoOfPages = $("#hidNoOfPages").val();	      

        //    if (TotalNoOfPages == $("#hdnCurrentPage").val()) {
        //        //alert("You are on the last page");
        //        alertify.set('notifier', 'position', 'top-right');
        //        alertify.notify('You are on the last page!', 'success');
        //    }
        //    else {
        //        $("#hdnCurrentPage").val(PageNumber);
        //        Page_OnClick(PageNumber);
        //    }
        //}




        //function RefreshGrid(cityName) {
        //    var strResult, data;
        //    var GridParameter = {};


        //    GridParameter.cityName = cityName;

        //    data = JSON.stringify({ GridParameter: GridParameter, Department: "", Role : "", Status:"" });

        //    strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);

        //    if (strResult.d != '')
        //    {
        //        if (String(cityName).toUpperCase() != "AUTOCLOSE")
        //        {
        //            $("#" + cityName + " .table-responsive:first").html(strResult.d);

        //            $("#" + cityName + " .table-responsive:first table").addClass("table");
        //        }
        //    }

        //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

        //        intDivGridListHeight = parseInt(window.innerHeight) - 360;
        //        alert(intDivGridListHeight);
        //    }
        //    else {
        //        //  intDivGridListHeight = (window.innerHeight / 3) + 6;
        //        intDivGridListHeight = parseInt(window.innerHeight) - 360;
        //        alert(intDivGridListHeight);
        //    }

        //    // $(".table-responsive tbody").css("overflow", "auto");
        //    $(".table-responsive").css("height", intDivGridListHeight + "px");
        //    $(".pannel-section").css("height", intDivGridListHeight + "px");


        //    datatables("divEmployee", 'SearchRquestType');
        //    datatables("divRole", 'SearchRole');
        //    setWidthEmployee();

        //    //$("#divRole .panel-body").each(function () {
        //    //    $(this).css("height", "161px");
        //    //});

        //    //$("#divEmployee .panel-body").each(function () {
        //    //    $(this).css("height", "161px");
        //    //});
        //}

        var strPageName = "CRM_User_RoleAccess.aspx";
        var arrSelectedCheck = new Array();
        function RefreshGrid(cityName) {
            // debugger;
            var strResult, data;
            var GridParameter = {};

            GridParameter.cityName = "RoleMaster";

            data = JSON.stringify({ GridParameter: GridParameter, Department: "", Role: "", Status: "" });
            // alert(data);
            strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);
            var DivId;
            // alert(strResult);
            var DivSerach;
            //alert(strResult.d);

            DivId = "divRole";
            DivSerach = "SearchRole";

            $("#" + cityName + " .table-responsive:first").html(strResult.d);

            $("#" + cityName + " .table-responsive:first table").addClass("table");
            RefreshPagePlot();

        }
        function RefreshPagePlot() {
            // debugger;
            var strResult, data;
            var GridParameter = {};

            DivId = "divRole";
            DivSerach = "SearchRole";

            var TypeDiv; var accordion;

            var intDivGridHeight

            //if (WhichBrowser() == "IE") {
            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
            //        //alert(1);
            //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
            //        $('#divRoleScroll').css('height', intDivGridListHeight + "px");
            //        //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
            //        $('#' + DivId).css('height', intDivGridListHeight - 200 + "px");
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //        //alert(2);
            //        intDivGridListHeight = parseInt(window.innerHeight) - 400;
            //        // alert(intDivGridListHeight);
            //        $('#divRoleScroll').css('height', intDivGridListHeight + 130 + "px");
            //        //  alert(intDivGridListHeight);
            //        $('#' + DivId).css('height', intDivGridListHeight - 150 + "px");
            //    }
            //    else {
            //        //alert(3);
            //        intDivGridListHeight = parseInt(window.innerHeight) - 530;
            //        //alert(intDivGridListHeight - 200);
            //        $('#divRoleScroll').css('height', intDivGridListHeight + 200 + "px");
            //        //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
            //        //alert(intDivGridListHeight - 200);
            //        $('#' + DivId).css('height', intDivGridListHeight - 200 + "px");
            //    }
            //    //  alert(intDivGridListHeight);

            //}
            //else {
            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {

            //        intDivGridListHeight = parseInt(window.innerHeight) - 290;

            //        $('#divRoleScroll').css('height', intDivGridListHeight + 330 + "px");
            //        //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);

            //        $('#' + DivId).css('height', intDivGridListHeight - 150 + "px!important");
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //        //alert(27);
            //        intDivGridListHeight = parseInt(window.innerHeight) - 400;
            //        $('#divRoleScroll').css('height', intDivGridListHeight + 130 + "px");
            //        //  alert(intDivGridListHeight);
            //        $('#' + DivId).css('height', intDivGridListHeight - 150 + "px");
            //    }
            //    else {
            //        //alert(24);
            //        intDivGridListHeight = parseInt(window.innerHeight) - 530;
            //        $('#divRoleScroll').css('height', intDivGridListHeight + 200 + "px");
            //        //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
            //        //alert(intDivGridListHeight);
            //        $('#' + DivId).css('height', intDivGridListHeight - 250 + "px");
            //    }


            //}
            var intDivGridHeight, intDivGridListHeight
            intDivGridListHeight = parseInt(window.innerHeight);
            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {

                $("#divRoleScroll").css('height', intDivGridListHeight - 280 + "px");
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {

                $("#divRoleScroll").css('height', intDivGridListHeight - 320 + "px");
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

                $("#divRoleScroll").css('height', intDivGridListHeight - 280 + "px");
            }
            else {
                $("#divRoleScroll").css('height', intDivGridListHeight - 280 + "px");
            }




            datatables(DivId, DivSerach);

        }
        function PlotGridControls(cityName) {
            // debugger;
            var strResult, data;
            var GridParameter = {};

            GridParameter.cityName = "RoleMaster";
            DivId = "divRole";
            DivSerach = "SearchRole";
            data = JSON.stringify({ GridParameter: GridParameter, Department: "", Role: "", Status: "" });
            // alert(data);
            strResult = AJAXCallWithResult(strPageName + "/RefreshPlotControls", data, false);
            var DivId;
            // alert(strResult);
            var DivSerach;

            $("#" + cityName).html(strResult.d);

            RefreshPagePlot();
        }
        var table;
        function datatables(divID, txtBoxID) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            table = $('#' + divID + ' > table').DataTable({

                responsive: true, "pageLength": 3,
                //scrollY: '116px',
                pagingType: "simple_numbers",
                scrollX: true,
                language: {
                    //paginate: {
                    //    first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
                    //    next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
                    //    previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
                    //    last: '<i class="fa fa-angle-right" title="Last"></i>'
                    //}
                },
            });
            // debugger;
            if (txtBoxID != "") {
                $('#' + txtBoxID).on('keyup change', function () {
                    table.search($(this).val()).draw();
                })
            }
        }

        function datatablesNew(divID, txtBoxID, height) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' > table').DataTable({
                scrollX: true,
                "paging": false,
                "bInfo": false,
            });
        }
        function MapRoleStatus(obj, RoleStatusID, RoleID) {
            var strChecked;
            if (obj.checked == true) {
                strChecked = 1;
            }
            else {
                strChecked = 0;
            }

            data = JSON.stringify({ RoleID: RoleID, RoleStatusID: RoleStatusID, Checked: strChecked });
            strResult = AJAXCallWithResult("CRM_User_RoleAccess.aspx/MapRoleStatus", data, false);
            if (strResult.d != "") {

                if (strResult.d == '1') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Role Status mapped successfully', 'success');
                }
                if (strResult.d == '0') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Role Status unmapped successfully', 'success');
                }
                var strResult1, data1;

                data1 = JSON.stringify({ RequestTypeID: RequestTypeID });
                strResult1 = AJAXCallWithResult(strPageName + "/PlotRoleStatus", data1, false);

                if (strResult1.d != '') {
                    $("#divRoleStatus").html(strResult1.d);
                    $("#divRoleStatus").addClass("table");
                    $("#divRoleStatus").css("display", "block");

                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                        intDivGridListHeight = parseInt(window.innerHeight) - 350;
                    }
                    else {
                        intDivGridListHeight = parseInt(window.innerHeight) - 500;
                    }
                    datatables("divRoleStatus", "", intDivGridListHeight);
                }

            }

        }
        function SelectRoleAll_Checkbox(obj) {
            // $("input[name=chkchkRoleMasterSelect]").prop('checked', true);

            var table = $('#divRole table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            if ($(obj).is(':checked'))
                //  $("input[name=chkchkRoleMasterSelect]").prop('checked', true);
                // $("input[name=chkchkRoleMasterSelect]:not(:disabled)").prop('checked', true);
                $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
            else
                //$("input[name=chkchkRoleMasterSelect]").prop('checked', false);
                $('input[type="checkbox"]', rows).prop('checked', false);
        }


        function SelectAll_Checkbox(obj) {
            if ($(obj).is(':checked'))
                // $("input[name=chkUserMasterSelect]").prop('checked', true);
                $("input[name=chkUserMasterSelect]:not(:disabled)").prop('checked', true);
            else
                $("input[name=chkUserMasterSelect]").prop('checked', false);

        }

        function Role_OnClick(ROLEID) {
            //alert(ROLEID);
            globalRoleID = ROLEID;
            document.getElementById('hdnRoleID').value = globalRoleID;
            data = JSON.stringify({ RoleID: ROLEID });
            strResult = AJAXCallWithResult("CRM_User_RoleAccess.aspx/GetRoleDetails", data, false);

            if (strResult.d != "") {
                var arrResult = strResult.d.split("#$#");

                //  alert(strResult.d);

                $("#RoleDescription").val(arrResult[0]);
                $("#Cbolevel").val(arrResult[2]);
                $("#CboModule").val(arrResult[1]);


                if (arrResult[3] == "True") {

                    $("#GenerateInvoice").prop('checked', true);

                }
                else {

                    $("#GenerateInvoice").prop('checked', false);
                }


                if (arrResult[4] == "True") {

                    $("#SalesActivity").prop('checked', true);

                }
                else {

                    $("#SalesActivity").prop('checked', false);
                }

                if (arrResult[5] == "True") {

                    $("#CheckAssignment").prop('checked', true);

                }
                else {

                    $("#CheckAssignment").prop('checked', false);
                }

                $('#textBillingRate').val(arrResult[6]);
                $('#TextCost').val(arrResult[7]);
                $('#CboRoleDepartMent').val(arrResult[8]);

                $("#collapseOne2").addClass('in');
                $("#collapseOne2").css("overflow", "hidden");
                $("#collapseOne2").css("height", "auto");
                // AddRole();
                $("#RoleButton").css("display", "none");
                $("#tblrole").css("display", "none");
                $("#tblEmployee").css("display", "none");

                if ($("#Addaccordion").hasClass("collapsed")) {
                    $("#Addaccordion").removeClass("collapsed");
                    $("#collapseOne2").addClass('height', 'auto !important');
                }
                //Added By Aniruddh Gujar on 18-Dec-2017 Purpose::To plot the subtag
                var strResult1, data1;
                data1 = JSON.stringify({ RoleID: ROLEID });

                strResult1 = AJAXCallWithResult(strPageName + "/PlotRoleStatus", data1, false);

                if (strResult1.d != '') {
                    document.getElementById('tblRoleStatus').innerHTML = "";
                    document.getElementById('tblRoleStatus').innerHTML = strResult1.d;
                    $("#divRoleStatus").addClass("clsTable");
                    $("#divRoleStatus").addClass("table");
                    $("#divRoleStatus").addClass("dataTable");
                    $("#divRoleStatus").addClass("table-bordered table-stripped dataTable no-footer");

                    $("#divRoleStatus").css("display", "block");
                    $("#Statusheading1").css("display", "block");
                    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                        intDivGridListHeight = parseInt(window.innerHeight) - 250;
                    }
                    else {
                        intDivGridListHeight = parseInt(window.innerHeight) - 600;
                    }

                    //datatablesNew("divRoleStatus", "", intDivGridListHeight);
                    $("#tblEmployee").css("display", "none");

                    $("#collapseOne").css("width", "100%");
                    $("#collapseOne").css("overflow", "hidden");

                    if ($("#AddSubtagaccordion").hasClass("collapsed")) {
                        $("#AddSubtagaccordion").removeClass("collapsed");
                        $("#collapseOne2").addClass('height', 'auto !important');
                    }
                }

                //End of Added By Aniruddh Gujar on 18-Dec-2017 Purpose::To plot the subtag
            }
        }

        function AddRole() {


            $("#RoleButton").css("display", "none");
            $("#tblrole").css("display", "none");
            $("#tblEmployee").css("display", "none");

            // document.getElementById("#divRole.panel-body").style.setProperty("height", "450px", "!important");
            $("#collapseOne2").addClass('in');
            $("#collapseOne2").css("overflow", "hidden");
            $("#collapseOne2").css("height", "auto");
            // document.getElementsByClassName('.bottom-bar')
            $(".bottom-bar").css("margin-top", "1%")

            // $("#divRole .panel-body").css("height", "450px")
            $("#divRole .panel-body").each(function () {
                $(this).css("height", "450px");
            });

            $("#RoleDescription").val("");
            $("#Cbolevel").val("");
            $("#CboModule").val("");
            $('#textBillingRate').val("");
            $('#TextCost').val("");
            $('#CboRoleDepartMent').val("");

            $('#TextCost').val("");
            $('#CboRoleDepartMent').val("");
            $("#GenerateInvoice").prop('checked', false);
            $("#SalesActivity").prop('checked', false);
            $("#CheckAssignment").prop('checked', false);
            if ($("#Addaccordion").hasClass("collapsed")) {
                $("#Addaccordion").removeClass("collapsed");
                $("#collapseOne2").addClass('height', 'auto !important');
            }
        }


        var RoleID;
        function SaveRole(Flag) {
            //debugger;
            if (ValidateRole() == 0) {

                // alert(ValidateRole());
                // debugger;

                if (document.getElementById('hdnRoleID').value == '') {
                    RoleID = 0;

                }
                else {

                    RoleID = globalRoleID;

                }

                var RoleDescription = $("#RoleDescription").val();
                var Module = $("#CboModule").val();
                var level = $("#Cbolevel").val();
                //var textBillingRate = $('#textBillingRate').val();
                //var TextCost = $('#TextCost').val();
                var CboRoleDepartMent = $('#CboRoleDepartMent').val();
                var GenerateInvoicevalue, SalesActivityvalue, CheckAssignmentvalue;
                //var GenerateInvoice = document.getElementById('GenerateInvoice');
                //if (GenerateInvoice.checked == true) {
                //    // alert(GenerateInvoice.checked);
                //    GenerateInvoicevalue = 1;

                //}
                //else {

                //    GenerateInvoicevalue = 0;
                //}
                //var SalesActivity = document.getElementById('SalesActivity');

                //if (SalesActivity.checked == true) {

                //    SalesActivityvalue = 1;

                //}
                //else {

                //    SalesActivityvalue = 0;
                //}

                //var CheckAssignment = document.getElementById('CheckAssignment');
                //if (CheckAssignment.checked == true) {

                //    CheckAssignmentvalue = 1;

                //}
                //else {

                //    CheckAssignmentvalue = 0;
                //}


                // alert(Flag);
                data = JSON.stringify({ RoleDescription: RoleDescription, ModuleValue: Module, level: level, textBillingRate: 0, TextCost: 0, CboRoleDepartMent: CboRoleDepartMent, GenerateInvoicevalue: 0, SalesActivityvalue: 0, CheckAssignmentvalue: 0, RoleID: RoleID });
                //  alert(data);
                strResult = AJAXCallWithResult("CRM_User_RoleAccess.aspx/SaveRoleDescription", data, false);

                if (strResult.d != "") {


                    // alert(strResult.d);
                    alertify.set('notifier', 'position', 'top-right');
                    if (RoleID == 0) {
                        alertify.notify('Role created successfully', 'success');
                    }
                    else {
                        alertify.notify('Role updated successfully', 'success');
                    }
                    // $("#collapseOne2").removeClass('in');

                    //$("#divRole").css("display", "block");

                    if (Flag == 'AddSave') {

                        $("#RoleDescription").val("");
                        $("#Cbolevel").val("");
                        $("#CboModule").val("");
                        $('#textBillingRate').val("");
                        $('#TextCost').val("");
                        $('#CboRoleDepartMent').val("");

                        $('#TextCost').val("");
                        $('#CboRoleDepartMent').val("");
                        $("#GenerateInvoice").prop('checked', false);
                        $("#SalesActivity").prop('checked', false);
                        $("#CheckAssignment").prop('checked', false);
                        $("#divRoleStatus").css("display", "none");
                        $("#Statusheading1").css("display", "none");
                        RefreshGrid('RoleMaster');
                        RefreshPagePlot();
                    }
                    else {
                        $("#RoleButton").css("display", "");
                        $("#tblrole").css("display", "");
                        $("#tblEmployee").css("display", "");
                        RefreshGrid('RoleMaster');
                        RefreshPagePlot();
                    }

                }


            }

        }



        function ValidateRole() {
            //debugger;
            var checkvalue = 0;
            var Flag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"

            var RoleDescription = document.getElementById('RoleDescription');
            var CboModule = document.getElementById('CboModule');
            var Cbolevel = document.getElementById('Cbolevel');
            //var textBillingRate = document.getElementById('textBillingRate');
            //var TextCost = document.getElementById('TextCost');
            var CboRoleDepartMent = document.getElementById('CboRoleDepartMent');



            if ($("#RoleDescription").val() == "") {
                //  alertify.set('notifier', 'position', 'top-right');
                strmsg = '- Role Description should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('Employee Code Already Exists', 'error');
                checkvalue = 1;
                //  alertify.notify('Please Select  Role Description', 'error');
                Flag = 1;
                // checkvalue = 1;
            }



            if ($("#RoleDescription").val() != "") {
                //if (disallowSpecialCharacters(RoleDescription)) {
                //    strMsg = '- Role Description contain any of these /\\:*?<>|,"+- characters.'
                //    errorMsg += "<li>" + strmsg + "</li>";
                //    checkvalue = 1;
                //    Flag = 1;
                //}

                if (document.getElementById('hdnRoleID').value == '') {
                    RoleID = 0;

                }
                else {

                    RoleID = globalRoleID;
                    // alert(RoleID);
                }

                var url = 'CRM_User_RoleAccess.aspx/CheckRoleDescription';
                var data = JSON.stringify({ RoleDescription: $('#RoleDescription').val(), RoleID: RoleID });

                $.ajax({
                    type: "POST",
                    url: url,
                    data: data,
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    timeout: 180000,
                    success: function (result) {
                        if (result.d == 1) {
                            checkValu = 1;
                            if (checkValu == 1) {

                                strmsg = '- Role Description  Already Exists';
                                errorMsg += "<li>" + strmsg + "</li>";
                                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                                checkvalue = 1;
                            }
                        }
                    },
                    //error: function (xhr, status, error) {
                    //    console.log(xhr.responseText);
                    //    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                    //}
                });



                //Commented by Usha Pandit on 16.12.2017 for RoleDescription should accept special chars
                //if (checkSpecialCharacter($('#RoleDescription').val()) == true) {
                //   // alertify.set('notifier', 'position', 'top-right');
                //   strmsg = '- A Role Description cannot contain any of these /\\:*?<>|,"+- Characters';
                //   errorMsg += "<li>" + strmsg + "</li>";
                //   //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                //   checkvalue = 1;

                //}
                //End of comment
            }



            if ($("#Cbolevel").val() == "") {

                alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Level should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                //alertify.notify('Please Select  Level', 'error');
                checkvalue = 1;
            }


            //if ($("#textBillingRate").val() == "") {
            //    //alertify.set('notifier', 'position', 'top-right');
            //    strmsg = ' - Standard Billing Rate should not be left blank';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    // alertify.notify('Please Enter Standard Billing Rate', 'error');
            //    checkvalue = 1;
            //}



            //// if (checkvalue == 0) {
            //if ($("#textBillingRate").val() != "") {


            //    if (checkSpecialCharacter($('#textBillingRate').val()) == true) {
            //        //alertify.set('notifier', 'position', 'top-right');
            //        strmsg = ' - A  Standard Billing Rate cannot contain any of these /\\:*?<>|,"+- Characters';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        //alertify.notify('A  Standard Billing Rate cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //        checkvalue = 1;

            //    }

            //    else if (RestrictNonNumeric(document.getElementById('textBillingRate')) == true) {
            //        // alertify.set('notifier', 'position', 'top-right');
            //        strmsg = ' - Please Enter only positive numeric value for Standard Billing Rate numeric values.';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        //alertify.notify('', 'error');
            //        checkvalue = 1;

            //    }
            //}


            //if ($("#TextCost").val() == "") {
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = ' - Cost($) should not be left blank.';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    // alertify.notify('Please Enter Cost', 'error');
            //    checkvalue = 1;
            //}




            //if ($("#TextCost").val() != "") {

            //    if (checkSpecialCharacter($('#TextCost').val()) == true) {
            //        // alertify.set('notifier', 'position', 'top-right');
            //        // alertify.notify('A  Cost cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //        strmsg = ' - A  Cost cannot contain any of these /\\:*?<>|,"+- Characters';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        checkvalue = 1;

            //    }

            //    else if (RestrictNonNumeric(document.getElementById('TextCost')) == true) {
            //        // alertify.set('notifier', 'position', 'top-right');
            //        //alertify.notify('Please Enter only positive numeric value for Cost numeric values !!!', 'error');
            //        strmsg = ' - Please Enter only positive numeric value for Cost numeric values.';
            //        errorMsg += "<li>" + strmsg + "</li>";
            //        checkvalue = 1;

            //    }



            //}



            if ($("#CboModule").val() == "") {
                //  alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Default Module should not be left blank.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

            }


            if ($("#CboRoleDepartMent").val() == "") {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Department/Unit should not be left blank.';
                errorMsg += "<li>" + strmsg + "</li>";

                checkvalue = 1;
            }

            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 15);

            }

            return checkvalue;
        }


        function AddSaveRole(Flag) {


            if (ValidateRole() == 0) {

                SaveRole(Flag);
                RefreshPagePlot();
            }


        }

        function RoleListCheckBox_OnClick() {



        }


        function CancelRole() {

            $("#RoleDescription").val("");
            $("#Cbolevel").val("");
            $("#CboModule").val("");
            $('#textBillingRate').val("");
            $('#TextCost').val("");
            $('#CboRoleDepartMent').val("");

            $('#TextCost').val("");
            $('#CboRoleDepartMent').val("");
            $("#GenerateInvoice").prop('checked', false);
            $("#SalesActivity").prop('checked', false);
            $("#CheckAssignment").prop('checked', false);

            // $("#collapseOne2").removeClass('in');
            $("#RoleButton").css("display", "");
            $("#tblrole").css("display", "");
            $("#tblEmployee").css("display", "");
            $("#divRoleStatus").css("display", "none");
            $("#Statusheading1").css("display", "none");

            RefreshGrid('RoleMaster');
            RefreshPagePlot();


        }

        function checkSpecialCharacter(value) {
            var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
            var isSpecialCharacter = 0;
            for (var i = 0; i < regularExpression.length; i++) {
                if (value.indexOf(regularExpression[i]) != -1) {
                    isSpecialCharacter = 1
                }
            }
            if (isSpecialCharacter == 1) {
                return true;
            }
            else {
                return false;
            }
        }
        function RestrictNonNumeric(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }

            var dofocus = (arguments.length > 1) ? arguments[1] : true;
            if (!isNumeric(getInputValue(obj))) {
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }



        function DeleteRole() {

            //strRoleIDs = arrSelectedCheck.join();

            var table = $('#divRole table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            if (document.getElementById('chkRoleSelect').checked == true) {
                strRoleIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
                    return this.value;
                }).get().join(',');
            }
            else {
                strRoleIDs = arrSelectedCheck.join();
            }
            if (strRoleIDs.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');         //added by Usha Pandit on 18.12.2017
                alertify.notify('Please select at least one Role for deletion', 'error');  //added by Usha Pandit on 18.12.2017
                return;
            }
            data = JSON.stringify({ RoleIDs: strRoleIDs });
            strResult = AJAXCallWithResult(strPageName + "/DeleteRole", data, false);
            if (strResult.d != "") {


                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify(strResult.d, 'error');

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Role Deleted Succssfully", 'success');
                RefreshGrid('RoleMaster');
                CancelRole();
            }


        }

        var AjaxResult;
        function AJAXCallWithResult(url, data, async) {
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
                    //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }

        function DepartMentFilter_OnChange(Object) {

            var strResult, data;
            var GridParameter = {};
            var Department = $("#cboDepartment").val();
            var Role = $("#CboRole").val();

            if (Department == "0" || Department == "") {
                Department = ""
            }

            if (Role == "0" || Role == "") {
                Role = ""
            }
            // debugger;
            var Status = $("#CboStatus").val();
            //   alert(Status)
            if (Status == -1) {
                Status = "";
            }
            if (Status == "Active") {
                Status = 1;
            }
            else {
                Status = 0;
            }
            GridParameter.cityName = globalCityName;
            //alert(Role);
            //alert(Status);
            // var getvalue = Object.val();

            // alert(getvalue)
            data = JSON.stringify({ GridParameter: GridParameter, Department: Department, Role: Role, Status: Status });
            //  alert(data);
            strResult = AJAXCallWithResult("CRM_User_RoleAccess.aspx/RefreshGrid", data, false);

            if (strResult.d != "") {
                $("#divEmployee").html(strResult.d);
                datatables("divEmployee", 'SearchRquestType');
                setWidthEmployee();
                //RefreshGrid(globalCityName);
                //var arrResult = strResult.d;
            }
        }

        function setWidthEmployee() {
            var tblTotal = document.getElementById("divEmployee").getElementsByClassName('dataTable')[0];
            var tblDetails = document.getElementById("divEmployee").getElementsByClassName('dataTable')[1];
            //if (WhichBrowser() != 'FF') {
            if (tblDetails != null) {
                tblTotal.style.width = tblDetails.offsetWidth + 'px';
                width = tblDetails.offsetWidth + 'px';
            }
            // }
            var FooterTableRow = tblTotal.rows[0];
            var HeaderRow = tblDetails.rows[0];
            for (var i = 0; i < tblTotal.rows[0].cells.length; i++) {
                if (FooterTableRow.cells[i] != null)
                    if (HeaderRow.cells[i] != null) {
                        FooterTableRow.cells[i].style.width = HeaderRow.cells[i].offsetWidth + 'px';
                    }
            }


        }

        var BusinessGroupID, TypeID;
        function BusinessGroup_Change(obj) {

            var url = "CRM_User_RoleAccess.aspx/GetOU"
            BusinessGroupID = obj.value;
            //alert(BusinessGroupID);
            data = JSON.stringify({ TypeID: BusinessGroupID });
            CustomAJAXCall(url, data, BindDropdownOU);
        }


        function BindDropdownOU(result) {

            //alert(result.d);
            var strArray = String(result.d).split("|")
            var objCbo = document.getElementById("CboOrganizationUnit");
            var i = 0;
            objCbo.innerHTML = "";
            // alert(strArray[0])

            insBlankOpt(objCbo);

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.Location
                objOption.value = obj.OUPoolID;;

            });
        }

        function insBlankOpt(objCbo) {
            objOption = new Option();

            objOption.text = "";
            objOption.value = "";

            if (WhichBrowser() == 'IE')
                objCbo.add(objOption);
            else
                objCbo.add(objOption, null);
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
                    //  Stop();
                },
                error: function (xhr, status, error) {
                    // Stop();
                    //  StopAjaxLoader("body");
                    console.log(xhr.responseText);
                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

        }

        //Added by Yogesh Jalamkar on 20-dec-2017 Purpose Issue id = 9877
        function select_checkbox(obj) {
            if (obj.checked) {
                arrSelectedCheck.push(obj.value);	// record the value of the checkbox to valArray
            } else {
                arrSelectedCheck.pop(obj.value);	// remove the recorded value of the checkbox
            }
        }
        //End by Yogesh jalamkar Purpose Issue id = 9877


      </script>

</head>

</html>

