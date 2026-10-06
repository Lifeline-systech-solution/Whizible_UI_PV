<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Bulk_Extension.aspx.vb" Inherits="Whizible.PM_Bulk_Extension" %>

<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Bulk Extension")%>
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_Title") %></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=1.0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <link href="../../../Whizible2.0-new/plugins/select2/select2.css?v=3" rel="stylesheet" />--%>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
 <!-- Added By Madhuri.K On 26-03-2026 -->
 <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
    <style type="text/css">
        /* Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen */
        .lblProjectName {
            color: #606feb;
        }

        .fw-bold {
            color: #606feb;
        }

        .lbl_text {
            color: #606feb;
            font-weight: 500;
        }

        .alert_note {
            background: #fff4af;
            color: #720606;
        }
        /* End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen */

        /* Added by Vishal Mane on 08/10/2025 to show contract details */
        #ContractDetailsModal label {
            font-weight: 400;
        }

        #ContractDetailsModal .ContractContent label {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        #ContractDetailsModal .modal-xl {
            --bs-modal-width: 900px;
        }

        #ContractDetailsModal .custom_chckbox label:before {
            margin-right: 0 !important;
        }

        .ContractContent {
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .contractLabels {
            color: #4263c1;
        }
        /* End of Added by Vishal Mane on 08/10/2025 to show contract details */
        .grid_bg {
            border: 1px solid #ddd;
            padding: 4px;
            background-color: #ededed;
        }

        .pro_text {
            color: #133ea1;
            font-size: 12px;
            font-weight: 500;
        }

        .txt_Small {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .txt_Blue {
            color: #4263c1;
        }

        .zebra_bg {
            background-image: repeating-linear-gradient(45deg, #fff, #b1e2ff 1px, #fff 3px, #fff 4px);
        }

        .W-50 {
            width: 100%;
            text-align: center;
            border-radius: 5%;
        }

        .statusDiv {
            margin: unset;
        }

        .bg_lightRed {
            background-color: #ffd9d97d !important;
        }

        .clearedStage1 {
            color: #ff6161;
            text-align: center;
        }
        /*Added by Vishal Mane on 08/10/2025 to add new column Contract Details*/
        .contractinfo {
            color: #ff0000;
            text-align: center;
        }
        /*End of Added by Vishal Mane on 08/10/2025 to add new column Contract Details*/
        .txt_hover {
            cursor: pointer;
        }

        .blocked {
            position: relative;
            display: inline-block;
        }

        .hasDatepicker {
            margin-right: 0px !important;
        }

        body::-webkit-scrollbar {
            display: none;
        }

        .btn-default {
            background-color: #f4f4f4;
            color: #444;
            border-color: #ddd;
        }

        .alertify-notifier {
            z-index: 99999 !important;
        }

        .btn-default:hover,
        .btn-default:active,
        .btn-default.hover {
            background-color: #e7e7e7;
        }

        .table thead tr th span {
            display: inline;
        }

        h5.pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .form-group label {
            line-height: 1.2;
        }

        .custmodal .modal-content .modal-body {
            padding: 20px;
        }

        .dblock {
            display: block;
        }

        .mb-1 {
            margin-bottom: 10px
        }

        .toplinks {
            border-top: 1px solid #eee;
        }

        .dataTables_paginate a.paginate_button.disabled {
            cursor: no-drop
        }

        .dataTables_paginate a.paginate_button {
            border: 1px solid #e9e9e9;
            min-width: 40px;
            display: inline-block;
            text-align: center;
            height: 32px;
            padding: 8px;
            line-height: 14px;
            color: #1359a6;
            margin-left: -1px;
            cursor: pointer
        }

        .dataTables_paginate a.paginate_button.current {
            background: #1359a6;
            color: #fff;
            cursor: pointer
        }

        .ui-datepicker {
            z-index: 9999 !important;
        }

        .pr0 {
            padding-right: 0;
        }

        .custom_radio input[type="radio"] {
            display: none
        }

        .custom_radio input[type="radio"] + label span {
            display: inline-block;
            width: 15px;
            height: 15px;
            background: transparent;
            vertical-align: middle;
            border: 1px solid #464a4c;
            border-radius: 50%;
            padding: 2px;
            margin: 0 12px
        }

        .custom_radio input[type="radio"]:checked + label span {
            width: 15px;
            height: 15px;
            background: #464a4c;
            background-clip: content-box
        }

        .custom_radio span {
            margin: 0px 10px 0px 0px !important;
        }

        table tr th,
        table tr td {
            text-align: center !important
        }

        table tr th:last-child,
        table tr td:last-child {
            text-align: center;
        }

        .custom_chckbox label:before {
            margin-right: 0;
        }

        .table-fixed-header thead tr th, .table thead tr th {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        /*Added by Vishal Mane on 24/03/2026 to fix UI Disturbance Issue*/
        .bootstrap-select .dropdown-menu {
            max-width: 100%;
            z-index: 2000;
        }

        .bootstrap-select .dropdown-menu .inner li a span.text,
        .bootstrap-select .dropdown-menu li a {
            white-space: normal;
            line-height: 1.35;
        }

        .custom_chckbox input:checked + label:after {
            top: 4px;
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

        tr.CustRowEdt .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 50%;
        }

        .custom_chckbox input.reversalMain[disabled] + label:before {
            opacity: 0.3;
        }


        .dateWidth {
            min-width: 160px;
        }       
        .yes-btn {
            background-color: green;
            color: white;
        }
        /**End of Added By Dipali V On 3rd March 2025 For Button */
        table.dataTable thead .sorting_asc:after {
            opacity: 0.0 !important;
        }

        input.form-control {
            text-align: center;
        }

        .blue-text {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #1359a6;
            font-weight: bold;
        }
        /*Added by Vishal Mane on 24/03/2026 to fix UI Disturbance Issue*/
        div#Res_BulkExtensionTbl_wrapper {
            height: auto;
            overflow-y: visible;
        }

        #Res_BulkExtensionTbl,
        #Res_BulkExtensionTbl_wrapper table {
            width: 100% !important;
        }

        #Res_BulkExtensionTbl th {
            white-space: normal;
        }

        .res-th-project,
        .res-th-resource,
        .res-th-role,
        .res-th-allocation,
        .res-th-start,
        .res-th-end,
        .res-th-status {
            min-width: 90px;
        }

        .res-th-revised-end {
            min-width: 170px;
        }
        /*End of Added by Vishal Mane on 24/03/2026 to fix UI Disturbance Issue*/
        td.bg_blue {
            background-color: #c8e0eec4;
        }

        .bg_blue {
            background-color: #c8e0eec4;
        }

        .StageboxDiv {
            width: 20px;
            height: 20px;
            border: 1px solid #999;
            border-radius: 3px;
        }

        img.CardViewIniImg.mx-auto {
            width: 30px !important;
            height: 30px !important;
        }

        /*Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list*/
        .offcanvas-close-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            background: transparent;
            border: none;
            border-radius: 4px;
            color: #374151;
            font-size: 12px;
            line-height: 1;
            cursor: pointer;
            opacity: 0.6;
            transition: opacity 0.15s ease, background 0.15s ease;
            flex-shrink: 0;
        }

        .offcanvas-close-btn:hover {
            opacity: 1;
            background: rgba(0, 0, 0, 0.08);
        }

        .offcanvas-close-btn:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.25);
        }

         /* Added by Vishal Mane on 11/03/2026 for UI changes */
        

        .page-header {
           /* background-color: #e7edf0;*/
            padding: 12px 14px;
            margin-bottom: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #e9ecef;
            margin: 0px;
        }

        .header-icon {
            width: 26px;
            height: 26px;
            background-color: #1e40af;
            border-radius: 6px;
            margin-top: -5px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
            flex-shrink: 0;
        }

        .header-content {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .page-title {
            color: #1e40af;
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 600;
            margin: 0;
            line-height: 1.2;
        }

        .page-subtitle {
            color: #6B7280;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 4px;
            margin-left: -42px;
        }

        .highlight-box {
            display: inline-block;
            background-color: #fff3cd;   /* light yellow */
            color: #856404;
            padding: 4px 10px;
            border-radius: 6px;
            border: 1px solid #ffeeba;
            font-weight: 500;
        }


        /*.dataTables_wrapper .dataTables_info {
            margin-top: 8px;
        }

        .dataTables_wrapper .dataTables_paginate {
            margin-top: 8px;
        }*/

        .dataTables_wrapper .row:last-child {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .dataTables_wrapper .dataTables_info,
        .dataTables_wrapper .dataTables_paginate {
            margin-top: 8px;
        }

        #Res_BulkExtensionTbl_wrapper .row:last-child {
            display: block !important;
            text-align: right !important;
            margin-top: 4px;
        }

        #Res_BulkExtensionTbl_wrapper .row:last-child > div {
            width: auto !important;
            max-width: none !important;
            flex: none !important;
            padding-left: 0 !important;
            padding-right: 0 !important;
            display: inline-block !important;
            vertical-align: middle;
        }

        #Res_BulkExtensionTbl_wrapper .dataTables_info,
        #Res_BulkExtensionTbl_wrapper .dataTables_paginate {
            margin-top: 0;
            padding-top: 0;
            width: auto;
            float: none !important;
            white-space: nowrap !important;
        }

        #Res_BulkExtensionTbl_wrapper .dataTables_info {
            order: 1;
            margin-right: 6px;
            text-align: right;
            display: inline-flex !important;
            align-items: center;
        }

        #Res_BulkExtensionTbl_wrapper .dataTables_paginate {
            order: 2;
            display: inline-flex !important;
            justify-content: flex-end;
            align-items: center;
            margin-left: 8px;
            float: none;
        }

        #Res_BulkExtensionTbl_wrapper .dataTables_paginate .paginate_button {
            min-width: 28px;
            height: 24px;
            line-height: 14px;
            padding: 4px 8px;
            margin-left: 0;
        }

        #Res_BulkExtensionTbl_wrapper .dataTables_paginate .paginate_button.previous {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        #Res_BulkExtensionTbl_wrapper .dataTables_paginate .paginate_button.next {
            border-left: 0;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }

        .dataTables_wrapper .dt-footer-dock {
            width: 100%;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 8px;
            margin-top: 4px;
            white-space: nowrap;
        }

        .dataTables_wrapper .dt-footer-dock .dataTables_info,
        .dataTables_wrapper .dt-footer-dock .dataTables_paginate {
            float: none !important;
            width: auto !important;
            margin: 0 !important;
            padding: 0 !important;
        }
        /* Added by Vishal Mane on 24/03/2026 for UI changes */
        #Proj_BulkExtensionTbl_wrapper .dt-footer-dock {
            align-items: center;
            gap: 8px;
        }

        #Proj_BulkExtensionTbl_wrapper .dt-footer-dock .dataTables_info {
            display: inline-flex;
            align-items: center;
            height: 24px;
            line-height: 24px;
            margin: 0;
        }

        #Proj_BulkExtensionTbl_wrapper .dt-footer-dock .dataTables_paginate {
            display: inline-flex;
            align-items: center;
            margin: 0;
        }

        #Proj_BulkExtensionTbl_wrapper .dt-footer-dock .dataTables_paginate .paginate_button {
            min-width: 28px;
            height: 24px;
            line-height: 14px;
            padding: 4px 8px;
            margin: 0;
        }


        body {
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .form-control, .btn, a, p, input, select.form-select {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }

        table.dataTable,
        table.dataTable th,
        table.dataTable td {
        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .dataTables_wrapper,
        table.dataTable,
        table.dataTable th,
        table.dataTable td,
        .table,
        .table th,
        .table td,
        .accordion-button,
        .accordion-body,
        .accordion-header {
        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .bg_lightVoilet {
            background-color: #e1dee4 !important;
        }

        /*End of Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list*/
    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
    <%--Commented and Added By Riddhesh Patil on 29 Jan  2025--%>
    <%'If m_blnViewAccess = True Or m_blnPMViewAccess = True Or m_blnResViewAccess = True Then%>
    <%If m_blnPMViewAccess = True Or m_blnResViewAccess = True Then%>
    <%--End of Commented and Added By Riddhesh Patil on 29 Jan 2025--%>
    <div class="bgwhite">        
        <div class="graybg page-header">
            <div class="header-icon">
                <%--<i class="fas fa-clipboard-list"></i>--%>
                <i class="fas fa-calendar-plus"></i>
            </div>
            <div class="header-content">
                <h5 class="page-title"><%=MyBase.GetResourceString("C_Title") %></h5>
                <p class="page-subtitle">Review, update, and submit multiple project/resource extension requests for approval in a single action</p>
            </div>
        </div>
        <div class="clearfix"></div>
        <!-- Main content -->
        <div class="content pt-0">
            <!-- Filters -->
            <div class="filtersSection" id="BulkExtension_TopFilSec">
                <!-- Top Section -->
                <div class="row py-2">
                    <div class="col-sm-12">
                        <div class="allApprTabsDiv">
                            <ul class="nav nav-tabs pe-3" id="BulkEntityTab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button type="button" class="nav-link active" data-bs-toggle="tab"
                                        data-bs-target="#ProjExtension_Tab" role="tab">
                                        <%=MyBase.GetResourceString("C_PrjExtension") %>
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button type="button" class="nav-link" data-bs-toggle="tab"
                                        data-bs-target="#ResExtension_Tab" role="tab">
                                        <%=MyBase.GetResourceString("C_ResExtension") %>
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="BulkExtension_TabContent">
                    <div class="row">
                        <div class="tab-content" id="BulkExtension_TabContent">
                            <!-- Project Extension Approval Tab Start here -->
                            <div class="tab-pane fade show active" id="ProjExtension_Tab" role="tabpanel">
                                <!-- Top filters -->
                                <div class="py-2 mt-1 mb-1 col-sm-12 text-end toplinks topFilters lightGrey">
                                    <div class="form-group mb-1">                                     
                                        <div class="row">
                                            <ul class="list-unstyled main-box d-flex align-items-center gap-3" id="TimesheetLegendsP">
                                                <li class="d-flex gap-1 ">
                                                                <div class="highlight-box" id="divPrjSubmittedRecords">
                                                                    <strong>
                                                                        <small>
                                                                            <span class="spntotal" id="ProjSubmittedTotalRecords"></span>
                                                                        </small>
                                                                    </strong>
                                                                </div>
                                                            </li>
                                                <li class="d-flex gap-1 ">
                                                    <div class="py-2">
                                                        <i class="far fa-lightbulb noteIcon me-2"></i><small>You can select a maximum of 10 records on the current page only.</small>
                                                    </div>
                                                </li>
                                                <li class="d-flex gap-1 ">
                                                    <div class="StageboxDiv bg_blue" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Approved" data-bs-original-title="Submitted"></div>
                                                    <small>Submitted from Project Extension</small>
                                                    <%--<strong><small>Submitted</small></strong>--%>
                                                </li> 
                                                <%--Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list--%>
                                                <li class="d-flex gap-1 ">
                                                    <div class="StageboxDiv  bg_lightRed" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Approved" data-bs-original-title="Rejected"></div>
                                                    <small>Submitted from Project Information</small>
                                                    <%--<strong><small>Rejected</small></strong>--%>
                                                </li> 
                                                <%--End of Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list--%>
                                                <li class="text-end">
                                                    <%If m_blnPMEditAccess = True Then%>
                                                    <button class="btn btnyellow" id="showProjApprovalbtn" data-bs-toggle="modal" onclick="SendForProjApprove(this)"><%=MyBase.GetResourceString("C_SendForApproval") %></button>
                                                    <%End If%>
                                                </li>
                                            </ul>                                           
                                        </div>
                                    </div>
                                </div>
                                <!-- Project Bulk Extension  List View starts here -->
                                <div class="Tblwrapper">
                                    <table id="Proj_BulkExtensionTbl" class="table  mt-2" style="width: 100%;">
                                    
                                    </table>
                                </div>
                                <div class="row footer-row">
                                    <!-- LEFT: Total Records -->
                                    <%--<div class="col-sm-6 d-flex align-items-center">--%>
                                    <div class="col-sm-6">
                                        <%--<span class="spntotal" id="ProjTotalRecords"></span>--%>
                                    </div>
                                    <!-- RIGHT: Pagination -->
                                    <div class="col-sm-6 d-flex justify-content-end align-items-center">
                                        <span class="spntotal me-3" id="ProjTotalRecords"></span>
                                        <nav>
                                            <ul class="pagination mb-0">
                                                <li class="page-item" id="btnprevious">
                                                    <a class="page-link" onclick="PrevList()" title="Previous">
                                                        <i class="fas fa-angle-double-left"></i>
                                                    </a>
                                                </li>
                                                <li class="page-item" id="btnnext">
                                                    <a class="page-link" onclick="NextList()" title="Next">
                                                        <i class="fas fa-angle-double-right"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                                <!-- Project Extension Approval List View ends here -->
                            </div>

                            <!-- Bulk Extension Tab Start here -->
                            <div class="tab-pane fade show" id="ResExtension_Tab" role="tabpanel">
                                <!-- Top filters -->
                                <div class="py-2 mt-1 mb-1 col-sm-12 text-end toplinks topFilters lightGrey">
                                    <div class="form-group mb-1">

                                        <div class="row">
                                            <%--<div class="col-sm-4 mt-4">--%>
                                            <div class="col-sm-4">
                                                <div class="row mb-2" hidden>
                                                    <label class="col-sm-4 mt-2 required">
                                                        <%=MyBase.GetResourceString("C_SelContract") %>
                                                    </label>
                                                    <div class="col-sm-7 text-start pe-0">
                                                        <div style="flex-grow: 1;">
                                                            <%CommonFunctions.HTMLControls.DrawComboBox("ResCboContract", "usp_Whizible2_sel_ActiveContract_tbl_PM_ContractMaster",,, "class='selectpicker' data-live-search='true'",,, ) %>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-1 text-start d-flex align-items-center ps-2">
                                                        <span data-bs-toggle="tooltip" aria-label="Contract Details" data-bs-original-title="Contract Details">
                                                            <span class="txt_hover">
                                                                <i class="fas fa-info-circle Card_View_whiz contractinfo" onclick="ShowContractDetails(1)"></i>
                                                            </span>
                                                        </span>
                                                    </div>
                                                    <%--End of Added and modified by Vishal Mane on 08/10/2025 to show Contract Details--%>
                                                </div>
                                                <div class="row mb-2">
                                                    <label class="col-sm-4 mt-2 required"><%=MyBase.GetResourceString("C_Project") %></label>
                                                    <div class="col-sm-8 text-start">
                                                        <select class="selectpicker" data-live-search="true" id="ResprojectID" onchange="handleResProjectChange(this)">
                                                         
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <label class="col-sm-4 mt-2"><%=MyBase.GetResourceString("C_Status") %></label>
                                                    <div class="col-sm-8 text-start">                                                        
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("ResCboStatus", "usp_Whizible2_Sel_ResourceStatus",,, "class='selectpicker' data-live-search='true'",,, ) %>
                                                        <%-- Commented & Added by Ajit L on 29/01/2025--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--<div class="col-sm-4 mt-4">--%>
                                            <div class="col-sm-4">
                                                <div class="row mb-2">
                                                    <label class="col-sm-4 mt-2"><%=MyBase.GetResourceString("C_Role") %></label>
                                                    <div class="col-sm-8 text-start">
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("ResCboRoleID", "usp_Whizible2_sel_tbl_pm_role_ddl_ResExt",,, "class='selectpicker' data-live-search='true'",,, ) %>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <label class="col-sm-4 mt-2"><%=MyBase.GetResourceString("C_Designation") %></label>
                                                    <div class="col-sm-8 text-start">                                                        
                                                        <%CommonFunctions.HTMLControls.DrawComboBox("ResCboDesignation", "usp_Whizible2_sel_tbl_PM_DesignationMaster_ddl_ResExt",,, "class='selectpicker' data-live-search='true'",,, ) %>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <div class="col-sm-12 text-end">
                                                        <a href="javascript:;" class="btn btnyellow" data-bs-toggle="tooltip"
                                                            title="Show" onclick="ShowGridWithFilter()"><%=MyBase.GetResourceString("C_Show") %></a>
                                                    </div>
                                                </div>
                                            </div>

                                            <div style="height: 135px" class="col-sm-4 grid_bg">
                                                <div class="row text-start">
                                                    <div class="col-sm-12 txt_Small txt_Blue"><%=MyBase.GetResourceString("C_UpdAction") %></div>
                                                </div>
                                                <div class="row mb-2">
                                                    <label class="col-sm-4 mt-2"><%=MyBase.GetResourceString("C_ResNewEndDate") %></label>
                                                    <div class="col-sm-6">
                                                        <div class="input-group">
                                                            <input id="updateNew_Date" class="form-control date-picker" onchange="updateResGridEndDates(this.value,this)">
                                                            <span class="input-group-btn" for="updateNew_Date">
                                                                <button class="btn btncalendar" type="button" for="updateNew_Date">
                                                                    <i class="fas fa-calendar-alt"></i>
                                                                </button>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <label class="col-sm-4 mt-2"></label>
                                                    <div class="col-sm-8">
                                                        <%If m_blnResEditAccess = True Then%>
                                                        <%--Added & commented by Ajit L on 28/01/2025--%>
                                                        <%-- <button class="btn btnyellow" id="showResApprovalbtn" onclick="SendForProjApprove(this)" data-bs-toggle="modal" data-bs-target="#ApprovalCommentModal" ><%=MyBase.GetResourceString("C_SendForApproval") %></button>--%>
                                                        <button class="btn btnyellow" id="showResApprovalbtn" onclick="SendForProjApprove(this)" data-bs-toggle="modal"><%=MyBase.GetResourceString("C_SendForApproval") %></button>
                                                        <%--End of Added & commented by Ajit L on 28/01/2025--%>
                                                        <%End If%>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12 d-flex">
                                                <div class="col-sm-12 text-end">
                                                    <div class="row">
                                                        <ul class="list-unstyled main-box d-flex align-items-center gap-3" id="TimesheetLegends">
                                                            <li class="d-flex gap-1 ">
                                                                <div class="" id="divResSubmittedRecords">
                                                                    <strong>
                                                                        <small>
                                                                            <span class="spntotal hgRes" id="ResTotalRecords"></span>
                                                                        </small>
                                                                    </strong>
                                                                </div>
                                                            </li>
                                                            <li class="d-flex gap-1 ">
                                                                <div class="py-2">
                                                                    <i class="far fa-lightbulb noteIcon me-2"></i><small>You can select a maximum of 10 records on the current page only.</small>
                                                                </div>
                                                            </li>
                                                            <li class="d-flex gap-1 ">
                                                                <div class="StageboxDiv bg_blue" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Approved" data-bs-original-title="Submitted"></div>
                                                                <%--<strong><small>Submitted from Project Extension</small></strong>--%>
                                                                <small>Submitted from Bulk Resource Extension</small>
                                                            </li>
                                                            <li class="d-flex gap-1 ">
                                                                <div class="StageboxDiv  bg_lightRed" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Approved" data-bs-original-title="Submitted"></div>
                                                                <%--<strong><small>Rejected from Project Extension</small></strong>--%>
                                                                <small>Submitted from Resource Request</small>
                                                            </li>
                                                            <li class="d-flex gap-1 ">
                                                                <div class="StageboxDiv  bg_lightVoilet" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Approved" data-bs-original-title="Submitted"></div>
                                                                <small>Prepone/Change Allocation Requests</small>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>                           
                                <!-- Resource Bulk Extension List View starts here -->
                                <table id="Res_BulkExtensionTbl" class="table" style="width: 100%;">
                                    <thead class="stickyTblHeader"></thead>
                                    <tbody id="Res_BulkExtensionTblBody"></tbody>
                                
                                </table>
                                <!-- Resource Bulk Extension List View ends here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- More Details For Project Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
            id="moredetailsProject_OffcvsScreen" aria-labelledby="moredetailsProject_OffcvsScreen">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-4">
                            <div class="d-flex align-items-center font-weight-600">
                                <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_RevDetails") %></h5>
                            </div>
                        </div>
                        <div class="col-sm-8 d-flex justify-content-end">
                             <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="Close">&#x2715;</button>
                        </div>
                    </div>
                </div>

                <div id="CountryEdtTab" class="CountryInfo">
                    <div class="row">
                        <div class="col-sm-4">&nbsp;</div>
                        <div class="col-sm-8">
                            <div class="align-items-end font-weight-600">
                                <ul class="list-unstyled main-box d-flex justify-content-end gap-3" id="PrjHistoryLegends">
                                    <li class="d-flex gap-1 ">
                                        <div class="StageboxDiv" style="background-color: #c8e0eec4" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Submitted" data-bs-original-title="Submitted"></div>
                                        <strong><small>Submitted</small></strong>
                                    </li>
                                    <li class="d-flex gap-1 ">
                                        <div class="StageboxDiv " style="background-color: #a0ffa0" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Approved" data-bs-original-title="Approved"></div>
                                        <strong><small>Approved</small></strong>
                                    </li>
                                    <li class="d-flex gap-1 ">
                                        <div class="StageboxDiv" style="background-color: #f2b1b1" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Rejected" data-bs-original-title="Rejected"></div>
                                        <strong><small>Rejected</small></strong>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>                

                    <table id="ProjectRevisionTbl" class="table table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th width="20%"><%= MyBase.GetResourceString("C_TiTle") %></th>
                                <th width="20%">Event Time</th>
                                <th width="20%">Action Taken</th>
                                <th width="20%">From Stage</th>
                                <th width="20%">To Stage</th>
                                <th width="20%">Approver/Sender</th>
                                <th width="20%">Comments</th>
                            </tr>
                        </thead>
                        <tbody id="ProjectRevisionTbody">
                        </tbody>

                    </table>

                </div>
                <div class="clearfix"></div>

            </div>
        </div>
        <!-- More Details for Project Offcanvas Section ends -->
        <!-- More Details for Resource Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
            id="moredetails_OffcvsScreen" aria-labelledby="moredetails_OffcvsScreen">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center font-weight-600">
                               <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ReqDetails") %></h5>
                                <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="Close">&#x2715;</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="CountryEdtTab" class="CountryInfo">                   
                    <div class="CountryEdtInfo mb-2">
                        <div class="addCGContent">
                            <div class="row mb-1">
                                <div class="col-sm-6 mb-2">
                                    <div class="row ">
                                        <div class="col-sm-5 text-end">
                                            <label class="pro_text"><%=MyBase.GetResourceString("C_ReqType") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <label class="pro_text" id="ReqType"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-2">
                                    <div class="row ">
                                        <div class="col-sm-5 text-end">
                                            <label class="pro_text"><%=MyBase.GetResourceString("C_Status") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <div class="statusDiv d-flex justify-content-start">
                                                <span class="statusBox statusSubmitted me-2" data-bs-toggle="tooltip"                                          
                                                    title="">&nbsp;</span>
                                                <a href="javascript:;">
                                                    <label class="crsrLink pro_text txt_org" id="ReqStatus"></label>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row form-group">
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <div class="col-sm-5 text-end">
                                            <label class="txt_Blue"><%=MyBase.GetResourceString("C_ReqID") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <label class="" id="ReqID"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <div class="col-sm-5 text-end">
                                            <label class="txt_Blue"><%=MyBase.GetResourceString("C_ReqDate") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <label class="" id="ReqDate"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <div class="col-sm-5 text-end">
                                            <label class="txt_Blue"><%=MyBase.GetResourceString("C_FromDate") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <label class="" id="ReqFromDate"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <div class="col-sm-5 text-end">
                                            <label class="txt_Blue"><%=MyBase.GetResourceString("C_ToDate") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <label class="" id="ReqToDate"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <div class="col-sm-5 text-end">
                                            <label class="txt_Blue"><%=MyBase.GetResourceString("C_WorkHours") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <label class="" id="ReqWorkHours"></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <div class="col-sm-5 text-end">
                                            <label class="txt_Blue"><%=MyBase.GetResourceString("C_AllocationType") %> : </label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <label class="" id="ReqAllocationType"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <!-- More Details for ResourceOffcanvas Section ends -->
        <!-- Commented Approval Comment modal by Vishal Mane on 09/02/2026 -->
        <!-- Approval Comment modal start here-->
        <div class="modal custmodal fade" id="ApprovalCommentModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%=MyBase.GetResourceString("C_Submit") %></h5>
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
                            <label class="required"><%=MyBase.GetResourceString("C_SubmitComment") %>: </label>
                            <div class="col-sm-12">
                                <textarea rows="3" id="ProjectApprovalRemark" maxlength="500" class="form-control required"></textarea>
                            </div>
                        </div>
                        <div class="text-center my-2">
                            <a href="javascript:;" class="btn btnyellow" id="Approve_Submit_Btn" onclick="SendForApproval(this)" data-bs-toggle="tooltip"
                                title="Submit"><%=MyBase.GetResourceString("C_Submit") %></a>
                            <a href="javascript:;" class="btn borderbtn mr-5" id="Approve_Cancel_Btn" data-bs-dismiss="modal"
                                data-bs-toggle="tooltip" title="Cancel"><%=MyBase.GetResourceString("C_Cancel") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End of Commented Approval Comment modal by Vishal Mane on 09/02/2026 -->
        <!-- Approval Comment modal end here-->

        <%--Added By Dipali V On 3rd March for Validation MSG--%>
        <div class="modal custmodal fade" id="ValidationModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Warning</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12 text-end">
                            </div>
                        </div>
                        <div class="form-group row">
                            <p id="AllocationPercentage"></p>
                            <p id="MsgDate"></p>
                        </div>
                        <div class="text-center my-2">
                            <a href="javascript:;" class="btn btnyellow" id="Submit_Btn" onclick="AllowtoSubmit(1)(this)" data-bs-toggle="tooltip"
                                title="Submit">Yes</a>
                            <a href="javascript:;" class="btn borderbtn mr-5" id="AllowtoSubmit(0)" data-bs-dismiss="modal"
                                data-bs-toggle="tooltip" title="Cancel"><%=MyBase.GetResourceString("C_Cancel") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--End of  Added By Dipali V On 3rd March for Validation MSG--%>

        <!-- Show History Details Panel start here -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="ShowPrjHisDetailpanel" aria-labelledby="moredetailsProject_OffcvsScreen">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center font-weight-600">
                                <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_HistoryDetails") %></h5>
                                <%--Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list--%>
                            <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="Close">&#x2715;</button>
                            <%--End of Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mb-4">
                    <div class="pgdetailinner p-0">
                        <div class="HistorySec">
                            <div class="tab-content">
                                <!-- History Tab -->
                                <div id="MyTS_HistoryTab" class="tab-pane active mt-2">
                                    <div class="container-fluid">
                                        <div class="form-inline hstryfltr pb-2">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="d-flex justify-content-end gap-2">                                                        
                                                        <%--<a href="javascript:;" class="btn borderbtn cancelEdtDetpanel"id="BtnCancelHistory" data-bs-toggle="tooltip" data-bs-dismiss="offcanvas" title="Cancel">Cancel</a>--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="table-responsive">
                                            <table id="tblPrjExtHistory" class="table table-bordered table-striped" style="width: 100%;">
                                                <thead class="">
                                                    <tr>
                                                        <th style="width: 200px!important;" class="text-center"><%=MyBase.GetResourceString("C_ModifiedField") %></th>
                                                        <th class="text-center"><%=MyBase.GetResourceString("C_OldValue") %></th>
                                                        <th class="text-center"><%=MyBase.GetResourceString("C_NewValue") %></th>
                                                        <th class="text-center"><%=MyBase.GetResourceString("C_ModifiedBy") %></th>
                                                        <th class="text-center"><%=MyBase.GetResourceString("C_ModifiedDate") %></th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tblPrjExtHistoryBody">
                                                </tbody>
                                            </table>
                                        </div>
                                        <br />
                                    </div>

                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--Added by Vishal Mane on 20/06/2025 to plot Approval History for Expelo Customization--%>
            <div class="offcanvas-body">           
            </div>
            <%--End of Added by Vishal Mane on 20/06/2025 to plot Approval History for Expelo Customization--%>
        </div>

        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="ShowResHisDetailpanel" aria-labelledby="moredetailsProject_OffcvsScreen">
            <div class="container-fluid py-2 graybg mb-2">
                <div class="row align-items-center">
                    <div class="col-sm-12">
                        <div class="d-flex align-items-center font-weight-600">
                            <!-- Modified By Madhuri.K On 02-04-2026 --> 
                            <h5 class="pgtitle">Resource Extension</h5>
                            <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="Close">&#x2715;</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="offcanvas-body">
                <div class="accordion" id="historyAccordion">
                    <!-- 🔹 History Section -->
                    <div class="accordion-item">
                        <h5 class="accordion-header" id="headingHistory">
                            <button class="accordion-button" type="button"
                                data-bs-toggle="collapse"
                                data-bs-target="#collapseHistory"
                                aria-expanded="true">
                                <%=MyBase.GetResourceString("C_HistoryDetails") %>
                            </button>
                        </h5>

                        <div id="collapseHistory"
                            class="accordion-collapse collapse show">
                            <div class="mb-4">
                                <div class="pgdetailinner p-0">
                                    <div class="HistorySec">
                                        <div class="tab-content">
                                            <div id="MyReS_HistoryTab" class="tab-pane active mt-2">
                                                <div class="container-fluid">
                                                    <div class="table-responsive">
                                                        <table id="tblResExtHistory" class="table table-bordered table-striped" style="width: 100%;">
                                                            <thead class="">
                                                                <tr>
                                                                    <th style="width: 200px!important;" class="text-center"><%=MyBase.GetResourceString("C_ModifiedField") %></th>
                                                                    <th class="text-center"><%=MyBase.GetResourceString("C_OldValue") %></th>
                                                                    <th class="text-center"><%=MyBase.GetResourceString("C_NewValue") %></th>
                                                                    <th class="text-center"><%=MyBase.GetResourceString("C_ModifiedBy") %></th>
                                                                    <th class="text-center"><%=MyBase.GetResourceString("C_ModifiedDate") %></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tblResExtHistoryBody">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <br />
                                                </div>

                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 🔹 Action History Section -->
                    <div class="accordion-item">
                        <h5 class="accordion-header" id="headingAction">
                            <button class="accordion-button collapsed" type="button"
                                data-bs-toggle="collapse"
                                data-bs-target="#collapseAction"
                                aria-expanded="false">
                                <%=MyBase.GetResourceString("C_ActionHistory") %>
                            </button>
                        </h5>

                        <div id="collapseAction"
                            class="accordion-collapse collapse">
                            <div class="mb-4">
                                <div class="pgdetailinner p-0">
                                    <div class="HistorySec">
                                        <div class="tab-content">
                                            <div id="MyReS_HistoryTab_Approval" class="tab-pane active mt-2">
                                                <div class="container-fluid">
                                                    <div class="table-responsive">
                                                        <table id="tblResExtHistory_Approval" class="table table-bordered table-striped" style="width: 100%;">
                                                            <thead class="">
                                                                <tr>
                                                                    <th class="text-center" style="width: 200px!important;"><%=MyBase.GetResourceString("C_Action") %></th>
                                                                    <th class="text-center"><%=MyBase.GetResourceString("C_ActionTakenBy") %></th>
                                                                    <th class="text-center"><%=MyBase.GetResourceString("C_ActionTakenOn") %></th>
                                                                    <th class="text-center"><%=MyBase.GetResourceString("C_Comments") %></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tblResExtHistoryBody_Approval">
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <br />
                                                </div>

                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>

            </div>
        </div>



        <!-- Show History Details Panel end here -->        
        <!-- Contract Details For Project Offcanvas Section starts here added by Vishal Mane on 08/10/2025 -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
            id="moredetailsContract_OffcvsScreen" aria-labelledby="moredetailsProject_OffcvsScreen">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-4">
                            <div class="d-flex align-items-center font-weight-600">
                               <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ContractDetails")%></h5>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-inline hstryfltr pb-2">
                    <div class="row">
                        <div class="col-sm-6">
                        </div>
                        <div class="col-sm-6">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="javascript:;" class="btn borderbtn cancelEdtDetpanel"
                                    id="BtnCancelResHistory1" data-bs-toggle="tooltip" data-bs-dismiss="offcanvas" title="Cancel"><%=MyBase.GetResourceString("C_Close")%></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row form-group mb-2">
                    <div class="col-sm-4">
                        <div class="row mb-1">
                            <div class="col-sm-6 text-end">
                                <label><strong><%=MyBase.GetResourceString("C_CustomerName")%></strong></label>
                            </div>
                            <div class="col-sm-6 text-start">
                                <label id="CustomerNameLabel"></label>
                            </div>
                            <div class="col-sm-8" style="display: none">
                                <%CommonFunctions.HTMLControls.DrawTextBox("hiddencontractid", "hiddencontractid", "form-control", widthInPixel:=0, maxLength:=50)%>
                                <%CommonFunctions.HTMLControls.DrawTextBox("hiddencontractCurrencyID", "hiddencontractCurrencyID", "form-control", widthInPixel:=0, maxLength:=50)%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="contrctDetailsSec">
                    <div class="row">
                        <div class="col-sm-4">
                            <table id="contrctDetailsTbl" class="table table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th class="col-sm-3"><%=MyBase.GetResourceString("C_UniqueId")%></th>
                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_Name")%></th>
                                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_Select")%></th>
                                    </tr>
                                </thead>
                                <tbody id="contractdetailsid"></tbody>
                            </table>
                            <button class="btn borderbtn" id="UpdateContractBtn" data-bs-toggle="tooltip" data-bs-original-title="Update" onclick="updateContractData()"><%=MyBase.GetResourceString("C_Update")%></button>
                        </div>
                        <div class="col-sm-8">
                            <div class="ContractContent">
                                <div class="row form-group mt-3">
                                    <div class="col-sm-6">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_UniqueId1")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ContractUniqueIdEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractSummary")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ContractSumEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractDetails1")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="CtractDetEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_Customer")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="CustEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractType")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ContctEdtTypeLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_CommencementDate")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ComDateEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractSigningDate")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ComSignDateEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractExpiryDate")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ComExpDateEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_ContractValue")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ContctEdtValLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_Currency")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="CurrValEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_SOWNumber")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="SOW_NoEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_PONumber")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="PO_NoEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_TypeofApproval")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="ApprTypeEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_EndCustomertotheGroup")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="EndCustGpEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 mb-1">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="contractLabels"><%=MyBase.GetResourceString("C_OpportunityId")%></label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <label id="OppIdEdtLabel"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="contrctAttmentInfo">
                    <div class="contrctAttSec">
                        <ul class="nav nav-tabs detailsubtabs mt-4">
                            <li class="nav-item"><a class="nav-link active" href="#contrctAttmentTab" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_ContractAttachment")%></a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <!-- History Tab -->
                            <div id="contrctAttmentTab" class="tab-pane active mt-2">
                                <div class="container-fluid">
                                    <div class="table-responsive">
                                        <table id="contrctDocumentsTbl" class="table table-bordered" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th class="col-sm-3"><%=MyBase.GetResourceString("C_FileName")%></th>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_AttachedBy")%></th>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_AttachedDate")%></th>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_Description")%></th>
                                                </tr>
                                            </thead>
                                            <tbody id="contractdocid"></tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>

            </div>
        </div>
        <!-- Contract Details For Project Offcanvas Section ends here added by Vishal Mane on 08/10/2025 -->

        <!-- Send for Approval Offcanvas Section starts here added by Vishal Mane on 09/02/2026 -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1" id="sendforApproval_OffcvsScreen">
            <div class="offcanvas-body">
                <!-- HEADER BAR -->
                <div class="container-fluid py-2 graybg mb-3">
                    <div class="row align-items-center">
                        <div class="col-sm-6">
                            <div class="font-weight-600">
                                <span><%=MyBase.GetResourceString("C_SendForApproval") %></span>
                            </div>
                        </div>
                        <div class="col-sm-6 text-end">
                            <%--Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list--%>
                            <%--<a href="javascript:;" class="btn borderbtn" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Cancel") %></a>--%>
                            <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="Close">&#x2715;</button>
                            <%--End of Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list--%>
                        </div>
                    </div>                    
                </div>
                <!-- INFO MESSAGE -->
                <div class="alert small alert_note">
                     <%=MyBase.GetResourceString("C_WorkflowNote") %>
                </div>
                <div class="text-end mb-3">
                     <a href="javascript:;" class="btn btn-primary" id="btnSendWorkflowApproval" onclick="SendForApproval_WF(this)"><%=MyBase.GetResourceString("C_Submit") %></a>
                </div>
                <!-- PROJECT BLOCK (DYNAMIC) -->
                <div id="workflowProjectContainer">
                </div>
                <!-- APPROVAL COMMENTS -->
                <div class="form-group mt-3">
                    <label class="required"><%=MyBase.GetResourceString("C_SubmitComment") %>: </label>
                    <%--<textarea rows="3" id="ProjectApprovalRemark_WF" maxlength="500" class="form-control" placeholder="Enter your approval comments..."></textarea>--%>
                    <textarea rows="3" id="ProjectApprovalRemark_WF" maxlength="500" class="form-control" placeholder="Enter comments..."></textarea>            
                    </div>

                <!-- FOOTER BUTTONS -->
                <div class="text-end mt-4">
                    
                </div>

            </div>
        </div>
        <!-- End of Send for Approval Offcanvas Section starts here added by Vishal Mane on 09/02/2026 -->
        

        <div class="clearfix"></div>

    </div>
    <%-- </div>

