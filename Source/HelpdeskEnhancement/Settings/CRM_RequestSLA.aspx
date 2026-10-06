<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RequestSLA.aspx.vb" Inherits="PbNIT.CRM_RequestSLA" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head id="Head1" runat="server">

    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <%--<title>Admin Panel</title>--%>
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("SLA Details")%>--%>
    
    <%--<link href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" rel="stylesheet" />--%>
    
    <!-- Custom fonts for this template -->
   <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />--%>
    <!-- Custom styles for this template -->

    <!-- Plugin CSS -->    
    <link href="../../../Whizible2.0-new/dist/css/editor.css" rel="stylesheet" />
    
    <link href="../../../Whizible2.0-new/dist/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../Whizible2.0-new/dist/css/setting.css" rel="stylesheet" />
    <link href="../../../Whizible2.0-new/dist/css/sb-admin.css" rel="stylesheet" />
    <%--<link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" />--%>
    <link href="../../../Whizible2.0-new/dist/css/timepicker.min.css" rel="stylesheet" />
    <link href="../../../Whizible2.0-new/dist/css/style.css" rel="stylesheet" />
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
</head>

    <style>
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
            /*HEIGHT: 246PX;*/
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

        .table-responsive .fas {
            font-size: 15px;
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

        /*.bottom-bar {
            margin-top: -16px;
        }*/

        #divSubRequestType .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }

        #divSubRequestType .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            /* padding-left: 25px; */
            /* padding-top: 10px; */
            position: relative;
        }

        #DivList .dataTables_wrapper .dataTables_paginate ul li {
            background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
            font-size: 13px;
            font-weight: 300;
            line-height: 28px;
            list-style: outside none none;
            padding-bottom: 5px;
            /* padding-left: 25px; */
            /* padding-top: 10px; */
            position: relative;
        }

        .dataTables_info {
            font-size: 13px;
        }

        #frmType {
            width: 100%;
        }

        #divSubRequestType .dataTables_wrapper {
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

        /*#DivHelpDeskSLA .dataTables_scroll {
    overflow: hidden!important;
    width: 100%!important;
}*/
        /*#DivHelpDeskSLA .dataTables_scrollBody {
    overflow: auto!important;
    width: 102%!important;
    height: 130px;
    padding-right: 2%!important;
}*/
        #idPanelBody {
            overflow: auto;
            height: 175px;
            width: 103%;
            padding-right: 2%;
        }

        #divSubRequestType .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divSubRequestType .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #divGridSubRequestType .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divGridSubRequestType .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #DivList table tr td:nth-child(1) {
            width: 25% !important;
        }

        #DivList table tr td:nth-child(2) {
            width: 25% !important;
        }

        #DivList table tr td:nth-child(3) {
            width: 40% !important;
        }

        #divGridSubRequestType .dataTables_scrollHeadInner table .clsTRColumnHeader tr th:nth-child(4) {
            text-align: center;
        }

        #divGridSubRequestType .container-fluid {
            min-height: 0px !important;
        }

        #divStatus .container-fluid {
            min-height: 0px !important;
        }

        #collapseOne2 {
            overflow: hidden;
        }

            #collapseOne2 .panel-body {
                overflow: auto;
                /*height: 150px;*/
                width: 103%;
                padding-right: 2%;
            }

        #collapseOne3 {
            overflow: hidden;
        }

            #collapseOne3 .panel-body {
                overflow: auto;
               
                width: 103%;
                padding-right: 2%;
            }

        #divStatus .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divStatus .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        .form-control {
            font-weight: 100;
        }

        #divStatus .dataTables_scrollHeadInner table .clsTRColumnHeader tr th:nth-child(4) {
            text-align: left;
        }
       
        #divPriority .container-fluid {
            min-height: 0px !important;
        }

        #collapseOne4 {
            overflow: hidden;
        }

            #collapseOne4 .panel-body {
                overflow: auto;
                /*height: 150px;*/
                width: 103%;
                padding-right: 2%;
            }

        #divPriority .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divPriority .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #divSeverity .dataTables_scroll {
            OVERFLOW: HIDDEN;
        }

        #divSeverity .dataTables_scrollBody {
            position: relative;
            overflow: auto;
            width: 102% !important;
            height: 180px;
            padding-right: 0.5%;
        }

        #divSeverity .container-fluid {
            min-height: 0px !important;
        }

        #collapseOne5 {
            overflow: hidden;
        }

            #collapseOne5 .panel-body {
                overflow: auto;
            
                width: 103%;
                padding-right: 2%;
            }

        .form-horizontal {
            width: 100%;
            line-height: 2;
        }

        #accordion4 .form-group {
            border-bottom: none;
        }

        #tblTypeSLADetails .clsTxtControls {
            width: 43px !important;
            height: 28px !important;
        }

        #tblTypeSLADetails .clscboControls {
            width: 79px !important;
            margin-left: 4PX; height:30px;
        }

        #tblTypeSLADetails .col-sm-4 {
            padding-right: 3PX;
        }

        #tblTypeSLADetails .form-group {
            float: none;
        }

        .container-fluid {
            min-height: 0px !important;
        }

        /*Added By Dipali V On 27th Feb 2021 For UI Issue*/
        #tblTypeSLADetails {
            overflow:auto!important;
        }

          /*End of Added By Dipali V On 27th Feb 2021 For UI Issue*/

        #CboType {
            /*width:75px;
        padding: 4px 5px;*/
            width: 81px !important;
            padding: 4px 7px;
            font-size: 11px !important;
        }

        .clsCheckBox {
            margin-top: 9px !important;
        }

        #idSearchHistory {
            position: absolute;
            margin-top: 14px;
            margin-left: 10px;
        }

        .panel-group {
            margin-bottom: 0px !important;
        }

        /*#page-top {
            overflow: hidden !important;
        }*/ /*commented by pradip on 18-06-2021*/

        .setting-src {
            padding: 0px !important;
        }

        select.form-control:not([size]):not([multiple]) {
            height: calc(2.25rem + 6px);
        }

        #tblTypeSLADetails table thead {
            font-size: 12px;
        }

        .right {
            padding-right: 10px;
        }

        .clsSLADetails {
            overflow: hidden;
        }
       
        .btn-default {
            margin-left: 2px;
        }

        #HelpDeskAddSLA {
            width: 100%;
            overflow: hidden;
        }

        #HelpDeskScroll {
           
        }

        .bottom-bar {
            padding-left: 13px;
            padding-right: 13px;
        }

        #idCancel {
            margin-right: -7px;
        }

        .type-top-bar {
            padding: 2px 14px !important;
        }

        .form-group {
            border: none !important;
        }

        #tblTypeSLADetails table tbody td {
            vertical-align: middle !important;
        }

        .dataTables_scrollBody .clsTRColumnHeader {
            height: 0px !important;
        }

        input.form-control:not([type=button]) {
            margin-top: 1px !important;
        }

        #tblTypeSLADetails .table > thead tr th {
            font-weight: normal !important;
        }

        #FormDescription {
            margin-bottom: 7px;
        }

        .clsLinks .btn-default {
            background: white !important;
            color: black !important;
        }

            .clsLinks .btn-default:hover {
                background: white !important;
                color: black !important;
            }

        .clsCoSntrol {
            margin-top: 12PX;
        }
        /*Added by Usha Pandit on 04 JAN 2018*/
        #tblDivHelpDeskSLA {
            margin-top: 6px;
        }
        /*End of added by Usha Pandit on 04 JAN 2018*/

        /*added stype by pradip on 7-1-2021*/
       
        .tabcontent, .v-tabs .tab, .request-details-pg, .container-fluid{ height:100%!important;}
        .request-details-pg, .container-fluid{ height:100%!important; min-height:auto!important;}
    
  
  .clsSLADetails .form-horizontal .form-group{ margin-bottom:15px;}
 .clsSLADetails .form-horizontal .form-group { display: inline-flex;}
 #tblTypeSLADetails td .form-group { display: inline-flex;}
 .type-top-bar.top-bar ul.left li { list-style-type: none;}
 ul.right.clsLinks {
    float: right;
    list-style-type: none;
}
 .bottom-bar .panel-title a[role='button'] {
    float: right;
    margin-top: -18px;
}

