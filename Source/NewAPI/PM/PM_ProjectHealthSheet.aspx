<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectHealthSheet.aspx.vb" Inherits="PbNIT.PM_ProjectHealthSheet" %>

<!DOCTYPE html>
<html>
    
    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
     <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">


    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap-5.2.2.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <!-- media_queries -->
    <!--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">-->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />

    <!-- alertify -->
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=0.1">--%>
</head>
    
    <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        .dataTables_scrollHeadInner {
            width: 100% !important;
        }

            .dataTables_scrollHeadInner table {
                width: 100% !important;
            }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.float-end {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        tr.rowhiglight {
            background: #c3dbff;
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

            .DisableContent:hover {
                cursor: no-drop;
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }

        /*New css start here*/
        .circleIndicator {
        }

        .ciYellow {
            color: #f4cd0f;
        }

        .ciGreen {
            color: #81cf09;
        }

        .ciRed {
            color: #eb1c24;
        }

        #healthshetprojectList tr th:first-child, #healthshetprojectList tr td:first-child {
            text-align: left;
        }

        #healthshetprojectList tr th, #healthshetprojectList tr th {
            text-align: center;
        }

        .informationtbl tr th {
            text-align: right;
            font-weight: 500;
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px;
        }

            .informationtbl td.colan {
                padding: 0px;
            }

        .borderbox {
            padding: 15px 10px 10px;
            border: 1px solid #ddd;
            min-height: 91px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5;
        }


        .alertify-notifier {
            z-index: 99999;
        }




        /*chartbox css start here*/
        .chartbox {
            position: relative;
            border-radius: 4px;
            background: #fff;
            margin-bottom: 20px
        }

            .chartbox .box-body {
                border: 1px solid #d2d6de;
                box-shadow: 0 1px 1px rgba(0,0,0,0.1);
                padding: 15px
            }

            .chartbox .box-header {
                background: #4263c1;
                color: #fff;
                padding: 10px
            }

                .chartbox .box-header h3 {
                    margin: 0;
                    color: #fff;
                    font-size: 16px
                }

        .bluehighlight {
            background: #0d95d3
        }

        .bluelight {
            background: #87c9eb
        }
        /*chartbox css end here*/

        /*New css end here*/


        /*New style added by pradip*/
        /*collapse panel style added here*/
        .panel-heading .accordion-toggle:after {
            /* symbol for "opening" panels */
            font-family: 'Glyphicons Halflings'; /* essential for enabling glyphicon */
            content: "\e114"; /* adjust as needed, taken from bootstrap.css */
            float: right; /* adjust as needed */
            color: grey; /* adjust as needed */
        }

        .panel-heading .accordion-toggle.collapsed:after {
            /* symbol for "collapsed" panels */
            content: "\e080"; /* adjust as needed, taken from bootstrap.css */
        }

        .togglerup .collapseup {
            display: block;
        }

        .togglerup .collapsedown {
            display: none;
        }

        .togglerdown .collapsedown {
            display: block;
        }

        .togglerdown .collapseup {
            display: none;
        }

        .infoToggler {
            margin: 5px 0 0;
        }

        .hideaccordianinfopanel {
            position: absolute;
            right: 10px;
        }

        .accordianinfopanel .panel.panel-default {
            padding: 0px 0px 0 0;
            position: relative;
            margin: 0 0 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

            .accordianinfopanel .panel.panel-default table {
                margin-bottom: 0;
            }

        .accordianinfopanel .panel-default > .panel-heading {
            padding-right: 35px;
            /* Changed by Madhuri.K on 09-03-2026 */
            background: #F8FAFC;
            /* background: #e7edf0; */
        }

            .accordianinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus {
                color: #464a4c;
            }

            .accordianinfopanel .panel-default > .panel-heading a span img {
                opacity: 0.5;
            }

                .accordianinfopanel .panel-default > .panel-heading a span img:hover {
                    opacity: 1;
                }

            .accordianinfopanel .panel-default > .panel-heading a:focus {
                color: #464a4c;
            }

        span.col-sm-1.colan {
            text-align: center;
            padding: 0 !important;
            width: 5px
        }

        .PIInfo .form-group {
            margin-bottom: 8px;
        }
        /*End Style for collapse*/
        #MEdetails .control-label, #basicfilters label {
            line-height: 18px;
            text-align: right;
            padding-right: 0px;
        }

        .filterpanelbody > .row > div:nth-child(5n), .filterpanelbody > .row > div:nth-child(6n), .filterpanelbody > .row > div:nth-child(7n) {
            width: 50%;
        }

        .TblHeadingBlue {
            margin: 0 0 5px;
            background: #4263c1;
            color: #fff;
            padding: 10px;
        }

        .notebox ul {
            margin: 0;
            padding: 0;
        }

        .legend {
            background: #fff;
            background: rgba(255, 255, 255, 0.8);
            padding: 0;
            border: none;
            margin-bottom: 10px;
        }

            .legend li:first-child {
                margin-left: 0;
            }

            .legend span {
                display: inline-block;
                width: 12px;
                height: 12px;
                margin-right: 6px;
            }

            .legend li {
                float: left;
                margin-left: 10px;
            }
        /*End style*/

        .phsOpenIssuTbl th {
            min-width: 80px;
        }

            .phsOpenIssuTbl th:first-child {
                min-width: auto;
            }

            .phsOpenIssuTbl th:nth-child(3) {
                min-width: 280px;
                text-align: left;
            }

        .phsOpenIssuTbl td:nth-child(3) {
            text-align: left;
        }

        .phsOpenIssuTbl th:nth-child(4) {
            min-width: 120px;
        }

        .header {
            position: sticky;
            top: 0;
        }

        .tooltip {
            z-index: 99999;
        }

        #filterpanel .cust_tabpanel .nav-tabs > li > a:focus {
            color: #fff;
        }

        /*Added by Vidhi*/
        .filterbutton {
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }
        /*End By vidhi*/


        /*Added by vidhi*/
        .stackbasicfilter .form-inline .input-group .form-control {
            margin: 0;
            border-radius: 4px 0 0 4px
        }

        .stackbasicfilter .input-group-btn {
            margin-left: -4px
        }

            .stackbasicfilter .input-group-btn button.btn.btncalendar {
                height: 28px
            }

        .stackbasicfilter .form-inline select.form-control {
            max-width: 210px;
        }


        .stackbasicfilter .input-group {
            max-width: 170px;
        }

        .stackbasicfilter .form-inline select + select {
            width: 210px !important;
        }

        .stackbasicfilter .form-inline .input-group .form-control {
            width: 162px;
            border-radius: 4px 0px 0 4px;
            margin-left: -4px;
        }

        .stackbasicfilter .form-inline select + .form-control {
            width: 210px;
        }

        /*End by vidhi */

        /*simple pagination style*/
        .simple-pagination {
            display: inline-block;
            padding-left: 0;
            margin-top: 1rem;
            margin-bottom: 1rem;
            border-radius: .25rem
        }

            .simple-pagination li {
                display: inline
            }

            .simple-pagination .page-link, .simple-pagination .ellipse, .simple-pagination .current {
                display: inline-block;
                position: relative;
                float: left;
                padding: .5rem .75rem;
                margin-left: -1px;
                color: #0275d8;
                text-decoration: none;
                background-color: #fff;
                border: 1px solid #ddd
            }

            .simple-pagination li:first-child .page-link {
                margin-left: 0;
                border-bottom-left-radius: .25rem;
                border-top-left-radius: .25rem
            }

            .simple-pagination li:last-child .page-link {
                border-bottom-right-radius: .2rem;
                border-top-right-radius: .2rem
            }

            .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                z-index: 2;
                color: #fff;
                cursor: default;
                background-color: #0275d8;
                border-color: #0275d8
            }

                .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                    background: #1359ac;
                }
        /*End of pagination style*/


        .mandatoryfieldsTD {
            white-space: nowrap;
        }

            .mandatoryfieldsTD .form-control {
                width: 98%;
                display: inline-block;
                float: left;
            }

            .mandatoryfieldsTD label.required {
                display: inline-block;
                vertical-align: bottom;
                margin-left: 5px;
            }

        /*
    Added By Vidhi
*/
        .txtAlign {
            text-align: center;
        }

        .filter button[aria-expanded="true"] {
            background: transparent;
            color: #464a4c;
        }

        tbody tr td.dataTables_empty {
            text-align: center !important;
        }

        .UpSQERTtbl {
            /*width:820px;*/
            width: 100%;
        }

        /*Added by imran on 19-09-2022 */
        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            border-radius: 15px;
            background: #ddd;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

        .clsShowHide {
            display: none !important;
        }
        /*End by imran on 19-09-2022 */

        .accordianinfopanel .panel-default > .panel-heading {
            /* padding: 10px; */
            padding: 0;
        }

            .accordianinfopanel .panel-default > .panel-heading h4 {
                font-size: 14px;
                margin-bottom: 0;
            }

                .accordianinfopanel .panel-default > .panel-heading h4 a {
                    text-decoration: none;
                    color: #464a4c;
                }

        .panel-body {
            padding: 15px;
        }

        .dataTables_scrollBody thead tr {
            visibility: collapse !important;
        }

        .dataTables_paginate a.paginate_button {
            text-decoration: none;
        }

        .main_graybgtbs li {
            min-width: auto;
        }

        .nav-tabs.main_graybgtbs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            background-color: #1359ac;
            color: #fff;
        }

        th.sorting_disabled::after, th.sorting_disabled::before {
            display: none !important;
        }
        .pl-0 {
            padding-left: 0!important;
        }
        .filterpanelbody .input-group {
            display: flex !important;
        }

        /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        .panel-default > .panel-heading a {
            display: block;
            padding: 10px 15px;
        }
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bdyNewProjectHealthSheet">

    <%--Added by imran on 19-09-2022--%>
    <div id="divPMResource" class="preloader"></div>
    <%--End by imran on 19-09-2022--%>

    <div class="bgwhite clsShowHide">

        <div class="container-fluid pt-2 pb-2 mb-3 text-end graybg">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ProjectHealthSheet") %></h5>
            <a href="javascript:;" class="clearalllink" style="" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" id="AdvanceFilterIcon" title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="container-fluid pt-1 pb-1 mb-1 text-end">
            <div class="row">
                <div class="col-sm-3">

                    <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "Select 'Select Project'", 200,, "class='form-select'",,, ) %>
                </div>
                <div class="col-sm-9">
                    <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" id="UpdateSQERT" onclick="UpdateSQERT()" data-bs-target="#UpdateSQERTModal">Update SQERT Values</a>
                    <a href="javascript:;" class="btn borderbtn" id="helpdetails" title="" data-bs-placement="bottom" data-original-title="Help" onclick="GetPHSHelpDetails('3068')">?</a>
                </div>
            </div>
        </div>


        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="dropdown" id="liALMyFiltersdropdown">
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" onclick="MyFilterList()" id="MyFilter" aria-expanded="false"><%= MyBase.GetResourceString("C_MyFilters") %></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                            </ul>
                        </li>
                        <li class="LIALBasicFilter">
                            <a href="#basicfilters" data-bs-toggle="tab" id="BasicFilter" aria-expanded="true"><%= MyBase.GetResourceString("C_BasicFilters") %></a>
                        </li>

                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <%--This Code Commented  and add by Vidhi To switch Myfilter to basic filter part--%>
                        <div id="basicfilters" class="tab-pane stackbasicfilter">

                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" onclick="btnSaveAndApplyFilter_Onclick()" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_SaveandApply") %></button>
                                    <button class="btn btnyellow" onclick="CallApplyFunction()"><%= MyBase.GetResourceString("C_Apply") %></button>
                                </div>
                                <br />

                                <div class="row">

                                    <div class="col-sm-6 form-group row mb-3">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_Practice") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPHSFilterProjectType", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                </div>
                                                <div class="col-sm-8 pl-0">

                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtPHSFilterProjectType", "Select  'Select Practice' ", 200,, "class='form-select'", False,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group row mb-3">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_BusinessGroup") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPHSFilterBusinessGroup", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtPHSFilterBusinessGroup", "Select  'Select Business Group' ", 200,, "class='form-select'", False,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group row mb-3">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_OrganizationUnit") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPHSFilterLocation", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtPHSFilterLocation", "Select  'Select Organization Unit' ", 200,, "class='form-select'", False,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group row mb-3">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_ProjectGroup") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPHSFilterProjectGroupName", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtPHSFilterProjectGroupName", "Select  'Select Project Group' ", 200,, "class='form-select'", False,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group row mb-3">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_Project") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPHSFilterProjectName", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'",,,) %>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtPHSFilterProjectName", "Select  'Select Project' ", 200,, "class='form-select'", False,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group row mb-3">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_ReportingDate") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPHSFilterReportingDate", "usp_Whizible2_ProjectHealthSheet_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-select'",,,) %>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    <div class="input-group" style="white-space: nowrap;">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPHSFilterReportingDate", "txtPHSFilterReportingDate", "form-control",,,,,, , True, "white",, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' autocomplete='off'",,, True,,,,) %>
                                                        <button class="btn btncalendar" type="button" style="height: 30px;"><i class="fas fa-calendar-alt pt-2"></i></button>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6 form-group row mb-3">
                                        <label class="col-sm-4"><%= MyBase.GetResourceString("C_ReportingPeriod") %></label>
                                        <div class="col-sm-8">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <strong id="lblReportingPeriod"></strong>
                                                </div>
                                                <div class="col-sm-8 pl-0">
                                                    &nbsp;

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <div class="content pt-0">

            <div class="panel-group accordianinfopanel" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#PhscollapseOne" aria-expanded="true" aria-controls="collapseOne">
                                
                                <%= MyBase.GetResourceString("C_PHSInformation") %>
                                <span class="infoToggler togglerup float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="PhscollapseOne" class="panel-collapse collapse show">
                        <div class="panel-body clearfix">
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-6 PIInfo">

                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_FromDate") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="lblfromdate"></span>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_ToDate") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="lbltodate"></span>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_BusinessGroup") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="lblbg"></span>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_OrganizationUnit") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class=" col-xs-12 col-sm-8" id="lblou"></span>
                                    </div>

                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_ProjectGroup") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="lblpg"></span>
                                    </div>

                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_Project") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="lblprojectname"></span>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-xs-12 col-sm-3"><%= MyBase.GetResourceString("C_Practice") %></label>
                                        <span class=" col-sm-1 colan">:</span>
                                        <span class="col-xs-12 col-sm-8" id="lblpractice"></span>
                                    </div>

                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-6 PIInfo">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse2" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse2">
                                <%= MyBase.GetResourceString("C_SQERTDetails") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse2" class="panel-collapse collapse">
                        <div class="panel-body clearfix">

                            <div class="row">
                                <div class="col-sm-4">
                                    <strong><%= MyBase.GetResourceString("C_SQERTTill") %></strong>
                                    <label id="lblName"></label>
                                </div>
                                <div class="col-sm-8 text-end">
                                    <div class="legend float-end">
                                        <ul>
                                            <li><span style="background-color: #9dd824"></span><%= MyBase.GetResourceString("C_LowRange") %></li>
                                            <li><span style="background-color: #f4cd0f"></span><%= MyBase.GetResourceString("C_MidRange") %></li>
                                            <li><span style="background-color: #eb1c24"></span><%= MyBase.GetResourceString("C_UPRange") %></li>

                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <table id="sqertListTbl" class="table table-bordered profiencyTbllist" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th class="text-start"><%= MyBase.GetResourceString("C_ProjectName") %></th>
                                        <th><%= MyBase.GetResourceString("C_ReportingDate") %></th>
                                        <th><%= MyBase.GetResourceString("C_Scope") %></th>
                                        <th><%= MyBase.GetResourceString("C_Quality") %></th>
                                        <th><%= MyBase.GetResourceString("C_Effort") %></th>
                                        <th><%= MyBase.GetResourceString("C_Risk") %></th>
                                        <th><%= MyBase.GetResourceString("C_Time") %></th>
                                        <th><%= MyBase.GetResourceString("C_ProjectOverview") %></th>
                                    </tr>
                                </thead>
                                <tbody id="tblsqert">
                                </tbody>
                            </table>
                            <div class="clearfix"></div>
                            <p>
                                <strong><%= MyBase.GetResourceString("C_NotLocked") %> </strong>
                                <label id="lblName2"></label>
                            </p>

                            <table id="healthshetprojectList" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th class="text-start"><%= MyBase.GetResourceString("C_ProjectName") %></th>
                                        <th width="200"><%= MyBase.GetResourceString("C_ProStartDate") %></th>
                                        <th width="200"><%= MyBase.GetResourceString("C_ProEndDate") %></th>
                                    </tr>
                                </thead>
                                <tbody id="tblAllProjectHealthSheetData">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse3" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse3">
                                <%= MyBase.GetResourceString("C_KeyAchievement") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse3" class="panel-collapse collapse">
                        <div class="panel-body clearfix">
                            <div id="PHSDetailtabTwo" class="tab-pane">

                                <table class="table table-bordered" id="KeyAchievementTBL" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th><%= MyBase.GetResourceString("C_TotalPlanned") %></th>
                                            <th><%= MyBase.GetResourceString("C_Completed") %></th>
                                            <th><%= MyBase.GetResourceString("C_NextMonthRepPeriod") %></th>
                                            <th><%= MyBase.GetResourceString("C_TaskSlipping") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblkeyachievementbody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>



                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse4" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse4">
                                <%= MyBase.GetResourceString("C_IssueDetails") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse4" class="panel-collapse collapse">
                        <div class="panel-body clearfix">
                            <div id="PHSDetailtab5" class="tab-pane">

                                <table class="table table-bordered" id="IssueDetailsTBL" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th colspan="5"><%= MyBase.GetResourceString("C_IssueDetails") %></th>
                                            <th colspan="3"><%= MyBase.GetResourceString("C_AgeingAnalysis") %></th>
                                            <th><%= MyBase.GetResourceString("C_ShownToCustomer") %></th>
                                            <th><%= MyBase.GetResourceString("C_TotalOverdueIssues") %></th>
                                        </tr>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("C_IssueType") %></th>
                                            <th><%= MyBase.GetResourceString("C_Open") %></th>
                                            <th><%= MyBase.GetResourceString("C_Closed") %></th>
                                            <th><%= MyBase.GetResourceString("C_Others") %></th>
                                            <th><%= MyBase.GetResourceString("C_Total") %></th>
                                            <th><%= MyBase.GetResourceString("C_5days") %></th>
                                            <th><%= MyBase.GetResourceString("C_5to10") %></th>
                                            <th><%= MyBase.GetResourceString("C_More10") %></th>
                                            <th>&nbsp;</th>
                                            <th>&nbsp;</th>
                                        </tr>
                                    </thead>
                                    <tbody id="issuedetailbody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse5" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse5">
                                <%= MyBase.GetResourceString("C_SQERT") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse5" class="panel-collapse collapse">
                        <div class="panel-body clearfix">
                            <div id="PHSDetailtab4" class="tab-pane">
                                <table class="table table-bordered" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th width="100"><%= MyBase.GetResourceString("C_Title") %></th>
                                            <th width="100"><%= MyBase.GetResourceString("C_Value") %></th>
                                            <th width="100"><%= MyBase.GetResourceString("C_Rating") %></th>
                                            <th width="100"><%= MyBase.GetResourceString("C_Trend") %></th>
                                            <th class="text-start"><%= MyBase.GetResourceString("C_Description") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblSQERTSection">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse6" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse6">
                                <%= MyBase.GetResourceString("C_Milestone") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse6" class="panel-collapse collapse">
                        <div class="panel-body clearfix">
                            <div id="PHSDetailtab5" class="tab-pane ">

                                <table class="table table-bordered" id="tblMileStoneDetails" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("C_MilestoneName") %></th>
                                            <th><%= MyBase.GetResourceString("C_ReadyForBilling") %></th>
                                            <th><%= MyBase.GetResourceString("C_Amount") %></th>
                                            <th><%= MyBase.GetResourceString("C_PlanStartDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_PlanCompletionDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_ActualStartDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_ActualEndDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_SlippageDays") %></th>
                                            <th><%= MyBase.GetResourceString("C_MilestoneStatus") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="MileStoneBinding">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse7" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse7">
                                <%= MyBase.GetResourceString("C_Baseline") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse7" class="panel-collapse collapse">
                        <div class="panel-body clearfix">
                            <div id="PHSDetailtab6" class="tab-pane ">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="tblBaseline" style="width: 100%;">
                                        <thead>
                                            <tr>
                                                <th width="400"><%= MyBase.GetResourceString("C_ReasonForChange") %></th>
                                                <th><%= MyBase.GetResourceString("C_ChagedDate") %></th>
                                                <th><%= MyBase.GetResourceString("C_EstimatedEffort") %></th>
                                                <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                            </tr>
                                        </thead>
                                        <tbody id="baselinetbody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse8" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse8">
                                <%= MyBase.GetResourceString("C_ActiveResource") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse8" class="panel-collapse collapse">
                        <div class="panel-body clearfix">
                            <div id="PHSDetailtab8" class="tab-pane ">

                                <table class="table table-bordered" id="tblActiveResource" style="width: 100%;" style="margin-bottom: 15px;">
                                    <thead>
                                        <tr>
                                            <th width="400"><%= MyBase.GetResourceString("C_Resource") %></th>
                                            <th><%= MyBase.GetResourceString("C_StartDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_EndDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_WorkHrs") %></th>
                                            <th><%= MyBase.GetResourceString("C_ActualWorkHrs") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="ActiveResourceDetail">
                                    </tbody>
                                </table>
                                <br />
                                <br />
                                <div class="ECdetailpanel" id="EVdetailpanel">
                                    <h6><%= MyBase.GetResourceString("C_EarnValueReport") %></h6>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="EVDetaltabl">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-start"><%= MyBase.GetResourceString("C_EVDetails") %></th>
                                                            <th class="text-end">&nbsp;</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="EVDetaltablbody">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="chartcontainer">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h4 class="panel-title"><%= MyBase.GetResourceString("C_EarnedValueAnalysis") %>
                                                        </h4>
                                                    </div>
                                                    <div class="panel-collapse">
                                                        <div class="panel-body clearfix">
                                                            <canvas id="EVAnalysisChart" height="175"></canvas>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>


                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <!-- Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                        <h4 class="panel-title">
                            <a role="button" data-bs-toggle="collapse" data-parent="#accordion" href="#Phscollapse9" aria-expanded="false" aria-controls="collapseOne" id="ClickPhscollapse9">
                                <%= MyBase.GetResourceString("C_Graphs") %>
                                <span class="infoToggler togglerdown float-end">
                                    <img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="collapsedown" width="15px" data-original-title="View Details">
                                    <img class="collapseup" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" width="15px" data-original-title="Hide Details">
                                </span>
                            </a>
                        </h4>
                        <!-- End of Added By Gauri On 22th Aug 2024 For Alignment Issue -->
                    </div>
                    <div id="Phscollapse9" class="panel-collapse collapse">
                        <div class="panel-body clearfix">
                            <div id="PHSDetailtab9" class="tab-pane ">

                                <div class="graphwrapper row">
                                    <div class="col-sm-4 chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3><%= MyBase.GetResourceString("C_TotalvsCompletion") %></h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="CompletionstatusGraph" height="245"></canvas>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-4 chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3><%= MyBase.GetResourceString("C_TotalvsDelay") %></h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="DelayinDayschart" height="245"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 chartbox">
                                        <div class="box box-panel box-solid">
                                            <div class="box-header boxheaderblue with-border">
                                                <h3><%= MyBase.GetResourceString("C_MonthlyResourceCost") %></h3>
                                            </div>
                                            <div class="box-body text-center">
                                                <canvas id="MonthlyResourceCostChart" height="245"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!-------New code end here-->
            <!------------old code-->
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SaveFilterAs") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Issuesavrefilterbox" class="box-panel">

                            <div class="box-body">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <%--<label class="control-label col-md-4 p-0 text-end">Filter Name :</label>--%>
                                            <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_FilterName") %> <span id="MandatoryFilterName" style="color: red">* </span>:</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",,,,,, ,,,, "PlaceHolder = 'Enter Filter Name (Maxlength 100 Char)' autocomplete='Off' maxlength='100' onkeypress='return restrictSpecialChars(event)' onpaste='return false'",,, True,,,,) %>
                                                <%--<input type="text" class="form-control" name=""><br />--%>
                                                <br />
                                                <div class="btnrow">
                                                    <button id="savefilterbtn" class="btn btnyellow float-start" onclick="saveFilter()">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
                                                </div>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Save filter Modal End here-->


        <div class="modal custmodal fade" id="UpdateSQERTModal" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_PHSInformation") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs main_graybgtbs">
                            <li class="nav-item"><a class="nav-link active" href="#UpdateSQERTtab1" data-bs-toggle="tab"><%= MyBase.GetResourceString("C_ProjectHealthSheet") %></a></li>
                            <li class="nav-item"><a class="nav-link" href="#UpdateSQERTtab2" data-bs-toggle="tab" onclick="ShowHistory()"><%= MyBase.GetResourceString("C_History") %></a></li>

                        </ul>

                        <div class="tab-content pt-1">
                            <div id="UpdateSQERTtab1" class="tab-pane fade in active show">
                                <div class="text-end pb-1">
                                    <!-- Removed class By Gauri On 22th Aug 2024 For Button color Issue -->
                                    <button class="btn borderbtn" onclick="SaveUpdatedSQERTValue()"><%= MyBase.GetResourceString("C_UpdateSQERTValues") %></button>
                                    <a href="javascript:;" class="btn borderbtn" id="insidehelpdetails" title="" data-bs-placement="bottom" data-original-title="Help" onclick="GetPHSHelpDetails('3068')">?</a>
                                </div>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th width="200"><%= MyBase.GetResourceString("SQERT") %></th>
                                            <th width="100"><%= MyBase.GetResourceString("C_Value") %></th>
                                            <th><%= MyBase.GetResourceString("C_Description") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblinsidewindowsqertdetails">
                                        <tr>
                                            <td class="text-start"><%= MyBase.GetResourceString("C_SScope") %></td>

                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextBox("txtScope", "txtScope", "form-control",, 0,,,,,,,, "onkeypress='return Field_OnKeyPress(event)' oncopy='return false' onpaste='return false'  autocomplete='off'", , , True,,,, True) %>
                                                <label class="required"></label>
                                            </td>

                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextArea("txtScopeDesc", "txtScopeDesc", "Enter Scope Details", "form-control",,,,, , ,,,,,,,,,,, ,,,,,,,,) %>
                                                <label class="required"></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-start"><%= MyBase.GetResourceString("C_QQuality") %></td>


                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextBox("txtQuality", "txtQuality", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPress(event)' oncopy='return false' onpaste='return false'  autocomplete='off'",,, True,,,, True) %>
                                                <label class="required"></label>
                                            </td>
                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextArea("txtQualityDesc", "txtQualityDesc", "Enter Quality Details", "form-control",,,,, , ,,,,,,,,,,,,,,,,,,,) %>
                                                <label class="required"></label>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="text-start"><%= MyBase.GetResourceString("C_EEffort") %></td>


                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextBox("txtEffort", "txtEffort", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPress(event)' oncopy='return false' onpaste='return false' autocomplete='off' readonly ",,, True,,,, True) %>
                                                <label class="required"></label>
                                            </td>
                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextArea("txtEffortDesc", "txtEffortDesc", "Enter Effort Details", "form-control",,,,, , ,,,,,,,,,,,,,,,,,,,) %>
                                                <label class="required"></label>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="text-start"><%= MyBase.GetResourceString("C_RRisk") %></td>


                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextBox("txtRisk", "txtRisk", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPress(event)' oncopy='return false' onpaste='return false' autocomplete='off' readonly",,, True,,,, True) %>
                                                <label class="required"></label>
                                            </td>
                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextArea("txtRiskDesc", "txtRiskDesc", "Enter Risk Details", "form-control",,,,, , ,,,,,,,,,,,,,,,,,,,) %>
                                                <label class="required"></label>
                                            </td>


                                        </tr>
                                        <tr>
                                            <td class="text-start"><%= MyBase.GetResourceString("C_TTime") %></td>


                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextBox("txtTime", "txtTime", "form-control",,,,,,,,,, "onkeypress='return Field_OnKeyPress(event)' oncopy='return false' onpaste='return false' autocomplete='off' readonly",,, True,,,, True) %>
                                                <label class="required"></label>
                                            </td>
                                            <td class="mandatoryfieldsTD"><% CommonFunctions.HTMLControls.DrawTextArea("txtTimeDesc", "txtTimeDesc", "Enter Time Details", "form-control",,,,, , ,,,,,,,,,,,,,,,,,,,) %>
                                                <label class="required"></label>
                                            </td>


                                        </tr>

                                    </tbody>
                                </table>

                                <h5 class="TblHeadingBlue"><%= MyBase.GetResourceString("C_GenRemarkAndEsc") %></h5>
                                <table class="table table-bordered">
                                    <tbody id="tblGeneralRemarksAndEscalations">
                                        <tr>
                                            <td class="text-start" width="160"><%= MyBase.GetResourceString("C_GeneralRemarks") %></td>

                                            <td><% CommonFunctions.HTMLControls.DrawTextArea("txtGeneralRemark", "txtGeneralRemark", , "form-control",,,,, , ,,,,,,,,,,,,,,,,,,,) %></td>

                                        </tr>
                                        <tr>
                                            <td class="text-start"><%= MyBase.GetResourceString("C_Escalations") %></td>

                                            <td><% CommonFunctions.HTMLControls.DrawTextArea("txtEscalation", "txtEscalation", , "form-control",,,,, , ,,,,,,,,,,,,,,,,,,,) %></td>

                                        </tr>
                                    </tbody>
                                </table>

                                <div class="notebox graybg">
                                    <p><strong><%= MyBase.GetResourceString("C_Note") %></strong></p>
                                    <ul>
                                        <li><%= MyBase.GetResourceString("C_EEEffort") %></li>
                                        <li><%= MyBase.GetResourceString("C_QQQuality") %></li>
                                        <li><%= MyBase.GetResourceString("C_RRRisk") %></li>
                                        <li><%= MyBase.GetResourceString("C_SSScope") %></li>
                                        <li><%= MyBase.GetResourceString("C_TTTime") %></li>
                                    </ul>
                                </div>
                            </div>
                            <div id="UpdateSQERTtab2" class="tab-pane fade">
                                <div class="text-end pb-1">
                                    <a href="javascript:;" class="btn borderbtn" onclick="GetPHSHelpDetails('3068')">?</a>
                                </div>
                                <%--<h5>Recorded SQERT Locking History for the Project : Entry Gate Automation</h5>--%>
                                <p>
                                    <%= MyBase.GetResourceString("C_SQERTLockingHistory") %>
                                    <label id="lblProjectName"></label>
                                </p>

                                <table class="table table-bordered UpSQERTtbl" id="showHistoryTBL">
                                    <thead>
                                        <tr>
                                            <th><%= MyBase.GetResourceString("C_ReportingDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_LockedDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_Scope") %></th>
                                            <th><%= MyBase.GetResourceString("C_Quality") %></th>
                                            <th><%= MyBase.GetResourceString("C_Effort") %></th>
                                            <th><%= MyBase.GetResourceString("C_Risk") %></th>
                                            <th><%= MyBase.GetResourceString("C_Time") %></th>
                                            <th><%= MyBase.GetResourceString("C_Comments") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblShowHistory">
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <div class="form-group">&nbsp;</div>
                        <div class="form-group text-center">
                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Cancel") %></button>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--end modal popup-->
        <!-- Issue detail Modal start here-->
        <div class="modal custmodal" id="PHSopenissuedetailModal" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_IssueDetails") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Issuesavrefilterbox" class="box-panel">
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <h5 class="float-start"><strong><%= MyBase.GetResourceString("C_Project") %> :</strong> <strong><span id="lblIssuepopProjectName"></span></strong></h5>
                                    </div>
                                    <div class="col-sm-3">
                                        <h5><%= MyBase.GetResourceString("C_IssueDetails") %>(<span id="lblIssueDetails"></span>)</h5>
                                    </div>
                                    <div class="col-sm-5"><span class="float-end" style="margin-top: 8px;"><small><%= MyBase.GetResourceString("C_SlippageOROverdue") %></small></span></div>

                                    <div class="clearfix"></div>
                                </div>
                                <div class="table-responsive" style="max-height: 280px;">
                                    <table class="table table-bordered phsOpenIssuTbl" id="IndividualIssueDTBL" style="width: 100%;">
                                        <thead style="position: sticky; top: 0" class="thead-dark">
                                            <tr>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_SrNo") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_IssueID") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_Summary") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_ReportedDate") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_IssueType") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_SubType") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_Priority") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_Severity") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_Status") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_DueDate") %></th>
                                                <th class="header" scope="col"><%= MyBase.GetResourceString("C_ReportedBy") %></th>
                                            </tr>
                                        </thead>
                                        <tbody id="individualissuedetablbody">
                                        </tbody>
                                    </table>
                                </div>


                                <div class="btnrow text-center">
                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Issue detail Modal End here-->


        <div class="clearfix"></div>

    </div>

    <!-- REQUIRED JS SCRIPTS -->

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>


    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>

    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>

    <!-- Alertify added by Vidhi-->
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <!--For Simple Pagination-->

    <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>
    <%--<script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>

    <script>
        //Added By Riddhesh Patil on 15-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        var today = new Date();
        var Xdate = $.datepicker.formatDate('dd-mm-yy', today);
        document.getElementById('lblName').innerHTML = Xdate;
        document.getElementById('lblName2').innerHTML = Xdate;


        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        //Initialize bootstrap tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl, {
                trigger: 'hover'
            });
        });

        $("body").on("click", ".nav-tabs [data-bs-toggle='dropdown']", function () {
            $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
            $(this).closest(".nav-tabs']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

        });

        $('body').on('click', function (e) {
            $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
                // hide any open popovers when the anywhere else in the body is clicked
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
                    $(".nav-tabs .dropdown-menu").removeClass('show');
                }
            });
        });

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").hover(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');
        }); //added by pradip on 24-3-2023


        function editPHSDetail() {

            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'slow');
            //used for disable grid
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });


        /// Lines of code added for hide tool tip 

        //cleartooltip
        $('body').tooltip({
            selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
        });

        /// end of lines of code added for hide tool tip 

        var ProjectID = 0;
        var temp;
        var insideActiveresource;
        var inputDate;
        var dateObjectName = new Date();
        var listofallprojects = new Array();
        var dataAfterProjectselection = new Array();
        var InsideFilterProjectID = 0;
        var module = "PHS";
        var ColumnNamelst = ["ProjectType", "BusinessGroup", "OrganizationUnit", "ProjectGroupName", "ProjectName", "ReportingDate"];
        var holddelaydays = new Array();
        var strPhaseQuery = "";
        var PhaseQueryText = null;
        var GlobalFilterName;
        var FilterID;
        var GlobalApplyID;
        var defaultProjectIDHolder = new Array();
        var GetAllProjectExpectedEndDate = new Array(); // This array holds all the accessible project data like projectName, ExpectedStartDate, ExpectedEndDate
        var DefaultSetProjectID;
        var FilterPracticedataobj = new Array();
        var onchangeChecker = 0; // This Variable is used to find out somthing taken from inner drop down 
        var FromEditOptionHolder = 0; // This varible helps to find out in the saving part from which drop dwon value
        var ChangedDateHolder;
        var DatepickerOnChangeChecker = 0;
        var OuterDropdownOnChangeIndicator = 0;// this variable is showing outerdrop down onchange is performed or not
        var OuterDropdownOnChangeProjectID;
        // For Scope Range
        var ScopeLoweLow;
        var ScopeLoweHigh;
        var ScopeMiddleLow;
        var ScopeMiddleHigh;
        var ScopeUpperLow;
        var ScopeUpperHigh;
        // For Quality Range
        var QualityLoweLow;
        var QualityLoweHigh;
        var QualityMiddleLow;
        var QualityMiddleHigh;
        var QualityUpperLow;
        var QualityUpperHigh;
        // For Effort
        var EffortLoweLow;
        var EffortLoweHigh;
        var EffortMiddleLow;
        var EffortMiddleHigh;
        var EffortUpperLow;
        var EffortUpperHigh;
        //For Risk
        var RiskLoweLow;
        var RiskLoweHigh;
        var RiskMiddleLow;
        var RiskMiddleHigh;
        var RiskUpperLow;
        var RiskUpperHigh;

        // For Time
        var TimeLoweLow;
        var TimeLoweHigh;
        var TimeMiddleLow;
        var TimeMiddleHigh;
        var TimeUpperLow;
        var TimeUpperHigh;

        var DTime;
        var DEffort;
        var DRisk;
        var GlSQERTID;
        var GPName;
        var OtherDetailsofprojectholder = new Array();
        // Variables used for issue detail section
        var issuedetailscurrentProjectid;
        var CID;
        var PGID;
        var BGID;
        var OUID;
        var insidepopupissuedetailprojectname;
        var SelectedProjectID; // selected project
        var PageTagID = 3068;
        var EditFilterID;
        var FrequencyID = 0;
        $(document).ready(function () {
            //StartLoader("#bdyNewProjectHealthSheet");
            //$("#AdvanceFilterIcon").removeClass('activefilter');

            GetListOfProject();
            CheckDefaultFilterAppliedOrNot();
            GetSQERTRangs();
            CallFilterFunctions();
            if (DefaultSetProjectID != null && DefaultSetProjectID != undefined && DefaultSetProjectID != "") {
                SelectedProjectID = DefaultSetProjectID;
            }
            else {
                SelectedProjectID = encodeURI('<%= Session("intProjectID") %>');
            }

            //commented And Added by imran on 09-02-2022
            getProjectHealthSheetInformation(SelectedProjectID);
            //Added By dipali V n 10th feb 2022 for get list of till not project
            ProjectLockingBinding(SelectedProjectID);
            //End of Added By dipali V n 10th feb 2022 for get list of till not project

            //callAllFunction(SelectedProjectID);
            bindAllProjectsTillDate(SelectedProjectID);

            //End Of comment by imran on 09-02-2022

            $("#filterpanel").removeClass('in');
            $("#basicfilters").removeClass("active");

            //StopAjaxLoader("#bdyNewProjectHealthSheet");
            <%--Added by imran on 19-09-2022--%>
            $("#divPMResource").removeClass("center");
            $("#divPMResource").removeClass("preloader");
            $(".bgwhite").removeClass('clsShowHide');
            <%--End by imran on 19-09-2022--%>
        });


        //Added by imran on 09-02-2022 For Performance Related
        $('#ClickPhscollapse2').click(function () {
            //SQERT Details Start 
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            bindAllProjectsTillDate(ProjectId);
            getSQERTDetails(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
            //SQERT Details End 
        });

        // For Key Achievement section
        $('#ClickPhscollapse3').click(function () {
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            getTaskAndDeliverablesDetails(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });

        // For Issue Details section
        $('#ClickPhscollapse4').click(function () {
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            IssueDetails(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });

        // For SQERT section
        $('#ClickPhscollapse5').click(function () {
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            SQERTSection(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });

        // For milestonesection
        $('#ClickPhscollapse6').click(function () {
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            ListOfMilestone(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });

        // For baseline section
        $('#ClickPhscollapse7').click(function () {
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            baselinedetails(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });

        // For active resource section  
        $('#ClickPhscollapse8').click(function () {
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            GetListOfActiveResource(ProjectId);
            CheckEvIsApplicable(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });

        // For First graph
        $('#ClickPhscollapse9').click(function () {
            var ProjectId = $("#CboProject").val();
            StartLoader("#bdyNewProjectHealthSheet");
            getGraphTaskVsCompletion(ProjectId);
            DelayInDys(ProjectId);
            MonthlyResourceCost(ProjectId);
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });
        //End Of Comment By imran on 09-02-2022


        function callAllFunction(Projectid) {
            StartLoader("#bdyNewProjectHealthSheet");

            $("#CboProject").val(Projectid);
            getProjectHealthSheetInformation(Projectid);// For Project Information section
            //Added By dipali V n 10th feb 2022 for get list of till not project
            ProjectLockingBinding(Projectid);
            //End of Added By dipali V n 10th feb 2022 for get list of till not project
            bindAllProjectsTillDate(Projectid);
            getSQERTDetails(Projectid); // For SQERT Detail section
            getTaskAndDeliverablesDetails(Projectid); // For Key Achievement section
            IssueDetails(Projectid); // For Issue Details
            SQERTSection(Projectid);// For SQERT section
            ListOfMilestone(Projectid); // For milestonesection
            baselinedetails(Projectid); // For baseline section
            GetListOfActiveResource(Projectid);// For active resource section                          
            getGraphTaskVsCompletion(Projectid);// For First graph
            DelayInDys(Projectid);// For graph
            MonthlyResourceCost(Projectid);// For Graph
            CheckEvIsApplicable(Projectid);

            $("#filterpanel").removeClass('in');
            $("#basicfilters").removeClass("active");

            StopAjaxLoader("#bdyNewProjectHealthSheet");
        }

        // Code added by VIDHI on  23/11/2020
        $("#CboProject").on('change', function () {
            StartLoader("#bdyNewProjectHealthSheet");
            $("#filterpanel").removeClass('in');
            $("#basicfilters").removeClass("active");
            OuterDropdownOnChangeIndicator = 1;
            OuterDropdownOnChangeProjectID = "";
            ProjectID = $("#CboProject").val();
            OuterDropdownOnChangeProjectID = ProjectID;
            CheckDefaultFilterAppliedOrNot();

            if (ProjectID == 'Select Project') {
                ProjectID = "0";
                $('#UpdateSQERT').css('pointer-events', 'none');
                $('#UpdateSQERT').attr('disabled', true);
                jQuery("select#CboProject option[value='Select Project']").attr('selected', 'selected');
            } else {
                $('#UpdateSQERT').css('pointer-events', 'auto');
                $('#UpdateSQERT').attr('disabled', false);
            }
            if (ProjectID == "0" || ProjectID == null) {
                ProjectID = "0";

                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_SelectProject") %>');
                //StopAjaxLoader("#bdyNewProjectHealthSheet"); 

            } else {
                //callAllFunction(ProjectID);
            }

            //Commented And Added by imran on 09-02-2022
            //callAllFunction(ProjectID);
            getProjectHealthSheetInformation(ProjectID);

            $(".accordianinfopanel .panel-collapse").collapse('hide');
            $("#PhscollapseOne").collapse('show');
            //End Of Comment by imran on 09-02-2022

            $("#txtPHSFilterProjectName").val('Select Project');
            $("#txtPHSFilterLocation").val('Select Organization Unit');
            $("#txtPHSFilterProjectType").val('Select Practice');
            $("#txtPHSFilterBusinessGroup").val('Select Business Group');
            $("#txtPHSFilterProjectGroupName").val('Select Project Group');
            $("#txtPHSFilterReportingDate").datepicker('setDate', new Date());
            StopAjaxLoader("#bdyNewProjectHealthSheet");
        });

        //Added by imran on 09-02-2022 for Panel Collaps
        $(".accordianinfopanel .panel-title a").click(function () {
            $(".accordianinfopanel .panel-collapse").collapse('hide');
            $(this).closest(".accordianinfopanel .panel-collapse").collapse('show');
        });
        //End Of Comment 09-02-2022

        // function for filter 
        function CallFilterFunctions() {
            PracticeFilter();
            BGFilter();
            FilterOU();
            FilterPG();
            FilterReportingPeriod();
            FilterProjectBinding();

        }


        function CallApplyFunction() {
            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            if (InsideFilterProjectID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_SelectProject") %>');
            } else {
                callAllFunction(InsideFilterProjectID);
                $(".clearalllink").css("display", "inline-block");
                $(".filter button").css({ 'background': '#1359ac', 'color': '#fff' });

            }
            //$("#filterpanel").removeClass('in');
            //$("#basicfilters").removeClass("active");
        }


        $("#txtPHSFilterBusinessGroup").on('change', function () {

            $("#txtPHSFilterLocation").html("");
            $("#txtPHSFilterLocation").append('<option value="0">Select Organization Unit</option>');

            $("#txtPHSFilterProjectName").html("");
            $("#txtPHSFilterProjectName").append('<option value="0">Select Project</option>');
            var BusinessGroupIDG = $("#txtPHSFilterBusinessGroup").val();
            if (BusinessGroupIDG == "0" || BusinessGroupIDG == null) {
                BusinessGroupIDG = 0;
            }
            FilterOU();
            FilterProjectBinding();

        });

        $("#txtPHSFilterProjectType").on('change', function () {


            $("#txtPHSFilterProjectName").html("");
            $("#txtPHSFilterProjectName").append('<option value="0">Select Project</option>');
            var PracticeID = $("#txtPHSFilterProjectType").val();
            if (PracticeID == "0" || PracticeID == null) {
                PracticeID = 0;
            }

            FilterProjectBinding();
        });

        $("#txtPHSFilterLocation").on('change', function () {


            $("#txtPHSFilterProjectName").html("");
            $("#txtPHSFilterProjectName").append('<option value="0">Select Project</option>');
            var LocationID = $("#txtPHSFilterLocation").val();
            if (LocationID == "0" || LocationID == null) {
                LocationID = 0;
            }

            FilterProjectBinding();
        });

        $("#txtPHSFilterProjectGroupName").on('change', function () {


            $("#txtPHSFilterProjectName").html("");
            $("#txtPHSFilterProjectName").append('<option value="0">Select Project</option>');
            var ProjectGroupID = $("#txtPHSFilterProjectGroupName").val();
            if (ProjectGroupID == "0" || ProjectGroupID == null) {
                ProjectGroupID = 0;
            }

            FilterProjectBinding();

        });





        $("#txtPHSFilterProjectName").on('change', function () {

            onchangeChecker = 1;
            var ProjectID = $("#txtPHSFilterProjectName").val();
            InsideFilterProjectID = ProjectID;



            if (ProjectID == 'Select Project') {
                ProjectID = 0;
            }
            if (ProjectID == "0") {
                $("#txtPHSFilterBusinessGroup").html("");
                $("#txtPHSFilterBusinessGroup").append('<option value="0">Select BusinessGroup </option>');
                $("#txtPHSFilterProjectType").html("");
                $("#txtPHSFilterProjectType").append('<option value="0">Select Practice </option>');
                $("#txtPHSFilterLocation").html("");
                $("#txtPHSFilterLocation").append('<option value="0">Select Organization Unit </option>');
                $("#txtPHSFilterProjectGroupName").html("");
                $("#txtPHSFilterProjectGroupName").append('<option value="0">Select Project Group </option>');


            } else {


                FetchSelectedDataBasedOnProjectId(ProjectID);

            }
            //MyFilterList();

        });









        function FetchSelectedDataBasedOnProjectId(id) {

            var pid = id;
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var date = $('#txtPHSFilterReportingDate').datepicker().val();


            var ListOfProjectParameter = {

                UserID: Userid,
                LoginType: Logintype,
                ProjectId: pid,
                CurrentDate: date,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FilterDataDisplay',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        for (var i = 0; i < result.length; i++) {
                            var obj = result[i];

                            var ProjectTypeID = obj.ProjectTypeID;
                            var ProjectGroupID = obj.ProjectGroupID;
                            var BusinessGroupID = obj.BusinessGroupID;
                            var LocationID = obj.LocationID;
                        }
                        $("#txtPHSFilterProjectType").val(ProjectTypeID);
                        $("#txtPHSFilterBusinessGroup").val(BusinessGroupID);
                        $("#txtPHSFilterLocation").val(LocationID);
                        $("#txtPHSFilterProjectGroupName").val(ProjectGroupID);

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                //alert(ex.text);
            }


        }




        function PracticeFilter() {

            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var ListOfProjectParameter = {

                UserID: Userid,
                LoginType: Logintype,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetPHSFilterData',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        FilterPracticedataobj = result;

                        $.each(result, function () {
                            $("#txtPHSFilterProjectType").append($("<option></option>").val(this['TypeId']).html(this['ProjectType']));

                        });

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }

        function BGFilter() {
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var ListOfProjectParameter = {

                UserID: Userid,
                LoginType: Logintype,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetPHSBGFilter',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {


                        $.each(result, function () {
                            $("#txtPHSFilterBusinessGroup").append($("<option></option>").val(this['BusinessGroupID']).html(this['BusinessGroup']));

                        });

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }



        function FilterOU() {
            var Selectedbg = $("#txtPHSFilterBusinessGroup").val();
            //added by imran on 14-09-2022
            if (Selectedbg == "Select Business Group") {
                Selectedbg = 0;
            }
            //End of comment by imran on 15-09-2022

            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var ListOfProjectParameter = {
                SelectedBG: Selectedbg,
                UserID: Userid,
                LoginType: Logintype,
            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetPHSOUFilter',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {


                        $.each(result, function () {
                            $("#txtPHSFilterLocation").append($("<option></option>").val(this['LocationID']).html(this['Location']));

                        });


                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }

        function FilterPG() {

            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var ListOfProjectParameter = {

                UserID: Userid,
                LoginType: Logintype,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetPHSProjectGroupFilter',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {


                        $.each(result, function () {
                            $("#txtPHSFilterProjectGroupName").append($("<option></option>").val(this['ProjectGroupID']).html(this['ProjectGroupName']));

                        });

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }

        }

        function FilterReportingPeriod() {

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetPHSReportingPeriod',// Path
                    type: "POST",                                       //HTTP TYPE get /post                       
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    },
                    async: false,
                    success: function (result) {

                        for (var i = 0; i < result.length; i++) {
                            var obj = result[i];
                            var frequency = obj.Frequency;
                            FrequencyID = obj.FrequencyID;
                        }


                        $('#lblReportingPeriod').text(frequency);
                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                //alert(ex.text);
            }

        }


        function FilterProjectBinding() {

            var selectedpractice = $("#txtPHSFilterProjectType").val();
            if (selectedpractice == "Select Practice") {
                selectedpractice = 0;
            }
            var selectedbgid = $("#txtPHSFilterBusinessGroup").val();
            if (selectedbgid == "Select Business Group") {
                selectedbgid = 0;
            }
            var selectedouid = $("#txtPHSFilterLocation").val();
            if (selectedouid == "Select Organization Unit") {
                selectedouid = 0;
            }
            var selectedpgid = $("#txtPHSFilterProjectGroupName").val();
            if (selectedpgid == "Select Project Group") {
                selectedpgid = 0;
            }
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var selectedpid = $("#txtPHSFilterProjectName").val();
            if (selectedpid == "Select Project") {
                selectedpid = 0;
            }
            var Logintype = encodeURI('<%= Session("LoginType") %>');

            var ListOfProjectParameter = {
                PracticeID: selectedpractice,
                BusinessID: selectedbgid,
                LocationID: selectedouid,
                ProjectGroupID: selectedpgid,
                UserID: Userid,
                ProjectID: selectedpid,
                LoginType: Logintype
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetFilterListOfProject',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        // GetAllProjectExpectedEndDate = result;

                        $.each(result, function () {
                            $("#txtPHSFilterProjectName").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                        });


                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                //alert(ex.text);
            }


        }


        ///////////////////Added By dipali V n 10th feb 2022 for get list of till not project

        function ProjectLockingBinding(Projectid) {


            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var Userid = encodeURI('<%= Session("intUserID") %>');
             var CID;
             var PGID;
             var BGID;
             var OUID;

             for (var j = 0; j < OtherDetailsofprojectholder.length; j++) {
                 var proid = OtherDetailsofprojectholder[j]["ProjectID"];
                 CID = OtherDetailsofprojectholder[j]["ProjectTypeID"];
                 PGID = OtherDetailsofprojectholder[j]["ProjectGroupID"];
                 BGID = OtherDetailsofprojectholder[j]["BusinessGroupID"];
                 OUID = OtherDetailsofprojectholder[j]["LocationID"];
             }

             var Userid = encodeURI('<%= Session("intUserID") %>');
             var selectedpid = $("#txtPHSFilterProjectName").val();
             var Logintype = encodeURI('<%= Session("LoginType") %>');
            var ListOfProjectParameter = {
                ProgramID: PGID,
                ProjectID: Projectid,
                CategoryID: CID,
                BusinessID: BGID,
                OrganizationID: OUID,
                ReportingEndDate: date,
                UserID: Userid,
                Logintype: Logintype
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/ProjectLockingBinding',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        GetAllProjectExpectedEndDate = result;

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                //alert(ex.text);
            }


        }

        //End of Added By dipali V n 10th feb 2022 for get list of till not project

        // Get the list of project and display in drop down 
        function GetListOfProject() {

            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var ListOfProjectParameter = {

                UserID: Userid,
                LoginType: Logintype,
            }


            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchListOfProject',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        listofallprojects = result;
                        $.each(result, function () {
                            $("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                        });

                        // This code is for highlight the session project

                        if (DefaultSetProjectID != null && DefaultSetProjectID != undefined && DefaultSetProjectID != "") {
                            $("#CboProject").val(DefaultSetProjectID);
                        } else {
                            var temp = encodeURI('<%= Session("intProjectID") %>');
                                $("#CboProject").val(temp);
                            }
                            // end here highlight the session project

                        },
                        error: function (ER) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                        }
                    });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }

        // end of Get the list of project and display in drop down 

        // Get the active resource in the active resouce section
        function GetListOfActiveResource(projectid) {

            var ListOfProjectParameter = {
                ProjectID: projectid,

            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchListOfActiveResource',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        if (result == '') {
                            var strHtml = "";
                            $("#tblActiveResource").dataTable().fnDestroy();
                            $('#ActiveResourceDetail').html('');
                            strHtml += '<tr>'
                            //Added By Dipali V on 29th march 2023 For Datatable Issue
                            //strHtml += '<td  class ="txtAlign" colspan="5">No data available in table</td>'
                            strHtml += '<td  class ="txtAlign" colspan="5">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                            strHtml += '</tr>'
                            $("#ActiveResourceDetail").html("");
                            $("#ActiveResourceDetail").html(strHtml);
                            $('#tblActiveResource').dataTable({
                                "scrollY": true,
                                "scrollX": true,
                                "pageLength": 5,
                                "lengthChange": false,
                                "bFilter": false,
                                "ordering": false,
                                "responsive": true,
                                "destroy": false,
                                "retrieve": true,
                                "responsive": true,
                            });

                        } else {
                            DisplayActiveResouce(result);
                        }

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }

        }
        // end of Get the active resource in the active resouce section

        // Display active resource in grid
        function DisplayActiveResouce(data) {
            var strHtml = "";
            var Body = "";
            $("#tblActiveResource").dataTable().fnDestroy();
            for (var i = 0; i < data.length; i++) {
                var Resource = data[i]["Resource"];
                var StartDate = data[i]["StartDate"];
                var EndDate = data[i]["EndDate"];
                var Work = data[i]["Work"];
                var ActualWork = data[i]["ActualWork"];
                strHtml += ' <tr>'
                strHtml += ' <td>' + Resource + '</td>'
                strHtml += ' <td>' + StartDate + '</td>'
                strHtml += ' <td>' + EndDate + '</td>'
                strHtml += ' <td>' + Work + '</td>'
                strHtml += ' <td>' + ActualWork + '</td>'
                strHtml += '</tr>'
            }
            Body += strHtml;
            $("#ActiveResourceDetail").html("");
            $("#ActiveResourceDetail").html(Body);
            $('#tblActiveResource').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,
            });
        }
        // End of Display active resource in grid 

        // Project Health Sheet Information

        function getProjectHealthSheetInformation(id) {

            var pid = id;
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var date = $('#txtPHSFilterReportingDate').datepicker().val();


            var ListOfProjectParameter = {
                UserID: Userid,
                LoginType: Logintype,
                ProjectID: pid,
                CurrentDate: date,

            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchPHSInformation',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (result != '') {
                            OtherDetailsofprojectholder = result;
                            BindProjectHealthSheetInformation(result);
                        }

                    },
                    error: function (ER) {

                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                //alert(ex.text);
            }
        }
        // End OF Project Health Sheet Information

        // Project Health Sheet Information Binding
        function BindProjectHealthSheetInformation(Data) {
            if (Data != null) {
                for (var i = 0; i < Data.length; i++) {
                    var FromDate = Data[i]["FromDate"];
                    var ToDate = Data[i]["ToDate"];
                    var ProjectName = Data[i]["ProjectName"];
                    var ProjectType = Data[i]["ProjectType"];
                    var BusinessGroup = Data[i]["BusinessGroup"];
                    var Location = Data[i]["Location"];
                    var ProjectGroupName = Data[i]["ProjectGroupName"];

                    $('#lblfromdate').text('');
                    $('#lbltodate').text('');
                    $('#lblbg').text('');
                    $('#lblou').text('');
                    $('#lblpg').text('');
                    $('#lblprojectname').text('');
                    $('#lblpractice').text('');

                    $('#lblfromdate').text(FromDate);
                    $('#lbltodate').text(ToDate);

                    if (BusinessGroup == '') {
                        $('#lblbg').text('-');
                    } else {
                        $('#lblbg').text(BusinessGroup);
                    }
                    if (Location == '') {
                        $('#lblou').text('-');
                    } else {
                        $('#lblou').text(Location);
                    }
                    if (ProjectGroupName == '') {
                        $('#lblpg').text('-');
                    } else {
                        $('#lblpg').text(ProjectGroupName);
                    }
                    $('#lblprojectname').text(ProjectName);
                    if (ProjectType == '') {
                        $('#lblpractice').text('-');
                    } else {
                        $('#lblpractice').text(ProjectType);
                    }
                    if (ProjectName == '') {
                        $('#lblfromdate').text('-');
                        $('#lbltodate').text('-');
                        $('#lblprojectname').text('-');
                    }
                }
            }

        }
        // End of Project Health Sheet Information Binding

        // Delay In days By Project

        function DelayInDys(Projectid) {

            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var ListOfProjectParameter = {
                ProjectID: Projectid,
                CurrentDate: date,
            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchDelayInDays',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        var arrlable = new Array();
                        var arrdata = new Array();
                        arrlable = [];
                        arrdata = [];
                        if (Projectid == 0) {
                            arrlable = [];
                            arrdata = [];
                            bindDelayIndays(arrlable, arrdata);
                        } else {

                            for (var i = 0; i < result.length; i++) {
                                arrlable.push(result[i].DelayInterval);
                                arrdata.push(result[i].DelayCount);
                            }
                            bindDelayIndays(arrlable, arrdata);
                        }
                    },
                    error: function (ER) {
                        // alert(ER.text);
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }


        }

        // End of Delay in days By project 

        // Function to bind Delay in days data into graph

        function bindDelayIndays(arrlable, arrdata) {

            var ctx = document.getElementById("DelayinDayschart").getContext("2d");

            var myBarChart = new Chart(ctx, {

                type: 'bar',
                data: {
                    labels: arrlable,// dynamic data bind  here
                    datasets: [{
                        label: "Delay Count",
                        text: "label",
                        backgroundColor: "#fbb03b",
                        data: arrdata// dyanamic data bind here
                    }]
                },
                options: {


                    title: {
                        display: true,
                        responsive: true,
                        //text: ''
                    },
                    barValueSpacing: 20,
                    scales: {
                        xAxes: [{
                            maxBarThickness: 50,
                            barPercentage: 0.6,
                        }],
                        yAxes: [{
                            maxBarThickness: 20,
                            ticks: {
                                max: 10,
                                min: 0
                            }
                        }]
                    },
                    responsive: true,

                },
                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }
            });

        }

        // end of Function to bind Delay in days data into graph

        // Monthly resource cost graph

        function MonthlyResourceCost(Projectid) {

            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var ListOfProjectParameter = {
                ProjectID: Projectid,
                CurrentDate: date,
            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchMonthlyResourceCost',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        var arrMonth = new Array();
                        var arrCost = new Array();
                        arrMonth = [];
                        arrCost = [];
                        if (Projectid == 0) {
                            arrMonth = [];
                            arrCost = [];
                            BindResourceCosToGraph(arrMonth, arrCost);
                        } else {
                            for (var i = 0; i < result.length; i++) {
                                arrMonth.push(result[i].Month);
                                arrCost.push(result[i].ResourceCost);

                            }

                            BindResourceCosToGraph(arrMonth, arrCost);
                        }

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }
        //end of Monthly resource cost graph

        //Binding Resouce cost to graph
        function BindResourceCosToGraph(armonth, arcost) {

            var ctx = document.getElementById("MonthlyResourceCostChart").getContext("2d");

            var myBarChart = new Chart(ctx, {
                type: 'bar',
                data: {

                    labels: armonth,
                    datasets: [{
                        label: "Resource Cost",
                        text: "label",
                        backgroundColor: "#fbb03b",

                        data: arcost
                    }]
                },

                options: {
                    title: {
                        display: true,
                        responsive: true,

                    },
                    barValueSpacing: 20,
                    scales: {
                        xAxes: [{
                            maxBarThickness: 50,
                            barPercentage: 0.6,
                        }],
                        yAxes: [{
                            maxBarThickness: 20,
                            ticks: {
                                max: 500,
                                min: 0
                            }
                        }]
                    },
                    responsive: true,

                },
                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',

                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }
            });

        }

        // End of binding resource cost to graph



        // Graph Total Tasks V/s Completion Status 

        function getGraphTaskVsCompletion(Projectid) {

            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var ListOfProjectParameter = {
                ProjectID: Projectid,
                CurrentDate: date,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchGraphTaskVsComplete',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        var arrperc = new Array();
                        var arrvalue = new Array();
                        arrperc = [];
                        arrvalue = [];

                        if (Projectid == 0) {
                            arrperc = [];
                            arrvalue = [];
                            TaskVsCompleteGraphBinding(arrperc, arrvalue);
                        } else {
                            for (var i = 0; i < result.length; i++) {
                                arrperc.push(result[i].ActualPercentComplete);
                                arrvalue.push(result[i].TotalTasks);
                            }
                            TaskVsCompleteGraphBinding(arrperc, arrvalue);
                        }

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }
        // End of graph Total Tasks V/s Completion Status


        // Chart binding for Total  Task VS Complete task
        function TaskVsCompleteGraphBinding(arrPer, arrValue) {

            var ctx1 = document.getElementById("CompletionstatusGraph");

            var myChart = new Chart(ctx1, {
                type: 'doughnut',
                data: {

                    labels: arrPer,
                    datasets: [{
                        label: '# 1',// here need to display all label

                        data: arrValue,
                        backgroundColor: [
                            '#afd037',
                            '#ffce56',
                            '#36a2eb',
                            '#eb1c24',
                            '#4bc0c0',
                            '#87c9eb',
                            '#cccccc',
                            '#36a2eb',
                            '#4373c7',
                            '#fec200'

                        ],
                        borderColor: [
                            '#fff',
                            '#fff',
                            '#fff',
                            '#fff',
                            '#fff',

                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    cutoutPercentage: 60,
                    responsive: false,
                    segmentShowStroke: true,
                    legend: {
                        display: true,
                        position: 'right',
                        labels: {
                            fontColor: "#000080",
                        }
                    },

                }
            });


        }
        // End of this function here 

        //datatable
        $('#healthshetprojectList').dataTable({
            "scrollY": true,
            "scrollX": true,
            "pageLength": 10,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,

        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#healthshetprojectList').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });

        $("#filterpanel").on("show.bs.collapse", function () {
            // $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            // $(".clearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }
        });

        //New script start here added by pradip
        function toggleIcon(e) {
            $(e.target)
                .prev('.panel-heading')
                .find(".infoToggler")
                .toggleClass('togglerdown togglerup');

        }
        $('.panel-group').on('hidden.bs.collapse', toggleIcon);
        $('.panel-group').on('shown.bs.collapse', toggleIcon);

        //// btn Save and Apply filter
        function btnSaveAndApplyFilter_Onclick() {

            var TagID = PageTagID;
            if (InsideFilterProjectID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_SelectProject") %>');

            }
            else {
                strPhaseQuery = GenerateBasicFilterQuery(module, ColumnNamelst);

                PhaseQueryText = strPhaseQuery

                if (strPhaseQuery.length > 0) {
                    $('#spanTagId').attr('value', 3068);
                    $("#Issuesavefilter").modal("show");
                }

            }
        }

        function GenerateBasicFilterQuery(module, AllFields) {

            var strqtext = "";
            for (var i = 0; i < AllFields.length; i++) {
                var strvalue = '';
                var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();

                strvalue = $("#txt" + module + "Filter" + AllFields[i]).val();
                if (strvalue != "" && strvalue != null && strOp != "" && strvalue != null && strOp != undefined && strvalue != undefined) {
                    if (strqtext != "") strqtext += " AND ";
                    if (strOp == "Contains") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += " ''%" + strvalue + "%''";
                    }
                    else if (strOp == "Ends With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += " ''%" + strvalue + "''";
                    }
                    else if (strOp == "Exact Word") {
                        strqtext += AllFields[i] + " = ";
                        strqtext += " ''" + strvalue + "''";
                    }
                    else if (strOp == "Not Contains") {
                        strqtext += AllFields[i] + " ";
                        strqtext += " NOT LIKE ''%" + strvalue + "%''";
                    }
                    else if (strOp == "Starts With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += " ''" + strvalue + "%''";
                    }
                    else {
                        strqtext += AllFields[i] + " ";
                        strqtext += strOp + " ''" + strvalue + "''";
                    }
                }
            }
            strqtext = strqtext.replace('Over', '[Over]');

            return strqtext;
        }

        // function to get all list of filter saved in table 

        function MyFilterList() {
            if (onchangeChecker == 0) {
                var Projectid = $("#CboProject").val();

            } else if (OuterDropdownOnChangeIndicator == 1) {
                var Projectid = OuterDropdownOnChangeProjectID;

            } else {
                var Projectid = $("#txtPHSFilterProjectName").val();
            }


            var userid = encodeURI('<%= Session("intUserID") %>');
            var logintype = encodeURI('<%= Session("LoginType") %>');

            var Parameters = {
                ProjectID: Projectid,
                TagID: PageTagID,
                LoginType: logintype,
                UserID: userid
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/MyFilterList',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {


                        MyFiltersListBinding(result);

                    },
                    error: function (ER) {
                        // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });

            }
            catch (ex) {
                // alert(ex.text);
            }
            $(".liALMyFiltersdropdown").removeClass("active");
            $("#liResourceALMyFiltersdropdown").addClass("active");


        }

        // end of function to get all list of filter saved in table 

        // Function to bind the  list of filter into UI 
        function MyFiltersListBinding(result) {


            var strHTML = "";
            $("#MyFiltersdropdown").html('');

            for (var i = 0; i < result.length; i++) {

                var FilterID = result[i]["FilterId"];
                var FilterName = result[i]["FilterName"];
                var QueryText = result[i]["QueryText"];
                var SetDefault = result[i]["SetDefault"];



                strHTML += ' <li>'
                if (SetDefault == true) {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2"  onclick="SetDefaultFilter(this.id,&quot;Default&quot;)" checked="checked">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>'
                    strHTML += '</label>'
                }
                else {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2"  onclick="SetDefaultFilter(this.id,&quot;&quot)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>'
                    strHTML += '</label>'
                }
                strHTML += '<label class="">'
                strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                strHTML += '</label>'
                strHTML += '<div class="issfilter_actiondropdown">'


                if (SetDefault == true) {
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="IssueselproOne" checked="" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                }
                else {
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" for="ModuleselproOne" id="Apply' + FilterID + '"  onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                }

                strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)" ></i></span>'
                if (SetDefault == true) {
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="Default' + FilterID + '" onclick="DeleteDefaultFilter(this.id)" ></i></span>'
                }
                else {
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="' + FilterID + '" onclick="DeleteDefaultFilter(this.id)"></i></span>'
                }
                strHTML += '</div>'
                strHTML += '</li>'
            }

            $("#MyFiltersdropdown").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();



            if (GlobalApplyID != null) {
                ApplyCheckFilter(GlobalApplyID);
            }
            else {
                ClearAppliedFilter(GlobalApplyID);
            }

        }
        // end of  Function to bind the  list of filter into UI 


        // function to select on option from list of filter (blue check)
        function ApplyCheckFilter(ApplyID) {
           
            if (GlobalApplyID == "") {

                GlobalApplyID = ApplyID;
            }
            else if (GlobalApplyID != "") {
                GlobalApplyID = ApplyID;
            }
            else {

                ApplyID = GlobalApplyID;

            }

            if (onchangeChecker == 0) {
                var ProjectId = $("#CboProject").val();
            } else if (OuterDropdownOnChangeIndicator == 1) {
                var ProjectId = OuterDropdownOnChangeProjectID;
            } else {
                var ProjectId = $("#txtPHSFilterProjectName").val();
            }


            FilterID = ApplyID.replace("Apply", "");
            if (FilterID != "undefined") {
                Parameters = {
                    FilterID: encodeURI(FilterID),
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/CheckFilter',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {


                        for (var i = 0; i < result.length; i++) {
                            var QueryText = result[i].WhereClause;
                        }
                        if (QueryText != null) {
                            QueryText = QueryText.toString().replace(/'/g, "''");
                        }
                        var sibling = $('label[id^="Apply"]')
                        if ($("#" + ApplyID).parent().find("input").prop("checked") == true) {

                            $("#" + ApplyID).parent().find("input").prop("checked", true);
                            $("#" + ApplyID).removeAttr("data-original-title", "");
                            $("#" + ApplyID).attr("data-original-title", "Applied Filter");

                        }
                        else if ($("#" + ApplyID).parent().find("input").prop("checked") == false) {



                            $(sibling).each(function () {
                                var id = this.id;

                                if (ApplyID == this.id) {

                                    $("#" + id).parent().find("input").prop("checked", true);
                                    $("#" + id).removeAttr("data-original-title", "");
                                    $("#" + id).attr("data-original-title", "Applied Filter");
                                }
                                else {

                                    $("#" + id).parent().find("input").prop("checked", false);
                                    $("#" + id).removeAttr("data-original-title", "");
                                    $("#" + id).attr("data-original-title", "Apply Filter");
                                }

                            });

                        }

                        callAllFunction(ProjectId);
                        $("#basicfilters").removeClass("active");
                        $(".clearalllink").css("display", "inline-block");
                       // $("#MyFiltersdropdown").css('display', 'none'); // commented by pradip on 7-4-2023
                        $(".filter button").css({ 'background': '#1359ac', 'color': '#fff' });

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }



        }
        // End of function to select on option from list of filter (blue check)


        $(".LIALBasicFilter").click(function () {
            $("#basicfilters").addClass('active');
        });

        // Clear 
        function ClearAppliedFilter(GlobalApplyID) {
            var sibling = $('label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($("#" + id).parent().find("input").prop("checked") == true) {
                    $("#" + id).parent().find("input").prop("checked", false);
                }
            });
            //Commented by imran on 15-12-2021 Datatable Warking alert display
            //setTimeout(function () {
            //    $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            //}, 350);
            //End Comment by imran on 15-12-2021
        }










        // Function for set as default filter 
        function SetDefaultFilter(DefaultID, flag) {
            //debugger;
            var RemoveDefault = 0;
            if (flag == "Default") {
                RemoveDefault = 1;
            }

            FilterID = DefaultID.replace("Default", "");
            // code case from which Drop down value it should take 

            if (onchangeChecker == 0) {
                var Projectid = $("#CboProject").val();
            } else {
                var Projectid = $("#txtPHSFilterProjectName").val();
            }
            var userid = encodeURI('<%= Session("intUserID") %>');
            var logintype = encodeURI('<%= Session("LoginType") %>');
            if (FilterID != undefined) {
                Parameters = {
                    ProjectID: Projectid,
                    LoginType: logintype,
                    UserID: userid,
                    TagID: PageTagID,
                    FilterID: FilterID,
                    Flag: encodeURI(RemoveDefault)
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/SetDefaultFilter',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        //debugger;
                        if (result != undefined) {
                            if (RemoveDefault == 0) {
                                FilterID = "Apply" + FilterID;
                                MyFilterList();/*//11th March 2023 Apply filter should display*/
                                ApplyCheckFilter(FilterID);
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success(result);
                            }
                            else {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.success('<%= MyBase.GetResourceString("A_ClearFilter") %>');

                                    if (DefaultSetProjectID != null && DefaultSetProjectID != undefined && DefaultSetProjectID != "") {
                                        SelectedProjectID = DefaultSetProjectID;
                                    }
                                    else {
                                        SelectedProjectID = encodeURI('<%= Session("intProjectID") %>');

                                    }
                                callAllFunction(SelectedProjectID);
                                if (RemoveDefault == 0) {/*//11th March 2023 Apply filter should display*/
                                    GlobalApplyID = null;
                                }
                                MyFilterList();/*//11th March 2023 Apply filter should display*/
                                }
                            }
                        if (result == "Set Default Filter Successfully") {
                            $("#basicfilters").addClass("activefilter");

                            $(".clearalllink").css("display", "inline-block");
                            $(".filter button").css({ 'background': '#1359ac', 'color': '#fff' });
                        } else {
                            $("#basicfilters").removeClass("activefilter");
                            $(".clearalllink").hide();
                            $(".filter button").css({ 'background': 'transparent', 'color': '#464a4c' });
                        }
                      
                        $("#MyFiltersdropdown").removeClass('show');/*//11th March 2023 Apply filter should display*/
                        $(".tooltip").removeClass('show')/*//11th March 2023 Apply filter should display*/
                        },
                        error: function (ER) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                        }
                    });
            }
        }

        //Function to get the default filter if it 1


        //end of Function to get the default filter if it 1

        function CheckDefaultFilterAppliedOrNot() {

            var userid = encodeURI('<%= Session("intUserID") %>');
            var logintype = encodeURI('<%= Session("LoginType") %>');
            $("#filterpanel").removeClass('in');
            $(".clearalllink").hide();
            $(".filter button").css({ 'background': 'transparent', 'color': '#464a4c' });
            GlobalFilterName = "";
            GlobalApplyID = null;
            Parameters = {
                TagID: PageTagID,
                LoginType: logintype,
                UserID: userid,
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/CheckDefaultFilterSetOrNot',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(Parameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                async: false,
                success: function (result) {
                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        var pid = obj.ProjectID;
                        var defultchecker = obj.SetDefault;

                        var FilterID = obj.FilterID;
                        var CheckSlectedProjectID = $("#CboProject").val();
                        if (defultchecker == true) {
                            if (CheckSlectedProjectID == pid) {
                                DefaultSetProjectID = pid;
                                GlobalApplyID = FilterID;
                                $(".clearalllink").show();
                                $(".clearalllink").css("display", "inline-block");
                                $(".LIALBasicFilter").addClass("active");
                                $("#basicfilters").addClass("active");
                                $(".filter button").attr("aria-expanded", "true");
                                $(".filter button[aria-expanded='true']").css({ 'background': '#1359ac', 'color': '#fff' });

                            }
                        }
                    }
                },
                error: function (ER) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                }
            });
        }

        // CLICK ON CLEAR  ALL LINK
        $("#PMProjectReviewClearAllFilter").click(function () {
            if (DefaultSetProjectID != null && DefaultSetProjectID != undefined && DefaultSetProjectID != "") {
                SelectedProjectID = DefaultSetProjectID;
            }
            else {
                SelectedProjectID = encodeURI('<%= Session("intProjectID") %>');

            }
            callAllFunction(SelectedProjectID);
            $("#filterpanel").removeClass('in');
            $(".clearalllink").hide();
            GlobalFilterName = "";
            GlobalApplyID = null;
            $(".filter button").attr("aria-expanded", "false");
            $(".filter button").css({ 'background': 'transparent', 'color': '#464a4c' });
            $("#txtPHSFilterProjectName").val('Select Project');
            $("#txtPHSFilterLocation").val('Select Organization Unit');
            $("#txtPHSFilterProjectType").val('Select Practice');
            $("#txtPHSFilterBusinessGroup").val('Select Business Group');
            $("#txtPHSFilterProjectGroupName").val('Select Project Group');
            $("#txtPHSFilterReportingDate").datepicker('setDate', new Date());

        });
        // END OF CLICK ON CLEAR  ALL LINK

        $("#ALLBasicFilter").click(function () {

            if (GlobalApplyID != null) {
                var FilterID = GlobalApplyID.replace("Apply", "");
                $("#MyFilter").removeClass("active");
                $("li#liALMyFiltersdropdown").removeClass("active");
                $(".stackbasicfilter").addClass("active");
                ResourceParameters = {
                    FilterID: encodeURI(FilterID),
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/EditFilter',// Path
                    method: 'Post',
                    data: JSON.stringify(ResourceParameters),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ResourceParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                        }
                    },
                    success: function (result) {
                        for (var i = 0; i < result.length; i++) {
                            var QueryText = result[i].WhereClause;
                            GlobalFilterName = result[i].FilterName;
                        }
                        QueryText = QueryText.replace('E.ReportingTo', 'ReportingTo');
                        BindBasicFilters(QueryText, "PHS");
                        var FilterName = $("#txtFilterName").val(GlobalFilterName);
                        $(".LIALBasicFilter").addClass("active");

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            else {
                $("li#liALMyFiltersdropdown").removeClass("active");
                $("#basicfilters").addClass("active");

                ClearBasicFilter("PHS");
                $("#txtFilterName").val('');
                GlobalFilterName = "";
            }



        });

        // EDIT  FILTER
        function EditFilter(EditID) {

            FromEditOptionHolder = 1;
            Flag = 1;
            FilterID = EditID.replace("Edit", "");
            EditFilterID = FilterID;

            // Click on edit (Basic Filter section will display)
            $('.nav-tabs li.LIALBasicFilter a[href="#basicfilters"]').tab('show');
            $('ul#ALLBasicFilter li a:last').parents('li').addClass('active');
            $("#basicfilters").addClass("active");
            Parameters = {
                FilterID: encodeURI(FilterID),
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/EditFilter',// Path
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {
                        var QueryText = result[i].WhereClause;
                        GlobalFilterName = result[i].FilterName;
                        GlobalApplyID = result[i].FilterID;
                    }

                    BindBasicFilters(QueryText, "PHS");
                    var FilterName = $("#txtFilterName").val(GlobalFilterName);

                },
                error: function (err) {
                    // alert(err.text);
                    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

            $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
                // hide any open popovers when the anywhere else in the body is clicked
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
                    $(".nav-tabs .dropdown-menu").removeClass('show');
                }
            });

        }

        // END OF EDIT FILTER

        function BindBasicFilters(qtext, module) {

            ClearBasicFilter(module);
            var isAnd = qtext.indexOf(' AND ');
            if (isAnd > 0) {
                var rowsAnd = qtext.split(' AND ');
                for (i = 0; i < rowsAnd.length; i++) {
                    BindBasicFilterValues(rowsAnd[i], module);
                }
            }
            else {
                BindBasicFilterValues(qtext, module);
            }
        }

        function BindBasicFilterValues(qtext, module) {

            var field = qtext.substr(0, qtext.indexOf(' '));
            var op = orgop = "";
            var val = valstr = "";

            var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
            var opchar = opstr.substr(0, 1);
            if (opchar == "N" || opchar == "L") {
                if (opchar == "N") {
                    op = "Not Contains";
                    orgop = "NOT LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                }
                if (opchar == "L") {
                    orgop = "LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    if (valstr.indexOf('%') == 1) {
                        if (valstr.substr(2, valstr.length).indexOf('%') > 0) {
                            op = "Contains";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                        }
                        else {
                            op = "Ends With";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 3);
                        }
                    }
                    else {
                        op = "Starts With";
                        val = valstr.substr(1, valstr.length - 3);
                    }
                }
            }
            else {
                op = opstr.substr(0, opstr.indexOf(' '));
                valstr = opstr.substr(op.length, opstr.length).trim();
                val = valstr.substr(1, valstr.length - 2);
            }
            if (op == '=') {
                var cbo = "cbo" + module + "Filter" + field;
                if ($("#" + cbo + " option[value='" + op + "']").length == 0) {
                    op = "Exact Word"
                }
            }
            $('#cbo' + module + 'Filter' + field).val(op).change();
            $('#txt' + module + 'Filter' + field).val(val).change();
        }

        function ClearBasicFilter(IdCaption) {

            $("[id*=cbo" + IdCaption + "Filter]").each(function (obj) {
                var cbo = this.id;
                $("#" + cbo + " option:first").prop('selected', 'selected');
            });

            $("[id*=txt" + IdCaption + "Filter]").each(function (obj) {

                var txt = this.id;
                if ($("#" + txt)[0].nodeName == "INPUT" || $("#" + txt)[0].nodeName == "TEXTAREA") {
                    $("#" + txt).val('').change();
                }
                else {
                    $("#" + txt + " option:first").prop('selected', 'selected');
                }


            });




        }

        // DELETE FILTER FROM MY FILTER LIST
        function DeleteDefaultFilter(DefaultID) {
            onchangeChecker = 0;
            if (DefaultID.indexOf("Default") > -1) {
                var FilterID = DefaultID.replace("Default", "");
                DeleteFilter(FilterID);
                var ProjectID = $("#CboProject").val();
                SelectedProjectID = ProjectID;
                callAllFunction(SelectedProjectID);
                $(".clearalllink").hide();
                $(".filter button").css({ 'background': 'transparent', 'color': '#464a4c' });
            }
            else {

                DeleteFilter(DefaultID);
                GetPHSDefaultFilter(3068);
            }
           
            $('.tooltip').remove(); //added by pradip on 7-4-2023
        }

        function DeleteFilter(FilterID) {
            //debugger;
            if (FilterID != undefined) {
                Parameters = {
                    FilterID: encodeURI(FilterID),
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/DeleteFilter',// Path
                    type: "POST",
                    data: JSON.stringify(Parameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    success: function (result) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(result);
                        ClearBasicFilter("PHS");
                        MyFilterList();
                        $('#basicfilters').removeClass("active");
                        $(".bgwhite.resource_allocation > div > div > div:nth-child(3) > div >button#PMProjectReviewClearAllFilter").removeClass("activefilter");
                        $("#MyFiltersdropdown").css('display', 'none');
                        $("#liALMyFiltersdropdown").removeClass('active');
                        $(".LIALBasicFilter").removeClass('active');


                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }



        }

        function GetPHSDefaultFilter(TagID) {

            var userid = encodeURI('<%= Session("intUserID") %>');
            var logintype = encodeURI('<%= Session("LoginType") %>');
            if (DefaultSetProjectID != null && DefaultSetProjectID != undefined && DefaultSetProjectID != "") {
                Projectid = DefaultSetProjectID;
            } else {
                var Projectid = $("#CboProject").val();
            }

            var Parameters = {
                ProjectID: encodeURI(Projectid),
                TagID: TagID,
                LoginType: encodeURI(logintype),
                UserID: encodeURI(userid)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetPHSDefaultFilter',// Path
                type: "POST",
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (strResult) {

                    if (strResult != undefined) {
                        FilterID = strResult.FilterID;
                        var QueryText = strResult.QueryText;
                        if (QueryText != null) {
                            var QueryText = QueryText.toString().replace(/'/g, "''");
                            $("#MyFilter").addClass("activefilter");

                            $(".clearalllink").css("display", "inline-block");
                            $(".filter button").css({ 'background': '#1359ac', 'color': '#fff' });
                            $(".LIALBasicFilter").addClass("active");
                        }
                        else {
                            $("#MyFilter").removeClass("activefilter");

                            $(".clearalllink").css("display", "none");
                            $(".LIALBasicFilter").removeClass("active");
                            $(".filter button").css({ 'background': 'transparent', 'color': '#464a4c' });
                        }
                        GlobalApplyID = "Apply" + FilterID;

                        var Projectid = $("#CboProject").val();
                        if (DefaultSetProjectID != null && DefaultSetProjectID != undefined && DefaultSetProjectID != "") {
                            SelectedProjectID = DefaultSetProjectID;
                        }
                        else {
                            SelectedProjectID = Projectid;

                        }
                        callAllFunction(SelectedProjectID);

                    }

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }


        //END OF  DELETE FILTER FROM MY FILTER LIST

        // CHECK DUPLICATE FILTER NAME IS EXIST OR NOT
        function checkDuplicateFilter(FilterName, TagID) {

            var isFilterExists = 0;
            var userid = encodeURI('<%= Session("intUserID") %>');
            var projectid = $("#txtPHSFilterProjectName").val();

            var Parameters = {
                FilterName: encodeURI(FilterName),
                TagID: encodeURI(TagID),
                ProjectID: projectid,
                UserID: userid,
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/chkFilterExists',// Path
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {

                    if (data == 0) {
                        isFilterExists = 0;
                    }
                    else if (data == 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%= MyBase.GetResourceString("A_FilterExist") %>');
                        $("#btnSaveAndApplyFilter").removeAttr("data-bs-dismiss", "");
                        isFilterExists = 1;
                        $("#txtFilterName").focus();
                    }
                },
                error: function (xhr, errorThrown) {
                    isFilterExists = 1;
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            return isFilterExists;

        }

        // END OF CHECK DUPLICATE FILTER NAME IS EXIST OR NOT

        // FILTER SECTION END HERE


        // SQERT Details start here
        function GetSQERTRangs() {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetSQERTRange',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(Parameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                async: false,
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        var rangeid = obj.RangeID;
                        var ll = obj.LowerLow;
                        var lh = obj.LowerHigh;
                        var ml = obj.MiddleLow;
                        var mh = obj.MiddleHigh;
                        var ul = obj.UpperLow;
                        var uh = obj.UpperHigh
                        // For Scope value assignment 
                        if (rangeid == 1) {
                            ScopeLoweLow = ll;
                            ScopeLoweHigh = lh;
                            ScopeMiddleLow = ml;
                            ScopeMiddleHigh = mh;
                            ScopeUpperLow = ul;
                            ScopeUpperHigh = uh;
                        }
                        // For Quality
                        if (rangeid == 2) {
                            QualityLoweLow = ll;
                            QualityLoweHigh = lh;
                            QualityMiddleLow = ml;
                            QualityMiddleHigh = mh;
                            QualityUpperLow = ul;
                            QualityUpperHigh = uh;
                        }
                        // For Effort
                        if (rangeid == 3) {
                            EffortLoweLow = ll;
                            EffortLoweHigh = lh;
                            EffortMiddleLow = ml;
                            EffortMiddleHigh = mh;
                            EffortUpperLow = ul;
                            EffortUpperHigh = uh;
                        }
                        // For Risk

                        if (rangeid == 4) {
                            RiskLoweLow = ll;
                            RiskLoweHigh = lh;
                            RiskMiddleLow = ml;
                            RiskMiddleHigh = mh;
                            RiskUpperLow = ul;
                            RiskUpperHigh = uh;
                        }
                        // For Time 
                        if (rangeid == 5) {
                            TimeLoweLow = ll;
                            TimeLoweHigh = lh;
                            TimeMiddleLow = ml;
                            TimeMiddleHigh = mh;
                            TimeUpperLow = ul;
                            TimeUpperHigh = uh;
                        }
                    }
                },
                error: function (ER) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                }
            });

        }

        function getSQERTDetails(projectid) {

            // var projectid = id;
            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var logintype = encodeURI('<%= Session("LoginType") %>');
            var userid = encodeURI('<%= Session("intUserID") %>');
            var tagvalue = 0;
            if (projectid == 0) {
                var strHtml = "";
                strHtml += '<tr>'
               
                //Added By Dipali V on 29th march 2023 For Datatable Issue
                 //strHtml += '<td class ="txtAlign" colspan="8">No data available in table</td>'
                strHtml += '<td  class ="txtAlign" colspan="8">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                strHtml += '</tr>'
                $("#tblsqert").html("");
                $("#tblsqert").html(strHtml);
            }
            var Parameters = {
                ProjectID: projectid,
                CurrentDate: date,
                UserID: userid,
                LoginType: logintype,
                TagValue: tagvalue,

            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetSQERTDetails',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (result == "") {
                            var strHtml = "";
                            strHtml += '<tr>'
                         
                            //Added By Dipali V on 29th march 2023 For Datatable Issue
                            //strHtml += '<td class ="txtAlign" colspan="8">No data available in table</td>'
                            strHtml += '<td  class ="txtAlign" colspan="8">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                            strHtml += '</tr>'
                            $("#tblsqert").html("");
                            $("#tblsqert").html(strHtml);
                        } else {
                            BindDataToSQERTGrid(result);
                        }


                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }

        }


        function BindDataToSQERTGrid(Data) {
            var SColor = "";
            var QColor = "";
            var EColor = "";
            var RColor = "";
            var TColor = "";
            var FColor = "";
            var CurGreen = "Green";
            var CurYellow = "Yellow";
            var CurRed = "Red";
            var redChecker = 0;
            var strHtml = "";
            $('#tblsqert').html('');
            var Body = "";
            if (Data != undefined) {
                for (var i = 0; i < Data.length; i++) {

                    var obj = Data[i];
                    var proname = obj.ProjectName;
                    var reportingdate = obj.ReportingDate;
                    var s = obj.Scope;
                    var q = obj.Quality;
                    var e = obj.Effort;
                    var r = obj.Risk;
                    var t = obj.Time;

                    strHtml += ' <tr>';
                    strHtml += ' <td>' + proname + '</td>';
                    strHtml += ' <td>' + reportingdate + '</td>';


                    // //for scope
                    if ((s >= ScopeLoweLow) && (s <= ScopeLoweHigh)) {
                        SColor = "Green";
                    }
                    if ((s >= ScopeMiddleLow) && (s <= ScopeMiddleHigh)) {
                        SColor = "Yellow";
                    }
                    if ((s >= ScopeUpperLow) && (s <= ScopeUpperHigh)) {
                        SColor = "Red";
                    }

                    if (SColor == CurGreen) {

                        strHtml += ' <td> <i class="fas fa-circle circleIndicator ciGreen"></i> </td>';
                    }
                    if (SColor == CurYellow) {

                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (SColor == CurRed) {

                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (SColor == "") {
                        strHtml += '<td></td>';
                    }


                    ////For quality
                    if ((q >= QualityLoweLow) && (q <= QualityLoweHigh)) {
                        QColor = "Green";
                    }
                    if ((q >= QualityMiddleLow) && (q <= QualityMiddleHigh)) {
                        QColor = "Yellow";
                    }
                    if ((q >= QualityUpperLow) && (q <= QualityUpperHigh)) {
                        QColor = "Red";
                    }

                    if (QColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (QColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (QColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (QColor == "") {
                        strHtml += '<td></td>';
                    }

                    //// For Effort

                    if ((e >= EffortLoweLow) && (e <= EffortLoweHigh)) {
                        EColor = "Green";
                    }
                    if ((e >= EffortMiddleLow) && (e <= EffortMiddleHigh)) {
                        EColor = "Yellow";
                    }
                    if ((e >= EffortUpperLow) && (e <= EffortUpperHigh)) {
                        EColor = "Red";
                    }

                    if (EColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (EColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (EColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (EColor == "") {
                        strHtml += '<td></td>';
                    }

                    //// For Risk

                    if ((r >= RiskLoweLow) && (r <= RiskLoweHigh)) {
                        RColor = "Green";
                    }
                    if ((r >= RiskMiddleLow) && (r <= RiskMiddleHigh)) {
                        RColor = "Yellow";
                    }
                    if ((r >= RiskUpperLow) && (r <= RiskUpperHigh)) {
                        RColor = "Red";
                    }

                    if (RColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (RColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (RColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (RColor == "") {
                        strHtml += '<td></td>';
                    }
                    //// For Time

                    if ((t >= TimeLoweLow) && (t <= TimeLoweHigh)) {
                        TColor = "Green";
                    }
                    if ((t >= TimeMiddleLow) && (t <= TimeMiddleHigh)) {
                        TColor = "Yellow";
                    }
                    if ((t >= TimeUpperLow) && (t <= TimeUpperHigh)) {
                        TColor = "Red";
                    }
                    if (TColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (TColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (TColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (TColor == "") {
                        strHtml += '<td></td>';
                    }

                    // Project Overview Color selection
                    if ((SColor == CurRed) || (QColor == CurRed) || (EColor == CurRed) || (RColor == CurRed) || (TColor == CurRed)) {

                        FColor = "Red";
                    }

                    if (FColor == "") {
                        if ((SColor == CurYellow) || (QColor == CurYellow) || (EColor == CurYellow) || (RColor == CurYellow) || (TColor == CurYellow)) {

                            FColor = "Yellow";
                        } else {
                            FColor = "Green";
                        }
                    }


                    if (FColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>'
                    }
                    if (FColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>'
                    }
                    if (FColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>'
                    }

                    strHtml += '</tr>'

                }
                $("#tblsqert").html("");
                $("#tblsqert").html(strHtml);

            }

        }

        // function to bind projects in this section  --List of Projects which were not locked till 
        function bindAllProjectsTillDate(selProjectid) {

            var strHtml = "";
            var Body = "";
            $("#healthshetprojectList").dataTable().fnDestroy();
            $('#tblAllProjectHealthSheetData').html('');
            if (selProjectid != 0) {
                for (var i = 0; i < GetAllProjectExpectedEndDate.length; i++) {
                    var obj = GetAllProjectExpectedEndDate[i];
                    var ProjectName = obj.ProjectName;
                    var startdate = obj.ExpectedStartDate;
                    var enddate = obj.ExpectedEndDate;


                    var tr = '<tr>';
                    tr += '<td>' + ProjectName + '</td>';
                    tr += '<td>' + startdate + '</td>';
                    tr += '<td>' + enddate + '</td>';
                    tr += '</tr>';

                    Body += tr;


                }
            }
            $('#tblAllProjectHealthSheetData').html("");
            $('#tblAllProjectHealthSheetData').append(Body);

            $('#healthshetprojectList').dataTable({
                "sScrollY": 200,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "retrieve": true,
                "autoWidth": false,
                "autoHeight": true

            });
        }


        // END of SQERT Details start here 



        // SQERT section starts here 
        function SQERTSection(projectid) {

            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var logintype = encodeURI('<%= Session("LoginType") %>');
            var userid = encodeURI('<%= Session("intUserID") %>');


            var Parameters = {
                ProjectID: projectid,
                CurrentDate: date,
                UserID: userid,
                LoginType: logintype,


            }

            try {

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetSQERTSection',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {



                        $("#tblSQERTSection").html("");
                        for (var i = 0; i < result.length; i++) {
                            var obj = result[i];
                            var s = obj.Scope;
                            var q = obj.Quality;
                            var e = obj.Effort;
                            var r = obj.Risk;
                            var t = obj.Time;
                            var sd = obj.ScopeDesc;
                            var qd = obj.QualityDesc;
                            var ed = obj.EffortDesc;
                            var rd = obj.RiskDesc;
                            var td = obj.TimeDesc;
                            if ((s == 0) && (q == 0) && (e == 0) && (r == 0) && (t == 0) && (sd == '') && (qd == '') && (ed == '') && (rd == '') && (td == '')) {
                                var strHtml = "";
                                strHtml += '<tr>'
                               /* strHtml += '<td class="txtAlign" colspan="5">No data available in table</td>'*/
                                //Added By Dipali V on 29th march 2023 For Datatable Issue
                                //strHtml += '<td  class ="txtAlign" colspan="5">No data available in table</td>'
                                strHtml += '<td  class ="txtAlign" colspan="5">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                                strHtml += '</tr>'
                                $("#tblSQERTSection").html("");
                                $("#tblSQERTSection").html(strHtml);

                            } else {

                                BindSQERTSection(result);
                            }

                        }



                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }


        }
        // Binding function starts here 
        function BindSQERTSection(Data) {

            var SColor = "";
            var QColor = "";
            var EColor = "";
            var RColor = "";
            var TColor = "";
            var CurGreen = "Green";
            var CurYellow = "Yellow";
            var CurRed = "Red";
            var s;// Scope value
            var q;
            var e;
            var r;
            var t;
            var sd;// Scope Description
            var qd;
            var ed;
            var rd;
            var td;
            $('#tblSQERTSection').html('');
            for (var i = 0; i < Data.length; i++) {
                var obj = Data[i];
                s = obj.Scope;
                q = obj.Quality;
                e = obj.Effort;
                r = obj.Risk;
                t = obj.Time;
                sd = obj.ScopeDesc;
                qd = obj.QualityDesc;
                ed = obj.EffortDesc;
                rd = obj.RiskDesc;
                td = obj.TimeDesc;

            }

            var Body = "";
            for (var j = 0; j < 5; j++) {
                if (j == 0) { // For Scope
                    var strHtml = "";
                    var str = "Scope";
                    strHtml += ' <tr>'
                    strHtml += ' <td>' + str + '</td>'
                    strHtml += ' <td>' + s + '</td>'
                    //for scope
                    if ((s >= ScopeLoweLow) && (s <= ScopeLoweHigh)) {
                        SColor = "Green";
                    }
                    if ((s >= ScopeMiddleLow) && (s <= ScopeMiddleHigh)) {
                        SColor = "Yellow";
                    }
                    if ((s >= ScopeUpperLow) && (s <= ScopeUpperHigh)) {
                        SColor = "Red";
                    }

                    if (SColor == CurGreen) {

                        strHtml += ' <td> <i class="fas fa-circle circleIndicator ciGreen"></i> </td>';
                    }
                    if (SColor == CurYellow) {

                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (SColor == CurRed) {

                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (SColor == "") {
                        strHtml += '<td></td>';
                    }

                    strHtml += ' <td><i class="fas fa-arrows-alt-h"></i></td>'
                    strHtml += ' <td>' + sd + '</td>'
                    strHtml += ' </tr>'
                    Body += strHtml;
                }
                if (j == 1) {// For quality
                    var strHtml = "";
                    var str = "Quality";
                    strHtml += ' <tr>'
                    strHtml += ' <td>' + str + '</td>'
                    strHtml += ' <td>' + q + '</td>'
                    ////For quality
                    if ((q >= QualityLoweLow) && (q <= QualityLoweHigh)) {
                        QColor = "Green";
                    }
                    if ((q >= QualityMiddleLow) && (q <= QualityMiddleHigh)) {
                        QColor = "Yellow";
                    }
                    if ((q >= QualityUpperLow) && (q <= QualityUpperHigh)) {
                        QColor = "Red";
                    }

                    if (QColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (QColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (QColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (QColor == "") {
                        strHtml += '<td></td>';
                    }

                    strHtml += ' <td><i class="fas fa-arrows-alt-h"></i></td>'
                    strHtml += ' <td>' + qd + '</td>'
                    strHtml += ' </tr>'
                    Body += strHtml;
                }
                if (j == 2) {// For Effort
                    var strHtml = "";
                    var str = "Effort";
                    strHtml += ' <tr>'
                    strHtml += ' <td>' + str + '</td>'
                    strHtml += ' <td>' + e + '</td>'
                    //// For Effort

                    if ((e >= EffortLoweLow) && (e <= EffortLoweHigh)) {
                        EColor = "Green";
                    }
                    if ((e >= EffortMiddleLow) && (e <= EffortMiddleHigh)) {
                        EColor = "Yellow";
                    }
                    if ((e >= EffortUpperLow) && (e <= EffortUpperHigh)) {
                        EColor = "Red";
                    }

                    if (EColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (EColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (EColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (EColor == "") {
                        strHtml += '<td></td>';
                    }
                    strHtml += ' <td><i class="fas fa-arrows-alt-h"></i></td>'
                    strHtml += ' <td>' + ed + '</td>'
                    strHtml += ' </tr>'
                    Body += strHtml;


                }
                if (j == 3) {// For Risk
                    var strHtml = "";
                    var str = "Risk";
                    strHtml += ' <tr>'
                    strHtml += ' <td>' + str + '</td>'
                    strHtml += ' <td>' + r + '</td>'
                    //// For Risk

                    if ((r >= RiskLoweLow) && (r <= RiskLoweHigh)) {
                        RColor = "Green";
                    }
                    if ((r >= RiskMiddleLow) && (r <= RiskMiddleHigh)) {
                        RColor = "Yellow";
                    }
                    if ((r >= RiskUpperLow) && (r <= RiskUpperHigh)) {
                        RColor = "Red";
                    }

                    if (RColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (RColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (RColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (RColor == "") {
                        strHtml += '<td></td>';
                    }
                    strHtml += ' <td><i class="fas fa-arrows-alt-h"></i></td>'
                    strHtml += ' <td>' + rd + '</td>'
                    strHtml += ' </tr>'
                    Body += strHtml;
                }
                if (j == 4) {// For Time
                    var strHtml = "";
                    var str = "Time";
                    strHtml += ' <tr>'
                    strHtml += ' <td>' + str + '</td>'
                    strHtml += ' <td>' + t + '</td>'
                    //// For Time

                    if ((t >= TimeLoweLow) && (t <= TimeLoweHigh)) {
                        TColor = "Green";
                    }
                    if ((t >= TimeMiddleLow) && (t <= TimeMiddleHigh)) {
                        TColor = "Yellow";
                    }
                    if ((t >= TimeUpperLow) && (t <= TimeUpperHigh)) {
                        TColor = "Red";
                    }
                    if (TColor == CurGreen) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciGreen"></i></td>';
                    }
                    if (TColor == CurYellow) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciYellow"></i></td>';
                    }
                    if (TColor == CurRed) {
                        strHtml += ' <td><i class="fas fa-circle circleIndicator ciRed"></i></td>';
                    }
                    if (TColor == "") {
                        strHtml += '<td></td>';
                    }
                    strHtml += ' <td><i class="fas fa-arrows-alt-h"></i></td>'
                    strHtml += ' <td>' + td + '</td>'
                    strHtml += ' </tr>'
                    Body += strHtml;
                }

            }
            //alert(Body);
            $("#tblSQERTSection").html(Body);
        }

        // End of binding function starts here


        // SQERT section starts here 


        // UPDATE SQERT SECTION WINDOW
        // Function to get  Effort,Time and Risk for Project

        function UpdateSQERT() {

            fetchEarnedValueReportvalues();
            DisplaySQERT();


        }


        function fetchEarnedValueReportvalues() {

            var projectid = $("#CboProject").val();
            var date = $('#txtPHSFilterReportingDate').datepicker().val();

            var Parameters = {
                ProjectID: projectid,
                CurrentDate: date,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetEffortTimeRisk',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        for (var i = 0; i < result.length; i++) {

                            var obj = result[i];
                            var title = obj.title;
                            var titlevalue = obj.titleValue;

                            if (title == 'Effort') {
                                DEffort = Math.round(titlevalue);


                            }
                            if (title == 'Time') {
                                DTime = Math.round(titlevalue);


                            }
                            if (title == 'Risk') {

                                DRisk = Math.round(titlevalue);

                            }
                        }



                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }


        }

        function DisplaySQERT() {

            var projectid = $("#CboProject").val();
            var Parameters = {
                ProjectID: projectid,
            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/DataonUpdateSQERTClick',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        BindDataUpdateSQERTInsideWindow(result);
                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }

        }


        // Function to bind pop up window table 
        function BindDataUpdateSQERTInsideWindow(Data) {

            var SQERTID;
            var Quality;
            var Scope;
            var Effort;
            var Risk;
            var Time;
            var QualityDesc;
            var ScopeDesc;
            var EffortDesc;
            var RiskDesc;
            var TimeDesc;
            var Locked;
            var GeneralRemarks;
            var Escalations;
            var GLOCKED;

            if (Data == '') {

                // If data is null the show  0 as textbox value same as old UI
                document.getElementById("txtScope").value = 0;
                document.getElementById("txtQuality").value = 0;

                document.getElementById("txtEffort").value = DEffort;
                document.getElementById("txtRisk").value = DRisk;
                document.getElementById("txtTime").value = DTime;

                //document.getElementById("txtEffort").disabled = false;
                //document.getElementById("txtRisk").disabled = false;
                //document.getElementById("txtTime").disabled = false;
                // $("#txtEffort").removeAttr("readonly");
                // $("#txtRisk").removeAttr("readonly");
                // $("#txtTime").removeAttr("readonly");



            } else {


                for (var i = 0; i < Data.length; i++) {

                    var obj = Data[i];
                    SQERTID = obj.SQERTID;
                    Quality = obj.Quality;
                    Scope = obj.Scope;
                    Effort = obj.Effort;
                    Risk = obj.Risk;
                    Time = obj.Time;
                    QualityDesc = obj.QualityDesc;
                    ScopeDesc = obj.ScopeDesc;
                    EffortDesc = obj.EffortDesc;
                    RiskDesc = obj.RiskDesc;
                    TimeDesc = obj.TimeDesc;
                    Locked = obj.Locked;
                    GeneralRemarks = obj.GeneralRemarks;
                    Escalations = obj.Escalations;
                }
                GlSQERTID = SQERTID;// to get unique SQERT id 


                if (Scope == undefined) {

                    document.getElementById("txtScope").value = 0;
                } else {
                    document.getElementById("txtScope").value = Scope;
                }
                $('#txtScopeDesc').text(ScopeDesc);

                if (Quality == undefined) {

                    document.getElementById("txtQuality").value = 0;
                } else {
                    document.getElementById("txtQuality").value = Quality;
                }
                $('#txtQualityDesc').text(QualityDesc);


                if (Effort == undefined) {

                    document.getElementById("txtEffort").value = 0;
                } else {
                    document.getElementById("txtEffort").value = Effort;
                }
                $('#txtEffortDesc').text(EffortDesc);


                if (Risk == undefined) {

                    document.getElementById("txtRisk").value = 0;
                } else {
                    document.getElementById("txtRisk").value = Risk;
                }
                $('#txtRiskDesc').text(RiskDesc);

                if (Time == undefined) {

                    document.getElementById("txtTime").value = 0;
                } else {
                    document.getElementById("txtTime").value = Time;
                }
                $('#txtTimeDesc').text(TimeDesc);



                $('#txtGeneralRemark').text(GeneralRemarks);
                $('#txtEscalation').text(Escalations);

                if (Locked == false) {

                    document.getElementById("txtEffort").disabled = false;
                    document.getElementById("txtRisk").disabled = false;
                    document.getElementById("txtTime").disabled = false;

                } else {
                    document.getElementById("txtScope").disabled = true;
                    document.getElementById("txtQuality").disabled = true;
                    document.getElementById("txtEffort").disabled = true;
                    document.getElementById("txtRisk").disabled = true;
                    document.getElementById("txtTime").disabled = true;
                }
                //Dipali
                document.getElementById("txtEffort").value = DEffort;
                document.getElementById("txtRisk").value = DRisk;
                document.getElementById("txtTime").value = DTime;
            }
        }

        //Added by Dipali V On 1st Feb 2022 For Validation Alert
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode
            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57))
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                    $("#txtOrderNumber").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    // alertify.error("Please enter only numeric values");
                    alertify.error("Please enter numeric value");
                }
            }
            return ret;
        }
        //End of Added by Dipali V On 1st Feb 2022 For Validation Alert


        //Added By Riddhesh Patil on 15-NOV-2022 
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
        //End of Added By Riddhesh Patil


        /* Inside Update SQERT Window if we change one of the parameter value and click on update 
         button. In short Saving SQERT value in table.*/

        function SaveUpdatedSQERTValue() {


            var projectid = $("#CboProject").val();
            var curdate = $('#txtPHSFilterReportingDate').datepicker().val();
            var scope = $("#txtScope").val();
            var quality = $("#txtQuality").val();
            var effort = $("#txtEffort").val();
            var risk = $("#txtRisk").val();
            var time = $("#txtTime").val();
            var sd = $("#txtScopeDesc").val();
            var qd = $("#txtQualityDesc").val();
            var ed = $("#txtEffortDesc").val();
            var rd = $("#txtRiskDesc").val();
            var td = $("#txtTimeDesc").val();
            var gr = $("#txtGeneralRemark").val();
            var esca = $("#txtEscalation").val();
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var sqertHolder;
            if (GlSQERTID != undefined) {
                sqertHolder = GlSQERTID;
            } else {
                sqertHolder = 0;
            }

            if ((sd == '') || (qd == '') || (ed == '') || (rd == '') || (td == '')) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_DescriptionField") %>');
                return;
            }
            //Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(sd, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Scope Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtScopeDesc").focus();

                return;
            }
            else if (checkSpecialCharacter(qd, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Quality Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtQualityDesc").focus();

                return;
            }
            else if (checkSpecialCharacter(ed, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Effort Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEffortDesc").focus();

                return;
            }
            else if (checkSpecialCharacter(rd, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Risk Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtRiskDesc").focus();

                return;
            }
            else if (checkSpecialCharacter(td, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Time Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtTimeDesc").focus();

                return;
            }
            else if (gr != '' || esca != '')
            {
                if (checkSpecialCharacter(gr, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('General Remarks should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtGeneralRemark").focus();

                    return;
                }
                else if (checkSpecialCharacter(esca, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Escalations should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtEscalation").focus();

                    return;
                }
            }
            //End of Added By Riddhesh Patil
            else {
                var sd = $("#txtScopeDesc").val();
                var qd = $("#txtQualityDesc").val();
                var ed = $("#txtEffortDesc").val();
                var rd = $("#txtRiskDesc").val();
                var td = $("#txtTimeDesc").val();
            }


            var Parameters = {
                ProjectID: projectid,
                CurrentDate: curdate,
                Scope: scope,
                Quality: quality,
                Effort: effort,
                Risk: risk,
                Time: time,
                ScopeDesc: sd,
                QualityDesc: qd,
                EffortDesc: ed,
                RiskDesc: rd,
                TimeDesc: td,
                UserID: Userid,
                GeneralRemarks: gr,
                Escalations: esca,
                SQERTID: sqertHolder
            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/SaveSQERTValue',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('<%= MyBase.GetResourceString("A_DetailUpdated") %>');
                    },
                    error: function (ER) {

                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }


        // HISTORY BUTTON INSIDE UPDATE SQERT POP WINDOW 



        function ShowHistory() {

            var projectid = $("#CboProject").val();
            for (var j = 0; j < listofallprojects.length; j++) {
                var proid = listofallprojects[j]["ProjectID"];
                var projectname = listofallprojects[j]["ProjectName"];
                if (proid == projectid) {
                    GPName = projectname;
                }

            }
            document.getElementById('lblProjectName').innerHTML = GPName;// lines of code to set the value to the lable



            var Parameters = {
                ProjectID: projectid,

            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/ShowHistory',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (result == '') {

                            var strHtml = "";
                            $('#tblShowHistory').html('');
                            strHtml += '<tr>'
                            /* strHtml += '<td class ="txtAlign"   colspan="8">No data available in table</td>'*/
                            //Added By Dipali V on 29th march 2023 For Datatable Issue
                            //strHtml += '<td class ="txtAlign" colspan="8">No data available in table</td>'
                            strHtml += '<td  class ="txtAlign" colspan="8">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                            strHtml += '</tr>'
                            $("#tblShowHistory").html("");
                            $("#tblShowHistory").html(strHtml);

                        } else {
                            //Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
                            //$('table').columns.adjust();// added by pradip on 20-7-2021
                            $($.fn.dataTable.tables(true)).css('width', '100%');
                            $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();
                            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                            //End of Added By Dipali V on 2nd Dec 2021 For To Adjust Column of datatable
                            ShowHistoryGridBinding(result);
                        }

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }


        }

        function ShowHistoryGridBinding(Data) {
            var strHtml = "";
            var Comment = "";
            var Body = "";

            $("#showHistoryTBL").dataTable().fnDestroy();
            $('#tblShowHistory').html('');

            for (var i = 0; i < Data.length; i++) {
                var obj = Data[i];
                var reportingdate = obj.ReportingDate;
                var lockeddate = obj.LockedDate;
                var s = obj.Scope;
                var q = obj.Quality;
                var e = obj.Effort;
                var r = obj.Risk;
                var t = obj.Time;
                var sd = obj.ScopeDesc;
                var qd = obj.QualityDesc;
                var ed = obj.EffortDesc;
                var rd = obj.RiskDesc;
                var td = obj.TimeDesc;


                strHtml = '<tr>'
                strHtml += ' <td>' + reportingdate + '</td>'
                strHtml += ' <td>' + lockeddate + '</td>'
                strHtml += ' <td>' + s + '</td>'
                strHtml += ' <td>' + q + '</td>'
                strHtml += ' <td>' + e + '</td>'
                strHtml += ' <td>' + r + '</td>'
                strHtml += ' <td>' + t + '</td>'
                strHtml += '<td>'
                strHtml += 'Scope :' + sd + '<br>'
                strHtml += 'Quality :' + qd + '<br>'
                strHtml += 'Effort :' + ed + '<br>'
                strHtml += 'Risk :' + rd + '<br>'
                strHtml += 'Time :' + td + '<br>'
                strHtml += '</td>'
                strHtml += '</tr>'

                Body += strHtml;

            }


            $('#tblShowHistory').html("");
            $('#tblShowHistory').append(Body);

            $('#showHistoryTBL').dataTable({
                "sScrollY": 200,
                "scrollX": true,
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "retrieve": true,
                "autoWidth": false,
                "autoHeight": true,
                //Added By Dipali V On 9th Feb 2022 For Removed Sorting
                "columnDefs": [
                    { "orderable": false, "targets": [0, 1, 2, 3, 4, 5, 6] } // Applies the option to all columns
                ]


            });

        }


        // END OF UPDATE SQERT SECTION WINDOW


        // Key Achievement in the Reporting Period section start here
        function getTaskAndDeliverablesDetails(Projectid) {


            // var projectid = Projectid;
            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var CID;
            var PGID;
            var BGID;
            var OUID;

            for (var j = 0; j < OtherDetailsofprojectholder.length; j++) {

                var proid = OtherDetailsofprojectholder[j]["ProjectID"];

                CID = OtherDetailsofprojectholder[j]["ProjectTypeID"];
                PGID = OtherDetailsofprojectholder[j]["ProjectGroupID"];
                BGID = OtherDetailsofprojectholder[j]["BusinessGroupID"];
                OUID = OtherDetailsofprojectholder[j]["LocationID"];
            }

            var Parameters = {
                ProgramID: PGID,
                ProjectID: Projectid,
                CategoryID: CID,
                BusinessID: BGID,
                OrganizationID: OUID,
                ReportingEndDate: date,
                UserID: Userid,

            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/KeyAchievement',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        BindingKeyAchievementGrid(result);

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }

        function BindingKeyAchievementGrid(Data) {
            var CompletedTasks;
            var TobeCompletedTasks;
            var SlippingTasks;
            var TotalPlannedTasks;
            var CompletedDeliverables;
            var SlippingDeliverables;
            var TobeCompletedDeliverables;
            var TotalPlannedDeliverables;
            var strHtml = "";

            var t = "Tasks";
            var d = "Deliverables";
            $("#tblkeyachievementbody").html('');
            for (var i = 0; i < Data.length; i++) {
                var obj = Data[i];
                CompletedTasks = obj.CompletedTasks;
                TobeCompletedTasks = obj.TobeCompletedTasks;
                SlippingTasks = obj.SlippingTasks;
                TotalPlannedTasks = obj.TotalPlannedTasks;
                CompletedDeliverables = obj.CompletedDeliverables;
                SlippingDeliverables = obj.SlippingDeliverables;
                TobeCompletedDeliverables = obj.TobeCompletedDeliverables;
                TotalPlannedDeliverables = obj.TotalPlannedDeliverables;

            }
            strHtml += '<tr>'
            strHtml += '<td>' + t + '</td>'
            strHtml += '<td>' + TotalPlannedTasks + '</td>'
            strHtml += '<td>' + CompletedTasks + '</td>'
            strHtml += '<td>' + TobeCompletedTasks + '</td>'
            strHtml += '<td>' + SlippingTasks + '</td>'
            strHtml += '</tr>'

            strHtml += '<tr>'
            strHtml += '<td>' + d + '</td>'
            strHtml += '<td>' + TotalPlannedDeliverables + '</td>'
            strHtml += '<td>' + CompletedDeliverables + '</td>'
            strHtml += '<td>' + TobeCompletedDeliverables + '</td>'
            strHtml += '<td>' + SlippingDeliverables + '</td>'
            strHtml += '</tr>'


            $("#tblkeyachievementbody").html('');
            $("#tblkeyachievementbody").html(strHtml);

        }

        //End of Key Achievement in the Reporting Period section


        // Issue Details section starts here
        function IssueDetails(projectid) {


            issuedetailscurrentProjectid = projectid;
            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var Userid = encodeURI('<%= Session("intUserID") %>');

            for (var j = 0; j < OtherDetailsofprojectholder.length; j++) {

                insidepopupissuedetailprojectname = OtherDetailsofprojectholder[j]["ProjectName"];
                CID = OtherDetailsofprojectholder[j]["ProjectTypeID"];
                PGID = OtherDetailsofprojectholder[j]["ProjectGroupID"];
                BGID = OtherDetailsofprojectholder[j]["BusinessGroupID"];
                OUID = OtherDetailsofprojectholder[j]["LocationID"];
            }
            var Parameters = {
                ProgramID: PGID,
                ProjectID: projectid,
                CategoryID: CID,
                BusinessID: BGID,
                OrganizationID: OUID,
                ReportingEndDate: date,
                UserID: Userid,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/IssueDetails',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        BindIssueDetailGrid(result);
                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }
        }

        function BindIssueDetailGrid(Data) {


            var TS = 0;
            var OS = 0;
            var CS = 0;
            var OTS = 0;
            var LFIVE = 0;
            var BETFIVETEN = 0;
            var MORETEN = 0;
            var DUES = 0;
            var SHOWCUSt = 0;
            var totalissueSUM = 0;
            var openissueSUM = 0;
            var closeissueSUM = 0;
            var otherissueSUM = 0;
            var lessthanfiveSUM = 0;
            var betweenfivetenSUM = 0;
            var moretenSUM = 0;
            var dueissueSUM = 0;
            var showcustSUM = 0;
            var strHtml = "";

            var str = "Total";
            $('#issuedetailbody').html('');
            for (var i = 0; i < Data.length; i++) {

                var obj = Data[i];
                var Type = obj.Type;
                var totalissues = obj.totalissues;
                var openissues = obj.openissues;
                var closeissues = obj.closeissues;
                var OTHERSissues = obj.OTHERSissues;
                var LessThanFive = obj.LessThanFive;
                var BetweenFiveAndTen = obj.BetweenFiveAndTen;
                var MoreThanTen = obj.MoreThanTen;
                var OverDueIssues = obj.OverDueIssues;
                var ShownToCustomer = obj.ShownToCustomer;
                totalissueSUM += totalissues;
                openissueSUM += openissues;
                closeissueSUM += closeissues;
                otherissueSUM += OTHERSissues;
                lessthanfiveSUM += LessThanFive;
                betweenfivetenSUM += BetweenFiveAndTen;
                moretenSUM += MoreThanTen;
                dueissueSUM += OverDueIssues;
                showcustSUM += ShownToCustomer;

                strHtml += '<tr>'
                strHtml += '<td>' + Type + '</td>'
                if (openissues == 0) {
                    strHtml += '<td>' + openissues + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="2"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details" onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')"> ' + openissues + '</a></td>'
                }
                if (closeissues == 0) {
                    strHtml += '<td>' + closeissues + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;"  id ="3"   data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details" onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')" >' + closeissues + '</a></td>'
                }
                if (OTHERSissues == 0) {
                    strHtml += '<td>' + OTHERSissues + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="6"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details" onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')" >' + OTHERSissues + '</a></td>'
                }
                if (totalissues == 0) {
                    strHtml += '<td>' + totalissues + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="1"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal"  id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details" onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')">' + totalissues + '</a></td>'
                }

                if (LessThanFive == 0) {
                    strHtml += '<td>' + LessThanFive + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="7" data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')">' + LessThanFive + '</a></td>'
                }
                if (BetweenFiveAndTen == 0) {
                    strHtml += '<td>' + BetweenFiveAndTen + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="8"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')">' + BetweenFiveAndTen + '</a></td>'
                }
                if (MoreThanTen == 0) {
                    strHtml += '<td>' + MoreThanTen + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="9"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal"  id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')">' + MoreThanTen + '</a></td>'
                }

                if (ShownToCustomer == 0) {
                    strHtml += '<td>' + ShownToCustomer + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="5"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"   onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')">' + ShownToCustomer + '</a></td>'
                }
                if (OverDueIssues == 0) {
                    strHtml += '<td>' + OverDueIssues + '</td>'
                } else {
                    strHtml += '<td><a href="javascript:;" id="4"   data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + Type + "'" + ')">' + OverDueIssues + '</a></td>'
                }

                strHtml += '</tr>'


            }
            TS = totalissueSUM;
            OS = openissueSUM;
            CS = closeissueSUM;
            OTS = otherissueSUM;
            LFIVE = lessthanfiveSUM;
            BETFIVETEN = betweenfivetenSUM;
            MORETEN = moretenSUM;
            DUES = dueissueSUM;
            SHOWCUSt = showcustSUM;
            strHtml += '<tr>'
            strHtml += '<td>' + str + '</td>'
            if (OS == 0) {
                strHtml += '<td>' + OS + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="16"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + OS + '</a></td>'
            }
            if (CS == 0) {
                strHtml += '<td>' + CS + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="17"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + CS + '</a></td>'
            }
            if (OTS == 0) {
                strHtml += '<td>' + OTS + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="18"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal"  id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + OTS + '</a></td>'
            }
            if (TS == 0) {
                strHtml += '<td>' + TS + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="19"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + TS + '</a></td>'
            }
            if (LFIVE == 0) {
                strHtml += '<td>' + LFIVE + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="20"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + LFIVE + '</a></td>'
            }
            if (BETFIVETEN == 0) {
                strHtml += '<td>' + BETFIVETEN + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="21"   data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + BETFIVETEN + '</a></td>'
            }
            if (MORETEN == 0) {
                strHtml += '<td>' + MORETEN + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="22"   data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal" id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + MORETEN + '</a></td>'
            }
            if (SHOWCUSt == 0) {
                strHtml += '<td>' + SHOWCUSt + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="23"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal"  id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + SHOWCUSt + '</a></td>'
            }
            if (DUES == 0) {
                strHtml += '<td>' + DUES + '</td>'
            } else {
                strHtml += '<td><a href="javascript:;" id="24"  data-bs-toggle="modal" data-bs-target="#PHSopenissuedetailModal"  id="individualIssuedetails" title="" data-bs-placement="bottom" data-original-title="Show Details"  onclick="Clickedlink(this.id,' + "'" + str + "'" + ')">' + DUES + '</a></td>'
            }



            $("#issuedetailbody").html("");
            $("#issuedetailbody").html(strHtml);

        }

        function Clickedlink(id, temptype) {
            var str;

            // Code for Showing value in Issue detail lable
            if (id == 1 || id == 19) {
                str = 'Total Issue';
            }
            if ((id == 2) || (id == 16)) {

                str = 'Open Issue';
            }
            if (id == 3 || id == 17) {
                str = 'Closed Issue';
            }
            if (id == 4 || id == 24) {
                str = 'Over Due Issue';
            }
            if (id == 5 || id == 23) {
                str = 'Show to customer Issue';
            }
            if (id == 6 || id == 18) {
                str = 'Other Issue';
            }
            if (id == 7 || id == 20) {
                str = 'Ageing less than 5 days';
            }
            if (id == 8 || id == 21) {
                str = 'Ageing betwwen 5 and 10 days';
            }
            if (id == 9 || id == 22) {
                str = 'Ageing more than 10 days';
            }
            document.getElementById('lblIssueDetails').innerHTML = str;
            //End of code for showing value in issue detail lable

            document.getElementById('lblIssuepopProjectName').innerHTML = insidepopupissuedetailprojectname;

            var tempflag = id;
            var tempIssueTypeHolder = temptype;
            if (tempIssueTypeHolder == 'Total') {
                tempIssueTypeHolder = '';
            }
            var projectid = issuedetailscurrentProjectid;
            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var Userid = encodeURI('<%= Session("intUserID") %>');

            var Parameters = {
                ProgramID: PGID,
                ProjectID: projectid,
                CategoryID: CID,
                BusinessID: BGID,
                OrganizationID: OUID,
                ReportingEndDate: date,
                UserID: Userid,
                Flag: tempflag,
                StrIssueType: tempIssueTypeHolder
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/IndividualIssueDetails',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(Parameters),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (result == '') {
                            var strHtml = "";
                            $('#individualissuedetablbody').html('');
                            strHtml += '<tr>'
                          
                            //Added By Dipali V on 29th march 2023 For Datatable Issue
                            //strHtml += '<td class ="txtAlign" colspan="11">No data available in table</td>'
                            strHtml += '<td  class ="txtAlign" colspan="11">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                            strHtml += '</tr>'
                            $("#individualissuedetablbody").html("");
                            $("#individualissuedetablbody").html(strHtml);

                        } else {
                            BindIndividualIssueDetailBody(result);
                        }


                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }

        }

        function BindIndividualIssueDetailBody(Data) {
            var strHtml = "";
            var Body = "";
            var srno;
            $("#IndividualIssueDTBL").dataTable().fnDestroy();
            $('#individualissuedetablbody').html('');
            for (var i = 0; i < Data.length; i++) {
                var obj = Data[i];
                var issueid = obj.IssueID;
                var summary = obj.Summary;
                var reporteddate = obj.ReportedDate;
                var issuetype = obj.Type;
                var issuesubtype = obj.SubType;
                var priority = obj.Priority;
                var severity = obj.Severity;
                var status = obj.Status;
                var duedate = obj.DueDate;
                var reportedby = obj.ReportedBy;
                if (i == 0) {
                    srno = 1;
                } else {
                    srno = i + 1;
                }
                strHtml += '<tr>'
                strHtml += '<td>' + srno + '</td>'
                strHtml += '<td>' + issueid + '</td>'
                strHtml += '<td>' + summary + '</td>'
                strHtml += '<td>' + reporteddate + '</td>'
                strHtml += '<td>' + issuetype + '</td>'
                strHtml += '<td>' + issuesubtype + '</td>'
                strHtml += '<td>' + priority + '</td>'
                strHtml += '<td>' + severity + '</td>'
                strHtml += '<td>' + status + '</td>'
                strHtml += '<td>' + duedate + '</td>'
                strHtml += '<td>' + reportedby + '</td>'
                strHtml += '</tr>'
            }
            Body += strHtml
            $('#individualissuedetablbody').html("");
            $('#individualissuedetablbody').append(Body);
            $('#IndividualIssueDTBL').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true,

            });

        }

        /// End of issue details section 


        // Get Milestone details 
        function ListOfMilestone(Projectid) {
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var categoryid;
            var bgid;
            var ouid;
            var programid;

            for (var i = 0; i < OtherDetailsofprojectholder.length; i++) {
                var obj = OtherDetailsofprojectholder[i];
                categoryid = obj.ProjectTypeID;
                bgid = obj.BusinessGroupID;
                ouid = obj.LocationID;
                programid = obj.ProjectGroupID;

            }


            var ListOfProjectParameter = {
                ProgramID: programid,
                ProjectID: Projectid,
                ProjectTypID: categoryid,
                BusinessGroupID: bgid,
                LocationID: ouid,
                EndDate: date,
                UserID: Userid
            }

            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchListOfMileStone',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        if (result == '') {
                            var strHtml = "";

                            $('#MileStoneBinding').html('');
                            strHtml += '<tr>'
                            
                            //Added By Dipali V on 29th march 2023 For Datatable Issue
                            //strHtml += '<td class ="txtAlign" colspan="9">No data available in table</td>'
                            strHtml += '<td  class ="txtAlign" colspan="9">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                            strHtml += '</tr>'
                            $("#MileStoneBinding").html("");
                            $("#MileStoneBinding").html(strHtml);

                        } else {
                            DisplayMileStoneInformation(result);
                        }

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }

        }
        // End of Get Milestone details 

        // Function to bind the milestone data to grid 
        function DisplayMileStoneInformation(data) {

            var strHtml = "";
            var convertedRedayForBilling;
            if (data != null) {

                for (var i = 0; i < data.length; i++) {

                    var Milestone = data[i]["Milestone"];
                    var IsReadyForBilling = data[i]["IsReadyForBilling"];
                    var BillAmount = data[i]["BillAmount"];
                    var PlannedStartDate = data[i]["PlannedStartDate"];
                    var PlannedEndDate = data[i]["PlannedEndDate"];
                    var ActualStartDate = data[i]["ActualStartDate"];
                    var ActualEndDate = data[i]["ActualEndDate"];
                    var Slippage = data[i]["Slippage"];
                    var Milestonestatus = data[i]["Milestonestatus"];

                    if (IsReadyForBilling == true) {
                        convertedRedayForBilling = 1;
                    } else {
                        convertedRedayForBilling = 0;
                    }
                    strHtml += ' <tr>'
                    strHtml += ' <td>' + Milestone + '</td>'
                    strHtml += ' <td>' + convertedRedayForBilling + '</td>'
                    strHtml += ' <td>' + BillAmount + '</td>'
                    strHtml += ' <td>' + PlannedStartDate + '</td>'
                    strHtml += ' <td>' + PlannedEndDate + '</td>'
                    strHtml += ' <td>' + ActualStartDate + '</td>'
                    strHtml += ' <td>' + ActualEndDate + '</td>'
                    strHtml += ' <td>' + Slippage + '</td>'
                    strHtml += ' <td>' + Milestonestatus + '</td>'
                    strHtml += '</tr>'
                }
                $("#MileStoneBinding").html("");
                $("#MileStoneBinding").html(strHtml);
            }

        }
        // end of Function to bind the milestone data to grid 


        // BASE LINE DETAILS
        function baselinedetails(Projectid) {
            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var date = $('#txtPHSFilterReportingDate').datepicker().val();
            var categoryid;
            var bgid;
            var ouid;
            var programid;

            for (var i = 0; i < OtherDetailsofprojectholder.length; i++) {
                var obj = OtherDetailsofprojectholder[i];
                categoryid = obj.ProjectTypeID;
                bgid = obj.BusinessGroupID;
                ouid = obj.LocationID;
                programid = obj.ProjectGroupID;

            }


            var ListOfProjectParameter = {
                ProgramID: programid,
                ProjectID: Projectid,
                ProjectTypID: categoryid,
                BusinessGroupID: bgid,
                LocationID: ouid,
                EndDate: date,
                UserID: Userid
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/FetchBaseLine',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(ListOfProjectParameter),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (ListOfProjectParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        if (result == '') {
                            var strHtml = "";

                            $('#baselinetbody').html('');
                            strHtml += '<tr>'
                            //strHtml += '<td class ="txtAlign"   colspan="9">No data available in table</td>'
                            //Added By Dipali V on 29th march 2023 For Datatable Issue
                            //strHtml += '<td class ="txtAlign" colspan="8">No data available in table</td>'
                            strHtml += '<td  class ="txtAlign" colspan="9">No data available in table</td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td><td style="display:none"></td>'
                              //End of Added By Dipali V on 29th march 2023 For Datatable Issue
                            strHtml += '</tr>'
                            $("#baselinetbody").html("");
                            $("#baselinetbody").html(strHtml);

                        } else {

                            DisplayBaseLineInformation(result);
                        }

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                // alert(ex.text);
            }

        }

        function DisplayBaseLineInformation(Data) {
            var strHtml = "";

            $("#baselinetbody").html("");
            for (var i = 0; i < Data.length; i++) {
                var obj = Data[i];
                var ProjectName = obj.ProjectName;
                var ReasonForRevision = obj.ReasonForRevision;
                var RevisionDate = obj.RevisionDate;
                var EstimatedEffort = obj.EstimatedEffort;
                var ExpectedEnddate = obj.ExpectedEnddate;

                strHtml += ' <tr colspan="4" class="graybglight" >'
                strHtml += ' <td class="graybglight" >' + ProjectName + '</td>'
                strHtml += ' <td class="graybglight" ></td>'
                strHtml += ' <td class="graybglight" ></td>'
                strHtml += ' <td class="graybglight" ></td>'
                strHtml += '</tr>'
                strHtml += '<tr>'
                strHtml += ' <td>' + ReasonForRevision + '</td>'
                strHtml += ' <td>' + RevisionDate + '</td>'
                strHtml += ' <td>' + EstimatedEffort + '</td>'
                strHtml += ' <td>' + ExpectedEnddate + '</td>'
                strHtml += '</tr>'
            }
            $("#baselinetbody").html("");
            $("#baselinetbody").html(strHtml);
        }

        //END OF BASE LINE DETAILS 

        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        // Date Picker
        $("#txtPHSFilterReportingDate").datepicker(
            {

                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: "dd M yy",
                defaultDate: new Date()



            }
        );
        $("#txtPHSFilterReportingDate").datepicker('setDate', new Date());


        // EV Details Start From Here Rutuja D. Added

        //For Binding EV Detial Grid
        function BindEVDetails(ProjectID) {
            var ProjectID = ProjectID;
            var ReportingDate = $("#txtPHSFilterReportingDate").val();
            if (ReportingDate != "") {
                ReportingDate = ReportingDate;
            } else {
                ReportingDate = $.datepicker.formatDate('dd M yy', today);
            }
            ReportingEndDate = new Date(ReportingDate);
            ReportingDate = new Date(ReportingDate);
            //ReportingStartDate = new Date(ReportingDate);
            var NextReportingEndDate = "";
            var intLastDayOfMonth = "";
            switch (FrequencyID) {
                case 0:
                    ReportingStartDate = new Date(ReportingDate.setDate(ReportingDate.getDate() - 6));
                    //NextReportingEndDate = new Date(ReportingDate.setDate(ReportingDate.getDate() + 7));
                    break;
                case 1:

                    ReportingStartDate = new Date(ReportingDate.setDate(ReportingDate.getDate() - 13));
                    //NextReportingEndDate = new Date(ReportingDate.setDate(ReportingEndDate.getDate() + 14));
                    break;
                case 2:
                    var month = ReportingEndDate.getMonth() + 1;
                    var year = ReportingEndDate.getFullYear();
                    var intMonthOfFeb = ReportingEndDate.getMonth() + 1;
                    //intLastDayOfMonth = new Date(year, month, 0).getDate();
                    intLastDayOfMonth = ReportingEndDate.getDate();

                    if (intLastDayOfMonth == 31) {
                        ReportingStartDate = new Date(ReportingDate.setDate(ReportingDate.getDate() - 30));
                        //NextReportingEndDate = new Date(ReportingDate.setDate(ReportingEndDate.getDate(), intLastDayOfNextMonth));
                    }
                    else if (intLastDayOfMonth == 28 && intMonthOfFeb == 2) {
                        ReportingStartDate = new Date(ReportingDate.setDate(ReportingDate.getDate() - 27));
                        //NextReportingEndDate = new Date(ReportingDate.setDate(ReportingEndDate.getDate(), intLastDayOfNextMonth));
                    } else {
                        if (intLastDayOfMonth == 29 && intMonthOfFeb == 2) {
                            ReportingStartDate = new Date(ReportingDate.setDate(ReportingDate.getDate() - 28));
                            //NextReportingEndDate = new Date(ReportingDate.setDate(ReportingEndDate.getDate(), intLastDayOfNextMonth));
                        } else {
                            ReportingStartDate = new Date(ReportingDate.setDate(ReportingDate.getDate() - 29));
                            var intMonth = "";
                            intMonth = ReportingEndDate.getMonth() + 1;

                            if (intMonth == 4 || intMonth == 6 || intMonth == 9 || intMonth == 11) {
                                // NextReportingEndDate = new Date(ReportingDate.setDate(ReportingDate.getDate() + 30));
                            } else if (intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth == 7 || intMonth == 8 || intMonth == 10 || intMonth == 12) {
                                // NextReportingEndDate = new Date(ReportingDate.setDate(ReportingDate.getDate() + 31));
                            } else if (intMonth == 2) {
                                if ((ReportingEndDate / 4) == 0) {
                                    //   NextReportingEndDate = new Date(ReportingDate.setDate(ReportingDate.getDate() + 29));
                                } else {
                                    //  NextReportingEndDate = new Date(ReportingDate.setDate(ReportingDate.getDate() + 28));
                                }
                            }
                        }
                    }
                    break;

            }
            var sd = ReportingStartDate.getDate();
            var sm = ReportingStartDate.getMonth() + 1;
            var sy = ReportingStartDate.getFullYear();
            var AllmonthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var sdate = "" + sm + "/" + sd + "/" + sy + "";
            var startDate = new Date(sdate);
            var SelectedMonthName = AllmonthNames[startDate.getMonth()];
            var SelectedYearName = startDate.getFullYear();
            ReportingStartDate = sd + " " + SelectedMonthName + " " + SelectedYearName;
            ReportingEndDate = $.datepicker.formatDate('dd M yy', ReportingEndDate);
            var EVDetails = {
                ProjectID: ProjectID,
                ReportingEndDate: ReportingEndDate,
                ReportingStartDate: ReportingStartDate,
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetEVDetails',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(EVDetails),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (EVDetails) {
                            xhr.setRequestHeader("Params", encryptString(isJson(EVDetails) ? EVDetails : JSON.stringify(EVDetails)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        $("#EVDetaltablbody").html('');
                        var strHTML = "";
                        for (var i = 0; i < result.length; i++) {
                            var obj = result[i];

                            var FieldName = obj.FieldName;
                            var FieldValue = obj.FieldValue.toFixed(2);
                            var EVElementName = obj.EVElementName;
                            if (EVElementName == "Status") { }
                            else if (EVElementName == "PossibleCauses") { }
                            else if (EVElementName == "PossibleSolutions") { }
                            else {
                                strHTML += '<tr class="">'
                                strHTML += '<td class="text-start">' + FieldName + '</td>'
                                strHTML += '<td class="text-end">' + FieldValue + '</td>'
                                strHTML += '</tr>'
                            }
                        }
                        $("#EVDetaltablbody").html("")
                        $("#EVDetaltablbody").html(strHTML);


                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                //alert(ex.text);
            }
        }

        //Before EV detail plot Checking one condition EVISApplicable it is Applicable then EV detail plot 
        function CheckEvIsApplicable(ProjectID) {
            if (ProjectID == 0) {
                $("#EVdetailpanel").hide();
            } else {
                var EVDetails = {
                    ProjectID: ProjectID,
                }
                try {
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetEvIsApplicable',// Path
                        type: "POST",                                       //HTTP TYPE get /post
                        data: JSON.stringify(EVDetails),       // Parameters
                        dataType: "json",                                   //Retrun Type 
                        contentType: "application/json; charset=utf-8",     //
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (EVDetails) {
                                xhr.setRequestHeader("Params", encryptString(isJson(EVDetails) ? EVDetails : JSON.stringify(EVDetails)));
                            }
                        },
                        async: false,
                        success: function (result) {

                            if (result == 0) {
                                $("#EVdetailpanel").hide();
                            } else {
                                $("#EVdetailpanel").show();
                                BindEVDetails(ProjectID);
                                GenerateReportGraphForEV(ProjectID);
                            }


                        },
                        error: function (ER) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                        }
                    });
                }
                catch (ex) {
                    //alert(ex.text);
                }
            }
        }

        //Report Binding For EV
        function GenerateReportGraphForEV(ProjectID) {
            var ReportingDate = $("#txtPHSFilterReportingDate").val();
            if (ReportingDate != "") {
                ReportingDate = ReportingDate;
            } else {
                ReportingDate = $.datepicker.formatDate('dd M yy', today);
            }
            ReportingEndDate = ReportingDate;
            var EVDetails = {
                ProjectID: encodeURI(ProjectID),
                ReportingEndDate: encodeURI(ReportingEndDate)
            }
            try {
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/GetReportGraphForEV',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(EVDetails),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (EVDetails) {
                            xhr.setRequestHeader("Params", encryptString(isJson(EVDetails) ? EVDetails : JSON.stringify(EVDetails)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        var EVReportDetails = result.EVReportDetails;
                        var ACReportDetails = result.ACReportDetails;
                        var PVandTotalBudgetReportDetails = result.PVandTotalBudgetReportDetails;
                        var PVDetails = new Array();
                        var TotalBudgetDetails = new Array();
                        var Weeks = new Array();
                        for (var i = 0; i < PVandTotalBudgetReportDetails.length; i++) {
                            PVDetails[i] = PVandTotalBudgetReportDetails[i].PlannedValue.toFixed(2);
                            TotalBudgetDetails[i] = PVandTotalBudgetReportDetails[i].TotalBudgetedCosts;
                            Weeks[i] = PVandTotalBudgetReportDetails[i].Weeks;
                        }
                        /*Earned value analysis graph start here*/
                        var ctx = document.getElementById("EVAnalysisChart");

                        var data = {
                            labels: Weeks,
                            datasets: [
                                {
                                    label: "PV Planned Value",
                                    fill: false,
                                    lineTension: 0.1,
                                    backgroundColor: "rgba(75,192,192,0.4)",
                                    borderColor: "rgba(75,192,192,1)",
                                    borderCapStyle: 'butt',
                                    borderDash: [],
                                    borderDashOffset: 0.0,
                                    borderJoinStyle: 'miter',
                                    pointBorderColor: "rgba(75,192,192,1)",
                                    pointBackgroundColor: "#fff",
                                    pointBorderWidth: 1,
                                    pointHoverRadius: 5,
                                    pointHoverBackgroundColor: "rgba(75,192,192,1)",
                                    pointHoverBorderColor: "rgba(220,220,220,1)",
                                    pointHoverBorderWidth: 2,
                                    pointRadius: 1,
                                    pointHitRadius: 10,
                                    data: PVDetails,
                                },
                                {
                                    label: "Total Budget Cost",
                                    fill: false,
                                    lineTension: 0.1,
                                    backgroundColor: "#fbb03b",
                                    borderColor: "#fbb03b",
                                    borderCapStyle: 'butt',
                                    borderDash: [],
                                    borderDashOffset: 0.0,
                                    borderJoinStyle: 'miter',
                                    pointBorderColor: "#fbb03b",
                                    pointBackgroundColor: "#fff",
                                    pointBorderWidth: 1,
                                    pointHoverRadius: 5,
                                    pointHoverBackgroundColor: "#fbb03b",
                                    pointHoverBorderColor: "#fbb03b",
                                    pointHoverBorderWidth: 2,
                                    pointRadius: 1,
                                    pointHitRadius: 10,
                                    data: TotalBudgetDetails,
                                }
                            ]
                        };

                        var myLineChart = new Chart(ctx, {
                            type: 'line',
                            data: data,
                        });
                        /*Earned value analysis graph end here*/

                    },
                    error: function (ER) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                    }
                });
            }
            catch (ex) {
                //alert(ex.text);
            }
        }

        // EV Details End Here Rutuja D. Added



        //Added By Rutuja D. For Filter Saving Functionality
        function saveFilter() {
            var FilterName = $("#txtFilterName").val().trim();
            var Flag;
            var filterExists = 0;

            if (FilterName == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_FilterName") %>');
                $("#txtFilterName").focus();
                return;
            }
           
            if (GlobalFilterName == undefined) {
                GlobalFilterName = "";
            }
            else {
                GlobalFilterName = GlobalFilterName;
            }

            if (FilterName != GlobalFilterName) {
                Flag = 0;
                FilterID = null;
            }
            else {
                Flag = 1;
            }

            if (FilterName != "" && GlobalFilterName == "") {
                filterExists = checkDuplicateFilter(FilterName, 3068);
            }


            // Here we check wheather we are doing normal saving or edit-saving

            if (FromEditOptionHolder == 1) {
                var ProjectID = $("#CboProject").val();
            } else {
                var ProjectID = $("#txtPHSFilterProjectName").val();
            }

            var Userid = encodeURI('<%= Session("intUserID") %>');
            var Logintype = encodeURI('<%= Session("LoginType") %>');
            var FilterName = $("#txtFilterName").val().trim();
            var UserName = '<%= Session("strUserName") %>';
            var querytext = PhaseQueryText
            var fid = EditFilterID;

            if (filterExists == 0) {
                var Parameters = {
                    TagID: PageTagID,
                    ProjectID: encodeURI(ProjectID),
                    UserID: encodeURI(Userid),
                    FilterName: encodeURI(FilterName),
                    LoginType: encodeURI(Logintype),
                    QueryText: encodeURI(querytext),
                    UserName: encodeURI(UserName),
                    FilterFlag: encodeURI(Flag),
                    FilterID: fid

                }
                try {

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectHealthSheet/SavedFilters',// Path
                        type: "POST",                                       //HTTP TYPE get /post
                        data: JSON.stringify(Parameters),       // Parameters
                        dataType: "json",                                   //Retrun Type 
                        contentType: "application/json; charset=utf-8",     //
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (Parameters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                            }
                        },
                        async: false,
                        success: function (result) {
                            GlobalApplyID = "Apply" + result;
                            ApplyCheckFilter(GlobalApplyID);
                            var currentSelectedProject = $("#txtPHSFilterProjectName").val();
                            callAllFunction(currentSelectedProject);
                            $("#Issuesavefilter").modal('hide');
                            $(".clearalllink").css("display", "inline-block");


                        },
                        error: function (ER) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + ""
                        }
                    });
                }
                catch (ex) {
                    //alert(ex.text);
                }
            }
        }

        //date function Keypress
        function Date_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = (e.keyCode == 8 || e.keyCode == 46)
            {
                if (e.keyCode == 8 || e.keyCode == 46) {

                }
            }
            return ret;
        }


        var m_CurrentToken = '';
        function GetPHSHelpDetails(TagID) {
            m_CurrentToken = '<%= m_PKToken%>';
            //Commented And Added By imran on 10-02-2022
            //window.open("../PM/PM_ProjectHealthSheet_Help.aspx", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");
            window.open("../PM/PM_ProjectHealthSheet_Help.aspx?PKToken=" + m_CurrentToken + "&TagID=" + TagID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");
            //End By imran on 10-02-2022
        }

        //Added by imran on 15-12-2021
        //Restrict Special Charaters onkeypress
        function restrictSpecialChars(e) {

            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
        }
        //End by imran 15-12-2021
    </script>

</body>
</html>