</div>--%>

    <%--</div>--%>

    <div class="clearfix"></div>

    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_Note") %></p>
        </div>
    </div>
    <%End If %>

    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/select2/select2.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>

    <script>
    var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>'
    var SessionProjectID = "<%=m_ProjectId%>";
    var LoginType = '<%= Session("LoginType") %>';
    var RoleID = '<%= Session("intPostID") %>';
    var LoginID = '<%= Session("intLoginID") %>';
    var UserID = '<%= Session("intUserID") %>';
    var UserName = '<%= Session("strUserName") %>';
    var AddAccess = "<%=m_blnAddAccess%>";
    var EditAccess = "<%=m_blnEditAccess%>";
    var DeleteAccess = "<%= m_blnDeleteAccess%>";
    var blnViewAccess = "<%= m_blnViewAccess%>";
    var blnPMViewAccess = "<%= m_blnPMViewAccess%>";
    var blnResViewAccess = "<%= m_blnResViewAccess%>";

        $(document).ready(function () {
        getStatusColors();
        $('#BulkEntityTab .nav-link.active').css('color', '#0d6efd');
        $('#BulkEntityTab .nav-link').not('.active').css('color', 'black');
        //Added By Riddhesh Patil on 29 Jan 2025
        if (blnPMViewAccess == "False" && blnResViewAccess == "True") {
            $("#BulkEntityTab .nav-item:first-child .nav-link").removeClass('active');
            $("#BulkEntityTab .nav-item:first-child .nav-link").hide();

            $("#BulkEntityTab .nav-item:nth-child(2) .nav-link").addClass('active');
            $("#BulkEntityTab .nav-item:nth-child(2) .nav-link").show();

            $("#ProjExtension_Tab").removeClass('active');
            $("#ResExtension_Tab").addClass('active');
        }
        if (blnPMViewAccess == "True" && blnResViewAccess == "False") {
            $("#BulkEntityTab .nav-item:first-child .nav-link").addClass('active');
            $("#BulkEntityTab .nav-item:first-child .nav-link").show();

            $("#BulkEntityTab .nav-item:nth-child(2) .nav-link").removeClass('active');
            $("#BulkEntityTab .nav-item:nth-child(2) .nav-link").hide();

            $("#ProjExtension_Tab").addClass('active');
            $("#ResExtension_Tab").removeClass('active');
        }
        //End of Added By Riddhesh Patil on 29 Jan 2025
        $("#cboContract").on("change", function () {
            handleContractChange($(this).val());
        });
        $("#ResCboContract").on("change", function () {
            handleResContractChange($(this).val());
        });
        handleResContractChange();
        //updateHeading();
        //calender 
        $(document).on('focus', '.date-picker', function () {
            $(this).datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                /* dateFormat: 'yy-mm-dd',*/
                dateFormat: 'dd M yy',
                onSelect: function (dateText, inst) {
                    $(this).val(dateText); // Update the input with the selected date
                    $(this).trigger('change'); // Trigger the onchange event
                }
            });
        });
        $('[data-bs-toggle="tooltip"]').tooltip();
        // Event listener for tab shown event
        $('button[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            //updateHeading();
        });
        handleContractChange();
    })

    $('#BulkEntityTab .nav-link').on('click', function () {
        if ($(this).hasClass('active')) {
            // Set active tab to blue
            $(this).css('color', '#0d6efd');

            // Set inactive tabs to black
            $('#BulkEntityTab .nav-link').not(this).css('color', 'black');
        }
    });

    //$(function () {

    //});
    var GlobalContractEndDate;
    var ValidateionGlobalContractEndDate;
    var GlobalcontractID;

    var TotalPages = 0;
    var TotalPagesCount;
    var isNextDisabled = false;
    var isPreviousDisabled = false;
    var PageNumber = 1;
    var selectedRows = [];
    var contractValue;
    var contractCurrency = "";
    function handleContractChange(element) {
        TotalPages = 0;
        TotalPagesCount = 0;
        isNextDisabled = false;
        isPreviousDisabled = false;
        PageNumber = 1;
        selectedRows.length = 0;
        //Commented by Vishal Mane on 24/02/2026 for Bulk Extensio integration
        //var parts = element.split("_EDT_");        
        //var contractID = parts[0];
        //var ContractEndDate = parts[1];
        //contractCurrency = parts[3];
        //GlobalcontractID = contractID
        //ValidateionGlobalContractEndDate = ContractEndDate;
        //Commented by Vishal Mane on 24/02/2026 for Bulk Extensio integration
        <%--if (contractID == 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('<%=MyBase.GetResourceString("A_ContractMandatory") %>');
            return;
        }--%>
        //End of Commented by Vishal Mane on 24/02/2026 for Bulk Extensio integration
        //var newEndDateTextbox = document.getElementById("newEndDate");
        //if (newEndDateTextbox) {
        //    newEndDateTextbox.value = ContractEndDate;
        //}        
        //Commented by Vishal Mane on 24/02/2026 for Bulk Extensio integration
        //GlobalContractEndDate = ContractEndDate;
        GetContractData(contractID);        
        //var ProjectdataParameter = {
        //    ContractID: contractID,
        //}
        //var param = JSON.stringify(ProjectdataParameter);
        //Commented by Vishal Mane on 24/02/2026 for Bulk Extensio integration
        var contractID = 0;
        var ContractEndDate;
        var ProjectdataParameter = {
            UserID: UserID,
            ContractID: contractID,
            LoginType: LoginType,
            LoginID: LoginID
        }
        var param = JSON.stringify(ProjectdataParameter);
        var ProjPaginationCount = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectDataCount", param, false);
        TotalPages = ProjPaginationCount;
        TotalPagesCount = ProjPaginationCount;
        var ProjPaginationCountElement = $("#ProjTotalRecords");
        ProjPaginationCountElement.empty();
        ProjPaginationCountElement.append(`Total Records: ${ProjPaginationCount}`);
        var ProjPaginationCountElement = $("#ProjSubmittedTotalRecords");
        ProjPaginationCountElement.empty();
        ProjPaginationCountElement.append(`Total Submitted Records: ${SubmittedProjCount}`);
        PlotProjectGrid(contractID, ContractEndDate, PageNumber);
    }

    function PrevList() {
        selectedRows.length = 0;
        //alert("mclaren prev");
        if (!isPreviousDisabled && PageNumber > 1) {
            PageNumber--;
            // GetProjectTimesheetList("", "", PageNumber);
            var ProjectdataParameter = {
                UserID: UserID,
                ContractID: GlobalcontractID,
                LoginType: LoginType,
                LoginID: LoginID

            }
            var param = JSON.stringify(ProjectdataParameter);
            var ProjPaginationCount = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectDataCount", param, false);
            TotalPages = ProjPaginationCount;
            TotalPagesCount = ProjPaginationCount;
            var ProjPaginationCountElement = $("#ProjTotalRecords");
            ProjPaginationCountElement.empty();
            ProjPaginationCountElement.append(`Total Records: ${ProjPaginationCount}`);

            var ProjPaginationCountElement = $("#ProjSubmittedTotalRecords");
            ProjPaginationCountElement.empty();
            ProjPaginationCountElement.append(`Total Submitted Records: ${SubmittedProjCount}`);
            PlotProjectGrid(GlobalcontractID, ValidateionGlobalContractEndDate, PageNumber);
            //Added by Vishal Mane on 18/06/2025 to fix refresh issue for pagination
            //$("#newEndDate").trigger("change");                                               Commented and added by Vishal Mane on 05/12/2025 to fix refresh Issue
            //End of Added by Vishal Mane on 18/06/2025 to fix refresh issue for pagination                
        }
    }

    function NextList() {
        selectedRows.length = 0;
        //alert("mclaren next " + TotalPages);
        if (!isNextDisabled && PageNumber < TotalPages) {
            PageNumber++;
            // GetProjectTimesheetList("", "", PageNumber);
            var ProjectdataParameter = {
                UserID: UserID,
                ContractID: GlobalcontractID,
                LoginType: LoginType,
                LoginID: LoginID

            }
            var param = JSON.stringify(ProjectdataParameter);
            var ProjPaginationCount = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectDataCount", param, false);
            TotalPages = ProjPaginationCount;
            TotalPagesCount = ProjPaginationCount;
            var ProjPaginationCountElement = $("#ProjTotalRecords");
            ProjPaginationCountElement.empty();
            ProjPaginationCountElement.append(`Total Records: ${ProjPaginationCount}`);

            var ProjPaginationCountElement = $("#ProjSubmittedTotalRecords");
            ProjPaginationCountElement.empty();
            ProjPaginationCountElement.append(`Total Submitted Records: ${SubmittedProjCount}`);
            PlotProjectGrid(GlobalcontractID, ValidateionGlobalContractEndDate, PageNumber);
            //Added by Vishal Mane on 18/06/2025 to fix refresh issue for pagination
            //$("#newEndDate").trigger("change");                                               Commented and added by Vishal Mane on 05/12/2025 to fix refresh Issue
            //End of Added by Vishal Mane on 18/06/2025 to fix refresh issue for pagination
        }
        else {
            PlotProjectGrid(GlobalcontractID, ValidateionGlobalContractEndDate, PageNumber);
        }
    }

    //$(document).on('click', '#btnnext', function () {
    //    checkedRecords = [];
    //    if (!isNextDisabled && PageNumber < TotalPages) {
    //        PageNumber++;
    //        // GetProjectTimesheetList("", "", PageNumber);
    //        isValidDate(PageNumber);
    //    }
    //});

    //$(document).on('click', '#btnprevious', function () {
    //    checkedRecords = [];
    //    if (!isPreviousDisabled && PageNumber > 1) {
    //        PageNumber--;
    //        // GetProjectTimesheetList("", "", PageNumber);

    //    }
    //});



    //datatable


    function resizeSection() {
        var tblheight = $(window).height();
        //$('#Proj_BulkExtensionTbl_wrapper .dataTables_scroll').css({ 'height': tblheight - 250, "overflow-y": "auto" });
        $('.Tblwrapper').css({ 'height': tblheight - 220, "overflow-y": "auto" });

    }
    function alignAllDataTableFootersRight() {
        $('.dataTables_wrapper').each(function () {
            var $wrapper = $(this);
            var $info = $wrapper.find('.dataTables_info').first();
            var $paginate = $wrapper.find('.dataTables_paginate').first();
            if (!$info.length || !$paginate.length) return;

            var $dock = $wrapper.find('.dt-footer-dock');
            if (!$dock.length) {
                $dock = $('<div class="dt-footer-dock"></div>');
                $wrapper.append($dock);
            }
            $dock.append($info).append($paginate);

            // Remove leftover empty DataTables bootstrap rows after docking footer controls.
            $wrapper.children('.row').each(function () {
                var $row = $(this);
                var hasDtControls = $row.find('.dataTables_length, .dataTables_filter, .dataTables_info, .dataTables_paginate').length > 0;
                if (hasDtControls) return;

                var hasVisibleContent = $.trim($row.text()).length > 0 || $row.find('table, tbody, thead, tr, td, th, input, select, button, a').length > 0;
                if (!hasVisibleContent) {
                    $row.remove();
                }
            });
        });
    }
    $(window).on("load resize scroll", function (e) {
        resizeSection(this);
        alignAllDataTableFootersRight();
    });
    $(document).on('init.dt draw.dt', function () {
        alignAllDataTableFootersRight();
    });
    // $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();



    //dataTable.on('draw', function () {
    //    $('.selectpicker').selectpicker();
    //});


    // Validation Function validateEndDate(this,'1','29 Feb 2024', 'newEfforts_1',170,480)
    function validateEndDate(input, rowIndex, projectEnddate, newEffortId, projectID, ExistingWorkHour, TaskEndDate, ExpectedStartDate) {
        //debugger
        if (input.value == '') {
            alertify.set('notifier', 'position', 'top-right');
            //alertify.error("Please Select a Revised End Date");
            alertify.error("Please Select valid End Date");
            input.value = ValidateionGlobalContractEndDate;
            return;
        }
        const enteredDate = new Date(input.value);
        const contractEndDate = new Date(ValidateionGlobalContractEndDate);
        const projEnddate = new Date(projectEnddate);
        const projstartdate = new Date(ExpectedStartDate);
        if (enteredDate < projstartdate) {
            alertify.set('notifier', 'position', 'top-right');
            //Added By Riddhesh Patil on 28 jan 2025 for alert rephrase issue
            //alertify.error(`Project end date cannot exceed the global contract end date: ${ValidateionGlobalContractEndDate}`);
            alertify.error(`Project end date should be greater than project start date : ${ExpectedStartDate}`);
            //End of Added By Riddhesh Patil on 28 jan 2025 for alert rephrase issue
            //Commented and Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
            //input.value = ValidateionGlobalContractEndDate; // Clear the invalid value and set back to Contract end date 
            input.value = projectEnddate; // Clear the invalid value and set back to Contract end date
            //Commented and Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
            return
        }

        if (enteredDate > contractEndDate) {
            alertify.set('notifier', 'position', 'top-right');
            //Added By Riddhesh Patil on 28 jan 2025 for alert rephrase issue
            //alertify.error(`Project end date cannot exceed the global contract end date: ${ValidateionGlobalContractEndDate}`);
            alertify.error(`Planned end date cannot exceed the contract end date: ${ValidateionGlobalContractEndDate}`);
            //End of Added By Riddhesh Patil on 28 jan 2025 for alert rephrase issue
            //input.value = ValidateionGlobalContractEndDate; // Clear the invalid value and set back to Contract end date 
            input.value = projectEnddate; // Clear the invalid value and set back to Contract end date
            //Commented and Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
            return
        }

        //Commented and Added By Riddhesh Patil on 03 March 2025
        if (enteredDate < projEnddate) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(`Revised End Date cannot less than Project Actual End Date ${projectEnddate}`);
            //input.value = ValidateionGlobalContractEndDate; // Clear the invalid value and set back to Contract end date 
            input.value = projectEnddate; // Clear the invalid value and set back to Contract end date
            //Commented and Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
            return
        }

        if (TaskEndDate != null && enteredDate < new Date(TaskEndDate)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(`Revised End Date cannot less than Task End Date ${TaskEndDate}`);
            //input.value = ValidateionGlobalContractEndDate; // Clear the invalid value and set back to Contract end date 
            input.value = projectEnddate; // Clear the invalid value and set back to Contract end date
            //Commented and Added by Vishal Mane on 24/02/2026 for Bulk Extensio integration
            return
        }
        //End of Commented and Added By Riddhesh Patil on 03 March 2025

        const effortFieldId = `newEfforts_${rowIndex}`; // Assuming consistent naming convention
        const effortInput = document.getElementById(effortFieldId);
        //ExistingWorkHour = parseFloat(ExistingWorkHour.replaceAll(/,/g, ''));
        var NewEfforts = calculateNewEfforts(input.value, projectEnddate, projectID, ExistingWorkHour);
        effortInput.value = NewEfforts.replaceAll(",", "") > 0 ? NewEfforts : 0;
    }



    function calculateNewEfforts(NewEndDate, oldEndDate, ProjectID, ExistingWorkHour) {
        // Parse new and old end dates
        //Added by Vishal Mane on 18/06/2025 to fix crash for null value of NewEndDate
        if (NewEndDate == "" || NewEndDate == undefined) {
            NewEndDate = GlobalContractEndDate;
        }
        //End of Added by Vishal Mane on 18/06/2025 to fix crash for null value of NewEndDate
        var ExistingWorkHours = "";
        ExistingWorkHours = ExistingWorkHour.toString();
        const newEndDate = new Date(NewEndDate);
        const oldDate = new Date(oldEndDate);
        if (ExistingWorkHours.indexOf(",") > -1) {
            ExistingWorkHours = ExistingWorkHours.replaceAll(",", "");
        }

        const formatDate = (date) => {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, "0"); // Months are 0-based
            const day = String(date.getDate()).padStart(2, "0");
            return `${year}-${month}-${day}`;
        };


        var ProjectdataParameter = {
            ProjectID: ProjectID,
            StartDate: formatDate(oldDate),
            EndDate: formatDate(newEndDate),
            UserID: UserID,
            ExistingWorkhours: ExistingWorkHours,

        }
        var param = JSON.stringify(ProjectdataParameter);
        var data = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectNewEffort", param, false);

        return data
    }



    // Synchronize Grid End Dates with External Input

    function updateGridEndDates(input) {
        var newDate = input.value;
        const contractEndDate = new Date(ValidateionGlobalContractEndDate);
        if (newDate == '') {
            alertify.set('notifier', 'position', 'top-right');
            //alertify.error("Please Select a Revised End Date");
            alertify.error("Please Select valid End Date");
            input.value = ValidateionGlobalContractEndDate;
            return;
        }
        const endDateInputs = document.querySelectorAll("input[id^='td_ProjnewEndDate']");
        if (new Date(newDate) > contractEndDate) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(`The date cannot exceed the global contract end date: ${ValidateionGlobalContractEndDate}`);
            //alert();
            input.value = ValidateionGlobalContractEndDate;
            endDateInputs.forEach(input => {
                input.value = ValidateionGlobalContractEndDate;
            });
            return; // Prevent invalid updates

        }
        //endDateInputs.forEach(input => {
        //    input.value = newDate;
        //});

        endDateInputs.forEach((newEndDateInput, index) => {
            // Update the "Revised End Date" field
            //Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
            //newEndDateInput.value = newDate;
            const status = newEndDateInput.getAttribute("data-status");
            if (status !== "Submitted") {
                newEndDateInput.value = newDate;
            }
            //End of Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests

            // Find the old end date for the current row
            const row = newEndDateInput.closest("tr");
            //Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
            //const oldEndDateElement = row.querySelector(`td:nth-child(5)`); // Assuming "Plan End Date" is the 4th column
            const oldEndDateElement = row.querySelector(`td:nth-child(6)`);

            const oldEndDate = oldEndDateElement ? oldEndDateElement.textContent.trim() : null;

            //const ExisitingEffortsElement = row.querySelector(`td:nth-child(6)`);
            const ExisitingEffortsElement = row.querySelector(`td:nth-child(7)`);
            const ExisitingEfforts = ExisitingEffortsElement ? ExisitingEffortsElement.textContent.trim() : null;

            //const ProjectElement = row.querySelector(`td:nth-child(2)`);
            const ProjectElement = row.querySelector(`td:nth-child(3)`);
            const ProjectID = ProjectElement ? ProjectElement.id.trim() : null;
            //End of Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value

            //console.log("KL")
            //console.log(ProjectElement)
            //console.log(ProjectID)

            //kam chalu hai 

            // Find the effort field ID for this row
            const effortFieldId = `newEfforts_${index + 1}`; // Assuming consistent naming convention

            var NewEfforts;
            // Calculate and update efforts if old end date exists
            if (oldEndDate) {
                NewEfforts = calculateNewEfforts(newEndDateInput.value, oldEndDate, ProjectID, ExisitingEfforts);
            }
            const effortInput = document.getElementById(effortFieldId);
            effortInput.value = NewEfforts; // Ensure no negative values
            //effortInput.value = NewEfforts > 0 ? NewEfforts : 0; // Ensure no negative values


        });

    }

    //for checkbox

    const MAX_SELECTION = 10;

    function toggleRowSelection(checkbox, rowIndex) {

        const table = document.getElementById('Proj_BulkExtensionTbl');
        const row = table.rows[rowIndex];

        // Extract row data
        const rowData = {
            ProjectID: checkbox.getAttribute('data-id'),
            ProjectName: row.cells[1].textContent.trim(),
            //Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
            //ProjectValue: row.cells[2].querySelector('input').value,
            //PlanStartDate: row.cells[3].textContent.trim(),
            //PlanEndDate: row.cells[4].textContent.trim(),
            //Efforts: row.cells[5].textContent.trim(),
            //ProjectStatus: row.cells[6].querySelector('select').value,
            //ProjectNewEffort: row.cells[7].querySelector('input').value,
            //NewEndDate: row.cells[8].querySelector('input').value,
            //RequestId: row.cells[11].querySelector('input').value,
            //IsResubmit: parseInt(row.cells[11].querySelector('input[type="hidden"]').value) != 0 ? 1 : 0,
            //SubmittedBy: LoginID
            ProjectValue: row.cells[3].querySelector('input').value,
            PlanStartDate: row.cells[4].textContent.trim(),
            PlanEndDate: row.cells[5].textContent.trim(),
            Efforts: row.cells[6].textContent.trim(),
            ProjectStatus: row.cells[7].querySelector('select').value,
            ProjectNewEffort: row.cells[8].querySelector('input').value,
            NewEndDate: row.cells[9].querySelector('input').value,
            RequestId: row.cells[12].querySelector('input').value,
            IsResubmit: parseInt(row.cells[12].querySelector('input[type="hidden"]').value) != 0 ? 1 : 0,
            //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
            IsResubmit_StatusID: parseInt(row.cells[12].querySelector('input[type="hidden"]').value),
            //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
            SubmittedBy: LoginID
            //End of Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
        };

        // Fetch original data using rowIndex
        const originalRowData = globalProjData[rowIndex - 1]; // Adjust rowIndex if the table has a header row

        if (!originalRowData) {
            console.error('Original data not found for row index:', rowIndex);
            return;
        }

        // Check if there are changes
        const hasChanges =
            rowData.ProjectValue !== originalRowData.ContractValue ||
            rowData.ProjectStatus !== originalRowData.ProjectStatus.toString() ||
            rowData.ProjectNewEffort !== calculateNewEfforts(GlobalContractEndDate, originalRowData.ExpectedEndDate, originalRowData.ProjectID, originalRowData.EstimatedEfforts) ||
            rowData.NewEndDate !== (GlobalContractEndDate || '');

        if (checkbox.checked) {
            if (selectedRows.length > MAX_SELECTION) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`You can select a maximum of ${MAX_SELECTION} rows.`);
                checkbox.checked = false; // Uncheck the checkbox
                return;
            }

            if (hasChanges) {
                //if (!selectedRows.some(item => item.ProjectID === rowData.ProjectID)) {
                //    selectedRows.push(rowData);
                //}

                selectedRows = selectedRows.filter(item => item.ProjectID != rowData.ProjectID);

                selectedRows.push(rowData);

            } else {
                //alert();

                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`No changes detected for Project: ${rowData.ProjectName}`);
                checkbox.checked = false;
            }
        } else {
            selectedRows = selectedRows.filter(item => item.ProjectID != rowData.ProjectID);
        }

    }







    //const MAX_SELECTION = 5;
    //function toggleRowSelection(checkbox, rowIndex) {
    //    //
    //    const table = document.getElementById('Proj_BulkExtensionTbl');
    //    const row = table.rows[rowIndex];
    //    const rowData = {
    //        ProjectID: checkbox.getAttribute('data-id'), // Retrieve the ID
    //        ProjectName: row.cells[0].textContent.trim(),
    //        Projectvalue: row.cells[1].querySelector('input').value,
    //        PlanStartDate: row.cells[2].textContent.trim(),
    //        PlanEndDate: row.cells[3].textContent.trim(),
    //        Efforts: row.cells[4].textContent.trim(),
    //        ProjectStatus: row.cells[5].querySelector('select').value,
    //        ProjectNewEffort: row.cells[6].querySelector('input').value,
    //        NewEndDate: row.cells[7].querySelector('input').value,
    //        SubmittedBy: LoginID
    //    };

    //    if (checkbox.checked) {
    //        if (selectedRows.length >= MAX_SELECTION) {
    //            alertify.set('notifier', 'position', 'top-right');                    
    //            alertify.error(`You can select a maximum of ${MAX_SELECTION} rows.`);
    //            //alert();
    //            checkbox.checked = false; // Uncheck the checkbox
    //            return;
    //        }

    //        // Add the row data to the array if not already present
    //        if (!selectedRows.some(item => item.ProjectName === rowData.ProjectName)) {
    //            selectedRows.push(rowData);
    //        }
    //    } else {
    //        // Remove the row data from the array
    //        selectedRows = selectedRows.filter(item => item.ProjectName !== rowData.ProjectName);
    //    }

    //    console.log(selectedRows); // Debugging output
    //}

    function SendForApproval(element) {
        var Approvaltype = element.dataset.flag;
        if (Approvaltype == 'showProjApprovalbtn') {
            Flag = 0;
        } else {
            Flag = 1;
        }
        var ProjectdataParameter = {
            RoleID: RoleID,
            Flag: Flag
        }
        var param = JSON.stringify(ProjectdataParameter);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/CheckIsProjectExtensionApprover", param, false);
        if (Approvaltype == 'showProjApprovalbtn') {
            if (strResult !== 'True' && strResult != "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Please Set Project Extension Approver`);
                return;
            }
        }
        else {
            if (strResult !== 'True' && strResult != "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Please Set Resource Extension Approver`);
                return;
            }
        }


        if (Approvaltype == 'showProjApprovalbtn') {

            submitBulkExtensionApproval();
            //Added by Ajit L for hiding comment submit modal after sending Mail
            // $("#ApprovalCommentModal").modal('hide');
            //End of Added by Ajit L for hiding comment submit modal after sending Mail

        }
        else if (Approvaltype == 'showResApprovalbtn') {
            //alert('Resourse ka data save kr');
            //if (selectedRowsResData.length == 0) {
            //    alert("Please select a check boxes to save resources request");
            //}

            saveSelectedResRows();


            //Added by Ajit L for hiding comment submit modal after sending Mail
            // $("#ApprovalCommentModal").modal('hide');
            //End of Added by Ajit L for hiding comment submit modal after sending Mail
        }



        //kam baki hai
    }


    function showProjectRevision(ProjectID) {

        //alert(ProjectID);
        var ProjectdataParameter = {
            ProjectID: ProjectID
        }
        var param = JSON.stringify(ProjectdataParameter);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectRevisionHistory", param, false);
        //console.log(data);

        //document.getElementById("ProjRFromStage").innerText = "";
        //document.getElementById("ProjRActionTaken").innerText = "";
        //document.getElementById("ProjRRevisionNumber").innerText = "";
        //document.getElementById("ProjRTodate").innerText = "";
        //document.getElementById("ProjRTostage").innerText = "";
        //document.getElementById("ProjRApproval").innerText = "";
        //document.getElementById("ProjRComment").innerText = "";

        //document.getElementById("ProjRFromStage").innerText = data[0].FromStage;
        //document.getElementById("ProjRActionTaken").innerText = data[0].ActionType;
        //document.getElementById("ProjRRevisionNumber").innerText = data[0].WorkflowInstanceID;
        //document.getElementById("ProjRTodate").innerText = data[0].EventTime;
        //document.getElementById("ProjRTostage").innerText = data[0].ToStage;
        //document.getElementById("ProjRApproval").innerText = data[0].UserName;
        //document.getElementById("ProjRComment").innerText = data[0].comments;

        $("#ProjectRevisionTbody").html('');
        $("#ProjectRevisionTbl").dataTable().fnDestroy();
        var strHTML = "";
        for (var i = 0; i < strResult.length; i++) {
            var fullComment = strResult[i].comments;
            var shortComment = fullComment.length > 20 ? fullComment.substring(0, 20) + "..." : fullComment;
            if (i == 0) {
                var color = "";
                if (strResult[i].ActionType == "Submitted") {
                    color = "#c8e0eec4";
                }
                else if (strResult[i].ActionType == "Approved") {
                    color = "#a0ffa0";
                }
                else if (strResult[i].ActionType == "Rejected") {
                    color = "#f2b1b1";
                }
                strHTML += '<tr>'
                strHTML += '<td style="background-color:' + color + '!important"> ' + strResult[i].WorkflowInstanceID + '</td>'
                strHTML += '<td style="background-color:' + color + '!important"> ' + strResult[i].EventTime + '</td>'
                strHTML += '<td style="background-color:' + color + '!important"> ' + strResult[i].ActionType + '</td>'
                strHTML += '<td style="background-color:' + color + '!important"> ' + strResult[i].FromStage + '</td>'
                strHTML += '<td style="background-color:' + color + '!important"> ' + strResult[i].ToStage + '</td>'
                strHTML += '<td style="background-color:' + color + '!important"> ' + strResult[i].UserName + '</td>'
                strHTML += '<td style="background-color:' + color + '!important" data-bs-toggle="tooltip" title="' + fullComment + '"> ' + shortComment + '</td>'
                strHTML += '</tr>'
            }
            else {
                strHTML += '<tr>'
                strHTML += '<td> ' + strResult[i].WorkflowInstanceID + '</td>'
                strHTML += '<td> ' + strResult[i].EventTime + '</td>'
                strHTML += '<td> ' + strResult[i].ActionType + '</td>'
                strHTML += '<td> ' + strResult[i].FromStage + '</td>'
                strHTML += '<td> ' + strResult[i].ToStage + '</td>'
                strHTML += '<td> ' + strResult[i].UserName + '</td>'
                strHTML += '<td data-bs-toggle="tooltip" title="' + fullComment + '"> ' + shortComment + '</td>'
                strHTML += '</tr>'
            }
        }
        $("#ProjectRevisionTbody").html("");

        $("#ProjectRevisionTbody").html(strHTML);
        //tableMilestone = $('#ProjectRevisionTbl').DataTable({
        //    "pageLength": 10,
        //    "bdestroy": true,
        //    "lengthChange": false,
        //    "bFilter": false,
        //    "ordering": false,
        //    "responsive": true,
        //    "columnDefs": [
        //        { "width": "100px" }

        //    ],
        //    "drawCallback": function (settings) {
        //        $('[data-bs-toggle="tooltip"]').tooltip();
        //    }
        //});

        tableMilestone = $('#ProjectRevisionTbl').DataTable({
            "scrollY": true,
            "scrollX": true,
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
            "info": true,
            pagingType: "simple",
            language: {
                info: "Total Records: _TOTAL_",
                infoEmpty: "Total Records: 0",
                paginate: {
                    previous: "<<",
                    next: ">>"
                }
            }
        });
        resizeSection_Updated();

        if (strHTML == "") {
            $("#divRevisionhistory tbody tr td").prop("colspan", 7);
            $("#divRevisionhistory tbody tr td").html("No data available in table");
        }
    }

    //Grip plotting with filter

    var globalProjData;
    function PlotProjectGrid(contractID, contractEndDate, PageNumber) {
        selectedRows.length = 0;
        var ProjectdataParameter = {
            UserID: UserID,
            ContractID: contractID,
            LoginType: LoginType,
            LoginID: LoginID,
            PageNo: PageNumber
        }
        var param = JSON.stringify(ProjectdataParameter);
        var data = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectData", param, false);
        //console.log(contractEndDate)
        //console.log(data)
        var ProjData = data;
        globalProjData = data;
        var statusData = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectStatus", '', false);
        var thead = `<thead class="stickyTblHeader">
                                        <tr>
                                            <th style="width: 100px;">Project Code</th>
                                            <th style="width: 100px;">Project Name</th>
                                            <th style="width: 100px;">Total Excepted Revenue</th>
                                            <th style="width: 100px;">Revised Total Excepted Revenue</th>
                                            <th style="width: 50px;">Planned Start Date</th>
                                            <th style="width: 50px;">Planned End Date</th>
                                            <th style="width: 100px;">Efforts<br>(<span class="">Hrs.</span>) </th>
                                            <th style="width: 100px;">Project Status</th>
                                            <th style="width: 150px;">Revised Efforts<br>(<span class="">Hrs.</span>)</th>
                                            <th style="width: 300px;">Revised End Date</th>
                                            <th class="">History</th>
                                            <th></th>
                                            <th style="width: 100px;">
                                                <div class="custom_chckbox">
                                                    <input id="PM_BulkExtensionCheckAll" class="chckHead" onchange='toggleAllRowsProjectSelection(this)' type="checkbox">
                                                    <label for="PM_BulkExtensionCheckAll"></label>
                                                </div>
                                            </th>
                                        </tr>
                                    </thead>`;
        //End of Commented and Added by Vishal Mane on 18/06/2025 to have a full display for 'Revised End date'

        var tbody = `<tbody>`;
        ProjData.forEach((project, index) => {
            //project.Project_Status.includes('Sent for Approval')
            //project.Project_Status !== 'Pending Approval' && project.Project_Status !== ''
            // Generate status options with the correct status selected
            let fullProjectName = project.ProjectName;
            let shortProjectName = fullProjectName.length > 20 ? fullProjectName.substring(0, 20) + "..." : fullProjectName;

            let statusOptions = statusData.map(status => {
                const selected = status.ProjectStatus === project.ProjectStatus ? "selected" : ""; // Automatically select the correct status
                return `<option value="${status.ProjectStatusID}" ${selected}>${status.ProjectStatus}</option>`;
            }).join("");
            //Commented by Vishal Mane on 24/02/2026 for Bulk Extensio integration
            GlobalContractEndDate = project.ExpectedEndDate;
            var NewEfforts = calculateNewEfforts(GlobalContractEndDate, project.ExpectedEndDate, project.ProjectID, project.EstimatedEfforts);
            //var NewEfforts = 0;
            //End of Commented by Vishal Mane on 24/02/2026 for Bulk Extensio integration
            //Commented and Added By Riddhesh Patil on 03 March 2025 for checking status of project
            //if (project.Project_Status.includes('Sent for Approval')) {
            //Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value
            if (project.Project_Status.includes('Sent for Approval') || project.Project_Status.includes('Rejected')) {
                //End of Commented and Added By Riddhesh Patil on 03 March 2025 for checking status of project
                tbody += `  <!--Commented and Added by Vishal Mane on 09/02/2026 to bind workfloe related data -->
                                <!--<tr>-->
                                <tr data-workflowid="${project.WorkflowID}"
                                data-workflowname="${project.WorkflowName}" data-practicename="${project.PracticeName}"
                                data-businessgroupname="${project.BusinessGroupName}" data-locationname="${project.LocationName}">
                                <td class=" bg_lightRed">${project.ProjectCode}</td>
                                <td class="bg_lightRed truncate-text" id="${project.ProjectID}" data-bs-toggle="tooltip" title="${fullProjectName}">${shortProjectName}</td>
                                <td class=" bg_lightRed">${project.ContractValue}</td>
                                <td class=" bg_lightRed"><input class="form-control" type="text" value="${project.ProjectNewValue}" disabled></td>
                                <td class=" bg_lightRed">${project.ExpectedStartDate}</td>
                                <td class=" bg_lightRed">${project.ExpectedEndDate}</td>
                                <td class=" bg_lightRed">${project.EstimatedEfforts}</td>
                                <td class=" bg_lightRed">
                                    <div class="">
                                        <select class="selectpicker " aria-label="Select Status" id="Status_${index + 1}" data-live-search="true" id="" disabled>
                                            ${statusOptions}
                                        </select>
                                    </div>
                                </td>
                                <td class=" bg_lightRed" ><input id="newEfforts_${index + 1}" class="form-control" type="text" value="${NewEfforts}" disabled></td>`
                //Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
                if (project.Project_Status.includes('Sent for Approval')) {
                    tbody += `<td class=" bg_lightRed">
                                    <div class="input-group">
                                        <input data-status="Submitted" id="td_ProjnewEndDate${index + 1}" class="form-control date-picker" value="${project.ExpectedEndDate || ''}" onchange="validateEndDate(this,'${index + 1}','${project.ExpectedEndDate}', 'newEfforts_${index + 1}',${project.ProjectID},${project.EstimatedEfforts.replaceAll(",", "")},'${project.TaskEndDate}','${project.ExpectedStartDate}')" disabled>
                                            <span class="input-group-btn" for="td_ProjnewEndDate${index + 1}">
                                                <button class="btn btncalendar" type="button" for="td_ProjnewEndDate${index + 1}">
                                                    <i class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                    </div>
                                 </td>`
                } else {
                    tbody += `<td class=" bg_lightRed">
                                    <div class="input-group">
                                        <input data-status="Editable" id="td_ProjnewEndDate${index + 1}" class="form-control date-picker" value="${project.ExpectedEndDate || ''}" onchange="validateEndDate(this,'${index + 1}','${project.ExpectedEndDate}', 'newEfforts_${index + 1}',${project.ProjectID},${project.EstimatedEfforts.replaceAll(",", "")},'${project.TaskEndDate}','${project.ExpectedStartDate}')" disabled>
                                            <span class="input-group-btn" for="td_ProjnewEndDate${index + 1}">
                                                <button class="btn btncalendar" type="button" for="td_ProjnewEndDate${index + 1}">
                                                    <i class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                    </div>
                                 </td>`
                }
                //End of Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
                tbody += `<td class="bg_lightRed">
                                    ${project.HistoryFlag != "0" ? `
                                    <div class="mx-2 ">
                                    <span data-bs-toggle="offcanvas" data-bs-target="#ShowPrjHisDetailpanel">
                                    <i class="fas fa-history Card_View_whiz  txt_hover" data-bs-toggle="tooltip" title="Show History" onclick='ShowProjecthistory(${project.ProjectApprovalID}); ShowProjectApprovalHistory(${project.ProjectApprovalID})'></i>
                                    </span>
                                    </div>` : ''
                    }
                                    </td>
                                <td class=" bg_lightRed ">
                                    <div class="mx-2">
                                        <span data-bs-toggle="tooltip" aria-label="More Details" data-bs-original-title="More Details">
                                            <span data-bs-toggle="offcanvas" data-bs-target="#moredetailsProject_OffcvsScreen" class="txt_hover"><i class="fas fa-info-circle Card_View_whiz clearedStage1" onclick="showProjectRevision(${project.ProjectID})"></i></span>
                                        </span>
                                    </div>
                                </td>                               
                                <td class=" bg_lightRed ">
                                    <div class="d-flex justify-content-center">
                                    <div class="custom_chckbox blocked">
                                        <input id="bulExtensionCheck${index + 1}" class="chcktbl reversalMain" value="${project.ProjectApprovalID}" type="checkbox" data-id="${project.ProjectID}" disabled>
                                        <label for="bulExtensionCheck${index + 1}"></label><input type="hidden" id="hdn${index + 1}" value="${project.StatusId}">
                                    </div>
                                               
                            </div>
                                </td>
                        </tr>`;
                //} else if (project.ApprovalStatus == 'Submitted') {
            }
            else if (project.StatusId == 1) {
                tbody += `<!--Commented and Added by Vishal Mane on 09/02/2026 to bind workfloe related data -->
                                <!--<tr>-->
                                <tr data-workflowid="${project.WorkflowID}"
                                data-workflowname="${project.WorkflowName}" data-practicename="${project.PracticeName}"
                                data-businessgroupname="${project.BusinessGroupName}" data-locationname="${project.LocationName}">
                                <td class=" bg_blue">${project.ProjectCode}</td>
                                <td class="bg_blue truncate-text" id="${project.ProjectID}" data-bs-toggle="tooltip" title="${fullProjectName}">${shortProjectName}</td>
                                <td class=" bg_blue">${project.ContractValue}</td>
                                <td class=" bg_blue"><input class="form-control" type="text" value="${project.ProjectNewValue}" disabled></td>
                                <td class=" bg_blue">${project.ExpectedStartDate}</td>
                                <td class=" bg_blue">${project.ExpectedEndDate}</td>
                                <td class=" bg_blue">${project.EstimatedEfforts}</td>
                                <td class=" bg_blue">
                                    <div class="">
                                        <select class="selectpicker " aria-label="Select Status" id="Status_${index + 1}" data-live-search="true" id="" disabled>
                                            ${statusOptions}
                                        </select>
                                    </div>
                                </td>
                                <td class="bg_blue" ><input id="newEfforts_${index + 1}" class="form-control" type="text" value="${NewEfforts}" disabled></td>`
                //Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
                tbody += `<td class="bg_blue">
                                    <div class="input-group">
                                        <input data-status="Submitted" id="td_ProjnewEndDate${index + 1}" class="form-control date-picker" value="${project.NewEnddate || ''}" onchange="validateEndDate(this,'${index + 1}','${project.ExpectedEndDate}', 'newEfforts_${index + 1}',${project.ProjectID},${project.EstimatedEfforts.replaceAll(",", "")},'${project.TaskEndDate}','${project.ExpectedStartDate}')" disabled>
                                            <span class="input-group-btn" for="td_ProjnewEndDate${index + 1}">
                                                <button class="btn btncalendar" type="button" for="td_ProjnewEndDate${index + 1}">
                                                    <i class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                    </div>
                                 </td>`
                //End of Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
                tbody += `<td class="bg_blue">
                                ${project.HistoryFlag != "0" ? `
                                <div class="mx-2 ">
                                <span data-bs-toggle="offcanvas" data-bs-target="#ShowPrjHisDetailpanel">
                                <i class="fas fa-history Card_View_whiz  txt_hover" data-bs-toggle="tooltip" title="Show History" onclick='ShowProjecthistory(${project.ProjectApprovalID}); ShowProjectApprovalHistory(${project.ProjectApprovalID})'></i>
                                </span>
                                </div>` : ''
                    }
                                </td>
                                <td class="bg_blue "></td>                                
                                <td class="bg_blue ">
                                    <div class="d-flex justify-content-center">
                                        <div class="custom_chckbox blocked">
                                            <input id="bulExtensionCheck${index + 1}" class="chcktbl reversalMain" value="${project.ProjectApprovalID}" type="checkbox" data-id="${project.ProjectID}" disabled>
                                            <label for="bulExtensionCheck${index + 1}"></label><input type="hidden" id="hdn${index + 1}" value="${project.StatusId}">
                                        </div>   
                                                
                                    </div>
                                </td>
                            </tr>`;
            }
            else {
                tbody += `<!--Commented and Added by Vishal Mane on 09/02/2026 to bind workfloe related data -->
                                <!--<tr>-->
                                <tr data-workflowid="${project.WorkflowID}"
                                data-workflowname="${project.WorkflowName}" data-practicename="${project.PracticeName}"
                                data-businessgroupname="${project.BusinessGroupName}" data-locationname="${project.LocationName}">
                                <td class=" ">${project.ProjectCode}</td>
                                <td class="truncate-text" id="${project.ProjectID}" data-bs-toggle="tooltip" title="${fullProjectName}">${shortProjectName}</td>
                                <td class="">${project.ContractValue}</td>
                                <td class=""><input class="form-control" type="text" value="${project.ProjectNewValue}" maxlength="12" onchange="ValidateProjectValue(this,${index},${project.ProjectID})"></td>
                                <td class="">${project.ExpectedStartDate}</td>
                                <td class="">${project.ExpectedEndDate}</td>
                                <td class="">${project.EstimatedEfforts}</td>
                                <td class="">
                                    <div class="">
                                        <select class="selectpicker " aria-label="Select Status" id="Status_${index + 1}" data-live-search="true" id="">
                                            ${statusOptions}
                                        </select>
                                    </div>
                                </td>
                                <td class=""><input id="newEfforts_${index + 1}" class="form-control" type="text" value="${NewEfforts}" maxlength="12" onchange='ValidateNewEffort(this,${project.EstimatedEfforts.replaceAll(",", "")},${NewEfforts})'</td>`

                tbody += `<td class="">
                                    <div class="input-group">
                                        <input data-status="Editable" id="td_ProjnewEndDate${index + 1}" class="form-control date-picker" value="${GlobalContractEndDate || ''}" onchange="validateEndDate(this,'${index + 1}','${project.ExpectedEndDate}', 'newEfforts_${index + 1}',${project.ProjectID},${project.EstimatedEfforts.replaceAll(",", "")},'${project.TaskEndDate}','${project.ExpectedStartDate}')">
                                            <span class="input-group-btn" for="td_ProjnewEndDate${index + 1}">
                                                <button class="btn btncalendar" type="button" for="td_ProjnewEndDate${index + 1}">
                                                    <i class="fas fa-calendar-alt"></i>
                                                </button>
                                            </span>
                                            </div>
                                         </td>`

                tbody += `<td>
                                ${project.HistoryFlag != "0" ? `
                                <div class="mx-2 ">
                                <span data-bs-toggle="offcanvas" data-bs-target="#ShowPrjHisDetailpanel">
                                <i class="fas fa-history Card_View_whiz  txt_hover" data-bs-toggle="tooltip" title="Show History" onclick='ShowProjecthistory(${project.ProjectApprovalID}); ShowProjectApprovalHistory(${project.ProjectApprovalID})'></i>
                                </span>
                                </div>` : ''
                    }
                               </td>
                               <td class="">
                               </td>
                               <td class="">
                                <div class="d-flex justify-content-center">
                                    <div class="custom_chckbox">
                                        ${/*<input id="bulExtensionCheck${index + 1}" class="chcktbl reversalMain" value="${project.ProjectApprovalID}" type="checkbox" data-id="${project.ProjectID}" onchange="toggleRowSelection(this, ${index + 1})">*/''}
                                        <input id="bulExtensionCheck${index + 1}" class="chcktbl reversalMain" value="${project.ProjectApprovalID}" type="checkbox" data-id="${project.ProjectID}" >
                                            <label for="bulExtensionCheck${index + 1}"></label><input type="hidden" id="hdn${index + 1}" value="${project.StatusId}">
                                        </div>
                                  
                                    </div>
                                </td>
                            </tr>`;
            }
            //End of Added and modified by Vishal Mane on 07/10/2025 to update changes due to newly added column Revised Project Contract Value

        })

        var tableid = $("#Proj_BulkExtensionTbl");
        //thead, tbody
        tableid.empty();
        tableid.append(thead);
        tableid.append(tbody);
        $('[data-bs-toggle="tooltip"]').tooltip();

        //datatable
        if ($.fn.DataTable.isDataTable('#Proj_BulkExtensionTbl')) {
            $('#Proj_BulkExtensionTbl').DataTable().destroy();
        }
        $(".selectpicker").selectpicker('refresh');
        //$('#Proj_BulkExtensionTbl').dataTable({
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
        //$('#Proj_BulkExtensionTbl').wrap('<div class="dataTables_scroll" />');
        $(".reversalMain").each(function () {
            $(this).prop("checked", false);
        });
        // Project list View Check or Uncheck All checkboxes
        $("#PM_BulkExtensionCheckAll").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".reversalMain").each(function () {
                    if ($(this).is(':disabled')) {
                        $(this).prop("checked", false);
                    } else {
                        $(this).prop("checked", true);
                    }
                });
            } else {
                $(".reversalMain").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Project list View of CheckAll checkbox
        $(".reversalMain").click(function () {
            if ($(".reversalMain").length === $(".reversalMain:checked").length) {
                $("#PM_BulkExtensionCheckAll").prop("checked", true);
            } else {
                $("#PM_BulkExtensionCheckAll").prop("checked", false);
            }
        });

        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };



        //datepicker
        //$('#newEndDate, #Resource_newEndDate, #updateNew_Date, #effective_Date, #td_ProjnewEndDate1, #td_ProjnewEndDate2, #td_ProjnewEndDate3, #td_ProjnewEndDate4, #td_ProjnewEndDate5, #td_ProjnewEndDate6, #td_newEndDate1, #td_newEndDate2, #td_newEndDate3').datepicker({
        //    autoclose: true,
        //    changeMonth: true,
        //    changeYear: true,
        //    dateFormat: 'dd M yy'
        //});



        //Commented by Ajit L on  20/06/2025 for Pagination Issue
        // var ItemsPerPage = 5;
        var ItemsPerPage = 10;
        //End of Commented by Ajit L on  20/06/2025 for Pagination Issue
        TotalPages = Math.ceil(TotalPagesCount / ItemsPerPage);
        //alert(TotalPages);
        if (PageNumber === TotalPages) {
            $('#btnnext').addClass('disabled');
            isNextDisabled = true;
        } else {
            $('#btnnext').removeClass('disabled');
            isNextDisabled = false;
        }

        if (PageNumber === 1) {
            $('#btnprevious').addClass('disabled');
            isPreviousDisabled = true;
        } else {
            $('#btnprevious').removeClass('disabled');
            isPreviousDisabled = false;
        }
    }


    function SendForProjApprove(element) {
        //debugger
        var detail = element.id;
        //alert(detail);

        targetElement = document.getElementById('Approve_Submit_Btn');
        //alert(targetElement.id);
        if (detail === "showProjApprovalbtn") {
            selectedRows = [];
            $(".reversalMain:not(:disabled)").each(function () {
                if ($(this).is(":checked")) {
                    const rowIndex = $(this).closest("tr").index(); // Get the row index
                    toggleRowSelection(this, rowIndex + 1);
                }
            });
            //Added by Ajit L on 28/01/2025
            if ($('#newEndDate').val() == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select a Revised End Date");
                return;
            }

            for (var i = 0; i < selectedRows.length; i++) {

                if (new Date(selectedRows[i].NewEndDate) < new Date(selectedRows[i].PlanEndDate)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(`Project '${selectedRows[i].ProjectName}' Revised End Date should be greater than project planned end Date ${selectedRows[i].PlanEndDate}`);
                    return;
                }
            }
            if (selectedRows.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
                //alertify.error("No rows selected.");
                alertify.error("Please select at least one row.");
                //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
                return;
            }
            //Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
            //$("#ApprovalCommentModal").modal("show");             
            buildWorkflowApprovalUI(selectedRows);
            //End of Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen

            //End of Added by Ajit L on 28/01/2025
            targetElement.setAttribute("data-flag", `${detail}`);
        }
        else if (detail === "showResApprovalbtn") {
            selectedRowsResData = [];
            toggleRowResSelection();

            //Added by Ajit L on 28/01/2025
            if ($('#updateNew_Date').val() == '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please select a Revised End Date");
                return;
            }

            if (selectedRowsResData.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
                //alertify.error("No rows selected.");
                alertify.error("Please select at least one row.");
                //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
                return;
            }

            // Added by Ajit L on 4th July 2025 to check if resource's Current End Date & Revised End Date
            let SameDateResources = [];

            for (let i = 0; i < selectedRowsResData.length; i++) {
                const row = selectedRowsResData[i];

                const newEndDate = new Date(row.ResourceNewEndDate);
                const expectedEndDate = new Date(row.ExpectedEndDate);

                // Compare both date values and status
                if (newEndDate.getTime() === expectedEndDate.getTime()) {
                    SameDateResources.push(row.ResourceName);
                }
            }

            if (SameDateResources.length > 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Current End Date & Revised End Date should not be same for resource(s): ${SameDateResources.join(', ')}.`);
                return;
            }

            //End of Added by Ajit L on 4th July 2025 to check if resource's Current End Date & Revised End Date

            $("#ApprovalCommentModal").modal("show");
            //End of Added by Ajit L on 28/01/2025
            targetElement.setAttribute("data-flag", `${detail}`);
        }
        $(`#ProjectApprovalRemark`).val("");
    }
    //

    //Added By Riddhesh Patil On 5 March 2025 to check invoice amount validation
    function GetIRAmountValidation(ProjectID, ProjValue) {
        var Parameters =
        {
            ProjectID: ProjectID,
            ProjectValue: ProjValue
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetIRAmountValidation", param, false);
        return strResult;
    }
    //End of Added By Riddhesh Patil On 5 March 2025 to check invoice amount validation

    function ValidateProjectValue(element, rowIndex, ProjectID) {
        //debugger
        // Retrieve the original data using the rowIndex
        const originalRowData = globalProjData[rowIndex]; // Adjust rowIndex if the table has a header row

        if (!originalRowData) {
            console.error('Original data not found for row index:', rowIndex);
            return;
        }
        var validateAlert = validatePositiveDecimal(element);
        if (validateAlert) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(validateAlert);
            element.value = originalRowData.ContractValue;
            return;
        }
        else if (element.value == '') {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(`Total excepetd revenue feild should not be left blank.`);
            element.value = originalRowData.ContractValue;
        }

        // Parse the entered value and the original value to ensure proper comparison
        // const enteredValue = parseFloat(element.value);
        const enteredValue = parseFloat(element.value.replaceAll(",", ''));
        //Commented and added by Vishal Mane on 05/12/2025 to fix issue due to comma saperated value 
        //const globalValue = parseFloat(originalRowData.ContractValue);
        const globalValue = parseFloat(originalRowData.ContractValue.replaceAll(",", ''));
        //End of Commented and added by Vishal Mane on 05/12/2025 to fix issue due to comma saperated value 
        //Added By Riddhesh Patil On 5 March 2025 to check invoice amount validation
        var Result = GetIRAmountValidation(ProjectID, enteredValue);

        if (Result != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(Result);
            element.value = originalRowData.ContractValue;
            element.focus();
        }
        else {
            //End of Added By Riddhesh Patil On 5 March 2025 to check invoice amount validation
            // Validation: Project value cannot be less than the global value

            if (enteredValue < globalValue) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Project value cannot be less than the Current value ${originalRowData.ContractValue}.`);
                //alertify.error(`StartDate=${GlobalResProjectStartdt} and Enddate=${GlobalResProjectEnddt}`);


                // Reset the value to the global value
                //element.value = globalValue.toFixed(2);
                element.value = originalRowData.ContractValue;

                // Optionally focus back on the input field
                element.focus();
            }

            if (enteredValue > contractValue) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error(`Project value cannot be greater than Contract Value ${contractValue}`);

                element.value = originalRowData.ContractValue;

                element.focus();
            }
        }
        }

    var GlobalResContractID;
    var GlobalResProjectID;
    function handleResContractChange() {
        //var data = $("#ResCboContract").val();
        //var parts = data.split("_EDT_");
        // Extract the values
        var contractID = 0;
        GlobalResContractID = 0;
        //var ContractEndDate = parts[1];
        var $projectDropdown = $("#ResprojectID"); // Find the second dropdown by its ID
        var ProjectdataParameter = {
            UserID: UserID,
            ContractID: contractID,
            LoginType: LoginType,
            LoginID: LoginID

        }
        var param = JSON.stringify(ProjectdataParameter);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectDataDDl", param, false);
        GlobalResProjectID = 0;
        $projectDropdown.empty(); 
        strResult.forEach(function (project) {
            var option = `<option value="${project.ProjectIDs}">${project.ProjectName}</option>`;
            $projectDropdown.append(option);
        });
        $projectDropdown.selectpicker('refresh');
    }

    var GlobalResProjectStartdt;
    var GlobalResProjectEnddt;
    function handleResProjectChange(element) {

        var data = $("#ResprojectID").val();
        var parts = data.split("_EDT_");
        var ProjectID = parts[0];
        var ProjectEndDate = parts[1];
        var ProjectStartDate = parts[2];
        //var parts 
        //var data1 = $("#ResprojectID").attr("id");
        //var data1 = $("#ResprojectID").id(); 
        GlobalResProjectStartdt = ProjectStartDate;
        GlobalResProjectEnddt = ProjectEndDate;
        alertify.set('notifier', 'position', 'top-right');
        //alertify.error(`StartDate=${GlobalResProjectStartdt} and Enddate=${GlobalResProjectEnddt}`);
        //alert()
        GlobalResProjectID = ProjectID;
        //console.log(GlobalResContractID);
        //console.log(GlobalResProjectID);


        $(`#updateNew_Date`).val(GlobalResProjectEnddt);

    }

    //function ShowResGridWithFilter() {
    //    //var AJAXCallWithResult = 
    //    //var Data = AJAXCallWithResult("/api/PM_Bulk_Extension/GetResourceData", '', false);
    //    //plotResourceGrid(Data);
    //}

    function ShowGridWithFilter() {

        var ddlContract = $("#ResCboContract").val();
        var ddlproject = GlobalResProjectID;
        //Added by Ajit L on 29/01/2025 
        var ddlstatus = $("#ResCboStatus").val();
        var ddlRoleId = $("#ResCboRoleID").val();
        //End of Added by Ajit L on 29/01/2025 

        var ddlDesignation = $("#ResCboDesignation").val();

        <%--if (ddlContract == '0_EDT_') {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('<%=MyBase.GetResourceString("A_ContractMandatory") %>');
            //alert("Please Select a contract");
            return;
        }--%>
        if (!ddlproject || ddlproject == 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Please Select a project");
            //alert("Please Select a contract");
            return;
        }

        //
        //kamt kam

        var parts = ddlContract.split("_EDT_");
        // Extract the values
        var ResContractID = parts[0];
        var ContractEndDate = parts[1];



        var ResourcedataParameter = {
            ContractID: ResContractID,
            ProjectID: ddlproject,
            DesignationID: ddlDesignation,
            //Commented & Added by Ajit L on 29/01/2025
            // RoleId: ddlstatus,
            RoleId: ddlRoleId,
            Status: ddlstatus
            //End of Commented & Added by Ajit L on 29/01/2025
        }
        var param = JSON.stringify(ResourcedataParameter);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetResourceData", param, false);
        //console.log(strResult);
        if (strResult) {
            plotResourceGrid(strResult, GlobalResProjectEnddt);
        }
        updateResGridEndDates(GlobalResProjectEnddt, '');
    }

    function updateResGridEndDates(newEnddate, input) {
        //var newResDate = input.value;
        //const table = $("#Res_BulkExtensionTbl");
        const table = gblResourceTbl;
        var newResDate = newEnddate;
        const ProjectEndDate = new Date(GlobalResProjectEnddt);
        const ProjectStartDate = new Date(GlobalResProjectStartdt);
        const selectedDate = new Date(newResDate);

        // Validate the entered date
        if (selectedDate < ProjectStartDate || selectedDate > ProjectEndDate) {
            alertify.set('notifier', 'position', 'top-right');
            //(`You can select a maximum of ${MAX_SELECTION} rows.`);
            alertify.error(`The selected date must be between ${ProjectStartDate.toDateString()} and ${ProjectEndDate.toDateString()}.`);
            input.value = GlobalResProjectEnddt; // Clear the invalid input
            return;
        }
        //if (newResDate) {
        // Update all "Revised End Date" inputs
        //$('input[id^="td_newEndDate"]').each(function () {
        //    $(this).val(newResDate);
        //});
        $('#Res_BulkExtensionTbl tr[data-index]').each(function () {

            const rowIndex = $(this).data('index'); // Get the unique row index
            const planStartDateStr = $(`#Res_BulkExtensionTbl #planStartDate_${rowIndex}`).text(); // Get the Plan Start Date for the row
            const planStartDate = new Date(planStartDateStr);
            const rowInput = $(`#Res_BulkExtensionTbl #td_newEndDate${rowIndex}`); // Get the specific input for this row
            //const rowInput = $(`#Res_BulkExtensionTbl .newEndDate`); // Get the specific input for this row


            const rowData = globalData[rowIndex];
            const projectName = rowData.ProjectName; // Get the Project Name
            const resourceName = rowData.ResourceName; // Get the Resource Name
            const resourceTentativeLeavingDate = rowData.TentativeDateOfRelieving; // Get the Resource Name
            console.log(resourceTentativeLeavingDate);
            // Validate the entered date for this row

            if (selectedDate < planStartDate) {

                //const projectName = $(`#Res_BulkExtensionTbl #projectName_${rowIndex - 1}`).text(); // Get the Project Name                        
                alertify.set('notifier', 'position', 'top-right');
                //(`You can select a maximum of ${MAX_SELECTION} rows.`);
                alertify.error(`For project "${projectName}" and resource "${resourceName}", the selected date must not be earlier than Resource planned start date ${planStartDate.toDateString()}.`);
                rowInput.val(GlobalResProjectEnddt); // Clear the invalid input
                return
            }

            //if (resourceTentativeLeavingDate) {
            //    var TentativeLeavingDate = new Date(resourceTentativeLeavingDate);
            //    if (selectedDate > TentativeLeavingDate) {
            //        
            //        //const projectName = $(`#Res_BulkExtensionTbl #projectName_${rowIndex - 1}`).text(); // Get the Project Name
            //        const rowData = globalData[rowIndex];
            //        const projectName = rowData.ProjectName; // Get the Project Name
            //        const resourceName = rowData.ResourceName; // Get the Resource Name
            //        alertify.set('notifier', 'position', 'top-right');                            
            //        //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
            //        alertify.error(`Resorce (${resourceName}) extension date is greater than tentative leaving date ${resourceTentativeLeavingDate}`);
            //        rowInput.val(resourceTentativeLeavingDate); // Clear the invalid input
            //        return
            //    }
            //} 

            //Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
            // $("#td_newEndDate" + rowIndex).val(newResDate);
            const status = $(this).find("input[id^='td_newEndDate']").attr("data-status");
            if (status !== "Submitted") {
                $("#td_newEndDate" + rowIndex).val(newResDate);
            }
            //End of Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests                
        });

    }

    $(document).on("click", ".paginate_button", function () {
        var newResDate = $('#updateNew_Date').val();
        $(".newEndDate").each(function () {
            //Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
            //$(this).val(newResDate);
            var status = $(this).attr("data-status");
            if (status !== "Submitted") {
                $(this).val(newResDate);
            }
            //End of Commented and Added by Vishal Mane on 18/06/2025 to fix 'Project New End date' field should be non-editable for submittted requests
        });
    });
    function toggleAllRowsProjectSelection(headerCheckbox) {

        //const isChecked = globalCheckbox.checked;
        //$(".reversalMain").each(function (index) {
        //    $(this).prop("checked", isChecked);
        //    if (isChecked) {
        //        addRowDataToArray(index);
        //    } else {
        //        selectedRowsResData = [];
        //        if (selectedRowsResData.length == 0) {
        //            //alert("emty");
        //            alertify.set('notifier', 'position', 'top-right');
        //            alertify.error(`All checkbox Unchecked`);
        //        }
        //    }
        //});


        const isChecked = headerCheckbox.checked;
        const table = document.getElementById("Proj_BulkExtensionTbl");
        const checkboxes = table.querySelectorAll(".chcktbl.reversalMain");

        checkboxes.forEach((checkbox, index) => {
            if (!checkbox.disabled) {
                checkbox.checked = isChecked;

                // Call toggleRowSelection logic for each row
                toggleRowSelection(checkbox, index + 1);
            }
        });
    }


    function toggleAllRowsSelection(globalCheckbox) {
        const isChecked = globalCheckbox.checked;
        $(".ResourceMain").each(function (index) {
            $(this).prop("checked", isChecked);
            if (isChecked) {
                addRowDataToArray(index);
            } else {
                selectedRowsResData = [];
                //if (selectedRowsResData.length == 0) {
                //    //alert("emty");
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.error(`All checkbox Unchecked`);
                //}
            }
        });
    }

    //function toggleRowResSelection(checkbox, index) {

    //    var inputvalue = $(`#td_newEndDate${index}`).val();
    //    //if (inputvalue == '') {
    //    //    checkbox.checked = false;
    //    //    alert(inputvalue);
    //    //    return
    //    //}

    //    const isChecked = checkbox.checked;
    //    if (isChecked) {
    //        addRowDataToArray(index);
    //    } else {
    //        removeRowDataFromArray(index);
    //    }
    //}

    function toggleRowResSelection() {
        $(".ResourceMain").each(function (index) {
            const isChecked = $(this).is(':checked');
            const idText = $(this).attr('id') || ''; // Assuming ID contains the number
            const numberMatch = idText.match(/\d+$/); // Extract digits at the end
            const indexnumber = numberMatch ? numberMatch[0] : null; // Get number or null
            if (isChecked) {
                addRowDataToArray(indexnumber);
            } else {
                if (selectedRowsResData.length > 0) {
                    removeRowDataFromArray(indexnumber);
                }
            }
        });
    }

    //function addRowDataToArray(index) {

    //    const rowData = globalData[index]; // Use global data
    //    const newEndDate = document.getElementById(`td_newEndDate${index}`).value; // Get the New End Date value
    //    //const EffectiveFromDate = document.getElementById(`effective_Date`).value; // Get the New End Date value

    //    //Commented & Added by Ajit L on 27/01/2025
    //    //const rowWithNewEndDate = {
    //    //    ...rowData,
    //    //    ResourceNewEndDate: newEndDate,
    //    //    EffectiveFromDate: EffectiveFromDate
    //    //};

    //    const rowWithNewEndDate = {
    //        ...rowData,
    //        ResourceNewEndDate: newEndDate,

    //        RequestId: rowData.ReqID,
    //        IsResubmit: parseInt(rowData.StatusId) != 0 ? 1 : 0
    //       // EffectiveFromDate: EffectiveFromDate
    //    };
    //    //End of Commented & Added by Ajit L on 27/01/2025


    //    //if (!selectedRowsResData.some(item => item === rowData)) {
    //    //    selectedRowsResData.push(rowData);
    //    //}

    //    if (!selectedRowsResData.some(item => item.ProjectEmployeeRoleID === rowWithNewEndDate.ProjectEmployeeRoleID)) {
    //        selectedRowsResData.push(rowWithNewEndDate); // Add the data with New End Date to selectedRowsData
    //    }
    //    //console.log(selectedRowsResData)
    //}



    function addRowDataToArray(index) {
        const rowData = globalData[index]; // Use global data
        const newEndDate = document.getElementById(`td_newEndDate${index}`).value; // Get the New End Date value

        const rowWithNewEndDate = {
            ...rowData,
            ResourceNewEndDate: newEndDate,
            RequestId: rowData.ReqID,
            IsResubmit: parseInt(rowData.StatusId) != 0 ? 1 : 0
        };

        selectedRowsResData = selectedRowsResData.filter(item => item.ProjectEmployeeRoleID !== rowWithNewEndDate.ProjectEmployeeRoleID);

        selectedRowsResData.push(rowWithNewEndDate);
    }

    function removeRowDataFromArray(index) {
        selectedRowsResData = selectedRowsResData.filter((_, idx) => idx !== index);
        //console.log(selectedRowsResData)
    }
    var gblResourceTbl = "";
    let globalData = [];
    let selectedRowsResData = [];
    function plotResourceGrid(data, GlobalResProjectEnddt) {
        let SubmittedResDataCount = 0;
        //
        selectedRowsResData = [];
        globalData = data;
       //Commented and added by Vishal Mane on 24/03/2026 to fix UI Disturbance Issue
        //var thead = `
        //        <tr>
        //            <th style="width: 100px;">Project Name</th>
        //            <!-- <th style="width: 100px;">CBU</th> -->
        //            <th style="width: 100px;">Resource Name</th>
        //            <th style="width: 100px;">Role</th>
        //            <!-- <th style="width: 100px;">Designation</th> -->
        //            <!--<th style="width: 100px;">Resource Site</th> -->
        //            <th style="width: 100px;">% Allocation</th>
        //            <th style="width: 100px;">Planned start Date</th>
        //            <th style="width: 100px;">Planned end Date</th>
        //            <th style="min-width: 200px;">Revised End Date</th>
        //            <th style="width: 100px;">Current Status</th>
        //            <th class="">History</th>
        //            <th class=""></th>
        //            <th class=" ">
        //                <div class="custom_chckbox">
        //                    <input id="ResourceCheckAll" class="chckHead" type="checkbox" onchange="toggleAllRowsSelection(this)">
        //                    <label for="ResourceCheckAll"></label>
        //                </div>
        //            </th>
        //        </tr>`;
        var thead = `
                <tr>
                    <th class="res-th-project">Project Name</th>
                    <!-- <th style="width: 100px;">CBU</th> -->
                    <th class="res-th-resource">Resource Name</th>
                    <th class="res-th-role">Role</th>
                    <!-- <th style="width: 100px;">Designation</th> -->
                    <!--<th style="width: 100px;">Resource Site</th> -->
                    <th class="res-th-allocation">% Allocation</th>
                    <th class="res-th-start">Planned start Date</th>
                    <th class="res-th-end">Planned end Date</th>
                    <th class="res-th-revised-end">Revised End Date</th>
                    <th class="res-th-status">Current Status</th>
                    <th class="">History</th>
                    <th class=""></th>
                    <th class=" ">
                        <div class="custom_chckbox">
                            <input id="ResourceCheckAll" class="chckHead" type="checkbox" onchange="toggleAllRowsSelection(this)">
                            <label for="ResourceCheckAll"></label>
                        </div>
                    </th>
                </tr>`;
        //End of Commented and added by Vishal Mane on 24/03/2026 to fix UI Disturbance Issue

        var tbody = ``;
        data.forEach((data, index) => {

            let fullProjectName = data.ProjectName;
            let shortProjectName = fullProjectName.length > 20 ? fullProjectName.substring(0, 20) + "..." : fullProjectName;

            if (data.ApprovalStatus == 'Submitted') {
                SubmittedResDataCount = SubmittedResDataCount + 1;
                tbody += `<tr data-index="${index}">
                                     <td class="bg_blue truncate-text" id="${data.ProjectID}" data-bs-toggle="tooltip" title="${fullProjectName}">${shortProjectName}</td>
                                     <!--<td class=" bg_blue">${data.CBU}</td> -->
                                     ${/*<td class=" bg_blue">${data.ResourceName}*/''}
                                     ${data.SystemFilename != null ? `    
                                     <td class=" bg_blue"><img src="${data.SystemFilename}" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`
                        : `<td class=" bg_blue"><img src="../../../Whizible2.0-new/dist/img/blankprofile.png" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`}
                                     </td>
                                     <td class=" bg_blue">${data.Role ?? ''}</td>
                                     <!-- <td class=" bg_blue">${data.DesignationName}</td> -->
                                     <!--<td class=" bg_blue">${data.ResourceSite}</td> -->
                                     <td class=" bg_blue">${data.ResourcePercentage}%</td>
                                     <td class=" bg_blue" id="planStartDate_${index}">${data.ExpectedStartDate}</td>
                                     <td class=" bg_blue" disabled>${data.ExpectedEndDate}</td>
                                     <td class=" bg_blue">
                                         <div class="input-group">
                                             <input data-status="Submitted" id="td_newEndDate${index}" data-bs-toggle="tooltip" title="${data.NewResourceEnddate}" class="form-control newEndDate date-picker" value="${data.NewResourceEnddate}" disabled>
                                             <span class="input-group-btn" for="td_newEndDate${index}">
                                                 <button class="btn btncalendar" type="button" for="td_newEndDate${index}">
                                                     <i class="fas fa-calendar-alt"></i>
                                                 </button>
                                             </span>
                                         </div>
                                      </td>
                                     <td class=" bg_blue">
                                      ${data.ApprovalStatus != "" ? `    
                                     <div class="statusDiv d-flex justify-content-center">
                                         <span class="statusBox statusSubmitted me-2" data-bs-toggle="tooltip"
                                               title="Submitted">&nbsp;</span>
                                         <a href="javascript:;" >
                                             <label class="crsrLink">${data.ApprovalStatus}</label>
                                         </a>
                                     </div>` : ''}
                                     
                                     </td>
                                     <td class=" bg_blue">
                                      ${data.HistoryFlag != "0" ? `
                                      <span data-bs-toggle="offcanvas" data-bs-target="#ShowResHisDetailpanel">
                                      <i class="fas fa-history Card_View_whiz  txt_hover" data-bs-toggle="tooltip" title="Show History" onclick='ShowResHistory(${data.ProjectEmployeeRoleID}); ShowResourceApprovalHistory(${data.ProjectEmployeeRoleID})'></i>
                                      </span>`: ''}
                                     </td>

                                     <td class=" bg_blue">
                                     </td>
                                     <td class=" bg_blue">
                                         <div class="d-flex justify-content-center">
                                         <div class="custom_chckbox blocked">
                                             <input id="Reso_bulExtensionCheck${index}"  value="${data.ReqID}" class="chcktbl reversalMain " type="checkbox" disabled>
                                             <label for="Reso_bulExtensionCheck${index}"></label><input type="hidden" id="hdn${index + 1}" value="${data.StatusId}">
                                         </div>
                                     </div>
                                     </td>
                                 </tr>`;
            }
            else if (data.ResStatus.trim() == 'R') {
                const statusClass =
                    data.ApprovalStatus === 'Submitted' ? 'statusSubmitted' :
                        data.ApprovalStatus === 'Rejected' ? 'statusRejected' :
                            data.ApprovalStatus === 'Approved' ? 'statusApproved' : '';

                //if (data.ApprovalStatus == "Approved" && (data.RequestType == 'P' || data.RequestType == 'C')) {
                if (data.RequestType == 'P' || data.RequestType == 'C') {
                    tbody += `<tr data-index="${index}">
                            <td class="bg_lightVoilet truncate-text" id="${data.ProjectID}" data-bs-toggle="tooltip" title="${fullProjectName}">${shortProjectName}</td>
                            <!--<td class=" bg_lightVoilet">${data.CBU}</td>-->
                            ${/*<td class=" bg_lightVoilet">${data.ResourceName}*/''}
                            ${data.SystemFilename != null ? `    
                            <td class=" bg_lightVoilet"><img src="${data.SystemFilename}" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`
                            : `<td class=" bg_lightVoilet"><img src="../../../Whizible2.0-new/dist/img/blankprofile.png" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`}
                                     </td>
                                     <td class=" bg_lightVoilet">${data.Role ?? ''}</td>
                                     <!--<td class=" bg_lightVoilet">${data.DesignationName}</td>-->
                                     <!--<td class=" bg_lightVoilet">${data.ResourceSite}</td>-->
                                     <td class=" bg_lightVoilet">${data.ResourcePercentage}%</td>
                                     <td class=" bg_lightVoilet" id="planStartDate_${index}">${data.ExpectedStartDate}</td>
                                     <td class=" bg_lightVoilet" disabled>${data.ExpectedEndDate}</td>
                                     <td class=" bg_lightVoilet">
                                         <div class="input-group">
                                             <input data-status="Editable" id="td_newEndDate${index}" class="form-control newEndDate date-picker" data-bs-toggle="tooltip" title="${GlobalResProjectEnddt}" value="${GlobalResProjectEnddt}" disabled>
                                             <span class="input-group-btn" for="td_newEndDate${index}">
                                                 <button class="btn btncalendar" type="button" for="td_newEndDate${index}">
                                                     <i class="fas fa-calendar-alt"></i>
                                                 </button>
                                             </span>
                                         </div>
                                      </td>
                                     <!--<td class=" bg_lightVoilet">
                                     ${data.ApprovalStatus != "" ? `
                                        <div class="statusDiv d-flex justify-content-center">
                                        <span class="statusBox statusApproved me-2" data-bs-toggle="tooltip"
                                               title="Approved">&nbsp;</span>
                                         <a href="javascript:;" >
                                            <label class="crsrLink">${data.ApprovalStatus}</label>
                                         </a>
                                     </div>` : ''}
                                     </td>-->
                                    <td class="bg_lightVoilet">
                                        ${data.ApprovalStatus != "" ? `
                                            <div class="statusDiv d-flex justify-content-center">
                                                <span class="statusBox ${statusClass} me-2"
                                                        data-bs-toggle="tooltip"
                                                        title="${data.ApprovalStatus}">&nbsp;</span>
                                                <a href="javascript:;">
                                                    <label class="crsrLink">${data.ApprovalStatus}</label>
                                                </a>
                                            </div>` : ''}
                                    </td>

                                     <td class=" bg_lightVoilet">
                                    ${data.HistoryFlag != "0" ? `
                                      <span data-bs-toggle="offcanvas" data-bs-target="#ShowResHisDetailpanel">
                                      <i class="fas fa-history Card_View_whiz  txt_hover" data-bs-toggle="tooltip" title="Show History" onclick='ShowResHistory(${data.ProjectEmployeeRoleID}); ShowResourceApprovalHistory(${data.ProjectEmployeeRoleID})'></i>
                                      </span>`: ''}
                                                                                 </td>
                                    
                                                                                 <td class=" bg_lightVoilet">
                                                                                 <span data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen">
                                         <i class="fas fa-info-circle Card_View_whiz clearedStage1 txt_hover" data-bs-toggle="tooltip" title="More Details" onclick='ShowResoReq(${data.ProjectID},${data.ProjectEmployeeRoleID})'></i>
                                     </span>
                                     </td>
                                     <td class=" bg_lightVoilet">
                                         <div class="d-flex justify-content-center">
                                         <div class="custom_chckbox blocked">
                                             <input id="Reso_bulExtensionCheck${index}"  value="${data.ReqID}" class="chcktbl reversalMain " type="checkbox" disabled>
                                             <label for="Reso_bulExtensionCheck${index}"></label><input type="hidden" id="hdn${index + 1}" value="${data.StatusId}">
                                         </div>
                                     </div>
                                     </td>
                                 </tr>`;
                }
                else {
                    tbody += `<tr data-index="${index}">
                                                                 <td class="bg_lightRed truncate-text" id="${data.ProjectID}" data-bs-toggle="tooltip" title="${fullProjectName}">${shortProjectName}</td>
                                                                 <!--<td class=" bg_lightRed">${data.CBU}</td>-->
                                                                  ${/*<td class=" bg_lightRed">${data.ResourceName}*/''}
                                                                 ${data.SystemFilename != null ? `    
                                                                 <td class=" bg_lightRed"><img src="${data.SystemFilename}" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`
                            : `<td class=" bg_lightRed"><img src="../../../Whizible2.0-new/dist/img/blankprofile.png" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`}
                                     </td>
                                     <td class=" bg_lightRed">${data.Role ?? ''}</td>
                                     <!--<td class=" bg_lightRed">${data.DesignationName}</td>-->
                                     <!--<td class=" bg_lightRed">${data.ResourceSite}</td>-->
                                     <td class=" bg_lightRed">${data.ResourcePercentage}%</td>
                                     <td class=" bg_lightRed" id="planStartDate_${index}">${data.ExpectedStartDate}</td>
                                     <td class=" bg_lightRed" disabled>${data.ExpectedEndDate}</td>
                                     <td class=" bg_lightRed">
                                         <div class="input-group">
                                             <input data-status="Editable" id="td_newEndDate${index}" class="form-control newEndDate date-picker" data-bs-toggle="tooltip" title="${GlobalResProjectEnddt}" value="${GlobalResProjectEnddt}" disabled>
                                             <span class="input-group-btn" for="td_newEndDate${index}">
                                                 <button class="btn btncalendar" type="button" for="td_newEndDate${index}">
                                                     <i class="fas fa-calendar-alt"></i>
                                                 </button>
                                             </span>
                                         </div>
                                      </td>
                                     <!--<td class=" bg_lightRed">
                                     ${data.ApprovalStatus != "" ? `
                                        <div class="statusDiv d-flex justify-content-center">
                                        <span class="statusBox statusSubmitted me-2" data-bs-toggle="tooltip"
                                               title="Submitted">&nbsp;</span>
                                         <a href="javascript:;" >
                                            <label class="crsrLink">${data.ApprovalStatus}</label>
                                         </a>
                                     </div>` : ''}
                                     </td>-->
                                    <td class="bg_lightRed">
                                        ${data.ApprovalStatus != "" ? `
                                            <div class="statusDiv d-flex justify-content-center">
                                                <span class="statusBox ${statusClass} me-2"
                                                        data-bs-toggle="tooltip"
                                                        title="${data.ApprovalStatus}">&nbsp;</span>
                                                <a href="javascript:;">
                                                    <label class="crsrLink">${data.ApprovalStatus}</label>
                                                </a>
                                            </div>` : ''}
                                    </td>
                                     <td class=" bg_lightRed">
                                    ${data.HistoryFlag != "0" ? `
                                      <span data-bs-toggle="offcanvas" data-bs-target="#ShowResHisDetailpanel">
                                      <i class="fas fa-history Card_View_whiz  txt_hover" data-bs-toggle="tooltip" title="Show History" onclick='ShowResHistory(${data.ProjectEmployeeRoleID}); ShowResourceApprovalHistory(${data.ProjectEmployeeRoleID})'></i>
                                      </span>`: ''}
                                                                                 </td>
                                    
                                                                                 <td class=" bg_lightRed">
                                                                                 <span data-bs-toggle="offcanvas" data-bs-target="#moredetails_OffcvsScreen">
                                         <i class="fas fa-info-circle Card_View_whiz clearedStage1 txt_hover" data-bs-toggle="tooltip" title="More Details" onclick='ShowResoReq(${data.ProjectID},${data.ProjectEmployeeRoleID})'></i>
                                     </span>
                                     </td>
                                     <td class=" bg_lightRed">
                                         <div class="d-flex justify-content-center">
                                         <div class="custom_chckbox blocked">
                                             <input id="Reso_bulExtensionCheck${index}"  value="${data.ReqID}" class="chcktbl reversalMain " type="checkbox" disabled>
                                             <label for="Reso_bulExtensionCheck${index}"></label><input type="hidden" id="hdn${index + 1}" value="${data.StatusId}">
                                         </div>
                                     </div>
                                     </td>
                                 </tr>`;
                }              
                
            }

            else {
                tbody += `  <tr data-index="${index}">
                           <td class=" truncate-text" id="${data.ProjectID}" data-bs-toggle="tooltip" title="${fullProjectName}">${shortProjectName}</td>
                           <!--<td class="">${data.CBU}</td> -->
                          ${/*<td class="">${data.ResourceName}*/''}
                         ${data.SystemFilename != null ? `
                         <td class=""><img src="${data.SystemFilename}" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`
                        : `<td class=""><img src="../../../Whizible2.0-new/dist/img/blankprofile.png" class="CardViewIniImg mx-auto" alt=""><br>${data.ResourceName}`}
                         </td>
                           <td class="">${data.Role ?? ''}</td>
                           <!--<td class="">${data.DesignationName}</td> -->
                           <!--<td class="">${data.ResourceSite}</td> -->
                           <td class="">${data.ResourcePercentage}%</td>
                           <td id="planStartDate_${index}" class="">${data.ExpectedStartDate}</td>
                           <td class="" id="planEndDate_${index}">${data.ExpectedEndDate}</td>
                           <td class=" ">
                               <div class="input-group">
                                   <input data-status="Editable" id="td_newEndDate${index}" class="form-control newEndDate date-picker" value="${GlobalResProjectEnddt}" data-bs-toggle="tooltip" title="${GlobalResProjectEnddt}" onchange="validateResNewEndDate('${data.TentativeDateOfRelieving}',${index},this,'${data.ExpectedStartDate}','${data.ExpectedEndDate}','${data.ApprovalStatus}')">
                                   <span class="input-group-btn" for="td_newEndDate${index}">
                                       <button class="btn btncalendar" type="button" for="td_newEndDate${index}">
                                           <i class="fas fa-calendar-alt"></i>
                                       </button>
                                   </span>
                               </div>
                            </td>
                           <td id="approvalStatus_${index}" class="">
                             ${data.ApprovalStatus != "" ? `
                                 <div class="statusDiv d-flex justify-content-center">
                                     <span class="statusBox ${data.ApprovalStatus == "Rejected" ? "statusRejected" : "statusApproved"} me-2"
                                           data-bs-toggle="tooltip"
                                           title="${data.ApprovalStatus}">&nbsp;</span>
                                     <a href="javascript:;">
                                         <label class="crsrLink">${data.ApprovalStatus}</label>
                                     </a>
                                 </div>` : ''}
                                                               </td>

                                                                         <td>
                                                                          ${data.HistoryFlag != "0" ? `
                              <span data-bs-toggle="offcanvas" data-bs-target="#ShowResHisDetailpanel">
                              <i class="fas fa-history Card_View_whiz  txt_hover" data-bs-toggle="tooltip" title="Show History" onclick='ShowResHistory(${data.ProjectEmployeeRoleID}); ShowResourceApprovalHistory(${data.ProjectEmployeeRoleID})'></i>
                              </span>`: ''}
                                     </td>

                                     <td>

                                     </td>
                           <td class="">
                               <div class="custom_chckbox justify-content-center">
                                  ${ /* <input id="Reso_bulExtensionCheck${index}"   value="${data.ReqID}" class="chcktbl ResourceMain" type="checkbox" onchange="toggleRowResSelection(this, ${index})">*/``}
                                   <input id="Reso_bulExtensionCheck${index}"   value="${data.ReqID}" class="chcktbl ResourceMain" type="checkbox" >
                                   <label for="Reso_bulExtensionCheck${index}"></label><input type="hidden" id="hdn${index + 1}" value="${data.StatusId}">


                                         </div>
                           </td>
             </tr>`;

            }
        })
        //  tbody += `</tbody>`;
        var tableid = $("#Res_BulkExtensionTbl");
        var tableHeadid = $("#Res_BulkExtensionTbl thead");
        var tabletbodyid = $("#Res_BulkExtensionTbl tbody");
        //thead, tbody
        //tableid.empty();
        tableHeadid.html("");
        $("#Res_BulkExtensionTblBody").html("");
        //tableid.append(thead);
        //tableid.append(tbody);
        //$("#Res_BulkExtensionTbl").dataTable().fnDestroy();
        tableHeadid.html(thead);

        if ($.fn.DataTable.isDataTable('#Res_BulkExtensionTbl')) {
            $('#Res_BulkExtensionTbl').DataTable().clear().destroy();
        }
        $("#Res_BulkExtensionTblBody").html(tbody);
        $('[data-bs-toggle="tooltip"]').tooltip();
        $(".selectpicker").selectpicker('refresh');
        //gblResourceTbl = $('#Res_BulkExtensionTbl').DataTable({
        //    // "scrollY": true,
        //    // "scrollX": true,
        //    "paging": true,
        //    "pageLength": 10,
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
        gblResourceTbl = $('#Res_BulkExtensionTbl').DataTable({
            "scrollY": false,
            "scrollX": false,
            "scrollCollapse": false,
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false,
            "destroy": true,
            "retrieve": false,
            "bFilter": false,
            "bAutoWidth": true,
            "ordering": false,
            "info": true,
            pagingType: "simple",
            language: {
                info: "Total Records: _TOTAL_",
                infoEmpty: "Total Records: 0",
                paginate: {
                    previous: "<<",
                    next: ">>"
                }
            },
            "initComplete": function () {
                this.api().columns.adjust();
            },
            "drawCallback": function () {
                this.api().columns.adjust();
                alignAllDataTableFootersRight();
            }
        });
        alignAllDataTableFootersRight();

        /* $('#Res_BulkExtensionTbl').wrap('<div class="dataTables_scroll" />');*/
        var ResPaginationCountElement = $("#ResTotalRecords");
        var container = $("#divResSubmittedRecords");
        ResPaginationCountElement.empty();
        if (data.length != 0) {
            ResPaginationCountElement.append(`Total Submitted Records: ${SubmittedResDataCount}`);
            container.addClass("highlight-box");
        } else {
            // 👉 Remove highlight if no data
            container.removeClass("highlight-box");
        }

        // Project list View Check or Uncheck All checkboxes
        $("#PM_BulkExtensionCheckAll").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".reversalMain").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".reversalMain").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Project list View of CheckAll checkbox
        $(".reversalMain").click(function () {
            if ($(".reversalMain").length === $(".reversalMain:checked").length) {
                $("#PM_BulkExtensionCheckAll").prop("checked", true);
            } else {
                $("#PM_BulkExtensionCheckAll").prop("checked", false);
            }
        });
        // Resource list View Check or Uncheck All checkboxes
        $("#ResourceCheckAll").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".ResourceMain").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".ResourceMain").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Resource list View of CheckAll checkbox
        $(".ResourceMain").click(function () {
            if ($(".ResourceMain").length === $(".ResourceMain:checked").length) {
                $("#ResourceCheckAll").prop("checked", true);
            } else {
                $("#ResourceCheckAll").prop("checked", false);
            }
        });

        $('#Res_BulkExtensionTbl').on('page.dt', function () {
            $("#ResourceCheckAll").prop("checked", false);
            $(".ResourceMain").prop("checked", false);
        });
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        //datepicker
        //$('#newEndDate, #Resource_newEndDate, #updateNew_Date, #effective_Date, #td_ProjnewEndDate1, #td_ProjnewEndDate2, #td_ProjnewEndDate3, #td_ProjnewEndDate4, #td_ProjnewEndDate5, #td_ProjnewEndDate6, #td_newEndDate1, #td_newEndDate2, #td_newEndDate3').datepicker({
        //    autoclose: true,
        //    changeMonth: true,
        //    changeYear: true,
        //    dateFormat: 'yy-mm-dd'
        //});

        //$('#newEndDate, #Resource_newEndDate, #updateNew_Date, #effective_Date, #td_ProjnewEndDate1, #td_ProjnewEndDate2, #td_ProjnewEndDate3, #td_ProjnewEndDate4, #td_ProjnewEndDate5, #td_ProjnewEndDate6, #td_newEndDate1, #td_newEndDate2, #td_newEndDate3').datepicker({
        //    autoclose: true,
        //    changeMonth: true,
        //    changeYear: true,
        //    dateFormat: 'yy-mm-dd'
        //});
    }




    function validateResNewEndDate(resourceTentativeLeavingDate, index, input, ExpectedStartDate, ExpectedEndDate, CurrentStatus) {
        var newResDate = $('#updateNew_Date').val();
        if (new Date(input.value) == "") {
            /* var selectedDate = new Date($("#td_newEndDate" + index).val());*/
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(`Revised End Date should not be left blank`);
            input.value = newResDate; // Clear the invalid input
            return;
        }
        if (new Date(input.value) < new Date(ExpectedEndDate)) {
            alertify.set('notifier', 'position', 'top-right');
            //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
            alertify.error(`Resource extension date should be greater than resource end date.`);
            input.value = newResDate;
            return;
        }
        if (new Date(input.value) < new Date(GlobalResProjectStartdt)) {
            alertify.set('notifier', 'position', 'top-right');
            //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
            alertify.error(`Resource extension date should be greater than project start date ${ResProjectStartdt}`);
            input.value = newResDate;
            return;
        }


        if (new Date(input.value) > new Date(GlobalResProjectEnddt)) {
            alertify.set('notifier', 'position', 'top-right');
            //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
            alertify.error(`Resource extension date should be less than project end date ${GlobalResProjectEnddt}`);
            input.value = newResDate;
            return;
        }

        if (resourceTentativeLeavingDate) {
            var TentativeLeavingDate = new Date(resourceTentativeLeavingDate);


            if (new Date(input.value) > TentativeLeavingDate) {

                //const projectName = $(`#Res_BulkExtensionTbl #projectName_${rowIndex - 1}`).text(); // Get the Project Name
                const rowData = globalData[index];
                const projectName = rowData.ProjectName; // Get the Project Name
                const resourceName = rowData.ResourceName; // Get the Resource Name
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
                alertify.error(`Resource (${resourceName}) extension date is greater than tentative leaving date ${resourceTentativeLeavingDate}`);
                input.value = resourceTentativeLeavingDate; // Clear the invalid input
                // return
            }
        }
    }


    function submitBulkExtensionApproval() {
        //
        if ($('#newEndDate').val() == '') {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Please Select a Revised End Date");
            return;
        }

        if (selectedRows.length === 0) {
            alertify.set('notifier', 'position', 'top-right');
            //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
            //alertify.error("No rows selected.");
            alertify.error("Please select at least one row.");
            //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
            return;
        }
        //Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        //if ($(`#ProjectApprovalRemark`).val() == '') {
        if ($(`#ProjectApprovalRemark_WF`).val() == '') {
            alertify.set('notifier', 'position', 'top-right')
            //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert    ;
            //alertify.error("Please write a comment");
            alertify.error("Comment should not be left blank");
            //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
            return;
        }
        const jsonData = selectedRows.map(row => ({
            ProjectID: parseInt(row.ProjectID),
            ProjectValue: parseInt(row.ProjectValue.replaceAll(",", "")),
            ProjectNewEffort: parseInt(row.ProjectNewEffort.replaceAll(",", "")),
            ProjectStatus: (row.ProjectStatus),
            NewEndDate: row.NewEndDate,
            ApprovalStatus: "Submitted",
            //Added & Commented by Ajit L on 4th July 2025 for string break issue
            // SubmitterRemark: $(`#ProjectApprovalRemark`).val(),
            SubmitterRemark: $(`#ProjectApprovalRemark`).val().replaceAll("'", "''"),
            //End of Added & Commented by Ajit L on 4th July 2025 for string break issue
            SubmittedBy: UserID,
            //RequestId: row.RequestId,
            RequestId: (row.RequestId === "null" || row.RequestId === null) ? 0 : row.RequestId,
            IsResubmit: row.IsResubmit,
        }));
        // Make AJAX call to the backend
        //$.ajax({
        //    url: '/api/ProjectExtension/BulkApproval',
        //    type: 'POST',
        //    contentType: 'application/json',
        //    data: JSON.stringify(jsonData),
        //    success: function (response) {
        //        alert("Success: " + response);
        //    },
        //    error: function (xhr, status, error) {
        //        alert("Error: " + (xhr.responseText || status));
        //    }
        //});
        var param = JSON.stringify(jsonData);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/InsertProjectExtensionRequest", param, false);
        if (strResult) {
            alertify.set('notifier', 'position', 'top-right');
            //Commented and Added By Riddhesh Patil on 28 jan 2025 for alert rephrase issue
            //alertify.success("Inserted Successfully");
            /*alertify.success("Project extension request sent for approval");*/
            alertify.success("Selected records have been sent for approval.");
            //End of Commented and Added By Riddhesh Patil on 28 jan 2025 for alert rephrase issue
            //NextList();
            PlotProjectGrid(GlobalcontractID, ValidateionGlobalContractEndDate, 1);
            //GetContractData(GlobalcontractID);
            var ProjPaginationCountElement = $("#ProjSubmittedTotalRecords");            
            ProjPaginationCountElement.empty();
            ProjPaginationCountElement.append(`Total Submitted Records: ${SubmittedProjCount}`);
            //var container = $("#divPrjSubmittedRecords");
            //container.addClass("highlight-box");
            var parameters = {
                UserID: UserID,
                ApproverRoles: ApproverRoleList
            }
            var param = JSON.stringify(parameters);
            var strResult = AJAXCallWithResult_SilentMail("/api/PM_Bulk_Extension/SilentMailWorkFowSubmision", param, false);
            //End of Added by Vishal Mane on 09/02/2026 to send Session EmployeeID for silent mail 
            
            //Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
            //$("#ApprovalCommentModal").modal('hide');
            var offcanvasEl = document.getElementById('sendforApproval_OffcvsScreen');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.hide();
            //End of Commented and Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
        }


    }






    //function saveSelectedResRows() {
    //    //
    //    var NotificationMsg = 0;
    //    var IsValidation = 0;
    //    const minimalData = selectedRowsResData.map(row => ({
    //        ProjectEmployeeRoleID: row.ProjectEmployeeRoleID,
    //        ResourceNewEndDate: row.ResourceNewEndDate,
    //        EffectiveFromDate: row.EffectiveFromDate,
    //        ApprovalStatus: "Submitted",
    //        SubmitterComments: $(`#ProjectApprovalRemark`).val()
    //    }));

    //    if ($('#updateNew_Date').val() == '') {
    //        alertify.set('notifier', 'position', 'top-right');
    //        alertify.error("Please Select a Revised End Date");
    //        return;
    //    }

    //    //if ($('#effective_Date').val() == '') {
    //    //    alertify.set('notifier', 'position', 'top-right');
    //    //    alertify.error("Please Select a Resource New Effective End Date");
    //    //    return;
    //    //}

    //    if (minimalData.length === 0) {
    //        alertify.set('notifier', 'position', 'top-right');
    //        //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
    //        //alertify.error("No rows selected.");
    //        alertify.error("Please select at least one row.");
    //        //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
    //        return;
    //    }

    //    if ($(`#ProjectApprovalRemark`).val() == '') {
    //        alertify.set('notifier', 'position', 'top-right');
    //        //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
    //        //alertify.error("Please write a comment");
    //        alertify.error("Comment should not be left blank");
    //        //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
    //        return;
    //    }

    //    var param = JSON.stringify(minimalData);
    //    var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/InsertProjectEmployeeRole", param, false);

    //    //if (strResult) {
    //    //    alert("Data inserted successfully!");
    //    //    console.log("Success response:", strResult);

    //    //    // Perform additional actions, e.g., refreshing the table or clearing inputs
    //    //    //refreshTable();
    //    //} else {
    //    //    alert("Failed to insert data. Please try again.");
    //    //}


    //    if (strResult) {

    //        try {
    //            var response = strResult;

    //            // Check if the response contains a success message
    //            if (response.message === "Data inserted successfully.") {
    //                alertify.set('notifier', 'position', 'top-right');
    //                //(`You can select a maximum of ${MAX_SELECTION} rows.`);
    //                //Added & Commented by Ajit L on 27/01/2025
    //               // alertify.success("Data inserted successfully!");
    //                alertify.success("Resource extension request sent for approval.");
    //                 //End of Added & Commented by Ajit L on 27/01/2025
    //                //Commented and Added By Riddhesh Patil on 03 March 2025 for Email Notification
    //                //window.open('../Email/SendEmail.aspx?MessageID=35013', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
    //                window.open('../Email/SendEmail.aspx?MessageID=35016', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
    //                //End of Commented and Added By Riddhesh Patil on 03 March 2025 for Email Notification
    //                //console.log("Success response:", response);

    //                // Perform additional actions, e.g., refreshing the table or clearing inputs
    //                // refreshTable();
    //            }
    //            // Check for duplicates
    //            else if (response.message === "Some records already exist.") {
    //                alertify.set('notifier', 'position', 'top-right');
    //                //(`You can select a maximum of ${MAX_SELECTION} rows.`);
    //                alertify.error("Some records already exist.");
    //                //console.log("Duplicate records:", response);
    //            }
    //            else {
    //                alertify.set('notifier', 'position', 'top-right');
    //                //(`You can select a maximum of ${MAX_SELECTION} rows.`);
    //                alertify.error("Failed to insert data. Please try again.");
    //                //console.log("Error response:", response);
    //            }
    //        } catch (e) {
    //            console.error("Error parsing response:", e);
    //            //alert("An error occurred while processing the response.");
    //        }
    //    } else {
    //        console.error("Failed to insert data. Please try again.");
    //    }


    //}
    function formatDate(inputDate) {
        if (!inputDate) return ""; // Handle empty values


        //let date = new Date(inputDate); // Convert to Date object

        //// Extract the date part (YYYY-MM-DD)
        //return date.toISOString().split("T")[0];

        let date = new Date(inputDate);
        let year = date.getFullYear();
        //let month = (date.getMonth() + 1).toString().padStart(2, '0'); // Month is 0-indexed

        const monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        const month = monthNames[date.getMonth()];

        let day = date.getDate().toString().padStart(2, '0');

        //return `${year}-${month}-${day}`; // Local date format
        return `${day} ${month} ${year}`; // Local date format


    }
    function saveSelectedResRows() {
        //

        var NotificationMsg = 0;
        var IsValidation = 0;
        const minimalData = selectedRowsResData.map(row => ({
            ProjectEmployeeRoleID: row.ProjectEmployeeRoleID,
            ResourceNewEndDate: row.ResourceNewEndDate,
            EffectiveFromDate: row.EffectiveFromDate,
            ApprovalStatus: "Submitted",
            SubmitterComments: $(`#ProjectApprovalRemark`).val(),
            RequestId: row.RequestId,
            IsResubmit: row.IsResubmit,
            TentativeDateOfRelieving: row.TentativeDateOfRelieving,
            ResourceName: row.ResourceName,
            ExpectedEndDate: row.ExpectedEndDate
        }));

        for (var i = 0; i < minimalData.length; i++) {
            const resourceName = minimalData[i].ResourceName; // Get the Resource Name
            const ResProjectStartdt = formatDate(GlobalResProjectStartdt);
            const ResProjectEnddt = formatDate(GlobalResProjectEnddt);
            if (minimalData[i].TentativeDateOfRelieving != "" && new Date(minimalData[i].ResourceNewEndDate) > new Date(minimalData[i].TentativeDateOfRelieving)) {
                const TentDate = formatDate(minimalData[i].TentativeDateOfRelieving);
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
                alertify.error(`Resource (${resourceName}) extension date is greater than tentative leaving date ${TentDate}`);
                return;
            }
            else if (new Date(minimalData[i].ResourceNewEndDate) < new Date(GlobalResProjectStartdt)) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
                alertify.error(`Resource (${resourceName}) extension date should be greater than project start date ${ResProjectStartdt}`);
                return;
            }
            else if (new Date(minimalData[i].ResourceNewEndDate) > new Date(GlobalResProjectEnddt)) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
                alertify.error(`Resource (${resourceName}) extension date should be less than project end date ${ResProjectEnddt}`);
                return;
            }
            else if (new Date(minimalData[i].ResourceNewEndDate) < new Date(minimalData[i].ExpectedEndDate)) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error(`The ${selectedDate} is greater than Resource ${resourceName} Tentative Leaving date `);
                alertify.error(`Resource (${resourceName}) extension date should be greater than resource end date.`);
                input.value = newResDate;
                return;
            }

            //alert(GlobalResProjectStartdt);
            //alert(GlobalResProjectEnddt);
        }



        if ($('#updateNew_Date').val() == '') {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Please Select a Revised End Date");
            return;
        }

        //if ($('#effective_Date').val() == '') {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.error("Please Select a Resource New Effective End Date");
        //    return;
        //}

        if (minimalData.length === 0) {
            alertify.set('notifier', 'position', 'top-right');
            //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
            //alertify.error("No rows selected.");
            alertify.error("Please select at least one row.");
            //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
            return;
        }

        if ($(`#ProjectApprovalRemark`).val() == '') {
            alertify.set('notifier', 'position', 'top-right');
            //Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
            //alertify.error("Please write a comment");
            alertify.error("Comment should not be left blank");
            //End of Commented & Added By Dipali V On 3rd March 2025 For Rephrase Alert
            return;
        }

        //Added By Dipali V On 3rd March 2025 For Check Resource Allocation
        //
        for (var i = 0; i < selectedRowsResData.length; i++) {
            var ProjectdataParameter = {
                ProjectEmployeeRoleID: selectedRowsResData[i].ProjectEmployeeRoleID,
                //ResourceNewEndDate: $("#td_newEndDate" + [i]).val(),
                ResourceNewEndDate: selectedRowsResData[i].ResourceNewEndDate,
                //ExpectedStartDate: selectedRowsResData[i].ResourceStartDate,
                ExpectedStartDate: formatDate(selectedRowsResData[i].ResourceStartDate),

                // TentativeDateOfRelieving: selectedRowsResData[i].TentativeDateOfRelieving
                TentativeDateOfRelieving: '',
                RequestId: selectedRowsResData[i].RequestId,
                IsResubmit: selectedRowsResData[i].IsResubmit
            }

            var param = JSON.stringify(ProjectdataParameter);
            var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/CheckResourceAllocations", param, false);
            strResult.forEach(function (Data) {
                if (Data.alertType !== 0) {
                    IsValidation = 1;
                    if (Data.alertType === 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(Data.MSG);
                        return;
                    }
                    else if (Data.alertType === 2) {
                        $("#ApprovalCommentModal").on('hidden.bs.modal', function () {
                            $("#ValidationModal").modal('show');
                        }).modal('hide');
                        $("#MsgDate").text(Data.MSG);
                        NotificationMsg = 1;
                        //return;
                    }

                }
            })

        }

        if (IsValidation == 0) {
            AllowtoSubmit(1);
            $("#ApprovalCommentModal").modal('hide');
            var currentPage = gblResourceTbl.page();

            ShowGridWithFilter();
            // Get total number of pages
            var totalPages = gblResourceTbl.page.info().pages;

            // Move to the next page only if it's not the last one
            if (currentPage + 1 < totalPages) {
                gblResourceTbl.page(currentPage + 1).draw(false);
            }


        }
        //End of Added By Dipali V On 3rd March 2025 For Check Resource Allocation


        //var param = JSON.stringify(minimalData);
        //var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/InsertProjectEmployeeRole", param, false);

        //if (strResult) {

        //    try {
        //        var response = strResult;

        //        // Check if the response contains a success message
        //        if (response.message === "Data inserted successfully.") {
        //            alertify.set('notifier', 'position', 'top-right');
        //            //(`You can select a maximum of ${MAX_SELECTION} rows.`);
        //            //Added & Commented by Ajit L on 27/01/2025
        //           // alertify.success("Data inserted successfully!");
        //            alertify.success("Resource extension request sent for approval.");
        //             //End of Added & Commented by Ajit L on 27/01/2025
        //            //Commented and Added By Riddhesh Patil on 03 March 2025 for Email Notification
        //            //window.open('../Email/SendEmail.aspx?MessageID=35013', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
        //            window.open('../Email/SendEmail.aspx?MessageID=35016', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
        //            //End of Commented and Added By Riddhesh Patil on 03 March 2025 for Email Notification
        //            //console.log("Success response:", response);

        //            // Perform additional actions, e.g., refreshing the table or clearing inputs
        //            // refreshTable();
        //        }
        //        // Check for duplicates
        //        else if (response.message === "Some records already exist.") {
        //            alertify.set('notifier', 'position', 'top-right');
        //            //(`You can select a maximum of ${MAX_SELECTION} rows.`);
        //            alertify.error("Some records already exist.");
        //            //console.log("Duplicate records:", response);
        //        }
        //        else {
        //            alertify.set('notifier', 'position', 'top-right');
        //            //(`You can select a maximum of ${MAX_SELECTION} rows.`);
        //            alertify.error("Failed to insert data. Please try again.");
        //            //console.log("Error response:", response);
        //        }
        //    } catch (e) {
        //        console.error("Error parsing response:", e);
        //        //alert("An error occurred while processing the response.");
        //    }
        //} else {
        //    console.error("Failed to insert data. Please try again.");
        //}


    }



    //Added By Dipali V On 3rd March 2025 For  Check TentativeDateOfRelieving & Project End Date Notification
    function AllowtoSubmit(Flag) {
        if (Flag == 1) {
            const minimalData = selectedRowsResData.map(row => ({
                ProjectEmployeeRoleID: row.ProjectEmployeeRoleID,
                ResourceNewEndDate: row.ResourceNewEndDate,
                EffectiveFromDate: row.EffectiveFromDate,
                ApprovalStatus: "Submitted",
                //Added & commented by Ajit L on 4th July 2025 for string break issue   
                //SubmitterComments: $(`#ProjectApprovalRemark`).val(),
                SubmitterComments: $(`#ProjectApprovalRemark`).val().replaceAll("'", "''"),
                //End of Added & commented by Ajit L on 4th July 2025 for string break issue    
                RequestId: row.RequestId,
                IsResubmit: row.IsResubmit,
                UserName: UserName
            }));

            var param = JSON.stringify(minimalData);
            var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/InsertProjectEmployeeRole", param, false);

            if (strResult) {

                try {
                    var response = strResult;

                    // Check if the response contains a success message
                    if (response.message === "Data inserted successfully.") {
                        alertify.set('notifier', 'position', 'top-right');
                        //(`You can select a maximum of ${MAX_SELECTION} rows.`);
                        //Added & Commented by Ajit L on 27/01/2025
                        // alertify.success("Data inserted successfully!");
                        /*   alertify.success("Resource extension request sent for approval.");*/
                        alertify.success("Selected records have been sent for approval.");
                        //End of Added & Commented by Ajit L on 27/01/2025
                        //Commented and Added By Riddhesh Patil on 03 March 2025 for Email Notification
                        //window.open('../Email/SendEmail.aspx?MessageID=35013', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                        window.open('../Email/SendEmail.aspx?MessageID=35016', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');
                        //End of Commented and Added By Riddhesh Patil on 03 March 2025 for Email Notification
                        //console.log("Success response:", response);
                        $("#ValidationModal").modal('hide');
                        // Perform additional actions, e.g., refreshing the table or clearing inputs
                        // refreshTable();
                    }
                    // Check for duplicates
                    else if (response.message === "Some records already exist.") {
                        alertify.set('notifier', 'position', 'top-right');
                        //(`You can select a maximum of ${MAX_SELECTION} rows.`);
                        alertify.error("Some records already exist.");
                        //console.log("Duplicate records:", response);
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        //(`You can select a maximum of ${MAX_SELECTION} rows.`);
                        alertify.error("Failed to insert data. Please try again.");
                        //console.log("Error response:", response);
                    }
                } catch (e) {
                    console.error("Error parsing response:", e);
                    //alert("An error occurred while processing the response.");
                }
            } else {
                console.error("Failed to insert data. Please try again.");
            }

        } else {

            $("#ValidationModal").modal('hide');

        }
    }


    //End of Added By Dipali V On 3rd March 2025 For  Check TentativeDateOfRelieving & Project End Date Notification

    $(document).on("click", function () {
        $(".tooltip").remove();
    });

    //function refreshPage() {
    //    window.location.reload();
    //}

    function AJAXCallWithResult(url, param, async) {

        $.ajax({
            url: encodeURI(strUrl + url),
            type: "POST",
            data: param,
            async: async,
            dataType: "json",
            //contentType: "application/json;charset-utf=8",
            contentType: "application/json; charset=UTF-8",

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
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        return ajaxResult;
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


    //Added by Ajit L on 28/01/2025
    function ValidateNewEffort(element, Currenteffort, newEffort) {
        if (element.value == "" || element.value == null || element.value == undefined) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Revised Efforts should not be left blank");
            element.value = newEffort;
            element.focus();
        }
        else {
            var validateAlert = validatePositiveNumeric(element);
            if (validateAlert) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(validateAlert);
                element.value = newEffort;
                element.focus();
            }
        }


        if (parseFloat(element.value.replaceAll(",", "")) < parseFloat(Currenteffort)) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Revised Efforts should not be less than current efforts.");
            element.value = newEffort;
            element.focus();
        }

    }
    //End Added by Ajit L on 28/01/2025


    function ShowProjecthistory(Id) {
        var strHTML = "";
        var Parameters = {
            ProjectApprovalId: Id
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetPrjExtensionHistory", param, false);
        // Added or Modified by Vishal Mane on 24/03/2026 to remove empty row issue in History table
        if ($.fn.DataTable.isDataTable('#tblPrjExtHistory')) {
            $('#tblPrjExtHistory').DataTable().clear().destroy();
        }
        $("#tblPrjExtHistoryBody").empty();

        var filteredPrjHistory = [];
        for (var i = 0; i < strResult.length; i++) {
            var fieldName = $.trim((strResult[i].FieldName || "").toString());
            var oldValue = $.trim((strResult[i].OldValue || "").toString());
            var newValue = $.trim((strResult[i].NewValue || "").toString());
            var modifiedBy = $.trim((strResult[i].ModifiedBy || "").toString());
            var approvedDate = $.trim((strResult[i].ApprovedDate || "").toString());
            if (fieldName === "" && oldValue === "" && newValue === "" && modifiedBy === "" && approvedDate === "") {
                continue;
            }
            filteredPrjHistory.push(strResult[i]);
        }

        for (var j = 0; j < filteredPrjHistory.length; j++) {
            strHTML += "<tr>";
            strHTML += "<td class=''>" + (filteredPrjHistory[j].FieldName || "") + "</td>";
            strHTML += "<td class=''>" + (filteredPrjHistory[j].OldValue || "") + "</td>";
            strHTML += "<td class=''>" + (filteredPrjHistory[j].NewValue || "") + "</td>";
            strHTML += "<td class=''>" + (filteredPrjHistory[j].ModifiedBy || "") + "</td>";
            strHTML += "<td class=''>" + (filteredPrjHistory[j].ApprovedDate || "") + "</td>";
            strHTML += "</tr>";
        }
        $("#tblPrjExtHistoryBody").html(strHTML);
        $('#tblPrjExtHistory').dataTable({
             "scrollY": true,
             "scrollX": true,
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
            "info": true,
            pagingType: "simple",
            language: {
                info: "Total Records: _TOTAL_",
                infoEmpty: "Total Records: 0",
                paginate: {
                    previous: "<<",
                    next: ">>"
                }
            }
        });
        //$('#tblPrjExtHistory').wrap('<div class="dataTables_scroll" />');
        resizeSection_Updated();

        }
        function resizeSection_Updated() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 270, "overflow-y": "auto" });
        }
    //Added by Vishal Mane on 23/06/2025 to get Project Approval History
    function ShowProjectApprovalHistory(Id) {
        var strHTML = "";
        var Parameters = {
            ProjectApprovalId: Id
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetProjectApprovalHistory", param, false);
        $("#tblPrjExtHistoryBody_Approval").html("");
        $("#tblPrjExtHistory_Approval").dataTable().fnDestroy();
        for (var i = 0; i < strResult.length; i++) {
            var actionBy = (strResult[i].ApprovalStatus == "Approved" || strResult[i].ApprovalStatus == "Rejected")
                ? strResult[i].ApprovedRejectedBy
                : strResult[i].CreatedBy;
            var actionOn = (strResult[i].ApprovalStatus == "Approved" || strResult[i].ApprovalStatus == "Rejected")
                ? strResult[i].ApprovedRejectedDate
                : strResult[i].CreatedDate;
            var hasDataPrjApprovalHistory =
                $.trim(strResult[i].ApprovalStatus || "") !== "" ||
                $.trim(actionBy || "") !== "" ||
                $.trim(actionOn || "") !== "" ||
                $.trim(strResult[i].Comments || "") !== "";
            if (!hasDataPrjApprovalHistory) {
                continue;
            }
            strHTML += "<tr>";
            strHTML += "<td class=''>" + strResult[i].ApprovalStatus + "</td>";
            if (strResult[i].ApprovalStatus == "Approved" || strResult[i].ApprovalStatus == "Rejected") {
                strHTML += "<td class=''>" + strResult[i].ApprovedRejectedBy + "</td>";
            } else {
                strHTML += "<td class=''>" + strResult[i].CreatedBy + "</td>";
            }
            if (strResult[i].ApprovalStatus == "Approved" || strResult[i].ApprovalStatus == "Rejected") {
                strHTML += "<td class=''>" + strResult[i].ApprovedRejectedDate + "</td>";
            } else {
                strHTML += "<td class=''>" + strResult[i].CreatedDate + "</td>";
            }
            strHTML += "<td class=''>" + strResult[i].Comments + "</td>";
            strHTML += "</tr>";
        }
        $("#tblPrjExtHistoryBody_Approval").html(strHTML);
        $('#tblPrjExtHistory_Approval').dataTable({
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

        $("#tblAuditHistory").DataTable({
            scrollY: true,
            scrollX: true,
            paging: true,
            pagingType: "simple",
            lengthChange: false,
            searching: false,
            ordering: false,
            responsive: true,
            destroy: true,
            info: true,
            autoWidth: false,
            pageLength: 5,

            language: {
                info: "Total Records: _TOTAL_",
                infoEmpty: "Total Records: 0",
                paginate: {
                    previous: "<<",
                    next: ">>"
                }
            }
        });


        $('#tblPrjExtHistory_Approval').wrap('<div class="dataTables_scroll" />');
    }

    function ShowResourceApprovalHistory(Id) {
        var strHTML = "";
        var Parameters = {
            ProjectEmployeeRoleID: Id
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetResourceApprovalHistory", param, false);
        // Added or Modified by Vishal Mane on 24/03/2026 to remove empty row issue in Action History table
        if ($.fn.DataTable.isDataTable('#tblResExtHistory_Approval')) {
            $('#tblResExtHistory_Approval').DataTable().clear().destroy();
        }
        $("#tblResExtHistoryBody_Approval").empty();

        var filteredResApprovalHistory = [];
        for (var i = 0; i < strResult.length; i++) {
            var action = $.trim((strResult[i].Action || "").toString());
            var actionTakenBy = $.trim((strResult[i].ActionTakenBy || "").toString());
            var actionTakenOn = $.trim((strResult[i].ActionTakenOn || "").toString());
            var comments = $.trim((strResult[i].Comments || "").toString());
            if (action === "" && actionTakenBy === "" && actionTakenOn === "" && comments === "") {
                continue;
            }
            filteredResApprovalHistory.push(strResult[i]);
        }

        for (var j = 0; j < filteredResApprovalHistory.length; j++) {
            strHTML += "<tr>";
            strHTML += "<td class=''>" + (filteredResApprovalHistory[j].Action || "") + "</td>";
            strHTML += "<td class=''>" + (filteredResApprovalHistory[j].ActionTakenBy || "") + "</td>";
            strHTML += "<td class=''>" + (filteredResApprovalHistory[j].ActionTakenOn || "") + "</td>";
            strHTML += "<td class=''>" + (filteredResApprovalHistory[j].Comments || "") + "</td>";
            strHTML += "</tr>";
        }
        $("#tblResExtHistoryBody_Approval").html(strHTML);
        //$('#tblResExtHistory_Approval').dataTable({
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
        //$('#tblResExtHistory_Approval').wrap('<div class="dataTables_scroll" />');

        $('#tblResExtHistory_Approval').dataTable({
            "scrollY": true,
            "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": true,
            "retrieve": true,
            "bFilter": false,
            "bAutoWidth": true,
            "ordering": false,
            "info": true,
            pagingType: "simple",
            language: {
                info: "Total Records: _TOTAL_",
                infoEmpty: "Total Records: 0",
                paginate: {
                    previous: "<<",
                    next: ">>"
                }
            }
        });
       /* $('#tblResExtHistory_Approval').wrap('<div class="dataTables_scroll" />');*/

    }
    //End of Added by Vishal Mane on 23/06/2025 to get Project Approval History

    function ShowResHistory(Id) {
        var strHTML = "";
        var Parameters = {
            ProjectEmployeeRoleID: Id
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetResExtensionHistory", param, false);
        // Added or Modified by Vishal Mane on 24/03/2026 to remove empty row issue in tblResExtHistory
        if ($.fn.DataTable.isDataTable('#tblResExtHistory')) {
            $('#tblResExtHistory').DataTable().clear().destroy();
        }
        $("#tblResExtHistoryBody").empty();

        var filteredResHistory = [];
        for (var i = 0; i < strResult.length; i++) {
            var fieldName = $.trim((strResult[i].FieldName || "").toString()).replace(/&nbsp;/gi, "");
            var oldValue = $.trim((strResult[i].OldValue || "").toString()).replace(/&nbsp;/gi, "");
            var newValue = $.trim((strResult[i].NewValue || "").toString()).replace(/&nbsp;/gi, "");
            var modifiedBy = $.trim((strResult[i].ModifiedBy || "").toString()).replace(/&nbsp;/gi, "");
            var approvedDate = $.trim((strResult[i].ApprovedDate || "").toString()).replace(/&nbsp;/gi, "");
            if (fieldName === "" && oldValue === "" && newValue === "" && modifiedBy === "" && approvedDate === "") {
                continue;
            }
            filteredResHistory.push(strResult[i]);
        }

        for (var j = 0; j < filteredResHistory.length; j++) {
            strHTML += "<tr>";
            strHTML += "<td class=''>" + (filteredResHistory[j].FieldName || "") + "</td>";
            strHTML += "<td class=''>" + (filteredResHistory[j].OldValue || "") + "</td>";
            strHTML += "<td class=''>" + (filteredResHistory[j].NewValue || "") + "</td>";
            strHTML += "<td class=''>" + (filteredResHistory[j].ModifiedBy || "") + "</td>";
            strHTML += "<td class=''>" + (filteredResHistory[j].ApprovedDate || "") + "</td>";
            strHTML += "</tr>";
        }
        $("#tblResExtHistoryBody").html(strHTML);
        //$('#tblResExtHistory').dataTable({
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
        //$('#tblResExtHistory').wrap('<div class="dataTables_scroll" />');
        $('#tblResExtHistory').dataTable({
            "scrollY": true,
            "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "bAutoWidth": true,
            "ordering": false,
            "info": true,
            pagingType: "simple",
            language: {
                info: "Total Records: _TOTAL_",
                infoEmpty: "Total Records: 0",
                paginate: {
                    previous: "<<",
                    next: ">>"
                }
            }
        });
    }


    function ShowResoReq(ProjectID, ProjectEmployeeRoleID) {
        var Parameters = {
            ProjectID: ProjectID,
            ProjectEmployeeRoleID: ProjectEmployeeRoleID
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetResReqDetails", param, false);
        $("#ReqType").text(strResult[0].RequestType);
        $("#ReqStatus").text(strResult[0].RequestStatus);
        $("#ReqID").text(strResult[0].RequestID);
        $("#ReqDate").text(strResult[0].RequestDate);
        $("#ReqFromDate").text(strResult[0].FromDate);
        $("#ReqToDate").text(strResult[0].ToDate);
        $("#ReqWorkHours").text(strResult[0].WorkHours);
        $("#ReqAllocationType").text(strResult[0].AllocationType);
    }

    function validatePositiveNumeric(input) {
        // Regular expression to match positive numeric values only
        var regex = /^[0-9]*$/;

        // Get the value of the input field

        //Commented By Vishal for Comma Issue on 14-Aug-2025
        //var value = input.value;

        //Added By Vishal for Comma Issue on 14-Aug-2025
        var value = input.value.replaceAll(",", '');



        var Alert = "";
        // Test the value against the regular expression
        if (!regex.test(value)) {
            // If the value is not a positive numeric value, clear the input field
            //input.value = '';
            //alertify.set('notifier', 'position', 'top-right');
            //alertify.error();
            Alert = "Please enter a positive numeric value only."
        }
        return Alert;
    }
    function validatePositiveDecimal(input) {
        //var regex = /^[0-9]+(\.[0-9]{1})?$/;
        var regex = /^(\d{1,3}(,\d{2})*(,\d{3})*|\d+)([.,]\d{1})?$/;
        var value = input.value.replaceAll(',', '');
        var Alert = "";
        if (!regex.test(value)) {
            Alert = "Please enter a positive decimal value with one decimal point only."
        }
        return Alert;
    }
    //function hideCanvas() {
    //    $("#ShowPrjHisDetailpanel").hide();
    //    $("# .offcanvas-backdrop").hide();
    //}
    var SubmittedProjCount = "";
    function GetContractData(ContractId) {
        //debugger
        var Parameters = {
            ContractID: ContractId,
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetContractData", param, false);
        //$("#lblContractCustomer").text(strResult[0].CustomerName)
        //$("#lblContractValue").text(strResult[0].ContractValue)
        //$("#lblContractValue").text(strResult[0].SubmittedPrjCount)
        SubmittedProjCount = strResult[0].SubmittedPrjCount;
        //Added by Vishal Mane on 08/10/2025 to show Contract Details
        //GlobalCustomerID = strResult[0].CustomerID;
        //End of Added by Vishal Mane on 08/10/2025 to show Contract Details
    }
    //Added by Vishal Mane on 08/10/2025 to show contract details 
    function GetContractDataUpdated(ContractId) {
        var Parameters = {
            ContractID: ContractId,
        }
        var param = JSON.stringify(Parameters);
        var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/GetContractData", param, false);
        GlobalCustomerID = strResult[0].CustomerID;
    }
    function ShowContractDetails(flag) {
        //debugger
        var SelContractID = 0;
        if (flag == 0) {
            var element = $("#cboContract").val();
            var parts = element.split("_EDT_");
            var selectedcontractid = parts[0];
            if (selectedcontractid == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ContractMandatory") %>');
                $("#cboContract").focus();
                return false;
            }
            SelContractID = selectedcontractid;
        } else if (flag == 1) {
            var Reselement = $("#ResCboContract").val();
            var parts = Reselement.split("_EDT_");
            var selectedRescontractid = parts[0];
            if (selectedRescontractid == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ContractMandatory") %>');
                $("#ResCboContract").focus();
                return false;
            }
            SelContractID = selectedRescontractid;
        }
        //GetContractDataUpdated(SelContractID);
        var offcanvasEl = document.getElementById('moredetailsContract_OffcvsScreen');
        var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
        offcanvas.show();
        var strHTML = "";
        var contractid;
        contractid = SelContractID;
        var WhichAction = 'C';
        var parameter = {
            CustomerID: GlobalCustomerID,
            Flag: 1
        }
        var Param = JSON.stringify(parameter);
        var Result = AJAXCallWithResult_WebAPIUrl("/api/PM_CreateProject/GetContractList", Param, false);
        $("#contrctDetailsTbl").DataTable().destroy();
        //if (Result.length != 0) {
        //    contractid = Result[0]["ContractID"]
        //}
        for (var i = 0; i < Result.length; i++) {
            if (contractid == Result[i]["ContractID"]) {
                strHTML += '<tr id="tr_"' + Result[i]["ContractID"] + '">'
                strHTML += '<td>' + Result[i]["ContractID"] + '</td>'
                strHTML += '<td>' + Result[i]["ContractSummary"] + '</td>'
                strHTML += '<td><div class="custom_chckbox"><input id="' + Result[i]["ContractID"] + '" class="contrctChck" checked type="checkbox" onclick="bindContractid(' + Result[i]["ContractID"] + ')"><label for="' + Result[i]["ContractID"] + '"></label></div></td>'
                strHTML += '</tr>'
            }
        }
        $("#contractdetailsid").html('');
        $("#contractdetailsid").html(strHTML);
        $('#contrctDetailsTbl input[type="checkbox"]').click(function () {
            $('input[type="checkbox"]').not(this).prop("checked", false);
        });
        if (WhichAction == 'C') {
            $("#UpdateContractBtn").hide();
            $(".contrctChck").prop("disabled", true);
        }
        $("#hiddencontractid").val(contractid);
        bindContractData(contractid, GlobalCustomerID);
        getContractAttachmentDetails(contractid, GlobalCustomerID);


    }

    function bindContractData(contractid, CustomerID) {
        var Parameter = {
            CustomerID: CustomerID,
            ContractID: contractid
        }
        var param = JSON.stringify(Parameter);
        Result = AJAXCallWithResult_WebAPIUrl("/api/PM_CreateProject/GetContractDetails", param, false);
        for (var i = 0; i < Result.length; i++) {
            //console.log(Result);
            $('#ContractUniqueIdEdtLabel').text(Result[i].ContractID);
            $("#ContractSumEdtLabel").text(Result[i].ContractSummary);
            $("#CtractDetEdtLabel").text(Result[i].ContractDetails);
            $("#CustEdtLabel").text(Result[i].CustomerName);
            $("#ContctEdtTypeLabel").text(Result[i].ContractTypeID);
            $("#ComDateEdtLabel").text(Result[i].ContractStartDate);
            $("#ComSignDateEdtLabel").text(Result[i].ContractSigningDate);
            $("#ComExpDateEdtLabel").text(Result[i].ContractEndDate);
            $("#ContctEdtValLabel").text(Result[i].ContractValue);
            $("#CurrValEdtLabel").text(Result[i].Currency);
            $("#SOW_NoEdtLabel").text(Result[i].SOWNumber);
            $("#PO_NoEdtLabel").text(Result[i].PONumber);
            $("#ApprTypeEdtLabel").text(Result[i].ApprovalTypeID);
            $("#EndCustGpEdtLabel").text(Result[i].EndCustomerID);
            $("#OppIdEdtLabel").text(Result[i].OpportunityID);
            $("#hiddencontractCurrencyID").val(Result[i].CurrencyID);
            //var CustomerName = $("#cboProjectCustomer option:selected").text();
            $("#CustomerNameLabel").text(Result[i].CustomerName);
        }
    }

    function getContractAttachmentDetails(contractid, CustomerID) {
        var strHTML = "";
        var parameter = {
            ContractID: contractid
        };
        var Param = JSON.stringify(parameter);
        Result = AJAXCallWithResult_WebAPIUrl("/api/PM_CreateProject/GetContractAttachmentList", Param, false);
        if (Result.length > 0) {
            for (var i = 0; i < Result.length; i++) {
                var filesize = Result[i]["FileSize"];
                strHTML += '<tr>';
                strHTML += '<input type="hidden" class="form-control" id="hdn_OrgDocument' + Result[i]["ContractAttachmentID"] + '"  value="' + Result[i]["GeneratedFileName"] + '"/><input type="hidden" class="form-control" id="hdn_Document' + Result[i]["ContractAttachmentID"] + '"  value="' + Result[i]["OriginalFileName"] + '"/>';
                strHTML += '<td><a href="javascript:;" onclick="DownloadFile(\'' + Result[i]["OriginalFileName"] + '\',\'' + Result[i]["GeneratedFileName"] + '\') ">' + Result[i]["OriginalFileName"] + '</a><i class="fas fa-file-download blueIcn ps-2" data-bs-toggle="tooltip" title="Download" ></i></td>';
                strHTML += '<td>' + Result[i]["AttachedBy"] + '</td>';
                strHTML += '<td>' + Result[i]["DateAttached"] + '</td>';
                strHTML += '<td>' + Result[i]["Description"] + '</td>';
                strHTML += '</tr>';
            }
        } else {
            strHTML = '<tr><td colspan="4">No data available in table</td></tr>'
        }
        $("#contractdocid").html('');
        $("#contractdocid").html(strHTML);
    }

    function DownloadFile(OriginalFileName, SystemFileName) {
        if (SystemFileName == null) {
            SystemFileName = '';
        }
        var strTemp = '../../General/ViewAttachment.aspx?FromWhere=Contracts&FileName=' + OriginalFileName + '&SystemFileName=' + SystemFileName;
        window.open(strTemp);
    }

    var strWebAPIUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
    var GlobalCustomerID;
    function AJAXCallWithResult_WebAPIUrl(url, param, async) {
        $.ajax({
            url: encodeURI(strWebAPIUrl + url),
            type: "POST",
            data: param,
            async: async,
            dataType: "json",
            //contentType: "application/json;charset-utf=8",
            contentType: "application/json; charset=UTF-8",
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
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        return ajaxResult;
    }
    //Added by Vishal Mane on 08/10/2025 to show contract details

    //Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
    function buildWorkflowApprovalUI(projectList) {
        //debugger
        $("#ProjectApprovalRemark_WF").val("");
        alertify.set('notifier', 'position', 'top-right');
        let container = $("#workflowProjectContainer");
        container.html("");
        var IsValid = 1;
        let failedProjects = [];
        for (let i = 0; i < projectList.length; i++) {
            let p = projectList[i];
            let payload = { ProjectID: p.ProjectID };
            let Result;
            
            if (p.IsResubmit_StatusID == 3) {
                Result = AJAXCallWithResult(
                    "/api/PM_Bulk_Extension/GetRejectedWorkflowDetails",
                    JSON.stringify(payload),
                    false
                );
            } else {
                Result = AJAXCallWithResult(
                    "/api/PM_Bulk_Extension/GetWorkflowDetails",
                    JSON.stringify(payload),
                    false
                );
            }
            let headerInfo = Result.Header[0];
            if (
                !Result ||
                !Result.Workflows ||
                Result.Workflows.length === 0 ||
                !Result.Workflows[0].WorkflowID
            ) {
                failedProjects.push(headerInfo.ProjectName);   // ✅ collect
                IsValid = 0;
            }
        }
        // 🔴 After loop
        if (failedProjects.length > 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error(
                `Workflow is not configured for project(s): ${failedProjects.join(", ")}`
            );
            return false;
        }
        for (let i = 0; i < projectList.length; i++) {
            let p = projectList[i];
            // 🔵 API call per project
            let payload = { ProjectID: p.ProjectID };
            var Result;
            if (p.IsResubmit_StatusID == 3) {
                Result = AJAXCallWithResult("/api/PM_Bulk_Extension/GetRejectedWorkflowDetails", JSON.stringify(payload), false);
            } else {
                Result = AJAXCallWithResult("/api/PM_Bulk_Extension/GetWorkflowDetails", JSON.stringify(payload), false);
            }
            //var Result = AJAXCallWithResult("/api/PM_Bulk_Extension/GetWorkflowDetails", JSON.stringify(payload), false);
            let workflowList = Result.Workflows;
            let headerInfo = Result.Header[0];
            if (
                !Result ||
                !Result.Workflows ||
                Result.Workflows.length === 0 ||
                !Result.Workflows[0].WorkflowID
            ) {
                alertify.error("Workflow is not configured for project: " + headerInfo.ProjectName);
                IsValid = 0;
                break;
            }            
            //let workflowOptions = '<option value="">Select Workflow</option>';
            let workflowOptions = "";
            for (let i = 0; i < workflowList.length; i++) {
                workflowOptions += `<option value="${workflowList[i].WorkflowID}">
                                    ${workflowList[i].WorkflowName}
                                </option>`;
            }
            let html = `<div class="card border rounded mb-3 workflow-block" data-fromstageid="${headerInfo.FromStageID}" data-projectid="${p.ProjectID}" data-isresubmit="${p.IsResubmit_StatusID}">
                                <div class="card-body">
                                    <div class="fw-bold mb-1">
                                        Project Name : <span class="lblProjectName">${headerInfo.ProjectName}</span>
                                    </div>
                                    <div class="text-muted small mb-3">
                                        <span class="lbl_text">Workflow:</span> 
                                        <span class="lblWorkflowName">${headerInfo.WorkflowName ?? ''}</span><br>

                                        <span class="lbl_text">Practice:</span> ${headerInfo.PracticeName ?? ''} >>
                                        <span class="lbl_text">BU:</span> ${headerInfo.BusinessGroupName ?? ''} >>
                                        <span class="lbl_text">OU:</span> ${headerInfo.LocationName ?? ''}
                                    </div>
                                    <div class="row">
                                        <!-- WORKFLOW DROPDOWN -->
                                        <div class="col-sm-6">
                                            <div class="row align-items-center">
                                                <div class="col-sm-4 text-end">
                                                    <label class="required mb-0">Workflow:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <select class="selectpicker ddlWorkflow" data-live-search="true" data-width="100%" data-projectid="${p.ProjectID}"> ${workflowOptions}</select>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- STATUS DROPDOWN -->
                                        <div class="col-sm-6">
                                            <div class="row align-items-center">
                                                <div class="col-sm-4 text-end">
                                                    <label class="required mb-0">Status:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <select class="selectpicker ddlStatusWF" data-live-search="true" data-width="100%" data-projectid="${p.ProjectID}"><option value="">Select Status</option></select>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>`;
            container.append(html);
            // initialize selectpicker for newly added html
            $('.selectpicker').selectpicker('refresh');
            if (workflowList.length > 0) {
                loadWorkflowStatuses(workflowList[0].WorkflowID, p.ProjectID);
            }
            //container.append(html);
        }
        if (IsValid == 1) {
            var offcanvasEl = document.getElementById('sendforApproval_OffcvsScreen');
            var offcanvas = new bootstrap.Offcanvas(offcanvasEl);
            offcanvas.show();
        }
        // refresh bootstrap select
        $('.selectpicker').selectpicker('refresh');
    }

        $(document).on("change", ".ddlWorkflow", function () {
        //debugger
        let workflowId = $(this).val();
        let projectId = $(this).data("projectid");
        if (!workflowId) return;
        let payload = {
            WorkflowID: workflowId,
            ProjectID: projectId
        };
        var Result = AJAXCallWithResult("/api/PM_Bulk_Extension/GetWorkflowStatusMaster", JSON.stringify(payload), false);
        let statusDDL = $(`.ddlStatusWF[data-projectid='${projectId}']`);
        // destroy selectpicker instance first (important)
        statusDDL.selectpicker('destroy');
        statusDDL.empty();
        //statusDDL.html('<option value="">Select Status</option>');
        if (Result && Result.length > 0) {
            for (let i = 0; i < Result.length; i++) {
                statusDDL.append(`<option value="${Result[i].StatusID}" data-roleid="${Result[i].RoleID}">
                                ${Result[i].StatusName}
                              </option>`);
            }
        }
        statusDDL.selectpicker('refresh');
    });

    function loadWorkflowStatuses(WorkflowID, projectid) {
        let payload = {
            WorkflowID: WorkflowID,
            ProjectID: projectid,
        };
        var Result = AJAXCallWithResult("/api/PM_Bulk_Extension/GetWorkflowStatusMaster", JSON.stringify(payload), false);
        let statusDDL = $(`.ddlStatusWF[data-projectid='${projectid}']`);
        // destroy selectpicker instance first (important)
        statusDDL.selectpicker('destroy');
        statusDDL.empty();
        //statusDDL.html('<option value="">Select Status</option>');
        if (Result && Result.length > 0) {
            for (let i = 0; i < Result.length; i++) {
                statusDDL.append(`<option value="${Result[i].StatusID}" data-roleid="${Result[i].RoleID}">
                                ${Result[i].StatusName}
                              </option>`);
            }
        }
        statusDDL.selectpicker('refresh');
    }

    function ValidateSendForApproval() {
        let IsValid = 1;
        alertify.set('notifier', 'position', 'top-right');
        $(".workflow-block").each(function () {
            let workflowDDL = $(this).find(".ddlWorkflow");
            let statusDDL = $(this).find(".ddlStatusWF");
            let projectName = $(this).find(".lblProjectName").text();
            // 🔴 get selected values safely
            let workflowId = workflowDDL.find("option:selected").val();
            let statusId = statusDDL.find("option:selected").val();
            //Added by Vishal Mane on 17/02/2026 to Validate If no active employee is mapped to the approver role 
            let postId = statusDDL.find("option:selected").data("roleid");
            if (postId > 0) {
                var ProjectdataParameter = {
                    RoleID: postId,
                }
                var param = JSON.stringify(ProjectdataParameter);
                var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/CheckIsRoleActiveEmployee", param, false);
                if (strResult[0].IsACtiveEmployee == 0) {
                    alertify.error(`No active employee is mapped to the selected role >> ${strResult[0].RoleDescription}`);
                    //statusDDL.selectpicker('toggle');
                    //statusDDL.focus();
                    IsValid = 0;
                    return false;
                }
            }
            //End of Added by Vishal Mane on 17/02/2026 to Validate If no active employee is mapped to the approver role            
            // ===== WORKFLOW VALIDATION =====
            if (!workflowId || workflowId == "" || workflowId == "0") {
                alertify.error("Please select workflow for project: " + projectName);
                workflowDDL.selectpicker('toggle');
                workflowDDL.focus();
                IsValid = 0;
                return false;
            }
            // ===== STATUS VALIDATION =====
            if (!statusId || statusId == "" || statusId == "0") {
                alertify.error("Please select status for project: " + projectName);
                statusDDL.selectpicker('toggle');
                statusDDL.focus();
                IsValid = 0;
                return false;
            }
        });
        // ===== COMMENT VALIDATION =====
        if (IsValid == 1) {
            let comments = $("#ProjectApprovalRemark_WF").val();
            if (!comments || comments.trim() == "") {
                alertify.error("Submitter comment is required before sending for approval.");
                $("#ProjectApprovalRemark_WF").focus();
                return 0;
            }
        }
        return IsValid;
    }
    var ApproverRoleList = [];
    function getWorkflowApprovalData() {
        let approvalList = [];
        ApproverRoleList = [];
        let uniqueMap = {};   // 🔵 used to prevent duplicates
        $(".workflow-block").each(function () {
            let fromstageid = $(this).data("fromstageid");
            let projectId = $(this).data("projectid");
            let workflowDDL = $(this).find(".ddlWorkflow");
            let statusDDL = $(this).find(".ddlStatusWF");
            let workflowId = workflowDDL.find("option:selected").val();
            let statusId = statusDDL.find("option:selected").val();
            let actionTypeID = $(this).data("isresubmit");   // data attribute is lowercase internally
            let actionType = "";
            // convert to number safely
            actionTypeID = parseInt(actionTypeID) || 0;
            if (actionTypeID === 3) {
                actionType = "RESUBMIT";
            } else {
                actionType = "SUBMIT";
            }

            let roleId = statusDDL.find("option:selected").data("roleid");

            if (!workflowId || !statusId) return;

            let key = projectId + "_" + roleId + "_" + fromstageid + "_" + statusId;
            if (!uniqueMap[key]) {
                uniqueMap[key] = true;
                approvalList.push({
                    ProjectID: projectId,
                    WorkflowID: workflowId,
                    StageID: statusId,
                    ActionType: actionType,
                    FromStage: fromstageid
                });

                ApproverRoleList.push({
                    ProjectID: projectId,
                    RoleID: roleId,
                    ToStageID: statusId,
                    WorkflowID: workflowId,
                });
            }
        });
        return approvalList;
    }


    function SendForApproval_WF(element) {
        var IsValid = ValidateSendForApproval();
        if (IsValid == 1) {

            // 🔵 collect workflow approval data
            let approvalData = getWorkflowApprovalData();
            
            if (approvalData.length == 0) {
                alertify.error("No project data available for approval.");
                return;
            }

            var Approvaltype = element.dataset.flag;
            Approvaltype = 'showProjApprovalbtn';
            if (Approvaltype == 'showProjApprovalbtn') {
                Flag = 0;
            } else {
                Flag = 1;
            }
            var ProjectdataParameter = {
                RoleID: RoleID,
                Flag: Flag
            }
            var param = JSON.stringify(ProjectdataParameter);
            var strResult = AJAXCallWithResult("/api/PM_Bulk_Extension/CheckIsProjectExtensionApprover", param, false);
            if (Approvaltype == 'showProjApprovalbtn') {
                if (strResult !== 'True' && strResult != "1") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(`Please Set Project Extension Approver`);
                    return;
                }
            }
            else {
                if (strResult !== 'True' && strResult != "1") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(`Please Set Resource Extension Approver`);
                    return;
                }
            }
            if (Approvaltype == 'showProjApprovalbtn') {
                let payload = {
                    UserID: encodeURI(UserID),
                    SubmitterRemark: $(`#ProjectApprovalRemark_WF`).val().replaceAll("'", "''"),
                    WorkflowAttributes: approvalData
                };
                var Result = AJAXCallWithResult("/api/PM_Bulk_Extension/SubmitWorkflowForApproval", JSON.stringify(payload), false);
                var offcanvasEl = document.getElementById('sendforApproval_OffcvsScreen');
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasEl);
                offcanvas.hide();
                submitBulkExtensionApproval();
            }
            else if (Approvaltype == 'showResApprovalbtn') {
                saveSelectedResRows();
            }
        }
        else {

        }
    }


    function AJAXCallWithResult_SilentMail(url, param, async) {
        //debugger
        let ajaxResult = null;
        $.ajax({
            url: encodeURI(strUrl + url),
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
            error: function (xhr, status, error) {
                ajaxResult = null;
                alertify.set('notifier', 'position', 'top-right');
                let errorMsg = "Failure Sending Mail. Unable to connect to remote server.";
                //try {
                //    if (xhr.responseJSON && xhr.responseJSON.Message) {
                //        errorMsg = xhr.responseJSON.Message;
                //    }
                //    else if (xhr.responseText) {
                //        errorMsg = xhr.responseText;
                //    }
                //    else if (error) {
                //        errorMsg = error;
                //    }
                //} catch (e) { }
                //Specified argument was out of the range of valid values
                alertify.error(errorMsg);
            }
        });
        return ajaxResult;
        }


        function getStatusColors() {
            var html = "";
            var strResult = AJAXCallWithResult("/api/PM_BulkExtensionApproval/GetStatusColors", '', false);
            for (var i = 0; i < strResult.length; i++) {
                if (strResult[i].StatusID === 0) {
                    html += "<option value='" + strResult[i].StatusID + "'>" + "Select Status" + "</option>";
                } else if (strResult[i].StatusID === 1) {
                    html += "<option value='" + strResult[i].StatusID + "'data-content=\"<span class='statusBox statusSubmitted mx-2'>&nbsp;</span> Submitted\">" + strResult[i].StatusName + "</option>";
                } else if (strResult[i].StatusID === 2) {
                    html += "<option value='" + strResult[i].StatusID + "'data-content=\"<span class='statusBox statusApproved mx-2'>&nbsp;</span> Approved\">" + strResult[i].StatusName + "</option>";
                } else if (strResult[i].StatusID === 3) {
                    html += "<option value='" + strResult[i].StatusID + "'data-content=\"<span class='statusBox statusRejected mx-2'>&nbsp;</span> Rejected\">" + strResult[i].StatusName + "</option>";
                }
            }
            $("#ResCboStatus").html(html);
            $('#ResCboStatus').selectpicker('refresh');            
        }
    //End of Added by Vishal Mane on 09/02/2026 to open off canvas for Send For Approval Screen
    </script>

</body>

</html>
