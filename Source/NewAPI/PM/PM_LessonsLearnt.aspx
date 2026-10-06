<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_LessonsLearnt.aspx.vb" Inherits="Whizible.PM_LessonsLearnt" %>

<!DOCTYPE html>
<html>
<%-- PlotPageHeadTag may try to load StyleSheetChanakya_Blue.css which might not exist - this can cause MIME type errors --%>
<%CommonFunctions.General.PlotPageHeadTag("Lessons Learnt")%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%=MyBase.GetResourceString("C_LessonsLearnt")%></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <style>
        .alertify-notifier {
            z-index: 9999 !important;
        }        
        #LessonsLearntTbl th::after,
        #LessonsLearntTbl th::before,
        #LessonsLearntTbl th i,
        #LessonsLearntTbl th .fa,
        #LessonsLearntTbl th .fas,
        #LessonsLearntTbl th .far,
        #LessonsLearntTbl th .sort,
        #LessonsLearntTbl th .sorting,
        #LessonsLearntTbl th .sorting_asc,
        #LessonsLearntTbl th .sorting_desc {
            display: none !important;
        }
        #LessonsLearntTbl th:after,
        #LessonsLearntTbl th:before {
            display: none !important;
        }
        /* Fix project dropdown width */
        #ProjectFilter {
            width: 250px !important;
            max-width: 250px !important;
            min-width: 250px !important;

            /*display: none !important;*/
        
            }
        /* Ensure the select element itself is 250px and hidden */
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
            flex-shrink: 0;
            position: relative !important;
            /*overflow: hidden !important;*/ 
            box-sizing: border-box !important;
            pointer-events: auto !important;
            z-index: 1 !important; 
        }
        /* Prevent any clickable area beyond 250px */
        .bootstrap-select#ProjectFilter > * {
            max-width: 250px !important;
            box-sizing: border-box !important;
        }
        .bootstrap-select#ProjectFilter .dropdown-toggle {
            width: 100% !important;
            max-width: 100% !important;
            min-width: 100% !important;
            overflow: hidden;
            text-overflow: ellipsis;
            box-sizing: border-box !important;
            position: relative !important;
            z-index: 1001 !important;
        }
        /* Prevent the dropdown menu from extending into the gap area */
        .bootstrap-select#ProjectFilter .dropdown-menu {
            max-width: 250px !important;
            width: 250px !important;
            box-sizing: border-box !important;
            z-index: 10000 !important; 
            position: absolute !important;
            overflow: visible !important;
        }
        /* Make sure no child elements extend beyond the 250px boundary */
        .bootstrap-select#ProjectFilter .filter-option,
        .bootstrap-select#ProjectFilter .filter-option-inner,
        .bootstrap-select#ProjectFilter .filter-option-inner-inner {
            max-width: 100% !important;
            overflow: hidden !important;
            box-sizing: border-box !important;
        }
        /* Ensure no clickable area extends beyond the dropdown */
        .bootstrap-select#ProjectFilter * {
            box-sizing: border-box;
        }
        /* Prevent any pseudo-elements from creating clickable areas */
        .bootstrap-select#ProjectFilter::before,
        .bootstrap-select#ProjectFilter::after {
            display: none !important;
            pointer-events: none !important;
        }
        /* Container for ProjectFilter to limit clickable area */
        div[style*="position: relative"][style*="width: 250px"] {
            position: relative !important;
            width: 250px !important;
            max-width: 250px !important;
            min-width: 250px !important;
            overflow: visible !important;
            z-index: 1 !important;
            box-sizing: border-box !important;
        }
        /* Ensure dropdown menu can overflow container but container itself is 250px */
        div[style*="position: relative"][style*="width: 250px"] .bootstrap-select#ProjectFilter {
            overflow: hidden !important; 
        }
        div[style*="position: relative"][style*="width: 250px"] .bootstrap-select#ProjectFilter .dropdown-menu {
            overflow: visible !important; /* Allow menu to show */
        }

        /*Added by Vaibhav K on 30-01-25 for cursor*/
        /* Default cursor for all cells = normal */
#LessonsLearntTbl tbody tr td {
    cursor: default;
}

/* Show pointer ONLY on Problem Description column */
#LessonsLearntTbl tbody tr td:first-child {
    color: #1359a6;
    cursor: pointer;
}

/*.bootstrap-select .dropdown-menu {
    top: 100% !important;
    bottom: auto !important;
}*/
/* Complete fix for dropdown gap */
/*.bootstrap-select .dropdown-menu {
    padding: 0 !important;
    margin-top: 0 !important;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
}*/

.bootstrap-select .dropdown-menu .inner {
    padding: 0 !important;
}

.bootstrap-select .dropdown-menu li {
    margin: 0 !important;
}

.bootstrap-select .dropdown-menu li:first-child {
    margin-top: 0 !important;
    padding-top: 0 !important;
}

.bootstrap-select .dropdown-menu li a {
    padding: 8px 12px;
}



body {
/* Modified By Madhuri.K On 26-03-2026 */
            font-size: 11.5px !important;

        }

        .form-control, .btn, a, p, input, select.form-select {

    /* Modified By Madhuri.K On 26-03-2026 */
    font-size: 11.5px !important;

}
 
/* Prevent long text from breaking table layout */
#LessonsLearntTbl {
    table-layout: fixed; /* CRITICAL */
    width: 100%;
}

