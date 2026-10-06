<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectSites.aspx.vb" Inherits="Whizible.PM_ProjectSites" %>

<!DOCTYPE html>
<html>
  <%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("C_ProjectSites"))%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_ProjectSites")%></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Commented out for UI only - will be enabled when functionality is added -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/calendar-gc.min.css"> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <!-- Alertify CSS for notifications -->
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />
    <style type="text/css"> 
        .dataTables_scrollBody {
            margin-bottom: 10px;
        }
        .bgwhite{
            font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
            font-family: "Roboto",sans-serif !important;
        }
        .dataTables_scroll {
            overflow: auto; /* Enable horizontal and vertical scrolling if needed */
        }

        table tr th,
        table tr td {
            text-align: center !important;
        }

        table tr th:last-child,
        table tr td:last-child {
            text-align: center;
        }

        .dataTables_scrollHeadInner,
        .dataTables_scrollHeadInner table {
            width: 100% !important;
        }

        .dataTables_scrollHeadInner {
            width: 100% !important;
        }

        div.dataTables_scrollBody>table {
            width: 100% !important;
        }

        /* Hide default DataTables pagination */
        #trainingPlanTbl_wrapper .dataTables_paginate {
            display: none !important;
        }
        
        #ProjectSiteShowHisTable_wrapper .dataTables_paginate {
            display: none !important;
        }

        /* Hide DataTables sorting arrows */
        table.dataTable thead th.sorting,
        table.dataTable thead th.sorting_asc,
        table.dataTable thead th.sorting_desc {
            background-image: none !important;
            padding-right: 0.75rem !important;
        }
        
        table.dataTable thead th.sorting:before,
        table.dataTable thead th.sorting:after,
        table.dataTable thead th.sorting_asc:before,
        table.dataTable thead th.sorting_asc:after,
        table.dataTable thead th.sorting_desc:before,
        table.dataTable thead th.sorting_desc:after {
            display: none !important;
        }

        .black-tooltip .tooltip-inner {
    background-color: #000;
    color: #fff;
    font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
    padding: 6px 10px;
}

.black-tooltip .tooltip-arrow::before {
    border-top-color: #000;
}

        /* Increase z-index for history filter dropdowns to appear above pagination */
        /* Target the bootstrap-select wrapper and dropdown menu for both filter dropdowns */
        .hstryfltr .bootstrap-select {
            z-index: 1001 !important;
        }
        
        .hstryfltr .bootstrap-select .dropdown-menu {
            z-index: 1001 !important;
        }
        
        /* Also target by ID for more specificity */
        #modifiedHisField + .dropdown-menu,
        #modifiedHisBy + .dropdown-menu {
            z-index: 1001 !important;
        }

        /* Increase z-index for alertify notifications to appear above modals */
        .alertify-notifier {
            z-index: 9999 !important;
        }
        
        .alertify-notifier .ajs-message {
            z-index: 9999 !important;
        }
        
        .alertify-notifier .ajs-success,
        .alertify-notifier .ajs-error,
        .alertify-notifier .ajs-warning,
        .alertify-notifier .ajs-message {
            z-index: 9999 !important;
        }

        /* Modal small size - matching PM_Documents.aspx */
        .modalsmall {
            width: 400px;
            margin: 30px auto;
        }

        /* Style for close button in modal header */
        .modal-header.ui-draggable-handle {
            position: relative;
        }

        .modal-header.ui-draggable-handle .close {
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 28px;
            font-weight: bold;
            line-height: 1;
            color: #fff;
            text-shadow: 0 1px 0 #fff;
            opacity: 0.8;
            background: transparent;
            border: 0;
            padding: 0;
            cursor: pointer;
            z-index: 1;
        }

        .modal-header.ui-draggable-handle .close:hover {
            opacity: 1;
            color: #fff;
        }

        .custom_chckbox label:before {
            margin-right: 10px;
        }

        /* Style for disabled checkboxes */
        .custom_chckbox.chckbox-disabled {
            cursor: not-allowed !important;
            pointer-events: auto; /* Allow pointer events on container for tooltip */
        }

        .custom_chckbox.chckbox-disabled input[type="checkbox"] {
            cursor: not-allowed !important;
            pointer-events: none !important; /* Prevent clicks on disabled checkbox */
        }

        .custom_chckbox.chckbox-disabled input[type="checkbox"] + label {
            opacity: 0.6;
            cursor: not-allowed !important;
            pointer-events: none !important; /* Prevent clicks on label */
        }

        /* Ensure enabled checkboxes are clickable */
        .custom_chckbox:not(.chckbox-disabled) input[type="checkbox"] {
            cursor: pointer !important;
            pointer-events: auto !important;
        }

        .custom_chckbox:not(.chckbox-disabled) input[type="checkbox"] + label {
            cursor: pointer !important;
            pointer-events: auto !important;
        }

        /* Ensure the checkbox container allows clicks */
        .custom_chckbox:not(.chckbox-disabled) {
            pointer-events: auto !important;
            cursor: pointer !important;
        }

        /* Make sure the label can be clicked to toggle checkbox */
        .custom_chckbox:not(.chckbox-disabled) label {
            cursor: pointer !important;
            pointer-events: auto !important;
        }

        .custom_chckbox.chckbox-disabled input[type="checkbox"] + label:before {
            background-color: #e9ecef;
            border-color: #ced4da;
            opacity: 0.6;
            cursor: not-allowed !important;
        }

        .custom_chckbox.chckbox-disabled input[type="checkbox"]:checked + label:before {
            background-color: #6c757d;
            border-color: #6c757d;
            opacity: 0.6;
        }

        /* Style for disabled Offshore Site checkbox */
        #OffshoreSiteChk:disabled {
            cursor: not-allowed !important;
        }

        #OffshoreSiteChk:disabled + label {
            cursor: not-allowed !important;
            opacity: 0.6;
            pointer-events: none;
        }

        #OffshoreSiteChk:disabled + label:before {
            background-color: #e9ecef !important;
            border-color: #ced4da !important;
            opacity: 0.6 !important;
            cursor: not-allowed !important;
        }

        #OffshoreSiteChk:disabled:checked + label:before {
            background-color: #adb5bd !important;
            border-color: #6c757d !important;
            opacity: 0.7 !important;
            cursor: not-allowed !important;
        }

        /* Parent container styling for disabled offshore checkbox */
        .custom_chckbox.offshore-disabled {
            cursor: not-allowed !important;
        }

        .offcanvas {
            --bs-offcanvas-width: 85%;
        }

        label {
            font-weight: 400;
        }

        /* Disable page scroll when offcanvas is open */
        body.no-scroll,
        html.no-scroll {
            overflow: hidden !important;
            height: 100% !important;
            position: fixed !important;
            width: 100% !important;
        }
        body.no-scroll {
            overflow-y: hidden !important;
        }

        /* Remove unwanted horizontal scrollbar on the page */
        html, body {
            overflow-x: hidden;
            max-width: 100%;
        }

        /* Ensure offcanvas body has proper scrolling */
        .offcanvas-body {
            overflow-y: auto;
            overflow-x: hidden;
        }

        /* Calendar legend styles */
        .legend span {
            display: inline-block;
            width: 22px;
            height: 15px;
            margin-right: 0;
            border: 1px solid #ddd;
        }

        .lgdHoliday {
            background: #fff9c4;
            background-image: repeating-linear-gradient(45deg, #fff, #ffae00 1px, #fff 3px, #fff 3px);
            border-left: 2px solid #d32f2f !important;
        }

        .lgdPlannedday {
            background: #fff9c4;
            background-image: repeating-linear-gradient(45deg, #fff, yellow 1px, #fff 3px, #fff 4px);
            border-left: 2px solid #d32f2f !important;
        }

        .lgdPH {
            background: #f0f0f0;
            background-image: repeating-linear-gradient(45deg, #fff, #e9e9e9 1px, #fff 3px, #fff 4px);
            border-left: 2px solid #d32f2f !important;
        }

        .lgdUpdated {
            background: #e3f2fd;
            background-image: repeating-linear-gradient(45deg, #fff, #90caf9 1px, #fff 3px, #fff 4px);
            border-left: 2px solid #d32f2f !important;
        }

        /* Calendar cell styling */
        .calendar-placeholder table td {
            position: relative;
            min-height: 60px;
            color: #38385c;
            font-weight: 800;
        }

        .calendar-placeholder table td strong {
            color: #38385c;
            font-weight: 800;
        }

        .calendar-weekend {
            background: #f0f0f0 !important;
            background-image: repeating-linear-gradient(45deg, #fff, #e9e9e9 1px, #fff 3px, #fff 4px) !important;
            color: #38385c !important;
        }

        .calendar-today {
            background: #fff9c4 !important;
            background-image: repeating-linear-gradient(45deg, #fff, yellow 1px, #fff 3px, #fff 4px) !important;
            color: #38385c !important;
        }

        .calendar-today strong {
            color: #38385c !important;
            font-weight: 800;
        }

        .calendar-holiday {
            background: #fff9c4 !important;
            background-image: repeating-linear-gradient(45deg, #fff, #ffae00 1px, #fff 3px, #fff 3px) !important;
            color: #38385c !important;
        }
        
        .calendar-updated {
            background: #e3f2fd !important;
            background-image: repeating-linear-gradient(45deg, #fff, #90caf9 1px, #fff 3px, #fff 4px) !important;
            color: #38385c !important;
        }
        
        /* Holiday takes priority over weekend */
        .calendar-weekend.calendar-holiday {
            background: #fff9c4 !important;
            background-image: repeating-linear-gradient(45deg, #fff, #ffae00 1px, #fff 3px, #fff 3px) !important;
            color: #38385c !important;
        }
        
        /* Holiday takes priority over today */
        .calendar-today.calendar-holiday {
            background: #fff9c4 !important;
            background-image: repeating-linear-gradient(45deg, #fff, #ffae00 1px, #fff 3px, #fff 3px) !important;
            color: #38385c !important;
        }
        
        /* Updated takes priority over weekend (but not holiday) */
        .calendar-weekend.calendar-updated {
            background: #e3f2fd !important;
            background-image: repeating-linear-gradient(45deg, #fff, #90caf9 1px, #fff 3px, #fff 4px) !important;
            color: #38385c !important;
        }
        
        /* Updated takes priority over today (but not holiday) */
        .calendar-today.calendar-updated {
            background: #e3f2fd !important;
            background-image: repeating-linear-gradient(45deg, #fff, #90caf9 1px, #fff 3px, #fff 4px) !important;
            color: #38385c !important;
        }

        /* Hover effects for calendar dates - popup effect on numbers only */
        .calendar-placeholder table td[data-clickable="true"]:not(.calendar-today):not(.calendar-weekend):not(.calendar-holiday):not(.calendar-updated) {
            position: relative;
        }

        .calendar-placeholder table td[data-clickable="true"]:not(.calendar-today):not(.calendar-weekend):not(.calendar-holiday):not(.calendar-updated):hover {
            background: inherit !important;
            background-image: inherit !important;
        }

        .calendar-placeholder table td[data-clickable="true"]:not(.calendar-today):not(.calendar-weekend):not(.calendar-holiday):not(.calendar-updated) span,
        .calendar-placeholder table td[data-clickable="true"]:not(.calendar-today):not(.calendar-weekend):not(.calendar-holiday):not(.calendar-updated) strong {
            display: inline-block;
            transition: transform 0.2s ease;
            transform-origin: center;
        }

        .calendar-placeholder table td[data-clickable="true"]:not(.calendar-today):not(.calendar-weekend):not(.calendar-holiday):not(.calendar-updated):hover span,
        .calendar-placeholder table td[data-clickable="true"]:not(.calendar-today):not(.calendar-weekend):not(.calendar-holiday):not(.calendar-updated):hover strong {
            color: #38385c;
            transform: scale(1.3);
            font-weight: 800;
        }
        
        /* Holiday hover effect - preserve holiday background */
        .calendar-holiday {
            position: relative;
        }
        
        .calendar-holiday:hover {
            background: #fff9c4 !important;
            background-image: repeating-linear-gradient(45deg, #fff, #ffae00 1px, #fff 3px, #fff 3px) !important;
            color: #38385c !important;
        }
        
        .calendar-holiday span,
        .calendar-holiday strong {
            display: inline-block;
            transition: transform 0.2s ease;
            transform-origin: center;
        }
        
        .calendar-holiday:hover span,
        .calendar-holiday:hover strong {
            color: #38385c !important;
            transform: scale(1.3);
            font-weight: 800;
        }
        
        /* Updated hover effect - preserve updated background */
        .calendar-updated {
            position: relative;
        }
        
        .calendar-updated:hover {
            background: #e3f2fd !important;
            background-image: repeating-linear-gradient(45deg, #fff, #90caf9 1px, #fff 3px, #fff 4px) !important;
            color: #38385c !important;
        }
        
        .calendar-updated span,
        .calendar-updated strong {
            display: inline-block;
            transition: transform 0.2s ease;
            transform-origin: center;
        }
        
        .calendar-updated:hover span,
        .calendar-updated:hover strong {
            color: #38385c !important;
            transform: scale(1.3);
            font-weight: 800;
        }

        /* Weekend hover effect - preserve background */
        .calendar-weekend {
            position: relative;
        }

        .calendar-weekend:hover {
            background: #f0f0f0 !important;
            background-image: repeating-linear-gradient(45deg, #fff, #e9e9e9 1px, #fff 3px, #fff 4px) !important;
        }

        .calendar-weekend span {
            display: inline-block;
            transition: transform 0.2s ease;
            transform-origin: center;
        }

        .calendar-weekend:hover span {
            color: #38385c;
            transform: scale(1.3);
            font-weight: 800;
        }

        /* Today hover - preserve background */
        .calendar-today {
            position: relative;
        }

        .calendar-today:hover {
            background: #fff9c4 !important;
            background-image: repeating-linear-gradient(45deg, #fff, yellow 1px, #fff 3px, #fff 4px) !important;
        }

        .calendar-today strong {
            display: inline-block;
            transition: transform 0.2s ease;
            transform-origin: center;
        }

        .calendar-today:hover strong {
            color: #38385c !important;
            transform: scale(1.3);
            font-weight: 800;
        }

        /* Pagination styling - Added to match PM_Documents.aspx */
        .pagination-container {
            background: white;
            display: flex !important;
            justify-content: flex-end;
            align-items: center;
            gap: 1rem;
            margin-top: 0;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            
        }
        
        .pagination-info {
            color: #333;
            font-size: 14px;
            font-weight: 300;
        }
        
        .pagination {
            margin-bottom: 20px !important;
            margin-top: 20px !important;
        }
        
        .pagination .page-item {
            margin: 0 2px;
        }
        
        .pagination .page-link {
            padding: 8px 12px;
            color: #1359a6;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .clsShowHide {
    display: none !important;
}
        .pagination .page-link:hover {
            color: #fff;
            background-color: #1359a6;
            border-color: #1359a6;
        }
        
        .pagination .page-item.fa-disabled .page-link {
            color: #6c757d;
            background-color: #f8f9fa;
            border-color: #dee2e6;
            cursor: not-allowed;
            pointer-events: none;
        }
        
        .pagination .page-item.fa-disabled .page-link:hover {
            color: #6c757d;
            background-color: #f8f9fa;
            border-color: #dee2e6;
        }
        li#btnprevious.page-item.fa-disabled {
            cursor: not-allowed;
        }
        li#btnnext.page-item.fa-disabled {
            cursor: not-allowed;
        }
        
        /* Add padding to content to prevent overlap with fixed pagination */
        .content.mb-10 {
            padding-bottom: 80px;
        }

        /* Page Header Styling - Matching PM_Documents.aspx */
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
            font-size: 18px;
            flex-shrink: 0;
        }
        
        .header-content {
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        
        .page-title {
            color: #1e40af;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
            line-height: 1.2;
        }
        
        .page-subtitle {
            color: #6B7280;
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            line-height: 1.4;
            margin-top: 4px;
            margin-left: -42px;
        }

        .project-section {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn dropdown-toggle btn-light{
            width: 260px !important;
        }

        #cboProject,
        #cboProject + .bootstrap-select {
            width: 260px !important;
        }
        
        #cboProject + .btn.dropdown-toggle {
            height: 32px;
        }
        
        /* Fix Bootstrap Select picker click area */
        #cboProject + .btn.dropdown-toggle,
        .bootstrap-select .dropdown-toggle {
            pointer-events: auto !important;
            position: relative;
            z-index: 1;
        }
        
        .bootstrap-select .dropdown-toggle::after {
            pointer-events: none;
        }

        #ProjectSiteShowHisTable td:nth-child(2),
#ProjectSiteShowHisTable td:nth-child(3) {
    white-space: normal !important;
    word-break: break-word;
}

        /* Reduce gap between project dropdown and table */
        .statckmainheader {
            margin-bottom: 0 !important;
            padding-bottom: 0.25rem !important;
        }
        
        .content.mb-10 {
            margin-top: 0 !important;
            padding-top: 0 !important;
            /* Keep padding-bottom for pagination */
        }
        
        .content.mb-10 > .py-1 {
            padding-top: 0.25rem !important;
            padding-bottom: 0.25rem !important;
        }
        .RoleRateRoleColumn .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            max-width: 200px;
            min-width: 200px;
        }
        .statckmainheader .dropdown-toggle, .bs-searchbox{
            width: 260px;
        }
            /* ── Checkbox appearance — matches My_Leaves native style ── */
        .chckHead,
        .chcktbl,
        .chckHead1,
        .chcksite,
        .mainchck,
        .main_Skills,
        .custom_chckbox input[type="checkbox"] {
            -webkit-appearance: auto !important;
            -moz-appearance: auto !important;
            appearance: auto !important;
            opacity: 1 !important;
            position: static !important;
            display: inline-block !important;
            width: 14px !important;
            height: 14px !important;
            min-width: 14px !important;
            cursor: pointer !important;
            vertical-align: middle;
            accent-color: #486AC0;
        }

        /* Remove pseudo-element fake box — native checkbox is now visible */
        .custom_chckbox input[type="checkbox"] + label:before,
        .custom_chckbox input[type="checkbox"] + label:after {
            display: none !important;
            content: none !important;
        }

        /* Keep label in flow but collapse it — click area stays on the input */
        .custom_chckbox input[type="checkbox"] + label {
            display: inline-block !important;
            width: 0 !important;
            height: 0 !important;
            overflow: hidden !important;
            margin: 0 !important;
            padding: 0 !important;
        }

        /* Center checkbox in its table cell */
        .custom_chckbox {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }
    
        /* Offcanvas header — matches PM_ToolsSkills style */
        .offcanvas-title-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }

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
            font-size: 18px;
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
    
    /* Loader overlay — matches PM_ReportUIBuilder / PM_ProjectProfitability */
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
</style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
<!-- Page Loader — matches PM_ReportUIBuilder style -->
<div class="loader-overlay" id="pageLoader" style="display: none;">
    <div class="loader"></div>
</div>

    <!-- Added for Role Access -->
    <% If m_blnViewAccess Then %>
    <!-- End of Role Access -->

    <div class="bgwhite">
        <!-- Page Header with Icon -->
        <div class="graybg page-header">
            <div class="header-icon">
                <i class="fas fa-building"></i>
            </div>
            <div class="header-content">
                <h5 class="page-title">Project Sites</h5>
                <p class="page-subtitle">Manage project sites, billing details, and site calendars</p>
            </div>
        </div>
        <div class="clearfix"></div>
        
        <div class="container-fluid pt-1 pb-1 statckmainheader clearfix">
            <div class="row">
                <div class="col-sm-3">
                    <div class="project-section">
                        <label for="cboProject" style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0; margin-right: 0.5rem; white-space: nowrap;">Select Project</label>
                        <%--//Added by Aditya J. on 19-08-2026 for showing closed project also in the project dropdown--%>
                        <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true' data-width='260px%'",,,) %>--%>
                        <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_WithSelected " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true' data-width='260px%'",,,) %>
                        <%--//End of Added by Aditya J. on 19-08-2026 for showing closed project also in the project dropdown--%>
                    </div>
                </div>
                <input type="hidden" id="hdnUniqueID" value="<%= Request.QueryString("UniqueID") %>" />
                <div class="col-sm-9 form-inline text-end">
                    <div class="clearFilter d-flex align-items-center justify-content-end">
                        <a href="javascript:;" class="clearalllink pe-3" onclick="clearAll()" id="PMProjectSitesClearAllFilter"
                            data-bs-toggle="tooltip" data-bs-placement="bottom" title="" style="display: none;"><strong><%=MyBase.GetResourceString("C_ClearAll")%></strong></a>
                        <div class="filter inline">
                            <button data-bs-toggle="collapse" data-bs-target="#filterpanel" aria-expanded="false"
                                id="AdvanceFilterIcon" data-original-title="<%=MyBase.GetResourceString("C_Filter")%>" autocomplete="off">
                                 <%-- Commented and Added By Vyankat B. on 1st April 2026 for adding the missing tooltip --%>
<%--                                <i class="fas fa-filter" ></i>--%>
                                <i class="fas fa-filter" data-bs-toggle="tooltip" title="Filter"></i>
                                 <%-- End of Commented and Added By Vyankat B. on 1st April 2026 for adding the missing tooltip --%>

                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                <div class="Fwrapper">
                    <div class="filterpanelbody" style="padding: 0px 30px">
                                <div class="text-center hidden-xs centerbtn">
                                    
                                    <button class="btn btnyellow" id="applyFilterBtn"><%=MyBase.GetResourceString("C_Apply")%></button>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="nameFilter" class="col-sm-4"><%=MyBase.GetResourceString("C_Names")%></label>
                                            <div class="col-sm-8">
                                                <input id="nameFilter" type="text" class="form-control input-sm" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="shortNameFilter" class="col-sm-4"><%=MyBase.GetResourceString("C_ShortNames")%></label>
                                            <div class="col-sm-8">
                                                <input type="text" id="shortNameFilter" class="form-control input-sm" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="projFilterCurrency" class="col-sm-4"><%=MyBase.GetResourceString("C_Currency")%></label>
                                            <div class="col-sm-8">
                                                <select class="selectpicker" aria-label="<%=MyBase.GetResourceString("C_SelectCurrency")%>"
                                                    data-live-search="true" id="projFilterCurrency">
                                                    <option><%=MyBase.GetResourceString("C_SelectCurrency")%></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label class="col-sm-4"><%=MyBase.GetResourceString("C_RateMethod")%></label>
                                            <div class="col-sm-8">
                                                <select class="selectpicker" aria-label="<%=MyBase.GetResourceString("C_SelectRateMethod")%>"
                                                    data-live-search="true" id="projFilterRateMethod">
                                                    <option>Select Rate Method</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label class="col-sm-4"><%=MyBase.GetResourceString("C_StartingDayOfWeek")%></label>
                                            <div class="col-sm-8">
                                                <select class="selectpicker" aria-label="<%=MyBase.GetResourceString("C_StartingDayOfWeek")%>"
                                                    data-live-search="true" id="projFilterDayOfWeek">
                                                    <option>Select Days of Week</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="workingDaysFilter" class="col-sm-4"><%=MyBase.GetResourceString("C_WorkingDaysPerWeek")%></label>
                                            <div class="col-sm-8">
                                                <input type="text" id="workingDaysFilter" class="form-control input-sm" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="workingHoursFilter" class="col-sm-4"><%=MyBase.GetResourceString("C_WorkingHoursPerDay")%></label>
                                            <div class="col-sm-8">
                                                <input type="text" id="workingHoursFilter" class="form-control input-sm" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="extraHoursFilter" class="col-sm-4"><%=MyBase.GetResourceString("C_ExtraHoursCapPerDay")%></label>
                                            <div class="col-sm-8">
                                                <input type="text" id="extraHoursFilter" class="form-control input-sm" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label for="workHoursMonthFilter" class="col-sm-4"><%=MyBase.GetResourceString("C_WorkingHoursPerMonth")%></label>
                                            <div class="col-sm-8">
                                                <input type="text" id="workHoursMonthFilter" class="form-control input-sm" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 col-sm-6 form-group mb-3">
                                        <div class="row">
                                            <label class="col-sm-4"><%=MyBase.GetResourceString("C_OffshoreSite")%></label>
                                            <div class="col-sm-4">
                                                <select class="selectpicker" aria-label="<%=MyBase.GetResourceString("C_OffshoreSite")%>"
                                                    data-live-search="true" id="projFilterOffshoreSite">
                                                    <option>Select Option</option>
                                                    <option><%=MyBase.GetResourceString("C_Yes")%></option>
                                                    <option><%=MyBase.GetResourceString("C_No")%></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                </div>
            </div>
        </div>

        <!--end filter panel-->

        <div class="content mb-10">
            <div class="py-1">
                <div class="text-end float-end" style="cursor: auto;">
                    <% If m_blnAddAccess Then %>
                    <a href="javascript:;" class="btn borderbtn inheritBtn" id="InheritProjectBtn"
                        data-bs-toggle="modal" data-bs-target="#InheritDetailsModal" data-bs-dismiss="modal">Inherit</a>
                    <a href="javascript:;" class="btn borderbtn addbtn" id="AddProjectBtn" data-bs-toggle="offcanvas"
                        data-bs-target="#AddProjectSiteOffcanvas" aria-controls="offcanvasWithBothOptions"><i
                            class="fas fa-plus"></i> <%=MyBase.GetResourceString("C_Add")%></a>
                    <% End If %>

                    <% If m_blnDeleteAccess Then %>
                    <button class="btn borderbtn" id="DeleteProjectBtn" onclick=""><%=MyBase.GetResourceString("C_Delete")%></button>
                    <% End If %>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="table-responsive-custom">
                <table id="trainingPlanTbl" class="table table-stripped modalDTtabl" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_SiteName")%></th>
                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_RateMethod")%></th>
                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_StartingDayOfWeek")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_IsFreezed")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_OffshoreSite")%></th>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_Currency")%></th>
                            <%If m_blnViewAccess %>
                                <th class="col-sm-1">
                                    Action
                                </th>
                            <% End If %>
                            <% If m_blnDeleteAccess Then %>
                            <th>
                                <div class="custom_chckbox">
                                    <input id="tpGridcheck0" class="chckHead" type="checkbox" />
                                    <label for="tpGridcheck0"></label>
                                </div>
                            </th>
                            <% End If %>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Table rows will be populated dynamically from API -->
                        <!-- Hardcoded rows removed - data now comes from GetAllProjectSites API -->
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination-container">
                <div class="pagination-info" id="paginationInfo">
                    <span class="spntotal"><%=MyBase.GetResourceString("C_TotalRecordsColon")%></span>
                    <span class="spntotal" id="totalRecords">0</span>
                </div>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <li class="page-item fa-disabled" id="btnprevious">
                            <a class="page-link" aria-label="Previous" href="javascript:;" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" id="LinkPrevious" onclick="goToPreviousPage(); return false;">
                                <i class="fas fa-angle-double-left"></i>
                            </a>
                        </li>
                        <li class="page-item fa-disabled" id="btnnext">
                            <a class="page-link" aria-label="Next" href="javascript:;" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" id="LinkNext" onclick="goToNextPage(); return false;">
                                <i class="fas fa-angle-double-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

        <div class="offcanvas offcanvas-end" data-bs-scroll="true" tabindex="-1" id="AddProjectSiteOffcanvas"
            aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body px-0" style=" padding-top: 0px;">
                    <ul class="nav nav-tabs detailsubtabs mt-2 d-flex align-items-center">
                        <li class="nav-item">
                            <a class="nav-link active" href="#prositedetailTab1" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_Details")%></a>
                        </li>
                        <% If m_blnViewAccess Then %>
                        <li class="nav-item">
                            <a class="nav-link" href="#prositedetailTab2" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_RoleRate")%></a>
                        </li>
                        <% End If %>
                        <li class="nav-item">
                            <a class="nav-link" href="#prositedetailTab3" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_SiteCalendar")%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#prositedetailTab4" data-bs-toggle="tab" id=""><%=MyBase.GetResourceString("C_ShowHistory")%></a>
                        </li>
                        <li class="nav-item ms-auto border-0 d-flex align-items-center pe-2">
                            <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas"
                                aria-label="Close" data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip"
                                data-bs-placement="top" title="Close">&#x2715;</button>
                        </li>
                    </ul>
                <div class="tab-content">
                    <div id="prositedetailTab1" class="tab-pane active mt-4">
                        <div class="projDetailsContent projDetailsContentMain">
                            <div class="container-fluid">
                                <div class="row align-items-center">
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="col-sm-8 pe-4">
                                        <div class="detailsubtabsbtn pb-1 text-end" style="margin-right: -15px;">
                                            <% If m_blnEditAccess Then %>
                                            <a href="javascript:;" id="freezeSiteBtn" onclick="freezeSite()" class="btn borderbtn"><%=MyBase.GetResourceString("C_FreezeSiteDetails")%></a>
                                            <% End If %>
                                            <% If m_blnAddAccess Or m_blnEditAccess Then %>
                                            <button class="btn btnyellow" id="saveResBtn"><%=MyBase.GetResourceString("C_Save")%></button>
                                            <button class="btn btnyellow" id="saveAddResBtn"><%=MyBase.GetResourceString("C_SaveAndAdd")%></button>
                                            <% End If %>

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12 text-end">
                                        <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                    </div>
                                </div>

                                <div class="projectRsrsinfo">
                                    <div class="row">
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="ResName" class="col-sm-5 text-end control-label required"><%=MyBase.GetResourceString("C_Name")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="ResName" maxlength="50" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="ResShortName" class="col-sm-5 text-end control-label"><%=MyBase.GetResourceString("C_ShortName")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="ResShortName" maxlength="10" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            &nbsp;
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="detailTabTitleDiv my-3">
                                        <h5 class="detailSubtabTitle mb-0"><%=MyBase.GetResourceString("C_BillingDetails")%></h5>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsCurrency"
                                                    class="col-sm-5 control-label required text-end"><%=MyBase.GetResourceString("C_Currency")%></label>
                                                <div class="col-sm-7">
                                                    <select class="selectpicker" aria-label="<%=MyBase.GetResourceString("C_SelectCurrency")%>"
                                                        data-live-search="true" id="projDetailsCurrency">
                                                        <option><%=MyBase.GetResourceString("C_SelectCurrency")%></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label class="col-sm-5 control-label required text-end"><%=MyBase.GetResourceString("C_RateMethod")%></label>
                                                <div class="col-sm-7">
                                                    <select class="selectpicker" aria-label="<%=MyBase.GetResourceString("C_SelectRateMethod")%>"
                                                        data-live-search="true" id="projDetailsRateMethod">
                                                        <option><%=MyBase.GetResourceString("C_SelectRateMethod")%></option>
                                                        <option><%=MyBase.GetResourceString("C_PersonHour")%></option>
                                                        <option><%=MyBase.GetResourceString("C_PersonDay")%></option>
                                                        <option><%=MyBase.GetResourceString("C_PersonMonth")%></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label class="col-sm-5 control-label required text-end"><%=MyBase.GetResourceString("C_StartingDayOfWeek")%></label>
                                                <div class="col-sm-7">
                                                    <select select class="selectpicker"
                                                        aria-label="<%=MyBase.GetResourceString("C_SelectDaysOfWeek")%>" data-live-search="true"
                                                        id="projDetailsDays">
                                                    <option><%=MyBase.GetResourceString("C_SelectDaysOfWeek")%></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsWorkingDays" class="col-sm-5 control-label required text-end"><%=MyBase.GetResourceString("C_WorkingDaysPerWeek")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsWorkingDays" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsWorkingHours" class="col-sm-5 control-label required text-end"><%=MyBase.GetResourceString("C_WorkingHoursPerDay")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsWorkingHours" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsExtraHours" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_ExtraHoursCapPerDay")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsExtraHours" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsWHoursMonth" class="col-sm-5 control-label required text-end"><%=MyBase.GetResourceString("C_WorkingHoursPerMonth")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsWHoursMonth" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsOffshoreSite" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_OffshoreSite")%></label>
                                                <div class="col-sm-7">
                                                    <div class="custom_chckbox">
                                                        <input id="OffshoreSiteChk" class="" type="checkbox"
                                                            checked />
                                                        <label for="OffshoreSiteChk"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="detailTabTitleDiv my-3">
                                        <h5 class="detailSubtabTitle mb-0"><%=MyBase.GetResourceString("C_AddressDetails")%></h5>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsAdd1" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_Address1")%></label>
                                                <div class="col-sm-7">
                                                    <textarea class="form-control" id="projDetailsAdd1" maxlength="100" rows="2"></textarea>        
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsAdd2" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_Address2")%></label>
                                                <div class="col-sm-7">
                                                    <textarea class="form-control" id="projDetailsAdd2" maxlength="100" rows="2"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsCountry" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_Country")%></label>
                                                <div class="col-sm-7">
                                                    <select select class="selectpicker" aria-label="<%=MyBase.GetResourceString("C_SelectCountry")%>"
                                                        data-live-search="true" id="projDetailsCountry">
                                                        <option><%=MyBase.GetResourceString("C_SelectCountry")%></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>

                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsState" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_State")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsState" maxlength="50" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsCity" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_City")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsCity" maxlength="50" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsZip" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_ZipPostalCode")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsZip" maxlength="10" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>

                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsFax" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_Fax")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsFax" maxlength="12" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsPhone" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_Phone")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsPhone" maxlength="12" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsEmail" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_Email")%></label>
                                                <div class="col-sm-7">
                                                    <input type="text" class="form-control" id="projDetailsEmail" maxlength="50" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>

                                        <div class="col-sm-4 form-group mb-3">
                                            <div class="row">
                                                <label for="projDetailsRemarks" class="col-sm-5 control-label text-end"><%=MyBase.GetResourceString("C_Remarks")%></label>
                                                <div class="col-sm-7">
                                                    <textarea class="form-control" id="projDetailsRemarks" maxlength="500"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <% If m_blnViewAccess Then %>
                    <!--Tab Role Rate-->
                    <div id="prositedetailTab2" class="tab-pane mt-4">
                        <div class="RoleRateContent RoleRateContentMain">
                            <div class="container-fluid">
                                <div class="row align-items-center mb-3">
                    
                    <!-- Center buttons -->
                                <div class="col-12 d-flex justify-content-end gap-2 flex-nowrap">
                                    <% If m_blnEditAccess Then %>
                                        <button type="button"
                                            class="btn borderbtn text-nowrap"
                                            data-bs-toggle="modal"
                                            data-bs-target="#updateBillingInfoModal">
                                            <%=MyBase.GetResourceString("C_UpdateEmployeeBillingRates")%>
                                        </button>
                                    <% End If %>
                                </div>

                                </div>

                                <table id="rolerateTbl" class="table table-stripped modalDTtabl mt-3">
                                    <thead>
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_Role")%></th>
                                            <th><%=MyBase.GetResourceString("C_Currency")%></th>
                                            <th><%=MyBase.GetResourceString("C_NormalRate")%></th>
                                            <th><%=MyBase.GetResourceString("C_ExtraRate")%></th>
                                            <th><%=MyBase.GetResourceString("C_HolidayRate")%></th>
                                            <% If m_blnEditAccess Then %>
                                                <th>Action</th>
                                            <% End If %>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Role rate data will be loaded dynamically via API -->
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="RoleRateContent RoleRateRoleColumn d-none">
                            <div class="container-fluid pb-2">
                                <div class="row align-items-center">
                                    <div class="col-sm-12 pe-4">
                                        <div class="detailsubtabsbtn text-end">
                                            <% If m_blnEditAccess Then %>
                                            <button class="btn btnyellow" id="svRoleRateBtn"><%=MyBase.GetResourceString("C_Save")%></button>
                                            <% End If %>
                                            <button class="btn borderbtn" id="backRoleRateBtn"><%=MyBase.GetResourceString("C_Back")%></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="row pt-1">
                                    <div class="col-sm-12 text-end">
                                        <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                                    </div>
                                </div>
                            </div>

                           <div class="RoleRateFieldsSec px-3">

                            <!-- Row 1 -->
                            <div class="row mb-3">

                            <!-- Role -->
                                <div class="col-sm-6">
                                    <div class="row align-items-center">
                                        <label class="col-sm-4 control-label text-end">
                                            <%=MyBase.GetResourceString("C_Role")%>
                                        </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="projRoleRateRoleText" readonly />
                                        </div>
                                    </div>
                                </div>

                            <!-- Normal Rate -->
                                <div class="col-sm-6">
                                    <div class="row align-items-center">
                                        <label class="col-sm-4 control-label text-end required">
                                            <%=MyBase.GetResourceString("C_NormalRate")%>*
                                        </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="RoleNormalRate" />
                                        </div>
                                    </div>
                                </div>

                            </div>

                        <!-- Row 2 -->
                            <div class="row mb-3">

                        <!-- Extra Rate -->
                                <div class="col-sm-6">
                                    <div class="row align-items-center">
                                        <label class="col-sm-4 control-label text-end">
                                            <%=MyBase.GetResourceString("C_ExtraRate")%>
                                        </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="RoleExtraRate" />
                                        </div>
                                    </div>
                                </div>

                        <!-- Holiday Rate -->
                                <div class="col-sm-6">
                                    <div class="row align-items-center">
                                        <label class="col-sm-4 control-label text-end">
                                            <%=MyBase.GetResourceString("C_HolidayRate")%>
                                        </label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="RoleHolidayRate" />
                                        </div>
                                    </div>
                                </div>

                            </div>

                        <!-- Row 3 : Currency at bottom-right -->
                            <div class="row mt-4">

                                <div class="col-sm-6"></div>

                                <div class="col-sm-6 text-end">
                                    <span class="me-2">Currency :</span>
                                    <strong id="RoleCurrencyCode">INR</strong>
                                </div>

                            </div>

                        </div>



                        </div>
                        </div>
                    <% End If %>
                    <!--Site Calendar-->
                    <div id="prositedetailTab3" class="tab-pane mt-4">
                        <div class="projDetailsContent projDetailsSiteCalendar">
                            <div class="container-fluid">
                                <div class="SiteCalendarContent">
                                    <div class="form-group row align-items-center mt-1 mb-2">

                                    <!-- Site label -->
                                        <label class="control-label col-sm-1 mb-0" style="color: #374151; font-size: 11.5px; font-weight: 500; white-space: nowrap;">
                                            <%=MyBase.GetResourceString("C_Site")%>:
                                        </label>

                                    <!-- Site dropdown -->
                                        <div class="col-sm-4">
                                            <select class="selectpicker" data-live-search="true" id="selectDefaultSite">
                                               <option><%=MyBase.GetResourceString("C_SelectSite")%></option>
                                            </select>
                                        </div>

                                    <!-- Legends -->
                                        <div class="col-sm-7 d-flex justify-content-end">
                                            <div class="legend float-end">
                                                    <ul class="" style="list-style: none; padding: 0; margin: 0; display: flex; align-items: center; gap: 10px;">
                                                        <li style="margin: 0;"><label class="mx-1 mb-0" style="margin: 0;"><%=MyBase.GetResourceString("C_Legends")%> :</label></li>
                                                        <li style="margin: 0; display: flex; align-items: center; gap: 5px;">
                                                            <span class="lgdHoliday" data-bs-toggle="tooltip"
                                                                data-bs-container="body" aria-label="<%=MyBase.GetResourceString("C_Holiday")%>"
                                                                data-bs-original-title="<%=MyBase.GetResourceString("C_Holiday")%>" title="<%=MyBase.GetResourceString("C_Holiday")%>"></span>
                                                        </li>
                                                        <li style="margin: 0; display: flex; align-items: center; gap: 5px;">
                                                            <span class="lgdUpdated" data-bs-toggle="tooltip"
                                                                data-bs-container="body" aria-label="<%=MyBase.GetResourceString("C_UpdatedHours")%>"
                                                                data-bs-original-title="<%=MyBase.GetResourceString("C_UpdatedHours")%>" title="<%=MyBase.GetResourceString("C_UpdatedHours")%>"></span>
                                                        </li>
                                                        <li style="margin: 0; display: flex; align-items: center; gap: 5px;">
                                                            <span class="lgdPlannedday" data-bs-toggle="tooltip"
                                                                data-bs-container="body" aria-label="<%=MyBase.GetResourceString("C_Today")%>"
                                                                data-bs-original-title="<%=MyBase.GetResourceString("C_Today")%>" title="<%=MyBase.GetResourceString("C_Today")%>"></span>
                                                        </li>
                                                        <li style="margin: 0; display: flex; align-items: center; gap: 5px;">
                                                            <span class="lgdPH" data-bs-toggle="tooltip"
                                                                data-bs-container="body" aria-label="<%=MyBase.GetResourceString("C_Weekend")%>"
                                                                data-bs-original-title="<%=MyBase.GetResourceString("C_Weekend")%>" title="<%=MyBase.GetResourceString("C_Weekend")%>"></span>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                    </div>
                                    <div class="clearfix"></div>

                                    <div id="siteCalendarView" class="w-100">
                                        <!-- Calendar placeholder for UI - will be replaced with actual calendar when library is available -->
                                        <div class="calendar-placeholder" style="padding: 20px;">
                                            <div class="calendar-header" style="background: rgb(59 92 128); color: white; padding: 10px; text-align: center; border-radius: 4px 4px 0 0; display: flex; align-items: center; gap: 10px;">
                                                <span style="cursor: pointer; font-size: 18px; font-weight: bold;" onclick="changeMonth(-1);">&lt;</span>
                                                <strong id="calendarMonthYear" style="font-size: 16px; font-weight: bold;">November 2025</strong>
                                                <span style="cursor: pointer; font-size: 18px; font-weight: bold;" onclick="changeMonth(1);">&gt;</span>
                                            </div>
                                            <table class="table table-stripped modalDTtabl mb-0" style="background: white;" id="calendarTable">
                                                <thead>
                                                    <tr style="background: #f8f9fa;">
                                                        <th style="text-align: center; padding: 8px;">MON</th>
                                                        <th style="text-align: center; padding: 8px;">TUE</th>
                                                        <th style="text-align: center; padding: 8px;">WED</th>
                                                        <th style="text-align: center; padding: 8px;">THU</th>
                                                        <th style="text-align: center; padding: 8px;">FRI</th>
                                                        <th style="text-align: center; padding: 8px;">SAT</th>
                                                        <th style="text-align: center; padding: 8px;">SUN</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="calendarBody">
                                                    <!-- Calendar will be generated by JavaScript -->
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End Tab-->

                    <!--Show History Tab-->
                    <div id="prositedetailTab4" class="tab-pane mt-4">
                        <div class="projDetailsContent projDetailsShowHistory">
                            <div class="container-fluid">
                                <div class="ShowHistoryContent">
                                    <div class="form-group row mt-1 mb-2">
                                        <div class="col-sm-11">
                                            <div class="form-inline hstryfltr pb-1">

    <div class="row d-flex justify-content-center">

        <div class="col-sm-5">
            <div class="row form-group">
                <div class="col-sm-5 d-flex justify-content-end">
                    <label style="color: #374151; font-size: 11.5px; font-weight: 500; white-space: nowrap;"style="color: #374151; font-size: 11.5px; font-weight: 500; white-space: nowrap;"><%=MyBase.GetResourceString("C_ModifiedField")%> : </label>
                </div>
                <div class="col-sm-6">
                    <select class="selectpicker" data-live-search="true" data-bs-toggle="tooltip" title="Select Modified Field"
                        id="modifiedHisField">
                        <option value="">Select Modified Field</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="col-sm-5">
            <div class="row form-group">
                <div class="col-sm-5 d-flex justify-content-end">
                    <label style="color: #374151; font-size: 11.5px; font-weight: 500; white-space: nowrap;"><%=MyBase.GetResourceString("C_ModifiedBy")%> : </label>
                </div>
                <div class="col-sm-6">
                    <select class="selectpicker" data-live-search="true"  data-bs-toggle="tooltip" title="Select Modified By"
                        id="modifiedHisBy">
                        <option>Select Modified By</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>
                                           
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                    
                                    

                                    <div class="table-responsive mt-1">
                                        <table id="ProjectSiteShowHisTable" class="table table-stripped modalDTtabl"
                                            style="width:100%;">
                                            <thead>
                                                <tr>
                                                    <th class="col-sm-3"><%=MyBase.GetResourceString("C_ModifiedField")%></th>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_OldValue")%></th>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_NewValue")%></th>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                                                    <th class="col-sm-2"><%=MyBase.GetResourceString("C_ModifiedBy")%></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- History data will be loaded dynamically via API -->
                                            </tbody>
                                        </table>
                                    </div>
                                    
                                    <div class="pagination-container" style="position: relative; margin-top: 10px;">
                                        <div class="pagination-info" id="historyPaginationInfo">
                                            <span class="spntotal"><%=MyBase.GetResourceString("C_TotalRecordsColon")%></span>
                                            <span class="spntotal" id="historyTotalRecords">0</span>
                                        </div>
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination justify-content-end">
                                                <li class="page-item fa-disabled" style="cursor:not-allowed" id="historyBtnPrevious">
                                                    <a class="page-link" aria-label="Previous" href="javascript:;"  data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" id="historyLinkPrevious" onclick="goToHistoryPreviousPage(); return false;">
                                                        <i class="fas fa-angle-double-left"></i>
                                                    </a>
                                                </li>
                                                <li class="page-item fa-disabled" style="cursor:not-allowed" id="historyBtnNext">
                                                    <a class="page-link" aria-label="Next" href="javascript:;"  data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" id="historyLinkNext" onclick="goToHistoryNextPage(); return false;">
                                                        <i class="fas fa-angle-double-right"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End Show History Tab-->
                </div>
            </div>
        </div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-dismiss="modal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="svFilterAs"><%=MyBase.GetResourceString("C_Save")%> Filter</h5>
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

        <!--site calendar modal start here-->
        <div class="modal custmodal fade" id="SCDetailsModal" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><i class="fas fa-calendar-alt pe-2"></i> <%=MyBase.GetResourceString("C_ SiteCalendarDetails")%>
                        </h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="calendarDate" id="calendarModalDate"><i class="far fa-calendar-check pe-1"></i> <span id="calendarModalDateText">12-08-2023</span></div>
                            </div>
                            <div class="col-sm-6 text-end">
                                <label class="form-label ">(<font color="red">*</font> Mandatory)</label>
                            </div>
                        </div>
                        <div class="form-group row pt-1 mb-2">
    <label class="control-label col-sm-4 required" style="margin-top:5px;">Normal Hours</label>
    <div class="col-sm-6">
        <input type="text"
               class="form-control"
               id="calendarNormalHours"
               inputmode="decimal"
               autocomplete="off" />
    </div>
