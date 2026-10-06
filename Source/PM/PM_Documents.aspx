<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Documents.aspx.vb" Inherits="Whizible.PM_Documents" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.min.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/font.css?v=2">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom_project.css?">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />

    <style type="text/css">
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
            background-color: #e7edf0;
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
        
        /* Set minimum width for Document Category and Sub Category dropdowns */
        #StdocCategory + .btn.dropdown-toggle,
        #StdocSub + .btn.dropdown-toggle {
            min-width: 200px !important;
        }
        
        /* Fix Bootstrap Select picker click area */
        #cboProject + .btn.dropdown-toggle,
        .bootstrap-select .dropdown-toggle {
            pointer-events: auto !important;
            position: relative;
            z-index: 1;
        }
        
        .bootstrap-select {
            width: auto !important;
        }
        
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
    </style>

</head>

<body class="bgwhite">

     <!-- Added by Nischal C on 3/11/2025 for the Role Access -->
     <% If m_blnViewAccess Then %>
     <!-- End of added by Nischal C on 3/11/2025 for the Role Access -->

    <div class="bgwhite">
        <!--ps_list_table_start-->
        <div class="tab-pane pstbl_documents pt-0 active clearfix" id="pstbl_documents">
            <!-- Page Header with Icon -->
            <div class="page-header">
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
                        <input type="text" name="docName" class="form-control" id="docName">
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
                        <div class="d-flex gap-2" style="align-items: flex-start; margin-top: 0;">
                            <a href="javascript:;" class="btn btnyellow" id="showClick" onclick="fetchAllDocuments()" style=" display: inline-flex; align-items: center; margin-top: 4px;"><%=MyBase.GetResourceString("C_Show")%></a>
                            <a href="javascript:;" class="clearalllink" id="ClearAllFilter" onclick="clearFilters()" style="color: #1359a6; text-decoration: none; font-size: 11.5px; font-weight: 500; display: none; margin-right: 116px;"><strong><%=MyBase.GetResourceString("C_Clear")%></strong></a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="content mb-10">

                <div class="row">
                    <div class="col-sm-9"></div>
                    <div class="col-sm-3 text-end pb-1">
                        <div class="input-group">
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
                    <div class="table-responsive-custom">
                        <table id="prodocumentstbl" class="table table-bordered">
  <thead>
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
        <input id="docSltAll" class="chckHead" type="checkbox">
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

                <div id="containerUrls" style="display:none;">
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
                                            <input id="urlSltAll" class="chckHead" type="checkbox">
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


             <%--   <table id="prodocumentstbl" class="table table-bordered">
                   <thead>
  <tr>
    <th class="col-w-2">Document Category</th>
    <th class="col-w-2">Document Sub Category</th>
    <th class="col-w-3">Document Name (Latest)</th>
    <th class="col-w-1">Upload Date</th>
    <th class="col-w-1">Size (KB)</th>
    <th class="col-w-2">Last Modified</th>
    <th class="col-w-1">Actions</th>
    <th class="col-w-1 sm-wid">
      <div class="custom_chckbox">
        <input id="docSltAll" class="chckHead" type="checkbox">
        <label for="docSltAll"></label>
      </div>
    </th>
  </tr>