#LessonsLearntTbl td {
    white-space: normal !important;
    word-break: break-word !important;
    overflow-wrap: anywhere !important;
    vertical-align: top;
}
/*End of Added by Vaibhav K on 30-01-25 for cursor*/




    </style>

    <style type="text/css">
        .dataTables_scrollBody {
            margin-bottom: 10px
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
            font-size: 0.9rem;
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
        /*.bootstrap-select .dropdown-menu {
            overflow-y: auto;
            z-index: 10000 !important;*/ /* Ensure dropdown menus appear above all other elements */
        /*}*/        
        .bootstrap-select:not(.open) .dropdown-menu {
            overflow-y: hidden;
        }        
        .bootstrap-select.open .dropdown-menu {
            overflow-y: auto;
            max-height: 200px;
            z-index: 10000 !important; /* Ensure open dropdown menu appears above all */
        }
        

        /* Ensure ProjectFilter dropdown menu appears above everything when open */
        .bootstrap-select#ProjectFilter.open .dropdown-menu,
        .bootstrap-select[data-id="ProjectFilter"].open .dropdown-menu {
            z-index: 10000 !important;
            position: absolute !important;
            display: block !important;
        }
        /* Minimize Project dropdown open height – fewer visible items, scroll the rest */
        .bootstrap-select[data-id="ProjectFilter"] .dropdown-menu,
        .bootstrap-select#ProjectFilter .dropdown-menu {
            max-height: 160px !important;
            overflow-y: auto !important;
        }
        .bootstrap-select[data-id="ProjectFilter"] .dropdown-menu .inner,
        .bootstrap-select#ProjectFilter .dropdown-menu .inner {
            max-height: 120px !important;
            overflow-y: auto !important;
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
        .pagination-container {
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

        /* Remove outer border around edit details accordion in Lessons Learnt offcanvas */
        .Off_acordian_panel .accordion-item {
            border: 0 !important;
            box-shadow: none !important;
        }

         /*commented and added by Vaibhav K on 30-01-25*/

       /* #LessonsLearntTbl_wrapper {
            max-height: 300px;
            overflow-y: hidden;
            padding-right: 8px;
            box-sizing: border-box;
        }        
        #LessonsLearntTbl_wrapper:hover {
            overflow-y: auto;
            padding-right: 0;
        }     */
         /*End of commented and added by Vaibhav K on 30-01-25*/
        

        #LessonsLearntTbl_wrapper::-webkit-scrollbar {
            width: 8px;
        }        
        #LessonsLearntTbl_wrapper::-webkit-scrollbar-track {
            background: #f1f1f1;
        }        
        #LessonsLearntTbl_wrapper::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 4px;
        }        
        #LessonsLearntTbl_wrapper::-webkit-scrollbar-thumb:hover {
            background: #999;
        }
        #LessonsLearntTbl thead th {
            position: sticky;
            top: 0;
            z-index: 0;
            border-bottom: 2px solid #dee2e6;
        }
        #LessonsLearntTbl thead th {
            position: sticky;
            top: 0;
            z-index: 0;
            border-bottom: 2px solid #dee2e6;
        }        
        #LessonsLearntTbl {
            margin-bottom: 0;
        }
        /* Style DataTable's empty state message - match table row styling exactly (like Training Plan) */
        #LessonsLearntTbl tbody td.dataTables_empty,
        table#LessonsLearntTbl tbody td.dataTables_empty,
        #LessonsLearntTbl.dataTable tbody td.dataTables_empty,
        #LessonsLearntTbl tbody tr td.dataTables_empty {
            text-align: center !important;
            /* Regular font style (not italic) - matching Training Plan format */
            font-style: normal !important;
            /* Use specified color for empty message */
            color: #212529 !important;
            font-family: 'Roboto', sans-serif !important;
            font-weight: normal !important;
            /* Match table row padding - same as newTblStyle tbody td (16px 20px) */
            padding: 16px 20px !important;
            /* Match table row font size - same as inherited body font-size (0.875rem = 14px) */
            font-size: 0.875rem !important;
            /* Match table row vertical alignment */
            vertical-align: middle !important;
            /* Ensure no other styles override */
            line-height: normal !important;
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
        #LessonsLearntTbl thead th.sorting,
        #LessonsLearntTbl thead th.sorting_asc,
        #LessonsLearntTbl thead th.sorting_desc {
            background-image: none !important;
        }        
        #LessonsLearntTbl thead th.sorting:after,
        #LessonsLearntTbl thead th.sorting_asc:after,
        #LessonsLearntTbl thead th.sorting_desc:after {
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
        #LessonsLearntTbl_wrapper {
            overflow-x: hidden;
        }
        .filter-note {
            text-align: center;
            color: red;
            margin: 0.5rem 0;
        }
        table tr td a {
            color: #1359a6;
            text-decoration: underline;
            cursor: pointer;
        }
        table tr td a:hover {
            color: #0d47a1;
        }
        /* Color for Problem Description column data cells (rows) only */
        #LessonsLearntTbl tbody tr td:first-child {
            color: #1359a6;
        }
        /* Loader overlay - same as Project Profitability */
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
        .loader-overlay .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
        .preloader {
            position: fixed;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
            z-index: 2100;
        }
    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <div id="LessonsLearntPreloader" class="preloader"></div>
    <div class="loader-overlay" id="loaderOverlay" style="display: none;">
        <div class="loader"></div>
    </div>
    <%If m_blnViewAccess = True Then%>
    <div class="bgwhite" id="LessonsLearntWrapper" style="display: none;">
        <div style="background: white; margin-bottom: 1rem;">
            <div class="graybg" style="padding: 0.4rem 1rem; margin-left: 0;">
                <h2 style="color: #1e40af; font-weight: 600; font-size: 18px; margin: 0 0 0.25rem 0; display: flex; align-items: center;">
                    <i class="fas fa-book" style="color: #1e40af; font-size: 1.5rem; margin-right: 0.75rem;"></i>
                    <%=MyBase.GetResourceString("C_LessonsLearnt")%> 
                </h2>
                <p style="color: #6b7280; font-size: 0.7rem; margin: 0;"><%=MyBase.GetResourceString("C_LessonsLearntDesc")%></p>
            </div>
        </div>
        <div class="graybg" style=" padding: 0.5rem 1rem; margin: 0 1.2rem;">
            <div style="display: flex; align-items: center; justify-content: space-between; gap: 0.75rem;">
                <!-- Project Dropdown and Search Box Container -->
                <div style="display: flex; align-items: center; gap: 0.75rem; position: relative;">
                    <!-- Project Dropdown -->
                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <label style="color: #374151; font-size: 11.5px; font-weight: 500; margin: 0;"><%=MyBase.GetResourceString("C_SelProj")%></label>
                        <div style="position: relative; width: 250px; max-width: 250px; min-width: 250px; flex-shrink: 0; overflow: hidden; z-index: 1; box-sizing: border-box;">
                            <select id="ProjectFilter" class="selectpicker" data-live-search="true" data-width="250px" style="width: 250px;">
                              
                                <%--<option value=""><%=MyBase.GetResourceString("C_SelProject")%></option>--%>
                           
                                </select>
                        </div>
                    </div>
                    <!-- Added By Vyankat B On 24-11-2025 - Search Box -->
                    <div style="display: flex; align-items: center; background: white; border-radius: 0.25rem; border: 1px solid #d1d5db; overflow: hidden; height: 2rem; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
                        <input type="text" id="searchInput" placeholder="Search.." oninput="handleSearchInput()" style="border: none; outline: none; padding: 0.25rem 0.5rem; flex: 1; background: transparent; height: 100%; font-size: 11.5px;">
                        <button id="searchBtn" onclick="handleSearchInput()" style="background: #f3f4f6; border: none; padding: 0.25rem 0.5rem; color: #374151; cursor: pointer; height: 100%; display: flex; align-items: center; border-left: 1px solid #d1d5db;">
                            <i class="fas fa-search" style="font-size: 11.5px;"></i>
                        </button>
                    </div>
                    <!-- End of Added By Vyankat B On 24-11-2025 -->
                </div>
                <div style="display: flex; align-items: center; gap: 0.5rem;">
                    <% If m_blnAddAccess Then %>
                    <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_EditLessonsLearnt" aria-controls="offcanvasWithBothOptions" class="btn borderbtn" id="NewLessonsLearntBtn" onclick="openNewLessonsLearntForm()" title="New Lessons Learnt">
                        <i class="fas fa-plus"></i>
                        <%=MyBase.GetResourceString("C_Add")%>
                    </a>
                    <%End If %>
                   
                    <% If m_blnDeleteAccess Then %>
                     <button class="btn borderbtn" id="deleteLessonsLearntBtn" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Delete")%>"><%=MyBase.GetResourceString("C_Delete")%></button>
                    <%End If %>
                    <a href="javascript:;" class="clearalllink pe-3" id="SelectAllBtn" onclick="selectAllLessonsLearnt()" data-bs-toggle="tooltip" title="Select All">
                        <strong><%=MyBase.GetResourceString("C_SelectAll")%></strong>
                    </a>
                    <a href="javascript:;" class="clearalllink pe-3" id="ClearAllBtn" onclick="clearAllLessonsLearnt()" data-bs-toggle="tooltip" title="Clear All">
                        <strong><%=MyBase.GetResourceString("C_ClearAll")%></strong>
                    </a>
                    <a href="javascript:;" class="clearalllink pe-3" id="FiltersBtn" onclick="showFiltersPanel()" data-bs-toggle="tooltip" title="Filters">
                        <strong><%=MyBase.GetResourceString("C_Filters")%></strong>
                    </a>
                    <a href="javascript:;" class="clearalllink pe-3" id="HelpBtn" data-bs-toggle="tooltip" title="Help">
                        <strong>?</strong>
                    </a>
                </div>
            </div>
        </div>        
        <div class="content">
            <table id="LessonsLearntTbl" class="table table-stripped table-responsive newTblStyle">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_ProblemDescription")%></th>
                        <th><%=MyBase.GetResourceString("C_Solution")%></th>
                        <th><%=MyBase.GetResourceString("C_PreventiveAction")%></th>
                        <th><%=MyBase.GetResourceString("C_ReferredDocument")%></th>
                        <th><%=MyBase.GetResourceString("C_ProblemType")%></th>
                        <th style="width: 40px;">
                            <input type="checkbox" id="chkSelectAll" class="chckHead" title="Select All" />
                        </th>
                    </tr>
                </thead>
                <tbody id="LessonsLearntTbl_body">
                    
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
            <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
                id="offcanvas_EditLessonsLearnt">
                <div class="offcanvas-body">
                    <div class="Edit_Details">
                        <div class="graybg container-fluid py-1 mb-2">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h5 class="pgtitle mb-0">
                                        <%--<%=MyBase.GetResourceString("C_LessonsLearnt")%>--%>
                                        <%=MyBase.GetResourceString("C_LessonsLearntDetails")%>
                                    </h5>
                                </div>
                                <div class="col-auto">
                                    <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close" data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');" aria-label="Close">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row my-2">
                            <div class="col-sm-12 ">
                                <div class="row">
                                    <div class="col-sm-4">
                                    </div>
                                    <div class="col-sm-8 text-end">
                                        <% If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
                                        <button class="btn btnyellow" id="saveLessonsLearntBtn" data-bs-toggle="tooltip" title="Save" onclick="saveLessonsLearnt(false)"><%=MyBase.GetResourceString("C_Save")%></button>
                                        <%End If %>
                                        <% If m_blnAddAccess = True Then %>
                                        <button class="btn btnyellow" id="saveandAddLessonsLearntBtn" data-bs-toggle="tooltip" title="Save and Add" onclick="saveLessonsLearnt(true)"><%=MyBase.GetResourceString("C_SaveAdd")%></button>
                                        <%End If %>
                                 
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
                                  <%--Commented By Vaibhav K on 30-01-24 for collapse issue--%>

                                <%--    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#EditDetailsTab" aria-expanded="true">
                                        <%=MyBase.GetResourceString("C_LessonsLearntDetails")%>
                                    </button>--%>
                                  <%--End of Commented By Vaibhav K on 30-01-24 for collapse issue--%>


                                </h2>
                                <div id="EditDetailsTab" class="accordion-collapse collapse show">
                                    <div class="accordion-body">
                                        <div class="EditContent">
                                            <div class="row">
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="ProblemDescriptionEdit" class="required text-end"><%=MyBase.GetResourceString("C_ProblemDescription")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="ProblemDescriptionEdit" rows="4"  maxlength="500"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="SolutionEdit" class="required text-end"><%=MyBase.GetResourceString("C_Solution")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="SolutionEdit" rows="4"  maxlength="500"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="PreventiveActionEdit" class="required text-end"><%=MyBase.GetResourceString("C_PreventiveAction")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <textarea class="form-control" id="PreventiveActionEdit" rows="4"  maxlength="500"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="ReferredDocumentEdit" class="text-end"><%=MyBase.GetResourceString("C_ReferredDocument")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <input type="text" class="form-control" id="ReferredDocumentEdit"  maxlength="500"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="ProblemTypeEdit" class="required text-end"><%=MyBase.GetResourceString("C_ProblemType")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                         

                                                            <%CommonFunctions.HTMLControls.DrawComboBox("MilestoneEdit", "usp_Whizible2_Sel_tbl_PM_LessonProblemTypes",,, "class='selectpicker' data-live-search='true' ",,,) %>
                                     

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-2 d-flex justify-content-end">
                                                            <label for="PublishToKnowledgeEdit" class="text-end"><%=MyBase.GetResourceString("C_PublishToKnowledge")%></label>
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <div class="custom_chckbox">
                                                                <input type="checkbox" id="PublishToKnowledgeEdit" />
                                                                <label for="PublishToKnowledgeEdit"></label>
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
                </div>
            </div>
            <!-- Edit Lessons Learnt Section ends -->
        </div>
    </div>
    <div id="deleteConfirm" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-bs-dismiss="modal">
            <div class="modal-dialog ui-draggable">
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" onclick="Close_deleteModel()" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_DeleteConf")%></h4>
                    </div>
                    <div class="modal-body">
                        <p id="txtExcelValidationMessage"><center><%=MyBase.GetResourceString("C_DelLessonsLearnt")%></center></p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn me-2 uncheckbtn" data-bs-dismiss="modal" onclick="Close_deleteModel()"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" id="btnExcelYes" onclick="DeleteRequestDetails()"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
  <div class="clearfix"></div>

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
        if (strUrl.endsWith('/')) {
            strUrl = strUrl.slice(0, -1);
        }
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var SessionProjectID = '<%= Session("intProjectID") %>';
   
        

