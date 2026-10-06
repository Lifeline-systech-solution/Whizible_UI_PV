﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Documents.aspx.vb" Inherits="Whizible.PM_Documents" %>

<!DOCTYPE html>
<html>
     <%CommonFunctions.General.PlotPageHeadTag("Project Documents")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?">
    <!-- Added By Madhuri.K On 26-03-2026 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
    <style type="text/css">
        /* Added by Vishal Mane on 23/01/2026 for UI changes */
        body {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
                }
                .form-control, .btn, a, p, input, select.form-select {
            /* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;
        }
        /* End of Added by Vishal Mane on 23/01/2026 for UI changes */
        /*Added by Vishal Mane on 19/01/2026*/
        .fixed-textarea{
           /*min-height: calc(1.5em + .75rem + calc(var(--bs-border-width) * 2));*/
           height: 150px;
            resize: vertical;
        }
        .fixed-textarea2{
           /*min-height: calc(1.5em + .75rem + calc(var(--bs-border-width) * 2));*/
           height: 100px;
            resize: vertical;
        }
        .Doc_reviewInfo .dropdown-toggle {
           width: 260px;
        }
        .deleteIcon{
            color: #e81d1d;
        }
        .dynamic-textarea{
           height: 10px;
            resize: vertical;
        }
        .project-section .dropdown-toggle{
            width:280px;
        }
        /*End of Added by Vishal Mane on 19/01/2026*/
        .offcanvas-55{
            --bs-offcanvas-width: 70%;
        }
        .offcanvas-70{
            --bs-offcanvas-width: 72%;
        }
        .borderbtn {
            border-color: #1359a6 !important;
        }
        .nostylebtn {
            border: none;
            background: none;
        }
        .tbl-documents {
            width: 97%;
            margin: auto;
            text-align: left
        }

        .drop-zone {
            max-width: 363px;
            height: 86px;
            padding: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            font-weight: 500;
            font-size: 20px;
            cursor: pointer;
            color: #9da7cd;
            border: 2px dashed #5878ac;
            border-radius: 20px;
        }


        #prodocumentstbl {
            table-layout: fixed !important;
        }

        #prodocumentstbl th,
        #prodocumentstbl td {
        overflow: hidden;
        }


        .drop-zone--over {
            border-style: solid;
        }

        .drop-zone__input {
            display: none;
        }

        .drop-zone__thumb {
            width: 100%;
            height: 100%;
            border-radius: 10px;
            overflow: hidden;
            background-color: #cccccc;
            background-size: cover;
            position: relative;
        }

        .drop-zone__thumb::after {
            content: attr(data-label);
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            padding: 5px 0;
            color: #ffffff;
            background: rgba(0, 0, 0, 0.75);
            font-size: 14px;
            text-align: center;
            
        }

        .dropdown-menu > li:hover {
            background-color: #e1e3e9;
            color: #333;
            width: 100% !important;
        }

        .main-menu li:hover > a, nav.main-menu li.active > a, .dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus, .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus, .no-touch .dashboard-page nav.dashboard-menu ul li:hover a, .dashboard-page nav.dashboard-menu ul li.active a {
            color: #656363;
            background: none;
        }
        .filedownload .dropdown-menu {
            left: auto;
            right: 0;
            min-width: 94px;
            max-width: 100px;
        }
            .tbl-documents thead tr th:first-child, .tbl-documents tbody tr td:first-child, .tbl-documents thead tr th:nth-child(2), .tbl-documents tbody tr td:nth-child(2), .tbl-documents thead tr th:nth-child(3), .tbl-documents tbody tr td:nth-child(3) {
                text-align: left;
            }

            .tbl-documents .sm-wid .custom_chckbox label:before {
                margin-right: 0px;
            }

        #pstbl_keyword > table > thead > tr > th:nth-child(1) {
            width: 20%;
        }

        .pad-side-20 {
            padding: 0px 20px;
        }

        .mt-5 {
            margin-top: 5px;
        }

        .mar-0 {
            margin: 0px;
        }

        .mb-10 {
            margin-bottom: 10px;
        }

        .mb-25 {
            margin-bottom: 25px;
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

        #tbodySignOffs, #tbodyPlans, #tbodyCommercials, #tbodyReqSpe, #tbodyDesign, #tbodyStatusRep {
            display: none;
        }
        
        /* Detail view rows should be hidden by default, but shown when detail view is active */
        .detail-view-wrap {
            display: none;
        }

        .modal-body .note-wrap-txt {
            width: 100% !important;
        }

        .bglightgray {
            background: #f5f5f5;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
        }

        .dropdown-menu {
            -webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
            box-shadow: 0 6px 12px rgba(0,0,0,.175);
        }

        .modalpgHead {
            background: #4263c1;
            color: #fff;
            font-family: 'Roboto', sans-serif;
            font-size: 20px;
        }

        .listviewbtn.active, .detailviewbtn.active {
            background: #1359a6;
            color: #fff;
        }

  
        .custom-modal-size {
         width: 800px;
         height: 300px;
        }
        

        .scroll-hover-wrapper {
            max-height: 200px;
            overflow-y: hidden;
            overflow-x: hidden;
        }

        .scroll-hover-wrapper:hover {
            overflow-y: auto;
            overflow-x: auto;
        }

        /* Remove scrollbar for upload files table when 3 or fewer rows */
        #divMainAttachments .scroll-hover-wrapper {
            max-height: none;
            overflow-y: visible;
            overflow-x: visible;
        }

        #divMainAttachments .scroll-hover-wrapper:hover {
            overflow-y: visible;
            overflow-x: visible;
        }

        /* Keep asterisk inline with Document Type header */
        #tblMainFiles th {
            white-space: nowrap !important;
            line-height: 1.2;
        }
        #tblMainFiles th span {
            display: inline !important;
            white-space: nowrap !important;
        }


        #prodocumentstbl th:first-child {
            width: 180px;
        }
        label {
            font-weight: 500;
        }
        
        /* Header Icon Styles */
        .page-header {
          /*  Commented By Madhuri.K On 11-03-2026*/
         /*   background-color: #e7edf0;*/
            padding: 12px 14px;
            margin-bottom: 0;
            display: flex;
            align-items: flex-start;
            border-bottom: 1px solid #e9ecef;
            margin:0px;
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
            width: auto;
        }
        
        #cboProject + .btn.dropdown-toggle {
            height: 32px;
        }
        
        /*Commented and Added by Vaibhav K on 11-03-26 */
        /* Set minimum width for Document Category and Sub Category dropdowns */
     /*   #StdocCategory + .btn.dropdown-toggle,
        #StdocSub + .btn.dropdown-toggle {
            min-width: 280px !important;
        }*/
        /* FIX - constrain dropdown widths in filter row */
        #StdocCategory + .btn.dropdown-toggle,
        #StdocSub + .btn.dropdown-toggle {
            min-width: 140px !important;
            max-width: 100% !important;
            width: 100% !important;
        }


        /* Fix Bootstrap Select picker click area */
        #cboProject + .btn.dropdown-toggle,
        .bootstrap-select .dropdown-toggle {
            pointer-events: auto !important;
            position: relative;
            z-index: 1;
        }
        
/*
        .bootstrap-select {
            width: auto !important;
        }
        */
        /*End of Commented and Added by Vaibhav K on 11-03-26 */

        .bootstrap-select .dropdown-toggle::after {
            pointer-events: none;
        }
        
        .col-sm-9.form-inline.text-end {
            margin-top: 4px;
        }
        
        /* Table column width adjustments */
        #prodocumentstbl {
            table-layout: fixed !important;
            width: 100% !important;
            border-collapse: collapse;
        }
        
        /* Ensure header and data cells have same width */
        #prodocumentstbl thead th:nth-child(4),
        #prodocumentstbl tbody td:nth-child(4) {
            width: 180px !important;
            min-width: 150px !important;
            max-width: 180px !important;
        }

        .table-responsive-custom {
            width: 100%;
            overflow-x: hidden; /* prevent page bottom scrollbar */
            scrollbar-width: none; /* Firefox - hide scrollbar */
            -ms-overflow-style: none; /* IE and Edge - hide scrollbar */
        }

        /* Hide scrollbar but keep scroll functionality for webkit browsers */
        .table-responsive-custom::-webkit-scrollbar {
            display: none; /* Chrome, Safari, Opera */
        }

        /* Simple tabs for Uploaded vs URLs */
        .doc-tabs {
            display: flex;
            gap: 12px;
            border-bottom: 1px solid #e5e7eb;
            margin: -26px 0 12px 0;
            position: relative;
            z-index: 10;
        }
        .doc-tab {
            font-size: 12px;
            padding: 6px 12px;
            border: 1px solid #e5e7eb;
            border-bottom: none;
            background: #f8fafc;
            cursor: pointer;
            border-top-left-radius: 6px;
            border-top-right-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            z-index: 10;
            pointer-events: auto !important;
            user-select: none;
        }
        .doc-tab.active {
            background: #ffffff;
            font-weight: 600;
        }
        .doc-tab .badge {
            background: #ffffff;
            color: #1e40af;
            border: 1px solid #1e40af;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 17px;
            height: 16px;
            line-height: 22px;
            font-size: 8px;
            font-weight: 600;
            pointer-events: none;
            padding: 0;
        }

        /* Add spacing between tabs */
        #divmaindocheader .main_graybgtbs li {
            margin-right: 2px;
        }
        #divmaindocheader .main_graybgtbs li:last-child {
            margin-right: 0;
        }
        
     input#sercdeltsk{
            outline: none;
            border: 1px solid #ddd;
        }
        
        /* Document Sub Category column */
        #prodocumentstbl th:nth-child(2),
        #prodocumentstbl td:nth-child(2) {
            width: 12%;
        }

        /* URL column - reduced width */
        #urlstable th:nth-child(3),
        #urlstable td:nth-child(3) {
            width: 24% !important;
            max-width: 200px !important;
            white-space: normal !important;
            word-wrap: break-word !important;
            overflow-wrap: break-word !important;
        }
        
        /* URL links in table */
        #urlstable td:nth-child(3) a {
            word-break: break-all;
            display: inline-block;
            max-width: 100%;
        }
        
        /* Attached URLs Description column - Fixed width */
        #urlstable th:nth-child(4),
        #urlstable td:nth-child(4) {
            width: 150px !important;
            max-width: 150px !important;
            min-width: 150px !important;
            padding: 8px 12px !important;
        }
        
        /* Attached URLs description truncation with tooltip */
        #urlstable td:nth-child(4) {
            position: relative;
        }
        
        /* Ensure the span inside td has fixed width with ellipsis */
        #urlstable td:nth-child(4) span.desc-ellipsis {
            width: 100% !important;
            max-width: 100% !important;
            display: inline-block;
            white-space: nowrap !important;
            overflow: hidden !important;
            text-overflow: ellipsis !important;
            cursor: default;
        }
        
        /* Document Name (Latest) column - Increased width with text wrapping */
        #prodocumentstbl th:nth-child(3),
        #prodocumentstbl td:nth-child(3) {
            width: 18%;
            white-space: normal !important;
            word-wrap: break-word;
            overflow-wrap: break-word;
            line-height: 1.4;
        }
        
        /* Uploaded By column - Fixed width for header and cells */
        #prodocumentstbl th:nth-child(4),
        #prodocumentstbl td:nth-child(4) {
            width: 180px !important;
            min-width: 150px !important;
            max-width: 180px !important;
            white-space: normal !important;
            word-wrap: break-word !important;
            overflow-wrap: break-word !important;
            line-height: 1.4;
            overflow: hidden !important;
            box-sizing: border-box !important;
        }
        
        /* Ensure header specifically matches */
        #prodocumentstbl thead th:nth-child(4) {
            width: 180px !important;
            max-width: 180px !important;
        }
        
        /* Ensure data cells match header */
        #prodocumentstbl tbody td:nth-child(4) {
            width: 180px !important;
            max-width: 180px !important;
        }
        
        /* Upload Date column */
        #prodocumentstbl th:nth-child(5),
        #prodocumentstbl td:nth-child(5) {
            width: 10%;
        }
        
        /* Size (KB) column */
        #prodocumentstbl th:nth-child(6),
        #prodocumentstbl td:nth-child(6) {
            width: 8%;
        }
        
        /* Last Modified column */
        #prodocumentstbl th:nth-child(7),
        #prodocumentstbl td:nth-child(7) {
            width: 9%;
        }
        
        /* Actions column */
        #prodocumentstbl th:nth-child(8),
        #prodocumentstbl td:nth-child(8) {
            width: 7%;
            text-align: center;
        }
        
        /* Checkbox column - ensure visibility */
        #prodocumentstbl th:nth-child(9),
        #prodocumentstbl td:nth-child(9) {
            width: 50px;
            min-width: 40px;
            text-align: center;
            padding: 6px 4px !important;
            overflow: visible !important;
        }
        
        /* Ensure checkbox doesn't take extra space */
        #prodocumentstbl th:nth-child(9).sm-wid,
        #prodocumentstbl td:nth-child(9) .custom_chckbox {
            
            min-width: 20px;
            max-width: 25px;
        }
        
        #prodocumentstbl .custom_chckbox input[type="checkbox"] {
            width: 16px;
            height: 16px;
        }
        
        /* Uploaded By column styling */
        .uploaded-by-cell {
            display: flex;
            align-items: flex-start;
            gap: 8px;
            padding: 8px 12px !important;
            overflow: hidden !important;
            word-wrap: break-word !important;
            white-space: normal !important;
            max-width: 100% !important;
            width: 100% !important;
            box-sizing: border-box !important;
            min-width: 0 !important;
        }
        
        .user-avatar {
            width: 32px;
            height: 32px;
            min-width: 32px;
            border-radius: 50%;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            overflow: hidden;
            border: none;
            outline: none;
            box-shadow: none;
            margin-top: 2px; /* Align with first line of text */
        }
        
        .user-avatar * {
            border: none !important;
            outline: none !important;
        }
        
        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .user-avatar-placeholder {
            color: #9ca3af;
            font-size: 16px;
        }
        
        .user-avatar-placeholder i {
            opacity: 0.5;
        }
        
        .user-name {
            font-size: 14px;
            font-weight: 400;
            word-wrap: break-word !important;
            overflow-wrap: anywhere !important;
            word-break: break-all !important;
            line-height: 1.4;
            white-space: normal !important;
            overflow: hidden !important;
            flex: 1 1 auto;
            min-width: 0 !important;
            max-width: calc(100% - 40px) !important;
            display: block !important;
            hyphens: auto;
        }
        
        /* Ensure table cell allows wrapping */
        #prodocumentstbl td.uploaded-by-cell {
            overflow: hidden !important;
            text-overflow: clip !important;
            border: none !important;
            background-color: transparent !important;
            white-space: normal !important;
            word-wrap: break-word !important;
            overflow-wrap: break-word !important;
            padding: 8px 12px !important;
            vertical-align: top !important;
            width: 180px !important;
            max-width: 180px !important;
        }
        
        /* Force DataTables to respect column width */
        #prodocumentstbl th.uploaded-by-column,
        #prodocumentstbl td.uploaded-by-column {
            width: 180px !important;
            max-width: 180px !important;
            min-width: 150px !important;
        }
        
        /* Document Category Header Row */
        .category-header-row {
            background-color: #9ca3af !important;
            font-weight: 500;
            color: #ffffff;
            font-size: 14px;
        }
        
        .category-header-row td {
            padding: 4px 12px !important;
            border: 1px solid #6b7280;
            text-align: left !important;
            /*background-color: #9ca3af !important;*/
            /*color: #ffffff !important;*/
            overflow: visible !important;
            white-space: nowrap !important;
        }
        
        .category-header-row td[colspan] {
            width: 100% !important;
            display: table-cell !important;
        }

        /* Ensure full-width background across bordered tables */
        table.table-bordered > tbody > tr.category-header-row > td {
            border-left-width: 0;
            border-right-width: 0;
        }
        
        .category-header-row td:first-child {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        /* Category Icon Circle */
        .category-icon {
            width: 28px;
            height: 28px;
            /*min-width: 32px;*/
            border-radius: 50%;
            background-color: #2e52a3;
            color: white;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 600;
            vertical-align: middle;
            margin-right: 12px;
        }

        .category-header-row td span {
            display: inline-block;
            vertical-align: middle;
        }
        
        /* Alternating row colors for documents within categories */
        #prodocumentstbl tbody tr:not(.category-header-row):nth-child(even) {
            background-color: #fafbfc;
        }
        
        #prodocumentstbl tbody tr:not(.category-header-row):nth-child(odd) {
            background-color: #ffffff;
        }
        
        /* Force dropdowns to drop down instead of up */
        .bootstrap-select .dropdown-menu {
            transform: none !important;
            bottom: auto !important;
            top: 100% !important;
        }
        
        /* Ensure modal has enough space for dropdowns */
        .modal {
            overflow: visible !important;
        }
        
        .modal-body {
            overflow: visible !important;
        }
        
        /* Detail view wrap styling */
        .detail-view-wrap {
            background-color: #f5f5f5 !important;
        }
        
        /* Mandatory note styling for offcanvas */
        .mandatory-note {
            color: #6c757d;
            font-size: 14px;
            margin-top: 10px;
            text-align: right;
            margin-right: 8px;
        }
        
        .mandatory-note small {
            font-size: 14px;
        }
        
        /* Pagination styling - Added to match PM_SCM.aspx */
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
        .custom-search {
    outline: none;
    border: 1px solid #ddd;
}

.custom-search:focus {
    outline: none;
    box-shadow: none; /* removes bootstrap focus glow */
    border-color: #ddd;
}

/*Added by Vaibhav K on 11-03-26 for fixing the issues of hidden text on hover*/ 
#ClearAllFilter {
    color: #1359a6 !important;
    background-color: transparent !important;
    border-color: #1359a6 !important;
}

#ClearAllFilter:hover {
    color: #ffffff !important;
    background-color: #1359a6 !important;
    text-decoration: none !important;
    border-color: #1359a6 !important;
}
/*End of Added by Vaibhav K on 11-03-26 for fixing the issues of hidden text on hover*/


/*Added by Vaibhav K on 11-03-26 for adding cross close button*/
/* Offcanvas header × close button */
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
    font-size: 14px;
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
/*End of Added by Vaibhav K on 11-03-26 for adding cross close button*/ 


/*Added by Vaibhav K on 11-03-26 for loader*/
/* Fullscreen loader overlay */
.loader-overlay {
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    width: 100%; height: 100%;
    background-color: transparent;
    z-index: 2000;
}
/* Centered loader GIF */
.loader-overlay .loader {
    position: absolute;
    top: 50%; left: 50%;
    width: 100px; height: 100px;
    margin: -50px 0 0 -50px;
    background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
}
/* Initial page-load preloader */
.preloader {
    position: fixed;
    top: 50%; left: 50%;
    width: 100px; height: 100px;
    margin: -50px 0 0 -50px;
    background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    z-index: 2100;
}

/*End of Added by Vaibhav K on 11-03-26 for loader*/


    </style>

</head>

<body class="bgwhite">


    <div id="PMDocsSec" class="preloader"></div>

    <!-- Page Loader -->
    <div class="loader-overlay" id="loaderOverlay" style="display: none;">
        <div class="loader"></div>
    </div>

     <!-- Added by Nischal C on 3/11/2025 for the Role Access -->
     <% If m_blnViewAccess Then %>
     <!-- End of added by Nischal C on 3/11/2025 for the Role Access -->

    <div class="bgwhite">
        <!--ps_list_table_start-->
        <div class="tab-pane pstbl_documents pt-0 active clearfix" id="pstbl_documents">
            <!-- Page Header with Icon -->
            <div class="graybg page-header">
                <div class="header-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="header-content">
                    <h5 class="page-title"><%=MyBase.GetResourceString("C_Docs")%></h5>
                    <p class="page-subtitle"><%=MyBase.GetResourceString("C_DocsDesc")%></p>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class=" container-fluid pt-1 pb-1 statckmainheader clearfix">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="project-section">
                            <label for="cboProject" style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0; margin-right: 0.5rem; white-space: nowrap;"><%=MyBase.GetResourceString("C_SelectProject")%></label>
                            <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,,) %>
                        </div>
                    </div>
                    <input type="hidden" id="hdnUniqueID" value="<%= Request.QueryString("UniqueID") %>" />
                    <div class="col-sm-9 form-inline text-end">
                        <a class="btn borderbtn mr-5 listviewbtn active" id="listView"><%=MyBase.GetResourceString("C_LView")%></a>
                        <a class="btn borderbtn mr-5 detailviewbtn " id="detailView"><%=MyBase.GetResourceString("C_DView")%></a>
                        <% If m_blnAddAccess Then %>
                        <a class="btn borderbtn mr-5" data-bs-toggle="offcanvas" data-bs-target="#uploadDocOffScreen"><%=MyBase.GetResourceString("C_UplDoc")%></a>
                        <a class="btn borderbtn mr-5" data-bs-toggle="offcanvas" data-bs-target="#AttachURLOffScreen" onclick="loadDocCategory(null,true)"><%=MyBase.GetResourceString("C_AttURL")%></a>
                        <% End If %>
                        <% If m_blnDeleteAccess Then %>
                        <a id="delete-row" class="btn borderbtn" onclick="deletDocument()" ><%=MyBase.GetResourceString("C_Delete")%></a>
                        <% End If %>
                    </div>
                </div>
            </div>


            <div class="pt-1 pb-1 bglightgray">
                <div class="row mx-1">
                    <div class="col-sm-3">
                        <label><%=MyBase.GetResourceString("C_DocName")%></label>
                        <input type="text" name="docName" class="form-control" id="docName" placeholder="Enter Document Name">
                    </div>
                    <div class="col-sm-3">
                        <label><%=MyBase.GetResourceString("C_DocCategory")%></label>
                        <div class="custom-dropdown">
                            <select id="StdocCategory" class="form-control selectpicker" <%--title="Document Category"--%> data-live-search="true" onchange="loadSubDocCategory(this.value, null)">
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <label><%=MyBase.GetResourceString("C_SDocCategory")%></label>
                        <div class="custom-dropdown">
                            <select id="StdocSub" class="form-control selectpicker" <%--title="Select Document Sub Category"--%> data-live-search="true">
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <label>&nbsp;</label>
                        <div class="d-flex justify-content-start gap-2" style="align-items: flex-start; margin-top: 0;">
                            <a href="javascript:;" class="btn btnyellow" id="showClick" onclick="fetchAllDocuments()" style="display: inline-flex; align-items: center;"><%=MyBase.GetResourceString("C_Show")%></a>
                            <a href="javascript:;" class="btn borderbtn clearalllink" id="ClearAllFilter" onclick="clearFilters()" style="color: #1359a6; text-decoration: none; font-size: 11.5px; font-weight: 500; display: none; margin: 0;"><strong><%=MyBase.GetResourceString("C_Clear")%></strong></a>                     
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="content mb-10">

                <div class="row">
                    <div class="col-sm-9"></div>
                    <div class="col-sm-3 text-end">
                        <div class="input-group" style="">
