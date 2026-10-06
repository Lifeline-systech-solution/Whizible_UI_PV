<%@ Page Language="VB" AutoEventWireup="false" CodeBehind="PM_BulkResourceReq.aspx.vb" Inherits="Whizible.PM_BulkResourceReq" EnableSessionState="ReadOnly" %>
<!DOCTYPE html>
<html>
  <%CommonFunctions.General.PlotPageHeadTag("Bulk Resource Request")%>
  <head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bulk Resource Request</title>

    <%-- Same CSS stack as PM_Resource_Selection --%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1" />
    <link href="../../../Whizible2.0-new/plugins/select2/select2.css?v=3" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css" />

    <style>
    button, input, optgroup, select, textarea{ font-size: 11.5px !important; }
      *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
      body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; font-size: 11.5px; color: #333; line-height: 1.5; background: #f4f6f9; }
      .bgwhite { font-size: 11.5px !important; }
      select, input, button, textarea { font-family: inherit; }

      /* ── Page header band — normal flow (not frozen) ── */
      .page-header-band { width: 100%; background-color: #e7edf0; padding: 12px 14px; display: flex; flex-direction: column; border-bottom: 1px solid #e9ecef; margin: 0; }
      .page-title { font-size: 18px; font-weight: 600; color: #1e40af; white-space: nowrap; margin: 0; display: flex; align-items: center; gap: 8px; }
      .action-buttons { display: flex; gap: 8px; flex-shrink: 0; align-items: center; }
      .topbtn { display: inline-flex; align-items: center; gap: 5px; padding: 6px 16px; border-radius: 5px; font-weight: 500; cursor: pointer; border: none; white-space: nowrap; font-family: inherit; }
      .topbtn-outline { background: #fff; border: 1.5px solid #486AC0; color: #486AC0; }
      .topbtn-outline:hover { background: #e7ecfa; }
      .topbtn-primary { background: #486AC0; color: #fff; border: 1.5px solid #486AC0; }
      .topbtn-primary:hover { background: #3b5aa5; }
      .page-header-band .action-buttons { display: none; }

      .page-wrapper { padding: 14px 24px 20px; overflow: visible; }

      .note-actions-row { display: flex; align-items: flex-start; gap: 10px; margin-bottom: 12px; padding: 8px 24px 8px; border-bottom: 1px solid #e9ecef; }
      .note-actions-row .note-bar { flex: 1; margin-bottom: 0; }
      .note-actions-row .action-buttons { display: flex; gap: 8px; align-items: flex-start; flex-shrink: 0; padding-top: 2px; }
      .note-bar { background: #fffbeb; border: 1px solid #fde68a; border-radius: 7px; padding: 8px 14px; margin-bottom: 12px; }
      .note-header { display: flex; align-items: center; justify-content: space-between; cursor: pointer; user-select: none; }
      .note-left { display: flex; align-items: center; gap: 8px; color: #92400e; }
      .note-left strong { font-weight: 600; }
      .note-chevron { color: #92400e; display: flex; align-items: center; transition: transform 0.2s; }
      .note-chevron.open { transform: rotate(180deg); }
      .note-expanded { display: none; margin-top: 8px; padding-top: 8px; border-top: 1px solid #fde68a; color: #92400e; }
      .note-expanded ul { padding-left: 18px; }
      .note-expanded ul li { margin-bottom: 3px; }
      /* Added by Nikhil Mane on 04-04-2026 — bullet list inside collapsible note bar */
      .note-bullets-always { list-style: none; padding-left: 4px; margin: 0; color: #92400e; font-size: 11.5px; }
      .note-bullets-always li { margin-bottom: 4px; line-height: 1.5; display: flex; align-items: flex-start; gap: 6px; }
      .note-bullets-always li:last-child { margin-bottom: 0; }
      .note-bullet { flex-shrink: 0; font-size: 14px; line-height: 1.4; color: #92400e; }

      .top-row { display: flex; gap: 12px; margin-bottom: 14px; align-items: flex-start; }

      .project-details-card { flex: 1; background: #f4f6f9; border: 1px solid #e0e4ea; border-radius: 8px; padding: 12px 16px; }
      .project-details-card h2 {font-size: 12px; font-weight: 700; color: #1e3a5f; text-transform: uppercase; letter-spacing: 0.04em; margin-bottom: 8px; display: flex; align-items: center; gap: 6px; padding-bottom: 6px; border-bottom: 1px solid #dbeafe; }
      .project-grid { display: grid; grid-template-columns: repeat(3, 1fr); row-gap: 6px; column-gap: 16px; }
      .project-field { display: flex; align-items: baseline; gap: 4px; }
      .project-field label { font-size: 11.5px; color: #6b7280; white-space: nowrap; }
      .project-field .value {  font-weight: 600; color: #1a56db; }

      .additional-columns-card { width: 320px; flex-shrink: 0; background: #fff; border: 1px solid #e5e7eb; border-radius: 10px; padding: 14px; position: relative; }
      .additional-columns-card h3 { font-size: 12px; font-weight: 600; color: #1a56db; margin-bottom: 0; }
      .additional-columns-card .section-header { display: flex; align-items: center; justify-content: space-between; cursor: pointer; user-select: none; padding-bottom: 0; border-bottom: none; }
      .additional-columns-card .section-header:hover { opacity: 0.85; }

      .tag-bar { display: flex; align-items: center; flex-wrap: wrap; gap: 4px; border: 1px solid #d1d5db; border-radius: 6px; padding: 5px 8px; min-height: 32px; cursor: default; }
      .col-tag { display: inline-flex; align-items: center; gap: 3px; background: #fff; border: 1px solid #d1d5db; border-radius: 4px; padding: 2px 6px; font-size: 11.5px; color: #374151; white-space: nowrap; }
      .col-tag .remove-tag { cursor: pointer; color: #9ca3af; font-size: 9px; display: flex; align-items: center; margin-left: 2px; }
      .col-tag .remove-tag:hover { color: #ef4444; }
      .tag-bar-chevron-btn { margin-left: auto; flex-shrink: 0; background: none; border: none; cursor: pointer; color: #6b7280; display: flex; align-items: center; padding: 2px 3px; border-radius: 3px; align-self: flex-start; }
      .tag-bar-chevron-btn:hover { background: #f3f4f6; }
      .tag-bar-chevron-btn svg { transition: transform 0.2s; }
      .tag-bar-chevron-btn.open svg { transform: rotate(180deg); }
      /* Non-project skill and delete confirmations reuse the same
         visual pattern as the submit confirmation modal. */
      .col-dropdown { display: none; position: fixed; background: #fff; border: 1px solid #e5e7eb; border-radius: 8px; box-shadow: 0 4px 16px rgba(0,0,0,0.15); z-index: 9999; overflow-x: hidden; overflow-y: auto; max-height: 260px; min-width: 260px; scrollbar-width: thin; scrollbar-color: #d1d5db #f9fafb; }
      .col-dropdown::-webkit-scrollbar { width: 5px; }
      .col-dropdown::-webkit-scrollbar-track { background: #f9fafb; border-radius: 0 8px 8px 0; }
      .col-dropdown::-webkit-scrollbar-thumb { background: #d1d5db; border-radius: 4px; }
      .col-dropdown.open { display: block; }
      .dd-section-label { font-size: 10px; font-weight: 600; color: #9ca3af; text-transform: uppercase; letter-spacing: 0.05em; padding: 6px 12px 4px; background: #f9fafb; border-bottom: 1px solid #f3f4f6; position: sticky; top: 0; z-index: 1; }
      .dd-divider { border: none; border-top: 1px solid #f3f4f6; margin: 0; }
      .col-dd-row { display: flex; align-items: center; padding: 6px 10px 6px 8px;  color: #374151; user-select: none; transition: background 0.1s; cursor: default; }
      .col-dd-row:hover { background: #f9fafb; }
      .col-dd-row.is-selected .dd-handle { visibility: visible; cursor: grab; }
      .col-dd-row.is-selected .dd-handle:active { cursor: grabbing; }
      .col-dd-row .dd-handle { visibility: hidden; color: #9ca3af;  padding: 0 6px 0 0; display: flex; align-items: center; letter-spacing: -1.5px; line-height: 1; flex-shrink: 0; }
      .col-dd-row.dragging { opacity: 0.35; }
      .col-dd-row.drag-over-above { border-top: 2px solid #1a56db; }
      .col-dd-row.drag-over-below { border-bottom: 2px solid #1a56db; }
      .col-dd-row input[type="checkbox"] { width: 13px; height: 13px; accent-color: #1a56db; cursor: pointer; flex-shrink: 0; margin-right: 7px; }
      .col-dd-row label { cursor: pointer; flex: 1; margin: 0; font-weight: 400;  }

      .resource-table-wrapper { background: #fff; border: 1px solid #e5e7eb; border-radius: 10px; overflow: hidden; }

      /* ── Scroll container: both axes, table header stays put ── */
      .table-scroll {
        overflow-x: auto;
        overflow-y: auto;
        max-height: 460px;
        scrollbar-width: thin;
        scrollbar-color: #d1d5db #f9fafb;
        /* Establish a stacking context so sticky children resolve z-index inside here only */
        position: relative;
      }
      .table-scroll::-webkit-scrollbar { height: 6px; width: 5px; }
      .table-scroll::-webkit-scrollbar-track { background: #f9fafb; }
      .table-scroll::-webkit-scrollbar-thumb { background: #d1d5db; border-radius: 3px; }

      /* ── Table base ── */
      /* border-collapse:separate is required for position:sticky on th/td to work in all browsers */
      .resource-table { border-collapse: separate; border-spacing: 0; min-width: 100%; white-space: nowrap; }

      /* ── Sticky header row ── */
      .resource-table thead tr { background: #f9fafb; }
      .resource-table thead th {
        padding: 9px 11px;
        text-align: left;
        font-weight: 600;
        color: #374151;
        white-space: nowrap;
        background: #f9fafb;
        /* Stick each TH individually (more reliable than sticking the whole thead) */
        position: sticky;
        top: 0;
        z-index: 11;
        /* Bottom border rendered via box-shadow so it scrolls with the sticky header */
        box-shadow: 0 2px 0 #e5e7eb;
      }

      /* ── Sticky Actions column (col 1) ── */
      /* Header corner: sticky top AND left — needs highest z-index */
      .resource-table thead th:first-child {
        left: 0;
        z-index: 21;  /* above all other sticky headers (z:11) and sticky body cells (z:3) */
      }
      /* Body cells in col 1: sticky left only */
      .resource-table tbody td:first-child {
        position: sticky;
        left: 0;
        z-index: 3;
        background: #fff;
        /* Separator shadow on the right edge */
        box-shadow: 2px 0 4px -1px rgba(0,0,0,0.08);
      }
      .resource-table tbody tr:hover td:first-child { background: #fafafa; }

      /* ── Body rows ── */
      .resource-table tbody tr { border-bottom: 1px solid #f3f4f6; }
      .resource-table tbody tr:hover { background: #fafafa; }
      .resource-table tbody td {
        padding: 7px 10px;
        vertical-align: middle;
        /* Explicit z-index:0 so non-sticky cells never climb above sticky cols/header */
        z-index: 0;
        position: relative;  /* needed for z-index to take effect */
      }

      /* ── Skill / Replacement expansion rows ──
         These span all columns. Their first <td> (spacer) is sticky-left.
         Their second <td> (content) must NOT be sticky and must clip overflow
         so the inner content never bleeds over the sticky Actions column. */
      .resource-table .skill-section-row td:first-child,
      .resource-table .replacement-row td:first-child {
        position: sticky;
        left: 0;
        z-index: 3;
        /* background set inline via JS */
      }
      .resource-table .skill-section-row td.skill-section-cell,
      .resource-table .replacement-row td.replacement-row-cell {
        position: relative !important;
        z-index: 1 !important;
        box-shadow: none !important;
        /* Clip any overflowing child content so it doesn't bleed over the sticky Actions col */
        overflow: hidden;
      }
      .th-inner { display: flex; align-items: center; gap: 4px; }
      .th-icon { color: #9ca3af; display: flex; align-items: center; flex-shrink: 0; }

      .icon-btn { background: none; border: 1px solid #e5e7eb; border-radius: 4px; padding: 3px 5px; cursor: pointer; color: #6b7280; display: inline-flex; align-items: center; justify-content: center; transition: background 0.12s, color 0.12s; line-height: 1; }
      .icon-btn:hover { background: #f3f4f6; border-color: #d1d5db; color: #374151; }
      .icon-btn.danger:hover { background: #fef2f2; border-color: #fca5a5; color: #ef4444; }

      .actions-cell { display: flex; flex-direction: column; align-items: center; gap: 4px; }
      .actions-cell .icon-row { display: flex; gap: 4px; }
      .set-skill-link {  color: #1a56db; cursor: pointer; background: none; border: none; font-weight: 500; padding: 1px 0; white-space: nowrap; }
      .set-skill-link:hover { text-decoration: underline; }

      .skill-section-row { display: none; }
      .skill-section-row.open { display: table-row; }
      .skill-section-cell { padding: 0 !important; border-bottom: 2px solid #dbeafe !important; }
      .skill-section-inner { background: #f8faff; padding: 12px 16px; border-top: 1px solid #dbeafe; }
      .skill-section-header { display: flex; align-items: center; gap: 7px;  font-weight: 600; color: #374151; margin-bottom: 10px; }
      .skill-section-close { background: none; border: none; cursor: pointer; color: #9ca3af; font-size: 14px; line-height: 1; padding: 0 3px; }
      .skill-section-close:hover { color: #374151; }
      .skill-dot { width: 7px; height: 7px; background: #3b82f6; border-radius: 50%; display: inline-block; flex-shrink: 0; }
      .skills-table { width: 100%; border-collapse: collapse; margin-bottom: 8px; }
      .skills-table thead tr { background: #f9fafb; }
      .skills-table thead th {  font-weight: 600; color: #374151; padding: 7px 10px; text-align: left; border: 1px solid #dee2e6; white-space: nowrap; }
      .skills-table tbody td { padding: 6px 8px; vertical-align: middle; border: 1px solid #dee2e6; }
      .skills-table td.exprience { display: flex; border: none !important; align-items: center; justify-content: center; padding: 6px 4px; gap: 6px; width: 100%; }
      .skills-table td.exprience .form-control { margin: 0; width: 100% !important; min-width: 120px; max-width: 180px; height: 30px; }
      .skills-table td.exprience .select2-container { width: 100% !important; min-width: 120px; max-width: 180px; }
      .skills-table td.exprience .exp-sep { color: #6b7280; }
      .skills-table td.exprience .exp-unit { color: #6b7280; font-size: 11px; white-space: nowrap; min-width: 44px; text-align: left; }
      .skills-table .form-control {  height: 30px; padding: 4px 8px; }
      .skills-table select.form-control { padding-right: 22px; min-width: 140px; }
      .skills-table .chk-core { width: 16px; height: 16px; accent-color: #1a56db; cursor: pointer; display: block; margin: auto; }
      .skills-table td.core-val-error { background: #fff5f5; box-shadow: inset 0 0 0 1px #ef4444; border-radius: 3px; }
      .skills-table .ibtnDel { background: none; border: none; cursor: pointer; color: #9ca3af; padding: 2px 4px; border-radius: 3px; }
      .skills-table .ibtnDel:hover { color: #ef4444; }
      .btn-add-skill { display: inline-flex; align-items: center; gap: 4px;  color: #374151; background: #fff; border: 1px solid #d1d5db; border-radius: 4px; cursor: pointer; padding: 5px 12px; font-weight: 500; }
      .btn-add-skill:hover { background: #eff6ff; border-color: #1a56db; color: #1a56db; }

      .datefielddiv { display: flex !important; align-items: stretch !important; flex-wrap: nowrap !important; min-width: 150px; }
      .datefielddiv .form-control { border-radius: 4px 0 0 4px !important; font-size: 12px !important; height: 30px !important; min-height: 30px !important; max-height: 30px !important; padding: 0 8px !important; flex: 1 1 auto; min-width: 0; box-sizing: border-box !important; line-height: 28px !important; border-right: none !important; }
      .datefielddiv .datefield-btn-wrap { display: flex !important; flex-shrink: 0; align-items: stretch !important; }
      .datefielddiv .btncalendar { border-radius: 0 4px 4px 0 !important; height: 30px !important; min-height: 30px !important; max-height: 30px !important; width: 32px !important; padding: 0 !important; font-size: 13px !important; background: #f3f4f6 !important; border: 1px solid #d1d5db !important; border-left: none !important; color: #6b7280 !important; cursor: pointer !important; display: flex !important; align-items: center !important; justify-content: center !important; flex-shrink: 0; box-sizing: border-box !important; line-height: 1 !important; }
      .datefielddiv .btncalendar:hover { background: #e5e7eb !important; color: #374151 !important; }

      .resource-table .form-control {  height: 30px; padding: 4px 8px; min-width: 100px; }
      .resource-table select.form-control { padding-right: 22px; }
      .resource-table select.form-control {
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8' viewBox='0 0 24 24' fill='none' stroke='%239ca3af' stroke-width='3'%3E%3Cpolyline points='6 9 12 15 18 9'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 6px center;
      }
      .resource-table input[type="number"].form-control { min-width: 64px; }

      .allocation-wrapper { display: flex; align-items: center; border: 1px solid #d1d5db; border-radius: 4px; overflow: hidden; width: 84px; }
      .allocation-wrapper input { border: none; padding: 4px 6px; width: 48px;  outline: none; height: 30px; }
      .allocation-wrapper .pct-label { padding: 4px 7px; background: #f9fafb; border-left: 1px solid #e5e7eb;  color: #6b7280; }

      .add-more-row { padding: 10px 14px; border-top: 1px solid #f3f4f6; }
      .btn-add-more { display: inline-flex; align-items: center; gap: 5px; padding: 6px 14px; background: #fff; border: 1.5px solid #d1d5db; border-radius: 5px;  color: #374151; cursor: pointer; font-weight: 500; font-family: inherit; }
      .btn-add-more:hover { background: #eff6ff; border-color: #1a56db; color: #1a56db; }
      .btn-add-more .plus { font-size: 14px; font-weight: 700; color: #1a56db; line-height: 1; }

      .dyn-th { display: none; }
      .dyn-td { display: none; }

      .ui-datepicker { z-index: 9999 !important; }

      .replacement-row { display: none; }
      .replacement-row.open { display: table-row; }
      .replacement-row-cell { padding: 0 !important; border-bottom: 1px solid #fde68a !important; }
      .replacement-row-inner { background: #fffbeb; border-top: 1px solid #fde68a; padding: 8px 16px; display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
      .replacement-row-inner .rep-label {  font-weight: 600; color: #92400e; white-space: nowrap; min-width: 160px; }
      .replacement-row-inner .rep-select-wrap { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
      .replacement-row-inner select.form-control { height: 30px;  padding: 4px 24px 4px 8px; min-width: 220px; max-width: 300px; border: 1px solid #d1d5db; border-radius: 4px; appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8' viewBox='0 0 24 24' fill='none' stroke='%239ca3af' stroke-width='3'%3E%3Cpolyline points='6 9 12 15 18 9'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 8px center; background-color: #fff; }
      .replacement-row-inner select.form-control:focus { outline: none; border-color: #f59e0b; box-shadow: 0 0 0 2px rgba(245,158,11,.15); }
      .rep-note { font-size: 10px; color: #b45309; font-style: italic; white-space: nowrap; }

      .val-error { border: 1.5px solid #ef4444 !important; background-color: #fff5f5 !important; border-radius: 4px; }
      .val-error:focus { box-shadow: 0 0 0 2px rgba(239,68,68,.2) !important; }

      /* JD attachment — hidden file input is fully off-screen (no layout impact).
         Triggered via JS: jdBtn.onclick -> fileInput.click(), so the page never reflows. */
      .jd-file-input-hidden {
        position: fixed !important; top: -9999px !important; left: -9999px !important;
        width: 1px !important; height: 1px !important; opacity: 0 !important;
        overflow: hidden !important; pointer-events: none !important; clip: rect(0,0,0,0) !important;
      }
      /* JD button — styled to match the JD Attachments button in the Resource Request modal */
      .jd-upload-btn {
        display: inline-flex; align-items: center; gap: 6px; padding: 5px 14px;
         font-family: inherit; background: #fff;
        border: 1.5px solid #486AC0; border-radius: 5px; color: #486AC0;
        cursor: pointer; white-space: nowrap; line-height: 1.4; font-weight: 500;
        transition: background 0.12s, color 0.12s;
      }
      .jd-upload-btn:hover { background: #e7ecfa; }
      .jd-upload-btn.val-error { border-color: #ef4444 !important; background: #fff5f5 !important; color: #b91c1c !important; }
      .jd-upload-btn svg, .jd-upload-btn i { flex-shrink: 0; }
      /* Filename shown beneath the button after a file is chosen */
      .jd-file-name {
        display: block; font-size: 11px; color: #374151; max-width: 140px;
        overflow: hidden; text-overflow: ellipsis; white-space: nowrap; margin-top: 3px;
      }
      .jd-file-name a { color: #1a56db; text-decoration: underline; }

      /* alertify notifier z-index */
      .alertify-notifier { z-index: 99999 !important; }
      .alertify-notifier .ajs-message { z-index: 99999 !important; }

      /* ── Select2 overrides — match form-control height (30px) used in resource table ──
         Added by Nikhil Mane on 04-04-2026 */
      .select2-container--default .select2-selection--single { height: 30px !important; border: 1px solid #d1d5db !important; border-radius: 4px !important; }
      .select2-container--default .select2-selection--single .select2-selection__rendered { line-height: 28px !important; font-size: 11.5px !important; color: #333 !important; padding-left: 8px !important; padding-right: 20px !important; }
      .select2-container--default .select2-selection--single .select2-selection__arrow { height: 28px !important; }
      .select2-container--default .select2-selection--single .select2-selection__arrow b { border-color: #9ca3af transparent transparent transparent !important; }
      .select2-container { width: 100% !important; }
      .select2-dropdown { font-size: 11.5px !important; z-index: 99999 !important; border: 1px solid #d1d5db !important; }
      .select2-search--dropdown .select2-search__field { font-size: 11.5px !important; border: 1px solid #d1d5db !important; border-radius: 3px !important; padding: 3px 6px !important; }
      .select2-results__option { font-size: 11.5px !important; padding: 5px 8px !important; }
      .select2-results__option--highlighted { background-color: #486AC0 !important; }
      /* val-error on select2 — highlight the wrapper border */
      .val-error + .select2-container--default .select2-selection--single,
      select.val-error + .select2-container .select2-selection--single { border-color: #ef4444 !important; background-color: #fff5f5 !important; }
      /* End of Added by Nikhil Mane on 04-04-2026 */

      /* Black tooltip — same as PM_ProjectSites.aspx */
      .black-tooltip .tooltip-inner { background-color: #000; color: #fff;  padding: 6px 10px; }
      .black-tooltip .tooltip-arrow::before { border-top-color: #000; }

      /* ── Uniform confirm modals (Submit / Non-Project Skill / Delete Row) ── */
      .modalsmall { width: 420px; margin: 30px auto; }

      /* Header: flex row, title left, close button right — same pattern for all three modals */
      .modal-header.ui-draggable-handle {
        background: #486AC0;
        padding: 12px 16px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border-radius: 6px 6px 0 0;
      }
      .modal-header.ui-draggable-handle .modal-title {
        color: #fff;
        font-size: 14px;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 7px;
        margin: 0;
      }
      /* Close button — SVG ✕, always white, right-aligned via flex */
      .modal-header.ui-draggable-handle .close {
        background: transparent;
        border: none;
        padding: 2px 4px;
        cursor: pointer;
        color: #fff;
        opacity: 0.85;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 4px;
        line-height: 1;
        flex-shrink: 0;
        /* reset any inherited absolute positioning */
        position: static;
        font-size: inherit;
        font-weight: inherit;
        text-shadow: none;
      }
      .modal-header.ui-draggable-handle .close:hover { opacity: 1; background: rgba(255,255,255,0.15); }
      .modal-header.ui-draggable-handle .close svg { display: block; }

      /* Modal body */
      .modalsmall .modal-body { padding: 20px 24px; }
      .modalsmall .modal-body p { font-size: 13px; color: #374151; margin: 0; text-align: center; line-height: 1.6; }

      /* Footer — right-aligned, uniform gap */
      .modalsmall .modal-footer {
        padding: 12px 16px;
        background: #f9fafb;
        border-top: 1px solid #e5e7eb;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 8px;
        border-radius: 0 0 6px 6px;
      }

      /* Uniform button styles for all confirm modals */
      .modal-btn-cancel {
        background: #fff;
        border: 1.5px solid #d1d5db;
        color: #374151;
        padding: 6px 18px;
        border-radius: 5px;
        font-size: 12px;
        font-weight: 500;
        cursor: pointer;
        font-family: inherit;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        line-height: 1.4;
      }
      .modal-btn-cancel:hover { background: #f3f4f6; border-color: #9ca3af; }
      .modal-btn-confirm {
        background: #486AC0;
        border: 1.5px solid #486AC0;
        color: #fff;
        padding: 6px 18px;
        border-radius: 5px;
        font-size: 12px;
        font-weight: 600;
        cursor: pointer;
        font-family: inherit;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        line-height: 1.4;
      }
      .modal-btn-confirm:hover { background: #3b5aa5; border-color: #3b5aa5; }
      /* Delete confirm — red variant */
      .modal-btn-confirm.danger { background: #dc2626; border-color: #dc2626; }
      .modal-btn-confirm.danger:hover { background: #b91c1c; border-color: #b91c1c; }

       /* Delete confirm modal — mirror ProjectSites button visual style */
      #deleteRowConfirmModal .modal-footer .btn.borderbtn {
        background: #fff;
        border: 1px solid #486AC0;
        color: #1f2937;
        border-radius: 5px;
        padding: 4px 14px;
        min-width: 42px;
        font-size: 12px;
        line-height: 1.3;
      }
      #deleteRowConfirmModal .modal-footer .btn.borderbtn:hover {
        background: #f8fbff;
        border-color: #3f5eaa;
      }
      #deleteRowConfirmModal .modal-footer .btn.btnyellow {
        background: #f6b73c;
        border: 1px solid #f6b73c;
        color: #fff;
        border-radius: 5px;
        padding: 4px 14px;
        min-width: 42px;
        font-size: 12px;
        line-height: 1.3;
      }
      #deleteRowConfirmModal .modal-footer .btn.btnyellow:hover {
        background: #e3a629;
        border-color: #e3a629;
      }

      /* Ensure cursor:pointer on all interactive buttons */
      .topbtn { cursor: pointer !important; }
      .icon-btn { cursor: pointer !important; }
      .btn-add-more { cursor: pointer !important; }
      .set-skill-link { cursor: pointer !important; }
      .btncalendar { cursor: pointer !important; }
      .btn-add-skill { cursor: pointer !important; }

      /* ── No-access banner ── */
      .no-access-banner { display:flex; align-items:center; justify-content:center; height:60vh; flex-direction:column; gap:12px; color:#6b7280; }
      .no-access-banner svg { color:#d1d5db; }
      .no-access-banner h2 { font-size:16px; font-weight:600; color:#374151; margin:0; }
      .no-access-banner p  { font-size:13px; margin:0; }

      /* ── Email Preview Modal ── */
      /* Added by Nikhil Mane on 01-01-2026 */
      #emailPreviewModal { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.52); z-index:99999; overflow-y:auto; }
      .email-modal-box { background:#fff; margin:36px auto 40px; max-width:840px; border-radius:10px; box-shadow:0 8px 36px rgba(0,0,0,0.22); overflow:hidden; }
      .email-modal-header { background:#4472C4; padding:14px 20px; display:flex; align-items:center; justify-content:space-between; }
      .email-modal-header-title { color:#fff; font-size:14px; font-weight:600; display:flex; align-items:center; gap:8px; }
      .email-modal-close { background:none; border:none; color:#fff; font-size:22px; cursor:pointer; line-height:1; padding:0 4px; }
      .email-modal-body { padding:20px 24px; }
      .email-modal-info { background:#eff6ff; border:1px solid #bfdbfe; border-radius:6px; padding:10px 14px; margin-bottom:16px; font-size:12px; color:#1e40af; }
      .email-field-group { margin-bottom:12px; }
      .email-field-label { font-size:12px; font-weight:600; color:#374151; display:block; margin-bottom:4px; }
      .email-field-note { font-weight:400; color:#6b7280; }
      .email-field-input { width:100%; font-size:12px; height:32px; padding:4px 10px; border:1px solid #d1d5db; border-radius:4px; font-family:inherit; }
      .email-field-input:focus { outline:none; border-color:#4472C4; box-shadow:0 0 0 2px rgba(68,114,196,.15); }
      .email-field-input.readonly { background:#f9fafb; color:#6b7280; border-color:#e5e7eb; cursor:default; }
      .email-preview-label { font-size:12px; font-weight:600; color:#374151; display:block; margin-bottom:6px; margin-top:4px; }
      .email-preview-iframe { width:100%; height:320px; border:1px solid #e5e7eb; border-radius:6px; background:#fff; }
      .email-modal-footer { padding:14px 24px; background:#f9fafb; border-top:1px solid #e5e7eb; display:flex; justify-content:flex-end; gap:10px; }
      .email-modal-btn { padding:7px 20px; border-radius:5px; font-size:12px; cursor:pointer; font-family:inherit; font-weight:500; border:none; display:inline-flex; align-items:center; gap:6px; }
      .email-modal-btn-cancel { background:#fff; border:1.5px solid #d1d5db; color:#374151; }
      .email-modal-btn-cancel:hover { background:#f3f4f6; }
      .email-modal-btn-send { background:#4472C4; color:#fff; font-weight:600; }
      .email-modal-btn-send:hover { background:#3460b0; }
      .email-modal-btn-send:disabled { background:#93afd8; cursor:not-allowed; }
.header-subtitle {
    font-size: 11px;
    font-weight: 400;
    opacity: 0.9;
    margin: 0;
}
.section-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    cursor:pointer;
}

.note-chevron{
    transition: transform 0.2s ease;
}

.note-chevron.open{
    transform: rotate(180deg);
}
#projectDetailsGrid{
    display:none;
}
.section-body{
    display:none;
}
      /* End Added by Nikhil Mane on 01-01-2026 */
      /* Loader overlay — same as PM_ProjectSites */
      .loader-overlay { position: fixed; top: 0; left: 0; right: 0; bottom: 0; width: 100%; height: 100%; background-color: transparent; z-index: 2000; }
      .loader-overlay .loader { position: absolute; top: 50%; left: 50%; width: 100px; height: 100px; margin: -50px 0 0 -50px; background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center; }
    </style>
  </head>
  <body class="bgwhite">
    <%-- Page Loader — same as PM_ProjectSites --%>
    <div class="loader-overlay" id="pageLoader" style="display: none;">
      <div class="loader"></div>
    </div>
    <form id="form1" runat="server">

      <%-- ═══ Role Access Guard (mirrors PM_EarnedValueReports.aspx pattern) ═══ --%>
      <%If m_blnViewAccess = True Then%>

      <%-- ═══ Page header band (normal page flow — not frozen) ═══ --%>

        <%-- Page header band --%>
        <div class="page-header-band">
          <h1 class="page-title"><i class="fas fa-users pe-2" style="font-size:16px;"></i> <%=MyBase.GetResourceString("C_PageHeader")%></h1>
            <p class="header-subtitle">Manage bulk resource requests submission for the project.</p>
        </div>

        <%-- Note bar + action buttons (frozen with header) --%>
        <div class="note-actions-row">
          <%-- Updated by Nikhil Mane on 04-04-2026 — note section: always-visible bullet list;
               all hints shown as bullet points; expand/collapse shows the full description. --%>
          <div class="note-bar">
            <div class="note-header" onclick="toggleNote()">
              <div class="note-left">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="flex-shrink:0;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                <strong>Notes</strong>
              </div>
              <span class="note-chevron" id="noteChevron">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"/></svg>
              </span>
            </div>
            <%-- Collapsible bullet list — hidden by default, shown on toggle --%>
            <div class="note-expanded" id="noteExpanded">
              <ul class="note-bullets-always">
                <li><span class="note-bullet">&#8226;</span><%=MyBase.GetResourceString("C_PageSubtitle")%></li>
                <li><span class="note-bullet">&#8226;</span><%=MyBase.GetResourceString("C_NoteHint1")%></li>
                <li><span class="note-bullet">&#8226;</span><%=MyBase.GetResourceString("C_NoteHint2")%></li>
                <li><span class="note-bullet">&#8226;</span><%=MyBase.GetResourceString("C_NoteHint3")%></li>
                <li id="noteHintRowLimit" style="display:none;"><span class="note-bullet">&#8226;</span></li>
              </ul>
            </div>
          </div>
          <%-- Save As Draft and Submit: require Add access. Edit access = View access (read-only). --%>
          <%If m_blnAddAccess = True Then%>
          <div class="action-buttons">
            <button type="button" class="topbtn topbtn-outline" onclick="saveDraft()"
              data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="bottom"
              title="<%=MyBase.GetResourceString("C_SaveAsDraft")%>">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v14a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
              <%=MyBase.GetResourceString("C_SaveAsDraft")%>
            </button>
            <button type="button" class="topbtn topbtn-primary" onclick="submitRequest()"
              data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="bottom"
              title="<%=MyBase.GetResourceString("C_Submit")%>">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
              <%=MyBase.GetResourceString("C_Submit")%>
            </button>
          </div>
          <%End If%>
        </div>

      <div class="page-wrapper">

        <%-- Project Details + Additional Columns --%>
        <div class="top-row">
          <div class="project-details-card">
              <div class="section-header" onclick="toggleSection('projectDetailsGrid','projectChevron')">
            <h2>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2"/><line x1="3" y1="9" x2="21" y2="9"/><line x1="9" y1="21" x2="9" y2="9"/></svg>
              Project Details
            </h2>
                  <span class="note-chevron" id="projectChevron">
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
        <polyline points="6 9 12 15 18 9"/>
      </svg>
    </span>

  </div>
            <div class="project-grid section-body" id="projectDetailsGrid">
              <div class="project-field"><label><%=MyBase.GetResourceString("C_ProjectName")%></label><span class="value" id="pdProjectName">Loading</span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_StartDate")%></label><span class="value" id="pdStartDate"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_EndDate")%></label><span class="value" id="pdEndDate"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_Customer")%></label><span class="value" id="pdCustomer"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_NoOfResources")%></label><span class="value" id="pdNoOfResources"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_WorkHours")%></label><span class="value" id="pdWorkHours"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_Billable")%></label><span class="value" id="pdBillable"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_ProjectCurrency")%></label><span class="value" id="pdProjectCurrency"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_TotalRevenue")%></label><span class="value" id="pdTotalRevenue"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_TotalBudget")%></label><span class="value" id="pdTotalBudget"></span></div>
              <div class="project-field"><label><%=MyBase.GetResourceString("C_GrossProfitMargin")%></label><span class="value" id="pdGrossProfitMargin"></span></div>
            </div>
          </div>

          <div class="additional-columns-card" id="additionalColumnsCard">
            <div class="section-header" onclick="toggleAdditionalColumns()" style="margin-bottom:8px;">
              <h3 style="margin-bottom:0;"><%=MyBase.GetResourceString("C_AdditionalColumns")%></h3>
              <span class="note-chevron" id="additionalColChevron">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"/></svg>
              </span>
            </div>
            <div id="additionalColBody" style="display:none;">
              <div class="tag-bar" id="tagBar">
                <button type="button" class="tag-bar-chevron-btn" id="tagBarChevronBtn"
                  data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Select Additional Columns">
                  <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"/></svg>
                </button>
              </div>
              <div class="col-dropdown" id="colDropdown"></div>
            </div>
          </div>
        </div>

        <%-- Resource Table --%>
        <div class="resource-table-wrapper">
          <div class="table-scroll">
            <table class="resource-table" id="resourceTable">
              <thead>
                <tr id="tableHeader">
                  <th style="width:86px;"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/><circle cx="5" cy="12" r="1"/></svg></span><%=MyBase.GetResourceString("C_Actions")%></div></th>
                  <th><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg></span><%=MyBase.GetResourceString("C_TypeOfRequirement")%></div></th>
                  <th><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/></svg></span><%=MyBase.GetResourceString("C_ProjectRole")%></div></th>
                  <th style="width:78px;"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="6" x2="20" y2="6"/><line x1="4" y1="12" x2="20" y2="12"/><line x1="4" y1="18" x2="20" y2="18"/></svg></span><%=MyBase.GetResourceString("C_NoOfResourcesCol")%></div></th>
                  <th><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg></span><%=MyBase.GetResourceString("C_FromDate")%></div></th>
                  <th><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg></span><%=MyBase.GetResourceString("C_ToDate")%></div></th>
                  <%-- Added by Nikhil Mane on 31-03-2026 — Allocation Type: mandatory fixed column, placed before Allocation % --%>
                  <th style="min-width:120px;"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg></span>Allocation Type</div></th>
                  <%-- End of Added by Nikhil Mane on 31-03-2026 --%>
                  <th style="width:84px;"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="19" y1="5" x2="5" y2="19"/><circle cx="6.5" cy="6.5" r="2.5"/><circle cx="17.5" cy="17.5" r="2.5"/></svg></span>Allocation Unit</div></th>
                  <%-- Added by Nikhil Mane on 31-03-2026 — Special Request: optional dynamic column --%>
                  <th class="dyn-th" data-col="special-request"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg></span>Special Request</div></th>
                  <%-- End of Added by Nikhil Mane on 31-03-2026 --%>
                  <th class="dyn-th" data-col="department"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg></span><%=MyBase.GetResourceString("C_Department")%></div></th>
                  <th class="dyn-th" data-col="resource-pool"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="7" r="4"/><path d="M3 21v-2a4 4 0 0 1 4-4h4"/><circle cx="17" cy="17" r="4"/></svg></span><%=MyBase.GetResourceString("C_ResourcePool")%></div></th>
                  <th class="dyn-th" data-col="location"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z"/><circle cx="12" cy="9" r="2.5"/></svg></span><%=MyBase.GetResourceString("C_Location")%></div></th>
                  <th class="dyn-th" data-col="engagement-model"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg></span><%=MyBase.GetResourceString("C_EngagementModel")%></div></th>
                  <th class="dyn-th" data-col="priority"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg></span><%=MyBase.GetResourceString("C_Priority")%></div></th>
                  <th class="dyn-th" data-col="billable-position"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg></span><%=MyBase.GetResourceString("C_BillablePosition")%></div></th>
                  <th class="dyn-th" data-col="billing-start-date"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg></span><%=MyBase.GetResourceString("C_BillingStartDate")%></div></th>
                  <th class="dyn-th" data-col="sow-available"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg></span><%=MyBase.GetResourceString("C_SOWAvailable")%></div></th>
                  <th class="dyn-th" data-col="jd-attachment"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21.44 11.05l-9.19 9.19a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48"/></svg></span><%=MyBase.GetResourceString("C_JDAttachment")%></div></th>
                  <%-- Nature of Request: UI-only readonly column. Visible only when sow-available column is selected. --%>
                  <%-- Value is auto-computed from SOW Available + Billing Start Date. Not sent in payload. --%>
                  <th class="dyn-th" data-col="nature-of-request" style="min-width:130px;"><div class="th-inner"><span class="th-icon"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg></span>Nature of Request</div></th>
                </tr>
              </thead>
              <tbody id="resourceTableBody"></tbody>
            </table>
          </div>
          <div class="add-more-row">
            <%If m_blnAddAccess = True Then%>
            <button type="button" class="btn-add-more" onclick="addRow()"
              data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top"
              title="<%=MyBase.GetResourceString("C_AddMore")%>">
              <span class="plus">+</span> <%=MyBase.GetResourceString("C_AddMore")%>
            </button>
            <%End If%>
          </div>
        </div>

      </div><%-- end .page-wrapper --%>
     
      <%-- ═══════════════════════════════════════════════════════════════════
           EMAIL PREVIEW MODAL — HIDDEN/COMMENTED OUT
           Mail is now sent directly after submit without showing this popup.
           The To value from GetEmailPreview is used automatically.
           Commented out by request — mail popup modal hidden.
      ════════════════════════════════════════════════════════════════════ --%>
      <%--
      <div id="emailPreviewModal">
        <div class="email-modal-box">

          <%-- Header 
          <div class="email-modal-header">
            <span class="email-modal-header-title">
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                <polyline points="22,6 12,13 2,6"/>
              </svg>
              <%=MyBase.GetResourceString("C_EmailModalTitle")%>
            </span>
            <button type="button" class="email-modal-close" onclick="closeEmailModal()"
              data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="Close">&times;</button>
          </div>

          <%-- Body 
          <div class="email-modal-body">

            <div class="email-modal-info">
              <strong>&#9432;&nbsp; Single Email:</strong>
              <%=MyBase.GetResourceString("C_EmailModalInfo")%>
            </div>

            <%-- From (read-only) 
            <div class="email-field-group">
              <label class="email-field-label"><%=MyBase.GetResourceString("C_EmailFrom")%></label>
              <input type="text" id="emailPreviewFrom" class="email-field-input readonly" readonly />
            </div>

            <%-- To (editable) 
            <div class="email-field-group">
              <label class="email-field-label">
                <%=MyBase.GetResourceString("C_EmailTo")%> <span style="color:red;">*</span>
                <span class="email-field-note"><%=MyBase.GetResourceString("C_EmailCommaSeparated")%></span>
              </label>
              <input type="text" id="emailPreviewTo" class="email-field-input" placeholder="<%=MyBase.GetResourceString("C_EmailToPlaceholder")%>" />
            </div>

            <%-- CC (editable) 
            <div class="email-field-group">
              <label class="email-field-label">
                <%=MyBase.GetResourceString("C_EmailCC")%> <span class="email-field-note"><%=MyBase.GetResourceString("C_EmailCommaSeparated")%></span>
              </label>
              <input type="text" id="emailPreviewCC" class="email-field-input" />
            </div>

            <%-- Subject (editable) 
            <div class="email-field-group">
              <label class="email-field-label"><%=MyBase.GetResourceString("C_EmailSubject")%></label>
              <input type="text" id="emailPreviewSubject" class="email-field-input" />
            </div>

            <%-- Body preview (read-only iframe) --%>
             <%--  <div class="email-field-group" style="margin-bottom:0;">
              <label class="email-preview-label">
                <%=MyBase.GetResourceString("C_EmailBodyPreview")%>
                <span class="email-field-note"><%=MyBase.GetResourceString("C_EmailBodyReadOnly")%></span>
              </label>
              <iframe id="emailPreviewFrame" class="email-preview-iframe" sandbox="allow-same-origin"></iframe>
            </div>

            <%-- Hidden store --%>
            <input type="hidden" id="emailPreviewRequestIDs" value="" />

          <%--</div> --%>

          <%-- Footer --%>
          <%-- <div class="email-modal-footer">
            <button type="button" class="email-modal-btn email-modal-btn-cancel" onclick="closeEmailModal()"
              data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Cancel and close">
              <%=MyBase.GetResourceString("C_EmailCancel")%>
            </button>
            <button type="button" class="email-modal-btn email-modal-btn-send" id="btnSendEmailConfirm" onclick="confirmSendEmail()"
              data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Send the email notification">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/>
              </svg>
              <%=MyBase.GetResourceString("C_SendEmail")%>
            </button>
          </div>

        </div>
      </div> --%>
      
      <%-- End Email Preview Modal (hidden) — Added by Nikhil Mane on 01-01-2026 --%>

      <%-- ═══ Submit Confirm Modal (replaces browser confirm()) ═══ --%>
      <div id="submitConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall ui-draggable">
          <div class="modal-content">
            <div class="modal-header ui-draggable-handle">
              <h4 class="modal-title">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
                <%=MyBase.GetResourceString("C_Submit")%>
              </h4>
              <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" id="btnSubmitConfirmClose"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="Cancel">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
              </button>
            </div>
            <div class="modal-body">
              <p align="center" id="submitConfirmMsg"><%=MyBase.GetResourceString("C_ConfirmSubmit")%></p>
            </div>
            <div class="modal-footer">
              <button type="button" class="modal-btn-confirm" id="btnSubmitConfirmYes"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Confirm and submit the request">
                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
                Submit
              </button>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
      </div>
      <%-- End Submit Confirm Modal --%>
          <%-- ═══ Non-Project Skills Confirmation Modal ═══ --%>
      <div id="nonProjectSkillModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall ui-draggable">
          <div class="modal-content">
            <div class="modal-header ui-draggable-handle">
              <h4 class="modal-title">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                Confirmation
              </h4>
              <button type="button" class="close" aria-label="Close" id="btnNonProjectSkillClose"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="Cancel">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
              </button>
            </div>
            <div class="modal-body">
              <p align="center" id="nonProjectSkillMessage">
                Do you want to add <strong><span id="nonProjectSkillName"></span></strong> skill to the project?
              </p>
            </div>
            <div class="modal-footer">
              <button type="button" class="modal-btn-cancel" id="btnCancelNonProjectSkill"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Cancel skill selection">Cancel</button>
              <button type="button" class="modal-btn-confirm" id="btnConfirmNonProjectSkill"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Confirm skill selection">
                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg>
                Yes
              </button>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
      </div>
         <%-- ═══ Delete Row Confirmation Modal ═══ --%>
      <div id="deleteRowConfirmModal" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall ui-draggable">
          <div class="modal-content">
            <div class="modal-header ui-draggable-handle">
              <h4 class="modal-title">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <polyline points="3 6 5 6 21 6"/>
                  <path d="M19 6l-1 14H6L5 6"/>
                  <path d="M10 11v6"/>
                  <path d="M14 11v6"/>
                </svg>
                Confirm Delete
              </h4>
              <button type="button" class="close" aria-label="Close" id="btnDeleteRowClose"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="left" title="Cancel">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
              </button>
            </div>
            <div class="modal-body">
              <p align="center">Are you sure you want to delete this row? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="modal-btn-cancel" id="btnCancelDeleteRow"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Cancel delete">Cancel</button>
              <button type="button" class="modal-btn-confirm" id="btnConfirmDeleteRow"
                data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Delete row">
                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/></svg>
                Delete
              </button>
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
      </div>

      <%-- ═══ No View Access banner ═══ --%>
      <%Else%>
      <div class="no-access-banner">
        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><line x1="4.93" y1="4.93" x2="19.07" y2="19.07"/></svg>
        <h2><%=MyBase.GetResourceString("C_UnauthorizedAccess")%></h2>
        <p><%=MyBase.GetResourceString("C_UnauthorizedMsg")%></p>
      </div>
      <%End If%>
      <%-- ═══ End Role Access Guard ═══ --%>

    </form>

    <%-- JS stack --%>
    <script src="../../../EnhancementFiles/New_CommonFunctions.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/select2/select2.js"></script>
    <%-- Bootstrap 5 bundle (includes Popper for tooltips & modals) --%>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <%-- LoadingOverlay scripts — same as PM_ProjectSites --%>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>

    <%-- Server-rendered select templates --%>
    <div id="tmplSelects" style="display:none;">
      <span id="tmpl-type-of-req"><% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectTOReq", "usp_Whizible2_Sel_TypeOfRequirement",,, "Onchange='ValidateReEmployeeName(this.value)' class='form-control'",,, ) %></span>
      <span id="tmpl-project-role"><% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectRoleAdd", "usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo",,, "class='form-control'",,, ) %></span>
      <%-- Added by Nikhil Mane on 31-03-2026 — Allocation Type template (same SP as cbotype in PM_Resource_Selection) --%>
      <span id="tmpl-allocation-type"><% CommonFunctions.HTMLControls.DrawComboBox("cboAllocType_tmpl", "usp_Whizible2_Sel_RequestedType_tbl_PM_ResourceRequest",,, "class='form-control'",,, ) %></span>
      <%-- End of Added by Nikhil Mane on 31-03-2026 --%>
      <span id="tmpl-department"><% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectDepartment", "usp_Whizible2_Sel_tbl_PM_DepartmentMaster",,, "class='form-control'",,, ) %></span>
      <span id="tmpl-resource-pool"><%=CommonFunctions.HTMLControls.DrawComboBox("cboResourcePools_tmpl", "usp_Whizible2_Sel_tbl_PM_ResourcePoolMaster_ForCombo",,, "class='form-control'",,,)%></span>
      <span id="tmpl-location"><%=CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectLocation_tmpl", "usp_Whizible2_Sel_tbl_PM_LocationMaster",,, "class='form-control'",,,)%></span>
      <span id="tmpl-engagement-model"><%=CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectEngagementModel_tmpl", "usp_Whizible2_Sel_EngagementModel",,, "class='form-control'",,,)%></span>
      <span id="tmpl-priority"><%=CommonFunctions.HTMLControls.DrawComboBox("cboRPriority_tmpl", "usp_Whizible2_Sel_tbl_HR_Parameters 2",,, "class='form-control'",,,)%></span>
      <span id="tmpl-billable-position"><%=CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectBillablePosition_tmpl", "usp_Whizible2_Sel_BillablePosition",,, "class='form-control'",,,)%></span>
      <span id="tmpl-skill-master"><%=CommonFunctions.HTMLControls.DrawComboBox("cboSkillMasterName", "select ''", , , "Mandatory=1 class=""form-control clsMandatoryFields skill-select""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "&#39;")%></span>
      <span id="tmpl-skill-month"><%=CommonFunctions.HTMLControls.DrawComboBox("cboMonthName", "usp_Sel_GetYears 0 ,30 ", 50, , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "&#39;")%></span>
      <span id="tmpl-skill-year"><%=CommonFunctions.HTMLControls.DrawComboBox("cboYearName", "usp_Sel_GetYears 0 ,11 ", 50, , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "&#39;")%></span>
      <span id="tmpl-skill-proficiency"><%=CommonFunctions.HTMLControls.DrawComboBox("cboParametersName", "usp_Whizible2_Sel_tbl_HR_Parameters 7 ", , , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "&#39;")%></span>
    </div>

    <script>
        var strUrl = '<%=ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        if (strUrl.endsWith('/')) { strUrl = strUrl.slice(0, -1); }
        /* App virtual root e.g. /W26_NewDev — used to build absolute file hrefs */
        var strAppRoot = '<%=Request.ApplicationPath.TrimEnd("/")%>';
        /* JD attachment validation config — read from web.config via server-side emit */
        var intJDMinFileSize       = parseInt('<%=ConfigurationManager.AppSettings("inFileSize")%>') || 0;
        var strJDExtensionDisallow = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>';

        (function () {
            'use strict';

            var _rowCount = 0;

            function cloneSelect(templateId, newId) {
                var src = document.getElementById(templateId);
                if (!src) return '<select class="form-control"><option value="">Select</option></select>';
                var html = src.innerHTML;
                html = html.replace(/(<select\b[^>]*\bid=)(['"])[^'"]*\2/i, '$1"' + newId + '"');
                html = html.replace(/(<select\b[^>]*\bname=)(['"])[^'"]*\2/i, '$1"' + newId + '"');
                return html;
            }

            function dateField(inputId) {
                return '<div class="datefielddiv">' +
                    '<input type="text" id="' + inputId + '" class="form-control" ' +
                    'autocomplete="off" readonly="readonly" placeholder="dd/mm/yyyy" style="background:#fff;min-width:110px;" />' +
                    '<span class="datefield-btn-wrap">' +
                    '<button class="btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>' +
                    '</span></div>';
            }

            function initDatepicker(inputId) {
                $('#' + inputId).datepicker({
                    autoclose: true, changeMonth: true, changeYear: true,
                    yearRange: 'c-100:c+100', dateFormat: 'dd M yy'
                });
                $('#' + inputId).closest('.datefielddiv').find('.btncalendar')
                    .off('click.dp').on('click.dp', function () { $('#' + inputId).datepicker('show'); });
            }

            /* ALL_COLS — populated dynamically from usp_PM_BulkRequest_GetColumnMaster
               via loadColumnMaster() on DOMContentLoaded.
               FALLBACK_COLS is used if the API call fails so the page still works. */
            var FALLBACK_COLS = [
                { id: 1,  key: 'department',        label: 'Department' },
                { id: 2,  key: 'resource-pool',     label: 'Resource Pool' },
                { id: 3,  key: 'location',          label: 'Location' },
                { id: 4,  key: 'engagement-model',  label: 'Engagement Model' },
                { id: 5,  key: 'priority',          label: 'Priority' },
                { id: 6,  key: 'billable-position', label: 'Billable Position' },
                { id: 7,  key: 'billing-start-date',label: 'Billing Start Date' },
                { id: 8,  key: 'sow-available',     label: 'SOW Available' },
                { id: 9,  key: 'jd-attachment',     label: 'JD Attachment' },
                /* Added by Nikhil Mane on 31-03-2026 — Special Request optional column */
                { id: 10, key: 'special-request',   label: 'Special Request' },
                /* End of Added by Nikhil Mane on 31-03-2026 */
                /* Nature of Request: UI-only readonly column. Auto-computed. Not sent in payload. */
                { id: 11, key: 'nature-of-request', label: 'Nature of Request' }
            ];

            var ALL_COLS = [];   /* filled by loadColumnMaster() */

            var selectedOrder  = [];
            var unselectedKeys = [];
            var dragSrcKey     = null;

            function labelFor(key) {
                if(key == 'nature-of-request'){
                    return 'Nature of Request';
                }
                
                var c = ALL_COLS.find(function (c) { return c.key === key; });
                return c ? c.label : key;
            }

            window.toggleNote = function () {
                var el = document.getElementById('noteExpanded');
                var ch = document.getElementById('noteChevron');
                var open = window.getComputedStyle(el).display !== 'none';
                el.style.display = open ? 'none' : 'block';
                ch.classList.toggle('open', !open);
            };
           window.toggleSection = function (contentId, chevronId) {

    var el = document.getElementById(contentId);
    var ch = document.getElementById(chevronId);

    var open = window.getComputedStyle(el).display !== 'none';

    el.style.display = open ? 'none' : 'grid';

    ch.classList.toggle('open', !open);
};

            window.toggleAdditionalColumns = function () {
                var body = document.getElementById('additionalColBody');
                var ch   = document.getElementById('additionalColChevron');
                if (!body) return;
                var open = window.getComputedStyle(body).display !== 'none';
                body.style.display = open ? 'none' : 'block';
                body.style.marginTop = open ? '' : '8px';
                ch.classList.toggle('open', !open);
            };
            var _ddOpen = false;
            var _currentBulkRequestID = 0;
            var _projectStartDate = null;
            var _projectEndDate   = null;

            function _positionDropdown() {
                var card = document.getElementById('additionalColumnsCard');
                var dd   = document.getElementById('colDropdown');
                if (!card || !dd) return;
                var rect = card.getBoundingClientRect();
                dd.style.top   = (rect.bottom + 4) + 'px';
                dd.style.left  = rect.left + 'px';
                dd.style.width = rect.width + 'px';
            }

            function _colDDOpen() {
                var dd  = document.getElementById('colDropdown');
                var btn = document.getElementById('tagBarChevronBtn');
                var card = document.getElementById('additionalColumnsCard');
                if (!dd || _ddOpen) return;
                document.body.appendChild(dd);
                _positionDropdown();
                dd.classList.add('open');
                if (btn) btn.classList.add('open');
                _ddOpen = true;
            }

            function _colDDClose() {
                var dd  = document.getElementById('colDropdown');
                var btn = document.getElementById('tagBarChevronBtn');
                var card = document.getElementById('additionalColumnsCard');
                if (!dd || !_ddOpen) return;
                dd.classList.remove('open');
                if (btn) btn.classList.remove('open');
                if (dd.parentNode === document.body && card) card.appendChild(dd);
                _ddOpen = false;
            }

            window.toggleColDropdown = function (e) {
                if (e) { e.stopPropagation(); e.preventDefault(); }
                if (_ddOpen) _colDDClose(); else _colDDOpen();
            };

            window.addEventListener('scroll', function () { if (_ddOpen) _positionDropdown(); }, true);
            window.addEventListener('resize', function () { if (_ddOpen) _positionDropdown(); });
            document.addEventListener('click', function (e) {
                if (!_ddOpen) return;
                var dd   = document.getElementById('colDropdown');
                var card = document.getElementById('additionalColumnsCard');
                if (!((card && card.contains(e.target)) || (dd && dd.contains(e.target)))) _colDDClose();
            });

            function renderTagBar() {
                var bar = document.getElementById('tagBar');
                var chevBtn = bar.querySelector('.tag-bar-chevron-btn');
                Array.from(bar.children).forEach(function (ch) {
                    if (!ch.classList.contains('tag-bar-chevron-btn')) bar.removeChild(ch);
                });
                selectedOrder.forEach(function (key) {
                    var pill = document.createElement('span');
                    pill.className = 'col-tag';
                    /* Updated by Nikhil Mane on 02-04-2026 — mandatory columns show a
                       dimmed ✕ with "not-allowed" cursor so the user can see the button
                       but cannot click it to remove the column. _isColMandatory() covers
                       both IsResourceRequestNewFieldsManatory columns and IsResourcePoolMandatory
                       → 'resource-pool'. */
                    pill.innerHTML = labelFor(key) +
                        (_isColMandatory(key)
                            ? '<span class="remove-tag" style="opacity:0.35;cursor:not-allowed;" title="Mandatory column — cannot be removed">&#x2715;</span>'
                            : '<span class="remove-tag" onclick="deselectCol(event,\'' + key + '\')" title="Remove">&#x2715;</span>');
                    bar.insertBefore(pill, chevBtn);
                });
            }

            /* _removeFromSelected(key) — internal helper used by deselectCol to
               silently move a key from selectedOrder to unselectedKeys without
               triggering the mandatory-column guard or firing saveColumnPreference.
               Used for paired-column removal (billable-position ↔ billing-start-date). */
            function _removeFromSelected(key) {
                if (selectedOrder.indexOf(key) === -1) return;
                selectedOrder = selectedOrder.filter(function (k) { return k !== key; });
                var origIdx = ALL_COLS.findIndex(function (c) { return c.key === key; });
                var insertAt = 0;
                for (var i = 0; i < unselectedKeys.length; i++) {
                    var uIdx = ALL_COLS.findIndex(function (c) { return c.key === unselectedKeys[i]; });
                    if (uIdx < origIdx) insertAt = i + 1;
                }
                unselectedKeys.splice(insertAt, 0, key);
            }

            window.deselectCol = function (e, key) {
                if (e) e.stopPropagation();

                /* Check if this is a mandatory column.
                   Updated by Nikhil Mane on 02-04-2026 — delegates to _isColMandatory()
                   which covers both IsResourceRequestNewFieldsManatory columns and
                   the independent IsResourcePoolMandatory → 'resource-pool' case. */
                if (_isColMandatory(key)) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('This column is mandatory and cannot be removed.');
                    return;
                }

                /* sow-available: nature-of-request stays permanently selected now,
                   so no need to auto-remove it when sow-available is deselected. */

                /* Billable Position ↔ Billing Start Date are always paired.
                   Removing one from the dropdown automatically removes the other. */
                if (key === 'billable-position' && selectedOrder.indexOf('billing-start-date') !== -1) {
                    _removeFromSelected('billing-start-date');
                }
                if (key === 'billing-start-date' && selectedOrder.indexOf('billable-position') !== -1) {
                    _removeFromSelected('billable-position');
                }

                selectedOrder = selectedOrder.filter(function (k) { return k !== key; });
                var origIdx = ALL_COLS.findIndex(function (c) { return c.key === key; });
                var insertAt = 0;
                for (var i = 0; i < unselectedKeys.length; i++) {
                    var uIdx = ALL_COLS.findIndex(function (c) { return c.key === unselectedKeys[i]; });
                    if (uIdx < origIdx) insertAt = i + 1;
                }
                unselectedKeys.splice(insertAt, 0, key);
                renderDropdown(); renderTagBar(); syncTableColumns();
            };

            /* _autoSelectCol(key) — programmatically add a column to selectedOrder
               (mirrors the checkbox-checked branch in makeRow's change handler).
               Used by the Billable Position ↔ Billing Start Date auto-link.
               Added by Nikhil Mane */
            function _autoSelectCol(key) {
                if (selectedOrder.indexOf(key) !== -1) return; /* already selected */
                unselectedKeys = unselectedKeys.filter(function (k) { return k !== key; });
                selectedOrder.push(key);
                renderDropdown(); renderTagBar(); syncTableColumns();
                saveColumnPreference();
            }


             /* Always resets scrollTop to 0 after rebuild so the selected section
             * (top of the list) is visible even when the dropdown was previously
             * scrolled down. Without this, columns at the top of selectedOrder
             * (Department, Location, Engagement Model etc.) are hidden off-screen
             * when the dropdown re-renders after loadBulkRequest updates the state. */
            function renderDropdown() {
                var dd = document.getElementById('colDropdown');
                dd.innerHTML = '';
                if (selectedOrder.length > 0) {
                    var lbl = document.createElement('div');
                    lbl.className = 'dd-section-label';
                    lbl.textContent = 'Selected : drag to reorder';
                    dd.appendChild(lbl);
                    selectedOrder.forEach(function (key) { dd.appendChild(makeRow(key, true)); });
                }
                if (unselectedKeys.length > 0) {
                    if (selectedOrder.length > 0) { var hr = document.createElement('hr'); hr.className = 'dd-divider'; dd.appendChild(hr); }
                    unselectedKeys.forEach(function (key) { dd.appendChild(makeRow(key, false)); });
                }
                /* Reset scroll to top so selected columns at the head of the list
                   are always visible after a rebuild, regardless of prior scroll pos. */
                dd.scrollTop = 0;
            }
            /* End of Updated by Nikhil Mane on 01-04-2026 */

            function makeRow(key, isSelected) {
                var row = document.createElement('div');
                row.className = 'col-dd-row' + (isSelected ? ' is-selected' : '');
                row.setAttribute('data-col', key);
                if (isSelected) row.setAttribute('draggable', 'true');
                var cbId = 'chk-' + key;

                /* Updated by Nikhil Mane on 02-04-2026 — delegates to _isColMandatory()
                   which covers both IsResourceRequestNewFieldsManatory columns and the
                   independent IsResourcePoolMandatory → 'resource-pool' case. */
                var isMandatory = _isColMandatory(key);

                row.innerHTML =
                    '<span class="dd-handle" title="Drag to reorder">&#8942;&#8942;</span>' +
                    '<input type="checkbox" id="' + cbId + '" data-col="' + key + '"' + (isSelected ? ' checked' : '') + (isMandatory ? ' disabled' : '') + ' />' +
                    '<label for="' + cbId + '"' + (isMandatory ? ' style="color:#6b7280;"' : '') + '>' + labelFor(key) + '</label>';

                row.querySelector('input').addEventListener('change', function (ev) {
                    ev.stopPropagation();

                    if (ev.target.checked) {
                        unselectedKeys = unselectedKeys.filter(function (k) { return k !== key; });
                        selectedOrder.push(key);
                        renderDropdown(); renderTagBar(); syncTableColumns();
                        /* Added by Nikhil Mane on 01-01-2026 — persist column selection immediately */
                        saveColumnPreference();
                        /* End of Added by Nikhil Mane on 01-01-2026 */
                        /* Auto-link: selecting billable-position also selects billing-start-date
                           and vice versa — always, regardless of mandatory flag. */
                        if (key === 'billable-position') { _autoSelectCol('billing-start-date'); }
                        else if (key === 'billing-start-date') { _autoSelectCol('billable-position'); }
                        /* nature-of-request is always selected permanently — no auto-link needed */
                    } else {
                        /* Prevent unchecking mandatory columns.
                           Updated by Nikhil Mane on 02-04-2026 — delegates to _isColMandatory(). */
                        if (_isColMandatory(key)) {
                            ev.target.checked = true; /* Re-check the checkbox */
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('This column is mandatory and cannot be removed.');
                            return;
                        }
                        deselectCol(null, key);
                        /* Added by Nikhil Mane on 01-01-2026 — persist column deselection immediately */
                        saveColumnPreference();
                        /* End of Added by Nikhil Mane on 01-01-2026 */
                    }
                });

                if (isSelected) {
                    row.addEventListener('dragstart', function (ev) {
                        dragSrcKey = key; ev.dataTransfer.effectAllowed = 'move';
                        setTimeout(function () { row.classList.add('dragging'); }, 0);
                    });
                    row.addEventListener('dragend', function () {
                        row.classList.remove('dragging');
                        document.querySelectorAll('.col-dd-row').forEach(function (r) { r.classList.remove('drag-over-above', 'drag-over-below'); });
                    });
                    row.addEventListener('dragover', function (ev) {
                        ev.preventDefault();
                        if (!dragSrcKey || dragSrcKey === key) return;
                        document.querySelectorAll('.col-dd-row').forEach(function (r) { r.classList.remove('drag-over-above', 'drag-over-below'); });
                        var rect = row.getBoundingClientRect();
                        row.classList.add(ev.clientY < rect.top + rect.height / 2 ? 'drag-over-above' : 'drag-over-below');
                    });
                    row.addEventListener('dragleave', function () { row.classList.remove('drag-over-above', 'drag-over-below'); });
                    row.addEventListener('drop', function (ev) {
                        ev.stopPropagation();
                        row.classList.remove('drag-over-above', 'drag-over-below');
                        if (!dragSrcKey || dragSrcKey === key) return;
                        var rect = row.getBoundingClientRect();
                        var before = ev.clientY < rect.top + rect.height / 2;
                        var fi = selectedOrder.indexOf(dragSrcKey), ti = selectedOrder.indexOf(key);
                        if (fi < 0 || ti < 0) return;
                        selectedOrder.splice(fi, 1);
                        var newTi = selectedOrder.indexOf(key);
                        selectedOrder.splice(before ? newTi : newTi + 1, 0, dragSrcKey);
                        dragSrcKey = null;
                        renderDropdown(); renderTagBar(); syncTableColumns();
                        /* Added by Nikhil Mane on 01-01-2026 — persist reordered columns */
                        saveColumnPreference();
                        /* End of Added by Nikhil Mane on 01-01-2026 */
                    });
                }
                return row;
            }

            /* Updated by Nikhil Mane on 01-04-2026
             * syncTableColumns()
             * ──────────────────────────────────────────────────────────────────
             * Pure DOM sync — reorders and shows/hides all dynamic header <th>
             * and body <td> elements to match the current selectedOrder /
             * unselectedKeys globals.
             *
             * These globals are the single source of truth. They are set by:
             *   • loadColumnPreference() — on page load / project switch
             *     (sorts prefs by columnOrder, resolves against ALL_COLS,
             *      splits on applicable flag)
             *   • deselectCol() / checkbox change / drag-drop — on user interaction
             *
             * This function never re-derives state from any external source.
             * It only reads selectedOrder / unselectedKeys and updates the DOM.
             * ────────────────────────────────────────────────────────────────── */
            /* ══════════════════════════════════════════════════════════════════
             * _resetColValue(rowId, col)
             * ──────────────────────────────────────────────────────────────────
             * Resets the input/select/textarea inside a dynamic column cell to
             * its blank/default state when that column is deselected.
             * This ensures deselected columns never bleed stale values into the
             * save/submit payload.
             *
             * Reset rules per column:
             *   select dropdowns       → value = '0' (or '' for sow-available)
             *   date inputs            → value = ''  + re-apply disabled state
             *   textarea               → value = ''
             *   jd-attachment          → clear file input + stored path attributes
             *   nature-of-request      → read-only/UI-only, no reset needed
             * ══════════════════════════════════════════════════════════════════ */
            function _resetColValue(rowId, col) {
                switch (col) {
                    case 'department':
                        var elD = document.getElementById('cboDept_' + rowId);
                        if (elD) elD.value = '0';
                        break;
                    case 'resource-pool':
                        var elR = document.getElementById('cboResPool_' + rowId);
                        if (elR) elR.value = '0';
                        break;
                    case 'location':
                        var elL = document.getElementById('cboLoc_' + rowId);
                        if (elL) elL.value = '0';
                        break;
                    case 'engagement-model':
                        var elE = document.getElementById('cboEngModel_' + rowId);
                        if (elE) elE.value = '0';
                        break;
                    case 'priority':
                        var elP = document.getElementById('cboPriority_' + rowId);
                        if (elP) elP.value = '0';
                        break;
                    case 'billable-position':
                        var elBP = document.getElementById('cboBillPos_' + rowId);
                        if (elBP) elBP.value = '0';
                        /* Billing Start Date depends on Billable Position — disable it too */
                        if (typeof _applyBillingStartDateState === 'function') {
                            _applyBillingStartDateState(rowId, false);
                        }
                        break;
                    case 'billing-start-date':
                        var elBS = document.getElementById('RRBillingStart_' + rowId);
                        if (elBS) {
                            elBS.value = '';
                            elBS.setAttribute('disabled', 'disabled');
                            elBS.style.background = '#f3f4f6';
                            elBS.style.cursor = 'not-allowed';
                            var calBtn = elBS.closest && elBS.closest('.datefielddiv')
                                ? elBS.closest('.datefielddiv').querySelector('.btncalendar')
                                : null;
                            if (calBtn) {
                                calBtn.setAttribute('disabled', 'disabled');
                                calBtn.style.opacity = '0.5';
                                calBtn.style.cursor = 'not-allowed';
                            }
                        }
                        break;
                    case 'sow-available':
                        var elSOW = document.getElementById('cboSOWAvailable_' + rowId);
                        if (elSOW) elSOW.value = '';
                        /* Recompute Nature of Request — will go blank since SOW is now empty */
                        if (typeof computeNatureOfRequest === 'function') {
                            computeNatureOfRequest(rowId);
                        }
                        break;
                    case 'special-request':
                        var elSR = document.getElementById('txtSpecialReq_' + rowId);
                        if (elSR) elSR.value = '';
                        break;
                    case 'jd-attachment':
                        /* Clear the file input and all stored path references */
                        var fileEl = document.getElementById('fileJD_' + rowId);
                        if (fileEl) { fileEl.value = ''; fileEl.removeAttribute('data-jd-path'); }
                        var rowTr = document.querySelector('tr[data-row="' + rowId + '"]');
                        if (rowTr) { rowTr.removeAttribute('data-jd-path'); }
                        var spnName = document.getElementById('spnJDName_' + rowId);
                        if (spnName) spnName.innerHTML = '';
                        var spnMsg = document.getElementById('spnJDMsg_' + rowId);
                        if (spnMsg) spnMsg.style.display = 'none';
                        break;
                    /* nature-of-request: read-only/UI-only — value auto-clears when
                       sow-available is reset above; no independent reset needed. */
                }
            }

            function syncTableColumns() {
                var header = document.getElementById('tableHeader');
                var fullOrder = selectedOrder.concat(unselectedKeys);

                /* ── Reorder and show/hide header <th> elements ── */
                fullOrder.forEach(function (key) {
                    var th = header.querySelector('th.dyn-th[data-col="' + key + '"]');
                    if (th) header.appendChild(th);
                });
                header.querySelectorAll('th.dyn-th').forEach(function (th) {
                    th.style.display = selectedOrder.indexOf(th.getAttribute('data-col')) > -1
                        ? 'table-cell' : 'none';
                });
                renderDropdown();
                renderTagBar();
                /* ── Reorder, show/hide, and reset body <td> elements ── */
                document.querySelectorAll('#resourceTableBody tr.resource-row').forEach(function (tr) {
                    var rowId = parseInt(tr.getAttribute('data-row'));
                    fullOrder.forEach(function (key) {
                        var td = tr.querySelector('td.dyn-td[data-col="' + key + '"]');
                        if (td) tr.appendChild(td);
                    });
                    tr.querySelectorAll('td.dyn-td').forEach(function (td) {
                        var col = td.getAttribute('data-col');
                        var isSelected = selectedOrder.indexOf(col) > -1;
                        /* Track previous visibility so we only reset on transition visible→hidden */
                        var wasVisible = td.style.display !== 'none';

                        td.style.display = isSelected ? 'table-cell' : 'none';

                        /* ── Clear stale value when column transitions to hidden ──
                           Only fires on visible→hidden transition, NOT on initial page load
                           (where td starts as 'none' and remains 'none'). */
                        if (!isSelected && wasVisible) {
                            _resetColValue(rowId, col);
                        }

                        /* Re-render JD attachment cell ONLY when transitioning hidden -> visible
                           so the saved filename link appears correctly after a column toggle.
                           Previously this ran on every syncTableColumns call (including every
                           addRow), which repeatedly replaced the td.innerHTML and could destroy
                           the live fileJD_ input before validation read its data-jd-path.
                           Fixed by Nikhil Mane on 04-04-2026. */
                        if (col === 'jd-attachment' && isSelected && !wasVisible) {
                            var existingPath = tr.getAttribute('data-jd-path') || '';
                            if (existingPath) {
                                renderJDAttachmentCell(rowId, existingPath);
                            }
                        }
                    });
                });
            }
            /* End of Updated by Nikhil Mane on 01-04-2026 */

            var SVG = {
                save: '<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v14a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>',
                del:  '<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4h6v2"/></svg>'
            };

            function createRow() {
                _rowCount++;
                var id = _rowCount;
                var tr = document.createElement('tr');
                tr.className = 'resource-row';
                tr.setAttribute('data-row', id);

                var fixedHtml =
                    '<td><div class="actions-cell"><div class="icon-row">' +
                    (addAccess ? '<button type="button" class="icon-btn" style="cursor:pointer;" ' +
                        'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Save Row" ' +
                        'onclick="saveRow(' + id + ')">' + SVG.save + '</button>' : '') +
                    (deleteAccess ? '<button type="button" class="icon-btn danger" style="cursor:pointer;" ' +
                        'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Delete Row" ' +
                        'onclick="deleteRow(' + id + ')">' + SVG.del + '</button>' : '') +
                    '</div>' +
                    (addAccess ? '<button type="button" class="set-skill-link" style="cursor:pointer;" ' +
                        'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Set Skills for this row" ' +
                        'onclick="toggleSkill(' + id + ')">Set Skill</button>' : '') +
                    '</div></td>' +
                    '<td style="min-width:140px;">' + cloneSelect('tmpl-type-of-req', 'cboTypeOfReq_' + id) + '</td>' +
                    '<td style="min-width:130px;">' + cloneSelect('tmpl-project-role', 'cboProjectRole_' + id) + '</td>' +
                    // For No. of Resources — max 4 digits
                    '<td><input type="text" id="txtNoOfRes_' + id + '" class="form-control" value="0" maxlength="4" style="width:64px;" /></td>' +
                    '<td style="min-width:160px;white-space:nowrap;">' + dateField('RRstartdt_' + id) + '</td>' +
                    '<td style="min-width:160px;white-space:nowrap;">' + dateField('RRenddt_' + id) + '</td>' +
                    /* Added by Nikhil Mane on 31-03-2026 — Allocation Type (mandatory, before Allocation %) */
                    '<td style="min-width:120px;">' + cloneSelect('tmpl-allocation-type', 'cboAllocType_' + id) + '</td>' +
                    /* End of Added by Nikhil Mane on 31-03-2026 */
                    // For Allocation % — enabled only when Allocation Type = 'P' (% of day); max 3 digits
                    '<td><div class="allocation-wrapper">' +
                    '<input type="text" placeholder="0" id="txtAlloc_' + id + '" maxlength="3" disabled style="background:#f3f4f6;cursor:not-allowed;" />' +
                    '<span class="pct-label" id="lblAllocUnit_' + id + '">%</span></div></td>';

                tr.innerHTML = fixedHtml;

                /* ── Access guard: if user has no edit access, lock all inputs in this row ── */
                if (!addAccess) {
                    tr.querySelectorAll('input, select, textarea, button.btncalendar').forEach(function (el) {
                        el.setAttribute('disabled', 'disabled');
                        el.style.background  = '#f3f4f6';
                        el.style.cursor      = 'not-allowed';
                        el.style.pointerEvents = 'none';
                    });
                }

                var typeSelEl = tr.querySelector('#cboTypeOfReq_' + id);
                if (typeSelEl) {
                    typeSelEl.onchange = null;
                    typeSelEl.setAttribute('onchange', 'onTypeOfReqChange_row(' + id + ', this.value)');
                }

                /* Added by Nikhil Mane on 31-03-2026 — wire Allocation Type onchange */
                var allocTypeSelEl = tr.querySelector('#cboAllocType_' + id);
                if (allocTypeSelEl) {
                    allocTypeSelEl.onchange = null;
                    allocTypeSelEl.setAttribute('onchange', 'onAllocTypeChange_row(' + id + ', this.value)');
                }
                /* End of Added by Nikhil Mane on 31-03-2026 */

                /* onblur validations removed — validation runs on button click only */

                var dynDefs = [
                    { key: 'department',        tmpl: 'tmpl-department',        prefix: 'cboDept_' },
                    { key: 'resource-pool',      tmpl: 'tmpl-resource-pool',     prefix: 'cboResPool_' },
                    { key: 'location',           tmpl: 'tmpl-location',          prefix: 'cboLoc_' },
                    { key: 'engagement-model',   tmpl: 'tmpl-engagement-model',  prefix: 'cboEngModel_' },
                    { key: 'priority',           tmpl: 'tmpl-priority',          prefix: 'cboPriority_' },
                    { key: 'billable-position',  tmpl: 'tmpl-billable-position', prefix: 'cboBillPos_' },
                    { key: 'billing-start-date', tmpl: null,                     prefix: 'RRBillingStart_' },
                    { key: 'sow-available',      tmpl: null,                     prefix: 'cboSOWAvailable_' },
                    { key: 'jd-attachment',      tmpl: null,                     prefix: '' },
                    /* Added by Nikhil Mane on 31-03-2026 — Special Request optional column */
                    { key: 'special-request',    tmpl: null,                     prefix: 'txtSpecialReq_' }
                    /* End of Added by Nikhil Mane on 31-03-2026 */,
                    /* Nature of Request: UI-only readonly column. Auto-computed from SOW Available + Billing Start Date. */
                    { key: 'nature-of-request',  tmpl: null,                     prefix: 'txtNatureOfReq_' }
                ];

                dynDefs.forEach(function (d) {
                    var td = document.createElement('td');
                    td.className = 'dyn-td';
                    td.setAttribute('data-col', d.key);
                    if (d.key === 'billing-start-date') { 
                        td.style.minWidth = '160px'; 
                        td.style.whiteSpace = 'nowrap'; 
                        let dateHtml = dateField(d.prefix + id);
                        dateHtml = dateHtml.replace('<input', '<input onchange="onSOWAvailableChange_row(' + id + ')"');
                        td.innerHTML = dateHtml;
                    } else if (d.key === 'billable-position') {
                        td.style.minWidth = '110px';
                        td.innerHTML = cloneSelect(d.tmpl, d.prefix + id);
                        /* Wire onchange after the select is inside the TD fragment */
                        var _bpSel = td.querySelector('#' + d.prefix + id);
                        if (_bpSel) {
                            _bpSel.setAttribute('onchange', 'onBillablePosChange_row(' + id + ', this.value)');
                        }
                    } else if (d.key === 'sow-available') {
                        td.innerHTML = '<select id="' + d.prefix + id + '" name="' + d.prefix + id + '" class="form-control"' +
                            ' onchange="onSOWAvailableChange_row(' + id + ')">' +
                            '<option value="">Select</option><option value="Yes">Yes</option><option value="No">No</option></select>';
                    } else if (d.key === 'jd-attachment') {
                        /* Hidden file input placed truly off-screen — triggers via button.onclick.
                           This prevents the browser from reflowing / resizing the page on click. */
                        td.innerHTML =
                            '<div style="display:flex;flex-direction:column;gap:2px;">' +
                            '<input type="file" id="fileJD_' + id + '" class="jd-file-input-hidden"' +
                            ' accept=".pdf,.doc,.docx,.jpg,.jpeg,.png,.gif,.bmp,.webp"' +
                            ' onchange="validateJDAttachment(' + id + ', this)" />' +
                            '<button type="button" class="jd-upload-btn" id="btnJD_' + id + '"' +
                            ' onclick="document.getElementById(\'fileJD_' + id + '\').click()">' +
                            '<i class="fas fa-paperclip"></i> JD Attachments</button>' +
                            '<span class="jd-file-name" id="spnJDName_' + id + '"></span>' +
                            '<span id="spnJDMsg_' + id + '" style="font-size:10px;color:#ef4444;display:none;"></span>' +
                            '</div>';
                    /* Added by Nikhil Mane on 31-03-2026 — Special Request optional textarea */
                    } else if (d.key === 'special-request') {
                        td.style.minWidth = '160px';
                        td.innerHTML = '<textarea id="txtSpecialReq_' + id + '"' +
                            ' class="form-control" maxlength="300" rows="1"' +
                            ' placeholder="Max 300 chars"' +
                            ' style="min-width:140px;font-size:12px;height:30px;resize:vertical;padding:4px 8px;">' +
                            '</textarea>';
                    /* End of Added by Nikhil Mane on 31-03-2026 */
                    } else if (d.key === 'nature-of-request') {
                        /* Nature of Request — readonly, UI-only, not sent in payload.
                           Styled with a subtle background to indicate it is read-only.
                           Value and color are fully controlled by computeNatureOfRequest().
                           Do NOT set color/font-weight here — they start neutral (empty). */
                        td.style.minWidth = '130px';
                        td.innerHTML =
                            '<input type="text" id="txtNatureOfReq_' + id + '"' +
                            ' class="form-control" readonly placeholder=""' +
                            ' style="min-width:120px;background:#f9fafb;color:#6b7280;' +
                            'font-weight:400;cursor:default;border-color:#e5e7eb;" />';
                    } else {
                        td.style.minWidth = '110px';
                        td.innerHTML = cloneSelect(d.tmpl, d.prefix + id);
                    }
                    tr.appendChild(td);
                });

                var result = { row: tr, id: id };

                /* Initialize datepickers AFTER result is created */
                initDatepicker('RRstartdt_' + result.id);
                initDatepicker('RRenddt_' + result.id);
                initDatepicker('RRBillingStart_' + result.id);
                /* Recompute Nature of Request whenever Billing Start Date changes */
                (function (rId) {
                    $('#RRBillingStart_' + rId).on('change', function () {
                        computeNatureOfRequest(rId);
                    });
                }(result.id));

                /* Determine initial Billable Position state */
                var billPosEl = document.getElementById('cboBillPos_' + result.id);
                var isYes = false;
                if (billPosEl && billPosEl.value && billPosEl.value !== '0') {
                    var selText = billPosEl.options[billPosEl.selectedIndex]
                        ? (billPosEl.options[billPosEl.selectedIndex].text || '') : '';
                    isYes = (selText.toLowerCase().indexOf('yes') !== -1) ||
                        (parseInt(billPosEl.value) === 2) ||
                        (parseInt(billPosEl.value) === 1);
                }

                /* Apply Billing Start Date state - this will auto-set the date and set field state */
                _applyBillingStartDateState(result.id, isYes);

                return result;
            }

            /* ── Digit-only input helpers for No. of Resources and Allocation % ──
               blockNonDigit  : fires on keydown — prevents the character from
                                ever appearing in the field.
               handleDigitPaste: fires on paste — strips non-digits from pasted
                                text and clamps to max before inserting.
               filterPositiveInt: fires on oninput as a final safety net for any
                                input path not covered by the above (IME, autofill).
               No alertify is shown during typing — range errors fire on button click
               via validateRowFields. */

            function blockNonDigit(e) {
                /* Allow: Backspace, Delete, Tab, Escape, Enter */
                var controlKeys = [8, 9, 13, 27, 46];
                if (controlKeys.indexOf(e.keyCode) !== -1) return;
                /* Allow: Ctrl/Cmd+A, C, V, X */
                if ((e.ctrlKey || e.metaKey) && [65, 67, 86, 88].indexOf(e.keyCode) !== -1) return;
                /* Allow: Arrow keys, Home, End */
                if (e.keyCode >= 35 && e.keyCode <= 40) return;
                /* Allow: numeric 0-9 via main keyboard (48-57) */
                if (e.keyCode >= 48 && e.keyCode <= 57) return;
                /* Allow: numeric 0-9 via numpad (96-105) */
                if (e.keyCode >= 96 && e.keyCode <= 105) return;
                /* Block everything else — letter, symbol, decimal point, minus, space */
                e.preventDefault();
            }

            function handleDigitPaste(e, max) {
                e.preventDefault();
                var pasted = (e.clipboardData || window.clipboardData).getData('text');
                var digits = pasted.replace(/[^0-9]/g, '');
                if (!digits) return;
                var num = parseInt(digits, 10);
                if (isNaN(num) || num < 1) return;
                if (num > max) num = max;
                e.target.value = num;
            }

            function filterPositiveInt(input, max) {
                /* Final safety net — removes any non-digit that slipped through
                   (e.g. browser autofill, IME input) and clamps to max. */
                var raw = input.value.replace(/[^0-9]/g, '');
                if (raw === '') { input.value = ''; return; }
                var num = parseInt(raw, 10);
                if (isNaN(num) || num < 1) { input.value = ''; return; }
                if (num > max) num = max;
                input.value = num;
            }

            function createReplacementRow(rowId) {
                var tr = document.createElement('tr');
                tr.className = 'replacement-row';
                tr.id = 'replacement-row-' + rowId;
                /* Empty first cell — aligns with sticky Actions column; CSS makes it sticky */
                var tdEmpty = document.createElement('td');
                tdEmpty.style.cssText = 'padding:0;background:#fffbeb;border-bottom:1px solid #fde68a;';
                tr.appendChild(tdEmpty);
                var td = document.createElement('td');
                td.className = 'replacement-row-cell';
                td.colSpan = 29;
                td.innerHTML =
                    '<div class="replacement-row-inner">' +
                    '<span class="rep-label">' + RES.C_ReplacementEmployeeName + ' <span style="color:red;font-weight:700;">*</span></span>' +
                    '<div class="rep-select-wrap" style="display:flex; align-items:center; gap:10px;">' +
                    '<select id="cboRepResource_' + rowId + '" name="cboRepResource_' + rowId + '" class="form-control" style="min-width:220px;">' +
                    '</select>' +
                    '<span class="rep-note">' + RES.C_ReplacementNote + '</span>' +
                    '</div>' +
                    '</div>';
                tr.appendChild(td);
                return tr;
            }

            function createSkillSection(rowId) {
                var tr = document.createElement('tr');
                tr.className = 'skill-section-row';
                tr.id = 'skill-section-' + rowId;
                /* Empty first cell — aligns with sticky Actions column; CSS makes it sticky */
                var tdSkillEmpty = document.createElement('td');
                tdSkillEmpty.style.cssText = 'padding:0;background:#f8faff;border-bottom:2px solid #dbeafe;';
                tr.appendChild(tdSkillEmpty);
                var td = document.createElement('td');
                td.className = 'skill-section-cell';
                td.colSpan = 29;
                /* Added by Nikhil Mane on 01-01-2026 — skill-note visibility driven by IsRequestResourceSkillMandatory */
                var skillNoteDisplay = (IsRequestResourceSkillMandatory == 1) ? 'none' : 'block';
                td.innerHTML =
                    '<div class="skill-section-inner">' +
                    '<div class="skill-section-header">' +
                    '<button type="button" class="skill-section-close" onclick="toggleSkill(' + rowId + ')" ' +
                        'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Close Skill Panel">&#x2715;</button>' +
                    '<span class="skill-dot"></span>' +
                    '<span>Skill Set &nbsp;<small style="font-weight:400;color:#6b7280;">(Skills Section for Row ' + rowId + ')</small></span></div>' +
                    /* skill-note: shown when skill is not mandatory — mirrors #skillnote in PM_Resource_Selection.aspx */
                    '<ul class="skill-note" id="skill-note-' + rowId + '" style="display:' + skillNoteDisplay + ';margin-bottom:8px;padding-left:18px;">' +
                    '<li><span style="font-size:12px;color:#6b7280;">Note: As per configuration, skill is not mandatory for raising resource request.</span></li></ul>' +
                    /* End of Added by Nikhil Mane on 01-01-2026 */
                    '<table class="skills-table table table-bordered"><thead><tr>' +
                    '<th width="30%">'+RES.C_Skills+'</th><th width="30%">'+RES.C_Experience+'</th>' +
                    '<th width="20%">'+RES.C_Proficiency+'</th><th width="10%">'+RES.C_CoreCompetency+'</th><th>&nbsp;</th>' +
                    '</tr></thead>' +
                    '<tbody id="skill-tbody-' + rowId + '"></tbody>' +
                    '<tfoot><tr><td colspan="5">' +
                    (addAccess ? '<button type="button" class="btn-add-skill" id="addskillsetrow-' + rowId + '" onclick="addSkillRow(' + rowId + ')" ' +
                        'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="'+RES.C_AddSkillSet+'">'+RES.C_AddSkillSet+'</button>' : '') +
                    '</td></tr></tfoot></table></div>';
                tr.appendChild(td);
                return tr;
            }

            var _globalSkillCounter = 0;
            var skillCounters = {};

            function nextSkillCounter(rowId) {
                var c = _globalSkillCounter++;
                if (!skillCounters[rowId]) skillCounters[rowId] = [];
                skillCounters[rowId].push(c);
                return c;
            }

            function skillTmpl(tmplId, counter) {
                var el = document.getElementById(tmplId);
                if (!el) return '';
                return el.innerHTML.replace(/Name/g, counter);
            }
            function setSkillExperiencePlaceholders(counter) {
                /* Keep server-bound option sets from DrawComboBox.
                   Only normalize the default placeholder captions. */
                var yearEl = document.getElementById('cboMonth' + counter);
                var monthEl = document.getElementById('cboYear' + counter);
                if (yearEl && yearEl.options && yearEl.options.length > 0 && yearEl.options[0].value === '0') {
                    yearEl.options[0].text = 'Select Year';
                }
                if (monthEl && monthEl.options && monthEl.options.length > 0 && monthEl.options[0].value === '0') {
                    monthEl.options[0].text = 'Select Month';
                }
            }

            window.addSkillRow = function (rowId) {
                
                /* ── Access guard (bypass during draft restore) ── */
                if (!addAccess && !window._loadDraftInProgress) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('You do not have permission to add skills.');
                    return;
                }
                var tbody = document.getElementById('skill-tbody-' + rowId);
                if (!tbody) return;
                /* Added by Nikhil Mane on 01-01-2026 — enforce Count_Request_ResourceSkill limit.
                   Bypass during draft restore (_loadDraftInProgress) so saved skills are always
                   reloaded without hitting the cap — same pattern as the access guard above.
                   Use >= so the limit is exactly enforced (not limit+1).
                   Fixed by Nikhil Mane on 04-04-2026. */
                var maxSkills = parseInt(Count_Request_ResourceSkill) || 0;
                if (maxSkills > 0 && !window._loadDraftInProgress && tbody.querySelectorAll('tr').length >= maxSkills) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Maximum ' + maxSkills + ' skills are allowed to add.');
                    return;
                }
                /* End of Added by Nikhil Mane on 01-01-2026 */

                /* ── Validate existing skill rows before adding another (test #30 / #32):
                   Do not allow a second skill row if the first skill dropdown is still blank. */
                var existingSkillRows = tbody.querySelectorAll('tr');
                var hasBlankExisting = false;
                existingSkillRows.forEach(function (skillTr) {
                    var parts   = skillTr.id.split('_');
                    var counter = parts[parts.length - 1];
                    var skillSel = document.getElementById('cboSkillMaster' + counter);
                    if (!skillSel || !skillSel.value || skillSel.value === '0' || skillSel.value === '') {
                        hasBlankExisting = true;
                        if (skillSel) skillSel.classList.add('val-error');
                    }
                });
                if (hasBlankExisting) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Please complete the configuration of skill(s) for Row No. ' + _getRowDisplayNum(rowId) + '.');
                    return;
                }
                var counter = nextSkillCounter(rowId);
                var skillHtml = skillTmpl('tmpl-skill-master', counter);
                var monthHtml = skillTmpl('tmpl-skill-month', counter);
                var yearHtml  = skillTmpl('tmpl-skill-year', counter);
                var profHtml  = skillTmpl('tmpl-skill-proficiency', counter);
                var tr = document.createElement('tr');
                tr.id = 'R_' + rowId + '_' + counter;
                var cols =
                    '<td>' + skillHtml + '</td>' +
                    '<td class="exprience">' +
                    monthHtml + '<span class="exp-unit">Years</span>' +
                    '<span class="exp-sep">&amp;</span>' +
                    yearHtml + '<span class="exp-unit">Months</span>' +
                    '</td>' +
                    '<td>' + profHtml + '</td>' +
                    '<td style="text-align:center;"><input type="checkbox" id="CheckCoreCompantency_' + rowId + '_' + counter + '" name="CheckCoreCompantency_' + rowId + '_' + counter + '" class="clsMandatoryFields chk-core" onclick="validateCoreCompantency(this.id)"' + (addAccess ? '' : ' disabled') + '></td>' +
                    /* Updated by Nikhil Mane on 04-04-2026 — Delete Skill button: deleteAccess (not addAccess) */
                    ((addAccess || deleteAccess) ? '<td><button class="ibtnDel nostylebtn" type="button" onclick="deleteSkillRow_row(this,' + rowId + ')" ' +
                        'data-bs-toggle="tooltip" data-bs-custom-class="black-tooltip" data-bs-placement="top" title="Delete Skill"><i class="far fa-trash-alt"></i></button></td>' : '<td></td>');
                tr.innerHTML = cols;
                tbody.appendChild(tr);
                /* Clear val-error on this skill row's select as soon as user picks a value */
                var newSkillSel = tr.querySelector('[id^="cboSkillMaster"]');
                if (newSkillSel) {
                    newSkillSel.addEventListener('change', function () {
                        if (this.value && this.value !== '0') this.classList.remove('val-error');
                    });
                }
                GetRequestSkillCombo_row(rowId, counter);
                setSkillExperiencePlaceholders(counter);
                $('select option').removeAttr('title');
                /* ── Select2: initialise searchable dropdowns on the new skill row ──
                   Added by Nikhil Mane on 04-04-2026 */
                initRowSelect2(tr);
                /* ── Focus: open Skill Name dropdown immediately so the user can search/select
                   the skill right after clicking Add Skill Set.
                   GetRequestSkillCombo_row is async:false so options are already populated here.
                   Added by Nikhil Mane on 04-04-2026 */
                if (!window._loadDraftInProgress) {
                    var _skillNameEl = document.getElementById('cboSkillMaster' + counter);
                    _focusSelect2(_skillNameEl);
                }
                /* End of Added by Nikhil Mane on 04-04-2026 */
                reinitTooltips && reinitTooltips();
            };

            window.deleteSkillRow_row = function (btn, rowId) {
                /* ── Access guard — Updated by Nikhil Mane on 04-04-2026: deleteAccess required ── */
                if (!deleteAccess) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('You do not have permission to delete skills.');
                    return;
                }
                /* Hide & dispose the tooltip on the clicked button before the row is removed
                   so the tooltip bubble doesn't stay visible after the element leaves the DOM.
                   Updated by Nikhil Mane */
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var tipInstance = bootstrap.Tooltip.getInstance(btn);
                    if (tipInstance) { tipInstance.hide(); tipInstance.dispose(); }
                }
                var row = btn.closest('tr');
                if (!row) return;
                var dbSkillId = parseInt(row.getAttribute('data-skill-db-id') || '0');
                if (dbSkillId > 0) {
                    var param = JSON.stringify({ SkillRequestID: dbSkillId, UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0 });
                    $.ajax({ url: strUrl + '/api/PM_BulkResourceReq/DeleteSkill', type: 'POST', data: param, async: true,
                             dataType: 'json', contentType: 'application/json;charset=utf-8',
                             beforeSend: function (xhr) { buildAuthHeaders(xhr, param); } });
                }
                row.remove();
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('Skill deleted successfully.');
            };

            window.toggleSkill = function (rowId) {
                var sec = document.getElementById('skill-section-' + rowId);
                if (sec) sec.classList.toggle('open');
            };

            window.validateCoreCompantency = function (id) { /* reserved for business logic */ };

            function _markCoreCompetencyGroup(rowId, isError) {
                var tbody = document.getElementById('skill-tbody-' + rowId);
                if (!tbody) return;
                tbody.querySelectorAll('tr').forEach(function (skillTr) {
                    var coreCell = skillTr.querySelector('td:nth-child(4)');
                    if (!coreCell) return;
                    if (isError) coreCell.classList.add('core-val-error');
                    else coreCell.classList.remove('core-val-error');
                });
            }

            function _markJDError(rowId, isError) {
                var jdBtn = document.getElementById('btnJD_' + rowId);
                var jdInput = document.getElementById('fileJD_' + rowId);
                if (jdBtn) {
                    if (isError) jdBtn.classList.add('val-error');
                    else jdBtn.classList.remove('val-error');
                }
                if (jdInput) _markError(jdInput, isError);
            }
            /**
             * Sets Authorization and optional encrypted Params header.
             *
             * IMPORTANT — call convention:
             *
             *   buildAuthHeaders(xhr)
             *     — Authorization header only. No Params header sent.
             *     — Use for endpoints that do NOT have [ValidateHeadersAttribute]:
             *         SaveDraft, Submit, SaveRow,
             *         GetResourceRequestConfiguration, CheckResourcePoolMandatory,
             *         GetColumnMaster, GetresourceHrs.
             *
             *   buildAuthHeaders(xhr, param)
             *     — Authorization + full encrypted Params header.
             *     — Use for endpoints that DO have [ValidateHeadersAttribute]:
             *         GetProjectDetails, GetRequestSkillCombo, GetColumnPreference,
             *         SaveColumnPreference, DeleteRow, DeleteSkill,
             *         GetActiveResources, GetByUserProject, GetEmailPreview,
             *         SendEmail, GetProjectBalHrs, GetLocationWorkingHours.
             *
             *   buildAuthHeaders(xhr, param, 'minimal')
             *     — Authorization + minimal Params header
             *       (BulkRequestID / ProjectID / UserID only;
             *        avoids IIS "request headers too long" for large payloads).
             *
             * Updated by Nikhil Mane on 04-04-2026
             */
            function buildAuthHeaders(xhr, param, auditMode) {
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem('access_token_W26API'));
                if (!param || typeof encryptString !== 'function' || typeof isJson !== 'function')
                    return;
                var toEncrypt;
                if (auditMode === 'minimal') {
                    try {
                        var o = typeof param === 'string' ? JSON.parse(param) : param;
                        toEncrypt = JSON.stringify({
                            BulkRequestID: o.BulkRequestID != null ? o.BulkRequestID : 0,
                            ProjectID: o.ProjectID != null ? o.ProjectID : 0,
                            UserID: o.UserID != null ? o.UserID : 0
                        });
                    } catch (e) {
                        return;
                    }
                } else {
                    toEncrypt = isJson(param) ? param : JSON.stringify(param);
                }
                //xhr.setRequestHeader('Params', encryptString(toEncrypt));
            }

            var SessionProjectID = <%= Session("intProjectID") %>;
            var SessionUserID    = <%= Session("intUserID")    %>;
            var viewAccess       = <%= m_blnViewAccess.ToString().ToLower() %>;
            var addAccess        = <%= m_blnAddAccess.ToString().ToLower() %>;
            var editAccess       = <%= m_blnEditAccess.ToString().ToLower() %>;
            var deleteAccess     = <%= m_blnDeleteAccess.ToString().ToLower() %>;

            /* ── Resource Request Configuration (Sonata) ───────────────────────
             * Loaded once on page init via GetResourceRequestConfiguration API.
             * Mirrors the Protected variables injected by GetResourceRequestConfiguration()
             * in PM_Resource_Selection.aspx.vb.
             * Note: IsResourceRequestsplittingbased is not used on this page.
             * Added by Nikhil Mane on 01-01-2026
             * ─────────────────────────────────────────────────────────────────── */
            var Count_Request_ResourceSkill           = 0;
            var IsRequestResourceSkillMandatory        = 0;
            var IsResourceSkillCoreCompetencyMandatory = 0;
            var IsResourceRequestNewFieldsManatory     = 0;
            // Added by Nikhil Mane on 01-01-2026 — splitting-based flag integrated.
            // When true, Submit expands each bulk row into NoOfResources individual
            // ResourceRequests (each with NoOfResources = 1).
            var IsResourceRequestSplittingBased        = false;
            // Added by Nikhil Mane on 30-03-2026 — row limit config.
            // 0 = no limit; N = max rows allowed per bulk submit.
            // Mirrors Count_Request_ResourceSkill but applies to rows instead of skills.
            var Count_BulkRequest_Rows                 = 0;
            // Added by Nikhil Mane on 02-04-2026 — Resource Pool Mandatory setting.
            // Populated by loadResourcePoolMandatory() from the CheckResourcePoolMandatory API.
            // When 1, the Resource Pool column is treated as mandatory:
            //   • auto-selected in the tag bar on first visit (no saved prefs)
            //   • forced back into selectedOrder even when restoring saved prefs
            //   • checkbox is disabled in the column picker (greyed out)
            //   • ✕ remove button is non-functional in the tag bar
            var IsResourcePoolMandatory = 0;
            // End of Added by Nikhil Mane on 02-04-2026
            var _configLoaded = false;
            /* End of Added by Nikhil Mane on 01-01-2026 */

            /* ── Localised string resources ───────────────────────────────── */
            var RES = {
                A_AuthenticationFailed        : '<%=MyBase.GetResourceString("A_AuthenticationFailed")%>',
                /* success */
                S_DraftSaved                  : '<%=MyBase.GetResourceString("S_DraftSaved")%>',
                S_SubmittedSuccessfully        : '<%=MyBase.GetResourceString("S_SubmittedSuccessfully")%>',
                S_EmailSent                   : '<%=MyBase.GetResourceString("S_EmailSent")%>',
                /* confirm */
                C_ConfirmSubmit               : '<%=MyBase.GetResourceString("C_ConfirmSubmit")%>',
                /* warnings */
                W_EmailNoToAddress            : '<%=MyBase.GetResourceString("W_EmailNoToAddress")%>',
                W_EmailCannotSend             : '<%=MyBase.GetResourceString("W_EmailCannotSend")%>',
                W_MoreValidationIssues        : '<%=MyBase.GetResourceString("W_MoreValidationIssues")%>',
                /* general AJAX errors */
                E_ErrorSavingDraft            : '<%=MyBase.GetResourceString("E_ErrorSavingDraft")%>',
                E_ErrorSubmitting             : '<%=MyBase.GetResourceString("E_ErrorSubmitting")%>',
                E_ErrorSavingRow              : '<%=MyBase.GetResourceString("E_ErrorSavingRow")%>',
                E_ErrorLoadingDetails         : '<%=MyBase.GetResourceString("E_ErrorLoadingDetails")%>',
                /* row validation */
                E_NoOfResourcesRange          : '<%=MyBase.GetResourceString("E_NoOfResourcesRange")%>',
                E_AllocationBlank             : '<%=MyBase.GetResourceString("E_AllocationBlank")%>',
                E_AllocationZero              : '<%=MyBase.GetResourceString("E_AllocationZero")%>',
                E_AllocationMax               : '<%=MyBase.GetResourceString("E_AllocationMax")%>',
                E_ProjectRoleBlank            : '<%=MyBase.GetResourceString("E_ProjectRoleBlank")%>',
                E_TypeOfRequirementBlank      : '<%=MyBase.GetResourceString("E_TypeOfRequirementBlank")%>',
                E_PlannedStartDateBlank       : '<%=MyBase.GetResourceString("E_PlannedStartDateBlank")%>',
                E_PlannedStartDateInvalid     : '<%=MyBase.GetResourceString("E_PlannedStartDateInvalid")%>',
                E_PlannedStartDateBeforeProjectStart : '<%=MyBase.GetResourceString("E_PlannedStartDateBeforeProjectStart")%>',
                E_PlannedStartDateAfterProjectEnd    : '<%=MyBase.GetResourceString("E_PlannedStartDateAfterProjectEnd")%>',
                E_PlannedStartDateAfterEndDate       : '<%=MyBase.GetResourceString("E_PlannedStartDateAfterEndDate")%>',
                E_PlannedDatesBetweenProject  : '<%=MyBase.GetResourceString("E_PlannedDatesBetweenProject")%>',
                E_PlannedEndDateBlank         : '<%=MyBase.GetResourceString("E_PlannedEndDateBlank")%>',
                E_PlannedEndDateInvalid       : '<%=MyBase.GetResourceString("E_PlannedEndDateInvalid")%>',
                E_PlannedEndDateAfterProjectEnd      : '<%=MyBase.GetResourceString("E_PlannedEndDateAfterProjectEnd")%>',
                E_PlannedEndDateBeforeProjectStart   : '<%=MyBase.GetResourceString("E_PlannedEndDateBeforeProjectStart")%>',
                E_PlannedEndDateBeforeStartDate      : '<%=MyBase.GetResourceString("E_PlannedEndDateBeforeStartDate")%>',
                E_BillingStartDateInvalid     : '<%=MyBase.GetResourceString("E_BillingStartDateInvalid")%>',
                E_BillingStartDateBeforeFromDate     : '<%=MyBase.GetResourceString("E_BillingStartDateBeforeFromDate")%>',
                E_BillingStartDateAfterProjectEnd    : '<%=MyBase.GetResourceString("E_BillingStartDateAfterProjectEnd")%>',
                E_SkillRequired:                        'Please Select at least one Skill.',
                E_SkillNameRequired:                    'Please select a Skill Name.',
                /* JD attachment */
                E_JDSpecialCharHash           : '<%=MyBase.GetResourceString("E_JDSpecialCharHash")%>',
                E_JDSingleQuote               : '<%=MyBase.GetResourceString("E_JDSingleQuote")%>',
                E_JDMultipleExtensions        : '<%=MyBase.GetResourceString("E_JDMultipleExtensions")%>',
                E_JDFileNameTooLong           : '<%=MyBase.GetResourceString("E_JDFileNameTooLong")%>',
                E_JDInvalidExtension          : '<%=MyBase.GetResourceString("E_JDInvalidExtension")%>',
                E_JDFileSizeTooSmall          : '<%=MyBase.GetResourceString("E_JDFileSizeTooSmall")%>',
                /* skill section (JS-built HTML) */
                C_SetSkill                    : '<%=MyBase.GetResourceString("C_SetSkill")%>',
                C_Skills                      : '<%=MyBase.GetResourceString("C_Skills")%>',
                C_Experience                  : '<%=MyBase.GetResourceString("C_Experience")%>',
                C_Proficiency                 : '<%=MyBase.GetResourceString("C_Proficiency")%>',
                C_CoreCompetency              : '<%=MyBase.GetResourceString("C_CoreCompetency")%>',
                C_AddSkillSet                 : '<%=MyBase.GetResourceString("C_AddSkillSet")%>',
                C_ReplacementEmployeeName     : '<%=MyBase.GetResourceString("C_ReplacementEmployeeName")%>',
                C_ReplacementNote             : '<%=MyBase.GetResourceString("C_ReplacementNote")%>',
                /* Send Email button (JS-updated after send) */
                C_SendEmail: '<%=MyBase.GetResourceString("C_SendEmail")%>',
                /* Added by Nikhil Mane on 03-04-2026 — AllocationType server-side limit messages */
                E_AllocTH_ExceedsProjectBal  : 'Total Work Hours cannot exceed the project balance hours',
                E_AllocHPD_ExceedsCompanyHrs : 'Work hours per day cannot be greater than the company work hours',
                E_AllocP_ExceedsMaxPct       : 'Allocation Unit cannot be greater than the configured maximum',
                E_AllocAPI_Failed            : 'Could not validate allocation limits. Please try again.'
                /* End of Added by Nikhil Mane on 03-04-2026 */
            };

            /* ══════════════════════════════════════════════════════════════════
             * loadResourceRequestConfig()
             * ──────────────────────────────────────────────────────────────────
             * Calls usp_Whizible2_Tbl_Whizible_ResourceRequestConfiguration via
             * the new GetResourceRequestConfiguration API endpoint and populates
             * all five module-level config variables.
             * Once loaded, calls onComplete() so the caller can continue init.
             *
             * Mirrors GetResourceRequestConfiguration() in PM_Resource_Selection.aspx.vb.
             * Updated by Nikhil Mane on 01-01-2026 — IsResourceRequestSplittingBased integrated.
             *
             * Added by Nikhil Mane on 01-01-2026
             * ══════════════════════════════════════════════════════════════════ */
            function loadResourceRequestConfig(onComplete) {
                var param = JSON.stringify({});
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetResourceRequestConfiguration',
                    type: 'POST', data: param, async: false,
                    dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr); },
                    success: function (response) {
                        var cfg = null;
                        if (response && response.data && response.data.data && response.data.data.length > 0) {
                            cfg = response.data.data[0];
                        } else if (response && response.data && response.data.length > 0) {
                            cfg = response.data[0];
                        }
                        if (cfg) {
                            Count_Request_ResourceSkill = parseInt(cfg.count_Request_ResourceSkill) || 0;
                            IsRequestResourceSkillMandatory = cfg.isRequestResourceSkillMandatory;
                            IsResourceSkillCoreCompetencyMandatory = cfg.isResourceSkillCoreCompetencyMandatory;
                            IsResourceRequestNewFieldsManatory = cfg.isResourceRequestNewFieldsManatory;
                            // Updated by Nikhil Mane on 01-01-2026 — populate splitting flag.
                            // SP returns isResourceRequestsplittingbased (camelCase, lowercase 's').
                            IsResourceRequestSplittingBased = !!(cfg.isResourceRequestSplittingBased || cfg.isResourceRequestsplittingbased);
                            // Added by Nikhil Mane on 30-03-2026 — row limit config.
                            Count_BulkRequest_Rows = parseInt(cfg.count_BulkRequest_Rows || cfg.Count_BulkRequest_Rows) || 0;
                        }
                        _configLoaded = true;
                        applyConfigToUI();
                    },
                    error: function () {
                        /* Non-fatal: defaults (0/false) already set — page works without config */
                        _configLoaded = true;
                    },
                    complete: function () {
                        if (typeof onComplete === 'function') onComplete();
                    }
                });
            }
            /* End of Added by Nikhil Mane on 01-01-2026 */

            /* ══════════════════════════════════════════════════════════════════
             * loadResourcePoolMandatory(onComplete)
             * ──────────────────────────────────────────────────────────────────
             * Calls the CheckResourcePoolMandatory API to read the
             * RESOURCEPOOLMANDATORY entry from tbl_SEM_Settings.
             * Populates the module-level IsResourcePoolMandatory flag.
             *
             * When IsResourcePoolMandatory = 1 the Resource Pool column becomes
             * mandatory across the page:
             *   • auto-selected in the tag bar on first visit (no saved prefs)
             *   • forced back into selectedOrder when restoring saved prefs
             *   • checkbox is greyed/disabled in the column picker
             *   • ✕ pill button is non-interactive in the tag bar
             *
             * Called as step 1b in the DOMContentLoaded init chain, between
             * loadResourceRequestConfig and loadColumnMaster, so the flag is
             * available when loadColumnPreference applies defaults.
             *
             * Non-fatal: if the API call fails, IsResourcePoolMandatory stays 0
             * and the column behaves as optional (safe default).
             *
             * Added by Nikhil Mane on 02-04-2026
             * ══════════════════════════════════════════════════════════════════ */
            // Added by Nikhil Mane on 02-04-2026
            function loadResourcePoolMandatory(onComplete) {
                var param = JSON.stringify({});
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/CheckResourcePoolMandatory',
                    type: 'POST',
                    data: param,
                    async: false,
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr); },
                    success: function (response) {
                        var row = null;
                        if (response && response.data && response.data.data && response.data.data.length > 0) {
                            row = response.data.data[0];
                        } else if (response && response.data && response.data.length > 0) {
                            row = response.data[0];
                        }
                        if (row) {
                            IsResourcePoolMandatory = parseInt(row.settingValue || row.SettingValue) || 0;
                        }
                    },
                    error: function () {
                        /* Non-fatal — IsResourcePoolMandatory stays 0; resource pool stays optional */
                    },
                    complete: function () {
                        if (typeof onComplete === 'function') onComplete();
                    }
                });
            }
            // End of Added by Nikhil Mane on 02-04-2026
             /* ──────────────────────────────────────────────────────────────────
             * Applies the loaded config flags to the page UI:
             *   - Shows/hides required (*) markers on field labels
             *   - Shows/hides the "skill is not mandatory" note
             *   - Updates Add Skill Set button labels with max count
             *
             * Called once after loadResourceRequestConfig() resolves and again
             * after each addRow() so new rows inherit the correct state.
             *
             * Added by Nikhil Mane on 01-01-2026
             * ══════════════════════════════════════════════════════════════════ */
            function applyConfigToUI() {
                if (!_configLoaded) return;

                /* ── IsResourceRequestNewFieldsManatory ─────────────────────────
                 * When True  (1): labels carry the "required" CSS class and the
                 *                 asterisk spans are shown.
                 * When False (0): "required" class is removed and spans are hidden.
                 * Mirrors the on-load block in PM_Resource_Selection.aspx lines 1158–1169.
                 * ─────────────────────────────────────────────────────────────── */
                var newFieldsMandatory = (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory === true);

                document.querySelectorAll('#resourceTableBody tr.resource-row').forEach(function (tr) {
                    var rowId = parseInt(tr.getAttribute('data-row'));
                    _applyNewFieldsMandatoryToRow(rowId, newFieldsMandatory);
                });

                /* ── IsRequestResourceSkillMandatory ────────────────────────────
                 * Show/hide the "skill not mandatory" note for all open skill panels.
                 * ─────────────────────────────────────────────────────────────── */
                document.querySelectorAll('.skill-note').forEach(function (el) {
                    el.style.display = (IsRequestResourceSkillMandatory == 1) ? 'none' : 'block';
                });

                /* ── Count_Request_ResourceSkill ────────────────────────────────
                 * Update the Add Skill Set button tooltip with the max count.
                 * ─────────────────────────────────────────────────────────────── */
                if (Count_Request_ResourceSkill > 0) {
                    document.querySelectorAll('.btn-add-skill').forEach(function (btn) {
                        btn.setAttribute('title', RES.C_AddSkillSet + ' (Max: ' + Count_Request_ResourceSkill + ')');
                    });
                }

                // Added by Nikhil Mane on 30-03-2026 — enforce row limit on Add More button.
                // Called here so button state is updated whenever config is (re-)applied
                // (e.g. page load and after loadDraft restores rows).
                updateAddMoreButtonState();

                /* ── Row-limit note in the Note bar ────────────────────────────
                   When Count_BulkRequest_Rows > 0 → show the limit.
                   When 0 (no limit) → show "There is no limit" message.
                   Added by Nikhil Mane */
                var noteHintEl = document.getElementById('noteHintRowLimit');
                if (noteHintEl) {
                    /* Use a separate text node so the bullet <span> inside the <li> is preserved */
                    var noteHintText = noteHintEl.querySelector('.note-hint-text');
                    if (!noteHintText) {
                        noteHintText = document.createElement('span');
                        noteHintText.className = 'note-hint-text';
                        noteHintEl.appendChild(noteHintText);
                    }
                    if (Count_BulkRequest_Rows > 0) {
                        noteHintText.textContent = 'Maximum ' + Count_BulkRequest_Rows + ' resource request(s) can be created at a time.';
                    } else {
                        noteHintText.textContent = 'Maximum resource request count is not set.';
                    }
                    noteHintEl.style.display = '';
                }
            }
            /* End of Added by Nikhil Mane on 01-01-2026 */

            /* ══════════════════════════════════════════════════════════════════
             * updateAddMoreButtonState()
             * ──────────────────────────────────────────────────────────────────
             * Enables or disables the "Add More" button based on Count_BulkRequest_Rows.
             * Rules:
             *   - Count_BulkRequest_Rows = 0  → no limit, button always enabled.
             *   - Current row count < limit   → button enabled.
             *   - Current row count >= limit  → button disabled with tooltip showing limit.
             *
             * Called from:
             *   • applyConfigToUI()   — on page load / after config resolves
             *   • addRow()            — after a row is successfully appended
             *   • deleteRow()         — after a row is removed
             *   • loadDraft callback  — after rows are restored from a saved draft
             *
             * Added by Nikhil Mane on 30-03-2026
             * ══════════════════════════════════════════════════════════════════ */
            function updateAddMoreButtonState() {
                var btn = document.querySelector('.btn-add-more');
                if (!btn) return;
                var currentRows = document.querySelectorAll('#resourceTableBody tr.resource-row').length;

                if (!Count_BulkRequest_Rows || Count_BulkRequest_Rows <= 0) {
                    var labelText = ' Add More' + (currentRows > 0 ? ' (' + currentRows + ')' : '');
                    /* No limit configured — ensure button is always enabled */
                    btn.disabled = false;
                    btn.classList.remove('disabled');
                    btn.style.opacity = '';
                    btn.style.cursor  = '';
                    btn.setAttribute('title', '<%=MyBase.GetResourceString("C_AddMore")%>');
                } else if (currentRows >= Count_BulkRequest_Rows) {
                    var labelText = ' Add More' + (currentRows > 0 ? ' (' + currentRows + ' / ' + Count_BulkRequest_Rows + ')' : '');
                    btn.disabled = true;
                    btn.classList.add('disabled');
                    btn.style.opacity = '0.5';
                    btn.style.cursor = 'not-allowed';
                    btn.setAttribute('title', 'Current Row / Total Row Limit');
                }
                else {
                    /* Fixed by Nikhil Mane on 04-04-2026 — button was never re-enabled
                       after a row was deleted that brought the count back below the limit.
                       The disabled state set in the >= branch was left intact because this
                       else branch only updated the label but never cleared disabled/opacity/cursor. */
                    var labelText = ' Add More' + (currentRows > 0 ? ' (' + currentRows + ' / ' + Count_BulkRequest_Rows + ')' : '');
                    btn.disabled = false;
                    btn.classList.remove('disabled');
                    btn.style.opacity = '';
                    btn.style.cursor = '';
                    btn.setAttribute('title', 'Current Row / Total Row Limit');
                }

                /* Re-init the tooltip so Bootstrap picks up the new title text.
                   Bootstrap 5 caches the title in data-bs-original-title on first init.
                   If we don't remove it before creating a new instance, Bootstrap reads
                   the stale cached value and the tooltip never reflects the updated title. */

                /* Always update the visible button label with current row count */
                var plusSpan = btn.querySelector('.plus');
                /* Rebuild inner content preserving the plus span */
                btn.innerHTML = '<span class="plus">+</span>' + labelText;
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var existing = bootstrap.Tooltip.getInstance(btn);
                    if (existing) { existing.hide(); existing.dispose(); }
                    btn.removeAttribute('data-bs-original-title');
                    new bootstrap.Tooltip(btn, { trigger: 'hover focus', html: false });
                }
            }
            /* End of Added by Nikhil Mane on 30-03-2026 */

            /* ══════════════════════════════════════════════════════════════════
             * _applyNewFieldsMandatoryToRow(rowId, isMandatory)
             * ──────────────────────────────────────────────────────────────────
             * Applies IsResourceRequestNewFieldsManatory to a single row:
             *   isMandatory=true  → adds "required" class to labels, shows * spans
             *   isMandatory=false → removes "required" class, hides * spans
             *
             * Field mapping mirrors PM_Resource_Selection.aspx:
             *   #lblTypeOfReq          → TypeOfRequirement combo label
             *   #lbldepartment         → Department combo label
             *   #lbllocation           → Location combo label
             *   #lblEngagementModel    → Engagement Model combo label
             *   #lblBillablePosition   → Billable Position combo label
             *   #lblSOWAv              → SOW Available combo label
             *   #lblJDattachment       → JD Attachment label
             *   #spncboRRProjectRepEmployeeName → Replacement Employee * span
             *   #spnRRillingStartDate  → Billing Start Date * span
             *
             * Added by Nikhil Mane on 01-01-2026
             * ══════════════════════════════════════════════════════════════════ */
            // Add this after your ALL_COLS declaration
            var MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY = [
                'department',
                'location',
                'engagement-model',
                'billable-position',
                'billing-start-date',
                'sow-available',
                'jd-attachment'
            ];

            /* ══════════════════════════════════════════════════════════════════
             * _isColMandatory(key)
             * ──────────────────────────────────────────────────────────────────
             * Centralised mandatory-column check.
             * Returns true when a column must be forced-selected and cannot be
             * removed by the user. Two independent sources of mandatory status:
             *
             *   1. IsResourceRequestNewFieldsManatory = 1  →  any key listed in
             *      MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY is mandatory.
             *
             *   2. IsResourcePoolMandatory = 1  →  'resource-pool' is mandatory
             *      regardless of flag 1 (independent SEM setting).
             *
             * All call sites (deselectCol, renderTagBar, makeRow, loadColumnPreference)
             * delegate to this single function so logic stays consistent.
             * Added by Nikhil Mane on 02-04-2026
             * ══════════════════════════════════════════════════════════════════ */
            // Added by Nikhil Mane on 02-04-2026
            function _isColMandatory(key) {
                var newFieldsMandatory = (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory === true);
                if (newFieldsMandatory && MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY.indexOf(key) !== -1) return true;
                if (IsResourcePoolMandatory == 1 && key === 'resource-pool') return true;
                /* Nature of Request is always mandatory — permanently selected and locked.
                   It is readonly/auto-computed so the user should never be able to remove it. */
                if (key === 'nature-of-request') return true;
                return false;
            }
            // End of Added by Nikhil Mane on 02-04-2026

            /* Returns true if any visible row has SOW Available set to a non-empty value */
            function _isSowSelectedInAnyRow() {
                var rows = document.querySelectorAll('#resourceTableBody tr.resource-row');
                for (var i = 0; i < rows.length; i++) {
                    var rowId = rows[i].getAttribute('data-row');
                    var el = document.getElementById('cboSOWAvailable_' + rowId);
                    if (el && el.value && el.value !== '') return true;
                }
                return false;
            }
            function _applyNewFieldsMandatoryToRow(rowId, isMandatory) {
                /* Label IDs that get the "required" CSS class.
                   These match the id attributes set on <label> elements in createRow().
                   Added by Nikhil Mane on 01-01-2026 */
                var labelIds = [
                    'lblTypeOfReq_' + rowId,
                    'lbldepartment_' + rowId,
                    'lbllocation_' + rowId,
                    'lblEngagementModel_' + rowId,
                    'lblBillablePosition_' + rowId,
                    'lblSOWAv_' + rowId,
                    'lblJDattachment_' + rowId
                ];
                labelIds.forEach(function (id) {
                    var el = document.getElementById(id);
                    if (!el) return;
                    if (isMandatory) el.classList.add('required');
                    else el.classList.remove('required');
                });

                /* Asterisk spans */
                var spanIds = [
                    'spncboRRProjectRepEmployeeName_' + rowId,
                    'spnRRillingStartDate_' + rowId
                ];
                spanIds.forEach(function (id) {
                    var el = document.getElementById(id);
                    if (!el) return;
                    el.style.display = isMandatory ? 'inline-block' : 'none';
                });
            }
            /* End of Added by Nikhil Mane on 01-01-2026 */

            function LoadProjectDetails() {
                var projectId = typeof SessionProjectID !== 'undefined' ? parseInt(SessionProjectID) : 0;
                if (!projectId || projectId <= 0) { document.getElementById('pdProjectName').textContent = 'N/A'; return; }
                var param = JSON.stringify({ ProjectID: projectId });
                showLoader();
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetProjectDetails',
                    type: 'POST', data: param, async: true, dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        var d = (response && response.data && response.data.length > 0) ? response.data[0] : null;
                        if (!d) return;
                        document.getElementById('pdProjectName').textContent = d.ProjectName || d.projectName || '';
                        var _rawStart = d.StartDate || d.startDate || '';
                        var _rawEnd = d.EndDate || d.endDate || '';
                        document.getElementById('pdStartDate').textContent = _rawStart;
                        document.getElementById('pdEndDate').textContent = _rawEnd;
                        try { _projectStartDate = $.datepicker.parseDate('dd M yy', _rawStart); } catch (e) { _projectStartDate = null; }
                        try { _projectEndDate = $.datepicker.parseDate('dd M yy', _rawEnd); } catch (e) { _projectEndDate = null; }
                        document.getElementById('pdCustomer').textContent = d.CustomerName || d.customerName || '';
                        document.getElementById('pdNoOfResources').textContent = d.NoOfResources || d.noOfResources || '0';
                        document.getElementById('pdWorkHours').textContent = d.WorkHours || d.workHours || '';
                        document.getElementById('pdBillable').textContent = d.Billable || d.billable || '';
                        document.getElementById('pdProjectCurrency').textContent = d.ProjectCurrency || d.projectCurrency || '';
                        var cur = (d.CurrencySymbol || d.currencySymbol) || '';
                        document.getElementById('pdTotalRevenue').textContent = (d.TotalRevenue || d.totalRevenue) != null ? cur + ' ' + Number(d.TotalRevenue || d.totalRevenue).toLocaleString('en-IN', { minimumFractionDigits: 2 }) : '';
                        document.getElementById('pdTotalBudget').textContent = (d.TotalBudget || d.totalBudget) != null ? cur + ' ' + Number(d.TotalBudget || d.totalBudget).toLocaleString('en-IN', { minimumFractionDigits: 2 }) : '';
                        document.getElementById('pdGrossProfitMargin').textContent = (d.GrossProfitMargin || d.grossProfitMargin) != null ? Number(d.GrossProfitMargin || d.grossProfitMargin).toFixed(2) + '%' : '';
                    },
                    error: function () { document.getElementById('pdProjectName').textContent = RES.E_ErrorLoadingDetails; },
                    complete: function () { hideLoader(); }
                });
            }

            window.onTypeOfReqChange_row = function (rowId, val) {
                /* Draft restore sets Type of Requirement programmatically and syncs
                   select2 afterward — ignore synthetic change events during that window. */
                if (window._loadDraftInProgress) return;
                var repRow = document.getElementById('replacement-row-' + rowId);
                if (!repRow) return;
                if (parseInt(val) === 2) {
                    /* Added by Nikhil Mane on 03-04-2026 — Replacement type allows only
                       1 resource. Force the field to 1 the moment the user selects
                       Replacement so it is never submitted with a higher value. */
                    var noResEl = document.getElementById('txtNoOfRes_' + rowId);
                    if (noResEl) {
                        noResEl.value = 1;
                        _markError(noResEl, false);
                    }
                    /* End of Added by Nikhil Mane on 03-04-2026 */
                    /* Load active employees first — only open the row if at least one exists */
                    loadReplacementResources_row(rowId, null, function (hasEmployees) {
                        if (hasEmployees) {
                            repRow.classList.add('open');
                        } else {
                            /* Reset TypeOfReq back to blank */
                            var typeEl = document.getElementById('cboTypeOfReq_' + rowId);
                            if (typeEl) typeEl.value = '0';
                            repRow.classList.remove('open');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Current Project does not have any active Employee to replace.');
                        }
                    });
                } else {
                    repRow.classList.remove('open');
                    var sel = document.getElementById('cboRepResource_' + rowId);
                    if (sel) {
                        _destroyRepResourceSelect2(sel);
                        sel.value = '';
                        sel.innerHTML = '<option value="">Select Employee</option>';
                    }
                }
            };

            /* Added by Nikhil Mane on 31-03-2026
               onAllocTypeChange_row — fires when Allocation Type dropdown changes.
               Mirrors PM_Resource_Selection cbotype behaviour:
                 'P'   = % of Day  → show '%' suffix on Allocation field
                 'HPD' = Hours/Day  → show 'hrs' suffix, allow decimals
                 'TH'  = Total Hrs  → show 'hrs' suffix, allow decimals
               Suffix label is cosmetic — the stored value is the raw number;
               AllocationType tells the SP and Resource Allocation page how to interpret it.
            */
            window.onAllocTypeChange_row = function (rowId, val) {
                var lblEl = document.getElementById('lblAllocUnit_' + rowId);
                var allocEl = document.getElementById('txtAlloc_' + rowId);
                if (!lblEl) return;
                if (val === 'P') {
                    /* % of Day — enable field, cap at 3 digits, show % */
                    lblEl.textContent = '%';
                    if (allocEl) {
                        allocEl.removeAttribute('disabled');
                        allocEl.style.background = '';
                        allocEl.style.cursor = '';
                        allocEl.setAttribute('maxlength', '3');
                    }
                } else if (val === 'HPD' || val === 'TH') {
                    /* Hours mode — enable field, remove 3-digit cap, show hrs */
                    lblEl.textContent = 'hrs';
                    if (allocEl) {
                        allocEl.removeAttribute('disabled');
                        allocEl.style.background = '';
                        allocEl.style.cursor = '';
                        allocEl.removeAttribute('maxlength');
                    }
                } else {
                    /* No allocation type selected — disable field */
                    lblEl.textContent = '%';
                    if (allocEl) {
                        allocEl.setAttribute('disabled', 'disabled');
                        allocEl.style.background = '#f3f4f6';
                        allocEl.style.cursor = 'not-allowed';
                        allocEl.setAttribute('maxlength', '3');
                    }
                }
            };
            /* End of Added by Nikhil Mane on 31-03-2026 */

            /* ── Billing Start Date helpers ────────────────────────────────────────
               Rules enforced here:
               ┌─────────────────────────────────────────────────────────────────┐
               │ When Billable Position = Yes (isYes = true)                     │
               │  • Field is ENABLED.                                            │
               │  • Auto-set to today+30 ONLY if today+30 falls within the       │
               │    project duration [projectStart … projectEnd].                │
               │    - If today+30 < projectStart  → auto-set to projectStart.    │
               │    - If today+30 > projectEnd    → auto-set to projectEnd and   │
               │      show an alert.                                             │
               │  • After auto-set, if the date exceeds the row's requested      │
               │    To Date, show an alert and highlight the field.              │
               │                                                                 │
               │ When Billable Position = No / blank (isYes = false)             │
               │  • Field is DISABLED and CLEARED (set to empty string).         │
               │  • No date is auto-set. No alert is shown.                      │
               └─────────────────────────────────────────────────────────────────┘
               _computeAutoDate() : picks the best auto-date within project range.
               _applyBillingStartDateState(rowId, isYes) : main entry point.
               onBillablePosChange_row(rowId, val) : wired to select onchange.   */

            function _todayPlus30() {
                var d = new Date();
                d.setDate(d.getDate() + 30);
                d.setHours(0, 0, 0, 0);
                return d;
            }

            /* Returns the best auto-date as a Date object (never null).
               Priority: today+30 clamped to [projectStart, projectEnd].
               If project dates are not loaded yet, returns today+30 as-is. */
            function _computeAutoDate() {
                var candidate = _todayPlus30();
                if (_projectStartDate && candidate < _projectStartDate) {
                    candidate = new Date(_projectStartDate.getTime());
                }
                if (_projectEndDate && candidate > _projectEndDate) {
                    candidate = new Date(_projectEndDate.getTime());
                }
                return candidate;
            }

            function _applyBillingStartDateState(rowId, isYes) {
                var billEl = document.getElementById('RRBillingStart_' + rowId);
                var billBtn = billEl ? billEl.closest('.datefielddiv').querySelector('.btncalendar') : null;
                if (!billEl) return;

                /* Get the current row's To Date for validation */
                var toEl = document.getElementById('RRenddt_' + rowId);
                var toStr = toEl ? toEl.value.trim() : '';

                /* Auto-set the date ONLY for new rows — skip during draft restore.
                   During restore, window._loadDraftInProgress = true and the saved
                   billing date is written by the caller (forEach restore block) AFTER
                   this function returns. Running the auto-date logic here during restore
                   would stamp "today + 30" onto the field, which the caller then
                   correctly overwrites — but wrapping it here is cleaner and avoids
                   the unnecessary alertify calls and _markError flicker on load.
                   Fixed by [your name] on [date]. */
                if (!window._loadDraftInProgress) {
                    try {
                        var autoDate = _computeAutoDate();
                        var autoStr = _fmtDate(autoDate);
                        var today30 = _todayPlus30();

                        /* Set the date value */
                        billEl.value = autoStr;

                        /* Check if the auto date is within project duration and show alerts if needed */
                        if (_projectEndDate && today30 > _projectEndDate) {
                            /* today+30 is beyond project end — clamped to project end */
                            _markError(billEl, true);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(
                                'Billing Start Date has been set to the Project End Date (' +
                                _fmtDate(_projectEndDate) +
                                ') because the default date (today + 30 days) falls beyond the project duration.'
                            );
                        }
                        else if (_projectStartDate && today30 < _projectStartDate) {
                            /* today+30 is before project start — clamped to project start */
                            _markError(billEl, true);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(
                                'Billing Start Date has been set to the Project Start Date (' +
                                _fmtDate(_projectStartDate) +
                                ') because the default date (today + 30 days) falls before the project start.'
                            );
                        }
                        else {
                            _markError(billEl, false);
                        }

                        /* Check if the auto date exceeds the row To Date */
                        if (toStr && _parseRowDate(toStr)) {
                            if (Date.parse(autoStr) > Date.parse(toStr)) {
                                _markError(billEl, true);
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(
                                    'Billing Start Date (' + autoStr +
                                    ') is beyond the requested To Date (' + toStr +
                                    '). Please adjust the To Date or Billing Start Date.'
                                );
                            }
                        }
                    } catch (e) {
                        /* _fmtDate requires jQuery datepicker to be initialised — ignore */
                    }
                }

                /* Always apply the enabled/disabled UI state based on Billable Position —
                   this must run even during restore so the field is correctly enabled or
                   disabled to match the saved Billable Position value.
                   Updated by Nikhil Mane — field is ENABLED for any selection (Yes OR No),
                   and only DISABLED when nothing is selected (blank/unset).
                   isYes is now used as "hasValue" — true when any option is chosen. */
                if (!isYes) {
                    /* No selection made → field is DISABLED */
                    billEl.setAttribute('disabled', 'disabled');
                    billEl.style.background = '#f3f4f6';
                    billEl.style.cursor = 'not-allowed';
                    if (billBtn) {
                        billBtn.setAttribute('disabled', 'disabled');
                        billBtn.style.cursor = 'not-allowed';
                        billBtn.style.opacity = '0.5';
                    }
                } else {
                    /* Any value selected (Yes or No) → field is ENABLED and editable */
                    billEl.removeAttribute('disabled');
                    billEl.style.background = '#fff';
                    billEl.style.cursor = 'text';
                    if (billBtn) {
                        billBtn.removeAttribute('disabled');
                        billBtn.style.cursor = 'pointer';
                        billBtn.style.opacity = '1';
                    }
                }
                /* Recompute Nature of Request now that billing date may have been auto-set */
                computeNatureOfRequest(rowId);
            }

            /* Billable Position select onchange handler.
               Updated by Nikhil Mane —
               • Billing Start Date is now ENABLED for ANY selection (Yes or No),
                 and only disabled when nothing is selected (blank / 0).
               • When IsResourceRequestNewFieldsManatory is false AND a value is selected,
                 the Billing Start Date column is auto-added to the grid (and vice-versa). */
            window.onBillablePosChange_row = function (rowId, selValue) {
                /* hasValue = true when a real option is chosen (not blank / '0') */
                var hasValue = selValue && selValue !== '' && selValue !== '0';
                /* Apply field enabled/disabled state and auto-set date */
                _applyBillingStartDateState(rowId, hasValue);

                /* Auto-link: when config is NOT mandatory and a value is selected,
                   ensure the Billing Start Date column is visible in the grid. */
                var newFieldsMandatory = (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory === true);
                if (!newFieldsMandatory && hasValue) {
                    if (selectedOrder.indexOf('billing-start-date') === -1) {
                        _autoSelectCol('billing-start-date');
                    }
                }

                /* Recompute Nature of Request for this row whenever Billable Position changes
                   (Billing Start Date may have been auto-set above) */
                computeNatureOfRequest(rowId);
            };

            /* ══════════════════════════════════════════════════════════════════
             * computeNatureOfRequest(rowId)
             * ──────────────────────────────────────────────────────────────────
             * UI-ONLY — value is never sent in any API payload.
             * Computes and sets the Nature of Request readonly field for a row.
             *
             * Rules:
             *   Super Critical : SOW Available = "Yes"  AND  Billing Start Date < Today
             *   Critical       : SOW Available = "Yes"  AND  Billing Start Date is within
             *                    the next 30 days (>= Today AND <= Today + 30 days)
             *   Normal         : All other combinations (incl. SOW = "No" / blank)
             *
             * The field is only rendered when the "nature-of-request" column is visible.
             * It is auto-shown whenever "sow-available" is selected (see _autoSelectCol
             * override below and deselectCol guard).
             * ══════════════════════════════════════════════════════════════════ */
            function computeNatureOfRequest(rowId) {
                var el = document.getElementById('txtNatureOfReq_' + rowId);
                if (!el) return;

                var sowEl = document.getElementById('cboSOWAvailable_' + rowId);
                var sowVal = sowEl ? sowEl.value : '';
                var billEl = document.getElementById('RRBillingStart_' + rowId);
                var billStr = billEl ? billEl.value.trim() : '';

                /* Default: blank when SOW is not selected or SOW = No */
                var label = '';
                var color = '#6b7280'; /* grey for empty */
                var fontWeight = '400';

                if (sowVal === 'Yes') {
                    /* SOW = Yes but no billing date yet → show Normal as default */
                    label = 'Normal';
                    color = '#1e40af'; /* blue */
                    fontWeight = '600';

                    if (billStr) {
                        var billDate = _parseRowDate(billStr);
                        if (billDate) {
                            var today = new Date(); today.setHours(0, 0, 0, 0);
                            var today30 = new Date(today); today30.setDate(today30.getDate() + 30);

                            if (billDate < today) {
                                label = 'Super Critical';
                                color = '#dc2626'; /* red */
                            } else if (billDate <= today30) {
                                label = 'Critical';
                                color = '#d97706'; /* amber */
                            }
                            /* else Normal — already set above */
                            else {
                                label = 'Normal';
                                color = '#1e40af'; /* blue */
                            }
                        } else {
                            label = 'Normal';
                            color = '#1e40af';
                        }
                    } else {
                        label = 'Normal';
                        color = '#1e40af';
                    }
                } else {
                    label = 'Normal';
                    color = '#1e40af';
                }

                el.value = label;
                el.style.color = color;
                el.style.fontWeight = fontWeight;
            }

            /* onSOWAvailableChange_row — fires when SOW Available dropdown changes.
               1. Recomputes Nature of Request for this row.
               2. Auto-shows the nature-of-request column when SOW = "Yes"
                  (and also ensures it stays visible with sow-available column). */
            window.onSOWAvailableChange_row = function (rowId) {
                /* Re-render dropdown + tagbar so nature-of-request lock state stays current */
                renderDropdown();
                renderTagBar();
                /* Recompute Nature of Request value for this row */
                computeNatureOfRequest(rowId);
            };
            function _isRepResourceSelect(el) {
                return el && el.id && el.id.indexOf('cboRepResource_') === 0;
            }

            function _destroyRepResourceSelect2(sel) {
                if (!sel || typeof $ === 'undefined' || typeof $.fn.select2 === 'undefined') return;
                var $sel = $(sel);
                if ($sel.data('select2')) {
                    try { $sel.select2('destroy'); } catch (e) { }
                }
            }

            /* Initialise / refresh select2 on replacement-employee dropdown after options load.
               Must run after native <option> list is built — select2 caches options at init time. */
            function _bindRepResourceSelect2(sel, savedValue) {
                if (!sel || typeof $ === 'undefined' || typeof $.fn.select2 === 'undefined') return;
                var $sel = $(sel);
                _destroyRepResourceSelect2(sel);
                $sel.select2({
                    width: '100%',
                    minimumResultsForSearch: 0
                });
                $sel.off('select2:select.repval select2:unselect.repval select2:clear.repval');
                $sel.on('select2:select.repval select2:unselect.repval select2:clear.repval', function () {
                    var $container = $sel.next('.select2-container');
                    if ($sel.hasClass('val-error')) {
                        $container.find('.select2-selection--single').css({ 'border-color': '#ef4444', 'background-color': '#fff5f5' });
                    } else {
                        $container.find('.select2-selection--single').css({ 'border-color': '', 'background-color': '' });
                    }
                });
                if (savedValue && savedValue != 0) {
                    $sel.val(String(savedValue)).trigger('change');
                }
            }

            if (!window._repResourceLoadSeq) window._repResourceLoadSeq = {};
            function loadReplacementResources_row(rowId, savedValue, onDone) {
                var sel = document.getElementById('cboRepResource_' + rowId);
                if (!sel) { if (onDone) onDone(false); return; }
                window._repResourceLoadSeq[rowId] = (window._repResourceLoadSeq[rowId] || 0) + 1;
                var loadSeq = window._repResourceLoadSeq[rowId];
                _destroyRepResourceSelect2(sel);
                sel.innerHTML = '<option value="">Loading…</option>';
                sel.disabled = true;
                var param = JSON.stringify({ ProjectID: SessionProjectID });
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetActiveResources',
                    type: 'POST', data: param, async: true, dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        if (loadSeq !== window._repResourceLoadSeq[rowId]) return;
                        var list = (response && response.data && Array.isArray(response.data.BulkResourceActiveEmployeeModel))
                            ? response.data.BulkResourceActiveEmployeeModel : [];
                        if (list.length === 0) {
                            _destroyRepResourceSelect2(sel);
                            sel.innerHTML = '<option value="">Select Employee</option>';
                            sel.disabled = false;
                            if (onDone) onDone(false);
                            return;
                        }
                        var html = '';
                        list.forEach(function (emp) {
                            var id = emp.employeeID || emp.EmployeeID || emp.toolID || emp.ToolID || '0';
                            var name = emp.employeeName || emp.EmployeeName || emp.description || emp.Description || '';
                            html += '<option value="' + id + '">' + name + '</option>';
                        });
                        _destroyRepResourceSelect2(sel);
                        sel.innerHTML = html;
                        sel.disabled = false;
                        _bindRepResourceSelect2(sel, savedValue);
                        if (onDone) onDone(true);
                    },
                    error: function () {
                        if (loadSeq !== window._repResourceLoadSeq[rowId]) return;
                        _destroyRepResourceSelect2(sel);
                        sel.innerHTML = '<option value="">Select Employee</option>';
                        sel.disabled = false;
                        if (onDone) onDone(false);
                    }
                });
            }

            function GetRequestSkillCombo_row(rowId, counter) {
                
                var capturedCounter = counter;
                var param = JSON.stringify({ ProjectID: SessionProjectID, RequestID: 0 });
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetRequestSkillCombo',
                    type: 'POST', data: param, async: false, dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        var strResult = (response && response.data) ? response.data : [];
                        if (!strResult || strResult.length === 0) return;
                        var strResult1 = strResult;
                        var objCbo2 = document.getElementById('cboSkillMaster' + capturedCounter);
                        if (!objCbo2) return;
                        while (objCbo2.options.length > 0) objCbo2.options.remove(0);
                        var IsExternal = '', ChkIsExternal = '';
                        for (var i = 0; i < strResult1.length; i++) {
                            if (strResult[i].flag === '') {
                                var opt = document.createElement('OPTION');
                                objCbo2.options.add(opt);
                                opt.value = strResult[i].toolID == null ? '' : strResult[i].toolID;
                                opt.text = strResult[i].description;
                                opt.setAttribute('data-flag', strResult[i].flag || '');
                            } else if (strResult1[i].flag !== '' && IsExternal !== strResult1[i].flag) {
                                IsExternal = strResult1[i].flag;
                                var og = document.createElement('optgroup');
                                objCbo2.appendChild(og); og.label = IsExternal;
                                for (var j = 0; j < strResult.length; j++) {
                                    ChkIsExternal = strResult[j].flag;
                                    if (IsExternal === ChkIsExternal) {
                                        var optJ = document.createElement('OPTION');
                                        objCbo2.options.add(optJ);
                                        optJ.value = strResult[j].toolID == null ? '' : strResult[j].toolID;
                                        optJ.text = strResult[j].description;
                                        optJ.setAttribute('data-flag', strResult[j].flag || '');
                                    }
                                }
                            }
                        }
                        jQuery('#resourceTableBody .skills-table select option').filter(function () {
                            return !this.value || jQuery.trim(this.value).length === 0 || jQuery.trim(this.text).length === 0;
                        }).remove();
                    },
                    error: function (xhr, status, err) { console.warn('GetRequestSkillCombo_row failed', status, err); }
                });
            }

            window.addRow = function () {
                /* ── Access guard ── */
                if (!addAccess && !window._loadDraftInProgress) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('You do not have permission to add new requests.');
                    return;
                }
                // Added by Nikhil Mane on 30-03-2026 — enforce Count_BulkRequest_Rows limit.
                // This guard fires even if the button is somehow clicked while disabled
                // (e.g. programmatic calls from loadDraft which bypass the disabled state).
                // loadDraft is the only legitimate internal caller that bypasses the button —
                // it calls addRow() for each saved row, so we skip the limit check when
                // restoring a draft (signalled by _skipRowLimitCheck flag).
                if (!window._skipRowLimitCheck && Count_BulkRequest_Rows > 0) {
                    var currentRows = document.querySelectorAll('#resourceTableBody tr.resource-row').length;
                    if (currentRows >= Count_BulkRequest_Rows) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Maximum ' + Count_BulkRequest_Rows + ' rows are allowed per Bulk Resource Request.');
                        return;
                    }
                }
                // End of Added by Nikhil Mane on 30-03-2026

                /* _appendNewRow — performs the actual DOM append.
                   Must be defined before loadBulkRequest / draft-restore paths call it.
                   Fixed by Nikhil Mane on 04-04-2026: when loadBulkRequest loops
                   rows.forEach(function(){ addRow(); var rowId = _rowCount; ... }),
                   the previous implementation deferred the 2nd+ row behind
                   validateAllocationLimitsAsync. addRow() returned immediately,
                   _rowCount never incremented, and every API row mapped onto row 1. */
                function _appendNewRow() {
                    var tbody = document.getElementById('resourceTableBody');
                    var result = createRow();
                    var repRow = createReplacementRow(result.id);
                    var skillSec = createSkillSection(result.id);
                    tbody.appendChild(result.row);
                    tbody.appendChild(repRow);
                    tbody.appendChild(skillSec);
                    initDatepicker('RRstartdt_' + result.id);
                    initDatepicker('RRenddt_' + result.id);
                    initDatepicker('RRBillingStart_' + result.id);
                    /* Apply initial Billing Start Date state: auto-set to today+30, disabled until Billable Position = Yes */
                    _applyBillingStartDateState(result.id, false);
                    syncTableColumns();
                    // Refresh Add More button state — must run BEFORE reinitTooltips
                    // so the new title is on the element when tooltips are re-created.
                    updateAddMoreButtonState();
                    reinitTooltips && reinitTooltips();
                    /* Apply config mandatory state to newly added row */
                    if (_configLoaded) {
                        _applyNewFieldsMandatoryToRow(result.id, (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory === true));
                    }
                    /* ── Select2: initialise searchable dropdowns on the new row ──
                       Added by Nikhil Mane on 04-04-2026 */
                    initRowSelect2(result.row);
                    /* ── Focus: open Type of Requirement (first field) on the new row
                       so the user can start filling it immediately after clicking Add More.
                       Added by Nikhil Mane on 04-04-2026 */
                    if (!window._loadDraftInProgress) {
                        _focusSelect2(document.getElementById('cboTypeOfReq_' + result.id));
                    }
                    /* End of Added by Nikhil Mane on 04-04-2026 */
                }

                /* Restore from API (loadBulkRequest): must append synchronously — see comment on _appendNewRow. */
                if (window._loadDraftInProgress) {
                    _appendNewRow();
                    return;
                }

                /* Validate all existing rows before allowing a new one to be added.
                   IMPORTANT — order of checks:
                     1. Main mandatory fields + row fields are checked first.
                        If ANY main field is missing → show "Please complete the
                        configuration for Row No. X" and stop.  Skill check is
                        skipped entirely so the skill panel is never opened here.
                     2. Only when ALL main fields are valid do we check skill rows.
                     3. Finally, AllocationType server-side limit validation runs
                        async (mirrors saveDraft / saveRow / submitRequest).
                        The new row is only added inside the onSuccess callback
                        so it is never created when a limit check fails.
                   Updated by Nikhil Mane on 04-04-2026 — added validateAllocationLimitsAsync
                   to match the full validation chain used by Save Row / Save Draft / Submit. */
                var existingRows = document.querySelectorAll('#resourceTableBody tr.resource-row');
                if (existingRows.length > 0) {
                    /* Step 1 — static mandatory + row field validation */
                    var rowValidation = validateAllRows();
                    if (!rowValidation) return;

                    /* Step 2 — skill validation */
                    var addMoreSkillErrs = validateSkillsForRows();
                    if (addMoreSkillErrs.length > 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(addMoreSkillErrs[0]);
                        return;
                    }

                    /* Step 3 — async AllocationType server-side limit validation.
                       Collect all visible row IDs and delegate to the shared helper.
                       The actual row-append logic is deferred into onSuccess so
                       it only runs when every row's allocation is within its limit.
                       Added by Nikhil Mane on 04-04-2026 */
                    var _allAddMoreRowIds = Array.prototype.map.call(
                        existingRows,
                        function (tr) { return parseInt(tr.getAttribute('data-row')); }
                    );
                    validateAllocationLimitsAsync(_allAddMoreRowIds, function () {
                        /* onSuccess — all validations passed; append the new row */
                        _appendNewRow();
                    }, null /* onFail — alertify error already shown by validateAllocationLimitsAsync */);
                    /* End of Added by Nikhil Mane on 04-04-2026 */
                } else {
                    /* No existing rows — skip validation and add the first row directly */
                    _appendNewRow();
                }
            };

            function collectRow(rowId) {
                function val(id) { var el = document.getElementById(id); return el ? el.value : ''; }

                /* ── Helper: returns true when a dynamic column is currently visible ──
                   Used as a safety net: even if _resetColValue somehow didn't fire,
                   hidden columns always contribute null/0 to the payload. */
                function colVisible(colKey) {
                    var rowTr = document.querySelector('#resourceTableBody tr.resource-row[data-row="' + rowId + '"]');
                    if (!rowTr) return false;
                    var td = rowTr.querySelector('td.dyn-td[data-col="' + colKey + '"]');
                    return td ? (td.style.display !== 'none') : false;
                }
                function valIfVisible(colKey, id) {
                    return colVisible(colKey) ? val(id) : '';
                }
                function intIfVisible(colKey, id) {
                    return colVisible(colKey) ? (parseInt(val(id)) || 0) : 0;
                }

                /* Added by Nikhil Mane on 01-01-2026 — skills embedded as child array in the row */
                var skills = [];
                var tbody = document.getElementById('skill-tbody-' + rowId);
                if (tbody) {
                    tbody.querySelectorAll('tr').forEach(function (tr, idx) {
                        var parts = tr.id.split('_'); var counter = parts[parts.length - 1];
                        function sel(prefix) { var el = document.getElementById(prefix + counter); return el ? el.value : ''; }
                        skills.push({
                            SkillOrder: idx,
                            SkillName: parseInt(sel('cboSkillMaster')) || 0,
                            ExperienceYear: parseInt(sel('cboMonth')) || 0,
                            ExperienceMonth: parseInt(sel('cboYear')) || 0,
                            Proficiency: parseInt(sel('cboParameters')) || 0,
                            CoreCompetency: !!(document.getElementById('CheckCoreCompantency_' + rowId + '_' + counter) &&
                                document.getElementById('CheckCoreCompantency_' + rowId + '_' + counter).checked)
                        });
                    });
                }
                /* End of Added by Nikhil Mane on 01-01-2026 */
                /* RowID = the database primary key for this row (0 = new/unsaved row).
                   Required so SaveDraft / Submit / SaveRow can UPDATE existing rows
                   instead of always INSERTing. Without it, rows 2..N are never saved
                   because the API cannot match them to their existing DB records.
                   Fixed by Nikhil Mane on 04-04-2026. */
                var _rowDbId = (function () {
                    var _rTr = document.querySelector('#resourceTableBody tr.resource-row[data-row="' + rowId + '"]');
                    return _rTr ? (parseInt(_rTr.getAttribute('data-row-db-id') || '0') || 0) : 0;
                }());
                return {
                    RowID: _rowDbId,
                    RowOrder: rowId, TypeOfRequirement: parseInt(val('cboTypeOfReq_' + rowId)) || 0,
                    ProjectRole: parseInt(val('cboProjectRole_' + rowId)) || 0, NoOfResources: parseInt(val('txtNoOfRes_' + rowId)) || 0,
                    FromDate: val('RRstartdt_' + rowId), ToDate: val('RRenddt_' + rowId),
                    /* Added by Nikhil Mane on 31-03-2026 — AllocationType before AllocationPct */
                    AllocationType: val('cboAllocType_' + rowId) || '',
                    /* End of Added by Nikhil Mane on 31-03-2026 */
                    AllocationPct: parseFloat(val('txtAlloc_' + rowId)) || 0,
                    /* Dynamic columns — read value only when column is visible; send 0/null otherwise */
                    Department: intIfVisible('department', 'cboDept_' + rowId),
                    ResourcePool: intIfVisible('resource-pool', 'cboResPool_' + rowId),
                    Location: intIfVisible('location', 'cboLoc_' + rowId),
                    EngagementModel: intIfVisible('engagement-model', 'cboEngModel_' + rowId),
                    Priority: intIfVisible('priority', 'cboPriority_' + rowId),
                    BillablePosition: intIfVisible('billable-position', 'cboBillPos_' + rowId),
                    BillingStartDate: (function () {
                        if (!colVisible('billing-start-date')) return null;
                        var v = val('RRBillingStart_' + rowId);
                        return (v && v.trim()) ? v.trim() : null;
                    }()),
                    SOWAvailable: valIfVisible('sow-available', 'cboSOWAvailable_' + rowId),
                    JDAttachmentPath: (function () {
                        if (!colVisible('jd-attachment')) return '';
                        var f = document.getElementById('fileJD_' + rowId);
                        if (f) { var stored = f.getAttribute('data-jd-path'); if (stored) return stored; }
                        var rowTr2 = document.querySelector('tr[data-row="' + rowId + '"]');
                        return rowTr2 ? (rowTr2.getAttribute('data-jd-path') || '') : '';
                    }()),
                    ReplacementResourceID: parseInt(val('cboRepResource_' + rowId)) || 0,
                    /* Added by Nikhil Mane on 31-03-2026 — SpecialRequest (optional) */
                    SpecialRequest: colVisible('special-request') ? (val('txtSpecialReq_' + rowId) || '') : '',
                    /* End of Added by Nikhil Mane on 31-03-2026 */
                    /* Added by Nikhil Mane on 01-01-2026 — Skills child array embedded in row */
                    Skills: skills
                };
            }

            /* collectSkills and collectColumns removed by Nikhil Mane on 01-01-2026.
             * Skills are now embedded inside each row via collectRow().Skills.
             * Columns are saved independently via saveColumnPreference(). */

            /* Added by Nikhil Mane on 01-01-2026
             * buildBulkPayload — now sends only Rows (with embedded Skills).
             * Columns are excluded — saved separately via saveColumnPreference(). */
            function buildBulkPayload() {
                var allRows = [];
                document.querySelectorAll('#resourceTableBody tr.resource-row').forEach(function (tr) {
                    allRows.push(collectRow(parseInt(tr.getAttribute('data-row'))));
                });
                return {
                    BulkRequestID: _currentBulkRequestID,
                    ProjectID: typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0,
                    UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0,
                    Rows: allRows
                };
            }
            /* End of Added by Nikhil Mane on 01-01-2026 */

            /* Added by Nikhil Mane on 01-01-2026
             * buildColumnPayload — builds the Columns array from current selectedOrder/unselectedKeys.
             * Used by saveColumnPreference(). */
            function buildColumnPayload() {
                var cols = [];
                selectedOrder.forEach(function (key, idx) {
                    var col = ALL_COLS.find(function (c) { return c.key === key; });
                    cols.push({ ColumnID: col ? col.id : 0, ColumnName: key, ColumnOrder: idx, Applicable: true });
                });
                unselectedKeys.forEach(function (key, idx) {
                    var col = ALL_COLS.find(function (c) { return c.key === key; });
                    cols.push({ ColumnID: col ? col.id : 0, ColumnName: key, ColumnOrder: selectedOrder.length + idx, Applicable: false });
                });
                return {
                    BulkRequestID: _currentBulkRequestID,
                    ProjectID: typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0,
                    UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0,
                    Columns: cols
                };
            }
            /* End of Added by Nikhil Mane on 01-01-2026 */

            /* Added by Nikhil Mane on 01-01-2026
             * saveColumnPreference(onComplete)
             * Calls /api/PM_BulkResourceReq/SaveColumnPreference with the current
             * column selection state. Invoked:
             *   1. After page-load config resolves (when IsResourceRequestNewFieldsManatory
             *      forces mandatory columns to be selected).
             *   2. On every column checkbox check/uncheck in the picker dropdown.
             * onComplete is an optional callback invoked after the AJAX finishes. */
            function saveColumnPreference(onComplete) {
                var param = JSON.stringify(buildColumnPayload());
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/SaveColumnPreference',
                    type: 'POST', data: param, async: true,
                    dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        /* Non-critical — silently update BulkRequestID if new one was returned */
                        if (response && response.data && response.data.bulkRequestID) {
                            _currentBulkRequestID = response.data.bulkRequestID;
                        }
                    },
                    error: function () { /* non-critical; page still functional */ },
                    complete: function () { if (typeof onComplete === 'function') onComplete(); }
                });
            }
            /* End of Added by Nikhil Mane on 01-01-2026 */

            window.saveDraft = function () {
                /* ── Access guard ── */
                if (!addAccess) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('You do not have permission to save changes.');
                    return;
                }
                if (!validateAllRows()) return;
                var saveDraftSkillErrs = validateSkillsForRows();
                if (saveDraftSkillErrs.length > 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(saveDraftSkillErrs[0]);
                    return;
                }
                /* Added by Nikhil Mane on 03-04-2026 — AllocationType server-side limit validation.
                   Collects all visible row IDs and checks allocation caps via API before saving.
                   The AJAX save is deferred inside onSuccess so it only runs if all rows pass. */
                var _allDraftRowIds = Array.prototype.map.call(
                    document.querySelectorAll('#resourceTableBody tr.resource-row'),
                    function (tr) { return parseInt(tr.getAttribute('data-row')); }
                );
                validateAllocationLimitsAsync(_allDraftRowIds, function () {
                    /* onSuccess — all allocation limits passed; proceed to save draft */
                    var param = JSON.stringify(buildBulkPayload());
                    showLoader();
                    $.ajax({
                        url: strUrl + '/api/PM_BulkResourceReq/SaveDraft',
                        type: 'POST', data: param, async: true, dataType: 'json', contentType: 'application/json;charset=utf-8',
                        beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                        success: function (response) {
                            var result = (response && response.data && response.data.data) ? response.data.data : (response && response.data ? response.data : null);
                            if (result && result.bulkRequestID) { _currentBulkRequestID = result.bulkRequestID; sessionStorage.setItem('BulkRequestID', _currentBulkRequestID); }
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(RES.S_DraftSaved);
                            loadBulkRequest();
                        },
                        error: function () { alertify.set('notifier', 'position', 'top-right'); alertify.error(RES.E_ErrorSavingDraft); },
                        complete: function () { hideLoader(); }
                    });
                }, null /* onFail — alertify error already shown by validateAllocationLimitsAsync */);
                /* End of Added by Nikhil Mane on 03-04-2026 */
            };

            window.submitRequest = function () {
                /* ── Access guard ── */
                if (!addAccess) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('You do not have permission to submit requests.');
                    return;
                }
                /* 1. Run all static validations FIRST — only proceed if everything is valid */
                if (!validateAllRows()) return;
                var skillErrs = validateSkillsForSubmit();
                if (skillErrs.length > 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(skillErrs[0]);
                    if (skillErrs.length > 1) {
                        setTimeout(function () {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Please Add Skills');
                        }, 400);
                    }
                    return;
                }
                /* Added by Nikhil Mane on 03-04-2026 — AllocationType server-side limit validation.
                   Runs after all static checks pass. If any row's AllocationPct exceeds the
                   server-side cap for its AllocationType, the error is shown and the confirm
                   modal is NOT displayed — it only appears when onSuccess fires. */
                var _allSubmitRowIds = Array.prototype.map.call(
                    document.querySelectorAll('#resourceTableBody tr.resource-row'),
                    function (tr) { return parseInt(tr.getAttribute('data-row')); }
                );
                validateAllocationLimitsAsync(_allSubmitRowIds, function () {
                    /* onSuccess — all allocation limits passed */
                    /* 2. All valid — now show the Bootstrap confirm modal */
                    var modal = new bootstrap.Modal(document.getElementById('submitConfirmModal'));
                    modal.show();
                    /* Wire Yes button — unbind first to avoid duplicate handlers */
                    var yesBtn = document.getElementById('btnSubmitConfirmYes');
                    yesBtn.onclick = function (evt) {
                        if (evt) {
                            evt.preventDefault();
                            evt.stopPropagation();
                        }
                        modal.hide();
                        _doSubmitRequest();
                        return false;
                    };
                }, null /* onFail — alertify error already shown by validateAllocationLimitsAsync */);
                /* End of Added by Nikhil Mane on 03-04-2026 */
            };
            function _doSubmitRequest() {
                var param = JSON.stringify(buildBulkPayload());
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/Submit',
                    type: 'POST', data: param, async: true, dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        var result = null;
                        if (response && response.data && response.data.data !== undefined) {
                            result = response.data.data;
                        } else if (response && response.data !== undefined) {
                            result = response.data;
                        } else {
                            result = response;
                        }

                        var newBulkID = (result && (result.bulkRequestID || result.BulkRequestID)) || 0;
                        if (newBulkID > 0) {
                            _currentBulkRequestID = newBulkID;
                            sessionStorage.setItem('BulkRequestID', _currentBulkRequestID);
                        }

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(RES.S_SubmittedSuccessfully);

                        var submittedRequestIDs = [];
                        if (result && result.requestIDs && result.requestIDs.length) {
                            submittedRequestIDs = result.requestIDs;
                        } else if (result && result.RequestIDs && result.RequestIDs.length) {
                            submittedRequestIDs = result.RequestIDs;
                        } else if (result && (result.requestID || result.RequestID)) {
                            submittedRequestIDs = [result.requestID || result.RequestID];
                        }

                        /* Fire email FIRST while auth headers + page state are still intact */
                        if (submittedRequestIDs.length > 0) {
                            sendEmailAfterSubmit(submittedRequestIDs);
                        } else {
                            resetPageAfterSubmit();
                        }
                    },
                    error: function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(RES.E_ErrorSubmitting);
                    }
                });
            }
            /* Reset page after submit */
            function resetPageAfterSubmit() {
                /* Updated by Nikhil Mane on 03-04-2026:
                   loadBulkRequest() now handles everything:
                     1. Reads payload.columns from GetByUserProject (even when header=null).
                     2. Updates selectedOrder / unselectedKeys from the server response.
                     3. Calls syncTableColumns / renderDropdown / renderTagBar.
                     4. Adds one blank row via the early-return path.
            
                   Calling addRow / renderDropdown / renderTagBar here BEFORE the async
                   loadBulkRequest completed was a race condition — it added a row too early,
                   then loadBulkRequest cleared the body and added a second row, leaving
                   the page with stale or duplicate rows.
            
                   We now just re-load column prefs then hand off to loadBulkRequest. */
                _currentBulkRequestID = 0;
                sessionStorage.removeItem('BulkRequestID');
                document.getElementById('resourceTableBody').innerHTML = '';
                _rowCount = 0;
                skillCounters = {};
                loadColumnPreference(function () {
                    loadBulkRequest();
                });
            }

            /* sendEmailAfterSubmit — MODAL HIDDEN.
               Mail is now sent directly after submit without showing the popup.
               If the To value exists in GetEmailPreview response, SendEmail is called
               automatically and a success message is shown.
               Updated: mail popup modal hidden, direct send on submission. */
            function sendEmailAfterSubmit(requestIDs) {
                if (!requestIDs || requestIDs.length === 0) return;
                var param = JSON.stringify({ RequestIDs: requestIDs });
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetEmailPreview',
                    type: 'POST', data: param, async: true,
                    dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        try {
                            var preview = null;
                            if (response) {
                                var responseData = response.data || response.Data || null;
                                var nested = responseData && (responseData.data || responseData.Data || null);

                                function hasPreviewFields(obj) {
                                    return !!(obj && (
                                        obj.flag !== undefined || obj.Flag !== undefined ||
                                        obj.from !== undefined || obj.From !== undefined ||
                                        obj.to !== undefined || obj.To !== undefined ||
                                        obj.cc !== undefined || obj.CC !== undefined ||
                                        obj.subject !== undefined || obj.Subject !== undefined ||
                                        obj.bodyHtml !== undefined || obj.BodyHtml !== undefined
                                    ));
                                }

                                if (hasPreviewFields(nested)) {
                                    preview = nested;
                                } else if (hasPreviewFields(responseData)) {
                                    preview = responseData;
                                } else if (hasPreviewFields(response)) {
                                    preview = response;
                                }
                            }

                            /* No valid preview data — skip popup silently */
                            if (!preview) {
                                resetPageAfterSubmit();
                                return;
                            }

                            var flagValue = preview.flag;
                            if (flagValue === undefined || flagValue === null) flagValue = preview.Flag;
                            if (flagValue !== undefined && flagValue !== null && String(flagValue) === '0') {
                                resetPageAfterSubmit();
                                return;
                            }

                            /* MODAL HIDDEN — send mail directly if To value exists */
                            var toVal = (preview.to || preview.To || '').trim();

                            if (!toVal) {
                                /* No To address — skip send, warn and reset */
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(RES.W_EmailNoToAddress || 'No To address found. Email not sent.');
                                resetPageAfterSubmit();
                                return;
                            }

                            /* To value exists — call SendEmail directly without showing popup */
                            var rids = preview.requestIDs || preview.RequestIDs || requestIDs;
                            var sendPayload = {
                                RequestIDs: rids,
                                To: toVal,
                                CC: (preview.cc || preview.CC || '').trim(),
                                Subject: (preview.subject || preview.Subject || '').trim()
                            };
                            var sendParam = JSON.stringify(sendPayload);
                            $.ajax({
                                url: strUrl + '/api/PM_BulkResourceReq/SendEmail',
                                type: 'POST', data: sendParam, async: true,
                                dataType: 'json', contentType: 'application/json;charset=utf-8',
                                beforeSend: function (xhr) { buildAuthHeaders(xhr, sendParam); },
                                success: function () {
                                    /* Mail sent successfully — show success notification */
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.success(RES.S_EmailSent || 'Email sent successfully.');
                                    resetPageAfterSubmit();
                                },
                                error: function () {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(RES.W_EmailCannotSend || 'Email could not be sent.');
                                    resetPageAfterSubmit();
                                }
                            });
                            return; /* exit — resetPageAfterSubmit is called inside the AJAX callbacks above */
                        } catch (e) {
                            resetPageAfterSubmit();
                        }
                    },
                    error: function () { /* silent — never block the user on email failure */ resetPageAfterSubmit(); }
                });
            }

            /* closeEmailModal / confirmSendEmail — stubs retained so any residual
               references in the codebase do not throw JavaScript errors.
               The email popup modal is hidden/commented out; mail is sent directly
               after submission via sendEmailAfterSubmit(). */
            window.closeEmailModal = function () {
                /* no-op — modal is hidden */
                window._emailModalReady = false;
            };

            /* Close on backdrop click — listener retained as no-op since modal is hidden */
            document.addEventListener('DOMContentLoaded', function () {
                /* emailPreviewModal is commented out in HTML — these are no-ops */
            });

            /* confirmSendEmail — no-op stub; modal is hidden, mail is sent directly */
            window.confirmSendEmail = function () {
                /* no-op — modal is hidden; mail sent directly in sendEmailAfterSubmit() */
            };
            /* ══════════════════════════════════════════════════════════════════
 * Non-Project Skills Modal Functions
 * Uses existing flag from dropdown (External = Non-Project Skills)
 * Added by Nikhil Mane on 30-03-2026
 * ══════════════════════════════════════════════════════════════════ */
            var _pendingSkillRowId = null;
            var _pendingSkillCounter = null;
            var _pendingSkillName = null;
            var _pendingSkillFlag = null;
            var _pendingSkillPrevValue = '0';
            var _suppressSkillChangeModal = false;

            function getModalInstance(modalId) {
                var modalEl = document.getElementById(modalId);
                return modalEl ? bootstrap.Modal.getOrCreateInstance(modalEl) : null;
            }

            function restorePendingSkillSelection() {
                if (_pendingSkillCounter === null) return;
                var skillSel = $('#cboSkillMaster' + _pendingSkillCounter);
                if (!skillSel.length) return;
                _suppressSkillChangeModal = true;
                skillSel.val(_pendingSkillPrevValue || '0');
                skillSel.trigger('change');
                _suppressSkillChangeModal = false;
            }

            window.showNonProjectSkillModal = function (rowId, counter, skillName, skillFlag) {
                _pendingSkillRowId = rowId;
                _pendingSkillCounter = counter;
                _pendingSkillName = skillName;
                _pendingSkillFlag = skillFlag;

                var skillMessage = document.getElementById('nonProjectSkillMessage');
                if (skillMessage) {
                    var normalizedFlag = String(skillFlag || '').trim().toLowerCase();
                    if (normalizedFlag === 'non-project skills') {
                        skillMessage.innerHTML = 'Selected skill <strong>' + skillName + '</strong> belongs to <strong>Non-Project Skills</strong>. Do you want to add this skill to the project?';
                    }
                }
                var modal = getModalInstance('nonProjectSkillModal');
                if (modal) modal.show();
            };

            window.closeNonProjectSkillModal = function () {
                var modal = getModalInstance('nonProjectSkillModal');
                if (modal) modal.hide();
                _pendingSkillRowId = null;
                _pendingSkillCounter = null;
                _pendingSkillName = null;
                _pendingSkillFlag = null;
                _pendingSkillPrevValue = '0';
            };

            document.getElementById('btnConfirmNonProjectSkill').addEventListener('click', function () {
                if (_pendingSkillRowId !== null && _pendingSkillCounter !== null) {
                    var skillSel = document.getElementById('cboSkillMaster' + _pendingSkillCounter);
                    if (skillSel) skillSel.classList.remove('val-error');
                    skillSel.setAttribute('data-prev-value', skillSel.value || '0');
                }
                closeNonProjectSkillModal();
            });

            document.getElementById('btnCancelNonProjectSkill').addEventListener('click', function () {
                restorePendingSkillSelection();
                closeNonProjectSkillModal();
            });

            document.getElementById('btnNonProjectSkillClose').addEventListener('click', function () {
                restorePendingSkillSelection();
                closeNonProjectSkillModal();
            });

            // Skill dropdown change handler to check if skill is from Non-Project Skills group
            // Shows modal whenever a Non-Project Skill is selected (flag = 'non-project skills').
            // Project Skills (flag = 'project skills') do NOT trigger the modal.
            // Updated by Nikhil Mane — uses flag exclusively to decide modal; removed legacy
            // 'external' / 'indexOf(external)' fallbacks that were masking the real condition.
            function bindSkillDropdownChange() {
                $(document).on('focus', '[id^="cboSkillMaster"]', function () {
                    this.setAttribute('data-prev-value', this.value || '0');
                });

                $(document).on('change', '[id^="cboSkillMaster"]', function () {
                    if (_suppressSkillChangeModal) return;

                    var $select = $(this);
                    var selectedOption = $select.find('option:selected');
                    var skillId = $select.val();
                    var skillText = selectedOption.text();
                    var counter = $select.attr('id').replace('cboSkillMaster', '');
                    var previousValue = $select.attr('data-prev-value') || '0';

                    /* Read the flag from the selected option's data-flag attribute first;
                       fall back to the optgroup label if data-flag is absent. */
                    var flag = selectedOption.attr('data-flag') || '';
                    if (!flag) {
                        var optGroup = selectedOption.closest('optgroup');
                        flag = optGroup.length ? optGroup.attr('label') : '';
                    }
                    var normalizedFlag = String(flag || '').trim().toLowerCase();

                    var $skillRow = $select.closest('tr');
                    var rowIdMatch = $skillRow.attr('id');

                    if (rowIdMatch && skillId && skillId !== '0' && skillId !== '') {
                        var parts = rowIdMatch.split('_');
                        var rowId = parseInt(parts[1]);

                        /* ── Duplicate skill check — Added by Nikhil Mane on 04-04-2026 ──
                           Before accepting the selection, scan every OTHER skill row in the
                           same request row (rowId) to see if this skill ID is already chosen.
                           If a duplicate is found: revert the dropdown to its previous value
                           and show an error — do NOT proceed to the Non-Project Skills modal. */
                        var tbody = document.getElementById('skill-tbody-' + rowId);
                        var isDuplicate = false;
                        if (tbody) {
                            tbody.querySelectorAll('tr').forEach(function (skillTr) {
                                var trParts = skillTr.id.split('_');
                                var trCounter = trParts[trParts.length - 1];
                                /* Skip the row that the user is currently editing */
                                if (trCounter === String(counter)) return;
                                var otherSel = document.getElementById('cboSkillMaster' + trCounter);
                                if (otherSel && otherSel.value === skillId) {
                                    isDuplicate = true;
                                }
                            });
                        }
                        if (isDuplicate) {
                            /* Revert to the previously selected value */
                            _suppressSkillChangeModal = true;
                            $select.val(previousValue || '0');
                            _suppressSkillChangeModal = false;
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('Row ' + _getRowDisplayNum(rowId) + ': "' + skillText + '" is already added. Please select a different skill.');
                            return;
                        }
                        /* ── End duplicate skill check ── */

                        /* Show modal ONLY for Non-Project Skills.
                           Project Skills are already assigned to the project — no confirmation needed. */
                        if (normalizedFlag === 'non-project skills') {
                            _pendingSkillPrevValue = previousValue;
                            showNonProjectSkillModal(rowId, counter, skillText, flag);
                        } else {
                            /* Project Skill or no-flag (top-level) — accept silently */
                            $select.attr('data-prev-value', skillId || '0');
                        }
                    } else {
                        $select.attr('data-prev-value', skillId || '0');
                    }
                });
            }

            /* ══════════════════════════════════════════════════════════════════
             * Delete Row Confirmation Modal Functions
             * Added by Nikhil Mane on 30-03-2026
             * ══════════════════════════════════════════════════════════════════ */
            var _pendingDeleteRowId = null;

            window.showDeleteRowConfirmModal = function (rowId) {
                _pendingDeleteRowId = rowId;
                var modal = getModalInstance('deleteRowConfirmModal');
                if (modal) modal.show();
            };

            window.closeDeleteRowModal = function () {
                var modal = getModalInstance('deleteRowConfirmModal');
                if (modal) modal.hide();
                _pendingDeleteRowId = null;
            };

            // Confirm delete button handler
            document.getElementById('btnConfirmDeleteRow').addEventListener('click', function () {
                if (_pendingDeleteRowId !== null) {
                    executeDeleteRow(_pendingDeleteRowId);
                }
                closeDeleteRowModal();
            });

            document.getElementById('btnCancelDeleteRow').addEventListener('click', function () {
                closeDeleteRowModal();
            });

            document.getElementById('btnDeleteRowClose').addEventListener('click', function () {
                closeDeleteRowModal();
            });

            function executeDeleteRow(id) {
                var r = document.querySelector('tr[data-row="' + id + '"]');
                var rep = document.getElementById('replacement-row-' + id);
                var s = document.getElementById('skill-section-' + id);
                /* Hide & dispose all tooltip instances inside affected rows BEFORE removal
                   so Bootstrap doesn't leave orphaned tooltip bubbles visible.
                   Updated by Nikhil Mane */
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    [r, rep, s].forEach(function (el) {
                        if (!el) return;
                        el.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (tipEl) {
                            var tip = bootstrap.Tooltip.getInstance(tipEl);
                            if (tip) { tip.hide(); tip.dispose(); }
                        });
                    });
                }
                var dbRowId = r ? parseInt(r.getAttribute('data-row-db-id') || '0') : 0;
                if (dbRowId > 0) {
                    var param = JSON.stringify({ RowID: dbRowId, UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0 });
                    $.ajax({
                        url: strUrl + '/api/PM_BulkResourceReq/DeleteRow', type: 'POST', data: param, async: true,
                        dataType: 'json', contentType: 'application/json;charset=utf-8',
                        beforeSend: function (xhr) { buildAuthHeaders(xhr, param); }
                    });
                }
                if (r) r.remove();
                if (rep) rep.remove();
                if (s) s.remove();
                updateAddMoreButtonState();
                alertify.set('notifier', 'position', 'top-right');
                alertify.success('Request deleted successfully.');
            }

            // Override the original deleteRow function to show confirmation modal
            var originalDeleteRow = window.deleteRow;
            window.deleteRow = function (id) {
                /* ── Access guard ── */
                if (!deleteAccess) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('You do not have permission to delete rows.');
                    return;
                }
                showDeleteRowConfirmModal(id);
            };

            window.saveRow = function (id) {
                /* ── Access guard ── */
                if (!addAccess) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('You do not have permission to save changes.');
                    return;
                }
                /* Clear existing error highlights once before both validators run */
                _clearRowErrors(id);
                /* Run both validators; deduplicate errors; show the first unique one */
                var seen = {};
                var allRowErrs = [];
                validateMandatoryFields(id).concat(validateRowFields(id)).forEach(function (msg) {
                    if (!seen[msg]) { seen[msg] = true; allRowErrs.push(msg); }
                });
                if (allRowErrs.length > 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(allRowErrs[0]);
                    _focusFirstInvalidField(id, { includeSkills: false });
                    return;
                }
                var saveRowSkillErrs = validateSkillsForRows([id]);
                if (saveRowSkillErrs.length > 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(saveRowSkillErrs[0]);
                    return;
                }
                /* Added by Nikhil Mane on 03-04-2026 — AllocationType server-side limit validation.
                   Validates this single row's AllocationPct against the server-side cap for its
                   AllocationType before the SaveRow AJAX call is allowed to proceed. */
                validateAllocationLimitsAsync([id], function () {
                    /* onSuccess — allocation limit passed for this row; proceed to save */
                    var payload = {
                        BulkRequestID: _currentBulkRequestID,
                        ProjectID: typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0,
                        UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0,
                        /* Added by Nikhil Mane on 01-01-2026 — Skills removed from top-level;
                           they are now embedded inside Row.Skills via collectRow() */
                        Row: collectRow(id)
                    };
                    var param = JSON.stringify(payload);
                    var r = document.querySelector('tr[data-row="' + id + '"]');
                    showLoader();
                    $.ajax({
                        url: strUrl + '/api/PM_BulkResourceReq/SaveRow',
                        type: 'POST', data: param, async: true, dataType: 'json', contentType: 'application/json;charset=utf-8',
                        beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                        success: function (response) {
                            var result = (response && response.data && response.data.data) ? response.data.data : (response && response.data ? response.data : response);
                            if (result) {
                                if (result.bulkRequestID) { _currentBulkRequestID = result.bulkRequestID; sessionStorage.setItem('BulkRequestID', _currentBulkRequestID); }
                                if (r && (result.rowID || result.RowID)) r.setAttribute('data-row-db-id', result.rowID || result.RowID);
                            }
                            /* FIX: after save, re-render JD cell so filename link stays visible */
                            var savedJdPath = r ? r.getAttribute('data-jd-path') : '';
                            if (savedJdPath) renderJDAttachmentCell(id, savedJdPath);
                            if (r) { r.style.background = '#f0fdf4'; setTimeout(function () { r.style.background = ''; }, 1500); }
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('Row saved successfully.');
                            var skillSec = document.getElementById('skill-section-' + id);
                            if (skillSec && skillSec.classList.contains('open')) {
                                var inner = skillSec.querySelector('.skill-section-inner');
                                if (inner) { inner.style.background = '#f0fdf4'; setTimeout(function () { inner.style.background = ''; }, 1500); }
                            }
                        },
                        error: function () { alertify.set('notifier', 'position', 'top-right'); alertify.error(RES.E_ErrorSavingRow); },
                        complete: function () { hideLoader(); }
                    });
                }, null /* onFail — alertify error already shown by validateAllocationLimitsAsync */);
                /* End of Added by Nikhil Mane on 03-04-2026 */
            };

            /*window.deleteRow = function (id) {
                var r = document.querySelector('tr[data-row="' + id + '"]');
                var s = document.getElementById('skill-section-' + id);
                var dbRowId = r ? parseInt(r.getAttribute('data-row-db-id') || '0') : 0;
                if (dbRowId > 0) {
                    var param = JSON.stringify({ RowID: dbRowId, UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0 });
                    $.ajax({
                        url: strUrl + '/api/PM_BulkResourceReq/DeleteRow', type: 'POST', data: param, async: true,
                        dataType: 'json', contentType: 'application/json;charset=utf-8',
                        beforeSend: function (xhr) { buildAuthHeaders(xhr, param); }
                    });
                }
                if (r) r.remove();
                var rep = document.getElementById('replacement-row-' + id);
                if (rep) rep.remove();
                if (s) s.remove();
                // Added by Nikhil Mane on 30-03-2026 — refresh Add More button state after row deleted.
                // Re-enables the button if row count drops back below Count_BulkRequest_Rows.
                updateAddMoreButtonState();
            };*/

            /* ── Validation helpers ── */
            function _parseRowDate(str) { if (!str || !str.trim()) return null; try { return $.datepicker.parseDate('dd M yy', str.trim()); } catch (e) { return null; } }
            function _addMonths(d, m) { var r = new Date(d); r.setMonth(r.getMonth() + m); return r; }
            function _fmtDate(d) { return $.datepicker.formatDate('dd M yy', d); }
            function _markError(el, isError) {
                if (!el) return;
                if (isError) el.classList.add('val-error');
                else el.classList.remove('val-error');
                /* ── Sync val-error visual state to select2 container (if enhanced) ──
                   select2 wraps the native <select> in a sibling .select2-container div,
                   so CSS :has() / sibling selectors on the <select> don't reach it.
                   We set inline styles directly on the selection box instead.
                   Added by Nikhil Mane on 04-04-2026 */
                if (typeof $ !== 'undefined' && typeof $.fn.select2 !== 'undefined' && $(el).data('select2')) {
                    var $sel = $(el).next('.select2-container').find('.select2-selection--single');
                    if (isError) {
                        $sel.css({ 'border-color': '#ef4444', 'background-color': '#fff5f5' });
                    } else {
                        $sel.css({ 'border-color': '', 'background-color': '' });
                    }
                }
                /* End of Added by Nikhil Mane on 04-04-2026 */
            }
            function _clearRowErrors(rowId) {
                var tr = document.querySelector('tr[data-row="' + rowId + '"]');
                if (tr) tr.querySelectorAll('.val-error').forEach(function (el) { el.classList.remove('val-error'); });
            }
            /* _getRowDisplayNum(rowId)
               Returns the 1-based VISUAL position of the row in the table so that
               validation messages always say "Row 1", "Row 2" etc. matching what
               the user sees on screen — even when the internal data-row counter
               drifts due to row deletions, saves, or draft reloads.
               Falls back to rowId if the row cannot be found (safety net).
               Added by Nikhil Mane on 04-04-2026 */
            function _getRowDisplayNum(rowId) {
                var rows = document.querySelectorAll('#resourceTableBody tr.resource-row');
                for (var _i = 0; _i < rows.length; _i++) {
                    if (parseInt(rows[_i].getAttribute('data-row')) === rowId) return _i + 1;
                }
                return rowId;
            }
            /* End of Added by Nikhil Mane on 04-04-2026 */

            function _focusField(el) {
                if (!el) return;
                try {
                    el.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'nearest' });
                } catch (e) {
                    try { el.scrollIntoView(true); } catch (ignore) { }
                }
                try { el.focus(); } catch (e2) { }
            }

            function _focusFirstInvalidField(rowId, options) {
                options = options || {};

                var replacementRow = document.getElementById('replacement-row-' + rowId);
                var skillSection = document.getElementById('skill-section-' + rowId);

                function pickFirst(ids) {
                    for (var i = 0; i < ids.length; i++) {
                        var el = document.getElementById(ids[i]);
                        if (el && el.classList.contains('val-error')) return el;
                    }
                    return null;
                }

                var mainFieldIds = [
                    'cboTypeOfReq_' + rowId,
                    'cboProjectRole_' + rowId,
                    'txtNoOfRes_' + rowId,
                    'RRstartdt_' + rowId,
                    'RRenddt_' + rowId,
                    'cboAllocType_' + rowId,
                    'txtAlloc_' + rowId,
                    'cboRepResource_' + rowId,
                    'cboDept_' + rowId,
                    'cboResPool_' + rowId,
                    'cboLoc_' + rowId,
                    'cboEngModel_' + rowId,
                    'cboBillPos_' + rowId,
                    'RRBillingStart_' + rowId,
                    'cboSOWAvailable_' + rowId,
                    'fileJD_' + rowId
                ];

                var firstInvalid = pickFirst(mainFieldIds);
                if (firstInvalid) {
                    if (replacementRow && firstInvalid.id.indexOf('cboRepResource_') === 0) {
                        replacementRow.classList.add('open');
                    }
                    if (firstInvalid.id.indexOf('fileJD_') === 0) {
                        _focusField(document.getElementById('btnJD_' + rowId) || firstInvalid);
                    } else if (firstInvalid.id.indexOf('RRBillingStart_') === 0) {
                        _focusField(firstInvalid);
                        try { $('#' + firstInvalid.id).datepicker('show'); } catch (e3) { }
                    } else {
                        _focusField(firstInvalid);
                    }
                    return true;
                }

                if (options.includeSkills && skillSection) {
                    var firstSkillInvalid = skillSection.querySelector('.val-error');
                    if (firstSkillInvalid) {
                        skillSection.classList.add('open');
                        _focusField(firstSkillInvalid);
                        return true;
                    }
                }

                return false;
            }

            /* ── Blur validation handlers ── pattern matches PM_Resource_Selection.aspx:
               alertify.set('notifier','position','top-right') called inline before each alert */

            window.onNoOfResBlur_row = function (rowId, input) {
                var v = parseInt(input.value) || 0;
                /* Added by Nikhil Mane on 03-04-2026 — Replacement type allows only 1 resource.
                   If the user manually edits the field to anything other than 1 after selecting
                   Replacement, silently reset it to 1 and show an informational error. */
                var typeEl = document.getElementById('cboTypeOfReq_' + rowId);
                var isReplacement = typeEl && parseInt(typeEl.value) === 2;
                if (isReplacement) {
                    if (v !== 1) {
                        input.value = 1;
                        _markError(input, false);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Row ' + _getRowDisplayNum(rowId) + ': No. of Resources must be 1 for Replacement type.');
                    } else {
                        _markError(input, false);
                    }
                    return;
                }
                /* End of Added by Nikhil Mane on 03-04-2026 */
                if (v < 1 || v > 50) {
                    _markError(input, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_NoOfResourcesRange);
                } else {
                    _markError(input, false);
                }
            };

            window.onAllocBlur_row = function (rowId, input) {
                var v = parseFloat(input.value);
                if (isNaN(v) || input.value.trim() === '') {
                    _markError(input, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_AllocationBlank);
                } else if (v <= 0) {
                    _markError(input, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_AllocationZero);
                } else {
                    _markError(input, false);
                }
            };

            window.onTypeOfReqBlur_row = function (rowId) {
                var el = document.getElementById('cboTypeOfReq_' + rowId);
                if (el && (!el.value || el.value === '0' || el.value === '')) {
                    _markError(el, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_TypeOfRequirementBlank);
                } else if (el) {
                    _markError(el, false);
                }
            };

            window.onProjectRoleBlur_row = function (rowId, sel) {
                if (!sel.value || sel.value === '' || sel.value === '0') {
                    _markError(sel, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_ProjectRoleBlank);
                } else {
                    _markError(sel, false);
                }
            };

            window.onFromDateBlur_row = function (rowId) {
                var fromEl = document.getElementById('RRstartdt_' + rowId);
                var fromStr = fromEl ? fromEl.value.trim() : '';

                if (!fromStr) {
                    _markError(fromEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedStartDateBlank);
                    return;
                }
                var fromDate = _parseRowDate(fromStr);
                if (!fromDate) {
                    _markError(fromEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedStartDateInvalid);
                    return;
                }
                /* From Date must not be in the past */
                var _today = new Date(); _today.setHours(0, 0, 0, 0);
                if (Date.parse(fromStr) < _today.getTime()) {
                    _markError(fromEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Row ' + _getRowDisplayNum(rowId) + ': From Date cannot be in the past. Please select today or a future date.');
                    return;
                }
                if (_projectStartDate && Date.parse(fromStr) < Date.parse(_fmtDate(_projectStartDate))) {
                    _markError(fromEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedStartDateBeforeProjectStart.replace('{0}', _fmtDate(_projectStartDate)));
                    return;
                }
                if (_projectEndDate && Date.parse(fromStr) > Date.parse(_fmtDate(_projectEndDate))) {
                    _markError(fromEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedStartDateAfterProjectEnd.replace('{0}', _fmtDate(_projectEndDate)));
                    return;
                }
                /* From Date must be less than To Date if To Date is already set */
                var toEl = document.getElementById('RRenddt_' + rowId);
                var toStr = toEl ? toEl.value.trim() : '';
                if (toStr && _parseRowDate(toStr) && Date.parse(fromStr) > Date.parse(toStr)) {
                    _markError(fromEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Row ' + _getRowDisplayNum(rowId) + ': From Date must be earlier than To Date.');
                    return;
                }
                _markError(fromEl, false);
            };

            window.onToDateBlur_row = function (rowId) {
                var fromEl = document.getElementById('RRstartdt_' + rowId);
                var toEl = document.getElementById('RRenddt_' + rowId);
                var fromStr = fromEl ? fromEl.value.trim() : '';
                var toStr = toEl ? toEl.value.trim() : '';

                if (!toStr) {
                    _markError(toEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedEndDateBlank);
                    return;
                }
                var toDate = _parseRowDate(toStr);
                if (!toDate) {
                    _markError(toEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedEndDateInvalid);
                    return;
                }
                _markError(toEl, false);

                if (_projectEndDate && Date.parse(toStr) > Date.parse(_fmtDate(_projectEndDate))) {
                    _markError(toEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedEndDateAfterProjectEnd.replace('{0}', _fmtDate(_projectEndDate)));
                    return;
                }
                if (_projectStartDate && Date.parse(toStr) < Date.parse(_fmtDate(_projectStartDate))) {
                    _markError(toEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_PlannedEndDateBeforeProjectStart.replace('{0}', _fmtDate(_projectStartDate)));
                    return;
                }
                if (fromStr) {
                    var fromDate = _parseRowDate(fromStr);
                    if (fromDate && Date.parse(toStr) < Date.parse(fromStr)) {
                        _markError(toEl, true);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Row ' + _getRowDisplayNum(rowId) + ': From Date must be earlier than To Date.');
                    }
                }
            };

            window.onBillingStartDateBlur_row = function (rowId) {
                var billEl = document.getElementById('RRBillingStart_' + rowId);
                var billStr = billEl ? billEl.value.trim() : '';

                /* Determine if Billable Position = Yes */
                var _bpEl = document.getElementById('cboBillPos_' + rowId);
                var _bpIsYes = false;
                if (_bpEl && _bpEl.value && _bpEl.value !== '0') {
                    var _bpTxt = _bpEl.options[_bpEl.selectedIndex] ? (_bpEl.options[_bpEl.selectedIndex].text || '') : '';
                    _bpIsYes = (_bpTxt.toLowerCase().indexOf('yes') !== -1) || (parseInt(_bpEl.value) === 2) || (parseInt(_bpEl.value) === 1);
                }

                if (!billStr) {
                    /* Blank: clear error (mandatory check handled elsewhere when Billable Pos = Yes) */
                    _markError(billEl, false);
                    return;
                }

                var billDate = _parseRowDate(billStr);
                if (!billDate) {
                    _markError(billEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_BillingStartDateInvalid);
                    return;
                }
                _markError(billEl, false);

                var fromEl = document.getElementById('RRstartdt_' + rowId);
                var fromStr = fromEl ? fromEl.value.trim() : '';
                var toEl = document.getElementById('RRenddt_' + rowId);
                var toStr = toEl ? toEl.value.trim() : '';

                /* Rule 3: must not be before From Date */
                if (fromStr && _parseRowDate(fromStr)) {
                    if (Date.parse(billStr) < Date.parse(fromStr)) {
                        _markError(billEl, true);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(RES.E_BillingStartDateBeforeFromDate.replace('{0}', fromStr));
                        return;
                    }
                }
                /* Rule 4a: must not be before project start date */
                if (_projectStartDate && Date.parse(billStr) < Date.parse(_fmtDate(_projectStartDate))) {
                    _markError(billEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Billing Start Date must be within the project duration (from ' + _fmtDate(_projectStartDate) + ').');
                    return;
                }
                /* Rule 4b: must not be after project end date */
                if (_projectEndDate && Date.parse(billStr) > Date.parse(_fmtDate(_projectEndDate))) {
                    _markError(billEl, true);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_BillingStartDateAfterProjectEnd.replace('{0}', _fmtDate(_projectEndDate)));
                    return;
                }
                /* Rule 5: must not be beyond the requested To Date */
                if (toStr && _parseRowDate(toStr)) {
                    if (Date.parse(billStr) > Date.parse(toStr)) {
                        _markError(billEl, true);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Billing Start Date must not be beyond the requested To Date (' + toStr + ').');
                        return;
                    }
                }
                _markError(billEl, false);
            };

            function renderJDAttachmentCell(rowId, storedPath, displayName) {
                var tr = document.querySelector('tr[data-row="' + rowId + '"]');
                if (!tr) return;
                var td = tr.querySelector('td.dyn-td[data-col="jd-attachment"]');
                if (!td) return;

                /* Store path on the TR so collectRow can always retrieve it */
                if (storedPath && storedPath.trim()) tr.setAttribute('data-jd-path', storedPath.trim());

                /* Derive display name */
                var fileName = displayName || (storedPath ? storedPath.split('/').pop().split('\\').pop() : '');
                var ext = fileName ? fileName.substring(fileName.lastIndexOf('.')).toLowerCase() : '';
                var isImage = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'].indexOf(ext) !== -1;

                /* Build inline file preview (shown under the button when a file is already saved) */
                var filePreviewHtml = '';
                if (storedPath && storedPath.trim()) {
                    var hrefPath = strAppRoot + '/' + storedPath.replace(/^\/+/, '');
                    if (isImage) {
                        filePreviewHtml =
                            '<span class="jd-file-name">' +
                            '<a href="' + hrefPath + '" target="_blank">' +
                            '<img src="' + hrefPath + '" alt="JD" style="max-width:80px;max-height:40px;border:1px solid #e5e7eb;border-radius:3px;object-fit:cover;vertical-align:middle;" />' +
                            '</a></span>';
                    } else {
                        filePreviewHtml =
                            '<span class="jd-file-name">' +
                            '<a href="' + hrefPath + '" target="_blank">' +
                            '<i class="fas fa-paperclip" style="margin-right:2px;"></i>' + fileName +
                            '</a></span>';
                    }
                }

                td.innerHTML =
                    '<div style="display:flex;flex-direction:column;gap:2px;">' +
                    '<input type="file" id="fileJD_' + rowId + '" class="jd-file-input-hidden"' +
                    ' data-jd-path="' + (storedPath || '') + '"' +
                    ' accept=".pdf,.doc,.docx,.jpg,.jpeg,.png,.gif,.bmp,.webp"' +
                    ' onchange="validateJDAttachment(' + rowId + ', this)" />' +
                    '<button type="button" class="jd-upload-btn" id="btnJD_' + rowId + '"' +
                    ' onclick="document.getElementById(\'fileJD_' + rowId + '\').click()">' +
                    '<i class="fas fa-paperclip"></i> JD Attachments</button>' +
                    filePreviewHtml +
                    '<span class="jd-file-name" id="spnJDName_' + rowId + '"></span>' +
                    '<span id="spnJDMsg_' + rowId + '" style="font-size:10px;color:#ef4444;display:none;"></span>' +
                    '</div>';
            }

            window.validateJDAttachment = function (rowId, input) {
                var msgEl = document.getElementById('spnJDMsg_' + rowId);
                if (!input || !input.files || input.files.length === 0) {
                    if (msgEl) msgEl.style.display = 'none';
                    _markError(input, false);
                    return true;
                }
                var file = input.files[0];

                /* ── 1. Special characters (mirrors ValidateAttachment) ────────── */
                if (file.name.indexOf('#') !== -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_JDSpecialCharHash);
                    _markError(input, true); input.value = ''; return false;
                }
                if (file.name.indexOf("'") !== -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_JDSingleQuote);
                    _markError(input, true); input.value = ''; return false;
                }

                /* ── 2. Multiple extensions ────────────────────────────────────── */
                if ((file.name.split('.').length - 1) > 1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_JDMultipleExtensions);
                    _markError(input, true); input.value = ''; return false;
                }

                /* ── 3. File name length (120 chars before extension) ──────────── */
                var baseName = file.name.split('.')[0];
                if (baseName.length > 120) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_JDFileNameTooLong);
                    _markError(input, true); input.value = ''; return false;
                }

                /* ── 4. Disallowed extensions (from web.config FileExtensionDisallow) ─
                   ValidateAttachment logic: build list from comma-separated string,
                   ALLOW only those extensions — reject anything not in the list. */
                var ext = file.name.slice(file.name.lastIndexOf('.') + 1).toLowerCase();
                if (strJDExtensionDisallow && strJDExtensionDisallow.length > 0) {
                    var allowedList = strJDExtensionDisallow.split(',');
                    var extAllowed = false;
                    for (var i = 0; i < allowedList.length; i++) {
                        if (allowedList[i].trim().toLowerCase() === ext) { extAllowed = true; break; }
                    }
                    if (!extAllowed) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(RES.E_JDInvalidExtension.replace('{0}', allowedList.map(function (e) { return e.trim().toUpperCase(); }).join(', ')));
                        _markError(input, true); input.value = ''; return false;
                    }
                }

                /* ── 5. Minimum file size (from web.config inFileSize, in bytes) ── */
                if (intJDMinFileSize > 0 && file.size < intJDMinFileSize) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(RES.E_JDFileSizeTooSmall.replace('{0}', intJDMinFileSize));
                    _markError(input, true); input.value = ''; return false;
                }

                /* ── All checks passed ─────────────────────────────────────────── */
                if (msgEl) msgEl.style.display = 'none';
                _markError(input, false);

                /* Show chosen filename immediately beneath the button */
                var nameEl = document.getElementById('spnJDName_' + rowId);
                if (nameEl) {
                    nameEl.textContent = file.name;
                    nameEl.style.display = 'block';
                }

                /* ── Upload file to server immediately on selection ────────────── */
                uploadJDAttachment(rowId, input, file);
                return true;
            };

            /* ── uploadJDAttachment: dual upload ───────────────────────────────────
               XHR 1 → PM_BulkResourceReq.aspx?action=UploadJD  (this ASPX page,
                        handled in Page_Load of the VB code-behind)
                        Saves to ~/Uploads/JDAttachments/{projectId}/ in the ASPX
                        project. Drives the UI — path stored + cell rendered.
               XHR 2 → /api/PM_BulkResourceReq/UploadJDAttachment  (API project)
                        Unchanged from before. Runs silently in background.
               Both fire simultaneously. */
            function uploadJDAttachment(rowId, inputEl, file) {
                var msgEl = document.getElementById('spnJDMsg_' + rowId);

                if (msgEl) { msgEl.style.color = '#2563eb'; msgEl.textContent = 'Uploading'; msgEl.style.display = 'block'; }

                var fd = new FormData();
                fd.append('file', file);
                fd.append('rowId', rowId);
                fd.append('projectId', typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0);

                var xhr = new XMLHttpRequest();
                /* POST back to this same ASPX page with ?action=UploadJD
                   Page_Load in the VB code-behind intercepts it, saves the
                   file to ~/Uploads/JDAttachments/, returns JSON. */
                xhr.open('POST', '<%=Request.Url.AbsolutePath%>?action=UploadJD', true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        try {
                            var data = JSON.parse(xhr.responseText);
                            /* filePath  = full web path saved in DB  e.g. /W26_NewDev/Uploads/JDAttachments/20260310_MyJD.pdf
                               fileName  = original name shown in UI  e.g. MyJD.pdf */
                            var serverPath = (data && (data.filePath || data.FilePath)) || '';
                            var originalName = (data && (data.fileName || data.FileName)) || file.name;
                            if (serverPath) {
                                /* Store the full web path on the TR and the input —
                                   collectRow reads this and sends it in the payload */
                                var tr = document.querySelector('tr[data-row="' + rowId + '"]');
                                if (tr) tr.setAttribute('data-jd-path', serverPath);
                                inputEl.setAttribute('data-jd-path', serverPath);
                                /* Re-render the cell so the link shows the original filename
                                   but the href points to the correct server path */
                                renderJDAttachmentCell(rowId, serverPath, originalName);
                                if (msgEl) msgEl.style.display = 'none';
                            } else {
                                if (msgEl) { msgEl.style.color = '#ef4444'; msgEl.textContent = 'Upload failed — no path returned.'; msgEl.style.display = 'block'; }
                                inputEl.value = '';
                            }
                        } catch (e) {
                            if (msgEl) { msgEl.style.color = '#ef4444'; msgEl.textContent = 'Upload error. Please try again.'; msgEl.style.display = 'block'; }
                            inputEl.value = '';
                        }
                    } else {
                        try {
                            var errData = JSON.parse(xhr.responseText);
                            var errMsg = (errData && errData.error) ? errData.error : 'Upload failed (' + xhr.status + ').';
                            if (msgEl) { msgEl.style.color = '#ef4444'; msgEl.textContent = errMsg; msgEl.style.display = 'block'; }
                        } catch (e) {
                            if (msgEl) { msgEl.style.color = '#ef4444'; msgEl.textContent = 'Upload failed (' + xhr.status + '). Please try again.'; msgEl.style.display = 'block'; }
                        }
                        inputEl.value = '';
                    }
                };
                xhr.onerror = function () {
                    if (msgEl) { msgEl.style.color = '#ef4444'; msgEl.textContent = 'Upload error. Check connection and try again.'; msgEl.style.display = 'block'; }
                    inputEl.value = '';
                };
                xhr.send(fd);
            }

            function validateMandatoryFields(rowId) {
                /* Errors collected in visual column order:
                   Type of Requirement → Project Role → No. of Resources (replacement check)
                   → Replacement Employee → Department → Location → Engagement Model
                   → Billable Position → Billing Start Date → SOW Available → JD Attachment
                   → From Date → To Date → Allocation Type → Allocation % */
                var errors = [];
                var newFieldsMandatory = (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory === true);
                function elById(id) { return document.getElementById(id); }
                function val(id) { var e = elById(id); return e ? e.value.trim() : ''; }
                /* 1. Type of Requirement (col 1) */
                var typeEl = document.getElementById('cboTypeOfReq_' + rowId);

                if (typeEl && (!typeEl.value || typeEl.value === '0' || typeEl.value === '')) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_TypeOfRequirementBlank);
                    _markError(typeEl, true);
                } else if (typeEl) { _markError(typeEl, false); }


                /* 2. Project Role (col 2) */
                var roleEl = document.getElementById('cboProjectRole_' + rowId);
                if (roleEl && (!roleEl.value || roleEl.value === '0' || roleEl.value === '')) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_ProjectRoleBlank);
                    _markError(roleEl, true);
                } else if (roleEl) { _markError(roleEl, false); }

                /* 3. Replacement checks — only when TypeOfRequirement = 2 */
                if (typeEl && parseInt(typeEl.value) === 2) {
                    /* 3a. No. of Resources must be exactly 1 for replacement */

                    var noResEl2 = document.getElementById('txtNoOfRes_' + rowId);
                    if (noResEl2 && parseInt(noResEl2.value) !== 1) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': In case of Replacement Request, No. Of Resources should be 1.');
                        _markError(noResEl2, true);
                    }

                    /* 3b. Replacement Employee Name — only validate if the replacement
                       row is currently open (visible). If TypeOfReq = 2 but the row is
                       not open yet (e.g. employees are still loading async), skip this
                       check so rows in-between are not falsely blocked.
                       Fixed by Nikhil Mane on 04-04-2026. */
                    var repRowEl = document.getElementById('replacement-row-' + rowId);
                    var repRowOpen = repRowEl && repRowEl.classList.contains('open');
                    var repEl = document.getElementById('cboRepResource_' + rowId);
                    /* Fixed by Nikhil Mane on 04-04-2026 — secondary safety net:
                       if the dropdown is still disabled (employees loading async), skip
                       the check entirely so a race condition never shows a false error. */
                    var repStillLoading = repEl && repEl.disabled;
                    if (repRowOpen && !repStillLoading && (!repEl || !repEl.value || parseInt(repEl.value) <= 0)) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + (newFieldsMandatory
                            ? 'Replacement Employee Name Should not be left blank.'
                            : 'Please select an Employee to replace.'));
                        if (repEl) _markError(repEl, true);
                    } else { if (repEl && !repStillLoading) _markError(repEl, false); }
                    /* End of Fixed by Nikhil Mane on 04-04-2026 */
                }
                /* No. of Resources (col 3 — fixed column) */
                var noRes = parseInt(val('txtNoOfRes_' + rowId)) || 0;
                var noResEl = elById('txtNoOfRes_' + rowId);
                /* Added by Nikhil Mane on 03-04-2026 — Replacement type constraint.
                   When Type of Requirement = Replacement (value 2), No. of Resources
                   must be exactly 1. Validated here so Save Row / Save as Draft / Submit
                   all enforce the same rule. */
                var _typeEl = elById('cboTypeOfReq_' + rowId);
                var _isReplacement = _typeEl && parseInt(_typeEl.value) === 2;
                if (_isReplacement) {
                    if (noRes !== 1) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': No. of Resources must be 1 for Replacement type.');
                        _markError(noResEl, true);
                    } else {
                        _markError(noResEl, false);
                    }
                } else if (noRes < 1 || noRes > 9999) {
                    /* End of Added by Nikhil Mane on 03-04-2026 */
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_NoOfResourcesRange);
                    _markError(noResEl, true);
                } else { _markError(noResEl, false); }

                /* Dates — validated before Allocation Type to match column order */
                var fromStr = val('RRstartdt_' + rowId);
                var toStr = val('RRenddt_' + rowId);
                var fromEl = elById('RRstartdt_' + rowId);
                var toEl = elById('RRenddt_' + rowId);

                /* Compute today at midnight for past-date comparison */
                var _today = new Date(); _today.setHours(0, 0, 0, 0);
                var _todayStr = _fmtDate(_today);

                if (!fromStr) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedStartDateBlank);
                    _markError(fromEl, true);
                } else if (!_parseRowDate(fromStr)) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedStartDateInvalid);
                    _markError(fromEl, true);
                } else if (Date.parse(fromStr) < Date.parse(_todayStr)) {
                    /* Skip past-date check for rows already saved to DB — their From Date
                       was valid when created. Blocking re-save/draft would prevent all rows
                       after row 1 from ever being saved again.
                       Fixed by Nikhil Mane on 04-04-2026. */
                    var _savedRow = document.querySelector('#resourceTableBody tr.resource-row[data-row="' + rowId + '"]');
                    var _isSavedRow = _savedRow && (parseInt(_savedRow.getAttribute('data-row-db-id') || '0') > 0);
                    if (!_isSavedRow) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': From Date cannot be in the past. Please select today or a future date.');
                        _markError(fromEl, true);
                    } else { _markError(fromEl, false); }
                } else { _markError(fromEl, false); }

                if (!toStr) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedEndDateBlank);
                    _markError(toEl, true);
                } else if (!_parseRowDate(toStr)) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedEndDateInvalid);
                    _markError(toEl, true);
                } else { _markError(toEl, false); }

                var fromDate = _parseRowDate(fromStr);
                var toDate = _parseRowDate(toStr);

                if (fromDate && toDate) {
                    /* From Date must be strictly less than To Date */
                    if (Date.parse(fromStr) > Date.parse(toStr)) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': From Date must be earlier than To Date.');
                        _markError(fromEl, true); _markError(toEl, true);
                    } else {
                        if (_projectStartDate && Date.parse(fromStr) < Date.parse(_fmtDate(_projectStartDate)) &&
                            _projectEndDate && Date.parse(toStr) < Date.parse(_fmtDate(_projectEndDate))) {
                            errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedDatesBetweenProject.replace('{0}', _fmtDate(_projectStartDate)).replace('{1}', _fmtDate(_projectEndDate)));
                            _markError(fromEl, true); _markError(toEl, true);
                        } else {
                            if (_projectEndDate && Date.parse(fromStr) > Date.parse(_fmtDate(_projectEndDate))) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedStartDateAfterProjectEnd.replace('{0}', _fmtDate(_projectEndDate)));
                                _markError(fromEl, true);
                            }
                            if (_projectStartDate && Date.parse(fromStr) < Date.parse(_fmtDate(_projectStartDate))) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedStartDateBeforeProjectStart.replace('{0}', _fmtDate(_projectStartDate)));
                                _markError(fromEl, true);
                            }
                            if (_projectEndDate && Date.parse(toStr) > Date.parse(_fmtDate(_projectEndDate))) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_PlannedEndDateAfterProjectEnd.replace('{0}', _fmtDate(_projectEndDate)));
                                _markError(toEl, true);
                            }
                        }
                    }
                }

                /* Added by Nikhil Mane on 31-03-2026 — Allocation Type mandatory check */
                var allocTypeEl = elById('cboAllocType_' + rowId);
                var allocTypeVal = allocTypeEl ? allocTypeEl.value : '';
                if (!allocTypeVal || allocTypeVal === '0' || allocTypeVal === '') {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': Allocation Type Should not be left blank.');
                    _markError(allocTypeEl, true);
                } else { _markError(allocTypeEl, false); }
                /* End of Added by Nikhil Mane on 31-03-2026 */

                /* Allocation % / Hours (fixed column, after Allocation Type)
                   Added by Nikhil Mane on 31-03-2026:
                   When AllocationType = 'HPD' or 'TH' (hours mode) the value is hours,
                   not a percentage — the 100-cap does not apply.
                   When AllocationType = 'P' (or unset) the 0–100 percentage cap applies. */
                var allocVal = val('txtAlloc_' + rowId);
                var alloc = parseFloat(allocVal);
                var allocEl = elById('txtAlloc_' + rowId);
                var isHoursMode = (allocTypeVal === 'HPD' || allocTypeVal === 'TH');
                if (!allocVal || isNaN(alloc)) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_AllocationBlank);
                    _markError(allocEl, true);
                } else if (alloc <= 0) {
                    errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_AllocationZero);
                    _markError(allocEl, true);
                } else { _markError(allocEl, false); }
                /* End of Added by Nikhil Mane on 31-03-2026 */
                if (newFieldsMandatory) {
                    /* 4. Department */
                    var deptEl = document.getElementById('cboDept_' + rowId);
                    if (deptEl && (!deptEl.value || deptEl.value === '0')) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': Department Should not be left blank.');
                        _markError(deptEl, true);
                    } else if (deptEl) { _markError(deptEl, false); }

                    /* 5. Location */
                    var locEl = document.getElementById('cboLoc_' + rowId);
                    if (locEl && (!locEl.value || locEl.value === '0')) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': Location Should not be left blank.');
                        _markError(locEl, true);
                    } else if (locEl) { _markError(locEl, false); }

                    /* 6. Engagement Model */
                    var engEl = document.getElementById('cboEngModel_' + rowId);
                    if (engEl && (!engEl.value || engEl.value === '0')) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': Engagement Model Should not be left blank.');
                        _markError(engEl, true);
                    } else if (engEl) { _markError(engEl, false); }

                    /* 7. Billable Position */
                    var billPosEl = document.getElementById('cboBillPos_' + rowId);
                    if (billPosEl && (!billPosEl.value || billPosEl.value === '0')) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': Billable Position Should not be left blank.');
                        _markError(billPosEl, true);
                    } else if (billPosEl) { _markError(billPosEl, false); }

                    /* 8. Billing Start Date — mandatory only when Billable Position = Yes */
                    if (billPosEl && billPosEl.value && billPosEl.value !== '0') {
                        var _bpText = billPosEl.options[billPosEl.selectedIndex]
                            ? (billPosEl.options[billPosEl.selectedIndex].text || '') : '';
                        var _bpIsYes = (_bpText.toLowerCase().indexOf('yes') !== -1) || (parseInt(billPosEl.value) === 2) || (parseInt(billPosEl.value) === 1);
                        if (_bpIsYes) {
                            var billStartEl = document.getElementById('RRBillingStart_' + rowId);
                            if (!billStartEl || !billStartEl.value.trim()) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': Billing Start Date Should not be left blank.');
                                if (billStartEl) _markError(billStartEl, true);
                            } else { if (billStartEl) _markError(billStartEl, false); }
                        }
                    }

                    /* 9. SOW Available */
                    var sowEl = document.getElementById('cboSOWAvailable_' + rowId);
                    if (sowEl && (!sowEl.value || sowEl.value === '0' || sowEl.value === '')) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': SOW Available Should not be left blank.');
                        _markError(sowEl, true);
                    } else if (sowEl) { _markError(sowEl, false); }

                    /* 10. JD Attachment — only validate when the column is selected/visible.
                       Mirrors the colVisible('jd-attachment') guard in collectRow.
                       Without this guard the check ran even when the jd-attachment column
                       was not in selectedOrder, causing false "blank" errors on rows where
                       the fileJD_ input had just been rebuilt by syncTableColumns.
                       Fixed by Nikhil Mane on 04-04-2026. */
                    var _jdColVisible = (selectedOrder.indexOf('jd-attachment') !== -1);
                    if (_jdColVisible) {
                        var jdInput = document.getElementById('fileJD_' + rowId);
                        var jdPath = jdInput ? (jdInput.getAttribute('data-jd-path') || '').trim() : '';
                        if (!jdPath) {
                            var jdTr = document.querySelector('tr[data-row="' + rowId + '"]');
                            jdPath = jdTr ? (jdTr.getAttribute('data-jd-path') || '').trim() : '';
                        }
                        if (!jdPath) {
                            errors.push('Row ' + _getRowDisplayNum(rowId) + ': JD Attachment Should not be left blank.');
                            if (jdInput) _markError(jdInput, true);
                        } else { if (jdInput) _markError(jdInput, false); }
                    }
                }

                return errors;
            }

            function validateRowFields(rowId) {
                /* Errors in column order: No. of Resources → From Date → To Date → Allocation Type → Allocation % → Billing Start Date */
                var errors = [];
                var newFieldsMandatory = (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory === true);
                function elById(id) { return document.getElementById(id); }
                function val(id) { var e = elById(id); return e ? e.value.trim() : ''; }


                /* Dates */
                var fromStr = val('RRstartdt_' + rowId);
                var toStr = val('RRenddt_' + rowId);
                var fromEl = elById('RRstartdt_' + rowId);
                var toEl = elById('RRenddt_' + rowId);
                var fromDate = _parseRowDate(fromStr);
                var toDate = _parseRowDate(toStr);
                /* Compute today at midnight for past-date comparison */
                var _today = new Date(); _today.setHours(0, 0, 0, 0);
                var _todayStr = _fmtDate(_today);
                /* Billing Start Date — format/range/business-rule checks.
                   Rules:
                     1. Only validated when Billable Position = Yes (text "yes" or value===2/1).
                     2. Must be a valid date.
                     3. Must not be before the row From Date.
                     4. Must be within the project duration (>= projectStartDate, <= projectEndDate).
                     5. Must not be beyond the row To Date (requested end date). */
                var billStr = val('RRBillingStart_' + rowId);
                var billEl = elById('RRBillingStart_' + rowId);
                var _bpEl2 = elById('cboBillPos_' + rowId);
                var _bpIsYes2 = false;
                if (_bpEl2 && _bpEl2.value && _bpEl2.value !== '0') {
                    var _bpText2 = _bpEl2.options[_bpEl2.selectedIndex]
                        ? (_bpEl2.options[_bpEl2.selectedIndex].text || '') : '';
                    _bpIsYes2 = (_bpText2.toLowerCase().indexOf('yes') !== -1) || (parseInt(_bpEl2.value) === 2) || (parseInt(_bpEl2.value) === 1);
                }
                var billTd = billEl ? billEl.closest('td.dyn-td[data-col="billing-start-date"]') : null;
                var billColVisible = billTd && billTd.style.display !== 'none';
                var shouldValidateBilling = _bpIsYes2 || (billColVisible && billStr);
                if (shouldValidateBilling) {
                    if (!billStr) {
                        /* Already caught by validateMandatoryFields when Billable Position = Yes; skip double-error */
                    } else {
                        var billDate = _parseRowDate(billStr);
                        if (!billDate) {
                            errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_BillingStartDateInvalid);
                            _markError(billEl, true);
                        } else {
                            var _billOk = true;
                            /* Rule 3: must not be before From Date */
                            if (fromDate && Date.parse(billStr) < Date.parse(fromStr)) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_BillingStartDateBeforeFromDate.replace('{0}', fromStr));
                                _markError(billEl, true); _billOk = false;
                            }
                            /* Rule 4a: must not be before project start date */
                            if (_billOk && _projectStartDate && Date.parse(billStr) < Date.parse(_fmtDate(_projectStartDate))) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': Billing Start Date must be within the project duration (from ' + _fmtDate(_projectStartDate) + ').');
                                _markError(billEl, true); _billOk = false;
                            }
                            /* Rule 4b: must not be after project end date */
                            if (_billOk && _projectEndDate && Date.parse(billStr) > Date.parse(_fmtDate(_projectEndDate))) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_BillingStartDateAfterProjectEnd.replace('{0}', _fmtDate(_projectEndDate)));
                                _markError(billEl, true); _billOk = false;
                            }
                            /* Rule 5: must not be beyond the requested To Date */
                            if (_billOk && toDate && Date.parse(billStr) > Date.parse(toStr)) {
                                errors.push('Row ' + _getRowDisplayNum(rowId) + ': Billing Start Date must not be beyond the requested To Date (' + toStr + ').');
                                _markError(billEl, true); _billOk = false;
                            }
                            if (_billOk) { _markError(billEl, false); }
                        }
                    }
                }
                if (IsResourcePoolMandatory) {
                    var respoolEl = elById('cboResPool_' + rowId);
                    var respool = val('cboResPool_' + rowId);
                    //var respoolVal = respool ? respool.value : '';
                    if (respool === '0') {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': Resource pool is required.');
                        _markError(respoolEl, true);
                    }
                }
                /* JD Attachment — validate only after date/range checks so messages are sequential.
                 This ensures invalid Billing Start Date is surfaced before JD mandatory message. */
                if (newFieldsMandatory) {
                    var _jdColVisible = (selectedOrder.indexOf('jd-attachment') !== -1);
                    if (_jdColVisible) {
                        var jdInput = document.getElementById('fileJD_' + rowId);
                        var jdPath = jdInput ? (jdInput.getAttribute('data-jd-path') || '').trim() : '';
                        if (!jdPath) {
                            var jdTr = document.querySelector('tr[data-row="' + rowId + '"]');
                            jdPath = jdTr ? (jdTr.getAttribute('data-jd-path') || '').trim() : '';
                        }
                        if (!jdPath) {
                            errors.push('Row ' + _getRowDisplayNum(rowId) + ': JD Attachment Should not be left blank.');
                            _markJDError(rowId, true);
                        } else {
                            _markJDError(rowId, false);
                        }
                    } else {
                        _markJDError(rowId, false);
                    }
                }
                return errors;
            }

            /* ══════════════════════════════════════════════════════════════════
             * validateAllocationLimitsAsync(rowIds, onSuccess, onFail)
             * ──────────────────────────────────────────────────────────────────
             * Mirrors the allocation-limit validation from PM_Resource_Selection.aspx
             * (lines 4709–4819) adapted for the Bulk Request grid.
             *
             * For every rowId in rowIds it validates AllocationPct against the
             * server-side limits for the row's AllocationType by calling the
             * three endpoints already used by PM_RequestedResources:
             *
             *   • GetProjectBalHrs          → TH  : AllocationPct × NoOfResources ≤ ProjectBalHrs
             *   • GetLocationWorkingHours   → HPD : AllocationPct ≤ locationHrs × resourcePct / 100
             *   • GetresourceHrs            → P   : AllocationPct ≤ configuredResourcePct
             *
             * The three project-level values are fetched ONCE in parallel (async: true)
             * for efficiency — they return the same answer for every row in the same project.
             * Once all three requests settle, each row is evaluated synchronously.
             *
             * onSuccess() is called when every row passes all checks.
             * onFail()    is called (no argument) after the first failure; the alertify
             *             error message is already displayed before this callback fires.
             *
             * Added by Nikhil Mane on 03-04-2026
             * ══════════════════════════════════════════════════════════════════ */
            function validateAllocationLimitsAsync(rowIds, onSuccess, onFail) {
                var projID = typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0;

                /* ── Step 1: collect rows that actually need API validation ─────
                   Skip rows where AllocationType is blank or AllocationPct is
                   zero / blank — those are caught by the earlier static checks
                   in validateRowFields, so no point calling the APIs for them. */
                var rowsToCheck = [];
                rowIds.forEach(function (rowId) {
                    var allocTypeEl = document.getElementById('cboAllocType_' + rowId);
                    var allocTypeVal = allocTypeEl ? allocTypeEl.value : '';
                    var allocInputEl = document.getElementById('txtAlloc_' + rowId);
                    var allocVal = allocInputEl ? allocInputEl.value : '';
                    var alloc = parseFloat(allocVal);
                    var noResInputEl = document.getElementById('txtNoOfRes_' + rowId);
                    var noOfRes = parseInt(noResInputEl ? noResInputEl.value : '1') || 1;

                    /* Only validate rows that have a valid, positive AllocationType and value */
                    if (allocTypeVal && allocTypeVal !== '0' && !isNaN(alloc) && alloc > 0) {
                        rowsToCheck.push({
                            rowId: rowId,
                            allocType: allocTypeVal,
                            alloc: alloc,
                            noOfRes: noOfRes,
                            allocEl: allocInputEl
                        });
                    }
                });

                if (rowsToCheck.length === 0) {
                    /* Nothing to validate via API — proceed straight to onSuccess */
                    if (typeof onSuccess === 'function') onSuccess();
                    return;
                }

                /* ── Step 2: fetch the three project-level values in parallel ───
                   All three calls fire simultaneously. onAllFetched() acts as a
                   barrier — row evaluation only starts after all three settle. */
                var paramProj = JSON.stringify({ ProjectID: projID });
                var paramEmpty = JSON.stringify({});

                var projBalHrs = null;   /* GetProjectBalHrs result          */
                var locationHrs = null;   /* GetLocationWorkingHours result   */
                var resourceHrsPct = null;   /* GetresourceHrs result            */
                var fetchErrors = 0;
                var fetchDone = 0;
                var FETCH_COUNT = 3;

                function onAllFetched() {
                    fetchDone++;
                    if (fetchDone < FETCH_COUNT) return;    /* wait for all three to settle */

                    if (fetchErrors === FETCH_COUNT) {
                        /* Every API call failed — cannot validate safely, surface error */
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(RES.E_AllocAPI_Failed);
                        if (typeof onFail === 'function') onFail();
                        return;
                    }

                    /* ── Step 3: validate each row against the fetched limits ───
                       Rules mirror PM_Resource_Selection.aspx lines 4742-4819. */
                    var failMsg = null;
                    var failEl = null;

                    for (var i = 0; i < rowsToCheck.length; i++) {
                        var r = rowsToCheck[i];

                        if (r.allocType === 'TH') {
                            /* Total Hours ──────────────────────────────────────
                               AllocationPct × NoOfResources must NOT exceed the
                               project's remaining balance hours.
                               Mirrors PM_Resource_Selection.aspx lines 4742–4757. */
                            if (projBalHrs !== null && projBalHrs !== '' && projBalHrs !== undefined) {
                                var fltTotalWorkHrs = r.alloc * r.noOfRes;
                                if (parseFloat(projBalHrs) < parseFloat(fltTotalWorkHrs)) {
                                    failMsg = 'Row ' + _getRowDisplayNum(r.rowId) + ': '
                                        + RES.E_AllocTH_ExceedsProjectBal
                                        + ' (' + projBalHrs + ' hrs remaining)';
                                    failEl = r.allocEl;
                                    break;
                                }
                            }

                        } else if (r.allocType === 'HPD') {
                            /* Hours Per Day ────────────────────────────────────
                               AllocationPct must NOT exceed:
                                   locationHrs × resourceHrsPct / 100
                               Mirrors PM_Resource_Selection.aspx lines 4760–4787. */
                            if (locationHrs !== null && resourceHrsPct !== null) {
                                var maxhrs = parseFloat(locationHrs) * parseFloat(resourceHrsPct) / 100;
                                var maxhrsHPD = (maxhrs.toString().indexOf('.') !== -1)
                                    ? maxhrs
                                    : (maxhrs + '.00');
                                if (parseFloat(r.alloc) > parseFloat(maxhrsHPD)) {
                                    failMsg = 'Row ' + _getRowDisplayNum(r.rowId) + ': '
                                        + RES.E_AllocHPD_ExceedsCompanyHrs
                                        + ' (' + maxhrs + ')';
                                    failEl = r.allocEl;
                                    break;
                                }
                            }

                        } else if (r.allocType === 'P') {
                            /* Percentage of Day ────────────────────────────────
                               AllocationPct must NOT exceed the server-configured
                               resource percentage ceiling.
                               NOTE: the static check in validateRowFields already
                               rejects values > 100. This adds the extra server-
                               configured ceiling which may be lower than 100.
                               Mirrors PM_Resource_Selection.aspx lines 4788–4815. */
                            if (resourceHrsPct !== null) {
                                var objResPerP = (resourceHrsPct.toString().indexOf('.') !== -1)
                                    ? resourceHrsPct
                                    : (resourceHrsPct + '.00');
                                if (parseFloat(r.alloc) > parseFloat(objResPerP)) {
                                    failMsg = 'Row ' + _getRowDisplayNum(r.rowId) + ': '
                                        + RES.E_AllocP_ExceedsMaxPct
                                        + ' (' + resourceHrsPct + '%)';
                                    failEl = r.allocEl;
                                    break;
                                }
                            }
                        }
                        /* Other AllocationType values: no server-side cap defined — skip */
                    }

                    if (failMsg) {
                        if (failEl) { _markError(failEl, true); }
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(failMsg);
                        if (typeof onFail === 'function') onFail();
                    } else {
                        if (typeof onSuccess === 'function') onSuccess();
                    }
                }

                /* API call 1 — GetProjectBalHrs
                   Returns remaining budget hours for the project.
                   Used by the TH (Total Hours) rule. */
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetProjectBalHrs',
                    type: 'POST',
                    data: paramProj,
                    async: true,
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, paramProj); },
                    success: function (resp) {

                        projBalHrs = resp?.ProjectBalanceHrsModel[0].projectBalanceHrs ?? 0;

                    },
                    error: function () { fetchErrors++; },
                    complete: function () { onAllFetched(); }
                });

                /* API call 2 — GetLocationWorkingHours
                   Returns the company/location working hours per day for this project.
                   Used by the HPD (Hours Per Day) cap formula. */
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetLocationWorkingHours',
                    type: 'POST',
                    data: paramProj,
                    async: true,
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, paramProj); },
                    success: function (resp) {

                        locationHrs = resp?.LocationWorkHoursModel[0].workingHours ?? 0;

                    },
                    error: function () { fetchErrors++; },
                    complete: function () { onAllFetched(); }
                });

                /* API call 3 — GetresourceHrs
                   Returns the configured max resource allocation % from SEM settings.
                   No body param — matches PM_Resource_Selection.aspx usage exactly.
                   Used by both the HPD cap formula and the P (percentage) rule. */
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetresourceHrs',
                    type: 'POST',
                    data: paramEmpty,
                    async: true,
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr); },
                    success: function (resp) {

                        resourceHrsPct = parseInt(resp?.ResourceAllocationSettingModel[0].settingValue) ?? 100;

                    },
                    error: function () { fetchErrors++; },
                    complete: function () { onAllFetched(); }
                });
            }
            /* End of Added by Nikhil Mane on 03-04-2026 */

            function validateAllRows() {
                var allErrors = [];
                var allSeen = {};
                var firstInvalidRowId = null;
                document.querySelectorAll('#resourceTableBody tr.resource-row').forEach(function (tr) {
                    var rowId = parseInt(tr.getAttribute('data-row'));
                    _clearRowErrors(rowId);
                    validateMandatoryFields(rowId).forEach(function (e) {
                        if (!allSeen[e]) { allSeen[e] = true; allErrors.push(e); }
                    });
                    validateRowFields(rowId).forEach(function (e) {
                        if (!allSeen[e]) { allSeen[e] = true; allErrors.push(e); }
                    });
                    if (firstInvalidRowId === null) {
                        var rowTr = document.querySelector('tr[data-row="' + rowId + '"]');
                        if (rowTr && rowTr.querySelector('.val-error')) {
                            firstInvalidRowId = rowId;
                        }
                    }
                });
                if (allErrors.length > 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error(allErrors[0]);
                    if (firstInvalidRowId !== null) {
                        _focusFirstInvalidField(firstInvalidRowId, { includeSkills: false });
                    }
                    return false;
                }
                return true;
            }

            function validateSkillsForRows(rowIds) {
                var errors = [];
                var skillMandatory = (IsRequestResourceSkillMandatory == 1 || IsRequestResourceSkillMandatory === true);
                var coreCompMandatory = (IsResourceSkillCoreCompetencyMandatory == 1 || IsResourceSkillCoreCompetencyMandatory === true);

                if (!skillMandatory) {
                    return errors;
                }

                var rowsToValidate = rowIds && rowIds.length
                    ? rowIds
                    : Array.prototype.map.call(document.querySelectorAll('#resourceTableBody tr.resource-row'), function (tr) {
                        return parseInt(tr.getAttribute('data-row'));
                    });

                rowsToValidate.forEach(function (rowId) {
                    var tbody = document.getElementById('skill-tbody-' + rowId);
                    var sec = document.getElementById('skill-section-' + rowId);

                    if (!tbody || tbody.querySelectorAll('tr').length === 0) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_SkillRequired);
                        if (sec) sec.classList.add('open');
                        return;
                    }

                    var hasBlankSkill = false;
                    var coreCompetencyCount = 0;
                    var lastSkillEl = null;

                    tbody.querySelectorAll('tr').forEach(function (skillTr) {
                        var parts = skillTr.id.split('_');
                        var counter = parts[parts.length - 1];
                        var skillSel = document.getElementById('cboSkillMaster' + counter);
                        if (!skillSel || !skillSel.value || skillSel.value === '0' || skillSel.value === '') {
                            _markError(skillSel, true);
                            hasBlankSkill = true;
                            if (sec) sec.classList.add('open');
                        } else {
                            _markError(skillSel, false);
                            lastSkillEl = skillSel;
                        }
                        var chk = document.getElementById('CheckCoreCompantency_' + rowId + '_' + counter);
                        if (chk && chk.checked) coreCompetencyCount++;
                    });

                    if (hasBlankSkill) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': ' + RES.E_SkillNameRequired);
                    }
                    _markCoreCompetencyGroup(rowId, false);
                    if (!hasBlankSkill && coreCompMandatory && coreCompetencyCount === 0) {
                        errors.push('Row ' + _getRowDisplayNum(rowId) + ': Please select at least one skill as core competency.');
                        if (sec) sec.classList.add('open');
                        _markCoreCompetencyGroup(rowId, true);
                    }
                });

                if (errors.length > 0) {
                    var firstSkillErrorRow = null;
                    rowsToValidate.forEach(function (rowId) {
                        if (firstSkillErrorRow !== null) return;
                        var sec = document.getElementById('skill-section-' + rowId);
                        if (sec && sec.querySelector('.val-error')) {
                            firstSkillErrorRow = rowId;
                        }
                    });
                    if (firstSkillErrorRow !== null) {
                        _focusFirstInvalidField(firstSkillErrorRow, { includeSkills: true });
                    }
                }

                return errors;
            }

            function validateSkillsForSubmit() {
                return validateSkillsForRows();
            }

            function loadBulkRequest() {
                var param = JSON.stringify({ ProjectID: SessionProjectID, UserID: SessionUserID });
                showLoader();
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetByUserProject',
                    type: 'POST', data: param, dataType: 'json', contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        /* ── Payload detection ──────────────────────────────────────────
                           Fixed by Nikhil Mane on 03-04-2026:
                           The original guard required response.data.header to be truthy,
                           which meant a response like { header: null, columns: [...] }
                           (no active draft, but column prefs saved) was never captured —
                           payload stayed null and payload.columns was never read.
                           We now also accept a payload that has columns even when header
                           is null so that GetByUserProject column data is always applied. */
                        var payload = null;
                        if (response && response.data) {
                            if (response.data.data &&
                                (response.data.data.header || response.data.data.columns)) {
                                payload = response.data.data;
                            } else if (response.data.header || response.data.columns) {
                                payload = response.data;
                            }
                        }
                        /* ── Column processing — MUST run BEFORE the early-return guard ──
                           GetByUserProject always returns payload.columns (RS4) with the
                           saved column preferences for this project+user, even when there
                           is no active draft (header = null / bulkRequestID = 0).
                           Moving this block above the early-return ensures the tag bar,
                           dropdown, and table columns always reflect the server state on
                           every page load or post-submit reset.

                           Resolve logic:
                             1. Sort by columnOrder ASC.
                             2. Match each entry to ALL_COLS by columnID first, then columnName.
                             3. applicable=true  -> selectedOrder
                                applicable=false -> unselectedKeys
                             4. Any ALL_COLS entry not mentioned at all -> unselectedKeys.

                           If payload.columns is empty, selectedOrder / unselectedKeys from
                           loadColumnPreference() are kept as-is.

                           Updated by Nikhil Mane on 03-04-2026 — moved above early-return. */
                        var apiCols = (payload && payload.columns) ? payload.columns : [];
                        if (apiCols.length > 0) {
                            var sortedApiCols = apiCols.slice().sort(function (a, b) {
                                return (a.columnOrder || 0) - (b.columnOrder || 0);
                            });
                            selectedOrder = [];
                            unselectedKeys = [];
                            sortedApiCols.forEach(function (col) {
                                var match = null;
                                if (col.columnID) {
                                    match = ALL_COLS.find(function (c) { return c.id === col.columnID; });
                                }
                                if (!match && col.columnName) {
                                    match = ALL_COLS.find(function (c) { return c.key === col.columnName; });
                                }
                                if (!match) return;
                                /* Guard: applicable may arrive as boolean or 1/0 integer */
                                if (col.applicable === true || col.applicable === 1) {
                                    if (selectedOrder.indexOf(match.key) === -1) selectedOrder.push(match.key);
                                } else {
                                    if (unselectedKeys.indexOf(match.key) === -1) unselectedKeys.push(match.key);
                                }
                            });
                            /* Any ALL_COLS entry not mentioned in payload.columns -> unselected */
                            ALL_COLS.forEach(function (c) {
                                if (selectedOrder.indexOf(c.key) === -1 && unselectedKeys.indexOf(c.key) === -1) {
                                    unselectedKeys.push(c.key);
                                }
                            });
                            /* nature-of-request: UI-only — always force into selectedOrder */
                            (function () {
                                var norKey = 'nature-of-request';
                                unselectedKeys = unselectedKeys.filter(function (k) { return k !== norKey; });
                                if (selectedOrder.indexOf(norKey) === -1) selectedOrder.push(norKey);
                            }());
                        }
                        /* ── End column processing ── */

                        /* ── Mandatory-column enforcement after GetByUserProject ──────────
                         * After the column state has been rebuilt from payload.columns,
                         * re-enforce all mandatory columns so they are always present in
                         * selectedOrder regardless of what the DB saved.
                         *
                         * Two independent sources of mandatory status (mirrors _isColMandatory):
                         *   1. IsResourceRequestNewFieldsManatory = 1  →  MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY
                         *   2. IsResourcePoolMandatory = 1              →  'resource-pool'
                         *   3. 'nature-of-request'                      →  always locked (UI-only)
                         *
                         * For each mandatory key:
                         *   a. Remove from unselectedKeys (if present).
                         *   b. Push to selectedOrder (if not already there) so the column
                         *      header, tag pill, and dropdown checkbox are all in sync.
                         *
                         * Added by Nikhil Mane on 04-04-2026
                         * ────────────────────────────────────────────────────────────────── */
                        (function _enforceMandatoryColsAfterGetByUserProject() {
                            var mandatoryKeys = [];

                            /* Source 1 — IsResourceRequestNewFieldsManatory */
                            var _newFieldsMand = (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory === true);
                            if (_newFieldsMand) {
                                MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY.forEach(function (k) {
                                    if (mandatoryKeys.indexOf(k) === -1) mandatoryKeys.push(k);
                                });
                            }

                            /* Source 2 — IsResourcePoolMandatory */
                            if (IsResourcePoolMandatory == 1) {
                                if (mandatoryKeys.indexOf('resource-pool') === -1) mandatoryKeys.push('resource-pool');
                            }

                            /* Source 3 — nature-of-request is always locked */
                            if (mandatoryKeys.indexOf('nature-of-request') === -1) mandatoryKeys.push('nature-of-request');

                            /* For every mandatory key that exists in ALL_COLS,
                               move it from unselectedKeys → selectedOrder if not already there */
                            mandatoryKeys.forEach(function (k) {
                                /* Confirm the column exists in ALL_COLS (safety guard) */
                                var colExists = ALL_COLS.find(function (c) { return c.key === k; });
                                if (!colExists) return;

                                /* Remove from unselected */
                                unselectedKeys = unselectedKeys.filter(function (uk) { return uk !== k; });

                                /* Add to selected if missing */
                                if (selectedOrder.indexOf(k) === -1) {
                                    selectedOrder.push(k);
                                }
                            });
                        }());
                        /* ── End mandatory-column enforcement ── */

                        /* Early return: no active draft — render updated column state and
                           add a blank row so the user can start a new request.
                           syncTableColumns / renderDropdown / renderTagBar are called here
                           (not skipped as before) so the column picker and tag bar always
                           reflect the columns just derived from payload.columns above.
                           Fixed by Nikhil Mane on 03-04-2026. */
                        if (!payload || !payload.header || !payload.header.bulkRequestID) {
                            syncTableColumns();
                            renderDropdown();
                            renderTagBar();
                            window._loadDraftInProgress = true; addRow(); window._loadDraftInProgress = false;
                            return;
                        }
                        _currentBulkRequestID = payload.header.bulkRequestID || 0;
                        var rows = payload.rows || [], skills = payload.skills || [];

                        document.getElementById('resourceTableBody').innerHTML = '';
                        _rowCount = 0; skillCounters = {};
                        /* Fixed by Nikhil Mane on 03-04-2026: when there is an active
                           bulkRequestID but no saved rows yet, sync the column UI before
                           adding the first blank row so the table header and tag bar are
                           consistent with the columns just loaded from payload.columns. */
                        if (rows.length === 0) {
                            syncTableColumns();
                            renderDropdown();
                            renderTagBar();
                            window._loadDraftInProgress = true; addRow(); window._loadDraftInProgress = false;
                            return;
                        }
                        // Added by Nikhil Mane on 30-03-2026 — bypass row-limit guard while
                        // restoring a saved draft so that existing rows (saved before the limit
                        // was configured, or while the limit was higher) can always be reloaded
                        // without hitting the cap.  The button state is corrected below after
                        // all rows are restored.
                        window._skipRowLimitCheck = true;
                        window._loadDraftInProgress = true;
                        rows.forEach(function (r) {
                            addRow(); var rowId = _rowCount;
                            var tr = document.querySelector('tr[data-row="' + rowId + '"]');
                            if (tr && r.rowID) tr.setAttribute('data-row-db-id', r.rowID);
                            var typeOfReqVal = r.typeOfRequirement || 0;
                            /* Set without jQuery .val() — that fires change and re-runs
                               onTypeOfReqChange_row, starting a second GetActiveResources call
                               with no saved employee id and leaving "Loading…" in select2. */
                            var typeOfReqEl = document.getElementById('cboTypeOfReq_' + rowId);
                            if (typeOfReqEl) typeOfReqEl.value = String(typeOfReqVal);
                            if (parseInt(typeOfReqVal) === 2) {
                                /* Fixed by Nikhil Mane on 04-04-2026 — the replacement row was
                                   previously marked 'open' synchronously, BEFORE the async
                                   loadReplacementResources_row AJAX completed.  This caused a race
                                   condition: if the user clicked Add More / Save Draft / Submit while
                                   employees were still loading, validateMandatoryFields would see
                                   repRowOpen=true but repEl.value="" (the "Loading…" placeholder),
                                   triggering a false "Please select an Employee to replace" error.
                                   Fix: mirror the pattern used in onTypeOfReqChange_row — only add
                                   'open' inside the onDone callback, after employees are loaded. */
                                var _savedRepRowId = rowId;
                                var _savedRepId = r.replacementResourceID || 0;
                                loadReplacementResources_row(_savedRepRowId, _savedRepId, function (hasEmployees) {
                                    if (hasEmployees) {
                                        var repRow = document.getElementById('replacement-row-' + _savedRepRowId);
                                        if (repRow) repRow.classList.add('open');
                                    }
                                });
                                /* End of Fixed by Nikhil Mane on 04-04-2026 */
                            }
                            if (r.sowAvailable === 'Yes') {
                                $('#cboSOWAvailable_' + rowId).val('Yes');
                            }
                            else if (r.sowAvailable === 'No') {
                                $('#cboSOWAvailable_' + rowId).val('No');
                            } else {
                                $('#cboSOWAvailable_' + rowId).val('');
                            }
                            /* Recompute Nature of Request after all date/SOW values are restored */
                            $('#cboProjectRole_' + rowId).val(r.projectRole || '0');
                            $('#txtNoOfRes_' + rowId).val(r.noOfResources || 0);
                            $('#RRstartdt_' + rowId).val(r.fromDate || '');
                            $('#RRenddt_' + rowId).val(r.toDate || '');
                            /* Added by Nikhil Mane on 31-03-2026 — restore AllocationType and sync suffix label */
                            var _allocTypeVal = r.allocationType || r.AllocationType || '';
                            $('#cboAllocType_' + rowId).val(_allocTypeVal || '0');
                            onAllocTypeChange_row(rowId, _allocTypeVal);
                            /* End of Added by Nikhil Mane on 31-03-2026 */
                            $('#txtAlloc_' + rowId).val(r.allocationPct || 0);
                            $('#cboDept_' + rowId).val(r.department || '0');
                            $('#cboResPool_' + rowId).val(r.resourcePool || '0');
                            $('#cboLoc_' + rowId).val(r.location || '0');
                            $('#cboEngModel_' + rowId).val(r.engagementModel || '0');
                            $('#cboPriority_' + rowId).val(r.priority || '0');
                            $('#cboBillPos_' + rowId).val(r.billablePosition || '0');
                            /* Restore saved billing date directly to the field */
                            var _bsRestored = r.billingStartDate || '';
                            $('#RRBillingStart_' + rowId).val(_bsRestored);
                            /* Apply only the enabled/disabled UI state based on restored Billable Position.
                               We do NOT call _applyBillingStartDateState here because that function
                               clears the field when isYes=false and auto-sets when isYes=true —
                               both of which would overwrite the value we just restored from the DB. */
                            (function (rId, bpVal) {
                                var billPosEl = document.getElementById('cboBillPos_' + rId);
                                var billEl = document.getElementById('RRBillingStart_' + rId);
                                var billBtn = billEl ? billEl.closest('.datefielddiv').querySelector('.btncalendar') : null;
                                if (!billEl) return;
                                var isYes = false;
                                if (billPosEl && bpVal && bpVal !== '0' && bpVal !== '') {
                                    var selText = billPosEl.options[billPosEl.selectedIndex]
                                        ? (billPosEl.options[billPosEl.selectedIndex].text || '') : '';
                                    isYes = (selText.toLowerCase().indexOf('yes') !== -1) ||
                                        (parseInt(bpVal) === 2) || (parseInt(bpVal) === 1);
                                }
                                if (isYes) {
                                    billEl.removeAttribute('disabled');
                                    billEl.style.background = '#fff';
                                    billEl.style.cursor = 'text';
                                    if (billBtn) { billBtn.removeAttribute('disabled'); billBtn.style.cursor = 'pointer'; billBtn.style.opacity = '1'; }
                                } else {
                                    billEl.setAttribute('disabled', 'disabled');
                                    billEl.style.background = '#f3f4f6';
                                    billEl.style.cursor = 'not-allowed';
                                    if (billBtn) { billBtn.setAttribute('disabled', 'disabled'); billBtn.style.cursor = 'not-allowed'; billBtn.style.opacity = '0.5'; }
                                }
                            }(rowId, r.billablePosition || '0'));

                            if ((r.requestID || r.RequestID) && tr) tr.setAttribute('data-request-id', r.requestID || r.RequestID);
                            /* Added by Nikhil Mane on 31-03-2026 — restore Special Request */
                            var _specReqVal = r.specialRequest || r.SpecialRequest || '';
                            if (_specReqVal) {
                                var _specReqEl = document.getElementById('txtSpecialReq_' + rowId);
                                if (_specReqEl) _specReqEl.value = _specReqVal;
                            }
                            /* End of Added by Nikhil Mane on 31-03-2026 */
                            /* Recompute Nature of Request now that SOW Available and Billing Start Date are restored */
                            computeNatureOfRequest(rowId);
                            /* ── select2: after all $.val() calls, trigger change so select2
                               updates the displayed text in each enhanced dropdown.
                               initRowSelect2 has not run yet (called after all rows are built)
                               so this is a no-op at this point — select2 is initialised in the
                               final syncTableColumns block below. The trigger is deferred to
                               that point via the global initRowSelect2 call.
                               Added by Nikhil Mane on 04-04-2026 — comment only; actual
                               select2 refresh done in the post-restore initRowSelect2 call. */
                            var dbRowId = r.rowID || 0;
                            var rowSkills = skills.filter(function (s) {
                                return Number(s.rowID) === Number(dbRowId);
                            });
                            /* JD cell is rendered after the final syncTableColumns call below.
                               Also set data-jd-path directly on the TR so validateMandatoryFields
                               can read it immediately — it reads data-jd-path, not data-jd-path-pending.
                               Fixed by Nikhil Mane on 04-04-2026. */
                            if (r.jdAttachmentPath || r.JDAttachmentPath) {
                                var _jdPath = r.jdAttachmentPath || r.JDAttachmentPath;
                                var _tr = document.querySelector('tr[data-row="' + rowId + '"]');
                                if (_tr) {
                                    _tr.setAttribute('data-jd-path', _jdPath);
                                    _tr.setAttribute('data-jd-path-pending', _jdPath);
                                }
                            }
                            if (rowSkills.length > 0) {
                                var sec = document.getElementById('skill-section-' + rowId);
                                if (sec) sec.classList.add('open');
                                rowSkills.forEach(function (s) {
                                    addSkillRow(rowId);
                                    var arr = skillCounters[rowId] || [];
                                    var counter = arr[arr.length - 1];
                                    if (counter === undefined) return;
                                    var skillTr = document.getElementById('R_' + rowId + '_' + counter);
                                    if (skillTr && s.skillRequestID) skillTr.setAttribute('data-skill-db-id', s.skillRequestID);
                                    $('#cboSkillMaster' + counter).val(s.skillName || '0');
                                    $('#cboMonth' + counter).val(s.experienceYear || '0');
                                    $('#cboYear' + counter).val(s.experienceMonth || '0');
                                    $('#cboParameters' + counter).val(s.proficiency || '0');
                                    var chk = document.getElementById('CheckCoreCompantency_' + rowId + '_' + counter);
                                    if (chk) chk.checked = !!s.coreCompetency;
                                });
                            }
                        });
                        // Added by Nikhil Mane on 30-03-2026 — restore limit enforcement now that
                        // all draft rows have been reloaded.  updateAddMoreButtonState() will disable
                        // Add More if the restored row count already meets or exceeds the limit.
                        window._skipRowLimitCheck = false;
                        window._loadDraftInProgress = false;
                        updateAddMoreButtonState();
                        /* ── If no edit access, lock all restored row inputs ── */
                        if (!addAccess) {
                            document.querySelectorAll('#resourceTableBody input, #resourceTableBody select, #resourceTableBody textarea, #resourceTableBody button.btncalendar').forEach(function (el) {
                                el.setAttribute('disabled', 'disabled');
                                el.style.background = '#f3f4f6';
                                el.style.cursor = 'not-allowed';
                                el.style.pointerEvents = 'none';
                            });
                            /* Also lock skill section inputs */
                            document.querySelectorAll('.skill-section-inner input, .skill-section-inner select').forEach(function (el) {
                                el.setAttribute('disabled', 'disabled');
                                el.style.background = '#f3f4f6';
                                el.style.cursor = 'not-allowed';
                            });
                        }
                        /* Updated by Nikhil Mane on 01-04-2026:
                           selectedOrder / unselectedKeys were updated above from payload.columns
                           (or kept from loadColumnPreference() if RS4 was empty).
                           Single syncTableColumns() call after ALL rows are built so the
                           full DOM is in place for one efficient pass.
                           renderDropdown / renderTagBar follow to sync the picker and tag bar. */
                        /* Recompute Nature of Request for every row after full restore */
                        document.querySelectorAll('#resourceTableBody tr.resource-row').forEach(function (tr) {
                            computeNatureOfRequest(parseInt(tr.getAttribute('data-row')));
                        });
                        syncTableColumns();
                        renderDropdown();
                        renderTagBar();
                        /* Render pending JD file links now that the jd-attachment column is visible */
                        document.querySelectorAll('#resourceTableBody tr.resource-row').forEach(function (tr) {
                            var pending = tr.getAttribute('data-jd-path-pending');
                            if (pending) {
                                renderJDAttachmentCell(parseInt(tr.getAttribute('data-row')), pending);
                                tr.removeAttribute('data-jd-path-pending');
                            }
                        });
                        /* ── Select2: initialise searchable dropdowns on all restored rows ──
                           Run once after all rows + skill sections are fully in the DOM.
                           Added by Nikhil Mane on 04-04-2026 */
                        var _restoreBody = document.getElementById('resourceTableBody');
                        if (_restoreBody) {
                            initRowSelect2(_restoreBody);
                            /* Sync select2 display for restored fields — skip Type of Requirement
                               (fires onTypeOfReqChange_row) and replacement employee (loaded async). */
                            $(_restoreBody).find('select').each(function () {
                                var sid = this.id || '';
                                if (sid.indexOf('cboTypeOfReq_') === 0 || sid.indexOf('cboRepResource_') === 0) return;
                                var $s = $(this);
                                if ($s.data('select2')) $s.val(this.value).trigger('change.select2');
                            });
                            /* Type of Requirement: update select2 label only, no change handler */
                            $(_restoreBody).find('select[id^="cboTypeOfReq_"]').each(function () {
                                var $t = $(this);
                                if ($t.data('select2')) $t.val(this.value);
                            });
                        }
                        window._loadDraftInProgress = false;
                    },
                    error: function () { window._loadDraftInProgress = true; addRow(); window._loadDraftInProgress = false; },
                    complete: function () { hideLoader(); }
                });
            }

            /* ── Init ── */
            /* ══════════════════════════════════════════════════════════════════
             * loadColumnMaster(onComplete)
             * ──────────────────────────────────────────────────────────────────
             * Step 1 of 2 in the column init chain.
             * Calls usp_PM_BulkRequest_GetColumnMaster to build ALL_COLS from DB.
             * On success fires loadColumnPreference(onComplete) as step 2.
             * On failure falls back to FALLBACK_COLS and calls applyDefaultColumns().
             *
             * Updated by Nikhil Mane on 01-04-2026:
             *   Column preferences are now PROJECT-SPECIFIC. After building ALL_COLS
             *   we ALWAYS call loadColumnPreference() to fetch the saved prefs for
             *   the CURRENT project. loadColumnPreference then decides whether to
             *   restore saved prefs or fall back to defaults (no columns selected +
             *   mandatory columns when configured).
             * ══════════════════════════════════════════════════════════════════ */
            function loadColumnMaster(onComplete) {
                var param = JSON.stringify({});
                showLoader();
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetColumnMaster',
                    type: 'POST',
                    data: param,
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr); },
                    success: function (response) {
                        try {
                            /* Unwrap W26 ResponseHelper */
                            var rows = null;
                            if (response && response.data && Array.isArray(response.data.data)) {
                                rows = response.data.data;
                            } else if (response && Array.isArray(response.data)) {
                                rows = response.data;
                            } else if (Array.isArray(response)) {
                                rows = response;
                            }
                            ALL_COLS = (rows && rows.length > 0)
                                ? rows.map(function (r) {
                                    return {
                                        id: r.columnID || r.ColumnID,
                                        key: r.columnKey || r.ColumnKey,
                                        label: r.columnLabel || r.ColumnLabel
                                    };
                                })
                                : FALLBACK_COLS.slice();
                            /* Always normalise the nature-of-request label regardless of what
                               the DB returns — some environments store the key as the label. */
                            var _norCol = ALL_COLS.find(function (c) { return c.key === 'nature-of-request'; });
                            if (_norCol) _norCol.label = 'Nature of Request';
                        } catch (e) {
                            ALL_COLS = FALLBACK_COLS.slice();
                        }
                        /* Step 2: load project-specific column preferences */
                        loadColumnPreference(onComplete);
                    },
                    error: function () {
                        ALL_COLS = FALLBACK_COLS.slice();
                        /* Normalise nature-of-request label in fallback too */
                        var _norCol2 = ALL_COLS.find(function (c) { return c.key === 'nature-of-request'; });
                        if (_norCol2) _norCol2.label = 'Nature of Request';
                        /* Still try to load prefs even if column master failed */
                        loadColumnPreference(onComplete);
                    },
                    complete: function () { hideLoader(); }
                });
            }

            /* ══════════════════════════════════════════════════════════════════
             * loadColumnPreference(onComplete)
             * ──────────────────────────────────────────────────────────────────
             * Step 2 of 2 in the column init chain.
             * Calls GetColumnPreference to fetch saved column preferences for the
             * CURRENT project + user from tbl_PM_BulkRequestColumnPreference.
             *
             * DESIGN — Column preferences are PROJECT-SPECIFIC:
             *   • Saved prefs exist for this project
             *       → restore selectedOrder from saved data, then add remaining
             *         columns (including mandatory ones not yet in selectedOrder)
             *         as unselected.
             *
             *   • No saved prefs (new project / first visit)
             *       → apply defaults:
             *           – no columns selected (all into unselectedKeys)
             *           – if IsResourceRequestNewFieldsManatory=1, auto-select
             *             MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY and persist them.
             *
             * This means switching to a different project always loads THAT
             * project's own column state, never bleed from another project.
             *
             * Added by Nikhil Mane on 01-04-2026
             * ══════════════════════════════════════════════════════════════════ */
            function loadColumnPreference(onComplete) {
                var param = JSON.stringify({
                    ProjectID: typeof SessionProjectID !== 'undefined' ? SessionProjectID : 0,
                    UserID: typeof SessionUserID !== 'undefined' ? SessionUserID : 0
                });
                $.ajax({
                    url: strUrl + '/api/PM_BulkResourceReq/GetColumnPreference',
                    type: 'POST',
                    data: param,
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    beforeSend: function (xhr) { buildAuthHeaders(xhr, param); },
                    success: function (response) {
                        try {
                            /* ── Unwrap response — handle all W26 wrapper shapes ── */
                            var prefs = null;
                            if (response && response.data && Array.isArray(response.data.data)) {
                                prefs = response.data.data;
                            } else if (response && Array.isArray(response.data)) {
                                prefs = response.data;
                            } else if (Array.isArray(response)) {
                                prefs = response;
                            }

                            var newFieldsMandatory = (IsResourceRequestNewFieldsManatory == 1 ||
                                IsResourceRequestNewFieldsManatory === true);

                            if (prefs && prefs.length > 0) {
                                /* ── Saved prefs exist — restore exact order from columnOrder ──
                                   Updated by Nikhil Mane on 01-04-2026:
                                   Sort by columnOrder ASC first so DB order is always honoured,
                                   regardless of the order the server returns rows.
                                   We NO LONGER pre-push mandatory columns before iterating —
                                   that was corrupting the saved order by forcing mandatory cols
                                   to the front even when the user had placed them elsewhere.
                                   Mandatory columns are enforced at the SAVE side (SaveColumnPreference)
                                   and at the checkbox-disable side (makeRow). On LOAD we simply
                                   trust the saved columnOrder values. */
                                selectedOrder = [];
                                unselectedKeys = [];

                                /* Sort by columnOrder ascending — defensive guard */
                                var sortedPrefs = prefs.slice().sort(function (a, b) {
                                    return (a.columnOrder || 0) - (b.columnOrder || 0);
                                });

                                /* Walk sorted prefs: resolve each against ALL_COLS,
                                   split into selected (applicable=true) vs unselected */
                                sortedPrefs.forEach(function (p) {
                                    var match = null;
                                    /* Prefer match by columnID (stable integer key) */
                                    if (p.columnID) {
                                        match = ALL_COLS.find(function (c) { return c.id === p.columnID; });
                                    }
                                    /* Fall back to columnName string match */
                                    if (!match && p.columnName) {
                                        match = ALL_COLS.find(function (c) { return c.key === p.columnName; });
                                    }
                                    if (!match) return; /* column not in master — skip */

                                    if (p.applicable) {
                                        if (selectedOrder.indexOf(match.key) === -1) {
                                            selectedOrder.push(match.key);
                                        }
                                    } else {
                                        if (unselectedKeys.indexOf(match.key) === -1) {
                                            unselectedKeys.push(match.key);
                                        }
                                    }
                                });

                                /* Any ALL_COLS entry not mentioned by prefs at all goes to unselected */
                                ALL_COLS.forEach(function (c) {
                                    if (selectedOrder.indexOf(c.key) === -1 &&
                                        unselectedKeys.indexOf(c.key) === -1) {
                                        unselectedKeys.push(c.key);
                                    }
                                });

                                /* Added by Nikhil Mane on 02-04-2026 ─────────────────────────────
                                 * Even when restoring saved column prefs, if the RESOURCEPOOLMANDATORY
                                 * setting is now 1, force 'resource-pool' into selectedOrder.
                                 * This handles the case where a user saved prefs before the setting
                                 * was enabled — on next page load the column will auto-appear. */
                                if (IsResourcePoolMandatory == 1) {
                                    var rpKey = 'resource-pool';
                                    if (selectedOrder.indexOf(rpKey) === -1) {
                                        unselectedKeys = unselectedKeys.filter(function (k) { return k !== rpKey; });
                                        selectedOrder.push(rpKey);
                                    }
                                }
                                /* End of Added by Nikhil Mane on 02-04-2026 */

                            } else {
                                /* ── No saved prefs for this project — apply defaults ── */
                                selectedOrder = [];
                                unselectedKeys = [];

                                if (newFieldsMandatory) {
                                    /* Auto-select mandatory columns in their defined order */
                                    MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY.forEach(function (mandatoryKey) {
                                        var colExists = ALL_COLS.find(function (c) { return c.key === mandatoryKey; });
                                        if (colExists) selectedOrder.push(mandatoryKey);
                                    });
                                    ALL_COLS.forEach(function (c) {
                                        if (selectedOrder.indexOf(c.key) === -1) unselectedKeys.push(c.key);
                                    });
                                } else {
                                    /* All columns start unselected */
                                    unselectedKeys = ALL_COLS.map(function (c) { return c.key; });
                                }

                                /* Added by Nikhil Mane on 02-04-2026 ─────────────────────────────
                                 * Regardless of newFieldsMandatory, if RESOURCEPOOLMANDATORY = 1
                                 * force 'resource-pool' into selectedOrder (move from unselected
                                 * if present there). Runs after both sub-branches above so the
                                 * column is always in the grid when the setting is active. */
                                if (IsResourcePoolMandatory == 1) {
                                    var rpKey = 'resource-pool';
                                    var rpExists = ALL_COLS.find(function (c) { return c.key === rpKey; });
                                    if (rpExists && selectedOrder.indexOf(rpKey) === -1) {
                                        unselectedKeys = unselectedKeys.filter(function (k) { return k !== rpKey; });
                                        selectedOrder.push(rpKey);
                                    }
                                }
                                /* End of Added by Nikhil Mane on 02-04-2026 */
                            }
                        } catch (e) {
                            /* Fallback: all unselected */
                            selectedOrder = [];
                            unselectedKeys = ALL_COLS.map(function (c) { return c.key; });
                        }
                        /* Always ensure nature-of-request is in selectedOrder on page load.
                           It is a permanent column — always visible, readonly, auto-computed.
                           If it was somehow left in unselectedKeys, move it to selectedOrder. */
                        (function () {
                            var norKey = 'nature-of-request';
                            if (selectedOrder.indexOf(norKey) === -1) {
                                unselectedKeys = unselectedKeys.filter(function (k) { return k !== norKey; });
                                selectedOrder.push(norKey);
                            }
                        }());
                        if (onComplete) onComplete();
                    },
                    error: function () {
                        /* On error fall back to defaults (same as new-project path) */
                        var newFieldsMandatory = (IsResourceRequestNewFieldsManatory == 1 ||
                            IsResourceRequestNewFieldsManatory === true);
                        selectedOrder = [];
                        unselectedKeys = [];
                        if (newFieldsMandatory) {
                            MANDATORY_COLS_WHEN_NEWFIELDS_MANDATORY.forEach(function (mandatoryKey) {
                                var colExists = ALL_COLS.find(function (c) { return c.key === mandatoryKey; });
                                if (colExists) selectedOrder.push(mandatoryKey);
                            });
                            ALL_COLS.forEach(function (c) {
                                if (selectedOrder.indexOf(c.key) === -1) unselectedKeys.push(c.key);
                            });
                        } else {
                            unselectedKeys = ALL_COLS.map(function (c) { return c.key; });
                        }
                        /* Added by Nikhil Mane on 02-04-2026 — same resource-pool enforcement
                           as the success path so a transient API error never leaves the column
                           de-selected when IsResourcePoolMandatory = 1. */
                        if (IsResourcePoolMandatory == 1) {
                            var rpKey = 'resource-pool';
                            var rpExists = ALL_COLS.find(function (c) { return c.key === rpKey; });
                            if (rpExists && selectedOrder.indexOf(rpKey) === -1) {
                                unselectedKeys = unselectedKeys.filter(function (k) { return k !== rpKey; });
                                selectedOrder.push(rpKey);
                            }
                        }
                        /* End of Added by Nikhil Mane on 02-04-2026 */
                        /* Always ensure nature-of-request is selected */
                        (function () {
                            var norKey = 'nature-of-request';
                            if (selectedOrder.indexOf(norKey) === -1) {
                                unselectedKeys = unselectedKeys.filter(function (k) { return k !== norKey; });
                                selectedOrder.push(norKey);
                            }
                        }());
                        if (onComplete) onComplete();
                    }
                });
            }

            window.addEventListener('DOMContentLoaded', function () {
                var chevBtn = document.getElementById('tagBarChevronBtn');
                if (chevBtn) chevBtn.addEventListener('click', function (e) {
                    e.stopPropagation(); e.preventDefault();
                    if (_ddOpen) _colDDClose(); else _colDDOpen();
                });

                /* ── select2 → native onchange bridge ────────────────────────────────
                   select2 fires a jQuery 'change' event but NOT the native DOM 'change'
                   event that inline onchange="..." attributes listen on.
                   This delegated handler re-fires a native change event so that all
                   existing onchange handlers (onTypeOfReqChange_row, onAllocTypeChange_row,
                   onBillablePosChange_row, onSOWAvailableChange_row etc.) keep working
                   when the user picks a value via the select2 search dropdown.
                   Added by Nikhil Mane on 04-04-2026 */
                $(document).on('select2:select select2:unselect select2:clear', '#resourceTableBody select, .skill-section-row select', function () {
                    var nativeEvt = document.createEvent('HTMLEvents');
                    nativeEvt.initEvent('change', true, true);
                    this.dispatchEvent(nativeEvt);
                });
                /* End of Added by Nikhil Mane on 04-04-2026 */

                /* ── Delegated digit-only enforcement for No. of Resources & Allocation % ──
                   Replaces inline onkeydown/oninput/onpaste attributes so it works reliably
                   even when rows are added dynamically via innerHTML.               */
                var tBody = document.getElementById('resourceTableBody');
                if (tBody) {
                    /* keydown — block non-digit keys */
                    tBody.addEventListener('keydown', function (e) {
                        var el = e.target;
                        if (!el || (el.id.indexOf('txtNoOfRes_') === -1 && el.id.indexOf('txtAlloc_') === -1)) return;
                        var controlKeys = [8, 9, 13, 27, 46]; /* Backspace, Tab, Enter, Esc, Delete */
                        if (controlKeys.indexOf(e.keyCode) !== -1) return;
                        if ((e.ctrlKey || e.metaKey) && [65, 67, 86, 88].indexOf(e.keyCode) !== -1) return; /* Ctrl+A/C/V/X */
                        if (e.keyCode >= 35 && e.keyCode <= 40) return; /* Arrow / Home / End */
                        if (e.keyCode >= 48 && e.keyCode <= 57) return; /* 0-9 main keyboard */
                        if (e.keyCode >= 96 && e.keyCode <= 105) return; /* 0-9 numpad */
                        /* Added by Nikhil Mane on 31-03-2026 — allow decimal point for txtAlloc in hours mode */
                        if (el.id.indexOf('txtAlloc_') !== -1) {
                            var _rId = el.id.replace('txtAlloc_', '');
                            var _atEl = document.getElementById('cboAllocType_' + _rId);
                            var _atVal = _atEl ? _atEl.value : '';
                            if ((_atVal === 'HPD' || _atVal === 'TH') && (e.keyCode === 190 || e.keyCode === 110)) return;
                        }
                        /* End of Added by Nikhil Mane on 31-03-2026 */
                        e.preventDefault(); /* block letters, symbols, minus, dot, space */
                    });

                    /* input — strip any non-digit that slipped through (IME, autofill, drag-drop).
                       Do NOT silently clamp to max — allow the value to exceed the limit so the
                       user can see it, then blur-validation or button-click validation fires an error. */
                    tBody.addEventListener('input', function (e) {
                        var el = e.target;
                        if (el.id.indexOf('txtNoOfRes_') === -1 && el.id.indexOf('txtAlloc_') === -1) return;
                        /* Added by Nikhil Mane on 31-03-2026 — allow decimal for txtAlloc in hours mode */
                        if (el.id.indexOf('txtAlloc_') !== -1) {
                            var _rId2 = el.id.replace('txtAlloc_', '');
                            var _atEl2 = document.getElementById('cboAllocType_' + _rId2);
                            var _atVal2 = _atEl2 ? _atEl2.value : '';
                            if (_atVal2 === 'HPD' || _atVal2 === 'TH') {
                                var raw2 = el.value.replace(/[^0-9.]/g, '');
                                var pts = raw2.split('.');
                                if (pts.length > 2) raw2 = pts[0] + '.' + pts.slice(1).join('');
                                if (raw2 !== el.value) el.value = raw2;
                                return;
                            }
                        }
                        /* End of Added by Nikhil Mane on 31-03-2026 */
                        /* Strip non-digits only (no clamping) */
                        var raw = el.value.replace(/[^0-9]/g, '');
                        if (raw !== el.value) el.value = raw;
                    });

                    /* paste — strip non-digits from pasted text. No silent clamping. */
                    tBody.addEventListener('paste', function (e) {
                        var el = e.target;
                        if (el.id.indexOf('txtNoOfRes_') === -1 && el.id.indexOf('txtAlloc_') === -1) return;
                        e.preventDefault();
                        var pasted = (e.clipboardData || window.clipboardData).getData('text');
                        var digits = pasted.replace(/[^0-9]/g, '');
                        if (!digits) return;
                        el.value = digits; /* Insert as-is; blur/submit validation will catch out-of-range */
                    });
                }
                /* ── End delegated digit-only enforcement ── */
                /* ── Page init chain (order is critical) ────────────────────────────
                   1. loadResourceRequestConfig  — reads mandatory-field & skill flags.
                   1b. loadResourcePoolMandatory — reads RESOURCEPOOLMANDATORY SEM setting.
                       Must run after config (flag is independent but init order keeps
                       all API calls grouped before any rendering starts) and before
                       loadColumnMaster so the flag is available when loadColumnPreference
                       applies defaults (auto-select resource-pool when mandatory).
                   2. loadColumnMaster           — builds ALL_COLS from DB master table.
                   3. loadColumnPreference       — fetches PROJECT-SPECIFIC saved column
                                                   prefs for current ProjectID + UserID.
                                                   Falls back to defaults (no selection +
                                                   mandatory cols) for a new/unseen project.
                   4. renderDropdown/TagBar      — renders the picker with correct state.
                   5. LoadProjectDetails         — fills the project header card.
                   6. loadBulkRequest            — restores draft rows (column state is
                                                   already correct; rows just sync to it).
                   Updated by Nikhil Mane on 01-04-2026 — column prefs are now
                   project-specific; loadColumnPreference() is called inside
                   loadColumnMaster() so step 3 is automatic.
                   Updated by Nikhil Mane on 02-04-2026 — loadResourcePoolMandatory
                   added as step 1b between config load and column master load.
                */
                loadResourceRequestConfig(function () {
                    // Added by Nikhil Mane on 02-04-2026
                    loadResourcePoolMandatory(function () {
                        // End of Added by Nikhil Mane on 02-04-2026
                        loadColumnMaster(function () {
                            renderDropdown(); renderTagBar();
                            LoadProjectDetails();
                            loadBulkRequest();
                        });
                        // Added by Nikhil Mane on 02-04-2026
                    });
                    // End of Added by Nikhil Mane on 02-04-2026
                });

                /* ── Bootstrap 5 tooltip init (black-tooltip class, same as PM_ProjectSites) ──
                   Use trigger:'hover focus' so tooltips always disappear on mouseleave. */
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var tooltipEls = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                    tooltipEls.forEach(function (el) {
                        new bootstrap.Tooltip(el, { trigger: 'hover focus', html: false });
                    });
                }
                bindSkillDropdownChange();
                /* ── Submit confirm modal: re-init tooltips after modal buttons added to DOM ── */
                document.getElementById('submitConfirmModal') && document.getElementById('submitConfirmModal')
                    .addEventListener('shown.bs.modal', function () {
                        var btns = document.querySelectorAll('#submitConfirmModal [data-bs-toggle="tooltip"]');
                        btns.forEach(function (el) { new bootstrap.Tooltip(el); });
                    });
            });

            /* Re-initialise BS5 tooltips on any newly added buttons (called after addRow / addSkillRow).
               Disposes any stale instance first so the tooltip always hides on mouseleave.
               Updated by Nikhil Mane — force .hide() before .dispose() to clear any tooltip
               bubble that is currently visible (fixes delete-skill / delete-row tooltip lingering). */
            function reinitTooltips() {
                if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
                /* First pass: hide, dispose, and remove the cached title attribute on ALL
                   tooltip elements. Bootstrap 5 stores the original title in
                   data-bs-original-title on first init. Removing it forces each new
                   Tooltip instance to read the current title attribute instead of the
                   stale cached value — this is what makes the Add More counter update. */
                document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (el) {
                    var existing = bootstrap.Tooltip.getInstance(el);
                    if (existing) {
                        existing.hide();
                        existing.dispose();
                    }
                    el.removeAttribute('data-bs-original-title');
                });
                /* Second pass: create fresh instances with mouseleave/blur auto-hide */
                document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (el) {
                    new bootstrap.Tooltip(el, { trigger: 'hover focus', html: false });
                });
            }

            /* ══════════════════════════════════════════════════════════════════
             * initRowSelect2(context)
             * ──────────────────────────────────────────────────────────────────
             * Initialises select2 (searchable dropdown) on every <select> inside
             * `context` (a DOM element — a <tr>, <tbody>, or skill <tr>).
             * Skips selects that are already select2-enhanced to prevent double-init.
             *
             * Uses the select2 plugin already loaded via:
             *   /Whizible2.0-new/plugins/select2/select2.js
             *
             * Mirrors the pattern used in PM_ProjectSites.aspx where dropdowns are
             * made searchable with bootstrap-select data-live-search="true".
             * Here we use select2 because it is the plugin already bundled in
             * PM_BulkResourceReq.aspx (select2.css + select2.js are linked in <head>).
             *
             * Added by Nikhil Mane on 04-04-2026
             * ══════════════════════════════════════════════════════════════════ */
            function initRowSelect2(context) {
                if (typeof $ === 'undefined' || typeof $.fn.select2 === 'undefined') return;

                /* Updated by Nikhil Mane on 23-04-2026 — enable searchable dropdown
                   for ALL selects created in resource rows / skill rows / replacement rows.
                   This mirrors the PM_BulkResAllocation.aspx pattern where each dropdown
                   opens with a search box at the top. */
                $(context).find('select').each(function () {
                    var $sel = $(this);
                    var selEl = $sel[0];
                    if (!selEl) return;

                    /* Replacement employee list is loaded async — select2 is bound in
                       loadReplacementResources_row after GetActiveResources returns. */
                    if (_isRepResourceSelect(selEl)) return;

                    /* DrawComboBox can emit legacy wrappers (e.g. <font>) inside <select>.
                       Native browser dropdown still reads these options, but select2's adapter
                       can miss them because it expects direct option/optgroup children.
                       Flatten nested options to direct children before select2 init. */
                    var directCount = selEl.querySelectorAll(':scope > option, :scope > optgroup').length;
                    if (directCount === 0) {
                        var nestedOptions = selEl.querySelectorAll('option');
                        if (nestedOptions && nestedOptions.length) {
                            var frag = document.createDocumentFragment();
                            nestedOptions.forEach(function (opt) { frag.appendChild(opt.cloneNode(true)); });
                            selEl.innerHTML = '';
                            selEl.appendChild(frag);
                        }
                    }

                    /* Skip if already initialised — select2 adds data('select2') */
                    if ($sel.data('select2')) return;
                    if ($sel.hasClass('select2-hidden-accessible')) return;
                    $sel.select2({
                        width: '100%',
                        minimumResultsForSearch: 0   /* always show search box at top */
                    });
                    /* Mirror val-error class to the select2 container on change
                       so red-border validation state stays visible */
                    $sel.on('select2:select select2:unselect select2:clear', function () {
                        var $container = $sel.next('.select2-container');
                        if ($sel.hasClass('val-error')) {
                            $container.find('.select2-selection--single').css({ 'border-color': '#ef4444', 'background-color': '#fff5f5' });
                        } else {
                            $container.find('.select2-selection--single').css({ 'border-color': '', 'background-color': '' });
                        }
                    });
                });
            }
            /* End of Added by Nikhil Mane on 04-04-2026 */

            /* ══════════════════════════════════════════════════════════════════
             * _focusSelect2(selectEl)
             * ──────────────────────────────────────────────────────────────────
             * Opens the select2 dropdown for a given native <select> element and
             * scrolls it into view — used to auto-focus the Skill Name column
             * after Add Skill Set, and the Type of Requirement column after Add More.
             * Added by Nikhil Mane on 04-04-2026
             * ══════════════════════════════════════════════════════════════════ */
            function _focusSelect2(selectEl) {
                if (!selectEl) return;
                try {
                    selectEl.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'nearest' });
                } catch (e) { try { selectEl.scrollIntoView(true); } catch (ignore) { } }
                /* Open the select2 dropdown if the element has been enhanced */
                if (typeof $ !== 'undefined' && typeof $.fn.select2 !== 'undefined' && $(selectEl).data('select2')) {
                    setTimeout(function () { $(selectEl).select2('open'); }, 120);
                } else {
                    try { selectEl.focus(); } catch (e2) { }
                }
            }
            /* End of Added by Nikhil Mane on 04-04-2026 */

        })();

        /* ── Page Loader removed — replaced with no-ops so existing call sites compile.
           The loader overlay was causing a white/blocked screen because the transparent
           overlay div (z-index:2000) was never reliably hidden when AJAX calls
           overlapped or the counter went out of sync. All loader calls are now no-ops. */
        function showLoader() { /* no-op */ }
        function hideLoader() { /* no-op */ }
    </script>
  </body>
</html>