.bottom-bar .panel-body .top-bar ul{margin-bottom:0;height: 27px;}
.bottom-bar .panel-body .top-bar ul select{margin-bottom:0;}
.bottom-bar #accordion .fas fa-minus{display:block;}
.bottom-bar #accordion .fas fa-plus{display:none;}
.bottom-bar #accordion .collapse.show .fas fa-minus{ display:block;}
.bottom-bar #accordion .collapse.show .fas fa-plus{display:none;}
.bottom-bar #accordion .collapsed .fas fa-minus{display:none;}
.bottom-bar #accordion .collapsed .fas fa-plus{display:block;}
.bottom-bar .fas fa-plus {display:none;}
.bottom-bar .fas fa-minus {display:block;}
.bottom-bar .collapsed .fas fa-plus {display: block;}
.bottom-bar .collapsed .fas fa-minus {display:none;}

body {font-size: 11.5px;} /* Modified By Madhuri.K On 26-03-2026 */
.page-link {font-size: 11.5px;} /* Modified By Madhuri.K On 26-03-2026 */
.h-type .panel-heading {
    padding: 10px;
}
.h-type .panel-heading h3 {
    color: #464a4c;
    font-size: 11.5px;
     /* Modified By Madhuri.K On 26-03-2026 */ 
     width:97%;
}
.panel-collapse{ clear:both;}
.btn-default {
    color: rgb(51, 51, 51);
    background-color: rgb(255, 255, 255);
    border-color: rgb(204, 204, 204);
}
.btn-default:hover {
    color: #333;
    background-color: #e6e6e6;
    border-color: #adadad;
}
    /* Added by Gauri on 27th Sep 2024 for Alignment Issue */
    .form-control,
    input.form-control:not([type="button"]), 
    textarea.form-control {
        font-weight: 400 !important;
    }
    input.form-control:not([type="button"])::placeholder, 
    textarea.form-control::placeholder,
    input[type="text"]:not(.search-bar){
        font-weight: 500 !important;
    }
    /* End of Added by Gauri on 27th Sep 2024 for Alignment Issue */
        </style>

