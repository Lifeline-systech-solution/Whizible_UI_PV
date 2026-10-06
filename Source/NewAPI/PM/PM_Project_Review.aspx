<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Project_Review.aspx.vb" Inherits="Whizible.Project_Review" %>

<!DOCTYPE html>

<html>

    <!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->
   <%CommonFunctions.General.PlotPageHeadTag("Review")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Review</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=3">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-multiselect.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    
    <%--end--%>
  
</head>
    <style type="text/css">

        /* Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization */
        .taskQAtbl .checkbox-inline {
            width: 100%;
            padding-left: 0;
        }

        .bold {
            font-weight: bold;
        }
        /* End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization */

        /* Added by Vyankat B. on 1st April 2026 for highlighting the filter button when clicked */
        #btnAdvFilter[aria-expanded="true"] {
            background: #1359a6 !important;
            color: #fff !important;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }
        /* End of Added by Vyankat B. on 1st April 2026 for highlighting the filter button when clicked */  


        .alertify-notifier {
            z-index: 99999 !important;
        }

        .alertify-notifier {
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
        }

        .date-picker-wrapper .month-wrapper {
            overflow: hidden;
        }

        .conductdetail_panel {
            display: none;
        }

        .dataTables_scroll {
            margin-bottom: 15px;
        }

        .required {
            color: red;
        }



        .multiselect-native-select .btn-group {
            width: 100%;
        }

            .multiselect-native-select .btn-group button {
                width: 100%;
                min-height: 34px;
                text-align: left;
                overflow: hidden;
                text-overflow: ellipsis;
            }

                .multiselect-native-select .btn-group button b.caret {
                    float: right;
                    text-align: right;
                    margin-top: 6px;
                }

        .multiselect-native-select .multiselect-container {
            width: 100%;
            max-height: 300px;
            overflow-y: auto;
        }

        .multiselect-native-select .dropdown-menu > .active > a,
        .multiselect-native-select .dropdown-menu > .active > a:focus,
        .multiselect-native-select .dropdown-menu > .active > a:hover {
            background-color: #f0f1f5;
            color: #464a4c;
        }

        .multiselect-native-select .btn-group button span.multiselect-selected-text {
            width: 90%;
            display: inline-block;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .content-wrapper.projectreview {
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .toprightactions {
            margin-top: 10px;
        }

        .filterpanel .issuefilter_container .filterpanelbody {
            background: #fff;
        }

        .fbtnCR {
            display: none;
        }

        i.fas.fa-check.success {
            color: #81cf09;
        }

        i.fas.fa-times.alert {
            color: #eb1c24;
        }
        /*08-09-2019*/

        .conductdetail_panel {
            display: none;
            margin: 60px 0 0;
        }

        .RreqID {
            cursor: auto;
        }

        .conductdetail_panel .tab-content {
            min-height: 65vh;
        }

        .disableControl:hover {
            cursor: not-allowed;
        }

        .filterpanelplnReview .cust_tabpanel .MyFiltersdropdown {
            z-index: 999;
        }

        .filterpanelplnReviewCR .cust_tabpanel .MyFiltersdropdown {
            z-index: 999;
        }

        .filter button[aria-expanded="true"] {
            background: NONE;
            color: #464a4c;
            padding: 4px 6px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            border-radius: 4px;
        }

        /*New css add for filter alignment - 03-12-2019*/
        .stackbasicfilter .multiselect-native-select .btn-group {
            width: auto;
            min-width: 160px;
            margin: 0;
            padding: 0;
            height: 30px;
        }

            .stackbasicfilter .multiselect-native-select .btn-group button {
                min-height: 30px;
                font-size: 13px;
            }

        .stackbasicfilter .box ul.multiselect-container {
            max-height: 200px;
            overflow-y: auto;
            width: 250px;
        }

        .stackbasicfilter .multiselect-native-select .btn-group button b.caret {
            border-width: 4px;
        }

        .stackbasicfilter .multiselect-container > li > a {
            font-size: 13px;
            word-break: break-word;
            white-space: normal;
        }

        .stackbasicfilter .box ul.multiselect-container li label {
            padding-left: 30px;
            width: 100%;
        }

        .stackbasicfilter .form-inline .multiselect-container li a label.checkbox input[type=checkbox] {
            float: left;
        }

        .stackbasicfilter .box ul.multiselect-container {
            max-width: 200px;
            overflow-y: auto;
        }

        .stackbasicfilter .form-inline .form-control {
            width: 148px;
        }

        a.clearalllink {
            font-weight: bold;
            padding-top: 2px;
        }

        .stackbasicfilter .box label {
            width: 140px;
            text-align: right;
            margin-right: 10px;
            font-weight: 500;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            line-height: normal;
        }

        /*START by vishal mahajan 11-12-2019*/
        .disabledbutton {
            pointer-events: none;
            opacity: 0.7;
        }

        .custom_chckbox input[type=checkbox][disabled] {
            margin-right: 15px;
            CURSOR: NOT-ALLOWED;
        }

            .custom_chckbox input[type=checkbox][disabled] + label {
                margin-right: 15px;
                CURSOR: NOT-ALLOWED;
            }

        /*Added By Chetan M on 5 Dec 2019*/
        .custom_radio input[disabled="disabled"] + label {
            cursor: no-drop;
        }
        /*End of Addition by Chetan M.*/
        /*Added by Chetan M. on 18th Dec 2019*/
        .chcklistwarningmsg .alert-warning {
            height: 90px;
            line-height: 60px;
        }

        .alert.alert-warning.fade.in.alert-dismissible {
            font-size: 16px;
            text-align: center;
            color: #8a6d3b !important;
            background-color: #fcf8e3 !important;
            border-color: #faebcc !important;
            margin-bottom: 0px !important;
        }
        /*End of addition by Chetan M on 18th Dec 2019*/

        /*added by Vishal Mahajan 25-12-2019*/
        button[disabled], html input[disabled] {
            cursor: not-allowed;
        }

        .custom_chckbox input[type=checkbox][disabled] {
            margin-right: 15px;
            CURSOR: NOT-ALLOWED !important;
        }

        /* Added by Omkar T on 26-12-2019 */
        .taskQAtbl tr td:nth-child(2n) > div:first-child, .taskQAtbl tr td:nth-child(2n) > div:nth-child(4), .taskQAtbl tr td:nth-child(2n) > div:nth-child(7), .taskQAtbl tr td:nth-child(2n) > div:nth-child(10), .taskQAtbl tr td:nth-child(2n) > div:nth-child(13), .taskQAtbl tr td:nth-child(2n) > div:nth-child(16) {
            padding-left: 0;
            margin-left: 0;
        }

        #conductActiontbl .custom_chckbox label:before, #conductActiontbl .custom_chckbox input[type=checkbox][disabled] + label {
            margin-right: 0px;
        }

        #conductActiontbl > thead > tr > th:nth-child(8) {
            width: 14% !important;
        }

        #conductActiontbl > thead > tr > th:nth-child(10), #conductActiontbl > tbody > tr > td:nth-child(10) {
            width: 10% !important;
        }

        #Revoverview .righttopheading, #Revchklist .righttopheading, #RevActions .righttopheading, #Revchklistissue .righttopheading, #RevAttachment .righttopheading {
            margin-bottom: 10px;
        }

        .righttopheading h4 {
            font-size: 16px;
        }

        /*New css added by pradip on 26-12-2019*/
        .multiselect-container > li > a {
            word-wrap: break-word;
            white-space: normal;
        }

        div#planreview .projectreviewtbl th:not(:last-child) {
            min-width: 70px;
            vertical-align: middle;
        }
        /*New css end added by pradip on 26-12-2019*/
        /*css added by pradip on 30-12-2019*/
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

         /*modified css by pradip on 15-2-2021*/
 div#planreview .projectreviewtbl th:not(:last-child){min-width:100px; vertical-align:middle;}
  div#planreview .projectreviewtbl th:last-child{ min-width:50px;}
  /*End modified css by pradip on 15-2-2021*/

        #projectcondctreviewtbl tr th:first-child, #projectcondctreviewtbl tr td:first-child {
            text-align: left;
        }

        .dataTables_scrollBody {
            overflow: auto !important;
        }

        /**/
        .IB_filterlist .input-group.datefielddiv input {
            margin-right: 0px !important;
            border-radius: 4px 0 0 4px;width: 98px;
        }

        .stackbasicfilter .form-inline .form-control {
            margin-right: 6px;
        }

        .stackbasicfilter .input-group-btn button.btn.btncalendar {
            height: 28px;
        }
        /*31-12-2019*/
        table.dataTable td.dataTables_empty, table.dataTable th.dataTables_empty {
            text-align: center !important;
        }

        /*02-01-2019 added by pradip*/
        .tooltip {
            white-space: normal !important;
            word-break: break-all;
        }

        .dataTables_scrollHeadInner, .dataTables_scrollHead table {
            width: 100% !important;
        }


        /*New style Added by Omkar on 03-01-2020*/
        table.dataTable thead .sorting_asc:after, table.dataTable thead .sorting_desc:after, table.dataTable thead .sorting:after {
            top: 35%;
        }

        .table thead tr th {
            vertical-align: middle;
        }
        /*New style added by pradip on 03-01-2020*/
        table.dataTable {
            border-collapse: separate !important;
        }

        div#planreview .projectreviewtbl th:nth-child(6), div#planreview .projectreviewtbl td:nth-child(6) {
            min-width: 160px;
            width: 160px !important;
            max-width: 160px;
            word-wrap: break-word;
        }

        div#planreview .projectreviewtbl th {
            width: 70px; position:relative;
        }

        .table-fixed-header thead tr th, .table thead tr th {
            vertical-align: middle;
        }
        /* Modified By Gauri On 16th Sep 2024 For Datatable Sorting arrows Issue */
        table.dataTable thead .sorting::after, table.dataTable thead .sorting_asc::after, table.dataTable thead .sorting_desc::after, table.dataTable thead .sorting_asc_disabled::after, table.dataTable thead .sorting_desc_disabled::after {
            /* top: 24px !important; 
            position:absolute; 
            right:3px; */
            position: relative; 
            right: -5px;
            top: 0 !important;
        }
        
        /* #projectcondctreviewtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sorting_asc:after, #projectcondctreviewtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th:after {
            top: 15px !important;
        } */
        /* End of Modified By Gauri On 16th Sep 2024 For Datatable Sorting arrows Issue */


/*New Css*/
.dataTables_scrollBody thead tr{visibility: collapse !important;}
.mainreview_toprow .main_graybgtbs li{ min-width:120px;}
.input-group-btn button.btn.btncalendar{ background:#eee;}
.conductdetail_panel {
    margin: 40px 0px 0;
    display: none;
    border: 1px solid #ddd;
    border-radius: 4px; padding:10px;
}
ul.nav.nav-tabs.detailsubtabs {
    background: #f5f5f5;
    margin: -11px -11px;
    padding: 10px 10px 0;
    border: 1px solid #ddd;
    border-radius: 4px 4px 0 0;
}
.detailsubtabs li:hover a, .detailsubtabs li:focus a {
    color: #1359ac;
    background: #fff;
}

.IB_filterlist label + .form-select {
    width: 110px!important;
    margin-right: 5px;
}
.IB_filterlist .form-select, .IB_filterlist .form-control, .IB_filterlist .input-group {
    display: inline-block;
    width: 148px;
    height: 30px;
    vertical-align: top;
    /* Modified By Madhuri.K On 26-03-2026 */
    font-size: 11.5px!important;
}
.IB_filterlist .form-group label {
    min-width: 140px;
    /* Modified By Madhuri.K On 26-03-2026 */
    font-size: 11.5px;
    text-align: right;
    padding-right: 10px;
}
.IB_filterlist .form-group {
    margin-bottom: 5px;
}
.ClosaeblealertMsg{ display:none;}
.alert .close {
    color: #fff;
    opacity: 1;
    float: right;
    /* Modified By Madhuri.K On 26-03-2026 */
    font-size: 11.5px; background:none; border:none;
}
button#PRaddattachnebtrow {white-space: nowrap;}
div.dataTables_wrapper div.dataTables_paginate {
    margin: 10px 0px 0;
}
.bootstrap-datetimepicker-widget button{ height:30px;}
button.multiselect:hover, button.multiselect:focus{ color: #464a4c;}
button.btn.dropdown-toggle.btn-default{ background-color:transparent;}
.dropdown-menu>li:hover {background-color: #e1e3e9;color: #333;}
.multiselect-native-select .dropdown-menu > .active , .multiselect-native-select .dropdown-menu > .active:focus, .multiselect-native-select .dropdown-menu > .active:hover {background-color: #f0f1f5;
    color: #464a4c;}
.filterpanelplnReviewCR .caret{display:none}


        /* .bootstrap-datetimepicker-widget .btn {
            color: #414042; 
            top: -20px !important;
        }*/
    </style>

<body id="bodyPMProjectReview" class=" hold-transition skin-blue-light sidebar-mini fixed">

    <!-- Content Wrapper. Contains page content -->
    <div class="projectreview">
        <!-- Content Header (Page header) -->
        <div class="row pt-1 pb-1">
            <div class="col-sm-3">
                <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-select'", False,, ) %>
            </div>
            <div class="col-sm-9"></div>
            <div class="clearfix"></div>
        </div>



        <div id="divmainreviewheader" class="graybg mainreview_toprow container-fluid">
            <div class="row">
                <div class="col-sm-8">
                    <ul class="nav nav-tabs main_graybgtbs float-start pt-1 pb-1">
                        <li class="active">
                            <a href="#planreview" id="tabPlanReview" data-bs-toggle="tab" aria-expanded="false"><%= MyBase.GetResourceString("C_Button_Planned_Review") %></a>
                        </li>
                        <li class="">
                            <a href="#conductreview" id="tabConductedReview" data-bs-toggle="tab" aria-expanded="false"><%= MyBase.GetResourceString("C_Button_Conduct_Review") %></a>
                        </li>
                    </ul>
                </div>
                <div class="col-sm-4">
                    <div class="toprightactions">

                        <div class="filter float-end ml-1">
                            <button data-bs-toggle="collapse" id="btnAdvFilterCR" data-bs-target="#filterpanelplnReviewCR" data-original-title="" title="" class="fbtnCR">
                                <i data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Advance_Filter") %>" class="fas fa-filter"></i>
                            </button>
                            <button data-bs-toggle="collapse" id="btnAdvFilter" data-bs-target="#filterpanelplnReview" data-original-title="" title="" class="fbtnPR">
                                <i data-bs-toggle="tooltip" data-bs-placement="top" title="<%= MyBase.GetResourceString("C_Advance_Filter") %>" class="fas fa-filter"></i>
                            </button>
                        </div>
                        <a href="javascript:;" class="clearalllink float-end" style="display: none" onclick="GetAllReviews(null)" id="PMProjectReviewCRClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom">Clear All</a>
                        <a href="javascript:;" class="clearalllink float-end" style="display: none" onclick="GetAllReviews(null)" id="PMProjectReviewClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom">Clear All</a>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal popup for converting observation to action-->
        <div class="modal custmodal  fade" id="divConvertToAction" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="true">
            <input type="hidden" id="hdnConvertedActionID" value="" />
            <div class="modal-dialog" role="document">
                <div class="modal-content" id="NewStageContent">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Convert_To_Action") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="tab-content ">
                            <div class="tab-pane active" id="wbsbasic">
                                <div class="row">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <label class=""><%= MyBase.GetResourceString("C_Cause") %></label>
                                            <span class="required">* </span>
                                            <select class="form-select " id="CboModalCauses"></select>
                                            <br />
                                            <label class=""><%= MyBase.GetResourceString("C_Action") %></label>
                                            <span class="required">* </span>
                                            <textarea id="txtmodalDecription" maxlength="1000" class="form-control"></textarea>
                                            <br />
                                            <label class=""><%= MyBase.GetResourceString("C_Work") %></label>
                                            <span class="required">* </span>
                                            <input type="text" id="txtmodalWork" maxlength="7" class="form-control work" />
                                            <br />
                                            <label class=""><%= MyBase.GetResourceString("C_Reviewee") %></label>
                                            <span class="required">* </span>
                                            <select class="form-select " id="CboModalReviewee"></select>
                                        </div>
                                    </div>

                                    <div class="form-group">&nbsp;</div>
                                    <div class="clearfix"></div>
                                    <div class="form-group text-center">
                                        <button class="btn borderbtn borderbtnfill" id="btnSaveModal"><%= MyBase.GetResourceString("C_Save") %></button>
                                        <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Cancel") %></button>
                                    </div>
                                </div>

                            </div>
                            <!-- /.content -->
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Modal End Here -->
            <div class="clearfix"></div>
        </div>

        <div class="clearfix"></div>
        <div class="tab-content content bgwhite">
            <!--Plan review tab content start here-->
            <div class="tab-pane active" id="planreview">

                <!--filter_panel_section_satrts_here-->
                <div id="filterpanelplnReview" class="collapse filterpanel filterpanelplnReview bgwhite" style="border-bottom: 12px solid #eee;">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                        <div class="row">
                            <div class="col-md-10 col-sm-10">
                                <div class="cust_tabpanel">
                                    <ul class="nav nav-tabs">
                                        <li class="dropdown">
                                            <%--Commented and Added by Riddhesh Patil on 10th April 2023--%>
                                            <%--<a class="dropdown-toggle" href="javascript:;" data-bs-toggle="dropdown">My Filters</a>--%>
                                            <a class="dropdown-toggle" href="javascript:;" data-bs-toggle="dropdown" onclick="PMProjectReviewGetMyFiltersList();">My Filters</a>
                                             <%--End of Commented and Added by Riddhesh Patil on 10th April 2023--%>
                                            
                                            <ul id="PMProjectReviewMyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                           
                                            </ul>
                                        </li>
                                        <li id="basicfilterli" class="">
                                            <a href="#presetfilterML" id="PlanReviewBasicFilter" onclick="ResetEditFilterID();" data-bs-toggle="tab">Basic Filters</a>
                                        </li>
                                        <!-- <li><a href="#queryfilterML" data-bs-toggle="tab">Advanced Filters</a></li> -->
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="issuefilter_container">
                        <div class="tab-content issuefilter_tabcontent">

                            <!-- Modal -->
                            <div class="modal custmodal  fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="">Save Filter As </h5>
                                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="box-panel">

                                                <div class="box-body graybg">
                                                    <div class="mb-0">
                                                        <div class="row">
                                                            <div class="col-md-12 row">
                                                                <label class="control-label col-md-4 p-0 text-end">Filter Name <span class="required"> * </span> :</label>
                                                                <span class="col-md-8">
                                                                    <input type="hidden" name="FilterID" id="FilterID" value="0" />
                                                                    <input type="hidden" name="QueryID" id="QueryID" value="0" />
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("filterName", "txtFilterName", "form-control",, 500,,,, ,,,,,,, True,,,,) %><br />
                                                                    <div class="btnrow">
                                                                        <button class="btn btnyellow float-start savefilter" id="btnSaveBasicFilter" onclick="SavePMProjectReviewFilter()">Save</button>
                                                                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
                                                                    </div>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <!-- /.content -->
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--modal-end-here-->
                            <div id="presetfilterML" class="tab-pane stackbasicfilter">
                                <!--filter panel start here-->
                                <div class="filterpanelwrapbasicfilter">
                                    <div class="filterpanelbody" id="accordion">
                                        <div class="fp_button text-center hidden-xs centerbtn" style="margin: 0 0 40px;">
                                            <button class="btn btnyellow" id="btnsaveandapply1" onclick="btnPMProjectReviewSaveAndApplyFilter_Onclick()">Save and Apply</button>
                                            <button class="btn btnyellow" onclick="PMProjectReviewbtnApplyFilter()">Apply</button>
                                        </div>

                                        <div class="row hidden-xs IB_filterlist">
                                            <!--basic filter start here-->
                                            <div class="form-inline">
                                                <div class="row p1" style="">
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Type") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterPReviewTypeID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWFilterPReviewTypeID", "usp_Sel_tbl_PM_ProjectReviewTypes " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select'", True,, ) %>
                                                    </div>

                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Title") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterReviewTitle", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWFilterReviewTitle", "txtPMRWFilterReviewTitle", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Reviewer") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterReviewedBy", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWFilterReviewedBy", "txtPMRWFilterReviewedBy", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Reviewee") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterReviewee", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWFilterReviewee", "txtPMRWFilterReviewee", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                    </div>
                                                
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Planned_From") %>Review Planned From:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterReviewStartDate", "usp_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-select'", False,, ) %>
                                                        <div class="input-group datefielddiv">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWFilterReviewStartDate", "txtPMRWFilterReviewStartDate", "form-control Mandatory",,,,,,, True, "white")%>
                                                            <span class="input-group-btn">
                                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                            </span>
                                                        </div>
                                                        <!--modiefied on 31-12-2019-->
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Planned_To") %>Review Planned To:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterReviewEndDate", "usp_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-select'", False,, ) %>
                                                        <div class="input-group datefielddiv">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWFilterReviewEndDate", "txtPMRWFilterReviewEndDate", "form-control Mandatory",,,,,,, True, "white")%>
                                                            <span class="input-group-btn">
                                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                            </span>
                                                        </div>
                                                    </div>
                                          
                                                    <%--    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Send_Review_Invite") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterIsSendReviewInvite", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-control'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWFilterIsSendReviewInvite", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-control'", True,,) %>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Work_Product_Type")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterWorkProductType", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWFilterWorkProductType", "usp_Whizible2_Sel_tbl_PM_WorkProductTypes ",,, "class='form-control'", True,, ) %>
                                                    </div>   --%>
                                               
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Billable")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterIsReviewBillable", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWFilterIsReviewBillable", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'", True,,) %>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Offline_Review")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterIsOfflineReview", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWFilterIsOfflineReview", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'", True,,) %>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <div id="divIterationFilter" style="display: none;" class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Iteration")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterIterationID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWFilterIterationID" class="form-select "></select>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                              <hr />
                                                <div class="row p1" style="">
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Sub_Project")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterSubProjectID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWFilterSubProjectID" class="form-select "></select>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Phase")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterPhaseID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWFilterPhaseID" class="form-select "></select>
                                                    </div>
                                             
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Milestone")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterMilestoneID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWFilterMilestoneID" class="form-select "></select>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Module")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterModuleID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWFilterModuleID" class="form-select "></select>
                                                    </div>
                                                 
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Deleverable")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWFilterDeliverableID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWFilterDeliverableID" class="form-select "></select>
                                                    </div>
                                                    <br />
                                                    <div class="clearfix"></div>
                                                </div>




                                            </div>
                                            <!--basic filter end here-->
                                            <div class="clearfix"></div>
                                        </div>

                                    </div>
                                </div>
                                <hr>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <!--end filter for--plan review-->
                <!--filter panel-end-here-->

                <div class="bgwhite col-sm-12 pt-1 pb-1 pl-0">
                    <!--removed class "pt-1" -pradip on 27-12-2019-->
                    <button id="btnAddNewReview" class="btn borderbtn newreviewbtn">+ <%= MyBase.GetResourceString("C_Button_Add_Review") %></button>
                </div>
                <div class="clearfix"></div>
                <table id="projectplanreviewtbl" class="table bgwhite table-bordered projectreviewtbl" style="width: 100%;">
                </table>
                <div class="clearfix"></div>
                <div id="ProaddnewreviewPanel" class="collapse bgwhite">
                    <div class="formbody px-0" id="formoverview">
                        <div class="col-sm-12 righttopheading pt-1 pb-1 graybg clearfix">
                            <h4 class="float-start m-0 pt-Onehalf reviewtitlefield">
                                <input type="text" id="txtAddReview" maxlength="50" name="" placeholder="Add Review title here" class="Mandatory"></h4>
                            <div class="float-end">
                                <a href="javascript:;" id="btnSaveReview" class="btn btnyellow float-end ml-1""><%= MyBase.GetResourceString("C_PlannedReview_Save") %></a>
                                <a href="javascript:;" class="btn borderbtn float-end ml-1 canclebtn"><%= MyBase.GetResourceString("C_PlannedReview_Cancel") %></a>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                        <br />
                        <div class="newproformrow">
                            <div class="form-group row mb-3">
                                <div class="col-sm-3">
                                    <label class="control-label "><%= MyBase.GetResourceString("C_Review_Type") %></label><span class="required"> * </span>
                                    <%--  <select class="form-control selectpicker">
                                        <option>Design</option>
                                        <option>Developing</option>
                                        <option>Intigration</option>
                                    </select>--%>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboReviewType", "usp_Sel_tbl_PM_ProjectReviewTypes " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select Mandatory' ", True,, ) %>
                                </div>
                                <div class="col-sm-3">
                                    <label class="control-label"><%= MyBase.GetResourceString("C_Work") %></label><span class="required"> * </span>
                                    <div class="row">
                                        <div class="col-sm-10">
                                            <%--<input type="text" class="form-control" name="" id="txtWork">--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("", "txtWork", "form-control Mandatory",, 7)%>
                                        </div>
                                        <div class="col-sm-2 p-0"><%= MyBase.GetResourceString("C_Hrs") %></div>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <label class="control-label"><%= MyBase.GetResourceString("C_Start_Date") %></label><span class="required"> * </span>
                                    <div class="input-group">
                                        <%--<input id="txtStartDate" type="text" class="form-control">--%>
                                        <%--  Added By Dipali  V On 8th May 2020 For IssueID 24212--%>
                                        <%--  <% CommonFunctions.HTMLControls.DrawTextBox("", "txtStartDate", "form-control Mandatory", , ,,,,,)%>--%>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("", "txtStartDate", "form-control Mandatory", , ,,,,, True, "white")%>
                                        <%--  End of Added By Dipali  V On 8th May 2020 For IssueID 24212--%>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <label class="control-label"><%= MyBase.GetResourceString("C_End_Date") %></label><span class="required"> * </span>
                                    <div class="input-group">
                                        <%--<input id="txtEndDate" type="text" class="form-control">--%>
                                        <%--  Added By Dipali  V On 8th May 2020 For IssueID 24212--%>
                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("", "txtEndDate", "form-control Mandatory")%>--%>
                                        <% CommonFunctions.HTMLControls.DrawTextBox("", "txtEndDate", "form-control Mandatory",,,,,,, True, "white")%>
                                        <%--End of   Added By Dipali  V On 8th May 2020 For IssueID 24212--%>
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                        </div>

                        <div class="form-group row mb-3">
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Start_Time") %></label><span class="required"> * </span>
                                <div class="input-group bootstrap-timepicker timepicker">
                                    <%--<input id="txtStartTime" type="text" class="form-control input-small">--%>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("", "txtStartTime", "form-control input-small Mandatory",, 8)%>
                                    <span class="input-group-text"><i class="far fa-clock"></i></span>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_End_Time") %></label><span class="required"> * </span>
                                <div class="input-group bootstrap-timepicker timepicker">
                                    <%--<input id="txtEndTime" type="text" class="form-control input-small">--%>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("", "txtEndTime", "form-control input-small Mandatory",, 8)%>
                                    <span class="input-group-text"><i class="far fa-clock"></i></span>
                                </div>

                            </div>

                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Time_Zone") %></label><span class="required"> * </span>
                                <select class="form-select Mandatory" id="cboTimeZone">
                                </select>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label">&nbsp;</label>
                                <div id="divSendInvite" class="custom_chckbox" style="display: block;">
                                    <input type="checkbox" id="chkSendReviewInvite" class="">
                                    <label for="chkSendReviewInvite"><%= MyBase.GetResourceString("C_Send_Review_Invite") %> </label>
                                </div>
                                <div id="divCancelInvite" class="custom_chckbox" style="display: none;">
                                    <input type="hidden" id="hdnCancelReviewInvite" value="0" />
                                    <input type="checkbox" id="chkCancelReviewInvite" class="">
                                    <label for="chkCancelReviewInvite"><%= MyBase.GetResourceString("C_Send_Review_Cancellation") %></label>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group row mb-3">
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Reviewer") %></label><span class="required"> * </span>
                                <div class="row">
                                    <div class="col-sm-10">
                                        <select id="cboReviwer" type="text" class="form-select multiselect multiselect-icon multiselectdropdown Mandatory" multiple="multiple" role="multiselect">
                                            <%--  <option value="0" data-icon="glyphicon-picture text-primary">Sam Jhon</option>
                                            <option value="1" data-icon="glyphicon-link">James D.</option>
                                            <option value="2" data-icon="glyphicon-pencil text-danger">Sandeep A.</option>
                                            <option value="3" data-icon="glyphicon-shopping-cart">Sam Jhon</option>
                                            <option value="4" data-icon="glyphicon-shopping-cart">Lorem Ipsum</option>
                                            <option value="5" data-icon="glyphicon-shopping-cart">Robert C</option>
                                            <option value="6" data-icon="glyphicon-shopping-cart">Ken M</option>
                                            <option value="9" data-icon="glyphicon-shopping-cart">Pady P</option>
                                            <option value="8" data-icon="glyphicon-shopping-cart">Smith K.</option>--%>
                                        </select>
                                    </div>
                                    <div class="col-sm-2 p-0">
                                        <span class="">
                                            <img src="../../../Whizible2.0-new/dist/img/add-resource.svg" width="32px" alt=""></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Reviewee") %></label><span class="required"> * </span>
                                <div class="row">
                                    <div class="col-sm-10">
                                        <select id="cboReviwee" type="text" class="form-select multiselect multiselect-icon multiselectdropdown Mandatory" multiple="multiple" role="multiselect">
                                            <%-- <option value="0" data-icon="glyphicon-picture text-primary">Sam Jhon</option>
                                            <option value="1" data-icon="glyphicon-link">James D.</option>
                                            <option value="2" data-icon="glyphicon-pencil text-danger">Sandeep A.</option>
                                            <option value="3" data-icon="glyphicon-shopping-cart">Sam Jhon</option>--%>
                                        </select>
                                    </div>
                                    <div class="col-sm-2 p-0">
                                        <span>
                                            <img src="../../../Whizible2.0-new/dist/img/add-resource.svg" width="32px" alt=""></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Offline_Review")%></label>
                                <div class="custom_chckbox">
                                    <input type="checkbox" id="chkOfflineReview" class="">
                                    <label for="chkOfflineReview">
                                        <small><em class="float-end">Reviewee will be optional if<br />
                                            offline review is checked</em></small>
                                    </label>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <%-- <div class="col-sm-3">
                                <label class="control-label">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <input type="checkbox" id="chkWorkProductType" class="">
                                    <label for="chkWorkProductType">Work product type</label>
                                </div>
                            </div>--%>

                            <div class="col-sm-3">
                                <label class="control-label">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <input type="checkbox" id="chkBillable" class="">
                                    <label for="chkBillable"><%= MyBase.GetResourceString("C_Billable")%></label>
                                </div>
                            </div>

                            <%-- <div class="col-sm-3">
                                <label class="control-label">&nbsp;</label>
                                <div class="custom_chckbox">
                                    <input type="checkbox" id="chkSendReviewInvite" class="">
                                    <label for="chkSendReviewInvite">Send Review Invite</label>
                                </div>
                            </div>--%>


                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group row mb-3">

                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Work_Product_Type")%></label>

                                <select id="cboWorkProductType" class="form-select">
                                    <%-- <option>Option 1</option>
                                    <option>Option 2</option>
                                    <option>Option 3</option>--%>
                                </select>
                            </div>

                            <%-- <div class="col-sm-3">
                                <label class="control-label">Deliverable</label>

                                <input type="tetx" class="form-control" name="" placeholder="">
                            </div>--%>

                            <div class="col-sm-3" style="display: none">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Checklist")%></label>

                                <select id="cboChecklist" class="form-select ">
                                    <%--<option>Option 1</option>
                                    <option>Option 2</option>
                                    <option>Option 3</option>--%>
                                </select>

                            </div>
                            <div class="col-sm-3" style="display: none">
                                <label class="control-label"><%= MyBase.GetResourceString("C_No_of_defects")%></label>
                                <%--<input type="txtNoOfDefects" class="form-control" name="" placeholder="">--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("", "txtNoOfDefects", "form-control")%>
                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Note")%></label>
                                <textarea class="form-control" id="txtAreaNote" maxlength="2000"></textarea>
                                <% 'CommonFunctions.HTMLControls.DrawTextArea("", "txtAreaNote", "form-control")%>
                            </div>


                            <div class="col-sm-3" id="divSprintPlanReview">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Iteration")%></label>
                                <span class="required">* </span>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CboIteration", "usp_Whizible2_Sel_tbl_PM_ScrumIterationforRetrospective_Review " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select'", True,, ) %>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <div class="form-group row mb-3">

                            <div class="clearfix"></div>
                        </div>
                        <hr />
                        <div class="form-group row mb-3">
                            <h6><%= MyBase.GetResourceString("C_WBS_Attributes")%></h6>

                            <div class="col-sm-3">&nbsp;</div>
                            <div class="col-sm-3">&nbsp;</div>
                            <div class="col-sm-3">&nbsp;</div>
                            <div class="clearfix"></div>
                        </div>
                        <div class="row form-group mb-3">
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Sub_Project")%></label>
                                <select id="CboSubproject" class="form-select ">
                                    <%--<option>Sub Project 1</option>
                                    <option>Sub Project 2</option>
                                    <option>Sub Project 3</option>--%>
                                </select>

                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Phase")%></label>
                                <%--By Vishal Mahajan 28-12-2019--%>
                                <span class="required">* </span>
                                <select id="CboPhase" class="form-select">
                                </select>

                            </div>

                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Milestone")%></label>

                                <select id="CboMilestones" class="form-select">
                                    <%--<option>Milestone 1</option>
                                    <option>Milestone 2</option>
                                    <option>Milestone 3</option>--%>
                                </select>

                            </div>
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Module")%></label>
                                <select id="CboModules" class="form-select">
                                    <%-- <option>Module 1</option>
                                    <option>Module 2</option>
                                    <option>Module 3</option>--%>
                                </select>

                            </div>
                        </div>
                        <div class="row form-group mb-3">
                            <div class="col-sm-3">
                                <label class="control-label"><%= MyBase.GetResourceString("C_Deleverable")%></label>
                                <select id="CboDeliverables" class="form-select"></select>
                            </div>
                            <div class="clearfix"></div>
                        </div>

                        <br />
                        <br />

                    </div>
                </div>
                <div class="clearfix"></div>

            </div>
            <!--Plan review tab content end here-->
            <!--conduct review tab content start here-->
            <div class="tab-pane" id="conductreview">
                <!--filter_panel_section_satrts_here-->
                <div id="filterpanelplnReviewCR" class="collapse filterpanel filterpanelplnReviewCR bgwhite" style="border-bottom: 12px solid #eee;">
                    <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                        <div class="row">
                            <div class="col-md-10 col-sm-10">
                                <div class="cust_tabpanel">
                                    <ul class="nav nav-tabs">
                                        <li class="dropdown">
                                            <%--Commented and Added by Riddhesh Patil on 10th April 2023--%>
                                           <%-- <a class="dropdown-toggle" href="javascript:;" data-bs-toggle="dropdown">My Filters</a>--%>
                                            <a class="dropdown-toggle" href="javascript:;" data-bs-toggle="dropdown" onclick="PMProjectReviewCRGetMyFiltersList();">My Filters</a>
                                            <%--End of Commented and Added by Riddhesh Patil on 10th April 2023--%>

                                            <ul id="PMProjectReviewCRMyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu" >
                                            </ul>
                                        </li>
                                        <li id="basicfilterCRli" class="">
                                            <a href="#presetfilterCR" id="PlanReviewCRBasicFilter" data-bs-toggle="tab">Basic Filters</a>
                                        </li>
                                        <!-- <li><a href="#queryfilterML" data-bs-toggle="tab">Advanced Filters</a></li> -->
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="issuefilter_container">
                        <div class="tab-content issuefilter_tabcontent">
                            <!-- Modal -->
                            <div class="modal custmodal  fade" id="CRIssuesavefilter" tabindex="-1" role="dialog" aria-labelledby="taskeditorlabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="">Save Filter As </h5>
                                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="box-panel">

                                                <div class="box-body graybg">
                                                    <div class="form-group mb-0">
                                                        <div class="row">
                                                            <div class="col-md-12 row">
                                                                <label class="control-label col-md-4 p-0 text-end">Filter Name <span class="required"> * </span> :</label>
                                                                <span class="col-md-8">
                                                                    <input type="hidden" name="CRFilterID" id="CRFilterID" value="0" />
                                                                    <input type="hidden" name="CRQueryID" id="CRQueryID" value="0" />
                                                                    <% CommonFunctions.HTMLControls.DrawTextBox("CRfilterName", "txtFilterNameCR", "form-control",, 500,,,, ,,,,,,, True,,,,) %><br />
                                                                    <div class="btnrow">
                                                                        <button class="btn btnyellow float-start savefilter" id="btnSaveBasicFilterCR" onclick="SavePMProjectReviewCRFilter()">Save</button>
                                                                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
                                                                    </div>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <!-- /.content -->
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--modal-end-here-->

                            <div id="presetfilterCR" class="tab-pane stackbasicfilter">
                                <!--filter panel start here-->
                                <div class="filterpanelwrapbasicfilter">
                                    <div class="filterpanelbody" id="accordion">
                                        <div class="fp_button text-center hidden-xs centerbtn" style="margin: 0 0 40px;">
                                            <button class="btn btnyellow" id="btnsaveandapplycr" onclick="btnPMProjectReviewCRSaveAndApplyFilter_Onclick()">Save and Apply</button>
                                            <button class="btn btnyellow" onclick="PMProjectReviewCRbtnApplyFilter()">Apply</button>
                                        </div>

                                        <div class="row hidden-xs IB_filterlist">
                                            <!--basic filter conduct review start here-->
                                            <div class="form-inline">
                                                <div class="box box-solid p1 row" style="">
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Type") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterPReviewTypeID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWCRFilterPReviewTypeID", "usp_Sel_tbl_PM_ProjectReviewTypes " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-control'", True,, ) %>
                                                    </div>

                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Title") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterReviewTitle", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWCRFilterReviewTitle", "txtPMRWCRFilterReviewTitle", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                    </div>
                                                    <br />
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Reviewer") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterReviewedBy", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWCRFilterReviewedBy", "txtPMRWCRFilterReviewedBy", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Reviewee") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterReviewee", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWCRFilterReviewee", "txtPMRWCRFilterReviewee", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                                    </div>
                                                    <br />
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Planned_From") %>Review Planned From:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterReviewStartDate", "usp_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-select'", False,, ) %>
                                                        <div class="input-group datefielddiv">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWCRFilterReviewStartDate", "txtPMRWCRFilterReviewStartDate", "form-control Mandatory",, ,,,,, True, "white")%>
                                                            <span class="input-group-btn">
                                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                            </span>
                                                        </div>
                                                        <!--modified by pradip on 31-12-2019-->
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Planned_To") %>Review Planned To:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterReviewEndDate", "usp_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-select'", False,, ) %>
                                                        <div class="input-group datefielddiv">
                                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWCRFilterReviewEndDate", "txtPMRWCRFilterReviewEndDate", "form-control Mandatory",, ,,,,, True, "white")%>
                                                            <span class="input-group-btn">
                                                                <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                            </span>
                                                        </div>
                                                        <!--modified by pradip on 31-12-2019-->
                                                    </div>
                                                    <br />
                                                    <%--<div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Actual_From") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterActualStartDate", "usp_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-control'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWCRFilterActualStartDate", "txtPMRWCRFilterActualStartDate", "form-control Mandatory")%>
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Review_Actual_To") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterActualEndDate", "usp_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-control'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtPMRWCRFilterActualEndDate", "txtPMRWCRFilterActualEndDate", "form-control Mandatory")%>
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </div>
                                                    <br />--%>
                                                    <%--<div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Send_Review_Invite") %>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterIsSendReviewInvite", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-control'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWCRFilterIsSendReviewInvite", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-control'", True,,) %>
                                                    </div>
                                                     <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Work_Product_Type")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterWorkProductType", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWCRFilterWorkProductType", "usp_Whizible2_Sel_tbl_PM_WorkProductTypes ",,, "class='form-control'", True,, ) %>
                                                    </div>--%>
                                                    <br />
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Billable")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterIsReviewBillable", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWCRFilterIsReviewBillable", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'", True,,) %>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Offline_Review")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterIsOfflineReview", "usp_Sel_Filter_FillOperatorCombo 'BIT'",,, "class='form-select'", False,, ) %>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("txtPMRWCRFilterIsOfflineReview", "usp_Whizible2_Sel_Filter_YesNo ",,, "class='form-select'", True,,) %>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <div id="divCRIterationFilter" style="display: none;" class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Iteration")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterIterationID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWCRFilterIterationID" class="form-select "></select>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <%--<div class="box box-solid p1" style="">
                                                    <div class="form-group col-sm-12">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Note")%>:</label>
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterReviewNotes", "usp_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-control'", False,, ) %>
                                                        <%CommonFunctions.HTMLControls.DrawTextArea("txtPMRWCRFilterReviewNotes", "txtPMRWCRFilterReviewNotes", "", "form-control", , , , , , , 1000, , , "width: 60%;max-width: 60%;", , , , ,, , , , , , , , , , True)%>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>--%>
                                                <div class="box box-solid p1 row" style="">
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Sub_Project")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterSubProjectID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWCRFilterSubProjectID" class="form-select"></select>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Phase")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterPhaseID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWCRFilterPhaseID" class="form-select"></select>
                                                    </div>
                                                    <br />
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Milestone")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterMilestoneID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWCRFilterMilestoneID" class="form-select "></select>
                                                    </div>
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Module")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterModuleID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWCRFilterModuleID" class="form-select "></select>
                                                    </div>
                                                    <br />
                                                    <div class="form-group col-sm-6">
                                                        <label for="email"><%= MyBase.GetResourceString("C_Deleverable")%>:</label>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPMRWCRFilterDeliverableID", "usp_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select'", False,, ) %>
                                                        <select id="txtPMRWCRFilterDeliverableID" class="form-select"></select>
                                                    </div>
                                                    <br />
                                                    <div class="clearfix"></div>
                                                </div>

                                            </div>
                                            <!--basic filter conduct review end here-->
                                            <div class="clearfix"></div>
                                        </div>

                                    </div>
                                </div>
                                <hr>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <!--end filter for--plan review-->
                <!--filter panel-end-here-->
                <div class="clearfix"></div>
                <table id="projectcondctreviewtbl" class="table bgwhite table-bordered projectreviewtbl" style="width: 100%;">
                </table>
                <div class="clearfix"></div>
                <div class="conductdetail_panel">
                    <ul class="nav nav-tabs detailsubtabs">
                        <li class="nav-item">
                            <a href="#Revoverview" id="liRevoverview" class="nav-link active" data-bs-toggle="tab" aria-expanded="true"><%= MyBase.GetResourceString("C_Tab_Details") %></a>
                        </li>
                        <li class="nav-item">
                            <a href="#RevActions" id="liRevActions" class="nav-link" data-bs-toggle="tab" aria-expanded="false"><%= MyBase.GetResourceString("C_Tab_Actions") %></a>
                        </li>
                        <li class="nav-item">
                            <a href="#Revchklist" id="liRevchklist" class="nav-link" data-bs-toggle="tab" aria-expanded="false"><%= MyBase.GetResourceString("C_Tab_Checklist") %></a>
                        </li>
                        <li class="nav-item">
                            <a href="#Revchklistissue" id="liRevchklistissue" class="nav-link" class="nav-link" data-bs-toggle="tab" aria-expanded="false"><%= MyBase.GetResourceString("C_Tab_Checklist_Issues") %></a>
                        </li>
                        <li class="nav-item">
                            <a href="#RevAttachment" id="liRevAttachment" class="nav-link" data-bs-toggle="tab" aria-expanded="true"><%= MyBase.GetResourceString("C_Tab_Attachments") %> </a>
                        </li>
                    </ul>
                    <div class="clearfix"></div>
                    <div class="detailpanelbody">
                        <div class="tab-content bgwhite">
                            <!--tab overview start here-->
                            <div class="tab-pane active" id="Revoverview">
                                <div class="col-sm-12 righttopheading pt-1 pb-1 graybg clearfix px-3">
                                    <h4 class="float-start m-0 pt-Onehalf" id="txtAddReviewcr"></h4>
                                    <a id="btnSaveReviewcr" class="btn btnyellow float-end ml-1"><%= MyBase.GetResourceString("C_PlannedReview_Save") %></a>
                                    <a href="javascript:;" class="btn borderbtn float-end CRbackbtn"><%= MyBase.GetResourceString("C_PlannedReview_Cancel") %></a>
                                </div>
                                <div class="clearfix"></div>
                                <div class="" id="formoverview2">
                                    <!--removed class "formbody" - commented by Omkar T on 27-12-2019-->

                                    <div class="newproformrow">

                                        <div class="form-group row mb-3">
                                            <div class="col-sm-3">
                                                <label class="control-label"><%= MyBase.GetResourceString("C_Review_Type") %></label><span class="required"> * </span>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboReviewTypecr", "usp_Sel_tbl_PM_ProjectReviewTypes " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select Mandatorycr' ", True,, ) %>
                                            </div>
                                            <div class="col-sm-3">
                                                <label class="control-label"><%= MyBase.GetResourceString("C_Work") %></label><span class="required"> * </span>
                                                <div class="row">
                                                    <div class="col-sm-10">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("", "txtWorkcr", "form-control Mandatorycr",, 7)%>
                                                    </div>
                                                    <div class="col-sm-2 p-0"><%= MyBase.GetResourceString("C_Hrs") %></div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <label class="control-label"><%= MyBase.GetResourceString("C_Start_Date") %></label><span class="required"> * </span>
                                                <div class="input-group">
                                                    <%-- Added By Dipali V On 8th May 2020 For IsseID24212--%>
                                                    <%--<% CommonFunctions.HTMLControls.DrawTextBox("", "txtStartDatecr", "form-control Mandatorycr")%>--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("", "txtStartDatecr", "form-control Mandatorycr",,,,,,, True, "white")%>
                                                    <%--End of Added By Dipali V On 8th May 2020 For IsseID24212--%>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <label class="control-label"><%= MyBase.GetResourceString("C_End_Date") %></label><span class="required"> * </span>
                                                <div class="input-group">
                                                    <%--Added By Dipali V On 8th May 2020 For IsseID24212--%>
                                                    <%-- <% CommonFunctions.HTMLControls.DrawTextBox("", "txtEndDatecr", "form-control Mandatorycr")%>--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("", "txtEndDatecr", "form-control Mandatorycr",,,,,,, True, "white")%>
                                                    <%--End of Added By Dipali V On 8th May 2020 For IsseID24212--%>
                                                    <span class="input-group-btn">
                                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>

                                    </div>

                                    <div class="form-group row mb-3">
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Start_Time") %></label><span class="required"> * </span>
                                            <div class="input-group bootstrap-timepicker timepicker">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("", "txtStartTimecr", "form-control input-small Mandatorycr")%>
                                                <span class="input-group-text"><i class="far fa-clock"></i></span>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_End_Time") %></label><span class="required"> * </span>
                                            <div class="input-group bootstrap-timepicker timepicker">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("", "txtEndTimecr", "form-control input-small Mandatorycr")%>
                                                <span class="input-group-text"><i class="far fa-clock"></i></span>
                                            </div>

                                        </div>

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Time_Zone") %></label><span class="required"> * </span>
                                            <select class="form-select Mandatorycr" id="cboTimeZonecr">
                                            </select>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label">&nbsp;</label>
                                            <div id="divSendInvitecr" style="display: block;" class="custom_chckbox">
                                                <input type="checkbox" id="chkSendReviewInvitecr" class="">
                                                <label for="chkSendReviewInvitecr"><%= MyBase.GetResourceString("C_Send_Review_Invite") %> </label>
                                            </div>
                                            <div id="divCancelInvitecr" class="custom_chckbox" style="display: none;">
                                                <input type="checkbox" id="chkCancelReviewInvitecr" class="">
                                                <label for="chkCancelReviewInvitecr"><%= MyBase.GetResourceString("C_Send_Review_Cancellation") %></label>
                                                <input type="hidden" id="hdnCancelReviewInvitecr" value="0" />
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group row mb-3">

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Reviewer") %></label><span class="required"> * </span>
                                            <div class="row">
                                                <div class="col-sm-10">
                                                    <select id="cboReviwercr" type="text" class="form-select multiselect multiselect-icon multiselectdropdown Mandatorycr" multiple="multiple" role="multiselect">
                                                    </select>
                                                </div>
                                                <div class="col-sm-2 p-0">
                                                    <span class="">
                                                        <img src="../../../Whizible2.0-new/dist/img/add-resource.svg" width="32px" alt=""></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Reviewee") %></label><span class="required"> * </span>
                                            <div class="row">
                                                <div class="col-sm-10">
                                                    <select id="cboReviweecr" type="text" class="form-select multiselect multiselect-icon multiselectdropdown Mandatorycr" multiple="multiple" role="multiselect">
                                                    </select>
                                                </div>
                                                <div class="col-sm-2 p-0">
                                                    <span>
                                                        <img src="../../../Whizible2.0-new/dist/img/add-resource.svg" width="32px" alt=""></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Offline_Review")%></label>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" id="chkOfflineReviewcr" class="">
                                                <label for="chkOfflineReviewcr">
                                                    <small><em class="float-end">Reviewee will be optional if<br />
                                                        offline review is checked</em></small>
                                                </label>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>

                                        <div class="col-sm-3">
                                            <label class="control-label">&nbsp;</label>
                                            <div class="custom_chckbox">
                                                <input type="checkbox" id="chkBillablecr" class="">
                                                <label for="chkBillablecr"><%= MyBase.GetResourceString("C_Billable")%></label>
                                            </div>
                                        </div>


                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group row mb-3">

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Work_Product_Type")%></label>
                                            <select id="cboWorkProductTypecr" class="form-select ">
                                            </select>
                                        </div>


                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Work_Product_Name_Version") %></label>
                                            <div class="row">
                                                <div class="col-sm-10">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("", "txtWorkProductNameVersioncr", "form-control ",, 1000)%>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Checklist")%></label>

                                            <select id="cboChecklistcr" class="form-select ">
                                            </select>

                                        </div>


                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Note")%></label>
                                            <textarea class="form-control" id="txtAreaNotecr" maxlength="2000"></textarea>
                                            <% 'CommonFunctions.HTMLControls.DrawTextArea("", "txtAreaNote", "form-control")%>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group row mb-3">

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_No_of_defects")%></label>
                                            <%--<input type="txtNoOfDefects" class="form-control" name="" placeholder="">--%>
                                            <%--Commented and Added By Reshma on 26th Dec 2019 For IssueID-21125--%>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("", "txtNoOfDefectscr", "form-control")%>--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtNoOfDefectscr", "txtNoOfDefectscr", "form-control",,,,,,,,,, "autocomplete='off' maxlength='3'",,, True,,,, True) %>
                                            <%--End Added By Reshma on 26th Dec 2019 For IssueID-21125--%>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Per") %></label>
                                            <div class="row">
                                                <div class="col-sm-10">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("", "txtPercr", "form-control ",, 7)%>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Unit")%></label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboUnitcr", "usp_Whizible2_Sel_Unit ",,, "class='form-select'", True,, ) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Status")%></label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboReviewStatus", "usp_Whizible2_Sel_ReviewStatus ",,, "class='form-select'", False,, ) %>
                                        </div>


                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group row mb-3">

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_What_Went_Wrong")%></label>
                                            <textarea class="form-control" id="txtWhatWentWrongcr" maxlength="2000"></textarea>
                                            <% 'CommonFunctions.HTMLControls.DrawTextArea("", "txtAreaNote", "form-control")%>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_What_Was_Done")%></label>
                                            <textarea class="form-control" id="txtWhatWasDonecr" maxlength="2000"></textarea>
                                            <% 'CommonFunctions.HTMLControls.DrawTextArea("", "txtAreaNote", "form-control")%>
                                        </div>
                                        <div class="col-sm-3" id="divSprint">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Iteration")%></label>
                                            <span class="required">* </span>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("CboIterationcr", "usp_Whizible2_Sel_tbl_PM_ScrumIterationforRetrospective_Review " & IIf(Session("intprojectID") = Nothing, 0, Session("intprojectID")),,, "class='form-select'", True,, ) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Conclusion")%></label>
                                            <textarea class="form-control" id="txtConculsioncr" maxlength="1000"></textarea>
                                            <% 'CommonFunctions.HTMLControls.DrawTextArea("", "txtAreaNote", "form-control")%>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group row mb-3">

                                        <div class="clearfix"></div>
                                    </div>
                                    <hr />
                                    <!--Added on 26-12-19 by Omkar T-->
                                    <div class="form-group row mb-3">
                                        <h6><%= MyBase.GetResourceString("C_WBS_Attributes")%></h6>

                                        <!--<div class="col-sm-3">&nbsp;</div>
                                        <div class="col-sm-3">&nbsp;</div>
                                        <div class="col-sm-3">&nbsp;</div>-->
                                        <div class="clearfix"></div>
                                    </div>


                                    <div class="row form-group mb-3">
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Sub_Project")%></label>
                                            <select id="CboSubprojectcr" class="form-select ">
                                            </select>

                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Phase")%></label><span class="required"> * </span>
                                            <select id="CboPhasecr" class="form-select ">
                                            </select>

                                        </div>

                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Milestone")%></label>

                                            <select id="CboMilestonescr" class="form-select">
                                            </select>

                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Module")%></label>
                                            <select id="CboModulescr" class="form-select">
                                            </select>

                                        </div>
                                    </div>
                                    <div class="row form-group mb-3">
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Deleverable")%></label>
                                            <select id="CboDeliverablescr" class="form-select"></select>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <!--End Addition on 26-12-19 by Omkar T-->
                                    <br />
                                    <br />

                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div id="RevActions" class="tab-pane">
                                <div class="col-sm-12 righttopheading pt-1 pb-1 graybg clearfix">
                                    <h4 class="float-start m-0 pt-Onehalf" id="txtReviewTitlecr"></h4>
                                    <a href="javascript:;" class="btn borderbtn float-end CRbackbtn"><%= MyBase.GetResourceString("C_Cancle")%></a>
                                
                                </div>
                                <table id="conductActiontbl" class="table table-bordered conductactiontbl table-outer">
                                    <thead>
                                        <tr>
                                        <th width="10%"><%= MyBase.GetResourceString("C_Type") %></th>
                                        <th width="10%"><%= MyBase.GetResourceString("C_Cause") %></th>
                                        <th><%= MyBase.GetResourceString("C_Description") %></th>
                                        <th width="10%"><%= MyBase.GetResourceString("C_Work") %> </th>
                                        <th width="10%"><%= MyBase.GetResourceString("C_Reviewee") %></th>
                                        <th width="5%"><%= MyBase.GetResourceString("C_Task") %></th>
                                        <th width="5%"><%= MyBase.GetResourceString("C_Issue") %></th>
                                        <th width="10%"><%= MyBase.GetResourceString("C_Track_Next_Review") %></th>
                                        <th width="5%"><%= MyBase.GetResourceString("C_Closed") %></th>
                                        <th width="9%">&nbsp;</th>
                                            </tr>
                                    </thead>
                                    <tbody id="tbodyActions">
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td class="text-start" colspan="10">
                                                <button id="btnAddAction" class="btn borderbtn nobtnstyle-xs add-new"><%= MyBase.GetResourceString("C_Add") %></button>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <div id="Revchklist" class="tab-pane">
                                <div class="col-sm-12 righttopheading pt-1 pb-1 graybg clearfix">
                                    <%-- Added by Vishal Mane on 02/01/2025 to set Cancel and Save button at extreme right end --%>
                                    <div class="row align-items-center">
                                    <div class="col-sm-9">
                                        <%-- Added by Chetan M. on 17th Dec 2019 --%>
                                        <h4 class="float-start m-0 pt-Onehalf" id="ChecklistNameHeader"><%= MyBase.GetResourceString("C_Checklist_Name") %><span id="ProjectReviewChecklistID"></span></h4>
                                    </div>
                                    <div class="col-sm-3 d-flex justify-content-end">
                                        <%If m_EditAccess = True Then%>
                                        <a href="javascript:;" class="btn btnyellow float-end  ml-1 PR-1" id="btnSaveReviewChecklistResponses" onclick="SaveProjectReviewCheckListResponse()"><%= MyBase.GetResourceString("C_PlannedReview_Save")%></a>
                                        <%End If %>
                                        <a href="javascript:;" class="btn borderbtn float-end ml-1 CRbackbtn"><%= MyBase.GetResourceString("C_Cancle")%></a>
                                    </div>
                                    </div>
                                    <!--add div wrapper by pradip on 14-10-2020-->

                                    <%--<a href="javascript:;" class="btn borderbtn float-end ml-1 CRbackbtn"><%= MyBase.GetResourceString("C_Cancle")%></a>--%>
                                    <%--<a href="javascript:;" class="btn borderbtn float-end CRbackbtn"><%= MyBase.GetResourceString("C_Back")%></a>--%>
                                    <%-- End of addition by Chetan M on 17th Dec 2019 --%>
                                </div>
                                <div class="clearfix"></div>

                                <div class="table-responsive table-outer">
                                    <%-- Commented and added by Chetan M. on 5th Dec 2019 --%>
                                    <%-- Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization --%>
                                    <%--<table class="table table-bordered taskQAtbl" id="tblProjectReviwCheckList">
                                    </table>--%>
                                    <table class="table table-bordered taskQAtbl" id="tblProjectReviwCheckList">
                                        <thead class="stickyTblHeader">
                                            <tr>                                       
                                                <th class="col-sm-4 text-start"><%= MyBase.GetResourceString("C_Checklist_Item")%></th>
                                                <th class="col-sm-4"><%= MyBase.GetResourceString("C_Responses")%></th>
                                                <th class="col-sm-4"><%= MyBase.GetResourceString("C_Remark")%></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblProjectReviwCheckList_Body">
                                        </tbody>
                                    </table>
                                     <%--End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization--%>
                                </div>
                            </div>
                            <div id="Revchklistissue" class="tab-pane">
                                <div class="col-sm-12 righttopheading pt-1 pb-1 graybg px-3 clearfix">
                                    <h4 class="float-start m-0 pt-Onehalf" id="ReviewTitleChecklistIssue"></h4>
                                    <a href="javascript:;" class="btn borderbtn float-end CRbackbtn"><%= MyBase.GetResourceString("C_Cancle")%></a>
                                </div>
                                <div class="col-sm-12 righttopheading pt-1 pb-1 graybg px-3 clearfix">
                                    <span>
                                        <label id="lblTotalChcklistIssueCount"></label>
                                    </span>
                                </div>
                                <div class="clearfix"></div>
                                <br />
                                <div class="table-responsive table-outer">
                                    <table class="table table-bordered cheklistissuetbl">
                                        <thead>
                                            <tr>
                                                <th align="text-center" width="10%"><%= MyBase.GetResourceString("C_Issue_Id") %></th>
                                                <th><%= MyBase.GetResourceString("C_Type") %></th>
                                                <th class="text-start"><%= MyBase.GetResourceString("C_Summary") %></th>
                                                <th><%= MyBase.GetResourceString("C_Status") %></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyChecklistIssues">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <%--   added by Vishal Mahajan 18-12-2019--%>
                            <div id="RevAttachment" class="tab-pane">
                                <div class="col-sm-12 righttopheading pt-1 pb-1 graybg clearfix">
                                    <a href="javascript:;" class="btn borderbtn float-end CRbackbtn"><%= MyBase.GetResourceString("C_Cancle")%></a>
                                </div>
                                <table id="PRattachment" class="table table-fixed-header table-bordered  table-outer table-stripped order_attchmentlist">
                                    <thead>
                                        <tr>
                                            <th style="text-align: left"><%= MyBase.GetResourceString("C_Document_Category") %></th>
                                            <th style="text-align: left"><%= MyBase.GetResourceString("C_Document_Sub_Category") %></th>
                                            <th style="text-align: left"><%= MyBase.GetResourceString("C_Document_Name") %></th>
                                            <th style="text-align: left"><%= MyBase.GetResourceString("C_Description") %></th>

                                            <th style="text-align: left"><%= MyBase.GetResourceString("C_File_Size") %></th>
                                            <th style="text-align: left"><%= MyBase.GetResourceString("C_Upload_Date") %> </th>
                                            <th style="text-align: left; width: 5%" class="text-start"></th>


                                        </tr>
                                    </thead>
                                    <tbody id="PRattachmentBody">
                                    </tbody>
                                    <tfoot>
                                        <td class="text-start">
                                            <%If m_EditAccess = True Then%>
                                            <button id="PRaddattachnebtrow" value="Add Row" class="btn borderbtn" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Add New Attachment">+ Add New Attachment</button>
                                            <%End If %>
                                        </td>
                                        <td colspan="6">
                                            <%If m_EditAccess = True Then %>
                                            <button id="PRUpload" type="button" class="btn btnyellow ml-1 float-end" disabled>Upload</button>
                                            <%End If %>
                                        </td>
                                    </tfoot>
                                </table>

                            </div>
                            <%--   added by Vishal Mahajan 18-12-2019--%>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                    <!--conduct review tab content end here-->
                    <div class="clearfix"></div>
                </div>


                <!-- DELETE Modal Start here-->
                <div id="deletemodal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modalsmall">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Delete</h4>
                            </div>

                            <div class="modal-body">
                                <span id="TagId"></span>
                                <span id="DeleteId"></span>
                                <span id="DeleteDocumnetId"></span>
                                <p align="center">Are you sure you want to delete this record ?</p>

                                <div class="form-group mt-4">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-6 text-start">
                                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6">
                                            <button class="btn btnyellow ml-1 float-end" onclick="DeleteData()" data-bs-dismiss="modal">Yes</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!-- DELETE Modal End here-->


                <%--Status Closed Modal Starts--%>
                <div id="StatusClosedModal" class="modal fade custmodal" role="dialog" aria-hidden="false">
                    <div class="modal-dialog modalsmall ui-draggable">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header ui-draggable-handle">
                                <button type="button" class="close" data-bs-dismiss="modal">×</button>
                                <h4 class="modal-title"><%= MyBase.GetResourceString("C_Status_Update_Closed_Header") %></h4>
                            </div>

                            <div class="modal-body">
                                <span id="DeleteRiskId"></span>
                                <p align="center"><%= MyBase.GetResourceString("C_Status_Update_Closed") %></p>

                                <div class="form-group mt-4">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-6 text-start">
                                            <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6">
                                            <button class="btn btnyellow ml-1 float-end" onclick="UpdateReviewConductedReview();" data-bs-dismiss="modal">Yes</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <%--Status Closed Modal Ends--%>

                <%--By Vishal Mahajan 28-12-2019--%>
                <!-- DELETE ACTION Modal Start here-->
                <div id="deleteactionmodal" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modalsmall">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" onclick="CancelDeleteAction();" data-bs-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Delete</h4>
                            </div>

                            <div class="modal-body">
                                <hidden id="DeleteReviewActionID"></hidden>
                                <hidden id="DeleteTypeOfReview"></hidden>
                                <p align="center">Are you sure you want to delete this record ?</p>

                                <div class="form-group mt-4">
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-6 text-start">
                                            <button class="btn borderbtn ml-1" onclick="CancelDeleteAction();" data-bs-dismiss="modal">No</button>
                                        </div>
                                        <div class="col-xs-6 col-sm-6">
                                            <button class="btn btnyellow ml-1 float-end" onclick="DeleteAction()" data-bs-dismiss="modal">Yes</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <!-- DELETE ACTION Modal End here-->
            </div>
            <!-- /.content-wrapper -->

        </div>

        <!--bootstrap_Alertify-->

        <%--Added By Reshma on 26th Dec 2019 For IssueID-21046--%>
        <!-- Confirm to Delete Review Modal Start here-->
        <div id="confirmDelReview" class="modal fade custmodal" role="dialog" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Delete Review</h4>
                    </div>

                    <div class="modal-body">
                        <span id="DeleteReviewId"></span>
                        <!-- by reshma 02-01-2019-->
                        <p align="center">Are you sure, you want to delete the selected record?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">Cancel</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="ConfirmDeleteReview()" data-bs-dismiss="modal">Ok</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- Confirm to Delete Review Modal End here-->
        <%--End Added By Reshma on 26th Dec 2019 For IssueID-21046--%>
    </div>

    <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
        <button id="btnCloseableAlert" type="button" onclick="CloseShowAlert()" class="close">×</button>
        <p id="alertMsg"></p>
    </div>
    <!-- ./project-review -->
    <!-- REQUIRED JS SCRIPTS -->
    <!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->

    <%--     <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-multiselect.js"></script>
    <!-- Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 --> 
    <%--<script type="text/javascript" src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>--%>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/moment-2.30.1.js"></script>
    <!-- End of Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 -->
<%--    <script src="../../../Whizible2.0-new/dist/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>
    <script src="../../../Whizible2.0-new/dist/js/common_filters.js"></script>--%>


    <script type="text/javascript"> 
        /*Global variables*/
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
       //Added By Rehan C To check validation for Special characters  on 11th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var LoginId = '<%= Session("intLoginID") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserID = '<%= Session("intUserID") %>';
        var userRoleAccess = "";
        var m_AddAccess = "";
        var m_EditAccess = "";
        var m_DeleteAccess = "";
        var m_ViewAccess = "";
        var UserName = '<%= Session("strUserName") %>';
        var SessionProjectId = '<%= Session("intProjectID") %>';
        //start vishal mahajan 04-12-2019
        var currentDate = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
        var currentDateWithTime = '';
        var projectWorkHours = 0;
        var defaultTimeZone = 0;
        var isAgileMethodused = false;
        var ProjectID = '0';
        var FilterID, CRFilterID;
        var GlobalFilterName;
        var GlobalApplyID, CRGlobalApplyID;
        var Flag = 0, CRFlag=0;
        var ReportFilterQuery = '';
        //end vishal mahajan 04-12-2019

        //start vishal mahajan 07-12-2019
        var OldReviewInvite = false;
        var OldStartDate = '', OldEndDate = '';
        //end vishal mahajan 07-12-2019
        var ReviewStatisticsid = "";
        var MinDAENtryDisplay = "";
        var MinDAEntry = <%=CommonFunctions.Application.MinHoursForDAEntry%>;
        var GlobalRestrictByMinHours = 0;
        var GlobalHoursFlag = 1;
        var hiddenReviewStatasticID = "";
        //Added By Reshma on 30th Dec 2019 For IssueID-21123
        var TotalReviewEfforts = 0;
        var GblDefaultType = "";
        //End Added By Reshma on 30th Dec 2019 For IssueID-21123
        /*Global variables*/
        var selectedqid = "";
        var CRselectedqid = "";
        //start document ready vishal mahajan 30-11-2019
        <%--Added by Riddhesh Patil on 10th April 2023--%>
        $('body').on('click', function () {
            $('.tooltip').remove();
        });
        <%--End of Added by Riddhesh Patil on 10th April 2023--%>
        $(document).ready(function () {
          
            GetSessionValues();
            setDefaultOption();
            getDefaultTimeZone();
            $("#btnAdvFilter").click(function () {

                if ($(this).attr("aria-expanded") == undefined && $(this).css("color") == "rgb(255, 255, 255)") {
                    //$("#PlanReviewBasicFilter").click();
                    $("#presetfilterML,#basicfilterli").addClass("active");
                    //$("#presetfilterML").removeClass("active");
                }
                else if ($(this).attr("aria-expanded") == "false" && $(this).css("color") == "rgb(255, 255, 255)") {
                    //$("#PlanReviewBasicFilter").click();
                    $("#presetfilterML,#basicfilterli").addClass("active");
                    //$("#presetfilterML").removeClass("active");
                }
            });

            $("#btnAdvFilterCR").click(function () {

                if ($(this).attr("aria-expanded") == undefined && $(this).css("color") == "rgb(255, 255, 255)") {
                    //$("#PlanReviewCRBasicFilter").click();
                    $("#presetfilterCR,#basicfilterCRli").addClass("active");
                    //$("#presetfilterCR").removeClass("active");
                }
                else if ($(this).attr("aria-expanded") == "false" && $(this).css("color") == "rgb(255, 255, 255)") {
                    //$("#PlanReviewCRBasicFilter").click();
                    $("#presetfilterCR,#basicfilterCRli").addClass("active");
                    //$("#presetfilterCR").removeClass("active");
                }
            });

            //tooltip
            $('[data-bs-toggle="tooltip"]').tooltip();
            /*if ($('#stacktype').hasClass('open')) {
         
            }*/

        });
        //end document ready

        if (GlobalHoursFlag == 1) {

            if (MinDAEntry == 0.25) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:15"
            }
            else if (MinDAEntry == 0.50) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:30"
            }
            else if (MinDAEntry == 0.75) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:45"
            }
            //else if (MinDAEntry == 0.016) {
            //    MinDAEntry = MinDAEntry
            //         MinDAENtryDisplay = MinDAEntry
            //}
        }
        else {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = MinDAEntry
        }

        //Added By Rehan C To check validation for Special characters  on 11th Nov 2022
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

        //#region Alerts
        function showAlert(Msg, className, id) {
            $('.ClosaeblealertMsg').show();
            if (id != undefined) {
                $('#' + id).prop("disabled", true);
            }
            if (className == 'alert-danger') {
                $('#CloseableAlert').removeClass("alert-success");
                $('#CloseableAlert').addClass("alert-danger");
            }
            else if (className == 'alert-success') {
                $('#CloseableAlert').removeClass("alert-danger");
                $('#CloseableAlert').addClass("alert-success");
            }
            $('#alertMsg').html(Msg);
            $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                if (id != undefined) {
                    $('#' + id).prop("disabled", false);
                }
            });
        }
        function CloseShowAlert() {
            $('.ClosaeblealertMsg').hide();
        }
        //endregion


        /*Custome code for this page*/
        // window.onload = function GetSessionValues() {
        function GetSessionValues() {
            $('input[type=Textbox]').each(function () {

                var control = this;
                $(control).attr("autocomplete", "off");
            });
            userRoleAccess = '<%=m_roleLevel%>';
            m_AddAccess = '<%=m_AddAccess%>';
            m_EditAccess = '<%=m_EditAccess%>';
            m_DeleteAccess = '<%=m_DeleteAccess%>';
            m_ViewAccess = '<%=m_ViewAccess%>';
            UserName = '<%= Session("strUserName") %>';
            SessionProjectId = '<%= Session("intProjectID") %>';
            getCurrentDate();
            fillprojectname();
            SetUserAccess();
            //CheckWFApplicableOrNOt(SessionProjectId);
            //start vishal Mahajan 09-12-2019
            enableDisabledControls();
            //end vishal Mahajan 09-12-2019
            if (SessionProjectId.length) {
                var isPlannedReview;
                $("#CboProject").val(SessionProjectId);
                $("#CboProject").trigger("change");
                /////////////////////////////////////////////
                FillReviewTypes($("#CboProject").val());
                FillReviwers($("#CboProject").val());
                FillReviwee($("#CboProject").val());
                FillDeliverables($("#CboProject").val());
                FillModules($("#CboProject").val());
                FillSubProjects($("#CboProject").val());
                 FillProjectPhases($("#CboProject").val());
                FillMilstones($("#CboProject").val());
                FillTimezones();
                FillProjectCheckList($("#CboProject").val());
                FillIterations($("#CboProject").val());
               ////////////////////////////////////
                FillWorkProductType();
                Multiselectddl();
                var ActiveTab = $('#planreview').attr('class');
                var ActiveTab = $('#planreview').attr('class');
                if (ActiveTab == "tab-pane active") {
                    isPlannedReview = 1;
                }
                else {
                    isPlannedReview = 0;
                }
                //GetAllReviews(SessionProjectId, isPlannedReview);
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_Select_Project_Alert") %>', "alert-danger");
            }
        }

        $("#CboProject").on('change', function () {
            //start vishal mahajan 07-12-2019
            ProjectID = $("#CboProject").val();
            getProjectEstimatedEfforts();
            //Added By Reshma on 30th Dec 2019 For IssueID-21111           
            GetDefaultType(ProjectID);
            //End Added By Reshma on 30th Dec 2019 For IssueID-21111
            isAgileMethodFollowed();
            enableDisabledControls();
            //end vishal mahajan 07-12-2019
            //FillReviewTypes($("#CboProject").val());
            //FillReviwers($("#CboProject").val());
            //FillReviwee($("#CboProject").val());
            FillTimezones();
            //FillIterations($("#CboProject").val());
            //FillDeliverables($("#CboProject").val());
            //FillModules($("#CboProject").val());
            //FillSubProjects($("#CboProject").val());
            //FillProjectPhases($("#CboProject").val());
            //FillMilstones($("#CboProject").val());
            //FillProjectCheckList($("#CboProject").val());
            FillWorkProductType();

            //start vishal mahajan 04-12-2019
            PMProjectReviewGetMyFiltersList();
            PMProjectReviewCRGetMyFiltersList();
            //end vishal mahajan 04-12-2019
            Multiselectddl();
            var isPlannedReview;
            var ActiveTab = $('#planreview').attr('class');
            $(".conductdetail_panel").hide("fast");
            if (ActiveTab == "tab-pane active") {
                isPlannedReview = 1;
            }
            else {
                isPlannedReview = 0;
                //ClearFieldscr();
            }
            SetUserAccess();
            //GetAllReviews($("#CboProject").val(), isPlannedReview);
            $("#ProaddnewreviewPanel").hide('slow');
            $("#projectplanreviewtbl_wrapper").show();
            $('#tabPlanReview').click();
            //alert("On project change called");

            
            $('table').resize();
        });


        /**
         * Created Date     :   07-10-2019
         * Purpose          :   Set user access
         * Author           :   Chandrashekhar Salagar
         * */
        function SetUserAccess() {
            if (m_AddAccess == "False") {
                $('#btnAddNewReview').hide();
                //Added by Chetan M. on 05 Dec 2019
                $('#btnSaveReviewChecklistResponses').hide();
                //End of Addition By ChetaN M.
                //$('#btnSaveReview').hide();
                //$('#btnSaveReviewcr').hide();
            }
            if (m_ViewAccess == "False") {
                if (m_AddAccess == "False") {
                    $('#btnAddNewReview').hide();
                    $('#btnSaveReview').hide();
                    $('#btnSaveReviewcr').hide();
                }

            }
        }

        /*
         * Created Date     :   10-07-2019  
         * Purpose          :   On planned/conducted review click
         * Author           :   Chandrashekhar Salagar
         * **/
        // Change by Vishal Mahajan 
        $('#tabPlanReview').on('click', function () {

            $('#tabConductedReview').closest('li').removeClass('active');
            $('#tabPlanReview').closest('li').addClass('active');
            $("#PMProjectReviewCRClearAllFilter").hide();
            PMProjectReviewDefaultFilter();
            //GetAllReviews($("#CboProject").val(), 1);
            //GetAllReviews('');
            //Commented And Added By Usha Pandit On 05.11.2020 For fetching result as per filter applied if any
            //GetAllReviews('');//Added by pradip on 27-12-2019 for datat table alignment issue
            GetAllReviews(ReportFilterQuery);
            //End Of Added By Usha Pandit On 05.11.2020 For fetching result as per filter applied if any
        })
        $('#tabConductedReview').on('click', function () {
            //Added By Vaijat K on 10 - Feb2021 for Performance Improvement
            FillReviewTypes($("#CboProject").val());
            FillReviwers($("#CboProject").val());
            FillReviwee($("#CboProject").val());
            FillDeliverables($("#CboProject").val());
            FillModules($("#CboProject").val());
            FillSubProjects($("#CboProject").val());
            FillProjectPhases($("#CboProject").val());
            FillMilstones($("#CboProject").val());
            FillTimezones();
            FillProjectCheckList($("#CboProject").val());
            FillIterations($("#CboProject").val());
            //End Of Added BY Vaijat K
            $('#tabPlanReview').closest('li').removeClass('active');
            $('#tabConductedReview').closest('li').addClass('active');
            $("#PMProjectReviewClearAllFilter").hide();
            PMProjectReviewCRDefaultFilter();
            //GetAllReviews($("#CboProject").val(), 0);
            //GetAllReviews('');
            //Commented And Added By Usha Pandit On 05.11.2020 For fetching result as per filter applied if any       
            //GetAllReviews('');//Added by pradip on 27-12-2019 for datat table alignment issue
            GetAllReviews(ReportFilterQuery);
            //End Of Added By Usha Pandit On 05.11.2020 For fetching result as per filter applied if any
        });
        // end Change by Vishal Mahajan 

        /**
         * Created Date     :   04 October  2019
         * Purpose          :   To get all the reviews of selected project
         * Author           :   Chandrashekhar Salagar
         * @param ProjectID
         */
        // Change by Vishal Mahajan 
        function GetAllReviews(filterQuery) {

            var ProjectID = $("#CboProject :selected").val();
            if (ProjectID == '0' || ProjectID == '') {
                ProjectID = -1;
            }
            var ActiveTab = $('#tabPlanReview').closest('li').hasClass('active');
            var isPlannedReview = 1;
            if (ActiveTab || ActiveTab == undefined) {
                isPlannedReview = 1;
                if (filterQuery == null || filterQuery == '') {
                    $("#PMProjectReviewClearAllFilter").hide();
                    $("#basicfilterli a").removeClass("active");
                    $("#presetfilterML").removeClass("active");
                    $("#presetfilterML").removeClass("show");
                    $("#btnAdvFilter").css({ "background": "NONE", "color": "#464a4c" });
                } else {
                    $("#PMProjectReviewClearAllFilter").show();
                    $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                }

                if (filterQuery == null) {
                    var sibling = $('#PMProjectReviewMyFiltersdropdown label[id^="Apply"]');
                    $(sibling).each(function () {
                        var id = this.id;
                        $(this).parent().find("input").prop("checked", false);
                        $(this).attr("data-original-title", "Apply filter");
                    });
                    clearBasicFilters();
                    GlobalApplyID = null;
                    FilterID = '0';
                    filterQuery = "";
                    $("#btnAdvFilter").attr("aria-expanded", false);
                    $("#filterpanelplnReview").removeClass("in");
                }
            }
            else {
                isPlannedReview = 0;
                if (filterQuery == null || filterQuery == '') {
                    $("#PMProjectReviewCRClearAllFilter").hide();
                    $("#basicfilterCRli a").removeClass("active");
                    $("#presetfilterCR").removeClass("active");
                    $("#presetfilterCR").removeClass("show");
                    $("#btnAdvFilterCR").css({ "background": "NONE", "color": "#464a4c" });
                } else {
                    $("#PMProjectReviewCRClearAllFilter").show();
                    $("#btnAdvFilterCR").css({ "background": "#1359a6", "color": "#fff" });
                }

                if (filterQuery == null) {
                    var sibling = $('#PMProjectReviewCRMyFiltersdropdown label[id^="Apply"]');
                    $(sibling).each(function () {
                        var id = this.id;
                        $(this).parent().find("input").prop("checked", false);
                        $(this).attr("data-original-title", "Apply filter");
                    });
                    clearBasicFiltersCR();
                    CRGlobalApplyID = null;
                    CRFilterID = '0';
                    filterQuery = "";
                    $("#btnAdvFilterCR").attr("aria-expanded", false);
                    $("#filterpanelplnReviewCR").removeClass("in");
                }
            }



            var project_Review = {
                projectID: encodeURI(ProjectID),
                FilterQuery: encodeURI(filterQuery),
                IsPlannedReview: isPlannedReview
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/getProjectReviews',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                //by Vishal Mahajan 31-12-2019
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {

                    if ($("#btnAdvFilter").attr("aria-expanded") != undefined) {
                        if ($("#btnAdvFilter").attr("aria-expanded") == "true") {
                            $("#btnAdvFilter").attr("aria-expanded", false);
                            $("#filterpanelplnReview").removeClass("in");
                        }
                    }
                    if ($("#btnAdvFilterCR").attr("aria-expanded") != undefined) {
                        if ($("#btnAdvFilterCR").attr("aria-expanded") == "true") {
                            $("#btnAdvFilterCR").attr("aria-expanded", false);
                            $("#filterpanelplnReviewCR").removeClass("in");
                        }
                    }

                    if (isPlannedReview == 1) {
                        $('#projectplanreviewtbl').html("");
                        console.log(result);
                        var stdTable1 = $("#projectplanreviewtbl").DataTable({
                            data: result,
                            "scrollY": true,
                            "scrollX": true,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": true,
                            "responsive": true,
                            "bProcessing": true,
                            'destroy': true,
                            "pageLength": 5,
                            "lengthChange": false,
                            "dom": 'lrtip',
                            "bDestroy": true,
                            "processing": true,

                            "columns": [
                                {
                                    "data": "ReviewTitle", title: '<%= MyBase.GetResourceString("C_Review_Title") %>', "width": "22%",
                                    render: function (data, type, row) {
                                        if (m_EditAccess == "True") {
                                            return '<span  class="planreview_detail"><a href="javascript:;" >' + data + '</a><input type="hidden" value=' + row.ReviewStatisticsID + '></span>'
                                        }
                                        else {
                                            return '<span  class="">' + data + '<input type="hidden" value=' + row.ReviewStatisticsID + '></span>'
                                        }
                                    }
                                },
                                { "data": "ReviewStartDate", title: '<%= MyBase.GetResourceString("C_From_Date") %>' },
                                { "data": "ReviewEndDate", title: '<%= MyBase.GetResourceString("C_To_Date") %>' },
                                { "data": "ReviewType", title: '<%= MyBase.GetResourceString("C_Review_Type") %>' },
                                {
                                    "data": "ReviewedBy", title: '<%= MyBase.GetResourceString("C_Reviewer") %>', bSortable: false,
                                    render: function (data, type, row) {

                                        var reviweeArray = data.split(',');
                                        var reviewees = "";
                                        if (reviweeArray.length > 2) {
                                            reviewees = reviweeArray[0];
                                            reviewees = reviewees + ',' + reviweeArray[1] + '...';
                                        }
                                        else {
                                            reviewees = reviweeArray.toString();
                                        }
                                        //return '<lable title=' + data + '>' + reviewees + '</lable>'
                                        return '<lable data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title=' + data + ' data-original-title=' + data + '>' + reviewees + '</lable>';
                                    }

                                },
                                {
                                    "data": "Reviewee", title: '<%= MyBase.GetResourceString("C_Reviewee") %>', bSortable: false,
                                    render: function (data, type, row) {

                                        var reviweeArray = data.split(',');
                                        var reviewees = "";
                                        if (reviweeArray.length > 2) {
                                            reviewees = reviweeArray[0];
                                            reviewees = reviewees + ',' + reviweeArray[1] + '...';
                                        }
                                        else {
                                            reviewees = reviweeArray.toString();
                                        }
                                        //return '<lable title=' + data + '>' + reviewees + '</lable>'
                                        return '<lable data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title=' + data + ' data-original-title=' + data + '>' + reviewees + '</lable>';
                                    }
                                },
                                {
                                    title: '<%= MyBase.GetResourceString("C_SendCancel_Invitation") %>', bSortable: false,
                                    // Start Vishal Mahajan 07-12-2019 
                                    render: function (data, type, row) {
                                        if (row.ReviewStatus == "Closed") {
                                            return "";
                                        } else {
                                            if (row.IsSendReviewInvite == "True") {
                                                var ReviewStartDate = new Date(Date.parse(row.ReviewStartDate));
                                                var ReviewEndDate = new Date(Date.parse(row.ReviewEndDate));
                                                //if (ReviewEndDate >= currentDate && ReviewStartDate <= currentDate) {
                                                if (ReviewEndDate >= currentDate) {

                                                    if (m_EditAccess == "True") {
                                                        return ' <a class="reviewcancellationlink" onclick="sendCancellation(this,' + row.ReviewStatisticsID + ');" href="javascript:;"><%= MyBase.GetResourceString("C_Send_Review_Cancellation") %></a>';
                                                    } else {
                                                        return ' <a class="reviewcancellationlink" style="cursor: not-allowed;"><%= MyBase.GetResourceString("C_Send_Review_Cancellation") %></a>';
                                                    }
                                                } else {
                                                    return '';
                                                }
                                            } else {
                                                var ReviewStartDate = new Date(Date.parse(row.ReviewStartDate));
                                                var ReviewEndDate = new Date(Date.parse(row.ReviewEndDate));
                                                //if (ReviewEndDate >= currentDate && ReviewStartDate <= currentDate) {
                                                //if (ReviewEndDate >= currentDate ) {
                                                if (ReviewStartDate >= currentDate) {
                                                    //added by Vishal M 03-01-2020
                                                    var StartTime = row.StartTime;
                                                    if (StartTime == null || StartTime == undefined) {
                                                        StartTime = '';
                                                    }
                                                    StartTime = StartTime.trim();
                                                    var EndTime = row.EndTime;
                                                    if (EndTime == null || EndTime == undefined) {
                                                        EndTime = '';
                                                    }
                                                    EndTime = EndTime.trim();
                                                    var PhaseID = row.PhaseID;
                                                    if (PhaseID == null || PhaseID == undefined) {
                                                        PhaseID = '';
                                                    }
                                                    PhaseID = PhaseID.trim();
                                                    var IterationID = row.IterationID;
                                                    if (IterationID == null || IterationID == undefined) {
                                                        IterationID = '';
                                                    }
                                                    IterationID = IterationID.trim();
                                                    var ReviewStatisticsID = row.ReviewStatisticsID;
                                                    var flag = false;
                                                    if (StartTime == "" || EndTime == "" || PhaseID == "" || (isAgileMethodused == 1 ? IterationID == "" : false)) {
                                                        flag = false;
                                                    } else {
                                                        flag = true;
                                                    }
                                                    if (m_EditAccess == "True") {
                                                        return ' <a class="" onclick="sendInvitaion(this,' + row.ReviewStatisticsID + ');" href="javascript:;"><%= MyBase.GetResourceString("C_Send_Review_Invitaion") %></a>';
                                                    } else {
                                                        return ' <a class="" style="cursor: not-allowed;"><%= MyBase.GetResourceString("C_Send_Review_Invitaion") %></a>';
                                                    }
                                                } else {
                                                    return '';
                                                }
                                            }
                                        }
                                        // end Vishal Mahajan 07-12-2019 
                                    }
                                },

                                { "data": "ReviewEffort", title: '<%= MyBase.GetResourceString("C_Works_hrs") %>' },
                                { "data": "ReviewStatus", title: '<%= MyBase.GetResourceString("C_Review_Status") %>' },
                                {
                                    "data": "ReviewTitle", bSortable: false,
                                    render: function (data, type, row) {
                                        if (m_DeleteAccess == "True") {
                                            //Commented And Added By Reshma on 26th Dec 2019 For IssueID-21046
                                            //return ' <button class="nostylebtn removerow __web-inspector-hide-shortcut__ diabled DeleteReview" value=' + row.ReviewStatisticsID + '><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Delete"></i></button>';
                                            return ' <button class="nostylebtn removerow __web-inspector-hide-shortcut__ diabled DeleteReview" value=' + row.ReviewStatisticsID + ' onclick="DeleteReview(' + row.ReviewStatisticsID + ')" ><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" data-original-title="Delete" ></i></button>';
                                            //End Added By Reshma on 26th Dec 2019 For IssueID-21046

                                        } else {
                                            return ' <button class="nostylebtn" disabled="disabled"><i class="far fa-trash-alt" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="You Dont have access to Delete" ></i></button>';
                                        }
                                    }
                                }
                            ],

                        });

                        $('[data-bs-toggle="tooltip"]').tooltip();//Added by pradip on 30-12-2019
                        //Added by pradip on 27-12-2019
                        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                            $($.fn.dataTable.tables(true)).DataTable()
                                .columns.adjust();
                        });

                        $('.filterpanel').on('shown.bs.collapse', function () {

                            $($.fn.dataTable.tables(true)).DataTable()
                                .columns.adjust();
                        });
                        $('.filterpanel').on('hidden.bs.collapse', function () {
                            $($.fn.dataTable.tables(true)).DataTable()
                                .columns.adjust(); // modified by pradip on 30-12-2019
                        });
                        //End script Added by pradip on 27-12-2019

                        $("i").tooltip({
                            placement: 'top'
                        });
                        $("#conductreview").removeClass('active');
                        $("#planreview").addClass('active');
                    }
                    else {//bind conducted review
                        //projectcondctreviewtbl
                        var stdTable1 = $("#projectcondctreviewtbl").DataTable({
                            data: result,
                            "scrollY": true,
                            "scrollX": true,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": true,
                            "responsive": true,
                            "bProcessing": true,
                            'destroy': true,
                            "pageLength": 5,
                            "lengthChange": false,
                            "dom": 'lrtip',
                            "bDestroy": true,
                            "processing": true,
                            "columns": [
                                {
                                    //"data": "ReviewTitle", title: '<%= MyBase.GetResourceString("C_Reviewee") %>', "width": "22%",

                                    //Added By Rutuja D. For Conduct Review Main Table Header Displaying Wrong issueID=21058
                                    "data": "ReviewTitle", title: '<%= MyBase.GetResourceString("C_Review_Title") %>', "width": "22%",
                                    //End Added By Rutuja D. For Conduct Review Main Table Header Displaying Wrong issueID=21058
                                    render: function (data, type, row) {
                                        if (m_EditAccess == "True") {
                                            return '<span  class="cndctdetaillink"><a href="javascript:;" >' + data + '</a><input type="hidden" value=' + row.ReviewStatisticsID + '></span>'
                                        }
                                        else {
                                            return '<span  class=""> ' + data + '<input type="hidden" value=' + row.ReviewStatisticsID + '></span>'
                                        }
                                    }
                                },
                                { "data": "ReviewStartDate", title: '<%= MyBase.GetResourceString("C_From_Date") %>', },
                                { "data": "ReviewEndDate", title: '<%= MyBase.GetResourceString("C_To_Date") %>' },
                                { "data": "ReviewType", title: '<%= MyBase.GetResourceString("C_Review_Type") %>' },
                                {
                                    "data": "ReviewedBy", title: '<%= MyBase.GetResourceString("C_Reviewer") %>', bSortable: false,
                                    render: function (data, type, row) {

                                        var reviweeArray = data.split(',');
                                        var reviewees = "";
                                        if (reviweeArray.length > 2) {
                                            reviewees = reviweeArray[0];
                                            reviewees = reviewees + ',' + reviweeArray[1] + '...';
                                        }
                                        else {
                                            reviewees = reviweeArray.toString();
                                        }
                                        //return '<lable title=' + data + '>' + reviewees + '</lable>'
                                        return '<lable data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title=' + data + ' data-original-title=' + data + '>' + reviewees + '</lable>'
                                    }


                                },
                                {
                                    "data": "Reviewee", title: '<%= MyBase.GetResourceString("C_Reviewee") %>', bSortable: false,
                                    render: function (data, type, row) {

                                        var reviweeArray = data.split(',');
                                        var reviewees = "";
                                        if (reviweeArray.length > 2) {
                                            reviewees = reviweeArray[0];
                                            reviewees = reviewees + ',' + reviweeArray[1] + '...';
                                        }
                                        else {
                                            reviewees = reviweeArray.toString();
                                        }
                                        //return '<lable title=' + data + '>' + reviewees + '</lable>'
                                        return '<lable data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title=' + data + ' data-original-title=' + data + '>' + reviewees + '</lable>';
                                    }

                                },
                                { "data": "ReviewStatus", title: '<%= MyBase.GetResourceString("C_Review_Status") %>' },
                            ],
                            "columnDefs": [{
                                "targets": 0,
                                "data": "ReviewStatisticsID",
                                "render": function (data, type, full, meta) {
                                    return '<input type="hidden" value=' + data + ' />';
                                }
                            }]
                        });
                        $("#planreview").removeClass('active');
                        $("#conductreview").addClass('active');
                        $('[data-bs-toggle="tooltip"]').tooltip();//Added by pradip on 30-12-2019
                    }
                },
                error: function (ER) {
                    console.log(ER);
                }
            });
            ReportFilterQuery = filterQuery;
            $("i,img").tooltip({
                placement: 'top'
            });

            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
            });//Added by pradip on 27-12-2019


            $('[data-bs-toggle="tooltip"]').tooltip();
            return filterQuery;
        }

        /**
         * Created Date     :   07-10-2019
         * Purpose          :   FillReviewTypes
         * Author           :   Chandrashekhar Salagar
         * @param ProjectID
         */

        function FillReviewTypes(ProjectID) {
            var reviewTypes = {
                ProjectID: encodeURI(ProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/getProjectReviewParameters',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(reviewTypes),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviewTypes) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviewTypes) ? reviewTypes : JSON.stringify(reviewTypes)));
                    }
                },
                success: function (result) {
                    $("#cboReviewType,#cboReviewTypecr,#txtPMRWFilterPReviewTypeID,#txtPMRWCRFilterPReviewTypeID").html("");
                    $("#cboReviewType,#cboReviewTypecr").prepend("<option value='0' selected='selected'>Select Review Type</option>").val();
                    $("#txtPMRWFilterPReviewTypeID,#txtPMRWCRFilterPReviewTypeID").prepend("<option value='' selected='selected'>Select Review Type</option>").val();
                    $.each(result, function () {
                        $("#cboReviewType,#cboReviewTypecr").append($("<option></option>").val(this['PReviewTypeID']).html(this['PReviewType']));
                        $("#txtPMRWFilterPReviewTypeID,#txtPMRWCRFilterPReviewTypeID").append($("<option></option>").val(this['PReviewTypeID']).html(this['PReviewType']));
                    })

                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }
        var GetWorkFlowApplicableornot = "";
        function CheckWFApplicableOrNOt(ProjectID) {
            var reviewTypes = {
                ProjectID: encodeURI(ProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/CheckWFApplicableOrNOt',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(reviewTypes),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviewTypes) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviewTypes) ? reviewTypes : JSON.stringify(reviewTypes)));
                    }
                },
                success: function (result) {
                    if (result != "") {
                        //alert(result.d);
                        GetWorkFlowApplicableornot = result.d;

                    }
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }


        /**
         * Created Date     :   07-10-2019
         * Purpose          :   FillReviewTypes
         * Author           :   Chandrashekhar Salagar
         */
        function FillReviwers(ProjectID) {
            var reviwer = {
                ProjectID: encodeURI(ProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/getReviewers',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                data: JSON.stringify(reviwer),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviwer) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviwer) ? reviwer : JSON.stringify(reviwer)));
                    }
                },
                success: function (result) {
                    $('#cboReviwer,#cboReviwercr').html('');
                    $.each(result, function () {
                        $('#cboReviwer,#cboReviwercr').append($("<option></option>").val(this['EmployeeID']).html(this['EmployeeName']));

                    });
                    $('#cboReviwer,#cboReviwercr').multiselect('rebuild');
                    Multiselectddl();
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }


        function FillReviwee(ProjectID) {
            var reviwer = {
                ProjectID: encodeURI(ProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/getReviewee',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(reviwer),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviwer) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviwer) ? reviwer : JSON.stringify(reviwer)));
                    }
                },
                success: function (result) {
                    $('#cboReviwee,#cboReviweecr').html('');
                    $.each(result, function () {
                        $('#cboReviwee,#cboReviweecr').append($("<option></option>").val(this['EmployeeID']).html(this['EmployeeName']));

                    });
                    $('#cboReviwee,#cboReviweecr').multiselect('rebuild');
                    Multiselectddl()
                },
                error: function (ER) {
                    console.log(ER);
                }
            });
            $('[data-bs-toggle="tooltip"]').tooltip("hide");
            $('[data-bs-toggle="tooltip"]').removeAttr("data-original-title", "");

        }


        function FillTimezones() {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/getTimezone',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                //data: JSON.stringify(reviwer),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    $("#cboTimeZone, #cboTimeZonecr").html("");
                    $("#cboTimeZone, #cboTimeZonecr").prepend("<option value='0' selected='selected'>Select Time Zone</option>").val();
                    $.each(result, function () {
                        $("#cboTimeZone, #cboTimeZonecr").append($("<option></option>").val(this['GMTID']).html(this['GMTZone']));

                    });

                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }

        function FillDeliverables(ProjectID) {
            var reviwer = {
                ProjectId: encodeURI(ProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/getDeliverables',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                data: JSON.stringify(reviwer),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviwer) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviwer) ? reviwer : JSON.stringify(reviwer)));
                    }
                },
                success: function (result) {
                    $("#CboDeliverables,#CboDeliverablescr,#txtPMRWFilterDeliverableID,#txtPMRWCRFilterDeliverableID").html("");
                    $("#CboDeliverables,#CboDeliverablescr").prepend("<option value='0' selected='selected'>Select Deliverable</option>").val();
                    $("#txtPMRWFilterDeliverableID,#txtPMRWCRFilterDeliverableID").prepend("<option value=''>Select Deliverable</option>").val();
                    $.each(result, function () {
                        $("#CboDeliverables,#CboDeliverablescr,#txtPMRWFilterDeliverableID,#txtPMRWCRFilterDeliverableID").append($("<option></option>").val(this['ScheduleID']).html(this['Title']));

                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }


        function FillModules(ProjectID) {
            var project_Review = {
                ProjectId: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetModules',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $("#CboModules,#CboModulescr,#txtPMRWFilterModuleID,#txtPMRWCRFilterModuleID").html("");
                    $("#CboModules,#CboModulescr").prepend("<option value='0' selected='selected'>Select Module</option>").val();
                    $("#txtPMRWFilterModuleID,#txtPMRWCRFilterModuleID").prepend("<option value=''>Select Module</option>").val();

                    $.each(result, function () {
                        $("#CboModules,#CboModulescr,#txtPMRWFilterModuleID,#txtPMRWCRFilterModuleID").append($("<option></option>").val(this['ModuleID']).html(this['ModuleName']));

                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }


        function FillSubProjects(ProjectID) {
            var project_Review = {
                ProjectId: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetSubProjects',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $("#CboSubproject,#CboSubprojectcr,#txtPMRWFilterSubProjectID,#txtPMRWCRFilterSubProjectID").html("");
                    $("#CboSubproject,#CboSubprojectcr").prepend("<option value='0' selected='selected'>Select Sub Project</option>").val();
                    $("#txtPMRWFilterSubProjectID,#txtPMRWCRFilterSubProjectID").prepend("<option value=''>Select Sub Project</option>").val();

                    $.each(result, function () {
                        $("#CboSubproject,#CboSubprojectcr,#txtPMRWFilterSubProjectID,#txtPMRWCRFilterSubProjectID").append($("<option></option>").val(this['SubProjectId']).html(this['SubProjectName']));

                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }


        function FillMilstones(ProjectID) {
            var project_Review = {
                ProjectId: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetMilestones',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $("#CboMilestones,#CboMilestonescr,#txtPMRWFilterMilestoneID,#txtPMRWCRFilterMilestoneID").html("");
                    $("#CboMilestones,#CboMilestonescr").prepend("<option value='0' selected='selected'>Select Milestone</option>").val();
                    $("#txtPMRWFilterMilestoneID,#txtPMRWCRFilterMilestoneID").prepend("<option value=''>Select Milestone</option>").val();

                    $.each(result, function () {
                        $("#CboMilestones,#CboMilestonescr,#txtPMRWFilterMilestoneID,#txtPMRWCRFilterMilestoneID").append($("<option></option>").val(this['MileStoneID']).html(this['MileStone']));

                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }



        function FillProjectPhases(ProjectID) {
            var project_Review = {
                ProjectId: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetProject_Phases',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $("#CboPhase,#CboPhasecr,#txtPMRWFilterPhaseID,#txtPMRWCRFilterPhaseID").html("");
                    $("#CboPhase,#CboPhasecr").prepend("<option value='0' selected='selected'>Select Phase</option>").val();
                    $("#txtPMRWFilterPhaseID,#txtPMRWCRFilterPhaseID").prepend("<option value=''>Select Phase</option>").val();

                    $.each(result, function () {
                        $("#CboPhase,#CboPhasecr,#txtPMRWFilterPhaseID,#txtPMRWCRFilterPhaseID").append($("<option></option>").val(this['ProjectPhaseID']).html(this['Phase']));

                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }

        function FillProjectCheckList(ProjectID) {
            var project_Review = {
                ProjectId: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetProjectCheckList',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $("#cboChecklist,#cboChecklistcr").html("");
                    $("#cboChecklist,#cboChecklistcr").prepend("<option value='0' selected='selected'>Select Checklist</option>").val();
                    $.each(result, function () {
                        $("#cboChecklist,#cboChecklistcr").append($("<option></option>").val(this['ProjectCheckListID']).html(this['CheckListShortName']));

                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }


        function FillWorkProductType() {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetWorkProductType',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {

                    $("#cboWorkProductType,#cboWorkProductTypecr").html("");
                    $("#cboWorkProductType,#cboWorkProductTypecr").prepend("<option value='0' selected='selected'>Select Work Product Type</option>").val();
                    $.each(result, function () {
                        $("#cboWorkProductType,#cboWorkProductTypecr").append($("<option></option>").val(this['WorkProductType']).html(this['WorkProductType']));

                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }

        function FillIterations(ProjectID) {
            var project_Review = {
                ProjectId: encodeURI(ProjectID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetprojectIteration',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                data: JSON.stringify(project_Review),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $("#CboIteration,#CboIterationcr,#txtPMRWFilterIterationID,#txtPMRWCRFilterIterationID").html("");
                    $("#txtPMRWCRFilterIterationID,#txtPMRWFilterIterationID").prepend("<option value=''>Select Sprint</option>").val();
                    $("#CboIteration,#CboIterationcr").prepend("<option value='0'>Select Sprint</option>").val();
                    $.each(result, function () {
                        $("#CboIteration,#CboIterationcr,#txtPMRWCRFilterIterationID,#txtPMRWFilterIterationID").append($("<option></option>").val(this['IterationID']).html(this['IterationName']));
                    });
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }

        /*Edit Planned Review*/
        $(document).on('click', '.planreview_detail', function () {

            $("#projectplanreviewtbl_wrapper").hide();
            $("#ProaddnewreviewPanel").show('slow');
            $('html, body, .content').animate({
                scrollTop: $("#ProaddnewreviewPanel").offset().top -= 100
            }, 500);//modified by pradip on 30-12-2019
            ClearFields();
            hiddenReviewStatasticID = $(this).find("input[type=hidden]").val();
            FillReviewTypes($("#CboProject").val());
            FillReviwers($("#CboProject").val());
            FillReviwee($("#CboProject").val());
            FillDeliverables($("#CboProject").val());
            FillModules($("#CboProject").val());
            FillSubProjects($("#CboProject").val());
            FillProjectPhases($("#CboProject").val());
            FillMilstones($("#CboProject").val());
            FillProjectCheckList($("#CboProject").val());
            FillIterations($("#CboProject").val());
            GetReviewDetailsForEdit(hiddenReviewStatasticID, "PlannedReview");
            //start vishal Mahajan 09-12-2019
            enableDisabledControlsForEdit(false);
            //end vishal Mahajan 09-12-2019
        });



        /**
         * Created Date     :   07-10-2019
         * Purpose          :   Edit Review
         * Author           :   Chandrashekhar Salagar
         * */
        function GetReviewDetailsForEdit(ReviewStatasticID, ReviewType) {
            //debugger
            ReviewStatisticsid = ReviewStatasticID;
            //Added By Reshma on 30th Dec 2019 For IssueID-21123
            getTotalReviewEfforts(ReviewStatisticsid);
            //End Added By Reshma on 30th Dec 2019 For IssueID-21123
            var project_Review = {
                ReviewStatisticsID: ReviewStatasticID
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetReviewForEdit',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    console.log(result);
                    if (ReviewType == "PlannedReview") {
                        $("#projectplanreviewtbl_wrapper").hide();
                        BindReviewDetails(result);
                        if (result['ReviewStatus'] == "Closed") {
                            $("#btnSaveReview").hide();
                        }
                        else {
                            $("#btnSaveReview").show();
                        }
                    }
                    if (ReviewType == "ConductedReview") {
                        BindConductedReviewDetails(result);
                        GetReviewActions(hiddenReviewStatasticID);
                        //Added By Chetan M on 4 Dec 2019
                        GblCReviewTypeID = result['CReviewTypeID'];
                        //Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                        PlotProjectReviewChecklist(ReviewStatasticID, result['ChecklistTypeId'], UserName);
                        //End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                        if (result['ReviewStatus'] == "Closed") {
                            $("#btnSaveReviewcr,#btnAddAction,#btnSaveReviewChecklistResponses").hide();
                            $("#conductActiontbl .add-new").attr("disabled", true);
                            $("#conductActiontbl .converttoAction").attr("disabled", true);
                            $("#conductActiontbl .edit").attr("disabled", true);
                            $("#conductActiontbl .delete").attr("disabled", true);
                        }
                        else {
                            $("#btnSaveReviewcr,#btnAddAction,#btnSaveReviewChecklistResponses").show();
                            $("#conductActiontbl .add-new").attr("disabled", false);
                            $("#conductActiontbl .converttoAction").attr("disabled", false);
                            $("#conductActiontbl .edit").attr("disabled", false);
                            $("#conductActiontbl .delete").attr("disabled", false);
                        }
                        //End of Addition by Chetan M.
                    }

                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }

        var i = 0;
        //added by Vishal M 02-01-2019
        var OldSendInvitation = false;
        function BindReviewDetails(review) {

            //$("#cboReviewType option").each(function () {
            //    var thisText = $(this).text();
            //    var actualValue = review['ReviewType'];

            //    if ($(this).text() == review['ReviewType']) {
            //        $(this).prop('selected', true);
            //    }
            //});
            $("#cboReviewType").val(review['PReviewTypeID']);
            if ($('#cboReviewType').val() == "") {
                $('#cboReviewType').val(0);
            }
            $('#txtAddReview').val(review['ReviewTitle']);
            $('#txtWork').val(review["ReviewEffort"]);
            var StartDate = new Date(Date.parse(review['ReviewStartDate']));
            var EndDate = new Date(Date.parse(review['ReviewEndDate']));
            var endTime = new Date(Date.parse(review['EndTime']));
            var $startDate = $('#txtStartDate');
            $startDate.datepicker();
            $startDate.datepicker('setDate', StartDate);
            var $endDate = $('#txtEndDate');
            $endDate.datepicker();
            $endDate.datepicker('setDate', EndDate);




            //start Vishal Mahajan 07-12-2019
            if (review["IsSendReviewInvite"] == "True") {
                OldReviewInvite = true;
            } else {
                OldReviewInvite = false;
            }
            OldStartDate = $('#txtStartDate').val();
            OldEndDate = $('#txtEndDate').val();

            //end Vishal Mahajan 07-12-2019
            console.log(review['ReviewedBy']);
            /*Set reviewer */
            var reviewerArray = review['ReviewedBy'].split(',');
            $("#cboReviwer option").each(function (i, val) {
                var optionText = $(this).text();
                var optionValue = $(this).val();
                if (jQuery.inArray(optionText, reviewerArray) != "-1") {

                    $("#cboReviwer").multiselect('select', [optionValue]);
                }
                else {
                    $("#cboReviwer").multiselect('deselect', [optionValue]);
                }
                $('[data-bs-toggle="tooltip"]').tooltip("hide");
                $('[data-bs-toggle="tooltip"]').removeAttr("data-original-title", "");


            });

            /*set reviewee */
            var revieweeArray = review['Reviewee'].split(',');

            $("#cboReviwee option").each(function (i, val) {

                var optionText = $(this).text();
                var optionValue = $(this).val();
                if (jQuery.inArray(optionText, revieweeArray) != "-1") {

                    $("#cboReviwee").multiselect('select', [optionValue]);
                }
                else {
                    $("#cboReviwee").multiselect('deselect', [optionValue]);
                }
            });
            var sendReviewStatus = review["IsSendReviewInvite"];
            console.log(review["IsSendReviewInvite"]);


            $('#txtStartTime').val(review['StartTime'].replace(":00", ""));


            $('#txtEndTime').val(review['EndTime'].replace(":00", ""));


            if (review["IsReviewBillable"] == "True") {
                $('#chkBillable').prop('checked', true);
            }
            else {
                $('#chkBillable').prop('checked', false);
            }
            if (review["IsOfflineReview"] == "True") {
                $('#chkOfflineReview').prop('checked', true);
                $('#chkOfflineReview').prop('disabled', true);
            }
            else {
                $('#chkOfflineReview').prop('checked', false)
            }
            $('#chkCancelReviewInvite').prop('checked', false);
            $("#txtAddReview").prop('disabled', true);
            if (review["IsSendReviewInvite"] == "True") {
                $('#chkSendReviewInvite').prop('checked', true);
                //added by Vishal M 02-01-2019
                OldSendInvitation = true;
                //START by Vishal Mahajan 09-12-2019
                $('#chkSendReviewInvite').prop('disabled', true);
                $('#divCancelInvite').css("display", "block");
                $('#divSendInvite').css("display", "none");
                $("#cboReviwee,#cboReviwer").multiselect("disable");
                $('#cboReviewType,#txtWork,#txtStartDate,#txtEndDate,#txtStartTime,#txtEndTime,#cboTimeZone,#cboWorkProductType,#chkOfflineReview,#chkBillable').prop('disabled', true);
                //$('#CboSubproject,#CboPhase,#CboMilestones,#CboModules,#CboDeliverables').prop('disabled', true);
                //START by Vishal Mahajan 02-01-2019
            }
            else {
                //added by Vishal M 02-01-2019
                OldSendInvitation = false;
                $('#chkSendReviewInvite').prop('checked', false);
                //START by Vishal Mahajan 09-12-2019
                $('#chkSendReviewInvite').prop('disabled', false);
                $('#divCancelInvite').css("display", "none");
                $('#divSendInvite').css("display", "block");
                $("#cboReviwee,#cboReviwer").multiselect("enable");
                $('#cboReviewType,#txtWork,#txtStartDate,#txtEndDate,#txtStartTime,#txtEndTime,#cboTimeZone,#cboWorkProductType,#chkOfflineReview,#chkBillable').prop('disabled', false);
                $('#CboSubproject,#CboPhase,#CboMilestones,#CboModules,#CboDeliverables').prop('disabled', false);
                //START by Vishal Mahajan 09-12-2019
            }


            $('#txtNoOfDefects').val(review["NoOfDefects"]);
            $('#txtAreaNote').val(review['ReviewNotes']);
            if (review['SubProjectID'] != "") {
                $('#CboSubproject').val(review['SubProjectID'])
            }
            var ProjectPhase = review['PhaseID'];
            var ProjectPhaseText = review['ProjectPhase'];

            if (ProjectPhase == "" && ProjectPhaseText != "") {
                $("#CboPhase option:contains(" + review['ProjectPhase'] + ")").prop('selected', true);
            }
            else if (review['PhaseID'] != "") {
                $('#CboPhase').val(review['PhaseID'])
            }
            if ($('#CboPhase').val() == "" || $('#CboPhase').val() == undefined) {
                $('#CboPhase').val('0');
            }

            $('#CboModules').val(review['ModuleID'])
            if (review['DeliverableID'] != "") {
                $('#CboDeliverables').val(review['DeliverableID']);
            }
            $('#cboChecklist').val(review['ChecklistTypeId']);
            //$('#cboWorkProductType').val(review['WorkProductType']);
            //Commented And Added By Usha Pandit On 22.04.2020 For selecting correct Work Product Type
            //$("#cboWorkProductType option:contains(" + review['WorkProductType'] + ")").prop('selected', true);
            var curWorkProductType = "";
            if (review['WorkProductType'] == "" || review['WorkProductType'] == undefined || review['WorkProductType'] == null || review['WorkProductType'] == 0) {
                curWorkProductType = "0";
            }
            else {
                curWorkProductType = review['WorkProductType'];
            }
            $("#cboWorkProductType option").each(function () {
                if ($(this).val() == curWorkProductType) {
                    $(this).prop('selected', true);
                }
            });
            //End Of Added By Usha Pandit On 22.04.2020 For selecting correct Work Product Type

            if (review['MilestoneID'] != "") {
                $('#CboMilestones').val(review['MilestoneID']);
            }
            if (review['SubProjectID'] != "") {
                $('#cboSubProject').val(review['SubProjectID']);
            }
            if (review['TimeZone'] != "") {
                $('#cboTimeZone').val(review['TimeZone']);
            }
            if ($('#cboTimeZone').val() == "" || $('#cboTimeZone').val() == "0" || $('#cboTimeZone').val() == undefined) {
                $('#cboTimeZone').val(defaultTimeZone);
            }
            $('#CboIteration').val(review['IterationID']);
            if ($('#CboIteration').val() == "" || $('#CboIteration').val() == undefined) {
                $('#CboIteration').val('0');
            }
            //if (!(EndDate >= currentDate && StartDate <= currentDate))
            if (StartDate < currentDate) {
                $('#divSendInvite').css("display", "none");
            }
            if (EndDate < currentDate) {
                $('#divCancelInvite').css("display", "none");
            }

            if (review["IsOfflineReview"] == "True") {
                $('#chkOfflineReview').prop('disabled', true);
            }

            if (review["IsReviewInviteCancelled"] == "True") {
                $('#hdnCancelReviewInvite').val("1");
            } else {
                $('#hdnCancelReviewInvite').val("0");
            }

        }

        $("#txtStartDate").on("change", function () {
            if (!$('#chkSendReviewInvite').prop('checked')) {
                var date = new Date(Date.parse($(this).val()));
                if (date >= currentDate) {
                    $('#divSendInvite').css("display", "block");
                    $('#chkSendReviewInvite').prop('disabled', false);
                }
            }
        });

        $("#txtStartDatecr").on("change", function () {
            if (!$('#chkSendReviewInvitecr').prop('checked')) {
                var date = new Date(Date.parse($(this).val()));
                if (date >= currentDate) {
                    $('#divSendInvitecr').css("display", "block");
                    $('#chkSendReviewInvitecr').prop('disabled', false);
                }
            }
        });

        function BindConductedReviewDetails(review) {

            //$("#cboReviewTypecr option").each(function () {
            //    var thisText = $(this).text();
            //    var actualValue = review['ReviewType'];

            //    if ($(this).text() == review['ReviewType']) {
            //        $(this).prop('selected', true);
            //    }
            //});
            //});
            $("#cboReviewTypecr").val(review['PReviewTypeID']);
            if ($('#cboReviewTypecr').val() == "") {
                $('#cboReviewTypecr').val(0);
            }

            $('#txtAddReviewcr').text(review['ReviewTitle']);
            $('#txtReviewTitlecr').text(review['ReviewTitle']);
            $('#ReviewTitleChecklistIssue').text(review['ReviewTitle']);
            $('#txtWorkcr').val(review["ReviewEffort"]);
            var StartDate = new Date(Date.parse(review['ReviewStartDate']));
            var EndDate = new Date(Date.parse(review['ReviewEndDate']));
            var endTime = new Date(Date.parse(review['EndTime']));
            var $startDate = $('#txtStartDatecr');
            $startDate.datepicker();
            $startDate.datepicker('setDate', StartDate);
            var $endDate = $('#txtEndDatecr');
            $endDate.datepicker();
            $endDate.datepicker('setDate', EndDate);
            console.log(review['ReviewedBy']);
            OldStartDate = $('#txtStartDatecr').val();
            OldEndDate = $('#txtEndDatecr').val();
            /*Set reviewer */
            var reviewerArray = review['ReviewedBy'].split(',');
            $("#cboReviwercr option").each(function (i, val) {
                var optionText = $(this).text();
                var optionValue = $(this).val();
                if (jQuery.inArray(optionText, reviewerArray) != "-1") {

                    $("#cboReviwercr").multiselect('select', [optionValue]);
                }
                else {
                    $("#cboReviwercr").multiselect('deselect', [optionValue]);
                }

            });

            /*set reviewee */
            var revieweeArray = review['Reviewee'].split(',');

            $("#cboReviweecr option").each(function (i, val) {

                var optionText = $(this).text();
                var optionValue = $(this).val();
                if (jQuery.inArray(optionText, revieweeArray) != "-1") {

                    $("#cboReviweecr").multiselect('select', [optionValue]);
                }
                else {
                    $("#cboReviweecr").multiselect('deselect', [optionValue]);
                }
            });
            var sendReviewStatus = review["IsSendReviewInvite"];
            console.log(review["IsSendReviewInvite"]);


            $('#txtStartTimecr').val(review['StartTime'].replace(":00", ""));


            $('#txtEndTimecr').val(review['EndTime'].replace(":00", ""));


            if (review["IsReviewBillable"] == "True") {
                $('#chkBillablecr').prop('checked', true);
            }
            else {
                $('#chkBillablecr').prop('checked', false);
            }

            if (review["IsOfflineReview"] == "True") {
                $('#chkOfflineReviewcr').prop('checked', true)

                //Added By Rutuja D. for Offline Review is already true the check box is disabled issueid = 21107 
                $("#chkOfflineReviewcr").prop('disabled', true);
                //End Added By Rutuja D. for Offline Review is already true the check box is disabled issueid = 21107 

            }
            else {
                $('#chkOfflineReviewcr').prop('checked', false)

                //Added By Rutuja D. for Offline Review is already false the check box is unable issueid = 21107
                $("#chkOfflineReviewcr").prop('disabled', false);
                //Added By Rutuja D. for Offline Review is already false the check box is unable issueid = 21107 

            }
            if (review["IsSendReviewInvite"] == "True") {
                //added by Vishal M 02-01-2019
                OldSendInvitation = true;
                $('#chkSendReviewInvitecr').prop('checked', true);
                //START by Vishal Mahajan 09-12-2019
                $('#chkSendReviewInvitecr').prop('disabled', true);
                $('#divCancelInvitecr').css("display", "block");
                $('#divSendInvitecr').css("display", "none");
                $("#cboReviweecr,#cboReviwercr").multiselect("disable");
                $('#cboReviewTypecr,#txtWorkcr,#txtStartDatecr,#txtEndDatecr,#txtStartTimecr,#txtEndTimecr,#cboTimeZonecr,#cboWorkProductTypecr,#chkOfflineReviewcr,#chkBillablecr').prop('disabled', true);
                //$('#CboSubprojectcr,#CboPhasecr,#CboMilestonescr,#CboModulescr,#CboDeliverablescr').prop('disabled', true);
                //START by Vishal Mahajan 02-01-2019
            }
            else {
                //added by Vishal M 02-01-2019
                OldSendInvitation = false;
                $('#chkSendReviewInvitecr').prop('checked', false)
                //START by Vishal Mahajan 09-12-2019               
                $('#divCancelInvitecr').css("display", "none");
                $('#divSendInvitecr').css("display", "block");
                $('#CboSubprojectcr,#CboPhasecr,#CboMilestonescr,#CboModulescr,#CboDeliverablescr').prop('disabled', false);
                //START by Vishal Mahajan 09-12-2019
            }


            $('#txtNoOfDefectscr').val(review["NoOfDefects"]);
            $('#txtAreaNotecr').val(review['ReviewNotes']);
            if (review['SubProjectID'] != "") {
                $('#CboSubprojectcr').val(review['SubProjectID'])
            }

            var ProjectPhase = review['PhaseID'];
            if (ProjectPhase == "") {
                $("#CboPhasecr option:contains(" + review['ProjectPhase'] + ")").prop('selected', true);
            }
            else {
                $('#CboPhasecr').val(review['PhaseID'])
            }
            if ($('#CboPhasecr').val() == "" || $('#CboPhasecr').val() == undefined) {
                $('#CboPhasecr').val('0');
            }
            if (review['MilestoneID'] != "") {
                $('#CboMilestonescr').val(review['MilestoneID'])
            }
            if (review['ModuleID'] != "") {
                $('#CboModulescr').val(review['ModuleID'])
            }
            if (review['DeliverableID'] != "") {
                $('#CboDeliverablescr').val(review['DeliverableID']);
            }
            $('#cboChecklistcr').val(review['ChecklistTypeId']);
            //$('#cboWorkProductType').val(review['WorkProductType']);
            //Commented And Added By Usha Pandit On 22.04.2020 For selecting correct Work Product Type
            //$("#cboWorkProductTypecr option:contains(" + review['WorkProductType'] + ")").prop('selected', true);
            var curWorkProductType = "";
            if (review['WorkProductType'] == "" || review['WorkProductType'] == undefined || review['WorkProductType'] == null || review['WorkProductType'] == 0) {
                curWorkProductType = "0";
            }
            else {
                curWorkProductType = review['WorkProductType'];
            }
            $("#cboWorkProductTypecr option").each(function () {
                if ($(this).val() == curWorkProductType) {
                    $(this).prop('selected', true);
                }
            });
            //End Of Added By Usha Pandit On 22.04.2020 For selecting correct Work Product Type

            if (review['TimeZone'] != "") {
                $('#cboTimeZonecr').val(review['TimeZone']);
            }
            if ($('#cboTimeZonecr').val() == "" || $('#cboTimeZonecr').val() == "0" || $('#cboTimeZonecr').val() == undefined) {
                $('#cboTimeZonecr').val(defaultTimeZone);
            }
            $('#txtPercr').val(review['MeasurementNumber']);
            $('#CboUnitcr').val(review['MeasurementUnit']);
            $('#txtWhatWentWrongcr').val(review['WhatWentWrong']);
            $("#txtWorkProductNameVersioncr").val(review['WorkProductName']);
            $('#txtWhatWasDonecr').val(review['WhatWasRight']);
            $('#CboIterationcr').val(review['IterationID']);
            //added by Vishal M 03-01-2020
            if ($('#CboIterationcr').val() == "" || $('#CboIterationcr').val() == undefined) {
                $('#CboIterationcr').val('0');
            }
            //added by Vishal M 03-01-2020
            if ($('#CboUnitcr').val() == "" || $('#CboUnitcr').val() == undefined) {
                $('#CboUnitcr').val('');
            }
            $("#CboReviewStatus option:contains(" + review['ReviewStatus'] + ")").prop('selected', true);
            $('#txtConculsioncr').text(review["Conclusion"]);

            //if (!(new Date(EndDate) >= currentDate && StartDate <= currentDate))
            //if (!(new Date(EndDate) >= currentDate)) {

            //    $('#divCancelInvitecr').css("display", "none");
            //    $('#divSendInvitecr').css("display", "none");
            //}
            if (StartDate < currentDate) {
                $('#divSendInvitecr').css("display", "none");
            }
            if (EndDate < currentDate) {
                $('#divCancelInvitecr').css("display", "none");
            }

            if (review["IsReviewInviteCancelled"] == "True") {
                $('#hdnCancelReviewInvitecr').val("1");
            } else {
                $('#hdnCancelReviewInvitecr').val("0");
            }
        }




        /*Created Date  :   14 Oct 2019
         * Purpose      :   btnUpdateReview
         * Author       :   Chandrashekhar Salagar
         * 
         * **/
        $('#btnSaveReview').on('click', function () {
            StartLoader("#bodyPMProjectReview");
            if ($("#chkCancelReviewInvite").is(":checked")) {
                sendCancellation("sendCancellation", ReviewStatisticsid);
                $("#projectplanreviewtbl_wrapper").hide();
                $("#ProaddnewreviewPanel").show('slow');
                ClearFields();
                hiddenReviewStatasticID = ReviewStatisticsid;
                setTimeout(GetReviewDetailsForEdit(ReviewStatisticsid, "PlannedReview"), 7000);
                enableDisabledControlsForEdit(false);
                showAlert('<%= MyBase.GetResourceString("C_ReviewSave") %>', "alert-success");
                $('table').resize();
            } else {
                var isAllMandatorySelected = true;
                //start by Vishal Mahajan16-12-2019 for mandatory change
                var MandatoryFileds = ("Review Title,Review Type,Work,Start Date,End Date,Start Time,End Time,Time Zone,Reviewer,Reviewee").split(',');
                $('#ProaddnewreviewPanel .Mandatory').each(function (index, value) {
                    //end by Vishal Mahajan16-12-2019 for mandatory change
                    var Control = $(this);
                    var val = $(this).val();
                    if (val != "") {
                        if (val != "0") {
                            if (val != null) {
                                delete MandatoryFileds[index];
                            } else {
                                if ($('#chkOfflineReview').prop('checked') == true && index != 9) {
                                    isAllMandatorySelected = false;
                                } else {
                                    delete MandatoryFileds[index];
                                }
                            }
                        }
                        else {
                            if ($('#chkOfflineReview').prop('checked') == true && index != 9) {
                                isAllMandatorySelected = false;
                            } else {
                                delete MandatoryFileds[index];
                            }
                        }
                    }
                    //start by Vishal Mahajan16-12-2019 for mandatory change
                    else {
                        if ($('#chkOfflineReview').prop('checked') == true && index != 9) {
                            isAllMandatorySelected = false;
                        } else {
                            delete MandatoryFileds[index];
                        }
                    }
                    //end by Vishal Mahajan16-12-2019 for mandatory change
                });
                
                if (isAllMandatorySelected) {
                    var ReviewTitle = $("#txtAddReview").val();
                    var Note = $("#txtAreaNote").val();
                    if ($('#txtAddReview').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewTitle_Blank") %>', "alert-danger");
                        $('#txtAddReview').focus();
                    }
                    //Added By Rehan C To check validation for Special characters  on 11th Nov 2022
                    else if (checkSpecialCharacter(ReviewTitle, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Review Title should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtAddReview").focus();
                    }
                    else if (disallowSpecialforFileCreationCharacters(document.getElementById('txtAddReview'))) {
                        showAlert('<%= MyBase.GetResourceString("C_Review_Tille_ShouldNotBe_Allow") %>', "alert-danger");
                        $('#txtAddReview').focus();
                    }
                    //Added By Rutuja D. For Blank Space not allowed issueid=21052
                    else if (isBlank($('#txtAddReview').val().trim())) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewTitle_Blank") %>', "alert-danger");
                        $('#txtAddReview').focus();
                    }
                    //End Added By Rutuja D. For Blank Space not allowed issueid=21052
                    else if ($('#cboReviewType').val() == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_Review_Type_Blank") %>', "alert-danger");
                        $('#cboReviewType').focus();
                    }
                    else if ($('#txtWork').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                        $('#txtWork').focus();
                    }
                    else if ($('#txtStartDate').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewStartDate_Blank") %>', "alert-danger");
                        $('#txtStartDate').focus();
                    }
                    else if ($('#txtEndDate').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewEndDate_Blank") %>', "alert-danger");
                        $('#txtEndDate').focus();
                    }
                    else if ($('#txtStartTime').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewStartTime_Blank") %>', "alert-danger");
                        $('#txtStartTime').focus();
                    }
                    else if ($('#txtEndTime').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewEndTime_Blank") %>', "alert-danger");
                        $('#txtEndTime').focus();
                    }
                    else if ($('#cboReviwer').get(0).selectedIndex == -1) {
                        showAlert('<%= MyBase.GetResourceString("C_Reviewer_Blank") %>', "alert-danger");
                        $('#cboReviwer').focus();
                    }
                    else if ($('#cboReviwee').get(0).selectedIndex == -1 && $('#chkOfflineReview').prop('checked') == false) {
                        showAlert('<%= MyBase.GetResourceString("C_Reviewee_Blank") %>', "alert-danger");
                        $('#cboReviwee').focus();
                    }
                    else if ($('#cboTimeZone').val() == 0 || $('#cboTimeZone').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Timezone_Blank") %>', "alert-danger");
                        $('#cboTimeZone').focus();
                    }// By Vishal Mahajan 30-12-2019  

                    //Added By Rehan C To check validation for Special characters  on 11th Nov 2022                    
                    else if (checkSpecialCharacter(Note, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Note should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtAreaNote").focus();
                    }
                    else if (isAgileMethodused == 1 && ($('#CboIteration').val() == "" || $('#CboIteration').val() == "0" || $('#CboIteration').val() == null)) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Sprint") %>', "alert-danger");
                        $('#CboIteration').focus()
                    }
                    else if ($('#CboPhase').val() == "" || $('#CboPhase').val() == "0" || $('#CboPhase').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Phase") %>', "alert-danger");
                        $('#CboPhase').focus()
                    }
                    else {

                        var IsValid = CheckValidHours($('#txtWork').val().trim());

                        if (IsValid) {

                            //Added By Reshma on 30th Dec 2019 For IssueID-21123
                            var Curworkhours = parseFloat($("#txtWork").val());
                            var SumReviewEfforts = parseFloat(TotalReviewEfforts);
                            //End Added By Reshma on 30th Dec 2019 For IssueID-21123
                            var jsStartDate = $('#txtStartDate').datepicker('getDate');
                            var jsEndDate = $('#txtEndDate').datepicker('getDate');
                            var StartDate = new Date(jsStartDate);
                            var EndDate = new Date(jsEndDate);

                            var startTime = $('#txtStartTime').val();
                            var endTime = $('#txtEndTime').val();
                            var isValidTime = false;
                            var starthour = parseInt($('#txtStartTime').val().split(":")[0]);
                            var endhour = parseInt($('#txtEndTime').val().split(":")[0]);
                            var startmin = parseInt($('#txtStartTime').val().split(":")[1]);
                            var endmin = parseInt($('#txtEndTime').val().split(":")[1]);
                            if (starthour >= endhour) {
                                isValidTime = false;
                                if (starthour == endhour) {
                                    if (startmin >= endmin) {
                                        isValidTime = false;
                                    } else {
                                        isValidTime = true;
                                    }
                                }
                            } else if (starthour > 0) {
                                isValidTime = true;
                            }

                            getCurrentDate();

                            if (Date.parse(StartDate) == Date.parse(currentDate)) {
                                var checkCurrentTime = true;
                                var currentHours = currentDateWithTime.getHours();
                                var currentMinutes = currentDateWithTime.getMinutes();
                                var CurrentTime = currentHours + ":" + currentMinutes;
                                if (starthour <= currentHours) {
                                    if (starthour == currentHours) {
                                        if (startmin >= currentMinutes) {
                                        } else {
                                            checkCurrentTime = false;
                                        }
                                    } //by Vishal Mahajan 28-12-2019
                                    else {
                                        checkCurrentTime = false;
                                    }
                                }
                                if (!checkCurrentTime) {
                                    showAlert('<%= MyBase.GetResourceString("C_StartTime_Is_Greater_Than_CurrentTime") %>', "alert-danger");
                                    StopAjaxLoader("#bodyPMProjectReview");
                                    return;
                                }
                            }

                            if (StartDate > EndDate) {
                                showAlert('<%= MyBase.GetResourceString("C_StartDate_Greater") %>', "alert-danger");
                            }
                            else if (StartDate < currentDate) {
                                $('#txtStartDate').focus();
                                showAlert('<%= MyBase.GetResourceString("C_ReviewStartDate_NotBeLessThanTodaysDate") %>', "alert-danger");
                            }
                            else if (Date.parse(StartDate) == Date.parse(EndDate) && (!isValidTime)) {
                                $('#txtEndTime').focus();
                                showAlert('<%= MyBase.GetResourceString("C_ReviewEndTimeNotBeLessThanOrEqualToStartTime") %>', "alert-danger");
                            }
                            //Commented and Added By Reshma on 30th Dec 2019 For IssueID-21123
                            <%-- else if (parseFloat($("#txtWork").val()) > parseFloat(projectWorkHours)) {
                                $('#txtWork').focus();
                                //showAlert('<%= MyBase.GetResourceString("C_Works_LessThan_ProjectHour") %>', "alert-danger");
                             }--%>
                            else if ((Curworkhours + SumReviewEfforts) > parseFloat(projectWorkHours)) {
                                $('#txtWork').focus();
                                showAlert('<%= MyBase.GetResourceString("C_Works_LessThan_ProjectHour") %>', "alert-danger");
                            }
                            //End Added By Reshma on 30th Dec 2019 For IssueID-21123
                            else {
                                if (GlobalHoursFlag == 1) {
                                    var minutes = $('#txtWork').val().split(':');
                                    var p = minutes[0];
                                    var dec = minutes[1];
                                    if (dec == undefined) { dec = 0; }
                                    var d = (dec - 0) / 60 + (p - 0);
                                }

                                if (MinDAENtryDisplay != "") {
                                    if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                                        showAlert('Please specify the Work(hrs) in multiples of ( ' + MinDAENtryDisplay + ' ) hours.', 'alert-danger');
                                        $('#txtWork').focus();
                                        StopAjaxLoader("#bodyPMProjectReview");
                                        return;
                                    }
                                    else {
                                        UpdateReview();
                                    }
                                }
                                else {
                                    UpdateReview();
                                }

                            }
                        }
                        else {
                            if ($("#txtWork").val().trim() == "") {
                                showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                                return false;
                            }
                            else {
                                showAlert('<%= MyBase.GetResourceString("C_Time_Format") %>', "alert-danger");
                            }
                        }
                    }
                }
                else {

                    var destinationArray = new Array();
                    $(MandatoryFileds).each(function (index, value) {
                        if (value != undefined) {
                            destinationArray.push(value);
                        }
                    });
                    showAlert("Please select " + destinationArray.toString(), "alert-danger");
                }
            }
            $('.projectreviewtbl').resize();
            StopAjaxLoader("#bodyPMProjectReview");

        });


        function CheckMandatoryFeilds() {
            var MandatoryFileds = ("Review Title,Review Type,Work,Start Date,End Date,Start Time,End Time,Time Zone,Reviewer,Reviewee").split(',');
            $('.Mandatory').each(function (index, value) {

                var Control = $(this);
                var val = $(this).val();
                if (val != "") {
                    if (val != "0") {
                        delete MandatoryFileds[index];
                    }
                }
            });
            return MandatoryFileds.toString();
        }

        /*
         * Craeted Date     :   16 Oct  2019
         * Purpose          :   Delete Review
         * Author           :   Chandrashekhar Salagar
         * **/
        //Commented And Added By Reshma on 26th Dec 2019 For IssueID-21046

        <%--$(document).on('click', '.DeleteReview', function () {
            var project_Review = {
                ProjectId: encodeURI($('#CboProject').val()),
                ReviewStatisticsID: encodeURI($(this).val())
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/DeleteReview',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));

                },
                success: function (result) {
                    showAlert('<%= MyBase.GetResourceString("C_ReviewDelete") %>', "alert-success");
                    $("#ProaddnewreviewPanel").hide('slow');
                    $("#projectplanreviewtbl_wrapper").show();
                    //var ActiveTab = $('#planreview').attr('class');
                    //var ActiveTab = $('#planreview').attr('class');
                    //if (ActiveTab == "tab-pane active") {
                    //    isPlannedReview = 1;
                    //}
                    //else {
                    //    isPlannedReview = 0;
                    //}
                    //var ProjectID = $('#CboProject').val();
                    //GetAllReviews(ProjectID, isPlannedReview);
                    //start vishal mahajan 04-12-2019
                    var ActiveTab = $('#tabPlanReview').closest('li').hasClass('active');
                    var isPlannedReview = 1;
                    if (ActiveTab || ActiveTab == undefined) {
                        PMProjectReviewDefaultFilter();
                    } else {
                        PMProjectReviewCRDefaultFilter();
                    }
                    //end vishal mahajan 04-12-2019
                },
                error: function (ER) {

                    console.log(ER);
                }
            });

        })--%>

        function ConfirmDeleteReview() {

            var DeleteReviewStatisticsID = $("#DeleteReviewId").attr("value");
            DeleteReviewById(DeleteReviewStatisticsID);
        }

        //Function for delete Review
        function DeleteReview(ReviewStatisticsID) {
            $('#DeleteReviewId').attr('value', ReviewStatisticsID);
            $("#confirmDelReview").modal("show");
        }

        function DeleteReviewById(DeleteReviewStatisticsID) {
            var project_Review = {
                ProjectId: encodeURI($('#CboProject').val()),
                ReviewStatisticsID: encodeURI(DeleteReviewStatisticsID)
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/DeleteReview',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    showAlert('<%= MyBase.GetResourceString("C_ReviewDelete") %>', "alert-success");
                    $("#ProaddnewreviewPanel").hide('slow');
                    $("#projectplanreviewtbl_wrapper").show();
                    //start vishal mahajan 04-12-2019
                    var ActiveTab = $('#tabPlanReview').closest('li').hasClass('active');
                    var isPlannedReview = 1;
                    if (ActiveTab || ActiveTab == undefined) {
                        PMProjectReviewDefaultFilter();
                    } else {
                        PMProjectReviewCRDefaultFilter();
                    }
                    //end vishal mahajan 04-12-2019
                },
                error: function (ER) {

                    console.log(ER);
                }
            });
        }
        //End Added By Reshma on 26th Dec 2019 For IssueID-21046

        /*
         * Created Date     :   19 Sept 2019
         * Purpose          :   Fill Projects
         * Author           :   Chandrashekhar Salagar
         * **/
        function fillprojectname() {
            var defaultFilterParameters = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                ProjectID: encodeURI('<%= Session("intProjectID") %>')
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetProjectDropDown',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(defaultFilterParameters),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (defaultFilterParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(defaultFilterParameters) ? defaultFilterParameters : JSON.stringify(defaultFilterParameters)));
                    }
                },
                async: false,
                success: function (result) {


                    $("#CboProject").html("");
                    $.each(result, function () {
                        $("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));
                        //$("#CboProject").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));
                    });

                },
                error: function (ER) {
                    alert(ER);
                }
            });
        }


        /**
         * Created Date     :   14 Oct 2019
         * Purpose          :   Check for valid hours
         * Author           :   Chandrashekhar Salagar
         * @param Workhours
         */
        function CheckValidHours(Workhours) {

            //var isValid = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/.test($('#txtWork').val());
            //start by Vishal Mahajan 11-12-2019
            //Added By Reshma On 26th Dec 2019 For IssueID-21117
            var hours = parseInt($('#txtWork').val().split(":")[0]);
            //End Added By Reshma On 26th Dec 2019 For IssueID-21117

            if ($("#txtWork").val().trim() == "") {
                showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                return false;
            }
            if ($.isNumeric($("#txtWork").val())) {
                if ($("#txtWork").val().indexOf('.') !== -1) {
                    return false;
                }
                //Added By Reshma On 26th Dec 2019 For IssueID-21117
                if (hours <= 0) {
                    return false;
                }
                //End Added By Reshma On 26th Dec 2019 For IssueID-21117
                if ($("#txtWork").val().indexOf(':') !== -1) {
                    var hours = parseInt($('#txtWork').val().split(":")[0]);
                    var mins = parseInt($('#txtWork').val().split(":")[1]);
                    if (hours == 0 && mins == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                        return false;
                    }

                }
                else {
                    var hours = parseInt($('#txtWork').val());
                    if (hours == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                        return false;
                    }
                }
                return true;
            }
            var isValid = isWork(document.getElementById('txtWork'));
            if (isValid) {

                if ($("#txtWork").val().indexOf(':') !== -1) {
                    var hours = parseInt($('#txtWork').val().split(":")[0]);
                    var mins = parseInt($('#txtWork').val().split(":")[1]);
                    if (hours == 0 && mins == 0) {
                        isValid = false;
                    }
                }
                else {
                    var hours = parseInt($('#txtWork').val());
                    if (hours == 0) {
                        isValid = false;
                    }
                }
            }
            //end by Vishal Mahajan 11-12-2019
            return isValid;
        }

        //start by Vishal Mahajan 12-12-2019
        function isWork(obj) {

            if (isBlank(getInputValue(obj))) { return false; }

            var msg = (arguments.length > 1) ? arguments[1] : "";
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            var sSep = (arguments.length > 3) ? arguments[3] : ":";
            var minHr = (arguments.length > 4) ? arguments[4] : 0;
            var maxHr = (arguments.length > 5) ? arguments[5] : 2147483647;
            var minMin = (arguments.length > 6) ? arguments[6] : 0;
            var maxMin = (arguments.length > 7) ? arguments[7] : 59;
            msg = replaceSubstring(msg, "&#39;", "'");

            if (isWork_Main(obj, sSep, minHr, maxHr, minMin, maxMin)) {
                return true;
            }
            else {
                setFocus(obj);
                return false;
            }
        }

        function isWork_Main(objTime) {
            var sSep = (arguments.length > 1) ? arguments[1] : ":";
            var minHr = (arguments.length > 2) ? arguments[2] : 0;
            var maxHr = (arguments.length > 3) ? arguments[3] : 2147483647;
            var minMin = (arguments.length > 4) ? arguments[4] : 0;
            var maxMin = (arguments.length > 5) ? arguments[5] : 59;

            var time = objTime.value; var index; index = time.indexOf(sSep);
            //If sSep not entered or hour is more than 10 digit then return false.
            if (index <= 0 || index > 10) { return false; }
            else {
                //If minute is not entered return false.
                if (index == time.length - 1 || index + 2 != time.length - 1) { return false; }
                else {
                    var hour, minute, minPart1;
                    try { hour = parseInt(time.substring(0, index), 10); if (isNaN(hour)) { return false; } }
                    catch (e) { return false; }

                    if (hour < minHr || hour > maxHr) { return false; }

                    try { minute = parseInt(time.substring(index + 1, time.length), 10); if (isNaN(minute)) { return false; } }
                    catch (e) { return false; }

                    if (minute < minMin || minute > maxMin) { return false; }

                }
            }
            return true;
        }
        //end byVishal Mahajan 12-12-2019

        function CheckValidHoursCr(Workhours) {

            //var isValid = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/.test($('#txtWorkcr').val());
            //start by Vishal Mahajan 11-12-2019
            //var isValid = /^([0-9][0-9]):([0-5][0-9])?$/.test($('#txtWorkcr').val());            
            if ($.isNumeric($("#txtWorkcr").val())) {
                if ($("#txtWork").val().indexOf('.') !== -1) {
                    return false;
                }
                if ($("#txtWorkcr").val().indexOf(':') !== -1) {
                    var hours = parseInt($('#txtWorkcr').val().split(":")[0]);
                    var mins = parseInt($('#txtWorkcr').val().split(":")[1]);
                    if (hours == 0 && mins == 0) {
                        return false;
                    }
                }
                else {
                    var hours = parseInt($('#txtWorkcr').val());
                    if (hours == 0) {
                        return false;
                    }
                }
                return true;
            }
            var isValid = isWork(document.getElementById('txtWorkcr'));
            if (isValid) {
                if ($("#txtWorkcr").val().indexOf(':') !== -1) {
                    var hours = parseInt($('#txtWorkcr').val().split(":")[0]);
                    var mins = parseInt($('#txtWorkcr').val().split(":")[1]);
                    if (hours == 0 && mins == 0) {
                        isValid = false;
                    }
                }
                else {
                    var hours = parseInt($('#txtWorkcr').val());
                    if (hours == 0) {
                        isValid = false;
                    }
                }
            }
            //end by Vishal Mahajan 11-12-2019
            return isValid;
        }

        function CheckHHMMFormat(obj) {

            //alert(obj.value);
            //var isValid = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/.test(obj);
            //start by Vishal Mahajan 11-12-2019
            //var isValid = /^([0-9][0-9]):([0-5][0-9])?$/.test($('#txtWork').val());
            //Added By Reshma on 26th Dec 2019 For IssueID-21117
            var hours = parseInt($(obj).val().split(":")[0]);
            //End Added By Reshma on 26th Dec 2019 For IssueID-21117

            if ($.isNumeric($(obj).val())) {
                if ($(obj).val().indexOf('.') !== -1) {
                    return false;
                }
                //Added By Reshma on 26th Dec 2019 For IssueID-21117
                if (hours <= 0) {
                    return false;
                }
                //End Added By Reshma on 26th Dec 2019 For IssueID-21117
                if ($(obj).val().indexOf(':') !== -1) {
                    var hours = parseInt($(obj).val().split(":")[0]);
                    var mins = parseInt($(obj).val().split(":")[1]);
                    if (hours == 0 && mins == 0) {
                        return false;
                    }
                }
                else {
                    var hours = parseInt($(obj).val());
                    if (hours == 0) {
                        return false;
                    }
                }
                return true;
            }
            var isValid = isWork(obj);
            if (isValid) {
                if ($(obj).val().indexOf(':') !== -1) {
                    var hours = parseInt($(obj).val().split(":")[0]);
                    var mins = parseInt($(obj).val().split(":")[1]);
                    if (hours == 0 && mins == 0) {
                        isValid = false;
                    }
                }
                else {
                    var hours = parseInt($(obj).val());
                    if (hours == 0) {
                        isValid = false;
                    }
                }
            }
            //end by Vishal Mahajan 11-12-2019
            return isValid;
        }


        /***
         * Craeted Date     :   09 Oct  2019
         * Purpose          :   update planned review
         * Author           :   Chandrashekhar Salagar
         * */
        function UpdateReview() {

            var IsOfflineReview = "0";
            var IsReviewBillable = "0";
            var IsCarryForwardedRev = "0";
            var SubProjectID = 0;
            var MilestoneID = 0;
            var PhaseID = 0;
            var ModuleID = 0;
            var DeliverableID = 0;
            var isSendReviewInvite = 0;
            var jsStartDate = $('#txtStartDate').datepicker('getDate');
            var jsEndDate = $('#txtEndDate').datepicker('getDate');
            var startDate = ConvertJSDate(jsStartDate);
            var endDate = ConvertJSDate(jsEndDate);


            var jsStartTime = $('#txtStartTime').val();

            var jsEndTime = $('#txtEndTime').val();


            if ($('#chkOfflineReview').prop('checked') == true) {
                IsOfflineReview = "1"
            }

            if ($('#chkBillable').prop('checked') == true) {
                IsReviewBillable = "1";
            }

            if ($('#chkSendReviewInvite').prop('checked') == true) {
                IsCarryForwardedRev = "1";
            }
            if ($('#chkSendReviewInvite').prop('checked') == true) {
                isSendReviewInvite = 1;
            }

            var SelectedReviewers = $("#cboReviwer option:selected").map(function () {
                return $(this).text();
            }).get().join(',');

            var SelectedReviewee = $("#cboReviwee option:selected").map(function () {
                return $(this).text();
            }).get().join(',');

            var SelectedReviewerIDs = $("#cboReviwer option:selected").map(function () {
                return $(this).val();
            }).get().join(',');

            SelectedReviewerIDs = "," + SelectedReviewerIDs + ",";

            var SelectedRevieweeIDs = $("#cboReviwee option:selected").map(function () {
                return $(this).val();
            }).get().join(',');

            if (SelectedRevieweeIDs == "") {
                SelectedRevieweeIDs = ",0,";
            } else {
                SelectedRevieweeIDs = "," + SelectedRevieweeIDs + ",";
            }
            var IsReviewInviteCancelled = 0;
            if ($('#hdnCancelReviewInvite').val() == "1") {
                IsReviewInviteCancelled = 1;
            }

            var project_Review = {
                ReviewStatisticsID: encodeURI(ReviewStatisticsid),
                ProjectId: encodeURI($('#CboProject').val()),
                ReviewType: encodeURI($("#cboReviewType option:selected").text().trim()),
                ProjectPhase: encodeURI(""),
                NoOfReviews: encodeURI(""),
                ReviewEffort: encodeURI($('#txtWork').val()),
                NoOfDefects: encodeURI(replaceAllChar($('#txtNoOfDefects').val().trim())),
                ReviewedBy: encodeURI(SelectedReviewers),
                ReviewNotes: encodeURI(replaceAllChar($('#txtAreaNote').val().trim())),
                Reviewee: encodeURI(SelectedReviewee),
                CReviewTypeID: encodeURI($("#cboReviewType").val()),
                PReviewTypeID: encodeURI($("#cboReviewType").val()),
                IsPlannedReview: encodeURI("1"),
                WorkProductType: encodeURI($("#cboWorkProductType option:selected").text().trim()),
                ModuleID: encodeURI($("#CboModules").val()),
                DeliverableID: encodeURI($("#CboDeliverables").val()),
                DeliverableTypeID: encodeURI($("#CboDeliverables").val()),
                ChecklistTypeId: encodeURI($('#cboChecklist').val()),
                ReviewTitle: encodeURI(replaceAllChar($("#txtAddReview").val().trim())),
                ReviewStartDate: encodeURI(startDate),
                ReviewEndDate: encodeURI(endDate),
                IsOfflineReview: encodeURI(IsOfflineReview),
                IsReviewBillable: encodeURI(IsReviewBillable),
                ModifiedBy: encodeURI(UserName),
                //IsCarryForwardedRev: encodeURI(IsCarryForwardedRev),
                SubProjectID: encodeURI($('#CboSubproject').val()),
                MilestoneID: encodeURI($('#CboMilestones').val()),
                PhaseID: encodeURI($('#CboPhase').val()),
                StartTime: encodeURI(jsStartTime),
                EndTime: encodeURI(jsEndTime),
                Timezone: encodeURI($('#cboTimeZone').val()),
                IsSendReviewInvite: isSendReviewInvite,
                SelectedRevieweeIDs: encodeURI(SelectedRevieweeIDs),
                // Start Vishal Mahajan 07-12-2019   
                StartDate: encodeURI($("#txtStartDate").val().trim()),
                EndDate: encodeURI($("#txtEndDate").val().trim()),
                TimezoneText: encodeURI($("#cboTimeZone option:selected").text().trim()),
                SelectedReviewerIDs: encodeURI(SelectedReviewerIDs),
                IterationID: encodeURI($('#CboIteration').val()),
                IsReviewInviteCancelled: IsReviewInviteCancelled,
                // END Vishal Mahajan 07-12-2019   
            }
            console.log(project_Review);



            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/UpdateProjectReview',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    // Start Vishal Mahajan 06-12-2019
                    if ($.isNumeric(result)) {


                        // Start Vishal Mahajan 02-01-2020
                        // for resheduled start and end date changed
                        if ((project_Review.IsReviewInviteCancelled == 1 && project_Review.IsSendReviewInvite == 1) || (project_Review.IsSendReviewInvite == 1 && ((OldStartDate != "" && OldEndDate != "") && (OldStartDate != decodeURI(project_Review.StartDate) || OldEndDate != decodeURI(project_Review.EndDate))))) {
                            sendInvitation(result, false, true);
                        }
                        else if (project_Review.ReviewStatisticsID == "" || project_Review.ReviewStatisticsID == "0") {
                            sendInvitation(result, true, false);
                        }
                        else if ($("#txtStartDate").attr("disabled") == undefined && (OldStartDate != decodeURI(project_Review.StartDate) || OldEndDate != decodeURI(project_Review.EndDate))) {
                            sendInvitation(result, false, true);
                        }
                        else if (OldSendInvitation == false && project_Review.IsSendReviewInvite == 1) {
                            sendInvitation(result, true, false);
                        }
                        else {
                            GetAllReviews(ReportFilterQuery);
                        }
                        if (project_Review.ReviewStatisticsID != "" && project_Review.ReviewStatisticsID != "0") {
                            $("#projectplanreviewtbl_wrapper").hide();
                            $("#ProaddnewreviewPanel").show('slow');
                            ClearFields();
                            hiddenReviewStatasticID = project_Review.ReviewStatisticsID;
                            setTimeout(GetReviewDetailsForEdit(hiddenReviewStatasticID, "PlannedReview"), 7000);
                            //GetReviewDetailsForEdit(hiddenReviewStatasticID, "PlannedReview");
                            enableDisabledControlsForEdit(false);
                            $('html, body, .content').animate({
                                scrollTop: $("#ProaddnewreviewPanel").offset().top -= 100
                            }, 500); // modified by pradip on 30-12-2019
                        } else {
                            enableDisabledControlsForEdit(true);
                            $("#ProaddnewreviewPanel").hide('slow');
                            $("#projectplanreviewtbl_wrapper").show();
                        }
                        showAlert('<%= MyBase.GetResourceString("C_ReviewSave") %>', "alert-success");
                        //Added By Reshma on 19th Oct 2020 For Refresh Issue Ater Add Review-27714
                        GetAllReviews(ReportFilterQuery);
                        //End of Added By Reshma on 19th Oct 2020 For Refresh Issue Ater Add Review-27714
                    }

                    else {

                        showAlert(result, "alert-danger")
                    }
                    StopAjaxLoader("#bodyPMProjectReview");
                },
                error: function (ER) {
                    StopAjaxLoader("#bodyPMProjectReview");
                    console.log(ER);
                }
            });


        }


        function ConvertJSDate(Date) {

            var day = Date.getDate();
            var month = Date.getMonth() + 1;
            var year = Date.getFullYear();
            var hour = Date.getHours();
            var minute = Date.getMinutes();
            var second = Date.getSeconds();
            var time = year + "/" + month + "/" + day;
            return time;
        }

        /*
         * Created Date     :   14 Oct 2019
         * Purpose          :   Clear fields of conducted reviews
         * Author           :   Chandrashekhar Salgar
         * 
         * ***/
        function ClearFields() {
            $("#cboReviewType").val("0");
            $('#txtAddReview').val("");
            $('#txtWork').val("");
            $("#cboReviwer option:selected").prop("selected", false);
            $("#cboReviwer option").each(function (i, val) {
                var optionText = $(this).text();
                var optionValue = $(this).val();
                if ($(this).val() == UserID) {
                    $("#cboReviwer").multiselect('select', [optionValue]);
                }
                else {
                    $("#cboReviwer").multiselect('deselect', [optionValue]);
                }
            });
            $("#cboReviwer").multiselect("refresh");

            $("#cboReviwee option:selected").prop("selected", false);
            $("#cboReviwee").multiselect("refresh");

            $('#chkBillable').prop('checked', false);
            $("#chkSendReviewInvite").prop('checked', false);
            $('#chkOfflineReview').prop('checked', false);
            $('#chkCancelReviewInvite').prop('checked', false);
            $('#divCancelInvite').css("display", "none");
            $('#divSendInvite').css("display", "block");
            $('#txtNoOfDefects').val("");
            $('#txtAreaNote').val("");
            //$('#CboSubproject').val("")
            $('#CboPhase').val("0")
            $('#CboMilestones').val("0")
            $('#CboModules').val("0")
            $('#CboDeliverables').val("0");
            $('#cboChecklist').val("0");
            $("#cboWorkProductType").val("0");
            $('#CboPhase').val("0");
            $('#CboSubproject').val("0");
            $('#CboIteration').val("0");
            $('#cboTimeZone').val(defaultTimeZone);
            var currentDate = new Date();
            var currentHours = currentDate.getHours();

            var currentMinutes = currentDate.getMinutes();
            var CurrentTime = currentHours + ":" + currentMinutes;
            //$('#txtStartTime, #txtEndTime').val(CurrentTime);
            $('#txtStartTime, #txtEndTime').val("");
            $('#txtStartDate, #txtEndDate').val("");
        }

        function ClearFieldscr() {
            $("#cboReviewTypecr").val("0");

            $('#txtWorkcr').val("");
            $("#cboReviwercr option:selected").prop("selected", false);
            $("#cboReviwercr").multiselect("refresh");

            $("#cboReviweecr option:selected").prop("selected", false);
            $("#cboReviweecr").multiselect("refresh");

            $('#chkBillablecr').prop('checked', false);
            $("#chkSendReviewInvitecr").prop('checked', false);
            $("#chkCancelReviewInvitecr").prop('checked', false);
            $('#chkOfflineReviewcr').prop('checked', false);

            $('#txtNoOfDefectscr').text("");
            $('#txtAreaNotecr').val("");
            //$('#CboSubproject').val("")
            $('#CboPhasecr').val("0")
            $('#CboMilestonescr').val("0")
            $('#CboModulescr').val("0")
            $('#CboDeliverablescr').val("0");
            $('#CboSubprojectcr').val("0");
            $('#txtWorkProductNameVersioncr').text("");
            $('#txtPercr').text("");
            $('#txtWhatWentWrongcr').text("");
            $('#txtWhatWasDonecr').text("");
            $('#CboIterationcr').val("0");
            $('#txtConculsioncr').text("");
            $("#CboUnitcr").val("");
            $("#CboReviewStatus").val("");
            $('#cboChecklistcr').val("0");
            $("#cboWorkProductTypecr").val("0");
            $('#cboTimeZonecr').val("0");
            $("#txtWorkProductNameVersioncr").text("");
            var currentDate = new Date();
            var currentHours = currentDate.getHours();

            var currentMinutes = currentDate.getMinutes();
            var CurrentTime = currentHours + ":" + currentMinutes;
            $('#txtStartTime, #txtEndTime').val(CurrentTime);
            $('#txtStartDate, #txtEndDate').val("");


        }


        /*
         * Created Date     :   19 Oct 2019
         * Purpose          :   Update conducted review
         * Author           :   Chandrashekhar Salagar
         * **/
        var IsUpdate = 0;
        $('#btnSaveReviewcr').on('click', function () {
            StartLoader("#bodyPMProjectReview");
            IsUpdate = 0;
            if ($("#chkCancelReviewInvitecr").is(":checked")) {
                sendCancellation("sendCancellation", ReviewStatisticsid);
                GetAllReviews(ReportFilterQuery);
                $(".detailsubtabs>li.active").removeClass("active");
                $(".detailsubtabs>li:first").addClass("active");
                $("#Revoverview,#RevActions,#Revchklist,#Revchklistissue,#RevAttachment").removeClass("active");
                $("#Revoverview").addClass("active");
                $(".conductdetail_panel").show("");
                ClearFieldscr();
                hiddenReviewStatasticID = ReviewStatisticsid;
                ConductedReviewCheck(hiddenReviewStatasticID);
                setTimeout(GetReviewDetailsForEdit(hiddenReviewStatasticID, "ConductedReview"), 7000);
                GetChecklistIssue(hiddenReviewStatasticID);
                GetDocumentsList(hiddenReviewStatasticID, 2191);
                enableDisabledControlsForEdit(false);
                showAlert('<%= MyBase.GetResourceString("C_ReviewSave") %>', "alert-success");
            } else {
                var isAllMandatorySelected = true;
                //start by Vishal Mahajan16-12-2019 for mandatory change
                var MandatoryFileds = ("Review Type,Work,Start Date,End Date,Start Time,End Time,Time Zone,Reviewer,Reviewee").split(',');
                $('#Revoverview .Mandatorycr').each(function (index, value) {
                    //end by Vishal Mahajan16-12-2019 for mandatory change
                    var Control = $(this);
                    var val = $(this).val();

                    if (val != "") {
                        if (val != "0") {
                            if (val != null) {
                                delete MandatoryFileds[index];
                            } else {
                                if ($('#chkOfflineReviewcr').prop('checked') == true && index != 8) {
                                    isAllMandatorySelected = false;
                                } else {
                                    delete MandatoryFileds[index];
                                }
                            }
                        }
                        else {
                            if ($('#chkOfflineReviewcr').prop('checked') == true && index != 8) {
                                isAllMandatorySelected = false;
                            } else {
                                delete MandatoryFileds[index];
                            }
                        }
                    }
                    //start by Vishal Mahajan16-12-2019 for mandatory change
                    else {
                        if ($('#chkOfflineReviewcr').prop('checked') == true && index != 8) {
                            isAllMandatorySelected = false;
                        } else {
                            delete MandatoryFileds[index];
                        }
                    }
                    //end by Vishal Mahajan16-12-2019 for mandatory change
                });

                if (isAllMandatorySelected) {
                    var WorkProductNameVersion = $("#txtWorkProductNameVersioncr").val();
                    var Note2 = $("#txtAreaNotecr").val();
                    var per = $("#txtPercr").val();
                    var WhatWentWrong = $("#txtWhatWentWrongcr").val();
                    var WhatWasDoneRight = $("#txtWhatWasDonecr").val();
                    var Conclusion = $("#txtConculsioncr").val();
                    if ($('#cboReviewTypecr').val() == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_Review_Type_Blank") %>', "alert-danger");
                        $('#cboReviewTypecr').focus();
                    }
                    else if ($('#txtWorkcr').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                        $('#txtWorkcr').focus();
                    }
                    else if ($('#txtStartDatecr').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewStartDate_Blank") %>', "alert-danger");
                        $('#txtStartDatecr').focus();
                    }
                    else if ($('#txtEndDatecr').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewEndDate_Blank") %>', "alert-danger");
                        $('#txtEndDatecr').focus();
                    }
                    else if ($('#txtStartTimecr').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewStartTime_Blank") %>', "alert-danger");
                        $('#txtStartTimecr').focus();
                    }
                    else if ($('#txtEndTimecr').val().trim().length == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_ReviewEndTime_Blank") %>', "alert-danger");
                        $('#txtEndTimecr').focus();
                    }
                    else if ($('#cboReviwercr').get(0).selectedIndex == -1) {
                        showAlert('<%= MyBase.GetResourceString("C_Reviewer_Blank") %>', "alert-danger");
                        $('#cboReviwercr').focus();
                    }
                    else if ($('#cboReviweecr').get(0).selectedIndex == -1 && $('#chkOfflineReviewcr').prop('checked') == false) {
                        showAlert('<%= MyBase.GetResourceString("C_Reviewee_Blank") %>', "alert-danger");
                        $('#cboReviweecr').focus();
                    }
                    else if ($('#cboTimeZonecr').val() == 0) {
                        showAlert('<%= MyBase.GetResourceString("C_Timezone_Blank") %>', "alert-danger");
                        $('#cboTimeZonecr').focus()
                    }
                    //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
                    else if (checkSpecialCharacter(WorkProductNameVersion, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Work Product Name Version should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtWorkProductNameVersioncr").focus();                        
                    }
                    //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
                    else if (checkSpecialCharacter(Note2, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Note should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtAreaNotecr").focus();
                    }
                   //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
                    else if (checkSpecialCharacter(per, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Per should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtPercr").focus();
                    }
                    //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
                    else if (checkSpecialCharacter(WhatWentWrong, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('What Went Wrong not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtWhatWentWrongcr").focus();
                    } 
                   //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
                    else if (checkSpecialCharacter(WhatWasDoneRight, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('What Was Done Right not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtWhatWasDonecr").focus();
                    }

                   //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
                    else if (checkSpecialCharacter(Conclusion, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Conclusion should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtConculsioncr").focus();
                    }
               
                    // By Vishal Mahajan 30-12-2019
                    else if (isAgileMethodused == 1 && ($('#CboIterationcr').val() == "" || $('#CboIterationcr').val() == "0" || $('#CboIterationcr').val() == null)) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Sprint") %>', "alert-danger");
                        $('#CboIterationcr').focus()
                    }
                    else if ($('#CboPhasecr').val() == "" || $('#CboPhasecr').val() == "0" || $('#CboPhasecr').val() == null) {
                        showAlert('<%= MyBase.GetResourceString("C_Please_Select_Phase") %>', "alert-danger");
                        $('#CboPhasecr').focus()
                    }
                    // By Vishal Mahajan 26-12-2019
                    ////Added By Rehan for Character Validation for Per on 12th Nov 2022	
                    //else if ($('#txtPercr').val().trim() != "") {
                    //    var chkresult1 = PerValidation("txtPercr");

                    //}


                    else if ($('#txtNoOfDefectscr').val().trim() != "") {

                        var chkresult = NoOfDefectsValidation("txtNoOfDefectscr");
                        if (chkresult == true) {
                            //End Added By Reshma on 26th Dec 2019 For IssueID-21125
                            var IsValid = CheckValidHoursCr($('#txtWorkcr').val().trim());
                            if (IsValid)
                            {

                                var jsStartDate = $('#txtStartDatecr').datepicker('getDate');
                                var jsEndDate = $('#txtEndDatecr').datepicker('getDate');
                                var StartDate = new Date(jsStartDate);
                                var EndDate = new Date(jsEndDate);

                                if (StartDate > EndDate) {
                                    $('#txtEndDatecr').focus();
                                    showAlert('<%= MyBase.GetResourceString("C_StartDate_Greater") %>', "alert-danger");
                                }
                                else {

                                    if (GlobalHoursFlag == 1) {
                                        var minutes = $('#txtWorkcr').val().split(':');
                                        var p = minutes[0];
                                        var dec = minutes[1];
                                        if (dec == undefined) { dec = 0; }
                                        var d = (dec - 0) / 60 + (p - 0);
                                    }

                                    if (MinDAENtryDisplay != "") {
                                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                                            showAlert('Please specify the Work(hrs) in multiples of ( ' + MinDAENtryDisplay + ' ) hours.', 'alert-danger');
                                            $('#txtWorkcr').focus();
                                            return;
                                        }
                                        else {
                                            if ($('#CboReviewStatus option:selected').text() == "Closed") {
                                                IsUpdate = 1;
                                                SetStatusClosed();
                                            } else {
                                                UpdateReviewConductedReview();
                                            }
                                        }
                                    }
                                    else {
                                        if ($('#CboReviewStatus option:selected').text() == "Closed") {
                                            IsUpdate = 1;
                                            SetStatusClosed();
                                        } else {
                                            UpdateReviewConductedReview();
                                        }
                                    }

                                }
                            }
                            else {
                                if ($("#txtWorkcr").val().trim() == "") {
                                    showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                                    return false;
                                } else {
                                    showAlert('<%= MyBase.GetResourceString("C_Time_Format") %>', "alert-danger");
                                }
                            }
                        }
                    }
                    //Added By Reshma Chavan on 9th Dec 2020 For Reviwee alert Issue                 
                    else {
                        if ($('#CboReviewStatus option:selected').text() == "Closed") {
                            IsUpdate = 1;
                            SetStatusClosed();
                        }
                        else {
                            IsUpdate = 0;
                            UpdateReviewConductedReview();
                        }
                    }
                    //End of Added By Reshma Chavan on 9th Dec 2020 For Reviwee alert Issue   
                }
                else {

                    var destinationArray = new Array();
                    $(MandatoryFileds).each(function (index, value) {
                        if (value != undefined) {
                            destinationArray.push(value);
                        }
                    });
                    showAlert("Please select " + destinationArray.toString(), "alert-danger");
                }
            }

            //Added By Dipali V on 21st April 2020 For Alert Should Come
            //Commented And Added By Reshma Chavan on 9th Dec 2020 For Reviwee Alert Issue           
            //if(IsUpdate != 1){
            //    if ($('#CboReviewStatus option:selected').text() == "Closed") {
            //        SetStatusClosed();
            //    } else {
            //        UpdateReviewConductedReview();
            //    }
            //}
            if (IsUpdate == 1) {
                if ($('#CboReviewStatus option:selected').text() == "Closed") {
                    SetStatusClosed();
                }
                else {
                    UpdateReviewConductedReview();
                }
            }

            //Commented And Added By Reshma Chavan on 9th Dec 2020 For Reviwee Alert Issue
            //End of Added By Dipali V on 21st April 2020 For Alert Should Come
            StopAjaxLoader("#bodyPMProjectReview");
        });


        //Added By Reshma on 26th Dec 2019 For IssueID-21125
        //No Of Defects validation
        function NoOfDefectsValidation(ControlID) {
            var objNoOfDefects = document.getElementById(ControlID);
            var isdigit = isNumeric(objNoOfDefects.value);
            if (isdigit == false) {
                showAlert("Please enter only positive numeric value for 'Number of Defects'", "alert-danger");
                $('#txtNoOfDefectscr').focus();
                return false;
            }
            if (disallowNegativeNumeric(objNoOfDefects)) {
                showAlert("Please enter only positive numeric value for 'Number of Defects'", "alert-danger");
                $('#txtNoOfDefectscr').focus();
                return false;
            }
            if (objNoOfDefects.value.indexOf('.') > -1) {
                showAlert("Please enter only positive numeric value for 'Number of Defects'", 'alert-danger');
                $('#txtNoOfDefectscr').focus();
                return false;
            }
            return true;
        }

        //Added By Rehan To Add Character validation for Per on 12th Nov 2022
        function PerValidation(ControlID) {
            var objPerV = document.getElementById(ControlID);
            var isdigit = isNumeric(objPerV.value);
            if (isdigit == false) {
                showAlert("Please enter only positive numeric value for 'Per'", "alert-danger");
                $('#txtPercr').focus();
                return false;
            }
            if (disallowNegativeNumeric(objPerV)) {
                showAlert("Please enter only positive numeric value for 'Per'", "alert-danger");
                $('#txtPercr').focus();
                return false;
            }
            if (objPerV.value.indexOf('.') > -1) {
                showAlert("Please enter only positive numeric value for 'Per'", 'alert-danger');
                $('#txtPercr').focus();
                return false;
            }
            return true;
        }
        //End Added By Reshma on 26th Dec 2019 For IssueID-21125

        /*
         * Create Date      :   19 Oct 20149
         * Purpose          :   Update conducted review
         * Author           :   Chandrashekhar Salagar
         * **/
        function UpdateReviewConductedReview() {
            StartLoader("#bodyPMProjectReview");
            var Title = $("#txtAddReviewcr").text();
            var IsOfflineReview = "0";
            var IsReviewBillable = "0";
            var IsCarryForwardedRev = "0";
            var SubProjectID = 0;
            var MilestoneID = 0;
            var PhaseID = 0;
            var ModuleID = 0;
            var DeliverableID = 0;
            var isSendReviewInvite = 0;
            var jsStartDate = $('#txtStartDatecr').datepicker('getDate');
            var jsEndDate = $('#txtEndDatecr').datepicker('getDate');
            var startDate = ConvertJSDate(jsStartDate);
            var endDate = ConvertJSDate(jsEndDate);
            var jsStartTime = $('#txtStartTimecr').val();
            var jsEndTime = $('#txtEndTimecr').val();
            if ($('#chkOfflineReviewcr').prop('checked') == true) {
                IsOfflineReview = "1"
            }
            if ($('#chkBillablecr').prop('checked') == true) {
                IsReviewBillable = "1";
            }
            if ($('#chkSendReviewInvitecr').prop('checked') == true) {
                IsCarryForwardedRev = "1";
            }
            if ($('#chkSendReviewInvitecr').prop('checked') == true) {
                isSendReviewInvite = 1;
            }

            var SelectedReviewers = $("#cboReviwercr option:selected").map(function () {
                return $(this).text();
            }).get().join(',');

            var SelectedReviewee = $("#cboReviweecr option:selected").map(function () {
                return $(this).text();
            }).get().join(',');

            var SelectedRevieweeIDs = $("#cboReviwee option:selected").map(function () {
                return $(this).val();
            }).get().join(',');

            var SelectedReviewerIDs = $("#cboReviwercr option:selected").map(function () {
                return $(this).val();
            }).get().join(',');

            var SelectedRevieweeIDs = $("#cboReviweecr option:selected").map(function () {
                return $(this).val();
            }).get().join(',');

            if (SelectedRevieweeIDs == "") {
                SelectedRevieweeIDs = ",0,";
            } else {
                SelectedRevieweeIDs = "," + SelectedRevieweeIDs + ",";
            }

            SelectedReviewerIDs = "," + SelectedReviewerIDs + ",";

            var IsReviewInviteCancelled = 0;
            if ($('#hdnCancelReviewInvitecr').val() == "1") {
                IsReviewInviteCancelled = 1;
            }

            var project_Review = {
                ReviewStatisticsID: encodeURI(ReviewStatisticsid),
                ProjectId: encodeURI($('#CboProject').val()),
                ReviewType: encodeURI($("#cboReviewTypecr option:selected").text().trim()),
                ProjectPhase: encodeURI(""),
                NoOfReviews: encodeURI(""),
                ReviewEffort: encodeURI(replaceAllChar($('#txtWorkcr').val().trim())),
                NoOfDefects: encodeURI(replaceAllChar($('#txtNoOfDefectscr').val().trim())),
                ReviewedBy: encodeURI(SelectedReviewers),
                ReviewNotes: encodeURI(replaceAllChar($('#txtAreaNotecr').val().trim())),
                Reviewee: encodeURI(SelectedReviewee),
                CReviewTypeID: encodeURI($("#cboReviewTypecr").val()),
                PReviewTypeID: encodeURI($("#cboReviewTypecr").val()),
                IsPlannedReview: encodeURI("1"),
                WorkProductType: encodeURI($("#cboWorkProductTypecr option:selected").text().trim()),
                ModuleID: encodeURI($("#CboModulescr").val()),
                DeliverableID: encodeURI($("#CboDeliverablescr").val()),
                DeliverableTypeID: encodeURI($("#CboDeliverablescr").val()),
                ChecklistTypeId: encodeURI($("#cboChecklistcr").val()),
                ReviewTitle: encodeURI(replaceAllChar($("#txtAddReviewcr").text().trim())),
                ReviewStartDate: encodeURI(startDate),
                ReviewEndDate: encodeURI(endDate),
                IsOfflineReview: encodeURI(IsOfflineReview),
                IsReviewBillable: encodeURI(IsReviewBillable),
                ModifiedBy: encodeURI(UserName),
                //IsCarryForwardedRev: encodeURI(IsCarryForwardedRev),
                SubProjectID: encodeURI($('#CboSubprojectcr').val()),
                MilestoneID: encodeURI($('#CboMilestonescr').val()),
                PhaseID: encodeURI($('#CboPhasecr').val()),
                StartTime: encodeURI(jsStartTime),
                EndTime: encodeURI(jsEndTime),
                Timezone: encodeURI($('#cboTimeZonecr').val()),
                IsSendReviewInvite: isSendReviewInvite,
                MeasurementNumber: encodeURI(replaceAllChar($('#txtPercr').val().trim())),
                //Commented and Added By Reshma C on 19 March 2020 For IssueID-23419
                //Conclusion: encodeURI(replaceAllChar($('#txtConculsioncr').val().trim())),
                Conclusion: encodeURI($.trim($('#txtConculsioncr').val().replace(/[\t\n]+/g, ' '))),
                //End of Commented and Added By Reshma C on 19 March 2020 For IssueID-23419

                MeasurementUnit: encodeURI($('#CboUnitcr').val()),
                //Commented and Added By Reshma C on 19 March 2020 For IssueID-23419
                //WhatWentWrong: encodeURI(replaceAllChar($('#txtWhatWentWrongcr').val().trim())),
                //WhatWasRight: encodeURI($('#txtWhatWasDonecr').val().trim()),
                WhatWentWrong: encodeURI($.trim($('#txtWhatWentWrongcr').val().replace(/[\t\n]+/g, ' '))),
                WhatWasRight: encodeURI($.trim($('#txtWhatWasDonecr').val().replace(/[\t\n]+/g, ' '))),
                //End Of Commented and Added By Reshma C on 19 March 2020 For IssueID-23419
                IterationID: encodeURI($('#CboIterationcr').val()),
                ReviewStatus: encodeURI($('#CboReviewStatus option:selected').text().trim()),
                WorkProductName: encodeURI(replaceAllChar($("#txtWorkProductNameVersioncr").val().trim())),
                SelectedReviewerIDs: encodeURI(SelectedReviewerIDs),
                SelectedRevieweeIDs: encodeURI(SelectedRevieweeIDs),
                // Start Vishal Mahajan 12-12-2019   
                StartDate: encodeURI($("#txtStartDatecr").val().trim()),
                EndDate: encodeURI($("#txtEndDatecr").val().trim()),
                TimezoneText: encodeURI($("#cboTimeZone option:selected").text().trim()),
                IsReviewInviteCancelled: IsReviewInviteCancelled,
                // END Vishal Mahajan 12-12-2019   
            }
            console.log(project_Review);
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/SaveConductedReview',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                // Start Vishal Mahajan 02-01-2020
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    HideStatusClosedModel();
                    StopAjaxLoader("#bodyPMProjectReview");
                    // Start Vishal Mahajan 02-01-2020
                    if ($.isNumeric(result)) {

                        // for resheduled start and end date changed
                        //if (project_Review.IsReviewInviteCancelled == 1 && (OldStartDate != "" && OldEndDate != "") && (OldStartDate != decodeURI(project_Review.StartDate) || OldEndDate != decodeURI(project_Review.EndDate))) {
                        if ((project_Review.IsReviewInviteCancelled == 1 && project_Review.IsSendReviewInvite == 1) || (project_Review.IsSendReviewInvite == 1 && ((OldStartDate != "" && OldEndDate != "") && (OldStartDate != decodeURI(project_Review.StartDate) || OldEndDate != decodeURI(project_Review.EndDate))))) {
                            sendInvitation(result, false, true);
                        }
                        //else if (OldStartDate == "" && OldEndDate == "" || (project_Review.IsSendReviewInvite == 1 && $("#chkSendReviewInvitecr").attr("disabled") == undefined)) {
                        //else if (project_Review.IsSendReviewInvite == 1 && $("#txtStartDatecr").attr("disabled") == undefined ) {
                        if ($("#txtStartDatecr").attr("disabled") == undefined && (OldStartDate != decodeURI(project_Review.StartDate) || OldEndDate != decodeURI(project_Review.EndDate))) {
                            project_Review.ReviewStatisticsID = result;
                            sendInvitation(result, true, false);
                        }
                        else if (OldSendInvitation == false && project_Review.IsSendReviewInvite == 1) {
                            sendInvitation(result, true, false);
                        }
                        else {
                            GetAllReviews(ReportFilterQuery);
                        }
                        $(".detailsubtabs>li.active").removeClass("active");
                        $(".detailsubtabs>li:first").addClass("active");
                        $("#Revoverview,#RevActions,#Revchklist,#Revchklistissue,#RevAttachment").removeClass("active");
                        $("#Revoverview").addClass("active");
                        $(".conductdetail_panel").show("");
                        //$('html, body, .content').animate({
                        //    scrollTop: $(".conductdetail_panel").offset().top -= 200
                        //}, 500);
                        ClearFieldscr();
                        hiddenReviewStatasticID = project_Review.ReviewStatisticsID;
                        ConductedReviewCheck(hiddenReviewStatasticID);
                        setTimeout(GetReviewDetailsForEdit(hiddenReviewStatasticID, "ConductedReview"), 7000);
                        //GetReviewDetailsForEdit(hiddenReviewStatasticID, "ConductedReview");
                        GetChecklistIssue(hiddenReviewStatasticID);
                        GetDocumentsList(hiddenReviewStatasticID, 2191);
                        enableDisabledControlsForEdit(false);
                        //enableDisabledControlsForEdit(true);
                        //$(".conductdetail_panel").hide("fast");                       
                        showAlert('<%= MyBase.GetResourceString("C_ReviewSave") %>', "alert-success");

                    }

                    else {
                        showAlert(result, "alert-danger")
                    }

                },
                error: function (ER) {
                    StopAjaxLoader("#bodyPMProjectReview");
                    console.log(ER);
                }
            });


        }


        /**
         * Created Date     :   22 Sept 2019
         * Purpose          :   Check if review is conducted 
         * Author           :   Chandrashekhar  Salagar
         * @param ReviewStatisticsID
         */
        function ConductedReviewCheck(ReviewStatisticsID) {

            var project_Review = {
                ReviewStatisticsID: encodeURI(ReviewStatisticsID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/ConductedReviewCheck',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {

                    if (result != 0) {
                        $('#chkSendReviewInvitecr').prop('disabled', true);
                        $("#cboReviweecr").multiselect("disable");
                        $('#chkOfflineReviewcr').prop('disabled', true);
                        $('#chkBillablecr').prop('disabled', true);
                        //$('#txtNoOfDefectscr').prop('disabled', true);
                        //$('#cboChecklistcr').prop('disabled', true);
                        //$('#CboModulescr').prop('disabled', true);
                        //$('#CboDeliverablescr').prop('disabled', true);
                        //$('#txtAreaNotecr').prop('disabled', true);
                        $("#cboReviweecr,#cboReviwercr").multiselect("disable");
                        $('#cboReviewTypecr,#txtWorkcr,#txtStartDatecr,#txtEndDatecr,#txtStartTimecr,#txtEndTimecr,#cboTimeZonecr,#cboWorkProductTypecr,#chkOfflineReviewcr,#chkBillablecr').prop('disabled', true);
                    }
                    else {
                        $('#chkSendReviewInvitecr').prop('disabled', false);
                        $("#cboReviweecr").multiselect("enable");
                        $('#chkOfflineReviewcr').prop('disabled', false);
                        $('#chkBillablecr').prop('disabled', false);
                        $('#txtNoOfDefectscr').prop('disabled', false);
                        $('#cboChecklistcr').prop('disabled', false);
                        $('#CboModulescr').prop('disabled', false);
                        $('#CboDeliverablescr').prop('disabled', false);
                        $('#txtAreaNotecr').prop('disabled', false);
                        $("#cboReviweecr,#cboReviwercr").multiselect("enable");
                        $('#cboReviewTypecr,#txtWorkcr,#txtStartDatecr,#txtEndDatecr,#txtStartTimecr,#txtEndTimecr,#cboTimeZonecr,#cboWorkProductTypecr,#chkOfflineReviewcr,#chkBillablecr').prop('disabled', false);
                    }
                },
                error: function (ER) {
                    console.log(ER);
                }
            });

        }


        /*
         * Created By   :   Chandrashekhar Salagar
         * Date         :   25 Sept 2019
         * Purpose      :   validate Action work hours
         * **/
        //remove by Vishal M 02-01-2019
        $(document).on('change', '.work', function () {

        });

        /*
         * Created Date     :   25 Sept 2019
         * Purpose          :   Convert to action link click 
         * Author           :   Chandrashekhar Salagar.
         * **/
        var ObservationID = "";
        $(document).on('click', '.converttoAction', function () {

            ObservationID = $(this).next().val();
            $("#txtmodalDecription").val($(this).next().next().text());
            $("#txtmodalWork").val('');
            $("#CboModalCauses").val('0');
            $("#CboModalReviewee").val('0');
            /*Bind Modal dropdowns*/
            $("#CboModalReviewee").html("");
            $("#CboModalReviewee").prepend("<option value='0' selected='selected'>Select Reviewee</option>").val();
            $("#cboReviweecr option ").each(function (i, val) {
                var property = $(this).prop('selected');
                if ($(this).prop('selected')) {
                    var thisText = $(this).text();
                    var actualValue = $(this).val();
                    $("#CboModalReviewee").append($("<option></option>").val(actualValue).html(thisText));
                }
            });
            var project_Review = {
                ProjectId: encodeURI($('#CboProject').val()),
                ReviewStatisticsID: hiddenReviewStatasticID
            };
            GetCauses(project_Review, $('#CboModalCauses'));
            $('#divConvertToAction').modal('show');
        });

        /*
         * Created Date     :   25 Sept 2019
         * Purpose          :   Save converted action
         * Author           ;   Chandrashekhar Salagar
         * **/
        $("#btnSaveModal").on('click', function () {
            //added by Vishal M 02-01-2019
            var IsValidActionHours = CheckHHMMFormat($("#txtmodalWork")[0]);
            if ($('#CboModalCauses').val() == "0") {
                showAlert('<%= MyBase.GetResourceString("C_ReviewCuase_Blank") %>', "alert-danger");
            }
            else if ($("#txtmodalDecription").val().trim() == "") {
                showAlert('<%= MyBase.GetResourceString("C_Convert_To_Action_Not_Blank") %>', "alert-danger");
            }
            else if ($("#txtmodalWork").val().trim() == "") {
                showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
            }
            //added by Vishal M 02-01-2019
            else if (IsValidActionHours == false) {
                showAlert('<%= MyBase.GetResourceString("C_Time_Format") %>', "alert-danger");
            }
               //Commented and Added By Reshma chavan on 27 Jan 2021 for offline review alert
            <%--else if ($("#CboModalReviewee").val() == "0") {
                showAlert('<%= MyBase.GetResourceString("C_Reviewee_Blank") %>', "alert-danger");
            }--%>
            else if ($("#CboModalReviewee").val() == "0" && $('#chkOfflineReviewcr').prop('checked') == false) {
                showAlert('<%= MyBase.GetResourceString("C_Reviewee_Blank") %>', "alert-danger");
            }
             //End of Commented and Added By Reshma chavan on 27 Jan 2021 for offline review alert
            else {
                var ReviewActionID = "0";
                var Description = $('#txtmodalDecription').val().trim();

                var reviewactions = {
                    ReviewActionID: encodeURI(ReviewActionID),
                    ProjectID: encodeURI($('#CboProject').val()),
                    ReviewStatisticsID: encodeURI(hiddenReviewStatasticID),
                    PReviewCauseID: encodeURI(replaceAllChar($('#CboModalCauses').val())),
                    Action: encodeURI(replaceAllChar(Description)),
                    Reviewee: encodeURI($("#CboModalReviewee").val()),
                    CreatedBy: encodeURI(replaceAllChar(UserName)),
                    WorkInHours: encodeURI(replaceAllChar($("#txtmodalWork").val().trim())),
                    ReviewObservationID: ObservationID,
                };

                /*Validate work hours */

                if (GlobalHoursFlag == 1) {
                    var minutes = $("#txtmodalWork").val().split(':');
                    var p = minutes[0];
                    var dec = minutes[1];
                    if (dec == undefined) { dec = 0; }
                    var d = (dec - 0) / 60 + (p - 0);
                }

                if (MinDAENtryDisplay != "") {
                    if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                        showAlert('Please specify the Work(hrs) in multiples of ( ' + MinDAENtryDisplay + ' ) hours.', 'alert-danger');
                    }
                    else {
                        SaveModalAction(reviewactions);
                        UpdateActionToObservation(ObservationID);
                        $('#divConvertToAction').modal('hide');
                        $('#CboModalCauses').val("0");
                        $('#txtmodalDecription').val("");
                        $("#txtmodalWork").val("0");
                        $("#CboModalReviewee").val("0");
                    }
                }
                else {
                    SaveModalAction(reviewactions)
                    UpdateActionToObservation(ObservationID);
                    $('#divConvertToAction').modal('hide');
                    $('#CboModalCauses').val("0");
                    $('#txtmodalDecription').val("");
                    $("#txtmodalWork").val("0");
                    $("#CboModalReviewee").val("0");
                }



            }

        });

        function SaveModalAction(reviewactions) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/SaveReviewAction',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(reviewactions),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviewactions) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviewactions) ? reviewactions : JSON.stringify(reviewactions)));
                    }
                },
                success: function (result) {
                    $("#hdnConvertedActionID").val(result);

                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }

        function UpdateActionToObservation(ObservationID) {
            var observations = {
                ReviewActionID: encodeURI($("#hdnConvertedActionID").val()),
                ReviewObservationID: encodeURI(ObservationID)

            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/UpdateActionToObservation',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(observations),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (observations) {
                        xhr.setRequestHeader("Params", encryptString(isJson(observations) ? observations : JSON.stringify(observations)));
                    }
                },
                success: function (result) {
                    $("#hdnConvertedActionID").val("");
                    ObservationID = "";
                    showAlert('<%= MyBase.GetResourceString("C_ReviewActionSave") %>', "alert-success");
                    GetReviewActions(hiddenReviewStatasticID);
                    //$(currentButton).parents("tr").find(".add, .edit").toggle();
                    $(".add-new").removeAttr("disabled");
                    $('[data-bs-toggle="tooltip"]').tooltip('dispose');

                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }

        /*From Designer*/

        $('.nav-tabs a[href="#conductreview"]').click(function () {
            $('.fbtnCR').css('display', 'block');
            $('.fbtnPR').css('display', 'none');

        });

        $('.nav-tabs a[href="#planreview"]').click(function () {
            $('.fbtnCR').css('display', 'none');
            $('.fbtnPR').css('display', 'block');

        });



        // START Vishal Mahajan 
        function Multiselectddl() {
            $('.multiselectdropdown').multiselect({
                destroy: true,
                numberDisplayed: 1,
                includeSelectAllOption: true,
                countSelectedText: true,
                //allSelectedText: true,
                selectAllJustVisible: false,
                nSelectedText: 'selected',
                nonSelectedText: 'None selected',
                delimiterText: '/ ',
                onSelectAll: function () {
                    $('button[class="multiselect"]').attr('title', false);
                },
                //templates: {
                //    button: '<button type="button" class="multiselect dropdown-toggle btn btn-primary form-select" data-bs-toggle="dropdown" aria-expanded="false"><span class="multiselect-selected-text"></span></button>',
                //},
                buttonTitle: function () { },
            }); //New function added by pradip on 26-12-2019

        }
        // END Vishal Mahajan 



        $(function () {
            $('#txtStartTime, #txtEndTime, #txtStartTimecr, #txtEndTimecr').datetimepicker({
                defaultDate: new Date(),
                // var now = new Date();
                format: 'HH:mm',
                icons:
                {
                    up: 'fas fa-chevron-up',
                    down: 'fas fa-chevron-down'
                },
                keepOpen: true
            }).on('dp.hide', function(e) {
                // Prevent the picker from closing when clicking outside
                e.preventDefault();
        });
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.collapse', function () {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });
        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        //dynamically set height
        function resizeSection(tag) {
            var divhieght2 = $(window).height();
            $('#planreview .dataTables_scrollBody').css({
                'height': divhieght2 - 324,
                "overflow-y": "auto", "overflow-x": "hidden"
            });

            var divhieght3 = $(window).height();
            $('#conductreview .dataTables_scrollBody').css({
                'height': divhieght2 - 230,
                "overflow-y": "auto", "overflow-x": "hidden"
            });

        }//modified by pradip on 26-12-2019

        $(window).on("load resize scroll click", function (e) {
            resizeSection(this);
        });

        $('[data-bs-toggle="tooltip"]').tooltip();
        var actions = $("#conductActiontbl td.actioncolumn").html();
        // Append table with add row form on add new button click
        $(".add-new").click(function () {
            $(this).attr("disabled", "disabled");
            $('.edit, .delete, .converttoAction').prop('disabled', true);
            var checkBoxProperty = "";
            /*===============if review is offline then disable convert to task option====================== */
            if ($('#chkOfflineReviewcr').prop("checked")) {
                checkBoxProperty = "disabled";
            }
            if (isAgileMethodused) {
                checkBoxProperty = "disabled";
            }
            var actionTask = '', actionIssue = '';
            actionTask = '<div class="custom_chckbox"><input id="ACT4" type="checkbox" class="chcktbl TaskCheckBox" ' + checkBoxProperty + '><label for="ACT4"></label></div>';
            actionIssue = '<div class="custom_chckbox"><input id="ACT5" type="checkbox" class="chcktbl IssueCheckBox" ' + checkBoxProperty + '><label for="ACT5"></label></div>';
            if (isAgileMethodused) {
                actionTask = 'NA';
                actionIssue = 'NA';
            }
            //modified on 31-12-2019 by pradip
            var index = $("#conductActiontbl tbody tr:last-child").index();
            var row = '<tr class="add_llrow">' +
                '<td class="text-start"><select class="form-select ActionType" id="CboActionType"><option>Select Action</option><option>Action</option><option>Observation</option></select></td>' +
                '<td class="text-start"><select class="form-select" name="ActionCause" id="ActionCause"><option>Select Cause</option></select></td>' +
                '<td><textarea rows="1" cols="50" maxlength="1000" class="form-control exandonfocus" name="" id="descript"></textarea></td>' +
                '<td><input type="text" maxlength="7" class="form-control work" /></td>' +
                '<td><select class="form-select CboActionReviewee" name="Reviewee" id="Reviewee"><option>Select Reviewee</option><option>ABC</option>ABC<option>Action 2</option></select></td>' +
                '<td>' + actionTask + '</td>' +
                '<td>' + actionIssue + '</td>' +
                '<td><div class="custom_chckbox"><input id="ACT6" type="checkbox" class="chcktbl trackToNextReview"><label for="ACT6"></label></td> <td></td>' +
                '<td class="actioncolumn" style="width:14%"> <a id="convertToAction" class="reviewcancellationlink converttoAction" href="javascript:;" style="display:none" >Convert to action</a>  <a href="javascript:;" class="add" title="" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save">' +
                '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px"></a>' +
                '<a class="edit_SH_Detail nostylebtn edit" href="javascript:;" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Edit">' +
                '<img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px">' +
                '</a>' +
                //'<a class="nostylebtn Cancel" style="color:black" data-bs-toggle="modal" data-bs-target="#deleteinfomodal">' +    by Vishal Mahajan 28-12-2019
                '<a class="nostylebtn Cancel" style="color:black" data-bs-toggle="modal">' +
                '<i class="fa fa-times" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Cancel"></i></a>'
            '</td>' +
                '</tr>';
            $("#conductActiontbl").append(row);
            $("#conductActiontbl tbody tr").eq(index + 1).find(".add, .edit").toggle();
            $('[data-bs-toggle="tooltip"]').tooltip();

            var element = $(".CboActionReviewee");
            var reviewee = $("#conductActiontbl tbody tr:last-child td:nth-child(n+4)").find('select');
            $(reviewee).html("");
            $(reviewee).prepend("<option value='0' selected='selected'>Select Reviewee</option>").val();
            $("#cboReviweecr option").each(function () {
                var property = $(this).prop('selected');
                if ($(this).prop('selected')) {
                    var thisText = $(this).text();
                    var actualValue = $(this).val();
                    $(reviewee).append($("<option></option>").val(actualValue).html(thisText));
                }
            });
        });

        /*
         * Craeted Date      :   23 Oct 2019
         * Purpose           :   Save action on review
         * Author            :   Chandrashekhar Salagar
         * **/
        $(document).on("click", "#conductActiontbl .add", function () {
            //Added By Reshma on 31st Dec 2019 For IssueID-21111
            var DefaultType = GblDefaultType;
            //Added by Chetan M on 9th April 2020 for IssueID = 23593
            GetCorporateReviewDefaultStatus(GblDefaultType);
            GetCorporateReviewDefaultType(GblDefaultType);
            //End of Added by Chetan M on 9th April 2020 for IssueID = 23593
            if (DefaultType == undefined || DefaultType == null) { DefaultType = ""; }
            else { DefaultType = DefaultType; }
            //End Added By Reshma on 31st Dec 2019 For IssueID-21111

            var ReviewType = "";
            var currentButton = $(this);
            var ReviewActionID = "";
            var PReviewCauseID = "";
            var Work = "";
            var Action = "";
            var Reviewee = "";
            var IsConvertToTaskChecked;
            var ConvertIssueChecked;
            var IsTrackToNextReview = "0";
            var IsClosed = "0";
            var trElement = $(this).parents("tr");
            var IsValidActionHours;
            $(trElement).find('td').each(function (index, value) {

                if (index == 0) {
                    ReviewActionID = $(this).find('input').val();
                    ReviewType = $(this).find('select').val();
                    if (ReviewActionID == undefined) {
                        ReviewActionID = "0";
                    }
                }
                if (index == 1) {
                    PReviewCauseID = $(this).find('select').val();
                }
                if (index == 2) {
                    Action = $(this).find('textarea').val().trim();
                }
                if (index == 3) {

                    var test = $(this).find('.work');
                    Work = $(this).find('.work').val().trim();
                    IsValidActionHours = CheckHHMMFormat($(this).find('.work')[0]);
                }
                if (index == 4) {
                    Reviewee = $(this).find('select').val();
                }
                if (index == 5) {

                    if ($(this).find('.chcktbl').prop('checked')) {
                        if ($(this).find('.chcktbl').hasClass('existing') == false) {
                            IsConvertToTaskChecked = true;
                        }
                    }
                }
                if (index == 6) {
                    if ($(this).find('.chcktbl').prop('checked')) {
                        if ($(this).find('.chcktbl').hasClass('existing') == false) {
                            ConvertIssueChecked = true;
                        }
                    }
                }
                if (index == 7) {

                    if ($(this).find('.chcktbl').prop('checked')) {
                        if ($(this).find('.chcktbl').hasClass('ConvertedObservation') == false) {
                            IsTrackToNextReview = "1";
                        }
                    }
                }
                if (index == 8) {

                    if ($(this).find('.chcktbl').prop('checked')) {
                        if ($(this).find('.chcktbl').hasClass('ConvertedObservation') == false) {
                            IsClosed = "1";
                        }
                    }
                }
            });

            /*If review type is Action then this block will execute*/

            if (ReviewType == "Action") {
                /* Validation check for cause and reviewee */
                var Description2 = $("#descript").val();
                if (ReviewActionID == 'Select') {
                    showAlert('<%= MyBase.GetResourceString("C_ActionType_Blank") %>', "alert-danger");
                }
                else if (PReviewCauseID == "0") {
                    showAlert('<%= MyBase.GetResourceString("C_ReviewCuase_Blank") %>', "alert-danger");
                }
                else if (Action.trim() == "") {
                    showAlert('<%= MyBase.GetResourceString("C_Action_Blank") %>', "alert-danger");
                }
                //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
                    //Commented and Added by Riddhesh Patil on 12 April 2023
               // else if (checkSpecialCharacter(Description2, WebConfigSpecialCharacters) == true) {
                else if (checkSpecialCharacter(Action.trim(), WebConfigSpecialCharacters) == true) {
                    //End of Commented and Added by Riddhesh Patil on 12 April 2023
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $(this).find('textarea').focus();

                }

                else if (Work.trim() == "") {
                    showAlert('<%= MyBase.GetResourceString("C_Work_Blank") %>', "alert-danger");
                }
                //added by Vishal M 02-01-2019
                else if (IsValidActionHours == false) {
                    showAlert('<%= MyBase.GetResourceString("C_Time_Format") %>', "alert-danger");
                }
                 //Commented and Added By Reshma chavan on 27 Jan 2021 for offline review alert
               <%-- else if (Reviewee == "0") {
                    showAlert('<%= MyBase.GetResourceString("C_Reviewee_Blank") %>', "alert-danger");
                }--%>
                else if (Reviewee == "0" && $('#chkOfflineReviewcr').prop('checked') == false) {
                    showAlert('<%= MyBase.GetResourceString("C_Reviewee_Blank") %>', "alert-danger");
                }
                //End of Commented and Added By Reshma chavan on 27 Jan 2021 for offline review alert
                //Added By Reshma on 31st Dec 2019 For IssueID-21111
                else if (ConvertIssueChecked == true) {
                    if (DefaultType == "") {
                        //Commented and Added by Chetan M on 9th April 2020 for IssueID = 23593
                        //showAlert('<%= MyBase.GetResourceString("A_DefaultTypeMap") %>', "alert-danger");
                        showAlert('No default values selected for issue type at project level', "alert-danger");
                        //End of commented and Added by Chetan M on 9th April 2020 for IssueID = 23593
                    }
                    // Added by Chetan M on 9th April 2020 for IssueID = 23593
                    else if (GblIssueStatus == "" || GblIssueStatus == null || GblIssueSubType == "" || GblIssueSubType == null) {
                        showAlert('<%= MyBase.GetResourceString("C_No_default_issue_status_type_alert")%>', 'alert-danger');
                    }
                    //End of Added by Chetan M on 9th April 2020 for IssueID = 23593
                    else {
                        var reviewactions = {
                            ReviewActionID: encodeURI(ReviewActionID),
                            ProjectID: encodeURI($('#CboProject').val()),
                            ReviewStatisticsID: encodeURI(hiddenReviewStatasticID),
                            PReviewCauseID: encodeURI(PReviewCauseID),
                            Action: encodeURI(replaceAllChar(Action)),
                            Reviewee: encodeURI(replaceAllChar(Reviewee)),
                            CreatedBy: encodeURI(replaceAllChar(UserName)),
                            ConvertTaskChecked: IsConvertToTaskChecked,
                            ConvertIssueChecked: ConvertIssueChecked,
                            WorkInHours: replaceAllChar(Work)
                        };

                        /*Validate work hours */

                        if (GlobalHoursFlag == 1) {
                            var minutes = Work.split(':');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            var d = (dec - 0) / 60 + (p - 0);
                        }

                        if (MinDAENtryDisplay != "") {
                            if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                                showAlert('Please specify the Work(hrs) in multiples of ( ' + MinDAENtryDisplay + ' ) hours.', 'alert-danger');
                                return;
                            }
                            else {
                                SaveAction(reviewactions, currentButton);
                            }
                        }
                        else {
                            SaveAction(reviewactions, currentButton);
                        }

                    }
                }
                //End Added By Reshma on 31st Dec 2019 For IssueID-21111
                else {
                    var reviewactions = {
                        ReviewActionID: encodeURI(ReviewActionID),
                        ProjectID: encodeURI($('#CboProject').val()),
                        ReviewStatisticsID: encodeURI(hiddenReviewStatasticID),
                        PReviewCauseID: encodeURI(PReviewCauseID),
                        Action: encodeURI(replaceAllChar(Action)),
                        Reviewee: encodeURI(replaceAllChar(Reviewee)),
                        CreatedBy: encodeURI(replaceAllChar(UserName)),
                        ConvertTaskChecked: IsConvertToTaskChecked,
                        ConvertIssueChecked: ConvertIssueChecked,
                        WorkInHours: replaceAllChar(Work)
                    };


                    /*Validate work hours */

                    if (GlobalHoursFlag == 1) {
                        var minutes = Work.split(':');
                        var p = minutes[0];
                        var dec = minutes[1];
                        if (dec == undefined) { dec = 0; }
                        var d = (dec - 0) / 60 + (p - 0);
                    }

                    if (MinDAENtryDisplay != "") {
                        if ((((d - 0) / MinDAEntry) - 0).toFixed(0) != ((d - 0) / MinDAEntry)) {
                            showAlert('Please specify the Work(hrs) in multiples of ( ' + MinDAENtryDisplay + ' ) hours.', 'alert-danger');
                            return;
                        }
                        else {
                            SaveAction(reviewactions, currentButton);
                        }
                    }
                    else {
                        SaveAction(reviewactions, currentButton);
                    }

                }

            }
            else if (ReviewType == "Observation") {
                if (Action.trim() == "") {
                    showAlert('<%= MyBase.GetResourceString("C_Action_Blank") %>', "alert-danger");
                }
                else {
                    /*Save Review Observation*/
                    var observations = {
                        ReviewObservationID: encodeURI(ReviewActionID),
                        ProjectID: encodeURI($('#CboProject').val()),
                        ReviewStatisticsID: encodeURI(hiddenReviewStatasticID),
                        Observation: encodeURI(replaceAllChar(Action)),
                        CreatedBy: encodeURI(replaceAllChar(UserName)),
                        TrackToNextReview: IsTrackToNextReview,
                        Closed: IsClosed
                    };

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_Project_Review/SaveReviewObservation',
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        data: JSON.stringify(observations),
                        async: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (observations) {
                                xhr.setRequestHeader("Params", encryptString(isJson(observations) ? observations : JSON.stringify(observations)));
                            }
                        },
                        success: function (result) {
                            $(".add-new").removeAttr("disabled");
                            $(currentButton).parents("tr").find(".add, .edit").toggle();
                            $('[data-bs-toggle="tooltip"]').tooltip('dispose');
                            $('[data-bs-toggle="tooltip"]').tooltip('disable');
                            $("#hdnConvertedActionID").val(result);
                            showAlert('<%= MyBase.GetResourceString("C_ReviewObservation") %>', "alert-success");
                            GetReviewActions(hiddenReviewStatasticID);
                        },
                        error: function (ER) {
                            console.log(ER);
                        }
                    });
                }
            }
            else {
                showAlert('<%= MyBase.GetResourceString("C_ActionType_Blank") %>', "alert-danger");
            }

        });

        /*Save Action*/
        /*
         * Created By   : Chandrashekhar Salagar
         * Date         : 25 Sept 2019
         * Purpose      : Save or update Action
         * **/
        function SaveAction(reviewactions, currentButton) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/SaveReviewAction',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(reviewactions),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviewactions) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviewactions) ? reviewactions : JSON.stringify(reviewactions)));
                    }
                },
                success: function (result) {

                    $(".add-new").removeAttr("disabled");
                    $(currentButton).parents("tr").find(".add, .edit").toggle();
                    $('[data-bs-toggle="tooltip"]').tooltip('dispose');
                    $('[data-bs-toggle="tooltip"]').tooltip('disable');
                    $("#hdnConvertedActionID").val(result);
                    showAlert('<%= MyBase.GetResourceString("C_ReviewActionSave") %>', "alert-success");
                    GetReviewActions(hiddenReviewStatasticID);
                    ConductedReviewCheck(hiddenReviewStatasticID);
                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }

        //Added By Reshma on 31st Dec 2019 For IssueID-21111
        function GetDefaultType() {
            var reviewactions = {
                ProjectID: encodeURI($('#CboProject').val()),
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetDefaultTypeConvertToAction',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(reviewactions),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviewactions) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviewactions) ? reviewactions : JSON.stringify(reviewactions)));
                    }
                },
                success: function (result) {
                    GblDefaultType = result.Type;

                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }
        //End Added By Reshma on 31st Dec 2019 For IssueID-21111

        // Edit row on edit button click
        $(document).on("click", "#conductActiontbl .edit", function () {

            $(".tooltip").tooltip("hide");
            var isOfflineReview = $('#chkOfflineReviewcr').prop('checked');
            var reviewType = "";
            $('#conductActiontbl .edit').prop('disabled', true);
            $('#conductActiontbl .delete').prop('disabled', true);
            $('#conductActiontbl .converttoAction').prop('disabled', true);
            $(this).parents("tr").find(".add, .edit, .ibtnactionCancel").toggle();
            var trElement = $(this).parents("tr");
            cause = $($(this).parents("tr").find("select")[1]).val();
            var CboCause = $(this).parent().next().find('select');
            $(trElement).find('td').each(function (index, value) {
                if (index == 0) {
                    //$(this).find('select').prop('disabled', false);
                    var element = $(this).find('select');
                    reviewType = $(element).val();
                    if (reviewType == "Action") {

                        $(element).val('Action');

                        var project_Review = {
                            ProjectId: encodeURI($('#CboProject').val()),
                            ReviewStatisticsID: hiddenReviewStatasticID
                        };
                        GetCauses(project_Review, CboCause);
                        $(this).parents("tr").find('textarea').prop("disabled", false);
                        $(this).parents("tr").find('.trackToNextReview').prop("disabled", true);
                        $(this).parents("tr").find('.ActionCause,.work, .CboActionReviewee').prop("disabled", false);
                        //$(element).trigger('change');
                    }

                }
                if (index == 1) {
                    if (reviewType == "Action") {
                        $(this).find('select').prop('disabled', false);
                        var Causeddl = $(this).find('select');
                        $(Causeddl).val(cause);
                        var SelectedText = $(Causeddl).text().trim();

                    }

                }
                if (index == 2) {
                    $(this).find('textarea').prop('disabled', false);
                    actionsdescription = $(this).find('textarea').val();
                }
                if (index == 3) {
                    if (reviewType == "Action") {
                        var test = $(this).find('.work');
                        $(this).find('.work').prop('disabled', false);
                        actionswork = $(this).find('.work').val();
                    }
                }
                if (index == 4) {
                    if (reviewType == "Action") {
                        $(this).find('select').prop('disabled', false);
                        actionsreviewee = $(this).find('select').val();
                    }
                }

                if (index == 5) {
                    var thisControl = $(this).find('.chcktbl');
                    if (reviewType == "Action") {
                        var ExistingTaskorIssue = $(thisControl).hasClass('existing');
                        if (isOfflineReview || ExistingTaskorIssue) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        else {
                            $(this).find('.chcktbl').prop('disabled', false);
                        }
                        // By Vishal Mahajan 26-12-2019
                        if (isAgileMethodused) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        // By Vishal Mahajan 26-12-2019
                        actionstask = $(this).find('.chcktbl').prop("checked");
                    }
                }
                if (index == 6) {
                    var thisControl = $(this).find('.chcktbl');
                    var ExistingTaskorIssue = $(thisControl).hasClass('existing');

                    if (reviewType == "Action") {
                        if (isOfflineReview || ExistingTaskorIssue) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        else {
                            $(this).find('.chcktbl').prop('disabled', false);
                        }
                        // By Vishal Mahajan 26-12-2019
                        if (isAgileMethodused) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        // By Vishal Mahajan 26-12-2019
                        actionsissue = $(this).find('.chcktbl').prop("checked");
                    }
                }
                if (index == 7) {
                    var thisControl = $(this).find('.chcktbl');
                    var ConvertedObservation = $(thisControl).hasClass('ConvertedObservation');
                    actionstracktonextreview = $(this).find('.chcktbl').prop("checked");
                    if ((reviewType == "Observation") && actionstracktonextreview) {
                        $(this).find('.chcktbl').prop('disabled', true);
                    } else if (!actionstracktonextreview) {
                        $(this).find('.chcktbl').prop('disabled', false);
                    }
                    else {
                        $(this).find('.chcktbl').prop('disabled', false);
                    }
                }
                if (index == 8) {
                    var thisControl = $(this).find('.chcktbl');
                    var ConvertedObservation = $(thisControl).hasClass('ConvertedObservation');
                    actionsclosed = $(this).find('.chcktbl').prop("checked");
                    if ((reviewType == "Observation") && (actionsclosed)) {
                        $(this).find('.chcktbl').prop('disabled', true);
                    }
                    else {
                        $(this).find('.chcktbl').prop('disabled', false);
                    }
                    if (reviewType == "Observation") {
                        if (actionsclosed) {
                            $(this).prev().find('.chcktbl').prop('disabled', true);
                        }
                    }
                }
            });
            $(".add-new").attr("disabled", "disabled");
        });


        /*
         * Craeted Date :   08 Sept 2019
         * Purpose      :   Type of review changed event
         * Author       :   Chandrashekhar Salagar
         * 
         * **/
        $(document).on('change', '.ActionType', function () {
            var isOfflineReview = $('#chkOfflineReviewcr').prop('checked');
            var trElement = $(this).parents("tr");
            $(trElement).find('td').each(function (index, value) {

                if (index == 0) {
                    //$(this).find('select').prop('disabled', false);
                    var element = $(this).find('select');
                    reviewType = $(element).val();
                }
                if (index == 1) {
                    if (reviewType == "Action") {
                        $(this).find('select').prop('disabled', false);
                    }
                    else {
                        $(this).find('select').prop('disabled', true);
                    }

                }
                if (index == 2) {
                    $(this).find('textarea').prop('disabled', false);
                }
                if (index == 3) {
                    if (reviewType == "Action") {
                        $(this).find('.work').prop('disabled', false);
                    }
                    else {
                        $(this).find('.work').prop('disabled', true);
                    }
                }
                if (index == 4) {
                    $(this).find('select').prop('disabled', false);

                }
                if (index == 5) {
                    var element = $(this).find('.chcktbl');

                    if (reviewType == "Action") {
                        if (isOfflineReview) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        else {
                            $(this).find('.chcktbl').prop('disabled', false);// change the codition by Rutuja D. on 23 dec 2021 true to false bcz that checkbox is always disabled IssueID = 31848
                        }
                    }
                    else {
                        $(this).find('.chcktbl').prop('disabled', true);
                    }

                }
                if (index == 6) {
                    if (reviewType == "Action") {
                        if (isOfflineReview) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        else {
                            $(this).find('.chcktbl').prop('disabled', false); // change the codition by Rutuja D. on 23 dec 2021 true to false bcz that checkbox is always disabled IssueID = 31848
                        }
                    }
                    else {
                        $(this).find('.chcktbl').prop('disabled', true);
                    }
                }
            });
        });



   <%--     /*
         * Created Date :   08 Sept 2019
         * Purpose      :   Delete Action
         * Author       :   Chandrashekhar Salagar
         * **/
        $(document).on("click", "#conductActiontbl .delete", function () {
            
            var ObservationID = 0;
            var trElement = $(this).parents("tr");
            $(trElement).find('td').each(function (index, value) {
                if (index == 0) {
                    ObservationID = $(this).find('input').val();
                }
            });
            isReviewObservationIDExist(ObservationID);
            if (isObservationIDExist) {
                showAlert('<%= MyBase.GetResourceString("C_Observation_Not_Be_Deleted") %>', "alert-danger");
            }
            else {
                var typeOfReview = "";
                var reviewactions;
                //Find ReviewActionId in table 
                $(trElement).find('td').each(function (index, value) {

                    if (index == 0) {
                        ReviewActionID = $(this).find('input').val();
                        typeOfReview = $(this).find('select').val();
                        if (ReviewActionID == undefined) {
                            ReviewActionID = "0";
                        }
                    }
                });
                /*Delete Review Action*/
                if (typeOfReview == "Action") {
                    reviewactions = {
                        ReviewActionID: encodeURI(ReviewActionID),
                        ReviewStatisticsID: encodeURI(hiddenReviewStatasticID),
                        TypeOfReview: typeOfReview
                    };
                }

                if (typeOfReview == "Observation") {
                    reviewactions = {
                        ReviewActionID: encodeURI(ReviewActionID),
                        TypeOfReview: replaceAllChar(typeOfReview)
                    };
                }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_Project_Review/DeleteReviewAction',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(reviewactions),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (reviewactions) {
	                        xhr.setRequestHeader("Params", encryptString(isJson(reviewactions) ? reviewactions : JSON.stringify(reviewactions)));
                        }
                    },
                    success: function (result) {
                        $('[data-bs-toggle="tooltip"]').tooltip('destroy');
                        $(trElement).remove();
                        //$(".add-new").removeAttr("disabled");
                        showAlert('<%= MyBase.GetResourceString("C_ReviewActionDelete") %>', "alert-success");
                        GetReviewActions(hiddenReviewStatasticID);
                    },
                    error: function (ER) {
                        console.log(ER);
                    }
                });
            }

        });--%>

        /*
         * Created Date     :   27 Nov 2019
         * Purpose          :   Cancel Adding Action/Observation
         * Author           :   Chandrashekhar Salagar
         * **/
        $(document).on('click', '.Cancel', function () {
            $('[data-bs-toggle="tooltip"]').tooltip('dispose');
            var trElement = $(this).parents("tr");
            $(trElement).remove();
            $(".add-new").removeAttr("disabled");
            $('#conductActiontbl .converttoAction').prop('disabled', false);
            $('#conductActiontbl .edit').prop('disabled', false);
            $('#conductActiontbl .delete').prop('disabled', false);
        });

    </script>
    <script>
        $('.selectpicker').selectpicker({
            //style: 'btn-info',
            //size: 2
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {

        });
        //$(".cndctdetaillink").click(function () {
        //    $(".conductdetail_panel").show("");
        //    $('html, body, .content').animate({
        //        scrollTop: $(".conductdetail_panel").offset().top -= 200
        //    }, 500);
        //});

        $(".CRbackbtn").click(function () {
            ClearFieldscr();
            //start vishal Mahajan 09-12-2019
            enableDisabledControlsForEdit(true);
            //end vishal Mahajan 09-12-2019
            $(".conductdetail_panel").hide("fast");
            $("#projectplanreviewtbl").DataTable();
            $("#projectcondctreviewtbl").DataTable();
            //Added by Riddhesh Patil for tab Navigation Issue on 12 April 2023
            $(".nav-link").removeClass('active');
            $("#liRevoverview").addClass('active');
            //End of Added by Riddhesh Patil for tab Navigation Issue on 12 April 2023
        });

        /*
         * Created Date     :   22 Sept 2019.
         * Purpose          :   disabling check box if another is checked.(one can convert action into task or issue not both.)
         * Author           :   Chandrashekhar Salagar.
         * **/
        $(document).on('click', '.chcktbl', function () {

            var siblingDiv = "";
            var element = $(this);
            var parentDiv = $(this).closest('td');
            if ($(this).hasClass('TaskCheckBox')) {
                siblingDiv = $(parentDiv).next();
            }
            else if ($(element).hasClass('IssueCheckBox')) {
                siblingDiv = $(parentDiv).prev();
            }

            if ($(element).hasClass('trackToNextReview')) {

                siblingDiv = $(parentDiv).next();
            }
            else if ($(element).hasClass('closed')) {

                siblingDiv = $(parentDiv).prev();
            }

            if ($(element).prop('checked')) {
                $(siblingDiv).find('.chcktbl').prop('disabled', true);
                $(siblingDiv).find('.chcktbl').prop("checked", false);
            }
            else if ($(element).prop('checked') == false) {
                $(siblingDiv).find('.chcktbl').prop('disabled', false);
            }

        });


        //check and uncheck checkbox
        // Check or Uncheck All checkboxes

        //checkall_filter_section
        $(".filterpanelwrap .chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(this).closest(".col-sm-2").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", true);

                });
            } else {
                $(this).closest(".col-sm-2").find("ul .chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox 
        $(".filterpanelwrap .chcktbl").click(function () {
            if ($(this).closest(".col-sm-2").find("ul .chcktbl").length == $(this).closest(".col-sm-2").find(".chcktbl:checked").length) {
                $(this).closest(".col-sm-2").find(".chckHead").prop("checked", true);

            } else {
                $(this).closest(".col-sm-2").find("ul .chckHead").removeAttr("checked");
            }

        });

        //checkall for table

        $("#projectcondctreviewtbl .chckHead, #projectplanreviewtbl .chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $("#projectcondctreviewtbl .chcktbl, #projectplanreviewtbl .chcktbl").each(function () {
                    $(this).prop("checked", true);

                });
            } else {
                $("#projectcondctreviewtbl .chcktbl, #projectplanreviewtbl .chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox 
        $("#projectcondctreviewtbl .chcktbl, #projectplanreviewtbl .chcktbl").click(function () {
            if ($("#projectcondctreviewtbl .chcktbl, #projectplanreviewtbl .chcktbl").length == $("#projectcondctreviewtbl .chcktbl:checked, #projectplanreviewtbl .chcktbl:checked").length) {
                $("#projectcondctreviewtbl .chckHead, #projectplanreviewtbl .chckHead").prop("checked", true);

            } else {
                $("#projectcondctreviewtbl .chckHead, #projectplanreviewtbl .chckHead").removeAttr("checked");
            }

        });

        $('#txtStartDate, #txtEndDate,#txtStartDatecr, #txtEndDatecr').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'

        });

        // START Vishal Mahajan 
        $('#txtPMRWFilterReviewStartDate,#txtPMRWCRFilterReviewStartDate,#txtPMRWFilterActualStartDate,#txtPMRWCRFilterActualStartDate, #txtPMRWFilterReviewEndDate,#txtPMRWCRFilterReviewEndDate,#txtPMRWFilterActualEndDate,#txtPMRWCRFilterActualEndDate').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'

        });
        // END Vishal Mahajan 

        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        //script use for show new review form_Added_Pradip
        $("#btnAddNewReview, .planreview_detail").click(function () {
            $("#projectplanreviewtbl_wrapper").hide();
            $("#ProaddnewreviewPanel").show('slow');
            $('html, body, .content').animate({
                scrollTop: $("#ProaddnewreviewPanel").offset().top -= 100
            }, 500); // modified by pradip on 30-12-2019
        });

        /*for dynamic table for planned review*/
        $(document).on('click', '#btnAddNewReview', function () {
            //$("#projectplanreviewtbl_wrapper").hide();
            $("#ProaddnewreviewPanel").show('slow');
            $('html, body, .content').animate({
                scrollTop: $("#ProaddnewreviewPanel").offset().top -= 100
            }, 500); //modified by pradip on 30-12-2019

            hiddenReviewStatasticID = "";
            ReviewStatisticsid = "";
            //Added By Reshma on 31st dec 2019 For IssueID-21123
            getTotalReviewEfforts(ReviewStatisticsid);
            //End Added By Reshma on 31st dec 2019 For IssueID-21123
            ClearFields();
            //start vishal mahajan 07-12-2019
            OldReviewInvite = false;
            OldStartDate = '';
            OldEndDate = '';
            enableDisabledControlsForEdit(false);
            $('#chkSendReviewInvite').prop('disabled', false);
            $('#chkCancelReviewInvite').prop('checked', false);
            $('#divCancelInvite').css("display", "none");
            $('#divSendInvite').css("display", "block");
            $("#cboReviwee,#cboReviwer").multiselect("enable");
            $("#txtAddReview").prop('disabled', false);
            $("#btnSaveReview").prop('disabled', false);
            $('#cboReviewType,#txtWork,#txtStartDate,#txtEndDate,#txtStartTime,#txtEndTime,#cboTimeZone,#cboWorkProductType,#chkOfflineReview,#chkBillable').prop('disabled', false);
            $('#CboSubproject,#CboPhase,#CboMilestones,#CboModules,#CboDeliverables').prop('disabled', false);
            $('#hdnCancelReviewInvite').val("0");
            FillReviewTypes($("#CboProject").val());
            FillReviwers($("#CboProject").val());
            FillReviwee($("#CboProject").val());
            FillDeliverables($("#CboProject").val());
            FillModules($("#CboProject").val());
            FillSubProjects($("#CboProject").val());
            FillProjectPhases($("#CboProject").val());
            FillMilstones($("#CboProject").val());
            FillProjectCheckList($("#CboProject").val());
            FillIterations($("#CboProject").val());
            //end vishal mahajan 07-12-2019

            $('#txtStartTime, #txtEndTime, #txtStartTimecr, #txtEndTimecr').datetimepicker({

                defaultDate: new Date(),
                // var now = new Date();
                format: 'HH:mm'

            });




        })



        $(document).on('click', '.cndctdetaillink', function () {
            $(".detailsubtabs>li.active").removeClass("active");
            $(".detailsubtabs>li:first").addClass("active");
            $("#Revoverview,#RevActions,#Revchklist,#Revchklistissue,#RevAttachment").removeClass("active");
            $("#Revoverview").addClass("active");
            $(".conductdetail_panel").show("");
            $('html, body, .content').animate({
                scrollTop: $(".conductdetail_panel").offset().top -= 50
            }, 500);
            ClearFieldscr();
            hiddenReviewStatasticID = $(this).find("input[type=hidden]").val();
            ConductedReviewCheck(hiddenReviewStatasticID);
            //GetReviewActions(hiddenReviewStatasticID);
            GetReviewDetailsForEdit(hiddenReviewStatasticID, "ConductedReview");
            GetChecklistIssue(hiddenReviewStatasticID);
            GetDocumentsList(hiddenReviewStatasticID, 2191);
            //CboActionReviewee
            //start vishal Mahajan 09-12-2019
            enableDisabledControlsForEdit(false);
            //end vishal Mahajan 09-12-2019
        });


        /*
         * Created Date     :   23 Oct 2019
         * Purpose          :   Action type change event
         * Author           :   Chandrashekhar Salagar
         * **/
        $(document).on('change', '.ActionType', function () {

            var CboCause = $(this).parent().next().find('select');
            var Text = $(CboCause).text();

            if ($(this).val() == 'Action') {
                var project_Review = {
                    ProjectId: encodeURI($('#CboProject').val()),
                    ReviewStatisticsID: hiddenReviewStatasticID
                };
                GetCauses(project_Review, CboCause);
                $(CboCause).find('option').each(function (i, v) {
                    var testText = $(this).text();

                    if ($(this).text() == Text.trim()) {
                        $(this).attr('selected', 'selected');
                    }
                });
                $(this).parent().closest('tr').find('textarea').prop("disabled", false);
                $(this).parent().closest('tr').find('.trackToNextReview').prop("disabled", true);
                $(this).parent().closest('tr').find('.ActionCause,.work, .CboActionReviewee').prop("disabled", false);
            } else {
                $(this).parent().closest('tr').find('textarea').prop("disable", false);
                $(this).parent().closest('tr').find('.trackToNextReview').prop("disabled", false);
                $(this).parent().closest('tr').find('.ActionCause,.work,.CboActionReviewee').prop('disabled', true);
                $(this).parent().closest('tr').find('.CboActionReviewee').prop('disabled', true);
            }
            $(this).parent().closest('tr').find('.ActionCause').val('0');
            $(this).parent().closest('tr').find('textarea').val('');
            $(this).parent().closest('tr').find('.work').val('');
            $(this).parent().closest('tr').find('.CboActionReviewee').val('0');
            $(this).parent().closest('tr').find('.TaskCheckBox,.IssueCheckBox,.trackToNextReview').prop("checked", false);
            $(this).parent().closest('tr').find('.CboActionReviewee').prop("checked", false);
        });

        /**
         * Craeted Date :   25 Sept 2019
         * Purpose      :   Get Project Causes
         * @param project_Review
         */
        function GetCauses(project_Review, CboCause) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetReviewCauses',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $(CboCause).html("");
                    $(CboCause).prepend("<option value='0' selected='selected'>Select Cause</option>").val();
                    $.each(result, function () {
                        // Commented And Added By Rutuja D for Binding Clause Data Correct IssueID = 21077 & 21064
                        //$(CboCause).append($("<option></option>").val(this['PReviewCauseID']).html(this['CReviewCause']));
                        $(CboCause).append($("<option></option>").val(this['PReviewCauseID']).html(this['PReviewCause']));
                        //End Added By Rutuja D for Binding Clause Data Correct IssueID = 21077 & 21064

                    })
                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }

        /**
         * Created Date :   29 Oct 2019
         * Purpose      :   Get review action
         * Author       :   Chandrashekhar Salagar
         * @param ReviewID
         */
        function GetReviewActions(ReviewID) {
            var project_Review = {
                ReviewStatisticsID: encodeURI(ReviewID)
            };
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetReviewActions',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(project_Review),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {
                    $("#conductActiontbl .add-new").attr("disabled", false);
                    $('#tbodyActions').html('');
                    var Body = "";
                    for (var i = 0; i < result.length; i++) {
                        var editHtml = m_EditAccess == "True" ? '<button class="edit_SH_Detail nostylebtn edit" href="javascript:;" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Edit"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px"/></button>' : '<button class="edit_SH_Detail nostylebtn" href="javascript:;" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Edit"  disabled="disabled"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" title="You Dont have access to Edit" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"/></button>'
                        if (result[i].TypeOfReview == 'Action') {
                            var IsConvertedToTask = "";
                            var IsConvertedToIssue = "";
                            var TaskDisplay = "";
                            var IssueDisplay = "";
                            var IsExited = "";
                            if (result[i].TaskID != "") {
                                IsConvertedToTask = "checked";
                                IssueDisplay = "display:none"
                                IsExited = "existing"
                            }
                            else if (result[i].IssueID != "") {
                                IsConvertedToIssue = "checked";
                                TaskDisplay = "display:none";
                                IsExited = "existing";
                            }
                            var actionTask = '', actionIssue = '';
                            actionTask = '<div class="custom_chckbox " style=' + TaskDisplay + '> ' + '<input id="convert' + i + '" type="checkbox" class="TaskCheckBox chcktbl ' + IsExited + '" disabled="true" ' + IsConvertedToTask + '> ' + '<label for="convert' + i + '"></label> </div> ';
                            actionIssue = '<div class="custom_chckbox" style=' + IssueDisplay + '>  ' + '<input id="ACI' + i + '" type="checkbox" class="IssueCheckBox chcktbl ' + IsExited + '" disabled="true" ' + IsConvertedToIssue + '>  ' + '<label for="ACI' + i + '"></label>  </div> ';
                            if (result[i].IssueID != "" || result[i].TaskID != "") {
                                actionTask = '';
                                actionIssue = '';
                            }
                            if (result[i].TaskID != "") {
                                actionTask = "<span data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Task ID'>" + result[i].TaskID + "</span>";
                            }
                            if (result[i].IssueID != "") {
                                actionIssue = "<span data-bs-toggle='tooltip' data-bs-placement='top' title='' data-original-title='Issue ID'>" + result[i].IssueID + "</span>";
                            }
                            if (isAgileMethodused == 1) {
                                actionTask = 'NA';
                                actionIssue = 'NA';
                            }
                            var isDeleted = IsConvertedToTask == "" ? (IsConvertedToIssue == "" ? true : false) : false;
                            //by Vishal Mahajan 28-12-2019
                            var deleteHtml = isDeleted ? (m_DeleteAccess == "True" ? "<button class='nostylebtn delete' data-bs-toggle='modal' name='" + result[i].TypeOfReview + "' onclick='SetDeleteAction(" + result[i].ReviewActionID + ",this);'> <i class='far fa-trash-alt' title='' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Delete'></i></button>" : '<button class="nostylebtn delete" data-bs-toggle="modal" disabled="disabled"> <i class="far fa-trash-alt"  title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"></i></button>') : "";

                            Body = Body + '      <tr>  ' +
                                '                                               <td>  ' +
                                '                                                   <select class="form-select ActionType" id="CboActionType" disabled="true">  ' +
                                '                                                       <option value="Select">Select Action</option>  ' +
                                '                                                       <option value="Action" selected="selected">Action</option>  ' +
                                '                                                       <option value="Observation">Observation</option>  ' +
                                '                                                   </select> <input type="hidden" value=' + result[i].ReviewActionID + '></input> ' +
                                '                                               </td>  ' +
                                '                                               <td>  ' +
                                '                                                   <select class="form-select " id="CboCauses" disabled="true">  ' +
                                //Commented And Added By Rutuja D. For IssueID = 21074
                                //'                                                       <option value=' + result[i].PReviewCauseID + '>' + result[i].CReviewCause + '</option>  ' +
                                '                                                          <option value=' + result[i].PReviewCauseID + '>' + result[i].PReviewCause + '</option>  ' +
                                //End Added By Rutuja D. For IssueId = 21074  ' +
                                '                                                   </select>  ' +
                                '                                               </td>  ' +
                                '                                               <td>  ' +
                                '                                                   <textarea class="form-control" placeholder="Description"  maxlength="1000" disabled="true">' + result[i].Action + '</textarea>  ' +
                                '                                               </td>  ' +
                                '                                                 <td><input type="text" class="form-control work"  maxlength="7"  disabled="true" value=' + result[i].WorkInHours + ' ></td>     ' +
                                '                                               <td>  ' +
                                '                                                   <select class="form-select CboActionReviewee" disabled="true">  ' +
                                '                                                        <option>ABC 1</option>  ' +
                                '                                                   </select>  ' +
                                '                                               </td>  ' +
                                '                                               <td>  ' + actionTask +
                                '                                               </td>  ' +
                                '                                               <td>  ' + actionIssue +
                                '                                               </td><td></td><td></td>  ' +
                                '                                               <td class="actioncolumn" style="width: 14%;" > <button id="convertToAction" class="reviewcancellationlink converttoAction" href="javascript:;" style="display:none" >Convert to action</button> ' +
                                '                                                   <a href="javascript:;" class="add" title="" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save">  ' +
                                '                                                       <img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">  ' +
                                '                                                   </a>  ' +
                                //'                                                   <button class="edit_SH_Detail nostylebtn edit" href="javascript:;" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Edit">  ' +
                                //'                                                       <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px">  ' +
                                //'                                                   </button>'
                                editHtml + deleteHtml +
                                '<button style="display: none;" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Cancel" class="ibtnactionCancel nostylebtn" name="1033"><i class="fa fa-times" value="Delete"></i></button>' +
                                '                                               </td>  ' +
                                '                                          </tr>  ';
                        }
                        else if (result[i].TypeOfReview == 'Observation') {

                            var ID = result[i].ConvertedActionID;
                            var Converted = "";
                            var convertToActionLink = "";
                            var isClosed = "";
                            var isTrackToNextReview = "";
                            if (result[i].ConvertedActionID == "") {
                                convertToActionLink = '<button id="" class="reviewcancellationlink converttoAction" style="background: none;border: none;" href="javascript:;"  >Convert to action</button> ';
                            }
                            else {
                                convertToActionLink = '<h8>N/A</h8>';
                                Converted = "ConvertedObservation";

                            }
                            /*Check if observations is closed*/
                            if (result[i].Closed == "True") {
                                isClosed = "checked";
                            }
                            else if (result[i].TrackToNextReview == "True") {
                                isTrackToNextReview = "checked";

                            }
                            //by Vishal Mahajan 28-12-2019
                            var deleteHtml = m_DeleteAccess == "True" ? "<button class='nostylebtn delete' data-bs-toggle='modal' name='" + result[i].TypeOfReview + "' onclick='SetDeleteAction(" + result[i].ReviewActionID + ",this);'> <i class='far fa-trash-alt' title='' data-bs-toggle='tooltip' data-bs-placement='top' data-bs-container='body' data-original-title='Delete'></i></button>" : '<button class="nostylebtn" data-bs-toggle="modal" disabled="disabled"> <i class="far fa-trash-alt"  title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" ></i></button>';

                            Body = Body + '      <tr>  ' +
                                '                                               <td>  ' +
                                '                                                   <select class="form-select ActionType" id="CboActionType" disabled="true">  ' +
                                '                                                       <option value="Select">Select Action Type</option>  ' +
                                '                                                       <option value="Action" >Action</option>  ' +
                                '                                                       <option value="Observation" selected="selected">Observation</option>  ' +
                                '                                                   </select> <input type="hidden" value=' + result[i].ReviewActionID + '></input> ' +
                                '                                               </td>  ' +
                                '                                               <td>  ' +
                                '                                                   <select class="form-select" id="CboCauses" disabled="true">  ' +
                                '                                                       <option>' + result[i].CReviewCause + '</option>  ' +
                                '                                                   </select>  ' +
                                '                                               </td>  ' +
                                '                                               <td>  ' +
                                '                                                   <textarea class="form-control" maxlength="1000" placeholder="Description" disabled="true">' + result[i].Action + '</textarea>  ' +
                                '                                               </td>  ' +
                                '                                                 <td><input type="text"  maxlength="7" class="form-control work" disabled="true"></td>     ' +
                                '                                               <td>  ' +
                                '                                                   <select class="form-select CboActionReviewee" disabled="true">  ' +
                                '                                                        <option>' + result[i].review + '</option>  ' +
                                '                                                   </select>  ' +
                                '                                               </td>  ' +
                                '                                               <td>NA</td>  ' +
                                '                                               <td>NA</td> ' +
                                '                                               <td>  ' +
                                '                                                   <div class="custom_chckbox">  ' +
                                '                                                       <input id="chkTrackToNextReview' + i + '" type="checkbox" class="trackToNextReview chcktbl ' + Converted + '" disabled="true" ' + isTrackToNextReview + '>  ' +
                                '                                                       <label for="chkTrackToNextReview' + i + '"></label>  ' +
                                '                                                   </div>  ' +
                                '                                               </td>  ' +
                                '                                               <td>  ' +
                                '                                                   <div class="custom_chckbox" >  ' +
                                '                                                       <input id="chkClosed' + i + '" type="checkbox" class="closed chcktbl ' + Converted + '" disabled="true" ' + isClosed + '>  ' +
                                '                                                       <label for="chkClosed' + i + '"></label>  ' +
                                '                                                   </div>  ' +
                                '                                               </td> ' +
                                '                                               <td class="actioncolumn" style="width: 14%;" > ' + convertToActionLink +
                                '<input type="hidden" value=' + result[i].ReviewActionID + ' />  ' +
                                '<span style="display: none;">' + result[i].Action + '</span> ' +
                                '                                                   <a href="javascript:;" class="add" title="" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save">  ' +
                                '                                                       <img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">  ' +
                                '                                                   </a>  ' +
                                //'                                                   <button class="edit_SH_Detail nostylebtn edit" href="javascript:;" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Edit">  ' +
                                //'                                                       <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px">  ' +
                                //'                                                   </button><button class="nostylebtn delete" data-bs-toggle="modal" data-bs-target="#deleteinfomodal"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Delete"></i></button>  ' +
                                //'<button style="display: none;" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" data-original-title="Cancel" class="ibtnactionCancel nostylebtn" name="1033"><i class="fa fa-times" value="Delete"></i></button>' +
                                editHtml + deleteHtml +
                                '<button style="display: none;" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Cancel" class="ibtnactionCancel nostylebtn" name="1033"><i class="fa fa-times" value="Delete"></i></button>' +
                                '                                               </td>  ' +
                                '                                          </tr>  ';
                        }

                    }
                    $('#tbodyActions').append(Body);
                    $("i,img,span").tooltip({
                        placement: 'top'
                    });
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    var element = $("#cboReviweecr");

                    $(".CboActionReviewee").html("");
                    $(".CboActionReviewee").prepend("<option value='0' selected='selected'>Select Reviewee</option>").val();
                    $("#cboReviweecr option").each(function (i, val) {

                        var property = $(this).prop('selected');
                        if ($(this).prop('selected')) {
                            var thisText = $(this).text();
                            var actualValue = $(this).val();

                            $(".CboActionReviewee").append($("<option></option>").val(actualValue).html(thisText));
                        }
                    });


                    /*Bind all reviewees for all actions*/
                    $(".CboActionReviewee").each(function (i, val) {
                        $(this).val(result[i].Reviewee);
                    });
                    /*SetTooltips();*/

                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }


        function SetTooltips() {
            $('.task').each(function () {

                var value = $(this).hasClass('existing');
                if ($(this).hasClass('existing')) {
                    $(this).attr('title', 'This is the hover-over text');

                }
                else {
                    $(this).attr('title', '');
                }
            });
            $('.issue').each(function () {
                if ($(this).hasClass('existing')) {
                    $(this).attr('title', 'This is the hover-over text');

                }
                else {
                    $(this).attr('title', 'This is the hover-over text');
                }
            });
        }


        /*For dynamic generated control*/
        $(document).on('click', '.cndctdetaillink', function () {
            $(".conductdetail_panel").show("");
            $('html, body, .content').animate({
                scrollTop: $(".conductdetail_panel").offset().top -= 50
            }, 500);

        })

        $(".CRbackbtn").click(function () {
            $(".conductdetail_panel").hide("fast");
            $("#projectplanreviewtbl").DataTable();
            $("#projectcondctreviewtbl").DataTable();
        })

        $("#ProaddnewreviewPanel .righttopheading .canclebtn").click(function () {
            ClearFields();
            $("#ProaddnewreviewPanel").hide('slow');
            $("#projectplanreviewtbl_wrapper").show();
            //start vishal Mahajan 09-12-2019
            enableDisabledControlsForEdit(true);
            //end vishal Mahajan 09-12-2019
        });
        //Proaddnewreviewbtn

        //auto search for corporate roles
        $("#searchCR").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#CRTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });

        //delete row    
        $('.removerow').click(function () {
            $(this).closest('tr').hide();
        });

        //Start Script for edit basic filter
        $(".edit_filter").click(function () {
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
        });
        //Start Script for edit basic filter

        $(".wbsclearalllink").click(function () {
            $(".filter").removeClass("active");
            $('.filterpanel').collapse('toggle');
        });
        // START Vishal Mahajan 19-11-2019
        //check project is selected or not
        function CheckProjectIsSelect() {
            if ($("#CboProject :selected").val() == "" || $("#CboProject :selected").val() == "" || $("#CboProject :selected").val() == "0") {
                showAlert('<%= MyBase.GetResourceString("C_PleaseSelectProject") %>', 'alert-danger');
                return false;
            }
            else {
                return true;
            }
        }
        // END Vishal Mahajan 19-11-2019

        // START Vishal Mahajan 02-12-2019
        //Filter code logic 
        //To check is default filter is applied for user 
        function PMProjectReviewDefaultFilter() {
            var TagID = 2191;

            var PMProjectReviewFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                TagID: encodeURI(TagID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                IsPlannedReview: true
            }
            StartLoader("#bodyPMProjectReview");
            $.ajax({
                url: strUrl + '/api/PM_Project_Review/CheckPMProjectReviewDefaultFilter',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {

                    var FilterID = result.FilterID;
                    var QueryText = result.QueryText;
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                    }
                    GlobalApplyID = "Apply" + FilterID;
                    GetAllReviews(QueryText);
                    if (FilterID != 0) {
                        $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                    } else {
                        $("#btnAdvFilter").css({ "background": "NONE", "color": "#464a4c" });
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview")
        }
        var SPFilterAllFields = ["PReviewTypeID", "ReviewedBy", "ReviewNotes", "Reviewee", "ModuleID", "DeliverableID", "ReviewTitle", "ReviewStartDate", "ReviewEndDate", "ActualStartDate", "ActualEndDate", "IsOfflineReview", "IsReviewBillable", "IsSendReviewInvite", "IterationID", "MilestoneID", "PhaseID", "StartTime", "SubProjectID"];
        var module = "PMRW";

        //Onclick of PMProjectReview Apply button 
        function PMProjectReviewbtnApplyFilter() {

            var strQuery = "";
            strQuery = GenerateBasicFilterQuery(module, SPFilterAllFields);
            if (strQuery == "") {
                showAlert("Please select at least one filter option.", 'alert-danger');
            }
            else {
                GetAllReviews(strQuery);
                //Added By Reshma Chavan on 4th Jan 2021 not getting Alert after Applying Filter
                showAlert("Filter Applied Successfully", 'alert-success');
                //End of Added By Reshma Chavan on 4th Jan 2021 not getting Alert after Applying Fil
                $("#PMProjectReviewClearAllFilter").show();
                $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                $(".filterpanelplnReview").removeClass("show");
                $("#presetfilterML").removeClass("show");
                $(".filterpanelheader li a").removeClass("active");
            }
            return strQuery;
        }

        //reset edit filters
        function ResetEditFilterID() {

            if ($("#basicfilterli").hasClass("active")) {

            } else {
                Flag = 0;
                FilterID = 0;
            }
        }


        //Save and apply filter
        function btnPMProjectReviewSaveAndApplyFilter_Onclick() {
            if (CheckProjectIsSelect()) {
                var TagID = 2191;
                var strQuery = GenerateBasicFilterQuery(module, SPFilterAllFields);
                if (strQuery.length > 0) {
                    $("#Issuesavefilter").modal("show");
                } else {
                    showAlert('<%= MyBase.GetResourceString("C_Filter_PleaseSelectAtleastoneFilter") %>', 'alert-danger');
                }
            }
        }

        //savePMProjectReview filter
        function SavePMProjectReviewFilter() {
            if (CheckProjectIsSelect()) {
                var FilterName = replaceAllChar($("#txtFilterName").val().trim());
                var strQuery = GenerateBasicFilterQuery(module, SPFilterAllFields);
                var fltFilterName = $("#txtFilterName").val();
                if (strQuery == "") {
                    showAlert('<%= MyBase.GetResourceString("C_Filter_PleaseSelectAtleastoneFilter") %>', 'alert-danger');
                }
                //Added By Rehan on 07/11/2022 To check validation for Special characters  on 07/11/2022
                else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                    $("#btnSaveBasicFilter").removeAttr("data-bs-dismiss");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Filter Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $(ControlValidationFieldID[i]).focus()
                    $("#txtFilterName").focus();
                }
                else if (FilterName.trim() != '') {
                    var IsFilterNameExists = "0";
                    var PMProjectReviewFilterParameter = {
                        TagID: encodeURI(2191),
                        IsPlannedReview: true,
                        ProjectID: encodeURI($("#CboProject :selected").val()),
                        UserID: encodeURI(UserID),
                        FilterName: encodeURI(replaceAllChar(FilterName)),
                        LoginType: encodeURI(LoginType),
                        QueryText: encodeURI(strQuery),
                        CreatedBy: encodeURI(UserName),
                        Flag: encodeURI(Flag),
                        FilterID: encodeURI(FilterID)
                    }
                    StartLoader("#bodyPMProjectReview");
                    //Check fileter name duplicate 
                    $.ajax({
                        url: strUrl + '/api/PM_Project_Review/IsDuplicatePMProjectReviewBasicFilter',// Path
                        type: "POST",                                       //HTTP TYPE get /post
                        data: JSON.stringify(PMProjectReviewFilterParameter),       // Parameters
                        dataType: "json",                                   //Retrun Type 
                        contentType: "application/json; charset=utf-8",     //
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (PMProjectReviewFilterParameter) {
                                xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                            }
                        },
                        async: false,
                        success: function (result) {
                            if (!result) {
                                $.ajax({
                                    url: encodeURI(strUrl) + '/api/PM_Project_Review/SavePMProjectReviewBasicFilter',
                                    method: 'Post',
                                    data: JSON.stringify(PMProjectReviewFilterParameter),
                                    dataType: 'json',
                                    async: false,
                                    contentType: "application/json",
                                    beforeSend: function (xhr) {
                                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                        if (PMProjectReviewFilterParameter) {
                                            xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                                        }
                                    },
                                    success: function (result) {

                                        if (result != "") {
                                            $("#Issuesavefilter").modal("hide");
                                            GlobalApplyID = "Apply" + result;
                                            PMProjectReviewGetMyFiltersList();
                                            PMProjectReviewApplyCheckFilter(GlobalApplyID);
                                            //Commented And Added By Reshma on 26th Dec 2019 For IssueID-21134
                                            //showAlert("Filter applied Sucessfully", 'alert-success');
                                            showAlert("Filter Applied Successfully", 'alert-success');
                                            //End Added By Reshma on 26th Dec 2019 For IssueID-21134
                                            $("#presetfilterML").removeClass("active");
                                        }
                                        $('[data-bs-toggle="tooltip"]').tooltip();// Added by pradip on 30-12-2019
                                    },
                                    error: function (err) {
                                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                    }
                                })
                            }
                            else {
                                showAlert('<%= MyBase.GetResourceString("C_Advance_Filter_Already_Exists") %>', 'alert-danger');
                                IsFilterNameExists = "1";
                                return;
                            }

                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                    StopAjaxLoader("#bodyPMProjectReview");
                    if (IsFilterNameExists == "0") {
                        clearBasicFilters();
                    }
                }

                else {
                    showAlert("Please enter filter name.", 'alert-danger');
                }
            }
        }

        //open basic filter tab
        function OpenBasicFilter() {
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
        }

        //Function for get the list of PMProjectReview filters on My filter dropdown
        function PMProjectReviewGetMyFiltersList() {
            var SetID = selectedqid;
            var projectID = ProjectID;
            if (projectID == '0' || projectID == '') {
                projectID = -1;
            }
            clearBasicFilters();
            var PMProjectReviewFilterParameter = {
                TagID: encodeURI(2191),
                IsPlannedReview: 1,
                ProjectID: encodeURI(projectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetMyPMProjectReviewFiltersList',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {
                    var strHTML = "";
                    $("#PMProjectReviewMyFiltersdropdown").empty();
                    for (var i = 0; i < result.length; i++) {

                        strHTML += '<li id="li' + result[i].FilterId + '">'

                        if (result[i].SetDefault == true) {
                            GlobalApplyID = 'Apply' + result[i].FilterId;

                            strHTML += '<label class="customradio">'
                            strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + result[i].FilterId + '" type="checkbox" name="' + result[i].FilterId + '" onchange="PMProjectReviewRemoveDefaultFilter(this.id)" checked="checked">'
                            strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Remove Default filter" class="checkmark"></span>'
                            strHTML += '</label>'
                            strHTML += '<label class="">'
                            strHTML += '<span for="project2" class="radiotextsty filtername">' + result[i].FilterName + '</span>'
                            strHTML += '</label>'
                            strHTML += '<div class="issfilter_actiondropdown">'
                            strHTML += '<div class="custom_chckbox_markblue">'
                            //Commented and Added by Riddhesh Patil on 10th April 2023
                             //strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" checked="" type="radio" name="abc">'
                            //strHTML += '<label data-bs-toggle="tooltip" data-original-title="Apply filter" data-bs-container="body" data-bs-placement="bottom" title="Default filter" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewApplyCheckFilter(this.id)"></label>'
                            if (result[i].FilterId == SetID) {
                                strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" type="radio" name="">'
                                //strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Applied filter" for="IssueselproOne" id="Applied' + result[i].FilterId + '" onclick="ClearAll()" class="filterid"></label>'
                                strHTML += '<label data-bs-toggle="tooltip" title="Applied filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="ClearAll()" ></label>'
                            }
                            else {
                                strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" type="radio" name="">'
                                strHTML += '<label data-bs-toggle="tooltip" title="Apply filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewApplyCheckFilter(this.id)"></label>'
                            }
                            //End of Commented and Added by Riddhesh Patil on 10th April 2023
                            //strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" checked="" type="radio" name="abc">'
                            //strHTML += '<label data-bs-toggle="tooltip" data-original-title="Apply filter" data-bs-container="body" data-bs-placement="bottom" title="Default filter" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewApplyCheckFilter(this.id)"></label>'
                            strHTML += '</div>'
                            strHTML += '<span onclick="OpenBasicFilter()"><i  data-original-title="Edit filter"  data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt edit_filter" id="' + result[i].FilterId + '" onclick="PMProjectReviewEditMyFilter(this.id);"></i></span>'
                            strHTML += '<span><i data-bs-toggle="tooltip" data-original-title="Delete filter" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="Default' + result[i].FilterId + '" onclick="PMProjectReviewDeleteMyFilter(this.id)"></i></span>'
                            strHTML += '</div>'
                            strHTML += '</li>'
                        }
                        else {
                            strHTML += '<label class="customradio">'
                            strHTML += '<input class="myfilter_selectprocheckbox" data-original-title="Set Default filter" data-bs-toggle="tooltip" data-bs-placement="bottom" id="' + result[i].FilterId + '" type="radio" name="project2" onchange="PMProjectReviewSetDefaultFilter(this.id)">'
                            strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>'
                            strHTML += '</label>'
                            strHTML += '<label class="">'
                            strHTML += '<span for="project2" class="radiotextsty filtername">' + result[i].FilterName + '</span>'
                            strHTML += '</label>'
                            strHTML += '<div class="issfilter_actiondropdown">'
                            strHTML += '<div class="custom_chckbox_markblue">'
                            //Commented and Added by Riddhesh Patil on 10th April 2023
                            //strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" type="radio" name="">'
                            //strHTML += '<label data-bs-toggle="tooltip" data-original-title="Apply filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewApplyCheckFilter(this.id)"></label>'
                            if (result[i].FilterId == SetID) {
                                strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" type="radio" name="">'
                                //strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Applied filter" for="IssueselproOne" id="Applied' + result[i].FilterId + '" onclick="ClearAll()" class="filterid"></label>'
                                strHTML += '<label data-bs-toggle="tooltip" title="Applied filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="ClearAll()" ></label>'
                            }
                            else {
                                strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" type="radio" name="">'
                                strHTML += '<label data-bs-toggle="tooltip" title="Apply filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewApplyCheckFilter(this.id)"></label>'
                            }
                            //End of Commented and Added by Riddhesh Patil on 10th April 2023
                            strHTML += '</div>'
                            strHTML += '<span onclick="OpenBasicFilter()"><i data-bs-toggle="tooltip" data-original-title="Edit filter" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt edit_filter" id="' + result[i].FilterId + '" onclick="PMProjectReviewEditMyFilter(this.id);"></i></span>'
                            strHTML += '<span><i data-bs-toggle="tooltip" data-original-title="Delete filter" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="' + result[i].FilterId + '" onclick="PMProjectReviewDeleteMyFilter(this.id)"></i></span>'
                            strHTML += '</div>'
                            strHTML += '</li>'
                        }
                    }
                    $("#PMProjectReviewMyFiltersdropdown").append(strHTML);

                    if (GlobalApplyID != null) {
                        PMProjectReviewApplyCheckFilter(GlobalApplyID);
                    }
                    else {
                        ClearFilterApplied();
                    }
                    $('[data-bs-toggle="tooltip"]').tooltip();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        //Added by Riddhesh Patil on 10th April 2023
        function ClearAll() {
            selectedqid = "";
            GetAllReviews(null)
        }
        //Added by Riddhesh Patil on 10th April 2023
        //Delete Saved PMProjectReview filter
        function PMProjectReviewDeleteMyFilter(FilterID) {
            $(".tooltip").tooltip("hide");
            if (FilterID.indexOf('Default') > -1) {
                var FilterID = FilterID.replace("Default", "");
                PMProjectReviewDeleteFilter(FilterID);
                GetAllReviews(null);
                PMProjectReviewGetMyFiltersList();
                $("#btnAdvFilter").css({ "background": "NONE", "color": "#464a4c" });
                clearBasicFilters();
            }
            else {
                PMProjectReviewDeleteFilter(FilterID);
                PMProjectReviewDefaultFilter();
                //PMProjectReviewCheckDefaultFilter(2191);
                PMProjectReviewGetMyFiltersList();
                clearBasicFilters();
            }
        }


        //Delete PMProjectReview Filter
        function PMProjectReviewDeleteFilter(FilterID) {
            StartLoader("#bodyPMProjectReview");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/DeletePMProjectReviewFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        showAlert("Filter is deleted successfully.", 'alert-success');
                        PMProjectReviewGetMyFiltersList();
                    }
                }, error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview")
        }


        //Apply saved PMProjectReview filter
        function PMProjectReviewApplySavedFilter(FilterID) {
            StartLoader("#bodyPMProjectReview");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetPMProjectReviewWhereClauseOfFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    var Querytext = result;
                    var FilterID = result.FilterID;
                    var QueryText = result.QueryText;
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                    }
                    GetAllReviews(Querytext);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview")
        }

        //To set the default filter of PMProjectReview.
        function PMProjectReviewSetDefaultFilter(FilterID) {

            var PMProjectReviewFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                TagID: encodeURI(2191),
                IsPlannedReview: true,
                FilterID: encodeURI(FilterID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/SetPMProjectReviewDefaultFilter',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {
                    //Added & Commented By Dipali V On 17th Feb 2022 For alert changed
                    //showAlert("Default filter is set.", 'alert-success');
                    showAlert("Default Filter Set Successfully", 'alert-success');
                    //End of Added & Commented By Dipali V On 17th Feb 2022 For alert changed
                    FilterID = "Apply" + FilterID;
                    PMProjectReviewGetMyFiltersList();
                    PMProjectReviewApplyCheckFilter(FilterID);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        //To remove the default filter of PMProjectReview.
        function PMProjectReviewRemoveDefaultFilter(FilterID) {
            StartLoader("#bodyPMProjectReview");
            FilterID = FilterID.replace("Default", "");
            var PMProjectReviewFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                TagID: encodeURI(2191),
                IsPlannedReview: true,
                FilterID: encodeURI(FilterID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/RemovePMProjectReviewDefaultFilter',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {
                   
                     //Added & Commented By Dipali V On 17th Feb 2022 For alert changed
                    showAlert("Default Filter Removed Successfully", "alert-success");
                    // showAlert("Default filter is removed.", 'alert-success');
                    //End of Added & Commented By Dipali V On 17th Feb 2022 For alert changed
                    GetAllReviews(null);
                    PMProjectReviewGetMyFiltersList();
                    $("#btnAdvFilter").css({ "background": "NONE", "color": "#464a4c" });
                    clearBasicFilters();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview")
        }

        //CLEAR BASIC FILTERS
        function ClearBasicFilter(IdCaption) {
            $("[id*=cbo" + IdCaption + "Filter]").each(function (obj) {
                var cbo = this.id;
                $("#" + cbo + " option:first").prop('selected', 'selected');
            });

            $("[id*=txt" + IdCaption + "Filter]").each(function (obj) {
                var txt = this.id;
                $("#" + txt).val('').change();
            });
        }

        //bind basic filters
        function BindBasicFilters(qtext, module) {
            clearBasicFilters();
            //ClearBasicFilter(module);
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
            //$("#txtPMRWFilterReviewedBy").multiselect("refresh");
            //$("#txtPMRWFilterReviewee").multiselect("refresh");
            //$("#txtPMRWCRFilterReviewedBy").multiselect("refresh");
            //$("#txtPMRWCRFilterReviewee").multiselect("refresh");
        }

        //bind basicfilter values
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


        //To Edit saved PMProjectReview filter
        function PMProjectReviewEditMyFilter(FilterId) {

            Flag = 1;
            clearBasicFiltersforEdit();
            FilterID = FilterId;
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/EditPMProjectReviewFilterData',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {

                    BindBasicFilters(result[0].WhereClause, module);
                    $("#txtFilterName").val(result[0].FilterName);
                    FilterID = FilterId;
                    GlobalFilterName = result[0].FilterName;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        // Getting QueryText From Perticular FilterID
        function PMProjectReviewApplyCheckFilter(ApplyID) {
            $("#" + ApplyID).attr("data-original-title");
            if ($("#" + ApplyID).attr("data-original-title") == "Applied filter" || $("#" + ApplyID).attr("data-original-title") == "Default filter") {
                var sibling = $('#PMProjectReviewMyFiltersdropdown label[id^="Apply"]')
                $(sibling).each(function () {
                    var id = this.id;
                    if (ApplyID == this.id) {
                        $(this).parent().find("input").prop("checked", true);
                    }
                });
                return;
            }
            var FilterID = ApplyID.replace("Apply", "");
            if (FilterID != undefined) {
                PMProjectReviewFilterParameter = {
                    FilterID: encodeURI(FilterID),
                    IsPlannedReview: true
                }
                $.ajax({
                    url: strUrl + '/api/PM_Project_Review/GetWhereClauseFilter',
                    type: "POST",
                    data: JSON.stringify(PMProjectReviewFilterParameter),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMProjectReviewFilterParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                        }
                    },
                    success: function (result) {
                        $(FilterID).attr("checked");
                        //Added by Riddhesh Patil on 10th April 2023
                        selectedqid = FilterID;
                        //End of Added by Riddhesh Patil on 10th April 2023
                        var QueryText = result;
                        if (QueryText != null) {
                            QueryText = QueryText.toString().replace(/'/g, "''");
                        }

                        var sibling = $('#PMProjectReviewMyFiltersdropdown label[id^="Apply"]')

                        $(sibling).each(function () {
                            var id = this.id;
                            if (ApplyID == this.id) {
                                $(this).parent().find("input").prop("checked", true);
                                $(this).attr("data-original-title", "Applied filter");
                            }
                            else {
                                $(this).parent().find("input").prop("checked", false);
                                $(this).attr("data-original-title", "Apply filter");
                            }
                        });
                        GetAllReviews(QueryText);
                        $("#PMProjectReviewClearAllFilter").show();
                        $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                        GlobalApplyID = "Apply" + FilterID;
                        $('#presetfilterML').removeClass("active");
                        $('.filterpanelplnReview .cust_tabpanel li').removeClass("active");
                        $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
        }

        //To clear the applied filter arrow after click on clear filter button
        function ClearFilterApplied() {
            var sibling = $('#PMProjectReviewMyFiltersdropdown label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($(this).parent().find("input").prop("checked") == true) {
                    $(this).parent().find("input").prop("checked", false);
                    $(this).attr("data-original-title", "Apply filter");
                }
            });
        }

        function clearBasicFiltersforEdit() {
            FilterID = '0';
            $("#FilterID").val("0");
            $("#QueryID").val("0");
            $("#presetfilterML").find("input[type=text],input[type=Textbox], textarea").val("");
            $("#presetfilterML").find('input:checkbox').removeAttr('checked');
            //if ($('#txtPMRWFilterReviewedBy option:selected').toArray().length > 0) {
            //    $("#txtPMRWFilterReviewedBy").multiselect("clearSelection");
            //    $("#txtPMRWFilterReviewedBy").multiselect("refresh");
            //}
            //if ($('#txtPMRWFilterReviewee option:selected').toArray().length > 0) {
            //    $("#txtPMRWFilterReviewee").multiselect("clearSelection");
            //    $("#txtPMRWFilterReviewee").multiselect("refresh");
            //}
            $("#presetfilterML").find("select").each(function (obj) {
                var cbo = this.id;
                //if (cbo != 'txtPMRWFilterReviewedBy' && cbo != 'txtPMRWFilterReviewee') {
                $("#" + cbo + " option:first").prop('selected', 'selected');
                //}
            });
            $("#presetfilter").removeClass("active in");

            $("#queryfilter").removeClass("active in");
            $("#advancefilterli").removeClass("active");

            $("#presetfilter").addClass("active in");
            $("#basicfilterli").addClass("active");

        }


        function clearBasicFilters() {

            FilterID = '0';
            $("#FilterID").val("0");
            $("#QueryID").val("0");
            $("#txtFilterName").val('');
            $("#presetfilterML").find("input[type=text],input[type=Textbox], textarea").val("");
            $("#presetfilterML").find('input:checkbox').removeAttr('checked');
            //if ($('#txtPMRWFilterReviewedBy option:selected').toArray().length > 0) {
            //    $("#txtPMRWFilterReviewedBy").multiselect("clearSelection");
            //    $("#txtPMRWFilterReviewedBy").multiselect("refresh");
            //}
            //if ($('#txtPMRWFilterReviewee option:selected').toArray().length > 0) {
            //    $("#txtPMRWFilterReviewee").multiselect("clearSelection");
            //    $("#txtPMRWFilterReviewee").multiselect("refresh");
            //}
            $("#presetfilterML").find("select").each(function (obj) {
                var cbo = this.id;
                //if (cbo != 'txtPMRWFilterReviewedBy' && cbo != 'txtPMRWFilterReviewee') {
                $("#" + cbo + " option:first").prop('selected', 'selected');
                //}
            });
            $("#presetfilter").removeClass("active in");


        }


        ////End filter code

        ////Start CR filter code 30-11-2019
        function PMProjectReviewCRDefaultFilter() {
            var TagID = 2191;

            var PMProjectReviewFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                TagID: encodeURI(TagID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                //Comment and added by Riddhesh on 3 March 2023
                //IsPlannedReview: false
                IsPlannedReview: 0
                //End of Comment and added by Riddhesh on 3 March 2023
            }
            StartLoader("#bodyPMProjectReview");
            $.ajax({
                url: strUrl + '/api/PM_Project_Review/CheckPMProjectReviewDefaultFilter',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {

                    var FilterID = result.FilterID;
                    var QueryText = result.QueryText;
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                    }
                    CRGlobalApplyID = "Apply" + FilterID;
                    GetAllReviews(QueryText);
                    if (FilterID != 0) {
                        $("#btnAdvFilterCR").css({ "background": "#1359a6", "color": "#fff" });
                    } else {
                        $("#btnAdvFilterCR").css({ "background": "NONE", "color": "#464a4c" });
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview")
        }

        var CRFilterAllFields = ["PReviewTypeID", "ReviewedBy", "ReviewNotes", "Reviewee", "ModuleID", "DeliverableID", "ReviewTitle", "ReviewStartDate", "ActualStartDate", "ActualEndDate", "ReviewEndDate", "IsOfflineReview", "IsReviewBillable", "IsSendReviewInvite", "IterationID", "MilestoneID", "PhaseID", "StartTime", "SubProjectID"];
        var CRmodule = "PMRWCR";
        //Onclick of PMProjectReview Apply button 
        function PMProjectReviewCRbtnApplyFilter() {

            var strQuery = "";
            strQuery = GenerateBasicFilterQuery(CRmodule, CRFilterAllFields);
            if (strQuery == "") {
                showAlert("Please select at least one filter option.", 'alert-danger');
            }
            else {
                GetAllReviews(strQuery);
                //Added By imran on 11th Jan 2022 not getting Alert after Applying Filter
                showAlert("Filter Applied Successfully", 'alert-success');
                //End of Added By Imran Chavan on 11th Jan 2022 not getting Alert after Applying
                $("#PMProjectReviewCRClearAllFilter").show();
                $("#btnAdvFilterCR").css({ "background": "#1359a6", "color": "#fff" });
                $(".filterpanelplnReviewCR ").removeClass("show");
                $("#btnAdvFilterCR").css({ "background": "#1359a6", "color": "#fff" });
                $("#presetfilterCR").removeClass("active");
                $("#presetfilterCR").removeClass("show");
                $(".filterpanelheader li a").removeClass("active");
            }
            return strQuery;
        }

        //reset edit filters
        function ResetCREditFilterID() {

            if ($("#basicfilterCRli").hasClass("active")) {

            } else {
                CRFlag = 0;
                CRFilterID = 0;
            }
        }


        function btnPMProjectReviewCRSaveAndApplyFilter_Onclick() {
            if (CheckProjectIsSelect()) {
                var TagID = 2191;
                var strQuery = GenerateBasicFilterQuery(CRmodule, CRFilterAllFields);
                if (strQuery.length > 0) {
                    $("#CRIssuesavefilter").modal("show");
                } else {
                    showAlert('<%= MyBase.GetResourceString("C_Filter_PleaseSelectAtleastoneFilter") %>', 'alert-danger');
                }
            }
        }

        //savePMProjectReviewCR filter
        function SavePMProjectReviewCRFilter() {
            if (CheckProjectIsSelect()) {
                var FilterName = $("#txtFilterNameCR").val();
                var FilterName = replaceAllChar($("#txtFilterNameCR").val().trim());
                var strQuery = GenerateBasicFilterQuery(CRmodule, CRFilterAllFields);
                if (strQuery == "") {
                    showAlert('<%= MyBase.GetResourceString("C_Filter_PleaseSelectAtleastoneFilter") %>', 'alert-danger');
                }
                //Added By Rehan C To add Validator for Special characters on 07th Nov 2022
                else if (checkSpecialCharacter(FilterName, WebConfigSpecialCharacters) == true) {
                    $("#btnSaveBasicFilterCR").removeAttr("data-bs-dismiss");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Filter Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtFilterNameCR").focus();
                }
                else if (FilterName.trim() != '') {
                    var IsFilterNameExists = "0";
                    var PMProjectReviewFilterParameter = {
                        TagID: encodeURI(2191),
                         //Comment and added by Riddhesh on 3 March 2023
                        //IsPlannedReview: false,
                        IsPlannedReview: 0,
                         //End of Comment and added by Riddhesh on 3 March 2023
                        ProjectID: encodeURI($("#CboProject :selected").val()),
                        UserID: encodeURI(UserID),
                        FilterName: encodeURI(replaceAllChar(FilterName)),
                        LoginType: encodeURI(LoginType),
                        QueryText: encodeURI(strQuery),
                        CreatedBy: encodeURI(UserName),
                         //Comment and added by Riddhesh on 3 March 2023
                        //Flag: encodeURI(CRFlag),
                        Flag: encodeURI(0),
                         //End of Comment and added by Riddhesh on 3 March 2023
                        FilterID: encodeURI(CRFilterID)
                    }
                    StartLoader("#bodyPMProjectReview");
                    //Check fileter name duplicate 
                    $.ajax({
                        url: strUrl + '/api/PM_Project_Review/IsDuplicatePMProjectReviewBasicFilter',// Path
                        type: "POST",                                       //HTTP TYPE get /post
                        data: JSON.stringify(PMProjectReviewFilterParameter),       // Parameters
                        dataType: "json",                                   //Retrun Type 
                        contentType: "application/json; charset=utf-8",     //
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (PMProjectReviewFilterParameter) {
                                xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                            }
                        },
                        async: false,
                        success: function (result) {
                            if (!result) {
                                $.ajax({
                                    url: encodeURI(strUrl) + '/api/PM_Project_Review/SavePMProjectReviewBasicFilter',
                                    method: 'Post',
                                    data: JSON.stringify(PMProjectReviewFilterParameter),
                                    dataType: 'json',
                                    async: false,
                                    contentType: "application/json",
                                    beforeSend: function (xhr) {
                                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                        if (PMProjectReviewFilterParameter) {
                                            xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                                        }
                                    },
                                    success: function (result) {

                                        if (result != "") {
                                            $("#CRIssuesavefilter").modal("hide");
                                            CRGlobalApplyID = "Apply" + result;
                                            PMProjectReviewCRGetMyFiltersList();
                                            PMProjectReviewCRApplyCheckFilter(CRGlobalApplyID);
                                            showAlert("Filter applied Sucessfully", 'alert-success');
                                            $("#presetfilterCR").removeClass("active");
                                        }
                                    },
                                    error: function (err) {
                                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                    }
                                })
                            }
                            else {
                                showAlert('<%= MyBase.GetResourceString("C_Advance_Filter_Already_Exists") %>', 'alert-danger');
                                IsFilterNameExists = "1";
                                return;
                            }
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                    StopAjaxLoader("#bodyPMProjectReview");
                    if (IsFilterNameExists == "0") {
                        clearBasicFiltersCR();
                    }
                } else {
                    showAlert("Please enter filter name.", 'alert-danger');
                }
            }
        }

        //open basic filter tab
        function OpenBasicFilterCR() {
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
        }

        //Function for get the list of PMProjectReviewCR filters on My filter dropdown
        function PMProjectReviewCRGetMyFiltersList() {
            var SetID = CRselectedqid;
            var projectID = ProjectID;
            if (projectID == '0' || projectID == '') {
                projectID = -1;
            }
            clearBasicFilters();
            var PMProjectReviewFilterParameter = {
                TagID: encodeURI(2191),
                 //Comment and added by Riddhesh on 3 March 2023
                //IsPlannedReview: 1,
                IsPlannedReview: 0,
                 //End of Comment and added by Riddhesh on 3 March 2023
                ProjectID: encodeURI(projectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetMyPMProjectReviewFiltersList',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {
                    var strHTML = "";

                    $("#PMProjectReviewCRMyFiltersdropdown").empty();
                    for (var i = 0; i < result.length; i++) {

                        strHTML += '<li id="li' + result[i].FilterId + '">'

                        if (result[i].SetDefault == true) {
                            CRGlobalApplyID = 'Apply' + result[i].FilterId;
                            strHTML += '<label class="customradio">'
                            strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + result[i].FilterId + '" type="checkbox" name="' + result[i].FilterId + '" onchange="PMProjectReviewCRRemoveDefaultFilter(this.id)" checked="checked">'
                            strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Remove Default filter" class="checkmark"></span>'
                            strHTML += '</label>'
                            strHTML += '<label class="">'
                            strHTML += '<span for="project2" class="radiotextsty filtername">' + result[i].FilterName + '</span>'
                            strHTML += '</label>'
                            strHTML += '<div class="issfilter_actiondropdown">'
                            strHTML += '<div class="custom_chckbox_markblue">'
                            //Commented and Added by Riddhesh Patil on 10th April 2023
                            //strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" checked="" type="radio" name="abc">'
                            //strHTML += '<label data-bs-toggle="tooltip" data-original-title="Apply filter" data-bs-container="body" data-bs-placement="bottom" title="Default filter" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewCRApplyCheckFilter(this.id)"></label>'
                            if (result[i].FilterId == SetID) {
                                strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                                strHTML += '<label data-bs-toggle="tooltip" title="Applied filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="ClearCRall();"></label>'
                            }
                            else {
                                strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                                strHTML += '<label data-bs-toggle="tooltip" title="Apply filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewCRApplyCheckFilter(this.id)"></label>'
                            }
                            //End of Commented and Added by Riddhesh Patil on 10th April 2023
                            strHTML += '</div>'
                            strHTML += '<span onclick="OpenBasicFilterCR()"><i  data-original-title="Edit filter"  data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt edit_filter" id="' + result[i].FilterId + '" onclick="PMProjectReviewCREditMyFilter(this.id);"></i></span>'
                            strHTML += '<span><i data-bs-toggle="tooltip" data-original-title="Delete filter" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="Default' + result[i].FilterId + '" onclick="PMProjectReviewCRDeleteMyFilter(this.id)"></i></span>'
                            strHTML += '</div>'
                            strHTML += '</li>'
                        }
                        else {
                            strHTML += '<label class="customradio">'
                            strHTML += '<input class="myfilter_selectprocheckbox" data-original-title="Set Default filter" data-bs-toggle="tooltip" data-bs-placement="bottom" id="' + result[i].FilterId + '" type="radio" name="project2" onchange="PMProjectReviewCRSetDefaultFilter(this.id)">'
                            strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>'
                            strHTML += '</label>'
                            strHTML += '<label class="">'
                            strHTML += '<span for="project2" class="radiotextsty filtername">' + result[i].FilterName + '</span>'
                            strHTML += '</label>'
                            strHTML += '<div class="issfilter_actiondropdown">'
                            strHTML += '<div class="custom_chckbox_markblue">'
                            //strHTML += '<input id="IssueselproOne' + result[i].FilterId + '" type="radio" name="">'
                            //strHTML += '<label data-bs-toggle="tooltip" data-original-title="Apply filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewCRApplyCheckFilter(this.id)"></label>'
                            if (result[i].FilterId == SetID) {
                                strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                                strHTML += '<label data-bs-toggle="tooltip" title="Applied filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="ClearCRall();"></label>'
                            }
                            else {
                                strHTML += '<label data-bs-toggle="tooltip" title="Apply filter" title="" data-bs-container="body" data-bs-placement="bottom" for="IssueselproOne' + result[i].FilterId + '" id="Apply' + result[i].FilterId + '" onclick="PMProjectReviewCRApplyCheckFilter(this.id)"></label>'
                            }
                            strHTML += '</div>'
                            strHTML += '<span onclick="OpenBasicFilterCR()"><i data-bs-toggle="tooltip" data-original-title="Edit filter" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt edit_filter" id="' + result[i].FilterId + '" onclick="PMProjectReviewCREditMyFilter(this.id);"></i></span>'
                            strHTML += '<span><i data-bs-toggle="tooltip" data-original-title="Delete filter" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="' + result[i].FilterId + '" onclick="PMProjectReviewCRDeleteMyFilter(this.id)"></i></span>'
                            strHTML += '</div>'
                            strHTML += '</li>'
                        }
                    }
                    $("#PMProjectReviewCRMyFiltersdropdown").append(strHTML);

                    if (CRGlobalApplyID != null) {
                        PMProjectReviewCRApplyCheckFilter(CRGlobalApplyID);
                    }
                    else {
                        ClearFilterAppliedCR();
                    }
                    $('[data-bs-toggle="tooltip"]').tooltip();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        ////End CR filter code
        //Added by Riddhesh Patil on 10th April 2023
        function ClearCRall() {
            CRselectedqid = "";
            GetAllReviews(null);
        }
        //End of Added by Riddhesh Patil on 10th April 2023
        //Delete Saved PMProjectReviewCR filter
        function PMProjectReviewCRDeleteMyFilter(FilterID) {
            $(".tooltip").tooltip("hide");
            if (FilterID.indexOf('Default') > -1) {
                var FilterID = FilterID.replace("Default", "");
                PMProjectReviewCRDeleteFilter(FilterID);
                GetAllReviews(null);
                PMProjectReviewCRGetMyFiltersList();
                $("#btnAdvFilterCR").css({ "background": "NONE", "color": "#464a4c" });
                clearBasicFiltersCR();
            }
            else {
                PMProjectReviewCRDeleteFilter(FilterID);
                PMProjectReviewCRDefaultFilter();
                PMProjectReviewCRGetMyFiltersList();
                clearBasicFiltersCR();
            }
        }

        //Delete PMProjectReviewCR Filter
        function PMProjectReviewCRDeleteFilter(FilterID) {
            StartLoader("#bodyPMProjectReview");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/DeletePMProjectReviewFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        showAlert("Filter is deleted successfully.", 'alert-success');
                        PMProjectReviewCRGetMyFiltersList();
                    }
                }, error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview")
        }

        //Apply saved PMProjectReviewCR filter
        function PMProjectReviewApplyCRSavedFilter(FilterID) {
            StartLoader("#bodyPMProjectReview");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetPMProjectReviewWhereClauseOfFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    var Querytext = result;
                    var FilterID = result.FilterID;
                    var QueryText = result.QueryText;
                    if (QueryText != null) {
                        QueryText = QueryText.toString().replace(/'/g, "''");
                    }
                    GetAllReviews(Querytext);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview")
        }

        //To set the default filter of PMProjectReviewCR.
        function PMProjectReviewCRSetDefaultFilter(FilterID) {
            var PMProjectReviewFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                TagID: encodeURI(2191),
                 //Comment and added by Riddhesh on 3 March 2023
                //IsPlannedReview: false,
                IsPlannedReview: 0,
                 //End of Comment and added by Riddhesh on 3 March 2023
                FilterID: encodeURI(FilterID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/SetPMProjectReviewDefaultFilter',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {
                    showAlert("Default filter is set.", 'alert-success');
                    CRFilterID = "Apply" + FilterID;
                    PMProjectReviewCRGetMyFiltersList();
                    PMProjectReviewCRApplyCheckFilter(CRFilterID);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //To remove the default filter of PMProjectReviewCR.
        function PMProjectReviewCRRemoveDefaultFilter(FilterID) {
            StartLoader("#bodyPMProjectReview");
            FilterID = FilterID.replace("Default", "");
            var PMProjectReviewFilterParameter = {
                ProjectID: encodeURI(ProjectID),
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID),
                TagID: encodeURI(2191),
                 //Comment and added by Riddhesh on 3 March 2023
                //IsPlannedReview: false,
                IsPlannedReview: 0,
                 //End of Comment and added by Riddhesh on 3 March 2023
                FilterID: encodeURI(FilterID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/RemovePMProjectReviewDefaultFilter',
                method: 'Post',
                data: JSON.stringify(PMProjectReviewFilterParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMProjectReviewFilterParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                    }
                },
                success: function (result) {
                    showAlert("Default filter is removed.", 'alert-success');
                    GetAllReviews(null);
                    PMProjectReviewCRGetMyFiltersList();
                    $("#btnAdvFilterCR").css({ "background": "NONE", "color": "#464a4c" });
                    clearBasicFiltersCR();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyPMProjectReview");
        }


        //To Edit saved PMProjectReviewCR filter
        function PMProjectReviewCREditMyFilter(FilterId) {

            CRFlag = 1;
            clearBasicFiltersCRforEdit();
            CRFilterID = FilterId;
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/EditPMProjectReviewFilterData',
                method: 'Post',
                data: JSON.stringify(CRFilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (CRFilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(CRFilterID) ? CRFilterID : JSON.stringify(CRFilterID)));
                    }
                },
                success: function (result) {

                    BindBasicFilters(result[0].WhereClause, CRmodule);
                    $("#txtFilterNameCR").val(result[0].FilterName);
                    CRFilterID = FilterId;
                    GlobalFilterName = result[0].FilterName;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        // Getting QueryText From Perticular FilterID
        function PMProjectReviewCRApplyCheckFilter(ApplyID) {
            $("#" + ApplyID).attr("data-original-title");
            if ($("#" + ApplyID).attr("data-original-title") == "Applied filter" || $("#" + ApplyID).attr("data-original-title") == "Default filter") {
                return;
            }
            var FilterID = ApplyID.replace("Apply", "");
            if (FilterID != undefined) {
                PMProjectReviewFilterParameter = {
                    FilterID: encodeURI(FilterID),
                    //Comment and added by Riddhesh on 3 March 2023
                    //IsPlannedReview: false,
                    IsPlannedReview: 0
                    //End of Comment and added by Riddhesh on 3 March 2023
                }
                $.ajax({
                    url: strUrl + '/api/PM_Project_Review/GetWhereClauseFilter',
                    type: "POST",
                    data: JSON.stringify(PMProjectReviewFilterParameter),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMProjectReviewFilterParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMProjectReviewFilterParameter) ? PMProjectReviewFilterParameter : JSON.stringify(PMProjectReviewFilterParameter)));
                        }
                    },
                    success: function (result) {
                        $(FilterID).attr("checked");
                        //Added by Riddhesh Patil on 10th April 2023
                        CRselectedqid = FilterID;
                        //End of Added by Riddhesh Patil on 10th April 2023
                        var QueryText = result;
                        if (QueryText != null) {
                            QueryText = QueryText.toString().replace(/'/g, "''");
                        }

                        var sibling = $('#PMProjectReviewCRMyFiltersdropdown label[id^="Apply"]')

                        $(sibling).each(function () {
                            var id = this.id;
                            if (ApplyID == this.id) {
                                $(this).parent().find("input").prop("checked", true);
                                $(this).attr("data-original-title", "Applied filter");
                            }
                            else {
                                $(this).parent().find("input").prop("checked", false);
                                $(this).attr("data-original-title", "Apply filter");
                            }
                        });
                        GetAllReviews(QueryText);
                        $("#PMProjectReviewCRClearAllFilter").show();
                        $("#btnAdvFilterCR").css({ "background": "#1359a6", "color": "#fff" });
                        CRGlobalApplyID = "Apply" + FilterID;
                        $('#presetfilterCR').removeClass("active");
                        $('.filterpanelplnReviewCR .cust_tabpanel li').removeClass("active");
                        $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
        }

        function clearBasicFiltersCR() {

            $("#CRFilterID").val("0");
            $("#CRQueryID").val("0");
            CRFilterID = '0';
            $("#txtFilterNameCR").val('');
            $("#presetfilterCR").find("input[type=text],input[type=Textbox], textarea").val("");
            $("#presetfilterCR").find('input:checkbox').removeAttr('checked');
            if ($('#txtPMRWCRFilterReviewedBy option:selected').toArray().length > 0) {
                $("#txtPMRWCRFilterReviewedBy").multiselect("clearSelection");
                $("#txtPMRWCRFilterReviewedBy").multiselect("refresh");
            }
            if ($('#txtPMRWCRFilterReviewee option:selected').toArray().length > 0) {
                $("#txtPMRWCRFilterReviewee").multiselect("clearSelection");
                $("#txtPMRWCRFilterReviewee").multiselect("refresh");
            }
            $("#presetfilterCR").find("select").each(function (obj) {
                var cbo = this.id;
                if (cbo != 'txtPMRWCRFilterReviewedBy' && cbo != 'txtPMRWCRFilterReviewee') {
                    $("#" + cbo + " option:first").prop('selected', 'selected');
                }
            });
            $("#presetfilter").removeClass("active in");


        }

        //To clear the applied filter arrow after click on clear filter button
        function ClearFilterAppliedCR() {
            var sibling = $('#PMProjectReviewCRMyFiltersdropdown label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($(this).parent().find("input").prop("checked") == true) {
                    $(this).parent().find("input").prop("checked", false);
                    $(this).attr("data-original-title", "Apply filter");
                }
            });
        }

        function clearBasicFiltersCRforEdit() {

            $("#btnsaveandapply1").show();
            $("#btnsaveandapply2").show();
            CRFilterID = '0';
            $("#CRFilterID").val("0");
            $("#CRQueryID").val("0");
            $("#presetfilterCR").find("input[type=text],input[type=Textbox], textarea").val("");
            $("#presetfilterCR").find('input:checkbox').removeAttr('checked');
            if ($('#txtPMRWCRFilterReviewedBy option:selected').toArray().length > 0) {
                $("#txtPMRWCRFilterReviewedBy").multiselect("clearSelection");
                $("#txtPMRWCRFilterReviewedBy").multiselect("refresh");
            }
            if ($('#txtPMRWCRFilterReviewee option:selected').toArray().length > 0) {
                $("#txtPMRWCRFilterReviewee").multiselect("clearSelection");
                $("#txtPMRWCRFilterReviewee").multiselect("refresh");
            }
            $("#presetfilterCR").find("select").each(function (obj) {
                var cbo = this.id;
                if (cbo != 'txtPMRWCRFilterReviewedBy' && cbo != 'txtPMRWCRFilterReviewee') {
                    $("#" + cbo + " option:first").prop('selected', 'selected');
                }
            });
            $("#presetfilterCR").removeClass("active in");

            $("#queryfilter").removeClass("active in");
            $("#advancefilterli").removeClass("active");

            $("#presetfilterCR").addClass("active in");
            $("#basicfilterCRli").addClass("active");

        }

        //replace 
        function replaceAllChar(text, replacechar, replacewith) {
            if (text == null || text == undefined) {
                return text;
            }
            var replacetext = '';
            var _replacechar = '';
            var _replacewith = '';
            if (replacechar == undefined)
                _replacechar = "'";
            if (replacewith == undefined)
                _replacewith = "''";
            if (text != '') {
                var ch = '';
                for (var i = 0; i < text.length; i++) {
                    ch = text.charAt(i);
                    if (ch == _replacechar) {
                        replacetext = replacetext + _replacewith;
                    } else {
                        replacetext = replacetext + ch;
                    }
                }
            }
            return replacetext;
        }

        //replace 
        function replaceChar(text) {
            var replacetext = text;
            if (replacetext != '') {
                replacetext = replacetext.replace("''''", "''").replace("''", "'");
            }
            return replacetext;
        }

        function setDefaultOption() {
            $('select[name=txtPMRWFilterPReviewTypeID] > option:first-child').text('Select Review Type');
            $('select[name=txtPMRWCRFilterPReviewTypeID] > option:first-child').text('Select Review Type');
            $('select[name=txtPMRWFilterIsSendReviewInvite] > option:first-child').text('Select Send Review Invite');
            $('select[name=txtPMRWCRFilterIsSendReviewInvite] > option:first-child').text('Select Send Review Invite');
            $('select[name=txtPMRWFilterIsOfflineReview] > option:first-child').text('Select Offline Review');
            $('select[name=txtPMRWCRFilterIsOfflineReview] > option:first-child').text('Select Offline Review');
            $('select[name=txtPMRWFilterWorkProductType] > option:first-child').text('Select Work Product Type');
            $('select[name=txtPMRWCRFilterWorkProductType] > option:first-child').text('Select Work Product Type');
            $('select[name=txtPMRWFilterIsReviewBillable] > option:first-child').text('Select Billable');
            $('select[name=txtPMRWCRFilterIsReviewBillable] > option:first-child').text('Select Billable');
            $('select[name=txtPMRWFilterSubProjectID] > option:first-child').text('Select Sub Project');
            $('select[name=txtPMRWCRFilterSubProjectID] > option:first-child').text('Select Sub Project');
            $('select[name=txtPMRWFilterPhaseID] > option:first-child').text('Select Phase');
            $('select[name=txtPMRWCRFilterPhaseID] > option:first-child').text('Select Phase');
            $('select[name=txtPMRWFilterMilestoneID] > option:first-child').text('Select Milestone');
            $('select[name=txtPMRWCRFilterMilestoneID] > option:first-child').text('Select Milestone');
            $('select[name=txtPMRWFilterDeliverableID] > option:first-child').text('Select Deliverable');
            $('select[name=txtPMRWCRFilterDeliverableID] > option:first-child').text('Select Deliverable');
            $('select[name=txtPMRWFilterModuleID] > option:first-child').text('Select Module');
            $('select[name=txtPMRWCRFilterModuleID] > option:first-child').text('Select Module');
            //added by Vishal M 03-01-2020
            $('select[name=CboUnitcr] > option:first-child').text('Select Unit');
        }

        // END Vishal Mahajan 02-12-2019

        // Start Vishal Mahajan 06-12-2019        
        function sendInvitation(reviewStatisticsID, isInvitation, isResendReviewInvite) {

            var MessageID = 29;
            var reviewInviteOrCancellation = {
                OldReviewStartDate: '',
                OldReviewEndDate: '',
                LoginID: UserID,
                ReviewStatisticsID: reviewStatisticsID,
            };
            if (isInvitation) {
                MessageID = 29;
            }
            else if (isResendReviewInvite) {
                MessageID = 30;
                reviewInviteOrCancellation.OldReviewStartDate = OldStartDate;
                reviewInviteOrCancellation.OldReviewEndDate = OldEndDate;
            }
            else {
                MessageID = 20049;
            }
            getEmailShowPopupFlag(MessageID);
            if (isEmailShowPopup) {
                //if (true) {

                window.open("../Email/SendEmail.aspx?MessageID=" + MessageID + "&ReviewStatisticsID=" + reviewInviteOrCancellation.ReviewStatisticsID + "&LoginUserID=" + reviewInviteOrCancellation.LoginID + "&OldReviewStartDate=" + reviewInviteOrCancellation.OldReviewStartDate.replace(" ", "_").replace(" ", "_") + "&OldReviewEndDate=" + reviewInviteOrCancellation.OldReviewEndDate.replace(" ", "_").replace(" ", "_") + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                //start vishal mahajan 10-12-2019                      
                setTimeout(GetAllReviews(ReportFilterQuery), 7000);
                //end vishal mahajan 10-12-2019
            }
            else {
                var EmailParameters = {
                    msgID: MessageID,
                    ReviewStatisticsID: reviewInviteOrCancellation.ReviewStatisticsID,
                    LoginUserID: reviewInviteOrCancellation.LoginID,
                    OldReviewStartDate: reviewInviteOrCancellation.OldReviewStartDate.replace(" ", "_").replace(" ", "_"),
                    OldReviewEndDate: reviewInviteOrCancellation.OldReviewEndDate.replace(" ", "_").replace(" ", "_"),
                };
                $.ajax({
                    url: strUrl + '/api/SendEmail/SendSilentEmailWithAttachment',
                    type: "POST",
                    data: JSON.stringify(EmailParameters),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (data) {

                        if (data == 1) {
                            setTimeout(GetAllReviews(ReportFilterQuery), 5000);
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            }
        }

        function sendInvitaion(ainvitaion, ReviewStatisticsID) {
            var PM_Project_Review = {
                ReviewStatisticsID: ReviewStatisticsID
            };
            $.ajax({
                url: strUrl + '/api/PM_Project_Review/SendReviewInvite',
                type: "POST",
                data: JSON.stringify(PM_Project_Review),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PM_Project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PM_Project_Review) ? PM_Project_Review : JSON.stringify(PM_Project_Review)));
                    }
                },
                success: function (data) {
                    if (data == 1) {
                        $(ainvitaion).text("Send Review Cancellation");
                        sendInvitation(ReviewStatisticsID, true, false);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function sendCancellation(ainvitaion, ReviewStatisticsID) {
            var PM_Project_Review = {
                ReviewStatisticsID: ReviewStatisticsID
            };
            $.ajax({
                url: strUrl + '/api/PM_Project_Review/ReviewInviteCancellation',
                type: "POST",
                data: JSON.stringify(PM_Project_Review),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PM_Project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PM_Project_Review) ? PM_Project_Review : JSON.stringify(PM_Project_Review)));
                    }
                },
                success: function (data) {
                    if (data == 1) {
                        $(ainvitaion).text("Send Review Invitation");
                        sendInvitation(ReviewStatisticsID, false, false);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        var isEmailShowPopup = true;
        function getEmailShowPopupFlag(MessageID) {

            var id = $("#CboProject :selected").val();
            if (id != '' && id != '0') {
                var EmailParameters = {
                    msgID: MessageID,
                    ProjectID: id,
                };
                $.ajax({
                    url: strUrl + '/api/SendEmail/GetEmailShowPopupFlagForProject',
                    type: "POST",
                    data: JSON.stringify(EmailParameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (data) {

                        if (data == 1) {
                            isEmailShowPopup = true;
                        } else {
                            isEmailShowPopup = false;
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
            } else {
                isEmailShowPopup = true;
            }
        }

        function enableDisabledControls() {

            var id = $("#CboProject :selected").val();
            if (id == '' || id == '0') {
                $.each($("#bodyPMProjectReview").find("li,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $.each($("#bodyPMProjectReview").find("li,select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $("#PMProjectReviewClearAllFilter").hide(); $("#btnAdvFilter").css({ "background": "NONE", "color": "#464a4c" });
            } else {
                $.each($("#bodyPMProjectReview").find("li,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $.each($("#bodyPMProjectReview").find("li,select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                enableDisabledControlsForEdit(true);
            }
            $("#btnCloseableAlert").removeClass("disabledbutton");
            $("#CboProject").removeClass("disabledbutton");
        }

        function enableDisabledControlsForEdit(flag) {

            if (!flag) {
                $.each($("#divmainreviewheader").find("li,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $.each($("#projectcondctreviewtbl_wrapper,#projectplanreviewtbl_wrapper").find("table,div,li,select,a,button"), function (index, control) {
                    $(control).addClass("disabledbutton");
                });
                $("#btnAddNewReview").addClass("disabledbutton");
                $("#btnAdvFilter").attr("aria-expanded", false);
                $("#filterpanelplnReview").removeClass("in");
            } else {
                $.each($("#divmainreviewheader").find("li,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $.each($("#projectcondctreviewtbl_wrapper,#projectplanreviewtbl_wrapper").find("table,div,li,select,a,button"), function (index, control) {
                    $(control).removeClass("disabledbutton");
                });
                $("#btnAddNewReview").removeClass("disabledbutton");
            }
        }

        // end Vishal Mahajan 06-12-2019
        //Added By Chetan M. on 4 Dec 2019
        var GblIssueType = "";
        var GblIssueSubType = "";
        var GblIssueCorpSubType = "";
        var GblIssueStatus = "";
        var GblIssueCorpStatus = "";
        var GblCReviewTypeID;
        var GblReviewStaticID;
        var GblChecklistTypeID;
        var strQuestionWithOption = "";
        var strShowComment = "";
        var lngTempQuestionID = "";
        var strBtnName = "";
        var GblDescription = "";
        var GblCheckListItemName = "";
        var GblSingleSelection;
        var GblJval;
        var GblResponseval = 0;
        //Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
        var strQuestionWithOption1 = "";
        //End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
        //Addded By Dipali V On 04th Feb 2026 For checklist issues
        var GlobalDropdownID = 0;
        var strShowComment = "";
        var lngTempQuestionID = "";
        var strBtnName = "";
        var GblDescription = "";
        var GblCheckListItemName = "";
        var GblSingleSelection;
        var GblJval;
        var GblResponseval = 0;
        //End of Addded By Dipali V On 04th Feb 2026 For checklist issues
        function PlotProjectReviewChecklist(ReviewStaticID, ChecklistTypeID, UserName) {
            //debugger
            var strHTML = "";
            //var IsDisable = flag;
            $("#cboChecklistcr").prop('disabled', false);
            StartLoader("#bodyPMProjectReview");
            GblReviewStaticID = ReviewStaticID;
            GblChecklistTypeID = ChecklistTypeID;
            if (ChecklistTypeID == "") {
                ChecklistTypeID = 0;
            }
            var ProjectReviewChecklistParameter = {
                ReviewStaticID: encodeURI(ReviewStaticID),
                ChecklistTypeID: encodeURI(ChecklistTypeID),
                UserName: encodeURI(UserName)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetProjectChecklistItems',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(ProjectReviewChecklistParameter),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ProjectReviewChecklistParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ProjectReviewChecklistParameter) ? ProjectReviewChecklistParameter : JSON.stringify(ProjectReviewChecklistParameter)));
                    }
                },
                success: function (strResult) {
                    //debugger

                    $("#tblProjectReviwCheckList").dataTable().fnDestroy();
                    if (strResult.length == 0) {
                        //$("#tblProjectReviwCheckList").empty();
                        //$("#tblProjectReviwCheckList_Body").empty();
                        $("#cboChecklistcr").prop('disabled', false);
                        $("#tblProjectReviwCheckList_Body").html('');


                        //Comment and added by Riddhesh on 3 March 2023
                        //$("#tblProjectReviwCheckList").html("<div class='chcklistwarningmsg'><div class='alert alert-warning fade in alert-dismissible'>No Checklist is defined for this review.</div></div>");

                        // strHTML += '<tr class="colspan-3">No Checklist is defined for this review.</tr>';



                        //$("#tblProjectReviwCheckList").html("<div class='chcklistwarningmsg'><div class='alert alert-dismissible text-center'>No Checklist is defined for this review.</div></div>");
                        // //End of Comment and added by Riddhesh on 3 March 2023
                        //$("#ProjectReviewChecklistID").empty();
                        $("#cboUsersIDN").hide();
                        $("#cboUserID").hide();

                        $("#ChecklistNameHeader").hide();
                        $("#btnSaveReviewChecklistResponses").attr("disabled", true);
                        $("#btnSaveReviewChecklistResponses").css({ 'pointer-events': 'none' });

                        $("#tblProjectReviwCheckList_Body").html(strHTML);
                    }
                    if (strResult.length != 0) {
                        //Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                        //for (var i = 0; i < strResult.length; i++) {
                        //    var Responce = "";                                
                        //    Responce = strResult[i].Responses;
                        //    if (Responce == ",") {
                        //        Responce = "";
                        //    }                                
                        //    if (Responce) {
                        //        var IsDisable = 1;
                        //        break
                        //    }
                        //}
                        for (var i = 0; i < strResult.length; i++) {
                            var Responce = "";
                            Responce = strResult[i].IsDisable;
                            if (Responce) {
                                var IsDisable = 1;
                                break
                            }
                        }

                        if (IsDisable == 1 && ($("#cboChecklistcr").val() != null && $("#cboChecklistcr").val() != "0")) {
                            $("#cboChecklistcr").prop('disabled', true);
                        } else {
                            $("#cboChecklistcr").prop('disabled', false);
                            if ($("#cboChecklistcr").val() == null || $("#cboChecklistcr").val() == "0") {
                                $("#cboChecklistcr").val("0");
                                $("#tblProjectReviwCheckList_Body").html('');
                                $("#tblProjectReviwCheckList_Body").html(strHTML);
                                return false
                            }

                        }
                        //End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization

                        $("#cboUsersIDN").show();
                        $("#cboUserID").show();
                        $("#btnSaveReviewChecklistResponses").attr("disabled", false);
                        $("#btnSaveReviewChecklistResponses").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });
                        $("#ChecklistNameHeader").show();
                        $("#ProjectReviewChecklistID").empty();
                        $("#ProjectReviewChecklistID").append(strResult[0].ChecklistShortName);
                        GblDescription = strResult[0].Description;
                        GblCheckListItemName = strResult[0].CheckListItemName;
                        GblSingleSelection = strResult[0].SingleSelection;
                        lngTempQuestionID = strResult[0].ProjectChecklistItemId;
                //$("#tblProjectReviwCheckList").empty();
                //$("#tblProjectReviwCheckList_Body").empty();

               // $("#tblProjectReviwCheckList_Body").html('');

                <%--theadHTML += '<thead>'
                theadHTML += '<tr>'
                theadHTML += '<th width="40%" class="text-start"><%= MyBase.GetResourceString("C_Checklist_Item")%></th>'
                theadHTML += '<th width="30%" class="text-start"><%= MyBase.GetResourceString("C_Responses")%></th>'
                theadHTML += '<th class="text-start"><%= MyBase.GetResourceString("C_Remark")%></th>'
                theadHTML += '</tr>'
                theadHTML += '</thead>'--%>
                        //$("#tblProjectReviwCheckList").append(theadHTML);
                        //$("#tblProjectReviwCheckList_Body").append(theadHTML);

                        //strHTML += '<thead width="100%"><tr><th colspan="3" class="text-start">' + GblDescription + '</th></tr></thead>';
                        strHTML += '<tr class="bgGrey"><th class="text-start">' + GblDescription + '</th><th></th><th></th></tr>';
                        for (var i = 0; i < strResult.length; i++) {
                            var Description = strResult[i].Description;
                            var CheckListItemName = strResult[i].CheckListItemName;
                            if (GblDescription != Description) {
                                if (Description != "") {
                                    GblDescription = Description;
                                    //strHTML += '<thead width="100%"><tr><th colspan="3" class="text-start">' + Description + '</th></tr></thead>';
                                    //strHTML += '<thead width="100%"><tr><th colspan="3" class="text-start">' + Description + '</th></tr></thead>';
                                    strHTML += '<tr class="bgGrey"><th class="text-start">' + Description + '</th><th></th><th></th></tr>';
                                }
                            }
                            if (GblCheckListItemName != CheckListItemName) {
                                if (CheckListItemName != "") {
                                    if (strResult[i].Compulsory == true) {
                                        strHTML += '<tr>';
                                        strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '"><span style="color: red;">* </span>' + CheckListItemName + '</div></td>';
                                    }
                                    else {
                                        strHTML += '<tr>';
                                        strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '">' + CheckListItemName + '</div></td>';
                                    }
                                    //Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                                    if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                        //strQuestionWithOption1 = "";
                                        var PlaceHolder = "Select Option";
                                        var strBtnName1 = "ddlOption";
                                        var Id = "cboOption" + strResult[i].ProjectChecklistItemId;
                                        if (strResult[i].UniqueId == 0) {
                                            strQuestionWithOption1 += '<div id="cboValue"><select class="form-select" id="' + Id + '" >';
                                        } else {
                                            strQuestionWithOption1 += '<div id="cboValue"><select class="form-select" id="' + Id + '" disabled="disabled">';
                                        }
                                        strQuestionWithOption1 += "<li>";
                                        //strQuestionWithOption += '<option value="0">' + PlaceHolder + '</option>';
                                        strQuestionWithOption1 += '<option id="' + strBtnName1 + '" type="dropdown" class="" name="" value="0">' + PlaceHolder + '</option>';

                                        strQuestionWithOption1 += "<li>";

                                    }
                                    //End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization

                                    for (var j = 0; j < strResult.length; j++) {

                                        if (lngTempQuestionID == strResult[j].ProjectChecklistItemId) {
                                            GblJval = j;

                                            if (strResult[j].MultipleSelection == true) {
                                                strBtnName = "chkOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                                strQuestionWithOption += '<div class="custom_chckbox">';
                                                var Responses = strResult[j].Responses;
                                                Responses = Responses.substring(1, Responses.length);
                                                Responses = Responses.substring(0, Responses.length - 1)
                                                var ArrResponce = Responses.split(',');
                                                for (var k = 0; k < ArrResponce.length; k++) {
                                                    Responses = ArrResponce[k];
                                                    if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses) {
                                                        GblResponseval = Responses;
                                                        strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '" checked>';
                                                    }
                                                }
                                                if (strResult[j].QuestionnaireOptionID != GblResponseval) {
                                                    strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '">';
                                                }
                                                strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';
                                            }
                                            if (strResult[j].SingleSelection == true) {

                                                //Commented and Added By Reshma on 27th Dec 2019 For IssueID-21116
                                                //strBtnName = "optOption" + strResult[j].OptionDescription + strResult[j].ProjectChecklistItemId;
                                                strBtnName = "optOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                                //End  Added By Reshma on 27th Dec 2019 For IssueID-21116

                                                strQuestionWithOption += '<div class="checkbox-inline custom_radio">';
                                                var Responses = strResult[j].Responses;
                                                Responses = Responses.replace(/,/g, "");

                                                if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses && strResult[i].UniqueId != 0) {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" checked="checked" disabled="disabled">';

                                                }
                                                else if (strResult[i].UniqueId != 0 && strResult[j].QuestionnaireOptionID != Responses) {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" disabled="disabled">';
                                                }
                                                else if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses && strResult[i].UniqueId == 0) {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" checked="checked">';
                                                }
                                                else {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '">';
                                                }


                                                if (strResult[j].IsNegative == true) {
                                                    strQuestionWithOption += '<label for="' + strBtnName + '"><span></span><b>' + strResult[j].OptionDescription + '</b></label></div>';
                                                }
                                                else {
                                                    strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';
                                                }
                                            }
                                            //Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                                            if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                                GlobalDropdownID = 1;
                                                strQuestionWithOption = "";
                                                strBtnName = "ddlOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                                strQuestionWithOption1 += "<li>";
                                                var Responses = strResult[j].Responses;
                                                Responses = Responses.substring(1, Responses.length - 1);
                                                var ArrResponse = Responses.split(',');

                                                if (Responses == ",") {
                                                    if (strResult[j].IsNegative == true) {
                                                        if (strResult[i].Compulsory == true) {
                                                            strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        } else {
                                                            strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        }
                                                    } else {
                                                        if (strResult[i].Compulsory == true) {
                                                            strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        } else {
                                                            strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        }
                                                    }
                                                }
                                                else {
                                                    for (var k = 0; k < ArrResponse.length; k++) {
                                                        var Response = ArrResponse[k].trim();
                                                        if (ArrResponse.length != 0) {
                                                            //if (strResult[j].QuestionnaireOptionID == Response) {
                                                            //    var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                            //    strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '>' + strResult[j].OptionDescription + '</option>';
                                                            //}
                                                            //else {
                                                            //    var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                            //    strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                            //}

                                                            if (strResult[j].QuestionnaireOptionID == Response && strResult[j].IsNegative == true) {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="1" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="0" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                }

                                                            } else if (strResult[j].QuestionnaireOptionID == Response && strResult[j].IsNegative == false) {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '>' + strResult[j].OptionDescription + '</option>';

                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '>' + strResult[j].OptionDescription + '</option>';
                                                                }

                                                            } else if (strResult[j].QuestionnaireOptionID != Response && strResult[j].IsNegative == true) {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="1" value="' + strResult[j].QuestionnaireOptionID + '"><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="0" value="' + strResult[j].QuestionnaireOptionID + '"><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                }
                                                            }
                                                            else {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                                }

                                                            }

                                                        } else {
                                                            var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                            if (strResult[i].Compulsory == true) {
                                                                strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                            } else {
                                                                strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                            }

                                                        }
                                                    }
                                                }
                                                strQuestionWithOption1 += "</li>";
                                            }
                                            //End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                                        }
                                        else {
                                        }
                                    }
                                    if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                        strQuestionWithOption1 += '<select></div>';
                                    }

                                    if (strResult[i].ShowComment == true) {
                                        if (strResult[i].Remarks != null) {
                                            if (strResult[i].SingleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000">' + strResult[i].Remarks + '</textarea></td>';
                                            }
                                            if (strResult[i].MultipleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000">' + strResult[i].Remarks + '</textarea></td>';
                                            }
                                            if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                                strShowComment = "";
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000">' + strResult[i].Remarks + '</textarea></td>';
                                            }
                                        }
                                        else {
                                            if (strResult[i].SingleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000"></textarea></td>';
                                            }
                                            if (strResult[i].MultipleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000"></textarea></td>';
                                            }
                                            if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                                strShowComment = "";
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000"></textarea></td>';
                                            }
                                        }
                                    }
                                }
                                if (GblJval + 1 < strResult.length) {
                                    lngTempQuestionID = strResult[GblJval + 1].ProjectChecklistItemId;
                                }
                            }
                            else {
                                if (GblCheckListItemName != "") {
                                    if (strResult[i].Compulsory == true) {
                                        strHTML += '<tr>';
                                        strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '"><span style="color: red;">* </span>' + GblCheckListItemName + '</div></td>';
                                    }
                                    else {
                                        strHTML += '<tr>';
                                        strHTML += '<td><div class="cl_question" id="' + strResult[i].ProjectChecklistItemId + '">' + GblCheckListItemName + '</div></td>';
                                    }
                                    //Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                                    if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                        //strQuestionWithOption1 = "";
                                        var PlaceHolder = "Select Option";
                                        var strBtnName1 = "ddlOption";
                                        var Id = "cboOption" + strResult[i].ProjectChecklistItemId;
                                        if (strResult[i].UniqueId == 0) {
                                            if (strResult[i].Compulsory == true) {
                                                strQuestionWithOption1 += '<div id="cboValue"><select class="form-select" id="' + Id + '" name="1" >';
                                            } else {
                                                strQuestionWithOption1 += '<div id="cboValue"><select class="form-select" id="' + Id + '" name="0" >';
                                            }

                                        } else {
                                            if (strResult[i].Compulsory == true) {
                                                strQuestionWithOption1 += '<div id="cboValue"><select class="form-select" id="' + Id + '" name="1" disabled="disabled">';
                                            } else {
                                                strQuestionWithOption1 += '<div id="cboValue"><select class="form-select" id="' + Id + '" name="0" disabled="disabled">';
                                            }

                                        }
                                        strQuestionWithOption1 += "<li>";
                                        //strQuestionWithOption += '<option value="0">' + PlaceHolder + '</option>';
                                        strQuestionWithOption1 += '<option id="' + strBtnName1 + '" type="dropdown" class="" name="" value="0">' + PlaceHolder + '</option>';

                                        strQuestionWithOption1 += "<li>";

                                    }
                                    //End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization

                                    for (var j = 0; j < strResult.length; j++) {
                                        if (lngTempQuestionID == strResult[j].ProjectChecklistItemId) {
                                            GblJval = j;

                                            if (strResult[j].MultipleSelection == true) {
                                                strBtnName = "chkOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                                strQuestionWithOption += '<div class="custom_chckbox">';

                                                var Responses = strResult[j].Responses;
                                                Responses = Responses.substring(1, Responses.length);
                                                Responses = Responses.substring(0, Responses.length - 1)
                                                var ArrResponce = Responses.split(',');
                                                for (var k = 0; k < ArrResponce.length; k++) {
                                                    Responses = ArrResponce[k];
                                                    if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses) {
                                                        GblResponseval = Responses;
                                                        strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '" checked>';
                                                    }
                                                }
                                                if (strResult[j].QuestionnaireOptionID != GblResponseval) {
                                                    strQuestionWithOption += '<input type="checkbox" id="' + strBtnName + '" class="" value="' + strResult[j].QuestionnaireOptionID + '">';
                                                }
                                                strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';
                                            }
                                            if (strResult[j].SingleSelection == true) {

                                                //Commented and Added By Reshma on 27th Dec 2019 For IssueID-21116
                                                //strBtnName = "optOption" + strResult[j].OptionDescription + strResult[j].ProjectChecklistItemId;
                                                strBtnName = "optOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                                //End  Added By Reshma on 27th Dec 2019 For IssueID-21116

                                                strQuestionWithOption += '<div class="checkbox-inline custom_radio">';
                                                var Responses = strResult[j].Responses;
                                                Responses = Responses.replace(/,/g, "");

                                                if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses && strResult[i].UniqueId != 0) {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" checked="checked" disabled="disabled">';
                                                }
                                                else if (strResult[i].UniqueId != 0 && strResult[j].QuestionnaireOptionID != Responses) {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" disabled="disabled">';
                                                }
                                                else if (Responses != "" && strResult[j].QuestionnaireOptionID == Responses && strResult[i].UniqueId == 0) {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" checked="checked">';
                                                }
                                                else {
                                                    strQuestionWithOption += ' <input id="' + strBtnName + '" type="radio" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '">';
                                                }


                                                if (strResult[j].IsNegative == true) {
                                                    strQuestionWithOption += '<label for="' + strBtnName + '"><span></span><b>' + strResult[j].OptionDescription + '</b></label></div>';
                                                }
                                                else {
                                                    strQuestionWithOption += '<label for="' + strBtnName + '"><span></span>' + strResult[j].OptionDescription + '</label></div>';
                                                }
                                            }
                                            //Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                                            if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                                GlobalDropdownID = 1;
                                                strQuestionWithOption = "";
                                                strBtnName = "ddlOption" + strResult[j].ProjectChecklistItemId + strResult[j].QuestionnaireOptionID;
                                                strQuestionWithOption1 += "<li>";
                                                var Responses = strResult[j].Responses;
                                                Responses = Responses.substring(1, Responses.length - 1);
                                                var ArrResponse = Responses.split(',');

                                                if (Responses == ",") {
                                                    if (strResult[j].IsNegative == true) {
                                                        if (strResult[i].Compulsory == true) {
                                                            strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        } else {
                                                            strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        }
                                                    } else {
                                                        if (strResult[i].Compulsory == true) {
                                                            strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        } else {
                                                            strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';

                                                        }
                                                    }
                                                }
                                                else {
                                                    for (var k = 0; k < ArrResponse.length; k++) {
                                                        var Response = ArrResponse[k].trim();
                                                        if (ArrResponse.length != 0) {
                                                            //if (strResult[j].QuestionnaireOptionID == Response) {
                                                            //    var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                            //    strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '>' + strResult[j].OptionDescription + '</option>';
                                                            //}
                                                            //else {
                                                            //    var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                            //    strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="' + strResult[j].ProjectChecklistItemId + '" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                            //}

                                                            if (strResult[j].QuestionnaireOptionID == Response && strResult[j].IsNegative == true) {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="1" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="0" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                }

                                                            } else if (strResult[j].QuestionnaireOptionID == Response && strResult[j].IsNegative == false) {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '>' + strResult[j].OptionDescription + '</option>';

                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '" ' + isSelected + '>' + strResult[j].OptionDescription + '</option>';
                                                                }

                                                            } else if (strResult[j].QuestionnaireOptionID != Response && strResult[j].IsNegative == true) {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="1" value="' + strResult[j].QuestionnaireOptionID + '"><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="1" type="dropdown" class="bold" name="0" value="' + strResult[j].QuestionnaireOptionID + '"><b>' + strResult[j].OptionDescription + '</b></option>';
                                                                }
                                                            }
                                                            else {
                                                                var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                                if (strResult[i].Compulsory == true) {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                                } else {
                                                                    strQuestionWithOption1 += '<option id="0" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                                }

                                                            }

                                                        } else {
                                                            var isSelected = (Response == strResult[j].QuestionnaireOptionID) ? "selected" : "";
                                                            if (strResult[i].Compulsory == true) {
                                                                strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="1" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                            } else {
                                                                strQuestionWithOption1 += '<option id="' + strBtnName + '" type="dropdown" class="" name="0" value="' + strResult[j].QuestionnaireOptionID + '">' + strResult[j].OptionDescription + '</option>';
                                                            }

                                                        }
                                                    }
                                                }
                                                strQuestionWithOption1 += "</li>";
                                            }
                                            //End of Added by Vishal Mane on 02/01/2025 to add a dropdown for responses for checklist customization
                                        }
                                        else {
                                        }
                                    }

                                    if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                        strQuestionWithOption1 += '<select></div>';
                                    }
                                    if (strResult[i].ShowComment == true) {
                                        if (strResult[i].Remarks != null) {
                                            if (strResult[i].SingleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000">' + strResult[i].Remarks + '</textarea></td>';
                                            }
                                            if (strResult[i].MultipleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000">' + strResult[i].Remarks + '</textarea></td>';
                                            }
                                            if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                                strShowComment = "";
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000">' + strResult[i].Remarks + '</textarea></td>';
                                            }
                                        }
                                        else {
                                            if (strResult[i].SingleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000"></textarea></td>';
                                            }
                                            if (strResult[i].MultipleSelection == true) {
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000"></textarea></td>';
                                            }
                                            if (strResult[i].IsDropdown == true || (strResult[i].SingleSelection == false && strResult[i].MultipleSelection == false)) {
                                                strShowComment = "";
                                                strShowComment += '<td><textarea rows="2" cols="50" class="form-control" id="txt' + strResult[i].ProjectChecklistItemId + '"maxlength="1000"></textarea></td>';
                                            }
                                        }
                                    }
                                }
                                if (GblJval + 1 < strResult.length) {
                                    lngTempQuestionID = strResult[GblJval + 1].ProjectChecklistItemId;
                                }
                            }

                            if (GlobalDropdownID == 1) {
                                if (strHTML != "" && strQuestionWithOption1 != "") {
                                    strHTML += '<td>' + strQuestionWithOption1 + '</td>' + strShowComment + '</tr>';
                                    //$("#tblProjectReviwCheckList").append(strHTML);
                                    //$("#tblProjectReviwCheckList_Body").append(strHTML);
                                    //strHTML = '';
                                    strQuestionWithOption1 = '';
                                    strShowComment = '';
                                    GblResponseval = 0;
                                    GlobalDropdownID = 0;
                                }
                            } else {
                                if (strHTML != "" && strQuestionWithOption != "") {
                                    strHTML += '<td>' + strQuestionWithOption + '</td>' + strShowComment + '</tr>';
                                    //$("#tblProjectReviwCheckList").append(strHTML);
                                    // $("#tblProjectReviwCheckList_Body").append(strHTML);
                                    //strHTML = '';
                                    strQuestionWithOption = '';
                                    strShowComment = '';
                                    GblResponseval = 0;
                                }
                            }

                        }
                        //$("#tblProjectReviwCheckList_Body").append(strHTML);
                        $("#tblProjectReviwCheckList_Body").html(strHTML);

                    }

                    $('#tblProjectReviwCheckList').dataTable({
                        // "scrollY": true,
                        // "scrollX": true,
                        "paging": false,
                        //"pageLength": 10,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "destroy": false,
                        "retrieve": true,
                        "bFilter": false,
                        "bAutoWidth": false,
                        "ordering": false,
                        "info": false,
                        "language": {
                            "emptyTable": "No Checklist is defined for this review."
                        }
                    });
                },
                error: function (ER) {
                    console.log(ER);
                }

            })
            StopAjaxLoader("#bodyPMProjectReview");
        }


        var ProjectCheckListItemID = new Array();
        var AllSelectedval = "";
        //Function for save the Checklist Responses.
        function SaveProjectReviewCheckListResponse() {
            ////debugger;
            GetCorporateReviewIssueMapping();
            var IsHaveStatus = GetCorporateReviewDefaultStatus(GblIssueType);
            var IsHaveType = GetCorporateReviewDefaultType(GblIssueType);
            if (IsHaveStatus == 0 || IsHaveType == 0) {
                showAlert('<%= MyBase.GetResourceString("C_No_default_issue_status_type_alert")%>', 'alert-danger');
            }
            else {
                //End of addition by Chetan M. on 18th Dec 2019
                //////////debugger
                var NegativeResponseID = '-1';
                //StartLoader("#bodyPMProjectReview");
                ProjectCheckListItemID.length = 0;
                var TableRows = $('#tblProjectReviwCheckList> tbody > tr');
                for (var i = 0; i < TableRows.length; i++) {
                    var RowData = TableRows[i].innerHTML;
                    var Td = $(RowData).first();
                    var QuestionID = Td[0].childNodes[0].id;
                    var ResponsesLength = Td.children().length;
                    var RadioResponses = $(RowData).find('input[type="radio"]').length;
                    var MultipleResponses = $(RowData).find('input[type="checkbox"]').length;
                    if (RowData.indexOf('type="radio"') > -1) {
                        if (RowData.indexOf('disabled="disabled"') > -1) {

                        }
                        else {
                            AllSelectedval = "";
                            for (var j = 0; j < RadioResponses; j++) {
                                var RadioButtonId = Td.prevObject[1].childNodes[j].childNodes[1].id;
                                if ($("#" + RadioButtonId).is(':checked')) {
                                    var Selectedval = $("#" + RadioButtonId).val();
                                    AllSelectedval += ',' + Selectedval + '';
                                }
                                if (Td.prevObject[1].childNodes[j].innerHTML.indexOf('</b>') > -1) {
                                    var NegativeResponseID = $("#" + RadioButtonId).val();
                                }
                            }
                            if (RowData.indexOf('style="color: red;"') > -1) {
                                if (AllSelectedval == "") {
                                    showAlert('<%= MyBase.GetResourceString("C_Manditory_CheckList_alert")%>', 'alert-danger');
                            //StopAjaxLoader("#bodyPMProjectReview");
                            ProjectCheckListItemID.length = 0;
                            break;
                        }
                    }
                    if (AllSelectedval != "") {
                        var TextboxVal = $("#txt" + QuestionID).val();
                        var FinalData = QuestionID + "=" + AllSelectedval + "=" + TextboxVal + "=" + NegativeResponseID;
                        NegativeResponseID = '-1';
                        ProjectCheckListItemID.push(FinalData);
                    }
                }
            }                    
            // Added by Vishal Mane on 02/01/2025 to insert/update DropDown responses for Checklist customization
            else if (RowData.indexOf('type="dropdown"') > -1) {
                if (RowData.indexOf('disabled="disabled"') > -1) {

                }
                else {
                    var AllSelectedval = "";
                    var dropdownId = "";
                    var dropdownName = "";
                    for (var j = 0; j < ResponsesLength; j++) {
                        dropdownId = Td.prevObject[1].childNodes[j].childNodes[0].id;
                        dropdownName = Td.prevObject[1].childNodes[j].childNodes[0].name;
                        var selectedValue = $("#" + dropdownId).val();
                        var selectedOptionId = $("#" + dropdownId + " option:selected").attr("id");
                        var selectedOptionName = $("#" + dropdownId + " option:selected").attr("name");
                        if (selectedValue != "0") {
                            AllSelectedval += "," + selectedValue;
                        }
                        else {
                            AllSelectedval = "0";
                        }
                        if (selectedOptionId == "1") {
                            NegativeResponseID = selectedValue;
                        }
                    }
                    if (RowData.indexOf('style="color: red;"') > -1) {
                        if (AllSelectedval == "0") {
                            showAlert('<%= MyBase.GetResourceString("C_Manditory_CheckList_alert")%>', 'alert-danger');
                            ProjectCheckListItemID.length = 0;
                            $("#" + dropdownId).focus();
                            // StopAjaxLoader("#bodyPMProjectReview");
                            break;
                        }
                    }
                    if (AllSelectedval != "") {
                        var TextboxVal = $("#txt" + QuestionID).val();
                        var FinalData = QuestionID + "=" + AllSelectedval + "=" + TextboxVal + "=" + NegativeResponseID;
                        NegativeResponseID = '-1';
                        ProjectCheckListItemID.push(FinalData);
                    }
                }
            }
            // End of Added by Vishal Mane on 02/01/2025 to insert/update DropDown responses for Checklist customization
            else {
                AllSelectedval = "";
                for (var j = 0; j < MultipleResponses; j++) {
                    var CheckBoxId = Td.prevObject[1].childNodes[j].childNodes[0].id;
                    if ($("#" + CheckBoxId).is(':checked')) {
                        var Selectedval = $("#" + CheckBoxId).val();
                        AllSelectedval += ',' + Selectedval + '';
                    }

                    if (Td.prevObject[1].childNodes[j].innerHTML.indexOf('</b>') > -1) {
                        NegativeResponseID = $("#" + CheckBoxId).val();
                    }

                }
                // Trim leading comma from AllSelectedval if necessary
                // AllSelectedval = AllSelectedval.replace(/^,/, '');
                if (RowData.indexOf('style="color: red;"') > -1) {
                    if (AllSelectedval == "") {
                        showAlert('<%= MyBase.GetResourceString("C_Manditory_CheckList_alert")%>', 'alert-danger');
                                ProjectCheckListItemID.length = 0;
                                // StopAjaxLoader("#bodyPMProjectReview");
                                break;
                            }
                        }
                        if (AllSelectedval != "") {
                            var TextboxVal = $("#txt" + QuestionID).val();
                            var FinalData = QuestionID + "=" + AllSelectedval + "=" + TextboxVal + "=" + NegativeResponseID;
                            ProjectCheckListItemID.push(FinalData);
                        }
                    }
                }
                if (ProjectCheckListItemID.length != 0) {
                    //////////debugger
                    StartLoader("#bodyPMProjectReview");
                    DeleteCheckListeResponses();
                    GetCorporateReviewIssueMapping();
                    for (var i = 0; i < ProjectCheckListItemID.length; i++) {
                        var ObjChekListItem = ProjectCheckListItemID[i];
                        var CheckListResponseData = ObjChekListItem.split("=");
                        var ProjectChecklistItemId = CheckListResponseData[0];
                        var ResponseId = CheckListResponseData[1];
                        ResponseId = ResponseId.substring(1, ResponseId.length);
                        var Remark = CheckListResponseData[2];
                        var NegativeResponseId = CheckListResponseData[3];
                        var ArrResponce = ResponseId.split(',');
                        for (var j = 0; j < ArrResponce.length; j++) {
                            var ResponseID = ArrResponce[j];
                            var ClosureParameter = {
                                ProjectID: encodeURI(ProjectID),
                                ReviewStaticID: encodeURI(GblReviewStaticID),
                                ProjectCheckListItemId: encodeURI(ProjectChecklistItemId),
                                ResponseId: encodeURI(ResponseID),
                                Remarks: encodeURI(replaceAllChar(Remark)),
                                UserName: encodeURI(UserName),
                                NegativeResponseId: encodeURI(NegativeResponseId),
                                IssueType: encodeURI(GblIssueType),
                                IssueSubType: encodeURI(GblIssueSubType),
                                CorporateSubType: encodeURI(GblIssueCorpSubType),
                                Staus: encodeURI(replaceAllChar(GblIssueStatus)),
                                CorporateStaus: encodeURI(GblIssueCorpStatus),
                            }
                            var param = JSON.stringify(ClosureParameter);
                            var strResult = AJAXCallWithResult("/api/PM_Project_Review/SaveCheckListResponse", param, false);
                        }
                        StopAjaxLoader("#bodyPMProjectReview");
                        if (i == ProjectCheckListItemID.length - 1 && strResult == null) {
                            showAlert("<%= MyBase.GetResourceString("C_Saved_Responses_Successfully")%>", 'alert-success');
                    GetChecklistIssue(hiddenReviewStatasticID);
                    PlotProjectReviewChecklist(GblReviewStaticID, GblChecklistTypeID, UserName);
                }
                else if (i == ProjectCheckListItemID.length - 1 && strResult > 0) {
                    showAlert("<%= MyBase.GetResourceString("C_Saved_Responses_Successfully")%>", 'alert-success');
                            GetChecklistIssue(hiddenReviewStatasticID);
                            PlotProjectReviewChecklist(GblReviewStaticID, GblChecklistTypeID, UserName);
                        }
                    }
                }
            }
        }

        //Function for delete the checklist responses.
        function DeleteCheckListeResponses() {
            var ChecklistParameter = {
                ReviewStaticID: encodeURI(GblReviewStaticID),
                UserName: encodeURI(UserName)
            }

            $.ajax({
                url: strUrl + '/api/PM_Project_Review/DeleteCheckListeResponses',
                type: "POST",
                data: JSON.stringify(ChecklistParameter),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ChecklistParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ChecklistParameter) ? ChecklistParameter : JSON.stringify(ChecklistParameter)));
                    }
                },
                success: function (result) {
                    //alert(result);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


        function GetCorporateReviewIssueMapping() {

            $.ajax({
                url: strUrl + '/api/PM_Project_Review/GetCorporateReviewIssueMapping',
                type: "POST",
                data: JSON.stringify(GblCReviewTypeID),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (GblCReviewTypeID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(GblCReviewTypeID) ? GblCReviewTypeID : JSON.stringify(GblCReviewTypeID)));
                    }
                },
                success: function (result) {
                    if (result.length != 0) {
                        GblIssueType = result[0].Type;
                        GetCorporateReviewDefaultStatus(result[0].Type);
                        GetCorporateReviewDefaultType(result[0].Type);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //Added by Chetan M. on 18th Dec 2019
        var IsReviewHaveDefaultStatus = 0;
        var IsReviewHaveDefaultType = 0;
        //End of addition by Chetan M. on 18th Dec 2019
        function GetCorporateReviewDefaultStatus(Type) {
            //Added by Riddhesh Patil 0n 12 April 2023
            if (Type == null) {
                Type="0"
            }
            //End of Added by Riddhesh Patil 0n 12 April 2023
            var ChecklistParameter = {
                Type: encodeURI(Type),
                ProjectID: parseInt(ProjectID)
            }
            $.ajax({
                url: strUrl + '/api/PM_Project_Review/GetCorporateReviewDefaultStatus',
                type: "POST",
                data: JSON.stringify(ChecklistParameter),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ChecklistParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ChecklistParameter) ? ChecklistParameter : JSON.stringify(ChecklistParameter)));
                    }
                },
                success: function (result) {
                    //Commented and added by Chetan M. on 18th Dec 2019
                    //if (result.length != 0) {
                    //    GblIssueStatus = result[0].Status;
                    //    GblIssueCorpStatus = result[0].CorporateStatus;
                    //}
                    if (result.length != 0) {
                        IsReviewHaveDefaultStatus = 1;
                        GblIssueStatus = result[0].Status;
                        GblIssueCorpStatus = result[0].CorporateStatus;
                    }
                    else {
                        IsReviewHaveDefaultStatus = 0;
                    }
                    //End of addition by Chetan M. on 18th Dec 2019
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //Added by Chetan M. on 18th Dec 2019
            return IsReviewHaveDefaultStatus;
            //End of addition by Chetan M. on 18th Dec 2019
        }


        function GetCorporateReviewDefaultType(Type) {
            //Added by Riddhesh Patil on 12 April 2023
            if (Type == null) {
                Type = "0";
            }
            //End of Added by Riddhesh Patil on 12 April 2023
            var ChecklistParameter = {
                Type: encodeURI(Type),
                ProjectID: parseInt(ProjectID)
            }
            $.ajax({
                url: strUrl + '/api/PM_Project_Review/GetCorporateReviewDefaultType',
                type: "POST",
                data: JSON.stringify(ChecklistParameter),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ChecklistParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ChecklistParameter) ? ChecklistParameter : JSON.stringify(ChecklistParameter)));
                    }
                },
                success: function (result) {
                    //Commented and added by Chetan M. on 18th Dec 2019
                    //if (result.length != 0) {
                    //    GblIssueSubType = result[0].SubType;
                    //    GblIssueCorpSubType = result[0].CorporateSubType;
                    //}
                    if (result.length != 0) {
                        IsReviewHaveDefaultType = 1;
                        GblIssueSubType = result[0].SubType;
                        GblIssueCorpSubType = result[0].CorporateSubType;
                    }
                    else {
                        IsReviewHaveDefaultType = 0;
                    }
                    //End of addition by Chetan M. on 18th Dec 2019
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //Added by Chetan M. on 18th Dec 2019
            return IsReviewHaveDefaultType;
            //End of addition by Chetan M. on 18th Dec 2019
        }


        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                }
            });
            return ajaxResult;
        }


        //End Of addition By Chetan M.

        //start by Vishal Mahajan 17-12-2019
        function getCurrentDate() {
            $.ajax({
                url: strUrl + '/api/PM_Project_Review/GetCurrentDate',
                type: "POST",
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    if (result != "") {
                        var dt = new Date(result);
                        currentDateWithTime = dt;
                        //alert(dt);
                        //alert(new Date());
                        currentDate = new Date(dt.getFullYear(), dt.getMonth(), dt.getDate());
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function GetChecklistIssue(ReviewStatisticsID) {

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetCheckListIssues',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(ReviewStatisticsID),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ReviewStatisticsID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ReviewStatisticsID) ? ReviewStatisticsID : JSON.stringify(ReviewStatisticsID)));
                    }
                },
                success: function (result) {
                    $('#tbodyChecklistIssues').html("");
                    $('#lblTotalChcklistIssueCount').text("Total Records " + result.length);
                    var tableBody = "";
                    for (var i = 0; i < result.length; i++) {
                        tableBody = tableBody +
                            '   <tr>' +
                            '   <td><a href="javascript:;" class="RreqID"><span data-bs-toggle="tooltip" title="" class="idlabel">' + result[i].IssueID + '</span></a> </td>' +
                            '   <td>' + result[i].Type + '</td>' +
                            '   <td class="text-start">' + result[i].Summary + '</td>' +
                            '   <td>' + result[i].Status + '</td>' +
                            '   /tr>';

                    }
                    $('#tbodyChecklistIssues').append(tableBody);
                },
                error: function (ER) {
                    console.log(ER);
                }
            })

        }


        //end by Vishal Mahajan 17-12-2019


        //Get Documents List
        function GetDocumentsList(ReviewStatisticsID, TagID) {

            $('[data-bs-toggle="tooltip"]').tooltip();
            var PMParameters = {
                UniqueID: ReviewStatisticsID,
                TagID: encodeURI(TagID),
                RoleID: encodeURI('<%= Session("intPostID") %>')

            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetDocumentsList',
                method: 'Post',
                data: JSON.stringify(PMParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParameters) ? PMParameters : JSON.stringify(PMParameters)));
                    }
                },
                success: function (result) {
                    StartLoader("#bodyPMProjectReview");
                    var category = new Array();
                    var IsData = 0;
                    $("#PRattachmentBody").html("");

                    var strHTML = "";
                    for (var i = 0; i < result.length; i++) {
                        var data = result[i];
                        category.push(data.Category);
                    }
                    category = category.filter(
                        function (a) { if (!this[a]) { this[a] = 1; return a; } },
                        {}
                    );
                    for (var j = 0; j < category.length; j++) {
                        //    alert(category.length);
                        IsData = 1;
                        strHTML += '<tr><td>' + category[j] + '</td><td></td><td></td><td></td><td></td><td></td><td></td></tr>'
                        for (var i = 0; i < result.length; i++) {
                            var data = result[i];
                            if (category[j] == data.Category) {
                                var data = result[i];
                                strHTML += '<tr>'
                                strHTML += '<td> </td>'
                                if (data.SubCategory != null) {
                                    strHTML += '<td> ' + data.SubCategory + '</td>'
                                } else {
                                    strHTML += '<td> </td>'
                                }
                                strHTML += '<td> <a  href="javascript:;" onclick="downloadfile(' + data.DocumentID + ',' + ProjectID + ',2191)">' + data.FileName + '</a> </td>'
                                if (data.Description.length < 20) {
                                    strHTML += '<td data-bs-toggle="tooltip"  data-bs-container="body" title="' + data.Description + '"> ' + data.Description + '</td>'
                                }
                                else {
                                    var str = data.Description.substring(0, 20);
                                    strHTML += '<td data-bs-toggle="tooltip"  data-bs-container="body" title="' + data.Description + '"> ' + str + '....</td>'

                                }
                                strHTML += '<td> ' + data.FileSize.toFixed(2) + '</td>'
                                strHTML += '<td> ' + data.UploadedDate + '</td>'
                                if (m_DeleteAccess == "True") {
                                    strHTML += '<td> ' + '<button class="nostylebtn delattachbtn" title="" onclick="DeletedAttachment(' + data.DocumentID + ')"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete" class="far fa-trash-alt"></i></button></td>'
                                } else {
                                    strHTML += '<td> </td>'
                                }
                                strHTML += '</tr>'

                            }
                        }

                    }
                    // 
                    if (IsData == 0) {
                        $("#PRUpload").prop("disabled", true);
                    }
                    $("#PRattachmentBody").append(strHTML);
                    StopAjaxLoader("#bodyPMProjectReview");
                    category = [];

                    //Added By Reshma on 19 March 2020 For IssueID-23427
                    if ($('#CboReviewStatus option:selected').text() == "Closed") {
                        $("#PRaddattachnebtrow").prop('disabled', true);
                        $(".delattachbtn").css('pointer-events', 'none');

                    }
                    else {
                        $("#PRaddattachnebtrow").prop('disabled', false);
                        $(".delattachbtn").css('pointer-events', 'auto');

                    }
                    //End of Added By Reshma on 19 March 2020 For IssueID-23427

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }
        function downloadfile(DocumentID, ProjectID, MasterTagID) {
            var strTemp = '../../PM/PM_ViewDocument.aspx?FromWhere=PM&MasterTagID=' + MasterTagID + '&DocumentID=' + DocumentID + '&ProjectID=' + ProjectID + '';
            window.open(strTemp);
        }


        //added by Parth Godshelwar
        async function validateForExe(file){
            if (!file) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select File");
                return
            }
            //var fileData =file;
            //console.log(fileData);
            //added by Parth Godshelwar
            var objFile = file;
            var fileName = objFile.files[0].name;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


            isValidTypeExeCheck = false;
            //Commented and Added by Aditya J. on 25-11-2024
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            //End of comment Added by Aditya J. on 25-11-2024
            isValidTypeExeCheck = ValidExtsExe.includes(extension);

            if (isValidTypeExeCheck) {
                const file = objFile.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        //alert("File is valid and ready to upload.");
                    })
                    .catch(error => {
                        //Added by Ajit L on 21/11/2024
                        var fileInput = objFile;
                        var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                        // Before clearing:
                        console.log("Selected files before clearing:", fileInput.files);
                        $(fileInput).val(""); // Clear the file input
                        fileNameInput.val(""); // Clear the file name text input
                        //End of Added by Ajit L on 21/11/2024
                        console.log(error);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;
                        $(objFile).val("");
                        /*$(objFileName).attr("placeholder", "Upload File");*/
                        //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                        return;
                    });



                if (!isValidTypeExeCheck) {
                    return;
                }
            }

            //$(objtxtFileName).val("");

            //Ended by Parth Godshelwar

        }

        //add attachment
        var i = "1";
        var j = "1";
        var k = "1";
        var l = "1";
        var counter = 0;
        var PRCounter = 0;
        $("#PRaddattachnebtrow").on("click", function () {
            var newRow = $("<tr class='attachments'>");
            var cols = "";
            cols = '<td><select  style="width: 90%;" id="PRasdCat' + PRCounter + '" class="form-select" onchange="PRCategoryOnChange(this.id,this);"><option></option></select><span style="color:red;float: right;margin-top: -25px;">*</span></td>';
            cols += '<td><select id="PRasdsubCat' + PRCounter + '" class="form-select"><option value="0">Select Sub Category</option></select></td>';
            //added by Parth Godshelwar onchange event for validating exe file
            //cols += '<td><input id="PRAfilname' + PRCounter + '" type="file" name="img[]" class="file" onchange="validateForExe(this)" > <div class="input-group col-xs-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button"><i class="fas fa-paperclip" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Select File"></i></button></span><input type="text" class="form-control" disabled="" placeholder="Upload Files"></td>'
            cols += '<td><input id="PRAfilname' + PRCounter + '" type="file" name="img[]" class="file" onchange="validateForExe(this)" > <div class="input-group col-xs-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button"><i class="fas fa-paperclip" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Select File"></i></button></span><input id="FileName' + PRCounter + '" type="text" class="form-control" disabled="" placeholder="Upload Files"></td>' //Id Added by Ajit L on 22/11/2024
            //ended by Parth Godshelwar onchange event for validating exe file
            cols += '<td><textarea rows="4" cols="50" id="PRadescription' + PRCounter + '" class="form-control" maxlength="100" placeholder=""></textarea></td>';
            cols += '<td></td>';
            cols += '<td></td><td><button class="ibtnDel nostylebtn" title="Remove" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Delete"><i class="fa fa-times" value="Delete" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Remove"></i></button></td>';
            newRow.append(cols);
            //  $("#PRadescription" + PRCounter).text("");
            $("table.order_attchmentlist").append(newRow);
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('table.order_attchmentlist').find('.attachdate').datepicker();
            //  
            GetDocumnetCategoryList("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + PRCounter);

            i++;
            j++;
            k++;
            l++;
            counter++;
            PRCounter++;
            $(".delattachbtn").prop('disabled', true);
            $(".delattachbtn").css("cursor", "not-allowed");
            $("#PRUpload").prop('disabled', false);
        });
        // var IsRemove = 0;
        $("table.order_attchmentlist").on("click", ".ibtnDel", function (event) {
            $(this).closest("tr").remove();
            counter = counter - 1;
            PRCounter = PRCounter - 1;
            if ($(".attachments").find(".ibtnDel").length == 0) {
                $(".delattachbtn").prop('disabled', false);
                $(".delattachbtn").css("cursor", "pointer");
                $("#PRUpload").prop('disabled', true);
            } else {
                $(".delattachbtn").prop('disabled', true);
                $(".delattachbtn").css("cursor", "not-allowed");
                $("#PRUpload").prop('disabled', false);
            }
        });




        //get Document Category List
        function GetDocumnetCategoryList(cboId) {

            var PMParameters = {
                ProjectID: encodeURI(ProjectID),
                RoleID: encodeURI('<%= Session("intPostID") %>')
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetDocumnetCategoryList',
                method: 'Post',
                data: JSON.stringify(PMParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParameters) ? PMParameters : JSON.stringify(PMParameters)));
                    }
                },
                success: function (strResult) {
                    //   alert(strResult.length);
                    $(cboId).empty();
                    //  
                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value=0 > Select Category </option>";
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var CategoryID = d.CategoryID;
                            var Category = d.Category;
                            selHTML += "<option  value='" + CategoryID + "' >" + Category + "</option>";
                        }


                        $(cboId).html(selHTML);
                        $('[data-bs-toggle="tooltip"]').tooltip();

                    }


                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        //category onchange
        function PRCategoryOnChange(id, val) {

            var subcategoryid = id;
            var addstr = "sub";
            var position = 5;
            subcategoryid = [subcategoryid.slice(0, position), addstr, subcategoryid.slice(position)].join('');
            var category = val.value;
            //Comment and added by Riddhesh on 3 March 2023
            //GetPRDocumnetSubCategoryList(subcategoryid, category, null);
            GetPRDocumnetSubCategoryList(subcategoryid, category, 0);
            //Comment and added by Riddhesh on 3 March 2023
        }

        //get Document sub Category List
        function GetPRDocumnetSubCategoryList(SubCategoryId, Category, SubCategory) {
            var AttachmentDocuments = {
                Category: encodeURI(Category),
                SubCategory: encodeURI(SubCategory),
                ProjectID: encodeURI(ProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/GetDocumnetSubCategoryList',
                method: 'Post',
                data: JSON.stringify(AttachmentDocuments),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (AttachmentDocuments) {
                        xhr.setRequestHeader("Params", encryptString(isJson(AttachmentDocuments) ? AttachmentDocuments : JSON.stringify(AttachmentDocuments)));
                    }
                },
                success: function (strResult) {
                    $("#PRattachmentBody > tr > td:nth-child(2)>select#" + SubCategoryId).empty();
                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value=0 > Select Sub Category </option>";
                        for (var i = 0; i < strResult.length; i++) {
                            var d = strResult[i];
                            var SubCategoryID = d.SubCategoryID;
                            var SubCategory = d.SubCategory;
                            selHTML += "<option  value='" + SubCategoryID + "' >" + SubCategory + "</option>";
                        }
                        $("#PRattachmentBody > tr > td:nth-child(2)>select#" + SubCategoryId).html(selHTML);
                        $('[data-bs-toggle="tooltip"]').tooltip();


                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }

        $(document).on('click', '.browse', function () {
            var file = $(this).parent().parent().parent().find('.file');
            file.trigger('click');
        });

        $(document).on('change', '.file', function () {
            $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        });


        //$("#PRUpload").click(function () {
        $(document).on('click', "#PRUpload", function () {
            //debugger
            var chkCategory;
            Flag = true;
            var formdata = new FormData();
            var LoginType = '<%= Session("LoginType") %>';
            var UserName = '<%= Session("strUserName") %>';
            var AttachedFileData = new Array();
            var Files = new Array();
            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var CategoryName;
            var SubCategoryName;
            var Category;
            var SubCategory;
            var PMParameters = {
                UserID: UserID,
                LoginType: LoginType,
                ProjectID: ProjectID,
                RoleID: '<%= Session("intpostID") %>',
                TagID: 2191,
                UniqueID: hiddenReviewStatasticID,
            };
            //Added By Rehan C To add Validator for Special characters on 11th Nov 2022
            var AttachDesc = $("#PRadescription0").val();
            if (checkSpecialCharacter(AttachDesc, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#PRadescription0").focus();
                return false
            }

            $('#PRattachmentBody > tr.attachments').each(function (index, value) {

                var Description = "";
                var File;
                var Date = "";
                var allColumns = $(this).find('td');

                $(allColumns).each(function (i, v) {
                    if (i == 0) {
                        if (Flag == true) {

                            var id = $(this).find('*[id*=PRasdCat]').attr("id");
                            var curCatIndex = 0;
                            curCatIndex = id.replace(/PRasdCat/g, "");

                            CategoryName = $("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + (curCatIndex) + " option:selected").text();
                            Category = $("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + (curCatIndex)).val();
                            if (Flag == true) {
                                if (Category == 0) {
                                    showAlert("Please Select Category ", "alert-danger");
                                    $("#PRattachmentBody > tr > td:nth-child(1)>select#PRasdCat" + (curCatIndex)).focus();
                                    Flag = false;

                                }
                            }
                        }
                    }
                    if (i == 1) {
                        var id = $(this).find('*[id*=PRasdsubCat]').attr("id");
                        var curCatIndex = 0;
                        curCatIndex = id.replace(/PRasdsubCat/g, "");
                        SubCategoryName = $("#PRattachmentBody > tr > td:nth-child(2)>select#PRasdsubCat" + (curCatIndex) + " option:selected").text();
                        SubCategory = $("#PRattachmentBody > tr > td:nth-child(2)>select#PRasdsubCat" + (curCatIndex)).val();
                    }

                    if (Flag == true) {
                        if (i == 2) {
                            var id = $(this).find('*[id*=PRAfilname]').attr("id");
                            var curCatIndex = 0;
                            curCatIndex = id.replace(/PRAfilname/g, "");
                            var id = $('#PRattachmentBody > tr > td:nth-child(3)>#PRAfilname' + (curCatIndex));
                            var getfileName = id[0].files[0];
                            Flag = PRValidateAttachment('PRAfilname' + (curCatIndex), id);
                            formdata.append("file" + curCatIndex, getfileName);

                        }

                        if (i == 3) {
                            Description = $(this).find('textarea').val().trim();

                        }
                    }
                });
                var item = {
                    Description: Description,
                    CategoryName: CategoryName,
                    Category: Category,
                    SubCategoryName: SubCategoryName,
                    SubCategory: SubCategory,
                    PMParameters: PMParameters,
                    UniqueID: hiddenReviewStatasticID,
                }
                AttachedFileData.push(item);
            });
            formdata.append("AttachedFileData", JSON.stringify(AttachedFileData));
            StartLoader("#bodyPMProjectReview");
            if (Flag == true) {
                $.ajax({
                    url: strUrl + '/api/PM_Project_Review/InsertDocumnetAttachment',
                    type: "POST",
                    dataType: "json",
                    data: formdata,
                    contentType: false,
                    processData: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (result) {
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        if (result == 'File Uploaded Successfully') {
                            showAlert(result, 'alert-success');
                            $('#PRattachmentBody > tr.attachments').each(function (index, value) {
                                $(this).remove();
                            });
                            counterFORattachment = 0;
                            counter = 0;
                            PRCounter = 0;
                            i = "1";
                            j = "1";
                            k = "1";
                            l = "1";
                            $("#PRattachmentBody").empty();
                            GetDocumentsList(hiddenReviewStatasticID, 2191);
                            $('[data-bs-toggle="tooltip"]').tooltip();
                        }
                        else {
                            $(".Stakeholdertbl").find("tr").removeClass("tropen");
                            $("#stakedetailpanel .main_graybgtbs li:nth-child(2) a, #stakedetailpanel .main_graybgtbs li:nth-child(3n) a").css("cursor", "pointer");
                            $("#stakedetailpanel").hide('fast');
                            $("#hidestaklist").show('fast');
                            showAlert(result, "alert-danger");
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            StopAjaxLoader("#bodyPMProjectReview");
        });

        function PRValidateAttachment(fileid, filePath) {
            var ValidateAttachmentFlag = true;
            var objFileName = document.getElementById(fileid);
            if (filePath.get(0).files['0'] != undefined) {
                if (objFileName != null && objFileName != undefined) {
                    if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                    if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                    var countOfDot, FileNameCharCount;
                    var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
                    var intActualFileSize = (filePath.get(0).files['0'].size);
                    //Added By Rutuja D. on 2 Feb 2021 For MaxFileSize Declaration
                    var intMaxFileSize = '<%=ConfigurationManager.AppSettings("MaxFileSize")%>'
                    //End Added By Rutuja D. on 2 Feb 2021 For MaxFileSize Declaration

                    if (filePath.get(0).files['0'].name != '')
                        var countOfDot = filePath.get(0).files['0'].name.split(".").length - 1;

                    if (countOfDot > 1) {
                        showAlert('File with two or more extensions is not allowed!', "alert-danger");
                        ValidateAttachmentFlag = false;
                        return false;
                    }

                    if (filePath.get(0).files['0'].name != '')
                        FileNameCharCount = filePath.get(0).files['0'].name.split(".")[0].length;

                    if (FileNameCharCount > 120) {

                        showAlert('File name should not exceed 120 characters!', "alert-danger");
                        ValidateAttachmentFlag = false;
                        return false;
                    }

                    if (intActualFileSize < intMinFileSize) {
                        showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', "alert-danger");
                        ValidateAttachmentFlag = false;
                        return false;
                    }
                    // Added By Rutuja D. on 2 Feb 2021 For Excceded File size Validation 
                    if (intMaxFileSize < intActualFileSize) {
                        showAlert('File size should not be greater than or equal to ' + intMaxFileSize + ' bytes !', "alert-danger");
                        ValidateAttachmentFlag = false;
                        return false;
                    }
                    //End Added By Rutuja D. on 2 Feb 2021 For Excceded File size Validation
                }
            }
            else {
                showAlert('Please Select  File', "alert-danger");
                return false;
            }

            return ValidateAttachmentFlag;
        }

        function DeleteData() {

            var tagid = $("#TagId").attr("value");
            var deleteid = $("#DeleteId").attr("value");
            var deleteDocumnetid = $("#DeleteDocumnetId").attr("value");
            StartLoader("#bodyPMProjectReview");
            if (deleteDocumnetid != undefined) {
                if (tagid == 2191 && deleteDocumnetid.length != null && deleteDocumnetid.length != undefined) {
                    DeleteDocumentById(deleteDocumnetid);
                    $("#DeleteDocumnetId").removeAttr("value");
                }
            }
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");

            });
            clearTooltip();
            StopAjaxLoader("#bodyPMProjectReview");
        }

        //Delete Attachment
        function DeletedAttachment(DocumnetId) {
            $("#TagId").attr('value', 2191);
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('#DeleteDocumnetId').attr('value', DocumnetId);
            $("#deletemodal").modal("show");
            clearTooltip();
        }

        function DeleteDocumentById(documentId) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/DeleteDocumnet',
                method: 'Post',
                data: JSON.stringify(encodeURI(documentId)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (documentId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(documentId) ? documentId : JSON.stringify(documentId)));
                    }
                },
                success: function (strResult) {
                    //Commented And Added By Reshma on 26th Dec 2019 For IssueID-21134
                    //showAlert("Attachment Deleted Suceessfully", 'alert-success');
                    showAlert("Attachment Deleted Successfully", 'alert-success');
                    //End Added By Reshma on 26th Dec 2019 For IssueID-21134

                    GetDocumentsList(hiddenReviewStatasticID, 2191);
                    $('[data-bs-toggle="tooltip"]').click(function () {
                        $('[data-bs-toggle="tooltip"]').tooltip("hide");
                    });
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        }


        // end attachment by vishal Mahajan 18-12-2019


        function getProjectEstimatedEfforts() {

            if (ProjectID == "" || ProjectID == "0") {
                projectWorkHours = 0;
            } else {
                $.ajax({
                    url: strUrl + '/api/PM_Project_Review/GetProjectEstimatedEfforts',
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(ProjectID),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                        }
                    },
                    success: function (result) {
                        //alert(result);
                        projectWorkHours = result;
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
        }

        //Added By Reshma on 30 th Dec 2019 For IssueID-21123
        function getTotalReviewEfforts(ReviewStatisticsid) {

            if (ReviewStatisticsid == "") {
                ReviewStatisticsid = 0;
            }
            else {
                ReviewStatisticsid = ReviewStatisticsid;
            }

            var project_Review = {
                ProjectId: encodeURI(ProjectID),
                ReviewStatisticsID: encodeURI(ReviewStatisticsid),
            }

            $.ajax({
                url: strUrl + '/api/PM_Project_Review/GetTotalReviewEfforts',
                type: "POST",
                dataType: "json",
                data: JSON.stringify(project_Review),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (project_Review) {
                        xhr.setRequestHeader("Params", encryptString(isJson(project_Review) ? project_Review : JSON.stringify(project_Review)));
                    }
                },
                success: function (result) {

                    TotalReviewEfforts = result;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }
        //End Added By Reshma on 30 th Dec 2019 For IssueID-21123
        function getDefaultTimeZone() {


            $.ajax({
                url: strUrl + '/api/PM_Project_Review/GetDefaultTimeZone',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                },
                success: function (result) {
                    defaultTimeZone = result;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });

        }


        function isAgileMethodFollowed() {
            if (ProjectID == "" || ProjectID == "0") {
                projectWorkHours = 0;
            } else {
                $.ajax({
                    url: strUrl + '/api/PM_Project_Review/IsAgileMethodFollowed',
                    type: "POST",
                    dataType: "json",
                    data: JSON.stringify(ProjectID),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectID) ? ProjectID : JSON.stringify(ProjectID)));
                        }
                    },
                    success: function (result) {

                        isAgileMethodused = result;
                        if (isAgileMethodused == 1) {
                            $("#divSprintPlanReview,#divIterationFilter,#divSprint,#divCRIterationFilter").css("display", "inline-block");
                        } else {
                            $("#divSprintPlanReview,#divIterationFilter,#divSprint,#divCRIterationFilter").css("display", "none");
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }

        }

        //status closed  
        function SetStatusClosed() {
            $("#StatusClosedModal").modal("show");
        }

        function HideStatusClosedModel() {
            $("#StatusClosedModal").modal("hide");
        }

        var cause = 0;
        var actionsdescription, actionswork, actionsreviewee, actionstask, actionsissue, actionstracktonextreview, actionsclosed;
        var actionsExistingTaskorIssue;
        $(document).on("click", "#conductActiontbl .ibtnactionCancel", function () {
            //$('[data-bs-toggle="tooltip"]').tooltip('destroy');
            $(".tooltip").tooltip("hide");
            $(".add-new").removeAttr("disabled");
            $('#conductActiontbl .converttoAction').prop('disabled', false);
            $('#conductActiontbl .edit').prop('disabled', false);
            $('#conductActiontbl .delete').prop('disabled', false);

            var isOfflineReview = $('#chkOfflineReviewcr').prop('checked');
            var reviewType = "";
            $(this).parents("tr").find(".add, .edit, .ibtnactionCancel").toggle();
            var trElement = $(this).parents("tr");
            $(trElement).find('td').each(function (index, value) {
                if (index == 0) {
                    //$(this).find('select').prop('disabled', false);
                    var element = $(this).find('select');
                    reviewType = $(element).val();
                    if (reviewType == "Action") {

                        $(element).val('Action');
                        //$(element).trigger('change');
                    }

                }
                if (index == 1) {
                    if (reviewType == "Action") {
                        $(this).find('select').prop('disabled', true);
                        var Causeddl = $(this).find('select');
                        $(Causeddl).val(cause);
                        var SelectedText = $(Causeddl).text().trim();
                    }

                }
                if (index == 2) {
                    $(this).find('textarea').prop('disabled', true);
                    $(this).find('textarea').val(actionsdescription);
                }
                if (index == 3) {

                    var test = $(this).find('.work');
                    $(this).find('.work').prop('disabled', true);
                    $(this).find('.work').val(actionswork);
                }
                if (index == 4) {
                    if (reviewType == "Action") {
                        $(this).find('select').prop('disabled', true);
                        $(this).find('select').val(actionsreviewee);
                    }
                }

                if (index == 5) {
                    var thisControl = $(this).find('.chcktbl');
                    if (reviewType == "Action") {
                        if (isOfflineReview || ExistingTaskorIssue) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        else {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        $(this).find('.chcktbl').prop("checked", actionstask);
                    }
                }
                if (index == 6) {
                    var thisControl = $(this).find('.chcktbl');
                    var ExistingTaskorIssue = $(thisControl).hasClass('existing');

                    if (reviewType == "Action") {
                        if (isOfflineReview || ExistingTaskorIssue) {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        else {
                            $(this).find('.chcktbl').prop('disabled', true);
                        }
                        $(this).find('.chcktbl').prop("checked", actionsissue);
                    }
                }
                if (index == 7) {
                    var thisControl = $(this).find('.chcktbl');
                    var ConvertedObservation = $(thisControl).hasClass('ConvertedObservation');

                    if ((reviewType == "Observation") && (isOfflineReview || ConvertedObservation)) {
                        $(this).find('.chcktbl').prop('disabled', true);
                    }
                    else {
                        $(this).find('.chcktbl').prop('disabled', true);
                    }
                    $(this).find('.chcktbl').prop("checked", actionstracktonextreview);
                }
                if (index == 8) {
                    var thisControl = $(this).find('.chcktbl');
                    var ConvertedObservation = $(thisControl).hasClass('ConvertedObservation');
                    if ((reviewType == "Observation") && (isOfflineReview || ConvertedObservation)) {
                        $(this).find('.chcktbl').prop('disabled', true);
                    }
                    else {
                        $(this).find('.chcktbl').prop('disabled', true);
                    }
                    $(this).find('.chcktbl').prop("checked", actionsclosed);
                }
            });
            $("i,img,span").tooltip({
                placement: 'top'
            });
            $('[data-bs-toggle="tooltip"]').tooltip();
        });

        var isObservationIDExist = false;
        function isReviewObservationIDExist(ObservationID) {

            $.ajax({
                url: strUrl + '/api/PM_Project_Review/IsReviewObservationIDExist',
                type: "POST",
                dataType: "json",
                data: JSON.stringify(ObservationID),
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ObservationID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ObservationID) ? ObservationID : JSON.stringify(ObservationID)));
                    }
                },
                success: function (result) {
                    if (result > 0)
                        isObservationIDExist = true;
                    else
                        isObservationIDExist = false;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        function disallowSpecialforFileCreationCharacters(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }
            var msg = (arguments.length > 1) ? arguments[1] : "";
            msg = replaceSubstring(msg, "&#39;", "'");
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            var spChars = (arguments.length > 3) ? arguments[3] : "[/:'*?+\"><|,\\\\]";
            if (hasSpecialCharacters(getInputValue(obj), spChars)) {
                if (!isBlank(msg)) { alert(msg); }
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }

        //by Vishal Mahajan 28-12-2019
        function SetDeleteAction(ReviewActionID, button) {
            var typeOfReview = $(button)[0].name;
            $('#DeleteReviewActionID').val(ReviewActionID);
            $('#DeleteTypeOfReview').val(typeOfReview);
            $("#deleteactionmodal").modal("show");
        }

        function CancelDeleteAction() {
            $("#deleteactionmodal").modal("hide");
            $("#DeleteReviewActionID").val("0");
            $("#DeleteTypeOfReview").val("0");
        }

        function DeleteAction() {
            var ReviewActionID = $("#DeleteReviewActionID").val();
            var typeOfReview = $("#DeleteTypeOfReview").val();
            if (typeOfReview == "Observation") {
                isReviewObservationIDExist(ReviewActionID);
                if (isObservationIDExist) {
                    showAlert('<%= MyBase.GetResourceString("C_Observation_Not_Be_Deleted") %>', "alert-danger");
                    return;
                }
            }
            if (typeOfReview == "Action") {
                reviewactions = {
                    ReviewActionID: encodeURI(ReviewActionID),
                    ReviewStatisticsID: encodeURI(hiddenReviewStatasticID),
                    TypeOfReview: typeOfReview
                };
            }
            if (typeOfReview == "Observation") {
                reviewactions = {
                    ReviewActionID: encodeURI(ReviewActionID),
                    TypeOfReview: replaceAllChar(typeOfReview)
                };
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Project_Review/DeleteReviewAction',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(reviewactions),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (reviewactions) {
                        xhr.setRequestHeader("Params", encryptString(isJson(reviewactions) ? reviewactions : JSON.stringify(reviewactions)));
                    }
                },
                success: function (result) {
                    CancelDeleteAction();
                    showAlert('<%= MyBase.GetResourceString("C_ReviewActionDelete") %>', "alert-success");
                    GetReviewActions(hiddenReviewStatasticID);
                },
                error: function (ER) {
                    console.log(ER);
                }
            });
        }


        //Added by Parth.G
        //commented by Aditya J. on 25-11-2024
        //function validateDocFileForExe(file) {

        //    return new Promise((resolve, reject) => {
        //        //debugger;

        //        const reader = new FileReader();

        //        reader.onload = function (e) {
        //            const arrayBuffer = e.target.result;
        //            const uint8 = new Uint8Array(arrayBuffer);

        //            // Function to search for a specific byte sequence
        //            const containsSignature = (signature) => {
        //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
        //                    let found = true;
        //                    for (let j = 0; j < signature.length; j++) {
        //                        if (uint8[i + j] !== signature[j]) {
        //                            found = false;
        //                            break;
        //                        }
        //                    }
        //                    if (found) return true;
        //                }
        //                return false;
        //            };

        //            // Check for 'MZ' signature (common for Windows EXE files)
        //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
        //            if (containsSignature(mzSignature)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }

        //            // If no signatures are found, the file is considered safe
        //            resolve();
        //        };

        //        reader.onerror = function () {
        //            reject("Error reading the file. Please try again.");
        //        };

        //        // Read the file as an ArrayBuffer
        //        reader.readAsArrayBuffer(file);
        //    });
        //}
        //End of commented by Aditya J. on 25-11-2024
        //Ended by Parth.G

        $('[data-bs-toggle="tooltip"]').tooltip({
            trigger: 'hover'
        });//added by omkar on 26-12-2019

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });//added by pradip on 26-12-2019

        $('.stackbasicfilter .form-group').contents().filter(function () {
            return this.nodeType === 3;
        }).remove();//script Added by pradip on 31-12-2019

        //Added By Rutuja D. on 3 Jan 2021 For Filter crash was coming because of single quotes added in text field
        function GenerateBasicFilterQuery(module, AllFields) {
            var strqtext = "";
            for (var i = 0; i < AllFields.length; i++) {
                var strvalue = '';
                var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();
                if ($("#txt" + module + "Filter" + AllFields[i]).val() != null) {
                    strvalue = $("#txt" + module + "Filter" + AllFields[i]).val().trim();
                }

                //Comment and added by imran on 17-12-2021 for filter Billable dropdown value=0 means no selected thats why alert getting please select filter
                //if (strvalue != "" && strvalue != "0" && strvalue != null && strvalue != "null") {
                if (strvalue != "" && strvalue != null && strvalue != "null") {
                    //End comment by imran on 17-12-2021
                    if (strqtext != "") strqtext += " AND ";
                    if (strOp == "Contains") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '%"';
                    }
                    else if (strOp == "Ends With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '"';
                    }
                    else if (strOp == "Exact Word") {
                        strqtext += AllFields[i] + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    else if (strOp == "Not Contains") {
                        strqtext += AllFields[i] + " ";
                        strqtext += ' NOT LIKE "%' + strvalue + '%"';
                    }
                    else if (strOp == "Starts With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "' + strvalue + '%"';
                    }
                    else {

                        strqtext += AllFields[i] + " ";
                        strqtext += strOp + ' "' + strvalue + '"';
                    }
                }
            }
            strqtext = strqtext.replace(/'/g, "''");
            return strqtext;
        }
        //End of Added By Rutuja D. on 3 Jan 2021 For Filter crash was coming because of single quotes added in text field
    </script>
    <!--filter-table-->
    <%--added by Vishal Mahajan 15-11-2019--%>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <%--end--%>
</body>

</html>
