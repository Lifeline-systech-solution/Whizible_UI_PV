<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Plan_VS_Actual_DB.aspx.vb" Inherits="Whizible.Plan_VS_Actual_DB" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
        <!-- <%CommonFunctions.General.PlotPageHeadTag("Dashboard")%> -->
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Plan vs Actual Hours - Dashboard (Business Group / Organization Unit)</title>
<!-- Modify By Madhuri.K on 27-07-2026 - Replaced Department/Domain with Business Group/Organization Unit -->
<!-- Changed By Madhuri.K on 24-07-2026 - Align layout with My_Leaves.aspx (header, chart, action-bar, table, offcanvas) -->
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
<!-- Changed By Madhuri.K on 31-07-2026 - Use local Bootstrap / Font Awesome (removed online CDN) -->
<!-- Changed By Madhuri.K on 03-08-2026 - Paths are ../ from whizible-multipage (not ../../../ like Source/NewAPI pages) -->
<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.min.css">
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/v4-shims.min.css">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
<style>
  :root{
    --navy:#1e40af;
    --slate:#5b7089;
    --teal:#0f9b8e;
    --teal-light:#e3f5f2;
    --amber:#e0982f;
    --amber-light:#fbf1e0;
    --red:#d0473f;
    --red-light:#fbe9e7;
    --line:#e3e8ef;
    --text:#1a2536;
    --text-dim:#6b7280;
  }
  body{ margin:0; background:#fff; color:var(--text); font-size:11.5px; }
  .bgwhite{ font-size:11.5px!important; }
  .page-header-section{ margin-bottom:0!important; background:#fff; }
  /* Added By Madhuri.K on 07-08-2026 - Freeze title + filter bar while page content scrolls */
  .pva-sticky-top{
    position:sticky; top:0; z-index:200;
    background:#fff; box-shadow:0 1px 0 #e5e7eb;
  }
  .graybg{ padding:0.4rem 1rem; background:#F8FAFC; border-bottom:1px solid #ddd; }
  .card.leave-chart-card{ margin:0.75rem 1rem 1rem 1rem !important; border:1px solid #e5e7eb; overflow:hidden; }
  .card.leave-chart-card .card-header{ padding:0.5rem 1rem; font-size:12px; }
  /* Modified By Madhuri.K On 05-08-2026 - Auto-grow overview card so stacked charts do not overlap Analysis Table */
  .card.leave-chart-card .card-body{
    height:auto !important; min-height:0; overflow:hidden; padding-bottom:1rem !important;
  }
  /* Changed By Madhuri.K on 24-07-2026 - Top filter bar (filters left, action buttons right) */
  /* Added By Madhuri.K On 13-08-2026 - Purpose: Keep Save View / Clear View on the same top row as filters (right side) */
  .action-bar{
    background:#e7edf0; padding:0.65rem 1rem; margin:0;
    display:flex; align-items:flex-end; justify-content:space-between; gap:0.75rem; flex-wrap:nowrap;
    width:100%; box-sizing:border-box;
  }
  .action-bar .filter-group-wrap{
    display:flex; align-items:flex-end; gap:10px; flex-wrap:nowrap; flex:1 1 auto; min-width:0;
  }
  .action-bar .pva-filter-group{
    display:flex; flex-direction:column; gap:4px; min-width:0; flex:1 1 0;
  }
  .action-bar .pva-filter-group label{
    font-size:11px;  letter-spacing:.4px; color:#4b5563; font-weight:600; margin:0;
  }
  .action-bar .action-btns{
    display:flex; align-items:center; gap:0.35rem; flex-wrap:nowrap; flex:0 0 auto;
    /* Added By Madhuri.K On 13-08-2026 - Purpose: Always pin Save/Clear to the right corner */
    margin-left:auto; padding-bottom:1px; align-self:flex-end;
  }
  /* Added By Vishal.M on 12-08-2026 - Save default filter button next to Month dropdown */
  /* Modified By Vishal.M on 12-08-2026 - ghostbtn style (Save view) + Clear View beside Save */
  .action-bar .pva-filter-save-group{
    display:flex; flex-direction:column; gap:4px; min-width:auto; justify-content:flex-end;
  }
  .action-bar .pva-filter-save-group label{ visibility:hidden; height:14px; margin:0; }
  .action-bar .pva-filter-view-actions{
    display:flex; align-items:center; gap:8px; flex-wrap:wrap; height:34px;
  }
  .action-bar .ghostbtn{
    display:inline-flex; align-items:center; gap:7px;
    padding:0 13px; height:34px; border-radius:10px;
    border:1px solid #d1d5db; background:#fff;
    font-size:12px; font-weight:500; color:#0753eb;
    cursor:pointer; white-space:nowrap; transition:.15s;
  }
  .action-bar .ghostbtn:hover,
  .action-bar .ghostbtn:focus{
    color:#1a2536; border-color:#1359a6; background:#fff;
  }
  .action-bar .ghostbtn:disabled{ opacity:.65; cursor:wait; }
  .action-bar .ghostbtn i{ font-size:12px; line-height:1; }
  /* Modified By Madhuri.K On 13-08-2026 - Purpose: Keep Vishal Save/Clear group; compact + pin to right (top row) */
  .action-bar .action-btns .pva-filter-save-group{
    margin-left:0;
  }
  .action-bar .action-btns .pva-filter-save-group label{
    display:none; height:0; visibility:hidden;
  }
  .action-bar .action-btns .pva-filter-view-actions{
    gap:5px; flex-wrap:nowrap; height:30px;
  }
  .action-bar .action-btns .ghostbtn{
    gap:3px; padding:0 6px; height:30px; border-radius:6px;
    font-size:10.5px; line-height:1;
  }
  .action-bar .action-btns .ghostbtn i{ font-size:10px; }
  /* Added By Madhuri.K On 13-08-2026 - Purpose: Filter button label stays on one line (ellipsis if long) */
  .action-bar .pva-filter-group{ min-width:100px; }
  .action-bar .msel-btn{
    white-space:nowrap; overflow:hidden;
  }
  .action-bar .msel-btn > span:first-child,
  .action-bar .msel-btn{
    text-overflow:ellipsis;
  }
  .action-bar .msel-btn .chev,
  .action-bar .msel-btn .count{ flex-shrink:0; }
  /* Added By Madhuri.K On 13-08-2026 - Purpose: At ~1100px / 110% zoom keep Save View & Clear View on right corner */
  @media (max-width:1100px){
    .action-bar{
      flex-wrap:nowrap;
      gap:0.5rem;
    }
    .action-bar .filter-group-wrap{
      flex-wrap:nowrap; flex:1 1 auto; min-width:0;
    }
    .action-bar .pva-filter-group{ min-width:80px; flex:1 1 0; }
    .action-bar .action-btns{
      margin-left:auto; flex:0 0 auto; flex-shrink:0;
      justify-content:flex-end;
    }
    .action-bar .action-btns .ghostbtn{
      padding:0 5px; font-size:10px; height:28px;
    }
  }
  @media (max-width:768px){
    .action-bar{ flex-wrap:wrap; }
    .action-bar .filter-group-wrap{ flex:1 1 100%; flex-wrap:wrap; }
    .action-bar .action-btns{
      width:100%; margin-left:auto; justify-content:flex-end;
    }
  }
  .card.leave-chart-card{ margin:0.75rem 1rem 1rem 1rem !important; }
  .content{ margin:0 1rem; position:relative; z-index:1; clear:both; }
  /* Changed By Madhuri.K on 24-07-2026 - KPI + Trend sections on main page */
  .main-section{
    margin:0.75rem 1rem 0 1rem; background:#fff; border:1px solid #e5e7eb; border-radius:6px; overflow:hidden;
  }
  .main-section-header{
    display:flex; align-items:center; justify-content:space-between; gap:12px; flex-wrap:nowrap;
    padding:0.65rem 1rem; background:#F8FAFC; border-bottom:1px solid #e5e7eb;
  }
  .main-section-header h3{
    margin:0; color:#1e40af; font-size:13px; font-weight:600;
    display:flex; align-items:center; gap:0.5rem; white-space:nowrap; flex:0 1 auto; min-width:0;
  }
  .main-section-header h3 i{ font-size:1rem; flex-shrink:0; }
  .main-section-body{ padding:1rem; }
  .kpi-intro{ color:#6b7280; font-size:11.5px; margin:0 0 0.75rem 0; }
  .table-toolbar{
    display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:8px;
    padding:0.75rem 0 0.5rem;
  }
  .table-toolbar h3{ margin:0; color:#1e40af; font-size:14px; font-weight:600; }
  .pagination-container{
    background:#fff; display:flex; justify-content:flex-end; align-items:center;
    padding:0.35rem 0.75rem; gap:0.5rem; border-top:1px solid #eee; margin:0.5rem 1rem 1rem;
    min-height:0;
  }
  /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
  .analysis-pagination .pagination-actions{
    display:flex; align-items:center; gap:0.35rem;
  }
  .analysis-pagination .total-records{
   /* Modify By Madhuri.K on 21-08-2026 */
    color:#6b7280; font-size:11px; line-height:1.2;
  }
  #analysisPagination.pagination-container{
    padding:0.25rem 0.65rem !important; min-height:28px; height:auto;
    justify-content:flex-end !important; gap:0.5rem;
  }
  /* Match Trend & Heatmap: Total Records on the right (with Prev/Next) for all Analysis tabs */
  #analysisPagination #analysisTotalRecords,
  #analysisPagination .total-records{
    margin:0 !important; margin-right:0 !important; margin-left:0 !important;
    font-size:11.5px; line-height:1; white-space:nowrap;
  }
  #analysisPagination .btn.borderbtn,
  #analysisPagination .btn-sm{
    padding:1px 6px !important; font-size:10.5px !important; height:22px !important;
    min-height:22px !important; line-height:1.1 !important;
  }
  .borderbtn{
    background:#fff; border:1px solid #1359a6; color:#1359a6; font-weight:500;
    font-size:11.5px!important; padding:4px 10px; border-radius:4px; cursor:pointer;
  }
  .borderbtn:hover,.borderbtn:focus{ background:#1359a6!important; color:#fff!important; border-color:#1359a6!important; }
   /* Modify By Madhuri.K on 21-08-2026 */
  /* Disabled Prev/Next: no-drop cursor when no data / no previous or next page */
  .borderbtn:disabled,
  .borderbtn[disabled],
  #trendPagination .btn:disabled,
  #trendPagination .btn[disabled],
  #analysisPagination .btn:disabled,
  #analysisPagination .btn[disabled]{
    opacity:.45; cursor:no-drop !important; pointer-events:auto;
  }
  .borderbtn:disabled:hover,
  .borderbtn[disabled]:hover,
  #trendPagination .btn:disabled:hover,
  #trendPagination .btn[disabled]:hover,
  #analysisPagination .btn:disabled:hover,
  #analysisPagination .btn[disabled]:hover{
    background:#fff !important; color:#1359a6 !important; border-color:#1359a6 !important;
    cursor:no-drop !important;
  }
  .clearalllink{ text-decoration:underline; cursor:pointer; color:#0d6efd; font-size:11.5px; font-weight:600; }
  /* Changed By Madhuri.K on 24-07-2026 - Nice offcanvas headers (My_Leaves style) + Trend tabs right-aligned */
  .offcanvas-header.graybg{
    display:flex; align-items:center; justify-content:space-between;
    padding:0.75rem 1rem !important; background:#F8FAFC !important;
    border-bottom:1px solid #e5e7eb; min-height:52px;
  }
  .offcanvas-title{
    font-size:16px !important; color:#1e40af !important; font-weight:600 !important;
    margin:0 !important; display:flex; align-items:center; gap:0.5rem; line-height:1.3;
  }
  .offcanvas-title i{ font-size:1.1rem; color:#1e40af; }
  .offcanvas-70{ --bs-offcanvas-width:70%; }
  .offcanvas-85{ --bs-offcanvas-width:85%; }
  .offcanvas-body{ padding:1rem 1.25rem; }
  .trend-level-toolbar{
    display:flex; justify-content:flex-end; align-items:center; gap:10px;
    flex-wrap:nowrap; margin:0; width:auto; flex:0 0 auto; margin-left:auto;
  }
  .trend-level-toolbar .trend-level-label{
    font-size:12px; font-weight:600; color:#374151; margin:0; white-space:nowrap;
  }
  .main-section-header .level-tabs{ flex-shrink:0; }

  /* Modify By Madhuri.K on 27-07-2026 - Project dropdown below Trend by level tabs (By Project) */
  /* Modify By Madhuri.K on 03-08-2026 - Multi-select with search (same msel pattern as top filters) */
  .trend-project-filter{
    display:none; align-items:center; gap:8px; flex-wrap:nowrap;
    margin:0 0 12px 0; padding:0;
  }
  .trend-project-filter label{
    font-size:11px; font-weight:600; color:#374151; margin:0; white-space:nowrap;
  }
  .trend-project-filter select{
    background:#fff; border:1px solid #d1d5db; border-radius:4px; padding:5px 8px;
    font-size:11.5px; color:#1a2536; min-width:220px; max-width:360px; height:32px;
  }
  .trend-project-filter .msel{ min-width:260px; max-width:360px; width:260px; }
  .trend-project-filter .msel-panel{ min-width:260px; z-index:1060; }

  .kpi-intro{
    color:#6b7280; font-size:11.5px; margin:0 0 1rem 0; padding:0;
    background:none; border:none;
  }

  .msel{ position:relative; }
  .msel-btn{
    width:100%; text-align:left; background:#fff; border:1px solid #d1d5db;
    border-radius:4px; padding:6px 8px; font-size:11.5px; cursor:pointer; color:var(--text);
    display:flex; justify-content:space-between; align-items:center; gap:8px; height:34px;
    /* Added By Madhuri.K On 13-08-2026 - Purpose: Keep dropdown selected/placeholder text on one line */
    white-space:nowrap; overflow:hidden;
  }
  .msel-btn > span:first-child{
    min-width:0; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
  }
  .msel-btn:hover{ border-color:#1359a6; }
  .msel-btn .count{ background:#1359a6; color:#fff; border-radius:10px; font-size:10px; padding:1px 7px; font-weight:600; }
  .msel-btn .chev{ color:var(--text-dim); font-size:10px; line-height:1; }
  .msel-btn .chev i{ font-size:10px; }
  .msel-panel{
    position:absolute; top:calc(100% + 4px); left:0; min-width:220px; max-height:260px; overflow-y:auto;
    background:#fff; border:1px solid var(--line); border-radius:6px; box-shadow:0 8px 24px rgba(20,30,50,.14);
    padding:8px; z-index:1055; display:none;
  }
  .msel-panel.open{ display:block; }
  /* Added By Madhuri.K on 30-07-2026 - Search box pinned to top of the scrollable options list */
  .msel-search{
    width:100%; box-sizing:border-box; border:1px solid var(--line); border-radius:4px;
    padding:6px 8px; font-size:11.5px; margin-bottom:6px; position:sticky; top:-8px; background:#fff; z-index:2;
  }
  .msel-search:focus{ outline:none; border-color:#1359a6; }
  .msel-empty{ padding:10px 8px; font-size:11.5px; color:var(--text-dim); text-align:center; }
  .msel-row{ display:flex; align-items:center; gap:8px; padding:6px 8px; border-radius:4px; cursor:pointer; font-size:11.5px; }
  .msel-row:hover{ background:#f1f5f9; }
  /* Added By Madhuri.K On 06-08-2026 - Selected row highlight (legacy single-select; multi-select uses checkboxes) */
  .msel-row.selected{ background:#EEF2FF; color:#1e40af; font-weight:600; }
  .msel-actions{ display:flex; justify-content:space-between; padding:4px 6px 2px; border-top:1px solid var(--line); margin-top:6px; }
  .msel-actions button{ background:none; border:none; color:#1359a6; font-size:11.5px; cursor:pointer; font-weight:600; padding:4px; }

  .kpi-row{ display:grid; grid-template-columns:repeat(auto-fit,minmax(180px,1fr)); gap:12px; margin-bottom:16px; }
  .kpi{
    background:#fff; border:1px solid var(--line); border-radius:8px; padding:14px 16px;
    position:relative; overflow:hidden;
  }
  .kpi::before{ content:""; position:absolute; left:0; top:0; bottom:0; width:4px; background:var(--kpi-accent,#1359a6); }
  .kpi .lbl{ font-size:11px; color:var(--text-dim); font-weight:600;  letter-spacing:.4px; }
  .kpi .val{ font-size:15px; font-weight:700; margin-top:6px; color:#1e40af; }
  .kpi .sub{ font-size:11.5px; margin-top:4px; color:var(--text-dim); }
  .kpi .sub.pos{ color:var(--teal); }
  .kpi .sub.neg{ color:var(--red); }
  /* Added By Madhuri.K on 07-08-2026 - Under-plan subtitle matches heatmap amber band */
  .kpi .sub.under{ color:var(--amber); }

  /* Modified By Madhuri.K On 05-08-2026 - Contain overview charts on resize; grid grows instead of overflowing */
  /* Added By Madhuri.K On 13-08-2026 - Purpose: Overview - Plan vs Actual show 2 equal graphs per row (same width & height) */
  /* Modified By Madhuri.K On 13-08-2026 - Purpose: Keep 2 graphs per row at ~1100px / 110% zoom (do not stack 1-by-1) */
  .overview-chart-body{ width:100%; box-sizing:border-box; }
  .chart-grid{
    display:grid !important;
    grid-template-columns:repeat(2, minmax(0, 1fr)) !important;
    gap:12px;
    height:auto; width:100%; align-items:stretch;
    box-sizing:border-box;
  }
  .chart-box{
    position:relative; height:320px; min-width:0; width:100%;
    overflow:hidden; background:#fff; box-sizing:border-box;
  }
  .chart-box canvas{ display:block; max-width:100% !important; height:100% !important; }
  @media (max-width:1100px){
    .chart-grid{
      grid-template-columns:repeat(2, minmax(0, 1fr)) !important;
      gap:10px;
    }
    .chart-box{ height:300px; }
  }
  @media (max-width:575.98px){
    .chart-grid{ grid-template-columns:minmax(0, 1fr) !important; }
    .chart-box{ height:260px; }
  }

  .level-tabs{ display:flex; gap:6px; background:#f1f4f8; padding:4px; border-radius:8px; }
  .level-tabs button{
    border:none; background:none; padding:6px 12px; border-radius:6px; font-size:11.5px; font-weight:600;
    color:var(--text-dim); cursor:pointer;
  }
  .level-tabs button.active{ background:#fff; color:#1e40af; box-shadow:0 1px 3px rgba(20,30,50,.12); }

  .newTblStyle{ width:100%; border-collapse:collapse; font-size:11.5px; margin:0; }
  .newTblStyle thead th{
    background:#f8f9fa; color:#374151; font-weight:600; font-size:11px;
    text-align:left; padding:4px 8px; border-bottom:1px solid #e5e7eb; cursor:pointer; white-space:nowrap;
    line-height:1.2; height:auto;
  }
  /* Added By Madhuri.K On 11-08-2026 - Sort arrow stays on same line as header text */
  .newTblStyle thead th .th-inner{
    display:inline-flex; align-items:center; gap:4px; white-space:nowrap; max-width:100%;
  }
  .newTblStyle thead th .th-text{ white-space:nowrap; }
  .newTblStyle thead th .arrow{
    opacity:.55; font-size:10px; line-height:1; flex:0 0 auto; display:inline-block;
  }
  .newTblStyle tbody td{ padding:8px 10px; border-bottom:1px solid #f0f2f5; vertical-align:middle; font-size:11.5px; }
  .newTblStyle tbody tr:hover{ background:#f8fafc; }
  .newTblStyle tfoot td{ padding:8px 10px; font-weight:700; background:#f8f9fa; border-top:2px solid #e5e7eb; color:#1e40af; }
  .newTblStyle td.num, .newTblStyle th.num{ text-align:right; font-variant-numeric:tabular-nums; }
  .newTblStyle thead th .arrow{ opacity:.45; font-size:10px; margin-left:3px; }
  .table-scroll{ max-height:480px; overflow:auto; border:1px solid #e5e7eb; border-radius:6px; }
  .table-scroll .newTblStyle thead th{ position:sticky; top:0; z-index:2; }
  .empty-state{ padding:32px 16px; text-align:center; color:var(--text-dim); }
  /* Added By Madhuri.K On 11-08-2026 / 13-08-2026 - Purpose: Var % value + status badge always stay on one line (no wrap when Project name is long) */
  .newTblStyle td.num.var-pct{ white-space:nowrap; min-width:9.5rem; }
  .newTblStyle td.num.var-pct .var-pct-wrap{
    display:inline-flex; align-items:center; justify-content:flex-end; gap:6px; white-space:nowrap;
  }
  .badge-var{
    padding:2px 8px; border-radius:10px; font-weight:600; font-size:11px;
    white-space:nowrap; display:inline-block; flex:0 0 auto;
  }
  .badge-var.over{ background:var(--red-light); color:var(--red); }
  .badge-var.under{ background:var(--amber-light); color:var(--amber); }
  .badge-var.ok{ background:var(--teal-light); color:var(--teal); }

  .trend-chart-box{ position:relative; height:360px; margin-bottom:12px; border:1px solid var(--line); border-radius:8px; padding:12px 10px 6px; background:#fff; }
  /* Modified By Madhuri.K On 06-08-2026 - Sticky first column (Business Group / OU / Project) on horizontal scroll */
  /* Added By Madhuri.K On 21-08-2026 - Heatmap panel: freeze header + pagination; scroll data rows */
  .heatmap-panel{
    border:1px solid var(--line); border-radius:8px; overflow:hidden; background:#fff;
    display:flex; flex-direction:column;
  }
  .heatmap-wrap{
    /* Fixed height (~half of prior 420) so gap is smaller but Prev/Next does not jump */
    overflow:auto; height:210px; min-height:210px; max-height:210px;
    border:none; border-radius:0; flex:0 0 auto;
  }
  .heatmap-table{
    border-collapse:separate; border-spacing:0; width:100%; font-size:11.5px; min-width:640px;
  }
  .heatmap-table thead th{
    padding:2px 6px !important; background:#f8f9fa; color:var(--text-dim); font-weight:600;
    font-size:9.5px !important; letter-spacing:.2px; text-align:center; line-height:1.15;
    border-bottom:1px solid var(--line); white-space:nowrap;
    position:sticky; top:0; z-index:4; height:22px;
  }
  .heatmap-table th:first-child{
    text-align:left; position:sticky; left:0; top:0; z-index:5;
    background:#f8f9fa; box-shadow:2px 0 4px rgba(20,30,50,.06);
  }
  .heatmap-table td{ padding:5px 6px; border-bottom:1px solid #f0f2f5; text-align:center; }
  .heatmap-table td.entity{
    text-align:left; font-weight:600; color:#1e40af; background:#fff;
    position:sticky; left:0; z-index:2; white-space:nowrap; padding:8px 10px;
    box-shadow:2px 0 4px rgba(20,30,50,.06);
  }
  .heatmap-cell{
    font-weight:600; font-size:11px; border-radius:4px; padding:6px 4px; color:#1a2536; min-width:52px;
  }
   /* Modify By Madhuri.K on 21-08-2026 */
  .heatmap-panel .heatmap-legend{
    margin:0; padding:2px 8px !important; border-top:1px solid #f0f2f5; flex:0 0 auto;
    font-size:10px; gap:6px; min-height:0; line-height:1.2;
  }
  .heatmap-panel .heatmap-legend .scale{ height:6px; width:90px; }
  .heatmap-panel .heatmap-pagination,
  .heatmap-panel #trendPagination.pagination-container,
  .heatmap-panel #trendPagination{
    margin:0 !important; padding:2px 8px !important; min-height:26px !important; height:26px;
    border-top:1px solid #eee; border-radius:0; background:#fff;
    flex:0 0 auto; justify-content:flex-end; gap:0.4rem !important;
    align-items:center !important; box-sizing:border-box;
  }
  .heatmap-panel #trendPagination .total-records,
  .heatmap-panel #trendTotalRecords{
    font-size:10.5px !important; line-height:1 !important; margin:0 !important;
  }
  .heatmap-panel #trendPagination .btn,
  .heatmap-panel #trendPagination .btn.borderbtn,
  .heatmap-panel #trendPagination .btn-sm{
    padding:0 5px !important; font-size:10px !important; line-height:1 !important;
    height:20px !important; min-height:20px !important; max-height:20px !important;
  }
  .heatmap-panel #trendPagination .btn i{ font-size:10px; line-height:1; }
  .heatmap-legend{ display:flex; align-items:center; gap:10px; font-size:11px; color:var(--text-dim); margin-top:10px; flex-wrap:wrap; }
  .heatmap-legend .scale{ display:flex; align-items:center; height:10px; width:140px; border-radius:5px;
    background:linear-gradient(90deg, var(--amber) 0%, var(--teal-light) 50%, var(--red) 100%); }
  .line-style-note{
    display:inline-flex; align-items:center; gap:8px; background:var(--teal-light);
    border:1px solid #bfe4de; border-radius:8px; padding:8px 14px; font-size:11.5px;
    font-weight:600; color:#1e40af; margin:2px 0 12px;
  }
  .alert.alert-light.border{ font-size:11.5px; }
  /* Added By Madhuri.K On 06-08-2026 - Custom hover tooltip for Plan vs Actual charts (SS style) */
  /* Modified By Madhuri.K On 10-08-2026 - Tip head shows full entity name (no ellipsis truncate) */
  .pva-chart-tooltip{
    position:absolute; pointer-events:none; z-index:2200; min-width:150px; max-width:420px;
    border-radius:6px; overflow:hidden; opacity:0; transition:opacity .12s ease;
    box-shadow:0 8px 20px rgba(20,30,50,.2); font-size:12px; line-height:1.35;
  }
  .pva-chart-tooltip.open{ opacity:1; }
  .pva-chart-tooltip .tip-head{
    background:#1e40af; color:#fff; font-weight:700; padding:8px 12px;
    white-space:normal; overflow:visible; text-overflow:clip; word-break:break-word;
  }
  .pva-chart-tooltip .tip-body{ background:#fff; padding:8px 12px 10px; }
  .pva-chart-tooltip .tip-row{
    display:flex; justify-content:space-between; align-items:flex-start; gap:18px; padding:3px 0;
  }
  .pva-chart-tooltip .tip-lbl{
    color:#1a2536; font-weight:500; white-space:normal; word-break:break-word; flex:1 1 auto; min-width:0;
  }
  .pva-chart-tooltip .tip-val{ font-weight:700; }
  .pva-chart-tooltip .tip-val.planned{ color:#2a78d6; }
  .pva-chart-tooltip .tip-val.actual{ color:#eb6834; }
  .pva-chart-tooltip .tip-val.other{ color:#1e40af; }
  /* Page-load loader (same pattern as MyAlerts.aspx) */
  .loader-overlay{
    position:fixed; top:0; left:0; right:0; bottom:0;
    width:100%; height:100%; background-color:transparent; z-index:2000;
  }
  .loader-overlay .loader{
    position:absolute; top:50%; left:50%; width:100px; height:100px;
    margin:-50px 0 0 -50px;
    background:url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
  }
  .preloader{
    position:fixed; top:50%; left:50%; width:100px; height:100px;
    margin:-50px 0 0 -50px;
    background:url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
    z-index:2100;
  }
</style>
</head>
<body>
    <form id="form1" runat="server">
<div id="AnalyticsPreloader" class="preloader" aria-label="Loading"></div>
<div class="loader-overlay" id="loaderOverlay" style="display:none;"><div class="loader"></div></div>
       <!-- Changed By Madhuri.K on 24-07-2026 - Page shell aligned with My_Leaves.aspx -->
<div class="bgwhite" id="AnalyticsWrapper" style="display:none;">
  <!-- Added By Madhuri.K on 07-08-2026 - Sticky wrapper for title + filters -->
  <div class="pva-sticky-top">
  <div class="page-header-section" style="background:white;">
    <div class="graybg" style="padding:0.4rem 1rem; margin-left:0;">
      <h2 style="color:#1e40af; font-weight:600; font-size:18px; margin:0 0 0.25rem 0; display:flex; align-items:center;">
        <i class="fas fa-chart-bar" style="color:#1e40af; font-size:1.5rem; margin-right:0.75rem;"></i>
        Plan vs Actual
      </h2>
      <p style="color:#6b7280; margin:0;">Business Group &rarr; Organization Unit &rarr; Project &middot; Resource utilization tracking</p>
    </div>
  </div>

  <!-- Modify By Madhuri.K on 27-07-2026 - Filter bar at top (KPIs, Trend, Quarterly all on main page) -->
  <!-- Modified By Madhuri.K On 13-08-2026 - Purpose: Save View / Clear View on top row (right of filters) -->
  <div class="action-bar">
    <div class="filter-group-wrap" id="filterBar"></div>
    <div class="action-btns" id="filterViewActions"></div>
  </div>
  </div>

  <!-- Changed By Madhuri.K on 24-07-2026 - KPI Summary on main page -->
  <div class="main-section" id="sectionKPIs">
    <div class="main-section-header">
      <h3><i class="fas fa-tachometer-alt"></i> KPI Summary</h3>
    </div>
    <div class="main-section-body">
      <p class="kpi-intro">Plan vs Actual KPIs for the current filter selection.</p>
      <div class="kpi-row" id="kpiRow"></div>
    </div>
  </div>

    <!-- Changed By Madhuri.K on 24-07-2026 - Trend & Heatmap on main page; tabs right-aligned -->
    <div class="main-section" id="sectionTrend">
      <div class="main-section-header">
        <h3><i class="fas fa-chart-line"></i> Planned vs Actual - Trend &amp; Heatmap</h3>
        <!-- Changed By Madhuri.K on 24-07-2026 - Title + Trend by level tabs on one line -->
        <div class="trend-level-toolbar">
          <span class="trend-level-label">Trend by level</span>
          <div class="level-tabs" id="trendLevelTabs">
            <button data-level="businessGroup" class="active" type="button">Business Group</button>
            <button data-level="organizationUnit" type="button">Organization Unit</button>
            <button data-level="project" type="button">Project</button>
          </div>
        </div>
      </div>
      <div class="main-section-body">
        <!-- Modify By Madhuri.K on 27-07-2026 / 03-08-2026 - Multi-select Project filter for Trend By Project -->
        <div class="trend-project-filter" id="trendProjectFilterWrap">
          <label>Project</label>
          <div id="trendProjectMselHost"></div>
        </div>
        <div class="trend-chart-box" id="pvaTrendChartBox"><canvas id="chartPvaTrend"></canvas></div>
        <div class="line-style-note">Solid line = Actual hours &middot; Dotted line = Planned hours &middot; same color per entity.</div>
        <!-- Added By Madhuri.K On 21-08-2026 - Heatmap: frozen header + pagination; scrollable data -->
        <div class="heatmap-panel">
          <div class="heatmap-wrap" id="pvaHeatmapWrap"></div>
          <div class="heatmap-legend">
            <span>Variance vs Plan:</span>
            <div class="scale"></div>
            <span>Under-plan (amber) &middot; On-plan (teal) &middot; Over-plan (red)</span>
          </div>
          <div class="pagination-container analysis-pagination heatmap-pagination" id="trendPagination">
            <span id="trendTotalRecords" class="total-records" style="color:#6b7280; font-size:11.5px; margin-right:auto;">Total Records: 0</span>
            <div class="pagination-actions">
              <button type="button" class="btn borderbtn btn-sm"
                id="trendPrevBtn"
                onclick="goToPreviousTrendPage()"
                title="Previous Page"
                disabled>
                <i class="fas fa-angle-double-left"></i>
              </button>
              <button type="button" class="btn borderbtn btn-sm"
                id="trendNextBtn"
                onclick="goToNextTrendPage()"
                title="Next Page"
                disabled>
                <i class="fas fa-angle-double-right"></i>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

  <div class="card leave-chart-card">
    <div class="card-header bg-light">
      <strong>Overview - Plan vs Actual</strong>
      <span class="text-muted ms-2" style="font-size:11px; font-weight:400;">Charts respond to the filters below</span>
    </div>
    <div class="card-body px-3 overview-chart-body">
      <div class="chart-grid">
        <div class="chart-box"><canvas id="chartDept"></canvas></div>
        <div class="chart-box"><canvas id="chartDomain"></canvas></div>
        <div class="chart-box"><canvas id="chartProject"></canvas></div>
      </div>
    </div>
  </div>

    <div class="content">
    <div class="table-toolbar">
      <h3>Analysis Table</h3>
      <div class="level-tabs" id="levelTabs">
        <!-- Modify By Madhuri.K on 27-07-2026 - Tab sequence: Project, Business Group, Organization Unit, Resource -->
        <button data-level="project" class="active" type="button">Project</button>
        <button data-level="businessGroup" type="button">Business Group</button>
        <button data-level="organizationUnit" type="button">Organization Unit</button>
        <button data-level="resource" type="button">Resource</button>
      </div>
    </div>
    <!-- Added By Madhuri.K on 31-07-2026 - Project/Resource drill-down dropdowns for their Analysis Table tabs -->
    <!-- Modified By Madhuri.K On 06-08-2026 - Searchable dropdown (msel) instead of plain select -->
    <!-- Modified By Madhuri.K On 07-08-2026 - Project / Resource are multi-select (checkboxes) -->
    <div class="trend-project-filter" id="analysisProjectFilterWrap">
      <label>Project</label>
      <div id="analysisProjectMselHost"></div>
    </div>
    <div class="trend-project-filter" id="analysisResourceFilterWrap">
      <label>Resource</label>
      <div id="analysisResourceMselHost"></div>
    </div>
    <div class="table-scroll">
      <table class="table table-hover newTblStyle" id="analysisTbl" style="width:100%;">
        <thead><tr id="tableHead"></tr></thead>
        <tbody id="tableBody"></tbody>
        <tfoot><tr id="tableFoot"></tr></tfoot>
      </table>
    </div>
  </div>

  <!-- Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown -->
  <div class="pagination-container analysis-pagination" id="analysisPagination">
    <span id="analysisTotalRecords" class="total-records" style="color:#6b7280; font-size:11.5px;">Total Records: 0</span>
    <div class="pagination-actions">
      <button type="button" class="btn borderbtn btn-sm"
        id="analysisPrevBtn"
        onclick="goToPreviousAnalysisPage()"
        title="Previous Page"
        disabled>
        <i class="fas fa-angle-double-left"></i>
      </button>
      <button type="button" class="btn borderbtn btn-sm"
        id="analysisNextBtn"
        onclick="goToNextAnalysisPage()"
        title="Next Page"
        disabled>
        <i class="fas fa-angle-double-right"></i>
      </button>
    </div>
  </div>
</div>

<!-- Changed By Madhuri.K on 31-07-2026 - Use local Bootstrap / Chart.js (removed online CDN) -->
<!-- Changed By Madhuri.K on 03-08-2026 - Correct relative path from whizible-multipage; Chart.js needs no CSS file -->
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>


<script>
const MONTH_NAMES = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

// Added By Madhuri.K on 29-07-2026 - Top filter bar master data (Business Group / Organization Unit / Project) via API
var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
if(strUrl.endsWith('/')){ strUrl = strUrl.slice(0, -1); }
var LOGIN_ID = '<%= Session("intLoginID") %>';
// Added By Vishal.M on 12-08-2026 - Session keys used when saving/applying default filters
var SessionEmployeeID = '<%= Session("intUserID") %>';
var SessionProjectID = '<%= Session("intProjectID") %>';
var PVA_PAGE_KEY = "Plan_VS_Actual_DB";
// Modified By Vishal.M on 12-08-2026 - DashboardID from query string (FilterTagId) so Get/Save use the same key
function getQueryParam(name){
  try {
    var params = new URLSearchParams(window.location.search || "");
    return params.get(name) || "";
  } catch(e){ return ""; }
}
var DashboardID = String(getQueryParam("FilterTagId") || getQueryParam("terTagId") || getQueryParam("DashboardID") || "21039");

// Business Group -> Organization Units it owns; Project -> Organization Units it uses.
// Populated from /api/PlanVsActualDashboard/GetFilterMasters (see buildFilterMasterStructures below).
let BG_STRUCTURE = {};
let OU_TO_BG = {};
let PROJECT_OUS = {};
let PROJECT_BUSINESS_GROUPS = {};

// Name -> ID lookups (built alongside the structures above) so the KPI Summary API call
// can send the IDs it expects even though the filter bar tracks selections by display name.
let BG_NAME_TO_ID = {};
let OU_NAME_TO_ID = {};
let PROJECT_NAME_TO_ID = {};

// Added By Madhuri.K On 07-08-2026 - Preserve GetFilterMasters API order + exact display labels
let BG_ORDER = [];
let OU_ORDER = [];
let PROJECT_ORDER = [];
let FY_ORDER = [];
let FY_LABELS = {};
let MONTH_ORDER = [];
let MONTH_LABELS = {};
let MONTH_TO_FY = {};

// rows = the API's "data" object: { BusinessGroupMasterModel, OrganizationUnitMasterModel, ProjectMasterModel, ... }.
// Organization Units are joined to Business Groups by businessGroupID (the same OU can legitimately
// appear under more than one Business Group, e.g. "Development" under both Products and Services).
// Added By Madhuri.K On 10-08-2026 - "NA" / unassigned (null/0) BG & OU must still cascade into
// Project (and OU) dropdowns; otherwise selecting Business Group = NA left Project as "No matches"
// and KPI/summary calls went out without a usable businessGroupIDs value.
function isNaFilterLabel(name){
  if(name == null || name === "") return false;
  const n = String(name).trim().toLowerCase();
  return n === "na" || n === "n/a" || n === "n.a." || n === "n.a" || n === "not applicable";
}
function findNaLabel(orderList){
  if(!orderList || !orderList.length) return null;
  for(let i = 0; i < orderList.length; i++){
    if(isNaFilterLabel(orderList[i])) return orderList[i];
  }
  return null;
}
function isUnassignedMasterId(id){
  return id == null || id === "" || id === 0 || id === "0";
}
function masterIdKey(id){
  if(id == null || id === "") return null;
  return String(id);
}
function resolveNameById(idMap, id){
  const key = masterIdKey(id);
  if(key == null) return null;
  if(idMap[key] != null) return idMap[key];
  if(idMap[id] != null) return idMap[id];
  return null;
}

function buildFilterMasterStructures(data){
  BG_STRUCTURE = {};
  OU_TO_BG = {};
  PROJECT_OUS = {};
  PROJECT_BUSINESS_GROUPS = {};
  BG_NAME_TO_ID = {};
  OU_NAME_TO_ID = {};
  PROJECT_NAME_TO_ID = {};
  BG_ORDER = [];
  OU_ORDER = [];
  PROJECT_ORDER = [];
  FY_ORDER = [];
  FY_LABELS = {};
  MONTH_ORDER = [];
  MONTH_LABELS = {};
  MONTH_TO_FY = {};

  const bgList = apiArray(data, "BusinessGroupMasterModel", "businessGroupMasterModel");
  const ouList = apiArray(data, "OrganizationUnitMasterModel", "organizationUnitMasterModel");
  const projectList = apiArray(data, "ProjectMasterModel", "projectMasterModel");
  const fyList = apiArray(data, "FinancialYearMasterModel", "financialYearMasterModel");
  const monthList = apiArray(data, "MonthMasterModel", "monthMasterModel");

  const bgIdToName = {};
  bgList.forEach(bg => {
    const bgName = apiVal(bg, "businessGroupName", "BusinessGroupName");
    let bgId = apiVal(bg, "businessGroupID", "BusinessGroupID");
    if(bgName == null || bgName === "") return;
    // NA placeholder often arrives with null/empty ID; treat as 0 so filter APIs still receive an ID
    if(isNaFilterLabel(bgName) && isUnassignedMasterId(bgId)) bgId = 0;
    const idKey = masterIdKey(bgId);
    if(idKey != null) bgIdToName[idKey] = bgName;
    if(!(bgName in BG_STRUCTURE)){
      BG_STRUCTURE[bgName] = [];
      BG_ORDER.push(bgName);
    }
    BG_NAME_TO_ID[bgName] = bgId;
  });
  const naBgName = findNaLabel(BG_ORDER);

  // key: "<organizationUnitID>|<businessGroupID>" -> organizationUnitName, so Projects can be
  // joined to the exact OU-within-BG row that ProjectMasterModel references.
  const ouKeyToName = {};
  const ouIdToName = {};
  ouList.forEach(ou => {
    const ouName = apiVal(ou, "organizationUnitName", "OrganizationUnitName");
    let ouId = apiVal(ou, "organizationUnitID", "OrganizationUnitID");
    const bgId = apiVal(ou, "businessGroupID", "BusinessGroupID");
    if(ouName == null || ouName === "") return;
    if(isNaFilterLabel(ouName) && isUnassignedMasterId(ouId)) ouId = 0;
    let bgName = resolveNameById(bgIdToName, bgId);
    // Modified By Madhuri.K On 10-08-2026 - Do not attach every null/0-BG OU under NA
    // (that pulled unrelated OUs like "Consulting" into the NA cascade).
    // Ambiguous id 0/null → NA only for the OU placeholder named NA; real OUs must
    // resolve to NA via a proper Business Group ID (or via NA projects below).
    if(bgName && isNaFilterLabel(bgName) && isUnassignedMasterId(bgId) && !isNaFilterLabel(ouName)){
      bgName = null;
    }
    if(!bgName && naBgName && isUnassignedMasterId(bgId) && isNaFilterLabel(ouName)){
      bgName = naBgName;
    }
    if(bgName){
      if(!BG_STRUCTURE[bgName]) BG_STRUCTURE[bgName] = [];
      if(BG_STRUCTURE[bgName].indexOf(ouName) === -1){
        BG_STRUCTURE[bgName].push(ouName);
      }
      const bgKey = masterIdKey(bgId != null && bgId !== "" ? bgId : (isNaFilterLabel(bgName) ? 0 : bgId));
      const ouKey = masterIdKey(ouId);
      if(ouKey != null && bgKey != null) ouKeyToName[ouKey + "|" + bgKey] = ouName;
      if(!OU_TO_BG[ouName]) OU_TO_BG[ouName] = bgName;
    }
    if(OU_ORDER.indexOf(ouName) === -1) OU_ORDER.push(ouName);
    if(!(ouName in OU_NAME_TO_ID)) OU_NAME_TO_ID[ouName] = ouId;
    // Fallback: organizationUnitID -> name, regardless of which BG row it came from. A project's own
    // businessGroupID/organizationUnitID pair isn't guaranteed to also appear as its own row in
    // OrganizationUnitMasterModel; without this fallback such a project got silently dropped from
    // PROJECT_OUS/PROJECT_BUSINESS_GROUPS, so it vanished from the Project dropdown the moment its
    // Business Group was selected (it only showed with no BG filter, where this join isn't checked).
    const ouIdKey = masterIdKey(ouId);
    if(ouIdKey != null && !(ouIdKey in ouIdToName)) ouIdToName[ouIdKey] = ouName;
  });
  const naOuName = findNaLabel(OU_ORDER);
  // Ensure NA Business Group always lists its NA Organization Unit dependent
  if(naBgName && naOuName){
    if(!BG_STRUCTURE[naBgName]) BG_STRUCTURE[naBgName] = [];
    if(BG_STRUCTURE[naBgName].indexOf(naOuName) === -1) BG_STRUCTURE[naBgName].push(naOuName);
    if(!OU_TO_BG[naOuName]) OU_TO_BG[naOuName] = naBgName;
  }

  projectList.forEach(p => {
    const projectName = apiVal(p, "projectName", "ProjectName");
    const projectId = apiVal(p, "projectID", "ProjectID");
    if(projectName == null || projectName === "") return;
    // Modified By Madhuri.K On 07-08-2026 - Include all projects in API order (even null BG/OU)
    if(PROJECT_ORDER.indexOf(projectName) === -1) PROJECT_ORDER.push(projectName);
    if(!(projectName in PROJECT_NAME_TO_ID)) PROJECT_NAME_TO_ID[projectName] = projectId;
    if(!PROJECT_OUS[projectName]) PROJECT_OUS[projectName] = [];
    if(!PROJECT_BUSINESS_GROUPS[projectName]) PROJECT_BUSINESS_GROUPS[projectName] = new Set();

    const bgId = apiVal(p, "businessGroupID", "BusinessGroupID");
    const ouId = apiVal(p, "organizationUnitID", "OrganizationUnitID");
    const bgNameFromApi = apiVal(p, "businessGroupName", "BusinessGroupName");
    const ouNameFromApi = apiVal(p, "organizationUnitName", "OrganizationUnitName");
    let bgName = resolveNameById(bgIdToName, bgId) || (bgNameFromApi != null && bgNameFromApi !== "" ? bgNameFromApi : null);
    // Null/0 BG on a project = "NA" Business Group (so selecting NA still lists those projects)
    if(!bgName && naBgName && isUnassignedMasterId(bgId)) bgName = naBgName;
    const bgKey = masterIdKey(bgId != null && bgId !== "" ? bgId : (bgName && isNaFilterLabel(bgName) ? 0 : bgId));
    const ouKey = masterIdKey(ouId);
    let ouName = null;
    if(ouKey != null && bgKey != null && ouKeyToName[ouKey + "|" + bgKey]) ouName = ouKeyToName[ouKey + "|" + bgKey];
    if(!ouName && ouKey != null) ouName = ouIdToName[ouKey];
    if(!ouName && ouNameFromApi != null && ouNameFromApi !== "") ouName = ouNameFromApi;
    if(!ouName && naOuName && isUnassignedMasterId(ouId)) ouName = naOuName;
    if(ouName && PROJECT_OUS[projectName].indexOf(ouName) === -1) PROJECT_OUS[projectName].push(ouName);
    if(bgName) PROJECT_BUSINESS_GROUPS[projectName].add(bgName);
    // OUs used by projects under a real BG are cascade dependents.
    // For NA, do not pull every project's OU into the OU dropdown (that re-added unrelated OUs).
    if(bgName && ouName && !isNaFilterLabel(bgName)){
      if(!BG_STRUCTURE[bgName]) BG_STRUCTURE[bgName] = [];
      if(BG_STRUCTURE[bgName].indexOf(ouName) === -1) BG_STRUCTURE[bgName].push(ouName);
      if(!OU_TO_BG[ouName]) OU_TO_BG[ouName] = bgName;
    }
  });

  fyList.forEach(fy => {
    const year = apiVal(fy, "financialYear", "FinancialYear");
    if(year == null || year === "") return;
    const y = Number(year);
    if(!isFinite(y)) return;
    if(FY_ORDER.indexOf(y) === -1) FY_ORDER.push(y);
    FY_LABELS[y] = apiVal(fy, "financialYearLabel", "FinancialYearLabel") || fyRangeLabel(y);
  });

  monthList.forEach(m => {
    const mk = apiVal(m, "monthKey", "MonthKey");
    if(mk == null || mk === "") return;
    const key = Number(mk);
    if(!isFinite(key)) return;
    if(MONTH_ORDER.indexOf(key) === -1) MONTH_ORDER.push(key);
    MONTH_LABELS[key] = cleanMonthLabel(apiVal(m, "monthLabel", "MonthLabel") || monthYearLabel(key));
    const fy = apiVal(m, "financialYear", "FinancialYear");
    if(fy != null && fy !== "") MONTH_TO_FY[key] = Number(fy);
  });
}

    function fetchFilterMasters() {
          var params = { LoginID: LOGIN_ID }
          return fetch(encodeURI(strUrl) + '/api/PlanVsActualDashboard/GetFilterMasters', {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=utf-8",
                "Authorization": "bearer " + sessionStorage.getItem("access_token_W27_Dashboard")
                //Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
                ,"Params": encryptString(isJson(params) ? params : JSON.stringify(params)),
                //End of Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
            },
            body: JSON.stringify({ LoginID: LOGIN_ID })
          })
          .then(res => { if(!res.ok) throw new Error("GetFilterMasters failed: " + res.status); return res.json(); })
          .then(json => buildFilterMasterStructures((json && (json.data || json.Data)) || null))
          .catch(err => { console.error("GetFilterMasters error:", err); buildFilterMasterStructures(null); });
}

const QUARTERLY_PROJECT_DATA = {
  "TRSL-Transit - GMRCL (AMRP & SMRP)": { 20252:9000,  20253:12000, 20254:15000, 20261:12000, 20262:10000, 20263:5000, 20264:0 },
  "TRSL-Transit - Mumbai (L6 & L5)":    { 20252:3000,  20253:4500,  20254:6000,  20261:10000, 20262:10000, 20263:15000, 20264:20000 },
  "TRSL - Transit - VandeBharath":      { 20252:4000,  20253:5000,  20254:6300,  20261:7000,  20262:8000,  20263:8000, 20264:8000 },
  "TRSL-Transit - Pune Extension":      { 20252:0,     20253:50,    20254:200,   20261:500,   20262:1000,  20263:1000, 20264:1000 }
};

// Periods covered by sample data — aligned to the 5 fiscal quarters in the Actual Hours chart:
// Q4'25-26 (Jan-Mar'26), Q1'26-27 (Apr-Jun'26), Q2'26-27 (Jul-Sep'26), Q3'26-27 (Oct-Dec'26), Q4'26-27 (Jan-Mar'27)
const PERIODS = [
  {year:2026, month:1}, {year:2026, month:2}, {year:2026, month:3},
  {year:2026, month:4}, {year:2026, month:5}, {year:2026, month:6},
  {year:2026, month:7}, {year:2026, month:8}, {year:2026, month:9},
  {year:2026, month:10}, {year:2026, month:11}, {year:2026, month:12},
  {year:2027, month:1}, {year:2027, month:2}, {year:2027, month:3}
];

function seededFactor(seed, spread){
  // deterministic pseudo-random in [1-spread, 1+spread]
  const x = Math.sin(seed * 12.9898) * 43758.5453;
  const frac = x - Math.floor(x);
  return 1 + (frac * 2 - 1) * spread;
}


// Modify By Madhuri.K on 27-07-2026 - Sample resources for Analysis Table Resource views
const RESOURCES = [
  "Amit Sharma", "Priya Nair", "Rahul Verma", "Sara Khan",
  "Vikram Joshi", "Neha Desai", "Arjun Reddy", "Meera Iyer"
];

function generateData(){
  const rows = [];
  let seed = 1;
  Object.entries(PROJECT_OUS).forEach(([project, domains]) => {
    const quarterTotals = QUARTERLY_PROJECT_DATA[project] || {};
    PERIODS.forEach(({year, month}) => {
      const fq = fiscalQuarterOf(year, month);
      const qKey = quarterKeyOf(fq.fy, fq.q);
      const quarterTotal = quarterTotals[qKey] || 0;
      const monthlyTotal = quarterTotal / 3;
      domains.forEach(organizationUnit => {
        seed++;
        const dept = OU_TO_BG[organizationUnit];
        const domainShare = monthlyTotal / domains.length;
        const plannedTotal = Math.round(domainShare * seededFactor(seed, 0.08));
        const actualTotal = Math.round(plannedTotal * seededFactor(seed * 7.31, 0.28));
        // Modify By Madhuri.K on 27-07-2026 - Split hours across sample resources
        const picked = [RESOURCES[seed % RESOURCES.length], RESOURCES[(seed + 3) % RESOURCES.length], RESOURCES[(seed + 5) % RESOURCES.length]]
          .filter(function(v,i,a){ return a.indexOf(v)===i; });
        let plannedLeft = plannedTotal, actualLeft = actualTotal;
        picked.forEach(function(resource, ri){
          const planned = ri === picked.length - 1 ? plannedLeft : Math.round(plannedTotal / picked.length);
          const actual = ri === picked.length - 1 ? actualLeft : Math.round(actualTotal / picked.length);
          plannedLeft -= planned; actualLeft -= actual;
          rows.push({businessGroup:dept, organizationUnit, project, resource, year, month, planned, actual});
        });
      });
    });
  });
  return rows;
}

// Populated once the top filter master data has loaded (see bootstrap() at the end of this script).
let RAW_DATA = [];

/* Fiscal-year helpers used by the filter bar (fiscal year runs Apr -> Mar, same convention
   as the quarter helpers further down in this file — function declarations are hoisted,
   so it's safe to call fiscalQuarterOf() here even though it's defined later). */
function rowFY(r){ return fiscalQuarterOf(r.year, r.month).fy; }
function fyRangeLabel(fy){ return `FY ${fy}-${String(fy+1).slice(-2)}`; }
const FISCAL_MONTH_ORDER = [4,5,6,7,8,9,10,11,12,1,2,3];
/* Month filter options are keyed by calendar year+month together (e.g. 202604 = Apr 2026)
   so "Jan" always means one specific, unambiguous month rather than any-year January. */
function monthKeyOf(year, month){ return year*100 + month; }
function decodeMonthKey(key){ return { year: Math.floor(key/100), month: key%100 }; }
function monthYearLabel(key){ const {year, month} = decodeMonthKey(key); return `${MONTH_NAMES[month-1]} ${year}`; }
// Added By Madhuri.K On 07-08-2026 - Remove apostrophe from month labels (Apr '26 -> Apr 26)
function cleanMonthLabel(label){
  if(label == null || label === "") return label;
  return String(label).replace(/[''\u2018\u2019]/g, "").replace(/\s+/g, " ").trim();
}

/* =========================================================================
   2. FILTER STATE
   ========================================================================= */
const FILTERS = { businessGroup:new Set(), organizationUnit:new Set(), project:new Set(), year:new Set(), month:new Set() };

/* Default the Year filter to the current Indian Financial Year, if it exists in master data. Month stays "All". */
function applyDefaultYearMonth(){
  FILTERS.year.clear();
  FILTERS.month.clear();
  const today = new Date();
  const curFY = fiscalQuarterOf(today.getFullYear(), today.getMonth()+1).fy;
  // Modified By Madhuri.K On 07-08-2026 - Use FinancialYearMasterModel list from GetFilterMasters
  if(FY_ORDER.indexOf(curFY) > -1){
    FILTERS.year.add(curFY);
  }
}

function optionsFor(key){
  // Added By Madhuri.K on 30-07-2026 - Business Group / Organization Unit / Project options come
  // straight from the GetFilterMasters-derived master data (BG_STRUCTURE / PROJECT_OUS /
  // PROJECT_BUSINESS_GROUPS), not from RAW_DATA (the sample hours dataset), so an OU or project
  // with no hours data still shows up in its dropdown instead of silently disappearing.
  // Modified By Madhuri.K On 07-08-2026 - Keep API order; Year/Month from master models
  // Modified By Madhuri.K On 10-08-2026 - NA / unassigned parents still return child values;
  // if cascade yields nothing, fall back to the full master list so top filters never go empty.
  if(key==="businessGroup") return BG_ORDER.slice();
  if(key==="organizationUnit"){
    if(!FILTERS.businessGroup.size) return OU_ORDER.slice();
    const out = [];
    const seen = new Set();
    BG_ORDER.forEach(bg => {
      if(!FILTERS.businessGroup.has(bg)) return;
      (BG_STRUCTURE[bg] || []).forEach(ou => {
        if(!seen.has(ou)){ seen.add(ou); out.push(ou); }
      });
    });
    // Modified By Madhuri.K On 10-08-2026 - Keep strict BG→OU cascade (no full-list fallback).
    // Selecting NA must only list OUs dependent on NA — never all master OUs.
    return out;
  }
  if(key==="project"){
    const domains = FILTERS.organizationUnit.size ? FILTERS.organizationUnit : null;
    const depts = FILTERS.businessGroup.size ? FILTERS.businessGroup : null;
    const filtered = PROJECT_ORDER.filter(project=>{
      if(!domains && !depts) return true;
      const ous = PROJECT_OUS[project] || [];
      const bgs = PROJECT_BUSINESS_GROUPS[project] || new Set();
      const naSelected = depts && [...depts].some(isNaFilterLabel);
      const naOuSelected = domains && [...domains].some(isNaFilterLabel);
      const matchesOU = !domains || ous.some(ou => domains.has(ou)) ||
        (naOuSelected && (!ous.length || ous.some(isNaFilterLabel)));
      const matchesBG = !depts || [...bgs].some(bg => depts.has(bg)) ||
        (naSelected && (!bgs.size || [...bgs].some(isNaFilterLabel)));
      return matchesOU && matchesBG;
    });
    // If NA is selected and linkage still yields nothing, keep full Project list visible
    if(!filtered.length && PROJECT_ORDER.length){
      const naInPlay = (depts && [...depts].some(isNaFilterLabel)) ||
        (domains && [...domains].some(isNaFilterLabel));
      if(naInPlay) return PROJECT_ORDER.slice();
    }
    return filtered;
  }
  if(key==="year") return FY_ORDER.slice();
  if(key==="month"){
    // Month choices depend on selected Financial Year(s); values/order from MonthMasterModel
    const fys = FILTERS.year.size ? FILTERS.year : null;
    return MONTH_ORDER.filter(mk => !fys || fys.has(MONTH_TO_FY[mk]));
  }
  return [];
}

/* Prune stale selections when parent filters change (businessGroup -> organizationUnit -> project, year -> month) */
function pruneDependents(){
  const validDomains = new Set(optionsFor("organizationUnit"));
  FILTERS.organizationUnit.forEach(d => { if(!validDomains.has(d)) FILTERS.organizationUnit.delete(d); });
  const validProjects = new Set(optionsFor("project"));
  FILTERS.project.forEach(p => { if(!validProjects.has(p)) FILTERS.project.delete(p); });
  const validMonths = new Set(optionsFor("month"));
  FILTERS.month.forEach(m => { if(!validMonths.has(m)) FILTERS.month.delete(m); });
}

/* =========================================================================
   3. FILTER BAR UI
   ========================================================================= */
const FILTER_DEFS = [
  {key:"businessGroup", label:"Business Group"},
  {key:"organizationUnit", label:"Organization Unit"},
  {key:"project", label:"Project"},
  {key:"year", label:"Financial Year", isYear:true},
  {key:"month", label:"Month", isMonth:true}
];

// Modified By Madhuri.K On 07-08-2026 - Show GetFilterMasters values exactly (no Title Case); FY/Month use API labels
function formatFilterValue(def, opt){
  if(def.isMonth) return cleanMonthLabel(MONTH_LABELS[opt] || monthYearLabel(opt));
  if(def.isYear) return FY_LABELS[opt] || fyRangeLabel(opt);
  return String(opt);
}

// Added By Madhuri.K on 30-07-2026 - Keep a dropdown open across re-renders (selecting a checkbox
// triggers renderAll() -> renderFilterBar(), which used to rebuild fresh DOM and lose the "open"
// state); it now only closes on the explicit Close button or a genuine click outside the dropdown.
let openFilterKey = null;
// Search text typed into each dropdown's search box, keyed by filter key, kept across re-renders.
const filterSearchTerms = {};
// Added By Madhuri.K on 07-08-2026 - Preserve list scroll when checkbox selection rebuilds the panel
const mselPanelScroll = {};
function rememberMselScroll(key, panel){
  if(key && panel) mselPanelScroll[key] = panel.scrollTop || 0;
}
function bindMselScrollPersist(key, panel){
  if(!key || !panel) return;
  panel.addEventListener("scroll", function(){ mselPanelScroll[key] = panel.scrollTop; });
  if(panel.classList.contains("open") && mselPanelScroll[key] != null){
    const y = mselPanelScroll[key];
    requestAnimationFrame(function(){ panel.scrollTop = y; });
  }
}

function renderFilterBar(){
  const bar = document.getElementById("filterBar");
  bar.innerHTML = "";
  FILTER_DEFS.forEach(def=>{
    const opts = optionsFor(def.key);
    const group = document.createElement("div");
    group.className = "pva-filter-group";
    const selected = FILTERS[def.key];
    const label = document.createElement("label");
    label.textContent = def.label;
    group.appendChild(label);

    const msel = document.createElement("div");
    msel.className = "msel";
    const btn = document.createElement("button");
    btn.className = "msel-btn";
    btn.type = "button";
    let btnLabel = "Select " + def.label; // Modify By Madhuri.K on 27-07-2026 - Placeholder instead of All
    if(selected.size === 1){
      const only = [...selected][0];
      btnLabel = formatFilterValue(def, only);
    } else if(selected.size > 1){
      btnLabel = "Selected";
    }
    btn.innerHTML = `<span>${btnLabel}</span>` +
      (selected.size > 1 ? `<span class="count">${selected.size}</span>` : `<span class="chev"><i class="fas fa-chevron-down"></i></span>`);
    const panel = document.createElement("div");
    panel.className = "msel-panel";
    if(openFilterKey === def.key) panel.classList.add("open");
    // Clicks inside the dropdown (search box, rows, action buttons) must not bubble to the
    // document-level "click outside closes everything" listener below.
    panel.addEventListener("click", (e)=> e.stopPropagation());
    bindMselScrollPersist(def.key, panel);

    const searchInput = document.createElement("input");
    searchInput.type = "text";
    searchInput.className = "msel-search";
    searchInput.placeholder = "Search " + def.label + "...";
    searchInput.value = filterSearchTerms[def.key] || "";
    panel.appendChild(searchInput);

    const rowsWrap = document.createElement("div");
    panel.appendChild(rowsWrap);

    const emptyMsg = document.createElement("div");
    emptyMsg.className = "msel-empty";
    emptyMsg.textContent = "No matches";
    emptyMsg.style.display = "none";
    panel.appendChild(emptyMsg);

    function applySearchFilter(){
      const term = searchInput.value.trim().toLowerCase();
      let anyVisible = false;
      rowsWrap.querySelectorAll(".msel-row").forEach(row=>{
        const match = !term || row.dataset.label.indexOf(term) > -1;
        row.style.display = match ? "" : "none";
        if(match) anyVisible = true;
      });
      emptyMsg.style.display = anyVisible ? "none" : "block";
    }
    searchInput.addEventListener("input", ()=>{
      filterSearchTerms[def.key] = searchInput.value;
      applySearchFilter();
    });

    opts.forEach(opt=>{
      const row = document.createElement("label");
      row.className = "msel-row";
      const optLabel = formatFilterValue(def, opt);
      row.dataset.label = String(optLabel).toLowerCase();
      const cb = document.createElement("input");
      cb.type = "checkbox";
      cb.checked = selected.has(opt);
      cb.addEventListener("change", ()=>{
        rememberMselScroll(def.key, panel);
        if(cb.checked) selected.add(opt); else selected.delete(opt);
        pruneDependents();
        renderAll();
      });
      row.appendChild(cb);
      const txt = document.createElement("span");
      txt.textContent = optLabel;
      row.appendChild(txt);
      row.addEventListener("click", (e)=>{ if(e.target!==cb){ cb.checked=!cb.checked; cb.dispatchEvent(new Event("change")); }});
      rowsWrap.appendChild(row);
    });
    applySearchFilter();

    const actions = document.createElement("div");
    actions.className = "msel-actions";
    const clearOne = document.createElement("button");
    clearOne.textContent = "Clear";
    clearOne.addEventListener("click", ()=>{
      // Modified By Madhuri.K On 07-08-2026 - Clear selection + search; do not re-apply default FY
      selected.clear();
      filterSearchTerms[def.key] = "";
      pruneDependents();
      renderAll();
    });
    const closeOne = document.createElement("button");
    closeOne.textContent = "Close";
    closeOne.addEventListener("click", ()=>{
      openFilterKey = null;
      panel.classList.remove("open");
    });
    actions.appendChild(clearOne); actions.appendChild(closeOne);
    panel.appendChild(actions);

    btn.addEventListener("click", (e)=>{
      e.stopPropagation();
      if(openFilterKey === def.key){
        openFilterKey = null;
        panel.classList.remove("open");
      } else {
        openFilterKey = def.key;
        document.querySelectorAll(".msel-panel.open").forEach(p=>{ if(p!==panel) p.classList.remove("open"); });
        panel.classList.add("open");
        searchInput.focus();
      }
    });

    msel.appendChild(btn); msel.appendChild(panel);
    group.appendChild(msel);
    bar.appendChild(group);
  });

  // Added By Vishal.M on 12-08-2026 - Save button immediately after Month dropdown
  // Modified By Vishal.M on 12-08-2026 - ghostbtn Save view + Clear View (reset to current FY)
  // Modified By Madhuri.K On 13-08-2026 - Purpose: Keep Vishal save-group; place on top-right via filterViewActions
  const saveGroup = document.createElement("div");
  saveGroup.className = "pva-filter-save-group";
  const saveLabel = document.createElement("label");
  saveLabel.textContent = "Views";
  saveGroup.appendChild(saveLabel);

  const viewActions = document.createElement("div");
  viewActions.className = "pva-filter-view-actions";

  const saveBtn = document.createElement("button");
  saveBtn.type = "button";
  saveBtn.id = "btnSaveDefaultFilters";
  saveBtn.className = "ghostbtn";
  saveBtn.innerHTML = '<i class="far fa-star"></i> Save View';
  saveBtn.title = "Save View";
  saveBtn.addEventListener("click", function(e){
    e.stopPropagation();
    saveDefaultFilters(saveBtn);
  });

  const clearViewBtn = document.createElement("button");
  clearViewBtn.type = "button";
  clearViewBtn.id = "btnClearDefaultView";
  clearViewBtn.className = "ghostbtn";
  clearViewBtn.innerHTML = '<i class="far fa-times-circle"></i> Clear View';
  clearViewBtn.title = "Clear View";
  clearViewBtn.addEventListener("click", function(e){
    e.stopPropagation();
    clearDefaultViewFilters();
  });

  viewActions.appendChild(saveBtn);
  viewActions.appendChild(clearViewBtn);
  saveGroup.appendChild(viewActions);
  // Prefer right-side host so buttons stay on top row; fallback to filter bar (Vishal original)
  const viewHost = document.getElementById("filterViewActions");
  if(viewHost){
    viewHost.innerHTML = "";
    viewHost.appendChild(saveGroup);
  } else {
    bar.appendChild(saveGroup);
  }

  // Changed By Madhuri.K on 24-07-2026 - Clear All moved to action-bar link (My_Leaves style)
}
document.addEventListener("click", ()=>{
  openFilterKey = null;
  openTrendProjectPanel = false;
  openAnalysisProjectPanel = false;
  openAnalysisResourcePanel = false;
  document.querySelectorAll(".msel-panel.open").forEach(p=>p.classList.remove("open"));
});
document.getElementById("ClearAllFiltersBtn") && document.getElementById("ClearAllFiltersBtn").addEventListener("click", ()=>{
  // Modified By Madhuri.K On 07-08-2026 - Clear all selections + search text (including Financial Year)
  Object.values(FILTERS).forEach(s=>s.clear());
  FILTER_DEFS.forEach(function(def){ filterSearchTerms[def.key] = ""; });
  trendProjectSearchTerm = "";
  analysisProjectSearchTerm = "";
  analysisResourceSearchTerm = "";
  renderAll();
});

/* =========================================================================
   3b. DEFAULT FILTER SAVE / APPLY (Added By Vishal.M on 12-08-2026)
   Saves static dropdown selections + SessionEmployeeID / SessionProjectID as one
   JSON string (WhereClause). Backend can parse JSON into SP parameters.
   ========================================================================= */
function buildDefaultFilterObject(){
  return {
    pageKey: PVA_PAGE_KEY,
    SessionEmployeeID: SessionEmployeeID || "",
    SessionProjectID: SessionProjectID || "",
    DashboardID: DashboardID,
    businessGroupIDs: idsParam(FILTERS.businessGroup, BG_NAME_TO_ID),
    businessGroupNames: [...FILTERS.businessGroup],
    organizationUnitIDs: idsParam(FILTERS.organizationUnit, OU_NAME_TO_ID),
    organizationUnitNames: [...FILTERS.organizationUnit],
    projectIDs: idsParam(FILTERS.project, PROJECT_NAME_TO_ID),
    projectNames: [...FILTERS.project],
    financialYears: [...FILTERS.year].map(function(y){ return Number(y); }).filter(function(y){ return isFinite(y); }),
    monthKeys: [...FILTERS.month].map(function(m){ return Number(m); }).filter(function(m){ return isFinite(m); })
  };
}

// Single JSON string persisted as WhereClause in the default-filter table
function buildDefaultFilterWhereClauseJson(){
  return JSON.stringify(buildDefaultFilterObject());
}

function parseDefaultFilterPayload(raw){
  if(raw == null || raw === "") return null;
  var obj = raw;
  if(typeof raw === "string"){
    try { obj = JSON.parse(raw); }
    catch(e){ console.error("Default filter JSON parse failed:", e); return null; }
  }
  // API may wrap: { whereClause }, { WhereClause }, { filterJson }, or { data: {...} }
  if(obj && typeof obj === "object"){
    var nested = apiVal(obj, "whereClause", "WhereClause", "filterJson", "FilterJson", "queryText", "QueryText");
    if(typeof nested === "string" && nested.trim().charAt(0) === "{"){
      try { obj = JSON.parse(nested); }
      catch(e){ /* keep obj */ }
    } else if(nested && typeof nested === "object"){
      obj = nested;
    } else {
      var dataWrap = apiVal(obj, "data", "Data");
      if(dataWrap){
        var wc = apiVal(dataWrap, "whereClause", "WhereClause", "filterJson", "FilterJson");
        if(typeof wc === "string" && wc.trim().charAt(0) === "{"){
          try { obj = JSON.parse(wc); }
          catch(e){ obj = dataWrap; }
        } else if(wc && typeof wc === "object"){
          obj = wc;
        } else if(typeof dataWrap === "object"){
          obj = dataWrap;
        }
      }
    }
  }
  return obj && typeof obj === "object" ? obj : null;
}

function fillFilterSetFromSaved(setRef, values, coerceNumber){
  setRef.clear();
  if(!values) return;
  var list = Array.isArray(values) ? values : String(values).split(",").map(function(s){ return s.trim(); }).filter(Boolean);
  list.forEach(function(v){
    if(coerceNumber){
      var n = Number(v);
      if(isFinite(n)) setRef.add(n);
    } else if(v != null && v !== ""){
      setRef.add(v);
    }
  });
}

function resolveNamesFromIds(idCsv, nameToIdMap){
  if(!idCsv) return [];
  var idToName = {};
  Object.keys(nameToIdMap || {}).forEach(function(name){
    var id = nameToIdMap[name];
    if(id === undefined || id === null || id === "") return;
    idToName[String(id)] = name;
  });
  var list = Array.isArray(idCsv) ? idCsv : String(idCsv).split(",");
  return list.map(function(s){ return String(s).trim(); }).filter(Boolean).map(function(id){
    return idToName[id] != null ? idToName[id] : null;
  }).filter(function(n){ return n != null && n !== ""; });
}

function hasSavedFilterValues(val){
  if(val == null || val === "") return false;
  if(Array.isArray(val)) return val.length > 0;
  return String(val).trim().length > 0;
}

// Returns true when a saved default was applied
function applyDefaultFilterFromPayload(payload){
  var saved = parseDefaultFilterPayload(payload);
  if(!saved) return false;

  // Modified By Vishal.M on 12-08-2026 - Prefer IDs from WhereClause so names stay in sync with master data
  var bgNames = resolveNamesFromIds(apiVal(saved, "businessGroupIDs", "BusinessGroupIDs"), BG_NAME_TO_ID);
  var ouNames = resolveNamesFromIds(apiVal(saved, "organizationUnitIDs", "OrganizationUnitIDs"), OU_NAME_TO_ID);
  var projectNames = resolveNamesFromIds(apiVal(saved, "projectIDs", "ProjectIDs"), PROJECT_NAME_TO_ID);
  if(!bgNames.length) bgNames = apiVal(saved, "businessGroupNames", "BusinessGroupNames", "departmentNames", "DepartmentNames");
  if(!ouNames.length) ouNames = apiVal(saved, "organizationUnitNames", "OrganizationUnitNames", "domainNames", "DomainNames");
  if(!projectNames.length) projectNames = apiVal(saved, "projectNames", "ProjectNames");

  var hasAny =
    hasSavedFilterValues(bgNames) ||
    hasSavedFilterValues(ouNames) ||
    hasSavedFilterValues(projectNames) ||
    hasSavedFilterValues(apiVal(saved, "financialYears", "FinancialYears")) ||
    hasSavedFilterValues(apiVal(saved, "monthKeys", "MonthKeys"));

  if(!hasAny) return false;

  fillFilterSetFromSaved(FILTERS.businessGroup, bgNames, false);
  fillFilterSetFromSaved(FILTERS.organizationUnit, ouNames, false);
  fillFilterSetFromSaved(FILTERS.project, projectNames, false);
  fillFilterSetFromSaved(FILTERS.year, apiVal(saved, "financialYears", "FinancialYears"), true);
  fillFilterSetFromSaved(FILTERS.month, apiVal(saved, "monthKeys", "MonthKeys"), true);
  pruneDependents();
  return true;
}

// Added By Vishal.M on 12-08-2026 - Read WhereClause / Result from Success(...) API wrapper
// Modified By Vishal.M on 12-08-2026 - Also unwrap DataTable / array rows from GetDefaultFilter
function firstApiRow(json){
  if(!json || typeof json !== "object") return null;
  var data = apiVal(json, "data", "Data");
  if(Array.isArray(data)) return data[0] || null;
  if(data && typeof data === "object"){
    var nested = apiVal(data, "data", "Data");
    if(Array.isArray(nested)) return nested[0] || null;
    return data;
  }
  if(Array.isArray(json)) return json[0] || null;
  return json;
}
function extractDefaultFilterResponseData(json){
  if(!json || typeof json !== "object") return { result: "", whereClause: null, filterId: 0 };
  var row = firstApiRow(json) || json;
  var whereClause = apiVal(row, "whereClause", "WhereClause", "filterJson", "FilterJson", "queryText", "QueryText");
  if(whereClause == null){
    whereClause = apiVal(json, "whereClause", "WhereClause", "filterJson", "FilterJson");
  }
  // GetDefaultFilter may return the JSON string directly in data
  if(whereClause == null){
    var dataVal = apiVal(json, "data", "Data");
    if(typeof dataVal === "string" && dataVal.trim().charAt(0) === "{") whereClause = dataVal;
  }
  return {
    result: String(apiVal(row, "result", "Result") != null ? apiVal(row, "result", "Result") : ""),
    whereClause: whereClause,
    filterId: apiVal(row, "filterID", "FilterID") || 0
  };
}

function saveDefaultFilterResultMessage(resultCode){
  // Result = "1" insert/saved, Result = "2" update/updated (from SaveDefaultFilter SP)
  //if(String(resultCode) === "1") return "Default filters saved successfully.";
  //if(String(resultCode) === "2") return "Default filters updated successfully.";
    if (String(resultCode) === "1") return "View saved successfully.";
    if (String(resultCode) === "2") return "View updated successfully.";
    return "View saved successfully.";
}

// Added By Vishal.M on 12-08-2026 - Clear View: reset dropdowns; keep current Financial Year (same as fresh load default)
function clearDefaultViewFilters(){
  Object.values(FILTERS).forEach(function(s){ s.clear(); });
  FILTER_DEFS.forEach(function(def){ filterSearchTerms[def.key] = ""; });
  trendProjectSearchTerm = "";
  analysisProjectSearchTerm = "";
  analysisResourceSearchTerm = "";
  if(typeof trendProjectFilter !== "undefined" && trendProjectFilter && trendProjectFilter.clear) trendProjectFilter.clear();
  if(typeof analysisProjectFilter !== "undefined" && analysisProjectFilter && analysisProjectFilter.clear) analysisProjectFilter.clear();
  if(typeof analysisResourceFilter !== "undefined" && analysisResourceFilter && analysisResourceFilter.clear) analysisResourceFilter.clear();
  applyDefaultYearMonth();
  renderAll();
    alertify.set('notifier', 'position', 'top-right');
    alertify.success("View cleared successfully.");
}

function setSaveViewButtonIdle(btnEl){
  if(!btnEl) return;
  btnEl.disabled = false;
  btnEl.innerHTML = '<i class="far fa-star"></i> Save view';
}

// Modified By Vishal.M on 12-08-2026 - Apply returned WhereClause after save/update; alert by Result
// Modified By Vishal.M on 12-08-2026 - DashboardID must be string; include request wrapper for API model binding
function saveDefaultFilters(btnEl){
  var whereClauseJson = buildDefaultFilterWhereClauseJson();
  var requestBody = {
    LoginID: LOGIN_ID,
    SessionEmployeeID: SessionEmployeeID || "",
    DashboardID: DashboardID,
    PageKey: PVA_PAGE_KEY,
    WhereClause: whereClauseJson,
    FilterJson: whereClauseJson
  };
  var requestPayload = Object.assign({ request: requestBody }, requestBody);

  if(btnEl){
    btnEl.disabled = true;
    btnEl.innerHTML = '<i class="far fa-star"></i> Saving...';
  }
  return fetch(encodeURI(strUrl) + '/api/PlanVsActualDashboard/SaveDefaultFilter', {
    method: "POST",
    headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "bearer " + sessionStorage.getItem("access_token_W27_Dashboard")
        //Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
        , "Params": encryptString(isJson(requestPayload) ? requestPayload : JSON.stringify(requestPayload)),
        //End of Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
    },
    body: JSON.stringify(requestPayload)
  }).then(function(res){
    if(!res.ok) throw new Error("SaveDefaultFilter failed: " + res.status);
    return res.json().catch(function(){ return {}; });
  }).then(function(json){
    var resp = extractDefaultFilterResponseData(json);
    var clauseToApply = resp.whereClause != null && resp.whereClause !== "" ? resp.whereClause : whereClauseJson;
    var applied = applyDefaultFilterFromPayload(clauseToApply);
      if (applied) renderAll();
      alertify.set('notifier', 'position', 'top-right');
      alertify.success(saveDefaultFilterResultMessage(resp.result));
    //alert(saveDefaultFilterResultMessage(resp.result));
  }).catch(function(err){
    console.error("SaveDefaultFilter error:", err);
    //alert("Unable to save default filters. Please try again.");
      alertify.error("Unable to save default filters. Please try again.");
  }).finally(function(){
    setSaveViewButtonIdle(btnEl);
  });
}

function fetchDefaultFilters(){
  var requestBody = {
    LoginID: LOGIN_ID,
    SessionEmployeeID: SessionEmployeeID || "",
    DashboardID: DashboardID,
    PageKey: PVA_PAGE_KEY
  };
  // Modified By Vishal.M on 12-08-2026 - Keep request wrapper + root fields for API compatibility
  var requestPayload = Object.assign({ request: requestBody }, requestBody);
  return fetch(encodeURI(strUrl) + '/api/PlanVsActualDashboard/GetDefaultFilter', {
    method: "POST",
    headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "bearer " + sessionStorage.getItem("access_token_W27_Dashboard")
        //Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
        , "Params": encryptString(isJson(requestPayload) ? requestPayload : JSON.stringify(requestPayload)),
        //End of Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
    },
    body: JSON.stringify(requestPayload)
  }).then(function(res){
    if(res.status === 204 || res.status === 404) return null;
    if(!res.ok) throw new Error("GetDefaultFilter failed: " + res.status);
    return res.json();
  }).then(function(json){
    if(!json) return null;
    // Modified By Vishal.M on 12-08-2026 - Same Success(...) shape as SaveDefaultFilter
    var resp = extractDefaultFilterResponseData(json);
    if(resp.whereClause != null && resp.whereClause !== "") return resp.whereClause;
    return json;
  }).catch(function(err){
    console.error("GetDefaultFilter error:", err);
    return null;
  });
}

/* =========================================================================
   4. KPIs
   ========================================================================= */
// Added By Madhuri.K on 29-07-2026 - KPI Summary now sourced from /api/PlanVsActualDashboard/GetKPISummary
function idsParam(nameSet, nameToIdMap){
  // Modified By Madhuri.K On 10-08-2026 - Keep ID 0 (NA / unassigned); only drop null/undefined/""
  return [...nameSet].map(function(name){
    let id = nameToIdMap[name];
    if((id === undefined || id === null || id === "") && isNaFilterLabel(name)) id = 0;
    return id;
  }).filter(function(id){ return id !== undefined && id !== null && id !== ""; }).join(",");
}

function fetchKPISummary(){
  const params = {
    businessGroupIDs: idsParam(FILTERS.businessGroup, BG_NAME_TO_ID),
    organizationUnitIDs: idsParam(FILTERS.organizationUnit, OU_NAME_TO_ID),
    projectIDs: idsParam(FILTERS.project, PROJECT_NAME_TO_ID),
    financialYears: [...FILTERS.year].join(","),
    monthKeys: [...FILTERS.month].join(",")
  };
  return fetch(encodeURI(strUrl) + '/api/PlanVsActualDashboard/GetKPISummary', {
    method: "POST",
    headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "bearer " + sessionStorage.getItem("access_token_W27_Dashboard")
        //Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
        ,"Params": encryptString(isJson(params) ? params : JSON.stringify(params)),
        //End of Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
    },      
    body: JSON.stringify(params)
  }).then(res => {
    if(!res.ok) throw new Error("GetKPISummary failed: " + res.status);
    return res.json();
  }).then(json => {
    const data = (json && (json.data || json.Data)) || {};
    const rows = apiArray(data, "PlanVsActualKpiModel", "planVsActualKpiModel", "KpiModel", "kpiModel");
    return (rows && rows[0]) || {};
  });
}

let kpiRequestSeq = 0;
function renderKPIs(){
  const row = document.getElementById("kpiRow");
  const requestId = ++kpiRequestSeq;
  fetchKPISummary().then(summary => {
    if(requestId !== kpiRequestSeq) return; // a newer filter change superseded this request
    // Modified By Madhuri.K On 06-08-2026 - KPI hours come as "HHHH:MM" strings from GetKPISummary
    const plannedDisp = formatHoursDisplay(apiVal(summary, "plannedHours", "PlannedHours"));
    const actualDisp = formatHoursDisplay(apiVal(summary, "actualHours", "ActualHours"));
    const varianceDisp = formatHoursDisplay(apiVal(summary, "varianceHours", "VarianceHours"));
    const varianceNum = hoursToNumber(apiVal(summary, "varianceHours", "VarianceHours"));
    const variancePct = apiNum(summary, "variancePercent", "VariancePercent");
    const util = apiNum(summary, "utilizationPercent", "UtilizationPercent");
    const varianceSign = (String(varianceDisp).charAt(0) === "-" || varianceNum < 0) ? "" : (varianceNum > 0 ? "+" : "");
    // Variance card colors stay on ±10% bands (unchanged): >10 over/red, <-10 under/amber, else on-plan/teal
    const varBand = Number(variancePct) > 10 ? "over" : Number(variancePct) < -10 ? "under" : "ok";
    const varAccent = varBand === "over" ? "var(--red)" : varBand === "under" ? "var(--amber)" : "var(--teal)";
    const varSubClass = varBand === "over" ? "neg" : varBand === "under" ? "under" : "pos";
    // Modified By Madhuri.K On 10-08-2026 - Utilization label: >+10 Over-utilized; <-10 Under-utilized; -10..+10 On-plan
    const utilBadge = varianceBadgeMeta(variancePct);
    const utilAccent = utilBadge.cls === "over" ? "var(--red)" : utilBadge.cls === "under" ? "var(--amber)" : "var(--teal)";
    const utilSubClass = utilBadge.cls === "over" ? "neg" : utilBadge.cls === "under" ? "under" : "pos";
    // Added By Madhuri.K on 07-08-2026 - Treat rounded-to-zero % as 0.00 (no "-0.00%" / "-0.0%")
    // Added By Madhuri.K On 13-08-2026 - Purpose: Comma delimiter on KPI variance % / utilization for readability
    const variancePctSub = formatPercentDisplay(variancePct, 2, true) + " vs plan";

    const cards = [
      // Modified By Madhuri.K On 06-08-2026 - Removed data points subtitle from Total Planned Hours
      {lbl:"Total Planned Hours", val:plannedDisp, sub:"", accent:"var(--slate)"},
      {lbl:"Total Actual Hours", val:actualDisp, sub:"", accent:"var(--navy)"},
      {lbl:"Variance", val:varianceSign + varianceDisp + " hrs",
        sub:variancePctSub, accent: varAccent,
        subClass: varSubClass},
      {lbl:"Utilization", val:formatPercentDisplay(util, 2, false), sub: utilBadge.label,
        accent: utilAccent,
        subClass: utilSubClass}
    ];
    row.innerHTML = "";
    cards.forEach(c=>{
      const div = document.createElement("div");
      div.className = "kpi";
      div.style.setProperty("--kpi-accent", c.accent);
      div.innerHTML = `<div class="lbl">${c.lbl}</div><div class="val">${c.val}</div>` +
        (c.sub ? `<div class="sub ${c.subClass||''}">${c.sub}</div>` : "");
      row.appendChild(div);
    });
  }).catch(err => {
    if(requestId !== kpiRequestSeq) return;
    console.error("GetKPISummary error:", err);
    row.innerHTML = '<div class="empty-state">Unable to load KPI summary.</div>';
  });
}

/* =========================================================================
   6. CHARTS
   ========================================================================= */
let charts = {};
function destroyCharts(){ Object.values(charts).forEach(c=>c && c.destroy()); charts = {}; }

const CHART_FONT = { family: "'Inter',sans-serif", size: 11 };

// Added By Madhuri.K On 06-08-2026 - Chart tooltip hours in same H:MM format as API
function formatChartTooltipValue(v, hoursLabel){
  if(hoursLabel != null && hoursLabel !== "") return hoursLabel;
  return formatHoursDisplay(v);
}

// Added By Madhuri.K On 06-08-2026 - External HTML tooltip matching SS (blue title + Planned/Actual rows)
function pvaExternalTooltip(context){
  var tooltipModel = context.tooltip;
  var chart = context.chart;
  var tooltipEl = document.getElementById("pvaChartTooltip");
  if(!tooltipEl){
    tooltipEl = document.createElement("div");
    tooltipEl.id = "pvaChartTooltip";
    tooltipEl.className = "pva-chart-tooltip";
    document.body.appendChild(tooltipEl);
  }
  if(!tooltipModel || tooltipModel.opacity === 0 || !tooltipModel.dataPoints || !tooltipModel.dataPoints.length){
    tooltipEl.classList.remove("open");
    return;
  }

  var dataIndex = tooltipModel.dataPoints[0].dataIndex;
  // Prefer full entity/month name stored on the chart (axis / legend may be truncated with "...")
  var title = "";
  if(chart.$pvaFullLabels && chart.$pvaFullLabels[dataIndex] != null && chart.$pvaFullLabels[dataIndex] !== ""){
    title = String(chart.$pvaFullLabels[dataIndex]);
  } else if(tooltipModel.title && tooltipModel.title.length){
    title = tooltipModel.title[0];
  }
  var rowsHtml = "";
  tooltipModel.dataPoints.forEach(function(dp){
    var ds = dp.dataset || {};
    // Full series name for Details rows (legend label may be shortened)
    var dsLabel = (ds.pvaFullLabel != null && ds.pvaFullLabel !== "")
      ? String(ds.pvaFullLabel)
      : (ds.label ? String(ds.label) : "");
    var colorClass = "other";
    var lower = dsLabel.toLowerCase();
    if(lower.indexOf("planned") > -1) colorClass = "planned";
    else if(lower.indexOf("actual") > -1) colorClass = "actual";
    var displayLabel = dsLabel;
    var rawY = (dp.parsed && dp.parsed.y != null) ? dp.parsed.y : dp.raw;
    var hoursLabel = (ds.hoursLabels && dp.dataIndex != null)
      ? ds.hoursLabels[dp.dataIndex]
      : null;
    rowsHtml += '<div class="tip-row"><span class="tip-lbl">' + displayLabel +
      '</span><span class="tip-val ' + colorClass + '">' + formatChartTooltipValue(rawY, hoursLabel) +
      "</span></div>";
  });

  tooltipEl.innerHTML = '<div class="tip-head" title="' + String(title).replace(/"/g, "&quot;") + '">' + title +
    '</div><div class="tip-body">' + rowsHtml + "</div>";
  tooltipEl.classList.add("open");

  var canvasRect = chart.canvas.getBoundingClientRect();
  var left = canvasRect.left + window.pageXOffset + tooltipModel.caretX + 12;
  var top = canvasRect.top + window.pageYOffset + tooltipModel.caretY - 12;
  // Keep tooltip inside viewport
  var tw = tooltipEl.offsetWidth || 160;
  var th = tooltipEl.offsetHeight || 80;
  if(left + tw > window.pageXOffset + window.innerWidth - 8){
    left = canvasRect.left + window.pageXOffset + tooltipModel.caretX - tw - 12;
  }
  if(top + th > window.pageYOffset + window.innerHeight - 8){
    top = window.pageYOffset + window.innerHeight - th - 8;
  }
  if(top < window.pageYOffset + 8) top = window.pageYOffset + 8;
  tooltipEl.style.left = left + "px";
  tooltipEl.style.top = top + "px";
}

// Modify By Madhuri.K on 27-07-2026 - Simple Chart.js options
// Modified By Madhuri.K On 06-08-2026 - Custom hover tooltip (category + Planned/Actual details)
// Modified By Madhuri.K On 13-08-2026 - Purpose: ssAxisLabels enables SS angled x-axis; Y ticks use comma delimiter
function baseBarOptions(title, categoryCount, ssAxisLabels){
  var opts = {
    responsive: true,
    maintainAspectRatio: false,
    interaction: { mode: "index", intersect: false },
    plugins: {
      title: { display: true, text: title, font: { size: 13, weight: "600" }, color: "#1a2536", padding: { bottom: 8 } },
      legend: { position: "bottom", labels: { font: CHART_FONT, boxWidth: 12 } },
      tooltip: {
        enabled: false,
        external: pvaExternalTooltip
      }
    },
    scales: {
      x: { ticks: { font: CHART_FONT }, grid: { display: false }, offset: true },
      y: {
        // Added By Madhuri.K On 13-08-2026 - Purpose: Comma delimiter on chart Y-axis numbers (e.g. 1,800)
        ticks: { font: CHART_FONT, callback: function(val){ return formatNumberComma(val); } },
        grid: { color: "#eef1f5" },
        beginAtZero: true
      }
    }
  };
  return applyCategoryAxisSpacing(opts, categoryCount, ssAxisLabels);
}

// Added By Madhuri.K on 03-08-2026 - Case-insensitive API property helpers
// (W26 API may return PascalCase or camelCase keys/properties).
function apiVal(obj){
  if(!obj) return undefined;
  for(var i = 1; i < arguments.length; i++){
    var k = arguments[i];
    if(obj[k] != null && obj[k] !== "") return obj[k];
    var found = Object.keys(obj).find(function(ok){ return ok.toLowerCase() === String(k).toLowerCase(); });
    if(found != null && obj[found] != null && obj[found] !== "") return obj[found];
  }
  return undefined;
}
function apiNum(obj){
  var keys = Array.prototype.slice.call(arguments, 1);
  var v = apiVal.apply(null, [obj].concat(keys));
  // Modified By Madhuri.K On 06-08-2026 - Support "HHHH:MM" hour strings from KPI/summary APIs
  if(typeof v === "string" && /^-?[\d,]+:\d{1,2}$/.test(v.trim())){
    return hoursToNumber(v);
  }
  var n = Number(v);
  return isFinite(n) ? n : 0;
}

// Added By Madhuri.K On 06-08-2026 - Parse/display API hours in "HHHH:MM" (e.g. "667431:26", "-666686:42")
// Added By Madhuri.K On 13-08-2026 - Purpose: Shared comma delimiter helpers so all numeric UI values are more readable
function formatNumberComma(v, fractionDigits){
  var n = Number(v);
  if(!isFinite(n)) n = 0;
  var opts = {};
  if(fractionDigits != null && fractionDigits !== undefined){
    opts.minimumFractionDigits = fractionDigits;
    opts.maximumFractionDigits = fractionDigits;
  } else {
    opts.maximumFractionDigits = 2;
  }
  return n.toLocaleString("en-IN", opts);
}
// Added By Madhuri.K On 13-08-2026 - Purpose: Format % with comma delimiter (optional + sign)
function formatPercentDisplay(v, fractionDigits, withSign){
  var digits = (fractionDigits != null && fractionDigits !== undefined) ? fractionDigits : 2;
  var n = Number(v);
  if(!isFinite(n)) n = 0;
  var rounded = Math.round(n * Math.pow(10, digits)) / Math.pow(10, digits);
  if(rounded === 0) return "0." + Array(digits + 1).join("0").slice(0, digits) + "%";
  var sign = "";
  if(withSign){
    if(rounded > 0) sign = "+";
    else if(rounded < 0) sign = ""; // minus comes from the number itself
  }
  return sign + formatNumberComma(rounded, digits) + "%";
}
// Modified By Madhuri.K On 13-08-2026 - Purpose: Parse H:MM even when hour part already has commas (e.g. 23,861:12)
function hoursToNumber(v){
  if(v == null || v === "") return 0;
  if(typeof v === "number" && isFinite(v)) return v;
  var s = String(v).trim();
  var m = s.match(/^(-)?([\d,]+):(\d{1,2})$/);
  if(m){
    var sign = m[1] ? -1 : 1;
    return sign * (parseInt(String(m[2]).replace(/,/g, ""), 10) + (parseInt(m[3], 10) / 60));
  }
  var n = Number(s.replace(/,/g, ""));
  return isFinite(n) ? n : 0;
}
// Added By Madhuri.K On 06-08-2026 - Minute-accurate H:MM sum/display for all Plan vs Actual APIs
// Modified By Madhuri.K On 13-08-2026 - Purpose: Accept comma in H:MM hour part when converting to minutes
function hoursToMinutes(v){
  if(v == null || v === "") return 0;
  if(typeof v === "number" && isFinite(v)) return Math.round(v * 60);
  var s = String(v).trim();
  var m = s.match(/^(-)?([\d,]+):(\d{1,2})$/);
  if(m){
    var sign = m[1] ? -1 : 1;
    return sign * (parseInt(String(m[2]).replace(/,/g, ""), 10) * 60 + parseInt(m[3], 10));
  }
  var n = Number(s.replace(/,/g, ""));
  return isFinite(n) ? Math.round(n * 60) : 0;
}
function minutesToHoursDisplay(totalMins){
  var minsNum = Math.round(Number(totalMins) || 0);
  var sign = minsNum < 0 ? "-" : "";
  var abs = Math.abs(minsNum);
  var hrs = Math.floor(abs / 60);
  var mins = abs % 60;
  // Modified By Madhuri.K On 11-08-2026 / 13-08-2026 - Purpose: Comma delimiter on hour portion (e.g. 1,234:56)
  return sign + formatNumberComma(hrs, 0) + ":" + String(mins).padStart(2, "0");
}
function formatHoursDisplay(v){
  if(v == null || v === "") return "0:00";
  if(typeof v === "number" && isFinite(v)){
    return minutesToHoursDisplay(hoursToMinutes(v));
  }
  var s = String(v).trim();
  // Modified By Madhuri.K On 13-08-2026 - Purpose: Normalize H:MM and always show comma on hours
  var m = s.match(/^(-)?([\d,]+):(\d{1,2})$/);
  if(m){
    var hrsNum = parseInt(String(m[2]).replace(/,/g, ""), 10);
    return (m[1] || "") + formatNumberComma(hrsNum, 0) + ":" + String(m[3]).padStart(2, "0");
  }
  var n = Number(s.replace(/,/g, ""));
  if(isFinite(n)) return formatHoursDisplay(n);
  return s;
}

// Added By Madhuri.K On 11-08-2026 - Extra x-axis space when few months/categories are shown
// Modified By Madhuri.K On 13-08-2026 - Purpose: SS format — angled (~45°) one-line x labels when categories > 3 (no overlap)
function applyCategoryAxisSpacing(options, categoryCount, ssAxisLabels){
  var opts = options || {};
  opts.scales = opts.scales || {};
  var n = Number(categoryCount) || 0;
  var sidePad = 8;
  if(n <= 1) sidePad = 110;
  else if(n === 2) sidePad = 70;
  else if(n <= 4) sidePad = 36;
  else if(n <= 6) sidePad = 18;
  var tickOpts = {
    font: CHART_FONT,
    autoSkip: false,
    maxRotation: 0,
    minRotation: 0
  };
  var bottomPad = (opts.layout && opts.layout.padding && opts.layout.padding.bottom) || 0;
  // Added By Madhuri.K On 13-08-2026 - Purpose: Overview SS style — slant labels so text stays one line and does not overlap
  if(ssAxisLabels && n > 3){
    tickOpts.maxRotation = 45;
    tickOpts.minRotation = 45;
    tickOpts.padding = 2;
    bottomPad = Math.max(bottomPad, 8);
    /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
    // When category count is very large (ex: By Project), drawing every label overrides/overlaps.
    // Skip most labels using ticks.callback so only a limited set is shown on the axis.
    if(n > 18){
      tickOpts.autoSkip = true;
      tickOpts.autoSkipPadding = 10;
      var skip = Math.ceil(n / 12); // show ~12 labels max
      tickOpts.callback = function(val, idx){
        if(skip > 1 && (idx % skip) !== 0) return "";
        return val;
      };
    } else {
      tickOpts.autoSkip = false;
    }
  } else if(!ssAxisLabels && n > 6){
    tickOpts.autoSkip = true;
    tickOpts.autoSkipPadding = 6;
    tickOpts.maxRotation = 45;
    tickOpts.minRotation = 0;
  }
  opts.layout = Object.assign({}, opts.layout, {
    padding: Object.assign({}, (opts.layout && opts.layout.padding) || {}, {
      left: sidePad, right: sidePad, bottom: bottomPad
    })
  });
  opts.scales.x = Object.assign({}, opts.scales.x, {
    offset: true,
    ticks: Object.assign({}, (opts.scales.x && opts.scales.x.ticks) || {}, tickOpts),
    grid: { display: false }
  });
  opts.scales.y = Object.assign({}, opts.scales.y, {
    beginAtZero: true,
    grid: { color: "#eef1f5" },
    ticks: Object.assign({}, (opts.scales.y && opts.scales.y.ticks) || {}, {
      font: CHART_FONT,
      // Added By Madhuri.K On 13-08-2026 - Purpose: Comma delimiter on Y-axis after spacing merge
      callback: function(val){ return formatNumberComma(val); }
    })
  });
  return opts;
}
function padSparseCategories(labels, datasets, fullLabels){
  if(!labels || labels.length !== 1){
    return { labels: labels, datasets: datasets, fullLabels: fullLabels || labels };
  }
  var paddedLabels = ["", labels[0], ""];
  var paddedFull = fullLabels ? ["", fullLabels[0], ""] : paddedLabels.slice();
  var paddedDatasets = (datasets || []).map(function(ds){
    var copy = Object.assign({}, ds);
    copy.data = [null].concat(ds.data || []).concat([null]);
    if(ds.hoursLabels) copy.hoursLabels = [null].concat(ds.hoursLabels).concat([null]);
    return copy;
  });
  return { labels: paddedLabels, datasets: paddedDatasets, fullLabels: paddedFull };
}
function apiArray(dataObj){
  if(!dataObj) return [];
  if(Array.isArray(dataObj)) return dataObj;
  var keys = Array.prototype.slice.call(arguments, 1);
  for(var i = 0; i < keys.length; i++){
    var v = apiVal(dataObj, keys[i]);
    if(Array.isArray(v)) return v;
  }
  return firstArrayIn(dataObj);
}

// Added By Madhuri.K on 30-07-2026 - Overview charts now sourced from /api/PlanVsActualDashboard/GetSummaryByLevel
// (one call returns all 3 level breakdowns together: Business Group / Organization Unit / Project).
// Modified By Madhuri.K On 06-08-2026 - Prefer level-specific name fields so OU/Project charts
// do not pick businessGroupName when that property is also present on the row.
function rowEntityName(row, preferredKeys){
  if(preferredKeys && preferredKeys.length){
    var preferred = apiVal.apply(null, [row].concat(preferredKeys));
    if(preferred != null && preferred !== "") return preferred;
  }
  return apiVal(row,
    "projectName", "ProjectName",
    "organizationUnitName", "OrganizationUnitName",
    "businessGroupName", "BusinessGroupName",
    "entityName", "EntityName",
    "levelName", "LevelName",
    "name", "Name"
  ) || "Unknown";
}

function firstArrayIn(dataObj){
  if(!dataObj) return [];
  const arr = Object.values(dataObj).find(v => Array.isArray(v));
  return arr || [];
}

function fetchSummaryByLevel(){
  const params = {
    businessGroupIDs: idsParam(FILTERS.businessGroup, BG_NAME_TO_ID),
    organizationUnitIDs: idsParam(FILTERS.organizationUnit, OU_NAME_TO_ID),
    projectIDs: idsParam(FILTERS.project, PROJECT_NAME_TO_ID),
    financialYears: [...FILTERS.year].join(","),
    monthKeys: [...FILTERS.month].join(",")
  };
  return fetch(encodeURI(strUrl) + '/api/PlanVsActualDashboard/GetSummaryByLevel', {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=utf-8",
        "Authorization": "bearer " + sessionStorage.getItem("access_token_W27_Dashboard")
        //Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
        ,"Params": encryptString(isJson(params) ? params : JSON.stringify(params)),
        //End of Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
    },
    body: JSON.stringify(params)
  })
  .then(res => { if(!res.ok) throw new Error("GetSummaryByLevel failed: " + res.status); return res.json(); })
  .then(json => (json && (json.data || json.Data)) || {});
}

function renderOverviewChart(chartKey, canvasId, rows, title, nameKeys){
  const canvas = document.getElementById(canvasId);
  if(!canvas){
    console.error("Overview chart canvas not found:", canvasId);
    return;
  }
  if(typeof Chart === "undefined"){
    console.error("Chart.js is not loaded — cannot render overview charts.");
    return;
  }
  if(charts[chartKey]){
    try { charts[chartKey].destroy(); } catch(ex) {}
    charts[chartKey] = null;
  }
  const agg = new Map();
  (rows || []).forEach(r => {
    const name = rowEntityName(r, nameKeys);
    if(!agg.has(name)) agg.set(name, { plannedMins: 0, actualMins: 0 });
    const e = agg.get(name);
    // Modified By Madhuri.K On 06-08-2026 - Aggregate H:MM via minutes so tooltips stay accurate
    e.plannedMins += hoursToMinutes(apiVal(r, "plannedHours", "PlannedHours", "planned_hours", "PlanHours"));
    e.actualMins += hoursToMinutes(apiVal(r, "actualHours", "ActualHours", "actual_hours", "ActualHrs"));
  });
  // Sort highest planned first so the main drivers are visible
  const labels = [...agg.keys()].sort(function(a, b){
    return (agg.get(b).plannedMins || 0) - (agg.get(a).plannedMins || 0);
  });
  const plannedData = labels.map(l => agg.get(l).plannedMins / 60);
  const actualData = labels.map(l => agg.get(l).actualMins / 60);
  const plannedLabels = labels.map(l => minutesToHoursDisplay(agg.get(l).plannedMins));
  const actualLabels = labels.map(l => minutesToHoursDisplay(agg.get(l).actualMins));
  // Added By Madhuri.K On 13-08-2026 - Purpose: Keep axis label on one line; full name still shown in chart tooltip
  /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
  const maxAxisLen = labels.length > 50 ? 10
    : (labels.length > 30 ? 12
    : (labels.length > 18 ? 14
    : (labels.length > 12 ? 16 : 26)));
  let chartLabels = labels.map(l => l.length > maxAxisLen ? l.slice(0, Math.max(6, maxAxisLen - 2)) + "..." : l);
  let chartDatasets = [
    { label: "Planned", data: plannedData, hoursLabels: plannedLabels, backgroundColor: "#2a78d6", hoverBackgroundColor: "#1c5cab", borderRadius: 4, borderSkipped: "bottom", maxBarThickness: labels.length <= 3 ? 48 : 24 },
    { label: "Actual", data: actualData, hoursLabels: actualLabels, backgroundColor: "#eb6834", hoverBackgroundColor: "#c94f1e", borderRadius: 4, borderSkipped: "bottom", maxBarThickness: labels.length <= 3 ? 48 : 24 }
  ];
  let fullLabels = labels.slice();
  if(labels.length === 1){
    const padded = padSparseCategories(chartLabels, chartDatasets, fullLabels);
    chartLabels = padded.labels;
    chartDatasets = padded.datasets;
    fullLabels = padded.fullLabels;
  }
  // Added By Madhuri.K On 13-08-2026 - Purpose: Enable SS angled (~45°) x-axis labels on Overview graphs when data is more
  charts[chartKey] = new Chart(canvas, {
    type: "bar",
    data: { labels: chartLabels, datasets: chartDatasets },
    options: baseBarOptions(title, labels.length, true)
  });
  // Added By Madhuri.K On 10-08-2026 - Full names for chart Details tooltip (not the truncated axis text)
  charts[chartKey].$pvaFullLabels = fullLabels;
}

let overviewRequestSeq = 0;
function renderCharts(){
  const requestId = ++overviewRequestSeq;
  destroyCharts();

  fetchSummaryByLevel().then(data => {
    if(requestId !== overviewRequestSeq) return; // a newer filter change superseded this request
    // Changed By Madhuri.K on 03-08-2026 - Resolve summary arrays with PascalCase/camelCase-safe lookup
    const bgRows = apiArray(data,
      "PlanVsActualBusinessGroupSummaryModel", "planVsActualBusinessGroupSummaryModel",
      "BusinessGroupSummary", "businessGroupSummary");
    const ouRows = apiArray(data,
      "PlanVsActualOrganizationUnitSummaryModel", "planVsActualOrganizationUnitSummaryModel",
      "OrganizationUnitSummary", "organizationUnitSummary");
    const projectRows = apiArray(data,
      "PlanVsActualProjectSummaryModel", "planVsActualProjectSummaryModel",
      "ProjectSummary", "projectSummary");

    if(!bgRows.length && !ouRows.length && !projectRows.length){
      console.warn("GetSummaryByLevel returned no chart rows. data keys:", data ? Object.keys(data) : data);
    }

    // Modified By Madhuri.K On 06-08-2026 - Pass level-specific name keys so each chart uses its own labels
    renderOverviewChart("dept", "chartDept", bgRows, "By Business Group",
      ["businessGroupName", "BusinessGroupName"]);
    renderOverviewChart("domain", "chartDomain", ouRows, "By Organization Unit",
      ["organizationUnitName", "OrganizationUnitName"]);
    renderOverviewChart("project", "chartProject", projectRows, "By Project",
      ["projectName", "ProjectName"]);
    // Modified By Madhuri.K On 05-08-2026 - Reflow charts after layout so resize does not overlap Analysis Table
    setTimeout(function(){ resizeOverviewCharts(); }, 0);
  }).catch(err => {
    if(requestId !== overviewRequestSeq) return;
    console.error("GetSummaryByLevel error:", err);
  });
}

// Added By Madhuri.K On 05-08-2026 - Keep overview Chart.js canvases inside .chart-box on window resize
function resizeOverviewCharts(){
  ["dept", "domain", "project"].forEach(function(k){
    if(charts[k] && typeof charts[k].resize === "function"){
      try { charts[k].resize(); } catch(ex) { console && console.warn && console.warn(ex); }
    }
  });
}
var overviewResizeTimer = null;
window.addEventListener("resize", function(){
  clearTimeout(overviewResizeTimer);
  overviewResizeTimer = setTimeout(resizeOverviewCharts, 150);
});

/* =========================================================================
   6b. TREND & HEATMAP
   ========================================================================= */
const PALETTE = ["#0f9b8e","#e0982f","#d0473f","#1c3358","#7c5cbf","#2f9e44","#c2410c","#0891b2"];

// Needed by sample data / FY filters
function fiscalQuarterOf(year, month){
  if(month >= 4 && month <= 6) return { fy: year, q: 1 };
  if(month >= 7 && month <= 9) return { fy: year, q: 2 };
  if(month >= 10 && month <= 12) return { fy: year, q: 3 };
  return { fy: year - 1, q: 4 };
}
function quarterKeyOf(fy, q){ return fy * 10 + q; }

function varianceColor(pct){
  if(pct > 10) return "#f8c9c5";
  if(pct < -10) return "#f5d9a8";
  return "#c8ebe6";
}

let trendLevel = "businessGroup";
// Modify By Madhuri.K on 03-08-2026 - Multi-select project names for Trend By Project
let trendProjectFilter = new Set();
let openTrendProjectPanel = false;
let trendProjectSearchTerm = "";
const TREND_LEVEL_LABELS = { businessGroup:"Business Group", organizationUnit:"Organization Unit", project:"Project" };
// levelFlag: 1 = Business Group, 2 = Organization Unit, 3 = Project (same convention as GetTrendData/GetAnalysisTable).
const TREND_LEVEL_FLAG = { businessGroup:1, organizationUnit:2, project:3 };

// Added By Madhuri.K On 07-08-2026 - Copy top Project selection into Trend dropdown (does not write back)
function syncTrendProjectFromTopFilter(){
  trendProjectFilter.clear();
  FILTERS.project.forEach(function(p){ trendProjectFilter.add(p); });
}

function updateTrendProjectDropdown(){
  const wrap = document.getElementById("trendProjectFilterWrap");
  const host = document.getElementById("trendProjectMselHost");
  if(!wrap || !host) return;
  if(trendLevel !== "project"){
    wrap.style.display = "none";
    openTrendProjectPanel = false;
    return;
  }
  wrap.style.display = "flex";

  // Modified By Madhuri.K On 07-08-2026 - When top Project has selections, Trend options limited to that set
  const allProjects = optionsFor("project").slice();
  const projects = FILTERS.project.size > 0
    ? allProjects.filter(function(p){ return FILTERS.project.has(p); })
    : allProjects;
  // Drop selections that are no longer in the available project list
  [...trendProjectFilter].forEach(p => { if(projects.indexOf(p) < 0) trendProjectFilter.delete(p); });

  host.innerHTML = "";
  const msel = document.createElement("div");
  msel.className = "msel";
  const btn = document.createElement("button");
  btn.className = "msel-btn";
  btn.type = "button";
  let btnLabel = "Select Project";
  if(trendProjectFilter.size === 1){
    // Modified By Madhuri.K On 06-08-2026 - Keep Project names in original API case
    btnLabel = String([...trendProjectFilter][0]);
  } else if(trendProjectFilter.size > 1){
    btnLabel = "Selected";
  }
  btn.innerHTML = "<span>" + btnLabel + "</span>" +
    (trendProjectFilter.size > 1
      ? '<span class="count">' + trendProjectFilter.size + "</span>"
      : '<span class="chev"><i class="fas fa-chevron-down"></i></span>');

  const panel = document.createElement("div");
  panel.className = "msel-panel";
  if(openTrendProjectPanel) panel.classList.add("open");
  panel.addEventListener("click", function(e){ e.stopPropagation(); });
  bindMselScrollPersist("trendProject", panel);

  const searchInput = document.createElement("input");
  searchInput.type = "text";
  searchInput.className = "msel-search";
  searchInput.placeholder = "Search Project...";
  searchInput.value = trendProjectSearchTerm || "";
  panel.appendChild(searchInput);

  const rowsWrap = document.createElement("div");
  panel.appendChild(rowsWrap);

  const emptyMsg = document.createElement("div");
  emptyMsg.className = "msel-empty";
  emptyMsg.textContent = "No matches";
  emptyMsg.style.display = "none";
  panel.appendChild(emptyMsg);

  function applySearchFilter(){
    const term = searchInput.value.trim().toLowerCase();
    let anyVisible = false;
    rowsWrap.querySelectorAll(".msel-row").forEach(function(row){
      const match = !term || row.dataset.label.indexOf(term) > -1;
      row.style.display = match ? "" : "none";
      if(match) anyVisible = true;
    });
    emptyMsg.style.display = anyVisible ? "none" : "block";
  }
  searchInput.addEventListener("input", function(){
    trendProjectSearchTerm = searchInput.value;
    applySearchFilter();
  });

  projects.forEach(function(opt){
    const row = document.createElement("label");
    row.className = "msel-row";
    // Modified By Madhuri.K On 06-08-2026 - Keep Project names in original API case
    const optLabel = String(opt);
    row.dataset.label = String(optLabel).toLowerCase();
    const cb = document.createElement("input");
    cb.type = "checkbox";
    cb.checked = trendProjectFilter.has(opt);
    cb.addEventListener("change", function(){
      rememberMselScroll("trendProject", panel);
      if(cb.checked) trendProjectFilter.add(opt); else trendProjectFilter.delete(opt);
      renderPvaTrendSection();
    });
    row.appendChild(cb);
    const txt = document.createElement("span");
    txt.textContent = optLabel;
    row.appendChild(txt);
    row.addEventListener("click", function(e){
      if(e.target !== cb){ cb.checked = !cb.checked; cb.dispatchEvent(new Event("change")); }
    });
    rowsWrap.appendChild(row);
  });
  applySearchFilter();

  const actions = document.createElement("div");
  actions.className = "msel-actions";
  const clearOne = document.createElement("button");
  clearOne.type = "button";
  clearOne.textContent = "Clear";
  clearOne.addEventListener("click", function(){
    // Modified By Madhuri.K On 07-08-2026 - Reset to top master selection (does not clear top) + clear search
    syncTrendProjectFromTopFilter();
    trendProjectSearchTerm = "";
    renderPvaTrendSection();
  });
  const closeOne = document.createElement("button");
  closeOne.type = "button";
  closeOne.textContent = "Close";
  closeOne.addEventListener("click", function(){
    openTrendProjectPanel = false;
    panel.classList.remove("open");
  });
  actions.appendChild(clearOne);
  actions.appendChild(closeOne);
  panel.appendChild(actions);

  btn.addEventListener("click", function(e){
    e.stopPropagation();
    if(openTrendProjectPanel){
      openTrendProjectPanel = false;
      panel.classList.remove("open");
    } else {
      openTrendProjectPanel = true;
      openFilterKey = null;
      document.querySelectorAll(".msel-panel.open").forEach(function(p){ if(p !== panel) p.classList.remove("open"); });
      panel.classList.add("open");
      searchInput.focus();
    }
  });

  msel.appendChild(btn);
  msel.appendChild(panel);
  host.appendChild(msel);
}

// Added By Madhuri.K on 30-07-2026 - Trend & Heatmap from GetTrendData
// Modify By Madhuri.K on 03-08-2026 - When Project tab has multi-select values, narrow via projectIDs
function fetchTrendData(levelFlag, pageNumber, pageSize){
  const pn = Number(pageNumber) || 0;
  const ps = Number(pageSize) || 0;
  let projectIDs = idsParam(FILTERS.project, PROJECT_NAME_TO_ID);
  let trendProjectID = 0;
  if(levelFlag === TREND_LEVEL_FLAG.project && trendProjectFilter.size > 0){
    const selectedIds = [...trendProjectFilter]
      .map(function(name){ return PROJECT_NAME_TO_ID[name]; })
      .filter(function(id){ return id !== undefined && id !== null; });
    if(FILTERS.project.size > 0){
      const topIds = new Set(
        [...FILTERS.project]
          .map(function(name){ return PROJECT_NAME_TO_ID[name]; })
          .filter(function(id){ return id !== undefined && id !== null; })
      );
      projectIDs = selectedIds.filter(function(id){ return topIds.has(id); }).join(",");
    } else {
      projectIDs = selectedIds.join(",");
    }
    // Backward-compatible single-id param when exactly one project is chosen
    if(selectedIds.length === 1) trendProjectID = selectedIds[0];
  }
  const params = {
    businessGroupIDs: idsParam(FILTERS.businessGroup, BG_NAME_TO_ID),
    organizationUnitIDs: idsParam(FILTERS.organizationUnit, OU_NAME_TO_ID),
    projectIDs: projectIDs,
    financialYears: [...FILTERS.year].join(","),
    monthKeys: [...FILTERS.month].join(","),
    levelFlag: levelFlag,
    trendProjectID: trendProjectID || 0,
    pageNumber: pn,
    pageSize: ps
  };
  return fetch(encodeURI(strUrl) + '/api/PlanVsActualDashboard/GetTrendData', {
    method: "POST",
    headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "bearer " + sessionStorage.getItem("access_token_W27_Dashboard")
        //Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
        , "Params": encryptString(isJson(params) ? params : JSON.stringify(params)),
        //End of Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
    },
    body: JSON.stringify(params)
  })
  .then(res => { if(!res.ok) throw new Error("GetTrendData failed: " + res.status); return res.json(); })
  /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
  .then(json => {
    const dataObj = (json && (json.data || json.Data)) || {};

    // Prefer named trend rows: data.PlanVsActualTrendModel
    let rows = apiArray(dataObj, "PlanVsActualTrendModel", "planVsActualTrendModel");
    if(!rows.length) rows = firstArrayIn(dataObj);

    // Total Records lives on each trend row (example: totalRecords: 5930), not as a root field.
    let totalRowCount = null;
    if(rows.length){
      totalRowCount = apiVal(rows[0], "totalRecords", "TotalRecords", "totalRowCount", "TotalRowCount", "totalCount", "TotalCount");
    }
    if(totalRowCount == null) totalRowCount = apiVal(json, "totalRecords", "TotalRecords", "totalRowCount", "TotalRowCount");
    if(totalRowCount == null) totalRowCount = apiVal(dataObj, "totalRecords", "TotalRecords", "totalRowCount", "TotalRowCount");

    if(totalRowCount != null && isFinite(Number(totalRowCount))){
      const n = Number(totalRowCount);
      // Never replace a larger API total with the current page length (e.g. 20).
      if(!trendTotalRecords || trendTotalRecords === 0 || n > trendTotalRecords){
        trendTotalRecords = n;
      }
    }

    let apiTotalPages = apiVal(json, "totalPages", "TotalPages", "totalPageCount", "TotalPageCount", "totalPage", "TotalPage");
    if(apiTotalPages == null){
      apiTotalPages = apiVal(dataObj, "totalPages", "TotalPages", "totalPageCount", "TotalPageCount", "totalPage", "TotalPage");
    }

    if(apiTotalPages != null && isFinite(Number(apiTotalPages)) && Number(apiTotalPages) > 0){
      const tp = Number(apiTotalPages);
      if(ps === 0 || !trendTotalPagesFromApi || trendTotalPagesFromApi === 0 || tp > trendTotalPagesFromApi){
        trendTotalPagesFromApi = tp;
      }
    }

    // Resolve final total pages for button enable/disable.
    if(trendTotalPagesFromApi != null && isFinite(Number(trendTotalPagesFromApi)) && Number(trendTotalPagesFromApi) > 0){
      trendTotalPages = Number(trendTotalPagesFromApi);
    } else if(trendTotalRecords != null && isFinite(Number(trendTotalRecords)) && Number(trendTotalRecords) > 0){
      trendTotalPages = Math.max(1, Math.ceil(Number(trendTotalRecords) / trendPageSize) || 1);
    } else {
      // Fallback: if API doesn't return totals, assume at least 1 page.
      trendTotalPages = Math.max(1, trendTotalPages || 1);
    }

    return rows;
  });
}

let trendRequestSeq = 0;

// Added By Madhuri.K on 19-08-2026 - Pagination for Trend & Heatmap
// Heatmap/chart paginate unique entities (10 per page). API rows are month-level.
const trendPageSize = 10;
let trendCurrentPage = 1;
let trendTotalPages = 1;
let trendTotalRecords = 0;
let trendTotalPagesFromApi = 0;
let lastTrendAllRows = [];

function isTrendTotalRow(r){
  if(apiVal(r, "isTotal", "IsTotal") === true) return true;
  const lbl = String(apiVal(r, "monthLabel", "MonthLabel") || "").trim().toLowerCase();
  return lbl === "total";
}

function getTrendNameKeys(){
  return trendLevel === "project"
    ? ["projectName", "ProjectName", "entityName", "EntityName"]
    : trendLevel === "organizationUnit"
      ? ["organizationUnitName", "OrganizationUnitName", "entityName", "EntityName"]
      : ["businessGroupName", "BusinessGroupName", "entityName", "EntityName"];
}

function getTrendUniqueEntities(rows, nameKeys){
  const seen = [];
  const set = new Set();
  (rows || []).forEach(function(r){
    if(isTrendTotalRow(r)) return;
    const e = rowEntityName(r, nameKeys);
    if(!set.has(e)){
      set.add(e);
      seen.push(e);
    }
  });
  return seen;
}

function updateTrendPaginationButtons(){
  const paginationWrap = document.getElementById("trendPagination");
  const prevBtn = document.getElementById("trendPrevBtn");
  const nextBtn = document.getElementById("trendNextBtn");
  const totalEl = document.getElementById("trendTotalRecords");

  if(paginationWrap){
    paginationWrap.style.display = "";
  }
  if(totalEl){
    totalEl.textContent = "Total Records: " + formatNumberComma(trendTotalRecords || 0, 0);
  }
  if(prevBtn){
    prevBtn.disabled = !trendTotalRecords || trendCurrentPage <= 1 || trendTotalPages <= 1;
  }
  if(nextBtn){
    nextBtn.disabled = !trendTotalRecords || trendCurrentPage >= trendTotalPages || trendTotalPages <= 1;
  }
}

function goToPreviousTrendPage(){
  if(trendCurrentPage > 1){
    trendCurrentPage--;
    paintTrendPage();
  }
}

function goToNextTrendPage(){
  if(trendCurrentPage < trendTotalPages){
    trendCurrentPage++;
    paintTrendPage();
  }
}

function renderPvaTrendSection(){
  updateTrendProjectDropdown();
  const requestId = ++trendRequestSeq;
  const chartBox = document.getElementById("pvaTrendChartBox");
  const wrap = document.getElementById("pvaHeatmapWrap");
  trendCurrentPage = 1;
  lastTrendAllRows = [];
  trendTotalRecords = 0;
  trendTotalPagesFromApi = 0;

  // pageNumber=1 / pageSize=10 would return month-rows for a limited set of entities.
  // Fetch all rows, then show 10 unique entities per page.
  /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
  fetchTrendData(TREND_LEVEL_FLAG[trendLevel], 0, 0).then(rows => {
    if(requestId !== trendRequestSeq) return;
    rows = rows || [];
    var apiTotal = rows.length && apiVal(rows[0], "totalRecords", "TotalRecords");
    // If pageSize=0 is truncated, re-fetch using the API total so all entities are available.
    if(apiTotal != null && isFinite(Number(apiTotal)) && Number(apiTotal) > rows.length){
      return fetchTrendData(TREND_LEVEL_FLAG[trendLevel], 1, Number(apiTotal)).then(function(allRows){
        if(requestId !== trendRequestSeq) return;
        lastTrendAllRows = allRows || rows;
        paintTrendPage();
      });
    }
    lastTrendAllRows = rows;
    paintTrendPage();
  }).catch(err => {
    if(requestId !== trendRequestSeq) return;
    console.error("GetTrendData error:", err);
    var msg = (err && String(err.message || err).indexOf("Chart.js") > -1)
      ? "Chart.js failed to load. Check script path ../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"
      : "Unable to load trend data.";
    chartBox.innerHTML = '<div class="empty-state">' + msg + '</div>';
    wrap.innerHTML = "";
  });
}

function paintTrendPage(){
  const levelLabel = TREND_LEVEL_LABELS[trendLevel] || trendLevel;
  const chartBox = document.getElementById("pvaTrendChartBox");
  const wrap = document.getElementById("pvaHeatmapWrap");
  const nameKeys = getTrendNameKeys();
  const rows = lastTrendAllRows || [];

  /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
  const monthRowsAll = rows.filter(function(r){ return !isTrendTotalRow(r); });
  const totalRows = rows.filter(isTrendTotalRow);
  const hasApiTotal = totalRows.length > 0;
  const allEntities = getTrendUniqueEntities(monthRowsAll, nameKeys);

  // Total Records = unique first-column entities (Business Group / OU / Project), not month-level API rows.
  trendTotalRecords = allEntities.length;
  trendTotalPages = Math.max(1, Math.ceil(trendTotalRecords / trendPageSize) || 1);
  if(trendCurrentPage > trendTotalPages) trendCurrentPage = trendTotalPages;

  const start = (trendCurrentPage - 1) * trendPageSize;
  const entities = allEntities.slice(start, start + trendPageSize);
  const entitySet = new Set(entities);
  const monthRows = monthRowsAll.filter(function(r){
    return entitySet.has(rowEntityName(r, nameKeys));
  });
    const monthKeys = [...new Set(monthRows.map(r => apiVal(r, "monthKey", "MonthKey")))].filter(k => k != null).sort((a, b) => a - b);
    // Prefer API monthLabel when present; strip apostrophe (Jun '26 -> Jun 26)
    const monthLabelByKey = {};
    monthRows.forEach(function(r){
      const mk = apiVal(r, "monthKey", "MonthKey");
      const ml = apiVal(r, "monthLabel", "MonthLabel");
      if(mk != null && ml != null && ml !== "" && monthLabelByKey[mk] == null){
        monthLabelByKey[mk] = cleanMonthLabel(String(ml));
      }
    });
    const monthLabels = monthKeys.map(function(mk){
      return cleanMonthLabel(monthLabelByKey[mk] || MONTH_LABELS[mk] || monthYearLabel(mk));
    });

    const grid = new Map();
    entities.forEach(e => grid.set(e, new Map()));
    monthRows.forEach(r => {
      const e = rowEntityName(r, nameKeys);
      const mk = apiVal(r, "monthKey", "MonthKey");
      if(mk == null) return;
      if(!grid.get(e).has(mk)) grid.get(e).set(mk, { plannedMins: 0, actualMins: 0, variancePercent: null });
      const cell = grid.get(e).get(mk);
      // Modified By Madhuri.K On 06-08-2026 - Store minutes so heatmap/tooltips show H:MM
      cell.plannedMins += hoursToMinutes(apiVal(r, "plannedHours", "PlannedHours"));
      cell.actualMins += hoursToMinutes(apiVal(r, "actualHours", "ActualHours"));
      // Modified By Madhuri.K On 07-08-2026 - Keep API variancePercent decimals (e.g. -98.17)
      const vp = apiVal(r, "variancePercent", "VariancePercent");
      if(vp != null && vp !== "" && isFinite(Number(vp))){
        cell.variancePercent = Number(vp);
      }
    });

    // Optional Total map from API total rows (entity -> variancePercent / hours)
    const totalByEntity = new Map();
    if(hasApiTotal){
      totalRows.forEach(function(r){
        const e = rowEntityName(r, nameKeys);
        totalByEntity.set(e, {
          plannedMins: hoursToMinutes(apiVal(r, "plannedHours", "PlannedHours")),
          actualMins: hoursToMinutes(apiVal(r, "actualHours", "ActualHours")),
          variancePercent: (function(){
            const vp = apiVal(r, "variancePercent", "VariancePercent");
            return (vp != null && vp !== "" && isFinite(Number(vp))) ? Number(vp) : null;
          })()
        });
      });
    }

    // Added By Madhuri.K On 13-08-2026 - Purpose: Comma delimiter on heatmap variance % values
    function formatTrendPct(pct){
      const n = Number(pct);
      if(!isFinite(n)) return "-";
      return formatPercentDisplay(n, 2, true);
    }

    if(charts.pvaTrend){ charts.pvaTrend.destroy(); charts.pvaTrend = null; }

    if(!entities.length || !monthKeys.length){
      chartBox.innerHTML = '<div class="empty-state">No data matches the current filters.</div>';
    } else {
      if(!document.getElementById("chartPvaTrend")){
        chartBox.innerHTML = '<canvas id="chartPvaTrend"></canvas>';
      }
      if(typeof Chart === "undefined"){
        /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
        chartBox.innerHTML = '<div class="empty-state">Chart.js failed to load. Check script path ../../../Whizible2.0-new/plugins/chartjs/Chart.min.js</div>';
      } else {
      let datasets = [];
      entities.forEach((e, i) => {
        const col = PALETTE[i % PALETTE.length];
        const actualData = monthKeys.map(mk => grid.get(e).has(mk) ? grid.get(e).get(mk).actualMins / 60 : null);
        const plannedData = monthKeys.map(mk => grid.get(e).has(mk) ? grid.get(e).get(mk).plannedMins / 60 : null);
        const actualLabels = monthKeys.map(mk => grid.get(e).has(mk) ? minutesToHoursDisplay(grid.get(e).get(mk).actualMins) : null);
        const plannedLabels = monthKeys.map(mk => grid.get(e).has(mk) ? minutesToHoursDisplay(grid.get(e).get(mk).plannedMins) : null);
        const shortE = e.length > 26 ? e.slice(0, 24) + "..." : e;
        datasets.push({
          label: shortE + " (Actual)",
          pvaFullLabel: e + " (Actual)",
          data: actualData,
          hoursLabels: actualLabels,
          borderColor: col, backgroundColor: col,
          borderWidth: 2, tension: 0.3, fill: false, spanGaps: true, pointRadius: 3
        });
        datasets.push({
          label: shortE + " (Planned)",
          pvaFullLabel: e + " (Planned)",
          data: plannedData,
          hoursLabels: plannedLabels,
          borderColor: col, backgroundColor: "#fff",
          borderWidth: 2, borderDash: [6, 4], tension: 0.3, fill: false, spanGaps: true,
          pointRadius: 3, pointBackgroundColor: "#fff", pointBorderColor: col, pointBorderWidth: 2
        });
      });
      let chartMonthLabels = monthLabels.slice();
      let tipFullLabels = monthLabels.slice();
      if(monthKeys.length === 1){
        const padded = padSparseCategories(chartMonthLabels, datasets, tipFullLabels);
        chartMonthLabels = padded.labels;
        datasets = padded.datasets;
        tipFullLabels = padded.fullLabels;
      }
      charts.pvaTrend = new Chart(document.getElementById("chartPvaTrend"), {
        type: "line",
        data: { labels: chartMonthLabels, datasets: datasets },
        options: baseBarOptions("Planned vs Actual Hours - by " + levelLabel, monthKeys.length)
      });
      // Full month labels for Details tooltip header on Trend graph
      charts.pvaTrend.$pvaFullLabels = tipFullLabels;
      }
    }

    if(!entities.length || !monthKeys.length){
      wrap.innerHTML = '<div class="empty-state">No data matches the current filters.</div>';
      updateTrendPaginationButtons();
      return;
    }
    let html = '<table class="heatmap-table"><thead><tr><th>' + levelLabel + "</th>";
    monthLabels.forEach(l => { html += "<th>" + l + "</th>"; });
    // Modified By Madhuri.K On 07-08-2026 - Show Total column only when API returns total rows
    if(hasApiTotal) html += "<th>Total</th>";
    html += "</tr></thead><tbody>";
    entities.forEach(e => {
      html += '<tr><td class="entity">' + e + "</td>";
      monthKeys.forEach(mk => {
        const cell = grid.get(e).get(mk);
        if(cell){
          const pct = (cell.variancePercent != null && isFinite(cell.variancePercent))
            ? cell.variancePercent
            : (cell.plannedMins ? ((cell.actualMins - cell.plannedMins) / cell.plannedMins * 100) : 0);
          const pDisp = minutesToHoursDisplay(cell.plannedMins);
          const aDisp = minutesToHoursDisplay(cell.actualMins);
          html += '<td><div class="heatmap-cell" style="background:' + varianceColor(pct) + ';" title="Planned ' + pDisp + ' / Actual ' + aDisp + '">' + formatTrendPct(pct) + "</div></td>";
        } else {
          html += '<td><div class="heatmap-cell" style="background:#f4f6f9;color:#6b7280;">-</div></td>';
        }
      });
      if(hasApiTotal){
        const tot = totalByEntity.get(e);
        if(tot){
          const totalPct = (tot.variancePercent != null && isFinite(tot.variancePercent))
            ? tot.variancePercent
            : (tot.plannedMins ? ((tot.actualMins - tot.plannedMins) / tot.plannedMins * 100) : 0);
          const totTitle = "Planned " + minutesToHoursDisplay(tot.plannedMins) + " / Actual " + minutesToHoursDisplay(tot.actualMins);
          html += '<td><div class="heatmap-cell" style="background:' + varianceColor(totalPct) + ';font-weight:700;" title="' + totTitle + '">' + formatTrendPct(totalPct) + "</div></td>";
        } else {
          html += '<td><div class="heatmap-cell" style="background:#f4f6f9;color:#6b7280;">-</div></td>';
        }
      }
      html += "</tr>";
    });
    html += "</tbody></table>";
    wrap.innerHTML = html;
    wrap.scrollTop = 0;
    wrap.scrollLeft = 0;
    /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
    updateTrendPaginationButtons();
}

document.getElementById("trendLevelTabs").addEventListener("click", function(e){
  const btn = e.target.closest("button");
  if(!btn) return;
  document.querySelectorAll("#trendLevelTabs button").forEach(b => b.classList.remove("active"));
  btn.classList.add("active");
  trendLevel = btn.dataset.level;
  if(trendLevel === "project"){
    // Added By Madhuri.K On 07-08-2026 - Seed Trend Project from top filter when Project tab opens
    syncTrendProjectFromTopFilter();
  } else {
    trendProjectFilter.clear();
    openTrendProjectPanel = false;
    trendProjectSearchTerm = "";
  }
  renderPvaTrendSection();
});

/* =========================================================================
   7. TABLE
   ========================================================================= */
let currentLevel = "project"; // Modify By Madhuri.K on 27-07-2026 - default matches first Analysis tab
// Modified By Madhuri.K On 07-08-2026 - Default keep API row order (ascending as returned); column click still sorts
let sortState = {col:null, dir:"asc"};
// Added By Madhuri.K on 31-07-2026 - Project tab / Resource tab drill-down dropdown selections
// Modified By Madhuri.K On 07-08-2026 - Multi-select Sets (same pattern as Trend Project filter)
// Modified By Madhuri.K On 07-08-2026 - Analysis Project is separate from top; top is master (one-way sync down)
let analysisProjectFilter = new Set();
let analysisResourceFilter = new Set();
// Added By Madhuri.K On 06-08-2026 - Searchable Analysis Project/Resource dropdown state
let openAnalysisProjectPanel = false;
let openAnalysisResourcePanel = false;
let analysisProjectSearchTerm = "";
let analysisResourceSearchTerm = "";

// Added By Madhuri.K On 07-08-2026 - Copy top Project selection into Analysis dropdown (does not write back)
function syncAnalysisProjectFromTopFilter(){
  analysisProjectFilter.clear();
  FILTERS.project.forEach(function(p){ analysisProjectFilter.add(p); });
}

// Added By Madhuri.K on 29-07-2026 - Analysis Table now sourced from /api/PlanVsActualDashboard/GetAnalysisTable
// levelFlag: 1 = Project, 2 = Business Group, 3 = Organization Unit, 4 = Resource.
const ANALYSIS_LEVEL_CONFIG = {
  businessGroup: { labels:["Business Group"], fields:["businessGroupName"] },
  organizationUnit: { labels:["Business Group","Organization Unit"], fields:["businessGroupName","organizationUnitName"] },
  project: { labels:["Business Group","Organization Unit","Project"], fields:["businessGroupName","organizationUnitName","projectName"] },
  resource: { labels:["Resource"], fields:["resourceName"] }
};
const ANALYSIS_LEVEL_FLAG = { project:1, businessGroup:2, organizationUnit:3, resource:4 };

function analysisFieldValue(row, field){
  var v = apiVal(row, field, field.charAt(0).toUpperCase() + field.slice(1));
  if(v != null) return v;
  if(field === "resourceName"){
    return apiVal(row, "employeeName", "EmployeeName", "resource", "Resource") || "Unknown";
  }
  // PascalCase variant of camelCase field (businessGroupName -> BusinessGroupName)
  var pascal = field.replace(/^[a-z]/, function(c){ return c.toUpperCase(); }).replace(/([a-z])([A-Z])/g, "$1$2");
  v = apiVal(row, pascal);
  return v != null ? v : "Unknown";
}

function fetchAnalysisTable(levelFlag, pageNumber, pageSize){
  // Modified By Madhuri.K On 07-08-2026 - Top Project is master; Analysis can further narrow only
  var ps = Number(pageSize) || 0;
  let projectIDs = idsParam(FILTERS.project, PROJECT_NAME_TO_ID);
  if(currentLevel === "project" && analysisProjectFilter.size > 0){
    const selectedIds = [...analysisProjectFilter]
      .map(function(name){ return PROJECT_NAME_TO_ID[name]; })
      .filter(function(id){ return id !== undefined && id !== null; });
    if(FILTERS.project.size > 0){
      const topIds = new Set(
        [...FILTERS.project]
          .map(function(name){ return PROJECT_NAME_TO_ID[name]; })
          .filter(function(id){ return id !== undefined && id !== null; })
      );
      projectIDs = selectedIds.filter(function(id){ return topIds.has(id); }).join(",");
    } else {
      projectIDs = selectedIds.join(",");
    }
  }
  const params = {
    businessGroupIDs: idsParam(FILTERS.businessGroup, BG_NAME_TO_ID),
    organizationUnitIDs: idsParam(FILTERS.organizationUnit, OU_NAME_TO_ID),
    projectIDs: projectIDs,
    financialYears: [...FILTERS.year].join(","),
    monthKeys: [...FILTERS.month].join(","),
    levelFlag: levelFlag,
    // Added By Request - Pagination compatibility fields (we fetch all for UI pagination)
    pageNumber: Number(pageNumber) || 0,
    pageSize: Number(pageSize) || 0
  };
  return fetch(encodeURI(strUrl) + '/api/PlanVsActualDashboard/GetAnalysisTable', {
    method: "POST",
    headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "bearer " + sessionStorage.getItem("access_token_W27_Dashboard")
        //Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
        ,"Params": encryptString(isJson(params) ? params : JSON.stringify(params)),
        //End of Added by Vishal Mane on 12/08/2026 tom add validate headers for every API
    },
    body: JSON.stringify(params)
  })
  .then(res => { if(!res.ok) throw new Error("GetAnalysisTable failed: " + res.status); return res.json(); })
  .then(json => {
    // Modified By Madhuri.K On 06-08-2026 - Read row + total models; keep H:MM strings for display
    var dataObj = (json && (json.data || json.Data)) || {};
    var rows = apiArray(dataObj, "PlanVsActualAnalysisRowModel", "planVsActualAnalysisRowModel");
    if(!rows.length) rows = firstArrayIn(dataObj);
    var totals = apiArray(dataObj, "PlanVsActualAnalysisTotalModel", "planVsActualAnalysisTotalModel");
    
    /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
    // Keep totals stable across pagination. Some APIs only return total model on pageSize=0 calls.
    if(totals && totals.length){
      lastAnalysisTotal = totals[0];
    }

    // Primary source for total records returned by your API:
    // PlanVsActualAnalysisTotalModel[0].totalRowCount (example: 559)
    var totalRowCount = (totals && totals.length) ? apiVal(totals[0], "totalRowCount", "TotalRowCount") : null;
    if(totalRowCount != null && isFinite(Number(totalRowCount))){
      analysisTotalRecords = Number(totalRowCount);
      analysisTotalPagesFromApi = Math.max(1, Math.ceil(analysisTotalRecords / analysisPageSize) || 1);
    }

    // Server pagination: API may return total record count / total pages under different key casing.
    var apiTotalPages = apiVal(json, "totalPages", "TotalPages", "totalPageCount", "TotalPageCount", "TotalPage");
    if(apiTotalPages == null){
      apiTotalPages = apiVal(dataObj, "totalPages", "TotalPages", "totalPageCount", "TotalPageCount", "TotalPage");
    }
    if(apiTotalPages != null && isFinite(Number(apiTotalPages)) && Number(apiTotalPages) > 0){
      // Only overwrite when:
      // - this is the 0/0 totals fetch (ps===0), or
      // - the new value is larger (avoid per-page overwrites)
      if(ps === 0 || !analysisTotalPagesFromApi || analysisTotalPagesFromApi === 0 || Number(apiTotalPages) > analysisTotalPagesFromApi){
        analysisTotalPagesFromApi = Number(apiTotalPages);
      }
    }

    var totalRecords = apiVal(json, "totalRecords", "TotalRecords", "totalCount", "TotalCount", "count", "Count");
    if(totalRecords == null){
      totalRecords = apiVal(dataObj, "totalRecords", "TotalRecords", "totalCount", "TotalCount", "count", "Count");
    }
    if(totalRecords != null && isFinite(Number(totalRecords))){
      var nTotalRecords = Number(totalRecords);
      if(ps === 0 || !analysisTotalRecords || analysisTotalRecords === 0 || nTotalRecords > analysisTotalRecords){
        analysisTotalRecords = nTotalRecords;
      }
    } else if(!analysisTotalRecords || analysisTotalRecords === 0){
      analysisTotalRecords = rows.length;
    }
    return rows;
  });
}

// Modified By Madhuri.K On 07-08-2026 - Shared searchable multi-select builder (Analysis Project / Resource)
function buildAnalysisMultiSelect(host, opts){
  const options = opts.options || [];
  const selectedSet = opts.selectedSet || new Set();
  const placeholder = opts.placeholder || "Select";
  const searchPlaceholder = opts.searchPlaceholder || "Search...";
  const isOpen = !!opts.isOpen;
  const searchTerm = opts.searchTerm || "";
  const scrollKey = opts.scrollKey || "";
  const onToggle = opts.onToggle || function(){};
  const onSearch = opts.onSearch || function(){};
  const onChange = opts.onChange || function(){};
  const onClear = opts.onClear || function(){};

  host.innerHTML = "";
  const msel = document.createElement("div");
  msel.className = "msel";

  const btn = document.createElement("button");
  btn.className = "msel-btn";
  btn.type = "button";
  let btnLabel = placeholder;
  if(selectedSet.size === 1){
    btnLabel = String([...selectedSet][0]);
  } else if(selectedSet.size > 1){
    btnLabel = "Selected";
  }
  btn.innerHTML = "<span>" + btnLabel + "</span>" +
    (selectedSet.size > 1
      ? '<span class="count">' + selectedSet.size + "</span>"
      : '<span class="chev"><i class="fas fa-chevron-down"></i></span>');

  const panel = document.createElement("div");
  panel.className = "msel-panel";
  if(isOpen) panel.classList.add("open");
  panel.addEventListener("click", function(e){ e.stopPropagation(); });
  bindMselScrollPersist(scrollKey, panel);

  const searchInput = document.createElement("input");
  searchInput.type = "text";
  searchInput.className = "msel-search";
  searchInput.placeholder = searchPlaceholder;
  searchInput.value = searchTerm;
  panel.appendChild(searchInput);

  const rowsWrap = document.createElement("div");
  panel.appendChild(rowsWrap);

  const emptyMsg = document.createElement("div");
  emptyMsg.className = "msel-empty";
  emptyMsg.textContent = "No matches";
  emptyMsg.style.display = "none";
  panel.appendChild(emptyMsg);

  function applySearchFilter(){
    const term = searchInput.value.trim().toLowerCase();
    let anyVisible = false;
    rowsWrap.querySelectorAll(".msel-row").forEach(function(row){
      const match = !term || row.dataset.label.indexOf(term) > -1;
      row.style.display = match ? "" : "none";
      if(match) anyVisible = true;
    });
    if(options.length === 0){
      emptyMsg.textContent = "No options";
      emptyMsg.style.display = "block";
    } else {
      emptyMsg.textContent = "No matches";
      emptyMsg.style.display = anyVisible ? "none" : "block";
    }
  }
  searchInput.addEventListener("input", function(){
    onSearch(searchInput.value);
    applySearchFilter();
  });

  options.forEach(function(opt){
    const row = document.createElement("label");
    row.className = "msel-row";
    const optLabel = String(opt);
    row.dataset.label = String(optLabel).toLowerCase();
    const cb = document.createElement("input");
    cb.type = "checkbox";
    cb.checked = selectedSet.has(opt);
    cb.addEventListener("change", function(){
      rememberMselScroll(scrollKey, panel);
      if(cb.checked) selectedSet.add(opt); else selectedSet.delete(opt);
      onChange();
    });
    row.appendChild(cb);
    const txt = document.createElement("span");
    txt.textContent = optLabel;
    row.appendChild(txt);
    row.addEventListener("click", function(e){
      if(e.target !== cb){ cb.checked = !cb.checked; cb.dispatchEvent(new Event("change")); }
    });
    rowsWrap.appendChild(row);
  });
  applySearchFilter();

  const actions = document.createElement("div");
  actions.className = "msel-actions";
  const clearOne = document.createElement("button");
  clearOne.type = "button";
  clearOne.textContent = "Clear";
  clearOne.addEventListener("click", function(){ onClear(); });
  const closeOne = document.createElement("button");
  closeOne.type = "button";
  closeOne.textContent = "Close";
  closeOne.addEventListener("click", function(){
    onToggle(false);
    panel.classList.remove("open");
  });
  actions.appendChild(clearOne);
  actions.appendChild(closeOne);
  panel.appendChild(actions);

  btn.addEventListener("click", function(e){
    e.stopPropagation();
    const nextOpen = !panel.classList.contains("open");
    openFilterKey = null;
    openTrendProjectPanel = false;
    openAnalysisProjectPanel = false;
    openAnalysisResourcePanel = false;
    document.querySelectorAll(".msel-panel.open").forEach(function(p){ p.classList.remove("open"); });
    onToggle(nextOpen);
    if(nextOpen){
      panel.classList.add("open");
      searchInput.focus();
    }
  });

  msel.appendChild(btn);
  msel.appendChild(panel);
  host.appendChild(msel);
}

// Added By Madhuri.K on 31-07-2026 - Project dropdown (Project tab only), options from the same
// master-data cascade as the top filter bar's Project filter.
// Modified By Madhuri.K On 06-08-2026 - Searchable dropdown instead of plain <select>
// Modified By Madhuri.K On 07-08-2026 - Multi-select with checkboxes
// Modified By Madhuri.K On 07-08-2026 - Separate from top filter; changes here do not update top
function updateAnalysisProjectDropdown(){
  const wrap = document.getElementById("analysisProjectFilterWrap");
  const host = document.getElementById("analysisProjectMselHost");
  if(!wrap || !host) return;
  if(currentLevel !== "project"){
    wrap.style.display = "none";
    openAnalysisProjectPanel = false;
    return;
  }
  wrap.style.display = "flex";
  // When top Project has selections, Analysis options are limited to that master set
  const allProjects = optionsFor("project").slice();
  const projects = FILTERS.project.size > 0
    ? allProjects.filter(function(p){ return FILTERS.project.has(p); })
    : allProjects;
  [...analysisProjectFilter].forEach(function(p){
    if(projects.indexOf(p) < 0) analysisProjectFilter.delete(p);
  });
  buildAnalysisMultiSelect(host, {
    options: projects,
    selectedSet: analysisProjectFilter,
    placeholder: "Select Project",
    searchPlaceholder: "Search Project...",
    isOpen: openAnalysisProjectPanel,
    searchTerm: analysisProjectSearchTerm,
    scrollKey: "analysisProject",
    onToggle: function(open){ openAnalysisProjectPanel = open; },
    onSearch: function(term){ analysisProjectSearchTerm = term; },
    onChange: function(){ renderTable(); },
    onClear: function(){
      // Reset Analysis selection to top master (does not clear top filter)
      syncAnalysisProjectFromTopFilter();
      analysisProjectSearchTerm = "";
      openAnalysisProjectPanel = false;
      renderTable();
    }
  });
}

// Resource dropdown (Resource tab only). Options + filter rows come from the full Resource
// list (totals / full fetch), not the current page — so selecting a Resource always finds data.
// Modified By Madhuri.K On 06-08-2026 - Searchable dropdown instead of plain <select>
// Modified By Madhuri.K On 07-08-2026 - Multi-select with checkboxes
// Modified By Madhuri.K On 21-08-2026 - Show all Resources; filter against full row cache
function setAllAnalysisResourceOptionsFromRows(rows){
  allAnalysisResourceRows = Array.isArray(rows) ? rows.slice() : [];
  allAnalysisResourceOptions = [...new Set(allAnalysisResourceRows.map(function(r){
    return analysisFieldValue(r, "resourceName");
  }).filter(function(n){ return n != null && String(n).trim() !== ""; }))];
  allAnalysisResourceOptions.sort(function(a, b){
    return String(a).localeCompare(String(b), undefined, { sensitivity: "base", numeric: true });
  });
}

function updateAnalysisResourceDropdown(){
  const wrap = document.getElementById("analysisResourceFilterWrap");
  const host = document.getElementById("analysisResourceMselHost");
  if(!wrap || !host) return;
  if(currentLevel !== "resource"){
    wrap.style.display = "none";
    openAnalysisResourcePanel = false;
    return;
  }
  wrap.style.display = "flex";
   /* Modify By Madhuri.K on 21-08-2026 */
  // Prefer full cached list; fall back to current page only if master list not ready yet
  let resources = allAnalysisResourceOptions.slice();
  if(!resources.length){
    resources = [...new Set(lastAnalysisRows.map(function(r){ return analysisFieldValue(r, "resourceName"); }))];
    resources.sort(function(a, b){
      return String(a).localeCompare(String(b), undefined, { sensitivity: "base", numeric: true });
    });
  }
  [...analysisResourceFilter].forEach(function(name){
    if(resources.indexOf(name) < 0) analysisResourceFilter.delete(name);
  });
  buildAnalysisMultiSelect(host, {
    options: resources,
    selectedSet: analysisResourceFilter,
    placeholder: "Select Resource",
    searchPlaceholder: "Search Resource...",
    isOpen: openAnalysisResourcePanel,
    searchTerm: analysisResourceSearchTerm,
    scrollKey: "analysisResource",
    onToggle: function(open){ openAnalysisResourcePanel = open; },
    onSearch: function(term){ analysisResourceSearchTerm = term; },
    onChange: function(){
      analysisCurrentPage = 1;
      updateAnalysisResourceDropdown();
      renderTableBody();
    },
    onClear: function(){
      analysisResourceFilter.clear();
      analysisResourceSearchTerm = "";
      openAnalysisResourcePanel = false;
      analysisCurrentPage = 1;
      updateAnalysisResourceDropdown();
      // Restore server page 1 when Resource filter is cleared
      if(currentLevel === "resource") loadAnalysisPage();
      else renderTableBody();
    }
  });
}

function buildTableRows(rows){
  const cfg = ANALYSIS_LEVEL_CONFIG[currentLevel];
  // Modified By Madhuri.K On 06-08-2026 - Keep API H:MM / variancePercent for UI; numeric only for sort
  let tableRows = rows.map(r=>{
    const parts = cfg.fields.map(f => analysisFieldValue(r, f));
    const plannedRaw = apiVal(r, "plannedHours", "PlannedHours");
    const actualRaw = apiVal(r, "actualHours", "ActualHours");
    const varianceRaw = apiVal(r, "varianceHours", "VarianceHours");
    const planned = hoursToNumber(plannedRaw);
    const actual = hoursToNumber(actualRaw);
    const variance = (varianceRaw != null && varianceRaw !== "")
      ? hoursToNumber(varianceRaw)
      : (actual - planned);
    const variancePctRaw = apiVal(r, "variancePercent", "VariancePercent");
    const variancePct = (variancePctRaw != null && variancePctRaw !== "" && isFinite(Number(variancePctRaw)))
      ? Number(variancePctRaw)
      : (planned ? variance / planned * 100 : 0);
    return {
      parts, planned, actual, variance, variancePct,
      plannedDisp: formatHoursDisplay(plannedRaw),
      actualDisp: formatHoursDisplay(actualRaw),
      varianceDisp: formatHoursDisplay(varianceRaw != null && varianceRaw !== "" ? varianceRaw : variance)
    };
  });
  // Modified By Madhuri.K On 07-08-2026 / 11-08-2026 - Sort any column (label parts or numeric)
  if(sortState.col){
    tableRows.sort((a,b)=>{
      let av, bv, cmp;
      if(String(sortState.col).indexOf("part") === 0){
        const idx = Number(String(sortState.col).replace("part", "")) || 0;
        av = a.parts[idx] != null ? a.parts[idx] : "";
        bv = b.parts[idx] != null ? b.parts[idx] : "";
        cmp = String(av).localeCompare(String(bv), undefined, { sensitivity: "base", numeric: true });
        return sortState.dir === "asc" ? cmp : -cmp;
      }
      if(sortState.col==="label"){
        av = a.parts.join(" ");
        bv = b.parts.join(" ");
        cmp = String(av).localeCompare(String(bv), undefined, { sensitivity: "base", numeric: true });
        return sortState.dir === "asc" ? cmp : -cmp;
      }
      av = a[sortState.col];
      bv = b[sortState.col];
      if(av<bv) return sortState.dir==="asc"?-1:1;
      if(av>bv) return sortState.dir==="asc"?1:-1;
      return 0;
    });
  }
  return tableRows;
}

// Added By Madhuri.K On 10-08-2026 - Variance % bands for KPI Utilization / Analysis badges
// pct > +10 → Over-utilized; pct < -10 → Under-utilized; -10 to +10 (inclusive) → On-plan
function varianceBadgeMeta(variancePct){
  const pct = Number(variancePct) || 0;
  if(pct > 10) return { cls: "over", label: "Over-utilized" };
  if(pct < -10) return { cls: "under", label: "Under-utilized" };
  return { cls: "ok", label: "On-plan" };
}

function renderTableHead(cfg){
  const head = document.getElementById("tableHead");
  head.innerHTML = "";
  // Modified By Madhuri.K On 11-08-2026 - All columns sortable; arrow stays inline with header
  cfg.labels.forEach((lbl, idx)=>{
    const key = "part" + idx;
    const th = document.createElement("th");
    const arrow = sortState.col===key ? (sortState.dir==="asc"?"↑":"↓") : "";
    th.innerHTML = `<span class="th-inner"><span class="th-text">${lbl}</span><span class="arrow">${arrow}</span></span>`;
    th.addEventListener("click", ()=>{
      sortState.dir = sortState.col===key && sortState.dir==="desc" ? "asc" : "desc";
      sortState.col = key;
      renderTableHead(cfg);
      analysisCurrentPage = 1;
      renderTableBody();
    });
    head.appendChild(th);
  });
  [["planned","Planned"],["actual","Actual"],["variance","Variance"],["variancePct","Var %"]].forEach(([key,lbl])=>{
    const th = document.createElement("th");
    th.className = "num";
    const arrow = sortState.col===key ? (sortState.dir==="asc"?"↑":"↓") : "";
    th.innerHTML = `<span class="th-inner"><span class="th-text">${lbl}</span><span class="arrow">${arrow}</span></span>`;
    th.addEventListener("click", ()=>{
      sortState.dir = sortState.col===key && sortState.dir==="desc" ? "asc" : "desc";
      sortState.col = key;
      renderTableHead(cfg);
      analysisCurrentPage = 1;
      renderTableBody();
    });
    head.appendChild(th);
  });
}

let lastAnalysisRows = [];
let lastAnalysisTotal = null;
// Added By Madhuri.K on 21-08-2026 - Full Resource name list for Analysis Resource dropdown (not page-sliced)
let allAnalysisResourceOptions = [];
// Added By Madhuri.K on 21-08-2026 - Full Resource rows for dropdown filter (so selection is not limited to current page)
let allAnalysisResourceRows = [];
// Added By Madhuri.K on 19-08-2026 - Analysis pagination UI (10 rows per page)
const analysisPageSize = 10;
let analysisCurrentPage = 1;
let analysisTotalPages = 1;
let analysisTotalRecords = 0;
let analysisTotalPagesFromApi = 0;
function renderTableBody(){
  const cfg = ANALYSIS_LEVEL_CONFIG[currentLevel];
  const body = document.getElementById("tableBody");
  const foot = document.getElementById("tableFoot");
  let sourceRows = lastAnalysisRows;
  const clientFiltered = (currentLevel === "resource" && analysisResourceFilter.size > 0);
  // Modified By Madhuri.K On 21-08-2026 - When Resource dropdown has a selection, filter the
  // full Resource row cache (not only the current API page) so matching names always show.
  if(clientFiltered){
    const pool = (allAnalysisResourceRows && allAnalysisResourceRows.length)
      ? allAnalysisResourceRows
      : lastAnalysisRows;
    sourceRows = pool.filter(function(r){
      return analysisResourceFilter.has(analysisFieldValue(r, "resourceName"));
    });
  }
  const rows = buildTableRows(sourceRows);

  const filteredCount = rows.length;
  // Server pagination when unfiltered; client pagination when Resource filter is active
  if(clientFiltered){
    analysisTotalPages = Math.max(1, Math.ceil(filteredCount / analysisPageSize) || 1);
  } else if(analysisTotalPagesFromApi != null && isFinite(Number(analysisTotalPagesFromApi)) && Number(analysisTotalPagesFromApi) > 0){
    analysisTotalPages = Number(analysisTotalPagesFromApi);
  } else {
    const totalForPages = (analysisTotalRecords != null && isFinite(Number(analysisTotalRecords)))
      ? Number(analysisTotalRecords)
      : filteredCount;
    analysisTotalPages = Math.max(1, Math.ceil(totalForPages / analysisPageSize) || 1);
  }
  if(analysisCurrentPage > analysisTotalPages) analysisCurrentPage = analysisTotalPages;
  if(analysisCurrentPage < 1) analysisCurrentPage = 1;
  const pagedRows = clientFiltered
    ? rows.slice((analysisCurrentPage - 1) * analysisPageSize, analysisCurrentPage * analysisPageSize)
    : rows; // already current page from API

  body.innerHTML = "";
  if(!filteredCount){
    body.innerHTML = `<tr><td colspan="${cfg.labels.length+4}"><div class="empty-state">No data matches the current filters.</div></td></tr>`;
  } else {
    pagedRows.forEach(r=>{
      const tr = document.createElement("tr");
      const labelCells = r.parts.map(p=>`<td>${p}</td>`).join("");
      // Modified By Madhuri.K On 10-08-2026 - Var % badge: Over-utilized / Under-utilized / On-plan (±10%)
      // Added By Madhuri.K On 13-08-2026 - Purpose: Comma delimiter on Analysis Var % text
      const badge = varianceBadgeMeta(r.variancePct);
      const pctTxt = formatPercentDisplay(r.variancePct, 2, true);
      // Modified By Madhuri.K On 06-08-2026 - Show Planned/Actual/Variance as API H:MM (e.g. 100:00, 08:00, -92:00)
      // Added By Madhuri.K On 13-08-2026 - Purpose: var-pct wrap keeps % + badge on one line
      tr.innerHTML = `${labelCells}
        <td class="num">${r.plannedDisp}</td>
        <td class="num">${r.actualDisp}</td>
        <td class="num">${r.varianceDisp}</td>
        <td class="num var-pct"><span class="var-pct-wrap">${pctTxt} <span class="badge-var ${badge.cls}">${badge.label}</span></span></td>`;
      body.appendChild(tr);
    });
  }

  // Footer totals = API totals (must not change when clicking Prev/Next).
  // When Resource filter is active, footer sums the filtered selection instead.
  /* Added By Madhuri.K On 20-08-2026 - Analysis Table - Purpose: Pagination - Previous / Next / Page Size dropdown */
  let plannedDisp, actualDisp, varianceDisp, footBadge, footPctTxt;
  if(clientFiltered){
    const totalPlanned = rows.reduce((s,r)=>s+r.planned,0);
    const totalActual = rows.reduce((s,r)=>s+r.actual,0);
    const totalVar = totalActual - totalPlanned;
    const totalVarPct = totalPlanned ? totalVar / totalPlanned * 100 : 0;
    plannedDisp = formatHoursDisplay(totalPlanned);
    actualDisp = formatHoursDisplay(totalActual);
    varianceDisp = formatHoursDisplay(totalVar);
    footBadge = varianceBadgeMeta(totalVarPct);
    footPctTxt = formatPercentDisplay(totalVarPct, 2, true);
  } else if(lastAnalysisTotal){
    const plannedRawTotal = apiVal(lastAnalysisTotal, "plannedHours", "PlannedHours", "planned_hours", "PlannedHrs");
    const actualRawTotal = apiVal(lastAnalysisTotal, "actualHours", "ActualHours", "actual_hours", "ActualHrs");
    const varianceRawTotal = apiVal(lastAnalysisTotal, "varianceHours", "VarianceHours", "variance_hours", "VarianceHrs");
    const variancePctRawTotal = apiVal(lastAnalysisTotal, "variancePercent", "VariancePercent");

    plannedDisp = formatHoursDisplay(plannedRawTotal);
    actualDisp = formatHoursDisplay(actualRawTotal);
    varianceDisp = formatHoursDisplay(varianceRawTotal);

    const variancePctNum =
      variancePctRawTotal != null && variancePctRawTotal !== "" && isFinite(Number(variancePctRawTotal))
        ? Number(variancePctRawTotal)
        : null;

    footBadge = varianceBadgeMeta(variancePctNum != null ? variancePctNum : 0);
    // Keep the Var % value from API (no recompute).
    footPctTxt = formatPercentDisplay(variancePctNum != null ? variancePctNum : 0, 2, true);
  } else {
    // Fallback (should rarely happen): keep old behavior.
    const totalPlanned = pagedRows.reduce((s,r)=>s+r.planned,0);
    const totalActual = pagedRows.reduce((s,r)=>s+r.actual,0);
    const totalVar = totalActual - totalPlanned;
    const totalVarPct = totalPlanned ? totalVar / totalPlanned * 100 : 0;
    plannedDisp = formatHoursDisplay(totalPlanned);
    actualDisp = formatHoursDisplay(totalActual);
    varianceDisp = formatHoursDisplay(totalVar);
    footBadge = varianceBadgeMeta(totalVarPct);
    footPctTxt = formatPercentDisplay(totalVarPct, 2, true);
  }
  foot.innerHTML = `<td colspan="${cfg.labels.length}">Total</td>
    <td class="num">${plannedDisp}</td>
    <td class="num">${actualDisp}</td>
    <td class="num">${varianceDisp}</td>
    <td class="num var-pct"><span class="var-pct-wrap">${footPctTxt} <span class="badge-var ${footBadge.cls}">${footBadge.label}</span></span></td>`;
  // Pagination UI (as per MyAlerts.aspx)
  const paginationWrap = document.getElementById("analysisPagination");
  const prevBtn = document.getElementById("analysisPrevBtn");
  const nextBtn = document.getElementById("analysisNextBtn");
  const totalEl = document.getElementById("analysisTotalRecords");
  if(totalEl){
    const totalRecordsForLabel = clientFiltered
      ? filteredCount
      : (analysisTotalRecords != null && isFinite(Number(analysisTotalRecords)) ? Number(analysisTotalRecords) : filteredCount);
    totalEl.textContent = "Total Records: " + formatNumberComma(totalRecordsForLabel, 0);
  }
  if(paginationWrap){
    // Always show pagination container (MyAlerts-style); enable/disable buttons based on total pages.
    paginationWrap.style.display = "";
  }
  const pageNavTotal = clientFiltered ? filteredCount : analysisTotalRecords;
  if(prevBtn){
    prevBtn.disabled = !pageNavTotal || analysisCurrentPage <= 1 || analysisTotalPages <= 1;
  }
  if(nextBtn){
    nextBtn.disabled = !pageNavTotal || analysisCurrentPage >= analysisTotalPages || analysisTotalPages <= 1;
  }
}

let analysisRequestSeq = 0;
function renderTable(){
  const cfg = ANALYSIS_LEVEL_CONFIG[currentLevel];
  const requestId = ++analysisRequestSeq;
  analysisCurrentPage = 1;
  updateAnalysisProjectDropdown();
  updateAnalysisResourceDropdown();
  renderTableHead(cfg);
  document.getElementById("tableBody").innerHTML =
    `<tr><td colspan="${cfg.labels.length+4}"><div class="empty-state">Loading...</div></td></tr>`;

  // Added By Request - two-step:
  // 1) pageNumber=0/pageSize=0 to get total records (and/or totals)
  // 2) pageNumber=1/pageSize=10 to get the first page rows
  // Modified By Madhuri.K On 21-08-2026 - On Resource tab, build full Resource dropdown list
  // from the totals fetch (does not change page rows / pagination).
  fetchAnalysisTable(ANALYSIS_LEVEL_FLAG[currentLevel], 0, 0).then((allRows) => {
    if(requestId !== analysisRequestSeq) return;
    if(currentLevel === "resource"){
      var rows0 = allRows || [];
      var totalNeeded = (analysisTotalRecords != null && isFinite(Number(analysisTotalRecords)))
        ? Number(analysisTotalRecords) : 0;
      // If 0/0 did not return every resource row, fetch once by total count for names only
      if(totalNeeded > 0 && rows0.length < totalNeeded){
        return fetchAnalysisTable(ANALYSIS_LEVEL_FLAG.resource, 1, totalNeeded).then(function(fullRows){
          if(requestId !== analysisRequestSeq) return;
          setAllAnalysisResourceOptionsFromRows((fullRows && fullRows.length) ? fullRows : rows0);
          return fetchAnalysisTable(ANALYSIS_LEVEL_FLAG[currentLevel], 1, analysisPageSize);
        });
      }
      setAllAnalysisResourceOptionsFromRows(rows0);
    } else {
      allAnalysisResourceOptions = [];
      allAnalysisResourceRows = [];
    }
    return fetchAnalysisTable(ANALYSIS_LEVEL_FLAG[currentLevel], 1, analysisPageSize);
  }).then(rows => {
    if(requestId !== analysisRequestSeq) return;
    lastAnalysisRows = rows;
    updateAnalysisResourceDropdown(); // Resource options from allAnalysisResourceOptions
    renderTableBody();
  }).catch(err => {
    if(requestId !== analysisRequestSeq) return;
    console.error("GetAnalysisTable error:", err);
    document.getElementById("tableBody").innerHTML =
      `<tr><td colspan="${cfg.labels.length+4}"><div class="empty-state">Unable to load analysis table.</div></td></tr>`;
  });
}

// Added By Madhuri.K on 19-08-2026 - Pagination navigation (Prev/Next) for Analysis Table
function goToPreviousAnalysisPage(){
  if(analysisCurrentPage > 1){
    analysisCurrentPage--;
    // Resource dropdown filter uses client-side pages over the full cache
    if(currentLevel === "resource" && analysisResourceFilter.size > 0){
      renderTableBody();
    } else {
      loadAnalysisPage();
    }
  }
}
function goToNextAnalysisPage(){
  if(analysisCurrentPage < analysisTotalPages){
    analysisCurrentPage++;
    if(currentLevel === "resource" && analysisResourceFilter.size > 0){
      renderTableBody();
    } else {
      loadAnalysisPage();
    }
  }
}

function loadAnalysisPage(){
  const cfg = ANALYSIS_LEVEL_CONFIG[currentLevel];
  const requestId = ++analysisRequestSeq;
  document.getElementById("tableBody").innerHTML =
    `<tr><td colspan="${cfg.labels.length+4}"><div class="empty-state">Loading...</div></td></tr>`;
  fetchAnalysisTable(ANALYSIS_LEVEL_FLAG[currentLevel], analysisCurrentPage, analysisPageSize).then(rows => {
    if(requestId !== analysisRequestSeq) return;
    lastAnalysisRows = rows;
    // Keep full Resource dropdown list; only refresh UI state (do not rebuild from page rows)
    updateAnalysisResourceDropdown();
    renderTableBody();
  }).catch(err => {
    if(requestId !== analysisRequestSeq) return;
    console.error("GetAnalysisTable error:", err);
    document.getElementById("tableBody").innerHTML =
      `<tr><td colspan="${cfg.labels.length+4}"><div class="empty-state">Unable to load analysis table.</div></td></tr>`;
  });
}

document.getElementById("levelTabs") && document.getElementById("levelTabs").addEventListener("click", (e)=>{
  const btn = e.target.closest("button");
  if(!btn) return;
  document.querySelectorAll("#levelTabs button").forEach(b=>b.classList.remove("active"));
  btn.classList.add("active");
  currentLevel = btn.dataset.level;
  if(currentLevel === "project"){
    syncAnalysisProjectFromTopFilter();
  } else {
    analysisProjectFilter.clear();
    analysisProjectSearchTerm = "";
    openAnalysisProjectPanel = false;
  }
  if(currentLevel !== "resource"){
    analysisResourceFilter.clear();
    analysisResourceSearchTerm = "";
    openAnalysisResourcePanel = false;
    allAnalysisResourceOptions = [];
    allAnalysisResourceRows = [];
  }
  sortState = {col:null, dir:"asc"};
  renderTable();
});

/* =========================================================================
   8. MASTER RENDER
   ========================================================================= */
function renderAll(){
  // Added By Madhuri.K On 07-08-2026 - Top Project is master; push selection into Analysis / Trend dropdowns
  syncAnalysisProjectFromTopFilter();
  syncTrendProjectFromTopFilter();
  renderFilterBar();
  renderKPIs();
  renderCharts();
  renderPvaTrendSection();
  // Modify By Madhuri.K on 27-07-2026 - Quarterly section removed
  renderTable();
}

// Added By Madhuri.K on 29-07-2026 - Load top filter master data (Business Group/Organization Unit/Project) before first render
// Modified By Vishal.M on 12-08-2026 - Load saved default view (GetDefaultFilter) after masters, then apply
function bootstrap(){
  fetchFilterMasters().then(function(){
    RAW_DATA = generateData();
    return fetchDefaultFilters().then(function(saved){
      var applied = applyDefaultFilterFromPayload(saved);
      if(!applied) applyDefaultYearMonth();
      renderAll();
      hideAnalyticsPreloader();
    });
  }).catch(function(){
    hideAnalyticsPreloader();
  });
}
function hideAnalyticsPreloader(){
  var pre = document.getElementById("AnalyticsPreloader");
  var wrap = document.getElementById("AnalyticsWrapper");
  if(pre) pre.style.display = "none";
  if(wrap) wrap.style.display = "";
}
setTimeout(hideAnalyticsPreloader, 8000);
    bootstrap();


    function encryptString(value) {
        var intStrArr;
        intStrArr = [];
        var strEncryptedString = "";
        var intEncryptNum = 1;
        var i;
        if (String(value).length > 0) {
            for (i = 0; i <= value.length - 1; i++) {
                intStrArr[i] = String(String(String(value[i])).charCodeAt(0) + intEncryptNum);
                intEncryptNum = intEncryptNum + 2;
            }
            strEncryptedString = intStrArr.join("-");
            if (String(strEncryptedString).substring(0, 1) == "-") {
                strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1)
            }
        }
        return strEncryptedString;
    }
    function isJson(str) {
        try {
            JSON.parse(str);
        } catch (e) {
            return false;
        }
        return true;
    }

</script>
    </form>
</body>
</html>