<!--<body class="" id="page-top" style="overflow: hidden !important;">-->
    <body class="" id="page-top">

        <!-- Navigation -->


        <%PageInit("Load")%>
        <input type="hidden" id="hdnTemplateID" name="hdnTemplateID" value="0" />

        <div id="id13" class="modal">

            <form class="modal-content animate" action="/action_page.php">
                <div class="imgcontainer">
                    <span class="appro-title">Show History</span>
                    <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close Modal">&times;</span>
                </div>
                <div class="container-fluid">
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="request type">Modified Field</label>
                        <div class="col-sm-9">
                            <select class="form-control form-select" id="Select21" style="width: 219px;">
                                <option>Department</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-3" for="request type code">Modified By</label>
                        <div class="col-sm-9">
                            <select class="form-control form-select" id="Select22" style="width: 219px;">
                                <option>Modified By</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>
                        </div>
                    </div>
                    <div class="h-tabs">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Modified Field</th>
                                        <th>Modified Date</th>
                                        <th>Value</th>
                                        <th>Modified By</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Subject</td>
                                        <td>25 Augast 2017    3:30 AM</td>
                                        <td>IR submitted [Project: PROJECT_NAME IR ID:
                                            <ir_id>
                                            ].</td>
                                        <td>Admin</td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </form>
        </div>

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <%--<script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>--%>    
    <script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>


    <!-- Time picker -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/timepicker.js"></script>
       <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%> 
    <script>
        $(function () {
            $('#timepicker1').timepicker();
            $('#timepicker2').timepicker();
        });
    </script>

    <!-- End of time picker -->
    <script>
        $(function () {
            $("#datepicker").datepicker();
            $("#datepicker1").datepicker();
            $("#datepicker2").datepicker();
            $("#datepicker3").datepicker();
            $("#datepicker4").datepicker();
            $("#datepicker5").datepicker();
        });
    </script>


    <script>
        var strPageName = "CRM_RequestSLA.aspx";
        $(document).ready(function () {
            $("#txtEditor").Editor();
            $("#txtEditor1").Editor();
            $("#txtEditor2").Editor();
            $("#txtEditor3").Editor();

<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
            disableRightClick();
                <%End If%>
        });
    </script>

    <script>
        //Added By Rehan C To add Validator for Special characters on 27th Dec 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        //End Of Comment By Rehan C
        var TabName = "";
        var Flag = "";
        var arrSelectedCheck = new Array();

        function OpenTabs(evt, cityName) {

            TabName = cityName;
            var i, tabcontent1, tablinks1;
            tabcontent1 = document.getElementsByClassName("tabcontent1");
            for (i = 0; i < tabcontent1.length; i++) {
                tabcontent1[i].style.display = "none";
            }
            tablinks1 = document.getElementsByClassName("tablinks1");
            for (i = 0; i < tablinks1.length; i++) {
                tablinks1[i].className = tablinks1[i].className.replace(" active", "");
            }

            document.getElementById(cityName).style.display = "block";

            RefreshGrid(cityName, Flag);

            evt.currentTarget.className += " active";
        }
        // Get the element with id="defaultOpen" and click on it
        // document.getElementById("defaultOpen1").click();


        function RefreshGrid(cityName, Flag) {

            var strResult, data;
            var GridParameter = {};
            cityName = "HelpDeskAddSLA"
            GridParameter.cityName = cityName;
            var DivId;
            var DivSerach;
            var DivId1;
            var DivSerach1;

            DivId = "HELPDESKSLA";
            DivSerach = "SearchSLA";
            DivId1 = "tblTypeSLADetails";
            DivSerach1 = "";

            data = JSON.stringify({ GridParameter: GridParameter });
            if (Flag != "") {
                strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);

                if (strResult.d != '') {

                    //      $("#" + cityName).html(strResult.d);
                    $("#tblDivHelpDeskSLA").html(strResult.d);

                    $("#tblDivHelpDeskSLA .table-responsive:first table").addClass("table");
                    //   $("#" + cityName + " .table-responsive:first table").addClass("table"); 
                }
            }

            RefreshPage();
        }

        function RefreshPage() {

            var strResult, data;

            var DivId;
            var DivSerach;
            var DivId1;
            var DivSerach1;

            DivId = "DivHelpDeskSLA";
            DivSerach = "SearchSLA";
            DivId1 = "tblTypeSLADetails";
            DivSerach1 = "";


            var TypeDiv; var accordion;

            var intDivGridHeight, intDivGridListHeight
            intDivGridListHeight = parseInt(window.innerHeight);
            if ((parseInt(window.innerHeight) <= 803 && parseInt(window.innerWidth) <= 1072)) {
                //commented by pradip on 18-06-2021
                //$("#HelpDeskScroll").css('height', intDivGridListHeight - 280 + "px");
            }

            else if ((parseInt(window.innerHeight) < 768 && parseInt(window.innerWidth) < 1024)) {
                //commented by pradip on 18-06-2021
                //$("#HelpDeskScroll").css('height', intDivGridListHeight - 320 + "px");
            }
            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
                //commented by pradip on 18-06-2021
                //$("#HelpDeskScroll").css('height', intDivGridListHeight - 280 + "px");
            }
            else {
                //commented by pradip on 18-06-2021
                //$("#HelpDeskScroll").css('height', intDivGridListHeight - 280 + "px");
            }
            datatables(DivId, DivSerach);
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
        function datatableMainPage(divID, height) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' table').DataTable({
                responsive: true,
                "pageLength": 10,
                scrollY: height - 80 + 'px',
                //scrollX: true,
                pagingType: "simple",
            });
            $("#" + divID + " .dataTables_length").parent().css("display", "none");

            $("#" + divID + " .dataTables_scrollHeadInner table th:first-child").css("width", "50%");
            $("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("width", "50%");
            $("#" + divID + " .dataTables_scrollHeadInner table th:nth-child(2)").css("text-align", "center");
            $("#" + divID + " .dataTables_scrollHeadInner table").css("width", "98.3%");
            $("#" + divID + " .dataTables_scrollBody table").css("width", "98.3%");
            $("#" + divID + " .dataTables_scrollBody table td:first-child").css("width", "50%");
            $("#" + divID + " .dataTables_scrollBody table td:nth-child(2)").css("width", "50%");

            $('#' + divID).css("visibility", "");

        }
        //function datatables(divID, txtBoxID) {
        //    //debugger;
        //    $('#' + divID + ' > table').removeClass("clsGridTable");
        //    $('#' + divID + ' table').addClass("table table-bordered table-stripped");
        //    var table = $('#' + divID + ' > table').DataTable({
        //        responsive: true,
        //        "pageLength": 3,
        //        // scrollY: '130px',
        //        pagingType: "simple_numbers",

        //        //  scrollX: true,


        //    });



        //    if (txtBoxID != "") {
        //        $('#' + txtBoxID).on('keyup change', function () {
        //            table.search($(this).val()).draw();
        //        })


        //        //Added by Usha Pandit on 11 JAN 2018 for showing records match with text in search box
        //        if ($('#' + txtBoxID).val() != "") {
        //            table.search($('#' + txtBoxID).val()).draw();
        //            //table.refresh();
        //        }
        //        //End of Added by Usha Pandit on 11 JAN 2018 for showing records match with text in search box
        //    }
        //}

        function datatables(divID, txtBoxID) {

            var tableSelector = "";
            var targetTable = null;

            // Case 1: Auto-generated DataTables table (no records)
            if ($("#DataTables_Table_0").length > 0) {
                tableSelector = "#DataTables_Table_0";
                targetTable = $("#DataTables_Table_0");
            }
            // Case 2: Dynamic table under div
            else if ($("#" + divID + " table").length > 0) {
                tableSelector = "#" + divID + " table";
                targetTable = $("#" + divID + " table");
            }
            else {
                console.warn("No table found for divID: " + divID);
                return; // stop here, nothing to bind
            }

            // Check if table has proper structure before initializing DataTables
            if (targetTable.length === 0) {
                console.warn("Target table not found");
                return;
            }

            // Check if table has thead and tbody
            var hasThead = targetTable.find('thead').length > 0;
            var hasTbody = targetTable.find('tbody').length > 0;
            var hasRows = targetTable.find('tbody tr').length > 0;

            // If no proper table structure, don't initialize DataTables
            if (!hasThead) {
                console.warn("Table missing thead, skipping DataTables initialization");
                return;
            }

            // Check column count consistency
            var headerColumns = targetTable.find('thead tr:first th').length;
            var dataColumns = 0;
            if (hasRows) {
                dataColumns = targetTable.find('tbody tr:first td').length;
                if (headerColumns !== dataColumns) {
                    console.warn("Column count mismatch: Header has " + headerColumns + " columns, but data has " + dataColumns + " columns. Skipping DataTables initialization.");
                    return;
                }
            }

            // Destroy existing DataTable instance if already initialized
            if ($.fn.DataTable.isDataTable(tableSelector)) {
                $(tableSelector).DataTable().clear().destroy();
            }

            // Apply styling
            $(tableSelector).removeClass("clsGridTable");
            $(tableSelector).addClass("table table-bordered table-stripped");

            try {
                // Initialize DataTable with error handling
                var table = $(tableSelector).DataTable({
                    responsive: true,
                    pageLength: 3,
                    pagingType: "simple_numbers",
                    // Add empty data message if no rows
                    language: {
                        emptyTable: "There are no items to show in this view."
                    },
                    // Handle empty tables gracefully
                    data: hasRows ? null : []
                });

                // Search box binding
                if (txtBoxID && $("#" + txtBoxID).length > 0) {
                    $("#" + txtBoxID).off("keyup change").on("keyup change", function () {
                        table.search($(this).val()).draw();
                    });

                    if ($("#" + txtBoxID).val() != "") {
                        table.search($("#" + txtBoxID).val()).draw();
                    }
                }
            } catch (error) {
                console.error("Error initializing DataTable:", error);
                // If DataTables fails, at least ensure the table is visible
                $(tableSelector).show();
                // Add a simple message if table is empty
                if (!hasRows) {
                    var emptyMessage = '<tr><td colspan="' + headerColumns + '" style="text-align: center; padding: 20px;">There are no items to show in this view.</td></tr>';
                    if (targetTable.find('tbody').length === 0) {
                        targetTable.append('<tbody></tbody>');
                    }
                    targetTable.find('tbody').html(emptyMessage);
                }
            }
        }




        function setWidthDatatable(divID) {

            var tblTotal = document.getElementById(divID).getElementsByClassName('dataTable')[0];
            var tblDetails = document.getElementById(divID).getElementsByClassName('dataTable')[1];
            //if (WhichBrowser() != 'FF') {

            // console.log(tblDetails) //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            if (tblDetails != null) {
                tblTotal.style.width = tblDetails.offsetWidth + 'px';
                width = tblDetails.offsetWidth + 'px';
                //   alert(width);
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
                    // console.log(xhr.responseText); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }


        function ValidateHeldeskSLA() {
            var chkVal = 0;
            var TemplateName = $("#txtTemplateName").val();
            var Description = $("#txtDescription").val();
            var strmsg = "";
            if ($("#txtTemplateName").val() == "") {
                //  alertify.set('notifier', 'position', 'top-right');
                // alertify.notify('Request Type should not be left blank', 'error');
                strmsg = strmsg + 'SLA Template Name should not be left blank';
                chkVal = 1;
            }


            //if (RequestType != "") {
            //    data = JSON.stringify({ RequestType: RequestType });
            //    var strResult1 = AJAXCallWithResult("CRM_RequestSLA.aspx/IsDuplicateRequestType", data, false);

            //    if (strResult1.d == "1") {
            //        //alertify.set('notifier', 'position', 'top-right');
            //        //alertify.notify('Request Type is already exists', 'error');
            //        strmsg = strmsg + 'Request Type already exists';
            //        chkVal = 1;

            //    }
            //}
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strmsg, 'error');
            }

            return chkVal;
        }
        //function SaveHelpDeskSLA() {
        //    if (ValidateHeldeskSLA() == 0) {
        //        var TemplateName = $("#txtTemplateName").val();
        //        var Description = $("#txtDescription").val();
        //        var HelpDeskSLAID
        //        if (document.getElementById('SLADetailsID') != null) {
        //            HelpDeskSLAID = document.getElementById('SLADetailsID').value;
        //        }
        //        else {
        //            HelpDeskSLAID = "0";
        //        }

        //        data = JSON.stringify({ TemplateName: TemplateName, Description: Description, HelpDeskSLAID: HelpDeskSLAID });
        //        //  alert(data);
        //        strResult = AJAXCallWithResult("CRM_RequestSLA.aspx/SaveRequestType", data, false);
        //        if (strResult.d != "") {

        //            $("#divRequestTypes").css("display", "block");
        //            $(".type-top-bar").css("display", "block");
        //            $("#RequestPaging").css("display", "block");
        //            alertify.set('notifier', 'position', 'top-right');
        //            alertify.notify('Type saved successfully', 'success');
        //            $("#requesttype").val("");
        //            $("#requesttypecode").val("");
        //            RefreshGrid(TabName, Flag);
        //        }
        //        // }
        //    }
        //}




        function isBlank(val) {
            if (val == null) { return true; }
            for (var i = 0; i < val.length; i++) {
                if ((val.charAt(i) != ' ') && (val.charAt(i) != "\t") && (val.charAt(i) != "\n") && (val.charAt(i) != "\r")) { return false; }
            }
            return true;
        }
        function isNumeric(val) { return (parseFloat(val, 10) == (val * 1)); }

        function RestrictNonNumeric(obj) {
            // debugger;
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

    </script>
    <script>

        function openCity(evt, cityName) {
            var i, tabcontent3, tablinks3;
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
        }
        // Get the element with id="defaultOpen" and click on it
        //document.getElementById("defaultOpen3").click();
    </script>

    <script>
        // Get the modal for Request Type button popup
        $('.modal').draggable();
        var modal = document.getElementById('id09');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script>
        // Get the modal for Status in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id10');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Priority in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id11');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id12');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id13');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id14');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>

    <script>
        // Get the modal for Sevirity in show history button popup
        $('.modal').draggable();
        var modal = document.getElementById('id15');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        $(document).ready(function () {
            //  debugger;

            // var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
            //    alert(bodyHeight);
            // $('#MainDiv').css('height', bodyHeight - 10 + 'px');

            $('[data-bs-toggle="tooltip"]').tooltip();
            RefreshPage();
        });

        //Commented & Added By Dipali V on 25th Dec 2020 For Jquery Version Issues
   // $(window).load(function () {
    $(window).on("load", function () {
  //End of Commented & Added By Dipali V on 25th Dec 2020 For Jquery Version Issues

            //var ObjTd = window.frames.parent.document.getElementById('tdTree')
            //var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
            //var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

            //if (ObjTd != null && ObjImg != null) {

            //    ObjTd.style.display = 'none';
            //    ObjImg.src = '../../Images/Home/RightMove.gif';
            //    ObjLeftnavigation.style.display = '';
            //}

            //  var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;

            // $('#MainDiv').css('height', bodyHeight - 10 + 'px');


            //$("#divRequestType").addClass(".table-responsive");
            // $(".table-responsive table.clsGridTable").addClass("table");

        });
        var SLATemplateID = 0;
        var SLATypeID = 0;
        function Type_Onchange(obj) {
            var SLAType = obj.value;
            SLATypeID = obj.id;
            if (EditSLATemplateID != 0) {
                SLATemplateID = EditSLATemplateID
            }
            data = JSON.stringify({ SLATemplateID: SLATemplateID, SLAType: SLAType, SLATypeID: SLAType });
            var strResult;
            strResult = AJAXCallWithResult(strPageName + "/RefreshSLADetailsGrid", data, false);
            if (strResult.d != '') {
                $("#divSLADetails").html("");
                $("#divSLADetails").html(strResult.d);
                // datatables('tblTypeSLADetails',"");
                // $("#tblTypeSLADetails").css("height", "150px");
                // $("#tblTypeSLADetails").css("overflow", "auto");
            }

        }
        function EditApplySLADetails() {

           // alert('1')


        }
        function ValidateSLA() {
           // debugger;
            var checkvalue = 0;

            var Flag1 = 0;
            var Flag2 = 0;
            var Flag3 = 0;
            var Flag4 = 0;

            var Unit1 = 0;
            var Unit2 = 0;
            var Unit3 = 0;
            var Unit4 = 0;
            var ValidRow = 0;
            var ValidDetails = 0;
            var checkValid = 0;
            var checkSpecialChar = 0;
            var checkRange = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            var TemplateName = $("#txtTemplateName").val();
            var Description = $("#txtDescription").val();
            var Type = $("#CboType").val();
            if ($("#txtTemplateName").val() == "") {
                strmsg = '- SLA Template name should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;

                //Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
                $("#txtTemplateName").focus();
                //End of Added by Usha Pandit on 08 JAN 2018 for giving focus to mandatory field
            }
            //}
            //debugger;
            //Added & Commented Dipali V On 25th Dec 2020 For Undefined Condition Handal
            if (EditSLATemplateID == "" ||  EditSLATemplateID==undefined) {
                EditSLATemplateID = "0";
            }
            //End of Added & Commented Dipali V On 25th Dec 2020 For Undefined Condition Handal
            if (TemplateName != "") {
                data = JSON.stringify({ TemplateName: TemplateName, TemplateID: EditSLATemplateID });
                var strResult1 = AJAXCallWithResult("CRM_RequestSLA.aspx/IsDuplicateTemplateName", data, false);
                //   alert(strResult1.d);
                if (EditSLATemplateID == "0") {
                    if (strResult1.d == "1") {
                        strmsg += "<li>- SLA Template name is already exists. </li>";
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }
                //Added By Rehan C To add Validator for Special characters validation on 27th Dec 2022
                if (checkSpecialCharacter(TemplateName, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('SLA Template Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtsubject").focus();
                    checkvalue = 1;
                }
                //End of the Comment by Rehan C
                if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtDescription").focus();
                    checkvalue = 1;
                }
        //End of the Comment by Rehan C
            }




            var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
            for (var i = 0; i < hdnCountTypeDetails.length; i++) {

                if (hdnCountTypeDetails[i] != null) {
                    Flag1 = 0;
                    Flag2 = 0;
                    Flag3 = 0;
                    Flag4 = 0;

                    Unit1 = 0;
                    Unit2 = 0;
                    Unit3 = 0;
                    Unit4 = 0;
                    $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");
                    $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");
                    $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");
                    $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "");

                    if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (RestrictNonNumeric(document.getElementById('txtAkNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for Acknowledge Norm';
                            //errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;
                            checkValid = 1;
                            $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }
                    if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (!(($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 >= 0.1) && ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 <= 99))) {
                            checkRange = 1;
                            checkvalue = 1;
                            $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }
                    if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (RestrictNonNumeric(document.getElementById('txtResolveNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for Resolve Norm';
                            //errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;
                            checkValid = 1;
                            $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }
                    if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (!(($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 >= 0.1) && ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 <= 99))) {
                            checkRange = 1;
                            checkvalue = 1;
                            $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }

                    if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (RestrictNonNumeric(document.getElementById('txtResNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for Response Norm';
                            //errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;
                            checkValid = 1;
                            $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }
                    if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (!(($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 >= 0.1) && ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 <= 99))) {
                            checkRange = 1;
                            checkvalue = 1;
                            $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }

                    if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        if (RestrictNonNumeric(document.getElementById('txtcloseNorm_' + Type + "_" + hdnCountTypeDetails[i].value)) == true) {
                            //strmsg = '- Please enter only positive numeric value for close Norm';
                            //errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;
                            checkValid = 1;
                            $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }
                    if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (!(($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 >= 0.1) && ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() - 0 <= 99))) {
                            checkRange = 1;
                            checkvalue = 1;
                            $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }

                    /////////////////////////////////////////

                    if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (checkSpecialCharacter($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }

                    if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (checkSpecialCharacter($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }

                    if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
                        if (checkSpecialCharacter($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }

                    if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        if (checkSpecialCharacter($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val()) == true) {
                            checkvalue = 1;
                            checkSpecialChar = 1;
                            $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233,1)");
                        }
                    }



                    if ($("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit1 = 0;
                    }
                    else {
                        Unit1 = 1;
                    }

                    if ($("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit2 = 0;
                    }
                    else {
                        Unit2 = 1;
                    }

                    if ($("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit3 = 0;
                    }
                    else {
                        Unit3 = 1;
                    }

                    if ($("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                        Unit4 = 0;
                    }
                    else {
                        Unit4 = 1;
                    }


                    if ((Unit1 == 0 && Unit2 == 0 && Unit3 == 0 && Unit4 == 0)) {
                        strmsg = '- Unit is mandatory';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }

                }
            }
            //  debugger;


            if (ValidDetails == 1 && (Flag1 == 0 && Flag2 == 0 && Flag3 == 0 && Flag4 == 0)) {
                strmsg = '- Norm is mandatory';
                errorMsg += "<li>" + strmsg + "</li>";
            }

            if (checkValid == 1) {
                strmsg = '- Please enter only positive numeric value for Norms';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }


            if (checkSpecialChar == 1) {
                strmsg = '- Norm cannot contain any of these /\\:*?<>|,"+- Characters';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
            if (checkRange == 1) {
                strmsg = '- The value of Norm should be in the Range of 0.1-99.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
            //  alert(strmsg);
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error');
                checkvalue = 1;
            }
            return checkvalue;

        }
        var EditSLATemplateID = 0;
        function SaveAddHelpDeskSLA() {
            if (SaveHelpDeskSLA() == 0) {
                AddHelpDeskSLA();
            }
        }

        var EditSLATemplateID = 0;
        function SaveHelpDeskSLA() {
            //sdebugger;
            if (ValidateSLA() == 0) {
                var TemplateName = $("#txtTemplateName").val();
                var Description = $("#txtDescription").val();
                var Type = $("#CboType").val();
                var SLATemplateID = "0";
                var SaveSLADetialsData = [];
                var Priority = 0, Severity = 0;

                var hdnCountType = document.getElementById('hdnCountType');
                if (Type == "1") {
                    //Priority = "1"

                }
                else if (Type == "2") {
                    // Severity = "1"
                }
                if (hdnCountType != null) {
                    var strAcknowledgeWithinNorm = "";
                    var strAcknowledgeWithinUnit = "";

                    var strResolveWithinNorm = "";
                    var strResolveWithinUnit = "";

                    var strRespondWithinNorm = "";
                    var strRespondWithinUnit = "";

                    var strCloseeWithinNorm = "";
                    var strCloseeWithinUnit = "";

                    var ExcalationEmail = "";
                    var ConsiderWorkHrs = "";
                    var ExcludeHoldPeriod = "";
                    var IsExcalationEmail = "";
                    var IsConsiderWorkHrs = "";
                    var IsExcludeHoldPeriod = "";
                    var strDetailsID = "";
                    var strCustomCommentIDsRelease = "";
                    var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
                    for (var i = 0; i < hdnCountTypeDetails.length; i++) {

                        if (hdnCountTypeDetails[i] != null) {
                            // alert($("#hdnDetailsID" + Type + "_" + hdnCountTypeDetails[i].value));
                            if ($("#hdnDetailsID " + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                if (strDetailsID == "") {
                                    //Added By  Dipali V On 9th April 2021 for Template Saving issue
                                    if ($("#hdnDetailsID " + Type + "_" + hdnCountTypeDetails[i].value).val() != undefined) {
                                        strDetailsID = $("#hdnDetailsID " + Type + "_" + hdnCountTypeDetails[i].value).val();
                                    } else {
                                        strDetailsID = "0";
                                    }

                                     //End of Added By  Dipali V On 9th April 2021 for Template Saving issue
                                }
                                else {
                                    strDetailsID += ',' + $("#hdnDetailsID " + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }
                            else {
                                if (strDetailsID == "") {
                                    strDetailsID = "0";
                                }
                                else {
                                    strDetailsID += ',' + "0";
                                }

                            }



                            if (Type == "1") {
                                if (Priority == 0) {
                                    Priority = $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                                else {
                                    Priority += ',' + $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }

                            // alert(Priority);

                            if (Type == "2") {
                                if (Severity == 0) {
                                    Severity = $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                                else {
                                    Severity += ',' + $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }

                            //Acknowledge Within

                            if (strAcknowledgeWithinNorm == "") {
                                strAcknowledgeWithinNorm = $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strAcknowledgeWithinNorm == "") {
                                    strAcknowledgeWithinNorm = "0"
                                }
                            }
                            else {
                                if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strAcknowledgeWithinNorm += ',' + "0";
                                }
                                else {
                                    strAcknowledgeWithinNorm += ',' + $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }

                            //Acknowledge Unit
                            if (strAcknowledgeWithinUnit == "") {
                                strAcknowledgeWithinUnit = $("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strAcknowledgeWithinUnit += ',' + $("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }

                            //Resolve Within
                            if (strResolveWithinNorm == "") {
                                strResolveWithinNorm = $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strResolveWithinNorm == "") {
                                    strResolveWithinNorm = "0"
                                }
                            }
                            else {
                                if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strResolveWithinNorm += ',' + "0";
                                }
                                else {
                                    strResolveWithinNorm += ',' + $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }

                            }
                            //Resolve Unit
                            if (strResolveWithinUnit == "") {
                                strResolveWithinUnit = $("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strResolveWithinUnit += ',' + $("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }



                            //Response Within
                            if (strRespondWithinNorm == "") {
                                strRespondWithinNorm = $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strRespondWithinNorm == "") {
                                    strRespondWithinNorm = "0";
                                }

                            }
                            else {
                                if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strRespondWithinNorm += ',' + "0";
                                }
                                else {
                                    strRespondWithinNorm += ',' + $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }
                            //Response Unit
                            if (strRespondWithinUnit == "") {
                                strRespondWithinUnit = $("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strRespondWithinUnit += ',' + $("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }




                            //Response Within
                            if (strCloseeWithinNorm == "") {

                                strCloseeWithinNorm = $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                if (strCloseeWithinNorm == "") {
                                    strCloseeWithinNorm = "0";
                                }
                            }
                            else {
                                if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
                                    strCloseeWithinNorm += ',' + "0";
                                }
                                else {
                                    strCloseeWithinNorm += ',' + $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                                }
                            }
                            //Response Unit
                            if (strCloseeWithinUnit == "") {
                                strCloseeWithinUnit = $("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }
                            else {
                                strCloseeWithinUnit += ',' + $("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val();
                            }

                            //ExcalationEmail 

                            var IsExcalationEmail = "";
                            var IsConsiderWorkHrs = "";
                            var IsExcludeHoldPeriod = "";

                            var ExcalationEmailValue;
                            if (ExcalationEmail == "") {
                                ExcalationEmailValue = $("#chkEsc_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcalationEmail = "1"
                                    }
                                    else {
                                        IsExcalationEmail = "0"
                                    }
                                }
                                else {

                                    IsExcalationEmail = "0"
                                }
                                ExcalationEmail = IsExcalationEmail;
                            }
                            else {
                                ExcalationEmailValue = $("#chkEsc_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcalationEmail = "1"
                                    }
                                    else {
                                        IsExcalationEmail = "0"
                                    }
                                }
                                else {

                                    IsExcalationEmail = "0"
                                }

                                ExcalationEmail += ',' + IsExcalationEmail;
                            }
                            // ConsiderWorkHrs  
                            var ConsiderWorkHrsValue;
                            if (ConsiderWorkHrs == "") {
                                ConsiderWorkHrsValue = $("#chkWrkhrs_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsConsiderWorkHrs = "1"
                                    }
                                    else {
                                        IsConsiderWorkHrs = "0"
                                    }
                                } else {
                                    IsConsiderWorkHrs = "0"
                                }
                                ConsiderWorkHrs = IsConsiderWorkHrs;
                            }
                            else {
                                ConsiderWorkHrsValue = $("#chkWrkhrs_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsConsiderWorkHrs = "1"
                                    }
                                    else {
                                        IsConsiderWorkHrs = "0"
                                    }
                                } else {
                                    IsConsiderWorkHrs = "0"
                                }
                                ConsiderWorkHrs += ',' + IsConsiderWorkHrs;
                            }

                            // ExcludeHoldPeriod
                            var ExcludeHoldPeriodValue;
                            if (ExcludeHoldPeriod == "") {
                                ExcludeHoldPeriodValue = $("#chkEHoldP_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcludeHoldPeriod = "1"
                                    }
                                    else {
                                        IsExcludeHoldPeriod = "0"
                                    }
                                } else {

                                    IsExcludeHoldPeriod = "0"
                                }
                                ExcludeHoldPeriod = IsExcludeHoldPeriod;
                            }
                            else {
                                ExcludeHoldPeriodValue = $("#chkEHoldP_" + Type + "_" + hdnCountTypeDetails[i].value);
                                if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value) != null) {
                                    if (document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked) {
                                        IsExcludeHoldPeriod = "1"
                                    }
                                    else {
                                        IsExcludeHoldPeriod = "0"
                                    }
                                }
                                else {

                                    IsExcludeHoldPeriod = "0"
                                }
                                ExcludeHoldPeriod += ',' + IsExcludeHoldPeriod;
                            }

                        }
                    }

                }
               // alert(EditSLATemplateID);
               // debugger;
                SaveSLADetialsData.push({
                    SLATemplateID: EditSLATemplateID, TemplateName: TemplateName, Description: Description, strAcknowledgeWithinNorm: strAcknowledgeWithinNorm, strAcknowledgeWithinUnit: strAcknowledgeWithinUnit,
                    strResolveWithinNorm: strResolveWithinNorm, strResolveWithinUnit: strResolveWithinUnit, strRespondWithinNorm: strRespondWithinNorm, strRespondWithinUnit: strRespondWithinUnit, strCloseeWithinNorm: strCloseeWithinNorm, strCloseeWithinUnit: strCloseeWithinUnit,
                    ExcalationEmail: ExcalationEmail, ConsiderWorkHrs: ConsiderWorkHrs, ExcludeHoldPeriod: ExcludeHoldPeriod, Priority: Priority, Severity: Severity, Type: Type, DetailsID: strDetailsID
                });

                data = JSON.stringify({ SaveSLADetialsData: SaveSLADetialsData });


                // alert(Priority);
                //  alert(data);
                //data = JSON.stringify({ Subject: Subject, Description: Description, Department: Department, RequestType: RequestType, SubRequestType: SubRequestType, Priority: Priority, Product: Product, ModuleComponent: ModuleComponent, Location: Location, TimeZone: TimeZone, Status: "", Project: "", AssignTo: "", objCustomField: m_strCustomFieldList, CustomFieldValue: CustomFieldValue, ExpResoulDate: ExpResoulDate, CC: CC, CustomerID: CustomerID, EmployeeID: EmployeeID });
                //  alert(data);
                strResult = AJAXCallWithResult("CRM_RequestSLA.aspx/SaveHelpDeskSLATemplate", data, false);
                //  var Result = String(strResult.d).split("||");

                if (strResult != null) {

                    alertify.set('notifier', 'position', 'top-right');
                    if (EditSLATemplateID == 0 || EditSLATemplateID == "0") {
                        alertify.notify("SLA details saved successfully", 'success');
                    }
                    else {
                        alertify.notify("SLA details updated successfully", 'success');
                    }
                    document.getElementById('hdnTemplateID').value = strResult.d;

                    EditSLATemplateID = document.getElementById('hdnTemplateID').value;
                    // alert(EditSLATemplateID);
                    RefreshGrid("HelpDeskSLA", "Refresh");
                    $("#tblDivHelpDeskSLA").css("display", "block");
                    $(".top-bar").css("display", "block");
                    // Cancel_HelpDeskSLA();
                }
                return 0;
            }
            else {
                return 1;
            }
        }



        function Edit_SLATemplate(obj, SLATemplateID) {
           // debugger;
            EditSLATemplateID = SLATemplateID;
            $.ajax({
                type: "POST",
                url: "CRM_RequestSLA.aspx/EditSLADetails",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ SLATemplateID: SLATemplateID }),
                success: function (data) {
                    //debugger;
                    var arrResult = data.d.split('##');
                    //  $("divSLADetails").html("");
                    // alert(arrResult[0]);
                    document.getElementById('divSLADetails').innerHTML = "";
                    document.getElementById('divSLADetails').innerHTML = arrResult[0];
                    //alert(arrResult[0]);
                    //  $("divSLADetails").html(arrResult[0]);
                    $("#txtTemplateName").val(arrResult[1]);
                    $("#txtDescription").val(arrResult[2]);
                    $("#tblDivHelpDeskSLA").css("display", "none");
                    $(".type-top-bar").css("display", "none");
                
                    if ("<%=objAddAccess%>" == true) {
                        $("#save").css("display", "inline");
                         $("#Addsave").css("display", "inline");
                    }
                    else {

                        $("#save").css("display", "none");
                         $("#Addsave").css("display", "none");
                    }
                    if ("<%=objEditAccess%>" == true) {
                        $("#Addsave").css("display", "inline");
                    }
                    else {
                        // $("#save").css("display", "none");
                        $("#Addsave").css("display", "none");
                    }
                },
                error: function (xhr) {
                    // console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                }
            });
        }

        function Cancel_HelpDeskSLA() {
            var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
            $("#txtTemplateName").val("");
            $("#txtDescription").val("");
            var Type = $("#CboType").val();
            EditSLATemplateID = 0;
            for (var i = 0; i < hdnCountTypeDetails.length; i++) {

                if (hdnCountTypeDetails[i] != null) {
                    //Commented And Added By Usha Pandit On 22.02.2021 For SLA Apply Priority/Severity save issue
                    //$("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    //$("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    //End Of Commented By Usha Pandit On 22.02.2021 For SLA Apply Priority/Severity save issue
                    $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = true;
                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = true;
                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = true;
                }
            }
            //Type_Onchange("1");
            $(".type-top-bar").css("display", "block");
            $("#tblDivHelpDeskSLA").css("display", "block");
            RefreshGrid("HelpDeskSLA", "Refresh");
            RefreshPage();
            $("#HelpDeskScroll").scrollTop("0px");
        }
        function AddHelpDeskSLA() {
            var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
            $("#txtTemplateName").val("");
            $("#txtDescription").val("");
            var Type = $("#CboType").val();
            //   alert(Type);
            for (var i = 0; i < hdnCountTypeDetails.length; i++) {

                if (hdnCountTypeDetails[i] != null) {
                    //$("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    //  $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("Days");
                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;

                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = true;
                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = true;
                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = true;

                }
            }
            $(".type-top-bar").css("display", "none");
            $("#tblDivHelpDeskSLA").css("display", "none");
            EditSLATemplateID = 0;
            RefreshPage();
        }

        function DeleteHelpDeskSLA() {
            var SLATemplateID;
            //Commented & Added By Dipali V On 8th April 2023 For Check box issue
            //var table = $('#tblDivHelpDeskSLA table').DataTable();
            //var rows = table.rows({ 'search': 'applied' }).nodes();

            //if (document.getElementById('chkAllDeleteSLA').checked == true) {
            //    SLATemplateID = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
            //        return this.value;
            //    }).get().join(',');
            //}
            //else {
            //    SLATemplateID = arrSelectedCheck.join();
            //} 

            SLATemplateID = $('input[name=chkSLATemplateDelete]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (SLATemplateID.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');         //added by Usha Pandit on 03 JAN 2018
                alertify.notify('Please select at least one SLA record for deletion', 'error');  //added by Usha Pandit on 03 JAN 2018
                return;
            }
            data = JSON.stringify({ SLATemplateID: SLATemplateID });

            strResult = AJAXCallWithResult(strPageName + "/DeleteSLATemplate", data, false);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('SLA Template deleted successfully', 'success');

            //Added by Usha Pandit on 10 JAN 2018 for wrong popup for delete
            var arraySLA = SLATemplateID.split(",");

            $.each(arraySLA, function (i) {
                arrSelectedCheck.pop(arraySLA[i]);
            });

            //End of Added by Usha Pandit on 10 JAN 2018 for wrong popup for delete
            //End of Commented & Added By Dipali V On 8th April 2023 For Check box issue
            var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
            $("#txtTemplateName").val("");
            $("#txtDescription").val("");
            var Type = $("#CboType").val();
            for (var i = 0; i < hdnCountTypeDetails.length; i++) {

                if (hdnCountTypeDetails[i] != null) {

                    $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#hdnTypeNameID_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboAkUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboResolveUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CboResUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    $("#CbocloseUnit_" + Type + "_" + hdnCountTypeDetails[i].value).val("");
                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
                }
            }
            RefreshGrid("HelpDeskSLA", "Refresh");

        }
        function DeleteMultiple_SLATemplate() {
            //if (document.getElementById('chkAllDeleteSLA').checked == true) {
            //    $("input[name=chkSLATemplateDelete]:not(:disabled)").prop('checked', true);
            //}
            //else {
            //    $("input[name=chkSLATemplateDelete]").prop('checked', false);
            //}

            var table = $('#tblDivHelpDeskSLA table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            if (document.getElementById('chkAllDeleteSLA').checked == true) {
                //$("input[name=chkPriorityDelete]:not(:disabled)").prop('checked', true);
                $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
            }
            else {
                //$("input[name=chkPriorityDelete]").prop('checked', false);
                $('input[type="checkbox"]', rows).prop('checked', false);
            }

            //$("#hdScrollfixedtbl1 #Tapprovalall").click(function () {
            // //debugger;
            // if (this.checked) {
            //     $("#fixedtbl1 input[type='checkbox']").attr("checked", true)

            // }
            // else {


            //     $("#fixedtbl1 input[type='checkbox']").attr("checked", false)
            // }


            // });

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

        //function EnableControls(obj, SLATypeID, Counter) {
        //    var Type = $("#CboType").val();

        //    Flag2 = 0;
        //    Flag3 = 0;
        //    Flag4 = 0;
        //    var hdnCountTypeDetails = document.getElementsByName("hdnCountType");
        //    for (var i = 0; i < hdnCountTypeDetails.length; i++) {

        //        if (hdnCountTypeDetails[i] != null) {


        //                if ($("#txtAkNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
        //                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    Flag1 = 1;
        //                }

        //                if ($("#txtResolveNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
        //                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    Flag1 = 1;
        //                }

        //                if ($("#txtResNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() != "") {
        //                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).disabled = false;
        //                    Flag1 = 1;
        //                }

        //                if ($("#txtcloseNorm_" + Type + "_" + hdnCountTypeDetails[i].value).val() == "") {
        //                    document.getElementById('chkEsc_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
        //                    document.getElementById('chkWrkhrs_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
        //                    document.getElementById('chkEHoldP_' + Type + "_" + hdnCountTypeDetails[i].value).checked = false;
        //                    Flag1 = 1;
        //                }


        //        }
        //    }
        //}

        function EnableControls(obj, SLATypeID, Counter) {
            var Type = $("#CboType").val();

            Flag2 = 0;
            Flag3 = 0;
            Flag4 = 0;
            var hdnCountTypeDetails = document.getElementsByName("hdnCountType");


            if ($("#txtAkNorm_" + Type + "_" + Counter).val() == "" && $("#txtResolveNorm_" + Type + "_" + Counter).val() == "" && $("#txtResNorm_" + Type + "_" + Counter).val() == "" && $("#txtcloseNorm_" + Type + "_" + Counter).val() == "") {
                document.getElementById('chkEsc_' + Type + "_" + Counter).disabled = true;
                document.getElementById('chkWrkhrs_' + Type + "_" + Counter).disabled = true;
                document.getElementById('chkEHoldP_' + Type + "_" + Counter).disabled = true;
                document.getElementById('chkEsc_' + Type + "_" + Counter).checked = false;
                document.getElementById('chkWrkhrs_' + Type + "_" + Counter).checked = false;
                document.getElementById('chkEHoldP_' + Type + "_" + Counter).checked = false;
            }
            else {
                document.getElementById('chkEsc_' + Type + "_" + Counter).disabled = false;
                document.getElementById('chkWrkhrs_' + Type + "_" + Counter).disabled = false;
                document.getElementById('chkEHoldP_' + Type + "_" + Counter).disabled = false;
            }
        }
        var Checkedbox;
        function select_checkbox(obj) {
            Checkedbox = 0;
            //Commented & Added By Dipali V On 8th April 2023 For Check box issue
            //Added By Dipali V On 25th June 2019 For Checkbox Issue
            var table = $('#tblDivHelpDeskSLA table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();
            $('#tblDivHelpDeskSLA input[type="checkbox"]').each(function () {
                Checkedbox = $('input[type="checkbox"]:checked:not(:disabled)', rows).map(function () {
                    return this.value;
                }).get().join(',');
            });
            let checked = $(".chcktbl:checked").length
            //if (Checkedbox.length > 0) {
            if (checked == Checkedbox.length) {
                if (checked == 0 && Checkedbox.length == 0) {
                    $("#chkAllDeleteSLA").prop("checked", false);
                }
                else {
                    $("#chkAllDeleteSLA").prop("checked", true);
                }

            } else {
                $("#chkAllDeleteSLA").prop("checked", false);
            }
            //End of Added By Dipali V On 25th June 2019 For Checkbox Issue
            //End of Commented & Added By Dipali V On 8th April 2023 For Check box issue

        }
        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
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
            else {
                return false;
            }
        }
    </script>
</body>

</html>
