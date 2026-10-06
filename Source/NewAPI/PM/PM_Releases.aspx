<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Releases.aspx.vb" Inherits="Whizible.PM_Releases" %>

<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Releases")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_Releases")%></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
     <!-- Added By Madhuri.K On 02-04-2026 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
    <style>
        /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        body{
            font-size:11.5px
        }
        .alertify-notifier {
            z-index: 9999 !important;
        }
        /* Ensure Send Mail button is visible */
        #sendMailBtn {
            display: inline-block !important;
            visibility: visible !important;
            opacity: 1 !important;
            min-width: 80px !important;
            padding: 6px 20px !important;
        }        
        #ReleasesTbl th::after,
        #ReleasesTbl th::before,
        #ReleasesTbl th i,
        #ReleasesTbl th .fa,
        #ReleasesTbl th .fas,
        #ReleasesTbl th .far,
        #ReleasesTbl th .sort,
        #ReleasesTbl th .sorting,
        #ReleasesTbl th .sorting_asc,
        #ReleasesTbl th .sorting_desc {
            display: none !important;
        }
        #ReleasesTbl th:after,
        #ReleasesTbl th:before {
            display: none !important;
        }
        /* Fix project dropdown width */
        select#ProjectFilter {
            width: 250px !important;
            max-width: 250px !important;
            min-width: 250px !important;
            display: none !important;
        }
        .bootstrap-select#ProjectFilter {
            width: 250px !important;
            max-width: 250px !important;
            min-width: 250px !important;
            position: relative !important;
            overflow: visible !important;
            box-sizing: border-box !important;
            z-index: 1 !important;
        }
        /* Disable project dropdown when offcanvas is open */
        body.offcanvas-open .bootstrap-select#ProjectFilter,
        body:has(.offcanvas.show) .bootstrap-select#ProjectFilter {
            pointer-events: none !important;
            opacity: 0.6 !important;
        }
        body.offcanvas-open .bootstrap-select#ProjectFilter .dropdown-toggle,
        body:has(.offcanvas.show) .bootstrap-select#ProjectFilter .dropdown-toggle {
            pointer-events: none !important;
            cursor: default !important;
            opacity: 0.6 !important;
            background-color: #f3f4f6 !important;
        }
        body.offcanvas-open .bootstrap-select#ProjectFilter .dropdown-toggle:hover,
        body.offcanvas-open .bootstrap-select#ProjectFilter .dropdown-toggle:focus,
        body.offcanvas-open .bootstrap-select#ProjectFilter .dropdown-toggle:active,
        body:has(.offcanvas.show) .bootstrap-select#ProjectFilter .dropdown-toggle:hover,
        body:has(.offcanvas.show) .bootstrap-select#ProjectFilter .dropdown-toggle:focus,
        body:has(.offcanvas.show) .bootstrap-select#ProjectFilter .dropdown-toggle:active {
            pointer-events: none !important;
            cursor: default !important;
            opacity: 0.6 !important;
            background-color: #f3f4f6 !important;
            border-color: #d1d5db !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
            outline: none !important;
        }
        body.offcanvas-open .bootstrap-select#ProjectFilter.open,
        body:has(.offcanvas.show) .bootstrap-select#ProjectFilter.open {
            pointer-events: none !important;
            opacity: 0.6 !important;
        }
        body.offcanvas-open .bootstrap-select#ProjectFilter.open .dropdown-toggle,
        body:has(.offcanvas.show) .bootstrap-select#ProjectFilter.open .dropdown-toggle {
            background-color: #f3f4f6 !important;
            border-color: #d1d5db !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
        }
        .bootstrap-select#ProjectFilter .dropdown-toggle {
            width: 100% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            box-sizing: border-box !important;
            position: relative !important;
            z-index: 1001 !important;
            border: 1px solid #d1d5db !important;
            border-radius: 0.25rem !important;
            padding: 0.375rem 0.75rem !important;
            background-color: #f3f4f6 !important;
            color: #374151 !important;
            /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
            font-size: 11.5px !important;
            height: 2rem !important;
            line-height: 1.25rem !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
            display: flex !important;
            align-items: center !important;
            justify-content: space-between !important;
        }
        .bootstrap-select#ProjectFilter .dropdown-toggle:hover {
            border-color: #9ca3af !important;
            background-color: #e5e7eb !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
        }
        .bootstrap-select#ProjectFilter .dropdown-toggle:focus,
        .bootstrap-select#ProjectFilter .dropdown-toggle:active {
            border-color: #3b82f6 !important;
            background-color: #f3f4f6 !important;
            outline: 0 !important;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1) !important;
        }
        .bootstrap-select#ProjectFilter:not(.open) .dropdown-toggle:not(:focus):not(:active) {
            border-color: #d1d5db !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
        }
        /* Validation error highlighting - only black border like normal field, no icons or extra styling */
        .form-control.is-invalid,
        textarea.is-invalid,
        select.is-invalid {
            border-color: #000000 !important;
            border-width: 1px !important;
            box-shadow: none !important;
            outline: none !important;
            background-image: none !important;
            background-position: unset !important;
            padding-right: inherit !important;
        }
        .form-control.is-invalid:focus,
        textarea.is-invalid:focus,
        select.is-invalid:focus {
            border-color: #000000 !important;
            border-width: 1px !important;
            box-shadow: none !important;
            outline: none !important;
            background-image: none !important;
        }
        /* Hide any validation icons or feedback */
        .form-control.is-invalid + .invalid-feedback,
        textarea.is-invalid + .invalid-feedback,
        select.is-invalid + .invalid-feedback {
            display: none !important;
        }
        /* First column blue color - same as Lessons Learnt page */
        #ReleasesTbl tbody tr td:first-child,
        /* Added By Vyankat B On 24-11-2025 - Release Note column same styling as Subject column */
        #ReleasesTbl tbody tr td:nth-child(2) {
            color: #1359a6 !important;
            cursor: pointer !important; /* <--- ADDED by Vaibhav K for cursor on 02-02-25 */
        }
        .bootstrap-select#ProjectFilter .dropdown-menu {
            max-width: 250px !important;
            width: 250px !important;
            box-sizing: border-box !important;
            position: fixed !important;
        }
        /* Style DataTable's empty state message - match table row styling exactly */
        #ReleasesTbl tbody td.dataTables_empty,
        table#ReleasesTbl tbody td.dataTables_empty,
        #ReleasesTbl.dataTable tbody td.dataTables_empty,
        #ReleasesTbl tbody tr td.dataTables_empty {
            text-align: center !important;
            font-style: normal !important;
            color: #212529 !important;
            font-family: 'Roboto', sans-serif !important;
            font-weight: normal !important;
            padding: 16px 20px !important;
            /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
            font-size: 11.5px !important;
            vertical-align: middle !important;
            line-height: normal !important;
        }
    </style>

    <style type="text/css">
        .dataTables_scrollBody {
            margin-bottom: 10px;
        }
        .listboxpanel select {
            min-height: 320px
        }
        table tr th, table tr td {
            text-align: center !important
        }
        table tr th:last-child, table tr td:last-child {
            text-align: center;
        }
        .dataTables_scrollHeadInner, .dataTables_scrollHeadInner table {
            width: 100% !important
        }
        .dataTables_scrollHeadInner {
            width: 100% !important
        }
        div.dataTables_scrollBody > table {
            width: 100% !important
        }
        .custom_chckbox label:before {
            margin-right: 10px;
        }
        .accordion-button{
          /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
            font-size: 12px;
        }
        .h6, h6 {
    font-size: 12px;
}
        .nostylebtn {
            background: none;
            border: none;
            padding: 0;
            outline: none;
        }
        .custmfields .form-group {
            background: #f5f5f5;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .custmfields .form-group .col-sm-2 {
            padding-right: 0px;
        }
        .ui-datepicker {
            z-index: 9999!important;
        }        
        .bootstrap-select .dropdown-menu {
            overflow-y: auto;
            z-index: 10000 !important; /* Ensure dropdown menus appear above all other elements */
        }        
        .bootstrap-select:not(.open) .dropdown-menu {
            overflow-y: hidden;
        }        
        .bootstrap-select.open .dropdown-menu {
            overflow-y: auto;
            max-height: 200px; /* Adjust height as needed */
        }
        
        .bootstrap-select#ProjectFilter.open .dropdown-menu {
            position: fixed !important;
            display: block !important;
        }        
        .bootstrap-select .dropdown-menu::-webkit-scrollbar {
            width: 6px;
        }        
        .bootstrap-select .dropdown-menu::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 3px;
        }        
        .bootstrap-select .dropdown-menu::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 3px;
        }        
        .bootstrap-select .dropdown-menu::-webkit-scrollbar-thumb:hover {
            background: #a8a8a8;
        }        
        .required::after {
            content: " *";
            color: red;
            font-weight: bold;
        }
        .dataTables_paginate {
            display: none !important;
        }        
        .dataTables_info {
            display: none !important;
        }        
        .dataTables_length {
            display: none !important;
        }
        .dataTables_scrollHead {
            position: sticky !important;
            top: 0 !important;
            z-index: 100 !important;
            background: white !important;
        }        
        .dataTables_scrollHead table {
            margin-bottom: 0 !important;
        }        
        .dataTables_scrollHead th {
            background: #f8f9fa !important;
            border-bottom: 2px solid #dee2e6 !important;
            position: sticky !important;
            top: 0 !important;
            z-index: 101 !important;
        }        
        .dataTables_scrollBody {
            max-height: calc(100vh - 120px) !important;
            overflow-y: auto !important;
            height: auto !important;
            transition: height 0.3s ease; 
        }        
        .dataTables_scrollHeadInner {
            background: white !important;
        }
        /* Main page pagination - fixed at bottom */
        .content > .pagination-container {
            background: white;
            display: flex !important;
            justify-content: flex-end;
            align-items: center;
            padding: 1rem;
            gap: 1rem;
            margin-top: 0;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            visibility: visible !important;
            opacity: 1 !important;
        }        
        /* Offcanvas file pagination - relative positioning, only visible inside offcanvas */
        .offcanvas .pagination-container {
            background: transparent;
            display: flex !important;
            justify-content: flex-end;
            align-items: center;
            padding: 0.75rem 0;
            gap: 0.5rem;
            margin-top: 0.5rem;
            position: relative !important;
            bottom: auto !important;
            left: auto !important;
            right: auto !important;
            z-index: auto;
            visibility: visible !important;
            opacity: 1 !important;
        }
        #ReleasesTbl_wrapper {
            max-height: 350px; /* Reduced height to prevent page scroll */
            overflow-x: hidden; /* Hide scrollbar by default */
            overflow-y: Auto; /* Hide scrollbar by default */
            /* Reserve space for scrollbar to prevent content shift */
            padding-right: 8px;
            box-sizing: border-box;
        }        
       
        /* Custom scrollbar styling for webkit browsers */
        #ReleasesTbl_wrapper::-webkit-scrollbar {
            width: 0px; /* Thin scrollbar width */
        }        
        #ReleasesTbl_wrapper::-webkit-scrollbar-track {
            background: #f1f1f1; /* Track color */
        }        
        #ReleasesTbl_wrapper::-webkit-scrollbar-thumb {
            background: #ccc; /* Thumb color */
            border-radius: 4px; /* Rounded corners */
        }        
        #ReleasesTbl_wrapper::-webkit-scrollbar-thumb:hover {
            background: #999; /* Thumb color on hover */
        }        
        #ReleasesTbl thead th {
            position: sticky;
            top: 0;
            z-index: 10;
            border-bottom: 2px solid #dee2e6;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        #ReleasesTbl tbody {
            white-space: nowrap;
            overflow: auto;
            text-overflow: ellipsis;
        }        
        #ReleasesTbl {
            margin-bottom: 0;
        }        
        body {
            padding-bottom: 80px;
        }
        input[type="text"]::-webkit-outer-spin-button,
        input[type="text"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            appearance: none;
            margin: 0;
        }        
        input[type="text"] {
            -moz-appearance: textfield;
            appearance: textfield;
        }
        #ReleasesTbl thead th.sorting,
        #ReleasesTbl thead th.sorting_asc,
        #ReleasesTbl thead th.sorting_desc {
            background-image: none !important;
        }        
        #ReleasesTbl thead th.sorting:after,
        #ReleasesTbl thead th.sorting_asc:after,
        #ReleasesTbl thead th.sorting_desc:after {
        content: none !important;
        }
        .attachment-icon {
            cursor: pointer;
            color: #1359a6;
            font-size: 1rem;
            margin-left: 0.5rem;
        }
        .attachment-icon:hover {
            color: #0d47a1;
        }
      /*  #ReleasesTbl_wrapper {
            overflow-x: hidden;
        }*/

      /*Addded by Vaibhav K for issue fixing*/
      /* --- UI Fix for Upload File Preview --- */
        /* Remove the black background box */
        .drop-zone__thumb {
            background-color: transparent !important;
            border: none !important;
            box-shadow: none !important;
            display: flex !important;
            align-items: center;
            justify-content: center;
        }

        /* Style the file name text (which is stored in data-label) */
        .drop-zone__thumb::after {
            color: #1359a6 !important; /* Whizible Blue */
            text-decoration: underline !important;
            background-color: transparent !important;
            /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
            font-size: 12px !important;
            font-weight: 500 !important;
            /* Ensure the text wraps if filename is long */
            white-space: normal !important; 
            text-align: center;
        }
        /* Optional: Hide the background image icon if one exists for non-images */
        /*.drop-zone__thumb {
            background-image: none !important; 
        }*/

        /*Added by Vaibhav K for reducing size of document popup*/
         #UploadDocumentModal {
        --bs-modal-width: 700px;
    }


      /*End of Addded by Vaibhav K for issue fixing*/


    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">   
    <%If m_blnViewAccess = True Then%>
    <div class="bgwhite">
        <div style="background: white; margin-bottom: 1rem;">
            <div class="graybg" style="padding: 0.4rem 1rem; margin-left: 0;">
                <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                    <i class="fas fa-rocket" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;"></i>
                    <%=MyBase.GetResourceString("C_Releases")%> 
                </h2>
                <p style="color: #6b7280; font-size: 0.7rem; margin: 0;"><%=MyBase.GetResourceString("C_ReleaseDesc")%>  </p>
            </div>
        </div>
        <div style="background: rgb(231, 237, 240); padding: 0.5rem 1rem; margin: 0 1.7rem 0 1.2rem;">
            <div style="display: flex; align-items: center; justify-content: space-between; gap: 0.75rem;">
                <!-- Project Dropdown and Search Box Container -->
                <div style="display: flex; align-items: center; gap: 0.75rem; position: relative;">
                    <!-- Added By Vyankat B on [Date] - Project dropdown -->
                    <div style="position: relative; width: 250px; max-width: 250px; min-width: 250px; flex-shrink: 0; overflow: visible; z-index: 1; box-sizing: border-box;">
                        <select id="ProjectFilter" data-live-search="true" data-width="250px" title="<%=MyBase.GetResourceString("C_SelProject")%>">
                        <%--<option value=""><%=MyBase.GetResourceString("C_SelProject")%></option>--%>
                    </select>
                    </div>
                    <!-- End of Added By Vyankat B -->
                    <div style="display: flex; align-items: center; background: white; border-radius: 0.25rem; border: 1px solid #d1d5db; overflow: hidden; height: 2rem; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
                        <input type="text" id="searchInput" placeholder="Search.." oninput="handleSearchInput()" style="border: none; outline: none; padding: 0.25rem 0.5rem; flex: 1; background: transparent; height: 100%; font-size: 11.5px;">
                        <button id="searchBtn" onclick="handleSearchInput()" style="background: #f3f4f6; border: none; padding: 0.25rem 0.5rem; color: #374151; cursor: pointer; height: 100%; display: flex; align-items: center; border-left: 1px solid #d1d5db;">
                            <i class="fas fa-search" style="font-size: 11.5px;"></i>
                        </button>
                    </div>
                </div>
                <!-- Action Buttons Container - Separate from Dropdown -->
                <div style="display: flex; align-items: center; gap: 0.5rem; position: relative; z-index: 1;">
                    <% If m_blnAddAccess Then %>
                    <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_EditRelease" aria-controls="offcanvasWithBothOptions" class="btn btnyellow" id="NewReleaseBtn" onclick="openNewReleaseForm()" title="New Release">
                        <%=MyBase.GetResourceString("C_NewRelease")%>
                    </a>
                    <%End If %>
                    <% If m_blnDeleteAccess Then %>
                     <button class="btn borderbtn" id="deleteReleaseBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Delete")%>"><%=MyBase.GetResourceString("C_Delete")%></button>
                    <%End If %>
                    <a href="javascript:;" class="clearalllink pe-3" id="SelectAllBtn" onclick="selectAllReleases()" data-bs-toggle="tooltip" title="Select All">
                        <strong><%=MyBase.GetResourceString("C_SelectAll")%></strong>
                    </a>
                    <a href="javascript:;" class="clearalllink pe-3" id="ClearAllBtn" onclick="clearAllReleases()" data-bs-toggle="tooltip" title="Clear All">
                        <strong><%=MyBase.GetResourceString("C_ClearAll")%></strong>
                    </a>
                </div>
            </div>
        </div>
        <div class="content">
            <table id="ReleasesTbl" class="table table-stripped table-responsive newTblStyle">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_Subject")%></th>
                        <th><%=MyBase.GetResourceString("C_ReleaseNote")%></th>
                        <th><%=MyBase.GetResourceString("C_Date")%></th>
                        <th style="width: 40px;">
                            <input type="checkbox" id="chkSelectAll" class="chckHead" title="Select All" />
                        </th>
                    </tr>
                </thead>
                <tbody id="ReleasesTbl_body">
                    
                </tbody>
            </table>
            <div class="pagination-container">
                <div style="color: #374151; font-size: 11.5px;">
                    <span id="totalRecords">
                    </span>
                </div>
                <div style="display: flex; gap: 0.5rem;">
                    <button id="firstPageBtn" onclick="goToPreviousPage()" data-bs-toggle="tooltip" title="Previous Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                        <i class="fas fa-angle-double-left"></i>
                    </button>
                    <button id="lastPageBtn" onclick="goToNextPage()" data-bs-toggle="tooltip" title="Next Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                        <i class="fas fa-angle-double-right"></i>
                    </button>
                </div>
            </div>
            <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="false" tabindex="-1"
                id="offcanvas_EditRelease">
                <div class="offcanvas-body">
                    <div class="Edit_Details">
                        <div class="graybg container-fluid py-1 mb-2">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_Releases")%></h5>
                                </div>
                            </div>
                        </div>
                        <div class="row my-2">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-sm-2">
                                    </div>
                                    <div class="col-sm-10 text-end" style="white-space: nowrap;">
                                        <a href="javascript:;" class="textUndrln me-3" id="ReleaseNoteBtn" onclick="openReleaseNoteView()" data-bs-toggle="tooltip" title="Release Note">
                                            <span><%=MyBase.GetResourceString("C_ReleaseNote")%></span>
                                        </a>
                                        <a href="javascript:;" class="textUndrln me-3" id="SendMailBtn" onclick="sendReleaseMail()" data-bs-toggle="tooltip" title="Send Mail">
                                            <span><%=MyBase.GetResourceString("C_SendMail")%></span>
                                        </a>
                                        <% If m_blnEditAccess = True Or m_blnAddAccess = True Then %>
                                        <button class="btn btnyellow me-2" id="saveReleaseBtn" data-bs-toggle="tooltip" title="Save" onclick="saveRelease(false)"><%=MyBase.GetResourceString("C_Save")%></button>
                                        <%End If %>
                                        <% If m_blnAddAccess = True Then %>
                                        <button class="btn btnyellow me-2" id="saveandAddReleaseBtn" data-bs-toggle="tooltip" title="Save and Add" onclick="saveRelease(true)"><%=MyBase.GetResourceString("C_SaveAdd")%></button>
                                        <%End If %>
                                        <% If m_blnDeleteAccess = True Then %>
                                        <button class="btn borderbtn me-2" id="deleteReleaseFormBtn" data-bs-toggle="tooltip" title="Delete" onclick="showDelModalRelease()"><%=MyBase.GetResourceString("C_Delete")%></button>
                                        <%End If %>
                                        <button type="button" class="btn borderbtn closebtn" id="offcanvasClose" data-bs-toggle="tooltip" title="Back" data-bs-dismiss="offcanvas"><%=MyBase.GetResourceString("C_Back")%></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-sm-12 text-end">
                                <label class="form-label "><%=MyBase.GetResourceString("C_Mandatory")%></label>
                            </div>
                        </div>
                        <div class="accordion Off_acordian_panel my-3 " id="EditDetailsAcc">
                            <div class="accordion-item mb-3">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#EditDetailsTab" aria-expanded="true">
                                        <%=MyBase.GetResourceString("C_ReleaseDetails")%>
                                    </button>
                                </h2>
                                <div id="EditDetailsTab" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <div class="EditContent">
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="SubjectEdit" class="required text-end"><%=MyBase.GetResourceString("C_Subject")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="SubjectEdit" maxlength="50"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="DateEdit" class="text-end"><%=MyBase.GetResourceString("C_Date")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control" id="DateEdit" readonly disabled/>
                                                                <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button" disabled><i class="fas fa-calendar-alt"></i></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="MilestoneEdit" class="text-end"><%=MyBase.GetResourceString("C_Milestone")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                         <%--commented and added By Vaibhav K for creating dynamic dropdown--%>
                                                            <%--<%CommonFunctions.HTMLControls.DrawComboBox("MilestoneEdit", "usp_Whizible2_Sel_tbl_PM_Milestones_Releases " & Session("intProjectID"),,, "class='selectpicker' data-live-search='true'",,,) %>--%>
                                                           <select id="MilestoneEdit" class="selectpicker form-control" data-live-search="true" title="Select Milestone"></select>
                                                         <%--commented and added By Vaibhav K for creating dynamic dropdown--%>
                                                      
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="ObjectivesEdit" class="required text-end"><%=MyBase.GetResourceString("C_Objectives")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="ObjectivesEdit" rows="4" maxlength="450"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="ReleaseItemsEdit" class="required text-end"><%=MyBase.GetResourceString("A_DeReIt")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="ReleaseItemsEdit" rows="4" maxlength="450"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="KnownProblemsEdit" class="required text-end"><%=MyBase.GetResourceString("C_KnownProblems")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="KnownProblemsEdit" rows="4" maxlength="450"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="InstallationEdit" class="required text-end"><%=MyBase.GetResourceString("C_Installation")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="InstallationEdit" rows="4" maxlength="450"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="IssuesEdit" class="required text-end"><%=MyBase.GetResourceString("C_Issues")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="IssuesEdit" rows="4" maxlength="450"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="TestingSummaryEdit" class="required text-end"><%=MyBase.GetResourceString("C_TestingSummary")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="TestingSummaryEdit" rows="4" maxlength="450"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item mb-3" id="UploadedFilesDetails">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#UploadedFilesTab" aria-expanded="true">
                                        <%=MyBase.GetResourceString("C_UploadedFiles")%>
                                    </button>
                                </h2>
                                <div id="UploadedFilesTab" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <div class="TabSection">
                                            <div class="container-fluid">
                                                <div class="form-inline pb-1">
                                                    <div class="row">
                                                        <div class="col-sm-6">
                                                            <h5 class="pgtitle"><%=MyBase.GetResourceString("C_UploadedFilesDetails")%></h5>
                                                        </div>
                                                        <div class="col-sm-6 text-end">
                                                            <% If m_blnAddAccess Then %>
                                                                <button type="button" class="btn borderbtn" id="UploadDocumentBtn"><span data-bs-toggle="tooltip" title="Add"><%=MyBase.GetResourceString("C_Add")%></span></button>
                                                            <%End If %>
                                                            <% If m_blnDeleteAccess Then %>
                                                                <a href="javascript:;" class="btn borderbtn" id="DeleteFileBtn" onclick="deleteSelectedFiles()" data-bs-toggle="tooltip" title="Delete"><%=MyBase.GetResourceString("C_Delete")%></a>
                                                            <%End If %>
                                                            <a href="javascript:;" class="clearalllink pe-3" id="SelectAllFilesBtn" onclick="selectAllFiles()" data-bs-toggle="tooltip" title="Select All">
                                                                <strong><%=MyBase.GetResourceString("C_SelectAll")%></strong>
                                                            </a>
                                                            <a href="javascript:;" class="clearalllink pe-3" id="ClearAllFilesBtn" onclick="clearAllFiles()" data-bs-toggle="tooltip" title="Clear All">
                                                                <strong><%=MyBase.GetResourceString("C_ClearAll")%></strong>
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <div class="clearfix"></div>
                                                </div>

                                                <div class="table-responsive">
                                                    <table id="UploadedFilesTbl" class="table table-stripped" style="width: 100%;">
                                                        <thead>
                                                            <tr>
                                                                <th><%=MyBase.GetResourceString("C_SrNo")%></th>
                                                                <th><%=MyBase.GetResourceString("C_FileName")%></th>
                                                                <th><%=MyBase.GetResourceString("C_FileSizeKB")%></th>
                                                                <th><%=MyBase.GetResourceString("C_AttachedBy")%></th>
                                                                <th><%=MyBase.GetResourceString("C_AttachedDate")%></th>
                                                                <th><%=MyBase.GetResourceString("C_Description")%></th>
                                                                <th><%=MyBase.GetResourceString("C_Delete")%></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <!-- Table rows will be populated dynamically -->
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="pagination-container">
                                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                                        <span id="totalFileRecords" style="color: #374151; font-size: 11.5px;">Total Records: 0</span>
                                                        <button id="firstFilePageBtn" onclick="goToPreviousFilePage()" data-bs-toggle="tooltip" title="Previous Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                                            <i class="fas fa-angle-double-left"></i>
                                                        </button>
                                                        <button id="lastFilePageBtn" onclick="goToNextFilePage()" data-bs-toggle="tooltip" title="Next Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                                            <i class="fas fa-angle-double-right"></i>
                                                        </button>
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
            </div>
            <!-- Edit Release Section ends -->
        </div>
    </div>
    <div id="deleteConfirm" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" onclick="Close_deleteModel()" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteConf")%></h4>
                    </div>
                    <div class="modal-body">
                        <p id="txtExcelValidationMessage"><center><%=MyBase.GetResourceString("C_DelRelease")%></center></p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" onclick="Close_deleteModel()"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" id="btnExcelYes" onclick="DeleteRequestDetails()"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    <!-- Delete File Confirmation Modal -->
    <div id="deleteFileConfirm" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
        <div class="modal-dialog ui-draggable">
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteConf")%></h4>
                </div>
                <div class="modal-body">
                    <p id="deleteConfirmFile">
                        <center><%=MyBase.GetResourceString("C_DelRelease")%></center>
                    </p>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_No")%></button>
                    <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="deleteTheSelectedFiles()"><%=MyBase.GetResourceString("C_Yes")%></button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- File Attachment modal start here-->
    <div class="modal custmodal fade" id="UploadDocumentModal" data-bs-backdrop="static" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="margin-top:10px;">
                <div class="modal-header">
                    <h5 class="modal-title text-center"><%=MyBase.GetResourceString("C_UploadData")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="uploadDocDetails">
                        <div class="form-group row">
                            <div class="col-sm-6 drop-zone form-group mb-3" id="drop-zone-div">
                                <span class="drop-zone__prompt"><%=MyBase.GetResourceString("C_DropFilePrompt")%></span>
                                <input type="file" class="drop-zone__input" id="doc_dragdrop">
                            </div>
                            <div class="col-sm-6 d-flex align-items-center justify-content-center mb-3">
                                <div class="row">
                                    <label for="docDescription" class="col-sm-4 text-end mt-2"><%=MyBase.GetResourceString("C_Description")%></label>
                                    <div class="col-sm-8">
                                        <textarea id="docDescription" class="form-control" maxlength="500"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-sm-12 text-center">
                            <button id="uploadDocBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Upload")%>" class="btn btnyellow" onclick="UploadFile();"><%=MyBase.GetResourceString("C_Upload")%></button>
                            <button data-bs-dismiss="modal" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Cancel")%>" class="btn borderbtn"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- File Attachment modal end here-->
    <!-- Send Mail modal start here-->
    <div class="modal custmodal fade" id="SendMailModal" data-bs-backdrop="static" aria-hidden="true" style="overflow-y:hidden;">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center"><%=MyBase.GetResourceString("C_SendMail")%></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="padding-top:12px; padding-bottom:15px;">
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-3">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_Frm")%></strong></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendMailFrom" class="form-control" readonly="readonly" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-3">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_To")%></strong> <span style="color:red;"><%=MyBase.GetResourceString("C_Str")%></span></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendMailTo" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-3">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_CC")%></strong></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendMailCC" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-3">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_Subject")%></strong> <span style="color:red;"><%=MyBase.GetResourceString("C_Str")%></span></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <input type="text" id="sendMailSubject" class="form-control" style="width:94%; padding:4px 10px; height:28px; box-sizing:border-box;" />
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-3"></div>
                        <div class="form-group col-sm-9">
                            <small style="color:#666;"><%=MyBase.GetResourceString("C_MailNote")%></small>
                        </div>
                    </div>
                    <div class="row form-group" style="margin-bottom:9px;">
                        <div class="form-group col-sm-3">
                            <label class="control-label"><strong><%=MyBase.GetResourceString("C_Msg")%></strong></label>
                        </div>
                        <div class="form-group col-sm-9">
                            <textarea id="sendMailBody" class="form-control" rows="10" style="width:94%; padding:6px 10px; line-height: 1.5!important; resize:vertical; min-height:180px; box-sizing:border-box;"></textarea>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-sm-12 text-center">
                            <button id="sendMailBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Send")%>" class="btn btnyellow" onclick="sendMailConfirm()"><%=MyBase.GetResourceString("C_Send")%></button>
                            <button data-bs-dismiss="modal" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Cancel")%>" class="btn borderbtn" onclick="window.close()"><%=MyBase.GetResourceString("C_Cancel")%></button>
                        </div>
                    </div>
                    <div class="clearfix">                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Send Mail modal end here-->
    <!-- Release Note modal start here-->
    <div class="modal custmodal fade" id="ReleaseNoteModal" data-bs-backdrop="static" aria-hidden="true" style="display:none; overflow-x:hidden;overflow-y:hidden;">
        <div class="modal-dialog modal-lg" role="document" style="max-width:60%; margin:1.75rem auto;">
            <div class="modal-content" style="overflow-x:hidden;">
                <div class="modal-header" style="background-color:rgb(66, 99, 193); border-bottom:none; padding:15px 20px; overflow-x:hidden; border-radius:4px 4px 0 0;">
                    <h4 class="modal-title text-center" ><%=MyBase.GetResourceString("C_ReleaseNote")%></h4>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="<%=MyBase.GetResourceString("C_Close")%>" style="position:absolute; right:20px; top:15px; color:#fff; opacity:1;">
                        <span aria-hidden="true" style="color:#fff; font-size:18px;">&times;</span>
                    </button>
                    <div id="releaseNoteDate" style="position:absolute; right:61px; top:15px; color:#fff; font-size:11.5px; white-space:nowrap; opacity:0.9;"><%=MyBase.GetResourceString("C_Dte")%><span id="releaseNoteDateValue"></span></div>
                </div>
                <div class="modal-body" style="padding:20px; max-height:80vh; overflow-y:auto; overflow-x:hidden; word-wrap:break-word;">
                    <!-- Objectives Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;"><%=MyBase.GetResourceString("C_Objectives")%></h6>
                            <div id="releaseNoteObjectives" style="padding:10px; background-color:#f8f9fa; border:1px solid #dee2e6; border-radius:4px; min-height:50px; color:#555; word-wrap:break-word; overflow-wrap:break-word; overflow-x:hidden;">
                                <p style="margin:0;"></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Details Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;"><%=MyBase.GetResourceString("A_DeReIt")%></h6>
                            <div id="releaseNoteDetails" style="padding:10px; background-color:#f8f9fa; border:1px solid #dee2e6; border-radius:4px; min-height:50px; color:#555; word-wrap:break-word; overflow-wrap:break-word; overflow-x:hidden;">
                                <p style="margin:0;"></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Known Problems Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;"><%=MyBase.GetResourceString("C_KnownProblems")%></h6>
                            <div id="releaseNoteKnownProblems" style="padding:10px; background-color:#f8f9fa; border:1px solid #dee2e6; border-radius:4px; min-height:50px; color:#555; word-wrap:break-word; overflow-wrap:break-word; overflow-x:hidden;">
                                <p style="margin:0;"></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Installation Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;"><%=MyBase.GetResourceString("C_Installation")%></h6>
                            <div id="releaseNoteInstallation" style="padding:10px; background-color:#f8f9fa; border:1px solid #dee2e6; border-radius:4px; min-height:50px; color:#555; word-wrap:break-word; overflow-wrap:break-word; overflow-x:hidden;">
                                <p style="margin:0;"></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Issues and Concerns Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;"><%=MyBase.GetResourceString("C_Issues")%></h6>
                            <div id="releaseNoteIssues" style="padding:10px; background-color:#f8f9fa; border:1px solid #dee2e6; border-radius:4px; min-height:50px; color:#555; word-wrap:break-word; overflow-wrap:break-word; overflow-x:hidden;">
                                <p style="margin:0;"></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Testing Summary Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;"><%=MyBase.GetResourceString("C_TestingSummary")%></h6>
                            <div id="releaseNoteTestingSummary" style="padding:10px; background-color:#f8f9fa; border:1px solid #dee2e6; border-radius:4px; min-height:50px; color:#555; word-wrap:break-word; overflow-wrap:break-word; overflow-x:hidden;">
                                <p style="margin:0;"></p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Uploaded Files Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;"><%=MyBase.GetResourceString("C_UplFile")%></h6>
                            <div style="border:1px solid #dee2e6; border-radius:4px; overflow:hidden; overflow-x:hidden;">
                                <table class="table table-bordered mb-0" style="margin:0; background-color:#f8f9fa; width:100%; table-layout:auto;">
                                    <thead style="background-color:#f8f9fa;">
                                        <tr>
                                            <th style="padding:10px; border:1px solid #dee2e6; font-weight:bold; color:#333; word-wrap:break-word; overflow-wrap:break-word;">File Name</th>
                                            <th style="padding:10px; border:1px solid #dee2e6; font-weight:bold; color:#333; word-wrap:break-word; overflow-wrap:break-word;">Upload Date</th>
                                            <th style="padding:10px; border:1px solid #dee2e6; font-weight:bold; color:#333; word-wrap:break-word; overflow-wrap:break-word;">File Size</th>
                                        </tr>
                                    </thead>
                                    <tbody id="releaseNoteFilesTableBody">
                                        <tr>
                                            <td colspan="3" style="text-align:center; padding:15px; color:#999;">Loading files...</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <!-- Added By Vyankat B On 24-11-2025 - Pagination for Release Note Files -->
                                <div class="pagination-container" style="display: flex; align-items: center; justify-content: flex-end; gap: 0.5rem; margin-top: 7px; margin-bottom: 7px; padding: 0 15px;">
                                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                                        <span id="totalReleaseNoteFileRecords" style="color: #374151; font-size: 11.5px;">Total Records: 0</span>
                                        <button id="firstReleaseNoteFilePageBtn" onclick="goToPreviousReleaseNoteFilePage()" data-bs-toggle="tooltip" title="Previous Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                            <i class="fas fa-angle-double-left"></i>
                                        </button>
                                        <button id="lastReleaseNoteFilePageBtn" onclick="goToNextReleaseNoteFilePage()" data-bs-toggle="tooltip" title="Next Page" style="background: white; border: 1px solid #d1d5db; border-radius: 0.375rem; padding: 0.5rem 0.75rem; color: #3b82f6; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 40px; position: relative;">
                                            <i class="fas fa-angle-double-right"></i>
                                        </button>
                                    </div>
                                </div>
                                <!-- End of Added By Vyankat B On 24-11-2025 - Pagination for Release Note Files -->
                            </div>
                        </div>
                    </div>
                    
                    <!-- Customer Feedback Section -->
                    <div class="row mb-3" style="margin:0; overflow-x:hidden;">
                        <div class="col-sm-12" style="padding:0 15px; overflow-x:hidden;">
                            <h6 style="font-weight:500; color:#333; margin-bottom:8px;">Customer Feedback</h6>
                            <input type="text" id="releaseNoteCustomerFeedback" class="form-control" placeholder="<%=MyBase.GetResourceString("C_NoCusFeed")%>" style="padding:10px; background-color:#f8f9fa; border:1px solid #dee2e6; border-radius:4px; min-height:50px; color:#555; word-wrap:break-word; overflow-wrap:break-word; overflow-x:hidden;" readonly />
                        </div>
                    </div>
                    
                    <div class="row mt-4">
                        <div class="col-sm-12 text-end">
                            <button data-bs-dismiss="modal" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>" class="btn borderbtn"><%=MyBase.GetResourceString("C_Close")%></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Release Note modal end here-->
    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
    <div style="text-align: center">
     <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_AuthAlert")%></p>
    </div>
    </div>
    <%End If %>
    <!-- jQuery and Bootstrap JS -->
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <script type="text/javascript">
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';

        // --- REPLACE/ADD these variables at the top of your script ---
        var selectedReleaseIDs = []; // Keep for backward compatibility if needed, but we rely on the specific arrays below
        var globalIsSelectAll = false; // Tracks if "Select All" mode is active
        var globalSelectedIDs = [];    // For Manual Selection Mode
        var globalExcludedIDs = [];    // For Select All Mode (Items to exclude)
