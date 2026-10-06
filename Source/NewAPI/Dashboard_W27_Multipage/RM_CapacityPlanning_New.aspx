<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_CapacityPlanning_New.aspx.vb" Inherits="Whizible.RM_CapacityPlanning_New" %>

<!DOCTYPE html>
<html>
<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("C_CapacityPlanning"))%>
<head>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
</head>
<style>
    /* ===== Capacity Planning — Lovable / Whizible design tokens ===== */
    :root {
        --cp-background: hsl(210 20% 98%);
        --cp-foreground: hsl(222 47% 11%);
        --cp-muted: hsl(210 40% 96%);
        --cp-muted-fg: hsl(215 16% 47%);
        --cp-border: hsl(214 32% 91%);
        --cp-card: #ffffff;
        --cp-primary: hsl(221 83% 53%);
        --cp-primary-fg: #ffffff;
        --cp-status-healthy: hsl(142 71% 45%);
        --cp-status-critical: hsl(0 72% 51%);
        --cp-status-risk: hsl(25 95% 53%);
        --cp-status-nodata: hsl(215 16% 47%);
        --cp-current-quarter: hsl(199 89% 55%);
        --cp-chart-5: hsl(280 75% 60%);
        --cp-q1-tint: hsl(217 91% 97%);
        --cp-q2-tint: hsl(142 71% 97%);
        --cp-section-gap: 16px;
        --cp-q3-tint: hsl(38 92% 97%);
        --cp-q4-tint: hsl(280 75% 97%);
        --cp-radius: 12px;
        --cp-shadow: 0 1px 2px rgba(15, 23, 42, 0.05);
    }

    body#CapacityPlanning,
    body#CapacityPlanning .form-control,
    body#CapacityPlanning .btn,
    body#CapacityPlanning a,
    body#CapacityPlanning p,
    body#CapacityPlanning input,
    body#CapacityPlanning select.form-select,
    body#CapacityPlanning table,
    body#CapacityPlanning th,
    body#CapacityPlanning td,
    body#CapacityPlanning label,
    body#CapacityPlanning button {
        font-size: 11.5px !important;
        font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
    }

    html, body#CapacityPlanning {
        width: 100%;
        max-width: 100%;
        overflow-x: hidden;
        box-sizing: border-box;
    }

    body#CapacityPlanning *,
    body#CapacityPlanning *::before,
    body#CapacityPlanning *::after {
        box-sizing: border-box;
    }

    body#CapacityPlanning {
        background-color: var(--cp-background) !important;
    }

    body#CapacityPlanning #CapacityWrapper,
    body#CapacityPlanning #form1 {
        width: 100%;
        max-width: 100%;
        overflow-x: hidden;
    }

    body#CapacityPlanning .cp-main {
        background: var(--cp-background);
    }

    .cp-main {
        width: 100%;
        max-width: 100%;
        min-height: calc(100vh - 48px);
        background: var(--cp-background);
        padding: 12px 16px 24px;
        overflow-x: hidden;
    }

    @media (min-width: 768px) {
        .cp-main { padding: 16px 20px 28px; }
    }

    .cp-container {
        width: 100%;
        max-width: 100%;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        gap: var(--cp-section-gap);
        min-width: 0;
    }

    .cp-page-header {
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        width: 100%;
        min-width: 0;
        margin: 0;
        padding: 0;
    }

    body#CapacityPlanning h1.cp-title {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 18px !important;
        font-weight: 700;
        letter-spacing: -0.02em;
        color: var(--cp-primary) !important;
        margin: 0;
    }

    body#CapacityPlanning h1.cp-title .cp-title-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 28px;
        height: 28px;
        border-radius: 8px;
        background: hsl(221 83% 53% / 0.12);
        color: var(--cp-primary) !important;
        flex-shrink: 0;
    }

    body#CapacityPlanning h1.cp-title .cp-title-icon i {
        font-size: 14px;
        line-height: 1;
        color: var(--cp-primary) !important;
    }

    .cp-subtitle {
        margin: 2px 0 0;
        font-size: 10px;
        color: var(--cp-muted-fg);
    }

    .cp-period-toggle {
        display: flex;
        border-radius: 8px;
        border: 1px solid var(--cp-border);
        background: var(--cp-card);
        padding: 2px;
        box-shadow: var(--cp-shadow);
        flex-shrink: 0;
        align-self: center;
    }

    .cp-period-btn,
    .cp-toggle-pill {
        border: none;
        background: transparent;
        color: var(--cp-muted-fg);
        font-size: 10px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.04em;
        padding: 3px 10px;
        border-radius: 6px;
        transition: all 0.15s ease;
        cursor: pointer;
    }

    .cp-period-btn.active,
    .cp-toggle-pill.active {
        background: var(--cp-foreground);
        color: var(--cp-card);
        box-shadow: var(--cp-shadow);
    }

    /* KPI: ALWAYS 5 columns, one row — never wrap */
    .cp-kpi-grid {
        display: grid !important;
        grid-template-columns: repeat(5, minmax(0, 1fr)) !important;
        gap: 6px;
        width: 100%;
        max-width: 100%;
        min-width: 0;
    }

    .kpi-card {
        position: relative;
        overflow: hidden;
        background: var(--cp-card);
        border: 1px solid var(--cp-border);
        border-radius: 8px;
        padding: 6px 8px;
        box-shadow: var(--cp-shadow);
        display: flex;
        align-items: center;
        gap: 6px;
        transition: all 0.2s ease;
        cursor: default;
        min-width: 0;
    }

    .kpi-card:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(15, 23, 42, 0.08);
    }

    .kpi-icon {
        width: 24px;
        height: 24px;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .kpi-icon i { font-size: 11.5px; line-height: 1; }

    .kpi-content {
        min-width: 0;
        flex: 1;
    }

    .kpi-title {
        font-size: 10px;
        font-weight: 600;
        color: var(--cp-muted-fg);
        margin: 0 0 1px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .kpi-value {
        display: flex;
        align-items: baseline;
        gap: 3px;
        line-height: 1;
        color: var(--cp-foreground);
        font-size: 13px;
        font-weight: 700;
        letter-spacing: -0.02em;
        min-width: 0;
        flex-wrap: nowrap;
    }

    .kpi-value span {
        font-size: 16px;
        font-weight: 700;
        color: var(--cp-foreground);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 100%;
    }

    .kpi-value small { font-size: 8px; font-weight: 600; color: var(--cp-muted-fg) !important; flex-shrink: 0; }

    .total-strength-icon { background: hsl(221 83% 53% / 0.1); color: var(--cp-primary); }
    .allocated-icon { background: hsl(142 71% 45% / 0.1); color: var(--cp-status-healthy); }
    .bench-icon { background: hsl(25 95% 53% / 0.15); color: var(--cp-status-risk); }
    .project-icon { background: hsl(280 75% 60% / 0.1); color: var(--cp-chart-5); }
    .opportunity-icon { background: hsl(25 95% 53% / 0.1); color: var(--cp-status-risk); }

    .cp-kpi-section {
        display: flex;
        flex-direction: column;
        gap: 0;
        width: 100%;
        min-width: 0;
        margin: 0;
    }

    .cp-kpi-note {
        margin: 0;
        display: inline-flex;
        align-items: center;
        align-self: flex-start;
        gap: 8px;
        width: fit-content;
        max-width: 100%;
        box-sizing: border-box;
        padding: 8px 12px;
        border: 1px solid #ffe08a;
        border-radius: 6px;
        background: #fff8db;
        color: #6d5711;
        font-size: 11.5px;
        line-height: 1.4;
    }

    .cp-kpi-note i {
        color: #8a6d1f;
        font-size: 13px;
        flex-shrink: 0;
    }

    .cp-kpi-note strong {
        font-weight: 700;
        color: #5b470c;
    }

    .cp-applied-filters {
        display: none;
        width: 100%;
        box-sizing: border-box;
        align-items: center;
        flex-wrap: wrap;
        gap: 8px;
        margin: 0;
    }

    .cp-applied-filters.is-visible {
        display: flex;
    }

    .cp-applied-filters-title {
        display: inline-block;
        margin: 0;
        padding: 0;
        background: transparent;
        color: #334155;
        font-size: 11.5px;
        font-weight: 700;
        line-height: 1.3;
        white-space: nowrap;
    }

    .cp-applied-filters-inner {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 8px;
    }

    .cp-filter-chip {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        max-width: 100%;
        padding: 5px 10px;
        border: none;
        border-radius: 16px;
        background: #e9ecef;
        color: #334155;
        font-size: 11.5px;
        line-height: 1.3;
        white-space: nowrap;
    }

    .cp-filter-chip-text {
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 320px;
    }

    .cp-filter-chip-remove {
        border: none;
        background: transparent;
        color: #6b7280;
        cursor: pointer;
        padding: 0;
        margin: 0;
        font-size: 11px;
        line-height: 1;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 14px;
        height: 14px;
    }

    .cp-filter-chip-remove:hover {
        color: #111827;
    }

    /* Filter bar: row 1 = filters, row 2 = legend + download */
    .filter-section,
    .cp-filter-bar {
        background: var(--cp-card);
        border: 1px solid var(--cp-border);
        border-radius: 8px;
        padding: 8px 12px;
        box-shadow: var(--cp-shadow);
        display: flex !important;
        flex-wrap: wrap !important;
        align-items: center;
        gap: 8px 10px;
        position: relative;
        overflow: visible;
        width: 100%;
        max-width: 100%;
        min-width: 0;
        min-height: 40px;
        box-sizing: border-box;
        margin: 0;
    }

    .filter-left {
        display: flex;
        align-items: center;
        flex-wrap: nowrap;
        gap: 8px;
        flex: 1 1 100%;
        width: 100%;
        min-width: 0;
        overflow: visible;
    }

    .filter-right {
        display: flex;
        align-items: center;
        flex-wrap: nowrap;
        gap: 10px;
        flex: 1 1 100%;
        width: 100%;
        min-width: 0;
        margin-left: 0;
        position: relative;
        background: transparent;
        padding: 8px 0 0;
        border-top: 1px solid var(--cp-border);
        z-index: 2;
        overflow: visible;
    }

    .view-switch {
        display: flex;
        background: var(--cp-muted);
        border-radius: 6px;
        padding: 2px;
        flex-shrink: 0;
    }

    .cp-dropdown {
        position: relative;
        flex: 1 1 0;
        min-width: 120px;
        max-width: none;
    }

    .capacity-legend {
        display: flex;
        align-items: center;
        gap: 16px;
        flex-wrap: wrap;
        flex: 1 1 auto;
        min-width: 0;
        max-width: 100%;
        justify-content: flex-start;
        overflow: visible;
    }

    .legend-item {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 11.5px;
        font-weight: 500;
        color: var(--cp-muted-fg);
        white-space: nowrap;
        overflow: visible;
        max-width: none;
        flex-shrink: 0;
        min-width: 0;
    }

    .btn-view {
        border: none;
        background: transparent;
        color: var(--cp-muted-fg);
        font-size: 11.5px;
        font-weight: 600;
        text-transform: capitalize;
        padding: 4px 10px;
        border-radius: 5px;
        transition: all 0.15s ease;
        cursor: pointer;
        white-space: nowrap;
    }

    .btn-view.active {
        background: var(--cp-primary);
        color: var(--cp-primary-fg);
        box-shadow: var(--cp-shadow);
    }

    .cp-dropdown-toggle {
        width: 100%;
        height: 28px;
        border-radius: 6px;
        border: 1px solid var(--cp-border);
        background: var(--cp-card);
        font-size: 11.5px;
        font-weight: 500;
        color: var(--cp-foreground);
        padding: 0 20px 0 8px;
        text-align: left;
        position: relative;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        display: inline-flex;
        align-items: center;
        gap: 3px;
        box-shadow: var(--cp-shadow);
        transition: border-color 0.15s ease;
        cursor: pointer;
    }

    .cp-dropdown-toggle:after {
        content: "";
        position: absolute;
        right: 8px;
        top: 50%;
        width: 0;
        height: 0;
        border-left: 3px solid transparent;
        border-right: 3px solid transparent;
        border-top: 4px solid var(--cp-muted-fg);
        transform: translateY(-50%);
    }

    .cp-dropdown-toggle:hover,
    .cp-dropdown.open .cp-dropdown-toggle {
        border-color: hsl(221 83% 53% / 0.4);
    }

    .cp-dropdown-toggle:focus {
        outline: none;
        border-color: var(--cp-primary);
    }

    .cp-dropdown-panel {
        display: none;
        position: absolute;
        top: calc(100% + 4px);
        left: 0;
        width: 100%;
        min-width: 180px;
        max-height: 280px;
        overflow: hidden;
        background: var(--cp-card);
        border: 1px solid var(--cp-border);
        border-radius: 6px;
        box-shadow: 0 8px 24px rgba(20, 30, 50, 0.14);
        z-index: 9999;
        flex-direction: column;
        padding: 0;
    }

    .cp-dropdown.open .cp-dropdown-panel {
        display: flex;
    }

    .cp-dropdown-options {
        flex: 1 1 auto;
        overflow-y: auto;
        max-height: 220px;
        min-height: 0;
    }

    .cp-dropdown-search {
        flex: 0 0 auto;
        width: 100%;
        box-sizing: border-box;
        border: 1px solid #d1d5db;
        border-radius: 4px;
        padding: 6px 8px;
        font-size: 11.5px;
        margin-bottom: 6px;
        color: var(--cp-foreground);
        background: #fff;
        position: sticky;
        top: 0;
        z-index: 2;
    }

    .cp-dropdown-search:focus {
        outline: none;
        border-color: #1359a6;
    }

    .cp-dropdown-no-match {
        padding: 10px 8px;
        font-size: 11.5px;
        color: #6b7280;
        text-align: center;
    }

    .cp-dd-actions {
        flex: 0 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 6px 10px;
        border-top: 1px solid var(--cp-border);
        background: #fff;
    }

    .cp-dd-actions button {
        padding: 4px;
        border: 0;
        background: none;
        color: #1359a6;
        font-size: 11.5px;
        font-weight: 600;
        cursor: pointer;
        line-height: 1.2;
    }

    .cp-dd-actions button:hover {
        text-decoration: underline;
    }

    .cp-dropdown-panel li {
        padding: 6px 10px;
        font-size: 10px;
        color: var(--cp-foreground);
        cursor: pointer;
        white-space: nowrap;
    }

    .cp-dropdown-panel li:hover { background: var(--cp-muted); }
    .cp-dropdown-panel li.selected { background: hsl(221 83% 53% / 0.1); color: var(--cp-primary); font-weight: 600; }
    .cp-dropdown-panel li.cp-dropdown-empty { color: var(--cp-muted-fg); cursor: default; }
    .cp-dropdown-panel li.cp-dropdown-empty:hover { background: transparent; }

    .dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        display: inline-block;
        flex-shrink: 0;
    }

    .dot.dot-green { background-color: var(--cp-status-healthy); }
    .dot.dot-red { background-color: var(--cp-status-critical); }
    .dot.dot-orange { background-color: var(--cp-status-risk); }
    /* Match the soft gray No Data indicator used in the legend. */
    .dot.dot-gray { background-color: #c5ced8; }

    .cp-btn-icon {
        flex-shrink: 0;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 26px;
        height: 26px;
        border-radius: 6px;
        border: 1px solid var(--cp-border);
        background: var(--cp-card);
        color: var(--cp-foreground);
        box-shadow: var(--cp-shadow);
        transition: background 0.15s ease;
        cursor: pointer;
        text-decoration: none;
    }

    .cp-btn-icon:hover { background: var(--cp-muted); color: var(--cp-foreground); }

    .cp-grid-card {
        overflow: hidden;
        border: 1px solid var(--cp-border);
        border-radius: var(--cp-radius);
        background: var(--cp-card);
        box-shadow: var(--cp-shadow);
        width: 100%;
        max-width: 100%;
        min-width: 0;
        margin: 0;
    }

    .cp-grid-container {
        overflow-x: auto;
        overflow-y: auto;
        max-height: 520px;
        width: 100%;
        max-width: 100%;
        -webkit-overflow-scrolling: touch;
    }

    .cp-grid-container.cp-has-detail {
        max-height: none;
        overflow-y: visible;
    }

    .detail-row > td {
        position: sticky;
        left: 0;
        padding: 0 !important;
        background: var(--cp-card) !important;
        z-index: 15;
        border-bottom: 1px solid var(--cp-border) !important;
        box-sizing: border-box;
    }

    .cp-detail-sticky-inner {
        width: 100%;
        max-width: 100%;
        box-sizing: border-box;
    }

    .cp-detail-wrapper {
        padding: 0;
        border-top: 1px solid var(--cp-border);
        width: 100%;
        max-width: 100%;
        box-sizing: border-box;
        background: var(--cp-card);
    }

    .cp-detail-flex {
        display: flex;
        align-items: stretch;
        min-height: 280px;
        width: 100%;
        max-width: 100%;
        box-sizing: border-box;
    }

    .cp-detail-sidebar {
        width: 210px;
        flex-shrink: 0;
        border-right: 1px solid var(--cp-border);
        padding: 8px 0;
        background: var(--cp-card);
    }

    .cp-detail-nav-item {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 9px 14px;
        font-size: 11.5px;
        color: var(--cp-muted-fg);
        cursor: pointer;
        white-space: nowrap;
    }

    .cp-detail-nav-item i {
        width: 16px;
        font-size: 11.5px;
        color: var(--cp-muted-fg);
    }

    .cp-detail-nav-item:hover { background: hsl(210 40% 96% / 0.6); }

    .cp-detail-nav-item.active {
        background: hsl(221 83% 53% / 0.08);
        color: var(--cp-primary);
        font-weight: 600;
        border-right: 3px solid var(--cp-primary);
    }

    .cp-detail-nav-item.active i { color: var(--cp-primary); }

    .cp-detail-content {
        flex: 1;
        padding: 14px 16px;
        min-width: 0;
        width: 100%;
        overflow-x: auto;
    }

    .cp-detail-content-title {
        font-size: 11.5px;
        font-weight: 700;
        color: var(--cp-foreground);
        margin-bottom: 10px;
    }

    table.cp-month-table {
        width: max-content;
        min-width: 100%;
        border-collapse: collapse;
        font-size: 11.5px;
        table-layout: auto;
    }

    table.cp-month-table th,
    table.cp-month-table td {
        padding: 6px 10px;
        text-align: center;
        border-bottom: 1px solid hsl(214 32% 91% / 0.8);
        white-space: nowrap;
        min-width: 56px;
    }

    table.cp-month-table td:first-child,
    table.cp-month-table th:first-child {
        text-align: left;
        font-weight: 600;
        color: var(--cp-foreground);
        min-width: 180px;
        position: sticky;
        left: 0;
        background: var(--cp-card);
        z-index: 2;
    }

    .cp-week-cell,
    .cp-month-cell,
    .cp-quarter-cell {
        cursor: pointer;
        transition: background 0.15s ease;
    }

    /* Clickable metric numbers: small underline cue */
    .cp-week-cell > span.cp-metric-link,
    .cp-month-cell > span.cp-metric-link,
    .cp-quarter-cell > span.cp-metric-link {
        text-decoration: underline;
        text-decoration-thickness: 1px;
        text-underline-offset: 2px;
        text-decoration-color: rgba(0, 0, 0, 0.35);
    }

    .cp-week-cell:hover > span.cp-metric-link,
    .cp-month-cell:hover > span.cp-metric-link,
    .cp-quarter-cell:hover > span.cp-metric-link {
        text-decoration-color: rgba(0, 0, 0, 0.65);
    }

    .cp-week-cell:hover,
    .cp-month-cell:hover,
    .cp-quarter-cell:hover {
        background: hsl(221 83% 53% / 0.06);
    }

    .cp-week-cell-empty,
    .cp-month-cell-empty,
    .cp-quarter-cell-empty,
    .cp-util-metric-cell {
        cursor: default;
    }

    .cp-util-metric-cell > span {
        text-decoration: none;
    }

    .cp-week-cell-empty:hover,
    .cp-month-cell-empty:hover,
    .cp-quarter-cell-empty:hover,
    .cp-util-metric-cell:hover {
        background: transparent;
    }

    table.cp-month-table th.cp-detail-q1 { background: var(--cp-q1-tint); }
    table.cp-month-table th.cp-detail-q2 { background: var(--cp-q2-tint); }
    table.cp-month-table th.cp-detail-q3 { background: var(--cp-q3-tint); }
    table.cp-month-table th.cp-detail-q4 { background: var(--cp-q4-tint); }

    .cp-quarter-detail-wrap {
        width: 100%;
        overflow-x: auto;
    }

    table.cp-quarter-detail-table {
        width: 100%;
        min-width: 100%;
        table-layout: fixed;
    }

    table.cp-quarter-detail-table th,
    table.cp-quarter-detail-table td {
        padding: 8px 12px;
        vertical-align: middle;
    }

    table.cp-quarter-detail-table .cp-month-group-head {
        text-align: center;
        padding: 10px 8px;
    }

    table.cp-quarter-detail-table .cp-qdetail-quarter-cell {
        text-align: center;
        font-weight: 500;
    }

    table.cp-quarter-detail-table.cp-quarter-detail-expanded {
        min-width: 100%;
    }

    .detail-row .cp-detail-content.cp-has-quarter-detail {
        overflow-x: auto;
    }

    .detail-row .cp-detail-flex.cp-quarter-detail-open {
        min-height: 320px;
    }

    .cp-detail-quarter-toggle {
        border: none;
        background: transparent;
        font-size: 11.5px;
        font-weight: 700;
        color: inherit;
        cursor: pointer;
        padding: 4px 8px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        width: 100%;
        min-height: 28px;
    }

    .cp-detail-quarter-toggle:hover {
        opacity: 0.85;
    }

  /* Detail drawer (employee / drill-down panel) */
    .cp-drawer-overlay {
        position: fixed;
        inset: 0;
        background: rgba(15, 23, 42, 0.35);
        z-index: 10050;
        display: none;
    }

    .cp-drawer-overlay.open { display: block; }

    html.cp-drawer-open,
    body#CapacityPlanning.cp-drawer-open {
        overflow: hidden !important;
        overscroll-behavior: none;
        touch-action: none;
    }

    .cp-drawer-panel {
        position: fixed;
        top: 0;
        right: 0;
        width: min(720px, 92vw);
        height: 100vh;
        max-height: 100dvh;
        background: var(--cp-card);
        box-shadow: -8px 0 32px rgba(15, 23, 42, 0.15);
        display: flex;
        flex-direction: column;
        animation: cpDrawerIn 0.22s ease;
        overflow: hidden;
    }

    @keyframes cpDrawerIn {
        from { transform: translateX(100%); }
        to { transform: translateX(0); }
    }

    .cp-drawer-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        padding: 6px 12px;
        min-height: 40px;
        background: #F8FAFC;
        border-bottom: 1px solid #e5e7eb;
    }

    /* Match PM_AssignedTasks / My_Leaves offcanvas-title */
    .cp-drawer-title {
        margin: 0;
        font-size: 16px;
        font-weight: 600;
        color: #1e40af;
        line-height: 1.3;
    }

    .cp-drawer-subtitle {
        margin: 2px 0 0;
        font-size: 12px;
        font-weight: 600;
        color: #1e40af;
        line-height: 1.3;
    }

    /* Match Assigned Task close (btn-danger-modern + fa-times) */
    .cp-drawer-close,
    .cp-drawer-close.btn-danger-modern {
        background-color: transparent;
        border: none;
        color: #333;
        font-size: 11.5px;
        padding: 2px 6px;
        line-height: 1;
        cursor: pointer;
        box-shadow: none;
        transition: none;
        flex-shrink: 0;
    }

    .cp-drawer-close:hover,
    .cp-drawer-close.btn-danger-modern:hover {
        background-color: transparent;
        color: #333;
        box-shadow: none;
    }

    .cp-drawer-close i {
        font-size: 14px;
        line-height: 1;
    }

    .cp-drawer-body {
        flex: 1;
        overflow: auto;
        padding: 0 20px 12px;
    }

    table.cp-drawer-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 11.5px;
        table-layout: fixed;
    }

    table.cp-drawer-table th {
        text-align: left;
        padding: 10px 8px;
        font-weight: 600;
        color: var(--cp-muted-fg);
        border-bottom: 1px solid var(--cp-border);
        background: hsl(210 40% 96% / 0.35);
        position: sticky;
        top: 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    table.cp-drawer-table td {
        padding: 9px 8px;
        border-bottom: 1px solid hsl(214 32% 91% / 0.7);
        color: var(--cp-foreground);
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    table.cp-drawer-table tr.cp-empty-row td,
    table.cp-detail-list-table tr.cp-empty-row td {
        border-bottom: none;
        text-align: center;
        vertical-align: middle;
        white-space: normal;
        overflow: visible;
        padding: 56px 16px;
        min-height: 180px;
        height: 220px;
        color: var(--cp-muted-fg);
        font-size: 12px;
    }

    .cp-empty-message {
        display: inline-block;
        color: var(--cp-muted-fg);
        font-size: 12px;
        line-height: 1.4;
    }

    .cp-drawer-title,
    .cp-drawer-subtitle,
    .cp-detail-content-title {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        max-width: 100%;
    }

    .cp-detail-nav-item {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    #tblCapacity thead th {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .cp-cell-ellipsis {
        display: block;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        max-width: 100%;
    }

    .cp-status-bench { color: var(--cp-status-risk); font-weight: 600; }
    .cp-status-allocated { color: var(--cp-status-healthy); font-weight: 600; }

    .cp-drawer-footer {
        padding: 8px 12px;
        border-top: 1px solid var(--cp-border);
        font-size: 11.5px;
        color: var(--cp-muted-fg);
        background: hsl(210 40% 96% / 0.2);
    }

    .cp-drawer-footer.cp-pagination-footer {
        display: flex !important;
        flex-direction: column;
        gap: 8px;
        justify-content: space-between;
        align-items: flex-start;
    }

    .cp-drawer-footer.cp-pagination-footer.cp-pagination-hidden,
    .cp-detail-tab-pagination.cp-pagination-hidden {
        display: none !important;
    }

    @media (min-width: 768px) {
        .cp-drawer-footer.cp-pagination-footer {
            flex-direction: row;
            align-items: center;
        }
    }

    .cp-drawer-footer #cpDrawerRecordCount,
    .cp-detail-tab-pagination #cpTabRecordCount {
        color: var(--cp-muted-fg);
        font-size: 11.5px;
    }

    .cp-drawer-footer .btn-page-nav,
    .cp-detail-tab-pagination .btn-page-nav {
        width: 24px;
        height: 24px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: var(--cp-card);
        border: 1px solid var(--cp-border);
        border-radius: 6px;
        color: var(--cp-muted-fg);
        cursor: pointer;
        padding: 0;
        font-size: 11.5px;
    }

    .cp-drawer-footer .btn-page-nav:hover:not(:disabled),
    .cp-detail-tab-pagination .btn-page-nav:hover:not(:disabled) {
        background: var(--cp-muted);
    }

    .cp-drawer-footer .btn-page-nav:disabled,
    .cp-detail-tab-pagination .btn-page-nav:disabled {
        opacity: 0.4;
        cursor: not-allowed;
    }

    .cp-drawer-footer .btn-page-current,
    .cp-detail-tab-pagination .btn-page-current {
        min-width: 24px;
        height: 24px;
        padding: 0 6px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: var(--cp-primary);
        color: #fff;
        border: none;
        border-radius: 6px;
        font-size: 11.5px;
        font-weight: 600;
        cursor: default;
    }

    #tblCapacity {
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        table-layout: fixed;
        border-collapse: separate;
        border-spacing: 0;
        font-size: 11.5px;
        margin-bottom: 0;
    }

    #tblCapacity th,
    #tblCapacity td {
        padding: 6px 4px;
        font-size: 11.5px;
        white-space: nowrap;
        vertical-align: middle;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    #tblCapacity thead th {
        font-size: 10px;
        font-weight: 600;
        color: var(--cp-foreground);
        background: hsl(210 40% 96% / 0.3);
        border-bottom: 1px solid var(--cp-border);
        text-align: center;
        position: sticky;
        top: 0;
        z-index: 20;
    }

    #tblCapacity thead th:first-child {
        text-align: left;
        position: sticky;
        left: 0;
        z-index: 30;
        width: 16%;
        min-width: 140px;
        max-width: 200px;
        background: hsl(210 40% 96% / 0.95);
        padding-left: 8px;
    }

    #tblCapacity tbody td {
        color: var(--cp-muted-fg);
        font-weight: 600;
        border-bottom: 1px solid hsl(214 32% 91% / 0.6);
        text-align: center;
    }

    #tblCapacity tbody td:first-child {
        text-align: left;
        position: sticky;
        left: 0;
        background: var(--cp-card);
        z-index: 10;
        font-weight: 500;
        color: var(--cp-foreground);
        padding-left: 8px;
        max-width: 200px;
    }

    #tblCapacity tbody tr.cp-master-row,
    #tblCapacity tbody tr:not(.detail-row) {
        cursor: pointer;
        transition: background 0.15s ease;
    }

    #tblCapacity tbody tr.cp-master-row:hover,
    #tblCapacity tbody tr:not(.detail-row):hover {
        background: hsl(210 40% 96% / 0.3);
    }

    #tblCapacity th.cp-col-center,
    #tblCapacity td.cp-col-center {
        width: 7%;
        min-width: 52px;
        max-width: 72px;
        padding: 6px 2px;
    }

    #tblCapacity th.cp-util-col,
    #tblCapacity td.cp-util-col {
        width: 11%;
        min-width: 88px;
        max-width: 120px;
        text-align: center !important;
        padding: 6px 4px;
    }

    #tblCapacity td.cp-util-col > div { margin: 0 auto; }

    #tblCapacity th.cp-week-util-col,
    #tblCapacity td.cp-week-util-col {
        width: auto;
        min-width: 56px;
        max-width: none;
        padding: 6px 2px;
        font-size: 10px;
    }

    .cp-col-center {
        min-width: 52px !important;
        width: auto !important;
        text-align: center;
        white-space: nowrap;
    }

    .cp-week-header-label {
        font-size: 10px;
        font-weight: 600;
        line-height: 1.2;
    }

    .cp-week-header-sub {
        font-size: 9px;
        color: #6b7280;
        line-height: 1.2;
        margin-top: 1px;
    }

    #tblCapacity.cp-month-fit {
        width: 100% !important;
        min-width: 100% !important;
        max-width: 100% !important;
        table-layout: fixed !important;
    }

    .cp-grid-container.cp-month-view {
        overflow-x: hidden;
    }

    #tblCapacity.cp-quarter-table {
        width: 100%;
        min-width: 100%;
        max-width: 100%;
        table-layout: fixed;
    }

    #tblCapacity.cp-quarter-table.cp-quarter-expanded {
        width: max-content;
        min-width: 100%;
        max-width: none;
        table-layout: auto;
    }

    .cp-grid-container.cp-quarter-view {
        overflow-x: hidden;
    }

    .cp-grid-container.cp-quarter-expanded {
        overflow-x: auto;
    }

    #tblCapacity.cp-quarter-table th.cp-quarter-head:not(.cp-expanded) {
        width: 96px;
        min-width: 96px;
        max-width: 110px;
    }

    #tblCapacity.cp-quarter-table th.cp-quarter-head.cp-expanded {
        min-width: 72px;
    }

    .cp-quarter-head {
        text-align: center !important;
        vertical-align: middle !important;
        border-left: 1px solid var(--cp-border);
    }

    .cp-quarter-head.cp-q1 { background: var(--cp-q1-tint); }
    .cp-quarter-head.cp-q2 { background: var(--cp-q2-tint); }
    .cp-quarter-head.cp-q3 { background: var(--cp-q3-tint); }
    .cp-quarter-head.cp-q4 { background: var(--cp-q4-tint); }

    /* Visually identify the current quarter in the quarter-wise grid. */
    #tblCapacity .cp-current-quarter {
        border-left: 1px solid hsl(199 89% 55% / 0.32) !important;
        border-right: 1px solid hsl(199 89% 55% / 0.32) !important;
    }

    #tblCapacity th.cp-current-quarter {
        border-top: 1px solid hsl(199 89% 55% / 0.50) !important;
        background-image: linear-gradient(180deg, hsl(199 89% 55% / 0.22), hsl(199 89% 55% / 0.08));
    }

    #tblCapacity td.cp-current-quarter {
        background-color: #e0f2fe !important;
        background-image: none !important;
        border-left-color: transparent !important;
        border-right-color: transparent !important;
    }

    #tblCapacity td.cp-current-quarter-start {
        border-left-color: hsl(199 89% 55% / 0.32) !important;
    }

    #tblCapacity td.cp-current-quarter-end {
        border-right-color: hsl(199 89% 55% / 0.32) !important;
    }

    .cp-quarter-detail-table .cp-current-quarter {
        background-color: #e0f2fe !important;
        background-image: none !important;
        border-left-color: transparent !important;
        border-right-color: transparent !important;
    }

    .cp-quarter-detail-table td.cp-current-quarter-start {
        border-left-color: hsl(199 89% 55% / 0.32) !important;
    }

    .cp-quarter-detail-table td.cp-current-quarter-end {
        border-right-color: hsl(199 89% 55% / 0.32) !important;
    }

    .cp-quarter-detail-table th.cp-current-quarter {
        border-top: 1px solid hsl(199 89% 55% / 0.42) !important;
        background-image: linear-gradient(180deg, hsl(199 89% 55% / 0.22), hsl(199 89% 55% / 0.08));
    }

    #tblCapacity tbody tr:last-child td.cp-current-quarter,
    .cp-quarter-detail-table tbody tr:last-child td.cp-current-quarter {
        border-bottom: 1px solid hsl(199 89% 55% / 0.32) !important;
    }

    .cp-current-quarter-label {
        display: table;
        width: auto;
        margin: 0 auto 5px;
        padding: 3px 8px;
        border-radius: 999px;
        background: hsl(199 89% 55% / 0.14);
        color: #0369a1;
        font-size: 8.5px;
        font-weight: 700;
        line-height: 1;
        letter-spacing: 0.06em;
        text-transform: uppercase;
    }

    /* Current month follows the same visual treatment in month-wise grids. */
    #tblCapacity .cp-current-month-view,
    .cp-month-table .cp-current-month-view {
        background-color: #e0f2fe !important;
        background-image: none !important;
    }

    #tblCapacity th.cp-current-month-view,
    .cp-month-table th.cp-current-month-view {
        border-top: 1px solid hsl(199 89% 55% / 0.50) !important;
    }

    .cp-current-month-view-label {
        display: table;
        width: auto;
        margin: 0 auto 4px;
        padding: 3px 8px;
        border-radius: 999px;
        background: hsl(199 89% 55% / 0.18);
        color: #0369a1;
        font-size: 8.5px;
        font-weight: 700;
        letter-spacing: 0.06em;
        line-height: 1;
        text-transform: uppercase;
    }

    .cp-quarter-label {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        gap: 4px;
        font-size: 11.5px;
        font-weight: 700;
        color: var(--cp-foreground);
        border: none;
        background: transparent;
        padding: 2px 6px;
        border-radius: 6px;
        cursor: pointer;
    }

    .cp-quarter-label:hover { background: hsl(222 47% 11% / 0.08); }

    .cp-quarter-label i,
    .cp-role-cell i,
    .expand-icon {
        font-size: 10px;
        color: var(--cp-muted-fg);
    }

    .cp-quarter-sub {
        font-size: 9px;
        font-weight: 600;
        letter-spacing: 0.06em;
        text-transform: uppercase;
        color: var(--cp-muted-fg);
        margin-top: 2px;
    }

    .cp-role-cell {
        display: flex;
        align-items: center;
        gap: 8px;
        width: 100%;
        max-width: 100%;
        min-width: 0;
        overflow: hidden;
        font-size: 11.5px;
        font-weight: 500;
        color: var(--cp-foreground);
    }

    .cp-role-cell .expand-icon,
    .cp-role-cell .cp-sort-icon {
        flex-shrink: 0;
    }

    .cp-role-name {
        display: block;
        min-width: 0;
        flex: 1 1 auto;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    #tblCapacity thead th:first-child,
    #tblCapacity tbody td:first-child {
        overflow: hidden;
    }

    /* Metric counts (non-%): always black */
    #tblCapacity td.cp-col-center:not(.cp-util-col):not(.cp-week-util-col):not(.cp-qcell-td),
    #tblCapacity td.cp-col-center:not(.cp-util-col):not(.cp-week-util-col):not(.cp-qcell-td) span,
    .cp-bench-val,
    .cp-requests-val,
    .cp-month-table tbody td,
    .cp-month-table tbody td span,
    .cp-quarter-detail-table tbody td,
    .cp-quarter-detail-table tbody td span {
        color: #000000 !important;
    }

    .cp-util-bar-wrap {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        justify-content: center;
        max-width: 100%;
    }

    .cp-util-bar-track {
        width: 40px;
        height: 5px;
        border-radius: 999px;
        background: var(--cp-muted);
        overflow: hidden;
        flex-shrink: 0;
    }

    .cp-util-bar-fill {
        height: 100%;
        border-radius: 999px;
    }

    .cp-util-bar-fill.cp-healthy { background-color: var(--cp-status-healthy); }
    .cp-util-bar-fill.cp-review { background-color: var(--cp-status-critical); }
    .cp-util-bar-fill.cp-critical { background-color: var(--cp-status-risk); }
    .cp-util-bar-fill.cp-nodata { background-color: var(--cp-status-nodata); }

    .cp-util-bar-pct { font-size: 10px; font-weight: 600; }

    .cp-util-bar-pct.cp-healthy { color: var(--cp-status-healthy); }
    .cp-util-bar-pct.cp-review { color: var(--cp-status-critical); }
    .cp-util-bar-pct.cp-critical { color: var(--cp-status-risk); }
    .cp-util-bar-pct.cp-nodata { color: var(--cp-status-nodata); }

    #tblCapacity td.cp-qcell-td {
        font-weight: 600;
        border-right: 1px solid hsl(214 32% 91% / 0.4);
    }

    #tblCapacity td.cp-qcell-td.cp-healthy {
        color: var(--cp-status-healthy);
        background: hsl(142 71% 45% / 0.08);
    }

    #tblCapacity td.cp-qcell-td.cp-review {
        color: var(--cp-status-critical);
        background: hsl(0 72% 51% / 0.08);
    }

    #tblCapacity td.cp-qcell-td.cp-critical {
        color: var(--cp-status-risk);
        background: hsl(25 95% 53% / 0.08);
    }

    #tblCapacity td.cp-qcell-td.cp-nodata {
        color: var(--cp-status-nodata);
        background: transparent;
    }

    /* Outside the current quarter, No Data uses gray text only. */
    #tblCapacity td.cp-qcell-td.cp-nodata,
    #tblCapacity td.cp-qcell-td.cp-nodata:not(.cp-current-quarter) {
        background: transparent !important;
        background-image: none !important;
        color: var(--cp-status-nodata) !important;
    }

    /* Current-quarter highlight takes precedence, including 0% / No Data cells. */
    #tblCapacity td.cp-qcell-td.cp-nodata.cp-current-quarter {
        background-color: #e0f2fe !important;
        background-image: none !important;
        color: var(--cp-status-nodata) !important;
    }

    /* Current-month highlight also applies to 0% / No Data cells. */
    #tblCapacity td.cp-qcell-td.cp-nodata.cp-current-month-view {
        background-color: #e0f2fe !important;
        background-image: none !important;
        color: var(--cp-status-nodata) !important;
    }

    .cp-qcell {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 50px;
        padding: 4px 10px;
        border-radius: 3px;
        font-weight: 600;
        font-size: 11.5px;
    }

    .cp-qcell.cp-healthy { background: hsl(142 71% 45% / 0.08); color: var(--cp-status-healthy); }
    .cp-qcell.cp-review { background: hsl(0 72% 51% / 0.08); color: var(--cp-status-critical); }
    .cp-qcell.cp-critical { background: hsl(25 95% 53% / 0.08); color: var(--cp-status-risk); }
    .cp-qcell.cp-nodata { background: transparent; color: var(--cp-status-nodata); }

    .cp-pagination-footer {
        display: flex !important;
        flex-direction: column;
        gap: 8px;
        justify-content: space-between;
        align-items: flex-start;
        padding: 8px 12px;
        border-top: 1px solid var(--cp-border);
        background: hsl(210 40% 96% / 0.2);
    }

    @media (min-width: 768px) {
        .cp-pagination-footer {
            flex-direction: row;
            align-items: center;
        }
    }

    .cp-pagination-footer #lblRecordCount {
        color: var(--cp-muted-fg);
        font-size: 11.5px;
    }

    .cp-pagination-footer .btn-page-nav {
        width: 24px;
        height: 24px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: var(--cp-card);
        border: 1px solid var(--cp-border);
        border-radius: 6px;
        color: var(--cp-muted-fg);
        cursor: pointer;
        padding: 0;
        font-size: 11.5px;
    }

    .cp-pagination-footer .btn-page-nav:hover:not(:disabled) {
        background: var(--cp-muted);
    }

    .cp-pagination-footer .btn-page-nav:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }

    .cp-pagination-footer .btn-page-current {
        width: 24px;
        height: 24px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background: var(--cp-primary);
        color: var(--cp-primary-fg);
        border: none;
        border-radius: 6px;
        font-size: 11.5px;
        font-weight: 600;
        padding: 0;
    }

    /* Unified pagination style across grid, drawer and detail tab */
    .cp-pagination-footer {
        flex-direction: row !important;
        align-items: center !important;
        justify-content: flex-end !important;
        gap: 12px !important;
    }

    .cp-pagination-footer #lblRecordCount,
    .cp-drawer-footer #cpDrawerRecordCount,
    .cp-detail-tab-pagination #cpTabRecordCount {
        margin-right: 4px;
        color: #2f3b52;
        font-weight: 500;
        white-space: nowrap;
    }

    .cp-pagination-controls {
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .cp-pagination-footer .btn-page-nav,
    .cp-drawer-footer .btn-page-nav,
    .cp-detail-tab-pagination .btn-page-nav {
        width: 30px;
        height: 30px;
        border-radius: 6px;
        border: 1px solid #e2e8f0;
        background: #fff;
        color: #7da2d0;
        font-size: 16px;
        font-weight: 700;
        line-height: 1;
        box-shadow: 0 1px 2px rgba(15, 23, 42, 0.04);
    }

    .cp-pagination-footer .btn-page-nav:hover:not(:disabled),
    .cp-drawer-footer .btn-page-nav:hover:not(:disabled),
    .cp-detail-tab-pagination .btn-page-nav:hover:not(:disabled) {
        background: #f8fbff;
        border-color: #d5e2f1;
        color: #5f8fc8;
    }

    .cp-pagination-footer .btn-page-nav:disabled,
    .cp-drawer-footer .btn-page-nav:disabled,
    .cp-detail-tab-pagination .btn-page-nav:disabled {
        opacity: 0.55;
        color: #b8c7db;
        background: #fff;
    }

    .cp-pagination-footer .btn-page-current,
    .cp-drawer-footer .btn-page-current,
    .cp-detail-tab-pagination .btn-page-current {
        display: none !important;
    }

    .cp-charts-grid {
        display: grid;
        grid-template-columns: minmax(0, 1fr);
        gap: var(--cp-section-gap);
        width: 100%;
        max-width: 100%;
        min-width: 0;
        align-items: stretch;
        margin: 0;
    }

    @media (min-width: 1024px) {
        .cp-charts-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
    }

    .cp-trend-card {
        overflow: visible;
        border: 1px solid var(--cp-border);
        border-radius: var(--cp-radius);
        background: var(--cp-card);
        box-shadow: var(--cp-shadow);
        min-width: 0;
        max-width: 100%;
        display: flex;
        flex-direction: column;
        height: 100%;
        min-height: 0;
    }

    .cp-trend-header {
        display: flex;
        flex-direction: column;
        gap: 10px;
        padding: 12px 16px;
        border-bottom: 1px solid var(--cp-border);
        background: hsl(210 40% 96% / 0.3);
        min-height: 92px;
        box-sizing: border-box;
    }

    @media (min-width: 768px) {
        .cp-trend-header {
            flex-direction: row;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
        }
    }

    .cp-trend-header-text {
        min-width: 0;
        flex: 1 1 auto;
    }

    .cp-trend-title {
        font-size: 14px;
        font-weight: 700;
        color: var(--cp-foreground);
        display: flex;
        align-items: center;
        gap: 8px;
        margin: 0;
        line-height: 1.25;
    }

    .cp-trend-title i { color: var(--cp-primary); font-size: 14px; flex-shrink: 0; }

    .cp-trend-desc {
        font-size: 11.5px;
        color: var(--cp-muted-fg);
        margin: 2px 0 0;
        line-height: 1.4;
        white-space: normal;
        overflow: visible;
        word-wrap: break-word;
    }

    .cp-trend-toggle {
        display: flex;
        border-radius: 8px;
        border: 1px solid var(--cp-border);
        background: var(--cp-card);
        padding: 2px;
        box-shadow: var(--cp-shadow);
        flex-shrink: 0;
        align-self: flex-start;
        margin-top: 0;
    }

    .cp-trend-btn {
        border: none;
        background: transparent;
        padding: 4px 10px;
        font-size: 11.5px;
        font-weight: 600;
        color: var(--cp-muted-fg);
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.15s ease;
        white-space: nowrap;
    }

    .cp-trend-btn:hover { color: var(--cp-foreground); }

    .cp-trend-btn.active {
        background: var(--cp-primary);
        color: var(--cp-primary-fg);
        box-shadow: var(--cp-shadow);
    }

    .cp-trend-filter {
        display: flex;
        flex-direction: column;
        align-items: stretch;
        justify-content: center;
        gap: 6px;
        padding: 8px 16px;
        border-bottom: 1px solid var(--cp-border);
        min-height: 78px;
        box-sizing: border-box;
    }

    .cp-trend-filter .cp-kpi-note {
        width: 100%;
        max-width: 100%;
        box-sizing: border-box;
    }

    .cp-trend-filter .cp-dropdown {
        min-width: 220px;
        max-width: 320px;
        width: 100%;
        z-index: 20;
    }

    .cp-trend-filter .multi-dropdown .cp-dropdown-panel {
        width: 100%;
        min-width: 260px;
        max-height: 300px;
        padding: 8px 8px 0 8px;
        z-index: 30;
    }

    .cp-trend-filter .multi-dropdown .cp-dropdown-options {
        max-height: 200px;
    }

    .cp-trend-option {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 6px 8px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 11.5px;
        margin: 0;
        color: #374151;
    }

    .cp-trend-option:hover { background: #f1f5f9; }

    .cp-trend-option.select-all {
        border-bottom: 1px solid var(--cp-border);
        font-weight: 600;
    }

    .cp-trend-option.is-frozen {
        opacity: 0.45;
        cursor: not-allowed;
        background: transparent;
    }

    .cp-trend-option.is-frozen:hover {
        background: transparent;
    }

    .cp-trend-option.is-frozen input[type=checkbox] {
        cursor: not-allowed;
    }

    .cp-trend-option-label {
        flex: 1;
        min-width: 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .cp-chart-body {
        padding: 8px 10px 4px;
        height: 300px;
        min-height: 300px;
        position: relative;
        flex: 1 1 auto;
        z-index: 1;
    }

    .cp-chart-body canvas {
        width: 100% !important;
        height: 100% !important;
        position: relative;
        z-index: 1;
    }

    .cp-chart-legend {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-items: center;
        gap: 10px 16px;
        padding: 8px 12px 10px;
        min-height: 48px;
        box-sizing: border-box;
    }

    .cp-chart-legend-item {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 10px;
        font-weight: 500;
        color: var(--cp-muted-fg);
    }

    .cp-chart-legend-line {
        position: relative;
        display: inline-block;
        width: 22px;
        height: 2px;
        background: currentColor;
        border-radius: 1px;
    }

    .cp-chart-legend-dot {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: #fff;
        border: 2px solid currentColor;
        box-sizing: border-box;
    }

    #cpTrendChartTooltip {
        position: fixed !important;
        z-index: 30000 !important;
        background: #ffffff !important;
        border: 1px solid #e5e7eb !important;
        box-shadow: 0 8px 20px rgba(15, 23, 42, 0.12) !important;
        padding: 8px 10px !important;
        border-radius: 8px !important;
        pointer-events: none;
        opacity: 0;
        transition: opacity 0.08s ease;
        max-width: 340px;
        min-width: 160px;
        color: #111827;
    }

    .cp-trend-tooltip-title {
        font-size: 11px;
        font-weight: 700;
        color: #111827;
        margin-bottom: 6px;
        line-height: 1.2;
        border-bottom: 1px solid #e5e7eb;
        padding-bottom: 4px;
    }

    .cp-trend-tooltip-item {
        margin: 3px 0;
        font-size: 11px;
        font-weight: 600 !important;
        line-height: 1.35;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 320px;
    }

    /* Loader (copied from MyAlerts) */
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
    .multi-dropdown .cp-dropdown-panel {
        width: 260px;
        min-width: 260px;
        max-height: 280px;
        overflow: hidden;
        padding: 8px 8px 0 8px;
        z-index: 10050;
    }

    .multi-dropdown .cp-dropdown-options {
        max-height: 180px;
    }

    .multi-dropdown .cp-dd-actions {
        margin: 6px -8px 0 -8px;
        padding: 4px 10px 6px;
    }

    #ddBusinessGroupPanel,
    #ddOriginationUnitPanel,
    #ddRoleSkillPanel {
        width: 100%;
    }

    .cp-download-menu {
        position: relative;
        flex: 0 0 26px;
        flex-shrink: 0 !important;
        width: 26px;
        height: 26px;
        z-index: 10050;
        margin-left: 2px;
        margin-right: 0;
    }

    .cp-download-menu .cp-btn-icon {
        width: 26px;
        height: 26px;
    }

    .cp-download-menu .cp-download-dropdown {
        display: none;
        position: absolute;
        top: auto;
        bottom: calc(100% + 4px);
        left: auto;
        right: 0;
        transform: none;
        min-width: 132px;
        max-width: calc(100vw - 24px);
        background: var(--cp-card);
        border: 1px solid var(--cp-border);
        border-radius: 8px;
        box-shadow: 0 8px 24px rgba(15, 23, 42, 0.12);
        z-index: 10051;
        padding: 4px 0;
        list-style: none;
        margin: 0;
        pointer-events: auto;
    }

    .cp-download-menu.open .cp-download-dropdown { display: block; }

    .cp-download-dropdown li {
        cursor: pointer !important;
    }

    .cp-download-dropdown li a,
    .cp-download-dropdown .cp-download-option-btn {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 12px;
        font-size: 11.5px;
        color: var(--cp-foreground);
        text-decoration: none;
        width: 100%;
        border: 0;
        background: transparent;
        text-align: left;
        cursor: pointer !important;
        pointer-events: auto;
    }

    .cp-download-dropdown li a:hover,
    .cp-download-dropdown .cp-download-option-btn:hover,
    .cp-download-dropdown li:hover .cp-download-option-btn {
        background: var(--cp-muted);
    }

    .multi-option {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 6px 8px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 11.5px;
        margin: 0;
        color: #374151;
    }

    .multi-option:hover { background: #f1f5f9; }
    .multi-option input[type=checkbox] { margin: 0; cursor: pointer; }
    .multi-option.select-all {
        border-bottom: 1px solid var(--cp-border);
        font-weight: 600;
        margin-bottom: 2px;
        border-radius: 0;
    }

    .detail-row td { background: var(--cp-card); }

    .cp-month-group-head {
        font-weight: 600;
        color: #374151;
        user-select: none;
        text-align: center;
        vertical-align: middle;
    }

    .cp-month-nav-row {
        display: inline-flex;
        flex-direction: row;
        flex-wrap: nowrap;
        justify-content: center;
        align-items: center;
        gap: 8px;
        white-space: nowrap;
        line-height: 1.2;
    }

    .cp-month-nav-row .cp-month-nav-label {
        display: inline-block;
        font-weight: 700;
        color: #374151;
    }

        .cp-month-group-head i {
            font-size: 10px;
            color: #1359a6;
            margin: 0;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
        }

        .cp-month-group-head i.cp-month-arrow-disabled {
            opacity: 0.35;
            cursor: default;
            pointer-events: none;
        }

    .cp-month-nav-btn {
        border: none;
        background: transparent;
        padding: 0 6px;
        line-height: 1;
        cursor: pointer;
        color: #1359a6;
        vertical-align: middle;
    }

    .cp-month-nav-wrap {
        display: inline-flex;
        align-items: center;
        vertical-align: middle;
    }

    /* All CP Bootstrap tooltips: black background + white text */
    .tooltip.cp-border-tooltip,
    .tooltip.cp-nav-tooltip {
        z-index: 20000;
        pointer-events: none !important; /* never trap mouse — hide as soon as cursor leaves trigger */
    }

    .tooltip.cp-border-tooltip .tooltip-inner,
    .tooltip.cp-nav-tooltip .tooltip-inner {
        background-color: #111827 !important;
        color: #ffffff !important;
        box-shadow: 0 4px 14px rgba(15, 23, 42, 0.35) !important;
        border: 1px solid #111827 !important;
        padding: 4px 8px;
        font-size: 12px;
        font-weight: 500;
        max-width: 320px;
        text-align: left;
        pointer-events: none !important;
    }

    .tooltip.cp-border-tooltip .tooltip-arrow,
    .tooltip.cp-nav-tooltip .tooltip-arrow {
        display: none !important;
    }

    /* Fallback: any Bootstrap tooltip on Capacity Planning page */
    body#CapacityPlanning .tooltip {
        pointer-events: none !important;
    }

    body#CapacityPlanning .tooltip .tooltip-inner {
        background-color: #111827 !important;
        color: #ffffff !important;
        border: 1px solid #111827 !important;
        pointer-events: none !important;
    }

    body#CapacityPlanning .tooltip .tooltip-arrow::before {
        border-top-color: #111827 !important;
        border-bottom-color: #111827 !important;
        border-left-color: #111827 !important;
        border-right-color: #111827 !important;
    }

    .cp-month-nav-btn i {
        margin: 0 !important;
        pointer-events: none;
    }

    .cp-month-nav-btn:hover:not(.cp-month-arrow-disabled):not(:disabled) {
        color: var(--cp-primary);
    }

    .cp-month-arrow-disabled {
        color: var(--cp-muted-fg) !important;
        cursor: default !important;
        pointer-events: none;
        opacity: 0.4;
    }

    .cp-quarter-head.cp-expanded .cp-quarter-label i.fa-chevron-right:before { content: "\f077"; }

    .cp-detail-list-wrap { padding: 4px 0; }

    table.cp-detail-list-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 11.5px;
        table-layout: fixed;
    }

    table.cp-detail-list-table th,
    table.cp-detail-list-table td {
        padding: 8px 12px;
        border-bottom: 1px solid var(--cp-border);
        text-align: left;
        vertical-align: middle;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    table.cp-detail-list-table .cp-col-num { width: 48px; text-align: center; }
    table.cp-detail-list-table .cp-col-project { width: 22%; }
    table.cp-detail-list-table .cp-col-employee { width: 18%; }
    table.cp-detail-list-table .cp-col-account { width: 16%; }
    table.cp-detail-list-table .cp-col-role { width: 18%; }
    table.cp-detail-list-table .cp-col-money { width: 14%; text-align: right; }
    table.cp-detail-list-table .cp-col-date { width: 12%; }
    table.cp-detail-list-table .cp-col-status { width: 10%; }

    table.cp-detail-list-table th {
        background: hsl(210 40% 96% / 0.35);
        font-weight: 600;
        color: var(--cp-muted-fg);
    }

    /* Empty state: center message like offcanvas (must win over td text-align:left) */
    table.cp-detail-list-table tr.cp-empty-row td,
    table.cp-drawer-table tr.cp-empty-row td {
        border-bottom: none !important;
        text-align: center !important;
        vertical-align: middle !important;
        white-space: normal !important;
        overflow: visible !important;
        text-overflow: clip !important;
        padding: 56px 16px !important;
        min-height: 180px;
        height: 220px;
        color: var(--cp-muted-fg) !important;
        font-size: 12px !important;
    }

    table.cp-detail-list-table tr.cp-empty-row .cp-empty-message,
    table.cp-drawer-table tr.cp-empty-row .cp-empty-message {
        display: block;
        width: 100%;
        text-align: center;
        color: var(--cp-muted-fg);
        font-size: 12px;
        line-height: 1.4;
    }

    .cp-text-center {
        text-align: center !important;
        vertical-align: middle !important;
    }
</style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="CapacityPlanning">
    <div id="CapacityPreloader" class="preloader"></div>
    <div class="loader-overlay" id="loaderOverlay" style="display: none;">
        <div class="loader"></div>
    </div>

    <form id="form1" runat="server">
        <div id="CapacityWrapper" style="display: none;">
            <main class="cp-main">
                <div class="cp-container">

                    <div class="cp-page-header">
                        <div>
                            <h1 class="cp-title"><span class="cp-title-icon"><i class="fa fa-users" aria-hidden="true"></i></span><%=MyBase.GetResourceString("C_CapacityPlanning") %></h1>
                            <p class="cp-subtitle"><%=MyBase.GetResourceString("C_Subtitle") %></p>
                        </div>
                        <div class="cp-period-toggle">
                            <button type="button" id="btnMonthView" class="cp-period-btn active"><%=MyBase.GetResourceString("C_Month") %></button>
                            <button type="button" id="btnQuarterView" class="cp-period-btn"><%=MyBase.GetResourceString("C_Quarter") %></button>
                        </div>
                    </div>

                    <div class="cp-kpi-section">
                        <div class="cp-kpi-grid">
                            <div class="kpi-card">
                                <div class="kpi-icon total-strength-icon"><i class="fa fa-users"></i></div>
                                <div class="kpi-content">
                                    <div class="kpi-title" data-cp-full="<%=MyBase.GetResourceString("C_TotalStrength") %>"><%=MyBase.GetResourceString("C_TotalStrength") %></div>
                                    <div class="kpi-value"><span id="lblTotalStrength">0</span></div>
                                </div>
                            </div>
                            <div class="kpi-card">
                                <div class="kpi-icon allocated-icon"><i class="fa fa-user-check"></i></div>
                                <div class="kpi-content">
                                    <div class="kpi-title" data-cp-full="<%=MyBase.GetResourceString("C_Allocated") %>"><%=MyBase.GetResourceString("C_Allocated") %></div>
                                    <div class="kpi-value">
                                        <span id="lblAllocated">0</span>
                                        <small id="lblAllocatedPct">0%</small>
                                    </div>
                                </div>
                            </div>
                            <div class="kpi-card">
                                <div class="kpi-icon bench-icon"><i class="fa fa-user-minus"></i></div>
                                <div class="kpi-content">
                                    <div class="kpi-title" data-cp-full="<%=MyBase.GetResourceString("C_Bench") %>"><%=MyBase.GetResourceString("C_Bench") %></div>
                                    <div class="kpi-value">
                                        <span id="lblBench">0</span>
                                        <small id="lblBenchPct">0%</small>
                                    </div>
                                </div>
                            </div>
                            <div class="kpi-card">
                                <div class="kpi-icon project-icon"><i class="fa fa-briefcase"></i></div>
                                <div class="kpi-content">
                                    <div class="kpi-title" data-cp-full="<%=MyBase.GetResourceString("C_ProjectRequests") %>"><%=MyBase.GetResourceString("C_ProjectRequests") %></div>
                                    <div class="kpi-value"><span id="lblProjectRequests">0</span></div>
                                </div>
                            </div>
                            <div class="kpi-card">
                                <div class="kpi-icon opportunity-icon"><i class="fa fa-bullseye"></i></div>
                                <div class="kpi-content">
                                    <div class="kpi-title" data-cp-full="<%=MyBase.GetResourceString("C_OpportunityRequests") %>"><%=MyBase.GetResourceString("C_OpportunityRequests") %></div>
                                    <div class="kpi-value"><span id="lblOpportunityRequests">0</span></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <p class="cp-kpi-note">
                        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                        <span><strong>Note :</strong> All Card Details is as per Current Month / Quarter</span>
                    </p>

                    <div class="filter-section cp-filter-bar">
                        <div class="filter-left">
                            <div class="view-switch">
                                <button type="button" id="btnByRole" class="btn-view active"><%=MyBase.GetResourceString("C_ByRole") %></button>
                                <button type="button" id="btnBySkill" class="btn-view"><%=MyBase.GetResourceString("C_BySkill") %></button>
                            </div>
                            <div class="cp-dropdown multi-dropdown" id="ddBusinessGroup">
                                <button type="button" class="cp-dropdown-toggle" id="ddBusinessGroupToggle"><%=MyBase.GetResourceString("C_SelectBusinessGroup") %></button>
                                <div class="cp-dropdown-panel">
                                    <input type="text" class="cp-dropdown-search" placeholder="Search Business Group..." autocomplete="off">
                                    <div class="cp-dropdown-options" id="ddBusinessGroupPanel"></div>
                                    <div class="cp-dd-actions">
                                        <button type="button" class="cp-dd-clear">Clear</button>
                                        <button type="button" class="cp-dd-close"><%=MyBase.GetResourceString("C_Close") %></button>
                                    </div>
                                </div>
                            </div>
                            <div class="cp-dropdown multi-dropdown" id="ddOriginationUnit">
                                <button type="button" class="cp-dropdown-toggle" id="ddOriginationUnitToggle"><%=MyBase.GetResourceString("C_SelectOriginationUnit") %></button>
                                <div class="cp-dropdown-panel">
                                    <input type="text" class="cp-dropdown-search" placeholder="Search Organization Unit..." autocomplete="off">
                                    <div class="cp-dropdown-options" id="ddOriginationUnitPanel"></div>
                                    <div class="cp-dd-actions">
                                        <button type="button" class="cp-dd-clear">Clear</button>
                                        <button type="button" class="cp-dd-close"><%=MyBase.GetResourceString("C_Close") %></button>
                                    </div>
                                </div>
                            </div>
                            <div class="cp-dropdown multi-dropdown" id="ddRoleSkill">
                                <button type="button" class="cp-dropdown-toggle" id="ddRoleSkillToggle"><%=MyBase.GetResourceString("C_SelectRole") %></button>
                                <div class="cp-dropdown-panel">
                                    <input type="text" class="cp-dropdown-search" placeholder="Search Role..." autocomplete="off" id="ddRoleSkillSearch">
                                    <div class="cp-dropdown-options" id="ddRoleSkillPanel"></div>
                                    <div class="cp-dd-actions">
                                        <button type="button" class="cp-dd-clear">Clear</button>
                                        <button type="button" class="cp-dd-close"><%=MyBase.GetResourceString("C_Close") %></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="filter-right">
                            <div class="capacity-legend">
                                <span class="legend-item"><span class="dot dot-green"></span>Healthy (&gt;=95%)</span>
                                <span class="legend-item"><span class="dot dot-red"></span>Need to Review (51% – 94%)</span>
                                <span class="legend-item"><span class="dot dot-orange"></span>Critical (1% – 50%)</span>
                                <span class="legend-item"><span class="dot dot-gray"></span>No Data (0%)</span>
                            </div>
                            <div class="cp-download-menu" id="cpDownloadMenu">
                                <a href="javascript:void(0);" class="cp-btn-icon" id="cpDownloadToggle" aria-label="<%=MyBase.GetResourceString("C_Download") %>">
                                    <i class="fas fa-download"></i>
                                </a>
                                <ul class="cp-download-dropdown">
                                    <li data-format="PDF">
                                        <button type="button" id="cpDownloadPdfBtn" class="cp-download-option-btn" data-format="PDF">
                                            <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18" alt=""> <%=MyBase.GetResourceString("C_Pdf") %>
                                        </button>
                                    </li>
                                    <li data-format="EXCEL">
                                        <button type="button" id="cpDownloadExcelBtn" class="cp-download-option-btn" data-format="EXCEL">
                                            <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18" alt=""> <%=MyBase.GetResourceString("C_Xlsx") %>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="cp-applied-filters" id="cpAppliedFilters" aria-live="polite">
                        <div class="cp-applied-filters-title">Applied Filters:</div>
                        <div class="cp-applied-filters-inner" id="cpAppliedFiltersInner"></div>
                    </div>

                    <div class="cp-grid-card">
                        <div class="cp-grid-container">
                            <table id="tblCapacity" class="table align-middle">
                                <colgroup id="tblCapacityColGroup"></colgroup>
                                <thead id="tblCapacityHead">
                                    <tr>
                                        <th><span class="cp-role-cell"><%=MyBase.GetResourceString("C_Role") %> <i class="fas fa-chevron-down cp-sort-icon"></i></span></th>
                                        <th class="cp-col-center"><%=MyBase.GetResourceString("C_TotalStrength") %></th>
                                        <th class="cp-col-center"><%=MyBase.GetResourceString("C_Allocated") %></th>
                                        <th class="cp-col-center"><%=MyBase.GetResourceString("C_Bench") %></th>
                                        <th class="cp-col-center"><%=MyBase.GetResourceString("C_Requests") %></th>
                                        <th class="cp-util-col"><%=MyBase.GetResourceString("C_UtilizationPercent") %></th>
                                        <th class="cp-quarter-head cp-q1">
                                            <button type="button" class="cp-quarter-label"><i class="fas fa-chevron-right"></i> Q1 2026</button>
                                            <div class="cp-quarter-sub"><%=MyBase.GetResourceString("C_UtilizationPercent") %></div>
                                        </th>
                                        <th class="cp-quarter-head cp-q2">
                                            <button type="button" class="cp-quarter-label"><i class="fas fa-chevron-right"></i> Q2 2026</button>
                                            <div class="cp-quarter-sub"><%=MyBase.GetResourceString("C_UtilizationPercent") %></div>
                                        </th>
                                        <th class="cp-quarter-head cp-q3">
                                            <button type="button" class="cp-quarter-label"><i class="fas fa-chevron-right"></i> Q3 2026</button>
                                            <div class="cp-quarter-sub"><%=MyBase.GetResourceString("C_UtilizationPercent") %></div>
                                        </th>
                                        <th class="cp-quarter-head cp-q4">
                                            <button type="button" class="cp-quarter-label"><i class="fas fa-chevron-right"></i> Q4 2026</button>
                                            <div class="cp-quarter-sub"><%=MyBase.GetResourceString("C_UtilizationPercent") %></div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="tblCapacityBody"></tbody>
                            </table>
                        </div>
                        <div class="cp-pagination-footer">
                            <span id="lblRecordCount">Total Records: 0</span>
                            <div class="cp-pagination-controls">
                                <span class="cp-month-nav-wrap" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-cp-tip="1" title="Previous">
                                    <button type="button" class="btn-page-nav" id="btnPrev" aria-label="Previous">&laquo;</button>
                                </span>
                                <button type="button" class="btn-page-current" id="btnCurrentPage">1</button>
                                <span class="cp-month-nav-wrap" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-cp-tip="1" title="Next">
                                    <button type="button" class="btn-page-nav" id="btnNext" aria-label="Next">&raquo;</button>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="cp-charts-grid">
                        <div class="cp-trend-card">
                            <div class="cp-trend-header">
                                <div class="cp-trend-header-text">
                                    <h3 class="cp-trend-title"><i class="fas fa-chart-line"></i> <%=MyBase.GetResourceString("C_TrendRoleWise") %></h3>
                                    <p class="cp-trend-desc"><%=MyBase.GetResourceString("C_TrendRoleDesc") %></p>
                                </div>
                                <div class="cp-trend-toggle">
                                    <button type="button" class="cp-trend-btn active"><%=MyBase.GetResourceString("C_UtilizationPercent") %></button>
                                    <button type="button" class="cp-trend-btn"><%=MyBase.GetResourceString("C_Allocated") %></button>
                                    <button type="button" class="cp-trend-btn"><%=MyBase.GetResourceString("C_Bench") %></button>
                                </div>
                            </div>
                            <div class="cp-trend-filter">
                                <p class="cp-kpi-note">
                                    <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                                    <span><strong>Note :</strong> Only 5 records can be displayed at a time. Other records are disabled.</span>
                                </p>
                                <div class="cp-dropdown multi-dropdown" id="ddRoleTrend">
                                    <button type="button" class="cp-dropdown-toggle" id="ddRoleTrendToggle"><%=MyBase.GetResourceString("C_SelectRole") %></button>
                                    <div class="cp-dropdown-panel">
                                        <input type="text" class="cp-dropdown-search" placeholder="Search Role..." autocomplete="off">
                                        <div class="cp-dropdown-options" id="ddRoleTrendPanel"></div>
                                        <div class="cp-dd-actions">
                                            <button type="button" class="cp-dd-clear">Clear</button>
                                            <button type="button" class="cp-dd-close"><%=MyBase.GetResourceString("C_Close") %></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="cp-chart-body"><canvas id="roleTrendChart"></canvas></div>
                            <div class="cp-chart-legend" id="roleTrendLegend"></div>
                        </div>

                        <div class="cp-trend-card">
                            <div class="cp-trend-header">
                                <div class="cp-trend-header-text">
                                    <h3 class="cp-trend-title"><i class="fas fa-chart-line"></i> <%=MyBase.GetResourceString("C_TrendSkillWise") %></h3>
                                    <p class="cp-trend-desc"><%=MyBase.GetResourceString("C_TrendSkillDesc") %></p>
                                </div>
                                <div class="cp-trend-toggle">
                                    <button type="button" class="cp-trend-btn active"><%=MyBase.GetResourceString("C_UtilizationPercent") %></button>
                                    <button type="button" class="cp-trend-btn"><%=MyBase.GetResourceString("C_Allocated") %></button>
                                    <button type="button" class="cp-trend-btn"><%=MyBase.GetResourceString("C_Bench") %></button>
                                </div>
                            </div>
                            <div class="cp-trend-filter">
                                <p class="cp-kpi-note">
                                    <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
                                    <span><strong>Note :</strong> Only 5 records can be displayed at a time. Other records are disabled.</span>
                                </p>
                                <div class="cp-dropdown multi-dropdown" id="ddSkillTrend">
                                    <button type="button" class="cp-dropdown-toggle" id="ddSkillTrendToggle"><%=MyBase.GetResourceString("C_SelectSkill") %></button>
                                    <div class="cp-dropdown-panel">
                                        <input type="text" class="cp-dropdown-search" placeholder="Search Skill..." autocomplete="off">
                                        <div class="cp-dropdown-options" id="ddSkillTrendPanel"></div>
                                        <div class="cp-dd-actions">
                                            <button type="button" class="cp-dd-clear">Clear</button>
                                            <button type="button" class="cp-dd-close"><%=MyBase.GetResourceString("C_Close") %></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="cp-chart-body"><canvas id="skillTrendChart"></canvas></div>
                            <div class="cp-chart-legend" id="skillTrendLegend"></div>
                        </div>
                    </div>

                </div>
            </main>
        </div>
    </form>

    <div class="clearfix"></div>

    <div id="cpDrawerOverlay" class="cp-drawer-overlay">
        <div class="cp-drawer-panel" onclick="event.stopPropagation();">
            <div class="cp-drawer-header">
                <div>
                    <h3 class="cp-drawer-title" id="cpDrawerTitle"></h3>
                    <p class="cp-drawer-subtitle" id="cpDrawerSubtitle"></p>
                </div>
                <button type="button" class="btn btn-sm btn-danger-modern cp-drawer-close" id="cpDrawerClose" aria-label="<%=MyBase.GetResourceString("C_Close") %>" title="<%=MyBase.GetResourceString("C_Close") %>">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="cp-drawer-body">
                <table class="cp-drawer-table">
                    <thead id="cpDrawerHead"></thead>
                    <tbody id="cpDrawerBody"></tbody>
                </table>
            </div>
            <div class="cp-drawer-footer cp-pagination-footer">
                <span id="cpDrawerRecordCount">Total Records: 0</span>
                <div class="cp-pagination-controls">
                    <span class="cp-month-nav-wrap" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-cp-tip="1" title="Previous">
                        <button type="button" class="btn-page-nav" id="btnDrawerPrev" aria-label="Previous">&laquo;</button>
                    </span>
                    <button type="button" class="btn-page-current" id="btnDrawerCurrentPage">1</button>
                    <span class="cp-month-nav-wrap" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-cp-tip="1" title="Next">
                        <button type="button" class="btn-page-nav" id="btnDrawerNext" aria-label="Next">&raquo;</button>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString()%>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var cpResources = {
            month: '<%=MyBase.GetResourceString("C_Month")%>',
            quarter: '<%=MyBase.GetResourceString("C_Quarter")%>',
            totalStrength: '<%=MyBase.GetResourceString("C_TotalStrength")%>',
            allocated: '<%=MyBase.GetResourceString("C_Allocated")%>',
            bench: '<%=MyBase.GetResourceString("C_Bench")%>',
            requests: '<%=MyBase.GetResourceString("C_Requests")%>',
            utilizationPercent: '<%=MyBase.GetResourceString("C_UtilizationPercent")%>',
            role: '<%=MyBase.GetResourceString("C_Role")%>',
            skill: '<%=MyBase.GetResourceString("C_Skill")%>',
            roleLabel: '<%=MyBase.GetResourceString("C_RoleLabel")%>',
            rolesLabel: '<%=MyBase.GetResourceString("C_RolesLabel")%>',
            skillLabel: '<%=MyBase.GetResourceString("C_SkillLabel")%>',
            skillsLabel: '<%=MyBase.GetResourceString("C_SkillsLabel")%>',
            selectBusinessGroup: '<%=MyBase.GetResourceString("C_SelectBusinessGroup")%>',
            selectOriginationUnit: '<%=MyBase.GetResourceString("C_SelectOriginationUnit")%>',
            selectRole: '<%=MyBase.GetResourceString("C_SelectRole")%>',
            selectSkill: '<%=MyBase.GetResourceString("C_SelectSkill")%>',
            allBusinessGroup: '<%=MyBase.GetResourceString("C_AllBusinessGroup")%>',
            allOriginationUnit: '<%=MyBase.GetResourceString("C_AllOriginationUnit")%>',
            allRoles: '<%=MyBase.GetResourceString("C_AllRoles")%>',
            allSkills: '<%=MyBase.GetResourceString("C_AllSkills")%>',
            selected: '<%=MyBase.GetResourceString("C_Selected")%>',
            showingZeroRecords: '<%=MyBase.GetResourceString("C_ShowingZeroRecords")%>',
            showingToOf: '<%=MyBase.GetResourceString("C_ShowingToOf")%>',
            showingSingleRecord: '<%=MyBase.GetResourceString("C_ShowingSingleRecord")%>',
            showingMultipleRecords: '<%=MyBase.GetResourceString("C_ShowingMultipleRecords")%>',
            previousPage: '<%=MyBase.GetResourceString("C_PreviousPage")%>',
            nextPage: '<%=MyBase.GetResourceString("C_NextPage")%>',
            noItemsInView: '<%=MyBase.GetResourceString("C_NoItemsInView")%>',
            noDataForView: '<%=MyBase.GetResourceString("C_NoDataForView")%>',
            noRecords: '<%=MyBase.GetResourceString("C_NoRecords")%>',
            noRecordsFound: '<%=MyBase.GetResourceString("C_NoRecordsFound")%>',
            overview: '<%=MyBase.GetResourceString("C_Overview")%>',
            allocatedToProject: 'Project Allocated',
            projectRequest: '<%=MyBase.GetResourceString("C_ProjectRequest")%>',
            opportunityRequests: '<%=MyBase.GetResourceString("C_OpportunityRequests")%>',
            benchDetails: '<%=MyBase.GetResourceString("C_BenchDetails")%>',
            anticipatedExitsDetails: '<%=MyBase.GetResourceString("C_AnticipatedExitsDetails")%>',
            joiningPoolDetails: '<%=MyBase.GetResourceString("C_JoiningPoolDetails")%>',
            quarterWisePlanning: '<%=MyBase.GetResourceString("C_QuarterWisePlanning")%>',
            quarterWiseMonthLevel: '<%=MyBase.GetResourceString("C_QuarterWiseMonthLevel")%>',
            monthWisePlanning: '<%=MyBase.GetResourceString("C_MonthWisePlanning")%>',
            healthy: '<%=MyBase.GetResourceString("C_Healthy")%>',
            needToReview: '<%=MyBase.GetResourceString("C_NeedToReview")%>',
            critical: '<%=MyBase.GetResourceString("C_Critical")%>',
            noData: '<%=MyBase.GetResourceString("C_NoData")%>',
            resourceName: '<%=MyBase.GetResourceString("C_ResourceName")%>',
            projectName: '<%=MyBase.GetResourceString("C_ProjectName")%>',
            projectRole: '<%=MyBase.GetResourceString("C_ProjectRole")%>',
            costPerHour: '<%=MyBase.GetResourceString("C_CostPerHour")%>',
            ratePerHour: '<%=MyBase.GetResourceString("C_RatePerHour")%>',
            employee: '<%=MyBase.GetResourceString("C_Employee")%>',
            experience: '<%=MyBase.GetResourceString("C_Experience")%>',
            primarySkill: '<%=MyBase.GetResourceString("C_PrimarySkill")%>',
            availableFrom: '<%=MyBase.GetResourceString("C_AvailableFrom")%>',
            agingInDays: '<%=MyBase.GetResourceString("C_AgingInDays")%>',
            location: '<%=MyBase.GetResourceString("C_Location")%>',
            status: '<%=MyBase.GetResourceString("C_Status")%>',
            requestId: '<%=MyBase.GetResourceString("C_RequestId")%>',
            project: '<%=MyBase.GetResourceString("C_Project")%>',
            businessGroup: '<%=MyBase.GetResourceString("C_BusinessGroup")%>',
            requiredFrom: '<%=MyBase.GetResourceString("C_RequiredFrom")%>',
            headcount: '<%=MyBase.GetResourceString("C_Headcount")%>',
            opportunity: '<%=MyBase.GetResourceString("C_Opportunity")%>',
            client: '<%=MyBase.GetResourceString("C_Client")%>',
            stage: '<%=MyBase.GetResourceString("C_Stage")%>',
            probability: '<%=MyBase.GetResourceString("C_Probability")%>',
            requestsStartDate: '<%=MyBase.GetResourceString("C_RequestsStartDate")%>',
            currentProject: '<%=MyBase.GetResourceString("C_CurrentProject")%>',
            exitDate: '<%=MyBase.GetResourceString("C_ExitDate")%>',
            reason: '<%=MyBase.GetResourceString("C_Reason")%>',
            candidate: '<%=MyBase.GetResourceString("C_Candidate")%>',
            offeredRole: '<%=MyBase.GetResourceString("C_OfferedRole")%>',
            joiningDate: '<%=MyBase.GetResourceString("C_JoiningDate")%>',
            source: '<%=MyBase.GetResourceString("C_Source")%>',
            invalidExportFormat: '<%=MyBase.GetResourceString("A_InvalidExportFormat")%>',
            recordsNotAvailable: '<%=MyBase.GetResourceString("A_RecordsNotAvailable")%>',
            requestFailed: '<%=MyBase.GetResourceString("A_RequestFailed")%>',
            unableToDownloadReport: '<%=MyBase.GetResourceString("A_UnableToDownloadReport")%>'
        };

        function formatCpShowingToOf(start, end, total, label) {
            return formatCpTotalRecords(total);
        }

        function formatCpShowingRecords(count) {
            return formatCpTotalRecords(count);
        }

        function formatCpTotalRecords(count) {
            var total = (count === null || count === undefined || isNaN(count)) ? 0 : Number(count);
            return 'Total Records: ' + formatCpNumberWithCommas(total);
        }

        function formatCpNumberWithCommas(value) {
            if (value === null || value === undefined || value === '') return '';
            var str = String(value).trim();
            var num = parseFloat(str.replace(/,/g, '').replace(/[^0-9.\-]/g, ''));
            if (isNaN(num)) return str;
            var abs = Math.abs(num);
            var fraction = abs - Math.floor(abs + 1e-10);
            if (fraction < 0.0000001) {
                return Math.round(num).toLocaleString('en-US');
            }
            return num.toLocaleString('en-US', { minimumFractionDigits: 0, maximumFractionDigits: 2 });
        }

        function formatCpHoursDisplay(value) {
            if (value === null || value === undefined || value === '') return '0';
            var str = String(value).trim();
            var hm = str.match(/^(-)?(\d{1,3}(?:,\d{3})*|\d+):(\d{1,2})(?::(\d{1,2}))?$/);
            if (hm) {
                var hoursNum = parseInt(String(hm[2]).replace(/,/g, ''), 10);
                if (isNaN(hoursNum)) return str;
                var hours = hoursNum.toLocaleString('en-US', { maximumFractionDigits: 0 });
                var result = (hm[1] || '') + hours + ':' + hm[3];
                if (hm[4] !== undefined) result += ':' + hm[4];
                return result;
            }
            return formatCpNumberWithCommas(str);
        }

        function formatCpCountDisplay(value) {
            if (value === null || value === undefined || value === '') return formatCpNumberWithCommas(0);
            return formatCpNumberWithCommas(value);
        }

        function isCpPlainNumericValue(value) {
            if (value === null || value === undefined || value === '') return false;
            var str = String(value).trim();
            if (/^\d{1,2}\s+[A-Za-z]{3}\s+\d{4}$/.test(str)) return false;
            var cleaned = str.replace(/,/g, '');
            if (cleaned.indexOf('%') > -1) return false;
            return /^-?\d+(\.\d+)?$/.test(cleaned);
        }

        function formatCpRoleName(name) {
            var full = name == null ? '' : String(name);
            var maxLen = 20;
            var truncated = full.length > maxLen;
            var display = truncated ? full.substring(0, maxLen) + '...' : full;
            return {
                full: full,
                display: display,
                truncated: truncated,
                tipAttrs: truncated ? cpBsTooltipAttrs(full) : '',
                titleAttr: full.replace(/"/g, '&quot;')
            };
        }

        function cpEscAttr(value) {
            return String(value == null ? '' : value)
                .replace(/&/g, '&amp;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;');
        }

        function cpBsTooltipAttrs(fullText, placement) {
            var text = String(fullText == null ? '' : fullText).trim();
            if (!text) return '';
            return ' data-bs-toggle="tooltip" data-bs-placement="' + (placement || 'top') +
                '" data-bs-container="body" data-cp-tip="1" title="' + cpEscAttr(text) + '"';
        }

        function cpRoleNameHtml(roleName) {
            return '<span class="cp-role-name"' +
                (roleName.truncated ? ' data-cp-full="' + cpEscAttr(roleName.full) + '"' + roleName.tipAttrs : '') +
                '>' + roleName.display + '</span>';
        }

        function hideAllCpBootstrapTooltips() {
            try {
                $('[data-cp-tip="1"]').each(function () {
                    try {
                        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                            var tip = bootstrap.Tooltip.getInstance(this);
                            if (tip) tip.hide();
                        } else if (typeof $(this).tooltip === 'function') {
                            $(this).tooltip('hide');
                        }
                    } catch (eTip) { /* ignore */ }
                });
            } catch (eAll) { /* ignore */ }

            // Remove orphaned tip nodes left in body after dispose / re-render
            try {
                $('body > .tooltip').remove();
                $('.tooltip.show').remove();
            } catch (eDom) { /* ignore */ }

            if (typeof hideCpTrendTooltip === 'function') {
                try { hideCpTrendTooltip(); } catch (eChart) { /* ignore */ }
            }
        }

        function bindCpTooltipHideOnLeave(el) {
            if (!el) return;
            $(el).off('.cpTipHide')
                .on('mouseleave.cpTipHide blur.cpTipHide', function () {
                    try {
                        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                            var tip = bootstrap.Tooltip.getInstance(el);
                            if (tip) tip.hide();
                        } else if (typeof $(el).tooltip === 'function') {
                            $(el).tooltip('hide');
                        }
                    } catch (e) { /* ignore */ }
                    // Clear any orphan tip immediately
                    try { $('body > .tooltip').remove(); } catch (e2) { /* ignore */ }
                });
        }

        function disposeCpBootstrapTooltips(root) {
            var $root = $(root || document);
            $root.find('[data-cp-tip="1"]').each(function () {
                try {
                    if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                        var inst = bootstrap.Tooltip.getInstance(this);
                        if (inst) {
                            inst.hide();
                            inst.dispose();
                        }
                    } else if (typeof $(this).tooltip === 'function') {
                        $(this).tooltip('hide');
                        $(this).tooltip('dispose');
                    }
                } catch (e) { /* ignore */ }
                $(this).off('.cpTipHide .cpTip .cpNavTip');
                $(this).removeAttr('data-cp-tip data-bs-toggle data-bs-placement data-bs-container data-bs-original-title title');
            });
            try { $('body > .tooltip').remove(); } catch (eDom) { /* ignore */ }
        }

        function initCpBootstrapTooltipEl(el, fullText) {
            if (!el || !fullText) return;
            var text = String(fullText).trim();
            if (!text) return;
            try {
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var existing = bootstrap.Tooltip.getInstance(el);
                    if (existing) {
                        existing.hide();
                        existing.dispose();
                    }
                    el.setAttribute('data-bs-toggle', 'tooltip');
                    el.setAttribute('data-bs-placement', 'top');
                    el.setAttribute('data-bs-container', 'body');
                    el.setAttribute('data-cp-tip', '1');
                    el.setAttribute('title', text);
                    new bootstrap.Tooltip(el, {
                        container: 'body',
                        placement: 'top',
                        trigger: 'hover',
                        delay: { show: 0, hide: 0 },
                        animation: false,
                        customClass: 'cp-border-tooltip'
                    });
                    bindCpTooltipHideOnLeave(el);
                } else if (typeof $(el).tooltip === 'function') {
                    $(el).attr({
                        'data-bs-toggle': 'tooltip',
                        'data-bs-placement': 'top',
                        'data-cp-tip': '1',
                        title: text
                    }).tooltip({
                        container: 'body',
                        placement: 'top',
                        trigger: 'hover',
                        delay: { show: 0, hide: 0 },
                        animation: false,
                        customClass: 'cp-border-tooltip'
                    });
                    bindCpTooltipHideOnLeave(el);
                } else {
                    el.setAttribute('title', text);
                    el.setAttribute('data-cp-tip', '1');
                }
            } catch (e) {
                el.setAttribute('title', text);
                el.setAttribute('data-cp-tip', '1');
            }
        }

        function initCpNavTooltipEl(el, fullText) {
            if (!el || !fullText) return;
            var text = String(fullText).trim();
            if (!text) return;
            try {
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var existing = bootstrap.Tooltip.getInstance(el);
                    if (existing) {
                        existing.hide();
                        existing.dispose();
                    }
                    el.setAttribute('data-bs-toggle', 'tooltip');
                    el.setAttribute('data-bs-placement', 'top');
                    el.setAttribute('data-bs-container', 'body');
                    el.setAttribute('data-cp-tip', '1');
                    el.setAttribute('title', text);
                    new bootstrap.Tooltip(el, {
                        container: 'body',
                        placement: 'top',
                        trigger: 'hover',
                        delay: { show: 0, hide: 0 },
                        animation: false,
                        customClass: 'cp-border-tooltip',
                        fallbackPlacements: [],
                        popperConfig: function (defaultConfig) {
                            var modifiers = (defaultConfig && defaultConfig.modifiers) ? defaultConfig.modifiers.slice() : [];
                            modifiers.push({
                                name: 'flip',
                                options: { fallbackPlacements: [] }
                            });
                            modifiers.push({
                                name: 'preventOverflow',
                                options: { altAxis: false }
                            });
                            return Object.assign({}, defaultConfig, {
                                placement: 'top',
                                strategy: 'fixed',
                                modifiers: modifiers
                            });
                        }
                    });
                    bindCpTooltipHideOnLeave(el);
                } else if (typeof $(el).tooltip === 'function') {
                    $(el).attr({
                        'data-bs-toggle': 'tooltip',
                        'data-bs-placement': 'top',
                        'data-cp-tip': '1',
                        title: text
                    }).tooltip({
                        container: 'body',
                        placement: 'top',
                        trigger: 'hover',
                        delay: { show: 0, hide: 0 },
                        animation: false,
                        customClass: 'cp-border-tooltip'
                    });
                    bindCpTooltipHideOnLeave(el);
                } else {
                    el.setAttribute('title', text);
                    el.setAttribute('data-cp-tip', '1');
                }
            } catch (e) {
                el.setAttribute('title', text);
                el.setAttribute('data-cp-tip', '1');
            }
        }

        function isCpTextOverflowing(el) {
            if (!el) return false;
            if ((el.scrollWidth - el.clientWidth) > 1 || (el.scrollHeight - el.clientHeight) > 1) {
                return true;
            }
            // -webkit-line-clamp / multi-line ellipsis can report equal scroll/client heights
            try {
                var styles = window.getComputedStyle(el);
                var lineClamp = styles.webkitLineClamp || styles.getPropertyValue('-webkit-line-clamp');
                if (lineClamp && lineClamp !== 'none') {
                    var range = document.createRange();
                    range.selectNodeContents(el);
                    var rects = range.getClientRects();
                    var clampLines = parseInt(lineClamp, 10);
                    if (!isNaN(clampLines) && rects.length > clampLines) return true;
                    // Fallback: compare full text height via temp clone
                    var clone = el.cloneNode(true);
                    clone.style.cssText = 'position:absolute;visibility:hidden;display:block;height:auto;max-height:none;' +
                        '-webkit-line-clamp:unset;line-clamp:unset;overflow:visible;white-space:normal;' +
                        'width:' + el.clientWidth + 'px;';
                    document.body.appendChild(clone);
                    var overflowing = clone.scrollHeight > el.clientHeight + 1;
                    document.body.removeChild(clone);
                    return overflowing;
                }
            } catch (e) { /* ignore */ }
            return false;
        }

        function refreshCpBootstrapTooltips(root) {
            var $scope = $(root || 'body#CapacityPlanning, #cpDrawerOverlay');
            if (!$scope.length) $scope = $(document);

            hideAllCpBootstrapTooltips();

            // Keep explicitly marked truncated role names / cells; re-init others by overflow.
            $scope.find('[data-cp-tip="1"]').each(function () {
                try {
                    if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                        var inst = bootstrap.Tooltip.getInstance(this);
                        if (inst) {
                            inst.hide();
                            inst.dispose();
                        }
                    } else if (typeof $(this).tooltip === 'function') {
                        $(this).tooltip('hide');
                        $(this).tooltip('dispose');
                    }
                } catch (e) { /* ignore */ }
            });

            // KPI numbers must never show tooltips (title/value tips only on truncated labels).
            $scope.find('.kpi-value span, .kpi-value small').each(function () {
                try {
                    if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                        var kpiTip = bootstrap.Tooltip.getInstance(this);
                        if (kpiTip) kpiTip.dispose();
                    }
                } catch (eKpi) { /* ignore */ }
                $(this).removeAttr('data-cp-tip data-bs-toggle data-bs-placement data-bs-container data-bs-original-title title');
            });

            var selectors = [
                '.cp-role-name[data-cp-full]',
                '.cp-cell-ellipsis[data-cp-full]',
                '.cp-filter-chip-text',
                '.kpi-title',
                '#tblCapacity thead th',
                '.cp-week-header-label',
                '.cp-detail-list-table th',
                '.cp-detail-list-table td',
                '.cp-drawer-table th',
                '.cp-drawer-table td',
                '.cp-drawer-title',
                '.cp-drawer-subtitle',
                '.cp-detail-content-title',
                '.cp-detail-nav-item'
            ].join(',');

            $scope.find(selectors).each(function () {
                var el = this;
                var $el = $(el);
                var full = ($el.attr('data-cp-full') || '').trim();
                if (!full) full = (el.textContent || '').replace(/\s+/g, ' ').trim();
                if (!full) return;

                var hasExplicitFull = !!$el.attr('data-cp-full');
                var displayText = (el.textContent || '').replace(/\s+/g, ' ').trim();
                var overflowing = false;
                if (hasExplicitFull) {
                    overflowing = (full !== displayText) || displayText.indexOf('...') > -1 || isCpTextOverflowing(el);
                } else {
                    overflowing = isCpTextOverflowing(el);
                }
                if (!overflowing) {
                    // Clear stale tip attrs if no longer truncated (keep data-cp-full)
                    if ($el.attr('data-cp-tip') === '1') {
                        try {
                            if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                                var old = bootstrap.Tooltip.getInstance(el);
                                if (old) old.dispose();
                            }
                        } catch (e2) { /* ignore */ }
                        $el.removeAttr('data-cp-tip data-bs-toggle data-bs-placement data-bs-container data-bs-original-title title');
                    }
                    return;
                }
                initCpBootstrapTooltipEl(el, full);
            });

            // Permanent Previous / Next Bootstrap tooltips (not overflow-based)
            $scope.find('.cp-month-nav-wrap').each(function () {
                var el = this;
                var title = (el.getAttribute('title') || el.getAttribute('data-bs-original-title') || '').trim();
                if (!title) {
                    if ($(el).find('.cp-outer-month-prev, .cp-month-nav-prev, #btnPrev, #btnDrawerPrev, #btnTabPrev').length) {
                        title = 'Previous';
                    } else if ($(el).find('.cp-outer-month-next, .cp-month-nav-next, #btnNext, #btnDrawerNext, #btnTabNext').length) {
                        title = 'Next';
                    }
                }
                if (title) initCpNavTooltipEl(el, title);
            });
        }

        function scheduleCpBootstrapTooltips(root) {
            setTimeout(function () { refreshCpBootstrapTooltips(root); }, 0);
        }

        function getDetailNavItems() {
            return [
                { key: 'overview', label: cpResources.overview, icon: 'fa-th-large' },
                { key: 'allocated', label: cpResources.allocatedToProject, icon: 'fa-clipboard-list' },
                { key: 'project', label: cpResources.projectRequest, icon: 'fa-file-alt' },
                { key: 'opportunity', label: cpResources.opportunityRequests, icon: 'fa-bullseye' },
                { key: 'bench', label: cpResources.benchDetails, icon: 'fa-users' },
                { key: 'exits', label: cpResources.anticipatedExitsDetails, icon: 'fa-user-clock' },
                { key: 'joining', label: cpResources.joiningPoolDetails, icon: 'fa-user-plus' }
            ];
        }

        var currentView = "Month";
        var currentType = "Role";
        var currentPage = 1;
        var totalPages = 1;
        var pageSize = 5;
        var drawerCurrentPage = 1;
        var drawerTotalPages = 1;
        var drawerPageSize = 10;
        var detailListContext = null;
        var expandedRowKey = null;
        var expandedRowContext = null;
        var lastDetailContext = null;
        var cpWeekHeaderList = [];
        var activeDetailTab = 'overview';
        var roleTrendChartInst = null;
        var skillTrendChartInst = null;
        var roleTrendSeries = [];
        var skillTrendSeries = [];
        var currentRoleTrendView = cpResources.utilizationPercent;
        var currentSkillTrendView = cpResources.utilizationPercent;
        var lastQuarterGridContext = null;
        var lastQuarterHeaderResponse = null;
        var cpMonthHeaderList = [];
        var detailExpandedQuarters = { Q1: false, Q2: false, Q3: false, Q4: false };
        var expandedQuarters = { Q1: false, Q2: false, Q3: false, Q4: false };
        var CP_CHART_COLORS = ['hsl(217 91% 60%)', 'hsl(142 71% 45%)', 'hsl(38 92% 50%)', 'hsl(280 75% 60%)', 'hsl(199 89% 55%)', 'hsl(28 95% 55%)', 'hsl(48 92% 50%)', 'hsl(0 72% 51%)'];
        var CP_MONTH_LABELS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        var CP_FULL_MONTH_NAMES = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        var QUARTER_DEFS = [
            { key: 'Q1', label: 'Q1 2026', months: ['Jan', 'Feb', 'Mar'], fullMonths: ['January', 'February', 'March'] },
            { key: 'Q2', label: 'Q2 2026', months: ['Apr', 'May', 'Jun'], fullMonths: ['April', 'May', 'June'] },
            { key: 'Q3', label: 'Q3 2026', months: ['Jul', 'Aug', 'Sep'], fullMonths: ['July', 'August', 'September'] },
            { key: 'Q4', label: 'Q4 2026', months: ['Oct', 'Nov', 'Dec'], fullMonths: ['October', 'November', 'December'] }
        ];

        $(document).ready(function () {
            $("#CapacityPreloader").hide();
            if (typeof alertify !== "undefined") {
                alertify.set('notifier', 'position', 'top-right');
            }
            if ($("#CapacityWrapper").length) {
                $("#CapacityWrapper").show();
            }
            GetCapacityPlanHeaderCounts();
            updateRoleSkillSearchPlaceholder();
            GetCapacityPlanBGFilterList();
            GetOriginationUnitFilterList();
            GetCapacityPlanRoleFilterList();
            LoadCapacityGrid();
            loadRoleTrendAnalysis();
            loadSkillTrendAnalysis();
            scheduleCpBootstrapTooltips('body#CapacityPlanning');
            setTimeout(function () {
                scheduleCpBootstrapTooltips('.cp-charts-grid');
            }, 150);

            // Hide all tooltips immediately on scroll / click
            $(document)
                .off('click.cpTipGlobalHide')
                .on('click.cpTipGlobalHide', function () {
                    hideAllCpBootstrapTooltips();
                });
            $(window).off('scroll.cpTipGlobalHide').on('scroll.cpTipGlobalHide', function () {
                hideAllCpBootstrapTooltips();
            });
            // scroll does not bubble — capture so drawer/grid scroll also clears tips
            if (!window._cpTipScrollCaptureBound) {
                window._cpTipScrollCaptureBound = true;
                document.addEventListener('scroll', function () {
                    hideAllCpBootstrapTooltips();
                }, true);
            }
            // Chart tooltips: clear as soon as cursor leaves chart area
            $(document)
                .off('mouseleave.cpTrendTip', '.cp-chart-card, .cp-charts-grid canvas')
                .on('mouseleave.cpTrendTip', '.cp-chart-card, .cp-charts-grid canvas', function () {
                    hideCpTrendTooltip();
                });

            $('#btnMonthView').addClass('active');
            $('#btnQuarterView').removeClass('active');

            $('#cpDrawerClose').on('click', function (e) {
                e.preventDefault();
                hideAllCpBootstrapTooltips();
                closeDetailDrawer();
            });

            $('#btnDrawerPrev').on('click', function (e) {
                e.preventDefault();
                if (detailListContext && detailListContext.target === 'drawer' && drawerCurrentPage > 1) {
                    drawerCurrentPage--;
                    loadDrawerData();
                }
            });

            $('#btnDrawerNext').on('click', function (e) {
                e.preventDefault();
                if (detailListContext && detailListContext.target === 'drawer' && drawerCurrentPage < drawerTotalPages) {
                    drawerCurrentPage++;
                    loadDrawerData();
                }
            });

            $(document).on('click', '#btnTabPrev', function (e) {
                e.preventDefault();
                if (detailListContext && detailListContext.target === 'tab' && drawerCurrentPage > 1) {
                    drawerCurrentPage--;
                    renderDetailTabListContent();
                }
            });

            $(document).on('click', '#btnTabNext', function (e) {
                e.preventDefault();
                if (detailListContext && detailListContext.target === 'tab' && drawerCurrentPage < drawerTotalPages) {
                    drawerCurrentPage++;
                    renderDetailTabListContent();
                }
            });

            $('#cpDrawerOverlay').on('click', function (e) {
                if (e.target === this || $(e.target).is('#cpDrawerOverlay')) {
                    e.preventDefault();
                    e.stopPropagation();
                    closeDetailDrawer();
                }
            });

            $(window).on('resize', function () {
                syncDetailRowWidth();
            });

            $('#cpDownloadToggle').on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('#cpDownloadMenu').toggleClass('open');
            });

            $(document).on('click', '.cp-download-dropdown li, .cp-download-dropdown a, .cp-download-dropdown img', function (e) {
                e.preventDefault();
                e.stopPropagation();
                var $target = $(e.target).closest('[data-format]');
                var format = ($target.attr('data-format') || '').toUpperCase();
                $('#cpDownloadMenu').removeClass('open');
                downloadCpReport(format);
            });

            $(document).on('click', '#cpDownloadExcelBtn', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('#cpDownloadMenu').removeClass('open');
                downloadCpReport('EXCEL');
            });

            $(document).on('click', '#cpDownloadPdfBtn', function (e) {
                e.preventDefault();
                e.stopPropagation();
                $('#cpDownloadMenu').removeClass('open');
                downloadCpReport('PDF');
            });

            $(document).on('click', function (e) {
                if ($(e.target).closest('#cpDownloadMenu').length === 0) {
                    $('#cpDownloadMenu').removeClass('open');
                }
            });
        });

        function getResponseData(response) {
            if (!response) return null;
            if (response.data !== undefined) return response.data;
            if (response.Data !== undefined) return response.Data;
            return response;
        }

        function getResponseList(response) {
            if (Array.isArray(response)) return response;
            if (response && Array.isArray(response.data)) return response.data;
            if (response && Array.isArray(response.Data)) return response.Data;
            if (response && Array.isArray(response.Table)) return response.Table;
            if (response && Array.isArray(response.table)) return response.table;
            var data = getResponseData(response);
            if (Array.isArray(data)) return data;
            if (data && Array.isArray(data.data)) return data.data;
            if (data && Array.isArray(data.Data)) return data.Data;
            if (data && Array.isArray(data.Table)) return data.Table;
            if (data && Array.isArray(data.table)) return data.table;
            if (data && Array.isArray(data.items)) return data.items;
            if (data && Array.isArray(data.Items)) return data.Items;
            return [];
        }

        function getFilterUserParam() {
            var id = parseInt(SessionEmployeeId, 10) || 0;
            return JSON.stringify({ userID: id, UserID: id });
        }

        function getHeaderPeriodType() {
            return (currentView === 'Quarter') ? 'QUARTER' : 'MONTH';
        }

        function getCapacityPlanHeaderParam() {
            var id = parseInt(SessionEmployeeId, 10) || 0;
            var periodType = getHeaderPeriodType();
            return JSON.stringify({
                userID: id,
                UserID: id,
                periodType: periodType,
                PeriodType: periodType
            });
        }

        function getRowRoleId(row) {
            if (!row) return 0;
            return row.RoleID || row.roleID || row.RoleId || row.roleId || 0;
        }

        function getRowSkillId(row) {
            if (!row) return 0;
            return row.ToolID || row.toolID || row.ToolId || row.toolId || row.SkillID || row.skillID || 0;
        }

        function getRowCellValue(row, col) {
            if (!row || col === undefined || col === null) return null;
            if (row[col] !== undefined && row[col] !== null) return row[col];
            var lowerCol = String(col).toLowerCase();
            var keys = Object.keys(row);
            for (var i = 0; i < keys.length; i++) {
                if (keys[i].toLowerCase() === lowerCol) return row[keys[i]];
            }
            return null;
        }

        function getPaginationEntitiesFromResponse(response) {
            if (!response) return [];
            var entities = response.paginationEntities || response.PaginationEntities || [];
            if (!entities.length) {
                var data = getResponseData(response);
                if (data) {
                    entities = data.paginationEntities || data.PaginationEntities || [];
                }
            }
            if (!entities.length) {
                var tableSources = [
                    response.Table1, response.table1,
                    response.Table2, response.table2,
                    response.Table3, response.table3
                ];
                var dataObj = getResponseData(response);
                if (dataObj) {
                    tableSources.push(
                        dataObj.Table1, dataObj.table1,
                        dataObj.Table2, dataObj.table2,
                        dataObj.Table3, dataObj.table3
                    );
                }
                tableSources.forEach(function (table) {
                    if (table && table.length) {
                        entities = entities.concat(table);
                    }
                });
            }
            return entities;
        }

        function isQuarterMonthHeaderEntity(entity) {
            if (!entity) return false;
            if (entity.WkStartDate !== undefined || entity.wkStartDate !== undefined) return false;
            if (entity.MonthDate !== undefined || entity.monthDate !== undefined) return true;
            var name = entity.Name || entity.name;
            return !!(name && (entity.Month !== undefined || entity.month !== undefined ||
                entity.Quarter !== undefined || entity.quarter !== undefined));
        }

        function storeCpMonthHeaders(response) {
            var headers = getPaginationEntitiesFromResponse(response).filter(isQuarterMonthHeaderEntity);
            if (!headers.length && lastQuarterHeaderResponse) {
                headers = getPaginationEntitiesFromResponse(lastQuarterHeaderResponse).filter(isQuarterMonthHeaderEntity);
            }
            if (!headers.length) return;

            // SP Month is fiscal sequence (Apr…Mar → 1..12) so sort order = Q2,Q3,Q4,Q1.
            headers.sort(function (a, b) {
                return (a.Month || a.month || 0) - (b.Month || b.month || 0);
            });
            cpMonthHeaderList = headers;

            // Bind each UI quarter slot to SP months (e.g. first slot → Apr,May,Jun under Q2 2026).
            QUARTER_DEFS.forEach(function (q, qi) {
                var slice = headers.slice(qi * 3, qi * 3 + 3);
                if (!slice.length) return;

                var first = slice[0];
                q.label = (first.Quarter || first.quarter || q.key) + ' ' + (first.Year || first.year || '');

                var months = [];
                var fullMonths = [];
                slice.forEach(function (hdr) {
                    var full = hdr.Name || hdr.name || '';
                    var d = parseCpLocalDate(getCpMonthDateValue(hdr));
                    var mi = d ? d.getMonth() : -1;
                    if (mi < 0 && full) {
                        var fl = String(full).toLowerCase();
                        mi = CP_FULL_MONTH_NAMES.findIndex(function (n) {
                            return n.toLowerCase() === fl || n.toLowerCase().indexOf(fl) === 0;
                        });
                    }
                    if (mi < 0) mi = 0;
                    if (!full) full = CP_FULL_MONTH_NAMES[mi];
                    fullMonths.push(full);
                    months.push(CP_MONTH_LABELS[mi] || String(full).substring(0, 3));
                });
                q.months = months;
                q.fullMonths = fullMonths;
            });
        }

        function ensureCpMonthHeaders() {
            if (cpMonthHeaderList && cpMonthHeaderList.length > 0) return;
            if (lastQuarterHeaderResponse) {
                storeCpMonthHeaders(lastQuarterHeaderResponse);
            }
        }

        function getCpMonthDateValue(header) {
            if (!header) return '';
            return header.MonthDate || header.monthDate || '';
        }

        function getQuarterMonthDatesByIndex(monthIndex) {
            ensureCpMonthHeaders();
            var year = new Date().getFullYear();
            var monthIdx = monthIndex;

            if (cpMonthHeaderList && cpMonthHeaderList.length) {
                var header = cpMonthHeaderList[monthIndex] || null;

                if (!header) {
                    for (var hi = 0; hi < cpMonthHeaderList.length; hi++) {
                        var hMonth = cpMonthHeaderList[hi].Month || cpMonthHeaderList[hi].month;
                        if (hMonth === monthIndex + 1) {
                            header = cpMonthHeaderList[hi];
                            break;
                        }
                    }
                }

                if (header) {
                    year = parseInt(header.Year || header.year, 10) || year;
                    var monthDate = getCpMonthDateValue(header);
                    if (monthDate) {
                        var parsed = new Date(monthDate);
                        if (!isNaN(parsed.getTime())) {
                            monthIdx = parsed.getMonth();
                            year = parsed.getFullYear();
                        }
                    }
                    return getMonthStartEndFromIndex(monthIdx, year);
                }
            }

            return getMonthStartEndFromIndex(monthIndex, year);
        }

        function getQuarterDatesByQuarterIndex(quarterIdx) {
            ensureCpMonthHeaders();
            var qi = parseInt(quarterIdx, 10);
            if (isNaN(qi) || qi < 0) qi = 0;
            var monthStartIdx = qi * 3;
            var monthEndIdx = monthStartIdx + 2;

            // Use same month-header resolution as month-cell click (fiscal Apr…Mar indices → real calendar months).
            var startRange = getQuarterMonthDatesByIndex(monthStartIdx);
            var endRange = getQuarterMonthDatesByIndex(monthEndIdx);
            if (startRange && endRange && startRange.start && endRange.end) {
                return { start: startRange.start, end: endRange.end };
            }

            var year = new Date().getFullYear();
            startRange = getMonthStartEndFromIndex(monthStartIdx % 12, year);
            endRange = getMonthStartEndFromIndex(monthEndIdx % 12, year);
            return { start: startRange.start, end: endRange.end };
        }

        function getDefaultCpQuarterRange() {
            ensureCpMonthHeaders();
            if (cpMonthHeaderList && cpMonthHeaderList.length > 0) {
                var firstHeader = cpMonthHeaderList[0];
                var lastHeader = cpMonthHeaderList[cpMonthHeaderList.length - 1];
                var firstYear = parseInt(firstHeader.Year || firstHeader.year, 10) || new Date().getFullYear();
                var lastYear = parseInt(lastHeader.Year || lastHeader.year, 10) || firstYear;
                var firstMonthIdx = 0;
                var lastMonthIdx = cpMonthHeaderList.length - 1;
                var firstDate = getCpMonthDateValue(firstHeader);
                var lastDate = getCpMonthDateValue(lastHeader);
                if (firstDate) {
                    var parsedFirst = new Date(firstDate);
                    if (!isNaN(parsedFirst.getTime())) {
                        firstMonthIdx = parsedFirst.getMonth();
                        firstYear = parsedFirst.getFullYear();
                    }
                }
                if (lastDate) {
                    var parsedLast = new Date(lastDate);
                    if (!isNaN(parsedLast.getTime())) {
                        lastMonthIdx = parsedLast.getMonth();
                        lastYear = parsedLast.getFullYear();
                    }
                }
                var startRange = getMonthStartEndFromIndex(firstMonthIdx, firstYear);
                var endRange = getMonthStartEndFromIndex(lastMonthIdx, lastYear);
                return { start: startRange.start, end: endRange.end };
            }
            var now = new Date();
            return {
                start: toCpApiDate(new Date(now.getFullYear(), 0, 1)),
                end: toCpApiDate(new Date(now.getFullYear(), 11, 31))
            };
        }

        function getQuarterGroupLabel(quarterIdx) {
            if (cpMonthHeaderList && cpMonthHeaderList[quarterIdx * 3]) {
                var h = cpMonthHeaderList[quarterIdx * 3];
                return (h.Quarter || h.quarter || ('Q' + (quarterIdx + 1))) + ' ' + (h.Year || h.year || '');
            }
            return QUARTER_DEFS[quarterIdx] ? QUARTER_DEFS[quarterIdx].label : ('Q' + (quarterIdx + 1));
        }

        function getQuarterMonthLabel(monthIndex) {
            if (cpMonthHeaderList && cpMonthHeaderList[monthIndex]) {
                var name = cpMonthHeaderList[monthIndex].Name || cpMonthHeaderList[monthIndex].name;
                if (name) return name.length > 3 ? name.substring(0, 3) : name;
            }
            return CP_MONTH_LABELS[monthIndex] || ('M' + (monthIndex + 1));
        }

        function getQuarterDetailMonthKey(row, monthIndex) {
            var fullName = CP_FULL_MONTH_NAMES[monthIndex];
            if (cpMonthHeaderList && cpMonthHeaderList[monthIndex]) {
                fullName = cpMonthHeaderList[monthIndex].Name || cpMonthHeaderList[monthIndex].name || fullName;
            }
            if (row && getRowCellValue(row, fullName) !== null && getRowCellValue(row, fullName) !== undefined) {
                return fullName;
            }
            var numericKey = 'Month_' + (monthIndex + 1);
            if (row && getRowCellValue(row, numericKey) !== null && getRowCellValue(row, numericKey) !== undefined) {
                return numericKey;
            }
            return fullName;
        }

        function getQuarterDetailMonthValue(row, monthIndex) {
            var key = getQuarterDetailMonthKey(row, monthIndex);
            var value = getRowCellValue(row, key);
            if (value === null || value === undefined || value === '') return 0;
            return value;
        }

        function getQuarterDetailQuarterValue(row, quarterIdx, metricName) {
            // Quarter aggregation rules (same as month-wise unique/peak logic):
            // - Total Strength / Allocated / Bench / Anticipated / Joining -> MAX(months)
            // - Project / Opportunity Requests -> SUM(months)
            // - Utilization % -> SP value (Allocated_MAX / Strength_MAX * 100)
            var name = String(metricName || '');
            var maxMetric = /total strength|allocated|current bench|anticipated|joining/i.test(name);
            var sumMetric = /project request|opportunity request/i.test(name);

            if (isUtilizationMetric(metricName)) {
                // Calendar Q from fiscal slot label (Q1 2027 → SP Q1 = Jan–Mar)
                var qNumUtil = getCpCalendarQuarterNumber(quarterIdx);
                var utilKeys = [
                    'Q' + qNumUtil + 'Utilization', 'q' + qNumUtil + 'Utilization',
                    'Q' + qNumUtil, 'q' + qNumUtil,
                    'Quarter' + qNumUtil, 'quarter' + qNumUtil
                ];
                var ui;
                for (ui = 0; ui < utilKeys.length; ui++) {
                    var uv = getRowCellValue(row, utilKeys[ui]);
                    if (uv !== null && uv !== undefined && uv !== '') return uv;
                }
                return 0;
            }

            var monthStart = quarterIdx * 3;
            var monthEnd = monthStart + 2;
            var sum = 0;
            var maxVal = 0;
            var hasValue = false;
            var mi;
            for (mi = monthStart; mi <= monthEnd; mi++) {
                var mv = parseFloat(String(getQuarterDetailMonthValue(row, mi)).replace(/[%,\s]/g, ''));
                if (!isNaN(mv)) {
                    sum += mv;
                    if (mv > maxVal) maxVal = mv;
                    hasValue = true;
                }
            }

            if (maxMetric) {
                return hasValue ? maxVal : 0;
            }

            // Prefer SP calendar quarter (Q1=Jan–Mar …) from fiscal slot label — NOT UI slot index+1.
            // Slot order is Q2→Q3→Q4→Q1; quarterIdx+1 wrongly maps Q4 UI → SP Q3 (Aug → Q4 bug).
            var qNum = getCpCalendarQuarterNumber(quarterIdx);
            var directKeys = ['Q' + qNum, 'q' + qNum, 'Quarter' + qNum, 'quarter' + qNum];
            var i;
            for (i = 0; i < directKeys.length; i++) {
                var v = getRowCellValue(row, directKeys[i]);
                if (v !== null && v !== undefined && v !== '') return v;
            }
            if (!hasValue) return 0;
            return sum;
        }

        

        function isCpWeekHeaderRow(row) {
            if (!row) return false;
            return row.WkStartDate !== undefined || row.wkStartDate !== undefined ||
                row.WkEndDate !== undefined || row.wkEndDate !== undefined ||
                row.WkRowNo !== undefined || row.wkRowNo !== undefined ||
                row.WkNo !== undefined || row.wkNo !== undefined ||
                row.WkMonthName !== undefined || row.wkMonthName !== undefined;
        }

        function getCpWeekHeaderList(response) {
            if (!response) return [];

            function pickWeekRows(list) {
                if (!list || !list.length) return [];
                return list.filter(isCpWeekHeaderRow);
            }

            var sources = [
                response.weekHeaders,
                response.WeekHeaders,
                response.CpWeeksListHeader,
                response.cpWeeksListHeader,
                response.WeekHeaderList,
                response.weekHeaderList,
                response.paginationEntities,
                response.PaginationEntities
            ];
            var data = getResponseData(response);
            if (data) {
                sources.push(
                    data.weekHeaders, data.WeekHeaders,
                    data.CpWeeksListHeader, data.cpWeeksListHeader,
                    data.WeekHeaderList, data.weekHeaderList,
                    data.paginationEntities, data.PaginationEntities
                );
            }

            for (var i = 0; i < sources.length; i++) {
                var weeks = pickWeekRows(sources[i]);
                if (weeks.length) return weeks;
            }

            var pages = getPaginationEntitiesFromResponse(response);
            weeks = pickWeekRows(pages);
            return weeks.length ? weeks : [];
        }

        function isCpPaginationEntity(entity) {
            if (!entity) return false;
            if (isCpWeekHeaderRow(entity)) return false;
            if (isQuarterMonthHeaderEntity(entity)) return false;

            return entity.currentPage !== undefined || entity.CurrentPage !== undefined ||
                entity.totalPages !== undefined || entity.TotalPages !== undefined ||
                entity.pageSize !== undefined || entity.PageSize !== undefined ||
                entity.totalRecords !== undefined || entity.TotalRecords !== undefined ||
                entity.totalCount !== undefined || entity.TotalCount !== undefined;
        }

        function getTotalRecordsFromRows(rows) {
            if (!rows || !rows.length) return 0;
            var first = rows[0];
            var total = first.TotalRecords || first.totalRecords || first.TotalCount || first.totalCount || 0;
            total = parseInt(total, 10);
            return isNaN(total) ? 0 : total;
        }

        function getPaginationInfo(response) {
            if (!response) return null;

            var rootCandidates = [response, getResponseData(response)];
            for (var r = 0; r < rootCandidates.length; r++) {
                var root = rootCandidates[r];
                if (!root) continue;
                if (isCpPaginationEntity(root)) {
                    return root;
                }
            }

            var pages = getPaginationEntitiesFromResponse(response);
            if (!pages || !pages.length) return null;

            for (var i = pages.length - 1; i >= 0; i--) {
                if (isCpPaginationEntity(pages[i])) {
                    return pages[i];
                }
            }
            return null;
        }

        function findWeekHeaderForColumn(weekCol, monthName) {
            if (!cpWeekHeaderList.length || !weekCol) return null;

            var key = buildWeekColumnKey(weekCol, monthName);
            var match = String(key).match(/([A-Za-z]+)\s+Week\s+(\d+)/i);
            var weekNum = match ? parseInt(match[2], 10) : getWeekNumberFromColumn(weekCol);
            if (!weekNum) return null;

            // Same order as Inner/Outer SP SelectWeekColumns: ORDER BY WkNo / WkStartDate.
            // "August Week 1" = 1st week in that month query list (may start in prior month).
            var sorted = cpWeekHeaderList.slice().sort(function (a, b) {
                var aNo = parseInt(a.WkNo || a.wkNo, 10) || 0;
                var bNo = parseInt(b.WkNo || b.wkNo, 10) || 0;
                if (aNo !== bNo) return aNo - bNo;
                var aStart = parseCpLocalDate(a.WkStartDate || a.wkStartDate);
                var bStart = parseCpLocalDate(b.WkStartDate || b.wkStartDate);
                return (aStart && bStart) ? (aStart - bStart) : 0;
            });

            if (weekNum > 0 && weekNum <= sorted.length) {
                return sorted[weekNum - 1];
            }

            // Fallback: match WkOfMonth within same month name when available
            var monthToken = match ? match[1] : (monthName || '');
            if (monthToken) {
                for (var i = 0; i < sorted.length; i++) {
                    var h = sorted[i];
                    var hMonth = h.WkMonthName || h.wkMonthName || '';
                    var ofMonth = parseInt(h.WkOfMonth || h.wkOfMonth, 10);
                    if (monthsMatch(hMonth, monthToken) && ofMonth === weekNum) return h;
                }
            }
            return null;
        }

        function parseCpLocalDate(dateVal) {
            if (!dateVal) return null;
            if (dateVal instanceof Date && !isNaN(dateVal.getTime())) {
                return new Date(dateVal.getFullYear(), dateVal.getMonth(), dateVal.getDate());
            }
            var s = String(dateVal);
            var m = s.match(/^(\d{4})-(\d{2})-(\d{2})/);
            if (m) {
                return new Date(parseInt(m[1], 10), parseInt(m[2], 10) - 1, parseInt(m[3], 10));
            }
            var parsed = new Date(s);
            if (isNaN(parsed.getTime())) return null;
            return new Date(parsed.getFullYear(), parsed.getMonth(), parsed.getDate());
        }

        function getWeekNumberFromColumn(weekCol) {
            var match = String(weekCol || '').match(/Week\s*(\d+)/i);
            var n = match ? parseInt(match[1], 10) : parseInt(weekCol, 10);
            return n > 0 ? n : 1;
        }

        function buildWeekColumnKey(weekCol, monthName) {
            var col = String(weekCol || '').trim();
            if (/^[A-Za-z]+\s+Week\s*\d+/i.test(col)) return col;
            var weekPart = col.match(/Week\s*\d+/i);
            if (monthName && weekPart) return String(monthName).trim() + ' ' + weekPart[0];
            if (monthName && /^\d+$/.test(col)) return String(monthName).trim() + ' Week ' + col;
            return col;
        }

        // Clip SP Sun–Sat week into the selected calendar month.
        // Aug 2026 example:
        //   W1 SP=26 Jul–01 Aug → 01 Aug–01 Aug
        //   W2 SP=02 Aug–08 Aug → 02 Aug–08 Aug
        //   W6 SP=30 Aug–05 Sep → 30 Aug–31 Aug
        function clipWeekRangeToMonth(range, monthName) {
            if (!range || !range.start || !range.end) return range;
            var monthIndex = parseMonthNameToIndex(monthName);
            if (monthIndex < 0) return range;
            var year = getYearForVisibleMonth(monthName) || getCpAllowedYear();
            var monthStart = new Date(year, monthIndex, 1);
            var monthEnd = new Date(year, monthIndex + 1, 0);
            var start = parseCpLocalDate(range.start);
            var end = parseCpLocalDate(range.end);
            if (!start || !end) return range;
            if (start < monthStart) start = new Date(monthStart);
            if (end > monthEnd) end = new Date(monthEnd);
            if (start > end) return null;
            return { start: toCpApiDate(start), end: toCpApiDate(end) };
        }

        // Build month-clipped Sun–Sat weeks when SP headers are unavailable.
        function getSundayToSaturdayWeeksForMonth(monthName) {
            var monthIndex = parseMonthNameToIndex(monthName);
            if (monthIndex < 0) return [];
            var year = getYearForVisibleMonth(monthName) || getCpAllowedYear();
            var monthStart = new Date(year, monthIndex, 1);
            var monthEnd = new Date(year, monthIndex + 1, 0);
            var cursor = new Date(monthStart);
            cursor.setDate(cursor.getDate() - cursor.getDay()); // Sunday on/before 1st

            var weeks = [];
            while (cursor <= monthEnd) {
                var sunday = new Date(cursor);
                var saturday = new Date(cursor);
                saturday.setDate(saturday.getDate() + 6);
                if (saturday >= monthStart && sunday <= monthEnd) {
                    var start = sunday < monthStart ? new Date(monthStart) : sunday;
                    var end = saturday > monthEnd ? new Date(monthEnd) : saturday;
                    weeks.push({
                        start: toCpApiDate(start),
                        end: toCpApiDate(end)
                    });
                }
                cursor.setDate(cursor.getDate() + 7);
            }
            return weeks;
        }

        // SP week headers first, then always clip to selected month.
        function getWeekDatesFromHeaders(weekCol, monthName) {
            var name = monthName || '';
            if (!name) {
                var m = String(weekCol || '').match(/([A-Za-z]+)\s+Week/i);
                name = m ? m[1] : '';
            }

            var weekNum = getWeekNumberFromColumn(weekCol);
            var header = findWeekHeaderForColumn(weekCol, name);
            if (header) {
                var ws = parseCpLocalDate(header.WkStartDate || header.wkStartDate);
                var we = parseCpLocalDate(header.WkEndDate || header.wkEndDate);
                if (ws && !we) {
                    we = new Date(ws.getFullYear(), ws.getMonth(), ws.getDate() + 6);
                }
                if (ws && we) {
                    return clipWeekRangeToMonth(
                        { start: toCpApiDate(ws), end: toCpApiDate(we) },
                        name
                    );
                }
            }

            var weeks = getSundayToSaturdayWeeksForMonth(name);
            if (!weeks.length) return null;
            if (weekNum > weeks.length) weekNum = weeks.length;
            return weeks[weekNum - 1] || null;
        }

        function resolveWeekClickDateRange(weekCol, monthName, startDate, endDate) {
            var range = getWeekDatesFromHeaders(weekCol, monthName);
            if (range && range.start && range.end) return range;
            if (startDate && endDate) {
                return clipWeekRangeToMonth({ start: startDate, end: endDate }, monthName)
                    || { start: startDate, end: endDate };
            }
            return null;
        }

        function parseMonthNameToIndex(monthName) {
            return ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec']
                .indexOf((monthName || '').toLowerCase().substring(0, 3));
        }

        function monthsMatch(headerMonth, visibleMonth) {
            var h = String(headerMonth || '').toLowerCase().substring(0, 3);
            var v = String(visibleMonth || '').toLowerCase().substring(0, 3);
            return h === v;
        }

        function toCpApiDate(dateVal) {
            if (!dateVal) return dateVal;
            if (typeof dateVal === 'string') {
                var match = dateVal.match(/^(\d{4})-(\d{2})-(\d{2})/);
                if (match) {
                    return match[1] + '-' + match[2] + '-' + match[3] + 'T00:00:00';
                }
                var parsed = new Date(dateVal);
                if (!isNaN(parsed.getTime())) {
                    dateVal = parsed;
                } else {
                    return dateVal;
                }
            }
            if (!(dateVal instanceof Date) || isNaN(dateVal.getTime())) return dateVal;

            var pad = function (n) {
                return n < 10 ? '0' + n : '' + n;
            };

            return dateVal.getFullYear() + '-' +
                pad(dateVal.getMonth() + 1) + '-' +
                pad(dateVal.getDate()) +
                'T00:00:00';
        }

        function getYearForVisibleMonth(monthName) {
            if (currentView === 'Month') {
                return getCpMonthViewDate().getFullYear();
            }
            if (cpWeekHeaderList && cpWeekHeaderList.length) {
                var i;
                for (i = 0; i < cpWeekHeaderList.length; i++) {
                    var h = cpWeekHeaderList[i];
                    if (monthsMatch(h.WkMonthName || h.wkMonthName, monthName)) {
                        var ws = h.WkStartDate || h.wkStartDate;
                        if (ws) return new Date(ws).getFullYear();
                    }
                }
            }
            return getCpAllowedYear();
        }

        function getMonthStartEndFromIndex(monthIndex, year) {
            var start = new Date(year, monthIndex, 1);
            var end = new Date(year, monthIndex + 1, 0);
            return { start: toCpApiDate(start), end: toCpApiDate(end) };
        }

        function getVisibleDetailMonths() {
            if (!lastDetailContext || lastDetailContext.viewMode !== 'month') return [];
            var $content = $('.detail-row .cp-detail-content').first();
            var startIdx = parseInt($content.attr('data-month-start'), 10) || 0;
            var monthsPerPage = lastDetailContext.monthsPerPage || outerMonthsPerPage || 1;
            if (!lastDetailContext.monthOrder || !lastDetailContext.monthOrder.length) return [];
            return lastDetailContext.monthOrder.slice(startIdx, startIdx + monthsPerPage);
        }

        function getVisibleQuarterDetailRange() {
            if (!lastDetailContext || lastDetailContext.viewMode !== 'quarter') return null;
            ensureCpMonthHeaders();
            var anyExpanded = QUARTER_DEFS.some(function (q) { return detailExpandedQuarters[q.key]; });
            if (!anyExpanded || !cpMonthHeaderList || !cpMonthHeaderList.length) {
                return getDefaultCpQuarterRange();
            }
            var firstIdx = null;
            var lastIdx = null;
            QUARTER_DEFS.forEach(function (q, qi) {
                if (detailExpandedQuarters[q.key]) {
                    var start = qi * 3;
                    var end = start + 2;
                    if (firstIdx === null) firstIdx = start;
                    lastIdx = end;
                }
            });
            if (firstIdx === null) return getDefaultCpQuarterRange();
            var firstHeader = cpMonthHeaderList[firstIdx];
            var lastHeader = cpMonthHeaderList[lastIdx];
            var firstYear = parseInt(firstHeader.Year || firstHeader.year, 10) || new Date().getFullYear();
            var lastYear = parseInt(lastHeader.Year || lastHeader.year, 10) || firstYear;
            var firstMonthIdx = firstIdx;
            var lastMonthIdx = lastIdx;
            var firstDate = getCpMonthDateValue(firstHeader);
            var lastDate = getCpMonthDateValue(lastHeader);
            if (firstDate) {
                var parsedFirst = new Date(firstDate);
                if (!isNaN(parsedFirst.getTime())) {
                    firstMonthIdx = parsedFirst.getMonth();
                    firstYear = parsedFirst.getFullYear();
                }
            }
            if (lastDate) {
                var parsedLast = new Date(lastDate);
                if (!isNaN(parsedLast.getTime())) {
                    lastMonthIdx = parsedLast.getMonth();
                    lastYear = parsedLast.getFullYear();
                }
            }
            var startRange = getMonthStartEndFromIndex(firstMonthIdx, firstYear);
            var endRange = getMonthStartEndFromIndex(lastMonthIdx, lastYear);
            return {
                start: startRange.start,
                end: endRange.end
            };
        }

        function getVisibleDetailMonthRange() {
            if (lastDetailContext && lastDetailContext.viewMode === 'quarter') {
                return getVisibleQuarterDetailRange() || getDefaultCpQuarterRange();
            }

            var visibleMonths = getVisibleDetailMonths();
            if (!visibleMonths.length) {
                var now = new Date();
                return {
                    start: toCpApiDate(new Date(now.getFullYear(), now.getMonth(), 1)),
                    end: toCpApiDate(now)
                };
            }

            var firstIdx = parseMonthNameToIndex(visibleMonths[0]);
            var lastIdx = parseMonthNameToIndex(visibleMonths[visibleMonths.length - 1]);
            if (firstIdx < 0) firstIdx = 0;
            if (lastIdx < 0) lastIdx = firstIdx;

            var startYear = getYearForVisibleMonth(visibleMonths[0]);
            var endYear = getYearForVisibleMonth(visibleMonths[visibleMonths.length - 1]);
            var startRange = getMonthStartEndFromIndex(firstIdx, startYear);
            var endRange = getMonthStartEndFromIndex(lastIdx, endYear);

            return {
                start: startRange.start,
                end: endRange.end
            };
        }

        function getSelectedCheckboxValues(panelSelector) {
            var values = [];
            $(panelSelector).find('.chk-item:checked').each(function () {
                values.push($(this).val());
            });
            return values;
        }

        function getSelectedCheckboxTexts(panelSelector) {
            var texts = [];
            $(panelSelector).find('.chk-item:checked').each(function () {
                var $label = $(this).closest('label');
                var text = '';
                if ($label.length) {
                    text = $.trim($label.clone().children().remove().end().text());
                }
                if (!text) {
                    text = $.trim($(this).parent().text());
                }
                if (text) {
                    texts.push(text);
                }
            });
            return texts;
        }

        function getCpSqlFilterParams(forExport) {
            var result = { bgouType: '', bgouFilter: '', skillList: '', roleList: '' };
            var bgValues = getSelectedCheckboxValues('#ddBusinessGroupPanel');
            var ouValues = getSelectedCheckboxValues('#ddOriginationUnitPanel');
            var roleSkillValues = getSelectedCheckboxValues('#ddRoleSkillPanel');

            if (roleSkillValues.length > 0) {

                var joined = roleSkillValues.join(',');

                if (currentType === 'Skill') {

                    result.skillList =
                        '(SKM.ToolID IN (' + joined + '))';

                    result.roleList = '';

                }
                else {

                    result.roleList =
                        '(Role.RoleID IN (' + joined + '))';

                    result.skillList = '';
                }
            }

            if (bgValues.length > 0) {
                var whereClause = 'EMP.BusinessGroupID in (' + bgValues.join(' , ') + ')';
                result.bgouType = 'O';
                result.bgouFilter = forExport ? whereClause : '(' + whereClause + ')';
            } else if (ouValues.length > 0) {
                var ouClause = 'EMP.LocationID in (' + ouValues.join(' , ') + ')';
                result.bgouType = 'O';
                result.bgouFilter = forExport ? ouClause : '(' + ouClause + ')';
            }

            return result;
        }

        function getFilterParams() {
            return getCpSqlFilterParams(false);
        }

        function buildTrendParams(viewType) {
            return JSON.stringify({
                bgouType: '',
                bgouFilter: '',
                skillList: '',
                viewType: viewType,
                BGOUType: '',
                BGOUFilter: '',
                SkillList: '',
                ViewType: viewType
            });
        }

        function cpIsSameCalendarMonth(startDate, endDate) {
            if (!startDate || !endDate) return true;
            var s = new Date(startDate);
            var e = new Date(endDate);
            if (isNaN(s.getTime()) || isNaN(e.getTime())) return true;
            return s.getFullYear() === e.getFullYear() && s.getMonth() === e.getMonth();
        }

        function resolveCpDrawerWeekOrMonth(startDate, endDate, quarterIndex) {
            if (quarterIndex !== undefined && quarterIndex !== null && quarterIndex !== '' && !isNaN(quarterIndex)) {
                return false;
            }
            return cpIsSameCalendarMonth(startDate, endDate);
        }

        function buildCPDetailsParams(startDate, endDate, options) {
            options = options || {};
            var filters = getFilterParams();
            var roleId = parseInt(expandedRowContext ? expandedRowContext.roleId : 0, 10) || 0;
            var skillId = parseInt(expandedRowContext ? expandedRowContext.skillId : 0, 10) || 0;
            var weekOrMonth = options.weekOrMonth;

            if (weekOrMonth === undefined) {
                weekOrMonth = true;
            }

            var pageNumber = options.pageNumber !== undefined ? options.pageNumber
                : (options.PageNumber !== undefined ? options.PageNumber : drawerCurrentPage);
            var pageSizeVal = options.pageSize !== undefined ? options.pageSize
                : (options.PageSize !== undefined ? options.PageSize : drawerPageSize);

            var defaultRange = getVisibleDetailMonthRange();
            return JSON.stringify({
                RoleID: currentType === 'Role' ? roleId : 0,
                SkillID: currentType === 'Skill' ? skillId : 0,
                UserID: parseInt(SessionEmployeeId, 10) || 0,
                StartDate: toCpApiDate(startDate || defaultRange.start),
                EndDate: toCpApiDate(endDate || defaultRange.end),
                Days: 0,
                RoleOrSkill: currentType === 'Role',
                WeekOrMonth: weekOrMonth,
                BGOUType: filters.bgouType || '',
                BGOUFilter: filters.bgouFilter || '',
                SkillList: filters.skillList || '',
                PageNumber: pageNumber,
                PageSize: pageSizeVal
            });
        }

        var filterGridReloadTimer = null;

        function reloadGridFromFilters() {
            updateAppliedFilterChips();
            clearTimeout(filterGridReloadTimer);
            filterGridReloadTimer = setTimeout(function () {
                currentPage = 1;
                if (currentView === 'Month') {
                    resetCpMonthViewDate();
                }
                LoadCapacityGrid();
            }, 250);
        }

        function getCheckboxLabelText($chk) {
            var $label = $chk.closest('label');
            if (!$label.length) return String($chk.val() || '');
            return $label.clone().children().remove().end().text().replace(/\s+/g, ' ').trim();
        }

        function collectAppliedFilterChipsFromPanel(panelId, dropdownId, filterLabel) {
            var chips = [];
            var $panel = $('#' + panelId);
            var $items = $panel.find('.chk-item');
            var $checked = $items.filter(':checked');
            if (!$checked.length) return chips;

            if ($checked.length === $items.length) {
                chips.push({
                    panelId: panelId,
                    dropdownId: dropdownId,
                    value: '__all__',
                    label: filterLabel,
                    text: 'All'
                });
                return chips;
            }

            $checked.each(function () {
                chips.push({
                    panelId: panelId,
                    dropdownId: dropdownId,
                    value: String($(this).val()),
                    label: filterLabel,
                    text: getCheckboxLabelText($(this))
                });
            });
            return chips;
        }

        function updateAppliedFilterChips() {
            var chips = [];
            chips = chips.concat(collectAppliedFilterChipsFromPanel(
                'ddBusinessGroupPanel',
                'ddBusinessGroup',
                cpResources.businessGroup || 'Business Group'
            ));
            chips = chips.concat(collectAppliedFilterChipsFromPanel(
                'ddOriginationUnitPanel',
                'ddOriginationUnit',
                'Organization Unit'
            ));
            chips = chips.concat(collectAppliedFilterChipsFromPanel(
                'ddRoleSkillPanel',
                'ddRoleSkill',
                currentType === 'Skill' ? (cpResources.skill || 'Skill') : (cpResources.role || 'Role')
            ));

            var $bar = $('#cpAppliedFilters');
            var $inner = $('#cpAppliedFiltersInner');
            if (!chips.length) {
                $inner.empty();
                $bar.removeClass('is-visible').hide();
                return;
            }

            var html = '';
            chips.forEach(function (chip) {
                var safeLabel = $('<div/>').text(chip.label).html();
                var safeText = $('<div/>').text(chip.text).html();
                var safeValue = $('<div/>').text(chip.value).html();
                html += '<span class="cp-filter-chip">' +
                    '<span class="cp-filter-chip-text" data-cp-full="' + cpEscAttr(chip.label + ': ' + chip.text) + '">' + safeLabel + ': ' + safeText + '</span>' +
                    '<button type="button" class="cp-filter-chip-remove" title="Remove" ' +
                    'data-panel="' + chip.panelId + '" data-value="' + safeValue + '">' +
                    '<i class="fas fa-times" aria-hidden="true"></i></button></span>';
            });
            $inner.html(html);
            $bar.addClass('is-visible').css('display', 'flex');
            scheduleCpBootstrapTooltips('#cpAppliedFilters');
        }

        $(document).on('click', '.cp-filter-chip-remove', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var panelId = $(this).attr('data-panel');
            var value = String($(this).attr('data-value') || '');
            var $panel = $('#' + panelId);
            if (!$panel.length) return;

            if (value === '__all__') {
                $panel.find('.chk-item, .chk-all').prop('checked', false);
            } else {
                $panel.find('.chk-item').each(function () {
                    if (String($(this).val()) === value) {
                        $(this).prop('checked', false);
                    }
                });
                var total = $panel.find('.chk-item').length;
                var checked = $panel.find('.chk-item:checked').length;
                $panel.find('.chk-all').prop('checked', total > 0 && total === checked);
            }

            UpdateDropdownText($panel);
            reloadGridFromFilters();
        });

        function buildCpParams(extra) {
            var filters = getFilterParams();
            var params = {
                bgouType: filters.bgouType,
                bgouFilter: filters.bgouFilter,
                skillList: filters.skillList,
                roleList: filters.roleList || '',
                currentDate: toCpApiDate(currentView === 'Month' ? getCpMonthViewDate() : new Date()),
                skillID: 0,
                roleID: 0,
                pageNumber: currentPage,
                pageSize: pageSize
            };
            if (extra) {
                if (extra.SkillID !== undefined || extra.skillID !== undefined) {
                    params.skillID = extra.SkillID !== undefined ? extra.SkillID : extra.skillID;
                }
                if (extra.RoleID !== undefined || extra.roleID !== undefined) {
                    params.roleID = extra.RoleID !== undefined ? extra.RoleID : extra.roleID;
                }
                if (extra.PageNumber !== undefined || extra.pageNumber !== undefined) {
                    params.pageNumber = extra.PageNumber !== undefined ? extra.PageNumber : extra.pageNumber;
                }
                if (extra.PageSize !== undefined || extra.pageSize !== undefined) {
                    params.pageSize = extra.PageSize !== undefined ? extra.PageSize : extra.pageSize;
                }
                if (extra.currentDate !== undefined) {
                    params.currentDate = extra.currentDate;
                }
            }
            return JSON.stringify(params);
        }

        function syncDetailRowWidth() {
            var width = $('.cp-grid-card').innerWidth();
            if (!width) return;
            $('.detail-row > td').css({ width: width + 'px', maxWidth: width + 'px' });
        }

        function showLoader() {
            var el = document.getElementById('loaderOverlay');
            if (el) { el.style.display = 'block'; }
        }
        function hideLoader() {
            var el = document.getElementById('loaderOverlay');
            if (el) { el.style.display = 'none'; }
        }

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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_W27_Dashboard"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(typeof isJson === 'function' && isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    result = data;
                },
                error: function (xhr, status, error) {
                    hideLoader();
                    if (xhr.status === 401) {
                        if (typeof benchNotifyError === 'function') {
                            benchNotifyError(benchResAuthFailed);
                        }
                    } else if (xhr.status === 400 && xhr.responseJSON) {
                        result = xhr.responseJSON;
                    } else {
                        var errMsg = (xhr.responseJSON && xhr.responseJSON.Message) ? xhr.responseJSON.Message : (error || status);
                        if (typeof alertify !== 'undefined') {
                            alertify.error(errMsg || cpResources.requestFailed);
                        }
                    }
                }
            });

            if (!async) { return result; }
            return null;
        }

        function pickHeaderValue(data) {
            if (!data) return 0;
            for (var i = 1; i < arguments.length; i++) {
                var key = arguments[i];
                if (data[key] !== undefined && data[key] !== null && data[key] !== '') {
                    return data[key];
                }
            }
            return 0;
        }

        function GetCapacityPlanHeaderCounts() {
            showLoader();
            var response = AJAXCallWithResult('api/RM_CapacityPlanning/GetCapacityPlanHeaderCounts', getCapacityPlanHeaderParam(), false);

            if (response) {
                var data = getResponseData(response);
                if (data) {
                    // Main KPI values: hours (not FTE ratio Allocated / Bench)
                    $('#lblTotalStrength').text(formatCpCountDisplay(pickHeaderValue(data, 'totalStrength', 'TotalStrength')));
                    $('#lblAllocated').text(formatCpHoursDisplay(pickHeaderValue(data, 'allocatedHours', 'AllocatedHours')));
                    $('#lblAllocatedPct').text(pickHeaderValue(data, 'allocatedPercentage', 'AllocatedPercentage') + '%');
                    $('#lblBench').text(formatCpHoursDisplay(pickHeaderValue(data, 'benchHours', 'BenchHours')));
                    $('#lblBenchPct').text(pickHeaderValue(data, 'benchPercentage', 'BenchPercentage') + '%');
                    $('#lblProjectRequests').text(formatCpCountDisplay(pickHeaderValue(data, 'projectRequests', 'ProjectRequests')));
                    $('#lblOpportunityRequests').text(formatCpCountDisplay(pickHeaderValue(data, 'opportunityRequests', 'OpportunityRequests')));
                }
            }
            hideLoader();
            scheduleCpBootstrapTooltips('.cp-kpi-grid');
        }

        /* ───────── Capacity grid rendering ───────── */

        var cpSampleRoleData = [
            { role: 'Administrator', totalStrength: 48, allocated: 36, bench: 12, requests: 5, utilizationPct: 75, q1: 76, q2: 88, q3: 92, q4: 80 },
            { role: 'Business Analyst', totalStrength: 72, allocated: 58, bench: 14, requests: 3, utilizationPct: 81, q1: 81, q2: 82, q3: 85, q4: 78 },
            { role: 'React Developer', totalStrength: 120, allocated: 95, bench: 25, requests: 8, utilizationPct: 79, q1: 88, q2: 104, q3: 115, q4: 105 },
            { role: 'QA Engineer', totalStrength: 110, allocated: 88, bench: 22, requests: 4, utilizationPct: 80, q1: 82, q2: 90, q3: 89, q4: 78 },
            { role: 'DevOps Engineer', totalStrength: 60, allocated: 42, bench: 18, requests: 2, utilizationPct: 70, q1: 68, q2: 78, q3: 78, q4: 71 },
            { role: 'AI Engineer', totalStrength: 40, allocated: 28, bench: 12, requests: 1, utilizationPct: 70, q1: 68, q2: 74, q3: 77, q4: 72 }
        ];

        // Legend bands (util % / numbers that use util colours):
        // Healthy  : >= 95          → green
        // Review   : >= 51 and < 95 → red   (51% – 94%)
        // Critical : >= 1  and < 51 → orange (1% – 50%)
        // No Data  : 0 / null / NaN → grey
        function cpUtilCategory(pct) {
            if (pct === null || pct === undefined || isNaN(pct)) return 'nodata';
            var n = Number(pct);
            if (n === 0) return 'nodata';
            if (n >= 95) return 'healthy';
            if (n >= 51) return 'review';
            if (n >= 1) return 'critical';
            return 'nodata';
        }

        function formatQuarterPct(pct) {
            if (pct === null || pct === undefined || isNaN(pct)) return null;
            return Math.round(pct * 100) / 100;
        }

        function isUtilizationMetric(name) {
            var n = String(name || '').toLowerCase();
            return n.indexOf('utilization') > -1 || n.indexOf('%') > -1;
        }

        function formatCpPercentDisplay(value) {
            var pct = formatQuarterPct(parseFloat(String(value == null ? '' : value).replace('%', '').replace(/,/g, '').trim()));
            if (pct === null || pct === undefined || isNaN(pct)) return '—';
            return pct + '%';
        }

        function formatCpMetricCell(metricName, value) {
            if (isUtilizationMetric(metricName)) return formatCpPercentDisplay(value);
            if (value === null || value === undefined || value === '') return formatCpCountDisplay(0);
            var num = parseFloat(String(value).replace(/,/g, '').trim());
            if (isNaN(num)) return value;
            return formatCpCountDisplay(Math.round(num * 100) / 100);
        }

        // Standardize the API metric label everywhere it is displayed.
        function getCpDisplayMetricName(metricName) {
            var name = String(metricName || '');
            if (/^allocated\s+to\s+projects?$/i.test(name.trim())) {
                return 'Project Allocated';
            }
            return name;
        }

        function getGridDisplayName(row) {
            if (currentType === 'Skill') {
                return row.SkillDescription || row.skillDescription ||
                    row.SkillName || row.skillName ||
                    row.Description || row.description || '';
            }
            return row.RoleName || row.roleName ||
                row.RoleDescription || row.roleDescription || '';
        }

        function sortCpGridRowsByName(rows) {
            if (!rows || !rows.length) return rows || [];
            return rows.slice().sort(function (a, b) {
                var an = String(
                    getGridDisplayName(a) || a.role || a.Role || a.skill || a.Skill || ''
                ).toLocaleLowerCase();
                var bn = String(
                    getGridDisplayName(b) || b.role || b.Role || b.skill || b.Skill || ''
                ).toLocaleLowerCase();
                if (an < bn) return -1;
                if (an > bn) return 1;
                return 0;
            });
        }

        function cpQuarterCellHtml(pct, quarterLabel, extraClass) {
            extraClass = extraClass || '';
            pct = formatQuarterPct(pct);
            if (pct === null || pct === undefined || isNaN(pct)) {
                return '<td class="cp-col-center cp-qcell-td cp-nodata' + extraClass + '">—</td>';
            }
            var cat = cpUtilCategory(pct);
            var text = pct + '%';
            var statusLabel = cat === 'healthy' ? cpResources.healthy : (cat === 'review' ? cpResources.needToReview : (cat === 'critical' ? cpResources.critical : cpResources.noData));
            var title = 'Utilization • ' + (quarterLabel || '') + ' avg: ' + text + ' (' + statusLabel + ')';
            return '<td class="cp-col-center cp-qcell-td cp-' + cat + extraClass + '" title="' + title + '">' + text + '</td>';
        }

        function cpUtilBarHtml(pct) {
            pct = formatQuarterPct(parseFloat(String(pct == null ? '' : pct).replace('%', '').replace(/,/g, '').trim()));
            if (pct === null || pct === undefined || isNaN(pct)) pct = 0;
            var cat = cpUtilCategory(pct);
            var width = Math.max(0, Math.min(100, pct));
            return '<div class="cp-util-bar-wrap">' +
                '<div class="cp-util-bar-track"><div class="cp-util-bar-fill cp-' + cat + '" style="width:' + width + '%;"></div></div>' +
                '<span class="cp-util-bar-pct cp-' + cat + '">' + pct + '%</span>' +
                '</div>';
        }

        function renderCapacityGrid(rows) {
            var $body = $('#tblCapacityBody');
            $body.empty();
            var labelCol = currentType === 'Skill' ? cpResources.skillLabel : cpResources.roleLabel;

            if (!rows || !rows.length) {
                $body.append('<tr><td colspan="10" style="text-align:center !important; padding: 30px;">' + cpResources.noItemsInView + '</td></tr>');
                $('#lblRecordCount').text(formatCpTotalRecords(0));
                return;
            }

            rows = sortCpGridRowsByName(rows);

            rows.forEach(function (r) {
                var name = r.role || r.skill || '';
                var roleName = formatCpRoleName(name);
                $body.append(
                    '<tr class="cp-master-row">' +
                    '<td><span class="cp-role-cell"><i class="fas fa-chevron-right expand-icon"></i>' + cpRoleNameHtml(roleName) + '</span></td>' +
                    '<td class="cp-col-center">' + formatCpCountDisplay(r.totalStrength) + '</td>' +
                    '<td class="cp-col-center">' + formatCpCountDisplay(r.allocated) + '</td>' +
                    '<td class="cp-col-center"><span class="cp-bench-val">' + formatCpCountDisplay(r.bench) + '</span></td>' +
                    '<td class="cp-col-center"><span class="cp-requests-val">' + formatCpCountDisplay(r.requests) + '</span></td>' +
                    '<td class="cp-util-col">' + cpUtilBarHtml(r.utilizationPct) + '</td>' +
                    cpQuarterCellHtml(r.q1, 'Q1 2026') +
                    cpQuarterCellHtml(r.q2, 'Q2 2026') +
                    cpQuarterCellHtml(r.q3, 'Q3 2026') +
                    cpQuarterCellHtml(r.q4, 'Q4 2026') +
                    '</tr>'
                );
            });

            $('#lblRecordCount').text(formatCpShowingToOf(1, rows.length, rows.length, labelCol + (rows.length === 1 ? '' : 's')));
            scheduleCpBootstrapTooltips('#tblCapacity');
        }



        $('#btnMonthView').click(function () {

            currentView = "Month";
            resetCpMonthViewDate();

            $('#btnMonthView, #btnQuarterView')
                .removeClass('active');

            $(this).addClass('active');
            currentPage = 1;
            GetCapacityPlanHeaderCounts();
            LoadCapacityGrid();

            $('.filter-section').show();
        });
        $('#btnQuarterView').click(function () {

            currentView = "Quarter";

            $('#btnMonthView, #btnQuarterView')
                .removeClass('active');

            $(this).addClass('active');
            currentPage = 1;
            GetCapacityPlanHeaderCounts();
            LoadCapacityGrid();

            $('.filter-section').show();
        });
        $('#btnByRole').click(function () {

            $('#btnByRole, #btnBySkill').removeClass('active');
            $(this).addClass('active');

            currentType = "Role";
            updateRoleSkillSearchPlaceholder();
            $('#ddRoleSkill .cp-dropdown-search').val('');

            GetCapacityPlanRoleFilterList();
            currentPage = 1;
            updateAppliedFilterChips();
            LoadCapacityGrid();
            loadRoleTrendAnalysis();
            loadSkillTrendAnalysis();
        });

        $('#btnBySkill').click(function () {

            $('#btnByRole, #btnBySkill').removeClass('active');
            $(this).addClass('active');

            currentType = "Skill";
            updateRoleSkillSearchPlaceholder();
            $('#ddRoleSkill .cp-dropdown-search').val('');

            GetCapacityPlanSkillFilterList();
            currentPage = 1;
            updateAppliedFilterChips();
            LoadCapacityGrid();
            loadRoleTrendAnalysis();
            loadSkillTrendAnalysis();
        });

        $('.cp-trend-toggle').on('click', '.cp-trend-btn', function () {
            var $toggle = $(this).closest('.cp-trend-toggle');
            $toggle.find('.cp-trend-btn').removeClass('active');
            $(this).addClass('active');
            var viewType = $(this).text().trim();
            if ($toggle.closest('.cp-trend-card').find('#roleTrendChart').length) {
                currentRoleTrendView = viewType;
                loadRoleTrendAnalysis();
            } else {
                currentSkillTrendView = viewType;
                loadSkillTrendAnalysis();
            }
        });

        /* ───────── Custom dropdown (Select Role / Select Skill) ─────────
           Generic open/close + outside-click-close wiring for any .cp-dropdown
           on the page. Currently used by #ddRoleSkill, but written so any
           future custom filter dropdown can reuse the same markup/CSS. */
        $(document).on('click', '.cp-dropdown-toggle', function (e) {
            e.stopPropagation();
            var $dd = $(this).closest('.cp-dropdown');
            var wasOpen = $dd.hasClass('open');
            $('.cp-dropdown').removeClass('open');
            if (!wasOpen) {
                $dd.addClass('open');
                setTimeout(function () {
                    $dd.find('.cp-dropdown-search').trigger('focus');
                }, 0);
            }
        });

        $(document).on('click', '.cp-dropdown-search', function (e) {
            e.stopPropagation();
        });

        $(document).on('input', '.cp-dropdown-search', function () {
            applyCpDropdownSearch($(this).closest('.cp-dropdown'));
        });

        $(document).on('click', '.multi-option', function (e) {
            e.stopPropagation();
        });

        $(document).on('click', '.cp-dropdown-panel', function (e) {
            e.stopPropagation();
        });

        $(document).on('click', function (e) {
            if ($(e.target).closest('.cp-dropdown').length === 0) {
                $('.cp-dropdown').removeClass('open');
            }
        });
        $(document).on('click', '.cp-dropdown-panel li', function () {
            if ($(this).hasClass('cp-dropdown-empty')) {
                return;
            }
            var $li = $(this);
            var $panel = $li.closest('.cp-dropdown-panel');
            var $dd = $li.closest('.cp-dropdown');
            var value = $li.attr('data-value');
            var text = $li.text();

            $panel.find('li').removeClass('selected');
            $li.addClass('selected');
            $dd.find('.cp-dropdown-toggle').text(text).attr('title', text);
            $dd.find('input[type="hidden"]').val(value).trigger('change');
        });

        /* Populates #ddRoleSkillPanel with <li> items (replaces old <option> injection). */
        function cpPopulateRoleSkillDropdown(items, placeholderText) {
            var $panel = $('#ddRoleSkillPanel');
            var $toggle = $('#ddRoleSkillToggle');
            var $hidden = $('#selRoleSkill');

            $panel.empty();
            $hidden.val('');
            $toggle.text(placeholderText).attr('title', placeholderText);

            if (!items || !items.length) {
                $panel.append('<li class="cp-dropdown-empty">' + placeholderText + '</li>');
                return;
            }

            items.forEach(function (item) {
                $panel.append(
                    '<li data-value="' + item.value + '">' + item.text + '</li>'
                );
            });
        }

        function GetCapacityPlanBGFilterList() {
            var response = AJAXCallWithResult('api/RM_CapacityPlanning/GetCapacityPlanBGFilterList', getFilterUserParam(), false);
            var list = getResponseList(response);
            if (list.length > 0) {
                var items = list.map(function (item) {
                    return {
                        value: item.businessGroupID || item.BusinessGroupID,
                        text: item.businessGroup || item.BusinessGroup
                    };
                });
                PopulateMultiSelect('ddBusinessGroupPanel', items, 'ddBusinessGroupToggle', cpResources.selectBusinessGroup);
            }
        }

        function GetOriginationUnitFilterList() {
            var response = AJAXCallWithResult('api/RM_CapacityPlanning/GetCapacityPlanOUFilterList', getFilterUserParam(), false);
            var list = getResponseList(response);
            if (list.length > 0) {
                var items = list.map(function (item) {
                    return {
                        value: item.locationID || item.locationId || item.LocationID,
                        text: item.location || item.Location
                    };
                });
                PopulateMultiSelect('ddOriginationUnitPanel', items, 'ddOriginationUnitToggle', cpResources.selectOriginationUnit);
            }
        }

        function GetCapacityPlanRoleFilterList() {
            var response = AJAXCallWithResult('api/RM_CapacityPlanning/GetCapacityPlanRoleFilterList', getFilterUserParam(), false);
            var list = getResponseList(response);
            if (list.length > 0) {
                var items = list.map(function (item) {
                    return {
                        value: item.roleID || item.RoleID,
                        text: item.roleDescription || item.RoleDescription
                    };
                });
                PopulateMultiSelect('ddRoleSkillPanel', items, 'ddRoleSkillToggle', cpResources.selectRole);
            } else {
                PopulateMultiSelect('ddRoleSkillPanel', [], 'ddRoleSkillToggle', cpResources.selectRole);
            }
        }

        function GetCapacityPlanSkillFilterList() {
            var response = AJAXCallWithResult('api/RM_CapacityPlanning/GetCapacityPlanSkillFilterList', getFilterUserParam(), false);
            var list = getResponseList(response);
            if (list.length > 0) {
                var items = list.map(function (item) {
                    return {
                        value: item.toolID || item.ToolID,
                        text: item.description || item.Description
                    };
                });
                PopulateMultiSelect('ddRoleSkillPanel', items, 'ddRoleSkillToggle', cpResources.selectSkill);
            } else {
                PopulateMultiSelect('ddRoleSkillPanel', [], 'ddRoleSkillToggle', cpResources.selectSkill);
            }
        }
        function ensureCpDropdownNoMatch($options) {
            if (!$options.find('.cp-dropdown-no-match').length) {
                $options.append('<div class="cp-dropdown-no-match" style="display:none;">No matches</div>');
            }
        }

        function applyCpDropdownSearch($dd) {
            if (!$dd || !$dd.length) return;
            var term = ($dd.find('.cp-dropdown-search').val() || '').trim().toLowerCase();
            var $options = $dd.find('.cp-dropdown-options');
            var $items = $options.find('.multi-option:not(.select-all), .cp-trend-option');
            var anyVisible = false;

            ensureCpDropdownNoMatch($options);

            $items.each(function () {
                var $item = $(this);
                var label = $item.find('.cp-trend-option-label').text() || $item.text();
                label = String(label).replace(/\s+/g, ' ').trim().toLowerCase();
                var match = !term || label.indexOf(term) > -1;
                $item.toggle(match);
                if (match) anyVisible = true;
            });

            if ($items.length === 0) {
                $options.find('.cp-dropdown-no-match').hide();
                return;
            }

            $options.find('.multi-option.select-all').toggle(anyVisible || !term);
            $options.find('.cp-dropdown-no-match').toggle(!anyVisible);
        }

        function updateRoleSkillSearchPlaceholder() {
            var isRole = $('#btnByRole').hasClass('active');
            $('#ddRoleSkillSearch').attr(
                'placeholder',
                isRole ? 'Search Role...' : 'Search Skill...'
            );
        }

        function PopulateMultiSelect(panelId, items, toggleId, defaultText) {
            var $panel = $('#' + panelId);
            var $dd = $panel.closest('.cp-dropdown');

            if (!items || !items.length) {
                $panel.html('<div class="multi-option" style="color:#94a3b8;">No options available</div>');
                $('#' + toggleId).text(defaultText);
                applyCpDropdownSearch($dd);
                return;
            }

            var html = '';

            $.each(items, function (i, item) {
                var val = item.value !== undefined && item.value !== null ? item.value : '';
                var text = item.text || '';
                html += '<label class="multi-option"><input type="checkbox" class="chk-item" value="' + val + '"> ' + text + '</label>';
            });

            $panel.html(html);
            ensureCpDropdownNoMatch($panel);
            $('#' + toggleId).text(defaultText);
            applyCpDropdownSearch($dd);
        }

        function clearFilterPanel(panelId, toggleId, defaultText) {
            var $panel = $('#' + panelId);
            $panel.find('.chk-item, .chk-all').prop('checked', false);
            $('#' + toggleId).text(defaultText);
        }

        $(document).on('change', '.chk-all', function () {
            var panel = $(this).closest('.cp-dropdown-panel');
            panel.find('.chk-item').prop('checked', this.checked);
            UpdateDropdownText(panel);
            reloadGridFromFilters();
        });

        $(document).on('change', '.chk-item', function () {
            var panel = $(this).closest('.cp-dropdown-panel');
            var total = panel.find('.chk-item').length;
            var checked = panel.find('.chk-item:checked').length;
            panel.find('.chk-all').prop('checked', total > 0 && total === checked);
            UpdateDropdownText(panel);
            reloadGridFromFilters();
        });

        $(document).on('click', '.cp-dd-clear', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var $dd = $(this).closest('.cp-dropdown');
            var ddId = $dd.attr('id') || '';

            if (ddId === 'ddRoleTrend' || ddId === 'ddSkillTrend') {
                var type = ddId === 'ddRoleTrend' ? 'role' : 'skill';
                var series = type === 'role' ? roleTrendSeries : skillTrendSeries;
                (series || []).forEach(function (s) { s.active = false; });
                $dd.find('.cp-dropdown-search').val('');
                renderTrendMultiSelect(type);
                applyTrendSelection(type);
                return;
            }

            var $panel = $dd.find('.cp-dropdown-panel');
            $panel.find('.chk-item, .chk-all').prop('checked', false);
            $dd.find('.cp-dropdown-search').val('');
            applyCpDropdownSearch($dd);
            UpdateDropdownText($panel);
            reloadGridFromFilters();
        });

        $(document).on('click', '.cp-dd-close', function (e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).closest('.cp-dropdown').removeClass('open');
        });

        $(document).on('click', '.cp-dd-actions', function (e) {
            e.stopPropagation();
        });

        function UpdateDropdownText(panel) {

            var dropdown = panel.closest('.multi-dropdown');
            var toggle = dropdown.find('.cp-dropdown-toggle');

            var checked = panel.find('.chk-item:checked');
            var totalItems = panel.find('.chk-item').length;

            var defaultText = '';

            if (dropdown.attr('id') === 'ddBusinessGroup')
                defaultText = cpResources.selectBusinessGroup;

            else if (dropdown.attr('id') === 'ddOriginationUnit')
                defaultText = cpResources.selectOriginationUnit;

            else
                defaultText = $('#btnByRole').hasClass('active')
                    ? cpResources.selectRole
                    : cpResources.selectSkill;

            if (checked.length === 0) {

                toggle.text(defaultText);
            }
            else if (checked.length === totalItems) {

                if (dropdown.attr('id') === 'ddBusinessGroup')
                    toggle.text(cpResources.allBusinessGroup);

                else if (dropdown.attr('id') === 'ddOriginationUnit')
                    toggle.text(cpResources.allOriginationUnit);

                else
                    toggle.text(
                        $('#btnByRole').hasClass('active')
                            ? cpResources.allRoles
                            : cpResources.allSkills
                    );
            }
            else if (checked.length === 1) {

                toggle.text(
                    checked.closest('label').text().trim()
                );
            }
            else {

                toggle.text(
                    cpResources.selected.replace('{0}', checked.length)
                );
            }
        }
        function getTrendViewType(label) {
            if (!label) return 'UTILIZATION';
            var t = label.toLowerCase();
            if (t.indexOf('alloc') > -1) return 'ALLOCATED';
            if (t.indexOf('bench') > -1) return 'BENCH';
            return 'UTILIZATION';
        }

        function isUtilizationTrendView(viewTypeOrLabel) {
            return String(viewTypeOrLabel || '').toLowerCase().indexOf('util') > -1;
        }

        function getTrendSeriesName(row) {
            return row.roleDescription || row.RoleDescription ||
                row.skillDescription || row.SkillDescription ||
                row.description || row.Description ||
                row.role || row.Role || row.roleName || row.RoleName ||
                row.skill || row.Skill || row.skillName || row.SkillName ||
                row.toolName || row.ToolName || row.name || row.Name || '';
        }

        function rowHasWideMonthColumns(row) {
            if (!row) return false;
            var keys = Object.keys(row).map(function (k) { return k.toLowerCase(); });
            var fullMonths = CP_FULL_MONTH_NAMES.map(function (m) { return m.toLowerCase(); });
            return keys.some(function (k) {
                return fullMonths.indexOf(k) >= 0 ||
                    /^month[_]?\d+$/.test(k) ||
                    CP_MONTH_LABELS.some(function (m) { return k === m.toLowerCase(); });
            });
        }

        function parseTrendNumber(value) {
            if (value === undefined || value === null || value === '') return null;
            var num = parseFloat(String(value).replace('%', '').replace(/,/g, '').trim());
            return isNaN(num) ? null : num;
        }

        function getTrendMonthIndexFromRow(row) {
            var m = row.monthNumber || row.MonthNumber || row.monthNo || row.MonthNo || row.monthIndex || row.MonthIndex || row.month || row.Month;
            if (m !== undefined && m !== null && m !== '') {
                var n = parseInt(m, 10);
                if (!isNaN(n)) return n > 0 ? n - 1 : n;
            }
            var monthName = (row.monthName || row.MonthName || '').toString().toLowerCase();
            if (monthName) {
                var idx = -1;
                CP_MONTH_LABELS.some(function (label, i) {
                    if (monthName === label.toLowerCase() || monthName.indexOf(label.toLowerCase()) === 0) {
                        idx = i;
                        return true;
                    }
                    return false;
                });
                if (idx >= 0) return idx;
            }
            return -1;
        }

        function getTrendMetricValueFromRow(row, viewType) {
            var view = (viewType || 'Utilization').toLowerCase();
            var keys = [
                view, viewType, viewType + 'Percentage', view + 'Percentage',
                'percentage', 'Percentage', 'value', 'Value', 'amount', 'Amount',
                'count', 'Count', 'utilization', 'Utilization', 'utilizationPercentage', 'UtilizationPercentage',
                'allocated', 'Allocated', 'bench', 'Bench'
            ];
            for (var i = 0; i < keys.length; i++) {
                if (row[keys[i]] !== undefined && row[keys[i]] !== null && row[keys[i]] !== '') {
                    return parseTrendNumber(row[keys[i]]);
                }
            }
            return null;
        }

        function getTrendMonthValueFromRow(row, monthIndex, viewType) {
            var num = monthIndex + 1;
            var monthName = CP_MONTH_LABELS[monthIndex];
            var fullMonthName = CP_FULL_MONTH_NAMES[monthIndex];
            var view = (viewType || 'UTILIZATION').toLowerCase();
            var candidates = [
                fullMonthName, fullMonthName.toLowerCase(),
                'Month_' + num, 'month_' + num, 'Month' + num, 'month' + num, 'M' + num,
                monthName, monthName.toLowerCase(),
                view + monthName, view + '_' + monthName, view + 'Month' + num, view + '_Month_' + num,
                viewType + monthName, viewType + 'Month' + num, viewType + '_Month_' + num,
                'Utilization' + monthName, 'Allocated' + monthName, 'Bench' + monthName,
                'utilizationMonth' + num, 'allocatedMonth' + num, 'benchMonth' + num
            ];

            var keyMap = {};
            Object.keys(row).forEach(function (k) {
                keyMap[k.toLowerCase()] = row[k];
            });

            for (var i = 0; i < candidates.length; i++) {
                var val = parseTrendNumber(keyMap[String(candidates[i]).toLowerCase()]);
                if (val !== null) return val;
            }

            return null;
        }

        function normalizeTrendRows(rows, viewType) {
            if (!rows || !rows.length) return [];
            if (rowHasWideMonthColumns(rows[0])) return rows;

            var grouped = {};
            rows.forEach(function (row) {
                var name = getTrendSeriesName(row);
                if (!name) return;
                var monthIdx = getTrendMonthIndexFromRow(row);
                var val = getTrendMetricValueFromRow(row, viewType);
                if (monthIdx < 0 || monthIdx > 11 || val === null) return;

                if (!grouped[name]) {
                    grouped[name] = {
                        name: name,
                        meta: row,
                        values: new Array(12)
                    };
                }
                grouped[name].values[monthIdx] = val;
            });

            var normalized = [];
            Object.keys(grouped).forEach(function (name) {
                var item = grouped[name];
                var row = $.extend({}, item.meta);
                row.roleDescription = row.roleDescription || row.RoleDescription || name;
                row.description = row.description || row.Description || name;
                for (var i = 0; i < 12; i++) {
                    row['Month_' + (i + 1)] = item.values[i] !== undefined ? item.values[i] : null;
                }
                normalized.push(row);
            });
            return normalized.length ? normalized : rows;
        }

        function parseTrendSeriesFromApi(rows, viewType) {
            rows = normalizeTrendRows(rows, viewType);
            if (!rows || !rows.length) return [];

            var series = rows.map(function (row, idx) {
                var name = getTrendSeriesName(row) || ('Series ' + (idx + 1));
                var values = [];

                for (var i = 0; i < 12; i++) {
                    var val = getTrendMonthValueFromRow(row, i, viewType);
                    values.push(val !== null ? val : 0);
                }

                if (values.every(function (v) { return v === 0; })) {
                    var arrays = [row.months, row.Months, row.data, row.Data, row.values, row.Values];
                    for (var a = 0; a < arrays.length; a++) {
                        if (arrays[a] && arrays[a].length) {
                            values = arrays[a].map(function (v) { return parseTrendNumber(v) || 0; });
                            while (values.length < 12) values.push(0);
                            if (values.length > 12) values = values.slice(0, 12);
                            break;
                        }
                    }
                }

                return {
                    id: row.roleID || row.RoleID || row.toolID || row.ToolID || idx,
                    name: name,
                    color: CP_CHART_COLORS[idx % CP_CHART_COLORS.length],
                    data: values,
                    active: false
                };
            });

            applyTopTrendSelection(series, CP_TREND_MAX_SELECTED);
            return series;
        }

        var CP_TREND_MAX_SELECTED = 5;

        function getTrendSeriesRankScore(seriesItem) {
            var sum = 0;
            (seriesItem.data || []).forEach(function (v) {
                var n = parseFloat(v);
                if (!isNaN(n)) sum += n;
            });
            return sum;
        }

        /* Select top N series by current metric values (Utilization / Allocated / Bench). */
        function applyTopTrendSelection(series, maxCount) {
            maxCount = maxCount || CP_TREND_MAX_SELECTED;
            if (!series || !series.length) return;
            series.forEach(function (s) { s.active = false; });
            var ranked = series.map(function (s, i) {
                return { s: s, i: i, score: getTrendSeriesRankScore(s) };
            }).sort(function (a, b) {
                if (b.score !== a.score) return b.score - a.score;
                return a.i - b.i;
            });
            ranked.slice(0, Math.min(maxCount, ranked.length)).forEach(function (item) {
                item.s.active = true;
            });
        }

        function getTrendSelectedCount(series) {
            return (series || []).filter(function (s) { return !!s.active; }).length;
        }

        function updateTrendSelectionFreeze(type) {
            var isRole = type === 'role';
            var series = isRole ? roleTrendSeries : skillTrendSeries;
            var $panel = $(isRole ? '#ddRoleTrendPanel' : '#ddSkillTrendPanel');
            if (!$panel.length || !series) return;

            var selectedCount = getTrendSelectedCount(series);
            var atMax = selectedCount >= CP_TREND_MAX_SELECTED;

            series.forEach(function (s, i) {
                var $chk = $panel.find('.chk-trend-item[data-series="' + i + '"]');
                var $opt = $chk.closest('.cp-trend-option');
                var freeze = atMax && !s.active;
                $chk.prop('disabled', freeze);
                $opt.toggleClass('is-frozen', freeze);
            });
        }

        function getTrendDropdownDefaultText(type) {
            return type === 'role' ? cpResources.selectRole : cpResources.selectSkill;
        }

        function getTrendDropdownAllText(type) {
            return type === 'role'
                ? (cpResources.allRoles || cpResources.selectRole)
                : (cpResources.allSkills || cpResources.selectSkill);
        }

        function updateTrendDropdownToggle(type) {
            var isRole = type === 'role';
            var series = isRole ? roleTrendSeries : skillTrendSeries;
            var $toggle = $(isRole ? '#ddRoleTrendToggle' : '#ddSkillTrendToggle');
            var selected = series.filter(function (s) { return s.active; });
            var defaultText = getTrendDropdownDefaultText(type);
            var allText = getTrendDropdownAllText(type);

            if (!series.length || !selected.length) {
                $toggle.text(defaultText).attr('title', defaultText);
                return;
            }

            if (selected.length === series.length || selected.length >= CP_TREND_MAX_SELECTED) {
                var selectedText = (cpResources.selected || '{0} selected').replace('{0}', selected.length);
                if (selected.length === series.length && series.length <= CP_TREND_MAX_SELECTED) {
                    $toggle.text(allText).attr('title', allText);
                } else {
                    $toggle.text(selectedText).attr('title', selectedText);
                }
                return;
            }

            if (selected.length <= 2) {
                var names = selected.map(function (s) { return s.name; }).join(', ');
                $toggle.text(names).attr('title', names);
                return;
            }

            var selectedText = (cpResources.selected || '{0} selected').replace('{0}', selected.length);
            $toggle.text(selectedText).attr('title', selectedText);
        }

        function renderTrendMultiSelect(type) {
            var isRole = type === 'role';
            var series = isRole ? roleTrendSeries : skillTrendSeries;
            var panelId = isRole ? 'ddRoleTrendPanel' : 'ddSkillTrendPanel';
            var $panel = $('#' + panelId);
            var $dd = $panel.closest('.cp-dropdown');
            var defaultText = getTrendDropdownDefaultText(type);

            if (!series || !series.length) {
                $panel.html('<div class="cp-trend-option" style="color:#94a3b8;">No options available</div>');
                $(isRole ? '#ddRoleTrendToggle' : '#ddSkillTrendToggle').text(defaultText).attr('title', defaultText);
                applyCpDropdownSearch($dd);
                return;
            }

            var html = '';

            series.forEach(function (s, i) {
                var checked = s.active ? ' checked' : '';
                var activeClass = s.active ? ' is-active' : '';
                html += '<label class="cp-trend-option' + activeClass + '">' +
                    '<input type="checkbox" class="chk-trend-item" data-trend-type="' + type + '" data-series="' + i + '"' + checked + '>' +
                    '<span class="cp-trend-option-label">' + s.name + '</span></label>';
            });

            $panel.html(html);
            ensureCpDropdownNoMatch($panel);
            applyCpDropdownSearch($dd);
            updateTrendSelectionFreeze(type);
            updateTrendDropdownToggle(type);
        }

        function syncTrendDropdownChecks(type) {
            var isRole = type === 'role';
            var series = isRole ? roleTrendSeries : skillTrendSeries;
            var $panel = $(isRole ? '#ddRoleTrendPanel' : '#ddSkillTrendPanel');

            series.forEach(function (s, i) {
                var $opt = $panel.find('.chk-trend-item[data-series="' + i + '"]').closest('.cp-trend-option');
                var $chk = $panel.find('.chk-trend-item[data-series="' + i + '"]');
                $chk.prop('checked', !!s.active);
                $opt.toggleClass('is-active', !!s.active);
            });

            updateTrendSelectionFreeze(type);
            updateTrendDropdownToggle(type);
        }

        function applyTrendSelection(type) {
            syncTrendDropdownChecks(type);
            renderTrendChart(type, true);
        }

        $(document).on('change', '.chk-trend-item', function (e) {
            e.stopPropagation();
            var type = $(this).attr('data-trend-type');
            var idx = parseInt($(this).attr('data-series'), 10);
            var series = type === 'role' ? roleTrendSeries : skillTrendSeries;
            if (!series[idx]) return;

            if (this.checked) {
                var selectedCount = getTrendSelectedCount(series);
                if (selectedCount >= CP_TREND_MAX_SELECTED && !series[idx].active) {
                    this.checked = false;
                    return;
                }
                series[idx].active = true;
            } else {
                series[idx].active = false;
            }
            applyTrendSelection(type);
        });

        $(document).on('click', '.cp-trend-option', function (e) {
            e.stopPropagation();
        });

        function getTrendChartMaxValue(datasets, viewType) {
            var maxVal = 0;
            datasets.forEach(function (ds) {
                (ds.data || []).forEach(function (v) {
                    if (!isNaN(v) && v > maxVal) maxVal = v;
                });
            });
            if (isUtilizationTrendView(viewType)) {
                if (maxVal <= 100) return 140;
                if (maxVal <= 200) return 200;
                if (maxVal <= 400) return 400;
                if (maxVal <= 600) return 600;
                if (maxVal <= 800) return 800;
                if (maxVal <= 1200) return 1200;
                return Math.ceil(maxVal / 200) * 200;
            }
            if (maxVal <= 0) return 10;
            return Math.ceil(maxVal / 50) * 50;
        }

        function renderTrendChartLegend(legendId, datasets) {
            if (!datasets || !datasets.length) {
                $('#' + legendId).html('');
                return;
            }
            var html = '';
            datasets.forEach(function (ds) {
                var color = ds.borderColor || '#3b82f6';
                html += '<span class="cp-chart-legend-item">' +
                    '<span class="cp-chart-legend-line" style="color:' + color + ';">' +
                    '<span class="cp-chart-legend-dot" style="border-color:' + color + ';"></span></span>' +
                    '<span>' + (ds.label || '') + '</span></span>';
            });
            $('#' + legendId).html(html);
        }

        var cpTrendHoverLinePlugin = {
            afterDraw: function (chart) {
                if (!chart || !chart.tooltip || !chart.tooltip._active || !chart.tooltip._active.length) return;
                var ctx = chart.ctx;
                var chartArea = chart.chartArea;
                var activePoint = chart.tooltip._active[0];
                if (!ctx || !chartArea || !activePoint || !activePoint.element) return;

                var x = activePoint.element.x;
                ctx.save();
                ctx.beginPath();
                ctx.moveTo(x, chartArea.top);
                ctx.lineTo(x, chartArea.bottom);
                ctx.lineWidth = 1;
                ctx.strokeStyle = 'rgba(100, 116, 139, 0.55)';
                ctx.stroke();
                ctx.restore();
            }
        };

        function hideCpTrendTooltip() {
            var tooltipEl = document.getElementById('cpTrendChartTooltip');
            if (tooltipEl) {
                tooltipEl.style.opacity = '0';
                tooltipEl.style.left = '-9999px';
                tooltipEl.style.top = '-9999px';
            }
        }

        function getCpTrendTooltipEl() {
            var tooltipEl = document.getElementById('cpTrendChartTooltip');
            if (!tooltipEl) {
                tooltipEl = document.createElement('div');
                tooltipEl.id = 'cpTrendChartTooltip';
                document.body.appendChild(tooltipEl);
            }
            // Always keep tooltip above chart canvas / page content
            tooltipEl.style.position = 'fixed';
            tooltipEl.style.zIndex = '30000';
            tooltipEl.style.pointerEvents = 'none';
            if (tooltipEl.parentNode !== document.body) {
                document.body.appendChild(tooltipEl);
            }
            return tooltipEl;
        }

        function externalTrendTooltipHandler(context) {
            var chart = context && context.chart ? context.chart : null;
            var tooltip = context && context.tooltip ? context.tooltip : null;
            var tooltipEl = getCpTrendTooltipEl();

            if (!chart || !tooltip || tooltip.opacity === 0) {
                hideCpTrendTooltip();
                return;
            }

            var title = (tooltip.title && tooltip.title.length) ? tooltip.title[0] : '';
            var dataPoints = (tooltip.dataPoints || []).slice();
            var dsList = (chart.data && chart.data.datasets) ? chart.data.datasets : [];
            var isUtil = chart.$cpIsUtilizationTrend === true;

            // Keep names readable / A-Z in tooltip
            dataPoints.sort(function (a, b) {
                var la = String(((dsList[a.datasetIndex] || {}).label) || '').toLowerCase();
                var lb = String(((dsList[b.datasetIndex] || {}).label) || '').toLowerCase();
                if (la < lb) return -1;
                if (la > lb) return 1;
                return 0;
            });

            var linesHtml = '';
            dataPoints.forEach(function (dp) {
                var ds = dsList[dp.datasetIndex] || {};
                var label = ds.label || '';
                var color = ds.borderColor || '#2563eb';
                var val = dp.raw !== undefined ? dp.raw : (dp.formattedValue !== undefined ? dp.formattedValue : '');
                if (isUtil && val !== null && val !== undefined && String(val).indexOf('%') === -1) {
                    val = val + '%';
                } else if (val !== null && val !== undefined && isCpPlainNumericValue(val)) {
                    val = formatCpNumberWithCommas(val);
                }
                linesHtml += '<div class="cp-trend-tooltip-item" style="color:' + color + ';">' + label + ': ' + val + '</div>';
            });

            tooltipEl.innerHTML = '<div class="cp-trend-tooltip-title">' + title + '</div>' + linesHtml;
            tooltipEl.style.position = 'fixed';
            tooltipEl.style.zIndex = '30000';
            tooltipEl.style.opacity = '0';
            tooltipEl.style.left = '0px';
            tooltipEl.style.top = '0px';
            tooltipEl.style.display = 'block';

            var rect = chart.canvas.getBoundingClientRect();
            var tooltipWidth = tooltipEl.offsetWidth || 220;
            var tooltipHeight = tooltipEl.offsetHeight || 80;

            // Prefer right of caret; keep fully visible in viewport (above chart lines)
            var left = rect.left + tooltip.caretX + 14;
            var top = rect.top + tooltip.caretY - (tooltipHeight / 2);

            if (left + tooltipWidth > window.innerWidth - 8) {
                left = rect.left + tooltip.caretX - tooltipWidth - 14;
            }
            if (left < 8) left = 8;
            if (top < 8) top = 8;
            if (top + tooltipHeight > window.innerHeight - 8) {
                top = Math.max(8, window.innerHeight - tooltipHeight - 8);
            }

            tooltipEl.style.left = left + 'px';
            tooltipEl.style.top = top + 'px';
            tooltipEl.style.opacity = '1';
        }

        function getTrendChartOptions(datasets, viewLabel) {
            var isUtil = isUtilizationTrendView(viewLabel);
            var yMax = getTrendChartMaxValue(datasets || [], viewLabel);
            var step = isUtil ? (yMax <= 140 ? 35 : (yMax <= 200 ? 40 : Math.ceil(yMax / 5))) : Math.max(10, Math.ceil(yMax / 5));
            return {
                responsive: true,
                maintainAspectRatio: false,
                layout: {
                    padding: {
                        top: 0,
                        left: 6,
                        right: 6,
                        bottom: 0
                    }
                },
                interaction: {
                    mode: 'index',
                    intersect: false
                },
                hover: {
                    mode: 'index',
                    intersect: false
                },
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        enabled: false,
                        mode: 'index',
                        intersect: false,
                        external: externalTrendTooltipHandler
                    }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { font: { size: 10 }, color: '#64748b' }
                    },
                    y: {
                        grid: { display: false },
                        beginAtZero: true,
                        max: yMax,
                        ticks: {
                            stepSize: step,
                            font: { size: 10 },
                            color: '#64748b',
                            callback: function (value) { return value + (isUtil ? '%' : ''); }
                        }
                    }
                },
                elements: { point: { radius: 4, hitRadius: 10, hoverRadius: 5, borderWidth: 2 }, line: { tension: 0.35, borderWidth: 2 } }
            };
        }

        function renderTrendChart(type, skipDropdownRender) {
            if (typeof Chart === 'undefined') return;

            var isRole = type === 'role';
            var series = isRole ? roleTrendSeries : skillTrendSeries;
            var canvasId = isRole ? 'roleTrendChart' : 'skillTrendChart';
            var chartRef = isRole ? 'roleTrendChartInst' : 'skillTrendChartInst';
            var legendId = isRole ? 'roleTrendLegend' : 'skillTrendLegend';

            if (!skipDropdownRender) {
                renderTrendMultiSelect(type);
            }

            var datasets = [];

            series.forEach(function (s) {

                if (!s.active) return;

                datasets.push({
                    label: s.name,
                    data: s.data,

                    borderColor: s.color,

                    // Filled line color
                    backgroundColor: s.color,

                    fill: false,

                    // ===== Point Styling =====
                    pointRadius: 2.5,            // Smaller point
                    pointHoverRadius: 4,
                    pointHitRadius: 8,

                    pointBackgroundColor: s.color,   // Filled point
                    pointBorderColor: s.color,       // Same border color
                    pointBorderWidth: 1
                });
            });

            var ctx = document.getElementById(canvasId);
            if (!ctx) return;

            if (window[chartRef]) {
                window[chartRef].destroy();
            }

            var viewLabel = isRole ? currentRoleTrendView : currentSkillTrendView;

            window[chartRef] = new Chart(ctx.getContext('2d'), {
                type: 'line',
                data: {
                    labels: CP_MONTH_LABELS,
                    datasets: datasets
                },
                plugins: [cpTrendHoverLinePlugin],
                options: $.extend(true, {}, getTrendChartOptions(datasets, viewLabel), {
                    legend: {
                        display: false
                    }
                })
            });

            window[chartRef].$cpIsUtilizationTrend = isUtilizationTrendView(viewLabel);

            if (window[chartRef].legend) {
                window[chartRef].legend.options.display = false;
            }

            renderTrendChartLegend(legendId, datasets);
        }

        function loadRoleTrendAnalysis() {
            var viewType = getTrendViewType(currentRoleTrendView);
            var response = AJAXCallWithResult(
                'api/RM_CapacityPlanning/RoleWiseTrendAnalysis',
                buildTrendParams(viewType),
                false
            );
            roleTrendSeries = parseTrendSeriesFromApi(getResponseList(response), viewType);
            if (!roleTrendSeries.length) {
                roleTrendSeries = parseTrendSeriesFromApi(cpSampleRoleData.map(function (r) {
                    var obj = { roleDescription: r.role };
                    CP_MONTH_LABELS.forEach(function (m, i) {
                        obj['Month_' + (i + 1)] = r.utilizationPct;
                    });
                    return obj;
                }), viewType);
            }
            renderTrendChart('role');
        }

        function loadSkillTrendAnalysis() {
            var viewType = getTrendViewType(currentSkillTrendView);
            var response = AJAXCallWithResult(
                'api/RM_CapacityPlanning/SkillWiseTrendAnalysis',
                buildTrendParams(viewType),
                false
            );
            skillTrendSeries = parseTrendSeriesFromApi(getResponseList(response), viewType);
            if (!skillTrendSeries.length) {
                skillTrendSeries = parseTrendSeriesFromApi(cpSampleRoleData.map(function (r) {
                    var obj = { description: r.role };
                    CP_MONTH_LABELS.forEach(function (m, i) {
                        obj['Month_' + (i + 1)] = r.utilizationPct;
                    });
                    return obj;
                }), viewType);
            }
            renderTrendChart('skill');
        }

        function getQuarterFixedColumns() {
            var cols = ['RoleName', 'SkillName', 'roleName', 'skillName', 'RoleDescription', 'roleDescription',
                'SkillDescription', 'skillDescription',
                'Description', 'description', 'TotalStrength', 'totalStrength', 'Allocated', 'allocated',
                'Bench', 'bench', 'Requests', 'requests', 'UtilizationPercentage', 'utilizationPercentage',
                'RoleID', 'roleID', 'ToolID', 'toolID', 'Q1', 'Q2', 'Q3', 'Q4', 'q1', 'q2', 'q3', 'q4',
                'Quarter1', 'Quarter2', 'Quarter3', 'Quarter4',
                'Q1Utilization', 'Q2Utilization', 'Q3Utilization', 'Q4Utilization',
                'q1Utilization', 'q2Utilization', 'q3Utilization', 'q4Utilization'];
            CP_FULL_MONTH_NAMES.forEach(function (m) {
                cols.push(m);
                cols.push(m.toLowerCase());
            });
            return cols;
        }

        var MONTH_NAME_INDEX = { jan: 1, feb: 2, mar: 3, apr: 4, may: 5, jun: 6, jul: 7, aug: 8, sep: 9, oct: 10, nov: 11, dec: 12 };

        function findMonthColumnKey(columns, monthName) {
            var target = monthName.toLowerCase();
            var monthIdx = MONTH_NAME_INDEX[target];

            for (var i = 0; i < columns.length; i++) {
                var col = columns[i];
                var colLower = col.toLowerCase();
                if (colLower === target) return col;
                if (colLower.indexOf(target) === 0) return col;
            }

            if (monthIdx) {
                var numericKeys = ['Month_' + monthIdx, 'month_' + monthIdx, 'Month' + monthIdx, 'M' + monthIdx];
                for (var j = 0; j < numericKeys.length; j++) {
                    if (columns.indexOf(numericKeys[j]) > -1) return numericKeys[j];
                }
                for (var k = 0; k < columns.length; k++) {
                    if (columns[k].toLowerCase() === numericKeys[0].toLowerCase()) return columns[k];
                }
            }
            return null;
        }

        function getCpCalendarQuarterNumber(qKeyOrIdx) {
            var qDef = null;
            if (typeof qKeyOrIdx === 'number') {
                qDef = QUARTER_DEFS[qKeyOrIdx];
            } else if (qKeyOrIdx) {
                for (var i = 0; i < QUARTER_DEFS.length; i++) {
                    if (QUARTER_DEFS[i].key === qKeyOrIdx) {
                        qDef = QUARTER_DEFS[i];
                        break;
                    }
                }
            }
            if (qDef) {
                var lm = String(qDef.label || '').match(/Q\s*([1-4])/i);
                if (lm) return lm[1];
                if (qDef.fullMonths && qDef.fullMonths[0]) {
                    var fl = String(qDef.fullMonths[0]).toLowerCase();
                    var mi = CP_FULL_MONTH_NAMES.findIndex(function (n) {
                        return n.toLowerCase() === fl;
                    });
                    if (mi >= 0) return String(Math.floor(mi / 3) + 1);
                }
            }
            if (typeof qKeyOrIdx === 'string' && qKeyOrIdx.length > 1) return qKeyOrIdx.charAt(1);
            return String((qKeyOrIdx || 0) + 1);
        }

        function getQuarterSummaryValue(row, qKey) {
            // Use calendar Q from label (Q2 2026 / Q1 2027), not UI slot key.
            // SP: Q1Utilization=Jan–Mar, Q2=Apr–Jun, … and January…December = that month only.
            var n = getCpCalendarQuarterNumber(qKey);
            var keys = [
                'Q' + n + 'Utilization', 'q' + n + 'Utilization',
                'Q' + n, 'q' + n,
                'quarter' + n, 'Quarter' + n
            ];
            for (var i = 0; i < keys.length; i++) {
                var v = row[keys[i]];
                if (v !== undefined && v !== null && v !== '') return v;
            }
            return null;
        }

        function getQuarterMonthValue(row, fullMonthName, shortMonth) {
            if (row[fullMonthName] !== undefined && row[fullMonthName] !== null) return row[fullMonthName];
            if (row[fullMonthName.toLowerCase()] !== undefined && row[fullMonthName.toLowerCase()] !== null) {
                return row[fullMonthName.toLowerCase()];
            }
            var colKey = findMonthColumnKey(Object.keys(row), shortMonth);
            if (colKey && row[colKey] !== undefined && row[colKey] !== null) return row[colKey];
            return null;
        }

        function syncQuarterTableLayout() {
            if (currentView !== 'Quarter') {
                $('#tblCapacity').removeClass('cp-quarter-table cp-quarter-expanded');
                $('.cp-grid-container').removeClass('cp-quarter-view cp-quarter-expanded');
                return;
            }
            var anyExpanded = QUARTER_DEFS.some(function (q) { return expandedQuarters[q.key]; });
            $('#tblCapacity').removeClass('cp-month-fit').addClass('cp-quarter-table').toggleClass('cp-quarter-expanded', anyExpanded);
            $('.cp-grid-container').removeClass('cp-month-view').toggleClass('cp-quarter-view', !anyExpanded).toggleClass('cp-quarter-expanded', anyExpanded);
        }

        function buildQuarterColGroup() {
            var html = '<col style="width:18%"><col style="width:8%"><col style="width:8%"><col style="width:7%"><col style="width:7%"><col style="width:11%">';
            QUARTER_DEFS.forEach(function (q) {
                if (expandedQuarters[q.key]) {
                    q.months.forEach(function () {
                        html += '<col style="width:56px">';
                    });
                } else {
                    html += '<col style="width:10%">';
                }
            });
            $('#tblCapacityColGroup').html(html);
        }

        function BuildQuarterGridFromApi(apiRows) {
            if (!apiRows || !apiRows.length) {
                BuildQuarterGrid();
                return;
            }

            apiRows = sortCpGridRowsByName(apiRows);

            var fixedColumns = getQuarterFixedColumns();
            var monthColumns = Object.keys(apiRows[0]).filter(function (key) {
                return fixedColumns.indexOf(key) === -1;
            });

            lastQuarterGridContext = { apiData: apiRows, monthColumns: monthColumns };
            renderQuarterGrid();
        }

        function getCpCurrentQuarterKey() {
            // Use the actual current month, not the month currently being viewed.
            return 'Q' + (Math.floor(new Date().getMonth() / 3) + 1);
        }

        // Fiscal headers are stored in Apr–Mar order, so their array key may not
        // match the displayed quarter label (for example, slot Q3 can show Q4).
        function getDisplayedQuarterKey(q) {
            var match = String((q && q.label) || '').match(/\bQ([1-4])\b/i);
            return match ? ('Q' + match[1]) : ((q && q.key) || '');
        }

        function isCpCurrentQuarter(q) {
            return getDisplayedQuarterKey(q) === getCpCurrentQuarterKey();
        }

        function getCpCurrentQuarterCellClass(q, partIndex, partCount) {
            if (!isCpCurrentQuarter(q)) return '';
            var className = ' cp-current-quarter';
            if (partCount > 1) {
                if (partIndex === 0) className += ' cp-current-quarter-start';
                if (partIndex === partCount - 1) className += ' cp-current-quarter-end';
            }
            return className;
        }

        function renderQuarterGrid() {
            if (!lastQuarterGridContext) return;

            var apiData = lastQuarterGridContext.apiData;
            var monthColumns = lastQuarterGridContext.monthColumns;
            var firstColumnHeader = getCapacityFirstColumnHeader();
            var headerHtml = '<tr>';
            headerHtml += '<th rowspan="2"><span class="cp-role-cell">' + firstColumnHeader + ' <i class="fas fa-chevron-down cp-sort-icon"></i></span></th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.totalStrength + '</th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.allocated + '</th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.bench + '</th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.requests + '</th>';
            headerHtml += '<th rowspan="2" class="cp-util-col">' + cpResources.utilizationPercent + '</th>';

            QUARTER_DEFS.forEach(function (q) {
                var currentQuarterClass = getCpCurrentQuarterCellClass(q, 0, 1);
                var currentQuarterLabel = currentQuarterClass ? '<span class="cp-current-quarter-label">Current</span>' : '';
                if (expandedQuarters[q.key]) {
                    headerHtml += '<th colspan="' + q.months.length + '" class="cp-quarter-head cp-q' + q.key.charAt(1) + ' cp-expanded' + currentQuarterClass + '">' +
                        currentQuarterLabel +
                        '<button type="button" class="cp-quarter-label cp-quarter-toggle" data-quarter="' + q.key + '">' +
                        '<i class="fas fa-chevron-down"></i> ' + q.label +
                        '</button>' +
                        '</th>';
                } else {
                    headerHtml += '<th rowspan="2" class="cp-quarter-head cp-q' + q.key.charAt(1) + currentQuarterClass + '">' +
                        currentQuarterLabel +
                        '<button type="button" class="cp-quarter-label cp-quarter-toggle" data-quarter="' + q.key + '">' +
                        '<i class="fas fa-chevron-right"></i> ' + q.label +
                        '</button>' +
                        '<div class="cp-quarter-sub">UTILIZATION %</div>' +
                        '</th>';
                }
            });
            headerHtml += '</tr><tr>';

            QUARTER_DEFS.forEach(function (q) {
                if (expandedQuarters[q.key]) {
                    q.months.forEach(function (month, monthIndex) {
                        var currentQuarterClass = getCpCurrentQuarterCellClass(q, monthIndex, q.months.length);
                        headerHtml +=
                            '<th class="cp-col-center' + currentQuarterClass + '">' +
                            '<div>' + month + '</div>' +
                            '<div style="font-size:10px;color:#6b7280;">UTIL %</div>' +
                            '</th>';
                    });
                }
            });
            headerHtml += '</tr>';

            $('#tblCapacityHead').html(headerHtml);
            buildQuarterColGroup();
            syncQuarterTableLayout();
            renderQuarterRows(apiData, monthColumns);
        }

        function renderQuarterRows(rows, monthColumns) {
            var html = '';
            rows.forEach(function (row) {
                var displayName = getGridDisplayName(row);
                var roleName = formatCpRoleName(displayName);
                var util = row.UtilizationPercentage || row.utilizationPercentage || 0;

                html += '<tr class="cp-master-row" data-key="' + displayName + '" data-roleid="' + getRowRoleId(row) +
                    '" data-skillid="' + getRowSkillId(row) + '">';
                html += '<td><span class="cp-role-cell"><i class="fas fa-chevron-right expand-icon"></i>' + cpRoleNameHtml(roleName) + '</span></td>';
                html += '<td class="cp-col-center">' + formatCpCountDisplay(row.TotalStrength || row.totalStrength || 0) + '</td>';
                html += '<td class="cp-col-center">' + formatCpCountDisplay(row.Allocated || row.allocated || 0) + '</td>';
                html += '<td class="cp-col-center"><span class="cp-bench-val">' + formatCpCountDisplay(row.Bench || row.bench || 0) + '</span></td>';
                html += '<td class="cp-col-center"><span class="cp-requests-val">' + formatCpCountDisplay(row.Requests || row.requests || 0) + '</span></td>';
                html += '<td class="cp-util-col">' + cpUtilBarHtml(util) + '</td>';

                QUARTER_DEFS.forEach(function (q) {
                    if (expandedQuarters[q.key]) {
                        q.fullMonths.forEach(function (fullMonth, mi) {
                            var currentQuarterClass = getCpCurrentQuarterCellClass(q, mi, q.fullMonths.length);
                            var value = getQuarterMonthValue(row, fullMonth, q.months[mi]);
                            var qNum = (value === null || value === undefined || value === '') ? null : formatQuarterPct(parseFloat(String(value).replace('%', '')));
                            html += cpQuarterCellHtml(qNum, q.months[mi], currentQuarterClass);
                        });
                    } else {
                        var currentQuarterClass = getCpCurrentQuarterCellClass(q, 0, 1);
                        var qVal = getQuarterSummaryValue(row, q.key);
                        var qNum = (qVal === null || qVal === undefined || qVal === '') ? null : formatQuarterPct(parseFloat(String(qVal).replace('%', '')));
                        html += cpQuarterCellHtml(qNum, q.label, currentQuarterClass);
                    }
                });
                html += '</tr>';
            });

            $('#tblCapacityBody').html(html);
            scheduleCpBootstrapTooltips('#tblCapacity, .cp-grid-container');
        }

        $(document).on('click', '.cp-quarter-toggle', function (e) {
            e.stopPropagation();
            if (currentView !== 'Quarter') return;
            var q = $(this).data('quarter');
            expandedQuarters[q] = !expandedQuarters[q];
            renderQuarterGrid();
        });

        function BuildQuarterGrid() {
            lastQuarterGridContext = { apiData: sortCpGridRowsByName(cpSampleRoleData.map(function (r) {
                var row = mapQuarterApiRow(r);
                return {
                    RoleName: row.role,
                    TotalStrength: row.totalStrength,
                    Allocated: row.allocated,
                    Bench: row.bench,
                    Requests: row.requests,
                    UtilizationPercentage: row.utilizationPct,
                    Q1: row.q1, Q2: row.q2, Q3: row.q3, Q4: row.q4,
                    Jan: row.q1, Feb: row.q1, Mar: row.q2, Apr: row.q2, May: row.q3, Jun: row.q3,
                    Jul: row.q3, Aug: row.q4, Sep: row.q4, Oct: row.q4, Nov: row.q4, Dec: row.q4,
                    RoleID: 0, ToolID: 0
                };
            })), monthColumns: CP_MONTH_LABELS };
            renderQuarterGrid();
            totalPages = 1;
            currentPage = 1;
            $('#btnCurrentPage').text('1');
            updatePaginationButtons();
        }

        function getCapacityFirstColumnHeader() {
            return currentType === 'Skill' ? cpResources.skill : cpResources.role;
        }

        function updateCapacityGridFirstColumnHeader() {
            var label = getCapacityFirstColumnHeader();
            var $firstTh = $('#tblCapacityHead tr:first th:first');
            if (!$firstTh.length) return;

            if ($firstTh.find('.cp-role-cell').length) {
                $firstTh.find('.cp-role-cell').html(label + ' <i class="fas fa-chevron-down cp-sort-icon"></i>');
            } else {
                $firstTh.text(label);
            }
        }

        function renderCapacityGridNoRecords() {
            updateCapacityGridFirstColumnHeader();
            $('#tblCapacityBody').html('<tr><td colspan="20" class="text-center">No Records Found</td></tr>');
            $('#lblRecordCount').text(formatCpTotalRecords(0));
            totalPages = 1;
            currentPage = 1;
            $('#btnCurrentPage').text('1');
            updatePaginationButtons();
        }

        function GetQuarterRoleData() {

            showLoader();

            var response = AJAXCallWithResult(
                'api/RM_CapacityPlanning/GetCP_RoleWise_QtrHeader',
                buildCpParams(),
                false
            );

            hideLoader();

            var rows = getResponseList(response);

            lastQuarterHeaderResponse = response;
            storeCpMonthHeaders(response);

            if (rows.length > 0) {

                BuildQuarterGridFromApi(rows);
                applyPagination(response, rows.length);

            } else {

                renderCapacityGridNoRecords();
            }
        }

        function GetQuarterSkillData() {

            showLoader();

            var response = AJAXCallWithResult(
                'api/RM_CapacityPlanning/GetCP_SkillWise_QuarterHeader',
                buildCpParams(),
                false
            );

            hideLoader();

            var rows = getResponseList(response);

            lastQuarterHeaderResponse = response;
            storeCpMonthHeaders(response);

            if (rows.length > 0) {

                BuildQuarterGridFromApi(rows);
                applyPagination(response, rows.length);

            } else {

                renderCapacityGridNoRecords();
            }
        }

        function applyPagination(response, rowCount) {
            var pageInfo = getPaginationInfo(response);
            var labelCol = currentType === 'Skill' ? cpResources.skillsLabel : cpResources.rolesLabel;
            var rows = getResponseList(response);
            var totalFromRow = getTotalRecordsFromRows(rows);

            if (pageInfo) {
                currentPage = pageInfo.currentPage || pageInfo.CurrentPage || currentPage;
                var pageSizeVal = pageInfo.pageSize || pageInfo.PageSize || pageSize;
                var totalRecords = pageInfo.totalRecords || pageInfo.TotalRecords || 0;
                if (totalRecords <= 0) {
                    totalRecords = totalFromRow || rowCount;
                }
                totalPages = pageInfo.totalPages || pageInfo.TotalPages || Math.max(1, Math.ceil(totalRecords / pageSizeVal));
                if (totalPages < 1) totalPages = 1;
                var start = totalRecords === 0 ? 0 : ((currentPage - 1) * pageSizeVal) + 1;
                var end = Math.min(currentPage * pageSizeVal, totalRecords);
                $('#btnCurrentPage').text(currentPage);
                $('#lblRecordCount').text(formatCpShowingToOf(start, end, totalRecords, labelCol));
                updatePaginationButtons();
            } else if (rowCount > 0 || totalFromRow > 0) {
                var totalRecords = totalFromRow || rowCount;
                currentPage = currentPage || 1;
                totalPages = Math.max(1, Math.ceil(totalRecords / pageSize));
                var start = totalRecords === 0 ? 0 : ((currentPage - 1) * pageSize) + 1;
                var end = Math.min(currentPage * pageSize, totalRecords);
                $('#btnCurrentPage').text(currentPage);
                $('#lblRecordCount').text(formatCpShowingToOf(start, end, totalRecords, labelCol));
                updatePaginationButtons();
            } else {
                $('#lblRecordCount').text(formatCpTotalRecords(0));
                updatePaginationButtons();
            }
        }

        function mapQuarterApiRow(row) {
            return {
                role: row.roleName || row.RoleName || row.roleDescription || row.RoleDescription || row.skillName || row.SkillName || row.description || row.Description || '',
                totalStrength: row.totalStrength || row.TotalStrength || 0,
                allocated: row.allocated || row.Allocated || 0,
                bench: row.bench || row.Bench || 0,
                requests: row.requests || row.Requests || 0,
                utilizationPct: row.utilizationPercentage || row.UtilizationPercentage || 0,
                q1: row.q1 || row.Q1 || row.quarter1 || row.Quarter1 || 0,
                q2: row.q2 || row.Q2 || row.quarter2 || row.Quarter2 || 0,
                q3: row.q3 || row.Q3 || row.quarter3 || row.Quarter3 || 0,
                q4: row.q4 || row.Q4 || row.quarter4 || row.Quarter4 || 0
            };
        }

        function renderMonthGrid(rows) {

            var $body = $('#tblCapacityBody');

            $body.empty();

            $.each(rows, function (i, r) {

                $body.append(
                    '<tr>' +
                    '<td>' + r.role + '</td>' +
                    '<td>' + formatCpCountDisplay(r.totalStrength) + '</td>' +
                    '<td>' + formatCpCountDisplay(r.allocated) + '</td>' +
                    '<td>' + formatCpCountDisplay(r.bench) + '</td>' +
                    '<td>' + formatCpCountDisplay(r.requests) + '</td>' +
                    '<td>' + r.utilizationPct + '%</td>' +
                    '<td>82%</td>' +
                    '<td>85%</td>' +
                    '<td>88%</td>' +
                    '<td>90%</td>' +
                    '<td>92%</td>' +
                    '<td>95%</td>' +
                    '</tr>'
                );
            });
        }
        /* ───────── Outer grid: month-grouped, paginated header (Jan <> / Feb <>) ───────── */

        var outerMonthsPerPage = 1;
        var outerMonthStartIdx = 0;
        var lastOuterGridContext = null; // { apiData, monthMap, monthOrder }
        var cpMonthViewDate = null;

        function getCpAllowedYear() {
            return new Date().getFullYear();
        }

        // Month view follows the financial year: April through next March.
        function getCpFinancialYearStart() {
            var today = new Date();
            return today.getFullYear() - (today.getMonth() < 3 ? 1 : 0);
        }

        function getCpFinancialYearRange() {
            var startYear = getCpFinancialYearStart();
            return {
                start: new Date(startYear, 3, 1),
                end: new Date(startYear + 1, 2, 1)
            };
        }

        function getCpMonthViewDate() {
            var financialYear = getCpFinancialYearRange();
            if (!cpMonthViewDate) {
                var today = new Date();
                cpMonthViewDate = new Date(today.getFullYear(), today.getMonth(), 1);
            }
            cpMonthViewDate.setDate(1);
            if (cpMonthViewDate < financialYear.start) cpMonthViewDate = new Date(financialYear.start);
            if (cpMonthViewDate > financialYear.end) cpMonthViewDate = new Date(financialYear.end);
            return new Date(cpMonthViewDate.getTime());
        }

        function resetCpMonthViewDate() {
            var today = new Date();
            cpMonthViewDate = new Date(today.getFullYear(), today.getMonth(), 1);
        }

        function canNavigateCpMonthWithinYear(deltaMonths) {
            var d = getCpMonthViewDate();
            var next = new Date(d.getFullYear(), d.getMonth() + deltaMonths, 1);
            var financialYear = getCpFinancialYearRange();
            return next >= financialYear.start && next <= financialYear.end;
        }

        function formatCpMonthYearLabel(monthName) {
            var year = getCpMonthViewDate().getFullYear();
            var idx = typeof parseMonthNameToIndex === 'function' ? parseMonthNameToIndex(monthName) : -1;
            if (idx >= 0 && CP_FULL_MONTH_NAMES[idx]) {
                return CP_FULL_MONTH_NAMES[idx] + ' ' + year;
            }
            var name = String(monthName || '').trim();
            return name ? (name + ' ' + year) : String(year);
        }

        function shiftCpMonthViewDate(deltaMonths) {
            if (!canNavigateCpMonthWithinYear(deltaMonths)) return false;
            var d = getCpMonthViewDate();
            d.setDate(1);
            d.setMonth(d.getMonth() + deltaMonths);
            cpMonthViewDate = d;
            return true;
        }

        function findExpandedMasterRow(ctx) {
            if (!ctx) return $();
            var $rows = $('tr.cp-master-row');
            if (ctx.roleId) {
                var $byRole = $rows.filter('[data-roleid="' + ctx.roleId + '"]');
                if ($byRole.length) return $byRole.first();
            }
            if (ctx.skillId) {
                var $bySkill = $rows.filter('[data-skillid="' + ctx.skillId + '"]');
                if ($bySkill.length) return $bySkill.first();
            }
            return $rows.filter('[data-key="' + ctx.key + '"]').first();
        }

        function reloadExpandedMonthDetail() {
            if (!expandedRowContext) return;
            var ctx = expandedRowContext;
            var $tr = findExpandedMasterRow(ctx);
            if (!$tr.length) return;
            expandedRowKey = ctx.key;
            $tr.find('.expand-icon').removeClass('fa-chevron-right').addClass('fa-chevron-down');
            LoadDetailGrid(ctx.roleId, ctx.skillId, $tr);
        }

        function navigateCpMonthView(deltaMonths) {
            if (currentView !== 'Month') return;
            if (!shiftCpMonthViewDate(deltaMonths)) return;
            var savedCtx = expandedRowContext;

            if (savedCtx) {
                $('.detail-row').remove();
                $('.expand-icon').removeClass('fa-chevron-down').addClass('fa-chevron-right');
                expandedRowKey = null;
                $('.cp-grid-container').removeClass('cp-has-detail');
            }

            if (currentType === 'Role') {
                GetMonthRoleData();
            } else {
                GetMonthSkillData();
            }

            if (savedCtx) {
                expandedRowContext = savedCtx;
                reloadExpandedMonthDetail();
            }
        }

        function findMonthOrderIndex(monthOrder, monthName) {
            var target = String(monthName || '').toLowerCase();
            if (!monthOrder || !monthOrder.length || !target) return -1;
            for (var i = 0; i < monthOrder.length; i++) {
                var m = String(monthOrder[i] || '').toLowerCase();
                if (m === target || m.indexOf(target) === 0 || target.indexOf(m) === 0) {
                    return i;
                }
            }
            return -1;
        }

        function getDefaultOuterMonthStartIdx(monthOrder) {
            if (!monthOrder || !monthOrder.length) return 0;
            var viewDate = (currentView === 'Month' ? getCpMonthViewDate() : new Date());
            var fullNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
            var shortNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var idx = findMonthOrderIndex(monthOrder, fullNames[viewDate.getMonth()]);
            if (idx < 0) idx = findMonthOrderIndex(monthOrder, shortNames[viewDate.getMonth()]);
            if (idx < 0) idx = 0;
            var maxStart = Math.max(0, monthOrder.length - outerMonthsPerPage);
            return Math.min(idx, maxStart);
        }

        function getAlignedDetailMonthStartIdx(monthOrder) {
            var monthsPerPage = outerMonthsPerPage || 1;
            if (!monthOrder || !monthOrder.length) return 0;
            var maxStart = Math.max(0, monthOrder.length - monthsPerPage);

            if (lastOuterGridContext && lastOuterGridContext.monthOrder && lastOuterGridContext.monthOrder.length) {
                var outerVisible = lastOuterGridContext.monthOrder.slice(
                    outerMonthStartIdx,
                    outerMonthStartIdx + outerMonthsPerPage
                );
                if (outerVisible.length) {
                    var idx = findMonthOrderIndex(monthOrder, outerVisible[0]);
                    if (idx >= 0) return Math.min(idx, maxStart);
                }
            }

            return Math.min(getDefaultOuterMonthStartIdx(monthOrder), maxStart);
        }

        function syncOpenDetailMonthsWithOuter() {
            if (!lastDetailContext || lastDetailContext.viewMode !== 'month') return;
            if (activeDetailTab !== 'overview') return;
            var $content = $('.detail-row .cp-detail-content').first();
            if (!$content.length) return;

            var startIdx = getAlignedDetailMonthStartIdx(lastDetailContext.monthOrder);
            var filteredData = filterDetailRows(lastDetailContext.data, activeDetailTab);
            var html = renderMonthWiseTable(
                filteredData,
                lastDetailContext.monthMap,
                lastDetailContext.monthOrder,
                startIdx,
                lastDetailContext.monthsPerPage
            );
            $content.attr('data-month-start', startIdx).html(html);
            syncDetailRowWidth();
            scheduleCpBootstrapTooltips($content);
        }

        function isCpHiddenWeekMetricColumn(key) {
            return /^__(TS|AL|BN|RQ|WTS|WAL|WBN)__/i.test(String(key || ''));
        }

        function rowHasWindowMetrics(row) {
            return Object.keys(row || {}).some(function (k) {
                return /^__(WTS|WAL|WBN)__/i.test(String(k || ''));
            });
        }

        function getVisiblePeriodMetrics(row, visibleMonths, visibleWeekColumns) {
            var firstMonth = (visibleMonths && visibleMonths.length) ? visibleMonths[0] : '';

            if (rowHasWindowMetrics(row) && firstMonth) {
                var wts = getCpWeekMetricValue(row, '__WTS__', firstMonth);
                var wal = getCpWeekMetricValue(row, '__WAL__', firstMonth);
                var wbn = getCpWeekMetricValue(row, '__WBN__', firstMonth);
                var wrq = 0;
                (visibleWeekColumns || []).forEach(function (col) {
                    wrq += getCpWeekMetricValue(row, '__RQ__', col);
                });
                var wutil = wts === 0 ? 0 : Math.round((wal * 10000) / wts) / 100;
                return {
                    totalStrength: Math.round(wts * 100) / 100,
                    allocated: Math.round(wal * 100) / 100,
                    bench: Math.round(wbn * 100) / 100,
                    requests: Math.round(wrq * 100) / 100,
                    utilization: wutil
                };
            }

            // Month header SP returns unique-per-role month counts (not week sums).
            var ts = parseFloat(row.TotalStrength || row.totalStrength || 0) || 0;
            var al = parseFloat(row.Allocated || row.allocated || 0) || 0;
            var bn = parseFloat(row.Bench || row.bench || 0) || 0;
            var rq = parseFloat(row.Requests || row.requests || 0) || 0;
            var util = parseFloat(row.UtilizationPercentage || row.utilizationPercentage || 0) || 0;
            return {
                totalStrength: Math.round(ts * 100) / 100,
                allocated: Math.round(al * 100) / 100,
                bench: Math.round(bn * 100) / 100,
                requests: Math.round(rq * 100) / 100,
                utilization: util
            };
        }

        function getCpRowValueCI(row, propName) {
            if (!row || propName === undefined || propName === null) return undefined;
            if (Object.prototype.hasOwnProperty.call(row, propName)) return row[propName];
            var want = String(propName).toLowerCase();
            var keys = Object.keys(row);
            for (var i = 0; i < keys.length; i++) {
                if (String(keys[i]).toLowerCase() === want) return row[keys[i]];
            }
            return undefined;
        }

        /*
         * Both Role and Skill MonthHeader SPs return the final utilization for
         * each week. That value is authoritative. Recalculating it from __AL__
         * (project-level Allocated) is incorrect and can produce 1450%/3800%.
         */
        function getWeekUtilizationPct(row, weekCol) {
            var raw = getCpRowValueCI(row, weekCol);
            if (raw !== null && raw !== undefined && raw !== '') {
                return formatQuarterPct(parseFloat(String(raw).replace('%', '').replace(/,/g, '')));
            }

            // Do not derive utilization from hidden Allocated/Strength values.
            // A missing SP field is intentionally rendered as No Data.
            return null;
        }

        function getCpWeekMetricValue(row, prefix, weekCol) {
            if (!row || !weekCol) return 0;
            var want = (prefix + weekCol).toLowerCase();
            var keys = Object.keys(row);
            for (var i = 0; i < keys.length; i++) {
                if (String(keys[i]).toLowerCase() === want) {
                    var num = parseFloat(row[keys[i]]);
                    return isNaN(num) ? 0 : num;
                }
            }
            return 0;
        }

        function rowHasWeekMetrics(row) {
            return Object.keys(row || {}).some(isCpHiddenWeekMetricColumn);
        }

        function sumVisibleMonthMetrics(row, visibleWeekColumns, visibleMonths) {
            return getVisiblePeriodMetrics(row, visibleMonths, visibleWeekColumns);
        }

        function cpGroupColumnsByMonth(weekColumns) {

            var monthOrder = [];
            var monthMap = {};

            weekColumns.forEach(function (col) {
                var match = col.match(/^([A-Za-z]+)/);
                var month = match ? match[1] : col;
                if (!monthMap[month]) {
                    monthMap[month] = [];
                    monthOrder.push(month);
                }
                monthMap[month].push(col);
            });

            // Display the monthly grid in fiscal sequence: Apr, May ... Mar.
            monthOrder.sort(function (a, b) {
                var aIndex = parseMonthNameToIndex(a);
                var bIndex = parseMonthNameToIndex(b);
                aIndex = aIndex < 3 ? aIndex + 12 : aIndex;
                bIndex = bIndex < 3 ? bIndex + 12 : bIndex;
                return aIndex - bIndex;
            });

            return { monthMap: monthMap, monthOrder: monthOrder };
        }

        function isCpActualCurrentMonth(monthName) {
            return parseMonthNameToIndex(monthName) === new Date().getMonth();
        }

        function getCpCurrentMonthViewClass(monthName) {
            return isCpActualCurrentMonth(monthName) ? ' cp-current-month-view' : '';
        }

        function getCpMonthFromWeekColumn(weekColumn) {
            var match = String(weekColumn || '').match(/^([A-Za-z]+)/);
            return match ? match[1] : '';
        }

        function BuildMonthGrid(apiData) {

            if (!apiData || apiData.length == 0)
                return;

            apiData = sortCpGridRowsByName(apiData);

            var fixedColumns = [
                'RoleName',
                'SkillName',
                'RoleDescription',
                'SkillDescription',
                'roleName',
                'skillName',
                'roleDescription',
                'skillDescription',
                'TotalStrength',
                'totalStrength',
                'Allocated',
                'allocated',
                'Bench',
                'bench',
                'Requests',
                'requests',
                'UtilizationPercentage',
                'utilizationPercentage',
                'RoleID',
                'roleID',
                'ToolID',
                'toolID'
            ];

            var weekColumns = [];

            Object.keys(apiData[0]).forEach(function (key) {

                if (fixedColumns.indexOf(key) === -1 && !isCpHiddenWeekMetricColumn(key)) {
                    weekColumns.push(key);
                }

            });

            var grouped = cpGroupColumnsByMonth(weekColumns);

            lastOuterGridContext = {
                apiData: apiData,
                monthMap: grouped.monthMap,
                monthOrder: grouped.monthOrder
            };

            outerMonthStartIdx = getDefaultOuterMonthStartIdx(grouped.monthOrder);

            renderOuterMonthGrid(outerMonthStartIdx);
        }

        function renderOuterMonthGrid(startIdx) {

            if (!lastOuterGridContext) return;

            var monthMap = lastOuterGridContext.monthMap;
            var monthOrder = lastOuterGridContext.monthOrder;
            var apiData = lastOuterGridContext.apiData;

            var maxStart = Math.max(0, monthOrder.length - outerMonthsPerPage);
            startIdx = Math.max(0, Math.min(startIdx, maxStart));
            outerMonthStartIdx = startIdx;

            var visibleMonths = monthOrder.slice(startIdx, startIdx + outerMonthsPerPage);

            var firstColumnHeader = getCapacityFirstColumnHeader();

            // Prev/next only within the financial year (Apr ↔ next Mar)
            var atStart = !canNavigateCpMonthWithinYear(-1);
            var atEnd = !canNavigateCpMonthWithinYear(1);

            /* Row 1: fixed columns (rowspan 2) + month group headers with prev/next arrows */
            var headerHtml = '<tr>';
            headerHtml += '<th rowspan="2">' + firstColumnHeader + '</th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.totalStrength + '</th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.allocated + '</th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.bench + '</th>';
            headerHtml += '<th rowspan="2" class="cp-col-center">' + cpResources.requests + '</th>';
            headerHtml += '<th rowspan="2" class="cp-util-col cp-text-center">' + cpResources.utilizationPercent + '</th>';

            visibleMonths.forEach(function (month, i) {
                var weeks = monthMap[month];
                var currentMonthClass = getCpCurrentMonthViewClass(month);
                var currentMonthLabel = currentMonthClass ? '<span class="cp-current-month-view-label">Current</span>' : '';
                var showPrev = (i === 0);
                var showNext = (i === visibleMonths.length - 1);
                var monthLabel = formatCpMonthYearLabel(month);

                var prevArrow = showPrev
                    ? '<span class="cp-month-nav-wrap"' + cpBsTooltipAttrs('Previous') + '>' +
                      '<button type="button" class="cp-month-nav-btn cp-outer-month-prev' + (atStart ? ' cp-month-arrow-disabled' : '') + '" aria-label="Previous"' + (atStart ? ' disabled' : '') + '><i class="fas fa-chevron-left"></i></button>' +
                      '</span>'
                    : '';
                var nextArrow = showNext
                    ? '<span class="cp-month-nav-wrap"' + cpBsTooltipAttrs('Next') + '>' +
                      '<button type="button" class="cp-month-nav-btn cp-outer-month-next' + (atEnd ? ' cp-month-arrow-disabled' : '') + '" aria-label="Next"' + (atEnd ? ' disabled' : '') + '><i class="fas fa-chevron-right"></i></button>' +
                      '</span>'
                    : '';

                headerHtml += '<th colspan="' + weeks.length + '" class="cp-quarter-head text-center' + currentMonthClass + '">' +
                    currentMonthLabel +
                    '<div class="cp-quarter-label">' + prevArrow + monthLabel + nextArrow + '</div>' +
                    '</th>';
            });
            headerHtml += '</tr>';

            /* Row 2: individual week sub-labels under each visible month */
            headerHtml += '<tr>';
            visibleMonths.forEach(function (month) {
                var monthShort = String(month || '').substring(0, 3);
                var currentMonthClass = getCpCurrentMonthViewClass(month);
                monthMap[month].forEach(function (col, weekIdx) {
                    var weekMatch = String(col).match(/Week\s*(\d+)/i);
                    var weekNum = weekMatch ? weekMatch[1] : String(weekIdx + 1);
                    var weekLabel = monthShort + ' Week ' + weekNum;
                    headerHtml += '<th class="cp-week-util-col text-center' + currentMonthClass + '">' +
                        '<div class="cp-week-header-label">' + weekLabel + '</div>' +
                        '<div class="cp-week-header-sub">UTIL %</div>' +
                        '</th>';
                });
            });
            headerHtml += '</tr>';

            $('#tblCapacityHead').html(headerHtml);
            $('#tblCapacity').addClass('cp-month-fit').removeClass('cp-quarter-table cp-quarter-expanded');
            $('.cp-grid-container').addClass('cp-month-view').removeClass('cp-quarter-view cp-quarter-expanded');

            var visibleWeekColumns = [];
            visibleMonths.forEach(function (month) {
                monthMap[month].forEach(function (col) {
                    visibleWeekColumns.push(col);
                });
            });

            var weekCount = Math.max(visibleWeekColumns.length, 1);
            var weekPct = (42 / weekCount).toFixed(2);
            var colGroupHtml = '';
            colGroupHtml += '<col style="width:16%;">';  // Role/Skill
            colGroupHtml += '<col style="width:7%;">';   // Total Strength
            colGroupHtml += '<col style="width:7%;">';   // Allocated
            colGroupHtml += '<col style="width:7%;">';   // Bench
            colGroupHtml += '<col style="width:7%;">';   // Requests
            colGroupHtml += '<col style="width:14%;">';  // Utilization %
            visibleWeekColumns.forEach(function () {
                colGroupHtml += '<col style="width:' + weekPct + '%;">';
            });
            $('#tblCapacityColGroup').html(colGroupHtml);

            RenderMonthRows(apiData, visibleWeekColumns, visibleMonths);
            syncOpenDetailMonthsWithOuter();
            scheduleCpBootstrapTooltips('#tblCapacity, .cp-grid-container');
        }

        $(document).on('click', '.cp-outer-month-prev', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if ($(this).hasClass('cp-month-arrow-disabled') || this.disabled) return;
            navigateCpMonthView(-outerMonthsPerPage);
        });

        $(document).on('click', '.cp-outer-month-next', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if ($(this).hasClass('cp-month-arrow-disabled') || this.disabled) return;
            navigateCpMonthView(outerMonthsPerPage);
        });

        function RenderMonthRows(rows, weekColumns, visibleMonths) {

            var html = '';

            $.each(rows, function (i, row) {

                var displayName = getGridDisplayName(row);
                var roleName = formatCpRoleName(displayName);

                html += '<tr class="cp-master-row" ' +
                    'data-key="' + displayName + '" ' +
                    'data-roleid="' + (row.RoleID || 0) + '" ' +
                    'data-skillid="' + (row.ToolID || 0) + '">';

                html += `
<td><span class="cp-role-cell"><i class="fas fa-chevron-right expand-icon"></i>${cpRoleNameHtml(roleName)}</span></td>`;

                var monthMetrics = getVisiblePeriodMetrics(row, visibleMonths, weekColumns);

                html += '<td class="cp-col-center">' + formatCpCountDisplay(monthMetrics.totalStrength) + '</td>';

                html += '<td class="cp-col-center">' + formatCpCountDisplay(monthMetrics.allocated) + '</td>';

                html += '<td class="cp-col-center"><span class="cp-bench-val">' + formatCpCountDisplay(monthMetrics.bench) + '</span></td>';

                html += '<td class="cp-col-center"><span class="cp-requests-val">' + formatCpCountDisplay(monthMetrics.requests) + '</span></td>';

                html += '<td class="cp-util-col">' +
                    cpUtilBarHtml(monthMetrics.utilization) +
                    '</td>';

                weekColumns.forEach(function (col) {
                    var currentMonthClass = getCpCurrentMonthViewClass(getCpMonthFromWeekColumn(col));
                    var pct = getWeekUtilizationPct(row, col);
                    pct = formatQuarterPct(pct);
                    if (pct === null || pct === undefined || isNaN(pct)) {
                        html += '<td class="cp-week-util-col cp-qcell-td cp-nodata' + currentMonthClass + '">—</td>';
                        return;
                    }
                    var cat = cpUtilCategory(pct);
                    html += '<td class="cp-week-util-col cp-qcell-td cp-' + cat + currentMonthClass + '" title="' + col + ': ' + pct + '%">' + pct + '%</td>';
                });

                html += '</tr>';

            });

            $('#tblCapacityBody').html(html);
            scheduleCpBootstrapTooltips('#tblCapacity, .cp-grid-container');
        }
        function LoadCapacityGrid() {
            expandedRowKey = null;
            expandedRowContext = null;
            lastDetailContext = null;
            $('.detail-row').remove();
            $('.expand-icon').removeClass('fa-chevron-down').addClass('fa-chevron-right');
            $('.cp-grid-container').removeClass('cp-has-detail');
            if (currentView !== 'Quarter') {
                syncQuarterTableLayout();
            }

            if (currentView == "Month" && currentType == "Role") {
                GetMonthRoleData();
            }
            else if (currentView == "Month" && currentType == "Skill") {
                GetMonthSkillData();
            }
            else if (currentView == "Quarter" && currentType == "Role") {
                GetQuarterRoleData();
            }
            else if (currentView == "Quarter" && currentType == "Skill") {
                GetQuarterSkillData();
            }
        }

        function GetMonthRoleData() {
            showLoader();
            var response = AJAXCallWithResult(
                'api/RM_CapacityPlanning/GetCP_RoleWise_MonthHeader',
                buildCpParams(),
                false
            );
            hideLoader();

            cpWeekHeaderList = getCpWeekHeaderList(response);
            var rows = getResponseList(response);
            if (rows.length > 0) {
                BuildMonthGrid(rows);
                applyPagination(response, rows.length);
            } else {
                renderCapacityGridNoRecords();
            }
        }

        function GetMonthSkillData() {
            showLoader();
            var response = AJAXCallWithResult(
                'api/RM_CapacityPlanning/GetCP_SkillWise_MonthHeader',
                buildCpParams(),
                false
            );
            hideLoader();

            cpWeekHeaderList = getCpWeekHeaderList(response);
            var rows = getResponseList(response);
            if (rows.length > 0) {
                BuildMonthGrid(rows);
                applyPagination(response, rows.length);
            } else {
                renderCapacityGridNoRecords();
            }
        }
        function updatePaginationButtons() {
            $('#btnPrev').prop('disabled', currentPage <= 1);
            $('#btnNext').prop('disabled', currentPage >= totalPages);
        }

        $('#btnPrev').off('click').on('click', function (e) {

            e.preventDefault();

            if (currentPage > 1) {

                currentPage--;

                LoadCapacityGrid();
            }
        });
        $('#btnNext').off('click').on('click', function (e) {

            e.preventDefault();

            if (currentPage < totalPages) {

                currentPage++;

                LoadCapacityGrid();
            }
        });
        function getNumberClass(value) {
            return 'cp-' + cpUtilCategory(parseFloat(String(value == null ? '' : value).replace('%', '')));
        }

        function getNumberCell(value) {

            return '<span class="cp-qcell ' +
                getNumberClass(value) +
                '">' +
                value +
                '</span>';
        }
        function getValueColor(value) {
            var cat = cpUtilCategory(parseFloat(String(value == null ? '' : value).replace('%', '').replace(/,/g, '').trim()));
            if (cat === 'healthy') return '#16a34a';
            if (cat === 'review') return '#dc2626';
            if (cat === 'critical') return '#ea580c';
            return '#64748b';
        }

        function getMetricDisplayColor(metricName, value) {
            if (!isUtilizationMetric(metricName)) return '';
            return getValueColor(value);
        }
        $(document).on('click', '.cp-master-row', function (e) {
            if ($(e.target).closest('.cp-week-cell, .cp-month-cell, .cp-quarter-cell, .cp-detail-nav-item, .cp-month-nav-prev, .cp-month-nav-next, .cp-detail-quarter-toggle').length) {
                return;
            }

            var tr = $(this);
            var key = tr.data('key');
            var roleId = parseInt(tr.data('roleid'), 10) || 0;
            var skillId = parseInt(tr.data('skillid'), 10) || 0;
            var displayName = tr.data('key');

            if (expandedRowKey === key) {
                $('.detail-row').remove();
                $('.expand-icon').removeClass('fa-chevron-down').addClass('fa-chevron-right');
                expandedRowKey = null;
                expandedRowContext = null;
                $('.cp-grid-container').removeClass('cp-has-detail');
                return;
            }

            $('.detail-row').remove();
            $('.expand-icon').removeClass('fa-chevron-down').addClass('fa-chevron-right');

            expandedRowKey = key;
            expandedRowContext = { key: key, roleId: roleId, skillId: skillId, displayName: displayName };
            activeDetailTab = 'overview';
            detailExpandedQuarters = { Q1: false, Q2: false, Q3: false, Q4: false };

            tr.find('.expand-icon').removeClass('fa-chevron-right').addClass('fa-chevron-down');
            LoadDetailGrid(roleId, skillId, tr);
        });

        function LoadDetailGrid(roleId, skillId, tr) {
            showLoader();
            var param = buildCpParams({
                SkillID: skillId || 0,
                RoleID: roleId || 0,
                PageNumber: 0,
                PageSize: 0
            });

            var apiName;
            if (currentView === 'Quarter') {
                apiName = currentType === 'Role'
                    ? 'api/RM_CapacityPlanning/GetCP_RoleWise_QtrDetails'
                    : 'api/RM_CapacityPlanning/GetCP_SkillWise_QuarterDetails';
            } else {
                apiName = currentType === 'Role'
                    ? 'api/RM_CapacityPlanning/GetCP_RoleWise_MonthDetails'
                    : 'api/RM_CapacityPlanning/GetCP_SkillWise_MonthDetails';
            }

            var response = AJAXCallWithResult(apiName, param, false);
            hideLoader();

            if (currentView === 'Month') {
                var detailWeekHeaders = getCpWeekHeaderList(response);
                if (detailWeekHeaders.length) {
                    cpWeekHeaderList = detailWeekHeaders;
                }
            }

            var rows = getResponseList(response);
            if (!rows.length && response) {
                rows = getResponseList(getResponseData(response));
            }
            if (!rows.length && currentView === 'Quarter') {
                rows = getSampleQuarterDetailData();
            }

            if (rows.length > 0) {
                ensureCpMonthHeaders();
                var detailHtml = currentView === 'Quarter'
                    ? BuildQuarterDetailSection(rows)
                    : BuildDetailSection(rows);
                tr.after(detailHtml);
                $('.cp-grid-container').addClass('cp-has-detail');
                syncDetailRowWidth();
                scheduleCpBootstrapTooltips('.detail-row');
            }
        }

        function getDetailTabFilter(tab) {
            var filters = {
                overview: null,
                allocated: ['allocated'],
                project: ['project request'],
                opportunity: ['opportunity'],
                bench: ['bench'],
                exits: ['anticipated', 'exit'],
                joining: ['joining']
            };
            return filters[tab] || null;
        }

        function isCpDetailUtilizationRow(row) {
            return isUtilizationMetric(row && (row.name || row.Name));
        }

        function filterDetailRows(data, tab) {
            var list = (data || []).filter(function (row) {
                // Inner overview grid: metrics only — no Utilization % row (shown on outer grid).
                return !isCpDetailUtilizationRow(row);
            });
            var tokens = getDetailTabFilter(tab);
            if (!tokens) return list;
            return list.filter(function (row) {
                var name = (row.name || row.Name || '').toLowerCase();
                return tokens.some(function (token) { return name.indexOf(token) > -1; });
            });
        }

        function BuildQuarterDetailSection(data) {
            var filteredData = filterDetailRows(data, activeDetailTab);
            var navItems = getDetailNavItems();

            var sidebarHtml = '<div class="cp-detail-sidebar">';
            navItems.forEach(function (item) {
                sidebarHtml += '<div class="cp-detail-nav-item' + (item.key === activeDetailTab ? ' active' : '') + '" data-tab="' + item.key + '" data-cp-full="' + cpEscAttr(item.label) + '">' +
                    '<i class="fas ' + item.icon + '"></i>' + item.label + '</div>';
            });
            sidebarHtml += '</div>';

            var contentHtml = renderQuarterDetailTable(filteredData);

            var html = '';
            html += '<tr class="detail-row">';
            html += '<td colspan="' + $('#tblCapacityHead th').length + '">';
            html += '<div class="cp-detail-sticky-inner"><div class="cp-detail-wrapper">';
            html += '<div class="cp-detail-flex">';
            html += sidebarHtml;
            html += '<div class="cp-detail-content cp-has-quarter-detail">' + contentHtml + '</div>';
            html += '</div></div></div>';
            html += '</td></tr>';

            lastDetailContext = {
                viewMode: 'quarter',
                data: data
            };

            return html;
        }

        function buildQuarterDetailColGroup() {
            var metricPct = 24;
            var quarterPct = (100 - metricPct) / 4;
            var monthPct = quarterPct / 3;
            var html = '<colgroup><col style="width:' + metricPct + '%">';
            QUARTER_DEFS.forEach(function (q) {
                if (detailExpandedQuarters[q.key]) {
                    html += '<col style="width:' + monthPct + '%"><col style="width:' + monthPct + '%"><col style="width:' + monthPct + '%">';
                } else {
                    html += '<col style="width:' + quarterPct + '%">';
                }
            });
            html += '</colgroup>';
            return html;
        }

        function renderQuarterDetailTable(data) {
            ensureCpMonthHeaders();
            var anyExpanded = QUARTER_DEFS.some(function (q) { return detailExpandedQuarters[q.key]; });
            var tableClass = 'cp-month-table cp-quarter-detail-table' +
                (anyExpanded ? ' cp-quarter-detail-expanded' : ' cp-quarter-detail-collapsed');
            var html = '<div class="cp-detail-content-title">' + cpResources.quarterWisePlanning +
                (anyExpanded ? cpResources.quarterWiseMonthLevel : '') + '</div>';
            html += '<div class="cp-quarter-detail-wrap">';
            html += '<table class="' + tableClass + '">';
            html += buildQuarterDetailColGroup();

            html += '<thead>';
            html += '<tr><th></th>';
            QUARTER_DEFS.forEach(function (q, qi) {
                var expanded = detailExpandedQuarters[q.key];
                var colspan = expanded ? 3 : 1;
                var icon = expanded ? 'fa-chevron-down' : 'fa-chevron-right';
                var currentQuarterClass = getCpCurrentQuarterCellClass(q, 0, 1);
                var currentQuarterLabel = currentQuarterClass ? '<span class="cp-current-quarter-label">Current</span>' : '';
                html += '<th colspan="' + colspan + '" class="cp-month-group-head cp-detail-q' + (qi + 1) + currentQuarterClass + '">' +
                    currentQuarterLabel +
                    '<button type="button" class="cp-detail-quarter-toggle" data-quarter="' + q.key + '">' +
                    '<i class="fas ' + icon + '"></i> ' + getQuarterGroupLabel(qi) +
                    '</button></th>';
            });
            html += '</tr>';

            if (anyExpanded) {
                html += '<tr><th></th>';
                QUARTER_DEFS.forEach(function (q, qi) {
                    if (detailExpandedQuarters[q.key]) {
                        var mi;
                        for (mi = 0; mi < 3; mi++) {
                            var currentQuarterClass = getCpCurrentQuarterCellClass(q, mi, 3);
                            html += '<th class="cp-detail-q' + (qi + 1) + currentQuarterClass + '">' + getQuarterMonthLabel(qi * 3 + mi) + '</th>';
                        }
                    } else {
                        html += '<th class="cp-detail-q' + (qi + 1) + ' cp-detail-quarter-placeholder"></th>';
                    }
                });
                html += '</tr>';
            }
            html += '</thead><tbody>';

            if (!data.length) {
                html += '<tr><td colspan="5" style="text-align:center;padding:20px;">' + cpResources.noDataForView + '</td></tr>';
            }

            data.forEach(function (row) {
                var metricName = row.name || row.Name || '';
                var displayMetricName = getCpDisplayMetricName(metricName);
                html += '<tr><td>' + displayMetricName + '</td>';

                QUARTER_DEFS.forEach(function (q, qi) {
                    if (detailExpandedQuarters[q.key]) {
                        var mi;
                        for (mi = 0; mi < 3; mi++) {
                            var globalMonthIdx = qi * 3 + mi;
                            var value = getQuarterDetailMonthValue(row, globalMonthIdx);
                            var monthLabel = getQuarterMonthLabel(globalMonthIdx);
                            var colKey = getQuarterDetailMonthKey(row, globalMonthIdx);
                            var monthDates = getQuarterMonthDatesByIndex(globalMonthIdx);
                            var currentQuarterClass = getCpCurrentQuarterCellClass(q, mi, 3);
                            var cellClass = (isUtilizationMetric(metricName) ? 'cp-util-metric-cell' : 'cp-month-cell') + currentQuarterClass;
                            var startAttr = (monthDates.start || '').toString().replace(/"/g, '&quot;');
                            var endAttr = (monthDates.end || '').toString().replace(/"/g, '&quot;');
                            var spanClass = isUtilizationMetric(metricName) ? '' : ' class="cp-metric-link"';
                            html += '<td class="' + cellClass + '" data-metric="' + metricName.replace(/"/g, '&quot;') + '" data-month-col="' + colKey.replace(/"/g, '&quot;') + '" data-month="' + monthLabel.replace(/"/g, '&quot;') + '" data-month-index="' + globalMonthIdx + '" data-value="' + value + '" data-start-date="' + startAttr + '" data-end-date="' + endAttr + '">' +
                                '<span' + spanClass + '>' + formatCpMetricCell(metricName, value) + '</span></td>';
                        }
                    } else {
                        var qValue = getQuarterDetailQuarterValue(row, qi, metricName);
                        var quarterDates = getQuarterDatesByQuarterIndex(qi);
                        var quarterLabel = getQuarterGroupLabel(qi);
                        var isUtilQ = isUtilizationMetric(metricName);
                        var currentQuarterClass = getCpCurrentQuarterCellClass(q, 0, 1);
                        var qCellClass = (isUtilQ ? 'cp-util-metric-cell' : 'cp-qdetail-quarter-cell cp-quarter-cell') + currentQuarterClass;
                        var qSpanClass = isUtilQ ? '' : ' class="cp-metric-link"';
                        var qStartAttr = String(quarterDates.start || '').replace(/"/g, '&quot;');
                        var qEndAttr = String(quarterDates.end || '').replace(/"/g, '&quot;');
                        html += '<td class="' + qCellClass + '" data-metric="' + metricName.replace(/"/g, '&quot;') + '" data-quarter="' + q.key + '" data-quarter-index="' + qi + '" data-quarter-label="' + quarterLabel.replace(/"/g, '&quot;') + '" data-value="' + qValue + '" data-start-date="' + qStartAttr + '" data-end-date="' + qEndAttr + '">' +
                            '<span' + qSpanClass + '>' + formatCpMetricCell(metricName, qValue) + '</span></td>';
                    }
                });
                html += '</tr>';
            });

            html += '</tbody></table></div>';
            return html;
        }

        function refreshQuarterDetailContent() {
            if (!lastDetailContext || lastDetailContext.viewMode !== 'quarter') return;
            var $content = $('.detail-row .cp-detail-content').first();
            if (!$content.length) return;
            var anyExpanded = QUARTER_DEFS.some(function (q) { return detailExpandedQuarters[q.key]; });
            $content.toggleClass('cp-has-quarter-detail', true);
            $content.closest('.cp-detail-flex').toggleClass('cp-quarter-detail-open', anyExpanded);
            if (activeDetailTab === 'overview') {
                var filteredData = filterDetailRows(lastDetailContext.data, activeDetailTab);
                $content.html(renderQuarterDetailTable(filteredData));
            }
            syncDetailRowWidth();
        }

        function BuildDetailSection(data) {
            var ignoreCols = ['RoleID', 'SkillID', 'ToolID', 'RoleDescription', 'Description', 'roleID', 'skillID', 'toolID'];
            var weekColumns = Object.keys(data[0]).filter(function (key) {
                return ignoreCols.indexOf(key) === -1 && key.toLowerCase() !== 'name';
            });

            var grouped = cpGroupColumnsByMonth(weekColumns);
            var monthOrder = grouped.monthOrder;
            var monthMap = grouped.monthMap;

            var monthsPerPage = outerMonthsPerPage || 1;
            var startIdx = getAlignedDetailMonthStartIdx(monthOrder);
            var filteredData = filterDetailRows(data, activeDetailTab);

            var navItems = getDetailNavItems();

            var sidebarHtml = '<div class="cp-detail-sidebar">';
            navItems.forEach(function (item) {
                sidebarHtml += '<div class="cp-detail-nav-item' + (item.key === activeDetailTab ? ' active' : '') + '" data-tab="' + item.key + '" data-cp-full="' + cpEscAttr(item.label) + '">' +
                    '<i class="fas ' + item.icon + '"></i>' + item.label + '</div>';
            });
            sidebarHtml += '</div>';

            var contentHtml = renderMonthWiseTable(filteredData, monthMap, monthOrder, startIdx, monthsPerPage);

            var html = '';
            html += '<tr class="detail-row">';
            html += '<td colspan="' + $('#tblCapacityHead th').length + '">';
            html += '<div class="cp-detail-sticky-inner"><div class="cp-detail-wrapper">';
            html += '<div class="cp-detail-flex">';
            html += sidebarHtml;
            html += '<div class="cp-detail-content" data-month-start="' + startIdx + '">' + contentHtml + '</div>';
            html += '</div></div></div>';
            html += '</td></tr>';

            lastDetailContext = {
                viewMode: 'month',
                data: data,
                monthMap: monthMap,
                monthOrder: monthOrder,
                monthsPerPage: monthsPerPage
            };

            return html;
        }

        function renderMonthWiseTable(data, monthMap, monthOrder, startIdx, monthsPerPage) {
            var visibleMonths = monthOrder.slice(startIdx, startIdx + monthsPerPage);
            var html = '<div class="cp-detail-content-title">' + cpResources.monthWisePlanning + '</div>';
            html += '<table class="cp-month-table">';

            html += '<thead><tr><th></th>';
            var atStart = !canNavigateCpMonthWithinYear(-1);
            var atEnd = !canNavigateCpMonthWithinYear(1);
            visibleMonths.forEach(function (month, i) {
                var weeks = monthMap[month];
                var currentMonthClass = getCpCurrentMonthViewClass(month);
                var currentMonthLabel = currentMonthClass ? '<span class="cp-current-month-view-label">Current</span>' : '';
                var showPrev = (i === 0);
                var showNext = (i === visibleMonths.length - 1);
                var monthLabel = formatCpMonthYearLabel(month);
                var prevArrow = showPrev
                    ? '<span class="cp-month-nav-wrap"' + cpBsTooltipAttrs('Previous') + '>' +
                      '<i class="fas fa-chevron-left cp-month-nav-prev' + (atStart ? ' cp-month-arrow-disabled' : '') + '" aria-label="Previous"></i>' +
                      '</span>'
                    : '';
                var nextArrow = showNext
                    ? '<span class="cp-month-nav-wrap"' + cpBsTooltipAttrs('Next') + '>' +
                      '<i class="fas fa-chevron-right cp-month-nav-next' + (atEnd ? ' cp-month-arrow-disabled' : '') + '" aria-label="Next"></i>' +
                      '</span>'
                    : '';
                html += '<th colspan="' + weeks.length + '" class="cp-month-group-head' + currentMonthClass + '">' +
                    currentMonthLabel +
                    '<div class="cp-month-nav-row">' + prevArrow +
                    '<span class="cp-month-nav-label">' + monthLabel + '</span>' +
                    nextArrow + '</div></th>';
            });
            html += '</tr><tr><th></th>';

            visibleMonths.forEach(function (month) {
                var currentMonthClass = getCpCurrentMonthViewClass(month);
                monthMap[month].forEach(function (col) {
                    var label = col;
                    if (col.indexOf('Week') > -1) {
                        label = col.substring(col.indexOf('Week'));
                    } else {
                        label = col.replace(month, '').replace(/^[^0-9]*/, 'Week ') || col;
                    }
                    html += '<th class="' + currentMonthClass.trim() + '">' + label + '</th>';
                });
            });
            html += '</tr></thead><tbody>';

            if (!data.length) {
                html += '<tr><td colspan="' + (visibleMonths.reduce(function (n, m) { return n + monthMap[m].length; }, 0) + 1) + '" style="text-align:center;padding:20px;">' + cpResources.noDataForView + '</td></tr>';
            }

            data.forEach(function (row) {
                var metricName = row.name || row.Name || '';
                var displayMetricName = getCpDisplayMetricName(metricName);
                html += '<tr><td>' + displayMetricName + '</td>';
                visibleMonths.forEach(function (month) {
                    var currentMonthClass = getCpCurrentMonthViewClass(month);
                    monthMap[month].forEach(function (col) {
                        var value = row[col];
                        if (value === null || value === undefined || value === '') value = 0;
                        var weekLabel = col.indexOf('Week') > -1 ? col.substring(col.indexOf('Week')) : col;
                        var weekDates = getWeekDatesFromHeaders(col, month) || {};
                        var isUtil = isUtilizationMetric(metricName);
                        var cellClass = (isUtil ? 'cp-util-metric-cell' : 'cp-week-cell') + currentMonthClass;
                        var spanClass = isUtil ? '' : ' class="cp-metric-link"';
                        html += '<td class="' + cellClass + '" data-metric="' + metricName.replace(/"/g, '&quot;') + '" data-week-col="' + col + '" data-month="' + month + '" data-week="' + weekLabel + '" data-value="' + value + '" data-start-date="' + (weekDates.start || '') + '" data-end-date="' + (weekDates.end || '') + '">' +
                            '<span' + spanClass + '>' + formatCpMetricCell(metricName, value) + '</span></td>';
                    });
                });
                html += '</tr>';
            });

            html += '</tbody></table>';
            return html;
        }

        function getDrawerApiForTab(tab) {
            var map = {
                allocated: 'api/RM_CapacityPlanning/GetCP_GetProjectAllocationByRole',
                project: 'api/RM_CapacityPlanning/GetCP_GetProjectRequestByRole',
                opportunity: 'api/RM_CapacityPlanning/GetCP_ApportunityRequestByRole',
                bench: 'api/RM_CapacityPlanning/GetCP_GetBenchByRole',
                exits: 'api/RM_CapacityPlanning/GetCP_AnticipatedExitByRole',
                joining: 'api/RM_CapacityPlanning/GetCP_JoiningPoolByRole'
            };
            return map[tab] || '';
        }

        function getDrawerApiForMetric(metricName, tab) {
            var name = (metricName || '').toLowerCase();
            if (name.indexOf('total strength') > -1 || name.indexOf('totalstrength') > -1) {
                return 'api/RM_CapacityPlanning/GetCP_GettotalstrengthbyRoleorskill';
            }
            if (tab === 'allocated' || name.indexOf('allocated') > -1) return 'api/RM_CapacityPlanning/GetCP_GetProjectAllocationByRole';
            if (tab === 'project' || name.indexOf('project request') > -1) return 'api/RM_CapacityPlanning/GetCP_GetProjectRequestByRole';
            if (tab === 'opportunity' || name.indexOf('opportunity') > -1) return 'api/RM_CapacityPlanning/GetCP_ApportunityRequestByRole';
            if (tab === 'bench' || name.indexOf('bench') > -1) return 'api/RM_CapacityPlanning/GetCP_GetBenchByRole';
            if (tab === 'exits' || name.indexOf('anticipated') > -1 || name.indexOf('exit') > -1) return 'api/RM_CapacityPlanning/GetCP_AnticipatedExitByRole';
            if (tab === 'joining' || name.indexOf('joining') > -1) return 'api/RM_CapacityPlanning/GetCP_JoiningPoolByRole';
            return 'api/RM_CapacityPlanning/GetCP_GetBenchByRole';
        }

        function getTabLabel(tab) {
            var labels = {
                overview: cpResources.overview,
                allocated: cpResources.allocatedToProject,
                project: cpResources.projectRequest,
                opportunity: cpResources.opportunityRequests,
                bench: cpResources.benchDetails,
                exits: cpResources.anticipatedExitsDetails,
                joining: cpResources.joiningPoolDetails
            };
            return labels[tab] || tab;
        }

        function getDetailListLabel() {
            return 'Records';
        }

        function setDetailListPaginationVisible(recordCountSel, visible) {
            $(recordCountSel).closest('.cp-pagination-footer').toggleClass('cp-pagination-hidden', !visible);
        }

        function resetDrawerListUi() {
            drawerCurrentPage = 1;
            drawerTotalPages = 1;
            $('#cpDrawerHead').empty();
            $('#cpDrawerBody').empty();
            $('#cpDrawerHead').closest('table').show();
            $('#cpDrawerRecordCount').text('');
            $('#btnDrawerCurrentPage').text('1');
            $('#btnDrawerPrev, #btnDrawerNext').prop('disabled', true);
            setDetailListPaginationVisible('#cpDrawerRecordCount', false);
        }

        function getDetailListTotalRecords(response, rowCount) {
            if (!rowCount) return 0;
            var pageInfo = getPaginationInfo(response);
            if (pageInfo) {
                return pageInfo.totalRecords || pageInfo.TotalRecords || rowCount;
            }
            return rowCount;
        }

        function toCpTitleCase(value) {
            // Assigned Task style: first letter capital, rest small (per word)
            return String(value == null ? '' : value)
                .split(/(\s+|—|–|•|\/|\(|\))/)
                .map(function (part) {
                    if (!part) return part;
                    if (/^\s+$/.test(part) || /^(—|–|•|\/|\(|\))$/.test(part)) return part;
                    if (/^\d+$/.test(part)) return part;
                    return part.charAt(0).toUpperCase() + part.slice(1).toLowerCase();
                })
                .join('');
        }

        function updateDrawerTitle(totalRecords) {
            if (!detailListContext || detailListContext.target !== 'drawer') return;
            var titleName = expandedRowContext ? (expandedRowContext.displayName || '') : '';
            var metricName = getCpDisplayMetricName(detailListContext.metricName || '');
            var fullTitle = toCpTitleCase(titleName + ' — ' + metricName + ' (' + totalRecords + ')');
            $('#cpDrawerTitle').attr('data-cp-full', fullTitle).text(fullTitle);
            scheduleCpBootstrapTooltips('#cpDrawerOverlay');
        }

        function applyDetailListPagination(response, rowCount, recordCountSel, currentPageSel, prevBtnSel, nextBtnSel) {
            if (rowCount === 0) {
                setDetailListPaginationVisible(recordCountSel, true);
                $(recordCountSel).text(formatCpTotalRecords(0));
                $(currentPageSel).text('1');
                $(prevBtnSel).prop('disabled', true);
                $(nextBtnSel).prop('disabled', true);
                drawerTotalPages = 1;
                return;
            }

            var pageInfo = getPaginationInfo(response);
            if (pageInfo) {
                drawerCurrentPage = pageInfo.currentPage || pageInfo.CurrentPage || drawerCurrentPage;
                drawerTotalPages = pageInfo.totalPages || pageInfo.TotalPages || 1;
                var totalRecords = pageInfo.totalRecords || pageInfo.TotalRecords || rowCount;
                var pageSizeVal = pageInfo.pageSize || pageInfo.PageSize || drawerPageSize;
                drawerPageSize = pageSizeVal;
                var start = ((drawerCurrentPage - 1) * pageSizeVal) + 1;
                var end = Math.min(drawerCurrentPage * pageSizeVal, totalRecords);
                $(currentPageSel).text(drawerCurrentPage);
                $(recordCountSel).text(formatCpShowingToOf(start, end, totalRecords, getDetailListLabel()));
                $(prevBtnSel).prop('disabled', drawerCurrentPage <= 1);
                $(nextBtnSel).prop('disabled', drawerCurrentPage >= drawerTotalPages);
                setDetailListPaginationVisible(recordCountSel, true);
            } else {
                $(recordCountSel).text(formatCpShowingRecords(rowCount));
                $(currentPageSel).text('1');
                $(prevBtnSel).prop('disabled', true);
                $(nextBtnSel).prop('disabled', true);
                setDetailListPaginationVisible(recordCountSel, true);
            }
        }

        function fetchDetailListResponse(context) {
            return AJAXCallWithResult(
                context.apiUrl,
                buildCPDetailsParams(context.startDate, context.endDate, {
                    weekOrMonth: context.weekOrMonth,
                    PageNumber: drawerCurrentPage,
                    PageSize: drawerPageSize
                }),
                false
            );
        }

        function extractCpDetailDataRows(source) {
            if (!source) return [];

            var envelope = Array.isArray(source) ? source : getResponseData(source);
            if (!envelope) return [];

            if (Array.isArray(envelope)) {
                return envelope;
            }
            if (Array.isArray(envelope.data)) return envelope.data;
            if (Array.isArray(envelope.Data)) return envelope.Data;
            if (envelope.data && Array.isArray(envelope.data.data)) return envelope.data.data;
            if (envelope.data && Array.isArray(envelope.data.Data)) return envelope.data.Data;

            return getResponseList(source);
        }

        function getDetailListRows(response) {
            var rows = extractCpDetailDataRows(response);
            if (!rows.length && response) {
                rows = extractCpDetailDataRows(getResponseData(response));
            }
            return rows.filter(function (row) {
                return row && !isCpPaginationEntity(row);
            });
        }

        function loadDrawerData() {
            if (!detailListContext || detailListContext.target !== 'drawer') return;

            showLoader();
            var response = fetchDetailListResponse(detailListContext);
            hideLoader();

            var rows = getDetailListRows(response);
            renderDrawerTable(rows, detailListContext.apiUrl);
            updateDrawerTitle(getDetailListTotalRecords(response, rows.length));
            applyDetailListPagination(response, rows.length, '#cpDrawerRecordCount', '#btnDrawerCurrentPage', '#btnDrawerPrev', '#btnDrawerNext');
        }

        function loadDetailTabList(tab, $content) {
            var apiUrl = getDrawerApiForTab(tab);
            if (!apiUrl || !expandedRowContext) return;

            drawerCurrentPage = 1;
            drawerTotalPages = 1;

            var monthRange = getVisibleDetailMonthRange();
            detailListContext = {
                target: 'tab',
                apiUrl: apiUrl,
                tab: tab,
                startDate: monthRange.start,
                endDate: monthRange.end,
                weekOrMonth: resolveCpDrawerWeekOrMonth(monthRange.start, monthRange.end, null),
                $content: $content
            };
            renderDetailTabListContent();
        }

        function renderDetailTabListContent() {
            if (!detailListContext || detailListContext.target !== 'tab' || !detailListContext.$content) return;

            var ctx = detailListContext;

            showLoader();
            var response = fetchDetailListResponse(ctx);
            hideLoader();

            var rows = getDetailListRows(response);
            var totalRecords = getDetailListTotalRecords(response, rows.length);
            var tableParts = buildListTableHtml(rows, ctx.apiUrl);
            var title = toCpTitleCase((expandedRowContext.displayName || '') + ' — ' + getTabLabel(ctx.tab) + ' (' + totalRecords + ')');
            var listHtml = '<div class="cp-detail-content-title" data-cp-full="' + cpEscAttr(title) + '">' + title + '</div>';
            listHtml += '<div class="cp-detail-list-wrap">';
            listHtml += '<table class="cp-detail-list-table"><thead>' + tableParts.head + '</thead><tbody>' + tableParts.body + '</tbody></table>';
            listHtml += '<div class="cp-pagination-footer cp-detail-tab-pagination" style="margin-top:8px;">';
            listHtml += '<span id="cpTabRecordCount">' + formatCpTotalRecords(0) + '</span>';
            listHtml += '<div class="cp-pagination-controls">';
            listHtml += '<span class="cp-month-nav-wrap"' + cpBsTooltipAttrs('Previous') + '><button type="button" class="btn-page-nav" id="btnTabPrev" aria-label="Previous">&laquo;</button></span>';
            listHtml += '<button type="button" class="btn-page-current" id="btnTabCurrentPage">1</button>';
            listHtml += '<span class="cp-month-nav-wrap"' + cpBsTooltipAttrs('Next') + '><button type="button" class="btn-page-nav" id="btnTabNext" aria-label="Next">&raquo;</button></span>';
            listHtml += '</div></div></div>';
            ctx.$content.html(listHtml);
            applyDetailListPagination(response, rows.length, '#cpTabRecordCount', '#btnTabCurrentPage', '#btnTabPrev', '#btnTabNext');
            scheduleCpBootstrapTooltips(ctx.$content);
        }

        var cpDrawerScrollY = 0;
        var cpDrawerScrollLocked = false;

        function lockCpDrawerScroll() {
            if (cpDrawerScrollLocked) return;
            cpDrawerScrollY = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
            cpDrawerScrollLocked = true;
            $('html').addClass('cp-drawer-open');
            $('body#CapacityPlanning').addClass('cp-drawer-open');
        }

        function unlockCpDrawerScroll() {
            if (!cpDrawerScrollLocked) return;
            cpDrawerScrollLocked = false;
            $('html').removeClass('cp-drawer-open');
            $('body#CapacityPlanning').removeClass('cp-drawer-open').css({
                top: '',
                paddingRight: '',
                position: '',
                left: '',
                right: '',
                width: ''
            });
            // Keep same scroll position — do not scrollTo (avoids jump on outside click)
        }

        function openDetailDrawer(metricName, month, weekLabel, weekCol, cellValue, startDate, endDate, isMonthLevel, monthIndex, quarterIndex) {
            if (!expandedRowContext) return;
            // Utilization % is calculated — no employee drawer / offcanvas.
            if (isUtilizationMetric(metricName)) return;

            lockCpDrawerScroll();
            resetDrawerListUi();

            var apiUrl = getDrawerApiForMetric(metricName, activeDetailTab);
            var weekOrMonth = false;
            var range;

            if (currentView === 'Quarter' || isMonthLevel === true) {
                if (quarterIndex !== undefined && quarterIndex !== null && quarterIndex !== '' && !isNaN(quarterIndex)) {
                    // Always resolve from fiscal quarter index (Jul–Sep for Q3), not cell attrs that may be stale/wrong.
                    range = getQuarterDatesByQuarterIndex(parseInt(quarterIndex, 10));
                } else {
                    var idx = (monthIndex !== undefined && monthIndex !== null && monthIndex !== '' && !isNaN(monthIndex))
                        ? parseInt(monthIndex, 10)
                        : undefined;
                    if (idx !== undefined) {
                        range = getQuarterMonthDatesByIndex(idx);
                    } else if (startDate && endDate) {
                        range = { start: startDate, end: endDate };
                    } else {
                        range = getQuarterMonthDatesByIndex(0);
                    }
                }
                weekOrMonth = resolveCpDrawerWeekOrMonth(range.start, range.end, quarterIndex);
            } else {
                // Month week click: exact dates from SP week headers only
                range = resolveWeekClickDateRange(weekCol, month, startDate, endDate);
                if (!range || !range.start || !range.end) {
                    // Last fallback so numbers stay clickable even if week headers missing
                    var monthIdx = parseMonthNameToIndex(month);
                    if (monthIdx >= 0) {
                        range = getMonthStartEndFromIndex(monthIdx, getYearForVisibleMonth(month) || getCpAllowedYear());
                        weekOrMonth = true;
                    } else {
                        unlockCpDrawerScroll();
                        return;
                    }
                }
            }

            drawerCurrentPage = 1;
            drawerTotalPages = 1;

            detailListContext = {
                target: 'drawer',
                apiUrl: apiUrl,
                metricName: metricName,
                month: month,
                weekLabel: weekLabel,
                cellValue: cellValue,
                startDate: range.start,
                endDate: range.end,
                weekOrMonth: weekOrMonth
            };

            var titleName = expandedRowContext.displayName || '';
            var displayMetricName = getCpDisplayMetricName(metricName);
            var fullTitle = toCpTitleCase(titleName + ' — ' + displayMetricName);
            $('#cpDrawerTitle').attr('data-cp-full', fullTitle).text(fullTitle);
            var subtitle = displayMetricName + ' • ' + (month || '');
            if (!weekOrMonth && weekLabel) {
                subtitle += ' • ' + weekLabel;
            }
            subtitle = toCpTitleCase(subtitle);
            $('#cpDrawerSubtitle').attr('data-cp-full', subtitle).text(subtitle);

            $('#cpDrawerOverlay').addClass('open');
            loadDrawerData();
            scheduleCpBootstrapTooltips('#cpDrawerOverlay');
        }

        function closeDetailDrawer() {
            $('#cpDrawerOverlay').removeClass('open');
            unlockCpDrawerScroll();
            if (detailListContext && detailListContext.target === 'drawer') {
                detailListContext = null;
            }
        }

        function formatCpDisplayDateFromParts(day, monthIndex, year) {
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var m = months[monthIndex];
            if (!m) return day + ' ' + year;
            return day + ' ' + m + ' ' + year;
        }

        function formatCpDisplayDate(value) {
            if (value === null || value === undefined || value === '') return '';

            if (typeof value === 'string') {
                var trimmed = value.trim();
                if (/^\d{1,2}\s+[A-Za-z]{3}\s+\d{4}$/.test(trimmed)) {
                    return trimmed;
                }
                var isoMatch = trimmed.match(/^(\d{4})-(\d{2})-(\d{2})(?:T|$|\s)/);
                if (isoMatch) {
                    return formatCpDisplayDateFromParts(
                        parseInt(isoMatch[3], 10),
                        parseInt(isoMatch[2], 10) - 1,
                        parseInt(isoMatch[1], 10)
                    );
                }
                var dmyMatch = trimmed.match(/^(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{4})/);
                if (dmyMatch) {
                    return formatCpDisplayDateFromParts(
                        parseInt(dmyMatch[1], 10),
                        parseInt(dmyMatch[2], 10) - 1,
                        parseInt(dmyMatch[3], 10)
                    );
                }
            }

            if (value instanceof Date && !isNaN(value.getTime())) {
                return formatCpDisplayDateFromParts(value.getDate(), value.getMonth(), value.getFullYear());
            }

            var parsed = new Date(value);
            if (!isNaN(parsed.getTime())) {
                return formatCpDisplayDateFromParts(parsed.getDate(), parsed.getMonth(), parsed.getFullYear());
            }

            return value;
        }

        function isCpDateColumnKey(key) {
            if (!key) return false;
            var lower = String(key).toLowerCase();
            if (lower.indexOf('date') > -1) return true;
            if (lower.indexOf('availablefrom') > -1) return true;
            return false;
        }

        function looksLikeIsoDate(value) {
            if (typeof value !== 'string') return false;
            return /^\d{4}-\d{2}-\d{2}(?:T|\s|$)/.test(value.trim());
        }

        function formatCpCellValue(key, value) {
            if (value === null || value === undefined) return '';
            if (looksLikeIsoDate(value) || (isCpDateColumnKey(key) && value !== '')) {
                return formatCpDisplayDate(value);
            }
            var str = String(value).trim();
            if (str.indexOf('%') > -1) {
                var pctNum = parseFloat(str.replace(/,/g, '').replace('%', '').trim());
                if (!isNaN(pctNum)) return formatCpNumberWithCommas(pctNum) + '%';
                return value;
            }
            if (isCpPlainNumericValue(value)) {
                return formatCpNumberWithCommas(value);
            }
            return value;
        }

        function normalizeCpColKey(value) {
            return String(value || '').toLowerCase().replace(/[\s_\-\/]/g, '');
        }

        function pickDetailColumnKeys(keys, aliasGroups) {
            var map = {};
            keys.forEach(function (k) {
                map[normalizeCpColKey(k)] = k;
            });
            var picked = [];
            aliasGroups.forEach(function (aliases) {
                var found = null;
                for (var i = 0; i < aliases.length; i++) {
                    found = map[normalizeCpColKey(aliases[i])];
                    if (found) break;
                }
                if (found && picked.indexOf(found) === -1) picked.push(found);
            });
            return picked.length ? picked : keys;
        }

        function getDetailListColumnHeader(key, apiUrl) {
            var n = normalizeCpColKey(key);
            var url = String(apiUrl || '').toLowerCase();
            if (url.indexOf('getprojectallocation') > -1) {
                if (n === 'resourcename' || n === 'employeename') return cpResources.resourceName || 'Resource Name';
                if (n === 'projectname') return cpResources.projectName || 'Project Name';
                if (n === 'projectrole') return cpResources.projectRole || 'Project Role';
                if (n === 'costperhour' || n === 'costhr' || n === 'cost') return 'Cost/Hr';
                if (n === 'rateperhour' || n === 'ratehr' || n === 'rate') return 'Rate/Hr';
            }
            if (url.indexOf('apportunity') > -1 || url.indexOf('opportunityrequest') > -1 || url.indexOf('getcp_apportunity') > -1) {
                if (n === 'opportunity' || n === 'opportunityname' || n === 'opportunityid' || n === 'prospect') return cpResources.opportunity || 'Opportunity';
                if (n === 'client' || n === 'clientname') return cpResources.client || 'Client';
                if (n === 'stage') return cpResources.stage || 'Stage';
                if (n === 'probability' || n === 'engagementprobability') return cpResources.probability || 'Probability';
                if (n === 'headcount' || n === 'noofresources') return cpResources.headcount || 'Headcount';
                if (n === 'requestsstartdate' || n === 'requeststartdate' || n === 'tentativestartdate') return cpResources.requestsStartDate || 'Requests Start Date';
            }
            return key;
        }

        function getDetailListColumnAliasGroups(apiUrl) {
            var url = String(apiUrl || '').toLowerCase();
            if (url.indexOf('getprojectallocation') > -1 || url.indexOf('getcp_getprojectallocation') > -1) {
                return [
                    ['Resource Name', 'ResourceName', 'EmployeeName', 'Employee Name'],
                    ['Project Name', 'ProjectName'],
                    ['Project Role', 'ProjectRole'],
                    ['Cost/Hr', 'CostPerHour', 'CostPerHr', 'Cost Per Hour'],
                    ['Rate/Hr', 'RatePerHour', 'RatePerHr', 'Rate Per Hour']
                ];
            }
            if (url.indexOf('getbenchbyrole') > -1 || url.indexOf('getcp_getbenchbyrole') > -1) {
                return [
                    ['Employee', 'EmployeeName'],
                    ['Experience'],
                    ['Primary Skill', 'PrimarySkill'],
                    ['Available From', 'AvailableFrom'],
                    ['Aging (in days)', 'AgingDays', 'Aging'],
                    ['Location'],
                    ['Status']
                ];
            }
            if (url.indexOf('joiningpool') > -1 || url.indexOf('getcp_joiningpool') > -1) {
                return [
                    ['Candidate', 'EmployeeName', 'Resource Name', 'ResourceName'],
                    ['Experience'],
                    ['Primary Skill', 'PrimarySkill'],
                    ['Offered Role', 'OfferedRole', 'Role'],
                    ['Joining Date', 'JoiningDate']
                ];
            }
            if (url.indexOf('getprojectrequest') > -1 || url.indexOf('getcp_getprojectrequest') > -1) {
                return [
                    ['Request ID'],
                    ['Project'],
                    ['Business Group'],
                    ['Required From'],
                    ['Headcount'],
                    ['Status']
                ];
            }
            if (url.indexOf('apportunity') > -1 || url.indexOf('opportunityrequest') > -1 || url.indexOf('getcp_apportunity') > -1) {
                return [
                    ['Opportunity', 'OpportunityName', 'OpportunityID', 'Prospect'],
                    ['Client', 'ClientName'],
                    ['Stage'],
                    ['Probability', 'EngagementProbability'],
                    ['Headcount', 'NoOfResources'],
                    ['Requests Start Date', 'RequestStartDate', 'RequestsStartDate', 'TentativeStartDate']
                ];
            }
            if (url.indexOf('totalstrength') > -1 || url.indexOf('getcp_gettotalstrength') > -1) {
                return [
                    ['Employee', 'EmployeeName'],
                    ['Experience'],
                    ['Primary Skill', 'PrimarySkill'],
                    ['Status'],
                    ['Location']
                ];
            }
            if (url.indexOf('anticipatedexit') > -1 || url.indexOf('getcp_anticipatedexit') > -1) {
                return [
                    ['Employee', 'EmployeeName'],
                    ['Experience'],
                    ['Primary Skill', 'PrimarySkill'],
                    ['Current Project', 'CurrentProject'],
                    ['Exit Date', 'ExitDate'],
                    ['Reason'],
                    ['Location']
                ];
            }
            return null;
        }

        function getDetailListColumnKeys(rows, apiUrl) {
            var keys = Object.keys(rows[0] || {});
            var aliasGroups = getDetailListColumnAliasGroups(apiUrl);

            // 0 records: still show expected column headers for this drawer
            if (!keys.length) {
                if (aliasGroups && aliasGroups.length) {
                    return aliasGroups.map(function (aliases) { return aliases[0]; });
                }
                return [];
            }

            if (aliasGroups && aliasGroups.length) {
                return pickDetailColumnKeys(keys, aliasGroups);
            }
            return keys;
        }

        function buildListTableHtml(rows, apiUrl) {
            var keys = getDetailListColumnKeys(rows, apiUrl);
            var emptyMsg = cpResources.noRecordsFound || 'No records found for this selection.';

            if (!keys.length) {
                return {
                    head: '',
                    body: '<tr class="cp-empty-row"><td class="cp-text-center" colspan="1"><span class="cp-empty-message">' + emptyMsg + '</span></td></tr>'
                };
            }

            var head = '<tr>' + keys.map(function (k) {
                var headerText = getDetailListColumnHeader(k, apiUrl);
                return '<th data-cp-full="' + cpEscAttr(headerText) + '"><span class="cp-cell-ellipsis" data-cp-full="' + cpEscAttr(headerText) + '">' + headerText + '</span></th>';
            }).join('') + '</tr>';

            if (!rows.length) {
                return {
                    head: head,
                    body: '<tr class="cp-empty-row"><td class="cp-text-center" colspan="' + keys.length + '"><span class="cp-empty-message">' + emptyMsg + '</span></td></tr>'
                };
            }

            var body = '';
            rows.forEach(function (row) {
                body += '<tr>' + keys.map(function (k) {
                    var cellText = formatCpCellValue(k, row[k]);
                    var fullText = cellText == null ? '' : String(cellText);
                    return '<td><span class="cp-cell-ellipsis" data-cp-full="' + cpEscAttr(fullText) + '">' + fullText + '</span></td>';
                }).join('') + '</tr>';
            });

            return { head: head, body: body };
        }

        function renderDrawerTable(rows, apiUrl) {
            var tableParts = buildListTableHtml(rows, apiUrl);
            $('#cpDrawerHead').closest('table').show();
            $('#cpDrawerHead').html(tableParts.head);
            $('#cpDrawerBody').html(tableParts.body);
            scheduleCpBootstrapTooltips('#cpDrawerOverlay');
        }

        function formatDate(value) {
            if (!value) return '';

            if (typeof value === 'string') {
                return value;
            }
            var d = new Date(value);
            return d.getFullYear() + '-' +
                String(d.getMonth() + 1).padStart(2, '0') + '-' +
                String(d.getDate()).padStart(2, '0') +
                'T00:00:00';
        }

        $(document).on('click', '.cp-week-cell', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var $cell = $(e.target).closest('.cp-week-cell');
            if (!$cell.length) return;
            openDetailDrawer(
                $cell.attr('data-metric') || $cell.data('metric'),
                $cell.attr('data-month') || $cell.data('month'),
                $cell.attr('data-week') || $cell.data('week'),
                $cell.attr('data-week-col') || $cell.data('weekCol'),
                $cell.attr('data-value') || $cell.data('value'),
                $cell.attr('data-start-date'),
                $cell.attr('data-end-date')
            );
        });

        $(document).on('click', '.cp-month-cell', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var $cell = $(e.target).closest('.cp-month-cell');
            if (!$cell.length) return;
            openDetailDrawer(
                $cell.data('metric'),
                $cell.data('month'),
                '',
                $cell.data('monthCol'),
                $cell.data('value'),
                $cell.attr('data-start-date'),
                $cell.attr('data-end-date'),
                true,
                $cell.attr('data-month-index')
            );
        });

        $(document).on('click', '.cp-quarter-cell', function (e) {
            e.preventDefault();
            e.stopPropagation();
            var $cell = $(e.target).closest('.cp-quarter-cell');
            if (!$cell.length) return;
            openDetailDrawer(
                $cell.data('metric'),
                $cell.data('quarterLabel') || $cell.data('quarter'),
                '',
                '',
                $cell.data('value'),
                $cell.attr('data-start-date'),
                $cell.attr('data-end-date'),
                true,
                null,
                $cell.attr('data-quarter-index')
            );
        });

        $(document).on('click', '.cp-detail-quarter-toggle', function (e) {
            e.stopPropagation();
            if (!lastDetailContext || lastDetailContext.viewMode !== 'quarter') return;
            var q = $(this).data('quarter');
            detailExpandedQuarters[q] = !detailExpandedQuarters[q];
            refreshQuarterDetailContent();
        });

        $(document).on('click', '.cp-month-nav-prev, .cp-month-nav-next', function (e) {
            e.stopPropagation();
            if (!lastDetailContext || activeDetailTab !== 'overview' || lastDetailContext.viewMode === 'quarter') return;
            if ($(this).hasClass('cp-month-arrow-disabled')) return;
            var delta = $(this).hasClass('cp-month-nav-next') ? 1 : -1;
            navigateCpMonthView(delta);
        });

        function getExportReportTab() {
            if (currentView === 'Month' && currentType === 'Role') return 'MonthWiseRole';
            if (currentView === 'Month' && currentType === 'Skill') return 'MonthWiseSkill';
            if (currentView === 'Quarter' && currentType === 'Role') return 'QtrWiseRole';
            if (currentView === 'Quarter' && currentType === 'Skill') return 'QtrWiseSkill';
            return 'MonthWiseRole';
        }

        function downloadCpReport(format) {
            var normalized = (format || '').toString().toUpperCase();
            if (normalized === 'XLS' || normalized === 'XLSX') {
                normalized = 'EXCEL';
            }
      
            if (normalized === 'PDF' || normalized === 'EXCEL') {
                downloadCpExport(normalized);
                return;
            }
            if (typeof alertify !== 'undefined') {
                alertify.error(cpResources.invalidExportFormat);
            }
        }

        function saveBlobFile(blob, fileName) {
            if (window.navigator && typeof window.navigator.msSaveOrOpenBlob === 'function') {
                window.navigator.msSaveOrOpenBlob(blob, fileName);
                return;
            }
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = fileName;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            window.URL.revokeObjectURL(link.href);
        }

        function downloadCpExport(format) {
            var filters = getCpSqlFilterParams(true);
            var fullUrl = strUrl.endsWith('/') ? strUrl + 'api/RM_CapacityPlanning/DownloadCpExport' : strUrl + '/api/RM_CapacityPlanning/DownloadCpExport';
            var excelFormats = ['EXCEL', 'XLSX', 'XLS'];
            var tryFormats = format === 'EXCEL' ? excelFormats : [format];
            var tryIndex = 0;

            function attemptDownload() {
                var formatToUse = tryFormats[tryIndex];
                var param = JSON.stringify({
                    BGOUType: filters.bgouType || '',
                    BGOUFilter: filters.bgouFilter || '',
                    SkillList: filters.skillList || '',
                    RoleList: filters.roleList || '',
                    RoleNames: getSelectedCheckboxTexts('#ddRoleSkillPanel').join('\n'),
                    ReportTab: getExportReportTab(),
                    ReportFormat: formatToUse,
                    CurrentDate: toCpApiDate(currentView === 'Month' ? getCpMonthViewDate() : new Date())
                });

                showLoader();
                $.ajax({
                    url: fullUrl,
                    type: 'POST',
                    data: param,
                    contentType: 'application/json;charset=utf-8',
                    xhrFields: { responseType: 'blob' },
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem('access_token_W27_Dashboard'));
                        if (param) {
                            xhr.setRequestHeader('Params', encryptString(typeof isJson === 'function' && isJson(param) ? param : param));
                        }
                    },
                    success: function (blob, status, xhr) {
                        if (!blob || blob.size === 0) {
                            if (format === 'EXCEL' && tryIndex < tryFormats.length - 1) {
                                tryIndex++;
                                attemptDownload();
                                return;
                            }
                            hideLoader();
                            if (typeof alertify !== 'undefined') {
                                alertify.error(cpResources.recordsNotAvailable);
                            }
                            return;
                        }

                        var ext = format === 'PDF' ? 'pdf' : 'xlsx';
                        var fileName = 'CapacityPlanning.' + ext;
                        var disposition = xhr.getResponseHeader('Content-Disposition');
                        if (disposition) {
                            var match = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/i.exec(disposition);
                            if (match && match[1]) {
                                fileName = match[1].replace(/['"]/g, '');
                            }
                        }
                        hideLoader();
                        saveBlobFile(blob, fileName);
                    },
                    error: function () {
                        if (format === 'EXCEL' && tryIndex < tryFormats.length - 1) {
                            tryIndex++;
                            attemptDownload();
                            return;
                        }
                        hideLoader();
                        if (typeof alertify !== 'undefined') {
                            alertify.error(cpResources.unableToDownloadReport);
                        }
                    }
                });
            }

            attemptDownload();
        }

        $(document).on('click', '.cp-detail-nav-item', function (e) {
            e.stopPropagation();
            if (!lastDetailContext) return;

            $(this).siblings().removeClass('active');
            $(this).addClass('active');
            activeDetailTab = $(this).data('tab');

            var $content = $(this).closest('.cp-detail-flex').find('.cp-detail-content');
            var startIdx = parseInt($content.attr('data-month-start'), 10) || 0;

            if (activeDetailTab === 'overview') {
                if (lastDetailContext.viewMode === 'quarter') {
                    var quarterFiltered = filterDetailRows(lastDetailContext.data, activeDetailTab);
                    $content.html(renderQuarterDetailTable(quarterFiltered));
                } else {
                    var filteredData = filterDetailRows(lastDetailContext.data, activeDetailTab);
                    $content.html(renderMonthWiseTable(
                        filteredData,
                        lastDetailContext.monthMap,
                        lastDetailContext.monthOrder,
                        startIdx,
                        lastDetailContext.monthsPerPage
                    ));
                    scheduleCpBootstrapTooltips($content);
                }
            } else {
                loadDetailTabList(activeDetailTab, $content);
            }
            syncDetailRowWidth();
        });

        function formatDateForSP(dateValue) {

            if (!dateValue) return '';

            var d = new Date(dateValue);

            var dd = ('0' + d.getDate()).slice(-2);
            var mm = ('0' + (d.getMonth() + 1)).slice(-2);
            var yyyy = d.getFullYear();

            var hh = ('0' + d.getHours()).slice(-2);
            var mi = ('0' + d.getMinutes()).slice(-2);
            var ss = ('0' + d.getSeconds()).slice(-2);

            return dd + '-' + mm + '-' + yyyy + ' ' + hh + ':' + mi + ':' + ss;
        }

    </script>
</body>
</html>
