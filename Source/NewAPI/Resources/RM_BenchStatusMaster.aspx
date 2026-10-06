<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_BenchStatusMaster.aspx.vb" Inherits="Whizible.RM_BenchStatusMaster" %>
<!DOCTYPE html>
<html class="bench-status-master-page">

     <%CommonFunctions.General.PlotPageHeadTag("Bench Status Master")%>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom_0.1.css">



    <style type="text/css">
        /* Alertify toast above modals/offcanvas (colors from alertify.min.css) */
        .alertify-notifier {
            z-index: 99999 !important;
        }
        .alertify-notifier .ajs-message {
            z-index: 99999 !important;
        }
        /* ── PM-style page header (aligned with PM_Bulk_Ex_Approval.html) ── */
        :root {
            --bench-primary: #2563eb;
            --bench-text-muted: #6b7280;
            --bench-border: #e5e7eb;
            --bench-white: #ffffff;
        }
        .page-header {
            background: var(--bench-white);
            border-bottom: 1px solid var(--bench-border);
            padding: 6px 9px;
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .page-header .icon-wrap {
            width: 32px;
            height: 32px;
            background: #1e40af;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .page-header .icon-wrap i { color: #fff; font-size: 18px; }
        .page-header h1 { font-size: 16px; font-weight: 700; color: #1e40af; margin: 0; }
        .page-header p { font-size: 11.5px; color: var(--bench-text-muted); margin: 0; }
        /* Main list: table unchanged; pagination fixed like Vendor (wrap table + pager only) */
        body.bench-status-master-page {
            overflow-x: hidden;
        }
        .bench-pm-main.main-content {
            padding: 8px 28px 12px;
            width: 100%;
            box-sizing: border-box;
            overflow: visible;
        }
        .bench-pm-main .content.bench-list-layout {
            min-height: 0 !important;
            height: auto !important;
            padding-bottom: 0 !important;
            overflow: visible;
            width: 100%;
        }
        .bench-list-top,
        .bench-pm-main .filtersSection {
            width: 100%;
        }
        /* Same as VendorType .vendor-list-table-wrap — search stays outside this wrap */
        .bench-list-table-wrap {
            display: flex;
            flex-direction: column;
            min-height: calc(100vh - 210px);
        }
        .bench-list-table-area {
            flex: 0 0 auto;
            overflow: visible;
            width: 100%;
        }
        .bench-list-table-wrap .bench-list-pagination {
            flex: 0 0 auto;
            margin-top: auto !important;
            padding-top: 26px;
            border-top: none;
        }
        .bench-list-table-area #UnitTable_wrapper {
            width: 100% !important;
            max-width: 100% !important;
            box-sizing: border-box;
        }
        .bench-list-table-area .dataTables_wrapper,
        .bench-list-table-area .dataTables_scroll,
        .bench-list-table-area .dataTables_scrollBody,
        .bench-list-table-area .dataTables_scrollHead {
            overflow: visible !important;
            max-height: none !important;
            height: auto !important;
            width: 100% !important;
        }
        /* Only the page-header bottom border; global + local .toplinks added a second line */
        .bench-pm-main .filtersSection .toplinks.topFilters {
            border-top: none !important;
        }
        .bench-pm-main .filtersSection .topFilters {
            margin-bottom: 0 !important;
            padding-top: 0.35rem !important;
            padding-bottom: 0.35rem !important;
        }
        .bench-no-access-msg {
            margin: 0;
            font-weight: 400;
            color: #2a2d2e;
            font-size: 14px;
            line-height: 1.2;
            text-align: center;
            margin-top: 224px;
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

        h5.pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 14px
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

        .custom_radio input[type="radio"]+label span {
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

        .custom_radio input[type="radio"]:checked+label span {
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
            font-size: 11.5px;
        }
        /* Main grid – fixed Active / More Action; Status Name fills remainder */
        #UnitTable,
        #UnitTable_wrapper table {
            table-layout: fixed !important;
            width: 100% !important;
        }
        #UnitTable thead th,
        #UnitTable_wrapper table thead th {
            vertical-align: middle;
        }
        #UnitTable th:nth-child(1),
        #UnitTable td:nth-child(1),
        #UnitTable_wrapper table th:nth-child(1),
        #UnitTable_wrapper table td:nth-child(1) {
            text-align: left !important;
            padding-left: 8px !important;
            vertical-align: middle;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        #UnitTable tbody tr.tblCol td:nth-child(1),
        #UnitTable_wrapper table tbody tr.tblCol td:nth-child(1) {
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }
        #UnitTable th:nth-child(2),
        #UnitTable td:nth-child(2),
        #UnitTable_wrapper table th:nth-child(2),
        #UnitTable_wrapper table td:nth-child(2) {
            width: 100px !important;
            min-width: 100px !important;
            max-width: 100px !important;
            text-align: center !important;
            vertical-align: middle;
        }
        #UnitTable th:nth-child(3),
        #UnitTable td:nth-child(3),
        #UnitTable_wrapper table th:nth-child(3),
        #UnitTable_wrapper table td:nth-child(3) {
            width: 140px !important;
            min-width: 140px !important;
            max-width: 140px !important;
            text-align: center !important;
            vertical-align: middle;
        }
        #UnitTable .bench-more-action-cell,
        #UnitTable_wrapper table .bench-more-action-cell {
            text-align: center !important;
        }
        #UnitTable .bench-add-status-cell {
            display: flex;
            align-items: center;
            gap: 8px;
            width: 100%;
        }
        #UnitTable .bench-add-status-cell .addIcn {
            flex-shrink: 0;
        }
        #UnitTable .bench-add-status-cell .newTaskInput {
            flex: 1 1 auto;
            min-width: 0;
        }
        .bench-row-actions a {
            color: #1359a6;
            text-decoration: none;
            line-height: 1;
            font-size: 11px;
        }
        .bench-row-actions a:hover {
            color: #0d3d7a;
        }
        .bench-row-actions .fa-pen,
        .bench-row-actions .fa-trash-alt,
        .bench-row-actions .fa-history {
            font-size: 11px;
        }
        .bench-row-actions .bench-delete-row,
        .bench-row-actions .bench-delete-row .fa-trash-alt {
            color: #dc3545 !important;
        }
        .bench-row-actions .bench-delete-row:hover,
        .bench-row-actions .bench-delete-row:hover .fa-trash-alt {
            color: #b02a37 !important;
        }
        .bench-row-actions .bench-history-row,
        .bench-row-actions .bench-history-row .fa-history {
            color: #0d3d7a !important;
        }
        .bench-row-actions .bench-history-row:hover,
        .bench-row-actions .bench-history-row:hover .fa-history {
            color: #333 !important;
        }
        .bench-row-actions .bench-history-row.bench-history-disabled,
        .bench-row-actions .bench-history-row.bench-history-disabled .fa-history {
            color: #8b95a1 !important;
            cursor: not-allowed !important;
            opacity: 0.85;
           /* pointer-events: none;*/
        }
        .bench-row-actions.bench-row-actions-view {
            gap: 6px !important;
        }
        #UnitTable tr.row-editing .status-name-input {
            max-width: 100%;
        }
        #UnitTable tr.row-editing .bench-active-select {
            max-width: 90px;
            margin: 0 auto;
            font-size: 11.5px;
            padding: 2px 8px;
            height: auto;
        }
        #UnitHistoryOffcanvas {
            display: flex;
            flex-direction: column;
            height: 100vh;
            max-height: 100vh;
        }
        #UnitHistoryOffcanvas .offcanvas-body.bench-history-offcanvas-body {
            padding: 0;
            display: flex;
            flex-direction: column;
            flex: 1 1 auto;
            min-height: 0;
            overflow: hidden;
        }
        #UnitHistoryOffcanvas .bench-history-top {
            flex: 0 0 auto;
        }
        #UnitHistoryOffcanvas .bench-history-table-area {
            flex: 1 1 auto;
            min-height: 0;
            overflow: auto;
            padding: 0 16px;
        }
        #UnitHistoryOffcanvas .bench-history-pagination {
            flex: 0 0 auto;
            margin-top: auto;
            width: 100%;
            border-top: 1px solid #e5e7eb;
            background: #fff;
        }
        #UnitHistoryOffcanvas .bench-history-section-bar {
            margin-bottom: 0;
        }
        #UnitHistoryOffcanvas .bench-history-section-bar .bench-offcanvas-section-title {
            font-weight: 700;
            color: #1e40af;
            font-size: 14px;
        }
        #UnitHistoryOffcanvas .bench-history-details {
            background: #fff;
            border-bottom: 1px solid #e9ecef;
        }
        #UnitHistoryOffcanvas .bench-history-details .detail-label {
            color: #6b7280;
            font-weight: 500;
            margin-right: 6px;
        }
        #UnitHistoryOffcanvas .bench-history-details .detail-value {
            font-weight: 600;
            color: #212529;
        }
        #UnitHistoryOffcanvas .bench-history-filters {
            padding: 12px 16px 8px;
        }
        /* History grid – fixed column widths */
        #UnithowHisTable,
        #UnithowHisTable_wrapper table {
            table-layout: fixed !important;
            width: 100% !important;
        }
        #UnithowHisTable th,
        #UnithowHisTable td,
        #UnithowHisTable_wrapper table th,
        #UnithowHisTable_wrapper table td {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            vertical-align: middle;
            font-size: 11.5px;
        }
        #UnithowHisTable th:nth-child(1),
        #UnithowHisTable td:nth-child(1),
        #UnithowHisTable_wrapper table th:nth-child(1),
        #UnithowHisTable_wrapper table td:nth-child(1) {
            width: 120px !important;
            min-width: 120px !important;
            max-width: 120px !important;
        }
        #UnithowHisTable th:nth-child(2),
        #UnithowHisTable td:nth-child(2),
        #UnithowHisTable_wrapper table th:nth-child(2),
        #UnithowHisTable_wrapper table td:nth-child(2) {
            width: 160px !important;
            min-width: 160px !important;
            max-width: 160px !important;
        }
        #UnithowHisTable th:nth-child(3),
        #UnithowHisTable td:nth-child(3),
        #UnithowHisTable_wrapper table th:nth-child(3),
        #UnithowHisTable_wrapper table td:nth-child(3) {
            width: 160px !important;
            min-width: 160px !important;
            max-width: 160px !important;
        }
        #UnithowHisTable th:nth-child(4),
        #UnithowHisTable td:nth-child(4),
        #UnithowHisTable_wrapper table th:nth-child(4),
        #UnithowHisTable_wrapper table td:nth-child(4) {
            width: 115px !important;
            min-width: 115px !important;
            max-width: 115px !important;
        }
        #UnithowHisTable th:nth-child(5),
        #UnithowHisTable td:nth-child(5),
        #UnithowHisTable_wrapper table th:nth-child(5),
        #UnithowHisTable_wrapper table td:nth-child(5) {
            width: 100px !important;
            min-width: 100px !important;
            max-width: 100px !important;
        }
        #UnitHistoryOffcanvas .table-responsive {
            overflow-x: auto;
        }
        /* Pagination (same pattern as PM_TrainingPlan.aspx) */
        .pagination-container {
            background: white;
            display: flex !important;
            justify-content: flex-end;
            align-items: center;
            padding: 1rem;
            gap: 1rem;
            margin-top: 0;
            z-index: 100;
            visibility: visible !important;
            opacity: 1 !important;
        }
        #UnitTable_wrapper .dataTables_paginate,
        #UnitTable_wrapper .dataTables_info {
            display: none !important;
        }
        /* Main list: no inner scroll area — table grows with content */
        #UnitTable_wrapper .dataTables_scroll,
        #UnitTable_wrapper .dataTables_scrollBody,
        #UnitTable_wrapper .dataTables_scrollHead {
            overflow: visible !important;
            height: auto !important;
            max-height: none !important;
        }
        #UnitTable_wrapper .dataTables_scrollBody {
            overflow-y: visible !important;
        }
        #UnitTable_wrapper,
        .bench-list-table-area .dataTables_wrapper {
            overflow: visible !important;
            max-height: none !important;
        }
        /* Keep scrollHead width in sync with scrollBody so header never misaligns
           when the offcanvas panel opens/closes and shifts the available width.
           KEY FIX: DataTables sets a hardcoded pixel width + padding-right:15px on
           dataTables_scrollHeadInner at init (e.g. "width:1020px; padding-right:15px").
           When the offcanvas shifts layout the body shrinks but the header stays at 1020px.
           Overriding to 100% + box-sizing:border-box + padding-right:0 permanently fixes this. */
        #UnitTable_wrapper .dataTables_scrollHead,
        #UnitTable_wrapper .dataTables_scrollHead table {
            width: 100% !important;
            box-sizing: border-box !important;
        }
        #UnitTable_wrapper .dataTables_scrollHeadInner {
            width: 100% !important;
            box-sizing: border-box !important;
            padding-right: 0 !important;
        }
        #UnitTable_wrapper .dataTables_scrollHeadInner table {
            width: 100% !important;
            margin-left: 0 !important;
        }
        #UnitTable_wrapper .dataTables_scrollBody,
        #UnitTable_wrapper .dataTables_scrollBody table {
            width: 100% !important;
            box-sizing: border-box !important;
        }
        #UnitTable {
            margin-bottom: 0;
        }
        #benchStatusTableBody tr.bench-empty-row td.bench-empty-msg {
            text-align: center !important;
            color: #6c757d;
            padding: 1rem 0;
        }

        #UnitHistoryOffcanvas .hstryfltr label {
            font-weight: 500;
            margin-bottom: 0;
        }
        .bootstrap-select .dropdown-menu{
            max-width: 100%;
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
        tr.CustRowEdt .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 50%;
        }

          /* Added by Gauri - Fullscreen loader overlay for this page */
        .loader-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            width: 100%;
            height: 100%;
            background-color: transparent;
            z-index: 2000;
        }
    
        /* Centered loader GIF inside overlay */
        .loader-overlay .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
    
        /* Added by Gauri - Initial page-load preloader (center GIF before JS runs) */
        .preloader {
            position: fixed;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
            z-index: 2100;
            /* above overlay so GIF is visible even before JS initializes */
        }

    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed bench-status-master-page">

     <!-- Page Loader - Show immediately -->
   <div class="loader-overlay" id="loaderOverlay" style="display: none;">
       <div class="loader"></div>
   </div>

    <%If m_blnViewAccess = True Then%>
 
       <div id="ProjProfSec" class="preloader"></div>


    <div class="page-header PT-1">
        <div class="icon-wrap"><i class="fas fa-clipboard-list"></i></div>
        <div>
            <h1><%=MyBase.GetResourceString("C_PageHeading")%></h1>
            <p><%=MyBase.GetResourceString("C_PageDescription")%></p>
        </div>
    </div>

    <div class="bgwhite bench-page-shell">
        <%If m_blnViewAccess = True Then%><span id="canViewBenchStatusFlag" style="display:none;"></span><%End If%>
        <%If m_blnDeleteAccess = True Then%><span id="canDeleteBenchStatusFlag" style="display:none;"></span><%End If%>
        <%If m_blnAddAccess = True Then%><span id="canAddBenchStatusFlag" style="display:none;"></span><%End If%>
        <%If m_blnEditAccess = True Then%><span id="canEditBenchStatusFlag" style="display:none;"></span><%End If%>
        <div class="clearfix"></div>


        <div class="clearfix"></div>
        <div class="main-content bench-pm-main pt-0">
            <div class="content pt-0 bench-list-layout">
            <div class="bench-list-top">
            <!-- Filters -->
            <div class="filtersSection" id="topFilterSec">
                <!-- Top filters -->
                <div class="py-2 mb-1 col-sm-12 text-end toplinks topFilters">
                    <div class="form-group mb-0">
                        <div class="row">
                            <div class="col-sm-2">&nbsp;</div>
                            <div class="col-sm-7"></div>
                            <div class="col-sm-3 text-end">
                                <div class="input-group">
                                    <input id="serchUnitInput" type="text" placeholder="<%=MyBase.GetResourceString("C_SearchStatus")%>"
                                        class="form-control input-sm" autocomplete="off">
                                    <div class="input-group-btn">
                                        <button class="btn btn-default srchBtn" type="button" id="serchUnitBtn"><i
                                                class="fas fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div><!-- /.bench-list-top -->

            <!-- Unit List View starts here -->
            <div class="bench-list-table-wrap">
            <div class="bench-list-table-area">
            <table id="UnitTable" class="table" style="width:100%;">
                <thead class="stickyTblHeader">
                    <tr>
                        <th class="text-start"><%=MyBase.GetResourceString("C_StatusName")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_Active")%></th>
                        <th class="text-center"><%=MyBase.GetResourceString("C_MoreAction")%></th>
                    </tr>
                </thead>
                <tbody id="benchStatusTableBody">
                    <%If m_blnAddAccess = True Then%>
                    <!-- Table row to add new records in table -->
                    <tr class="CustRowEdt">
                        <td class="text-start newTaskCell">
                            <div class="bench-add-status-cell" >
                                <i class="fas fa-plus addIcn" data-bs-toggle="tooltip"
       data-bs-placement="top"
       title="Add New Status"></i>
                                <input type="text" class="newTaskInput" id="newUnitInput" maxlength="50" placeholder="<%=MyBase.GetResourceString("C_NewStatusName")%>" />
                            </div>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <div class="addNewBtns d-flex justify-content-center gap-3">
                                <i class="fas fa-check clickYes disableIcn" id="clickYes1" onclick="AddNewUnit()"></i>
                                <i class="fas fa-times clickNo" id="clickNo1" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="<%=MyBase.GetResourceString("C_Cancel")%>"></i>
                            </div>
                        </td>
                    </tr>
                    <%End If%>
                </tbody>
            </table>
            </div><!-- /.bench-list-table-area -->
            <!-- Custom Pagination (server-side) -->
            <div class="pagination-container bench-list-pagination">
                <div style="color: #374151; font-size: 11.5px;">
                    <span id="totalRecords"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
                </div>
                <div style="display: flex; gap: 0.5rem;">
                    <button type="button" id="firstPageBtn" onclick="benchGoToPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px;">
                        <i class="fas fa-angle-double-left"></i>
                    </button>
                    <button type="button" id="lastPageBtn" onclick="benchGoToNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px;">
                        <i class="fas fa-angle-double-right"></i>
                    </button>
                </div>
            </div>
            </div><!-- /.bench-list-table-wrap -->
            <!-- Country List View ends here -->
            </div><!-- /.bench-list-layout -->
        </div><!-- /.main-content -->

        <!-- History Offcanvas (opened from list History icon) -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
            id="UnitHistoryOffcanvas" aria-labelledby="benchHistorySectionTitle">
            <div class="offcanvas-body bench-history-offcanvas-body">
                <div class="bench-history-top">
                <div class="container-fluid py-2 graybg bench-history-section-bar">
                    <div class="row align-items-center">
                        <div class="col">
                            <div class="d-flex align-items-center font-weight-600">
                                <span class="bench-offcanvas-section-title" id="benchHistorySectionTitle"><%=MyBase.GetResourceString("C_History")%></span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>"  data-bs-toggle="tooltip" data-bs-placement="top" title="Close"></button>
                        </div>
                    </div>
                </div>
                <div class="bench-history-details px-3 py-2">
                    <div class="row g-2">
                        <div class="col-sm-6">
                            <span class="detail-label"><%=MyBase.GetResourceString("C_StatusNameColon")%></span>
                            <span class="detail-value" id="benchHisStatusName">—</span>
                        </div>
                        <div class="col-sm-6">
                            <span class="detail-label"><%=MyBase.GetResourceString("C_ActiveColon")%></span>
                            <span class="detail-value" id="benchHisActive">—</span>
                        </div>
                    </div>
                </div>
                <div class="form-inline hstryfltr bench-history-filters">
                    <div class="row d-flex justify-content-center g-3">
                        <div class="col-sm-6">
                            <div class="row form-group align-items-center">
                                <div class="col-sm-5 d-flex justify-content-end">
                                    <label for="modifiedHisField"><%=MyBase.GetResourceString("C_ModifiedFieldColon")%></label>
                                </div>
                                <div class="col-sm-7">
                                    <select class="selectpicker" data-live-search="true" id="modifiedHisField" data-width="100%">
                                        <option value=""><%=MyBase.GetResourceString("C_SelectModifiedField")%></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group align-items-center">
                                <div class="col-sm-5 d-flex justify-content-end">
                                    <label for="modifiedHisBy"><%=MyBase.GetResourceString("C_ModifiedByColon")%></label>
                                </div>
                                <div class="col-sm-7">
                                    <select class="selectpicker" data-live-search="true" id="modifiedHisBy" data-width="100%">
                                        <option value=""><%=MyBase.GetResourceString("C_SelectModifiedBy")%></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div><!-- /.bench-history-top -->
                <div class="bench-history-table-area">
                <div class="table-responsive">
                    <table id="UnithowHisTable" class="table table-bordered" style="width:100%;">
                        <thead>
                            <tr>
                                <th><%=MyBase.GetResourceString("C_ModifiedField")%></th>
                                <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                                <th><%=MyBase.GetResourceString("C_NewValue")%></th>
                                <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                                <th><%=MyBase.GetResourceString("C_ModifiedBy")%></th>
                            </tr>
                        </thead>
                        <tbody id="benchHistoryTableBody">
                        </tbody>
                    </table>
                </div>
                </div><!-- /.bench-history-table-area -->
                <div class="pagination-container bench-history-pagination">
                    <div style="color: #374151; font-size: 11.5px;">
                        <span id="benchHistoryTotalRecords"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
                    </div>
                    <div style="display: flex; gap: 0.5rem;">
                        <button type="button" id="benchHistoryPrevBtn" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px;">
                            <i class="fas fa-angle-double-left"></i>
                        </button>
                        <button type="button" id="benchHistoryNextBtn" title="<%=MyBase.GetResourceString("C_NextPage")%>" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px;">
                            <i class="fas fa-angle-double-right"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- History Offcanvas ends -->
    </div><!-- /.bench-page-shell -->
    <%Else%>
    <div class="bgwhite bench-page-shell">
        <div class="container-fluid py-2">
            <p class="bench-no-access-msg"><%=MyBase.GetResourceString("C_ViewAccess")%></p>
        </div>
    </div>
    <%End If%>

        <!-- More Details Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
            id="UnitOffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">

                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center font-weight-600">
                                <span>Status Details</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="CustGroupEdtTab" class="CustGroupInfo">
                    <div class="row">
                        <div class="col-sm-6">&nbsp;</div>
                        <div class="col-sm-6">
                            <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                                <button class="btn btnyellow" id="saveCustGpBtn" data-bs-toggle="tooltip"
                                    title="Save">Save</button>
                                <%End If%>
                                <%If m_blnDeleteAccess = True Then%>
                                <button class="btn borderbtn" id="DeleteCustGpBtn" data-bs-toggle="tooltip" title="Delete">Delete</button>
                                <%End If%>
                                <button class="btn borderbtn" type="button" id="closeCustGpBtn" data-bs-dismiss="offcanvas"
                                    aria-label="Close" data-bs-toggle="tooltip" title="Close">Close</button>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red">*</font>
                                Mandatory)</label>
                        </div>
                    </div>

                    <div class="custGroupEdtInfo mb-2">
                        <div class="addCGContent">
                            <div class="row form-group mt-3">
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <div class="col-sm-5 text-end">
                                            <label class="required">Status Name</label>
                                        </div>
                                        <div class="col-sm-7 text-start">
                                            <input type="text" class="form-control" id="UnitEdtInput" maxlength="50" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-2"></div>
                              
                                <div class="col-sm-6 mb-2">
                                    <div class="row mb-1">
                                        <label for="RegActiveChk" class="col-sm-5 control-label text-end">Active</label>
                                        <div class="col-sm-7">
                                            <div class="custom_chckbox">
                                                <input id="RegActiveChk" class="" type="checkbox" checked="">
                                                <label for="RegActiveChk"></label>
                                            </div>
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
        <!-- More Details Offcanvas Section ends -->

    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="svFilterAs">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="Issuesavrefilterbox" class="box-panel">
                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end">Filter Name :</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" name="" /><br />
                                            <div class="btnrow">
                                                <button id="sveFilterbtn"
                                                    class="btn btnyellow float-start">Save</button>
                                                <button data-bs-dismiss="modal"
                                                    class="btn canclesaveasbtn borderbtn float-end">Cancel</button>
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
        </div>
    </div>
    <!-- Save filter Modal End here-->

    <!-- Edit Country Modal start here-->
    <div class="modal custmodal fade" id="EdtCountryModal" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Country</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="CustGroupEdtTab" class="CustGroupInfo">
                        <div class="row ">
                            <div class="col-sm-12 text-end">
                                <label class="form-label ">(<font color="red">*</font>
                                    Mandatory)</label>
                            </div>
                        </div>
    
                        <div class="custGroupEdtInfo">
                            <div class="addCGContent">
                                <div class="row form-group mt-3">
                                    <div class="col-sm-6">
                                        <div class="row mb-1">
                                            <div class="col-sm-6 text-end">
                                                <label class="required">Country</label>
                                            </div>
                                            <div class="col-sm-6 text-start">
                                                <!-- <input type="text" class="form-control" id="custGroupEdtInput" /> -->
                                                <input type="text" class="form-control" id="CountryEdtInput" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 d-none">
                                        <div class="row mb-1">
                                            <label for="ActiveChk" class="col-sm-5 control-label text-end">Active</label>
                                            <div class="col-sm-7">
                                                <div class="custom_chckbox">
                                                    <input id="ActiveChk" class="" type="checkbox" checked="">
                                                    <label for="ActiveChk"></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="form-group text-center mt-5">
                        <button class="btn btnyellow" id="saveContryBtn" data-bs-toggle="tooltip" title="Save">Save</button>
                        <button class="btn borderbtn" id="DeleteContryBtn" data-bs-toggle="tooltip" title="Delete">Delete</button>
                        <button class="btn borderbtn" id="cancelContryBtn" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="Cancel">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit Country modal end here-->

    <!-- Active Alert modal start here-->
    <div id="activeAlertModal" class="modal fade custmodal" role="dialog" aria-hidden="false">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title"><i class="far fa-check-circle confirmIcn me-2"></i> Confirmation</h4>
                </div>

                <div class="modal-body">
                    <p class="text-center">Are you sure you want to make this inactive?</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Active Alert modal end here-->

    <!-- Delete Bench Status confirmation modal (same layout as PM_TrainingPlan.aspx #deleteConfirm) -->
    <div id="benchDeleteStatusModal" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog ui-draggable">
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" data-bs-toggle="tooltip" data-bs-placement="top" title="Cancel">&times;</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_Confirmation")%></h4>
                </div>
                <div class="modal-body">
                    <p id="benchDeleteStatusMsg" class="text-center mb-0"><%=MyBase.GetResourceString("A_DelBenchStatusGeneric")%></p>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn borderbtn uncheckbtn me-2" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_No")%></button>
                    <button type="button" class="btn btnyellow" id="benchDeleteStatusYes" data-bs-dismiss="modal" title=""><%=MyBase.GetResourceString("C_Yes")%></button>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Delete Bench Status confirmation modal end -->

    <!-- Unmapped Alert for Country Modal start here-->
    <div id="UnmappedAlertModal" class="modal fade custmodal" role="dialog" aria-hidden="false">
        <div class="modal-dialog modalsmall ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title"><i class="far fa-check-circle confirmIcn me-2"></i> Confirmation</h4>
                </div>

                <div class="modal-body">
                    <p class="text-center">Are you sure you want to unmapped this country?</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" data-bs-dismiss="modal">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- Unmapped Alert for Country modal end here-->


    <div class="clearfix"></div>

    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>

    <script>
        // Added by Vyankat B. on 20-05-2026 – API integration (same pattern as PM_TrainingPlan.aspx)
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString()%>';
        var UserName = '<%= Session("strUserName") %>';
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';

        var canAddAccess = !!document.getElementById('canAddBenchStatusFlag');
        var canEditAccess = !!document.getElementById('canEditBenchStatusFlag');
        var canDeleteAccess = !!document.getElementById('canDeleteBenchStatusFlag');
        var canViewAccess = !!document.getElementById('canViewBenchStatusFlag');

        var benchSelectedStatusID = null;
        var benchCurrentPage = 1;
        var benchPageSize = 5;
        var benchTotalRecords = 0;
        var benchTotalPages = 0;
        var benchHistoryPageNumber = 1;
        var benchHistoryRecordsPerPage = 5;
        var benchHistoryTotalRecords = 0;
        var benchHistoryTotalPages = 0;

        /* Resource strings – RM_BenchStatusMaster.resx (same pattern as PM_TrainingPlan.aspx) */
        var benchResTotalRecords = '<%=MyBase.GetResourceString("C_TotalRecords")%>';
        var benchResYes = '<%=MyBase.GetResourceString("C_Yes")%>';
        var benchResNo = '<%=MyBase.GetResourceString("C_No")%>';
        var benchResActive = '<%=MyBase.GetResourceString("C_Active")%>';
        var benchResInactive = '<%=MyBase.GetResourceString("C_Inactive")%>';
        var benchResInActive = '<%=MyBase.GetResourceString("C_StatusInActive")%>';
        var benchResHistory = '<%=MyBase.GetResourceString("C_History")%>';
        var benchResNoHistory = '<%=MyBase.GetResourceString("C_NoHistoryAvailable")%>';
        var benchResEdit = '<%=MyBase.GetResourceString("C_Edit")%>';
        var benchResDelete = '<%=MyBase.GetResourceString("C_Delete")%>';
        var benchResSave = '<%=MyBase.GetResourceString("C_Save")%>';
        var benchResAdd = '<%=MyBase.GetResourceString("C_Add")%>';
        var benchResCancel = '<%=MyBase.GetResourceString("C_Cancel")%>';
        var benchResSelectModifiedField = '<%=MyBase.GetResourceString("C_SelectModifiedField")%>';
        var benchResSelectModifiedBy = '<%=MyBase.GetResourceString("C_SelectModifiedBy")%>';
        var benchResDelNamed = '<%=MyBase.GetResourceString("A_DelBenchStatusNamed")%>';
        var benchResDelGeneric = '<%=MyBase.GetResourceString("A_DelBenchStatusGeneric")%>';
        var benchResAuthFailed = '<%=MyBase.GetResourceString("A_AuthenticationFailed")%>';
        var benchResFailedInsert = '<%=MyBase.GetResourceString("A_FailedInsert")%>';
        var benchResInsertSuccess = '<%=MyBase.GetResourceString("A_InsertSuccess")%>';
        var benchResUpdateSuccess = '<%=MyBase.GetResourceString("A_UpdateSuccess")%>';
        var benchResUpdateFailed = '<%=MyBase.GetResourceString("A_UpdateFailed")%>';
        var benchResDeleteSuccess = '<%=MyBase.GetResourceString("A_DeleteSuccess")%>';
        var benchResDeleteFailed = '<%=MyBase.GetResourceString("A_DeleteFailed")%>';
        var benchResNoRecordsFound = '<%=MyBase.GetResourceString("A_NoRecordsFound")%>';
        var benchResNoHistoryFound = '<%=MyBase.GetResourceString("A_NoHistoryFound")%>';
        var benchResBenchStatusCharacter = '<%=MyBase.GetResourceString("A_BenchStatusCharacter")%>';
        var benchResCharat = '<%=MyBase.GetResourceString("A_Charat")%>';
        var benchResBenchStatusBlank = '<%=MyBase.GetResourceString("A_BenchStatusBlank")%>';
        var benchResStatusName = '<%=MyBase.GetResourceString("C_StatusName")%>';

        // Loader state (used by showLoader / hideLoader)
        var loaderShown = false;
        var loaderStartTime = 0;



        //Added By Gauri - Loader functions
        function showLoader() {
            document.getElementById('loaderOverlay').style.display = 'block';
            loaderShown = true;
            loaderStartTime = Date.now();
        }

        function hideLoader() {
            if (!loaderShown) return;

            var elapsedTime = Date.now() - loaderStartTime;
            var minDisplayTime = 1500; // Minimum 1.5 seconds

            if (elapsedTime < minDisplayTime) {
                setTimeout(function () {
                    document.getElementById('loaderOverlay').style.display = 'none';
                    loaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                document.getElementById('loaderOverlay').style.display = 'none';
                loaderShown = false;
            }
        }

        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
                var isSpecialCharacter = 0;
                for (var i = 0; i < regularExpression.length; i++) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1;
                    }
                }
                return isSpecialCharacter === 1;
            }
            return false;
        }

        function benchValidateStatusName(name, $focusEl) {
            var val = (name || '').trim();
            if (!val) {
                benchNotifyError(benchResBenchStatusBlank);
                if ($focusEl && $focusEl.length) {
                    $focusEl.focus();
                }
                return false;
            }
            if (checkSpecialCharacter(val, WebConfigSpecialCharacters)) {
                benchNotifyError(benchResBenchStatusCharacter + ' ' + WebConfigSpecialCharacters + ' ' + benchResCharat);
                if ($focusEl && $focusEl.length) {
                    $focusEl.focus();
                }
                return false;
            }
            return true;
        }

        function AJAXCallWithResult(url, param, async) {
            var result = null;
            var fullUrl = strUrl.endsWith('/') ? strUrl + url : strUrl + '/' + url;

            $.ajax({
                url: fullUrl,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(typeof isJson === 'function' && isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    result = data;
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        benchNotifyError(benchResAuthFailed);
                    } else if (xhr.status === 400 && xhr.responseJSON) {
                        result = xhr.responseJSON;
                    } else {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(error || status);
                    }
                }
            });

            if (!async) {
                return result;
            }
            return null;
        }

        function benchPrepareAlertify() {
            if (typeof alertify === 'undefined') {
                return false;
            }
            alertify.set('notifier', 'position', 'top-right');
            return true;
        }

        function benchNotifySuccess(msg) {
            if (!benchPrepareAlertify()) {
                return;
            }
            var successMessage = benchEscapeHtml(msg || '');
            alertify.success("<span style='font-size:14px;'>" + successMessage + "</span>");
        }

        function benchNotifyError(msg) {
            if (!benchPrepareAlertify()) {
                alert(msg);
                return;
            }
            var errorMessage = benchEscapeHtml(msg || '');
            alertify.error("<span style='font-size:14px;'>" + errorMessage + "</span>");
        }

        function benchFirstArray(source) {
            if (!source) return [];
            if (Array.isArray(source)) return source;
            if (Array.isArray(source.data)) return source.data;
            return [];
        }

        function benchExtractDropdownRows(response, typeName) {
            if (!response) return [];
            if (Array.isArray(response)) return response;

            var rows = benchGetSpResultRows(response, typeName);
            if (rows.length) return rows;

            var data = response.data || response.Data;
            if (!data) return [];

            if (Array.isArray(data)) return data;

            if (typeof data === 'object') {
                rows = benchGetSpResultRows(data, typeName);
                if (rows.length) return rows;
                var keys = Object.keys(data);
                for (var i = 0; i < keys.length; i++) {
                    if (Array.isArray(data[keys[i]])) {
                        return data[keys[i]];
                    }
                }
            }
            return [];
        }

        function benchRefreshSelectPicker($select) {
            if (!$select || !$select.length || !$.fn.selectpicker) return;
            if ($select.parent().hasClass('bootstrap-select')) {
                $select.selectpicker('destroy');
            }
            $select.selectpicker({ liveSearch: true, width: '100%' });
        }

        function benchGetSpResultRows(response, typeName) {
            if (!response) return [];
            if (Array.isArray(response.result)) return response.result;
            if (Array.isArray(response.Result)) return response.Result;
            var resultObj = response.result || response.Result;
            if (resultObj && typeof resultObj === 'object' && !Array.isArray(resultObj)) {
                if (Array.isArray(resultObj[typeName])) return resultObj[typeName];
                var camelType = typeName.charAt(0).toLowerCase() + typeName.slice(1);
                if (Array.isArray(resultObj[camelType])) return resultObj[camelType];
            }
            if (Array.isArray(response[typeName])) return response[typeName];
            var camel = typeName.charAt(0).toLowerCase() + typeName.slice(1);
            if (Array.isArray(response[camel])) return response[camel];
            return [];
        }

        function benchGetMutationResultRows(response) {
            return benchGetSpResultRows(response, 'BenchStatusMasterInsertResult')
                .concat(benchGetSpResultRows(response, 'BenchStatusMasterUpdateResult'))
                .concat(benchGetSpResultRows(response, 'BenchStatusMasterDeleteResult'));
        }

        function benchIsSuccessResponse(response) {
            var rows = benchGetMutationResultRows(response);
            if (rows.length) {
                var successFlag = rows[0].success != null ? rows[0].success : rows[0].Success;
                return successFlag === 1 || successFlag === '1' || successFlag === true;
            }
            var msg = (response && (response.message || response.Message)) || '';
            return msg.toLowerCase().indexOf('successfully') >= 0;
        }

        function benchGetResponseMessage(response, fallback) {
            var rows = benchGetMutationResultRows(response);
            if (rows.length && (rows[0].message || rows[0].Message)) {
                return rows[0].message || rows[0].Message;
            }
            return (response && (response.message || response.Message)) || fallback;
        }

        function benchEscapeHtml(text) {
            return $('<div>').text(text || '').html();
        }

        function benchParseIsActive(value) {
            if (value === true || value === 1 || value === '1' || value === 'true' || value === 'True') {
                return true;
            }
            if (value === false || value === 0 || value === '0' || value === 'false' || value === 'False') {
                return false;
            }
            return true;
        }

        function benchParseInUse(value) {
            return value === true || value === 1 || value === '1';
        }

        function benchParseIsHistory(value) {
            return value === true || value === 1 || value === '1';
        }

        function benchYesNoToIsActive(yesNo) {
            return yesNo === 'Yes' || yesNo === true || yesNo === 1 || yesNo === '1';
        }

        function benchBuildDataRow(item) {
            var statusId = item.statusID || item.StatusID || 0;
            var name = item.benchStatus || item.BenchStatus || '';
            var isActive = benchParseIsActive(item.isActive != null ? item.isActive : item.IsActive);
            var inUse = benchParseInUse(item.inUse != null ? item.inUse : item.InUse);
            var hasHistory = benchParseIsHistory(item.isHistory != null ? item.isHistory : item.IsHistory);
            var safeName = benchEscapeHtml(name);
            return '<tr class="tblCol" data-status-id="' + statusId + '" data-is-active="' + (isActive ? '1' : '0') + '" data-in-use="' + (inUse ? '1' : '0') + '" data-has-history="' + (hasHistory ? '1' : '0') + '">' +
                '<td class="text-start status-name-cell"><span class="status-name-display">' + safeName + '</span>' +
                '<input type="text" class="form-control form-control-sm status-name-input d-none" maxlength="50" value="' + safeName + '" /></td>' +
                benchActiveCellHtml(isActive) + benchMoreActionCellHtml(hasHistory) + '</tr>';
        }

        function benchParseListResponse(result) {
            var rows = [];
            var pagination = null;
            if (!result) {
                return { rows: rows, pagination: pagination };
            }
            if (Array.isArray(result.data)) {
                rows = result.data;
            }
            if (result.paginationEntities && result.paginationEntities.length > 0) {
                pagination = result.paginationEntities[0];
            }
            return { rows: rows, pagination: pagination };
        }

        function updateBenchPaginationDisplay(isEmpty) {
            var paginationContainer = document.querySelector('.bench-list-pagination');
            if (paginationContainer) {
                paginationContainer.style.display = 'flex';
                paginationContainer.style.visibility = 'visible';
                paginationContainer.style.opacity = '1';
            }

            var totalRecordsSpan = document.getElementById('totalRecords');
            if (totalRecordsSpan) {
                totalRecordsSpan.textContent = benchResTotalRecords + ': ' + (isEmpty ? 0 : (benchTotalRecords || 0));
            }

            var firstPageBtn = document.getElementById('firstPageBtn');
            var lastPageBtn = document.getElementById('lastPageBtn');
            var page = parseInt(benchCurrentPage, 10) || 1;
            var totalPages = parseInt(benchTotalPages, 10) || 0;

            if (firstPageBtn) {
                if (page <= 1) {
                    firstPageBtn.disabled = true;
                    firstPageBtn.style.opacity = '0.5';
                    firstPageBtn.style.cursor = 'not-allowed';
                    firstPageBtn.style.background = '#f8f9fa';
                    firstPageBtn.style.color = '#6c757d';
                } else {
                    firstPageBtn.disabled = false;
                    firstPageBtn.style.opacity = '1';
                    firstPageBtn.style.cursor = 'pointer';
                    firstPageBtn.style.background = 'white';
                    firstPageBtn.style.color = '#3b82f6';
                }
            }

            if (lastPageBtn) {
                if (page >= totalPages || totalPages === 0) {
                    lastPageBtn.disabled = true;
                    lastPageBtn.style.opacity = '0.5';
                    lastPageBtn.style.cursor = 'not-allowed';
                    lastPageBtn.style.background = '#f8f9fa';
                    lastPageBtn.style.color = '#6c757d';
                } else {
                    lastPageBtn.disabled = false;
                    lastPageBtn.style.opacity = '1';
                    lastPageBtn.style.cursor = 'pointer';
                    lastPageBtn.style.background = 'white';
                    lastPageBtn.style.color = '#3b82f6';
                }
            }
        }

        function benchGoToPreviousPage() {
            var page = parseInt(benchCurrentPage, 10) || 1;
            if (page > 1) {
                var prevPage = page - 1;
                benchCurrentPage = prevPage;
                loadBenchStatusMaster(prevPage, benchGetCurrentSearchText());
            }
        }

        function benchGoToNextPage() {
            var page = parseInt(benchCurrentPage, 10) || 1;
            var totalPages = parseInt(benchTotalPages, 10) || 0;
            if (page < totalPages) {
                var nextPage = page + 1;
                benchCurrentPage = nextPage;
                loadBenchStatusMaster(nextPage, benchGetCurrentSearchText());
            }
        }

        function benchGetCurrentSearchText() {
            return ($('#serchUnitInput').val() || '').trim();
        }

        function benchDestroyUnitDataTable() {
            if ($.fn.DataTable.isDataTable('#UnitTable')) {
                $('#UnitTable').DataTable().destroy(false);
            }
        }

        function benchInitUnitDataTable() {
            $('#UnitTable').dataTable({
                scrollY: false,
                scrollX: false,
                paging: false,
                bPaginate: false,
                bLengthChange: false,
                bFilter: false,
                ordering: false,
                responsive: false,
                destroy: false,
                retrieve: true,
                bAutoWidth: false,
                info: false,
                columnDefs: [
                    { orderable: false, targets: '_all' },
                    { width: '100px', targets: 1 },
                    { width: '140px', targets: 2 }
                ],
                language: {
                    emptyTable: benchResNoRecordsFound
                }
            });
            $('.dataTables_paginate').hide();
            benchSyncUnitTableLayout();
            benchInitRowTooltips($('#UnitTable_wrapper'));
        }

        function benchSyncUnitTableLayout() {
            if (!$.fn.DataTable.isDataTable('#UnitTable')) {
                return;
            }
            var api = $('#UnitTable').DataTable();
            api.columns.adjust();
            $('#UnitTable_wrapper').css({ width: '100%', maxWidth: '100%' });
            $('#UnitTable').css('width', '100%');
        }

        function loadBenchStatusMaster(pageNumber, searchText) {
            var requestedPage = parseInt(pageNumber, 10);
            if (isNaN(requestedPage) || requestedPage < 1) {
                requestedPage = 1;
            }
            benchCurrentPage = requestedPage;

            var param = JSON.stringify({
                StatusID: null,
                IsActive: null,
                Search: searchText || '',
                PageNumber: requestedPage,
                PageSize: benchPageSize
            });

            var result = AJAXCallWithResult('api/RM_BenchStsMaster/GetBenchStatusMaster', param, false);
            var parsed = benchParseListResponse(result);
            var rows = parsed.rows;
            var pagination = parsed.pagination;

            if (pagination) {
                var apiPage = parseInt(pagination.currentPage || pagination.CurrentPage, 10);
                if (!isNaN(apiPage) && apiPage > 0) {
                    benchCurrentPage = apiPage;
                }
                benchPageSize = parseInt(pagination.pageSize || pagination.PageSize, 10) || benchPageSize;
                benchTotalRecords = parseInt(pagination.totalRecords || pagination.TotalRecords, 10) || 0;
                benchTotalPages = parseInt(pagination.totalPages || pagination.TotalPages, 10) || 0;
            } else {
                benchTotalRecords = rows ? rows.length : 0;
                benchTotalPages = benchTotalRecords > 0 ? Math.ceil(benchTotalRecords / benchPageSize) : 0;
            }

            benchDestroyUnitDataTable();

            var $body = $('#benchStatusTableBody');
            $body.find('tr.tblCol, tr.bench-empty-row').remove();

            if (rows && rows.length > 0) {
                rows.forEach(function (item) {
                    $body.append(benchBuildDataRow(item));
                });
                updateBenchPaginationDisplay(false);
                benchInitUnitDataTable();
            } else {
                $body.append(
                    '<tr class="bench-empty-row">' +
                    '<td colspan="3" class="bench-empty-msg">' + benchEscapeHtml(benchResNoRecordsFound) + '</td>' +
                    '</tr>'
                );
                updateBenchPaginationDisplay(true);
            }
        }

        function insertBenchStatusMaster(benchStatus, isActive, onSuccess, $focusEl) {
            if (!canAddAccess) return false;
            if (typeof isActive === 'function') {
                onSuccess = isActive;
                isActive = true;
                $focusEl = null;
            }
            if (!benchValidateStatusName(benchStatus, $focusEl)) {
                return false;
            }
            benchStatus = (benchStatus || '').trim();
            var param = JSON.stringify({
                BenchStatus: benchStatus,
                IsActive: benchYesNoToIsActive(isActive),
                CreatedBy: UserName
            });
            var response = AJAXCallWithResult('api/RM_BenchStsMaster/InsertBenchStatusMaster', param, false);

            if (!response) {
                benchNotifyError(benchResFailedInsert);
                return false;
            }

            var result = response.result || response.Result || [];
            var row = result.length > 0 ? result[0] : null;
            var successMessage = (row && (row.message || row.Message))
                || response.message
                || response.Message
                || benchResInsertSuccess;
            var isSuccess = row
                ? (row.success === 1 || row.success === '1' || row.Success === 1)
                : (String(successMessage).toLowerCase().indexOf('successfully') >= 0);

            if (isSuccess) {
                benchNotifySuccess(successMessage);
                if (onSuccess) onSuccess();
                return response;
            }
            benchNotifyError(successMessage);
            return false;
        }

        function updateBenchStatusMaster(statusID, benchStatus, isActive, onSuccess, $focusEl) {
            if (!canEditAccess) return false;
            if (typeof isActive === 'function') {
                onSuccess = isActive;
                isActive = true;
                $focusEl = null;
            }
            if (!benchValidateStatusName(benchStatus, $focusEl)) {
                return false;
            }
            benchStatus = (benchStatus || '').trim();
            var param = JSON.stringify({
                StatusID: parseInt(statusID, 10),
                BenchStatus: benchStatus,
                IsActive: benchYesNoToIsActive(isActive),
                ModifiedBy: UserName
            });
            var response = AJAXCallWithResult('api/RM_BenchStsMaster/UpdateBenchStatusMaster', param, false);
            if (benchIsSuccessResponse(response)) {
                benchNotifySuccess(benchGetResponseMessage(response, benchResUpdateSuccess));
                if (onSuccess) onSuccess();
                return true;
            }
            benchNotifyError(benchGetResponseMessage(response, benchResUpdateFailed));
            return false;
        }

        function deleteBenchStatusMaster(statusID, onSuccess) {
            if (!canDeleteAccess) return false;
            var param = JSON.stringify({ StatusID: parseInt(statusID, 10) });
            var response = AJAXCallWithResult('api/RM_BenchStsMaster/DeleteBenchStatusMaster', param, false);
            if (benchIsSuccessResponse(response)) {
                benchNotifySuccess(benchGetResponseMessage(response, benchResDeleteSuccess));
                if (onSuccess) onSuccess();
                return true;
            }
            benchNotifyError(benchGetResponseMessage(response, benchResDeleteFailed));
            return false;
        }

        function benchBindHistoryFilters(statusID) {
            var filterParam = JSON.stringify({ StatusID: statusID || null });

            var fieldResult = AJAXCallWithResult('api/RM_BenchStsMaster/GetBenchStatusModifiedField', filterParam, false);
            var fieldRows = benchExtractDropdownRows(fieldResult, 'BenchStatusModifiedFieldRow');

            var $field = $('#modifiedHisField');
            $field.empty().append('<option value="">' + benchEscapeHtml(benchResSelectModifiedField) + '</option>');
            fieldRows.forEach(function (row) {
                var val = row.modifiedField || row.ModifiedField;
                if (val) {
                    $field.append('<option value="' + benchEscapeHtml(val) + '">' + benchEscapeHtml(benchFormatHistoryModifiedField(val)) + '</option>');
                }
            });
            $field.val('');
            benchRefreshSelectPicker($field);

            var byResult = AJAXCallWithResult('api/RM_BenchStsMaster/GetBenchStatusModifiedBy', filterParam, false);
            var byRows = benchExtractDropdownRows(byResult, 'BenchStatusModifiedByRow');

            var $by = $('#modifiedHisBy');
            $by.empty().append('<option value="">' + benchEscapeHtml(benchResSelectModifiedBy) + '</option>');
            byRows.forEach(function (row) {
                var val = row.modifiedBy || row.ModifiedBy;
                if (val) {
                    $by.append('<option value="' + benchEscapeHtml(val) + '">' + benchEscapeHtml(val) + '</option>');
                }
            });
            $by.val('');
            benchRefreshSelectPicker($by);
        }

        function benchFormatHistoryModifiedField(modifiedField) {
            var fieldName = (modifiedField || '').toString().trim().toLowerCase();
            if (fieldName === 'benchstatus') {
                return benchResStatusName;
            }
            if (fieldName === 'isactive') {
                return benchResActive;
            }
            return (modifiedField || '').toString();
        }

        function benchFormatHistoryModifiedDate(modDate) {
            if (!modDate) {
                return '';
            }
            var d = new Date(modDate);
            if (isNaN(d.getTime())) {
                return '';
            }
            var datePart = d.toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
            var hours = d.getHours().toString().padStart(2, '0');
            var minutes = d.getMinutes().toString().padStart(2, '0');
            return datePart + ', ' + hours + ':' + minutes;
        }

        function benchFormatHistoryDisplayValue(modifiedField, value) {
            if (value === null || value === undefined) {
                return '';
            }
            var fieldName = (modifiedField || '').toString().trim().toLowerCase();
            if (fieldName === 'isactive') {
                var textVal = value.toString().trim().toLowerCase();
                if (value === true || value === 1 || textVal === '1' || textVal === 'true' || textVal === 'yes' || textVal === 'active') {
                    return benchResYes;
                }
                if (value === false || value === 0 || textVal === '0' || textVal === 'false' || textVal === 'no' ||
                    textVal === 'inactive' || textVal === 'in active') {
                    return benchResNo;
                }
            }
            return value.toString();
        }

        function benchParseHistoryResponse(result) {
            var rows = [];
            var pagination = null;
            if (!result) {
                return { rows: rows, pagination: pagination };
            }
            if (Array.isArray(result.data)) {
                rows = result.data;
            }
            if (result.paginationEntities && result.paginationEntities.length > 0) {
                pagination = result.paginationEntities[0];
            }
            return { rows: rows, pagination: pagination };
        }

        function updateBenchHistoryPaginationDisplay(isEmpty) {
            var totalSpan = document.getElementById('benchHistoryTotalRecords');
            if (totalSpan) {
                totalSpan.textContent = benchResTotalRecords + ': ' + (isEmpty ? 0 : (benchHistoryTotalRecords || 0));
            }

            var page = parseInt(benchHistoryPageNumber, 10) || 1;
            var totalPages = parseInt(benchHistoryTotalPages, 10) || 0;
            var prevBtn = document.getElementById('benchHistoryPrevBtn');
            var nextBtn = document.getElementById('benchHistoryNextBtn');

            if (prevBtn) {
                if (page <= 1) {
                    prevBtn.disabled = true;
                    prevBtn.style.opacity = '0.5';
                    prevBtn.style.cursor = 'not-allowed';
                    prevBtn.style.background = '#f8f9fa';
                    prevBtn.style.color = '#6c757d';
                } else {
                    prevBtn.disabled = false;
                    prevBtn.style.opacity = '1';
                    prevBtn.style.cursor = 'pointer';
                    prevBtn.style.background = 'white';
                    prevBtn.style.color = '#3b82f6';
                }
            }

            if (nextBtn) {
                if (page >= totalPages || totalPages === 0) {
                    nextBtn.disabled = true;
                    nextBtn.style.opacity = '0.5';
                    nextBtn.style.cursor = 'not-allowed';
                    nextBtn.style.background = '#f8f9fa';
                    nextBtn.style.color = '#6c757d';
                } else {
                    nextBtn.disabled = false;
                    nextBtn.style.opacity = '1';
                    nextBtn.style.cursor = 'pointer';
                    nextBtn.style.background = 'white';
                    nextBtn.style.color = '#3b82f6';
                }
            }
        }

        function benchDestroyHistoryDataTable() {
            if ($.fn.DataTable.isDataTable('#UnithowHisTable')) {
                $('#UnithowHisTable').DataTable().destroy(false);
            }
        }

        function benchInitHistoryDataTable() {
            $('#UnithowHisTable').dataTable({
                paging: false,
                bPaginate: false,
                bLengthChange: false,
                bFilter: false,
                ordering: false,
                responsive: false,
                destroy: false,
                retrieve: true,
                bAutoWidth: false,
                info: false,
                columnDefs: [
                    { orderable: false, targets: '_all' },
                    { width: '120px', targets: 0 },
                    { width: '160px', targets: 1 },
                    { width: '160px', targets: 2 },
                    { width: '115px', targets: 3 },
                    { width: '100px', targets: 4 }
                ],
                language: {
                    emptyTable: ''
                }
            });
            $('#UnithowHisTable_wrapper .dataTables_paginate, #UnithowHisTable_wrapper .dataTables_info').hide();
            if ($.fn.DataTable.isDataTable('#UnithowHisTable')) {
                $('#UnithowHisTable').DataTable().columns.adjust();
            }
        }

        function benchReloadHistoryPanel() {
            if (!benchSelectedStatusID) return;
            benchHistoryPageNumber = 1;
            benchBindHistoryFilters(benchSelectedStatusID);
            loadBenchStatusHistory();
        }

        function benchGoToHistoryPreviousPage() {
            var page = parseInt(benchHistoryPageNumber, 10) || 1;
            if (page > 1) {
                benchHistoryPageNumber = page - 1;
                loadBenchStatusHistory();
            }
        }

        function benchGoToHistoryNextPage() {
            var page = parseInt(benchHistoryPageNumber, 10) || 1;
            var totalPages = parseInt(benchHistoryTotalPages, 10) || 0;
            if (page < totalPages) {
                benchHistoryPageNumber = page + 1;
                loadBenchStatusHistory();
            }
        }

        function loadBenchStatusHistory() {
            if (!benchSelectedStatusID) return;

            var modifiedField = $('#modifiedHisField').val() || '';
            var modifiedBy = $('#modifiedHisBy').val() || '';
            if (modifiedField === benchResSelectModifiedField) modifiedField = '';
            if (modifiedBy === benchResSelectModifiedBy) modifiedBy = '';

            var requestedPage = parseInt(benchHistoryPageNumber, 10);
            if (isNaN(requestedPage) || requestedPage < 1) {
                requestedPage = 1;
            }
            benchHistoryPageNumber = requestedPage;

            var param = JSON.stringify({
                StatusID: parseInt(benchSelectedStatusID, 10),
                ModifiedField: modifiedField,
                ModifiedBy: modifiedBy,
                PageNumber: requestedPage,
                PageSize: benchHistoryRecordsPerPage
            });

            var result = AJAXCallWithResult('api/RM_BenchStsMaster/GetBenchStatusHistory', param, false);
            var parsed = benchParseHistoryResponse(result);
            var rows = parsed.rows;
            var pagination = parsed.pagination;

            if (pagination) {
                var apiPage = parseInt(pagination.currentPage || pagination.CurrentPage, 10);
                if (!isNaN(apiPage) && apiPage > 0) {
                    benchHistoryPageNumber = apiPage;
                }
                benchHistoryTotalRecords = parseInt(pagination.totalRecords || pagination.TotalRecords, 10) || 0;
                benchHistoryTotalPages = parseInt(pagination.totalPages || pagination.TotalPages, 10) || 0;
                if (benchHistoryTotalPages === 0 && benchHistoryTotalRecords > 0) {
                    benchHistoryTotalPages = Math.ceil(benchHistoryTotalRecords / benchHistoryRecordsPerPage);
                }
            } else {
                benchHistoryTotalRecords = rows ? rows.length : 0;
                benchHistoryTotalPages = benchHistoryTotalRecords > 0
                    ? Math.ceil(benchHistoryTotalRecords / benchHistoryRecordsPerPage)
                    : 0;
            }

            benchDestroyHistoryDataTable();

            var $tbody = $('#benchHistoryTableBody');
            $tbody.empty();

            if (rows && rows.length > 0) {
                rows.forEach(function (entry) {
                    var modField = entry.modifiedField || entry.ModifiedField || '';
                    var modFieldDisplay = benchFormatHistoryModifiedField(modField);
                    var oldDisplay = benchFormatHistoryDisplayValue(modField, entry.oldValue != null ? entry.oldValue : entry.OldValue);
                    var newDisplay = benchFormatHistoryDisplayValue(modField, entry.newValue != null ? entry.newValue : entry.NewValue);
                    var modDate = entry.modifiedDate || entry.ModifiedDate;
                    var dateText = benchFormatHistoryModifiedDate(modDate);
                    $tbody.append(
                        '<tr class="bench-history-data-row">' +
                        '<td>' + benchEscapeHtml(modFieldDisplay) + '</td>' +
                        '<td>' + benchEscapeHtml(oldDisplay) + '</td>' +
                        '<td>' + benchEscapeHtml(newDisplay) + '</td>' +
                        '<td>' + benchEscapeHtml(dateText) + '</td>' +
                        '<td>' + benchEscapeHtml(entry.modifiedBy || entry.ModifiedBy || '') + '</td>' +
                        '</tr>'
                    );
                });
                updateBenchHistoryPaginationDisplay(false);
            } else {
                $tbody.append(
                    '<tr class="bench-history-empty-row">' +
                    '<td></td><td></td><td class="text-center text-muted">' + benchEscapeHtml(benchResNoHistoryFound) + '</td><td></td><td></td>' +
                    '</tr>'
                );
                updateBenchHistoryPaginationDisplay(true);
            }

            benchInitHistoryDataTable();
            $(".table").resize();
        }

        var benchSearchTimer = null;

        function benchTriggerSearch() {
            var searchText = benchGetCurrentSearchText();
            loadBenchStatusMaster(1, searchText);
        }

        function benchBindSearchBox() {
            $('#serchUnitInput').off('input.benchSearch keypress.benchSearch');
            $('#serchUnitBtn').off('click.benchSearch');

            $('#serchUnitInput').on('input.benchSearch', function () {
                clearTimeout(benchSearchTimer);
                benchSearchTimer = setTimeout(benchTriggerSearch, 400);
            });

            $('#serchUnitInput').on('keypress.benchSearch', function (e) {
                if (e.which === 13) {
                    e.preventDefault();
                    clearTimeout(benchSearchTimer);
                    benchTriggerSearch();
                }
            });

            $('#serchUnitBtn').on('click.benchSearch', function (e) {
                e.preventDefault();
                clearTimeout(benchSearchTimer);
                benchTriggerSearch();
            });
        }

        $(function () {
            benchPrepareAlertify();
            if (!canViewAccess) return;
            benchInitRowTooltips();
            if ($.fn.selectpicker) {
                $('#modifiedHisField, #modifiedHisBy').selectpicker();
            }
            $("#ProjProfSec").hide();
            benchBindSearchBox();
            loadBenchStatusMaster(1, '');
           

        });

        function benchHistoryActionHtml(hasHistory) {
            if (hasHistory) {
                return '<a href="javascript:;" class="bench-history-row bench-history-enabled" data-bs-toggle="offcanvas" data-bs-target="#UnitHistoryOffcanvas" aria-controls="UnitHistoryOffcanvas">' +
                    '<i class="fas fa-history" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="' + benchEscapeHtml(benchResHistory) + '"></i></a>';
            }
            return '<span class="bench-history-row bench-history-disabled" aria-disabled="true">' +
                '<i class="fas fa-history" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="' + benchEscapeHtml(benchResNoHistory) + '"></i></span>';

        }

        function benchMoreActionCellHtml(hasHistory) {
            var editHtml = canEditAccess
                ? '<a href="javascript:;" class="bench-edit-row"><i class="fas fa-pen" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="' + benchEscapeHtml(benchResEdit) + '"></i></a>'
                : '';
            var deleteHtml = canDeleteAccess
                ? '<a href="javascript:;" class="bench-delete-row"><i class="fas fa-trash-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="' + benchEscapeHtml(benchResDelete) + '"></i></a>'
                : '';
            var saveCancelHtml = canEditAccess
                ? '<div class="addNewBtns d-flex justify-content-center gap-3 bench-row-actions-edit d-none">' +
                '<i class="fas fa-check clickYes bench-save-row" data-bs-toggle="tooltip" title="' + benchEscapeHtml(benchResSave) + '"></i>' +
                '<i class="fas fa-times clickNo bench-cancel-row" data-bs-toggle="tooltip" title="' + benchEscapeHtml(benchResCancel) + '"></i>' +
                '</div>'
                : '';
            return '<td class="bench-more-action-cell">' +
                '<div class="d-flex justify-content-center align-items-center gap-2 bench-row-actions bench-row-actions-view">' +
                editHtml +
                benchHistoryActionHtml(hasHistory) +
                deleteHtml +
                '</div>' +
                saveCancelHtml +
                '</td>';
        }

        function benchInitRowTooltips($scope) {
            var $root = $scope || $(document);
            $root.find('[data-bs-toggle="tooltip"]').each(function () {
                var tip = bootstrap.Tooltip.getInstance(this);
                if (tip) tip.dispose();
                new bootstrap.Tooltip(this, {
                    placement: $(this).attr('data-bs-placement') || 'top',
                    container: $(this).attr('data-bs-container') || 'body',
                    trigger: 'hover focus'
                });
            });
        }

        function benchDisposeTooltip(el) {
            if (!el) return;
            var tip = bootstrap.Tooltip.getInstance(el);
            if (tip) tip.dispose();
        }

        function benchSetAddRowYesTooltipEnabled(isEnabled) {
            var el = document.getElementById('clickYes1');
            if (!el) return;
            benchDisposeTooltip(el);
            if (isEnabled) {
                el.setAttribute('data-bs-toggle', 'tooltip');
                el.setAttribute('data-bs-placement', 'top');
                el.setAttribute('data-bs-container', 'body');
                el.setAttribute('title', benchResAdd);
                new bootstrap.Tooltip(el, {
                    placement: 'top',
                    container: 'body',
                    trigger: 'hover focus'
                });
            } else {
                el.removeAttribute('data-bs-toggle');
                el.removeAttribute('title');
                el.removeAttribute('data-bs-placement');
                el.removeAttribute('data-bs-container');
            }
        }

        function benchInitAddRowActionTooltips() {
            benchInitRowTooltips($('#clickNo1').closest('.addNewBtns'));
            benchSetAddRowYesTooltipEnabled(!$('#clickYes1').hasClass('disableIcn'));
        }

        function benchGetRowActiveValue($row) {
            if ($row.find('.bench-active-select').length && !$row.find('.bench-active-select').hasClass('d-none')) {
                return $row.find('.bench-active-select').val() || 'Yes';
            }
            var dataActive = $row.data('is-active');
            if (dataActive !== undefined) {
                return dataActive === 1 || dataActive === '1' ? 'Yes' : 'No';
            }
            return $row.find('.bench-active-display .activeIcn').length ? 'Yes' : 'No';
        }

        function benchActiveCellHtml(isYes) {
            var iconClass = isYes ? 'activeIcn' : 'inactiveIcn';
            var iconTitle = isYes ? benchResActive : benchResInactive;
            var selYes = isYes ? ' selected' : '';
            var selNo = isYes ? '' : ' selected';
            return '<td class="bench-active-cell text-center">' +
                '<span class="bench-active-display"><i class="fas fa-dot-circle ' + iconClass + '" data-bs-toggle="tooltip" title="' + benchEscapeHtml(iconTitle) + '"></i></span>' +
                '<select class="form-select form-select-sm bench-active-select d-none">' +
                '<option value="Yes"' + selYes + '>' + benchEscapeHtml(benchResYes) + '</option><option value="No"' + selNo + '>' + benchEscapeHtml(benchResNo) + '</option></select></td>';
        }

        function benchSetActiveDisplay($row, value) {
            var isYes = value === 'Yes';
            var iconClass = isYes ? 'activeIcn' : 'inactiveIcn';
            var iconTitle = isYes ? benchResActive : benchResInactive;
            var $cell = $row.find('.bench-active-cell');
            if (!$cell.length) {
                $row.find('td').eq(1).replaceWith(benchActiveCellHtml(isYes));
                benchInitRowTooltips($row);
                return;
            }
            $row.find('.bench-active-display').html(
                '<i class="fas fa-dot-circle ' + iconClass + '" data-bs-toggle="tooltip" title="' + iconTitle + '"></i>'
            );
            $row.find('.bench-active-select').val(value);
            $row.data('is-active', isYes ? '1' : '0');
            benchInitRowTooltips($row.find('.bench-active-display'));
        }

        function benchToggleActiveEdit($row, editing) {
            if (!$row.find('.bench-active-cell').length) {
                var isYes = benchGetRowActiveValue($row) === 'Yes';
                $row.find('td').eq(1).replaceWith(benchActiveCellHtml(isYes));
            }
            if (editing) {
                var activeVal = benchGetRowActiveValue($row);
                $row.find('.bench-active-select').val(activeVal);
                $row.find('.bench-active-display').addClass('d-none');
                $row.find('.bench-active-select').removeClass('d-none');
            } else {
                $row.find('.bench-active-display').removeClass('d-none');
                $row.find('.bench-active-select').addClass('d-none');
            }
        }

        function benchCancelRowEdit($row) {
            var orig = $row.data('orig-name');
            if (orig !== undefined) {
                $row.find('.status-name-display').text(orig);
                $row.find('.status-name-input').val(orig);
            }
            var origActive = $row.data('orig-active');
            if (origActive !== undefined) {
                benchSetActiveDisplay($row, origActive);
            }
            $row.find('.status-name-display').removeClass('d-none');
            $row.find('.status-name-input').addClass('d-none');
            benchToggleActiveEdit($row, false);
            $row.removeClass('row-editing rowhiglight');
            $row.find('.bench-row-actions-view').removeClass('d-none');
            $row.find('.bench-row-actions-edit').addClass('d-none');
            $row.removeData('orig-name');
            $row.removeData('orig-active');
            $(".table").resize();
        }

        function benchStartRowEdit($row) {
            $('#UnitTable tbody tr.tblCol.row-editing').each(function () {
                benchCancelRowEdit($(this));
            });
            var text = $row.find('.status-name-display').text().trim();
            $row.data('orig-name', text);
            $row.data('orig-active', benchGetRowActiveValue($row));
            $row.addClass('row-editing rowhiglight');
            $row.find('.status-name-input').val(text).removeClass('d-none');
            $row.find('.status-name-display').addClass('d-none');
            benchToggleActiveEdit($row, true);
            $row.find('.bench-row-actions-view').addClass('d-none');
            $row.find('.bench-row-actions-edit').removeClass('d-none');
            $row.find('.status-name-input').focus();
            $(".table").resize();
        }

        var $benchDeletePendingRow = null;

        $(document).on('click', '.bench-delete-row', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (!canDeleteAccess) return;
            $benchDeletePendingRow = $(this).closest('tr.tblCol');
            if (!$benchDeletePendingRow.length) return;
            if ($benchDeletePendingRow.hasClass('row-editing')) {
                benchCancelRowEdit($benchDeletePendingRow);
            }
            var name = $benchDeletePendingRow.find('.status-name-display').text().trim();
            $('#benchDeleteStatusMsg').text(benchResDelNamed);
            var deleteModal = new bootstrap.Modal(document.getElementById('benchDeleteStatusModal'));
            deleteModal.show();
        });

        $('#benchDeleteStatusYes').on('click', function () {
            if ($benchDeletePendingRow && $benchDeletePendingRow.length) {
                var statusId = $benchDeletePendingRow.data('status-id');
                if (statusId) {
                    deleteBenchStatusMaster(statusId, function () {
                        var reloadPage = benchCurrentPage;
                        if (benchTotalRecords > 0) {
                            var recordsOnPage = $('#benchStatusTableBody tr.tblCol').length;
                            if (recordsOnPage <= 1 && reloadPage > 1) {
                                reloadPage = reloadPage - 1;
                            }
                        }
                        loadBenchStatusMaster(reloadPage, benchGetCurrentSearchText());
                    });
                }
                $benchDeletePendingRow = null;
            }
        });

        $('#benchDeleteStatusModal').on('hidden.bs.modal', function () {
            $benchDeletePendingRow = null;
        });

        $(document).on('click', '.bench-edit-row', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (!canEditAccess) return;
            var $row = $(this).closest('tr.tblCol');
            if (!$row.length || $row.hasClass('row-editing')) return;
            benchStartRowEdit($row);
        });

        $(document).on('click', '.bench-save-row', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (!canEditAccess) return;
            var $row = $(this).closest('tr.tblCol');
            var $nameInput = $row.find('.status-name-input');
            var val = $nameInput.val().trim();
            var statusId = $row.data('status-id');
            if (!statusId) return;

            var activeVal = $row.find('.bench-active-select').val() || benchGetRowActiveValue($row);
            updateBenchStatusMaster(statusId, val, activeVal, function () {
                $row.find('.status-name-display').text(val);
                $row.find('.status-name-input').val(val);
                benchSetActiveDisplay($row, activeVal);
                $row.removeData('orig-name');
                $row.removeData('orig-active');
                benchCancelRowEdit($row);
                loadBenchStatusMaster(benchCurrentPage, benchGetCurrentSearchText());
            }, $nameInput);
        });

        $(document).on('click', '.bench-cancel-row', function (e) {
            e.preventDefault();
            e.stopPropagation();
            benchCancelRowEdit($(this).closest('tr.tblCol'));
        });

        $(document).on('keydown', '#UnitTable .status-name-input', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                $(this).closest('tr').find('.bench-save-row').trigger('click');
            } else if (e.key === 'Escape') {
                e.preventDefault();
                $(this).closest('tr').find('.bench-cancel-row').trigger('click');
            }
        });

        $(document).on('click', '.bench-history-row.bench-history-enabled', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var $row = $(this).closest('tr.tblCol');
            if (!$row.length || $row.data('has-history') === 0 || $row.data('has-history') === '0') {
                return;
            }
            benchSelectedStatusID = $row.data('status-id') || null;
            var name = $row.find('.status-name-display').text().trim();
            var activeVal = benchGetRowActiveValue($row) === 'Yes' ? benchResYes : benchResNo;
            $('#benchHisStatusName').text(name || '—');
            $('#benchHisActive').text(activeVal);

            var offcanvasEl = document.getElementById('UnitHistoryOffcanvas');
            if (offcanvasEl && offcanvasEl.classList.contains('show')) {
                benchReloadHistoryPanel();
            }
        });

        $('#UnitHistoryOffcanvas').on('shown.bs.offcanvas', function () {
            benchReloadHistoryPanel();
            if ($.fn.selectpicker) {
                $('.selectpicker').selectpicker('refresh');
            }
            $(".table").resize();
            // Re-sync header & body column widths after offcanvas shifts the layout
            if ($.fn.DataTable && $.fn.DataTable.isDataTable('#UnitTable')) {
                setTimeout(function () { $('#UnitTable').DataTable().columns.adjust(); }, 50);
            }
        });

        $('#UnitHistoryOffcanvas').on('hidden.bs.offcanvas', function () {
            // Re-sync header & body column widths after offcanvas closes and layout restores
            if ($.fn.DataTable && $.fn.DataTable.isDataTable('#UnitTable')) {
                setTimeout(function () { $('#UnitTable').DataTable().columns.adjust(); }, 50);
            }
            $(".table").resize();
        });

        $('#modifiedHisField, #modifiedHisBy').on('changed.bs.select change', function () {
            benchHistoryPageNumber = 1;
            loadBenchStatusHistory();
        });

        $('#benchHistoryPrevBtn').on('click', function () {
            benchGoToHistoryPreviousPage();
        });

        $('#benchHistoryNextBtn').on('click', function () {
            benchGoToHistoryNextPage();
        });

        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        function refreshPage() {
            window.location.reload();
        } 

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

        $("#CustGpFilterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#CustGpFilterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        // Add new row in Unit table functionality added by Gauri
        $("#clickYes1").addClass("disableIcn");

        function AddNewUnit() {
            if (!canAddAccess) return;
            $("#newUnitInput").on("input", function () {
                var unitInput = $(this).val().trim();
                if (unitInput === '') {
                    $("#clickYes1").addClass("disableIcn").off("click");
                    benchSetAddRowYesTooltipEnabled(false);
                } else {
                    $("#clickYes1").removeClass("disableIcn").off("click").on("click", function () {
                        var $newInput = $("#newUnitInput");
                        var name = $newInput.val().trim();
                        insertBenchStatusMaster(name, true, function () {
                            $newInput.val('');
                            $("#clickYes1").addClass("disableIcn").off("click");
                            benchSetAddRowYesTooltipEnabled(false);
                            loadBenchStatusMaster(1, benchGetCurrentSearchText());
                        }, $newInput);
                    });
                    benchSetAddRowYesTooltipEnabled(true);
                }
            });

            $("#clickNo1").off("click").on("click", function () {
                $('#newUnitInput').val('');
                $("#clickYes1").addClass("disableIcn").off("click");
                benchSetAddRowYesTooltipEnabled(false);
            });
        }
        if (canAddAccess) {
            AddNewUnit();
            benchInitAddRowActionTooltips();
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

    </script>

</body>

</html>
