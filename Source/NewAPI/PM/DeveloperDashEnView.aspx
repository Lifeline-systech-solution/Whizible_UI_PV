<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DeveloperDashEnView.aspx.vb" Inherits="Whizible.DeveloperDashEnView" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("Developer Dashboard Enhanced View")%>

<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Developer Dashboard Enhanced View</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Keep the same file structure / references used across Whizible screens -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css"> -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
 <!-- Added By Madhuri.K On 26-03-2026 -->
 <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">
   
    <style>
        /* Page-level tweaks for this screen only */
        body {
            background-color: #f5f5f5;
            /* overflow-y: hidden; */
        }
        .graybg {
            background: rgb(248, 250, 252);
        }

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
            /* padding: 0 24px; */
        }

        h1.page-title {
            font-size: 24px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 700;
            color: #0f62fe;
            margin-bottom: 18px;
        }

        .profitImg {
            width: 24px;
            height: 24px;
            color: #1e40af;
        }

        /* header row */
        .project-header {
            background: #ffffff;
            border-radius: 6px 6px 0 0;
            /* border: 1px solid #e0e3ee; */
            padding: 10px 0;
            margin-bottom: 0;
        }

        .project-header .small {
            font-size: 11px;
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

        /* Stat cards */
        .stat-card {
            background: #ffffff;
            border: 1px solid #e0e3ee;
            border-radius: 12px;
            padding: 14px 16px;
            height: 100%;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.04);
        }

        .yellowBG {
            background-color: #fffdf0;
        }
        .pinkBG {
            background-color: #f8f7ff;
        }
        .purpleBG {
            background-color: #f3f6ff;
        }
        .orangeBG {
            background-color: #fff5e9;
        }
        .greenBG {
            background-color: #f5fff9;
        }

        .stat-title {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #6b7280;
            margin-bottom: 6px;
        }

        .stat-value {
            font-size: 23px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #0f172a;
            line-height: 1.1;
        }

        .stat-count{
            font-size: 11px;
            color: #64748b;
            margin-top: 5px;
        }

        .stat-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            border: 1px solid #e5e7eb;
            background: #f8fafc;
        }

        .stat-icon.success {
            background: rgba(34, 197, 94, 0.12);
            border-color: rgba(34, 197, 94, 0.22);
            color: #16a34a;
        }

        .stat-icon.danger {
            background: rgba(239, 68, 68, 0.12);
            border-color: rgba(239, 68, 68, 0.22);
            color: #ef4444;
        }

        .stat-icon.warn {
            background: rgba(245, 158, 11, 0.14);
            border-color: rgba(245, 158, 11, 0.25);
            color: #f59e0b;
        }

        .stat-icon.primary {
            background: rgba(59, 130, 246, 0.12);
            border-color: rgba(59, 130, 246, 0.22);
            color: #2563eb;
        }

        .stat-icon.info {
            background: rgba(149, 218, 245, 0.12);
            border-color: #8dd2dd;
            color: #0cafc5;
        }

        /* Panels (Tasks / Issues) */
        .panel {
            background: #ffffff;
            border: 1px solid #e0e3ee;
            border-radius: 14px;
            padding: 10px 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.04);
            min-height: 385px;
            position: relative;
        }

        .cstm_pagination {
            position: absolute;
            bottom: 10px;
            right: 15px;
        }
        .panel-title {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-weight: 500;
            color: #111827;
            margin: 0;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        h5.panel-title {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .panel-title .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #2563eb;
            display: inline-block;
        }

        .panel-title .dot.red {
            background: #ef4444;
        }

        .panel-actions {
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .pill {
            border: 1px solid #d6dbe6;
            border-radius: 12px;
            padding: 5px 10px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #64748b;
            background: #f8fafc;
            width: 4.8rem;
        }

        /* List items */
        .list-card {
            border: 1px solid #eef1f6;
            background: #f9fafb;
            border-radius: 12px;
            padding: 5px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .list-left {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
            flex: 1;
            width: 40%;
        }

        .status-icon {
            width: 28px;
            height: 28px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #e5e7eb;
            background: #ffffff;
            flex: 0 0 auto;
            font-size: 13px;
        }

        .status-icon.red {
            background: rgba(239, 68, 68, 0.10);
            border-color: rgba(239, 68, 68, 0.22);
            color: #ef4444;
        }

        .status-icon.green {
            background: rgba(34, 197, 94, 0.10);
            border-color: rgba(34, 197, 94, 0.22);
            color: #16a34a;
        }

        .status-icon.gray {
            background: rgba(148, 163, 184, 0.15);
            border-color: rgba(148, 163, 184, 0.25);
            color: #64748b;
        }

        .status-icon.amber {
            background: rgba(245, 158, 11, 0.12);
            border-color: rgba(245, 158, 11, 0.25);
            color: #f59e0b;
        }
        .IssueIcon {
            width: 60px;
            height: 28px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #e9c0c0;
            background: #fffef5;
            flex: 0 0 auto;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .list-title {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #111827;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 280px;
        }
        .outlineBtn {
            font-size: 11px; /* Modified By Madhuri.K On 26-03-2026 */
            border: 1px solid #ffe9c5;
            background-color: #fffcf7;
            border-radius: 7px;
            width: 75px;
        }

        .list-sub {
            font-size: 11px;
            color: #6b7280;
            /* margin-top: 2px; */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 280px;
            /*display: inline-block;*/
            display: block;
        }

        .tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 11px;
            color: #64748b;
            margin-left: 10px;
            font-weight: 500;
        }

        .priority {
            font-size: 11px;
            padding: 4px 10px;
            border-radius: 999px;
            border: 1px solid #e5e7eb;
            background: #eef2f7;
            color: #475569;
            font-weight: 600;
        }

        .priority.low {
            background: rgba(148, 163, 184, 0.18);
            border-color: rgba(148, 163, 184, 0.35);
            color: #64748b;
        }

        .priority.medium {
            background: rgba(245, 158, 11, 0.16);
            border-color: rgba(245, 158, 11, 0.30);
            color: #b45309;
        }

        .priority.high {
            background: rgba(239, 68, 68, 0.14);
            border-color: rgba(239, 68, 68, 0.28);
            color: #dc2626;
        }

        .list-right {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            /* flex: 0 0 auto; */
            width: 50%;
            justify-content: flex-end;
        }

        .mini-icon-btn {
            width: 28px;
            height: 28px;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
            background: #ffffff;
            color: #64748b;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .mini-icon-btn:hover {
            background: #f8fafc;
        }
        .resNameBg {
            font-size: 10px;
            background-color: #e0e7ff;
            padding: 6px 8px;
            border-radius: 15px;
            color: #3730a3;
            font-weight: 500;
            border: 1px solid #c7d2fe;
        }
        .view-all {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        .view-all:hover {
            text-decoration: underline;
        }

        /* Reviews list cards (slightly different icon) */
        .avatar-icon {
            width: 28px;
            height: 28px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #e5e7eb;
            background: rgba(148, 163, 184, 0.15);
            color: #64748b;
            flex: 0 0 auto;
        }

        /* Calendar tab UI */
        .calendar-panel {
            padding: 14px 16px;
        }

        .calendar-toolbar {
            border-bottom: 1px solid #eef1f6;
            flex-wrap: wrap;
        }

        .calendar-filters {
            display: flex;
            gap: 18px;
            align-items: center;
        }

        .cal-filter {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #0f172a;
            font-weight: 500;
            cursor: pointer;
            user-select: none;
        }

        .radio-chip {
            display: inline-flex;
            align-items: center;
            cursor: pointer;
            font-size: 12px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #1f2937;
            user-select: none;
        }

        .radio-chip input {
            display: none;
        }

        .radio-ui {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            border: 2px solid #3b82f6;
            margin-right: 6px;
            position: relative;
            box-sizing: border-box;
        }

        .radio-chip input:checked + .radio-ui {
            background-color: #3b82f6;
        }

        .radio-chip input:checked + .radio-ui::after {
            content: "";
            position: absolute;
            top: 3px;
            left: 3px;
            width: 6px;
            height: 6px;
            background: #fff;
            border-radius: 50%;
        }

        .radio-text {
            font-weight: 500;
        }

        .calendar-legend {
            display: flex;
            align-items: center;
            gap: 16px;
            color: #64748b;
            font-size: 13px;
        }

        .legend-item {
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .legend-box {
            width: 14px;
            height: 14px;
            border-radius: 2px;
            display: inline-block;
        }

        .legend-box.orange {
            background: #f59e0b;
        }

        .legend-box.blue {
            background: #3b82f6;
        }

        .calendar-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 0 10px 0;
        }

       .calendar-month {
            font-size: 12px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #0f172a;
            width: 140px;
            text-align: center;
            line-height: 1.2;
        }

        .calendar-nav {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .cal-nav-btn {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            border: 1px solid #e5e7eb;
            background: #ffffff;
            color: #64748b;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .cal-nav-btn:hover {
            background: #f8fafc;
        }

        .cal-today-link {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .cal-today-link:hover {
            text-decoration: underline;
        }

        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            /* gap: 18px 18px; */
            gap: 5px;
            padding: 4px 2px 8px 2px;
        }
        
        .calendar-dow {
            text-align: center;
            font-weight: 600;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            padding: 6px 0;
            color: #6b7280;
            border-bottom: 1px solid #e5e7eb;
        }

        .calendar-cell {
            position: relative;
            /* height: 110px; */
            height: 75px;
            border-radius: 5px;
            /* background: transparent; */
            background: #fffbf3;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            flex-direction: column;
            padding: 7px 14px;
            color: #0f172a;
            font-weight: 500;
        }

        .calendar-cell.muted {
            background: #f1f5f9;
            border: 1px solid #eef1f6;
            color: #475569;
        }

        .calendar-cell.empty {
            height: 110px;
        }

        .calendar-cell .day {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .calendar-cell.selected .day {
            background: #2f6df6;
            color: #ffffff;
            padding: 2px 9px;
            border-radius: 50%;
        }

        .calendar-cell .dots {
            position: absolute;
            top: 46px;
            display: flex;
            gap: 6px;
        }

        .calendar-cell .dot {
            width: 6px;
            height: 6px;
            border-radius: 999px;
            display: inline-block;
        }

        .calendar-cell .dot.green {
            background: #16a34a;
        }

        .calendar-cell .dot.red {
            background: #ef4444;
        }

        .calendar-cell .dot.amber {
            background: #f59e0b;
        }

        .calendar-cell .dot.blue {
            background: #2563eb;
        }

        .calendar-events {
            min-height: 600px;
        }

        /* My Report tab UI */
        @media (max-width: 992px) {

            .list-title,
            .list-sub {
                max-width: 210px;
            }
        }

        /* Timesheet Details Offcanvas UI starts */
        .ts-details-wrap {
            width: 100%;
        }

        .ts-table-card {
            background: #fff;
            border: 1px solid #e6eefb;
            border-radius: 14px;
            overflow: hidden;
            padding: 10px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .ts-table {
            margin: 0;
        }

        .ts-table thead th {
            background: #f9f9fa !important;
            /* light header like screenshot */
            color: #0f172a;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            /* font-weight:700; */
            border-bottom: 0 !important;
            padding: 14px 16px;
        }

        .ts-table tbody td {
            padding: 14px 16px;
            border-top: 1px solid #e6eefb !important;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .ts-muted {
            color: #64748b;
        }

        .fw-500 {
            font-weight: 500;
        }

        .fw-600 {
            font-weight: 600;
        }

        a.ts-link {
            cursor: default;
        }

        .ts-link:hover {
            text-decoration: underline;
        }

        .ts-status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 5px 12px;
            border-radius: 999px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 700;
            border: 1px solid;
            line-height: 1;
        }

        .ts-pending {
            color: #f97316;
            border-color: #fb923c;
            background: #fff7ed;
        }

        .ts-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 50px;
            background: #f8fafc;
            border-top: 1px solid #e6eefb;
        }
        .detail-offcanvas {
            width: 640px;
            max-width: 100%;
            border-left: 1px solid #e5e7eb;
            /*Commented By Dipali For Header Color */
            /*background-color: #f9fafb;*/
        }

        .detail-offcanvas .offcanvas-header {
             /*Commented By Dipali For Header Color */
            /*background: #ffffff;*/
            box-shadow: 0 1px 0 #e5e7eb;
        }

        .detail-offcanvas .offcanvas-title {
            font-size: 16px;
        }

        /* Close pill button */
        .detail-offcanvas .btn.btn-light {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        /* Discussion Thread Offcanvas CSS start */
        .dt-offcanvas{ width: 540px; }
        .dt-header{ background:#fff; }
        .dt-h-ico{
          width:34px; height:34px; border-radius:10px;
          background:#eaf2ff; color:#2563eb;
          display:flex; align-items:center; justify-content:center;
          font-size:16px; flex:0 0 auto;
        }
        .dt-title{ font-weight:800; font-size:16px; color:#0f172a; line-height:1.2; }
        .dt-subtitle{ font-size:12.5px; color:#64748b; margin-top:2px; }
        .dt-pill{
          display:inline-flex; align-items:center;
          padding:3px 8px; border-radius:6px;
          border:1px solid #e2e8f0;
          background:#f1f5f9;
          font-size:11px; color:#334155;
        }
        .dt-close{
          width:32px; height:32px; border-radius:10px;
          border:0; background:transparent; color:#64748b;
          display:flex; align-items:center; justify-content:center;
        }
        .dt-close:hover{ background:#f1f5f9; color:#0f172a; }
        .dt-divider{ height:1px; background:#e2e8f0; }

        .dt-body{ background:#fff; }

        /* Cards */
        .dt-card{
          border:1px solid #d7e3f7;
          background:#fff;
          border-radius:12px;
          padding:14px;
          margin-bottom: 5px;
        }

        /* Composer */
        .dt-composer{ box-shadow: 0 0 0 rgba(0,0,0,0); }
        .dt-composer-top{ display:flex; gap:10px; align-items:flex-start; }
        .dt-avatar{
          width:34px; height:34px; border-radius:999px;
          display:flex; align-items:center; justify-content:center;
          font-weight:800; font-size:12px;
          flex:0 0 auto;
        }
        .dt-avatar-blue{ background:#eaf2ff; color:#2563eb; }
        .dt-avatar-gray{ background:#eef2f7; color:#64748b; }

        .dt-name{ font-weight:800; color:#0f172a; font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */ }
        .dt-time{ font-size:11.5px; color:#64748b; }
        .dt-inputwrap{ position:relative; }
        .dt-textarea{
          width:100%;
          /* border:2px solid #3b82f6; */
          border:1px solid #c8ddff;
          border-radius:10px;
          padding:10px 10px;
          font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */
          outline:none;
          resize:none;
        }
        .dt-counter{
          font-size:11px; color:#64748b;
          margin-top:6px;
        }

        .dt-actions{
          display:flex; align-items:center; gap:14px; flex-wrap:wrap;
          margin-top:6px;
        }
        .dt-field{ display:flex; align-items:center; gap:8px; }
        .dt-label{ font-size:12px; color:#64748b; font-weight:700; }
        .dt-select{
          height:30px; border-radius:8px;
          border:1px solid #d1d5db;
          font-size:12px; padding:0 10px;
          background:#fff;
        }
        .dt-postbtn{
          width:100%;
          height:40px;
          border:0;
          border-radius:10px;
          background:#e0edff;
          color:#0b3b8f;
          font-weight:800;
        }
        .dt-postbtn:hover{ filter: brightness(0.98); }

        /* Radio */
        .dt-radio{ display:inline-flex; align-items:center; gap:8px; cursor:pointer; user-select:none; }
        .dt-radio input{ display:none; }
        .dt-radio-ui{
          width:14px; height:14px; border-radius:999px;
          border:2px solid #3b82f6; position:relative;
        }
        .dt-radio input:checked + .dt-radio-ui{ background:#3b82f6; }
        .dt-radio input:checked + .dt-radio-ui::after{
          content:""; position:absolute; left:3px; top:3px;
          width:6px; height:6px; border-radius:999px; background:#fff;
        }
        .dt-radio-text{ font-size:12px; color:#334155; font-weight:700; }

        /* Previous comments */
        .dt-section-hd{
          display:flex; align-items:center; gap:8px;
        }
        .dt-section-title{ font-weight:800; color:#0f172a; font-size:12.5px; }
        .dt-countpill{
          font-size:11px; font-weight:800;
          padding:2px 8px; border-radius:999px;
          background:#eef2f7; color:#334155;
        }

        .dt-comment{ padding:12px 14px; }
        .dt-comment-row{ display:flex; gap:10px; align-items:flex-start; }
        .dt-comment-main{ flex:1; min-width:0; }
        .dt-comment-top{
          display:flex; align-items:center; justify-content:space-between;
          gap:10px;
        }
        .dt-comment-text{ margin-top:6px; font-size:12.5px; color:#334155; line-height:1.4; }

        .dt-badge{
          font-size:10.5px;
          padding:2px 8px;
          border-radius:6px;
          background:#eaf2ff;
          color:#2563eb;
          font-weight:800;
          border:1px solid #dbeafe;
        }
        .switch {
            width: 40px;
            height: 15px;
        }
        input:checked+.slider:before {
            transform: translateX(22px);
        }
        .slider:before {
            transform: translateX(-22px);
        }
        /* Discussion Thread Offcanvas CSS end */

        /* Note card */
        .noteCard {
            /* background: #fff9e6; */
            border-radius: 8px;
            /* border: 1px solid #facc6b; */
            padding: 5px 12px;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #4b5563;
        }
        .calendar-cell.has-count .day{
            font-weight:700;
        }
        .cal-chip{
            display:inline-block;
            margin-top:1px;
            padding:2px 7px;
            border-radius:6px;
            font-size:10px; /* Modified By Madhuri.K On 26-03-2026 */
            line-height:1.2;
            white-space:nowrap;
            max-width:45%;
            overflow:hidden;
            text-overflow:ellipsis;
            cursor: pointer;
        }

        .cal-chip-start{
            background:#dbeafe;   /* light blue */
            color:#1e40af;        /* blue text */
        }

        .cal-chip-end{
            background:#e5e7eb;   /* light gray */
            color:#374151;        /* dark gray text */
        }
        .hl-dot{
            position:absolute;
            /* bottom:6px;
            left:14px;         */
            width:7px;
            top: 15px;
            right: 35px;
            height:7px;
            border-radius:50%;
            background: #f59e0b; /* Holiday orange */
        }        
        .hl_Weekdot {
            position: absolute;
            width: 7px;
            top: 40px;
            right: 9px;
            height: 7px;
            border-radius: 50%;
            background: #f59e0b;
        }
        .lv-dot{
            position:absolute;
            width:7px;
            top: 15px;
            right: 24px;
            height:7px;
            border-radius:50%;
            background:#2563eb; /* Leave blue */
        }

        .week-leave-dot {
            position: absolute;
            width: 7px;
            top: 50px;
            right: 8px;
            height: 7px;
            border-radius: 50%;
            background:#2563eb; /* Leave blue */
        }

        /* Added by Aditya J. on 20-03-2026 for legend color */
        .calendar-cell.holiday-cell-bg, .week-day.holiday-cell-bg {
            background: rgba(245, 158, 11, 0.14) !important;
        }
        .calendar-cell.leave-cell-bg, .week-day.leave-cell-bg {
            background: rgba(37, 99, 235, 0.14) !important;
        }
        /* End of Added by Aditya J. on 20-03-2026 for legend color */

        .legend-count{
            font-size:12px;
            color:#6b7280;
            margin-left:4px;
        }

        /* Right action row: Today + Toggle */
        .cal-actions{
            display:flex;
            align-items:center;
            gap:12px;
        }

        /* Toggle */
        .cal-view-toggle {
            display: inline-flex;
            gap: 0;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            overflow: hidden;
            background: #fff;
        }

        .cal-view-btn {
            border: 0;
            background: #fff;
            color: #0f172a;
            font-size: 13px;
            font-weight: 400;
            padding: 6px 12px;
            line-height: 1;
            border-left: 1px solid #cbd5e1;
        }
        .cal-view-btn:first-child { border-left: 0; }

        .cal-view-btn.active {
            background: #5a77d5;
            color: #fff;
        }

        /* Weekly View */
        .calendar-week-wrap { margin-top: 6px; }

        .calendar-week {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 14px;
            padding: 4px 2px 8px 2px;
        }

        .week-day {
            border: 1px solid #e5e7eb;
            background: #ffffff;
            border-radius: 14px;
            min-height: 200px;
            padding: 10px 10px 12px 10px;
            display: flex;
            flex-direction: column;
        }

        .week-day.selected {
            border-color: #2f6df6;
            box-shadow: 0 10px 22px rgba(47, 109, 246, 0.10);
        }

        .week-day-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 6px 6px 10px 6px;
            border-bottom: 1px solid #eef1f6;
            margin-bottom: 8px;
            position: relative;
        }

        .week-dow {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #64748b;
            font-weight: 700;
        }
        .week-date {
            font-size: 14px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #0f172a;
            line-height: 1;
        }

        .week-day-body {
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding: 4px 6px 0 6px;
        }

        /* Chips like Tasks Start / End */
        .week-count {
            align-self: flex-start;
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 700;
            padding: 6px 10px;
            border-radius: 10px;
            background: rgba(47, 109, 246, 0.10);
            color: #2563eb;
            border: 1px solid rgba(47, 109, 246, 0.18);
        }

        /* Event blocks */
        .week-event {
            border-radius: 12px;
            padding: 10px 10px;
            border: 1px solid transparent;
        }

        .week-event .we-title {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            font-weight: 500;
            color: #0f172a;
            margin-bottom: 6px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .week-event .we-meta {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #475569;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .we-task { background: rgba(34, 197, 94, 0.10); border-color: rgba(34, 197, 94, 0.22); }
        .we-holiday { background: rgba(239, 68, 68, 0.10); border-color: rgba(239, 68, 68, 0.22); }
        .we-meeting { background: rgba(59, 130, 246, 0.10); border-color: rgba(59, 130, 246, 0.22); }
        .we-deadline { background: rgba(245, 158, 11, 0.12); border-color: rgba(245, 158, 11, 0.25); }

        @media (max-width: 991px) {
        .calendar-week {
            grid-template-columns: repeat(7, minmax(180px, 1fr));
            overflow-x: auto;
            padding-bottom: 8px;
        }
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
            /* keep content visible, show only loader */
            z-index: 2000;
            /* above all page content */
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
       
       
        /*Commente and Added by Vaibhav K on 20-03-26 for w26 part 3 issue*/
        /*.FilterDropdown .dropdown-toggle {
            width: 200px;
        }*/

            /* ── Project dropdowns ── */
        .FilterDropdown .dropdown-toggle {
            width: 200px;
        }
        .bootstrap-select.FilterDropdown .dropdown-menu .inner {
            max-height: 250px !important;
            overflow-y: auto !important;
            overflow-x: hidden !important;
        }

        /*End of Commente and Added by Vaibhav K on 20-03-26 for w26 part 3 issue*/
     

        .nested_tabs .nav-tabs .nav-link.active {
            border-bottom: 1px solid #0f62fe !important;
            color: #0664e0 !important;
        }
        .nested_tabs .nav-link:focus, .nested_tabs .nav-link {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }

        .TS_Details_Section label, .TS_Details_Section span{
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .TS_Details_Section label{
            color: #4265c9;
        }
        .borderSec{
            border: 1px solid #dddd;
            padding: 20px 0;
        }
        .inputTS{
            outline-color: #4263c1;
            padding: 0 5px;
        }
        .list-data {
            width: 115px;
            font-size: 11px; /* Modified By Madhuri.K On 26-03-2026 */
            display: flex;
            flex-wrap: wrap;
        }
        .badge-bg {
             /*Commented By Dipali For Header Color */
            /* background-color: #e0e0e0; */
            color: #333;
            padding: 8px 6px;
            border-radius: 50%;
            font-size: 10px; /* Modified By Madhuri.K On 26-03-2026 */  
            margin-right: 4px;
            /* margin-top: 4px; */
            border: 1px solid #e0e0e0;
        }
        .offcanvas-50{
            --bs-offcanvas-width: 50%;
        }



    </style>
</head>
<body class="hold-transition bgwhite sidebar-mini fixed">
    <div id="DevDashboardSec" class="preloader"></div>

   <!-- Page Loader - Show immediately -->
   <div class="loader-overlay" id="loaderOverlay" style="display: none;">
       <div class="loader"></div>
   </div>

    <div class="page-wrapper" id="DevDashboardWrapper" style="display: none;">
        <div class="px-3 mb-3 graybg ">
            <h2 class="pageHeading">
                <img src="../../../Whizible2.0-new/dist/img/DevDashboard1.png" class="profitImg me-2" />
                <%=MyBase.GetResourceString("C_MyDBoard")%>
            </h2>

             <%--Added by Vaibhav K on 20-03-26 for note on title--%>

            <p style="color: #6b7280; margin: 0; font-size:14px;">
     Track your tasks, issues, deliverables, and milestones at a glance
    </p>
 <%--End of Added by Vaibhav K on 20-03-26 for note on title--%>

        </div>

        <!-- Stats row -->
                <div class="DevDashboardStatsSection">
                    <div class="row gx-2 gy-3 mb-3 px-3">
                        <div class="col">
                            <div class="stat-card TaskCard yellowBG">
                                <div>
                                    <div class="stat-title"><%=MyBase.GetResourceString("C_OpTasks")%></div>
                                    <div class="stat-value" id="TasksOpenCount"></div>
                                    <div class="stat-count"><%=MyBase.GetResourceString("C_NewTaskCreate")%>: <span id="NewTasksCount"></span></div>
                                </div>
                                <div class="stat-icon success"><i class="fas fa-tasks"></i></div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="stat-card IssueCard greenBG">
                                <div>
                                    <div class="stat-title"><%=MyBase.GetResourceString("C_OpIssues")%></div>
                                    <div class="stat-value" id="IssuesOpenCount"></div>
                                    <div class="stat-count"><%=MyBase.GetResourceString("C_NewIssCreate")%>: <span id="NewIssuesCount"></span></div>
                                </div>
                                <div class="stat-icon danger">
                                    <img src="../../../Whizible2.0-new/dist/img/issues-red.svg" style="width: 20px; height: 20px;" />
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="stat-card ReviewCard purpleBG">
                                <div>
                                    <div class="stat-title"><%=MyBase.GetResourceString("C_OpPendRevs")%></div>
                                    <div class="stat-value" id="ReviewsOpenCount"></div>
                                    <div class="stat-count"><%=MyBase.GetResourceString("C_NewRevCreate")%>: <span id="NewReviewsCount"></span></div>
                                </div>
                                <div class="stat-icon warn"><i class="fas fa-user-friends"></i></div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="stat-card DeliverableCard orangeBG">
                                <div>
                                    <div class="stat-title"><%=MyBase.GetResourceString("C_OpDel")%></div>
                                    <div class="stat-value" id="DeliverablesOpenCount"></div>
                                    <div class="stat-count"><%=MyBase.GetResourceString("C_NewDelCreate")%>: <span id="NewDeliverablesCount"></span></div>
                                </div>
                                <div class="stat-icon primary"><i class="fas fa-cube"></i></div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="stat-card MilestoneCard pinkBG">
                                <div>
                                    <div class="stat-title"><%=MyBase.GetResourceString("C_OpMStone")%></div>
                                    <div class="stat-value" id="MilestonesOpenCount"></div>
                                    <div class="stat-count"><%=MyBase.GetResourceString("C_NewMilCreate")%>: <span id="NewMilestonesCount"></span></div>
                                </div>
                                <div class="stat-icon info"><i class="far fa-flag"></i></div>
                            </div>
                        </div>
                    </div>
                </div>

        <div class="AllTabsDiv">
            <div
                style="background: white; border-bottom: 1px solid #e0e0e0; padding: 0 15px; margin: 10px 2px 15px 2px; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
                <ul class="nav nav-tabs task-management-tabs" id="menuTabsContainer" 
                    style="border-bottom: none; gap: 5px; margin-bottom: 0;">
                    <!-- <li class="nav-item">
                        <a class="nav-link NavTabsStyle active" href="javascript:;" data-bs-toggle="tab"
                            data-bs-target="#paneToday">
                            <i class="fas fa-calendar-check pe-1"></i>Whizible Today
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle" href="javascript:;" data-bs-toggle="tab" data-bs-target="#paneCalendar">
                            <i class="far fa-calendar-alt pe-1"></i>Calendar
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link NavTabsStyle" href="javascript:;" data-bs-toggle="tab" data-bs-target="#paneMyReports">
                            <i class="far fa-file-alt pe-1"></i>My Report
                        </a>
                    </li> -->
                </ul>
            </div>

            <div class="tab-content px-3" id="menuTabContent">
                <!-- Whizible Today -->
                <div class="tab-pane fade show active" id="paneWhizibleToday" role="tabpanel">
                    <div class="row g-3">
                        <!-- Tasks Section -->
                        <div class="col-12 col-lg-6">
                            <div class="panel">
                                <div class="panel-header d-flex mb-2">
                                    <h3 class="panel-title"><span class="dot"></span><%=MyBase.GetResourceString("C_Task")%></h3>
                                    <%--<div class="panel-actions">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectTask", "usp_Whizible2_Sel_AccessibleProjects_Dash_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "'," & Session("intProjectID") & ", 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectTaskOnChange();' class='selectpicker FilterDropdown' data-live-search='true'",,,) %>
                                    </div>--%>
                                                                    <div class="panel-actions">
                                    <select id="cboProjectTask"
                                            class="selectpicker FilterDropdown"
                                            data-live-search="true"
                                            onchange="ProjectTaskOnChange();">
                                    </select>
                                </div>

                                </div>

                                <!-- Task items -->
                                <div class="nested_tabs">
                                    <ul class="nav nav-tabs justify-content-start mb-2">
                                        <li class="nav-item">
                                            <button class="nav-link active mb-0" id="RunningTasksTab" 
                                                onclick="getWhizibleTodayTasksListByCategory('RUNNING', null)"
                                                data-bs-toggle="tab" data-bs-target="#RunningTasks" type="button">
                                                <%=MyBase.GetResourceString("C_RunTask")%>
                                            </button>
                                        </li>
                                        <li class="nav-item">
                                            <button class="nav-link mb-0" id="OldTasksTab" data-bs-toggle="tab" 
                                                onclick="getWhizibleTodayTasksListByCategory('OLD', (getSelectedProject($('#cboProjectTask'))||{}).id || null)"
                                                data-bs-target="#OldTasks" type="button">
                                                <%=MyBase.GetResourceString("C_OldTask")%>
                                            </button>
                                        </li>
                                        <li class="nav-item">
                                            <button class="nav-link mb-0" id="YetStartTasksTab" data-bs-toggle="tab"         
                                                onclick="getWhizibleTodayTasksListByCategory('YETTOSTART', (getSelectedProject($('#cboProjectTask'))||{}).id || null)"
                                                data-bs-target="#YetStartTasks" type="button">
                                                <%=MyBase.GetResourceString("C_YetStartTask")%>
                                            </button>
                                        </li>
                                    </ul>
                                </div>

                                <div class="tab-content">
                                    <!-- ===== Running Tasks ===== -->
                                    <div class="tab-pane fade show active" id="RunningTasks" role="tabpanel" aria-labelledby="RunningTasksTab">
                                        <div class="RunningTaskListContainer">
                                            <!-- Running Task items -->
                                            <div id="RunningTasksList"></div>

                                            <!-- Pagination Controls for Task List -->
                                            <div class="cstm_pagination mt-2" id="paginationControlsTask">
                                                <div class="d-flex justify-content-end w-100">
                                                    <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                                        <span id="" class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                                        <span class="spntotal" id="TotalRecordsTask"></span>
                                                        <nav aria-label="Page navigation example">
                                                            <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                                <li class="page-item" id="btnPreviousTask">
                                                                    <a class="page-link" aria-label="Previous" onclick="PrevTaskList()" id="LinkPreviousTask">
                                                                        <i class="fas fa-angle-double-left"></i>
                                                                    </a>
                                                                </li>
                                                                <li class="page-item" id="btnNextTask">
                                                                    <a class="page-link" aria-label="Next" onclick="NextTaskList()" id="LinkNextTask">
                                                                        <i class="fas fa-angle-double-right"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </nav>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- ===== Old Tasks ===== -->
                                    <div class="tab-pane fade" id="OldTasks" role="tabpanel" aria-labelledby="OldTasksTab">
                                        <div class="OldTaskContainer">
                                            <!-- Old Task items -->
                                            <div id="OldTasksList"></div>

                                            <!-- Pagination Controls for Task List -->
                                            <div class="cstm_pagination mt-2" id="paginationControlsOldTask">
                                                <div class="d-flex justify-content-end w-100">
                                                    <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                                        <span id="" class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                                        <span class="spntotal" id="TotalRecordsOldTask"></span>
                                                        <nav aria-label="Page navigation example">
                                                            <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                                <li class="page-item" id="btnPreviousOldTask">
                                                                    <a class="page-link" aria-label="Previous" onclick="PrevOldTaskList()" id="LinkPreviousOldTask">
                                                                        <i class="fas fa-angle-double-left"></i>
                                                                    </a>
                                                                </li>

                                                                <li class="page-item" id="btnNextOldTask">
                                                                    <a class="page-link" aria-label="Next" onclick="NextOldTaskList()" id="LinkNextOldTask">
                                                                        <i class="fas fa-angle-double-right"></i>
                                                                    </a>
                                                                </li>

                                                            </ul>
                                                        </nav>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- ===== Yet to Start Tasks ===== -->
                                    <div class="tab-pane fade" id="YetStartTasks" role="tabpanel" aria-labelledby="YetStartTasksTab">
                                        <div class="YetStartTaskListContainer">
                                            <!-- Yet to Start Task items -->
                                            <div id="YetStartTasksList"></div>

                                            <div class="cstm_pagination mt-2" id="paginationControlsYetStartTask">
                                                <div class="d-flex justify-content-end w-100">
                                                    <div class="buttons" style="display:flex; align-items:center; gap:10px;">
                                                    <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                                    <span class="spntotal" id="TotalRecordsYetStartTask"></span>
                                                    <nav aria-label="Page navigation">
                                                        <ul class="pagination justify-content-end" style="margin:0!important">
                                                        <li class="page-item" id="btnPreviousYetStartTask">
                                                            <a class="page-link" aria-label="Previous" onclick="PrevYetStartTaskList()" id="LinkPreviousYetStartTask">
                                                            <i class="fas fa-angle-double-left"></i>
                                                            </a>
                                                        </li>
                                                        <li class="page-item" id="btnNextYetStartTask">
                                                            <a class="page-link" aria-label="Next" onclick="NextYetStartTaskList()" id="LinkNextYetStartTask">
                                                            <i class="fas fa-angle-double-right"></i>
                                                            </a>
                                                        </li>
                                                        </ul>
                                                    </nav>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Issue Section -->
                        <div class="col-12 col-lg-6">
                            <div class="panel">
                                <div class="panel-header d-flex mb-2">
                                    <h3 class="panel-title"><span class="dot red"></span><%=MyBase.GetResourceString("C_Issue")%></h3>
                                   <%-- <div class="panel-actions">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectIssue", "usp_Whizible2_Sel_AccessibleProjects_Dash_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "'," & Session("intProjectID") & ", 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectIssueOnChange();' class='selectpicker FilterDropdown' data-live-search='true'",,,) %>
                                    </div>--%>
                                    <div class="panel-actions">
                                         <select id="cboProjectIssue"
                                            class="selectpicker FilterDropdown"
                                              data-live-search="true"
                                              onchange="ProjectIssueOnChange();">
                                         </select>
                                    </div>

                                </div>

                                <div class="RunningIssueContainer">
                                    <!-- Issue items -->
                                    <div class="nested_tabs">
                                        <ul class="nav nav-tabs justify-content-start mb-2">
                                            <li class="nav-item">
                                                <button class="nav-link active mb-0" id="RunningIssuesTab"
                                                    onclick="getWhizibleTodayIssuesList(null, true)"
                                                    data-bs-toggle="tab" data-bs-target="#RunningIssues" type="button">
                                                    <%=MyBase.GetResourceString("C_CurrIssue")%>
                                                </button>
                                            </li>
                                            <li class="nav-item">
                                                <button class="nav-link mb-0" id="OldIssuesTab" data-bs-toggle="tab"
                                                    onclick="getWhizibleTodayIssuesList(null, false)"
                                                    data-bs-target="#OldIssues" type="button">
                                                    <%=MyBase.GetResourceString("C_OldIssue")%>
                                                </button>
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="tab-content">
                                        <!-- ===== Current Issues ===== -->
                                        <div class="tab-pane fade show active" id="RunningIssues" role="tabpanel" aria-labelledby="RunningIssuesTab">
                                            <div id="CurrIssueListContainer"></div>

                                            <!-- Pagination Controls for Current Issue List -->
                                            <div class="cstm_pagination mt-2" id="paginationControlsIssue">
                                                <div class="d-flex justify-content-end w-100">
                                                    <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                                        <span id="" class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                                        <span class="spntotal" id="TotalRecords6"></span>
                                                        <nav aria-label="Page navigation example">
                                                            <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                                <li class="page-item" id="btnPreviousIssue">
                                                                    <a class="page-link" aria-label="Previous" onclick="PrevList()" id="LinkPreviousIssue">
                                                                        <i class="fas fa-angle-double-left"></i>
                                                                    </a>
                                                                </li>
                                                                <li class="page-item" id="btnNextIssue">
                                                                    <a class="page-link" aria-label="Next" onclick="NextList()" id="LinkNextIssue">
                                                                        <i class="fas fa-angle-double-right"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </nav>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- ===== Old Issues ===== -->
                                        <div class="tab-pane fade" id="OldIssues" role="tabpanel" aria-labelledby="OldIssuesTab">
                                            <div id="OpenIssueListContainer"></div>

                                            <!-- Pagination Controls for OLD Issue List -->
                                            <div class="cstm_pagination mt-2" id="oldPaginationControlsIssue">
                                                <div class="d-flex justify-content-end w-100">
                                                    <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                                        <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                                        <span class="spntotal" id="TotalRecordsOldIssue"></span>

                                                        <nav aria-label="Page navigation example">
                                                            <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                                <li class="page-item" id="btnPreviousOldIssue">
                                                                    <a class="page-link" aria-label="Previous" onclick="PrevOldIssueList()" id="LinkPreviousOldIssue">
                                                                        <i class="fas fa-angle-double-left"></i>
                                                                    </a>
                                                                </li>
                                                                <li class="page-item" id="btnNextOldIssue">
                                                                    <a class="page-link" aria-label="Next" onclick="NextOldIssueList()" id="LinkNextOldIssue">
                                                                        <i class="fas fa-angle-double-right"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </nav>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3 mt-1">
                        <!-- Deliverables Section -->
                        <div class="col-12 col-lg-6">
                            <div class="panel">
                                <div class="panel-header d-flex mb-2">
                                    <h3 class="panel-title"><span class="dot" style="background: #16a34a;"></span><%=MyBase.GetResourceString("C_Dev")%></h3>
                                   <%-- <div class="panel-actions">
                                       <%-- <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectDel", "usp_Whizible2_Sel_AccessibleProjects_Dash_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "'," & Session("intProjectID") & ", 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectDeliverableOnChange();' class='selectpicker FilterDropdown' data-live-search='true'",,,) %>
                                        <!-- <span class="pill"><span id="openCountDel"></span> open</span> -->

                                    </div>--%>

                                <div class="panel-actions">
                                <select id="cboProjectDel"
                                        class="selectpicker FilterDropdown"
                                        data-live-search="true"
                                        onchange="ProjectDeliverableOnChange();">
                                </select>

                                    <!-- <span class="pill"><span id="openCountDel"></span> open</span> -->
                                </div>

                                </div>

                                <div id="deliverableListContainer" class="mb-5"></div>

                                <!-- Pagination Controls for Deliverable List -->
                                <div class="cstm_pagination mt-2" id="paginationControlsDeliverable">
                                    <div class="d-flex justify-content-end w-100">
                                        <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                            <span id="" class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                            <span class="spntotal" id="TotalRecordsDeliverable"></span>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                    <li class="page-item" id="btnPreviousDeliverable">
                                                        <a class="page-link" aria-label="Previous" onclick="PrevDeliverableList()" id="LinkPreviousDeliverable">
                                                            <i class="fas fa-angle-double-left"></i>
                                                        </a>
                                                    </li>
                                                    <li class="page-item" id="btnNextDeliverable">
                                                        <a class="page-link" aria-label="Next" onclick="NextDeliverableList()" id="LinkNextDeliverable">
                                                            <i class="fas fa-angle-double-right"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Reviews Section -->
                        <div class="col-12 col-lg-6">
                            <div class="panel">
                                <div class="panel-header d-flex mb-2">
                                    <h3 class="panel-title"><span class="dot" style="background: #f59e0b;"></span><%=MyBase.GetResourceString("C_Rev")%></h3>

                                   <%-- <div class="panel-actions">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectReview", "usp_Whizible2_Sel_AccessibleProjects_Dash_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "'," & Session("intProjectID") & ", 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectReviewOnChange();' class='selectpicker FilterDropdown' data-live-search='true'",,,) %>
                                    </div>--%>


                                                                    <div class="panel-actions">
                                    <select id="cboProjectReview"
                                            class="selectpicker FilterDropdown"
                                            data-live-search="true"
                                            onchange="ProjectReviewOnChange();">
                                    </select>
                                </div>


                                </div>

                                <div id="reviewListContainer" class="mb-5"></div>

                                <!-- Pagination Controls for Review List -->
                                <div class="cstm_pagination mt-2" id="paginationControlsReview">
                                    <div class="d-flex justify-content-end w-100">
                                        <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                            <span id="" class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                            <span class="spntotal" id="TotalRecordsReview"></span>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                    <li class="page-item" id="btnPreviousReview">
                                                        <a class="page-link" aria-label="Previous" onclick="PrevReviewList()" id="LinkPreviousReview">
                                                            <i class="fas fa-angle-double-left"></i>
                                                        </a>
                                                    </li>
                                                    <li class="page-item" id="btnNextReview">
                                                        <a class="page-link" aria-label="Next" onclick="NextReviewList()" id="LinkNextReview">
                                                            <i class="fas fa-angle-double-right"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3 mt-1">
                        <!-- Milestone Section -->
                        <div class="col-12 col-lg-6">
                            <div class="panel">
                                <div class="panel-header d-flex mb-2">
                                    <h3 class="panel-title"><span class="dot" style="background: #00b3db;"></span><%=MyBase.GetResourceString("C_Mile")%></h3>
                                   <%-- <div class="panel-actions">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboProjectMile", "usp_Whizible2_Sel_AccessibleProjects_Dash_LoginResource " & Session("intUserID") & ", '" & Session("LoginType") & "'," & Session("intProjectID") & ", 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='ProjectMilestoneOnChange();' class='selectpicker FilterDropdown' data-live-search='true'",,,) %>
                                    </div>--%>

                                                                    <div class="panel-actions">
                                    <select id="cboProjectMile"
                                            class="selectpicker FilterDropdown"
                                            data-live-search="true"
                                            onchange="ProjectMilestoneOnChange();">
                                    </select>
                                </div>


                                </div>

                                <div id="milestoneListContainer" class="mb-5"></div>

                                <!-- Pagination Controls for Milestone List -->
                                <div class="cstm_pagination mt-2" id="paginationControlsMilestone">
                                    <div class="d-flex justify-content-end w-100">
                                        <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                            <span id="" class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                            <span class="spntotal" id="TotalRecordsMilestone"></span>
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination justify-content-end" style="margin: 0px!important">
                                                    <li class="page-item" id="btnPreviousMilestone">
                                                        <a class="page-link" aria-label="Previous" onclick="PrevMilestoneList()" id="LinkPreviousMilestone">
                                                            <i class="fas fa-angle-double-left"></i>
                                                        </a>
                                                    </li>
                                                    <li class="page-item" id="btnNextMilestone">
                                                        <a class="page-link" aria-label="Next" onclick="NextMilestoneList()" id="LinkNextMilestone">
                                                            <i class="fas fa-angle-double-right"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Calendar tab -->
                <div class="tab-pane fade" id="paneCalendar" role="tabpanel">
                    <div class="row g-3">
                        <!-- Calendar board -->
                        <div class="col-12 col-lg-12">
                            <div class="panel calendar-panel">
                                <div class="calendar-toolbar d-flex gap-2 pb-2">
                                    <div class="calendar-filters">
                                        <!-- Tasks -->
                                        <label class="radio-chip position-relative">
                                            <input type="radio" name="calendarFilter" id="rdoCalTodo" checked>
                                            <span class="radio-ui"></span>
                                            <span class="radio-text pe-2"><%=MyBase.GetResourceString("C_Task")%></span>
                                            (<span id="taskCalendarCount"></span>)
                                            <!-- <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill badge-bg">
                                                99+
                                            </span> -->
                                        </label>

                                        <!-- Issues -->
                                        <label class="radio-chip">
                                            <input type="radio" name="calendarFilter" id="rdoCalIssues">
                                            <span class="radio-ui"></span>
                                            <span class="radio-text pe-2"><%=MyBase.GetResourceString("C_Issue")%></span>
                                            (<span id="issueCalendarCount"></span>)
                                        </label>

                                        <!-- Reviews -->
                                        <label class="radio-chip">
                                            <input type="radio" name="calendarFilter" id="rdoCalReviews">
                                            <span class="radio-ui"></span>
                                            <span class="radio-text pe-2"><%=MyBase.GetResourceString("C_Rev")%></span>
                                            (<span id="reviewCalendarCount"></span>)
                                        </label>

                                        <!-- Milestones -->
                                        <label class="radio-chip">
                                            <input type="radio" name="calendarFilter" id="rdoCalMilestones">
                                            <span class="radio-ui"></span>
                                            <span class="radio-text pe-2"><%=MyBase.GetResourceString("C_Mile")%></span>
                                            (<span id="milestoneCalendarCount"></span>)
                                        </label>

                                        <!-- Deliverables -->
                                        <label class="radio-chip">
                                            <input type="radio" name="calendarFilter" id="rdoCalDeliverables">
                                            <span class="radio-ui"></span>
                                            <span class="radio-text pe-2"><%=MyBase.GetResourceString("C_Dev")%></span>
                                            (<span id="deliverableCalendarCount"></span>)
                                        </label>
                                    </div>

                                    <div class="calendar-legend">
                                        <!-- Holidays -->
                                        <span class="legend-item">
                                            <span class="legend-box orange"></span><%=MyBase.GetResourceString("C_Hol")%>
                                        </span>
                                        <!-- Leaves -->
                                        <span class="legend-item">
                                            <span class="legend-box blue"></span><%=MyBase.GetResourceString("C_Leave")%>
                                        </span>
                                    </div>
                                </div>

                                <div class="calendar-head">
                                    <div class="calendar-nav">
                                        <!-- commented and added by Aditya J. on 20-03-2026 for tooltip -->
                                        <%--<button class="cal-nav-btn" type="button" aria-label="Previous" id="btnCalPrev">--%>
                                        <button class="cal-nav-btn" type="button" aria-label="Previous" id="btnCalPrev" data-bs-toggle="tooltip" title="Prev Month">
                                            <!-- End of commented and added by Aditya J. on 20-03-2026 for tooltip -->
                                        <i class="fas fa-chevron-left"></i>
                                        </button>

                                        <!-- This label will show Month name OR Week range -->
                                        <div class="calendar-month" id="lblCalendarMonth"></div>

                                        <!-- commented and added by Aditya J. on 20-03-2026 for tooltip -->
                                        <%--<button class="cal-nav-btn" type="button" aria-label="Next" id="btnCalNext" >--%>
                                        <button class="cal-nav-btn" type="button" aria-label="Next" id="btnCalNext" data-bs-toggle="tooltip" title="Next Month">
                                            <!-- End of commented and added by Aditya J. on 20-03-2026 for tooltip -->
                                        <i class="fas fa-chevron-right"></i>
                                        </button>
                                    </div>

                                    <!-- RIGHT SIDE ACTIONS -->
                                    <div class="cal-actions">
                                        <div class="cal-view-toggle" role="group" aria-label="Calendar View Toggle">
                                        <button type="button" class="cal-view-btn" id="btnViewWeekly"><%=MyBase.GetResourceString("C_Week")%></button>
                                        <button type="button" class="cal-view-btn active" id="btnViewMonthly"><%=MyBase.GetResourceString("C_Month")%></button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Monthly View Calendar -->
                                <div class="calendar-grid" id="calendarGrid">
                                </div>
                                <!-- Weekly View Calendar -->
                                <div class="calendar-week-wrap d-none" id="calendarWeekWrap">
                                    <div class="calendar-week" id="calendarWeek"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Added by Gauri - Task Timesheet Details Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-70" data-bs-scroll="false" tabindex="-1" id="offcanvasTaskTimesheetDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4 graybg">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_TaskTSDetls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="TS_Details_Section mb-2">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-5 text-end">
                                    <label><%=MyBase.GetResourceString("C_TaskName")%>: </label>
                                </div>
                                <div class="col-sm-7">
                                    <span id="TaskNameTaskTS"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-5 text-end">
                                    <label><%=MyBase.GetResourceString("C_StDate")%>: </label>
                                </div>
                                <div class="col-sm-7">
                                    <span id="TaskStartDateTaskTS"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-5 text-end">
                                    <label><%=MyBase.GetResourceString("C_Dev")%>: </label>
                                </div>
                                <div class="col-sm-7">
                                    <span id="TaskDeliverablesTaskTS"></span>
                                </div>
                            </div>
                             <div class="row">
                                <div class="col-sm-5 text-end">
                                    <label><%=MyBase.GetResourceString("C_PlannedEfrt")%></label>
                                </div>
                                <div class="col-sm-7">
                                    <span id="TaskPlannedEffort"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-5 text-end">
                                    <label><%=MyBase.GetResourceString("C_Res")%>: </label>
                                </div>
                                <div class="col-sm-7">
                                    <span id="TaskResourcesTaskTS"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-5 text-end">
                                    <label><%=MyBase.GetResourceString("C_EndDate")%>: </label>
                                </div>
                                <div class="col-sm-7">
                                    <span id="TaskEndDateTaskTS"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-5 text-end">
                                    <label><%=MyBase.GetResourceString("C_Mil")%>: </label>
                                </div>
                                <div class="col-sm-7">
                                    <span id="TaskMilestonesTaskTS"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ts-details-wrap">
                    <div class="text-end mb-2">
                        <button class="btn borderbtn" id="CloseTaskBtn" onclick="CloseTaskTimesheet()"><%=MyBase.GetResourceString("C_CloseTask")%></button>
                        <button class="btn btnyellow" id="applyFilterBtn" onclick="ValidationTimesheetDetailsList()"><%=MyBase.GetResourceString("C_Save")%></button>
                    </div>
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div id="TS_Div">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="mb-2"><%=MyBase.GetResourceString("C_TodayDate")%>:</label>
                                    <div id="TodayDateTaskTS"></div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="mb-2"><%=MyBase.GetResourceString("C_WHrs")%>:</label>
                                    <div id="WorkHoursTaskTS">

                                        <%--<input type="text" class="inputTS" id="WorkHrsTasksTS">--%>
                                   <%--// Added by Vaibhav K on 20-03-26 - Show placeholder for yet to start tasks, not 00:00--%>
<input type="text" class="inputTS" id="WorkHrsTasksTS" 
    placeholder="00:00" 
    maxlength="5"
    autocomplete="off">
                                        <%--// End of Added by Vaibhav K on 20-03-26--%>
                                        
                                    
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="mb-2"><%=MyBase.GetResourceString("C_ActHrsTillDate")%>:</label>
                                    <div id="ActualHoursTillDateTaskTS"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Task Timesheet Details Offcanvas End -->

        <!-- Added by Gauri - Issue Timesheet Details Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-70" data-bs-scroll="false" tabindex="-1" id="offcanvasIssueTimesheetDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IssTSDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="IssueTS_DetailsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_Proj")%></th>
                                        <th><%=MyBase.GetResourceString("C_Res")%></th>
                                        <th><%=MyBase.GetResourceString("C_TaskName")%></th>
                                        <th><%=MyBase.GetResourceString("C_EntDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_Work")%></th>
                                        <!-- <th class="text-center" style="width: 140px;">Status</th> -->
                                    </tr>
                                </thead>

                                <tbody id="IssueTS_DetailsTBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Issue Timesheet Details Offcanvas End -->

        <!-- Added by Gauri - Timesheet Details Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-70" data-bs-scroll="false" tabindex="-1" id="offcanvasTimesheetDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_TSDetls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="TimesheetDetailsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_Proj")%></th>
                                        <th><%=MyBase.GetResourceString("C_Res")%></th>
                                        <th><%=MyBase.GetResourceString("C_TaskName")%></th>
                                        <th><%=MyBase.GetResourceString("C_EntDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_Work")%></th>
                                        <!-- <th class="text-center" style="width: 140px;">Status</th> -->
                                    </tr>
                                </thead>

                                <tbody id="TimesheetDetailsTBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Timesheet Details Offcanvas End -->

         <!-- Added by Gauri - Issue Details Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-50" data-bs-scroll="false" tabindex="-1" id="offcanvasIssueDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IssDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="TS_Details_Section borderSec mb-2">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_ProjName")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="IssueProjectName"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_IssName")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="IssueNameTS"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_IssID")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="IssueIDTS"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_RepDate")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="IssueReportedDate"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_ResPerson")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="IssueResponsiblePerson"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_IssAging")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="IssueAgingDays"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Issue Details Offcanvas End -->

         <!-- Added by Gauri - Deliverables Details Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-50" data-bs-scroll="false" tabindex="-1" id="offcanvasDeliverablesDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_DelDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="TS_Details_Section borderSec mb-2">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_ProjName")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="DelProjectName"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_Devble")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="DelDeliverables"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_StDate")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="DelStartDate"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_EndDate")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="DelEndDate"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_Status")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="DelStatus"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_Priority")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="DelPriority"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Deliverables Details Offcanvas End -->

         <!-- Added by Gauri - Milestone Details Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-50" data-bs-scroll="false" tabindex="-1" id="offcanvasMilestoneDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_MileDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="TS_Details_Section borderSec mb-2">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_ProjName")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="MilestoneProjectName"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_Mil")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="MilestoneName"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_StDate")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="MilestoneStartDate"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_EndDate")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="MilestoneEndDate"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_MileAging")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="MilestoneAging"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_MileStatus")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="MilestoneStatus"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Milestone Details Offcanvas End -->
         
        <!-- Added by Gauri - Review Details Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-50" data-bs-scroll="false" tabindex="-1" id="offcanvasReviewDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_RevDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="TS_Details_Section borderSec mb-2">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_ProjName")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="ReviewProjectName"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_RevName")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="ReviewName"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_RevStartDate")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="ReviewStartDate"></span>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_RevEndDate")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="ReviewEndDate"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_Reviwee")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="ReviewReviwee"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3 text-end">
                                    <label><%=MyBase.GetResourceString("C_Reviwer")%>: </label>
                                </div>
                                <div class="col-sm-9">
                                    <span id="ReviewReviewer"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Review Details Offcanvas End -->
         
        <!-- Added by Gauri - Discussion Thread Offcanvas start -->
        <div class="offcanvas offcanvas-end dt-offcanvas" tabindex="-1" id="offcanvasDiscussionThreadIssue" aria-labelledby="offcanvasDiscussionThreadIssueLabel">
          <!-- Header -->
          <div class="offcanvas-header dt-header px-4 pt-3 pb-2">
            <div class="d-flex gap-2 w-100">
              <div class="dt-h-ico">
                <i class="far fa-comment-dots"></i>
              </div>

              <div class="flex-grow-1">
                <div class="dt-title" id="DT_Label"><%=MyBase.GetResourceString("C_DiscThread")%></div>
                <!-- <div class="dt-subtitle">Chart rendering delay</div> -->
              </div>

              <button type="button" class="dt-close" data-bs-dismiss="offcanvas" aria-label="Close" title="Close">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>

          <div class="dt-divider"></div>

          <!-- Body -->
          <div class="offcanvas-body dt-body px-4 py-2">
            <div class="d-flex">
                <div class="noteCard">
                    <span class="font-weight-500"><%=MyBase.GetResourceString("C_Note")%>: </span><%=MyBase.GetResourceString("C_DiscNote")%>
                </div>
                <div class="dt-meta mb-2 text-end">
                    <span class="dt-pill"><%=MyBase.GetResourceString("C_IssID")%>: <b id="IssueID_DT"></b></span>
                </div>
            </div>

            <!-- Composer -->
            <div class="dt-card dt-composer">
                <div class="d-flex">
                    <div class="dt-composer-top">
                        <div class="dt-avatar dt-avatar-blue" id="loginstart">A</div>
                        <div class="dt-who">
                        <!-- User Name -->
                        <div class="dt-name" id="DT_User"></div>
                        <!-- Current Date and Time -->
                        <div class="dt-time" id="DT_CurrDateTime"></div>
                        </div>
                    </div>
                    <div class="text-end mb-2">
                        <button class="btn btnyellow" id="btnPostComment"><%=MyBase.GetResourceString("C_Save")%></button>
                    </div>
                </div>

              <div class="dt-inputwrap mt-3">
                <textarea id="DT_Comment" class="dt-textarea" rows="4" maxlength="500"
                  placeholder="Add your comment... (max 500 characters)"></textarea>
              </div>

              <!-- <div class="dt-actions mt-2"> -->
              <div class="mt-2">
                <div class="row">
                    <div class="col-sm-4">
                        <div class="dt-field">
                            <label class="dt-label"><%=MyBase.GetResourceString("C_Status")%>:</label>
                            <select class="selectpicker" data-live-search="true" id="statusDiscThread"></select>
                        </div>
                    </div>
                    <div class="col-sm-4 d-flex">
                        <div class="form-group d-flex align-items-center justify-content-center">
                            <%=MyBase.GetResourceString("C_ShowCust")%>
                            <label class="switch mx-2">
                                <input type="checkbox" checked id="chkShowToCustomer">
                                <span class="slider"></span>
                            </label> 
                        </div>
                    </div>
                </div>
              </div>

              <!-- <button type="button" class="dt-postbtn mt-3" id="btnPostComment" style="opacity: 0.5;">
                <i class="fas fa-paper-plane me-2"></i> Post Comment
              </button> -->
            </div>

            <!-- Previous Comments -->
            <div class="dt-section mt-4">
              <div class="dt-section-hd">
                <div class="dt-section-title"><%=MyBase.GetResourceString("C_PrevCom")%></div>
                <span class="dt-countpill" id="prevCommentsValue"></span>
              </div>

              <div class="dt-comments mt-2" id="IBDiscussionContainer"></div>
            </div>
          </div>
        </div>
        <!-- Added by Gauri - Discussion Thread Offcanvas End -->

        <!-- Added by Gauri - Review Actions on Review List View Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-70" tabindex="-1" id="offcanvasReviewActions">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_RevActions")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="ReviewActionsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_Action")%></th>
                                        <th><%=MyBase.GetResourceString("C_RevCause")%></th>
                                        <th class="text-center" style="width: 90px;"><%=MyBase.GetResourceString("C_WorkHr")%></th>
                                    </tr>
                                </thead>

                                <tbody id="ReviewActionsTBody"></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Review Actions on Review List View Offcanvas End -->
         
        <!-- Added by Gauri - Task details on Calendar Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-85" tabindex="-1" id="offcanvasCalendarTaskDetails">
            <div class="offcanvas-header graybg">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_TsDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="TaskDetailsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_ProjName")%></th>
                                        <th><%=MyBase.GetResourceString("C_Tasks")%></th>
                                        <th><%=MyBase.GetResourceString("C_StDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_EndDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_ActStart")%></th>
                                        <th><%=MyBase.GetResourceString("C_PlWork")%></th>
                                        <th><%=MyBase.GetResourceString("C_ActWork")%></th>
                                    </tr>
                                </thead>

                                <tbody id="TaskDetailsTBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Added by Aditya J. on 20-03-2026 for pagination of Task Details -->
                    <div class="cstm_pagination mt-2" id="paginationControlsTaskDetails" style="display:none;">
                        <div class="d-flex justify-content-end w-100">
                            <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                <span class="spntotal" id="TotalRecordsTaskDetails"></span>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-end" style="margin: 0px!important">
                                        <li class="page-item" id="btnPreviousTaskDetails">
                                            <a class="page-link" aria-label="Previous" onclick="PrevTaskDetailsList()" id="LinkPreviousTaskDetails">
                                                <i class="fas fa-angle-double-left"></i>
                                            </a>
                                        </li>
                                        <li class="page-item" id="btnNextTaskDetails">
                                            <a class="page-link" aria-label="Next" onclick="NextTaskDetailsList()" id="LinkNextTaskDetails">
                                                <i class="fas fa-angle-double-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- End of Added by Aditya J. on 20-03-2026 for pagination of Task Details -->
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Task details on Calendar Offcanvas End -->
       
        <!-- Added by Gauri - Issue details on Calendar Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-85" tabindex="-1" id="offcanvasCalendarIssueDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IssDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="IssueDetailsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_ProjName")%></th>
                                        <th><%=MyBase.GetResourceString("C_IssID")%></th>
                                        <th><%=MyBase.GetResourceString("C_IssStatus")%></th>
                                        <th><%=MyBase.GetResourceString("C_Summary")%></th>
                                        <th><%=MyBase.GetResourceString("C_StDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_EndDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_PlWork")%></th>
                                        <th><%=MyBase.GetResourceString("C_ActWork")%></th>
                                    </tr>
                                </thead>

                                <tbody id="IssueDetailsTBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Added by Aditya J. on 20-03-2026 for pagination of Issue Details -->
                    <div class="cstm_pagination mt-2" id="paginationControlsIssueDetails" style="display:none;">
                        <div class="d-flex justify-content-end w-100">
                            <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                <span class="spntotal" id="TotalRecordsIssueDetails"></span>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-end" style="margin: 0px!important">
                                        <li class="page-item" id="btnPreviousIssueDetails">
                                            <a class="page-link" aria-label="Previous" onclick="PrevIssueDetailsList()" id="LinkPreviousIssueDetails">
                                                <i class="fas fa-angle-double-left"></i>
                                            </a>
                                        </li>
                                        <li class="page-item" id="btnNextIssueDetails">
                                            <a class="page-link" aria-label="Next" onclick="NextIssueDetailsList()" id="LinkNextIssueDetails">
                                                <i class="fas fa-angle-double-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- End of Added by Aditya J. on 20-03-2026 for pagination of Issue Details -->
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Issue details on Calendar Offcanvas End -->
  
        <!-- Added by Gauri - Reviews details on Calendar Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-85" tabindex="-1" id="offcanvasCalendarReviewsDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_RevDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="ReviewsDetailsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_ProjName")%></th>
                                        <th><%=MyBase.GetResourceString("C_Revs")%></th>
                                        <th><%=MyBase.GetResourceString("C_RevType")%></th>
                                        <th><%=MyBase.GetResourceString("C_Status")%></th>
                                        <th><%=MyBase.GetResourceString("C_RevStartDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_RevEndDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_RevBy")%></th>
                                        <th><%=MyBase.GetResourceString("C_Reviewee")%></th>
                                    </tr>
                                </thead>

                                <tbody id="ReviewsDetailsTBody"></tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Added by Aditya J. on 20-03-2026 for pagination of Review Details -->
                    <div class="cstm_pagination mt-2" id="paginationControlsReviewDetails" style="display:none;">
                        <div class="d-flex justify-content-end w-100">
                            <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                <span class="spntotal" id="TotalRecordsReviewDetails"></span>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-end" style="margin: 0px!important">
                                        <li class="page-item" id="btnPreviousReviewDetails">
                                            <a class="page-link" aria-label="Previous" onclick="PrevReviewDetailsList()" id="LinkPreviousReviewDetails">
                                                <i class="fas fa-angle-double-left"></i>
                                            </a>
                                        </li>
                                        <li class="page-item" id="btnNextReviewDetails">
                                            <a class="page-link" aria-label="Next" onclick="NextReviewDetailsList()" id="LinkNextReviewDetails">
                                                <i class="fas fa-angle-double-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- End of Added by Aditya J. on 20-03-2026 for pagination of Review Details -->
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Reviews details on Calendar Offcanvas End -->

        <!-- Added by Gauri - Milestones details on Calendar Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-85" tabindex="-1" id="offcanvasCalendarMilestonesDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_MileDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="MilestonesDetailsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_ProjName")%></th>
                                        <th><%=MyBase.GetResourceString("C_Mil")%></th>
                                        <th><%=MyBase.GetResourceString("C_StDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_EndDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_ActStart")%></th>
                                        <th><%=MyBase.GetResourceString("C_MileStatus")%></th>
                                        <th><%=MyBase.GetResourceString("C_ActWork")%></th>
                                    </tr>
                                </thead>

                                <tbody id="MilestonesDetailsTBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Added by Aditya J. on 20-03-2026 for pagination of Milestone Details -->
                    <div class="cstm_pagination mt-2" id="paginationControlsMilestoneDetails" style="display:none;">
                        <div class="d-flex justify-content-end w-100">
                            <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                <span class="spntotal" id="TotalRecordsMilestoneDetails"></span>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-end" style="margin: 0px!important">
                                        <li class="page-item" id="btnPreviousMilestoneDetails">
                                            <a class="page-link" aria-label="Previous" onclick="PrevMilestoneDetailsList()" id="LinkPreviousMilestoneDetails">
                                                <i class="fas fa-angle-double-left"></i>
                                            </a>
                                        </li>
                                        <li class="page-item" id="btnNextMilestoneDetails">
                                            <a class="page-link" aria-label="Next" onclick="NextMilestoneDetailsList()" id="LinkNextMilestoneDetails">
                                                <i class="fas fa-angle-double-right"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>           
        </div>
        <!-- Added by Gauri - Milestones details on Calendar Offcanvas End -->

        <!-- Added by Gauri - Deliverables details on Calendar Offcanvas start -->
        <div class="offcanvas offcanvas-end detail-offcanvas offcanvas-85" tabindex="-1" id="offcanvasCalendarDeliverablesDetails">
            <div class="offcanvas-header border-0 pt-3 pb-2 px-4">
                <div class="row flex-grow-1">
                    <div class="col-sm-10">
                        <h5 class="pgtitle"><%=MyBase.GetResourceString("C_DelDtls")%></h5>
                    </div>
                    <div class="col-sm-2 text-end">
                        <button type="button" class="btn btn-sm btn-danger-modern" data-bs-toggle="tooltip" title="Close"
                            data-bs-dismiss="offcanvas" onclick="$('body').removeClass('offcanvas-open');">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="offcanvas-body px-4 pb-4">
                <div class="ts-details-wrap">
                    <!-- Table -->
                    <div class="ts-table-card">
                        <div class="table-responsive">
                            <table class="table ts-table align-middle mb-0" id="DeliverablesDetailsTable">
                                <thead>
                                    <tr>
                                        <th><%=MyBase.GetResourceString("C_ProjName")%></th>
                                        <th><%=MyBase.GetResourceString("C_Title")%></th>
                                        <th><%=MyBase.GetResourceString("C_StDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_EndDate")%></th>
                                        <th><%=MyBase.GetResourceString("C_ActStart")%></th>
                                        <th><%=MyBase.GetResourceString("C_ActWork")%></th>
                                    </tr>
                                </thead>

                                <tbody id="DeliverableDetailsTBody">
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details -->
                        <div class="cstm_pagination mt-2" id="paginationControlsDeliverableDetails" style="display:none;">
                            <div class="d-flex justify-content-end w-100">
                                <div class="buttons" style="display: flex; align-items: center; gap: 10px;">
                                    <span class="spntotal"><%=MyBase.GetResourceString("C_TotRec")%>: </span>
                                    <span class="spntotal" id="TotalRecordsDeliverableDetails"></span>
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-end" style="margin: 0px!important">
                                            <li class="page-item" id="btnPreviousDeliverableDetails">
                                                <a class="page-link" aria-label="Previous" onclick="PrevDeliverableDetailsList()" id="LinkPreviousDeliverableDetails">
                                                    <i class="fas fa-angle-double-left"></i>
                                                </a>
                                            </li>
                                            <li class="page-item" id="btnNextDeliverableDetails">
                                                <a class="page-link" aria-label="Next" onclick="NextDeliverableDetailsList()" id="LinkNextDeliverableDetails">
                                                    <i class="fas fa-angle-double-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                        <!-- End of Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details -->
                    </div>
                </div>
            </div>
        </div>
        <!-- Added by Gauri - Deliverables details on Calendar Offcanvas End -->

        <!--Confirmation message Modal Added By Gauri -->
        <div id="ConfirmMessagemodalinfo" class="modal fade custmodal" role="dialog" data-bs-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" id="btnConfirmTaskNo1" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><%=MyBase.GetResourceString("C_Msg")%></h4>
                    </div>
                    <div class="modal-body">
                        <span class="sm_txt" id="ConfirmationMsg"></span>
                    </div>
                    <div class="modal-footer">
                        <button class="btn borderbtn float-start uncheckbtn" data-bs-dismiss="modal" id="btnConfirmTaskNo"><%=MyBase.GetResourceString("C_No")%></button>
                        <button class="btn btnyellow" data-bs-toggle="modal" data-bs-dismiss="modal" id="btnConfirmTaskYes" onclick="saveTaskTimesheetDetailsList()"><%=MyBase.GetResourceString("C_Yes")%></button>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--End of Confirmation message Modal Added By Gauri -->
    </div>

    <!-- JS references (same as Project_Profitability.html) -->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/dist/js/jquery.calendar.js"></script>-->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script> -->

    <!-- ChartJS 1.0.1 -->
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>

    <script type="text/javascript">
        // Added by Gauri on 01/01/2026
        // Global variables
        
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';

        var defaultProjectID ='<%= Session("intProjectID")%>';

        if (!defaultProjectID) {

            defaultProjectID=null;
        }

        var defaultEmployeeID = <%= Session("intUserID") %>;
        var defaultEmployeeName = '<%= Session("strUserName") %>';
        var selectdTaskID = null;
        var selectdProjectID = null;
        var selectdActualHrs = null;
        var dailyActivityEntryID = null;        
        var isAgile = null;        
        var isClosedTask = null;  
        
        var getFromMailID = null;        
        var getCCMailID = null;        
        var getSubjectTxt = null;
        var getBodyTxt = null;

        // Loader state (used by showLoader / hideLoader)
        var loaderShown = false;        
        var loaderStartTime = 0;     

        // var defaultTagID = <%= Session("intTagID") %>;
        // console.log("defaultTagID", defaultTagID);
        // var defaultProjectName = null;
        
        // Store all tasks for filtering
        var allTasksList = [];
        
        // Store all issues for filtering
        var allIssuesList = [];
        
        // Store all deliverables for filtering
        var allDeliverablesList = [];
        
        // Store all reviews for filtering
        var allReviewsList = [];

        var sessionProjectId = '<%= Session("intProjectID") %>';


        $(document).ready(function () {
            
            
            loadAccessibleProjects();


            $('[data-bs-toggle="tooltip"]').tooltip();
            alertify.set('notifier', 'position', 'top-right');
            
            bindMenuTabsFromApi();
            getWhizibleTodayWBSCount();

            getWhizibleTodayTasksListByCategory("RUNNING", defaultProjectID);
            initTaskPagination();
            initIssuePagination();
            initDeliverablePagination();
            initReviewPagination();
            initMilestonePagination()

            // Initialize calendar navigation
            initCalendarNav();
            
            // Handle Bootstrap Selectpicker change event for project task dropdown
            $(document).on('changed.bs.select', '#cboProjectTask', function() {
                ProjectTaskOnChange();
            });
            
            // Handle Bootstrap Selectpicker change event for project issue dropdown
            $(document).on('changed.bs.select', '#cboProjectIssue', function() {
                ProjectIssueOnChange();
            });
            
            // Handle Bootstrap Selectpicker change event for project deliverable dropdown
            $(document).on('changed.bs.select', '#cboProjectDel', function() {
                ProjectDeliverableOnChange();
            });

            $(document).on('changed.bs.select change', '#cboProjectReview', function () {
                ProjectReviewOnChange();
            });

            $(document).on('changed.bs.select change', '#cboProjectMile', function () {
                ProjectMilestoneOnChange();
            });

            // $(window).one('wheel touchmove keydown', function () {
            //     $('body').css('overflow-y', 'auto');
            // });

            // Initial page load complete: hide preloader and show main content
            $("#DevDashboardSec").hide();
            $("#DevDashboardWrapper").show();

            //ensureProjectPlaceholder(
            //    '#cboProjectTask',
            //    function () {
            //        console.log('Dropdown ready');
            //    },
            //    defaultProjectID
            //);




            //ensureProjectPlaceholder(
            //    '#cboProjectIssue',
            //    function () {
            //        console.log('Dropdown ready');
            //    },
            //    defaultProjectID
            //);


            //ensureProjectPlaceholder(
            //    '#cboProjectDel',
            //    function () {
            //        console.log('Dropdown ready');
            //    },
            //    defaultProjectID
            //);

            //ensureProjectPlaceholder(
            //    '#cboProjectReview',
            //    function () {
            //        console.log('Dropdown ready');
            //    },
            //    defaultProjectID
            //);

            //ensureProjectPlaceholder(

            //    '#cboProjectMile',
            //    function () {
            //        console.log('Dropdown ready');
            //    },
            //    defaultProjectID
            //);
        })


        function loadAccessibleProjects() {
            
           
            if (!defaultProjectID) {

                defaultProjectID = null;
            }
          
            var param = {
                userId: defaultEmployeeID,
                loginType: 'E',
                projectID: defaultProjectID,
                showReleasedProjects: null,
                loginId: null,
                whereCriteria: null,
                orderBy: null
            };

            var url = "api/DeveloperDashEnView/GetAccesibleProject";

            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            if (result && Array.isArray(result.data)) {

                var dropdowns = $(
                    "#cboProjectTask, " +
                    "#cboProjectIssue, " +
                    "#cboProjectDel, " +
                    "#cboProjectReview, " +
                    "#cboProjectMile"
                );

                dropdowns.empty();

                result.data.forEach(function (item) {

                    var option = $("<option>", {
                        value: item.projectID,
                        text: item.projectName
                    });

                    dropdowns.each(function () {
                        $(this).append(option.clone());
                    });
                });

                dropdowns.selectpicker('refresh');
            }


        }
        //$('#cboProjectTask').on('shown.bs.select', function () {

        //    var $select = $(this);

        //    // Get scroll container (div.inner)
        //    var $scrollContainer = $select.parent().find('.inner.show').first();

        //    // Get active item
        //    var $activeItem = $scrollContainer.find('.dropdown-item.active');

        //    if ($activeItem.length) {

        //        var container = $scrollContainer[0];
        //        var item = $activeItem[0];

        //        container.scrollTop =
        //            item.offsetTop - container.offsetTop
        //            - (container.clientHeight / 2)
        //            + (item.clientHeight / 2);

        //    }

        //});



        // Added by Gauri - Enhanced AJAX helper with better error handling
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

        //// Added by Gauri - Ensure dropdown has placeholder and options are loaded before setting value
        //function ensureProjectPlaceholder(selector, onReady) {
        //    
        //    var $ddl = $(selector);
        //    if (!$ddl.length) return;

        //    var tries = 0;
        //    var maxTries = 10; // 10 * 150ms = 1.5s max wait

        //    (function waitForOptions() {
        //        var $options = $ddl.find('option');
        //        var hasOptions = $options.length > 0;
        //        var hasPlaceholder = $ddl.find('option[value=""]').length > 0;

        //        // Wait until options are populated (server-side or ajax)
        //        if (!hasOptions && tries < maxTries) {
        //            tries++;
        //            return setTimeout(waitForOptions, 150);
        //        }

        //        // If placeholder already exists OR no options exist at all, just set default and call onReady
        //        if (hasPlaceholder || !hasOptions) {
        //            setDropdownValue($ddl, '');
        //            if (typeof onReady === 'function') onReady();
        //            return;
        //        }

        //        // Add placeholder
        //        var isSelectpicker = !!($ddl.data('selectpicker') || $ddl.hasClass('selectpicker'));
        //        var canSelectpicker = isSelectpicker && typeof $.fn.selectpicker !== 'undefined';

        //        // Clone existing options
        //        var existing = $ddl.find('option').clone();

        //        // Destroy selectpicker only if needed
        //        if (canSelectpicker) {
        //            try { $ddl.selectpicker('destroy'); } catch (e) {}
        //        }

        //        // Rebuild options with placeholder first
        //        $ddl.empty()
        //            .append('<option value="" selected>Select Project</option>')
        //            .append(existing);

        //        // Always default to placeholder
        //        $ddl.val('');

        //        // Re-init selectpicker if needed
        //        if (canSelectpicker) {
        //            $ddl.selectpicker({ liveSearch: true, dropupAuto: false });
        //            $ddl.selectpicker('val', '');
        //        }

        //        // Callback once ready
        //        if (typeof onReady === 'function') onReady();
        //    })();
        //}

        //// Ensure dropdown options are loaded and set selected value
        function ensureProjectPlaceholder(selector, onReady, selectedValue) {
            
            var $ddl = $(selector);
            if (!$ddl.length) return;

            var tries = 0;
            var maxTries = 10; // 10 × 150ms = 1.5s max wait

            (function waitForOptions() {

                var $options = $ddl.find('option');
                var hasOptions = $options.length > 0;

                // Wait until options are populated
                if (!hasOptions && tries < maxTries) {
                    tries++;
                    return setTimeout(waitForOptions, 150);
                }

                // ✅ Set selected value if available
                if (selectedValue && selectedValue !== "0") {
                    $ddl.val(selectedValue);
                }

                // Refresh selectpicker if used
                var isSelectpicker = !!($ddl.data('selectpicker') || $ddl.hasClass('selectpicker'));
                var canSelectpicker = isSelectpicker && typeof $.fn.selectpicker !== 'undefined';

                if (canSelectpicker) {
                    try {
                        $ddl.selectpicker('refresh');
                        if (selectedValue && selectedValue !== "0") {
                            $ddl.selectpicker('val', selectedValue);
                        }
                    } catch (e) {
                        console.warn('Selectpicker refresh failed:', e);
                    }
                }

                // Execute callback
                if (typeof onReady === 'function') {
                    onReady();
                }

            })();
        }

       



        // Helper to set dropdown value, compatible with selectpicker or regular select
        function setDropdownValue($ddl, value) {
            var isSelectpicker = !!($ddl.data('selectpicker') || $ddl.hasClass('selectpicker'));
            if (isSelectpicker && typeof $.fn.selectpicker !== 'undefined') {
                $ddl.selectpicker('val', value);
            } else {
                $ddl.val(value);
            }
        }

        //ensureProjectPlaceholder('#cboProjectTask', function () {
        //    // RUNNING tasks
        //    allTasksList = getWhizibleTodayTasksListByCategory('RUNNING', null);
        //    bindTaskList('RunningTasksList', allTasksList);
        //    initTaskPagination();
        //});

        // ISSUES
        // ensureProjectPlaceholder('#cboProjectIssue', function () {
        //     if (typeof getWhizibleTodayIssuesList === 'function') getWhizibleTodayIssuesList(null);
        // });

        // Added by Gauri - Load issues based on selected project and active tab (current vs old)
        function loadIssuesByActiveProject(isCurrent) {
            var sel = getSelectedProject($('#cboProjectIssue'));
            var pid = sel && sel.id ? parseInt(sel.id, 10) : null;
            if (isNaN(pid)) pid = null;

            getWhizibleTodayIssuesList(pid, isCurrent);
        }

        // Issues
        ensureProjectPlaceholder('#cboProjectIssue', function () {
            
            loadIssuesByActiveProject(true);
        });


        // DELIVERABLES
        ensureProjectPlaceholder('#cboProjectDel', function () {
           
            // IMPORTANT: Initial load should show ALL deliverables
            if (typeof getWhizibleTodayDeliverablesList === 'function') {
                getWhizibleTodayDeliverablesList(null);
            }
        });

        // REVIEWS
        ensureProjectPlaceholder('#cboProjectReview', function () {
            
            if (typeof getWhizibleTodayReviewsList === 'function') {
                getWhizibleTodayReviewsList(null);
            }
            // OR API call: getTodayReviewsList(null);
        });

        // Milestones
        ensureProjectPlaceholder('#cboProjectMile', function () {
            
            if (typeof getWhizibleTodayMilestonesList === 'function') {
                getWhizibleTodayMilestonesList(null);
            }
            // OR API call: getTodayReviewsList(null);
        });

        $('#StartDateInput, #EndDateInput').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            yearRange: 'c-100:c+100',
            dateFormat: 'dd M yy',
            onSelect: function (date) {
                // $('.modal').modal('handleUpdate')
                //bodyFreezeScroll();
            },
        });

        // Added by Gauri - Bind Menu Tabs from API
        function bindMenuTabsFromApi() {     
            // var tagId = getMasterTagIdFromUrl(); 
            var tagId = 1005; // session-like (MasterTagId)
            // var tagId = defaultTagID; // session-like (MasterTagId)
            if (!tagId) {
                console.error("MasterTagId not found in URL");
                return;
            }

            var param = {
                tagId: tagId
            };

            var url = "api/DeveloperDashEnView/GetMenuSettings"; // replace if different
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            var list = [];
            if (result && Array.isArray(result.data)) {
                list = result.data;
            }

            // renderMenuTabs(list);
            var $tabs = $('#menuTabsContainer');
            if (!$tabs.length) return;

            $tabs.empty();

            if (!list || !list.length) return;

            // sort by sectionId, then orderNo
            list.sort(function (a, b) {
                var s1 = a.sectionId || 0, s2 = b.sectionId || 0;
                if (s1 !== s2) return s1 - s2;
                return (a.orderNo || 0) - (b.orderNo || 0);
            });

            for (var i = 0; i < list.length; i++) {
                var item = list[i];

                var caption = item.caption || '';
                var paneId = toPaneId(caption);
                var isActive = (i === 0);

                var html = ''
                    + '<li class="nav-item" role="presentation">'
                    +   '<a class="nav-link NavTabsStyle ' + (isActive ? 'active' : '') + '" '
                    +      'href="#' + paneId + '" '
                    +      'data-bs-toggle="tab" '
                    +      'role="tab">'
                    +      getTabIcon(caption) + caption
                    +   '</a>'
                    + '</li>';

                $tabs.append(html);

                 $('#menuTabContent').append(
                    '<div class="tab-pane fade ' + (isActive ? 'show active' : '') + '" ' +
                        'id="' + paneId + '" role="tabpanel"></div>'
                );
            }

            // IMPORTANT: initialize Bootstrap tab for dynamic tabs
            var firstTabEl = document.querySelector('#menuTabsContainer .nav-link.active');

            if (firstTabEl) {
                var firstTab = new bootstrap.Tab(firstTabEl);
                firstTab.show();
            }
        }

        // Added by Gauri - Handle tab shown event to load content as needed
        $(document).on('shown.bs.tab', '#menuTabsContainer .nav-link', function (e) {
            
            var targetPaneId = $(e.target).attr('href'); // e.g. #paneCalendar
            switch (targetPaneId) {
                case '#paneCalendar':
                    renderMonthlyView();
                    bindCalendarCountsForMonth();
                    bindCalendarHolidaysAndLeaves();
                    break;

                case '#paneWhizibleToday':
                    loadTodayApiOnce();
                    break;
            }
        });

        // Added by Gauri - Helper to convert caption to valid pane ID
        function toPaneId(caption) {
            return 'pane' + (caption || '')
                .replace(/\s+/g, '')
                .replace(/[^a-zA-Z0-9]/g, '');
        }

        // Added by Gauri - Helper to get icon HTML based on caption keywords
        function getTabIcon(caption) {
            caption = (caption || '').toLowerCase();
            if (caption.indexOf('today') > -1) return '<i class="fas fa-calendar-check pe-1"></i>';
            if (caption.indexOf('calendar') > -1) return '<i class="far fa-calendar-alt pe-1"></i>';
            if (caption.indexOf('report') > -1) return '<i class="far fa-file-alt pe-1"></i>';
            return '<i class="far fa-circle pe-1"></i>';
        }

        // Added by Gauri - Open Download Report Offcanvas
        $(document).on('click', '.btnDownloadReport', function () {
            var oc = new bootstrap.Offcanvas(document.getElementById('offcanvasDownloadReport'));
            oc.show();
        });

        // Added by Gauri - Fetch Tasks List 
        function getWhizibleTodayWBSCount() {

           
            var param = {
                employeeID: defaultEmployeeID || 0,
                projectID: null,
                taskEmployeeID: null,
                strUserName: defaultEmployeeName
            };

            var url = "api/DeveloperDashEnView/GetDeveloperDashboardCounts";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            var row = null;
            if (result && Array.isArray(result.data) && result.data.length) {
                row = result.data[0];
            }

            // Safe defaults
            row = row || {};

            // ----- Tasks -----
            $('#TasksOpenCount').text(row.openTaskCount != null ? row.openTaskCount : 0);
            $('#NewTasksCount').text(row.newOpenTask != null ? row.newOpenTask : 0);

            // ----- Issues -----
            if (row.openIssueCount != null) $('#IssuesOpenCount').text(row.openIssueCount);
            if (row.newOpenIssue != null) $('#NewIssuesCount').text(row.newOpenIssue);

            // ----- Reviews -----
            if (row.openReviewCount != null) $('#ReviewsOpenCount').text(row.openReviewCount);
            if (row.newOpenReview != null) $('#NewReviewsCount').text(row.newOpenReview);

            // ----- Deliverables -----
            if (row.openDeliverables != null) $('#DeliverablesOpenCount').text(row.openDeliverables);
            if (row.newDeliverables != null) $('#NewDeliverablesCount').text(row.newDeliverables);

            // ----- Milestones -----
            if (row.totalMilestones != null) $('#MilestonesOpenCount').text(row.totalMilestones);
            if (row.newOpenMilestones != null) $('#NewMilestonesCount').text(row.newOpenMilestones);
        }

        // Added by Gauri - Fetch Calendar WBS Count for the month view  
        // function getCalendarWBSCount(weekStart) {
        //     var monthStartISO = getMonthStartUTCISO(weekStart);

        //     var param = {
        //         employeeID: defaultEmployeeID || 0,
        //         projectID: null,
        //         taskEmployeeID: null,
        //         strUserName: defaultEmployeeName,
        //         monthStartDate: monthStartISO,
        //     };

        //     var url = "api/DeveloperDashEnView/GetDeveloperDashboardCounts";
        //     var result = AJAXCallWithResult(url, JSON.stringify(param), false);

        //     var row = null;
        //     if (result && Array.isArray(result.data) && result.data.length) {
        //         row = result.data[0];
        //     }

        //     // ----- Milestones -----
        //    $('#taskCalendarCount').text(row.openTaskCount);
        //    $('#issueCalendarCount').text(row.openIssueCount);
        //    $('#reviewCalendarCount').text(row.openReviewCount);
        //    $('#milestoneCalendarCount').text(row.newOpenMilestones);
        //    $('#deliverableCalendarCount').text(row.openDeliverables);
        // }
        function getCalendarWBSCount(mode, focusDate) {
            
            // focusDate should be a JS Date
            var monthStartISO = null;
            var weekStartISO  = null;

            if (mode === "month") {
                monthStartISO = getMonthStartUTCISO(focusDate);  // your existing helper
                weekStartISO  = null;
            } else if (mode === "week") {
                weekStartISO  = getWeekStartUTCISO(focusDate);   // helper below
                monthStartISO = null;
            }

            var param = {
                employeeID: defaultEmployeeID || 0,
                projectID: null,
                taskEmployeeID: null,
                strUserName: defaultEmployeeName,
                monthStartDate: monthStartISO,  
                weekstartDate: weekStartISO
            };

            var url = "api/DeveloperDashEnView/GetDeveloperDashboardCounts";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            var row = null;
            if (result && Array.isArray(result.data) && result.data.length) {
                row = result.data[0];
            }

            // ----- Milestones -----
           $('#taskCalendarCount').text(row.openTaskCount);
           $('#issueCalendarCount').text(row.openIssueCount);
           $('#reviewCalendarCount').text(row.openReviewCount);
            $('#milestoneCalendarCount').text(row.totalMilestones);
            $('#deliverableCalendarCount').text(row.openDeliverables);

            if (mode === "week") {
                weekStartISO = getWeekStartUTCISO(focusDate);   // helper below
                monthStartISO = null;
                bindCalendarHolidaysAndLeaves(weekStartISO);
            }

           

        }
        
        // Added by Gauri - Get selected project from dropdown
        function getSelectedProject($ddl) {
            // Works for bootstrap-select (selectpicker) and normal select
            var id = ($ddl.hasClass('selectpicker') || $ddl.data('selectpicker'))
                ? ($ddl.selectpicker('val') || '')
                : ($ddl.val() || '');

            var text = $ddl.find('option[value="' + id + '"]').text() || $ddl.find('option:selected').text() || '';

            // Normalize "no selection"
            if (!id || id === '0' || text.trim().toLowerCase() === 'select project') {
                return { id: null, text: '' };
            }

            return { id: id, text: text.trim() };
        }

        // Added by Gauri - Filter tasks based on selected project
        function getTaskProjectId(t) {
            if (!t) return null;
            if (t.projectID != null) return t.projectID;
            if (t.projectId != null) return t.projectId;
            if (t.ProjectID != null) return t.ProjectID;
            if (t.ProjectId != null) return t.ProjectId;
            return null;
        }

        // Added by Gauri - Get task project name
        function getTaskProjectName(t) {
            if (!t) return '';
            return (t.projectName || t.ProjectName || t.moduleName || t.ModuleName || '').toString().trim();
        }

        // Added by Gauri - Filter tasks based on selected project
        function filterRunningTasksByProject() {
            

            var sel = getSelectedProject($('#cboProjectTask'));
            var list = allTasksList || []; // RUNNING list stored here

            // nothing selected => show all
            if (!sel || !sel.id) {
                bindTaskList('RunningTasksList', list);
                initTaskPagination(); // running pagination
                return;
            }

            var filtered = list.filter(function (t) {
                var pid = getTaskProjectId(t);
                if (pid != null && pid !== '') return String(pid) === String(sel.id);

                var pname = getTaskProjectName(t);
                return (pname && sel.text) ? (pname === sel.text) : false;
            });

            bindTaskList('RunningTasksList', filtered);
            initTaskPagination();
        }

        // Added by Gauri - Filter old tasks based on selected project
        function filterOldTasksByProject() {
            var sel = getSelectedProject($('#cboProjectTask'));
            var list = allOldTasksList || []; // OLD list stored here

            if (!sel || !sel.id) {
                bindTaskList('OldTasksList', list);
                initOldTaskPagination(); // OLD pagination
                return;
            }

            var filtered = list.filter(function (t) {
                var pid = getTaskProjectId(t);
                if (pid != null && pid !== '') return String(pid) === String(sel.id);

                var pname = getTaskProjectName(t);
                return (pname && sel.text) ? (pname === sel.text) : false;
            });

            bindTaskList('OldTasksList', filtered);
            initOldTaskPagination();
        }

        // Added by Gauri - Filter yet to start tasks based on selected project
        function filterYetStartTasksByProject() {
            var sel = getSelectedProject($('#cboProjectTask'));
            var list = allYetStartTasksList || [];

            if (!sel || !sel.id) {
                bindTaskList("YetStartTasksList", list);
                initYetStartTaskPagination();
                return;
            }

            var filtered = list.filter(function (t) {
                var pid = getTaskProjectId(t);
                if (pid != null && pid !== '') return String(pid) === String(sel.id);

                var pname = getTaskProjectName(t);
                return (pname && sel.text) ? (pname === sel.text) : false;
            });

            bindTaskList("YetStartTasksList", filtered);
            initYetStartTaskPagination();
        }

        // Added by Gauri - Get active task category from tab
        function getActiveTaskCategory() {
            // Find the active tab button inside your task tabs container
            var activeBtn = document.querySelector('.nested_tabs .nav-link.active');

            // Option A: derive from a data attribute you control
            var cat = activeBtn?.getAttribute('data-category');
            if (cat) return cat;

            // Option B: derive from data-bs-target (pane id)
            var target = activeBtn?.getAttribute('data-bs-target') || '';
            target = target.toLowerCase();

            if (target.includes('running')) return 'RUNNING';
            if (target.includes('old')) return 'OLD';
            if (target.includes('yet')) return 'YETTOSTART';

            // fallback
            return 'RUNNING';
        }

        // Added by Gauri - Refresh active tasks tab
        function refreshActiveTasksTab() {
            var category = getActiveTaskCategory();
            getWhizibleTodayTasksListByCategory(category, null);
        }

        // globals for 3 lists
        var allTasksList = [];        // RUNNING
        var allOldTasksList = [];     // OLD
        var allYetStartTasksList = []; // YETTOSTART

        // Added by Gauri - Fetch Tasks List by Category
        function getWhizibleTodayTasksListByCategory(taskCategory, projectID) {
            
            var projectID = $('#cboProjectTask').val();

            var param = {
                employeeID: defaultEmployeeID || 61,
                projectID: projectID || null,
                taskEmployeeID: null,
                taskCategory: taskCategory || "RUNNING"
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayTasks";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // unwrap
            var list = [];
            if (result) {
                if (Array.isArray(result)) list = result;
                else if (result.data && Array.isArray(result.data)) list = result.data;
                else if (result.Tasks && Array.isArray(result.Tasks)) list = result.Tasks;
            }

            // store + bind + paginate based on category
            var cat = (taskCategory || '').toUpperCase();

            if (cat === "RUNNING") {
                allTasksList = list || [];
                filterRunningTasksByProject(); // will bind + paginate
                return;
            }

            if (cat === "OLD") {
                allOldTasksList = list || [];
                filterOldTasksByProject(); // will bind + paginate
                return;
            }

            if (cat === "YETTOSTART") {
                allYetStartTasksList = list || [];
                filterYetStartTasksByProject(); // will bind + paginate
                return;
            }

            // fallback: just return list
            return list || [];
        }
        
        // Added by Gauri - Handle project dropdown change for tasks
        function ProjectTaskOnChange() {
            // filterTasksByProject();
            refreshActiveTasksTab();
            filterRunningTasksByProject();
            filterOldTasksByProject();
            filterYetStartTasksByProject();

        }

        // Added by Gauri - Bind task list HTML
        function bindTaskList(containerId, list) {
            var $wrap = $('#' + containerId);
            if (!$wrap.length) return;

            if (!list || !list.length) {
                $wrap.html('<div class="text-center p-3 text-muted">No tasks found</div>');
                return;
            }

            var html = '';

            $.each(list, function (i, t) {
                var taskId = t.taskID || t.taskId || 0;
                var taskNo = t.taskNo || t.taskNumber || '';
                var taskName = t.taskName || t.title || '';
                var projectName = t.projectName || '';
                var priority = t.priority || 'Low';
                var status = (t.status || '').toString();
                var agingDays = t.taskAgingDays || 0;
                var agingDaysText = agingDays > 0 ? agingDays + 'd' : 'N/A';

                // Set status icon and colors based on aging days
                if (agingDays > 0) {
                    statusIconClass = 'red';
                    statusIcon = '<i class="far fa-times-circle"></i>';
                    borderColor = 'rgba(239,68,68,0.25)';
                    backgroundColor = 'rgba(239,68,68,0.04)';
                } else {
                    statusIconClass = 'green';
                    statusIcon = '<i class="far fa-check-circle"></i>';
                    borderColor = 'rgba(34,197,94,0.25)';
                    backgroundColor = 'rgba(34,197,94,0.04)';
                }

                // priority class
                var pr = priority.toLowerCase();
                var priorityClass = 'low';
                if (pr.indexOf('high') > -1) priorityClass = 'high';
                else if (pr.indexOf('medium') > -1) priorityClass = 'medium';

                html += ''
                + '<div class="list-card task-item">'
                +   '<div class="list-left">'
                +     '<div class="status-icon ' + statusIconClass + '"><i class="fas fa-tasks"></i></div>'
                +     '<div style="min-width:0;">'
                +       '<div class="list-title" data-bs-toggle="tooltip" title="Task Name: ' + (taskName || 'N/A') + '">'
                +         (taskName || 'N/A')
                +       '</div>'
                +       '<div class="list-sub" data-bs-toggle="tooltip" title="Project Name: ' + projectName + '">' + projectName + '</div>'
                +     '</div>'
                +   '</div>'
                +   '<div class="list-right">'
                +     '<span class="priority ' + priorityClass + '"  data-bs-toggle="tooltip" title="Priority">' + priority + '</span>'
                +     '<span class="list-sub" style="margin: 0; color: #64748b;" data-bs-toggle="tooltip" title="Task Aging">' + agingDaysText + '</span>'
                +     '<button class="mini-icon-btn taskTS_DetailsBtn" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTaskTimesheetDetails" onclick="getTaskTimesheetDetailsList(' + taskId + ')">'
                +       '<span data-bs-toggle="tooltip" title="Timesheet Details">'
                +         '<i class="fas fa-clipboard-list"></i>'
                +       '</span>'
                +     '</button>'
                +   '</div>'
                + '</div>';
            });

            $wrap.html(html);
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        // Added by Gauri - Fetch OLD Tasks List
        function getWhizibleTodayOldTasksList(projectID) {
            // Loader
            $('#OldTasksList').html('<div class="text-center p-3 text-muted">Loading...</div>');

            var oldList = getWhizibleTodayTasksListByCategory("OLD", projectID);

            // Bind
            bindTaskList('OldTasksList', oldList);

            // Set global list if you want filtering/pagination
            allOldTasksList = oldList || [];

            // Pagination for OLD tasks (separate)
            initOldTaskPagination();
        }

         // Added by Gauri - format Date as "DD MMM YYYY"
        function formatDateDDMMMYYYY(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return dateStr;
            return d.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
        }

        // Added by Gauri - Convert "HH:mm" to total minutes
        function timeToMinutes(hhmm) {
            if (!hhmm || typeof hhmm !== 'string') return 0;
            var parts = hhmm.split(':');
            if (parts.length !== 2) return 0;
            var h = parseInt(parts[0], 10) || 0;
            var m = parseInt(parts[1], 10) || 0;
            return (h * 60) + m;
        }

        // Added by Gauri - Convert "HH:mm" to decimal hours (HH.mm)
        function decimalToHHMM(decimal) {
            if (decimal === null || decimal === undefined || decimal === '') return '';

            decimal = parseFloat(decimal);
            if (isNaN(decimal)) return '';

            var hours = Math.floor(decimal);
            var minutes = Math.round((decimal - hours) * 60);

            // Handle edge case: 59.999 → next hour
            if (minutes === 60) {
                hours += 1;
                minutes = 0;
            }

            return hours.toString().padStart(2, '0') + ':' +
                minutes.toString().padStart(2, '0');
        }

        // Added by Gauri - Format hour (decimal) to "HH:00"
        function formatHourToHHMM(hour) {
            if (hour === null || hour === undefined || hour === '') return '';

            return String(hour).padStart(2, '0') + ':00';
        }

        // Added by Gauri - Fetch Task Timesheet Details
        function getTaskTimesheetDetailsList(taskID) {

            

            // Loading state for table
            $('#TaskTS_DetailsTBody').html(
                '<tr><td colspan="5" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            // Today date
            $("#TodayDateTaskTS").text(formatDateDDMMMYYYY(new Date()));

            // ---- Call Task Details API ----
            var param = {
                employeeID: defaultEmployeeID || 61,
                taskID: taskID || 0
            };

            var url = "api/DeveloperDashEnView/GetTaskDetails";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Unwrap response safely
            var data = null;
            if (result) {
                if (result.data) data = result.data;
                else data = result; // fallback if API returns raw object
            }

            selectdTaskID = data.taskID || 0;
            selectdProjectID = data.projectID || 0;
            selectdActualHrs = data.actualWork || '00:00';
            dailyActivityEntryID = data.dailyActivityEntryID || null;
            isAgile = data.isAgile || false;
            isClosedTask = data.taskCompletion ;

            if(isClosedTask==false){
                $("#CloseTaskBtn").hide();
            } else {
                $("#CloseTaskBtn").show();
            }

            $('#TaskNameTaskTS').text(data.taskName || '-');
            $('#TaskStartDateTaskTS').text(data.startDate || '-');
            $('#TaskEndDateTaskTS').text(data.endDate || '-');

            // Deliverable can be null
            $('#TaskDeliverablesTaskTS').text(data.deliverable ? data.deliverable : '-');

            // Resource name
            $('#TaskResourcesTaskTS').text(data.employeeName || '-');

            // Planned Effort
            $('#TaskPlannedEffort').text(data.work || '-');

            // Milestone can be empty string
            $('#TaskMilestonesTaskTS').text(data.milestone ? data.milestone : '-');
            // $('#WorkHrsTasksTS').val(data.todayDuration ? data.todayDuration : '00:00');

            // Commented and Added by Vaibhav K on 20-03-26 - Show placeholder for yet to start tasks, not 00:00

            //$('#WorkHrsTasksTS').val(
            //    data.todayDuration !== null && data.todayDuration !== undefined
            //        ? decimalToHHMM(data.todayDuration)
            //        : ''
            //);
            var durationValue = '';
            if (data.todayDuration !== null && data.todayDuration !== undefined) {
                var converted = decimalToHHMM(data.todayDuration);
                // Only set value if it's not 00:00 (treat 00:00 as empty for yet to start)
                durationValue = (converted === '00:00') ? '' : converted;
            }
            $('#WorkHrsTasksTS').val(durationValue);
            // End of Added by Vaibhav K on 20-03-26


            // $('#ActualHoursTillDateTaskTS').text(data.actualWork ? data.actualWork : '-');
            $('#ActualHoursTillDateTaskTS').text(
                data.actualWork !== null && data.actualWork !== undefined
                    ? decimalToHHMM(data.actualWork)
                    : ''
            );
        }

        //NOt Needed 
        // Added by Gauri - Check if "HH:mm" is valid with mins < 60
        function isValidHHMM(workHours) {
            if (!workHours) return true; // treat blank as allowed (you already normalize elsewhere)

            workHours = workHours.trim();

            // must be HH:mm
            if (!/^\d{1,2}:\d{2}$/.test(workHours)) return false;

            var parts = workHours.split(':');
            var mins = parseInt(parts[1], 10);

            return !isNaN(mins) && mins >= 0 && mins < 60;
        }


        // Added by Gauri - Combined Work Hours Validation
        function validateWorkHours(workHours) {

            if (!workHours) return true; // allow blank

            workHours = workHours.trim();

            // 1️⃣ Only numeric and colon allowed
            if (!/^[0-9:]+$/.test(workHours)) {
                alertify.error('<%=MyBase.GetResourceString("A_Numeric")%>');
                return false;
            }

            if (!/^\d{1,2}:\d{2}$/.test(workHours)) {
                alertify.error('<%=MyBase.GetResourceString("A_DecAlertTS1")%>');
                return false;
            }

            var parts = workHours.split(':');
            var mins = parseInt(parts[1], 10);

            if (isNaN(mins) || mins >= 60) {
                alertify.error('<%=MyBase.GetResourceString("A_WH")%>');
                return false;
            }
            return true;
        }


        // Added by Gauri - Validation API call before saving timesheet
        function ValidationTimesheetDetailsList() {
            
            var workHours = $('#WorkHrsTasksTS').val().trim();

            if (workHours && !validateWorkHours(workHours)) {
                $('#WorkHrsTasksTS').focus();
                return false;
            }


            if (workHours) {
                var parts = workHours.split(':');
                var formattedWorkHours = parseInt(parts[0]) + "." + parts[1];

            }


            // Convert HH:mm → HH.mm
            //var convertDecimalHour = convertWorkHours(workHours);

             var convertDecimalHour = formattedWorkHours;
 
            
            if(!isAgile){
                var param1 = {
                    projectID : selectdProjectID,
                    employeeID : defaultEmployeeID,
                    entryDate : formatDateDDMMMYYYY(new Date()),
                    duration : convertDecimalHour,
                    // duration : formattedDuration,
                    // totalDuration : selectdActualHrs.toString(),
                    taskID : selectdTaskID,
                    isTaskComplete : false,
                    subTaskTypeID : 0
                };

                var url1 = "api/DeveloperDashEnView/ValidateDailyActivity";
                var result1 = AJAXCallWithResult(url1, JSON.stringify(param1), false);

                var validationMessage = result1?.data?.message;

                if (validationMessage) {
                    alertify.error(validationMessage);
                    // $("#ConfirmMessagemodalinfo").modal("show");
                    // $("#ConfirmationMsg").text(validationMessage);
                    return false;
                } 
                else{
                    saveTaskTimesheetDetailsList();
                } 
            } else {
                var param2 = {
                    taskID : selectdTaskID,
                    storyPoint : 0,
                    entryDate : formatDateDDMMMYYYY(new Date())
                };

                var url2 = "api/DeveloperDashEnView/ValidateStoryPoint";
                var result2 = AJAXCallWithResult(url2, JSON.stringify(param2), false);

                var validationMessage = result2?.data?.message;

                if (validationMessage) {
                    alertify.error(validationMessage);
                    // $("#ConfirmMessagemodalinfo").modal("show");
                    // $("#ConfirmationMsg").text(validationMessage);
                    return false;
                } 
                else{
                    saveTaskTimesheetDetailsList();
                } 
            }
        }

        // Added by Gauri - Check if ID is valid (>0)
        function hasValidId(val) {
            return val !== null && val !== undefined && val !== "" && parseInt(val, 10) > 0;
        }

        // Added by Gauri - Save or Update Task Timesheet Details
        function saveTaskTimesheetDetailsList() {
            var workHours = ($('#WorkHrsTasksTS').val() || '').trim();

            // optional: normalize blank
            if (!workHours || workHours == '00:00') {
                alertify.error('<%=MyBase.GetResourceString("A_DailyActAlert")%>');
                return false;
            } 

            if (workHours && !validateWorkHours(workHours)) {
                $('#WorkHrsTasksTS').focus();
                return false;
            }

            if (workHours) {
                var parts = workHours.split(':');
                var formattedWorkHours = parseInt(parts[0]) + "." + parts[1];

            }


            // Convert HH:mm → HH.mm
            //var convertDecimalHour = convertWorkHours(workHours);

            var duration = formattedWorkHours;



            // Decide Update vs Save
            if (hasValidId(dailyActivityEntryID)) {
                // ---- UPDATE ----
                var paramUpdate = {
                    dailyActivityEntryID: dailyActivityEntryID,
                    taskID: selectdTaskID,
                    projectID: selectdProjectID,
                    employeeID: defaultEmployeeID,
                    entryDate: formatDateDDMMMYYYY(new Date()),
                    duration: duration || '00:00',
                    description: '',                   
                    isTaskComplete: false
                   
                };
                
                var updateUrl = "api/DeveloperDashEnView/SaveDailyActivity";
                var updateRes = AJAXCallWithResult(updateUrl, JSON.stringify(paramUpdate), false);

                // show validation error if any
                var msg = updateRes?.result?.DailyActivitySPResult[0]?.result;

                if (msg) {
                    alertify.success('<%=MyBase.GetResourceString("A_TS_Upd_Alert")%>');
                    // getTaskTimesheetDetailsList(selectdTaskID); // refresh details to get new entry ID and updated hours
                    var offcanvasEl = document.getElementById('offcanvasTaskTimesheetDetails');
                    bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).hide();
                    refreshActiveTasksTab();        // refresh task lists
                    getWhizibleTodayWBSCount();
                } else {
                    alertify.error(msg || "Error updating timesheet.");
                    return false;                    
                }

                return true;
            } else {
                // ---- SAVE (INSERT) ----
                var paramSave = {
                    dailyActivityEntryID: null,
                    taskID: selectdTaskID,
                    projectID: selectdProjectID,
                    employeeID: defaultEmployeeID,
                    entryDate: formatDateDDMMMYYYY(new Date()),
                    duration: duration || '00:00',
                    description: '',
                    isTaskComplete: false
                   
                };

                var saveUrl = "api/DeveloperDashEnView/SaveDailyActivity";
                var saveRes = AJAXCallWithResult(saveUrl, JSON.stringify(paramSave), false);

                var msg2 = saveRes?.result?.DailyActivitySPResult[0]?.result;
                if (msg2) {
                    alertify.success('<%=MyBase.GetResourceString("A_TS_Save_Alert")%>');
                    // getTaskTimesheetDetailsList(selectdTaskID); // refresh details to get new entry ID and updated hours
                    var offcanvasEl = document.getElementById('offcanvasTaskTimesheetDetails');
                    bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).hide();
                    refreshActiveTasksTab();        // refresh task lists
                    getWhizibleTodayWBSCount();
                } else {
                    alertify.error(msg2 || "Error saving timesheet.");
                    return false;                    
                }
                return true;
            }
        }

        // Added by Gauri - Convert work hours via API
        function convertWorkHours(workHours, flag = 2) {
            // normalize input
            var hrs = (workHours || '').trim();
            if (!hrs) hrs = '00:00';

            var param = {
                workHour: hrs,
                flag: flag
            };

            var url = "api/DeveloperDashEnView/ConvertDecimalToHour";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            var data = result?.data || result;
            return data?.convertDecimalToHourViceVersa || null;
        }
        
        // Added by Gauri - Close Task from Timesheet Details Offcanvas Screen
        function CloseTaskTimesheet() {
            var workHours = ($('#WorkHrsTasksTS').val() || '').trim();

            if (!workHours || workHours == '00:00') {
                alertify.error('<%=MyBase.GetResourceString("A_DailyActAlert")%>');
                return false;
            } 

            if (workHours && !validateWorkHours(workHours)) {
                $('#WorkHrsTasksTS').focus();
                return false;
            }

            if (workHours) {
                var parts = workHours.split(':');
                var formattedWorkHours = parseInt(parts[0]) + "." + parts[1];

            }


      
            var convertDecimalHour = formattedWorkHours(workHours);

          



            var paramSave = {
                dailyActivityEntryID: dailyActivityEntryID,
                taskID: selectdTaskID,
                projectID: selectdProjectID,
                employeeID: defaultEmployeeID,
                entryDate: formatDateDDMMMYYYY(new Date()),
                duration: convertDecimalHour || '00:00',
                description: '',
                taskTypeID: 0,
                subTaskTypeID: 0,
                isDurationChange: null,
                isTaskComplete: true,
                actualPercentComplete: 0,
                resourceTaskComplete: false,
                overtime: 0,
                daType: "N",
                storyPoint: 0,
                resourceTimesheetID: 0,
                proxyResourceID: 0
            };

            var saveUrl = "api/DeveloperDashEnView/SaveDailyActivity";
            var res = AJAXCallWithResult(saveUrl, JSON.stringify(paramSave), false);

            var msg = res?.result?.DailyActivitySPResult[0].result;
            if (msg === 1) {
                alertify.success('<%=MyBase.GetResourceString("A_TS_CloseAlert")%>');

                var offcanvasEl = document.getElementById('offcanvasTaskTimesheetDetails');
                bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl).hide();
                refreshActiveTasksTab();        // refresh task lists
                getWhizibleTodayWBSCount();
                return true;
            } else {
                alertify.error(msg || "Error closing task.");
                return false;
            }
        }

        // Added by Gauri - Fetch Tasks List - Timesheet Details Offcanvas Screen
        function getTimesheetDetailsList(taskID) {
            var offcanvasEl = document.getElementById('offcanvasTimesheetDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            $('#TimesheetDetailsTBody').html(
                '<tr><td colspan="5" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            var param = { taskID: taskID || 0 };
            var url = "api/DeveloperDashEnView/GetProjectTasksHistory";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            var list = [];
            try {
                if (typeof result === 'string') {
                    result = JSON.parse(result);
                }

                if (result && result.d) {
                    result = result.d;
                    if (typeof result === 'string') result = JSON.parse(result);
                }

                if (result && Array.isArray(result.data)) {
                    list = result.data;
                }
                else if (result && typeof result.data === 'string') {
                    var parsed = JSON.parse(result.data);
                    list = Array.isArray(parsed) ? parsed : [parsed];
                }
                else if (Array.isArray(result)) {
                    list = result;
                }
                else if (result && typeof result === 'object') {
                    list = [result];
                }
            } catch (e) {
                console.error("Timesheet unwrap error:", e, result);
                list = [];
            }

            console.log("Timesheet result:", result);
            console.log("Timesheet list:", list, "isArray:", Array.isArray(list), "len:", list.length);

            if (!list.length) {
                $('#TimesheetDetailsTBody').html(
                    '<tr><td colspan="6" class="text-center text-muted p-3">No timesheet entries found</td></tr>'
                );
                return;
            }

            var totalMinutes  = 0;
            var html = list.map(function (row, idx) {
                var project   = (row.projectName ?? '').toString();
                var resource  = (row.employeeNAME ?? '').toString();
                var taskName  = (row.taskName ?? '').toString();
                var duration  = (row.duration ?? '00:00').toString();

                var entryDate = formatDateDDMMMYYYY(row.entryDate);

                // add to total
                totalMinutes += timeToMinutes(duration);

                var statusText  = (row.status ?? '—').toString();
                var statusClass = 'ts-pending';

                return `
                    <tr>
                        <td>${project}</td>
                        <td>${resource}</td>
                        <td><a href="javascript:void(0)" class="ts-link">${taskName}</a></td>
                        <td class="ts-muted">${entryDate}</td>
                        <td class="text-center">${duration}</td>
                        </tr>
                        `;
                        // <td class="text-end"><span class="ts-status ${statusClass}">${statusText}</span></td>
            }).join('');
            $('#TimesheetDetailsTBody').html(html);
        }

        // Added by Gauri - Fetch Tasks List - Timesheet Details Offcanvas Screen
        function getIssueDetailsList(issueID, projectID) {
            
            
            var offcanvasEl = document.getElementById('offcanvasIssueDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            var param = {
                employeeID: defaultEmployeeID || 0,
                projectID: projectID || null,
                assignTo: null,
                isCurrentTask: IsCurrent,
                issueID: issueID || 0
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayIssues";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // unwrap list safely
            var list = [];
            if (result) {
                if (Array.isArray(result)) list = result;
                else if (result.data && Array.isArray(result.data)) list = result.data;
            }

            // find matching deliverable row
            var row = null;
            for (var i = 0; i < list.length; i++) {
                var d = list[i];
                var did = d.issueID; // API gives "deliverable": "12"
                if (String(did) === String(issueID)) {
                    row = d;
                    break;
                }
            }

            // fallback: if not found, show first row
            if (!row) row = list[0];

            row = row || {};

            $('#IssueProjectName').text(row.projectName || 'N/A');
            $('#IssueNameTS').text(row.issue || 'N/A');
            $('#IssueIDTS').text(row.issueID || 'N/A');
            $('#IssueReportedDate').text(formatDateDDMMMYYYY(row.reportedDate) || "N/A");
            $('#IssueAgingDays').text(
                row.issueAgingDays != undefined && row.issueAgingDays !== null
                    ? row.issueAgingDays + ' days'
                    : 'N/A'
            );
            $('#IssueResponsiblePerson').text(row.responsiblePerson || "N/A");
        }

        // Added by Gauri - Deliverables Details Offcanvas Screen
        function getDeliverableDetailsList(delID, projectID) {
            
            var offcanvasEl = document.getElementById('offcanvasDeliverablesDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            var param = {
                employeeID: defaultEmployeeID || 0,
                projectID: projectID || null,
                filterByEmployeeID: null,
                deliverableID: delID || 0
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayDeliverables";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // unwrap list safely
            var list = [];
            if (result) {
                if (Array.isArray(result)) list = result;
                else if (result.data && Array.isArray(result.data)) list = result.data;
            }

            // find matching deliverable row
            var row = null;
            for (var i = 0; i < list.length; i++) {
                var d = list[i];
                var did = d.delID; // API gives "deliverable": "12"
                if (String(did) === String(delID)) {
                    row = d;
                    break;
                }
            }

            // fallback: if not found, show first row
            if (!row) row = list[0];

            row = row || {};

            $('#DelProjectName').text(row.projectName || 'N/A');
            $('#DelDeliverables').text(row.deliverable || 'N/A');
            $('#DelStartDate').text(formatDateDDMMMYYYY(row.startDate) || "N/A");
            $('#DelEndDate').text(formatDateDDMMMYYYY(row.endDate) || "N/A");
            $('#DelStatus').text(
                row.status === 0 ? "N/A" : (row.status ?? "N/A")
            );
            $('#DelPriority').text(row.priority || "N/A");
        }

        // Added by Gauri - Milestone Details Offcanvas Screen
        function getMilestoneDetailsList(milestoneID, projectID) {
            
            var offcanvasEl = document.getElementById('offcanvasMilestoneDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            var param = {
                employeeID: defaultEmployeeID || 0,
                projectID: projectID || null,
                assignTo: null,
                mileStoneID: milestoneID || 0   // IMPORTANT: API data uses mileStoneID
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayMilestones";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // unwrap safely
            var list = [];
            if (result) {
                if (Array.isArray(result)) list = result;
                else if (result.data && Array.isArray(result.data)) list = result.data;
                else if (result.Milestones && Array.isArray(result.Milestones)) list = result.Milestones;
            }

            // find row by ID (handle different key casing)
            var row = null;
            for (var i = 0; i < list.length; i++) {
                var r = list[i];
                var id = r.mileStoneID || null;
                if (String(id) === String(milestoneID)) {
                    row = r;
                    break;
                }
            }

            // fallback
            if (!row) row = list[0];

            // bind
            $('#MilestoneProjectName').text(row.projectName || 'N/A');
            $('#MilestoneName').text(row.milestone || 'N/A');

            $('#MilestoneStartDate').text(row.plannedCompletionDate ? formatDateDDMMMYYYY(row.plannedCompletionDate) : 'N/A');
            $('#MilestoneEndDate').text(row.actualCompletionDate ? formatDateDDMMMYYYY(row.actualCompletionDate) : 'N/A');

            //// aging is number of days, NOT a date
            //$('#MilestoneAging').text((row.milestoneAgingDays != null) ? (row.milestoneAgingDays + ' days') : 'N/A');

            //$('#MilestoneStatus').text(row.milestoneStatus || 'N/A');

            // Milestone Aging
            $('#MilestoneAging').text(
                row.milestoneAgingDays == 0
                    ? '-'
                    : row.milestoneAgingDays != null
                        ? row.milestoneAgingDays + ' days'
                        : 'N/A'
            );

            // Milestone Status
            $('#MilestoneStatus').text(
                row.milestoneStatus == 0
                    ? 'N/A'
                    : row.milestoneStatus
                        ? row.milestoneStatus
                        : 'N/A'
            );

        }

        // Added by Gauri - Review Details Offcanvas Screen
        function getReviewDetailsList(reviewID, projectID) {
            
            var offcanvasEl = document.getElementById('offcanvasReviewDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            var param = {
              userName: defaultEmployeeName || '',
              projectID: projectID || null,
              authorID: null,
              reviewID: reviewID || 0
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayReviews";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // unwrap list safely
            var list = [];
            if (result) {
                if (Array.isArray(result)) list = result;
                else if (result.data && Array.isArray(result.data)) list = result.data;
            }

            // find matching deliverable row
            var row = null;
            for (var i = 0; i < list.length; i++) {
                var d = list[i];
                var did = d.reviewID; // API gives "deliverable": "12"
                if (String(did) === String(reviewID)) {
                    row = d;
                    break;
                }
            }

            // fallback: if not found, show first row
            if (!row) row = list[0];

            row = row || {};

            $('#ReviewProjectName').text(row.projectName || 'N/A');
            $('#ReviewName').text(row.title || 'N/A');
            // $('#ReviewType').text(row.reviewType || 'N/A');

            $('#ReviewStartDate').text(formatDateDDMMMYYYY(row.reviewStartDate) || "N/A");
            $('#ReviewEndDate').text(formatDateDDMMMYYYY(row.reviewEnd) || "N/A");
            $('#ReviewActualStartDate').text(formatDateDDMMMYYYY(row.actualStart) || "N/A");
            // $('#ReviewStatus').text(row.status || "N/A");

            // actualWork is decimal hours -> convert to HH:MM
            $('#ReviewReviwee').text(row.reviewee || "N/A");
            $('#ReviewReviewer').text(row.reviewer || "N/A");            
        }

        // Global lists (optional, useful later)
        var allCurrentIssuesList = [];
        var allOldIssuesList = [];

        // Added by Gauri - Fetch Issues List 
        var IsCurrent;
        function getWhizibleTodayIssuesList(projectID, isCurrentTask) {
            
            var projectID = $('#cboProjectIssue').val();
            IsCurrent = isCurrentTask;

            var containerId = isCurrentTask ? "CurrIssueListContainer" : "OpenIssueListContainer";

            // Loader
            $('#' + containerId).html('<div class="text-center p-3 text-muted">Loading...</div>');

            var param = {
                employeeID: defaultEmployeeID || 0,
                projectID: projectID || null,
                assignTo: null,
                isCurrentTask: !!isCurrentTask // ✅ NEW (true for Current tab, false for Old tab)
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayIssues";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Normalize response
            var issueList = [];
            if (result) {
                if (Array.isArray(result)) issueList = result;
                else if (result.data && Array.isArray(result.data)) issueList = result.data;
                else if (result.Issues && Array.isArray(result.Issues)) issueList = result.Issues;
            }

            // store
            if (isCurrentTask) allCurrentIssuesList = issueList || [];
            else allOldIssuesList = issueList || [];

            // bind
            bindIssueList(containerId, issueList || []);

            // pagination (separate)
            if (isCurrentTask) initIssuePagination();
            else initOldIssuePagination();
        }

        // Added by Gauri - Bind Issues List HTML
        function bindIssueList(containerId, issueList) {
            
            var $wrap = $('#' + containerId);
            if (!$wrap.length) return;

            if (!issueList || !issueList.length) {
                $wrap.html('<div class="text-center p-3 text-muted">No issues found</div>');
                return;
            }

            var html = '';

            $.each(issueList, function (index, issue) {
                var agingDays = issue.issueAgingDays || 0;

                statusIconClass = 'amber';
                statusIcon = '<i class="fas fa-exclamation-triangle"></i>';
                borderColor = 'rgba(245,158,11,0.25)';
                backgroundColor = 'rgba(245,158,11,0.05)';

                if (agingDays > 0) {
                    statusIconClass = 'red';
                    statusIcon = '<i class="far fa-times-circle"></i>';
                    borderColor = 'rgba(239,68,68,0.25)';
                    backgroundColor = 'rgba(239,68,68,0.04)';
                } 
                else {
                    var statusIconClass = 'green';
                    var statusIcon = '<i class="far fa-check-circle"></i>';
                    var borderColor = 'rgba(34,197,94,0.25)';
                    var backgroundColor = 'rgba(34,197,94,0.04)';
                }

                var issueSummary = issue.issue || '';
                var projectID = issue.projectID || '';
                var projectName = issue.projectName || '';
                var reportedDate = (issue.reportedDate || '').trim();
                var issueID = issue.issueID || '';
                var agingDaysText = agingDays > 0 ? agingDays + 'd' : 'N/A';

                var issueSummarySafe = issueSummary.replace(/'/g, "\\'");


                html += ''
                    + '<div class="list-card issue-item" style="border-color:' + borderColor + '; background:' + backgroundColor + ';">'
                    +   '<div class="list-left">'
                    // +     '<div class="status-icon ' + statusIconClass + '">' + statusIcon + '</div>'
                    +     '<div class="IssueIcon" data-bs-toggle="tooltip" title="Issue ID: ' + issueID + '">' + issueID + '</div>'
                    +     '<div style="min-width:0;">'
                    +       '<div class="list-title" data-bs-toggle="tooltip" title="Issue Summary: ' + issueSummary + '">' + issueSummary + '</div>'
                    +       '<div class="list-sub" data-bs-toggle="tooltip" title="Project Name: ' + projectName + '">' + projectName + '</div>'
                    +     '</div>'
                    +   '</div>'  
                    +   '<div class="list-right">'
                    +    '<span class="list-sub" style="margin-right:15px;;color:#64748b;" data-bs-toggle="tooltip" title="Issue Aging">' + agingDaysText + '</span>'
                    +     '<button class="outlineBtn p-1" data-bs-toggle="tooltip" title="Reported Date: ' + reportedDate + '">' + reportedDate + '</button>'
                    + '<button class="mini-icon-btn" onclick="getIBDiscussionList(' + issueID + ', \'' + issueSummarySafe + '\')" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDiscussionThreadIssue">'
                    +       '<span data-bs-toggle="tooltip" title="Discussion Thread"><i class="far fa-comment"></i></span>'
                    +     '</button>'
                    +     '<button class="mini-icon-btn issueTS_DetailsBtn" onclick="getIssueDetailsList(' + issueID + ', ' + projectID + ')">'
                    +       '<span data-bs-toggle="tooltip" title="Issue Details"><i class="fas fa-clipboard-list"></i></span>'
                    +     '</button>'
                    +   '</div>'
                    + '</div>';
            });

            $wrap.html(html);

            // Added by Aditya J. on 20-03-2026 for tooltip reinitialization
            $('[data-bs-toggle="tooltip"]').each(function () {
                var tooltip = bootstrap.Tooltip.getInstance(this);
                if (tooltip) {
                    tooltip.dispose();
                }
                new bootstrap.Tooltip(this);
            });
            // End of Added by Aditya J. on 20-03-2026 for tooltip reinitialization
        }
        
        // Added by Gauri - Handle project dropdown change for issues
        function ProjectIssueOnChange() {
            
            var sel = getSelectedProject($('#cboProjectIssue'));
            var pid = sel.id ? parseInt(sel.id, 10) : null;
            if (isNaN(pid)) pid = null;

            // detect active issue tab
            var isCurrent = $('#RunningIssuesTab').hasClass('active');
            // getWhizibleTodayIssuesList(pid);
            getWhizibleTodayIssuesList(pid, isCurrent);
        }

        // Added by Gauri - Bind Status Dropdown in Discussion Thread Offcanvas
        function bindStatusDiscThread(issueId) {
            var statusParam = {
                issueID: issueId || 0,
                loginType: "E"
            };

            var irRes = AJAXCallWithResult("api/DeveloperDashEnView/GetIssueWithRole", JSON.stringify(statusParam), false);

            var issueObj = null, roleObj = null;

            if (irRes && Array.isArray(irRes.issue) && irRes.issue.length) issueObj = irRes.issue[0];
            if (irRes && Array.isArray(irRes.role) && irRes.role.length) roleObj = irRes.role[0];

            if (!issueObj) return;

            var projectID = issueObj.projectID || 0;
            var type = issueObj.type || issueObj.corporateType || "";
            var currentStatus = issueObj.status || issueObj.corporateStatus || "";
            var roleID = (roleObj && roleObj.role) ? roleObj.role : (issueObj.assignTo || 0);

            // --- 2) Get Status list ---
            var stParam = {
                projectID: projectID,
                type: type,
                projectTypeStatusID: null,
                orderByClause: null,
                roleID: roleID,
                status: currentStatus
            };

            var stRes = AJAXCallWithResult("api/DeveloperDashEnView/GetStatusType", JSON.stringify(stParam), false);

            var list = (stRes && Array.isArray(stRes.data)) ? stRes.data : [];

            // --- 3) Bind dropdown (#statusDiscThread) ---
            var $ddl = $('#statusDiscThread');
            if (!$ddl.length) return;

            $ddl.empty();
            $ddl.append('<option value="">Select Status</option>');

            for (var i = 0; i < list.length; i++) {
                var row = list[i];
                var val = row.fieldID || "";
                var txt = row.fieldName || "";

                if (val && txt) {
                    $ddl.append('<option value="' + val + '">' + txt + '</option>');
                }
            }

            // --- 4) Preselect current status (match value or text) ---
            if (currentStatus) {
                // try match by value
                $ddl.val(currentStatus);

                // if not matched, try match by text
                if (!$ddl.val()) {
                    $ddl.find('option').each(function () {
                        if ($(this).text() === currentStatus) {
                            $ddl.val($(this).val());
                            return false;
                        }
                    });
                }
            }

            // --- 5) Refresh selectpicker ---
            if ($ddl.hasClass('selectpicker') && typeof $.fn.selectpicker !== 'undefined') {
                $ddl.selectpicker('refresh');
            }
        }

        // Added by Gauri - Get selected Status Dropdown value
        function getStatusDropdownValue() {
            var statusID = $('#ddlIssueStatus').val();
            console.log("Selected Status ID:", statusID);
        }
        var issueSum;
        // Added by Gauri - Fetch Issue Discussion Thread List 
        function getIBDiscussionList(issueId,issueSummary) {

            

            issueSum = issueSummary;

            bindStatusDiscThread(issueId || 0);

            $("#IssueID_DT").text(issueId || 'N/A');
            $("#DT_User").text(defaultEmployeeName || 'N/A');

            var firstLetter = defaultEmployeeName.trim().charAt(0).toUpperCase();

            $("#loginstart").text(firstLetter || 'N/A');


            $("#DT_CurrDateTime").text(formatDateTime(new Date()));

            $("#btnPostComment").data('issueid', issueId || 0);

            var offcanvasEl = document.getElementById('offcanvasDiscussionThreadIssue');
            if (offcanvasEl) {
                var oc = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);

                offcanvasEl.addEventListener('shown.bs.offcanvas', function () {
                    var body = offcanvasEl.querySelector('.offcanvas-body');
                    if (body) {
                        body.scrollTop = 0;
                    }
                }, { once: true }); // ensures it runs only once per open
                oc.show();
            }

            // Loading state
            $('#IBDiscussionContainer').html(
                '<div class="text-center text-muted p-3">Loading...</div>'
            );

            var param = {
                issueID: issueId || 0,
                loginType: "E" // don't use "E" || '' (that always becomes "E")
            };

            var url = "api/DeveloperDashEnView/GetIBDiscussion";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Unwrap
            var list = [];
            if (result) {
                if (Array.isArray(result)) list = result;
                else if (Array.isArray(result.data)) list = result.data;
                else if (result.d && result.d.data && Array.isArray(result.d.data)) list = result.d.data;
            }

            var $wrap = $('#IBDiscussionContainer');
            if (!$wrap.length) {
                console.error('IBDiscussionContainer not found');
                return;
            }

            $("#prevCommentsValue").html(list.length);

            if (!list || !list.length) {
                $wrap.html('<div class="text-center text-muted dt-card p-3">No discussions found</div>');
                return;
            }


            //// Sort by discussionDate ascending (optional)
            //list.sort(function (a, b) {
            //    var da = new Date(a.discussionDate || 0).getTime();
            //    var db = new Date(b.discussionDate || 0).getTime();
            //    return da - db;
            //});

            var html = list.map(function (row) {
                var user = (row.userName || 'Unknown').toString();
                var comment = (row.comments || '').toString();
                var showToCustomer = !!row.showToCustomer;

                var dtText = formatDateTime(row.discussionDate);

                var initials = getInitials(user);
                var avatarClass = 'dt-avatar-gray'; // default
                // Optional: highlight Admin in blue
                if (user.toLowerCase() === 'admin') avatarClass = 'dt-avatar-blue';

                // Badge only if customer visible
                var badgeHtml = showToCustomer
                    ? '<span class="dt-badge">Customer Visible</span>'
                    : '';

                return ''
                    + '<div class="dt-card dt-comment">'
                    +   '<div class="dt-comment-row">'
                    +     '<div class="dt-avatar ' + avatarClass + '">' + initials + '</div>'
                    +     '<div class="dt-comment-main">'
                    +       '<div class="dt-comment-top">'
                    +         '<div class="d-flex align-items-center gap-2">'
                    +           '<div class="dt-name">' + user + '</div>'
                    +             badgeHtml
                    +           '</div>'
                    +         '<div class="dt-time">' + dtText + '</div>'
                    +       '</div>'
                    +       '<div class="dt-comment-text">' + comment + '</div>'
                    +     '</div>'
                    +   '</div>'
                    + '</div>';
            }).join('');

            $wrap.html(html);
        }

        // Added by Gauri - Post Issue Discussion Comment
        $(document).on('click', '#btnPostComment', function () {
            
            var issueId = $(this).data('issueid'); // or pass it directly
            // postIBDiscussionComment(issueId);

            // 1) Read comment
            var comment = ($('#DT_Comment').val() || '').trim();
            if (!comment) {
                alertify.error('<%=MyBase.GetResourceString("A_DiscCom")%>');
                return;
            }

            var showToCustomer = $('#chkShowToCustomer').is(':checked');

            // 2) Fetch Issue Context (NO globals)
            var ctxParam = {
                issueID: issueId || 0,
                loginType: 'E'
            };

            var ctxRes = AJAXCallWithResult(
                "api/DeveloperDashEnView/GetIssueWithRole",
                JSON.stringify(ctxParam),
                false
            );

            var issueObj = null;
            if (ctxRes && Array.isArray(ctxRes.issue) && ctxRes.issue.length) {
                issueObj = ctxRes.issue[0];
            }

            if (!issueObj) {
                alertify.error('Unable to load issue context.');
                return;
            }

            // 3) Derive required fields
            var userName = defaultEmployeeName || "";

            var corporateStatus = issueObj.corporateStatus || issueObj.status || '';
            var existingStatus = issueObj.status || '';

            // Selected status from dropdown (preferred)
            var selectedStatusText = '';
            var $ddl = $('#statusDiscThread');
            if ($ddl.length && $ddl.val()) {
                selectedStatusText = $ddl.find('option:selected').text() || '';
            }

            var finalStatus = selectedStatusText || existingStatus || '';

            getIssueMailList(issueObj.projectID, issueId); // Added by Gauri - Get Mail List for Issue's Project

            // 4) Build InsertIBDiscussion payload
            var payload = {
                issueID: issueObj.issueID || issueId || 0,
                userName: userName,
                comment: comment,
                showToCustomer: showToCustomer,
                status: finalStatus,
                corporateStatus: corporateStatus,
                creatorOrModifier: userName,
                loginType: 'E'
            };

            // 5) POST Comment
            var res = AJAXCallWithResult(
                "api/DeveloperDashEnView/InsertIBDiscussion",
                JSON.stringify(payload),
                false
            );

            if (res) {
                alertify.success('<%=MyBase.GetResourceString("A_CommentSaved")%>');

                // Clear input
                $('#DT_Comment').val('');
                $('#chkShowToCustomer').prop('checked', false);

                // Refresh discussion thread
                getIBDiscussionList(issueObj.issueID);
            } else {
                alertify.error('Failed to post comment.');
            }
        });

        //function buildDiscussionMailBody(templateBody, context) {
        //    if (!templateBody) return '';

        //    return templateBody
        //        .replace(/<NAME>/g, context.employeeName || '')
        //        .replace(/<SENDER_NAME>/g, context.employeeName || '')
        //        .replace(/<PROJECT_NAME>/g, context.projectName || context.projectID || '')
        //        .replace(/<ISSUE_ID>/g, context.issueID || '')
        //        .replace(/<ISSUE_SUMMARY>/g, context.issueSummary || '')   // ✅ ADD THIS
        //        .replace(/<DISCUSSION_THREAD>/g, context.discussion || '')
        //        ;  // ✅ ADD THIS

        //}

        function buildDiscussionMailBody(templateBody, context) {
            if (!templateBody) return '';

            var body = templateBody
                .replace(/<NAME>/g, context.employeeName || '')
                .replace(/<SENDER_NAME>/g, context.employeeName || '')
                .replace(/<PROJECT_NAME>/g, context.projectName || context.projectID || '')
                .replace(/<ISSUE_ID>/g, context.issueID || '')
                .replace(/<ISSUE_SUMMARY>/g, context.issueSummary || '')
                .replace(/<DISCUSSION_THREAD>/g, (context.discussion || '').trim());

            // Convert line breaks to HTML
            body = body
                .replace(/\r\n/g, "<br>")
                .replace(/\n/g, "<br>")
                .replace(/\[Issue ID:/g, "<br><br>[Issue ID:")
                .replace(/\[Issue Summary:/g, "<br>[Issue Summary:")
                .replace(/Regards,/g, "<br><br>Regards,");

            return body;
        }






        // Helpers (ES5 safe)
        function getInitials(name) {
            name = (name || '').trim();
            if (!name) return '?';
            var parts = name.split(/\s+/);
            var first = parts[0] ? parts[0].charAt(0) : '';
            var last = parts.length > 1 ? parts[parts.length - 1].charAt(0) : '';
            var ini = (first + last).toUpperCase();
            return ini || first.toUpperCase() || '?';
        }

        function formatDateTime(dateStr) {
            if (!dateStr) return '';
            var d = new Date(dateStr);
            if (isNaN(d.getTime())) return '';

            // Example: "Jan 01, 2026 06:46 PM"
            return d.toLocaleString('en-US', {
                month: 'short',
                day: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            }).replace(',', '');
        }

        // Added by Gauri - Mail Get APIs for Issue Discussion Thread (From Mail, CC Mail, Subject, Body)
        function getIssueMailList(projectID, issueId) {

            // Get From Mail API
            var getParams = {
                EmpID: defaultEmployeeID || 0

            };
            var getUrl = "api/DeveloperDashEnView/GetFromMail";
            var getFromResult = AJAXCallWithResult(getUrl, JSON.stringify(getParams), false);

            getFromMailID = getFromResult?.data?.data[0]?.emailID || null;

            // Get CC Mail API
            var getCC_Params = {
                ReportedBy: defaultEmployeeName || 0,
                ProjectID: projectID || 0,
            };
            var getCC_Url = "api/DeveloperDashEnView/GetProjectCustomerEmail";
            var getCCResult = AJAXCallWithResult(getCC_Url, JSON.stringify(getCC_Params), false);

            getCCMailID = getCCResult?.data[0]?.emailID || null;

            // Get Message(Subject and Body) API
            var getMsgParams = {
                messageID: "33",
                projectID: projectID || 0,
            };
            var getMsg_Url = "api/DeveloperDashEnView/GetEmailMessage";
            var getResult = AJAXCallWithResult(getMsg_Url, JSON.stringify(getMsgParams), false);

            // getSubjectTxt = getResult?.subject || null; 
            // getBodyTxt = getResult?.body || null; 

            var template = null;
            if (getResult && getResult.data && getResult.data.length) {
                template = getResult.data[0];
            }

            if (!template) return;

            /* ---------- BUILD FINAL SUBJECT & BODY ---------- */
            var discussionText = $('#DT_Comment').val() || '';

            var finalSubject = template.subject
                .replace(/<PROJECT_NAME>/g, projectID)
                .replace(/<ISSUE_ID>/g, issueId);

            // ✅ Proper Comment Info Formatting
            var now = new Date();
            var formattedDate = formatDateTime(now);

            var commentInfo = "Comment added by "
                + (defaultEmployeeName || '')
                + " On "
                + formattedDate;

            var discussionBlock =
                "<br>" +
                commentInfo + "<br><br>" +
                (discussionText || '').trim().replace(/\r\n/g, "<br>") +
                "<br>";


            var finalBody = buildDiscussionMailBody(template.body, {
                employeeName: defaultEmployeeName,
                projectID: projectID,
                issueID: issueId,
                issueSummary: issueSum,   // ✅ ADD THIS
                discussion: discussionBlock
            });

            var postParams = {
                issueID: issueId || 0,
                ccEmailID: getCCMailID,
                toEmailID: getCCMailID,      // (if you want TO = customer mail)
                fromEmailID: getFromMailID,
                subject: finalSubject,
                body: finalBody
            };

            var postUrl = "api/DeveloperDashEnView/SendDevDashEmail";
            var postResult = AJAXCallWithResult(postUrl, JSON.stringify(postParams), false);

            console.log('Mail Send Result:', postResult);
        }

        function getWhizibleTodayDeliverablesList(projectID) {


            var projectID = $('#cboProjectDel').val();

            var param = {
                employeeID: defaultEmployeeID || 0,
                projectID: projectID || null,
                filterByEmployeeID: null
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayDeliverables";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Unwrap
            var deliverableList = [];
            if (result) {
                if (Array.isArray(result)) deliverableList = result;
                else if (result.data && Array.isArray(result.data)) deliverableList = result.data;
                else if (result.Deliverables && Array.isArray(result.Deliverables)) deliverableList = result.Deliverables;
            }

            // Store
            allDeliverablesList = deliverableList || [];

            // Always clear container first (prevents stale UI confusion)
            $('#deliverableListContainer').html('');

            if (!deliverableList || !deliverableList.length) {
                $('#deliverableListContainer').html('<div class="text-center p-3 text-muted">No deliverables found</div>');
                initDeliverablePagination();
                return;
            }

            var html = '';
            try {
                $.each(deliverableList, function (index, d) {
                    // Defensive reads
                    var deliverableName = (d.deliverable || d.deliverableName || '').toString();
                    var deliverableId = (d.deliverableId || d.deliverableID || d.id || 0);

                    var projectName = (d.projectName || '').toString();
                    var projectID = (d.projectID || '').toString();

                    var statusText = (d.status || '').toString();
                    var statusClass = statusText.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9\-]/g, '');
                    if (!statusClass) statusClass = 'na';

                    var priority = (d.priority || '-').toString();
                    var priorityClass = 'prio-na';
                    var pr = priority.toLowerCase();

                    // Build card
                    html += ''
                        + '<div class="list-card deliverable-item">'
                        + '<div class="list-left">'
                        // +     '<div class="status-icon ' + statusClass + '">' + statusText + '</div>'
                        + '<div class="status-icon primary">' + '<i class="fas fa-cube"></i>' + '</div>'
                        + '<div style="min-width:0;">'
                        + '<div class="list-title" data-bs-toggle="tooltip" title="' + 'Deliverable Name: ' + deliverableName + '">' + deliverableName + '</div>'
                        + '<div class="list-sub" data-bs-toggle="tooltip" title="' + 'Project Name: ' + projectName + '">' + projectName + '</div>'
                        + '</div>'
                        + '</div>'
                        + '<div class="list-right">'
                        // +     '<span class="resNameBg"><i class="far fa-user pe-1"></i>' + resourceName + '</span>'
                        + '<span class="priority" data-bs-toggle="tooltip" title="Priority">' + priority + '</span>'
                        + '<button class="mini-icon-btn delTS_DetailsBtn" type="button" onclick="getDeliverableDetailsList(' + deliverableId + ', ' + projectID + ')">'
                        + '<span data-bs-toggle="tooltip" title="Deliverable Details">'
                        + '<i class="fas fa-clipboard-list"></i>'
                        + '</span>'
                        + '</button>'
                        + '</div>'
                        + '</div>';
                });

            } catch (e) {
                console.error('Deliverables render failed:', e);
                $('#deliverableListContainer').html('<div class="text-center p-3 text-danger">Failed to render deliverables</div>');
                initDeliverablePagination();
                return;
            }

            $('#deliverableListContainer').html(html);
            // Added by Aditya J. on 20-03-2026 for tooltip reinitialization
            $('[data-bs-toggle="tooltip"]').each(function () {
                var tooltip = bootstrap.Tooltip.getInstance(this);
                if (tooltip) {
                    tooltip.dispose();
                }
                new bootstrap.Tooltip(this);
            });
            // End of Added by Aditya J. on 20-03-2026 for tooltip reinitialization
            // Reinit pagination
            initDeliverablePagination();
        }

        // Added by Gauri - Handle project dropdown change for deliverables
        function ProjectDeliverableOnChange() {

            var sel = getSelectedProject($('#cboProjectDel'));
            var pid = sel.id ? parseInt(sel.id, 10) : null;
            if (isNaN(pid)) pid = null;

            getWhizibleTodayDeliverablesList(pid);
        }

        // Added by Gauri - Fetch Reviews List 
        function getWhizibleTodayReviewsList(projectID) {

            var projectID = $('#cboProjectReview').val();

            var param = {
                userName: defaultEmployeeName || 0,
                projectID: projectID || null,
                authorID: null,
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayReviews";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            var reviewsList = null;
            if (result) {
                if (Array.isArray(result)) {
                    reviewsList = result;
                } else if (result.data && Array.isArray(result.data)) {
                    reviewsList = result.data;
                } else if (result.Reviews && Array.isArray(result.Reviews)) {
                    reviewsList = result.Reviews;
                }
            }

            // Store all deliverables for reference
            allReviewsList = reviewsList || [];

            // Bind reviews list
            if (reviewsList && reviewsList.length > 0) {
                //   bindReviewList(reviewsList);
                if (!reviewsList || !reviewsList.length) {
                    $('#reviewListContainer').html('<div class="text-center p-3 text-muted">No reviews found</div>');
                    return;
                }

                var html = reviewsList.map(function (r) {
                    var projectName = (r.projectName || '');
                    var projectID = (r.projectID || '');
                    var title = (r.title || '');
                    var reviewer = (r.reviewer || '');
                    var reviewee = (r.reviewee || '');

                    // format date (yyyy-mm-dd -> dd Mon yyyy)
                    var dt = r.reviewStartDate ? new Date(r.reviewStartDate) : null;
                    var dateText = dt && !isNaN(dt.getTime())
                        ? dt.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
                        : '';

                    var reviewID = r.reviewStatisticsID || '';
                    var actions = r.actions || '';
                    var ts = r.ts || '';

                    return `
                    <div class="list-card review-item">
                        <div class="list-left">
                            <div class="avatar-icon warn"><i class="fas fa-user-friends"></i></div>
                            <div style="min-width: 0;">
                                <div class="list-title"><span data-bs-toggle="tooltip" title="Review Name: ${title}">${title}</span></div>
                                <div class="list-sub"  data-bs-toggle="tooltip" title="Project Name: ${projectName}">${projectName}</div>
                            </div>
                        </div>
                        <div class="list-right">
                            <div class="list-data"><span data-bs-toggle="tooltip" title="Reviewer">${reviewer}&nbsp;→&nbsp;</span> <span data-bs-toggle="tooltip" title="Reviewee">${reviewee}</span></div>
                            <button class="mini-icon-btn" onClick="getReviewActionsList('${reviewID}')" data-bs-toggle="offcanvas" data-bs-target="#offcanvasReviewActions">
                                <span data-bs-toggle="tooltip" title="Review Actions">
                                    <!-- ${actions} -->
                                    <i class="far fa-user-circle"></i>
                                </span>
                            </button>
                            <button class="mini-icon-btn issueTS_DetailsBtn" onClick="getReviewDetailsList('${reviewID}', '${projectID}')">
                                <span data-bs-toggle="tooltip" title="Review Details">
                                    <i class="fas fa-clipboard-list"></i>
                                </span>
                            </button>
                        </div>
                    </div>
                `;
                }).join('');

                $('#reviewListContainer').html(html);

                // Added by Aditya J. on 20-03-2026 for tooltip reinitialization
                $('[data-bs-toggle="tooltip"]').each(function () {
                    var tooltip = bootstrap.Tooltip.getInstance(this);
                    if (tooltip) {
                        tooltip.dispose();
                    }
                    new bootstrap.Tooltip(this);
                });
                // End of Added by Aditya J. on 20-03-2026 for tooltip reinitialization

                // Reinitialize pagination after binding
                initReviewPagination();
            } else {
                $('#reviewListContainer').html('<div class="text-center p-3 text-muted">No reviews found</div>');
                initReviewPagination(); // Initialize pagination even with empty result
            }

        }

        // Added by Gauri - Handle project dropdown change for reviews
        function ProjectReviewOnChange() {

            var sel = getSelectedProject($('#cboProjectReview'));
            var pid = sel.id ? parseInt(sel.id, 10) : null;
            if (isNaN(pid)) pid = null;

            getWhizibleTodayReviewsList(pid);
        }

        // Added by Gauri - Global list for Milestones
        var allMilestonesList = [];
        function getWhizibleTodayMilestonesList(projectID) {

            var projectID = $('#cboProjectMile').val();

            var param = {
                employeeID: defaultEmployeeID,
                projectID: projectID || null,   // allow null => all projects if backend supports
                assignTo: null
            };

            var url = "api/DeveloperDashEnView/GetWhizibleTodayMilestones";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // unwrap safely
            var list = [];
            if (result) {
                if (Array.isArray(result)) list = result;
                else if (result.data && Array.isArray(result.data)) list = result.data;
                else if (result.Milestones && Array.isArray(result.Milestones)) list = result.Milestones;
            }

            allMilestonesList = list || [];

            bindMilestoneList(allMilestonesList);
            initMilestonePagination();
        }

        // Added by Gauri - Bind Milestones List HTML
        function bindMilestoneList(list) {
            var $wrap = $('#milestoneListContainer');
            if (!$wrap.length) return;

            if (!list || !list.length) {
                $wrap.html('<div class="text-center p-3 text-muted">No milestones found</div>');
                $('#TotalRecordsMilestone').text(0);
                return;
            }

            var html = '';

            $.each(list, function (i, m) {
                var milestoneId = m.mileStoneID || 0;
                var title = (m.milestone || 'N/A').toString();
                var project = (m.projectName || '').toString();
                var projectId = (m.projectID || 0);
                var milestoneDate = (formatDateDDMMMYYYY(m.plannedCompletionDate) || '-').toString();
                //var status = (m.milestoneStatus || '').toString().toLowerCase();
                var status = '-';

                if (m.milestoneStatus !== null && m.milestoneStatus !== undefined && m.milestoneStatus != 0) {
                    status = m.milestoneStatus.toString().toLowerCase();
                }

                var agingDays = m.milestoneAgingDays || 0;
                var agingDaysText = agingDays > 0 ? agingDays + 'd' : 'N/A';

                // status icon color
                var statusClass = 'orange';
                if (status.indexOf('complete') > -1 || status.indexOf('done') > -1) statusClass = 'green';
                else if (status.indexOf('progress') > -1 || status.indexOf('ongoing') > -1) statusClass = 'yellow';

                html += ''
                    + '<div class="list-card milestone-item">'
                    + '<div class="list-left">'
                    + '<div class="status-icon"><i class="far fa-flag"></i></div>'
                    + '<div style="min-width:0;">'
                    + '<div class="list-title" data-bs-toggle="tooltip" title="Milestone: ' + title + '">' + title + '</div>'
                    + '<div class="list-sub" data-bs-toggle="tooltip" title="Project: ' + project + '">' + project + '</div>'
                    + '</div>'
                    + '</div>'
                    + '<span class="list-sub" style="margin: 0; color: #64748b;" data-bs-toggle="tooltip" title="Milestone Aging">' + agingDaysText + '</span>'
                    + '<div class="list-right">'
                    + '<span class="priority ' + statusClass + '" data-bs-toggle="tooltip" title="Status">' + status + '</span>'
                    // +     '<span class="milestoneDate">' + milestoneDate + '</span>'
                    + '<button class="outlineBtn p-1" data-bs-toggle="tooltip" title="Milestone Completion Date">' + milestoneDate + '</button>'
                    + '<button class="mini-icon-btn" type="button" onclick="getMilestoneDetailsList(' + milestoneId + ', ' + projectId + ')">'
                    + '<span data-bs-toggle="tooltip" title="Milestone Details">'
                    + '<i class="fas fa-clipboard-list"></i>'
                    + '</span>'
                    + '</button>'
                    + '</div>'
                    + '</div>';
            });

            $wrap.html(html);

            // Added by Aditya J. on 20-03-2026 for tooltip reinitialization
            $('[data-bs-toggle="tooltip"]').each(function () {
                var tooltip = bootstrap.Tooltip.getInstance(this);
                if (tooltip) {
                    tooltip.dispose();
                }
                new bootstrap.Tooltip(this);
            });
            // End of Added by Aditya J. on 20-03-2026 for tooltip reinitialization
        }

        // Added by Gauri - Handle project dropdown change for milestones
        function ProjectMilestoneOnChange() {


            var pid = $('#cboProjectMile').val();
            pid = pid ? parseInt(pid, 10) : null;

            getWhizibleTodayMilestonesList(pid);
        }

        // Added by Gauri - Fetch Review List - Review Actions Offcanvas Screen
        function getReviewActionsList(reviewID) {
            var offcanvasE2 = document.getElementById('offcanvasReviewActions');
            if (!offcanvasE2) return;

            var myOffcanvasRev = bootstrap.Offcanvas.getOrCreateInstance(offcanvasE2);
            myOffcanvasRev.show();

            // Correct tbody id
            $('#ReviewActionsTBody').html(
                '<tr><td colspan="3" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            var param = { reviewStatisticsID: reviewID || 0 };
            var url = "api/DeveloperDashEnView/GetPMReviewActions";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Robust unwrap (handles string/asp.net/d/data)
            var list = [];

            try {
                if (typeof result === 'string') result = JSON.parse(result);

                // Most common: { message, data: [...] }
                if (result && Array.isArray(result.data)) {
                    list = result.data;
                }
                // If API returns: { message, data: {..single..} }
                else if (result && result.data && typeof result.data === 'object') {
                    list = [result.data];
                }
                // If API returns directly: [...]
                else if (Array.isArray(result)) {
                    list = result;
                }
                // If API returns directly: {..single..}
                else if (result && typeof result === 'object') {
                    // Sometimes API returns a single object (rare)
                    list = [result];
                }

                // If data is stringified JSON
                if (result && typeof result.data === 'string') {
                    var parsed = JSON.parse(result.data);
                    list = Array.isArray(parsed) ? parsed : [parsed];
                }
            } catch (e) {
                console.error("Parse/normalize error:", e, result);
                list = [];
            }

            console.log("Normalized list:", list, "isArray:", Array.isArray(list), "len:", list.length);

            // Force list to be array even if single object passed
            if (list && !Array.isArray(list) && typeof list === 'object') {
                list = [list];
            }

            console.log("bindReviewActions list:", list, "isArray:", Array.isArray(list), "len:", (list || []).length);

            if (!list || !list.length) {
                $('#ReviewActionsTBody').html(
                    '<tr><td colspan="3" class="text-center text-muted p-3">No review actions found</td></tr>'
                );
                return;
            }

            var html = list.map(function (row, idx) {
                console.log("MAP HIT idx:", idx, row);

                var action = (row.action ?? '').toString();
                var reviewCause = (row.pReviewCauseID || row.cReviewCauseID || '').toString();
                var work = (row.workInHours ?? '00:00').toString();

                return `
                <tr>
                    <td>${action}</td>
                    <td>${reviewCause}</td>
                    <td class="text-center">${work}</td>
                </tr>
            `;
            }).join('');

            console.log("HTML BUILT:", html);

            $('#ReviewActionsTBody').html(html);

        }

        // Pagination for Issue List
        var issueCurrentPage = 1;
        var issueItemsPerPage = 5;
        var issueTotalItems = 0;
        var issueTotalPages = 0;

        function initIssuePagination() {
            var $issueItems = $('#CurrIssueListContainer .issue-item');
            issueTotalItems = $issueItems.length;
            issueTotalPages = Math.ceil(issueTotalItems / issueItemsPerPage);

            // Update total records count
            $('#TotalRecords6').text(issueTotalItems);

            // Show first page
            showIssuePage(1);
        }

        function showIssuePage(page) {
            issueCurrentPage = page;
            var $issueItems = $('.issue-item');
            var startIndex = (page - 1) * issueItemsPerPage;
            var endIndex = startIndex + issueItemsPerPage;

            // Hide all items first
            $issueItems.hide();

            // Show items for current page
            $issueItems.slice(startIndex, endIndex).show();

            // Update pagination controls
            updateIssuePaginationControls();
        }

        function updateIssuePaginationControls() {
            // Reset button states first
            $("#btnPreviousIssue").removeClass("fa-disabled");
            $("#btnNextIssue").removeClass("fa-disabled");
            $("#LinkPreviousIssue").removeClass("disabled");
            $("#LinkNextIssue").removeClass("disabled");

            // Handle first page - disable previous button
            if (issueCurrentPage <= 1) {
                $("#btnPreviousIssue").addClass("fa-disabled");
                $("#LinkPreviousIssue").addClass("disabled");
            }

            // Handle last page - disable next button
            if (issueCurrentPage >= issueTotalPages) {
                $("#btnNextIssue").addClass("fa-disabled");
                $("#LinkNextIssue").addClass("disabled");
            }
        }

        function PrevList() {
            // Safety check - prevent navigation if disabled
            if ($("#btnPreviousIssue").hasClass("fa-disabled") || $("#LinkPreviousIssue").hasClass("disabled")) {
                return false;
            }

            if (issueCurrentPage > 1) {
                showIssuePage(issueCurrentPage - 1);
            }
        }

        function NextList() {
            // Safety check - prevent navigation if disabled
            if ($("#btnNextIssue").hasClass("fa-disabled") || $("#LinkNextIssue").hasClass("disabled")) {
                return false;
            }

            // Only increment if not on last page
            if (issueCurrentPage < issueTotalPages) {
                showIssuePage(issueCurrentPage + 1);
            }
        }
        // End of Pagination for Issue List

        // ---------------------------

        // OLD Issues Pagination
        // ---------------------------
        var oldIssueCurrentPage = 1;
        var oldIssueItemsPerPage = 5;
        var oldIssueTotalItems = 0;
        var oldIssueTotalPages = 0;

        function initOldIssuePagination() {

            // Old issues container items
            var $items = $('#OpenIssueListContainer .issue-item');

            oldIssueTotalItems = $items.length;
            oldIssueTotalPages = Math.ceil(oldIssueTotalItems / oldIssueItemsPerPage);

            $('#TotalRecordsOldIssue').text(oldIssueTotalItems);

            // Reset to page 1 on every bind
            oldIssueCurrentPage = 1;

            showOldIssuePage(oldIssueCurrentPage);
        }

        function showOldIssuePage(page) {

            var $items = $('#OpenIssueListContainer .issue-item');

            oldIssueCurrentPage = page;

            var start = (page - 1) * oldIssueItemsPerPage;
            var end = start + oldIssueItemsPerPage;

            $items.hide().slice(start, end).show();

            updateOldIssuePaginationControls();
        }

        function updateOldIssuePaginationControls() {

            // Enable by default
            $("#btnPreviousOldIssue,#LinkPreviousOldIssue").removeClass("disabled fa-disabled");
            $("#btnNextOldIssue,#LinkNextOldIssue").removeClass("disabled fa-disabled");

            // Disable prev
            if (oldIssueCurrentPage <= 1) {
                $("#btnPreviousOldIssue").addClass("fa-disabled");
                $("#LinkPreviousOldIssue").addClass("disabled");
            }

            // Disable next
            if (oldIssueCurrentPage >= oldIssueTotalPages || oldIssueTotalPages === 0) {
                $("#btnNextOldIssue").addClass("fa-disabled");
                $("#LinkNextOldIssue").addClass("disabled");
            }
        }

        function PrevOldIssueList() {
            if ($("#btnPreviousOldIssue").hasClass("fa-disabled")) return;
            if (oldIssueCurrentPage > 1) showOldIssuePage(oldIssueCurrentPage - 1);
        }

        function NextOldIssueList() {
            if ($("#btnNextOldIssue").hasClass("fa-disabled")) return;
            if (oldIssueCurrentPage < oldIssueTotalPages) showOldIssuePage(oldIssueCurrentPage + 1);
        }

        // Pagination for RunningTask List
        var taskCurrentPage = 1;
        var taskItemsPerPage = 5;
        var taskTotalItems = 0;
        var taskTotalPages = 0;

        function initTaskPagination() {
            var $taskItems = $('.RunningTaskListContainer .task-item');
            taskTotalItems = $taskItems.length;
            taskTotalPages = Math.ceil(taskTotalItems / taskItemsPerPage);

            // Update total records count
            $('#TotalRecordsTask').text(taskTotalItems);

            // Show first page
            showTaskPage(1);
        }

        function showTaskPage(page) {
            taskCurrentPage = page;
            var $taskItems = $('.task-item');
            var startIndex = (page - 1) * taskItemsPerPage;
            var endIndex = startIndex + taskItemsPerPage;

            // Hide all items first
            $taskItems.hide();

            // Show items for current page
            $taskItems.slice(startIndex, endIndex).show();

            // Update pagination controls
            updateTaskPaginationControls();
        }

        function updateTaskPaginationControls() {
            // Reset button states first
            $("#btnPreviousTask").removeClass("fa-disabled");
            $("#btnNextTask").removeClass("fa-disabled");
            $("#LinkPreviousTask").removeClass("disabled");
            $("#LinkNextTask").removeClass("disabled");

            // Handle first page - disable previous button
            if (taskCurrentPage <= 1) {
                $("#btnPreviousTask").addClass("fa-disabled");
                $("#LinkPreviousTask").addClass("disabled");
            }

            // Handle last page - disable next button
            if (taskCurrentPage >= taskTotalPages) {
                $("#btnNextTask").addClass("fa-disabled");
                $("#LinkNextTask").addClass("disabled");
            }
        }

        function PrevTaskList() {
            if ($("#btnPreviousTask").hasClass("fa-disabled") || $("#LinkPreviousTask").hasClass("disabled")) {
                return false;
            }

            if (taskCurrentPage > 1) {
                showTaskPage(taskCurrentPage - 1);
            }
        }

        function NextTaskList() {
            if ($("#btnNextTask").hasClass("fa-disabled") || $("#LinkNextTask").hasClass("disabled")) {
                return false;
            }

            if (taskCurrentPage < taskTotalPages) {
                showTaskPage(taskCurrentPage + 1);
            }
        }
        // End of Pagination for Task List

        // Pagination for Old Task List
        var oldTaskCurrentPage = 1;
        var oldTaskItemsPerPage = 5;
        var oldTaskTotalItems = 0;
        var oldTaskTotalPages = 0;

        function initOldTaskPagination() {
            var $items = $('#OldTasksList .task-item');
            oldTaskTotalItems = $items.length;
            oldTaskTotalPages = Math.ceil(oldTaskTotalItems / oldTaskItemsPerPage);

            $('#TotalRecordsOldTask').text(oldTaskTotalItems);

            showOldTaskPage(1);
        }

        function showOldTaskPage(page) {
            oldTaskCurrentPage = page;

            var $items = $('#OldTasksList .task-item');
            var start = (page - 1) * oldTaskItemsPerPage;
            var end = start + oldTaskItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateOldTaskPaginationControls();
        }

        function updateOldTaskPaginationControls() {
            $("#btnPreviousOldTask, #LinkPreviousOldTask").removeClass("disabled fa-disabled");
            $("#btnNextOldTask, #LinkNextOldTask").removeClass("disabled fa-disabled");

            if (oldTaskCurrentPage <= 1) {
                $("#btnPreviousOldTask").addClass("fa-disabled");
                $("#LinkPreviousOldTask").addClass("disabled");
            }

            if (oldTaskCurrentPage >= oldTaskTotalPages) {
                $("#btnNextOldTask").addClass("fa-disabled");
                $("#LinkNextOldTask").addClass("disabled");
            }
        }

        function PrevOldTaskList() {
            if ($("#btnPreviousOldTask").hasClass("fa-disabled")) return false;
            if (oldTaskCurrentPage > 1) showOldTaskPage(oldTaskCurrentPage - 1);
        }

        function NextOldTaskList() {
            if ($("#btnNextOldTask").hasClass("fa-disabled")) return false;
            if (oldTaskCurrentPage < oldTaskTotalPages) showOldTaskPage(oldTaskCurrentPage + 1);
        }

        // Pagination for YetToStart Task List
        var yetStartTaskCurrentPage = 1;
        var yetStartTaskItemsPerPage = 5;
        var yetStartTaskTotalItems = 0;
        var yetStartTaskTotalPages = 0;

        function initYetStartTaskPagination() {
            var $items = $('#YetStartTasksList .task-item');
            yetStartTaskTotalItems = $items.length;
            yetStartTaskTotalPages = Math.ceil(yetStartTaskTotalItems / yetStartTaskItemsPerPage);

            $('#TotalRecordsYetStartTask').text(yetStartTaskTotalItems);

            showYetStartTaskPage(1);
        }

        function showYetStartTaskPage(page) {
            yetStartTaskCurrentPage = page;

            var $items = $('#YetStartTasksList .task-item');
            var start = (page - 1) * yetStartTaskItemsPerPage;
            var end = start + yetStartTaskItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateYetStartTaskPaginationControls();
        }

        function updateYetStartTaskPaginationControls() {
            $("#btnPreviousYetStartTask, #LinkPreviousYetStartTask").removeClass("disabled fa-disabled");
            $("#btnNextYetStartTask, #LinkNextYetStartTask").removeClass("disabled fa-disabled");

            if (yetStartTaskCurrentPage <= 1) {
                $("#btnPreviousYetStartTask").addClass("fa-disabled");
                $("#LinkPreviousYetStartTask").addClass("disabled");
            }

            if (yetStartTaskCurrentPage >= yetStartTaskTotalPages) {
                $("#btnNextYetStartTask").addClass("fa-disabled");
                $("#LinkNextYetStartTask").addClass("disabled");
            }
        }

        function PrevYetStartTaskList() {
            if ($("#btnPreviousYetStartTask").hasClass("fa-disabled")) return false;
            if (yetStartTaskCurrentPage > 1) showYetStartTaskPage(yetStartTaskCurrentPage - 1);
        }

        function NextYetStartTaskList() {
            if ($("#btnNextYetStartTask").hasClass("fa-disabled")) return false;
            if (yetStartTaskCurrentPage < yetStartTaskTotalPages) showYetStartTaskPage(yetStartTaskCurrentPage + 1);
        }

        // Pagination for Deliverable List
        var deliverableCurrentPage = 1;
        var deliverableItemsPerPage = 5;
        var deliverableTotalItems = 0;
        var deliverableTotalPages = 0;

        function initDeliverablePagination() {
            var $deliverableItems = $('.deliverable-item');
            deliverableTotalItems = $deliverableItems.length;
            deliverableTotalPages = Math.ceil(deliverableTotalItems / deliverableItemsPerPage);

            // Update total records count
            $('#TotalRecordsDeliverable').text(deliverableTotalItems);

            // Show first page
            showDeliverablePage(1);
        }

        function showDeliverablePage(page) {
            deliverableCurrentPage = page;
            var $deliverableItems = $('.deliverable-item');
            var startIndex = (page - 1) * deliverableItemsPerPage;
            var endIndex = startIndex + deliverableItemsPerPage;

            // Hide all items first
            $deliverableItems.hide();

            // Show items for current page
            $deliverableItems.slice(startIndex, endIndex).show();

            // Update pagination controls
            updateDeliverablePaginationControls();
        }

        function updateDeliverablePaginationControls() {
            // Reset button states first
            $("#btnPreviousDeliverable").removeClass("fa-disabled");
            $("#btnNextDeliverable").removeClass("fa-disabled");
            $("#LinkPreviousDeliverable").removeClass("disabled");
            $("#LinkNextDeliverable").removeClass("disabled");

            // Handle first page - disable previous button
            if (deliverableCurrentPage <= 1) {
                $("#btnPreviousDeliverable").addClass("fa-disabled");
                $("#LinkPreviousDeliverable").addClass("disabled");
            }

            // Handle last page - disable next button
            if (deliverableCurrentPage >= deliverableTotalPages) {
                $("#btnNextDeliverable").addClass("fa-disabled");
                $("#LinkNextDeliverable").addClass("disabled");
            }
        }

        function PrevDeliverableList() {
            if ($("#btnPreviousDeliverable").hasClass("fa-disabled") || $("#LinkPreviousDeliverable").hasClass("disabled")) {
                return false;
            }

            if (deliverableCurrentPage > 1) {
                showDeliverablePage(deliverableCurrentPage - 1);
            }
        }

        function NextDeliverableList() {
            if ($("#btnNextDeliverable").hasClass("fa-disabled") || $("#LinkNextDeliverable").hasClass("disabled")) {
                return false;
            }

            if (deliverableCurrentPage < deliverableTotalPages) {
                showDeliverablePage(deliverableCurrentPage + 1);
            }
        }
        // End of Pagination for Deliverable List

        // Pagination for Review List
        var reviewCurrentPage = 1;
        var reviewItemsPerPage = 5;
        var reviewTotalItems = 0;
        var reviewTotalPages = 0;

        function initReviewPagination() {
            var $reviewItems = $('.review-item');
            reviewTotalItems = $reviewItems.length;
            reviewTotalPages = Math.ceil(reviewTotalItems / reviewItemsPerPage);

            // Update total records count
            $('#TotalRecordsReview').text(reviewTotalItems);

            // Show first page
            showReviewPage(1);
        }

        function showReviewPage(page) {
            reviewCurrentPage = page;
            var $reviewItems = $('.review-item');
            var startIndex = (page - 1) * reviewItemsPerPage;
            var endIndex = startIndex + reviewItemsPerPage;

            // Hide all items first
            $reviewItems.hide();

            // Show items for current page
            $reviewItems.slice(startIndex, endIndex).show();

            // Update pagination controls
            updateReviewPaginationControls();
        }

        function updateReviewPaginationControls() {
            // Reset button states first
            $("#btnPreviousReview").removeClass("fa-disabled");
            $("#btnNextReview").removeClass("fa-disabled");
            $("#LinkPreviousReview").removeClass("disabled");
            $("#LinkNextReview").removeClass("disabled");

            // Handle first page - disable previous button
            if (reviewCurrentPage <= 1) {
                $("#btnPreviousReview").addClass("fa-disabled");
                $("#LinkPreviousReview").addClass("disabled");
            }

            // Handle last page - disable next button
            if (reviewCurrentPage >= reviewTotalPages) {
                $("#btnNextReview").addClass("fa-disabled");
                $("#LinkNextReview").addClass("disabled");
            }
        }

        function PrevReviewList() {
            if ($("#btnPreviousReview").hasClass("fa-disabled") || $("#LinkPreviousReview").hasClass("disabled")) {
                return false;
            }

            if (reviewCurrentPage > 1) {
                showReviewPage(reviewCurrentPage - 1);
            }
        }

        function NextReviewList() {
            if ($("#btnNextReview").hasClass("fa-disabled") || $("#LinkNextReview").hasClass("disabled")) {
                return false;
            }

            if (reviewCurrentPage < reviewTotalPages) {
                showReviewPage(reviewCurrentPage + 1);
            }
        }

        // Pagination for Milestone List
        var milestoneCurrentPage = 1;
        var milestoneItemsPerPage = 5;
        var milestoneTotalItems = 0;
        var milestoneTotalPages = 0;

        function initMilestonePagination() {
            var $items = $('#milestoneListContainer .milestone-item');
            milestoneTotalItems = $items.length;
            milestoneTotalPages = Math.ceil(milestoneTotalItems / milestoneItemsPerPage);

            $('#TotalRecordsMilestone').text(milestoneTotalItems);

            showMilestonePage(1);
        }

        function showMilestonePage(page) {
            milestoneCurrentPage = page;

            var $items = $('#milestoneListContainer .milestone-item');
            var start = (page - 1) * milestoneItemsPerPage;
            var end = start + milestoneItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateMilestonePaginationControls();
        }

        function updateMilestonePaginationControls() {
            $("#btnPreviousMilestone, #LinkPreviousMilestone").removeClass("disabled fa-disabled");
            $("#btnNextMilestone, #LinkNextMilestone").removeClass("disabled fa-disabled");

            if (milestoneCurrentPage <= 1) {
                $("#btnPreviousMilestone").addClass("fa-disabled");
                $("#LinkPreviousMilestone").addClass("disabled");
            }

            if (milestoneCurrentPage >= milestoneTotalPages) {
                $("#btnNextMilestone").addClass("fa-disabled");
                $("#LinkNextMilestone").addClass("disabled");
            }
        }

        function PrevMilestoneList() {
            if ($("#btnPreviousMilestone").hasClass("fa-disabled")) return false;
            if (milestoneCurrentPage > 1) showMilestonePage(milestoneCurrentPage - 1);
        }

        function NextMilestoneList() {
            if ($("#btnNextMilestone").hasClass("fa-disabled")) return false;
            if (milestoneCurrentPage < milestoneTotalPages) showMilestonePage(milestoneCurrentPage + 1);
        }

        // Added by Aditya J. on 20-03-2026 for pagination of Milestone Details
        var milestoneDetailsCurrentPage = 1;
        var milestoneDetailsItemsPerPage = 5;
        var milestoneDetailsTotalItems = 0;
        var milestoneDetailsTotalPages = 0;

        function initMilestoneDetailsPagination() {
            var $items = $('#MilestonesDetailsTBody .milestone-details-item');
            milestoneDetailsTotalItems = $items.length;
            milestoneDetailsTotalPages = Math.ceil(milestoneDetailsTotalItems / milestoneDetailsItemsPerPage);

            $('#TotalRecordsMilestoneDetails').text(milestoneDetailsTotalItems);

            // If there are no items, hide pagination controls
            if (!milestoneDetailsTotalItems) {
                $('#paginationControlsMilestoneDetails').hide();
                return;
            }

            $('#paginationControlsMilestoneDetails').show();
            milestoneDetailsCurrentPage = 1;
            showMilestoneDetailsPage(1);
        }

        function showMilestoneDetailsPage(page) {
            milestoneDetailsCurrentPage = page;

            var $items = $('#MilestonesDetailsTBody .milestone-details-item');
            var start = (page - 1) * milestoneDetailsItemsPerPage;
            var end = start + milestoneDetailsItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateMilestoneDetailsPaginationControls();
        }

        function updateMilestoneDetailsPaginationControls() {
            $("#btnPreviousMilestoneDetails, #LinkPreviousMilestoneDetails").removeClass("disabled fa-disabled");
            $("#btnNextMilestoneDetails, #LinkNextMilestoneDetails").removeClass("disabled fa-disabled");

            if (milestoneDetailsCurrentPage <= 1) {
                $("#btnPreviousMilestoneDetails").addClass("fa-disabled");
                $("#LinkPreviousMilestoneDetails").addClass("disabled");
            }

            if (milestoneDetailsCurrentPage >= milestoneDetailsTotalPages) {
                $("#btnNextMilestoneDetails").addClass("fa-disabled");
                $("#LinkNextMilestoneDetails").addClass("disabled");
            }
        }

        function PrevMilestoneDetailsList() {
            if ($("#btnPreviousMilestoneDetails").hasClass("fa-disabled")) return false;
            if (milestoneDetailsCurrentPage > 1) showMilestoneDetailsPage(milestoneDetailsCurrentPage - 1);
        }

        function NextMilestoneDetailsList() {
            if ($("#btnNextMilestoneDetails").hasClass("fa-disabled")) return false;
            if (milestoneDetailsCurrentPage < milestoneDetailsTotalPages) showMilestoneDetailsPage(milestoneDetailsCurrentPage + 1);
        }

        // Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details
        var deliverableDetailsCurrentPage = 1;
        var deliverableDetailsItemsPerPage = 5;
        var deliverableDetailsTotalItems = 0;
        var deliverableDetailsTotalPages = 0;

        function initDeliverableDetailsPagination() {
            var $items = $('#DeliverableDetailsTBody .deliverable-details-item');
            deliverableDetailsTotalItems = $items.length;
            deliverableDetailsTotalPages = Math.ceil(deliverableDetailsTotalItems / deliverableDetailsItemsPerPage);

            $('#TotalRecordsDeliverableDetails').text(deliverableDetailsTotalItems);

            // If there are no items, hide pagination controls
            if (!deliverableDetailsTotalItems) {
                $('#paginationControlsDeliverableDetails').hide();
                return;
            }

            $('#paginationControlsDeliverableDetails').show();
            deliverableDetailsCurrentPage = 1;
            showDeliverableDetailsPage(1);
        }

        function showDeliverableDetailsPage(page) {
            deliverableDetailsCurrentPage = page;

            var $items = $('#DeliverableDetailsTBody .deliverable-details-item');
            var start = (page - 1) * deliverableDetailsItemsPerPage;
            var end = start + deliverableDetailsItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateDeliverableDetailsPaginationControls();
        }

        function updateDeliverableDetailsPaginationControls() {
            $("#btnPreviousDeliverableDetails, #LinkPreviousDeliverableDetails").removeClass("disabled fa-disabled");
            $("#btnNextDeliverableDetails, #LinkNextDeliverableDetails").removeClass("disabled fa-disabled");

            if (deliverableDetailsCurrentPage <= 1) {
                $("#btnPreviousDeliverableDetails").addClass("fa-disabled");
                $("#LinkPreviousDeliverableDetails").addClass("disabled");
            }

            if (deliverableDetailsCurrentPage >= deliverableDetailsTotalPages) {
                $("#btnNextDeliverableDetails").addClass("fa-disabled");
                $("#LinkNextDeliverableDetails").addClass("disabled");
            }
        }

        function PrevDeliverableDetailsList() {
            if ($("#btnPreviousDeliverableDetails").hasClass("fa-disabled")) return false;
            if (deliverableDetailsCurrentPage > 1) showDeliverableDetailsPage(deliverableDetailsCurrentPage - 1);
        }

        function NextDeliverableDetailsList() {
            if ($("#btnNextDeliverableDetails").hasClass("fa-disabled")) return false;
            if (deliverableDetailsCurrentPage < deliverableDetailsTotalPages) showDeliverableDetailsPage(deliverableDetailsCurrentPage + 1);
        }
        // End of Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details

        // Added by Aditya J. on 20-03-2026 for pagination of Task Details
        var taskDetailsCurrentPage = 1;
        var taskDetailsItemsPerPage = 5;
        var taskDetailsTotalItems = 0;
        var taskDetailsTotalPages = 0;

        function initTaskDetailsPagination() {
            var $items = $('#TaskDetailsTBody .task-details-item');
            taskDetailsTotalItems = $items.length;
            taskDetailsTotalPages = Math.ceil(taskDetailsTotalItems / taskDetailsItemsPerPage);

            $('#TotalRecordsTaskDetails').text(taskDetailsTotalItems);

            // If there are no items, hide pagination controls
            if (!taskDetailsTotalItems) {
                $('#paginationControlsTaskDetails').hide();
                return;
            }

            $('#paginationControlsTaskDetails').show();
            taskDetailsCurrentPage = 1;
            showTaskDetailsPage(1);
        }

        function showTaskDetailsPage(page) {
            taskDetailsCurrentPage = page;

            var $items = $('#TaskDetailsTBody .task-details-item');
            var start = (page - 1) * taskDetailsItemsPerPage;
            var end = start + taskDetailsItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateTaskDetailsPaginationControls();
        }

        function updateTaskDetailsPaginationControls() {
            $("#btnPreviousTaskDetails, #LinkPreviousTaskDetails").removeClass("disabled fa-disabled");
            $("#btnNextTaskDetails, #LinkNextTaskDetails").removeClass("disabled fa-disabled");

            if (taskDetailsCurrentPage <= 1) {
                $("#btnPreviousTaskDetails").addClass("fa-disabled");
                $("#LinkPreviousTaskDetails").addClass("disabled");
            }

            if (taskDetailsCurrentPage >= taskDetailsTotalPages) {
                $("#btnNextTaskDetails").addClass("fa-disabled");
                $("#LinkNextTaskDetails").addClass("disabled");
            }
        }

        function PrevTaskDetailsList() {
            if ($("#btnPreviousTaskDetails").hasClass("fa-disabled")) return false;
            if (taskDetailsCurrentPage > 1) showTaskDetailsPage(taskDetailsCurrentPage - 1);
        }

        function NextTaskDetailsList() {
            if ($("#btnNextTaskDetails").hasClass("fa-disabled")) return false;
            if (taskDetailsCurrentPage < taskDetailsTotalPages) showTaskDetailsPage(taskDetailsCurrentPage + 1);
        }
        // End of Added by Aditya J. on 20-03-2026 for pagination of Task Details

        // Added by Aditya J. on 20-03-2026 for pagination of Issue Details
        var issueDetailsCurrentPage = 1;
        var issueDetailsItemsPerPage = 5;
        var issueDetailsTotalItems = 0;
        var issueDetailsTotalPages = 0;

        function initIssueDetailsPagination() {
            var $items = $('#IssueDetailsTBody .issue-details-item');
            issueDetailsTotalItems = $items.length;
            issueDetailsTotalPages = Math.ceil(issueDetailsTotalItems / issueDetailsItemsPerPage);

            $('#TotalRecordsIssueDetails').text(issueDetailsTotalItems);

            // If there are no items, hide pagination controls
            if (!issueDetailsTotalItems) {
                $('#paginationControlsIssueDetails').hide();
                return;
            }

            $('#paginationControlsIssueDetails').show();
            issueDetailsCurrentPage = 1;
            showIssueDetailsPage(1);
        }

        function showIssueDetailsPage(page) {
            issueDetailsCurrentPage = page;

            var $items = $('#IssueDetailsTBody .issue-details-item');
            var start = (page - 1) * issueDetailsItemsPerPage;
            var end = start + issueDetailsItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateIssueDetailsPaginationControls();
        }

        function updateIssueDetailsPaginationControls() {
            $("#btnPreviousIssueDetails, #LinkPreviousIssueDetails").removeClass("disabled fa-disabled");
            $("#btnNextIssueDetails, #LinkNextIssueDetails").removeClass("disabled fa-disabled");

            if (issueDetailsCurrentPage <= 1) {
                $("#btnPreviousIssueDetails").addClass("fa-disabled");
                $("#LinkPreviousIssueDetails").addClass("disabled");
            }

            if (issueDetailsCurrentPage >= issueDetailsTotalPages) {
                $("#btnNextIssueDetails").addClass("fa-disabled");
                $("#LinkNextIssueDetails").addClass("disabled");
            }
        }

        function PrevIssueDetailsList() {
            if ($("#btnPreviousIssueDetails").hasClass("fa-disabled")) return false;
            if (issueDetailsCurrentPage > 1) showIssueDetailsPage(issueDetailsCurrentPage - 1);
        }

        function NextIssueDetailsList() {
            if ($("#btnNextIssueDetails").hasClass("fa-disabled")) return false;
            if (issueDetailsCurrentPage < issueDetailsTotalPages) showIssueDetailsPage(issueDetailsCurrentPage + 1);
        }
        // End of Added by Aditya J. on 20-03-2026 for pagination of Issue Details

        // Added by Aditya J. on 20-03-2026 for pagination of Review Details
        var reviewDetailsCurrentPage = 1;
        var reviewDetailsItemsPerPage = 5;
        var reviewDetailsTotalItems = 0;
        var reviewDetailsTotalPages = 0;

        function initReviewDetailsPagination() {
            var $items = $('#ReviewsDetailsTBody .review-details-item');
            reviewDetailsTotalItems = $items.length;
            reviewDetailsTotalPages = Math.ceil(reviewDetailsTotalItems / reviewDetailsItemsPerPage);

            $('#TotalRecordsReviewDetails').text(reviewDetailsTotalItems);

            // If there are no items, hide pagination controls
            if (!reviewDetailsTotalItems) {
                $('#paginationControlsReviewDetails').hide();
                return;
            }

            $('#paginationControlsReviewDetails').show();
            reviewDetailsCurrentPage = 1;
            showReviewDetailsPage(1);
        }

        function showReviewDetailsPage(page) {
            reviewDetailsCurrentPage = page;

            var $items = $('#ReviewsDetailsTBody .review-details-item');
            var start = (page - 1) * reviewDetailsItemsPerPage;
            var end = start + reviewDetailsItemsPerPage;

            $items.hide();
            $items.slice(start, end).show();

            updateReviewDetailsPaginationControls();
        }

        function updateReviewDetailsPaginationControls() {
            $("#btnPreviousReviewDetails, #LinkPreviousReviewDetails").removeClass("disabled fa-disabled");
            $("#btnNextReviewDetails, #LinkNextReviewDetails").removeClass("disabled fa-disabled");

            if (reviewDetailsCurrentPage <= 1) {
                $("#btnPreviousReviewDetails").addClass("fa-disabled");
                $("#LinkPreviousReviewDetails").addClass("disabled");
            }

            if (reviewDetailsCurrentPage >= reviewDetailsTotalPages) {
                $("#btnNextReviewDetails").addClass("fa-disabled");
                $("#LinkNextReviewDetails").addClass("disabled");
            }
        }

        function PrevReviewDetailsList() {
            if ($("#btnPreviousReviewDetails").hasClass("fa-disabled")) return false;
            if (reviewDetailsCurrentPage > 1) showReviewDetailsPage(reviewDetailsCurrentPage - 1);
        }

        function NextReviewDetailsList() {
            if ($("#btnNextReviewDetails").hasClass("fa-disabled")) return false;
            if (reviewDetailsCurrentPage < reviewDetailsTotalPages) showReviewDetailsPage(reviewDetailsCurrentPage + 1);
        }
        // End of Added by Aditya J. on 20-03-2026 for pagination of Review Details

        // ===============================
        // Added by Gauri - Calendar Month Navigation
        // ===============================
        // var calViewDate = new Date(); // today
        // calViewDate.setDate(1);       // always keep it on 1st day of month

        // ===============================
        // Weekly + Monthly Toggle
        // ===============================
        var calMode = "week"; // "week" | "month"
        var calFocusDate = new Date(); // used for week navigation
        var calViewDate = new Date();  // used for month navigation (you already have this)
        calViewDate.setDate(1);

        function pad2(n) { return String(n).padStart(2, "0"); }

        // Monday as start
        function getWeekStart(d) {
            var x = new Date(d.getFullYear(), d.getMonth(), d.getDate());
            var day = x.getDay(); // Sun=0..Sat=6
            var diff = (day === 0 ? -6 : 1) - day; // move to Monday
            x.setDate(x.getDate() + diff);
            x.setHours(0, 0, 0, 0);
            return x;
        }

        // Added by Gauri - Format: "Dec 22 - 28, 2025"
        function fmtRangeLabel(weekStart) {
            var weekEnd = new Date(weekStart);
            weekEnd.setDate(weekStart.getDate() + 6);

            // Example: "Dec 22 - 28, 2025"
            var optsM = { month: "short" };
            var m1 = weekStart.toLocaleDateString("en-US", optsM);
            var m2 = weekEnd.toLocaleDateString("en-US", optsM);

            var d1 = weekStart.getDate();
            var d2 = weekEnd.getDate();
            var y2 = weekEnd.getFullYear();

            // If month changes in the week, show both months
            if (weekStart.getMonth() !== weekEnd.getMonth()) {
                return `${m1} ${d1} - ${m2} ${d2}, ${y2}`;
            }
            return `${m1} ${d1} - ${d2}, ${y2}`;
        }

        // Added by Gauri - Format: "January 2025"
        function monthName(year, monthIndex) {
            var names = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            return names[monthIndex] + " " + year;
        }

        // Added by Gauri - Set Header Label
        function setHeaderLabel() {
            var $lbl = $("#lblCalendarRangeOrMonth");
            if (!$lbl.length) return;

            if (calMode === "week") {
                var ws = getWeekStart(calFocusDate);
                $lbl.text(fmtRangeLabel(ws));
            } else {
                $lbl.text(monthName(calViewDate.getFullYear(), calViewDate.getMonth()));
            }
        }

        // Weekly Rendering
        function renderWeeklyView() {
            var ws = getWeekStart(calFocusDate);
            var $week = $("#calendarWeek");
            if (!$week.length) return;

            $week.empty();

            var dow = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
            var today = new Date(); today.setHours(0, 0, 0, 0);

            for (var i = 0; i < 7; i++) {
                var dayDate = new Date(ws);
                dayDate.setDate(ws.getDate() + i);

                var dateKey = dayDate.getFullYear() + "-" + pad2(dayDate.getMonth() + 1) + "-" + pad2(dayDate.getDate());
                var isToday = (dayDate.getTime() === today.getTime());

                var cls = "week-day" + (isToday ? " selected" : "");
                var dayHtml = `
                    <div class="${cls}" data-date="${dateKey}">
                    <div class="week-day-head">
                        <div class="week-dow">${dow[i]}</div>
                        <div class="week-date">${dayDate.getDate()}</div>
                    </div>
                    <div class="week-day-body" id="weekBody_${dateKey.replaceAll('-', '')}"></div>
                    </div>
                `;
                $week.append(dayHtml);

                var $body = $("#weekBody_" + dateKey.replaceAll('-', ''));
                var dayEvents = map[dateKey] || [];

                // First show count chips if present
                dayEvents.filter(x => x.countText).forEach(function (e) {
                    $body.append(`<div class="week-count">${e.countText}</div>`);
                });

                // Then show event cards
                dayEvents.filter(x => x.title).forEach(function (e) {
                    var typeCls = "we-task";
                    if (e.type === "holiday") typeCls = "we-holiday";
                    if (e.type === "meeting") typeCls = "we-meeting";
                    if (e.type === "deadline") typeCls = "we-deadline";

                    $body.append(`
                    <div class="week-event ${typeCls}">
                        <div class="we-title">${e.title}</div>
                        <div class="we-meta">
                        <i class="far fa-clock"></i>
                        <span>${e.time || ""}</span>
                        </div>
                    </div>
                    `);
                });
            }

            setHeaderLabel();
        }

        // Month Rendering (your existing)
        function renderMonthlyView() {
            // Use your existing renderCalendarGrid(calViewDate)
            if (typeof renderCalendarGrid === "function") {
                renderCalendarGrid(calViewDate);
                getCalendarWBSCount("month", calViewDate);
            }
            setHeaderLabel();
        }

        // Toggle UI
        function setMode(mode) {
            calMode = mode;

            // Buttons
            $("#btnViewWeekly").toggleClass("active", mode === "week");
            $("#btnViewMonthly").toggleClass("active", mode === "month");

            // Views
            $("#calendarWeekWrap").toggleClass("d-none", mode !== "week");
            $("#calendarGrid").toggleClass("d-none", mode !== "month");

            // Render
            if (mode === "week") {
                renderWeeklyView();
                //  week view: pass START DATE OF MONTH (based on calFocusDate)
                getCalendarWBSCount("week", calFocusDate);
            } else {
                renderMonthlyView();
                // optional: bind month counts/holidays/leaves (your existing)
                if (typeof bindCalendarCountsForMonth === "function") bindCalendarCountsForMonth();
                if (typeof bindCalendarHolidaysAndLeaves === "function") bindCalendarHolidaysAndLeaves();

                // month view: pass START DATE OF MONTH (based on calViewDate)
                getCalendarWBSCount("month", calViewDate);
            }
        }

        // Monday-first index: Mon=0 ... Sun=6
        function getMondayFirstDayIndex(jsDayIndex) {
            // JS: Sun=0 Mon=1 ... Sat=6
            return (jsDayIndex + 6) % 7;
        }

        // Added by Gauri - Render Weekday Headers (Mon..Sun)
        function renderWeekdayHeaders($grid) {
            // Remove existing weekday headers if any
            $grid.find(".calendar-dow").remove();

            var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

            days.forEach(function (d) {
                $grid.append(`
                    <div class="calendar-dow">${d}</div>
                `);
            });
        }

        // Added by Gauri - Render Calendar Grid for Month View
        function renderCalendarGrid(viewDate) {
            var year = viewDate.getFullYear();
            var month = viewDate.getMonth(); // 0-11

            // Set header label
            $("#lblCalendarMonth").text(monthName(year, month));

            var $grid = $("#calendarGrid");
            if ($grid.length === 0) return;

            // Keep the weekday headers (Mon..Sun) already in HTML
            // Remove old date cells only (everything except the first 7 dow items)
            $grid.find(".calendar-cell").remove();
            $grid.find(".calendar-dow").remove();

            // ADD weekday headers first
            renderWeekdayHeaders($grid);

            var firstOfMonth = new Date(year, month, 1);
            var firstDayIndex = getMondayFirstDayIndex(firstOfMonth.getDay()); // 0..6

            var daysInMonth = new Date(year, month + 1, 0).getDate();
            var daysInPrevMonth = new Date(year, month, 0).getDate();

            // We render 42 cells (6 weeks) for stable layout
            var needed = firstDayIndex + daysInMonth;
            var totalCells = Math.ceil(needed / 7) * 7;

            var today = new Date();
            var todayY = today.getFullYear();
            var todayM = today.getMonth();
            var todayD = today.getDate();

            for (var i = 0; i < totalCells; i++) {
                var cellDateNum, isMuted = false;
                var cellYear = year, cellMonth = month;

                if (i < firstDayIndex) {
                    // previous month
                    isMuted = true;
                    cellDateNum = (daysInPrevMonth - firstDayIndex + 1) + i;
                    var prev = new Date(year, month - 1, 1);
                    cellYear = prev.getFullYear();
                    cellMonth = prev.getMonth();
                } else if (i >= firstDayIndex + daysInMonth) {
                    // next month
                    isMuted = true;
                    cellDateNum = (i - (firstDayIndex + daysInMonth)) + 1;
                    var next = new Date(year, month + 1, 1);
                    cellYear = next.getFullYear();
                    cellMonth = next.getMonth();
                } else {
                    // current month
                    cellDateNum = (i - firstDayIndex) + 1;
                }

                // highlight today if it’s in the visible month AND not muted
                var isToday = (!isMuted && cellYear === todayY && cellMonth === todayM && cellDateNum === todayD);

                // Skip previous / next month dates completely
                if (isMuted) {
                    $grid.append(`
                        <div class="calendar-cell muted"></div>
                    `);
                    continue;
                }

                var cls = "calendar-cell";
                // if (isMuted) cls += " muted";
                if (isToday) cls += " selected";

                // Store date on the cell if you want to click and load tasks/issues/etc
                var mm = String(cellMonth + 1).padStart(2, "0");
                var dd = String(cellDateNum).padStart(2, "0");
                var iso = cellYear + "-" + mm + "-" + dd;   // LOCAL date key, no timezone conversion

                var html = `
                    <div class="${cls}" data-date="${iso}">
                        <span class="day">${cellDateNum}</span>
                    </div>
                `;

                $grid.append(html);
            }
        }

        // Added by Gauri - Month Navigation
        function goPrevMonth() {
            calViewDate.setMonth(calViewDate.getMonth() - 1);
            calViewDate.setDate(1);
            renderCalendarGrid(calViewDate);
            getCalendarWBSCount("month", calViewDate);
            bindCalendarCountsForMonth();
            bindCalendarHolidaysAndLeaves();
        }

        // Added by Gauri - Month Navigation
        function goNextMonth() {
            calViewDate.setMonth(calViewDate.getMonth() + 1);
            calViewDate.setDate(1);
            renderCalendarGrid(calViewDate);
            getCalendarWBSCount("month", calViewDate);
            bindCalendarCountsForMonth();
            bindCalendarHolidaysAndLeaves();
        }

        // Added by Gauri - Month Navigation
        function goTodayMonth() {
            calViewDate = new Date();
            calViewDate.setDate(1);
            renderCalendarGrid(calViewDate);
            getCalendarWBSCount("month", calViewDate);
            bindCalendarCountsForMonth();
            bindCalendarHolidaysAndLeaves();
        }

        // ===============================
        // Weekly Mode Support
        // ===============================
        var calMode = "month";      // default month on load
        var calFocusDate = new Date(); // used for week navigation

        function pad2(n) { return String(n).padStart(2, "0"); }

        // Monday week start
        function getWeekStart(d) {
            var x = new Date(d.getFullYear(), d.getMonth(), d.getDate());
            var day = x.getDay(); // Sun=0
            var diff = (day === 0 ? -6 : 1) - day;
            x.setDate(x.getDate() + diff);
            x.setHours(0, 0, 0, 0);
            return x;
        }

        // Added by Gauri - Format: "January 1 - 7, 2025" or "Dec 28 - Jan 3, 2025"
        function fmtRangeLabel(weekStart) {
            var weekEnd = new Date(weekStart);
            weekEnd.setDate(weekStart.getDate() + 6);

            var m1 = weekStart.toLocaleDateString("en-US", { month: "long" });
            var m2 = weekEnd.toLocaleDateString("en-US", { month: "long" });

            if (weekStart.getMonth() !== weekEnd.getMonth()) {
                return `${m1} ${weekStart.getDate()} - ${m2} ${weekEnd.getDate()}, ${weekEnd.getFullYear()}`;
            }
            return `${m1} ${weekStart.getDate()} - ${weekEnd.getDate()}, ${weekEnd.getFullYear()}`;
        }

        function renderWeeklyView() {
            var ws = getWeekStart(calFocusDate);

            // Header shows week range
            $("#lblCalendarMonth").text(fmtRangeLabel(ws));

            var $week = $("#calendarWeek");
            $week.empty();

            var dow = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
            var today = new Date(); today.setHours(0, 0, 0, 0);

            for (var i = 0; i < 7; i++) {
                var dd = new Date(ws);
                dd.setDate(ws.getDate() + i);

                var key = dd.getFullYear() + "-" + pad2(dd.getMonth() + 1) + "-" + pad2(dd.getDate());
                var isToday = (dd.getTime() === today.getTime());

                $week.append(`
                    <div class="week-day ${isToday ? "selected" : ""}" data-date="${key}">
                        <div class="week-day-head">
                        <div class="week-dow">${dow[i]}</div>
                        <div class="week-date">${dd.getDate()}</div>
                        </div>
                        <div class="week-day-body" id="wk_${key.replaceAll('-', '')}"></div>
                    </div>
                    `);
            }

            // Bind same APIs you use for month, but only show chips for these 7 days
            bindCalendarCountsForWeek(ws);
        }

        // Bind calendar counts for the week view
        function bindCalendarCountsForWeek(weekStart) {

            var activityType = getSelectedActivityType();           // same radio selection
            var label = getActivityLabel(activityType);             // Tasks/Issues/Reviews/Milestones/Deliverables
            var actionIcon = getActivityIcon(activityType);

            // weekEnd used only for range calculation
            var weekEnd = new Date(weekStart);
            weekEnd.setDate(weekStart.getDate() + 6);

            // week date keys set (YYYY-MM-DD)
            var weekKeys = {};
            for (var i = 0; i < 7; i++) {
                var d = new Date(weekStart);
                d.setDate(weekStart.getDate() + i);
                var k = d.getFullYear() + "-" + pad2(d.getMonth() + 1) + "-" + pad2(d.getDate());
                weekKeys[k] = true;
            }

            // Helper: last day of month (YYYY-MM-DD) - to match your month function behavior
            function monthEndYYYYMMDD(y, m0) {
                var last = new Date(y, m0 + 1, 0);
                return last.getFullYear() + "-" + pad2(last.getMonth() + 1) + "-" + pad2(last.getDate());
            }

            // Weeks can span 2 months => call GetTaskCount for each involved month
            var monthsToFetch = [];
            var m1 = { y: weekStart.getFullYear(), m: weekStart.getMonth() };
            monthsToFetch.push(m1);

            if (weekStart.getMonth() !== weekEnd.getMonth() || weekStart.getFullYear() !== weekEnd.getFullYear()) {
                monthsToFetch.push({ y: weekEnd.getFullYear(), m: weekEnd.getMonth() });
            }

            // Clear existing week chips
            $("#calendarWeek .week-day-body").empty();

            monthsToFetch.forEach(function (mm) {

                var reqBody = {
                    activityType: activityType,
                    employeeID: defaultEmployeeID,
                    date: monthEndYYYYMMDD(mm.y, mm.m)   // API expects date like month end (same as month logic)
                };

                var result = AJAXCallWithResult(
                    "api/DeveloperDashEnView/GetTaskCount",
                    JSON.stringify(reqBody),
                    false
                );

                if (typeof result === "string") {
                    try { result = JSON.parse(result); } catch (e) { result = null; }
                }

                if (!result || !result.data || !result.data.length) return;

                // result.data rows: { monthDate, count1, count2 } same as month
                result.data.forEach(function (r) {
                    var day = parseInt(r.monthDate, 10);
                    if (!day) return;

                    var c1 = parseInt(r.count1 || 0, 10);
                    var c2 = parseInt(r.count2 || 0, 10);
                    if (c1 <= 0 && c2 <= 0) return;

                    // Build real YYYY-MM-DD for current month fetch (mm)
                    var key = mm.y + "-" + pad2(mm.m + 1) + "-" + pad2(day);

                    // only show chips for current week
                    if (!weekKeys[key]) return;

                    // weekly cell body (NOT monthly grid cell)
                    var $body = $("#wk_" + key.replaceAll("-", ""));
                    if (!$body.length) return;

                    // Commented and Modified by Gauri - Show only one chip with icon and count for week view, instead of separate start/end chips as in month view on 09 Feb 2025
                    if (c1 > 0) {
                        $body.append(`
                        <div class="cal-chip cal-chip-start ${label}Details" data-role="start" data-date="${key}">
                            ${actionIcon} : ${c1}
                        </div>
                        `);
                    }
                    // ${label} Start : ${c1}

                    // if (c2 > 0) {
                    //     $body.append(`
                    //         <div class="cal-chip cal-chip-end ${label}Details" data-role="end" data-date="${key}">
                    //             ${label} End : ${c2}
                    //         </div>
                    //     `);
                    // }
                });
            });
        }

        // Added by Gauri - Toggle Weekly/Monthly
        function setMode(mode) {
            calMode = mode;

            $("#btnViewWeekly").toggleClass("active", mode === "week");
            $("#btnViewMonthly").toggleClass("active", mode === "month");

            $("#calendarWeekWrap").toggleClass("d-none", mode !== "week");
            $("#calendarGrid").toggleClass("d-none", mode !== "month");

            if (mode === "week") {
                renderWeeklyView();
                getCalendarWBSCount("week", calFocusDate);
            } else {
                renderCalendarGrid(calViewDate);
                getCalendarWBSCount("month", calViewDate);
                bindCalendarCountsForMonth();
                bindCalendarHolidaysAndLeaves();
            }
        }

        // Added by Gauri - Prev for both modes
        function goPrev() {
            if (calMode === "week") {
                calFocusDate.setDate(calFocusDate.getDate() - 7);
                renderWeeklyView();
                getCalendarWBSCount("week", calFocusDate);
            } else {
                goPrevMonth();
                getCalendarWBSCount("month", calViewDate);
            }
        }
        // Added by Gauri - Next for both modes
        function goNext() {
            if (calMode === "week") {
                calFocusDate.setDate(calFocusDate.getDate() + 7);
                renderWeeklyView();
                getCalendarWBSCount("week", calFocusDate);
            } else {
                goNextMonth();
                getCalendarWBSCount("month", calViewDate);
            }
        }

        // Added by Gauri - Today for both modes
        function goToday() {
            var now = new Date();
            calFocusDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
            calViewDate = new Date(now.getFullYear(), now.getMonth(), 1);

            if (calMode === "week") {
                renderWeeklyView();
                getCalendarWBSCount("week", calFocusDate);
            } else {
                goTodayMonth();
                getCalendarWBSCount("month", calViewDate);
            }
        }

        // Toggle buttons
        $(document).on("click", "#btnViewWeekly", function () { setMode("week"); });
        $(document).on("click", "#btnViewMonthly", function () { setMode("month"); });

        // optional: highlight selected day in weekly view
        $(document).on("click", "#calendarWeek .week-day", function () {
            $("#calendarWeek .week-day").removeClass("selected");
            $(this).addClass("selected");
        });

        // Added by Gauri - Initialize calendar navigation and buttons
        function initCalendarNav() {
            $('button[data-bs-target="#paneCalendar"], a[data-bs-target="#paneCalendar"]').on('shown.bs.tab', function () {
                setMode("month");  // OR setMode("week") if you want weekly default
            });

            // Buttons
            $(document).on("click", "#btnCalPrev", function () { goPrev(); });
            $(document).on("click", "#btnCalNext", function () { goNext(); });
            $(document).on("click", "#btnCalToday", function () { goToday(); });

            // Optional: click a day cell
            $(document).on("click", "#calendarGrid .calendar-cell", function () {
                var dt = $(this).data("date");  // yyyy-mm-dd
            });
        }

        // Added by Gauri - Render todo list in offcanvas based on selected date and activity type
        function renderTodoList(tasks) {
            var $list = $("#calTodoList");
            $list.empty();

            if (!tasks || tasks.length === 0) {
                $("#calTodoEmpty").show();
                return;
            }
            $("#calTodoEmpty").hide();

            tasks.forEach(function (t) {
                var dt = pickTaskDate(t);
                var dtText = dt ? new Date(dt).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }) : "Unscheduled";

                var html = `
                <a href="javascript:;" class="list-group-item list-group-item-action">
                    <div class="d-flex justify-content-between align-items-start">
                    <div class="me-2">
                        <div class="fw-semibold">${(t.task || "").toString()}</div>
                        <div class="text-muted small">${dtText}</div>
                    </div>
                    <div class="text-muted small text-end">
                        ${(t.plannedWork != null ? "Planned: " + t.plannedWork : "")}
                        ${(t.actualWork != null ? "<br/>Actual: " + t.actualWork : "")}
                    </div>
                    </div>
                </a>
                `;
                $list.append(html);
            });
        }

        // Added by Gauri - Helper to get task date based on your data structure (plannedStart, plannedEnd, etc)
        function getMonthEndUTCISO(viewDate) {
            const y = viewDate.getUTCFullYear();
            const m = viewDate.getUTCMonth();

            // Last day of month in UTC
            const monthEndUTC = new Date(Date.UTC(y, m + 1, 0));

            const yyyy = monthEndUTC.getUTCFullYear();
            const mm = String(monthEndUTC.getUTCMonth() + 1).padStart(2, '0');
            const dd = String(monthEndUTC.getUTCDate()).padStart(2, '0');

            return `${yyyy}-${mm}-${dd}`;
        }

        // Added by Gauri - Helper to get task date based on your data structure (plannedStart, plannedEnd, etc)
        function getSelectedActivityType() {
            if ($("#rdoCalTodo").is(":checked")) return 1;
            if ($("#rdoCalIssues").is(":checked")) return 2;
            if ($("#rdoCalReviews").is(":checked")) return 3;
            if ($("#rdoCalMilestones").is(":checked")) return 4;
            if ($("#rdoCalDeliverables").is(":checked")) return 5;

            // Default fallback
            return 1;
        }

        // Added by Gauri - Helper to get label for activity type
        function getActivityLabel(activityType) {
            switch (parseInt(activityType, 10)) {
                case 1: return "Tasks";
                case 2: return "Issues";
                case 3: return "Reviews";
                case 4: return "Milestones";
                case 5: return "Deliverables";
                default: return "Items";
            }
        }

        function getActivityIcon(activityType) {
            switch (parseInt(activityType, 10)) {
                case 1: return "<i class=\"fas fa-tasks\"></i>";
                case 2: return "<i class=\"fas fa-exclamation-circle\"></i>";
                case 3: return "<i class=\"fas fa-user-friends\"></i>";
                case 4: return "<i class=\"far fa-flag\"></i>";
                case 5: return "<i class=\"fas fa-cube\"></i>";
                default: return "Items";
            }
        }

        // Added by Gauri - Helper to get month end date in YYYY-MM-DD format for API calls
        function getMonthEndYYYYMMDD(viewDate) {
            var y = viewDate.getFullYear();
            var m = String(viewDate.getMonth() + 1).padStart(2, '0');
            var d = String(new Date(viewDate.getFullYear(), viewDate.getMonth() + 1, 0).getDate()).padStart(2, '0');
            return `${y}-${m}-${d}`;
        }

        // Added by Gauri - Bind calendar counts for the month view
        function bindCalendarCountsForMonth() {

            var activityType = getSelectedActivityType();
            var dateISO = getMonthEndYYYYMMDD(calViewDate);

            var reqBody = {
                activityType: activityType,
                employeeID: defaultEmployeeID,
                date: dateISO
            };

            clearCalendarBadges();

            var result = AJAXCallWithResult(
                'api/DeveloperDashEnView/GetTaskCount',
                JSON.stringify(reqBody),
                false
            );

            // Some wrappers return string JSON
            if (typeof result === "string") {
                try { result = JSON.parse(result); } catch (e) { result = null; }
            }

            if (!result || !result.data || result.data.length === 0) return;

            var rows = result.data;
            // applyCountsToCalendar(result.data, activityType);
            if (!rows || rows.length === 0) return;

            var y = calViewDate.getFullYear();
            var m = calViewDate.getMonth(); // 0-11
            var daysInMonth = new Date(y, m + 1, 0).getDate();

            var label = getActivityLabel(activityType);
            var actionIcon = getActivityIcon(activityType);

            rows.forEach(function (r) {
                var day = parseInt(r.monthDate, 10);
                if (!day || day < 1 || day > daysInMonth) return;

                var c1 = parseInt(r.count1 || 0, 10);
                var c2 = parseInt(r.count2 || 0, 10);
                if (c1 <= 0 && c2 <= 0) return;

                var mm = String(m + 1).padStart(2, "0");
                var dd = String(day).padStart(2, "0");
                var key = y + "-" + mm + "-" + dd;

                var $cell = $("#calendarGrid .calendar-cell[data-date='" + key + "']");
                if ($cell.length === 0) return;

                var cellDate = $cell.attr("data-date");

                // If count1 -> Start chip
                if (c1 > 0) {
                    $cell.append(
                        `<div class="cal-chip cal-chip-start ${label}Details" data-role="start" data-date="${cellDate}">${actionIcon} : ${c1}</div>`
                    );
                }

                // If count2 -> End chip
                // if (c2 > 0) {
                //     $cell.append(
                //         `<div class="cal-chip cal-chip-end ${label}Details" data-role="end" data-date="${cellDate}">${actionIcon} : ${c2}</div>`
                //     );
                // }
            });
        }

        // Added by Gauri - Clear existing badges/chips from calendar cells before re-binding
        function bindCalendarHolidaysAndLeaves(week) {

            // ---- 1. Clear existing markers & legend counts ----
            $("#calendarGrid .calendar-cell .lv-dot").remove();
            $("#calendarGrid .calendar-cell .hl-dot").remove();
            $("#calendarWeek .week-day .hl_Weekdot").remove();
            $("#lblHolidayCount").text("");
            $("#lblLeaveCount").text("");

            // Added by Aditya J. on 20-03-2026 for legend color
            $("#calendarGrid .calendar-cell").removeClass("holiday-cell-bg leave-cell-bg");
            $("#calendarWeek .week-day").removeClass("holiday-cell-bg leave-cell-bg");
            // End of Added by Aditya J. on 20-03-2026 for legend color

            var monthStartISO = getMonthStartUTCISO(calViewDate);
            var monthEndISO = getMonthEndUTCISO(calViewDate);


            if (week) {
                monthStartISO = week;
            }
            // ===================================================
            // 2. HOLIDAYS (Summary only)
            // ===================================================
            var holidayReq = {
                date: monthStartISO,
                employeeID: defaultEmployeeID
            };

            var holidayResult = AJAXCallWithResult(
                'api/DeveloperDashEnView/GetHolidaysForOU',
                JSON.stringify(holidayReq),
                false
            );

            if (typeof holidayResult === "string") {
                try { holidayResult = JSON.parse(holidayResult); } catch (e) { }
            }

            //if (holidayResult && holidayResult.data && holidayResult.data.length) {

            //    var y = calViewDate.getFullYear();
            //    var m = calViewDate.getMonth(); // 0-based
            //    var daysInMonth = new Date(y, m + 1, 0).getDate();

            //    holidayResult.data.forEach(function (r) {
            //        var day = parseInt(r.holidays, 10);
            //        if (!day || day < 1 || day > daysInMonth) return;

            //        var mm = String(m + 1).padStart(2, "0");
            //        var dd = String(day).padStart(2, "0");
            //        var key = y + "-" + mm + "-" + dd;

            //        var $cell = $("#calendarGrid .calendar-cell[data-date='" + key + "']");
            //        if (!$cell.length) return;

            //        // Avoid duplicate dot
            //        if ($cell.find(".hl-dot").length === 0) {
            //            $cell.append(`<span class="hl-dot" data-bs-toggle="tooltip" title="Holiday"></span>`);
            //        }
            //    });

            //    $('[data-bs-toggle="tooltip"]').tooltip();
            //    // Optional: show count in legend
            //    $("#lblHolidayCount").text("(" + holidayResult.data.length + ")");
            //} else {
            //    $("#lblHolidayCount").text("(0)");
            //}

            if (holidayResult && holidayResult.data && holidayResult.data.length) {

                var isWeekView = !!week;
                var containerSelector = isWeekView
                    ? "#calendarWeek"
                    : "#calendarGrid";

                holidayResult.data.forEach(function (r) {

                    var key = "";

                    // ✅ Case 1: API returns full HolidayDate
                    if (r.holidayDate) {

                        var dateObj = new Date(r.holidayDate);
                        if (isNaN(dateObj)) return;

                        var y = dateObj.getFullYear();
                        var m = String(dateObj.getMonth() + 1).padStart(2, "0");
                        var d = String(dateObj.getDate()).padStart(2, "0");

                        key = y + "-" + m + "-" + d;
                    }

                    // ✅ Case 2: API returns only day number
                    else if (r.holidays || r.holidayDay) {

                        var day = parseInt(r.holidays || r.holidayDay, 10);
                        if (!day) return;

                        var baseDate = isWeekView ? new Date(week) : calViewDate;

                        var y = baseDate.getFullYear();
                        var m = String(baseDate.getMonth() + 1).padStart(2, "0");
                        var d = String(day).padStart(2, "0");

                        key = y + "-" + m + "-" + d;
                    }

                    if (!key) return;

                    // Added by Aditya J. on 20-03-2026 for legend color
                    var $cell = isWeekView
                        ? $("#calendarWeek .week-day[data-date='" + key + "']")
                        : $("#calendarGrid .calendar-cell[data-date='" + key + "']");
                    if (!$cell.length) return;
                    $cell.addClass("holiday-cell-bg");
                    // End of Added by Aditya J. on 20-03-2026 for legend color

                    // ✅ Avoid duplicate dot
                    if ($cell.find(".hl-dot").length === 0) {

                        if (isWeekView) {
                            // 🔹 Place dot inside week header (correct position)
                            $cell.find(".week-day-head").append(
                                `<span class="hl_Weekdot" data-bs-toggle="tooltip" title="Holiday"></span>`
                            );
                        }
                        else {
                            // 🔹 Month view normal placement
                            $cell.append(
                                `<span class="hl-dot" data-bs-toggle="tooltip" title="Holiday"></span>`
                            );
                        }
                    }
                });

                // Activate Bootstrap tooltips
                $('[data-bs-toggle="tooltip"]').tooltip();

                // Update holiday count
                $("#lblHolidayCount").text("(" + holidayResult.data.length + ")");
            }
            else {
                $("#lblHolidayCount").text("(0)");
            }


            //// ===================================================
            //// 3. LEAVES (Date-wise)
            //// ===================================================
            //var leaveReq = {
            //    employeeID: defaultEmployeeID,
            //    startDate: monthStartISO,
            //    endDate: monthEndISO,
            //    leaveType: "A"
            //};

            //var leaveResult = AJAXCallWithResult(
            //    'api/DeveloperDashEnView/GetEmployeeLeavesForCalendar',
            //    JSON.stringify(leaveReq),
            //    false
            //);

            //if (typeof leaveResult === "string") {
            //    try { leaveResult = JSON.parse(leaveResult); } catch (e) {}
            //}

            //if (!leaveResult || !leaveResult.data || !leaveResult.data.length) {
            //    $("#lblLeaveCount").text("(0)");
            //    return;
            //}

            //var leavesRaw = leaveResult.data[0].leaves || "";
            //var leaveKeys = extractLeaveDateKeys(leavesRaw);

            //$("#lblLeaveCount").text("(" + leaveKeys.length + ")");

            //// ---- paint blue dots on calendar ----
            //leaveKeys.forEach(function (key) {
            //    var $cell = $("#calendarGrid .calendar-cell[data-date='" + key + "']");
            //    if ($cell.length && !$cell.find(".lv-dot").length) {
            //        $cell.append(`<span class="lv-dot" title="Leave"></span>`);
            //    }
            //});


            // ===================================================
            // 3. LEAVES (Date-wise)
            // ===================================================
            var leaveReq = {
                employeeID: defaultEmployeeID,
                startDate: monthStartISO,
                endDate: monthEndISO,
                leaveType: "A"
            };

            var leaveResult = AJAXCallWithResult(
                'api/DeveloperDashEnView/GetEmployeeLeavesForCalendar',
                JSON.stringify(leaveReq),
                false
            );

            // Parse if string
            if (typeof leaveResult === "string") {
                try { leaveResult = JSON.parse(leaveResult); } catch (e) { }
            }

            // No data case
            if (!leaveResult || !leaveResult.data || !leaveResult.data.length) {
                $("#lblLeaveCount").text("(0)");
                return;
            }

            // Extract raw string (example: ",12,15")
            var leavesRaw = leaveResult.data[0].leaves || "";

            // Convert to date keys (YYYY-MM-DD)
            var leaveKeys = [];

            if (leavesRaw) {

                var days = leavesRaw.split(",").filter(function (d) {
                    return d && d !== "0";
                });

                days.forEach(function (day) {

                    var dd = String(parseInt(day, 10)).padStart(2, "0");

                    // Use calViewDate for month reference
                    var baseDate = calViewDate;

                    var yyyy = baseDate.getFullYear();
                    var mm = String(baseDate.getMonth() + 1).padStart(2, "0");

                    var key = yyyy + "-" + mm + "-" + dd;

                    leaveKeys.push(key);
                });
            }

            // Update leave count
            $("#lblLeaveCount").text("(" + leaveKeys.length + ")");

            // Detect view
            var isWeekView = !!week;
            var containerSelector = isWeekView ? "#calendarWeek" : "#calendarGrid";

            // ---- Paint blue leave dots ----
            leaveKeys.forEach(function (key) {

                // Added by Aditya J. on 20-03-2026 for legend color
                var $cell = isWeekView
                    ? $("#calendarWeek .week-day[data-date='" + key + "']")
                    : $("#calendarGrid .calendar-cell[data-date='" + key + "']");
                if (!$cell.length) return;
                $cell.removeClass("holiday-cell-bg").addClass("leave-cell-bg");
                // End of Added by Aditya J. on 20-03-2026 for legend color

                if ($cell.find(".lv-dot").length === 0) {

                    if (isWeekView) {
                        // place in header for week view
                        $cell.css("position", "relative");

                        $cell.append(`
                <span class="lv-dot week-leave-dot"
                      data-bs-toggle="tooltip"
                      title="Leave"></span>
            `);
                    }
                    else {
                        // month view
                        $cell.append(`
                <span class="lv-dot"
                      data-bs-toggle="tooltip"
                      title="Leave"></span>
            `);
                    }
                }
            });

            // Activate tooltip
            $('[data-bs-toggle="tooltip"]').tooltip();

        }

        // Added by Gauri - Helpers to get month start/end in UTC ISO format for API calls, ensuring no timezone shift issues
        function getMonthStartUTCISO(viewDate) {
            var y = viewDate.getFullYear();
            var m = viewDate.getMonth();
            return new Date(Date.UTC(y, m, 1, 0, 0, 0, 0)).toISOString();
        }

        // Added by Gauri - Helpers to get month start/end in UTC ISO format for API calls, ensuring no timezone shift issues
        function getMonthEndUTCISO(viewDate) {
            var y = viewDate.getFullYear();
            var m = viewDate.getMonth();
            return new Date(Date.UTC(y, m + 1, 0, 23, 59, 59, 999)).toISOString();
        }

        function getWeekStartUTCISO(dateObj) {
            // Monday-first week start
            var d = new Date(dateObj.getFullYear(), dateObj.getMonth(), dateObj.getDate());
            var day = d.getDay(); // 0=Sun..6=Sat
            var mondayIndex = (day === 0) ? 6 : (day - 1); // Sun->6, Mon->0, Tue->1...
            d.setDate(d.getDate() - mondayIndex);

            // Convert to UTC ISO (00:00:00Z)
            return new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0, 0)).toISOString();
        }

        // Added by Gauri - Helper to extract date keys from leaves data, handling both JSON array and text formats with optional ranges
        function extractLeaveDateKeys(leavesRaw) {
            if (!leavesRaw) return [];

            // Try JSON array
            try {
                var arr = JSON.parse(leavesRaw);
                if (Array.isArray(arr)) {
                    return arr.map(d => d.slice(0, 10));
                }
            } catch (e) { }

            // Extract all YYYY-MM-DD patterns
            var matches = leavesRaw.match(/\d{4}-\d{2}-\d{2}/g);
            if (!matches) return [];

            // Expand ranges if "to" exists
            if (/to/i.test(leavesRaw) && matches.length >= 2) {
                var expanded = [];
                for (var i = 0; i < matches.length - 1; i += 2) {
                    expanded = expanded.concat(expandRange(matches[i], matches[i + 1]));
                }
                return [...new Set(expanded)];
            }

            return [...new Set(matches)];
        }

        // Added by Gauri - Helper to expand date ranges (e.g. "2024-12-24" to "2024-12-26") into individual date keys
        function expandRange(fromKey, toKey) {
            var out = [];
            var d1 = new Date(fromKey + "T00:00:00");
            var d2 = new Date(toKey + "T00:00:00");

            for (var d = new Date(d1); d <= d2; d.setDate(d.getDate() + 1)) {
                var y = d.getFullYear();
                var m = String(d.getMonth() + 1).padStart(2, "0");
                var day = String(d.getDate()).padStart(2, "0");
                out.push(`${y}-${m}-${day}`);
            }
            return out;
        }

        var selectedCalendarDateISO = null; // will hold ISO datetime for API

        // when user clicks a calendar day cell (recommended)
        $(document).on("click", "#calendarGrid .calendar-cell", function () {
            var key = $(this).attr("data-date"); // YYYY-MM-DD
            if (!key) return;

            // Use UTC-safe ISO for API without timezone shift
            selectedCalendarDateISO = key + "T12:00:00.000Z";
        });

        // Added by Gauri - Helper to get Task details for binding to offcanvas table
        function getCalendarTaskDetailsList(fromDate, toDate) {

            var offcanvasEl = document.getElementById('offcanvasCalendarTaskDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            // Added by Aditya J. on 20-03-2026 for pagination of Task Details
            $('#paginationControlsTaskDetails').hide();
            $('#TotalRecordsTaskDetails').text('0');
            // End of Added by Aditya J. on 20-03-2026 for pagination of Task Details

            $('#TaskDetailsTBody').html(
                '<tr><td colspan="7" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            var param = {
                employeeId: defaultEmployeeID || 0,
                fromDate: fromDate,
                // toDate: toDate
            };

            var url = "api/DeveloperDashEnView/GetTasks";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            var list = [];
            try {
                if (typeof result === 'string') {
                    result = JSON.parse(result);
                }

                if (result && result.d) {
                    result = result.d;
                    if (typeof result === 'string') result = JSON.parse(result);
                }

                if (result && Array.isArray(result.data)) {
                    list = result.data;
                }
                else if (result && typeof result.data === 'string') {
                    var parsed = JSON.parse(result.data);
                    list = Array.isArray(parsed) ? parsed : [parsed];
                }
                else if (Array.isArray(result)) {
                    list = result;
                }
                else if (result && typeof result === 'object') {
                    list = [result];
                }
            } catch (e) {
                console.error("TaskDetails unwrap error:", e, result);
                list = [];
            }

            if (!list.length) {
                // Added by Aditya J. on 20-03-2026 for pagination of Task Details
                $('#TaskDetailsTBody').html(
                    '<tr><td colspan="7" class="text-center text-muted p-3">No tasks found</td></tr>'
                );
                $('#paginationControlsTaskDetails').hide();
                $('#TotalRecordsTaskDetails').text('0');
                // End of Added by Aditya J. on 20-03-2026 for pagination of Task Details
                return;
            }

            // -------------------------------
            // Bind rows
            // -------------------------------
            var html = list.map(function (row) {
                var taskText = (row.task ?? '').toString();
                var projectName = row.projectName || "N/A";
                var taskName = taskText;

                // Split "2150-->Task Name"
                if (taskText.indexOf('-->') > -1) {
                    var parts = taskText.split('-->');
                    projectName = (parts[0] || '').trim();
                    taskName = (parts.slice(1).join('-->') || '').trim();
                }

                return `
                    <tr class="task-details-item">
                        <td>${projectName || '-'}</td>
                        <td>${taskName || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.startDate) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.endDate) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.actualStartDate) || 'N/A'}</td>
                        <td class="text-center">
                            ${row.plannedWork && row.plannedWork != "00:00" ? row.plannedWork : 'N/A'}
                        </td>

                        <td class="text-center">
                            ${row.actualWork && row.actualWork != "00:00" ? row.actualWork : 'N/A'}
                        </td>


                    </tr>
                `;
            }).join('');

            $('#TaskDetailsTBody').html(html);

            // Added by Aditya J. on 20-03-2026 for pagination of Task Details
            initTaskDetailsPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Task Details
        }

        // when user clicks a calendar chip (start/end) - pass the date and role to load details
        $(document).on('click', '.TasksDetails', function () {
            var dateKey = $(this).data('date'); // YYYY-MM-DD
            var role = $(this).data('role');   // "start" | "end"

            var dateISO = dateKey
                ? dateKey + 'T12:00:00.000Z'
                : new Date().toISOString();

            // Use noon UTC to avoid timezone shift
            var fromDate = null;
            var toDate = null;

            if (role === "start") {
                fromDate = dateISO;
            } else if (role === "end") {
                toDate = dateISO;
            }

            getCalendarTaskDetailsList(fromDate, toDate);
        });

        // Added by Gauri - Helper to split task text into project and task name if in "2150-->Task Name" format, otherwise return as is
        function renderTaskDetailsRows(rows) {
            var html = "";

            rows.forEach(function (r) {
                var split = splitTaskText(r.task);

                html += `
                    <tr>
                        <td>${safe(split.projectName)}</td>
                        <td>${safe(split.task)}</td>
                        <td>${formatDateDDMMYYYY(r.startDate)}</td>
                        <td>${formatDateDDMMYYYY(r.endDate)}</td>
                        <td>${formatDateDDMMYYYY(r.actualStart)}</td>
                        <td>${safe(r.plannedWork)}</td>
                        <td>${safe(r.actualWork)}</td>
                    </tr>
                `;
            });

            return html;
        }

        // Added by Gauri - Helper to get Issue details for binding to offcanvas table
        function getCalendarIssueDetailsList(fromDate, toDate) {
            var offcanvasEl = document.getElementById('offcanvasCalendarIssueDetails'); // <-- confirm your offcanvas id
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            // Added by Aditya J. on 20-03-2026 for pagination of Issue Details
            $('#paginationControlsIssueDetails').hide();
            $('#TotalRecordsIssueDetails').text('0');
            // End of Added by Aditya J. on 20-03-2026 for pagination of Issue Details

            $('#IssueDetailsTBody').html(
                '<tr><td colspan="8" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            var param = {
                employeeId: defaultEmployeeID || 0,
                fromDate: fromDate,
                // toDate: toDate,
            };

            var url = "api/DeveloperDashEnView/GetIssues";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Robust unwrap + normalize (same pattern)
            var list = [];
            try {
                if (typeof result === 'string') {
                    result = JSON.parse(result);
                }

                if (result && result.d) {
                    result = result.d;
                    if (typeof result === 'string') result = JSON.parse(result);
                }

                if (result && Array.isArray(result.data)) {
                    list = result.data;
                } else if (result && typeof result.data === 'string') {
                    var parsed = JSON.parse(result.data);
                    list = Array.isArray(parsed) ? parsed : [parsed];
                } else if (Array.isArray(result)) {
                    list = result;
                } else if (result && typeof result === 'object') {
                    list = [result];
                }
            } catch (e) {
                console.error("IssueDetails unwrap error:", e, result);
                list = [];
            }

            if (!list.length) {
                // Added by Aditya J. on 20-03-2026 for pagination of Issue Details
                $('#IssueDetailsTBody').html(
                    '<tr><td colspan="8" class="text-center text-muted p-3">No issues found</td></tr>'
                );
                $('#paginationControlsIssueDetails').hide();
                $('#TotalRecordsIssueDetails').text('0');
                // End of Added by Aditya J. on 20-03-2026 for pagination of Issue Details
                return;
            }

            // Bind rows
            var html = list.map(function (row) {

                // If projectName not present in API, keep '-'
                var projectName = (row.projectName ?? row.project ?? '-').toString();

                var issueID = (row.issueID ?? '').toString();
                var status = (row.issueStatus ?? '—').toString();
                var summary = (row.summary ?? '').toString();

                return `
                    <tr class="issue-details-item">
                        <td>${projectName || '-'}</td>
                        <td>${issueID || 'N/A'}</td>
                        <td>${status == 0 ? 'N/A' : status}</td>
                        <td>${summary || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.startDate) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.endDate) || 'N/A'}</td>
                                                                      <td class="text-center">
                            ${row.plannedWork && row.plannedWork != "00:00" ? row.plannedWork : 'N/A'}
                        </td>

                        <td class="text-center">
                            ${row.actualWork && row.actualWork != "00:00" ? row.actualWork : 'N/A'}
                        </td>


                    </tr>
                `;
            }).join('');

            $('#IssueDetailsTBody').html(html);

            // Added by Aditya J. on 20-03-2026 for pagination of Issue Details
            initIssueDetailsPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Issue Details
        }

        // when user clicks a calendar chip (start/end) - pass the date and role to load details
        $(document).on('click', '.IssuesDetails', function () {
            var dateKey = $(this).data('date'); // YYYY-MM-DD
            var role = $(this).data('role');   // "start" | "end"

            if (!dateKey) return;

            // Safe ISO for API (prevents timezone shift)
            var dateISO = dateKey + "T12:00:00.000Z";

            // Use noon UTC to avoid timezone shift
            var fromDate = null;
            var toDate = null;

            if (role === "start") {
                fromDate = dateISO;
            } else if (role === "end") {
                toDate = dateISO;
            }

            getCalendarIssueDetailsList(fromDate, toDate);
        });

        // Added by Gauri - Helper to get Review details for binding to offcanvas table
        function getCalendarReviewsDetailsList(fromDate, toDate) {
            var offcanvasEl = document.getElementById('offcanvasCalendarReviewsDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            // Added by Aditya J. on 20-03-2026 for pagination of Review Details
            $('#paginationControlsReviewDetails').hide();
            $('#TotalRecordsReviewDetails').text('0');
            // End of Added by Aditya J. on 20-03-2026 for pagination of Review Details

            $('#ReviewsDetailsTBody').html(
                '<tr><td colspan="7" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            var param = {
                employeeId: defaultEmployeeID || 0,
                fromDate: fromDate,
                // toDate: toDate
            };

            var url = "api/DeveloperDashEnView/GetReviews";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Robust unwrap + normalize (same style as your timesheet)
            var list = [];
            try {
                if (typeof result === 'string') result = JSON.parse(result);

                if (result && result.d) {
                    result = result.d;
                    if (typeof result === 'string') result = JSON.parse(result);
                }

                if (result && Array.isArray(result.data)) {
                    list = result.data;
                } else if (result && typeof result.data === 'string') {
                    var parsed = JSON.parse(result.data);
                    list = Array.isArray(parsed) ? parsed : [parsed];
                } else if (Array.isArray(result)) {
                    list = result;
                } else if (result && typeof result === 'object') {
                    list = [result];
                }
            } catch (e) {
                console.error("Reviews unwrap error:", e, result);
                list = [];
            }

            if (!list.length) {
                // Added by Aditya J. on 20-03-2026 for pagination of Review Details
                $('#ReviewsDetailsTBody').html(
                    '<tr><td colspan="7" class="text-center text-muted p-3">No reviews found</td></tr>'
                );
                $('#paginationControlsReviewDetails').hide();
                $('#TotalRecordsReviewDetails').text('0');
                // End of Added by Aditya J. on 20-03-2026 for pagination of Review Details
                return;
            }

            var html = list.map(function (row) {
                var projectName = (row.projectName ?? '').toString();
                var review = (row.review ?? '').toString();
                var type = (row.reviewType ?? '').toString();
                var status = (row.status ?? '—').toString();

                return `
                    <tr class="review-details-item">
                        <td>${projectName || 'N/A'}</td>
                        <td>${review || 'N/A'}</td>
                        <td>${type || 'N/A'}</td>
                        <td>${status == 0 ? 'N/A' : status}</td>
                        <td>${formatDateDDMMMYYYY(row.reviewStart) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.reviewEnd) || 'N/A'}</td>
                        <td>${(row.reviewedBy ?? '').toString() || 'N/A'}</td>
                        <td>${(row.reviewee ?? '').toString() || 'N/A'}</td>
                    </tr>
                `;
            }).join('');

            $('#ReviewsDetailsTBody').html(html);

            // Added by Aditya J. on 20-03-2026 for pagination of Review Details
            initReviewDetailsPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Review Details

            // optional: scroll top every open
            offcanvasEl.scrollTop = 0;
        }

        // when user clicks a calendar chip (start/end) - pass the date and role to load details
        $(document).on('click', '.ReviewsDetails', function () {
            var dateKey = $(this).data('date'); // YYYY-MM-DD
            var role = $(this).data('role');   // "start" | "end"

            if (!dateKey) {
                // fallback (but better to ensure data-date exists)
                dateKey = new Date().toISOString().slice(0, 10);
            }

            // Use noon UTC to avoid timezone shift
            var dateISO = dateKey + "T12:00:00.000Z";
            var fromDate = null;
            var toDate = null;

            if (role === "start") {
                fromDate = dateISO;
            } else if (role === "end") {
                toDate = dateISO;
            }

            getCalendarReviewsDetailsList(fromDate, toDate);
        });

        // Added by Gauri - Helper to get milestone details for binding to offcanvas table based on selected date and role (start/end)
        function getCalendarMilestoneDetailsList(fromDate, toDate) {

            var offcanvasEl = document.getElementById('offcanvasCalendarMilestonesDetails');
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            // Added by Aditya J. on 20-03-2026 for pagination of Milestone Details
            $('#paginationControlsMilestoneDetails').hide();
            $('#TotalRecordsMilestoneDetails').text('0');

            $('#MilestonesDetailsTBody').html(
                '<tr><td colspan="7" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            var param = {
                employeeId: defaultEmployeeID || 0,
                fromDate: fromDate,  // null allowed
                // toDate: toDate       // null allowed
            };

            var url = "api/DeveloperDashEnView/GetDashMilestones";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Robust unwrap + normalize
            var list = [];
            try {
                if (typeof result === 'string') result = JSON.parse(result);

                if (result && result.d) {
                    result = result.d;
                    if (typeof result === 'string') result = JSON.parse(result);
                }

                if (result && Array.isArray(result.data)) {
                    list = result.data;
                } else if (result && typeof result.data === 'string') {
                    var parsed = JSON.parse(result.data);
                    list = Array.isArray(parsed) ? parsed : [parsed];
                } else if (Array.isArray(result)) {
                    list = result;
                } else if (result && typeof result === 'object') {
                    list = [result];
                }
            } catch (e) {
                console.error("Milestones unwrap error:", e, result);
                list = [];
            }

            if (!list.length) {
                // Added by Aditya J. on 20-03-2026 for pagination of Milestone Details
                $('#MilestonesDetailsTBody').html(
                    '<tr><td colspan="7" class="text-center text-muted p-3">No milestones found</td></tr>'
                );
                $('#paginationControlsMilestoneDetails').hide();
                $('#TotalRecordsMilestoneDetails').text('0');
                return;
            }

            // Bind rows to match your table columns
            // Added by Aditya J. on 20-03-2026 for pagination of Milestone Details
            var html = list.map(function (row) {

                var projectName = (row.projectName ?? '-').toString();
                var milestone = (row.milestone ?? '').toString();

                return `
                    <tr class="milestone-details-item">
                        <td>${projectName || 'N/A'}</td>
                        <td>${milestone || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.plannedCompletionDate) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.actualCompletionDate) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.actualStart) || 'N/A'}</td>
                        <td>${row.milestoneStatus == 0
                        ? 'N/A'
                        : (row.milestoneStatus ?? 'N/A')
                    }</td>
                                           <td class="text-center">
                        ${row.actualWork && row.actualWork != "00:00" ? row.actualWork : 'N/A'}
                    </td>

                   </tr>
                `;
            }).join('');

            $('#MilestonesDetailsTBody').html(html);

            // Added by Aditya J. on 20-03-2026 for pagination of Milestone Details
            initMilestoneDetailsPagination();

            // optional: scroll top
            offcanvasEl.scrollTop = 0;
        }

        // when user clicks a calendar chip (start/end) - pass the date and role to load details
        $(document).on('click', '.MilestonesDetails', function () {
            var dateKey = $(this).data('date');  // YYYY-MM-DD
            var role = $(this).data('role');  // start | end
            if (!dateKey) return;

            var dateISO = dateKey + "T12:00:00.000Z";

            var fromDate = null, toDate = null;
            if (role === "start") fromDate = dateISO;
            if (role === "end") toDate = dateISO;

            getCalendarMilestoneDetailsList(fromDate, toDate);
        });

        // Added by Gauri - Helper to get Deliverable details for binding to offcanvas table
        function getCalendarDeliverableDetailsList(fromDate, toDate) {
            var offcanvasEl = document.getElementById('offcanvasCalendarDeliverablesDetails'); // <-- confirm id
            if (!offcanvasEl) return;

            var myOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasEl);
            myOffcanvas.show();

            // Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details
            $('#paginationControlsDeliverableDetails').hide();
            $('#TotalRecordsDeliverableDetails').text('0');
            // End of Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details

            $('#DeliverableDetailsTBody').html(
                '<tr><td colspan="5" class="text-center text-muted p-3">Loading...</td></tr>'
            );

            var param = {
                employeeId: defaultEmployeeID || 0,
                fromDate: fromDate,
                // toDate: toDate
            };

            var url = "api/DeveloperDashEnView/GetDashDeliverables";
            var result = AJAXCallWithResult(url, JSON.stringify(param), false);

            // Robust unwrap + normalize
            var list = [];
            try {
                if (typeof result === 'string') {
                    result = JSON.parse(result);
                }

                if (result && result.d) {
                    result = result.d;
                    if (typeof result === 'string') result = JSON.parse(result);
                }

                if (result && Array.isArray(result.data)) {
                    list = result.data;
                }
                else if (result && typeof result.data === 'string') {
                    var parsed = JSON.parse(result.data);
                    list = Array.isArray(parsed) ? parsed : [parsed];
                }
                else if (Array.isArray(result)) {
                    list = result;
                }
                else if (result && typeof result === 'object') {
                    list = [result];
                }
            } catch (e) {
                console.error("DeliverableDetails unwrap error:", e, result);
                list = [];
            }

            if (!list.length) {
                // Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details
                $('#DeliverableDetailsTBody').html(
                    '<tr><td colspan="5" class="text-center text-muted p-3">No deliverables found</td></tr>'
                );
                $('#paginationControlsDeliverableDetails').hide();
                $('#TotalRecordsDeliverableDetails').text('0');
                // End of Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details
                return;
            }

            // Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details
            var html = list.map(function (row) {
                var deliverable = (row.deliverable ?? '').toString();

                return `
                    <tr class="deliverable-details-item">
                        <td>${row.projectName || 'N/A'}</td>
                        <td>${deliverable || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.startDate) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.endDate) || 'N/A'}</td>
                        <td>${formatDateDDMMMYYYY(row.actualStart) || 'N/A'}</td>
                        <td class="text-center">
                            ${row.actualWork && row.actualWork != "00:00" ? row.actualWork : 'N/A'}
                        </td>
                    </tr>
                `;
            }).join('');

            $('#DeliverableDetailsTBody').html(html);
            initDeliverableDetailsPagination();
            // End of Added by Aditya J. on 20-03-2026 for pagination of Deliverable Details
        }

        // when user clicks a calendar chip (start/end) - pass the date and role to load details
        $(document).on('click', '.DeliverablesDetails', function () {
            var dateKey = $(this).data('date'); // YYYY-MM-DD
            var role = $(this).data('role');   // "start" | "end"

            if (!dateKey) return;

            var dateISO = dateKey + "T12:00:00.000Z";
            // Use noon UTC to avoid timezone shift
            var fromDate = null;
            var toDate = null;

            if (role === "start") {
                fromDate = dateISO;
            } else if (role === "end") {
                toDate = dateISO;
            }

            getCalendarDeliverableDetailsList(fromDate, toDate);
        });

        // Added by Gauri - Re-bind calendar counts when user changes filter or toggles between week/month
        $(document).on("change", "input[name='calendarFilter']", function () {
            if (calMode === "week") {
                var ws = getWeekStart(calFocusDate);
                bindCalendarCountsForWeek(ws);
                getCalendarWBSCount("week", ws);
            } else {
                bindCalendarCountsForMonth();
            }
        });

        // Added by Gauri - Clear calendar badges when switching away from calendar tab to prevent stale data showing if user quickly toggles tabs
        function clearCalendarBadges() {
            $("#calendarGrid .calendar-cell .cal-chip").remove();
            $("#calendarGrid .calendar-cell").removeClass("has-count");
        }

        $(document).on("shown.bs.tab", 'a[data-bs-target="#paneCalendar"], button[data-bs-target="#paneCalendar"]', function () {
            renderCalendarGrid(calViewDate);
            getCalendarWBSCount("month", calViewDate);
            bindCalendarCountsForMonth();
        });


        // Added by Vaibhav K on 20-03-26 - Auto format work hours input (e.g. 1200 -> 12:00)
        $(document).on('input', '#WorkHrsTasksTS', function () {
            var val = $(this).val();

            //alert("calling: ", val)

            // Remove all non-numeric characters except colon
            val = val.replace(/[^0-9:]/g, '');

            // Remove existing colons to reformat
            var digits = val.replace(/:/g, '');

            // Limit to 4 digits max
            if (digits.length > 4) {
                digits = digits.substring(0, 4);
            }

            // Auto-insert colon after 2 digits
            if (digits.length > 2) {
                val = digits.substring(0, 2) + ':' + digits.substring(2);
            } else {
                val = digits;
            }

            $(this).val(val);
        });

        // Added by Vaibhav K on 20-03-26 - On blur, validate and format HH:MM
        $(document).on('blur', '#WorkHrsTasksTS', function () {
            var val = $(this).val().trim();

            if (!val) return; // allow empty

            var digits = val.replace(/:/g, '');

            // Pad to 4 digits if needed (e.g. "9" -> "0900")
            if (digits.length === 1) digits = '0' + digits + '00';
            if (digits.length === 2) digits = digits + '00';
            if (digits.length === 3) digits = '0' + digits;

            var hh = parseInt(digits.substring(0, 2), 10);
            var mm = parseInt(digits.substring(2, 4), 10);

            // Validate minutes
            if (mm >= 60) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%=MyBase.GetResourceString("A_WH")%>');
                $(this).val('').focus();
                return;
            }

            // Format back to HH:MM
            $(this).val(
                String(hh).padStart(2, '0') + ':' + String(mm).padStart(2, '0')
            );
        });

        // Added by Vaibhav K on 20-03-26 - Clear field on focus if showing 00:00
        $(document).on('focus', '#WorkHrsTasksTS', function () {
            if ($(this).val() === '00:00') {
                $(this).val('');
            }
        });
        // End of Added by Vaibhav K on 20-03-26


    </script>
</body>
</html>
