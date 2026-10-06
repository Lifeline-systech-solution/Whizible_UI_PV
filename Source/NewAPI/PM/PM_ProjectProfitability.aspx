<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectProfitability.aspx.vb"
    Inherits="Whizible.PM_ProjectProfitability" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("Project Profitability")%>

<head runat="server">
    <%--<meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
    <title>Project Profitability</title>
    <!-- Tell the browser to be responsive to screen width -->
    <%--<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
                <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
                <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">--%>
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css"> -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">--%>
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">

    <style>  
        .pageHeading {
            color: #1e40af;
            font-weight: 600;
            font-size: 16px; /* Modified By Madhuri.K On 26-03-2026 */
            margin: 0 0 0.25rem 0;
            display: flex;
            align-items: center;
        }
    
        .page-wrapper {
            max-width: 1280px;
            margin: 20px auto;
        }
    
        .profitImg {
            width: 30px;
            height: 30px;
            color: #1e40af;
        }
    
        /* header row - 90-degree (sharp) corners, no rounded border */
        .project-header {
        /* Commented By Madhuri.K on 09-03-2026 - As per new design, removing background color from header */
            /* background: #ffffff; */        
            border-radius: 0;
            padding: 10px 15px 2px;
            margin-bottom: 0;
        }
    
        .project-header .small {
            font-size: 11px;
        }
    
        .project-header .page-subtitle {
            font-size: 11px;
            margin: 4px 0 0 0;
            color: #6B7280;
            line-height: 1.35;
        }
    
        .dropDownLabel {
            color: #1e40af;
            font-size: 11.5px;
            font-weight: 400;
            margin: 0;
        }
    
        .AllTabsDiv {
            border-radius: 10px;
        }
    
        .AllTabsDiv .TabDivContent {
            padding: 10px 20px;
        }
    
        /* Accordion - Project Details */
        .proj-accordion .accordion-item {
            border-radius: 8px;
            border: 1px solid #e0e3ee;
            background: #ffffff;
        }
    
        .accordion-button {
            background-color: #fff !important;
        }
    
        .proj-accordion .accordion-button {
            background: #f7f9fc !important;
            font-weight: 600;
            font-size: 14px;
            padding-top: 8px;
            padding-bottom: 8px;
        }
    
        .proj-accordion .accordion-button:not(.collapsed) {
            color: #0664e0 !important;
            box-shadow: none;
        }
    
        .proj-accordion .accordion-body {
            background: #f9fafc;
        }
    
        .accordion-item .accordion-button {
            border-top: none;
        }
    
        .detail-item span.label {
            display: block;
            color: #777;
            margin-bottom: 2px;
        }
    
        .detail-item span.value {
            font-weight: 500;
            color: #333;
        }
    
        /* Highlight Cost Method */
        .highlight-cost-method {
            background: #eef2ff;
            padding: 8px 10px;
            border-radius: 6px;
            font-size: 11.5px;
        }
    
        .highlight-cost-method .label {
            font-weight: 600;
            color: #215cc7 !important;
        }
    
        .highlight-cost-method .value {
            font-weight: 600;
            color: #0f172a;
        }
    
        /* Profitability card */
        .profitability-card {
            margin-top: 16px;
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e0e3ee;
            padding: 18px 20px 20px;
        }
    
        .profitability-card .card-header {
            font-size: 14px;
            font-weight: 500;
            border-bottom: none;
            background: transparent;
        }
    
        .nested_tabs .nav-link {
            font-size: 12px;
            font-weight: 500;
        }
    
        .nested_tabs .nav-tabs .nav-link.active {
            border-bottom: 1px solid #0f62fe !important;
            color: #0664e0 !important;
        }
    
        .nav>li>a:hover,
        .nav>li>a:active,
        .nav>li>a:focus {
            background: transparent;
            transition: 0.4s ease-in-out 0s;
        }
    
        /* profitability table – NEW UI */
        .profitability-table-wrapper {
            border-radius: 10px;
            border: 1px solid #e0e3ee;
            background: #ffffff;
            margin-top: 8px;
            scrollbar-width: thin;
            scrollbar-color: #c7c7c7 #f1f1f1;
        }

        .TrendTable-wrapper:hover {
            scrollbar-width: thin;
            scrollbar-color: #c7c7c7 #f1f1f1;
        }
    
        /* Chrome, Edge, Safari */
        .profitability-table-wrapper::-webkit-scrollbar,
        .TrendTable-wrapper::-webkit-scrollbar {
            height: 6px;
            width: 6px;
        }
    
        .profitability-table-wrapper::-webkit-scrollbar-track,
        .TrendTable-wrapper::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
    
        .profitability-table-wrapper::-webkit-scrollbar-thumb,
        .TrendTable-wrapper::-webkit-scrollbar-thumb {
            background: #c7c7c7;
            border-radius: 10px;
        }
    
        .profitability-table-wrapper::-webkit-scrollbar-thumb:hover,
        .TrendTable-wrapper::-webkit-scrollbar-thumb:hover {
            background: #a0a0a0;
        }
    
        /* Header cells: allow wrapping so long labels fit */
        .profitabilitytbl thead th {
            font-size: 12px;
            padding: 6px 8px;
            border-color: #e4e7f0;
            vertical-align: middle;
            white-space: normal;
            word-break: break-word;
        }
    
        /* Body/footer cells: keep numbers on a single line */
        .profitabilitytbl tbody td,
        .profitabilitytbl tfoot td {
            font-size: 12px;
            padding: 6px 8px;
            border-color: #e4e7f0;
            vertical-align: middle;
            white-space: nowrap;
        }
    
        .profitabilitytbl thead tr:first-child th {
            text-align: center;
            font-size: 12px;
            font-weight: 600;
        }
    
        .profitabilitytbl thead tr:nth-child(2) th {
            font-size: 11px;
            font-weight: 500;
        }
    
        /* Top grouped headers */
        .profitabilitytbl thead tr:first-child th:first-child {
            background: #f5f7fb;
        }
    
        .profitabilitytbl thead tr:first-child th:nth-child(2) {
            background: #edf4ff;
        }
    
        .profitabilitytbl thead tr:first-child th:nth-child(3) {
            background: #fff5e6;
        }
    
        .profitabilitytbl thead tr:first-child th:nth-child(4) {
            background: #e8f8ef;
        }
    
        /* Column bands: Generated Date */
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(1),
        .profitabilitytbl tbody td:nth-child(1),
        .profitabilitytbl tfoot td:nth-child(1) {
            background: #f7f9fc;
        }
    
        /* Revenue band (cols 2-4) */
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(2),
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(3),
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(4),
        .profitabilitytbl tbody td:nth-child(2),
        .profitabilitytbl tbody td:nth-child(3),
        .profitabilitytbl tbody td:nth-child(4),
        .profitabilitytbl tfoot td:nth-child(2),
        .profitabilitytbl tfoot td:nth-child(3),
        .profitabilitytbl tfoot td:nth-child(4) {
            background: #f3f7ff;
        }
    
        /* Cost band (cols 5-7) */
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(5),
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(6),
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(7),
        .profitabilitytbl tbody td:nth-child(5),
        .profitabilitytbl tbody td:nth-child(6),
        .profitabilitytbl tbody td:nth-child(7),
        .profitabilitytbl tfoot td:nth-child(5),
        .profitabilitytbl tfoot td:nth-child(6),
        .profitabilitytbl tfoot td:nth-child(7) {
            background: #fff7eb;
        }
    
        /* GPM band (cols 8-10) */
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(8),
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(9),
        .profitabilitytbl thead tr:nth-child(2) th:nth-child(10),
        .profitabilitytbl tbody td:nth-child(8),
        .profitabilitytbl tbody td:nth-child(9),
        .profitabilitytbl tbody td:nth-child(10),
        .profitabilitytbl tfoot td:nth-child(8),
        .profitabilitytbl tfoot td:nth-child(9),
        .profitabilitytbl tfoot td:nth-child(10) {
            background: #ecf9f1;
        }
    
        /* zebra hover only (bands already give background) */
        .profitabilitytbl tbody tr:hover td {
            background-color: #e6f5ff;
        }
    
        /* Grand total darker row */
        .profitabilitytbl tfoot tr td {
            font-weight: 600;
            text-align: center;
        }
    
        .profitabilitytbl tfoot tr td:nth-child(1) {
            background: #e2e7f4;
        }
    
        .profitabilitytbl tfoot tr td:nth-child(2),
        .profitabilitytbl tfoot tr td:nth-child(3),
        .profitabilitytbl tfoot tr td:nth-child(4) {
            background: #dfe8ff;
        }
    
        .profitabilitytbl tfoot tr td:nth-child(5),
        .profitabilitytbl tfoot tr td:nth-child(6),
        .profitabilitytbl tfoot tr td:nth-child(7) {
            background: #ffe8c7;
        }
    
        .profitabilitytbl tfoot tr td:nth-child(8),
        .profitabilitytbl tfoot tr td:nth-child(9),
        .profitabilitytbl tfoot tr td:nth-child(10) {
            background: #d9f2e3;
        }
    
        /* ===== Detailed View table styling ===== */
        .profitabilitytbl-detailed thead tr:first-child th {
            text-align: center;
            font-size: 12px;
            font-weight: 600;
        }
    
        /* band header backgrounds */
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(1) {
            background: #f5f7fb;
            /* Reporting Date */
        }
    
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(2),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(3) {
            background: #edf4ff;
            /* Actual Hours */
        }
    
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(4),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(5) {
            background: #fff5e6;
            /* People Costs */
        }
    
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(6),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(7) {
            background: #edf4ff;
            /* Expenses & Direct Project Cost */
        }
    
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(8),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(9) {
            background: #edf4ff;
            /* Accrued People Revenue */
        }
    
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(10),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(11) {
            background: #fff5e6;
            /* Accrued Billable Expenses */
        }
    
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(12),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(13),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(14),
        .profitabilitytbl-detailed thead tr:first-child th:nth-child(15) {
            background: #ecf9f1;
            /* Accrued GPM + Invoiced Revenue */
        }
    
        /* second header row (Periodic / Cumulative) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th {
            font-size: 11px;
            font-weight: 500;
        }
    
        /* Column background bands – body + footer */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(1),
        .profitabilitytbl-detailed tbody td:nth-child(1),
        .profitabilitytbl-detailed tfoot td:nth-child(1) {
            background: #f7f9fc;
            /* Reporting Date */
        }
    
        /* Actual Hours band (2–3) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(2),
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(3),
        .profitabilitytbl-detailed tbody td:nth-child(2),
        .profitabilitytbl-detailed tbody td:nth-child(3),
        .profitabilitytbl-detailed tfoot td:nth-child(2),
        .profitabilitytbl-detailed tfoot td:nth-child(3) {
            background: #f3f7ff;
        }
    
        /* People Costs band (4–5) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(4),
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(5),
        .profitabilitytbl-detailed tbody td:nth-child(4),
        .profitabilitytbl-detailed tbody td:nth-child(5),
        .profitabilitytbl-detailed tfoot td:nth-child(4),
        .profitabilitytbl-detailed tfoot td:nth-child(5) {
            background: #fff7eb !important;
        }
    
        /* Expenses & Direct Project Cost band (6–7) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(6),
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(7),
        .profitabilitytbl-detailed tbody td:nth-child(6),
        .profitabilitytbl-detailed tbody td:nth-child(7),
        .profitabilitytbl-detailed tfoot td:nth-child(6),
        .profitabilitytbl-detailed tfoot td:nth-child(7) {
            background: #f3f7ff !important;
        }
    
        /* Accrued People Revenue band (8–9) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(8),
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(9),
        .profitabilitytbl-detailed tbody td:nth-child(8),
        .profitabilitytbl-detailed tbody td:nth-child(9),
        .profitabilitytbl-detailed tfoot td:nth-child(8),
        .profitabilitytbl-detailed tfoot td:nth-child(9) {
            background: #f3f7ff !important;
        }
    
        /* Accrued Billable Expenses band (10–11) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(10),
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(11),
        .profitabilitytbl-detailed tbody td:nth-child(10),
        .profitabilitytbl-detailed tbody td:nth-child(11),
        .profitabilitytbl-detailed tfoot td:nth-child(10),
        .profitabilitytbl-detailed tfoot td:nth-child(11) {
            background: #fff7eb !important;
        }
    
        /* Accrued GPM band (12–13) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(12),
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(13),
        .profitabilitytbl-detailed tbody td:nth-child(12),
        .profitabilitytbl-detailed tbody td:nth-child(13),
        .profitabilitytbl-detailed tfoot td:nth-child(12),
        .profitabilitytbl-detailed tfoot td:nth-child(13) {
            background: #ecf9f1 !important;
        }
    
        /* Invoiced Revenue band (14–15) */
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(14),
        .profitabilitytbl-detailed thead tr:nth-child(2) th:nth-child(15),
        .profitabilitytbl-detailed tbody td:nth-child(14),
        .profitabilitytbl-detailed tbody td:nth-child(15),
        .profitabilitytbl-detailed tfoot td:nth-child(14),
        .profitabilitytbl-detailed tfoot td:nth-child(15) {
            background: #ecf9f1 !important;
        }
    
        /* Grand total row – slightly darker */
        .profitabilitytbl-detailed tfoot tr td {
            font-weight: 600;
        }
    
        .textRed {
            color: #d93025 !important;
        }
    
        @media (max-width: 1024px) {
            .profitability-table-wrapper:hover {
                overflow-x: scroll;
                scrollbar-width: thin;
                scrollbar-color: #c7c7c7 #f1f1f1;
            }
        }
    
        .FilterDropdown.bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
            width: 200px;
        }
    
        /* ===== Revenue, Cost & GPM Trend toggle ===== */
        .rcg-toggle {
            display: inline-flex;
            align-items: center;
            background: #f3f4f6;
            border-radius: 999px;
            padding: 2px;
        }
    
        .rcg-toggle-btn {
            border: none;
            background: transparent;
            padding: 4px 14px;
            font-size: 12px;
            line-height: 1.4;
            border-radius: 999px;
            color: #6b7280;
            cursor: pointer;
        }
    
        .rcg-toggle-btn:focus {
            outline: none;
            box-shadow: none;
        }
    
        .rcg-toggle-btn.active {
            background: #ffffff;
            color: #111827;
            box-shadow: 0 0 0 1px rgba(148, 163, 184, 0.5);
        }
        /* Profitability Trends CSS start here */

        /* ===== Profitability Trends / GPM Trend ===== */
        .gpm-card-title {
            font-size: 14px;
            font-weight: 500;
        }
    
        .gpm-btn-group .btn {
            font-size: 12px !important;
            padding: 3px 10px;
            border-radius: 5px;
            border: 1px solid #dae0e7;
            color: #1f2933;
            margin: 0 2px;
        }
    
        .gpm-btn-group .btn.active {
            background: #dcefff;
            color: #1e40af;
            border-color: #ffffff;
        }
    
        .chart-card-body canvas {
            width: 100% !important;
            height: 100% !important;
        }
    
        .gpm-card-header {
            padding: 12px 18px;
            font-weight: 500;
            font-size: 14px;
            border-bottom: 1px solid #eef1f7;
            color: #111827;
        }
    
        .gpm-card-body {
            padding: 4px 18px 10px;
        }
    
        .gpm-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 9px 0;
            border-bottom: 1px solid #f2f4fa;
            font-size: 11.5px;
        }
    
        .gpm-row:last-child {
            border-bottom: none;
        }
    
        .gpm-label {
            color: #4b5563;
        }
    
        .gpm-value {
            color: #111827;
        }
    
        .gpm-row.total {
            background: #f9fafc;
            font-weight: 600;
        }
    
        .gpm-row.total .gpm-value {
            color: #1e40af;
        }
    
        .gpm-summary-card {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e0e3ee;
            padding: 18px 18px 14px;
            text-align: center;
            margin-top: 4px;
        }
    
        .gpm-summary-card p {
            margin: 0 0 4px;
            font-size: 12px;
            color: #6b7280;
        }
    
        .gpm-summary-card .gpm-equation {
            font-size: 11.5px;
            font-weight: 600;
            margin-bottom: 6px;
        }
    
        .gpm-summary-card .gpm-equation .textRed {
            font-weight: 600;
        }
    
        .gpm-summary-card .gpm-percent {
            font-size: 12px;
            color: #4b5563;
            font-weight: 500;
        }
        /* Gross Profit Margin CSS end here */
    
        /* Revenue Card CSS start here */
        .card-section {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e0e3ee;
            padding: 18px 20px 20px;
            margin-top: 16px;
        }
    
        .card-section .card-header {
            font-size: 14px;
            font-weight: 500;
            padding: 0 0 10px 0;
            margin-bottom: 6px;
            border-bottom: none;
            background: transparent;
        }
    
        .TrendTable th,
        .TrendTable td {
            font-size: 11.5px; 
            /* Modified By Madhuri.K On 26-03-2026 */
            padding: 9px 12px;
            border-color: #e4e7f0;
            vertical-align: middle;
            white-space: nowrap;
        }
    
        .TrendTable thead th {
            background: #f5f7fb;
            font-weight: 600;
        }
    
        .TrendTable tbody tr:hover td {
            background: #f1f5ff;
        }
        /* Revenue Card CSS end here */
    
        /* Profitability SnapShot CSS start here */
        .snapshot-note {
            background: #fff8e6;
            border: 1px solid #facc6b;
            border-radius: 8px;
            padding: 12px 14px 10px;
            font-size: 12px;
            color: #374151;
            margin-bottom: 16px;
        }

        /* icon next to status text/link */
        .status-pill .status-icon {
            font-size: 12px;
        }
    
        .status-pending {
            color: #ED6C02;
        }
    
        .status-generate {
            color: #28A745;
        }
    
        .status-regenerate {
            color: #007BFF;
        }
        /* Profitability SnapShot CSS end here */
    
        /* Graph CSS start here */
        /* ===== Charts UI ===== */
        .chart-card {
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e0e3ee;
            padding: 16px 18px 18px;
        }
    
        .chart-card-header {
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 8px;
        }
    
        .chart-card-body {
            height: 280px;
        }
    
        .chart-card canvas {
            width: 100% !important;
            height: 100% !important;
        }
        /* Graph CSS end here */
    
        /* header */
        .view-report-offcanvas .offcanvas-header {
            background: #ffffff;
            box-shadow: 0 1px 0 #e5e7eb;
        }
    
        /* report title card */
        .vrp-report-box {
            background: #ffffff;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
            padding: 12px 14px;
        }
    
        .vrp-report-title {
            font-size: 14px;
            font-weight: 500;
        }
    
        /* download icon */
        .vrp-download-btn {
            border: none;
            background: transparent;
            padding: 4px 6px;
            color: #4b5563;
        }
    
        .vrp-download-btn:hover {
            background: #f3f4f6;
            border-radius: 999px;
        }
    
        /* note card */
        .vrp-note-box {
            margin-top: 18px;
            background: #fff9e6;
            border-radius: 10px;
            border: 1px solid #facc6b;
            padding: 12px 14px;
            font-size: 11.5px;
            color: #4b5563;
            line-height: 1.4;
        }

        .vrp-note-box p{
            font-size: 12px !important;
        }
    
        .vrp-note-label {
            color: #2563eb;
            font-weight: 600;
            font-size: 12px;
        }
    
        /* View Report Offcanvas CSS end here */
    
        /* ===== Common detail offcanvas (Accrued Revenue / People Cost / Actual Hours) start ===== */
        .detail-offcanvas {
            background-color: #f9fafb;
        }
    
        .detail-offcanvas .offcanvas-header {
            background: #ffffff;
            box-shadow: 0 1px 0 #e5e7eb;
        }
    
        /* Period / Project card */
        .detail-meta-card {
            background: #ffffff;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            padding: 10px 12px;
            font-size: 11.5px;
        }
    
        /* Note card */
        .detail-note-card {
            background: #fff9e6;
            border-radius: 8px;
            border: 1px solid #facc6b;
            padding: 10px 12px;
            font-size: 11.5px;
            color: #4b5563;
        }
    
        .detail-note-icon {
            width: 20px;
            height: 20px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #b45309;
            font-size: 11px;
        }
    
        /* Table card + table */
        .detail-table-card {
            background: #ffffff;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            padding: 0;
        }
    
        .detail-table {
            font-size: 11.5px;
        }
    
        .detail-table thead th {
            background-color: #f3f4f6;
            font-weight: 600;
            border-color: #e5e7eb;
            white-space: normal;
            word-break: break-word;
            padding: 4px 4px;
        }
    
        .detail-table tbody td {
            border-color: #e5e7eb;
        }
    
        /* Thin scroll for tall tables */
        .detail-table-wrapper {
            scrollbar-width: thin;
            scrollbar-color: #c7c7c7 #f1f1f1;
        }
    
        .detail-table-wrapper::-webkit-scrollbar {
            width: 6px;
        }
    
        .detail-table-wrapper::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
    
        .detail-table-wrapper::-webkit-scrollbar-thumb {
            background: #c7c7c7;
            border-radius: 10px;
        }
    
        /* ===== Common detail offcanvas (Accrued Revenue / People Cost / Actual Hours) end ===== */
    
        /* ===== Common Table Header Backgrounds ===== */
        .table-fixed-header thead tr th,
        .table thead tr th {
            background: #f9f9fa;
        }
    
        .prof_Status {
            width: 90px;
            display: flex;
            justify-content: start;
        }
    
        .linkStatus {
            text-decoration: underline;
            font-size: 12px !important;
        }
    
        .linkAmount {
            text-decoration: none;
            font-size: 12px !important;
            color: #1359a6;
        }
    
        .NavTabsStyle,
        .NavTabsStyle:hover {
            border: none !important;
            color: #666 !important;
            padding: 6px 10px;
            font-weight: 500;
            border-bottom: 2px solid transparent;
        }
    
        .NavTabsStyle.active {
            border: none;
            color: #1359a6 !important;
            padding: 6px 10px;
            font-weight: 500;
            border-bottom: 1px solid #1359a6 !important;
            background: #f0f7ff !important;
        }
    
        .task-management-tabs .nav-link:hover {
            color: #1359a6 !important;
            background: #f0f7ff !important;
            border-bottom: 1px solid #1359a6 !important;
        }
    
        .no-data-row {
            font-size: 11.5px;
            padding-top: 8px;
            color: #4b5563;
            grid-column: 1 / -1;
        }
    
        .generate-link {
            color: #1e40af;
            font-size: 13px !important;
            font-weight: 500;
            cursor: pointer;
            text-decoration: underline;
        }
    
        .generate-link:hover, .generate-link:focus {
            color: #132b7c;
            text-decoration: underline !important;
        }
    
        .bootstrap-select .dropdown-menu {
            min-width: 178px;
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

<body class="hold-transition bgwhite sidebar-mini fixed">
   <div id="ProjProfSec" class="preloader"></div>

   <!-- Page Loader - Show immediately -->
   <div class="loader-overlay" id="loaderOverlay" style="display: none;">
       <div class="loader"></div>
   </div>

    <!--  Added By Gauri on 19/12/2025 for the Role Access -->
    <%If m_blnViewAccess = True Then%>
    <!--End of Added By Gauri on 19/12/2025 for the Role Access -->

    <!-- Main content wrapper is hidden until initial load completes -->
    <div class="page-wrapper" id="ProjProfWrapper" style="display:none;">
        <!-- TOP HEADER ROW -->

         <!-- Class graybg added By Madhuri.K on 09-03-2024 for the gray background to header section as per new UI -->

        <div class="graybg project-header d-flex flex-wrap align-items-center justify-content-between gap-2">
            <div>
                <h2 class="pageHeading">
<%--                    <img src="../../../assets/project-profitability-logo.png" class="profitImg me-2" alt="Project Profitability" />--%>
                         <img  src="../../../Whizible2.0-new/dist/img/profit-charts-rs.png" class="profitImg me-2" alt="Project Profitability" />

                   
                    <%=MyBase.GetResourceString("C_ProjProfTitle")%>
                </h2>
                <p class="page-subtitle"><%=MyBase.GetResourceString("C_PSubNote")%></p>

            </div>

            <!-- Project dropdown -->
            <div class="d-flex flex-wrap align-items-center gap-2">
                <div style="display: flex; align-items: center; gap: 0.5rem;">
                    <label class="dropDownLabel" for="cboProject"><%=MyBase.GetResourceString("C_SelProject")%></label>
                    <div style="min-width: 200px;">
                        <div class="bs-wrapper">
                            <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectOnChange();' class='selectpicker FilterDropdown' data-live-search='true'",,,) %>--%>
                            <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource_Profitibality " & Session("intUserID") & ", '" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectOnChange();' class='selectpicker FilterDropdown' data-live-search='true'",,,) %>
                        </div>
                    </div>
                </div>

                <!-- View Report button in header -->
                <button type="button" class="btn borderbtn btn-sm" data-bs-toggle="offcanvas"
                    data-bs-target="#viewReportOffcanvas" aria-controls="viewReportOffcanvas">
                    <%=MyBase.GetResourceString("C_VReport")%>
                </button>
            </div>
        </div>
        <div class="small text-muted text-end pe-3">(<%=MyBase.GetResourceString("C_CurrTxt")%>: <span id="currencySymbolHeader"></span>)</div>

        <!-- PROJECT DETAILS ACCORDION -->
        <div class="accordion proj-accordion px-3 mb-3" id="projectDetailsAccordion">
            <div class="accordion-item border-0">
                <h2 class="accordion-header" id="headingProjectDetails">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseProjectDetails" aria-expanded="true"
                        aria-controls="collapseProjectDetails">
                        <%=MyBase.GetResourceString("C_ProjDetls")%>
                    </button>
                </h2>
                <div id="collapseProjectDetails" class="accordion-collapse collapse show"
                    aria-labelledby="headingProjectDetails" data-bs-parent="#projectDetailsAccordion">
                    <div class="accordion-body">
                        <div class="row mb-3">
                            <div class="col-sm-9">
                                <div class="row gy-3">
                                    <div class="col-sm-4">
                                        <div class="detail-item">
                                            <span class="label"><%=MyBase.GetResourceString("C_ProjName")%>:</span>
                                            <span class="value" id="pdProjectName"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="detail-item">
                                            <span class="label"><%=MyBase.GetResourceString("C_ProjValue")%>:</span>
                                            <span class="value projValue" id="pdProjectValue"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="detail-item">
                                            <span class="label"><%=MyBase.GetResourceString("C_ComType")%>:</span>
                                            <span class="value" id="pdCommercialType"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="detail-item">
                                            <span class="label"><%=MyBase.GetResourceString("C_StDate")%>:</span>
                                            <span class="value" id="pdStartDate"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="detail-item">
                                            <span class="label"><%=MyBase.GetResourceString("C_EDate")%>:</span>
                                            <span class="value" id="pdEndDate"></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="detail-item">
                                            <span class="label"><%=MyBase.GetResourceString("C_Actual_StDate")%>:</span>
                                            <span class="value" id="pdActualStartDate"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3 highlight-cost-method">
                                <div class="row gy-2">
                                    <div class="detail-item">
                                        <span class="label"><%=MyBase.GetResourceString("C_CostMethod")%>:</span>
                                        <!-- <span class="value" id="pdCostMethod"></span> -->
                                        <% CommonFunctions.HTMLControls.DrawComboBox("pdCostMethod", "usp_Whizible2_Sel_CostMethod ",,, "' class='selectpicker' data-live-search='true' data-container='body' data-dropup-auto='false'",,,) %>
                                    </div>

                                    <div class="detail-item">
                                        <span class="label">Project Status:</span>
                                        <span class="value" id="pdProjectCurrStatus"></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-3">
                                <div class="detail-item">
                                    <span class="label">
                                        <%=MyBase.GetResourceString("C_Actual_EDate")%>:
                                    </span>
                                    <span class="value" id="pdActualEndDate"></span>
                                </div>
                            </div>
                            <div class="col-sm-3 DateRangeDiv">
                                <div class="detail-item">
                                    <span class="label">
                                        <!-- <%=MyBase.GetResourceString("C_RepFrom")%>: -->
                                        <%=MyBase.GetResourceString("C_DtRngFrom")%>:
                                    </span>
                                    <select id="ProjectProfitPeriodFrom" onchange='initReportingDates(true)'>
                                        <option value=""></option>
                                    </select>
                                    <!-- <% CommonFunctions.HTMLControls.DrawComboBox("ProjectProfitPeriodFrom", "usp_Whizible2_Sel_ProjectProfitability_Periods " & Session("intProjectID") & ", 'F'",,, "onchange ='initReportingDates(true);' class='selectpicker w-75' data-live-search='true' data-container='body' data-dropup-auto='false'",,,) %> -->
                                </div>
                            </div>
                            <div class="col-sm-3 DateRangeDiv">
                                <div class="detail-item">
                                    <span class="label">
                                        <!-- <%=MyBase.GetResourceString("C_RepTo")%>: -->
                                        <%=MyBase.GetResourceString("C_DtRngTo")%>:
                                    </span>
                                    <select id="ProjectProfitToPeriodTo" >
                                        <option value=""></option>
                                    </select>
                                    <!-- <% CommonFunctions.HTMLControls.DrawComboBox("ProjectProfitToPeriodTo", "usp_Whizible2_Sel_ProjectProfitability_Periods " & Session("intProjectID") & ", 'T'",,, "onchange ='initReportingDates(true);' class='selectpicker w-75' data-live-search='true' data-container='body' data-dropup-auto='false'",,,) %> -->
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="detail-item">
                                    <span class="label">
                                        <%=MyBase.GetResourceString("C_RepFreq")%>:
                                    </span>
                                    <!-- <span class="value" id="pdCostMethod"></span> -->
                                    <% CommonFunctions.HTMLControls.DrawComboBox("ReportingFrequencyID", "usp_Whizible2_Sel_ProjectProfitability_ReportFrequency ",,, "' class='selectpicker' data-live-search='true' data-container='body' data-dropup-auto='false'" ,,,)%>
                                </div>
                            </div>
                        </div>

                        <!-- FULL-WIDTH NO-DATA ROW (NOT inside grid) -->
                        <!-- Added by Gauri on 27 Jan 2026 to show Generate link based on role access -->
                        <% If m_blnAddAccess Or m_blnEditAccess Then %>
                        <div class="no-data-row project-details-nodata d-none" id="profitabilityNoData">
                            <%=MyBase.GetResourceString("C_GenerateMsg")%>
                            <a href="javascript:;" class="generate-link" id="profitabilityGenerateLink"></a>?
                        </div>
                        <% End If %>
                        <!-- End of Added by Gauri on 27 Jan 2026 to show Generate link based on role access -->
                    </div>
                </div>
            </div>
        </div>

        <!-- MAIN TABS -->
        <div class="AllTabsDiv">
            <div
                style="background: white; border-bottom: 1px solid #e0e0e0; padding: 0 15px; margin: 0 2px 5px 2px; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
                <ul class="nav nav-tabs task-management-tabs"
                    style="border-bottom: none; gap: 5px; margin-bottom: 0;">
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle active" href="javascript:;" data-bs-toggle="tab"
                            data-bs-target="#tabProjectProfitability" data-tab="projectProfitability">
                            <i class="fas fa-chart-line pe-1"></i><%=MyBase.GetResourceString("C_ProjProfTitle")%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle" href="javascript:;" data-bs-toggle="tab"
                            data-bs-target="#tabProfitabilityTrends" data-tab="profitTrends">
                            <i class="fas fa-chart-area pe-1"></i><%=MyBase.GetResourceString("C_ProfTrends")%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle" href="javascript:;" data-bs-toggle="tab"
                            data-bs-target="#tabGrossProfitMargin" data-tab="gpm">
                            <i class="fas fa-percent pe-1"></i><%=MyBase.GetResourceString("C_GPM")%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle" href="javascript:;" data-bs-toggle="tab"
                            data-bs-target="#tabRevenueTrend" data-tab="revenueTrend">
                            <i class="fas fa-chart-line pe-1"></i><%=MyBase.GetResourceString("C_RevTrends")%>
                        </a>
                    </li>
                    <!-- Modified by Gauri to change the sequence of tabs on 27 Jan 2025 -->
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle" href="javascript:;" data-bs-toggle="tab"
                            data-bs-target="#tabCostTrends" data-tab="costTrends">
                            <i class="fas fa-chart-bar pe-1"></i><%=MyBase.GetResourceString("C_CostTrends")%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle" href="javascript:;" data-bs-toggle="tab"
                            data-bs-target="#tabProfitabilitySnapshot" data-tab="profitabilitySnapshot">
                            <i class="fas fa-clipboard-list pe-1"></i><%=MyBase.GetResourceString("C_ProfSShot")%>
                        </a>
                    </li>
                    <!-- End of Modified by Gauri to change the sequence of tabs on 27 Jan 2025 -->
                </ul>
            </div>

            <div class="TabDivContent">
                <div class="tab-content">
                    <!-- PROJECT PROFITABILITY TAB -->
                    <div class="tab-pane fade show active" id="tabProjectProfitability">
                        <!-- PROFITABILITY CARD -->
                        <div class="profitability-card">
                            <div class="card-header"><%=MyBase.GetResourceString("C_ProfDetails")%></div>

                            <!-- NESTED TABS: Periodic / Detailed / Cumulative -->
                            <div class="nested_tabs">
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <button class="nav-link active mb-0" id="periodicViewTab"
                                            data-bs-toggle="tab" data-bs-target="#periodicView" type="button"
                                            onclick="setProfitabilityFlag(1)">
                                            <%=MyBase.GetResourceString("C_PrdicView")%>
                                        </button>
                                    </li>
                                    <li class="nav-item">
                                        <button class="nav-link mb-0" id="detailedViewTab" data-bs-toggle="tab"
                                            data-bs-target="#detailedView" type="button"
                                            onclick="setProfitabilityFlag(2)">
                                            <%=MyBase.GetResourceString("C_DetledView")%>
                                        </button>
                                    </li>
                                    <li class="nav-item">
                                        <button class="nav-link mb-0" id="cumulativeViewTab"
                                            data-bs-toggle="tab" data-bs-target="#cumulativeView" type="button"
                                            onclick="setProfitabilityFlag(3)">
                                            <%=MyBase.GetResourceString("C_CumulView")%>
                                        </button>
                                    </li>
                                </ul>
                            </div>

                            <div class="tab-content">
                                <!-- ===== PERIODIC VIEW – NEW STYLE TABLE ===== -->
                                <div class="tab-pane fade show active" id="periodicView" role="tabpanel"
                                    aria-labelledby="periodicViewTab">
                                    <!-- Charts Row -->
                                    <div class="row mt-3">
                                        <!-- Revenue, Cost & GPM Trend -->
                                        <div class="col-md-6 mb-3">
                                            <div class="chart-card">
                                                <div
                                                    class="chart-card-header d-flex justify-content-between align-items-center">
                                                    <span><%=MyBase.GetResourceString("C_RCG")%></span>
                                                    <div class="rcg-toggle" aria-label="Chart type">
                                                        <button type="button" class="rcg-toggle-btn active"
                                                            id="rcgLineBtn">
                                                            <%=MyBase.GetResourceString("C_Line")%>
                                                        </button>
                                                        <button type="button" class="rcg-toggle-btn"
                                                            id="rcgBarBtn">
                                                            <%=MyBase.GetResourceString("C_Bar")%>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="chart-card-body" style="height: 272px;">
                                                    <canvas id="RCG_lineGraph"></canvas>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Financial Performance by Period -->
                                        <div class="col-md-6 mb-3">
                                            <div class="chart-card">
                                                <div class="chart-card-header">
                                                    <%=MyBase.GetResourceString("C_FPPeriod")%>
                                                </div>
                                                <div class="chart-card-body">
                                                    <canvas id="financialPerformanceChart"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="table-responsive profitability-table-wrapper" style="max-height: 500px;">
                                        <table class="table table-bordered table-hover profitabilitytbl mb-0"
                                            id="ProjProfPeriodicTable">
                                            <thead class="stickyTblHeader">
                                                <!-- grouped band header -->
                                                <tr>
                                                    <th></th>
                                                    <th colspan="3" class="text-center"><%=MyBase.GetResourceString("C_RevA")%></th>
                                                    <th colspan="3" class="text-center"><%=MyBase.GetResourceString("C_CostB")%></th>
                                                    <th colspan="3" class="text-center"><%=MyBase.GetResourceString("C_GPM_AB")%></th>
                                                </tr>
                                                <tr>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_GenDate")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_AccPeopleRev")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_AccBillExp")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Total")%></th>

                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_PCosts")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ExpDirProjCost")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Total")%></th>

                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_AccGPM")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_InvRev")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ActHrs")%></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                <tr class="grandtotalrow" id="GrandTotalPeriodicView">
                                                </tr>
                                            </tfoot>
                                        </table>

                                        <div class="clearfix"></div>
                                    </div>
                                </div>

                                <!-- ===== DETAILED VIEW Tabs ===== -->
                                <div class="tab-pane fade" id="detailedView" role="tabpanel"
                                    aria-labelledby="detailedViewTab">
                                    <div class="table-responsive profitability-table-wrapper proftbl-detailed-wrapper mt-2" style="max-height: 500px;">
                                        <table style="word-break: normal;"
                                            class="table table-bordered table-hover profitabilitytbl profitabilitytbl-detailed mb-0"
                                            id="ProjProfDetailedTable">
                                            <thead class="stickyTblHeader">
                                                <!-- band header -->
                                                <tr>
                                                    <th></th>
                                                    <th colspan="2"><%=MyBase.GetResourceString("C_ActHrs")%></th>
                                                    <th colspan="2"><%=MyBase.GetResourceString("C_PCosts")%></th>
                                                    <th colspan="2"><%=MyBase.GetResourceString("C_ExpDirProjCost")%></th>
                                                    <th colspan="2"><%=MyBase.GetResourceString("C_AccPeopleRev")%></th>
                                                    <th colspan="2"><%=MyBase.GetResourceString("C_AccBillExp")%></th>
                                                    <th colspan="2"><%=MyBase.GetResourceString("C_AccGPM")%></th>
                                                    <th colspan="2"><%=MyBase.GetResourceString("C_InvRev")%></th>
                                                </tr>
                                                <!-- Periodic / Cumulative header -->
                                                <tr>
                                                    <th><%=MyBase.GetResourceString("C_RepDate")%></th>

                                                    <th><%=MyBase.GetResourceString("C_Periodic")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Cumulative")%></th>

                                                    <th><%=MyBase.GetResourceString("C_Periodic")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Cumulative")%></th>

                                                    <th><%=MyBase.GetResourceString("C_Periodic")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Cumulative")%></th>

                                                    <th><%=MyBase.GetResourceString("C_Periodic")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Cumulative")%></th>

                                                    <th><%=MyBase.GetResourceString("C_Periodic")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Cumulative")%></th>

                                                    <th><%=MyBase.GetResourceString("C_Periodic")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Cumulative")%></th>

                                                    <th><%=MyBase.GetResourceString("C_Periodic")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Cumulative")%></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                <tr class="grandtotalrow" id="GrandTotalDetailedView">
                                                </tr>
                                            </tfoot>
                                        </table>

                                        <div class="clearfix"></div>
                                    </div>
                                </div>

                                <!-- ===== CUMULATIVE VIEW Tabs ===== -->
                                <div class="tab-pane fade" id="cumulativeView" role="tabpanel" aria-labelledby="cumulativeViewTab">
                                    <div class="table-responsive profitability-table-wrapper mt-2" style="max-height: 500px;">
                                        <table class="table table-bordered table-hover profitabilitytbl mb-0"
                                            id="ProjProfCumulativeTable">
                                            <thead class="stickyTblHeader">
                                                <!-- grouped header (bands) -->
                                                <tr>
                                                    <th></th>
                                                    <th colspan="3" class="text-center"><%=MyBase.GetResourceString("C_RevA")%></th>
                                                    <th colspan="3" class="text-center"><%=MyBase.GetResourceString("C_CostB")%></th>
                                                    <th colspan="3" class="text-center"><%=MyBase.GetResourceString("C_GPM_AB")%></th>
                                                </tr>
                                                <!-- column header row -->
                                                <tr>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_GenDate")%></th>

                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_AccPeopleRev")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_AccBillExp")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Total")%></th>

                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_PCosts")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ExpDirProjCost")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_Total")%></th>

                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_AccGPM")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_InvRev")%></th>
                                                    <th class="col-sm-1"><%=MyBase.GetResourceString("C_ActHrs")%></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                <tr class="grandtotalrow" id="GrandTotalCumulView">
                                                </tr>
                                            </tfoot>
                                        </table>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /tab-pane -->

                    <!-- PROFITABILITY TRENDS TAB -->
                    <div class="tab-pane fade" id="tabProfitabilityTrends">
                        <!-- GPM Trend card -->
                        <div class="card-section">
                            <div class="gpm-card-header-row d-flex justify-content-between align-items-center pe-3">
                                <div class="gpm-card-title"><%=MyBase.GetResourceString("C_GPMTrend")%></div>

                                <div class="gpm-btn-group GPM_TrendTabs" role="group">
                                    <button type="button" class="btn active" data-graph="1" id="gpmLineBtn">
                                        <%=MyBase.GetResourceString("C_LGraph")%>
                                    </button>
                                    <button type="button" class="btn" data-graph="2" id="gpmColumnBtn">
                                        <%=MyBase.GetResourceString("C_CGraph")%>
                                    </button>
                                    <button type="button" class="btn" data-graph="3" id="gpmPointBtn">
                                        <%=MyBase.GetResourceString("C_PGraph")%>
                                    </button>
                                </div>
                            </div>

                            <div class="chart-card-body">
                                <!-- <canvas id="gpmTrendChart"></canvas> -->
                                <div id="gpmTrendChartWrap" style="height: 320px;">
                                    <canvas id="gpmTrendChart"></canvas>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- GROSS PROFIT MARGIN TAB -->
                    <div class="tab-pane fade" id="tabGrossProfitMargin">
                        <!-- GPM content cards -->
                        <div class="gpm-section mt-3">

                            <!-- Accrued Revenue -->
                            <div class="card-section">
                                <div class="gpm-card-header"><%=MyBase.GetResourceString("C_AccRev")%></div>
                                <div class="gpm-card-body">
                                    <div class="gpm-row">
                                        <div class="gpm-label"><%=MyBase.GetResourceString("C_PeopleRev")%></div>
                                        <!-- <div class="gpm-value" id="gpmPeopleRevenue">₹ 0.00</div> -->
                                        <div class="gpm-value" id="gpmPeopleRevenue"></div>
                                    </div>
                                    <div class="gpm-row">
                                        <div class="gpm-label"><%=MyBase.GetResourceString("C_AccBillExp")%></div>
                                        <!-- <div class="gpm-value" id="gpmBillableExpenses">₹ 0.00</div> -->
                                        <div class="gpm-value" id="gpmBillableExpenses"></div>
                                    </div>
                                    <div class="gpm-row total">
                                        <div class="gpm-label"><%=MyBase.GetResourceString("C_TotalRev")%></div>
                                        <!-- <div class="gpm-value" id="gpmTotalRevenue">₹ 0.00</div> -->
                                        <div class="gpm-value" id="gpmTotalRevenue"></div>
                                    </div>
                                </div>
                            </div>

                            <!-- Accrued Cost -->
                            <div class="card-section">
                                <div class="gpm-card-header"><%=MyBase.GetResourceString("C_AccCost")%></div>
                                <div class="gpm-card-body">
                                    <div class="gpm-row">
                                        <div class="gpm-label"><%=MyBase.GetResourceString("C_PCost")%></div>
                                        <!-- <div class="gpm-value" id="gpmPeopleCost">₹ 0.00</div> -->
                                        <div class="gpm-value" id="gpmPeopleCost"></div>
                                    </div>
                                    <div class="gpm-row">
                                        <div class="gpm-label"><%=MyBase.GetResourceString("C_TelExp")%></div>
                                        <!-- <div class="gpm-value" id="gpmTelephoneExpense">₹ 0.00</div> -->
                                        <div class="gpm-value" id="gpmTelephoneExpense"></div>
                                    </div>
                                    <div class="gpm-row total">
                                        <div class="gpm-label"><%=MyBase.GetResourceString("C_TCost")%></div>
                                        <!-- <div class="gpm-value" id="gpmTotalCost">₹ 0.00</div> -->
                                        <div class="gpm-value" id="gpmTotalCost"></div>
                                    </div>
                                </div>
                            </div>

                            <!-- Summary / Formula -->
                            <div class="gpm-summary-card">
                                <p><%=MyBase.GetResourceString("C_GPM")%> (<%=MyBase.GetResourceString("C_as_on")%>as on : <span id="GPMAsOnDate"></span>) = <%=MyBase.GetResourceString("C_TotalRev")%> - <%=MyBase.GetResourceString("C_TCost")%></p>
                                <!-- <div class="gpm-equation">
                                            Gross Profit Margin = &#8377; 8,67,900.00 – &#8377; 1,077,566.00 =
                                            <span class="textRed">(&#8377; -209,666.00)</span>
                                        </div> -->
                                <div class="gpm-equation" id="gpmEquation"></div>
                                <div class="gpm-percent">
                                    <%=MyBase.GetResourceString("C_GPM")%> % = <strong id="gpmPercent">0.00</strong>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- REVENUE TREND TAB -->
                    <div class="tab-pane fade" id="tabRevenueTrend">
                        <!-- Revenue Trend card -->
                        <div class="card-section">
                            <div class="card-header"><%=MyBase.GetResourceString("C_RevTrends")%></div>

                            <div class="table-responsive TrendTable-wrapper" style="max-height: 500px;">
                                <table class="table table-bordered table-hover TrendTable mb-0"
                                    id="RevenueTrendTable">
                                    <thead class="stickyTblHeader">
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_AsOn")%></th>
                                            <th><%=MyBase.GetResourceString("C_AccRev")%></th>
                                            <th><%=MyBase.GetResourceString("C_InvRev")%></th>
                                            <th><%=MyBase.GetResourceString("C_UnbillRev")%></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- PROFITABILITY SNAPSHOT TAB -->
                    <div class="tab-pane fade" id="tabProfitabilitySnapshot">

                        <!-- Note box -->
                        <div class="snapshot-note">
                            <div class="snapshot-note-header d-flex-align-items-center font-weight-600 mb-1">
                                <i class="fa fa-exclamation-triangle me-1" style="color: #f59e0b;"></i>
                                <span><%=MyBase.GetResourceString("C_Note")%> :</span>
                            </div>
                            <p>
                                <%=MyBase.GetResourceString("C_Note1")%>
                            </p>
                            <ul class="ps-3">
                                <li>
                                    <b><%=MyBase.GetResourceString("C_Cost")%> :</b> <%=MyBase.GetResourceString("C_Note2")%>
                                            <br />
                                    <small><%=MyBase.GetResourceString("C_CNoteA")%></small>
                                </li>
                                <li>
                                    <b><%=MyBase.GetResourceString("C_Rev")%> :</b> 
                                    <%=MyBase.GetResourceString("C_RevNote1")%>
                                        <br />
                                    <small><%=MyBase.GetResourceString("C_RevNote2")%></small>
                                </li>
                            </ul>
                            <p>
                                <b><%=MyBase.GetResourceString("C_ComType")%> :</b> <%=MyBase.GetResourceString("C_ComNote")%>
                            </p>
                        </div>

                        <!-- Snapshots table card -->
                        <div class="card-section">
                            <div class="card-header"><%=MyBase.GetResourceString("C_ProfSShot")%></div>
                            <div class="table-responsive TrendTable-wrapper" style="max-height: 500px;">
                                <table class="table table-bordered table-hover TrendTable mb-0"
                                    id="ProfitabilitySnapshotsTable">
                                    <thead class="stickyTblHeader">
                                        <tr>
                                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_FDate")%></th>
                                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_ToDate")%></th>
                                            <th class="col-sm-3">Generated Date</th>
                                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_Status")%></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- COST TRENDS TAB -->
                    <div class="tab-pane fade" id="tabCostTrends">
                        <!-- Cost Trends card -->
                        <div class="card-section">
                            <div class="card-header"><%=MyBase.GetResourceString("C_CostTrends")%></div>
                            <!-- <div class="card-header-row">
                            </div> -->

                            <div class="table-responsive TrendTable-wrapper" style="max-height: 500px;">
                                <table class="table table-bordered table-hover TrendTable mb-0"
                                    id="CostTrendsTable">
                                    <thead class="stickyTblHeader">
                                        <tr>
                                            <th><%=MyBase.GetResourceString("C_AsOn")%></th>
                                            <th><%=MyBase.GetResourceString("C_ResCost")%></th>
                                            <th><%=MyBase.GetResourceString("C_TravlAllow")%></th>
                                            <th><%=MyBase.GetResourceString("C_TCost")%></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /tab-content -->
            </div>
        </div>

        <!-- View Report Offcanvas start -->
        <div class="offcanvas offcanvas-end view-report-offcanvas" tabindex="-1" id="viewReportOffcanvas"
            aria-labelledby="viewReportOffcanvasLabel">

            <div class="graybg border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_VReport")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4">
                <!-- Report Name + Download -->
                <div class="vrp-report-box d-flex align-items-center justify-content-between mb-4">
                    <div class="flex-grow-1">
                        <span class="vrp-report-title"><%=MyBase.GetResourceString("C_ProjProfReport")%></span>
                    </div>

                    <!-- Download Dropdown -->
                    <div class="dropdown vrp-download-dropdown ms-2">
                        <button class="btn vrp-download-btn dropdown-toggle p-1" type="button"
                            id="downloadDropdownBtn" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-download"></i>
                        </button>

                        <ul class="dropdown-menu shadow-sm vrp-download-menu"
                            aria-labelledby="downloadDropdownBtn">
                            <li>
                                <a class="dropdown-item" href="#" onclick="exportProfitabilityReport('PDF');">
                                    <img src="../../../Whizible2.0-new/dist/img/pdf.svg" class="vrp-dd-icon" width="18" />
                                        <%=MyBase.GetResourceString("C_PDF")%>
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="#" onclick="exportProfitabilityReport('EXCEL');">
                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" class="vrp-dd-icon" width="18" />
                                    <%=MyBase.GetResourceString("C_Excel")%>
                                </a>
                            </li>    
                        </ul>
                    </div>
                </div>

                <!-- Note box -->
                <div class="vrp-note-box">
                    <p class="mb-0">
                        <span class="vrp-note-label"><%=MyBase.GetResourceString("C_Note")%> :</span>
                        <%=MyBase.GetResourceString("C_RepNote")%>
                    </p>
                </div>
            </div>
        </div>
        <!-- View Report Offcanvas End -->

        <!-- Accrued Revenue Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasAccruedRevenue"
            aria-labelledby="offcanvasAccruedRevenueLabel">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_AccRev")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <!-- <span id="AccruedStartDate">31 Jul 2013 </span> to <span id="AccruedEndDate">28-Feb-2023</span> -->
                            <span id="AccruedStartDate"> </span> <%=MyBase.GetResourceString("C_To")%> <span id="AccruedEndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>

                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <!-- <span class="font-weight-500 ms-1 CurrentProjectName">Tata Consultancy Services</span> -->
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div class="d-flex align-items-center">
                            <span class="detail-note-icon me-1">
                                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                            </span>
                            <span class="fw-semibold"><%=MyBase.GetResourceString("C_Note")%> :</span>
                        </div>
                        <!-- <i class="fa fa-chevron-up text-muted small" aria-hidden="true"></i> -->
                    </div>
                    <ul class="mb-0 ps-3">
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_ActHrs")%> :</strong>
                            <%=MyBase.GetResourceString("C_ActHrNote")%>
                        </li>
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_Rate")%> :</strong>
                            <%=MyBase.GetResourceString("C_RateNote")%> 
                        </li>
                        <li>
                            <strong><%=MyBase.GetResourceString("C_AccRev")%> :</strong>
                            <%=MyBase.GetResourceString("C_AccRevNote")%> 
                        </li>
                    </ul>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="AccruedRevenueTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_Res")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_AccRev")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <!-- Accrued Revenue Offcanvas End -->

        <!-- People Costs Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasPeopleCost"
            aria-labelledby="offcanvasPeopleCostLabel">

            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_PCosts")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <span id="PCostStartDate"></span> <%=MyBase.GetResourceString("C_To")%> <span id="PCostEndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>
                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div class="d-flex align-items-center">
                            <span class="detail-note-icon me-1">
                                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                            </span>
                            <span class="fw-semibold"><%=MyBase.GetResourceString("C_Note")%> :</span>
                        </div>
                        <!-- <i class="fa fa-chevron-up text-muted small" aria-hidden="true"></i> -->
                    </div>
                    <ul class="mb-0 ps-3">
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_ActHrs")%> :</strong>
                            <%=MyBase.GetResourceString("C_ActHrsNote")%> 
                        </li>
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_Rate")%> :</strong>
                            <%=MyBase.GetResourceString("C_RateNote1")%> 
                        </li>
                        <li>
                            <strong><%=MyBase.GetResourceString("C_PCosts")%> :</strong>
                            <%=MyBase.GetResourceString("C_AccRevNote")%> 
                        </li>
                    </ul>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="PeopleCostTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_Res")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_PCost")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <!-- People Costs Offcanvas end -->

        <!-- Actual Hours Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasActualHours"
            aria-labelledby="offcanvasActualHoursLabel">

            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ActHrs")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <span id="Hrs_StartDate"></span> <%=MyBase.GetResourceString("C_To")%> <span id="Hrs_EndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>
                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="">
                        <span class="detail-note-icon me-1">
                            <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                        </span>
                        <span class="fw-semibold me-1"><%=MyBase.GetResourceString("C_Note")%> :</span>
                    </div>
                    <span><%=MyBase.GetResourceString("C_ActHrsNote")%>
                    </span>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="ActualHoursTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_Res")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_ActHrs")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Actual Hours Offcanvas end -->
         
        <!-- Accrued Billable Expenses Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasAccBillableExpenses"
            aria-labelledby="offcanvasActualHoursLabel">

            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_AccBillExp")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <span id="BilExp_StartDate"></span> <%=MyBase.GetResourceString("C_To")%> <span id="BilExp_EndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>
                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div class="d-flex align-items-center">
                            <span class="detail-note-icon me-1">
                                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                            </span>
                            <span class="fw-semibold"><%=MyBase.GetResourceString("C_Note")%> :</span>
                        </div>
                        <!-- <i class="fa fa-chevron-up text-muted small" aria-hidden="true"></i> -->
                    </div>
                    <ul class="mb-0 ps-3">
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_ExpAmt")%> :</strong>
                            <%=MyBase.GetResourceString("C_BilNote1")%>
                        </li>
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_AccBillExp")%> :</strong>
                            <%=MyBase.GetResourceString("C_BilNote2")%>
                        </li>
                    </ul>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="AccruedBillExpenseTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_CHead")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_AccBillExp")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Accrued Billable Expenses Offcanvas end -->

        <!-- Expenses & Direct Project Cost Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasExpDirectPeopleCost"
            aria-labelledby="offcanvasActualHoursLabel">

            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ExpDirProjCost")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <span id="ExpCost_StartDate"></span> <%=MyBase.GetResourceString("C_To")%> <span id="ExpCost_EndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>
                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div class="d-flex align-items-center">
                            <span class="detail-note-icon me-1">
                                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                            </span>
                            <span class="fw-semibold"><%=MyBase.GetResourceString("C_Note")%> :</span>
                        </div>
                        <!-- <i class="fa fa-chevron-up text-muted small" aria-hidden="true"></i> -->
                    </div>
                    <ul class="mb-0 ps-3">
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_ExpAmt")%> :</strong>
                            <%=MyBase.GetResourceString("C_ExpPCostNote1")%>
                        </li>
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_ExpDirProjCost")%> :</strong>
                            <%=MyBase.GetResourceString("C_ExpPCostNote2")%>
                        </li>
                    </ul>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="ExpDirectPeopleCostTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_CHead")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_ExpDirProjCost")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Expenses & Direct Project Cost Offcanvas end -->
           
        <!-- Accrued People Revenue for Fixed Bid Project Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasAccruedRevMilestone"
            aria-labelledby="offcanvasActualHoursLabel">

            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_AccPeopleRev")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <span id="AccMilestone_StartDate"></span> <%=MyBase.GetResourceString("C_To")%> <span id="AccMilestone_EndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>
                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div class="d-flex align-items-center">
                            <span class="detail-note-icon me-1">
                                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                            </span>
                            <span class="fw-semibold"><%=MyBase.GetResourceString("C_Note")%> :</span>
                        </div>
                        <!-- <i class="fa fa-chevron-up text-muted small" aria-hidden="true"></i> -->
                    </div>
                    <ul class="mb-0 ps-3">
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_ExpAmt")%> :</strong>
                            <%=MyBase.GetResourceString("C_BilNote1")%>
                        </li>
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_AccBillExp")%> :</strong>
                            <%=MyBase.GetResourceString("C_BilNote2")%>
                        </li>
                    </ul>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="AccRevMilestoneTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_Mile")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_AccRev")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Accrued Billable Expenses for Fixed Bid Project Offcanvas end -->

         <!-- People Costs for Fixed Bid Project Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasPeopleCostMilestone"
            aria-labelledby="offcanvasPeopleCostLabel">

            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_PCosts")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <span id="PCMile_StartDate"></span> <%=MyBase.GetResourceString("C_To")%> <span id="PCMile_EndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>
                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <div class="d-flex align-items-center">
                            <span class="detail-note-icon me-1">
                                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                            </span>
                            <span class="fw-semibold"><%=MyBase.GetResourceString("C_Note")%> :</span>
                        </div>
                        <!-- <i class="fa fa-chevron-up text-muted small" aria-hidden="true"></i> -->
                    </div>
                    <ul class="mb-0 ps-3">
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_ActHrs")%> :</strong>
                            <%=MyBase.GetResourceString("C_ActHrsNote")%> 
                        </li>
                        <li class="mb-1">
                            <strong><%=MyBase.GetResourceString("C_Rate")%> :</strong>
                            <%=MyBase.GetResourceString("C_RateNote1")%> 
                        </li>
                        <li>
                            <strong><%=MyBase.GetResourceString("C_PCosts")%> :</strong>
                            <%=MyBase.GetResourceString("C_AccRevNote")%> 
                        </li>
                    </ul>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="PeopleCostTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_Res")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_PCost")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <!-- People Costs for Fixed Bid Project Offcanvas end -->

        <!-- Actual Hours for Fixed Bid Project Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas" tabindex="-1" id="offcanvasActualHrsMilestone"
            aria-labelledby="offcanvasActualHoursLabel">

            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ActHrs")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip"
                            title="Close" data-bs-dismiss="offcanvas"
                            onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <!-- Period / Project -->
                <div class="detail-meta-card mb-3">
                    <div class="d-flex justify-content-between small">
                        <div>
                            <span class="text-primary font-weight-500"><%=MyBase.GetResourceString("C_Period")%> :</span>
                            <span id="HrsMile_StartDate"></span> <%=MyBase.GetResourceString("C_To")%> <span id="HrsMile_EndDate"></span>
                        </div>
                        <div class="text-muted">(<%=MyBase.GetResourceString("C_ProjCurrNote")%>: <span class="currency-symbol-dynamic"></span>)</div>
                    </div>
                </div>
                <div class="small mb-1">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_ProjName")%> :</span>
                    <span class="font-weight-500 ms-1 CurrentProjectName"></span>
                </div>

                <!-- Note -->
                <div class="detail-note-card mb-3">
                    <div class="">
                        <span class="detail-note-icon me-1">
                            <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                        </span>
                        <span class="fw-semibold me-1"><%=MyBase.GetResourceString("C_Note")%> :</span>
                    </div>
                    <span><%=MyBase.GetResourceString("C_ActHrsNote")%>
                    </span>
                </div>

                <!-- Table -->
                <div class="detail-table-card">
                    <div class="table-responsive detail-table-wrapper" style="max-height: 500px;">
                        <table class="table table-bordered mb-0 detail-table" id="ActualHoursTable">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_Res")%></th>
                                    <th class="text-center"><%=MyBase.GetResourceString("C_ActHrs")%></th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Actual Hours for Fixed Bid Project Offcanvas end -->
    </div>

    <div class="clearfix"></div>

     <%Else %>
     <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_AuthAlert")%></p>
        </div>
     </div>
    <%End If %>

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>--%>
    <!-- jqueryUI js -->

    <!-- <script src="../../../Whizible2.0-new/dist/js/jquery.calendar.js"></script> -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
                    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <%--<script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <!-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script> -->
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
                            <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <!-- ChartJS 1.0.1 -->
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>


    <!--profitability Trends chart script-->
    <script type="text/javascript">
        // Added by Gauri on 12/12/2025
        // Global variables
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';

        var defaultProjectID = <%= Session("intProjectID") %>;      // Project ID From session
        var defaultProjectName = null;      // Project Name From session
        var reportingFromDate;              // Global Reporting From date
        var reportingToDate;                // Global Reporting To date
        var isFixedBidProject = false;      // Is current project Fixed Bid type
        var currencyID = 1;                 // Default to INR
        var currencyConfig;                 // Currency configuration symbol
        var RepFreqValue;             // Reporting Frequency ID (Weekly / Monthly)
        var isAutoSelectingToDate = false;          // Flag to avoid triggering ToDate change event during auto-selection

        // Loader state (used by showLoader / hideLoader)
        var loaderShown = false;        
        var loaderStartTime = 0;        

        // Cached profitability trends data
        var cachedProfitabilityTrendsData = null;       // Used to store data for re-rendering chart on resize

        $(document).ready(function () {
            
            $('[data-bs-toggle="tooltip"]').tooltip();

            alertify.set('notifier', 'position', 'top-right');

            // Remove tooltips completely
            $('.bootstrap-select').removeAttr('title');
            $('.bootstrap-select .dropdown-toggle').removeAttr('title');



            getCurrentProjectID();
            updateCurrencySymbols(); // Initialize currency symbols with default
            getCurrencyAndProjectDetails()

            // $('.task-management-tabs a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $('.task-management-tabs a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                var tabId = $(e.target).attr('data-bs-target');

                // 3rd tab = Gross Profit Margin
                if (tabId === '#tabGrossProfitMargin') {
                    toggleReportingPeriod(true);   // disable
                } else {
                    toggleReportingPeriod(false);  // enable
                }

            });

            $('.selectpicker').selectpicker();

            // Also load project details and period dropdowns for the session project
            if (defaultProjectID && defaultProjectID > 0) {
                
                var currentDropdownValue = $('#cboProject').val();
                // Convert to numbers for proper comparison
                var currentVal = parseInt(currentDropdownValue, 10) || 0;
                var sessionVal = parseInt(defaultProjectID, 10) || 0;

                //// Only set if it doesn't match (to avoid unnecessary updates)
                //if (currentVal !== sessionVal) {
                //    $('#cboProject').val(defaultProjectID);
                //    $('#cboProject').selectpicker('refresh');
                //    // Don't trigger change event on initial load - just set the value
                //}

                // Check if defaultProjectID exists in dropdown
                var optionExists = $('#cboProject option[value="' + sessionVal + '"]').length > 0;

                if (optionExists) {
                    if (currentVal !== sessionVal) {
                        $('#cboProject').val(sessionVal);
                    }
                } else {
                    // If project does not exist in dropdown, set to 0
                    $('#cboProject').val(0);
                //    defaultProjectID = 0;
                }

                $('#cboProject').selectpicker('refresh');

                // Load project details and period dropdowns for the session project
                loadProjectDetails(defaultProjectID);
                getProjectProfitabilityReportingFromDate();  // Reporting From
                getProjectProfitabilityReportingToDate(); // Reporting To
            }

            // Handle pdCostMethod dropdown change event
            $('#pdCostMethod').on('changed.bs.select', function() {
                var costMethodValue = $(this).val();
                if (costMethodValue && costMethodValue !== '') {
                    updateCompanyInformation(parseInt(costMethodValue, 10) || 0);
                }

                // Added by Vyankat B on 17 Jan 2026 to change the profitability date range based on the reporting frequency
                RepFreqValue = $('#ReportingFrequencyID').val();

                if (RepFreqValue && RepFreqValue !== '') {
                    updateReportingFrequency(parseInt(RepFreqValue, 10) || 0, 0);
                }
                // End of Added by Vyankat B on 17 Jan 2026 to change the profitability date range based on the reporting frequency
            });

            // Added by Gauri - Handle ReportingFrequencyID dropdown change event
            $('#ReportingFrequencyID').on('changed.bs.select', function() {
                RepFreqValue = $(this).val();
                if (RepFreqValue && RepFreqValue !== '') {
                    //updateReportingFrequency(parseInt(RepFreqValue, 10) || 0);
                    updateReportingFrequency(
                        parseInt(RepFreqValue, 10) || 0,
                        1   // or 0
                    );

                }
            });



            // Added by Gauri - Initial page load complete: hide preloader and show main content
            $("#ProjProfSec").hide();
            $("#ProjProfWrapper").show();

            // This will call GetProjectProfitability and GetProjPeridGraphData APIs on every page load
            initReportingDates(false);
            getFinancialPerformanceGraph();

            // Detect active tab on page load
            var activeTabId = $('.TabDivContent .tab-pane').attr('id');

            // If Gross Profit Margin tab is active, hide reporting period dropdowns
            if (activeTabId === 'tabGrossProfitMargin') {
                toggleReportingPeriod(true);
            }
        });

        // Added by Gauri - Track loaded tabs to avoid redundant API calls
        const tabLoaded = {
            projectProfitability: false,
            profitTrends: false,
            gpm: false,
            revenueTrend: false,
            profitabilitySnapshot: false,
            costTrends: false
        };

        // Added by Gauri - Revenue / Cost Trend date filter flags
        // Initially false so first load shows all data (no date filters)
        let revenueFilterEnabled = false;
        let costFilterEnabled     = false;

        // Added by Gauri to load API data on tab click
        $(document).on('click', '.task-management-tabs [data-tab]', function () {
            const tabKey = $(this).data('tab');

            // Ensure we have a valid project ID before loading any tab data
            var currentProjectID = getCurrentProjectID();
            if (!currentProjectID || currentProjectID <= 0) {
                console.log('No project selected. Please select a project first.');
                return;
            }

            // Update defaultProjectID to current selection (in case it changed)
            defaultProjectID = currentProjectID;
            defaultProjectName = getCurrentProjectName();

            // Mark tab as loaded (for tracking purposes, but we still refresh on each click)
            tabLoaded[tabKey] = true;

            // Always call the API when switching tabs to ensure current project ID is used
            switch (tabKey) {
                case 'projectProfitability':
                    getProjectProfitabilityList(); // Periodic/Detailed/Cumulative table API
                    break;

                case 'profitTrends':
                    loadProjectProfitabilityTrendsData();
                    break;  

                case 'gpm':
                    getGrossProfitMarginList();   // Accrued Revenue/Cost summary API (no dates needed)
                    break;

                case 'revenueTrend':
                    getRevenueTrendList();        // Revenue trend table API
                    break;

                case 'profitabilitySnapshot':
                    getProfitabilitySnapShotList(); // snapshot list API
                    break;

                case 'costTrends':
                    getCostTrendList();          // cost trends table API
                    break;
            }
        });

        // Added by Gauri - Initialize Reporting From and To dates
        function initReportingDates(isUserChange) {
            // Read raw dropdown values
            var fromRaw = ($('#ProjectProfitPeriodFrom').val() || '').trim();
            var toRaw   = ($('#ProjectProfitToPeriodTo').val() || '').trim();

            var frmDate = fromRaw ? toISODate(fromRaw) : null;

                reportingFromDate = null;
                reportingToDate   = null;

                var param = {
                    projectID: defaultProjectID,
                    fromDate: frmDate
                };

                var result = AJAXCallWithResult(
                    "api/ProjectProfitability/GetProjectProfitabilityToDate",
                    JSON.stringify(param),
                    false
                );

                if (typeof result === "string") {
                    try { result = JSON.parse(result); } catch (e) { result = {}; }
                }

            var apiToDate = result?.data?.result?.[0]?.toDate ?? null;
            var formattedToDate = formatToDdMmmYyyy(apiToDate);
          
            $('#ProjectProfitToPeriodTo').selectpicker('val', formattedToDate).selectpicker('refresh');

            // If API returns null → select "Select Reporting To"
            if (!apiToDate) {
                var $to = $('#ProjectProfitToPeriodTo');

                // find "Select Reporting To" option
                var $opt = $to.find('option').filter(function () {
                    var t = (($(this).text() || '') + '').trim().toLowerCase();
                    var v = (($(this).val() || '') + '').trim().toLowerCase();
                    return t === 'select reporting to' || v === 'select reporting to';
                }).first();

                var valToSelect = $opt.length ? $opt.val() : ($to.find('option:first').val() || '');

                // prevent re-trigger loop
                isAutoSelectingToDate = true;
                $to.selectpicker('val', valToSelect);
                $to.selectpicker('refresh');
                isAutoSelectingToDate = false;
            }

            // guard: if we auto-selected To date, skip
            if (isAutoSelectingToDate) ;

            var toRaw = apiToDate;

            // Your existing logic continues normally...
            reportingFromDate = toISODate(fromRaw);
            reportingToDate   = toISODate(toRaw);

            getProjectProfitabilityList();
            getFinancialPerformanceGraph();
            
            // Refresh the currently active tab's data when date range changes
            refreshActiveTabData();

            $('#ProjectProfitToPeriodTo').on('focus', function () {
                previousToDate = $(this).val();
            });
        }
        
        // Added by Gauri - format Date as "DD MMM YYYY"
        function formatDateDDMMMYYYY(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return dateStr;
            return d.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
        }

        function formatToDdMmmYyyy(isoDate) {
            if (!isoDate) return null;

            var d = new Date(isoDate);
            if (isNaN(d)) return null;

            var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

            var day = String(d.getDate()).padStart(2, '0');
            var month = months[d.getMonth()];
            var year = d.getFullYear();

            return day + '-' + month + '-' + year;
        }

        // Added by Gauri - Make it global (safe even if script order changes)
        function bindReportingToByFrom (fromVal) {
            var $to = $('#ProjectProfitToPeriodTo');

            if (!defaultProjectID || defaultProjectID <= 0 || !fromVal) {
                $to.empty()
                .append('<option value="">Select Reporting To</option>')
                .selectpicker('refresh');
                return;
            }

            var fromISO = toISODate(fromVal) || fromVal;

            var result = AJAXCallWithResult(
                "api/ProjectProfitability/GetProjectProfitabilityToDate",
                JSON.stringify({ projectID: defaultProjectID, fromDate: fromISO }),
                false
            );

            if (typeof result === "string") { try { result = JSON.parse(result); } catch (e) { result = {}; } }

            var toDateRaw = result?.data?.result?.[0]?.toDate || '';
            if (!toDateRaw) {
                $to.empty()
                .append('<option value="">No Reporting To available</option>')
                .selectpicker('refresh');
                return;
            }

            var toText = formatDateDDMMMYYYY(toDateRaw);

            $to.empty()
            .append('<option value="">Select Reporting To</option>')
            .append($('<option/>', { value: toDateRaw, text: toText }));

            $to.selectpicker('refresh');
            $to.selectpicker('val', toDateRaw); // ✅ auto select
        };

        // Added by Gauri - Set Reporting To date based on From date selection
        function setReportingToByFromDate() {
            if (!defaultProjectID || defaultProjectID <= 0) return;

            var fromVal = $('#ProjectProfitPeriodFrom').val();
            if (!fromVal) return;

            var param = {
                projectID: defaultProjectID,
                fromDate: toISODate(fromVal)
            };

            var url = "api/ProjectProfitability/GetProjectProfitabilityToDate";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON (ToDate API):", result); return; }
            }

            var toDateISO = result?.data?.result?.[0]?.toDate; // "2026-01-31T00:00:00"
            if (!toDateISO) return;

            // If your dropdown option values are ISO strings, this will work directly:
            $('#ProjectProfitToPeriodTo').val(toDateISO);
            $('#ProjectProfitToPeriodTo').selectpicker('refresh');
        }

        // Added by Gauri - Helper to convert various date formats to ISO string
        function toISODate(val) {
            if (!val) return null;

            // already ISO? 2025-05-01T...
            if (/^\d{4}-\d{2}-\d{2}T/.test(val)) return val;

            // already yyyy-mm-dd
            if (/^\d{4}-\d{2}-\d{2}$/.test(val)) {
                return new Date(val + "T00:00:00Z").toISOString();
            }

            // dd-MMM-yyyy (01-May-2025)
            var m = val.match(/^(\d{1,2})-([A-Za-z]{3})-(\d{4})$/);
            if (m) {
                var dd = parseInt(m[1], 10);
                var mon = m[2].toLowerCase();
                var yyyy = parseInt(m[3], 10);

                var months = { jan: 0, feb: 1, mar: 2, apr: 3, may: 4, jun: 5, jul: 6, aug: 7, sep: 8, oct: 9, nov: 10, dec: 11 };
                var mm = months[mon];
                if (mm === undefined) return null;

                // Use UTC so API gets clean Z time
                return new Date(Date.UTC(yyyy, mm, dd, 0, 0, 0, 0)).toISOString();
            }

            // fallback parse
            var dt = new Date(val);
            return isNaN(dt.getTime()) ? null : dt.toISOString();
        }

        // Enhanced AJAX helper with better error handling
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
                    // Always add Params header for POST requests
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    // Return the complete response object to preserve pagination info
                    result = data;
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 401) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%=MyBase.GetResourceString("A_AuthenticationFailed")%>', 'error', 5);
                    } else {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                    }
                }
            });

            // For synchronous calls, return the result directly
            if (!async) {
                return result;
            }

            // For asynchronous calls, return AjaxResult (legacy behavior)
            return AjaxResult;
        }

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
                setTimeout(function() {
                    document.getElementById('loaderOverlay').style.display = 'none';
                    loaderShown = false;
                }, minDisplayTime - elapsedTime);
            } else {
                document.getElementById('loaderOverlay').style.display = 'none';
                loaderShown = false;
            }
        }

        // Added by Gauri - Get selected Project ID
        function getCurrentProjectID() {
        
            var pid = $('#cboProject').val();
            if (!pid || pid === "0") return null;
            return parseInt(pid, 10);
        }

        // Added by Gauri - Get selected Project Name
        function getCurrentProjectName() {
            var name = $('#cboProject option:selected').text();
            if (!name || name.toLowerCase().includes("select")) return null;
            return $.trim(name);
        }

        // Added by Gauri - On Project change handler
        // Helper function to get the currently active tab key
        function getActiveTabKey() {
            // Method 1: Find the active nav-link (Bootstrap tabs)
            var $activeNavLink = $('.task-management-tabs .nav-link.active[data-tab]');
            if ($activeNavLink.length > 0) {
                return $activeNavLink.data('tab') || 'projectProfitability';
            }
            
            // Method 2: Find by active tab-pane and map to tab key
            var $activePane = $('.tab-content .tab-pane.active');
            if ($activePane.length > 0) {
                var paneId = $activePane.attr('id');
                // Map pane IDs to tab keys
                var paneToTabMap = {
                    'tabProjectProfitability': 'projectProfitability',
                    'tabProfitabilityTrends': 'profitTrends',
                    'tabGrossProfitMargin': 'gpm',
                    'tabRevenueTrend': 'revenueTrend',
                    'tabProfitabilitySnapshot': 'profitabilitySnapshot',
                    'tabCostTrends': 'costTrends'
                };
                if (paneToTabMap[paneId]) {
                    return paneToTabMap[paneId];
                }
            }
            
            // Method 3: Default to first tab if nothing found
            return 'projectProfitability';
        }

        // Added by Gauri - Function to refresh data for the currently active tab
        function refreshActiveTabData() {
            var activeTabKey = getActiveTabKey();
            
            switch (activeTabKey) {
                case 'projectProfitability':
                    getProjectProfitabilityList();
                    getFinancialPerformanceGraph();
                    break;

                case 'profitTrends':
                    loadProjectProfitabilityTrendsData();
                    break;

                case 'gpm':
                    getGrossProfitMarginList();
                    break;

                case 'revenueTrend':
                    getRevenueTrendList();
                    break;

                case 'profitabilitySnapshot':
                    getProfitabilitySnapShotList();
                    break;

                case 'costTrends':
                    getCostTrendList();
                    break;

                default:
                    // If dates are available, refresh the default tab
                    if (reportingFromDate && reportingToDate) {
                        getProjectProfitabilityList();
                    }
                    break;
            }
        }

        // Added by Gauri - To call API on Project Change
        function ProjectOnChange() {
            
            var selectedProjectID = getCurrentProjectID();   // should return selected projectId
            var selectedProjectName = getCurrentProjectName();   // should return selected projectName

            // Check if project actually changed (avoid reload on initial page load)
            var projectChanged = (selectedProjectID != defaultProjectID);
            
            defaultProjectID = selectedProjectID;
            defaultProjectName = selectedProjectName;

            // Update project details
            getCurrencyAndProjectDetails();
            loadProjectDetails(defaultProjectID);

            // Added by Vyankat B on 17 Jan 2026 to change the profitability date range based on the reporting frequency
            RepFreqValue = $('#ReportingFrequencyID').val();

            if (RepFreqValue && RepFreqValue !== '') {
                //updateReportingFrequency(parseInt(RepFreqValue, 10) || 0);

                updateReportingFrequency(
                    parseInt(RepFreqValue, 10) || 0,
                    1   // or 0
                );


            }
            // End of Added by Vyankat B on 17 Jan 2026 to change the profitability date range based on the reporting frequency

            // Load period dropdowns for the selected project
            getProjectProfitabilityReportingFromDate();  // Reporting From
            getProjectProfitabilityReportingToDate(); // Reporting To

            getProjectProfitabilityList();

            // Some tabs (like GPM) don't need dates, so we'll refresh them anyway.
            var activeTabKey = getActiveTabKey();
            var needsDates = (activeTabKey === 'projectProfitability' || activeTabKey === 'profitTrends' || 
                             activeTabKey === 'revenueTrend' || activeTabKey === 'costTrends');

            if (!needsDates) {
                refreshActiveTabData();
                return;
            }

            // Refresh the currently active tab's data when project changes
            refreshActiveTabData();
        }

        // Added by Gauri - Show/Hide reporting period selectors
        function toggleReportingPeriod(hide) {
            var $fromWrapper = $('#ProjectProfitPeriodFrom').closest($(".DateRangeDiv"));
            var $toWrapper = $('#ProjectProfitToPeriodTo').closest($(".DateRangeDiv"));

            if (hide) {
                $fromWrapper.addClass('d-none');
                $toWrapper.addClass('d-none');
                $("#profitabilityNoData").addClass('d-none');
            } else {
                $fromWrapper.removeClass('d-none');
                $toWrapper.removeClass('d-none');
                $("#profitabilityNoData").removeClass('d-none');
            }
        }

        // Added by Gauri - Load data for Project Details section
        function loadProjectDetails(projectId) {
            //debugger;
            var req = { projectID: parseInt(projectId, 10) || 0 };
            var result = AJAXCallWithResult('api/ProjectProfitability/GetProjectDetail', JSON.stringify(req), false);

            // ---- Extract first row safely ----
            var d =
                result?.data?.ProjectDetailModel?.[0] ||
                result?.Data?.ProjectDetailModel?.[0] ||
                result?.ProjectDetailModel?.[0] ||
                null;

            // helpers
            function setText(id, value) {
                $('#' + id).text(value == null ? '' : String(value));
            }

            function setCostMethodDropdown(costMethodValue) {
                var $ddl = $('#pdCostMethod');
                if (!$ddl.length) return;

                // Set by numeric value (API returns numeric costMethod)
                if (costMethodValue && costMethodValue !== "N/A") {
                    var numericValue = parseInt(costMethodValue, 10);
                    if (!isNaN(numericValue)) {
                        $ddl.val(numericValue);
                    }
                } else {
                    $ddl.val('');
                }

                $ddl.selectpicker('refresh');
            }

            function setReportingFrequencyDropdown(reportFrequencyValue) {
                var $ddl = $('#ReportingFrequencyID');
                if (!$ddl.length) return;

                // Set by numeric value (API returns numeric reportFrequency)
                if (reportFrequencyValue && reportFrequencyValue !== "N/A") {
                    var numericValue = parseInt(reportFrequencyValue, 10);
                    if (!isNaN(numericValue)) {
                        $ddl.val(numericValue);
                    }
                } else {
                    $ddl.val('');
                }

                $ddl.selectpicker('refresh');
            }

            if (!d) {
                // clear all
                setText('pdProjectName', '');
                setText('pdProjectValue', '');
                setText('pdCommercialType', '');
                setText('pdCostMethod', '');
                setText('pdProjectCurrStatus', '');
                setText('pdStartDate', '');
                setText('pdEndDate', '');
                setText('pdActualStartDate', '');
                setText('pdActualEndDate', '');
                setCostMethodDropdown('');
                setReportingFrequencyDropdown('');
                showProjectDetailsNoData();
                return;
            }

            // hideProjectDetailsNoData();

            // ---- Bind fields ----
            setText('pdProjectName', d.projectName || "N/A");
            setText('pdProjectValue', formatINR(d.contractValue || 0));
            setText('pdCommercialType', d.nodeLabel || "N/A");  // e.g., Fixed Bid
            setText('pdProjectCurrStatus', d.projectStatus || "N/A");
            setCostMethodDropdown(d.costMethod || null);
            setReportingFrequencyDropdown(d.reportFrequency || null);

            setText('pdStartDate', formatDateDDMMMYYYY(d.expectedStartDate) || "N/A");
            setText('pdEndDate', formatDateDDMMMYYYY(d.expectedEndDate) || "N/A");
            setText('pdActualStartDate', formatDateDDMMMYYYY(d.actualStartDate) || "N/A");
            setText('pdActualEndDate', formatDateDDMMMYYYY(d.actualEndDate) || "N/A");
        }

        // Added by Gauri - Update Company Information API call
        function updateCompanyInformation(costMethod) {
            var req = { costMethod: costMethod };
            var url = 'api/ProjectProfitability/UpdateCompanyInformation';
            var result = AJAXCallWithResult(url, JSON.stringify(req), false);
            
            // Refresh the active tab data after updating cost method
            refreshActiveTabData();
        }

        // Added by Gauri - Added by Gauri update data monthly or weekly
        function updateReportingFrequency(reportingFrequency, flag) {
            showLoader();

            // Allow browser to paint loader BEFORE sync AJAX
            setTimeout(function () {
               try {

                    var req = { reportingFrequency: reportingFrequency };
                    var url = 'api/ProjectProfitability/UpdReportingFrequency';
                    var result = AJAXCallWithResult(url, JSON.stringify(req), false);

                    var param = {
                        projectID: defaultProjectID                      
                   };

                    var url = 'api/ProjectProfitability/GetProjectProfitabilityDateRange';
                    var response = AJAXCallWithResult(url, JSON.stringify(param), false);

                    if (
                        response &&
                        response.data &&
                        response.data.ProjectDateRangeResponse &&
                        response.data.ProjectDateRangeResponse.length > 0
                    ) {
                        var frDate = response.data.ProjectDateRangeResponse[0].fromDate || null;
                        var toDate = response.data.ProjectDateRangeResponse[0].toDate || null;
                    }

                    var param = {
                        projectID: defaultProjectID,
                        fromdate: frDate,
                        toDate: toDate,
                        DtFlag: flag
                    };

                    var url = "api/ProjectProfitability/GenerateProjProfi";
                    var result = AJAXCallWithResult(url, JSON.stringify(param), false);
                    
                    // First refresh the data, then trigger tab click to ensure UI is updated
                    refreshActiveTabData();
                    
                    getProjectProfitabilityReportingFromDate();  // Reporting From

                    // Also trigger the tab click to ensure the tab UI is refreshed
                    setTimeout(function() {
                        var activeTabKey = getActiveTabKey();
                        var $activeTab = $('.task-management-tabs .nav-link[data-tab="' + activeTabKey + '"]');
                        if ($activeTab.length > 0) {
                            $activeTab.trigger('click');
                        }
                    }, 100);
                } catch (error) {
                   console.error("Error in updateReportingFrequency:", error);
                } finally {
                    // Hide loader AFTER everything is done (always hide, even on error)
                    hideLoader();
               }
            }, 0);

        }

        // Added by Gauri - Export Profitability add getDate helper
        function getTodayYYYYMMDD() {
            var d = new Date();
            var yyyy = d.getFullYear();
            var mm = String(d.getMonth() + 1).padStart(2, '0');
            var dd = String(d.getDate()).padStart(2, '0');
            return `${yyyy}${mm}${dd}`;
        }

        // Added by Gauri - Join URL parts safely on 27 Jan 2026
        function joinUrl(base, path) {
            return base.replace(/\/+$/, '') + '/' + path.replace(/^\/+/, '');
        }

        // Added by Gauri on 22 Dec 2025 - Export Profitability View Report function for PDF and Excel
        function exportProfitabilityReport(format) {
            
            showLoader();

            // Modified API endpoint based on format by Gauri on 27 Jan 2026
            var apiUrl = (format === 'PDF')
                ? 'api/ProjectProfitability/GenerateProfitabilityPdf'
                : (format === 'EXCEL')
                    ? 'api/ProjectProfitability/GenerateProfitabilityExcel'
                    : null;

            if (!apiUrl) {
                hideLoader();
                console.error('Unsupported export format:', format);
                return;
            }

            var param = {
                projectID: defaultProjectID,
                fromDate: reportingFromDate,
                toDate: reportingToDate
            };

            var ext = (format === 'PDF') ? 'pdf' : 'xlsx';
            var today = getTodayYYYYMMDD(); // e.g. 20251223
            // Get project name from dropdown if defaultProjectName is null
            var proj = defaultProjectName || getCurrentProjectName() || 'Project';
            var fileName = `${proj}_${today}.${ext}`;

            // Added by Gauri - Construct full URL safely on 27 Jan 2026
            var excelUrl = joinUrl(strUrl, apiUrl);

            $.ajax({
                // url: strUrl + apiUrl,
                url: excelUrl,      // Updated by Gauri on 27 Jan 2026
                type: 'POST',
                data: JSON.stringify(param),
                contentType: 'application/json',
                xhrFields: { responseType: 'blob' },

                beforeSend: function (xhr) {
                    var token = sessionStorage.getItem("access_token_W26API");
                    if (token) xhr.setRequestHeader('Authorization', 'bearer ' + token);
                },

                success: function (blob) {
                    // download
                    var url = window.URL.createObjectURL(blob);
                    var a = document.createElement('a');
                    a.href = url;
                    a.download = fileName;
                    document.body.appendChild(a);
                    a.click();
                    a.remove();
                    setTimeout(function () { window.URL.revokeObjectURL(url); }, 1000);
                },

                error: function (xhr) {
                    console.error(`${format} export failed:`, xhr.status, xhr.responseText || '');
                    alertify.error("There are no items to show.");
                },

                complete: function () {
                    hideLoader();
                }
            });
        }

        // Added by Gauri - Profitability Trends Tab Handlers - 1) Tab click wiring
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".GPM_TrendTabs .btn").forEach(btn => {
                btn.addEventListener("click", function () {
                    document.querySelectorAll(".GPM_TrendTabs .btn").forEach(b => b.classList.remove("active"));
                    this.classList.add("active");

                    const graphType = parseInt(this.getAttribute("data-graph"), 10) || 1;
                    // Just render the chart with cached data, no API call
                    renderProjectProfitabilityTrendsChart(graphType);
                });
            });
        });

        // Added by Gauri - Load profitability trends data from API (called once on tab load)
        function loadProjectProfitabilityTrendsData() {
            
            var projectId = getCurrentProjectID();
            if (!projectId) return;

            // Always use graphId: 3 for API call

            reportingFromDate = ($('#ProjectProfitPeriodFrom').val() || '').trim();
            reportingToDate = ($('#ProjectProfitToPeriodTo').val() || '').trim();

            // Treat placeholder text as NULL
            if (reportingFromDate === 'Select Date Range From') {
                reportingFromDate = null;
            }

            if (reportingToDate === 'Select Date Range To') {
                reportingToDate = null;
            }


            // Convert to ISO (yyyy-MM-dd)
            if (reportingFromDate) {
                const from = new Date(reportingFromDate);
                reportingFromDate = from.getFullYear() + '-' +
                    String(from.getMonth() + 1).padStart(2, '0') + '-' +
                    String(from.getDate()).padStart(2, '0');
            }

            if (reportingToDate) {
                const to = new Date(reportingToDate);
                reportingToDate = to.getFullYear() + '-' +
                    String(to.getMonth() + 1).padStart(2, '0') + '-' +
                    String(to.getDate()).padStart(2, '0');
            }

            var payload = {
                projectID: parseInt(projectId, 10) || 0,
                fromDate: reportingFromDate,
                toDate: reportingToDate,
                graphId: 3
            };

            var result = AJAXCallWithResult(
                "api/ProjectProfitability/GetProjectProfitabilityTrends",
                JSON.stringify(payload),
                false
            );

            toggleProfitabilityGenerateMessage();

            if (!result || !result.data) return;

            // Format asOn dates in ProjectProfitabilityTrendGraph3Model
            var rows = result?.data?.ProjectProfitabilityTrendGraph3Model;
            if (Array.isArray(rows)) {
                rows.forEach(function(row) {
                    if (row.asOn) {
                        row.asOn = formatAsOnDate(row.asOn);
                    }
                });
            }
            if (!Array.isArray(rows)) rows = [];

            // Cache the processed data
            cachedProfitabilityTrendsData = {
                labels: rows.map(r => r.asOn || ''),
                totalCost: rows.map(r => r.totalCost || 0),
                revenue: rows.map(r => r.revenue || 0),
                gpm: rows.map(r => r.gpm || 0)
            };

            // Render the chart with the currently active graph type (or default to line graph)
            var $activeGraphBtn = $('.GPM_TrendTabs .btn.active');
            var graphType = 1; // default to line graph
            if ($activeGraphBtn.length > 0) {
                graphType = parseInt($activeGraphBtn.attr('data-graph'), 10) || 1;
            }
            renderProjectProfitabilityTrendsChart(graphType);
        }

        // Added by Gauri - Render profitability trends chart using cached data
        function renderProjectProfitabilityTrendsChart(graphType) {
            // Use cached data if available
            if (!cachedProfitabilityTrendsData) {
                // If no cached data, load it first
                loadProjectProfitabilityTrendsData();
                return;
            }

            var canvas = document.getElementById("gpmTrendChart");
            if (!canvas || !window.Chart) return;

            safeDestroyGpmChart();

            var labels = cachedProfitabilityTrendsData.labels;
            var totalCost = cachedProfitabilityTrendsData.totalCost;
            var revenue = cachedProfitabilityTrendsData.revenue;
            var gpm = cachedProfitabilityTrendsData.gpm;

            // Render chart based on graphType (1=line, 2=column, 3=point)
            // All graphs use the same data fields: totalCost, revenue, gpm
            if (graphType === 1) {
                // Line Graph
                gpmChart = new Chart(canvas, {
                    type: "line",
                    data: {
                        labels: labels,
                        datasets: [
                            { label: "Revenue", data: revenue, borderColor: "#f59e0b", backgroundColor: "#f59e0b", tension: 0.3 },
                            { label: "Total Cost", data: totalCost, borderColor: "#ef4444", backgroundColor: "#ef4444", tension: 0.3 },
                            { label: "GPM", data: gpm, borderColor: "#10b981", backgroundColor: "#10b981", tension: 0.3 }
                        ]
                    },
                    options: commonMoneyOptions()
                });
            }
            else if (graphType === 2) {
                // Column (Bar) Graph
                gpmChart = new Chart(canvas, {
                    type: "bar",
                    data: {
                        labels: labels,
                        datasets: [
                            { label: "Revenue", data: revenue, backgroundColor: "#f59e0b" },
                            { label: "Total Cost", data: totalCost, backgroundColor: "#ef4444" },
                            { label: "GPM", data: gpm, backgroundColor: "#10b981" }
                        ]
                    },
                    options: {
                        ...commonMoneyOptions(),
                        scales: {
                            x: { stacked: false },
                            y: {
                                beginAtZero: true,
                                ticks: { callback: v => formatINR(v) }
                            }
                        }
                    }
                });
            }
            else if (graphType === 3) {
                // Point (Scatter) Graph
                var costPoints = totalCost.map((val, i) => ({ x: i, y: val }));
                var revPoints = revenue.map((val, i) => ({ x: i, y: val }));
                var gpmPoints = gpm.map((val, i) => ({ x: i, y: val }));

                gpmChart = new Chart(canvas, {
                    type: "scatter",
                    data: {
                        datasets: [
                            { label: "Revenue", data: revPoints, backgroundColor: "#f59e0b" },
                            { label: "Total Cost", data: costPoints, backgroundColor: "#ef4444" },
                            { label: "GPM", data: gpmPoints, backgroundColor: "#10b981" }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        interaction: { mode: "nearest", intersect: true },
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                align: 'end',
                                labels: {
                                    color: '#374151',
                                    usePointStyle: true,
                                    boxWidth: 12,
                                    boxHeight: 6,
                                    padding: 20,
                                    font: {
                                        size: 12
                                    }
                                }
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (ctx) {
                                        var val = ctx.parsed?.y ?? 0;
                                        return `${ctx.dataset.label}: ${formatINR(val)}`;
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                type: "linear",
                                ticks: {
                                    callback: function (value) {
                                        // show label instead of numeric index
                                        return labels[value] ?? "";
                                    }
                                }
                            },
                            y: {
                                beginAtZero: true,
                                ticks: { callback: v => formatINR(v) }
                            }
                        }
                    }
                });
            }
        }

        // Common Chart Options for Money values
        function commonMoneyOptions() {
            return {
                responsive: true,
                maintainAspectRatio: false,
                interaction: { mode: "index", intersect: false },
                plugins: {
                    tooltip: {
                        callbacks: {
                            label: function (ctx) {
                                // Works for line/bar; scatter uses parsed.y
                                var val = (ctx.parsed?.y ?? ctx.raw);
                                return `${ctx.dataset.label}: ${formatINR(val)}`;
                            }
                        }
                    },
                    legend: {
                        display: true,
                        position: 'top',
                        align: 'end',
                        labels: {
                            color: '#374151',
                            usePointStyle: true,
                            boxWidth: 12,
                            boxHeight: 6,
                            padding: 20,
                            font: {
                                size: 12
                            }
                        }
                    }
                },
                scales: {
                y: {
                    beginAtZero: true,
                    ticks: { callback: v => formatINR(v) }
                }
                }
            };
        }

        // Added by Gauri - safely destroy existing chart instances
        var gpmChart = null;   // GPM Trend charts
        var fpChart  = null;   // Financial Performance chart

        function safeDestroyGpmChart() {
            if (window.gpmChart) {
                window.gpmChart.destroy();
                window.gpmChart = null;
            }
        }

        // Safely destroy Financial Performance chart
        function safeDestroyFpChart() {
            try {
                if (fpChart && typeof fpChart.destroy === "function") {
                    fpChart.destroy();
                }
            } catch (e) {
                console.warn("fpChart destroy skipped:", e);
            }
            fpChart = null;
        }

        // Added by Gauri - Fetch Project Financial Performance data and bind chart
        function getFinancialPerformanceGraph() {
            
            // Ensure we have a valid project
            if (!defaultProjectID || defaultProjectID <= 0) {
                safeDestroyFpChart();
                return;
            }

            var param = { projectID: defaultProjectID };

            // Note: SP no longer requires fromDate and toDate - returns aggregated summary for all periods

            var url = "api/ProjectProfitability/GetProjectFinancialData";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) {
                    console.error("Invalid JSON (GetProjectFinancialData):", result);
                    safeDestroyFpChart();
                    return;
                }
            }

            // Support both result.data.ProjectProfitabilityFinancialDataModel
            // and direct result.ProjectProfitabilityFinancialDataModel
            var rows = null;
            if (result && result.data && Array.isArray(result.data.ProjectProfitabilityFinancialDataModel)) {
                rows = result.data.ProjectProfitabilityFinancialDataModel;
            } else if (result && Array.isArray(result.ProjectProfitabilityFinancialDataModel)) {
                rows = result.ProjectProfitabilityFinancialDataModel;
            } else {
                rows = [];
            }

            // Ensure rows is an array
            if (!Array.isArray(rows)) {
                rows = [];
            }

            // SP now returns single aggregated row - extract values from first row
            var dataRow = rows.length > 0 ? rows[0] : null;

            // Extract values from single row (SP returns aggregated summary)
            var plannedRevenue = dataRow ? (dataRow.plannedRevenue || 0) : 0;
            var plannedCost = dataRow ? (dataRow.plannedCost || 0) : 0;
            var plannedProfit = dataRow ? (dataRow.plannedProfit || 0) : 0;
            var actualRevenue = dataRow ? (dataRow.actualRevenue || 0) : 0;
            var actualCost = dataRow ? (dataRow.actualCost || 0) : 0;
            var actualProfit = dataRow ? (dataRow.actualProfit || 0) : 0;
            var variance = dataRow ? (dataRow.variance || 0) : 0;

            // Always render chart, even with empty data
            renderFinancialPerformanceChart(plannedRevenue, plannedCost, plannedProfit, actualRevenue, actualCost, actualProfit, variance);
        }

        // Render Financial Performance with 3 columns: Planned Data, Actual Data, Variance
        // Column 1: Stacked PlannedRevenue, PlannedCost, PlannedProfit
        // Column 2: Stacked ActualRevenue, ActualCost, ActualProfit
        // Column 3: Variance (single value)
        function renderFinancialPerformanceChart(plannedRevenue, plannedCost, plannedProfit, actualRevenue, actualCost, actualProfit, variance) {
            var canvas = document.getElementById("financialPerformanceChart");
            if (!canvas || !window.Chart) return;

            safeDestroyFpChart();

            // Ensure all values are numbers
            plannedRevenue = parseFloat(plannedRevenue) || 0;
            plannedCost = parseFloat(plannedCost) || 0;
            plannedProfit = parseFloat(plannedProfit) || 0;
            actualRevenue = parseFloat(actualRevenue) || 0;
            actualCost = parseFloat(actualCost) || 0;
            actualProfit = parseFloat(actualProfit) || 0;
            variance = parseFloat(variance) || 0;

            // Three column labels
            var labels = ["Planned", "Actual", "Variance"];

            // Define matching colors for planned/actual pairs
            var revenueColor = "#f7d28b"; // Light Golden/Yellow - same for Planned and Actual Revenue
            var costColor = "#ff704d"; // Coral/Orange-Red - same for Planned and Actual Cost
            var profitColor = "#ff66ff"; // Bright Magenta/Fuchsia - same for Planned and Actual Profit
            var varianceColor = "#66ffff"; // Bright Cyan - for Variance

            // Define datasets for 3 columns
            // Column 1: Planned Data (stacked: PlannedRevenue, PlannedCost, PlannedProfit)
            // Column 2: Actual Data (stacked: ActualRevenue, ActualCost, ActualProfit)
            // Column 3: Variance (single value)
            var datasets = [
                // Planned Revenue - Column 1 only
                {
                    label: "Planned Revenue",
                    data: [plannedRevenue, 0, 0],
                    backgroundColor: revenueColor,
                    borderColor: revenueColor,
                    borderWidth: 0,
                    stack: 'planned' // Stack with other planned values
                },
                // Planned Cost - Column 1 only
                {
                    label: "Planned Cost",
                    data: [plannedCost, 0, 0],
                    backgroundColor: costColor,
                    borderColor: costColor,
                    borderWidth: 0,
                    stack: 'planned' // Stack with other planned values
                },
                // Planned Profit - Column 1 only
                {
                    label: "Planned Profit",
                    data: [plannedProfit, 0, 0],
                    backgroundColor: profitColor,
                    borderColor: profitColor,
                    borderWidth: 0,
                    stack: 'planned' // Stack with other planned values
                },
                // Actual Revenue - Column 2 only (same color as Planned Revenue)
                {
                    label: "Actual Revenue",
                    data: [0, actualRevenue, 0],
                    backgroundColor: revenueColor,
                    borderColor: revenueColor,
                    borderWidth: 0,
                    stack: 'actual' // Stack with other actual values
                },
                // Actual Cost - Column 2 only (same color as Planned Cost)
                {
                    label: "Actual Cost",
                    data: [0, actualCost, 0],
                    backgroundColor: costColor,
                    borderColor: costColor,
                    borderWidth: 0,
                    stack: 'actual' // Stack with other actual values
                },
                // Actual Profit - Column 2 only (same color as Planned Profit)
                {
                    label: "Actual Profit",
                    data: [0, actualProfit, 0],
                    backgroundColor: profitColor,
                    borderColor: profitColor,
                    borderWidth: 0,
                    stack: 'actual' // Stack with other actual values
                },
                // Variance - Column 3 only (Red for negative, Green for positive)
                {
                    label: "Variance",
                    data: [0, 0, variance],
                    backgroundColor: variance >= 0 ? "#10B981" : "#EF4444", // Green for positive, Red for negative
                    borderColor: variance >= 0 ? "#10B981" : "#EF4444",
                    borderWidth: 0,
                    stack: 'variance' // Separate stack for variance
                }
            ];

            fpChart = new Chart(canvas, {
                type: "bar",
                data: {
                    labels: labels, // Three column labels
                    datasets: datasets
                },
                options: {
                    ...commonMoneyOptions(),
                    maintainAspectRatio: false,
                    datasets: {
                        bar: {
                            // Control column width - adjust categoryPercentage to control spacing between columns
                            categoryPercentage: 0.6, // 60% of category width (creates spacing between months)
                            barPercentage: 1.0, // 100% of available bar width (no gaps between segments)
                            maxBarThickness: 50, // Maximum column width in pixels
                            minBarLength: 0 // Ensure even tiny segments are visible
                        }
                    },
                    elements: {
                        bar: {
                            borderWidth: 0, // Ensure no borders on bars
                            borderSkipped: false, // Don't skip any borders
                            borderRadius: 0 // No rounded corners
                        }
                    },
                    plugins: {
                        ...commonMoneyOptions().plugins,
                        legend: {
                            display: true,
                            position: 'top',
                            align: 'end',
                            labels: {
                                color: '#374151',
                                usePointStyle: true,
                                boxWidth: 12,
                                boxHeight: 6,
                                padding: 20,
                                font: {
                                    size: 12
                                }
                            }
                        },
                        tooltip: {
                            filter: function(tooltipItem) {
                                // Show only relevant tooltips for each column
                                var dataIndex = tooltipItem.dataIndex;
                                var datasetLabel = tooltipItem.dataset.label || '';
                                
                                // Column 0 (Planned Data): Show only planned values
                                if (dataIndex === 0) {
                                    return datasetLabel.includes('Planned');
                                }
                                // Column 1 (Actual Data): Show only actual values
                                if (dataIndex === 1) {
                                    return datasetLabel.includes('Actual');
                                }
                                // Column 2 (Variance): Show only variance
                                if (dataIndex === 2) {
                                    return datasetLabel === 'Variance';
                                }
                                return false;
                            },
                            callbacks: {
                                label: function(context) {
                                    var label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    label += formatINR(context.parsed.y);
                                    return label;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            stacked: true, // Enable stacking for each column
                            grid: {
                                color: "#e5e7eb",
                                drawOnChartArea: true,
                                drawBorder: true, // Enable border to show X-axis line
                                borderColor: "#e5e7eb", // Light gray color for axis line
                                borderWidth: 1 // Thin line
                            },
                            border: {
                                display: true, // Show thin X-axis line
                                color: "#e5e7eb", // Light gray color to match grid
                                width: 1 // Thin line
                            },
                            ticks: {
                                color: "#6b7280",
                                font: {
                                    size: 12
                                }
                            }
                        },
                        y: {
                            stacked: true, // Stack values on Y-axis for each column
                            beginAtZero: true, // Show zero line as baseline
                            ticks: {
                                callback: function (value) {
                                    return formatINR(value);
                                },
                                color: "#6b7280"
                            },
                            grid: {
                                color: "#e5e7eb", // Same color for all grid lines including zero line
                                drawOnChartArea: true,
                                lineWidth: 1 // Same width for all grid lines
                            },
                            border: {
                                display: false // Remove axis border
                            }
                        }
                    }
                }
            });
        }

        // Added by Gauri - Load Reporting From dropdown with period data
        function getCurrencyAndProjectDetails() {
            var param = {
                projectID: defaultProjectID,
            };

            var url = "api/ProjectProfitability/GetProjectContractTypeCurrency";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);
            
            if(result.result?.[0]?.contractType == 1){
                isFixedBidProject = true;
            } else {
                isFixedBidProject = false;
            }
            currencyID = result.result?.[0]?.billingCurrencyID || 1;
            currencyConfig = result.result?.[0]?.currencySymbol || "";
            updateCurrencySymbols();
            RepFreqValue = $("#ReportingFrequencyID").val();
        }

        // Added by Gauri - format currency with symbol from API
        function formatINR(value) {
            value = value || 0;
            
            // Get currency symbol from API result (set in getCurrencyAndProjectDetails)
            const currencySymbol = currencyConfig || '₹';
            
            // Determine locale based on currencyID
            let locale = 'en-IN'; // Default to INR
            // let suffix = '';
            
            if (currencyID === 2) {
                locale = 'en-US'; // USD
            } else if (currencyID === 3) {
                locale = 'en-SG'; // SGD
                // suffix = ' SGD';
            }
            
            return (
                currencySymbol +
                ' ' +
                value.toLocaleString(locale, {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                }) 
                // + suffix
            );
        }

        // Added by Gauri - update currency symbols in the UI
        function updateCurrencySymbols() {
            $('#currencySymbolHeader').text(currencyConfig);
            $('.currency-symbol-dynamic').text(currencyConfig);
        }

        // Added by Gauri - Format hours as HH:MM (e.g., 2743.5 becomes "2743:30")
        function formatHours(value) {
            var hours = parseFloat(value || 0);
            if (isNaN(hours) || hours < 0) hours = 0;
            
            // Get integer part (hours)
            var hoursInt = Math.floor(hours);
            
            // Get decimal part and convert to minutes
            var decimalPart = hours - hoursInt;
            var minutes = Math.round(decimalPart * 60);
            
            // Handle case where rounding minutes gives 60 (should roll over to next hour)
            if (minutes >= 60) {
                hoursInt += 1;
                minutes = 0;
            }
            
            // Format as HH:MM (pad minutes with leading zero if needed)
            return hoursInt + ':' + (minutes < 10 ? '0' : '') + minutes;
        }

        // Added by Gauri - Set profitability report flag and fetch data
        var reportFlag = 1;      
        function setProfitabilityFlag(flag) {
            reportFlag = flag;
            getProjectProfitabilityList();
        }

        // Added by Gauri - Load Reporting From dropdown with period data
        var lastReportingFromVal = null;
        function getProjectProfitabilityReportingFromDate() {
            var $from = $('#ProjectProfitPeriodFrom');

            if (!defaultProjectID || defaultProjectID <= 0) {
                $from.empty().append('<option value="">Select Reporting From</option>').selectpicker('refresh');
                return;
            }

            var result = AJAXCallWithResult("api/ProjectProfitability/GetProjectProfitabilityPeriods",
                JSON.stringify({ projectID: defaultProjectID, whichDate: "F" }), false);

            if (typeof result === "string") { try { result = JSON.parse(result); } catch(e){ result = {}; } }

            var periods = result?.data?.ProjectProfitabilityPeriodsResponse || result?.ProjectProfitabilityPeriodsResponse || [];
            if (!Array.isArray(periods)) periods = [];

            $from.empty();

            // If API already sends "Select Reporting From" row, keep it, else add it.
            var hasSelectRow = periods.some(p => (p?.id || '').toLowerCase().includes('select'));
            if (!hasSelectRow) $from.append('<option value="">Select Reporting From</option>');

            $.each(periods, function (_, p) {
                var val = p.id || p.period || '';
                var txt = p.period || p.id || val;
                $from.append($('<option/>', { value: val, text: txt }));
            });

            $from.selectpicker('refresh');

            var firstDateVal = $('#ProjectProfitPeriodFrom').val();
            firstDateVal = (firstDateVal && !isNaN(Date.parse(firstDateVal))) ? firstDateVal : null;

            if (firstDateVal) {
                lastReportingFromVal = firstDateVal;
                bindReportingToByFrom(firstDateVal);   // auto bind To
                initReportingDates(false);             // set reportingFromDate/reportingToDate + refresh tab
            }
            if (firstDateVal == null) {
                getProjectProfitabilityReportingToDate(firstDateVal);
            }
        }

        $(document).on('changed.bs.select', '#ProjectProfitPeriodFrom', function () {
            var fromVal = $(this).val();
            if (!fromVal) return;

            // Call init after To is auto selected
            initReportingDates(true);
        });


        var previousToDate = null;
        $(document).on('changed.bs.select', '#ProjectProfitToPeriodTo', function () {

            
            // User manually changed To → just refresh data, DO NOT auto-select again
            if (isAutoSelectingToDate) return;
            var fromRaw = ($('#ProjectProfitPeriodFrom').val() || '').trim();
            var toRaw = ($('#ProjectProfitToPeriodTo').val() || '').trim();

            fromRaw = toISODate(fromRaw);
            toRaw = toISODate(toRaw);

            if (fromRaw && toRaw && fromRaw > toRaw) {
                alertify.error('<%=MyBase.GetResourceString("A_RepDateValid")%>');

                //$('#ProjectProfitToPeriodTo')
                //    .selectpicker('val', previousToDate)
                //    .selectpicker('refresh');

                getProjectProfitabilityList();
                getFinancialPerformanceGraph();
                
                // Refresh the currently active tab's data when date range changes
                refreshActiveTabData();

                previousToDate = ($('#ProjectProfitToPeriodTo').val() || '').trim();
                return false;
            }


            if (fromRaw == null && toRaw != null) {
               alertify.error('<%=MyBase.GetResourceString("A_PlzDateRange")%>');

                 $('#ProjectProfitToPeriodTo')
                     .selectpicker('val', previousToDate)
                     .selectpicker('refresh');

                 //getProjectProfitabilityList();
                 //getFinancialPerformanceGraph();

                 //// Refresh the currently active tab's data when date range changes
                 //refreshActiveTabData();

                 previousToDate = ($('#ProjectProfitToPeriodTo').val() || '').trim();
                 return false;
             }

            previousToDate = ($('#ProjectProfitToPeriodTo').val() || '').trim();
            getProjectProfitabilityList();
            getFinancialPerformanceGraph();
            
            // Refresh the currently active tab's data when date range changes
            refreshActiveTabData();
            
        });

        // Added by Gauri - Load Reporting To dropdown with period data
        function getProjectProfitabilityReportingToDate(selectedFromVal) {
            if (!defaultProjectID || defaultProjectID <= 0) {
                $('#ProjectProfitToPeriodTo')
                    .empty()
                    .append('<option value="">Select Reporting To</option>')
                    .selectpicker('refresh');
                return;
            }

            // 1) Bind full list (existing API)
            var param = { projectID: defaultProjectID, whichDate: "T" };
            var result = AJAXCallWithResult("api/ProjectProfitability/GetProjectProfitabilityPeriods", JSON.stringify(param), false);

            if (typeof result === "string") {
                try { result = JSON.parse(result); } catch (e) { result = null; }
            }

            var periods = result?.data?.ProjectProfitabilityPeriodsResponse || [];
            var $to = $('#ProjectProfitToPeriodTo');
            $to.empty();

            // Bind dropdown
            if (Array.isArray(periods) && periods.length > 0) {
                $.each(periods, function (i, item) {
                    var value = item.id || '';
                    var text  = item.period || value;
                    $to.append($('<option/>', { value: value, text: text }));
                });
            } else {
                $to.append('<option value="">No periods available</option>');
                $to.selectpicker('refresh');
                return;
            }

            $to.selectpicker('refresh');

            // 2) If From date is available → get recommended ToDate & auto-set it

            // Make it safe
            selectedFromVal = (selectedFromVal == null) ? '' : String(selectedFromVal);

            // Convert "Select Reporting From" to null
            if (selectedFromVal.trim().toLowerCase() === 'select reporting from') {
                selectedFromVal = null;
            }
            if (selectedFromVal) {
                bindToDateFirstAndSelect(selectedFromVal);
            }
        }

        function normalizeDateText(s) {
            return String(s || '')
                .toLowerCase()
                .replace(/[^a-z0-9]/g, ''); // removes spaces, hyphens, etc.
        }

        // Added by Gauri - Flag to avoid re-entrance when auto-selecting To date
        function bindToDateFirstAndSelect(fromVal) {
            var fromISO = toISODate(fromVal) || fromVal;

            var res = AJAXCallWithResult(
                "api/ProjectProfitability/GetProjectProfitabilityToDate",
                JSON.stringify({ projectID: defaultProjectID, fromDate: fromISO }),
                false
            );

            if (typeof res === "string") { try { res = JSON.parse(res); } catch (e) { res = {}; } }

            var toISO = res?.data?.result?.[0]?.toDate;     // "2025-11-30T00:00:00"
            if (!toISO) return;

            var toText = formatDateDDMMMYYYY(toISO);        // "30 Nov 2025" (or similar)
            var key = normalizeDateText(toText);

            var $to = $('#ProjectProfitToPeriodTo');

            // 1) Find all matching options (by text or value, ignoring hyphen/space differences)
            var $matches = $to.find('option').filter(function () {
                var txt = normalizeDateText($(this).text());
                var val = normalizeDateText($(this).val());
                return (txt === key || val === key);
            });

            // 2) If not found, then add ONCE (only in real missing case)
            if ($matches.length === 0) {
                // keep value same format as dropdown usually stores (often "30-Nov-2025")
                // if your dropdown expects dd-MMM-yyyy, make it like that:
                var ddMMM = moment ? moment(toISO).format('DD-MMM-YYYY') : toText; 
                $to.append($('<option/>', { value: ddMMM, text: toText }));
                $matches = $to.find('option').filter(function () {
                    return normalizeDateText($(this).text()) === key || normalizeDateText($(this).val()) === key;
                });
            }

            // 3) Dedupe: keep first, remove others
            var $keep = $matches.first();
            $matches.not($keep).remove();

            // 4) Move kept option just below the "Select Reporting To"
            var $first = $to.find('option').first();
            if ($first.length) {
                $keep.detach().insertAfter($first);
            }

            // 5) Select it
            isAutoSelectingToDate = true;
            $to.selectpicker('refresh');
            $to.selectpicker('val', $keep.val());
            isAutoSelectingToDate = false;

            // update global
            reportingToDate = toISODate($to.val());
        }

        // Added by Gauri - Fetch Project Profitability List (Periodic/Detailed/Cumulative)
        function getProjectProfitabilityList() {
            
            reportingFromDate = ($('#ProjectProfitPeriodFrom').val() || '').trim();
            reportingToDate = ($('#ProjectProfitToPeriodTo').val() || '').trim();

            // Treat placeholder text as NULL
            if (reportingFromDate === 'Select Date Range From') {
                reportingFromDate = null;
            }

            if (reportingToDate === 'Select Date Range To') {
                reportingToDate = null;
            }


            // Convert to ISO (yyyy-MM-dd)
            if (reportingFromDate) {
                const from = new Date(reportingFromDate);
                reportingFromDate = from.getFullYear() + '-' +
                    String(from.getMonth() + 1).padStart(2, '0') + '-' +
                    String(from.getDate()).padStart(2, '0');
            }

            if (reportingToDate) {
                const to = new Date(reportingToDate);
                reportingToDate = to.getFullYear() + '-' +
                    String(to.getMonth() + 1).padStart(2, '0') + '-' +
                    String(to.getDate()).padStart(2, '0');
            }

            var param = {
                projectID: defaultProjectID,
                fromDate: reportingFromDate,
                toDate: reportingToDate,
                reportFlag: reportFlag
            };

            var url = "api/ProjectProfitability/GetProjectProfitability";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            toggleProfitabilityGenerateMessage(result);

            // For Periodic View
            if (reportFlag == 1) {
                if (typeof result === "string") {
                    try { result = JSON.parse(result); }
                    catch (e) { console.error("Invalid JSON:", result); result = {}; }
                }

                // rcgPreparedData = buildRCGData(result);
                // if (rcgPreparedData) {
                //     initRCGToggle();   // first time init
                // }

                buildRCGData();
                var data = result?.projectProfitability?.ProjectProfitabilityPeriodicResponse;
                if (!Array.isArray(data)) data = [];

                // Format asOn dates from "25 11 Nov 30" to "25 Nov 30"
                data.forEach(function(row) {
                    if (row.asOn) {
                        row.asOn = formatAsOnDate(row.asOn);
                    }
                });

                var $tbody = $('#ProjProfPeriodicTable tbody');
                var $tfoot = $('#ProjProfPeriodicTable tfoot');
                $tbody.empty();

                var gtRevenuePeople = 0, gtRevenueOther = 0, gtRevenueTotal = 0;
                var gtPeopleCost = 0, gtDirectCost = 0, gtCostTotal = 0;
                var gtGPM = 0, gtInvoiced = 0, gtHours = 0;

                if (data.length === 0) {
                    // Show "no data" message
                    $tbody.append(`<tr><td colspan="10" class="text-center text-muted">No data available in table</td></tr>`);
                    // Clear Grand Total row so it is not displayed when there is no data
                    $tfoot.find('#GrandTotalPeriodicView').html('');
                    return;
                }

                $.each(data, function (i, row) {
                    // Preserve original asOn (from API) so we can derive period range for offcanvas popups
                    if (row.asOn) {
                        row.asOnRaw = row.asOn;
                        row.asOn = formatAsOnDate(row.asOn);
                    }
                    var revenuePeople = row.periodicAccruedResourceBillingTotal || 0;
                    var revenueOther = row.periodicBillableOtherCostTotal || 0;
                    var revenueTotal = row.periodicTotalAccruedRevenue || 0;

                    var peopleCost = row.periodicPeopleCosts || 0;
                    var directCost = row.periodicDirectCost || 0;
                    var costTotal = row.periodicTotalAccruedCost || 0;

                    var gpm = row.periodicGPM_Project || 0;
                    var invoiced = row.periodicInvoiceBillingTotal || 0;
                    var hours = row.periodicActualHoursTotal || 0;

                    var gpmClass = gpm >= 0 ? 'text-success' : 'textRed';

                    $tbody.append(`
                        <tr data-fromdate="${row.fromDate || ''}" data-ason="${row.asOnRaw || ''}">
                            <td>${row.asOn || 'N/A'}</td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount AccruedRevenueBtn p-0" data-costflag="${isFixedBidProject ? 'MILESTONE_REVENUE' : 'ACTUALCOST'}">                                
                                    ${formatINR(revenuePeople)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount AccBillableExpensesBtn p-0" data-costflag="BILLABLE_EXPENSES">
                                    ${formatINR(revenueOther)}
                                </button>
                            </td> 
                            <td>${formatINR(revenueTotal)}</td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount PeopleCostBtn p-0" data-costflag="PEOPLECOSTS">
                                    ${formatINR(peopleCost)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount ExpDirectPeopleCostBtn p-0" data-costflag="EXPENSES">
                                    ${formatINR(directCost)}
                                </button>
                            </td>
                            <td>${formatINR(costTotal)}</td>
                            <td class="${gpmClass}">${formatINR(gpm)}</td>
                            <td>${formatINR(invoiced)}</td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount ActualHoursBtn p-0" data-costflag="ACTUALHOURS">
                                    ${formatHours(hours)}
                                </button>
                            </td>
                        </tr>
                    `);

                    gtRevenuePeople += revenuePeople;
                    gtRevenueOther += revenueOther;
                    gtRevenueTotal += revenueTotal;

                    gtPeopleCost += peopleCost;
                    gtDirectCost += directCost;
                    gtCostTotal += costTotal;

                    gtGPM += gpm;
                    gtInvoiced += invoiced;
                    gtHours += hours;
                });

                $tfoot.find('#GrandTotalPeriodicView').html(`
                    <td>Grand Total</td>
                    <td>${formatINR(gtRevenuePeople)}</td>
                    <td>${formatINR(gtRevenueOther)}</td>
                    <td>${formatINR(gtRevenueTotal)}</td>
                    <td>${formatINR(gtPeopleCost)}</td>
                    <td>${formatINR(gtDirectCost)}</td>
                    <td>${formatINR(gtCostTotal)}</td>
                    <td class="${gtGPM >= 0 ? 'text-success' : 'textRed'}">${formatINR(gtGPM)}</td>
                    <td>${formatINR(gtInvoiced)}</td>
                    <td>${formatHours(gtHours)}</td>
                `);
            }
            // For Detailed View
            else if (reportFlag == 2) {

                // Parse string response if needed
                if (typeof result === "string") {
                    try { result = JSON.parse(result); }
                    catch (e) { console.error("Invalid JSON:", result); result = {}; }
                }

                var data = result?.projectProfitability?.ProjectProfitabilityDetailedResponse;
                if (!Array.isArray(data)) data = [];

                var $tbody = $('#ProjProfDetailedTable tbody');
                var $tfoot = $('#GrandTotalDetailedView');

                $tbody.empty();

                // ---- Grand totals ----
                var gtPH = 0, gtCH = 0;
                var gtPP = 0, gtCP = 0;
                var gtPD = 0, gtCD = 0;
                var gtPR = 0, gtCR = 0;
                var gtPO = 0, gtCO = 0;
                var gtPG = 0, gtCG = 0;
                var gtPI = 0, gtCI = 0;

                if (data.length === 0) {
                    $tbody.append(`<tr><td colspan="15" class="text-center text-muted">No data available in table</td></tr>`);
                    return;
                }

                $.each(data, function (i, row) {
                    // Preserve original date (asOn or reportingDate) for period calculation in offcanvas
                    var dateForPeriod = row.asOn || row.reportingDate || '';
                    $tbody.append(`
                        <tr data-fromdate="${row.fromDate || ''}" data-ason="${dateForPeriod}">
                            <td>${formatDateDDMMMYYYY(row.reportingDate) || ''}</td>

                            <td>
                                <button type="button" class="btn btn-link linkAmount ActualHoursBtn p-0" data-costflag="ACTUALHOURS">
                                    ${formatHours(row.periodicActualHoursTotal)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount ActualHoursBtn p-0" data-costflag="CUMULATIVE_ACTUALHOURS">
                                    ${formatHours(row.cumulativeActualHoursTotal)}
                                </button>
                            </td>

                            <td>
                                <button type="button" class="btn btn-link linkAmount PeopleCostBtn p-0" data-costflag="PEOPLECOSTS">
                                    ${formatINR(row.periodicPeopleCosts)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount PeopleCostBtn p-0" data-costflag="CUMULATIVE_PEOPLECOSTS">
                                    ${formatINR(row.cumulativePeopleCosts)}
                                </button>
                            </td>

                            <td>
                                <button type="button" class="btn btn-link linkAmount ExpDirectPeopleCostBtn p-0" data-costflag="EXPENSES">
                                    ${formatINR(row.periodicDirectCost)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount ExpDirectPeopleCostBtn p-0" data-costflag="CUMULATIVE_EXPENSES">
                                    ${formatINR(row.cumulativeDirectCost)}
                                </button>
                            </td>

                            <td>
                                <button type="button" class="btn btn-link linkAmount AccruedRevenueBtn p-0" data-costflag="${isFixedBidProject ? 'MILESTONE_REVENUE' : 'ACTUALCOST'}">
                                    ${formatINR(row.periodicAccruedResourceBillingTotal)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount AccruedRevenueBtn p-0" data-costflag="${isFixedBidProject ? 'CUMULATIVE_MILESTONE_REVENUE' : 'CUMULATIVE_ACTUALCOST'}">
                                    ${formatINR(row.cumulativeAccruedResourceBillingTotal)}
                                </button>
                            </td>
                            
                            <td>
                                <button type="button" class="btn btn-link linkAmount AccBillableExpensesBtn p-0" data-costflag="BILLABLE_EXPENSES">
                                    ${formatINR(row.periodicBillableOtherCostTotal)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount AccBillableExpensesBtn p-0" data-costflag="CUMULATIVE_BILLABLE_EXPENSES">
                                    ${formatINR(row.cumulativeBillableOtherCostTotal)}
                                </button>
                            </td>

                            <td class="${row.periodicAccruedGPM >= 0 ? 'text-success' : 'textRed'}">
                                ${formatINR(row.periodicAccruedGPM)}
                            </td>
                            <td class="${row.cumulativeAccruedGPM >= 0 ? 'text-success' : 'textRed'}">
                                ${formatINR(row.cumulativeAccruedGPM)}
                            </td>

                            <td>${formatINR(row.periodicInvoicedRevenue)}</td>
                            <td>${formatINR(row.cumulativeInvoicedRevenue)}</td>
                        </tr>
                    `);

                    // ---- accumulate totals ----
                    gtPH += row.periodicActualHoursTotal || 0;
                    gtCH += row.cumulativeActualHoursTotal || 0;

                    gtPP += row.periodicPeopleCosts || 0;
                    gtCP += row.cumulativePeopleCosts || 0;

                    gtPD += row.periodicDirectCost || 0;
                    gtCD += row.cumulativeDirectCost || 0;

                    gtPR += row.cumulativeAccruedResourceBillingTotal || 0;
                    gtCR += row.cumulativeAccruedResourceBillingTotal || 0;

                    gtPO += row.periodicBillableOtherCostTotal || 0;
                    gtCO += row.cumulativeBillableOtherCostTotal || 0;

                    gtPG += row.periodicAccruedGPM || 0;
                    gtCG += row.cumulativeAccruedGPM || 0;

                    gtPI += row.periodicInvoicedRevenue || 0;
                    gtCI += row.cumulativeInvoicedRevenue || 0;
                });

                // ---- Footer ----
                $tfoot.html(`
                    <td>Grand Total</td>

                    <td>${formatHours(gtPH)}</td>
                    <td>${formatHours(gtCH)}</td>

                    <td>${formatINR(gtPP)}</td>
                    <td>${formatINR(gtCP)}</td>

                    <td>${formatINR(gtPD)}</td>
                    <td>${formatINR(gtCD)}</td>

                    <td>${formatINR(gtPR)}</td>
                    <td>${formatINR(gtCR)}</td>

                    <td>${formatINR(gtPO)}</td>
                    <td>${formatINR(gtCO)}</td>

                    <td class="${gtPG >= 0 ? 'text-success' : 'textRed'}">${formatINR(gtPG)}</td>
                    <td class="${gtCG >= 0 ? 'text-success' : 'textRed'}">${formatINR(gtCG)}</td>

                    <td>${formatINR(gtPI)}</td>
                    <td>${formatINR(gtCI)}</td>
                `);
            }
            // For Cumulative View
            else if (reportFlag == 3) {

                // Parse string response
                if (typeof result === "string") {
                    try { result = JSON.parse(result); }
                    catch (e) { console.error("Invalid JSON:", result); result = {}; }
                }

                var data = result?.projectProfitability?.ProjectProfitabilityCumulativeResponse;
                if (!Array.isArray(data)) data = [];

                var $tbody = $('#ProjProfCumulativeTable tbody');
                var $tfoot = $('#GrandTotalCumulView');

                $tbody.empty();

                // ---- Grand totals ----
                var gtRevPeople = 0, gtRevOther = 0, gtRevTotal = 0;
                var gtPeopleCost = 0, gtDirectCost = 0, gtCostTotal = 0;
                var gtGPM = 0, gtInvoice = 0, gtHours = 0;

                if (data.length === 0) {
                    $tbody.append(`<tr><td colspan="10" class="text-center text-muted">No data available in table</td></tr>`);
                    return;
                }

                $.each(data, function (i, row) {
                    // Preserve original asOn (from API) so we can derive period range for offcanvas popups
                    var asOnRaw = row.asOn || '';

                    var revPeople = row.cumulativeAccruedRevenue || 0;
                    var revOther = row.cumulativeBillableOtherCostTotal || 0;
                    var revTotal = row.cumulativeTotalAccruedRevenue || 0;

                    var peopleCost = row.cumulativePeopleCosts || 0;
                    var directCost = row.cumulativeDirectCost || 0;
                    var costTotal = row.cumulativeTotalAccruedCost || 0;

                    var gpm = row.cumulativeGPM_Project || 0;
                    var invoice = row.cumulativeInvoiceBillingTotal || 0;
                    var hours = row.cumulativeActualHoursTotal || 0;

                    var gpmClass = gpm >= 0 ? 'text-success' : 'textRed';

                    $tbody.append(`
                        <tr data-fromdate="${row.fromDate || ''}" data-ason="${asOnRaw}">
                            <td>${formatDateDDMMMYYYY(row.asOn) || ''}</td>

                            <td>
                                <button type="button" class="btn btn-link linkAmount AccruedRevenueBtn p-0" data-costflag="${isFixedBidProject ? 'CUMULATIVE_MILESTONE_REVENUE' : 'CUMULATIVE_ACTUALCOST'}">
                                    ${formatINR(revPeople)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount AccBillableExpensesBtn p-0" data-costflag="CUMULATIVE_BILLABLE_EXPENSES">
                                    ${formatINR(revOther)}
                                </button>
                            </td>
                            
                            <td>${formatINR(revTotal)}</td>

                            <td>
                                <button type="button" class="btn btn-link linkAmount PeopleCostBtn p-0" data-costflag="CUMULATIVE_PEOPLECOSTS">
                                    ${formatINR(peopleCost)}
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount ExpDirectPeopleCostBtn p-0" data-costflag="CUMULATIVE_EXPENSES">
                                    ${formatINR(directCost)}
                                </button>
                            </td>
                            <td>${formatINR(costTotal)}</td>

                            <td class="${gpmClass}">${formatINR(gpm)}</td>
                            <td>${formatINR(invoice)}</td>
                            <td>
                                <button type="button" class="btn btn-link linkAmount ActualHoursBtn p-0" data-costflag="CUMULATIVE_ACTUALHOURS">
                                    ${formatHours(hours)}
                                </button>
                            </td>
                        </tr>
                    `);

                    // ---- accumulate totals ----
                    gtRevPeople += revPeople;
                    gtRevOther += revOther;
                    gtRevTotal += revTotal;

                    gtPeopleCost += peopleCost;
                    gtDirectCost += directCost;
                    gtCostTotal += costTotal;

                    gtGPM += gpm;
                    gtInvoice += invoice;
                    gtHours += hours;
                });

                // ---- Footer ----
                $tfoot.html(`
                    <td>Grand Total</td>
                    <td>${formatINR(gtRevPeople)}</td>
                    <td>${formatINR(gtRevOther)}</td>
                    <td>${formatINR(gtRevTotal)}</td>
                    <td>${formatINR(gtPeopleCost)}</td>
                    <td>${formatINR(gtDirectCost)}</td>
                    <td>${formatINR(gtCostTotal)}</td>
                    <td class="${gtGPM >= 0 ? 'text-success' : 'textRed'}">${formatINR(gtGPM)}</td>
                    <td>${formatINR(gtInvoice)}</td>
                    <td>${formatHours(gtHours)}</td>
                `);
            }
        }

        // Added by Gauri - Toggle Generate / Re-generate message in Project Details section
        function toggleProfitabilityGenerateMessage(result) {
            var rows = result?.projectProfitability?.ProjectProfitabilityPeriodicResponse;

            var hasData = Array.isArray(rows) && rows.length > 0;

            var $container = $('#profitabilityNoData');
            var $link = $('#profitabilityGenerateLink');

            // CASE 1: Reporting dates NOT selected → hide completely
            if (!reportingFromDate || !reportingToDate) {
                $container.addClass('d-none');
                $link.text('').removeData('action');
                return;
            }


           // CASE 2: From date is greater than To date → hide completely
            if (reportingFromDate > reportingToDate) {
                $container.addClass('d-none');
                $link.text('').removeData('action');
                return;
            }

            if (!hasData && !reportingFromDate && !reportingToDate) {
                // No data - Generate
                $container.removeClass('d-none');
                $link.text('<%=MyBase.GetResourceString("C_GenTxt")%>');
                $link.data('action', 'generate');
            } else {
                // Data exists - Re-generate
                $container.removeClass('d-none');
                $link.text('<%=MyBase.GetResourceString("C_ReGenTxt")%>');
                $link.data('action', 'regenerate');
            }
        }

        // Added by Gauri - Generate / Re-generate profitability data handler in Project Details section
        $(document).on('click', '#profitabilityGenerateLink', function () {
            var action = $(this).data('action');

            // Use current reporting period
            var fromDate = reportingFromDate;
            var toDate   = reportingToDate;

            if (!fromDate || !toDate) {
                return;
            }

            // 🔥 NORMALIZE DATE (kills Z / UTC / time issues)
            fromDate = new Date(fromDate).toISOString().split('T')[0];
            toDate = new Date(toDate).toISOString().split('T')[0];

            if (action === 'generate') {
                // call generate API
                getGenerateRegenerateData(fromDate, toDate,0);
            } else {
                // call re-generate API
                getGenerateRegenerateData(fromDate, toDate,0);
            }
        });

        // Added by Gauri - Fetch Gross Profit Margin (GPM) Trend Data
        function getGrossProfitMarginList() {
            var param = {
                projectID: defaultProjectID
            };

            var url = "api/ProjectProfitability/GetGPMTrend";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            var rows = result?.gpmTrend?.GPMTrendResponse;
            if (!Array.isArray(rows) || rows.length === 0) {
                // reset UI
                $('#gpmPeopleRevenue,#gpmBillableExpenses,#gpmTotalRevenue,#gpmPeopleCost,#gpmTelephoneExpense,#gpmTotalCost')
                    .text(formatINR(0));
                // Reset GPM \"as on\" date span to '-'
                $('#GPMAsOnDate').text('-');
                $('#gpmEquation').html('');
                $('#gpmPercent').text('0.00');
                return;
            }

            // take latest row (most recent toDate)
            rows.sort(function (a, b) { return new Date(b.toDate) - new Date(a.toDate); });
            var r = rows[0];

            var peopleRevenue = r.peopleRevenue || 0;
            var billableExp = r.accruedBillableExpenses || 0;
            var totalRevenue = r.total || (peopleRevenue + billableExp);

            var peopleCost = r.peopleCost || 0;
            var telExpense = r.cost || 0;              // API uses "cost" (keep telephone as this)
            var totalCost = r.totalCost || (peopleCost + telExpense);

            var gpmValue = totalRevenue - totalCost;
            var gpmPercent = totalRevenue !== 0 ? (gpmValue / totalRevenue) * 100 : 0;

            // update cards
            $('#gpmPeopleRevenue').text(formatINR(peopleRevenue));
            $('#gpmBillableExpenses').text(formatINR(billableExp));
            $('#gpmTotalRevenue').text(formatINR(totalRevenue));

            $('#gpmPeopleCost').text(formatINR(peopleCost));
            $('#gpmTelephoneExpense').text(formatINR(telExpense));
            $('#gpmTotalCost').text(formatINR(totalCost));

            // summary - bind API toDate to the UI span
            var asOn = formatDateDDMMMYYYY(r.toDate); // e.g., 30 Nov 2025
            $('#GPMAsOnDate').text(asOn);

            var gpmClass = gpmValue >= 0 ? 'text-success' : 'textRed';

            $('#gpmEquation').html(
                '<%=MyBase.GetResourceString("C_GPM")%> = ' + formatINR(totalRevenue) + ' - ' + formatINR(totalCost) +
                ' = <span class="' + gpmClass + '">(' + formatINR(gpmValue) + ')</span>'
            );

            $('#gpmPercent').text(gpmPercent.toFixed(2));
        }

        // Added by Gauri - Fetch Revenue Trend Data
        function getRevenueTrendList() {
            
            // Always send projectID
            //var param = {
            //    projectID: defaultProjectID
            //};

            reportingFromDate = ($('#ProjectProfitPeriodFrom').val() || '').trim();
            reportingToDate = ($('#ProjectProfitToPeriodTo').val() || '').trim();

            // Treat placeholder text as NULL
            if (reportingFromDate === 'Select Date Range From') {
                reportingFromDate = null;
            }

            if (reportingToDate === 'Select Date Range To') {
                reportingToDate = null;
            }

            // Convert to ISO (yyyy-MM-dd)
            if (reportingFromDate) {
                const from = new Date(reportingFromDate);
                reportingFromDate = from.getFullYear() + '-' +
                    String(from.getMonth() + 1).padStart(2, '0') + '-' +
                    String(from.getDate()).padStart(2, '0');
            }

            if (reportingToDate) {
                const to = new Date(reportingToDate);
                reportingToDate = to.getFullYear() + '-' +
                    String(to.getMonth() + 1).padStart(2, '0') + '-' +
                    String(to.getDate()).padStart(2, '0');
            }


            // Apply from/to date filter ONLY after user selects a reporting period
            if (revenueFilterEnabled && reportingFromDate && reportingToDate) {
                param.fromDate = reportingFromDate;
                param.toDate = reportingToDate;
            }


            var param = {
                projectID: defaultProjectID,
                fromDate: reportingFromDate,
                toDate: reportingToDate
               
            };


            var url = "api/ProjectProfitability/GetRevenueTrend";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            toggleProfitabilityGenerateMessage();
            // parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            var data = result?.revenueTrend?.RevenueTrendResponse;
            if (!Array.isArray(data)) data = [];

            var $tbody = $('#RevenueTrendTable tbody');
            $tbody.empty();

            if (data.length === 0) {
                $tbody.append(`<tr><td colspan="4" class="text-center text-muted">No data available in table</td></tr>`);
                return;
            }

            $.each(data, function (i, row) {
                $tbody.append(`
                    <tr>
                        <td>${formatDateDDMMMYYYY(row.asOn)}</td>
                        <td>${formatINR(row.accruedRevenue)}</td>
                        <td>${formatINR(row.invoicedRevenue)}</td>
                        <td>${formatINR(row.unbilledRevenue)}</td>
                    </tr>
                `);
            });
        }

        // Added by Gauri - Format date from "25 11 Nov 30" to "25 Nov 30"
        function formatAsOnDate(dateStr) {
            if (!dateStr) return '';
            // Trim whitespace
            dateStr = String(dateStr).trim();
            
            // Check if format is "DD MM MMM YY" (e.g., "25 11 Nov 30")
            // More flexible regex to handle multiple spaces and variations
            var match = dateStr.match(/^(\d{1,2})\s+(\d{1,2})\s+([A-Za-z]{3})\s+(\d{2})$/);
            if (match) {
                // Return "DD MMM YY" format (e.g., "25 Nov 30")
                return match[1] + ' ' + match[3] + ' ' + match[4];
            }
            
            // Try pattern with single spaces: "DD MM MMM YY"
            var matchSingleSpace = dateStr.match(/^(\d{1,2})\s(\d{1,2})\s([A-Za-z]{3})\s(\d{2})$/);
            if (matchSingleSpace) {
                return matchSingleSpace[1] + ' ' + matchSingleSpace[3] + ' ' + matchSingleSpace[4];
            }
            
            // Also try pattern without year if year is missing (fallback)
            var matchNoYear = dateStr.match(/^(\d{1,2})\s+(\d{1,2})\s+([A-Za-z]{3})$/);
            if (matchNoYear) {
                // Return "DD MMM" format (e.g., "25 Nov") - but we want year, so try to preserve if possible
                // If we can't find year, return without it
                return matchNoYear[1] + ' ' + matchNoYear[3];
            }
            
            // If format doesn't match, return as is
            return dateStr;
        }

        // Added by Gauri - Derive period (1st of month to asOn date) from GetProjectProfitability asOn value
        function getPeriodFromAsOn(asOnRaw) {
            if (!asOnRaw) return null;
                asOnRaw = String(asOnRaw).trim();
                var months = { jan: 0, feb: 1, mar: 2, apr: 3, may: 4, jun: 5, jul: 6, aug: 7, sep: 8, oct: 9, nov: 10, dec: 11 };
                var day, monthIndex, year;

                // 1) Current API format: "DD MMM YYYY" (e.g., "31 Dec 2025")
                var mCurrent = asOnRaw.match(/^(\d{1,2})\s+([A-Za-z]{3})\s+(\d{4})$/);
                if (mCurrent) {
                    day = parseInt(mCurrent[1], 10);
                    monthIndex = months[mCurrent[2].toLowerCase()];
                    year = parseInt(mCurrent[3], 10);
                } else {
                    // 2) Legacy format: "DD MM MMM YY" (e.g., "25 11 Nov 30")
                    var mLegacy = asOnRaw.match(/^(\d{1,2})\s+(\d{1,2})\s+([A-Za-z]{3})\s+(\d{2})$/);
                    if (mLegacy) {
                        day = parseInt(mLegacy[1], 10);
                        monthIndex = months[mLegacy[3].toLowerCase()];
                        var yy = parseInt(mLegacy[4], 10);
                        year = 2000 + yy; // assume 20xx
                    }
                }

                // If custom parsing failed, fallback to generic date parsing
                if (monthIndex === undefined || !year || !day) {
                    var iso = toISODate(asOnRaw);
                    if (!iso) return null;
                    var dFallback = new Date(iso);
                    if (isNaN(dFallback.getTime())) return null;

                    var fromFallback = new Date(Date.UTC(dFallback.getUTCFullYear(), dFallback.getUTCMonth(), 1, 0, 0, 0, 0));
                    return {
                        fromISO: fromFallback.toISOString(),
                        toISO: dFallback.toISOString(),
                        fromLabel: formatDateDDMMMYYYY(fromFallback.toISOString()),
                        toLabel: formatDateDDMMMYYYY(dFallback.toISOString())
                    };
                }

                var toDate = new Date(Date.UTC(year, monthIndex, day, 0, 0, 0, 0));
                var fromDate = new Date(Date.UTC(year, monthIndex, 1, 0, 0, 0, 0));

                return {
                    fromISO: fromDate.toISOString(),
                    toISO: toDate.toISOString(),
                    fromLabel: formatDateDDMMMYYYY(fromDate.toISOString()),
                    toLabel: formatDateDDMMMYYYY(toDate.toISOString())
                };
        }

        // Added by Gauri - Profitability SnapShot Tab Staus Column UI
        function getSnapshotStatusUI(status) {
            // Adjust this mapping to match your actual backend codes
            if (status === 0) {
                return {
                    cls: "status-pending",
                    // html: `<span class="dot"></span><i class="fas fa-clock status-icon"></i>Pending`,
                    html: `<i class="far fa-clock status-icon me-1"></i>Pending`,
                    action: null
                };
            }
            if (status === 1) {
                return {
                    cls: "status-regenerate",
                    html: `<i class="fas fa-sync-alt status-icon me-1"></i><a href="javascript:;" class="linkStatus refreshButton">Re-Generate</a>`,
                    action: "regenerate"
                };
            }
            // default to Re-Generate
            return {
                cls: "status-generate",
                html: `<i class="fas fa-redo-alt status-icon me-1"></i><a href="javascript:;" class="linkStatus refreshButton">Generate</a>`,
                action: "generate"
            };
        }

        // Added by Gauri - Profitability SnapShot Tab List view
        function getProfitabilitySnapShotList() {
            var param = {
                projectID: defaultProjectID
            };

            var url = "api/ProjectProfitability/GetProjectSnapshots";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            toggleProfitabilityGenerateMessage();

            // parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            var rows = result?.snapshots?.SnapshotTrendResponse;
            if (!Array.isArray(rows)) rows = [];

            var $tbody = $('#ProfitabilitySnapshotsTable tbody');
            $tbody.empty();

            if (rows.length === 0) {
                $tbody.append(`<tr><td colspan="3" class="text-center text-muted">No data available in table</td></tr>`);
                return;
            }

            // optional: sort by toDate descending (latest first)
            rows.sort(function (a, b) { return new Date(b.toDate) - new Date(a.toDate); });

            // all status = 0?
            var allPending = rows.length > 0 && rows.every(function (x) { return x.status === 0; });

            for (var i = 0; i < rows.length; i++) {
                var r = rows[i];
                var next = (i + 1 < rows.length) ? rows[i + 1] : null;

                var statusUI;

                // Rule A: If all are pending, show Generate ONLY on last record (oldest)
                if (allPending && i === rows.length - 1) {
                    statusUI = {
                        cls: "status-generate",
                        html: `<i class="fas fa-redo-alt status-icon me-1"></i><a href="javascript:;" class="linkStatus refreshButton">Generate</a>`,
                        action: "generate"
                    };
                }
                // Rule B: your existing rule (optional)
                else if (r.status === 0 && next && next.status === 1) {
                    statusUI = {
                        cls: "status-generate",
                        html: `<i class="fas fa-redo-alt status-icon me-1"></i><a href="javascript:;" class="linkStatus refreshButton">Generate</a>`,
                        action: "generate"
                    };
                }
                else {
                    statusUI = getSnapshotStatusUI(r.status);
                }

                var genDate = r.generatedDate ? new Date(r.generatedDate) : null;
                var toDate  = r.toDate ? new Date(r.toDate) : null;

                // default = red
                var genDateClass = 'textRed';

                // green only if generatedDate > toDate
                if (genDate && toDate && genDate > toDate) {
                    genDateClass = 'text-success';
                } else if(!genDate) {
                    genDateClass = '';
                }

                 //<span class="status-pill d-inline-flex align-items-center ${statusUI.cls} generateStatusClick"
                                    //    style="cursor: pointer;"
                                    //    data-fromdate="${r.fromDate}"
                                    //    data-todate="${r.toDate}">
                                    //    ${statusUI.html}
                                    //</span>


                var clickableClass = statusUI.action ? ' generateStatusClick' : '';
                var clickableStyle = statusUI.action ? 'cursor: pointer;' : 'cursor: default;';
                var dataAttrs = statusUI.action
                    ? `data-fromdate="${r.fromDate}" data-todate="${r.toDate}"`
                    : '';

                // Added by Gauri - Conditional rendering of status UI on 27 Jan 2026
                $tbody.append(`
                    <tr data-profitabilityid="${r.projectProfitabilityID}" data-action="${statusUI.action || ''}">
                        <td>${formatDateDDMMMYYYY(r.fromDate)}</td>
                        <td>${formatDateDDMMMYYYY(r.toDate)}</td>
                        <td class="${genDateClass}">${formatDateDDMMMYYYY(r.generatedDate) || '-'}</td>
                        <td>
                            <div class="d-flex justify-content-center">
                                <% If m_blnAddAccess Or m_blnEditAccess Then %>
                                <div class="prof_Status">
                                   

                            <span class="status-pill d-inline-flex align-items-center ${statusUI.cls}${clickableClass}"
                                                      style="${clickableStyle}"
                                                      ${dataAttrs}>
                                                    ${statusUI.html}
                                                </span>

                                </div>
                                <% End If %>
                            </div>
                        </td>
                    </tr>
                `);
            }

        }

        // Added by Gauri - Profitability SnapShot Tab Generate / Re-generate click handler
        $(document).on('click', '.generateStatusClick',function (e) {
            e.preventDefault();
            e.stopPropagation();

            var $tr = $(this).closest('.generateStatusClick');
            var fromDate = $tr.attr('data-fromdate');
            var toDate   = $tr.attr('data-todate');

            getGenerateRegenerateData(fromDate, toDate,0);
        });

        // Added by Gauri - Generate / Re-generate profitability data API call
        function getGenerateRegenerateData(fromDate, toDate, flag) {
            showLoader();

            // Allow browser to paint loader BEFORE sync AJAX
            setTimeout(function () {
                var param = {
                    projectID: defaultProjectID,
                    fromDate: fromDate || null,
                    toDate: toDate || null,
                    DtFlag: flag
                };

                var url = "api/ProjectProfitability/GenerateProjProfi";
                var result = AJAXCallWithResult(url, JSON.stringify(param), false);

                // Parse if response is string
                if (typeof result === "string") {
                    try {
                        result = JSON.parse(result);
                    } catch (e) {
                        console.error("Invalid JSON response:", result);
                        hideLoader();
                        return;
                    }
                }

                // If API returned message → refresh related UI
                if (result && result.message) {
                    // 1) Refresh snapshot list (bottom tab)
                    getProfitabilitySnapShotList();
                    // Added by Gauri Reporting From Date refresh on 27 Jan 2026
                    getProjectProfitabilityReportingFromDate();  

                    // 2) Refresh Project Profitability list (top tab)
                    //    This will re-evaluate data availability and update
                    //    the "generate / re-generate the data" link text.
                    if (reportingFromDate && reportingToDate) {
                        getProjectProfitabilityList();
                    }
                }

                // Hide loader AFTER everything is done
                hideLoader();
            }, 0);
        }

        // Added by Gauri - Cost Trend Tab List view
        function getCostTrendList() {
            // Always send projectID
            //var param = {
            //    projectID: defaultProjectID
            //};

            reportingFromDate = ($('#ProjectProfitPeriodFrom').val() || '').trim();
            reportingToDate = ($('#ProjectProfitToPeriodTo').val() || '').trim();

            // Treat placeholder text as NULL
            if (reportingFromDate === 'Select Date Range From') {
                reportingFromDate = null;
            }

            if (reportingToDate === 'Select Date Range To') {
                reportingToDate = null;
            }


            // Convert to ISO (yyyy-MM-dd)
            if (reportingFromDate) {
                const from = new Date(reportingFromDate);
                reportingFromDate = from.getFullYear() + '-' +
                    String(from.getMonth() + 1).padStart(2, '0') + '-' +
                    String(from.getDate()).padStart(2, '0');
            }

            if (reportingToDate) {
                const to = new Date(reportingToDate);
                reportingToDate = to.getFullYear() + '-' +
                    String(to.getMonth() + 1).padStart(2, '0') + '-' +
                    String(to.getDate()).padStart(2, '0');
            }

            // Apply from/to date filter ONLY after user selects a reporting period
            if (costFilterEnabled && reportingFromDate && reportingToDate) {
                param.fromDate = reportingFromDate;
                param.toDate   = reportingToDate;
            }

            var param = {
                projectID: defaultProjectID,
                fromDate: reportingFromDate,
                toDate: reportingToDate

            };

            var url = "api/ProjectProfitability/GetCostTrend";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            toggleProfitabilityGenerateMessage();

            // Parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            var data = result?.costTrend?.CostTrendResponse;
            if (!Array.isArray(data)) data = [];

            var $tbody = $('#CostTrendsTable tbody');
            $tbody.empty();

            if (data.length === 0) {
                $tbody.append(`<tr><td colspan="4" class="text-center text-muted">No data available in table</td></tr>`);
                return;
            }

            $.each(data, function (i, row) {
                var resourceCost = row.resourceCost || 0;
                var travelExpense = row.travelAllowance || 0; // not in API yet → defaults to 0
                var totalCost = row.totalCost || (resourceCost + travelExpense);

                $tbody.append(`
                    <tr>
                        <td>${formatDateDDMMMYYYY(row.asOn)}</td>
                        <td>${formatINR(resourceCost)}</td>
                        <td>${formatINR(travelExpense)}</td>
                        <td>${formatINR(totalCost)}</td>
                    </tr>
                `);
            });
        }

        $(document).on('click', '.AccruedRevenueBtn', function (e) {
            var costFlag = $(this).data('costflag'); // PERIODIC | CUMULATIVE
            defaultProjectName = getCurrentProjectName();

            // Show correct offcanvas
            var offcanvasId = isFixedBidProject ? 'offcanvasAccruedRevMilestone' : 'offcanvasAccruedRevenue';
            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById(offcanvasId));
            myOffcanvas.show();

            var $row = $(this).closest('tr');

            // get dates from row
            var asOnRaw = $row.data('ason');         // end date
            var rowFromDate = $row.data('fromdate'); // start date (NOTE: jQuery lowercases data keys)

            // Defaults (fallback)
            var fromDateISO = reportingFromDate;
            var toDateISO   = reportingToDate;

            // Use row dates if available
            if (rowFromDate) {
                // var isoFrom = toISODate(rowFromDate) || rowFromDate;
                var isoFrom = rowFromDate;
                fromDateISO = isoFrom;
            }
            if (asOnRaw) {
                // var isoTo = toISODate(asOnRaw) || asOnRaw;
                var isoTo = asOnRaw;
                toDateISO = isoTo;
            }

            // Update date labels (milestone vs regular)
            var fromLbl = formatDateDDMMMYYYY(fromDateISO);
            var toLbl   = formatDateDDMMMYYYY(toDateISO);

            if (isFixedBidProject) {
                $("#AccMilestone_StartDate").text(fromLbl);
                $("#AccMilestone_EndDate").text(toLbl);
            } else {
                $("#AccruedStartDate").text(fromLbl);
                $("#AccruedEndDate").text(toLbl);
            }

            $(".CurrentProjectName").text(defaultProjectName);

            var param = {
                projectID: defaultProjectID,
                fromDate: fromDateISO,
                toDate: toDateISO,
                costType: costFlag
            };

            var url = "api/ProjectProfitability/GetResourceProfitabilityDetails";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            // ✅ IMPORTANT: your API usually returns ResourceProfResponse array
            var rows = result?.resourceProfitabilityDetails?.ResourceProfResponse || result?.resourceProfitabilityDetails || [];
            if (!Array.isArray(rows)) rows = [];

            var tableId = isFixedBidProject ? '#AccRevMilestoneTable' : '#AccruedRevenueTable';
            var $tbody = $(tableId + ' tbody');
            $tbody.empty();

            if (rows.length === 0) {
                $tbody.append(`<tr><td colspan="2" class="text-center text-muted">No data available in table</td></tr>`);
                return;
            }

            var total = 0;

            $.each(rows, function (i, r) {
                var amount = r.resourceCost || r.milestoneCost || 0;
                total += amount;

                if (isFixedBidProject) {
                    $tbody.append(`
                        <tr>
                            <td>${r.mileStone || ''}</td>
                            <td class="text-center">${formatINR(r.milestoneCost || 0)}</td>
                        </tr>
                    `);
                } else {
                    $tbody.append(`
                        <tr>
                            <td>${r.employeeName || ''}</td>
                            <td class="text-center">${formatINR(amount)}</td>
                        </tr>
                    `);
                }
            });

            $tbody.append(`
                <tr class="fw-semibold">
                    <td>${isFixedBidProject ? 'Milestone Total' : 'Total'}</td>
                    <td class="text-center">${formatINR(total)}</td>
                </tr>
            `);
        });

        // Added by Gauri - Offcanvas People Cost button click
        $(document).on('click', '.PeopleCostBtn', function (e) {

            var costFlag = $(this).data('costflag'); // PERIODIC | CUMULATIVE
            defaultProjectName = getCurrentProjectName();

            var myOffcanvas = new bootstrap.Offcanvas(
                document.getElementById('offcanvasPeopleCost')
            );
            myOffcanvas.show();

            var $row = $(this).closest('tr');

            // ✅ Read dates directly from row
            var asOnRaw     = $row.data('ason');      // toDate
            var rowFromDate = $row.data('fromdate');  // fromDate

            // Defaults (fallback)
            var fromDateISO = reportingFromDate;
            var toDateISO   = reportingToDate;

            // ✅ Override with row-level dates
            if (rowFromDate) {
                fromDateISO = rowFromDate;
            }
            if (asOnRaw) {
                toDateISO = asOnRaw;
            }

            // ✅ Update date labels (NO getPeriodFromAsOn)
            var fromLabel = formatDateDDMMMYYYY(fromDateISO);
            var toLabel   = formatDateDDMMMYYYY(toDateISO);

            $("#PCostStartDate").text(fromLabel);
            $("#PCostEndDate").text(toLabel);

            $(".CurrentProjectName").text(defaultProjectName);

            var param = {
                projectID: defaultProjectID,
                fromDate: fromDateISO,
                toDate: toDateISO,
                costType: costFlag
            };

            var url = "api/ProjectProfitability/GetResourceProfitabilityDetails";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) {
                    console.error("Invalid JSON:", result);
                    result = {};
                }
            }

            // ✅ Correct rows extraction
            var rows =
                result?.resourceProfitabilityDetails?.ResourceProfResponse ||
                result?.resourceProfitabilityDetails ||
                [];

            if (!Array.isArray(rows)) rows = [];

            var $tbody = $('#PeopleCostTable tbody');
            $tbody.empty();

            if (rows.length === 0) {
                $tbody.append(`
                    <tr>
                        <td colspan="2" class="text-center text-muted">
                            No data available in table
                        </td>
                    </tr>
                `);
                return;
            }

            var total = 0;

            $.each(rows, function (i, r) {
                var amount = r.resourceCost || 0;
                total += amount;

                $tbody.append(`
                    <tr>
                        <td>${r.employeeName || ''}</td>
                        <td class="text-center">${formatINR(amount)}</td>
                    </tr>
                `);
            });

            $tbody.append(`
                <tr class="fw-semibold">
                    <td>Total</td>
                    <td class="text-center">${formatINR(total)}</td>
                </tr>
            `);
        });

        // Added by Gauri - OffcanvasActualHours button click
        $(document).on('click', '.ActualHoursBtn',function (e) {
            var costFlag = $(this).data('costflag'); // PERIODIC | CUMULATIVE
            defaultProjectName = getCurrentProjectName();

            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvasActualHours'));
            myOffcanvas.show();

            // Row dates
            var $row = $(this).closest('tr');
            var asOnRaw = $row.data('ason');       // toDate
            var rowFromDate = $row.data('fromdate'); // fromDate

            var fromDateISO = reportingFromDate;
            var toDateISO   = reportingToDate;

            // ✅ Use row dates if available
            if (rowFromDate) fromDateISO = rowFromDate;
            if (asOnRaw)     toDateISO   = asOnRaw;

            // ✅ Update labels using selected dates (no getPeriodFromAsOn)
            $("#Hrs_StartDate").text(formatDateDDMMMYYYY(fromDateISO));
            $("#Hrs_EndDate").text(formatDateDDMMMYYYY(toDateISO));

            $(".CurrentProjectName").text(defaultProjectName);
            
            var param = {
                projectID: defaultProjectID,
                fromDate: fromDateISO,
                toDate: toDateISO,
                costType: costFlag
            };

            var url = "api/ProjectProfitability/GetResourceProfitabilityDetails";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            var rows = result?.resourceProfitabilityDetails;
            if (!Array.isArray(rows)) rows = [];

            var $tbody = $('#ActualHoursTable tbody');
            $tbody.empty();

            if (rows.length === 0) {
                $tbody.append(`<tr><td colspan="2" class="text-center text-muted">No data available in table</td></tr>`);
                return;
            }

            var totalHours = 0;

            $.each(rows, function (i, r) {
                var hours = Number(r.resourceCost || 0); // API uses resourceCost, treat as hours
                totalHours += hours;

                $tbody.append(`
                    <tr>
                        <td>${r.employeeName || ''}</td>
                        <td class="text-center">${formatHours(hours)}</td>
                    </tr>
                `);
            });

            // Total row (keep your class name style)
            $tbody.append(`
                <tr class="font-weight-500">
                    <td>Total</td>
                    <td class="text-center">${formatHours(totalHours)}</td>
                </tr>
            `);
        });

        // Added by Gauri - OffcanvasAccBillableExpenses button click
        $(document).on('click', '.AccBillableExpensesBtn',function (e) {
            var costFlag = $(this).data('costflag'); // PERIODIC | CUMULATIVE
            defaultProjectName = getCurrentProjectName();

            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvasAccBillableExpenses'));
            myOffcanvas.show();

            // Row dates
            var $row = $(this).closest('tr');
            var asOnRaw = $row.data('ason');         // toDate
            var rowFromDate = $row.data('fromdate'); // fromDate

            var fromDateISO = reportingFromDate;
            var toDateISO   = reportingToDate;

            // ✅ Use row dates if available
            if (rowFromDate) fromDateISO = rowFromDate;
            if (asOnRaw)     toDateISO   = asOnRaw;

            // ✅ Update labels using selected dates (no getPeriodFromAsOn)
            $("#BilExp_StartDate").text(formatDateDDMMMYYYY(fromDateISO));
            $("#BilExp_EndDate").text(formatDateDDMMMYYYY(toDateISO));

            $(".CurrentProjectName").text(defaultProjectName);
            
            var param = {
                projectID: defaultProjectID,
                fromDate: fromDateISO,
                toDate: toDateISO,
                costType: costFlag
            };

            var url = "api/ProjectProfitability/GetResourceProfitabilityDetails";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            // This API returns array directly in resourceProfitabilityDetails
            var rows = result?.resourceProfitabilityDetails;
            if (!Array.isArray(rows)) rows = [];

            var $tbody = $('#AccruedBillExpenseTable tbody');
            $tbody.empty();

            if (rows.length === 0) {
                $tbody.append(`<tr><td colspan="2" class="text-center text-muted">No data available in table</td></tr>`);
                return;
            }

            var totalExpense = 0;

            $.each(rows, function (i, r) {
                var expense = Number(r.expense || 0);
                totalExpense += expense;

                $tbody.append(`
                    <tr>
                        <td>${r.costHeads || ''}</td>
                        <td class="text-center">${formatINR(expense)}</td>
                    </tr>
                `);
            });

            // Total row = sum of expense
            $tbody.append(`
                <tr class="font-weight-500">
                    <td>Total</td>
                    <td class="text-center">${formatINR(totalExpense)}</td>
                </tr>
            `);
        });

        // Added by Gauri - Offcanvas Expenses & Direct Project Cost button click
        $(document).on('click', '.ExpDirectPeopleCostBtn',function (e) {
            var costFlag = $(this).data('costflag'); // PERIODIC | CUMULATIVE
            defaultProjectName = getCurrentProjectName();

            var myOffcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvasExpDirectPeopleCost'));
            myOffcanvas.show();

            // Row dates
            var $row = $(this).closest('tr');
            var asOnRaw = $row.data('ason');         // toDate
            var rowFromDate = $row.data('fromdate'); // fromDate

            var fromDateISO = reportingFromDate;
            var toDateISO   = reportingToDate;

            // ✅ Use row dates if available
            if (rowFromDate) fromDateISO = rowFromDate;
            if (asOnRaw)     toDateISO   = asOnRaw;

            // ✅ Update labels using selected dates (no getPeriodFromAsOn)
            $("#ExpCost_StartDate").text(formatDateDDMMMYYYY(fromDateISO));
            $("#ExpCost_EndDate").text(formatDateDDMMMYYYY(toDateISO));

            $(".CurrentProjectName").text(defaultProjectName);
            
            var param = {
                projectID: defaultProjectID,
                fromDate: fromDateISO,
                toDate: toDateISO,
                costType: costFlag
            };

            var url = "api/ProjectProfitability/GetResourceProfitabilityDetails";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            // This API returns array directly in resourceProfitabilityDetails
            var rows = result?.resourceProfitabilityDetails;
            if (!Array.isArray(rows)) rows = [];

            var $tbody = $('#ExpDirectPeopleCostTable tbody');
            $tbody.empty();

            if (rows.length === 0) {
                $tbody.append(`<tr><td colspan="2" class="text-center text-muted">No data available in table</td></tr>`);
                return;
            }

            var totalExpense = 0;

            $.each(rows, function (i, r) {
                var expense = Number(r.expense || 0);
                totalExpense += expense;

                $tbody.append(`
                    <tr>
                        <td>${r.costHeads || ''}</td>
                        <td class="text-center">${formatINR(expense)}</td>
                    </tr>
                `);
            });

            // Total row = sum of expense
            $tbody.append(`
                <tr class="font-weight-500">
                    <td>Total</td>
                    <td class="text-center">${formatINR(totalExpense)}</td>
                </tr>
            `);
        });

        let rcgChart = null;
        let rcgPreparedData = null;

        // Added by Gauri - Build data for Revenue/Cost/GPM graph (separate API)
        function buildRCGData() {
            

          

         
            var param = {
                projectID: defaultProjectID,
                fromDate: reportingFromDate,
                toDate: reportingToDate
            };


            if (reportingFromDate < reportingToDate || (reportingFromDate === null && reportingToDate === null) || (reportingFromDate != null && reportingToDate === null)) {

                var url = "api/ProjectProfitability/GetProjPeridGraphData";
                var result = AJAXCallWithResult(url, JSON.stringify(param), false);
            }

          

           

            // parse if string
            if (typeof result === "string") {
                try { result = JSON.parse(result); }
                catch (e) { console.error("Invalid JSON:", result); result = {}; }
            }

            // const rows = result?.data?.ProjectProfitabilityPeriodGraphDataModel;
            // if (!Array.isArray(rows) || rows.length === 0) {
            //     rcgPreparedData = null;
            //     return;
            // }

            // // Format asOn dates from "25 11 Nov 30" to "25 Nov 30"
            // const labels = rows.map(r => formatAsOnDate(r.asOn || ''));

            // const revenue = rows.map(r => Number(r.periodicTotalAccruedRevenue || 0));
            // const cost    = rows.map(r => Number(r.periodicTotalAccruedCost || 0));
            // const gpm     = rows.map(r => Number(r.periodicGPM_Project || 0));  // ✅ correct GPM

            const rows = result?.data?.ProjectProfitabilityPeriodGraphDataModel;
            const hasRows = Array.isArray(rows) && rows.length > 0;

            // Always prepare data object (even if empty)
            const labels  = hasRows ? rows.map(r => formatAsOnDate(r.asOn || '')) : [];
            const revenue = hasRows ? rows.map(r => Number(r.periodicTotalAccruedRevenue || 0)) : [];
            const cost    = hasRows ? rows.map(r => Number(r.periodicTotalAccruedCost || 0)) : [];
            const gpm     = hasRows ? rows.map(r => Number(r.periodicGPM_Project || 0)) : [];

            rcgPreparedData = {
                labels,
                datasets: [
                    {
                        label: 'Revenue',
                        data: revenue,
                        borderColor: '#f59e0b',
                        backgroundColor: '#f59e0b',
                        borderWidth: 2,
                        barThickness: 18,
                        fill: false,
                        tension: 0.4,
                        pointRadius: 4,
                        pointHoverRadius: 5,
                        pointBorderWidth: 2,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#f59e0b'
                    },
                    {
                        label: 'Total Cost',
                        data: cost,
                        borderColor: '#ef4444',
                        backgroundColor: '#ef4444',
                        borderWidth: 2,
                        barThickness: 18,
                        fill: false,
                        tension: 0.4,
                        pointRadius: 4,
                        pointHoverRadius: 5,
                        pointBorderWidth: 2,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#ef4444'
                    },
                    {
                        label: 'GPM',
                        data: gpm,
                        borderColor: '#10b981',
                        backgroundColor: '#10b981',
                        borderWidth: 2,
                        barThickness: 18,
                        fill: false,
                        tension: 0.4,
                        pointRadius: 4,
                        pointHoverRadius: 5,
                        pointBorderWidth: 2,
                        pointBackgroundColor: '#ffffff',
                        pointBorderColor: '#10b981'
                    }
                ]
            };

            // Once data is prepared, (re)initialise the toggle + default chart
            if (rcgPreparedData) {
                initRCGToggle();
            }
        }

        // Added by Gauri - Build chart options for RCG chart
        function buildRCGOptions(dataObj) {
            const allVals = dataObj.datasets.flatMap(d => d.data);
            const minVal = Math.min(...allVals, 0);
            const maxVal = Math.max(...allVals, 0);

            const pad = Math.max(1000, Math.round((maxVal - minVal) * 0.15)); // padding
            const yMin = minVal - pad;
            const yMax = maxVal + pad;

            return {
                maintainAspectRatio: false,
                responsive: true,
                interaction: { mode: 'index', intersect: false },
                scales: {
                    x: {
                        grid: { color: '#e5e7eb', tickColor: '#ffffff', drawBorder: false },
                        // Added by Gauri - Show all labels on X-axis
                        ticks: { 
                            color: '#6b7280', 
                            maxRotation: 45,
                            minRotation: 0,
                            autoSkip: false,  // Show all labels on X-axis
                            padding: 8
                        }
                    },
                    y: {
                        min: yMin,
                        max: yMax,
                        ticks: {
                            color: '#6b7280',
                            callback: v => formatINR(v)
                        },
                        grid: { color: '#e5e7eb', tickColor: '#ffffff', drawBorder: false },
                        beginAtZero: false
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                        labels: { color: '#414042', usePointStyle: true, boxWidth: 12, boxHeight: 6, padding: 20 }
                    },
                    tooltip: {
                        callbacks: {
                            label: ctx => {
                                const val = ctx.parsed.y || 0;
                                return `${ctx.dataset.label}: ${formatINR(val)}`;
                            }
                        }
                    }
                }
            };
        }

        // Added by Gauri - Render RCG Chart (line or bar)
        function renderRCGChart(type) {
            const canvas = document.getElementById('RCG_lineGraph');
            if (!canvas || !window.Chart || !rcgPreparedData) return;

            if (rcgChart) rcgChart.destroy();

            rcgChart = new Chart(canvas.getContext('2d'), {
                type,                      // 'line' or 'bar'
                data: rcgPreparedData,
                options: buildRCGOptions(rcgPreparedData)
            });
        }

        // Added by Gauri - RCG Chart Toggle Button Handlers
        function initRCGToggle() {
            const lineBtn = document.getElementById('rcgLineBtn');
            const barBtn = document.getElementById('rcgBarBtn');

            function setActive(btn) {
                [lineBtn, barBtn].forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            }

            // default
            renderRCGChart('line');
            setActive(lineBtn);

            lineBtn.addEventListener('click', function () {
                setActive(lineBtn);
                renderRCGChart('line');
            });

            barBtn.addEventListener('click', function () {
                setActive(barBtn);
                renderRCGChart('bar');
            });
        }

        function resizeSection() {
            var tblheight = $(window).height();
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $("select").removeAttr("title");

        //hide notebox
        $(".closenotebox").click(function () {
            $(".noteboxpanel").fadeOut();
        });

        //hide profitability information
        $(".hideprofitabilityinfo").click(function () {
            $(".profitabilityinfopanel").fadeOut('fast');
        });

        function toggleIcon(e) {
            $(e.target)
                .prev('.panel-heading')
                .find(".infoToggler")
                .toggleClass('togglerdown togglerup');
        }
        $('.panel-group').on('hidden.bs.collapse', toggleIcon);
        $('.panel-group').on('shown.bs.collapse', toggleIcon);

    </script>
    <!--End chart script-->
</body>

</html>