// -------------------------------------------------------------



        if (strUrl.endsWith('/')) {
            strUrl = strUrl.slice(0, -1);
        }
        
        // Added By Vyankat B On 24-11-2025 For site URL construction
        var hostName = '<%=System.Configuration.ConfigurationManager.AppSettings("HostName").ToString%>';
        var virtualDirectoryName = '<%=System.Configuration.ConfigurationManager.AppSettings("VirtualDirectoryName").ToString%>';
        var siteUrl = 'http://' + hostName + '/' + virtualDirectoryName + '/';
        // End of Added By Vyankat B On 24-11-2025 For site URL construction
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var SessionProjectID = '<%= Session("intProjectID") %>';

        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var AddAccess = '<%=m_blnAddAccess%>';
        alertify.set('notifier', 'position', 'top-right');

        var selectedReleaseID = 0;
        var selectedReleaseIDs = []; // Store selected items for deletion
        var totalRecords = 0;
        var isFirstSaveAndAddInEditMode = false; // Track if first Save and Add in edit mode
        var isInSaveAndAddWorkflowFromEdit = false; // Track if we're in Save and Add workflow that started from edit mode
        
        // Added By Vyankat B On 24 Nov 2025 For special character validation
        var invalidChars = WebConfigSpecialCharacters;
        
        // Added By Vyankat B On 24 Nov 2025 - Helper function to check for invalid characters using string contains method
        function hasInvalidChars(text) {
            if (!text || !invalidChars) return false;
            for (var i = 0; i < text.length; i++) {
                if (invalidChars.includes(text.charAt(i))) {
                    return true;
                }
            }
            return false;
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Helper function to check for invalid characters
        var isProjectFilterLoading = false; // Flag to prevent multiple simultaneous loads
        
        // Added By Vyankat B On 24 Nov 2025 - Pagination variables
        var currentPageNumber = 1;
        var totalPages = 1;
        var pageSize = 10;
        // End of Added By Vyankat B On 24 Nov 2025 - Pagination variables
        
        // Added By Vyankat B On 20-11-2025 - File pagination variables
        var currentFilePageNumber = 1;
        var totalFilePages = 1;
        var filePageSize = 5;
        var totalFileRecords = 0;
        // End of Added By Vyankat B On 20-11-2025
        
        // Added By Vyankat B On 24-11-2025 - Release Note File pagination variables
        var currentReleaseNoteFilePageNumber = 1;
        var totalReleaseNoteFilePages = 1;
        var releaseNoteFilePageSize = 5;
        var totalReleaseNoteFileRecords = 0;
        // End of Added By Vyankat B On 24-11-2025

        // Initialize page
        $(document).ready(function () {
            
            // Added By Vyankat B On 24 Nov 2025 - Check if user has view access, if not skip all function calls
            var hasViewAccess = ViewAccess === 'True' || ViewAccess === true || ViewAccess === 'true';
            var isViewAccessDivVisible = $('#ViewAccess').length > 0 && $('#ViewAccess').is(':visible');
            
            // If user doesn't have access, skip all function calls
            if (!hasViewAccess || isViewAccessDivVisible) {
                return; // Exit early, don't execute any functions
            }
            // End of Added By Vyankat B On 24 Nov 2025 - Check if user has view access
            
            // Initialize tooltips with auto-hide after less than 1 second
            $('[data-bs-toggle="tooltip"]').tooltip({
                delay: { show: 0, hide: 0 }
            }).on('shown.bs.tooltip', function() {
                var $this = $(this);
                // Auto-hide tooltip after 800ms (less than 1 second)
                setTimeout(function() {
                    $this.tooltip('hide');
                }, 800);
            });
            
            // Initialize selectpicker for all except ProjectFilter (to avoid double initialization)
            $('.selectpicker').not('#ProjectFilter').selectpicker();
            
            // Remove validation highlight when user starts typing
            $('#SubjectEdit, #ObjectivesEdit, #ReleaseItemsEdit, #KnownProblemsEdit, #InstallationEdit, #IssuesEdit, #TestingSummaryEdit').on('input', function() {
                $(this).removeClass('is-invalid');
            });
            
            // Remove validation highlight when user selects from dropdown
            $('#MilestoneEdit').on('change', function() {
                $('#MilestoneEdit').removeClass('is-invalid');
            });
            
            // Show Send Mail and Release Note buttons by default
            $('#ReleaseNoteBtn, #SendMailBtn').show();
            
            // Load projects for dropdown - it will initialize and populate ProjectFilter
            loadProjectsForReleases();
            
            // Handle offcanvas events to disable/enable project dropdown
            $('#offcanvas_EditRelease').on('shown.bs.offcanvas', function() {
                $('body').addClass('offcanvas-open');
                
                // Disable project dropdown when offcanvas is shown (keep visible but not interactive)
                var $projectFilter = $('#ProjectFilter');
                var $bsSelect = $('.bootstrap-select#ProjectFilter');
                if ($projectFilter.length > 0 && $bsSelect.length > 0) {
                    // Close dropdown if open
                    if ($bsSelect.hasClass('open')) {
                        $projectFilter.selectpicker('toggle');
                    }
                    // Remove focus from dropdown if it has focus
                    $bsSelect.find('.dropdown-toggle').blur();
                    // Disable the selectpicker
                    $projectFilter.prop('disabled', true);
                    $projectFilter.selectpicker('refresh');
                    // Remove any active/focus classes
                    $bsSelect.removeClass('open');
                    $bsSelect.find('.dropdown-toggle').removeClass('active focus');
                }
            });
            
            $('#offcanvas_EditRelease').on('hidden.bs.offcanvas', function () {
                // Remove class from body
                $('body').removeClass('offcanvas-open');
                
                // Enable project dropdown when offcanvas is hidden
                var $projectFilter = $('#ProjectFilter');
                var $bsSelect = $('.bootstrap-select#ProjectFilter');
                if ($projectFilter.length > 0 && $bsSelect.length > 0) {
                    // Enable the selectpicker
                    $projectFilter.prop('disabled', false);
                    $projectFilter.selectpicker('refresh');
                }
                $('#deleteReleaseFormBtn').hide();
                
            });
            
            // Prevent dropdown from opening when clicking outside the dropdown button
            // Use capture phase to check early, but don't prevent toggle button clicks
            $(document).on('click', function (e) {
                var $target = $(e.target);
                var $bootstrapSelect = $('.bootstrap-select#ProjectFilter');
                var $projectFilter = $('#ProjectFilter');
                
                // Check if click is directly on the dropdown toggle button FIRST - allow it
                var isClickOnToggle = $target.closest('.bootstrap-select#ProjectFilter .dropdown-toggle').length > 0 ||
                                     $target.is('.bootstrap-select#ProjectFilter .dropdown-toggle') ||
                                     $target.closest('.dropdown-toggle').length > 0 ||
                                     $target.is('.dropdown-toggle');
                
                // Check if click is on the dropdown menu items (allow these to work normally)
                var isClickOnMenuItem = $target.closest('.bootstrap-select#ProjectFilter .dropdown-menu .dropdown-item').length > 0 ||
                                       $target.is('.bootstrap-select#ProjectFilter .dropdown-menu .dropdown-item');
                
                // Check if click is on the search input or search button
                var isClickOnSearch = $target.closest('#searchInput').length > 0 || 
                                     $target.closest('#searchBtn').length > 0 ||
                                     $target.is('#searchInput') || 
                                     $target.is('#searchBtn');
                
                // Check if click is on New Release button or other buttons
                var isClickOnButton = $target.closest('button').length > 0 || 
                                     $target.closest('a.btn').length > 0 ||
                                     $target.is('button') || 
                                     $target.is('a.btn');
                
                // If clicking on toggle button or menu items, don't interfere - let selectpicker handle it
                if (isClickOnToggle || isClickOnMenuItem) {
                    return; // Exit early - don't prevent the event
                }
                
                // If clicking outside dropdown (not on toggle, menu items, search, or buttons), remove focus
                if (!isClickOnToggle && !isClickOnMenuItem && !isClickOnSearch && !isClickOnButton) {
                    if ($bootstrapSelect.length > 0) {
                        var $toggle = $bootstrapSelect.find('.dropdown-toggle');
                        if ($toggle.length > 0 && ($toggle.is(':focus') || $bootstrapSelect.hasClass('open'))) {
                            // Only blur if dropdown is not open (to allow menu item clicks)
                            if (!$bootstrapSelect.hasClass('open')) {
                                $toggle.blur();
                                $toggle.removeClass('active focus');
                            }
                        }
                    }
                }
                
                // Only process if bootstrap-select exists
                if ($bootstrapSelect.length > 0 && $projectFilter.length > 0) {
                    var dropdownOffset = $bootstrapSelect.offset();
                    if (dropdownOffset) {
                        var dropdownWidth = 250; // Fixed width
                        var dropdownHeight = $bootstrapSelect.outerHeight();
                        var dropdownLeft = dropdownOffset.left;
                        var dropdownRight = dropdownLeft + dropdownWidth;
                        var dropdownTop = dropdownOffset.top;
                        var dropdownBottom = dropdownTop + dropdownHeight;
                        
                        var clickX = e.pageX;
                        var clickY = e.pageY;
                        
                        // Check if click is within the strict 250px boundary of the dropdown
                        var isClickWithinDropdown = clickX >= dropdownLeft && 
                                                   clickX <= dropdownRight && 
                                                   clickY >= dropdownTop && 
                                                   clickY <= dropdownBottom;
                        
                        // If click is outside the 250px boundary, close dropdown if open and remove focus
                        if (!isClickWithinDropdown && !isClickOnSearch) {
                            // Close dropdown if open
                            if ($bootstrapSelect.hasClass('open')) {
                                $projectFilter.selectpicker('toggle');
                            }
                            // Remove focus
                            var $toggle = $bootstrapSelect.find('.dropdown-toggle');
                            if ($toggle.length > 0) {
                                $toggle.blur();
                                $toggle.removeClass('active focus');
                            }
                            // Don't prevent - just close if needed
                            return;
                        }
                        
                        // If click is within dropdown but NOT on toggle button, prevent opening
                        // BUT only if dropdown is not already open (to allow menu item clicks)
                        // AND only if we're certain it's not a toggle button click
                        if (isClickWithinDropdown && !isClickOnToggle && !isClickOnMenuItem) {
                            // If dropdown is not open, prevent it from opening
                            if (!$bootstrapSelect.hasClass('open')) {
                                e.stopPropagation();
                                e.preventDefault();
                                return false;
                            }
                        }
                    }
                }
            });
            
            // Prevent dropdown from opening via selectpicker's own events when clicking outside
            $(document).on('hide.bs.select', '#ProjectFilter', function(e) {
                // Remove focus when dropdown is hidden
                var $bsSelect = $('.bootstrap-select#ProjectFilter');
                if ($bsSelect.length > 0) {
                    $bsSelect.find('.dropdown-toggle').blur();
                    $bsSelect.removeClass('open');
                    $bsSelect.find('.dropdown-toggle').removeClass('active focus');
                }
                // Allow normal hide behavior
                return true;
            });
            
            // Prevent show event when clicking in unwanted areas
            // ONLY allow clicks on the toggle button - default is PREVENT
            $(document).on('show.bs.select', '#ProjectFilter', function(e) {
           
                // First check if offcanvas is open - if so, prevent dropdown from opening
                var $offcanvas = $('#offcanvas_EditRelease');
                if ($offcanvas.length > 0 && $offcanvas.hasClass('show')) {
                    e.preventDefault();
                    return false;
                }
                
                // Get the element that triggered the event
                var $trigger = $(e.relatedTarget || document.activeElement || e.target);
                var $bootstrapSelect = $('.bootstrap-select#ProjectFilter');
                
                // Check if the trigger is the dropdown toggle button or its children
                var isClickOnToggle = $trigger.closest('.bootstrap-select#ProjectFilter .dropdown-toggle').length > 0 ||
                                     $trigger.is('.bootstrap-select#ProjectFilter .dropdown-toggle') ||
                                     $trigger.closest('.dropdown-toggle').length > 0 ||
                                     $trigger.is('.dropdown-toggle') ||
                                     $trigger.hasClass('dropdown-toggle');
                
                // ONLY allow if click is on the dropdown toggle button
                if (isClickOnToggle) {
                    // But still check if offcanvas is open
                    if ($offcanvas.length > 0 && $offcanvas.hasClass('show')) {
                        e.preventDefault();
                        return false;
                    }
                    // Allow the dropdown to open - don't prevent
                    return;
                }
                
                // Check if click is on the search input or search button (prevent dropdown from opening)
                var isClickOnSearch = $trigger.closest('#searchInput').length > 0 || 
                                     $trigger.closest('#searchBtn').length > 0 ||
                                     $trigger.is('#searchInput') || 
                                     $trigger.is('#searchBtn');
                
                // Prevent dropdown from opening if clicking on search box
                if (isClickOnSearch) {
                    e.preventDefault();
                    return false;
                }
                
                // Check click position to prevent opening when clicking outside 250px boundary
                if ($bootstrapSelect.length > 0) {
                    var dropdownOffset = $bootstrapSelect.offset();
                    if (dropdownOffset) {
                        var dropdownWidth = 250;
                        var dropdownLeft = dropdownOffset.left;
                        var dropdownRight = dropdownLeft + dropdownWidth;
                        var dropdownHeight = $bootstrapSelect.outerHeight();
                        var dropdownTop = dropdownOffset.top;
                        var dropdownBottom = dropdownTop + dropdownHeight;
                        
                        // Try to get click position from various event sources
                        var clickX = e.pageX || 
                                    (e.originalEvent && e.originalEvent.pageX) ||
                                    (window.event && window.event.pageX);
                        var clickY = e.pageY || 
                                    (e.originalEvent && e.originalEvent.pageY) ||
                                    (window.event && window.event.pageY);
                        
                        // Check if click is within the strict 250px x height boundary
                        var isClickWithinStrictBoundary = clickX && clickY &&
                                                          clickX >= dropdownLeft && 
                                                          clickX <= dropdownRight &&
                                                          clickY >= dropdownTop && 
                                                          clickY <= dropdownBottom;
                        
                        // If click is outside 250px boundary OR outside height boundary, prevent dropdown from opening
                        if (clickX && (clickX > dropdownRight || clickX < dropdownLeft || 
                            (clickY && (clickY > dropdownBottom || clickY < dropdownTop)))) {
                            e.preventDefault();
                            return false;
                        }
                        
                        // If click is within dropdown boundary but NOT on toggle button, prevent opening
                        if (isClickWithinStrictBoundary && !isClickOnToggle) {
                            e.preventDefault();
                            return false;
                        }
                    }
                }
                
                // Default: PREVENT the dropdown from opening
                // Only allow if explicitly clicking on the toggle button
                e.preventDefault();
                return false;
            });
            
            
            // Added By Vyankat B On 24-11-2025 - Add Enter key support for search input
            $('#searchInput').on('keypress', function(e) {
                if (e.which === 13) { // Enter key
                    e.preventDefault();
                    handleSearchInput();
                }
            });
            // End of Added By Vyankat B On 24-11-2025
            
            // Add event listener for project dropdown change
            $('#ProjectFilter').on('change', function () {
                var selectedProjectID = $(this).val();
                var projectID = parseInt(selectedProjectID) || 0;
                
                // Reset to first page when project changes
                currentPageNumber = 1;
                
                // Added By Vyankat B On 24-11-2025 - Clear search when project changes
                $('#searchInput').val('');
                // End of Added By Vyankat B On 24-11-2025
                
                // If "Select Project" (projectID = 0 or empty) is selected, clear the table
                if (!selectedProjectID || selectedProjectID === '' || projectID === 0) {
                    // Store current table width before destroying
                    var $table = $('#ReleasesTbl');
                    var tableWidth = $table.width() || $table.parent().width() || '100%';

                    // Clear the table
                    if ($.fn.DataTable.isDataTable('#ReleasesTbl')) {
                        $('#ReleasesTbl').DataTable().destroy();
                    }
                    $("#ReleasesTbl_body").empty();

                    // Preserve table width
                    $table.css({
                        'width': tableWidth,
                        'min-width': tableWidth,
                        'max-width': '100%',
                        'table-layout': 'auto'
                    });

                    // Reinitialize DataTable with empty state - preserve column widths
                    $("#ReleasesTbl").DataTable({
                        paging: true,
                        pageLength: pageSize,
                        searching: false,
                        ordering: false,
                        info: true,
                        autoWidth: false,
                        scrollX: false,
                        //scrollCollapse: false,
                        columnDefs: [
                            { width: "auto", targets: [0, 1, 2] },
                            { width: "40px", targets: [3] }
                        ],
                        language: {
                            emptyTable: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>"
                        }
                    });

                    // Force table width to remain stable after DataTable initialization
                    setTimeout(function () {
                        $table.css({
                            'width': tableWidth,
                            'min-width': tableWidth,
                            'max-width': '100%',
                            'table-layout': 'fixed'
                        });
                    }, 100);

                    // Reset pagination
                    totalRecords = 0;
                    totalPages = 1;
                    currentPageNumber = 1;
                    updateTotalRecords();
                    updatePaginationButtons();

                    $('#NewReleaseBtn').hide(); //Added By Vaibhav K for hiding new release btn on  05/02/25

                    return; // Don't load data
                }
                //Added By Vaibhav K for showing new release btn on  05/02/25
                else {
                    $('#NewReleaseBtn').show();
                }
                //End of  Added By Vaibhav K for showing new release btn on  05/02/25

                //Added By Vaibhav K On 04-02-26 for Milestone dropdown
                // Reset milestone dropdown for the new project
                bindMilestones(selectedProjectID, 0);
                // End of Added By Vaibhav K On 04-02-26 for Milestone dropdown
                
                // Reload releases data when valid project is selected
                GetAllReleases();
            });
            // End of Added By Vyankat B On 24 Nov 2025 - Project dropdown change handler
            
            GetAllReleases();

            // Initialize Uploaded Files DataTable
            // Only initialize DataTable if table has proper structure
            var $uploadedFilesTable = $("#UploadedFilesTbl");
            if ($uploadedFilesTable.length && $uploadedFilesTable.find('thead tr th').length === 7) {
                // Destroy existing DataTable if it exists
                if ($.fn.DataTable.isDataTable('#UploadedFilesTbl')) {
                    $('#UploadedFilesTbl').DataTable().destroy();
                }
                
                // Only initialize if tbody has rows or is empty (not if it has invalid structure)
                var tbodyRows = $uploadedFilesTable.find('tbody tr').length;
                if (tbodyRows === 0 || $uploadedFilesTable.find('tbody tr td').length % 7 === 0) {
                    $("#UploadedFilesTbl").dataTable({
                        paging: false,
                        pageLength: 10,
                        bLengthChange: false,
                        bFilter: false,
                        ordering: false,
                        responsive: false,
                        destroy: true,
                        retrieve: true,
                        info: false,
                        bPaginate: false,
                        columnDefs: [
                            { "width": "8%", "targets": 0 },
                            { "width": "20%", "targets": 1 },
                            { "width": "12%", "targets": 2 },
                            { "width": "15%", "targets": 3 },
                            { "width": "15%", "targets": 4 },
                            { "width": "20%", "targets": 5 },
                            { "width": "10%", "targets": 6 }
                        ]
                    });
                }
            }

            // Initialize datepicker
            $('#DateEdit, #DateFilter').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                yearRange: "2005:2035",
                dateFormat: 'dd-M-yy',
                defaultDate: new Date() // Set today's date as default
            });
            
            // Set today's date as default value for DateEdit
            var today = new Date();
            var formattedDate = $.datepicker.formatDate('dd-M-yy', today);
            $('#DateEdit').val(formattedDate);

            document.querySelectorAll(".drop-zone__input").forEach((inputElement) => {
                const dropZoneElement = inputElement.closest(".drop-zone");

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

                    if (e.dataTransfer.files.length) {
                        inputElement.files = e.dataTransfer.files;
                        updateThumbnail(dropZoneElement, e.dataTransfer.files[0]);
                    }

                    dropZoneElement.classList.remove("drop-zone--over");
                });
            });

            function updateThumbnail(dropZoneElement, file) {
                let thumbnailElement = dropZoneElement.querySelector(".drop-zone__thumb");
                // First time - remove the prompt
                if (dropZoneElement.querySelector(".drop-zone__prompt")) {
                    dropZoneElement.querySelector(".drop-zone__prompt").remove();
                }
                // First time - there is no thumbnail element, so lets create it
                if (!thumbnailElement) {
                    thumbnailElement = document.createElement("div");
                    thumbnailElement.classList.add("drop-zone__thumb");
                    dropZoneElement.appendChild(thumbnailElement);
                }
                thumbnailElement.dataset.label = file.name;
                // Show thumbnail for image files
                if (file.type.startsWith("image/")) {
                    const reader = new FileReader();

                    reader.readAsDataURL(file);
                    reader.onload = () => {
                        thumbnailElement.style.backgroundImage = `url('${reader.result}')`;
                    };
                } else {
                    thumbnailElement.style.backgroundImage = null;
                }
                // Reset drop-zone when UploadDocumentModal opens/closes
                $('#UploadDocumentModal').on('show.bs.modal shown.bs.modal hidden.bs.modal', function () {
                    var $dz = $(this).find('.drop-zone');
                    if ($dz.length === 0) return;
                    var $input = $dz.find('.drop-zone__input');

                    // Remove any thumbnail(s)
                    $dz.find('.drop-zone__thumb').remove();

                    // Ensure the prompt span exists
                    if ($dz.find('.drop-zone__prompt').length === 0) {
                        // add prompt at the beginning of drop-zone
                        $dz.prepend('<span class="drop-zone__prompt">Drop file here or click to upload</span>');
                    }
                    // Clear the file input (works for most browsers). For full reset replace input element if needed.
                    try {
                        $input.val('');
                        // also clear files property for some browsers
                        if ($input[0] && $input[0].files) $input[0].files = null;
                    } catch (e) {
                        // fallback: replace the input element with a clone
                        var $clone = $input.clone().val('');
                        $input.replaceWith($clone);
                    }
                });
            }
            updateTotalRecords();
            updatePaginationButtons();
            // Ensure New Release button click handler is attached
            $('#NewReleaseBtn').off('click').on('click', function (e) {
                e.preventDefault();
                // Remove focus from project dropdown immediately when button is clicked
                var $projectFilter = $('#ProjectFilter');
                var $bsSelect = $('.bootstrap-select#ProjectFilter');
               
                    $bsSelect.find('.dropdown-toggle').blur();
                    $bsSelect.removeClass('open');
                    $bsSelect.find('.dropdown-toggle').removeClass('active focus');
               
                openNewReleaseForm();
            });
        });

        // Added By Vyankat B On 24 Nov 2025 - Function to load projects for dropdown
        function loadProjectsForReleases() {
            // Prevent multiple simultaneous calls
            if (isProjectFilterLoading) {
                return;
            }
            
            try {
                isProjectFilterLoading = true;
                
                // Get the dropdown element
                var projectDropdown = document.getElementById('ProjectFilter');
                if (!projectDropdown) {
                    isProjectFilterLoading = false;
                    return;
                }
                var $projectDropdown = $(projectDropdown);

                $projectDropdown.removeClass('selectpicker');

                //if ($projectDropdown.data('selectpicker')) {
                //    try {
                //        $projectDropdown.selectpicker('destroy');
                //    } catch (e) {
                //    }
                //}
                
                $('.bootstrap-select#ProjectFilter').remove();
                $projectDropdown.next('.bootstrap-select').remove();
                $projectDropdown.parent().find('.bootstrap-select').remove();
                $projectDropdown.siblings('.bootstrap-select').remove();
                
                $projectDropdown.show().removeAttr('data-selectpicker-id');
                
                $projectDropdown.prop('disabled', true);

                //Commented by Vaibhav K on 05-02-25
                //projectDropdown.innerHTML = '<option value=""><%=MyBase.GetResourceString("C_SelProject")%></option>';
                //End of Commented by Vaibhav K on 05-02-25

                var param = {
                    UserId: parseInt(SessionEmployeeId) || 0,
                    LoginType: SessionLoginType || 'E'
                };

                param = JSON.stringify(param);

                var url = "/api/PM_Releases/GetProjects";
          
                var result = AJAXCallWithResult(url, param, false);

                    var projectsArray = null;

                    if (result && Array.isArray(result.projects.projectEntity)) {
                        projectsArray = result.projects.projectEntity;
                    }
                   
                    // Get session project ID before binding

                    var defaultProjectID = parseInt(SessionProjectID) || 0;
                    var sessionProjectFound = false;
                    
                    // Bind projects to dropdown
                    if (projectsArray && projectsArray.length > 0) {
                        projectsArray.forEach(function(project) {
                            // Handle both camelCase and PascalCase property names
                            var projectID = project.projectID;
                            var projectName = project.projectName;
                            
                            // Skip the placeholder option (projectID = 0) as we already have "Select Project" option
                            if (projectName && projectName.trim() !== '') {
                                var option = document.createElement('option');
                                option.value = projectID;
                                option.textContent = projectName;
                                projectDropdown.appendChild(option);
                                
                                // Check if this is the session project while building the list
                                if (defaultProjectID > 0 && parseInt(projectID) === defaultProjectID) {
                                    sessionProjectFound = true;
                                }
                            }
                        });
                    }
              
                setTimeout(function() {
                    // Ensure no existing instance exists
                    if ($projectDropdown.data('selectpicker')) {
                        try {
                            $projectDropdown.selectpicker('destroy');
                        } catch (e) {
                        }
                    }

                    $projectDropdown.next('.bootstrap-select').remove();
                    $projectDropdown.siblings('.bootstrap-select').remove();

                    $projectDropdown.prop('disabled', false);

                    $projectDropdown.selectpicker({
                        title: 'Select Project',
                        noneSelectedText: 'Select Project',
                        width: '250px',
                        style: 'btn-default',
                        liveSearch: true,
                        container: 'body'
                    });
                    
                    setTimeout(function() {
                        var $bsSelect = $('.bootstrap-select#ProjectFilter');
                        if ($bsSelect.length > 0) {
                            $bsSelect.find('.dropdown-menu').css({
                                'max-width': '250px',
                                'width': '250px',
                                'box-sizing': 'border-box'
                            });
                        }
                    }, 50);

                    if (defaultProjectID > 0 && sessionProjectFound) {
                        projectDropdown.value = defaultProjectID.toString();
                        $projectDropdown.selectpicker('refresh');
                        $projectDropdown.trigger('change');
                    }
                }, 50);
                
            } catch (error) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ErrorLoad")%>');
            } finally {             
                setTimeout(function() {
                    isProjectFilterLoading = false;
                }, 100);
            }
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to load projects for dropdown

        // Added By Vyankat B On 24 Nov 2025 - Updated GetAllReleases function with pagination and project filter
        function GetAllReleases() {
            var selectedProjectID = $('#ProjectFilter').val();
            selectedProjectID = parseInt(selectedProjectID) || parseInt(SessionProjectID) || 0;
            
            var searchText = $('#searchInput').val() || '';
            if (searchText.trim() === '') {
                searchText = null;
            } else {
                searchText = searchText.trim();
            }
            
            var ReleaseParameters = {
                ProjectID: selectedProjectID,
                PageNumber: currentPageNumber,
                PageSize: pageSize,
                SearchText: searchText
            };
            
            if ($.fn.DataTable.isDataTable('#ReleasesTbl')) {
                $('#ReleasesTbl').DataTable().destroy();
            }
            
            $("#ReleasesTbl_body").empty();
            
            var param = JSON.stringify(ReleaseParameters);
            var response = AJAXCallWithResult("/api/PM_Releases/GetAllReleases", param, false);
            
        
            if (response && response.data) {
              
                var responseData = response.data;
                
                // Handle different response structures
                var data = null;
                var pagination = null;
                            
                if (Array.isArray(responseData)) {
                    data = responseData;
                    pagination = response.pagination || null;
                }
                            
                // Update pagination info if available
                if (pagination) {
                    totalRecords = pagination.totalRecords || 0;
                    totalPages = pagination.totalPages || 1;
                    currentPageNumber = pagination.currentPage || currentPageNumber;
                } else {
                    totalRecords = 0;
                    totalPages = 1;
                }
                
                // Bind data to table
                var tbody = $("#ReleasesTbl_body");
                if (data && Array.isArray(data) && data.length > 0) {
                    data.forEach(function(release) {
                        var releaseId =release.releaseID;
                        var row = $('<tr>').attr('data-id', releaseId);
                        
                        // Subject column
                        row.append($('<td>').text(release.subject || ''));
                        
                        // Release Note column
                        row.append($('<td>').text(release.releaseNote || ''));
                        
                        // Date column - format as dd/MM/yyyy
                        var releaseDate = release.releaseDate || '';
                        var formattedDate = '';
                        if (releaseDate) {
                            try {
                                var dateObj = new Date(releaseDate);
                                if (!isNaN(dateObj.getTime())) {
                                    // Format as dd/MM/yyyy
                                    var day = String(dateObj.getDate()).padStart(2, '0');
                                    var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                                    var year = dateObj.getFullYear();
                                    formattedDate = day + '/' + month + '/' + year;
                                }
                            } catch (e) {
                            }
                        }
                        row.append($('<td>').text(formattedDate));
                        
                        // Checkbox column (last column)
                        var checkboxCell = $('<td>');
                        if (DeleteAccess === 'True') {
                            var checkbox = $('<input>')
                                .attr('type', 'checkbox')
                                .addClass('chcktbl')
                                .attr('data-id', releaseId)
                                .attr('value', releaseId);
                            checkboxCell.append(checkbox);
                        } else {
                            checkboxCell.text('');
                        }
                        row.append(checkboxCell);
                        
                        tbody.append(row);
                    });
                }
                // If no data, tbody remains empty - DataTable will automatically show emptyTable message
                
                // Initialize DataTable - it will automatically show emptyTable message if tbody is empty
                $("#ReleasesTbl").DataTable({
                    paging: false,
                    pageLength: 10,
                    bLengthChange: false,
                    bFilter: false,
                    ordering: false,
                    responsive: false,
                    destroy: true,
                    retrieve: true,
                    info: false,
                    bPaginate: false,
                    autoWidth: false,
                    scrollX: false,
                    scrollCollapse: false,
                    language: {
                        emptyTable: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>",
                        zeroRecords: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>"
                    },
                    columnDefs: [
                        { "width": "30%", "targets": 0 },
                        { "width": "30%", "targets": 1 },
                        { "width": "30%", "targets": 2 },
                        { "width": "10%", "targets": 3 }
                    ]
                });
                
                // Force table width to remain stable after DataTable initialization
                setTimeout(function() {
                    $('#ReleasesTbl').css({
                        'table-layout': 'fixed',
                        'width': '100%'
                    });
                }, 100);
            } else {
                // No data or error
                totalRecords = 0;
                totalPages = 1;

                $("#ReleasesTbl").DataTable({
                    paging: false,
                    pageLength: 10,
                    bLengthChange: false,
                    bFilter: false,
                    ordering: true,
                    responsive: false,
                    destroy: true,
                    retrieve: true,
                    info: false,
                    bPaginate: false,
                    autoWidth: false,
                    scrollX: false,
                    scrollCollapse: false,
                    language: {
                        emptyTable: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>",
                        zeroRecords: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>"
                    },
                    columnDefs: [
                        { "width": "30%", "targets": 0 },
                        { "width": "30%", "targets": 1 },
                        { "width": "30%", "targets": 2 },
                        { "width": "10%", "targets": 3 }
                    ]
                });

                setTimeout(function() {
                    $('#ReleasesTbl').css({
                        'table-layout': 'fixed',
                        'width': '100%'
                    });
                }, 100);
            }

            restoreCheckboxState();
            updateTotalRecords();
            updatePaginationButtons();
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Updated GetAllReleases function

       //  Added By Vaibhav K On 04 - 02 - 26 for bulk delete

        function restoreCheckboxState() {
            $('.chcktbl').each(function () {
                var id = parseInt($(this).val());

                if (globalIsSelectAll) {
                    $(this).prop('checked', !globalExcludedIDs.includes(id));
                } else {
                    $(this).prop('checked', globalSelectedIDs.includes(id));
                }
            });

            updateHeaderCheckboxVisual();
        }
       //End ofAdded By Vaibhav K On 04 - 02 - 26 for bulk delete


        
        // Added By Vyankat B On 24 Nov 2025 - Pagination Functions
        function goToPreviousPage() {
            if (currentPageNumber > 1) {
                currentPageNumber = currentPageNumber - 1;
                GetAllReleases();
            }
        }

        function goToNextPage() {
            if (currentPageNumber < totalPages) {
                currentPageNumber = currentPageNumber + 1;
                GetAllReleases();
            }
        }

        function updateTotalRecords() {
            var totalRecordsElement = document.getElementById('totalRecords');
            if (!totalRecordsElement) return;            
            
            var recordCount = totalRecords || 0;
           
            if (recordCount === 0 && $.fn.DataTable.isDataTable('#ReleasesTbl')) {
                var info = $('#ReleasesTbl').DataTable().page.info();
                var dataTableCount = info.recordsTotal || 0;
        
                var noDataRows = $('#ReleasesTbl tbody tr.no-data-row').length;
                recordCount = Math.max(0, dataTableCount - noDataRows);
            } else if (recordCount === 0) {
     
                var table = document.getElementById('ReleasesTbl');
                if (table) {
                    var tbody = table.getElementsByTagName('tbody')[0];
                    var rows = tbody ? tbody.getElementsByTagName('tr') : [];
                    var noDataRows = tbody ? tbody.querySelectorAll('tr.no-data-row').length : 0;
                    recordCount = Math.max(0, rows.length - noDataRows);
                }
            }  
            totalRecordsElement.textContent = '<%=MyBase.GetResourceString("C_TotlRec")%>' + recordCount;
        }

        function updatePaginationButtons() {
            var firstBtn = document.getElementById('firstPageBtn');
            var lastBtn = document.getElementById('lastPageBtn');
            
            if (!firstBtn || !lastBtn) return;
            
            // Disable Previous button if on first page or no data
            if (currentPageNumber <= 1 || totalRecords === 0 || totalPages === 0) {
                firstBtn.disabled = true;
                firstBtn.style.opacity = '0.5';
                firstBtn.style.cursor = 'not-allowed';
                firstBtn.style.background = '#f8f9fa';
                firstBtn.style.color = '#6c757d';
            } else {
                firstBtn.disabled = false;
                firstBtn.style.opacity = '1';
                firstBtn.style.cursor = 'pointer';
                firstBtn.style.background = 'white';
                firstBtn.style.color = '#3b82f6';
            }
                
            // Disable Next button if on last page or no data
            if (currentPageNumber >= totalPages || totalRecords === 0 || totalPages === 0) {
                lastBtn.disabled = true;
                lastBtn.style.opacity = '0.5';
                lastBtn.style.cursor = 'not-allowed';
                lastBtn.style.background = '#f8f9fa';
                lastBtn.style.color = '#6c757d';
            } else {
                lastBtn.disabled = false;
                lastBtn.style.opacity = '1';
                lastBtn.style.cursor = 'pointer';
                lastBtn.style.background = 'white';
                lastBtn.style.color = '#3b82f6';
            }
        }
        // Update total records when table is drawn
        $('#ReleasesTbl').on('draw.dt', function() {
            updateTotalRecords();
            updatePaginationButtons();
        });
        // End of Added By Vyankat B On 24 Nov 2025 - Pagination Functions
        
        // Handle row click to open edit form - only when clicking on Subject column (first column)
        $(document).on('click', '#ReleasesTbl tbody tr td:first-child', function(e) {
            // Don't trigger if clicking on checkbox, checkbox cell, or button
            if ($(e.target).is('input[type="checkbox"]') || 
                $(e.target).closest('input[type="checkbox"]').length ||
                $(e.target).is('button') || 
                $(e.target).closest('button').length) {
                return;
            }
            
            var row = $(this).closest('tr');
            var releaseId = row.data('id') || 0;
            if (releaseId > 0) {
                selectedReleaseID = releaseId;
                // Load data and open edit form
                openEditReleaseForm(releaseId);
            }
        });
        
        // Added By Vyankat B On 24-11-2025 - Handle Release Note column click to open Release Note modal
        $(document).on('click', '#ReleasesTbl tbody tr td:nth-child(2)', function(e) {
            // Don't trigger if clicking on checkbox, checkbox cell, or button
            if ($(e.target).is('input[type="checkbox"]') || 
                $(e.target).closest('input[type="checkbox"]').length ||
                $(e.target).is('button') || 
                $(e.target).closest('button').length) {
                return;
            }
            
            var row = $(this).closest('tr');
            var releaseId = row.data('id') || 0;
            if (releaseId > 0) {
                selectedReleaseID = releaseId;
                // Open Release Note modal
                openReleaseNoteView();
            }
        });
        // End of Added By Vyankat B On 24-11-2025 - Handle Release Note column click
        
        // Function to handle delete button click - delete selected items
        $("#deleteReleaseBtn").click(function () {
            var selectedItems = [];
            $('.chcktbl:checked').each(function() {
                var releaseId = $(this).data('id') || $(this).val();
                if (releaseId) {
                    selectedItems.push(parseInt(releaseId));
                }
            });
            
            if (selectedItems.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("C_SelectAtLeastOne")%>');
                return;
            }
            
            // Store selected items for deletion
            selectedReleaseIDs = selectedItems;
            $('#deleteConfirm').modal('show');
        });
        // Added By Vyankat B On 24 Nov 2025 - Function to close delete confirmation modal
        function Close_deleteModel() {
            $("#deleteConfirm").modal("hide");
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to close delete confirmation modal

    //Commented and  Added By Vaibhav K On 04 - 02 - 26 for bulk delete

        // Added By Vyankat B On 24 Nov 2025 - Function to delete selected release records
       <%-- function DeleteRequestDetails() {
            var selectedIDs = selectedReleaseIDs || [];
            if (!selectedIDs || selectedIDs.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("C_SelectAtLeastOne")%>');
                Close_deleteModel();
                return;
            }
            
            // Convert array to comma-separated string for bulk delete
            var releaseIdsString = selectedIDs.join(',');
            
            // Prepare request for bulk delete
            var deleteParam = {
                ReleaseIds: releaseIdsString
            };
            
            var param = JSON.stringify(deleteParam);
            var response = AJAXCallWithResult("/api/PM_Releases/DeleteMultipleReleases", param, false);
            
            Close_deleteModel();
            
            // Check response - response format: { data: { deletedCount: number, message: string } }
            if (response && response.deletedCount > 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_ReDele")%>');

                // Clear selection
                selectedReleaseIDs = [];
                $('.chcktbl').prop('checked', false);
                $('#chkSelectAll').prop('checked', false);
                
                // Reload data
                GetAllReleases();
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_UnableDel")%>');
            }
        }--%>

        function DeleteRequestDetails() {
            var projectID = parseInt($('#ProjectFilter').val()) || 0;
            var searchText = $('#searchInput').val() || null;

            // CASE 1: Select All mode
            if (globalIsSelectAll === true) {
                if (!projectID || projectID <= 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Project ID is required for Select All delete.');
                    Close_deleteModel();
                    return;
                }

                var deleteParam = {
                    projectID: projectID,
                    isDeleteAll: true,
                    selectedReleaseIDs: null,
                    excludedReleaseIDs: globalExcludedIDs.length > 0 ? globalExcludedIDs.join(',') : null,
                    searchText: searchText
                };

                var param = JSON.stringify(deleteParam);

             var response = AJAXCallWithResult("/api/PM_Releases/DeleteMultipleReleases", param, false);

                Close_deleteModel();
                handleDeleteResponse(response);
                return;
            }

            // CASE 2: Manual selection
            // FIX: Use globalSelectedIDs instead of selectedReleaseIDs
            var selectedIDs = globalSelectedIDs || [];

            if (!selectedIDs || selectedIDs.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("C_SelectAtLeastOne")%>');
        Close_deleteModel();
        return;
    }

    var deleteParam = {
        projectID: projectID,
        isDeleteAll: false,
        selectedReleaseIDs: selectedIDs.join(','),
        excludedReleaseIDs: null,
        searchText: searchText
    };

    var param = JSON.stringify(deleteParam);
    var response = AJAXCallWithResult("/api/PM_Releases/DeleteMultipleReleases", param, false);

    Close_deleteModel();
    handleDeleteResponse(response);
}
        function handleDeleteResponse(response) {
          
            if (response.rowsAffected>0) {

                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_ReDele")%>');

        // Clear all delete state
        globalIsSelectAll = false;
        globalExcludedIDs = [];
        selectedReleaseIDs = [];

        $('.chcktbl').prop('checked', false);
        $('#chkSelectAll').prop('checked', false);

        GetAllReleases();
    } else {
        alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_UnableDel")%>');
            }
        }

    //End of Commented and  Added By Vaibhav K On 04 - 02 - 26 for bulk delete

        // Added By Vyankat B On 24 Nov 2025 - Function to open edit release form
        function openEditReleaseForm(releaseId) {
            selectedReleaseID = releaseId;
            isFirstSaveAndAddInEditMode = false; // Reset flag when opening edit form
            isInSaveAndAddWorkflowFromEdit = false; // Reset flag when opening edit form
            // Reset file pagination when opening edit form
            currentFilePageNumber = 1;
            totalFilePages = 1;
            totalFileRecords = 0;
            
            // Show buttons based on EditAccess for Edit mode
            var hasEditAccess = EditAccess === 'True' || EditAccess === true || EditAccess === 'true';
            var hasAddAccess = AddAccess === 'True' || AddAccess === true || AddAccess === 'true';
            
            if (hasEditAccess) {
                $('#saveReleaseBtn').show();
            } else {
                $('#saveReleaseBtn').hide();
            }
            
            if (hasEditAccess && hasAddAccess) {
                $('#saveandAddReleaseBtn').show();
            } else {
                $('#saveandAddReleaseBtn').hide();
            }
            
            // Show Release Note and Send Mail buttons in edit mode
            $('#ReleaseNoteBtn, #SendMailBtn').show();
            $('#deleteReleaseFormBtn').hide();

            
            // Show the file upload section in edit mode
            $('#UploadedFilesDetails').show();
            
            // Call API to get release data by ID
            var requestParam = {
                ReleaseID: releaseId
            };
            var param = JSON.stringify(requestParam);
            var response = AJAXCallWithResult("/api/PM_Releases/GetReleaseByID", param, false);
            
            // Open offcanvas first
            var offcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_EditRelease'));
            offcanvas.show();
            
            // Check if response is valid and populate form
            if (response && response.data) {

                var releaseData = null;
                if (response.data) {
                    releaseData = response.data;
                } 
                
                if (releaseData) {

                 // Added By Vaibhav K On 04-02-26 for Milestone dropdown
                    var projectID = releaseData.projectID || $('#ProjectFilter').val();
                    var milestoneID = releaseData.milestoneID || 0;

                    // Call API to load milestones, passing the current ID so the SP returns it even if closed
                    bindMilestones(projectID, milestoneID);
               // End of Added By Vaibhav K On 04-02-26 for Milestone dropdown
                 
                    var subject = releaseData.subject || '';
                    $('#SubjectEdit').val(subject);

                  
                    
                    var releaseDate = releaseData.releaseDate || '';
                    if (releaseDate) {
                        // Format date if it's a date string
                        var dateObj = new Date(releaseDate);
                        if (!isNaN(dateObj.getTime())) {
                            var formattedDate = $.datepicker.formatDate('dd-M-yy', dateObj);
                            $('#DateEdit').val(formattedDate);
                            $('#DateEdit').prop('disabled', true); // Disable Input
                        } else {
                            $('#DateEdit').val(releaseDate);
                        }
                    }
             

                    
                    var milestoneID = releaseData.milestoneID || 0;
                    if ($('#MilestoneEdit').length) {
                        $('#MilestoneEdit').val(milestoneID);
                        if (typeof $.fn.selectpicker !== 'undefined') {
                            $('#MilestoneEdit').selectpicker('refresh');
                        }
                    }
                    
                    var objectives = releaseData.objectives || '';
                    $('#ObjectivesEdit').val(objectives);
                    
                    var details = releaseData.details || '';
                    $('#ReleaseItemsEdit').val(details);
                    
                    var knownProblems = releaseData.knownProblems || '';
                    $('#KnownProblemsEdit').val(knownProblems);
                    
                    var installation = releaseData.installation || '';
                    $('#InstallationEdit').val(installation);
                    
                    var issues = releaseData.issues || '';
                    $('#IssuesEdit').val(issues);
                    
                    var testingSummary = releaseData.testingSummary || '';
                    $('#TestingSummaryEdit').val(testingSummary);
                
                    loadUploadedFiles();
                  
                }
            } else {
              
                if ($.fn.DataTable.isDataTable('#UploadedFilesTbl')) {
                    $('#UploadedFilesTbl').DataTable().destroy();
                }
                $('#UploadedFilesTbl tbody').empty();
              
                $('#UploadedFilesTbl tbody').append('<tr><td colspan="7" class="text-center"><%=MyBase.GetResourceString("C_NoDataAvaible")%></td></tr>');
                updateTotalFileRecords();
            }
        }
        
        // Function to open new release form
        function openNewReleaseForm() {
            isFirstSaveAndAddInEditMode = false; // Reset flag when opening new form
            isInSaveAndAddWorkflowFromEdit = false; // Reset flag when opening new form


            //Added by Vaibhav K for fixing access issue on 04-02-25 
                var hasAddAccess = AddAccess === 'True' || AddAccess === true || AddAccess === 'true';

                // Show buttons because user is in "Add" mode
                if (hasAddAccess) {
                    $('#saveReleaseBtn').show();
                    $('#saveandAddReleaseBtn').show();
            }
            //End of Added by Vaibhav K for fixing access issue on 04-02-25 

                //Added By Vaibhav K On 04-02-26 for Milestone dropdown
            var currentProjectID = $('#ProjectFilter').val() || SessionProjectID;

            // Load with 0 to show only active milestones
            bindMilestones(currentProjectID, 0);
                // End of Added By Vaibhav K On 04-02-26 for Milestone dropdown



            // Reset file pagination when opening new form
            currentFilePageNumber = 1;
            totalFilePages = 1;
            totalFileRecords = 0;
            // Immediately remove focus from project dropdown to prevent it from staying focused
            var $projectFilter = $('#ProjectFilter');
            var $bsSelect = $('.bootstrap-select#ProjectFilter');
            if ($projectFilter.length > 0 && $bsSelect.length > 0) {
                // Close dropdown if open
                if ($bsSelect.hasClass('open')) {
                    $projectFilter.selectpicker('toggle');
                }
                // Remove focus from dropdown immediately
                $bsSelect.find('.dropdown-toggle').blur();
                // Remove any active/focus classes immediately
                $bsSelect.removeClass('open');
                $bsSelect.find('.dropdown-toggle').removeClass('active focus');
            }

            
            // Clear the form for new entry
            clearReleaseForm();
            selectedReleaseID = 0;
            
            // Show buttons based on AddAccess for Add mode
            // In Add mode: Show Save button if AddAccess, Show Save and Add if AddAccess
            var hasAddAccess = AddAccess === 'True' || AddAccess === true || AddAccess === 'true';
            if (hasAddAccess) {
                $('#saveReleaseBtn').show();
                $('#saveandAddReleaseBtn').show();
            } else {
                $('#saveReleaseBtn').hide();
                $('#saveandAddReleaseBtn').hide();
            }
            
            // Hide Release Note button when creating new release (Send Mail should be visible)
            $('#ReleaseNoteBtn').hide();
            // Show Send Mail button even when creating new release
            $('#SendMailBtn').hide();
            
            $('#deleteReleaseFormBtn').hide();

            //Commented and Added fix by Vaibhav K on 02-02-25
            // Show the file upload section
            //$('#UploadedFilesDetails').show();
            $('#UploadedFilesDetails').hide();

             //Commented and Added fix by Vaibhav K on 02-02-25


            // Clear uploaded files list for new release
            if ($.fn.DataTable.isDataTable('#UploadedFilesTbl')) {
                $('#UploadedFilesTbl').DataTable().clear().draw();
            } else {
                $('#UploadedFilesTbl tbody').empty();
            }
            updateTotalFileRecords();
            
            // Open the offcanvas
            var offcanvasElement = document.getElementById('offcanvas_EditRelease');
            if (offcanvasElement) {
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                if (!offcanvas) {
                    offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                }
                offcanvas.show();
                // Add class to body immediately
                $('body').addClass('offcanvas-open');
                
                // Disable project dropdown when offcanvas opens (keep visible but not interactive)
                setTimeout(function() {
                    if ($projectFilter.length > 0 && $bsSelect.length > 0) {
                        // Ensure dropdown is closed and not focused
                        if ($bsSelect.hasClass('open')) {
                            $projectFilter.selectpicker('toggle');
                        }
                        // Remove focus from dropdown
                        $bsSelect.find('.dropdown-toggle').blur();
                        // Disable the selectpicker
                        $projectFilter.prop('disabled', true);
                        $projectFilter.selectpicker('refresh');
                        // Remove any active/focus classes
                        $bsSelect.removeClass('open');
                        $bsSelect.find('.dropdown-toggle').removeClass('active focus');
                    }
                }, 100);
            }
        }
        // Added By Vyankat B On 24 Nov 2025 - Function to clear release form
        function clearReleaseForm() {
            try {


                //Added By Vaibhav K On 04-02-26 for Milestone dropdown
                var currentProjectID = $('#ProjectFilter').val() || SessionProjectID;

                // Load with 0 to show only active milestones
                bindMilestones(currentProjectID, 0);
                // End of Added By Vaibhav K On 04-02-26 for Milestone dropdown

                if ($('#SubjectEdit').length) $('#SubjectEdit').val('');
                if ($('#DateEdit').length) {
                    // Set today's date as default
                    var today = new Date();
                    var formattedDate = $.datepicker.formatDate('dd-M-yy', today);
                    $('#DateEdit').val(formattedDate);



                    $('#DateEdit').prop('disabled', true); // Disable Input
                }
                if ($('#MilestoneEdit').length) {
                    $('#MilestoneEdit').val('0'); // Set to 0 to show "Select Milestone" from SP data
                    if (typeof $.fn.selectpicker !== 'undefined') {
                        $('#MilestoneEdit').selectpicker('refresh');
                    }
                }
                if ($('#ObjectivesEdit').length) $('#ObjectivesEdit').val('');
                if ($('#ReleaseItemsEdit').length) $('#ReleaseItemsEdit').val('');
                if ($('#KnownProblemsEdit').length) $('#KnownProblemsEdit').val('');
                if ($('#InstallationEdit').length) $('#InstallationEdit').val('');
                if ($('#IssuesEdit').length) $('#IssuesEdit').val('');
                if ($('#TestingSummaryEdit').length) $('#TestingSummaryEdit').val('');
                
                // Only reset selectedReleaseID if we're NOT in edit mode with Save and Add
                // Don't show Save button here - it's managed in saveRelease function
                // The Save button visibility is controlled by the saveRelease function based on Save and Add workflow
                if (!isFirstSaveAndAddInEditMode && selectedReleaseID === 0) {
                    // Only reset if we're in pure add mode (not coming from edit mode Save and Add)
                    // Save button visibility is handled in saveRelease, not here
                }
                // Note: Don't reset isFirstSaveAndAddInEditMode here - it's managed in saveRelease
            } catch (error) {
            }
        }
        // Function to save release
        function saveRelease(saveAndAdd) {
            // Validation
            // Get ProjectID from dropdown, fallback to session or default
            var projectID = $('#ProjectFilter').val() || SessionProjectID;
            projectID = parseInt(projectID);
            if (!projectID || projectID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ValidPID")%>');
                return;
            }

            // Clear previous validation highlights
            $('.form-control, textarea, select').removeClass('is-invalid');
            
            // Get CreatedBy/ModifiedBy from session
            var createdBy = UserName || SessionEmployeeId || '';
            if (!createdBy || createdBy.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_CreatedBy")%>');
                return;
            }
            
            // Validate Subject (mandatory)
            var subject = $('#SubjectEdit').val().trim();
            if (!subject) {
                $('#SubjectEdit').addClass('is-invalid');
                $('#SubjectEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Subje")%>');

             

              <%--  alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ErrorLoad")%>');--%>

                return;
            }
            // Added By Vyankat B On 24 Nov 2025 For special character validation
            if (hasInvalidChars(subject)) {
                $('#SubjectEdit').addClass('is-invalid');
                $('#SubjectEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<span style="font-size:11.5px;"><%= MyBase.GetResourceString("A_Sub")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                return;
            }
            // End of Added By Vyankat B On 24 Nov 2025 For special character validation
            
            // Validate Objectives (mandatory)
            var objectives = $('#ObjectivesEdit').val().trim();
            if (!objectives) {
                $('#ObjectivesEdit').addClass('is-invalid');
                $('#ObjectivesEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Obj")%>');
                return;
            }
            // Added By Vyankat B On 24 Nov 2025 For special character validation
            if (hasInvalidChars(objectives)) {
                $('#ObjectivesEdit').addClass('is-invalid');
                $('#ObjectivesEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<span style="font-size:11.5px;"><%= MyBase.GetResourceString("A_Obje")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                return;
            }
            // End of Added By Vyankat B On 24 Nov 2025 For special character validation
            
            // Validate ReleaseItems/Details (mandatory)
            var releaseItems = $('#ReleaseItemsEdit').val().trim();
            if (!releaseItems) {
                $('#ReleaseItemsEdit').addClass('is-invalid');
                $('#ReleaseItemsEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_RelItems")%>');
                return;
            }
            // Added By Vyankat B On 24 Nov 2025 For special character validation
            if (hasInvalidChars(releaseItems)) {
                $('#ReleaseItemsEdit').addClass('is-invalid');
                $('#ReleaseItemsEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<span style="font-size:11.5px;"><%= MyBase.GetResourceString("A_DeReIt")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                return;
            }
            // End of Added By Vyankat B On 24 Nov 2025 For special character validation
            
            // Validate KnownProblems (mandatory)
            var knownProblems = $('#KnownProblemsEdit').val().trim();
            if (!knownProblems) {
                $('#KnownProblemsEdit').addClass('is-invalid');
                $('#KnownProblemsEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_KnownProb")%>');
                return;
            }
            // Added By Vyankat B On 24 Nov 2025 For special character validation
            if (hasInvalidChars(knownProblems)) {
                $('#KnownProblemsEdit').addClass('is-invalid');
                $('#KnownProblemsEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<span style="font-size:11.5px;"><%= MyBase.GetResourceString("C_KnownProblems")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                return;
            }
            // End of Added By Vyankat B On 24 Nov 2025 For special character validation
            
            // Get optional fields
            var releaseDate = $('#DateEdit').val() || null;
            var milestoneID = $('#MilestoneEdit').val() || 0;
            milestoneID = parseInt(milestoneID) || 0;
            var installation = $('#InstallationEdit').val().trim() || null;
            var issues = $('#IssuesEdit').val().trim() || null;
            var testingSummary = $('#TestingSummaryEdit').val().trim() || null;
            
            // Added By Vyankat B On 24 Nov 2025 For mandatory validation - Installation field
            if (!installation || installation === '') {
                $('#InstallationEdit').addClass('is-invalid');
                $('#InstallationEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Install")%>');
                return;
            }
            // End of Added By Vyankat B On 24 Nov 2025 For mandatory validation - Installation field

            // Added By Vyankat B On 24 Nov 2025 For special character validation - Optional fields
            if (installation && installation !== '') {
                if (hasInvalidChars(installation)) {
                    $('#InstallationEdit').addClass('is-invalid');
                    $('#InstallationEdit').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<span style="font-size:11.5px;"><%= MyBase.GetResourceString("C_Installation")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                    return;
                }
            }
            
            // Added By Vyankat B On 24 Nov 2025 For mandatory validation - Issues field
            if (!issues || issues === '') {
                $('#IssuesEdit').addClass('is-invalid');
                $('#IssuesEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Issues")%>');
                return;
            }
            // End of Added By Vyankat B On 24 Nov 2025 For mandatory validation - Issues field

            if (issues && issues !== '') {
                if (hasInvalidChars(issues)) {
                    $('#IssuesEdit').addClass('is-invalid');
                    $('#IssuesEdit').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<span style="font-size:11.5px;"><%= MyBase.GetResourceString("C_Issues")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                       return;
                   }
            }

            // Added By Vyankat B On 24 Nov 2025 For mandatory validation - TestingSummary field
            if (!testingSummary || testingSummary === '') {
                $('#TestingSummaryEdit').addClass('is-invalid');
                $('#TestingSummaryEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_TesSum")%>');
                return;
            }
            // End of Added By Vyankat B
            
           
         
            if (testingSummary && testingSummary !== '') {
                if (hasInvalidChars(testingSummary)) {
                    $('#TestingSummaryEdit').addClass('is-invalid');
                    $('#TestingSummaryEdit').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<span style="font-size:11.5px;"><%= MyBase.GetResourceString("C_TestingSummary")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                    return;
                }
            }
            // End of Added By Vyankat B On 24 Nov 2025 For mandatory validation - TestingSummary field

            //Added By Vaibhav K On 04-02-2025 for char limit issue
            if (testingSummary.length > 2000) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_TestingSummaryLimit")%>');
                $('#TestingSummaryEdit').focus();
                return;
            }
           
            if (issues.length > 1000) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_IssuesLimit")%>');
                  $('#IssuesEdit').focus();
                 return;
             }
         //End of Added By Vaibhav K On 04-02-2025 for char limit issue


            
            // Convert releaseDate to Date object if provided (already validated above)
            var releaseDateObj = null;

            //Commented and added by Vaibhav K on 02-02-25 for fixing date time issue
            //if (releaseDate && releaseDate.trim() !== '') {
            //    releaseDateObj = new Date(releaseDate);
            //}

            if (releaseDate && releaseDate.trim() !== '') {
                try {
                    // 1. Parse using jQuery UI utility to ensure 'dd-M-yy' is read correctly
                    var dt = $.datepicker.parseDate('dd-M-yy', releaseDate);

                    // 2. Adjust for Timezone offset
                    // This effectively adds the timezone offset to the time, so when 
                    // JSON.stringify converts it back to UTC, it lands on the correct day (00:00:00 UTC)
                    if (dt) {
                        dt.setMinutes(dt.getMinutes() - dt.getTimezoneOffset());
                        releaseDateObj = dt;
                    }
                } catch (e) {
                    // Fallback if parsing fails
                    releaseDateObj = new Date(releaseDate);
                }
            }
            //End of  Commented and added by Vaibhav K on 02-02-25 for fixing date time issue

            
            // Check if we're in edit mode (selectedReleaseID > 0)
            // But if it's Save and Add and we've already done first update, treat as insert
            var isEditMode = false;
            if (selectedReleaseID && selectedReleaseID > 0) {
                // If Save and Add and already did first update, treat as insert
                if (saveAndAdd && isFirstSaveAndAddInEditMode) {
                    isEditMode = false;
                } else {
                    isEditMode = true;
                }
            }

                //Commented by Vaibhav K on 05-02-25 as it's hiding save button unnecessary
            // Hide Save button immediately when clicking Save and Add in edit mode
            //if (isEditMode && saveAndAdd) {
                //$('#saveReleaseBtn').hide();
                //$('button#saveReleaseBtn').hide();
                //$('button[id="saveReleaseBtn"]').hide();
                //$('button[onclick*="saveRelease(false)"]').hide();
            //}
                //End of Commented by Vaibhav K on 05-02-25 as it's hiding save button unnecessary

            
            // Prepare API call
            var apiUrl;
            var requestParams;
            
            if (isEditMode) {
                // Update mode - use UpdateRelease API
                apiUrl = "/api/PM_Releases/UpdateRelease";
                requestParams = {
                    ReleaseID: selectedReleaseID,
                    ProjectID: projectID,
                    Subject: subject,
                    ReleaseDate: releaseDateObj,
                    MilestoneID: milestoneID,
                    Objectives: objectives,
                    Details: releaseItems,
                    KnownProblems: knownProblems,
                    Installation: installation,
                    Issues: issues,
                    TestingSummary: testingSummary,
                    ModifiedBy: createdBy
                };
            } else {
                // Insert mode - use InsertRelease API
                apiUrl = "/api/PM_Releases/InsertRelease";
                requestParams = {
                    ProjectID: projectID,
                    Subject: subject,
                    ReleaseDate: releaseDateObj,
                    MilestoneID: milestoneID,
                    Objectives: objectives,
                    Details: releaseItems,
                    KnownProblems: knownProblems,
                    Installation: installation,
                    Issues: issues,
                    TestingSummary: testingSummary
                };
            }
            
            var param = JSON.stringify(requestParams);
            var response = AJAXCallWithResult(apiUrl, param, false);
            
            // Check response - handle both insert and update responses
            var isSuccess = false;
            if (isEditMode) {
                // Update response check
                if (response && response.success === true) {
                    isSuccess = true;
                }
            } else {
                // Insert response check
                if (response && response.success === true) {
                    isSuccess = true;
                }
                $('#saveReleaseBtn').show();

            }
            
            if (isSuccess) {
                // Added By Vyankat B On 20-11-2025 - Extract ReleaseID from response for file uploads
                var newReleaseID = selectedReleaseID;
                if (!isEditMode && response && response.releaseID) {
                    newReleaseID = parseInt(response.releaseID);
                }
                // Set selectedReleaseID so files can be uploaded
                if (newReleaseID > 0) {
                    selectedReleaseID = newReleaseID;
                }
                // End of Added By Vyankat B On 20-11-2025
                
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(isEditMode ? '<%=MyBase.GetResourceString("A_ReUpd")%>' : '<%=MyBase.GetResourceString("A_ReAdded")%>');
                
                // Handle edit mode with Save and Add
                if (selectedReleaseID && selectedReleaseID > 0 && saveAndAdd) {
                    if (!isFirstSaveAndAddInEditMode) {
                        isFirstSaveAndAddInEditMode = true;
                        isInSaveAndAddWorkflowFromEdit = true; 
                       
                    } else {
                        isFirstSaveAndAddInEditMode = false;
                        $('#saveReleaseBtn').hide();
                    }
                } else if (!saveAndAdd) {                 
                    isFirstSaveAndAddInEditMode = false;
                    isInSaveAndAddWorkflowFromEdit = false;
                    $('#saveReleaseBtn').show();                
                    loadUploadedFiles();
                } else {
                    if (isInSaveAndAddWorkflowFromEdit) {
                        $('#saveReleaseBtn').hide();
                    } else {                    
                        isFirstSaveAndAddInEditMode = false;
                        $('#saveReleaseBtn').show();
                    }                
                    loadUploadedFiles();
                }
                currentPageNumber = 1;
                GetAllReleases();
                
            if (saveAndAdd) {
                clearReleaseForm();
            } else {
                var offcanvas = bootstrap.Offcanvas.getInstance(document.getElementById('offcanvas_EditRelease'));
                if (offcanvas) {
                    offcanvas.hide();
                }
            }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SaveReles")%>');
            }
        }        
        // Added By Vyankat B On 24 Nov 2025 - Function to select all releases
        function selectAllReleases() {
            $('.chcktbl').prop('checked', true);
            updateSelectAllCheckbox();
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to select all releases
        
        // Added By Vyankat B On 24 Nov 2025 - Function to clear all releases
        function clearAllReleases() {
            $('.chcktbl').prop('checked', false);
            updateSelectAllCheckbox();
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to clear all releases
        
        // Added By Vyankat B On 24 Nov 2025 - Function to update select all checkbox state
        function updateSelectAllCheckbox() {
            var totalCheckboxes = $('.chcktbl').length;
            var checkedCheckboxes = $('.chcktbl:checked').length;
            
            // Update the select all checkbox state
            if (   totalCheckboxes > 0 && checkedCheckboxes === totalCheckboxes) {
                $('#chkSelectAll').prop('checked', true);
            } else {
                $('#chkSelectAll').prop('checked', false);
            }
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to update select all checkbox state
        
        // Check or Uncheck All checkboxes
        $(document).on('change', '.chckHead', function() {

         // Commented and  Added By Vaibhav K On 04-02-26 for bulk delete
            //var checked = $(this).is(":checked");
            //if (checked) {
            //    $(".chcktbl").each(function () {
            //        $(this).prop("checked", true);
            //    });
            //} else {
            //    $(".chcktbl").each(function () {
            //        $(this).prop("checked", false);
            //    });
            //}

            globalIsSelectAll = $(this).is(':checked');

            if (globalIsSelectAll) {
                globalExcludedIDs = [];
                globalSelectedIDs = [];
                $('.chcktbl').prop('checked', true);
            } else {
                globalSelectedIDs = [];
                $('.chcktbl').prop('checked', false);
            }
         // End of Commented and  Added By Vaibhav K On 04-02-26 for bulk delete

        });
        // Changing state of CheckAll checkbox when individual checkboxes are clicked
        $(document).on('change', '.chcktbl', function (e) {
            e.stopPropagation(); // Prevent row click event
            //Commented and Added By Vaibhav K On 04 - 02 - 26 for bulk delete
            var id = parseInt($(this).val());

            if (globalIsSelectAll) {
                if (!this.checked) {
                    if (!globalExcludedIDs.includes(id)) {
                        globalExcludedIDs.push(id);
                    }
                } else {
                    globalExcludedIDs = globalExcludedIDs.filter(x => x !== id);
                }
            } else {
                if (this.checked) {
                    if (!globalSelectedIDs.includes(id)) {
                        globalSelectedIDs.push(id);
                    }
                } else {
                    globalSelectedIDs = globalSelectedIDs.filter(x => x !== id);
                }
            }
            //updateSelectAllCheckbox();


            updateHeaderCheckboxVisual();




           
        });

       
        function updateHeaderCheckboxVisual() {
            var $head = $('#chkSelectAll');

            // If global select-all is ON but exclusions exist,
            // header should NOT stay checked (your expected behavior)
            if (globalIsSelectAll && globalExcludedIDs.length > 0) {
                $head.prop('checked', false);
               /* $head.prop('indeterminate', true); */ // optional (recommended)
                return;
            }

            // If global select-all is ON and no exclusions
            if (globalIsSelectAll) {
                $head.prop('checked', true);
                //$head.prop('indeterminate', false);
                return;
            }

            // Normal mode: page-based selection
            var $checks = $('.chcktbl:visible');
            if (!$checks.length) {
                //$head.prop('checked', false).prop('indeterminate', false);
                return;
            }

            var checked = $checks.filter(':checked').length;
            var total = $checks.length;

            $head.prop('checked', checked === total);
            //$head.prop('indeterminate', checked > 0 && checked < total);
        }

            //End of Commented and  Added By Vaibhav K On 04 - 02 - 26 for bulk delete


        // Added By Vyankat B On 24 Nov 2025 - Function to show delete modal
        function showDelModalRelease() {
            $('#deleteConfirm').modal('show');
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to show delete modal
        
        // Added By Vyankat B On 24 Nov 2025 - Function to delete the selected release
        function deleteTheSelectedRelease() {
            $('#deleteConfirm').modal('hide');
        }
        // Added By Vyankat B On 24-11-2025 - Function to handle search input for Subject, Release Note, and Date
        function handleSearchInput() {
            // Reset to first page when searching
            currentPageNumber = 1;
            // Call GetAllReleases with the search text
            GetAllReleases();
        }
        // End of Added By Vyankat B On 24-11-2025
       
        // Added By Vyankat B On 24 Nov 2025 - Function to handle Release Note link click
        function openReleaseNote(releaseID) {
            if (releaseID) {
                selectedReleaseID = releaseID;
                var offcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvas_EditRelease'));
                offcanvas.show();
            }
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to handle Release Note link click
        
        // Added By Vyankat B On 24 Nov 2025 - Function to open Release Note view
        function openReleaseNoteView() {
            // Check if release ID is selected
            if (!selectedReleaseID || selectedReleaseID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PlzSelNot")%>');
                return;
            }
            
            // Reset all sections to loading state
            $('#releaseNoteObjectives').html('<p style="margin:0; color:#999;">Loading...</p>');
            $('#releaseNoteDetails').html('<p style="margin:0; color:#999;">Loading...</p>');
            $('#releaseNoteKnownProblems').html('<p style="margin:0; color:#999;">Loading...</p>');
            $('#releaseNoteInstallation').html('<p style="margin:0; color:#999;">Loading...</p>');
            $('#releaseNoteIssues').html('<p style="margin:0; color:#999;">Loading...</p>');
            $('#releaseNoteTestingSummary').html('<p style="margin:0; color:#999;">Loading...</p>');
            $('#releaseNoteDateValue').text('Loading...');
            $('#releaseNoteFilesTableBody').html('<tr><td colspan="3" style="text-align:center; padding:15px; color:#999;">Loading files...</td></tr>');
            
            // Open modal
            var releaseNoteModal = new bootstrap.Modal(document.getElementById('ReleaseNoteModal'));
            releaseNoteModal.show();
            
            // Call API to get release data by ID
            var requestParam = {
                ReleaseID: selectedReleaseID
            };
            var param = JSON.stringify(requestParam);
            
            // Call GetReleaseByID API
            var response = AJAXCallWithResult("/api/PM_Releases/GetReleaseByID", param, false);
            
            // Process release data
            if (response && response.data) {
                var releaseData = null;
                
              if (response.data) {
                    releaseData = response.data;
                }
                
                if (releaseData) {
                    // Format and display date
                    var releaseDate = releaseData.ReleaseDate || releaseData.releaseDate || '';
                    if (releaseDate) {
                        try {
                            var dateObj = new Date(releaseDate);
                            if (!isNaN(dateObj.getTime())) {
                                // Format as dd/MM/yyyy
                                var day = String(dateObj.getDate()).padStart(2, '0');
                                var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                                var year = dateObj.getFullYear();
                                $('#releaseNoteDateValue').text(day + '/' + month + '/' + year);
                            } else {
                                $('#releaseNoteDateValue').text(releaseDate);
                            }
                        } catch (e) {
                            $('#releaseNoteDateValue').text(releaseDate);
                        }
                    } else {
                        $('#releaseNoteDateValue').text('N/A');
                    }
                    
                    // Populate Objectives
                    var objectives =releaseData.objectives || '';
                    $('#releaseNoteObjectives').html(objectives && objectives.trim() !== '' ? objectives.replace(/\n/g, '<br>') : '<p style="margin:0; color:#999;">-</p>');
                    
                    // Populate Details
                    var details = releaseData.details || '';
                    $('#releaseNoteDetails').html(details && details.trim() !== '' ? details.replace(/\n/g, '<br>') : '<p style="margin:0; color:#999;">-</p>');
                    
                    // Populate Known Problems
                    var knownProblems =releaseData.knownProblems || '';
                    $('#releaseNoteKnownProblems').html(knownProblems && knownProblems.trim() !== '' ? knownProblems.replace(/\n/g, '<br>') : '<p style="margin:0; color:#999;">-</p>');
                    
                    // Populate Installation
                    var installation =releaseData.installation || '';
                    $('#releaseNoteInstallation').html(installation && installation.trim() !== '' ? installation.replace(/\n/g, '<br>') : '<p style="margin:0; color:#999;">-</p>');
                    
                    // Populate Issues
                    var issues =releaseData.issues || '';
                    $('#releaseNoteIssues').html(issues && issues.trim() !== '' ? issues.replace(/\n/g, '<br>') : '<p style="margin:0; color:#999;">-</p>');
                    
                    // Populate Testing Summary
                    var testingSummary =releaseData.testingSummary || '';
                    $('#releaseNoteTestingSummary').html(testingSummary && testingSummary.trim() !== '' ? testingSummary.replace(/\n/g, '<br>') : '<p style="margin:0; color:#999;">-</p>');
                } else {
                    // Show error message in modal
                    $('#releaseNoteObjectives').html('<p style="margin:0; color:#dc3545;"><%=MyBase.GetResourceString("C_NoRelFound")%></p>');
                }
            } else {
                // Show error message in modal
                $('#releaseNoteObjectives').html('<p style="margin:0; color:#dc3545;"><%=MyBase.GetResourceString("C_FilLoadReleas")%></p>');
                $('#releaseNoteDateValue').text('Error');
            }
            
            // Load uploaded files (reset to page 1 when opening modal)
            currentReleaseNoteFilePageNumber = 1;
            loadReleaseNoteFiles(selectedReleaseID);
            
            // Load customer feedback
            loadReleaseNoteFeedback(selectedReleaseID);
        }
        
        // Function to load files for Release Note modal
        function loadReleaseNoteFiles(releaseID) {
            if (!releaseID || releaseID <= 0) {
                $('#releaseNoteFilesTableBody').html('<tr><td colspan="3" style="text-align:center; padding:15px; color:#999;"><%=MyBase.GetResourceString("C_NoFAvail")%></td></tr>');
                updateTotalReleaseNoteFileRecords();
                updateReleaseNoteFilePaginationButtons();
                return;
            }
            
            var requestParam = {
                ReleaseID: releaseID,
                PageNumber: currentReleaseNoteFilePageNumber,
                PageSize: releaseNoteFilePageSize
            };
            var param = JSON.stringify(requestParam);
            var response = AJAXCallWithResult("/api/PM_Releases/GetReleaseFiles", param, false);
            
            var files = [];
            var pagination = null;
            
            if (response) {

                if (response.data && Array.isArray(response.data)) {
                    files = response.data;
                    pagination = response.pagination || response.Pagination || null;
                }
            }
           
            // Update pagination info if available
            if (pagination) {
                totalReleaseNoteFileRecords = pagination.totalRecords|| 0;
                totalReleaseNoteFilePages = pagination.totalPages|| 1;
                currentReleaseNoteFilePageNumber = pagination.currentPage|| currentReleaseNoteFilePageNumber;
            } else if (files && files.length > 0) {
                // Fallback: if no pagination, use data length
                totalReleaseNoteFileRecords = files.length;
                totalReleaseNoteFilePages = Math.ceil(totalReleaseNoteFileRecords / releaseNoteFilePageSize) || 1;
            } else {
                totalReleaseNoteFileRecords = 0;
                totalReleaseNoteFilePages = 1;
            }
            
            // Ensure totalReleaseNoteFilePages is at least 1
            if (totalReleaseNoteFilePages < 1) {
                totalReleaseNoteFilePages = 1;
            }
            
            // Populate files table
            var tbody = $('#releaseNoteFilesTableBody');
            tbody.empty();
            
            if (files && files.length > 0) {
                files.forEach(function(file) {
                    var fileID = file.fileID || 0;
                    var fileName = file.fileName|| '';
                    var releaseDate = file.releaseDate|| '';
                    var fileSize = file.fileSize|| 0;
                    
                    // Format date
                    var formattedDate = '';
                    if (releaseDate) {
                        try {
                            var dateObj = new Date(releaseDate);
                            if (!isNaN(dateObj.getTime())) {
                                var day = String(dateObj.getDate()).padStart(2, '0');
                                var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                                var year = dateObj.getFullYear();
                                formattedDate = day + '/' + month + '/' + year;
                            } else {
                                formattedDate = releaseDate;
                            }
                        } catch (e) {
                            formattedDate = releaseDate;
                        }
                    } else {
                        formattedDate = '';
                    }
                    
                    // Format file size
                    var formattedSize = '';
                    if (fileSize && fileSize > 0) {
                        if (fileSize < 1024) {
                            formattedSize = fileSize + ' B';
                        } else if (fileSize < 1024 * 1024) {
                            formattedSize = (fileSize / 1024).toFixed(2) + ' KB';
                        } else {
                            formattedSize = (fileSize / (1024 * 1024)).toFixed(2) + ' MB';
                        }
                    }
                    
                    // Create clickable file name link for download
                    var fileNameLink = $('<a>')
                        .attr('href', 'javascript:void(0);')
                        .addClass('file-download-link')
                        .attr('data-release-id', releaseID)
                        .attr('data-file-id', fileID)
                        .attr('data-file-name', fileName || '')
                        .css({ 
                            'color': '#3b82f6', 
                            'text-decoration': 'underline', 
                            'cursor': 'pointer' 
                        })
                        .text(fileName || '');
                    
                    var row = $('<tr>');
                    row.append($('<td>').append(fileNameLink));
                    row.append($('<td>').text(formattedDate));
                    row.append($('<td>').text(formattedSize));
                    tbody.append(row);
                });
            } else {
                tbody.html('<tr><td colspan="3" style="text-align:center; padding:15px; color:#999;"><%=MyBase.GetResourceString("C_NoFilUpl")%></td></tr>');
            }
            
            // Update pagination UI
            updateTotalReleaseNoteFileRecords();
            updateReleaseNoteFilePaginationButtons();
        }
        
        // Added By Vyankat B On 24-11-2025 For loading customer feedback for Release Note modal
        function loadReleaseNoteFeedback(releaseID) {
            if (!releaseID || releaseID <= 0) {
                $('#releaseNoteCustomerFeedback').val('');
                $('#releaseNoteCustomerFeedback').attr('placeholder', '<%=MyBase.GetResourceString("C_CusFeed")%>');
                return;
            }
            
            var requestParam = {
                ReleaseID: releaseID
            };
            var param = JSON.stringify(requestParam);
            var response = AJAXCallWithResult("/api/PM_Releases/GetReleaseFeedback", param, false);
            
            var feedbackText = '';
            
            // Handle response structure - response is an array, each item has feedback property
            if (response) {
                // If response is an array, use it directly
                if (Array.isArray(response) && response.length > 0) {
                    // Get feedback from first item - check multiple case variations
                    var firstItem = response[0];
                    feedbackText = firstItem.feedback|| '';
                }             
            }
            
            // Display feedback in input field
            var feedbackInput = $('#releaseNoteCustomerFeedback');
            if (feedbackText && feedbackText.trim() !== '') {
                feedbackInput.val(feedbackText.trim());
                feedbackInput.attr('placeholder', '');
            } else {
                feedbackInput.val('');
                feedbackInput.attr('placeholder', '<%=MyBase.GetResourceString("C_CusFeed")%>');
            }
        }
        // End of Added By Vyankat B On 24-11-2025 For loading customer feedback
        
        // Added By Vyankat B On 24-11-2025 - Release Note File pagination functions
        function goToPreviousReleaseNoteFilePage() {
            if (currentReleaseNoteFilePageNumber > 1) {
                currentReleaseNoteFilePageNumber = currentReleaseNoteFilePageNumber - 1;
                loadReleaseNoteFiles(selectedReleaseID);
            }
        }
        
        function goToNextReleaseNoteFilePage() {
            if (currentReleaseNoteFilePageNumber < totalReleaseNoteFilePages) {
                currentReleaseNoteFilePageNumber = currentReleaseNoteFilePageNumber + 1;
                loadReleaseNoteFiles(selectedReleaseID);
            }
        }
        
        function updateTotalReleaseNoteFileRecords() {
            var totalRecordsSpan = document.getElementById('totalReleaseNoteFileRecords');
            if (totalRecordsSpan) {
                totalRecordsSpan.textContent = 'Total Records: ' + totalReleaseNoteFileRecords;
            }
        }
        
        function updateReleaseNoteFilePaginationButtons() {
            var firstBtn = document.getElementById('firstReleaseNoteFilePageBtn');
            var lastBtn = document.getElementById('lastReleaseNoteFilePageBtn');
            
            if (!firstBtn || !lastBtn) return;
            
            // Disable Previous button if on first page or no data
            if (currentReleaseNoteFilePageNumber <= 1 || totalReleaseNoteFileRecords === 0 || totalReleaseNoteFilePages === 0 || totalReleaseNoteFilePages <= 1) {
                firstBtn.disabled = true;
                firstBtn.style.opacity = '0.5';
                firstBtn.style.cursor = 'not-allowed';
                firstBtn.style.background = '#f8f9fa';
                firstBtn.style.color = '#6c757d';
            } else {
                firstBtn.disabled = false;
                firstBtn.style.opacity = '1';
                firstBtn.style.cursor = 'pointer';
                firstBtn.style.background = 'white';
                firstBtn.style.color = '#3b82f6';
            }
                
            // Disable Next button if on last page or no data
            if (currentReleaseNoteFilePageNumber >= totalReleaseNoteFilePages || totalReleaseNoteFileRecords === 0 || totalReleaseNoteFilePages === 0 || totalReleaseNoteFilePages <= 1) {
                lastBtn.disabled = true;
                lastBtn.style.opacity = '0.5';
                lastBtn.style.cursor = 'not-allowed';
                lastBtn.style.background = '#f8f9fa';
                lastBtn.style.color = '#6c757d';
            } else {
                lastBtn.disabled = false;
                lastBtn.style.opacity = '1';
                lastBtn.style.cursor = 'pointer';
                lastBtn.style.background = 'white';
                lastBtn.style.color = '#3b82f6';
            }
        }
        // End of Added By Vyankat B On 24-11-2025 - Release Note File pagination functions
        // End of Added By Vyankat B On 24 Nov 2025 - Function to open Release Note view
        
        // Added By Vyankat B On 24 Nov 2025 - Function to send release mail
        function sendReleaseMail() {
            // Check if release ID is selected
            if (!selectedReleaseID || selectedReleaseID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SelRelFirst")%>');
                return;
            }
            
            // Open the send mail modal
            var sendMailModal = new bootstrap.Modal(document.getElementById('SendMailModal'));
            sendMailModal.show();
            
            // Ensure Send button is visible
            $('#sendMailBtn').show();
            
            // Load release data to populate email fields
            loadReleaseDataForEmail();
        }
        
        // Added By Vyankat B On 24 Nov 2025 - Function to load release data for email
        function loadReleaseDataForEmail() {
            if (!selectedReleaseID || selectedReleaseID <= 0) {
                return;
            }
            
            // Get ProjectID and EmployeeID
            var projectID = $('#ProjectFilter').val() || SessionProjectID;
            projectID = parseInt(projectID);
            var employeeID = parseInt(SessionEmployeeId) || 0;
            
            if (!projectID || projectID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ValidPID")%>');
                return;
            }
            
            if (!employeeID || employeeID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ValidEmpID")%>');
                return;
            }
            
            // Call GetEmployeeProjectInfo API
            var requestParams = {
                ProjectID: projectID,
                EmployeeID: employeeID
            };
            
            var param = JSON.stringify(requestParams);
            var response = AJAXCallWithResult("/api/PM_Releases/GetEmployeeProjectInfo", param, false);
            
            // Check if API call was successful
            var emailID = '';
            var projectName = '';
            var userName = '';
            if (response) {
                emailID = response.emailID || '';
                projectName = response.projectName || '';
                userName = response.userName || '';
                
                // Bind EmailID to From and CC fields
                $('#sendMailFrom').val(emailID || '');
                $('#sendMailCC').val(emailID || '');
            } else {
                // Fallback to default values if API fails
                var userEmail ='';
                emailID = userEmail;
                $('#sendMailFrom').val(userEmail);
                $('#sendMailCC').val(userEmail);
            }
            
            // Get release data from form fields
            var releaseDate = $('#ReleaseDateEdit').val() || '';
            var objectives = $('#ObjectivesEdit').val() || '';
            var details = $('#DetailsEdit').val() || '';
            var installation = $('#InstallationEdit').val() || '';
            var issues = $('#IssuesEdit').val() || '';
            var testingSummary = $('#TestingSummaryEdit').val() || '';
            var knownProblems = $('#KnownProblemsEdit').val() || '';
            
            //commented and added by Vaibhav K for sending all files on 06-02-25
            // Get file list from uploaded files
            //var fileList = '';
            //var fileCount = 0;
            //// Get files from the table tbody
            //$('#UploadedFilesTbl tbody tr').each(function() {
            //    var fileNameCell = $(this).find('td').eq(1); // File Name is in 2nd column (index 1)
            //    if (fileNameCell.length > 0) {
            //        var fileName = fileNameCell.find('a').text() || fileNameCell.text();
            //        if (fileName && fileName.trim() !== '') {
            //            fileCount++;
            //            fileList += fileCount + '. ' + fileName.trim() + '\n';
            //        }
            //    }
            //});
            //  Fetch ALL Files for this Release (Ignoring UI Pagination)
            // We call the API once with a small pageSize just to get the totalRecords count
            var initialFileParam = JSON.stringify({
                ReleaseID: selectedReleaseID,
                PageNumber: 1,
                PageSize: 1 // We only need the pagination object here
            });
            var initialFileResponse = AJAXCallWithResult("/api/PM_Releases/GetReleaseFiles", initialFileParam, false);

            var fileList = '';
            if (initialFileResponse && initialFileResponse.pagination) {
                var total = initialFileResponse.pagination.totalRecords;

                // Now call the API again with pageSize = total to get EVERYTHING
                var allFilesParam = JSON.stringify({
                    ReleaseID: selectedReleaseID,
                    PageNumber: 1,
                    PageSize: total
                });
                var allFilesResponse = AJAXCallWithResult("/api/PM_Releases/GetReleaseFiles", allFilesParam, false);

                if (allFilesResponse && allFilesResponse.data) {
                    allFilesResponse.data.forEach(function (file, index) {
                        fileList += (index + 1) + ". " + file.fileName + "\n";
                    });
                }
            }
            //End of commented and added by Vaibhav K for sending all files on 06-02-25

            
            // Call GetCustomerEmailIDs API to get customer emails for 'To' field
            var customerEmailParams = {
                ProjectID: projectID
            };
            var customerEmailParam = JSON.stringify(customerEmailParams);
            var customerEmailResponse = AJAXCallWithResult("/api/PM_Releases/GetCustomerEmailIDs", customerEmailParam, false);
            
            // Build comma-separated list of email IDs for 'To' field
            var toEmailList = [];
            var contactPersonNames = [];
            
            // Get customer email and contact person from response
            var customerEmail = '';
            var contactPerson = '';
            
            // Access response directly as array
            if (customerEmailResponse && Array.isArray(customerEmailResponse) && customerEmailResponse.length > 0) {
                customerEmail = customerEmailResponse[0].emailID|| '';
                contactPerson = customerEmailResponse[0].contactPerson|| '';
            }
            
            if (customerEmail && customerEmail.trim() !== '') {
                toEmailList.push(customerEmail.trim());
            }
            if (contactPerson && contactPerson.trim() !== '') {
                contactPersonNames.push(contactPerson.trim());
            }
            
            // Bind EmailIDs to 'To' field (comma-separated)
            if (toEmailList.length > 0) {
                $('#sendMailTo').val(toEmailList.join(', '));
            }
            
            // Get first contact person name for greeting
            var contactPersonGreeting = '';
            if (contactPersonNames.length > 0) {
                contactPersonGreeting = contactPersonNames.join(', ');
            }
            
            var messageID = 0; // 
            var emailMessageParams = {
                MessageID: 13,
                ProjectID: projectID
            };
            
            var emailMessageParam = JSON.stringify(emailMessageParams);
            var emailMessageResponse = AJAXCallWithResult("/api/PM_Releases/GetEmailMessage", emailMessageParam, false);
            
            // Get email template Subject and Body from API
            var emailSubject = '';
            var emailBody = '';
            
            if (emailMessageResponse) {
                emailSubject = emailMessageResponse.subject || '';
                emailBody = emailMessageResponse.body || '';
            }
            
            // If no template body from API, use empty string (don't use hardcoded body)
            if (!emailBody) {
                emailBody = '';
            }
            
            // Replace placeholders in email body
            if (emailBody) {
                // Replace <PROJECT_NAME> with actual project name
                if (projectName) {
                    emailBody = emailBody.replace(/<PROJECT_NAME>/g, projectName);
                }
                
                // Replace <NAME> with contact person name (with comma)
                if (contactPersonGreeting) {
                    emailBody = emailBody.replace(/<NAME>/g, contactPersonGreeting + ',');
                }

                else {
                    emailBody = emailBody.replace(/<NAME>/g,  '');
                }
                
                // Replace <SENDER_NAME> with user name
                if (userName) {
                    emailBody = emailBody.replace(/<SENDER_NAME>/g, userName);
                } else {
                    // If no user name, remove the placeholder
                    emailBody = emailBody.replace(/<SENDER_NAME>/g, '');
                }
                
                // Replace <FILE_NAMES> with file list
                if (fileList) {
                    emailBody = emailBody.replace(/<FILE_NAMES>/g, fileList);
                } else {
                    // If no files, remove the placeholder
                    emailBody = emailBody.replace(/<FILE_NAMES>/g, '');
                }
                
                // Replace <SITE> with siteUrl
                if (siteUrl) {
                    emailBody = emailBody.replace(/<SITE>/g, siteUrl);
                } else {
                    // If no siteUrl, remove the placeholder
                    emailBody = emailBody.replace(/<SITE>/g, '');
                }
            }
            
           
            // Bind Subject from API and replace <PROJECT_NAME> placeholder with actual project name
            if (emailSubject) {
                // Replace <PROJECT_NAME> placeholder with actual project name
                var finalSubject = emailSubject.replace(/<PROJECT_NAME>/g, projectName || '');
                $('#sendMailSubject').val(finalSubject);
            } else {
                $('#sendMailSubject').val(projectName || $('#SubjectEdit').val() || '');
            }
            
            // Bind Body from API (with appended file list and release details)
            $('#sendMailBody').val(emailBody);
        }
        
        // Function to confirm and send mail
        function sendMailConfirm() {
            var toEmail = $('#sendMailTo').val().trim();
            var ccEmail = $('#sendMailCC').val().trim();
            var subject = $('#sendMailSubject').val().trim();
         //Commented and Added by Vaibhav K on 05 - 02 - 25 for fixing mail body alignment issue
             //var body = $('#sendMailBody').val().trim();
            var rawBody = $('#sendMailBody').val().trim();

            // Encode HTML to avoid breaking markup
            var encodedBody = $('<div/>').text(rawBody).html();

            // Convert new lines to <br/>
            var body = encodedBody.replace(/\r?\n/g, '<br/>');
        // End of Commented and Added by Vaibhav K on 05 - 02 - 25 for fixing mail body alignment issue

            
           
            // Validation
            if (!toEmail) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ToMailReq")%>');
                $('#sendMailTo').focus();
                return;
            }
            
            if (!subject) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SubReq")%>');
                $('#sendMailSubject').focus();
                return;
            }
            
            if (!body) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_BodyReq")%>');
                $('#sendMailBody').focus();
                return;
            }
            
            // Prepare request for API call
            var requestParams = {
                ReleaseID: selectedReleaseID || 0,
                ToEmailID: toEmail,
                CCEmailID: ccEmail,
                FromEmailID: $('#sendMailFrom').val(),
                Subject: subject,
                Body: body
            };
            
            // Call API to send email
            try {
                var param = JSON.stringify(requestParams);
                var response = AJAXCallWithResult("/api/PM_Releases/SendReleaseEmail", param, false);
                
                // Check response - handle new format with success and message
                var isSuccess = false;
                var successMessage;
                
                if (response ) {
                    // Check for success property first (new format)
                    if (response.status == true ) {
                        isSuccess = true;
                        successMessage = response.message;
                    }                
                }
            
            if (isSuccess) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success(successMessage);
                
                // Close modal
                var sendMailModal = bootstrap.Modal.getInstance(document.getElementById('SendMailModal'));
                if (sendMailModal) {
                    sendMailModal.hide();
                }
                
                // Clear form
                $('#sendMailTo').val('');
                $('#sendMailCC').val('');
                $('#sendMailSubject').val('');
                $('#sendMailBody').val('');
            } else {
                // Show error message
                var errorMsg = 'A_FailSendMail';              
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(errorMsg);
            }
            } catch (error) {
                // Handle any JavaScript errors
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ErrSendMail")%>');
            }
        }
        // Added By Vyankat B On 24 Nov 2025 - Function to select all files
        function selectAllFiles() {
            $('.chcktblFile').prop('checked', true);
            updateFileSelectAllCheckbox();
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to select all files
        
        // Added By Vyankat B On 24 Nov 2025 - Function to clear all file selections
        function clearAllFiles() {
            $('.chcktblFile').prop('checked', false);
            updateFileSelectAllCheckbox();
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to clear all file selections
        
        // Added By Vyankat B On 24 Nov 2025 - Function to update file select all checkbox
        function updateFileSelectAllCheckbox() {
            var totalCheckboxes = $('.chcktblFile').length;
            var checkedCheckboxes = $('.chcktblFile:checked').length;
            // Update total file records
            updateTotalFileRecords();
        }
        // End of Added By Vyankat B On 24 Nov 2025 - Function to update file select all checkbox
        
        // Added By Vyankat B On 24 Nov 2025 - Function to delete selected files
        function deleteSelectedFiles() {
            var selectedFiles = [];
            $('.chcktblFile:checked').each(function() {
                selectedFiles.push($(this).data('file-id'));
            });
            
            if (selectedFiles.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PlzSelFil")%>');
                return;
            }
            
            $('#deleteFileConfirm').modal('show');
        }
        // Added By Vyankat B On 20-11-2025 For deleting selected files
        function deleteTheSelectedFiles() {
            var selectedFiles = [];
            $('.chcktblFile:checked').each(function() {
                var fileID = $(this).data('file-id');
                if (fileID) {
                    selectedFiles.push(fileID);
                }
            });
            
            if (selectedFiles.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PlzSelFil")%>');
            $('#deleteFileConfirm').modal('hide');
                return;
            }

            var fileIdsString = selectedFiles.join(',');          
            var deleteParam = {
                FileIDs: fileIdsString
            };
            
            var param = JSON.stringify(deleteParam);
            var response = AJAXCallWithResult("/api/PM_Releases/DeleteReleaseFiles", param, false);
            
            $('#deleteFileConfirm').modal('hide');

            var deletedCount = response.deletedCount || 0;
            var message = response.message || '';
            
            if (deletedCount > 0) {
                alertify.set('notifier', 'position', 'top-right');
               //Commented and added by Vaibhav K for fixing alert issue on 05-02-25
                <%--  if (message) {
                    alertify.success(message);
                } else {
                    alertify.success(deletedCount === 1 
                        ? '<%=MyBase.GetResourceString("A_FilDelSucc")%>'
                        : deletedCount + ' <%=MyBase.GetResourceString("A_FilDelSucc")%>');
                }--%>

                alertify.success('<%=MyBase.GetResourceString("A_FilDelSucc")%>');
                //End of Commented and added by Vaibhav K for fixing alert issue on 05 - 02 - 25

                $('.chcktblFile').prop('checked', false);
                $('.chckHeadFile').prop('checked', false);

                currentFilePageNumber = 1;
                loadUploadedFiles();
            } else {
                var errorMsg = 'A_FailDelFil';              
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(errorMsg);
            }
        }
        // End of Added By Vyankat B On 20-11-2025 For deleting selected files

        // Added By Vyankat B On 20-11-2025 For generating GUID
        function generateGuid() {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = Math.random() * 16 | 0;
                var v = c == 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }
        // End of Added By Vyankat B On 20-11-2025 For generating GUID

        // Added By Vyankat B On 20-11-2025 For uploading a file using InsertReleaseFile API
        function UploadFile() {
            var fileInput = document.getElementById('doc_dragdrop');
            if (!fileInput || !fileInput.files || fileInput.files.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("C_Plzfilupl")%>');
                return;
            }

            var file = fileInput.files[0];
          

            var description = $('#docDescription').val() || '';

            // Validate ReleaseID - must be set (either from edit mode or after saving a new release)
            if (!selectedReleaseID || selectedReleaseID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_SaveReles")%>');
                return;
            }

            // Get ProjectID from dropdown or session
            var projectID = $('#ProjectFilter').val() || SessionProjectID;
            projectID = parseInt(projectID);
            if (!projectID || projectID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ValidPID")%>');
                return;
            }

            // Get user information
            var attachedBy = UserName || SessionEmployeeId || '';
            var loginType = SessionLoginType || '';
            var releaseDate = new Date();

            // Generate SystemFilename (GUID + file extension)
            var fileExtension = file.name.substring(file.name.lastIndexOf('.')) || '';
            var systemFilename = generateGuid() + fileExtension;

            // Ensure Description is not null (can be empty string)
            if (description === null || description === undefined) {
                description = '';
            }

            // Create FormData for multipart/form-data
            var formData = new FormData();
            formData.append('file', file);
            formData.append('ReleaseID', selectedReleaseID);
            formData.append('FileName', file.name);
            formData.append('SystemFilename', systemFilename);
            formData.append('AttachedBy', attachedBy);
            formData.append('LoginType', loginType);
            formData.append('ReleaseDate', releaseDate.toISOString());
            formData.append('Description', description);
            formData.append('ProjectID', projectID);

            // Show loading indicator
            var $uploadBtn = $('#uploadDocBtn');
            var originalText = $uploadBtn.html();
            $uploadBtn.prop('disabled', true).html('Uploading...');

            // Make API call using FormData (multipart/form-data)
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Releases/InsertReleaseFile',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                async: true,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    // For multipart/form-data, we don't set Params header
                },
                success: function (response) {
                    $uploadBtn.prop('disabled', false).html(originalText);
                    
                    // Check if upload was successful
                    var isSuccess = false;
                    if (response && (response.status === "SUCCESS" || 
                        (response.data && (response.data.success === true || response.data.Success === true)) ||
                        (response.success === true))) {
                        isSuccess = true;
                    }

                    if (isSuccess) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success('<%=MyBase.GetResourceString("A_FileUploaded")%>');
                        
                        // Close modal
                        $('#UploadDocumentModal').modal('hide');
                        
                        // Clear form
                        $('#docDescription').val('');
                        fileInput.value = '';
                        
                        // Reset drop zone
                        var dropZone = document.getElementById('drop-zone-div');
                        if (dropZone) {
                            var thumb = dropZone.querySelector('.drop-zone__thumb');
                            if (thumb) {
                                thumb.remove();
                            }
                            if (!dropZone.querySelector('.drop-zone__prompt')) {
                                dropZone.insertAdjacentHTML('afterbegin', '<span class="drop-zone__prompt"><%=MyBase.GetResourceString("C_DropFilePrompt")%></span>');
                            }
                        }
                        
                        // Reload uploaded files list after successful upload
            loadUploadedFiles();
                    } else {
                        var errorMsg = 'Failed to upload file.';
                        if (response && response.data) {
                            errorMsg = response.data.toString() || errorMsg;
                        }
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(errorMsg);
                    }
                },
                error: function (xhr, status, error) {
                    $uploadBtn.prop('disabled', false).html(originalText);
                    
                    var errorMsg = 'Error uploading file.';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg = xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        try {
                            var errorResponse = JSON.parse(xhr.responseText);
                            if (errorResponse.message) {
                                errorMsg = errorResponse.message;
                            }
                        } catch (e) {
                            errorMsg = xhr.responseText;
                        }
                    }
                    
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(errorMsg);
                }
            });
        }
        // End of Added By Vyankat B On 20-11-2025 For uploading a file
        // Added By Vyankat B On 20-11-2025 For loading uploaded files for a release
        function loadUploadedFiles() {
            if (!selectedReleaseID || selectedReleaseID <= 0) {
                // No release selected, clear the table
                if ($.fn.DataTable.isDataTable('#UploadedFilesTbl')) {
                    $('#UploadedFilesTbl').DataTable().clear().draw();
                } else {
                    $('#UploadedFilesTbl tbody').empty();
                }
                updateTotalFileRecords();
                return;
            }

            var requestParam = {
                ReleaseID: selectedReleaseID,
                PageNumber: currentFilePageNumber,
                PageSize: filePageSize
            };
            var param = JSON.stringify(requestParam);
            var response = AJAXCallWithResult("/api/PM_Releases/GetReleaseFiles", param, false);

            // Clear existing table data and destroy DataTable if it exists
            var tbody = $('#UploadedFilesTbl tbody');
            if ($.fn.DataTable.isDataTable('#UploadedFilesTbl')) {
                $('#UploadedFilesTbl').DataTable().destroy();
            }
            tbody.empty();

            // Check if response is valid
            var files = [];
            var pagination = null;

            if (response && response.data) {        
                    files = response.data;
                    pagination = response.pagination;            
            }

            // Update pagination info if available
            if (pagination) {
                totalFileRecords = pagination.totalRecords || 0;
                totalFilePages = pagination.totalPages || 1;
                currentFilePageNumber = pagination.currentPage || currentFilePageNumber;
            } else if (files && files.length > 0) {
                // Fallback: if no pagination, use data length
                totalFileRecords = files.length;
                totalFilePages = Math.ceil(totalFileRecords / filePageSize) || 1;
            } else {
                totalFileRecords = 0;
                totalFilePages = 1;
            }
            
            // Ensure totalFilePages is at least 1
            if (totalFilePages < 1) {
                totalFilePages = 1;
            }
            
            // If we're on page 1 and there's only 1 page, ensure we're on page 1
            if (totalFilePages === 1) {
                currentFilePageNumber = 1;
            }
        
            // Populate table
            if (files && files.length > 0) {
                tbody.empty();
                
                files.forEach(function (file, index) {
                    // ---Added by Vaibhav K for fixing wrong serial no isusue on 05/02/25---
                    var serialNo = ((currentFilePageNumber - 1) * filePageSize) + (index + 1);
                     // ---End of Added by Vaibhav K for fixing wrong serial no isusue---
                    // Map both camelCase and PascalCase fields from API response
                    var fileID = file.fileID|| 0;
                    var fileName = file.fileName|| '';
                    var systemFileName = file.systemFileName|| '';
                    var attachedBy = file.attachedBy ||'';
                    var releaseDate = file.releaseDate|| '';
                    var description = file.description|| '';
                    
                    // Get file size from API response (in bytes)
                    var fileSize = file.fileSize|| 0;
                    
                    // Format file size (B, KB, MB)
                    var formattedSize = '';
                    if (fileSize && fileSize > 0) {
                        if (fileSize < 1024) {
                            formattedSize = fileSize + ' B';
                        } else if (fileSize < 1024 * 1024) {
                            formattedSize = (fileSize / 1024).toFixed(2) + ' KB';
                        } else {
                            formattedSize = (fileSize / (1024 * 1024)).toFixed(2) + ' MB';
                        }
                    }
                    
                    // Format date if needed
                    var formattedDate = '';
                    if (releaseDate) {
                        try {
                            var dateObj = new Date(releaseDate);
                            if (!isNaN(dateObj.getTime())) {

                                //Commeneted and added by Vaibhav K for doument date format issue on 04-02-26
                                //formattedDate = $.datepicker.formatDate('dd-M-yy', dateObj);
                                var day = String(dateObj.getDate()).padStart(2, '0');
                                var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                                var year = dateObj.getFullYear();
                                formattedDate = day + '/' + month + '/' + year; // New format DD/MM/YYYY


                                //End of Commeneted and added by Vaibhav K for doument date format issue on 04-02-26



                                var day = String(dateObj.getDate()).padStart(2, '0');
                                var month = String(dateObj.getMonth() + 1).padStart(2, '0');
                                var year = dateObj.getFullYear();
                                formattedDate = day + '/' + month + '/' + year; // New format DD/MM/YYYY



                            } else {
                                formattedDate = releaseDate;
                            }
                        } catch (e) {
                            formattedDate = releaseDate;
                        }
                    }
                    
                    // Make file name clickable for download
                    var releaseID = selectedReleaseID || 0;
                    var fileNameCell = '<td><a href="javascript:void(0);" class="file-download-link" data-release-id="' + releaseID + '" data-file-id="' + fileID + '" data-file-name="' + (fileName || '') + '" style="color: #3b82f6; text-decoration: underline; cursor: pointer;">' + (fileName || '') + '</a></td>';
                    
                    // Delete checkbox column - only show if delete access is available
                    var deleteCell = '';
                    if (DeleteAccess === 'True') {
                        deleteCell = '<td><input type="checkbox" class="chcktblFile" data-file-id="' + fileID + '"></td>';
                    } else {
                        deleteCell = '<td></td>';
                    }
                    
                    var row = '<tr>' +
                // ---Commented and Added by Vaibhav K for fixing wrong serial no isusue on 05/02/25---
                        //'<td>' + (index + 1) + '</td>' +
                        '<td>' + serialNo + '</td>' +
                // ---End of Commented and Added by Vaibhav K for fixing wrong serial no isusue on 05/02/25---
                        fileNameCell +
                        '<td>' + formattedSize + '</td>' +
                        '<td>' + (attachedBy || '') + '</td>' +
                        '<td>' + (formattedDate || '') + '</td>' +
                        '<td>' + (description || '') + '</td>' +
                        deleteCell +
                        '</tr>';
                    tbody.append(row);
                });
            } else {
                // No files found
                tbody.empty();
                tbody.append('<tr><td colspan="7" class="text-center"><%=MyBase.GetResourceString("C_NoDataAvaible")%></td></tr>');
                // Reset total records to 0 when no data
                totalFileRecords = 0;
                totalFilePages = 1;
            }

            // Update total records display
            updateTotalFileRecords();

            setTimeout(function() {
                var $table = $("#UploadedFilesTbl");
                
                // Verify table structure before initializing
                var headerCols = $table.find('thead tr th').length;
                if (headerCols !== 7) {
                    return; 
                }
                
                // Destroy existing DataTable if it exists
                if ($.fn.DataTable.isDataTable('#UploadedFilesTbl')) {
                    $('#UploadedFilesTbl').DataTable().destroy();
                }
            
                var tbodyRows = $table.find('tbody tr');
                var isValidStructure = true;
                
                if (tbodyRows.length > 0) {
                    tbodyRows.each(function() {
                        var rowCols = $(this).find('td').length;
                        // Allow colspan rows (like "No data available" message)
                        if (rowCols === 0) {
                            var colspan = $(this).find('td[colspan]').attr('colspan');
                            if (colspan && parseInt(colspan) !== 7) {
                                isValidStructure = false;
                                return false;
                            }
                        } else if (rowCols !== 7) {
                            isValidStructure = false;
                            return false;
                        }
                    });
                }
                
                // Only initialize if structure is valid
                if (isValidStructure) {
                    $("#UploadedFilesTbl").dataTable({
                        paging: false,
                        pageLength: 10,
                        bLengthChange: false,
                        bFilter: false,
                        ordering: false,
                        responsive: false,
                        destroy: true,
                        retrieve: true,
                        info: false,
                        bPaginate: false,
                        columnDefs: [
                            { "width": "8%", "targets": 0 },
                            { "width": "20%", "targets": 1 },
                            { "width": "12%", "targets": 2 },
                            { "width": "15%", "targets": 3 },
                            { "width": "15%", "targets": 4 },
                            { "width": "20%", "targets": 5 },
                            { "width": "10%", "targets": 6 }
                        ]
                    });
                }
                
                // Update pagination UI
                updateTotalFileRecords();
                updateFilePaginationButtons();
            }, 50);
        }
        // End of Added By Vyankat B On 20-11-2025 For loading uploaded files
        
        // Added By Vyankat B On 20-11-2025 For downloading a release file
        function downloadReleaseFile(releaseID, fileID, fileName) {
           
            if (!releaseID || releaseID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_InRelsID")%>');
                return;
            }
            
            if (!fileID || fileID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_InvalidFileID")%>');
                return;
            }
            
            // Construct download URL and request parameters
            var downloadUrl = '/api/PM_Releases/DownloadReleaseFile';
            var param = {
                ReleaseID: releaseID,
                FileID: fileID
            };
            
            // Store fileName for fallback if Content-Disposition header is not available
            var fallbackFileName = fileName || 'downloaded_file';
            
            $.ajax({
                url: encodeURI(strUrl + downloadUrl),
                type: "POST",
                data: JSON.stringify(param),
                xhrFields: {
                    responseType: 'blob' // Needed to handle binary file response
                },
                contentType: "application/json; charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data, status, xhr) {
                  
                    // Check if response is actually a JSON error (file not found)
                    var contentType = xhr.getResponseHeader('content-type') || '';
                    
                    if (contentType.includes('application/json')) {
                        // It's a JSON error response, read as text and parse
                        var reader = new FileReader();
                        reader.onload = function() {
                            try {
                                var errorData = JSON.parse(reader.result);
                                var errorMessage = errorData.message || 'C_FileNotF';
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(errorMessage);
                            } catch (e) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error('<%=MyBase.GetResourceString("C_FileNotF")%>');
                            }
                        };
                        reader.readAsText(data);
                        return;
                    }
                    
                    // Extract filename from the Content-Disposition header
                    var disposition = xhr.getResponseHeader('Content-Disposition');
                    var filename = fallbackFileName; // Use provided fileName as fallback

                    if (disposition) {
                        var filenameMatch = disposition.match(/filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/);
                        if (filenameMatch && filenameMatch[1]) {
                            filename = filenameMatch[1].replace(/['"]/g, '').trim();
                        } else if (disposition.indexOf('filename=') !== -1) {
                            filename = disposition.split('filename=')[1].split(';')[0].trim().replace(/["']/g, '');
                        }
                    }
                    
                    // If filename is still the fallback or empty, ensure we use the provided fileName
                    if (!filename || filename === 'downloaded_file') {
                        filename = fallbackFileName;
                    }

                    // Create download link and trigger it
                    var link = document.createElement('a');
                    var url = window.URL.createObjectURL(data);
                    link.href = url;
                    link.download = filename;
                    link.style.display = 'none';
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                    window.URL.revokeObjectURL(url);
                },
                error: function (xhr, status, error) {
                   
                    // Try to parse error response as JSON
                    if (xhr.responseText) {
                        try {
                            var errorData = JSON.parse(xhr.responseText);
                            var errorMessage = errorData.message || C_FileNotF;
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(errorMessage);
                            return;
                        } catch (e) {
                            // Not JSON, continue with default error
                        }
                    }
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("C_FileNotF")%>');
                }
            });
        }
        // End of Added By Vyankat B On 20-11-2025 For downloading a release file
        
        // Added By Vyankat B On 20-11-2025 For handling file name click to download
        $(document).on('click', '.file-download-link', function(e) {
            e.preventDefault();
            var releaseID = $(this).data('release-id');
            var fileID = $(this).data('file-id');
            var fileName = $(this).data('file-name') || $(this).text().trim();
            if (releaseID && fileID) {
                downloadReleaseFile(releaseID, fileID, fileName);
            }
        });
        // End of Added By Vyankat B On 20-11-2025 For handling file name click to download
        // Added By Vyankat B On 20-11-2025 - File pagination functions
        function goToPreviousFilePage() {
            if (currentFilePageNumber > 1) {
                currentFilePageNumber = currentFilePageNumber - 1;
                loadUploadedFiles();
            }
        }
        function goToNextFilePage() {
            if (currentFilePageNumber < totalFilePages) {
                currentFilePageNumber = currentFilePageNumber + 1;
                loadUploadedFiles();
            }
        }
        function updateTotalFileRecords() {
            var totalRecordsElement = document.getElementById('totalFileRecords');
            if (!totalRecordsElement) return;
            
            // Always use the totalFileRecords variable from API
            var recordCount = totalFileRecords || 0;
            
            // Fallback: if totalFileRecords is not set, try to get from DataTable
            if (recordCount === 0 && $.fn.DataTable.isDataTable('#UploadedFilesTbl')) {
                var info = $('#UploadedFilesTbl').DataTable().page.info();
                recordCount = info.recordsTotal || 0;
            } else if (recordCount === 0) {
                // Fallback: count rows (exclude "No data available" row)
                var table = document.getElementById('UploadedFilesTbl');
                if (table) {
                    var tbody = table.getElementsByTagName('tbody')[0];
                    var rows = tbody ? tbody.getElementsByTagName('tr') : [];
                    // Count only rows that are not "No data available" message
                    recordCount = 0;
                    for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        var cells = row.getElementsByTagName('td');
                        // Check if this is a "No data available" row (has colspan and contains the message)
                        var isNoDataRow = false;
                        if (cells.length > 0) {
                            var firstCell = cells[0];
                            if (firstCell.hasAttribute('colspan')) {
                                isNoDataRow = true;
                            }
                        }
                        if (!isNoDataRow) {
                            recordCount++;
                        }
                    }
                }
            }            
            
            totalRecordsElement.textContent = 'Total Records: ' + recordCount;
        }
        function updateFilePaginationButtons() {
            var firstBtn = document.getElementById('firstFilePageBtn');
            var lastBtn = document.getElementById('lastFilePageBtn');
            
            if (!firstBtn || !lastBtn) return;
            
            // Disable Previous button if on first page or no data
            if (currentFilePageNumber <= 1 || totalFileRecords === 0 || totalFilePages === 0) {
                firstBtn.disabled = true;
                firstBtn.style.opacity = '0.5';
                firstBtn.style.cursor = 'not-allowed';
                firstBtn.style.background = '#f8f9fa';
                firstBtn.style.color = '#6c757d';
            } else {
                firstBtn.disabled = false;
                firstBtn.style.opacity = '1';
                firstBtn.style.cursor = 'pointer';
                firstBtn.style.background = 'white';
                firstBtn.style.color = '#3b82f6';
            }
                
            // Disable Next button if on last page or no data
            if (currentFilePageNumber >= totalFilePages || totalFileRecords === 0 || totalFilePages === 0) {
                lastBtn.disabled = true;
                lastBtn.style.opacity = '0.5';
                lastBtn.style.cursor = 'not-allowed';
                lastBtn.style.background = '#f8f9fa';
                lastBtn.style.color = '#6c757d';
            } else {
                lastBtn.disabled = false;
                lastBtn.style.opacity = '1';
                lastBtn.style.cursor = 'pointer';
                lastBtn.style.background = 'white';
                lastBtn.style.color = '#3b82f6';
            }
        }
        // End of Added By Vyankat B On 20-11-2025 - File pagination functions
        $(document).on('change', '.chckHeadFile', function() {
            var checked = $(this).is(":checked");
            if (checked) {
                $(".chcktblFile").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktblFile").each(function () {
                    $(this).prop("checked", false);
                });
            }
            updateFileSelectAllCheckbox();
        });
        $(document).on('click', '.chcktblFile', function () {
            if ($(".chcktblFile").length == $(".chcktblFile:checked").length) {
                $(".chckHeadFile").prop("checked", true);
            } else {
                $(".chckHeadFile").removeAttr("checked");
            }
            updateFileSelectAllCheckbox();
        });
        updateTotalFileRecords();
        $("#UploadDocumentBtn").click(function () {
            $("#UploadDocumentModal").modal("show");
            $("#docDescription").val("");
            $(".drop-zone__input").val("");
            $(".drop-zone__thumb").attr("data-label", "Drop file here or click to upload");
        });

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W26API"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

         // Added By Vaibhav K On 04-02-26 for Milestone dropdown

        // Function to load milestones dynamically via API
        function bindMilestones(projectID, savedMilestoneID) {
            // If no project selected, clear dropdown
            if (!projectID || projectID <= 0) {
                $('#MilestoneEdit').empty().selectpicker('refresh');
                return;
            }

            var requestParam = {
                ProjectID: parseInt(projectID),
                SavedMilestoneID: parseInt(savedMilestoneID) || 0
            };

            var param = JSON.stringify(requestParam);

            // Call the NEW API endpoint
            var response = AJAXCallWithResult("/api/PM_Releases/GetMilestones", param, false);

            var $dropdown = $('#MilestoneEdit');
            $dropdown.empty(); // Clear existing
            if (response) {
                $.each(response, function (index, item) {
                    // Check for case sensitivity (API might return PascalCase or camelCase)
                    var id = item.MilestoneID || item.milestoneID;
                    var name = item.Milestone || item.milestone;

                    // Create option
                    var option = new Option(name, id);
                    $dropdown.append(option);
                });
            }

            // Refresh bootstrap-select
            if (typeof $.fn.selectpicker !== 'undefined') {
                $dropdown.selectpicker('refresh');

                // Set selected value if provided
                if (savedMilestoneID > 0) {
                    $dropdown.selectpicker('val', savedMilestoneID);
                } else {
                    // Reset to "Select Milestone" (value 0 or empty) if creating new
                    $dropdown.selectpicker('val', '0');
                }
            }
        }
         // End of Added By Vaibhav K On 04-02-26 for Milestone dropdown

    </script>
</body>
</html>

