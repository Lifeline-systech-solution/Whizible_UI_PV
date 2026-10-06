<%@ Page Language="vb" AutoEventWireup="false" CodeFile="PM_QuantitativeObjectives_New.aspx.vb" Inherits="Whizible.PM_QuantitativeObjectives_New" meta:resourcekey="PageResource1" Culture="auto" UICulture="auto" %>

<!DOCTYPE html>

<html>
<head>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("C_PageTitle"))%>
    <!-- Override/ensure correct viewport to avoid console warnings -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <!-- Exact UI/CSS/Font stack aligned to Training Plan reference -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <!-- Removed bootstrap-select CSS to prevent auto-initialization -->
        
        <!-- Custom Alertify Styling -->
        <style>
            #cboProject { min-width: 220px; }
            /* Ensure Alertify toasts appear above Bootstrap modals/backdrops */
            .alertify-notifier, .alertify-notifier .ajs-message { z-index: 200000 !important; }
        </style>
    
    <style type="text/css">
        /* Header, search, actions, table, pagination - aligned to reference */
        body { background:#f5f5f5; font-family: Roboto, sans-serif; }
        .main-container { padding:0; background:#f5f5f5; min-height:100vh; }
        .page-header { background:#fff; padding:15px 20px; margin-bottom:0; display:block; border-bottom:1px solid #dee2e6; }
        .title-row { display:flex; align-items:center; gap:10px; }
        .header-icon { display:flex; align-items:center; justify-content:center; color:#1e40af; font-size:1.5rem; margin-right:0; }
        .page-title { color:#1e40af; font-size:18px; font-weight:600; margin:0; line-height:1.2; }
        .page-subtitle { color:#6c757d; font-size:13px; margin:6px 0 0 0; }
        .search-section { background:rgb(231, 237, 240); padding:8px 20px; display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #e9ecef; }
        .project-select { display:flex; align-items:center; gap:8px; }
        .project-select label { font-size:0.875rem; color:#2c3e50; font-weight:500; margin:0; }
        /* Dropdown styling override to match Training Plan look (CSS-only) */
        .project-select select, #cboProject {
            min-width: 200px;
            width: 230px;
            height: 2rem;
            line-height: 1.25rem;
            padding: 0.375rem 1.75rem 0.375rem 0.75rem; /* space for arrow */
            border: 1px solid #d1d5db;
            border-radius: 0.25rem;
            background-color: #fff;
            color: #374151;
            font-size: 11.5px;
            font-weight: 400;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-image: url("../../Images/Whizible2.0-new/dropdown-arrow.png");
            background-repeat: no-repeat;
            background-position: calc(100% - 10px) 50%;
            background-size: 10px auto;
        }
        .project-select select:focus,
        #cboProject:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59,130,246,.1);
            background: #fff;
        }
        .project-select select:hover,
        #cboProject:hover {
            border-color: #9ca3af;
            box-shadow: 0 1px 3px rgba(0,0,0,0.12);
        }
        .search-container { display:flex; align-items:center; gap:10px; }
        .search-wrapper {
            display: flex;
            justify-content: end;
            gap: 10px;
        }
        
        /* Hide scrollbars but keep scrolling functionality */
        * {
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* Internet Explorer 10+ */
        }
        *::-webkit-scrollbar {
            display: none; /* WebKit browsers (Chrome, Safari, Edge) */
        }
        
        /* Hide table scrollbars specifically */
        table, .table, .table-responsive, .dataTables_scrollBody, .dataTables_scroll,
        .dataTables_wrapper, .dataTables_scrollHead, .dataTables_scrollFoot,
        .table-container, .scroll-container, .content, .main-content,
        div[style*="overflow"], div[style*="scroll"] {
            scrollbar-width: none !important; /* Firefox */
            -ms-overflow-style: none !important; /* Internet Explorer 10+ */
        }
        table::-webkit-scrollbar, .table::-webkit-scrollbar, .table-responsive::-webkit-scrollbar, 
        .dataTables_scrollBody::-webkit-scrollbar, .dataTables_scroll::-webkit-scrollbar,
        .dataTables_wrapper::-webkit-scrollbar, .dataTables_scrollHead::-webkit-scrollbar, 
        .dataTables_scrollFoot::-webkit-scrollbar, .table-container::-webkit-scrollbar,
        .scroll-container::-webkit-scrollbar, .content::-webkit-scrollbar, .main-content::-webkit-scrollbar,
        div[style*="overflow"]::-webkit-scrollbar, div[style*="scroll"]::-webkit-scrollbar {
            display: none !important; /* WebKit browsers */
        }
        
        /* Force hide all scrollbars on any element with overflow */
        *[style*="overflow:auto"], *[style*="overflow:scroll"], *[style*="overflow-x"], *[style*="overflow-y"] {
            scrollbar-width: none !important;
            -ms-overflow-style: none !important;
        }
        *[style*="overflow:auto"]::-webkit-scrollbar, *[style*="overflow:scroll"]::-webkit-scrollbar,
        *[style*="overflow-x"]::-webkit-scrollbar, *[style*="overflow-y"]::-webkit-scrollbar {
            display: none !important;
        }
        
        /* Target specific table classes in this page */
        .add-grid, .metrics-table, .objectives-table, .table-scroll-container, .metrics-table-container {
            scrollbar-width: none !important;
            -ms-overflow-style: none !important;
        }
        .add-grid::-webkit-scrollbar, .metrics-table::-webkit-scrollbar, .objectives-table::-webkit-scrollbar,
        .table-scroll-container::-webkit-scrollbar, .metrics-table-container::-webkit-scrollbar {
            display: none !important;
        }
        
        /* Universal scrollbar hiding - most aggressive approach */
        html, body, div, table, tbody, thead, tr, td, th {
            scrollbar-width: none !important;
            -ms-overflow-style: none !important;
        }
        html::-webkit-scrollbar, body::-webkit-scrollbar, div::-webkit-scrollbar, 
        table::-webkit-scrollbar, tbody::-webkit-scrollbar, thead::-webkit-scrollbar,
        tr::-webkit-scrollbar, td::-webkit-scrollbar, th::-webkit-scrollbar {
            display: none !important;
        }
        .search-input { padding:6px 10px; border:3px solid #dee2e6; border-radius:4px; width:230px; height:35px; font-size:12px; font-weight:400; background:#fff; }
        .search-input::placeholder { font-weight:400; }
        .search-input::-webkit-input-placeholder { font-weight:400; }
        .search-input::-moz-placeholder { font-weight:400; }
        .search-input:focus { outline:none; border:3px solid #dee2e6; }
        .search-icon { color:#6c757d; font-size:16px; }
        .save-button-container { display:flex; align-items:center; gap: 10px; }
        .btn-save-targets { background:#f6a637; color:#fff; border:1px solid #f6a637; padding:8px 16px; border-radius:6px; font-size:13px; font-weight:600; cursor:pointer; display:flex; align-items:center; gap:6px; transition:all 0.2s ease; }
        .btn-save-targets:hover { background:#e9961f; border-color:#e9961f; transform:translateY(-1px); box-shadow:0 2px 6px rgba(0,0,0,0.12); }
        .btn-save-targets:active { transform:none; box-shadow:0 1px 2px rgba(0,0,0,0.08); }
        .btn-save-targets i { font-size:12px; }
        /* Match Training Plans: white header strip for section titles */
        .action-bar { 
            background:#fff; 
            padding:17px 20px; 
            margin:0; 
            display:flex; 
            align-items:center; 
            border-bottom:1px solid #e9ecef; 
            border-radius:8px 8px 0 0;
            transition: all 0.3s ease;
        }
        .button-group { display:flex; align-items:center; width:100%; }
        /* Match backup: dark text, normal weight, 16px size, plus icon only */
        .btn-new-hardware {
            
            font-size: 15px;
            font-weight: 600;
        }
        .btn-new-hardware .text-group { display:flex; align-items:center; gap:8px; color:#495057; }
        .btn-new-hardware .text-group i { color:#495057; }
        .btn-new-hardware .dropdownIcon { display:none; }
        .btn-new-hardware.expanded .dropdownIcon { display:none; }
        .new-hardware-form { 
            background:#fff; 
            margin:0; 
            box-shadow:0 1px 3px rgba(0,0,0,0.1); 
            overflow:visible; 
            border:1px solid #e9ecef;
            border-top:none;
        }
        .section-headers {
            background:#fff;
            border:1px solid #e9ecef;
            border-radius:8px;
            margin-bottom:0;
            overflow:hidden;
        }
        .section-headers .action-bar {
            border-bottom:none;
            border-radius:8px 8px 0 0;
        }
        .section-headers + .new-hardware-form {
            margin-top:-1px;
            border-top:1px solid #e9ecef;
            border-radius:0 0 8px 8px;
        }
        .form-container { padding:20px; }
        .form-header { margin-bottom:20px; padding-bottom:10px; border-bottom:1px solid #e9ecef; }
        .form-header h3 { color:#2c3e50; font-size:18px; font-weight:400; margin:0; }
        .subtle { color:#6c757d; font-size:12px; }
        .form-grid { display:grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap:20px; }
        .form-group { margin-bottom:0; }
        .form-group label { display:block; margin-bottom:3px; font-weight:600; color:#2c3e50; font-size:13px; }
        .form-group label.required::after { content:" *"; color:#dc3545; }
        .form-actions-inline { display:flex; justify-content:flex-end; gap:10px; margin-top:20px; padding-top:20px; border-top:1px solid #e9ecef; }
        .content-area { background:#fff; margin:0 20px 20px 20px; border-radius:8px; box-shadow:0 2px 4px rgba(0,0,0,.1); overflow:hidden; }
        .hardware-table-container { overflow-x:auto; }
        .objectives-table { width:100%; border-collapse:collapse; font-size:14px; }
        .objectives-table { width:100%; border-collapse:collapse; }
        .objectives-table thead th { 
            background:#e7edf0; /* light blue strip like reference */
            color:#495057; 
            padding:12px; 
            text-align:left; 
            font-weight:600; 
            border-bottom:1px solid #e9ecef;
        }
        .objectives-table tbody td { 
            padding:12px; 
            vertical-align:middle; 
            border-bottom:1px solid #e9ecef; 
            color:#000 !important;
        }
        .objectives-table tbody tr:last-child td { border-bottom:none; }

        /* Match Training Plans table visuals exactly */
        .table.newTblStyle {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
        }
        .table.newTblStyle thead th {
            background: #e7edf0; /* same grey-blue strip */
            color: #495057;
            font-weight: 600;
            padding-top: 13px;
            padding-bottom: 12px;
            padding-left: .5rem;
            padding-right: .5rem;
            border-bottom: 1px solid #e9ecef;
            text-align: left;
        }
        .table.newTblStyle tbody td {
            background: #fff;
            color: #000 !important; /* enforce black text */
            padding: .5rem .5rem;
            border-bottom: 1px solid #e9ecef;
        }
        .table.newTblStyle tbody tr { height: 40px; }

        /* Ensure no rounded corners anywhere on tables */
        .table, .table thead th, .table tbody td, .table thead, .table tbody,
        .objectives-table, .objectives-table thead th, .objectives-table tbody td {
            border-radius: 0 !important;
        }
        .table, .dataTable, .table.newTblStyle, .objectives-table {
            box-shadow: none !important;
            border: none !important;
            background: #fff;
        }
        .table.newTblStyle tbody tr:last-child td { border-bottom: none; }
        .objectives-table tbody tr:hover { background:#f8f9fa; }
        .target-cell { display:flex; align-items:center; gap:8px; }
        .target-input { width:120px; max-width:140px; padding:6px 8px; font-size:13px; }
        .pagination-container { 
            display:flex; 
            justify-content:flex-end; 
            align-items:center; 
            margin:15px 20px 20px 20px; 
            padding:8px 0;
            gap:12px;
        }
        .pagination-total { 
            color:#6c757d; 
            font-size:13px; 
            font-weight:400;
        }
        .pager-buttons { 
            display:flex; 
            align-items:center; 
            gap:8px; 
        }
        .pager-btn { 
            width:40px; 
            height:32px; 
            background:#ffffff; 
            color:#3b82f6; 
            border:1px solid #d1d5db; 
            border-radius:6px; 
            cursor:pointer; 
            font-size:14px; 
            display:flex;
            align-items:center;
            justify-content:center;
            transition:all 0.2s ease;
            font-weight:500;
            box-shadow:0 1px 2px rgba(0,0,0,0.05);
        }
        .pager-btn:hover:not(:disabled) { 
            background:#f8fafc; 
            border-color:#3b82f6; 
            box-shadow:0 2px 4px rgba(0,0,0,0.1);
        }
        .pager-btn:disabled { 
            color:#d1d5db; 
            border-color:#d1d5db; 
            cursor:not-allowed; 
            background:#ffffff;
        }
        .loading { padding:30px; text-align:center; color:#007bff; }
        @media (max-width: 768px) { .search-input { width: 100%; } }
        .btn-primary-save { background:#4263c1; color:#fff; border:none; padding:8px 14px; border-radius:4px; font-size:13px; cursor:pointer; }
        .btn-primary-save:hover { filter:brightness(0.95); }
        
        
        .btn.btn-primary { background: #1359a6; color:#fff; border:none; padding:8px 16px; border-radius:6px; font-size:13px; font-weight:600; box-shadow:0 1px 2px rgba(0,0,0,0.08); transition:all .2s ease; }
        .btn.btn-primary:hover { filter:brightness(0.96); transform:translateY(-1px); box-shadow:0 2px 6px rgba(0,0,0,0.12); }
        .btn.btn-primary:active { transform:none; box-shadow:0 1px 2px rgba(0,0,0,0.08); }
        
        .borderbtn, .btn.btn-secondary {
            background: #ffffff !important;
            color: #3b82f6 !important;
            border: 1px solid #3b82f6 !important;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
        }
        .borderbtn:hover, .btn.btn-secondary:hover { 
            background: #f8fafc; 
            border-color: #2563eb; 
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .borderbtn:active, .btn.btn-secondary:active { 
            background: #f1f5f9; 
            transform: translateY(1px);
        }
        /* Add New enhanced table */
        .add-toolbar { display:flex; align-items:center; justify-content:space-between; margin:0 0 10px 0; }
        .add-toolbar .links a { color:#4263c1; text-decoration:none; margin-left:12px; font-size:13px; }
        .add-toolbar .links a:hover { text-decoration:underline; }
        .add-search-container { display:flex; align-items:center; gap:12px; }
        .add-search { display:flex; align-items:center; gap:8px; }
        .add-search input { padding:6px 10px; border:1px solid #ced4da; border-radius:6px; font-size:13px; min-width:240px; font-weight:400; }
        .add-search input::placeholder { font-weight:400; }
        .add-search input::-webkit-input-placeholder { font-weight:400; }
        .add-search input::-moz-placeholder { font-weight:400; }
        .add-save-button { display:flex; align-items:center; }
        .add-save-button .btn-primary-save:disabled { opacity:0.7; cursor:not-allowed; }
        .fa-spin { animation: fa-spin 1s infinite linear; }
        @keyframes fa-spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .add-grid { width:100%; border-collapse:collapse; border: none !important; }
        .add-grid td, .add-grid th { border: none !important; }
        .add-grid tr { border: none !important; }
        .add-grid tbody tr { border: none !important; }
        .add-grid tbody td { border: none !important; }
        .add-grid tbody tr td { border: none !important; }
        .add-grid thead tr th { border: none !important; }
        .add-grid tbody tr td, .add-grid tbody tr th { border: none !important; }
        
        /* Add New Metrics Pagination */
        .add-new-pagination-container { display:flex; justify-content:flex-end; align-items:center; margin:10px 0; gap:8px; }
        .add-new-pagination-total { color:#6c757d; font-size:12px; margin-right:12px; }
        .add-new-pager-buttons { display:flex; align-items:center; gap:8px; }
        .add-new-pager-btn { 
            width:40px; 
            height:32px; 
            background:#ffffff; 
            color:#3b82f6; 
            border:1px solid #d1d5db; 
            border-radius:6px; 
            cursor:pointer; 
            font-size:14px; 
            display:flex;
            align-items:center;
            justify-content:center;
            transition:all 0.2s ease;
            font-weight:500;
            box-shadow:0 1px 2px rgba(0,0,0,0.05);
        }
        .add-new-pager-btn:hover:not(:disabled) { 
            background:#f8fafc; 
            border-color:#3b82f6; 
            box-shadow:0 2px 4px rgba(0,0,0,0.1);
        }
        .add-new-pager-btn:disabled { 
            color:#d1d5db; 
            border-color:#d1d5db; 
            cursor:not-allowed; 
            background:#ffffff;
        }
        .add-grid thead th { background:#f8fafc; color:#2c3e50; font-weight:600; padding:10px; position:sticky; top:0; z-index:1; }
        .add-grid tbody tr:nth-child(odd) { background:#fcfdff; }
        .add-grid tbody td { padding:10px; }
        .add-grid .chkbox { display:flex; align-items:center; justify-content:center; }
        
        

        
        /* Group Add New and Strategy headers together on white background */
        .section-headers { background:#fff; }
        .section-headers .action-bar { background:#fff; padding:7px 20px; margin:0; border-bottom:none; }
        .section-headers .headers-divider { height:1px; background:#e9ecef; margin:4px 20px; }
        /* Ensure Add New and Strategy rows have identical visual size */
        .btn-new-hardware { font-size:15px; font-weight:600; }
        .btn-new-hardware .text-group { display:flex; align-items:center; gap:8px; line-height:24px; padding:0; }
        .btn-new-hardware .text-group i { font-size:14px; }
        
        /* Add Metric Interface Styles */
        .add-metric-container {
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .add-metric-header {
            margin-bottom: 20px;
            text-align: center;
        }
        
        .add-metric-header h2 {
            color: #4263c1;
            font-size: 24px;
            margin: 0;
        }
        
        .metrics-search {
            margin-bottom: 15px;
        }
        
        .metrics-table-container {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .metrics-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .metrics-table th {
            background-color: #f8f9fa;
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-weight: 600;
        }
        
        .metrics-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }
        
        .metrics-table tr:hover {
            background-color: #f5f5f5;
        }
        
        .add-metric-actions {
            margin-top: 20px;
            text-align: right;
        }
        
        .add-metric-actions button {
            margin-left: 10px;
        }
        
        /* Hierarchical table styles */
        .category-header {
            background: #f8f9fa !important;
            font-weight: 600;
            color: #2c3e50;
            border-bottom: 2px solid #dee2e6;
        }
        
        .category-header td {
            padding: 12px 16px !important;
            font-size: 14px;
        }
        
        .metric-row-even {
            background: #ffffff;
        }
        
        .metric-row-odd {
            background: #f8f9fa;
        }
        
        .objectives-table tbody tr.metric-row-even td,
        .objectives-table tbody tr.metric-row-odd td {
            padding: .5rem .5rem;
        }
        
        .objectives-table tbody tr.metric-row-even td:first-child,
        .objectives-table tbody tr.metric-row-odd td:first-child {
            padding-left: 30px;
            color: #495057;
            font-size: 13px;
        }
        
        /* Table scrollbar styles */
        .table-scroll-container {
            max-height: 500px;
            overflow-y: auto;
            overflow-x: hidden;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            margin: 0 20px 20px 20px;
            background: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        
        .table-scroll-container::-webkit-scrollbar {
            width: 8px;
        }
        
        .table-scroll-container::-webkit-scrollbar-track {
            background: transparent;
        }
        
        .table-scroll-container::-webkit-scrollbar-thumb {
            background: transparent;
            border-radius: 4px;
            transition: background 0.3s ease;
        }
        
        .table-scroll-container:hover::-webkit-scrollbar-thumb {
            background: #c1c1c1;
        }
        
        .table-scroll-container:hover::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }
        
        /* Firefox scrollbar */
        .table-scroll-container {
            scrollbar-width: thin;
            scrollbar-color: transparent transparent;
        }
        
        .table-scroll-container:hover {
            scrollbar-color: #c1c1c1 transparent;
        }
        
        /* Strategy word counter */
        #strategyWordCount {
            font-weight: 600;
            color: #4263c1;
            font-size: 13px;
        }
        
        /* Save with Revision Modal - Optimized */
        #saveRevisionModal .modal-content {
            border: none;
            border-radius: 10px;
            box-shadow: 0 8px 30px rgba(0,0,0,.12);
            overflow: hidden;
        }
        #saveRevisionModal .modal-header {
            background: linear-gradient(135deg,#4263c1,#3a5bb8);
            border: none;
            padding: 16px 20px;
        }
        #saveRevisionModal .modal-title {
            color: #fff;
            font: 600 14px/1 sans-serif;
            /* Modified By Madhuri.K On 01-04-2026 */
            display: flex;
            align-items: center;
            gap: 8px;
        }
        #saveRevisionModal .modal-title::before,
        #saveRevisionModal .form-label::before,
        #saveRevisionModal .form-text::before {
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
        }
        #saveRevisionModal .modal-title::before {
            content: '\f044';
            font-size: 14px;
            /* Modified By Madhuri.K On 01-04-2026 */
            color: #fff;
            opacity: .9;
        }
        #saveRevisionModal .btn-close {
            filter: brightness(0) invert(1);
            opacity: .8;
        }
        #saveRevisionModal .btn-close:hover { opacity: 1; }
        #saveRevisionModal .modal-body {
            padding: 20px;
            background: #fff;
        }
        #saveRevisionModal .form-group { margin: 0; }
        #saveRevisionModal .form-label {
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        #saveRevisionModal .form-label::before {
            content: '\f303';
            color: #4263c1;
            font-size: 13px;
            /* Modified By Madhuri.K On 01-04-2026 */
        }
        #saveRevisionModal textarea {
            border: 2px solid #e9ecef;
            border-radius: 6px;
            font-size: 13px;
            padding: 10px 12px;
            transition: all .3s;
            line-height: 1.5;
        }
        #saveRevisionModal textarea:focus {
            border-color: #4263c1;
            box-shadow: 0 0 0 4px rgba(66,99,193,.1);
            outline: none;
        }
        #saveRevisionModal textarea::placeholder { color: #adb5bd; }
        #saveRevisionModal .form-text {
            margin-top: 8px;
            font-size: 12px;
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        #saveRevisionModal .form-text::before {
            content: '\f05a';
            color: #6c757d;
            font-size: 11px;
            /* Modified By Madhuri.K On 01-04-2026 */
        }
        #saveRevisionModal #revisionCharCount {
            font-weight: 600;
            color: #4263c1;
            /* Modified By Madhuri.K On 01-04-2026 */
        }
        #saveRevisionModal .modal-footer {
            background: #f8f9fc;
            border-top: 1px solid #e9ecef;
            padding: 14px 20px;
            display: flex;
            gap: 8px;
        }
        #saveRevisionModal .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font: 600 13px/1 sans-serif;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all .3s;
            border: none;
        }
        #saveRevisionModal .btn i { font-size: 12px; }
        #saveRevisionModal .btn-secondary {
            background: #6c757d;
            color: #fff;
        }
        #saveRevisionModal .btn-secondary:hover,
        #saveRevisionModal .btn-primary:hover {
            transform: translateY(-1px);
        }
        #saveRevisionModal .btn-secondary:hover {
            background: #5a6268;
            box-shadow: 0 4px 8px rgba(108,117,125,.2);
        }
        #saveRevisionModal .btn-primary {
            background: linear-gradient(135deg,#4263c1,#3a5bb8);
            color: #fff;
        }
        #saveRevisionModal .btn-primary:hover {
            background: linear-gradient(135deg,#3a5bb8,#32509f);
            box-shadow: 0 4px 12px rgba(66,99,193,.3);
        }
        #saveRevisionModal .btn-primary:active { transform: translateY(0); }
        #saveRevisionModal.fade .modal-dialog { transition: transform .3s ease-out; }
        #saveRevisionModal.show .modal-dialog { transform: scale(1); }
    </style>
</head>

<body>
    <%--<form id="frmQuantativeObjectives" runat="server">--%>
        <%If m_blnViewAccess = True Then%>
        <div class="main-container">
            <!-- Page Header -->
            <div class="page-header">
                <div class="title-row">
                    <div class="header-icon" aria-hidden="true"><i class="fas fa-graduation-cap"></i></div>
                    <h1 class="page-title"><%=MyBase.GetResourceString("C_PageTitle")%></h1>
                </div>
                    <p class="page-subtitle"><%=MyBase.GetResourceString("C_PageSubtitle")%></p>
            </div>

            <!-- Search Section -->
            <div class="search-section">
                <!-- Left Side - Project Dropdown -->
                <div style="display: flex; align-items: center; gap: 0.5rem;">
                    <label style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0;"><%=MyBase.GetResourceString("C_SelectProject")%></label>
                    <div style="min-width: 200px;">
                        <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,,) %>
                    </div>
                </div>
                <div class="search-wrapper">
                    <div class="search-container">
                        <div style="display: flex; align-items: center; background: white; border-radius: 0.25rem; border: 1px solid #d1d5db; overflow: hidden; height: 2rem; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
                            <input type="text" id="searchObjective" placeholder="<%=MyBase.GetResourceString("C_SearchObjectivesPlaceholder")%>" oninput="handleSearchInput()" style="border: none; outline: none; padding: 0.25rem 0.5rem; flex: 1; background: transparent; height: 100%; font-size: 11.5px;">
                            <button id="searchBtn" onclick="handleSearchInput()" style="background: #f3f4f6; border: none; padding: 0.25rem 0.5rem; color: #374151; cursor: pointer; height: 100%; display: flex; align-items: center; border-left: 1px solid #d1d5db;">
                                <i class="fas fa-search" style="font-size: 11.5px;"></i>
                            </button>
                        </div>
                    </div>
                    <%If m_blnEditAccess = True Or m_blnAddAccess = True Then%>
                    <div class="save-button-container">
                        <% If m_blnAddAccess = True Then %>
                        <button type="button" class="btn btnyellow" data-bs-toggle="tooltip" onclick="saveAll()" title="<%=MyBase.GetResourceString("C_SaveStrategyAndTargets")%>">
                            <%=MyBase.GetResourceString("C_Save")%>
                        </button>
                        <% End If %>
                        <% If m_blnEditAccess = True Then %>
                        <button type="button" class="btn btnyellow" data-bs-toggle="tooltip" onclick="openSaveWithRevisionModal()" title="<%=MyBase.GetResourceString("C_SaveWithRevision")%>">
                            <%=MyBase.GetResourceString("C_SaveWithRevision")%>
                        </button>
                        <% End If %>
                    </div>
                    <%End If%>
                </div>
            </div>

            <!-- Action Bar -->
            <%If m_blnAddAccess = True Then%>
            <div class="section-headers">
                <div class="action-bar" style="min-height:40px; display:flex; align-items:center;">
                <div class="button-group">
                    <span class="btn-new-hardware" onclick="toggleAddNewSection();" title="<%=MyBase.GetResourceString("C_AddNewTitle")%>" style="padding:8px 0;">
                            <span class="text-group"><i class="fas fa-plus"></i><%=MyBase.GetResourceString("C_AddNew")%></span>
                    </span>
                </div>
                </div>
            </div>
            <%End If%>

            <%If m_blnAddAccess = True Then%>
            <!-- Add New Section (Initially Hidden) -->
            <div class="new-hardware-form" id="addNewSection" style="display: none; margin-top:0; border-top:none;">
                <div class="form-container">
                    <div class="modal-body" style="padding:0 12px 12px 12px;">
                        <div class="add-toolbar">
                            <div class="subtle"><%=MyBase.GetResourceString("C_SelectOneOrMoreMetrics")%></div>
                            <div class="add-search-container">
                                <div class="add-search">
                                    <input type="text" id="txtAddSearch" placeholder="<%=MyBase.GetResourceString("C_SearchMetricsPlaceholder")%>" />
                                </div>
                            </div>
                        </div>
                        <table class="add-grid" style="width:100%;">
                            <thead>
                                <tr>
                                    <th style="text-align:left;">Metrics</th>
                                    <th style="width:80px; text-align:center;">
                                        <input type="checkbox" id="selectAllMetrics" onchange="toggleAllMetrics()" style="transform:scale(1.2);" />
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="metricsAddTbody">
                                <tr><td colspan="2" class="text-center"><%=MyBase.GetResourceString("C_ClickAddNewToLoadMetrics")%></td></tr>
                            </tbody>
                        </table>
                        
                        <!-- Add New Metrics Pagination -->
                        <div class="add-new-pagination-container">
                            <div class="add-new-pagination-total" id="addNewPaginationInfo"><%=MyBase.GetResourceString("C_TotalRecords")%> 0</div>
                            <div class="add-new-pager-buttons">
                                <button class="add-new-pager-btn" id="addNewPrevBtn" onclick="changeAddNewPage(-1)" title="<%=MyBase.GetResourceString("C_Previous")%>" type="button"><%=MyBase.GetResourceString("C_Previous")%></button>
                                <button class="add-new-pager-btn" id="addNewNextBtn" onclick="changeAddNewPage(1)" title="<%=MyBase.GetResourceString("C_Next")%>" type="button"><%=MyBase.GetResourceString("C_Next")%></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%End If%>

            <%If m_blnEditAccess = True Or (m_blnViewAccess = True And m_blnAddAccess = False) Then%>
            <!-- Strategy Section using same uniform container styling -->
            <div class="section-headers">
                <div class="action-bar" style="min-height:40px; display:flex; align-items:center;">
                <div class="button-group">
                    <span class="btn-new-hardware" onclick="toggleStrategySection()" title="<%=MyBase.GetResourceString("C_StrategyToAchieveObjectives")%>" style="padding:8px 0;">
                        <span class="text-group"><i class="fas fa-plus"></i><%=MyBase.GetResourceString("C_StrategyToAchieveObjectives")%></span>
                    </span>
                </div>
                </div>
            </div>

            <!-- Strategy Section (Initially Hidden) -->
            <div class="new-hardware-form" id="strategyForm" style="display: none; margin-top:0; border-top:none;">
                <div class="form-container">
                    <div class="form-group">
                        <textarea id="txtStrategy" class="form-control" rows="4" placeholder="<%=MyBase.GetResourceString("C_StrategyPlaceholder")%>"></textarea>
                   <small class="form-text text-muted">
                       <i class="fas fa-info-circle"></i> <span id="strategyCharCount">0</span>/2000 <%=MyBase.GetResourceString("C_Characters")%>
                   </small>
                    </div>
                </div>
            </div>
            <%End If%>

            <!-- Content Area -->
            <div class="table-scroll-container">
                <div id="objectiveListContainer"></div>
            </div>

            <!-- Pagination -->
            <div class="pagination-container">
                <div class="pagination-total" id="paginationInfo"><%=MyBase.GetResourceString("C_TotalRecords")%> 0</div>
                <div class="pager-buttons">
                    <button class="pager-btn" id="prevBtn" onclick="changePage(-1)" title="<%=MyBase.GetResourceString("C_Previous")%>" type="button"><%=MyBase.GetResourceString("C_Previous")%></button>
                    <button class="pager-btn" id="nextBtn" onclick="changePage(1)" title="<%=MyBase.GetResourceString("C_Next")%>" type="button"><%=MyBase.GetResourceString("C_Next")%></button>
                </div>
            </div>

            <!-- Hidden fields for form processing -->
            <input type="hidden" id="txthidAction" runat="server" />
            <input type="hidden" id="txthidData" runat="server" />
            <input type="hidden" id="txthidRowCount" runat="server" value="0" />
        </div>

        <%Else %>
        <div class="main-container" style="display: flex; align-items: center; justify-content: center; min-height: 100vh; background: #f5f5f5;">
            <div style="text-align: center; padding: 40px; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 500px;">
                <div style="margin-bottom: 20px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 64px; color: #dc3545;"></i>
                </div>
                <h2 style="color: #2c3e50; font-size: 24px; font-weight: 600; margin-bottom: 12px;"><%=MyBase.GetResourceString("C_AccessDenied")%></h2>
                <p style="color: #6c757d; font-size: 16px; margin: 0;"><%=MyBase.GetResourceString("C_NotAuthorize")%></p>
            </div>
        </div>
        <%End If %>
        
        <!-- Save with Revision Modal - Enhanced UI -->
        <div class="modal fade" id="saveRevisionModal" tabindex="-1" role="dialog" aria-labelledby="saveRevisionModalLabel" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 480px;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveRevisionModalLabel"><%=MyBase.GetResourceString("C_SaveWithRevisionTitle")%></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="txtRevisionReason" class="form-label"><%=MyBase.GetResourceString("C_RevisionReason")%></label>
                            <textarea class="form-control" id="txtRevisionReason" rows="4" maxlength="1000" placeholder="<%=MyBase.GetResourceString("C_RevisionReasonPlaceholder")%>"></textarea>
                            <small class="form-text text-muted">
                                <span id="revisionCharCount">0</span>/1000 <%=MyBase.GetResourceString("C_Characters")%>
                            </small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn borderbtn closebtn text-end" id="offcanvasClose" data-bs-toggle="tooltip" data-bs-dismiss="modal" data-bs-original-title="Close" onclick="clearRevisionReason()">
                            <%=MyBase.GetResourceString("C_Close")%>
                        </button>
                        <button type="button" class="btn btnyellow" id="btnSaveRevision" onclick="saveTargetValuesWithRevision()">
                            <%=MyBase.GetResourceString("C_Save")%>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    <%--</form>--%>

    <!-- Scripts -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>--%>
    <!-- Removed bootstrap-select JS to prevent auto-initialization -->
    <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <%--<script src="../../General/CommonValidations.js"></script>--%>

    <!-- Removed bootstrap-select for project dropdown to avoid duplicate rendering -->
    
    <script type="text/javascript">
        // Role access flags from server-side
        var g_blnAddAccess = '<%=LCase(m_blnAddAccess.ToString())%>' === 'true';
        var g_blnEditAccess = '<%=LCase(m_blnEditAccess.ToString())%>' === 'true';
        var g_blnDeleteAccess = '<%=LCase(m_blnDeleteAccess.ToString())%>' === 'true';
        var g_blnViewAccess = '<%=LCase(m_blnViewAccess.ToString())%>' === 'true';
        
        // Resource strings for JavaScript
        var resourceStrings = {
            strategySavedSuccess: '<%=MyBase.GetResourceString("A_StrategySavedSuccess")%>',
            metricsSavedSuccess: '<%=MyBase.GetResourceString("A_MetricsSavedSuccess")%>',
            errorSavingStrategy: '<%=MyBase.GetResourceString("A_ErrorSavingStrategy")%>',
            errorLoadingStrategy: '<%=MyBase.GetResourceString("A_ErrorLoadingStrategy")%>',
            onlyNumericTargets: '<%=MyBase.GetResourceString("A_OnlyNumericTargets")%>',
            noProjectInSession: '<%=MyBase.GetResourceString("A_NoProjectInSession")%>',
            errorGettingProjectInfo: '<%=MyBase.GetResourceString("A_ErrorGettingProjectInfo")%>',
            targetsSavedSuccess: '<%=MyBase.GetResourceString("A_TargetsSavedSuccess")%>',
            allValuesSavedSuccess: '<%=MyBase.GetResourceString("A_AllValuesSavedSuccess")%>',
            errorSavingTargets: '<%=MyBase.GetResourceString("A_ErrorSavingTargets")%>',
            unauthorizedRelogin: '<%=MyBase.GetResourceString("A_UnauthorizedRelogin")%>',
            selectAtLeastOneMetric: '<%=MyBase.GetResourceString("A_SelectAtLeastOneMetric")%>',
            noAvailableMetrics: '<%=MyBase.GetResourceString("A_NoAvailableMetrics")%>',
            loadingMetrics: '<%=MyBase.GetResourceString("A_LoadingMetrics")%>',
            errorLoadingMetrics: '<%=MyBase.GetResourceString("A_ErrorLoadingMetrics")%>',
            noProjectSelected: '<%=MyBase.GetResourceString("A_NoProjectSelected")%>',
            pleaseEnterStrategy: '<%=MyBase.GetResourceString("A_PleaseEnterStrategy")%>',
            invalidPMIID: '<%=MyBase.GetResourceString("A_InvalidPMIID")%>',
            objectivesSavedSuccess: '<%=MyBase.GetResourceString("A_ObjectivesSavedSuccess")%>',
            pleaseEnterObjective: '<%=MyBase.GetResourceString("A_PleaseEnterObjective")%>',
            noTargetValuesToSave: '<%=MyBase.GetResourceString("A_NoTargetValuesToSave")%>',
            selectProject: '<%=MyBase.GetResourceString("C_SelectProject")%>',
            errorAddingMetrics: '<%=MyBase.GetResourceString("A_ErrorAddingMetrics")%>',
            unknownError: '<%=MyBase.GetResourceString("A_UnknownError")%>',
            addNewMetricsTitle: '<%=MyBase.GetResourceString("C_AddNewMetricsTitle")%>',
            metrics: '<%=MyBase.GetResourceString("C_Metrics")%>',
            select: '<%=MyBase.GetResourceString("C_Select")%>',
            save: '<%=MyBase.GetResourceString("C_Save")%>',
            close: '<%=MyBase.GetResourceString("C_Close")%>',
            totalRecords: '<%=MyBase.GetResourceString("C_TotalRecords")%>',
            confirmCancelUnsaved: '<%=MyBase.GetResourceString("A_ConfirmCancelUnsaved")%>',
            specialCharactersNotAllowed: '<%=MyBase.GetResourceString("A_SpecialCharactersNotAllowed")%>',
            targetsWithRevisionSavedSuccess: '<%=MyBase.GetResourceString("A_TargetsWithRevisionSavedSuccess")%>',
            errorSavingRevisionReason: '<%=MyBase.GetResourceString("A_ErrorSavingRevisionReason")%>',
            noPermissionToAddMetrics: '<%=MyBase.GetResourceString("A_NoPermissionToAddMetrics")%>',
            noPermissionToEditStrategy: '<%=MyBase.GetResourceString("A_NoPermissionToEditStrategy")%>',
            noPermissionToSave: '<%=MyBase.GetResourceString("A_NoPermissionToSave")%>',
            saving: '<%=MyBase.GetResourceString("C_Saving")%>',
            viewOnlyNoEditing: '<%=MyBase.GetResourceString("A_ViewOnlyNoEditing")%>',
            noPermissionToAddMetricsTable: '<%=MyBase.GetResourceString("A_NoPermissionToAddMetricsTable")%>',
            canOnlyEditExistingStrategy: '<%=MyBase.GetResourceString("A_CanOnlyEditExistingStrategy")%>',
            noPermissionToViewPage: '<%=MyBase.GetResourceString("A_NoPermissionToViewPage")%>',
            strategyExceedsCharLimit: '<%=MyBase.GetResourceString("A_StrategyExceedsCharLimit")%>'
        };

        // Store to keep unsaved target values keyed by metric ID so they persist in UI
        var unsavedTargetByMetricId = {};

        // Persistence helpers so values survive reload/session expiry
        function getUnsavedStoreKey(){
            var projectID = getProjectIDFromSession() || '0';
            return 'qo_unsaved_targets_' + String(projectID);
        }

        function loadUnsavedTargetsFromStorage(){
            try {
                var raw = localStorage.getItem(getUnsavedStoreKey());
                unsavedTargetByMetricId = raw ? JSON.parse(raw) : {};
                if (typeof unsavedTargetByMetricId !== 'object' || unsavedTargetByMetricId === null) {
                    unsavedTargetByMetricId = {};
                }
            } catch(e) {
                unsavedTargetByMetricId = {};
            }
        }

        function persistUnsavedTargetsToStorage(){
            try {
                localStorage.setItem(getUnsavedStoreKey(), JSON.stringify(unsavedTargetByMetricId));
            } catch(e) {
                // ignore storage errors (e.g., quota)
            }
        }

        // Strategy draft persistence (per project)
        function getStrategyStoreKey(projectID){
            var pid = projectID || $('#cboProject').val() || $('#ddlProject').val() || getProjectIDFromSession() || '0';
            return 'qo_strategy_draft_' + String(pid);
        }
        function loadStrategyDraft(projectID){
            try { return localStorage.getItem(getStrategyStoreKey(projectID)) || ''; } catch(e) { return ''; }
        }
        function saveStrategyDraft(value, projectID){
            try { localStorage.setItem(getStrategyStoreKey(projectID), String(value||'')); } catch(e) { }
        }
        function clearStrategyDraft(projectID){
            try { localStorage.removeItem(getStrategyStoreKey(projectID)); } catch(e) { }
        }
        
        // Configure Alertify to match the desired styling
        alertify.set('notifier', 'position', 'top-right');
        alertify.set('notifier', 'delay', 4);
        
        // Base URL from web.config for W26API (external .NET Core solution)
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        // Ensure trailing slash
        if (strUrl && !strUrl.endsWith('/')) {
            strUrl += '/';
        }

        // Special characters restriction from web.config
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';

        // Utility to detect JSON string
        function isJson(value){ if(typeof value !== 'string') return false; try{ JSON.parse(value); return true; }catch(e){ return false; } }

        // Function to validate special characters
        function containsRestrictedCharacters(text) {
            if (!text || !WebConfigSpecialCharacters) return false;
            for (var i = 0; i < WebConfigSpecialCharacters.length; i++) {
                if (text.indexOf(WebConfigSpecialCharacters[i]) !== -1) {
                    return true;
                }
            }
            return false;
        }

        // Centralized AJAX wrapper with callback support
        function AJAXCallWithResult(url, param, successCallback, errorCallback, options) {
            var config = Object.assign({ method: 'POST', async: true }, options || {});
            var isGet = String(config.method || 'POST').toUpperCase() === 'GET';
            var fullUrl = strUrl + url;
            
            // For GET requests, append query params to URL
            if (isGet && param) {
                var queryString = '';
                if (typeof param === 'string') {
                    // If param is JSON string, parse it first
                    try {
                        var paramObj = JSON.parse(param);
                        queryString = $.param(paramObj);
                    } catch(e) {
                        queryString = param;
                    }
                } else {
                    queryString = $.param(param);
                }
                fullUrl += (fullUrl.indexOf('?') === -1 ? '?' : '&') + queryString;
            }
            
            
            $.ajax({
                url: encodeURI(fullUrl),
                type: isGet ? 'GET' : 'POST',
                data: isGet ? null : param,
                async: config.async,
                dataType: 'json',
                contentType: 'application/json;charset-utf=8',
                beforeSend: function (xhr) {
                    // Attach Bearer token
                    var token = sessionStorage.getItem('access_token_W26API');
                    if (!token) {
                        
                    }
                    xhr.setRequestHeader('Authorization', 'Bearer ' + token);
                    xhr.setRequestHeader('Accept', 'application/json');
                    if (!isGet && param) { 
                        xhr.setRequestHeader('Params', encryptString(isJson(param) ? param : JSON.stringify(param))); 
                    }
                },
                success: function (data) {
                    if (typeof successCallback === 'function') successCallback(data);
                },
                error: function (xhr, status, err) { 
                    
                    if (typeof errorCallback === 'function') errorCallback(xhr, status, err);
                    else {
                        if (xhr && xhr.status === 401) alertify.error(resourceStrings.unauthorizedRelogin);
                        else alertify.error(resourceStrings.errorGettingProjectInfo);
                    }
                }
            });
        }

        
        // Helper functions for common API patterns using AJAXCallWithResult
        function getPMIID(projectID, successCallback, errorCallback) {
            var param = JSON.stringify({ ProjectID: parseInt(projectID) });
            return AJAXCallWithResult('api/QuantObj/GetPMIID', param, successCallback, errorCallback, { method: 'POST' });
        }
        
        function getAvailableMetrics(projectID, successCallback, errorCallback) {
            var param = JSON.stringify({ ProjectID: parseInt(projectID) });
            return AJAXCallWithResult('api/QuantObj/GetAvailableMetrics', param, successCallback, errorCallback, { method: 'POST' });
        }
        
        function getPMIInformation(pmiID, projectID, successCallback, errorCallback) {
            var param = JSON.stringify({ PMIID: pmiID, ProjectID: parseInt(projectID) });
            return AJAXCallWithResult('api/QuantObj/GetPMIInformation', param, successCallback, errorCallback, { method: 'POST' });
        }
        
        function saveStrategyAPI(pmiID, projectID, objective, successCallback, errorCallback) {
            var param = JSON.stringify({ 
                PMIID: parseInt(pmiID), 
                ProjectID: parseInt(projectID), 
                MetricID: 0,
                ProjectValue: 0,
                Objective: objective || '' 
            });
            return AJAXCallWithResult('api/QuantObj/SaveStrategy', param, successCallback, errorCallback, { method: 'POST' });
        }
        
        function getObjectiveValue(pmiID, projectID, successCallback, errorCallback) {
            var param = JSON.stringify({ PMIID: pmiID, ProjectID: parseInt(projectID) });
            return AJAXCallWithResult('api/QuantObj/GetObjectiveValue', param, successCallback, errorCallback, { method: 'POST' });
        }
        
        // Track selected metric IDs for Add New (stable even if DOM re-renders)
        var selectedMetricIdsForAdd = [];

        // Returns a stable list of selected MetricIDs by union of memory and live DOM
        function getSelectedMetricIds(){
            var ids = [];
            try {
                if (Array.isArray(selectedMetricIdsForAdd) && selectedMetricIdsForAdd.length){
                    ids = selectedMetricIdsForAdd.slice();
                }
                // Fallback/union with any currently checked boxes in DOM
                $('input.chkMetric:checked').each(function(){
                    var id = parseInt($(this).data('id'));
                    if (id && ids.indexOf(id) === -1) ids.push(id);
                });
            } catch(e) {}
            return ids;
        }

        // Build flags from intent (strategy text presence, selected metrics, targets array)
        function computeSaveFlagsFromIntent(strategy, targets, metricIds){
            var flags = [];
            try { if ((strategy || '').trim().length > 0) { flags.push(1); } } catch(e) {}
            try { if (Array.isArray(metricIds) && metricIds.length > 0) { flags.push(2); } } catch(e) {}
            try { if (Array.isArray(targets) && targets.length > 0) { flags.push(3); } } catch(e) {}
            return flags;
        }

        // Track initial strategy text to detect changes accurately
        var strategyInitialValue = '';

        // Build user message based on what is being saved: 1=strategy, 2=metrics, 3=targets
        function showSaveSuccess(flags){
            try {
                var hasStrategy = flags.indexOf(1) > -1;
                var hasMetrics = flags.indexOf(2) > -1;
                var hasTargets = flags.indexOf(3) > -1;
                var count = (hasStrategy?1:0) + (hasMetrics?1:0) + (hasTargets?1:0);
                if (count === 1){
                    if (hasStrategy) { alertify.success((resourceStrings.strategySavedSuccess || 'Strategy saved successfully')); return; }
                    if (hasMetrics) { alertify.success((resourceStrings.metricsSavedSuccess || 'Metrics saved successfully')); return; }
                    if (hasTargets) { alertify.success((resourceStrings.targetsSavedSuccess || 'Target values saved successfully')); return; }
                }
                alertify.success((resourceStrings.allValuesSavedSuccess || 'All values saved successfully'));
            } catch(e) { alertify.success(resourceStrings.allValuesSavedSuccess || '<%=MyBase.GetResourceString("A_AllValuesSavedSuccess")%>'); }
        }

        // Derive flags by comparing current UI vs original values
        function computeSaveFlagsAccurate(){
            var flags = [];
            try {
                var currentStrategy = (($('#txtStrategy').val() || '').trim());
                var initialStrategy = (strategyInitialValue || '').trim();
                if (currentStrategy !== initialStrategy) { flags.push(1); }
            } catch(e) {}
            try { if (getSelectedMetricIds().length > 0) { flags.push(2); } } catch(e) {}
            try {
                var changed = false;
                $('.target-input').each(function(){
                    var nowVal = (($(this).val() || '').trim());
                    var origVal = (($(this).data('original-value') || '').trim());
                    // Normalize numeric strings for fair compare
                    var nNow = isNaN(parseFloat(nowVal)) ? nowVal : String(parseFloat(nowVal));
                    var nOrig = isNaN(parseFloat(origVal)) ? origVal : String(parseFloat(origVal));
                    if (nNow !== nOrig) { changed = true; return false; }
                });
                if (changed) { flags.push(3); }
            } catch(e) {}
            return flags;
        }

        function saveAllTargetsWithStrategy(pmiID, projectID, strategy, targets) {
            return new Promise((resolve, reject) => {
                var metricIds = getSelectedMetricIds();

                var metricIds = getSelectedMetricIds();
            var param = JSON.stringify({ 
                    PMIID: parseInt(pmiID), 
                ProjectID: parseInt(projectID), 
                    Strategy: strategy || '',
                    Targets: targets,
                    MetricIDs: metricIds
                });
                AJAXCallWithResult('api/QuantObj/SaveAllTargetsWithStrategy', param, function(response) {
                    try { response.__flags = computeSaveFlagsFromIntent(strategy, targets, metricIds); } catch(e) {}
                    resolve(response);
                }, function(error) {
                    reject(error);
                }, { method: 'POST' });
            });
        }
        
        function saveAllTargetsWithStrategyAndRevision(pmiID, projectID, strategy, targets, modifiedBy, revisionReason) {
            return new Promise((resolve, reject) => {
                var metricIds = getSelectedMetricIds();

                var metricIds = getSelectedMetricIds();
                var param = JSON.stringify({
                    PMIID: parseInt(pmiID), 
                    ProjectID: parseInt(projectID), 
                    Strategy: strategy || '',
                    Targets: targets,
                    ModifiedBy: modifiedBy || '',
                    RevisionReason: revisionReason || '',
                    MetricIDs: metricIds
                });
                AJAXCallWithResult('api/QuantObj/SaveAllTargetsWithStrategyAndRevision', param, function(response) {
                    try { response.__flags = computeSaveFlagsFromIntent(strategy, targets, metricIds); } catch(e) {}
                    resolve(response);
                }, function(error) {
                    reject(error);
                }, { method: 'POST' });
            });
        }
        
        function getMetricProjectValue(pmiID, projectID, metricID, successCallback, errorCallback) {
            var param = JSON.stringify({ PMIID: pmiID, ProjectID: parseInt(projectID), MetricID: metricID });
            return AJAXCallWithResult('api/QuantObj/GetMetricProjectValue', param, successCallback, errorCallback, { method: 'POST' });
        }
        
        function addMetricsToProject(projectID, metricIDs, successCallback, errorCallback) {
            var param = JSON.stringify({ ProjectID: parseInt(projectID), MetricIDs: metricIDs });
            return AJAXCallWithResult('api/QuantObj/AddMetricsToProject', param, successCallback, errorCallback, { method: 'POST' });
        }
        
        // Custom styling for success alerts (green)
        alertify.success = function(message) {
            alertify.notify(message, 'success', 4, function(){
            });
        };
        
        // Custom styling for error alerts (red)
        alertify.error = function(message) {
            alertify.notify(message, 'error', 4, function(){
            });
        };
        
        // Custom styling for warning alerts (orange/yellow)
        alertify.warning = function(message) {
            alertify.notify(message, 'warning', 4, function(){
            });
        };
        var metricCount = 1;
        var objectivesData = [];
        var filteredData = [];
        var currentPage = 1;
        var itemsPerPage = 10;
        
        // Add New Metrics pagination variables
        var addNewCurrentPage = 1;
        var addNewItemsPerPage = 10;
        var addNewFilteredData = [];
        var addNewAllData = [];

        // Standard API headers consistent with other NewAPI pages
        function apiHeaders(){
            // Try different token keys that might be used - prioritize project token
            var token = sessionStorage.getItem("access_token_project") || 
                        sessionStorage.getItem("access_token_whizible26") ||
                        sessionStorage.getItem("access_token") || 
                        sessionStorage.getItem("access_token_invoice") ||
                        localStorage.getItem("access_token_project") ||
                        localStorage.getItem("access_token_whizible26") ||
                        localStorage.getItem("access_token");
            
            return { Authorization: token ? ('Bearer ' + token) : '' };
        }
        
        // Function to encrypt parameters (placeholder - you may need to implement this)
        function encryptString(str) {
            // This is a placeholder - you may need to implement the actual encryption
            // For now, return the string as is
            return str;
        }

        // Fetch saved ProjectValue for each metric and update objectivesData
        function enrichTargetsWithSavedValues(pmiID, projectID){
            var requests = [];
            for(var i=0;i<objectivesData.length;i++){
                (function(idx){
                    var metricID = objectivesData[idx].matricID;
                    var req = getMetricProjectValue(pmiID, projectID, metricID, function(resp){
                            var rows = [];
                            if(Array.isArray(resp)) rows = resp; else if(resp && Array.isArray(resp.Table)) rows = resp.Table; else if(resp && Array.isArray(resp.Rows)) rows = resp.Rows;
                            if(rows.length > 0 && rows[0].ProjectValue !== undefined && rows[0].ProjectValue !== null){
                                objectivesData[idx].target = String(rows[0].ProjectValue);
                        }
                    });
                    requests.push(req);
                })(i);
            }
            return $.when.apply($, requests);
        }

        $(document).ready(function() {
            try {
                // Project dropdown auto-initializes via selectpicker class in HTML
                // No manual initialization needed to avoid duplication

                initializePage();
                bindEvents();

            } catch (error) {
                
            }
        });
        
        function initializePage() {
            
            // Verify access flags are boolean values
            if (typeof g_blnAddAccess !== 'boolean' || typeof g_blnEditAccess !== 'boolean') {
                
            }
            
            // If all access removed, show access denied UI and stop
            if (!g_blnAddAccess && !g_blnEditAccess && !g_blnDeleteAccess && !g_blnViewAccess) {
                try {
                    $('.main-container').hide();
                    var deniedHtml = '<div style="width:100%;text-align:center;margin-top:80px;">You are not authorized to view this record.</div>';
                    $('body').append(deniedHtml);
                } catch(e) {}
                return;
            }

            
            // Reset all save buttons to ensure they're not stuck in disabled/loading state
            $('.btn-primary-save').each(function() {
                var $btn = $(this);
                if ($btn.prop('disabled') || $btn.html().indexOf('Saving') >= 0 || $btn.html().indexOf('fa-spinner') >= 0) {
                    // Use the server-side resource string
                    var btnText = '<i class="fas fa-save"></i> <%=MyBase.GetResourceString("C_Save")%>';
                    $btn.prop('disabled', false).html(btnText);
                }
            });
            
            var urlParams = new URLSearchParams(window.location.search);
            var mode = urlParams.get('Mode');
            var projectID = getProjectIDFromSession();

            // Proceed with initialization (server-side dropdown is already populated)
            if (mode === 'AddMetric') {
                showAddMetricInterface(projectID);
            } else {
                loadObjectivesList();
                loadStrategyForCurrentProject();
            }
        }

        // Unified project change handler (server-side dropdown)
        function PlotProjectonChange(){
            currentPage = 1;
            loadObjectivesList();
            loadStrategyForCurrentProject();
        }

        function showAddMetricInterface(projectID) {
            
            // Hide the main interface
            $('.main-container').hide();
            
            // Create Add Metric interface
            var addMetricHTML = `
                <div class="add-metric-container">
                    <div class="add-metric-header">
                        <h2>` + resourceStrings.addNewMetricsTitle + `</h2>
                    </div>
                    <div class="add-metric-content">
                        <div class="metrics-search">
                            <input type="text" id="txtAddSearch" placeholder="<%=MyBase.GetResourceString("C_SearchMetricsPlaceholder")%>" class="form-control">
                        </div>
                        <div class="metrics-table-container">
                            <table class="metrics-table">
                                <thead>
                                    <tr>
                                        <th>` + resourceStrings.metrics + `</th>
                                        <th style="width:80px; text-align:center;">` + resourceStrings.select + `</th>
                                    </tr>
                                </thead>
                                <tbody id="metricsAddTbody">
                                </tbody>
                            </table>
                        </div>
                        <div class="add-metric-actions">
                            <!-- No inline actions; use main Save button on the main page -->
                        </div>
                    </div>
                </div>
            `;
            
            $('body').append(addMetricHTML);
            
            // Load available metrics
            loadAvailableMetrics(projectID);
        }

        function loadAvailableMetrics(projectID) {
            
            $('#metricsAddTbody').html('<tr><td colspan="2" class="text-center">' + resourceStrings.loadingMetrics + '</td></tr>');
            
            getAvailableMetrics(projectID, function(response) {
                    var html = '';
                    
                    if (response && response.length > 0) {
                        response.forEach(function(metric, index) {
                            html += '<tr>' +
                                    '<td>' + escapeHtml(metric.Name || 'N/A') + '</td>' +
                                    '<td class="chkbox"><input type="checkbox" class="chkMetric" data-id="' + metric.MetricID + '" /></td>' +
                                    '</tr>';
                        });
                    } else {
                    html = '<tr><td colspan="2" class="text-center">' + resourceStrings.noAvailableMetrics + '</td></tr>';
                    }
                    
                    $('#metricsAddTbody').html(html);
                    
                    // Persist selection changes in memory and bind search functionality
                    try {
                        $('#metricsAddTbody').off('change', '.chkMetric').on('change', '.chkMetric', function(){
                            var id = parseInt($(this).data('id'));
                            if (!id) return;
                            var idx = selectedMetricIdsForAdd.indexOf(id);
                            if (this.checked) {
                                if (idx === -1) selectedMetricIdsForAdd.push(id);
                            } else {
                                if (idx > -1) selectedMetricIdsForAdd.splice(idx,1);
                            }
                        });
                    } catch(e) {}
                    
                    // Bind search functionality
                    $('#txtAddSearch').off('keyup').on('keyup', function(){
                        var term = $(this).val().trim().toLowerCase();
                        var rows = $('#metricsAddTbody tr');
                        if(!term){ rows.show(); return; }
                        rows.each(function(){
                            var text = $(this).find('td:first').text().toLowerCase();
                            $(this).toggle(text.indexOf(term) >= 0);
                        });
                    });
            }, function(xhr, status, error) {
                    
                $('#metricsAddTbody').html('<tr><td colspan="2" class="text-center">' + resourceStrings.errorLoadingMetrics + '</td></tr>');
            });
        }

        function handleSearchInput(){
            const term = $('#searchObjective').val().trim().toLowerCase();
            if(term){
                filteredData = objectivesData.filter(function(x){
                    return (
                        x.goal.toLowerCase().includes(term) ||
                        x.norms.toLowerCase().includes(term) ||
                        (x.unit||'').toLowerCase().includes(term)
                    );
                });
            } else {
                filteredData = objectivesData.slice();
            }
            currentPage = 1;
            renderTable();
        }

        function bindEvents(){
            $('#searchObjective').on('keyup', function(){
                handleSearchInput();
            });

            // Project dropdown removed - data loads from session
        }

        function getCurrentUserID() {
            return '<%= Session("intUserID") %>' || '0';
        }

// Removed obsolete AddNew_OnClick (legacy popup flow)
        
        function toggleAddNewSection(){
            
            // CRITICAL: Check add access before allowing toggle
            if (!g_blnAddAccess) {
                
                alertify.error(resourceStrings.noPermissionToAddMetrics);
                return false;
            }
            
            var addForm = $('#addNewSection');
            var addBtn = $('.action-bar .button-group .btn-new-hardware').first();
            // Close strategy if open
            var strategyForm = $('#strategyForm');
            var strategyBtn = $('.action-bar .button-group .btn-new-hardware').eq(1);


            if(addForm.is(':visible')){
                addForm.slideUp(200); 
                addBtn.removeClass('expanded'); 
            } else { 
                addForm.slideDown(200); 
                addBtn.addClass('expanded'); 
                strategyForm.slideUp(200); 
                strategyBtn.removeClass('expanded'); 
                // Load available metrics using usp_Sel_AvailableMetrics_ForProject
                buildMetricsAddList(); 
            }
        }

        function toggleStrategySection(){
            
            // Allow toggle for anyone with view access (including view-only users)
            if (!g_blnViewAccess) {
                
                alertify.error(resourceStrings.noPermissionToViewPage);
                return false;
            }
            
            var strategyForm = $('#strategyForm');
            var strategyBtn = $('.action-bar .button-group .btn-new-hardware').eq(1);
            // Close add new if open
            var addForm = $('#addNewSection');
            var addBtn = $('.action-bar .button-group .btn-new-hardware').first();

            if(strategyForm.is(':visible')){ strategyForm.slideUp(200); strategyBtn.removeClass('expanded'); }
            else { strategyForm.slideDown(200); strategyBtn.addClass('expanded'); addForm.slideUp(200); addBtn.removeClass('expanded'); }
        }

        // Strategy textarea currently informational; no save to list for UI-only phase

        function loadObjectivesList(pmiIDOverride, projectIDOverride){
            // If both overrides are provided, use them directly
            if (pmiIDOverride && projectIDOverride) {
                // Ensure dropdown reflects the project
                try { var $proj = $('#cboProject').length ? $('#cboProject') : $('#ddlProject'); if ($proj.length) { $proj.val(String(projectIDOverride)); } } catch(e) {}
            loadUnsavedTargetsFromStorage();
                loadQuantitativeObjectives(pmiIDOverride, projectIDOverride);
                return;
            }
            
            // Fallback to session-driven flow
            var projectID = getProjectIDFromSession();
            loadUnsavedTargetsFromStorage();
            if(!projectID || projectID == '0'){
                showNoDataMessage();
                return;
            }
            getPMIIDForProject(projectID);
        }

        // Ensure UI refresh is consistent after save
        function refreshAfterSave(pmiID, projectID){
            try {
                // Reset search and pagination
                $('#searchObjective').val('');
                currentPage = 1;
                // Collapse Add New section if open
                var addSection = $('#addNewSection');
                if (addSection.length && addSection.is(':visible')) {
                    addSection.slideUp(150);
                    $('.action-bar .button-group .btn-new-hardware').first().removeClass('expanded');
                }
                // Collapse Strategy section if open
                var strategySection = $('#strategyForm');
                var strategyBtn = $('.action-bar .button-group .btn-new-hardware').eq(1);
                if (strategySection.length && strategySection.is(':visible')) {
                    strategySection.slideUp(150);
                    strategyBtn.removeClass('expanded');
                }
            } catch(e) {}
            // Defer to allow backend commit; poll a few times until data reflects
            var attempts = 0;
            var maxAttempts = 4; // ~2.8s total
            var previousCount = Array.isArray(objectivesData) ? objectivesData.length : 0;
            var poll = function(){
                attempts++;
                loadQuantitativeObjectives(pmiID, projectID);
                setTimeout(function(){
                    var currentCount = Array.isArray(objectivesData) ? objectivesData.length : 0;
                    if (attempts < maxAttempts && currentCount === previousCount) {
                        poll();
                    }
                }, 700);
            };
            setTimeout(poll, 700);
        }

        function getPMIIDForProject(projectID){
            
            getPMIID(projectID, function(response){
                var pmiID = null;
                if (response) {
                    pmiID = response.PMIID || response.pmiID || response.pmiId || null;
                    if (!pmiID && Array.isArray(response.data) && response.data.length > 0) {
                        var first = response.data[0];
                        pmiID = first.PMIID || first.pmiID || first.pmiid || first.pmiId || null;
                    }
                }
                if(pmiID){
                    loadQuantitativeObjectives(pmiID, projectID);
                    } else {
                        showNoDataMessage();
                    }
            }, function(xhr, status, error){
                    
                    showNoDataMessage();
            });
        }

        function loadQuantitativeObjectives(pmiID, projectID){
            getPMIInformation(pmiID, projectID, function(response){
                    
                    // Handle DataTable response format
                    var rows = [];
                    if (Array.isArray(response)) {
                        rows = response;
                    } else if (response && Array.isArray(response.Table)) {
                        rows = response.Table;
                    } else if (response && Array.isArray(response.Rows)) {
                        rows = response.Rows;
                } else if (response && Array.isArray(response.data)) {
                    rows = response.data;
                    }
                    
                    if(rows && rows.length > 0){
                        objectivesData = rows.map(function(item){
                            var belowFormatted = formatToFourDecimals(item.Below);
                            var aboveFormatted = formatToFourDecimals(item.Above);
                            var unitName = item.UnitName || '';
                            return {
                                goal: item.Name || 'N/A',
                                norms: (belowFormatted !== null && aboveFormatted !== null) ? (belowFormatted + ' - ' + aboveFormatted + (unitName ? (' ' + unitName) : '')) : 'N/A',
                                unit: unitName || 'Unit',
                                target: item.ProjectValue || '',
                                matricID: item.MetricID,
                                category: item.CategoryName || 'Uncategorized'
                            };
                        });
                        // Enrich target values from DB so they persist after re-login
                        enrichTargetsWithSavedValues(pmiID, projectID).always(function(){
                            filteredData = objectivesData.slice();
                            renderTable();
                        });
                    } else {
                        showNoDataMessage();
                    }
            }, function(xhr, status, error){
                    
                    showNoDataMessage();
            });
        }

        function showNoDataMessage(){
            objectivesData = [];
            filteredData = [];
            renderTable();
        }

        function getProjectIDFromSession(){
            // Prefer dropdown selection if present (support both ddlProject and cboProject)
            var ddl = document.getElementById('ddlProject') || document.getElementById('cboProject');
            if(ddl && ddl.value){ return ddl.value; }
            // Else fallback to session
            var sessionProjectID = '<%= Session("intProjectID") %>' || '';
            return sessionProjectID;
        }

        

        // Load and bind saved strategy text to textarea so it persists across loads
        function loadStrategyText(pmiID, projectID){
            // Prefer locally saved draft if present (survives reload/session expiry)
            var draft = loadStrategyDraft(projectID);
            if (draft && draft.length) {
                $('#txtStrategy').val(draft);
                $('#txtStrategy').data('has-existing-strategy', true);
            }
            getObjectiveValue(pmiID, projectID, function(resp){
                var serverVal = '';
                    if(resp && resp.Objective !== undefined){
                    serverVal = resp.Objective || '';
                    } else if(resp && resp.Table && resp.Table.length){
                    serverVal = resp.Table[0].Objective || '';
                }
                // Only overwrite UI if there is no draft typed locally
                if (!draft || draft.length === 0) {
                    $('#txtStrategy').val(serverVal);
                }
                // Mark if strategy exists (from server or draft)
                var hasStrategy = (draft && draft.length > 0) || (serverVal && serverVal.length > 0);
                $('#txtStrategy').data('has-existing-strategy', hasStrategy);
                // Capture initial value for accurate change tracking
                strategyInitialValue = $('#txtStrategy').val() || '';
                
                // Apply access control after loading
                applyStrategyAccessControl();
            }, function(xhr, status, error){
                    
                alertify.error(resourceStrings.errorLoadingStrategy);
                applyStrategyAccessControl();
            });
        }

        // Load strategy for currently selected project
        function loadStrategyForCurrentProject(){
            var projectID = $('#cboProject').val() || $('#ddlProject').val() || getProjectIDFromSession();
            
            // Clear the textarea first to avoid showing old project's strategy
            $('#txtStrategy').val('');
            $('#txtStrategy').data('has-existing-strategy', false);
            
            // Check if there's a draft for this specific project
            var projectDraft = loadStrategyDraft(projectID);
            
            if (projectDraft && projectDraft.length) {
                // Show the draft immediately
                $('#txtStrategy').val(projectDraft);
                $('#txtStrategy').data('has-existing-strategy', true);
                applyStrategyAccessControl();
            } else {
                // No draft, load from server
            if(projectID && projectID !== '0'){
                    getPMIID(projectID, function(res){
                        var pmiID = null;
                        if (res) {
                            pmiID = res.PMIID || res.pmiID || res.pmiId || null;
                            if (!pmiID && Array.isArray(res.data) && res.data.length > 0) {
                                var first = res.data[0];
                                pmiID = first.PMIID || first.pmiID || first.pmiid || first.pmiId || null;
                            }
                        }
                        if(pmiID){ 
                            loadStrategyText(pmiID, projectID); 
                        } else {
                            applyStrategyAccessControl();
                        }
                    });
                } else {
                    applyStrategyAccessControl();
                }
            }
        }
        
        // Update strategy character count display
        function updateStrategyCharCount() {
            var text = $('#txtStrategy').val();
            var charCount = text.length;
            var $counter = $('#strategyCharCount');
            $counter.text(charCount);
            
            // Change color if exceeds limit
            if (charCount > 2000) {
                $counter.css('color', '#dc3545'); // Red
                $counter.parent().css('color', '#dc3545');
            } else {
                $counter.css('color', '#4263c1'); // Blue
                $counter.parent().css('color', '#6c757d'); // Default gray
            }
            
            return charCount;
        }
        
        // Validate strategy character count
        function validateStrategyCharCount() {
            var charCount = updateStrategyCharCount();
            if (charCount > 2000) {
                var message = resourceStrings.strategyExceedsCharLimit.replace('{0}', charCount);
                alertify.error(message);
                return false;
            }
            return true;
        }

        // (Normalization now inlined in save paths per requirement)
        
        // Apply access control to strategy textarea based on permissions and existing content
        function applyStrategyAccessControl(){
            var currentValue = $('#txtStrategy').val().trim();
            var hasExistingStrategy = $('#txtStrategy').data('has-existing-strategy') || (currentValue && currentValue.length > 0);
            
            // Update word count on load
            updateStrategyCharCount();
            
            // View-only: always readonly
            if (!g_blnEditAccess && !g_blnAddAccess) {
                $('#txtStrategy').prop('readonly', true).css({
                    'background-color': '#f0f0f0',
                    'cursor': 'not-allowed'
                });
                // Prevent interaction for view-only users
                $('#txtStrategy').off('click focus').on('click focus', function(e){
                    e.preventDefault();
                    $(this).blur();
                    // Warning removed as per user request
                    return false;
                });
            }
            // Add-only (no Edit): cannot edit or create strategy
            else if (g_blnAddAccess && !g_blnEditAccess) {
                $('#txtStrategy').prop('readonly', true).css({
                    'background-color': '#f0f0f0',
                    'cursor': 'not-allowed'
                });
                $('#txtStrategy').off('click focus').on('click focus', function(e){
                    e.preventDefault();
                    $(this).blur();
                    return false;
                });
            }
            // Edit access (with or without Add): can create and edit strategy
            else if (g_blnEditAccess) {
                $('#txtStrategy').prop('readonly', false).css({
                    'background-color': '#fff',
                    'cursor': 'text'
                });
                $('#txtStrategy').off('click focus');
                // Bind live draft persistence and word count update for the textarea
                $('#txtStrategy').off('input change').on('input change', function(){
                    updateStrategyCharCount();
                    var currentProjectID = $('#cboProject').val() || $('#ddlProject').val() || getProjectIDFromSession();
                    saveStrategyDraft($(this).val(), currentProjectID);
                });
            }
        }

        // Save both strategy and target values
        function saveAll(){
            
            // CRITICAL: Check edit or add access - MUST have edit or add access to save
            if (!g_blnEditAccess && !g_blnAddAccess) {
                
                alertify.error(resourceStrings.noPermissionToSave);
                return false;
            }

            // EARLY PATH: Add-only users adding metrics (no strategy/targets involved)
            if (g_blnAddAccess && !g_blnEditAccess) {
                var selectedEarly = [];
                try { selectedEarly = getSelectedMetricIds(); } catch(e) { selectedEarly = []; }
                if (!selectedEarly || selectedEarly.length === 0) {
                    alertify.error(resourceStrings.selectAtLeastOneMetric);
                    return;
                }
                addSelectedMetricsForCurrentProject().then(function(res){
                    alertify.success(resourceStrings.metricsSavedSuccess || 'Metrics saved successfully');
                    try { $('#metricsAddTbody .chkMetric').prop('checked', false); selectedMetricIdsForAdd = []; } catch(e) {}
                    // Collapse Add New section and reload list
                    try {
                        var addSection = $('#addNewSection');
                        if (addSection.length && addSection.is(':visible')) {
                            addSection.slideUp(150);
                            $('.action-bar .button-group .btn-new-hardware').first().removeClass('expanded');
                        }
                    } catch(e) {}
                    loadObjectivesList();
                }).catch(function(err){
                    var msg = (err && err.message) ? err.message : (resourceStrings.errorAddingMetrics || 'Error adding metrics');
                    alertify.error(msg);
                });
                return;
            }
            
            // Determine if this is a metrics-only save (for Add-only flow)
            var rawStrategyCheck = $('#txtStrategy').val() || '';
            var strategyCheck = String(rawStrategyCheck).replace(/\s+/g, ' ').trim();
            var metricIdsCheck = [];
            try { metricIdsCheck = getSelectedMetricIds(); } catch(e) { metricIdsCheck = []; }
            var anyTargetEntered = false;
            try {
                $('.target-input').each(function(){ if (($(this).val()||'').trim() !== '') { anyTargetEntered = true; return false; } });
            } catch(e) {}
            var isMetricsOnly = (metricIdsCheck.length > 0) && !anyTargetEntered && strategyCheck === '';

            // If metrics-only, perform add and exit early
            if (isMetricsOnly) {
                addSelectedMetricsForCurrentProject().then(function(){
                    try { $('#metricsAddTbody .chkMetric').prop('checked', false); selectedMetricIdsForAdd = []; } catch(e) {}
                    alertify.success(resourceStrings.metricsSavedSuccess || 'Metrics saved successfully');
                    // Collapse Add New section and reload list
                    try {
                        var addSection = $('#addNewSection');
                        if (addSection.length && addSection.is(':visible')) {
                            addSection.slideUp(150);
                            $('.action-bar .button-group .btn-new-hardware').first().removeClass('expanded');
                        }
                    } catch(e) {}
                    loadObjectivesList();
                }).catch(function(err){
                    var msg = (err && err.message) ? err.message : (resourceStrings.errorAddingMetrics || 'Error adding metrics');
                    alertify.error(msg);
                });
                return; // do not proceed to strategy/targets save
            }

            // Otherwise enforce full validations
            if (!isMetricsOnly) {
                // Validate strategy character count
                if (!validateStrategyCharCount()) {
                    return;
                }
                // Validate that all target values are numeric
                if (!ValidateNorms()) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(resourceStrings.onlyNumericTargets);
                    return;
                }
            }
            
            var projectID = getProjectIDFromSession();
            if (!projectID || projectID == '0') {
                alertify.error(resourceStrings.noProjectInSession);
                return;
            }
            
            // First, attempt to add any selected metrics (if any), then proceed to save
            addSelectedMetricsForCurrentProject().catch(function(err){
                // If adding metrics fails, show error but continue to try saving existing targets/strategy
                if (err && err.message) { alertify.error(resourceStrings.errorAddingMetrics + ': ' + err.message); }
            }).finally(function(){
                // Get PMI ID first
                getPMIID(projectID, function(response) {
                var pmiID = null;
                if (response) {
                    pmiID = response.PMIID || response.pmiID || response.pmiId || null;
                    if (!pmiID && Array.isArray(response.data) && response.data.length > 0) {
                        var first = response.data[0];
                        pmiID = first.PMIID || first.pmiID || first.pmiid || first.pmiId || null;
                    }
                }
                if (pmiID) {
                    
                    // Collect all target values and strategy
                    var targets = [];
                    var rawStrategy = $('#txtStrategy').val() || '';
                    var strategy = String(rawStrategy).replace(/\s+/g, ' ').trim();
                    // Validate special characters for strategy
                    if (strategy && containsRestrictedCharacters(strategy)) {
                        alertify.error('Strategy should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        // Re-enable button since we disabled it before
                        try { $saveBtn.prop('disabled', false).html(originalBtnHtml); } catch(e) {}
                        return;
                    }
                    try { $('#txtStrategy').val(strategy); updateStrategyCharCount(); } catch(e) {}
                    
                    // Collect all target values from the table
                    $('.target-input').each(function(index) {
                        var value = $(this).val().trim().substring(0,10);
                        
                        // Round to 2 decimal places if it's a valid number
                        if (value && !isNaN(parseFloat(value))) {
                            var num = parseFloat(value);
                            value = num.toFixed(2);
                            // Remove trailing zeros if it's a whole number
                            if (value.indexOf('.') !== -1) {
                                value = value.replace(/\.?0+$/, '');
                            }
                        }
                        
                        $(this).val(value);
                        var matricID = $(this).data('metricid') || (objectivesData[index] ? objectivesData[index].matricID : null);
                        var originalValue = $(this).data('original-value') || '';
                        
                        if (matricID && value !== '') {
                            // Check if user has Add-only access (no Edit access)
                            if (g_blnAddAccess && !g_blnEditAccess) {
                                return true;
                            }
                            
                            // Add to targets array
                            targets.push({
                                MetricID: parseInt(matricID),
                                ProjectValue: parseFloat(value)
                            });
                            
                            // Update local cache
                            try {
                                for (var i = 0; i < objectivesData.length; i++) {
                                    if (objectivesData[i].matricID == matricID) {
                                        objectivesData[i].target = value;
                                        break;
                                    }
                                }
                            } catch(e) { }
                            
                            // Update in-memory store
                            if (matricID) { 
                                unsavedTargetByMetricId[String(matricID)] = value; 
                                persistUnsavedTargetsToStorage();
                            }
                        }
                    });
                    
                    // Also allow add-only save if MetricIDs are selected (even when no targets)
                    var metricIdsForDecision = Array.isArray(selectedMetricIdsForAdd) ? selectedMetricIdsForAdd.slice() : [];
                    if (metricIdsForDecision.length === 0) {
                        try {
                            $('#metricsAddTbody .chkMetric:checked').each(function(){
                                var id = $(this).data('id');
                                if (id) metricIdsForDecision.push(parseInt(id));
                            });
                        } catch(e) { }
                    }

                    // Always call bulk save; backend will handle empty arrays gracefully
                    saveAllTargetsWithStrategy(pmiID, projectID, strategy, targets).then(function(response) {
                        
                        var flags = (response && response.__flags) ? response.__flags : computeSaveFlagsAccurate();
                        showSaveSuccess(flags);
                        try { $('#metricsAddTbody .chkMetric').prop('checked', false); selectedMetricIdsForAdd = []; } catch(e) {}
                        refreshAfterSave(pmiID, projectID);
                    }).catch(function(error) {
                        
                        alertify.error(resourceStrings.errorSavingTargets);
                    });
                    
                    } else {
                        alertify.error(resourceStrings.errorGettingProjectInfo);
                    }
                }, function(xhr, status, error) {
                    
                    alertify.error(resourceStrings.errorGettingProjectInfo);
                });
            });
        }

        function saveTargetValues(){
            
            // CRITICAL: Check edit or add access - MUST have edit or add access to save
            if (!g_blnEditAccess && !g_blnAddAccess) {
                
                alertify.error(resourceStrings.noPermissionToSave);
                return false;
            }
            
            // Validate that all target values are numeric
            if (!ValidateNorms()) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(resourceStrings.onlyNumericTargets);
                return;
            }
            
            var projectID = getProjectIDFromSession();
            if (!projectID || projectID == '0') {
                alertify.error(resourceStrings.noProjectInSession);
                return;
            }
            
            // Get PMI ID first
            getPMIID(projectID, function(response) {
                
                var pmiID = null;
                if (response) {
                    pmiID = response.PMIID || response.pmiID || response.pmiId || null;
                    if (!pmiID && Array.isArray(response.data) && response.data.length > 0) {
                        var first = response.data[0];
                        pmiID = first.PMIID || first.pmiID || first.pmiid || first.pmiId || null;
                    }
                }
                if (pmiID) {
                    
                    
                    // Collect all target values and strategy
                    var targets = [];
                    var rawStrategy = $('#txtStrategy').val() || '';
                    var strategy = String(rawStrategy).replace(/\s+/g, ' ').trim();
                    // Validate special characters for strategy
                    if (strategy && containsRestrictedCharacters(strategy)) {
                        alertify.error('Strategy should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        return;
                    }
                    try { $('#txtStrategy').val(strategy); updateStrategyCharCount(); } catch(e) {}
                    
                    // Collect all target values from the table
                        $('.target-input').each(function(index) {
                            var value = $(this).val().trim().substring(0,10);
                        
                        // Round to 2 decimal places if it's a valid number
                        if (value && !isNaN(parseFloat(value))) {
                            var num = parseFloat(value);
                            value = num.toFixed(2);
                            // Remove trailing zeros if it's a whole number
                            if (value.indexOf('.') !== -1) {
                                value = value.replace(/\.?0+$/, '');
                            }
                        }
                        
                            $(this).val(value); // keep trimmed value displayed
                            var matricID = $(this).data('metricid') || (objectivesData[index] ? objectivesData[index].matricID : null);
                        var originalValue = $(this).data('original-value') || '';
                            
                            if (matricID && value !== '') {
                            // Check if user has Edit-only access (no Add access)
                            // In that case, only allow saving if original value existed (not empty)
                            if (g_blnEditAccess && !g_blnAddAccess) {
                                if (!originalValue || originalValue.trim() === '') {
                                    
                                    return true; // Continue to next iteration
                                }
                            }
                            
                            // Add to targets array
                            targets.push({
                                MetricID: parseInt(matricID),
                                ProjectValue: parseFloat(value)
                            });
                            
                            // Update local cache
                                try {
                                    for (var i = 0; i < objectivesData.length; i++) {
                                        if (objectivesData[i].matricID == matricID) {
                                            objectivesData[i].target = value;
                                            break;
                                        }
                                    }
                                } catch(e) { }

                            // Update in-memory store
                        if (matricID) { 
                            unsavedTargetByMetricId[String(matricID)] = value; 
                            persistUnsavedTargetsToStorage();
                            }
                        }
                    });
                    
                    // Also allow add-only save if MetricIDs are selected (even when no targets)
                    var metricIdsForDecision = Array.isArray(selectedMetricIdsForAdd) ? selectedMetricIdsForAdd.slice() : [];
                    if (metricIdsForDecision.length === 0) {
                        try {
                            $('#metricsAddTbody .chkMetric:checked').each(function(){
                                var id = $(this).data('id');
                                if (id) metricIdsForDecision.push(parseInt(id));
                            });
                        } catch(e) { }
                    }

                    // Always call bulk save; backend will handle empty arrays gracefully
                    saveAllTargetsWithStrategy(pmiID, projectID, strategy, targets).then(function(response) {
                        
                        var flags = (response && response.__flags) ? response.__flags : computeSaveFlagsAccurate();
                        showSaveSuccess(flags);
                        try { $('#metricsAddTbody .chkMetric').prop('checked', false); selectedMetricIdsForAdd = []; } catch(e) {}
                        refreshAfterSave(pmiID, projectID);
                    }).catch(function(error) {
                        
                        alertify.error(resourceStrings.errorSavingTargets);
                        });
                    } else {
                    
                    alertify.error(resourceStrings.errorGettingProjectInfo);
                }
            }, function(xhr, status, error) {
                
                alertify.error(resourceStrings.errorGettingProjectInfo);
            });
        }
        
        // Save with Revision Functions
        function openSaveWithRevisionModal() {
            
            
            // Check permissions
            if (!g_blnEditAccess && !g_blnAddAccess) {
                
                alertify.error(resourceStrings.noPermissionToSave);
                return false;
            }
            
            // Validate that all target values are numeric before opening modal
            if (!ValidateNorms()) {
                alertify.error(resourceStrings.onlyNumericTargets);
                            return;
                        }
                        
            // Clear previous input and show modal
            clearRevisionReason();
            var modal = new bootstrap.Modal(document.getElementById('saveRevisionModal'));
            modal.show();
        }
        
        function clearRevisionReason() {
            $('#txtRevisionReason').val('');
            $('#revisionCharCount').text('0');
        }
        
        // Character counter for revision reason
        $(document).ready(function() {
            $('#txtRevisionReason').on('input', function() {
                var length = $(this).val().length;
                $('#revisionCharCount').text(length);
            });
        });
        
        function saveTargetValuesWithRevision() {
            
            var revisionReason = $('#txtRevisionReason').val().trim();
            
            // Check for special characters only if reason is provided
            if (revisionReason && containsRestrictedCharacters(revisionReason)) {
                alertify.error('Revision reason should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $('#txtRevisionReason').focus();
                return;
            }
            
            // Validate strategy word count
            if (!validateStrategyCharCount()) {
                return;
            }
            
            var projectID = getProjectIDFromSession();
            if (!projectID || projectID == '0') {
                alertify.error(resourceStrings.noProjectInSession);
                return;
            }
            
            // Disable save button to prevent double-click
            var $saveBtn = $('#btnSaveRevision');
            var originalBtnHtml = $saveBtn.html();
            $saveBtn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> ' + resourceStrings.saving);
            
            // Get PMI ID and save with revision
            getPMIID(projectID, function(response) {
                
                var pmiID = null;
                if (response) {
                    pmiID = response.PMIID || response.pmiID || response.pmiId || null;
                    if (!pmiID && Array.isArray(response.data) && response.data.length > 0) {
                        var first = response.data[0];
                        pmiID = first.PMIID || first.pmiID || first.pmiid || first.pmiId || null;
                    }
                }
                
                if (pmiID) {
                    
                    
                    // Collect all target values and strategy
                    var targets = [];
                    var rawStrategy = $('#txtStrategy').val() || '';
                    var strategy = String(rawStrategy).replace(/\s+/g, ' ').trim();
                    // Validate special characters for strategy
                    if (strategy && containsRestrictedCharacters(strategy)) {
                        alertify.error('Strategy should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        return;
                    }
                    try { $('#txtStrategy').val(strategy); updateStrategyCharCount(); } catch(e) {}
                    
                    // Collect all target values from the table
                    $('.target-input').each(function(index) {
                        var value = $(this).val().trim().substring(0,10);
                        
                        // Round to 2 decimal places if it's a valid number
                        if (value && !isNaN(parseFloat(value))) {
                            var num = parseFloat(value);
                            value = num.toFixed(2);
                            // Remove trailing zeros if it's a whole number
                            if (value.indexOf('.') !== -1) {
                                value = value.replace(/\.?0+$/, '');
                            }
                        }
                        
                        var matricID = $(this).data('metricid') || (objectivesData[index] ? objectivesData[index].matricID : null);
                        var originalValue = $(this).data('original-value') || '';
                        
                        if (matricID && value !== '') {
                            // Check if user has Add-only access (no Edit access)
                            if (g_blnAddAccess && !g_blnEditAccess) {
                                
                                return true; // Continue to next iteration
                            }
                            
                            // Add to targets array
                            targets.push({
                                MetricID: parseInt(matricID),
                                ProjectValue: parseFloat(value)
                            });
                            
                            // Update local cache
                            try {
                                for (var i = 0; i < objectivesData.length; i++) {
                                    if (objectivesData[i].matricID == matricID) {
                                        objectivesData[i].target = value;
                                        break;
                                    }
                                }
                            } catch(e) { }
                            
                            // Update in-memory store
                            if (matricID) { 
                                unsavedTargetByMetricId[String(matricID)] = value; 
                                persistUnsavedTargetsToStorage();
                            }
                        }
                    });
                    
                    // Also allow add-only save if MetricIDs are selected (even when no targets)
                    var metricIdsForDecision = Array.isArray(selectedMetricIdsForAdd) ? selectedMetricIdsForAdd.slice() : [];
                    if (metricIdsForDecision.length === 0) {
                        try {
                            $('#metricsAddTbody .chkMetric:checked').each(function(){
                                var id = $(this).data('id');
                                if (id) metricIdsForDecision.push(parseInt(id));
                            });
                        } catch(e) { }
                    }

                    // Always call bulk save with revision; backend will handle empty arrays gracefully
                    saveAllTargetsWithStrategyAndRevision(pmiID, projectID, strategy, targets, '<%= Session("strUserName") %>', revisionReason).then(function(response) {
                        
                        var flags = (response && response.__flags) ? response.__flags : computeSaveFlagsAccurate();
                        showSaveSuccess(flags);
                        // Close modal
                        var modal = bootstrap.Modal.getInstance(document.getElementById('saveRevisionModal'));
                        modal.hide();
                        clearRevisionReason();
                        $saveBtn.prop('disabled', false).html(originalBtnHtml);
                        try { $('#metricsAddTbody .chkMetric').prop('checked', false); selectedMetricIdsForAdd = []; } catch(e) {}
                        refreshAfterSave(pmiID, projectID);
                    }).catch(function(error) {
                        
                        alertify.error(resourceStrings.errorSavingTargets);
                        $saveBtn.prop('disabled', false).html(originalBtnHtml);
                        });
                        
                    } else {
                    
                    alertify.error(resourceStrings.errorGettingProjectInfo);
                    $saveBtn.prop('disabled', false).html(originalBtnHtml);
                }
            }, function(xhr, status, error) {
                
                alertify.error(resourceStrings.errorGettingProjectInfo);
                $saveBtn.prop('disabled', false).html(originalBtnHtml);
            });
        }
        
        function saveRevisionReason(projectID, reason, successCallback, errorCallback) {
            var param = JSON.stringify({ 
                ProjectID: parseInt(projectID), 
                RevisionReason: reason,
                ModifiedBy: '<%= Session("strUserName") %>'
            });
            return AJAXCallWithResult('api/QuantObj/SaveRevisionReason', param, successCallback, errorCallback, { method: 'POST' });
        }

        function buildMetricsAddList(){
            
            
            // CRITICAL: Check add access before loading metrics
            if (!g_blnAddAccess) {
                
                $('#metricsAddTbody').html('<tr><td colspan="2" class="text-center">' + resourceStrings.noPermissionToAddMetricsTable + '</td></tr>');
                return false;
            }
            
            var projectID = getProjectIDFromSession();
            
            
            if (!projectID || projectID == '0') {
                
                $('#metricsAddTbody').html('<tr><td colspan="2" class="text-center">' + resourceStrings.noProjectInSession + '</td></tr>');
                return;
            }
            
            
            $('#metricsAddTbody').html('<tr><td colspan="2" class="text-center">' + resourceStrings.loadingMetrics + '</td></tr>');
            
            // Call API to get metrics not already added to the project
            getAvailableMetrics(projectID, function(response) {
                    // Normalize different possible response shapes
                    var rows = [];
                    if (Array.isArray(response)) {
                        rows = response;
                    } else if (response && Array.isArray(response.Table)) {
                        rows = response.Table;
                    } else if (response && Array.isArray(response.Rows)) {
                        rows = response.Rows;
                    }

                    // Store all data for pagination
                    addNewAllData = rows.map(function(metric){
                        return {
                            id: metric.MetricID || metric.MetricId || metric.metricID || metric.metricId,
                            name: metric.Name || metric.MetricName || metric.name
                        };
                    });
                    
                    // Apply search filter if any
                    applyAddNewSearchFilter();
                    
            }, function(xhr, status, error) {
                    
                $('#metricsAddTbody').html('<tr><td colspan="2" class="text-center">' + resourceStrings.errorLoadingMetrics + '</td></tr>');
            });
            
            // bind add-search with pagination
            $('#txtAddSearch').off('keyup').on('keyup', function(){
                applyAddNewSearchFilter();
            });
        }
        
        function applyAddNewSearchFilter(){
            var searchTerm = $('#txtAddSearch').val().toLowerCase().trim();
            
            if(searchTerm === ''){
                addNewFilteredData = addNewAllData.slice();
            } else {
                addNewFilteredData = addNewAllData.filter(function(metric){
                    return metric.name.toLowerCase().includes(searchTerm);
                });
            }
            
            addNewCurrentPage = 1; // Reset to first page
            renderAddNewMetricsTable();
        }
        
        function renderAddNewMetricsTable(){
            var totalPages = Math.max(1, Math.ceil(addNewFilteredData.length / addNewItemsPerPage));
            if(addNewCurrentPage > totalPages) addNewCurrentPage = totalPages;
            
            var start = (addNewCurrentPage - 1) * addNewItemsPerPage;
            var end = start + addNewItemsPerPage;
            var pageData = addNewFilteredData.slice(start, end);
            
            var html = '';
            if(pageData.length === 0){
                html = '<tr><td colspan="2" class="text-center">' + resourceStrings.noAvailableMetrics + '</td></tr>';
            } else {
                pageData.forEach(function(metric){
                    html += '<tr>'+
                            '<td>'+ escapeHtml(metric.name || 'N/A') +'</td>'+
                            '<td class="chkbox"><input type="checkbox" class="chkMetric" data-id="'+ (metric.id || '') +'" onchange="updateSelectAllCheckboxState()" /></td>'+
                            '</tr>';
                });
            }
            
            $('#metricsAddTbody').html(html);
            
            // Update pagination info
            $('#addNewPaginationInfo').text(resourceStrings.totalRecords + ' ' + addNewFilteredData.length);
            
            // Update pagination buttons
            $('#addNewPrevBtn').prop('disabled', addNewCurrentPage === 1);
            $('#addNewNextBtn').prop('disabled', addNewCurrentPage >= totalPages);
            
            // Update Select All checkbox state
            updateSelectAllCheckboxState();
        }
        
        function changeAddNewPage(direction){
            var totalPages = Math.max(1, Math.ceil(addNewFilteredData.length / addNewItemsPerPage));
            var newPage = addNewCurrentPage + direction;
            
            if(newPage >= 1 && newPage <= totalPages){
                addNewCurrentPage = newPage;
                renderAddNewMetricsTable();
            }
        }
        
        function toggleAllMetrics(){
            var selectAllCheckbox = $('#selectAllMetrics');
            var isChecked = selectAllCheckbox.is(':checked');
            
            // Select/deselect all visible checkboxes on current page
            $('#metricsAddTbody .chkMetric').prop('checked', isChecked);
            
            
        }
        
        function updateSelectAllCheckboxState(){
            var totalCheckboxes = $('#metricsAddTbody .chkMetric').length;
            var checkedCheckboxes = $('#metricsAddTbody .chkMetric:checked').length;
            var selectAllCheckbox = $('#selectAllMetrics');
            
            if(totalCheckboxes === 0){
                selectAllCheckbox.prop('indeterminate', false).prop('checked', false);
            } else if(checkedCheckboxes === 0){
                selectAllCheckbox.prop('indeterminate', false).prop('checked', false);
            } else if(checkedCheckboxes === totalCheckboxes){
                selectAllCheckbox.prop('indeterminate', false).prop('checked', true);
            } else {
                selectAllCheckbox.prop('indeterminate', true).prop('checked', false);
            }
        }

        

        // Add selected metrics (from Add New UI or popup) for current project
        function addSelectedMetricsForCurrentProject(){
            return new Promise(function(resolve, reject){
                try{
                    // If user has no add access or the Add UI is not present, resolve immediately
                    if (!g_blnAddAccess) { resolve({ skipped: true }); return; }

            var projectID = getProjectIDFromSession();
                    if (!projectID || projectID == '0') { resolve({ skipped: true }); return; }

                    // Collect selected checkboxes (support both embedded and any popup contexts)
                    var selected = [];
                    try {
                        // Prefer robust getter that unions memory + DOM
                        selected = getSelectedMetricIds();
                    } catch(e) {
                        selected = [];
                    }
                    if (!selected || selected.length === 0) {
                        var $checkboxes = $('input.chkMetric:checked, #metricsAddTbody .chkMetric:checked');
                        $checkboxes.each(function(){
                            var id = $(this).data('id');
                            if (id) selected.push(parseInt(id));
                        });
                    }
                    if (!selected || selected.length === 0) { resolve({ skipped: true }); return; }

                    if (selected.length === 0) { resolve({ skipped: true }); return; }

                    addMetricsToProject(projectID, selected, function(response){
                        try {
                            var isSuccess = (
                            (response && (response.Success === true || response.success === true)) ||
                            (response === true) ||
                            (typeof response === 'string' && response.toLowerCase().indexOf('success') >= 0)
                        );
                    if (isSuccess) {
                                // Clear selections and collapse the section
                                $('#metricsAddTbody .chkMetric').prop('checked', false);
                        var addSection = $('#addNewSection');
                                if (addSection.length && addSection.is(':visible')) {
                            addSection.slideUp(200);
                            $('.action-bar .button-group .btn-new-hardware').first().removeClass('expanded');
                                }
                                resolve({ added: selected.length });
                    } else {
                        var msg = (response && (response.Message || response.message)) || resourceStrings.unknownError;
                                reject(new Error(msg));
                            }
                        } catch(e) { reject(e); }
                    }, function(xhr){
                        var msg = resourceStrings.errorAddingMetrics;
                if (xhr && xhr.status === 401) { msg = resourceStrings.unauthorizedRelogin; }
                        reject(new Error(msg));
                    });
                } catch(err){ reject(err); }
            });
        }

 

        function renderTable(){
            var totalPages = Math.max(1, Math.ceil(filteredData.length / itemsPerPage));
            if(currentPage > totalPages) currentPage = totalPages;
            var start = (currentPage - 1) * itemsPerPage;
            var pageData = filteredData.slice(start, start + itemsPerPage);

            var html = '';
            html += '<table class="objectives-table" style="width:100%; margin:0;">';
            html += '<thead><tr>'+
                    '<th><%=MyBase.GetResourceString("C_Goals")%></th>'+
                    '<th><%=MyBase.GetResourceString("C_Norms")%></th>'+
                    '<th><%=MyBase.GetResourceString("C_TargetSetForProject")%></th>'+
                    '</tr></thead><tbody>';
            
            if(pageData.length === 0){
                html += '<tr><td colspan="3" class="no-data"><%=MyBase.GetResourceString("C_NoObjectivesAvailable")%></td></tr>';
            } else {
                // Group data by category
                var groupedData = groupDataByCategory(pageData);
                
                // Render grouped data
                for(var category in groupedData){
                    if(groupedData.hasOwnProperty(category)){
                        // Category header row
                        html += '<tr class="category-header">'+
                                '<td colspan="3" style="background:#f8f9fa; font-weight:600; color:#2c3e50; padding:12px 16px; border-bottom:2px solid #dee2e6;">'+
                                escapeHtml(category) +'</td>'+
                                '</tr>';
                        
                        // Metrics under this category
                        for(var i=0; i<groupedData[category].length; i++){
                            var r = groupedData[category][i];
                            var rowClass = (i % 2 === 0) ? 'metric-row-even' : 'metric-row-odd';
                            var metricIdStr = String(r.matricID);
                            var initialValue = (unsavedTargetByMetricId.hasOwnProperty(metricIdStr) && unsavedTargetByMetricId[metricIdStr] !== null && unsavedTargetByMetricId[metricIdStr] !== undefined)
                                ? String(unsavedTargetByMetricId[metricIdStr])
                                : String(r.target||'');
                            initialValue = initialValue.toString().substring(0,10);
                            var readOnlyAttr = '';
                            var inputStyle = 'width:120px; display:inline-block; margin-right:8px;';
                            
                            // View-only: all fields readonly
                            if (!g_blnEditAccess && !g_blnAddAccess) {
                                readOnlyAttr = ' readonly="readonly"';
                                inputStyle += ' background-color:#f0f0f0; cursor:not-allowed;';
                            }
                            // Add only (no Edit): all existing fields readonly, can only add new metrics via Add New
                            else if (g_blnAddAccess && !g_blnEditAccess) {
                                readOnlyAttr = ' readonly="readonly"';
                                inputStyle += ' background-color:#f0f0f0; cursor:not-allowed;';
                            }
                            // Edit access (with or without Add): can edit all fields and add new values
                            // No additional restrictions needed here
                            
                            html += '<tr class="' + rowClass + '">'+
                                    '<td style="padding-left:30px; color:#495057;">'+ escapeHtml(r.goal) +'</td>'+
                                    '<td style="color:#6c757d;">'+ escapeHtml(r.norms) +'</td>'+
                                    '<td class="target-cell">'+
                                        '<input class="form-control target-input" type="text" maxlength="10" data-metricid="'+ escapeHtml(r.matricID) +'" data-original-value="'+ escapeHtml(initialValue) +'" value="'+ escapeHtml(initialValue) +'" placeholder="" style="'+ inputStyle +'"' + readOnlyAttr + ' />'+
                                        '<span style="color:#6c757d; font-size:13px;">'+ escapeHtml(r.unit||'') +'</span>'+
                                    '</td>'+
                                    '</tr>';
                        }
                    }
                }
            }
            html += '</tbody></table>';
            $('#objectiveListContainer').html(html);

            // pagination ui
            var totalText = '<%=MyBase.GetResourceString("C_TotalRecords")%> '+ filteredData.length;
            $('#paginationInfo').text(totalText);
            $('#prevBtn').prop('disabled', currentPage === 1);
            $('#nextBtn').prop('disabled', currentPage >= totalPages);

        // Bind change handlers to persist values typed by the user (only if user has edit or add access)
        if (g_blnEditAccess || g_blnAddAccess) {
            // Restrict to numeric input only (prevent alphabets)
            $('.target-input').off('keypress').on('keypress', function(e){
                var charCode = (e.which) ? e.which : e.keyCode;
                var inputValue = $(this).val();
                
                // Allow: backspace, delete, tab, escape, enter
                if (charCode === 8 || charCode === 9 || charCode === 27 || charCode === 13) {
                    return true;
                }
                
                // Allow: decimal point (only one)
                if (charCode === 46) {
                    if (inputValue.indexOf('.') === -1) {
                        return true;
                    } else {
                        e.preventDefault();
                        return false;
                    }
                }
                
                // Allow: minus sign (only at the beginning)
                if (charCode === 45) {
                    if (inputValue.length === 0 || $(this).prop('selectionStart') === 0) {
                        return true;
                    } else {
                        e.preventDefault();
                        return false;
                    }
                }
                
                // Allow only numbers (0-9)
                if (charCode >= 48 && charCode <= 57) {
                    return true;
                }
                
                // Block all other characters
                e.preventDefault();
                return false;
            });
            
            // Also prevent paste of non-numeric content
            $('.target-input').off('paste').on('paste', function(e){
                e.preventDefault();
                var pastedText = (e.originalEvent || e).clipboardData.getData('text/plain');
                // Remove all non-numeric characters except decimal point and minus sign
                var cleanedText = pastedText.replace(/[^0-9.\-]/g, '');
                // Ensure only one decimal point
                var parts = cleanedText.split('.');
                if (parts.length > 2) {
                    cleanedText = parts[0] + '.' + parts.slice(1).join('');
                }
                // Ensure minus sign only at beginning
                cleanedText = cleanedText.replace(/(?!^)-/g, '');
                
                // Insert cleaned text at cursor position
                var input = $(this)[0];
                var startPos = input.selectionStart;
                var endPos = input.selectionEnd;
                var currentValue = $(this).val();
                var newValue = currentValue.substring(0, startPos) + cleanedText + currentValue.substring(endPos);
                newValue = newValue.substring(0, 10);
                
                
                $(this).val(newValue);
                
                // Trigger change event
                $(this).trigger('change');
            });
            
            $('.target-input').off('input change').on('input change', function(){
                var metricId = String($(this).data('metricid'));
                var val = $(this).val().trim().substring(0,10);
                
                
                $(this).val(val);
                unsavedTargetByMetricId[metricId] = val;
                persistUnsavedTargetsToStorage();
            });
        } else {
            // For view-only users, prevent any interaction with inputs
            $('.target-input').off('input change keydown keyup keypress mousedown click focus');
            $('.target-input').on('click focus mousedown', function(e){
                e.preventDefault();
                e.stopPropagation();
                $(this).blur();
                // Warning removed as per user request
                return false;
            });
        }
        }
        
        function groupDataByCategory(data) {
            var grouped = {};
            
            for(var i=0; i<data.length; i++){
                var item = data[i];
                var category = item.category || 'Uncategorized';
                
                if(!grouped[category]){
                    grouped[category] = [];
                }
                grouped[category].push(item);
            }
            
            return grouped;
        }

        function changePage(delta){
            var totalPages = Math.max(1, Math.ceil(filteredData.length / itemsPerPage));
            var np = currentPage + delta;
            if(np >= 1 && np <= totalPages){ currentPage = np; renderTable(); }
        }


        function escapeHtml(str){
            return String(str||'').replace(/[&<>"]+/g, function(s){
                return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'})[s];
            });
        }
        function formatToFourDecimals(value){
            var num = parseFloat(value);
            if (isNaN(num)) { return null; }
            return num.toFixed(4);
        }
        // Legacy compatibility shims
        function ValidateNorms(){
            var valid = true;
            $('.target-input').each(function(){
                var v = $(this).val().trim();
                if(v.length > 10){
                    v = v.substring(0,10);
                    $(this).val(v);
                }
                if(v !== '' && isNaN(Number(v))){
                    valid = false;
                    $(this).addClass('is-invalid');
                } else {
                    $(this).removeClass('is-invalid');
                }
            });
            return valid;
        }
        //function Save_OnClick(){
        //    if(!ValidateNorms()){
        //        alertify.error(resourceStrings.onlyNumericTargets);
        //        return;
        //    }
        //    var action = document.getElementById('txthidAction');
        //    if(action){ action.value = 'SAVE'; }
        //    document.getElementById('frmQuantativeObjectives').submit();
        //}
        function SaveRevision_OnClick(){
            window.open('PM_QuantitativeObjectives.aspx?Mode=SR', '_blank', 'resizable=no,scrollbars=no,width=600,height=220');
        }
    </script>
</body>
</html>
