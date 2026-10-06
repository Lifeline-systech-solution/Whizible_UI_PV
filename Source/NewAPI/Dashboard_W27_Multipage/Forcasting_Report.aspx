<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Forcasting_Report.aspx.vb" Inherits="Whizible.Forcasting_Report" %>

<!DOCTYPE html>

<html>
<head runat="server">
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Whizible - Forecasting Report</title>
<meta name="description" content="Weekly and monthly resource forecasting dashboard with role filtering and search.">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.min.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/v4-shims.min.css">
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="css/cxo-pva.css">
<style>
  :root {
    --navy: #1e40af;
    --line: #e3e8ef;
    --text: #1a2536;
    --text-dim: #6b7280;
  }
  body.analytics-pva {
    margin: 0;
    background: #fff;
    color: var(--text);
    font-family: 'Roboto', sans-serif !important;
    font-size: 11.5px !important;
    line-height: 1.5;
  }
  body.analytics-pva button,
  body.analytics-pva input,
  body.analytics-pva select,
  body.analytics-pva textarea {
    font-family: 'Roboto', sans-serif !important;
    font-size: 11.5px;
  }
  .bgwhite { font-size: 11.5px !important; font-family: 'Roboto', sans-serif; }
  .page-header-section { margin-bottom: 0 !important; background: #fff; }
  .page-wrap { max-width: 100%; margin: 0; padding: 0.5rem 1rem 1rem; }
  .header-actions {
    display: flex;
    gap: 8px;
    flex-shrink: 0;
    justify-content: flex-end;
    margin: 0.5rem 1rem 0;
  }
  .btn-export {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 10px;
    background: #fff;
    border: 1px solid #1359a6;
    border-radius: 4px;
    color: #1359a6;
    font-size: 11.5px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.15s, color 0.15s;
  }
  .btn-export:hover { background: #1359a6; color: #fff; border-color: #1359a6; }
  .btn-export i { color: inherit; font-size: 12px; }
  /* =========================================
     SearchSelect Dropdown Component Styles 
  ========================================= */
  .ss-host { position: relative; display: block; width: 100%; }
  
  /* The Trigger Button */
  .ss-btn {
    width: 100%; display: flex; justify-content: space-between; align-items: center;
    background: #fff; border: 1px solid #d1d5db; border-radius: 6px;
    padding: 7px 12px; min-height: 34px; font-size: 11.5px; color: #374151;
    text-align: left; cursor: pointer;
  }
  .ss-btn:hover { border-color: #9ca3af; }
  .ss-btn-label { flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
  .ss-chev { color: #9ca3af; font-size: 10px; margin-left: 8px; }

  /* The Floating Panel */
  .ss-panel.ss-floating {
    background: #fff; border: 1px solid #e5e7eb; border-radius: 8px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    display: flex; flex-direction: column; overflow: hidden;
    font-size: 11.5px; color: #374151; z-index: 9999 !important;
  }

  /* Search Input inside Dropdown */
  .ss-search {
    margin: 8px; padding: 6px 10px; border: 1px solid #d1d5db;
    border-radius: 4px; outline: none; width: calc(100% - 16px);
    box-sizing: border-box; font-size: 11.5px;
  }
  .ss-search:focus { border-color: #1359a6; }

  /* Dropdown Rows */
  .ss-rows {
    max-height: 200px; overflow-y: auto; padding-bottom: 4px;
  }
  .ss-row {
    padding: 7px 12px; cursor: pointer; white-space: nowrap;
    overflow: hidden; text-overflow: ellipsis;
  }
  .ss-row:hover { background: #f3f4f6; color: #1e40af; }
  .ss-row.selected { background: #eef2ff; color: #1e40af; font-weight: 600; }
  .ss-empty { padding: 8px 12px; color: #6b7280; font-style: italic; }

  /* Footer Action Buttons (Clear / Close) */
  .ss-actions {
    display: flex; border-top: 1px solid #e5e7eb; background: #f9fafb;
  }
  .ss-actions button {
    flex: 1; background: none; border: none; padding: 8px;
    font-size: 11px; font-weight: 600; color: #4b5563; cursor: pointer;
    border-right: 1px solid #e5e7eb;
  }
  .ss-actions button:last-child { border-right: none; }
  .ss-actions button:hover { background: #e5e7eb; color: #111827; }
  /* KPI row — SS pastel cards */
  body.analytics-pva .fc-kpi-grid {
    display: grid;
    grid-template-columns: repeat(4, minmax(0, 1fr));
    gap: 12px;
    margin-bottom: 12px;
  }
  @media (max-width: 992px) {
    body.analytics-pva .fc-kpi-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  }
  @media (max-width: 520px) {
    body.analytics-pva .fc-kpi-grid { grid-template-columns: 1fr; }
  }
  .fc-kpi-card {
    display: flex;
    align-items: center;
    gap: 10px;
    border-radius: 8px;
    padding: 10px 12px;
    border: 1px solid transparent;
    min-width: 0;
    min-height: 0;
  }
  .fc-kpi-icon {
    width: 32px;
    height: 32px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    flex-shrink: 0;
    margin-bottom: 0;
  }
  .fc-kpi-body {
    min-width: 0;
    flex: 1;
  }
  .fc-kpi-label {
    font-size: 10px;
    font-weight: 600;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    margin-bottom: 2px;
    line-height: 1.2;
  }
  .fc-kpi-val {
    font-size: 18px;
    font-weight: 700;
    line-height: 1.15;
    letter-spacing: -0.02em;
  }
  .fc-kpi-sub {
    font-size: 10px;
    color: #6b7280;
    margin-top: 2px;
    line-height: 1.2;
  }
  .fc-kpi-blue {
    background: #eef4ff;
    border-color: #dbeafe;
  }
  .fc-kpi-blue .fc-kpi-icon { background: #dbeafe; color: #2563eb; }
  .fc-kpi-blue .fc-kpi-label,
  .fc-kpi-blue .fc-kpi-val { color: #2563eb; }
  .fc-kpi-purple {
    background: #f5f0ff;
    border-color: #e9d5ff;
  }
  .fc-kpi-purple .fc-kpi-icon { background: #ede9fe; color: #7c3aed; }
  .fc-kpi-purple .fc-kpi-label,
  .fc-kpi-purple .fc-kpi-val { color: #7c3aed; }
  .fc-kpi-orange {
    background: #fff7ed;
    border-color: #fed7aa;
  }
  .fc-kpi-orange .fc-kpi-icon { background: #ffedd5; color: #ea580c; }
  .fc-kpi-orange .fc-kpi-label,
  .fc-kpi-orange .fc-kpi-val { color: #ea580c; }
  .fc-kpi-green {
    background: #ecfdf5;
    border-color: #bbf7d0;
  }
  .fc-kpi-green .fc-kpi-icon { background: #d1fae5; color: #059669; }
  .fc-kpi-green .fc-kpi-label,
  .fc-kpi-green .fc-kpi-val { color: #059669; }

  /* Filter panel — SS white bar */
  body.analytics-pva .fc-filter-panel.widget {
    margin-bottom: 12px;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    box-shadow: none;
    background: #fff;
  }
  body.analytics-pva .fc-filter-panel .w-body { padding: 14px 16px 10px; overflow: visible; }
  .fc-filter-rows {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }
  .fc-filter-row {
    display: grid;
    gap: 12px;
    align-items: end;
  }
  .fc-filter-row-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
  .fc-filter-row-2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  @media (max-width: 768px) {
    .fc-filter-row-3,
    .fc-filter-row-2 { grid-template-columns: 1fr; }
  }
  .fc-search-wrap {
    position: relative;
  }
  .fc-search-wrap i {
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: #9ca3af;
    font-size: 12px;
    pointer-events: none;
  }
  .fc-search-wrap input {
    width: 100%;
    padding-left: 30px !important;
    box-sizing: border-box;
  }
  .fc-filter-actions-row {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
    margin-top: 2px;
  }
  .fc-filter-actions-row .fc-btn-clear,
  .fc-filter-actions-row .fc-btn-show {
    min-width: 88px;
  }
  .fc-btn-clear {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    background: #fff;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    color: #374151;
    font-size: 11.5px;
    font-weight: 500;
    padding: 7px 12px;
    cursor: pointer;
    min-height: 34px;
  }
  .fc-btn-clear:hover { border-color: #9ca3af; background: #f9fafb; }
  .fc-btn-show {
    background: #1359a6;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 11.5px;
    font-weight: 600;
    padding: 7px 12px;
    cursor: pointer;
    min-height: 34px;
  }
  .fc-btn-show:hover { background: #0f4a8a; }
  .fc-filter-legend {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 14px;
    margin-top: 10px;
    padding-top: 8px;
    flex-wrap: wrap;
  }
  .fc-filter-legend .fc-leg-item {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 11.5px;
    color: #4b5563;
    font-weight: 500;
  }
  .fc-filter-legend .fc-leg-dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    display: inline-block;
    border: 1px solid rgba(0,0,0,0.06);
  }
  .fc-filter-legend .fc-leg-dot.idle { background: #f5f6f8; }
  .fc-filter-legend .fc-leg-dot.low  { background: #e6f7f2; }
  .fc-filter-legend .fc-leg-dot.mid  { background: #fff3e0; }
  .fc-filter-legend .fc-leg-dot.high { background: #ffe8ec; }

  .main-section {
    margin: 0;
    background: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 10px;
    overflow: hidden;
  }
  .main-section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    flex-wrap: wrap;
    padding: 0.65rem 1rem;
    background: #F8FAFC;
    border-bottom: 1px solid #e5e7eb;
  }
  .main-section-header h3 {
    margin: 0;
    color: #1e40af;
    font-size: 13px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 0.5rem;
  }
  .main-section-body { padding: 1rem; }
  .fc-header-tools {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
    margin-left: auto;
  }
  .fc-period-meta { font-size: 11.5px; color: #6b7280; white-space: nowrap; }
  .level-tabs {
    display: flex;
    gap: 6px;
    background: #f1f4f8;
    padding: 4px;
    border-radius: 8px;
  }
  .level-tabs button {
    border: none;
    background: none;
    padding: 6px 12px;
    border-radius: 6px;
    font-size: 11.5px;
    font-weight: 600;
    color: var(--text-dim);
    cursor: pointer;
  }
  .level-tabs button.active {
    background: #fff;
    color: #1e40af;
    box-shadow: 0 1px 3px rgba(20, 30, 50, 0.12);
  }
  .borderbtn {
    background: #fff;
    border: 1px solid #1359a6;
    color: #1359a6;
    font-weight: 500;
    font-size: 11.5px !important;
    padding: 4px 10px;
    border-radius: 4px;
    cursor: pointer;
  }
  .borderbtn:hover:not(:disabled) {
    background: #1359a6 !important;
    color: #fff !important;
  }
  .borderbtn:disabled { opacity: 0.45; cursor: not-allowed; }
  .report-table-scroll {
    max-height: 520px;
    overflow: auto;
    width: 100%;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
  }
  .pagination-container {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 0.75rem 0 0;
    gap: 1rem;
    margin-top: 0.75rem;
    border-top: 1px solid #eee;
  }
  .pagination-container .spntotal {
    font-size: 12px;
    font-weight: 600;
    color: #374151;
    white-space: nowrap;
  }
  .pagination-container .pagination { margin: 0; }
  .pagination-container .page-link {
    cursor: pointer;
    color: #1359a6;
    border: 1px solid #dee2e6;
    padding: 0.25rem 0.55rem;
    font-size: 12px;
  }
  .pagination-container .page-item.disabled .page-link {
    color: #9ca3af;
    pointer-events: none;
    background: #f9fafb;
  }
  .preloader {
    position: fixed;
    top: 50%; left: 50%;
    width: 100px; height: 100px;
    margin: -50px 0 0 -50px;
    background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    z-index: 2100;
  }
  .loader-overlay {
    position: fixed; inset: 0;
    background: transparent;
    z-index: 2000;
  }
  .loader-overlay .loader {
    position: absolute;
    top: 50%; left: 50%;
    width: 100px; height: 100px;
    margin: -50px 0 0 -50px;
    background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
  }
  .fc-toast {
    position: fixed;
    bottom: 20px; right: 20px;
    z-index: 4000;
    background: #1e3a5f;
    color: #fff;
    padding: 10px 14px;
    border-radius: 6px;
    font-size: 11.5px;
    opacity: 0;
    transform: translateY(8px);
    transition: opacity 0.15s, transform 0.15s;
    pointer-events: none;
  }
  .fc-toast.visible { opacity: 1; transform: translateY(0); }

  /* Forecast grid */
  #fcTable { border-collapse: separate; border-spacing: 0; min-width: 720px; width: 100%; font-size: 11.5px; }
  #fcTable th, #fcTable td { vertical-align: middle; }
  #fcTable thead th {
    position: sticky;
    background: #f8f9fa;
    z-index: 5;
    text-align: center;
    border-bottom: 1px solid #e5e7eb;
    font-weight: 600;
    font-size: 11px;
    color: #374151;
  }
  #fcTable thead tr:first-child th { top: 0; z-index: 6; }
  #fcTable thead tr:nth-child(2) th { top: 34px; z-index: 5; box-shadow: 0 1px 0 #e5e7eb; background: #f4f4f9; }
  #fcTable th.fc-res,
  #fcTable td.fc-res {
    position: sticky;
    left: 0;
    z-index: 4;
    background: #f8fafc;
    text-align: left;
    min-width: 220px;
    max-width: 280px;
    box-shadow: 1px 0 0 #e5e7eb;
  }
  #fcTable thead th.fc-res { z-index: 7; background: #f8f9fa; }
  #fcTable th.fc-month {
    font-size: 11px;
    letter-spacing: 0.04em;
    border-left: 1px solid #e5e7eb;
    cursor: pointer;
    user-select: none;
  }
  #fcTable th.fc-month:hover { color: #1e40af; }
  #fcTable th.fc-month .fc-chevron {
    font-size: 9px;
    opacity: 0.55;
    margin-left: 4px;
    transition: transform 0.15s;
  }
  #fcTable th.fc-month.is-expanded .fc-chevron { transform: rotate(0deg); }
  #fcTable th.fc-month:not(.is-expanded) .fc-chevron { transform: rotate(-90deg); }
  #fcTable th.fc-week,
  #fcTable th.fc-total {
    font-size: 10px;
    font-weight: 600;
    min-width: 56px;
    border-left: 1px solid #e5e7eb;
  }
  #fcTable th.fc-total { color: #6b7280; background: #f4f4f9 !important; }
  #fcTable td.fc-cell { padding: 5px 6px; border-left: 1px solid #f0f2f5; }
  #fcTable td.fc-cell .hc {
    min-width: 56px;
    height: 34px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 12px;
    letter-spacing: 0.01em;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  #fcTable tbody tr:hover td.fc-res { background: #f1f5f9; }
  .fc-hrs-tip {
    position: fixed;
    z-index: 5000;
    pointer-events: none;
    background: #1e3a5f;
    color: #fff;
    font-size: 11.5px;
    font-weight: 500;
    line-height: 1.45;
    padding: 8px 10px;
    border-radius: 6px;
    box-shadow: 0 4px 14px rgba(15, 23, 42, 0.22);
    white-space: nowrap;
    opacity: 0;
    transform: translateY(4px);
    transition: opacity 0.12s ease, transform 0.12s ease;
  }
  .fc-hrs-tip.visible { opacity: 1; transform: translateY(0); }
  .fc-hrs-tip b { font-weight: 600; }

  /* Resource detail panel */
  .fc-panel-overlay {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(20, 30, 50, 0.45);
    z-index: 3000;
    align-items: flex-end;
    justify-content: flex-end;
    padding: 0;
  }
  .fc-panel-overlay.open { display: flex; }
  .fc-panel {
    background: #fff;
    width: min(420px, 100vw);
    height: 100vh;
    display: flex;
    flex-direction: column;
    box-shadow: -8px 0 24px rgba(20, 30, 50, 0.18);
    border-left: 1px solid #e5e7eb;
  }
  .fc-panel-hd {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 0.75rem 1rem;
    background: #F8FAFC;
    border-bottom: 1px solid #e5e7eb;
  }
  .fc-panel-av {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: #dbeafe;
    color: #1e40af;
    font-weight: 700;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .fc-panel-body { flex: 1; overflow: auto; padding: 1rem; }
  .fc-panel-ft {
    display: flex;
    gap: 8px;
    padding: 0.75rem 1rem;
    border-top: 1px solid #e5e7eb;
    background: #fff;
  }
  .fc-panel-ft .borderbtn { flex: 1; justify-content: center; }
  .fc-panel-ft .btn-primary-fc {
    flex: 1;
    background: #1359a6;
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 6px 12px;
    font-weight: 600;
    cursor: pointer;
  }
  .fc-panel-close {
    border: 1px solid #d1d5db;
    background: #fff;
    border-radius: 4px;
    width: 28px;
    height: 28px;
    cursor: pointer;
    color: #6b7280;
    margin-left: auto;
  }
</style>
</head>

<body class="analytics-pva">
    <form id="form1" runat="server" onsubmit="return false;">
        <div id="AnalyticsPreloader" class="preloader" aria-label="Loading"></div>
        <div class="loader-overlay" id="loaderOverlay" style="display:none;"><div class="loader"></div></div>
        <div class="bgwhite" id="AnalyticsWrapper" style="display:none;">
  <div class="page-header-section" style="background:white;">
    <div class="graybg" style="padding:0.4rem 1rem; margin-left:0;">
      <h2 style="color:#1e40af; font-weight:600; font-size:18px; margin:0 0 0.25rem 0; display:flex; align-items:center;">
        <i class="fas fa-chart-line" style="color:#1e40af; font-size:1.5rem; margin-right:0.75rem;"></i>
        Forecasting Report
      </h2>
      <p style="color:#6b7280; margin:0;">Resource planning &middot; Weekly and monthly forecast vs actual</p>
    </div>
  </div>

  <div class="header-actions">
    <button type="button" class="btn-export" id="fcBtnPdf" title="Export PDF">
      <i class="far fa-file-pdf"></i> PDF
    </button>
    <button type="button" class="btn-export" id="fcBtnExcel" title="Export Excel">
      <i class="far fa-file-excel"></i> Excel
    </button>
  </div>

  <div class="page-wrap">
    <div class="fc-kpi-grid" id="fcKpis"></div>

    <div class="widget hours-filters fc-filter-panel">
      <div class="w-body">
        <div class="fc-filter-rows">
          <div class="fc-filter-row fc-filter-row-3">
            <div class="hours-field">
              <label>Business Group</label>
              <div id="fcBGHost" class="ss-host"></div>
            </div>
            <div class="hours-field">
              <label>Origination Unit</label>
              <div id="fcOUHost" class="ss-host"></div>
            </div>
            <div class="hours-field">
              <label>Department</label>
              <div id="fcDeptHost" class="ss-host"></div>
            </div>
          </div>
          <div class="fc-filter-row fc-filter-row-2">
            <div class="hours-field">
              <label>Role</label>
              <div id="fcRoleHost" class="ss-host"></div>
            </div>
            <div class="hours-field">
              <label for="fcName">Resource Name</label>
              <div class="fc-search-wrap">
                <i class="fas fa-search"></i>
                <input id="fcName" type="search" placeholder="Search resource" oninput="fcSearchInput(this.value)">
              </div>
            </div>
          </div>
          <div class="fc-filter-actions-row">
            <button type="button" class="fc-btn-clear" onclick="fcClearFilters()"><i class="fas fa-times"></i> Clear</button>
            <button type="button" class="fc-btn-show" onclick="fcShow()">Show</button>
          </div>
        </div>
        <div class="fc-filter-legend" aria-label="Utilization legend">
          <span class="fc-leg-item"><i class="fc-leg-dot idle"></i>Idle</span>
          <span class="fc-leg-item"><i class="fc-leg-dot low"></i>Low</span>
          <span class="fc-leg-item"><i class="fc-leg-dot mid"></i>Mid</span>
          <span class="fc-leg-item"><i class="fc-leg-dot high"></i>High</span>
        </div>
      </div>
    </div>

    <div class="main-section" id="fcWidget">
      <div class="main-section-header">
        <h3><i class="fas fa-table"></i> Forecast vs Actual</h3>
        <div class="fc-header-tools">
          <div class="level-tabs" id="fcSeg" role="tablist" aria-label="Forecast granularity">
            <button type="button" class="active" role="tab" data-mode="month" aria-selected="true" onclick="fcSetMode('month')">Monthly</button>
            <button type="button" role="tab" data-mode="week" onclick="fcSetMode('week')">Weekly</button>
          </div>
          <span class="fc-period-meta" id="fcPeriodLabel">—</span>
          <button class="borderbtn" type="button" id="fcPrevPeriod" onclick="fcPeriodPage(-1)">‹ Previous</button>
          <button class="borderbtn" type="button" id="fcNextPeriod" onclick="fcPeriodPage(1)">Next ›</button>
        </div>
      </div>
      <div class="main-section-body">
        <p class="fc-period-meta" id="fcPeriodNote" style="margin:0 0 10px">—</p>

        <div class="report-table-scroll">
          <table id="fcTable">
            <thead id="fcHead"></thead>
            <tbody id="fcBody"></tbody>
          </table>
        </div>

        <div class="pagination-container" id="fcPager" aria-label="Resource pagination">
          <span class="spntotal" id="fcTotalRecords">Total Records: 0</span>
          <nav>
            <ul class="pagination mb-0">
              <li class="page-item disabled" id="fcPagePrevItem">
                <a class="page-link" href="javascript:;" id="fcPagePrev" title="Previous"><i class="fas fa-angle-double-left"></i></a>
              </li>
              <li class="page-item disabled" id="fcPageNextItem">
                <a class="page-link" href="javascript:;" id="fcPageNext" title="Next"><i class="fas fa-angle-double-right"></i></a>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="fc-panel-overlay" id="fcPanel" aria-label="Resource forecast detail" aria-hidden="true">
  <div class="fc-panel">
    <div class="fc-panel-hd">
      <div class="fc-panel-av" id="fcPanelAv">–</div>
      <div style="flex:1;min-width:0">
        <b style="font-size:13.5px;display:block" id="fcPanelName">Resource forecast</b>
        <div style="font-size:11px;color:#6b7280" id="fcPanelRole">–</div>
      </div>
      <button type="button" class="fc-panel-close" onclick="fcClosePanel()" title="Close" aria-label="Close panel">✕</button>
    </div>
    <div class="fc-panel-body" id="fcPanelBody"></div>
    <div class="fc-panel-ft">
      <button type="button" class="borderbtn" onclick="fcClosePanel()">Close</button>
      <button type="button" class="btn-primary-fc" onclick="fcPanelAllocate()">Open allocation</button>
    </div>
  </div>
</div>

<div class="fc-toast" id="fcToast" role="status" aria-live="polite"></div>

<script src="js/search-select.js"></script>

<script>
/* =====================================================================
   FORECASTING REPORT — page controller (Skills Inventory / PVA Base UI)
===================================================================== */

var fcToastTimer = null;
function toast(msg) {
  var el = document.getElementById('fcToast');
  if (!el) return;
  el.textContent = msg || '';
  el.classList.add('visible');
  clearTimeout(fcToastTimer);
  fcToastTimer = setTimeout(function () { el.classList.remove('visible'); }, 2800);
}
function fcShowPage() {
  var pre = document.getElementById('AnalyticsPreloader');
  var wrap = document.getElementById('AnalyticsWrapper');
  if (pre) pre.style.display = 'none';
  if (wrap) wrap.style.display = 'block';
}

const FC_MONTHS  = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
if (strUrl && strUrl.endsWith('/')) strUrl = strUrl.slice(0, -1);
var LOGIN_ID = <%=If(Session("intUserID") Is Nothing, 0, Session("intUserID"))%>;

var fcFilterOptions = { bg: [], ou: [], dept: [], role: [] };

function isJson(str) {
  try { JSON.parse(str); } catch (e) { return false; }
  return true;
}
function encryptString(value) {
  var intStrArr = [];
  var strEncryptedString = '';
  var intEncryptNum = 1;
  var i;
  if (String(value).length > 0) {
    for (i = 0; i <= value.length - 1; i++) {
      intStrArr[i] = String(String(String(value[i])).charCodeAt(0) + intEncryptNum);
      intEncryptNum = intEncryptNum + 2;
    }
    strEncryptedString = intStrArr.join('-');
    if (String(strEncryptedString).substring(0, 1) == '-') {
      strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1);
    }
  }
  return strEncryptedString;
}
function apiHeaders(param, includeJsonContentType) {
  var headers = {
    'Authorization': 'bearer ' + (sessionStorage.getItem('access_token_W27_Dashboard') || '')
  };
  if (includeJsonContentType === true) {
    headers['Content-Type'] = 'application/json';
  }
  if (param) {
    headers['Params'] = encryptString(isJson(param) ? param : JSON.stringify(param));
  }
  return headers;
}
function apiPost(path, payload) {
  return fetch(encodeURI(strUrl) + path, {
    method: 'POST',
    headers: apiHeaders(payload || {}, true),
    body: JSON.stringify(payload || {})
  });
}
function apiVal(obj) {
  if (!obj) return undefined;
  for (var i = 1; i < arguments.length; i++) {
    var k = arguments[i];
    if (obj[k] != null && obj[k] !== '') return obj[k];
    var found = Object.keys(obj).find(function (ok) { return ok.toLowerCase() === String(k).toLowerCase(); });
    if (found != null && obj[found] != null && obj[found] !== '') return obj[found];
  }
  return undefined;
}
function asArray(v) {
  if (!v) return [];
  if (Array.isArray(v)) return v;
  return [v];
}
function unwrapPayload(json) {
  if (!json) return {};
  var data = json.data != null ? json.data : json.Data;
  if (data && typeof data === 'object' && !Array.isArray(data)) return data;
  return json;
}
function mapFilterOptions(arr, idKeys, labelKeys) {
  return asArray(arr).map(function (r) {
    var id = apiVal.apply(null, [r].concat(idKeys));
    var label = apiVal.apply(null, [r].concat(labelKeys));
    if (id == null && label == null) return null;
    return { value: String(id != null ? id : label), label: String(label != null ? label : id) };
  }).filter(Boolean);
}
function fcOptionLabel(kind, value) {
  if (!value) return '';
  var opts = fcFilterOptions[kind] || [];
  var found = opts.find(function (o) { return String(o.value) === String(value); });
  return found ? found.label : String(value);
}

function fetchFilterMasters() {
  return apiPost('/api/Forecasting/GetFilterMasters', {})
    .then(function (res) {
      if (!res.ok) throw new Error('GetFilterMasters failed: ' + res.status);
      return res.json();
    })
    .then(function (json) {
      var data = unwrapPayload(json);
      fcFilterOptions.bg = mapFilterOptions(
        apiVal(data, 'ForecastingBusinessGroupModel', 'forecastingBusinessGroupModel'),
        ['businessGroupID', 'BusinessGroupID', 'id', 'ID'],
        ['businessGroup', 'BusinessGroup', 'name', 'Name']
      );
      fcFilterOptions.ou = mapFilterOptions(
        apiVal(data, 'ForecastingOriginationUnitModel', 'forecastingOriginationUnitModel'),
        ['locationID', 'LocationID', 'id', 'ID'],
        ['location', 'Location', 'name', 'Name']
      );
      fcFilterOptions.dept = mapFilterOptions(
        apiVal(data, 'ForecastingDepartmentModel', 'forecastingDepartmentModel'),
        ['groupID', 'GroupID', 'departmentID', 'DepartmentID', 'id', 'ID'],
        ['groupName', 'GroupName', 'name', 'Name']
      );
      fcFilterOptions.role = mapFilterOptions(
        apiVal(data, 'ForecastingRoleModel', 'forecastingRoleModel'),
        ['roleID', 'RoleID', 'id', 'ID'],
        ['roleDescription', 'RoleDescription', 'role', 'Role', 'name', 'Name']
      );
    });
}

var fcData = {
  kpi: null,
  rows: [],
  weekColumns: [],
  totalRecords: 0,
  totalPages: 1,
  pageNumber: 1,
  loading: false,
  source: 'month' /* month | week */
};

var fcState = {
  mode: 'month',
  periodPage: 0,
  perPeriod: 3,
  rowPage: 1, /* 1-based PageNumber */
  perRow: 8,
  bg: '', ou: '', dept: '', role: '', q: '',
  bands: { idle: true, low: true, mid: true, high: true },
  sel: null,
  expandedMonths: {}
};

function fcNullableInt(v) {
  if (v == null || v === '') return null;
  var n = parseInt(v, 10);
  return isNaN(n) ? null : n;
}

/* ---------- ForecastingFilterRequest ---------- */
function buildForecastPayload() {
  var payload = {
    PageNumber: fcState.rowPage || 1,
    PageSize: fcState.perRow || 8,
    intUserID: LOGIN_ID || null
  };
  var bg = fcNullableInt(fcState.bg);
  var loc = fcNullableInt(fcState.ou);
  var dept = fcNullableInt(fcState.dept);
  var role = fcNullableInt(fcState.role);
  var search = (fcState.q && String(fcState.q).trim()) || '';
  if (bg != null) payload.BusinessGroupID = bg;
  if (loc != null) payload.LocationID = loc;
  if (dept != null) payload.DepartmentID = dept;
  if (role != null) payload.RoleID = role;
  if (search) payload.SearchText = search;
  return payload;
}

function fcNumVal(v) {
  var n = Number(v);
  return isNaN(n) ? 0 : n;
}

function fcRowKeyLookup(row, names) {
  for (var i = 0; i < names.length; i++) {
    var v = apiVal(row, names[i]);
    if (v != null && v !== '') return v;
  }
  /* case-insensitive scan */
  var keys = Object.keys(row || {});
  for (var j = 0; j < names.length; j++) {
    var want = String(names[j]).toLowerCase();
    for (var k = 0; k < keys.length; k++) {
      if (keys[k].toLowerCase() === want && row[keys[k]] != null && row[keys[k]] !== '') {
        return row[keys[k]];
      }
    }
  }
  return undefined;
}

function parseMonthlyRows(rawRows) {
  return asArray(rawRows).map(function (r, idx) {
    var actual = [];
    var planned = [];
    FC_MONTH_KEYS.forEach(function (m) {
      var cap = m.charAt(0).toUpperCase() + m.slice(1);
      /* Spec: january = hours, january_Ph = planned hours */
      actual.push(fcNumVal(fcRowKeyLookup(r, [m, cap, m + '_Ah', m + '_AH', cap + '_Ah'])));
      planned.push(fcNumVal(fcRowKeyLookup(r, [m + '_Ph', m + '_PH', cap + '_Ph', cap + '_PH', m + 'Ph', m + 'PH'])));
    });
    return {
      id: String(fcRowKeyLookup(r, ['employeeID', 'EmployeeID', 'resourceID', 'ResourceID']) || ('r' + (idx + 1))),
      name: String(fcRowKeyLookup(r, ['resourceName', 'ResourceName', 'employeeName', 'EmployeeName']) || ''),
      role: String(fcRowKeyLookup(r, ['roleDescription', 'RoleDescription', 'role', 'Role']) || ''),
      dept: String(fcRowKeyLookup(r, ['department', 'Department', 'groupName', 'GroupName']) || ''),
      bg: String(fcRowKeyLookup(r, ['businessGroup', 'BusinessGroup']) || ''),
      ou: String(fcRowKeyLookup(r, ['location', 'Location', 'originationUnit', 'OriginationUnit']) || ''),
      actual: actual,
      planned: planned,
      weeks: null,
      raw: r
    };
  });
}

function parseWeekColumns(cols) {
  return asArray(cols).map(function (c) {
    var wkNo = fcNumVal(fcRowKeyLookup(c, ['wkNo', 'WkNo', 'weekNo', 'WeekNo', 'sequenceNo', 'SequenceNo']));
    var start = fcRowKeyLookup(c, ['wkStartDate', 'WkStartDate', 'startDate', 'StartDate']);
    // monthIndex is assigned dynamically in applyForecastResponse to match rolling calendar
    return { wkNo: wkNo, monthIndex: 0, label: 'W' + wkNo, start: start };
  }).filter(function (w) { return w.wkNo > 0; });
}

function parseWeeklyRows(rawRows, weekCols) {
  var meta = weekCols && weekCols.length ? weekCols : [];
  return asArray(rawRows).map(function (r, idx) {
    var weeks = {};
    var actual = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    var planned = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    function ingestWeek(wkNo, monthIndex) {
      // BUG FIX: SQL outputs ActualHrs into W{n} and AllocatedHrs into W{n}_Ah.
      var a = fcNumVal(fcRowKeyLookup(r, ['W' + wkNo, 'w' + wkNo]));
      var pl = fcNumVal(fcRowKeyLookup(r, ['W' + wkNo + '_Ah', 'W' + wkNo + '_AH', 'w' + wkNo + '_Ah', 'W' + wkNo + 'Ah']));

      weeks[wkNo] = { a: a, pl: pl, monthIndex: monthIndex };
      if (monthIndex >= 0 && monthIndex < 12) {
        actual[monthIndex] += a;
        planned[monthIndex] += pl;
      }
    }

    if (meta.length) {
      meta.forEach(function (w) { ingestWeek(w.wkNo, w.monthIndex); });
    } else {
      for (var n = 1; n <= 53; n++) {
        if (fcRowKeyLookup(r, ['W' + n, 'W' + n + '_Ah', 'W' + n + '_AH']) == null) continue;
        // Fallback absolute calendar month
        ingestWeek(n, Math.min(11, Math.floor((n - 1) / 4)));
      }
    }

    return {
      id: String(fcRowKeyLookup(r, ['employeeID', 'EmployeeID', 'resourceID', 'ResourceID']) || ('r' + (idx + 1))),
      name: String(fcRowKeyLookup(r, ['resourceName', 'ResourceName', 'employeeName', 'EmployeeName']) || ''),
      role: String(fcRowKeyLookup(r, ['roleDescription', 'RoleDescription', 'role', 'Role']) || ''),
      dept: String(fcRowKeyLookup(r, ['department', 'Department', 'groupName', 'GroupName']) || ''),
      bg: String(fcRowKeyLookup(r, ['businessGroup', 'BusinessGroup']) || ''),
      ou: String(fcRowKeyLookup(r, ['location', 'Location']) || ''),
      actual: actual,
      planned: planned,
      weeks: weeks,
      raw: r
    };
  });
}

// 1. Clear out the hardcoded arrays
var FC_MONTH_KEYS = [];
var FC_MONTH_LABELS = [];

// 2. Replace your existing applyForecastResponse function with this updated version
function applyForecastResponse(json, source) {
  var data = unwrapPayload(json);
  var kpi = apiVal(data, 'kpi', 'Kpi') || null;
  var grid = apiVal(data, 'grid', 'Grid') || data;
  var rowsRaw = apiVal(grid, 'rows', 'Rows') || [];
  var weekCols = parseWeekColumns(apiVal(data, 'weekColumns', 'WeekColumns'));
  var monthCols = apiVal(data, 'monthColumns', 'MonthColumns') || [];

  var monthNames = ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'];
  var shortNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  // DYNAMIC ROLLING MONTHS: Align UI months with the API's returned timeframe
  if (source === 'month' && monthCols && monthCols.length > 0) {
      FC_MONTH_KEYS = monthCols.map(function(m) { return String(m.name || '').toLowerCase(); });
      FC_MONTH_LABELS = monthCols.map(function(m) { return String(m.name || '').substring(0, 3); });
  } else if (source === 'week' && weekCols && weekCols.length > 0) {
      var uniqueKeys = [];
      var uniqueLabels = [];
      
      weekCols.forEach(function(w) {
          if (w.start) {
              var d = new Date(w.start);
              if (!isNaN(d.getTime())) {
                  var mIdx = d.getMonth();
                  var mKey = monthNames[mIdx];
                  var mLabel = shortNames[mIdx];

                  if (uniqueKeys.indexOf(mKey) === -1) {
                      uniqueKeys.push(mKey);
                      uniqueLabels.push(mLabel);
                  }
                  // Map this week to the rolling array index (0 to 11)
                  w.monthIndex = uniqueKeys.indexOf(mKey);
              }
          }
      });
      
      if (uniqueKeys.length > 0) {
          FC_MONTH_KEYS = uniqueKeys;
          FC_MONTH_LABELS = uniqueLabels;
      }
  } else if (FC_MONTH_KEYS.length === 0) {
      FC_MONTH_KEYS = monthNames;
      FC_MONTH_LABELS = shortNames;
  }

  fcData.kpi = kpi;
  fcData.weekColumns = weekCols;
  fcData.source = source;
  fcData.totalRecords = fcNumVal(apiVal(grid, 'totalRecords', 'TotalRecords') || apiVal(data, 'totalRecords', 'TotalRecords'));
  fcData.totalPages = Math.max(1, fcNumVal(apiVal(grid, 'totalPages', 'TotalPages') || apiVal(data, 'totalPages', 'TotalPages') || 1));
  fcData.pageNumber = fcNumVal(apiVal(grid, 'pageNumber', 'PageNumber') || apiVal(data, 'pageNumber', 'PageNumber') || fcState.rowPage) || 1;

  if (source === 'week') {
    fcData.rows = parseWeeklyRows(rowsRaw, weekCols);
  } else {
    fcData.rows = parseMonthlyRows(rowsRaw);
  }
}

function fetchForecastGrid() {
  var wantWeek = fcState.mode === 'week' || Object.keys(fcState.expandedMonths).length > 0;
  var path = wantWeek
    ? '/api/Forecasting/GetWeeklyForecast'
    : '/api/Forecasting/GetMonthlyForecast';
  var payload = buildForecastPayload();
  fcData.loading = true;
  var body = document.getElementById('fcBody');
  if (body) {
    body.innerHTML = '<tr><td colspan="8" style="text-align:center;color:var(--muted);padding:26px">Loading forecast…</td></tr>';
  }

  return apiPost(path, payload)
    .then(function (res) {
      if (!res.ok) throw new Error((wantWeek ? 'GetWeeklyForecast' : 'GetMonthlyForecast') + ' failed: ' + res.status);
      return res.json();
    })
    .then(function (json) {
      applyForecastResponse(json, wantWeek ? 'week' : 'month');
      fcData.loading = false;
      fcRenderFilters();
      fcRenderKpis();
      fcRenderTable();
    })
    .catch(function (err) {
      console.error('Forecast grid error:', err);
      fcData.loading = false;
      fcData.rows = [];
      fcData.kpi = null;
      fcData.totalRecords = 0;
      fcData.totalPages = 1;
      fcRenderKpis();
      fcRenderTable();
      toast(err && err.message ? err.message : 'Unable to load forecast grid');
    });
}

/* ---------- period model ---------- */
function fcMonthGroups(){
  return FC_MONTH_LABELS.map(function(m, i){
    var weeks = [];
    if (fcData.weekColumns && fcData.weekColumns.length) {
      fcData.weekColumns.filter(function (w) { return w.monthIndex === i; }).forEach(function (w) {
        weeks.push({
          key: 'w' + w.wkNo,
          monthIndex: i,
          weekIndex: weeks.length,
          wkNo: w.wkNo,
          label: w.label,
          month: m
        });
      });
    } else {
      var weekCount = (i === 11) ? 5 : 4;
      for (var w = 0; w < weekCount; w++) {
        weeks.push({
          key: i + '-' + w,
          monthIndex: i,
          weekIndex: w,
          wkNo: i * 4 + w + 1,
          label: 'W' + (w + 1),
          month: m
        });
      }
    }
    return { monthIndex: i, label: m, weeks: weeks };
  });
}
function fcVisibleMonthGroups(){
  var all = fcMonthGroups();
  var s = fcState.periodPage * fcState.perPeriod;
  return all.slice(s, s + fcState.perPeriod);
}
function fcIsMonthExpanded(monthIndex){
  return !!fcState.expandedMonths[String(monthIndex)];
}
function fcToggleMonthExpand(monthIndex, ev){
  if (ev) { ev.preventDefault(); ev.stopPropagation(); }
  var key = String(monthIndex);
  if (fcState.expandedMonths[key]) delete fcState.expandedMonths[key];
  else fcState.expandedMonths[key] = true;
  var anyExpanded = Object.keys(fcState.expandedMonths).length > 0;
  if (anyExpanded) fcState.mode = 'week';
  else if (fcState.mode !== 'week') fcState.mode = 'month';
  /* expanding needs weekly API data */
  if (anyExpanded && fcData.source !== 'week') {
    fetchForecastGrid();
    return;
  }
  if (!anyExpanded && fcState.mode === 'month' && fcData.source === 'week') {
    fetchForecastGrid();
    return;
  }
  fcRenderTable();
  fcRenderKpis();
}
function fcPeriodPages(){ return Math.ceil(FC_MONTH_LABELS.length / fcState.perPeriod); }

function fcPlanned(r, p){
  if (p.isMonth || p.weekIndex == null || p.wkNo == null) {
    return (r.planned && r.planned[p.monthIndex]) || 0;
  }
  if (r.weeks && r.weeks[p.wkNo]) return r.weeks[p.wkNo].pl || 0;
  return 0;
}
function fcActual(r, p){
  if (p.isMonth || p.weekIndex == null || p.wkNo == null) {
    return (r.actual && r.actual[p.monthIndex]) || 0;
  }
  if (r.weeks && r.weeks[p.wkNo]) return r.weeks[p.wkNo].a || 0;
  return 0;
}
function fcMonthTotal(r, monthIndex){
  return {
    a: (r.actual && r.actual[monthIndex]) || 0,
    pl: (r.planned && r.planned[monthIndex]) || 0
  };
}
function fcHeatCell(a, pl){
  var b = fcBand(pl ? (a / pl * 100) : 0);
  return '<div class="hc" data-actual="' + a + '" data-planned="' + pl + '"' +
    ' style="background:' + FC_BAND_BG[b] + ';color:' + FC_BAND_FG[b] + '">' + a + '/' + pl + '</div>';
}

/* ---------- bands ---------- */
function fcBand(pct){ return pct<=0 ? "idle" : pct<40 ? "low" : pct<70 ? "mid" : "high"; }
const FC_BAND_BG = {
  idle: "#f5f6f8",
  low:  "#e6f7f2",
  mid:  "#fff3e0",
  high: "#ffe8ec"
};
const FC_BAND_FG = {
  idle: "#9aa3af",
  low:  "#0f8a74",
  mid:  "#c07d3e",
  high: "#c0392b"
};
const FC_BAND_SOLID = {
  idle: "#e5e7eb",
  low:  "#2dd4bf",
  mid:  "#f0a35a",
  high: "#f07184"
};

/* ---------- helpers ---------- */
const fcEsc  = s => String(s == null ? '' : s).replace(/[&<>"]/g, c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]));
const fcInit = n => String(n || '').split(/\s+/).filter(Boolean).map(w=>w[0]).slice(0,2).join("").toUpperCase();
const fcNum  = n => Number(n || 0).toLocaleString("en-IN");

/* ---------- filtering (server-side; local rows already filtered) ---------- */
function fcRows(){
  return fcData.rows || [];
}

/* ---------- KPI cards ---------- */
function fcRenderKpis(){
  var kpi = fcData.kpi || {};
  var rows = fcRows();
  var totalRes = fcNumVal(apiVal(kpi, 'totalResources', 'TotalResources')) || fcData.totalRecords || rows.length;
  var plan = fcNumVal(apiVal(kpi, 'totalPlannedHours', 'TotalPlannedHours'));
  var act = fcNumVal(apiVal(kpi, 'totalActualHours', 'TotalActualHours'));
  var remaining = fcNumVal(apiVal(kpi, 'remainingHours', 'RemainingHours'));
  if (!plan && !act && rows.length) {
    rows.forEach(function (r) {
      for (var i = 0; i < 12; i++) {
        plan += (r.planned && r.planned[i]) || 0;
        act += (r.actual && r.actual[i]) || 0;
      }
    });
    remaining = Math.max(0, plan - act);
  }
  if (remaining == null || (remaining === 0 && plan > act)) remaining = Math.max(0, plan - act);
  var util = fcNumVal(apiVal(kpi, 'utilizationPercent', 'UtilizationPercent'));
  if (!util && plan) util = Math.round(act / plan * 100);
  var health = String(apiVal(kpi, 'utilizationLabel', 'UtilizationLabel') || '');
  var band = fcBand(util);
  if (!health) health = { idle: 'Idle', low: 'Under-utilised', mid: 'Watch', high: 'Healthy' }[band];
  var groups = fcVisibleMonthGroups();
  var periodSub = groups.length + (groups.length === 1 ? ' month shown' : ' months shown');
  function kpiCard(theme, icon, label, val, sub) {
    return '<div class="fc-kpi-card ' + theme + '">' +
      '<div class="fc-kpi-icon"><i class="' + icon + '"></i></div>' +
      '<div class="fc-kpi-body">' +
        '<div class="fc-kpi-label">' + label + '</div>' +
        '<div class="fc-kpi-val">' + val + '</div>' +
        '<div class="fc-kpi-sub">' + sub + '</div>' +
      '</div></div>';
  }
  var el = document.getElementById('fcKpis');
  if (!el) return;
  el.innerHTML =
    kpiCard('fc-kpi-blue', 'fas fa-users', 'Resources', totalRes, 'of ' + (fcData.totalRecords || totalRes) + ' total') +
    kpiCard('fc-kpi-purple', 'far fa-clock', 'Planned Hours', fcNum(plan), periodSub) +
    kpiCard('fc-kpi-orange', 'fas fa-heartbeat', 'Actual Hours', fcNum(act), fcNum(remaining) + ' remaining') +
    kpiCard('fc-kpi-green', 'fas fa-chart-line', 'Utilization', util + '%', fcEsc(health));
}

/* ---------- forecast grid ---------- */
function fcRenderTable(){
  const groups = fcVisibleMonthGroups();
  const rows = fcRows();
  const pages = Math.max(1, fcData.totalPages || 1);
  if (fcState.rowPage > pages) fcState.rowPage = pages;
  if (fcState.rowPage < 1) fcState.rowPage = 1;
  const slice = rows;
  const anyExpanded = groups.some(function(g){ return fcIsMonthExpanded(g.monthIndex); });

  let head1 = '<tr><th scope="col" class="fc-res"' + (anyExpanded ? ' rowspan="2"' : '') + '>Resource · Actual / Planned Hrs</th>';
  let head2 = anyExpanded ? '<tr>' : '';

  groups.forEach(function(g){
    const expanded = fcIsMonthExpanded(g.monthIndex);
    const chevron = '<i class="fas fa-chevron-down fc-chevron"></i>';
    const title = expanded ? 'Collapse weeks' : 'Expand weeks';
    if (expanded) {
      const span = Math.max(1, g.weeks.length) + 1;
      head1 += '<th scope="colgroup" class="fc-month is-expanded" colspan="' + span + '"' +
        ' onclick="fcToggleMonthExpand(' + g.monthIndex + ',event)" title="' + title + '">' +
        fcEsc(g.label) + ' ' + chevron + '</th>';
      g.weeks.forEach(function(w){
        head2 += '<th scope="col" class="fc-week">' + fcEsc(w.label) + '</th>';
      });
      head2 += '<th scope="col" class="fc-total">Total</th>';
    } else if (anyExpanded) {
      head1 += '<th scope="col" class="fc-month" rowspan="2"' +
        ' onclick="fcToggleMonthExpand(' + g.monthIndex + ',event)" title="' + title + '">' +
        fcEsc(g.label) + ' ' + chevron + '</th>';
    } else {
      head1 += '<th scope="col" class="fc-month"' +
        ' onclick="fcToggleMonthExpand(' + g.monthIndex + ',event)" title="' + title + '">' +
        fcEsc(g.label) + ' ' + chevron + '</th>';
    }
  });
  head1 += '</tr>';
  if (anyExpanded) head2 += '</tr>';
  var headEl = document.getElementById('fcHead');
  var bodyEl = document.getElementById('fcBody');
  if (!headEl || !bodyEl) return;
  headEl.innerHTML = head1 + head2;

  const colCount = groups.reduce(function(n, g){
    return n + (fcIsMonthExpanded(g.monthIndex) ? (g.weeks.length + 1) : 1);
  }, 1);

  bodyEl.innerHTML = slice.length ? slice.map(function(r){
    let cells = '';
    groups.forEach(function(g){
      if (fcIsMonthExpanded(g.monthIndex)) {
        g.weeks.forEach(function(w){
          const a = fcActual(r, w), pl = fcPlanned(r, w);
          cells += '<td class="fc-cell">' + fcHeatCell(a, pl) + '</td>';
        });
        const tot = fcMonthTotal(r, g.monthIndex);
        cells += '<td class="fc-cell">' + fcHeatCell(tot.a, tot.pl) + '</td>';
      } else {
        const tot = fcMonthTotal(r, g.monthIndex);
        cells += '<td class="fc-cell">' + fcHeatCell(tot.a, tot.pl) + '</td>';
      }
    });
    return '<tr onclick="fcOpenPanel(\'' + fcEsc(r.id) + '\')" title="Open forecast panel">' +
      '<td class="fc-res"><span style="display:flex;align-items:center;gap:9px">' +
        '<span style="white-space:normal"><b>' + fcEsc(r.name) + '</b>' +
        '<small style="display:block;color:var(--muted);font-size:11px">' + fcEsc(r.role) + ' · ' + fcEsc(r.dept) + '</small></span></span></td>' +
      cells + '</tr>';
  }).join('')
    : '<tr><td colspan="' + colCount + '" style="text-align:center;color:var(--muted);padding:26px">' +
      (fcData.loading ? 'Loading forecast…' : 'No resources match these filters.') + '</td></tr>';

  const firstGroup = groups[0];
  const lastGroup = groups[groups.length - 1];
  let note = '—';
  if (firstGroup && lastGroup) {
    note = 'Showing ' + firstGroup.label + ' – ' + lastGroup.label + ' · Page ' +
      (fcState.periodPage + 1) + ' of ' + fcPeriodPages();
  }
  var noteEl = document.getElementById('fcPeriodNote');
  var labelEl = document.getElementById('fcPeriodLabel');
  if (noteEl) noteEl.textContent = note;
  if (labelEl) labelEl.textContent = note;
  var prevP = document.getElementById('fcPrevPeriod');
  var nextP = document.getElementById('fcNextPeriod');
  if (prevP) prevP.disabled = fcState.periodPage === 0;
  if (nextP) nextP.disabled = fcState.periodPage >= fcPeriodPages() - 1;

  var totalEl = document.getElementById('fcTotalRecords');
  if (totalEl) totalEl.textContent = 'Total Records: ' + (fcData.totalRecords || rows.length);
  var prevItem = document.getElementById('fcPagePrevItem');
  var nextItem = document.getElementById('fcPageNextItem');
  if (prevItem) prevItem.classList.toggle('disabled', fcState.rowPage <= 1);
  if (nextItem) nextItem.classList.toggle('disabled', fcState.rowPage >= pages || !rows.length);

  var prevBtn = document.getElementById('fcPagePrev');
  var nextBtn = document.getElementById('fcPageNext');
  if (prevBtn) {
    prevBtn.onclick = function (e) {
      e.preventDefault();
      if (prevItem && prevItem.classList.contains('disabled')) return;
      fcRowPage(-1);
    };
  }
  if (nextBtn) {
    nextBtn.onclick = function (e) {
      e.preventDefault();
      if (nextItem && nextItem.classList.contains('disabled')) return;
      fcRowPage(1);
    };
  }

  document.querySelectorAll('#fcSeg button').forEach(function(b){
    const on = b.dataset.mode === fcState.mode;
    b.classList.toggle('active', on);
    b.setAttribute('aria-selected', on);
  });
}

/* ---------- filter dropdowns (searchable) ---------- */
function fcRenderFilters() {
    if (typeof SearchSelect === "undefined") return;

    // 2. Bind Business Groups
    SearchSelect.render("fcBGHost", {
        key: "fcBG",
        options: fcFilterOptions.bg,
        value: fcState.bg,
        placeholder: "Select Business Group",
        searchPlaceholder: "Search Business Group...",
        onChange: function(v){ fcSetFilter("bg", v); }
    });

    // 3. Bind Origination Units
    SearchSelect.render("fcOUHost", {
        key: "fcOU",
        options: fcFilterOptions.ou,
        value: fcState.ou,
        placeholder: "Select Origination Unit",
        searchPlaceholder: "Search Origination Unit...",
        onChange: function(v){ fcSetFilter("ou", v); }
    });

    // 4. Bind Departments
    SearchSelect.render("fcDeptHost", {
        key: "fcDept",
        options: fcFilterOptions.dept,
        value: fcState.dept,
        placeholder: "Select Department",
        searchPlaceholder: "Search Department...",
        onChange: function(v){ fcSetFilter("dept", v); }
    });

    // 5. Bind Roles
    SearchSelect.render("fcRoleHost", {
        key: "fcRole",
        options: fcFilterOptions.role,
        value: fcState.role,
        placeholder: "Select Role",
        searchPlaceholder: "Search Role...",
        onChange: function(v){ fcSetFilter("role", v); }
    });

    // Handle Search Input
    const n = document.getElementById("fcName");
    if(n && n.value !== fcState.q) n.value = fcState.q;
}
/* ---------- offcanvas ---------- */
function fcOpenPanel(id){
  const r = fcRows().find(x=>String(x.id)===String(id)); if(!r) return;
  fcState.sel = id;
  if(location.hash !== "#/resource/"+id) location.hash = "#/resource/"+id;
  document.getElementById("fcPanelAv").textContent   = fcInit(r.name);
  document.getElementById("fcPanelName").textContent = r.name;
  document.getElementById("fcPanelRole").textContent = r.role + " · " + r.dept;
  const yearPlan = (r.planned || []).reduce(function(a,b){ return a + (Number(b)||0); }, 0);
  const yearAct  = (r.actual || []).reduce(function(a,b){ return a + (Number(b)||0); }, 0);
  const yearUtil = yearPlan ? Math.round(yearAct/yearPlan*100) : 0;
  const yb = fcBand(yearUtil);

  document.getElementById("fcPanelBody").innerHTML =
    '<div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-bottom:14px">' +
      '<div style="background:#f8fafc;border:1px solid #e5e7eb;border-radius:6px;padding:10px">' +
        '<div style="font-size:18px;font-weight:700;color:#1e40af">' + yearUtil + '%</div>' +
        '<div style="font-size:11px;color:#6b7280;margin-top:2px">FY utilization</div>' +
        '<div style="font-size:11px;color:#9ca3af;margin-top:4px">' + fcNum(yearAct) + ' of ' + fcNum(yearPlan) + ' hrs</div></div>' +
      '<div style="background:#f8fafc;border:1px solid #e5e7eb;border-radius:6px;padding:10px">' +
        '<div style="font-size:18px;font-weight:700;color:#1e40af">' + fcNum(Math.max(0, yearPlan - yearAct)) + '</div>' +
        '<div style="font-size:11px;color:#6b7280;margin-top:2px">Hours remaining</div>' +
        '<div style="font-size:11px;color:#9ca3af;margin-top:4px">Across 12 months</div></div>' +
    '</div>' +
    '<div style="margin-bottom:14px">' +
      '<div style="font-size:11px;font-weight:600;color:#4b5563;margin-bottom:8px">Monthly forecast vs actual</div>' +
      FC_MONTH_LABELS.map(function(m,i){
        const a=(r.actual&&r.actual[i])||0, p=(r.planned&&r.planned[i])||0, pc=p?Math.round(a/p*100):0, b=fcBand(pc);
        return '<div style="display:flex;align-items:center;gap:9px;margin-bottom:7px">' +
          '<span style="width:30px;font-size:11px;color:#6b7280">' + m + '</span>' +
          '<div class="pbar" style="flex:1;min-width:0;height:6px;background:#eef2f7;border-radius:4px;overflow:hidden">' +
            '<i style="display:block;height:100%;width:' + Math.min(100,pc) + '%;background:' + FC_BAND_SOLID[b] + '"></i></div>' +
          '<span style="width:74px;text-align:right;font-size:11.5px">' + a + '/' + p + '</span>' +
          '<span class="fc-util-badge ' + b + '" style="width:44px;text-align:center">' + pc + '%</span></div>';
      }).join('') +
    '</div>' +
    '<div style="border-top:1px solid #e5e7eb;padding-top:12px">' +
      '<div style="font-size:11px;font-weight:600;color:#4b5563;margin-bottom:8px">Assignment</div>' +
      '<div style="display:flex;flex-wrap:wrap;gap:8px;font-size:11.5px;color:#374151">' +
        '<span>' + fcEsc(r.bg || '—') + '</span>' +
        '<span>· ' + fcEsc(r.ou || '—') + '</span>' +
        '<span>· ' + fcEsc(r.role) + '</span>' +
      '</div></div>';

  const el = document.getElementById("fcPanel");
  el.classList.add("open");
  el.setAttribute("aria-hidden","false");
}
function fcClosePanel(){
  const el = document.getElementById("fcPanel");
  el.classList.remove("open");
  el.setAttribute("aria-hidden","true");
  fcState.sel = null;
  if(location.hash.startsWith("#/resource/")) location.hash = "#/";
}
function fcPanelAllocate(){
  if(!fcState.sel) return;
  location.href = "resource-allocation.html#/";
}

/* ---------- toolbar actions ---------- */
function fcSearchInput(v) {
  fcState.q = v;
}
function fcSetFilter(k, v) {
  fcState[k] = v;
  fcRenderFilters();
}
function fcShow() {
  fcState.rowPage = 1;
  fcHydrate(true);
}
function fcClearFilters() {
  Object.assign(fcState, { bg: '', ou: '', dept: '', role: '', q: '', rowPage: 1 });
  var n = document.getElementById('fcName');
  if (n) n.value = '';
  fcRenderFilters();
  fcHydrate(true);
  toast('Filters cleared');
}
function fcSetMode(m){
  if (m === "week") {
    fcVisibleMonthGroups().forEach(function(g){ fcState.expandedMonths[String(g.monthIndex)] = true; });
    fcState.mode = "week";
  } else {
    fcState.expandedMonths = {};
    fcState.mode = "month";
  }
  fcState.rowPage = 1;
  fcHydrate(true);
}
function fcPeriodPage(d){
  const n = Math.min(Math.max(0, fcState.periodPage + d), fcPeriodPages() - 1);
  if (n === fcState.periodPage) return;
  fcState.periodPage = n;
  if (fcState.mode === "week") {
    fcState.expandedMonths = {};
    fcVisibleMonthGroups().forEach(function(g){ fcState.expandedMonths[String(g.monthIndex)] = true; });
  } else {
    fcState.expandedMonths = {};
  }
  fcRenderTable();
  fcRenderKpis();
}
function fcRowPage(d){
  const pages = Math.max(1, fcData.totalPages || 1);
  const n = Math.min(Math.max(1, fcState.rowPage + d), pages);
  if (n === fcState.rowPage) return;
  fcState.rowPage = n;
  fetchForecastGrid();
}

/* ---------- Export Excel / PDF ---------- */
function getTodayYYYYMMDD() {
  var d = new Date();
  var mm = String(d.getMonth() + 1); if (mm.length < 2) mm = '0' + mm;
  var dd = String(d.getDate()); if (dd.length < 2) dd = '0' + dd;
  return d.getFullYear() + mm + dd;
}
function downloadBlob(blob, fileName) {
  var url = window.URL.createObjectURL(blob);
  var a = document.createElement('a');
  a.href = url;
  a.download = fileName;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(function () { window.URL.revokeObjectURL(url); }, 1000);
}
function fileNameFromDisposition(header, fallback) {
  if (!header) return fallback;
  var star = /filename\*\s*=\s*UTF-8''([^;]+)/i.exec(header);
  if (star && star[1]) {
    try { return decodeURIComponent(star[1].replace(/"/g, '').trim()); } catch (e) { /* ignore */ }
  }
  var m = /filename\s*=\s*("?)([^";]+)\1/i.exec(header);
  if (m && m[2]) return m[2].trim();
  return fallback;
}
function buildExportPayload() {
  var p = buildForecastPayload();
  p.CompanyLogo = null;
  return p;
}
function fcExport(kind) {
  var isPdf = kind === 'pdf';
  var isWeekly = fcState.mode === 'week' || Object.keys(fcState.expandedMonths).length > 0;
  var apiPath = (isPdf ? '/api/Forecasting/ExportForecastingPdf' : '/api/Forecasting/ExportForecastingExcel') +
    '?isWeekly=' + (isWeekly ? 'true' : 'false');
  var ext = isPdf ? 'pdf' : 'xlsx';
  var fileName = 'Forecasting_Report_' + getTodayYYYYMMDD() + '.' + ext;
  toast(isPdf ? 'Generating PDF…' : 'Generating Excel…');

  apiPost(apiPath, buildExportPayload())
    .then(function (res) {
      var disp = res.headers.get('Content-Disposition') || res.headers.get('content-disposition');
      var name = fileNameFromDisposition(disp, fileName);
      return res.blob().then(function (blob) {
        return { ok: res.ok, blob: blob, fileName: name };
      });
    })
    .then(function (result) {
      var blob = result.blob;
      var ct = (blob && blob.type) ? blob.type.toLowerCase() : '';
      if (!result.ok || ct.indexOf('application/json') > -1 || ct.indexOf('text/') > -1) {
        return blob.text().then(function (text) {
          var msg = 'Unable to export.';
          try {
            var json = JSON.parse(text);
            msg = (json && (json.message || (json.data && json.data.message))) || msg;
          } catch (e) {
            if (text && text.length < 300) msg = text;
          }
          throw new Error(msg);
        });
      }
      if (!blob || blob.size === 0) throw new Error('There are no items to show.');
      downloadBlob(blob, result.fileName || fileName);
      toast((isPdf ? 'PDF' : 'Excel') + ' downloaded');
    })
    .catch(function (err) {
      console.error('Forecast export failed:', err);
      alert(err && err.message ? err.message : 'Unable to export.');
    });
}

/* ---------- hydration + routing ---------- */
function fcHydrate(reloadGrid){
  if(!document.getElementById("fcBody")) return;
  fcRenderFilters();
  if (reloadGrid) {
    fetchForecastGrid().then(function () {
      var m = location.hash.match(/^#\/resource\/(.+)$/);
      if (m && fcState.sel !== m[1]) fcOpenPanel(m[1]);
      if (!m && fcState.sel) fcClosePanel();
    });
    return;
  }
  fcRenderKpis();
  fcRenderTable();
  var m = location.hash.match(/^#\/resource\/(.+)$/);
  if(m && fcState.sel !== m[1]) fcOpenPanel(m[1]);
  if(!m && fcState.sel) fcClosePanel();
}

window.addEventListener("hashchange", function(){ fcHydrate(false); });
document.addEventListener("keydown", e=>{ if(e.key==="Escape") fcClosePanel(); });
document.getElementById('fcPanel').addEventListener('click', function(e) {
  if (e.target === this) fcClosePanel();
});
document.getElementById('fcBtnPdf').addEventListener('click', function () { fcExport('pdf'); });
document.getElementById('fcBtnExcel').addEventListener('click', function () { fcExport('excel'); });

(function bindFcHoursTooltip(){
  var tip = document.createElement('div');
  tip.className = 'fc-hrs-tip';
  tip.setAttribute('role', 'tooltip');
  document.body.appendChild(tip);

  function hideTip(){
    tip.classList.remove('visible');
  }
  function showTip(el){
    var a = el.getAttribute('data-actual');
    var pl = el.getAttribute('data-planned');
    if (a == null || pl == null) return;
    tip.innerHTML = 'Actual Hrs: <b>' + fcEsc(a) + '</b><br>Planned Hrs: <b>' + fcEsc(pl) + '</b>';
    tip.classList.add('visible');
    var r = el.getBoundingClientRect();
    var tw = tip.offsetWidth || 120;
    var th = tip.offsetHeight || 40;
    var left = r.left + (r.width / 2) - (tw / 2);
    var top = r.top - th - 8;
    if (left < 8) left = 8;
    if (left + tw > window.innerWidth - 8) left = window.innerWidth - tw - 8;
    if (top < 8) top = r.bottom + 8;
    tip.style.left = left + 'px';
    tip.style.top = top + 'px';
  }

  document.addEventListener('mouseover', function (e) {
    var cell = e.target.closest && e.target.closest('#fcTable .hc[data-actual]');
    if (!cell) return;
    showTip(cell);
  });
  document.addEventListener('mouseout', function (e) {
    var cell = e.target.closest && e.target.closest('#fcTable .hc[data-actual]');
    if (!cell) return;
    var to = e.relatedTarget;
    if (to && cell.contains(to)) return;
    hideTip();
  });
  document.addEventListener('scroll', hideTip, true);
})();

fetchFilterMasters()
  .catch(function (err) {
    console.error('GetFilterMasters error:', err);
    toast('Unable to load filter masters');
  })
  .finally(function () {
    fcHydrate(true);
    fcShowPage();
  });
</script>
    </form>
</body>
</html>
