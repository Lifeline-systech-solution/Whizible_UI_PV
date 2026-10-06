<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TaskTypeReport.aspx.vb" Inherits="Whizible.PM_TaskTypeReport" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_TaskTypeReport") %></title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <!-- CSS Files -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    
    <style type="text/css">
        /* CSS CUSTOM PROPERTIES (THEME VARIABLES) - Match main page */
        :root {
            --primary-color: #2563eb;
            --primary-dark: #1e40af;
            --primary-light: #3b82f6;
            --secondary-color: #64748b;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #06b6d4;
            
            --bg-primary: #ffffff;
            --bg-secondary: #f8fafc;
            --bg-tertiary: #f1f5f9;
            --bg-hover: #f8f9fa;
            
            --text-primary: #000000;
            --text-secondary: #000000;
            --text-tertiary: #000000;
            --text-muted: #000000;
            
            --border-color: #e2e8f0;
            --border-radius: 8px;
            --border-radius-sm: 6px;
            --border-radius-lg: 12px;
            
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            
            --transition-base: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            --transition-slow: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        * {
            box-sizing: border-box;
        }
        
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            min-height: 100%;
            overflow-x: hidden;
            overflow-y: auto;
            background: #f5f7fa;
            font-family: 'Roboto', sans-serif;
        }
        
        /* Use same structure as main page */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        /* Match main page CSS structure */
        .reports-top-section {
            background: var(--bg-primary);
            padding: 1.25rem 2rem;
            border-bottom: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        
        /* Ensure parent containers don't clip the dropdown */
        .reports-top-section {
            overflow: visible !important;
        }
        
        .report-header {
            margin-bottom: 1rem;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        
        .report-title {
            font-size: 18px;
            font-weight: normal;
            font-family: 'Roboto', sans-serif;
            color: #1e40af;
            margin: 0 0 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .report-title::before {
            content: '';
            width: 4px;
            height: 2rem;
            background: linear-gradient(180deg, #1e40af 0%, #3b82f6 100%);
            border-radius: 2px;
        }
        
        .report-description {
            color: #000000;
            font-size: 14px;
            font-family: 'Roboto', sans-serif;
            line-height: 1.4;
            margin: 0 0 0.75rem 0;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
            display: block !important;
            visibility: visible !important;
            opacity: 1 !important;
            min-height: 20px;
        }
        
        .reports-middle-section {
            display: flex;
            flex: 1;
            overflow: visible;
            width: 100%;
            gap: 1rem;
            align-items: flex-start;
            min-height: calc(100vh - 200px);
        }
        
        .reports-content {
            flex: 1;
            overflow-y: visible;
            overflow-x: auto;
            padding: 2rem;
            background: var(--bg-secondary);
            min-width: 0;
            min-height: 500px;
        }
        
        .filters-section {
            background: var(--bg-secondary);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            overflow: visible;
            transition: var(--transition-base);
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
            margin-bottom: 1rem;
        }
        
        .filters-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.5rem 1rem;
            background: var(--bg-primary);
            cursor: pointer;
            user-select: none;
            transition: var(--transition-base);
            position: relative;
            z-index: 10;
        }
        
        .filters-header:hover {
            background: var(--bg-hover);
        }
        
        .filters-header h3 {
            margin: 0;
            font-size: 0.75rem;
            font-weight: normal;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            pointer-events: none;
        }
        
        .filters-header i {
            color: var(--primary-color);
            pointer-events: none;
        }
        
        .filters-toggle-icon {
            transition: transform 0.3s ease;
            color: var(--text-secondary);
        }
        
        .filters-section.collapsed .filters-toggle-icon {
            transform: rotate(-90deg);
        }
        
        .filters-content {
            padding: 0.75rem 1rem;
            max-height: 400px;
            transition: max-height 0.3s ease, padding 0.3s ease, opacity 0.3s ease;
            overflow: visible;
            opacity: 1;
            position: relative;
            width: 100%;
            max-width: 100%;
            box-sizing: border-box;
        }
        
        .filters-section.collapsed .filters-content {
            max-height: 0;
            padding: 0 1rem;
            opacity: 0;
        }
        
        .filter-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 0.75rem;
            margin-bottom: 0.75rem;
            overflow: visible !important;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.375rem;
            position: relative;
            overflow: visible !important;
        }
        
        .filter-group label {
            font-size: 12px;
            font-family: 'Roboto', sans-serif;
            font-weight: 500;
            color: #2563eb;
            margin: 0;
        }
        
        .filter-group select,
        .filter-group input {
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 0.375rem 0.625rem;
            font-size: 12px;
            font-family: 'Roboto', sans-serif;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            width: 100%;
            box-sizing: border-box;
        }
        
        .filter-group select:focus,
        .filter-group input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        
        .bs-wrapper {
            display: block !important;
            width: 100% !important;
        }
        
        .filter-actions-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 0.75rem;
            gap: 1rem;
        }
        
        .filter-notes-container {
            flex: 1;
        }
        
        .filter-note {
            font-size: 11px;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }
        
        .filter-note i {
            color: #3b82f6;
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition-base);
            border: none;
        }
        
        .btn.btnyellow {
            background: #f59e0b;
            color: #ffffff;
        }
        
        .btn.btnyellow:hover {
            background: #d97706;
        }
        
        .download-options {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }
        
        .download-link {
            color: #2563eb;
            text-decoration: none;
            font-size: 12px;
            display: flex;
            align-items: center;
            gap: 0.375rem;
            transition: var(--transition-base);
        }
        
        .download-link:hover {
            color: #1e40af;
            text-decoration: underline;
        }
        
        .download-divider {
            color: #cbd5e1;
        }
        
        .data-table-container {
            background: var(--bg-primary);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .table-responsive-custom {
            overflow-x: auto;
            overflow-y: visible;
            min-height: 300px;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }
        
        .table thead th {
            background: var(--bg-tertiary);
            color: var(--text-primary);
            font-weight: 500;
            padding: 0.75rem;
            text-align: left;
            border-bottom: 2px solid var(--border-color);
            white-space: nowrap;
        }
        
        .table tbody td {
            padding: 0.75rem;
            border-bottom: 1px solid var(--border-color);
        }
        
        .table tbody tr:hover {
            background: var(--bg-hover);
        }
        
        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }
        
        .pagination-info {
            font-size: 12px;
            color: var(--text-secondary);
        }
        
        .pagination {
            margin: 0;
        }
        
        .page-link {
            color: #2563eb;
            border: 1px solid var(--border-color);
            padding: 0.375rem 0.75rem;
            font-size: 12px;
        }
        
        .page-link:hover {
            background: var(--bg-hover);
            color: #1e40af;
        }
        
        .page-item.fa-disabled .page-link {
            color: #94a3b8;
            cursor: not-allowed;
            pointer-events: none;
        }
        
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.8);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }
        
        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #e2e8f0;
            border-top-color: #2563eb;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnProjectID" runat="server" />
        <asp:HiddenField ID="hdnUserID" runat="server" />
        <asp:HiddenField ID="hdnReportID" runat="server" Value="993" />
        <asp:HiddenField ID="hdnViewAccess" runat="server" />
        
        <% If m_blnViewAccess Then %>
        <!-- Top Section - Full Width (Title, Description, Note, Filters) -->
        <div class="reports-top-section">
            <div class="report-header">
                <h1 class="report-title"><%= MyBase.GetResourceString("C_TaskTypeReport") %></h1>
                <p class="report-description">
                    <%= MyBase.GetResourceString("C_ReportDescriptionTaskType") %>
                </p>
            </div>
            
            <!-- Filters Section -->
            <div class="filters-section collapsed" id="filtersSection">
                <div class="filters-header" id="filtersHeader">
                    <h3>
                        <i class="fas fa-filter"></i>
                        <%= MyBase.GetResourceString("C_FiltersAndActions") %>
                    </h3>
                    <i class="fas fa-chevron-down filters-toggle-icon"></i>
                </div>
                <div class="filters-content" id="filtersContent">
                    <div class="filter-row" id="standardFilters">
                        <div class="filter-group" id="projectFilterGroup">
                            <label for="cboProject"><%= MyBase.GetResourceString("C_ProjectName") %></label>
                            <div class="bs-wrapper">
                                <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectonChange();' class='selectpicker' data-live-search='true'",,,) %>
                            </div>
                        </div>
                        <div class="filter-group" id="periodFilterGroup">
                            <label for="cboPeriod"><%= MyBase.GetResourceString("C_Period") %></label>
                            <select class="form-control selectpicker" id="cboPeriod" data-live-search="true">
                                <option value=""><%= MyBase.GetResourceString("C_SelectPeriod") %></option>
                            </select>
                        </div>
                    </div>
                    <div class="filter-actions-row" style="display: flex; justify-content: space-between; align-items: center; margin-top: 0.75rem;">
                        <div class="filter-notes-container" style="flex: 1;">
                            <div class="filter-note" id="standardFilterNote">
                                <i class="fas fa-info-circle"></i>
                                <span>Please select Project and Period (both are mandatory).</span>
                            </div>
                        </div>
                        <div class="action-buttons">
                            <button type="button" class="btn btnyellow" id="btnShow"><%= MyBase.GetResourceString("C_Show") %></button>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Download Options - Outside Filter Box -->
            <div class="download-options">
                <a href="javascript:void(0);" class="download-link download-link-pdf" id="btnDownloadPdf">
                    <i class="fas fa-download"></i> PDF
                </a>
                <span class="download-divider">|</span>
                <a href="javascript:void(0);" class="download-link download-link-excel" id="btnDownloadExcel">
                    <i class="fas fa-download"></i> <%= MyBase.GetResourceString("C_EXCEL") %>
                </a>
            </div>
        </div>
        
        <!-- Middle Section - Table -->
        <div class="reports-middle-section">
            <!-- Content Area (Table) -->
            <div class="reports-content">
                <!-- Data Table Section -->
                <div class="data-table-container">
                    <div class="table-responsive-custom" style="overflow-x: auto; overflow-y: visible; min-height: 300px;">
                        <table id="tblReportData" class="table table-stripped table-bordered" style="width: 100%;">
                                <thead id="tblReportDataHead">
                                    <tr>
                                        <th>Resource</th>
                                        <th>Task Type</th>
                                        <th>Current Work (hrs) (1)</th>
                                        <th>BaseLine Work (hrs) (2)</th>
                                        <th>Actual Work (hrs) (3)</th>
                                        <th>Variance (hrs) (4)</th>
                                        <th>Current Work (%) (5)</th>
                                        <th>BaseLine Work (%) (6)</th>
                                        <th>Actual Work (%) (7)</th>
                                        <th>Variance (%) (8)</th>
                                    </tr>
                                </thead>
                                <tbody id="tblReportDataBody">
                                    <!-- Data will be populated dynamically -->
                                </tbody>
                            </table>
                    </div>
                    <!-- Pagination -->
                    <div class="pagination-container">
                        <div class="pagination-info" id="paginationInfo">
                            <span class="spntotal"><%= MyBase.GetResourceString("C_TotalRecords") %></span>
                            <span class="spntotal" id="totalRecords">0</span>
                        </div>
                        <nav aria-label="<%= MyBase.GetResourceString("C_PageNavigation") %>">
                            <ul class="pagination justify-content-end">
                                <li class="page-item fa-disabled" id="btnprevious">
                                    <a class="page-link" aria-label="<%= MyBase.GetResourceString("C_Previous") %>" href="javascript:;" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_PreviousPage") %>" id="LinkPrevious" onclick="goToPreviousPage(); return false;">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>
                                <li class="page-item fa-disabled" id="btnnext">
                                    <a class="page-link" aria-label="<%= MyBase.GetResourceString("C_Next") %>" href="javascript:;" data-bs-toggle="tooltip" title="<%= MyBase.GetResourceString("C_NextPage") %>" id="LinkNext" onclick="goToNextPage(); return false;">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <% Else %>
        <div style="min-height: calc(100vh - 60px); display: flex; align-items: flex-start; justify-content: center; padding-top: 50px; padding-left: 20px; padding-right: 20px;">
            <div style="text-align: center; width: 100%;">
                <b style="font-size: 16px; color: #333333; font-weight: bold;"><%= MyBase.GetResourceString("A_NotAuthorizedToView") %></b>
            </div>
        </div>
        <% End If %>
    </form>
    
    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>
    
    <!-- jQuery and other scripts -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    
    <script type="text/javascript">
        // ============================================
        // ALERTIFY CONFIGURATION
        // ============================================
        function configureAlertify() {
            if (typeof alertify !== 'undefined') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.set('notifier', 'delay', 5);
            } else {
                setTimeout(configureAlertify, 100);
            }
        }
        
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', configureAlertify);
        } else {
            configureAlertify();
        }
        
        // ============================================
        // RESOURCE VALUES
        // ============================================
        var Resources = {
            C_TaskTypeReport: '<%= MyBase.GetResourceString("C_TaskTypeReport") %>',
            C_ReportDescriptionTaskType: '<%= MyBase.GetResourceString("C_ReportDescriptionTaskType") %>',
            A_ProjectShouldNotBeBlank: '<%= MyBase.GetResourceString("A_ProjectShouldNotBeBlank") %>',
            A_PeriodShouldNotBeBlank: '<%= MyBase.GetResourceString("A_PeriodShouldNotBeBlank") %>',
            A_ErrorDownloadingReport: '<%= MyBase.GetResourceString("A_ErrorDownloadingReport") %>',
            A_ReportDownloadedSuccessfully: '<%= MyBase.GetResourceString("A_ReportDownloadedSuccessfully") %>',
            A_UnknownError: '<%= MyBase.GetResourceString("A_UnknownError") %>',
            A_PleaseAllowPopups: '<%= MyBase.GetResourceString("A_PleaseAllowPopups") %>',
            A_ReportOpenedInNewWindow: '<%= MyBase.GetResourceString("A_ReportOpenedInNewWindow") %>',
            A_UnableToDownload: '<%= MyBase.GetResourceString("A_UnableToDownload") %>',
            A_InvalidResponseFromServer: '<%= MyBase.GetResourceString("A_InvalidResponseFromServer") %>',
            A_RequestTimedOut: '<%= MyBase.GetResourceString("A_RequestTimedOut") %>',
            A_APIEndpointNotFound: '<%= MyBase.GetResourceString("A_APIEndpointNotFound") %>',
            A_ServerError: '<%= MyBase.GetResourceString("A_ServerError") %>',
            A_NoDataAvailable: '<%= MyBase.GetResourceString("A_NoDataAvailable") %>',
            A_FailedToLoadTaskTypeProgressReport: '<%= MyBase.GetResourceString("A_FailedToLoadTaskTypeProgressReport") %>'
        };
        
        // Global variables
        var currentPage = 1;
        var pageSize = 10;
        var totalRecords = 0;
        var reportData = [];
        var filtersLoaded = false;
        
        // API Configuration
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        if (!strUrl || strUrl === '' || strUrl === 'undefined') {
            var currentHost = window.location.protocol + '//' + window.location.host;
            strUrl = currentHost + '/';
        }
        if (strUrl && !strUrl.endsWith('/')) {
            strUrl += '/';
        }
        var baseUrl = strUrl || window.location.origin;
        if (baseUrl.endsWith('/')) {
            baseUrl = baseUrl.slice(0, -1);
        }
        
        // Helper function to get authentication token
        function getAuthToken() {
            return sessionStorage.getItem("access_token_W26API") || '';
        }
        
        // Helper function to get AJAX headers with authentication
        function getAjaxHeaders() {
            var token = getAuthToken();
            return {
                'Content-Type': 'application/json',
                'Authorization': token ? 'bearer ' + token : ''
            };
        }
        
        // Helper function to get URL parameter by name
        function getURLParameter(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)");
            var results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
        
        // Helper function for AJAX call with result (matching PM_ReportUIBuilder.aspx pattern)
        function AJAXCallWithResult(url, param, showLoading) {
            if (showLoading) {
                showLoadingOverlay();
            }
            
            var token = getAuthToken();
            return $.ajax({
                url: url,
                type: 'POST',
                contentType: 'application/json',
                data: param,
                headers: {
                    'Authorization': token ? 'Bearer ' + token : ''
                }
            }).always(function() {
                if (showLoading) {
                    hideLoadingOverlay();
                }
            });
        }
        
        // Loading overlay functions
        function showLoadingOverlay() {
            $('#loadingOverlay').css('display', 'flex');
        }
        
        function hideLoadingOverlay() {
            $('#loadingOverlay').css('display', 'none');
        }
        
        // Initialize on page load
        $(document).ready(function() {
            initializePage();
        });
        
        function initializePage() {
            // Initialize filters toggle
            $(document).on('click', '#filtersHeader', function (e) {
                e.preventDefault();
                e.stopPropagation();
                toggleFiltersSection();
            });
            
            $(document).on('click', '#filtersHeader h3', function (e) {
                e.preventDefault();
                e.stopPropagation();
                toggleFiltersSection();
            });
            
            $(document).on('click', '.filters-toggle-icon', function (e) {
                e.preventDefault();
                e.stopPropagation();
                toggleFiltersSection();
            });
            
            // Initialize Show button
            $('#btnShow').on('click', function() {
                handleShow();
            });
            
            // Initialize download buttons
            $('#btnDownloadPdf').on('click', function() {
                downloadReport('pdf');
            });
            
            $('#btnDownloadExcel').on('click', function() {
                downloadReport('excel');
            });
            
            // Initialize project dropdown for session
            initializeProjectDropdownForSession();
            
            // Read URL parameters
            window.urlProjectID = getURLParameter('ProjectID');
            window.urlReportID = getURLParameter('ReportID');
            window.urlPeriod = getURLParameter('Period');

            if (window.urlProjectID && window.urlProjectID !== '0') {

            }
        }
        
        function initializeProjectDropdownForSession() {
            var sessionProjectID = '<%= Session("intProjectID") %>';
            var $projectSelect = $('#cboProject');
            
            if (!sessionProjectID || sessionProjectID === '' || sessionProjectID === '0' || sessionProjectID === 'null' || sessionProjectID === 'undefined') {

                window.allProjectsLoaded = true;
                return;
            }
            
            setTimeout(function() {

                var allOptions = $projectSelect.find('option').clone();
                window.allProjectOptions = allOptions;
                
                $projectSelect.find('option').each(function() {
                    var optionValue = $(this).val();
                    if (optionValue !== sessionProjectID && optionValue !== '') {
                        $(this).remove();
                    }
                });
                
                $projectSelect.val(sessionProjectID);
                $('#<%= hdnProjectID.ClientID %>').val(sessionProjectID);
                
                if (typeof $.fn.selectpicker !== 'undefined') {
                    if (!$projectSelect.next('.bootstrap-select').length) {
                        $projectSelect.selectpicker({
                            liveSearch: true,
                            liveSearchStyle: 'startsWith',
                            dropupAuto: false
                        });
                    } else {
                        $projectSelect.selectpicker('refresh');
                    }
                }
                
                $projectSelect.off('shown.bs.select.sessionProject').on('shown.bs.select.sessionProject', function() {
                    if (!window.allProjectsLoaded) {

                        $projectSelect.empty();
                        if (window.allProjectOptions && window.allProjectOptions.length > 0) {
                            window.allProjectOptions.each(function() {
                                $projectSelect.append($(this).clone());
                            });
                        }
                        
                        $projectSelect.val(sessionProjectID);
                        $('#<%= hdnProjectID.ClientID %>').val(sessionProjectID);
                        
                        if (typeof $.fn.selectpicker !== 'undefined') {
                            $projectSelect.selectpicker('refresh');
                        }
                        
                        window.allProjectsLoaded = true;

                    }
                });
            }, 100);
        }
        
        function toggleFiltersSection() {
            var filtersSection = $('#filtersSection');
            var isCollapsed = filtersSection.hasClass('collapsed');
            
            if (isCollapsed) {
                filtersSection.removeClass('collapsed');
                
                if (!filtersLoaded) {
                    filtersLoaded = true;
                    loadPeriods();
                }
                
                setTimeout(function() {
                    if (typeof $.fn.selectpicker !== 'undefined') {
                        $('.selectpicker').selectpicker('refresh');
                    }
                }, 150);
            } else {
                filtersSection.addClass('collapsed');
            }
        }
        
        function ProjectonChange() {
            var projectID = $('#cboProject').val();
            if (projectID && projectID !== '' && projectID !== '0') {
                $('#<%= hdnProjectID.ClientID %>').val(projectID);
                loadPeriodsForProject(projectID);
            }
        }
        
        function loadPeriods() {
            var projectID = $('#cboProject').val();
            if (projectID && projectID !== '' && projectID !== '0') {
                return loadPeriodsForProject(projectID);
            } else {
                return $.Deferred().resolve().promise();
            }
        }
        
        function loadPeriodsForProject(projectID) {
            if (!projectID || projectID === '' || projectID === '0') {
                return $.Deferred().resolve().promise();
            }
            
            return $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetAllFilterDropdowns',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify({
                    ProjectID: parseInt(projectID),
                    GetPeriods: true
                }),
                success: function(response) {
                    var periodsData = null;
                    if (response) {
                        if (response.data) {
                            periodsData = response.data.Periods || response.data.periods;
                        }
                        if (!periodsData) {
                            periodsData = response.Periods || response.periods;
                        }
                        if (!periodsData && Array.isArray(response)) {
                            periodsData = response;
                        }
                    }
                    
                    if (periodsData && Array.isArray(periodsData) && periodsData.length > 0) {
                        var $periodSelect = $('#cboPeriod');
                        $periodSelect.empty();
                        $periodSelect.append('<option value=""><%= MyBase.GetResourceString("C_SelectPeriod") %></option>');
                        
                        periodsData.forEach(function(period) {
                            var periodId = period.UniqueID || period.Id || period.uniqueID || period.id || '';
                            var periodName = period.Description || period.Name || period.description || period.name || '';
                            if (periodId && periodName) {
                                $periodSelect.append('<option value="' + periodId + '">' + escapeHtml(periodName) + '</option>');
                            }
                        });
                        
                        if (typeof $.fn.selectpicker !== 'undefined') {
                            $periodSelect.selectpicker('refresh');
                        }
                        
                        // Apply URL parameter if available
                        if (window.urlPeriod && window.urlPeriod !== '') {
                            $periodSelect.val(window.urlPeriod);
                            $periodSelect.selectpicker('refresh');
                            window.urlPeriod = null; // Clear after applying
                        }

                    } else {

                    }
                },
                error: function(xhr, status, error) {

                }
            });
        }
        
        function escapeHtml(text) {
            if (!text) return '';
            var map = {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            };
            return text.toString().replace(/[&<>"']/g, function(m) { return map[m]; });
        }
        
        function handleShow() {
            var projectID = $('#cboProject').val();
            var period = $('#cboPeriod').val();
            
            if (!projectID || projectID === '' || projectID === '0') {
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                return;
            }
            
            if (!period || period === '' || period === '0') {
                alertify.error(Resources.A_PeriodShouldNotBeBlank || 'Please select a period');
                return;
            }
            
            showLoadingOverlay();
            
            var taskTypeParameters = {
                ProjectID: parseInt(projectID),
                PeriodFlag: parseInt(period)
            };
            
            loadTaskTypeProgressReportFromAPI(taskTypeParameters);
        }
        
        function loadTaskTypeProgressReportFromAPI(parameters) {
            var projectID = parameters && parameters.ProjectID ? parameters.ProjectID : null;
            var periodFlag = parameters && parameters.PeriodFlag ? parameters.PeriodFlag : null;
            
            if (!projectID || projectID === '' || projectID === '0') {
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                hideLoadingOverlay();
                return;
            }
            
            if (!periodFlag || periodFlag === '' || periodFlag === '0') {
                alertify.error(Resources.A_PeriodShouldNotBeBlank || 'Please select a period');
                hideLoadingOverlay();
                return;
            }
            
            var apiUrl = '/api/ReportUIBuilder/GetTaskTypeProgressReport';
            var requestData = {
                PeriodFlag: parseInt(periodFlag),
                ProjectID: parseInt(projectID),
                SelectedCase: 0,
                ShowCompleteMPPTasks: false,
                PageNumber: currentPage,
                PageSize: pageSize
            };
            
            var param = JSON.stringify(requestData);
            
            AJAXCallWithResult(apiUrl, param, false).then(function(response) {
                var reportData = [];
                if (response) {
                    if (response.data && response.data.data && Array.isArray(response.data.data)) {
                        reportData = response.data.data;
                    } else if (response.data && Array.isArray(response.data)) {
                        reportData = response.data;
                    } else if (response.data && response.data.ReportData && Array.isArray(response.data.ReportData)) {
                        reportData = response.data.ReportData;
                    } else if (Array.isArray(response)) {
                        reportData = response;
                    }
                }
                
                window.reportData = reportData;
                reportData = reportData;
                
                if (reportData && reportData.length > 0) {
                    processReportData(reportData);
                } else {
                    $('#tblReportDataBody').empty();
                    alertify.error(Resources.A_NoDataAvailable || 'No data available');
                    processReportData([]);
                }
                hideLoadingOverlay();
            }).catch(function(error) {
                alertify.error(Resources.A_FailedToLoadTaskTypeProgressReport || 'Failed to load Task Type Progress Report');
                hideLoadingOverlay();
            });
        }
        
        function processReportData(data) {
            if (!data || !Array.isArray(data)) {
                data = [];
            }
            
            reportData = data;
            totalRecords = data.length;
            $('#totalRecords').text(totalRecords);
            
            var tbody = $('#tblReportDataBody');
            tbody.empty();
            
            if (data.length === 0) {
                tbody.append('<tr><td colspan="10" style="text-align: center; padding: 2rem;">' + (Resources.A_NoDataAvailable || 'No data available') + '</td></tr>');
                updatePaginationButtons();
                return;
            }
            
            var startIndex = (currentPage - 1) * pageSize;
            var endIndex = Math.min(startIndex + pageSize, data.length);
            var pageData = data.slice(startIndex, endIndex);
            
            pageData.forEach(function(row) {
                var tr = $('<tr></tr>');
                tr.append('<td>' + escapeHtml(row.ResourceName || row.Resource || '') + '</td>');
                tr.append('<td>' + escapeHtml(row.TaskType || '') + '</td>');
                tr.append('<td>' + (row.CurrentWork || row.CurrentWorkHrs || 0) + '</td>');
                tr.append('<td>' + (row.BaseLineWork || row.BaselineWork || 0) + '</td>');
                tr.append('<td>' + (row.ActualWork || row.ActualWorkHrs || 0) + '</td>');
                tr.append('<td>' + (row.Variance || row.VarianceHrs || 0) + '</td>');
                tr.append('<td>' + (row.CurrentWorkPercentage || row.CurrentWorkPct || 0) + '</td>');
                tr.append('<td>' + (row.BaseLineWorkPercentage || row.BaselineWorkPct || 0) + '</td>');
                tr.append('<td>' + (row.ActualWorkPercentage || row.ActualWorkPct || 0) + '</td>');
                tr.append('<td>' + (row.VariancePercentage || row.VariancePct || 0) + '</td>');
                tbody.append(tr);
            });
            
            updatePaginationButtons();
        }
        
        function updatePaginationButtons() {
            var totalPages = Math.ceil(totalRecords / pageSize);
            var $btnPrevious = $('#btnprevious');
            var $btnNext = $('#btnnext');
            
            if (currentPage <= 1) {
                $btnPrevious.addClass('fa-disabled');
            } else {
                $btnPrevious.removeClass('fa-disabled');
            }
            
            if (currentPage >= totalPages) {
                $btnNext.addClass('fa-disabled');
            } else {
                $btnNext.removeClass('fa-disabled');
            }
        }
        
        function goToPreviousPage() {
            if (currentPage > 1) {
                currentPage--;
                processReportData(reportData);
            }
        }
        
        function goToNextPage() {
            var totalPages = Math.ceil(totalRecords / pageSize);
            if (currentPage < totalPages) {
                currentPage++;
                processReportData(reportData);
            }
        }
        
        function downloadReport(format) {

            var projectID = $('#cboProject').val();
            var period = $('#cboPeriod').val();

            if (!projectID || projectID === '' || projectID === '0') {
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                return;
            }
            
            if (!period || period === '' || period === '0') {
                alertify.error(Resources.A_PeriodShouldNotBeBlank || 'Please select a period');
                return;
            }
            
            var requestData = {
                ReportID: 993,
                Format: format,
                Parameters: {
                    ProjectID: parseInt(projectID),
                    PeriodFlag: parseInt(period)
                }
            };
            
            
            var token = getAuthToken();
            var apiUrl = baseUrl + '/api/ReportUIBuilder/DownloadReport';
            
            fetch(apiUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': token ? 'Bearer ' + token : ''
                },
                body: JSON.stringify(requestData)
            })
            .then(function(response) {


                if (!response.ok) {
                    return response.json().then(function(errorData) {
                        var errorMessage = errorData.message || errorData.error || Resources.A_ErrorDownloadingReport || 'Error downloading report';
                        throw new Error(errorMessage);
                    }).catch(function() {
                        throw new Error(Resources.A_ErrorDownloadingReport || 'Error downloading report');
                    });
                }
                
                var contentType = response.headers.get('content-type') || '';

                return response.blob().then(function(blob) {


                    if (!blob || blob.size === 0) {
                        throw new Error(Resources.A_InvalidResponseFromServer || 'Invalid response from server');
                    }
                    
                    var fileName = 'TaskTypeReport_' + format + '_' + Date.now() + '.' + (format === 'pdf' ? 'pdf' : 'xlsx');
                    var url = window.URL.createObjectURL(blob);
                    
                    var isInIframe = window.self !== window.top;
                    
                    if (isInIframe) {
                        var parentDoc = window.top.document;
                        var downloadLink = parentDoc.createElement('a');
                        downloadLink.href = url;
                        downloadLink.download = fileName;
                        downloadLink.style.display = 'none';
                        parentDoc.body.appendChild(downloadLink);
                        
                        window.requestAnimationFrame(function() {
                            downloadLink.click();
                            setTimeout(function() {
                                parentDoc.body.removeChild(downloadLink);
                                window.URL.revokeObjectURL(url);
                            }, 100);
                        });
                    } else {
                        var downloadLink = document.createElement('a');
                        downloadLink.href = url;
                        downloadLink.download = fileName;
                        downloadLink.style.display = 'none';
                        document.body.appendChild(downloadLink);
                        
                        window.requestAnimationFrame(function() {
                            downloadLink.click();
                            setTimeout(function() {
                                document.body.removeChild(downloadLink);
                                window.URL.revokeObjectURL(url);
                            }, 100);
                        });
                    }

                    alertify.success(Resources.A_ReportDownloadedSuccessfully || 'Report downloaded successfully');
                });
            })
            .catch(function(error) {

                var errorMessage = error.message || Resources.A_ErrorDownloadingReport || 'Error downloading report';
                alertify.error(errorMessage);
                
                if (errorMessage.indexOf('popup') !== -1 || errorMessage.indexOf('blocked') !== -1) {
                    alertify.warning(Resources.A_PleaseAllowPopups || 'Please allow popups for this site');
                }
            });
        }
    </script>
</body>
</html>