</thead>--%>

                   <%-- <tbody id="tbodySignOffs" class="tbodyDocuments">
                        <tr>
                            <td colspan="<%= If(m_blnDeleteAccess, "9", "8") %>" class="text-start">Sign Offs</td>
                        </tr>
                    </tbody>
                    <tbody id="tbodyPlans" class="tbodyDocuments">
                        <tr>
                            <td colspan="<%= If(m_blnDeleteAccess, "9", "8") %>" class="text-start">Plans</td>
                        </tr>
                    </tbody>
                    <tbody id="tbodyCommercials" class="tbodyDocuments">
                        <tr>
                            <td colspan="<%= If(m_blnDeleteAccess, "9", "8") %>" class="text-start">Commercials</td>
                        </tr>
                  <%--  </tbody>
                    <tbody id="tbodyReqSpe" class="tbodyDocuments">
                        <tr>
                            <td colspan="<%= If(m_blnDeleteAccess, "9", "8") %>" class="text-start">REQUIREMENT SPECIFICATIONS</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><a href="javascript:;" class="text-center">AllyGrow_Quote_Management_SRS_V_2.docx</a></td>
                            <td>04-May-2018</td>
                            <td>380.98</td>
                            <td>04-May-2018</td>
                            <td><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#Doc_reviewOffScreen">Review</a></td>
                            <td><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools">Show History</a></td>
                            <% If m_blnDeleteAccess Then %>
                            <td class="sm-wid">
                                <div class="custom_chckbox">
                                    <input id="docInnerFir" class="chckHead doc-chck" type="checkbox">
                                    <label for="docInnerFir"></label>
                                </div>
                            </td>
                            <% End If %>
                        </tr>
                        <tr class="detail-view-wrap">
                            <td colspan="<%= If(m_blnDeleteAccess, "9", "8") %>" class="text-start">
                                <div class="">
                                    <p class="mb-0"><strong>Uploaded By : </strong>saji.unni</p>
                                    <p class="mb-0"><strong>Comments : </strong>Draft Document</p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><a href="javascript:;" class="text-center">AllyGrow_Quote_Management_SRS_V_3.docx</a></td>
                            <td>04-May-2018</td>
                            <td>382.66</td>
                            <td>04-May-2018</td>
                            <td><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#Doc_reviewOffScreen">Review</a></td>
                            <td><a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_Tools">Show History</a></td>
                            <td class="sm-wid">
                                <div class="custom_chckbox">
                                    <input id="docInnerSec" class="chckHead doc-chck" type="checkbox">
                                    <label for="docInnerSec"></label>
                                </div>
                            </td>
                        </tr>
                        <tr class="detail-view-wrap">
                            <td colspan="9" class="text-start">
                                <div class="">
                                    <p class="mb-0"><strong>Uploaded By : </strong>saji.unni</p>
                                    <p class="mb-0"><strong>Comments : </strong>V3</p>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                   <tbody id="tbodyDesign" class="tbodyDocuments">
                        <tr>
                            <td colspan="<%= If(m_blnDeleteAccess, "9", "8") %>" class="text-start">Design</td>
                        </tr>
                    </tbody>
                    <tbody id="tbodyStatusRep" class="tbodyDocuments">
                        <tr>
                            <td colspan="<%= If(m_blnDeleteAccess, "9", "8") %>" class="text-start">Status Reports</td>
                        </tr>
                    </tbody>
                </table>--%>
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
            
            <!--Document Upload required field modal start here -->
           <%-- <div id="divMainAttachments" class="bottom-bar" style="">
                                                            <div class="row">
                                                                <div class="col-sm-12 ">
                                                                    <table id="tblMainFiles" style="display: none; margin-top: 1%" class="clsGridTable table table-bordered">

                                                                        <thead class="clsTRColumnHeader" align="left">
                                                                            <tr>
                                                                                <th width="5%"></th>
                                                                                <th width="15%">Files</th>
                                                                                <th>Comments</th>                                                                                
                                                                                <th width="20%">Document Type <span style="color:red;">*</span></th>                                              
                                                                                <th width="20%">Document Sub Type</th>                                                                                
                                                                                <th width="18%">Remove</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody id="bodyMainFiles">
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>--%>

            
           <!--Document Upload required field modal End here-->

            <!--Page modal start here-->
            <!--Upload document offcanvas start here-->
            <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
                 id="uploadDocOffScreen" aria-labelledby="uploadDocOffScreen">
                <div class="offcanvas-body">
                    <div class="container-fluid py-2 graybg mb-2">
                        <div class="row align-items-center">
                            <div class="col-sm-12">
                                <div class="d-flex align-items-center font-weight-600">
                                   <!-- Modified By Madhuri.K On 03-04-2026 -->
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_UplDoc")%></h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-2">
                        <div class="col-sm-12">
                            <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                <button type="button" class="btn borderbtn" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                    <%=MyBase.GetResourceString("C_Close")%>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="note-wrap note-wrap-txt mar-0 mb-10">
                        <p><strong>Note :</strong> <%=MyBase.GetResourceString("C_NoteMaxThreeFiles")%></p>
                    </div>
                    <div class="form-group row" style="margin-left: 179px;">
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
                                            <th width="5%">#</th>
                                            <th width="15%"><%=MyBase.GetResourceString("C_Files")%></th>
                                            <th width="20%" style="white-space: nowrap;"><%=MyBase.GetResourceString("C_DocumentType")%> <span style="color:red; display: inline;">*</span></th>
                                            <th width="20%"><%=MyBase.GetResourceString("C_DocumentSubType")%></th>
                                            <th width="20%"><%=MyBase.GetResourceString("C_ChangeRequest")%></th>
                                            <th width="16%"><%=MyBase.GetResourceString("C_Comments")%></th>
                                            <th width="18%"><%=MyBase.GetResourceString("C_Remove")%></th>
                                        </tr>
                                    </thead>
                                    <tbody id="bodyMainFiles">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12 text-center">
                            <button data-bs-dismiss="offcanvas" class="btn borderbtn" id="cnlID"><%=MyBase.GetResourceString("C_Cancel")%></button>
                            <button id="uploadDocBtn" class="btn btnyellow" onclick="uploadDocument()"><%=MyBase.GetResourceString("C_Upload")%></button>
                        </div>
                    </div>
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
                                     <!-- Modified By Madhuri.K On 03-04-2026 -->
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_AttURL")%></h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="Doc_reviewTab" class="Doc_reviewInfo">
                        <div class="row mb-2">
                            <div class="col-sm-12">
                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                    <button class="btn btnyellow" id="attachUrlbtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_AttURL")%>" onclick="Attach_OnClick()"><%=MyBase.GetResourceString("C_AttURL")%></button>
                                    <button class="btn borderbtn" type="button" id="cnl_Attach" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                        <%=MyBase.GetResourceString("C_Close")%>
                                    </button>
                                </div>
                                <div class="mandatory-note">
                                    <small>(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</small>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row mb-3">
                            <div class="col-sm-10">
                                <div class="row">
                                    <label class="col-sm-5 text-end"><%=MyBase.GetResourceString("C_EnterURL")%> <sup style="color: red; font-size: 0.7em; line-height: 0;">*</sup> <small><%=MyBase.GetResourceString("C_NoteCompleteURL")%></small></label>
                                    <div class="col-sm-6"> <input type="text" name="" class="form-control" id="txtURL" required></div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row ">
                            <div class="col-sm-6">
                                <div class="row mb-3">
                                    <div class="col-sm-6 text-end" style="position: relative;">
                                        <label><%=MyBase.GetResourceString("C_DocCategory")%></label>
                                        <div style="position: absolute; top: 0; right: 0;"><sup style="margin-right: 7px;color: red; font-size: 0.7em;">*</sup></div>
                                    </div>
                                    <div class="col-sm-6 custom-dropdown">
                                        <select class="selectpicker form-control" aria-label="<%=MyBase.GetResourceString("C_SelectDocumentCategory")%>" data-live-search="true" id="cboAttachCate" onchange="loadSubDocCategory(this.value, null, null, true)" required>
                                            <option value="0"><%=MyBase.GetResourceString("C_SelectDocumentCategory")%></option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                            <div class="col-sm-6">
                                <div class="row mb-3">
                                    <label class="col-sm-6 text-end"><%=MyBase.GetResourceString("C_SDocCategory")%></label>
                                    <div class="col-sm-6 custom-dropdown">
                                        <select class="selectpicker form-control" aria-label="<%=MyBase.GetResourceString("C_SelectSubCategory")%>" data-live-search="true" id="cboAttachSubCate">
                                            <option value="0"><%=MyBase.GetResourceString("C_SelectSubCategory")%></option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-6">
                                <div class="row mb-3">
                                    <label class="col-sm-6 text-end"><%=MyBase.GetResourceString("C_Description")%> <sup style="color: red; font-size: 0.7em; line-height: 0;">*</sup></label>
                                    <div class="col-sm-6">
                                        <textarea class="form-control" id="txtDescription" required></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
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
                                    <!-- Modified By Madhuri.K On 03-04-2026 -->
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_DocumentHistory")%></h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="CityEdtTab" class="CityInfo">
                        <div class="row mb-2">
                            <div class="col-sm-6">&nbsp;</div>
                            <div class="col-sm-6">
                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                    <button class="btn borderbtn" type="button" id="closeCityBtn" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                        <%=MyBase.GetResourceString("C_Close")%>
                                    </button>
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
                                     <!-- Modified By Madhuri.K On 03-04-2026 -->
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_DocumentReview")%></h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="Doc_reviewTab" class="Doc_reviewInfo">
                        <div class="row mb-2">
                            <div class="col-sm-6">&nbsp;</div>
                            <div class="col-sm-6">
                                <div class="nextBtnDiv d-flex justify-content-end gap-2">
                                    <button class="btn btnyellow" id="svDoc_review" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Save")%>" onclick="UpdshowReview()"><%=MyBase.GetResourceString("C_Save")%></button>
                                    <button class="btn borderbtn" type="button" id="closeDoc_review" data-bs-dismiss="offcanvas" aria-label="<%=MyBase.GetResourceString("C_Close")%>" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                        <%=MyBase.GetResourceString("C_Close")%>
                                    </button>
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
                                        <textarea class="form-control" rows="2" id="commentID"></textarea>
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

            <!-- REQUIRED JS SCRIPTS -->
            <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
            <!-- jqueryUI js -->
            <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
            <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
            <script src="../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>
            <script src="../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
            <script src="../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>
            <!--<script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>-->
            <script src="../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
            <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%> 
            <script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
            <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>




            <script>

                $(function () {
                    $('[data-bs-toggle="tooltip"]').tooltip();
                });

  /**************************script for drag and drop file*********************************/

                // Initialize drag and drop functionality
                function initializeDragAndDrop() {
                    document.querySelectorAll(".drop-zone__input").forEach((inputElement) => {
                        // Skip if already initialized
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
                                // Convert FileList to Array for easier manipulation
                                const filesArray = Array.from(e.dataTransfer.files);
                                
                                // Method 1: Try to use DataTransfer API (modern browsers)
                                if (typeof DataTransfer !== 'undefined') {
                                    try {
                                        const dataTransfer = new DataTransfer();
                                        filesArray.forEach(file => {
                                            dataTransfer.items.add(file);
                                        });
                                        inputElement.files = dataTransfer.files;
                                        
                                        // Trigger change event - jQuery will catch this
                                        $(inputElement).trigger('change');
                                        
                                        // Update thumbnail for visual feedback
                                        if (filesArray.length > 0) {
                                            updateThumbnail(dropZoneElement, filesArray[0]);
                            }

                            dropZoneElement.classList.remove("drop-zone--over");
                                        return;
                                    } catch (error) {
                                        // DataTransfer API failed, using fallback
                                    }
                                }
                                
                                // Method 2: Fallback - Create a FileList-like object and trigger change
                                // This works by creating a proxy that mimics FileList
                                try {
                                    // Create a FileList-like object
                                    const fileListProxy = {
                                        length: filesArray.length,
                                        item: function(index) { return filesArray[index] || null; }
                                    };
                                    
                                    // Add numeric indices for array-like access
                                    filesArray.forEach((file, index) => {
                                        fileListProxy[index] = file;
                                    });
                                    
                                    // Make it iterable
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
                                    
                                    // Try to set files property
                                    Object.defineProperty(inputElement, 'files', {
                                        value: fileListProxy,
                                        writable: false,
                                        configurable: true
                                    });
                                    
                                    // Trigger jQuery change event
                                    $(inputElement).trigger('change');
                                    
                                    if (filesArray.length > 0) {
                                        updateThumbnail(dropZoneElement, filesArray[0]);
                                    }
                                } catch (error) {
                                    // Last resort: Show error message
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileDropNotSupported);
                                }
                            }

                            dropZoneElement.classList.remove("drop-zone--over");
                        });
                    });
                }
                
                // Initialize on document ready
                $(document).ready(function() {
                    initializeDragAndDrop();
                });
                
                // Reinitialize when offcanvas is shown (in case offcanvas is dynamically loaded)
                $(document).on('shown.bs.offcanvas', '#uploadDocOffScreen', function() {
                    // Small delay to ensure DOM is fully ready
                    setTimeout(function() {
                        initializeDragAndDrop();
                    }, 100);
                });

          

                // Added by Nischal C on 3/11/2025 - Update thumbnail preview for file upload
                function updateThumbnail(dropZoneElement, file) {
                    // Check if file exists
                    if (!file) {
                        return;
                    }
                    
                    let thumbnailElement = dropZoneElement.querySelector(".drop-zone__thumb");


                    // First time - there is no thumbnail element, so lets create it
                    if (!thumbnailElement) {
                        thumbnailElement = document.createElement("div");
                        thumbnailElement.classList.add("drop-zone__thumb");
                       /* dropZoneElement.appendChild(thumbnailElement);*/
                    }

                    /*thumbnailElement.dataset.label = file.name;*/

                    // Show thumbnail for image files
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



                $(document).ready(function () {
                    // Added by Nischal C on 3/11/2025 - Get Employee Information including EmployeeImage
                    // This function retrieves employee information similar to Navigation.aspx
                    function GetEmployeeInformation() {
                        try {
                            // Use intLoginID from Session (same as Navigation.aspx)
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

                            $.ajax({
                                url: buildUrl("/api/DocumentUpload/GetEmployeeInformation"),
                                type: "POST",
                                data: JSON.stringify(requestData),
                                contentType: "application/json;charset=utf-8",
                                dataType: "json",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                                    xhr.setRequestHeader('Accept', 'application/json');
                                    var paramString = JSON.stringify(requestData);
                                    if (paramString) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(paramString) ? paramString : paramString));
                                    }
                                },
                                success: function (response) {
                                    try {
                                        // Handle ResponseEntity structure
                                        var data = response;
                                        
                                        // Check if response has data property (ResponseEntity structure)
                                        if (response && response.data) {
                                            data = response.data;
                                        }
                                        
                                        // Check if data has nested data property
                                        if (data && data.data) {
                                            data = data.data;
                                        }

                                        // Check if data is an array
                                        if (Array.isArray(data) && data.length > 0) {
                                            var employee = data[0];
                                            // API returns camelCase properties (employeeID, employeeName, employeeImage, etc.)
                                            var EmployeeID = employee.employeeID || employee.EmployeeID;
                                            var EmployeeName = employee.employeeName || employee.EmployeeName;
                                            var Role = employee.role || employee.Role;
                                            var EmployeeImage = employee.employeeImage || employee.EmployeeImage;
                                            var RoleID = employee.roleID || employee.RoleID;
                                            
                                            // Update employee image (similar to Navigation.aspx)
                                            var imagePath = "";
                                            if (EmployeeImage == "NoImage" || !EmployeeImage || EmployeeImage === "") {
                                                imagePath = "../../Images/Photo/no-photo.png";
                                            } else {
                                                imagePath = "../../Images/Photo/" + EmployeeImage;
                                            }
                                            
                                            // Function to update employee image elements
                                            function updateEmployeeImageElements() {
                                                // Try to find EmployeeImage elements in current window
                                                var $employeeImages = $(".EmployeeImage");
                                                var $userImage = $("#UserImage");
                                                
                                                // Also try to find in parent window (if this page is in an iframe)
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
                                                    // Cross-origin or other error, ignore
                                                }
                                                
                                                
                                                // Update EmployeeImage elements if found
                                                if ($employeeImages.length > 0) {
                                                    $employeeImages.each(function() {
                                                        var $img = $(this);
                                                        // Set onerror handler to fallback to no-photo.png if image fails to load
                                                        $img.off('error').on('error', function() {
                                                            $(this).attr("src", "../../Images/Photo/no-photo.png");
                                                        });
                                                        // Update src
                                                        $img.attr("src", imagePath);
                                                    });
                                                }
                                                
                                                // Update UserImage element if found
                                                if ($userImage.length > 0) {
                                                    // Set onerror handler to fallback to no-photo.png if image fails to load
                                                    $userImage.off('error').on('error', function() {
                                                        $(this).attr("src", "../../Images/Photo/no-photo.png");
                                                    });
                                                    // Update src
                                                    $userImage.attr("src", imagePath);
                                                }
                                                
                                                return $employeeImages.length > 0 || $userImage.length > 0;
                                            }
                                            
                                            // Try to update elements immediately
                                            var elementsFound = updateEmployeeImageElements();
                                            
                                            // If elements not found, retry after a short delay (Navigation.aspx might load later)
                                            if (!elementsFound) {
                                                setTimeout(function() {
                                                    updateEmployeeImageElements();
                                                }, 1000);
                                                
                                                // Also retry after a longer delay
                                                setTimeout(function() {
                                                    updateEmployeeImageElements();
                                                }, 3000);
                                            }
                                            
                                            // Store image path in a global variable for potential later use
                                            window.currentEmployeeImage = imagePath;
                                            window.currentEmployeeName = EmployeeName;
                                            window.currentEmployeeRole = Role;
                                            
                                            // Update user avatars in the table
                                            updateTableAvatars(imagePath, EmployeeName);

                                            // Update employee name and role if needed
                                            if (EmployeeName) {
                                                var $employeeName = $("#EmployeeName");
                                                var $employeeNameRole = $("#EmployeeNameRole");
                                                
                                                if ($employeeName.length > 0) {
                                                    $employeeName.html(EmployeeName);
                                                }
                                                
                                                if ($employeeNameRole.length > 0) {
                                                    $employeeNameRole.html(EmployeeName + "&nbsp;-&nbsp;" + (Role || "") + "");
                                                }
                                            }
                                        }
                                    } catch (error) {
                                        console.error('Error processing employee information:', error);
                                    }
                                },
                                error: function (err) {
                                    console.error('Error fetching employee information:', err);
                                }
                            });
                        } catch (error) {
                            console.error('Error in GetEmployeeInformation:', error);
                        }
                    }

                    // Call GetEmployeeInformation on page load
                    GetEmployeeInformation();

                    // When main checkbox is clicked (Documents table)
                    $("#docSltAll").on("click", function () {
                        if (!m_blnDeleteAccess) {
                            return;
                        }
                        var isChecked = $(this).prop('checked');
                        // Only select checkboxes in the documents table (not URLs table)
                        $("#tbodyReqSpe .doc-chck").prop('checked', isChecked);

                        // Optional: log all selected IDs
                        if (isChecked) {
                            getSelectedDocumentIDs(); // fetch all
                        }
                    });

                    // When main checkbox is clicked (URLs table)
                    $("#urlSltAll").on("click", function () {
                        if (!m_blnDeleteAccess) {
                            return;
                        }
                        var isChecked = $(this).prop('checked');
                        // Only select checkboxes in the URLs table
                        $("#tbodyUrls .doc-chck").prop('checked', isChecked);

                        // Optional: log all selected IDs
                        if (isChecked) {
                            getSelectedDocumentIDs(); // fetch all
                        }
                    });

                    // When individual checkboxes are changed (Documents table)
                    $("#tbodyReqSpe").on("change", ".doc-chck", function () {
                        var total = $("#tbodyReqSpe .doc-chck").length;
                        var checked = $("#tbodyReqSpe .doc-chck:checked").length;

                        // Sync main checkbox based on individual checkbox state
                        $("#docSltAll").prop('checked', total > 0 && total === checked);

                        // Log the current selected document ID
                        if ($(this).is(":checked")) {
                            var docId = $(this).data("documentid");
                        }
                    });

                    // When individual checkboxes are changed (URLs table)
                    $("#tbodyUrls").on("change", ".doc-chck", function () {
                        var total = $("#tbodyUrls .doc-chck").length;
                        var checked = $("#tbodyUrls .doc-chck:checked").length;

                        // Sync main checkbox based on individual checkbox state
                        $("#urlSltAll").prop('checked', total > 0 && total === checked);

                        // Log the current selected document ID
                        if ($(this).is(":checked")) {
                            var docId = $(this).data("documentid");
                        }
                    });


                    $("#detailView").click(function () {
                        // Set global flag for detail view
                        window.detailViewActive = true;
                     
                        // Add active class to detail view
                        $("#detailView").addClass('active');
                        $("#listView").removeClass('active');
                     
                        // Reload documents with detail view
                        fetchAllDocuments();
                    });
                    
                    $("#listView").click(function () {
                        // Set global flag for list view
                        window.detailViewActive = false;
                        
                        // Add active class to list view
                        $("#listView").addClass('active');
                        $("#detailView").removeClass('active');
                        
                        // Reload documents without detail view
                        fetchAllDocuments();
                    })
                });

                // Add Enter key support for Document Name search
                $(document).on('keypress', '#docName', function(e) {
                    if (e.key === 'Enter' || e.keyCode === 13) {
                        e.preventDefault();
                        fetchAllDocuments();
                    }
                });

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

                // Debounce timer for search
                var searchDebounceTimer = null;

                // Added by Nischal C on 3/11/2025 - Search documents with debouncing
                function myFunction() {
                    // Clear any pending search
                    if (searchDebounceTimer) {
                        clearTimeout(searchDebounceTimer);
                    }
                    
                    // Debounce: Wait 500ms after user stops typing before searching
                    searchDebounceTimer = setTimeout(function() {
                        // Use the search text from sercdeltsk input and sync it with docName input
                        // Then call fetchAllDocuments() to search via API (same as docName search)
                        var searchValue = $('#sercdeltsk').val() ? $('#sercdeltsk').val().trim() : '';
                        $('#docName').val(searchValue); // Sync with docName input
                        fetchAllDocuments(); // Search via API
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


                //$('#prodocumentstbl').dataTable({
                //    "scrollY": true,
                //    "scrollX": true,
                //    //"scroller": true,
                //    "pageLength": 5,
                //    //"paging": false,
                //    //"info": false,
                //    "lengthChange": false,
                //    "bFilter": false,
                //    "ordering": false,
                //    "responsive": true,
                //    "destroy": false,
                //    "retrieve": true,
                //    "responsive": true

                //});

                // Added by Nischal C on 3/11/2025 - Align DataTables columns
                function dtalign() {
                    setTimeout(function () {
                        try {
                            // Only adjust if DataTables instances exist and are initialized
                            var tables = $.fn.dataTable.tables({ visible: true, api: true });
                            if (tables && tables.length > 0) {
                                tables.columns.adjust();
                            }
                        } catch (e) {
                            // Ignore if DataTables is not initialized or fails
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
                        // Ignore if DataTables elements don't exist
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
                    A_ConfirmDeleteDocuments: '<%=MyBase.GetResourceString("A_ConfirmDeleteDocuments")%>',
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
                    $.ajax({
                        url: buildUrl(url),
                        type: "POST",
                        data: param,
                        async: async !== false, // Default to async if not specified
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
                        error: function (err) {
                            // Try to parse the error response as JSON
                            var errorMessage = err.statusText || 'Request failed';
                            var errorData = null;
                            
                            try {
                                if (err.responseText) {
                                    // Try to parse as JSON
                                    errorData = JSON.parse(err.responseText);
                                    errorMessage = errorData.message || errorData.Message || errorData.error || errorMessage;
                                }
                            } catch (e) {
                                // If parsing fails, use responseText as-is
                                errorMessage = err.responseText || errorMessage;
                            }
                            
                            // If we got a JSON response, use it; otherwise create error object
                            if (errorData) {
                                result = errorData; // Return the actual API response (which might have success: false)
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
                        // Update search placeholder for Documents tab
                        $('#sercdeltsk').attr('placeholder', '<%=MyBase.GetResourceString("C_SearchDocument")%>');
                    } else {
                        $('#liTabUrls').addClass('active');
                        $('#liTabUploaded').removeClass('active');
                        $('#containerUrls').show();
                        $('#containerUploaded').hide();
                        // Update search placeholder for URLs tab
                        $('#sercdeltsk').attr('placeholder', '<%=MyBase.GetResourceString("C_SearchUrl")%>');
                    }
                    
                    // Uncheck header checkboxes when switching tabs
                    $('#docSltAll').prop('checked', false);
                    $('#urlSltAll').prop('checked', false);
                    
                    // Reset to first page when switching tabs
                    currentPage = 1;
                    // Reload data for the active tab (unless skipReload is true)
                    if (!skipReload) {
                        fetchAllDocuments();
                    } else {
                        // If skipping reload, still update pagination for current view
                        showPageRows();
                    }
                }
                // End of addition by Nischal C on 3/11/2025 Switch between uploaded documents and URLs tabs

                $(document).ready(function () {

                    // Initialize project dropdown with search functionality
                    if (typeof $.fn.selectpicker !== 'undefined') {
                        $('#cboProject').selectpicker({
                            liveSearch: true,
                            liveSearchStyle: 'startsWith'
                        });
                        
                        // Set the selected project to session project ID after initialization
                        // Use setTimeout to ensure the dropdown is fully populated by server-side code
                        setTimeout(function() {
                            if (currentProjectID && currentProjectID > 0) {
                                var $projectSelect = $('#cboProject');
                                var projectValue = currentProjectID.toString();
                                
                                // Check if the value exists in the dropdown
                                if ($projectSelect.find('option[value="' + projectValue + '"]').length > 0) {
                                    $projectSelect.selectpicker('val', projectValue);
                                }
                            }
                        }, 100);
                    }
                    // Initialize selectpickers for dropdowns
                    $('#StdocCategory').selectpicker({
                        liveSearch: true,
                        liveSearchStyle: 'startsWith'
                    });
                    // Apply min-width to dropdown button after initialization
                    setTimeout(function() {
                        $('#StdocCategory').next('.btn.dropdown-toggle').css('min-width', '200px');
                    }, 100);
                    
                    $('#StdocSub').selectpicker({
                        liveSearch: true,
                        liveSearchStyle: 'startsWith'
                    });
                    // Apply min-width to dropdown button after initialization
                    setTimeout(function() {
                        $('#StdocSub').next('.btn.dropdown-toggle').css('min-width', '200px');
                    }, 100);
                    
                    // Function to apply min-width to dropdown buttons
                    function applyMinWidthToDropdowns() {
                        $('#StdocCategory').next('.btn.dropdown-toggle').css('min-width', '200px');
                        $('#StdocSub').next('.btn.dropdown-toggle').css('min-width', '200px');
                    }
                    
                    // Apply min-width after any selectpicker refresh
                    $(document).on('refreshed.bs.select', '#StdocCategory, #StdocSub', function() {
                        applyMinWidthToDropdowns();
                    });
                    
                    switchDocTab('uploaded');
                    loadDocCategory();
                    fetchAllDocuments();

                    // Bind search input events for sercdeltsk
                    $(document).on('keyup', '#sercdeltsk', function(e) {
                        // If Enter key is pressed, search immediately
                        if (e.key === 'Enter' || e.keyCode === 13) {
                            e.preventDefault();
                            // Clear debounce and search immediately
                            if (searchDebounceTimer) {
                                clearTimeout(searchDebounceTimer);
                            }
                            var searchValue = $('#sercdeltsk').val() ? $('#sercdeltsk').val().trim() : '';
                            $('#docName').val(searchValue);
                            fetchAllDocuments();
                        } else {
                            // For other keys, use debounced search
                            myFunction();
                        }
                        // Update Clear button visibility
                        toggleClearAllButton();
                    });
                    
                    // Bind search button click
                    $(document).on('click', '#searchButton', function(e) {
                        e.preventDefault();
                        // Clear debounce and search immediately
                        if (searchDebounceTimer) {
                            clearTimeout(searchDebounceTimer);
                        }
                        var searchValue = $('#sercdeltsk').val() ? $('#sercdeltsk').val().trim() : '';
                        $('#docName').val(searchValue);
                        fetchAllDocuments();
                        // Update Clear button visibility
                        toggleClearAllButton();
                    });
                    
                    // Bind events to show/hide Clear button when filters change
                    $(document).on('keyup', '#docName', function() {
                        toggleClearAllButton();
                    });
                    
                    $(document).on('changed.bs.select', '#StdocCategory', function() {
                        toggleClearAllButton();
                    });
                    
                    $(document).on('changed.bs.select', '#StdocSub', function() {
                        toggleClearAllButton();
                    });

                    // ✅ Bind Remove button once globally for all future rows
                    $('#bodyMainFiles').on('click', '.remove-row', function () {
                        const $row = $(this).closest('tr');
                        const rowIndex = $row.index();

                        selectedFiles.splice(rowIndex, 1); // ✅ Remove the file from the array
                        $row.remove(); // ✅ Remove row from DOM

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_DocumentRemovedSuccess);

                        const $allRows = $('#bodyMainFiles tr');

                        if ($allRows.length === 0) {
                            // ✅ Hide table and attachment container when last row is removed
                            $('#tblMainFiles').hide();
                            $('#divMainAttachments').hide();
                        } else {
                            // 🔁 Reindex row numbers
                            $allRows.each(function (i, row) {
                                $(row).find('td:first').text(i + 1);
                            });
                        }
                    });

                    // Toggle body scroll with offcanvas
                    $(document).on('show.bs.offcanvas', '.offcanvas', function () {
                        $('html, body').addClass('no-scroll');
                    });
                    $(document).on('shown.bs.offcanvas', '.offcanvas', function () {
                        $('html, body').addClass('no-scroll');
                    });
                    $(document).on('hide.bs.offcanvas', '.offcanvas', function () {
                        $('html, body').removeClass('no-scroll');
                    });
                    $(document).on('hidden.bs.offcanvas', '.offcanvas', function (e) {
                        $('html, body').removeClass('no-scroll');
                        
                        // Clear fields when Attach URL offcanvas is closed
                        if ($(e.target).attr('id') === 'AttachURLOffScreen') {
                            $('#txtURL').val('');
                            $('#txtDescription').val('');
                            $('#cboAttachCate').selectpicker('val', '0');
                            $('#cboAttachSubCate').empty().append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                            $('#cboAttachSubCate').selectpicker('refresh');
                            $('#cboAttachSubCate').selectpicker('val', '0');
                        }
                    });


                    // Use event delegation to ensure handler works even after modal reset
                    $(document).on('change', '#doc_dragdrop', function () {
                        var files = this.files;
                        if (files.length > 0) {
                            // Validate file selection using disallowBlank (similar to PM_ProjectDocuments.aspx)
                            var objFileInput = this;
                            if (disallowBlank(objFileInput, ResourceStrings.A_PleaseSelectFile)) {
                                $(this).val('');
                                return;
                            }
                            
                            // Validate file extensions using config (same as old page)
                            var validateExtensions = [];
                            var allowSubmit = false;
                            
                            if (FileExtensionDisallow && FileExtensionDisallow.length > 0) {
                                validateExtensions = FileExtensionDisallow.split(",");
                            }
                            
                            // Validate all files before processing
                            var invalidFiles = [];
                            var validFiles = [];
                            
                            $.each(files, function (index, file) {
                                var fileValue = file.name;
                                var extension = fileValue.slice(fileValue.lastIndexOf('.') + 1).toLowerCase();
                                allowSubmit = false;
                                
                                // Check if extension matches any in the allowed list (same logic as old page)
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
                            
                            // Show error if any invalid files found (same message format as old page)
                            if (invalidFiles.length > 0) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_InvalidFileExtension.replace("{0}", validateExtensions.join(", ").toUpperCase()));
                                // Clear the file input
                                $(this).val('');
                                return;
                            }
                            
                            // Additional validations (same as old page): multiple dots, filename length, special character #, file size, and path length
                            var hasInvalidFiles = false;
                            $.each(validFiles, function(index, file) {
                                // Check for multiple dots
                                var countOfDot = 0;
                                if (file.name != '') {
                                    countOfDot = file.name.split(".").length - 1;
                                }
                                if (countOfDot > 1) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_MultipleExtensions);
                                    hasInvalidFiles = true;
                                    return false; // break loop
                                }
                                
                                // Check filename length
                                var FileNameCharCount = 0;
                                if (file.name != '') {
                                    FileNameCharCount = file.name.split(".")[0].length;
                                }
                                if (FileNameCharCount > 120) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileNameTooLong);
                                    hasInvalidFiles = true;
                                    return false; // break loop
                                }
                                
                                // Check for special character # in filename (similar to PM_ProjectDocuments.aspx)
                                // Use direct check with alertify instead of disallowSpecialCharacters to ensure toaster notification
                                if (file.name.indexOf('#') !== -1) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_SpecialCharacterHash);
                                    hasInvalidFiles = true;
                                    return false; // break loop
                                }
                                
                                // Check minimum file size (MinFileSize from Web.config = 1024 bytes = 1 KB)
                                var minFileSizeBytes = parseInt(MinFileSize) || 1024;
                                if (file.size < minFileSizeBytes) {
                                    var minFileSizeKB = (minFileSizeBytes / 1024).toFixed(2);
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileSizeTooSmall.replace("{0}", minFileSizeKB));
                                    hasInvalidFiles = true;
                                    return false; // break loop
                                }
                                
                                // Check maximum file size (MaxFileSize from Web.config)
                                var maxFileSizeBytes = parseInt(MaxFileSize) || 99999999;
                                if (file.size > maxFileSizeBytes) {
                                    var maxFileSizeMB = (maxFileSizeBytes / (1024 * 1024)).toFixed(2);
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FileSizeTooLarge.replace("{0}", maxFileSizeMB));
                                    hasInvalidFiles = true;
                                    return false; // break loop
                                }
                                
                                // Check file path length (Windows path limit is 260 characters)
                                // Note: This is a client-side check. Actual path will be constructed on server.
                                // We check the filename length + estimated directory path length
                                var estimatedPathLength = file.name.length + 200; // Approximate directory path length
                                if (estimatedPathLength > 260) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(ResourceStrings.A_FilePathTooLong);
                                    hasInvalidFiles = true;
                                    return false; // break loop
                                }
                            });
                            
                            if (hasInvalidFiles) {
                                $(this).val('');
                                return;
                            }
                            
                            // Check total files count (max 3 files)
                            var currentRowCount = $('#bodyMainFiles tr').length;
                            if (currentRowCount + validFiles.length > 3) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_MaxThreeFiles);
                                $(this).val('');
                                return;
                            }
                            
                            // Show the table and container
                            $('#divMainAttachments').show();
                            $('#tblMainFiles').show();
                           
                            var $tbody = $('#bodyMainFiles');
                            var uniqueID = $tbody.find('tr').length + 1; // ✅ Corrected placement and syntax

                            // $tbody.empty(); // ❌ Do not empty if you want to keep existing rows

                            // Validate files for embedded EXE before processing (same as CRM_AddNewRequest.aspx)
                            var self = this;
                            var filesToProcess = [];
                            
                            // Process files sequentially for async EXE validation
                            async function validateFilesForExe() { 
                              //  debugger
                                for (var idx = 0; idx < validFiles.length; idx++) {
                                    var file = validFiles[idx];
                                    
                                    try {
                                        // Create a temporary file input object for ValidateForexeinFile (same pattern as CRM_AddNewRequest.aspx)
                                        var tempFileInput = document.createElement('input');
                                        tempFileInput.type = 'file';
                                        
                                        // Create a new FileList-like object
                                        var dataTransfer = new DataTransfer();
                                        dataTransfer.items.add(file);
                                        tempFileInput.files = dataTransfer.files;
                                        
                                        await ValidateForexeinFile(tempFileInput);
                                        
                                        // Check if file passed EXE validation
                                        if (isValidTypeExeCheck !== false && isValidTypeExeCheck !== undefined) {
                                            filesToProcess.push(file);
                                        } else {
                                            // File has embedded EXE, skip it
                                            continue;
                                        }
                                    } catch (error) {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.error(ResourceStrings.A_EmbeddedExecutable);
                                        // Skip this file
                                        continue;
                                    }
                                }
                                return true;
                            }
                            
                            // Execute async EXE validation
                            validateFilesForExe().then(function(success) {
                                if (filesToProcess.length === 0) {
                                    $(self).val('');
                                    return;
                                }
                                
                                // Use validated files instead of original validFiles
                                validFiles = filesToProcess;
                                
                                // Added by Nischal C on 3/11/2025 - MIME type validation using GetFileType API
                                // Validate MIME type for each file before adding to grid
                                validateFilesMimeType(validFiles).then(function(mimeValidFiles) {
                                    if (mimeValidFiles.length === 0) {
                                        $(self).val('');
                                        return;
                                    }
                                    
                                    // Use MIME-validated files
                                    validFiles = mimeValidFiles;
                                
                                $.each(validFiles, function (index, file) {
                                var rowCount = $tbody.find('tr').length + 1;
                                // Use local variables to capture values for each iteration
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
                     <select class="form-control CateTypeID" id="${localUniqueIDcateID}" onchange="loadSubDocCategoryModal(this.value, '${localUniqueIDSubcateID}', '${localUniqueIDChangeReTypeID}')">

                            <!-- Category options will be loaded -->
                        </select>
                    </td>
                    <td>
                        <select class="form-control SubCateTypeID" id="${localUniqueIDSubcateID}">
                            <option value="0">Select Document Sub Type</option>
                            <!-- Subcategory options will be loaded -->
                        </select>


                    </td>
                    <td>
                        <select class="form-control ChangeReTypeID" id="${localUniqueIDChangeReTypeID}">
                            <option value="0"><%=MyBase.GetResourceString("C_SelectChangeRequest")%></option>
                        </select>
                    </td>
                    <td><input type="text" class="form-control" placeholder="<%=MyBase.GetResourceString("C_EnterComment")%>" id="${"Comment" + localUniqueIDChangeReTypeID}"></td>
                    <td>
                        <button type="button" class="btn btn-danger btn-sm remove-row">Remove</button>
                    </td>
                </tr>`;

                                $tbody.append(row);

                                // Load categories from API - use setTimeout with increasing delay for each file to avoid conflicts
                                // Capture the local variable in closure
                                (function(capturedCateID) {
                                    setTimeout(function() {
                                        // Verify element exists before calling loadDocCategory
                                        var $dropdown = $('#' + capturedCateID);
                                        if ($dropdown.length > 0) {
                                            loadDocCategory(capturedCateID);
                                        } else {
                                            // Retry after a longer delay
                                            setTimeout(function() {
                                                var $retryDropdown = $('#' + capturedCateID);
                                                if ($retryDropdown.length > 0) {
                                                    loadDocCategory(capturedCateID);
                                                }
                                            }, 300);
                                        }
                                    }, 200 + (index * 100)); // Stagger the delays to avoid race conditions
                                })(localUniqueIDcateID);
                            });
                                
                                // Modal dropdowns are plain HTML selects, no selectpicker initialization needed
                                // The dropdowns will be populated by loadDocCategory function
                                }).catch(function(error) {
                                    // Error already handled in MIME validation function
                                });
                            }).catch(function(error) {
                                // Error already handled in EXE validation function
                            });
                        }

                        const dropZone = this.closest('.drop-zone');
                        if (this.files && this.files.length > 0) {
                        updateThumbnail(dropZone, this.files[0]); // ✅ This gets triggered only on document select
                        }
                    });

                    $('#uploadDocOffScreen').on('show.bs.offcanvas', function () {
                        // Reset all form elements when offcanvas opens
                        $('#tblMainFiles').hide();
                        $('#divMainAttachments').hide();
                        
                        // Destroy DataTable if it exists
                        if ($.fn.DataTable.isDataTable('#tblMainFiles')) {
                            $('#tblMainFiles').DataTable().clear().destroy();
                        }
                        
                        $('#bodyMainFiles').empty();
                        selectedFiles.length = 0; // Clear the selected files array
                        
                        // Reset file input
                        var fileInputs = $('#uploadDocOffScreen input[type="file"]');
                        fileInputs.val('');
                        
                        // Reset any other form elements if needed
                        $('#uploadDocOffScreen input[type="text"]').val('');
                        $('#uploadDocOffScreen select').val('0').trigger('change');
                    });
                    
                    // Also reset when offcanvas is hidden (after close)
                    $('#uploadDocOffScreen').on('hidden.bs.offcanvas', function () {
                        // Reset file input when offcanvas closes
                        var fileInputs = $('#uploadDocOffScreen input[type="file"]');
                        fileInputs.val('');
                        
                        // Reset table and files
                        $('#tblMainFiles').hide();
                        $('#divMainAttachments').hide();
                        $('#bodyMainFiles').empty();
                        selectedFiles.length = 0;
                        
                        // Destroy DataTable if it exists
                        if ($.fn.DataTable.isDataTable('#tblMainFiles')) {
                            $('#tblMainFiles').DataTable().clear().destroy();
                        }
                    });

                });

                // Track upload status for multiple files
                var uploadStatus = {
                    total: 0,
                    success: 0,
                    failed: 0,
                    errors: []
                };
                
                // Added by Nischal C on 3/11/2025 - Upload file to server with FormData
                function uploadFileWithFormData(url, formData, index, totalFilesCount, fileName, documentID, versionedFileName) {
                    $.ajax({
                        url: buildUrl(url),
                        type: "POST",
                        data: formData,
                        processData: false,
                        contentType: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("Authorization", "Bearer " + sessionStorage.getItem("access_token_W26API"));
                        },
                        success: function (data) {
                            // Check if SaveFileToServer actually succeeded
                            // Response structure: { status: "SUCCESS", data: { Success: true, Message: "...", FilePath: "..." } }
                            // OR: { Status: "SUCCESS", Data: { ... } }
                            var responseData = data.data || data.Data || data;
                            var saveResponse = responseData.data || responseData;
                            
                            // Check for success indicators - multiple ways to indicate success
                            var isSuccess = false;
                            
                            // Check status at root level - handle multiple response formats
                            // Format 1: { status: "SUCCESS", data: { Success: true, ... } }
                            // Format 2: { success: true, message: "...", filePath: "..." }
                            if (data.status === 'SUCCESS' || data.Status === 'SUCCESS') {
                                // If status is SUCCESS, check if there's an explicit failure in the response
                                if (saveResponse && saveResponse.Success === false) {
                                    isSuccess = false;
                                } else if (saveResponse && saveResponse.Success === true) {
                                    isSuccess = true;
                                } else {
                                    // If status is SUCCESS but no explicit Success field, assume success
                                    isSuccess = true;
                                }
                            } else if (data.status === 'FAILURE' || data.Status === 'FAILURE') {
                                // Explicit failure status
                                isSuccess = false;
                            } else if (data.success === true || data.Success === true) {
                                // Format 2: Direct success field
                                isSuccess = true;
                            } else if (data.success === false || data.Success === false) {
                                // Format 2: Direct failure field
                                isSuccess = false;
                            } else {
                                // If no status field, check saveResponse directly
                                if (saveResponse && (saveResponse.Success === true || saveResponse.success === true)) {
                                    isSuccess = true;
                                } else if (saveResponse && (saveResponse.Success === false || saveResponse.success === false)) {
                                    isSuccess = false;
                                } else {
                                    // If no explicit success/failure, check for error message
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
                            
                            // Note: The stored procedure now handles versioning in the database automatically
                            // The FileName in the database will be set with version suffix (e.g., file_v2.pdf)
                            // No need to update the database FileName here - the stored procedure does it
                            
                            // Check if all files are done (either success or failed)
                            var totalCompleted = uploadStatus.success + uploadStatus.failed;
                            
                            // Only show success message when ALL files are done
                            if (totalCompleted >= uploadStatus.total) {
                                // Use setTimeout to ensure all async operations complete
                                setTimeout(function() {
                                    // Only trigger cancel and show alert when all files are done
                                    $('#cnlID').trigger('click');
                                    
                                    if (uploadStatus.failed === 0) {
                                alertify.set('notifier', 'position', 'top-right');
                                        alertify.success(ResourceStrings.A_AllDocumentsUploadedSuccess);
                                    } else {
                                        var successMsg = uploadStatus.success > 0 ? uploadStatus.success + ' file(s) uploaded successfully. ' : '';
                                        var errorMsg = successMsg + uploadStatus.failed + ' file(s) failed:\n\n' + uploadStatus.errors.join('\n');
                                        alertify.error(errorMsg);
                                    }
                                    
                                    // Switch to uploaded documents tab and refresh to show new document at top
                                    switchDocTab('uploaded', true); // Skip reload in switchDocTab
                                    setTimeout(function() {
                                        fetchAllDocuments(); // Refresh the table (newest will be at top due to sorting)
                                    }, 300);
                                    
                                    // Reset upload status
                                    uploadStatus = { total: 0, success: 0, failed: 0, errors: [] };
                                }, 500);
            }
        },
        error: function (err) {
                            uploadStatus.failed++;
                            var errorMsg = fileName || ('File ' + (index + 1)) + ': ' + (err.responseText || err.statusText || 'Upload failed');
                            uploadStatus.errors.push(errorMsg);
                            
                            // Don't redirect on error - just log it and continue with other files
                            // Only redirect if ALL files failed
                            if (uploadStatus.failed === totalFilesCount) {
                                var allErrors = uploadStatus.errors.join('\n');
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_AllUploadsFailed.replace("{0}", allErrors));
                                window.location.href = "../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(allErrors);
                            }
        }
    });
                }



                // Added by Nischal C on 3/11/2025 - Load document categories from API
                function loadDocCategory(uniqueIDcateID,UrlFlag) {

                     if (UrlFlag) {


                        var docTypeParams = {
                             RoleID: intPostID,
                             ProjectID: currentProjectID
                        };

                        var param = JSON.stringify(docTypeParams);
                        var resultRaw = null;
                        
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/GetDocumentType"),
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
                                resultRaw = data;
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
                                    resultRaw = errorData;
                                } else {
                                    resultRaw = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });
                        
                         var result = [];
                         
                         // Normalize API response - try multiple response structures
                         // API returns: { Status: 'SUCCESS', Data: { message: '...', data: [...] } }
                         try {
                             if (resultRaw && resultRaw.data) {
                                 // Check for resultRaw.data.data (nested data structure)
                                 if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                     result = resultRaw.data.data; 
                                 } 
                                 // Check if resultRaw.data is directly an array
                                 else if (Array.isArray(resultRaw.data)) { 
                                     result = resultRaw.data; 
                                 }
                                 // Check for items array
                                 else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                     result = resultRaw.data.items;
                                 }
                                 // Check for DocumentTypeModel array in data
                                 else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.DocumentTypeModel && Array.isArray(resultRaw.data.DocumentTypeModel)) {
                                     result = resultRaw.data.DocumentTypeModel;
                                 }
                             } 
                             // Check if resultRaw is directly an array
                             else if (Array.isArray(resultRaw)) { 
                                 result = resultRaw; 
                             }
                         } catch (e) {
                             // Handle normalization error
                         }


                        // Target the select element
                        var $Attachselect = $('#cboAttachCate');
                        
                        // Ensure selectpicker is initialized
                        if (!$Attachselect.data('selectpicker')) {
                            $Attachselect.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                        
                        $Attachselect.empty(); // Remove any existing options
                        $Attachselect.append('<option value="0">' + ResourceStrings.C_SelectDocumentCategory + '</option>');

                        // Add the dynamic options from the result
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

                        // Only load subcategories if a valid category is selected
                        var selectedCategoryId = $('#cboAttachCate').val();
                        if (selectedCategoryId && selectedCategoryId !== '0') {
                            loadSubDocCategory(selectedCategoryId, null, uniqueIDcateID, subFlag);
                        } else {
                            // Clear subcategory dropdown if no category selected
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

                        var param = JSON.stringify(docTypeParams);
                        var resultRaw = null;
                        
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/GetDocumentType"),
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
                                resultRaw = data;
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
                                    resultRaw = errorData;
                                } else {
                                    resultRaw = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });
                        
                        var result = [];
                        
                        // Normalize API response - try multiple response structures
                        // API returns: { Status: 'SUCCESS', Data: { message: '...', data: [...] } }
                        try {
                            if (resultRaw && resultRaw.data) {
                                // Check for resultRaw.data.data (nested data structure)
                                if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                    result = resultRaw.data.data; 
                                } 
                                // Check if resultRaw.data is directly an array
                                else if (Array.isArray(resultRaw.data)) { 
                                    result = resultRaw.data; 
                                }
                                // Check for items array
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                    result = resultRaw.data.items;
                                }
                                // Check for DocumentTypeModel array in data
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.DocumentTypeModel && Array.isArray(resultRaw.data.DocumentTypeModel)) {
                                    result = resultRaw.data.DocumentTypeModel;
                                }
                            } 
                            // Check if resultRaw is directly an array
                            else if (Array.isArray(resultRaw)) { 
                                result = resultRaw; 
                            }
                        } catch (e) {
                            // Handle normalization error
                        }

                        // Target the select element
                        var $select = $('#StdocCategory');
                        
                        // Ensure selectpicker is initialized
                        if (!$select.data('selectpicker')) {
                            $select.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                        
                        $select.empty(); // Remove any existing options

                        // Add default option with value "0" using the header text
                        $select.append('<option value="0">' + ResourceStrings.C_SelectDocumentCategory + '</option>');

                        // Add the dynamic options from the result
                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var categoryId = item.CategoryID || item.categoryID || item.ID || item.id || item.DocumentTypeID || item.documentTypeID || '';
                                var categoryName = item.Category || item.category || item.Name || item.name || item.DocumentType || item.documentType || '';
                                if (categoryId && categoryName && categoryId !== '0') {
                                    $select.append('<option value="' + categoryId + '">' + categoryName + '</option>');
                                }
                            });
                        }

                        // Refresh Bootstrap Select and ensure the default option is selected.
                        $select.selectpicker('refresh');
                        $select.selectpicker('val', '0');

                        // Only load subcategories if a valid category is selected (not '0')
                        var selectedCategoryId = $('#StdocCategory').val();
                        if (selectedCategoryId && selectedCategoryId !== '0') {
                            loadSubDocCategory(selectedCategoryId, null, uniqueIDcateID);
                        } else {
                            // Clear subcategory dropdown if no category selected
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

                        // Modal dropdown loading
                        var docTypeParams = {
                            RoleID: intPostID,
                            ProjectID: currentProjectID
                        };

                        var param = JSON.stringify(docTypeParams);
                        var resultRaw = null;
                        
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/GetDocumentType"),
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
                                resultRaw = data;
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
                                    resultRaw = errorData;
                                } else {
                                    resultRaw = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });
                        
                        var result = [];
                        
                        // Normalize API response - try multiple response structures
                        // API returns: { Status: 'SUCCESS', Data: { message: '...', data: [...] } }
                        try {
                            if (resultRaw && resultRaw.data) {
                                // Check for resultRaw.data.data (nested data structure)
                                if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                    result = resultRaw.data.data; 
                                } 
                                // Check if resultRaw.data is directly an array
                                else if (Array.isArray(resultRaw.data)) { 
                                    result = resultRaw.data; 
                                }
                                // Check for items array
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                    result = resultRaw.data.items;
                                }
                                // Check for DocumentTypeModel array in data
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.DocumentTypeModel && Array.isArray(resultRaw.data.DocumentTypeModel)) {
                                    result = resultRaw.data.DocumentTypeModel;
                                }
                            } 
                            // Check if resultRaw is directly an array
                            else if (Array.isArray(resultRaw)) { 
                                result = resultRaw; 
                            }
                        } catch (e) {
                            // Handle normalization error
                        }

                        // Select the dropdown using the dynamic ID
                          var $cateTypeID = $('#' + uniqueIDcateID);

                        // Check if element exists
                        if ($cateTypeID.length === 0) {
                            return;
                        }

                        // Clear existing options first
                        $cateTypeID.empty();
                        $cateTypeID.append('<option value="0">' + ResourceStrings.C_SelectDocumentCategory + '</option>');

                        // Populate the dropdown
                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var categoryId = item.CategoryID || item.categoryID || item.ID || item.id || item.DocumentTypeID || item.documentTypeID || '';
                                var categoryName = item.Category || item.category || item.Name || item.name || item.DocumentType || item.documentType || '';
                                if (categoryId && categoryName && categoryId !== '0') {
                                    $cateTypeID.append('<option value="' + categoryId + '">' + categoryName + '</option>');
                                }
                            });
                        }
                        
                        // For modal dropdowns, just set the value directly (no selectpicker needed)
                        // The dropdowns are plain HTML selects, not selectpicker
                        $cateTypeID.val('0');

                    }
              
                   
                }
                // End of addition by Nischal C on 3/11/2025 Load sub-document categories based on selected category and project

                // Added by Nischal C on 3/11/2025 - Load sub-document categories based on selected category and project
                function loadSubDocCategory(CategoryID, SubCategoryID,flag,subFlag,changeRequestId) {

                    if (subFlag == true) {

                        var cboAttachCate = $('#cboAttachCate').val();
                        
                        // Don't load subcategories if CategoryID is 0 or null
                        if (!cboAttachCate || cboAttachCate === '0' || cboAttachCate === 0) {
                            var $subSelect = $('#cboAttachSubCate');
                            if ($subSelect.length) {
                                if (!$subSelect.data('selectpicker')) {
                                    $subSelect.selectpicker({
                                        liveSearch: true,
                                        liveSearchStyle: 'startsWith'
                                    });
                                }
                                $subSelect.empty();
                                $subSelect.append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                                $subSelect.selectpicker('refresh');
                                $subSelect.selectpicker('val', '0');
                            }
                            return;
                        }

                        var subDocTypeParams = {
                            CategoryID: cboAttachCate,
                            SubCategoryID: SubCategoryID,
                            ProjectID: currentProjectID
                        };

                        var param = JSON.stringify(subDocTypeParams);
                        var resultRaw = null;
                        
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/GetSubDocType"),
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
                                resultRaw = data;
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
                                    resultRaw = errorData;
                                } else {
                                    resultRaw = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });
                        
                        var result = [];
                        
                        // Normalize API response - try multiple response structures
                        // API returns: { Status: 'SUCCESS', Data: { message: '...', data: [...] } }
                        try {
                            if (resultRaw && resultRaw.data) {
                                // Check for resultRaw.data.data (nested data structure)
                                if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                    result = resultRaw.data.data; 
                                } 
                                // Check if resultRaw.data is directly an array
                                else if (Array.isArray(resultRaw.data)) { 
                                    result = resultRaw.data; 
                                }
                                // Check for items array
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                    result = resultRaw.data.items;
                                }
                                // Check for SubDocumentTypeModel array in data
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.SubDocumentTypeModel && Array.isArray(resultRaw.data.SubDocumentTypeModel)) {
                                    result = resultRaw.data.SubDocumentTypeModel;
                                }
                            } 
                            // Check if resultRaw is directly an array
                            else if (Array.isArray(resultRaw)) { 
                                result = resultRaw; 
                            }
                        } catch (e) {
                            // Handle normalization error
                        }

                        // Target the sub-category select element
                        var $subSelect = $('#cboAttachSubCate');
                        
                        // Ensure selectpicker is initialized
                        if (!$subSelect.data('selectpicker')) {
                            $subSelect.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                        
                        $subSelect.empty();
                        $subSelect.append('<option value="0">Select sub category</option>');

                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var subCategoryId = item.SubCategoryID || item.subCategoryID || item.ID || item.id || item.SubDocumentTypeID || item.subDocumentTypeID || '';
                                var subCategoryName = item.SubCategory || item.subCategory || item.Name || item.name || item.SubDocumentType || item.subDocumentType || '';
                                if (subCategoryId && subCategoryName && subCategoryId !== '0') {
                                    $subSelect.append('<option value="' + subCategoryId + '">' + subCategoryName + '</option>');
                                }
                            });

                            $subSelect.selectpicker('refresh');
                            $subSelect.selectpicker('val', '0');
                        }


return
                    }
                    else if (!flag) {

                        var subDocTypeParams = {
                            CategoryID: CategoryID,
                            SubCategoryID: SubCategoryID,
                            ProjectID: currentProjectID
                        };

                        var param = JSON.stringify(subDocTypeParams);
                        var resultRaw = null;
                        
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/GetSubDocType"),
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
                                resultRaw = data;
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
                                    resultRaw = errorData;
                                } else {
                                    resultRaw = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });
                        
                        var result = [];
                        
                        // Normalize API response - try multiple response structures
                        // API returns: { Status: 'SUCCESS', Data: { message: '...', data: [...] } }
                        try {
                            if (resultRaw && resultRaw.data) {
                                // Check for resultRaw.data.data (nested data structure)
                                if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                    result = resultRaw.data.data; 
                                } 
                                // Check if resultRaw.data is directly an array
                                else if (Array.isArray(resultRaw.data)) { 
                                    result = resultRaw.data; 
                                }
                                // Check for items array
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                    result = resultRaw.data.items;
                                }
                                // Check for SubDocumentTypeModel array in data
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.SubDocumentTypeModel && Array.isArray(resultRaw.data.SubDocumentTypeModel)) {
                                    result = resultRaw.data.SubDocumentTypeModel;
                                }
                            } 
                            // Check if resultRaw is directly an array
                            else if (Array.isArray(resultRaw)) { 
                                result = resultRaw; 
                            }
                        } catch (e) {
                            // Handle normalization error
                        }

                        // Target the sub-category select element
                        var $subSelect = $('#StdocSub');
                        
                        // Ensure selectpicker is initialized
                        if (!$subSelect.data('selectpicker')) {
                            $subSelect.selectpicker({
                                liveSearch: true,
                                liveSearchStyle: 'startsWith'
                            });
                        }
                        
                        $subSelect.empty(); // Clear existing options
                        $subSelect.append('<option value="0">Select Document Sub Category</option>');

                        // Populate sub-category dropdown
                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var subCategoryId = item.SubCategoryID || item.subCategoryID || item.ID || item.id || item.SubDocumentTypeID || item.subDocumentTypeID || '';
                                var subCategoryName = item.SubCategory || item.subCategory || item.Name || item.name || item.SubDocumentType || item.subDocumentType || '';
                                if (subCategoryId && subCategoryName && subCategoryId !== '0') {
                                    $subSelect.append('<option value="' + subCategoryId + '">' + subCategoryName + '</option>');
                                }
                            });
                        }

                        $subSelect.selectpicker('refresh');
                        $subSelect.selectpicker('val', '0');
                        return;

                    }
                   else {

                        // Modal subcategory dropdown loading
                        // Don't load subcategories if CategoryID is 0 or null
                        if (!CategoryID || CategoryID === '0' || CategoryID === 0) {
                            var $subSelect = $('#' + flag);
                            if ($subSelect.length) {
                                $subSelect.empty();
                                $subSelect.append('<option value="0">' + ResourceStrings.C_SelectSubCategory + '</option>');
                            }
                            return;
                        }

                        var subDocTypeParams = {
                            CategoryID: CategoryID,
                            SubCategoryID: SubCategoryID,
                            ProjectID: currentProjectID
                        };

                        var param = JSON.stringify(subDocTypeParams);
                        var resultRaw = null;
                        
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/GetSubDocType"),
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
                                resultRaw = data;
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
                                    resultRaw = errorData;
                                } else {
                                    resultRaw = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });
                        
                        var result = [];
                        
                        // Normalize API response - try multiple response structures
                        // API returns: { Status: 'SUCCESS', Data: { message: '...', data: [...] } }
                        try {
                            if (resultRaw && resultRaw.data) {
                                // Check for resultRaw.data.data (nested data structure)
                                if (resultRaw.data.data && Array.isArray(resultRaw.data.data)) { 
                                    result = resultRaw.data.data; 
                                } 
                                // Check if resultRaw.data is directly an array
                                else if (Array.isArray(resultRaw.data)) { 
                                    result = resultRaw.data; 
                                }
                                // Check for items array
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.items && Array.isArray(resultRaw.data.items)) {
                                    result = resultRaw.data.items;
                                }
                                // Check for SubDocumentTypeModel array in data
                                else if (resultRaw.data && typeof resultRaw.data === 'object' && resultRaw.data.SubDocumentTypeModel && Array.isArray(resultRaw.data.SubDocumentTypeModel)) {
                                    result = resultRaw.data.SubDocumentTypeModel;
                                }
                            } 
                            // Check if resultRaw is directly an array
                            else if (Array.isArray(resultRaw)) { 
                                result = resultRaw; 
                            }
                        } catch (e) {
                            // Handle normalization error
                        }

                        // Target the sub-category select element using the flag parameter (which is the uniqueIDSubcateID)
                        var $subSelect = $('#' + flag);

                        $subSelect.empty();
                        $subSelect.append('<option value="0">Select Document Sub Type</option>');

                        // Populate sub-category dropdown
                        if (result && Array.isArray(result) && result.length > 0) {
                            result.forEach(function (item) {
                                var subCategoryId = item.SubCategoryID || item.subCategoryID || item.ID || item.id || item.SubDocumentTypeID || item.subDocumentTypeID || '';
                                var subCategoryName = item.SubCategory || item.subCategory || item.Name || item.name || item.SubDocumentType || item.subDocumentType || '';
                                if (subCategoryId && subCategoryName && subCategoryId !== '0') {
                                    $subSelect.append('<option value="' + subCategoryId + '">' + subCategoryName + '</option>');
                                }
                            });
                        }

                        // For the fetching the change requests and bind in the dropdown  
                        // Use the changeRequestId parameter if passed, otherwise find it in the row
                        var changeRequestIdToUse = changeRequestId;
                        if (!changeRequestIdToUse) {
                            var $row = $subSelect.closest('tr');
                            if ($row.length > 0) {
                                var $changeReSelect = $row.find('select.ChangeReTypeID');
                                if ($changeReSelect.length > 0) {
                                    changeRequestIdToUse = $changeReSelect.attr('id');
                                }
                            }
                        }
                        
                        // Load change requests if dropdown ID is found
                        if (changeRequestIdToUse && currentProjectID) {
                            loadChangeRequests(changeRequestIdToUse, currentProjectID);
                        }


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

                    var changeReParam = JSON.stringify(changeReParams);
                    var changeReResultRaw = null;
                    
                    $.ajax({
                        url: buildUrl("/api/DocumentUpload/GetChangeReType"),
                        type: "POST",
                        data: changeReParam,
                        async: false,
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            xhr.setRequestHeader('Accept', 'application/json');
                            if (changeReParam) {
                                xhr.setRequestHeader("Params", encryptString(isJson(changeReParam) ? changeReParam : JSON.stringify(changeReParam)));
                            }
                        },
                        success: function (data) {
                            changeReResultRaw = data;
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
                                changeReResultRaw = errorData;
                            } else {
                                changeReResultRaw = { error: true, success: false, message: errorMessage, statusCode: err.status };
                            }
                            console.error('GetChangeReType API error:', err.status, errorMessage);
                        }
                    });
                    
                    var changeReResult = [];
                    
                    // Normalize API response - try multiple response structures
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
                        
                        // Reload all data for the new project
                        // Clear and reload document categories
                    loadDocCategory();
                        
                        // Clear and reload documents table
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
                    var CategoryID = $('#StdocCategory').val();
                    var SubCategoryID = $('#StdocSub').val();
                    var strAlphabet = "-1";
                    // Get search text from either docName or sercdeltsk input (whichever has value)
                    var searchTextFromDocName = $('#docName').val() ? $('#docName').val().trim() : '';
                    var searchTextFromSercdeltsk = $('#sercdeltsk').val() ? $('#sercdeltsk').val().trim() : '';
                    var searchText = searchTextFromDocName || searchTextFromSercdeltsk || '';
                    
                    // Sync both search inputs to have the same value
                    if (searchTextFromDocName && !searchTextFromSercdeltsk) {
                        $('#sercdeltsk').val(searchTextFromDocName);
                    } else if (searchTextFromSercdeltsk && !searchTextFromDocName) {
                        $('#docName').val(searchTextFromSercdeltsk);
                    }
                    
                    // Update Clear button visibility after processing filters
                    toggleClearAllButton();

                    // LOGIC: If search text is provided, search through ALL records (ignore category filters)
                    // If search text is empty, use category filters as normal
                    var docFetchParams = {
                        ProjectID: currentProjectID,
                        DocumentID: null,
                        WhatToSelect: null,
                        LoginRoleID: intPostID,
                        FilePaging: strAlphabet,
                        SearchText: searchText,
                        // If search text exists, ignore category filters to search all records
                        // If search text is empty, use category filters for normal filtering
                        CategoryID: (searchText && searchText.length > 0) ? null : (CategoryID && CategoryID !== '0' ? parseInt(CategoryID) : null),
                        SubCategoryID: (searchText && searchText.length > 0) ? null : (SubCategoryID && SubCategoryID !== '0' ? parseInt(SubCategoryID) : null)
                    };

                    var param = JSON.stringify(docFetchParams);
                    
                    // Make async AJAX call and handle response in callback
                    $.ajax({
                        url: buildUrl("/api/DocumentUpload/GetAllDocuments"),
                        type: "POST",
                        data: param,
                        async: true,
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            xhr.setRequestHeader('Accept', 'application/json');
                            if (param) {
                                xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                            }
                        },
                        success: function (apiResult) {
                            processDocumentsResponse(apiResult);
                        },
                        error: function (err) {
                            // Show "No data available in table" message on error
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
                            updatePagination();
                        }
                    });
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

                        // ✅ Group by CategoryID
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

                        // ✅ Step 1: Calculate version numbers using DocumentRefID (DB-based versioning)
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

                            // ✅ Get the Category Name from the first document in the group
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
                                </td>
</tr>`;

                            // Check if detail view is active
                            var isDetailView = window.detailViewActive || false;

                            docs.forEach(function (doc, index) {
                                var uploadedDate = formatDate(doc.UploadedDate || doc.uploadedDate);
                                var uploadedBy = doc.UploadedBy || doc.uploadedBy || '';
                                var userAvatarHTML = `
                                <div class="user-avatar">
                                    <img src="../../Images/Photo/no-photo.png" alt="User Avatar" />
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
                                } else {
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
                                    
                                    // Add detail row if detail view is active
                                    // If document is NOT reviewed: Show only Comments
                                    // If document IS reviewed: Show Comments, Reviewed By, Review Date, and Review Comments
                                    var isDetailView = window.detailViewActive || false;
                                    if (isDetailView) {
                                        // Get document comments (description) - ensure we have a fallback
                                        var documentComment = (doc.Description || doc.description || '').trim();
                                        if (!documentComment || documentComment === '') {
                                            documentComment = (ResourceStrings && ResourceStrings.C_NoCommentsAvailable) ? ResourceStrings.C_NoCommentsAvailable : 'No comments available';
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
                                        var noCommentsText = (ResourceStrings && ResourceStrings.C_NoCommentsAvailable) ? ResourceStrings.C_NoCommentsAvailable : 'No comments available';
                                        
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
                                            
                                            // Get the LATEST review data - API should return latest in the document object
                                            // If ReviewNotes is an array, take the first (latest) one
                                            // If it's a string, use it as is (should already be latest)
                                            var latestReviewNotes = '';
                                            
                                            if (Array.isArray(rawReviewNotes)) {
                                                // If it's an array, get the first element (latest)
                                                latestReviewNotes = rawReviewNotes.length > 0 ? String(rawReviewNotes[0]) : noCommentsText;
                                            } else if (typeof rawReviewNotes === 'string' && rawReviewNotes.trim() !== '') {
                                                // If it's a string, check if it contains multiple reviews separated by delimiters
                                                // Split by common delimiters and take the first part
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
                        }, 100); // Delay slightly to ensure DOM is ready

                        //$('#prodocumentstbl').DataTable({
                        //    scrollY: true,
                        //    scrollX: true,
                        //    pageLength: 15,
                        //    lengthChange: false,
                        //    bFilter: false,
                        //    ordering: false,
                        //    responsive: false,   // Prevent dynamic width change
                        //    destroy: true,
                        //    retrieve: false,
                        //    bAutoWidth: false    // Use your defined widths
                        //});

                    

                   
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
                                        $(this).attr("src", "../../Images/Photo/no-photo.png");
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

                        // MIME type validation removed - matching CRM_AddNewRequest.aspx which only validates file extensions, not MIME types
                        // FileContentType validation is not used in CRM_AddNewRequest.aspx

                        var categoryID = $row.find('.CateTypeID').val();

                        // Validate that category is selected
                        if (!categoryID || categoryID === '0' || categoryID === 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_PleaseSelectDocumentType.replace("{0}", file.name));
                            return;
                        }

                        var subcateID = $row.find('select.SubCateTypeID').val();

                        if (!subcateID || subcateID === '0') {
                            subcateID = null;
                        }

                        var changeReTypeID = $row.find('select.ChangeReTypeID').val();

                        if (!changeReTypeID || changeReTypeID === '0') {
                            changeReTypeID = null;
                        }

                        var commentValue = $row.find('input[type="text"]').val();

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
                        
                        // Make synchronous API call
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/CheckIfDirectoryStructureExists"),
                            type: "POST",
                            data: param,
                            async: false, // Synchronous for immediate result
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
                                apiResult = data;
                            },
                            error: function (err) {
                                // Try to parse the error response as JSON
                                // Note: The API may return 400 with a valid JSON response like {success: false, message: "..."}
                                // In that case, we should treat it as a valid response, not an error
                                var errorMessage = err.statusText || 'Request failed';
                                var errorData = null;
                                
                                try {
                                    if (err.responseText) {
                                        errorData = JSON.parse(err.responseText);
                                        // Check if this is a valid business logic response (has 'success' field)
                                        // If it has 'success', it's a valid API response, not a server error
                                        if (errorData.hasOwnProperty('success') || errorData.hasOwnProperty('Success')) {
                                            apiResult = errorData; // Treat as valid response
                                            return; // Exit early, don't set error flag
                                        }
                                        // Otherwise, it's a real error
                                        errorMessage = errorData.message || errorData.Message || errorData.error || errorMessage;
                                    }
                                } catch (e) {
                                    // Could not parse JSON - this is a real error
                                    errorMessage = err.responseText || errorMessage;
                                }
                                
                                // Only set error flag if this is NOT a valid business logic response
                                if (errorData && (errorData.hasOwnProperty('success') || errorData.hasOwnProperty('Success'))) {
                                    apiResult = errorData; // Valid response with success:false
                                } else {
                                    // This is a real server/network error
                                    apiResult = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });

                        var strDirectoryName = '';
                        var documentCode = '';
                        
                        // Handle API response - check for errors first
                        if (!apiResult) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_NoServerResponse.replace("{0}", file.name));
                            return;
                        }
                        
                        if (apiResult) {
                            // First, check if the API returned an error object or HTTP error
                            // BUT: A 400 response with {success: false} is a valid response structure, not an HTTP error
                            // The API can return 400 with JSON body containing {success: false, message: "..."}
                            // So we should check for actual errors (network errors, 500, etc.) vs. business logic failures
                            if (apiResult.error && !apiResult.success) {
                                // This is a network/server error, not a business logic response
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
                            
                            // Check if the API returned a failure response
                            // The API now creates directory structures automatically when they don't exist,
                            // so a failure means there's a real error (missing ProjectCode, Category, etc.)
                            var isFailure = false;
                            var errorMessage = '';
                            
                            // Check response status - API uses Status property for overall status
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
                                var detailedMsg = "Error with directory structure:\n\n";
                                detailedMsg += "Project ID: " + currentProjectID + "\n";
                                detailedMsg += "Category ID: " + categoryID + "\n";
                                if (subcateID && subcateID !== null && subcateID !== '0') {
                                    detailedMsg += "Sub Category ID: " + subcateID + "\n";
                                }
                                detailedMsg += "\nPlease contact your administrator to:\n";
                                detailedMsg += "1. Ensure Project Code is configured for Project ID: " + currentProjectID + "\n";
                                detailedMsg += "2. Ensure Document Type (Category ID: " + categoryID + ") is configured\n";
                                if (subcateID && subcateID !== null && subcateID !== '0') {
                                    detailedMsg += "3. Ensure Sub Category (Sub Category ID: " + subcateID + ") is configured\n";
                                }
                                
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_ErrorGenericWithDetails.replace("{0}", errorMessage).replace("{1}", detailedMsg).replace("{2}", file.name));
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
                        
                        // The API now creates directory structures automatically when they don't exist,
                        // so if directory name is empty, it means there was an error (missing ProjectCode, Category, etc.)
                        // This error should have been caught above, but validate again as a safety check
                        if (!strDirectoryName || (strDirectoryName && strDirectoryName.trim() === '')) {
                            // This shouldn't happen if the API is working correctly
                            // But if it does, it means the API couldn't create the directory structure
                            var detailedMsg = "Directory structure could not be created.\n\n";
                            detailedMsg += "Project ID: " + currentProjectID + "\n";
                            detailedMsg += "Category ID: " + categoryID + "\n";
                            if (subcateID && subcateID !== null && subcateID !== '0') {
                                detailedMsg += "Sub Category ID: " + subcateID + "\n";
                            }
                            detailedMsg += "\nThis might indicate:\n";
                            detailedMsg += "1. Project Code is missing for Project ID: " + currentProjectID + "\n";
                            detailedMsg += "2. Document Type (Category) Directory Name is missing for Category ID: " + categoryID + "\n";
                            if (subcateID && subcateID !== null && subcateID !== '0') {
                                detailedMsg += "3. Sub Category Directory Name is missing for Sub Category ID: " + subcateID + "\n";
                            }
                            detailedMsg += "\nPlease contact your administrator to configure the required directory information.";
                            
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_DirectoryStructure.replace("{0}", detailedMsg).replace("{1}", file.name));
                            return; // Cannot proceed without directory name
                        }

                        // Get current date in ISO 8601 format for proper JSON deserialization to DateTime
                        // Use toISOString() which returns format: YYYY-MM-DDTHH:mm:ss.sssZ
                        var today = new Date();
                        var createdDate = today.toISOString();
                        var lastModifiedDate = createdDate; // Same as created date for new uploads

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
                        
                        // Strip any existing version suffix from filename (e.g., "_v1", "_v2", etc.) as a safety measure
                        // The stored procedure will also do this, but we do it client-side to ensure clean filename
                        // Pattern: _v followed by digits at the end (e.g., "file-sample_150kB_v1" -> "file-sample_150kB")
                        // Use a more robust regex that matches _v followed by one or more digits at the end
                        var versionSuffixMatch = originalFileName.match(/^(.+?)_v(\d+)$/);
                        if (versionSuffixMatch && versionSuffixMatch.length > 1) {
                            originalFileName = versionSuffixMatch[1]; // Extract base filename without version suffix
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

                        // STEP 1: Calculate versioned filename BEFORE uploading to database
                        // LOGIC: Option 1 - Save each version as SEPARATE physical file with versioned filename
                        // We need to calculate the version number BEFORE saving the physical file
                        // This matches the logic in the stored procedure
                        var calculatedVersionNumber = 1;
                        var calculatedVersionedFileName = originalFileName;
                        
                        // Fetch existing documents to calculate version number (same logic as stored procedure)
                        // IMPORTANT: We need to match the stored procedure's filtering exactly:
                        // ProjectID, CategoryID, SubCategoryID, TagID, UniqueID, and FileName pattern
                        // Note: We fetch ALL documents for this Category/SubCategory, then filter by TagID/UniqueID/FileName client-side
                        // This ensures we don't miss any versions that might have different TagIDs (though they shouldn't version together)
                        var fetchExistingParams = {
                            ProjectID: parseInt(currentProjectID),
                            DocumentID: null,
                            WhatToSelect: null,
                            LoginRoleID: intPostID,
                            FilePaging: "-1",
                            SearchText: null,
                            CategoryID: parseInt(categoryID),
                            SubCategoryID: (subcateID && subcateID !== null && subcateID !== '0') ? parseInt(subcateID) : null
                            // Note: TagID and UniqueID are used in stored procedure but GetAllDocuments API doesn't filter by them
                            // We'll filter by TagID and UniqueID in the client-side filtering logic
                            // This is correct - we want to see all documents in this Category/SubCategory, then filter properly
                        };
                        
                        var existingDocsResult = null;
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/GetAllDocuments"),
                            type: "POST",
                            data: JSON.stringify(fetchExistingParams),
                            async: false, // Synchronous to get existing documents before calculating version
                            dataType: "json",
                            contentType: "application/json;charset=utf-8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                                xhr.setRequestHeader('Accept', 'application/json');
                                var paramStr = JSON.stringify(fetchExistingParams);
                                if (paramStr) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(paramStr) ? paramStr : JSON.stringify(paramStr)));
                                }
                            },
                            success: function (docResult) {
                                existingDocsResult = docResult;
                            },
                            error: function(err) {
                                // If fetch fails, assume it's version 1
                            }
                        });
                        
                        // Process existing documents to calculate version number
                        if (existingDocsResult) {
                            var existingDocsData = existingDocsResult.data || existingDocsResult.Data || existingDocsResult;
                            // The API returns: { message: '...', data: { ProjectDocumentModel: [...] } }
                            // OR: { data: { data: [...] } }
                            // OR: { data: [...] }
                            var existingDocsArray = null;
                            
                            if (Array.isArray(existingDocsData)) {
                                existingDocsArray = existingDocsData;
                            } else if (existingDocsData && existingDocsData.ProjectDocumentModel && Array.isArray(existingDocsData.ProjectDocumentModel)) {
                                // API returns data.ProjectDocumentModel
                                existingDocsArray = existingDocsData.ProjectDocumentModel;
                            } else if (existingDocsData && existingDocsData.data && Array.isArray(existingDocsData.data)) {
                                // Nested data.data structure
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
                                // Filter documents that match this file's pattern (same base filename or already versioned)
                                // IMPORTANT: Database stores FileName with version suffix (e.g., "file-sample_150kB_v1") and Extension separately
                                // We need to match documents that:
                                // 1. Have the same base filename (without version suffix) OR
                                // 2. Start with the base filename + "_v" pattern
                                var baseFileNameWithExt = originalFileName + '.' + extension;
                                var baseFileNamePattern = originalFileName + '_v';
                                
                                // Get TagID and UniqueID from current upload context to match stored procedure filtering
                                var currentTagID = parseInt(masterTagID);
                                var currentUniqueID = parseInt(currentProjectID);
                                
                                var matchingDocs = existingDocsArray.filter(function(doc) {
                                    // Skip URLs - only count physical files
                                    if (doc.IsURL || doc.isURL) {
                                        return false;
                                    }
                                    
                                    // Match TagID and UniqueID (same as stored procedure)
                                    var docTagID = doc.TagID || doc.tagID || doc.TagId || doc.tagId;
                                    var docUniqueID = doc.UniqueID || doc.uniqueID || doc.UniqueId || doc.uniqueId;
                                    
                                    // If TagID or UniqueID don't match, skip this document (matches stored procedure logic)
                                    if (docTagID != null && docTagID !== currentTagID) {
                                        return false;
                                    }
                                    if (docUniqueID != null && docUniqueID !== currentUniqueID) {
                                        return false;
                                    }
                                    
                                    var docFileName = (doc.FileName || doc.fileName || '').trim();
                                    var docExt = (doc.Extension || doc.extension || doc.FileExtension || doc.fileExtension || '').trim();
                                    
                                    // Build full filename from database
                                    var fullDocFileName = docExt ? docFileName + '.' + docExt : docFileName;
                                    
                                    // Check if filename matches base pattern (without version) or starts with version pattern
                                    // Match 1: Exact match with base filename + extension (e.g., "file-sample_150kB.pdf")
                                    if (fullDocFileName === baseFileNameWithExt) {
                                        return true;
                                    }
                                    
                                    // Match 2: Starts with base filename + "_v" pattern (e.g., "file-sample_150kB_v1.pdf", "file-sample_150kB_v2.pdf")
                                    if (fullDocFileName.indexOf(baseFileNamePattern) === 0) {
                                        // Verify it's actually a versioned filename (has _v followed by digits)
                                        var versionMatch = fullDocFileName.match(new RegExp('^' + baseFileNamePattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '\\d+'));
                                        if (versionMatch) {
                                            return true;
                                        }
                                    }
                                    
                                    // Match 3: Check if FileName itself (without extension) matches base or version pattern
                                    if (docFileName === originalFileName) {
                                        return true; // Base filename match
                                    }
                                    if (docFileName.indexOf(baseFileNamePattern) === 0) {
                                        var versionMatchFileName = docFileName.match(new RegExp('^' + baseFileNamePattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '\\d+$'));
                                        if (versionMatchFileName) {
                                            return true;
                                        }
                                    }
                                    
                                    return false;
                                });
                                
                                // Count matching documents to determine next version number
                                // IMPORTANT: If we have 2 matching docs (v1 and v2), next version is 3
                                // Formula: matchingDocs.length + 1
                                // BUT: If v1 is missing from results but we know it exists (from previous uploads),
                                // we need to account for it. Check if we're missing v1 by looking at the version numbers.
                                var maxVersionNumber = 0;
                                matchingDocs.forEach(function(doc) {
                                    var fn = (doc.FileName || doc.fileName || '').trim();
                                    var ext = (doc.Extension || doc.extension || doc.FileExtension || doc.fileExtension || '').trim();
                                    var fullFn = ext ? fn + '.' + ext : fn;
                                    // Extract version number from filename (e.g., "file-example_PDF_1MB_v2.pdf" -> 2)
                                    var versionMatch = fullFn.match(/_v(\d+)\./);
                                    if (versionMatch && versionMatch[1]) {
                                        var versionNum = parseInt(versionMatch[1]);
                                        if (versionNum > maxVersionNumber) {
                                            maxVersionNumber = versionNum;
                                        }
                                    }
                                });
                                
                                // If we found versions but the max version number is greater than the count,
                                // it means we're missing some versions (e.g., found v2 but not v1, so maxVersion=2 but count=1)
                                // In this case, use maxVersionNumber + 1 instead of matchingDocs.length + 1
                                if (matchingDocs.length > 0) {
                                    if (maxVersionNumber > matchingDocs.length) {
                                        // We're missing some versions - use max version number + 1
                                        calculatedVersionNumber = maxVersionNumber + 1;
                                    } else {
                                        // Normal case: count matches versions found
                                        calculatedVersionNumber = matchingDocs.length + 1;
                                    }
                                }
                            }
                        }
                        
                        // Build versioned filename (e.g., file-sample_150kB_v2.pdf)
                        calculatedVersionedFileName = originalFileName + '_v' + calculatedVersionNumber + '.' + extension;
                        // STEP 2: Call UploadDocument API (stored procedure will handle versioning and should match our calculation)
                        // The stored procedure will automatically add version suffix (_v1, _v2, etc.) to the filename
                        var docUplParams = {
                            ProjectID: parseInt(currentProjectID), // Ensure integer
                            CategoryID: parseInt(categoryID), // Ensure integer (convert from string)
                            DirectoryName: (strDirectoryName && strDirectoryName.trim() !== '') ? strDirectoryName : null, // Send null instead of empty string
                            UploadedFileName: originalFileName,
                            CreatedDate: createdDate, // ISO 8601 date string (YYYY-MM-DDTHH:mm:ss.sssZ) - API will parse to DateTime
                            LastModifiedDate: lastModifiedDate, // ISO 8601 date string (YYYY-MM-DDTHH:mm:ss.sssZ) - API will parse to DateTime
                            Description: commentValue || '', // Send empty string if not provided (matching old UI behavior: strDescription.Trim)
                            fileSize: parseFloat(fileSizeKB), // Ensure it's a number (decimal)
                            Extension: extension,
                            FileName: originalFileName, // using unmodified original name (stored procedure needs this to determine version)
                            LogInID: parseInt(intUserID), // Ensure integer
                            LoginType: loginType,
                            ChangeRID: (changeReTypeID && changeReTypeID !== null && changeReTypeID !== '0') ? parseInt(changeReTypeID) : null, // Convert to int or null
                            SubCategoryID: (subcateID && subcateID !== null && subcateID !== '0') ? parseInt(subcateID) : null, // Convert to int or null (was string)
                            TagID: parseInt(masterTagID), // Ensure integer
                            UniqueID: parseInt(currentProjectID), // Ensure integer
                            CodeTemplate: documentCode || null // Send null if empty
                        };

                        var uploadParam = JSON.stringify(docUplParams);
                        var uploadApiResult = null;
                        
                        // Make synchronous API call
                        $.ajax({
                            url: buildUrl("/api/DocumentUpload/UploadDocument"),
                            type: "POST",
                            data: uploadParam,
                            async: false, // Synchronous for immediate result
                            dataType: "json",
                            contentType: "application/json;charset=utf-8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                                xhr.setRequestHeader('Accept', 'application/json');
                                if (uploadParam) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(uploadParam) ? uploadParam : JSON.stringify(uploadParam)));
                                }
                            },
                            success: function (data) {
                                uploadApiResult = data;
                            },
                            error: function (err) {
                                // Try to parse the error response as JSON
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
                                    uploadApiResult = errorData;
                                } else {
                                    uploadApiResult = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                }
                            }
                        });

                        // STEP 2: Check if UploadDocument API call was successful and get DocumentID
                        var newDocumentID = null;
                        
                        if (uploadApiResult) {
                            if (uploadApiResult.status === 'FAILURE' || uploadApiResult.Status === 'FAILURE') {
                                var errorMsg = (uploadApiResult.data && uploadApiResult.data.Message) || (uploadApiResult.data && uploadApiResult.data.message) || uploadApiResult.message || "Error uploading document.";
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(ResourceStrings.A_UploadFailed.replace("{0}", file.name).replace("{1}", errorMsg));
                                return;
                            }
                            
                            // Extract DocumentID from API response
                            // Response structure: { status: "SUCCESS", data: { message: "...", UploadDocumentResponseModel: [{ intID: 469 }] } }
                            // OR: { status: "SUCCESS", data: { data: [UploadDocumentResponseModel] } }
                            // OR: { Status: "SUCCESS", Data: { ... } }
                            var responseData = uploadApiResult.data || uploadApiResult.Data || uploadApiResult;
                            var uploadData = null;
                            
                            // Try multiple response structures
                            // First check for UploadDocumentResponseModel array (most common structure)
                            if (responseData && responseData.UploadDocumentResponseModel && Array.isArray(responseData.UploadDocumentResponseModel)) {
                                uploadData = responseData.UploadDocumentResponseModel;
                            } else if (responseData && responseData.data && Array.isArray(responseData.data)) {
                                // Nested structure: { data: { data: [...] } }
                                uploadData = responseData.data;
                            } else if (Array.isArray(responseData)) {
                                // Direct array: { data: [...] }
                                uploadData = responseData;
                            } else if (responseData && typeof responseData === 'object') {
                                // Single object or nested object - try to extract array from it
                                // Check if it has any property that is an array
                                for (var key in responseData) {
                                    if (responseData.hasOwnProperty(key) && Array.isArray(responseData[key])) {
                                        uploadData = responseData[key];
                                        break;
                                    }
                                }
                                // If no array found, use the object itself
                                if (!uploadData) {
                                    uploadData = responseData;
                                }
                            }
                            
                            // Extract DocumentID from uploadData
                            if (Array.isArray(uploadData) && uploadData.length > 0) {
                                // Array of results - get first item
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

                        // STEP 3: Save the file physically to server with CALCULATED VERSIONED filename (each version is separate)
                        // Use the versioned filename we calculated earlier (e.g., file-sample_150kB_v2.pdf)
                        var formData = new FormData();
                        formData.append("file", file);
                        formData.append("DirectoryName", strDirectoryName); // Ensure this is always set
                        formData.append("FileName", calculatedVersionedFileName); // Use calculated versioned filename (e.g., file-sample_150kB_v2.pdf)

                        // Initialize upload status on first file
                        if (index === 0) {
                            uploadStatus = { total: selectedFiles.length, success: 0, failed: 0, errors: [] };
                        }

                        // Pass document ID and calculated versioned filename to save physical file
                        uploadFileWithFormData("/api/DocumentUpload/SaveFileToServer", formData, index, selectedFiles.length, file.name, newDocumentID, calculatedVersionedFileName);

                    });
                }
                // End of addition by Nischal C on 3/11/2025 Upload document with validation

                // Added by Nischal C on 3/11/2025 - Attach URL to document
                function Attach_OnClick() {
                    // Check add access permission
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

                    var uploadParam = JSON.stringify(attachUrl);
                    var apiResult = null;
                    
                    $.ajax({
                        url: buildUrl("/api/DocumentUpload/AttachUrl"),
                        type: "POST",
                        data: uploadParam,
                        async: false,
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            xhr.setRequestHeader('Accept', 'application/json');
                            if (uploadParam) {
                                xhr.setRequestHeader("Params", encryptString(isJson(uploadParam) ? uploadParam : JSON.stringify(uploadParam)));
                            }
                        },
                        success: function (data) {
                            apiResult = data;
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
                                apiResult = errorData;
                            } else {
                                apiResult = { error: true, success: false, message: errorMessage, statusCode: err.status };
                            }
                        }
                    });
                    
                    var result = [];
                    if (apiResult && apiResult.data && Array.isArray(apiResult.data)) {
                        result = apiResult.data;
                    } else if (apiResult && Array.isArray(apiResult)) {
                        result = apiResult;
                    } else if (apiResult && apiResult.data) {
                        result = [apiResult.data];
                    }
                    
                    // Check if save was successful before clearing
                    // Since we're in the success callback, assume success unless there's an explicit error
                    var isSuccess = true; // Default to success if we reached the success callback
                    
                    // Only mark as failure if there's an explicit error flag
                    if (apiResult && (apiResult.error === true || apiResult.error === 'true')) {
                        isSuccess = false;
                    }
                    // Also check if status indicates failure
                    else if (apiResult && apiResult.status && 
                            (apiResult.status === "FAILURE" || apiResult.status === "failure" || apiResult.status === "ERROR")) {
                        isSuccess = false;
                    }
                    
                    if (isSuccess) {
                        // Clear all fields after successful attachment
                        $('#txtURL').val('');
                        $('#cboAttachCate').selectpicker('val', '0');
                        $('#cboAttachSubCate').empty().append('<option value="0">Select sub category</option>');
                        $('#cboAttachSubCate').selectpicker('refresh');
                        $('#cboAttachSubCate').selectpicker('val', '0');
                        $('#txtDescription').val('');
                        
                    $('#cnl_Attach').trigger('click'); // Close modal or cancel

                    alertify.set('notifier', 'position', 'top-right');
                        alertify.success(ResourceStrings.A_URLAttachedSuccess);
                        // Switch to URLs tab and refresh to show new URL at top
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
                    $(".doc-chck:checked").each(function () {
                        selectedIDs.push($(this).data("documentid"));
                        selProjIDs.push($(this).data("projectid"));
                    });

                    ProjectID: $(this).data("projectid")

                    if (selectedIDs.length === 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(ResourceStrings.A_PleaseSelectDocument);
                        return;
                    }
                    
                    // Show confirmation modal (similar to PM_SCM.aspx)
                    $("#ConfirmationMsg").html(ResourceStrings.A_ConfirmDeleteDocuments);
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
                    // Step 2: Choose what to delete: "A" or "I"
                    // "A" = Delete ALL versions of the document (following PM_ProjectDocuments.aspx.vb pattern)
                    // "I" = Delete only the individual/selected document
                    var strWhatToDelete = "A"; // Always use "A" to delete all versions like the old page

                    var docUplParams = {
                                ProjectID: currentProjectID,
                        DocumentID: selectedIDs.join(','), 
                                WhatToDelete: strWhatToDelete
                    };

                    var uploadParam = JSON.stringify(docUplParams);
                            var apiResult = null;
                            
                            $.ajax({
                                url: buildUrl("/api/DocumentUpload/DeleteSelectedDocuments"),
                                type: "POST",
                                data: uploadParam,
                                async: false,
                                dataType: "json",
                                contentType: "application/json;charset=utf-8",
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                                    xhr.setRequestHeader('Accept', 'application/json');
                                    if (uploadParam) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(uploadParam) ? uploadParam : JSON.stringify(uploadParam)));
                                    }
                                },
                                success: function (data) {
                                    apiResult = data;
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
                                        apiResult = errorData;
                                    } else {
                                        apiResult = { error: true, success: false, message: errorMessage, statusCode: err.status };
                                    }
                                }
                            });

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

                            var msg = result.Message || result.message || 'Documents deleted successfully';

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

                    // ✅ Step 1: First get the document to find DocumentRefID (if any)
                    // This matches old UI behavior - we need to check if there are versions
                    var firstDocParams = {
                        ProjectID: currentProjectID,
                        DocumentID: docID
                    };

                    var firstDocParam = JSON.stringify(firstDocParams);
                    var firstDocResult = null;
                    
                    $.ajax({
                        url: buildUrl("/api/DocumentUpload/ShowHistory"),
                        type: "POST",
                        data: firstDocParam,
                        async: false,
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            xhr.setRequestHeader('Accept', 'application/json');
                            if (firstDocParam) {
                                xhr.setRequestHeader("Params", encryptString(isJson(firstDocParam) ? firstDocParam : JSON.stringify(firstDocParam)));
                            }
                        },
                        success: function (data) {
                            firstDocResult = data;
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
                                firstDocResult = errorData;
                            } else {
                                firstDocResult = { error: true, success: false, message: errorMessage, statusCode: err.status };
                            }
                        }
                    });

                    // ✅ Step 2: Parse first result to get DocumentRefID (original DocumentID)
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
                            
                            
                            // DocumentRefID points to the original DocumentID
                            // If DocumentRefID exists, that's the original DocumentID we need to query
                            // If DocumentRefID is null, this DocumentID itself is the original
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

                    // ✅ Step 3: Use documents already loaded on the page instead of calling GetAllDocuments again
                    // This is more efficient and avoids permission/parameter issues
                    // Get all documents from the DOM instead of making another API call
                    var allDocuments = [];
                    var tbody = document.querySelector('#tbodyReqSpe');
                    
                    if (tbody && tbody.children.length > 0) {
                        // Extract document data from DOM rows
                        $(tbody).find('tr[data-document-id]').each(function() {
                            var row = $(this);
                            var docID = row.attr('data-document-id');
                            if (docID) {
                                // Get document data from data attributes or row content
                                // We'll need to fetch from the already loaded data or make a simpler call
                                // For now, let's still use GetAllDocuments but with correct params
                            }
                        });
                    }
                    
                    // ✅ Step 3a: Fetch ALL documents for this project WITHOUT category/subcategory filters
                    // This is critical: We need ALL documents to find all versions, regardless of category
                    // If we filter by CategoryID/SubCategoryID, we might miss the original document or other versions
                    // Use the CategoryID and SubCategoryID from the first document we retrieved
                    var firstDocCategoryID = null;
                    var firstDocSubCategoryID = null;
                    if (firstDocArray.length > 0) {
                        var firstDoc = firstDocArray[0];
                        firstDocCategoryID = firstDoc.CategoryID || firstDoc.categoryID || firstDoc.CategoryId || firstDoc.categoryId;
                        firstDocSubCategoryID = firstDoc.SubCategoryID || firstDoc.subCategoryID || firstDoc.SubCategoryId || firstDoc.subCategoryId;
                    }
                    
                    // For versioning, we need to get all documents with the SAME category/subcategory
                    // as the document we're viewing, because the API might filter by category
                    // Even with CategoryID: null, the API might not return all documents due to permissions
                    // So we'll use the CategoryID/SubCategoryID from the first document
                    var getAllDocsParams = {
                        ProjectID: currentProjectID,
                        DocumentID: null,  // Get all documents
                        WhatToSelect: null,
                        LoginRoleID: typeof intPostID !== 'undefined' ? intPostID : null,
                        FilePaging: "-1",  // Match fetchAllDocuments format exactly
                        SearchText: null,
                        CategoryID: firstDocCategoryID || null,  // ✅ Use first doc's CategoryID to get all in same category
                        SubCategoryID: firstDocSubCategoryID || null  // ✅ Use first doc's SubCategoryID to get all in same subcategory
                    };
                    

                    var getAllDocsParam = JSON.stringify(getAllDocsParams);
                    var apiResult = null;
                    
                    $.ajax({
                        url: buildUrl("/api/DocumentUpload/GetAllDocuments"),
                        type: "POST",
                        data: getAllDocsParam,
                        async: false,
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            xhr.setRequestHeader('Accept', 'application/json');
                            if (getAllDocsParam) {
                                xhr.setRequestHeader("Params", encryptString(isJson(getAllDocsParam) ? getAllDocsParam : JSON.stringify(getAllDocsParam)));
                            }
                        },
                        success: function (data) {
                            apiResult = data;
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
                                apiResult = errorData;
                            } else {
                                apiResult = { error: true, success: false, message: errorMessage, statusCode: err.status };
                            }
                        }
                    });
                    

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
                            
                            // Handle successful response
                            // API returns: { Status: 'SUCCESS', Data: { data: [array of ProjectDocumentModel] } }
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
                        
                        
                        // ✅ Step 4: Filter documents to get all versions
                        // All versions have the same DocumentRefID (which equals originalDocumentID)
                        // OR they have DocumentID = originalDocumentID with DocumentRefID = NULL (the original)
                        var result = [];
                        
                        if (!originalDocumentID) {
                            result = firstDocArray;
                        } else if (allDocuments.length === 0) {
                            result = firstDocArray;
                        } else {
                            // Filter all documents to find versions
                            var originalDocIDInt = parseInt(originalDocumentID);
                            
                            // Filter out URLs - we only want file documents, not URLs
                            var fileDocumentsOnly = allDocuments.filter(function(doc) {
                                var isURL = doc.IsURL || doc.isURL;
                                return !isURL;  // Only include non-URL documents
                            });
                            
                            result = fileDocumentsOnly.filter(function(doc) {
                                var docRefID = doc.DocumentRefID || doc.documentRefID;
                                var docIDValue = doc.DocumentID || doc.documentID;
                                var docRefIDInt = docRefID ? parseInt(docRefID) : null;
                                var docIDValueInt = docIDValue ? parseInt(docIDValue) : null;
                                
                                // Match if:
                                // 1. DocumentRefID equals originalDocumentID (all versions point to original)
                                // 2. DocumentID equals originalDocumentID AND (DocumentRefID is null OR DocumentRefID is undefined) (the original itself)
                                var matches = (docRefIDInt !== null && docRefIDInt === originalDocIDInt) || 
                                             (docIDValueInt === originalDocIDInt && (docRefID === null || docRefID === undefined || docRefID === ''));
                                
                                if (matches) {
                                }
                                return matches;
                            });
                            
                            
                            if (originalDocIDInt) {
                                // Build a list of all expected DocumentIDs:
                                // 1. The original document (424) - DocumentID = 424 AND DocumentRefID = NULL
                                // 2. All versions that point to the original - DocumentRefID = 424
                                var expectedDocIDs = [originalDocIDInt]; // Start with original (424)
                                
                                // Find all documents with DocumentRefID = originalDocIDInt (these are versions)
                                fileDocumentsOnly.forEach(function(doc) {
                                    var docRefID = doc.DocumentRefID || doc.documentRefID;
                                    if (docRefID && parseInt(docRefID) === originalDocIDInt) {
                                        var docIDValue = doc.DocumentID || doc.documentID;
                                        if (docIDValue && !expectedDocIDs.includes(parseInt(docIDValue))) {
                                            expectedDocIDs.push(parseInt(docIDValue));
                                        }
                                    }
                                });
                                
                                // Also check result array (documents already found)
                                result.forEach(function(doc) {
                                    var docIDValue = doc.DocumentID || doc.documentID;
                                    if (docIDValue && !expectedDocIDs.includes(parseInt(docIDValue))) {
                                        expectedDocIDs.push(parseInt(docIDValue));
                                    }
                                });
                                
                                // Since we know from the database that DocumentID 427 has DocumentRefID = 424,
                                // there should be other documents (425, 426) with DocumentRefID = 424 too
                                // We need to check a range of DocumentIDs around the ones we found
                                // Strategy: If we found 427 with DocumentRefID = 424, check all IDs between 424 and 427
                                var foundDocIDs = [];
                                fileDocumentsOnly.forEach(function(doc) {
                                    var docRefID = doc.DocumentRefID || doc.documentRefID;
                                    var docIDValue = doc.DocumentID || doc.documentID;
                                    if (docIDValue) {
                                        foundDocIDs.push(parseInt(docIDValue));
                                        // If this doc has DocumentRefID = 424, we know 424 is the original
                                        if (docRefID && parseInt(docRefID) === originalDocIDInt) {
                                            // This means we should check all IDs between originalDocIDInt and this docID
                                            var maxDocID = parseInt(docIDValue);
                                            var minDocID = originalDocIDInt;
                                            // Add all IDs in this range to expected list (in case there are missing versions)
                                            for (var checkID = minDocID; checkID <= maxDocID; checkID++) {
                                                if (!expectedDocIDs.includes(checkID)) {
                                                    // Only add if it's not already in expectedDocIDs
                                                    // We'll verify they exist when we fetch them
                                                    expectedDocIDs.push(checkID);
                                                }
                                            }
                                        }
                                    }
                                });
                                
                                // Sort expectedDocIDs
                                expectedDocIDs.sort(function(a, b) { return a - b; });
                                
                                // Check which expected documents are missing
                                var missingDocIDs = [];
                                expectedDocIDs.forEach(function(expectedID) {
                                    var found = fileDocumentsOnly.find(function(doc) {
                                        var docIDValue = doc.DocumentID || doc.documentID;
                                        return parseInt(docIDValue) === expectedID;
                                    });
                                    if (!found) {
                                        missingDocIDs.push(expectedID);
                                    }
                                });
                                
                                if (missingDocIDs.length > 0) {
                                    
                                    // Fetch missing documents individually using ShowHistory API
                                    missingDocIDs.forEach(function(missingID) {
                                        var missingDocResponse = null;
                                        $.ajax({
                                            url: buildUrl("/api/DocumentUpload/ShowHistory"),
                                            type: "POST",
                                            data: JSON.stringify({
                                                ProjectID: currentProjectID,
                                                DocumentID: missingID
                                            }),
                                            async: false,
                                            dataType: "json",
                                            contentType: "application/json;charset=utf-8",
                                            beforeSend: function (xhr) {
                                                xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                                                xhr.setRequestHeader('Accept', 'application/json');
                                                xhr.setRequestHeader("Params", encryptString(JSON.stringify({
                                                    ProjectID: currentProjectID,
                                                    DocumentID: missingID
                                                })));
                                            },
                                            success: function (data) {
                                                missingDocResponse = data;
                                            },
                                            error: function (err) {
                                                missingDocResponse = null;
                                            }
                                        });
                                        
                                        if (missingDocResponse) {
                                            // Parse the response similar to firstDocResult
                                            var missingDocArray = [];
                                            try {
                                                if (missingDocResponse && Array.isArray(missingDocResponse)) {
                                                    missingDocArray = missingDocResponse;
                                                } else if (missingDocResponse && missingDocResponse.data) {
                                                    if (Array.isArray(missingDocResponse.data)) {
                                                        missingDocArray = missingDocResponse.data;
                                                    } else if (missingDocResponse.data.data && Array.isArray(missingDocResponse.data.data)) {
                                                        missingDocArray = missingDocResponse.data.data;
                                                    }
                                                }
                                                
                                                if (missingDocArray.length > 0) {
                                                    
                                                    // Process ALL items in the response, not just the first one
                                                    // The API might return all versions when querying with a DocumentRefID
                                                    missingDocArray.forEach(function(missingDoc, index) {
                                                        var isURL = missingDoc.IsURL || missingDoc.isURL;
                                                        if (!isURL) {
                                                            // Check if it matches our version criteria
                                                            var docRefID = missingDoc.DocumentRefID || missingDoc.documentRefID;
                                                            var docIDValue = missingDoc.DocumentID || missingDoc.documentID;
                                                            var docRefIDInt = docRefID ? parseInt(docRefID) : null;
                                                            var docIDValueInt = docIDValue ? parseInt(docIDValue) : null;
                                                            
                                                            
                                                            var shouldInclude = (docRefIDInt !== null && docRefIDInt === originalDocIDInt) || 
                                                                               (docIDValueInt === originalDocIDInt && (!docRefID || docRefID === ''));
                                                            
                                                            if (shouldInclude) {
                                                                // Check if already in result (using DocumentID, not missingID)
                                                                var alreadyInResult = result.some(function(doc) {
                                                                    var dID = doc.DocumentID || doc.documentID;
                                                                    return dID && parseInt(dID) === docIDValueInt;
                                                                });
                                                                
                                                                if (!alreadyInResult) {
                                                                    result.push(missingDoc);
                                                                } else {
                                                                }
                                                            } else {
                                                            }
                                                        } else {
                                                        }
                                                    });
                                                }
                                            } catch (e) {
                                                // Error parsing missing document
                                            }
                                        }
                                    });
                                }
                                
                                // Final check for original document
                                var originalDocExists = fileDocumentsOnly.some(function(doc) {
                                    var docIDValue = doc.DocumentID || doc.documentID;
                                    return parseInt(docIDValue) === originalDocIDInt;
                                });
                                
                                if (!originalDocExists && result.length > 0) {
                                } else if (originalDocExists) {
                                    var originalDoc = fileDocumentsOnly.find(function(doc) {
                                        var docIDValue = doc.DocumentID || doc.documentID;
                                        return parseInt(docIDValue) === originalDocIDInt;
                                    });
                                    var originalDocInResult = result.some(function(doc) {
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
                                    var firstDocInResult = result.some(function(doc) {
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

                        // Calculate version numbers using DocumentRefID (DB-based versioning)
                        // Sort by UploadedDate ascending (oldest first) to assign version numbers
                        allDocs.sort(function(a, b) {
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

                        // ✅ IMPORTANT: Check if we got all versions
                        // The stored procedure should return all versions, but if it only returns 1,
                        // we need to check if DocumentRefID exists and manually fetch all versions
                        
                        if (allDocs.length === 1) {
                            var singleDoc = allDocs[0];
                            var docRefID = singleDoc.DocumentRefID || singleDoc.documentRefID;
                            var docIDValue = singleDoc.DocumentID || singleDoc.documentID;
                            
                            // If DocumentRefID exists and we only got 1 document, the stored procedure might not be returning all versions
                            // We might need to query GetAllDocuments with filters to get all versions
                            // But let's first check if the stored procedure is supposed to return all versions
                            if (docRefID && docRefID !== docIDValue) {
                            }
                        }

                        // Sort documents by UploadedDate (oldest first) BEFORE assigning version numbers
                        // This ensures version 1.0 is the oldest, version 2.0 is the next oldest, etc.
                        allDocs.sort(function(a, b) {
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
                        
                        // Assign version numbers (1.0, 2.0, 3.0, etc.) - oldest gets 1.0, newest gets highest version
                        // Use Original flag from DB to identify latest version (as per stored procedure)
                        allDocs.forEach(function(d, index) {
                            var isOriginal = d.Original !== undefined ? d.Original : (d.original !== undefined ? d.original : false);
                            d._versionNumber = (index + 1) + '.0';
                            // Latest version is the one with Original = true (as per stored procedure logic)
                            // If Original flag is not reliable, use last in sorted order as fallback
                            d._isLatestVersion = isOriginal || (index === allDocs.length - 1);
                        });

                        // Build review comments list from all documents in history
                        var reviewCommentsList = [];
                        allDocs.forEach(function(d) {
                            // Check multiple possible field names for reviewed by and date
                            var reviewedBy = d.ReviewedBy || d.reviewedBy || d.ReviewBy || d.reviewBy || '';
                            var reviewedDateRaw = d.ReviewedDate || d.reviewedDate || d.ReviewDate || d.reviewDate || '';
                            // Preserve the original date format if it includes time
                            var reviewedDate = reviewedDateRaw;
                            var reviewComment = (d.ReviewNotes || d.reviewNotes || d.ReviewComments || d.reviewComments || '').replace(/\r/g, '').replace(/<BR>/gi, '<br>');
                            
                            // Check if reviewComment contains multiple reviews concatenated (look for pattern like "<b>Reviewed By:")
                            if (reviewComment && (reviewComment.indexOf('<b>Reviewed By:') >= 0 || reviewComment.indexOf('<strong>Reviewed By:') >= 0 || 
                                reviewComment.indexOf('Reviewed By:') >= 0)) {
                                // Parse the concatenated reviews - handle format like:
                                // "fgyu<br><b>Reviewed By: </b>Admin<br><b>Reviewed Date: </b> Oct 31 2025  2:10PM<br><b>Review Comments: </b>f3q<br>..."
                                
                                // First, extract the first standalone comment (before any "Reviewed By:")
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
                                
                                // Now extract all the reviews with pattern: <b>Reviewed By: </b>Admin<br><b>Reviewed Date: </b> ...
                                // Pattern: <b>Reviewed By: </b>Admin<br><b>Reviewed Date: </b> Oct 31 2025  2:10PM<br><b>Review Comments: </b>f3q<br>
                                var reviewRegex = /<b>Reviewed By:\s*<\/b>([^<]+?)<br\s*\/?>\s*<b>Reviewed Date:\s*<\/b>\s*([^<]+?)<br\s*\/?>\s*<b>Review Comments:\s*<\/b>([^<]+?)(?:<br\s*\/?>|$)/gi;
                                
                                var match;
                                while ((match = reviewRegex.exec(reviewComment)) !== null) {
                                    var currentReviewedBy = match[1] ? match[1].trim() : reviewedBy;
                                    var currentReviewedDate = match[2] ? match[2].trim() : '';
                                    var currentComment = match[3] ? match[3].trim() : '';
                                    
                                    // Clean up the comment
                                    currentComment = currentComment.replace(/<br\s*\/?>\s*$/i, '').trim();
                                    
                                    // Format the date - convert to "Oct 31 2025 2:40PM" format
                                    // If currentReviewedDate is extracted from HTML, use it; otherwise use reviewedDate
                                    var rawDateForDisplay = currentReviewedDate || reviewedDate || '';
                                    
                                    var formattedDate = 'N/A';
                                    if (rawDateForDisplay) {
                                        // Format to "Oct 31 2025 2:40PM" format
                                        formattedDate = formatDateWithTime(rawDateForDisplay);
                                    }
                                    
                                    if (currentComment && currentReviewedBy) {
                                        // Store the raw date for sorting - prefer the extracted date from HTML, fallback to reviewedDate
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
                                        Comment: reviewComment || 'No comments'
                                    });
                                }
                            }
                        });
                        
                        // Sort by date (newest first) - proper date sorting
                        reviewCommentsList.sort(function(a, b) {
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
                            
                            // If both dates can be parsed, compare them (newest first = descending)
                            // Return positive if B is newer (B should come first), negative if A is newer (A should come first)
                            if (parsedA && parsedB) {
                                // parsedB.getTime() - parsedA.getTime() means:
                                // If B > A (B is newer), return positive -> B comes before A (correct for newest first)
                                return parsedB.getTime() - parsedA.getTime(); // Newest first (descending)
                            }
                            
                            // If only one has a valid date, prioritize it
                            if (parsedA && !parsedB) return -1; // a comes first (has valid date)
                            if (!parsedA && parsedB) return 1;  // b comes first (has valid date)
                            
                            // Fallback: If both are strings, try reverse string comparison
                            // But be careful - this might not work correctly for date strings
                            // If dates are in ISO format, they should parse correctly above
                            // This fallback is for unusual formats
                            if (dateA && dateB) {
                                // For ISO dates, string comparison should work (2025 > 2024)
                                // But for "Oct 31 2025" format, this might not work correctly
                                return dateB.localeCompare(dateA);
                            }
                            
                            // If one has a date string and the other doesn't
                            if (dateA && !dateB) return -1;
                            if (!dateA && dateB) return 1;
                            
                            // If neither has a date, maintain order
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
                            reviewCommentsList.forEach(function(c, index) {
                                // Add margin-top for first review to separate from "Uploaded By"
                                // Add border-bottom AFTER each review entry to separate it from the next one
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
                            // Multiple versions - show each version with download link
                            // Sort by version number (newest first for display)
                            var sortedVersions = allDocs.slice().sort(function(a, b) {
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
                            
                            sortedVersions.forEach(function(versionDoc, idx) {
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
                                
                                // Format Last Modified with time using formatDateWithTime function
                                // Use UploadedDate as it represents the actual upload time (when the version was created)
                                // The UpdatedDate field might be incorrect (shows wrong time) so we use UploadedDate
                                var versionUploadedDateRaw = versionDoc.UploadedDate || versionDoc.uploadedDate || '';
                                var versionUpdatedDateRaw = versionDoc.UpdatedDate || versionDoc.updatedDate || versionDoc.LastModified || versionDoc.lastModified || '';
                                
                                // Use UploadedDate for "Last Modified" display (it's the actual upload time for each version)
                                // This represents when this specific version was uploaded/created
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
                            
                            // If DocumentRefID is null, this is likely the only version
                            // If DocumentRefID exists, there might be other versions, but API only returned this one
                            var versionNote = docRefID ? 
                                ' <span style="color:#f59e0b; font-size:11px;">(Note: Other versions may exist but were not returned by API)</span>' :
                                ' (Only Version)';
                            
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
                            latestVersion = allDocs.find(function(d) {
                                var isOriginal = d.Original !== undefined ? d.Original : (d.original !== undefined ? d.original : false);
                                return isOriginal || d._isLatestVersion;
                            });
                            // If no latest found by flag, use the one with highest version number
                            if (!latestVersion) {
                                latestVersion = allDocs.reduce(function(prev, curr) {
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

              
                function showReview(flag){

                    reviewDocID = flag;
                    
                }

                // Added by Nischal C on 3/11/2025 - Update review comments
                function UpdshowReview() {
                    var commentID = $('#commentID').val();
                    var reviewparams = {
                        DocumentID: reviewDocID,
                        LogInID: intUserID,
                        Comment: commentID,
                        LoginType: loginType
                    };

                    var uploadParam = JSON.stringify(reviewparams);
                    var apiResult = null;
                    
                    $.ajax({
                        url: buildUrl("/api/DocumentUpload/UpdateDocumentReview"),
                        type: "POST",
                        data: uploadParam,
                        async: false,
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            xhr.setRequestHeader('Accept', 'application/json');
                            if (uploadParam) {
                                xhr.setRequestHeader("Params", encryptString(isJson(uploadParam) ? uploadParam : JSON.stringify(uploadParam)));
                            }
                        },
                        success: function (data) {
                            apiResult = data;
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
                                apiResult = errorData;
                            } else {
                                apiResult = { error: true, success: false, message: errorMessage, statusCode: err.status };
                            }
                        }
                    });

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
                function downloadDocument(docID, ProjID, fileName, extension) {

                    var strWhatToDelete = "I";

                    // Ensure ProjectID and DocumentID are integers (API expects int?)
                    var docUplParams = {
                        ProjectID: parseInt(ProjID) || null,
                        DocumentID: parseInt(docID) || null,
                        WhatToDelete: strWhatToDelete
                    };

                    // Build filename with extension if available
                    var fullFileName = fileName || 'downloaded_file';
                    if (extension && extension.trim() !== '') {
                        // Only add extension if it doesn't already have one
                        var fileExt = extension.trim().toLowerCase();
                        var hasExtension = fullFileName.toLowerCase().endsWith('.' + fileExt);
                        if (!hasExtension) {
                            fullFileName = fullFileName + '.' + fileExt;
                        }
                    }

                    // Use this to directly trigger download
                    downloadFileWithParams("/api/DocumentUpload/DownloadDocument", docUplParams, fullFileName);
                }
                // End of addition by Nischal C on 3/11/2025 Download document

                // Added by Nischal C on 3/11/2025 - Download file with parameters
                function downloadFileWithParams(url, param, defaultFileName) {
                    $.ajax({
                        url: buildUrl(url),
                        type: "POST",
                        data: JSON.stringify(param),
                        xhrFields: { responseType: 'blob' },
                        contentType: "application/json; charset=utf-8",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                            if (param) {
                                xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                            }
                        },
                        success: function (blob, status, xhr) {
                            // Check if the response is actually an error (JSON error response)
                            if (xhr.getResponseHeader('content-type') && xhr.getResponseHeader('content-type').indexOf('application/json') !== -1) {
                                // Response is JSON (error), not a blob
                                var reader = new FileReader();
                                reader.onloadend = function() {
                                    try {
                                        var errorData = JSON.parse(reader.result);
                                        var errorMsg = errorData.message || errorData.Message || 'Download failed';
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.error(ResourceStrings.A_DownloadFailed.replace("{0}", errorMsg));
                                    } catch (e) {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.error(ResourceStrings.A_DownloadFailedParseError);
                                    }
                                };
                                reader.readAsText(blob);
                                return;
                            }
                            var disposition = xhr.getResponseHeader('Content-Disposition');
                            var filename = defaultFileName || 'downloaded_file';

                            // Try to extract filename from Content-Disposition header
                            if (disposition && disposition.indexOf('filename=') !== -1) {
                                // Handle both quoted and unquoted filenames
                                var filenameMatch = disposition.match(/filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/);
                                if (filenameMatch && filenameMatch[1]) {
                                    var extractedName = filenameMatch[1].replace(/['"]/g, '').trim();
                                    // Decode URL-encoded filename if needed
                                    try {
                                        extractedName = decodeURIComponent(extractedName);
                                    } catch (e) {
                                        // If decode fails, use as-is
                                    }
                                    if (extractedName) {
                                        filename = extractedName;
                                    }
                                }
                            }
                            
                            // Ensure filename has proper extension
                            // If the filename doesn't have an extension but defaultFileName does, use it
                            if (!filename.includes('.') && defaultFileName && defaultFileName.includes('.')) {
                                filename = defaultFileName;
                            }
                            
                            // Determine MIME type based on file extension for better browser handling
                            var mimeType = 'application/octet-stream';
                            var fileExtension = filename.split('.').pop().toLowerCase();
                            var mimeTypes = {
                                'pdf': 'application/pdf',
                                'doc': 'application/msword',
                                'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                                'xls': 'application/vnd.ms-excel',
                                'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                'txt': 'text/plain',
                                'xml': 'application/xml',
                                'png': 'image/png',
                                'jpg': 'image/jpeg',
                                'jpeg': 'image/jpeg',
                                'gif': 'image/gif',
                                'zip': 'application/zip',
                                'rar': 'application/x-rar-compressed',
                                'log': 'text/plain'
                            };
                            
                            if (mimeTypes[fileExtension]) {
                                mimeType = mimeTypes[fileExtension];
                            }
                            
                            var link = document.createElement('a');
                            var urlObj = window.URL.createObjectURL(new Blob([blob], { type: mimeType }));
                            link.href = urlObj;
                            link.download = filename;
                            document.body.appendChild(link);
                            link.click();
                            document.body.removeChild(link);
                            window.URL.revokeObjectURL(urlObj);
                        },
                        error: function (err) {
                            var errorMessage = 'Download failed.';
                            
                            // Try to parse error response if it's JSON
                            try {
                                if (err.responseText) {
                                    var errorData = JSON.parse(err.responseText);
                                    errorMessage = errorData.message || errorData.Message || errorMessage;
                                }
                            } catch (e) {
                                // If parsing fails, try to get error from statusText
                                errorMessage = err.statusText || err.responseText || errorMessage;
                            }
                            
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_DownloadFailed.replace("{0}", errorMessage));
                        }
                    });
                }
                // End of addition by Nischal C on 3/11/2025 Download file with parameters

                // Added by Nischal C on 3/11/2025 - Export document to PDF/Excel/XML/DOC
                function Export_PDFClick(format, docID, ProjID) {
                    const data = {
                        ProjectID: ProjID,
                        DocumentID: docID,
                        WhatToDelete: "I",
                        ExportFormat: format // 'PDF', 'EXCEL', 'XML', 'DOC'
                    };

                    var fullUrl = buildUrl("/api/DocumentUpload/ConvertDocument");

                    $.ajax({
                        type: "POST",
                        url: fullUrl,
                        contentType: 'application/json',
                        data: JSON.stringify(data),
                        xhrFields: { responseType: 'blob' },
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                        },
                        success: function (blob, status, xhr) {
                            const disposition = xhr.getResponseHeader('Content-Disposition');
                            const fileName = disposition && disposition.includes('filename=')
                                ? disposition.split('filename=')[1].replace(/["']/g, '')
                                : `downloaded_file.${format.toLowerCase()}`;
                            const link = document.createElement('a');
                            const url = window.URL.createObjectURL(blob);
                            link.href = url;
                            link.download = fileName;
                            document.body.appendChild(link);
                            link.click();
                            document.body.removeChild(link);
                            window.URL.revokeObjectURL(url);
                        },
                        error: function () {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(ResourceStrings.A_DownloadFailedGeneric);
                        }
                    });
                }
                // End of addition by Nischal C on 3/11/2025 Export document to PDF/Excel/XML/DOC

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
                    var dataRows = tbody.find('tr[data-document-id]:not(.detail-view-wrap), tr[data-url-id]').toArray();
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
                    
                    // Hide ALL rows first - use multiple methods to ensure they're hidden
                    // First, hide all data rows (main document/URL rows)
                    dataRows.forEach(function(row) {
                        var $row = $(row);
                        $row.css('display', 'none !important'); // Force hide with CSS !important
                        $row.hide(); // Also use jQuery hide
                        $row.attr('style', 'display: none !important'); // Set inline style with !important
                    });
                    
                    // Hide all category headers
                    tbody.find('tr.category-header-row').each(function() {
                        $(this).css('display', 'none !important');
                        $(this).hide();
                        $(this).attr('style', 'display: none !important');
                    });
                    
                    // Hide ALL detail view rows - we'll show them only when their parent row is visible
                    // Remove the inline display style completely, then hide
                    tbody.find('tr.detail-view-wrap').each(function() {
                        var $tr = $(this);
                        // Remove display:table-row from style, keep other styles
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
                            
                            // Show associated detail view row if it exists and detail view is active
                            // Note: Detail view rows are NOT counted in pagination (they're separate display rows)
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
                            
                            // Find and show the category header for this row
                            // Look for the category header that appears before this row
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
                            // Step 1: Hide ALL main rows with maximum force
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
                            
                            // Step 2: Hide ALL detail rows
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
                            
                            // Step 3: Show ONLY rows from startIndex to endIndex (exactly this range)
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
                                    
                                    // Show detail row only if detail view is active
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
                            
                            // Step 4: Show category header
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
                            
                            // Final verification
                            var finalMain = tbody.find('tr[data-document-id]:not(.detail-view-wrap):visible, tr[data-url-id]:visible').length;
                            var finalDetail = tbody.find('tr.detail-view-wrap:visible').length;
                            // If still wrong, use direct DOM manipulation based on index
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
        // Similar to SM_ContractMaster's addFileinGrid() but adapted for .NET Core API
        // MIMEType.xml validation is handled on client side (ASPX) since XML file is not in API solution
        async function validateFilesMimeType(files) {
            var validatedFiles = [];

            // Process files sequentially for MIME validation
            for (var idx = 0; idx < files.length; idx++) {
                var file = files[idx];

                try {
                    // Create FormData with file
                    var formData = new FormData();
                    formData.append('file', file);

                    // Call GetFileType API (synchronous-like behavior using async/await)
                    var apiResponse = await new Promise(function(resolve, reject) {
                        $.ajax({
                            url: buildUrl('/api/DocumentUpload/GetFileType'),
                            type: 'POST',
                            data: formData,
                            cache: false,
                            contentType: false,
                            processData: false,
                            async: true, // Use async for better performance
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token_W26API"));
                                xhr.setRequestHeader('Accept', 'application/json');
                            },
                            success: function (result) {
                                resolve(result);
                            },
                            error: function (err) {
                                var errorMsg = 'Error validating file type';
                                try {
                                    if (err.responseJSON && err.responseJSON.message) {
                                        errorMsg = err.responseJSON.message;
                                    } else if (err.responseText) {
                                        var errorData = JSON.parse(err.responseText);
                                        errorMsg = errorData.message || errorData.Message || errorMsg;
                                    }
                                } catch (e) {
                                    errorMsg = err.statusText || errorMsg;
                                }
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(errorMsg);
                                resolve({ IsValid: false, Message: errorMsg });
                            }
                        });
                    });

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

                    // Check if API validation passed (handle both boolean true and string "true")
                    var apiIsValid = false;
                    if (response) {
                        // Check multiple possible property names and formats
                        var isValidValue = response.IsValid || response.isValid || response.is_valid;
                        if (isValidValue !== undefined) {
                            // Handle boolean true, string "true", number 1, etc.
                            apiIsValid = (isValidValue === true ||
                                isValidValue === "true" ||
                                isValidValue === "True" ||
                                isValidValue === 1 ||
                                isValidValue === "1");
                        }
                    }

                    // If API says valid, trust it (XML validation is optional)
                    if (apiIsValid === true) {
                        validatedFiles.push(file);
                    } else {
                        // Only do XML validation if API validation failed
                        var isValid = false;
                        if (response && response.DetectedMimeType) {
                            isValid = await validateMimeTypeWithXml(response.DetectedMimeType, file.name, apiIsValid);
                        }

                        // If file passed validation (either API or XML), add it
                        if (isValid === true) {
                            validatedFiles.push(file);
                        } else {
                            var errorMsg = (response && response.Message) || 'Invalid file type';
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(errorMsg);
                        }
                    }
                } catch (error) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(ResourceStrings.A_ErrorValidatingMimeType.replace("{0}", error.message));
                    // Skip this file
                    continue;
                }
            }

            return validatedFiles;
        }
        // End of addition by Nischal C on 3/11/2025 - MIME type validation

        // Added by Nischal C on 3/11/2025 - Validate MIME type against MIMEType.xml (client-side)
        // This validates the detected MIME type from API against MIMEType.xml file
        // Note: XML validation is optional - if API says valid, we trust it
        async function validateMimeTypeWithXml(detectedMimeType, fileName, apiIsValid) {
            try {
                // If API validation passed, trust it (XML validation is optional cross-check)
                if (apiIsValid === true) {
                    return true;
                }

                // Only do XML validation if API validation failed
                // This allows XML to be a fallback or additional check
                var xmlDoc = await loadMimeTypeXml();
                if (!xmlDoc) {
                    // If XML file cannot be loaded, use API's validation result
                    return apiIsValid;
                }

                // Get file extension
                var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();
                if (!extension) {
                    return apiIsValid;
                }

                // Find matching MIME entry in XML (case-insensitive comparison)
                var mimeNodes = xmlDoc.getElementsByTagName('MIME');
                for (var i = 0; i < mimeNodes.length; i++) {
                    var contentTypeNode = mimeNodes[i].getElementsByTagName('ContentType')[0];
                    var extensionNode = mimeNodes[i].getElementsByTagName('Extension')[0];

                    if (contentTypeNode && extensionNode) {
                        var xmlContentType = (contentTypeNode.textContent || contentTypeNode.innerText).toLowerCase();
                        var xmlExtensions = (extensionNode.textContent || extensionNode.innerText).toLowerCase();
                        var detectedMimeLower = (detectedMimeType || '').toLowerCase();

                        // Check if detected MIME type matches XML (case-insensitive) and extension is in the list
                        if (xmlContentType === detectedMimeLower && xmlExtensions.indexOf(extension) > -1) {
                            return true; // Valid match found in XML
                        }
                    }
                }

                // If no match found in XML, return API's result (which is already false if we got here)
                return apiIsValid;
            } catch (error) {
                console.warn('Error validating with MIMEType.xml:', error);
                // On error, use API's validation result
                return apiIsValid;
            }
        }

        // Added by Nischal C on 3/11/2025 - Load MIMEType.xml file
        // Cache the XML document to avoid loading it multiple times
        var mimeTypeXmlCache = null;
        async function loadMimeTypeXml() {
            if (mimeTypeXmlCache) {
                return mimeTypeXmlCache;
            }

            try {
                var xmlDoc = await new Promise(function(resolve, reject) {
                    $.ajax({
                        url: 'MIMEType.xml',
                        type: 'GET',
                        dataType: 'xml',
                        cache: true,
                        success: function(xml) {
                            resolve(xml);
                        },
                        error: function() {
                            // If XML file not found, return null (will use API's validation)
                            console.warn('MIMEType.xml not found, using API validation only');
                            resolve(null);
                        }
                    });
                });

                mimeTypeXmlCache = xmlDoc;
                return xmlDoc;
            } catch (error) {
                console.warn('Error loading MIMEType.xml:', error);
                return null;
            }
        }

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