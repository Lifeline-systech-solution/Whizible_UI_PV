<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Skills_Inventory_Report.aspx.vb" Inherits="Whizible.Skills_Inventory_Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta charset="UTF-8" />
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Skills Inventory Report</title>
  <!-- Same font stack as Plan_VS_Actual_Dashboard_Base (Roboto 11.5px via whiz20_theme) -->
  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
  <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
  <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/v4-shims.min.css">
  <link rel="stylesheet" href="css/styles.css">
  <link rel="stylesheet" href="css/cxo-pva.css">
  <style>
    /* Page tokens; typography locked to PVA Base / cxo-pva (Roboto 11.5px) */
    body.analytics-pva {
      --surface-muted: #F8FAFC;
      --text-secondary: var(--muted);
      --text-muted: var(--faint);
      --accent-hover: #1359a6;
      --accent-light: var(--accent-soft);
      --skill-chip: var(--good);
      --skill-chip-bg: var(--good-soft);
      --ou-chip: var(--accent);
      --ou-chip-bg: var(--accent-soft);
      --green: var(--good);
      --green-bg: var(--good-soft);
      --orange: var(--warn);
      --orange-bg: var(--warn-soft);
      --shadow-sm: 0 1px 2px rgba(20, 30, 50, 0.05);
      --shadow-md: 0 4px 16px rgba(20, 30, 50, 0.08);
      --radius-sm: 4px;
      --sidebar-width: 260px;
      --font-display: 'Roboto', sans-serif;
      --font-body: 'Roboto', sans-serif;
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

    .page-wrap {
      max-width: 100%;
      margin: 0;
      padding: 0.5rem 1rem 1rem;
    }

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

    .btn-export:hover {
      background: #1359a6;
      color: #fff;
      border-color: #1359a6;
    }

    .btn-export i { color: inherit; font-size: 12px; }

    /* ── Active filter chips ── */
    .active-filters {
      display: none;
      flex-wrap: wrap;
      align-items: center;
      gap: 6px;
      margin-bottom: 8px;
      padding: 6px 10px;
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 6px;
      box-shadow: var(--shadow-sm);
    }

    .active-filters.visible { display: flex; }

    .filter-chip {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      padding: 3px 8px 3px 10px;
      border-radius: 20px;
      font-size: 11.5px;
      font-weight: 500;
    }

    .filter-chip.ou {
      background: var(--ou-chip-bg);
      color: var(--ou-chip);
    }

    .filter-chip.skill {
      background: var(--skill-chip-bg);
      color: var(--skill-chip);
    }

    .filter-chip button {
      border: none;
      background: transparent;
      color: inherit;
      opacity: 0.7;
      cursor: pointer;
      padding: 0 2px;
      line-height: 1;
      font-size: 11px;
    }

    .filter-chip button:hover { opacity: 1; }

    .clear-all-link {
      margin-left: 2px;
      font-size: 11.5px;
      font-weight: 600;
      color: var(--accent);
      cursor: pointer;
      background: none;
      border: none;
      padding: 2px 6px;
    }

    .clear-all-link:hover { text-decoration: underline; }

    /* ── Layout ── */
    .inventory-layout {
      display: grid;
      grid-template-columns: var(--sidebar-width) 1fr;
      gap: 12px;
      align-items: start;
    }

    @media (max-width: 992px) {
      .inventory-layout { grid-template-columns: 1fr; }
    }

    /* ── Sidebar filters ── */
    .inventory-sidebar { display: flex; flex-direction: column; gap: 8px; }

    .filter-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 6px;
      box-shadow: none;
      overflow: hidden;
    }

    .filter-card-header {
      display: flex;
      align-items: flex-start;
      gap: 8px;
      padding: 0.55rem 0.75rem;
      cursor: pointer;
      user-select: none;
      transition: background 0.15s;
    }

    .filter-card-header:hover { background: var(--surface-muted); }

    .filter-card-icon {
      width: 26px;
      height: 26px;
      border-radius: 6px;
      background: var(--accent-light);
      color: var(--accent);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 11.5px;
      flex-shrink: 0;
    }

    .filter-card-icon.skill-icon {
      background: var(--skill-chip-bg);
      color: var(--skill-chip);
    }

    .filter-card-title-wrap { flex: 1; min-width: 0; }

    .filter-card-title {
      font-size: 13px;
      font-weight: 600;
      color: #1e40af;
    }

    .filter-card-desc {
      font-size: 11px;
      color: var(--text-muted);
      margin-top: 0;
    }

    .filter-count-pill {
      font-size: 11px;
      font-weight: 600;
      padding: 2px 7px;
      border-radius: 10px;
      background: var(--accent-soft);
      color: var(--accent);
      flex-shrink: 0;
    }

    .filter-chevron {
      color: var(--text-muted);
      font-size: 11.5px;
      margin-top: 2px;
      transition: transform 0.2s;
    }

    .filter-card.collapsed .filter-chevron { transform: rotate(-90deg); }
    .filter-card.collapsed .filter-card-body { display: none; }

    .filter-card-body { padding: 0 0.75rem 0.65rem; }

    .filter-search-wrap {
      position: relative;
      margin-bottom: 6px;
    }

    .filter-search-wrap i {
      position: absolute;
      left: 10px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--text-muted);
      font-size: 11.5px;
    }

    .filter-search {
      width: 100%;
      padding: 6px 10px 6px 30px;
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      font-size: 11.5px;
      font-family: inherit;
      background: var(--surface-muted);
      outline: none;
      transition: border-color 0.15s, box-shadow 0.15s;
    }

    .filter-search:focus {
      border-color: var(--accent);
      box-shadow: 0 0 0 2px rgba(30, 64, 175, 0.12);
      background: #fff;
    }

    .filter-actions {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      margin-bottom: 4px;
    }

    .filter-actions button {
      border: none;
      background: none;
      font-size: 11px;
      font-weight: 600;
      color: var(--accent);
      cursor: pointer;
      padding: 2px 0;
    }

    .filter-actions button:hover { text-decoration: underline; }

    .filter-list {
      display: flex;
      flex-direction: column;
      gap: 1px;
    }

    .filter-item {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 5px 8px;
      border-radius: var(--radius-sm);
      cursor: pointer;
      transition: background 0.12s;
    }

    .filter-item:hover { background: var(--surface-muted); }

    .filter-item.selected {
      background: var(--accent-soft);
    }

    .filter-item input[type="checkbox"] {
      width: 14px;
      height: 14px;
      accent-color: var(--accent);
      cursor: pointer;
      flex-shrink: 0;
    }

    .filter-item label {
      font-size: 11.5px;
      color: var(--text);
      cursor: pointer;
      flex: 1;
      line-height: 1.3;
    }

    .filter-item.hidden { display: none; }
    .filter-item.collapsed-hidden { display: none; }

    .filter-more-less {
      display: none;
      text-align: center;
      padding: 4px 0 0;
      margin-top: 2px;
      border-top: 1px dashed var(--border);
    }

    .filter-more-less.visible { display: block; }

    .filter-more-less button {
      border: none;
      background: none;
      font-size: 11.5px;
      font-weight: 600;
      color: var(--accent);
      cursor: pointer;
      padding: 4px 6px;
      font-family: inherit;
      display: inline-flex;
      align-items: center;
      gap: 4px;
    }

    .filter-more-less button:hover { text-decoration: underline; }

    .filter-more-less button i { font-size: 10px; }

    /* ── Main report panel ── */
    .report-panel {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 6px;
      box-shadow: none;
      min-height: 0;
      display: flex;
      flex-direction: column;
    }

    .report-panel-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
      padding: 0.55rem 0.75rem;
      border-bottom: 1px solid var(--border);
      flex-wrap: wrap;
      background: #F8FAFC;
    }

    .report-panel-title {
      font-size: 13px;
      font-weight: 600;
      color: #1e40af;
    }

    .report-panel-meta {
      font-size: 11.5px;
      color: var(--text-secondary);
      margin-top: 1px;
    }

    .btn-generate {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 4px 10px;
      background: var(--accent);
      color: #fff;
      border: none;
      border-radius: 4px;
      font-size: 11.5px;
      font-weight: 600;
      font-family: inherit;
      cursor: pointer;
      transition: background 0.15s, transform 0.1s, box-shadow 0.15s;
      box-shadow: none;
      flex-shrink: 0;
      height: 34px;
    }

    .btn-generate:hover {
      background: var(--accent-hover);
      box-shadow: none;
    }

    .btn-generate:active { transform: scale(0.98); }

    .btn-generate:disabled {
      opacity: 0.55;
      cursor: not-allowed;
      transform: none;
    }

    .report-body {
      flex: 1;
      padding: 0.75rem;
    }

    /* Empty state */
    .empty-state {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      padding: 28px 16px;
      min-height: 220px;
    }

    .empty-state-icon {
      width: 48px;
      height: 48px;
      border-radius: 10px;
      background: var(--accent-light);
      color: var(--accent);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      margin-bottom: 10px;
    }

    .empty-state h3 {
      font-size: 14px;
      font-weight: 600;
      margin: 0 0 4px 0;
      color: var(--text);
    }

    .empty-state p {
      font-size: 11.5px;
      color: var(--text-secondary);
      max-width: 340px;
      margin: 0;
    }

    /* List view */
    .report-list { display: none; }
    .report-list.visible { display: block; }

    .report-table-card {
      border: 1px solid var(--border);
      border-radius: 6px;
      overflow: hidden;
      background: var(--surface);
    }

    .report-table-scroll {
      max-height: 520px;
      overflow: auto;
      -webkit-overflow-scrolling: touch;
      width: 100%;
      position: relative;
    }

    .list-row-skill {
      display: grid;
      background: linear-gradient(90deg, var(--accent-soft) 0%, #fafbff 100%);
      border-bottom: 1px solid var(--border);
      padding: 8px 12px;
      grid-template-columns: 1fr;
      min-width: 720px;
    }

    .list-row:nth-child(even):not(.list-row-head):not(.list-row-subtotal):not(.list-row-skill):not(.list-row-na) {
      background: #fafbfc;
    }

    .list-row-skill .skill-row-inner {
      grid-column: 1 / -1;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 8px;
    }

    .skill-group-name {
      font-size: 13px;
      font-weight: 600;
      color: var(--accent);
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .skill-group-name i { font-size: 11.5px; opacity: 0.8; }

    /* Added By Vyankat B. on 03rd Sep 2026 - hierarchical indent for Organization Unit under Skill */
    .col-ou-child {
      padding-left: 28px;
    }
    .list-row-subtotal .col-ou.col-ou-child {
      padding-left: 28px;
    }
    /* Previous hierarchy markers (green dot + arrows) removed:
    .sir-hier-dot { ... }
    .sir-hier-chevron / .sir-hier-arrow { ... }
    */
    /* End of Added By Vyankat B. on 03rd Sep 2026 */

    .skill-group-badge {
      font-size: 11px;
      font-weight: 600;
      padding: 2px 8px;
      border-radius: 10px;
      background: var(--surface);
      color: var(--text-secondary);
      border: 1px solid var(--border);
      flex-shrink: 0;
    }

    .list-row {
      display: grid;
      grid-template-columns: minmax(140px, 1.4fr) repeat(5, minmax(70px, 1fr));
      gap: 6px;
      align-items: center;
      padding: 8px 12px;
      border-bottom: 1px solid var(--border);
      transition: background 0.12s;
      min-width: 720px;
    }

    .list-row:hover:not(.list-row-head):not(.list-row-subtotal):not(.list-row-skill) {
      background: var(--surface-muted);
    }

    .report-table-card .list-row:last-child { border-bottom: none; }

    .list-row-head {
      position: sticky;
      top: 0;
      z-index: 10;
      background: var(--surface-muted);
      padding: 8px 12px;
      border-bottom: 1px solid var(--border-strong);
      box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .list-row-head .col-label {
      font-size: 10px;
      font-weight: 700;
      letter-spacing: 0.04em;
      color: var(--text-muted);
      line-height: 1.35;
      text-align: center;
    }

    .list-row-head .col-label.col-ou {
      text-align: left;
    }

    /* Desktop: experience cells participate in parent grid */
    .exp-grid-mobile {
      display: contents;
    }

    .exp-mobile-item {
      display: none !important;
    }

    .col-ou {
      font-size: 11.5px;
      font-weight: 500;
      color: var(--text);
      display: flex;
      align-items: center;
      gap: 6px;
      min-width: 0;
    }

    .col-ou i {
      color: var(--text-muted);
      font-size: 11px;
      flex-shrink: 0;
    }

    .exp-cell {
      text-align: center;
      font-size: 11.5px;
      font-weight: 600;
      color: var(--text);
    }

    .exp-pill {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      min-width: 28px;
      padding: 2px 8px;
      border-radius: 10px;
      font-size: 11.5px;
      font-weight: 600;
    }

    .exp-pill.zero {
      color: var(--text-muted);
      font-weight: 500;
    }

    .exp-pill.na {
      color: var(--text-muted);
      font-weight: 600;
      font-style: italic;
      background: transparent;
    }

    .list-row-na .col-ou {
      color: var(--text-muted);
      font-style: italic;
      font-weight: 500;
    }

    .exp-pill.low {
      background: var(--green-bg);
      color: var(--green);
    }

    .exp-pill.mid {
      background: var(--orange-bg);
      color: var(--orange);
    }

    .list-row-subtotal {
      background: #f3f4f8;
      font-weight: 600;
    }

    .list-row-subtotal .col-ou {
      font-weight: 700;
      font-size: 11.5px;
      letter-spacing: 0.03em;
      color: var(--text-secondary);
    }

    .list-row-subtotal.list-row-skill-divider {
      border-bottom: 2px solid var(--border-strong);
    }

    /* Stack only on narrow phones — keep desktop table in Navigation iframe */
    @media (max-width: 640px) {
      .list-row,
      .list-row-skill {
        grid-template-columns: 1fr;
        gap: 6px;
        padding: 8px 12px;
        min-width: 0;
      }

      .list-row-head { display: none; }

      .list-row .col-ou {
        grid-column: 1 / -1;
        padding-bottom: 6px;
        border-bottom: 1px dashed var(--border);
        margin-bottom: 2px;
      }

      .exp-grid-mobile {
        display: grid !important;
        grid-template-columns: repeat(2, 1fr);
        gap: 6px;
      }

      .exp-mobile-item {
        display: flex !important;
        align-items: center;
        justify-content: space-between;
        padding: 6px 8px;
        background: var(--surface-muted);
        border-radius: var(--radius-sm);
        font-size: 11px;
      }

      .exp-mobile-item span:first-child {
        color: var(--text-muted);
        font-weight: 500;
        font-size: 10px;
      }

      .exp-grid-mobile .exp-cell { display: none; }
    }

    .report-summary-bar {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-bottom: 8px;
      padding: 8px 10px;
      background: var(--surface-muted);
      border-radius: var(--radius-sm);
      border: 1px solid var(--border);
    }

    .summary-stat {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 11.5px;
      color: var(--text-secondary);
    }

    .summary-stat strong {
      color: var(--text);
      font-weight: 700;
    }

    .summary-stat i { color: var(--accent); }

    .exp-pill.clickable { cursor: pointer; }
    .exp-pill.clickable:hover { outline: 2px solid #1359a6; outline-offset: 1px; }

    .sir-modal-overlay{
      display:none; position:fixed; inset:0; background:rgba(20,30,50,.45);
      z-index:3000; align-items:center; justify-content:center; padding:1rem;
    }
    .sir-modal-overlay.open{ display:flex; }
    .sir-modal{
      background:#fff; border-radius:8px; border:1px solid #e5e7eb; width:min(820px,96vw);
      max-height:88vh; display:flex; flex-direction:column; overflow:hidden;
      box-shadow:0 12px 40px rgba(20,30,50,.22);
    }
    .sir-modal-hd{
      display:flex; align-items:center; justify-content:space-between; gap:12px;
      padding:0.65rem 1rem; background:#F8FAFC; border-bottom:1px solid #e5e7eb;
    }
    .sir-modal-hd h3{ margin:0; font-size:14px; font-weight:600; color:#1e40af; }
    .sir-modal-hd .sub{ font-size:11.5px; color:#6b7280; margin-top:2px; }
    .sir-modal-body{ padding:0.75rem 1rem 1rem; overflow:auto; flex:1; }
    .sir-modal-close{
      border:1px solid #d1d5db; background:#fff; border-radius:4px; width:28px; height:28px;
      cursor:pointer; color:#6b7280;
    }
    .sir-detail-table{ width:100%; border-collapse:collapse; font-size:11.5px; }
    .sir-detail-table th{
      background:#f8f9fa; text-align:left; padding:8px 10px; border-bottom:1px solid #e5e7eb;
      font-size:11px; font-weight:600; color:#374151;
    }
    .sir-detail-table td{ padding:8px 10px; border-bottom:1px solid #f0f2f5; }
    .sir-detail-empty{ text-align:center; color:#6b7280; padding:28px 12px; font-size:11.5px; }
    .sir-footer-row{ margin:10px 0 0; align-items:center; }
    .sir-footer-row .spntotal{
      font-size:12px; font-weight:600; color:#374151; white-space:nowrap;
    }
    .sir-footer-row .pagination{ margin:0; }
    .sir-footer-row .page-link{
      cursor:pointer; color:#1359a6; border:1px solid #dee2e6;
      padding:0.25rem 0.55rem; font-size:12px;
    }
    .sir-footer-row .page-item.disabled .page-link{
      color:#9ca3af; pointer-events:none; background:#f9fafb;
    }
  </style>
</head>
<body class="analytics-pva">
<form id="form1" runat="server">
  <%If m_blnViewAccess = True Then%>
  <div class="bgwhite">
    <div class="page-header-section" style="background:white;">
      <div class="graybg" style="padding:0.4rem 1rem; margin-left:0;">
        <h2 style="color:#1e40af; font-weight:600; font-size:18px; margin:0 0 0.25rem 0; display:flex; align-items:center;">
          <i class="fas fa-box-open" style="color:#1e40af; font-size:1.5rem; margin-right:0.75rem;"></i>
          Skills Inventory Report
        </h2>
        <p style="color:#6b7280; margin:0;">Organization Unit &middot; Skills &middot; Resource inventory tracking</p>
      </div>
    </div>

    <div class="header-actions">
      <button type="button" class="btn-export" id="btnPdf" title="Export PDF">
        <i class="far fa-file-pdf"></i> PDF
      </button>
      <button type="button" class="btn-export" id="btnExcel" title="Export Excel">
        <i class="far fa-file-excel"></i> Excel
      </button>
    </div>

  <div class="page-wrap">
    <div class="active-filters" id="activeFilters" aria-live="polite"></div>

    <div class="inventory-layout">
      <aside class="inventory-sidebar" aria-label="Report filters">
        <div class="filter-card" id="ouFilterCard">
          <div class="filter-card-header" data-toggle="ouFilterCard">
            <div class="filter-card-icon"><i class="fas fa-sitemap"></i></div>
            <div class="filter-card-title-wrap">
              <div class="filter-card-title">Organization Unit</div>
              <!-- Previous: <div class="filter-card-desc">Filter by team or business unit</div> -->
            </div>
            <span class="filter-count-pill" id="ouCount">0/12</span>
            <i class="fas fa-chevron-down filter-chevron"></i>
          </div>
          <div class="filter-card-body">
            <div class="filter-search-wrap">
              <i class="fas fa-search"></i>
              <input type="text" class="filter-search" id="ouSearch" placeholder="Search..." autocomplete="off" />
            </div>
            <div class="filter-actions">
              <button type="button" id="ouSelectAll">All</button>
              <button type="button" id="ouClear">Clear</button>
            </div>
            <div class="filter-list" id="ouList"></div>
            <div class="filter-more-less" id="ouMoreLess">
              <button type="button" id="ouToggleMore" aria-expanded="false">More</button>
            </div>
          </div>
        </div>

        <div class="filter-card" id="skillFilterCard">
          <div class="filter-card-header" data-toggle="skillFilterCard">
            <div class="filter-card-icon skill-icon"><i class="fas fa-code"></i></div>
            <div class="filter-card-title-wrap">
              <div class="filter-card-title">Skills</div>
              <!-- Previous: <div class="filter-card-desc">Narrow by technical expertise</div> -->
            </div>
            <span class="filter-count-pill" id="skillCount">0/18</span>
            <i class="fas fa-chevron-down filter-chevron"></i>
          </div>
          <div class="filter-card-body">
            <div class="filter-search-wrap">
              <i class="fas fa-search"></i>
              <input type="text" class="filter-search" id="skillSearch" placeholder="Search..." autocomplete="off" />
            </div>
            <div class="filter-actions">
              <button type="button" id="skillSelectAll">All</button>
              <button type="button" id="skillClear">Clear</button>
            </div>
            <div class="filter-list" id="skillList"></div>
            <div class="filter-more-less" id="skillMoreLess">
              <button type="button" id="skillToggleMore" aria-expanded="false">More</button>
            </div>
          </div>
        </div>
      </aside>

      <main class="report-panel">
        <div class="report-panel-header">
          <div>
            <div class="report-panel-title">Skills Inventory Report</div>
            <div class="report-panel-meta" id="reportMeta"></div>
          </div>
          <button type="button" class="btn-generate" id="btnGenerate" disabled>
            <i class="fas fa-play"></i> Generate Report
          </button>
        </div>

        <div class="report-body">
          <div class="empty-state" id="emptyState">
            <div class="empty-state-icon"><i class="fas fa-clipboard-list"></i></div>
            <h3>No Report Generated Yet</h3>
            <p>Select organization units and skills from the filters, then click &ldquo;Generate Report&rdquo;.</p>
          </div>

          <div class="report-list" id="reportList" aria-label="Skills inventory list"></div>
        </div>
      </main>
    </div>
  </div>
  </div>

  <!-- Resource details modal popup removed
  <div class="sir-modal-overlay" id="resourceModal" aria-hidden="true">
    <div class="sir-modal" role="dialog" aria-modal="true" aria-labelledby="resourceModalTitle">
      <div class="sir-modal-hd">
        <div>
          <h3 id="resourceModalTitle">Resource details</h3>
          <div class="sub" id="resourceModalSub"></div>
        </div>
        <button type="button" class="sir-modal-close" id="resourceModalClose" title="Close" aria-label="Close"><i class="fas fa-times"></i></button>
      </div>
      <div class="sir-modal-body" id="resourceModalBody">
        <div class="sir-detail-empty">Loading...</div>
      </div>
    </div>
  </div>
  -->

  <script>
  /* Added By Madhuri.K on 07-08-2026 - Skills Inventory Report API bindings
     Filter:  POST /api/SkillsInventoryReport/GetFilterMasters
     Report:  POST /api/SkillsInventoryReport/GetSkillsInventory
     Drill:   POST /api/SkillsInventoryReport/GetResourceDetail
     Export:  POST /api/SkillsInventoryReport/ExportSkillsInventoryExcel|Pdf
  */
  (function () {
    var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
    if (strUrl && strUrl.endsWith('/')) strUrl = strUrl.slice(0, -1);
    var LOGIN_ID = 61;
    var COMPANY_NAME = '<%= Session("strCompanyName") %>';

    var EXP_LABELS = [
      '&lt; 1 Year',
      '1 - 2 Years',
      '3 - 5 Years',
      '5 - 7 Years',
      '&gt; 7 Years'
    ];
    /* Experience band upper bounds in months — updated from SkillsInventoryBandModel */
    var BAND_MONTHS = { band1UpperMonths: 12, band2UpperMonths: 36, band3UpperMonths: 60, band4UpperMonths: 84 };

    var ORG_UNITS = [];
    var SKILLS = [];
    var LAST_INVENTORY_ROWS = [];
    var LAST_INVENTORY = { rows: [], subtotals: [], total: null };
    var FILTER_PAGE_SIZE = 7;

    var state = { ou: {}, skills: {} };
    var listExpanded = { ou: false, skill: false };

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

    function apiNum(obj) {
      var v = apiVal.apply(null, arguments);
      var n = Number(v);
      return isNaN(n) ? 0 : n;
    }

    function firstArrayIn(dataObj) {
      if (!dataObj) return [];
      if (Array.isArray(dataObj)) return dataObj;
      var preferred = ['orgUnits', 'OrgUnits', 'tools', 'Tools', 'skills', 'Skills',
        'rows', 'Rows', 'data', 'Data', 'items', 'Items', 'result', 'Result',
        'resources', 'Resources', 'employees', 'Employees', 'list', 'List'];
      for (var i = 0; i < preferred.length; i++) {
        var a = apiVal(dataObj, preferred[i]);
        if (Array.isArray(a)) return a;
      }
      var keys = Object.keys(dataObj);
      for (var j = 0; j < keys.length; j++) {
        if (Array.isArray(dataObj[keys[j]])) return dataObj[keys[j]];
      }
      return [];
    }

    function unwrapPayload(json) {
      if (!json) return {};
      var d = json.data != null ? json.data : (json.Data != null ? json.Data : json);
      if (!d || typeof d !== 'object' || Array.isArray(d)) return d || {};
      // ResponseEntity wraps as { message, data: { SkillInventoryModel / SkillsInventory*Model } }
      var inner = d.data != null ? d.data : d.Data;
      if (inner && typeof inner === 'object' && !Array.isArray(inner) &&
          (inner.SkillInventoryModel != null || inner.skillInventoryModel != null ||
           inner.SkillsInventorySkillModel != null || inner.SkillsInventoryOrgUnitModel != null ||
           inner.SkillsInventoryBandModel != null)) {
        return inner;
      }
      return d;
    }

    function asArray(v) {
      return Array.isArray(v) ? v : [];
    }

    function esc(s) {
      return String(s == null ? '' : s)
        .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }

    function getSelectedIds(map) {
      return Object.keys(map).filter(function (k) { return map[k]; });
    }

    function idsParam(map) {
      return getSelectedIds(map).join(',');
    }

    /* Added By Vyankat B. on 02nd Sep 2026 - API/SP accepts only ToolIDs, OrgUnitIDs, PageNo, PageSize */
    function buildReportParams(overrides) {
      var params = {
        orgUnitIDs: idsParam(state.ou),
        toolIDs: idsParam(state.skills)
      };
      /* Previous: extra fields not used by usp_Whizible2_Sel_SkillsInventory_Report
      var params = {
        orgUnitIDs: idsParam(state.ou),
        toolIDs: idsParam(state.skills),
        band1UpperMonths: BAND_MONTHS.band1UpperMonths,
        band2UpperMonths: BAND_MONTHS.band2UpperMonths,
        band3UpperMonths: BAND_MONTHS.band3UpperMonths,
        band4UpperMonths: BAND_MONTHS.band4UpperMonths,
        includeInactiveEmployees: true,
        accrueExperienceToDate: true,
        orgUnitParameterGroupID: 0,
        minProficiency: 0,
        onlyCoreCompetency: false
      };
      */
      if (overrides) {
        Object.keys(overrides).forEach(function (k) { params[k] = overrides[k]; });
      }
      return params;
    }

    function buildExportParams(kind) {
      var ouIds = idsParam(state.ou) || '';
      var toolIds = idsParam(state.skills) || '';
      var params = {
        orgUnitIDs: ouIds,
        toolIDs: toolIds
      };
      if (kind === 'excel') {
        params.includeResourceDetail = true;
      }
      /* Previous: companyName sent from page; API now loads it from company SP
      var params = {
        orgUnitIDs: ouIds,
        toolIDs: toolIds,
        companyName: COMPANY_NAME || ''
      };
      */
      /* Previous PDF payload used buildReportParams() with unused band/filter fields
      if (kind === 'excel') {
        return {
          orgUnitIDs: ouIds || '',
          toolIDs: toolIds || '',
          pageNo: 0,
          pageSize: 0,
          companyName: COMPANY_NAME || '',
          includeResourceDetail: true
        };
      }
      return Object.assign(buildReportParams(), {
        companyName: COMPANY_NAME || '',
        includeResourceDetail: true
      });
      */
      return params;
    }
    /* End of Added By Vyankat B. on 02nd Sep 2026 */

    /* ---------- Filter masters ---------- */
    function applyBandMasters(bandArr) {
      var bands = asArray(bandArr).slice().sort(function (a, b) {
        return apiNum(a, 'bandNumber', 'BandNumber') - apiNum(b, 'bandNumber', 'BandNumber');
      });
      if (!bands.length) return;
      EXP_LABELS = bands.map(function (b) {
        var raw = String(apiVal(b, 'bandLabel', 'BandLabel') || '').trim();
        var formatted = raw
          .replace(/\bYEARS\b/gi, 'Years')
          .replace(/\bYEAR\b/gi, 'Year')
          .replace(/\bEXPERIENCE\b/gi, 'Experience');
        return esc(formatted);
      });
      var u1 = apiVal(bands[0], 'upperMonths', 'UpperMonths');
      var u2 = apiVal(bands[1], 'upperMonths', 'UpperMonths');
      var u3 = apiVal(bands[2], 'upperMonths', 'UpperMonths');
      var u4 = apiVal(bands[3], 'upperMonths', 'UpperMonths');
      if (u1 != null) BAND_MONTHS.band1UpperMonths = Number(u1) || BAND_MONTHS.band1UpperMonths;
      if (u2 != null) BAND_MONTHS.band2UpperMonths = Number(u2) || BAND_MONTHS.band2UpperMonths;
      if (u3 != null) BAND_MONTHS.band3UpperMonths = Number(u3) || BAND_MONTHS.band3UpperMonths;
      if (u4 != null) BAND_MONTHS.band4UpperMonths = Number(u4) || BAND_MONTHS.band4UpperMonths;
    }

    function fetchFilterMasters() {
      return apiPost('/api/SkillsInventoryReport/GetFilterMasters', {
        loginID: LOGIN_ID,
        orgUnitParameterGroupID: 0,
        includeInactiveEmployees: true,
        onlySkillsInUse: true
      })
      .then(function (res) {
        if (!res.ok) throw new Error('GetFilterMasters failed: ' + res.status);
        return res.json();
      })
      .then(function (json) {
        var data = unwrapPayload(json);
        // Exact keys from GetFilterMasters: SkillsInventoryOrgUnitModel / SkillModel / BandModel
        var ouArr = asArray(apiVal(data,
          'SkillsInventoryOrgUnitModel', 'skillsInventoryOrgUnitModel',
          'orgUnits', 'OrgUnits'));
        var toolArr = asArray(apiVal(data,
          'SkillsInventorySkillModel', 'skillsInventorySkillModel',
          'skills', 'Skills', 'tools', 'Tools'));
        var bandArr = asArray(apiVal(data,
          'SkillsInventoryBandModel', 'skillsInventoryBandModel',
          'bands', 'Bands'));

        ORG_UNITS = ouArr.map(function (r, i) {
          var id = apiVal(r, 'orgUnitID', 'OrgUnitID', 'id', 'ID');
          id = id != null ? String(id) : ('ou' + i);
          var name = apiVal(r, 'orgUnitName', 'OrgUnitName', 'name', 'Name') || id;
          return { id: id, label: String(name), name: String(name) };
        });

        SKILLS = toolArr.map(function (r, i) {
          var id = apiVal(r, 'toolID', 'ToolID', 'skillID', 'SkillID', 'id', 'ID');
          id = id != null ? String(id) : ('sk' + i);
          var name = apiVal(r, 'skillName', 'SkillName', 'toolName', 'ToolName', 'name', 'Name') || id;
          return { id: id, label: String(name), name: String(name) };
        });

        applyBandMasters(bandArr);
      });
    }

    function initState() {
      state.ou = {};
      state.skills = {};
      ORG_UNITS.forEach(function (o) { state.ou[o.id] = false; });
      SKILLS.forEach(function (s) { state.skills[s.id] = false; });
    }

    function renderFilterList(containerId, items, group) {
      var container = document.getElementById(containerId);
      if (!container) return;
      if (!items.length) {
        container.innerHTML = '<div class="sir-detail-empty">No items available</div>';
        return;
      }
      container.innerHTML = items.map(function (item) {
        return (
          '<div class="filter-item" data-id="' + esc(item.id) + '" data-group="' + group + '">' +
            '<input type="checkbox" id="' + group + '_' + esc(item.id) + '" />' +
            '<label for="' + group + '_' + esc(item.id) + '">' + esc(item.label) + '</label>' +
          '</div>'
        );
      }).join('');
      applyFilterListVisibility(containerId, group);
    }

    function getListExpandedKey(group) { return group === 'ou' ? 'ou' : 'skill'; }
    function getMoreLessWrapId(group) { return group === 'ou' ? 'ouMoreLess' : 'skillMoreLess'; }
    function getToggleBtnId(group) { return group === 'ou' ? 'ouToggleMore' : 'skillToggleMore'; }

    function applyFilterListVisibility(listId, group) {
      var list = document.getElementById(listId);
      var wrap = document.getElementById(getMoreLessWrapId(group));
      var btn = document.getElementById(getToggleBtnId(group));
      if (!list || !wrap || !btn) return;
      var expanded = listExpanded[getListExpandedKey(group)];
      var visible = Array.prototype.slice.call(list.querySelectorAll('.filter-item:not(.hidden)'));
      visible.forEach(function (el) { el.classList.remove('collapsed-hidden'); });
      if (visible.length <= FILTER_PAGE_SIZE) {
        wrap.classList.remove('visible');
        btn.setAttribute('aria-expanded', 'false');
        return;
      }
      wrap.classList.add('visible');
      if (!expanded) {
        visible.forEach(function (el, index) {
          if (index >= FILTER_PAGE_SIZE) el.classList.add('collapsed-hidden');
        });
        btn.innerHTML = 'More (' + (visible.length - FILTER_PAGE_SIZE) + ') <i class="fas fa-chevron-down"></i>';
        btn.setAttribute('aria-expanded', 'false');
      } else {
        btn.innerHTML = 'Less <i class="fas fa-chevron-up"></i>';
        btn.setAttribute('aria-expanded', 'true');
      }
    }

    function toggleFilterListExpand(group) {
      listExpanded[getListExpandedKey(group)] = !listExpanded[getListExpandedKey(group)];
      applyFilterListVisibility(group === 'ou' ? 'ouList' : 'skillList', group);
    }

    function updateCounts() {
      var ouSel = getSelectedIds(state.ou).length;
      var skSel = getSelectedIds(state.skills).length;
      document.getElementById('ouCount').textContent = ouSel + '/' + ORG_UNITS.length;
      document.getElementById('skillCount').textContent = skSel + '/' + SKILLS.length;
      document.getElementById('btnGenerate').disabled = ouSel === 0 && skSel === 0;
    }

    function syncFilterUI(group) {
      var items = document.querySelectorAll('.filter-item[data-group="' + group + '"]');
      var map = group === 'ou' ? state.ou : state.skills;
      items.forEach(function (el) {
        var id = el.getAttribute('data-id');
        var checked = !!map[id];
        var input = el.querySelector('input');
        if (input) input.checked = checked;
        el.classList.toggle('selected', checked);
      });
      updateCounts();
      renderActiveChips();
      updateReportMeta();
      applyFilterListVisibility(group === 'ou' ? 'ouList' : 'skillList', group);
    }

    function setFilter(group, id, value) {
      if (group === 'ou') state.ou[id] = value;
      else state.skills[id] = value;
      syncFilterUI(group);
    }

    function setAll(group, value) {
      var map = group === 'ou' ? state.ou : state.skills;
      Object.keys(map).forEach(function (k) { map[k] = value; });
      if (!value) listExpanded[getListExpandedKey(group)] = false;
      syncFilterUI(group);
    }

    function renderActiveChips() {
      var bar = document.getElementById('activeFilters');
      var chips = [];
      ORG_UNITS.forEach(function (o) {
        if (state.ou[o.id]) {
          chips.push('<span class="filter-chip ou">' + esc(o.label) +
            '<button type="button" data-remove="ou" data-id="' + esc(o.id) + '" aria-label="Remove"><i class="fas fa-times"></i></button></span>');
        }
      });
      SKILLS.forEach(function (s) {
        if (state.skills[s.id]) {
          chips.push('<span class="filter-chip skill">' + esc(s.label) +
            '<button type="button" data-remove="skill" data-id="' + esc(s.id) + '" aria-label="Remove"><i class="fas fa-times"></i></button></span>');
        }
      });
      if (chips.length) {
        chips.push('<button type="button" class="clear-all-link" id="clearAllFilters">Clear all</button>');
        bar.innerHTML = chips.join('');
        bar.classList.add('visible');
      } else {
        bar.innerHTML = '';
        bar.classList.remove('visible');
      }
    }

    function formatDate() {
      var d = new Date();
      var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return d.getDate() + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
    }

    function updateReportMeta(generated) {
      var meta = document.getElementById('reportMeta');
      if (!meta) return;
      meta.textContent = '';
    }

    function pillClass(val) {
      if (!val) return 'zero';
      if (val <= 2) return 'low';
      return 'mid';
    }

    function getOuLabel(id) {
      var found = ORG_UNITS.find(function (o) { return String(o.id) === String(id); });
      if (!found) return id;
      return found.name || found.label || id;
    }

    function getSkillLabel(id) {
      var found = SKILLS.find(function (s) { return String(s.id) === String(id); });
      if (!found) return id;
      return found.name || found.label || id;
    }

    function renderExpCell(val, toolId, ouId, bandIndex) {
      var n = Number(val) || 0;
      if (!n) return '<span class="exp-pill zero">0</span>';
      return '<span class="exp-pill ' + pillClass(n) + '">' + n + '</span>';
    }

    function renderMobileExp(values, toolId, ouId) {
      return EXP_LABELS.map(function (label, i) {
        return '<div class="exp-mobile-item"><span>' + label + '</span>' +
          renderExpCell(values[i], toolId, ouId, i) + '</div>';
      }).join('');
    }

    function bandCountsFromRow(r) {
      // Prefer SkillInventoryModel experience fields; fall back to older band*Count names
      var keys = Object.keys(r || {});
      var hasNewShape = keys.some(function (k) {
        return /yearsexperience|below1year|above7years|^\d-\dYearsExperience$/i.test(k);
      });

      if (hasNewShape) {
        return [
          experienceCount(r, 'below1YearExperience', 'Below1YearExperience'),
          experienceCount(r, '1-2YearsExperience', 'OneToTwoYearsExperience'),
          experienceCount(r, '3-5YearsExperience', 'ThreeToFiveYearsExperience'),
          experienceCount(r, '5-7YearsExperience', 'FiveToSevenYearsExperience'),
          experienceCount(r, 'Above7YearsExperience', 'above7YearsExperience')
        ];
      }

      return [
        apiNum(r, 'band1Count', 'Band1Count'),
        apiNum(r, 'band2Count', 'Band2Count'),
        apiNum(r, 'band3Count', 'Band3Count'),
        apiNum(r, 'band4Count', 'Band4Count'),
        apiNum(r, 'band5Count', 'Band5Count')
      ];
    }

    /* null / missing experience counts display as 0 */
    function experienceCount(r) {
      if (!r) return 0;
      for (var i = 1; i < arguments.length; i++) {
        var k = arguments[i];
        if (Object.prototype.hasOwnProperty.call(r, k)) {
          var n = Number(r[k]);
          return isNaN(n) ? 0 : n;
        }
        var found = Object.keys(r).find(function (ok) { return ok.toLowerCase() === String(k).toLowerCase(); });
        if (found != null) {
          var n2 = Number(r[found]);
          return isNaN(n2) ? 0 : n2;
        }
      }
      return 0;
    }

    function parseInventoryPayload(json) {
      var payload = unwrapPayload(json);
      var rowArr = asArray(apiVal(payload,
        'SkillInventoryModel', 'skillInventoryModel',
        'SkillsInventoryRowModel', 'skillsInventoryRowModel',
        'rows', 'Rows'));
      var subArr = asArray(apiVal(payload,
        'SkillsInventorySubtotalModel', 'skillsInventorySubtotalModel', 'subtotals', 'Subtotals'));
      var totArr = asArray(apiVal(payload,
        'SkillsInventoryTotalModel', 'skillsInventoryTotalModel', 'totals', 'Totals'));

      var rows = rowArr.map(function (r) {
        var toolName = String(apiVal(r, 'description', 'Description', 'skillName', 'SkillName', 'toolName', 'ToolName') || '');
        var toolIdRaw = apiVal(r, 'toolID', 'ToolID', 'skillID', 'SkillID');
        var orgUnitName = String(apiVal(r, 'location', 'Location', 'orgUnitName', 'OrgUnitName') || '');
        var orgUnitIdRaw = apiVal(r, 'orgUnitID', 'OrgUnitID', 'locationID', 'LocationID');
        var values = bandCountsFromRow(r);
        var total = apiNum(r, 'totalCount', 'TotalCount');
        if (!total) {
          total = values.reduce(function (sum, v) { return sum + (Number(v) || 0); }, 0);
        }

        return {
          toolId: String(toolIdRaw != null && toolIdRaw !== '' ? toolIdRaw : toolName),
          toolName: toolName,
          orgUnitId: String(orgUnitIdRaw != null && orgUnitIdRaw !== '' ? orgUnitIdRaw : orgUnitName),
          orgUnitName: orgUnitName,
          values: values,
          total: total
        };
      }).filter(function (r) {
        return r.toolName || r.orgUnitName;
      });

      var subtotals = subArr.map(function (r) {
        return {
          toolId: String(apiVal(r, 'toolID', 'ToolID') != null ? apiVal(r, 'toolID', 'ToolID') : ''),
          toolName: String(apiVal(r, 'skillName', 'SkillName', 'description', 'Description') || ''),
          orgUnitCount: apiNum(r, 'orgUnitCount', 'OrgUnitCount'),
          values: bandCountsFromRow(r),
          total: apiNum(r, 'totalCount', 'TotalCount')
        };
      });

      var total = totArr.length ? {
        skillCount: apiNum(totArr[0], 'skillCount', 'SkillCount'),
        orgUnitCount: apiNum(totArr[0], 'orgUnitCount', 'OrgUnitCount'),
        values: bandCountsFromRow(totArr[0]),
        total: apiNum(totArr[0], 'totalCount', 'TotalCount')
      } : null;

      return { rows: rows, subtotals: subtotals, total: total };
    }

    function buildInventoryGroups(parsed) {
      var groups = [];
      var byTool = new Map();

      function ensureGroup(toolId, toolName, orgUnitCount) {
        var key = String(toolId || toolName || '');
        if (!key) return null;
        if (!byTool.has(key)) {
          byTool.set(key, {
            toolId: String(toolId || ''),
            toolName: toolName || getSkillLabel(toolId) || key,
            orgUnitCount: orgUnitCount != null ? orgUnitCount : null,
            rows: [],
            subtotal: null
          });
          groups.push(byTool.get(key));
        }
        var g = byTool.get(key);
        if (toolName && (!g.toolName || g.toolName === g.toolId)) g.toolName = toolName;
        if (orgUnitCount != null) g.orgUnitCount = orgUnitCount;
        return g;
      }

      parsed.subtotals.forEach(function (s) {
        var g = ensureGroup(s.toolId, s.toolName, s.orgUnitCount);
        if (g) g.subtotal = s.values;
      });

      parsed.rows.forEach(function (r) {
        var g = ensureGroup(r.toolId, r.toolName, null);
        if (g) g.rows.push(r);
      });

      if (!groups.length && parsed.rows.length) {
        parsed.rows.forEach(function (r) {
          ensureGroup(r.toolId, r.toolName, null);
        });
      }

      groups.forEach(function (g) {
        if (!g.subtotal) {
          var sub = [0, 0, 0, 0, 0];
          g.rows.forEach(function (r) {
            r.values.forEach(function (v, i) { sub[i] += Number(v) || 0; });
          });
          g.subtotal = sub;
        }
        if (g.orgUnitCount == null) g.orgUnitCount = g.rows.length;
      });

      return groups;
    }

    function fetchSkillsInventory() {
      return apiPost('/api/SkillsInventoryReport/GetSkillsInventory', buildReportParams())
      .then(function (res) {
        if (!res.ok) throw new Error('GetSkillsInventory failed: ' + res.status);
        return res.json();
      });
    }

    function generateListView() {
      var btn = document.getElementById('btnGenerate');
      var listEl = document.getElementById('reportList');
      btn.disabled = true;
      btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
      document.getElementById('emptyState').style.display = 'none';
      listEl.classList.add('visible');
      listEl.innerHTML = '<div class="sir-detail-empty">Loading skills inventory...</div>';

      fetchSkillsInventory()
        .then(function (json) {
          LAST_INVENTORY = parseInventoryPayload(json);
          LAST_INVENTORY_ROWS = LAST_INVENTORY.rows;
          renderInventoryTable(LAST_INVENTORY);
        })
        .catch(function (err) {
          console.error(err);
          listEl.innerHTML = '<div class="sir-detail-empty">Unable to load skills inventory. Please try again.</div>';
        })
        .finally(function () {
          btn.disabled = getSelectedIds(state.ou).length === 0 && getSelectedIds(state.skills).length === 0;
          btn.innerHTML = '<i class="fas fa-play"></i> Generate Report';
        });
    }

    function renderNaCell() {
      return '<span class="exp-pill na">NA</span>';
    }

    function renderInventoryTable(parsed) {
      var listEl = document.getElementById('reportList');
      var groups = buildInventoryGroups(parsed || { rows: [], subtotals: [], total: null });
      if (!groups.length) {
        listEl.innerHTML = '<div class="sir-detail-empty">No data matches the selected filters.</div>';
        updateReportMeta(true);
        return;
      }

      var uniqueOuSet = {};
      groups.forEach(function (g) {
        g.rows.forEach(function (r) {
          var key = (r.orgUnitId != null && r.orgUnitId !== '') ? String(r.orgUnitId) : (r.orgUnitName || '');
          if (key) uniqueOuSet[key] = true;
        });
      });
      var ouCount = Object.keys(uniqueOuSet).length || getSelectedIds(state.ou).length;
      var skillCount = groups.length;

      var html = '';
      html += '<div class="report-summary-bar">';
      html += '<div class="summary-stat"><i class="fas fa-layer-group"></i> <strong>' + skillCount + '</strong> skills</div>';
      html += '<div class="summary-stat"><i class="fas fa-building"></i> <strong>' + ouCount + '</strong> organization unit' + (ouCount !== 1 ? 's' : '') + '</div>';
      html += '<div class="summary-stat"><i class="fas fa-calendar-alt"></i> Generated as on ' + formatDate() + '</div>';
      html += '</div>';

      html += '<div class="report-table-card"><div class="report-table-scroll">';
      html += '<div class="list-row list-row-head">';
      html += '<div class="col-label col-ou">Skill / Organization Unit</div>';
      /* Previous: html += '<div class="col-label col-ou">Organization Unit</div>'; */
      EXP_LABELS.forEach(function (lbl) {
        html += '<div class="col-label">' + lbl + '<br>Experience</div>';
      });
      html += '</div>';

      groups.forEach(function (g, skillIndex) {
        var subtotal = g.subtotal || [0, 0, 0, 0, 0];
        var isLast = skillIndex === groups.length - 1;
        var toolId = g.toolId;
        var toolName = g.toolName || getSkillLabel(toolId);
        var badgeCount = g.rows.length;

        html += '<div class="list-row list-row-skill" data-skill="' + esc(toolId) + '">';
        html += '<div class="skill-row-inner">';
        /* Added By Vyankat B. on 03rd Sep 2026 - Skill parent (no green/arrow markers) */
        html += '<span class="skill-group-name"><i class="fas fa-wrench"></i> ' + esc(toolName) + '</span>';
        /* Previous: green dot + chevron-left */
        html += '<span class="skill-group-badge">' + badgeCount + ' org unit' + (badgeCount !== 1 ? 's' : '') + '</span>';
        html += '</div></div>';

        if (!g.rows.length) {
          /* API returned no OU detail rows — keep skill header, show NA */
          html += '<div class="list-row list-row-na">';
          html += '<div class="col-ou col-ou-child"><i class="fas fa-building"></i> NA</div>';
          /* Previous: green dot + arrow-right */
          html += '<div class="exp-grid-mobile">';
          for (var bi = 0; bi < EXP_LABELS.length; bi++) {
            html += '<div class="exp-cell">' + renderNaCell() + '</div>';
          }
          html += EXP_LABELS.map(function (label) {
            return '<div class="exp-mobile-item"><span>' + label + '</span>' + renderNaCell() + '</div>';
          }).join('');
          html += '</div></div>';
        } else {
          g.rows.forEach(function (row) {
            var ouLabel = row.orgUnitName || getOuLabel(row.orgUnitId);
            html += '<div class="list-row">';
            /* Added By Vyankat B. on 03rd Sep 2026 - Organization Unit child (indent only) */
            html += '<div class="col-ou col-ou-child"><i class="fas fa-building"></i> ' + esc(ouLabel) + '</div>';
            /* Previous: green dot + arrow-right */
            html += '<div class="exp-grid-mobile">';
            row.values.forEach(function (v, bi) {
              html += '<div class="exp-cell">' + renderExpCell(v, toolId, row.orgUnitId, bi) + '</div>';
            });
            html += renderMobileExp(row.values, toolId, row.orgUnitId);
            html += '</div></div>';
          });
        }

        html += '<div class="list-row list-row-subtotal' + (isLast ? '' : ' list-row-skill-divider') + '">';
        html += '<div class="col-ou col-ou-child">Subtotal</div>';
        /* Previous: html += '<div class="col-ou">Subtotal</div>'; */
        html += '<div class="exp-grid-mobile">';
        if (!g.rows.length) {
          for (var si = 0; si < EXP_LABELS.length; si++) {
            html += '<div class="exp-cell">' + renderNaCell() + '</div>';
          }
          html += EXP_LABELS.map(function (label) {
            return '<div class="exp-mobile-item"><span>' + label + '</span>' + renderNaCell() + '</div>';
          }).join('');
        } else {
          subtotal.forEach(function (v, bi) {
            html += '<div class="exp-cell">' + renderExpCell(v, toolId, '', bi) + '</div>';
          });
          html += renderMobileExp(subtotal, toolId, '');
        }
        html += '</div></div>';
      });

      html += '</div></div>';
      listEl.innerHTML = html;
      document.getElementById('emptyState').style.display = 'none';
      listEl.classList.add('visible');
      updateReportMeta(true);
    }

    function resetReportView() {
      document.getElementById('emptyState').style.display = '';
      document.getElementById('reportList').classList.remove('visible');
      document.getElementById('reportList').innerHTML = '';
      LAST_INVENTORY_ROWS = [];
      LAST_INVENTORY = { rows: [], subtotals: [], total: null };
      updateReportMeta(false);
    }

    /* ---------- Resource drill-down ---------- */
    var resourceDetailPager = { page: 1, size: 5, rows: [], bandIndex: null };

    function resourcePagerHtml() {
      var total = resourceDetailPager.rows.length;
      var totalPages = total ? Math.ceil(total / resourceDetailPager.size) : 1;
      resourceDetailPager.page = Math.max(1, Math.min(resourceDetailPager.page, totalPages));
      var prevDisabled = resourceDetailPager.page <= 1 ? ' disabled' : '';
      var nextDisabled = (!total || resourceDetailPager.page >= totalPages) ? ' disabled' : '';
      return '<div class="row footer-row sir-footer-row">' +
        '<div class="col-sm-6"></div>' +
        '<div class="col-sm-6 d-flex justify-content-end align-items-center">' +
        '<span class="spntotal me-3">Total Records: ' + total + '</span>' +
        '<nav aria-label="Pagination"><ul class="pagination mb-0">' +
        '<li class="page-item' + prevDisabled + '"><a class="page-link sir-page-prev" href="javascript:;" title="Previous"><i class="fas fa-angle-double-left"></i></a></li>' +
        '<li class="page-item' + nextDisabled + '"><a class="page-link sir-page-next" href="javascript:;" title="Next"><i class="fas fa-angle-double-right"></i></a></li>' +
        '</ul></nav></div></div>';
    }

    function bindResourcePager() {
      var body = document.getElementById('resourceModalBody');
      var prev = body.querySelector('.sir-page-prev');
      var next = body.querySelector('.sir-page-next');
      if (prev) prev.addEventListener('click', function (e) {
        e.preventDefault();
        if (resourceDetailPager.page <= 1) return;
        resourceDetailPager.page -= 1;
        renderResourceDetailPage();
      });
      if (next) next.addEventListener('click', function (e) {
        e.preventDefault();
        var totalPages = Math.ceil(resourceDetailPager.rows.length / resourceDetailPager.size);
        if (!resourceDetailPager.rows.length || resourceDetailPager.page >= totalPages) return;
        resourceDetailPager.page += 1;
        renderResourceDetailPage();
      });
    }

    function openResourceModal(toolId, ouId, bandIndex) {
      var modal = document.getElementById('resourceModal');
      var body = document.getElementById('resourceModalBody');
      var title = document.getElementById('resourceModalTitle');
      var sub = document.getElementById('resourceModalSub');
      title.textContent = 'Resource details';
      sub.textContent = (getSkillLabel(toolId) || toolId) +
        (ouId ? ' · ' + (getOuLabel(ouId) || ouId) : '') +
        (bandIndex != null && EXP_LABELS[bandIndex] ? ' · ' + EXP_LABELS[bandIndex].replace(/&lt;/g, '<').replace(/&gt;/g, '>') : '');
      resourceDetailPager.page = 1;
      resourceDetailPager.rows = [];
      resourceDetailPager.bandIndex = bandIndex;
      body.innerHTML = '<div class="sir-detail-empty">Loading resources...</div>';
      modal.classList.add('open');
      modal.setAttribute('aria-hidden', 'false');

      var overrides = {};
      if (toolId) overrides.toolIDs = String(toolId);
      if (ouId) overrides.orgUnitIDs = String(ouId);

      apiPost('/api/SkillsInventoryReport/GetResourceDetail', buildReportParams(overrides))
      .then(function (res) {
        if (!res.ok) throw new Error('GetResourceDetail failed: ' + res.status);
        return res.json();
      })
      .then(function (json) {
        renderResourceDetail(unwrapPayload(json), bandIndex);
      })
      .catch(function (err) {
        console.error(err);
        resourceDetailPager.rows = [];
        body.innerHTML = '<div class="sir-detail-empty">Unable to load resource details.</div>' + resourcePagerHtml();
        bindResourcePager();
      });
    }

    function renderResourceDetail(payload, bandIndex) {
      resourceDetailPager.page = 1;
      resourceDetailPager.rows = firstArrayIn(payload);
      resourceDetailPager.bandIndex = bandIndex;
      renderResourceDetailPage();
    }

    function renderResourceDetailPage() {
      var body = document.getElementById('resourceModalBody');
      var rows = resourceDetailPager.rows;
      if (!rows.length) {
        body.innerHTML = '<div class="sir-detail-empty">No resources found for this selection.</div>' + resourcePagerHtml();
        bindResourcePager();
        return;
      }
      var start = (resourceDetailPager.page - 1) * resourceDetailPager.size;
      var html = '<table id="sirResourceDetailTable" class="sir-detail-table"><thead><tr>';
      html += '<th>Employee</th><th>Org Unit</th><th>Skill / Tool</th><th>Experience</th><th>Proficiency</th>';
      html += '</tr></thead><tbody>';
      rows.slice(start, start + resourceDetailPager.size).forEach(function (r) {
        var name = apiVal(r, 'employeeName', 'EmployeeName', 'resourceName', 'ResourceName', 'name', 'Name') || '—';
        var ou = apiVal(r, 'orgUnitName', 'OrgUnitName', 'organizationUnitName') || '—';
        var skill = apiVal(r, 'toolName', 'ToolName', 'skillName', 'SkillName') || '—';
        var exp = apiVal(r, 'experienceLabel', 'ExperienceLabel', 'experience', 'Experience', 'experienceMonths', 'ExperienceMonths', 'months', 'Months');
        var prof = apiVal(r, 'proficiency', 'Proficiency', 'proficiencyName', 'ProficiencyName', 'minProficiency') || '—';
        html += '<tr><td>' + esc(name) + '</td><td>' + esc(ou) + '</td><td>' + esc(skill) +
          '</td><td>' + esc(exp != null ? exp : '—') + '</td><td>' + esc(prof) + '</td></tr>';
      });
      html += '</tbody></table>';
      body.innerHTML = html + resourcePagerHtml();
      bindResourcePager();
    }

    function closeResourceModal() {
      var modal = document.getElementById('resourceModal');
      modal.classList.remove('open');
      modal.setAttribute('aria-hidden', 'true');
    }

    /* ---------- Export (same blob-download pattern as PM_ProjectProfitability.aspx) ---------- */
    function joinUrl(base, path) {
      return String(base || '').replace(/\/+$/, '') + '/' + String(path || '').replace(/^\/+/, '');
    }

    function getTodayYYYYMMDD() {
      var d = new Date();
      var yyyy = d.getFullYear();
      var mm = String(d.getMonth() + 1).padStart(2, '0');
      var dd = String(d.getDate()).padStart(2, '0');
      return yyyy + mm + dd;
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

      function generateDownloadFileName(ext) {
          var randomHex = Math.floor(Math.random() * 0x100000000)
              .toString(16)
              .padStart(8, '0');

          return randomHex + '.' + ext;
      }

      function fileNameFromDisposition(header, fallback) {
          if (!header) return fallback;

          var star = /filename\*\s*=\s*UTF-8''([^;]+)/i.exec(header);
          if (star && star[1]) {
              try {
                  return decodeURIComponent(star[1].replace(/"/g, '').trim());
              } catch (e) {
                  // Ignore decode error
              }
          }

          var m = /filename\s*=\s*("?)([^";]+)\1/i.exec(header);
          if (m && m[2]) return m[2].trim();

          return fallback;
      }

      function exportReport(kind) {
          var isPdf = kind === 'pdf';
          var ouIds = idsParam(state.ou);
          var toolIds = idsParam(state.skills);

          // Same rule as Generate / API: need at least one OU or Skill
          if (!ouIds && !toolIds) {
              alert('Select at least one Organization Unit or Skill before exporting.');
              return;
          }

          // Endpoints mirror ProjectProfitability GenerateProfitabilityPdf / Excel
          var apiPath = isPdf
              ? 'api/SkillsInventoryReport/ExportSkillsInventoryPdf'
              : 'api/SkillsInventoryReport/ExportSkillsInventoryExcel';

          // Added By Vyankat B. on 03rd Sep 2026
          // Generate file name at ASPX level
          var ext = isPdf ? 'pdf' : 'xlsx';
          var fileName = generateDownloadFileName(ext);
          // End of Added By Vyankat B. on 03rd Sep 2026

          var btn = document.getElementById(isPdf ? 'btnPdf' : 'btnExcel');
          var prev = btn.innerHTML;

          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> ' +
              (isPdf ? 'PDF' : 'Excel');

          var exportUrl = joinUrl(strUrl, apiPath);
          var exportPayload = buildExportParams(kind);

          fetch(exportUrl, {
              method: 'POST',
              headers: apiHeaders(exportPayload, true),
              body: JSON.stringify(exportPayload)
          })
              .then(function (res) {
                  return res.blob().then(function (blob) {
                      return {
                          ok: res.ok,
                          status: res.status,
                          blob: blob
                      };
                  });
              })
              .then(function (result) {
                  var blob = result.blob;
                  var ct = (blob && blob.type)
                      ? blob.type.toLowerCase()
                      : '';

                  // API may return JSON error with a blob body
                  if (!result.ok ||
                      ct.indexOf('application/json') > -1 ||
                      ct.indexOf('text/') > -1) {

                      return blob.text().then(function (text) {
                          var msg = 'There are no items to show.';

                          try {
                              var json = JSON.parse(text);

                              msg = (json &&
                                  (json.message ||
                                      (json.data && json.data.message))) || msg;

                          } catch (e) {
                              if (text && text.length < 300) {
                                  msg = text;
                              }
                          }

                          throw new Error(msg);
                      });
                  }

                  if (!blob || blob.size === 0) {
                      throw new Error('There are no items to show.');
                  }

                  // Download using ASPX-generated file name
                  downloadBlob(blob, fileName);
              })
              .catch(function (err) {
                  console.error(
                      (isPdf ? 'PDF' : 'Excel') + ' export failed:',
                      err
                  );

                  alert(
                      err && err.message
                          ? err.message
                          : 'Unable to export ' +
                          (isPdf ? 'PDF' : 'Excel') +
                          '.'
                  );
              })
              .finally(function () {
                  btn.disabled = false;
                  btn.innerHTML = prev;
              });
      }

    function filterSearch(listId, query, group) {
      var q = query.toLowerCase().trim();
      var key = getListExpandedKey(group);
      if (q) listExpanded[key] = true;
      document.querySelectorAll('#' + listId + ' .filter-item').forEach(function (el) {
        var labelEl = el.querySelector('label');
        var label = labelEl ? labelEl.textContent.toLowerCase() : '';
        el.classList.toggle('hidden', q && label.indexOf(q) === -1);
      });
      applyFilterListVisibility(listId, group);
    }

    function bindEvents() {
      document.querySelectorAll('.filter-card-header[data-toggle]').forEach(function (hdr) {
        hdr.addEventListener('click', function (e) {
          if (e.target.closest('input')) return;
          var card = document.getElementById(hdr.getAttribute('data-toggle'));
          if (card) card.classList.toggle('collapsed');
        });
      });

      document.getElementById('ouList').addEventListener('change', function (e) {
        if (e.target.type !== 'checkbox') return;
        var item = e.target.closest('.filter-item');
        setFilter('ou', item.getAttribute('data-id'), e.target.checked);
      });
      document.getElementById('skillList').addEventListener('change', function (e) {
        if (e.target.type !== 'checkbox') return;
        var item = e.target.closest('.filter-item');
        setFilter('skill', item.getAttribute('data-id'), e.target.checked);
      });
      document.getElementById('ouList').addEventListener('click', function (e) {
        var item = e.target.closest('.filter-item');
        if (!item || e.target.tagName === 'INPUT') return;
        var cb = item.querySelector('input');
        cb.checked = !cb.checked;
        setFilter('ou', item.getAttribute('data-id'), cb.checked);
      });
      document.getElementById('skillList').addEventListener('click', function (e) {
        var item = e.target.closest('.filter-item');
        if (!item || e.target.tagName === 'INPUT') return;
        var cb = item.querySelector('input');
        cb.checked = !cb.checked;
        setFilter('skill', item.getAttribute('data-id'), cb.checked);
      });

      document.getElementById('ouSelectAll').addEventListener('click', function () { setAll('ou', true); });
      document.getElementById('ouClear').addEventListener('click', function () { setAll('ou', false); resetReportView(); });
      document.getElementById('skillSelectAll').addEventListener('click', function () { setAll('skill', true); });
      document.getElementById('skillClear').addEventListener('click', function () { setAll('skill', false); resetReportView(); });

      document.getElementById('ouSearch').addEventListener('input', function () {
        if (!this.value.trim()) listExpanded.ou = false;
        filterSearch('ouList', this.value, 'ou');
      });
      document.getElementById('skillSearch').addEventListener('input', function () {
        if (!this.value.trim()) listExpanded.skill = false;
        filterSearch('skillList', this.value, 'skill');
      });

      document.getElementById('ouToggleMore').addEventListener('click', function () { toggleFilterListExpand('ou'); });
      document.getElementById('skillToggleMore').addEventListener('click', function () { toggleFilterListExpand('skill'); });

      document.getElementById('activeFilters').addEventListener('click', function (e) {
        var btn = e.target.closest('button');
        if (!btn) return;
        if (btn.id === 'clearAllFilters') {
          setAll('ou', false);
          setAll('skill', false);
          resetReportView();
          return;
        }
        var group = btn.getAttribute('data-remove') === 'ou' ? 'ou' : 'skill';
        setFilter(group, btn.getAttribute('data-id'), false);
        resetReportView();
      });

      document.getElementById('btnGenerate').addEventListener('click', generateListView);
      document.getElementById('btnPdf').addEventListener('click', function () { exportReport('pdf'); });
      document.getElementById('btnExcel').addEventListener('click', function () { exportReport('excel'); });

      /* Resource details modal popup removed
      document.getElementById('reportList').addEventListener('click', function (e) {
        var pill = e.target.closest('.exp-pill.clickable');
        if (!pill) return;
        openResourceModal(pill.getAttribute('data-tool'), pill.getAttribute('data-ou'), parseInt(pill.getAttribute('data-band'), 10));
      });

      document.getElementById('resourceModalClose').addEventListener('click', closeResourceModal);
      document.getElementById('resourceModal').addEventListener('click', function (e) {
        if (e.target === this) closeResourceModal();
      });
      document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeResourceModal();
      });
      */
    }

    function bootstrap() {
      document.getElementById('ouList').innerHTML = '<div class="sir-detail-empty">Loading filters...</div>';
      document.getElementById('skillList').innerHTML = '<div class="sir-detail-empty">Loading filters...</div>';
      fetchFilterMasters()
        .then(function () {
          initState();
          renderFilterList('ouList', ORG_UNITS, 'ou');
          renderFilterList('skillList', SKILLS, 'skill');
          syncFilterUI('ou');
          syncFilterUI('skill');
        })
        .catch(function (err) {
          console.error('GetFilterMasters error:', err);
          document.getElementById('ouList').innerHTML = '<div class="sir-detail-empty">Unable to load organization units.</div>';
          document.getElementById('skillList').innerHTML = '<div class="sir-detail-empty">Unable to load skills.</div>';
        });
      bindEvents();
    }

    bootstrap();
  })();
  </script>

  <%Else %>
  <div id="ViewAccess" class="tab-pane" style="height: 448px">
      <div style="text-align: center">
          <p style="margin-top: 136px; font-weight: 700;">You are not authorize to view this page .</p>
      </div>
  </div>
  <%End If%>

</form>
</body>
</html>
