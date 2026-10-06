<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_CompletedTasks.aspx.vb" Inherits="Whizible.PM_CompletedTasks" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_TotalTasksInProgress") %></title>
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
        
        .no-data-message {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: var(--text-muted);
            font-size: 11.5px; 
            /* Modified By Madhuri.K On 26-03-2026 */
            text-align: center;
            z-index: 10;
            width: 100%;
            padding: 0 1rem;
        }
        
        .no-data-message-table {
            text-align: center;
            padding: 2rem;
            color: var(--text-muted);
            font-size: 11.5px;
            /* Modified By Madhuri.K On 26-03-2026 */
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
        <asp:HiddenField ID="hdnReportID" runat="server" Value="325" />
        <asp:HiddenField ID="hdnViewAccess" runat="server" />
        
        <% If m_blnViewAccess Then %>
        <!-- Top Section - Full Width (Title, Description, Note, Filters) -->
        <div class="reports-top-section">
            <div class="report-header">
                <h1 class="report-title"><%= MyBase.GetResourceString("C_TotalTasksInProgress") %></h1>
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
                                <option value=""><%= MyBase.GetResourceString("C_AllPeriods") %></option>
                            </select>
                        </div>
                        <div class="filter-group" id="resourceFilterGroup">
                            <label for="cboResource"><%= MyBase.GetResourceString("C_Resource") %></label>
                            <select class="form-control selectpicker" id="cboResource" data-live-search="true">
                                <option value=""><%= MyBase.GetResourceString("C_AllResources") %></option>
                            </select>
                        </div>
                    </div>
                    <div class="filter-actions-row" style="display: flex; justify-content: space-between; align-items: center; margin-top: 0.75rem;">
                        <div class="filter-notes-container" style="flex: 1;">
                            <div class="filter-note" id="standardFilterNote">
                                <i class="fas fa-info-circle"></i>
                                <span><%= MyBase.GetResourceString("C_NotePeriodNotMentioned") %></span>
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
                            <div class="kpi-label">Total Tasks In Progress</div>
                            <div class="kpi-value" id="kpiTotalTasks">0</div>
                        </div>
                        <div class="kpi-box">
                            <div class="kpi-label"><%= MyBase.GetResourceString("C_AverageDelayDays") %></div>
                            <div class="kpi-value" id="kpiAvgDelay">0</div>
                        </div>
                        <div class="kpi-box">
                            <div class="kpi-label"><%= MyBase.GetResourceString("C_AverageEffortOverrun") %></div>
                            <div class="kpi-value" id="kpiEffortOverrun">0%</div>
                        </div>
                        <div class="kpi-box">
                            <div class="kpi-label"><%= MyBase.GetResourceString("C_TasksCompletedOnTime") %></div>
                            <div class="kpi-value" id="kpiOnTime">0%</div>
                        </div>
                </div>
                
                <!-- Data Table Section -->
                <div class="data-table-container">
                    <div class="table-responsive-custom" style="overflow-x: auto; overflow-y: visible; min-height: 300px;">
                        <table id="tblReportData" class="table table-stripped table-bordered" style="width: 100%;">
                                <thead id="tblReportDataHead">
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_TableHeaderTaskName") %></th>
                                        <th><%= MyBase.GetResourceString("C_TableHeaderResourceName") %></th>
                                        <th><%= MyBase.GetResourceString("C_TableHeaderStartDate") %></th>
                                        <th><%= MyBase.GetResourceString("C_TableHeaderEndDate") %></th>
                                        <th>Work (Hrs)[1]</th>
                                        <th><%= MyBase.GetResourceString("C_TableHeaderActualStartDate") %></th>
                                        <th>Actual Work (Hrs)[2]</th>
                                        <th>Remaining Work (Hrs)[1-2]</th>
                                    </tr>
                                </thead>
                                <tbody id="tblReportDataBody">
                                    <tr>
                                        <td colspan="9" class="no-data-message-table">No data available</td>
                                    </tr>
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
                    <div class="chart-title">Top 5 Resources – In Progress vs Completed Tasks</div>
                    <div class="chart-wrapper">
                        <div class="no-data-message" id="chart1NoData">No data available</div>
                        <canvas id="chart1"></canvas>
                    </div>
                </div>
                
                <div class="chart-container" data-chart="2">
                    <div class="chart-title"><%= MyBase.GetResourceString("C_ChartTop5ResourcesTotalVsOverrun") %></div>
                    <div class="chart-wrapper">
                        <div class="no-data-message" id="chart2NoData">No data available</div>
                        <canvas id="chart2"></canvas>
                    </div>
                </div>
                
                <div class="chart-container" data-chart="3">
                    <div class="chart-title"><%= MyBase.GetResourceString("C_ChartTop5ResourcesScheduleVariance") %></div>
                    <div class="chart-wrapper">
                        <div class="no-data-message" id="chart3NoData">No data available</div>
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
            C_TotalTasksInProgress: '<%= MyBase.GetResourceString("C_TotalTasksInProgress") %>',
            C_TasksCompletedOnTime: '<%= MyBase.GetResourceString("C_TasksCompletedOnTime") %>',
            C_ReportDescriptionTasksInProgress: '<%= MyBase.GetResourceString("C_ReportDescriptionTasksInProgress") %>',
            C_ChartTop5ResourcesTotalVsCompleted: '<%= MyBase.GetResourceString("C_ChartTop5ResourcesTotalVsCompleted") %>',
            A_ReportIDNotFound: '<%= MyBase.GetResourceString("A_ReportIDNotFound") %>',
            A_ProjectShouldNotBeBlank: '<%= MyBase.GetResourceString("A_ProjectShouldNotBeBlank") %>',
            A_ErrorDownloadingReport: '<%= MyBase.GetResourceString("A_ErrorDownloadingReport") %>',
            A_ReportDownloadedSuccessfully: '<%= MyBase.GetResourceString("A_ReportDownloadedSuccessfully") %>',
            A_UnknownError: '<%= MyBase.GetResourceString("A_UnknownError") %>',
            A_PleaseAllowPopups: '<%= MyBase.GetResourceString("A_PleaseAllowPopups") %>',
            A_ReportOpenedInNewWindow: '<%= MyBase.GetResourceString("A_ReportOpenedInNewWindow") %>',
            A_UnableToDownload: '<%= MyBase.GetResourceString("A_UnableToDownload") %>',
            A_InvalidResponseFromServer: '<%= MyBase.GetResourceString("A_InvalidResponseFromServer") %>'
        };
        
        // Global variables
        var currentPage = 1;
        var pageSize = 5;
        var totalRecords = 0;
        var reportData = [];
        var chartInstances = {};
        var chartData = [];
        var isAutoLoadDone = false;
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
        var sessionProjectID = '<%= Session("intProjectID") %>';
        // Initialize on page load
        $(document).ready(function() {
            initializePage();

            // 🔥 AUTO LOAD REPORT, KPI & CHARTS FOR SESSION PROJECT
            if (sessionProjectID && sessionProjectID !== '' && sessionProjectID !== '0' && !isAutoLoadDone) {
                isAutoLoadDone = true;

                // Ensure UI state is correct
                $("#divNoData").hide();
                $("#divGrid").show();
                $("#divChart").show();
                $("#chart1").show();
                $("#chart2").show();
                $("#chart3").show();
                initializeCharts();
                // Delay ensures:
                // ✔ selectpicker ready
                // ✔ DOM ready
                // ✔ filters not racing
                setTimeout(function () {
                    handleShow(); // 🚀 This loads EVERYTHING
                }, 400);
            }
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
            
            // Pre-fill filters from URL parameters (but don't auto-load data)
            // Note: Filters will load when filters section is expanded
            var urlProjectID = getURLParameter('ProjectID');
            var urlReportID = getURLParameter('ReportID');
            var urlPeriod = getURLParameter('Period');
            var urlResourceID = getURLParameter('ResourceID');

            if (urlProjectID && urlProjectID !== '' && urlProjectID !== '0') {
                // Function to set project and pre-fill filters (but NOT load data)
                function setProjectAndFilters() {
                    var $projectSelect = $('#cboProject');
                    if ($projectSelect.length > 0) {
                        // Check if the project option exists in dropdown
                        var projectExists = $projectSelect.find('option[value="' + urlProjectID + '"]').length > 0;
                        
                        if (projectExists) {

                            $projectSelect.val(urlProjectID);
                            $('#<%= hdnProjectID.ClientID %>').val(urlProjectID);
                            
                            // Set period if provided
                            if (urlPeriod && urlPeriod !== '' && urlPeriod !== '0') {
                                $('#cboPeriod').val(urlPeriod);
                                if (typeof $.fn.selectpicker !== 'undefined') {
                                    $('#cboPeriod').selectpicker('refresh');
                                }
                            }
                            
                            // Refresh selectpicker if available
                            if (typeof $.fn.selectpicker !== 'undefined') {
                                $projectSelect.selectpicker('refresh');
                            }
                            
                            // Resources will be loaded when filters section is expanded
                            // Set resource value if provided (will be applied after resources load)
                                if (urlResourceID && urlResourceID !== '' && urlResourceID !== '0') {
                                // Store resource ID to apply after resources are loaded
                                window.pendingResourceID = urlResourceID;
                                }

                            return true;
                        } else {

                            return false;
                        }
                    }
                    return false;
                }
                
                // Set project filters immediately (periods and resources will load when filters section is expanded)

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
                } else {

                }
        }

        function resetKPIsToNA() {
            $('#kpiTotalTasks').text('NA');
            $('#kpiAvgDelay').text('NA');
            $('#kpiEffortOverrun').text('NA').removeClass('text-success text-warning text-danger');
            $('#kpiOnTime').text('NA').removeClass('text-success text-warning text-danger');
        }

        function destroyAllCharts() {
            Object.keys(chartInstances).forEach(function (key) {
                try {
                    if (chartInstances[key]) {
                        chartInstances[key].destroy();
                        chartInstances[key] = null;
                    }
                } catch (e) { }
            });

            // Hide canvases
            $('#chart1, #chart2, #chart3').hide();

            // Show no-data labels if present
            $('#chart1NoData, #chart2NoData, #chart3NoData').show();
        }

        function clearGridWithNoData() {
            var $tbody = $('#tblReportDataBody');
            $tbody.empty().append(
                '<tr><td colspan="9" class="no-data-message-table">No data available</td></tr>'
            );
            $('#totalRecords').text(0);
        }

        var filtersLoaded = false;
        
        function toggleFiltersSection() {
            var filtersSection = $('#filtersSection');
            var isCollapsed = filtersSection.hasClass('collapsed');
            
            if (isCollapsed) {
                filtersSection.removeClass('collapsed');
                
                // Load filters only when filters section is expanded for the first time
                if (!filtersLoaded) {
                    filtersLoaded = true;
                    var periodsPromise = loadPeriods();
                    
                    // If there's a project selected, load resources
                    var projectID = $('#cboProject').val();
                    if (projectID && projectID !== '' && projectID !== '0') {
                        periodsPromise.done(function() {
                            // Trigger ProjectonChange to load resources
                            if (typeof ProjectonChange === 'function') {
                                ProjectonChange();
                            }
                            // Also load resources directly
                            loadResourcesForProject(projectID).done(function() {
                                // Apply pending resource ID if set
                                if (window.pendingResourceID) {
                                    $('#cboResource').val(window.pendingResourceID);
                                    if (typeof $.fn.selectpicker !== 'undefined') {
                                        $('#cboResource').selectpicker('refresh');
                                    }
                                    window.pendingResourceID = null;
                                }
                            });
                        });
                    }
                }
                
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
            var reportID = $('#<%= hdnReportID.ClientID %>').val() || 324;

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
                        // Use default description for Tasks In Progress
                        var defaultDesc = Resources.C_ReportDescriptionTasksInProgress || '';
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
                    var defaultDesc = Resources.C_ReportDescriptionCompletedTasks || '';
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
                loadResourcesForProject(projectID);
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
                success: function (response) {
                    // Handle different response structures
                    var resourcesData = null;
                    if (response) {
                        // Try nested structure first: response.data.Resources or response.data.resources
                        if (response.data) {
                            resourcesData = response.data.Resources || response.data.resources;
                        }
                        // Try direct structure: response.Resources or response.resources (direct API response)
                        if (!resourcesData) {
                            resourcesData = response.Resources || response.resources;
                        }
                        // Also check if response itself is an array (unlikely but possible)
                        if (!resourcesData && Array.isArray(response)) {
                            resourcesData = response;
                        }
                    }

                    if (resourcesData && Array.isArray(resourcesData) && resourcesData.length > 0) {
                        var $resourceSelect = $('#cboResource');
                        $resourceSelect.empty();
                        $resourceSelect.append('<option value=""><%= MyBase.GetResourceString("C_AllResources") %></option>');
                
                        $.each(resourcesData, function(index, resource) {
                            var resourceId = resource.EmployeeID || resource.Id || resource.id || resource.employeeID || '';
                            var resourceName = resource.EmployeeName || resource.Name || resource.name || resource.employeeName || '';
                            if (resourceId && resourceName) {
                                $resourceSelect.append('<option value="' + resourceId + '">' + resourceName + '</option>');
                            }
                        });
                
                        $resourceSelect.selectpicker('refresh');

                    } else {

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
            // Handle different response structures
            var periodsData = null;
            if (response) {
                // Try nested structure first: response.data.Periods or response.data.periods
                if (response.data) {
                    periodsData = response.data.Periods || response.data.periods;
                }
                // Try direct structure: response.Periods or response.periods (direct API response)
                if (!periodsData) {
                    periodsData = response.Periods || response.periods;
                }
                // Also check if response itself is an array (unlikely but possible)
                if (!periodsData && Array.isArray(response)) {
                    periodsData = response;
                }
            }
            
            if (periodsData && Array.isArray(periodsData) && periodsData.length > 0) {
                var $periodSelect = $('#cboPeriod');
                $periodSelect.empty();
                $periodSelect.append('<option value=""><%= MyBase.GetResourceString("C_AllPeriods") %></option>');

                $.each(periodsData, function (index, period) {
                    var periodId = period.UniqueID || period.Id || period.id || period.uniqueID || '';
                    var periodName = period.Description || period.Name || period.name || period.description || '';
                    if (periodId && periodName) {
                        $periodSelect.append('<option value="' + periodId + '">' + periodName + '</option>');
                    }
                });

                $periodSelect.selectpicker('refresh');

            } else {

            }
        },
        error: function (xhr, status, error) {

        }
    });
}
        
        function loadPeriodsForProject(projectID) {
            // Implementation for loading periods specific to project if needed
        }
        
        function handleShow() {
            var projectID = $('#cboProject').val();
            var period = $('#cboPeriod').val();
            var resourceID = $('#cboResource').val();
            if (isAutoLoadDone && (!projectID || projectID === '' || projectID === '0')) {
                projectID = sessionProjectID;
            }
            if (!projectID || projectID === '' || projectID === '0') {
                destroyAllCharts();
                resetKPIsToNA();
                clearGridWithNoData();
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                return;
            }
            
            showLoading();
            
            // Build parameters object - API expects parameters nested in Parameters property
            var requestData = {
                ReportID: 325,
                Parameters: {
                    ProjectID: parseInt(projectID)
                }
            };
            
            if (period && period !== '') {
                requestData.Parameters.Period = parseInt(period);
            }
            
            if (resourceID && resourceID !== '' && resourceID !== '0') {
                requestData.Parameters.ResourceID = parseInt(resourceID);
            }
            
            // Load report data
            loadReportData(requestData);
        }
        
        function loadReportData(requestData) {

            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetReportData',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                success: function(response) {
                    hideLoading();

                    // Handle different response structures
                    var dataArray = [];
                    if (response) {
                        // Check for success flag (lowercase or uppercase) OR presence of data
                        var hasSuccessFlag = response.success === true || response.status === 'SUCCESS' || response.Status === 'SUCCESS';
                        var hasData = (response.data && Array.isArray(response.data) && response.data.length > 0) ||
                                     (response.data && response.data.Data && Array.isArray(response.data.Data)) ||
                                     (response.data && response.data.data && Array.isArray(response.data.data)) ||
                                     (response.data && response.data.ReportData && Array.isArray(response.data.ReportData)) ||
                                     (response.Data && Array.isArray(response.Data)) ||
                                     (Array.isArray(response) && response.length > 0);
                        
                        var isSuccess = hasSuccessFlag || hasData;
                        
                        if (isSuccess) {
                            // Extract data array from various possible structures
                            if (response.data) {
                                if (Array.isArray(response.data)) {
                                    dataArray = response.data;
                                } else if (response.data.Data && Array.isArray(response.data.Data)) {
                                    dataArray = response.data.Data;
                                } else if (response.data.data && Array.isArray(response.data.data)) {
                                    dataArray = response.data.data;
                                } else if (response.data.ReportData && Array.isArray(response.data.ReportData)) {
                                    dataArray = response.data.ReportData;
                                }
                            } else if (response.Data && Array.isArray(response.Data)) {
                                dataArray = response.Data;
                            } else if (Array.isArray(response)) {
                                dataArray = response;
                            }
                            
                            if (dataArray.length > 0) {
                                reportData = dataArray;
                                totalRecords = reportData.length;
                                currentPage = 1;

                                displayReportData();
                                loadCharts(requestData, reportData);
                            } else {
                                // No data but response structure looks successful
                                reportData = [];
                                totalRecords = 0;
                                currentPage = 1;
                                chartData = [];

                                destroyAllCharts();
                                resetKPIsToNA();
                                clearGridWithNoData();
                                $('#chart1NoData, #chart2NoData, #chart3NoData').show();
                                // ❌ DO NOT show success message here
                                return;
                                // Show "No data available" for charts
                            }
                        } else {
                            totalRecords = 0;
                            currentPage = 1;

                            destroyAllCharts();
                            resetKPIsToNA();
                            clearGridWithNoData();
                            $('#chart1NoData, #chart2NoData, #chart3NoData').show();
                            // ❌ DO NOT show success message here
                            return;
                            // Show "No data available" for charts
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
            
            if (!reportData || reportData.length === 0) {
                $tbody.append('<tr><td colspan="9" class="no-data-message-table">No data available</td></tr>');
                updatePagination();
                $('#totalRecords').text(0);
                return;
            }
            
            var startIndex = (currentPage - 1) * pageSize;
            var endIndex = Math.min(startIndex + pageSize, reportData.length);
            var pageData = reportData.slice(startIndex, endIndex);
            
            $.each(pageData, function(index, task) {
                // Calculate remaining work: Work (Hrs)[1] - Actual Work (Hrs)[2]
                var workHrs = parseFloat(task.work || 0);
                var actualWorkHrs = parseFloat(task.ActualWork || task.ActualHr || 0);
                var remainingWorkHrs = Math.max(0, workHrs - actualWorkHrs); // Ensure non-negative
                var row = '<tr>' +
                    '<td>' + (task.TaskName || '') + '</td>' +
                    '<td>' + (task.Resource || task.ResourceName || '') + '</td>' +
                    '<td>' + formatDate(task.Startdate) + '</td>' +
                    '<td>' + formatDate(task.Enddate) + '</td>' +
                    '<td>' + workHrs.toFixed(2) + '</td>' +
                    '<td>' + formatDate(task.ActualStartDate) + '</td>' +
                    '<td>' + actualWorkHrs.toFixed(2) + '</td>' +
                    '<td>' + remainingWorkHrs.toFixed(2) + '</td>' +
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

            if (!reportData || reportData.length === 0) {
                resetKPIsToNA();
                return;
            }

            let inProgressTasks = [];
            let delayedTasks = [];
            let completedTasks = [];
            // Categorize tasks
            reportData.forEach(task => {

                const isStarted = task.ActualStartDate;
                const isCompleted = task.ActualEndDate;

                if (isStarted && !isCompleted) {
                    inProgressTasks.push(task);
                }

                if (isCompleted) {
                    completedTasks.push(task);
                }
            });
            chartData.forEach(task => {

                const isStarted = task.ActualStartDate;
                const isCompleted = task.ActualEndDate;
                if (isCompleted) {
                    completedTasks.push(task);
                }
            });

            /* KPI 1: Total Tasks In Progress */
            $('#kpiTotalTasks').text(inProgressTasks.length);

            /* KPI 2 & 3: Delayed Tasks (In-Progress only) */
            let totalDelayDays = 0;
            let totalEffortVariance = 0;

            completedTasks.forEach(task => {

                if (task.EndDate && task.ActualEndDate) {
                    const planned = new Date(task.EndDate);
                    const actual = new Date(task.ActualEndDate);

                    const delayDays = Math.ceil((actual - planned) / (1000 * 60 * 60 * 24));

                    if (delayDays > 0) {
                        delayedTasks.push(task);
                        totalDelayDays += delayDays;

                        if (task.Work && task.ActualWork) {
                            const variance =
                                ((task.ActualWork - task.Work) / task.Work) * 100;
                            totalEffortVariance += variance;
                        }
                    }
                }
            });

            /* KPI 2: Average Delay */
            const avgDelay =
                delayedTasks.length > 0
                    ? Math.round(totalDelayDays / delayedTasks.length)
                    : 0;

            $('#kpiAvgDelay').text(avgDelay);

            /* KPI 3: Average Effort Overrun */
            const avgEffortOverrun =
                delayedTasks.length > 0
                    ? Math.round(totalEffortVariance / delayedTasks.length)
                    : 0;

            $('#kpiEffortOverrun')
                .text(avgEffortOverrun + '%')
                .removeClass('text-success text-warning text-danger')
                .addClass(
                    avgEffortOverrun > 0
                        ? 'text-danger'
                        : avgEffortOverrun === 0
                            ? 'text-warning'
                            : 'text-success'
                );

            /* KPI 4: % Tasks Completed On Time */
            let completedOnTime = 0;

            completedTasks.forEach(task => {
                if (task.EndDate && task.ActualEndDate) {
                    if (new Date(task.ActualEndDate) <= new Date(task.EndDate)) {
                        completedOnTime++;
                    }
                }
            });

            const percentOnTime =
                completedTasks.length > 0
                    ? Math.round((completedOnTime / completedTasks.length) * 100)
                    : 0;

            $('#kpiOnTime')
                .text(percentOnTime + '%')
                .removeClass('text-success text-warning text-danger')
                .addClass(
                    percentOnTime === 100
                        ? 'text-success'
                        : percentOnTime >= 80
                            ? 'text-warning'
                            : 'text-danger'
                );
        }
        
        function initializeCharts() {
            initializeChart1();
            initializeChart2();
            initializeChart3();
        }
        
        function initializeChart1() {
            try {

                if (!reportData || reportData.length === 0) {
                    showNoDataForChart(1);
                    return;
                }

                var $wrapper = $('.chart-container[data-chart="1"] .chart-wrapper');
                $wrapper.find('.no-data-msg').remove();
                $('#chart1').show();

                var canvas1 = document.getElementById('chart1');
                if (!canvas1) return;

                if (chartInstances.chart1) {
                    try { chartInstances.chart1.destroy(); } catch (e) { }
                    chartInstances.chart1 = null;
                }

                var existingChart = Chart.getChart(canvas1);
                if (existingChart) existingChart.destroy();

                var labels = [];
                var completed = [];
                var inProgress = [];

                reportData.forEach(function (item) {
                    labels.push(item.EmployeeName || item.ResourceName || '');
                    completed.push(item.CompletedTasks || 0);
                    inProgress.push(item.InProgressTasks || 0);
                });

                var ctx1 = canvas1.getContext('2d');

                chartInstances.chart1 = new Chart(ctx1, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [
                            { label: 'InProgress', data: inProgress, backgroundColor: '#3b82f6' },
                            { label: 'Completed', data: completed, backgroundColor: '#f97316' }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            x: { stacked: true },
                            y: { stacked: true, beginAtZero: true }
                        }
                    }
                });

            } catch (error) {

            }
        }



        function initializeChart2() {
            try {

                /* ============================
                   NO DATA → SHOW MESSAGE
                ============================ */
                if (!reportData || reportData.length === 0) {
                    showNoDataForChart(2);
                    return;
                }

                /* ============================
                   CLEAR NO DATA MESSAGE
                ============================ */
                var $wrapper = $('.chart-container[data-chart="2"] .chart-wrapper');
                $wrapper.find('.no-data-msg').remove();
                $('#chart2').show();

                var canvas2 = document.getElementById('chart2');
                if (!canvas2) return;

                /* ============================
                   DESTROY EXISTING CHART
                ============================ */
                if (chartInstances.chart2) {
                    try { chartInstances.chart2.destroy(); } catch (e) { }
                    chartInstances.chart2 = null;
                }

                try {
                    var existingChart = Chart.getChart(canvas2);
                    if (existingChart) existingChart.destroy();
                } catch (e) { }

                /* ============================
                   BUILD DATA FROM reportData
                   (adjust mapping if needed)
                ============================ */
                var labels = [];
                var total = [];
                var overrun = [];

                reportData.forEach(function (item) {
                    labels.push(item.EmployeeName || item.ResourceName || '');
                    total.push(item.TotalTasks || 0);
                    overrun.push(item.OverrunTasks || 0);
                });

                /* ============================
                   INIT CHART
                ============================ */
                var ctx2 = canvas2.getContext('2d');

                chartInstances.chart2 = new Chart(ctx2, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [
                            { label: 'Total', data: total, backgroundColor: '#3b82f6' },
                            { label: 'Overrun', data: overrun, backgroundColor: '#f97316' }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    font: { size: 8 },
                                    boxWidth: 10,
                                    padding: 5
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                titleFont: { size: 11 },
                                bodyFont: { size: 10 }
                            }
                        },
                        scales: {
                            x: {
                                stacked: false,
                                categoryPercentage: 0.4,
                                barPercentage: 0.4,
                                ticks: {
                                    font: { size: 7 },
                                    maxRotation: 45,
                                    minRotation: 0
                                }
                            },
                            y: {
                                stacked: false,
                                beginAtZero: true,
                                ticks: {
                                    stepSize: 5,
                                    font: { size: 7 }
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

                /* ============================
                   NO DATA → SHOW MESSAGE
                ============================ */
                if (!reportData || reportData.length === 0) {
                    showNoDataForChart(3);
                    return;
                }

                /* ============================
                   CLEAR NO DATA MESSAGE
                ============================ */
                var $wrapper = $('.chart-container[data-chart="3"] .chart-wrapper');
                $wrapper.find('.no-data-msg').remove();
                $('#chart3').show();

                var canvas3 = document.getElementById('chart3');
                if (!canvas3) return;

                /* ============================
                   DESTROY EXISTING CHART
                ============================ */
                if (chartInstances.chart3) {
                    try { chartInstances.chart3.destroy(); } catch (e) { }
                    chartInstances.chart3 = null;
                }

                try {
                    var existingChart = Chart.getChart(canvas3);
                    if (existingChart) existingChart.destroy();
                } catch (e) { }

                /* ============================
                   BUILD DATA FROM reportData
                   (adjust mapping if needed)
                ============================ */
                var labels = [];
                var totalTasks = [];
                var scheduleVariance = [];

                reportData.forEach(function (item) {
                    labels.push(item.EmployeeName || item.ResourceName || '');
                    totalTasks.push(item.TotalTasks || 0);
                    scheduleVariance.push(item.ScheduleVariance || 0);
                });

                /* ============================
                   INIT CHART
                ============================ */
                var ctx3 = canvas3.getContext('2d');

                chartInstances.chart3 = new Chart(ctx3, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [
                            { label: 'Total Tasks', data: totalTasks, backgroundColor: '#3b82f6' },
                            { label: 'Schedule Variance', data: scheduleVariance, backgroundColor: '#f97316' }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                labels: {
                                    font: { size: 8 },
                                    boxWidth: 10,
                                    padding: 5
                                }
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                titleFont: { size: 11 },
                                bodyFont: { size: 10 }
                            }
                        },
                        scales: {
                            x: {
                                stacked: false,
                                categoryPercentage: 0.4,
                                barPercentage: 0.4,
                                ticks: {
                                    font: { size: 7 },
                                    maxRotation: 45,
                                    minRotation: 0
                                }
                            },
                            y: {
                                stacked: false,
                                beginAtZero: true,
                                ticks: {
                                    stepSize: 5,
                                    font: { size: 7 }
                                }
                            }
                        }
                    }
                });

            } catch (error) {

            }
        }
        
        function loadCharts(requestData, reportData) {
            // Initialize charts if they don't exist yet
            if (!chartInstances.chart1 || !chartInstances.chart2 || !chartInstances.chart3) {
                initializeCharts();
            }
            
            // Load chart data from API - use same endpoints as main page
            var reportId = requestData.ReportID || 325;
            var parameters = requestData.Parameters || {};
            
            // Build parameters object
            var chartParameters = {};
            if (parameters.ProjectID) {
                chartParameters.ProjectID = parameters.ProjectID;
            }
            if (parameters.Period) {
                chartParameters.Period = parameters.Period;
            }
            if (parameters.ResourceID) {
                chartParameters.ResourceID = parameters.ResourceID;
            }
            
            // Load all 3 charts from API
            loadChart1FromAPI(reportId, chartParameters, reportData);
            loadChart2FromAPI(reportId, chartParameters);
            loadChart3FromAPI(reportId, chartParameters);
        }
        
        function loadChart1FromAPI(reportId, parameters, reportData) {
            // ProjectID is required
            if (!parameters.ProjectID || parameters.ProjectID === '' || parameters.ProjectID === '0') {
                return;
            }
            
            var requestData = {
                ReportID: 324,
                Parameters: Object.keys(parameters).length > 0 ? parameters : null
            };
            
            $.ajax({
                url: baseUrl + '/api/ReportUIBuilder/GetReportData',
                type: 'POST',
                headers: getAjaxHeaders(),
                data: JSON.stringify(requestData),
                success: function(response) {
                    
                    // Check if response has data property (wrapped by ResponseHelper)
                    if (response && response.data) {
                        chartData = response.data;
                    }
                    // Check if response itself has the chart data properties
                    else if (response && response.labels && response.totalTasks && response.completedTasks) {
                        chartData = response;
                    }
                    // 🔹 Build in-progress from grid data
                    // 🔹 Build maps
                    // 🔹 Build maps
                    var inProgressMap = buildInProgressMap(reportData);
                    var completedMap = buildInCompletedMap(chartData);

                    // 🔹 Priority labels from reportData
                    var priorityLabels = buildResourceListFromReportData(reportData);

                    // 🔑 FINAL RESOURCE MAP
                    var resourceMap = {};

                    // 🔹 Use ONLY labels from reportData
                    priorityLabels.forEach(function (key) {

                        resourceMap[key] = {
                            label: key,
                            completed: completedMap[key] || 0,
                            inProgress: inProgressMap[key] || 0
                        };
                    });

                    // 🔁 Convert map → arrays
                    var labels = [];
                    var completedTasks = [];
                    var inProgressTasks = [];

                    Object.keys(resourceMap).forEach(function (key) {
                        labels.push(resourceMap[key].label);
                        completedTasks.push(resourceMap[key].completed);
                        inProgressTasks.push(resourceMap[key].inProgress);
                    });

                    // 🔥 Update chart
                    updateChart1(
                        labels,
                        completedTasks,
                        inProgressTasks
                    );
                    calculateKPIs();
                },
                error: function(xhr, status, error) {

                    updateChart1([], [], []);
                }
            });
        }

        function buildResourceListFromReportData(reportData) {

            var map = {};
            var list = [];

            reportData.forEach(function (item) {

                var resource =
                    item.Resource ||
                    item.ResourceName ||
                    '';

                if (!resource) return;

                var key = resource.toString().trim();
                if (key === '' || key.toLowerCase() === 'unknown') return;

                // Preserve order, enforce uniqueness
                if (!map[key]) {
                    map[key] = true;
                    list.push(key);
                }
            });

            return list; // ordered + unique
        }

        function buildInProgressMap(reportData) {

            var inProgressMap = {};
            reportData.forEach(function (item) {

                var resourceName =
                    item.Resource ||
                    item.EmployeeName ||
                    '';

                if (!resourceName) return;

                var key = resourceName.toString().trim();
                if (key === '' || key.toLowerCase() === 'unknown') return;

                if (!inProgressMap[key]) {
                    inProgressMap[key] = 0;
                }
                inProgressMap[key]++;
            });

            return inProgressMap;
        }

        function buildInCompletedMap(reportData) {
            var completedMap = {};
            reportData.forEach(function (item) {

                var resourceName =
                    item.Resource ||
                    item.EmployeeName ||
                    '';

                if (!resourceName) return;

                var key = resourceName.toString().trim();
                if (key === '' || key.toLowerCase() === 'unknown') return;

                if (!completedMap[key]) {
                    completedMap[key] = 0;
                }
                completedMap[key]++;
            });

            return completedMap;
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
                                var total = parseInt(chartData.totalTasks[i]) || 0;
                                var overrun = parseInt(chartData.overrunTasks[i]) || 0;
                                filteredTotalTasks.push(total);
                                filteredOverrunTasks.push(overrun);

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
                                var total = parseInt(chartData.totalTasks[i]) || 0;
                                var variance = parseInt(chartData.scheduleVarianceTasks[i]) || 0;
                                filteredTotalTasks.push(total);
                                filteredScheduleVarianceTasks.push(variance);

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

        function updateChart1(labels, totalTasks, completedTasks) {
            // Show/hide "No data available" message
            var hasData = labels && labels.length > 0 && totalTasks && totalTasks.length > 0;
            var $noDataMsg = $('#chart1NoData');
            if ($noDataMsg.length) {
                $noDataMsg.toggle(hasData === false);
            }

            if (!chartInstances.chart1) {
                initializeChart1();
            }

            if (!chartInstances.chart1) {
                return;
            }

            // If no data, don't update chart
            if (!hasData) {
                return;
            }

            // Ensure arrays are the same length
            var maxLength = Math.max(labels.length, totalTasks.length, completedTasks.length);
            var safeLabels = labels.slice(0, maxLength);
            var safeTotalTasks = totalTasks.slice(0, maxLength);
            var safeCompletedTasks = completedTasks.slice(0, maxLength);

            // Pad arrays if needed
            while (safeLabels.length < maxLength) safeLabels.push('');
            while (safeTotalTasks.length < maxLength) safeTotalTasks.push(0);
            while (safeCompletedTasks.length < maxLength) safeCompletedTasks.push(0);

            // Sanitize data arrays
            safeTotalTasks = safeTotalTasks.map(function (v) {
                var num = parseInt(v);
                return (isNaN(num) || num === null || num === undefined) ? 0 : num;
            });
            safeCompletedTasks = safeCompletedTasks.map(function (v) {
                var num = parseInt(v);
                return (isNaN(num) || num === null || num === undefined) ? 0 : num;
            });
            safeLabels = safeLabels.map(function (v) {
                return (v === undefined || v === null) ? '' : String(v);
            });

            chartInstances.chart1.data.labels = safeLabels;

            // For stacked bar chart, dataset[0] should be "Remaining" (Total - Completed)
            var safeRemainingTasks = safeTotalTasks.map(function (total, index) {
                var totalVal = parseInt(total) || 0;
                var completedVal = parseInt(safeCompletedTasks[index]) || 0;
                return Math.max(0, totalVal - completedVal);
            });

            chartInstances.chart1.data.datasets[0].data = safeTotalTasks;
            chartInstances.chart1.data.datasets[1].data = safeCompletedTasks;
            chartInstances.chart1.data.datasets[0].label = 'Completed';
            chartInstances.chart1.data.datasets[1].label = 'InProgress';

            // Update max value for Y-axis
            var allValues = safeTotalTasks.map(function (v) { return parseInt(v) || 0; });
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

            chartInstances.chart1.options.scales.y.afterBuildTicks = function (scale) {
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
                chartInstances.chart1.options.scales.y.ticks.callback = function (value, index, values) {
                    if (value === undefined || value === null || isNaN(value)) {
                        return '';
                    }
                    return value.toString();
                };
            }

            chartInstances.chart1.update('none');
        }

        function updateChart2(labels, totalTasks, overrunTasks) {
            // Show/hide "No data available" message
            var hasData = labels && labels.length > 0 && totalTasks && totalTasks.length > 0;
            var $noDataMsg = $('#chart2NoData');
            if ($noDataMsg.length) {
                $noDataMsg.toggle(hasData === false);
            }

            if (!chartInstances.chart2) {
                initializeChart2();
            }

            if (!chartInstances.chart2) {
                return;
            }

            // If no data, don't update chart
            if (!hasData) {
                return;
            }

            // Ensure arrays are the same length
            var maxLength = Math.max(labels.length, totalTasks.length, overrunTasks.length);
            var safeLabels = labels.slice(0, maxLength);
            var safeTotalTasks = totalTasks.slice(0, maxLength).map(function (v) { return parseInt(v) || 0; });
            var safeOverrunTasks = overrunTasks.slice(0, maxLength).map(function (v) { return parseInt(v) || 0; });

            // Pad arrays if needed
            if (maxLength > 0) {
                while (safeLabels.length < maxLength) safeLabels.push('');
                while (safeTotalTasks.length < maxLength) safeTotalTasks.push(0);
                while (safeOverrunTasks.length < maxLength) safeOverrunTasks.push(0);
            }

            chartInstances.chart2.data.labels = safeLabels;
            chartInstances.chart2.data.datasets[0].data = safeTotalTasks;
            chartInstances.chart2.data.datasets[1].data = safeOverrunTasks;
            chartInstances.chart2.data.datasets[0].label = 'Total';
            chartInstances.chart2.data.datasets[1].label = 'Overrun';

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

            chartInstances.chart2.options.scales.y.afterBuildTicks = function (scale) {
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
            // Show/hide "No data available" message
            var hasData = labels && labels.length > 0 && totalTasks && totalTasks.length > 0;
            var $noDataMsg = $('#chart3NoData');
            if ($noDataMsg.length) {
                $noDataMsg.toggle(hasData === false);
            }

            if (!chartInstances.chart3) {
                initializeChart3();
            }

            if (!chartInstances.chart3) {
                return;
            }

            // If no data, don't update chart
            if (!hasData) {
                return;
            }

            // Ensure arrays are the same length
            var maxLength = Math.max(labels.length, totalTasks.length, scheduleVarianceTasks.length);
            var safeLabels = labels.slice(0, maxLength);
            var safeTotalTasks = totalTasks.slice(0, maxLength).map(function (v) { return parseInt(v) || 0; });
            var safeScheduleVarianceTasks = scheduleVarianceTasks.slice(0, maxLength).map(function (v) { return parseInt(v) || 0; });

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

            // Update chart data - both total tasks and schedule variance
            chartInstances.chart3.data.labels = safeLabels;
            chartInstances.chart3.data.datasets[0].data = safeTotalTasks;
            chartInstances.chart3.data.datasets[0].label = 'Total Tasks';
            chartInstances.chart3.data.datasets[0].backgroundColor = '#3b82f6';
            chartInstances.chart3.data.datasets[1].data = safeScheduleVarianceTasks;
            chartInstances.chart3.data.datasets[1].label = 'Schedule Variance';
            chartInstances.chart3.data.datasets[1].backgroundColor = '#f97316';

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

            chartInstances.chart3.options.scales.y.afterBuildTicks = function (scale) {
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
            var resourceID = $('#cboResource').val();

            if (!projectID || projectID === '' || projectID === '0') {
                alertify.error(Resources.A_ProjectShouldNotBeBlank || 'Please select a project');
                return;
            }
            
            // Build request data - API expects parameters nested in Parameters property
            var requestData = {
                ReportID: 325,
                Format: format,
                Parameters: {
                    ProjectID: parseInt(projectID)
                }
            };
            
            if (period && period !== '') {
                requestData.Parameters.Period = parseInt(period);
            }
            
            if (resourceID && resourceID !== '' && resourceID !== '0') {
                requestData.Parameters.ResourceID = parseInt(resourceID);
            }
            
            
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
                var fileName = 'TasksInProgress_' + format + '_' + new Date().getTime() + '.' + fileExtension;
                
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
