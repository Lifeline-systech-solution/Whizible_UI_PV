<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_DerivedMetricReport.aspx.vb" Inherits="Whizible.PM_DerivedMetricReport" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Derived Metric")%> 
<head>
     <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project Status Update - Dev-Maintenance (Waterfall)</title>
     
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
 
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
   
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">


     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/OverlayScrollbars.min.css">   

    <style type="text/css">
        .block_freeze {
            cursor: no-drop !important;
            opacity: 0.5;
        }

        .ui-datepicker {
            z-index: 9999 !important;
            width: max-content;
        }

        .bg_grayTD {
            background-color: #f9f9f9 !important;
        }

        .sticky_col {
            position: -webkit-sticky;
            position: sticky;
            background-color: white;
            z-index: 1;
            border: 1px solid #dee2e6;
        }

        .res_col {
            /* min-width: 250px; */
            width: 250px;
            /* min-width: 100px; */
            max-width: 600px;
            left: 0px;
            z-index: 1;
        }

        .Sr_col {
            width: 60px;
            min-width: 60px;
            max-width: 60px;
            left: 0px;
            z-index: 1;
        }

        .first_col {
            width: 80px;
            min-width: 80px;
            max-width: 80px;
            left: 0px;
            z-index: 1;
        }

        .Sr_sec_col {
            /* width: 250px; */
            width: 210px;
            min-width: 210px;
            max-width: 210px;
            left: 60px;
            z-index: 1;
        }

        .second_col {
            /* width: 250px; */
            width: 210px;
            min-width: 210px;
            max-width: 210px;
            left: 80px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .third_col {
            /* width: 100px; */
            width: 80px;
            min-width: 80px;
            max-width: 80px;
            left: 290px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .forth_col {
            /* width: 100px; */
            width: 85px;
            min-width: 85px;
            max-width: 85px;
            left: 370px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .fifth_col {
            /* width: 100px; */
            width: 85px;
            min-width: 85px;
            max-width: 85px;
            left: 370px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .sixth_col {
            /* width: 100px; */
            width: 85px;
            min-width: 85px;
            max-width: 85px;
            left: 370px;
            /* you have to count the first-col width => your border width */
            z-index: 1;
        }

        .text_small {
            font-size: 12px;
        }

        .lbtext_small {
            font-size: 12px;
        }

        .table-fixed-header thead tr th,
        .table thead tr th {
            font-weight: 400;
            background-color: #e7edf0;
            /* background-color: #f5f5f5; */
        }

        .table-fixed-header tbody tr td,
        .table tbody tr td {
            font-weight: 400;
            text-align: left;
            vertical-align: middle;
        }

        .table-fixed-header thead tr th,
        .table thead tr td {
            text-align: center;
            vertical-align: middle;
            background-color: #e7edf0;
        }

        /* label{
            font-weight:500;
        } */
        table > td {
            text-align: left !important;
        }

        .panel-body {
            padding: 3px;
        }

        .btn-default {
            background-color: #f4f4f4;
            color: #444;
            border-color: #ddd;
        }

            .btn-default:hover,
            .btn-default:active,
            .btn-default.hover {
                background-color: #e7e7e7;
            }

        .table thead tr th span {
            display: inline;
        }

        .form-group label {
            line-height: 1.2;
        }

        .custmodal .modal-content .modal-body {
            padding: 20px;
        }

        .custom_chckbox label:before {
            margin-right: 0;
        }

        /*.bootstrap-select .dropdown-menu {
            max-width: 100%;*/
            /* position: absolute !important;
            z-index: 7;
            min-height: 210px !important; */
        /*}*/

        .custom_chckbox input:checked + label:after {
            top: 1px;
        }

        .form-check-input:checked {
            background-color: #8b8b8b;
            border-color: #8b8b8b;
        }

        .form-check-input:focus {
            border-color: unset;
            outline: 0;
            box-shadow: none;
        }

        textarea::placeholder {
            font-size: 11px;
        }

        .logoImg {
            width: 85px;
            height: auto;
        }

        .greenbg {
            background-color: #0b6f6a;
            color: #FFF;
        }

        .detailPanel {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
        }

        .bgBlue {
            /* background-color: #304295; */
            background-color: #283b91;
            color: #FFF;
        }

        .bgGreen {
            /* background-color: #304295; */
            background-color: #0b6f6a;
            color: #FFF;
        }

        .textSky {
            color: #2fc2c2;
        }

        .checkIcn {
            font-size: 20px;
        }

        h6.pageTitle {
            color: #0b6f6a;
        }

        .sheetTitle {
            font-weight: 500;
        }

        .BG_Gray {
            background: #efefef !important;
        }

        .bg_Milestone {
            background-color: #f1f8ff !important;
            /* color: #124801 !important;*/
        }

        .allWorkflowTabsDiv {
            display: flex;
            justify-content: flex-start;
            flex-wrap: wrap;
        }

        /* .table-responsive {
            scrollbar-width: thin;
        } */
        .scrollTable {
            overflow: hidden !important;
        }

            .scrollTable:hover {
                 overflow-y: auto !important;  
                overflow-x: hidden !important;
            }

        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 15px;
        }

        .slider:before {
            transform: translateX(-20px);
        }

        input:checked + .slider:before {
            transform: translateX(20px);
        }

        .tempTitle {
            font-size: 12px;
        }

        .inputWidth {
            width: 70px;
            margin: auto;
        }

        .bgGrey {
            background-color: #efefef !important;
        }

        .tblIcons > a {
            /* color: #1359a6 !important; */
            color: #414042 !important;
        }

        #DevAgile_MetricCarSec1 .stickyTblHeader {
            top: -8px;
        }

        .pro_RedBGscore {
            background-color: #ffcfcf !important;
            color: #d32222 !important;
            font-weight: 600;
            height: 19px;
            margin: 1px;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
        }

        .pro_GreenBGscore {
            background-color: #a7ff7e !important;
            color: #11a819 !important;
            font-weight: 600;
            height: 19px;
            margin: 1px;
            display: flex;
            justify-content: space-evenly;
            align-items: center;
        }

        .WF_TopAccordianPanel .accordion-button {
            font-size: 12px;
        }

        .borderGrey {
            border: 1px solid #dee2e6;
        }

        .allWorkflowTabsDiv .nav {
            justify-content: flex-start;
        }

        .statusDiv {
            /* width: 110px; */
            width: 136px;
        }
        .statusBox {
            margin-top:1px!important;
        }
        textarea {
            resize: none;
        }
        .dataTables_empty {
            text-align:center!important;
        }
        #ActionTypeHistory {
            width:165px!important;
        }
        #DivFilter .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 140%;
        }
        .offcanvas {
            --bs-offcanvas-width: 82%!important;
        }
        #WF_ApprovalDetailsTable .table-fixed-header thead tr th, .table thead tr th:nth-child(1) {
            width:84px!important;
        }

        #WF_ApprovalDetailsTable thead tr th, #WF_ApprovalDetailsTable thead tr th:nth-child(2) {
            width:160px!important;
        }

         #ApprovalHistoryTbl thead tr th, #ApprovalHistoryTbl thead tr th:nth-child(1) {
            width:124px!important;
        }

        #addWorkflowDetlsBtn {
            white-space:nowrap;
        }
        .loadingoverlay_progress_bar {
            left: 0 !important;
            right: 0 !important;
        }

        #DevAgile_DerivedMetricTbl .dataTables_empty {
            text-align:center!important;
        }
    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed" id="BodyDerivedMetric">
    <%If m_ViewAccess = True Then%>
    <div class="container-fluid pt-1 pb-1 text-end graybg d-flex justify-content-between">
        <h5 class="pgtitle"><%= MyBase.GetResourceString("C_DM") %></h5>
    </div>
    <div class="bgwhite pageContent px-2">
        <!-- Main content -->
        <div class="content mt-0 pt-0">
            <div class="container-fluid mb-4 mt-3" id="ProjectDetlsExcel">
                <div class="row py-2 mx-0">
                    <div class="col-sm-5">
                        <div class="row mb-2">
                            <label class="form-label col-sm-5 mt-1 text-end"><%= MyBase.GetResourceString("C_Project") %></label>
                            <div class="col-sm-7">
                                <%--      <select class="selectpicker" data-live-search="true">
                                    <option>Select Project</option>
                                    <option>Project 01</option>
                                    <option>Project 02</option>
                                    <option>Project 03</option>
                                    <option>Project 04</option>
                                </select>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProject", "select 0,'select Project'",,, "class='selectpicker ' data-live-search='true' onchange='GetSessionProjDetails();PlotProjectonChange();' ",,,) %>
                            </div>
                        </div>
                        <div class="row">
                            <label class="form-label col-sm-5 mt-1 text-end">
                                <%= MyBase.GetResourceString("C_Template") %>
                                <br />
                                <span
                                    class="text_bg"><%= MyBase.GetResourceString("C_PMI") %></span></label>
                            <label class="form-label col-sm-7 mt-1" id="lblPMITemplate"></label>
                            <!-- <div class="col-sm-7">
                                <select class="selectpicker" data-live-search="true" id="selectTempUploadDtls">
                                    <option>Select Template</option>
                                    <option value="metricTemplate1" selected>Dev-Maintenance (Agile)</option>
                                    <option value="metricTemplate2">Dev-Maintenance (Waterfall)</option>
                                    <option value="metricTemplate3">Infra Support</option>
                                    <option value="metricTemplate4">Testing (Agile)</option>
                                    <option value="metricTemplate5">Testing (Waterfall)</option>
                                </select>
                            </div> -->
                        </div>
                    </div>
                    <div class="col-sm-4 d-flex align-items-center">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <span class="lbtext_small col-sm-6 text-end"><%= MyBase.GetResourceString("C_Client") %> </span>
                                    <span class="text_small col-sm-6" id="lblClientName"></span>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <span class="lbtext_small col-sm-6 text-end"><%= MyBase.GetResourceString("C_PrjCode") %> </span>
                                    <span class="text_small col-sm-6" id="lblProjectCode"></span>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <span class="lbtext_small col-sm-6 text-end"><%= MyBase.GetResourceString("C_PrjType") %> </span>
                                    <span class="text_small col-sm-6" id="lblProjectType"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Dev-Maintenance (Agile) Template Details Added by Gauri start here -->
                <div class="allMetricSec" id="MetricTemplateSec1">
                    <div class="allWorkflowTabsDiv">
                        <div class="row flex-1">
                            <div class="col-sm-2">
                                <ul class="nav nav-tabs mb-2 pe-3" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="DevAgile_TabDerivedMetric" data-bs-toggle="tab"
                                            data-bs-target="#DevAgile_DerivedMetricTab" type="button" role="tab"
                                            aria-selected="false" tabindex="-1">
                                            <%= MyBase.GetResourceString("C_DM") %>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-sm-10 d-flex justify-content-end align-items-center" >
                                <div class="d-block" id="sendApprovalSec">    
                                    <a href="javascript:;" class="textUndrln d-inline-block pe-2" id="ApproveRejectedlink" style="display:none!important"> 
                                        <span data-bs-toggle="tooltip" title="Approve/Reject" onclick="SendForApproval()"><%= MyBase.GetResourceString("C_RejectApproval")%> </span>
                                    </a>
                                    <a href="javascript:;" class="textUndrln d-inline-block" id="addWorkflowDetlsBtn" style="display:none!important"> 
                                        <span data-bs-toggle="tooltip" title="Send for Metric Approval" onclick="SendForApproval()"><%= MyBase.GetResourceString("C_SendApproval")%></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-content mt-2">
                        <%--<div id="DevAgile_DerivedMetricTab" class="tab-pane active" role="tabpanel">--%>
                        <div id="DevAgile_DerivedMetricTab" class="tab-pane" role="tabpanel">
                            <div class="MetricTblPanel2" id="">
                                <div class="scrollTable  table-responsive" id="DevAgile_DM_ScrollTable">
                                    <table id="DevAgile_DerivedMetricTbl"
                                        class="table table-color-header borderGrey table-fixed-header ExcelUploadTbl"
                                        style="width: 100%;">
                                        <tbody class="stickyTblHeader">
                                            <tr id="tblheadforMilestone">
                                                <td class="col-sm-1 ExcldColms sticky_col first_col bg_Milestone text-center"><%= MyBase.GetResourceString("C_Metric") %>
                                                    <br>
                                                    <%= MyBase.GetResourceString("C_ID") %></td>
                                                <td class="col-sm-1 ExcldColms sticky_col second_col bg_Milestone"><%= MyBase.GetResourceString("C_Metric") %></td>
                                                <td class="col-sm-1 ExcldColms sticky_col third_col bg_Milestone text-center"><%= MyBase.GetResourceString("C_Units") %>
                                                </td>
                                                <td class="col-sm-1 ExcldColms sticky_col forth_col bg_Milestone text-center"><%= MyBase.GetResourceString("C_Target") %></td>
                                                <td class="col-sm-1 ExcldColms sticky_col colSmall bg_Milestone text-center"><%= MyBase.GetResourceString("C_Average") %>
                                                    <br>
                                                   <%= MyBase.GetResourceString("C_Mean") %> </td>
                                                <td class="col-sm-1 ExcldColms sticky_col colSmall bg_Milestone text-center"><%= MyBase.GetResourceString("C_Standard") %>
                                                    <br>
                                                    <%= MyBase.GetResourceString("C_Deviation") %></td>
                                        </tbody>
                                    </table>
                                    <%--           <td class="hideTblTxt sprintCol text-center">
                                                    <i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i>
                                                    <span>Sprint 1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                                    incididunt ut labore et dolore magna aliqua. </span>
                                                </td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 2</span></td>
                                                <td class="hideTblTxt sprintCol text-center">
                                                    <i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i>
                                                    <span>Sprint 3 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                                        incididunt ut labore et dolore magna aliqua. </span>
                                                </td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 4</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 5</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 6</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 7</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 8</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 9</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 10</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 11</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 12</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 13</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 14</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 15</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 16</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 17</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 18</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 19</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 20</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 21</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 22</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 23</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 24</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 25</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 26</span></td>
                                                <td class="colSmall">
                                                    <div class="yearDiv d-flex justify-content-center">
                                                        <div>
                                                            <i class="far fa-caret-square-left Excel_PrevMonthBtn"
                                                                data-bs-toggle="tooltip" title="Previous"
                                                                id="DevAgileDM_PrevMonthBtn"></i>
                                                            <i class="far fa-caret-square-right Excel_NextMonthBtn"
                                                                data-bs-toggle="tooltip" title="Next"
                                                                id="DevAgileDM_NextMonthBtn"></i>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                        <tbody>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">1</td>
                                                <td class="sticky_col second_col bg_grayTD">Sprint Stability Index</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">20%</td>
                                                <td class="text-center sprintCol">0%</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">2</td>
                                                <td class="sticky_col second_col bg_grayTD">User Story Acceptance</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">10%</td>
                                                <td class="text-center sprintCol">0%</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">3</td>
                                                <td class="sticky_col second_col bg_grayTD">Sprint Velocity</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">8%</td>
                                                <td class="text-center sprintCol">8%</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">4</td>
                                                <td class="sticky_col second_col bg_grayTD">Velocity Variation</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">+/-10%</td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.16</td>
                                                <td class="text-center sprintCol">0.12</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">5</td>
                                                <td class="sticky_col second_col bg_grayTD">Sprint Capacity Utilization
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">2.12</td>
                                                <td class="text-center sprintCol">0.14</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">6</td>
                                                <td class="sticky_col second_col bg_grayTD">Effort Variance - Overall
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">+/-10%</td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.16</td>
                                                <td class="text-center sprintCol">0.12</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">7</td>
                                                <td class="sticky_col second_col bg_grayTD">Productivity - Story Points
                                                    (In terms of St.Pt/Hrs)</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">St.Pt/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">4.35</td>
                                                <td class="text-center sprintCol">2.65</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">8</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Test Case Design
                                                    Productivity</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">TCs/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.54</td>
                                                <td class="text-center sprintCol">0.23</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">9</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Test Case Execution
                                                    Productivity</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">TCs/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.22</td>
                                                <td class="text-center sprintCol">0.65</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">10</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Test Script
                                                    Design Productivity</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">TSs/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.16</td>
                                                <td class="text-center sprintCol">0.12</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">11</td>
                                                <td class="sticky_col second_col bg_grayTD">Unit Test Coverage</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.76</td>
                                                <td class="text-center sprintCol">0.33</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">12</td>
                                                <td class="sticky_col second_col bg_grayTD">Review Efficiency - Coding
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Defects/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.23</td>
                                                <td class="text-center sprintCol">0.55</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">13</td>
                                                <td class="sticky_col second_col bg_grayTD">Review Effectiveness</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.65</td>
                                                <td class="text-center sprintCol">0.35</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">14</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Test Case Review
                                                    Efficiency</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Defects/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.43</td>
                                                <td class="text-center sprintCol">0.76</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">15</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Test Execution
                                                    Coverage</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.56</td>
                                                <td class="text-center sprintCol">0.87</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">16</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Scripts Review
                                                    Efficiency</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Defects/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.23</td>
                                                <td class="text-center sprintCol">0.76</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">17</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Testing Efficiency
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Defects/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.69</td>
                                                <td class="text-center sprintCol">0.78</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">18</td>
                                                <td class="sticky_col second_col bg_grayTD">Test Effectiveness</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.96</td>
                                                <td class="text-center sprintCol">0.75</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">19</td>
                                                <td class="sticky_col second_col bg_grayTD">Defect Removal Effectiveness
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">0.63</td>
                                                <td class="text-center sprintCol">0.74</td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">20</td>
                                                <td class="sticky_col second_col bg_grayTD">Overall Defect Injection
                                                    Rate</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Defects/Hr</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">
                                                    <div class="pro_GreenBGscore">
                                                        <span class="">0.04</span>
                                                    </div>
                                                </td>
                                                <td class="text-center sprintCol">
                                                    <div class="pro_RedBGscore">
                                                        <span class="">0.09</span>
                                                    </div>
                                                </td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">21</td>
                                                <td class="sticky_col second_col bg_grayTD">Overall Defect Density</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Defects/St.Pt
                                                </td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">
                                                    <div class="pro_RedBGscore">
                                                        <span class="">0.30</span>
                                                    </div>
                                                </td>
                                                <td class="text-center sprintCol">
                                                    <div class="pro_GreenBGscore">
                                                        <span class="">0.72</span>
                                                    </div>
                                                </td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">22</td>
                                                <td class="sticky_col second_col bg_grayTD">Delivered Defect Density
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Defects/St.Pt
                                                </td>
                                                <td class="sticky_col forth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col fifth_col bg_grayTD text-center"></td>
                                                <td class="sticky_col sixth_col bg_grayTD text-center"></td>
                                                <td class="text-center sprintCol">
                                                    <div class="pro_RedBGscore">
                                                        <span class="">0.03</span>
                                                    </div>
                                                </td>
                                                <td class="text-center sprintCol">
                                                    <div class="pro_RedBGscore">
                                                        <span class="">0.08</span>
                                                    </div>
                                                </td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="text-center sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Dev-Maintenance (Agile) Template Details Added by Gauri end here -->

                <!-- offcanvas Section Start here Comment Added By Gauri-->
                <div class="offcanvas offcanvas-end offcanvas-80" data-bs-scroll="false" tabindex="-1"
                    id="offcanvas_ShowMetric_History">
                    <div class="offcanvas-body">
                        <div class="container-fluid py-2 graybg mb-2">
                            <div class="row align-items-center">
                                <div class="col-sm-12">
                                    <div class="d-flex align-items-center font-weight-600">
                                        <span>Project Status History Details</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="showHistorySec">
                            <div class="row">
                                <div class="col-sm-12 text-end">
                                    <button class="btn borderbtn" type="button" id="closeBtn"
                                        data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip"
                                        title="Close">
                                        Close
                                    </button>
                                </div>
                            </div>

                            <div class="showHistoryFltr">
                                <div class="row d-flex justify-content-center my-3">
                                    <div class="col-sm-5">
                                        <div class="row">
                                            <div class="col-sm-6 d-flex justify-content-end">
                                                <label>Modified Field : </label>
                                            </div>
                                            <div class="col-sm-6">
                                                <select class="selectpicker" data-live-search="true"
                                                    id="ModifiedHisFieldInput">
                                                    <option>Select Option</option>
                                                    <option>Field 1</option>
                                                    <option>Field 2</option>
                                                    <option>Field 3</option>
                                                    <option>Field 4</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <div class="row">
                                            <div class="col-sm-6 d-flex justify-content-end">
                                                <label>Modified By : </label>
                                            </div>
                                            <div class="col-sm-6">
                                                <select class="selectpicker" data-live-search="true"
                                                    id="ModifiedHisByInput">
                                                    <option>Select Option</option>
                                                    <option>User 1</option>
                                                    <option>User 2</option>
                                                    <option>User 3</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="showHistoryContent">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table id="MetricShowHistoryTable" class="table" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th class="text-start">Modified Field</th>
                                                    <th class="text-start">Sprint Name</th>
                                                    <th class="text-start">Old Value</th>
                                                    <th class="text-start">New Value</th>
                                                    <th class="text-start">Modified Date</th>
                                                    <th class="text-start">Modified By</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>Field 1</td>
                                                    <td>Sprint 1</td>
                                                    <td>Old Value 1</td>
                                                    <td>New Value 1</td>
                                                    <td>12 Dec 2017</td>
                                                    <td>Peter</td>
                                                </tr>
                                                <tr>
                                                    <td>Field 2</td>
                                                    <td>Sprint 2</td>
                                                    <td>Old Value 2</td>
                                                    <td>New Value 2</td>
                                                    <td>02 Oct 2017</td>
                                                    <td>Johns</td>
                                                </tr>
                                                <tr>
                                                    <td>Field 3</td>
                                                    <td>Sprint 3</td>
                                                    <td>Old Value 3</td>
                                                    <td>New Value 3</td>
                                                    <td>11 Jun 2017</td>
                                                    <td>Jems</td>
                                                </tr>
                                                <tr>
                                                    <td>Field 4</td>
                                                    <td>Sprint 4</td>
                                                    <td>Old Value 4</td>
                                                    <td>New Value 4</td>
                                                    <td>05 Jul 2017</td>
                                                    <td>Admin</td>
                                                </tr>
                                                <tr>
                                                    <td>Field 5</td>
                                                    <td>Sprint 5</td>
                                                    <td>Old Value 5</td>
                                                    <td>New Value 5</td>
                                                    <td>22 Feb 2017</td>
                                                    <td>Peter</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- offcanvas Section End here Comment Added By Gauri-->

                <!-- Add Workflow Offcanvas Section starts -->
                <div class="offcanvas offcanvas-end offcanvas-80" data-bs-scroll="false" tabindex="-1"
                    id="AddWorkflowDetlsOffcanvas">
                    <div class="offcanvas-body">
                        <div class="container-fluid py-2 graybg mb-2">
                            <div class="row align-items-center">
                                <div class="col-sm-12">
                                    <div class="d-flex align-items-center font-weight-500">
                                        <span><%= MyBase.GetResourceString("C_MetricApproval") %></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mx-1">
                            <div class="col-sm-6">&nbsp;</div>
                            <div class="col-sm-6">
                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                    <a href="javascript:;" class="btn borderbtn" id="ApproveWorkflowBtn" data-bs-toggle="modal" data-bs-target="#ApprovalRemarkModal" style="display:none"> 
                                        <span data-bs-toggle="tooltip" data-bs-original-title="Approve"><%= MyBase.GetResourceString("C_Approve") %></span>
                                    </a>
                                    <a href="javascript:;" class="btn borderbtn" id="RejectWorkflowBtn" data-bs-toggle="modal" data-bs-target="#RejectRemarkModal" style="display:none"> 
                                        <span data-bs-toggle="tooltip" data-bs-original-title="Reject"><%= MyBase.GetResourceString("C_Reject") %></span>
                                    </a>
                                    <a href="javascript:;" class="btn btnyellow" id="SubmitWorkflowBtn" style="display:none" onclick="Submit_Onclick()"> 
                                        <span data-bs-toggle="tooltip" data-bs-original-title="Submit"><%= MyBase.GetResourceString("C_Submit") %></span>
                                    </a>
                                      <%If m_AddAccess = True Or m_EditAccess Then%>
                                    <a href="javascript:;" class="btn btnyellow" id="SaveWorkflowBtn" onclick="Save_Onclick()" style="display:none"> 
                                        <span data-bs-toggle="tooltip" data-bs-original-title="Save"><%= MyBase.GetResourceString("C_Save") %></span>
                                    </a>
                                    <%End If %>
                                    <button class="btn borderbtn" type="button" id="closeWorkflowBtn"
                                        data-bs-dismiss="offcanvas" aria-label="Close" data-bs-toggle="tooltip"
                                        title="Close">
                                        <%= MyBase.GetResourceString("C_Close") %>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="Details_Info">
                            <!-- WorkFlow Approval Details start here -->
                            <div class="accordion WF_TopAccordianPanel mt-3 "
                                id="WF_ApprovalDtlsAcc">
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                         <%If m_AddAccess = True Then%>
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" id="btnAddRequest" onclick="Add_Request()"
                                                data-bs-target="#WF_ApprovalAddDtlsTab" aria-expanded="true">
                                            <i class="fas fa-plus addIcn pe-2" ></i> <%= MyBase.GetResourceString("C_AddRequest") %> 
                                        </button>
                                        <%End If%>
                                    </h2>

                                    <div id="WF_ApprovalAddDtlsTab" class="accordion-collapse collapse">
                                        <div class="accordion-body">
                                            <div class="WF_ApprovalDtls_Editable">
                                                <div class="row mb-2 ps-5">
                                                    <div class="col-sm-12">
                                                        <div class="row">
                                                            <div class="col-sm-6 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end mt-2">
                                                                        <label class="form-label pe-2"><%= MyBase.GetResourceString("C_RequestId") %>  :</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-start mt-2">
                                                                        <label class="form-label" id="newRequestIdInput">1</label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end mt-2">
                                                                        <label for="newSprintNameInput" class="form-label required"><%= MyBase.GetResourceString("C_SprintName") %> :</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-start">
                                                                       
                                                                         <% CommonFunctions.HTMLControls.DrawComboBox("newSprintNameInput", "select 0,'Select Sprint'",,, "class='selectpicker ' data-live-search='true' ",,,) %>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div class="col-sm-7 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-4 text-end mt-2">
                                                                        <label for="newRemarkInput" class="form-label required"><%= MyBase.GetResourceString("C_Remark") %>  :</label>
                                                                    </div>
                                                                    <div class="col-sm-8 text-start">
                                                                     
                                                                         <% CommonFunctions.HTMLControls.DrawTextArea("newRemarkInput", "newRemarkInput", "Enter Remarks", "form-control",,,,, , 100, 200,,,,,,,, "Maxlength=500",,,,,,,,,,) %>
                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row" id="DivSenderRemarks"  style="display:none">
                                                            <div class="col-sm-7 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-4 text-end mt-2">
                                                                        <label for="newSenderRemarkInput" class="form-label "><%= MyBase.GetResourceString("C_Sender'sRemark") %> &nbsp;:</label>
                                                                    </div>
                                                                    <div class="col-sm-8 text-start">
                                                                       
                                                                  <% CommonFunctions.HTMLControls.DrawTextArea("newSenderRemarkInput", "newSenderRemarkInput", "Enter Sender Remark", "form-control",,,,, , 100, 200,,,,, True, "White",, "Maxlength=500",,,,,,,,,,) %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row"  id="DivApproverRemarks"  style="display:none">
                                                            <div class="col-sm-7 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-4 text-end mt-2">
                                                                        <label for="newApprRemarkInput" class="form-label"><%= MyBase.GetResourceString("C_ApproverRemark") %> :</label>
                                                                    </div>
                                                                    <div class="col-sm-8 text-start">
                                                                       
                                                                  <% CommonFunctions.HTMLControls.DrawTextArea("newApprRemarkInput", "newApprRemarkInput", "Enter Approver Remark", "form-control",,,,, , 100, 200,,,,, True, "White",, "Maxlength=500",,,,,,,,,,) %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="WF_ApprovalDtls_Info">
                                                <div class="row mb-2 ps-5">
                                                    <div class="col-sm-12">
                                                        <div class="row">
                                                            <div class="col-sm-6 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end">
                                                                        <label class="form-label pe-2"><%= MyBase.GetResourceString("C_RequestId") %> :</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-stard">
                                                                        <label class="form-label" id="newRequestIdLabel"></label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6 mb-3"  id="DivSprint"  style="display:none">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end">
                                                                        <label for="newSprintNameInput" class="form-label"><%= MyBase.GetResourceString("C_SprintName") %> :</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-start">
                                                                        <label class="form-label" id="newSprintNameLabel"></label>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                                  <div class="col-sm-6 mb-3" id="DivSprintDraft" style="display:none">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end mt-2">
                                                                        <label for="newSprintNameInput" class="form-label required"><%= MyBase.GetResourceString("C_SprintName") %> :</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-start">
                                                                       
                                                                         <% CommonFunctions.HTMLControls.DrawComboBox("newSprintNameInputDraft", "select 0,'Select Sprint'",,, "class='selectpicker ' data-live-search='true' ",,,) %>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row" id="DivRemarks">
                                                            <div class="col-sm-6 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end">
                                                                        <label for="newRemarkInput" class="form-label "><%= MyBase.GetResourceString("C_Remark") %> :</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-start">
                                                                        <label class="form-label" id="newRemarkLabel"></label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                          <div class="row" id="DivRemarksDraft"  style="display:none">
                                                            <div class="col-sm-7 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-4 text-end mt-2">
                                                                        <label for="newRemarkInputdraft" class="form-label required"><%= MyBase.GetResourceString("C_Remark") %>&nbsp;:</label>
                                                                    </div>
                                                                    <div class="col-sm-8 text-start">
                                                                       
                                                                  <% CommonFunctions.HTMLControls.DrawTextArea("newRemarkInputdraft", "newRemarkInputdraft", "Enter  Remark", "form-control",,,,, , 100, 200,,,,, , ,, "Maxlength=500",,,,,,,,,,) %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row" id="DivSender">
                                                            <div class="col-sm-6 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end">
                                                                        <label for="newSenderRemarkInput" class="form-label"><%= MyBase.GetResourceString("C_Sender'sRemark") %>:</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-start">
                                                                        <label class="form-label" id="newSenderRemarkLabel"></label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row" id="DivSenderComments"  style="display:none">
                                                            <div class="col-sm-7 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-4 text-end mt-2">
                                                                        <label for="newSenderRemarkInput" class="form-label required"><%= MyBase.GetResourceString("C_Sender'sRemark") %>&nbsp;:</label>
                                                                    </div>
                                                                    <div class="col-sm-8 text-start">
                                                                       
                                                                  <% CommonFunctions.HTMLControls.DrawTextArea("newSenderCommentsInput", "newSenderCommentsInput", "Enter Sender Remark", "form-control",,,,, , 100, 200,,,,, , ,, "Maxlength=500",,,,,,,,,,) %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row"  id="DivApprover">
                                                            <div class="col-sm-6 mb-3">
                                                                <div class="row">
                                                                    <div class="col-sm-5 text-end">
                                                                        <label for="newApprRemarkInput" class="form-label"><%= MyBase.GetResourceString("C_ApproverRemark") %> :</label>
                                                                    </div>
                                                                    <div class="col-sm-7 text-start">
                                                                        <label class="form-label" id="newApprRemarkLabel"></label>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="WF_ApprovalHistoryInfo basicInfoSec p-3 mt-3" style="display:none">
                                                <div class="row mb-2">
                                                    <div class="col-sm-12 ps-4">
                                                        <div class="ExcelTitle font-weight-500"><%= MyBase.GetResourceString("C_ApprovalHistory") %>  - </div>
                                                    </div>
                                                </div>

                                                <div class="row my-2">
                                                    <div class="col-sm-5">
                                                        <div class="row">
                                                            <div class="col-sm-6 d-flex justify-content-end">
                                                                <label><%= MyBase.GetResourceString("C_ActionTaken") %>  </label>
                                                            </div>
                                                            <div class="col-sm-6" id="DivFilter">
                                                            

                                                                <% CommonFunctions.HTMLControls.DrawComboBox("ActionTypeHistory", "select 0,'Select Action Taken'",,, "class='selectpicker ' data-live-search='true' onchange=GetFilterStatus('onchange')",,,) %>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="table-responsive">
                                                        <table class="table" id="ApprovalHistoryTbl">
                                                            <thead>
                                                                <tr>
                                                                    <th><%= MyBase.GetResourceString("C_EventTime") %>  </th>
                                                                    <th><%= MyBase.GetResourceString("C_ActionTaken") %></th>
                                                                    <th><%= MyBase.GetResourceString("C_Approver/Sender") %></th>
                                                                    <th><%= MyBase.GetResourceString("C_Comments") %></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="TbodyHistory">
                                                                
                                                                
                                                            </tbody>
                                                        </table>
                                                        <div class="clearfix"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- WorkFlow Approval Details end here -->

                            <div class="content mt-0" id="WF_ApprovalSec">
                                <!-- List View starts here -->
                                <div class="row">
                                    <div class="table-responsive">
                                        <table id="WF_ApprovalDetailsTable" class="table" style="width:100%;">
                                            <thead class="stickyTblHeader">
                                                <tr>
                                                    <th class="col-sm-1"><%= MyBase.GetResourceString("C_RequestId") %></th>
                                                    <th class="col-sm-5"><%= MyBase.GetResourceString("C_SprintName") %></th>
                                                    <th class="col-sm-3"><%= MyBase.GetResourceString("C_Remark") %></th>
                                                    <th class="col-sm-3"><%= MyBase.GetResourceString("C_Status") %></th>
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </thead>
                                            <tbody id="TbodyWF_ApprovalDetailsTable">
                                  
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                                <!-- List View Ended here -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Add Workflow Offcanvas Section ends -->

                <!--Approval Remark modal start here-->
                <div class="modal custmodal fade" id="ApprovalRemarkModal" data-bs-backdrop="static" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ApprovalRemark") %> </h5>
                                <button type="button" class="close" onclick="Clearall(2)" data-bs-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-12 text-end">
                                        <label class="form-label ">(<font color="red">*</font> Mandatory)</label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="required"><%= MyBase.GetResourceString("C_ApprovalComment") %> : </label>
                                    <div class="col-sm-12">
                                        <%--<textarea rows="3" class="form-control required"></textarea>--%>
                                         <% CommonFunctions.HTMLControls.DrawTextArea("ApproverRemakrs", "ApproverRemakrs", "Enter Remarks", "form-control required",,,,, , 100, 200,,,,,,,, "Maxlength=500",,,,,,,,,,) %>
                                        
                                    </div>
                                </div>
                                <div class="text-center my-2">
                                    <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                                        data-bs-original-title="Approve" onclick="ApproveRejectOnClick(2)"><%= MyBase.GetResourceString("C_Approve") %></a>
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" onclick="Clearall(2)"
                                        data-bs-toggle="tooltip" data-bs-original-title="Cancel"><%= MyBase.GetResourceString("C_Cancel") %></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Approval Remark modal end here-->

                <!-- Reject Remark modal start here-->
                <div class="modal custmodal fade" id="RejectRemarkModal" data-bs-backdrop="static" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_RejectRemark") %> </h5>
                                <button type="button" class="close" onclick="Clearall(3)" data-bs-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-12 text-end">
                                        <label class="form-label ">(<font color="red">*</font> Mandatory)</label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="required"><%= MyBase.GetResourceString("C_RejectionComment") %>: </label>
                                    <div class="col-sm-12">
                                        <%--<textarea rows="3" class="form-control required"></textarea>--%>
                                        <% CommonFunctions.HTMLControls.DrawTextArea("RejectedRemakrs", "RejectedRemakrs", "Enter Remarks", "form-control required",,,,, , 100, 200,,,,,,,, "Maxlength=500",,,,,,,,,,) %>
                                        
                                    </div>
                                </div>
                                <div class="text-center my-2">
                                    <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                                        data-bs-original-title="Reject"  onclick="ApproveRejectOnClick(3)"><%= MyBase.GetResourceString("C_Reject") %></a>
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal" onclick="Clearall(3)"
                                        data-bs-toggle="tooltip" data-bs-original-title="Cancel"><%= MyBase.GetResourceString("C_Cancel") %></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Reject Remark modal end here-->
            </div>
        </div>
    </div>

    <div class="clearfix"></div>

    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess")%></p>
        </div>
    </div>
    <%End If %>
   
 <!-- REQUIRED JS SCRIPTS -->
      <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    
   <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>


    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
     <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <script>
        var Session_ProjectID = '<%= Session("intProjectID") %>';
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
        var UserName = '<%= Session("strUserName") %>';
        var SessionUserId = '<%= Session("intUserId") %>';
        var LoginType = '<%= Session("LoginType") %>';


        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();

            $('td.hideTblTxt >span').each(function () {
                var text = $(this).text();
                if (text.length > 12) {
                    var truncatedText = text.substring(0, 12);
                    var remainingText = text.substring(12);
                    var popoverTrigger = '<span class="more" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="' + text + '">' + truncatedText + '...</span>';
                    $(this).html(popoverTrigger + '<span class="full-text" style="display:none;">' + text + '</span>');
                }
            });

            $('[data-bs-toggle="popover"]').popover();

            $(".ExcelUploadTbl input[type='number']").attr("disabled", true);

            const myCollapsible = document.getElementById('WF_ApprovalDtlsAcc')
            myCollapsible.addEventListener('hidden.bs.collapse', event => {
                $(".WF_ApprovalDtls_Info").hide();
                $(".WF_ApprovalDtls_Editable").show();
            })
        });

        $(".WF_ApprovalDtls_Info").hide();

        function EditApprovalDetls() {
            $("#WF_ApprovalAddDtlsTab").collapse('show');
            $(".WF_ApprovalDtls_Info").hide();
            $(".WF_ApprovalDtls_Editable").show();
        }

       

        var newRequestIdInput = 1;
         var IsSQA = 0, IsPM = 0, SQAID = 0, PMID = 0;
        $(document).ready(function () {

            GetSessionProjDetails();
            GetTemplatewiseAccessibleProject();
            $("#cboProject").val(Session_ProjectID);
            $(".selectpicker").selectpicker('refresh');
            GetDerivedMetricDetails();
            $(".sprintCol").hide();
            var InitialIndex = 0;
            var ColumnsCnt = $('#DevAgile_DerivedMetricTbl tbody tr:first .sprintCol').length;

            function updateTableDisplay() {
                $('#DevAgile_DerivedMetricTbl tbody tr').each(function () {
                    $(this).find('td.sprintCol').hide();
                    $(this).find('td.sprintCol').slice(InitialIndex, InitialIndex + 3).css('display', 'table-cell');
                });

                $('#DevAgileDM_PrevMonthBtn').prop('disabled', InitialIndex <= 0);
                $('#DevAgileDM_NextMonthBtn').prop('disabled', InitialIndex >= ColumnsCnt - 3);
            }

            updateTableDisplay();

            $('#DevAgileBM_NextMonthBtn').on('click', function () {
                if (InitialIndex < ColumnsCnt - 3) {
                    InitialIndex += 3;
                    updateTableDisplay();
                }
            });

            $('#DevAgileBM_PrevMonthBtn').on('click', function () {
                if (InitialIndex > 0) {
                    InitialIndex -= 3;
                    updateTableDisplay();
                }
            });
            $("#DevAgile_DerivedMetricTab").addClass('active');
            CheckPMSQA();
        });


        $('#MetricShowHistoryTable').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
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
        });
        $('#MetricShowHistoryTable').wrap('<div class="dataTables_scroll" />');

     

        $('#ApprovalEdtHistoryTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
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
        });
        $('#ApprovalEdtHistoryTbl').wrap('<div class="dataTables_scroll" />');

     
        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        function refreshPage() {
            window.location.reload();
        }

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".modal").on('show.bs.modal', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.modal', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $("#MetricShowHistoryTable_wrapper .dataTables_scroll").css({ height: tblheight - 280, "overflow-y": "auto" });
            $(".MetricTblPanel2 .scrollTable").css({ height: tblheight - 230, "overflow-y": "auto" });

            $("#DevAgile_PE_ScrollTable1").css({ height: tblheight - 230, "overflow-y": "auto" });
            $("#DevAgile_MetricCarSec1").css({ height: 500, "overflow-y": "auto" });
            $("#DevAgile_MetricCarSec2").css({ height: tblheight - 100, "overflow-y": "auto" });
            $("#WF_ApprovalDetailsTable_wrapper .dataTables_scroll").css({ height: tblheight - 400, "overflow-y": "auto" });
            $("#ApprovalHistoryTbl_wrapper .dataTables_scroll").css({ height: tblheight - 300, "overflow-y": "auto" });
            $("#ApprovalEdtHistoryTbl_wrapper .dataTables_scroll").css({ height: tblheight - 230, "overflow-y": "auto" });
        }

        $(window).on("load resize scroll", function () {
            resizeSection();
        });

        var PrjTempId = 0;
        var ProjectID = 0;
        var GRequestID = 0;
        var ArrStatus = [];
        var ArrStatusID = [];
        var FromWhichAction = "Load";
        function GetSessionProjDetails() {
           // var ProjectID = 0;
            ProjectID = $("#cboProject").val();
            if (ProjectID == undefined || ProjectID == 0) {
                ProjectID = Session_ProjectID;
            }
            else {
                ProjectID = ProjectID;
            }

            var Parameters = {
                ProjectID: ProjectID
            }
            
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetSessionProjDetails", param, false);
            console.log(strResult);
            PrjTempId = strResult[0].PMIID;
            $("#lblPMITemplate").text(strResult[0].TemplateName);
            $("#lblClientName ").text(strResult[0].CustomerName);
            $("#lblProjectCode").text(strResult[0].ProjectCode);
            $("#lblProjectType").text(strResult[0].ProjectType);
            //PlotProjectonChange();
            CheckPMSQA();
        }

        function GetTemplatewiseAccessibleProject() {
            var strHTML = "";
            var Parameter = {
                TemplateID: PrjTempId,
                UserID: SessionUserId,
                LoginType: LoginType
            }
            var param = JSON.stringify(Parameter);

            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetTemplatewiseAccessibleProject", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var listComponent = strResult[i];
                strHTML += ('<option value=' + listComponent.ProjectID + ' >' + listComponent.ProjectName + '</option>');
            }
            $("#cboProject").html(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

        function GetDerivedMetricDetails() {
            var ProjectID = $("#cboProject").val();

            var Parameters = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetDerivedMetricDetails", param, false);

            if (strResult.length != 0) {
                $("#DevAgile_DerivedMetricTbl tbody").find('td').not('.ExcldColms').remove();
                $("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').find('tr.trNoData').remove();
                $("#DevAgile_DerivedMetricTbl").append(createTable(strResult, 0));
            }
            else {
                $("#DevAgile_DerivedMetricTbl ").find('td').not('.ExcldColms').remove();
                $("#DevAgile_DerivedMetricTbl").find('tr.ExcldRow').remove();
                $("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').remove();
                $("#DevAgile_DerivedMetricTbl").find('tr.trNoData').remove();
                //$("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').remove();
                //$("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').find('tr').remove();
                //$("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').find('tr.trNoData').remove();
                //$("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').find('td.sprintCol').remove();
                //$("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').find('td.PNNavButtons').remove();
                //$("#DevAgile_DerivedMetricTbl").find('tr.trNoData').remove();
                var strhtml = `<td class="hideTblTxt sprintCol  text-center"><span>&nbsp</span></td>
                                <td class="colSmall PNNavButtons">
                                                        <div class="yearDiv d-flex justify-content-center">
                                                            <div>
                                                                <i class="far fa-caret-square-left Excel_PrevMonthBtn"
                                                                    data-bs-toggle="tooltip" title="Previous"
                                                                    id="DevAgileBM_PrevMonthBtn"></i>
                                                                <i class="far fa-caret-square-right Excel_NextMonthBtn"
                                                                    data-bs-toggle="tooltip" title="Next"
                                                                    id="DevAgileBM_NextMonthBtn"></i>
                                                            </div>
                                                        </div>
                                                    </td>`;
                $("#DevAgile_DerivedMetricTbl tbody").find('tr').append(strhtml);

                //$("#DevAgile_DerivedMetricTbl tbody").append(`<tr colspan="8"><td>No Data Available in the table</td></tr>`);
                //$("#DevAgile_DerivedMetricTbl tbody").not('.stickyTblHeader').append(`<tbody><tr id='trNoData'><td colspan="8">No Data Available in the table</td></tr></tbody>`);
                $("#DevAgile_DerivedMetricTbl tbody").append(`<tr class='trNoData' ><td colspan="8" style="text-align:center!important">No Data Available in the table</td></tr>`);
            }
            updateTableDisplay();
            $('td.hideTblTxt >span').each(function () {
                var text = $(this).text();
                if (text.length > 12) {
                    var truncatedText = text.substring(0, 12);
                    var remainingText = text.substring(12);
                    var popoverTrigger = '<span class="more" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="' + text + '">' + truncatedText + '...</span>';
                    $(this).html(popoverTrigger + '<span class="full-text" style="display:none;">' + text + '</span>');
                }
            });

            $('[data-bs-toggle="popover"]').popover();
        }

        $(".sprintCol").hide();
        var InitialIndex = 0;
        var ColumnsCnt = $('#DevAgile_DerivedMetricTbl tbody tr:first .sprintCol').length;

        function updateTableDisplay() {
            //    debugger
            $('#DevAgile_DerivedMetricTbl tbody tr').each(function () {
                $(this).find('td.sprintCol').hide();
                $(this).find('td.sprintCol').slice(InitialIndex, InitialIndex + 3).css('display', 'table-cell');
            });

            $('#DevAgileDM_PrevMonthBtn').prop('disabled', InitialIndex <= 0);
            $('#DevAgileDM_NextMonthBtn').prop('disabled', InitialIndex >= ColumnsCnt - 3);

           
        }

        function updateTableDisplaynxt() {
            var ColumnsCntnxt = $('#DevAgile_DerivedMetricTbl tbody tr:first .sprintCol').length;
            if (InitialIndex < ColumnsCntnxt - 3) {
                InitialIndex += 3;
                updateTableDisplay();
            }
        }

        function updateTableDisplayPrev() {

            var ColumnsCntPrev = $('#DevAgile_DerivedMetricTbl tbody tr:first .sprintCol').length;
            if (InitialIndex > 0) {
                InitialIndex -= 3;
                updateTableDisplay();
            }
        }

        function GetDerivedMetricIsFreezed(MilestoneId) {
            var ProjectID = $("#cboProject").val();
            var Parameters = {
                ProjectID: ProjectID,
                MilestoneID: MilestoneId
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetDerivedMetricIsFreezed", param, false);
            return strResult;
        }

        function createTable(data, headflag) {
           
            var categoeryName = data[0].CategoryName;
            var tblbodyHTML = `<tbody></tbody >`;
            var tableBody = $(tblbodyHTML);
            var tblbodyHead = "";
            var excludedKeys = new Set(["MetricName", "Units", "Target", "MetricID", "Average", "StandardDeviation", "FreezedMilestones", "UCL", "LCL", "UCLColor", "LCLColor",]);
            var FreezedMilestones=[]
            var allKeys = new Set();
            $.each(data, function (index, metric) {
                FreezedMilestones.push(metric.FreezedMilestones);
                $.each(metric, function (key, value) {
                    if (!excludedKeys.has(key)) {
                        allKeys.add(key);
                    }
                });
            });
            allKeys = Array.from(allKeys);
            FreezedMilestones = FreezedMilestones.toString();
            if (headflag == 0) {

                var nxtprevBtn = `<td class="colSmall">
                        <div class="yearDiv d-flex justify-content-center">
                            <div>
                                <i class="far fa-caret-square-left Excel_PrevMonthBtn"
                                    data-bs-toggle="tooltip" title="Previous"
                                    id="DevAgileBM_PrevMonthBtn" onclick="updateTableDisplayPrev();"></i>
                                <i class="far fa-caret-square-right Excel_NextMonthBtn"
                                    data-bs-toggle="tooltip" title="Next"
                                    id="DevAgileBM_NextMonthBtn" onclick="updateTableDisplaynxt();"></i>
                            </div>
                        </div>
                    </td>`;


                var strHtmlmilestonesHead = '';
                var strHtmlEditBtnHead = '';
                var i = 1;
                allKeys.forEach(function (milestone) {

                    var MilestoneName = milestone.split('~');
               //     var IsFreezed = GetDerivedMetricIsFreezed(MilestoneName[1]); 
                    // strHtmlmilestonesHead += '<td class="hideTblTxt sprintCol text-center"><span>' + milestone + '</span></td>';
                    //if (IsFreezed == false) {
                    if (FreezedMilestones.replace(/,/g, "") == "" || FreezedMilestones.indexOf(MilestoneName[1])==-1) {
                        strHtmlmilestonesHead += '<td class="hideTblTxt sprintCol text-center"><span>' + MilestoneName[0] + '</span></td>';
                    }
                    else {
                        strHtmlmilestonesHead += '<td class="hideTblTxt sprintCol text-center"><i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i><span>' + MilestoneName[0] + '</span></td>';
                    }

                    i++;
                });
                $('#tblheadforMilestone').append(strHtmlmilestonesHead);
                $('#tblheadforMilestone').append(nxtprevBtn);
                $('#strHtmlEditBtnHead').append(strHtmlEditBtnHead);
            }

            $.each(data, function (index, metric) {
                console.log(metric);

                var MetricID = metric.MetricID
                var MetricName = (metric.MetricName).trim();
                var Units = metric.Units
                var Target = metric.Target
                var Avg = metric.Average;
                //Added By Ajit L on 03/09/2024 for color
                var UCL = metric.UCL;
                var LCL = metric.LCL;
                var UCLColor = metric.UCLColor;
                var LCLColor = metric.LCLColor;
               //End of Added By Ajit L on 03/09/2024 for color

                //Added by Ajit L on 27/09/2024 to exclude Agile word from metric Name
                if (MetricName.indexOf('Agile') != -1) {
                    MetricName = MetricName.replace('Agile', '')
                }
                 //Added by Ajit L on 27/09/2024


                var values = [];
                var standardDeviation = metric.StandardDeviation;
                var SumMilestone = 0;
                var Count = 0; 
                $.each(metric, function (key, value) {
                   
                    if (!excludedKeys.has(key)) {
                        SumMilestone = SumMilestone + parseFloat(value);
                        Count++; 
                        if (value.indexOf(":") != -1) {
                            value = ConvertDecimalToHourViceVersa(value);
                            values.push(parseFloat(value));
                        }
                        else {
                        values.push(parseFloat(value));
                        }
                    }
                }); 
                        
                if (Count != 0) {
                    Avg = SumMilestone / Count;
                }
                var variance = 0;
                var MathPow = 0;
                $.each(values, function (i, val) {
                    if (Avg < 0) {
                        MathPow= Math.pow(val + (Avg), 2);
                        //variance += Math.pow(val + (Avg), 2);
                    }
                    else {
                        MathPow= Math.pow(val - (Avg), 2);
                        //variance += Math.pow(val - (Avg), 2);
                    }
                    if (MathPow < 0) {
                        variance -= MathPow;
                    }
                    else {
                        variance += MathPow;
                    }
                    
                });

                if (Count > 1) {
                    variance /= (Count - 1);
                }

                var standardDeviation = Math.sqrt(variance);

                var mean = values.reduce(function (acc, val) { return acc + val; }, 0) / Count;

                // Calculate the variance
                if (Count != 0 && Count == 1) {
                    var variance = values.reduce(function (acc, val) {
                        return acc + Math.pow(val - mean, 2);
                    }, 0) / (Count); 
                }
                else {
                    var variance = values.reduce(function (acc, val) {
                        return acc + Math.pow(val - mean, 2);
                    }, 0) / (Count - 1); 
                }

                // Return the standard deviation
                standardDeviation= Math.sqrt(variance);

                SumMilestone = 0;
                variance = 0;


                if (Units == "%" || Units.indexOf("Number")!=-1|| Units.indexOf("number")!=-1|| Units.indexOf("Nos")!=-1|| Units.indexOf("nos")!=-1) {
                    standardDeviation = Math.round(standardDeviation);
                    Avg = Math.round(Avg);
                }
                else {
                    standardDeviation = standardDeviation.toFixed(3);
                    Avg = Avg.toFixed(3);
                    
                }

                var tblRowHTML = `<tr class="ExcldRow">
                                 <td class="sticky_col first_col bg_grayTD text-center">${MetricID}</td>
                                 <td class="sticky_col second_col bg_grayTD">${MetricName}</td>
                                 <td class="sticky_col third_col bg_grayTD text-center"> ${Units}</td> 
                                 <td class="sticky_col forth_col bg_grayTD text-center"> ${Target}</td> 
                                 <td class="sticky_col fifth_col bg_grayTD text-center"> ${Avg}</td>
                                 <td class="sticky_col sixth_col bg_grayTD text-center"> ${standardDeviation}</td>
                                 
                              </tr>`
                var row = $(tblRowHTML);

                $.each(metric, function (key, value) {
                    if (!excludedKeys.has(key)) {

                        //Commented and Added By Ajit L on 03/09/2024 for color
                        // row.append(`<td class="text-center sprintCol"> ${value} </td>`);
                        if (value < LCL) {
                            row.append(`<td class="text-center borderGrey sprintCol"><div style="background-color: ${LCLColor};"><span class="">${value}</span></div></td>`);
                        }
                        else if (value > UCL) {
                            row.append(`<td class="text-center borderGrey sprintCol"><div style="background-color: ${UCLColor};"><span class="">${value}</span></div></td>`);
                        }
                        else {
                            row.append(`<td class="text-center borderGrey sprintCol"> ${value} </td>`);
                        }
                        //End of Commented and Added By Ajit L on 03/09/2024 for color
                    }
                });



                row.append(`<td class="colSmall"></td>`);
                tableBody.append(row);


            });

            return tableBody;
        }

        function PlotProjectonChange() {
            ProjectID = $("#cboProject").val();
            InitialIndex = 0;
            ColumnsCnt = $('#DevAgile_DerivedMetricTbl tbody tr:first .sprintCol').length;
            GetDerivedMetricDetails();
        }

        function ConvertDecimalToHourViceVersa(val) { 
            var Parameters = {
                DataPointValue: val,
                Flag: 2
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/ConvertDecimalToHourViceVersa", param, false);
            return strResult;
        }
      
        function CheckPMSQA() {
            //alert(ProjectID);
            var Parameter = {                ProjectID: ProjectID,                UserID: SessionUserId            }            //debugger            var param = JSON.stringify(Parameter);            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/CheckPMSQA", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var listComponent = strResult[i];
                IsPM =  listComponent.IsPM
                IsSQA = listComponent.IsSQA
                PMID = listComponent.PMID
                SQAID = listComponent.SQAID
                newRequestIdInput = listComponent.TotalRequestCount
                if (SQAID.toString() == SessionUserId) {
                    $("#ApproveRejectedlink").show();
                    $("#btnAddRequest").hide();
                }
                else if (PMID.toString() == SessionUserId) {
                    $("#addWorkflowDetlsBtn").show();
                    $("#btnAddRequest").show();
                }
            }
        }

        function SendForApproval()
        {
          // debugger;
          
            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('AddWorkflowDetlsOffcanvas'));
            myOffcanvas.show();
            //CheckPMSQA();
            //if (IsPM == true) {
            //    $("#SubmitWorkflowBtn").show();
            //    $("#ApproveWorkflowBtn").hide();
            //    $("#RejectWorkflowBtn").hide();
            //}
            //if (IsSQA == true) {
            //    $("#RejectWorkflowBtn").show();
            //    $("#ApproveWorkflowBtn").show();
            //    $("#SubmitWorkflowBtn").hide();
            //}
            $("#ApproveWorkflowBtn").hide();
            $("#RejectWorkflowBtn").hide();
            GetSprintName();
            GetWFList(0)
            $("#WF_ApprovalAddDtlsTab").removeClass('show');
           // newRequestIdInput = newRequestIdInput + 1;
            $("#newRequestIdInput").html(newRequestIdInput);
            $("#SubmitWorkflowBtn").hide();
            //$("#SaveWorkflowBtn").show();
        }



        function GetSprintName() {
            var strHTML = "";
            var Parameter = {                ProjectID: ProjectID,                RequestID: GRequestID            }            var param = JSON.stringify(Parameter);            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetSprintName", param, false); 
            for (var i = 0; i < strResult.length; i++) {
                var listComponent = strResult[i];
                strHTML += ('<option value=' + listComponent.MileStoneID + ' >' + listComponent.MileStone + '</option>');
            }
            if (IsReqFlag == 0) {
                $("#newSprintNameInput").html(strHTML);
                $(".selectpicker").selectpicker('refresh');
            }
            else {
                $("#newSprintNameInputDraft").html(strHTML);
                $(".selectpicker").selectpicker('refresh');
            }

           // $(".selectpicker").selectpicker('refresh');
        }

        var IsFlag = "";
        var IsReqFlag = 0;
        function Add_Request() {
            IsFlag = 0;
            IsReqFlag = 0;
            GRequestID = 0;
            GetSprintName();
            $("#newRemarkInput").val('');
            $("#newRemarkInputdraft").val('');
            $("#newSenderRemarkInput").val('');
            $("#newApprRemarkInput").val('');
            $("#newSprintNameInput").val(0);
            $("#newSprintNameInputDraft").val(0);
            $(".selectpicker").selectpicker('refresh');
            $(".WF_ApprovalDtls_Info").hide();
            $(".WF_ApprovalHistoryInfo").hide();
            $(".WF_ApprovalDtls_Editable").show();
            $("#SaveWorkflowBtn").show();
            //SendForApproval();
        }

        function Save_Onclick() {
           // var Flag = 0;
            //debugger;
            $("#WF_ApprovalAddDtlsTab").addClass('show');
            if (PMID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_PMDefinded") %>", 'error');
                return true;
            }
            else if (PMID.toString() != SessionUserId) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_PMCreateRequest") %>", 'error');
                return true;
            }
            else if ($("#newRemarkInput").val().trim() == "" && GRequestID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_RemarkBlank") %> ", 'error');
                $('#newRemarkInput').focus();
                return;
            }
            else if ($("#newRemarkInputdraft").val().trim() == "" && GRequestID != 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_RemarkBlank") %> ", 'error');
                $('#newRemarkInputdraft').focus();
                return;
            }
            else if ($("#newSprintNameInput").val() == "0" && GRequestID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SprintNameBlank") %>", 'error');
                $('#newSprintNameInput').focus();
                return;
            }
            else if ($("#newSprintNameInputDraft").val() == "0" && GRequestID != 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SprintNameBlank") %>", 'error');
                $('#newSprintNameInputDraft').focus();
                return;
            }
            else if ($("#newSenderCommentsInput").val().trim() == "" && GRequestID != 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SenderRemarksBlank") %> ", 'error');
                $("#newSenderCommentsInput").focus();
                return true;
            }
            else
            {
                var Remarks = "";
                var SprintName = "";
                if (GRequestID == 0) {
                    Remarks = $("#newRemarkInput").val().replace(/'/g, "''");
                    SprintName = $("#newSprintNameInput").val();
                } else {
                    Remarks = $("#newRemarkInputdraft").val().replace(/'/g, "''");
                    SprintName = $("#newSprintNameInputDraft").val();
                }
              var SenderRemark=  $("#newSenderCommentsInput").val().replace(/'/g, "''");
                var Parameter = {                    ProjectID: ProjectID,                    RequestID: GRequestID,                    TemplateID: PrjTempId,                    UserID: SessionUserId,                    SprintID: SprintName,                    Remarks: Remarks,                    UserID: SessionUserId,                    StrUserName: UserName,                    Flag: IsFlag,                    SenderRemarks:SenderRemark                }                var param = JSON.stringify(Parameter);                var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/SaveDetails", param, false);
               // debugger;
                if (strResult != "") {
                    GRequestID = strResult[0].Column1;
                    GetWFList(0);
                    EditEdtApprovalDetls(GRequestID);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("<%= MyBase.GetResourceString("A_RequestCreated") %>", 'sucess');
                }

            }


        }


        var Details = "";
        function GetWFList(RequestID) {
           //GRequestID = RequestID;
            
            var Parameter = {                ProjectID: ProjectID,                RequestID: RequestID,                TemplateID: PrjTempId,                UserID: SessionUserId            }            var HTML = "";            var param = JSON.stringify(Parameter);            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetWFList", param, false);
           // debugger
            if (strResult.length != 0) {
               // newRequestIdInput = strResult.length + 1;
                Details = strResult;
                $("#TbodyWF_ApprovalDetailsTable").html('');
                $("#WF_ApprovalDetailsTable").dataTable().fnDestroy();

                for (var i = 0; i < strResult.length; i++) {
                    var ClsClass = "";
                    if (strResult[i].StatusName == "Draft") {
                        ClsClass = "statusDraft";
                    }
                    else if (strResult[i].StatusName == "Approved") {
                        ClsClass = "statusApproved ";
                    }
                    else if (strResult[i].StatusName == "Rejected") {
                        ClsClass = "statusRejected";
                    }
                    else if (strResult[i].StatusName == "Sent for Approval") {
                        ClsClass = "statusSendApproval";
                    }
                    HTML += "<tr>";
                    HTML += "<td class='text-center'> " + strResult[i].RequestID + "</td>";
                    HTML += "<td class='text-center'>" + strResult[i].MileStone + "</td>";
                    HTML += "<td class='text-center'>" + strResult[i].Remark + "</td>";
                    HTML += "<td class='text-center'>";
                    HTML += " <div class='statusDiv d-flex justify-content-center'>";
                    HTML += "<span class='statusBox " + ClsClass + " mx-2'>&nbsp;</span>";
                    HTML += "<a href='javascript:;'>";
                    HTML += "<label class='crsrLink' data-bs-toggle='tooltip' data-bs-original-title='" + strResult[i].StatusName + "'>" + strResult[i].StatusName + "</label>";
                    HTML += "</a>";
                    HTML += "</div>";
                    HTML += "</td>";
                    HTML += "<td>";
                    HTML += "<div class='d-flex gap-2' style='justify-content:center;align-items: center;'>";
                   // HTML += "<a href='javascript: ; ' id='showHisDevAgileBtn1' onclick='EditApprHisDetls(" + strResult[i].RequestID + ")'>";
                    //HTML += "<a href='javascript: ; ' id='showHisDevAgileBtn1' onclick='EditEdtApprovalDetls(" + strResult[i].RequestID + ")'>";
                    if (strResult[i].WF_HFlag == "Exists"){
                        HTML += "<a href='javascript: ; ' id='showHisDevAgileBtn1' onclick='GetWFSTageDetails(" + strResult[i].RequestID + ", \"onchange\");'>";
                        HTML += "<i class='fas fa-history' data-bs-toggle='tooltip' title='Show History'></i>";
                        HTML += "</a>";
                    } 
                    HTML += "<a href='javascript: ; ' onclick='EditEdtApprovalDetls(" + strResult[i].RequestID + ")'>";
                    HTML += " <i class='fas fa-ellipsis-h' data-bs-toggle='tooltip' title='More Details'></i>";
                    HTML += "</a>";
                    HTML += "</div>";
                    HTML += " </td>";
                    HTML += "</tr>";
                }

                //if (GRequestID == 0) {
                    $("#TbodyWF_ApprovalDetailsTable").html(HTML);
                    $('#WF_ApprovalDetailsTable').dataTable({
                        // "scrollY": true,
                        // "scrollX": true,
                        "paging": true,
                        "pageLength": 5,
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
                    });
                    $('#WF_ApprovalDetailsTable').wrap('<div class="dataTables_scroll" />');
              

            } else {
                $("#WF_ApprovalDetailsTable").dataTable().fnDestroy();
                $("#TbodyWF_ApprovalDetailsTable").html('');
                $('#WF_ApprovalDetailsTable').dataTable({
                    // "scrollY": true,
                    // "scrollX": true,
                    "paging": true,
                    "pageLength": 5,
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
                });
                $('#WF_ApprovalDetailsTable').wrap('<div class="dataTables_scroll" />');
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        function EditEdtApprovalDetls(RequestID) {
            $("#newSenderCommentsInput").val("");
            IsReqFlag = 1;
            CheckPMSQA(); 
            GRequestID = RequestID;

            GetSprintName();
            ArrStatus = [];
            ArrStatusID = [];
            FromWhichAction = "Load";
            $("#WF_ApprovalAddDtlsTab").collapse('show');
            $(".WF_ApprovalDtls_Editable").hide();
            $(".WF_ApprovalHistoryInfo").show();
            $(".WF_ApprovalDtls_Info").show();
            if (IsPM == true) {
            $("#SubmitWorkflowBtn").show();
            }

            $("#SaveWorkflowBtn").hide();
            GetRequestDetails();
            //var HistoryLen = GetWFSTageDetails(GRequestID, FromWhichAction)
            //if (HistoryLen>0){}
          
            $(".WF_ApprovalHistoryInfo").hide();
        }

        //function EditApprHisDetls() {
        //    $("#WF_ApprovalAddDtlsTab").collapse('show')
        //}

        function Submit_Onclick() {
            if (PMID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_PMDefinded") %>", 'error');
                return true;
            }
            else if (SQAID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SQANotDefined") %>", 'error');
                return true;
            }

            else if (PMID.toString() != SessionUserId) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_PMSubmit") %> ", 'error');
                return true;
            }
            else if ($("#newSenderCommentsInput").val().trim() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SenderRemarksBlank") %> ", 'error');
                $("#newSenderCommentsInput").focus();
                return true;
            }

            
           
            var Remarks = $("#newSenderCommentsInput").val().replace(/'/g, "''");
            var Parameter = {                ProjectID: ProjectID,                RequestID: GRequestID,                TemplateID: PrjTempId,                UserID: SessionUserId,                Flag: 1,                Remarks: Remarks            }            var param = JSON.stringify(Parameter);            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/SubmitDetails", param, false);
            if (strResult != "") {

                GetWFList(0);
                GetRequestDetails();
               // GetWFSTageDetails(GRequestID, FromWhichAction);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("<%= MyBase.GetResourceString("A_RequestSubmitted") %>", 'sucess');
                if (strResult == "1") {
                    window.open("../Email/SendEmail.aspx?MessageID=35009&RequestId=" + GRequestID + "&ProjectID=" + ProjectID + "&EmployeeID=" + SessionUserId + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                }
               
            }
        }


       
       
        function GetWFSTageDetails(RequestID, FromWhichAction, ActionFlag) {
            GRequestID = RequestID;
            if (ActionFlag != 1) {
            GetWFStatusFilter(RequestID);
            }

            $("#WF_ApprovalAddDtlsTab").collapse('show');
            $(".WF_ApprovalDtls_Info").hide();
            $(".WF_ApprovalDtls_Editable").hide();
            $(".WF_ApprovalHistoryInfo").show();
            if (FromWhichAction != "Load") {
                var StatusID = $("#ActionTypeHistory").val();
            }
             
            $("#ApprovalHistoryTbl").dataTable().fnDestroy();
            $("#TbodyHistory").html('');
            var Parameter = {                ProjectID: ProjectID,                RequestID: RequestID,                TemplateID: PrjTempId,                UserID: SessionUserId,                FromWhichAction: FromWhichAction,                StatusID: StatusID            }            var HTML = "";            var param = JSON.stringify(Parameter);            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetWFStageDetails", param, false);
            ArrStatus = [];
            ArrStatusID = [];

          // GetWFStatusFilter(RequestID);
            if (strResult.length != 0) {
                $("#ApprovalHistoryTbl").dataTable().fnDestroy();
                $("#TbodyHistory").html('');
                for (var i = 0; i < strResult.length; i++) {
                    var ClsClass = "";
                    if (strResult[i].StatusName == "Draft") {
                        ClsClass = "statusDraft";
                    }
                    else if (strResult[i].StatusName == "Approved") {
                        ClsClass = "statusApproved ";
                    }
                    else if (strResult[i].StatusName == "Rejected") {
                        ClsClass = "statusRejected";
                    }
                    else if (strResult[i].StatusName == "Sent for Approval") {
                        ClsClass = "statusSendApproval";
                    }
                    HTML += "<tr>";
                    HTML += '<td class="text-center">' + strResult[i].ActionOn +'</td>';
                    HTML += '<td class="text-center">';
                    HTML += '<div class="statusDiv d-flex justify-content-start">';
                    HTML += '<span class="statusBox ' + ClsClass +' mx-2">&nbsp;</span>';
                    HTML += '<a href="javascript:;">';
                    HTML += '<label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="' + strResult[i].StatusName + '">' + strResult[i].StatusName +'</label>';
                    HTML += '</a>';
                    HTML += '</div>';
                    HTML += '</td>';
                    HTML += '<td class="text-center">' + strResult[i].ActionTakenBy +'</td>';
                    HTML += '<td class="text-center">' + strResult[i].SenderApproversRemark + '</td>';
                    HTML += "</tr>";
                    ArrStatus.push(strResult[i].StatusName);
                    ArrStatusID.push(strResult[i].StatusID);
                }
                $("#TbodyHistory").html(HTML);
                //if (FromWhichAction == "Load") {
                    
             //   }
                    
            }
            
                $('#ApprovalHistoryTbl').dataTable({
                    "paging": true,
                    "pageLength": 5,
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
                });
                $('#ApprovalHistoryTbl').wrap('<div class="dataTables_scroll" />');
            $('[data-bs-toggle="tooltip"]').tooltip();
            return strResult.length;
        }


        function GetWFStatusFilter(RequestID) {
            debugger
            var strHTML = "";
            //var ArrStatusIDN = unique(ArrStatusID);
            //var ArrStatusN = unique(ArrStatus);
            //strHTML += ('<option value="0" > Action Taken </option>');
            
            var Parameter = {                ProjectID: ProjectID,                RequestID: RequestID            }            var param = JSON.stringify(Parameter);            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/GetWFStageActions", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var Data=strResult[i]
                strHTML += ('<option value=' + Data.StatusID + ' > ' + Data.StatusName + '</option>');
            }

            $("#ActionTypeHistory").html(strHTML);
            $(".selectpicker").selectpicker('refresh');
        }

      
        function GetFilterStatus(FromWhichAction) {
           // alert(GRequestID);
            FromWhichAction = FromWhichAction
            GetWFSTageDetails(GRequestID,FromWhichAction,1);
        }

        function ApproveRejectOnClick(Flag) {

            if (SQAID.toString() != SessionUserId && Flag == 2) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SQAApproved")%>", 'error');
                return true;
            }

            else if (SQAID.toString() != SessionUserId && Flag == 3) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_SQAReject")%>", 'error');
                return true;
            }

            else if ($("#RejectedRemakrs").val().trim() == "" && Flag == 3) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_RejectionRemarks")%>", 'error');
                $("#RejectedRemakrs").focus();
                return true;
            }

           
            else if ($("#ApproverRemakrs").val().trim() == "" && Flag == 2) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_ApprovalRemarks")%>", 'error');
                $("#ApproverRemakrs").focus();
                return true;
            }
            var Remarks = "";
            if (Flag == 2) {
                 Remarks = $("#ApproverRemakrs").val().replace(/'/g, "''");
            }

            else if (Flag == 3) {
                Remarks = $("#RejectedRemakrs").val().replace(/'/g, "''");
            }
           
            var Parameter = {                ProjectID: ProjectID,                RequestID: GRequestID,                TemplateID: PrjTempId,                UserID: SessionUserId,                Flag: Flag,                Remarks: Remarks            }            var param = JSON.stringify(Parameter);            var strResult = AJAXCallWithResult("/api/PM_DerivedMetricReport/SubmitDetails", param, false);
            //debugger
            if (strResult != "") {

           
               // GetWFSTageDetails(GRequestID, FromWhichAction);
                alertify.set('notifier', 'position', 'top-right');
                var MessageID = "";
                if (Flag == 2) {
                    MessageID = "35010";
                    alertify.success("<%= MyBase.GetResourceString("A_RequestApproved")%>", 'sucess');
                    $("#ApprovalRemarkModal").modal('hide');
                }
                else if (Flag == 3) {
                    MessageID = "35011";
                    alertify.success("<%= MyBase.GetResourceString("A_RequestRejected")%>", 'sucess');
                    $("#RejectRemarkModal").modal('hide');
                }

                if (strResult == "1") {
                    window.open("../Email/SendEmail.aspx?MessageID=" + MessageID + "&RequestId=" + GRequestID + "&ProjectID=" + ProjectID + "&EmployeeID=" + SessionUserId + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                }
                GetWFList(0);
                GetRequestDetails();
            }
            GetDerivedMetricDetails();
           // $("#closeWorkflowBtn").click();

        }


        function GetRequestDetails() {
            
            for (var i = 0; i < Details.length; i++) {
                if (GRequestID == Details[i].RequestID) {
                    //alert(SQAID.toString());
                    //debugger;
                    if (PMID.toString() == SessionUserId && Details[i].StatusID == 0) {
                        $("#newRemarkLabel").text(Details[i].Remark);
                        $("#newRemarkInputdraft").val(Details[i].Remark);
                        $("#newSenderCommentsInput").val(Details[i].SendersRemark);
                        $("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        $("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                        $("#newRequestIdLabel").text(Details[i].RequestID);
                        $("#DivSender").show();
                        $("#DivApprover").hide();
                        $("#DivRemarks").show();
                        $("#SubmitWorkflowBtn").show()
                        $("#SaveWorkflowBtn").show()
                    }

                    else if (PMID.toString() == SessionUserId && Details[i].StatusID == 1) {
                        //$("#newRemarkLabel").text(Details[i].Remark);
                        $("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        $("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                        $("#newRequestIdLabel").text(Details[i].RequestID);
                        $("#DivSender").show();
                        $("#DivApprover").hide();
                        $("#SaveWorkflowBtn").hide();
                        $("#DivRemarks").show();
                        $("#SubmitWorkflowBtn").hide()
                        if (SQAID.toString() == SessionUserId) {
                            $("#ApproveWorkflowBtn").show()
                            $("#RejectWorkflowBtn").show()
                        }
                    }
                    else if (SQAID.toString() == SessionUserId && Details[i].StatusID == 1) {
                        //$("#newRemarkLabel").text(Details[i].Remark);
                        $("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        //$("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                        $("#newRequestIdLabel").text(Details[i].RequestID);
                        $("#DivSender").show();
                        $("#DivApprover").hide();
                        $("#SaveWorkflowBtn").hide();
                        $("#DivRemarks").show();
                        $("#SubmitWorkflowBtn").hide()
                        $("#ApproveWorkflowBtn").show()
                        $("#RejectWorkflowBtn").show()
                    }

                    else if (SQAID.toString() == SessionUserId && Details[i].StatusID == 2) {
                        //$("#newRemarkLabel").text(Details[i].Remark);
                        $("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        $("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                        $("#newRequestIdLabel").text(Details[i].RequestID);
                        $("#DivSender").show();
                        $("#DivApprover").show();
                        $("#DivRemarks").show();
                        $("#SubmitWorkflowBtn").hide()
                        $("#SaveWorkflowBtn").hide()
                        $("#ApproveWorkflowBtn").hide()
                        $("#RejectWorkflowBtn").hide()
                        $("#newSenderCommentsInput").hide()
                        //$("#SaveWorkflowBtn").hide()
                    }

                    else if (SQAID.toString() == SessionUserId && Details[i].StatusID == 3) {
                        //$("#newRemarkLabel").text(Details[i].Remark);
                        $("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        $("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                        $("#newRequestIdLabel").text(Details[i].RequestID);
                        $("#DivSender").show();
                        $("#DivApprover").show();
                        $("#DivRemarks").show();
                        $("#SubmitWorkflowBtn").hide()
                       // $("#newSenderCommentsInput").show()
                        $("#ApproveWorkflowBtn").hide()
                        $("#RejectWorkflowBtn").hide()

                    }
                   
                    $("#newRequestIdLabel").text(Details[i].RequestID);
                    $("#newSprintNameLabel").text(Details[i].MileStone);
                    $("#newRemarkLabel").text(Details[i].Remark);
                    //alert(Details[i].SprintID);
                    if (Details[i].StatusID == 0) {
                        $("#DivSenderComments").show();
                        $("#DivSender").hide();
                        $("#DivApprover").hide();
                        $("#DivRemarksDraft").show();
                        $("#DivSprintDraft").show();
                        $("#newSprintNameInputDraft").val(Details[i].SprintID);
                        $(".selectpicker").selectpicker('refresh');
                        $("#DivRemarks").hide();
                        $("#DivSprint").hide();
                    }
                    else if (Details[i].StatusID == 1) {
                        $("#DivSenderComments").hide();
                        $("#SubmitWorkflowBtn").hide();
                        $("#DivSender").show();
                        $("#DivApprover").hide();
                        $("#DivRemarks").show();
                        $("#DivSprint").show();
                        $("#DivRemarksDraft").hide();
                        $("#DivSprintDraft").hide();
                        
                        $("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        //$("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                    }
                    else if (Details[i].StatusID == 2 || Details[i].StatusID == 3) {
                        $("#DivSenderComments").hide();
                        $("#DivSender").show();
                        $("#DivApprover").show();
                        $("#DivRemarks").show();
                        $("#DivSprint").show();
                        $("#SubmitWorkflowBtn").hide();
                        $("#DivRemarksDraft").hide();
                        $("#DivSprintDraft").hide();
                        $("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        $("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                    }
                  
                    if (Details[i].StatusID == 3 && PMID.toString()==SessionUserId) {
                        $("#DivSenderComments").show();
                        $("#DivSender").hide();
                        $("#DivApprover").hide();
                        $("#DivRemarks").show();
                        $("#DivSprint").show();
                        $("#SubmitWorkflowBtn").show();
                        $("#ApproveWorkflowBtn").hide()
                        $("#RejectWorkflowBtn").hide()
                        $("#newSenderCommentsInput").show()
                        //$("#newSenderRemarkLabel").text(Details[i].SendersRemark);
                        //$("#newApprRemarkLabel").text(Details[i].ApproversRemark);
                    }
                    
                        
                }
                $(".selectpicker").selectpicker('refresh');
            }
        }


        //Remove Duplicate From Array 
        function unique(array) {
            return array.filter(function (el, index, arr) {
                return index == arr.indexOf(el);
            });
        }

        var ajaxResult = "";
        function AJAXCallWithResult(url, param, async) {
            StartLoader("#BodyDerivedMetric");

            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {

                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    //console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#BodyDerivedMetric");
            return ajaxResult;
        }

        function StartLoader(bodyID) {

            var progress2 = new LoadingOverlayProgress({
                bar: {
                    "background": "#ddd",
                    "top": "50px",
                    "left": "0px",
                    "right": "0px",
                    "height": "90px",
                    "width": "90px",
                    "margin": "auto",
                    "border-radius": "15px",
                    "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .2 ) 100% 100% no-repeat"
                },
            });
            $(bodyID).LoadingOverlay("show", {
                custom: progress2.Init()
            });
        }

        function StopLoader(bodyID) {
            jQuery(window).load(function () {
                $(bodyID).LoadingOverlay("hide", {

                });
            });
        }

        function StopAjaxLoader(bodyID) {
            $(bodyID).LoadingOverlay("hide", {

            });
        }

        function Clearall(flag) {
            if (flag == 2) {
                $("#ApproverRemakrs").val("");
            }
            else {
                $("#RejectedRemakrs").val("");
            }
        }
         
    </script>

</body>

</html>
