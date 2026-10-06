<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TaskProgressReport.aspx.vb" Inherits="Whizible.PM_TaskProgressReport" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_TaskProgressReport") %></title>
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
        
        .charts-section {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            width: 280px;
            min-width: 280px;
            padding: 0.75rem;
            background: var(--bg-primary);
            border-left: 1px solid var(--border-color);
            overflow: visible;
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
            grid-template-columns: repeat(3, 1fr);
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
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: #374151;
            font-size: 0.75rem;
            padding: 0;
            background: transparent;
            border: none;
            border-radius: 0;
            margin-top: 0;
            padding-top: 0;
            border-top: none;
            flex: 1;
            box-sizing: border-box;
        }
        
        .filter-note i {
            font-size: 1rem;
            color: #374151;
        }
        
        .action-buttons {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
            margin-top: 0;
            margin-left: auto;
            justify-content: flex-end;
        }
        
        
        .download-options {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.75rem;
            padding: 0 1rem;
        }
        
        .download-link {
            font-size: 0.75rem;
            color: var(--primary-color);
            text-decoration: none;
            cursor: pointer;
            transition: var(--transition-base);
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }
        
        .download-link i {
            font-size: 0.5rem;
        }
        
        .download-link:hover {
            text-decoration: underline;
        }
        
        .download-link-pdf:hover {
            color: #dc2626;
        }
        
        .download-link-excel:hover {
            color: #16a34a;
        }
        
        .download-divider {
            color: var(--border-color);
            font-size: 0.75rem;
            margin: 0 0.25rem;
        }
        
        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius-sm);
            font-weight: normal;
            font-size: 0.8125rem;
            cursor: pointer;
            border: none;
            transition: var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            position: relative;
            z-index: 10;
        }
        
        .btn-show {
            background: #f97316;
            color: #ffffff;
            font-weight: 500;
            border-radius: 4px;
        }
        
        .btn-show:hover {
            background: #ea580c;
            color: #ffffff;
        }
        
        .btnyellow {
            background: #ffc107;
            color: #000000;
            font-weight: 500;
            border-radius: 4px;
        }
        
        .btnyellow:hover {
            background: #ffb300;
            color: #000000;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th {
            background-color: #f9fafb;
            padding: 0.375rem 0.375rem;
            text-align: center !important;
            font-weight: 600;
            font-size: 11px;
            color: #374151;
            border-bottom: 2px solid #e5e7eb;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        .table td {
            padding: 0.375rem 0.375rem;
            font-size: 11px;
            border-bottom: 1px solid #e5e7eb;
            color: #1f2937;
            text-align: center !important;
        }
        
        .table tbody tr:hover {
            background-color: #f9fafb;
        }
        
        /* KPI Container and Boxes */
        .kpi-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }
        
        .kpi-box {
            background: var(--bg-primary);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            padding: 0.75rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition-base);
            position: relative;
            overflow: hidden;
            min-height: 80px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        
        .kpi-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }
        
        .kpi-box:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-color);
        }
        
        .kpi-box:hover::before {
            transform: scaleX(1);
        }
        
        .kpi-label {
            font-size: 11px;
            font-family: 'Roboto', sans-serif;
            color: var(--primary-color);
            margin-bottom: 0.25rem;
            font-weight: normal;
            line-height: 1.2;
            text-align: center;
            word-wrap: break-word;
            hyphens: auto;
        }
        
        .kpi-value {
            font-size: 1rem;
            font-family: 'Roboto', sans-serif;
            font-weight: normal;
            color: var(--primary-color);
            line-height: 1.2;
            text-align: center;
        }
        
        .data-table-container {
            background: var(--bg-primary);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            padding: 1rem;
            box-shadow: var(--shadow-sm);
        }
        
        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }
        
        .pagination-info {
            color: #64748b;
            font-size: 14px;
        }
        
        .pagination {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 5px;
        }
        
        .page-item {
            margin: 0;
        }
        
        .page-link {
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            color: #1e40af;
            text-decoration: none;
            cursor: pointer;
        }
        
        .page-link:hover {
            background-color: #f1f5f9;
        }
        
        .page-item.fa-disabled .page-link {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        
        .chart-container {
            background: var(--bg-secondary);
            border-radius: var(--border-radius);
            padding: 0.75rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            flex-shrink: 0;
            display: block;
            transition: opacity 0.3s ease;
        }
        
        .chart-title {
            font-size: 0.6875rem;
            font-weight: normal;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            text-align: center;
            padding-bottom: 0.375rem;
            border-bottom: 1px solid var(--border-color);
        }
        
        .chart-wrapper {
            height: 140px;
            position: relative;
            width: 100%;
        }
        
        .chart-wrapper canvas {
            max-width: 100% !important;
            height: 140px !important;
        }
        
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        
        .spinner-border {
            width: 3rem;
            height: 3rem;
            border: 4px solid #f3f4f6;
            border-top-color: #1e40af;
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
        <asp:HiddenField ID="hdnReportID" runat="server" Value="996" />
        <asp:HiddenField ID="hdnViewAccess" runat="server" />
        
        <% If m_blnViewAccess Then %>
        <!-- Top Section - Full Width (Title, Description, Note, Filters) -->
        <div class="reports-top-section">
            <div class="report-header">
                <h1 class="report-title"><%= MyBase.GetResourceString("C_TaskProgressReport") %></h1>
                <p class="report-description">
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
                        <div class="filter-group" id="taskStatusFilterGroup">
                            <label for="cboTaskStatus"><%= MyBase.GetResourceString("C_TaskStatus") %></label>
                            <select class="form-control selectpicker" id="cboTaskStatus" data-live-search="true">
                                <option value=""><%= MyBase.GetResourceString("C_AllStatus") %></option>
                                <option value="Not Started"><%= MyBase.GetResourceString("C_NotStarted") %></option>
                                <option value="In Progress"><%= MyBase.GetResourceString("C_InProgress") %></option>
                                <option value="Completed"><%= MyBase.GetResourceString("C_Completed") %></option>
                                <option value="Void"><%= MyBase.GetResourceString("C_Void") %></option>
                            </select>
                        </div>
                        <div class="filter-group" id="showRollupMPPTasksGroup">
                            <label>
                                <input type="checkbox" id="chkShowRollupMPPTasks" />
                                <%= MyBase.GetResourceString("C_ShowRollupMPPTasks") %>
                            </label>
                        </div>
                    </div>
                    <div class="filter-actions-row" style="display: flex; justify-content: space-between; align-items: center; margin-top: 0.75rem;">
                        <div class="filter-notes-container" style="flex: 1;">
                            <div class="filter-note" id="standardFilterNote">
                                <i class="fas fa-info-circle"></i>
                                <span>Please select Project and Period. Task Status is optional.</span>
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
        
        <!-- Middle Section - KPI Cards, Table, and Charts -->
        <div class="reports-middle-section">
            <!-- Content Area (KPI Cards, Table, Charts) -->
            <div class="reports-content">
                <!-- KPI Section -->
                <div class="kpi-container">
                        <div class="kpi-box">
                            <div class="kpi-label">Total Tasks</div>
                            <div class="kpi-value" id="kpiTotalTasks">0</div>
                        </div>
                        <div class="kpi-box">
                            <div class="kpi-label">Completed Tasks</div>
                            <div class="kpi-value" id="kpiAvgDelay">0</div>
                        </div>
                        <div class="kpi-box">
                            <div class="kpi-label">In Progress Tasks</div>
                            <div class="kpi-value" id="kpiEffortOverrun">0</div>
                        </div>
                        <div class="kpi-box">
                            <div class="kpi-label">% Completion</div>
                            <div class="kpi-value" id="kpiOnTime">0%</div>
                        </div>
                </div>
                
                <!-- Data Table Section -->
                <div class="data-table-container">
                    <div class="table-responsive-custom" style="overflow-x: auto; overflow-y: visible; min-height: 300px;">
                        <table id="tblReportData" class="table table-stripped table-bordered" style="width: 100%;">
                                <thead id="tblReportDataHead">
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_TableHeaderResourceName") %></th>
                                        <th>Task Status</th>
                                        <th><%= MyBase.GetResourceString("C_TableHeaderTaskName") %></th>
                                        <th>Baseline Start<br/>Date</th>
                                        <th>Baseline End<br/>Date</th>
                                        <th>Baseline Duration<br/>(days)</th>
                                        <th>Baseline Work<br/>(hrs)</th>
                                        <th>Current Start<br/>Date</th>
                                        <th>Current End<br/>Date</th>
                                        <th>Current Duration<br/>(days)</th>
                                        <th>Current Work<br/>(hrs)</th>
                                        <th>Actual Start<br/>Date</th>
                                        <th>Actual End<br/>Date</th>
                                        <th>Actual Duration<br/>(days)</th>
                                        <th>Actual Work<br/>(hrs)</th>
                                        <th>Work In Last<br/>Week (hrs)</th>
                                        <th>Work In This<br/>Week (hrs)</th>
                                        <th>Variance<br/>(days,hrs)</th>
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
            
            <!-- Charts Section - Right Side -->
            <div class="charts-section">
                <div class="chart-container" data-chart="1">
                    <div class="chart-title">Progress vs Completed</div>
                    <div class="chart-wrapper">
                        <canvas id="chart1"></canvas>
                    </div>
                </div>
                
                <div class="chart-container" data-chart="2">
                    <div class="chart-title">Top 5 Resources - Average Effort Overrun</div>
                    <div class="chart-wrapper">
                        <canvas id="chart2"></canvas>
                    </div>
                </div>
                
                <div class="chart-container" data-chart="3">
                    <div class="chart-title">Top 5 Resources - Schedule Variance</div>
                    <div class="chart-wrapper">
                        <canvas id="chart3"></canvas>
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
    
    <!-- jQuery and other scripts -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    
    <script type="text/javascript">
        // ============================================
        // ALERTIFY CONFIGURATION
        // ============================================
        // Configure alertify to show alerts in top-right corner
        function configureAlertify() {
            if (typeof alertify !== 'undefined') {
                alertify.set('notifier', 'position', 'top-right');
                // Optional: Set delay for auto-dismiss (in seconds)
                alertify.set('notifier', 'delay', 5);
                
                // Suppress success messages
                alertify.success = function(message) {
                    // Suppress success messages - do nothing
                    return alertify;
                };
            } else {
                // Retry if alertify not loaded yet
                setTimeout(configureAlertify, 100);
            }
        }
        
        // Configure immediately if available, otherwise wait for DOM
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', configureAlertify);
        } else {
            configureAlertify();
        }
        
        // ============================================
        // RESOURCE VALUES
        // ============================================
        // Resource values
        var Resources = {
            C_TaskProgressReport: '<%= MyBase.GetResourceString("C_TaskProgressReport") %>',
            C_ReportDescriptionTaskProgress: '<%= MyBase.GetResourceString("C_ReportDescriptionTaskProgress") %>',
            A_ReportIDNotFound: '<%= MyBase.GetResourceString("A_ReportIDNotFound") %>',
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
            A_NoDataAvailable: '<%= MyBase.GetResourceString("A_NoDataAvailable") %>'
        };
        
        // Global variables
        var currentPage = 1;
        var pageSize = 5;
        var totalRecords = 0;
        var reportData = [];
        var chartInstances = {};
        
        // API Configuration - Base URL from web.config for W26API (external .NET Core solution)
        // This matches the pattern used in PM_ReportUIBuilder.aspx
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        
        // Fallback if web.config setting is not available
        if (!strUrl || strUrl === '' || strUrl === 'undefined') {
            // Try to detect the current host and use it
            var currentHost = window.location.protocol + '//' + window.location.host;
            // If API is on a different port, you may need to adjust this
            // For development, API might be on localhost:5095 or similar
            strUrl = currentHost + '/';
        }
        
        // Ensure trailing slash
        if (strUrl && !strUrl.endsWith('/')) {
            strUrl += '/';
        }
        
        // Use W26API base URL - remove trailing slash for API calls
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
        
        // Initialize on page load
        $(document).ready(function() {
            initializePage();
        });
        
        function initializePage() {
            // Load report description
            loadReportDescription();
            
            // Initialize filters toggle - match main page exactly
            $(document).on('click', '#filtersHeader', function (e) {
                e.preventDefault();
                e.stopPropagation();
                toggleFiltersSection();
            });
            
            // Also bind to h3 inside filters header
            $(document).on('click', '#filtersHeader h3', function (e) {
                e.preventDefault();
                e.stopPropagation();
                toggleFiltersSection();
            });
            
            // Also bind to the icon
            $(document).on('click', '.filters-toggle-icon', function (e) {
                e.preventDefault();
                e.stopPropagation();
                toggleFiltersSection();
            });
            
        function toggleFiltersSection() {
            var filtersSection = $('#filtersSection');
            var isCollapsed = filtersSection.hasClass('collapsed');
            
            if (isCollapsed) {
                filtersSection.removeClass('collapsed');
                // Refresh selectpickers when expanded
                setTimeout(function() {
                    if (typeof $.fn.selectpicker !== 'undefined') {
                        $('.selectpicker').selectpicker('refresh');
                    }
                }, 150);
            } else {
                filtersSection.addClass('collapsed');
            }
        }
            
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
            
            // Initialize charts
            initializeCharts();
            
            // Pre-fill filters from URL parameters (but don't auto-load data)
            // Slipping Tasks only needs ProjectID (no period/resource/date filters)
            var urlProjectID = getURLParameter('ProjectID');
            var urlReportID = getURLParameter('ReportID');

            if (urlProjectID && urlProjectID !== '' && urlProjectID !== '0') {
                // Function to set project (but NOT load data)
                function setProject() {
                    var $projectSelect = $('#cboProject');
                    if ($projectSelect.length > 0) {
                        // Check if the project option exists in dropdown
                        var projectExists = $projectSelect.find('option[value="' + urlProjectID + '"]').length > 0;
                        
                        if (projectExists) {

                            $projectSelect.val(urlProjectID);
                            $('#<%= hdnProjectID.ClientID %>').val(urlProjectID);
                            
                            // Refresh selectpicker if available
                            if (typeof $.fn.selectpicker !== 'undefined') {
                                $projectSelect.selectpicker('refresh');
                            }

                            return true;
                        } else {

                            return false;
                        }
                    }
                    return false;
                }
                
                // Try to set project immediately
                if (!setProject()) {

                            });
                            
                            return true;
                        } else {

                            return false;
                        }
                    }
                    return false;
                }
                
                // Wait for periods to load, then set project and filters (but NOT data)
                periodsPromise.done(function() {

                    if (!setProjectAndFilters()) {
                        // If project dropdown not ready, try again after delays
                        setTimeout(function() {
                            if (!setProjectAndFilters()) {
                                setTimeout(function() {
                                    setProjectAndFilters();
                                }, 1000);
                            }
                        }, 500);
                    }
                }).fail(function() {
                    // Even if project setting fails, retry

                    setTimeout(function() {
                        if (!setProject()) {
                            setTimeout(function() {
                                setProject();
                            }, 1000);
                        }
                    }, 500);
                });
                } else {

                }
        }
        
        function toggleFiltersSection() {
            var filtersSection = $('#filtersSection');
            var isCollapsed = filtersSection.hasClass('collapsed');
            
            if (isCollapsed) {
                filtersSection.removeClass('collapsed');
                // Refresh selectpickers when expanded
                setTimeout(function() {
                    if (typeof $.fn.selectpicker !== 'undefined') {
                        $('.selectpicker').selectpicker('refresh');
                    }
                }, 150);
            } else {
                filtersSection.addClass('collapsed');
            }
        }
        
        function loadReportDescription() {
            var reportID = $('#<%= hdnReportID.ClientID %>').val() || 996;

            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetReportComponent',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify({ ReportID: parseInt(reportID) }),
                success: function(response) {

                    var description = '';
                    var reportMaster = null;
                    
                    // Handle different response structures
                    if (response) {
                        var isSuccess = response.success === true || response.status === 'SUCCESS' || response.Status === 'SUCCESS';
                        
                        if (isSuccess && response.data) {
                            // Try multiple paths to find ReportMaster
                            reportMaster = response.data.ReportMaster || 
                                         response.data.reportMaster || 
                                         response.data.ReportMasterData ||
                                         response.ReportMaster ||
                                         response.reportMaster;
                            
                        if (reportMaster) {
                                description = reportMaster.description || 
                                            reportMaster.Description || 
                                            reportMaster.Desc ||
                                            '';
                            }
                        }
                    }
                    
                    // If description found, display it
                            if (description && description.trim() !== '') {

                        $('.report-description').html(description.replace(/\n/g, '<br>')).css({
                                    'display': 'block',
                                    'visibility': 'visible',
                            'opacity': '1',
                            'min-height': '20px'
                                });
                            } else {
                                // Use default description for Task Progress Report
                                var defaultDesc = Resources.C_ReportDescriptionTaskProgress || '';
                                if (defaultDesc && defaultDesc.trim() !== '') {

                            $('.report-description').html(defaultDesc.replace(/\n/g, '<br>')).css({
                                        'display': 'block',
                                        'visibility': 'visible',
                                'opacity': '1',
                                'min-height': '20px'
                            });
                        } else {
                            // Show note even if no description

                            $('.report-description').css({
                                'display': 'block',
                                'visibility': 'visible',
                                'opacity': '1',
                                'min-height': '20px'
                            });
                        }
                    }
                },
                error: function(xhr, status, error) {

                    // Use default description if API call fails
                    var defaultDesc = Resources.C_ReportDescriptionTaskProgress || '';
                    if (defaultDesc && defaultDesc.trim() !== '') {
                        $('.report-description').html(defaultDesc.replace(/\n/g, '<br>')).css({
                            'display': 'block',
                            'visibility': 'visible',
                            'opacity': '1',
                            'min-height': '20px'
                        });
                    } else {
                        // At least show the element
                        $('.report-description').css({
                            'display': 'block',
                            'visibility': 'visible',
                            'opacity': '1',
                            'min-height': '20px'
                        });
                    }
                }
            });
        }
        
        function ProjectonChange() {
            var projectID = $('#cboProject').val();
            if (projectID && projectID !== '' && projectID !== '0') {
                $('#<%= hdnProjectID.ClientID %>').val(projectID);
                loadPeriodsForProject(projectID);
            }
        }
        
        function loadResourcesForProject(projectID) {
            if (!projectID || projectID === '' || projectID === '0') {
                return $.Deferred().resolve().promise();
            }
            
            return $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetAllFilterDropdowns',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify({
                    ProjectID: parseInt(projectID),
                    GetResources: true
                }),
                success: function(response) {
                    if (response && response.success && response.data && response.data.Resources) {
                        var $resourceSelect = $('#cboResource');
                        $resourceSelect.empty();
                        $resourceSelect.append('<option value=""><%= MyBase.GetResourceString("C_AllResources") %></option>');
                        
                        $.each(response.data.Resources, function(index, resource) {
                            $resourceSelect.append('<option value="' + (resource.EmployeeID || resource.Id) + '">' + (resource.EmployeeName || resource.Name) + '</option>');
                        });
                        
                        $resourceSelect.selectpicker('refresh');
                    }
                },
                error: function(xhr, status, error) {

                }
            });
        }
        
        function loadPeriods() {
            return $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetAllFilterDropdowns',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify({
                    GetPeriods: true
                }),
                success: function(response) {
                    if (response && response.success && response.data && response.data.Periods) {
                        var $periodSelect = $('#cboPeriod');
                        $periodSelect.empty();
                        $periodSelect.append('<option value=""><%= MyBase.GetResourceString("C_AllPeriods") %></option>');
                        
                        $.each(response.data.Periods, function(index, period) {
                            $periodSelect.append('<option value="' + (period.UniqueID || period.Id) + '">' + (period.Description || period.Name) + '</option>');
                        });
                        
                        $periodSelect.selectpicker('refresh');
                    }
                },
                error: function(xhr, status, error) {

                }
            });
        }
        
        function loadPeriodsForProject(projectID) {
            if (!projectID || projectID === '' || projectID === '0') {
                return;
            }
            
            var $periodSelect = $('#cboPeriod');
            $periodSelect.empty();
            $periodSelect.append('<option value=""><%= MyBase.GetResourceString("C_SelectPeriod") %></option>');
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetPeriods',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify({ ProjectID: parseInt(projectID) }),
                success: function(response) {
                    if (response && response.data && Array.isArray(response.data)) {
                        $.each(response.data, function(index, period) {
                            var periodID = period.PeriodID || period.periodID || period.Period || period.period;
                            var periodName = period.PeriodName || period.periodName || period.Name || period.name || periodID;
                            $periodSelect.append('<option value="' + periodID + '">' + escapeHtml(periodName) + '</option>');
                        });
                        
                        $periodSelect.selectpicker('refresh');
                    }
                },
                error: function(xhr, status, error) {

                }
            });
        }
        
        function handleShow() {
            var projectID = $('#cboProject').val();
            var period = $('#cboPeriod').val();
            var taskStatus = $('#cboTaskStatus').val() || '';
            var showRollupMPPTasks = $('#chkShowRollupMPPTasks').is(':checked');
            
            if (!projectID || projectID === '' || projectID === '0') {
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                return;
            }
            
            if (!period || period === '' || period === '0') {
                alertify.error(Resources.A_PeriodShouldNotBeBlank || 'Please select a period');
                return;
            }
            
            showLoading();
            
            // Build parameters object - API expects parameters nested in Parameters property
            // Task Progress Report needs ProjectID, PeriodFlag, optional TaskStatus, ShowCompleteMPPTasks
            var parameters = {
                ProjectID: parseInt(projectID),
                PeriodFlag: parseInt(period),
                SelectedCase: 0,
                ShowCompleteMPPTasks: showRollupMPPTasks,
                PageNumber: 1,
                PageSize: 1000
            };
            
            // Add TaskStatus if selected
            if (taskStatus && taskStatus !== '' && taskStatus !== 'All Status') {
                parameters.TaskStatus = taskStatus;
            }
            
            var requestData = {
                ReportID: 996,
                Parameters: parameters
            };
            
            // Load report data
            loadReportData(requestData);
        }
        
        function loadReportData(requestData) {
            var parameters = requestData.Parameters || {};
            var projectID = parameters.ProjectID;
            var periodFlag = parameters.PeriodFlag;
            var taskStatus = parameters.TaskStatus;
            var showCompleteMPPTasks = parameters.ShowCompleteMPPTasks || false;
            var pageNumber = parameters.PageNumber || 1;
            var pageSize = parameters.PageSize || 1000;
            
            if (!projectID || projectID === '' || projectID === '0') {
                hideLoading();
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                return;
            }
            
            // Use Project Progress Report API
            var apiRequestData = {
                ProjectID: parseInt(projectID),
                SelectedCase: parameters.SelectedCase || 0,
                ShowCompleteMPPTasks: showCompleteMPPTasks,
                PageNumber: parseInt(pageNumber),
                PageSize: parseInt(pageSize)
            };
            
            if (periodFlag && periodFlag !== '' && periodFlag !== '0') {
                apiRequestData.PeriodFlag = parseInt(periodFlag);
            }
            
            if (taskStatus && taskStatus !== '') {
                apiRequestData.TaskStatus = taskStatus;
            }
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetProjectProgressReport',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(apiRequestData),
                success: function(response) {
                    hideLoading();
                    
                    // Extract report data from response
                    var reportDataArray = [];
                    var pagination = null;
                    
                    if (response) {
                        // Check for direct reportData property
                        if (response.reportData && Array.isArray(response.reportData)) {
                            reportDataArray = response.reportData;
                            pagination = response.pagination || null;
                        }
                        // Check for nested data structure
                        else if (response.data) {
                            if (response.data.ReportData && Array.isArray(response.data.ReportData)) {
                                reportDataArray = response.data.ReportData;
                            } else if (response.data.data && Array.isArray(response.data.data)) {
                                reportDataArray = response.data.data;
                            } else if (Array.isArray(response.data)) {
                                reportDataArray = response.data;
                            }
                            
                            if (response.data.pagination) {
                                pagination = response.data.pagination;
                            }
                        } else if (Array.isArray(response)) {
                            reportDataArray = response;
                        }
                    }
                    
                    if (reportDataArray.length > 0) {
                        reportData = reportDataArray;
                        totalRecords = pagination ? (parseInt(pagination.TotalRecords || pagination.totalRecords || 0)) : reportDataArray.length;
                        currentPage = 1;
                        
                        displayReportData();
                        calculateKPIs();
                        loadCharts(requestData);
                    } else {
                        reportData = [];
                        totalRecords = 0;
                        currentPage = 1;
                        displayReportData();
                        calculateKPIs();
                        alertify.warning(Resources.A_NoDataAvailable || 'No data available for the selected criteria');
                    }
                },
                error: function(xhr, status, error) {
                    hideLoading();
                    var errorMsg = Resources.A_ErrorLoadingReportData || 'Failed to load Task Progress Report data';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg = xhr.responseJSON.message;
                    }
                    alertify.error(errorMsg);

                        }
                    } else {
                        alertify.error(Resources.A_InvalidResponseFromServer || 'Invalid response from server');

                    }
                },
                error: function(xhr, status, error) {
                    hideLoading();
                    var errorMessage = (Resources.A_ErrorLoadingReportData || 'Error loading report data') + ': ' + error;
                    if (xhr.responseJSON) {
                        if (xhr.responseJSON.message) {
                            errorMessage = xhr.responseJSON.message;
                        } else if (xhr.responseJSON.error) {
                            errorMessage = xhr.responseJSON.error;
                        } else if (xhr.responseJSON.Message) {
                            errorMessage = xhr.responseJSON.Message;
                        }
                    }
                    alertify.error(errorMessage);

                }
            });
        }
        
        function displayReportData() {
            var $tbody = $('#tblReportDataBody');
            $tbody.empty();
            
            var startIndex = (currentPage - 1) * pageSize;
            var endIndex = Math.min(startIndex + pageSize, reportData.length);
            var pageData = reportData.slice(startIndex, endIndex);
            
            $.each(pageData, function(index, task) {
                // Task Progress Report columns: Resource, Task Status, Task Name, 
                // Baseline Start Date, Baseline End Date, Baseline Duration, Baseline Work,
                // Current Start Date, Current End Date, Current Duration, Current Work,
                // Actual Start Date, Actual End Date, Actual Duration, Actual Work,
                // Work In Last Week, Work In This Week, Variance
                
                // Resource
                var resource = task.ResourceName || task.resourceName || task.Resource || task.resource || '';
                
                // Task Status (from IsTaskComplete)
                var taskStatus = task.IsTaskComplete || task.isTaskComplete ? 'Complete' : 'In Progress';
                
                // Task Name
                var taskName = task.TaskName || task.taskName || '';
                
                // Baseline: Start Date, End Date, Duration, Work
                var baselineStart = formatDate(task.BaseLineStart || task.baseLineStart || task.BaselineStart || '');
                var baselineEnd = formatDate(task.BaseLineEnd || task.baseLineEnd || task.BaselineEnd || '');
                var baselineDuration = parseFloat(task.BaseLineDuration || task.baseLineDuration || task.BaselineDuration || 0);
                var baselineWork = parseFloat(task.BaseLineWork || task.baseLineWork || task.BaselineWork || 0);
                
                // Current: Start Date, End Date, Duration, Work
                var currentStart = formatDate(task.CurrentStart || task.currentStart || '');
                var currentEnd = formatDate(task.CurrentEnd || task.currentEnd || '');
                var currentDuration = parseFloat(task.CurrentDuration || task.currentDuration || 0);
                var currentWork = parseFloat(task.CurrentWork || task.currentWork || 0);
                
                // Actual: Start Date, End Date, Duration
                var actualStart = formatDate(task.ActualStart || task.actualStart || '');
                var actualEnd = formatDate(task.ActualEnd || task.actualEnd || '');
                var actualDuration = parseFloat(task.ActualDuration || task.actualDuration || 0);
                
                // Actual Work
                var actualWork = parseFloat(task.ActualWork || task.actualWork || 0);
                
                // Work In Last Week, Work In This Week
                var workInLastWeek = parseFloat(task.WorkInLastWeek || task.workInLastWeek || 0);
                var workInThisWeek = parseFloat(task.WorkInThisWeek || task.workInThisWeek || 0);
                
                // Variance (days,hrs) - combine StartVariance and FinishVariance
                var startVariance = parseFloat(task.StartVariance || task.startVariance || 0);
                var finishVariance = parseFloat(task.FinishVariance || task.finishVariance || 0);
                var variance = finishVariance.toFixed(1) + ' days, ' + (startVariance * 8).toFixed(1) + ' hrs';
                
                var row = '<tr>' +
                    '<td>' + escapeHtml(resource) + '</td>' +
                    '<td>' + escapeHtml(taskStatus) + '</td>' +
                    '<td>' + escapeHtml(taskName) + '</td>' +
                    '<td>' + escapeHtml(baselineStart) + '</td>' +
                    '<td>' + escapeHtml(baselineEnd) + '</td>' +
                    '<td>' + baselineDuration.toFixed(1) + '</td>' +
                    '<td>' + baselineWork.toFixed(2) + '</td>' +
                    '<td>' + escapeHtml(currentStart) + '</td>' +
                    '<td>' + escapeHtml(currentEnd) + '</td>' +
                    '<td>' + currentDuration.toFixed(1) + '</td>' +
                    '<td>' + currentWork.toFixed(2) + '</td>' +
                    '<td>' + escapeHtml(actualStart) + '</td>' +
                    '<td>' + escapeHtml(actualEnd) + '</td>' +
                    '<td>' + actualDuration.toFixed(1) + '</td>' +
                    '<td>' + actualWork.toFixed(2) + '</td>' +
                    '<td>' + workInLastWeek.toFixed(2) + '</td>' +
                    '<td>' + workInThisWeek.toFixed(2) + '</td>' +
                    '<td>' + escapeHtml(variance) + '</td>' +
                    '</tr>';
                $tbody.append(row);
            });
            
            // Update pagination
            updatePagination();
            $('#totalRecords').text(totalRecords);
        }
        
        function formatDate(dateString) {
            if (!dateString) return '';
            var date = new Date(dateString);
            if (isNaN(date.getTime())) return '';
            return date.toLocaleDateString();
        }
        
        function updatePagination() {
            var totalPages = Math.ceil(totalRecords / pageSize);
            $('#btnprevious').toggleClass('fa-disabled', currentPage <= 1);
            $('#btnnext').toggleClass('fa-disabled', currentPage >= totalPages);
        }
        
        function goToPreviousPage() {
            if (currentPage > 1) {
                currentPage--;
                displayReportData();
            }
        }
        
        function goToNextPage() {
            var totalPages = Math.ceil(totalRecords / pageSize);
            if (currentPage < totalPages) {
                currentPage++;
                displayReportData();
            }
        }
        
        function calculateKPIs() {
            // KPIs for Task Progress Report are loaded from API, not calculated from data
            // This function is kept for compatibility but KPIs are set by loadTaskProgressReportKPIs()
        }
        
        function initializeCharts() {
            initializeChart1();
            initializeChart2();
            initializeChart3();
        }
        
        function initializeChart1() {
            try {
                var canvas1 = document.getElementById('chart1');
                if (!canvas1) {
                    return;
                }
                
                // CRITICAL FIX: Properly destroy existing chart if it exists
                if (chartInstances.chart1) {
                    try {
                        chartInstances.chart1.destroy();
                    } catch (e) {}
                    chartInstances.chart1 = null;
                }
                
                if (typeof Chart !== 'undefined') {
                    var chartId = canvas1.id;
                    if (Chart.instances && Chart.instances[chartId]) {
                        try {
                            Chart.instances[chartId].destroy();
                            delete Chart.instances[chartId];
                        } catch (e) {}
                    }
                    try {
                        var existingChart = Chart.getChart(canvas1);
                        if (existingChart) {
                            existingChart.destroy();
                        }
                    } catch (e) {}
                }
                if (canvas1.chart) {
                    try {
                        canvas1.chart.destroy();
                        canvas1.chart = null;
                    } catch (e) {}
                }
                if (canvas1.hasAttribute && canvas1.hasAttribute('data-chartjs-chart')) {
                    canvas1.removeAttribute('data-chartjs-chart');
                }
                
                var ctx1 = canvas1.getContext('2d');
                chartInstances.chart1 = new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: ['R1', 'R2', 'R3', 'R4', 'R5'],
                        datasets: [{
                            label: 'Not Slipping',
                            data: [100, 100, 100, 100, 100],
                            backgroundColor: '#3b82f6'
                        }, {
                            label: 'Slipping',
                            data: [40, 60, 80, 70, 50],
                            backgroundColor: '#f97316'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    font: {
                                        size: 8
                                    },
                                    boxWidth: 10,
                                    padding: 5
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                titleFont: {
                                    size: 11
                                },
                                bodyFont: {
                                    size: 10
                                },
                                callbacks: {
                                    label: function(context) {
                                        var label = context.dataset.label || '';
                                        var value = context.parsed.y || 0;
                                        if (context.datasetIndex === 0) {
                                            var completedValue = 0;
                                            if (context.chart.data.datasets[1] && 
                                                context.chart.data.datasets[1].data[context.dataIndex] !== undefined) {
                                                completedValue = parseInt(context.chart.data.datasets[1].data[context.dataIndex]) || 0;
                                            }
                                            var totalValue = value + completedValue;
                                            return 'Not Slipping: ' + value + '\nSlipping: ' + completedValue + '\nTotal tasks: ' + totalValue;
                                        } else if (context.datasetIndex === 1) {
                                            var notSlippingValue = 0;
                                            if (context.chart.data.datasets[0] && 
                                                context.chart.data.datasets[0].data[context.dataIndex] !== undefined) {
                                                notSlippingValue = parseInt(context.chart.data.datasets[0].data[context.dataIndex]) || 0;
                                            }
                                            var totalValue = value + notSlippingValue;
                                            return 'Slipping: ' + value + '\nNot Slipping: ' + notSlippingValue + '\nTotal tasks: ' + totalValue;
                                        }
                                        return label + ': ' + value;
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                stacked: true,
                                categoryPercentage: 0.4,
                                barPercentage: 0.4,
                                ticks: {
                                    font: {
                                        size: 7
                                    },
                                    maxRotation: 45,
                                    minRotation: 0
                                },
                                title: {
                                    display: false
                                }
                            },
                            y: {
                                stacked: true,
                                beginAtZero: true,
                                min: 0,
                                max: 100,
                                ticks: {
                                    stepSize: 5,
                                    precision: 0,
                                    display: true,
                                    autoSkip: true,
                                    maxTicksLimit: 11,
                                    min: 0,
                                    font: {
                                        size: 7
                                    },
                                    callback: function(value, index, values) {
                                        if (value === undefined || value === null || isNaN(value)) {
                                            return '';
                                        }
                                        return value.toString();
                                    }
                                },
                                grid: {
                                    display: true,
                                    drawBorder: true
                                },
                                afterBuildTicks: function(scale) {
                                    scale.ticks = [];
                                    var step = (scale.options && scale.options.ticks && scale.options.ticks.stepSize) ? scale.options.ticks.stepSize : 5;
                                    var max = (scale.max !== undefined && scale.max !== null && !isNaN(scale.max)) ? scale.max : 100;
                                    if (max > 0 && step > 0) {
                                        for (var i = 0; i <= max; i += step) {
                                            scale.ticks.push({ value: i });
                                        }
                                    }
                                }
                            }
                        }
                    }
                });
            } catch (error) {
            }
        }
        
        function initializeChart2() {
            try {
                var canvas2 = document.getElementById('chart2');
                if (!canvas2) {
                    return;
                }
                
                if (chartInstances.chart2) {
                    try {
                        chartInstances.chart2.destroy();
                    } catch (e) {}
                    chartInstances.chart2 = null;
                }
                
                if (typeof Chart !== 'undefined') {
                    var chartId = canvas2.id;
                    if (Chart.instances && Chart.instances[chartId]) {
                        try {
                            Chart.instances[chartId].destroy();
                            delete Chart.instances[chartId];
                        } catch (e) {}
                    }
                    try {
                        var existingChart = Chart.getChart(canvas2);
                        if (existingChart) {
                            existingChart.destroy();
                        }
                    } catch (e) {}
                }
                if (canvas2.chart) {
                    try {
                        canvas2.chart.destroy();
                        canvas2.chart = null;
                    } catch (e) {}
                }
                
                var ctx2 = canvas2.getContext('2d');
                chartInstances.chart2 = new Chart(ctx2, {
                    type: 'bar',
                    data: {
                        labels: [],
                        datasets: [{
                            label: 'Total',
                            data: [],
                            backgroundColor: '#3b82f6'
                        }, {
                            label: 'Overrun',
                            data: [],
                            backgroundColor: '#f97316'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    font: {
                                        size: 8
                                    },
                                    boxWidth: 10,
                                    padding: 5
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                titleFont: {
                                    size: 11
                                },
                                bodyFont: {
                                    size: 10
                                }
                            }
                        },
                        scales: {
                            x: {
                                stacked: false,
                                categoryPercentage: 0.4,
                                barPercentage: 0.4,
                                ticks: {
                                    font: {
                                        size: 7
                                    },
                                    maxRotation: 45,
                                    minRotation: 0
                                },
                                title: {
                                    display: false
                                }
                            },
                            y: {
                                stacked: false,
                                beginAtZero: true,
                                min: 0,
                                max: 15,
                                ticks: {
                                    stepSize: 5,
                                    precision: 0,
                                    display: true,
                                    autoSkip: true,
                                    maxTicksLimit: 11,
                                    min: 0,
                                    font: {
                                        size: 7
                                    },
                                    callback: function(value, index, values) {
                                        if (value === undefined || value === null || isNaN(value)) {
                                            return '';
                                        }
                                        return value.toString();
                                    }
                                },
                                grid: {
                                    display: true,
                                    drawBorder: true
                                },
                                afterBuildTicks: function(scale) {
                                    scale.ticks = [];
                                    var step = (scale.options && scale.options.ticks && scale.options.ticks.stepSize) ? scale.options.ticks.stepSize : 5;
                                    var max = (scale.max !== undefined && scale.max !== null && !isNaN(scale.max)) ? scale.max : 15;
                                    if (max > 0 && step > 0) {
                                        for (var i = 0; i <= max; i += step) {
                                            scale.ticks.push({ value: i });
                                        }
                                    }
                                }
                            }
                        }
                    }
                });
            } catch (error) {
            }
        }
        
        function initializeChart3() {
            try {
                var canvas3 = document.getElementById('chart3');
                if (!canvas3) {
                    return;
                }
                
                if (chartInstances.chart3) {
                    try {
                        chartInstances.chart3.destroy();
                    } catch (e) {}
                    chartInstances.chart3 = null;
                }
                
                if (typeof Chart !== 'undefined') {
                    var chartId = canvas3.id;
                    if (Chart.instances && Chart.instances[chartId]) {
                        try {
                            Chart.instances[chartId].destroy();
                            delete Chart.instances[chartId];
                        } catch (e) {}
                    }
                    try {
                        var existingChart = Chart.getChart(canvas3);
                        if (existingChart) {
                            existingChart.destroy();
                        }
                    } catch (e) {}
                }
                if (canvas3.chart) {
                    try {
                        canvas3.chart.destroy();
                        canvas3.chart = null;
                    } catch (e) {}
                }
                
                var ctx3 = canvas3.getContext('2d');
                chartInstances.chart3 = new Chart(ctx3, {
                    type: 'bar',
                    data: {
                        labels: ['R1', 'R2', 'R3', 'R4', 'R5'],
                        datasets: [{
                            label: 'Total Tasks',
                            data: [10, 8, 12, 6, 5],
                            backgroundColor: '#3b82f6'
                        }, {
                            label: 'Schedule Variance',
                            data: [4, 3, 6, 2, 2],
                            backgroundColor: '#f97316'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    font: {
                                        size: 8
                                    },
                                    boxWidth: 10,
                                    padding: 5
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                titleFont: {
                                    size: 11
                                },
                                bodyFont: {
                                    size: 10
                                }
                            }
                        },
                        scales: {
                            x: {
                                stacked: false,
                                categoryPercentage: 0.4,
                                barPercentage: 0.4,
                                ticks: {
                                    font: {
                                        size: 7
                                    },
                                    maxRotation: 45,
                                    minRotation: 0
                                },
                                title: {
                                    display: false
                                }
                            },
                            y: {
                                stacked: false,
                                beginAtZero: true,
                                min: 0,
                                max: 15,
                                ticks: {
                                    stepSize: 5,
                                    precision: 0,
                                    display: true,
                                    autoSkip: true,
                                    maxTicksLimit: 11,
                                    min: 0,
                                    font: {
                                        size: 7
                                    },
                                    callback: function(value, index, values) {
                                        if (value === undefined || value === null || isNaN(value)) {
                                            return '';
                                        }
                                        return value.toString();
                                    }
                                },
                                grid: {
                                    display: true,
                                    drawBorder: true
                                },
                                afterBuildTicks: function(scale) {
                                    scale.ticks = [];
                                    var step = (scale.options && scale.options.ticks && scale.options.ticks.stepSize) ? scale.options.ticks.stepSize : 5;
                                    var max = (scale.max !== undefined && scale.max !== null && !isNaN(scale.max)) ? scale.max : 15;
                                    if (max > 0 && step > 0) {
                                        for (var i = 0; i <= max; i += step) {
                                            scale.ticks.push({ value: i });
                                        }
                                    }
                                }
                            }
                        }
                    }
                });
            } catch (error) {
            }
        }
        
        function loadCharts(requestData) {
            // Load chart data from API - use Project Progress Report APIs (Task Progress Report uses same APIs)
            var reportId = requestData.ReportID || 996;
            var parameters = requestData.Parameters || {};
            
            // Build parameters object for Project Progress Report APIs
            var chartParameters = {};
            if (parameters.ProjectID) {
                chartParameters.ProjectID = parameters.ProjectID;
            }
            if (parameters.PeriodFlag) {
                chartParameters.PeriodFlag = parameters.PeriodFlag;
            }
            if (parameters.TaskStatus) {
                chartParameters.TaskStatus = parameters.TaskStatus;
            }
            if (parameters.ShowCompleteMPPTasks !== undefined) {
                chartParameters.ShowCompleteMPPTasks = parameters.ShowCompleteMPPTasks;
            }
            chartParameters.SelectedCase = parameters.SelectedCase || 0;
            
            // Load KPIs from GetProjectProgressReportKPIs API
            loadTaskProgressReportKPIs(chartParameters);
            
            // Load charts from Project Progress Report APIs
            loadTaskProgressReportCharts(chartParameters);
        }
        
        function loadTaskProgressReportKPIs(parameters) {
            if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
                return;
            }
            
            var requestData = {
                ProjectID: parseInt(parameters.ProjectID),
                PeriodFlag: parameters.PeriodFlag ? parseInt(parameters.PeriodFlag) : null,
                SelectedCase: parameters.SelectedCase || 0,
                ShowCompleteMPPTasks: parameters.ShowCompleteMPPTasks || false
            };
            
            if (parameters.TaskStatus && parameters.TaskStatus !== '') {
                requestData.TaskStatus = parameters.TaskStatus;
            }
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetProjectProgressReportKPIs',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                timeout: 60000,
                success: function(response) {
                    try {
                        var kpiData = null;
                        if (response && response.data) {
                            if (response.data.data) {
                                kpiData = response.data.data;
                            } else {
                                kpiData = response.data;
                            }
                        } else {
                            kpiData = response;
                        }
                        
                        if (kpiData) {
                            var totalTasks = kpiData.TotalTasks || kpiData.totalTasks || 0;
                            var completedTasks = kpiData.CompletedTasks || kpiData.completedTasks || 0;
                            var inProgressTasks = kpiData.InProgressTasks || kpiData.inProgressTasks || 0;
                            var percentageCompletion = kpiData.PercentageCompletion || kpiData.percentageCompletion || 0;
                            
                            $('#kpiTotalTasks').text(totalTasks);
                            $('#kpiAvgDelay').text(Math.round(completedTasks));
                            $('#kpiEffortOverrun').text(Math.round(inProgressTasks));
                            $('#kpiOnTime').text(parseFloat(percentageCompletion).toFixed(2) + '%');
                        }
                    } catch (ex) {

                    }
                },
                error: function(xhr, status, error) {

                }
            });
        }
        
        function loadTaskProgressReportCharts(parameters) {
            if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
                return;
            }
            
            var requestData = {
                ProjectID: parseInt(parameters.ProjectID),
                PeriodFlag: parameters.PeriodFlag ? parseInt(parameters.PeriodFlag) : null,
                SelectedCase: parameters.SelectedCase || 0,
                ShowCompleteMPPTasks: parameters.ShowCompleteMPPTasks || false
            };
            
            if (parameters.TaskStatus && parameters.TaskStatus !== '') {
                requestData.TaskStatus = parameters.TaskStatus;
            }
            
            // Load Chart 1: Progress vs Completed
            loadTaskProgressReportProgVsCompChart(requestData);
            
            // Load Chart 2: Average Effort Overrun
            loadTaskProgressReportAverageEffortOverrunChart(requestData);
            
            // Load Chart 3: Schedule Variance
            loadTaskProgressReportScheduleVarianceChart(requestData);
        }
        
        function loadTaskProgressReportProgVsCompChart(requestData) {
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetProjectProgressReportProgVsComp',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                timeout: 60000,
                success: function(response) {
                    try {
                        var chartData = null;
                        if (response && response.data) {
                            chartData = response.data;
                        } else {
                            chartData = response;
                        }
                        
                        if (chartData && chartData.labels && chartData.progressTasks && chartData.completedTasks) {
                            var labels = chartData.labels || [];
                            var progressTasks = chartData.progressTasks || [];
                            var completedTasks = chartData.completedTasks || [];
                            
                            updateChart1(labels, progressTasks, completedTasks);
                        } else {
                            updateChart1([], [], []);
                        }
                    } catch (ex) {

                        updateChart1([], [], []);
                    }
                },
                error: function(xhr, status, error) {

                    updateChart1([], [], []);
                }
            });
        }
        
        function loadTaskProgressReportAverageEffortOverrunChart(requestData) {
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetProjectProgressReportResAvgEffortOverrun',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                timeout: 60000,
                success: function(response) {
                    try {
                        var chartData = null;
                        if (response && response.data) {
                            chartData = response.data;
                        } else {
                            chartData = response;
                        }
                        
                        if (chartData && chartData.labels && chartData.averageEffortOverrunTasks) {
                            var labels = chartData.labels || [];
                            var averageEffortOverrunTasks = chartData.averageEffortOverrunTasks || [];
                            
                            // Filter out "Unknown" resources
                            var filteredLabels = [];
                            var filteredEffortOverrun = [];
                            for (var i = 0; i < labels.length; i++) {
                                var label = labels[i];
                                if (label && label.toString().trim() !== '' && label.toString().trim().toLowerCase() !== 'unknown') {
                                    filteredLabels.push(label);
                                    filteredEffortOverrun.push(parseFloat(averageEffortOverrunTasks[i]) || 0);

                                }
                            }
                            
                            updateChart2(filteredLabels, [], filteredEffortOverrun);
                        } else {
                            updateChart2([], [], []);
                        }
                    } catch (ex) {

                        updateChart2([], [], []);
                    }
                },
                error: function(xhr, status, error) {

                    updateChart2([], [], []);
                }
            });
        }
        
        function loadTaskProgressReportScheduleVarianceChart(requestData) {
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetProjectProgressReportResScheduleVariance',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                timeout: 60000,
                success: function(response) {
                    try {
                        var chartData = null;
                        if (response && response.data) {
                            chartData = response.data;
                        } else {
                            chartData = response;
                        }
                        
                        if (chartData && chartData.labels && chartData.scheduleVarianceTasks) {
                            var labels = chartData.labels || [];
                            var scheduleVarianceTasks = chartData.scheduleVarianceTasks || [];
                            
                            // Filter out "Unknown" resources
                            var filteredLabels = [];
                            var filteredScheduleVariance = [];
                            for (var i = 0; i < labels.length; i++) {
                                var label = labels[i];
                                if (label && label.toString().trim() !== '' && label.toString().trim().toLowerCase() !== 'unknown') {
                                    filteredLabels.push(label);
                                    filteredScheduleVariance.push(parseInt(scheduleVarianceTasks[i]) || 0);

                                }
                            }
                            
                            updateChart3(filteredLabels, [], filteredScheduleVariance);
                        } else {
                            updateChart3([], [], []);
                        }
                    } catch (ex) {

                        updateChart3([], [], []);
                    }
                },
                error: function(xhr, status, error) {

                    updateChart3([], [], []);
                }
            });
        }
        
        function loadSlippingTasksWidgetData(reportId, parameters) {
            // ProjectID is required
            if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
                return;
            }
            
            // Build request data for Slipping Tasks Insights API
            var requestData = {
                ProjectID: parseInt(parameters.ProjectID)
            };
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetSlippingTasksInsights',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                timeout: 60000, // 60 second timeout
                success: function(response) {
                    try {
                        // Response structure: { status: "SUCCESS", data: { message: "...", Data: { 
                        //     SlippingTaskSummary: [...],
                        //     Top5AvgEffortEntity: [...],
                        //     Top5ScheduleVarianceEntity: [...],
                        //     Top5TotalVsSlippingEntity: [...]
                        // } } }
                        var widgetData = null;
                        
                        if (response) {
                            if (response.data) {
                                if (response.data.Data) {
                                    widgetData = response.data.Data;
                                } else if (response.data.data) {
                                    widgetData = response.data.data;
                                } else {
                                    widgetData = response.data;
                                }
                            } else {
                                widgetData = response;
                            }
                        }
                        
                        if (!widgetData) {

                            updateKPIDisplay(0, 0, 0, 0);
                            updateChart1([], [], []);
                            updateChart2([], [], []);
                            updateChart3([], [], []);
                            return;
                        }
                        
                        // Extract and update KPIs from SlippingTaskSummary
                        var summary = widgetData.SlippingTaskSummary || widgetData.slippingTaskSummary || 
                                     widgetData.SlippingTaskSummaryEntity || widgetData.slippingTaskSummaryEntity || [];
                        
                        if (summary && Array.isArray(summary) && summary.length > 0) {
                            var summaryItem = summary[0];
                            var totalTasks = summaryItem.TotalTasks || summaryItem.totalTasks || 0;
                            var avgDelay = summaryItem.AverageDelay || summaryItem.averageDelay || 0;
                            var avgEffortOverrun = summaryItem.AverageEffortOverrun || summaryItem.averageEffortOverrun || 0;
                            var percentOnTime = summaryItem.PercentOnTime || summaryItem.percentOnTime || 0;
                            
                            updateKPIDisplay(totalTasks, avgDelay, avgEffortOverrun, percentOnTime);
                        } else {
                            var fallbackTotalTasks = window.sortedDataForKPIs ? window.sortedDataForKPIs.length : 0;
                            updateKPIDisplay(fallbackTotalTasks, 0, 0, 0);
                        }
                        
                        // Update Chart 1: Total vs Slipping (from Top5TotalVsSlippingEntity)
                        var chart1Data = widgetData.Top5TotalVsSlippingEntity || widgetData.top5TotalVsSlippingEntity || 
                                        widgetData.Top5TotalVsSlipping || widgetData.top5TotalVsSlipping || [];
                        
                        if (Array.isArray(chart1Data) && chart1Data.length > 0) {
                            var labels1 = [];
                            var totalTasks1 = [];
                            var slippingTasks1 = [];
                            
                            chart1Data.forEach(function(item) {
                                var resourceName = item.ResourceName || item.resourceName || '';
                                var total = item.TotalTasks || item.totalTasks || 0;
                                var slipping = item.SlippingTasks || item.slippingTasks || 0;
                                
                                if (resourceName && resourceName.trim() !== '' && resourceName.toLowerCase() !== 'unknown') {
                                    labels1.push(resourceName);
                                    totalTasks1.push(parseInt(total) || 0);
                                    slippingTasks1.push(parseInt(slipping) || 0);
                                }
                            });
                            
                            // Update Chart 1 title
                            $('.chart-container[data-chart="1"] .chart-title').text('Top 5 Resources - Total vs Slipping Tasks');
                            
                            // For stacked chart: dataset[0] = Not Slipping (Total - Slipping), dataset[1] = Slipping
                            updateChart1(labels1, totalTasks1, slippingTasks1);
                        } else {
                            updateChart1([], [], []);
                        }
                        
                        // Update Chart 2: Average Effort (from Top5AvgEffortEntity)
                        var chart2Data = widgetData.Top5AvgEffortEntity || widgetData.top5AvgEffortEntity || 
                                        widgetData.Top5AvgEffort || widgetData.top5AvgEffort || [];
                        
                        if (Array.isArray(chart2Data) && chart2Data.length > 0) {
                            var labels2 = [];
                            var avgEffort2 = [];
                            var totalTasks2 = [];
                            
                            chart2Data.forEach(function(item) {
                                var resourceName = item.ResourceName || item.resourceName || '';
                                var avgEffort = item.AverageEffort || item.averageEffort || 0;
                                var total = item.TotalTasks || item.totalTasks || 0;
                                
                                if (resourceName && resourceName.trim() !== '' && resourceName.toLowerCase() !== 'unknown') {
                                    labels2.push(resourceName);
                                    avgEffort2.push(parseFloat(avgEffort) || 0);
                                    totalTasks2.push(parseInt(total) || 0);
                                }
                            });
                            
                            // For Chart 2, use avgEffort as first dataset and empty array for second
                            updateChart2(labels2, totalTasks2, avgEffort2);
                        } else {
                            updateChart2([], [], []);
                        }
                        
                        // Update Chart 3: Schedule Variance (from Top5ScheduleVarianceEntity)
                        var chart3Data = widgetData.Top5ScheduleVarianceEntity || widgetData.top5ScheduleVarianceEntity || 
                                        widgetData.Top5ScheduleVariance || widgetData.top5ScheduleVariance || [];
                        
                        if (Array.isArray(chart3Data) && chart3Data.length > 0) {
                            var labels3 = [];
                            var totalTasks3 = [];
                            var scheduleVariance3 = [];
                            
                            chart3Data.forEach(function(item) {
                                var resourceName = item.ResourceName || item.resourceName || '';
                                var total = item.TotalTasks || item.totalTasks || 0;
                                var scheduleVariance = item.ScheduleVariance || item.scheduleVariance || 0;
                                var scheduleVarianceInt = Math.round(parseFloat(scheduleVariance) || 0);
                                
                                if (resourceName && resourceName.trim() !== '' && resourceName.toLowerCase() !== 'unknown') {
                                    labels3.push(resourceName);
                                    totalTasks3.push(parseInt(total) || 0);
                                    scheduleVariance3.push(scheduleVarianceInt);
                                }
                            });
                            
                            // Update Chart 3 title
                            $('.chart-container[data-chart="3"] .chart-title').text('Top 5 Resources - Schedule Variance');
                            
                            updateChart3(labels3, totalTasks3, scheduleVariance3);
                        } else {
                            updateChart3([], [], []);
                        }
                    } catch (ex) {

                        updateKPIDisplay(0, 0, 0, 0);
                        updateChart1([], [], []);
                        updateChart2([], [], []);
                        updateChart3([], []);
                    }
                },
                error: function(xhr, status, error) {

                    if (status === 'timeout') {
                        alertify.error(Resources.A_RequestTimedOut || 'Request timed out. Please try again.');
                    } else if (xhr.status === 404) {

                        alertify.error(Resources.A_APIEndpointNotFound || 'API endpoint not found. Please contact administrator.');
                    } else if (xhr.status >= 500) {
                        alertify.error(Resources.A_ServerError || 'Server error. Please try again later.');
                    }
                    updateKPIDisplay(0, 0, 0, 0);
                    updateChart1([], [], []);
                    updateChart2([], [], []);
                    updateChart3([], [], []);
                }
            });
        }
        
        // Note: loadChart1FromAPI, loadChart2FromAPI, and loadChart3FromAPI are not used for Slipping Tasks
        // All chart loading is handled by loadSlippingTasksWidgetData above
        
        function loadChart1FromAPI(reportId, parameters) {
            // ProjectID is required
            if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
                return;
            }
            
            var requestData = {
                ReportID: parseInt(reportId),
                Parameters: Object.keys(parameters).length > 0 ? parameters : null
            };
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetTop5ResourcesChart',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                success: function(response) {
                    var chartData = null;
                    
                    // Check if response has data property (wrapped by ResponseHelper)
                    if (response && response.data) {
                        chartData = response.data;
                    }
                    // Check if response itself has the chart data properties
                    else if (response && response.labels && response.totalTasks && response.completedTasks) {
                        chartData = response;
                    }
                    
                    if (chartData && chartData.labels && chartData.totalTasks && chartData.completedTasks) {
                        // Filter out "Unknown" resources
                        var filteredLabels = [];
                        var filteredTotalTasks = [];
                        var filteredCompletedTasks = [];
                        
                        for (var i = 0; i < chartData.labels.length; i++) {
                            var label = chartData.labels[i];
                            if (label && 
                                label.toString().trim() !== '' && 
                                label.toString().trim().toLowerCase() !== 'unknown') {
                                filteredLabels.push(label);
                                filteredTotalTasks.push(chartData.totalTasks[i] || 0);
                                filteredCompletedTasks.push(chartData.completedTasks[i] || 0);
                            }
                        }
                        
                        updateChart1(filteredLabels, filteredTotalTasks, filteredCompletedTasks);
                    } else {
                        updateChart1([], [], []);
                    }
                },
                error: function(xhr, status, error) {

                    updateChart1([], [], []);
                }
            });
        }
        
        function loadChart2FromAPI(reportId, parameters) {
            // ProjectID is required
            if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
                return;
            }
            
            var requestData = {
                ReportID: parseInt(reportId),
                Parameters: Object.keys(parameters).length > 0 ? parameters : null
            };
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetTop5ResourcesOverrunChart',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                success: function(response) {
                    var chartData = null;
                    
                    if (response && response.data) {
                        chartData = response.data;
                    }
                    else if (response && response.labels && response.totalTasks && response.overrunTasks) {
                        chartData = response;
                    }
                    
                    if (chartData && chartData.labels && chartData.totalTasks && chartData.overrunTasks) {
                        // Filter out "Unknown" resources
                        var filteredLabels = [];
                        var filteredTotalTasks = [];
                        var filteredOverrunTasks = [];
                        
                        for (var i = 0; i < chartData.labels.length; i++) {
                            var label = chartData.labels[i];
                            if (label && 
                                label.toString().trim() !== '' && 
                                label.toString().trim().toLowerCase() !== 'unknown') {
                                filteredLabels.push(label);
                                filteredTotalTasks.push(chartData.totalTasks[i] || 0);
                                filteredOverrunTasks.push(chartData.overrunTasks[i] || 0);
                            }
                        }
                        
                        updateChart2(filteredLabels, filteredTotalTasks, filteredOverrunTasks);
                    } else {
                        updateChart2([], [], []);
                    }
                },
                error: function(xhr, status, error) {

                    updateChart2([], [], []);
                }
            });
        }
        
        function loadChart3FromAPI(reportId, parameters) {
            // ProjectID is required
            if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
                return;
            }
            
            var requestData = {
                ReportID: parseInt(reportId),
                Parameters: Object.keys(parameters).length > 0 ? parameters : null
            };
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetTop5ResourcesScheduleVarianceChart',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                success: function(response) {
                    var chartData = null;
                    
                    if (response && response.data) {
                        chartData = response.data;
                    }
                    else if (response && response.labels && response.totalTasks && response.scheduleVarianceTasks) {
                        chartData = response;
                    }
                    
                    if (chartData && chartData.labels && chartData.totalTasks && chartData.scheduleVarianceTasks) {
                        // Filter out "Unknown" resources
                        var filteredLabels = [];
                        var filteredTotalTasks = [];
                        var filteredScheduleVarianceTasks = [];
                        
                        for (var i = 0; i < chartData.labels.length; i++) {
                            var label = chartData.labels[i];
                            if (label && 
                                label.toString().trim() !== '' && 
                                label.toString().trim().toLowerCase() !== 'unknown') {
                                filteredLabels.push(label);
                                filteredTotalTasks.push(chartData.totalTasks[i] || 0);
                                filteredScheduleVarianceTasks.push(chartData.scheduleVarianceTasks[i] || 0);
                            }
                        }
                        
                        updateChart3(filteredLabels, filteredTotalTasks, filteredScheduleVarianceTasks);
                    } else {
                        updateChart3([], [], []);
                    }
                },
                error: function(xhr, status, error) {

                    updateChart3([], [], []);
                }
            });
        }
        
        function updateChart1(labels, totalTasks, slippingTasks) {
            if (!chartInstances.chart1) {
                initializeChart1();
            }
            
            if (!chartInstances.chart1) {
                return;
            }
            
            // Ensure arrays are the same length
            var maxLength = Math.max(labels.length, totalTasks.length, slippingTasks.length);
            var safeLabels = labels.slice(0, maxLength);
            var safeTotalTasks = totalTasks.slice(0, maxLength);
            var safeSlippingTasks = slippingTasks.slice(0, maxLength);
            
            // Pad arrays if needed
            while (safeLabels.length < maxLength) safeLabels.push('');
            while (safeTotalTasks.length < maxLength) safeTotalTasks.push(0);
            while (safeSlippingTasks.length < maxLength) safeSlippingTasks.push(0);
            
            // Sanitize data arrays
            safeTotalTasks = safeTotalTasks.map(function(v) { 
                var num = parseInt(v);
                return (isNaN(num) || num === null || num === undefined) ? 0 : num;
            });
            safeSlippingTasks = safeSlippingTasks.map(function(v) { 
                var num = parseInt(v);
                return (isNaN(num) || num === null || num === undefined) ? 0 : num;
            });
            safeLabels = safeLabels.map(function(v) { 
                return (v === undefined || v === null) ? '' : String(v);
            });
            
            // For Task Progress Report, Chart 1 shows Progress vs Completed (stacked chart)
            // Store data for tooltips
            chartInstances.chart1.data.progressTasks = safeTotalTasks;
            chartInstances.chart1.data.completedTasks = safeSlippingTasks;
            
            chartInstances.chart1.data.labels = safeLabels;
            
            // Stacked bar chart: dataset[0] = Progress, dataset[1] = Completed
            chartInstances.chart1.data.datasets[0].data = safeTotalTasks;
            chartInstances.chart1.data.datasets[1].data = safeSlippingTasks;
            chartInstances.chart1.data.datasets[0].label = 'In Progress';
            chartInstances.chart1.data.datasets[1].label = 'Completed';
            
            
            // Update max value for Y-axis
            var allValues = safeTotalTasks.map(function(v) { return parseInt(v) || 0; });
            var maxValue = allValues.length > 0 ? Math.max.apply(null, allValues) : 0;
            
            var calculatedMax, stepSize;
            if (maxValue > 0) {
                calculatedMax = Math.ceil(maxValue * 1.2);
                calculatedMax = Math.ceil(calculatedMax / 5) * 5;
                stepSize = 5;
            } else {
                calculatedMax = 10;
                stepSize = 5;
            }
            
            chartInstances.chart1.options.scales.y.min = 0;
            chartInstances.chart1.options.scales.y.max = calculatedMax;
            
            if (!chartInstances.chart1.options.scales.y.ticks) {
                chartInstances.chart1.options.scales.y.ticks = {};
            }
            if (!chartInstances.chart1.options.scales.y.ticks.font) {
                chartInstances.chart1.options.scales.y.ticks.font = {};
            }
            
            chartInstances.chart1.options.scales.y.ticks.stepSize = stepSize;
            chartInstances.chart1.options.scales.y.ticks.display = true;
            chartInstances.chart1.options.scales.y.ticks.autoSkip = true;
            chartInstances.chart1.options.scales.y.ticks.min = 0;
            chartInstances.chart1.options.scales.y.ticks.max = calculatedMax;
            var maxTicks = Math.min(Math.ceil(calculatedMax / stepSize) + 1, 11);
            chartInstances.chart1.options.scales.y.ticks.maxTicksLimit = maxTicks;
            chartInstances.chart1.options.scales.y.ticks.font.size = 7;
            
            if (!chartInstances.chart1.options.scales.x.ticks) {
                chartInstances.chart1.options.scales.x.ticks = {};
            }
            if (!chartInstances.chart1.options.scales.x.ticks.font) {
                chartInstances.chart1.options.scales.x.ticks.font = {};
            }
            chartInstances.chart1.options.scales.x.ticks.font.size = 7;
            chartInstances.chart1.options.scales.x.ticks.maxRotation = 45;
            chartInstances.chart1.options.scales.x.ticks.minRotation = 0;
            
            if (!chartInstances.chart1.options.plugins.legend) {
                chartInstances.chart1.options.plugins.legend = {};
            }
            if (!chartInstances.chart1.options.plugins.legend.labels) {
                chartInstances.chart1.options.plugins.legend.labels = {};
            }
            if (!chartInstances.chart1.options.plugins.legend.labels.font) {
                chartInstances.chart1.options.plugins.legend.labels.font = {};
            }
            chartInstances.chart1.options.plugins.legend.labels.font.size = 8;
            chartInstances.chart1.options.plugins.legend.labels.boxWidth = 10;
            chartInstances.chart1.options.plugins.legend.labels.padding = 5;
            
            chartInstances.chart1.options.scales.y.afterBuildTicks = function(scale) {
                scale.ticks = [];
                var max = (calculatedMax !== undefined && calculatedMax !== null && !isNaN(calculatedMax)) ? calculatedMax : 10;
                var step = 5;
                if (max > 0 && step > 0) {
                    for (var i = 0; i <= max; i += step) {
                        scale.ticks.push({ value: i });
                    }
                }
            };
            
            if (!chartInstances.chart1.options.scales.y.ticks.callback) {
                chartInstances.chart1.options.scales.y.ticks.callback = function(value, index, values) {
                    if (value === undefined || value === null || isNaN(value)) {
                        return '';
                    }
                    return value.toString();
                };
            }
            
            chartInstances.chart1.update('none');
        }
        
        function updateChart2(labels, totalTasks, overrunTasks) {
            if (!chartInstances.chart2) {
                initializeChart2();
            }
            
            if (!chartInstances.chart2) {
                return;
            }
            
            // Ensure arrays are the same length
            var maxLength = Math.max(labels.length, totalTasks.length, overrunTasks.length);
            var safeLabels = labels.slice(0, maxLength);
            var safeTotalTasks = totalTasks.slice(0, maxLength).map(function(v) { return parseInt(v) || 0; });
            var safeOverrunTasks = overrunTasks.slice(0, maxLength).map(function(v) { return parseInt(v) || 0; });
            
            // Pad arrays if needed
            if (maxLength > 0) {
                while (safeLabels.length < maxLength) safeLabels.push('');
                while (safeTotalTasks.length < maxLength) safeTotalTasks.push(0);
                while (safeOverrunTasks.length < maxLength) safeOverrunTasks.push(0);
            }
            
            // Check if this is Task Progress Report (single dataset - average effort overrun)
            // If totalTasks is empty, treat as single dataset for average effort overrun
            var hasTotalTasks = safeTotalTasks.length > 0 && safeTotalTasks.some(function(v) { return parseInt(v) > 0; });
            
            if (!hasTotalTasks && safeOverrunTasks.length > 0) {
                // Task Progress Report: Single dataset showing average effort overrun
                chartInstances.chart2.data.averageEffortOverrun = safeOverrunTasks;
                chartInstances.chart2.data.labels = safeLabels;
                chartInstances.chart2.data.datasets[0].data = safeOverrunTasks;
                chartInstances.chart2.data.datasets[0].label = 'Average Effort Overrun';
                if (chartInstances.chart2.data.datasets.length > 1) {
                    chartInstances.chart2.data.datasets[1].data = [];
                }
            } else {
                // Standard: Two datasets (Total and Overrun)
                chartInstances.chart2.data.totalTasks = safeTotalTasks;
                chartInstances.chart2.data.labels = safeLabels;
                chartInstances.chart2.data.datasets[0].data = safeTotalTasks;
                chartInstances.chart2.data.datasets[1].data = safeOverrunTasks;
                chartInstances.chart2.data.datasets[0].label = 'Total';
                chartInstances.chart2.data.datasets[1].label = 'Overrun';
            }
            
            
            // Update max value for Y-axis
            var allValues = safeTotalTasks.concat(safeOverrunTasks);
            var maxValue = allValues.length > 0 ? Math.max.apply(null, allValues) : 0;
            
            var calculatedMax;
            if (maxValue > 0) {
                calculatedMax = Math.ceil(maxValue * 1.2);
                calculatedMax = Math.ceil(calculatedMax / 5) * 5;
            } else {
                calculatedMax = 10;
            }
            
            chartInstances.chart2.options.scales.y.min = 0;
            chartInstances.chart2.options.scales.y.max = calculatedMax;
            
            if (!chartInstances.chart2.options.scales.y.ticks) {
                chartInstances.chart2.options.scales.y.ticks = {};
            }
            if (!chartInstances.chart2.options.scales.y.ticks.font) {
                chartInstances.chart2.options.scales.y.ticks.font = {};
            }
            
            chartInstances.chart2.options.scales.y.ticks.stepSize = 5;
            chartInstances.chart2.options.scales.y.ticks.display = true;
            chartInstances.chart2.options.scales.y.ticks.autoSkip = true;
            chartInstances.chart2.options.scales.y.ticks.min = 0;
            chartInstances.chart2.options.scales.y.ticks.max = calculatedMax;
            var maxTicks = Math.min(Math.ceil(calculatedMax / 5) + 1, 11);
            chartInstances.chart2.options.scales.y.ticks.maxTicksLimit = maxTicks;
            chartInstances.chart2.options.scales.y.ticks.font.size = 7;
            
            if (!chartInstances.chart2.options.scales.x.ticks) {
                chartInstances.chart2.options.scales.x.ticks = {};
            }
            if (!chartInstances.chart2.options.scales.x.ticks.font) {
                chartInstances.chart2.options.scales.x.ticks.font = {};
            }
            chartInstances.chart2.options.scales.x.ticks.font.size = 7;
            chartInstances.chart2.options.scales.x.ticks.maxRotation = 45;
            chartInstances.chart2.options.scales.x.ticks.minRotation = 0;
            
            if (!chartInstances.chart2.options.plugins.legend) {
                chartInstances.chart2.options.plugins.legend = {};
            }
            if (!chartInstances.chart2.options.plugins.legend.labels) {
                chartInstances.chart2.options.plugins.legend.labels = {};
            }
            if (!chartInstances.chart2.options.plugins.legend.labels.font) {
                chartInstances.chart2.options.plugins.legend.labels.font = {};
            }
            chartInstances.chart2.options.plugins.legend.labels.font.size = 8;
            chartInstances.chart2.options.plugins.legend.labels.boxWidth = 10;
            chartInstances.chart2.options.plugins.legend.labels.padding = 5;
            
            chartInstances.chart2.options.scales.y.afterBuildTicks = function(scale) {
                scale.ticks = [];
                var max = (calculatedMax !== undefined && calculatedMax !== null && !isNaN(calculatedMax)) ? calculatedMax : 10;
                var step = 5;
                if (max > 0 && step > 0) {
                    for (var i = 0; i <= max; i += step) {
                        scale.ticks.push({ value: i });
                    }
                }
            };
            
            chartInstances.chart2.options.scales.x.stacked = false;
            chartInstances.chart2.options.scales.y.stacked = false;
            
            chartInstances.chart2.update('none');
        }
        
        function updateChart3(labels, totalTasks, scheduleVarianceTasks) {
            if (!chartInstances.chart3) {
                initializeChart3();
            }
            
            if (!chartInstances.chart3) {
                return;
            }
            
            // Ensure arrays are the same length
            var maxLength = Math.max(labels.length, totalTasks.length, scheduleVarianceTasks.length);
            var safeLabels = labels.slice(0, maxLength);
            var safeTotalTasks = totalTasks.slice(0, maxLength).map(function(v) { return parseInt(v) || 0; });
            var safeScheduleVarianceTasks = scheduleVarianceTasks.slice(0, maxLength).map(function(v) { return parseInt(v) || 0; });
            
            // Pad arrays if needed
            if (maxLength > 0) {
                while (safeLabels.length < maxLength) safeLabels.push('');
                while (safeTotalTasks.length < maxLength) safeTotalTasks.push(0);
                while (safeScheduleVarianceTasks.length < maxLength) safeScheduleVarianceTasks.push(0);
            }
            
            // Ensure we have two datasets (Total Tasks and Schedule Variance)
            if (chartInstances.chart3.data.datasets.length < 2) {
                if (chartInstances.chart3.data.datasets.length === 1) {
                    chartInstances.chart3.data.datasets.push({
                        label: 'Schedule Variance',
                        data: safeScheduleVarianceTasks,
                        backgroundColor: '#f97316'
                    });
                    chartInstances.chart3.data.datasets[0].label = 'Total Tasks';
                    chartInstances.chart3.data.datasets[0].backgroundColor = '#3b82f6';
                } else if (chartInstances.chart3.data.datasets.length === 0) {
                    chartInstances.chart3.data.datasets = [
                        {
                            label: 'Total Tasks',
                            data: safeTotalTasks,
                            backgroundColor: '#3b82f6'
                        },
                        {
                            label: 'Schedule Variance',
                            data: safeScheduleVarianceTasks,
                            backgroundColor: '#f97316'
                        }
                    ];
                }
            }
            
            // Check if this is Task Progress Report (single dataset - schedule variance)
            // If totalTasks is empty, treat as single dataset for schedule variance
            var hasTotalTasks = safeTotalTasks.length > 0 && safeTotalTasks.some(function(v) { return parseInt(v) > 0; });
            
            if (!hasTotalTasks && safeScheduleVarianceTasks.length > 0) {
                // Task Progress Report: Single dataset showing schedule variance
                chartInstances.chart3.data.scheduleVariance = safeScheduleVarianceTasks;
                chartInstances.chart3.data.labels = safeLabels;
                chartInstances.chart3.data.datasets[0].data = safeScheduleVarianceTasks;
                chartInstances.chart3.data.datasets[0].label = 'Schedule Variance';
                chartInstances.chart3.data.datasets[0].backgroundColor = '#f97316';
                if (chartInstances.chart3.data.datasets.length > 1) {
                    chartInstances.chart3.data.datasets[1].data = [];
                }
            } else {
                // Standard: Two datasets (Total Tasks and Schedule Variance)
                chartInstances.chart3.data.totalTasks = safeTotalTasks;
                chartInstances.chart3.data.labels = safeLabels;
                chartInstances.chart3.data.datasets[0].data = safeTotalTasks;
                chartInstances.chart3.data.datasets[0].label = 'Total Tasks';
                chartInstances.chart3.data.datasets[0].backgroundColor = '#3b82f6';
                chartInstances.chart3.data.datasets[1].data = safeScheduleVarianceTasks;
                chartInstances.chart3.data.datasets[1].label = 'Schedule Variance';
                chartInstances.chart3.data.datasets[1].backgroundColor = '#f97316';
            }
            
            
            // Update max value for Y-axis based on both datasets
            var maxTotalTasks = safeTotalTasks.length > 0 ? Math.max.apply(null, safeTotalTasks) : 0;
            var maxScheduleVariance = safeScheduleVarianceTasks.length > 0 ? Math.max.apply(null, safeScheduleVarianceTasks) : 0;
            var maxValue = Math.max(maxTotalTasks, maxScheduleVariance);
            
            var calculatedMax;
            if (maxValue > 0) {
                calculatedMax = Math.ceil(maxValue * 1.2);
                calculatedMax = Math.ceil(calculatedMax / 5) * 5;
            } else {
                calculatedMax = 10;
            }
            
            chartInstances.chart3.options.scales.y.min = 0;
            chartInstances.chart3.options.scales.y.max = calculatedMax;
            
            if (!chartInstances.chart3.options.scales.y.ticks) {
                chartInstances.chart3.options.scales.y.ticks = {};
            }
            if (!chartInstances.chart3.options.scales.y.ticks.font) {
                chartInstances.chart3.options.scales.y.ticks.font = {};
            }
            
            chartInstances.chart3.options.scales.y.ticks.stepSize = 5;
            chartInstances.chart3.options.scales.y.ticks.display = true;
            chartInstances.chart3.options.scales.y.ticks.autoSkip = true;
            chartInstances.chart3.options.scales.y.ticks.min = 0;
            chartInstances.chart3.options.scales.y.ticks.max = calculatedMax;
            var maxTicks = Math.min(Math.ceil(calculatedMax / 5) + 1, 11);
            chartInstances.chart3.options.scales.y.ticks.maxTicksLimit = maxTicks;
            chartInstances.chart3.options.scales.y.ticks.font.size = 7;
            
            if (!chartInstances.chart3.options.scales.x.ticks) {
                chartInstances.chart3.options.scales.x.ticks = {};
            }
            if (!chartInstances.chart3.options.scales.x.ticks.font) {
                chartInstances.chart3.options.scales.x.ticks.font = {};
            }
            chartInstances.chart3.options.scales.x.ticks.font.size = 7;
            chartInstances.chart3.options.scales.x.ticks.maxRotation = 45;
            chartInstances.chart3.options.scales.x.ticks.minRotation = 0;
            
            if (!chartInstances.chart3.options.plugins.legend) {
                chartInstances.chart3.options.plugins.legend = {};
            }
            if (!chartInstances.chart3.options.plugins.legend.labels) {
                chartInstances.chart3.options.plugins.legend.labels = {};
            }
            if (!chartInstances.chart3.options.plugins.legend.labels.font) {
                chartInstances.chart3.options.plugins.legend.labels.font = {};
            }
            chartInstances.chart3.options.plugins.legend.labels.font.size = 8;
            chartInstances.chart3.options.plugins.legend.labels.boxWidth = 10;
            chartInstances.chart3.options.plugins.legend.labels.padding = 5;
            
            chartInstances.chart3.options.scales.y.afterBuildTicks = function(scale) {
                scale.ticks = [];
                var max = (calculatedMax !== undefined && calculatedMax !== null && !isNaN(calculatedMax)) ? calculatedMax : 10;
                var step = 5;
                if (max > 0 && step > 0) {
                    for (var i = 0; i <= max; i += step) {
                        scale.ticks.push({ value: i });
                    }
                }
            };
            
            chartInstances.chart3.options.scales.x.stacked = false;
            chartInstances.chart3.options.scales.y.stacked = false;
            
            chartInstances.chart3.update('active');
        }
        
        function downloadReport(format) {

            var projectID = $('#cboProject').val();
            var period = $('#cboPeriod').val();
            var taskStatus = $('#cboTaskStatus').val() || '';
            var showRollupMPPTasks = $('#chkShowRollupMPPTasks').is(':checked');

            if (!projectID || projectID === '' || projectID === '0') {
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                return;
            }
            
            if (!period || period === '' || period === '0') {
                alertify.error(Resources.A_PeriodShouldNotBeBlank || 'Please select a period');
                return;
            }
            
            // Build request data - API expects parameters nested in Parameters property
            var parameters = {
                ProjectID: parseInt(projectID),
                PeriodFlag: parseInt(period),
                SelectedCase: 0,
                ShowCompleteMPPTasks: showRollupMPPTasks
            };
            
            if (taskStatus && taskStatus !== '' && taskStatus !== 'All Status') {
                parameters.TaskStatus = taskStatus;
            }
            
            var requestData = {
                ReportID: 996,
                Format: format,
                Parameters: parameters
            };
            
            
            // Use fetch API for file download with authentication
            var token = getAuthToken();
            showLoading();

            fetch(baseUrl + '/api/ReportUIBuilder/DownloadReport', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': token ? 'bearer ' + token : ''
                },
                body: JSON.stringify(requestData)
            })
            .then(function(response) {


                // Get content type
                var contentType = response.headers.get('content-type') || '';

                if (!response.ok) {
                    // Try to get error message from response
                    return response.text().then(function(text) {

                        try {
                            var errorData = JSON.parse(text);
                            var errorMsg = errorData.message || errorData.error || 'Download failed: ' + response.status;
                            throw new Error(errorMsg);
                        } catch (e) {
                            throw new Error('Download failed: ' + response.status + ' - ' + (text || 'Unknown error'));
                        }
                    });
                }
                
                // If content-type is JSON, it's likely an error response
                if (contentType.indexOf('application/json') !== -1) {
                    return response.json().then(function(jsonData) {

                        var errorMsg = jsonData.message || jsonData.error || 'Server returned JSON instead of file';
                        throw new Error(errorMsg);
                    });
                }
                
                return response.blob().then(function(blob) {


                    // Check if blob is suspiciously small (might be an error response)
                    if (blob.size < 100) {
                        return blob.text().then(function(text) {

                            try {
                                var jsonResponse = JSON.parse(text);
                                if (jsonResponse.message || jsonResponse.error) {
                                    throw new Error(jsonResponse.message || jsonResponse.error || 'No data available to download');
                                }
                            } catch (e) {
                                // Not JSON, might be valid small file - continue
                            }
                            return blob;
                        });
                    }
                    return blob;
                });
            })
            .then(function(blob) {
                hideLoading();
                
                if (!blob || blob.size === 0) {
                    throw new Error('Downloaded file is empty');
                }

                // Create blob URL
                var url = window.URL.createObjectURL(blob);
                var fileExtension = format === 'pdf' ? 'pdf' : (format === 'excel' || format === 'xlsx' || format === 'xls') ? 'xls' : 'pdf';
                var fileName = 'TaskProgressReport_' + format + '_' + new Date().getTime() + '.' + fileExtension;
                
                // Check if we're in an iframe
                var isInIframe = window.self !== window.top;

                // Method 1: Try using anchor click in parent window if in iframe
                try {
                    var targetDoc = isInIframe ? window.top.document : document;
                    var a = targetDoc.createElement('a');
                    a.href = url;
                    a.download = fileName;
                    a.style.position = 'fixed';
                    a.style.left = '-9999px';
                    targetDoc.body.appendChild(a);

                    // Use requestAnimationFrame to ensure DOM is ready
                    requestAnimationFrame(function() {
                        try {
                            a.click();

                            // Clean up after download starts
                            setTimeout(function() {
                                if (a.parentNode) {
                                    targetDoc.body.removeChild(a);
                                }
                                window.URL.revokeObjectURL(url);

                            }, 1000);
                            
                            // Show success message
                            if (typeof alertify !== 'undefined') {
                                alertify.success(Resources.A_ReportDownloadedSuccessfully || 'Report download started. Please check your downloads folder.');
                            }
                        } catch (clickError) {

                            // Fallback: open in new window
                            var newWindow = window.open(url, '_blank');
                            if (newWindow) {
                                setTimeout(function() {
                                    newWindow.close();
                                }, 100);
                            } else {
                                alertify.error(Resources.A_PleaseAllowPopups || 'Please allow popups to download the file.');
                            }
                            window.URL.revokeObjectURL(url);
                        }
                    });
                } catch (e) {

                    // Final fallback: try direct window.open
                    var newWindow = window.open(url, '_blank');
                    if (newWindow) {
                        setTimeout(function() {
                            newWindow.close();
                        }, 100);
                        alertify.success(Resources.A_ReportOpenedInNewWindow || 'Report opened in new window. Please save it manually.');
                    } else {
                        alertify.error(Resources.A_UnableToDownload || 'Unable to download. Please check browser settings or try right-clicking the download link.');
                    }
                    window.URL.revokeObjectURL(url);
                }
            })
            .catch(function(error) {
                hideLoading();

                alertify.error((Resources.A_ErrorDownloadingReport || 'Error downloading report') + ': ' + (error.message || Resources.A_UnknownError || 'Unknown error'));
            });
        }
        
        function showLoading() {
            if ($('.loading-overlay').length === 0) {
                $('body').append('<div class="loading-overlay"><div class="spinner-border"></div></div>');
            }
        }
        
        function hideLoading() {
            $('.loading-overlay').remove();
        }
    </script>
</body>
</html>