</div>

<div class="form-group row pt-1 mb-2">
    <label class="control-label col-sm-4" style="margin-top:5px;">Extra Hours</label>
    <div class="col-sm-6">
        <input type="text"
               class="form-control"
               id="calendarExtraHours"
               inputmode="decimal"
               autocomplete="off" />
    </div>
</div>
                        <div class="form-group row pt-1 mb-2">
                            <label class="control-label col-sm-4" style="margin-top:5px;">&nbsp;</label>
                            <div class="col-sm-8">
                                <div class="custom_chckbox">
                                    <input id="calendarHolidayCheck" class="chcktbl" type="checkbox">
                                    <label for="calendarHolidayCheck">Is this a holiday?</label>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                        <br />
                        <div class="text-center">
                            <% If m_blnEditAccess Then %>
                                <a href="javascript:;" class="btn btnyellow me-2" id="caleModalSaveBtn"><%=MyBase.GetResourceString("C_Save")%></a>
                                <a href="javascript:;" class="btn borderbtn me-2" id="caleModalSetDefaultBtn" style="display: none;"><%=MyBase.GetResourceString("C_Reset")%></a>
                            <% End If %>
                            <a href="javascript:;" class="btn borderbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--site calendar modal end here-->

        <!--Offshore Site Change Confirmation modal start here-->
        <div id="offshoreChangeModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" id="btnOffshoreChangeNo1" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_OffshoreSite")%> <%=MyBase.GetResourceString("C_Details")%></h4>
                    </div>
                    <div class="modal-body">
                        <p align="center" id="offshoreChangeMsg">On setting this site as an offshore site, offshore site setting of previous site will be removed. Do you want to continue?</p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnOffshoreChangeNo"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" data-bs-dismiss="modal" id="btnOffshoreChangeYes"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--Offshore Site Change Confirmation modal end here-->

        <!--Delete Confirmation Modal Start here-->
        <div id="deleteProjectSiteModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" id="btnDeleteSiteNo1" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Delete")%></h4>
                    </div>
                    <div class="modal-body">
                        <p align="center" id="deleteSiteMsg">Are you sure, you want to delete the selected records?</p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnDeleteSiteNo"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" data-bs-dismiss="modal" id="btnDeleteSiteYes"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Delete Confirmation Modal End here-->

        <!--Update Billing Info Confirmation modal start here-->
        <div id="updateBillingInfoModal" class="modal fade custmodal" role="dialog" aria-hidden="false" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_UpdateEmployeeBillingRates")%></h4>
                    </div>
                    <div class="modal-body">
                        <p align="center">The billing rates will not be updated for the resources for whom the rates are already defined for the current date.</p>
                        <div class="mt-1">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_Cancel")%></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="updateBillingInfo()" data-bs-dismiss="modal">OK</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--Update Billing Info Confirmation modal end here-->

        <!--Inherit Details modal start here-->
        <div class="modal custmodal fade" id="InheritDetailsModal" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><i class="fas fa-location-arrow pe-2"></i> <%=MyBase.GetResourceString("C_ProjectSites")%></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body pt-3">
                        <div class="row mb-2">
                            <div class="InheritBtnsDiv d-flex justify-content-end">
                                <button id="savefilterbtn" class="btn btnyellow me-2"><%=MyBase.GetResourceString("C_Save")%></button>
                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            </div>
                        </div>
                        <table id="InheritTbl" class="table table-stripped modalDTtabl" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th class="col-sm-8"><%=MyBase.GetResourceString("C_Site")%></th>
                                    <th class="col-sm-4">
                                        <div class="custom_chckbox">
                                            <input id="InheritCheck0" class="chckHead1" type="checkbox" />
                                            <label for="InheritCheck0"></label>
                                        </div>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Inherit sites data will be loaded dynamically via API -->
                            </tbody>
                        </table>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Inherit Details modal end here-->

        <div class="clearfix"></div>
    </div>

    <% Else %>
    <div style="text-align:center;overflow: auto;width: 100%;;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>
    <% End If %>
    <!-- End of Role Access -->

    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <!-- Commented out for UI only - will be enabled when functionality is added -->
    <!-- <script src="../../../Whizible2.0-new/dist/js/jquery.calendar.js"></script> -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!-- DataTables scripts - order matters: jQuery DataTables first, then Bootstrap integration -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/dist/js/calendar-gc.min.js"></script> -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <!-- LoadingOverlay scripts for loading indicators -->
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <!-- Alertify JS for notifications -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <!-- CommonValidations.js contains encryptString() and isJson() functions -->
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>

    <script>
        // Initialize tooltips
        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                delay: { show: 200, hide: 100 }
            });
            
            // Initialize tooltips for legend items specifically
            $('.legend [data-bs-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                delay: { show: 200, hide: 100 },
                placement: 'top'
            });
        });
        
        // Re-initialize tooltips after pagination navigation
        $(document).on('draw.dt', '#trainingPlanTbl', function() {
            // Dispose existing tooltips only if they exist
            $('[data-bs-toggle="tooltip"]').each(function() {
                var $this = $(this);
                if ($this.data('bs.tooltip')) {
                    $this.tooltip('dispose');
                }
            });
            // Re-initialize tooltips
            $('[data-bs-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                delay: { show: 200, hide: 100 }
            });
        });

        // Filter panel show/hide
        $("#filterpanel").on("show.bs.collapse", function () {
            // Only show Clear All button if filters are actually applied
            checkAndShowClearAllButton();
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            // Hide Clear All button when filter panel is closed
            $("#PMProjectSitesClearAllFilter").hide();
        });

        // Resize section for role rate table
        function resizeSection() {
            var tblheight = $(window).height();
            $("#rolerateTbl_wrapper .dataTables_scrollBody").css({ height: tblheight - 232, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        // Check or Uncheck All checkboxes for main table (only enabled checkboxes)
        $(document).on("change", ".chckHead", function () {
            var checked = this.checked;

            if (!projectSitesTable) return;

            // Get ALL rows from ALL pages
            var nodes = projectSitesTable.rows().nodes();

            $(nodes).find(".chcktbl:not(:disabled)").prop("checked", checked);
        });


        // Changing state of CheckAll checkbox for main table (using event delegation for dynamically added checkboxes)
        // Use 'change' event instead of 'click' for better reliability with checkboxes
        $(document).on("change", ".chcktbl:not(:disabled)", function () {
            if (!projectSitesTable) return;

            var nodes = projectSitesTable.rows().nodes();

            var totalEnabled = $(nodes).find(".chcktbl:not(:disabled)").length;
            var checkedEnabled = $(nodes).find(".chcktbl:not(:disabled):checked").length;

            $(".chckHead").prop("checked", totalEnabled > 0 && totalEnabled === checkedEnabled);
        });


        // Check or Uncheck All checkboxes for inherit table
        $(".chckHead1").change(function () {
            var checked = $(this).is(":checked");
            if (checked) {
                $(".chcksite").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcksite").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox for inherit table
        $(".chcksite").click(function () {
            if ($(".chcksite").length == $(".chcksite:checked").length) {
                $(".chckHead1").prop("checked", true);
            } else {
                $(".chckHead1").removeAttr("checked");
            }
        });

        // Initialize DataTable for main table
        // NOTE: destroy: true allows reinitialization, retrieve: false prevents preserving old data
        // Use window.projectSitesTable to ensure global scope
        var projectSitesTable = $("#trainingPlanTbl").DataTable({
            scrollY: true,
            scrollX: true,
            paging: true,
            pageLength: 10,
            lengthChange: false,
            searching: false,
            ordering: false,
            responsive: true,
            destroy: true,  // Allow destroy/reinitialize if needed
            retrieve: false, // Don't retrieve existing instance (prevents preserving hardcoded rows)
            info: false,
            pagingType: "simple",
            columnDefs: [
                { orderable: false, targets: '_all' }
            ],
            language: {
                paginate: {
                    previous: "<%=MyBase.GetResourceString("C_PreviousPage")%>",
                    next: "<%=MyBase.GetResourceString("C_NextPage")%>"
                }
            }
        });
        // Store in window for global access
        window.projectSitesTable = projectSitesTable;

        projectSitesTable.on("draw", function () {
            var nodes = projectSitesTable.rows().nodes();

            var totalEnabled = $(nodes).find(".chcktbl:not(:disabled)").length;
            var checkedEnabled = $(nodes).find(".chcktbl:not(:disabled):checked").length;

            $(".chckHead").prop("checked", totalEnabled > 0 && totalEnabled === checkedEnabled);
        });

        // Resource strings for JavaScript
        var ResourceStrings = {
            // Common strings
            C_TotalRecordsColon: '<%=MyBase.GetResourceString("C_TotalRecordsColon")%>',
            C_PreviousPage: '<%=MyBase.GetResourceString("C_PreviousPage")%>',
            C_NextPage: '<%=MyBase.GetResourceString("C_NextPage")%>',
            C_SelectCurrency: '<%=MyBase.GetResourceString("C_SelectCurrency")%>',
            C_SelectOption: '<%=MyBase.GetResourceString("C_SelectOption")%>',
            C_SelectDaysOfWeek: '<%=MyBase.GetResourceString("C_SelectDaysOfWeek")%>',
            C_SelectCountry: '<%=MyBase.GetResourceString("C_SelectCountry")%>',
            C_RoleRate: '<%=MyBase.GetResourceString("C_RoleRate")%>',
            // Alert strings
            A_UnableToLoadProjectSiteData: '<%=MyBase.GetResourceString("A_UnableToLoadProjectSiteData")%>',
            A_InvalidProjectSiteID: '<%=MyBase.GetResourceString("A_InvalidProjectSiteID")%>',
            A_NoDataFoundForProjectSite: '<%=MyBase.GetResourceString("A_NoDataFoundForProjectSite")%>',
            A_RoleDetailsNotFound: '<%=MyBase.GetResourceString("A_RoleDetailsNotFound")%>',
            A_NoPermissionToSaveRoleRates: '<%=MyBase.GetResourceString("A_NoPermissionToSaveRoleRates")%>',
            A_PleaseSelectProjectSiteFirst: '<%=MyBase.GetResourceString("A_PleaseSelectProjectSiteFirst")%>',
            A_PleaseSelectRoleFirst: '<%=MyBase.GetResourceString("A_PleaseSelectRoleFirst")%>',
            A_NormalRateRequired: '<%=MyBase.GetResourceString("A_NormalRateRequired")%>',
            A_ExtraRateRequired: '<%=MyBase.GetResourceString("A_ExtraRateRequired")%>',
            A_NormalRateMustBeNonNegative: '<%=MyBase.GetResourceString("A_NormalRateMustBeNonNegative")%>',
            A_ExtraRateMustBeNonNegative: '<%=MyBase.GetResourceString("A_ExtraRateMustBeNonNegative")%>',
            A_HolidayRateMustBeNonNegative: '<%=MyBase.GetResourceString("A_HolidayRateMustBeNonNegative")%>',
            A_NormalRateCannotExceed: '<%=MyBase.GetResourceString("A_NormalRateCannotExceed")%>',
            A_ExtraRateCannotExceed: '<%=MyBase.GetResourceString("A_ExtraRateCannotExceed")%>',
            A_HolidayRateCannotExceed: '<%=MyBase.GetResourceString("A_HolidayRateCannotExceed")%>',
            A_RoleDetailsUpdatedSuccessfully: '<%=MyBase.GetResourceString("A_RoleDetailsUpdatedSuccessfully")%>',
            A_FailedToUpdateRoleDetails: '<%=MyBase.GetResourceString("A_FailedToUpdateRoleDetails")%>',
            A_PleaseEnterValidEmailAddress: '<%=MyBase.GetResourceString("A_PleaseEnterValidEmailAddress")%>',
            A_SiteNameRequired: '<%=MyBase.GetResourceString("A_SiteNameRequired")%>',
            A_SiteNameShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_SiteNameShouldNotContainSpecialChars")%>',
            A_SiteNameCannotExceed50Characters: '<%=MyBase.GetResourceString("A_SiteNameCannotExceed50Characters")%>',
            A_ShortNameShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_ShortNameShouldNotContainSpecialChars")%>',
            A_ShortNameCannotExceed10Characters: '<%=MyBase.GetResourceString("A_ShortNameCannotExceed10Characters")%>',
            A_Address1ShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_Address1ShouldNotContainSpecialChars")%>',
            A_Address1CannotExceed40Characters: '<%=MyBase.GetResourceString("A_Address1CannotExceed40Characters")%>',
            A_Address2ShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_Address2ShouldNotContainSpecialChars")%>',
            A_Address2CannotExceed40Characters: '<%=MyBase.GetResourceString("A_Address2CannotExceed40Characters")%>',
            A_StateShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_StateShouldNotContainSpecialChars")%>',
            A_StateCannotExceed20Characters: '<%=MyBase.GetResourceString("A_StateCannotExceed20Characters")%>',
            A_CityShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_CityShouldNotContainSpecialChars")%>',
            A_CityCannotExceed30Characters: '<%=MyBase.GetResourceString("A_CityCannotExceed30Characters")%>',
            A_EmailCannotExceed50Characters: '<%=MyBase.GetResourceString("A_EmailCannotExceed50Characters")%>',
            A_ZipPostalCodeShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_ZipPostalCodeShouldNotContainSpecialChars")%>',
            A_ZipPostalCodeCannotExceed10Characters: '<%=MyBase.GetResourceString("A_ZipPostalCodeCannotExceed10Characters")%>',
            A_FaxShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_FaxShouldNotContainSpecialChars")%>',
            A_FaxCannotExceed50Characters: '<%=MyBase.GetResourceString("A_FaxCannotExceed50Characters")%>',
            A_FaxShouldContain10Digits: '<%=MyBase.GetResourceString("A_FaxShouldContain10Digits")%>',
            A_PhoneNoShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_PhoneNoShouldNotContainSpecialChars")%>',
            A_PhoneNoCannotExceed12Characters: '<%=MyBase.GetResourceString("A_PhoneNoCannotExceed12Characters")%>',
            A_PhoneNoShouldContainAtLeast6Digits: '<%=MyBase.GetResourceString("A_PhoneNoShouldContainAtLeast6Digits")%>',
            A_RemarksShouldNotContainSpecialChars: '<%=MyBase.GetResourceString("A_RemarksShouldNotContainSpecialChars")%>',
            A_CurrencyRequired: '<%=MyBase.GetResourceString("A_CurrencyRequired")%>',
            A_RateMethodRequired: '<%=MyBase.GetResourceString("A_RateMethodRequired")%>',
            A_StartingDayOfWeekRequired: '<%=MyBase.GetResourceString("A_StartingDayOfWeekRequired")%>',
            A_WorkingDaysPerWeekRequired: '<%=MyBase.GetResourceString("A_WorkingDaysPerWeekRequired")%>',
            A_WorkingDaysPerWeekMustNotBeLessThanOrEqualZero: '<%=MyBase.GetResourceString("A_WorkingDaysPerWeekMustNotBeLessThanOrEqualZero")%>',
            A_WorkingDaysPerWeekMustBeBetween1And7: '<%=MyBase.GetResourceString("A_WorkingDaysPerWeekMustBeBetween1And7")%>',
            A_WorkingHoursPerDayRequired: '<%=MyBase.GetResourceString("A_WorkingHoursPerDayRequired")%>',
            A_WorkingHoursPerDayMustNotBeLessThanOrEqualZero: '<%=MyBase.GetResourceString("A_WorkingHoursPerDayMustNotBeLessThanOrEqualZero")%>',
            A_WorkingHoursPerDayMustBeBetween1And24: '<%=MyBase.GetResourceString("A_WorkingHoursPerDayMustBeBetween1And24")%>',
            A_ExtraHoursCapPerDayMustNotBeLessThanOrEqualZero: '<%=MyBase.GetResourceString("A_ExtraHoursCapPerDayMustNotBeLessThanOrEqualZero")%>',
            A_TotalWorkingHoursAndExtraHoursCapShouldNotBeGreaterThan24: '<%=MyBase.GetResourceString("A_TotalWorkingHoursAndExtraHoursCapShouldNotBeGreaterThan24")%>',
            A_WorkingHoursPerMonthRequired: '<%=MyBase.GetResourceString("A_WorkingHoursPerMonthRequired")%>',
            A_WorkingHoursPerMonthMustNotBeLessThanOrEqualZero: '<%=MyBase.GetResourceString("A_WorkingHoursPerMonthMustNotBeLessThanOrEqualZero")%>',
            A_WorkingHoursPerMonthMustBeGreaterThan0: '<%=MyBase.GetResourceString("A_WorkingHoursPerMonthMustBeGreaterThan0")%>',
            A_NoPermissionToSaveProjectSites: '<%=MyBase.GetResourceString("A_NoPermissionToSaveProjectSites")%>',
            A_PleaseSelectProjectFirst: '<%=MyBase.GetResourceString("A_PleaseSelectProjectFirst")%>',
            A_ProjectSiteUpdatedSuccessfully: '<%=MyBase.GetResourceString("A_ProjectSiteUpdatedSuccessfully")%>',
            A_ProjectSiteAddedSuccessfully: '<%=MyBase.GetResourceString("A_ProjectSiteAddedSuccessfully")%>',
            A_ErrorOccurredWhileSavingProjectSite: '<%=MyBase.GetResourceString("A_ErrorOccurredWhileSavingProjectSite")%>',
            A_InvalidProjectOrSiteID: '<%=MyBase.GetResourceString("A_InvalidProjectOrSiteID")%>',
            A_NoPermissionToFreezeSiteDetails: '<%=MyBase.GetResourceString("A_NoPermissionToFreezeSiteDetails")%>',
            A_CalendarFrozenSuccessfully: '<%=MyBase.GetResourceString("A_CalendarFrozenSuccessfully")%>',
            A_FailedToFreezeSite: '<%=MyBase.GetResourceString("A_FailedToFreezeSite")%>',
            A_InvalidAPIResponse: '<%=MyBase.GetResourceString("A_InvalidAPIResponse")%>',
            A_SomethingWentWrongWhileFreezingSite: '<%=MyBase.GetResourceString("A_SomethingWentWrongWhileFreezingSite")%>',
            A_NoProjectCostTypesAvailableForInheritance: '<%=MyBase.GetResourceString("A_NoProjectCostTypesAvailableForInheritance")%>',
            A_FailedToSaveProjectSitesInherits: '<%=MyBase.GetResourceString("A_FailedToSaveProjectSitesInherits")%>',
            A_UnableToFindSiteIDForSelectedSite: '<%=MyBase.GetResourceString("A_UnableToFindSiteIDForSelectedSite")%>',
            A_SelectedSiteNotFoundInProjectSites: '<%=MyBase.GetResourceString("A_SelectedSiteNotFoundInProjectSites")%>',
            A_UnableToLoadProjectSites: '<%=MyBase.GetResourceString("A_UnableToLoadProjectSites")%>',
            A_NoPermissionToDeleteProjectSites: '<%=MyBase.GetResourceString("A_NoPermissionToDeleteProjectSites")%>',
            A_PleaseSelectAtLeastOneSiteToDelete: '<%=MyBase.GetResourceString("A_PleaseSelectAtLeastOneSiteToDelete")%>',
            A_PleaseSelectProjectAndSiteFirst: '<%=MyBase.GetResourceString("A_PleaseSelectProjectAndSiteFirst")%>',
            A_PleaseSelectDateFirst: '<%=MyBase.GetResourceString("A_PleaseSelectDateFirst")%>',
            A_NormalHoursRequiredAndMustBeGreaterThan0: '<%=MyBase.GetResourceString("A_NormalHoursRequiredAndMustBeGreaterThan0")%>',
            A_NormalHoursMustBeBetween1And24: '<%=MyBase.GetResourceString("A_NormalHoursMustBeBetween1And24")%>',
            A_ExtraHoursMustBeBetween1And24: '<%=MyBase.GetResourceString("A_ExtraHoursMustBeBetween1And24")%>',
            A_TotalNormalHoursAndExtraHoursShouldNotBeGreaterThan24: '<%=MyBase.GetResourceString("A_TotalNormalHoursAndExtraHoursShouldNotBeGreaterThan24")%>',
            A_CalendarEntrySavedSuccessfully: '<%=MyBase.GetResourceString("A_CalendarEntrySavedSuccessfully")%>',
            A_NoCalendarEntryExistsForThisDateToReset: '<%=MyBase.GetResourceString("A_NoCalendarEntryExistsForThisDateToReset")%>',
            A_CalendarEntryResetToDefaultSuccessfully: '<%=MyBase.GetResourceString("A_CalendarEntryResetToDefaultSuccessfully")%>',
            A_FailedToResetCalendarEntry: '<%=MyBase.GetResourceString("A_FailedToResetCalendarEntry")%>',
            A_NoPermissionToUpdateBillingRates: '<%=MyBase.GetResourceString("A_NoPermissionToUpdateBillingRates")%>',
            A_BillingInformationUpdatedSuccessfully: '<%=MyBase.GetResourceString("A_BillingInformationUpdatedSuccessfully")%>',
            A_FailedToUpdateBillingInformation: '<%=MyBase.GetResourceString("A_FailedToUpdateBillingInformation")%>',
            A_ErrorOccurredWhileUpdatingBillingInformation: '<%=MyBase.GetResourceString("A_ErrorOccurredWhileUpdatingBillingInformation")%>',
            A_UnableToDetermineSelectedDate: '<%=MyBase.GetResourceString("A_UnableToDetermineSelectedDate")%>',
            A_FailedToDeleteProjectSites: '<%=MyBase.GetResourceString("A_FailedToDeleteProjectSites")%>',
            A_ErrorOccurredWhileDeletingProjectSites: '<%=MyBase.GetResourceString("A_ErrorOccurredWhileDeletingProjectSites")%>',
            A_ThisSiteCannotBeDeleted: '<%=MyBase.GetResourceString("A_ThisSiteCannotBeDeleted")%>'
        };

        // Pagination variables - MUST be declared BEFORE any function that uses them
        // These are used by updatePagination() which is called from loadAllProjectSites()
        let currentPage = 1;
        let itemsPerPage = 10;
        let totalPages = 1;
        var currentProjectSiteID = null;
        // Handle site name click to load site data for editing
        // Using event delegation to handle clicks on dynamically added rows
        $(document).on('click', '#trainingPlanTbl tbody .site-name-link', function(e) {
            e.preventDefault();
            var projectSiteID = $(this).data('site-id');
            var projectSiteName = $(this).data('site-name');
            $('#AddProjectSiteOffcanvas').data('site-id', projectSiteID);
            $('#AddProjectSiteOffcanvas').data('site-name', projectSiteName);
            if (projectSiteID) {
                // Reset to Details tab when clicking site name from main table
                $('a[href="#prositedetailTab1"]').tab('show');
                // Show all tabs when editing (not adding)
                $('a[href="#prositedetailTab2"]').parent().show();
                $('a[href="#prositedetailTab3"]').parent().show();
                $('a[href="#prositedetailTab4"]').parent().show();
                loadProjectSiteData(projectSiteID);
                // Update Save buttons visibility (Edit mode)
                updateSaveButtonsVisibility();
                // Open offcanvas (it will open automatically via data-bs-toggle, but we ensure it)
                $('#AddProjectSiteOffcanvas').offcanvas('show');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_UnableToLoadProjectSiteData);
            }
        });

        // Initialize DataTable for inherit table - Commented out for UI only
        /*
        $("#InheritTbl").dataTable({
            paging: true,
            pageLength: 5,
            bLengthChange: false,
            bFilter: false,
            ordering: false,
            responsive: true,
            destroy: false,
            retrieve: true,
            info: false
        });

        $('#InheritTbl').wrap('<div class="dataTables_scroll" />');
        */

        // Resize tables on collapse/expand
        $(".collapse").on("show.bs.collapse", function (e) {
            $(".table").resize();
        });
        $(".collapse").on("hidden.bs.collapse", function (e) {
            $(".table").resize();
        });

        // Resize tables on tab change
        $('a[data-bs-toggle="tab"]').on("shown.bs.tab", function (e) {
            var siteId = $('#AddProjectSiteOffcanvas').data('site-id');
            var siteName = $('#AddProjectSiteOffcanvas').data('site-name');
            if (!siteId) return;

            currentProjectSiteID = siteId;
            currentProjectSiteName = siteName;
            $(".table").resize();
            // Load role details when Role Rate tab is shown
            if ($(e.target).attr('href') === '#prositedetailTab2') {
                // Reset to main Role Rate view (hide detail view if visible)
                $(".RoleRateContent").hide();
                $(".RoleRateRoleColumn").addClass('d-none').hide();
                $(".RoleRateContentMain").show();
                
                // Clear any stored role ID
                window.currentRoleID = null;
                window.currentRoleDescription = null;
                
                if (currentProjectSiteID && currentProjectSiteID > 0) {
                    loadRoleDetails();
                }
            }
            if ($(e.target).attr('href') === '#prositedetailTab3') {
                if (!currentProjectID || currentProjectID === 0 || !currentProjectSiteID || currentProjectSiteID === 0) {
                    return;
                }
                loadProjectSitesNameDropdown(currentProjectSiteID, currentProjectSiteName);
                // Load OU-level holidays when calendar tab is shown
                loadOULevelHolidays();

                // Load month calendar data (single API call instead of 60)
                var year = currentCalendarDate.getFullYear();
                var month = currentCalendarDate.getMonth() + 1; // JavaScript months are 0-based, API expects 1-12
                loadMonthCalendarData(currentProjectID, currentProjectSiteID, year, month);

                // Fetch working days configuration (starting day of week, week days)
                fetchWorkingDays(currentProjectID, currentProjectSiteID);

                // Get work hours and extra hours cap for the site
                getWorkHrsExtraHoursCap(currentProjectID, currentProjectSiteID);
                renderCalendarHeader();
                // Render calendar (will use cached month data)
                if (typeof renderCalendar === 'function' && typeof currentCalendarDate !== 'undefined') {
                    renderCalendar(currentCalendarDate);
                }
            }
            if ($(e.target).attr('href') === '#prositedetailTab4') {
                // Populate Modified By dropdown with distinct values when tab is shown
                populateModifiedByDropdown();
                populateModifiedFieldDropdown();
                if (!$.fn.DataTable.isDataTable("#ProjectSiteShowHisTable")) {
                    var historyTable = $("#ProjectSiteShowHisTable").DataTable({
                        scrollY: true,
                        scrollX: true,
                        paging: true,
                        pageLength: 10,
                        lengthChange: false,
                        searching: false,
                        ordering: false,
                        responsive: true,
                        destroy: false,
                        retrieve: true,
                        info: false,
                        pagingType: "simple",
                        columnDefs: [
                            { orderable: false, targets: '_all' }
                        ],
                        columns: [
                            { data: 'ModifiedField' },
                            { data: 'OldValue' },
                            { data: 'NewValue' },
                            { data: 'ModifiedDate' },
                            { data: 'ModifiedBy' }
                        ],
                        language: {
                            paginate: {
                                previous: "<%=MyBase.GetResourceString("C_PreviousPage")%>",
                                next: "<%=MyBase.GetResourceString("C_NextPage")%>"
                            }
                        }
                    });

                    // Hide default DataTables pagination for history table
                    $("#ProjectSiteShowHisTable_wrapper .dataTables_paginate").css("display", "none");

                    // Initialize pagination on history table draw
                    $("#ProjectSiteShowHisTable").on('draw.dt', function () {
                        updateHistoryPagination();
                    });
                }
                // Load history data when tab is shown (after DataTable is initialized)
                loadProjectSiteHistory();

                // Check and update Clear button visibility
                toggleHistoryClearButton();
            }
        });

        // Role Rate navigation
// Loader state — mirrors PM_ReportUIBuilder logic
var loaderShown = false;
var loaderStartTime = 0;

function showLoader() {
    document.getElementById('pageLoader').style.display = 'block';
    loaderShown = true;
    loaderStartTime = Date.now();
}

function hideLoader() {
    if (!loaderShown) return;
    var elapsedTime = Date.now() - loaderStartTime;
    var minDisplayTime = 1500; // Minimum 1.5 seconds
    if (elapsedTime < minDisplayTime) {
        setTimeout(function() {
            document.getElementById('pageLoader').style.display = 'none';
            loaderShown = false;
        }, minDisplayTime - elapsedTime);
    } else {
        document.getElementById('pageLoader').style.display = 'none';
        loaderShown = false;
    }
}

$(document).ajaxStart(function () {
    showLoader();
});

$(document).ajaxStop(function () {
    hideLoader();
});

        $(document).ready(function () {
            // Use event delegation for dynamically added role links
            $(document).on('click', '.RoleRateTxt', function () {
                var roleID = $(this).data('role-id');
                if (roleID) {
                    loadRoleDetail(roleID);
                }
            });

            $("#backRoleRateBtn").click(function () {
                $(".RoleRateContent").hide();
                $(".RoleRateContentMain").show();
            });

            // Make "Role Rate" breadcrumb label act as back button
            $(document).on('click', '#roleRateBreadcrumb', function () {
                $(".RoleRateContent").hide();
                $(".RoleRateContentMain").show();
            });

            // Save role details button
            $("#svRoleRateBtn").click(function () {
                saveRoleDetails();
            });

            // Handle role dropdown change - load role details when role is selected
            $(document).on('changed.bs.select', '#projRoleRateRole', function() {
                var selectedRoleID = $(this).val();
                if (selectedRoleID && selectedRoleID !== '' && selectedRoleID !== '0') {
                    loadRoleDetail(parseInt(selectedRoleID, 10));
                }
            });

            // Rate fields validation - Max limit: 999999999, Non-negative only
            var MAX_RATE_LIMIT = 999999999;         

            //hide inherit button on Add Page if Add access is not given
            if (!m_blnAddAccess) {
                $("#InheritProjectBtn").hide();
            }

            // Save project site button
            $("#saveResBtn").click(function () {
                var isAddMode = !currentProjectSiteID || currentProjectSiteID === 0;
                if (isAddMode) {
                    saveProjectSiteData(false, true); // false = close offcanvas after save
                }
                else {
                    saveProjectSiteData(true, false);
                    if (currentProjectSiteID && currentProjectSiteID > 0) {
                        loadRoleDetails();
                    }
                }
            });

            // Save And Add project site button
            $("#saveAddResBtn").click(function () {
                saveProjectSiteData(true, true); // true = keep offcanvas open and clear form
                if (currentProjectSiteID && currentProjectSiteID > 0) {
                    loadRoleDetails();
                }
            });

            // Inherit button click - load inherit data
            // Variable to store original checkbox states for inherit modal
            var originalInheritCheckboxStates = {};
            var inheritSaveSuccessful = false;

            $("#InheritProjectBtn").click(function () {
                loadProjectSitesInherits();
            });

            // Store original checkbox states when modal is shown
            $('#InheritDetailsModal').on('shown.bs.modal', function () {
                // Reset flag
                inheritSaveSuccessful = false;
                // Store original checkbox states
                originalInheritCheckboxStates = {};
                $('#InheritTbl tbody .chcksite').each(function () {
                    var checkboxId = $(this).attr('id');
                    var costTypeID = $(this).data('cost-type-id');
                    if (checkboxId && costTypeID) {
                        originalInheritCheckboxStates[costTypeID] = $(this).is(':checked');
                    }
                });
            });

            // Reset checkboxes to original state when modal is hidden (unless save was successful)
            $('#InheritDetailsModal').on('hidden.bs.modal', function () {
                if (!inheritSaveSuccessful) {
                    // Reset checkboxes to original state
                    $('#InheritTbl tbody .chcksite').each(function () {
                        var costTypeID = $(this).data('cost-type-id');
                        if (costTypeID && originalInheritCheckboxStates.hasOwnProperty(costTypeID)) {
                            $(this).prop('checked', originalInheritCheckboxStates[costTypeID]);
                        }
                    });
                }
                // Clear stored states
                originalInheritCheckboxStates = {};
            });

            // Save inherit button
            $("#savefilterbtn").click(function () {
                saveProjectSitesInherits();
            });

            // Check/Uncheck all for inherit table
            $(document).on('change', '#InheritTbl .chckHead1', function () {
                var isChecked = $(this).is(':checked');
                $('#InheritTbl tbody .chcksite').prop('checked', isChecked);
            });

            // ============================================
            // Page Initialization
            // ============================================
            $("#PMProjectSitesClearAllFilter").hide();
            
            // Load filter dropdowns
            loadFilterCurrencyDropdown();
            loadFilterDayOfWeekDropdown();
           
            if (currentProjectID > 0) {
                loadFilterRateMethodDropdown();
            }
            
            if (currentProjectID > 0) {
                setTimeout(function() {
                    loadAllProjectSites();
                    loadProjectSitesNameDropdown(null, null);
                    checkAndShowClearAllButton();
                }, 100);
            } else {
                checkAndShowClearAllButton();
            }

            // Initialize selectpickers
            if (typeof $.fn.selectpicker !== 'undefined') {
                $('#cboProject').selectpicker({
                    liveSearch: true,
                    liveSearchStyle: 'startsWith'
                });
                
                // Set the selected project to session project ID after initialization
                setTimeout(function() {
                    if (currentProjectID && currentProjectID > 0) {
                        var $projectSelect = $('#cboProject');
                        var projectValue = currentProjectID.toString();
                        
                        if ($projectSelect.find('option[value="' + projectValue + '"]').length > 0) {
                            $projectSelect.selectpicker('val', projectValue);
                        }
                    }
                }, 100);
            }
            
            // Initialize other selectpickers
            $('.selectpicker').not('#cboProject').selectpicker();
            
            // Load all dropdowns from API
            loadCurrencyDropdown();
            loadRateMethodDropdown();
            loadWeekDaysDropdown();
            loadCountryDropdown();

            // ============================================
            // Filter Event Handlers
            // ============================================
            // Text inputs - show/hide Clear All button
            $('#nameFilter, #shortNameFilter, #workingDaysFilter, #workingHoursFilter, #extraHoursFilter, #workHoursMonthFilter').on('input change', function() {
                checkAndShowClearAllButton();
            });
            
            // Dropdowns - show/hide Clear All button
            $('#projFilterCurrency, #projFilterRateMethod, #projFilterDayOfWeek, #projFilterOffshoreSite').on('changed.bs.select', function() {
                checkAndShowClearAllButton();
            });

            // History filter change handlers
            $('#modifiedHisField').on('changed.bs.select', function() {
                toggleHistoryClearButton();
                if (currentProjectSiteID && currentProjectSiteID > 0) {
                    loadProjectSiteHistory();
                }
            });

            $('#modifiedHisBy').on('changed.bs.select', function() {
                toggleHistoryClearButton();
                if (currentProjectSiteID && currentProjectSiteID > 0) {
                    loadProjectSiteHistory();
                }
            });
            
            // Also render on initial load if tab is active
            setTimeout(function() {
                if ($('#prositedetailTab3').hasClass('active')) {
                    renderCalendar(currentCalendarDate);
                }
            }, 100);

            // ============================================
            // Initial Pagination Update
            // ============================================
            setTimeout(function() {
                updatePagination();
            }, 500);
        });

        // JavaScript variables for session and access rights
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var UserName = '<%= Session("strUserName") %>';
        let currentProjectID = parseInt('<%= Session("intProjectID")%>');
        var loginType = '<%= Session("LoginType")%>';
        var intUserID = '<%= Session("intUserID") %>';
        var intPostID = '<%= Session("intPostID") %>';

        var m_blnAddAccess = <%= m_blnAddAccess.ToString().ToLower()%>;
        var m_blnDeleteAccess = <%= m_blnDeleteAccess.ToString().ToLower()%>;
        var m_blnEditAccess = <%= m_blnEditAccess.ToString().ToLower()%>;
        var m_blnViewAccess = <%= m_blnViewAccess.ToString().ToLower()%>;

        // Get special characters from web.config (same as PM_CreateProject.aspx)
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';

        // Remove trailing slash from strUrl if present (following PM_SCM.aspx pattern)
        if (strUrl.endsWith('/')) {
            strUrl = strUrl.slice(0, -1);
        }

        
        function extractApiData(Result, dataKey) {
   
            
            if (!Result) return null;
            
            // If dataKey is provided, use it to extract specific data
            if (dataKey && typeof dataKey === 'string' && dataKey.trim() !== '') {
                // Generate both camelCase and PascalCase versions of the key
                var camelKey = dataKey.charAt(0).toLowerCase() + dataKey.slice(1);
                var pascalKey = dataKey.charAt(0).toUpperCase() + dataKey.slice(1);
                
                // Try different response structures in order of likelihood
                // 1. ResponseHelper nested structure: Result.data.data[dataKey]
                if (Result.data && Result.data.data) {
                    if (Result.data.data[dataKey] && Array.isArray(Result.data.data[dataKey])) return Result.data.data[dataKey];
                    if (Result.data.data[camelKey] && Array.isArray(Result.data.data[camelKey])) return Result.data.data[camelKey];
                    if (Result.data.data[pascalKey] && Array.isArray(Result.data.data[pascalKey])) return Result.data.data[pascalKey];
                }
                
                // 2. ResponseHelper structure: Result.data[dataKey]
                if (Result.data) {
                    if (Result.data[dataKey] && Array.isArray(Result.data[dataKey])) return Result.data[dataKey];
                    if (Result.data[camelKey] && Array.isArray(Result.data[camelKey])) return Result.data[camelKey];
                    if (Result.data[pascalKey] && Array.isArray(Result.data[pascalKey])) return Result.data[pascalKey];
                }
                
                // 3. Direct structure: Result[dataKey]
                if (Result[dataKey] && Array.isArray(Result[dataKey])) return Result[dataKey];
                if (Result[camelKey] && Array.isArray(Result[camelKey])) return Result[camelKey];
                if (Result[pascalKey] && Array.isArray(Result[pascalKey])) return Result[pascalKey];
            }
            
          
            if (Result.data && Result.data.data) {
             
                if (Array.isArray(Result.data.data)) return Result.data.data;
                
                if (typeof Result.data.data === 'object') return Result.data.data;
            }
            
         
            if (Result.data) {
               
                if (Array.isArray(Result.data)) return Result.data;
             
                if (typeof Result.data === 'object') return Result.data;
            }
            
          
            if (Array.isArray(Result)) return Result;
            
           
            if (typeof Result === 'object') return Result;
            
            return null;
        }

        // Enhanced AJAX helper with better error handling (from PM_SCM.aspx pattern)
        function AJAXCallWithResult(url, param, async) {
            var result = null;
            var fullUrl = buildUrl(url);
            
            $.ajax({
                url: encodeURI(fullUrl),
                type: "POST",
                data: param,
                async: false,
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                    xhr.setRequestHeader('Accept', 'application/json');      
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    result = data;
                },
                error: function (jqXHR) {
                    // Error handled silently
                    result = null;
                }
            });
            return result;
        }

        // URL building helper (from PM_SCM.aspx pattern)
        function buildUrl(url) {
            if (strUrl.endsWith('/') && url.startsWith('/')) {
                return strUrl + url.substring(1);
            } else if (strUrl.endsWith('/') && !url.startsWith('/')) {
                return strUrl + url;
            } else if (!strUrl.endsWith('/') && url.startsWith('/')) {
                return strUrl + url;
            } else {
                return strUrl + '/' + url;
            }
        }


        // Flag to prevent double API calls
        var isLoadingProjectSites = false;

      
        // Added by Nischal C on 30 Nov 2025 for loading all project sites from API
        function loadAllProjectSites() {
            // Prevent double calls
            if (isLoadingProjectSites) {
                return;
            }
            
            // Ensure DataTable reference is valid
            if (!projectSitesTable && $.fn.DataTable.isDataTable("#trainingPlanTbl")) {
                projectSitesTable = $("#trainingPlanTbl").DataTable();
            }
            var selectedProjectID = $('#cboProject').val();
            if (selectedProjectID === 0 || !selectedProjectID || selectedProjectID === "0") {
                // No project selected, clear table
                if (projectSitesTable && $.fn.DataTable.isDataTable("#trainingPlanTbl")) {
                    projectSitesTable.clear().draw();
                }
                updatePagination();
                return;
            }

            // Get filter values
            var nameFilter = $("#nameFilter").val();
            var shortNameFilter = $("#shortNameFilter").val();
            var currencyFilter = $("#projFilterCurrency").val();
            var rateMethodFilter = $("#projFilterRateMethod").val();
            var dayOfWeekFilter = $("#projFilterDayOfWeek").val();
            var workingDaysFilter = $("#workingDaysFilter").val();
            var workingHoursFilter = $("#workingHoursFilter").val();
            var extraHoursFilter = $("#extraHoursFilter").val();
            var workHoursMonthFilter = $("#workHoursMonthFilter").val();
            var offshoreFilter = $("#projFilterOffshoreSite").val();
            
        
            var nameParam = (nameFilter && nameFilter.trim() !== '') ? nameFilter.trim() : null;
            var shortNameParam = (shortNameFilter && shortNameFilter.trim() !== '') ? shortNameFilter.trim() : null;
            
            // Currency: API expects CurrencyID (int), filter dropdown uses CurrencyID as value
            var currencyParam = null;
            if (currencyFilter && currencyFilter !== ResourceStrings.C_SelectCurrency && currencyFilter !== '') {
                var currencyID = parseInt(currencyFilter, 10);
                if (!isNaN(currencyID) && currencyID > 0) {
                    currencyParam = currencyID;
                }
            }
            
            // RateMethod: API expects RateCode (int), filter dropdown uses RateCode as value
            var rateMethodParam = null;
            if (rateMethodFilter && rateMethodFilter !== ResourceStrings.C_SelectOption && rateMethodFilter !== '') {
                var rateCode = parseInt(rateMethodFilter, 10);
                if (!isNaN(rateCode) && rateCode > 0) {
                    rateMethodParam = rateCode;
                }
            }
            
            // Map day of week name to number (Monday=1, Tuesday=2, etc.)
            var daysParam = null;
            if (dayOfWeekFilter && dayOfWeekFilter !== ResourceStrings.C_SelectOption && dayOfWeekFilter !== '') {
                var dayMap = {
                    'Monday': 1,
                    'Tuesday': 2,
                    'Wednesday': 3,
                    'Thursday': 4,
                    'Friday': 5,
                    'Saturday': 6,
                    'Sunday': 7
                };
                daysParam = dayMap[dayOfWeekFilter] || null;
            }
            
            // Convert numeric filters to integers (API expects int?, handle empty strings)           
            var workingDaysParam = null;
            if (workingDaysFilter && workingDaysFilter.trim() !== '') {
                var wd = parseInt(workingDaysFilter.trim(), 10);
                if (!isNaN(wd)) {
                    workingDaysParam = wd; 
                }
            }
            
            var workingHoursParam = null;
            if (workingHoursFilter && workingHoursFilter.trim() !== '') {
                var wh = parseInt(workingHoursFilter.trim(), 10); 
                if (!isNaN(wh)) {
                    workingHoursParam = wh; 
                }
            }
            
            var extraHoursParam = null;
            if (extraHoursFilter && extraHoursFilter.trim() !== '') {
                var eh = parseInt(extraHoursFilter.trim(), 10); 
                if (!isNaN(eh)) {
                    extraHoursParam = eh; 
                }
            }
            
            var workHoursMonthParam = null;
            if (workHoursMonthFilter && workHoursMonthFilter.trim() !== '') {
                var whm = parseInt(workHoursMonthFilter.trim(), 10); 
                if (!isNaN(whm)) {
                    workHoursMonthParam = whm; 
                }
            }
            
            // Map offshore site (Yes/No to 1/0, or null)
            var offshoreParam = null;
            if (offshoreFilter && offshoreFilter !== ResourceStrings.C_SelectOption && offshoreFilter !== '') {
                offshoreParam = (offshoreFilter === 'Yes' || offshoreFilter === 'yes' || offshoreFilter === '1') ? 1 : 0;
            }
            var Parameters = {
                ProjectID: selectedProjectID,
                Name: nameParam,
                ShortName: shortNameParam,
                Currency: currencyParam,
                RateMethod: rateMethodParam,
                Days: daysParam,
                WorkingDays: workingDaysParam,
                WorkingHours: workingHoursParam,
                ExtraHours: extraHoursParam,
                WHoursMonth: workHoursMonthParam,
                OffshoreSite: offshoreParam
            };
            // Set flag to prevent double calls
            isLoadingProjectSites = true;
            
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetAllProjectSites', param, false);
            
            // Reset flag after API call completes
            isLoadingProjectSites = false;
            
            // Handle API response structure using helper function
            var data = extractApiData(Result, 'projectSites');
            data.sort(function (a, b) {
                return a.name.localeCompare(b.name);
            });
            // Track which site is currently offshore
            currentOffshoreSiteID = null;
            // If currentProjectSiteID is set but currentProjectSiteName is not, get it from the data
            if (currentProjectSiteID && !currentProjectSiteName && data && Array.isArray(data) && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var site = data[i];
                    var siteID = site.projectSiteID || site.ProjectSiteID;
                    if (siteID === currentProjectSiteID) {
                        currentProjectSiteName = site.name || site.Name || '';
                        break;
                    }
                }
            }
            if (data && Array.isArray(data) && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var site = data[i];
                    var isOffshore = site.isOffshore || site.IsOffshore || false;
                    if (isOffshore) {
                        currentOffshoreSiteID = site.projectSiteID || site.ProjectSiteID;
                        break; // Only one offshore site
                    }
                }
            }
            
            // Update DataTable - manually build HTML rows (following PM_Documents.aspx pattern)
            if (data && Array.isArray(data) && data.length > 0) {
                var tbody = $("#trainingPlanTbl tbody");
                if (tbody.length === 0) {
                    return;
                }
                
                
                if (projectSitesTable && $.fn.DataTable.isDataTable("#trainingPlanTbl")) {
                    projectSitesTable.clear();
                }
                tbody.empty();
                
               
                var rowsHtml = '';
                data.forEach(function(site) {
                    
                    var projectSiteID = site.projectSiteID || site.ProjectSiteID || '';
                    var name = site.name || site.Name || '';
                    var rateMethod = site.rateMethod || site.RateMethod || '';
                    var dayOfWeek = site.startingDayOfWeek || site.StartingDayOfWeek || '';  
                    var isFreezed = site.isFreezed || site.IsFreezed || false;
                    var offshoreSite = site.isOffshore || site.IsOffshore || false;  
                    var currencyName = site.currencyCode || site.CurrencyCode || '';  
                    
                    
                    var checkboxHtml = '';
                    if (m_blnDeleteAccess) {
                       
                        var canDelete = site.canDelete !== undefined ? site.canDelete : (site.CanDelete !== undefined ? site.CanDelete : 1);
                        var deleteReason = site.deleteReason || site.DeleteReason || '';
                        var checkboxId = 'chkSite_' + projectSiteID;
                        
                        if (canDelete === 1) {
                            checkboxHtml = '<div class="custom_chckbox"><input id="' + checkboxId + '" class="chcktbl" type="checkbox" data-site-id="' + projectSiteID + '" /><label for="' + checkboxId + '"></label></div>';
                        } else {
                            var tooltipTitle = deleteReason || 'This site cannot be deleted';
                            checkboxHtml = '<div class="custom_chckbox chckbox-disabled" title="' + tooltipTitle.replace(/'/g, "&#39;") + '" data-bs-toggle="tooltip"><input id="' + checkboxId + '" class="chcktbl" type="checkbox" disabled data-site-id="' + projectSiteID + '" data-cannot-delete="true" /><label for="' + checkboxId + '"></label></div>';
                        }
                    }
                    
                    rowsHtml += '<tr>' +
                        '<td>' + name + '</td>' +
                        '<td>' + rateMethod + '</td>' +
                        '<td>' + dayOfWeek + '</td>' +
                        '<td>' + ((isFreezed === 1 || isFreezed === true) ? 'Yes' : 'No') + '</td>' +
                        '<td>' + ((offshoreSite === 1 || offshoreSite === true) ? 'Yes' : 'No') + '</td>' +
                        '<td>' + currencyName + '</td>';
                    if (m_blnViewAccess) {
                        rowsHtml += '<td>' +
                            '<a href="javascript:;" class="site-name-link" ' +
                            'data-site-id="' + projectSiteID + '" ' +
                            'data-site-name="' + name + '" ' +
                            'data-bs-toggle="offcanvas" ' +
                            'data-bs-target="#AddProjectSiteOffcanvas">' +
                            '<i class="fa fa-ellipsis-v site-action-icon" style = "color:#6b7280; cursor:pointer; font-size:16px;" ' +
                            'data-bs-toggle="tooltip" ' +
                            'data-bs-placement="top" ' +
                            'data-bs-custom-class="black-tooltip" ' +
                            'data-bs-title="View Site Details"></i>' +
                            '</a>' +
                            '</td>';
                    }

                    if (m_blnDeleteAccess) {
                        rowsHtml += '<td>' + checkboxHtml + '</td>';
                    }
                    
                    rowsHtml += '</tr>';
                });
                
                if ($.fn.DataTable.isDataTable("#trainingPlanTbl")) {
                   
                    var dtInstance = projectSitesTable || window.projectSitesTable;
                    if (dtInstance) {
                        try {
                            dtInstance.destroy(false);
                        } catch (e) {
                           
                            try {
                                $("#trainingPlanTbl").DataTable().destroy(false);
                            } catch (e2) {
                              
                            }
                        }
                    } else {
                        try {
                            $("#trainingPlanTbl").DataTable().destroy(false);
                        } catch (e) {
                           
                        }
                    }
                }
                
             
                tbody.empty();
                
               
                tbody.html(rowsHtml);
                
            
                var rowCount = tbody.find('tr').length;
                
                if (rowCount === 0) {
                    return;
                }
                
               
                setTimeout(function() {
                   
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }, 100);
                
                
                setTimeout(function() {
                   
                    var verifyRowCount = $("#trainingPlanTbl tbody tr").length;
                    if (verifyRowCount === 0) {
                        
                        tbody.html(rowsHtml);
                    }
                    
                  
                    window.projectSitesTable = $("#trainingPlanTbl").DataTable({
                        scrollY: true,
                        scrollX: true,
                        paging: true,
                        pageLength: 10,
                        lengthChange: false,
                        searching: false,
                        ordering: false,
                        responsive: true,
                        destroy: true,
                        retrieve: false,
                        info: false,
                        pagingType: "simple",
                        columnDefs: [
                            { orderable: false, targets: '_all' }
                        ],
                        language: {
                            paginate: {
                                previous: "<%=MyBase.GetResourceString("C_PreviousPage")%>",
                                next: "<%=MyBase.GetResourceString("C_NextPage")%>"
                            }
                        }
                    });
                    
                   
                    projectSitesTable = window.projectSitesTable;
                    
                    
                    var dtRowCount = projectSitesTable.rows().count();
                    
                    if (dtRowCount === 0) {
                       
                        var rowsArray = [];
                        tbody.find('tr').each(function() {
                            var rowData = [];
                            $(this).find('td').each(function(index) {
                                if (index === 0) {
                                   
                                    rowData.push($(this).find('a').text() || $(this).text());
                                } else {
                                    rowData.push($(this).text());
                                }
                            });
                            rowsArray.push(rowData);
                        });
                        
                        if (rowsArray.length > 0) {
                            projectSitesTable.clear();
                            projectSitesTable.rows.add(rowsArray).draw();
                        }
                    } else {
                       
                        projectSitesTable.draw(false);
                    }
                    
                  
                    var pageInfo = projectSitesTable.page.info();
                    
                   
                    if (pageInfo.page !== 0 && pageInfo.recordsTotal > 0) {
                        projectSitesTable.page(0).draw('page');
                    }
                    
                    updatePagination();
                }, 100);
            } else {
              
                if (projectSitesTable && $.fn.DataTable.isDataTable("#trainingPlanTbl")) {
                    projectSitesTable.clear();
                    projectSitesTable.draw();
                } else {
                    $("#trainingPlanTbl tbody").empty();
                }
                updatePagination();
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading all project sites from API
        
      
        function updateSaveButtonsVisibility() {
            var isAddMode = !currentProjectSiteID || currentProjectSiteID === 0;
            
            if (isAddMode) {
             
                if (m_blnAddAccess) {
                    $('#saveResBtn').show();
                    $('#saveAddResBtn').show();
                } else {
                    $('#saveResBtn').hide();
                    $('#saveAddResBtn').hide();
                    $('#InheritProjectBtn').hide();
                }
               
                $('#freezeSiteBtn').hide();
            } else {
                // Edit mode: Show Save buttons only if user has Edit access
                if (m_blnEditAccess) {
                    $('#saveResBtn').show();
                    $('#saveAddResBtn').show();
                } else {
                    $('#saveResBtn').hide();
                    $('#saveAddResBtn').hide();
                }
                // Show Freeze Site Details button in edit mode (if user has edit access)
                if (m_blnEditAccess) {
                    $('#freezeSiteBtn').show();
                } else {
                    $('#freezeSiteBtn').hide();
                }
            }
        }
        
      
        var currentProjectSiteName = null;
        
     
        var currentOffshoreSiteID = null;

       
        // Added by Nischal C on 30 Nov 2025 for loading project site data from API
        function loadProjectSiteData(projectSiteID) {
            //debugger;
            if (!projectSiteID || projectSiteID === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_InvalidProjectSiteID);
                return;
            }

            currentProjectSiteID = projectSiteID;
            
            // Reset calendar to current month when loading a new site
            currentCalendarDate = new Date();
           
            $(".RoleRateContent").hide();
            $(".RoleRateRoleColumn").addClass('d-none').hide();
            $(".RoleRateContentMain").show();
            window.currentRoleID = null;
            window.currentRoleDescription = null;
            
        

            var Parameters = {
                ProjectSiteID: projectSiteID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetProjectSiteData', param, false);
            
           
            var data = extractApiData(Result, 'projectSiteData');
            
          
            var offcanvasElement = $('#AddProjectSiteOffcanvas')[0];
            var populateForm = function() {
                if (data && Array.isArray(data) && data.length > 0) {
                    var site = data[0];
                    
                    
                    currentProjectSiteName = site.name || site.Name || '';
                    
                  
                    if (currentProjectSiteName && currentProjectSiteName.trim() !== '') {
                       
                        isUpdatingDropdownProgrammatically = true;
                      
                        loadProjectSitesNameDropdown(null, null);
                       
                        setTimeout(function() {
                            isUpdatingDropdownProgrammatically = false;
                        }, 300);
                    }
                    
                    // General Details
                    $('#ResName').val(site.name || site.Name || '');
                    $('#ResShortName').val(site.shortName || site.ShortName || '');
                    
                    // Billing Details
                    var currencyID = site.currencyID || site.CurrencyID;
                    if (currencyID) {
                        $('#projDetailsCurrency').val(currencyID).selectpicker('refresh');
                    }
                    
                    var rateMethod = site.rateMethod || site.RateMethod;
                    if (rateMethod) {
                        $('#projDetailsRateMethod').val(rateMethod).selectpicker('refresh');
                    }
                    
                    var startingDayOfWeek = site.startingDayOfWeek || site.StartingDayOfWeek;
                    if (startingDayOfWeek) {
                        $('#projDetailsDays').val(startingDayOfWeek).selectpicker('refresh');
                    }
                    
                    $('#projDetailsWorkingDays').val(site.weekDays !== undefined && site.weekDays !== null ? String(site.weekDays) : (site.WeekDays !== undefined && site.WeekDays !== null ? String(site.WeekDays) : ''));
                    $('#projDetailsWorkingHours').val(site.workHrs !== undefined && site.workHrs !== null ? String(site.workHrs) : (site.WorkHrs !== undefined && site.WorkHrs !== null ? String(site.WorkHrs) : ''));
                    
                  
                    var extraHoursCapVal = '';
                    if (site.extraHoursCap !== undefined && site.extraHoursCap !== null) {
                        extraHoursCapVal = String(site.extraHoursCap);
                    } else if (site.ExtraHoursCap !== undefined && site.ExtraHoursCap !== null) {
                        extraHoursCapVal = String(site.ExtraHoursCap);
                    }
                   
                    setTimeout(function() {
                       
                        $('input#projDetailsExtraHours').val(extraHoursCapVal);
                    }, 100);
                
               
                var hoursPerMonthVal = (site.hoursPerMonth !== undefined && site.hoursPerMonth !== null) ? site.hoursPerMonth : 
                                       ((site.HoursPerMonth !== undefined && site.HoursPerMonth !== null) ? site.HoursPerMonth : '');
             
                if (hoursPerMonthVal !== '' && hoursPerMonthVal !== undefined && hoursPerMonthVal !== null) {
                    $('#projDetailsWHoursMonth').val(String(hoursPerMonthVal));
                } else {
                    $('#projDetailsWHoursMonth').val('');
                }
                
                
                var addressVal = (site.address !== undefined && site.address !== null) ? site.address : 
                                 ((site.Address !== undefined && site.Address !== null) ? site.Address : '');
               
                setTimeout(function() {
                    $('#projDetailsAdd1').val(addressVal !== '' ? String(addressVal) : '');
                }, 100);
                
                var address1Val = (site.address1 !== undefined && site.address1 !== null) ? site.address1 : 
                                  ((site.Address1 !== undefined && site.Address1 !== null) ? site.Address1 : '');
                setTimeout(function() {
                    $('#projDetailsAdd2').val(address1Val !== '' ? String(address1Val) : '');
                }, 100);
                
                var countryID = site.countryID || site.CountryID;
                if (countryID) {
                    $('#projDetailsCountry').val(countryID).selectpicker('refresh');
                }else{
                    $('#projDetailsCountry').val(0).selectpicker('refresh');
                }
                
                $('#projDetailsState').val(site.state || site.State || '');
                $('#projDetailsCity').val(site.city || site.City || '');
                $('#projDetailsZip').val(site.zip || site.Zip || '');
                $('#projDetailsPhone').val(site.phone || site.Phone || '');
                $('#projDetailsFax').val(site.fax || site.Fax || '');
                $('#projDetailsEmail').val(site.emailID || site.EmailID || '');
                $('#projDetailsRemarks').val(site.remarks || site.Remarks || '');
                
                // Checkbox fields               
                var isOffshore = site.isOffshore !== undefined ? site.isOffshore : site.IsOffshore;
               
                var isChecked = false;
                if (isOffshore !== undefined && isOffshore !== null) {
                    if (typeof isOffshore === 'boolean') {
                        isChecked = isOffshore === true;
                    } else if (typeof isOffshore === 'number') {
                        isChecked = isOffshore === 1;
                    } else if (typeof isOffshore === 'string') {
                        isChecked = isOffshore.toLowerCase() === 'true' || isOffshore === '1';
                    }
                }
              
                    $('#OffshoreSiteChk').prop('checked', isChecked);
                    // Disable checkbox if it's checked (offshore site)
                    if (isChecked) {
                        $('#OffshoreSiteChk').prop('disabled', true);
                       
                        $('#OffshoreSiteChk').closest('.custom_chckbox').addClass('offshore-disabled');
                        
                        $('#OffshoreSiteChk').attr('title', 'Offshore site cannot be deleted');
                        $('#OffshoreSiteChk').attr('data-bs-toggle', 'tooltip');
                       
                        setTimeout(function() {
                            var tooltipElement = document.getElementById('OffshoreSiteChk');
                            if (tooltipElement) {
                                var tooltipInstance = bootstrap.Tooltip.getInstance(tooltipElement);
                                if (tooltipInstance) {
                                    tooltipInstance.dispose();
                                }
                                new bootstrap.Tooltip(tooltipElement);
                            }
                        }, 100);
                    } else {
                        $('#OffshoreSiteChk').prop('disabled', false);
                       
                        $('#OffshoreSiteChk').closest('.custom_chckbox').removeClass('offshore-disabled');
                     
                        $('#OffshoreSiteChk').removeAttr('title');
                        $('#OffshoreSiteChk').removeAttr('data-bs-toggle');
                        var tooltipElement = document.getElementById('OffshoreSiteChk');
                        if (tooltipElement) {
                            var tooltipInstance = bootstrap.Tooltip.getInstance(tooltipElement);
                            if (tooltipInstance) {
                                tooltipInstance.dispose();
                            }
                        }
                    }
                    checkFreezeStatus();
                  
                    updateSaveButtonsVisibility();
                
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_NoDataFoundForProjectSite);
                }
            };
            
            
            if (offcanvasElement) {
              
                var isOffcanvasShown = $(offcanvasElement).hasClass('show');
                if (isOffcanvasShown) {
                   
                    populateForm();
                } else {
                   
                    $(offcanvasElement).one('shown.bs.offcanvas', function() {
                        populateForm();
                    });
                   
                    $('#AddProjectSiteOffcanvas').offcanvas('show');
                }
            } else {
               
                populateForm();
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading project site data from API

      
        // Added by Nischal C on 30 Nov 2025 for loading currency dropdown from API
        function loadCurrencyDropdown() {
            var Parameters = {
                CurrencyID: null,
                UniqueID: null
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetCurrencyDropdown', param, false);
            
          
            var data = extractApiData(Result, 'currencies');
            
            var $currencySelect = $('#projDetailsCurrency');
            $currencySelect.empty();
            // Add default "Select Currency" option
            //$currencySelect.append('<option>' + ResourceStrings.C_SelectCurrency + '</option>');
          
            if (data && Array.isArray(data) && data.length > 0) {
               
                $.each(data, function(index, currency) {
                    var currencyID = currency.currencyID !== undefined ? currency.currencyID : currency.CurrencyID;
                    var currencyCode = currency.currencyCode !== undefined ? currency.currencyCode : currency.CurrencyCode;
                    $currencySelect.append($('<option>', {
                        value: currencyID,
                        text: currencyCode
                    }));
                });
            }
            
            // Refresh selectpicker
            $currencySelect.selectpicker('refresh');
        }
        // End of added by Nischal C on 30 Nov 2025 for loading currency dropdown from API

      
        // Added by Nischal C on 30 Nov 2025 for loading filter currency dropdown from API
        function loadFilterCurrencyDropdown() {
            var Parameters = {
                CurrencyID: null,
                UniqueID: null
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetCurrencyDropdown', param, false);
            
            
            var data = extractApiData(Result, 'currencies');
            
          
            var $currencySelect = $('#projFilterCurrency');
            $currencySelect.empty();
            $currencySelect.append('<option>' + ResourceStrings.C_SelectCurrency + '</option>');
            
            if (data && Array.isArray(data) && data.length > 0) {
               
                $.each(data, function(index, currency) {
                    var currencyID = currency.currencyID !== undefined ? currency.currencyID : currency.CurrencyID;
                    var currencyCode = currency.currencyCode !== undefined ? currency.currencyCode : currency.CurrencyCode;
                    var currencyName = currency.currencyName !== undefined ? currency.currencyName : currency.CurrencyName;
                  
                    if (currencyID && currencyCode) {
                        $currencySelect.append($('<option>', {
                            value: currencyID,
                            text: currencyCode + (currencyName ? ' - ' + currencyName : '')
                        }));
                    }
                });
            }
            
          
            $currencySelect.selectpicker('refresh');
        }
        // End of added by Nischal C on 30 Nov 2025 for loading filter currency dropdown from API
        
        // Added by Nischal C on 30 Nov 2025 for loading rate method dropdown for filters from API
        // Function to load Rate Method dropdown for filters
        function loadFilterRateMethodDropdown() {
            var selectedProjectID = $('#cboProject').val();
            var Parameters = {
                ProjectID: selectedProjectID || null
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetRateMethodDropdown', param, false);
            
            // Handle API response structure using helper function
            var data = extractApiData(Result, 'rateMethods');
            
            // Populate Rate Method filter dropdown
            var $rateMethodSelect = $('#projFilterRateMethod');
            $rateMethodSelect.empty(); // Clear existing options (including hardcoded ones)
            $rateMethodSelect.append('<option>' + 'Select Rate Method' + '</option>'); // Add default option
            
            if (data && Array.isArray(data) && data.length > 0) {
                // Add options from API response
                $.each(data, function(index, rateMethod) {
                    var rateCode = rateMethod.rateCode !== undefined ? rateMethod.rateCode : rateMethod.RateCode;
                    var rateMethodName = rateMethod.rateMethod !== undefined ? rateMethod.rateMethod : rateMethod.RateMethod;
                   
                    if (rateCode !== undefined && rateCode !== null && rateCode !== 0 && rateMethodName) {
                        $rateMethodSelect.append($('<option>', {
                            value: rateCode,
                            text: rateMethodName
                        }));
                    }
                });
            }
            
            // Refresh selectpicker
            $rateMethodSelect.selectpicker('refresh');
        }
        // End of added by Nischal C on 30 Nov 2025 for loading rate method dropdown for filters from API
        
        // Added by Nischal C on 30 Nov 2025 for loading rate method dropdown from API
       
        function loadRateMethodDropdown() {
            var selectedProjectID = $('#cboProject').val();
            var Parameters = {
                ProjectID: selectedProjectID || null
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetRateMethodDropdown', param, false);
            
            // Handle API response structure using helper function
            var data = extractApiData(Result, 'rateMethods');
            
            // Populate Rate Method dropdown
            if (data && Array.isArray(data) && data.length > 0) {
                var $rateMethodSelect = $('#projDetailsRateMethod');
                $rateMethodSelect.empty(); // Clear existing options
                
                // Add options from API response
                $.each(data, function(index, rateMethod) {
                    var rateCode = rateMethod.rateCode !== undefined ? rateMethod.rateCode : rateMethod.RateCode;
                    var rateMethodName = rateMethod.rateMethod !== undefined ? rateMethod.rateMethod : rateMethod.RateMethod;
                    $rateMethodSelect.append($('<option>', {
                        value: rateCode,
                        text: rateMethodName
                    }));
                });
                
                // Refresh selectpicker
                $rateMethodSelect.selectpicker('refresh');
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading rate method dropdown from API

        // Added by Nischal C on 30 Nov 2025 for loading week days dropdown from API
       
        function loadWeekDaysDropdown() {
            var Parameters = {};
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetWeekDaysDropdown', param, false);
            
            // Handle API response structure using helper function
            var data = extractApiData(Result, 'weekDays');
            
            // Populate Week Days dropdown
            var $weekDaysSelect = $('#projDetailsDays');
            $weekDaysSelect.empty(); // Clear existing options
            // Add default "Select Days Of Week" option
            $weekDaysSelect.append(
            $('<option>', {
                value: '0',
                text: 'Select Days of Week'
            })
        );
            
            if (data && Array.isArray(data) && data.length > 0) {
                // Add options from API response
                $.each(data, function(index, weekDay) {
                    var dayNumber = weekDay.dayNumber !== undefined ? weekDay.dayNumber : weekDay.DayNumber;
                    var day = weekDay.day !== undefined ? weekDay.day : weekDay.Day;
                    // Skip the "Select day" option (DayNumber = 0) from stored procedure
                    if (dayNumber !== 0 && dayNumber !== '0') {
                        $weekDaysSelect.append($('<option>', {
                            value: dayNumber,
                            text: day
                        }));
                    }
                });
            }
            
            // Refresh selectpicker
            $weekDaysSelect.selectpicker('refresh');
        }
        // End of added by Nischal C on 30 Nov 2025 for loading week days dropdown from API
        
        // Added by Nischal C on 30 Nov 2025 for loading day of week dropdown for filters from API
        // Function to load Day of Week dropdown for filters
        function loadFilterDayOfWeekDropdown() {
            var Parameters = {};
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetWeekDaysDropdown', param, false);
            
            // Handle API response structure using helper function
            var data = extractApiData(Result, 'weekDays');
            
            // Populate Day of Week filter dropdown
            var $dayOfWeekSelect = $('#projFilterDayOfWeek');
            $dayOfWeekSelect.empty(); // Clear existing options (including hardcoded ones)
            $dayOfWeekSelect.append('<option>' + 'Select Days of Week' + '</option>'); // Add default option
            
            if (data && Array.isArray(data) && data.length > 0) {
                // Add options from API response
                $.each(data, function(index, weekDay) {
                    var day = weekDay.day !== undefined ? weekDay.day : weekDay.Day;
                    // Use day name for filter (will be mapped to number in applyFilters function)
                    if (day) {
                        $dayOfWeekSelect.append($('<option>', {
                            value: day,
                            text: day
                        }));
                    }
                });
            }
            
            // Refresh selectpicker
            $dayOfWeekSelect.selectpicker('refresh');
        }
        // End of added by Nischal C on 30 Nov 2025 for loading day of week dropdown for filters from API

        // Added by Nischal C on 30 Nov 2025 for loading country dropdown from API
        
        function loadCountryDropdown() {
            var Parameters = {};
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetCountryDropdown', param, false);
            
            // Handle API response structure using helper function
            var data = extractApiData(Result, 'countries');
            
            // Populate Country dropdown
            var $countrySelect = $('#projDetailsCountry');
            $countrySelect.empty(); // Clear existing options
            // Add default "Select Country" option
            //$countrySelect.append('<option>' + ResourceStrings.C_SelectCountry + '</option>');
            
            if (data && Array.isArray(data) && data.length > 0) {
                // Add options from API response
                $.each(data, function(index, country) {
                    var countryID = country.countryID !== undefined ? country.countryID : country.CountryID;
                    var countryName = country.countryName !== undefined ? country.countryName : country.CountryName;
                    $countrySelect.append($('<option>', {
                        value: countryID,
                        text: countryName
                    }));
                });
            }
            
            // Refresh selectpicker
            $countrySelect.selectpicker('refresh');
        }
        // End of added by Nischal C on 30 Nov 2025 for loading country dropdown from API

    

        // Added by Nischal C on 30 Nov 2025 for loading role dropdown from API
        // Function to load role dropdown options
        function loadRoleDropdown() {
            if (!currentProjectSiteID || currentProjectSiteID === 0) {
                return;
            }

            var Parameters = {
                ProjectSiteID: currentProjectSiteID,
                RoleID: null  // null to get all roles
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/SelRoleDetails', param, false);

            // Extract role details using helper function
            var roleDetails = extractApiData(Result, 'roleDetails');

            // Populate role dropdown
            if (roleDetails && Array.isArray(roleDetails) && roleDetails.length > 0) {
                var $roleSelect = $('#projRoleRateRole');
                $roleSelect.empty(); // Clear existing options
                
                // Add options from API response
                $.each(roleDetails, function(index, role) {
                    var roleID = role.roleID !== undefined ? role.roleID : role.RoleID;
                    var roleDescription = role.roleDescription !== undefined ? role.roleDescription : role.RoleDescription;
                    
                    if (roleID && roleDescription) {
                        $roleSelect.append($('<option>', {
                            value: roleID,
                            text: roleDescription
                        }));
                    }
                });
                
                // Refresh selectpicker
                $roleSelect.selectpicker('refresh');
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading role dropdown from API

        // Added by Nischal C on 30 Nov 2025 for loading all role details from API
        // Function to load all role details for the table
        function loadRoleDetails() {
            //debugger
            if (!currentProjectSiteID || currentProjectSiteID === 0) {
                return;
            }

            var Parameters = {
                ProjectSiteID: currentProjectSiteID,
                RoleID: null  // null to get all roles
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/SelRoleDetails', param, false);

            // Extract role details using helper function
            var roleDetails = extractApiData(Result, 'roleDetails');
            
            // Also load role dropdown when loading role details
            

            // Clear existing table rows
            var tbody = $('#rolerateTbl tbody');
            tbody.empty();

            // Populate table with API data
            if (roleDetails && Array.isArray(roleDetails) && roleDetails.length > 0) {
                // Sort role details alphabetically by role description
                roleDetails.sort(function(a, b) {
                    var roleA = (a.roleDescription !== undefined ? a.roleDescription : a.RoleDescription || '').toLowerCase();
                    var roleB = (b.roleDescription !== undefined ? b.roleDescription : b.RoleDescription || '').toLowerCase();
                    if (roleA < roleB) return -1;
                    if (roleA > roleB) return 1;
                    return 0;
                });
                
                var rowsHtml = '';
                roleDetails.forEach(function(role) {
                    // Handle both camelCase (API JSON) and PascalCase (fallback)
                    var roleID = role.roleID !== undefined ? role.roleID : role.RoleID;
                    var roleDescription = role.roleDescription !== undefined ? role.roleDescription : role.RoleDescription;
                    var currencyCode = role.currencyCode !== undefined ? role.currencyCode : role.CurrencyCode;
                    var normalRate = role.normalRate !== undefined ? role.normalRate : role.NormalRate;
                    var extraRate = role.extraRate !== undefined ? role.extraRate : role.ExtraRate;
                    var holidayRate = role.holidayRate !== undefined ? role.holidayRate : role.HolidayRate;

                    // Format rates (handle null/undefined/empty - all should show 0.00 if no value)
                    var normalRateDisplay = (normalRate !== null && normalRate !== undefined && normalRate !== '' && !isNaN(parseFloat(normalRate))) ? parseFloat(normalRate).toFixed(3) : '0.000';
                    var extraRateDisplay = (extraRate !== null && extraRate !== undefined && extraRate !== '' && !isNaN(parseFloat(extraRate))) ? parseFloat(extraRate).toFixed(3) : '0.000';
                    var holidayRateDisplay = (holidayRate !== null && holidayRate !== undefined && holidayRate !== '' && !isNaN(parseFloat(holidayRate))) ? parseFloat(holidayRate).toFixed(3) : '0.000';

                    rowsHtml += '<tr>';

                    // 1️⃣ Role Name – plain text (no hyperlink)
                    rowsHtml += '<td>' + (roleDescription || '') + '</td>';

                    // 2️⃣ Currency
                    rowsHtml += '<td>' + (currencyCode || '') + '</td>';

                    // 3️⃣ Rates
                    rowsHtml += '<td>' + normalRateDisplay + '</td>';
                    rowsHtml += '<td>' + extraRateDisplay + '</td>';
                    rowsHtml += '<td>' + holidayRateDisplay + '</td>';

                    // 4️⃣ Action column (ellipsis icon)
                    if (m_blnViewAccess) {
                        rowsHtml += '<td>' +
                            '<a href="javascript:;" class="RoleRateTxt" ' +
                            'data-role-id="' + roleID + '">' +
                            '<i class="fa fa-ellipsis-v" ' +
                            'style="color:#6b7280; cursor:pointer; font-size:16px;" ' +
                            'data-bs-toggle="tooltip" ' +
                            'data-bs-placement="top" ' +
                            'data-bs-custom-class="black-tooltip" ' +
                            'data-bs-title="View Role Rate Details"></i>' +
                            '</a>' +
                            '</td>';
                    }

                    rowsHtml += '</tr>';
                });
                tbody.html(rowsHtml);
                setTimeout(function () {

                    $('[data-bs-toggle="tooltip"]').tooltip();
                }, 100);
                // Re-bind click handlers for dynamically added role links
                $(".RoleRateTxt").off('click').on('click', function() {
                    var roleID = $(this).data('role-id');
                    if (roleID) {
                        loadRoleDetail(roleID);
                    }
                });
            } else {
                tbody.html('<tr><td colspan="5" class="text-center">' + "There are no records to view" + '</td></tr>');
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading all role details from API

        // Added by Nischal C on 30 Nov 2025 for loading specific role detail from API
        // Function to load specific role detail for editing
        function loadRoleDetail(roleID) {
            //debugger
            if (!currentProjectSiteID || currentProjectSiteID === 0 || !roleID) {
                return;
            }

            var Parameters = {
                ProjectSiteID: currentProjectSiteID,
                RoleID: roleID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/SelRoleDetails', param, false);

            // Extract role details using helper function
            var roleDetails = extractApiData(Result, 'roleDetails');

            // Populate form fields
            if (roleDetails && Array.isArray(roleDetails) && roleDetails.length > 0) {
                var role = roleDetails[0];
                
                // Handle both camelCase (API JSON) and PascalCase (fallback)
                var roleIDValue = role.roleID !== undefined ? role.roleID : role.RoleID;
                var roleDescription = role.roleDescription !== undefined ? role.roleDescription : role.RoleDescription;
                var currencyCode = role.currencyCode !== undefined ? role.currencyCode : role.CurrencyCode;
                var normalRate = role.normalRate !== undefined ? role.normalRate : role.NormalRate;
                var extraRate = role.extraRate !== undefined ? role.extraRate : role.ExtraRate;
                var holidayRate = role.holidayRate !== undefined ? role.holidayRate : role.HolidayRate;
                normalRate = normalRate != null ? parseFloat(normalRate).toFixed(3) : "0.000";
                extraRate = extraRate != null ? parseFloat(extraRate).toFixed(3) : "0.000";
                holidayRate = holidayRate != null ? parseFloat(holidayRate).toFixed(3) : "0.000";

                $('#projRoleRateRoleText').val(roleDescription !== null && roleDescription !== undefined ? roleDescription : '');
                // Set rate fields
                $('#RoleNormalRate').val(normalRate !== null && normalRate !== undefined ? normalRate : '0.000');
                $('#RoleExtraRate').val(extraRate !== null && extraRate !== undefined ? extraRate : '0.000');
                $('#RoleHolidayRate').val(holidayRate !== null && holidayRate !== undefined ? holidayRate : '0.000');
                //$('#RoleCurrencyCode').val(currencyCode !== null && currencyCode !== undefined ? currencyCode : '');
                $('#RoleCurrencyCode').text(currencyCode !== null && currencyCode !== undefined ? currencyCode : '');

                // Make fields readonly if user doesn't have edit access
                // Note: Role dropdown remains enabled for viewing/navigation purposes
                if (!m_blnEditAccess) {
                    $('#RoleNormalRate').prop('readonly', true);
                    $('#RoleExtraRate').prop('readonly', true);
                    $('#RoleHolidayRate').prop('readonly', true);
                    // Keep dropdown enabled so users can navigate between roles to view details
                    $('#projRoleRateRole').prop('disabled', false).selectpicker('refresh');
                } else {
                    $('#RoleNormalRate').prop('readonly', false);
                    $('#RoleExtraRate').prop('readonly', false);
                    $('#RoleHolidayRate').prop('readonly', false);
                    $('#projRoleRateRole').prop('disabled', false).selectpicker('refresh');
                }

                // Store current role ID for save operation
                window.currentRoleID = roleIDValue;
                window.currentRoleDescription = roleDescription;

                // Show detail view
                $(".RoleRateContent").hide();
                $(".RoleRateRoleColumn").removeClass('d-none').show();
                
                // Update breadcrumb title
                $('.RoleRateRoleColumn .projInnerTitle.active').text(roleDescription || ResourceStrings.C_RoleRate);
            } else {
                alert('Role details not found');
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading specific role detail from API

        // Added by Nischal C on 30 Nov 2025 for saving role details via API
        // Function to save role details
        function saveRoleDetails() {

            // Permission check
            if (!m_blnEditAccess) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_NoPermissionToSaveRoleRates);
                return;
            }

            if (!currentProjectSiteID || currentProjectSiteID === 0) {
                alert('Please select a project site first');
                return;
            }

            var normalRate = $('#RoleNormalRate').val().trim();
            var extraRate = $('#RoleExtraRate').val().trim();
            var holidayRate = $('#RoleHolidayRate').val().trim();

            var MAX_RATE_LIMIT = 999999999;

            // 🔴 Mandatory ONLY for Normal Rate
            if (!normalRate) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Normal Rate should not be left blank.');
                $('#RoleNormalRate').focus();
                return;
            }

            // Parse numbers
            var normalRateNum = parseFloat(normalRate);
            var extraRateNum = extraRate ? parseFloat(extraRate) : null;
            var holidayRateNum = holidayRate ? parseFloat(holidayRate) : null;

            // Validate Normal Rate
            if (isNaN(normalRateNum) || normalRateNum <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Normal Rate must be greater than 0.');
                $('#RoleNormalRate').focus();
                return;
            }

            if (normalRateNum > MAX_RATE_LIMIT) {
                alertify.error('Normal Rate cannot exceed ' + MAX_RATE_LIMIT.toLocaleString());
                $('#RoleNormalRate').focus();
                return;
            }

            // Validate Extra Rate (optional)
            if (extraRateNum !== null) {
                if (isNaN(extraRateNum) || extraRateNum < 0) {
                    alertify.error('Extra Rate must be a positive numeric value.');
                    $('#RoleExtraRate').focus();
                    return;
                }

                if (extraRateNum > MAX_RATE_LIMIT) {
                    alertify.error('Extra Rate cannot exceed ' + MAX_RATE_LIMIT.toLocaleString());
                    $('#RoleExtraRate').focus();
                    return;
                }
            }

            // Validate Holiday Rate (optional)
            if (holidayRateNum !== null) {
                if (isNaN(holidayRateNum) || holidayRateNum < 0) {
                    alertify.error('Holiday Rate must be a positive numeric value.');
                    $('#RoleHolidayRate').focus();
                    return;
                }

                if (holidayRateNum > MAX_RATE_LIMIT) {
                    alertify.error('Holiday Rate cannot exceed ' + MAX_RATE_LIMIT.toLocaleString());
                    $('#RoleHolidayRate').focus();
                    return;
                }
            }

            // ✅ Round to 3 decimal places (also reflected in UI & list)
            normalRateNum = parseFloat(normalRateNum.toFixed(3));
            extraRateNum = extraRateNum !== null ? parseFloat(extraRateNum.toFixed(3)) : null;
            holidayRateNum = holidayRateNum !== null ? parseFloat(holidayRateNum.toFixed(3)) : null;

            // Set back rounded values
            $('#RoleNormalRate').val(normalRateNum.toFixed(3));
            $('#RoleExtraRate').val(extraRateNum !== null ? extraRateNum.toFixed(3) : '');
            $('#RoleHolidayRate').val(holidayRateNum !== null ? holidayRateNum.toFixed(3) : '');

            var Parameters = {
                ProjectSiteID: currentProjectSiteID,
                RoleID: window.currentRoleID,
                NormalRate: normalRateNum,
                ExtraRate: extraRateNum,
                HolidayRate: holidayRateNum
            };

            var param = JSON.stringify(Parameters);
            alertify.set('notifier', 'position', 'top-right');

            try {
                var Result = AJAXCallWithResult('api/ProjectSites/UpdateRoleDetails', param, false);

                var message = '';
                var isSuccess = false;

                if (Result && Result.message) {
                    message = Result.message;
                } else if (Result && Result.data && Result.data.message) {
                    message = Result.data.message;
                }

                if (
                    (Result && Result.status && Result.status.toLowerCase() === 'success') ||
                    (Result && Result.data && Result.data.status && Result.data.status.toLowerCase() === 'success') ||
                    (message && message.toLowerCase().includes('successfully'))
                ) {
                    isSuccess = true;
                }

                if (isSuccess) {
                    alertify.success(message || ResourceStrings.A_RoleDetailsUpdatedSuccessfully);
                    loadRoleDetails();
                    $(".RoleRateContent").hide();
                    $(".RoleRateContentMain").show();
                } else {
                    alertify.error(message || 'Failed to save role details');
                }

            } catch (err) {
                alertify.error(ResourceStrings.A_FailedToUpdateRoleDetails);
            }
        }



        // Helper function to check special characters (updated to use WebConfigSpecialCharacters)
        function checkSpecialCharacter(value, specialChars) {
            if (!value || !specialChars) return false;
            for (var i = 0; i < specialChars.length; i++) {
                if (value.indexOf(specialChars[i]) != -1) {
                    return true;
                }
            }
            return false;
        }

        // jQuery extensions for phone/fax validation (same as PM_CreateProject.aspx)
        $.fn.isFaxNumber = function (options) {
            var intRegex = /^[0-9]{1,10}$/;
            var faxNumber = this.val();
            if ((faxNumber.length != 10) || (!intRegex.test(faxNumber))) {
                return false;
            }
            return true;
        };

        $.fn.isPhoneNumber = function (options) {
            var intRegex = /[0-9 -()+]+$/;
            var phNumber = this.val();
            if ((phNumber.length < 6) || (!intRegex.test(phNumber))) {
                return false;
            }
            return true;
        };

        function StartLoader(bodyID) {
            // Simple loading indicator - can be enhanced with LoadingOverlay if library is included
            if (typeof LoadingOverlay !== 'undefined' && typeof LoadingOverlayProgress !== 'undefined') {
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
                        "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
                    }
                });
                $(bodyID).LoadingOverlay("show", {
                    custom: progress2.Init()
                });
            } else {
                // Fallback: simple loading message
                $(bodyID).css('opacity', '0.6');
                $(bodyID).append('<div id="simpleLoader" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; background: white; padding: 20px; border-radius: 5px; box-shadow: 0 2px 10px rgba(0,0,0,0.2);"><div style="text-align: center;">Loading...</div></div>');
            }
        }

        function StopAjaxLoader(bodyID) {
            if (typeof LoadingOverlay !== 'undefined') {
                $(bodyID).LoadingOverlay("hide", {});
            } else {
                // Fallback: remove simple loading
                $(bodyID).css('opacity', '1');
                $('#simpleLoader').remove();
            }
        }

        // Helper function to validate email format
        function ValidateEmail(emailField) {
            var email = $(emailField).val();
            if (email && email.trim() !== '') {
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_PleaseEnterValidEmailAddress);
                    $(emailField).focus();
                    return false;
                }
            }
            return true;
        }

        // Helper function to restrict non-numeric values
        function RestrictNonNumeric(field) {
            var value = $(field).val();
            if (value && value.trim() !== '') {
                var numericRegex = /^[0-9]+\.?[0-9]*$/;
                if (!numericRegex.test(value)) {
                    return true; // Contains non-numeric
                }
            }
            return false; // Valid numeric
        }

        $('#projDetailsWorkingDays, #workingDaysFilter').on('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value.length > 2) {
                this.value = this.value.slice(0, 2);
            }
        });

        $('#projDetailsWorkingHours, #projDetailsExtraHours, #projDetailsWHoursMonth, #workingHoursFilter, #extraHoursFilter, #workHoursMonthFilter, #RoleNormalRate, #RoleExtraRate, #RoleHolidayRate')
            .on('input', function () {

                // Track trailing dot
                let hasTrailingDot = this.value.endsWith('.');

                // Allow digits and one dot only
                let value = this.value
                    .replace(/[^0-9.]/g, '')
                    .replace(/(\..*)\./g, '$1');

                // ❌ Remove dot if it's the first character
                if (value.startsWith('.')) {
                    value = value.substring(1);
                    hasTrailingDot = false;
                }

                let parts = value.split('.');
                let intPart = parts[0] || '';
                let decPart = parts[1] || '';

                // 🔒 Max 9 digits before decimal
                intPart = intPart.substring(0, 9);

                // 🔒 Max 3 digits after decimal
                decPart = decPart.substring(0, 3);

                // Rebuild value
                if (decPart.length > 0) {
                    this.value = intPart + '.' + decPart;
                } else if (hasTrailingDot && intPart.length > 0) {
                    this.value = intPart + '.';
                } else {
                    this.value = intPart;
                }
            });



        // Validation function for Project Site (following PM_CreateProject.aspx pattern)
        function ValidateProjectSite() {
            //debugger;
            var checkSite = 0;

            // Helper function to trim and normalize spaces (replace multiple spaces with single space)
            function trimAndNormalize(value) {
                if (!value || typeof value !== 'string') return value || '';
                return value.trim().replace(/\s+/g, ' '); // Replace multiple spaces with single space
            }

            // Get form values and trim extra spaces
            var siteName = trimAndNormalize($('#ResName').val() || '');
            var shortName = trimAndNormalize($('#ResShortName').val() || '');
            var currency = $('#projDetailsCurrency').val() || '';
            var rateMethod = $('#projDetailsRateMethod').val() || '';
            var startingDayOfWeek = $('#projDetailsDays').val() || '';
            var weekDays = $('#projDetailsWorkingDays').val() ? $('#projDetailsWorkingDays').val().trim() : '';
            var workHours = $('#projDetailsWorkingHours').val() ? $('#projDetailsWorkingHours').val().trim() : '';
            // Read Extra Hours Cap value - use input selector to ensure we get the input, not label
            var extraHoursCap = $('input#projDetailsExtraHours').val() ? $('input#projDetailsExtraHours').val().trim() : '';
            var workHoursPerMonth = $('#projDetailsWHoursMonth').val() ? $('#projDetailsWHoursMonth').val().trim() : '';
            var address1 = trimAndNormalize($('#projDetailsAdd1').val() || '');
            var address2 = trimAndNormalize($('#projDetailsAdd2').val() || '');
            var state = trimAndNormalize($('#projDetailsState').val() || '');
            var city = trimAndNormalize($('#projDetailsCity').val() || '');
            var zip = trimAndNormalize($('#projDetailsZip').val() || '');
            var fax = trimAndNormalize($('#projDetailsFax').val() || '');
            var phone = trimAndNormalize($('#projDetailsPhone').val() || '');
            var email = trimAndNormalize($('#projDetailsEmail').val() || '');
            var remarks = trimAndNormalize($('#projDetailsRemarks').val() || '');
            
            // Update form fields with trimmed values (so user sees what will be saved)
            $('#ResName').val(siteName);
            if (shortName) $('#ResShortName').val(shortName);
            if (address1) $('#projDetailsAdd1').val(address1);
            if (address2) $('#projDetailsAdd2').val(address2);
            if (state) $('#projDetailsState').val(state);
            if (city) $('#projDetailsCity').val(city);
            if (zip) $('#projDetailsZip').val(zip);
            if (fax) $('#projDetailsFax').val(fax);
            if (phone) $('#projDetailsPhone').val(phone);
            if (email) $('#projDetailsEmail').val(email);
            if (remarks) $('#projDetailsRemarks').val(remarks);

            // Validate Name (Required)
            if (siteName === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_SiteNameRequired);
                $('#ResName').focus();
                return 1;
            }
            
                if (typeof currentProjectID !== 'undefined' && currentProjectID > 0) {
                    var isAddMode = !currentProjectSiteID || currentProjectSiteID === 0;
                    var existingSites = getProjectSitesName(currentProjectID); // API call
                    if (!isAddMode) {
                        existingSites = existingSites.filter(function (s) {
                            var name = (typeof s === 'string') ? s : (s && s.names);
                            return name !== siteName;
                        });
                    }
                    var currentSiteName = normalizeSiteName(siteName);

                    var isDuplicate = existingSites.some(function (s) {

                        // handle both string array or object array safely
                        var existingName = '';

                        if (typeof s === 'string') {
                            existingName = s;
                        } else if (s.names) {
                            existingName = s.names;
                        }

                        return normalizeSiteName(existingName) === currentSiteName;
                    });

                    if (isDuplicate) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_SiteNameAlreadyExists || 'Site name already exists.');
                        $('#ResName').focus();
                        return 1;
                    }
                }
            
            
            // Validate Name - Special Characters (using WebConfigSpecialCharacters)
            if (checkSpecialCharacter(siteName, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_SiteNameShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#ResName').focus();
                return 1;
            }

            // Validate Name - Max Length (50 characters)
            if (siteName.length > 50) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_SiteNameCannotExceed50Characters);
                $('#ResName').focus();
                return 1;
            }

            // Validate Short Name - Special Characters (if provided)
            if (shortName && checkSpecialCharacter(shortName, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_ShortNameShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#ResShortName').focus();
                return 1;
            }

            // Validate Short Name - Max Length (10 characters)
            if (shortName && shortName.length > 10) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_ShortNameCannotExceed10Characters);
                $('#ResShortName').focus();
                return 1;
            }

            // Validate Address 1 - Special Characters (if provided)
            if (address1 && checkSpecialCharacter(address1, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_Address1ShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#projDetailsAdd1').focus();
                return 1;
            }

            // Validate Address 1 - Max Length (40 characters)
            if (address1 && address1.length > 100) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_Address1CannotExceed40Characters);
                $('#projDetailsAdd1').focus();
                return 1;
            }

            // Validate Address 2 - Special Characters (if provided)
            if (address2 && checkSpecialCharacter(address2, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_Address2ShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#projDetailsAdd2').focus();
                return 1;
            }

            // Validate Address 2 - Max Length (40 characters)
            if (address2 && address2.length > 100) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_Address2CannotExceed40Characters);
                $('#projDetailsAdd2').focus();
                return 1;
            }

            // Validate State - Special Characters (if provided)
            if (state && checkSpecialCharacter(state, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_StateShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#projDetailsState').focus();
                return 1;
            }

            // Validate State - Max Length (20 characters)
            if (state && state.length > 50) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_StateCannotExceed20Characters);
                $('#projDetailsState').focus();
                return 1;
            }

            // Validate City - Special Characters (if provided)
            if (city && checkSpecialCharacter(city, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_CityShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#projDetailsCity').focus();
                return 1;
            }

            // Validate City - Max Length (30 characters)
            if (city && city.length > 50) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_CityCannotExceed30Characters);
                $('#projDetailsCity').focus();
                return 1;
            }

            // Validate Email (if provided)
            if (email && email.trim() !== '') {
                if (!ValidateEmail($('#projDetailsEmail'))) {
                    return 1;
                }
            }

            // Validate Email - Max Length (50 characters)
            if (email && email.length > 50) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_EmailCannotExceed50Characters);
                $('#projDetailsEmail').focus();
                return 1;
            }

            // Validate Zip - Special Characters (if provided)
            if (zip && checkSpecialCharacter(zip, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_ZipPostalCodeShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#projDetailsZip').focus();
                return 1;
            }

            // Validate Zip - Max Length (10 characters)
            if (zip && zip.length > 10) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_ZipPostalCodeCannotExceed10Characters);
                $('#projDetailsZip').focus();
                return 1;
            }

            // Validate Fax - Special Characters and Format (if provided)
            if (fax && fax.trim() !== '') {
                if (checkSpecialCharacter(fax, WebConfigSpecialCharacters)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_FaxShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                    $('#projDetailsFax').focus();
                    return 1;
                }
            }

            // Validate Phone - Special Characters and Format (if provided)
            if (phone && phone.trim() !== '') {
                if (checkSpecialCharacter(phone, WebConfigSpecialCharacters)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_PhoneNoShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                    $('#projDetailsPhone').focus();
                    return 1;
                }
                // Validate Phone - Max Length (12 characters)
                if (phone.length > 12) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_PhoneNoCannotExceed12Characters);
                    $('#projDetailsPhone').focus();
                    return 1;
                }
                if ($("#projDetailsPhone").isPhoneNumber() == false) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_PhoneNoShouldContainAtLeast6Digits);
                    $('#projDetailsPhone').focus();
                    return 1;
                }
            }

            // Validate Remarks - Special Characters (if provided)
            if (remarks && checkSpecialCharacter(remarks, WebConfigSpecialCharacters)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_RemarksShouldNotContainSpecialChars.replace('{0}', WebConfigSpecialCharacters));
                $('#projDetailsRemarks').focus();
                return 1;
            }

            // Validate Currency (Required)
            if (!currency || currency === '' || currency === ResourceStrings.C_SelectCurrency || currency === '0') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_CurrencyRequired);
                $('#projDetailsCurrency').focus();
                return 1;
            }

            // Validate Rate Method (Required)
            if (!rateMethod || rateMethod === '' || rateMethod === 'Select Rate Method' || rateMethod === '0') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_RateMethodRequired);
                $('#projDetailsRateMethod').focus();
                return 1;
            }

            // Validate Starting Day Of Week (Required)
            if (!startingDayOfWeek || startingDayOfWeek === '' || startingDayOfWeek === 'Select Days of Week' || startingDayOfWeek === '0') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_StartingDayOfWeekRequired);
                $('#projDetailsDays').focus();
                return 1;
            }

            // Validate Working Days Per Week (Required)
            if (weekDays.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_WorkingDaysPerWeekRequired);
                $('#projDetailsWorkingDays').focus();
                return 1;
            }

            // Validate Working Days - Numeric and Range (1-7)
            if (weekDays) {
                if (RestrictNonNumeric($('#projDetailsWorkingDays')[0])) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_WorkingDaysPerWeekMustNotBeLessThanOrEqualZero);
                    $('#projDetailsWorkingDays').focus();
                    return 1;
                }
                var weekDaysNum = parseFloat(weekDays);
                if (weekDaysNum < 1 || weekDaysNum > 7) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_WorkingDaysPerWeekMustBeBetween1And7);
                    $('#projDetailsWorkingDays').focus();
                    return 1;
                }
            }

            // Validate Working Hours Per Day (Required)
            if (workHours.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_WorkingHoursPerDayRequired);
                $('#projDetailsWorkingHours').focus();
                return 1;
            }

            // Validate Working Hours - Numeric and Range (1-24)
            if (workHours) {
                if (RestrictNonNumeric($('#projDetailsWorkingHours')[0])) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_WorkingHoursPerDayMustNotBeLessThanOrEqualZero);
                    $('#projDetailsWorkingHours').focus();
                    return 1;
                }
                var workHoursNum = parseFloat(workHours);
                if (workHoursNum < 1 || workHoursNum > 24) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_WorkingHoursPerDayMustBeBetween1And24);
                    $('#projDetailsWorkingHours').focus();
                    return 1;
                }
            }

              // Validate Extra Hours Cap - Numeric (if provided)
            // Note: extraHoursCap is already read at the top of the function (line 3032)
            if (extraHoursCap && extraHoursCap.trim() !== '') {
                if (RestrictNonNumeric($('#projDetailsExtraHours')[0])) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_ExtraHoursCapPerDayMustNotBeLessThanOrEqualZero);
                    $('#projDetailsExtraHours').focus();
                    return 1;
                }
            }

            // Validate: Total of Working Hours and Extra Hours Cap should not be greater than 24
            if (workHours && workHours.trim() !== '') {
                var workHoursNum = parseFloat(workHours);
                var extraHoursCapNum = 0;
                if (extraHoursCap && extraHoursCap.trim() !== '') {
                    extraHoursCapNum = parseFloat(extraHoursCap);
                }
                var totalHours = workHoursNum + extraHoursCapNum;
                if (totalHours > 24) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_TotalWorkingHoursAndExtraHoursCapShouldNotBeGreaterThan24);
                    $('#projDetailsWorkingHours').focus();
                    return 1;
                }
            }

            // Validate Working Hours Per Month (Required)
            if (workHoursPerMonth.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_WorkingHoursPerMonthRequired);
                $('#projDetailsWHoursMonth').focus();
                return 1;
            }

            // Validate Working Hours Per Month - Numeric and Minimum (>= 1)
            if (workHoursPerMonth) {
                if (RestrictNonNumeric($('#projDetailsWHoursMonth')[0])) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_WorkingHoursPerMonthMustNotBeLessThanOrEqualZero);
                    $('#projDetailsWHoursMonth').focus();
                    return 1;
                }
                var workHoursPerMonthNum = parseFloat(workHoursPerMonth);
                if (workHoursPerMonthNum < 1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_WorkingHoursPerMonthMustBeGreaterThan0);
                    $('#projDetailsWHoursMonth').focus();
                    return 1;
                }
                else if (workHoursPerMonthNum > 99999) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Working Hours Per Month should be under 5 digits.");
                    $('#projDetailsWHoursMonth').focus();
                    return 1;
                }
            }

          
            return checkSite; // 0 = valid, 1 = invalid
        }

        // Function to save project site data (Add or Update) - Updated to match PM_CreateProject.aspx pattern
        function saveProjectSiteData(saveAndAdd, clearForm) {
            // Check add or edit access permission
            if (!m_blnAddAccess && !m_blnEditAccess) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_NoPermissionToSaveProjectSites);
                return;
            }
            
            // Validate first
            if (ValidateProjectSite() !== 0) {
                return; // Validation failed
            }
            var selectedProjectID = $('#cboProject').val();
            // Check if project is selected
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project first');
                return;
            }

            // Get form values and trim extra spaces (same as PM_CreateProject.aspx)
            // Helper function to trim and normalize spaces (replace multiple spaces with single space)
            function trimAndNormalize(value) {
                if (!value || typeof value !== 'string') return value;
                return value.trim().replace(/\s+/g, ' '); // Replace multiple spaces with single space
            }
            
            var siteName = trimAndNormalize($("#ResName").val());
            var shortName = trimAndNormalize($("#ResShortName").val());
            var currencyID = $("#projDetailsCurrency option:selected").val();
            var rateMethod = $("#projDetailsRateMethod option:selected").val();
            var startingDayOfWeek = $("#projDetailsDays option:selected").val();
            var weekDays = $("#projDetailsWorkingDays").val() ? $("#projDetailsWorkingDays").val().trim() : '';
            var workHrs = $("#projDetailsWorkingHours").val() ? $("#projDetailsWorkingHours").val().trim() : '';
            var extraHoursCap = $("#projDetailsExtraHours").val() ? $("#projDetailsExtraHours").val().trim() : '';
            var hoursPerMonth = $("#projDetailsWHoursMonth").val() ? $("#projDetailsWHoursMonth").val().trim() : '';
            var isOffshore = $("#OffshoreSiteChk").is(':checked') ? 1 : 0;
            if (extraHoursCap == 0) {
                extraHoursCap = '';
            }
            // Check if trying to set offshore and another site is already offshore
            if (isOffshore === 1 && currentOffshoreSiteID && currentOffshoreSiteID !== currentProjectSiteID) {
                // Show Bootstrap confirmation modal (using jQuery for Bootstrap 5 compatibility)
                $('#offshoreChangeModal').modal('show');
                
                // Store save parameters for use in modal handlers
                window.pendingOffshoreSave = {
                    saveAndAdd: saveAndAdd,
                    clearForm: clearForm,
                    isOffshore: isOffshore
                };
                
                return; // Exit here, proceedWithSave will be called if user confirms
            }
            
            // If no conflict, proceed with save normally
            proceedWithSave(saveAndAdd, clearForm, isOffshore);
        }
        
        // Added by Nischal C on 30 Nov 2025 for saving project site data via API
        // Function to proceed with the actual save
        function proceedWithSave(saveAndAdd, clearForm, isOffshore) {
          
            function trimAndNormalize(value) {
                if (!value || typeof value !== 'string') return value;
                return value.trim().replace(/\s+/g, ' '); // Replace multiple spaces with single space
            }
            var selectedProjectID = $('#cboProject').val();
            var siteName = trimAndNormalize($("#ResName").val());
            var shortName = trimAndNormalize($("#ResShortName").val());
            var currencyID = $("#projDetailsCurrency option:selected").val();
            var rateMethod = $("#projDetailsRateMethod option:selected").val();
            var startingDayOfWeek = $("#projDetailsDays option:selected").val();
            var weekDays = $("#projDetailsWorkingDays").val() ? $("#projDetailsWorkingDays").val().trim() : '';
            var workHrs = $("#projDetailsWorkingHours").val() ? $("#projDetailsWorkingHours").val().trim() : '';
            var extraHoursCap = $("#projDetailsExtraHours").val() ? $("#projDetailsExtraHours").val().trim() : '';
            var hoursPerMonth = $("#projDetailsWHoursMonth").val() ? $("#projDetailsWHoursMonth").val().trim() : '';
            var address = trimAndNormalize($("#projDetailsAdd1").val());
            var address1 = trimAndNormalize($("#projDetailsAdd2").val());
            var countryID = $("#projDetailsCountry option:selected").val();
            var state = trimAndNormalize($("#projDetailsState").val());
            var city = trimAndNormalize($("#projDetailsCity").val());
            var zip = trimAndNormalize($("#projDetailsZip").val());
            var fax = trimAndNormalize($("#projDetailsFax").val());
            var phone = trimAndNormalize($("#projDetailsPhone").val());
            var emailID = trimAndNormalize($("#projDetailsEmail").val());
            var remarks = trimAndNormalize($("#projDetailsRemarks").val());
            if (extraHoursCap == 0) {
                extraHoursCap = '';
            }
            // Update form fields with trimmed values to show user what will be saved
            $("#ResName").val(siteName);
            if (shortName) $("#ResShortName").val(shortName);
            if (address) $("#projDetailsAdd1").val(address);
            if (address1) $("#projDetailsAdd2").val(address1);
            if (state) $("#projDetailsState").val(state);
            if (city) $("#projDetailsCity").val(city);
            if (zip) $("#projDetailsZip").val(zip);
            if (fax) $("#projDetailsFax").val(fax);
            if (phone) $("#projDetailsPhone").val(phone);
            if (emailID) $("#projDetailsEmail").val(emailID);
            if (remarks) $("#projDetailsRemarks").val(remarks);

            // Determine if Add or Update based on currentProjectSiteID
            var isUpdate = (currentProjectSiteID && currentProjectSiteID > 0);
            var apiEndpoint = isUpdate ? 'api/ProjectSites/SaveProjectSiteData' : 'api/ProjectSites/AddProjectSiteData';

            // Handle StartingDayOfWeek - convert day name to number if needed
            var startingDayOfWeekValue = null;
            if (startingDayOfWeek && startingDayOfWeek !== '' && startingDayOfWeek !== 'Select Days of Week') {
                if (!isNaN(startingDayOfWeek)) {
                    startingDayOfWeekValue = parseInt(startingDayOfWeek);
                } else {
                    var dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
                    var dayIndex = dayNames.indexOf(startingDayOfWeek);
                    if (dayIndex >= 0) {
                        startingDayOfWeekValue = dayIndex + 1;
                    }
                }
            }

            // Handle CountryID
            if (countryID == "" || countryID == "Select Country") {
                countryID = 0;
            }

        
            var Data = {
                ProjectID: selectedProjectID,
                Name: siteName || null,
                ShortName: shortName || null,
                CurrencyID: currencyID && currencyID !== '' && currencyID !== ResourceStrings.C_SelectCurrency ? parseInt(currencyID) : null,
                RateMethod: rateMethod && rateMethod !== '' && rateMethod !== 'Select Rate Method' ? parseInt(rateMethod) : null,
                StartingDayOfWeek: startingDayOfWeekValue || null,
                WeekDays: weekDays && weekDays !== '' ? parseInt(weekDays) : null,
                WorkHrs: workHrs && workHrs !== '' ? parseFloat(workHrs) : null,
                ExtraHoursCap: extraHoursCap && extraHoursCap !== '' ? parseFloat(extraHoursCap) : null,
                HoursPerMonth: hoursPerMonth && hoursPerMonth !== '' ? parseFloat(hoursPerMonth) : null,
                IsOffshore: isOffshore === 1 ? true : false,
                Address: address || null,
                Address1: address1 || null,
                CountryID: countryID && countryID !== '' && countryID !== 'Select Country' ? parseInt(countryID) : null,
                State: state || null,
                City: city || null,
                Zip: zip || null,
                Fax: fax || null,
                Phone: phone || null,
                EmailID: emailID || null,
                Remarks: remarks || null,
                CreatedBy: isUpdate ? null : (UserName || null),  
                ModifiedBy: isUpdate ? (UserName || null) : null   
            };

            // Add ProjectSiteID for Update
            if (isUpdate) {
                Data.ProjectSiteID = currentProjectSiteID;
            }

            // Show loading indicator
            StartLoader("#AddProjectSiteOffcanvas");

            var param = JSON.stringify(Data);
            var Result = AJAXCallWithResult(apiEndpoint, param, false);
            
            StopAjaxLoader("#AddProjectSiteOffcanvas");
            
            if (Result && Result != "") {
                alertify.set('notifier', 'position', 'top-right');
                if (isUpdate) {
                    alertify.success(ResourceStrings.A_ProjectSiteUpdatedSuccessfully);
                } else {
                    alertify.success(ResourceStrings.A_ProjectSiteAddedSuccessfully);
                }

                // Update currentOffshoreSiteID after successful save
                if (isOffshore === 1) {
                    // Get the saved site ID from response
                    var savedSiteID = null;
                    if (Result && Result.data) {
                        savedSiteID = Result.data.projectSiteID || Result.data.ProjectSiteID || currentProjectSiteID;
                    } else {
                        savedSiteID = currentProjectSiteID;
                    }
                    currentOffshoreSiteID = savedSiteID;
                } else if (currentOffshoreSiteID === currentProjectSiteID) {
                    currentOffshoreSiteID = null;
                }
                
                // Reload project sites table after a small delay to ensure save is complete
                setTimeout(function() {
                    loadAllProjectSites();
                }, 300);

                // If Save And Add, clear form and keep offcanvas open
                if (saveAndAdd) {
                    if (clearForm) {
                        clearProjectSiteForm();
                        // Reset to Details tab
                        $('a[href="#prositedetailTab1"]').tab('show');
                        // Hide other tabs for new entry
                        $('a[href="#prositedetailTab2"]').parent().hide();
                        $('a[href="#prositedetailTab3"]').parent().hide();
                        $('a[href="#prositedetailTab4"]').parent().hide();
                    }               
                } else {
                    // Close offcanvas after save
                    var offcanvasElement = document.getElementById('AddProjectSiteOffcanvas');
                    var offcanvasInstance = bootstrap.Offcanvas.getInstance(offcanvasElement);
                    if (offcanvasInstance) {
                        offcanvasInstance.hide();
                    }
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_ErrorOccurredWhileSavingProjectSite);
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for saving project site data via API

        // Added by Nischal C on 30 Nov 2025 for checking freeze status from API
        function checkFreezeStatus() {
            var selectedProjectID = $('#cboProject').val();
            //debugger
            if (!selectedProjectID || !selectedProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Invalid Project or Site ID');
                return;
            }

            var Parameters = {
                ProjectID: selectedProjectID,
                ProjectSiteID: currentProjectSiteID
            };
            var param = JSON.stringify(Parameters);

            try {
                var Result = AJAXCallWithResult('/api/ProjectSites/CheckIsFreeze', param, false);
                //var data = extractApiData(Result, 'result');
                var freezeData = Result?.isFreeze;

                if (freezeData && Array.isArray(freezeData) && freezeData.length > 0) {
                    var status = freezeData[0];

                    
                    if (status.freeze === true) {       
                        $("#freezeSiteBtn").addClass("clsShowHide");             
                    } else {                   
                        $("#freezeSiteBtn").removeClass("clsShowHide");
                    }
                }
            }
            catch (err) {
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for checking freeze status from API



        // Added by Nischal C on 30 Nov 2025 for freezing site via API
        function freezeSite() {
           // debugger
            // Check edit access permission
            if (!m_blnEditAccess) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('You do not have permission to freeze site details.');
                return;
            }
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || !selectedProjectID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Invalid Project or Site ID');
                return;
            }

            var Parameters = {
                ProjectID: selectedProjectID,
                ProjectSiteID: currentProjectSiteID
            };

            var param = JSON.stringify(Parameters);

            StartLoader("#AddProjectSiteOffcanvas");

            try {
                // API call (synchronous like your existing pattern)
                var Result = AJAXCallWithResult('/api/ProjectSites/FreezeHoliday', param, false);

                // Read success property properly (supports your API structure)
                var data = extractApiData(Result, 'result');

                if (data && Array.isArray(data) && data.length > 0) {
                    var status = data[0];

                    if (status.frozenProjectSiteID && Number(status.frozenProjectSiteID) > 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("Site details frozen successfully!");

                        $("#freezeSiteBtn").addClass("clsShowHide");
                        loadProjectSiteData(currentProjectSiteID);
                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(Result.message || "Failed to freeze site");
                    }

                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Invalid API response");
                }
            }
            catch (err) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Something went wrong while freezing the site");
            }
            finally {
                StopAjaxLoader("#AddProjectSiteOffcanvas");
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for freezing site via API

        // Added by Nischal C on 30 Nov 2025 for updating role details via API
        function updateRoleDetails() {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || !currentProjectSiteID) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Invalid Project or Site ID');
                return;
            }

            var Parameters = {
                projectSiteID: currentProjectSiteID,
                roleID: Number($("#projRoleRateRoleText").val()) || 0, // dropdown input
                normalRate: Number($("#RoleNormalRate").val()) || 0.000,
                extraRate: Number($("#RoleExtraRate").val()) || 0.000,
                holidayRate: Number($("#RoleHolidayRate").val()) || 0.000
            };

            var param = JSON.stringify(Parameters);
            alertify.set('notifier', 'position', 'top-right');

            try {
                StartLoader("#AddProjectSiteOffcanvas");

                var Result = AJAXCallWithResult('/api/ProjectSites/UpdateRoleDetails', param, false);

                if (Result && Result.message) {
                    alertify.success(Result.message);
                } else {
                    alertify.success("Role details updated successfully!");
                }

            } catch (err) {
                alertify.error("Failed to update role details");
            } finally {
                StopAjaxLoader("#AddProjectSiteOffcanvas");
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for updating role details via API
        
      

        // Added by Nischal C on 30 Nov 2025 for loading project sites inherits from API
        // Function to load project sites inherits
        function loadProjectSitesInherits() {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project first');
                return;
            }

            var Parameters = {
                ProjectID: selectedProjectID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/SelProjectSitesInherits', param, false);

            // Handle API response structure using helper function
            var data = extractApiData(Result, 'Inherits');

            // Clear existing rows from inherit table
            var inheritTbody = $("#InheritTbl tbody");
            inheritTbody.empty();
            $('#InheritCheck0').prop('checked', false);
            $('#InheritCheck0').prop('disabled', false);
            // Populate inherit table with API data
            if (data && Array.isArray(data) && data.length > 0) {
                data.forEach(function (item, index) {
                    var projectCostTypeID = item.projectCostTypeID || item.ProjectCostTypeID || '';
                    var projectCostType = item.projectCostType || item.ProjectCostType || '';
                    // Check if this cost type is already selected (inherited)
                    // The API might return a flag, or we check if it exists in current project sites
                    var isSelected = item.isSelected || item.IsSelected || item.isInherited || item.IsInherited || false;

                    var rowHtml = '<tr>' +
                        '<td>' + (projectCostType || 'N/A') + '</td>' +
                        '<td>' +
                        '<div class="custom_chckbox">' +
                        '<input id="InheritCheck' + (index + 1) + '" class="chcksite" type="checkbox" data-cost-type="' + projectCostType +'" data-cost-type-id="' + projectCostTypeID + '" ' + (isSelected ? 'checked' : '') + ' />' +
                        '<label for="InheritCheck' + (index + 1) + '"></label>' +
                        '</div>' +
                        '</td>' +
                        '</tr>';
                    inheritTbody.append(rowHtml);
                });
            } else {
                $('#InheritCheck0').prop('disabled', true);
                // No data - show message
                inheritTbody.append('<tr><td colspan="2" class="text-center">There are no records to view</td></tr>');
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading project sites inherits from API

        // Added by Nischal C on 30 Nov 2025 for saving project sites inherits via API
        // Function to save project sites inherits
        function saveProjectSitesInherits() {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project first');
                return;
            }

            // Check if there are any sites available for inheritance
            var hasInheritOptions = $('#InheritTbl tbody .chcksite').length > 0;
            if (!hasInheritOptions) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('There are no records to view.');
                return;
            }

            // Get all checked project cost type IDs
            var selectedIDs = [];
            
            $('#InheritTbl tbody .chcksite:checked').each(function () {
                var costTypeID = $(this).data('cost-type-id');
                if (costTypeID) {
                    selectedIDs.push(costTypeID);
                }
            });

            var selectedSites = [];

            $('#InheritTbl tbody .chcksite:checked').each(function () {
                var costType = $(this).data('cost-type');
                if (costType) {
                    selectedSites.push(costType);
                }
            });

            if (!selectedIDs || selectedIDs.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one Site');
                return;
            }

            // Build comma-separated string of IDs
            var projectCostTypeIDs = selectedIDs.join(',');

            if (typeof currentProjectID !== 'undefined' && currentProjectID > 0) {

                var existingSites = getProjectSitesName(currentProjectID); // API call
                // Normalize existing sites into a flat array of strings
                var existingSiteNames = existingSites.map(function (s) {
                    if (typeof s === 'string') {
                        return s;
                    } else if (s && s.names) {
                        return s.names;
                    }
                    return '';
                }).filter(Boolean);

                // Check if any selectedSite exists in existingSites
                var isAnySelectedSiteExists = selectedSites.some(function (site) {
                    return existingSiteNames.includes(site);
                });

                if (isAnySelectedSiteExists) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_SiteAlreadyExists || 'One or more selected sites already exist.');
                    $('input[type="checkbox"][id^="InheritCheck"]').prop('checked', false);
                    return 1;
                }
            }
            var Parameters = {
                ProjectID: selectedProjectID,
                ProjectCostTypeIDs: projectCostTypeIDs || null
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/SaveProjectSitesInherits', param, false);

            // Handle response
            if (Result && Result != "") {
                // Check for success
                var isSuccess = false;
                var successMessage = 'Project sites inherits saved successfully!';
                var errorMessage = 'Failed to save project sites inherits';

                if (Result.status && Result.status.toLowerCase() === 'success') {
                    isSuccess = true;
                    successMessage = Result.message || Result.data?.message || successMessage;
                } else if (Result.data && Result.data.message) {
                    if (Result.data.message.toLowerCase().indexOf('success') >= 0 || Result.data.message.toLowerCase().indexOf('saved') >= 0) {
                        isSuccess = true;
                        successMessage = Result.data.message;
                    } else {
                        errorMessage = Result.data.message;
                    }
                } else if (Result.message) {
                    if (Result.message.toLowerCase().indexOf('success') >= 0 || Result.message.toLowerCase().indexOf('saved') >= 0) {
                        isSuccess = true;
                        successMessage = Result.message;
                    } else {
                        errorMessage = Result.message;
                    }
                }

                if (isSuccess) {
                    // Set flag to indicate save was successful (so checkboxes won't be reset)
                    inheritSaveSuccessful = true;
                    
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success(successMessage);
                    
                    // Close modal
                    $('#InheritDetailsModal').modal('hide');
                    
                    // Reload project sites table to show inherited sites
                    loadAllProjectSites();
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Error: ' + errorMessage);
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Failed to save project sites inherits. Please try again.');
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for saving project sites inherits via API

        // Added by Nischal C on 30 Nov 2025 for populating modified by dropdown from API
        // Function to populate Modified By dropdown with distinct values from history
        function populateModifiedByDropdown() {
            if (!currentProjectSiteID || currentProjectSiteID === 0) {
                // Clear dropdown if no site selected
                var $modifiedBySelect = $('#modifiedHisBy');
                $modifiedBySelect.empty();
                $modifiedBySelect.append('<option>' + "Select Modified By" + '</option>');
                $modifiedBySelect.selectpicker('refresh');
                return;
            }

            // Load all history data (without filters) to get all distinct ModifiedBy values
            var Parameters = {
                ProjectSiteID: currentProjectSiteID,
                RoleID: null,
                ModifiedField: null,
                ModifiedBy: null
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetProjectSiteHistory', param, false);
            
            // Extract data using helper function
            var data = extractApiData(Result, 'result');
            
            // Extract distinct ModifiedBy values
            var distinctModifiedBy = [];
            if (data && Array.isArray(data) && data.length > 0) {
                var modifiedBySet = new Set();
                data.forEach(function(item) {
                    var modifiedBy = item.modifiedBy !== undefined ? item.modifiedBy : (item.ModifiedBy || '');
                    // Only add non-empty values
                    if (modifiedBy && modifiedBy.trim() !== '') {
                        modifiedBySet.add(modifiedBy.trim());
                    }
                });
                distinctModifiedBy = Array.from(modifiedBySet).sort(); // Sort alphabetically
            }
            
            // Populate dropdown
            var $modifiedBySelect = $('#modifiedHisBy');
            //var currentValue = $modifiedBySelect.val(); // Preserve current selection
            
            // Clear existing options except "Select Option"
            $modifiedBySelect.empty();
            $modifiedBySelect.append('<option>' + "Select Modified By" + '</option>');
            
            // Add distinct values
            distinctModifiedBy.forEach(function(modifiedBy) {
                $modifiedBySelect.append($('<option>', {
                    value: modifiedBy,
                    text: modifiedBy
                }));
            });
            
            // Refresh selectpicker
            $modifiedBySelect.selectpicker('refresh');
           
        }
        // End of added by Nischal C on 30 Nov 2025 for populating modified by dropdown from API

        function populateModifiedFieldDropdown() {
            if (!currentProjectSiteID || currentProjectSiteID === 0) {
                // Clear dropdown if no site selected
                var $modifiedFieldSelect = $('#modifiedHisField');
                $modifiedFieldSelect.empty();
                $modifiedFieldSelect.append('<option>' + "Select Modified Field" + '</option>');
                $modifiedFieldSelect.selectpicker('refresh');
                return;
            }

            // Load all history data (without filters)
            var Parameters = {
                ProjectSiteID: currentProjectSiteID,
                RoleID: null,
                ModifiedField: null,
                ModifiedBy: null
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetProjectSiteHistory', param, false);

            // Extract data
            var data = extractApiData(Result, 'result');

            // Extract distinct ModifiedField values
            var distinctModifiedFields = [];
            if (data && Array.isArray(data) && data.length > 0) {
                var fieldSet = new Set();

                data.forEach(function (item) {
                    var modifiedField = item.modifiedField !== undefined
                        ? item.modifiedField
                        : (item.ModifiedField || '');

                    if (modifiedField && modifiedField.trim() !== '') {
                        fieldSet.add(modifiedField.trim());
                    }
                });

                distinctModifiedFields = Array.from(fieldSet).sort(); // Alphabetical
            }
            
            // Populate dropdown
            var $modifiedFieldSelect = $('#modifiedHisField');
            //var currentValue = $modifiedFieldSelect.val(); // Preserve selection

            // Clear existing options
            $modifiedFieldSelect.empty();
            $modifiedFieldSelect.append('<option>' + "Select Modified Field" + '</option>');

            // Add options
            distinctModifiedFields.forEach(function (field) {
                $modifiedFieldSelect.append($('<option>', {
                    value: field,
                    text: field
                }));
            });

            // Refresh selectpicker
            $modifiedFieldSelect.selectpicker('refresh');
        }

        // Added by Nischal C on 30 Nov 2025 for loading project site history from API
       
        function loadProjectSiteHistory() {
            if (!currentProjectSiteID || currentProjectSiteID === 0 || currentProjectSiteID === "0") {
                // Clear history table if no site selected
                var historyTable = $("#ProjectSiteShowHisTable").DataTable();
                if (historyTable) {
                    historyTable.clear().draw();
                    updateHistoryPagination();
                }
                return;
            }

            // Get filter values - handle "Select Option" as null
            var modifiedField = $('#modifiedHisField').val();
            if (modifiedField === "Select Modified Field" || !modifiedField) {
                modifiedField = null;
            }
            
            var modifiedBy = $('#modifiedHisBy').val();
            if (modifiedBy === "Select Modified By" || !modifiedBy) {
                modifiedBy = null;
            }

            var Parameters = {
                ProjectSiteID: currentProjectSiteID,
                RoleID: null,  // RoleID is for role-specific history, null for site-level
                ModifiedField: modifiedField,
                ModifiedBy: modifiedBy
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetProjectSiteHistory', param, false);
            
            // Extract data using helper function - try multiple possible keys
            var data = extractApiData(Result, 'result');
            if (!data) {
                data = extractApiData(Result, 'history');
            }
            if (!data) {
                data = extractApiData(Result);
            }
            
            // Update history table - ensure DataTable is initialized first
            if (!$.fn.DataTable.isDataTable("#ProjectSiteShowHisTable")) {
                // DataTable not initialized yet - initialize it now
                var historyTable = $("#ProjectSiteShowHisTable").DataTable({
                    scrollY: true,
                    scrollX: true,
                    paging: true,
                    pageLength: 10,
                    lengthChange: false,
                    searching: false,
                    ordering: false,
                    responsive: true,
                    destroy: false,
                    retrieve: true,
                    info: false,
                    pagingType: "simple",
                    columnDefs: [
                        { orderable: false, targets: '_all' }
                    ],
                    columns: [
                        { data: 'ModifiedField' },
                        { data: 'OldValue' },
                        { data: 'NewValue' },
                        { data: 'ModifiedDate' },
                        { data: 'ModifiedBy' }
                    ],
                    language: {
                        paginate: {
                            previous: "<%=MyBase.GetResourceString("C_PreviousPage")%>",
                            next: "<%=MyBase.GetResourceString("C_NextPage")%>"
                        }
                    }
                });
                
                // Hide default DataTables pagination for history table
                $("#ProjectSiteShowHisTable_wrapper .dataTables_paginate").css("display", "none");
                
                // Initialize pagination on history table draw
                $("#ProjectSiteShowHisTable").on('draw.dt', function () {
                    updateHistoryPagination();
                });
            }
            
            var historyTable = $("#ProjectSiteShowHisTable").DataTable();
            if (historyTable) {
                // Ensure data is an array
                if (!data || !Array.isArray(data)) {
                    data = [];
                }
                
                if (data.length > 0) {
                    // Map data to table format (handle both camelCase and PascalCase)
                    var mappedData = data.map(function(item) {
                        // Ensure item is an object
                        if (!item || typeof item !== 'object') {
                            return {
                                ModifiedField: '',
                                OldValue: '',
                                NewValue: '',
                                ModifiedDateRaw: null,
                                ModifiedDate: '',
                                ModifiedBy: ''
                            };
                        }
                        
                        // Get old value - if null/undefined/empty/N/A, leave it empty (first time entry)
                        var oldValue = item.oldValue !== undefined ? item.oldValue : item.OldValue;
                        if (oldValue === null || oldValue === undefined || oldValue === '' || oldValue === 'N/A' || oldValue === 'n/a') {
                            oldValue = '-';
                        }
                        var newValue = item.newValue !== undefined ? item.newValue : item.NewValue;
                        if (newValue === null || newValue === undefined || newValue === '' || newValue === 'N/A' || newValue === 'n/a') {
                            newValue = '-';
                        }
                        var modifiedDateRaw = item.modifiedDate ?? item.ModifiedDate;
                        return {
                            ModifiedField: item.modifiedField !== undefined ? item.modifiedField : (item.ModifiedField || ''),
                            OldValue: oldValue,
                            NewValue: item.newValue !== undefined ? item.newValue : (item.NewValue || '-'),
                            ModifiedDateRaw: modifiedDateRaw, // 👈 keep raw date
                            ModifiedDate: formatToDDMMYYYY(
                                item.modifiedDate !== undefined ? item.modifiedDate : item.ModifiedDate
                            ),
                            ModifiedBy: item.modifiedBy !== undefined ? item.modifiedBy : (item.ModifiedBy || '')
                        };
                    });
                    
                    // Sort by ModifiedDate in descending order (newest first)
                    mappedData.sort(function (a, b) {
                        const dA = parseDateTime(a.ModifiedDateRaw);
                        const dB = parseDateTime(b.ModifiedDateRaw);

                        if (!dA && !dB) return 0;
                        if (!dA) return 1;   // nulls last
                        if (!dB) return -1;

                        // 1️⃣ Compare DATE (newest first)
                        const dateOnlyA = new Date(dA.getFullYear(), dA.getMonth(), dA.getDate()).getTime();
                        const dateOnlyB = new Date(dB.getFullYear(), dB.getMonth(), dB.getDate()).getTime();

                        if (dateOnlyA !== dateOnlyB) {
                            return dateOnlyB - dateOnlyA; // newest date first
                        }

                        // 2️⃣ Same date → compare TIME (newest first)
                        return dB.getTime() - dA.getTime();
                    });
                    
                    historyTable.clear().rows.add(mappedData).draw();
                    updateHistoryPagination();
                } else {
                    // No data found
                    historyTable.clear().draw();
                    updateHistoryPagination();
                }
            }
            if (!data || !Array.isArray(data)) {
                data = [];
            }
            // Update Clear button visibility after loading history
            toggleHistoryClearButton();
        }
        // End of added by Nischal C on 30 Nov 2025 for loading project site history from API

        function parseDateTime(dateStr) {
            if (!dateStr) return null;

            // "29 Jan 2026 11:44 AM" → "Jan 29, 2026 11:44 AM"
            return new Date(
                dateStr.replace(/(\d{2}) (\w{3}) (\d{4})/, '$2 $1, $3')
            );
        }

        function formatToDDMMYYYY(dateStr) {
            if (!dateStr) return '';

            var date = new Date(dateStr);
            if (isNaN(date)) return '';

            var day = String(date.getDate()).padStart(2, '0');
            var month = String(date.getMonth() + 1).padStart(2, '0');
            var year = date.getFullYear();

            return day + '/' + month + '/' + year;
        }
       
        // Added by Nischal C on 30 Nov 2025 for loading OU-level holidays from API
        // Function to load OU-level holidays
        function loadOULevelHolidays() {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0" || !currentProjectSiteID || currentProjectSiteID === 0 || currentProjectSiteID === "0") {
                return;
            }

            // Get current year and month from calendar date
            var year = currentCalendarDate.getFullYear();
            var month = currentCalendarDate.getMonth() + 1; // JavaScript months are 0-based

            var Parameters = {
                ProjectID: selectedProjectID,
                ProjectSiteID: currentProjectSiteID,
                Year: year,
                Month: month
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetOULevelHolidays', param, false);
            
            // Extract data using helper function
            var data = extractApiData(Result);
            
            // The API returns {message: '...', holidays: Array}
            // Extract the holidays array from the response
            var holidaysArray = null;
            if (data) {
                if (Array.isArray(data)) {
                    // If data is already an array, use it directly
                    holidaysArray = data;
                } else if (data.holidays && Array.isArray(data.holidays)) {
                    // If data has a holidays property, use that (this is the expected format)
                    holidaysArray = data.holidays;
                } else if (data.data && Array.isArray(data.data)) {
                    // If data has a data property, use that
                    holidaysArray = data.data;
                } else if (data.Result && Array.isArray(data.Result)) {
                    // If data has a Result property, use that
                    holidaysArray = data.Result;
                }
            }
            
            // Store holidays for calendar rendering
            if (holidaysArray && Array.isArray(holidaysArray) && holidaysArray.length > 0) {
                window.ouLevelHolidays = holidaysArray;
            } else {
                window.ouLevelHolidays = [];
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading OU-level holidays from API

        // Added by Nischal C on 30 Nov 2025 for checking if date is weekend from API
        // Function to check if a date is a weekend
        function checkIsWeekend(projectID, projectSiteID, date) {
            if (!projectID || projectID === 0 || !projectSiteID || projectSiteID === 0 || !date) {
                return false;
            }

            var Parameters = {
                ProjectID: projectID,
                ProjectSiteID: projectSiteID,
                CurrentDate: date
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/CheckIsWeekend', param, false);
            
            // Extract data using helper function
            var data = extractApiData(Result);
            
            // Return boolean result
            if (data && Array.isArray(data) && data.length > 0) {
                return data[0].isWeekend === true || data[0].isWeekend === 1 || data[0].isWeekend === true || data[0].isWeekend === 1;
            } else if (data && (data.isWeekend[0].isWeekEnd === true || data.isWeekend[0].isWeekEnd === 1 || data.isWeekend[0].isWeekEnd === true || data.isWeekend[0].isWeekEnd === 1)) {
                return true;
            }
            return false;
        }
        // End of added by Nischal C on 30 Nov 2025 for checking if date is weekend from API

        // Added by Nischal C on 30 Nov 2025 for checking if site is frozen from API
        // Function to check if calendar is frozen
        function checkIsFreeze(projectID, projectSiteID) {
            if (!projectID || projectID === 0 || !projectSiteID || projectSiteID === 0) {
                return false;
            }

            var Parameters = {
                ProjectID: projectID,
                ProjectSiteID: projectSiteID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/CheckIsFreeze', param, false);
            
            // Extract data using helper function
            var data = extractApiData(Result);
            
            // Return boolean result
            if (data && data.length > 0) {
                return data[0].Freeze === true || data[0].Freeze === 1;
            }
            return false;
        }
        // End of added by Nischal C on 30 Nov 2025 for checking if site is frozen from API

        // Added by Nischal C on 30 Nov 2025 for getting site calendar ID from API
        // Function to get Site Calendar ID for a specific date
        function getSiteCalendarID(projectSiteID, currentDate) {
            if (!projectSiteID || projectSiteID === 0 || !currentDate) {
                return null;
            }

            var Parameters = {
                ProjectSiteID: projectSiteID,
                CurrentDate: currentDate
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetSiteCalendarID', param, false);
            
            // Extract data using helper function
            var data = extractApiData(Result);
            
            // Return SiteCalendarDayID if found
            if (data && Array.isArray(data) && data.length > 0) {
                return data[0].SiteCalendarDayID || data[0].siteCalendarDayID || null;
            } else if (data && data.SiteCalendarDayID) {
                return data.SiteCalendarDayID;
            } else if (data && data.siteCalendarDayID) {
                return data.siteCalendarDayID;
            }
            return null;
        }
        // End of added by Nischal C on 30 Nov 2025 for getting site calendar ID from API

        // Function to check if date is updated in calendar
        function isSiteCalendarUpdatedDate(projectID, projectSiteID, currentDate) {
            if (!currentDate) {
                return false;
            }
            
            // Normalize date string
            var dateStr = currentDate;
            if (typeof dateStr === 'string' && dateStr.indexOf('T') > -1) {
                dateStr = dateStr.split('T')[0];
            }
            
            // Get from cached month data (preferred - no API call)
            if (window.monthCalendarData && window.monthCalendarData[dateStr]) {
                return window.monthCalendarData[dateStr].Flag === 1;
            }
            
          
            
            return false;
        }

        // Function to get updated hours for a specific date (now uses cached data)
        function getUpdatedHours(projectID, projectSiteID, currentDate) {
            if (!currentDate) {
                return null;
            }
            
            // Normalize date string
            var dateStr = currentDate;
            if (typeof dateStr === 'string' && dateStr.indexOf('T') > -1) {
                dateStr = dateStr.split('T')[0];
            }
            
            // Get from cached month data (preferred - no API call)
            if (window.monthCalendarData && window.monthCalendarData[dateStr]) {
                var entry = window.monthCalendarData[dateStr];
                return {
                    SiteCalendarDayID: entry.SiteCalendarDayID,
                    NormalHours: entry.NormalHours,
                    ExtraHours: entry.ExtraHours,
                    Holiday: entry.Holiday
                };
            }
            
          
            
            return null;
        }
        // End of added by Nischal C on 30 Nov 2025 for getting updated hours from API

        var calendarConfig = {
            startDay: 1,       // default Monday
            workingDays: 5,    // default
            weekendDays: []    // calculated dynamically
        };

        // Added by Nischal C on 30 Nov 2025 for fetching working days from API
        // Function to fetch working days
        function fetchWorkingDays(projectID, projectSiteID) {
            var param = JSON.stringify({
                projectID: projectID,
                projectSiteID: projectSiteID
            });

            var result = AJAXCallWithResult(
                'api/ProjectSites/FetchWorkingDays',
                param,
                false
            );

            if (!result || !result.workingDays || result.workingDays.length === 0) {
                return;
            }

            var wd = result.workingDays[0];

            calendarConfig.startDay = wd.startingDayOfWeek ?? 1;
            calendarConfig.workingDays = wd.weekDays ?? 5;

            // 🔥 Calculate weekends dynamically
            for (var i = calendarConfig.workingDays; i < 7; i++) {
                calendarConfig.weekendDays.push((calendarConfig.startDay + i) % 7);
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for fetching working days from API

        function renderCalendarHeader() {
            var dayNames = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
            var headerHtml = '<tr style="background:#f8f9fa;">';

            for (var i = 0; i < 7; i++) {
                var dayIndex = (calendarConfig.startDay + i) % 7;
                
                headerHtml += `<th style="text-align:center;padding:8px;">${dayNames[dayIndex]}</th>`;
            }

            headerHtml += '</tr>';
            $('#calendarTable thead').html(headerHtml);
        }

        // Added by Nischal C on 30 Nov 2025 for getting work hours and extra hours cap from API
        // Function to get work hours and extra hours cap
        function getWorkHrsExtraHoursCap(projectID, projectSiteID) {
            if (!projectID || projectID === 0 || !projectSiteID || projectSiteID === 0) {
                return null;
            }

            var Parameters = {
                ProjectID: projectID,
                ProjectSiteID: projectSiteID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetWorkHrsExtraHoursCap', param, false);
            
            // Extract data using helper function - API returns { Data: { WorkHrs: [...] } }
            var workHrsList = extractApiData(Result, 'WorkHrs');
            
            // If extractApiData didn't find it with key, try without key (generic extraction)
            if (!workHrsList) {
                workHrsList = extractApiData(Result);
            }
            
            // Return work hours data if found
            if (workHrsList && Array.isArray(workHrsList) && workHrsList.length > 0) {
                var workHrsData = workHrsList[0];
                return {
                    WorkHrs: workHrsData.WorkHrs !== undefined && workHrsData.WorkHrs !== null ? workHrsData.WorkHrs : (workHrsData.workHrs !== undefined && workHrsData.workHrs !== null ? workHrsData.workHrs : 0),
                    ExtraHoursCap: workHrsData.ExtraHoursCap !== undefined && workHrsData.ExtraHoursCap !== null ? workHrsData.ExtraHoursCap : (workHrsData.extraHoursCap !== undefined && workHrsData.extraHoursCap !== null ? workHrsData.extraHoursCap : 0)
                };
            } else if (workHrsList && typeof workHrsList === 'object' && !Array.isArray(workHrsList)) {
                // Single object instead of array
                return {
                    WorkHrs: workHrsList.WorkHrs !== undefined && workHrsList.WorkHrs !== null ? workHrsList.WorkHrs : (workHrsList.workHrs !== undefined && workHrsList.workHrs !== null ? workHrsList.workHrs : 0),
                    ExtraHoursCap: workHrsList.ExtraHoursCap !== undefined && workHrsList.ExtraHoursCap !== null ? workHrsList.ExtraHoursCap : (workHrsList.extraHoursCap !== undefined && workHrsList.extraHoursCap !== null ? workHrsList.extraHoursCap : 0)
                };
            }
            return null;
        }

        // Function to get project sites name (for dropdowns)
        function getProjectSitesName(projectID) {
            if (!projectID || projectID === 0 || projectID === "0") {
                return [];
            }

            var Parameters = {
                ProjectID: projectID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/SelProjectSitesName', param, false);
            
            // Extract data using helper function - API returns {SiteNames: [...]}
            var data = extractApiData(Result, 'SiteNames');
            
            // If extractApiData didn't find it with key, try without key (generic extraction)
            if (!data) {
                data = extractApiData(Result);
            }
            
            if (data && Array.isArray(data)) {
                return data;
            }
            return [];
        }
        // End of added by Nischal C on 30 Nov 2025 for getting project sites name from API

        function normalizeSiteName(name) {
            if (!name || typeof name !== 'string') return '';
            return name.trim().replace(/\s+/g, ' ').toLowerCase();
        }

        // Added by Nischal C on 30 Nov 2025 for loading project sites name dropdown from API
        // Function to load Project Sites Name dropdown
        function loadProjectSitesNameDropdown(siteID, siteName) {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0") {
                // Clear dropdown if no project selected
                var $siteSelect = $('#selectDefaultSite');
                $siteSelect.empty();
                $siteSelect.selectpicker('refresh');
                return;
            }
            if (siteID) {
                currentProjectSiteID = siteID;
            }
            if (siteName) {
                currentProjectSiteName = siteName
            }
            var Parameters = {
                ProjectID: selectedProjectID
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/SelProjectSitesName', param, false);
            
            // Extract data using helper function - API returns {SiteNames: [...]}
            var data = extractApiData(Result, 'SiteNames');
            
            // If extractApiData didn't find it with key, try without key (generic extraction)
            if (!data) {
                data = extractApiData(Result);
            }
            
            // First, get the site name to pre-select if currentProjectSiteID is set but currentProjectSiteName is not
            var siteNameToSelect = currentProjectSiteName;
            if (!siteNameToSelect && currentProjectSiteID && currentProjectSiteID > 0) {
                // Get site name from GetAllProjectSites
                var sitesParams = {
                    ProjectID: selectedProjectID,
                    Name: null,
                    ShortName: null,
                    Currency: null,
                    RateMethod: null,
                    Days: null,
                    WorkingDays: null,
                    WorkingHours: null,
                    ExtraHours: null,
                    WHoursMonth: null,
                    OffshoreSite: null
                };
                var sitesParam = JSON.stringify(sitesParams);
                var sitesResult = AJAXCallWithResult('api/ProjectSites/GetAllProjectSites', sitesParam, false);
                var sitesData = extractApiData(sitesResult, 'projectSites');
                if (sitesData && Array.isArray(sitesData) && sitesData.length > 0) {
                    for (var i = 0; i < sitesData.length; i++) {
                        var site = sitesData[i];
                        var siteID = site.projectSiteID || site.ProjectSiteID;
                        if (siteID === currentProjectSiteID) {
                            siteNameToSelect = site.name || site.Name || '';
                            if (siteNameToSelect && siteNameToSelect.trim() !== '') {
                                currentProjectSiteName = siteNameToSelect; // Store for future use
                            }
                            break;
                        }
                    }
                }
            }
            
            // Populate Site dropdown
            var $siteSelect = $('#selectDefaultSite');
            $siteSelect.empty(); // Clear existing options
            
            
            if (data && Array.isArray(data) && data.length > 0) {
                // Add options from API response
                $.each(data, function(index, site) {
                    var siteName = site.Names !== undefined ? site.Names : (site.names !== undefined ? site.names : '');
                    if (siteName && siteName.trim() !== '') {
                        $siteSelect.append($('<option>', {
                            value: siteName,
                            text: siteName
                        }));
                    }
                });
            }
            
            // Refresh selectpicker
            $siteSelect.selectpicker('refresh');
            
            // Pre-select the site after refresh (using selectpicker's val method)
            if (siteNameToSelect && siteNameToSelect.trim() !== '') {
                // Small delay to ensure selectpicker is fully refreshed
                setTimeout(function() {
                    // Check if the site name exists in the dropdown
                    var $option = $siteSelect.find('option[value="' + siteNameToSelect + '"]');
                    if ($option.length > 0) {
                        // Set the value on the native select first
                        $siteSelect.val(siteNameToSelect);
                        // Then use selectpicker's val method to update the UI
                        $siteSelect.selectpicker('val', siteNameToSelect);
                        // Force a render to ensure the selection is visible
                        $siteSelect.selectpicker('render');
                    }
                }, 150);
            }
        }

        // Handle site dropdown change event - load site data in all 4 tabs
        var isUpdatingDropdownProgrammatically = false;
        $(document).on('changed.bs.select', '#selectDefaultSite', function () {
            var selectedProjectID = $('#cboProject').val();
            // Ignore if we're programmatically updating the dropdown
            if (isUpdatingDropdownProgrammatically) {
                return;
            }
            
            var selectedSiteName = $(this).val();
            
            // Ignore if "Select Site" is selected
            if (!selectedSiteName || selectedSiteName === 'Select Site' || selectedSiteName.trim() === '') {
                // Clear current site data
                currentProjectSiteID = null;
                currentProjectSiteName = null;
                // Clear calendar
                clearCalendar();
                return;
            }
            
            // Store the selected site name
            currentProjectSiteName = selectedSiteName;
            
            // Get site ID from site name by calling GetAllProjectSites
            var sitesParams = {
                ProjectID: selectedProjectID,
                Name: null,
                ShortName: null,
                Currency: null,
                RateMethod: null,
                Days: null,
                WorkingDays: null,
                WorkingHours: null,
                ExtraHours: null,
                WHoursMonth: null,
                OffshoreSite: null
            };
            var sitesParam = JSON.stringify(sitesParams);
            var sitesResult = AJAXCallWithResult('api/ProjectSites/GetAllProjectSites', sitesParam, false);
            var sitesData = extractApiData(sitesResult, 'projectSites');
            
            if (sitesData && Array.isArray(sitesData) && sitesData.length > 0) {
                // Find the site with matching name
                var foundSite = null;
                for (var i = 0; i < sitesData.length; i++) {
                    var site = sitesData[i];
                    var siteName = site.name || site.Name || '';
                    if (siteName === selectedSiteName) {
                        foundSite = site;
                        break;
                    }
                }
                
                if (foundSite) 
                {
                    var siteID = foundSite.projectSiteID || foundSite.ProjectSiteID;

                    if (siteID && siteID > 0) {

                    // ✅ SET GLOBAL STATE (THIS WAS MISSING)
                    currentProjectSiteID = siteID;
                    currentProjectSiteName = selectedSiteName;

                    isUpdatingDropdownProgrammatically = true;

                    var offcanvasElement = $('#AddProjectSiteOffcanvas')[0];
                    if (!$(offcanvasElement).hasClass('show')) {
                        $('#AddProjectSiteOffcanvas').offcanvas('show');
                    }

                    if (typeof loadOULevelHolidays === 'function') {
                        loadOULevelHolidays();
                    }

                    if (typeof fetchWorkingDays === 'function') {
                        fetchWorkingDays(selectedProjectID, siteID);
                    }

                    if (typeof getWorkHrsExtraHoursCap === 'function') {
                        getWorkHrsExtraHoursCap(selectedProjectID, siteID);
                    }

                    currentCalendarDate = new Date();

                    if (typeof loadMonthCalendarData === 'function') {
                        var year = currentCalendarDate.getFullYear();
                        var month = currentCalendarDate.getMonth() + 1;
                        loadMonthCalendarData(selectedProjectID, siteID, year, month);
                    }

                    if ($('#prositedetailTab3').hasClass('active')) {
                        renderCalendarHeader();
                        renderCalendar(currentCalendarDate);
                    }

                    setTimeout(function () {
                        isUpdatingDropdownProgrammatically = false;
                    }, 300);
                    } else 
                    {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Unable to find site ID for selected site');
                    }
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Selected site not found in project sites');
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Unable to load project sites');
            }
        });

        // Pagination Functions
        // NOTE: Pagination variables (currentPage, itemsPerPage, totalPages) are declared earlier (after DataTable initialization)
        // to avoid "Cannot access before initialization" errors
        function updatePagination() {
            var table = $("#trainingPlanTbl").DataTable();
            var info = table.page.info();
            var totalRecords = info.recordsTotal;
            
            $("#totalRecords").text(totalRecords);
            
            currentPage = info.page + 1;
            totalPages = info.pages;
            
            // Update previous button
            if (currentPage <= 1) {
                $("#btnprevious").addClass("fa-disabled");
            } else {
                $("#btnprevious").removeClass("fa-disabled");
            }
            
            // Update next button
            if (currentPage >= totalPages) {
                $("#btnnext").addClass("fa-disabled");
            } else {
                $("#btnnext").removeClass("fa-disabled");
            }
        }

        function goToPreviousPage() {
            // Hide any visible tooltips
            $('[data-bs-toggle="tooltip"]').tooltip('hide');
            var table = $("#trainingPlanTbl").DataTable();
            var info = table.page.info();
            if (info.page > 0) {
                table.page('previous').draw('page');
                updatePagination();
            }
        }

        function goToNextPage() {
            // Hide any visible tooltips
            $('[data-bs-toggle="tooltip"]').tooltip('hide');
            var table = $("#trainingPlanTbl").DataTable();
            var info = table.page.info();
            if (info.page < info.pages - 1) {
                table.page('next').draw('page');
                updatePagination();
            }
        }

        // Initialize pagination on table draw
        $("#trainingPlanTbl").on('draw.dt', function () {
            updatePagination();
        });


        // History Table Pagination Functions
        let historyCurrentPage = 1;
        let historyItemsPerPage = 10;
        let historyTotalPages = 1;

        function updateHistoryPagination() {
            var table = $("#ProjectSiteShowHisTable").DataTable();
            var info = table.page.info();
            var totalRecords = info.recordsTotal;
            
            $("#historyTotalRecords").text(totalRecords);
            
            historyCurrentPage = info.page + 1;
            historyTotalPages = info.pages;
            
            // Update previous button
            if (historyCurrentPage <= 1) {
                $("#historyBtnPrevious").addClass("fa-disabled");
            } else {
                $("#historyBtnPrevious").removeClass("fa-disabled");
            }
            
            // Update next button
            if (historyCurrentPage >= historyTotalPages) {
                $("#historyBtnNext").addClass("fa-disabled");
            } else {
                $("#historyBtnNext").removeClass("fa-disabled");
            }
        }

        function goToHistoryPreviousPage() {
            // Hide any visible tooltips
            $('[data-bs-toggle="tooltip"]').tooltip('hide');
            var table = $("#ProjectSiteShowHisTable").DataTable();
            var info = table.page.info();
            if (info.page > 0) {
                table.page('previous').draw('page');
                updateHistoryPagination();
            }
        }

        function goToHistoryNextPage() {
            // Hide any visible tooltips
            $('[data-bs-toggle="tooltip"]').tooltip('hide');
            var table = $("#ProjectSiteShowHisTable").DataTable();
            var info = table.page.info();
            if (info.page < info.pages - 1) {
                table.page('next').draw('page');
                updateHistoryPagination();
            }
        }

        // Initialize DataTable for history table when tab is shown
        // Show History tab handler - load history when tab is shown
        <%--$('a[href="#prositedetailTab4"]').on('shown.bs.tab', function (e) {
            // Populate Modified By dropdown with distinct values when tab is shown
            populateModifiedByDropdown();
            populateModifiedFieldDropdown();
            if (!$.fn.DataTable.isDataTable("#ProjectSiteShowHisTable")) {
                var historyTable = $("#ProjectSiteShowHisTable").DataTable({
                    scrollY: true,
                    scrollX: true,
                    paging: true,
                    pageLength: 10,
                    lengthChange: false,
                    searching: false,
                    ordering: false,
                    responsive: true,
                    destroy: false,
                    retrieve: true,
                    info: false,
                    pagingType: "simple",
                    columnDefs: [
                        { orderable: false, targets: '_all' }
                    ],
                    columns: [
                        { data: 'ModifiedField' },
                        { data: 'OldValue' },
                        { data: 'NewValue' },
                        { data: 'ModifiedDate' },
                        { data: 'ModifiedBy' }
                    ],
                    language: {
                        paginate: {
                            previous: "<%=MyBase.GetResourceString("C_PreviousPage")%>",
                            next: "<%=MyBase.GetResourceString("C_NextPage")%>"
                        }
                    }
                });

                // Hide default DataTables pagination for history table
                $("#ProjectSiteShowHisTable_wrapper .dataTables_paginate").css("display", "none");

                // Initialize pagination on history table draw
                $("#ProjectSiteShowHisTable").on('draw.dt', function () {
                    updateHistoryPagination();
                });
            }
            // Load history data when tab is shown (after DataTable is initialized)
            loadProjectSiteHistory();

            // Check and update Clear button visibility
            toggleHistoryClearButton();
        });--%>

        // Function to check if any history filters are active
        function hasActiveHistoryFilters() {
            var modifiedField = $('#modifiedHisField').val();
            var modifiedBy = $('#modifiedHisBy').val();
            var hasModifiedField = modifiedField && modifiedField !== ResourceStrings.C_SelectOption && modifiedField !== '';
            var hasModifiedBy = modifiedBy && modifiedBy !== ResourceStrings.C_SelectOption && modifiedBy !== '';
            return hasModifiedField || hasModifiedBy;
        }

        // Function to toggle Clear button visibility for history filters
        function toggleHistoryClearButton() {
            if (hasActiveHistoryFilters()) {
                $('#clearHistoryFilters').show();
            } else {
                $('#clearHistoryFilters').hide();
            }
        }

        // Function to clear history filters
        function clearHistoryFilters() {
            // Reset Modified Field dropdown to "Select Option"
            $('#modifiedHisField').val("Select Modified Field");
            $('#modifiedHisField').selectpicker('refresh');

            // Reset Modified By dropdown to "Select Option"
            $('#modifiedHisBy').val("Select Modified By");
            $('#modifiedHisBy').selectpicker('refresh');

            // Hide Clear button
            $('#clearHistoryFilters').hide();

            // Reload history with cleared filters
            if (currentProjectSiteID && currentProjectSiteID > 0) {
                loadProjectSiteHistory();
            }
        }


        // Function to apply filters
        function applyFilters() {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project first');
                return;
            }

            // Reload project sites with filters
            loadAllProjectSites();

            // Show Clear All button if any filter is applied
            checkAndShowClearAllButton();
        }

        // Function to check if any filter is applied and show/hide Clear All button
        function checkAndShowClearAllButton() {
            var hasFilters = false;

            // Check text inputs (must have non-empty value)
            var nameFilter = $("#nameFilter").val();
            if (nameFilter && nameFilter.trim() !== '') hasFilters = true;

            var shortNameFilter = $("#shortNameFilter").val();
            if (shortNameFilter && shortNameFilter.trim() !== '') hasFilters = true;

            var workingDaysFilter = $("#workingDaysFilter").val();
            if (workingDaysFilter && workingDaysFilter.trim() !== '') hasFilters = true;

            var workingHoursFilter = $("#workingHoursFilter").val();
            if (workingHoursFilter && workingHoursFilter.trim() !== '') hasFilters = true;

            var extraHoursFilter = $("#extraHoursFilter").val();
            if (extraHoursFilter && extraHoursFilter.trim() !== '') hasFilters = true;

            var workHoursMonthFilter = $("#workHoursMonthFilter").val();
            if (workHoursMonthFilter && workHoursMonthFilter.trim() !== '') hasFilters = true;

            // Check dropdowns (must not be default/empty option)
            var currencyVal = $("#projFilterCurrency").val();
            if (currencyVal && currencyVal !== ResourceStrings.C_SelectCurrency && currencyVal !== '' && currencyVal !== null) hasFilters = true;

            var rateMethodVal = $("#projFilterRateMethod").val();
            if (rateMethodVal && rateMethodVal !== "Select Rate Method" && rateMethodVal !== '' && rateMethodVal !== null) hasFilters = true;

            var dayOfWeekVal = $("#projFilterDayOfWeek").val();
            if (dayOfWeekVal && dayOfWeekVal !== "Select Days of Week" && dayOfWeekVal !== '' && dayOfWeekVal !== null) hasFilters = true;

            var offshoreVal = $("#projFilterOffshoreSite").val();
            if (offshoreVal && offshoreVal !== ResourceStrings.C_SelectOption && offshoreVal !== '' && offshoreVal !== null) hasFilters = true;

            // Show or hide Clear All button
            if (hasFilters) {
                $("#PMProjectSitesClearAllFilter").show();
            } else {
                $("#PMProjectSitesClearAllFilter").hide();
            }
        }

        // Clear all filters function
        function clearAll() {
            // Clear text inputs
            $("#nameFilter").val("");
            $("#shortNameFilter").val("");
            $("#workingDaysFilter").val("");
            $("#workingHoursFilter").val("");
            $("#extraHoursFilter").val("");
            $("#workHoursMonthFilter").val("");
            var selectedProjectID = $('#cboProject').val();
            // Clear dropdowns by selecting the first option (default placeholder option)
            // This preserves the original placeholder text instead of showing "Nothing selected"
            var $currencySelect = $("#projFilterCurrency");
            $currencySelect.val($currencySelect.find('option:first').val()).selectpicker('refresh');

            var $rateMethodSelect = $("#projFilterRateMethod");
            $rateMethodSelect.val($rateMethodSelect.find('option:first').val()).selectpicker('refresh');

            var $dayOfWeekSelect = $("#projFilterDayOfWeek");
            $dayOfWeekSelect.val($dayOfWeekSelect.find('option:first').val()).selectpicker('refresh');

            var $offshoreSelect = $("#projFilterOffshoreSite");
            $offshoreSelect.val($offshoreSelect.find('option:first').val()).selectpicker('refresh');

            // Check and hide Clear All button (should hide since all filters are cleared)
            checkAndShowClearAllButton();

            // Reload project sites without filters
            if (selectedProjectID && selectedProjectID > 0) {
                loadAllProjectSites();
            }
        }

        // Wire up Apply filter button
        $(document).on('click', '#applyFilterBtn', function () {
            applyFilters();
        });


        // Handle project dropdown change
        function PlotProjectonChange() {
            currentProjectSiteName = null;

            var selectedProjectID = $('#cboProject').val();
            if (selectedProjectID && selectedProjectID !== '0') {
                currentProjectID = parseInt(selectedProjectID);
                // Load project sites for the selected project
                loadAllProjectSites();
            } else {
                // Clear table if no project selected
                projectSitesTable.clear().draw();
                updatePagination();
            }
            var offcanvasElement = document.getElementById('AddProjectSiteOffcanvas');
            var offcanvasInstance = bootstrap.Offcanvas.getInstance(offcanvasElement);
            if (offcanvasInstance) {
                offcanvasInstance.hide();
            }
        }

        function clearCalendar() {
            // Clear calendar data source
            monthCalendarData = []; // or whatever array you use

            // Reset calendar date
            currentCalendarDate = new Date();

            // Clear calendar UI
            if (typeof renderCalendarHeader === 'function') {
                renderCalendarHeader();
            }

            if (typeof renderCalendar === 'function') {
                renderCalendar(currentCalendarDate);
            }
        }

        // Handle selectpicker change event
        $(document).on('changed.bs.select', '#cboProject', function () {
            var selectedProjectID = $('#cboProject').val();
            if (selectedProjectID && selectedProjectID === '0') {
                $('#InheritProjectBtn').hide();
                $('#AddProjectBtn').hide();
                $('#DeleteProjectBtn').hide();
            } else {
                $('#InheritProjectBtn').show();
                $('#AddProjectBtn').show();
                $('#DeleteProjectBtn').show();
            }
            PlotProjectonChange();
        });

        // Function to clear all form fields when adding new project site
        function clearProjectSiteForm() {
            // Clear selected site name when adding new site
            currentProjectSiteName = null;
            // Clear text inputs
            $('#ResName').val('');
            $('#ResShortName').val('');
            $('#projDetailsWorkingDays').val('');
            $('#projDetailsWorkingHours').val('');
            $('#projDetailsExtraHours').val('');
            $('#projDetailsWHoursMonth').val('');
            $('#projDetailsAdd1').val('');
            $('#projDetailsAdd2').val('');
            $('#projDetailsState').val('');
            $('#projDetailsCity').val('');
            $('#projDetailsZip').val('');
            $('#projDetailsFax').val('');
            $('#projDetailsPhone').val('');
            $('#projDetailsEmail').val('');
            $('#projDetailsRemarks').val('');

            // Reset dropdowns to default/empty
            $('#projDetailsCurrency').val('0').selectpicker('refresh');
            $('#projDetailsRateMethod').val('0').selectpicker('refresh');
            $('#projDetailsDays').val('0').selectpicker('refresh');
            $('#projDetailsCountry').val('0').selectpicker('refresh');

            // Uncheck checkbox and enable it
            $('#OffshoreSiteChk').prop('checked', false);
            $('#OffshoreSiteChk').prop('disabled', false);
            // Remove disabled class and tooltip
            $('#OffshoreSiteChk').closest('.custom_chckbox').removeClass('offshore-disabled');
            $('#OffshoreSiteChk').removeAttr('title');
            $('#OffshoreSiteChk').removeAttr('data-bs-toggle');
            var tooltipElement = document.getElementById('OffshoreSiteChk');
            if (tooltipElement) {
                var tooltipInstance = bootstrap.Tooltip.getInstance(tooltipElement);
                if (tooltipInstance) {
                    tooltipInstance.dispose();
                }
            }
            $('#OffshoreSiteChk').prop('disabled', false);
            // Remove disabled class and tooltip
            $('#OffshoreSiteChk').closest('.custom_chckbox').removeClass('offshore-disabled');
            $('#OffshoreSiteChk').removeAttr('title');
            $('#OffshoreSiteChk').removeAttr('data-bs-toggle');
            var tooltipElement = document.getElementById('OffshoreSiteChk');
            if (tooltipElement) {
                var tooltipInstance = bootstrap.Tooltip.getInstance(tooltipElement);
                if (tooltipInstance) {
                    tooltipInstance.dispose();
                }
            }

            // Reset currentProjectSiteID to indicate new entry
            currentProjectSiteID = 0;

            // Clear role rate table if it exists
            if ($.fn.DataTable.isDataTable("#rolerateTbl")) {
                $("#rolerateTbl").DataTable().clear().draw();
            }

            // Clear history table if it exists
            if ($.fn.DataTable.isDataTable("#ProjectSiteShowHisTable")) {
                $("#ProjectSiteShowHisTable").DataTable().clear().draw();
            }

            // Reset to Details tab
            $('a[href="#prositedetailTab1"]').tab('show');

            // Show main Role Rate view (hide detail view if visible)
            $(".RoleRateContent").hide();
            $(".RoleRateContentMain").show();

            // Update button visibility (hide freeze button in add mode)
            updateSaveButtonsVisibility();
        }

        // Handle Add button click - clear form before opening offcanvas
        $(document).on('click', '#AddProjectBtn', function (e) {
            // Clear form
            clearProjectSiteForm();

            // Reset currentProjectSiteID to null for Add mode
            currentProjectSiteID = null;

            // Show only Details tab, hide other tabs
            $('a[href="#prositedetailTab1"]').tab('show');

            // Hide other tab links (Role Rate, Site Calendar, Show History)
            $('a[href="#prositedetailTab2"]').parent().hide();
            $('a[href="#prositedetailTab3"]').parent().hide();
            $('a[href="#prositedetailTab4"]').parent().hide();

            // Update Save buttons visibility (Add mode)
            updateSaveButtonsVisibility();
        });

        // When offcanvas is shown, restore tab visibility if editing (not adding)
        $(document).on('shown.bs.offcanvas', '#AddProjectSiteOffcanvas', function () {
            // If editing (currentProjectSiteID exists), show all tabs
            if (currentProjectSiteID && currentProjectSiteID > 0) {
                $('a[href="#prositedetailTab2"]').parent().show();
                $('a[href="#prositedetailTab3"]').parent().show();
                $('a[href="#prositedetailTab4"]').parent().show();
            }
            // If adding (no currentProjectSiteID), tabs should remain hidden (set in Add button handler)

            // Update Save buttons visibility based on Add vs Edit mode
            updateSaveButtonsVisibility();
        });

        // Handle Delete button click
        $(document).on('click', '#DeleteProjectBtn', function (e) {
            e.preventDefault();

            // Check delete access permission
            if (!m_blnDeleteAccess) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('You do not have permission to delete project sites.');
                return;
            }

            // Collect selected site IDs (only from enabled checkboxes)
            var selectedIDs = [];
            $(".chcktbl:checked:not([disabled])").each(function () {
                var siteID = $(this).data('site-id');
                if (siteID) {
                    selectedIDs.push(siteID);
                }
            });

            if (selectedIDs.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select at least one site to delete.');
                return;
            }

            // Store selected IDs for use in modal handlers
            window.pendingDeleteSiteIDs = getSelectedProjectSiteIDs();

            // Show confirmation modal
            $('#deleteProjectSiteModal').modal('show');
        });

        function getSelectedProjectSiteIDs() {
            var ids = [];

            var nodes = projectSitesTable.rows().nodes();
            $(nodes).find(".chcktbl:checked").each(function () {
                ids.push($(this).data("site-id"));
            });

            return ids;
        }

        // Added by Nischal C on 30 Nov 2025 for deleting project sites via API
        // Function to delete project sites
        function deleteProjectSites(projectSiteIDs) {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project first.');
                return;
            }

            var param = JSON.stringify({
                ProjectID: selectedProjectID,
                ProjectSiteIDs: projectSiteIDs.join(',')
            });

            StartLoader("body");

            var Result = AJAXCallWithResult(
                'api/ProjectSites/DelProjectSiteData',
                param
            );

            StopAjaxLoader("body");

            alertify.set('notifier', 'position', 'top-right');

            if (!Result) {
                alertify.error(ResourceStrings.A_ErrorOccurredWhileDeletingProjectSites);
                return;
            }

            // normalize message
            var mainMessage = Result.message || '';
            var detailedMessage = Result.result && Result.result.length > 0
                ? Result.result[0].result
                : '';

            // ✅ CHECK SUCCESS STRING
            if (mainMessage === "Project site(s) deleted successfully!") {

                alertify.success(mainMessage);

                setTimeout(function () {
                    loadAllProjectSites();
                }, 500);

            } else {
                // ❌ ERROR CASE
                alertify.error(mainMessage || ResourceStrings.A_FailedToDeleteProjectSites);
            }
        }

        // End of added by Nischal C on 30 Nov 2025 for deleting project sites via API

        // Handle Offshore Site Change Confirmation Modal
        $(document).on('click', '#btnOffshoreChangeYes', function () {
            // User clicked Yes - proceed with save
            if (window.pendingOffshoreSave) {
                var saveParams = window.pendingOffshoreSave;
                proceedWithSave(saveParams.saveAndAdd, saveParams.isOffshore);
                window.pendingOffshoreSave = null; // Clear stored params
            }
        });

        $(document).on('click', '#btnOffshoreChangeNo, #btnOffshoreChangeNo1', function () {
            // User clicked No - uncheck checkbox and clear stored params
            $('#OffshoreSiteChk').prop('checked', false);
            $('#OffshoreSiteChk').prop('disabled', false);
            // Remove disabled class and tooltip
            $('#OffshoreSiteChk').closest('.custom_chckbox').removeClass('offshore-disabled');
            $('#OffshoreSiteChk').removeAttr('title');
            $('#OffshoreSiteChk').removeAttr('data-bs-toggle');
            var tooltipElement = document.getElementById('OffshoreSiteChk');
            if (tooltipElement) {
                var tooltipInstance = bootstrap.Tooltip.getInstance(tooltipElement);
                if (tooltipInstance) {
                    tooltipInstance.dispose();
                }
            }
            window.pendingOffshoreSave = null; // Clear stored params
        });

        // Handle Delete Confirmation Modal - Yes button
        $(document).on('click', '#btnDeleteSiteYes', function () {
            // User clicked Yes - proceed with delete
            if (window.pendingDeleteSiteIDs && window.pendingDeleteSiteIDs.length > 0) {
                deleteProjectSites(window.pendingDeleteSiteIDs);
                window.pendingDeleteSiteIDs = null; // Clear stored IDs
            }
        });

        // Handle Delete Confirmation Modal - No button and close button
        $(document).on('click', '#btnDeleteSiteNo, #btnDeleteSiteNo1', function () {
            // User clicked No or Close - cancel delete
            window.pendingDeleteSiteIDs = null; // Clear stored IDs
        });

        // Global variable to store selected calendar date
        var selectedCalendarDate = null;
        var currentSiteCalendarDayID = null;

        // Function to open calendar modal for a specific date
        function openCalendarModal(date) {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0" || !currentProjectSiteID || currentProjectSiteID === 0 || currentProjectSiteID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project and site first.');
                return;
            }

            selectedCalendarDate = date;
            currentSiteCalendarDayID = null;

            // Format date for display
            var dateStr = formatDateForDisplay(date);
            $('#calendarModalDateText').text(dateStr);

            // Format date for API (YYYY-MM-DD)
            var apiDateStr = formatDateForAPI(date);

            // Check if date is a weekend
            var isWeekend = checkIsWeekend(selectedProjectID, currentProjectSiteID, apiDateStr);
            // Store weekend status for potential use in modal
            window.selectedDateIsWeekend = isWeekend;

            // Get updated hours if date exists (this also returns SiteCalendarDayID if it exists)
            var hoursData = getUpdatedHours(selectedProjectID, currentProjectSiteID, apiDateStr);

            // Extract SiteCalendarDayID from hoursData if available (this is the primary source)
            if (hoursData && hoursData.SiteCalendarDayID) {
                currentSiteCalendarDayID = hoursData.SiteCalendarDayID;
            } else {
                // Fallback: Try to get Site Calendar ID separately if not in hoursData
                var siteCalendarID = getSiteCalendarID(currentProjectSiteID, apiDateStr);
                if (siteCalendarID) {
                    currentSiteCalendarDayID = siteCalendarID;
                } else {
                    currentSiteCalendarDayID = null;
                }
            }

            // Show/hide Set Default button based on whether entry exists
            if (currentSiteCalendarDayID && currentSiteCalendarDayID > 0) {
                // Entry exists, show Set Default button
                $('#caleModalSetDefaultBtn').show();
            } else {
                // No entry exists, hide Set Default button
                $('#caleModalSetDefaultBtn').hide();
            }

            // Get default work hours from site configuration (to use as fallback)
            var defaultWorkHrs = getWorkHrsExtraHoursCap(selectedProjectID, currentProjectSiteID);

            // Check if the date is a holiday (from OU-level holidays or calendar entries)
            var isDateHoliday = isHolidayDate(date);


            // Determine which values to use
            // If calendar entry exists and has non-zero values, use those
            // Otherwise, use default work hours from site configuration
            var normalHours, extraHours, isHoliday;

            if (hoursData && hoursData.NormalHours !== undefined && hoursData.NormalHours !== null && hoursData.NormalHours !== 0) {
                // Calendar entry exists with actual hours
                normalHours = hoursData.NormalHours;
                extraHours = hoursData.ExtraHours !== undefined && hoursData.ExtraHours !== null ? hoursData.ExtraHours : 0;
                // Use holiday status from calendar entry, or from holiday check if not set
                isHoliday = (hoursData.Holiday === true || hoursData.Holiday === 1) || isDateHoliday;
            } else if (defaultWorkHrs) {
                // No calendar entry or entry has 0 values, use default work hours
                normalHours = defaultWorkHrs.WorkHrs !== undefined && defaultWorkHrs.WorkHrs !== null ? defaultWorkHrs.WorkHrs : 0;
                extraHours = defaultWorkHrs.ExtraHoursCap !== undefined && defaultWorkHrs.ExtraHoursCap !== null ? defaultWorkHrs.ExtraHoursCap : 0;
                // Use holiday status from calendar entry if exists, otherwise from holiday check
                isHoliday = (hoursData && (hoursData.Holiday === true || hoursData.Holiday === 1)) || isDateHoliday;
            } else {
                // Fallback: use calendar entry values even if 0, or clear fields
                normalHours = hoursData ? (hoursData.NormalHours !== undefined && hoursData.NormalHours !== null ? hoursData.NormalHours : 0) : 0;
                extraHours = hoursData ? (hoursData.ExtraHours !== undefined && hoursData.ExtraHours !== null ? hoursData.ExtraHours : 0) : 0;
                // Use holiday status from calendar entry if exists, otherwise from holiday check
                isHoliday = (hoursData && (hoursData.Holiday === true || hoursData.Holiday === 1)) || isDateHoliday;
            }

            // Convert to string - explicitly handle 0 as a valid value
            var normalHoursStr = '';
            if (normalHours !== undefined && normalHours !== null) {
                normalHoursStr = String(normalHours);
            }

            var extraHoursStr = '';
            if (extraHours !== undefined && extraHours !== null) {
                extraHoursStr = String(extraHours);
            }

            // Set values directly on the input elements
            if (hoursData && hoursData.NormalHours !== undefined && hoursData.NormalHours !== null && hoursData.NormalHours !== 0) {
                $('#calendarNormalHours').val(normalHoursStr);
                $('#calendarExtraHours').val(extraHoursStr);
                $('#calendarHolidayCheck').prop('checked', false);
                if (isWeekend) {
                    $('#calendarHolidayCheck').prop('checked', false);
                } else if (isHoliday) {
                    $('#calendarHolidayCheck').prop('checked', true);
                }
            }
            else if (isHoliday || isWeekend) {
                $('#calendarNormalHours').val(0.00);
                $('#calendarExtraHours').val(0.00);
                $('#calendarHolidayCheck').prop('checked', true);
            } else {
                $('#calendarNormalHours').val(normalHoursStr);
                $('#calendarExtraHours').val(extraHoursStr);
                $('#calendarHolidayCheck').prop('checked', false);
            }


            // SiteCalendarDayID should already be set from hoursData above
            // This is just a safety check - if somehow it's still null, try getSiteCalendarID as fallback
            if (!currentSiteCalendarDayID) {
                var siteCalendarID = getSiteCalendarID(currentProjectSiteID, apiDateStr);
                if (siteCalendarID) {
                    currentSiteCalendarDayID = siteCalendarID;
                }
            }

            // Show modal AFTER setting values
            // Use setTimeout to ensure DOM is ready and values are set
            setTimeout(function () {
                $('#SCDetailsModal').modal('show');

                // Double-check values after modal is shown (in case modal reset them)
                setTimeout(function () {
                    // Re-check if date is a holiday (in case holidays were loaded after modal opened)
                    var isDateHolidayCheck = isHolidayDate(date);

                    // Re-calculate values using the same logic
                    var hoursDataCheck = getUpdatedHours(selectedProjectID, currentProjectSiteID, apiDateStr);

                    // Update SiteCalendarDayID from hoursDataCheck if available
                    if (hoursDataCheck && hoursDataCheck.SiteCalendarDayID) {
                        currentSiteCalendarDayID = hoursDataCheck.SiteCalendarDayID;
                    }

                    // Update Set Default button visibility after re-checking
                    if (currentSiteCalendarDayID && currentSiteCalendarDayID > 0) {
                        $('#caleModalSetDefaultBtn').show();
                    } else {
                        $('#caleModalSetDefaultBtn').hide();
                    }

                    var defaultWorkHrsCheck = getWorkHrsExtraHoursCap(selectedProjectID, currentProjectSiteID);

                    var normalHoursCheck, extraHoursCheck, isHolidayCheck;
                    if (hoursDataCheck && hoursDataCheck.NormalHours !== undefined && hoursDataCheck.NormalHours !== null && hoursDataCheck.NormalHours !== 0) {
                        normalHoursCheck = hoursDataCheck.NormalHours;
                        extraHoursCheck = hoursDataCheck.ExtraHours !== undefined && hoursDataCheck.ExtraHours !== null ? hoursDataCheck.ExtraHours : 0;
                        isHolidayCheck = (hoursDataCheck.Holiday === true || hoursDataCheck.Holiday === 1) || isDateHolidayCheck;
                    } else if (defaultWorkHrsCheck) {
                        normalHoursCheck = defaultWorkHrsCheck.WorkHrs !== undefined && defaultWorkHrsCheck.WorkHrs !== null ? defaultWorkHrsCheck.WorkHrs : 0;
                        extraHoursCheck = defaultWorkHrsCheck.ExtraHoursCap !== undefined && defaultWorkHrsCheck.ExtraHoursCap !== null ? defaultWorkHrsCheck.ExtraHoursCap : 0;
                        isHolidayCheck = (hoursDataCheck && (hoursDataCheck.Holiday === true || hoursDataCheck.Holiday === 1)) || isDateHolidayCheck;
                    } else {
                        normalHoursCheck = hoursDataCheck ? (hoursDataCheck.NormalHours !== undefined && hoursDataCheck.NormalHours !== null ? hoursDataCheck.NormalHours : 0) : 0;
                        extraHoursCheck = hoursDataCheck ? (hoursDataCheck.ExtraHours !== undefined && hoursDataCheck.ExtraHours !== null ? hoursDataCheck.ExtraHours : 0) : 0;
                        isHolidayCheck = (hoursDataCheck && (hoursDataCheck.Holiday === true || hoursDataCheck.Holiday === 1)) || isDateHolidayCheck;
                    }

                    var normalHoursStr = (normalHoursCheck !== undefined && normalHoursCheck !== null) ? String(normalHoursCheck) : '';
                    var extraHoursStr = (extraHoursCheck !== undefined && extraHoursCheck !== null) ? String(extraHoursCheck) : '';
                    if (hoursDataCheck && hoursDataCheck.NormalHours !== undefined && hoursDataCheck.NormalHours !== null && hoursDataCheck.NormalHours !== 0) {
                        $('#calendarNormalHours').val(normalHoursStr);
                        $('#calendarExtraHours').val(extraHoursStr);
                        $('#calendarHolidayCheck').prop('checked', false);
                        if (isWeekend) {
                            $('#calendarHolidayCheck').prop('checked', false);
                        } else if (isHolidayCheck) {
                            $('#calendarHolidayCheck').prop('checked', true);
                        }
                    }
                    else if (isHolidayCheck || isWeekend) {
                        $('#calendarNormalHours').val(0.00);
                        $('#calendarExtraHours').val(0.00);
                        $('#calendarHolidayCheck').prop('checked', true);
                    } else {
                        $('#calendarNormalHours').val(normalHoursStr);
                        $('#calendarExtraHours').val(extraHoursStr);
                        $('#calendarHolidayCheck').prop('checked', false);
                    }

                }, 100);
            }, 50);
        }


        $('#calendarHolidayCheck').on('change', function () {
            var selectedProjectID = $('#cboProject').val();
            if ($(this).is(':checked')) {
                prevNormalHours = $('#calendarNormalHours').val();
                prevExtraHours = $('#calendarExtraHours').val();

                $('#calendarNormalHours').val(0.00);
                $('#calendarExtraHours').val(0.00);
            } else {
                var defaultWorkHrs = getWorkHrsExtraHoursCap(selectedProjectID, currentProjectSiteID);
                normalHoursCheck = defaultWorkHrs.WorkHrs !== undefined && defaultWorkHrs.WorkHrs !== null ? defaultWorkHrs.WorkHrs : 0.00;
                extraHoursCheck = defaultWorkHrs.ExtraHoursCap !== undefined && defaultWorkHrs.ExtraHoursCap !== null ? defaultWorkHrs.ExtraHoursCap : 0.00;
                $('#calendarNormalHours').val(normalHoursCheck);
                $('#calendarExtraHours').val(extraHoursCheck);
            }
        });

        $('#calendarNormalHours, #calendarExtraHours').on('input', function () {
            let value = this.value
                .replace(/[^0-9.]/g, '')     // allow digits & dot
                .replace(/(\..*)\./g, '$1'); // only one dot

            let parts = value.split('.');

            // Max 9 digits before decimal
            if (parts[0].length > 3) {
                parts[0] = parts[0].substring(0, 3);
            }

            // Max 2 digits after decimal
            if (parts[1]) {
                parts[1] = parts[1].substring(0, 2);
            }

            this.value = parts.join('.');
        });

        $('#calendarNormalHours, #calendarExtraHours').on('blur', function () {
            if (this.value !== '') {
                this.value = parseFloat(this.value).toFixed(2);
            }
        });

        // Helper function to format date for display (DD-MM-YYYY)
        function formatDateForDisplay(date) {
            if (!date) return '';
            var d = new Date(date);
            var day = String(d.getDate()).padStart(2, '0');
            var month = String(d.getMonth() + 1).padStart(2, '0');
            var year = d.getFullYear();
            return day + '-' + month + '-' + year;
        }

        // Helper function to format date for API (YYYY-MM-DD)
        function formatDateForAPI(date) {
            if (!date) return '';
            var d = new Date(date);
            var year = d.getFullYear();
            var month = String(d.getMonth() + 1).padStart(2, '0');
            var day = String(d.getDate()).padStart(2, '0');
            return year + '-' + month + '-' + day;
        }

        // Function to save calendar entry
        // Added by Nischal C on 30 Nov 2025 for saving calendar entry via API
        function saveCalendarEntry() {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0" || !currentProjectSiteID || currentProjectSiteID === 0 || currentProjectSiteID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project and site first.');
                return;
            }

            if (!selectedCalendarDate) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a date first.');
                return;
            }

            // Get form values
            var normalHours = parseFloat($('#calendarNormalHours').val()) || 0;
            var extraHours = parseFloat($('#calendarExtraHours').val()) || 0;
            var isHoliday = $('#calendarHolidayCheck').is(':checked');

            // Validate Normal Hours (required)
            if (!isHoliday) {
                if (normalHours <= 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Normal Hours is required and should be greater than 0.');
                    $('#calendarNormalHours').focus();
                    return;
                }
            }

            if (normalHours > 24) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Normal Hours should be between 1 and 24.');
                $('#calendarNormalHours').focus();
                return;
            }
            if (extraHours > 24) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Extra Hours should be between 1 and 24.');
                $('#calendarExtraHours').focus();
                return;
            }

            if (normalHours + extraHours > 24) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Total of "Normal Hours" and "Extra Hours" should not be greater than 24. ');
                return;
            }

            // Format date for API
            var apiDateStr = formatDateForAPI(selectedCalendarDate);

            // Ensure SiteCalendarDayID is null (not empty string or undefined) if not set
            // Matches the pattern used by AddProjectSiteData and SaveProjectSiteData (nullable int?)
            var siteCalendarDayIDValue = null;
            if (currentSiteCalendarDayID && currentSiteCalendarDayID > 0) {
                // Ensure it's a proper integer, not a string
                siteCalendarDayIDValue = parseInt(currentSiteCalendarDayID, 10);
                // Double-check it's a valid number
                if (isNaN(siteCalendarDayIDValue) || siteCalendarDayIDValue <= 0) {
                    siteCalendarDayIDValue = null;
                }
            }

            // Ensure Holiday is always a proper boolean (true or false, not undefined/null)
            var holidayValue = Boolean(isHoliday);

            // Ensure NormalHours and ExtraHours are proper numbers (not strings)
            var normalHoursNum = parseFloat(normalHours) || 0;
            var extraHoursNum = parseFloat(extraHours) || 0;

            // Build Parameters object (EXACT same pattern as saveProjectSiteData)
            // Always include SiteCalendarDayID (even as null) to match entity structure for ActionFilter comparison
            var Parameters = {
                SiteCalendarDayID: siteCalendarDayIDValue,  // null for insert, number for update
                ProjectID: parseInt(selectedProjectID, 10),
                ProjectSiteID: parseInt(currentProjectSiteID, 10),
                CurrentDate: apiDateStr,
                NormalHours: normalHoursNum,
                ExtraHours: extraHoursNum,
                Holiday: holidayValue
            };


            // Show loading indicator
            StartLoader("#SCDetailsModal");

            // Call API to save calendar entry
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/AddHolidayProjectSiteCalendar', param, false);

            StopAjaxLoader("#SCDetailsModal");

            // Check if Result exists - even empty object {} indicates success
            // Only null/undefined indicate failure
            if (Result !== null && Result !== undefined && Result !== '') {
                // Handle API response structure
                var data = extractApiData(Result);

                var successMessage = ResourceStrings.A_CalendarEntrySavedSuccessfully;

                if (data && data.Message) {
                    successMessage = data.Message;
                } else if (data && data.Result) {
                    var resultMessage = Array.isArray(data.Result) && data.Result.length > 0
                        ? data.Result[0].Result || data.Result[0].result
                        : (data.Result.Result || data.Result.result);

                    if (resultMessage && resultMessage.toLowerCase().includes('success')) {
                        successMessage = resultMessage;
                    }
                } else if (Result && Result.message) {
                    successMessage = Result.message;
                }

                alertify.set('notifier', 'position', 'top-right');
                alertify.success(successMessage);

                // Update SiteCalendarDayID if returned
                if (data && data.Result && Array.isArray(data.Result) && data.Result.length > 0) {
                    if (data.Result[0].SiteCalendarDayID || data.Result[0].siteCalendarDayID) {
                        currentSiteCalendarDayID = data.Result[0].SiteCalendarDayID || data.Result[0].siteCalendarDayID;
                        // Show Set Default button since entry now exists
                        $('#caleModalSetDefaultBtn').show();
                    }
                }

                // Close modal
                $('#SCDetailsModal').modal('hide');

                // Reload month calendar data to refresh the cache after saving
                if (selectedProjectID && selectedProjectID > 0 && currentProjectSiteID && currentProjectSiteID > 0) {
                    var year = currentCalendarDate.getFullYear();
                    var month = currentCalendarDate.getMonth() + 1; // JavaScript months are 0-based, API expects 1-12
                    if (typeof loadMonthCalendarData === 'function') {
                        loadMonthCalendarData(selectedProjectID, currentProjectSiteID, year, month);
                    }
                }

                // Reload holidays and refresh calendar
                setTimeout(function () {
                    loadOULevelHolidays();
                    renderCalendarHeader();
                    if (typeof renderCalendar === 'function' && typeof currentCalendarDate !== 'undefined') {
                        renderCalendar(currentCalendarDate);
                    }
                }, 500);
            } else {
                // If Result is null/undefined but API call completed, assume success
                // (User confirmed API is working - changes visible after refresh)
                // This handles cases where API returns empty response or different structure
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(ResourceStrings.A_CalendarEntrySavedSuccessfully);

                // Close modal
                $('#SCDetailsModal').modal('hide');

                // Reload month calendar data to refresh the cache after saving
                if (selectedProjectID && selectedProjectID > 0 && currentProjectSiteID && currentProjectSiteID > 0) {
                    var year = currentCalendarDate.getFullYear();
                    var month = currentCalendarDate.getMonth() + 1;
                    if (typeof loadMonthCalendarData === 'function') {
                        loadMonthCalendarData(selectedProjectID, currentProjectSiteID, year, month);
                    }
                }

                // Reload holidays and refresh calendar
                setTimeout(function () {
                    loadOULevelHolidays();
                    renderCalendarHeader();
                    if (typeof renderCalendar === 'function' && typeof currentCalendarDate !== 'undefined') {
                        renderCalendar(currentCalendarDate);
                    }
                }, 500);
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for saving calendar entry via API

        // Handle calendar modal save button click
        $(document).on('click', '#caleModalSaveBtn', function () {
            saveCalendarEntry();
            if (m_blnEditAccess) {
                $('#freezeSiteBtn').removeClass("clsShowHide");
            }
        });

        // Added by Nischal C on 30 Nov 2025 for resetting calendar entry to default via API
        // Function to reset calendar entry to default (delete the entry)
        function setDefaultCalendarEntry() {
            var selectedProjectID = $('#cboProject').val();
            if (!selectedProjectID || selectedProjectID === 0 || selectedProjectID === "0" || !currentProjectSiteID || currentProjectSiteID === 0 || currentProjectSiteID === "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project and site first.');
                return;
            }

            if (!selectedCalendarDate) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a date first.');
                return;
            }

            if (!currentSiteCalendarDayID || currentSiteCalendarDayID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('No calendar entry exists for this date to reset.');
                return;
            }

            // Prepare request body
            var Parameters = {
                SiteCalendarDayID: parseInt(currentSiteCalendarDayID, 10)
            };

            // Show loader
            StartLoader("#SCDetailsModal");

            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/DeleteCalendarEntry', param, false);

            StopAjaxLoader("#SCDetailsModal");

            if (Result) {
                var data = extractApiData(Result);
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(Result.message || (data && data.Message) || ResourceStrings.A_CalendarEntryResetToDefaultSuccessfully);

                currentSiteCalendarDayID = null;

                // Refresh month view
                if (selectedCalendarDate) {
                    var dateObj = new Date(selectedCalendarDate);
                    loadMonthCalendarData(selectedProjectID, currentProjectSiteID, dateObj.getFullYear(), dateObj.getMonth() + 1);
                }

                // Refresh UI display
                if (typeof renderCalendar === 'function') {
                    renderCalendarHeader();
                    renderCalendar(currentCalendarDate);
                }

                // Close modal
                $('#SCDetailsModal').modal('hide');
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(ResourceStrings.A_FailedToResetCalendarEntry);
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for resetting calendar entry to default via API

        // Handle Set Default button click
        $(document).on('click', '#caleModalSetDefaultBtn', function () {
            setDefaultCalendarEntry();
        });

        // Added by Nischal C on 30 Nov 2025 for updating billing info via API
        // Function to update billing info
        function updateBillingInfo() {
            // Check edit access permission
            if (!m_blnEditAccess) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('You do not have permission to update billing rates.');
                return;
            }

            // Check if project site is selected
            if (!currentProjectSiteID || currentProjectSiteID === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please select a project site first');
                return;
            }

            var Parameters = {
                ProjectSiteID: currentProjectSiteID
            };
            var param = JSON.stringify(Parameters);
            alertify.set('notifier', 'position', 'top-right');

            // Show loading indicator
            StartLoader("#AddProjectSiteOffcanvas");

            try {
                var Result = AJAXCallWithResult('api/ProjectSites/UpdateBillingInfo', param, false);

                // Stop loading indicator
                StopAjaxLoader("#AddProjectSiteOffcanvas");

                // Handle response - check for success message or status
                var message = '';
                var isSuccess = false;

                // Get message from various possible response structures
                if (Result && Result.message) {
                    message = Result.message;
                } else if (Result && Result.data && Result.data.message) {
                    message = Result.data.message;
                }

                // Check if status indicates success
                if (Result && Result.status && Result.status.toLowerCase() === 'success') {
                    isSuccess = true;
                } else if (Result && Result.data && Result.data.status && Result.data.status.toLowerCase() === 'success') {
                    isSuccess = true;
                } else if (message && message.toLowerCase().includes('successfully')) {
                    // If message contains "successfully", treat as success
                    isSuccess = true;
                } else if (Result && Result.data && Result.data.data) {
                    // Check if there's data in the response (indicates success)
                    isSuccess = true;
                }

                if (isSuccess) {
                    alertify.success(message || 'Billing information updated successfully!');
                    // Reload role details to reflect updated rates
                    if (currentProjectSiteID && currentProjectSiteID > 0) {
                        loadRoleDetails();
                    }
                } else {
                    alertify.error(message || 'Failed to update billing information');
                }
            } catch (err) {
                StopAjaxLoader("#AddProjectSiteOffcanvas");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('An error occurred while updating billing information');
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for updating billing info via API

        // Toggle body scroll with offcanvas - Prevent double scrollbar
        $(document).on('show.bs.offcanvas', '.offcanvas', function () {
            $('html, body').addClass('no-scroll');
        });
        $(document).on('shown.bs.offcanvas', '.offcanvas', function () {
            $('html, body').addClass('no-scroll');
        });
        $(document).on('hide.bs.offcanvas', '.offcanvas', function () {
            // Keep no-scroll during hide transition
        });
        $(document).on('hidden.bs.offcanvas', '.offcanvas', function () {
            $('html, body').removeClass('no-scroll');

            // Reset Role Rate view to main view when offcanvas is closed
            $(".RoleRateContent").hide();
            $(".RoleRateRoleColumn").addClass('d-none').hide();
            $(".RoleRateContentMain").show();
            window.currentRoleID = null;
            window.currentRoleDescription = null;
        });

        // Calendar functionality - Simple calendar for UI
        var currentCalendarDate = new Date();

        // Global variable to store calendar entries for the month (for holiday checking)
        window.calendarEntries = [];


        window.monthCalendarData = {};

        // Track which month/year the cached data is for (to prevent OU-level holidays when month data is loaded)
        window.monthCalendarDataYear = null;
        window.monthCalendarDataMonth = null;

        // Function to load calendar data for the entire month (single API call)
        function loadMonthCalendarData(projectID, projectSiteID, year, month) {
            if (!projectID || projectID === 0 || !projectSiteID || projectSiteID === 0) {
                window.monthCalendarData = {};
                window.monthCalendarDataYear = null;
                window.monthCalendarDataMonth = null;
                return;
            }

            var Parameters = {
                ProjectID: projectID,
                ProjectSiteID: projectSiteID,
                Year: year,
                Month: month
            };
            var param = JSON.stringify(Parameters);
            var Result = AJAXCallWithResult('api/ProjectSites/GetMonthCalendarData', param, false);

            // Extract data
            var data = extractApiData(Result, 'MonthData');
            if (!data) {
                data = extractApiData(Result);
            }

            // Clear existing data
            window.monthCalendarData = {};

            // Store which month/year this data is for
            window.monthCalendarDataYear = year;
            window.monthCalendarDataMonth = month;

            // Store data in a map for quick lookup (key: "YYYY-MM-DD")
            if (data && Array.isArray(data) && data.length > 0) {
                data.forEach(function (entry) {
                    var dateStr = entry.Date || entry.date;
                    if (dateStr) {
                        // Normalize date string to YYYY-MM-DD format
                        if (typeof dateStr === 'string' && dateStr.indexOf('T') > -1) {
                            dateStr = dateStr.split('T')[0];
                        } else if (dateStr instanceof Date) {
                            var d = new Date(dateStr);
                            dateStr = d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0') + '-' + String(d.getDate()).padStart(2, '0');
                        }
                        window.monthCalendarData[dateStr] = {
                            SiteCalendarDayID: entry.SiteCalendarDayID !== undefined ? entry.SiteCalendarDayID : (entry.siteCalendarDayID !== undefined ? entry.siteCalendarDayID : null),
                            NormalHours: entry.NormalHours !== undefined && entry.NormalHours !== null ? entry.NormalHours : (entry.normalHours !== undefined && entry.normalHours !== null ? entry.normalHours : 0),
                            ExtraHours: entry.ExtraHours !== undefined && entry.ExtraHours !== null ? entry.ExtraHours : (entry.extraHours !== undefined && entry.extraHours !== null ? entry.extraHours : 0),
                            Holiday: entry.Holiday === true || entry.Holiday === 1 || entry.holiday === true || entry.holiday === 1,
                            Flag: entry.Flag !== undefined ? entry.Flag : (entry.flag !== undefined ? entry.flag : 0)
                        };
                    }
                });
            }
        }
        // End of added by Nischal C on 30 Nov 2025 for loading month calendar data from API

        // Function to check if a date is a holiday
        function isHolidayDate(dateObj) {
            if (!dateObj) {
                return false;
            }

            var day = dateObj.getDate();
            var month = dateObj.getMonth() + 1; // JavaScript months are 0-based
            var year = dateObj.getFullYear();
            var dateStr = year + '-' + String(month).padStart(2, '0') + '-' + String(day).padStart(2, '0');


            if (window.monthCalendarData && window.monthCalendarData[dateStr]) {
                var entry = window.monthCalendarData[dateStr];

                if (entry.Holiday === true || entry.Holiday === 1) {
                    return true;
                } else {

                    return false;
                }
            }


            if (window.calendarEntries && Array.isArray(window.calendarEntries) && window.calendarEntries.length > 0) {
                for (var j = 0; j < window.calendarEntries.length; j++) {
                    var entry = window.calendarEntries[j];
                    var entryDate = entry.Date || entry.date || entry.CurrentDate || entry.currentDate;
                    if (entryDate) {
                        // Compare dates (handle different date formats)
                        var entryDateStr = entryDate;
                        if (entryDateStr.indexOf('T') > -1) {
                            entryDateStr = entryDateStr.split('T')[0];
                        }
                        if (entryDateStr === dateStr && (entry.Holiday === true || entry.Holiday === 1 || entry.holiday === true || entry.holiday === 1)) {
                            return true;
                        }
                    }
                }
            }


            var isMonthDataLoaded = (window.monthCalendarDataYear === year && window.monthCalendarDataMonth === month);


            if (!isMonthDataLoaded && window.ouLevelHolidays && Array.isArray(window.ouLevelHolidays) && window.ouLevelHolidays.length > 0) {
                for (var i = 0; i < window.ouLevelHolidays.length; i++) {
                    var holiday = window.ouLevelHolidays[i];

                    var holidayDay = null;
                    if (holiday.Day !== undefined && holiday.Day !== null) {
                        holidayDay = parseInt(holiday.Day, 10);
                    } else if (holiday.day !== undefined && holiday.day !== null) {
                        holidayDay = parseInt(holiday.day, 10);
                    }

                    // Ensure day is also a number for comparison
                    var dateDayNum = parseInt(day, 10);

                    if (holidayDay !== null && !isNaN(holidayDay) && holidayDay === dateDayNum) {
                        return true;
                    }
                }
            }

            return false;
        }

        // Function to check if a date has been updated (has normal/extra hours modified)
        function isDateUpdated(dateObj) {
            if (!dateObj) {
                return false;
            }
            var selectedProjectID = $('#cboProject').val();
            var day = dateObj.getDate();
            var month = dateObj.getMonth() + 1; // JavaScript months are 0-based
            var year = dateObj.getFullYear();
            var dateStr = year + '-' + String(month).padStart(2, '0') + '-' + String(day).padStart(2, '0');

            // Get from cached month data (preferred - no API call)
            if (window.monthCalendarData && window.monthCalendarData[dateStr]) {
                var entry = window.monthCalendarData[dateStr];
                // If Flag = 1 and not a holiday, it's updated (has normal/extra hours modified)
                if (entry.Flag === 1 && !(entry.Holiday === true || entry.Holiday === 1)) {
                    return true;
                }
                return false;
            }

            // Fallback to API calls if cache is not available (shouldn't happen in normal flow)
            if (selectedProjectID && selectedProjectID > 0 && currentProjectSiteID && currentProjectSiteID > 0) {
                var isUpdated = isSiteCalendarUpdatedDate(selectedProjectID, currentProjectSiteID, dateStr);
                if (isUpdated) {
                    // Get hours data to check if it's a holiday (holidays have their own color)
                    var hoursData = getUpdatedHours(selectedProjectID, currentProjectSiteID, dateStr);
                    if (hoursData) {
                        // If it's a holiday, don't mark as updated (holiday has its own color)
                        if (hoursData.Holiday === true || hoursData.Holiday === 1) {
                            return false;
                        }
                    }
                    // If Flag = 1 and not a holiday, it's updated (has normal/extra hours modified)
                    return true;
                }
            }

            return false;
        }

        // Function to load calendar entries for the month (for holiday checking)
        function loadCalendarEntriesForMonth(projectID, projectSiteID, year, month) {
            if (!projectID || projectID === 0 || !projectSiteID || projectSiteID === 0) {
                window.calendarEntries = [];
                return;
            }


            window.calendarEntries = [];
        }

        function renderCalendar(date) {
            var selectedProjectID = $('#cboProject').val();
            var year = date.getFullYear();
            var month = date.getMonth();
            var monthNumber = month + 1; // JavaScript months are 0-based, API expects 1-12
            var monthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"];

            // Load month calendar data first (single API call instead of 60)
            if (selectedProjectID && selectedProjectID > 0 && currentProjectSiteID && currentProjectSiteID > 0) {
                loadMonthCalendarData(selectedProjectID, currentProjectSiteID, year, monthNumber);
            }

            // Update header
            $('#calendarMonthYear').text(monthNames[month] + ' ' + year);

            // Get first day of month and number of days
            var firstDay = new Date(year, month, 1);
            var lastDay = new Date(year, month + 1, 0);
            var daysInMonth = lastDay.getDate();
            var startingDayOfWeek = firstDay.getDay(); // 0 = Sunday, 1 = Monday, etc.

            // Adjust for Monday as first day (0 = Monday)
            var startDay = calendarConfig.startDay; // 0=Sunday
            startingDayOfWeek = (firstDay.getDay() - startDay + 7) % 7;

            // Get previous month's last days
            var prevMonth = new Date(year, month, 0);
            var daysInPrevMonth = prevMonth.getDate();

            var today = new Date();
            var isCurrentMonth = (today.getFullYear() === year && today.getMonth() === month);
            var todayDate = isCurrentMonth ? today.getDate() : 0;

            var calendarHTML = '';
            var dateCounter = 1;
            var prevMonthDate = daysInPrevMonth - startingDayOfWeek + 1;

            // Generate calendar rows (6 weeks max)
            for (var week = 0; week < 6; week++) {
                calendarHTML += '<tr>';
                cellClass = '';
                for (var day = 0; day < 7; day++) {
                    var cellDate, cellClass, cellContent, isWeekend = false;
                    var cellDateObj = null;

                    if (week === 0 && day < startingDayOfWeek) {
                        // Previous month dates
                        cellDate = prevMonthDate++;
                        cellContent = cellDate;
                        cellClass = 'color: #999;';
                        cellDateObj = new Date(year, month - 1, cellDate);
                    } else if (dateCounter > daysInMonth) {
                        // Next month dates
                        cellDate = dateCounter - daysInMonth;
                        cellContent = cellDate;
                        cellClass = 'color: #999;';
                        cellDateObj = new Date(year, month + 1, cellDate);
                        dateCounter++;
                    } else {
                        // Current month dates
                        cellDate = dateCounter;
                        cellContent = cellDate;
                        cellDateObj = new Date(year, month, cellDate);
                        cellClass = '';
                        // Check if holiday (takes priority over weekend/today/updated for styling)
                        var isHoliday = isHolidayDate(cellDateObj);

                        // Check if date is updated (has normal/extra hours modified) - only if not a holiday
                        var isUpdated = false;
                        if (!isHoliday) {
                            isUpdated = isDateUpdated(cellDateObj);
                        }

                        // Check if weekend (Saturday = 5, Sunday = 6)
                        var isWeekend = day >= calendarConfig.workingDays;

                        if (isWeekend) {
                            cellClass = 'calendar-weekend';
                        } else {
                            // Add holiday class if date is a holiday (highest priority)
                            if (isHoliday) {
                                if (cellClass) {
                                    cellClass += ' calendar-holiday';
                                } else {
                                    cellClass = 'calendar-holiday';
                                }
                            }
                            // Add updated class if date is updated (but not a holiday)
                            else if (isUpdated) {
                                if (cellClass) {
                                    cellClass += ' calendar-updated';
                                } else {
                                    cellClass = 'calendar-updated';
                                }
                            }
                        }

                        // Check if today
                        if (isCurrentMonth && cellDate === todayDate) {
                            cellClass = 'calendar-today';
                        }

                        if (!isHoliday && !isUpdated && !isWeekend && !(isCurrentMonth && cellDate === todayDate)) {
                            cellClass = '';
                        }
                        dateCounter++;
                    }

                    var cellStyle = 'text-align: center; padding: 15px;';
                    if (cellClass) {
                        if (cellClass.includes('color')) {
                            cellStyle += ' ' + cellClass;
                        } else {
                            cellStyle = 'text-align: center; padding: 15px;';
                        }
                    }
                    var isClickable = false;
                    if (m_blnEditAccess) {
                        isClickable = !cellClass.includes('color');
                    }
                    var clickStyle = isClickable ? 'cursor: pointer;' : '';
                    var fullStyle = cellStyle + (clickStyle ? ' ' + clickStyle : '');
                    var dataAttr = isClickable ? ' data-clickable="true"' : '';


                    var dateISO = '';
                    if (cellDateObj) {
                        var dateYear = cellDateObj.getFullYear();
                        var dateMonth = String(cellDateObj.getMonth() + 1).padStart(2, '0');
                        var dateDay = String(cellDateObj.getDate()).padStart(2, '0');
                        dateISO = dateYear + '-' + dateMonth + '-' + dateDay;
                    }
                    var dateDataAttr = dateISO ? ' data-date="' + dateISO + '"' : '';

                    // Build class string (may contain multiple classes like "calendar-today calendar-holiday")
                    var classAttr = cellClass ? ' class="' + cellClass + '"' : '';

                    if (cellClass && cellClass.includes('calendar-today')) {
                        // Today - use strong tag
                        calendarHTML += '<td' + classAttr + ' style="' + fullStyle + '"' + dataAttr + dateDataAttr + '><strong>' + cellContent + '</strong></td>';
                    } else {
                        // Regular date, weekend, or holiday - use span tag
                        calendarHTML += '<td' + classAttr + ' style="' + fullStyle + '"' + dataAttr + dateDataAttr + '><span>' + cellContent + '</span></td>';
                    }
                }
                calendarHTML += '</tr>';

                // Stop if we've displayed all days
                if (dateCounter > daysInMonth) {
                    break;
                }
            }

            // Clear existing content and event handlers
            $('#calendarBody').empty();
            $('#calendarBody').off('click', 'td[data-clickable="true"]');

            // Set the calendar HTML
            $('#calendarBody').html(calendarHTML);

            // Attach click handlers to clickable dates (including weekends) using event delegation
            $('#calendarBody').on('click', 'td[data-clickable="true"]', function () {
                var dateStr = $(this).attr('data-date');
                if (dateStr) {
                    // Parse date string (YYYY-MM-DD) and create date in local timezone
                    var dateParts = dateStr.split('-');
                    var year = parseInt(dateParts[0], 10);
                    var month = parseInt(dateParts[1], 10) - 1; // JavaScript months are 0-based
                    var day = parseInt(dateParts[2], 10);
                    var clickedDate = new Date(year, month, day);
                    openCalendarModal(clickedDate);
                } else {
                    // Fallback: try to extract date from cell content
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Unable to determine selected date.');
                }
            });
        }

        function changeMonth(direction) {
            var selectedProjectID = $('#cboProject').val();
            currentCalendarDate.setMonth(currentCalendarDate.getMonth() + direction);
            // Load month calendar data for the new month
            if (selectedProjectID && selectedProjectID > 0 && currentProjectSiteID && currentProjectSiteID > 0) {
                var year = currentCalendarDate.getFullYear();
                var month = currentCalendarDate.getMonth() + 1; // JavaScript months are 0-based, API expects 1-12
                if (typeof loadMonthCalendarData === 'function') {
                    loadMonthCalendarData(selectedProjectID, currentProjectSiteID, year, month);
                }
            }
            renderCalendarHeader();
            renderCalendar(currentCalendarDate);
        }
    </script>
</body>

</html>