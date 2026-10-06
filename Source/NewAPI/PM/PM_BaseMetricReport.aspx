<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_BaseMetricReport.aspx.vb" Inherits="Whizible.PM_BaseMetricReport" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Base Metric")%> 
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

        .text_small {
            font-size: 12px;
        }


        .offcanvas {
            --bs-offcanvas-width: 82% !important;
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

        .bootstrap-select .dropdown-menu {
            max-width: 100%;
            /* position: absolute !important;
            z-index: 7;
            min-height: 210px !important; */
        }

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
            width: 120px;
        }

        .loadingoverlay_progress_bar {
            left: 0 !important;
            right: 0 !important;
        }

        .fieldDisabled {
            
            cursor: no-drop;
            
        }

        .fieldDisabledOnceCopied {
            cursor: no-drop;
            
        }

        #MetricShowHistoryTable .dataTables_empty {
            text-align: center !important;
        }

         /* Added by Ajit l on 02/10/2024*/
        .loadingoverlay_progress_bar {
            left: 0 !important;
            right: 0 !important;
        }
         /* End of Added by Ajit l on 02/10/2024*/
    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed" id="base_metric">
     <%If m_blnViewAccess = True Then%>
    <div class="container-fluid pt-1 pb-1 text-end graybg d-flex justify-content-between">
        <h5 class="pgtitle"><%= MyBase.GetResourceString("C_Caption") %></h5>
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
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectName", "select 0",,, "class='selectpicker' data-live-search='true'",,,) %>
                                <%--<select class="selectpicker" data-live-search="true">
                                    <option>Select Project</option>
                                    <option>Project 01</option>
                                    <option>Project 02</option>
                                    <option>Project 03</option>
                                    <option>Project 04</option>
                                </select>--%>
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
                                    <span class="lbtext_small col-sm-6 text-end"> <%= MyBase.GetResourceString("C_Client") %> </span>
                                    <span class="text_small col-sm-6">
                                        <label id="lblClientName"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <span class="lbtext_small col-sm-6 text-end"><%= MyBase.GetResourceString("C_PrjCode") %></span>
                                    <span class="text_small col-sm-6">
                                        <label id="lblProjectCode"></label>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <span class="lbtext_small col-sm-6 text-end"><%= MyBase.GetResourceString("C_PrjType") %></span>
                                    <span class="text_small col-sm-6">
                                        <label id="lblProjectType"></label>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Dev-Maintenance (Agile) Template Details Added by Gauri start here -->
                <div class="allMetricSec" id="MetricTemplateSec1">
                    <div class="allWorkflowTabsDiv">
                        <div class="row flex-1">
                            <div class="col-sm-6">
                                <ul class="nav nav-tabs mb-2 pe-3" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="DevAgile_TabBaseMetric" data-bs-toggle="tab"
                                            data-bs-target="#DevAgile_BaseMetricTab" type="button" role="tab"
                                            aria-selected="false" tabindex="-1">
                                           <%= MyBase.GetResourceString("C_Caption") %>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="tab-content mt-2">
                        <div id="DevAgile_BaseMetricTab" class="tab-pane active" role="tabpanel">
                            <div class="MetricTblPanel2" id="">
                                <div class="scrollTable  table-responsive" id="DevAgile_BM_ScrollTable">
                                    <%--<table id="BaseMetricTbl"
                                        class="table table-fixed-header borderGrey BaseMetricTbl stickyTblHeader ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <tbody class="">
                                            <tr id="tblheadforMilestone">
                                                <td class="col-sm-1 sticky_col first_col bg_Milestone text-center">
                                                    Datapoint <br> Id</td>
                                                <td class="col-sm-1 sticky_col second_col bg_Milestone">Metric</td>
                                                <td class="col-sm-1 sticky_col third_col bg_Milestone text-center">Units
                                                </td>
                                                <td class="col-sm-1 sticky_col forth_col bg_Milestone text-center">
                                                    Cumulative</td>--%>
                                    <%--<td class="hideTblTxt sprintCol text-center">
                                                    <i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i>
                                                    <span>M1</span> 
                                                </td>
                                                <td class="hideTblTxt sprintCol text-center">
                                                    <span>M2</span>
                                                </td>
                                                <td class="hideTblTxt sprintCol text-center">
                                                    <i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i>
                                                    <span>M3</span>
                                                </td>
                                                <td class="hideTblTxt sprintCol text-center"><span>M4</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>M5</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>M6</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>M7</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>M8</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>M9</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 5</span></td>
                                                <td class="hideTblTxt sprintCol text-center"><span>Sprint 6</span></td>--%>

                                    <%--<td class="colSmall">
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
                                                </td>
                                            </tr>
                                            
                                            <tr id="strHtmlEditBtnHead" class="">
                                                <td class="sticky_col first_col"></td>
                                                <td class="sticky_col second_col"></td>
                                                <td class="sticky_col third_col"></td>
                                                <td class="sticky_col forth_col"></td>
                                                <td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn1" data-bs-toggle="tooltip"
                                                                    title="Enable Edit">
                                                                <span class="slider"></span>
                                                            </label>
                                                        </div>
                                                        <div class="tblIcons d-flex gap-2">
                                                            <a href="javascript:;" class="textUndrln" id="showHisDevAgileBM_Btn1" data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcanvas_ShowMetric_History"><i class="fas fa-history"
                                                                    data-bs-toggle="tooltip" title="Show History"></i></a>
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn1" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn2" data-bs-toggle="tooltip"
                                                                    title="Enable Edit">
                                                                <span class="slider"></span>
                                                            </label>
                                                        </div>
                                                        <div class="tblIcons d-flex gap-2">
                                                            <a href="javascript:;" class="textUndrln" id="CopyExcelDevAgileBM_Btn2" data-bs-toggle="tooltip"
                                                                title="Copy from previous"><i class="far fa-copy"></i></a>
                                                            <a href="javascript:;" class="textUndrln" id="showHisDevAgileBM_Btn2" data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcanvas_ShowMetric_History"><i class="fas fa-history"
                                                                    data-bs-toggle="tooltip" title="Show History"></i></a>
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn2" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn3" data-bs-toggle="tooltip"
                                                                    title="Enable Edit">
                                                                <span class="slider"></span>
                                                            </label>
                                                        </div>
                                                        <div class="tblIcons d-flex gap-2">
                                                            <a href="javascript:;" class="textUndrln" id="CopyExcelDevAgileBM_Btn3" data-bs-toggle="tooltip"
                                                                title="Copy from previous"><i class="far fa-copy"></i></a>
                                                            <a href="javascript:;" class="textUndrln" id="showHisDevAgileBM_Btn3" data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcanvas_ShowMetric_History"><i class="fas fa-history"
                                                                    data-bs-toggle="tooltip" title="Show History"></i></a>
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn3" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn4" data-bs-toggle="tooltip"
                                                                    title="Enable Edit">
                                                                <span class="slider"></span>
                                                            </label>
                                                        </div>
                                                        <div class="tblIcons d-flex gap-2">
                                                            <a href="javascript:;" class="textUndrln" id="CopyExcelDevAgileBM_Btn4" data-bs-toggle="tooltip"
                                                                title="Copy from previous"><i class="far fa-copy"></i></a>
                                                            <a href="javascript:;" class="textUndrln" id="showHisDevAgileBM_Btn4" data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcanvas_ShowMetric_History"><i class="fas fa-history"
                                                                    data-bs-toggle="tooltip" title="Show History"></i></a>
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn4" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn5" data-bs-toggle="tooltip"
                                                                    title="Enable Edit">
                                                                <span class="slider"></span>
                                                            </label>
                                                        </div>
                                                        <div class="tblIcons d-flex gap-2">
                                                            <a href="javascript:;" class="textUndrln" id="CopyExcelDevAgileBM_Btn5" data-bs-toggle="tooltip"
                                                                title="Copy from previous"><i class="far fa-copy"></i></a>
                                                            <a href="javascript:;" class="textUndrln" id="showHisDevAgileBM_Btn5" data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcanvas_ShowMetric_History"><i class="fas fa-history"
                                                                    data-bs-toggle="tooltip" title="Show History"></i></a>
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn5" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn6" data-bs-toggle="tooltip"
                                                                    title="Enable Edit">
                                                                <span class="slider"></span>
                                                            </label>
                                                        </div>
                                                        <div class="tblIcons d-flex gap-2">
                                                            <a href="javascript:;" class="textUndrln" id="CopyExcelDevAgileBM_Btn6" data-bs-toggle="tooltip"
                                                                title="Copy from previous"><i class="far fa-copy"></i></a>
                                                            <a href="javascript:;" class="textUndrln" id="showHisDevAgileBM_Btn6" data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcanvas_ShowMetric_History"><i class="fas fa-history"
                                                                    data-bs-toggle="tooltip" title="Show History"></i></a>
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn5" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>
                                                
                                                <<td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <div id="tableContainer"></div>--%>
                                    <%--<table id="DevAgile_BaseMetricTbl2"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <!-- Scope Management -->
                                        <tbody>
                                            <tr class="rowHeading">
                                                <td class="sticky_col first_col" colspan="4">Scope Management</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">1</td>
                                                <td class="sticky_col second_col bg_grayTD">User Stories Planned</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Us.St</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">2</td>
                                                <td class="sticky_col second_col bg_grayTD">User Stories Changed</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Us.St</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">3</td>
                                                <td class="sticky_col second_col bg_grayTD">User Stories
                                                    Discovered/Added</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Us.St</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">4</td>
                                                <td class="sticky_col second_col bg_grayTD">User Stories Deleted</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Us.St</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">5</td>
                                                <td class="sticky_col second_col bg_grayTD">User Stories Completed</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Us.St</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">6</td>
                                                <td class="sticky_col second_col bg_grayTD">User Stories Accepted</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Us.St</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">7</td>
                                                <td class="sticky_col second_col bg_grayTD">Story Points Planned</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">St.Pt</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">8</td>
                                                <td class="sticky_col second_col bg_grayTD">Story Points Completed</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">St.Pt</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">9</td>
                                                <td class="sticky_col second_col bg_grayTD">Story Points Un-Completed
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">St.Pt</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">11</td>
                                                <td class="sticky_col second_col bg_grayTD">Unit Test Coverage</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">%</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0%</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <table id="DevAgile_BaseMetricTbl3"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <!-- Effort Data -->
                                        <tbody>
                                            <tr class="rowHeading">
                                                <td class="sticky_col first_col" colspan="4">Effort Data</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">12</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Backlog
                                                    Grooming</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">13</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Analysis
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">14</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for
                                                    Requirement activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">15</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Design
                                                    activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">16</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Coding
                                                    activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">17</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort on Unit
                                                    Testing</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">18</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Planned Effort for
                                                    Test Case Design</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">19</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Planned Effort for
                                                    Test Case Execution</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">20</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Planned Effort
                                                    for Test Script Design</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">21</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort For User
                                                    Acceptance Testing</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">22</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Code
                                                    Reviews</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">23</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Code
                                                    Rework</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">24</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Planned Effort for
                                                    Test Case Review</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">25</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Planned Effort for
                                                    Test Case Rework</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">26</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Planned Effort
                                                    for Test Script Review</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">27</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Planned Effort
                                                    for Test Script Rework</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">28</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Backlog
                                                    Grooming</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">29</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Analysis
                                                </td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">30</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for
                                                    Requirement activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">31</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Design
                                                    activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">32</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Coding
                                                    activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">33</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort on Unit
                                                    Testing</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">34</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Actual Effort for
                                                    Test Case Design</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">35</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Actual Effort for
                                                    Test Case Execution</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">36</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Actual Effort
                                                    for Test Script Design</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">37</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort For User
                                                    Acceptance Testing</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">38</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Code
                                                    Reviews</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">39</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Coding
                                                    Rework</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">40</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Actual Effort for
                                                    Test Case Review</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">41</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Actual Effort for
                                                    Test Case Rework</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">42</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Actual Effort
                                                    for Test Script Review</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">43</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Actual Effort
                                                    for Test Script Rework</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <table id="DevAgile_BaseMetricTbl4"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <!-- Testing Activities -->
                                        <tbody>
                                            <tr class="rowHeading">
                                                <td class="sticky_col first_col" colspan="4">Testing Activities</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">44</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - No.of Test Cases
                                                    Designed</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">45</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - No.of Test Cases
                                                    Planned to Execute</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">46</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Actual No.of Test
                                                    Cases Executed</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">47</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - No.of Test
                                                    Scripts Designed</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <table id="DevAgile_BaseMetricTbl5"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <!-- Defects Data -->
                                        <tbody>
                                            <tr class="rowHeading">
                                                <td class="sticky_col first_col" colspan="4">Defects Data</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <!-- <tr class="rowheading">
                                                <td class="sticky_col first_col" colspan="4">Defects Data</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr> -->
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">48</td>
                                                <td class="sticky_col second_col bg_grayTD">Number of Defects -
                                                    Requirements Phase</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">49</td>
                                                <td class="sticky_col second_col bg_grayTD">Number of Defects - Design
                                                    Phase</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">50</td>
                                                <td class="sticky_col second_col bg_grayTD">Number of Defects - Coding
                                                    Phase</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">51</td>
                                                <td class="sticky_col second_col bg_grayTD">Number of Unit Testing
                                                    Defects</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">52</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Number of Test Case
                                                    Review Defects</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">53</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Number of Test
                                                    Scripts Review Defects</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">54</td>
                                                <td class="sticky_col second_col bg_grayTD">Manual - Number of Testing
                                                    Defects</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">55</td>
                                                <td class="sticky_col second_col bg_grayTD">Automation - Number of
                                                    Testing Defects</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">56</td>
                                                <td class="sticky_col second_col bg_grayTD">Number of Post Release
                                                    Defects</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Number</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <table id="DevAgile_BaseMetricTbl6"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <!-- Production Issues/Ticket fixing -->
                                        <tbody>
                                            <tr class="rowHeading">
                                                <td class="sticky_col first_col" colspan="4">Production Issues/Ticket
                                                    fixing</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">57</td>
                                                <td class="sticky_col second_col bg_grayTD">Number of Issues/Tickets
                                                    Received</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Tickets</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">58</td>
                                                <td class="sticky_col second_col bg_grayTD">Number of Issues/Tickets
                                                    Resolved</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Tickets</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">59</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for
                                                    Issues/Ticket fixing Activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">60</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for
                                                    Issues/Ticket fixing Activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <table id="DevAgile_BaseMetricTbl7"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <!-- Project Management Activities -->
                                        <tbody>
                                            <tr class="rowHeading">
                                                <td class="sticky_col first_col" colspan="4">Project Management
                                                    Activities</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">61</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Project
                                                    Management Activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">62</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Project
                                                    Management Activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <table id="DevAgile_BaseMetricTbl8"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <!-- Support Activities -->
                                        <tbody>
                                            <tr class="rowHeading">
                                                <td class="sticky_col first_col" colspan="4">Support Activities</td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="sprintCol"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">63</td>
                                                <td class="sticky_col second_col bg_grayTD">Planned Effort for Support
                                                    Activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="colSmall"></td>
                                            </tr>
                                            <tr>
                                                <td class="sticky_col first_col bg_grayTD text-center">64</td>
                                                <td class="sticky_col second_col bg_grayTD">Actual Effort for Support
                                                    Activities</td>
                                                <td class="sticky_col third_col bg_grayTD text-center">Hrs</td>
                                                <td class="sticky_col forth_col bg_grayTD text-center">0</td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
                                                <td class="text-center sprintCol"><input type="number" class="form-control inputWidth"></td>
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
                <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
                    id="offcanvas_ShowMetric_History">
                    <div class="offcanvas-body">
                        <div class="container-fluid py-2 graybg mb-2">
                            <div class="row align-items-center">
                                <div class="col-sm-12">
                                    <div class="d-flex align-items-center font-weight-600">
                                       <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                        <h5 class="pgtitle"><%= MyBase.GetResourceString("C_HistoryDetails") %></h5>
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
                                    <%= MyBase.GetResourceString("C_Close") %>    
                                    </button>
                                </div>
                            </div>

                            <div class="showHistoryFltr">
                                <div class="row d-flex justify-content-center my-3">
                                    <div class="col-sm-5">
                                        <div class="row">
                                            <div class="col-sm-6 d-flex justify-content-end">
                                                <label><%= MyBase.GetResourceString("C_ModifiedField") %> :  </label>
                                            </div>
                                            <div class="col-sm-6">
                                                <select class="selectpicker" data-live-search="true"
                                                    id="ModifiedHisFieldInput">
                                                    <%-- <option>Select Option</option>
                                                    <option>Field 1</option>
                                                    <option>Field 2</option>
                                                    <option>Field 3</option>
                                                    <option>Field 4</option>--%>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <div class="row">
                                            <div class="col-sm-6 d-flex justify-content-end">
                                                <label><%= MyBase.GetResourceString("C_ModifiedBy") %> : </label>
                                            </div>
                                            <div class="col-sm-6">
                                                <select class="selectpicker" data-live-search="true"
                                                    id="ModifiedHisByInput">
                                                    <%-- <option>Select Option</option>
                                                    <option>User 1</option>
                                                    <option>User 2</option>
                                                    <option>User 3</option>--%>
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
                                                    <th class="text-start"><%= MyBase.GetResourceString("C_ModifiedField") %></th>
                                                    <th class="text-start"><%= MyBase.GetResourceString("C_SprintName") %> </th>
                                                    <th class="text-start"><%= MyBase.GetResourceString("C_OldValue") %> </th>
                                                    <th class="text-start"><%= MyBase.GetResourceString("C_NewValue") %> </th>
                                                    <th class="text-start"><%= MyBase.GetResourceString("C_ModifiedDate") %> </th>
                                                    <th class="text-start"><%= MyBase.GetResourceString("C_ModifiedBy") %></th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbodyMetricShowHistoryTable">
                                                <%--<tr>
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
                                                </tr>--%>
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

                <!--Approval Remark modal start here-->
                <div class="modal custmodal fade" id="ApprovalRemarkModal" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="">Approval Remark</h5>
                                <button type="button" class="close" data-bs-dismiss="modal">
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
                                    <label class="required">Approval Comment: </label>
                                    <div class="col-sm-12">
                                        <textarea rows="3" class="form-control required"></textarea>
                                    </div>
                                </div>
                                <div class="text-center my-2">
                                    <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                                        data-bs-original-title="Approve">Approve</a>
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"
                                        data-bs-toggle="tooltip" data-bs-original-title="Cancel">Cancel</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Approval Remark modal end here-->

                <!-- Reject Remark modal start here-->
                <div class="modal custmodal fade" id="RejectRemarkModal" aria-hidden="true">
                    <div class="modal-dialog modal-md" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="">Reject Remark</h5>
                                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
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
                                    <label class="required">Rejection Comment: </label>
                                    <div class="col-sm-12">
                                        <textarea rows="3" class="form-control required"></textarea>
                                    </div>
                                </div>
                                <div class="text-center my-2">
                                    <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                                        data-bs-original-title="Reject">Reject</a>
                                    <a href="javascript:;" class="btn borderbtn mr-5" data-bs-dismiss="modal"
                                        data-bs-toggle="tooltip" data-bs-original-title="Cancel">Cancel</a>
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
        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var strUrl_Cust = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>';
        var SessionProjectID = '<%= Session("intProjectID") %>';
        var UserId = '<%= Session("intUserId") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var PMIID = '';
        var plLastcheckbox = '';
        var plLastColumnIndex = '';
        var plLastmilestoneid = '';


        //function for ajax call
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            StartLoader("#base_metric");
            $.ajax({
                url: encodeURI(strUrl_Cust + url),
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
                    ajaxResult = undefined;
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#base_metric");
            return ajaxResult;
        }


        //
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

        //

        var RoleDescription = '';
        function GetRoleDetails() {
            //debugger;
            var ProjectId = $('#cboProjectName').val();
            var parameter = {
                UserID: UserId,
                ProjectID: ProjectId
            }
            var param = JSON.stringify(parameter);
            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetRoleDetails", param, false);

            if (strResult.length !== 0) {
                for (var i = 0; i < strResult.length; i++) {
                    RoleDescription = strResult[i].RoleDescription;
                }
            } else {
                RoleDescription = ''

            }
        }


        function GetSessionProjDetails(ProjectID) {
            //debugger
            var Parameters = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetSessionProjDetails", param, false);
            //console.log(strResult);
            PMIID = strResult[0].PMIID;
            $("#lblPMITemplate").text(strResult[0].TemplateName);
            $("#lblClientName ").text(strResult[0].CustomerName);
            $("#lblProjectCode").text(strResult[0].ProjectCode);
            $("#lblProjectType").text(strResult[0].ProjectType);
            // pageLoad();
        }

        function GetTemplatewiseAccessibleProject(TemplateID) {
            //debugger
            var Parameter = {
                TemplateID: TemplateID,
                UserID: UserId,
                LoginType: LoginType
            }
            var param = JSON.stringify(Parameter);

            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetTemplatewiseAccessibleProject", param, false);
            if (strResult != null && strResult != undefined && strResult != "") {
                var strHTML = '';
                for (var i = 0; i < strResult.length; i++) {
                    var ListComponent = strResult[i];
                    strHTML += ('<option value="' + ListComponent.ProjectID + '">' + ListComponent.ProjectName + '</option>');
                }
                $("#cboProjectName").html('');
                $("#cboProjectName").html(strHTML);
                $(".selectpicker").selectpicker('refresh');
                $("#tbl_template").val();

            }
        }

        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);
                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }

        var DropdownProJID = 0;
        $('#cboProjectName').on('change', function () {
          //  debugger;
            DropdownProJID = $('#cboProjectName').val();
            //ProjectID = $("#cboProject").val();
            if (DropdownProJID == undefined || DropdownProJID == 0) {
                DropdownProJID = SessionProjectID;
            }
            else {
                DropdownProJID = DropdownProJID;
            }

            GetSessionProjDetails(DropdownProJID);
            pageLoad();
            //$('[data-bs-toggle="tooltip"]').tooltip();//Added By Dipali
        });




        $(document).ready(function () {
            
            GetSessionProjDetails(SessionProjectID);
            GetTemplatewiseAccessibleProject(PMIID);
            $('#cboProjectName').val(SessionProjectID);
            $(".selectpicker").selectpicker('refresh');
            GetRoleDetails();
            pageLoad();
            $('[data-bs-toggle="tooltip"]').tooltip();
        });

        function pageLoad() {
            GetRoleDetails();
            BaseMetrictableAppend();
            //
            RefreshList();
            LastColumnIndex = '';
        }

        var InitialIndex = 0;
        function RefreshList() {
            $(".sprintCol").hide();
            
            var ColumnsCnt = $('.BaseMetricTbl tbody tr:first .sprintCol').length;

            function updateTableDisplay() {
                $('.BaseMetricTbl tbody tr').each(function () {
                    $(this).find('td.sprintCol').hide();
                    $(this).find('td.sprintCol').slice(InitialIndex, InitialIndex + 3).css('display', 'table-cell');
                });

                $('#DevAgileBM_PrevMonthBtn').prop('disabled', InitialIndex <= 0);
                $('#DevAgileBM_NextMonthBtn').prop('disabled', InitialIndex >= ColumnsCnt - 3);

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
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        //iNSERT UPDATE 

        function validatehrs(inp) {
           // debugger
            const regex = /^\d+:[0-5][0-9]$/;
            <%--if (inp.value == '') {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Please enter Atleast one value");
                alertify.error("<%= MyBase.GetResourceString("A_Textbox") %>", 'error');

                return false;
            }--%>
            if (inp.value != '') {
                if (!regex.test(inp.value)) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("ENTER HH:MM");
                    alertify.error("<%= MyBase.GetResourceString("A_HHMM") %>", 'error');
                    inp.value = '';  // Clear the input if it is invalid
                    return false;
                }
            }
            

            handleBlur(inp);
        }

        function validateinputs(inp) { 
            const regex = /^\d+:[0-5][0-9]$/;
            if (inp.value == 'NA') {
                inp.value = '';
                <%--if (!regex.test(inp.value)) {
                    //alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("");
                    //alertify.error("<%= MyBase.GetResourceString("A_HHMM") %>", 'error');
                    inp.value = '';  // Clear the input if it is invalid
                    
                    
                }--%>
            }
            handleBlur(inp);
            
        }

        function handleBlur(inp) {
          //  debugger;
            var ValidFlag = 1;

            var projId = $('#cboProjectName').val();
            //alert(projId);
            var TempID = PMIID;
            var CategoryId = '';
            var MileStoneId = '';
            var MetricDataPointId = '';
            var MetricDataPointValue = '';
            var input = $(inp);
            var td = input.closest('td');
            var tr = td.closest('tr');
            var tbody = tr.closest('tbody');
            var AttrValue = input.val().replace(/\s+/g, ' ').trim();
            var isblankSave = 0;
            MetricDataPointValue = AttrValue;
           // console.log(MetricDataPointValue);
            //Added By Riddhesh Patil on 29 Aug 2024 for focus issue
            var container = $('#DevAgile_BM_ScrollTable');
            var scrollPosition = container.scrollTop();
            //End of Added By Riddhesh Patil on 29 Aug 2024 for focus issue
            if (AttrValue == '') {



                <%--alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Please enter Atleast one value");
                alertify.error("<%= MyBase.GetResourceString("A_Textbox") %>", 'error');

                ValidFlag = 0;
                return ValidFlag;
                return false;--%>
                isblankSave = 1;
            }

            var precision = AttrValue.split(":")[1];
            if (precision >= 60) {
                //showAlert('Please enter minutes less than 60.', 'alert-danger');
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Please enter minutes in two decimal and less than 60.");
                alertify.error("<%= MyBase.GetResourceString("A_ValidateHrs") %>", 'error');
                ValidFlag = 0;
                return ValidFlag;
                return false;
                //return false;
            }
            

            MileStoneId = td.attr('id').split('~')[0];
            MetricDataPointId = tr.attr('id').split('~')[1];
            CategoryId = tbody.attr('id').split('~')[1];
            MetricDataPointValue = MetricDataPointValue.replace(/,/g, "");
            if (ValidFlag == 1) {
                // Perform any other actions here
                //alert("hi");
                var Parameters = {
                    "ProjectID": projId,
                    "TemplateID": TempID,
                    "MilestoneID": MileStoneId,
                    "DataPointID": MetricDataPointId,
                    "DataPointvalue": MetricDataPointValue,
                    "CategoeryID": CategoryId,
                    "UserName": UserName,
                    "IsblankSave": isblankSave
                }
                
                var param = JSON.stringify(Parameters);
                var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/SaveMetricValues", param, false);
                if (strResult == '0') {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.success("inserted Successfully");
                    alertify.success("<%= MyBase.GetResourceString("A_InsertSuccess") %>", 'error');
                    pageLoad();
                    if (plLastColumnIndex != null, plLastmilestoneid != null, plLastcheckbox != null) {
                        $(`#${plLastcheckbox}`).prop('checked', true);
                        changeInputState(plLastColumnIndex, plLastmilestoneid, plLastcheckbox);
                        
                        LastColumnIndex = plLastColumnIndex
                        Lastcheckbox = plLastcheckbox
                    }
                } else if (strResult == '1') {
                    alertify.set('notifier', 'position', 'top-right');
                    //alertify.success("updated Successfully");
                    alertify.success("<%= MyBase.GetResourceString("A_UpdateSuccess") %>", 'error');
                    //console.log("updated Successfully");
                    pageLoad();
                    if (plLastColumnIndex != null, plLastmilestoneid != null, plLastcheckbox != null) {
                        //changeInputState(plLastColumnIndex, plLastmilestoneid, plLastcheckbox);
                        $(`#${plLastcheckbox}`).prop('checked', true);
                        changeInputState(plLastColumnIndex, plLastmilestoneid, plLastcheckbox);
                        LastColumnIndex = plLastColumnIndex
                        Lastcheckbox = plLastcheckbox
                    }
                }
                RefreshList();
                //Added By Riddhesh Patil on 29 Aug 2024 for focus issue
                container.animate({
                    scrollTop: scrollPosition
                }, 500);
                //End of Added By Riddhesh Patil on 29 Aug 2024 for focus issue
            }

        }
        //iNSERT UPDATE ends here 



        function groupDataByCategory(data) {
            const groupedData = [];
            const categoryMap = {};
            data.forEach(item => {
                const category = item.CategoryName;
                if (!categoryMap[category]) {
                    categoryMap[category] = [];
                    groupedData.push(categoryMap[category]);
                }
                categoryMap[category].push(item);
            });
            return groupedData;
        }

        //Base Metric Value table append
        function BaseMetrictableAppend() {
            //debugger
            var projcetId = $('#cboProjectName').val();
            //alert(projcetId);
            var Parameter = {
                ProjectID: projcetId,
                TemplateID: PMIID
            }
            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetBaseMetricValues", param, false);

           
            


            if (strResult.length != 0) {
                $("#DevAgile_BM_ScrollTable").empty();
                var maintable = `<table id="BaseMetricTbl"
                                        class="table table-fixed-header borderGrey BaseMetricTbl stickyTblHeader ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <tbody class="">
                                            <tr id="tblheadforMilestone">
                                                <td class="col-sm-1 sticky_col first_col bg_Milestone text-center">
                                                    Datapoint <br> Id</td>
                                                <td class="col-sm-1 sticky_col second_col bg_Milestone">Metric</td>
                                                <td class="col-sm-1 sticky_col third_col bg_Milestone text-center">Units
                                                </td>
                                                <td class="col-sm-1 sticky_col forth_col bg_Milestone text-center">
                                                    Cumulative</td>
                                          </tr>

                                            <tr id="strHtmlEditBtnHead" class="">
                                                <td class="sticky_col first_col"></td>
                                                <td class="sticky_col second_col"></td>
                                                <td class="sticky_col third_col"></td>
                                                <td class="sticky_col forth_col"></td>
                                                </tr>
                                        </tbody>
                                    </table>`;
                const data = groupDataByCategory(strResult);
                var inc = 2;
                $("#DevAgile_BM_ScrollTable").append(maintable);
                $.each(data, function (i, d) {
                    $('#DevAgile_BM_ScrollTable').append(createTable(data[i], i, inc));
                    inc++;
                });
            }
            else {
                $("#DevAgile_BM_ScrollTable").empty();
                var maintable = `<table id="BaseMetricTbl"
                                        class="table table-fixed-header borderGrey BaseMetricTbl stickyTblHeader ExcelUploadTbl mb-0"
                                        style="width:100%;">
                                        <tbody class="">
                                            <tr id="tblheadforMilestone">
                                                <td class="col-sm-1 sticky_col first_col bg_Milestone text-center">
                                                    Datapoint <br> Id</td>
                                                <td class="col-sm-1 sticky_col second_col bg_Milestone">Metric</td>
                                                <td class="col-sm-1 sticky_col third_col bg_Milestone text-center">Units
                                                </td>
                                                <td class="col-sm-1 sticky_col forth_col bg_Milestone text-center">
                                                    Cumulative</td>
                                          </tr>

                                           
                                        </tbody>
                                    </table>`;
                $("#DevAgile_BM_ScrollTable").append(maintable);
                $("#BaseMetricTbl tbody").append(`<tr class='trNoData' ><td colspan="8" style="text-align:center!important">No Data Available in the table</td></tr>`);
            }
            
            //
            
            

            

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

        function GetDerivedMetricIsFreezed(MilestoneId) {
            var ProjectID = $("#cboProjectName").val();
            var Parameters = {
                ProjectID: ProjectID,
                MilestoneID: MilestoneId
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetDerivedMetricIsFreezed", param, false);
            return strResult;
        }

        function GetBaseMetricIsCopied(PMIID,MilestoneId) {
            var ProjectID = $("#cboProjectName").val();
            var Parameters = {
                TemplateID: PMIID,
                ProjectID: ProjectID,
                MilestoneID: MilestoneId
            }
            var param = JSON.stringify(Parameters);

            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetBaseMetricIsCopied", param, false);
            return strResult;
        }


        function createTable(data, headflag, inc) {
            //debugger
            var categoeryName = data[0].CategoryName;
            var categoeryId = data[0].CategoryID;
            //console.log(data[0].CategoryName);

            var tblHtml = `<table id="DevAgile_BaseMetricTbl${inc}"
                                        class="table table-striped table-fixed-header borderGrey BaseMetricTbl ExcelUploadTbl mb-0"
                                        style="width:100%;"> </table>`
            var table = $(tblHtml);
            var tblbodyHTML = `<tbody id="catId~${categoeryId}"></tbody >`;
            var tableBody = $(tblbodyHTML);
            var tblbodyHeadHTML = `<tr  class="rowHeading" >
                                    <td class="sticky_col first_col" colspan="4">${categoeryName}</td>
                             </tr> `;
            var tblbodyHead = $(tblbodyHeadHTML)
            tableBody.append(tblbodyHead);


            var excludedKeys = new Set(["TemplateID", "CategoryID", "CategoryName", "Metric_DataPointID", "Metric_DataPoints_Name", "units", "Sum_Sprint_Data", "NoData","unitid"]);
            // Get all unique keys from the data array
            var allKeys = new Set();
            $.each(data, function (index, metric) {
                $.each(metric, function (key, value) {
                    if (!excludedKeys.has(key)) {
                        allKeys.add(key);

                    }
                });
            });

            // Convert set to array 
            allKeys = Array.from(allKeys);
            //console.log(allKeys);


            // Table header
            allKeys.forEach(function () {
                tblbodyHead.append(`<td class="sprintCol"></td>`);
            });


            if (headflag == 0) {
                var strHtmlmilestonesHead = '';
                var strHtmlEditBtnHead = '';
                var strHtmlCopyBtnHead = '';
                var strHtmlCopyBtnHeadLock = '';
                var strHtmlCopyBtnHeadLockPM = '';
                var strHtmlCopyBtnHeadLockPMEditAccess = '';

                var i = 1;

                var nxtprevBtn = `<td class="colSmall">
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


                var previousId = null;
                allKeys.forEach(function (milestone, index) {
                    /*debugger;*/
                    //console.log(milestone);
                    var parts = milestone.split('~');
                    var milestoneId = parts[0];
                    var milestoneName = parts[1];
                    var currentId = milestoneId;
                    var IsFreezed = GetDerivedMetricIsFreezed(milestoneId);
                    var IsCopied = GetBaseMetricIsCopied(PMIID, milestoneId);
                    var HistoryCount = (ShowHistory(1, milestoneId)).length;
                   // console.log(HistoryCount);
                    var HistoryBtn = '';
                    var freezeicon = '';
                    if (HistoryCount > 0) {
                        HistoryBtn = `<a href="javascript:;" class="textUndrln" id="showHisDevAgileBM_Btn${i}" onclick="ShowHistory(0,${milestoneId})" data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcanvas_ShowMetric_History"><i class="fas fa-history"
                                                                    data-bs-toggle="tooltip" title="Show History"></i></a>`;
                    } else {
                        HistoryBtn = ``;
                    }

                    if (IsFreezed == false) {
                        freezeicon = ``;
                    }
                    else {
                        freezeicon = `<i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i>`;
                    }
                    
                    //var ShwHisBtn = 
                    if (index != 0) {
                        
                        strHtmlCopyBtnHead = `<a href="javascript:;" class="textUndrln" id="CopyExcelDevAgileBM_Btn${milestoneId}"  data-bs-toggle="tooltip"
                                                                title="Copy from previous"><i class="far fa-copy"></i></a>`;
                        strHtmlCopyBtnHeadLock = `<a href="javascript:;" class="textUndrln fieldDisabled cpybtnmetric" id="CopyExcelDevAgileBM_Btn${milestoneId}" onclick="CopyBtn(${milestoneId},${previousId})"  data-bs-toggle="tooltip"
                                                                title="Copy from previous"><i class="far fa-copy"></i></a>`;
                        strHtmlCopyBtnHeadLockPM = `<a href="javascript:;" class="textUndrln fieldDisabled" id="CopyExcelDevAgileBM_Btn${milestoneId}" data-bs-toggle="tooltip" title="Please Configure Project Manager at Project Level"><i class="far fa-copy"></i></a>`;
                        strHtmlCopyBtnHeadLockPMEditAccess = `<a href="javascript:;" class="textUndrln fieldDisabled" id="CopyExcelDevAgileBM_Btn${milestoneId}" data-bs-toggle="tooltip" title="You don't have edit access for copy frorn previous sprint"><i class="far fa-copy"></i></a>`;

                        //(`#CopyExcelDevAgileBM_Btn${milestoneId}`).off("click");
                        //alert((`#CopyExcelDevAgileBM_Btn${milestoneId}`))
                    }

                    if (EditAccess == "True") {
                        if (RoleDescription == "PM") {
                            if (IsFreezed == false) {
                                if (IsCopied == true) {
                                    strHtmlCopyBtnHeadLock = `<a href="javascript:;" class="textUndrln fieldDisabled" id="FalseCopyExcelDevAgileBM_Btn${milestoneId}"  data-bs-toggle="tooltip"
                                                                title="Data is already Copied"><i class="far fa-copy"></i></a>`;
                                }
                                strHtmlmilestonesHead += `<td id='${milestoneId}' class="hideTblTxt sprintCol text-center"><span>${milestoneName}</span></td>`;
                                strHtmlEditBtnHead += `<td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch" id="EditSwitc${i}" data-bs-toggle="tooltip" title="Enable Edit">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn${i}" 
                                                                     onChange="changeInputState(${i},${milestoneId},'enableEditDevAgileBM_Btn${i}',this)">
                                                                <span class="slider"></span>
                                                            </label>
                                                        </div> 
                                                        <div class="tblIcons d-flex gap-2">
                                                            ${strHtmlCopyBtnHeadLock}
                                                            ${HistoryBtn}
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn${i}" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>`;
                            } else {
                                strHtmlmilestonesHead += `<td id='${milestoneId}' class="hideTblTxt sprintCol text-center"><i class="fas fa-lock pe-2 textRed" data-bs-toggle="tooltip" title="Freezed"></i><span>${milestoneName}</span></td>`;
                                strHtmlEditBtnHead += `<td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch" id="EditSwitc${i}" data-bs-toggle="tooltip" title="Sprint is freezed so you can not edit">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn${i}"
                                                                     onChange="changeInputState(${i},${milestoneId},'enableEditDevAgileBM_Btn${i}',this)" disabled>
                                                                <span class="slider fieldDisabled"></span>
                                                            </label>
                                                        </div> 
                                                        <div class="tblIcons d-flex gap-2">
                                                            ${strHtmlCopyBtnHeadLock}
                                                            ${HistoryBtn}
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn${i}" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>`;

                            }

                        } else {
                            strHtmlmilestonesHead += `<td id='${milestoneId}' class="hideTblTxt sprintCol text-center">${freezeicon}<span>${milestoneName}</span></td>`;
                            strHtmlEditBtnHead += `<td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch" id="EditSwitc${i}" data-bs-toggle="tooltip" title="Please Configure Project Manager at Project Level">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn${i}"
                                                                     onChange="changeInputState(${i},${milestoneId},'enableEditDevAgileBM_Btn${i}',this)" disabled>
                                                                <span class="slider fieldDisabled"></span>
                                                            </label>
                                                        </div> 
                                                        <div class="tblIcons d-flex gap-2">
                                                            ${strHtmlCopyBtnHeadLockPM}
                                                            ${HistoryBtn}
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn${i}" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>`;

                        }

                    }else {

                        strHtmlmilestonesHead += `<td id='${milestoneId}' class="hideTblTxt sprintCol text-center">${freezeicon}<span>${milestoneName}</span></td>`;
                        strHtmlEditBtnHead += `<td class="sprintCol">
                                                    <div class="td_iconsDiv2 d-flex justify-content-center gap-2">
                                                        <div class="form-group d-flex justify-content-start gap-2">
                                                            <label>Edit</label>
                                                            <label class="switch" id="EditSwitc${i}" data-bs-toggle="tooltip" title="You don't have edit access">
                                                                <input type="checkbox" id="enableEditDevAgileBM_Btn${i}"
                                                                     onChange="changeInputState(${i},${milestoneId},'enableEditDevAgileBM_Btn${i}',this)" disabled>
                                                                <span class="slider fieldDisabled"></span>
                                                            </label>
                                                        </div> 
                                                        <div class="tblIcons d-flex gap-2">
                                                            ${strHtmlCopyBtnHeadLockPMEditAccess}
                                                            ${HistoryBtn}
                                                            <!-- <a href="javascript:;" class="textUndrln" id="freezeDevAgileBM_Btn${i}" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_FreezeMilestone"><i class="fas fa-pause-circle" data-bs-toggle="tooltip" title="Freeze"></i></a> -->
                                                        </div>
                                                    </div>
                                                </td>`;

                    }




                    //$("#").off("click");
                    //$("#").css("cursor", "no-drop");


                    i++;
                    /*tblbodyHead.append(`<td class="sprintCol"></td>`);*/
                    previousId = currentId;
                });
                $('#tblheadforMilestone').append(strHtmlmilestonesHead);
                $('#tblheadforMilestone').append(nxtprevBtn);
                $('#strHtmlEditBtnHead').append(strHtmlEditBtnHead);
                $('#strHtmlEditBtnHead').append(`<td class="colSmall"></td>`);

            }

            // Table body
            $.each(data, function (index, metric) {
                //console.log(metric);
                var MetDataPointName = (metric.Metric_DataPoints_Name).trim();
                var cummulative = metric.Sum_Sprint_Data
                var tblRowHTML = `<tr id="metDtPt~${metric.Metric_DataPointID}">
                                 <td class="sticky_col first_col bg_grayTD text-center">${metric.Metric_DataPointID}</td>
                                 <td class="sticky_col second_col bg_grayTD">${MetDataPointName}</td>
                                 <td class="sticky_col third_col bg_grayTD text-center">${metric.units}</td>
                                 <td class="sticky_col forth_col bg_grayTD text-center"> ${cummulative}</td>
                              </tr>`
                var row = $(tblRowHTML);


                $.each(allKeys, function (index, key) {
                    console.log(metric.units);
                    console.log("Test Console");
                    var textbox = '';
                    var value = metric[key] !== null ? metric[key] : '';
                    if (metric.unitid == '13') {
                        textbox += `<td class="text-center sprintCol" id='${key}'><input type="text" maxlength="9" value="${value}" class="form-control inputWidth"  onkeypress="return (event.charCode >= 48 && event.charCode <= 57) || event.charCode === 58 || event.charCode === 8 || event.charCode === 0 || event.charCode === 13" onblur="validatehrs(this)" disabled></td>`
                    } else {
                        textbox += `<td class="text-center sprintCol" id='${key}'><input type="text" maxlength="9" value="${value}" class="form-control inputWidth" oninput="ValidateInput(this)" onblur="validateinputs(this)" disabled></td>`
                    }
                    row.append(textbox);

                });
                row.append(`<td class="colSmall"></td>`);
                tableBody.append(row);

            });
            tblbodyHead.append(`<td class="colSmall"></td>`);
            table.append(tableBody);
            return table;
        }






        //Base Metric Value table append ENDS HERE 
        function isNumber(evt, val, obj) {
            // 
            var legth = val.length;
            var objVal = obj.value;

            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            if (legth == 2) {
                obj.value = objVal + ":";
                //$("#textboxId").val(val +":");
            }
            return true;
        }



        //History Table Starts Here 
        var HisMilestoneId = '';
        var strHistoryResult = '';
        function ShowHistory(flag, MilestoneId, ModifiedField, ModifiedBy) {
            HisMilestoneId = MilestoneId;
            if (flag == 0) {
                GetModifiedBy(HisMilestoneId);
                GetModifiedField(HisMilestoneId)
                $(".selectpicker").selectpicker('refresh');
            }

            var strHTML = "";
            var NewModifiedField = "";
            var NewModifiedBy = "";
            if (ModifiedField == undefined && ModifiedBy == undefined) {
                NewModifiedField = "";
                NewModifiedBy = "";
            } else {
                NewModifiedField = ModifiedField;
                NewModifiedBy = ModifiedBy;
            }
            var NewModifiedField = unescape(NewModifiedField);
            var NewModifiedBy = unescape(NewModifiedBy);


            var parameter = {
                MilestoneID: MilestoneId,
                ModifiedField: NewModifiedField,
                HisModifiedBy: NewModifiedBy
            }

            var param = JSON.stringify(parameter);
            strHistoryResult = AJAXCallWithResult("/api/PM_BaseMetricReport/ShowHistory", param, false);
            $("#MetricShowHistoryTable").dataTable().fnDestroy();

            for (var i = 0; i < strHistoryResult.length; i++) {
                strHTML += "<tr><td>" + strHistoryResult[i].FieldName + "</td>";
                strHTML += "<td>" + strHistoryResult[i].Milestone + "</td>";
                strHTML += "<td>" + strHistoryResult[i].OldValue + "</td>";
                strHTML += "<td>" + strHistoryResult[i].NewValue + "</td>";
                strHTML += "<td>" + strHistoryResult[i].MfdDate + "</td>";
                strHTML += "<td>" + strHistoryResult[i].ModifiedBy + "</td>";

                strHTML += "</tr>";
            }
            $('#tbodyMetricShowHistoryTable').html('');
            $('#tbodyMetricShowHistoryTable').html(strHTML);

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
            return strHistoryResult;
        }

        function GetModifiedBy(id) {
            var strHTML = "";
            var Parameters = {
                MilestoneID: id
            }

            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetModifiedBy", param, false);

            for (var i = 0; i < strResult.length; i++) {
                var ListComponent = strResult[i];

                strHTML += ('<option value="' + ListComponent.ModifiedBy + '">' + ListComponent.ModifiedBy + '</option>');
            }
            $("#ModifiedHisByInput").html('');
            $("#ModifiedHisByInput").html(strHTML);
            // $(".selectpicker").selectpicker('refresh');
        }

        function GetModifiedField(id) {
            //debugger
            var strHTML = "";
            var Parameters = {
                MilestoneID: id
            }

            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/GetModifiedField", param, false);
          //  console.log(strResult)
            for (var i = 0; i < strResult.length; i++) {
                var ListComponent = strResult[i];
                strHTML += ('<option value="' + ListComponent.FieldName + '">' + ListComponent.FieldName + '</option>');

            }
            $("#ModifiedHisFieldInput").html('');
            $("#ModifiedHisFieldInput").html(strHTML);
            /* $(".selectpicker").selectpicker('refresh');*/
        }


        $('#ModifiedHisFieldInput').on('change', function () {
            var currModifiedField = $('#ModifiedHisFieldInput').val();
            var currModifiedBy = $('#ModifiedHisByInput').val();

            ShowHistory(1, HisMilestoneId, currModifiedField, currModifiedBy);

        });

        $('#ModifiedHisByInput').on('change', function () {
            var currModifiedField = $('#ModifiedHisFieldInput').val();
            var currModifiedBy = $('#ModifiedHisByInput').val();

            ShowHistory(1, HisMilestoneId, currModifiedField, currModifiedBy);

        });
        //History Table ends Here


        

        //$(`#CopyExcelDevAgileBM_Btn${milestoneid}`).off('click').on('click', function () {

        //    var btnMilestoneId = $(this).data('milestoneid');
        //    var curId = btnMilestoneId.split('_')[1];
        //    var prevId = btnMilestoneId.split('_')[0];
        //    CopyBtn(curId, prevId);
        //});
        //Faulty Code
        



        
        var Lastcheckbox = '';
        var LastColumnIndex = '';
        var lastmilestoneID = '';
        function changeInputState(columnIndex, milestoneid, HTMLSwitchId, chkbox) {
          
            // Added by parth. G
            //console.log(HTMLSwitchId);
            const checkbox = document.getElementById(`${HTMLSwitchId}`);
            
            //$("label.switch input[type='checkbox']").not(checkbox).prop('checked', false);
            if (checkbox.checked) {
                plLastcheckbox = HTMLSwitchId;
                plLastmilestoneid = milestoneid;
                plLastColumnIndex = columnIndex;
                
                if (Lastcheckbox == '' || Lastcheckbox == HTMLSwitchId) {

                } else {
                    $(`#${Lastcheckbox}`).prop('checked', false);
                    EditUIChange(LastColumnIndex);
                    $(`#CopyExcelDevAgileBM_Btn${lastmilestoneID}`).addClass('fieldDisabled');
                }
                LastColumnIndex = columnIndex
                Lastcheckbox = HTMLSwitchId;
                lastmilestoneID = milestoneid
                $(`#CopyExcelDevAgileBM_Btn${milestoneid}`).removeClass('fieldDisabled');
                //alert("Checkbox");
                /*if (enableEditBtn == '1') {*/
                //$(`#CopyExcelDevAgileBM_Btn${milestoneid}`).removeClass('fieldDisabled');

                // Attach click event listener to the button
                //$(`#CopyExcelDevAgileBM_Btn${milestoneid}`).off('click').on('click', function () {

                //    var btnMilestoneId = $(this).data('milestoneid');
                //    var curId = btnMilestoneId.split('_')[1];
                //    var prevId = btnMilestoneId.split('_')[0];
                //    CopyBtn(curId, prevId);
                //});



                //}
            } else {
                //alert("Checkbox false");
                //enableEditBtn = 0;
                LastColumnIndex = '';
                $(`#CopyExcelDevAgileBM_Btn${milestoneid}`).addClass('fieldDisabled');
            }

            $("table.BaseMetricTbl").find("tr").each(function () {
                
                var inputElement2 = $(this).find("td").eq(columnIndex + 3).find("input[type='text']");
                inputElement2.prop('disabled', !inputElement2.prop('disabled'));
                /*console.log(inputElement2);*/
            });

            $("table.BaseMetricTbl").find("tr").not('.rowHeading').each(function () {
                var tdElement2 = $(this).find("td").eq(columnIndex + 3);
                tdElement2.toggleClass("bgGrey");
            });

        }
        function EditUIChange(lastColumnIndex) {
            if (lastColumnIndex != '') {
                $("table.BaseMetricTbl").find("tr").each(function () {
                    
                    var inputElement2 = $(this).find("td").eq(lastColumnIndex + 3).find("input[type='text']");
                    inputElement2.prop('disabled', !inputElement2.prop('disabled'));
                    /*console.log(inputElement2);*/
                });

                $("table.BaseMetricTbl").find("tr").not('.rowHeading').each(function () {
                    var tdElement2 = $(this).find("td").eq(lastColumnIndex + 3);
                    tdElement2.toggleClass("bgGrey");
                });
            }

        }
        function CopyBtn(CurrentMileStone, Previousmilestone) {
            //debugger;
            //alert(CurrentMileStone+ "," + Previousmilestone);            
            console.log(CurrentMileStone);
            console.log(Previousmilestone);
            var $button = $(`#CopyExcelDevAgileBM_Btn${CurrentMileStone}`);
            if (!$button.hasClass('fieldDisabled')) {
                
                var Parameter = {
                    OldMilestoneId: Previousmilestone,
                    NewMilestoneId: CurrentMileStone,
                    UserName: UserName
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/PM_BaseMetricReport/CopyPrevMilestone", param, false);
                if (strResult != null && strResult != undefined && strResult != "") {
                    if (strResult == 'not Exists') {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.error("Previous Milestone does not Contain value against the any Metric Details");
                        alertify.error("<%= MyBase.GetResourceString("A_PreviousMSNoValue") %>", 'error');
                        pageLoad();

                    }
                    else if (strResult == 'Copied') {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.success("Previous Milestone Data copied successfully");
                        alertify.success("<%= MyBase.GetResourceString("A_PreviousMSDataCopySuccess") %>", 'error');
                        pageLoad();

                    } else if (strResult == 'up Copied') {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.success("Previous Milestone Data Updated successfully");
                        alertify.success("<%= MyBase.GetResourceString("A_PreviousMSDataUpdateSuccess") %>", 'error');
                        pageLoad();

                    }
                }
                /*$button.attr('onclick', 'saveButton()');*/
            } else {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Previous Milestone does not Contain value against the any Metric Details");
                //alertify.error("Please enable edit button to copy", 'error');
                alertify.error("<%= MyBase.GetResourceString("A_editBtn") %>", 'error');
                
                //$button.removeAttr('onclick');
            }


        }


        function ValidateInput(inputElement) {

            var inputValue = inputElement.value;

            var validFloatValue = inputValue.replace(/[^0-9.]/g, '');

            var parts = validFloatValue.split('.');
            if (parts.length > 2) {
                validFloatValue = parts[0] + '.' + parts.slice(1).join('');
            }

            if (validFloatValue.startsWith('.')) {
                validFloatValue = '0' + validFloatValue;
            }
            inputElement.value = validFloatValue;


        }

        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();

            $("#sendApprovalSec").hide();
            $('.nav-link').click(function (e) {
                var targetTab = $(this).text().trim();
                if (targetTab === 'Derived Metric') {
                    $('#sendApprovalSec').removeClass("d-none");
                    $('#sendApprovalSec').addClass("d-block");
                } else {
                    // $('#sendApprovalSec').css('display', 'none !important');
                    $('#sendApprovalSec').addClass("d-none");
                    $('#sendApprovalSec').removeClass("d-block");
                }
            });

            // Truncate the text and add the popover trigger
            //$('td.hideTblTxt >span').each(function () {
            //    var text = $(this).text();
            //    if (text.length > 12) {
            //        var truncatedText = text.substring(0, 12);
            //        var remainingText = text.substring(12);
            //        var popoverTrigger = '<span class="more" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-html="true" data-bs-content="' + text + '">' + truncatedText + '...</span>';
            //        $(this).html(popoverTrigger + '<span class="full-text" style="display:none;">' + text + '</span>');
            //    }
            //});

            //$('[data-bs-toggle="popover"]').popover();

            // Disable the columns when click on toggle button
            //$(".ExcelUploadTbl input[type='number']").attr("disabled", true);

            //$(".BaseMetricTbl .switch input[type='checkbox']").on("change", function () {
            //    alert("Hi");
            //    var columnIndex = $(this).closest("td").index();
            //    // $(this).closest("td").toggleClass("bgGrey");

            //    // $(".switch input[type='checkbox']").not(this).prop('checked', false);

            //    $("table.BaseMetricTbl").each(function () {

            //        $(this).closest("table.BaseMetricTbl").find("tr").each(function () {
            //            var inputElement1 = $(this).find("td.rowHeading").eq(columnIndex).find("input[type='number']");
            //            inputElement1.prop('disabled', !inputElement1.prop('disabled'));

            //            var inputElement2 = $(this).find("td").eq(columnIndex).find("input[type='number']");
            //            inputElement2.prop('disabled', !inputElement2.prop('disabled'));
            //        });

            //        // $(this).closest("table.BaseMetricTbl").find("tr.rowHeading").each(function () {
            //        //     var tdElement1 = $(this).find("td").eq(columnIndex-3);
            //        //     tdElement1.toggleClass("bgGrey");
            //        // });

            //        $(this).closest("table.BaseMetricTbl").find("tr").not('.rowHeading').each(function () {
            //            var tdElement2 = $(this).find("td").eq(columnIndex);
            //            tdElement2.toggleClass("bgGrey");
            //        });
            //    })
            //});
        });

        // Show/Hide months functionality on Derived Metric Added by Gauri


        //$('#MetricShowHistoryTable').dataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 5,
        //    "bLengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "destroy": false,
        //    "retrieve": true,
        //    "bFilter": false,
        //    "bAutoWidth": false,
        //    "ordering": false,
        //    "info": false,
        //});
        //$('#MetricShowHistoryTable').wrap('<div class="dataTables_scroll" />');

        $('#ApprovalHistoryTbl').dataTable({
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
        $('#ApprovalHistoryTbl').wrap('<div class="dataTables_scroll" />');

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
    </script>

</body>

</html>