<%--                            <%=CommonFunctions.HTMLControls.DrawTextBox("sercdeltsk", "sercdeltsk", "form-control input-sm searchbtn", , 50, , , , False, False, ToBeInserted:="placeholder='" & MyBase.GetResourceString("C_SearchDocument") & "'", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%> --%>
                            <input id="sercdeltsk" type="text" placeholder="<%=MyBase.GetResourceString("C_SearchDocument")%>" class="form-control input-sm">
                            <div class="input-group-btn">
                                <button class="btn btn-default" type="button" id="searchButton" style="height:30px;"><i class="fas fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="divmaindocheader" class="mainreview_toprow container-fluid" style="background: #ffffff;">
                    <div class="row">
                        <div class="col-sm-8" style="margin-top: -32px;margin-left: -14px;">
                            <ul class="nav nav-tabs main_graybgtbs float-start pt-1 pb-1">
                                <li class="active" id="liTabUploaded">
                                    <a href="javascript:;" id="tabUploaded" onclick="switchDocTab('uploaded')" aria-expanded="false"><%=MyBase.GetResourceString("C_UploadedDocuments")%></a>
                                </li>
                                <li class="" id="liTabUrls">
                                    <a href="javascript:;" id="tabUrls" onclick="switchDocTab('urls')" aria-expanded="false"><%=MyBase.GetResourceString("C_AttachedURLs")%></a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-sm-4">
                            <div class="toprightactions">
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="containerUploaded">
                    <div class="table-responsive-custom" style="height: 500px; overflow-y: auto;">
                        <table id="prodocumentstbl" class="table table-bordered">
                            <thead style="position: sticky; top: -2px; z-index: 5; background-color: #e7edf0;">
                                <tr>
                                    <th class="col-w-2"><%=MyBase.GetResourceString("C_DocCate")%></th>
                                    <th class="col-w-2"><%=MyBase.GetResourceString("C_DocSubCate")%></th>
                                    <th class="col-w-3"><%=MyBase.GetResourceString("C_DocuName")%></th>
                                    <th class="col-w-2"><%=MyBase.GetResourceString("C_UploadedBy")%></th>
                                    <th class="col-w-1"><%=MyBase.GetResourceString("C_UploadDate")%></th>
                                    <th class="col-w-1"><%=MyBase.GetResourceString("C_SizeKB")%></th>
                                    <th class="col-w-2"><%=MyBase.GetResourceString("C_LastModified")%></th>
                                    <th class="col-w-1"><%=MyBase.GetResourceString("C_Actions")%></th>
                                    <% If m_blnDeleteAccess Then %>
                                    <th class="col-w-1 sm-wid">
                                        <div class="custom_chckbox">
                                            <%= CommonFunctions.HTMLControls.DrawCheckBox("docSltAll", "docSltAll", "chckHead", , , , returnHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>
                                            <label for="docSltAll"></label>
                                        </div>
                                    </th>
                                    <% End If %>
                                </tr>
                            </thead>
                            <tbody id="tbodyReqSpe"></tbody>
                        </table>
                    </div>
                </div>

                <div id="containerUrls" style="display: none;">
                    <div class="table-responsive-custom">
                        <table id="urlstable" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th class="col-w-2"><%=MyBase.GetResourceString("C_DocCate")%></th>
                                    <th class="col-w-2"><%=MyBase.GetResourceString("C_DocSubCate")%></th>
                                    <th class="col-w-3"><%=MyBase.GetResourceString("C_URL")%></th>
                                    <th class="col-w-3"><%=MyBase.GetResourceString("C_Description")%></th>
                                    <th class="col-w-2"><%=MyBase.GetResourceString("C_UploadedBy")%></th>
                                    <th class="col-w-1"><%=MyBase.GetResourceString("C_UploadDate")%></th>
                                    <% If m_blnDeleteAccess Then %>
                                    <th class="col-w-1 sm-wid">
                                        <div class="custom_chckbox">
                                            <%= CommonFunctions.HTMLControls.DrawCheckBox("urlSltAll", "urlSltAll", "chckHead", , , , returnHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>
                                            <label for="urlSltAll"></label>
                                        </div>
                                    </th>
                                    <% End If %>
                                </tr>
                            </thead>
                            <tbody id="tbodyUrls"></tbody>
                        </table>
                    </div>
                </div>


            </div>

            <!-- Pagination -->
            <div class="pagination-container">
                <div class="pagination-info" id="paginationInfo">
                                                                                  <span class="spntotal"><%=MyBase.GetResourceString("C_TotalRecords")%></span>
                    <span class="spntotal" id="totalRecords">0</span>
                </div>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                         <li class="page-item" id="btnprevious">
                             <a class="page-link" aria-label="<%=MyBase.GetResourceString("C_Previous")%>" onclick="goToPreviousPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_PreviousPage")%>" id="LinkPrevious">
                                 <i class="fas fa-angle-double-left"></i>
                             </a>
                         </li>
                         <li class="page-item" id="btnnext">
                             <a class="page-link" aria-label="<%=MyBase.GetResourceString("C_Next")%>" onclick="goToNextPage()" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_NextPage")%>" id="LinkNext">
                                 <i class="fas fa-angle-double-right"></i>
                             </a>
                         </li>
                    </ul>
                </nav>
            </div>
            
           

            <!--Page modal start here-->
            <!--Upload document offcanvas start here-->
            <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
                 id="uploadDocOffScreen" aria-labelledby="uploadDocOffScreen">
                <div class="offcanvas-body">
                    <div class="container-fluid py-2 graybg mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-12">
                                <div class="d-flex align-items-center font-weight-600">
                                    <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_UplDoc")%></h5>
                                    <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="<%=MyBase.GetResourceString("C_Close")%>">&#x2715;</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-sm-12">
                            <div class="nextBtnDiv d-flex justify-content-end gap-2">
                               
                 <%--Commented and added  by Vaibhav to hide close button and show upload button instead on 11-03-26--%>
                                
                                <%--<button type="button" class="btn borderbtn" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                    <%=MyBase.GetResourceString("C_Close")%>
                                </button>--%>
                                                    
            <button id="uploadDocBtn" class="btn btnyellow" onclick="uploadDocument()"><%=MyBase.GetResourceString("C_Upload")%></button>
                 <%--End of Commented and added  by Vaibhav to hide close button and show upload button instead on 11-03-26--%>
       
                            </div>
                        </div>
                    </div>

                    <div class="note-wrap note-wrap-txt mar-0 mb-10">
                        <p><strong>Note :</strong> <%=MyBase.GetResourceString("C_NoteMaxThreeFiles")%></p>
                    </div>
                    <div class="form-group row justify-content-center">
                        <div class="col-sm-12 drop-zone form-group m-3">
                            <span class="drop-zone__prompt"><%=MyBase.GetResourceString("C_DropFileHere")%></span>
                            <%--<input type="file" class="drop-zone__input" id="doc_dragdrop">--%>
                            <input type="file" id="doc_dragdrop" class="drop-zone__input" multiple style="display: none;">
                        </div>
                    </div>

                    <!-- Attachments section -->
                    <div id="divMainAttachments" class="bottom-bar" style="display: none;">
                        <div class="row">
                            <div class="col-sm-12 table-responsive scroll-hover-wrapper">
                                <table id="tblMainFiles" class="clsGridTable table table-bordered" style="margin-top: 1%">
                                    <thead class="clsTRColumnHeader" align="left">
                                        <tr>
                                            <th width="5%"><%=MyBase.GetResourceString("C_SrNo")%></th>
                                            <th width="20%"><%=MyBase.GetResourceString("C_Files")%></th>
                                            <th width="21%" style="white-space: nowrap;"><%=MyBase.GetResourceString("C_DocumentType")%> <span style="color:red; display: inline;">*</span></th>
                                            <th width="21%"><%=MyBase.GetResourceString("C_DocumentSubType")%></th>
                                            <%--<th width="18%"><%=MyBase.GetResourceString("C_ChangeRequest")%></th>--%>
                                            <th width="27%"><%=MyBase.GetResourceString("C_Comments")%></th>
                                            <th width="5%"><%=MyBase.GetResourceString("C_Remove")%></th>
                                        </tr>
                                    </thead>
                                    <tbody id="bodyMainFiles">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                 <%--Commented  by Vaibhav to hide close button button 11-03-26--%>

                    <<%--div class="row">
                        <div class="col-sm-12 text-center">
                            <button data-bs-dismiss="offcanvas" class="btn borderbtn" id="cnlID"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            <button id="uploadDocBtn" class="btn btnyellow" onclick="uploadDocument()"><%=MyBase.GetResourceString("C_Upload")%></button>
                        </div>
                    </div>--%>
                 <%--End of ommented  by Vaibhav to hide close button button 11-03-26--%>              
                        <div class="clearfix"></div>
                </div>
            </div>
            <!--Upload document offcanvas end here-->
            <!--Page modal end here-->
            <!--delete info modal start here-->
            <div id="deleteinfomodal" class="modal fade custmodal" tabindex="-1" role="dialog" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog modalsmall ui-draggable">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header ui-draggable-handle">
                            <button type="button" class="close" id="btnConfirmTaskNo1" data-bs-dismiss="modal">×</button>
                            <h4 class="modal-title"><%=MyBase.GetResourceString("C_Delete")%></h4>
                        </div>

                        <div class="modal-body">
                            <p align="center" id="ConfirmationMsg"><%=MyBase.GetResourceString("A_ConfirmDeleteDocuments")%></p>
                                    </div>
                        <div class="modal-footer">
                            <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnConfirmTaskNo"><%=MyBase.GetResourceString("C_No")%></button>
                            <button class="btn btnyellow" data-bs-dismiss="modal" id="btnConfirmTaskYes"><%=MyBase.GetResourceString("C_Yes")%></button>
                            <div class="clearfix"></div>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <!--delete info modal end here-->
            <!-- Attach url Offcanvas Section starts -->
            <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
                 id="AttachURLOffScreen" aria-labelledby="AttachURLOffScreen">
                <div class="offcanvas-body">
                    <div class="container-fluid py-2 graybg mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-12">
                                <div class="d-flex align-items-center font-weight-600">
                                    <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_AttURL")%></h5>
                                     <%--Added by Vaibhav K on 11-03-26  for addiing cross icon for close--%>
                                    <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="<%=MyBase.GetResourceString("C_Close")%>">&#x2715;</button>
                                     <%--End of Added by Vaibhav K on 11-03-26  for addiing cross icon for close--%>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="Doc_reviewTab" class="Doc_reviewInfo">
                        <div class="row mb-2">
                            <div class="col-sm-12">
                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                    <button class="btn btnyellow" id="attachUrlbtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_AttURL")%>" onclick="Attach_OnClick()"><%=MyBase.GetResourceString("C_AttURL")%></button>
                                   
                                    <%--Commented by Vaibhav K on 11-03-26 for  hiding close button--%>
                                   <%-- <button class="btn borderbtn" type="button" id="cnl_Attach" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                        <%=MyBase.GetResourceString("C_Close")%>
                                    </button>--%>
                                    <%--End of Commented by Vaibhav K on 11-03-26 for  hiding close button--%>

                                </div>
                                <div class="mandatory-note">
                                    <small>(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</small>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mb-3">
                            <div class="col-sm-10">
                                <div class="row">
                                    <label class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_EnterURL")%> <sup style="color: red; font-size: 0.7em; line-height: 0;">*</sup> <small><%=MyBase.GetResourceString("C_NoteCompleteURL")%></small></label>
                                    <%--<div class="col-sm-6"> <%=CommonFunctions.HTMLControls.DrawTextBox("txtURL", "txtURL", "form-control", , 200, , , , False, False, ToBeInserted:="required", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%></div>--%>
                                    <div class="col-sm-7"> <input type="text" name="" class="form-control" id="txtURL" required maxlength ="200"></div>
                                </div>
                            </div>
                        </div>   
                        <div class="form-group row mb-3">
                            <div class="col-sm-10">
                                <div class="row mb-3">
                                    <div class="col-sm-4 text-end" style="position: relative;">
                                        <label><%=MyBase.GetResourceString("C_DocCategory")%></label>
                                        <div style="position: absolute; top: 0; right: 0;"><sup style="margin-right: 7px;color: red; font-size: 0.7em;">*</sup></div>
                                    </div>
                                    <div class="col-sm-8 custom-dropdown">
                                        <select class="selectpicker form-control" aria-label="<%=MyBase.GetResourceString("C_SelectDocumentCategory")%>" data-live-search="true" id="cboAttachCate"  onchange="loadSubDocCategory(this.value, null, null, true)" required>
                                            <option value="0"><%=MyBase.GetResourceString("C_SelectDocumentCategory")%></option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="form-group row mb-3">
                            <div class="col-sm-10">
                                <div class="row mb-3">
                                    <label class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_SDocCategory")%></label>
                                    <div class="col-sm-8 custom-dropdown">
                                        <select class="selectpicker form-control" aria-label="<%=MyBase.GetResourceString("C_SelectSubCategory")%>" data-live-search="true" id="cboAttachSubCate">
                                            <option value="0"><%=MyBase.GetResourceString("C_SelectSubCategory")%></option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="form-group row mb-3">
                            <div class="col-sm-10">
                                <div class="row mb-3">
                                    <label class="col-sm-4 text-end"><%=MyBase.GetResourceString("C_Description")%> <sup style="color: red; font-size: 0.7em; line-height: 0;">*</sup></label>
                                    <div class="col-sm-8">
                                        <%--<%=CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , "form-control", , "form-control", "", , , , 2000,,,,,,,, "required", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>--%>
                                        <textarea class="form-control fixed-textarea2" maxlength ="3000" id="txtDescription" MaxLength="2000" required ></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Attach url Offcanvas Section ends -->
                <!-- Document History Offcanvas Section starts -->
 
                <!-- Document History Offcanvas Section ends -->

            </div>
            <!--ps_list_table_end-->
        </div>
        <div class="clearfix"></div>

                <!-- offcanvas Section Start Here-->
                <div class="offcanvas offcanvas-end NOI-offcanvas" data-bs-scroll="true" tabindex="-1"
                id="offcanvas_Tools" aria-labelledby="offcanvas_Tools">
                <div class="offcanvas-body">
                    <div class="container-fluid py-2 graybg mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-12">
                                <div class="d-flex align-items-center font-weight-600">
                                   <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_DocumentHistory")%></h5>
                                      <%--Added by Vaibhav K on 11-03-26  for addiing cross icon for close--%>
                                     <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="<%=MyBase.GetResourceString("C_Close")%>">&#x2715;</button>
                                      <%--End of Added by Vaibhav K on 11-03-26  for addiing cross icon for close--%>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="CityEdtTab" class="CityInfo">
                        <div class="row mb-2">
                            <div class="col-sm-6">&nbsp;</div>
                            <div class="col-sm-6">
                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                      <%--Commented by Vaibhav to hide close button on 11-03-26--%>
                                    <%--<button class="btn borderbtn" type="button" id="closeCityBtn" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                        <%=MyBase.GetResourceString("C_Close")%>
                                    </button>--%>
                                  <%--Commented by Vaibhav to hide close button on 11-03-26--%>
                                
                                </div>
                            </div>
                        </div>
                        <div class="CityEdtInfo">
                            <div id="historyClassic"></div>
                            <div class="addCGContent">
                                <table class="table table-stripped" id="HisID" style="display:none;">
                                    <thead>
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_Category")%></th>
                                            <th><%=MyBase.GetResourceString("C_UploadDate")%></th>
                                            <th><%=MyBase.GetResourceString("C_FileName")%></th>
                                            <th><%=MyBase.GetResourceString("C_UploadedBy")%></th>
                                            <th><%=MyBase.GetResourceString("C_LastModified")%></th>
                                            <th><%=MyBase.GetResourceString("C_Description")%></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="HisIDbody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
           </div>

                <div class="offcanvas offcanvas-end NOI-offcanvas offcanvas-55" data-bs-scroll="true" tabindex="-1"
                id="Doc_reviewOffScreen" aria-labelledby="Doc_reviewOffScreen">
                <div class="offcanvas-body">
                    <div class="container-fluid py-2 graybg mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-12">
                                <div class="d-flex align-items-center font-weight-600">
                                    <!-- Modified By Madhuri.K On 02-04-2026 --> 
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_DocumentReview")%></h5>
                                            <%--Added by Vaibhav K on 11-03-26  for addiing cross icon for close--%>

                                     <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" title="<%=MyBase.GetResourceString("C_Close")%>">&#x2715;</button>
                                         <%--Added by Vaibhav K on 11-03-26  for addiing cross icon for close--%>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="Doc_reviewTab" class="Doc_reviewInfo">
                        <div class="row mb-2">
                            <div class="col-sm-6">&nbsp;</div>
                            <div class="col-sm-6">
                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                    <%--Added by Vishal Mane on 15/01/2026 to fix Role Access Issue--%>
                                    <% If m_blnEditAccess Then %>
                                    <button class="btn btnyellow" id="svDoc_review" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Save")%>" onclick="UpdshowReview()"><%=MyBase.GetResourceString("C_Save")%></button>
                                    <%End If %>
                                    <%--End of Added by Vishal Mane on 15/01/2026 to fix Role Access Issue--%>
                                   
                                        <%--Commented by Vaibhav K on 11-03-26 for  hiding close button--%>

                                   <%-- <button class="btn borderbtn" type="button" id="closeDoc_review" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                        <%=MyBase.GetResourceString("C_Close")%>
                                    </button>--%>
                                        <%--End of Commented by Vaibhav K on 11-03-26 for  hiding close button--%>
                                
                                </div>
                            </div>
                        </div>

                        <div class="row ">
                            <div class="col-sm-12 text-end">
                                <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <label class="col-sm-3 required"><%=MyBase.GetResourceString("C_ReviewComments")%></label>
                                    <div class="col-sm-6">
                                        <%--<%=CommonFunctions.HTMLControls.DrawTextArea("commentID", "commentID", , "form-control", , "form-control", "", , , , 500,,,,,,,, "rows='2'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>--%>
                                        <textarea class="form-control fixed-textarea" rows="2" id="commentID"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
           </div>

       <!-- offcanvas Section End Here-->
    </div>

    <!-- Added by Nischal C on 3/11/2025 else condition for role access -->
    <% Else %>
    <div style="text-align:center;overflow: auto;width: 100%;;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>
    <% End If %>
    <!-- End of added by Nischal C on 3/11/2025 else condition for role access -->
             
    <script>

        //Added by Vaibhav K on 11-03-26 for loader
        // Loader state
        var loaderShown = false;
        var loaderStartTime = 0;

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
        //End of Added by Vaibhav K on 11-03-26 for loader 

                $(function () {
                    $('[data-bs-toggle="tooltip"]').tooltip();
                });

  /**************************script for drag and drop file*********************************/

                function initializeDragAndDrop() {
                    document.querySelectorAll(".drop-zone__input").forEach((inputElement) => {
                        if (inputElement.hasAttribute('data-dragdrop-initialized')) {
                            return;
                        }
                        inputElement.setAttribute('data-dragdrop-initialized', 'true');
                        
                        const dropZoneElement = inputElement.closest(".drop-zone");
                        if (!dropZoneElement) {
                            return;
                        }

                        dropZoneElement.addEventListener("click", (e) => {
                            inputElement.click();
                        });

                        inputElement.addEventListener("change", (e) => {
                            if (inputElement.files.length) {
                                updateThumbnail(dropZoneElement, inputElement.files[0]);
                            }
                        });

                        dropZoneElement.addEventListener("dragover", (e) => {
                            e.preventDefault();
                            dropZoneElement.classList.add("drop-zone--over");
                        });

                        ["dragleave", "dragend"].forEach((type) => {
                            dropZoneElement.addEventListener(type, (e) => {
                                dropZoneElement.classList.remove("drop-zone--over");
                            });
                        });

                        dropZoneElement.addEventListener("drop", (e) => {
                            e.preventDefault();
                            e.stopPropagation();

                            if (e.dataTransfer.files.length) {
                                const filesArray = Array.from(e.dataTransfer.files);
                                
                                if (typeof DataTransfer !== 'undefined') {
                                    try {
                                        const dataTransfer = new DataTransfer();
                                        filesArray.forEach(file => {
                                            dataTransfer.items.add(file);
                                        });
                                        inputElement.files = dataTransfer.files;
                                        
                                        $(inputElement).trigger('change');
                                        
                                        if (filesArray.length > 0) {
                                            updateThumbnail(dropZoneElement, filesArray[0]);
                            }

                            dropZoneElement.classList.remove("drop-zone--over");
                                        return;
                                    } catch (error) {
                                    }
                                }
                                
                                try {
                                    const fileListProxy = {
                                        length: filesArray.length,
                                        item: function(index) { return filesArray[index] || null; }
                                    };
                                    
                                    filesArray.forEach((file, index) => {
                                        fileListProxy[index] = file;
                                    });
                                    
                                    fileListProxy[Symbol.iterator] = function() {
                                        let index = 0;
                                        return {
                                            next: function() {
                                                if (index < filesArray.length) {
                                                    return { value: filesArray[index++], done: false };
                                                }
                                                return { done: true };
                                            }
                                        };
                                    };
                                    
                                    Object.defineProperty(inputElement, 'files', {
                                        value: fileListProxy,
                                        writable: false,
                                        configurable: true
                                    });
                                    
                                    $(inputElement).trigger('change');
                                    
                                    if (filesArray.length > 0) {
                                        updateThumbnail(dropZoneElement, filesArray[0]);
                                    }
                                } catch (error) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileDropNotSupported);
                                }
                            }

                            dropZoneElement.classList.remove("drop-zone--over");
                        });
                    });
                }
                
                $(document).on('shown.bs.offcanvas', '#uploadDocOffScreen', function() {
                    setTimeout(function() {
                        initializeDragAndDrop();
                    }, 100);
                });

                // Added by Nischal C on 3/11/2025 - Update thumbnail preview for file upload
                function updateThumbnail(dropZoneElement, file) {
                    if (!file) {
                        return;
                    }
                    
                    let thumbnailElement = dropZoneElement.querySelector(".drop-zone__thumb");


                    if (!thumbnailElement) {
                        thumbnailElement = document.createElement("div");
                        thumbnailElement.classList.add("drop-zone__thumb");
                       /* dropZoneElement.appendChild(thumbnailElement);*/
                    }

                    /*thumbnailElement.dataset.label = file.name;*/

                    if (file.type && file.type.startsWith("image/")) {
                        const reader = new FileReader();

                        reader.readAsDataURL(file);
                        reader.onload = () => {
                            thumbnailElement.style.backgroundImage = `url('${reader.result}')`;
                        };
                    } else {
                        thumbnailElement.style.backgroundImage = null;
                    }
                }

                // Added by Nischal C on 3/11/2025 - Get Employee Information including EmployeeImage
                function GetEmployeeInformation() {
                        //debugger
                        try {
                            var employeeID = '<%=Session("intLoginID")%>';

                            if (!employeeID || employeeID === "" || employeeID === "0") {
                                return;
                            }

                            employeeID = parseInt(employeeID);

                            if (!employeeID || employeeID === 0) {
                                return;
                            }

                            var requestData = {
                                EmployeeID: employeeID
                            };

                            apiUrl = "/api/DocumentUpload/GetEmployeeInformation";
                            var param = JSON.stringify(requestData);
                            var response = AJAXCallWithResult(apiUrl, param, false);

                            var data = response;

                            if (response && response.data) {
                                data = response.data;
                            }

                            if (data && data.data) {
                                data = data.data;
                            }

                            if (Array.isArray(data) && data.length > 0) {

                                var employee = data[0];

                                var EmployeeID = employee.employeeID || employee.EmployeeID;
                                var EmployeeName = employee.employeeName || employee.EmployeeName;
                                var Role = employee.role || employee.Role;
                                var EmployeeImage = employee.employeeImage || employee.EmployeeImage;
                                var RoleID = employee.roleID || employee.RoleID;

                                var imagePath = "";
                                if (EmployeeImage == "NoImage" || !EmployeeImage || EmployeeImage === "") {
                                    imagePath = "../../../Images/Photo/no-photo.png";
                                } else {
                                    imagePath = "../../../Images/Photo/" + EmployeeImage;
                                }

                                function updateEmployeeImageElements() {
                                    var $employeeImages = $(".EmployeeImage");
                                    var $userImage = $("#UserImage");

                                    try {
                                        if (window.parent && window.parent !== window) {
                                            var $parentEmployeeImages = window.parent.$(".EmployeeImage");
                                            var $parentUserImage = window.parent.$("#UserImage");

                                            if ($parentEmployeeImages.length > 0) {
                                                $employeeImages = $parentEmployeeImages;
                                            }
                                            if ($parentUserImage.length > 0) {
                                                $userImage = $parentUserImage;
                                            }
                                        }
                                    } catch (e) {
                                    }

                                    if ($employeeImages.length > 0) {
                                        $employeeImages.each(function () {
                                            var $img = $(this);
                                            $img.off('error').on('error', function () {
                                                $(this).attr("src", "../../Images/Photo/no-photo.png");
                                            });
                                            $img.attr("src", imagePath);
                                        });
                                    }

                                    if ($userImage.length > 0) {
                                        $userImage.off('error').on('error', function () {
                                            $(this).attr("src", "../../Images/Photo/no-photo.png");
                                        });
                                        $userImage.attr("src", imagePath);
                                    }

                                    return $employeeImages.length > 0 || $userImage.length > 0;
                                }

                                var elementsFound = updateEmployeeImageElements();

                                if (!elementsFound) {
                                    setTimeout(function () {
                                        updateEmployeeImageElements();
                                    }, 1000);

                                    setTimeout(function () {
                                        updateEmployeeImageElements();
                                    }, 3000);
                                }

                                window.currentEmployeeImage = imagePath;
                                window.currentEmployeeName = EmployeeName;
                                window.currentEmployeeRole = Role;

                                updateTableAvatars(imagePath, EmployeeName);

                                if (EmployeeName) {
                                    var $employeeName = $("#EmployeeName");
                                    var $employeeNameRole = $("#EmployeeNameRole");

                                    if ($employeeName.length > 0) {
                                        $employeeName.html(EmployeeName);
                                    }

                                    if ($employeeNameRole.length > 0) {
                                        $employeeNameRole.html(
                                            EmployeeName + "&nbsp;-&nbsp;" + (Role || "")
                                        );
                                    }
                                }
                            }
                        }
                        catch (err) {
                            console.error(err);
                        }
                    }

                $('#tbodyReqSpe').show();
                $("#showClick").click(function showDocCat() {
                    var docValueElement = document.getElementById("docValue");
                    if (!docValueElement) {
                        // Element doesn't exist, skip this function
                        return;
                    }
                    var showCat = docValueElement.value;
                    if (showCat == "Sign offs") {
                        $('.tbodyDocuments').hide();
                        $('#tbodySignOffs').show();
                        return;
                    }
                    else if (showCat == "Plans") {
                        $('.tbodyDocuments').hide();
                        $('#tbodyPlans').show();
                        return;
                    }
                    else if (showCat == "Commercials") {
                        $('.tbodyDocuments').hide();
                        $('#tbodyCommercials').show();
                        return;
                    }
                    else if (showCat == "Requirement Specifications") {
                        $('.tbodyDocuments').hide();
                        $('#tbodyReqSpe').show();
                        return;
                    }
                    else if (showCat == "Design") {
                        $('.tbodyDocuments').hide();
                        $('#tbodyDesign').show();
                        return;
                    }
                    else if (showCat == "Status Reports") {
                        $('.tbodyDocuments').hide();
                        $('#tbodyStatusRep').show();
                        return;
                    }
                });

                var searchDebounceTimer = null;

                // Added by Nischal C on 3/11/2025 - Search documents with debouncing (client-side filtering)
                function myFunction() {
                    if (searchDebounceTimer) {
                        clearTimeout(searchDebounceTimer);
                    }
                    
                    searchDebounceTimer = setTimeout(function() {
                        // Filter client-side without calling API
                        currentPage = 1; // Reset to first page when filtering
                        showPageRows();
                        updatePagination();
                    }, 500);
                }

                $(".listviewbtn").click(function () {
                    $(".detailviewbtn").removeClass("active");
                    $(this).addClass("active");
                });
                $(".detailviewbtn").click(function () {
                    $(".listviewbtn").removeClass("active");
                    $(this).addClass("active");
                });

                // Added by Nischal C on 3/11/2025 - Align DataTables columns
                function dtalign() {
                    setTimeout(function () {
                        try {
                            var tables = $.fn.dataTable.tables({ visible: true, api: true });
                            if (tables && tables.length > 0) {
                                tables.columns.adjust();
                            }
                        } catch (e) {
                        }
                    }, 0);
                }
                // End of addition by Nischal C on 3/11/2025 Align DataTables columns

                function resizeSection() {
                    try {
                    if ($(this).height() <= 800) {
                        $('.dataTables_scrollBody').css('max-height', '150px'); //set max height
                    } else {
                        $('.dataTables_scrollBody').css('max-height', ''); //delete attribute
                        }
                    } catch (e) {
                    }
                }
                $(window).on("load resize scroll", function (e) {
                    resizeSection(this);
                    dtalign(this);
                });            
    </script>


            <script>

                var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
                var UserName = '<%= Session("strUserName") %>';
                let currentProjectID = parseInt('<%= Session("intProjectID")%>');
                var loginType = '<%= Session("LoginType")%>';
                var intUserID = '<%= Session("intUserID") %>';
                var intPostID = '<%= Session("intPostID") %>';
                var unqID = '<%= Request.QueryString("UniqueID") %>';
                var masterTagID = '<%= Request.QueryString("MasterTagID") %>';


                var SpecialCharactersList = '<%= System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString %>';
                var FileContentType = '<%= System.Configuration.ConfigurationManager.AppSettings("FileContentType")%>';
                var ValidateFileExtension = '<%= System.Configuration.ConfigurationManager.AppSettings("ValidateFileExtension")%>';
                var FileExtensionDisallow = '<%= System.Configuration.ConfigurationManager.AppSettings("FileExtensionDisallow")%>';
                var ValidateFileName = '<%= System.Configuration.ConfigurationManager.AppSettings("ValidateFileName")%>';
                var MaxFileSize = '<%= System.Configuration.ConfigurationManager.AppSettings("MaxFileSize")%>';
                var MinFileSize = '<%= System.Configuration.ConfigurationManager.AppSettings("MinFileSize")%>';

                var m_blnAddAccess = <%= m_blnAddAccess.ToString().ToLower()%>;
                var m_blnDeleteAccess = <%= m_blnDeleteAccess.ToString().ToLower()%>;
                var m_blnEditAccess = <%= m_blnEditAccess.ToString().ToLower()%>;
                var m_blnViewAccess = <%= m_blnViewAccess.ToString().ToLower()%>;

                // Resource strings for JavaScript
                var ResourceStrings = {
                    C_TotalRecords: '<%=MyBase.GetResourceString("C_TotalRecords")%>',
                    C_NoCommentsAvailable: '<%=MyBase.GetResourceString("C_NoCommentsAvailable")%>',
                    A_DownloadFailed: '<%=MyBase.GetResourceString("A_DownloadFailed")%>',
                    A_DownloadFailedParseError: '<%=MyBase.GetResourceString("A_DownloadFailedParseError")%>',
                    A_DownloadFailedGeneric: '<%=MyBase.GetResourceString("A_DownloadFailedGeneric")%>',
                    A_ErrorValidatingMimeType: '<%=MyBase.GetResourceString("A_ErrorValidatingMimeType")%>',
                    A_ErrorNoResponseDetailed: '<%=MyBase.GetResourceString("A_ErrorNoResponseDetailed")%>',
                    A_ErrorDirectoryStructureDetailed: '<%=MyBase.GetResourceString("A_ErrorDirectoryStructureDetailed")%>',
                    A_ErrorUploadFailedDetailed: '<%=MyBase.GetResourceString("A_ErrorUploadFailedDetailed")%>',
                    A_ErrorGenericDetailed: '<%=MyBase.GetResourceString("A_ErrorGenericDetailed")%>',
                    A_ErrorGenericSimple: '<%=MyBase.GetResourceString("A_ErrorGenericSimple")%>',
                    A_ErrorGenericWithDetails: '<%=MyBase.GetResourceString("A_ErrorGenericWithDetails")%>',
                    A_ErrorDocumentIDMissing: '<%=MyBase.GetResourceString("A_ErrorDocumentIDMissing")%>',
                    A_ErrorInvalidDocumentID: '<%=MyBase.GetResourceString("A_ErrorInvalidDocumentID")%>',
                    A_ErrorLoadingHistory: '<%=MyBase.GetResourceString("A_ErrorLoadingHistory")%>',
                    A_NoPermissionUpload: '<%=MyBase.GetResourceString("A_NoPermissionUpload")%>',
                    A_NoPermissionDelete: '<%=MyBase.GetResourceString("A_NoPermissionDelete")%>',
                    A_NoPermissionAttachURL: '<%=MyBase.GetResourceString("A_NoPermissionAttachURL")%>',
                    A_PleaseSelectFile: '<%=MyBase.GetResourceString("A_PleaseSelectFile")%>',
                    A_PleaseSelectDocument: '<%=MyBase.GetResourceString("A_PleaseSelectDocument")%>',
                    A_PleaseEnterURL: '<%=MyBase.GetResourceString("A_PleaseEnterURL")%>',
                    A_InvalidURLFormat: '<%=MyBase.GetResourceString("A_InvalidURLFormat")%>',
                    A_URLMustStartWithHttp: '<%=MyBase.GetResourceString("A_URLMustStartWithHttp")%>',
                    A_PleaseSelectCategory: '<%=MyBase.GetResourceString("A_PleaseSelectCategory")%>',
                    A_PleaseEnterDescription: '<%=MyBase.GetResourceString("A_PleaseEnterDescription")%>',
                    A_DescriptionMaxLength: '<%=MyBase.GetResourceString("A_DescriptionMaxLength")%>',
                    A_FileSizeExceeds: '<%=MyBase.GetResourceString("A_FileSizeExceeds")%>',
                    A_InvalidFileExtension: '<%=MyBase.GetResourceString("A_InvalidFileExtension")%>',
                    A_MultipleExtensions: '<%=MyBase.GetResourceString("A_MultipleExtensions")%>',
                    A_FileNameTooLong: '<%=MyBase.GetResourceString("A_FileNameTooLong")%>',
                    A_SpecialCharacterHash: '<%=MyBase.GetResourceString("A_SpecialCharacterHash")%>',
                    A_FileSizeTooSmall: '<%=MyBase.GetResourceString("A_FileSizeTooSmall")%>',
                    A_FileSizeTooLarge: '<%=MyBase.GetResourceString("A_FileSizeTooLarge")%>',
                    A_FilePathTooLong: '<%=MyBase.GetResourceString("A_FilePathTooLong")%>',
                    A_MaxThreeFiles: '<%=MyBase.GetResourceString("A_MaxThreeFiles")%>',
                    A_EmbeddedExecutable: '<%=MyBase.GetResourceString("A_EmbeddedExecutable")%>',
                    A_FileDropNotSupported: '<%=MyBase.GetResourceString("A_FileDropNotSupported")%>',
                    A_PleaseSelectDocumentType: '<%=MyBase.GetResourceString("A_PleaseSelectDocumentType")%>',
                    A_ProjectIDMissing: '<%=MyBase.GetResourceString("A_ProjectIDMissing")%>',
                    A_CategoryMissing: '<%=MyBase.GetResourceString("A_CategoryMissing")%>',
                    A_NoServerResponse: '<%=MyBase.GetResourceString("A_NoServerResponse")%>',
                    A_DirectoryStructure: '<%=MyBase.GetResourceString("A_DirectoryStructure")%>',
                    A_DirectoryPathMissing: '<%=MyBase.GetResourceString("A_DirectoryPathMissing")%>',
                    A_DocumentIDMissing: '<%=MyBase.GetResourceString("A_DocumentIDMissing")%>',
                    A_UploadFailed: '<%=MyBase.GetResourceString("A_UploadFailed")%>',
                    A_AllUploadsFailed: '<%=MyBase.GetResourceString("A_AllUploadsFailed")%>',
                    A_DocumentIDMissingHistory: '<%=MyBase.GetResourceString("A_DocumentIDMissingHistory")%>',
                    A_NotAuthorized: '<%=MyBase.GetResourceString("A_NotAuthorized")%>',
                    A_AllDocumentsUploadedSuccess: '<%=MyBase.GetResourceString("A_AllDocumentsUploadedSuccess")%>',
                    A_DocumentRemovedSuccess: '<%=MyBase.GetResourceString("A_DocumentRemovedSuccess")%>',
                    A_URLAttachedSuccess: '<%=MyBase.GetResourceString("A_URLAttachedSuccess")%>',
                    A_DocumentDeletedSuccess: '<%=MyBase.GetResourceString("A_DocumentDeletedSuccess")%>',
                    A_SelectedURLDeletedSuccess: '<%=MyBase.GetResourceString("A_SelectedURLDeletedSuccess")%>',
                    A_SelectedDocumentDeletedSuccess: '<%=MyBase.GetResourceString("A_SelectedDocumentDeletedSuccess")%>',
                    A_ConfirmDeleteDocuments: '<%=MyBase.GetResourceString("A_ConfirmDeleteDocuments")%>',
                    A_ConfirmDeleteURLs: '<%=MyBase.GetResourceString("A_ConfirmDeleteURLs")%>',
                    A_ReviewCommentShouldNotBeLeftBlank: '<%=MyBase.GetResourceString("A_ReviewCommentShouldNotBeLeftBlank")%>',
                    C_SelectDocumentCategory: '<%=MyBase.GetResourceString("C_SelectDocumentCategory")%>',
                    C_SelectSubCategory: '<%=MyBase.GetResourceString("C_SelectSubCategory")%>',
                    C_SelectChangeRequest: '<%=MyBase.GetResourceString("C_SelectChangeRequest")%>',
                    C_EnterComment: '<%=MyBase.GetResourceString("C_EnterComment")%>',
                    C_Review: '<%=MyBase.GetResourceString("C_Review")%>',
                    C_ShowHistory: '<%=MyBase.GetResourceString("C_ShowHistory")%>'
                };

                // here declared the global variable 
                var CategoryID;
                var SubCategoryID;
                var uniqueIDChangeReTypeID;
                var uniqueIDSubcateID;
                var uniqueIDcateID;
                var strUploadedFileName;
                var fileSizeKB;
                let extension;
                let cleanFileName;
                let selectedFiles = [];
                var reviewDocID;


                var AjaxResult;
                // Added by Nischal C on 3/11/2025 - Build API URL with proper path handling
                function buildUrl(path) {
                    try {
                        var base = strUrl || '';
                        if (!base) return path;
                        var endsWithSlash = base.endsWith('/');
                        var startsWithSlash = (path || '').startsWith('/');
                        if (endsWithSlash && startsWithSlash) return base + path.substring(1);
                        if (!endsWithSlash && !startsWithSlash) return base + '/' + path;
                        return base + path;
                    } catch (e) { return (strUrl || '') + path; }
                }

                function AJAXCallWithResult(url, param, async) {
                    var result = null;
                    
                    var isFormData = param instanceof FormData;
                    
                    $.ajax({
                        url: buildUrl(url),
                        type: "POST",
                        data: param,
                        async: async !== false,
                        dataType: "json",
                        contentType: isFormData ? false : "application/json;charset=utf-8",
                        processData: isFormData ? false : true,
                        cache: isFormData ? false : true,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            xhr.setRequestHeader('Accept', 'application/json');
                            if (param && !isFormData) {
                                xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                            }
                        },
                        success: function (data) {
                            result = data;
                        },
                        error: function (err) {
                            var errorMessage = err.statusText || 'Request failed';
                            var errorData = null;
                            
                            try {
                                if (err.responseText) {
                                    errorData = JSON.parse(err.responseText);
                                    errorMessage = errorData.message || errorData.Message || errorData.error || errorMessage;
                                }
                            } catch (e) {
                                errorMessage = err.responseText || errorMessage;
                            }
                            
                            if (errorData) {
                                result = errorData;
                            } else {
                                result = { error: true, success: false, message: errorMessage, statusCode: err.status };
                            }
                        }
                    });
                    return result;
                }
                // End of addition by Nischal C on 3/11/2025 Build API URL with proper path handling

                // Added by Nischal C on 3/11/2025 - Switch between uploaded documents and URLs tabs
                function switchDocTab(tab, skipReload) {
                    if (tab === 'uploaded') {
                        $('#liTabUploaded').addClass('active');
                        $('#liTabUrls').removeClass('active');
                        $('#containerUploaded').show();
                        $('#containerUrls').hide();
                        $('#sercdeltsk').attr('placeholder', '<%=MyBase.GetResourceString("C_SearchDocument")%>');
                    } else {
                        $('#liTabUrls').addClass('active');
                        $('#liTabUploaded').removeClass('active');
                        $('#containerUrls').show();
                        $('#containerUploaded').hide();
                        $('#sercdeltsk').attr('placeholder', '<%=MyBase.GetResourceString("C_SearchUrl")%>');
                    }
                    
                    $('#docSltAll').prop('checked', false);
                    $('#urlSltAll').prop('checked', false);
                    
                    currentPage = 1;
                    if (!skipReload) {
                        fetchAllDocuments();
                    } else {
                        showPageRows();
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Switch between uploaded documents and URLs tabs

                // Added by Nischal C on 3/11/2025 - Generic function to handle header checkbox click (Select All)
                function handleSelectAllCheckbox(headerCheckboxId, tbodySelector) {
                    if (!m_blnDeleteAccess) {
                        return;
                    }
                    var isChecked = $(headerCheckboxId).prop('checked');
                    $(tbodySelector + " .doc-chck").prop('checked', isChecked);

                    if (isChecked) {
                        getSelectedDocumentIDs();
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Generic function to handle header checkbox click

                // Added by Nischal C on 3/11/2025 - Generic function to handle individual checkbox change
                function handleIndividualCheckboxChange(checkboxElement, tbodySelector, headerCheckboxId) {
                    var total = $(tbodySelector + " .doc-chck").length;
                    var checked = $(tbodySelector + " .doc-chck:checked").length;

                    $(headerCheckboxId).prop('checked', total > 0 && total === checked);

                    if ($(checkboxElement).is(":checked")) {
                        var docId = $(checkboxElement).data("documentid");
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Generic function to handle individual checkbox change

                $(document).ready(function () {
                    //Added by Vaibhav K on 11-03-26 for showing loader 
                    showLoader();     
                    //End of Added by Vaibhav K on 11-03-26 for showing loader 


                    initializeDragAndDrop();
                    GetEmployeeInformation();

                    //Added by Vaibhav K on 11-03-26 for showing loader 
                    $("#PMDocsSec").hide();
                    //End of Added by Vaibhav K on 11-03-26 for showing loader 
                    
                    // Use generic function for document select all checkbox
                    $("#docSltAll").on("click", function () {
                        handleSelectAllCheckbox("#docSltAll", "#tbodyReqSpe");
                    });

                    // Use generic function for URL select all checkbox
                    $("#urlSltAll").on("click", function () {
                        handleSelectAllCheckbox("#urlSltAll", "#tbodyUrls");
                    });

                    // Use generic function for document individual checkboxes
                    $("#tbodyReqSpe").on("change", ".doc-chck", function () {
                        handleIndividualCheckboxChange(this, "#tbodyReqSpe", "#docSltAll");
                    });

                    // Use generic function for URL individual checkboxes
                    $("#tbodyUrls").on("change", ".doc-chck", function () {
                        handleIndividualCheckboxChange(this, "#tbodyUrls", "#urlSltAll");
                    });

                    $("#detailView").click(function () {
                        window.detailViewActive = true;
                     
                        $("#detailView").addClass('active');
                        $("#listView").removeClass('active');
                     
                        fetchAllDocuments();
                    });
                    
                    $("#listView").click(function () {
                        window.detailViewActive = false;
                        
                        $("#listView").addClass('active');
                        $("#detailView").removeClass('active');
                        
                        fetchAllDocuments();
                    });

                    $(document).on('keypress', '#docName', function(e) {
                        if (e.key === 'Enter' || e.keyCode === 13) {
                            e.preventDefault();
                            fetchAllDocuments();
                        }
                    });

                    if (typeof $.fn.selectpicker !== 'undefined') {
                        $('#cboProject').selectpicker({
                            liveSearch: true,
                            liveSearchStyle: 'startsWith',

                            //Added by Vaibhav to show all values of dropdowns on 11-03-26
                              dropupAuto: false,   // prevent auto flip
                            size: 10              // limit visible items to avoid going behind pagination
                            //End of Added by Vaibhav to show all values of dropdowns on 11-03-26

                        });
                        
                        setTimeout(function() {
                            if (currentProjectID && currentProjectID > 0) {
                                var $projectSelect = $('#cboProject');
                                var projectValue = currentProjectID.toString();
                                //Added by Vishal Mane on 20/01/2026 to set default to Select Project 
                                if (projectValue == undefined || projectValue == null) {
                                    projectValue = 0;
                                }
                                //End of Added by Vishal Mane on 20/01/2026 to set default to Select Project 
                                if ($projectSelect.find('option[value="' + projectValue + '"]').length > 0) {
                                    $projectSelect.selectpicker('val', projectValue);
                                }
                            }
                        }, 100);
                    }
                    $('#StdocCategory').selectpicker({
                        liveSearch: true,
                        liveSearchStyle: 'startsWith'
                    });
                    setTimeout(function() {
                        $('#StdocCategory').next('.btn.dropdown-toggle').css('min-width', '200px');
                    }, 100);
                    
                    $('#StdocSub').selectpicker({
                        liveSearch: true,
                        liveSearchStyle: 'startsWith'
                    });
                    setTimeout(function() {
                        $('#StdocSub').next('.btn.dropdown-toggle').css('min-width', '200px');
                    }, 100);
                    
                    function applyMinWidthToDropdowns() {
                        $('#StdocCategory').next('.btn.dropdown-toggle').css('min-width', '200px');
                        $('#StdocSub').next('.btn.dropdown-toggle').css('min-width', '200px');
                    }
                    
                    $(document).on('refreshed.bs.select', '#StdocCategory, #StdocSub', function() {
                        applyMinWidthToDropdowns();
                    });
                    
                    switchDocTab('uploaded');
                    loadDocCategory();
                    fetchAllDocuments();

                    $(document).on('keyup', '#sercdeltsk', function (e) {
                        //debugger
                        if (e.key === 'Enter' || e.keyCode === 13) {
                            e.preventDefault();
                            if (searchDebounceTimer) {
                                clearTimeout(searchDebounceTimer);
                            }
                            // Filter client-side without calling API
                            currentPage = 1; // Reset to first page when filtering
                            showPageRows();
                            updatePagination();
                        } else {
                            myFunction();
                        }
                        toggleClearAllButton();
                    });
                    
                    $(document).on('click', '#searchButton', function(e) {
                        e.preventDefault();
                        if (searchDebounceTimer) {
                            clearTimeout(searchDebounceTimer);
                        }
                        // Filter client-side without calling API
                        currentPage = 1; // Reset to first page when filtering
                        showPageRows();
                        updatePagination();
                        toggleClearAllButton();
                    });
                    
                    $(document).on('keyup', '#docName', function() {
                        toggleClearAllButton();
                    });
                    
                    $(document).on('changed.bs.select', '#StdocCategory', function() {
                        toggleClearAllButton();
                        fetchAllDocuments(); // Refresh documents when category changes
                    });
                    
                    $(document).on('changed.bs.select', '#StdocSub', function() {
                        toggleClearAllButton();
                        fetchAllDocuments(); // Refresh documents when subcategory changes
                    });

                    $('#bodyMainFiles').on('click', '.remove-row', function () {
                        const $row = $(this).closest('tr');
                        const rowIndex = $row.index();

                        selectedFiles.splice(rowIndex, 1);
                        $row.remove();

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(ResourceStrings.A_DocumentRemovedSuccess);

                        const $allRows = $('#bodyMainFiles tr');

                        if ($allRows.length === 0) {
                            $('#tblMainFiles').hide();
                            $('#divMainAttachments').hide();
                        } else {
                            $allRows.each(function (i, row) {
                                $(row).find('td:first').text(i + 1);
                            });
                        }
                    });
                    $(document).on('show.bs.offcanvas', '.offcanvas', function () {
                        $('html, body').addClass('no-scroll');
                    });
                    $(document).on('shown.bs.offcanvas', '.offcanvas', function () {
                        $('html, body').addClass('no-scroll');
                    });
                    
                    // Handle review offcanvas show event - hide/show save button based on edit access
                    $(document).on('shown.bs.offcanvas', '#Doc_reviewOffScreen', function () {
                        if (m_blnEditAccess) {
                            $('#svDoc_review').show();
                        } else {
                            $('#svDoc_review').hide();
                        }
                    });
                    $(document).on('hide.bs.offcanvas', '.offcanvas', function () {
                        $('html, body').removeClass('no-scroll');
                    });
                    $(document).on('hidden.bs.offcanvas', '.offcanvas', function (e) {
                        $('html, body').removeClass('no-scroll');
                        
                        if ($(e.target).attr('id') === 'AttachURLOffScreen') {
                            $('#txtURL').val('');
                            $('#txtDescription').val('');
                            $('#cboAttachCate').selectpicker('val', '0');
                            $('#cboAttachSubCate').empty().append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                            $('#cboAttachSubCate').selectpicker('refresh');
                            $('#cboAttachSubCate').selectpicker('val', '0');
                        }
                    });


                    $(document).on('change', '#doc_dragdrop', function () {
                        var files = this.files;
                        if (files.length > 0) {
                            var objFileInput = this;
                            if (disallowBlank(objFileInput, ResourceStrings.A_PleaseSelectFile)) {
                                $(this).val('');
                                return;
                            }
                            
                            var validateExtensions = [];
                            var allowSubmit = false;
                            
                            if (FileExtensionDisallow && FileExtensionDisallow.length > 0) {
                                validateExtensions = FileExtensionDisallow.split(",");
                            }
                            
                            var invalidFiles = [];
                            var validFiles = [];
                            
                            $.each(files, function (index, file) {
                                var fileValue = file.name;
                                var extension = fileValue.slice(fileValue.lastIndexOf('.') + 1).toLowerCase();
                                allowSubmit = false;
                                
                                for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                                    var strExtn = validateExtensions[cnt].trim().toLowerCase();
                                    if (strExtn === extension) {
                                        allowSubmit = true;
                                        break;
                                    }
                                }
                                
                                if (allowSubmit === false) {
                                    invalidFiles.push(file.name);
                                } else {
                                    validFiles.push(file);
                                }
                            });
                            
                            if (invalidFiles.length > 0) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_InvalidFileExtension.replace("{0}", validateExtensions.join(", ").toUpperCase()));
                                $(this).val('');
                                return;
                            }
                            
                            var hasInvalidFiles = false;
                            $.each(validFiles, function(index, file) {
                                //Commented by Vishal Mane on 15/01/2026 to fix issue : When file name exceeds 260 characters then is gives alert message

                                //debugger
                                var countOfDot = 0;
                                if (file.name != '') {
                                    countOfDot = file.name.split(".").length - 1;
                                }
                                if (countOfDot > 1) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_MultipleExtensions);
                                    hasInvalidFiles = true;
                                    return false;
                                }
                                //End of Commented by Vishal Mane on 15/01/2026 to fix issue : When file name exceeds 260 characters then is gives alert message

                                var FileNameCharCount = 0;
                                if (file.name != '') {
                                    FileNameCharCount = file.name.split(".")[0].length;
                                }
                                if (FileNameCharCount > 120) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileNameTooLong);
                                    hasInvalidFiles = true;
                                    return false;
                                }
                                
                                if (file.name.indexOf('#') !== -1) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_SpecialCharacterHash);
                                    hasInvalidFiles = true;
                                    return false;
                                }
                                
                                var minFileSizeBytes = parseInt(MinFileSize) || 1024;
                                if (file.size < minFileSizeBytes) {
                                    var minFileSizeKB = (minFileSizeBytes / 1024).toFixed(2);
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileSizeTooSmall.replace("{0}", minFileSizeKB));
                                    hasInvalidFiles = true;
                                    return false;
                                }
                                
                                var maxFileSizeBytes = parseInt(MaxFileSize) || 99999999;
                                if (file.size > maxFileSizeBytes) {
                                    var maxFileSizeMB = (maxFileSizeBytes / (1024 * 1024)).toFixed(2);
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileSizeTooLarge.replace("{0}", maxFileSizeMB));
                                    hasInvalidFiles = true;
                                    return false;
                                }
                                
                                var estimatedPathLength = file.name.length + 200;
                                //Added and commented by Vishal Mane on 15/01/2026 to fix Character Length Issue
                                //if (estimatedPathLength > 260) {
                                //if (estimatedPathLength > 120) {
                                //    alertify.set('notifier', 'position', 'top-right');
                                //    //alertify.error(ResourceStrings.A_FilePathTooLong);
                                //    alertify.error(ResourceStrings.A_FileNameTooLong);
                                //    hasInvalidFiles = true;
                                //    return false;
                                //}
                                //End of Added and commented by Vishal Mane on 15/01/2026 to fix Character Length Issue
                            });
                            
                            if (hasInvalidFiles) {
                                $(this).val('');
                                return;
                            }
                            
                            var currentRowCount = $('#bodyMainFiles tr').length;
                            if (currentRowCount + validFiles.length > 3) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_MaxThreeFiles);
                                $(this).val('');
                                return;
                            }
                            
                            $('#divMainAttachments').show();
                            $('#tblMainFiles').show();
                           
                            var $tbody = $('#bodyMainFiles');
                            var uniqueID = $tbody.find('tr').length + 1;


                            var self = this;
                            var filesToProcess = [];
                            
                            async function validateFilesForExe() { 
                              //  debugger
                                for (var idx = 0; idx < validFiles.length; idx++) {
                                    var file = validFiles[idx];
                                    
                                    try {
                                        var tempFileInput = document.createElement('input');
                                        tempFileInput.type = 'file';
                                        
                                        var dataTransfer = new DataTransfer();
                                        dataTransfer.items.add(file);
                                        tempFileInput.files = dataTransfer.files;
                                        
                                        await ValidateForexeinFile(tempFileInput);
                                        
                                        if (isValidTypeExeCheck !== false && isValidTypeExeCheck !== undefined) {
                                            filesToProcess.push(file);
                                        } else {
                                            continue;
                                        }
                                    } catch (error) {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.error(ResourceStrings.A_EmbeddedExecutable);
                                        continue;
                                    }
                                }
                                return true;
                            }
                            
                            validateFilesForExe().then(function(success) {
                                if (filesToProcess.length === 0) {
                                    $(self).val('');
                                    return;
                                }
                                
                                validFiles = filesToProcess;
                                
                                // Added by Nischal C on 3/11/2025 - MIME type validation using GetFileType API
                                validateFilesMimeType(validFiles).then(function(mimeValidFiles) {
                                    if (mimeValidFiles.length === 0) {
                                        $(self).val('');
                                        return;
                                    }
                                    
                                    validFiles = mimeValidFiles;
                                
                                $.each(validFiles, function (index, file) {
                                var rowCount = $tbody.find('tr').length + 1;
                                var localUniqueIDChangeReTypeID = `ChangeReTypeID_${Date.now()}_${rowCount}_${index}`;
                                var localUniqueIDSubcateID = `SubTypeID_${Date.now()}_${rowCount}_${index}`;
                                var localUniqueIDcateID = `TypeID_${Date.now()}_${rowCount}_${index}`;
                                strUploadedFileName = file.name;
                                fileSizeKB = (file.size / 1024).toFixed(2);
                                extension = strUploadedFileName.split('.').pop();
                                cleanFileName = encodeURIComponent(strUploadedFileName.trim());
                                selectedFiles.push(file);

                                var row = `

                <tr>
                    <td>${rowCount}</td>
                    <td>${file.name}</td>
                    <td>
                     <select class="form-select CateTypeID" id="${localUniqueIDcateID}" onchange="loadSubDocCategoryModal(this.value, '${localUniqueIDSubcateID}', '${localUniqueIDChangeReTypeID}')">

                            <!-- Category options will be loaded -->
                        </select>
                    </td>
                    <td>
                        <select class="form-select SubCateTypeID" id="${localUniqueIDSubcateID}">
                            <option value="0">Select Document Sub Type</option>
                            <!-- Subcategory options will be loaded -->
                        </select>


                    </td>
                    <!-- Commented by Vishal Mane on 19/01/2026 to remove Change Request column-->
                    <!--<td>
                        <select class="form-select ChangeReTypeID" id="${localUniqueIDChangeReTypeID}">
                            <option value="0"><%=MyBase.GetResourceString("C_SelectChangeRequest")%></option>
                        </select>
                    </td>-->
                    <!-- End of Commented by Vishal Mane on 19/01/2026 remove Change Request column -->
                    <!-- Commented and added by Vishal Mane on 19/01/2026 -->
                    <td><textarea class="form-control dynamic-textarea" MaxLength ="3000" placeholder="<%=MyBase.GetResourceString("C_EnterComment")%>" id="${"Comment" + localUniqueIDChangeReTypeID}"></textarea></td>
                    <td>
                        <button type="button" class="btn btn-sm remove-row"><i class="far fa-trash-alt deleteIcon"></i></button>
                    </td>
                    <!-- End of Commented and added by Vishal Mane on 19/01/2026 -->
                </tr>`;

                                $tbody.append(row);

                                (function(capturedCateID) {
                                    setTimeout(function() {
                                        var $dropdown = $('#' + capturedCateID);
                                        if ($dropdown.length > 0) {
                                            loadDocCategory(capturedCateID);
                                        } else {
                                            setTimeout(function() {
                                                var $retryDropdown = $('#' + capturedCateID);
                                                if ($retryDropdown.length > 0) {
                                                    loadDocCategory(capturedCateID);
                                                }
                                            }, 300);
                                        }
                                    }, 200 + (index * 100));
                                })(localUniqueIDcateID);
                            });
                                
                                }).catch(function(error) {
                                });
                            }).catch(function(error) {
                            });
                        }

                        const dropZone = this.closest('.drop-zone');
                        if (this.files && this.files.length > 0) {
                        updateThumbnail(dropZone, this.files[0]);
                        }
                    });

                    $('#uploadDocOffScreen').on('show.bs.offcanvas', function () {
                        $('#tblMainFiles').hide();
                        $('#divMainAttachments').hide();
                        
                        if ($.fn.DataTable.isDataTable('#tblMainFiles')) {
                            $('#tblMainFiles').DataTable().clear().destroy();
                        }
                        
                        $('#bodyMainFiles').empty();
                        selectedFiles.length = 0;
                        
                        var fileInputs = $('#uploadDocOffScreen input[type="file"]');
                        fileInputs.val('');
                        
                        $('#uploadDocOffScreen input[type="text"]').val('');
                        $('#uploadDocOffScreen select').val('0').trigger('change');
                    });
                    
                    $('#uploadDocOffScreen').on('hidden.bs.offcanvas', function () {
                        var fileInputs = $('#uploadDocOffScreen input[type="file"]');
                        fileInputs.val('');
                        
                        $('#tblMainFiles').hide();
                        $('#divMainAttachments').hide();
                        $('#bodyMainFiles').empty();
                        selectedFiles.length = 0;
                        
                        if ($.fn.DataTable.isDataTable('#tblMainFiles')) {
                            $('#tblMainFiles').DataTable().clear().destroy();
                        }
                    });

                });

                var uploadStatus = {
                    total: 0,
                    success: 0,
                    failed: 0,
                    errors: []
                };
                
                // Added by Nischal C on 3/11/2025 - Upload file to server with FormData
                function uploadFileWithFormData(url, formData, index, totalFilesCount, fileName, documentID, versionedFileName) {
                    var data = AJAXCallWithResult(url, formData, false);
                    
                    if (data) {
                            var responseData = data.data || data.Data || data;
                            var saveResponse = responseData.data || responseData;
                            
                            var isSuccess = false;                                                      
                            if (data.status === 'SUCCESS' || data.Status === 'SUCCESS') {
                                if (saveResponse && saveResponse.Success === false) {
                                    isSuccess = false;
                                } else if (saveResponse && saveResponse.Success === true) {
                                    isSuccess = true;
                                } else {
                                    isSuccess = true;
                                }
                            } else if (data.status === 'FAILURE' || data.Status === 'FAILURE') {
                                isSuccess = false;
                            } else if (data.success === true || data.Success === true) {
                                isSuccess = true;
                            } else if (data.success === false || data.Success === false) {
                                isSuccess = false;
                            } else {
                                if (saveResponse && (saveResponse.Success === true || saveResponse.success === true)) {
                                    isSuccess = true;
                                } else if (saveResponse && (saveResponse.Success === false || saveResponse.success === false)) {
                                    isSuccess = false;
                                } else {
                                    var errorMsg = (saveResponse && saveResponse.Message) || (saveResponse && saveResponse.message) || '';
                                    if (errorMsg && (errorMsg.toLowerCase().indexOf('error') !== -1 || errorMsg.toLowerCase().indexOf('failed') !== -1)) {
                                        isSuccess = false;
                                    } else {
                                        // No explicit error, assume success
                                        isSuccess = true;
                                    }
                                }
                            }
                            
                            if (isSuccess) {
                                uploadStatus.success++;
                                // Try multiple locations for FilePath
                                var filePath = (saveResponse && (saveResponse.FilePath || saveResponse.filePath)) || 
                                             (data.FilePath || data.filePath) || 
                                             (saveResponse && saveResponse.FilePath) ||
                                             "N/A";
                                if (filePath === "N/A") {
                                }
                            } else {
                                uploadStatus.failed++;
                                var errorMsg = (saveResponse && saveResponse.Message) || (saveResponse && saveResponse.message) || "File save failed";
                                uploadStatus.errors.push(fileName + ": " + errorMsg);
                                console.error("File save failed for:", versionedFileName, "Error:", errorMsg);
                            }
                    
                            var totalCompleted = uploadStatus.success + uploadStatus.failed;
                            
                            if (totalCompleted >= uploadStatus.total) {
                                setTimeout(function() {
                                    $('#cnlID').trigger('click');
                                    
                                    if (uploadStatus.failed === 0) {
                                alertify.set('notifier', 'position', 'top-right');
                                        alertify.success(ResourceStrings.A_AllDocumentsUploadedSuccess);
                                    } else {
                                        var successMsg = uploadStatus.success > 0 ? uploadStatus.success + ' file(s) uploaded successfully. ' : '';
                                        var errorMsg = successMsg + uploadStatus.failed + ' file(s) failed:\n\n' + uploadStatus.errors.join('\n');
                                        alertify.error(errorMsg);
                                    }
                                    
                                    switchDocTab('uploaded', true);
                                    setTimeout(function() {
                                        fetchAllDocuments();
                                    }, 300);
                                    
                                    uploadStatus = { total: 0, success: 0, failed: 0, errors: [] };
                                }, 500);
                            }
                    } else {
                        uploadStatus.failed++;
                        var errorMsg = fileName || ('File ' + (index + 1)) + ': ' + (data.message || data.Message || 'Upload failed');
                        uploadStatus.errors.push(errorMsg);
                        
                        if (uploadStatus.failed === totalFilesCount) {
                            var allErrors = uploadStatus.errors.join('\n');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_AllUploadsFailed.replace("{0}", allErrors));
                            window.location.href = "../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(allErrors);
                        }
                    }
                }


                // Added by Nischal C on 3/11/2025 - Load document categories from API
                function loadDocCategory(uniqueIDcateID,UrlFlag) {

                     if (UrlFlag) {


                        var docTypeParams = {
                             RoleID: intPostID,
                             ProjectID: currentProjectID
                        };


                         param = JSON.stringify(docTypeParams);

                         var url = "/api/DocumentUpload/GetDocumentType";
                         var result = AJAXCallWithResult(url, param, false);                      
                         resultRaw = result;                          
                         var result = [];
                         try {
                             if (resultRaw && resultRaw.data) {
                                 if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                     result = resultRaw.data.data; 
                                 } 
                                 else if (Array.isArray(resultRaw.data)) { 
                                     result = resultRaw.data; 
                                 }
                                 else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                     result = resultRaw.data.items;
                                 }
                                 else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.DocumentTypeModel && Array.isArray(resultRaw.data.DocumentTypeModel)) {
                                     result = resultRaw.data.DocumentTypeModel;
                                 }
                             } 
                             else if (Array.isArray(resultRaw)) { 
                                 result = resultRaw; 
                             }
                         } catch (e) {
                         }


                        var $Attachselect = $('#cboAttachCate');
                        
                        if (!$Attachselect.data('selectpicker')) {
                            $Attachselect.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                        
                        $Attachselect.empty();
                        $Attachselect.append('<option value="0">' + ResourceStrings.C_SelectDocumentCategory + '</option>');

                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var categoryId = item.CategoryID || item.categoryID || item.ID || item.id || item.DocumentTypeID || item.documentTypeID || '';
                                var categoryName = item.Category || item.category || item.Name || item.name || item.DocumentType || item.documentType || '';
                                if (categoryId && categoryName && categoryId !== '0') {
                                    $Attachselect.append('<option value="' + categoryId + '">' + categoryName + '</option>');
                                }
                            });
                        }

                        $Attachselect.selectpicker('refresh');
                        $Attachselect.selectpicker('val', '0');
                        var subFlag = true;

                        var selectedCategoryId = $('#cboAttachCate').val();
                        if (selectedCategoryId && selectedCategoryId !== '0') {
                            loadSubDocCategory(selectedCategoryId, null, uniqueIDcateID, subFlag);
                        } else {
                            var $subSelect = $('#cboAttachSubCate');
                            if ($subSelect.length) {
                                $subSelect.empty();
                                $subSelect.append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                                if ($subSelect.data('selectpicker')) {
                                    $subSelect.selectpicker('refresh');
                                    $subSelect.selectpicker('val', '0');
                                }
                            }
                        }
                         return;
                    }

                   else if (!uniqueIDcateID) {

                        var docTypeParams = {
                            RoleID: intPostID,
                            ProjectID: currentProjectID
                        };

                         param = JSON.stringify(docTypeParams);

                         var url = "/api/DocumentUpload/GetDocumentType";
                         var result = AJAXCallWithResult(url, param, false);
                         
                        var resultRaw = null;                      
                        resultRaw = result;                    
                        var result = [];                                              
                        try {
                            if (resultRaw && resultRaw.data) {
                                if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                    result = resultRaw.data.data; 
                                } 
                                else if (Array.isArray(resultRaw.data)) { 
                                    result = resultRaw.data; 
                                }
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                    result = resultRaw.data.items;
                                }
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.DocumentTypeModel && Array.isArray(resultRaw.data.DocumentTypeModel)) {
                                    result = resultRaw.data.DocumentTypeModel;
                                }
                            } 
                            else if (Array.isArray(resultRaw)) { 
                                result = resultRaw; 
                            }
                        } catch (e) {
                        }

                        var $select = $('#StdocCategory');
                        
                        if (!$select.data('selectpicker')) {
                            $select.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                        
                        $select.empty();
                        $select.append('<option value="0">' + ResourceStrings.C_SelectDocumentCategory + '</option>');

                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var categoryId = item.CategoryID || item.categoryID || item.ID || item.id || item.DocumentTypeID || item.documentTypeID || '';
                                var categoryName = item.Category || item.category || item.Name || item.name || item.DocumentType || item.documentType || '';
                                if (categoryId && categoryName && categoryId !== '0') {
                                    $select.append('<option value="' + categoryId + '">' + categoryName + '</option>');
                                }
                            });
                        }

                        $select.selectpicker('refresh');
                        $select.selectpicker('val', '0');

                        var selectedCategoryId = $('#StdocCategory').val();
                        if (selectedCategoryId && selectedCategoryId !== '0') {
                            loadSubDocCategory(selectedCategoryId, null, uniqueIDcateID);
                        } else {
                            var $subSelect = $('#StdocSub');
                            if ($subSelect.length) {
                                $subSelect.empty();
                                $subSelect.append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                                if ($subSelect.data('selectpicker')) {
                                    $subSelect.selectpicker('refresh');
                                    $subSelect.selectpicker('val', '0');
                                }
                            }
                        }                    
                         return;                       
                    }                 
                    else {
                        var docTypeParams = {
                            RoleID: intPostID,
                            ProjectID: currentProjectID
                        };

                         var param = JSON.stringify(docTypeParams);
                         var url = "/api/DocumentUpload/GetDocumentType";
                         var result = AJAXCallWithResult(url, param, false);                       
                         var resultRaw = null;                                                                       
                         resultRaw = result;                                                 
                         var result = [];
                        try {
                            if (resultRaw && resultRaw.data) {
                                if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                    result = resultRaw.data.data; 
                                } 
                                else if (Array.isArray(resultRaw.data)) { 
                                    result = resultRaw.data; 
                                }
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                    result = resultRaw.data.items;
                                }
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.DocumentTypeModel && Array.isArray(resultRaw.data.DocumentTypeModel)) {
                                    result = resultRaw.data.DocumentTypeModel;
                                }
                            } 
                            else if (Array.isArray(resultRaw)) { 
                                result = resultRaw; 
                            }
                        } catch (e) {
                        }

                          var $cateTypeID = $('#' + uniqueIDcateID);

                        if ($cateTypeID.length === 0) {
                            return;
                        }

                        $cateTypeID.empty();
                        $cateTypeID.append('<option value="0">' + ResourceStrings.C_SelectDocumentCategory + '</option>');

                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var categoryId = item.CategoryID || item.categoryID || item.ID || item.id || item.DocumentTypeID || item.documentTypeID || '';
                                var categoryName = item.Category || item.category || item.Name || item.name || item.DocumentType || item.documentType || '';
                                if (categoryId && categoryName && categoryId !== '0') {
                                    $cateTypeID.append('<option value="' + categoryId + '">' + categoryName + '</option>');
                                }
                            });
                        }
                        
                        $cateTypeID.val('0');

                    }
              
                   
                }
                // End of addition by Nischal C on 3/11/2025 Load sub-document categories based on selected category and project

                // Added by Nischal C on 3/11/2025 - Load sub-document categories based on selected category and project
                function loadSubDocCategory(CategoryID, SubCategoryID, flag, subFlag, changeRequestId) {
                    var $subSelect;
                    var actualCategoryID;
                    
                    if (subFlag == true) {
                        $subSelect = $('#cboAttachSubCate');
                        actualCategoryID = $('#cboAttachCate').val();
                        
                        if (!$subSelect.data('selectpicker')) {
                            $subSelect.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                    } else if (flag) {
                        $subSelect = $('#' + flag);
                        actualCategoryID = CategoryID;
                    } else {
                        $subSelect = $('#StdocSub');
                        actualCategoryID = CategoryID;
                        
                        if (!$subSelect.data('selectpicker')) {
                            $subSelect.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                    }
                    
                    if ($subSelect.length === 0) {
                        console.error('Subcategory dropdown not found');
                        return;
                    }
                    
                    if (!actualCategoryID || actualCategoryID === '0' || actualCategoryID === 0) {
                        $subSelect.empty();
                        $subSelect.append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                        if ($subSelect.data('selectpicker')) {
                            $subSelect.selectpicker('refresh');
                            $subSelect.selectpicker('val', '0');
                        }
                        return;
                    }

                    var subDocTypeParams = {
                        CategoryID: actualCategoryID,
                        SubCategoryID: SubCategoryID,
                        ProjectID: currentProjectID
                    };

                    var param = JSON.stringify(subDocTypeParams);
                    var resultRaw = null;
                    var url = "/api/DocumentUpload/GetSubDocType";
                    var result = AJAXCallWithResult(url, param, false);                       
                    resultRaw = result;                           
                    var result = [];         
                    try {
                        if (resultRaw && resultRaw.data) {
                            if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                result = resultRaw.data.data; 
                            } 
                            else if (Array.isArray(resultRaw.data)) { 
                                result = resultRaw.data; 
                            }
                            else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                result = resultRaw.data.items;
                            }
                            else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.SubDocumentTypeModel && Array.isArray(resultRaw.data.SubDocumentTypeModel)) {
                                result = resultRaw.data.SubDocumentTypeModel;
                            }
                        } 
                        else if (Array.isArray(resultRaw)) { 
                            result = resultRaw; 
                        }
                    } catch (e) {
                    }

                    $subSelect.empty();
                    $subSelect.append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');

                    if (result && Array.isArray(result) && result.length > 0) {
                        result.forEach(function (item) {
                            var subCategoryId = item.SubCategoryID || item.subCategoryID || item.ID || item.id || item.SubDocumentTypeID || item.subDocumentTypeID || '';
                            var subCategoryName = item.SubCategory || item.subCategory || item.Name || item.name || item.SubDocumentType || item.subDocumentType || '';
                            if (subCategoryId && subCategoryName && subCategoryId !== '0') {
                                $subSelect.append('<option value="' + subCategoryId + '">' + subCategoryName + '</option>');
                            }
                        });
                    }
                    
                    if ($subSelect.data('selectpicker')) {
                        $subSelect.selectpicker('refresh');
                        $subSelect.selectpicker('val', '0');
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Load sub-document categories based on selected category and project
              
                // Added by Nischal C on 3/11/2025 - Load change requests into dropdown
                function loadChangeRequests(changeRequestIdToUse, projectID) {
                    if (!changeRequestIdToUse || !projectID) {
                        return;
                    }
                    
                    var changeReParams = {                         
                        ProjectID: projectID
                    };

                    var param = JSON.stringify(changeReParams);
                    var changeReResultRaw = null;
                    var url = "/api/DocumentUpload/GetChangeReType";
                    var result = AJAXCallWithResult(url, param, false);
                    changeReResultRaw = result;                     
                    var changeReResult = [];
                    try {
                        if (changeReResultRaw && changeReResultRaw.data) {
                            if (changeReResultRaw.data.data && Array.isArray(changeReResultRaw.data.data)) { 
                                changeReResult = changeReResultRaw.data.data;
                            } 
                            else if (Array.isArray(changeReResultRaw.data)) { 
                                changeReResult = changeReResultRaw.data;
                            }
                            else if (changeReResultRaw.data && typeof changeReResultRaw.data === 'object' && changeReResultRaw.data.items && Array.isArray(changeReResultRaw.data.items)) {
                                changeReResult = changeReResultRaw.data.items;
                            }
                            else if (changeReResultRaw.data && typeof changeReResultRaw.data === 'object' && changeReResultRaw.data.ChangeRequestTypeModel && Array.isArray(changeReResultRaw.data.ChangeRequestTypeModel)) {
                                changeReResult = changeReResultRaw.data.ChangeRequestTypeModel;
                            }
                        } 
                        else if (Array.isArray(changeReResultRaw)) { 
                            changeReResult = changeReResultRaw;
                        }
                    } catch (e) {
                        console.error('Error normalizing change request response:', e);
                    }

                    var $changeReTypeSelect = $('#' + changeRequestIdToUse);
                    
                    if ($changeReTypeSelect.length === 0) {
                        console.error('Change Request dropdown not found with ID:', changeRequestIdToUse);
                        return;
                    }

                    $changeReTypeSelect.empty();
                    $changeReTypeSelect.append('<option value="0">' + ResourceStrings.C_SelectChangeRequest + '</option>');
                    
                    if (changeReResult && Array.isArray(changeReResult) && changeReResult.length > 0) {
                        changeReResult.forEach(function (item) {
                            var changeReqId = item.ChangeRequestID || item.changeRequestID || item.ID || item.id || '';
                            // Stored procedure returns ChangeRequestSummary (not ChangeRequestType)
                            // Priority: ChangeRequestSummary > ChangeRequestType > Description > Summary > Name
                            var changeReqText = item.ChangeRequestSummary || item.changeRequestSummary || 
                                               item.ChangeRequestType || item.changeRequestType || 
                                               item.ChangeRequestDescription || item.changeRequestDescription ||
                                               item.Description || item.description || 
                                               item.Summary || item.summary || 
                                               item.Name || item.name || '';
                            if (changeReqId && changeReqText && changeReqId !== '0') {
                                $changeReTypeSelect.append('<option value="' + changeReqId + '">' + changeReqText + '</option>');
                            }
                        });
                        
                        // Trigger change event to ensure UI updates
                        $changeReTypeSelect.trigger('change');
                    }
                }
                // End of Added by Nischal C on 3/11/2025 - Load change requests into dropdown
              
                // Added by Nischal C on 3/11/2025 - Load sub-categories in upload modal
                function loadSubDocCategoryModal(CategoryID, SubCategoryID, ChangeReTypeID) {
                    if (!CategoryID || CategoryID === '0' || CategoryID === 0) {
                        // Clear subcategory and change request dropdowns
                        $('#' + SubCategoryID).empty().append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                        $('#' + ChangeReTypeID).empty().append('<option value="0">' + ResourceStrings.C_SelectChangeRequest + '</option>');
                        return;
                    }
                    
                    // Load change request dropdown immediately when category is selected
                    // This ensures it loads even if subcategories are empty
                    if (ChangeReTypeID && currentProjectID) {
                        loadChangeRequests(ChangeReTypeID, currentProjectID);
                    }
                    
                    // Load subcategories - pass changeRequestId as 5th parameter
                    loadSubDocCategory(CategoryID, null, SubCategoryID, false, ChangeReTypeID);
                }
                // End of addition by Nischal C on 3/11/2025 Load sub-categories in upload modal
              
                // Added by Nischal C on 3/11/2025 - Handle project dropdown change
                function PlotProjectonChange() {
                    var selectedProjectID = $('#cboProject').val();
                    if (selectedProjectID && selectedProjectID !== '0') {
                        currentProjectID = parseInt(selectedProjectID);
                        loadDocCategory();                        
                        fetchAllDocuments();                    
                        // Reset search filters
                        $('#docName').val('');
                        $('#sercdeltsk').val('');
                        
                        // Clear category and subcategory dropdowns
                        $('#StdocCategory').selectpicker('val', '0');
                        $('#StdocSub').empty().append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                        $('#StdocSub').selectpicker('refresh');
                        $('#StdocSub').selectpicker('val', '0');
                        
                        // Hide Clear button
                        $('#ClearAllFilter').hide();
                    }
        else {
        // Added by Vaibhav K on 16-03-26 - No project selected: clear table 
        currentProjectID = 0;
        var hasDeleteAccess = <%=m_blnDeleteAccess.ToString().ToLower()%>;
        var colspan = hasDeleteAccess ? 9 : 8;
        $('#tbodyReqSpe').html('<tr><td colspan="' + colspan + '" class="text-center">No data available in table</td></tr>');
        $('#tbodyUrls').html('');
        $('#totalRecords').text('0');
        toggleDocumentActionButtons(false);
        // End of addition by Vaibhav K on 16-03-26 - No project selected: clear table 
    }



                }
                // End of addition by Nischal C on 3/11/2025 Handle project dropdown change
                
                // Handle selectpicker change event
                $(document).on('changed.bs.select', '#cboProject', function() {
                    PlotProjectonChange();
                });


                // Added by Nischal C on 3/11/2025 - Check if any filters are active
                function hasActiveFilters() {
                    var hasSearchText = ($('#docName').val() && $('#docName').val().trim() !== '') || 
                                       ($('#sercdeltsk').val() && $('#sercdeltsk').val().trim() !== '');
                    var hasCategory = $('#StdocCategory').val() && $('#StdocCategory').val() !== '0';
                    var hasSubCategory = $('#StdocSub').val() && $('#StdocSub').val() !== '0';
                    return hasSearchText || hasCategory || hasSubCategory;
                }
                // End of addition by Nischal C on 3/11/2025 Check if any filters are active
                
                // Added by Nischal C on 3/11/2025 - Toggle Clear button visibility
                function toggleClearAllButton() {
                    if (hasActiveFilters()) {
                        $('#ClearAllFilter').show();
                    } else {
                        $('#ClearAllFilter').hide();
                    }
                }
                
                // Clear all filters function
                function clearFilters() {
                    // Clear search inputs
                    $('#docName').val('');
                    $('#sercdeltsk').val('');
                    
                    // Clear category and subcategory dropdowns
                    $('#StdocCategory').selectpicker('val', '0');
                    $('#StdocSub').empty().append('<option value="0">Select Document Sub Category</option>');
                    $('#StdocSub').selectpicker('refresh');
                    $('#StdocSub').selectpicker('val', '0');
                    
                    // Hide Clear button
                    $('#ClearAllFilter').hide();
                    
                    // Reload documents without filters
                    fetchAllDocuments();
                }
                // End of addition by Nischal C on 3/11/2025 Toggle Clear button visibility

                // Added by Nischal C on 3/11/2025 - Fetch all documents from API
                function fetchAllDocuments() {
                   // debugger
                    var CategoryID = $('#StdocCategory').val();
                    var SubCategoryID = $('#StdocSub').val();
                    var strAlphabet = "-1";
                    // Get search text from docName only (for API filtering)
                    var searchText = $('#docName').val() ? $('#docName').val().trim() : '';
                    
                    // Update Clear button visibility after processing filters
                    toggleClearAllButton();

                    // LOGIC: Apply BOTH search text AND category filters together
                    // Both filters should work simultaneously for better filtering
                    var docFetchParams = {
                        ProjectID: currentProjectID,
                        DocumentID: null,
                        WhatToSelect: null,
                        LoginRoleID: intPostID,
                        FilePaging: strAlphabet,
                        SearchText: searchText,
                        // Apply category filters when selected, regardless of search text
                        CategoryID: (CategoryID && CategoryID !== '0') ? parseInt(CategoryID) : null,
                        SubCategoryID: (SubCategoryID && SubCategoryID !== '0') ? parseInt(SubCategoryID) : null
                    };

                    var param = JSON.stringify(docFetchParams);
                    var url = "/api/DocumentUpload/GetAllDocuments";
                    var result = AJAXCallWithResult(url, param, false);                 
                    processDocumentsResponse(result);                                           
                }
                // End of addition by Nischal C on 3/11/2025 Fetch all documents from API

                // Added by Nischal C on 3/11/2025 - Process documents API response
                function processDocumentsResponse(apiResult) {

                    // Normalize API response to a flat array
                    var result = [];
                    try {
                        // Check for ResponseEntity structure: { status: 'SUCCESS', data: { data: [...] } }
                        if (apiResult && apiResult.data) {
                            if (apiResult.data.data && Array.isArray(apiResult.data.data)) {
                                result = apiResult.data.data;
                            } else if (Array.isArray(apiResult.data)) {
                                result = apiResult.data;
                            } else if (apiResult.data && typeof apiResult.data === 'object' && apiResult.data.ProjectDocumentModel && Array.isArray(apiResult.data.ProjectDocumentModel)) {
                                result = apiResult.data.ProjectDocumentModel;
                            } else if (apiResult.data && typeof apiResult.data === 'object' && apiResult.data.items && Array.isArray(apiResult.data.items)) {
                                result = apiResult.data.items;
                            }
                        } else if (Array.isArray(apiResult)) {
                            result = apiResult;
                        }
                    } catch (e) {
                    }
                    
                    // Filter based on current view (Uploaded Documents vs Attached URLs)
                    var isUrlsView = $('#containerUrls').is(':visible');
                    if (!isUrlsView) {
                        result = (result || []).filter(function (d) { return !(d.IsURL || d.isURL); });
                    } else {
                        result = (result || []).filter(function (d) { return (d.IsURL || d.isURL); });
                    }
                    
                    if (!result || result.length === 0) {
                        // Show "No data available in table" message
                        var isUrlsView = $('#containerUrls').is(':visible');
                        var hasDeleteAccess = <%=m_blnDeleteAccess.ToString().ToLower()%>;
                        var tbodyNo = isUrlsView ? document.querySelector('#tbodyUrls') : document.querySelector('#tbodyReqSpe');
                        var tbodyOther = isUrlsView ? document.querySelector('#tbodyReqSpe') : document.querySelector('#tbodyUrls');
                        
                        if (tbodyNo) {
                            var colspan = isUrlsView ? (hasDeleteAccess ? 7 : 6) : (hasDeleteAccess ? 9 : 8);
                            tbodyNo.innerHTML = '<tr><td colspan="' + colspan + '" class="text-center">No data available in table</td></tr>';
                        }
                        if (tbodyOther) {
                            tbodyOther.innerHTML = '';
                        }
                        currentPage = 1;
                        showPageRows();
                        // Added by Vaibhav K to hide loader on 11-03-26
                        hideLoader();
                        // End of Added by Vaibhav K to hide loader on 11-03-26
                        return;
                    }
                    
                    // Determine which table to populate
                    var isUrlsView = $('#containerUrls').is(':visible');
                    var tbl, tbody, tableId;
                    
                    if (isUrlsView) {
                        // URLs table
                        tbl = document.querySelector("#urlstable");
                        tbody = document.querySelector("#tbodyUrls");
                        tableId = "#urlstable";
                    } else {
                        // Uploaded documents table
                        tbl = document.querySelector("#prodocumentstbl");
                        tbody = document.querySelector("#tbodyReqSpe");
                        tableId = "#prodocumentstbl";
                    }

                        if (!tbody) {
                            return;
                        }

                    // Destroy DataTable if exists - with error handling
                    try {
                        if ($.fn.DataTable.isDataTable(tableId)) {
                            $(tableId).DataTable().destroy();
                        }
                    } catch (e) {
                        // Ignore destroy errors
                        }

                        tbody.innerHTML = ""; // Clear table before adding new rows

                        var groupedDocs = {};

                        result.forEach(function (doc) {
                            var categoryId = (doc.CategoryID || doc.categoryID || 0).toString();
                            if (!groupedDocs[categoryId]) {
                                groupedDocs[categoryId] = [];
                            }
                            groupedDocs[categoryId].push(doc);
                        });

                        var html = '';

                        // Function to get category initials
                        function getCategoryInitials(categoryName) {
                            if (!categoryName) return '';
                            var words = categoryName.trim().split(/\s+/);
                            if (words.length >= 2) {
                                return (words[0].charAt(0) + words[1].charAt(0)).toUpperCase();
                            } else {
                                return categoryName.substring(0, 2).toUpperCase();
                            }
                        }

                        // Group documents by DocumentRefID - all versions of same file share same DocumentRefID
                        // Documents with DocumentRefID = NULL are originals (first upload)
                        var versionGroups = {};
                        result.forEach(function(doc) {
                            var docRefID = doc.DocumentRefID || doc.documentRefID;
                            var docID = doc.DocumentID || doc.documentID;
                            var isOriginal = doc.Original !== undefined ? doc.Original : (doc.original !== undefined ? doc.original : false);
                            
                            // Use DocumentRefID as key, or DocumentID if DocumentRefID is null (original/first upload)
                            var groupKey = docRefID ? docRefID.toString() : docID.toString();
                            
                            if (!versionGroups[groupKey]) {
                                versionGroups[groupKey] = [];
                            }
                            versionGroups[groupKey].push(doc);
                        });

                        // For each version group, assign version numbers based on UploadedDate (oldest = 1.0, newer = higher version)
                        Object.keys(versionGroups).forEach(function(groupKey) {
                            var versions = versionGroups[groupKey];
                            
                            // Sort by UploadedDate ascending (oldest first) to assign version numbers
                            versions.sort(function(a, b) {
                                var dateA = a.UploadedDate || a.uploadedDate || a.CreatedDate || a.createdDate || '';
                                var dateB = b.UploadedDate || b.uploadedDate || b.CreatedDate || b.createdDate || '';
                                
                                if (!dateA && !dateB) return 0;
                                if (!dateA) return 1;  // a comes after b (no date goes to bottom)
                                if (!dateB) return -1; // b comes after a (no date goes to bottom)
                                
                                try {
                                    var parsedA = new Date(dateA);
                                    var parsedB = new Date(dateB);
                                    if (!isNaN(parsedA.getTime()) && !isNaN(parsedB.getTime())) {
                                        return parsedA.getTime() - parsedB.getTime(); // Oldest first (ascending)
                                    }
                                } catch (e) {
                                    // If parsing fails, use string comparison
                                }
                                
                                return dateA.localeCompare(dateB); // Oldest first (ascending)
                            });

                            // Assign version numbers (1.0, 2.0, 3.0, etc.) based on sorted order
                            versions.forEach(function(doc, index) {
                                var isOriginal = doc.Original !== undefined ? doc.Original : (doc.original !== undefined ? doc.original : false);
                                doc._versionNumber = (index + 1) + '.0';
                                // Latest version is the one with Original = true (as per stored procedure logic)
                                // If Original flag is not reliable, use last in sorted order as fallback
                                doc._isLatestVersion = isOriginal || (index === versions.length - 1);
                            });
                        });

                        Object.keys(groupedDocs).forEach(function (categoryId) {
                            var docs = groupedDocs[categoryId];
                            //debugger
                            // Sort documents by UploadedDate (newest first) within each category
                            docs.sort(function(a, b) {
                                var dateA = a.UploadedDate || a.uploadedDate || a.CreatedDate || a.createdDate || '';
                                var dateB = b.UploadedDate || b.uploadedDate || b.CreatedDate || b.createdDate || '';
                                
                                if (!dateA && !dateB) return 0;
                                if (!dateA) return 1;  // a comes after b (no date goes to bottom)
                                if (!dateB) return -1; // b comes after a (no date goes to bottom)
                                
                                // Parse dates and compare (newest first = descending)
                                try {
                                    var parsedA = new Date(dateA);
                                    var parsedB = new Date(dateB);
                                    if (!isNaN(parsedA.getTime()) && !isNaN(parsedB.getTime())) {
                                        return parsedB.getTime() - parsedA.getTime(); // Newest first
                                    }
                                } catch (e) {
                                    // If parsing fails, use string comparison
                                }
                                
                                // Fallback to string comparison (newest first)
                                return dateB.localeCompare(dateA);
                            });

                            var categoryName = docs[0].Category || docs[0].category || "Uncategorized";
                            var categoryInitials = getCategoryInitials(categoryName);
                            
                            // Determine colspan based on table type and delete access
                            // Documents table: 9 columns (with delete) or 8 columns (without delete)
                            // URLs table: 7 columns (with delete) or 6 columns (without delete)
                            var colspan = isUrlsView ? (m_blnDeleteAccess ? 7 : 6) : (m_blnDeleteAccess ? 9 : 8);
                            
                            html += `<tr class="category-header-row dtr-disabled" data-category-id="${categoryId}">
                                <td colspan="${colspan}">
                                    <div class="category-icon">${categoryInitials}</div>
                                    <span>${categoryName}</span>
                                </td></tr>`;

                            // Check if detail view is active
                            var isDetailView = window.detailViewActive || false;

                            docs.forEach(function (doc, index) {
                                //debugger
                                var uploadedDate = formatDate(doc.UploadedDate || doc.uploadedDate);
                                var uploadedBy = doc.UploadedBy || doc.uploadedBy || '';
                                //var userAvatarHTML = `
                                //<div class="user-avatar">
                                //    <img src="../../../Images/Photo/no-photo.png" alt="User Avatar" />
                                //</div>`;

                                //var UploadedProfilePic = doc.ProfilePicURL || doc.profilePicURL || '../../Images/Photo/no-photo.png';
                                var UploadedProfilePic = doc.ProfilePicURL || doc.profilePicURL || '../../../Images/Photo/no-photo.png';
                                var userAvatarHTML = `
                                <div class="user-avatar">
                                    <img src="${UploadedProfilePic}" alt="User Avatar" />
                                </div>`;
                                
                                if (isUrlsView) {
                                    // Render URLs table
                                    // For URLs: DirectoryName contains the URL, Description contains the description
                                    var urlValue = doc.DirectoryName || doc.directoryName || doc.FileName || doc.fileName || '';
                                    var urlDescription = doc.Description || doc.description || '';
                                    var urlId = "urlChk_" + (doc.DocumentID || doc.documentID) + "_" + index;
                                    
                                    // Ensure URL is clickable - add http/https if missing
                                    var urlLink = urlValue;
                                    if (urlLink && !urlLink.match(/^https?:\/\//i)) {
                                        urlLink = 'http://' + urlLink;
                                    }
                                    
                                    html += `
                    <tr data-url-id="${(doc.DocumentID || doc.documentID)}">
                        <td></td>
                        <td>${doc.SubCategory ? doc.SubCategory : (doc.subCategory || '')}</td>
                        <td><a href="${urlLink}" target="_blank" rel="noopener" title="${urlValue}">${urlValue}</a></td>
                        <td><span class="desc-ellipsis" title="${urlDescription || ''}" data-bs-toggle="tooltip" data-bs-placement="top">${urlDescription || ''}</span></td>
                        <td class="uploaded-by-cell">${userAvatarHTML}<span class="user-name">${uploadedBy || ''}</span></td>
                        <td>${uploadedDate}</td>
                        ${m_blnDeleteAccess ? `<td>
                            <div class="custom_chckbox">
                                <input id="${urlId}" class="doc-chck" type="checkbox" data-url-id="${(doc.DocumentID || doc.documentID)}" data-documentid="${(doc.DocumentID || doc.documentID)}" data-projectid="${(doc.ProjectID || doc.projectID)}">
                                <label for="${urlId}"></label>
                            </div>
                        </td>` : ''}
                    </tr>`;
                                }
                                else {
                                    // Render uploaded documents table
                                    var updatedDate = formatDate(doc.UpdatedDate || doc.updatedDate);
                                    var fileSize = doc.FileSize || doc.fileSize || '';
                                    var rawNotes = doc.ReviewNotes || doc.reviewNotes || '';
                                    var comments = (typeof rawNotes === 'string')
                                        ? rawNotes.replace(/\r/g, '').replace(/<BR>/gi, '<br>')
                                    : '';
                                    var docId = "doc" + (doc.DocumentID || doc.documentID) + "_" + index;
                                    
                                    // For display in main list, remove version suffix (_v1, _v2, etc.) from filename
                                    // The database stores versioned filenames (e.g., file-sample_150kB_v1.pdf)
                                    // But we want to display the base filename (e.g., file-sample_150kB.pdf) in the main list
                                    var displayFileName = doc.FileName || doc.fileName || '';
                                    var fileExtension = doc.Extension || doc.extension || doc.FileExtension || doc.fileExtension || '';
                                    
                                    // Remove version suffix pattern: _v1, _v2, _v3, etc. (before the extension)
                                    if (displayFileName) {
                                        // Pattern: _v followed by digits before the extension
                                        // Example: file-sample_150kB_v1.pdf -> file-sample_150kB.pdf
                                        displayFileName = displayFileName.replace(/_v\d+\./i, '.');
                                        // Also handle case where version suffix is at the end (no extension)
                                        displayFileName = displayFileName.replace(/_v\d+$/i, '');
                                    }
                                    
                                    // If we have a separate extension field and filename doesn't have extension, add it
                                    if (fileExtension && fileExtension.trim() !== '' && displayFileName.indexOf('.') === -1) {
                                        displayFileName = displayFileName + '.' + fileExtension;
                                    }

                                html += `
                    <tr data-document-id="${(doc.DocumentID || doc.documentID)}">
                        <td></td>
                        <td>${doc.SubCategory ? doc.SubCategory : (doc.subCategory || '')}</td>
              <td>
                       <a href="javascript:void(0);"
                         class="text-center"
                             onclick="downloadDocument('${(doc.DocumentID || doc.documentID)}', '${(doc.ProjectID || doc.projectID)}', '${(doc.FileName || doc.fileName || '').replace(/'/g, "\\'")}', '${(doc.Extension || doc.extension || doc.FileExtension || doc.fileExtension || '').replace(/'/g, "\\'")}')">
                        ${displayFileName}
                                 </a>
                                  </td>
                        <td class="uploaded-by-cell">${userAvatarHTML}<span class="user-name">${uploadedBy || ''}</span></td>
                        <td>${uploadedDate}</td>
                        <td>${fileSize}</td>
                        <td>${updatedDate ? updatedDate : ''}</td>
                        <td style="text-align: center;">
                            <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#Doc_reviewOffScreen" title="${ResourceStrings.C_Review}" onclick="showReview(${(doc.DocumentID || doc.documentID)})" style="margin-right: 10px;">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="javascript:void(0);" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools" title="${ResourceStrings.C_ShowHistory}" onclick="showhistory(${(doc.DocumentID || doc.documentID)}, null)">
                                <i class="fas fa-history"></i>
  </a>
                        </td>
                        ${m_blnDeleteAccess ? `<td class="sm-wid" style="text-align:center;">
                            <div class="custom_chckbox">
                                <input id="${docId}" class="chckHead doc-chck" type="checkbox" data-documentid="${(doc.DocumentID || doc.documentID)}" data-projectid="${(doc.ProjectID || doc.projectID)}">
                                <label for="${docId}"></label>
                            </div>
                        </td>` : ''}
                    </tr>`;
                                                                    
                                    var isDetailView = window.detailViewActive || false;
                                    if (isDetailView) {
                                        // Get document comments (description) - ensure we have a fallback
                                        var documentComment = (doc.Description || doc.description || '').trim();
                                        if (!documentComment || documentComment === '') {
                                            documentComment = 'N/A';
                                        }
                                        
                                        // Check if document has been reviewed
                                        var hasReviewData = false;
                                        var reviewedBy = doc.ReviewedBy || doc.reviewedBy || doc.ReviewBy || doc.reviewBy || '';
                                        var reviewedDate = doc.ReviewedDate || doc.reviewedDate || null;
                                        var rawReviewNotes = doc.ReviewNotes || doc.reviewNotes || '';
                                        var hasReviewNotes = (rawReviewNotes && typeof rawReviewNotes === 'string' && rawReviewNotes.trim() !== '') || 
                                                           (Array.isArray(rawReviewNotes) && rawReviewNotes.length > 0);
                                        
                                        // Document is considered reviewed if it has review data
                                        if (reviewedBy || reviewedDate || hasReviewNotes) {
                                            hasReviewData = true;
                                        }
                                        
                                        var detailViewHtml = '';
                                        
                                        // Get resource strings with fallbacks
                                        var commentsLabel = (ResourceStrings && ResourceStrings.C_CommentsColon) ? ResourceStrings.C_CommentsColon : 'Comments:';
                                        var reviewedByLabel = (ResourceStrings && ResourceStrings.C_ReviewedBy) ? ResourceStrings.C_ReviewedBy : 'Reviewed By:';
                                        var reviewDateLabel = (ResourceStrings && ResourceStrings.C_ReviewDate) ? ResourceStrings.C_ReviewDate : 'Review Date:';
                                        var reviewCommentsLabel = (ResourceStrings && ResourceStrings.C_ReviewCommentsColon) ? ResourceStrings.C_ReviewCommentsColon : 'Review Comments:';
                                        var noCommentsText = 'N/A';
                                        
                                        if (!hasReviewData) {
                                            // Document NOT reviewed - Show only Comments
                                            detailViewHtml = `
                    <tr class="detail-view-wrap" data-document-id="${(doc.DocumentID || doc.documentID || '')}" style="background-color: #f5f5f5 !important;">
                        <td colspan="${m_blnDeleteAccess ? 9 : 8}" style="padding: 15px; border-top: 2px solid #f5f5f5; border-bottom: 2px solid #f5f5f5;">
                            <div style="text-align: left;">
                                <p style="margin: 5px 0;"><strong>${commentsLabel}</strong> ${documentComment || noCommentsText}</p>
                            </div>
                        </td>
                    </tr>`;
                                        } else {
                                            // Document IS reviewed - Show all 4 fields
                                            
                                            // Get latest reviewer - check multiple possible field names
                                            var reviewBy = (reviewedBy && reviewedBy.trim() !== '') ? reviewedBy.trim() : 'N/A';
                                           
                                            var latestReviewNotes = '';
                                            
                                            if (Array.isArray(rawReviewNotes)) {
                                                // If it's an array, get the first element (latest)
                                                latestReviewNotes = rawReviewNotes.length > 0 ? String(rawReviewNotes[0]) : noCommentsText;
                                            } else if (typeof rawReviewNotes === 'string' && rawReviewNotes.trim() !== '') {
                                              
                                                var parts = rawReviewNotes.split(/<br>|<BR>|\n\n|\r\n\r\n/);
                                                latestReviewNotes = parts.length > 0 ? parts[0].trim() : rawReviewNotes.trim();
                                            } else {
                                                latestReviewNotes = noCommentsText;
                                            }
                                            
                                            // Clean up the review comments
                                            if (latestReviewNotes && latestReviewNotes !== noCommentsText) {
                                                latestReviewNotes = latestReviewNotes.replace(/\r/g, '').replace(/<BR>/gi, '<br>').trim();
                                            }
                                            if (!latestReviewNotes || latestReviewNotes === '') {
                                                latestReviewNotes = noCommentsText;
                                            }
                                            
                                            // Format Review Date with time (latest review only)
                                            var reviewDateWithTime = 'N/A';
                                            if (reviewedDate) {
                                                try {
                                                    var dateObj = new Date(reviewedDate);
                                                    if (!isNaN(dateObj.getTime())) {
                                                        var day = dateObj.getDate().toString().padStart(2, '0');
                                                        var month = (dateObj.getMonth() + 1).toString().padStart(2, '0');
                                                        var year = dateObj.getFullYear();
                                                        var hours = dateObj.getHours().toString().padStart(2, '0');
                                                        var minutes = dateObj.getMinutes().toString().padStart(2, '0');
                                                        reviewDateWithTime = `${day}/${month}/${year} ${hours}:${minutes}`;
                                                    }
                                                } catch (e) {
                                                    reviewDateWithTime = formatDate(reviewedDate) || 'N/A';
                                                }
                                            }
                                            
                                            detailViewHtml = `
                    <tr class="detail-view-wrap" data-document-id="${(doc.DocumentID || doc.documentID || '')}" style="background-color: #f5f5f5 !important;">
                        <td colspan="${m_blnDeleteAccess ? 9 : 8}" style="padding: 15px; border-top: 2px solid #f5f5f5; border-bottom: 2px solid #f5f5f5;">
                            <div style="text-align: left;">
                                <p style="margin: 5px 0;"><strong>${commentsLabel}</strong> ${documentComment || noCommentsText}</p>
                                <p style="margin: 5px 0;"><strong>${reviewedByLabel}</strong> ${reviewBy}</p>
                                <p style="margin: 5px 0;"><strong>${reviewDateLabel}</strong> ${reviewDateWithTime}</p>
                                <p style="margin: 5px 0;"><strong>${reviewCommentsLabel}</strong> ${latestReviewNotes}</p>
                            </div>
                        </td>
                    </tr>`;
                                        }
                                        
                                        html += detailViewHtml;
                                    }
                                }
                            });
                        });

                        // Clear tbody first
                        tbody.innerHTML = '';
                        
                        // Insert HTML
                        tbody.insertAdjacentHTML("beforeend", html);
                      
                        // Wait for DOM to update before updating badges and pagination
                        setTimeout(function() {
                            // Clean up any existing DataTables instances
                            try {
                                if ($.fn.DataTable.isDataTable("#urlstable")) {
                                    $("#urlstable").DataTable().destroy();
                                }
                            } catch (e) {
                                // Ignore destroy errors
                            }
                            
                            try {
                                if ($.fn.DataTable.isDataTable("#prodocumentstbl")) {
                                    $("#prodocumentstbl").DataTable().destroy();
                                }
                            } catch (e) {
                                // Ignore destroy errors
                            }
                            
                            // Initialize tooltips and pagination based on which table is active
                            if (isUrlsView) {
                                // Initialize Bootstrap tooltips for description ellipsis
                                var tooltipTriggerList = [].slice.call(document.querySelectorAll('#urlstable td span.desc-ellipsis[title]'));
                                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                                    return new bootstrap.Tooltip(tooltipTriggerEl);
                                });
                            } else {
                                // Force column width for uploaded documents table
                                $('#prodocumentstbl th:nth-child(4), #prodocumentstbl td:nth-child(4)').css({
                                    'width': '180px',
                                    'max-width': '180px',
                                    'min-width': '150px'
                                });
                            }
                            
                            // Reset to first page and show paginated rows
                            currentPage = 1;
                            showPageRows();
                            
                            // Update user avatars in the table after rendering
                            updateTableAvatars();
                            // Added by Vaibhav K to hide loader on 11-03-26
                            hideLoader();
                            // End of Added by Vaibhav K to hide loader on 11-03-26
                        }, 100); // Delay slightly to ensure DOM is ready                                    
                }
                // End of addition by Nischal C on 3/11/2025 Process documents API response

                // Added by Nischal C on 3/11/2025 - Update user avatars in the "Uploaded By" column
                // This function updates user avatars in the documents table based on the current employee information
                function updateTableAvatars(imagePath, employeeName) {
                    try {
                        // Use global variables if parameters are not provided
                        if (!imagePath && window.currentEmployeeImage) {
                            imagePath = window.currentEmployeeImage;
                        }
                        if (!employeeName && window.currentEmployeeName) {
                            employeeName = window.currentEmployeeName;
                        }
                        
                        // If we don't have image path or employee name, skip
                        if (!imagePath || !employeeName) {
                            return;
                        }
                        
                        var $tableAvatars = $(".user-avatar img");
                        if ($tableAvatars.length === 0) {
                            return;
                        }
                        
                        var updatedCount = 0;
                        // Update avatars that match the current user
                        $tableAvatars.each(function() {
                            var $avatar = $(this);
                            var $row = $avatar.closest('tr');
                            var $uploadedByCell = $row.find('.uploaded-by-cell');
                            var uploadedByName = $uploadedByCell.find('.user-name').text().trim();
                            
                            // If the uploaded by name matches the current employee, update the avatar
                            if (uploadedByName && employeeName) {
                                var nameMatches = false;
                                
                                // Exact match (case-insensitive)
                                if (uploadedByName.toLowerCase() === employeeName.toLowerCase()) {
                                    nameMatches = true;
                                }
                                // Partial match for "Admin" users
                                else if (uploadedByName.toLowerCase() === 'admin' && 
                                         (employeeName.toLowerCase().includes('admin') || 
                                          employeeName.toLowerCase().includes('tool admin'))) {
                                    nameMatches = true;
                                }
                                // Check if employee name contains the uploaded by name (for partial matches)
                                else if (employeeName.toLowerCase().includes(uploadedByName.toLowerCase()) ||
                                         uploadedByName.toLowerCase().includes(employeeName.toLowerCase())) {
                                    nameMatches = true;
                                }
                                
                                if (nameMatches) {
                                    // Set onerror handler to fallback to no-photo.png if image fails to load
                                    $avatar.off('error').on('error', function() {
                                        $(this).attr("src", "../../../Images/Photo/no-photo.png");
                                    });
                                    // Update src
                                    $avatar.attr("src", imagePath);
                                    updatedCount++;
                                }
                            }
                        });
                    } catch (e) {
                        console.error('Error in updateTableAvatars:', e);
                    }
                }
                // End of Added by Nischal C on 3/11/2025 - Update user avatars in the "Uploaded By" column

                // Added by Nischal C on 3/11/2025 - Format date string
                function formatDate(dateStr) {
                    if (!dateStr) return '-';
                    var date = new Date(dateStr);
                    if (isNaN(date)) return '-';

                    var day = date.getDate().toString().padStart(2, '0');
                    var month = (date.getMonth() + 1).toString().padStart(2, '0'); // Month is 0-based
                    var year = date.getFullYear();

                    return `${day}/${month}/${year}`;
                }
                // End of addition by Nischal C on 3/11/2025 Format date string

                // Format date with time in "Oct 31 2025 2:40PM" format
                function formatDateWithTime(dateStr) {
                    if (!dateStr || dateStr === 'N/A' || dateStr === '') return 'N/A';
                    
                    // If already in desired format (contains "Oct", "Nov", etc. and "AM" or "PM"), return as is
                    if (dateStr.indexOf('AM') >= 0 || dateStr.indexOf('PM') >= 0) {
                        var hasMonthName = /(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)/i.test(dateStr);
                        if (hasMonthName) {
                            return dateStr; // Already in correct format
                        }
                    }
                    
                    // Try to parse the date
                    // Handle SQL Server datetime format: "2025-11-03 12:54:37.297" or ISO format: "2025-11-03T12:54:37.297"
                    var date = null;
                    
                    // If it's in SQL Server format (YYYY-MM-DD HH:mm:ss.sss), parse it as local time
                    if (typeof dateStr === 'string') {
                        // Handle format: "2025-11-03 12:54:37.297" or "2025-11-03T12:54:37.297"
                        var sqlFormatMatch = dateStr.match(/^(\d{4})-(\d{2})-(\d{2})[T\s](\d{2}):(\d{2}):(\d{2})(?:\.(\d+))?/);
                        if (sqlFormatMatch) {
                            var year = parseInt(sqlFormatMatch[1]);
                            var month = parseInt(sqlFormatMatch[2]) - 1; // JavaScript months are 0-based
                            var day = parseInt(sqlFormatMatch[3]);
                            var hour = parseInt(sqlFormatMatch[4]);
                            var minute = parseInt(sqlFormatMatch[5]);
                            var second = parseInt(sqlFormatMatch[6]);
                            // Create date in local timezone (not UTC)
                            date = new Date(year, month, day, hour, minute, second);
                        } else {
                            // Try standard Date parsing
                            date = new Date(dateStr);
                        }
                    } else {
                        date = new Date(dateStr);
                    }
                    
                    if (!date || isNaN(date.getTime())) {
                        return dateStr; // Return original if can't parse
                    }
                    
                    // Format: "Oct 31 2025 2:40PM"
                    var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    var month = monthNames[date.getMonth()];
                    var day = date.getDate();
                    var year = date.getFullYear();
                    var hours = date.getHours();
                    var minutes = date.getMinutes();
                    
                    // Convert to 12-hour format with AM/PM
                    var ampm = hours >= 12 ? 'PM' : 'AM';
                    hours = hours % 12;
                    hours = hours ? hours : 12; // 0 should be 12
                    var minutesStr = minutes < 10 ? '0' + minutes : minutes;
                    
                    return `${month} ${day} ${year} ${hours}:${minutesStr}${ampm}`;
                }


                // Added by Nischal C on 3/11/2025 - Upload document with validation
                function uploadDocument() {
                    
                    // Check add access permission
                    if (!m_blnAddAccess) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_NoPermissionUpload);
                        return;
                    }

                    if (selectedFiles.length === 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_PleaseSelectFile);
                        return;
                    }
                    //Added by Vishal Mane on 19/01/2026 to show only one alert
                    var IsDocSelected = 1;
                    //End of Added by Vishal Mane on 19/01/2026 to show only one alert
                    $('#bodyMainFiles tr').each(function (index, row) {
                        var $row = $(row);

                        // Find the file 
                        var file = selectedFiles[index];
                        if (!file) return; // Safety check

                        // Validate max file size
                        if (file.size > parseInt(MaxFileSize)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_FileSizeExceeds.replace("{0}", MaxFileSize));
                            return;
                        }

                        // Validate file extension using config (same logic as old page)
                        var strFileExtension = FileExtensionDisallow || '';
                        var validateExtensions = [];
                        var allowSubmit = false;
                        
                        if (strFileExtension && strFileExtension.length > 0) {
                            validateExtensions = strFileExtension.split(",");
                            
                            var fileValue = file.name;
                            var extension = fileValue.slice(fileValue.lastIndexOf('.') + 1).toLowerCase();
                            
                            for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                                var strExtn = validateExtensions[cnt].trim().toLowerCase();
                                if (strExtn === extension) {
                                    allowSubmit = true;
                                    break;
                                }
                            }
                            
                            if (allowSubmit === false) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_InvalidFileExtension.replace("{0}", validateExtensions.join(", ").toUpperCase()));
                            return;
                            }
                        }
                        //Commented by Vishal Mane on 15/01/2026 to fix issue : When file name exceeds 260 characters then is gives alert message
                        // Validate multiple dots (same as old page)
                        var countOfDot = 0;
                        if (file.name != '') {
                            countOfDot = file.name.split(".").length - 1;
                        }                        
                        if (countOfDot > 1) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_MultipleExtensions);
                            return;
                        }
                       //End of Commented by Vishal Mane on 15/01/2026 to fix issue : When file name exceeds 260 characters then is gives alert message

                        // Validate filename length (same as old page)
                        var FileNameCharCount = 0;
                        if (file.name != '') {
                            FileNameCharCount = file.name.split(".")[0].length;
                        }                        
                        if (FileNameCharCount > 120) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_FileNameTooLong);
                            return;
                        }
                        var categoryID = $row.find('.CateTypeID').val();
                        // Validate that category is selected
                        //Added by Vishal Mane on 19/01/2026 to show only one alert                        
                        if (!categoryID || categoryID === '0' || categoryID === 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            if (IsDocSelected == 1) {
                                alertify.error(ResourceStrings.A_PleaseSelectDocumentType.replace("{0}", file.name));
                            }                                
                            IsDocSelected = 0;
                            return;
                        }                       
                        //End of Added by Vishal Mane on 19/01/2026 to show only one alert

                        var subcateID = $row.find('select.SubCateTypeID').val();

                        if (!subcateID || subcateID === '0') {
                            subcateID = null;
                        }

                        var changeReTypeID = $row.find('select.ChangeReTypeID').val();

                        if (!changeReTypeID || changeReTypeID === '0') {
                            changeReTypeID = null;
                        }
                        //Added by Vishal Mane on 20/01/2026 to get Comment Value
                        //var commentValue = $row.find('input[type="text"]').val();
                        var commentValue = $row.find('textarea.dynamic-textarea').val();
                        //End of Added by Vishal Mane on 20/01/2026 to get Comment Value
                        // Validate parameters before API call
                        if (!currentProjectID || currentProjectID === 0 || currentProjectID === '0') {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_ProjectIDMissing.replace("{0}", file.name));
                            return;
                        }
                        
                        if (!categoryID || categoryID === 0 || categoryID === '0') {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_CategoryMissing.replace("{0}", file.name));
                            return;
                        }
                        
                        // Check if directory structure exists - the API will create it if it doesn't exist
                        // This matches the old page behavior where directories are created on-the-fly
                        var dirName = {
                            ProjectID: parseInt(currentProjectID), // Ensure it's an integer
                            CategoryID: parseInt(categoryID), // Ensure it's an integer
                            SubCategoryID: (subcateID && subcateID !== null && subcateID !== '0') ? parseInt(subcateID) : null // Convert to int or null
                        };

                        var param = JSON.stringify(dirName);
                        var apiResult = null;

                        var url = "/api/DocumentUpload/CheckIfDirectoryStructureExists";
                        var result = AJAXCallWithResult(url, param, false);                       
                        apiResult = result;                        
                        var strDirectoryName = '';
                        var documentCode = '';
                        
                        // Handle API response - check for errors first
                        if (!apiResult) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_NoServerResponse.replace("{0}", file.name));
                            return;
                        }
                        
                        if (apiResult) {                         
                            if (apiResult.error && !apiResult.success) {                             
                                var errorMsg = apiResult.message || apiResult.Message || apiResult.error || "Directory structure check failed.";
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_ErrorGenericDetailed.replace("{0}", errorMsg).replace("{1}", file.name).replace("{2}", (apiResult.statusCode || 'Unknown')));
                                return;
                            }
                            
                            // Check if API call failed at top level
                            if (apiResult.status === 'FAILURE' || apiResult.Status === 'FAILURE') {
                                var errorMsg = (apiResult.data && apiResult.data.Message) || (apiResult.data && apiResult.data.message) || apiResult.message || "Directory structure not found.";
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_ErrorGenericSimple.replace("{0}", errorMsg).replace("{1}", file.name));
                                return;
                            }
                            
                            // Get the data from response - handle nested structures
                            var responseData = null;
                            if (apiResult.data) {
                                if (apiResult.data.data) {
                                    responseData = apiResult.data.data;
                                } else {
                                    responseData = apiResult.data;
                                }
                            } else {
                                responseData = apiResult;
                            }
                            var isFailure = false;
                            var errorMessage = '';
                                                      
                            if (apiResult && (apiResult.Status === 'FAILURE' || apiResult.status === 'FAILURE')) {
                                isFailure = true;
                                // Get error message from data or root level
                                if (responseData && (responseData.Message || responseData.message)) {
                                    errorMessage = responseData.Message || responseData.message;
                                } else {
                                    errorMessage = apiResult.message || apiResult.Message || "Directory structure check failed.";
                                }
                            }
                            
                            // Also check success flag in responseData (some APIs use this)
                            if (!isFailure && responseData && (responseData.success === false || responseData.Success === false)) {
                                isFailure = true;
                                errorMessage = responseData.message || responseData.Message || "Directory structure check failed.";
                            }
                            
                            // If there's a failure, it's a real error - stop upload
                            if (isFailure) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_ErrorGenericSimple.replace("{0}", errorMessage).replace("{1}", file.name));
                                return;
                            }
                            
                            // Extract directory path and document code - check multiple possible locations
                            if (responseData) {
                                strDirectoryName = responseData.DirectoryPath || responseData.directoryPath || responseData.DirectoryName || responseData.directoryName || '';
                                documentCode = responseData.DocumentCode || responseData.documentCode || '';
                            }
                            
                            // Also check at root level if not found in responseData
                            if ((!strDirectoryName || (strDirectoryName && strDirectoryName.trim() === '')) && apiResult) {
                                strDirectoryName = apiResult.DirectoryPath || apiResult.directoryPath || apiResult.DirectoryName || apiResult.directoryName || '';
                                documentCode = apiResult.DocumentCode || apiResult.documentCode || documentCode || '';
                            }
                        }
                         
                        if (!strDirectoryName || (strDirectoryName && strDirectoryName.trim() === '')) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_DirectoryPathMissing.replace("{0}", file.name));
                            return; // Cannot proceed without directory name
                        }

                        var today = new Date();
                        var createdDate = today.toISOString();
                        var lastModifiedDate = createdDate; 

                        var fileSizeKB = (file.size / 1024).toFixed(2);
                        
                        // Extract file extension and name safely
                        var lastDotIndex = file.name.lastIndexOf('.');
                        var extension = '';
                        var originalFileName = file.name;
                        
                        if (lastDotIndex !== -1 && lastDotIndex < file.name.length - 1) {
                            extension = file.name.substring(lastDotIndex + 1).toLowerCase(); // gets extension (e.g., 'xml', 'pdf')
                            originalFileName = file.name.substring(0, lastDotIndex); // filename without extension
                        } else {
                            // File has no extension or ends with a dot
                            extension = '';
                            originalFileName = file.name;
                        }             
                        var versionSuffixMatch = originalFileName.match(/^(.+?)_v(\d+)$/);
                        if (versionSuffixMatch && versionSuffixMatch.length > 1) {
                            originalFileName = versionSuffixMatch[1]; 
                        }
                        
                        // Also strip any double versioning patterns (e.g., "_v1_v1" -> strip both)
                        while (originalFileName.match(/^(.+?)_v(\d+)$/)) {
                            var match = originalFileName.match(/^(.+?)_v(\d+)$/);
                            if (match && match.length > 1) {
                                var newName = match[1];
                                if (newName === originalFileName) break; // Prevent infinite loop
                                originalFileName = newName;
                            } else {
                                break;
                            }
                        }

                        var calculatedVersionNumber = 1;
                        var calculatedVersionedFileName = originalFileName;
                                            
                        var fetchExistingParams = {
                            ProjectID: parseInt(currentProjectID),
                            DocumentID: null,
                            WhatToSelect: null,
                            LoginRoleID: intPostID,
                            FilePaging: "-1",
                            SearchText: null,
                            CategoryID: parseInt(categoryID),
                            SubCategoryID: (subcateID && subcateID !== null && subcateID !== '0') ? parseInt(subcateID) : null                         
                        };
                        fetchExistingParams = JSON.stringify(fetchExistingParams);
                        var url = "/api/DocumentUpload/GetAllDocuments";
                        var result = AJAXCallWithResult(url, fetchExistingParams, false);
                        existingDocsResult = result;                          
                      
                        if (existingDocsResult) {
                            var existingDocsData = existingDocsResult.data || existingDocsResult.Data || existingDocsResult;                           
                            var existingDocsArray = null;                          
                            if (Array.isArray(existingDocsData)) {
                                existingDocsArray = existingDocsData;
                            } else if (existingDocsData && existingDocsData.ProjectDocumentModel && Array.isArray(existingDocsData.ProjectDocumentModel)) {                            
                                existingDocsArray = existingDocsData.ProjectDocumentModel;
                            } else if (existingDocsData && existingDocsData.data && Array.isArray(existingDocsData.data)) {                             
                                existingDocsArray = existingDocsData.data;
                            } else if (existingDocsData && existingDocsData.items && Array.isArray(existingDocsData.items)) {
                                existingDocsArray = existingDocsData.items;
                            } else if (existingDocsData && existingDocsData.Documents && Array.isArray(existingDocsData.Documents)) {
                                existingDocsArray = existingDocsData.Documents;
                            } else {
                                existingDocsArray = [];
                            }                            
                            if (existingDocsArray && existingDocsArray.length > 0) {
                                existingDocsArray.forEach(function(doc, idx) {
                                    var fn = (doc.FileName || doc.fileName || '').trim();
                                    var ext = (doc.Extension || doc.extension || doc.FileExtension || doc.fileExtension || '').trim();
                                    var fullFn = ext ? fn + '.' + ext : fn;
                                    var isUrl = doc.IsURL || doc.isURL;
                                    var tagID = doc.TagID || doc.tagID || doc.TagId || doc.tagId;
                                    var uniqueID = doc.UniqueID || doc.uniqueID || doc.UniqueId || doc.uniqueId;
                                });                              
                                var baseFileNameWithExt = originalFileName + '.' + extension;
                                var baseFileNamePattern = originalFileName + '_v';                        
                                var currentTagID = parseInt(masterTagID);
                                var currentUniqueID = parseInt(currentProjectID);
                                
                                var matchingDocs = existingDocsArray.filter(function(doc) {                                  
                                    if (doc.IsURL || doc.isURL) {
                                        return false;
                                    }      
                                    var docTagID = doc.TagID || doc.tagID || doc.TagId || doc.tagId;
                                    var docUniqueID = doc.UniqueID || doc.uniqueID || doc.UniqueId || doc.uniqueId;

                                    if (docTagID != null && docTagID !== currentTagID) {
                                        return false;
                                    }
                                    if (docUniqueID != null && docUniqueID !== currentUniqueID) {
                                        return false;
                                    }
                                    
                                    var docFileName = (doc.FileName || doc.fileName || '').trim();
                                    var docExt = (doc.Extension || doc.extension || doc.FileExtension || doc.fileExtension || '').trim();

                                    var fullDocFileName = docExt ? docFileName + '.' + docExt : docFileName;

                                    if (fullDocFileName === baseFileNameWithExt) {
                                        return true;
                                    }

                                    if (fullDocFileName.indexOf(baseFileNamePattern) === 0) {
                                        var versionMatch = fullDocFileName.match(new RegExp('^' + baseFileNamePattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '\\d+'));
                                        if (versionMatch) {
                                            return true;
                                        }
                                    }

                                    if (docFileName === originalFileName) {
                                        return true; 
                                    }
                                    if (docFileName.indexOf(baseFileNamePattern) === 0) {
                                        var versionMatchFileName = docFileName.match(new RegExp('^' + baseFileNamePattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '\\d+$'));
                                        if (versionMatchFileName) {
                                            return true;
                                        }
                                    }
                                    
                                    return false;
                                });

                                var maxVersionNumber = 0;
                                matchingDocs.forEach(function(doc) {
                                    var fn = (doc.FileName || doc.fileName || '').trim();
                                    var ext = (doc.Extension || doc.extension || doc.FileExtension || doc.fileExtension || '').trim();
                                    var fullFn = ext ? fn + '.' + ext : fn;

                                    var versionMatch = fullFn.match(/_v(\d+)\./);
                                    if (versionMatch && versionMatch[1]) {
                                        var versionNum = parseInt(versionMatch[1]);
                                        if (versionNum > maxVersionNumber) {
                                            maxVersionNumber = versionNum;
                                        }
                                    }
                                });

                                if (matchingDocs.length > 0) {
                                    if (maxVersionNumber > matchingDocs.length) {

                                        calculatedVersionNumber = maxVersionNumber + 1;
                                    } else {
 
                                        calculatedVersionNumber = matchingDocs.length + 1;
                                    }
                                }
                            }
                        }

                        calculatedVersionedFileName = originalFileName + '_v' + calculatedVersionNumber + '.' + extension;
                      
                        var docUplParams = {
                            ProjectID: parseInt(currentProjectID), 
                            CategoryID: parseInt(categoryID), 
                            DirectoryName: (strDirectoryName && strDirectoryName.trim() !== '') ? strDirectoryName : null, 
                            UploadedFileName: originalFileName,
                            CreatedDate: createdDate, 
                            LastModifiedDate: lastModifiedDate, 
                            Description: commentValue || '',
                            fileSize: parseFloat(fileSizeKB),
                            Extension: extension,
                            FileName: originalFileName,
                            LogInID: parseInt(intUserID),
                            LoginType: loginType,
                            ChangeRID: (changeReTypeID && changeReTypeID !== null && changeReTypeID !== '0') ? parseInt(changeReTypeID) : null,
                            SubCategoryID: (subcateID && subcateID !== null && subcateID !== '0') ? parseInt(subcateID) : null,
                            TagID: parseInt(masterTagID), 
                            UniqueID: parseInt(currentProjectID),
                            CodeTemplate: documentCode || null
                        };

                        var param = JSON.stringify(docUplParams);
                        var uploadApiResult = null;                      
                        var url = "/api/DocumentUpload/UploadDocument";
                        var result = AJAXCallWithResult(url, param, false);
                        uploadApiResult = result;                           
                        var newDocumentID = null;                        
                        if (uploadApiResult) {
                            if (uploadApiResult.status === 'FAILURE' || uploadApiResult.Status === 'FAILURE') {
                                var errorMsg = (uploadApiResult.data && uploadApiResult.data.Message) || (uploadApiResult.data && uploadApiResult.data.message) || uploadApiResult.message || "Error uploading document.";
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_UploadFailed.replace("{0}", file.name).replace("{1}", errorMsg));
                                return;
                            }                      
                            var responseData = uploadApiResult.data || uploadApiResult.Data || uploadApiResult;
                            var uploadData = null;           
                            if (responseData && responseData.UploadDocumentResponseModel && Array.isArray(responseData.UploadDocumentResponseModel)) {
                                uploadData = responseData.UploadDocumentResponseModel;
                            } else if (responseData && responseData.data && Array.isArray(responseData.data)) {                              
                                uploadData = responseData.data;
                            } else if (Array.isArray(responseData)) {                              
                                uploadData = responseData;
                            } else if (responseData && typeof responseData === 'object') {                            
                                for (var key in responseData) {
                                    if (responseData.hasOwnProperty(key) && Array.isArray(responseData[key])) {
                                        uploadData = responseData[key];
                                        break;
                                    }
                                }
                         
                                if (!uploadData) {
                                    uploadData = responseData;
                                }
                            }
                                                   
                            if (Array.isArray(uploadData) && uploadData.length > 0) {                            
                                var firstItem = uploadData[0];
                                newDocumentID = firstItem.intID || firstItem.IntID || firstItem.DocumentID || firstItem.documentID || firstItem.intNewDocumentID || firstItem.IntNewDocumentID;
                            } else if (uploadData && typeof uploadData === 'object') {
                                // Single object result
                                newDocumentID = uploadData.intID || uploadData.IntID || uploadData.DocumentID || uploadData.documentID || uploadData.intNewDocumentID || uploadData.IntNewDocumentID;
                            }
                            
                        }

                        // Validate DirectoryName and DocumentID before proceeding
                        if (!strDirectoryName || (strDirectoryName && strDirectoryName.trim() === '')) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_DirectoryPathMissing.replace("{0}", file.name));
                            return;
                        }
                        
                        if (!newDocumentID) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_DocumentIDMissing.replace("{0}", file.name));
                            return;
                        }
                        var formData = new FormData();
                        formData.append("file", file);
                        formData.append("DirectoryName", strDirectoryName); // Ensure this is always set
                        formData.append("FileName", calculatedVersionedFileName); 

                  
                        if (index === 0) {
                            uploadStatus = { total: selectedFiles.length, success: 0, failed: 0, errors: [] };
                        }

                        uploadFileWithFormData("/api/DocumentUpload/SaveFileToServer", formData, index, selectedFiles.length, file.name, newDocumentID, calculatedVersionedFileName);

                    });
                }
                // End of addition by Nischal C on 3/11/2025 Upload document with validation

                // Added by Nischal C on 3/11/2025 - Attach URL to document
                function Attach_OnClick() {
                  
                    if (!m_blnAddAccess) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_NoPermissionAttachURL);
                        return;
                    }

                    let $txtURL = $('#txtURL');
                    let urlValue = $txtURL.val().trim();

                    if (urlValue === '') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_PleaseEnterURL);
                        $txtURL.focus();
                        return;
                    }

                    if (!IsValidURL(urlValue)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_InvalidURLFormat);
                        $txtURL.focus();
                        return;
                    }

                    if (urlValue.charAt(0).toLowerCase() !== 'h') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_URLMustStartWithHttp);
                        $txtURL.focus();
                        return;
                    }

                    // Validate document category (must be selected before description)
                    let $cboCategory = $('#cboAttachCate');
                    let categoryValue = $cboCategory.val();
                    if (!categoryValue || categoryValue === '0' || categoryValue === '' || categoryValue === null || parseInt(categoryValue) === 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_PleaseSelectCategory);
                        $cboCategory.focus();
                        // Trigger Bootstrap Select to show dropdown
                        $cboCategory.selectpicker('toggle');
                        return;
                    }

                    var subCate = $('#cboAttachSubCate').val();

                    // Validate description (after category validation)
                    let $txtDesc = $('#txtDescription');
                    let descValue = $txtDesc.val().trim();

                    if (descValue === '') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_PleaseEnterDescription);
                        $txtDesc.focus();
                        return;
                    }

                    if (descValue.length > 3000) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_DescriptionMaxLength);
                        $txtDesc.focus();
                        return;
                    }

                    var attachUrl = {
                        CategoryID: parseInt(categoryValue),
                        ProjectID: currentProjectID,
                        DirectoryName: urlValue,
                        UploadedFileName: descValue,
                        LogInID: intUserID,
                        LoginType: loginType,
                        SubCategoryID: (subCate && subCate !== '0' && subCate !== null) ? parseInt(subCate) : null,
                        TagID: masterTagID
                    };

                    var param = JSON.stringify(attachUrl);
                    var apiResult = null;
                    var url = "/api/DocumentUpload/AttachUrl";
                    var result = AJAXCallWithResult(url, param, false);
                    apiResult = result;
                    var result = [];
                    if (apiResult && apiResult.data && Array.isArray(apiResult.data)) {
                        result = apiResult.data;
                    } else if (apiResult && Array.isArray(apiResult)) {
                        result = apiResult;
                    } else if (apiResult && apiResult.data) {
                        result = [apiResult.data];
                    }
                                  
                    var isSuccess = true; // Default to success if we reached the success callback
                                 
                    if (apiResult && (apiResult.error === true || apiResult.error === 'true')) {
                        isSuccess = false;
                    }             
                    else if (apiResult && apiResult.status && 
                            (apiResult.status === "FAILURE" || apiResult.status === "failure" || apiResult.status === "ERROR")) {
                        isSuccess = false;
                    }
                    
                    if (isSuccess) {
                        // Clear all fields after successful attachment
                        $('#txtURL').val('');
                        $('#cboAttachCate').selectpicker('val', '0');

                        //Commentd and Added by Vaibhav K for Renaming Documents sub Category on 11-03-26
                        //$('#cboAttachSubCate').empty().append('<option value="0">Select sub category</option>');
                        $('#cboAttachSubCate').empty().append('<option value="0">Select Document Sub Category</option>');

                        //End of Commentd and Added by Vaibhav K for Renaming Documents sub Category on 11-03-26



                        $('#cboAttachSubCate').selectpicker('refresh');
                        $('#cboAttachSubCate').selectpicker('val', '0');
                        $('#txtDescription').val('');
                        
                    $('#cnl_Attach').trigger('click'); // Close modal or cancel

                    alertify.set('notifier', 'position', 'top-right');
                        alertify.success(ResourceStrings.A_URLAttachedSuccess);
                       
                        switchDocTab('urls', true); // Skip reload in switchDocTab
                        setTimeout(function() {
                            fetchAllDocuments(); // Refresh the table (newest will be at top due to sorting)
                        }, 300);
                    } else {
                        // Show error message but don't clear the fields
                        var errorMsg = apiResult.message || apiResult.Message || 'Failed to attach URL';
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(errorMsg);
                    }

                }
                // End of addition by Nischal C on 3/11/2025 Attach URL to document

                // Added by Nischal C on 3/11/2025 - Delete selected documents
                function deletDocument() {
                    // Check delete access permission
                    if (!m_blnDeleteAccess) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_NoPermissionDelete);
                        return;
                    }
                    
                    var selectedIDs = [];
                    var selProjIDs = [];
                    var hasUrlCheckboxes = false;
                    var hasDocCheckboxes = false;
                    
                    $(".doc-chck:checked").each(function () {
                        var $checkbox = $(this);
                        selectedIDs.push($checkbox.data("documentid"));
                        selProjIDs.push($checkbox.data("projectid"));
                        // Check if checkbox is in URLs table or documents table
                        if ($checkbox.closest('#tbodyUrls').length > 0) {
                            hasUrlCheckboxes = true;
                        } else if ($checkbox.closest('#tbodyReqSpe').length > 0) {
                            hasDocCheckboxes = true;
                        }
                    });

                    ProjectID: $(this).data("projectid")

                    if (selectedIDs.length === 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_PleaseSelectDocument);
                        return;
                    }
                    
                    // Determine if URLs or documents are being deleted
                    var isDeletingUrls = hasUrlCheckboxes && !hasDocCheckboxes;
                    
                    // Show confirmation modal with appropriate message
                    var confirmMsg = isDeletingUrls 
                        ? ResourceStrings.A_ConfirmDeleteURLs 
                        : ResourceStrings.A_ConfirmDeleteDocuments;
                    $("#ConfirmationMsg").html(confirmMsg);
                    // Use Bootstrap 5 API - get or create instance to avoid conflicts
                    var modalElement = document.getElementById('deleteinfomodal');
                    if (modalElement) {
                        var deleteModal = bootstrap.Modal.getOrCreateInstance(modalElement);
                        deleteModal.show();
                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Delete confirmation modal not found.');
                        return;
                    }
                    
                    // Wait for user response
                    getConfirmationResponse().then(response => {
                        if (response == 1) {
                    // "A" = Delete ALL versions of the document (following PM_ProjectDocuments.aspx.vb pattern)
                    // "I" = Delete only the individual/selected document
                    var strWhatToDelete = "A"; // Always use "A" to delete all versions like the old page

                    var docUplParams = {
                                ProjectID: currentProjectID,
                        DocumentID: selectedIDs.join(','), 
                                WhatToDelete: strWhatToDelete
                    };
                    var param = JSON.stringify(docUplParams);
                    var url = "/api/DocumentUpload/DeleteSelectedDocuments";
                    var result = AJAXCallWithResult(url, param, false); 
                    apiResult = result;                          
                    var result = {};

                            if (apiResult && apiResult.data) {
                                if (apiResult.data.data) {
                                    result = apiResult.data.data;
                                } else {
                                    result = apiResult.data;
                                }
                            } else if (apiResult) {
                                result = apiResult;
                            }

                                // Determine if URLs or documents were deleted
                            var isDeletingUrls = hasUrlCheckboxes && !hasDocCheckboxes;
                            
                            // Get the raw message from API
                            var rawMsg = result.Message || result.message || '';
                            
                            // Remove "Deleted: X" pattern from the message
                            var msg = rawMsg.replace(/\s*Deleted:\s*\d+\s*/gi, '').trim();
                            
                            // Always use the appropriate message based on what was deleted
                            // This ensures correct message even if API returns wrong message
                            msg = isDeletingUrls 
                                ? ResourceStrings.A_SelectedURLDeletedSuccess 
                                : ResourceStrings.A_SelectedDocumentDeletedSuccess;

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(msg);

                    fetchAllDocuments();
                        } else {
                            // User clicked No - do nothing
                        }
                    });

                }
                // End of addition by Nischal C on 3/11/2025 Delete selected documents
                
                // Added by Nischal C on 3/11/2025 - Get confirmation response from modal
                function getConfirmationResponse() {
                    return new Promise(resolve => {
                        $('#btnConfirmTaskYes').off('click').on('click', function () {
                            var deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteinfomodal'));
                            if (deleteModal) deleteModal.hide();
                            resolve(1);
                        });
                        $('#btnConfirmTaskNo').off('click').on('click', function () {
                            var deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteinfomodal'));
                            if (deleteModal) deleteModal.hide();
                            resolve(0);
                        });
                        $('#btnConfirmTaskNo1').off('click').on('click', function () {
                            var deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteinfomodal'));
                            if (deleteModal) deleteModal.hide();
                            resolve(0);
                        });
                    });
                }
                // End of addition by Nischal C on 3/11/2025 Get confirmation response from modal

                // Added by Nischal C on 3/11/2025 - Show document history
                function showHistory(docId) {
                    // Wrapper to support existing onclicks
                    showhistory(docId, null);
                }
                // End of addition by Nischal C on 3/11/2025 Show document history

                // Added by Nischal C on 3/11/2025 - Toggle versions collapsible section
                function toggleVersions(containerId, collapsedId) {
                    var container = document.getElementById(containerId);
                    var icon = document.getElementById(containerId + '_icon');
                    if (container) {
                        if (container.style.display === 'none') {
                            container.style.display = 'block';
                            if (icon) icon.textContent = '▲';
                        } else {
                            container.style.display = 'none';
                            if (icon) icon.textContent = '▼';
                        }
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Toggle versions collapsible section

                // Added by Nischal C on 3/11/2025 - Show document history with flags
                function showhistory(flag1, flag2) {
                    //debugger
                    // Clear previous history
                    $('#historyClassic').html('').show();

                    var docID;

                    // Determine which ID to use
                    // If flag1 exists and is valid, use it; otherwise use flag2
                    if (flag1 && flag1 !== 'null' && flag1 !== null && flag1 !== undefined && flag1 !== 'undefined' && flag1 !== 0) {
                        docID = flag1;
                    } else if (flag2 && flag2 !== 'null' && flag2 !== null && flag2 !== undefined && flag2 !== 'undefined' && flag2 !== 0) {
                        docID = flag2;
                    } else {
                        $('#historyClassic').html('<div style="padding:8px;">' + ResourceStrings.A_DocumentIDMissingHistory + '</div>').show();
                        return;
                    }

                    // Validate DocumentID
                    if (!docID || docID === '0' || docID === 0) {
                        $('#historyClassic').html('<div style="padding:8px;">' + ResourceStrings.A_ErrorInvalidDocumentID + '</div>').show();
                        return;
                    }

                    var firstDocParams = {
                        ProjectID: currentProjectID,
                        DocumentID: docID
                    };

                    var firstDocParam = JSON.stringify(firstDocParams);
                    var firstDocResult = null;
                    var url = "/api/DocumentUpload/ShowHistory";
                    var result = AJAXCallWithResult(url,firstDocParam, false);
                   
                    firstDocResult = result;
                       

                    var originalDocumentID = null; // The original DocumentID that links all versions
                    var firstDocArray = [];

                    try {
                        // Try multiple response structures
                        if (firstDocResult) {
                            // Check if it's directly an array
                            if (Array.isArray(firstDocResult)) {
                                firstDocArray = firstDocResult;
                            }
                            // Check if it has a data property
                            else if (firstDocResult.data) {
                                // data is array
                                if (Array.isArray(firstDocResult.data)) {
                                    firstDocArray = firstDocResult.data;
                                }
                                // data has nested data property
                                else if (firstDocResult.data.data && Array.isArray(firstDocResult.data.data)) {
                                    firstDocArray = firstDocResult.data.data;
                                }
                                // data has ProjectDocumentModel property
                                else if (firstDocResult.data.ProjectDocumentModel && Array.isArray(firstDocResult.data.ProjectDocumentModel)) {
                                    firstDocArray = firstDocResult.data.ProjectDocumentModel;
                                }
                                // data has Documents property
                                else if (firstDocResult.data.Documents && Array.isArray(firstDocResult.data.Documents)) {
                                    firstDocArray = firstDocResult.data.Documents;
                                }
                                // Try to find any array in data object
                                else if (typeof firstDocResult.data === 'object') {
                                    for (var key in firstDocResult.data) {
                                        if (Array.isArray(firstDocResult.data[key])) {
                                            firstDocArray = firstDocResult.data[key];
                                            break;
                                        }
                                    }
                                }
                            }
                        }


                        if (firstDocArray.length > 0) {
                            var firstDoc = firstDocArray[0];
                            var docRefID = firstDoc.DocumentRefID || firstDoc.documentRefID;
                            var docIDValue = firstDoc.DocumentID || firstDoc.documentID;


                            
                            originalDocumentID = docRefID || docIDValue;
                        } else {
                            originalDocumentID = docID; // Fallback - use the passed DocumentID
                        }
                    } catch (e) {
                        originalDocumentID = docID; // Fallback
                    }

                    if (!originalDocumentID) {
                        originalDocumentID = docID;
                    }

                  
                    var allDocuments = [];
                    var tbody = document.querySelector('#tbodyReqSpe');

                    if (tbody && tbody.children.length > 0) {
                        // Extract document data from DOM rows
                        $(tbody).find('tr[data-document-id]').each(function () {
                            var row = $(this);
                            var docID = row.attr('data-document-id');
                            if (docID) {
                              
                            }
                        });
                    }

                   
                    var firstDocCategoryID = null;
                    var firstDocSubCategoryID = null;
                    if (firstDocArray.length > 0) {
                        var firstDoc = firstDocArray[0];
                        firstDocCategoryID = firstDoc.CategoryID || firstDoc.categoryID || firstDoc.CategoryId || firstDoc.categoryId;
                        firstDocSubCategoryID = firstDoc.SubCategoryID || firstDoc.subCategoryID || firstDoc.SubCategoryId || firstDoc.subCategoryId;
                    }

                    
                    var getAllDocsParams = {
                        ProjectID: currentProjectID,
                        DocumentID: null,  // Get all documents
                        WhatToSelect: null,
                        LoginRoleID: typeof intPostID !== 'undefined' ? intPostID : null,
                        FilePaging: "-1",  // Match fetchAllDocuments format exactly
                        SearchText: null,
                        CategoryID: firstDocCategoryID || null,  
                        SubCategoryID: firstDocSubCategoryID || null  
                    };


                    var getAllDocsParam = JSON.stringify(getAllDocsParams);
                    var apiResult = null;
                    var url = "/api/DocumentUpload/GetAllDocuments";
                    var result = AJAXCallWithResult(url, getAllDocsParam, false);
                    apiResult = result;                     
                    // Normalize API response to a flat array
                    var allDocuments = [];
                    try {
                        if (apiResult) {
                            // Check if API call failed
                            if (apiResult.status === 'FAILURE' || apiResult.Status === 'FAILURE') {
                                var errorMsg = (apiResult.data && apiResult.data.Message) || (apiResult.data && apiResult.data.message) || apiResult.message || "Error loading history.";
                                $('#historyClassic').html('<div style="padding:8px;">' + ResourceStrings.A_ErrorLoadingHistory.replace("{0}", errorMsg) + '</div>').show();
                                return;
                            }

                            if (apiResult.data) {
                                // Check if data has a nested data property
                                if (apiResult.data.data && Array.isArray(apiResult.data.data)) {
                                    allDocuments = apiResult.data.data;
                                }
                                // Check if data is directly an array (List<ProjectDocumentModel>)
                                else if (Array.isArray(apiResult.data)) {
                                    allDocuments = apiResult.data;
                                }
                                // Check if data has a Documents property
                                else if (apiResult.data.Documents && Array.isArray(apiResult.data.Documents)) {
                                    allDocuments = apiResult.data.Documents;
                                }
                                // Check if data is an object with ProjectDocumentModel array
                                else if (apiResult.data.ProjectDocumentModel && Array.isArray(apiResult.data.ProjectDocumentModel)) {
                                    allDocuments = apiResult.data.ProjectDocumentModel;
                                }
                                // Try to extract array from other possible structures
                                else if (typeof apiResult.data === 'object') {
                                    for (var key in apiResult.data) {
                                        if (Array.isArray(apiResult.data[key]) && key !== 'Documents') {
                                            allDocuments = apiResult.data[key];
                                            break;
                                        }
                                    }
                                    if (allDocuments.length === 0 && apiResult.data.Documents && Array.isArray(apiResult.data.Documents)) {
                                        allDocuments = apiResult.data.Documents;
                                    }
                                }
                            }
                            // Check if apiResult is directly an array
                            else if (Array.isArray(apiResult)) {
                                allDocuments = apiResult;
                            }
                        }


                        var result = [];

                        if (!originalDocumentID) {
                            result = firstDocArray;
                        } else if (allDocuments.length === 0) {
                            result = firstDocArray;
                        } else {
                            // Filter all documents to find versions
                            var originalDocIDInt = parseInt(originalDocumentID);

                            // Filter out URLs - we only want file documents, not URLs
                            var fileDocumentsOnly = allDocuments.filter(function (doc) {
                                var isURL = doc.IsURL || doc.isURL;
                                return !isURL;  // Only include non-URL documents
                            });

                            result = fileDocumentsOnly.filter(function (doc) {
                                var docRefID = doc.DocumentRefID || doc.documentRefID;
                                var docIDValue = doc.DocumentID || doc.documentID;
                                var docRefIDInt = docRefID ? parseInt(docRefID) : null;
                                var docIDValueInt = docIDValue ? parseInt(docIDValue) : null;

                               
                                var matches = (docRefIDInt !== null && docRefIDInt === originalDocIDInt) ||
                                    (docIDValueInt === originalDocIDInt && (docRefID === null || docRefID === undefined || docRefID === ''));

                                if (matches) {
                                }
                                return matches;
                            });


                            if (originalDocIDInt) {
                                
                                var expectedDocIDs = [originalDocIDInt]; // 

                               
                                fileDocumentsOnly.forEach(function (doc) {
                                    var docRefID = doc.DocumentRefID || doc.documentRefID;
                                    if (docRefID && parseInt(docRefID) === originalDocIDInt) {
                                        var docIDValue = doc.DocumentID || doc.documentID;
                                        if (docIDValue && !expectedDocIDs.includes(parseInt(docIDValue))) {
                                            expectedDocIDs.push(parseInt(docIDValue));
                                        }
                                    }
                                });

                                // Also check result array (documents already found)
                                result.forEach(function (doc) {
                                    var docIDValue = doc.DocumentID || doc.documentID;
                                    if (docIDValue && !expectedDocIDs.includes(parseInt(docIDValue))) {
                                        expectedDocIDs.push(parseInt(docIDValue));
                                    }
                                });

                               
                                var foundDocIDs = [];
                                fileDocumentsOnly.forEach(function (doc) {
                                    var docRefID = doc.DocumentRefID || doc.documentRefID;
                                    var docIDValue = doc.DocumentID || doc.documentID;
                                    if (docIDValue) {
                                        foundDocIDs.push(parseInt(docIDValue));
                                     
                                        if (docRefID && parseInt(docRefID) === originalDocIDInt) {
                                           
                                            var maxDocID = parseInt(docIDValue);
                                            var minDocID = originalDocIDInt;
                                           
                                            for (var checkID = minDocID; checkID <= maxDocID; checkID++) {
                                                if (!expectedDocIDs.includes(checkID)) {
                                                   
                                                    expectedDocIDs.push(checkID);
                                                }
                                            }
                                        }
                                    }
                                });

                                // Sort expectedDocIDs
                                expectedDocIDs.sort(function (a, b) { return a - b; });

                                // Check which expected documents are missing
                                var missingDocIDs = [];
                                expectedDocIDs.forEach(function (expectedID) {
                                    var found = fileDocumentsOnly.find(function (doc) {
                                        var docIDValue = doc.DocumentID || doc.documentID;
                                        return parseInt(docIDValue) === expectedID;
                                    });
                                    if (!found) {
                                        missingDocIDs.push(expectedID);
                                    }
                                });

                                
                                    if (missingDocIDs.length > 0) {

                                        missingDocIDs.forEach(function (missingID) {

                                            // Build parameters just like your correct format
                                            var missingDocParams = {
                                                ProjectID: currentProjectID,
                                                DocumentID: missingID
                                            };

                                            var param = JSON.stringify(missingDocParams);

                                            var url = "/api/DocumentUpload/ShowHistory";
                                            var missingDocResponse = AJAXCallWithResult(url, param, false);

                                            if (missingDocResponse) {

                                                var missingDocArray = [];

                                                try {

                                                    if (Array.isArray(missingDocResponse)) {
                                                        missingDocArray = missingDocResponse;
                                                    }
                                                    else if (missingDocResponse.data) {

                                                        if (Array.isArray(missingDocResponse.data)) {
                                                            missingDocArray = missingDocResponse.data;
                                                        }
                                                        else if (
                                                            missingDocResponse.data.data &&
                                                            Array.isArray(missingDocResponse.data.data)
                                                        ) {
                                                            missingDocArray = missingDocResponse.data.data;
                                                        }
                                                    }

                                                    if (missingDocArray.length > 0) {

                                                        missingDocArray.forEach(function (missingDoc) {

                                                            var isURL = missingDoc.IsURL || missingDoc.isURL;

                                                            if (!isURL) {

                                                                var docRefID = missingDoc.DocumentRefID || missingDoc.documentRefID;
                                                                var docIDValue = missingDoc.DocumentID || missingDoc.documentID;

                                                                var docRefIDInt = docRefID ? parseInt(docRefID) : null;
                                                                var docIDValueInt = docIDValue ? parseInt(docIDValue) : null;

                                                                var shouldInclude =
                                                                    (docRefIDInt !== null && docRefIDInt === originalDocIDInt) ||
                                                                    (docIDValueInt === originalDocIDInt && (!docRefID || docRefID === ""));

                                                                if (shouldInclude) {

                                                                    var alreadyInResult = result.some(function (doc) {
                                                                        var dID = doc.DocumentID || doc.documentID;
                                                                        return dID && parseInt(dID) === docIDValueInt;
                                                                    });

                                                                    if (!alreadyInResult) {
                                                                        result.push(missingDoc);
                                                                    }
                                                                }
                                                            }
                                                        });
                                                    }
                                                }
                                                catch (e) {
                                                    // continue if error
                                                }
                                            }
                                        });
                                    }


                                // Final check for original document
                                var originalDocExists = fileDocumentsOnly.some(function (doc) {
                                    var docIDValue = doc.DocumentID || doc.documentID;
                                    return parseInt(docIDValue) === originalDocIDInt;
                                });

                                if (!originalDocExists && result.length > 0) {
                                } else if (originalDocExists) {
                                    var originalDoc = fileDocumentsOnly.find(function (doc) {
                                        var docIDValue = doc.DocumentID || doc.documentID;
                                        return parseInt(docIDValue) === originalDocIDInt;
                                    });
                                    var originalDocInResult = result.some(function (doc) {
                                        var docIDValue = doc.DocumentID || doc.documentID;
                                        return parseInt(docIDValue) === originalDocIDInt;
                                    });

                                    if (!originalDocInResult) {
                                        result.push(originalDoc);
                                    }
                                }
                            }

                            // If filtering found no results, but we have the first doc, add it
                            if (result.length === 0) {
                                if (firstDocArray.length > 0) {
                                    result = firstDocArray;
                                }
                            } else {
                                // Ensure firstDoc is included if it matches but wasn't in result
                                if (firstDocArray.length > 0) {
                                    var firstDoc = firstDocArray[0];
                                    var firstDocID = firstDoc.DocumentID || firstDoc.documentID;
                                    var firstDocRefID = firstDoc.DocumentRefID || firstDoc.documentRefID;

                                    // Check if first doc is already in result
                                    var firstDocInResult = result.some(function (doc) {
                                        var docID = doc.DocumentID || doc.documentID;
                                        return parseInt(docID) === parseInt(firstDocID);
                                    });

                                    if (!firstDocInResult) {
                                        // First doc not in result - check if it should be included
                                        var firstDocRefIDInt = firstDocRefID ? parseInt(firstDocRefID) : null;
                                        var firstDocIDInt = firstDocID ? parseInt(firstDocID) : null;

                                        if ((firstDocRefIDInt !== null && firstDocRefIDInt === originalDocIDInt) ||
                                            (firstDocIDInt === originalDocIDInt && (!firstDocRefID || firstDocRefID === ''))) {
                                            result.push(firstDoc);
                                        }
                                    }
                                }
                            }
                        }
                    } catch (e) {
                        $('#historyClassic').html('<div style="padding:8px;">Error parsing API response: ' + e.message + '</div>').show();
                        return;
                    }

                    if (result && result.length > 0) {
                        // Build classic single-column layout similar to old UI
                        // Group by document to show history
                        var doc = result[0];
                        var allDocs = result;

                       
                        allDocs.sort(function (a, b) {
                            var dateA = a.UploadedDate || a.uploadedDate || a.CreatedDate || a.createdDate || '';
                            var dateB = b.UploadedDate || b.uploadedDate || b.CreatedDate || b.createdDate || '';

                            if (!dateA && !dateB) return 0;
                            if (!dateA) return 1;
                            if (!dateB) return -1;

                            try {
                                var parsedA = new Date(dateA);
                                var parsedB = new Date(dateB);
                                if (!isNaN(parsedA.getTime()) && !isNaN(parsedB.getTime())) {
                                    return parsedA.getTime() - parsedB.getTime(); // Oldest first (ascending)
                                }
                            } catch (e) {
                                // If parsing fails, use string comparison
                            }

                            return dateA.localeCompare(dateB); // Oldest first (ascending)
                        });

                      

                        if (allDocs.length === 1) {
                            var singleDoc = allDocs[0];
                            var docRefID = singleDoc.DocumentRefID || singleDoc.documentRefID;
                            var docIDValue = singleDoc.DocumentID || singleDoc.documentID;

                           
                            if (docRefID && docRefID !== docIDValue) {
                            }
                        }

                       
                        allDocs.sort(function (a, b) {
                            var dateA = a.UploadedDate || a.uploadedDate || a.CreatedDate || a.createdDate || '';
                            var dateB = b.UploadedDate || b.uploadedDate || b.CreatedDate || b.createdDate || '';

                            if (!dateA && !dateB) return 0;
                            if (!dateA) return 1; // Put items without date at end
                            if (!dateB) return -1;

                            try {
                                var parsedA = new Date(dateA);
                                var parsedB = new Date(dateB);
                                if (!isNaN(parsedA.getTime()) && !isNaN(parsedB.getTime())) {
                                    return parsedA.getTime() - parsedB.getTime(); // Oldest first
                                }
                            } catch (e) {
                                // If parsing fails, use string comparison
                            }

                            return dateA.localeCompare(dateB);
                        });

                      
                        allDocs.forEach(function (d, index) {
                            var isOriginal = d.Original !== undefined ? d.Original : (d.original !== undefined ? d.original : false);
                            d._versionNumber = (index + 1) + '.0';
                           
                            d._isLatestVersion = isOriginal || (index === allDocs.length - 1);
                        });

                        // Build review comments list from all documents in history
                        var reviewCommentsList = [];
                        allDocs.forEach(function (d) {
                            // Check multiple possible field names for reviewed by and date
                            var reviewedBy = d.ReviewedBy || d.reviewedBy || d.ReviewBy || d.reviewBy || '';
                            var reviewedDateRaw = d.ReviewedDate || d.reviewedDate || d.ReviewDate || d.reviewDate || '';
                            // Preserve the original date format if it includes time
                            var reviewedDate = reviewedDateRaw;
                            var reviewComment = (d.ReviewNotes || d.reviewNotes || d.ReviewComments || d.reviewComments || '').replace(/\r/g, '').replace(/<BR>/gi, '<br>');

                            // Check if reviewComment contains multiple reviews concatenated (look for pattern like "<b>Reviewed By:")
                            if (reviewComment && (reviewComment.indexOf('<b>Reviewed By:') >= 0 || reviewComment.indexOf('<strong>Reviewed By:') >= 0 ||
                                reviewComment.indexOf('Reviewed By:') >= 0)) {
                               
                                var firstCommentMatch = reviewComment.match(/^(.+?)(?:<br>\s*)?(?:<b>|<strong>)?Reviewed By:/is);
                                if (firstCommentMatch && firstCommentMatch[1]) {
                                    var firstComment = firstCommentMatch[1].trim();
                                    firstComment = firstComment.replace(/<br\s*\/?>\s*$/i, '').trim();
                                    if (firstComment && firstComment !== '' && reviewedBy && reviewedDate) {
                                        var formattedFirstDate = formatDateWithTime(reviewedDate);
                                        reviewCommentsList.push({
                                            By: reviewedBy,
                                            Date: formattedFirstDate,
                                            DateRaw: reviewedDateRaw || reviewedDate || '', // Store raw date for sorting
                                            Comment: firstComment
                                        });
                                    }
                                }

                              
                                var reviewRegex = /<b>Reviewed By:\s*<\/b>([^<]+?)<br\s*\/?>\s*<b>Reviewed Date:\s*<\/b>\s*([^<]+?)<br\s*\/?>\s*<b>Review Comments:\s*<\/b>([^<]+?)(?:<br\s*\/?>|$)/gi;

                                var match;
                                while ((match = reviewRegex.exec(reviewComment)) !== null) {
                                    var currentReviewedBy = match[1] ? match[1].trim() : reviewedBy;
                                    var currentReviewedDate = match[2] ? match[2].trim() : '';
                                    var currentComment = match[3] ? match[3].trim() : '';

                                    // Clean up the comment
                                    currentComment = currentComment.replace(/<br\s*\/?>\s*$/i, '').trim();

                                    var rawDateForDisplay = currentReviewedDate || reviewedDate || '';

                                    var formattedDate = 'N/A';
                                    if (rawDateForDisplay) {
                                        // Format to "Oct 31 2025 2:40PM" format
                                        formattedDate = formatDateWithTime(rawDateForDisplay);
                                    }

                                    if (currentComment && currentReviewedBy) {
                                      
                                        var rawDateForSorting = currentReviewedDate || reviewedDateRaw || reviewedDate || '';
                                        reviewCommentsList.push({
                                            By: currentReviewedBy,
                                            Date: formattedDate,
                                            DateRaw: rawDateForSorting, // Store raw date for sorting
                                            Comment: currentComment
                                        });
                                    }
                                }
                            } else {
                                // Single review - add it directly
                                if (reviewedBy && reviewedDate) {
                                    var formattedSingleDate = formatDateWithTime(reviewedDate);
                                    reviewCommentsList.push({
                                        By: reviewedBy,
                                        Date: formattedSingleDate,
                                        DateRaw: reviewedDateRaw || reviewedDate || '', // Store raw date for sorting
                                        Comment: reviewComment || 'N/A'
                                    });
                                }
                            }
                        });

                        // Sort by date (newest first) - proper date sorting
                        reviewCommentsList.sort(function (a, b) {
                            // Try to parse dates for comparison
                            var dateA = a.DateRaw || a.Date || '';
                            var dateB = b.DateRaw || b.Date || '';

                            // Helper function to parse date string (handles ISO format, "Oct 31 2025 2:10PM", etc.)
                            function parseDateStr(dateStr) {
                                if (!dateStr || dateStr === 'N/A' || dateStr === '' || dateStr === '-') return null;

                                // Try parsing as-is first (works for ISO format like "2025-10-31T16:15:35.933")
                                var d = new Date(dateStr);
                                if (!isNaN(d.getTime())) {
                                    return d;
                                }

                                // Try parsing formats like "Oct 31 2025 2:10PM"
                                // Match pattern: Month DD YYYY HH:MMAM/PM or Month DD YYYY HHMMAM/PM
                                var dateMatch = dateStr.match(/(\w+)\s+(\d+)\s+(\d+)\s+(\d+):?(\d+)?\s*(AM|PM)?/i);
                                if (dateMatch) {
                                    var month = dateMatch[1];
                                    var day = parseInt(dateMatch[2]);
                                    var year = parseInt(dateMatch[3]);
                                    var hour = parseInt(dateMatch[4]);
                                    var minute = parseInt(dateMatch[5] || '0');
                                    var ampm = (dateMatch[6] || '').toUpperCase();

                                    // Convert month name to number
                                    var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                                    var monthNum = monthNames.indexOf(month.substring(0, 3));
                                    if (monthNum === -1) {
                                        monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                        monthNum = monthNames.indexOf(month);
                                    }

                                    if (monthNum >= 0) {
                                        // Adjust hour for AM/PM
                                        if (ampm === 'PM' && hour < 12) hour += 12;
                                        if (ampm === 'AM' && hour === 12) hour = 0;

                                        d = new Date(year, monthNum, day, hour, minute, 0);
                                        if (!isNaN(d.getTime())) {
                                            return d;
                                        }
                                    }
                                }

                                // Try removing AM/PM and parsing again as fallback
                                var cleaned = dateStr.replace(/AM|PM/gi, '').trim();
                                d = new Date(cleaned);
                                if (!isNaN(d.getTime())) {
                                    // If original had AM/PM, adjust the time
                                    var isPM = /PM/i.test(dateStr);
                                    var isAM = /AM/i.test(dateStr);
                                    if (isPM || isAM) {
                                        var hours = d.getHours();
                                        if (isPM && hours < 12) d.setHours(hours + 12);
                                        if (isAM && hours >= 12) d.setHours(hours - 12);
                                    }
                                    return d;
                                }

                                return null;
                            }

                            var parsedA = parseDateStr(dateA);
                            var parsedB = parseDateStr(dateB);

                         
                            if (parsedA && parsedB) {
                               
                                return parsedB.getTime() - parsedA.getTime(); 
                            }

                           
                            if (parsedA && !parsedB) return -1; 
                            if (!parsedA && parsedB) return 1; 

                           
                            if (dateA && dateB) {
                                
                                return dateB.localeCompare(dateA);
                            }

                            if (dateA && !dateB) return -1;
                            if (!dateA && dateB) return 1;

                          
                            return 0;
                        });

                        const uploadedDate = formatDate(doc.UploadedDate || doc.UploadDate || doc.Uploaded_On || doc.uploadedDate || '');
                        const updatedDate = formatDate(doc.UpdatedDate || doc.LastModified || doc.updatedDate || doc.lastModified || '');
                        const fileName = doc.FileName || doc.fileName || doc.DirectoryName || doc.directoryName || '';
                        const category = doc.Category || doc.category || doc.DocumentType || doc.documentType || '';
                        const uploadedBy = doc.UploadedBy || doc.uploadedBy || '';
                        const description = doc.Description || doc.description || '';

                        // Build all review entries with borders AFTER each review entry
                        var reviewEntriesHTML = '';
                        if (reviewCommentsList.length > 0) {
                            reviewCommentsList.forEach(function (c, index) {
                                
                                var topMargin = index === 0 ? 'margin-top:12px;' : '';
                                // Use a darker, more visible border color
                                var borderBottom = 'border-bottom:1px solid #9ca3af; margin-bottom:12px; padding-bottom:12px;';
                                reviewEntriesHTML += `
                     <div style="${topMargin}${borderBottom}">
                         <div><strong>Reviewed By:</strong>&nbsp; ${c.By || 'N/A'}
                             <span style="margin-left:30px;"><strong>Review Date:</strong>&nbsp; ${c.Date || 'N/A'}</span>
                         </div>
                         <div><strong>Review Comments:</strong></div>
                         <div>${c.Comment || 'No comments'}</div>
                     </div>`;
                            });
                        } else {
                            // If no reviews, check the main document for review info
                            var docReviewedBy = doc.ReviewedBy || doc.reviewedBy || doc.ReviewBy || doc.reviewBy || '';
                            var docReviewedDate = doc.ReviewedDate || doc.reviewedDate || doc.ReviewDate || doc.reviewDate || '';
                            if (docReviewedBy && docReviewedBy !== 'N/A' && docReviewedDate) {
                                reviewEntriesHTML = `
                     <div style="margin-top:12px; border-bottom:1px solid #9ca3af; margin-bottom:12px; padding-bottom:12px;">
                         <div><strong>Reviewed By:</strong>&nbsp; ${docReviewedBy}
                             <span style="margin-left:30px;"><strong>Review Date:</strong>&nbsp; ${formatDate(docReviewedDate)}</span>
                         </div>
                         <div><strong>Review Comments:</strong></div>
                         <div>${(doc.ReviewNotes || doc.reviewNotes || doc.ReviewComments || doc.reviewComments || '').replace(/\r/g, '').replace(/<BR>/gi, '<br>') || 'No comments'}</div>
                     </div>`;
                            } else {
                                reviewEntriesHTML = '<div style="margin-top:12px;"><strong>Reviewed By:</strong>&nbsp; Not reviewed yet</div>';
                            }
                        }

                        // Build version entries HTML - show all versions with download links
                        var versionEntriesHTML = '';

                        if (allDocs && allDocs.length > 1) {
                           
                            var sortedVersions = allDocs.slice().sort(function (a, b) {
                                var verA = parseFloat(a._versionNumber || '0');
                                var verB = parseFloat(b._versionNumber || '0');
                                return verB - verA; // Newest first
                            });

                            // Create collapsible File Versions section
                            var versionsContainerId = 'versionsContainer_' + (doc.DocumentID || doc.documentID || Date.now());
                            var versionsCollapsedId = 'versionsCollapsed_' + (doc.DocumentID || doc.documentID || Date.now());

                            versionEntriesHTML = `
             <div style="margin-top:16px; margin-bottom:12px;">
                 <div id="${versionsCollapsedId}" onclick="toggleVersions('${versionsContainerId}', '${versionsCollapsedId}');" style="padding:10px 12px; background-color: #f9fafb; border:1px solid #9ca3af; border-radius:4px; cursor: pointer; display: flex; align-items: center; justify-content: space-between; user-select: none;">
                     <div style="display: flex; align-items: center; gap: 8px;">
                         <strong style="font-size:14px; color:#1f2937;">📄 File Versions (Total: ${allDocs.length})</strong>
                     </div>
                     <span id="${versionsContainerId}_icon" style="font-size:12px; color:#6b7280; transition: transform 0.2s;">▼</span>
                 </div>
                 <div id="${versionsContainerId}" style="display: none; margin-top:12px;">
             `;

                            sortedVersions.forEach(function (versionDoc, idx) {
                                var versionUploadedBy = versionDoc.UploadedBy || versionDoc.uploadedBy || '';
                                var versionFileNameBase = versionDoc.FileName || versionDoc.fileName || '';
                                var versionNumber = versionDoc._versionNumber || '1.0';
                                var isLatest = versionDoc._isLatestVersion || false;
                                var versionExt = versionDoc.Extension || versionDoc.extension || versionDoc.FileExtension || versionDoc.fileExtension || '';
                                var versionFileSize = versionDoc.FileSize || versionDoc.fileSize || '';
                                var versionFileSizeKB = versionFileSize ? (parseFloat(versionFileSize).toFixed(2) + ' KB') : 'N/A';

                                // The database already contains the versioned filename (e.g., "file-example_PDF_1MB_v1.pdf")
                                // DO NOT add another version suffix - just use the filename from the database as-is
                                var versionFileName = versionFileNameBase;

                                // If filename doesn't have extension and we have a separate extension field, add it
                                if (versionFileName && versionFileName.indexOf('.') === -1) {
                                    if (versionExt && versionExt.trim() !== '') {
                                        versionFileName = versionFileName + '.' + versionExt.trim();
                                    }
                                }

                             
                                var versionUploadedDateRaw = versionDoc.UploadedDate || versionDoc.uploadedDate || '';
                                var versionUpdatedDateRaw = versionDoc.UpdatedDate || versionDoc.updatedDate || versionDoc.LastModified || versionDoc.lastModified || '';

                               
                                var dateToUse = versionUploadedDateRaw && versionUploadedDateRaw !== '' ? versionUploadedDateRaw : versionUpdatedDateRaw;
                                var versionUpdatedDate = dateToUse ? formatDateWithTime(dateToUse) : 'N/A';

                                versionEntriesHTML += `
                 <div style="margin-top:${idx === 0 ? '0' : '12'}px; padding:12px; border:1px solid ${isLatest ? '#059669' : '#d1d5db'}; border-radius:4px; background-color:${isLatest ? '#ecfdf5' : '#ffffff'};">
                     <div style="margin-bottom:10px; display:flex; align-items:center; justify-content:space-between;">
                         <div>
                             <strong style="font-size:13px; color:#1f2937;">Version ${versionNumber}</strong>
                             ${isLatest ? ' <span style="color: #059669; font-weight: 600; background-color:#d1fae5; padding:2px 8px; border-radius:3px; font-size:11px;">✓ Latest</span>' : ''}
                         </div>
                         <a href="javascript:void(0);" 
                            onclick="downloadDocument('${versionDoc.DocumentID || versionDoc.documentID}', '${versionDoc.ProjectID || versionDoc.projectID}', '${versionFileName.replace(/'/g, "\\'")}', '${versionExt.replace(/'/g, "\\'")}')"
                            style="color: #2563eb; text-decoration: none; cursor: pointer; padding:4px 12px; background-color:#dbeafe; border-radius:3px; font-size:12px; font-weight:500;">
                             ⬇ Download
                         </a>
                     </div>
                     <table style="width:100%; font-size:12px; color:#4b5563;">
                         <tr>
                             <td style="width:30%; padding:4px 0;"><strong>File Name:</strong></td>
                             <td style="padding:4px 0;">${versionFileName}</td>
                         </tr>
                         <tr>
                             <td style="padding:4px 0;"><strong>Last Modified:</strong></td>
                             <td style="padding:4px 0;">${versionUpdatedDate}</td>
                         </tr>
                         <tr>
                             <td style="padding:4px 0;"><strong>File Size:</strong></td>
                             <td style="padding:4px 0;">${versionFileSizeKB}</td>
                         </tr>
                         <tr>
                             <td style="padding:4px 0;"><strong>Uploaded By:</strong></td>
                             <td style="padding:4px 0;">${versionUploadedBy || 'N/A'}</td>
                         </tr>
                     </table>
                 </div>`;
                            });

                            versionEntriesHTML += '</div></div>'; // Close versionsContainer div
                        } else if (allDocs && allDocs.length === 1) {
                            // Single document returned - but check if there are other versions
                            var singleDoc = allDocs[0];
                            var singleVersionNumber = singleDoc._versionNumber || '1.0';
                            var singleFileName = singleDoc.FileName || singleDoc.fileName || '';
                            var singleExt = singleDoc.Extension || singleDoc.extension || singleDoc.FileExtension || singleDoc.fileExtension || '';
                            var docRefID = singleDoc.DocumentRefID || singleDoc.documentRefID;
                            var isOriginal = singleDoc.Original !== undefined ? singleDoc.Original : (singleDoc.original !== undefined ? singleDoc.original : false);

                          
                            var versionNote = docRefID ?
                                ' <span style="color:#f59e0b; font-size:11px;">(Note: Other versions may exist but were not returned by API)</span>' :
                                //' (Only Version)';  Commented by Vishal on 15/01/2026 to remove this comment
                                '';

                            versionEntriesHTML = `
                 <div style="margin-top:16px; padding:12px; border:1px solid #9ca3af; border-radius:4px; background-color:#f9fafb;">
                     <div style="margin-bottom:8px;">
                         <strong style="font-size:13px; color:#1f2937;">Version ${singleVersionNumber}${versionNote}</strong>
                         ${isOriginal ? ' <span style="color: #059669; font-weight: 600; background-color:#d1fae5; padding:2px 8px; border-radius:3px; font-size:11px;">✓ Latest</span>' : ''}
                     </div>
                     <div style="font-size:12px; color:#4b5563;">
                         <div><strong>File Name:</strong>&nbsp; ${singleFileName}</div>
                         ${docRefID ? '<div style="margin-top:4px; color:#6b7280; font-size:11px;"><strong>DocumentRefID:</strong>&nbsp; ' + docRefID + '</div>' : ''}
                     </div>
                 </div>`;
                        }

                        // Find latest version for display in header
                        var latestVersion = null;
                        if (allDocs && allDocs.length > 0) {
                            latestVersion = allDocs.find(function (d) {
                                var isOriginal = d.Original !== undefined ? d.Original : (d.original !== undefined ? d.original : false);
                                return isOriginal || d._isLatestVersion;
                            });
                            // If no latest found by flag, use the one with highest version number
                            if (!latestVersion) {
                                latestVersion = allDocs.reduce(function (prev, curr) {
                                    var prevVer = parseFloat(prev._versionNumber || '0');
                                    var currVer = parseFloat(curr._versionNumber || '0');
                                    return currVer > prevVer ? curr : prev;
                                });
                            }
                        }

                        const htmlClassic = `
             <div style="border:1px solid #cbd5e1; border-radius:4px; overflow:hidden;">
                 <div style="background:#9ca3af; color:#fff; padding:8px 12px; font-weight:600; font-size:14px;">Document Category : ${category || 'N/A'}</div>
                 <div style="padding:12px 14px;">
                     <div style="margin-bottom:12px; padding-bottom:12px; border-bottom:1px solid #e5e7eb;">
                         <div style="font-size:13px; color:#1f2937; margin-bottom:6px;"><strong>File Name:</strong>&nbsp; ${fileName || 'N/A'}${latestVersion && latestVersion._versionNumber && allDocs.length > 1 ? ' <span style="color:#059669; font-weight:500;">(v' + latestVersion._versionNumber + ' - Latest)</span>' : ''}</div>
                         <div style="font-size:12px; color:#4b5563; margin:4px 0;"><strong>Upload Date:</strong>&nbsp; ${uploadedDate || 'N/A'}</div>
                         <div style="font-size:12px; color:#4b5563; margin:4px 0;"><strong>Last Modified:</strong>&nbsp; ${updatedDate || 'N/A'}</div>
                         <div style="font-size:12px; color:#4b5563; margin:4px 0;"><strong>Description:</strong>&nbsp; ${description || 'N/A'}</div>
                         <div style="font-size:12px; color:#4b5563; margin:4px 0;"><strong>Uploaded By:</strong>&nbsp; ${uploadedBy || 'N/A'}</div>
                     </div>
                     ${versionEntriesHTML}
                     ${reviewEntriesHTML}
                 </div>
             </div>`;

                        $('#historyClassic').html(htmlClassic).show();
                    } else {
                        $('#historyClassic').html('<div style="padding:8px;">No history found for this document.</div>').show();
                    }

                }
                // End of addition by Nischal C on 3/11/2025 Show document history with flags

                //Added by Vishal Mane on 16/01/2026 to display Review Comment
                $('#Doc_reviewOffScreen').on('hidden.bs.offcanvas', function () {
                    $('#commentID').css('height', '150px');
                    //min - height: calc(1.5em + .75rem + calc(var(--bs - border - width) * 2));
                });
                $('#AttachURLOffScreen').on('hidden.bs.offcanvas', function () {
                    $('#txtDescription').css('height', '100px');
                    //min - height: calc(1.5em + .75rem + calc(var(--bs - border - width) * 2));
                });
              
                function showReview(DocID) {
                    //debugger
                    //Added by Vishal Mane on 16/01/2026 to display Review Comment
                    reviewDocID = DocID;
                    //var reviewparams = {
                    //    DocumentID: DocID,
                      
                    //};
                    //var param = JSON.stringify(reviewparams);
                    //var url = "/api/DocumentUpload/BindReviewNotes";
                    //var result = AJAXCallWithResult(url, param, false);
                    //var apiResult = null;
                    //apiResult = result;
                    //if (apiResult && apiResult.data) {
                    //    $('#commentID').val(apiResult.data[0]["reviewNotes"]);
                    //}
                    //else if (apiResult) {
                    //    $('#commentID').val('');
                    //}
                    $('#commentID').val('');
                    // Hide/show save button based on edit access
                    if (m_blnEditAccess) {
                        $('#svDoc_review').show();
                    } else {
                        $('#svDoc_review').hide();
                    }
                    //End of Added by Vishal Mane on 16/01/2026 to display Review Comment
                }

                // Added by Nischal C on 3/11/2025 - Update review comments
                function UpdshowReview() {
                    //debugger
                    var commentID = $('#commentID').val();
                    
                    // Validate Review Comment is not blank
                    if (!commentID || commentID.trim() === '') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_ReviewCommentShouldNotBeLeftBlank);
                        $('#commentID').focus();
                        return;
                    }
                    
                    var reviewparams = {
                        DocumentID: reviewDocID,
                        LogInID: intUserID,
                        Comment: commentID,
                        LoginType: loginType
                    };

                    var param = JSON.stringify(reviewparams);

                    var url = "/api/DocumentUpload/UpdateDocumentReview";
                    var result = AJAXCallWithResult(url, param, false);                   
                    var apiResult = null;
                    apiResult = result;
                        
                    var result = {};
                    if (apiResult && apiResult.data) {
                        if (apiResult.data.data) {
                            result = apiResult.data.data;
                        } else {
                            result = apiResult.data;
                        }
                    } else if (apiResult) {
                        result = apiResult;
                    }
                    
                    var msg = result.Message || result.message || 'Review updated successfully';
                    
                    // Check if save was successful before clearing
                    var isSuccess = false;
                    if (apiResult && (apiResult.success === true || apiResult.success === 'true' || 
                        (apiResult.data && (apiResult.data.success === true || apiResult.data.success === 'true')) ||
                        (result && (result.success === true || result.success === 'true')))) {
                        isSuccess = true;
                    } else if (apiResult && !apiResult.error && !result.error) {
                        // If no error is present, consider it successful
                        isSuccess = true;
                    }
                    
                    if (isSuccess) {
                        // Clear the review textarea after successful save
                        $('#commentID').val('');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(msg);
                        
                        fetchAllDocuments(); // Refresh the table
                    $('#closeDoc_review').trigger('click'); // Close modal or cancel
                    } else {
                        // Show error message but don't clear the textarea
                        var errorMsg = result.Message || result.message || apiResult.message || apiResult.Message || 'Failed to save review';
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(errorMsg);
                    }

                }
                // End of addition by Nischal C on 3/11/2025 Update review comments

                // Added by Nischal C on 3/11/2025 - Download document
               // Main function used to download document
                function downloadDocument(docID, ProjID, fileName, extension) {
                    var params = {
                        ProjectID: parseInt(ProjID),
                        DocumentID: parseInt(docID),
                        WhatToDelete: "I"
                    };

                    var result = AJAXCallWithResult(
                        "/api/DocumentUpload/DownloadDocument",
                        JSON.stringify(params),
                        false
                    );

                    // Handle both PascalCase (API response) and camelCase
                    var filePath = result?.filePathSegments || result?.FilePathSegments;
                    var fileName = result?.fileName || result?.FileName;

                    if (result && filePath && fileName) {
                        // Use download endpoint to force download (sets Content-Disposition: attachment header)
                        // This prevents files from opening in browser and forces direct download
                        var fileUrl = buildUrl("/api/DocumentUpload/DownloadFile/" + filePath);
                        var tempLink = document.createElement("a");
                        tempLink.href = fileUrl;
                        tempLink.download = fileName;
                        tempLink.style.display = "none";
                        document.body.appendChild(tempLink);
                        tempLink.click();
                        document.body.removeChild(tempLink);
                    }
                    else {
                        //Added by Vaibhav to show alert on top on 11-03-26

                        alertify.set('notifier', 'position', 'top-right');
                        //Added by Vaibhav to to show alert on top on 11-03-26

                        alertify.error(result?.message || result?.Message || "Download failed");
                    }
                }
         

                // Added by Nischal C on 3/11/2025 - Download file using AJAXCallWithResult (no $.ajax, no blob)
                function downloadFileWithFormPost(url, param, defaultFileName) {
                    var result = AJAXCallWithResult(url, JSON.stringify(param), false);

                    // Handle both PascalCase (API response) and camelCase
                    var filePath = result?.filePathSegments || result?.FilePathSegments;
                    var fileName = result?.fileName || result?.FileName;

                    if (result && filePath && fileName) {
                       
                        var fileUrl = buildUrl("/api/DocumentUpload/DownloadFile/" + filePath);
                        var tempLink = document.createElement("a");
                        tempLink.href = fileUrl;
                        tempLink.download = fileName;
                        tempLink.style.display = "none";
                        document.body.appendChild(tempLink);
                        tempLink.click();
                        document.body.removeChild(tempLink);
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(result?.message || result?.Message || "Download failed");
                    }
                }
                // End of addition by Nischal C on 3/11/2025

                // Pagination Functions - Added to match PM_SCM.aspx
                let currentPage = 1;
                let itemsPerPage = 10;
                let totalPages = 1;
                
                // Added by Nischal C on 3/11/2025 - Show/hide rows based on current page
                function showPageRows() {
                    var isUrls = $('#containerUrls').is(':visible');
                    var tbody = isUrls ? $('#tbodyUrls') : $('#tbodyReqSpe');
                    
                    if (!tbody || tbody.length === 0) return;
                    
                    // Get all data rows (excluding category headers and detail view rows)
                    var allDataRows = tbody.find('tr[data-document-id]:not(.detail-view-wrap), tr[data-url-id]').toArray();
                    
                    // Filter rows based on sercdeltsk search (client-side filtering)
                    var searchText = $('#sercdeltsk').val() ? $('#sercdeltsk').val().trim().toLowerCase() : '';
                    var dataRows = allDataRows;
                    
                    if (searchText !== '') {
                        dataRows = allDataRows.filter(function(row) {
                            var $row = $(row);
                            // Search in document name (usually in the 3rd column)
                            var docName = $row.find('td').eq(2).text().toLowerCase();
                            // Also search in other visible text in the row
                            var rowText = $row.text().toLowerCase();
                            return docName.includes(searchText) || rowText.includes(searchText);
                        });
                    }
                    
                    var totalRecords = dataRows.length;
                    
                    
                    if (totalRecords === 0) {
                        // Hide all category headers if no data
                        tbody.find('tr.category-header-row').hide();
                        
                        // Show "No data available in table" message
                        var hasDeleteAccess = <%=m_blnDeleteAccess.ToString().ToLower()%>;
                        var colspan = isUrls ? (hasDeleteAccess ? 7 : 6) : (hasDeleteAccess ? 9 : 8);
                        
                        // Check if message already exists (avoid duplicate messages)
                        var existingMessage = tbody.find('td').filter(function() {
                            return $(this).text().trim() === 'No data available in table';
                        });
                        if (existingMessage.length === 0) {
                            tbody.html('<tr><td colspan="' + colspan + '" class="text-center">No data available in table</td></tr>');
                        }
                        updatePagination();
                        return;
                    }
                    
                    // Calculate start and end indices for current page
                    var startIndex = (currentPage - 1) * itemsPerPage;
                    var endIndex = Math.min(startIndex + itemsPerPage, totalRecords);
                    
                   
                    dataRows.forEach(function(row) {
                        var $row = $(row);
                        $row.css('display', 'none !important'); 
                        $row.hide(); 
                        $row.attr('style', 'display: none !important'); 
                    });
                    
                    // Hide all category headers
                    tbody.find('tr.category-header-row').each(function() {
                        $(this).css('display', 'none !important');
                        $(this).hide();
                        $(this).attr('style', 'display: none !important');
                    });
                    
                    
                    tbody.find('tr.detail-view-wrap').each(function() {
                        var $tr = $(this);
                      
                        var currentStyle = $tr.attr('style') || '';
                        currentStyle = currentStyle.replace(/display\s*:\s*[^;]+;?/gi, '');
                        currentStyle = currentStyle.replace(/display\s*!\s*important/gi, '');
                        if (currentStyle.trim()) {
                            $tr.attr('style', currentStyle.trim());
                        } else {
                            $tr.removeAttr('style');
                        }
                        $tr.css('display', 'none !important');
                        $tr.hide();
                    });
                    
                    // Double-check: Count any still-visible rows and force hide them
                    var allRowsInTbody = tbody.find('tr');
                    allRowsInTbody.each(function() {
                        var $tr = $(this);
                        // Only hide rows that aren't the ones we want to show
                        var shouldBeHidden = true;
                        for (var j = startIndex; j < endIndex; j++) {
                            if (dataRows[j] && $tr[0] === dataRows[j]) {
                                shouldBeHidden = false;
                                break;
                            }
                        }
                        if (shouldBeHidden && $tr.is(':visible')) {
                            $tr.css('display', 'none !important');
                            $tr.hide();
                            $tr.attr('style', 'display: none !important');
                        }
                    });
                    
                    
                    // Show rows for current page
                    var shownCategories = {};
                    var rowsShownCount = 0;
                    for (var i = startIndex; i < endIndex; i++) {
                        if (dataRows[i]) {
                            var $row = $(dataRows[i]);
                            // Force show this row - remove all hiding styles
                            $row.removeAttr('style');
                            $row.css('display', '');
                            $row.show();
                            rowsShownCount++;
                            
                         
                            if (window.detailViewActive) {
                                var docId = $row.attr('data-document-id');
                                if (docId) {
                                    var $detailRow = tbody.find('tr.detail-view-wrap[data-document-id="' + docId + '"]');
                                    if ($detailRow.length > 0) {
                                        // Restore the style and show
                                        var currentStyle = $detailRow.attr('style') || '';
                                        if (!currentStyle.includes('background-color')) {
                                            $detailRow.attr('style', 'background-color: #f5f5f5 !important; display: table-row !important;');
                                        } else if (!currentStyle.includes('display')) {
                                            currentStyle = currentStyle.replace(/background-color[^;]*;?/gi, '');
                                            $detailRow.attr('style', 'background-color: #f5f5f5 !important; display: table-row !important;');
                                        } else {
                                            currentStyle = currentStyle.replace(/display\s*:\s*[^;]+;?/gi, 'display: table-row !important;');
                                            $detailRow.attr('style', currentStyle);
                                        }
                                        $detailRow.css('display', 'table-row !important');
                                        $detailRow.show();
                                    }
                                }
                            }
                            
                            
                            var $prevRows = $row.prevAll('tr');
                            var $categoryHeader = null;
                            
                            // Find the first category header before this row
                            $prevRows.each(function() {
                                if ($(this).hasClass('category-header-row')) {
                                    $categoryHeader = $(this);
                                    return false; // break
                                }
                            });
                            
                            // If no header found before, check if row is right after a header
                            if ($categoryHeader === null || $categoryHeader.length === 0) {
                                var $immediatePrev = $row.prev('tr');
                                if ($immediatePrev.hasClass('category-header-row')) {
                                    $categoryHeader = $immediatePrev;
                                }
                            }
                            
                            // Show the category header if found
                            if ($categoryHeader && $categoryHeader.length > 0) {
                                var categoryId = $categoryHeader.attr('data-category-id') || 'default';
                                if (!shownCategories[categoryId]) {
                                    $categoryHeader.show();
                                    shownCategories[categoryId] = true;
                                }
                            }
                        }
                    }
                    
                    // Final verification: ALWAYS enforce the row limit - ALWAYS RUN, not conditional
                    setTimeout(function() {
                        var visibleMainRows = tbody.find('tr[data-document-id]:not(.detail-view-wrap):visible, tr[data-url-id]:visible').length;
                        var visibleDetailRows = tbody.find('tr.detail-view-wrap:visible').length;
                        var expectedMainCount = Math.min(endIndex - startIndex, itemsPerPage); // Should be exactly this many (10 for page 1)
                        
                        // ALWAYS enforce exact count - ALWAYS RUN THIS ENFORCEMENT, no conditions
                        // This ensures exactly the right number of rows are visible on each page
                        
                        // ALWAYS enforce - hide all and re-show only correct ones (every time, no exceptions)
                        {
                            dataRows.forEach(function(row, idx) {
                                var $r = $(row);
                                // Force hide with multiple methods
                                $r.attr('style', 'display: none !important');
                                $r.css('display', 'none !important');
                                $r.css('visibility', 'hidden');
                                $r.hide();
                                // Also set directly on DOM element
                                if ($r[0]) {
                                    $r[0].style.display = 'none';
                                    $r[0].style.setProperty('display', 'none', 'important');
                                }
                            });
                            
                            tbody.find('tr.detail-view-wrap').each(function() {
                                var $dr = $(this);
                                var style = ($dr.attr('style') || '').replace(/display\s*:\s*[^;]+;?/gi, '');
                                if (style.trim()) {
                                    $dr.attr('style', style.trim() + '; display: none !important;');
                                } else {
                                    $dr.attr('style', 'display: none !important;');
                                }
                                $dr.css('display', 'none !important');
                                $dr.css('visibility', 'hidden');
                                $dr.hide();
                                if ($dr[0]) {
                                    $dr[0].style.display = 'none';
                                    $dr[0].style.setProperty('display', 'none', 'important');
                                }
                            });
                            
                            var correctedCount = 0;
                            for (var k = startIndex; k < endIndex && k < dataRows.length; k++) {
                                if (dataRows[k]) {
                                    var $rowToShow = $(dataRows[k]);
                                    // Remove all hiding styles
                                    $rowToShow.removeAttr('style');
                                    $rowToShow.css('display', '');
                                    $rowToShow.css('visibility', '');
                                    $rowToShow.show();
                                    if ($rowToShow[0]) {
                                        $rowToShow[0].style.display = '';
                                        $rowToShow[0].style.removeProperty('display');
                                        $rowToShow[0].style.removeProperty('visibility');
                                    }
                                    correctedCount++;
                                    
                                    if (window.detailViewActive) {
                                        var docIdToShow = $rowToShow.attr('data-document-id');
                                        if (docIdToShow) {
                                            var $detailRowToShow = tbody.find('tr.detail-view-wrap[data-document-id="' + docIdToShow + '"]');
                                            if ($detailRowToShow.length > 0) {
                                                $detailRowToShow.removeAttr('style');
                                                $detailRowToShow.attr('style', 'background-color: #f5f5f5 !important; display: table-row !important;');
                                                $detailRowToShow.css('display', 'table-row !important');
                                                $detailRowToShow.css('visibility', 'visible');
                                                $detailRowToShow.show();
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Object.keys(shownCategories).forEach(function(catId) {
                                if (shownCategories[catId]) {
                                    tbody.find('tr.category-header-row[data-category-id="' + catId + '"]').each(function() {
                                        var $ch = $(this);
                                        $ch.removeAttr('style');
                                        $ch.css('display', '');
                                        $ch.css('visibility', '');
                                        $ch.show();
                                    });
                                }
                            });
                            
                            var finalMain = tbody.find('tr[data-document-id]:not(.detail-view-wrap):visible, tr[data-url-id]:visible').length;
                            var finalDetail = tbody.find('tr.detail-view-wrap:visible').length;
                            if (finalMain !== expectedMainCount) {
                                // Use the same dataRows array we used in the loop - hide all by index
                                dataRows.forEach(function(row, idx) {
                                    if (row && row.style) {
                                        if (idx >= startIndex && idx < endIndex) {
                                            // This row should be visible
                                            row.style.display = '';
                                            row.style.removeProperty('display');
                                            row.style.removeProperty('visibility');
                                        } else {
                                            // This row should be hidden
                                            row.style.display = 'none';
                                            row.style.setProperty('display', 'none', 'important');
                                            row.style.visibility = 'hidden';
                                        }
                                    }
                                });
                                
                                // Also hide any rows that don't match our index range
                                var allRowsInOrder = tbody.find('tr[data-document-id]:not(.detail-view-wrap), tr[data-url-id]').toArray();
                                allRowsInOrder.forEach(function(row, idx) {
                                    if (idx >= startIndex && idx < endIndex) {
                                        row.style.display = '';
                                        row.style.removeProperty('display');
                                    } else {
                                        row.style.display = 'none';
                                        row.style.setProperty('display', 'none', 'important');
                                    }
                                });
                                
                                var finalCheck = tbody.find('tr[data-document-id]:not(.detail-view-wrap):visible, tr[data-url-id]:visible').length;
                                // Last resort: count visible rows and hide extras
                                if (finalCheck > expectedMainCount) {
                                    var visibleRowsList = tbody.find('tr[data-document-id]:not(.detail-view-wrap):visible, tr[data-url-id]:visible').toArray();
                                    visibleRowsList.forEach(function(row, idx) {
                                        if (idx >= expectedMainCount) {
                                            row.style.display = 'none';
                                            row.style.setProperty('display', 'none', 'important');
                                        }
                                    });
                                }
                            }
                        }
                    }, 300);
                    
                    // Update pagination info
                    updatePagination();
                }
                // End of addition by Nischal C on 3/11/2025 

                // Added by Nischal C on 3/11/2025 - Update pagination controls
                function updatePagination() {
                    var isUrls = $('#containerUrls').is(':visible');
                    let totalRecords = isUrls
                        ? $("#urlstable tbody tr[data-url-id]").length
                        : $("#prodocumentstbl tbody tr[data-document-id]:not(.detail-view-wrap)").length;
                    
                    // Update total records count
                    $('#totalRecords').text(totalRecords);
                    
                    // Calculate total pages
                    totalPages = Math.ceil(totalRecords / itemsPerPage);
                    
                    // Update button states
                    if (currentPage === 1 || totalRecords === 0) {
                        $('#btnprevious').addClass('fa-disabled');
                        $('#LinkPrevious').removeAttr('onclick');
                    } else {
                        $('#btnprevious').removeClass('fa-disabled');
                        $('#LinkPrevious').attr('onclick', 'goToPreviousPage()');
                    }
                    
                    if (currentPage >= totalPages || totalRecords === 0) {
                        $('#btnnext').addClass('fa-disabled');
                        $('#LinkNext').removeAttr('onclick');
                    } else {
                        $('#btnnext').removeClass('fa-disabled');
                        $('#LinkNext').attr('onclick', 'goToNextPage()');
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Update pagination controls

                // Added by Nischal C on 3/11/2025 - Go to first page
                function goToFirstPage() {
                    currentPage = 1;
                    showPageRows();
                    updatePagination();
                }
                // End of addition by Nischal C on 3/11/2025 Go to first page

                // Added by Nischal C on 3/11/2025 - Go to last page
                function goToLastPage() {
                    var isUrls = $('#containerUrls').is(':visible');
                    let totalRecords = isUrls
                        ? $("#urlstable tbody tr[data-url-id]").length
                        : $("#prodocumentstbl tbody tr[data-document-id]:not(.detail-view-wrap)").length;
                    totalPages = Math.ceil(totalRecords / itemsPerPage);
                    currentPage = totalPages;
                    showPageRows();
                    updatePagination();
                }
                // End of addition by Nischal C on 3/11/2025 Go to last page

                // Added by Nischal C on 3/11/2025 - Go to previous page
                function goToPreviousPage() {
                    if (currentPage > 1) {
                        currentPage = currentPage - 1;
                        showPageRows();
                        updatePagination();
                    }
                }
                
                function goToNextPage() {
                    var isUrls = $('#containerUrls').is(':visible');
                    let totalRecords = isUrls
                        ? $("#urlstable tbody tr[data-url-id]").length
                        : $("#prodocumentstbl tbody tr[data-document-id]:not(.detail-view-wrap)").length;
                    totalPages = Math.ceil(totalRecords / itemsPerPage);
                    
                    if (currentPage < totalPages) {
                        currentPage = currentPage + 1;
                        showPageRows();
                        updatePagination();
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Go to next page



            </script>
    
    <%-- Added by Nischal C on 3/11/2025 - Restrict files containing embedded EXE files --%>
    <script>
        var isValidTypeExeCheck = '';

        // Added by Nischal C on 3/11/2025 - Validate MIME type using GetFileType API
     
        function validateFilesMimeType(files) {
            return new Promise(function(resolve, reject) {
                var validatedFiles = [];

                // Process files sequentially for MIME validation
                for (var idx = 0; idx < files.length; idx++) {
                    var file = files[idx];

                    try {
                        // Create FormData with file
                        var formData = new FormData();
                        formData.append('file', file);

                        // Call GetFileType API using AJAXCallWithResult (server-side handles all validation including XML)
                        var apiResponse = AJAXCallWithResult('/api/DocumentUpload/GetFileType', formData, false);

                        // Check for API errors
                        if (apiResponse && (apiResponse.error === true || apiResponse.error === 'true')) {
                            var errorMsg = apiResponse.message || apiResponse.Message || 'Error validating file type';
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(errorMsg);
                            continue;
                        }

                        // Normalize API response structure
                        var response = null;
                        if (apiResponse && apiResponse.data) {
                            if (apiResponse.data.data) {
                                response = apiResponse.data.data;
                            } else {
                                response = apiResponse.data;
                            }
                        } else if (apiResponse) {
                            response = apiResponse;
                        }

                        // Check if API validation passed (server-side handles all validation including XML)
                        var apiIsValid = false;
                        if (response) {
                            var isValidValue = response.IsValid || response.isValid || response.is_valid;
                            if (isValidValue !== undefined) {
                                apiIsValid = (isValidValue === true ||
                                    isValidValue === "true" ||
                                    isValidValue === "True" ||
                                    isValidValue === 1 ||
                                    isValidValue === "1");
                            }
                        }

                        // Server-side validation is complete (includes XML validation)
                        if (apiIsValid === true) {
                            validatedFiles.push(file);
                        } else {
                            var errorMsg = (response && response.Message) || 'Please upload valid file.';
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(errorMsg);
                        }
                    } catch (error) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_ErrorValidatingMimeType.replace("{0}", error.message));
                        // Skip this file
                        continue;
                    }
                }

                resolve(validatedFiles);
            });
        }
        // End of addition by Nischal C on 3/11/2025 - MIME type validation

        // Added by Nischal C on 3/11/2025 - Validate file for embedded EXE
        // Similar to CRM_RequestDetailsNew.aspx implementation with better error handling
        async function ValidateForexeinFile(file) {
            var objFile = file;
            var fileName = objFile.files[0].name;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            // Default: allow files unless they match extensions that require deep validation
            isValidTypeExeCheck = true;

            const ValidExtsExe = ValidateFileExtension.split(",").map(function(ext) { 
                return ext.trim().toLowerCase();
            });

            var requiresDeepValidation = ValidExtsExe.includes(extension);

            // If file type doesn't require deep validation, exit with allowed=true
            if (!requiresDeepValidation) {
                return;
            }

            if (requiresDeepValidation) {
                const fileObj = objFile.files[0];

                // validateDocFileForExe is in CommonFunctions.js (same as CRM_RequestDetailsNew.aspx)
                if (typeof validateDocFileForExe === 'function') {
                    await validateDocFileForExe(fileObj)
                        .then(() => {
                            // Explicitly mark as valid when no EXE is embedded
                            isValidTypeExeCheck = true;
                        })
                        .catch(error => {
                            // If validator can positively confirm EXE presence, block; otherwise allow
                            var errorText = (error && (error.message || error.toString())).toLowerCase();

                            var exeConfirmed = error && (error.hasEmbeddedExe === true || errorText.indexOf('embedded executable') > -1 || errorText.indexOf('.exe') > -1);

                            if (exeConfirmed) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_EmbeddedExecutable);
                                isValidTypeExeCheck = false;
                                $(objFile).val("");
                                return;
                            } else {
                                // Be permissive on parsing/other errors
                                console.warn('Skipping deep validation due to non-EXE error:', error);
                                isValidTypeExeCheck = true;
                            }
                        });
                } else {
                    // If function doesn't exist, skip EXE validation but allow file
                    isValidTypeExeCheck = true;
                }

                if (!isValidTypeExeCheck) {
                    return;
                }
            }
        }
        // End of addition by Nischal C on 3/11/2025 Validate file for embedded EXE
    </script>

</body>

</html>