//Added by Vaibhav K on 30-01-25
        // Bulk delete state
        var isSelectAllActive = false;          // user clicked "Select All"
        var selectedLessonIds = new Set();      // explicitly selected
        var excludedLessonIds = new Set();      // unchecked when Select All is active
        
        //End of Added by Vaibhav K on 30 - 01 - 25


     


        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var AddAccess = '<%=m_blnAddAccess%>';

       
        alertify.set('notifier', 'position', 'top-right');

        var selectedLessonsLearntID = 0;
          //Commented  by Vaibhav K on 30 - 01 - 25 for bulk delete

        //var selectedLessonsLearntIDs = []; 
          //Commented  by Vaibhav K on 30 - 01 - 25 for bulk delete


        var totalRecords = 0;
        var isFirstSaveAndAddInEditMode = false;

        // Loader state (same as Project Profitability)
        var loaderShown = false;
        var loaderStartTime = 0;
        
        // Added By Vyankat B on 26 nov 2025 For special character validation
        var invalidChars = WebConfigSpecialCharacters;
        
        //Added By Vyankat B on 26 nov 2025 - Helper function to check for invalid characters using string contains method
        function hasInvalidChars(text) {
            if (!text || !invalidChars) return false;
            for (var i = 0; i < text.length; i++) {
                if (invalidChars.includes(text.charAt(i))) {
                    return true;
                }
            }
            return false;
        }
        // End of Added By Vyankat B

        function showLoader() {
            var el = document.getElementById('loaderOverlay');
            if (el) { el.style.display = 'block'; }
            loaderShown = true;
            loaderStartTime = Date.now();
        }
        function hideLoader() {
            if (!loaderShown) return;
            var elapsedTime = Date.now() - loaderStartTime;
            var minDisplayTime = 1500;
            var el = document.getElementById('loaderOverlay');
            if (elapsedTime < minDisplayTime) {
                setTimeout(function () {
                    if (el) el.style.display = 'none';
                    loaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                if (el) el.style.display = 'none';
                loaderShown = false;
            }
        }

        $(document).ready(function () {
            $('#LessonsLearntPreloader').hide();

            var hasViewAccess = ViewAccess === 'True' || ViewAccess === true || ViewAccess === 'true';
            var isViewAccessDivVisible = $('#ViewAccess').length > 0 && $('#ViewAccess').is(':visible');
           
            if (!hasViewAccess || isViewAccessDivVisible) {
                return; 
            }

            showLoader();

            $('[data-bs-toggle="tooltip"]').tooltip({
                delay: { show: 0, hide: 0 }
            }).on('shown.bs.tooltip', function() {
                var $this = $(this);
             
                setTimeout(function() {
                    $this.tooltip('hide');
                }, 800);
            });            
          
            $('.selectpicker').not('#ProjectFilter').selectpicker();
                   
            $('#ProjectFilter').removeClass('selectpicker');
            // Initialize with fixed width
            $('#ProjectFilter').selectpicker({
                //title: 'Select Project',
                //noneSelectedText: 'Select Project',
                //width: '250px',
                //style: 'btn-default',
                //liveSearch: true
                //noneSelectedText: 'Select Project',
                //liveSearch: true,
                //width: '250px'

                noneSelectedText: 'Select Project',
                liveSearch: true,
                liveSearchStyle: 'startsWith',
                width: '250px',
                dropupAuto: false,  // prevent auto flip
                size: 5


            });
            
            $('#ProjectFilter').css({
                'width': '250px',
                'max-width': '250px',
                'min-width': '250px'
            });
            
            loadProjectsForLessonsLearnt();
 
            $(document).on('click', function(e) {
                var $target = $(e.target);
                var $bootstrapSelect = $('.bootstrap-select#ProjectFilter');
                var $projectFilter = $('#ProjectFilter');
                
                var isClickOnToggle = $target.closest('.bootstrap-select#ProjectFilter .dropdown-toggle').length > 0 ||
                                     $target.is('.bootstrap-select#ProjectFilter .dropdown-toggle') ||
                                     $target.closest('.dropdown-toggle').length > 0 ||
                                     $target.is('.dropdown-toggle');
                
                var isClickOnMenu = $target.closest('.bootstrap-select#ProjectFilter .dropdown-menu').length > 0 ||
                                   $target.is('.bootstrap-select#ProjectFilter .dropdown-menu');
                
                var isClickOnMenuItem = $target.closest('.bootstrap-select#ProjectFilter .dropdown-menu .dropdown-item').length > 0 ||
                                       $target.is('.bootstrap-select#ProjectFilter .dropdown-menu .dropdown-item');
                
                // Check if click is on the search input or search button
                var isClickOnSearch = $target.closest('#searchInput').length > 0 || 
                                     $target.closest('#searchBtn').length > 0 ||
                                     $target.is('#searchInput') || 
                                     $target.is('#searchBtn');
                
                // Prevent dropdown from opening if clicking on search box
                if (isClickOnSearch) {
                    e.preventDefault();
                    return false;
                }
                
                // If clicking on toggle button, menu, or menu items, don't interfere - let selectpicker handle it
                if (isClickOnToggle || isClickOnMenu || isClickOnMenuItem) {
                    return; // Exit early - don't prevent the event
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
                        
                        // If click is outside the 250px boundary, close dropdown if open
                        if (!isClickWithinDropdown) {
                            // Close dropdown if open
                            if ($bootstrapSelect.hasClass('open')) {
                                $projectFilter.selectpicker('toggle');
                            }
                            // Don't prevent - just close if needed
                            return;
                        }
                        
                        // If click is within dropdown but NOT on toggle button, prevent opening
                        // BUT only if dropdown is not already open (to allow menu item clicks)
                        // AND only if we're certain it's not a toggle button click
                        if (isClickWithinDropdown && !isClickOnToggle && !isClickOnMenu && !isClickOnMenuItem) {
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
 
            $(document).on('hide.bs.select', '#ProjectFilter', function(e) {
                // Allow normal hide behavior
                return true;
            });

            $(document).on('show.bs.select', '#ProjectFilter', function(e) {
        
                var $trigger = $(e.relatedTarget || document.activeElement || e.target);
                var $bootstrapSelect = $('.bootstrap-select#ProjectFilter');
                
                var isClickOnToggle = $trigger.closest('.bootstrap-select#ProjectFilter .dropdown-toggle').length > 0 ||
                                     $trigger.is('.bootstrap-select#ProjectFilter .dropdown-toggle') ||
                                     $trigger.closest('.dropdown-toggle').length > 0 ||
                                     $trigger.is('.dropdown-toggle') ||
                                     $trigger.hasClass('dropdown-toggle');

                if (isClickOnToggle) {
                    return;
                }

                var isClickOnSearch = $trigger.closest('#searchInput').length > 0 || 
                                     $trigger.closest('#searchBtn').length > 0 ||
                                     $trigger.is('#searchInput') || 
                                     $trigger.is('#searchBtn');

                if (isClickOnSearch) {
                    e.preventDefault();
                    return false;
                }

                if ($bootstrapSelect.length > 0) {
                    var dropdownOffset = $bootstrapSelect.offset();
                    if (dropdownOffset) {
                        var dropdownWidth = 250;
                        var dropdownLeft = dropdownOffset.left;
                        var dropdownRight = dropdownLeft + dropdownWidth;
                        var dropdownHeight = $bootstrapSelect.outerHeight();
                        var dropdownTop = dropdownOffset.top;
                        var dropdownBottom = dropdownTop + dropdownHeight;

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
                currentPageNumber = 1;
                $('#searchInput').val('');
                if (selectedProjectID && selectedProjectID !== '' && selectedProjectID !== '0') {
                    $('#NewLessonsLearntBtn').show();
                    $('#deleteLessonsLearntBtn').show();

                    

                    GetAllLessonsLearned();
                } else {
                    $('#NewLessonsLearntBtn').hide();
                    $('#deleteLessonsLearntBtn').hide();
                    GetAllLessonsLearned();


                }
            });
            
            GetAllLessonsLearned();
       
            updateTotalRecords();
            updatePaginationButtons();
         
            $('#NewLessonsLearntBtn').off('click').on('click', function(e) {
                e.preventDefault();
                clearLessonsLearntForm();
            });

            $('#ProblemDescriptionEdit, #SolutionEdit, #PreventiveActionEdit, #ReferredDocumentEdit').on('input', function() {
                $(this).removeClass('is-invalid');
            });

            $('#ProblemTypeEdit, #MilestoneEdit').on('change', function() {
                $('#ProblemTypeEdit, #MilestoneEdit').removeClass('is-invalid');
            });

            $('#offcanvas_EditLessonsLearnt').on('shown.bs.offcanvas', function() {
                $('body').addClass('offcanvas-open');
            });
            
            // Added By Vyankat B On 24-11-2025 - Handle offcanvas hide event (when closed by backdrop click or any other method)
            $('#offcanvas_EditLessonsLearnt').on('hidden.bs.offcanvas', function() {
                // Remove class from body
                $('body').removeClass('offcanvas-open');
            });
            // End of Added By Vyankat B On 24-11-2025

            hideLoader();
            $('#LessonsLearntWrapper').show();
        });

        // Added By Vyankat B On 24-11-2025 -for load projects for dropdown
        function loadProjectsForLessonsLearnt() {
            
            try {
      
                var param = {
                    UserId: parseInt(SessionEmployeeId) || 0,
                    LoginType: SessionLoginType || 'E'
                };
                param = JSON.stringify(param);

                var url = "api/PM_LessonsLearnt/GetProjects";
               // var result = AJAXCallWithResult(url, param, false);
                var result = AJAXCallWithResult("/api/PM_LessonsLearnt/GetProjects", param, false);

                console.log('GetProjects API Response:', result);
                
                // Clear existing options
                var projectDropdown = document.getElementById('ProjectFilter');
                if (projectDropdown) {
                    //projectDropdown.innerHTML = '<option value=""><%=MyBase.GetResourceString("C_SelProject")%></option>';

                    var projectsArray = null;

                    if (result && result.projects && result.projects.projectEntity && Array.isArray(result.projects.projectEntity)) {
                        projectsArray = result.projects.projectEntity;
                    }

                    var defaultProjectID = parseInt(SessionProjectID) || 0;
                   

                    var sessionProjectFound = false;

                    if (projectsArray && projectsArray.length > 0) {
                        projectsArray.forEach(function(project) {

                            var projectID = project.projectID;
                            var projectName = project.projectName;
                            
                            //if (projectID && parseInt(projectID) !== 0 && projectName && projectName.trim() !== '') {

                            if (projectID !== undefined && projectName && projectName.trim() !== '') {

                            var option = document.createElement('option');
                                option.value = projectID;
                                option.textContent = projectName;
                                projectDropdown.appendChild(option);
                                
                                // Check if this is the session project while building the list
                                if (defaultProjectID > -1 && parseInt(projectID) === defaultProjectID) {
                                    sessionProjectFound = true;
                                }
                            }
                        });
                    }
                    
                    // Refresh the selectpicker and maintain fixed width
                    $(projectDropdown).selectpicker('refresh');
                    //// Ensure fixed width is maintained after refresh
                    //var $bsSelect = $('.bootstrap-select#ProjectFilter');
                    //$bsSelect.css({
                    //    'width': '250px',
                    //    'max-width': '250px',
                    //    'min-width': '250px'
                    //});
                    //$('#ProjectFilter').css({
                    //    'width': '250px',
                    //    'max-width': '250px',
                    //    'min-width': '250px',
                    //    //'display': 'none'
                    //});
                    
                    //setTimeout(function() {
                    //    var $select = $('#ProjectFilter');
                    //    $select.css({
                    //        'width': '250px',
                    //        'max-width': '250px',
                    //        'min-width': '250px',
                    //        'display': 'none'
                    //    });
                        
                    //    var $bsSelect = $('.bootstrap-select#ProjectFilter');
                    //    if ($bsSelect.length > 0) {
                    //        var currentStyle = $bsSelect.attr('style') || '';
                    //        currentStyle = currentStyle.replace(/width\s*:\s*[^;]+;?/gi, '');
                    //        currentStyle = currentStyle.replace(/max-width\s*:\s*[^;]+;?/gi, '');
                    //        currentStyle = currentStyle.replace(/min-width\s*:\s*[^;]+;?/gi, '');
                    //        $bsSelect.attr('style', currentStyle + ' width: 250px !important; max-width: 250px !important; min-width: 250px !important; overflow: hidden !important; box-sizing: border-box !important;');
                            
                    //        $bsSelect.css({
                    //            'width': '250px',
                    //            'max-width': '250px',
                    //            'min-width': '250px',
                    //            'overflow': 'hidden',
                    //            'position': 'relative',
                    //            'box-sizing': 'border-box'
                    //        });
                            
                    //        var $container = $bsSelect.parent();
                    //        if ($container.length > 0) {
                    //            $container.css({
                    //                'width': '250px',
                    //                'max-width': '250px',
                    //                'min-width': '250px',
                    //                'overflow': 'hidden',
                    //                'box-sizing': 'border-box'
                    //            });
                    //        }
                            
                    //        $bsSelect.find('.dropdown-toggle').css({
                    //            'width': '100%',
                    //            'max-width': '100%',
                    //            'box-sizing': 'border-box'
                    //        });
                            
                    //        $bsSelect.find('.filter-option, .filter-option-inner, .filter-option-inner-inner').css({
                    //            'max-width': '100%',
                    //            'overflow': 'hidden',
                    //            'box-sizing': 'border-box'
                    //        });
                            
                    //        $bsSelect.find('.dropdown-menu').css({
                    //            'max-width': '250px',
                    //            'width': '250px',
                    //            'box-sizing': 'border-box'
                    //        });
                    //    }
                    //}, 50);
                    
                    // Set session project immediately after refresh if found
                    if (defaultProjectID > -1 && sessionProjectFound) {


                        //Added by Vaibhav K on 30-01-25
                        // Convert to integer safely
                        defaultProjectID = parseInt(defaultProjectID, 10);

                        // If NaN, null, undefined, or invalid → default to 0
                        if (isNaN(defaultProjectID) || defaultProjectID < 0) {
                            defaultProjectID = 0;
                        }
                    //End of Added by Vaibhav K on 30-01-25


                        // Set the value directly on the select element
                        projectDropdown.value = defaultProjectID.toString();
                        // Refresh selectpicker to reflect the change
                        $(projectDropdown).selectpicker('refresh');
                        // Trigger change event to load data
                        $(projectDropdown).trigger('change');
                    }
                }
                
            } catch (error) {
                console.error('Error loading projects:', error);
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Error loading projects: ' + (error.message || error));
            }
        }
        //End of Added By Vyankat B On 24-11-2025 -for load projects for dropdown

        // Added By Vyankat B On 24-11-2025 -for load the all lessons 
        function GetAllLessonsLearned() {
            // Get selected project from dropdown, fallback to session or default
            var selectedProjectID = $('#ProjectFilter').val() ;
            selectedProjectID = parseInt(selectedProjectID);
            
            // Get search text from search input
            var searchText = $('#searchInput').val() || '';
            // Trim and set to null if empty
            if (searchText.trim() === '') {
                searchText = null;
            } else {
                searchText = searchText.trim();
            }
            
            var LessionsParameters = {
                ProjectID: selectedProjectID,
                PageNumber: currentPageNumber,
                PageSize: pageSize,
                SearchText: searchText
            };
            
            //Commeneted and added By Vaibhav K for fixing table layout issue on 02-02-25
            // Destroy existing DataTable if it exists
            //if ($.fn.DataTable.isDataTable('#LessonsLearntTbl')) {
            //    $('#LessonsLearntTbl').DataTable().destroy();
            //}

            if (!$.fn.DataTable.isDataTable('#LessonsLearntTbl')) {
                $("#LessonsLearntTbl").DataTable({
                    paging: false,
                    searching: false,
                    info: false,
                    ordering: false,
                    responsive: true,
                    autoWidth: false,
                    width: "100%",
                    language: {
                        emptyTable: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>"
        },
        columnDefs: [
            { "width": "20%", "targets": 0 },
            { "width": "20%", "targets": 1 },
            { "width": "20%", "targets": 2 },
            { "width": "15%", "targets": 3 },
            { "width": "15%", "targets": 4 },
            { "width": "10%", "targets": 5 }
        ]
    });
        }
            //End of Commeneted and added By Vaibhav K for fixing table layout issue on 02 - 02 - 25



            
            // Clear table body
            $("#LessonsLearntTbl_body").empty();
            
            var param = JSON.stringify(LessionsParameters);
            var response = AJAXCallWithResult("/api/PM_LessonsLearnt/GetLessonsLearned", param, false);
            
            // Check if response is valid
            if (response && response.data) {

                /*commented and added by Vaibhav K on 30-01-25*/

                // Extract data and pagination from response
                //var responseData = response.data;
                
                //// Handle different response structures
                //var data = null;
                //var pagination = null;



            
                //if (Array.isArray(response.data)) {
                //    data = response.data;
                //    pagination = response.pagination || null;
                //}


                         
                //// Update total records and pagination info from pagination if available
                //if (pagination && typeof pagination === 'object') {
                //    totalRecords = pagination.totalRecords !== undefined ? pagination.totalRecords : 0;
                //    currentPageNumber = pagination.currentPage !== undefined ? pagination.currentPage : currentPageNumber;
                //    totalPages = pagination.totalPages !== undefined ? pagination.totalPages : 1;
                //    pageSize = pagination.pageSize !== undefined ? pagination.pageSize : pageSize;                 
                //} else {
                //    totalRecords = (data && Array.isArray(data)) ? data.length : 0;
                //    totalPages = 1;          
                //}



                var data = Array.isArray(response.data) ? response.data : [];
                var pagination = response.pagination || null;

                // APPLY PAGINATION FROM API
                if (pagination) {
                    totalRecords = pagination.totalRecords || 0;

                    //currentPageNumber = pagination.currentPage || 1;


                    totalPages = pagination.totalPages || 1;
                    pageSize = pagination.pageSize || 5;
                } else {
                    totalRecords = data.length;
                    totalPages = 1;
                }

                /*commented and added by Vaibhav K on 30-01-25*/



                
                // Force totalRecords to 0 when no data array or empty array
                if (!data || (Array.isArray(data) && data.length === 0)) {
                    totalRecords = 0;
                    totalPages = 1;
                }
                
                var tbody = $("#LessonsLearntTbl_body");
                tbody.empty(); // Clear any existing rows
                
                // Add rows only if data exists
                if (data && Array.isArray(data)) {

                   

                    /* ===========================
                       EMPTY DATA HANDLING
                    =========================== */
                    if (!data || data.length === 0) {

                        // Reset bulk delete state
                        isSelectAllActive = false;
                        selectedLessonIds.clear();
                        excludedLessonIds.clear();
                        $('#chkSelectAll').hide();
                        

                        // Show empty message row
                        var emptyRow = $('<tr class="no-data-row">');
                        emptyRow.append(
                            $('<td>')
                                .attr('colspan', 6)
                                .addClass('text-center text-muted')
                                .text('<%= MyBase.GetResourceString("C_NoDataAvaible") %>')
    );
                        tbody.append(emptyRow);

                       

                        // Force totals
                        totalRecords = 0;
                        totalPages = 0;
                        currentPageNumber = 1;
                      
                        updateTotalRecords();
                        updatePaginationButtons();

                        return; // stop further rendering
                    }
                    $('#chkSelectAll').show();
                    // Loop through data and create table rows
                    $.each(data, function(index, item) {
                        var lessonId = item.lessonId || item.LessonId;
                        var row = $('<tr>').attr('data-id', lessonId);
                        
                        // Problem Description column
                        var problemDesc = item.problemDescription || '';
                        row.append($('<td>').text(problemDesc));
                        
                        // Solution column
                        var solution = item.solution|| '';
                        row.append($('<td>').text(solution));
                        
                        // Preventive Action column
                        var preventiveAction = item.preventiveAction|| '';
                        row.append($('<td>').text(preventiveAction));
                        
                        // Referred Document column
                        var referedDoc = item.referedDocument || '';
                        row.append($('<td>').text(referedDoc));
                        
                        // Problem Type column
                        var problemType = item.problemType|| '';
                        row.append($('<td>').text(problemType));
                        
                        // Checkbox column (last column)
                        var checkboxCell = $('<td>');
                        if (DeleteAccess === 'True') {
                            var checkbox = $('<input>')
                                .attr('type', 'checkbox')
                                .addClass('chcktbl')
                                .attr('data-id', lessonId)
                                .attr('value', lessonId);
                            checkboxCell.append(checkbox);
                        } else {
                            $("#chkSelectAll").hide();
                            checkboxCell.text('-');
                        }
                        row.append(checkboxCell);
                        
                        tbody.append(row);
                    });
                }

              //Added by Vaibhav K on 30 - 01 - 25 for bulk delete

                // Restore checkbox states after table reload
                $('.chcktbl').each(function () {
                    var id = parseInt($(this).val());

                    if (isSelectAllActive) {
                        $(this).prop('checked', !excludedLessonIds.has(id));
                    } else {
                        $(this).prop('checked', selectedLessonIds.has(id));
                    }
                });
              //End of Added by Vaibhav K on 30 - 01 - 25 for bulk delete


                updateTotalRecords();
                updatePaginationButtons();
       
                $("#LessonsLearntTbl").DataTable({
                paging: false,
                pageLength: 5,
                bLengthChange: false,
                bFilter: false,
                ordering: true,
                responsive: false,
                destroy: true,
                retrieve: true,
                info: false,
                bPaginate: false,
                    language: {
                        emptyTable: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>",
                        zeroRecords: "<%= MyBase.GetResourceString("C_NoDataAvaible")%>"
                    },
                columnDefs: [
                    { "width": "20%", "targets": 0 },
                    { "width": "20%", "targets": 1 },
                    { "width": "20%", "targets": 2 },
                    { "width": "15%", "targets": 3 },
                    { "width": "15%", "targets": 4 },
                    { "width": "10%", "targets": 5 }
                ]
            });
            } else {
                // Error handling
                var tbody = $("#LessonsLearntTbl_body");
                var row = $('<tr>');
                var errorMsg = (response && response.data) ? (typeof response.data === 'string' ? response.data : (response.data.message || '<%= MyBase.GetResourceString("A_ErrLessData")%>')) : '<%= MyBase.GetResourceString("A_ErrLessData")%>';
                row.append($('<td>').attr('colspan', 6).text(errorMsg).css('text-align', 'center').css('color', 'red'));
                $("#chkSelectAll").hide();

                tbody.append(row);
                
                // Reset pagination info on error
                totalRecords = 0;
                totalPages = 1;
                currentPageNumber = 1;
            updateTotalRecords();
            updatePaginationButtons();
                
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ErrorLoad")%>');
            }
        }
        //End of Added By Vyankat B On 24-11-2025 -for load the all lessons 


        //Commented  and added by Vaibhav K on 30 - 01 - 25 for bulk delete

        //Added BY Vyankat B. On 24-11-2025  Function to handle delete button click - delete selected items
       <%-- $("#deleteLessonsLearntBtn").click(function () {
            var selectedItems = [];
            $('.chcktbl:checked').each(function() {
                var lessonId = $(this).data('id') || $(this).val();
                if (lessonId) {
                    selectedItems.push(parseInt(lessonId));
                }
            });
            
            if (selectedItems.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("C_SelectAtLeastOne")%>');
                return;
            }
            
            // Store selected items for deletion
            selectedLessonsLearntIDs = selectedItems;
            $('#deleteConfirm').modal('show');
        });--%>
        //End of Added BY Vyankat B. On 24-11-2025  Function to handle delete button click - delete selected items
        $("#deleteLessonsLearntBtn").click(function () {
        
            if (!isSelectAllActive && selectedLessonIds.size === 0) {
                alertify.error('<%=MyBase.GetResourceString("C_SelectAtLeastOne")%>');
                return;
            }

            $('#deleteConfirm').modal('show');
        });

        //Commented and added by Vaibhav K on 30 - 01 - 25 for bulk delete

        //Added BY Vyankat B. On 24-11-2025 to close the delete model
        function Close_deleteModel() {
            $("#deleteConfirm").modal("hide");
        }
        // End of Added BY Vyankat B. On 24-11-2025 to close the delete model


        //Commented and Added by Vaibhav K on 30 - 01 - 25 for bulk delete

        // Added BY Vyankat B. On 24-11-2025 to delete the request details
       <%-- function DeleteRequestDetails() {
            var selectedIDs = selectedLessonsLearntIDs || [];
            if (!selectedIDs || selectedIDs.length === 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("C_SelectAtLeastOne")%>');
            Close_deleteModel();
                return;
            }
            
            // Convert array to comma-separated string for bulk delete
            var lessonIdsString = selectedIDs.join(',');
            
            // Prepare request for bulk delete
            var deleteParam = {
                LessonIds: lessonIdsString
            };
            
            var param = JSON.stringify(deleteParam);
            var response = AJAXCallWithResult("/api/PM_LessonsLearnt/DeleteMultipleLessonsLearnt", param, false);
            
            Close_deleteModel();
            
            // Check response - response format: { data: { deletedCount: number, message: string } }
            if (response && response.deletedCount > 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('<%=MyBase.GetResourceString("A_Deleted")%>');

                // Clear selection
                selectedLessonsLearntIDs = [];
                $('.chcktbl').prop('checked', false);
                $('#chkSelectAll').prop('checked', false);
                
            // Reload data
                GetAllLessonsLearned();
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_UnableDel")%>');
            }
        }--%>
        //End of Added BY Vyankat B. On 24-11-2025 to delete the request details
        function DeleteRequestDetails() {

            if (!isSelectAllActive && selectedLessonIds.size === 0) {
                alertify.error('<%=MyBase.GetResourceString("C_SelectAtLeastOne")%>');
        Close_deleteModel();
        return;
    }

    var request = {
        ProjectID: parseInt($('#ProjectFilter').val()) || SessionProjectID,
        IsDeleteAll: isSelectAllActive,
        SelectedLessonIds: isSelectAllActive ? null : Array.from(selectedLessonIds).join(','),
        ExcludedLessonIds: isSelectAllActive ? Array.from(excludedLessonIds).join(',') : null,
        SearchText: $('#searchInput').val() || null
    };

    var response = AJAXCallWithResult(
        "/api/PM_LessonsLearnt/DeleteMultipleLessonsLearnt",
        JSON.stringify(request),
        false
    );

    Close_deleteModel();


            //Commented and Added by Vaibhav K on 30 - 01 - 25

    //if (response && response.data && response.data.success === true) {
    //    alertify.success(response.data.message);

    //    // Reset state
    //    isSelectAllActive = false;
    //    selectedLessonIds.clear();
    //    excludedLessonIds.clear();

    //    $('#chkSelectAll').prop('checked', false);

    //    currentPageNumber = 1;
    //    GetAllLessonsLearned();
    //}

            if (response && (response.success === true || (response.data && response.data.success === true))) {

                var msg = response.message || (response.data && response.data.message) || 'Deleted successfully';
                alertify.success('<%=MyBase.GetResourceString("A_Deleted")%>');


                // Reset state
                isSelectAllActive = false;
                selectedLessonIds.clear();
                excludedLessonIds.clear();

                $('#chkSelectAll').prop('checked', false);
                $('.chcktbl').prop('checked', false);

                currentPageNumber = 1;
                GetAllLessonsLearned();

            }

            //End of Commented and Added by Vaibhav K on 30 - 01 - 25




    else {
                alertify.error('<%=MyBase.GetResourceString("A_UnableDel")%>');
            }
        }

        //Commented and Added by Vaibhav K on 30 - 01 - 25 for bulk delete




        // Added BY Vyankat B. On 24-11-2025 - Function to clear lessons learnt form
        function clearLessonsLearntForm() {
            try {
                if ($('#ProblemDescriptionEdit').length) $('#ProblemDescriptionEdit').val('');
                if ($('#SolutionEdit').length) $('#SolutionEdit').val('');
                if ($('#PreventiveActionEdit').length) $('#PreventiveActionEdit').val('');
                if ($('#ReferredDocumentEdit').length) $('#ReferredDocumentEdit').val('');

                //commented and Added by Vaibhav K on 30-01-25

                //if ($('#ProblemTypeEdit').length) {
                //    $('#ProblemTypeEdit').val('');
                //    if (typeof $.fn.selectpicker !== 'undefined') {
                //        $('#ProblemTypeEdit').selectpicker('refresh');
                //    }
                //}
                if (typeof $.fn.selectpicker !== 'undefined') {
                    $('#ProblemTypeEdit, #MilestoneEdit').each(function () {
                        $(this).selectpicker('val', '');   // Proper reset
                        $(this).selectpicker('refresh');
                    });
                }

                //End of commented and added by Vaibhav K  on 30-01-25



                if ($('#PublishToKnowledgeEdit').length) $('#PublishToKnowledgeEdit').prop('checked', false);
                
                // Clear validation highlights
                $('.form-control, textarea, select').removeClass('is-invalid');
                
                
                if (!isFirstSaveAndAddInEditMode && selectedLessonsLearntID === 0) {
               
                }
           
            } catch (error) {
                console.warn('Error in clearLessonsLearntForm:', error);
            }
        }
        //End of Added BY Vyankat B. On 24-11-2025 - Function to clear lessons learnt form

        // Added BY Vyankat B. On 24-11-2025 - Function to save lessons learnt
        function saveLessonsLearnt(saveAndAdd) {
        
            // Get ProjectID from dropdown, fallback to session or default
            var projectID = $('#ProjectFilter').val() || SessionProjectID;
            projectID = parseInt(projectID);
            if (!projectID || projectID <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Valid Project ID is required');
                return;
            }

            // Clear previous validation highlights
            $('.form-control, textarea, select').removeClass('is-invalid');
            
            // Get CreatedBy/ModifiedBy from session
            var createdBy = UserName || SessionEmployeeId || '';
            if (!createdBy || createdBy.trim() === '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('User information is required');
                return;
            }
            var problemDescription = $('#ProblemDescriptionEdit').val().trim();
            if (!problemDescription) {
                $('#ProblemDescriptionEdit').addClass('is-invalid');
                $('#ProblemDescriptionEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ProbDes")%> ');
                return;
            }
            // Added By Vyankat B on [Date] For special character validation
            if (hasInvalidChars(problemDescription)) {
                $('#ProblemDescriptionEdit').addClass('is-invalid');
                $('#ProblemDescriptionEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<span style="font-size:14px;"><%= MyBase.GetResourceString("C_ProblemDescription")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                return;
            }
            // End of Added By Vyankat B
            
            var solution = $('#SolutionEdit').val().trim();
            if (!solution) {
                $('#SolutionEdit').addClass('is-invalid');
                $('#SolutionEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_Soln")%> ');
                return;
            }
            // Added By Vyankat B on [Date] For special character validation
            if (hasInvalidChars(solution)) {
                $('#SolutionEdit').addClass('is-invalid');
                $('#SolutionEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<span style="font-size:14px;"><%= MyBase.GetResourceString("C_Solution")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                return;
            }
            // End of Added By Vyankat B
            
            var preventiveAction = $('#PreventiveActionEdit').val().trim();
            if (!preventiveAction) {
                $('#PreventiveActionEdit').addClass('is-invalid');
                $('#PreventiveActionEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_PrevAct")%> ');
                return;
            }
            // Added By Vyankat B on [Date] For special character validation
            if (hasInvalidChars(preventiveAction)) {
                $('#PreventiveActionEdit').addClass('is-invalid');
                $('#PreventiveActionEdit').focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<span style="font-size:14px;"><%= MyBase.GetResourceString("C_PreventiveAction")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                return;
            }
            // End of Added By Vyankat B
            
            // Get ProblemType - check both ProblemTypeEdit and MilestoneEdit (in case the combo box uses different ID)
            var problemType = $('#ProblemTypeEdit').val() || $('#MilestoneEdit').val();
            if (!problemType || problemType.trim() === '' || problemType.trim() === 'Select Problem Type') {
                $('#ProblemTypeEdit, #MilestoneEdit').addClass('is-invalid');
                $('#ProblemTypeEdit, #MilestoneEdit').first().focus();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_ProbType")%>');
                return;
            }
            
            // Added By Vyankat B on [Date] For special character validation - Referred Document
            var referredDocument = $('#ReferredDocumentEdit').val().trim();
            if (referredDocument && referredDocument !== '') {
                if (hasInvalidChars(referredDocument)) {
                    $('#ReferredDocumentEdit').addClass('is-invalid');
                    $('#ReferredDocumentEdit').focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<span style="font-size:14px;"><%= MyBase.GetResourceString("C_ReferredDocument")%> <%= MyBase.GetResourceString("A_InvalidChars")%></span>');
                    return;
                }
            }
            // End of Added By Vyankat B
            
            // Check if we're in edit mode (selectedLessonsLearntID > 0)
            // But if it's Save and Add and we've already done first update, treat as insert
            var isEditMode = false;
            if (selectedLessonsLearntID && selectedLessonsLearntID > 0) {
                // If Save and Add and already did first update, treat as insert
                if (saveAndAdd && isFirstSaveAndAddInEditMode) {
                    isEditMode = false; // Insert mode
                } else {
                    isEditMode = true; // Update mode
                }
            }
            
            // Hide Save button immediately when clicking Save and Add in edit mode
            if (isEditMode && saveAndAdd) {

                //Commented by Vaibhav K on 03-02-25 as it's hiding save button
                // Hide immediately - try multiple selectors to ensure we find it
                //$('#saveLessonsLearntBtn').hide();
                //$('button#saveLessonsLearntBtn').hide();
                //$('button[id="saveLessonsLearntBtn"]').hide();
                //$('button[onclick*="saveLessonsLearnt(false)"]').hide();
                //Commented by Vaibhav K on 03 - 02 - 25

            }
            
            var apiUrl = '';
            var requestParams = {};
            
            if (isEditMode) {
                // Update mode - use UpdateLessonsLearnt API
                apiUrl = "/api/PM_LessonsLearnt/UpdateLessonsLearnt";
                requestParams = {
                    LessonId: selectedLessonsLearntID,
                    ProjectID: projectID,
                    ProblemDescription: problemDescription,
                    Solution: solution,
                    PreventiveAction: preventiveAction,
                    ReferedDocument: referredDocument || null,
                    ProblemType: problemType.trim(),
                    PublishToKM: $('#PublishToKnowledgeEdit').is(':checked'),
                    ModifiedBy: createdBy
                };
            } else {
                // Insert mode - use InsertLessonsLearnt API
                apiUrl = "/api/PM_LessonsLearnt/InsertLessonsLearnt";
                requestParams = {
                    ProjectID: projectID,
                    ProblemDescription: problemDescription,
                    Solution: solution,
                    PreventiveAction: preventiveAction,
                    ReferedDocument: referredDocument || null,
                    ProblemType: problemType.trim(),
                    PublishToKM: $('#PublishToKnowledgeEdit').is(':checked'),
                    CreatedBy: createdBy
                };
            }
            
            var param = JSON.stringify(requestParams);
            var response = AJAXCallWithResult(apiUrl, param, false);
            
            
            // Check response - handle both insert and update responses
            var isSuccess = false;
            if (isEditMode) {
                // Update response check
                if (response && (response.status === "SUCCESS" || 
                    (response.data && (response.data.success === true || response.data.Success === true)) ||
                    (response.success === true))) {
                    isSuccess = true;
                }
            } else {
                // Insert response check
                if (response && (response.success === true || response.data && response.data.lessonId) ||
                    (response.data && (response.data.success === true || response.data.Success === true))) {
                    isSuccess = true;
                }
            }
            
            if (isSuccess) {
                alertify.set('notifier', 'position', 'top-right');
                // Use A_Added for insert operations, A_Updated for update operations
                if (isEditMode) {
                    alertify.success('<%=MyBase.GetResourceString("A_Updated")%>');
                } else {
                    alertify.success('<%=MyBase.GetResourceString("A_Added")%>');
                }
                
                // Handle edit mode with Save and Add
                if (selectedLessonsLearntID && selectedLessonsLearntID > 0 && saveAndAdd) {
                    if (!isFirstSaveAndAddInEditMode) {
                        // First time Save and Add in edit mode - update record, hide Save button, keep selectedLessonsLearntID
                        isFirstSaveAndAddInEditMode = true;

                        //commented by Vaibhav K on 03-02-25
                        //$('#saveLessonsLearntBtn').hide();
                        //End of commented by Vaibhav K on 03 - 02 - 25

                        // Don't reset selectedLessonsLearntID - keep it for tracking
                    } else {
                        // Second time Save and Add in edit mode - insert new record, but keep Save button hidden
                        selectedLessonsLearntID = 0;
                        isFirstSaveAndAddInEditMode = false;
                        // Keep Save button hidden during Save and Add workflow
                        //commented by Vaibhav K on 03-02-25
                        //$('#saveLessonsLearntBtn').hide();
                        //End of commented by Vaibhav K on 03 - 02 - 25

                    }
                } else if (!saveAndAdd) {
                    // Regular Save - reset everything and show Save button
                    selectedLessonsLearntID = 0;
                    isFirstSaveAndAddInEditMode = false;
                    $('#saveLessonsLearntBtn').show();
                } else {
                    // Insert mode Save and Add - show Save button (only hide in edit mode)
                    selectedLessonsLearntID = 0;
                    isFirstSaveAndAddInEditMode = false;
                    $('#saveLessonsLearntBtn').show();
                }
                
                    // Reset to first page and refresh the table
                    currentPageNumber = 1;
                    GetAllLessonsLearned();
                
            if (saveAndAdd) {
                clearLessonsLearntForm();
            } else {
                    // Save and close - close offcanvas
                var offcanvas = bootstrap.Offcanvas.getInstance(document.getElementById('offcanvas_EditLessonsLearnt'));
                if (offcanvas) {
                    offcanvas.hide();
                }
                }
            }
            //added by Vaibhav K for validation error on 30-01-25
            else {
                alertify.set('notifier', 'position', 'top-right');

                // Handle duplicate record error from API
                if (response && response.error) {
                    alertify.error(response.error);   // Shows: Lessons Learnt already exist
                }
                else if (response && response.message) {
                    alertify.error(response.message);
                }
                else {
                    alertify.error('Unable to save or update Lessons Learnt. Please try again.');
                }

                return; // Stop further execution
            }
            //End of added by Vaibhav K for validation error on 30-01-25






        }
        //End of Added BY Vyankat B. On 24-11-2025 - Function to save lessons learnt

        //Commented and Added by Vaibhav K on 30 - 01 - 25 for bulk delete

        // Added BY Vyankat B. On 24-11-2025 - Function to select all lessons learnt
        //function selectAllLessonsLearnt() {
        //    $('.chcktbl').prop('checked', true);
        //    updateSelectAllCheckbox();
        //}

        //// End of Added BY Vyankat B. On 24-11-2025 - Function to select all lessons learnt

        //// Added BY Vyankat B. On 24-11-2025 - Function to clear all lessons learnt
        //function clearAllLessonsLearnt() {
        //    $('.chcktbl').prop('checked', false);
        //    updateSelectAllCheckbox();
        //}
        //End of Added BY Vyankat B. On 24-11-2025 - Function to clear all lessons learnt

        function selectAllLessonsLearnt() {
            isSelectAllActive = true;
            selectedLessonIds.clear();
            excludedLessonIds.clear();

            // Just reflect UI for current page
            $('.chcktbl').prop('checked', true);
            $('#chkSelectAll').prop('checked', true);
        }
        function clearAllLessonsLearnt() {
            isSelectAllActive = false;
            selectedLessonIds.clear();
            excludedLessonIds.clear();

            $('.chcktbl').prop('checked', false);
            $('#chkSelectAll').prop('checked', false);
        }

        //End of Commented and Added by Vaibhav K on 30 - 01 - 25 for bulk delete





     
      //Commented and Added by Vaibhav K on 30 - 01 - 25 for bulk delete
        // Added BY Vyankat B. On 24-11-2025 - Function to update select all checkbox state
        //function updateSelectAllCheckbox() {
        //    var totalCheckboxes = $('.chcktbl').length;
        //    var checkedCheckboxes = $('.chcktbl:checked').length;

        //    // Update the select all checkbox state
        //    if (totalCheckboxes > 0 && checkedCheckboxes === totalCheckboxes) {
        //        $('#chkSelectAll').prop('checked', true);
        //    } else {
        //        $('#chkSelectAll').prop('checked', false);
        //    }
        //}

        // Check or Uncheck All checkboxes
        //$(document).on('change', '.chckHead', function() {
        //    var checked = $(this).is(":checked");
        //    if (checked) {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", true);
        //        });
        //    } else {
        //        $(".chcktbl").each(function () {
        //            $(this).prop("checked", false);
        //        });
        //    }
        //});
        $(document).on('change', '#chkSelectAll', function () {
            if (this.checked) {
                isSelectAllActive = true;
                selectedLessonIds.clear();
                excludedLessonIds.clear();

                $('.chcktbl').prop('checked', true);
            } else {
                // user unchecks Select All
                isSelectAllActive = false;
                selectedLessonIds.clear();
                excludedLessonIds.clear();

                $('.chcktbl').prop('checked', false);
            }
        });



        //End of Added BY Vyankat B. On 24-11-2025 - Function to update select all checkbox state

        // Changing state of CheckAll checkbox when individual checkboxes are clicked
        $(document).on('change', '.chcktbl', function (e) {
            e.stopPropagation(); // Prevent row click event

                    //Commented and Added by Vaibhav K on 30 - 01 - 25 for bulk delete

            //updateSelectAllCheckbox();

           

            var lessonId = parseInt($(this).val());
            if (!lessonId) return;

            if (isSelectAllActive) {

                // ❗ ANY uncheck must uncheck Select All
                if (!this.checked) {
                    excludedLessonIds.add(lessonId);
                    $('#chkSelectAll').prop('checked', false);
                } else {
                    excludedLessonIds.delete(lessonId);
                }

                //// Select-all mode → track exclusions
                //if ($(this).is(':checked')) {
                //    excludedLessonIds.delete(lessonId);
                //} else {
                //    excludedLessonIds.add(lessonId);
                //}
            } else {
                // Normal mode → track inclusions
                if ($(this).is(':checked')) {
                    selectedLessonIds.add(lessonId);
                } else {
                    selectedLessonIds.delete(lessonId);
                }
            }

            updateHeaderCheckboxState();
  //End of Commented and Added by Vaibhav K on 30 - 01 - 25 for bulk delete


        });

        // Added By Vyankat B On 24-11-2025 - Function to handle search input for all columns
        function handleSearchInput() {
            currentPageNumber = 1;
            GetAllLessonsLearned();
        }
        // End of Added By Vyankat B On 24-11-2025

        // Added By Vyankat B On 24-11-2025 - Function to show filters panel
        function showFiltersPanel() {
            alertify.set('notifier', 'position', 'top-right');
            alertify.info('Filters panel will be implemented');
        }
        //End of Added By Vyankat B On 24-11-2025 - Function to show filters panel



        // Added By Vyankat B On 24-11-2025 - Function to open attachment modal
        function openAttachmentModal(fieldName) {
            // If not in edit mode (selectedLessonsLearntID is 0 or not set), show both Save and Save and Add buttons
            if (!selectedLessonsLearntID || selectedLessonsLearntID === 0) {
                // Ensure form is open
                var offcanvasElement = document.getElementById('offcanvas_EditLessonsLearnt');
                var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
                if (!offcanvas) {
                    offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                }
                offcanvas.show();
                
                // Show both Save and Save and Add buttons when not in edit mode
                $('#saveLessonsLearntBtn').show();
                $('#saveandAddLessonsLearntBtn').show();
            }
            
            // TODO: Implement attachment modal
            alertify.set('notifier', 'position', 'top-right');
            alertify.info('Attachment modal will be implemented for ' + fieldName);
        }
        //End of Added By Vyankat B On 24-11-2025 - Function to open attachment modal

        //  Added By Vyankat B On 24-11-2025 - Function to open new lessons learnt form
        function openNewLessonsLearntForm() {
            // Reset edit mode flags
            selectedLessonsLearntID = 0;
            isFirstSaveAndAddInEditMode = false;
            
            clearLessonsLearntForm();
            
            // Added By Vyankat B on [Date] - Show buttons based on AddAccess for Add mode
            // In Add mode: Show Save button if AddAccess, Show Save and Add if AddAccess
            if (AddAccess === 'True' || AddAccess === true || AddAccess === 'true') {
                $('#saveLessonsLearntBtn').show();
                $('#saveandAddLessonsLearntBtn').show();
            } else {
                $('#saveLessonsLearntBtn').hide();
                $('#saveandAddLessonsLearntBtn').hide();
            }
            // End of Added By Vyankat B

         //Added By Vaibhav K on 30-01-24 for seting problem type dropdown issue

            // Ensure Problem Type shows placeholder in Add mode
            $('#ProblemTypeEdit, #MilestoneEdit').selectpicker('val', '');
            $('#ProblemTypeEdit, #MilestoneEdit').selectpicker('refresh');
            clearLessonsLearntForm();
         //End of Added By Vaibhav K on 30-01-24 for seting problem type dropdown issue

            
            //var offcanvasElement = document.getElementById('offcanvas_EditLessonsLearnt');

            /*commented and added by Vaibhav K for top scroll issue on 30-01-25*/

            //var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
            //if (!offcanvas) {
            //    offcanvas = new bootstrap.Offcanvas(offcanvasElement);
            //}
            //offcanvas.show();
            var offcanvasEl = document.getElementById('offcanvas_EditLessonsLearnt');
            if (offcanvasEl) {
                var oc = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);

                offcanvasEl.addEventListener('shown.bs.offcanvas', function () {
                    var body = offcanvasEl.querySelector('.offcanvas-body');
                    if (body) {
                        body.scrollTop = 0;
                    }
                }, { once: true });

                oc.show();
            }
            /*End of commented and added by Vaibhav K on 30-01-25*/




            // Add class to body immediately
            $('body').addClass('offcanvas-open');



        }
        //End of Added By Vyankat B On 24-11-2025 - Function to open new lessons learnt form

        //Added By Vyankat B On 24-11-2025 - Function to load lessons learnt data
        function loadLessonsLearntData() {
            // TODO: Implement API call to load data
            updateTotalRecords();
            updatePaginationButtons();
        }
        //End of Added By Vyankat B On 24-11-2025 - Function to load lessons learnt data

        // Pagination variables
        var currentPageNumber = 1;
        var totalPages = 1;
        var pageSize = 5;
        
        // Custom Pagination Functions
        function goToPreviousPage() {
            if (currentPageNumber > 1) {
                currentPageNumber = currentPageNumber - 1;
                GetAllLessonsLearned();
            }
        }
        function goToNextPage() {
            if (currentPageNumber < totalPages) {
                currentPageNumber = currentPageNumber + 1;
                GetAllLessonsLearned();
            }
        }

        // Added By Vyankat B On 24-11-2025 - update the total record
        function updateTotalRecords() {
            var totalRecordsElement = document.getElementById('totalRecords');
            if (!totalRecordsElement) return;            
            var recordCount = totalRecords || 0;

            if (recordCount === 0 && $.fn.DataTable.isDataTable('#LessonsLearntTbl')) {
                var info = $('#LessonsLearntTbl').DataTable().page.info();
                var dataTableCount = info.recordsTotal || 0;
                // Exclude "no data" rows from count
                var noDataRows = $('#LessonsLearntTbl tbody tr.no-data-row').length;
                recordCount = Math.max(0, dataTableCount - noDataRows);
            } else if (recordCount === 0) {
                // Fallback: count rows but exclude "no-data-row"
                var table = document.getElementById('LessonsLearntTbl');
                if (table) {
                    var tbody = table.getElementsByTagName('tbody')[0];
                    var rows = tbody ? tbody.getElementsByTagName('tr') : [];
                    var noDataRows = tbody ? tbody.querySelectorAll('tr.no-data-row').length : 0;
                    recordCount = Math.max(0, rows.length - noDataRows);
                }
            }           
            totalRecordsElement.textContent = 'Total Records: ' + recordCount;
        }
        //End of Added By Vyankat B On 24-11-2025 - update the total record

        // Added By Vyankat B On 24-11-2025 - update the pagination
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
        //End of Added By Vyankat B On 24-11-2025 - update the pagination

        // Update total records when table is drawn
        $('#LessonsLearntTbl').on('draw.dt', function() {
            updateTotalRecords();
            updatePaginationButtons();
        });

        //Commented by Vaibhav K
        // Handle row click to open edit form
        //$(document).on('click', '#LessonsLearntTbl tbody tr', function(e) {
        //    // Don't trigger if clicking on checkbox, checkbox cell (last td), or button
        //    if ($(e.target).is('input[type="checkbox"]') || 
        //        $(e.target).closest('input[type="checkbox"]').length ||
        //        $(e.target).is('td:last-child') ||
        //        $(e.target).closest('td:last-child').length) {
        //        return;
        //    }
        //    if ($(e.target).is('button') || $(e.target).closest('button').length) {
        //        return;
        //    }
            
        //    var row = $(this);
        //    var lessonsLearntId = row.data('id') || 0;
        //    if (lessonsLearntId > 0) {
        //        selectedLessonsLearntID = lessonsLearntId;
        //        // Load data and open edit form
        //        openEditLessonsLearntForm(lessonsLearntId);
        //    }
        //});
        //End of Commented by Vaibhav K
        // Open edit form ONLY when Problem Description column is clicked
        $(document).on('click', '#LessonsLearntTbl tbody td:first-child', function (e) {

            // Prevent if somehow checkbox or button is inside
            if ($(e.target).is('input, button') || $(e.target).closest('input, button').length) {
                return;
            }

            var row = $(this).closest('tr');
            var lessonsLearntId = row.data('id') || 0;

            if (lessonsLearntId > 0) {
                selectedLessonsLearntID = lessonsLearntId;
                openEditLessonsLearntForm(lessonsLearntId);
            }
        });






        // Added By Vyankat B On 24-11-2025-Function to open edit form
        function openEditLessonsLearntForm(lessonsLearntId) {         
            selectedLessonsLearntID = lessonsLearntId;
            isFirstSaveAndAddInEditMode = false; // Reset flag when opening edit form

            var hasEditAccess = EditAccess === 'True' || EditAccess === true || EditAccess === 'true';
            var hasAddAccess = AddAccess === 'True' || AddAccess === true || AddAccess === 'true';
            
            if (hasEditAccess) {
                $('#saveLessonsLearntBtn').show();
            } else {
                $('#saveLessonsLearntBtn').hide();
            }
            
            if (hasEditAccess && hasAddAccess) {
                $('#saveandAddLessonsLearntBtn').show();
            } else {
                $('#saveandAddLessonsLearntBtn').hide();
            }
            // End of Added By Vyankat B
            
            // Call API to get lesson learnt data by ID
            var requestParam = {
                LessonId: lessonsLearntId
            };
            var param = JSON.stringify(requestParam);
            var response = AJAXCallWithResult("/api/PM_LessonsLearnt/GetLessonsLearntByID", param, false);
            
            // Open offcanvas first
            var offcanvasElement = document.getElementById('offcanvas_EditLessonsLearnt');
            var offcanvas = bootstrap.Offcanvas.getInstance(offcanvasElement);
            if (!offcanvas) {
                offcanvas = new bootstrap.Offcanvas(offcanvasElement);
            }
            offcanvas.show();
            // Add class to body immediately
            $('body').addClass('offcanvas-open');
            
            // Check if response is valid and populate form
            if (response && response.data) {
                var lessonData = null;
                
                if (response.data) {
                    lessonData = response.data;
                } 
                if (lessonData) {
                    // Populate form fields
                    var problemDesc = lessonData.problemDescription|| '';
                    $('#ProblemDescriptionEdit').val(problemDesc);
                    
                    var solution = lessonData.solution || '';
                    $('#SolutionEdit').val(solution);
                    
                    var preventiveAction = lessonData.preventiveAction|| '';
                    $('#PreventiveActionEdit').val(preventiveAction);
                    
                    var referedDoc = lessonData.referedDocument|| '';
                    $('#ReferredDocumentEdit').val(referedDoc);
                    
                    var problemType = lessonData.problemType || '';
                    // Set ProblemType in dropdown (check both IDs)

                    //commented by Vaibhav K
                    //if ($('#ProblemTypeEdit').length) {
                    //    $('#ProblemTypeEdit').val(problemType);
                    //    if (typeof $.fn.selectpicker !== 'undefined') {
                    //        $('#ProblemTypeEdit').selectpicker('refresh');
                    //    }
                    //}
                    //if ($('#MilestoneEdit').length) {
                    //    $('#MilestoneEdit').val(problemType);
                    //    if (typeof $.fn.selectpicker !== 'undefined') {
                    //        $('#MilestoneEdit').selectpicker('refresh');
                    //    }
                    //}
                  // End of commented by Vaibhav K
                    setProblemTypeDropdown(problemType);


                    
                    var publishToKM = lessonData.publishToKM || lessonData.PublishToKM || false;
                    $('#PublishToKnowledgeEdit').prop('checked', publishToKM === true || publishToKM === 'true' || publishToKM === 1);
                } else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('<%=MyBase.GetResourceString("A_LessNotF")%>');
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_LessErrLoad")%>');
            }
        }
        //End of Added By Vyankat B On 24-11-2025-Function to open edit form


        //Added By Vaibhav K on 30-01-24 for seting problem type dropdown
        function setProblemTypeDropdown(value) {
            var $ddl = $('#MilestoneEdit, #ProblemTypeEdit');

            if (!$ddl.find("option[value='" + value + "']").length) {
                console.warn("ProblemType value not found in dropdown:", value);
                return;
            }

            $ddl.selectpicker('val', value);   // Correct way
            $ddl.selectpicker('refresh');
        }

        //End of Added By Vaibhav K on 30-01-24 for seting problem type dropdown



         //Added By Vyankat B On 24-11-2025- for adding the ajax function
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

                /*commented and added by Vaibhav K on 30-01-25*/
               
                //error: function (err) {

                    error: function (xhr, status, error) {
                        if (xhr.status === 400 && xhr.responseJSON) {
                            // Return the error response so the calling function can display the message
                            ajaxResult = xhr.responseJSON;
                           
                            // We add both 'status' (bool) and 'Status' (string) to match your codebase's mixed conventions
                            if (ajaxResult.status === undefined) {
                                ajaxResult.status = false;
                                ajaxResult.Status = "FAILURE";
                            }

                        } else {




                            console.log(err);
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                }

                /*End of commented and added by Vaibhav K on 30-01-25*/

            });
            return ajaxResult;
        }
        //End of Added By Vyankat B On 24-11-2025- for adding the ajax function

        //Added by Vaibhav K on 30 - 01 - 25 for bulk delete

        //function updateHeaderCheckboxState() {
        //    if (isSelectAllActive) {
        //        $('#chkSelectAll').prop('checked', true);
        //        return;
        //    }

        //    var total = $('.chcktbl').length;
        //    var checked = $('.chcktbl:checked').length;
        //    $('#chkSelectAll').prop('checked', total > 0 && total === checked);
        //}
        function updateHeaderCheckboxState() {
            if (isSelectAllActive) {
                // Checked only if no exclusions exist
                $('#chkSelectAll').prop('checked', excludedLessonIds.size === 0);
                return;
            }

            var total = $('.chcktbl').length;
            var checked = $('.chcktbl:checked').length;
            $('#chkSelectAll').prop('checked', total > 0 && total === checked);
        }


        // End of Added by Vaibhav K on 30 - 01 - 25 for bulk delete


    </script>
</body>
</html>

