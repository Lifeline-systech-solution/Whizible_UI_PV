<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResourceAllocationView.aspx.vb" Inherits="Whizible.ResourceAllocationView" %>

<!DOCTYPE html>
<%CommonFunctions.General.PlotPageHeadTag("Whizible - Resource Allocation View")%>
<html lang="en" data-theme="light">
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Whizible - Resource Allocation View</title>
    <meta name="description" content="Monitor employee utilization across projects and timeframes">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/v4-shims.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <!-- Added By Madhuri.K On 26-03-2026 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">

    <!-- Page-specific styles -->
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/cxo-pva.css">
    <style>
        .b-over { color: #dc2626; background: #fee2e2; }
        .grid-scroll.rv-grid-scroll {
            overflow-x: auto !important;
            overflow-y: hidden !important;
            max-height: none !important;
        }
        .rv-grid-scroll::-webkit-scrollbar { height: 12px; width: 0; }
        .rv-grid-scroll::-webkit-scrollbar-thumb {
            background: #c5cdd6;
            border-radius: 99px;
            border: 2px solid transparent;
            background-clip: content-box;
        }
        .rv-grid-scroll #rvTable {
            width: max-content;
            min-width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        .rv-grid-scroll #rvTable th:nth-child(n+2),
        .rv-grid-scroll #rvTable td:nth-child(n+2) { min-width: 78px; }
        .rv-grid-scroll #rvTable th:nth-child(1),
        .rv-grid-scroll #rvTable td:nth-child(1) {
            position: sticky;
            left: 0;
            width: 230px;
            min-width: 230px;
            max-width: 230px;
            z-index: 6;
            background: #fff;
            box-shadow: none;
        }
        .rv-grid-scroll #rvTable thead th:nth-child(1) {
            top: 0;
            z-index: 8;
            background: #f8f9fa;
            box-shadow: none;
        }
        .rv-grid-scroll #rvTable tbody tr:hover td:nth-child(1) {
            background: #f8fafc;
        }
        /* Added By Vyankat B. on 25th Aug 2026
           Keep Average bar and Action (View) on a fixed width so Month (one period)
           does not stretch the bar and shift View to the right. */
        .rv-grid-scroll #rvTable th:nth-last-child(2),
        .rv-grid-scroll #rvTable td:nth-last-child(2) {
            width: 110px;
            min-width: 110px;
            max-width: 110px;
        }
        .rv-grid-scroll #rvTable th:last-child,
        .rv-grid-scroll #rvTable td:last-child {
            width: 72px;
            min-width: 72px;
            max-width: 72px;
            white-space: nowrap;
        }
        .rv-grid-scroll #rvTable .pbar {
            width: 100%;
            min-width: 0;
            max-width: 100%;
        }
        .rv-grid-scroll #rvTable th:nth-child(n+2):nth-last-child(n+3),
        .rv-grid-scroll #rvTable td:nth-child(n+2):nth-last-child(n+3) {
            text-align: center;
        }
        /* End of Added By Vyankat B. on 25th Aug 2026 */
        .rv-grid-footer {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 12px;
            position: relative;
            z-index: 1;
            clear: both;
        }
        .rv-alloc-legend {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 16px;
            position: static !important;
            float: none !important;
            width: 100%;
            font-size: 11px;
            color: var(--muted);
        }
        .rv-alloc-legend span {
            display: inline-flex;
            align-items: center;
            white-space: nowrap;
        }
        .rv-alloc-legend i {
            width: 9px;
            height: 9px;
            border-radius: 3px;
            display: inline-block;
            margin-right: 6px;
            flex: none;
        }
        /* Added By Vyankat B. on 24th Aug 2026 - Assigned Tasks pagination */
        .rv-cstm-pagination {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            width: 100%;
            padding: 8px 0 0;
            background: #fff;
            position: static;
        }
        .rv-cstm-pagination .rv-cstm-pagination-inner {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .rv-cstm-pagination .spntotal {
            font-size: 13px;
            color: #333;
            white-space: nowrap;
        }
        .rv-cstm-pagination .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0 !important;
            background: transparent !important;
            --bs-pagination-bg: #fff;
            --bs-pagination-hover-bg: #fff;
            --bs-pagination-focus-bg: #fff;
            --bs-pagination-active-bg: #fff;
            --bs-pagination-disabled-bg: #fff;
        }
        .rv-cstm-pagination .page-link,
        .rv-cstm-pagination .page-link:hover,
        .rv-cstm-pagination .page-link:focus,
        .rv-cstm-pagination .page-link:active {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 32px;
            height: 32px;
            padding: 0 10px;
            background-color: #fff !important;
            border: 1px solid #ddd !important;
            color: #1359a6 !important;
            text-decoration: none;
            cursor: pointer;
            box-shadow: none !important;
        }
        .rv-cstm-pagination .page-item:first-child .page-link {
            border-radius: 4px 0 0 4px;
        }
        .rv-cstm-pagination .page-item:last-child .page-link {
            border-radius: 0 4px 4px 0;
            margin-left: -1px;
        }
        .rv-cstm-pagination .page-item.fa-disabled,
        .rv-cstm-pagination .page-item.fa-disabled .page-link,
        .rv-cstm-pagination .page-item.fa-disabled .page-link:hover,
        .rv-cstm-pagination .page-item.fa-disabled .page-link:focus,
        .rv-cstm-pagination .page-link.disabled,
        .rv-cstm-pagination .page-link.disabled:hover,
        .rv-cstm-pagination .page-link.disabled:focus {
            background-color: #fff !important;
            color: #6c757d !important;
            border-color: #dee2e6 !important;
            opacity: 0.6;
            cursor: not-allowed !important;
            pointer-events: auto !important;
        }
        .rv-cstm-pagination .page-link i {
            font-size: 14px;
        }
        /* Closed off-canvas left box-shadow was visible on the right edge of the page */
        #rvViewCanvas:not(.open),
        #rvEditCanvas:not(.open),
        #rvHistCanvas:not(.open),
        aside.copilot:not(.open) {
            box-shadow: none !important;
        }
        .rv-cstm-pagination .page-link {
            position: relative;
        }
        .rv-cstm-pagination .page-link[title]:hover::after {
            content: attr(title);
            position: absolute;
            left: 50%;
            bottom: calc(100% + 8px);
            transform: translateX(-50%);
            background: #000;
            color: #fff;
            font-size: 12px;
            line-height: 1.2;
            padding: 4px 8px;
            border-radius: 4px;
            white-space: nowrap;
            z-index: 30;
            pointer-events: none;
        }
        .rv-cstm-pagination .page-link[title]:hover::before {
            content: "";
            position: absolute;
            left: 50%;
            bottom: calc(100% + 2px);
            transform: translateX(-50%);
            border: 6px solid transparent;
            border-top-color: #000;
            z-index: 30;
            pointer-events: none;
        }
        #rvEditCanvas .icon-btn[data-tooltip],
        #rvViewCanvas .icon-btn[data-tooltip],
        #rvHistCanvas .icon-btn[data-tooltip] {
            overflow: visible;
        }
        #rvEditCanvas .icon-btn[data-tooltip]:hover::after,
        #rvViewCanvas .icon-btn[data-tooltip]:hover::after,
        #rvHistCanvas .icon-btn[data-tooltip]:hover::after {
            content: attr(data-tooltip);
            position: absolute;
            left: 50%;
            top: calc(100% + 8px);
            transform: translateX(-50%);
            background: #000;
            color: #fff;
            font-size: 12px;
            line-height: 1.2;
            padding: 4px 8px;
            border-radius: 4px;
            white-space: nowrap;
            z-index: 30;
            pointer-events: none;
        }
        #rvEditCanvas .icon-btn[data-tooltip]:hover::before,
        #rvViewCanvas .icon-btn[data-tooltip]:hover::before,
        #rvHistCanvas .icon-btn[data-tooltip]:hover::before {
            content: "";
            position: absolute;
            left: 50%;
            top: calc(100% + 2px);
            transform: translateX(-50%);
            border: 6px solid transparent;
            border-bottom-color: #000;
            z-index: 30;
            pointer-events: none;
        }
        .rv-edit-hd,
        .rv-view-hd,
        .rv-hist-hd {
            overflow: visible;
        }
        body.analytics-pva #allocWidget.widget {
            overflow: visible;
        }
        .rv-grid-footer,
        .rv-hist-ft {
            overflow: visible;
        }
        /* End of Added By Vyankat B. on 24th Aug 2026 */
        body.rv-view-open { overflow: hidden; }
        #rvViewBackdrop {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.38);
            z-index: 400;
        }
        #rvViewBackdrop.open { display: block; }
        #rvViewCanvas {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            width: 86%;
            max-width: 1280px;
            z-index: 401;
            display: flex;
            flex-direction: column;
            background: #fff;
            box-shadow: -12px 0 32px rgba(15, 23, 42, 0.18);
            transform: translateX(100%);
            transition: transform 0.28s ease;
            font-family: inherit;
            font-size: 11.5px;
            color: var(--text);
        }
        #rvViewCanvas.open { transform: translateX(0); }
        aside#rvAlloc.copilot { z-index: 410; }
        #rvEditBackdrop {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.18);
            z-index: 420;
        }
        #rvEditBackdrop.open { display: block; }
        #rvEditCanvas {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            width: 86%;
            max-width: 1280px;
            z-index: 421;
            display: flex;
            flex-direction: column;
            background: #fff;
            box-shadow: -12px 0 32px rgba(15, 23, 42, 0.18);
            transform: translateX(100%);
            transition: transform 0.28s ease;
            font-family: inherit;
            font-size: 11.5px;
            color: var(--text);
        }
        #rvEditCanvas.open { transform: translateX(0); }
        .rv-edit-hd {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 14px 1.25rem;
            background: #F8FAFC;
            border-bottom: 1px solid #ddd;
            flex: none;
        }
        .rv-edit-hd-left {
            display: flex;
            align-items: center;
            gap: 10px;
            min-width: 0;
        }
        .rv-edit-hd h2 {
            margin: 0;
            font-family: inherit;
            font-size: 16px;
            font-weight: 600;
            color: #1359a6;
        }
        .rv-edit-body {
            flex: 1;
            overflow: auto;
            padding: 12px 1.25rem 1.5rem;
            background: #fff;
        }
        .rv-edit-toolbar {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 12px;
        }
        .rv-edit-actions {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
            margin-left: auto;
            justify-content: flex-end;
        }
        .rv-edit-mandatory {
            color: #d0473f;
            font-size: 11.5px;
            font-weight: 500;
            white-space: nowrap;
        }
        .rv-edit-banner {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
            margin-bottom: 12px;
            padding: 10px 14px;
            border-radius: 6px;
            background: #eef4ff;
            font-family: inherit;
            font-size: 11.5px;
        }
        .rv-edit-banner .rv-view-emp-label {
            color: var(--muted);
            font-size: 11.5px;
            font-weight: 500;
        }
        .rv-edit-banner #rvEditProjectName {
            color: var(--text);
            font-size: 11.5px;
            font-weight: 500;
        }
        .rv-edit-card {
            margin-bottom: 12px;
            padding: 0;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            background: #fff;
            overflow: hidden;
        }
        #rvEditCanvas.rv-view-only .rv-edit-card {
            overflow: visible;
        }
        .rv-edit-card h3 {
            margin: 0;
            padding: 8px 12px;
            background: #eef4ff;
            border-bottom: 1px solid #e5e7eb;
            font-family: inherit;
            font-size: 14px;
            font-weight: 500;
            color: #111827;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .rv-edit-card h3 i { color: #1359a6; font-size: 13px; }
        .rv-edit-card-body { padding: 14px 16px 8px; }
        .rv-edit-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px 24px;
            margin-bottom: 8px;
        }
        .rv-edit-field {
            display: flex;
            flex-direction: column;
            min-width: 0;
        }
        .rv-edit-label {
            display: block;
            margin-bottom: 6px;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 400;
            color: var(--text);
        }
        .rv-edit-req { color: #f87171; }
        .rv-edit-control {
            width: 100%;
            max-width: none;
            height: 34px;
            padding: 6px 10px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            font-family: inherit;
            font-size: 11.5px;
            color: var(--text);
        }
        .rv-edit-control[readonly] { background: #f8f9fa; }
        textarea.rv-edit-control {
            height: auto;
            min-height: 72px;
            resize: vertical;
        }
        .rv-edit-control:focus {
            outline: none;
            border-color: #93c5fd;
            box-shadow: 0 0 0 3px rgba(147, 197, 253, 0.1);
        }
        /* Added By Vyankat B. on 25th Aug 2026
           View panel: fields are read-only. Label sits in front of the value. */
        #rvEditCanvas.rv-view-only .rv-edit-mandatory,
        #rvEditCanvas.rv-view-only .rv-edit-req {
            display: none;
        }
        #rvEditCanvas.rv-view-only .rv-edit-field {
            flex-direction: row;
            align-items: center;
            gap: 10px;
        }
        #rvEditCanvas.rv-view-only .rv-edit-field:has(textarea),
        #rvEditCanvas.rv-view-only .rv-edit-field:has(#rvEditResponsibility) {
            align-items: flex-start;
        }
        #rvEditCanvas.rv-view-only .rv-edit-label {
            flex: 0 0 150px;
            margin-bottom: 0;
            color: var(--muted);
            font-size: 11.5px;
            font-weight: 500;
            white-space: nowrap;
        }
        #rvEditCanvas.rv-view-only .rv-edit-label::after {
            content: " :";
        }
        #rvEditCanvas.rv-view-only .rv-edit-control,
        #rvEditCanvas.rv-view-only .rv-edit-control:focus,
        #rvEditCanvas.rv-view-only .rv-edit-control[readonly],
        #rvEditCanvas.rv-view-only .rv-edit-control:disabled {
            flex: 1;
            width: auto;
            min-width: 0;
            height: auto;
            min-height: 0;
            border: none;
            background: transparent;
            box-shadow: none;
            outline: none;
            padding: 0;
            color: var(--text);
            font-weight: 400;
            opacity: 1;
            pointer-events: none;
            -webkit-appearance: none;
            appearance: none;
            resize: none;
        }
        #rvEditCanvas.rv-view-only select.rv-edit-control {
            background-image: none;
        }
        #rvEditCanvas.rv-view-only .rv-edit-cal {
            display: none;
        }
        #rvEditCanvas.rv-view-only .rv-edit-datewrap {
            flex: 1;
            min-width: 0;
        }
        #rvEditCanvas.rv-view-only .rv-edit-datewrap .rv-edit-control {
            border-radius: 0;
        }
        #rvEditCanvas.rv-view-only input[type="date"]::-webkit-calendar-picker-indicator,
        #rvEditCanvas.rv-view-only input[type="date"]::-webkit-inner-spin-button {
            display: none;
            -webkit-appearance: none;
            appearance: none;
            opacity: 0;
            pointer-events: none;
        }
        #rvEditCanvas.rv-view-only .rv-edit-check {
            min-height: 0;
            flex: 1;
        }
        #rvEditCanvas.rv-view-only .rv-edit-check input {
            pointer-events: none;
        }
        /* Added By Vyankat B. on 26th Aug 2026
           Responsibility: show 2 lines only; full text in black tooltip on hover. */
        #rvEditCanvas.rv-view-only .rv-edit-field:has(#rvEditResponsibility) {
            overflow: visible;
        }
        #rvEditCanvas.rv-view-only #rvEditResponsibility.rv-resp-wrap {
            position: relative;
            overflow: visible;
            pointer-events: auto;
            cursor: default;
        }
        #rvEditCanvas.rv-view-only #rvEditResponsibility .rv-resp-text {
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: normal;
            word-break: break-word;
            line-height: 1.4;
            max-height: 2.8em;
        }
        #rvEditCanvas.rv-view-only #rvEditResponsibility[data-tooltip]:hover::after {
            content: attr(data-tooltip);
            position: absolute;
            left: 0;
            bottom: calc(100% + 8px);
            top: auto;
            background: #000;
            color: #fff;
            font-size: 12px;
            line-height: 1.35;
            padding: 6px 8px;
            border-radius: 4px;
            white-space: pre-wrap;
            word-break: break-word;
            max-width: 360px;
            z-index: 40;
            pointer-events: none;
        }
        #rvEditCanvas.rv-view-only #rvEditResponsibility[data-tooltip]:hover::before {
            content: "";
            position: absolute;
            left: 12px;
            bottom: calc(100% + 2px);
            top: auto;
            border: 6px solid transparent;
            border-top-color: #000;
            z-index: 41;
            pointer-events: none;
        }
        /* End of Added By Vyankat B. on 26th Aug 2026 */
        /* End of Added By Vyankat B. on 25th Aug 2026 */
        .rv-edit-datewrap {
            display: flex;
            align-items: stretch;
            position: relative;
        }
        .rv-edit-datewrap .rv-edit-control {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }
        .rv-edit-datewrap input[type="date"]::-webkit-calendar-picker-indicator {
            opacity: 0;
            position: absolute;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        .rv-edit-cal {
            width: 36px;
            flex: none;
            border: 1px solid #d1d5db;
            border-left: 0;
            border-radius: 0 4px 4px 0;
            background: #dbeafe;
            color: #1359a6;
            cursor: pointer;
        }
        .rv-edit-check {
            display: inline-flex;
            align-items: center;
            min-height: 34px;
        }
        .rv-edit-empty {
            padding: 22px 8px;
            text-align: center;
            color: var(--muted);
            font-size: 11.5px;
        }
        #rvEditCanvas .chipbtn {
            font-family: inherit;
            font-size: 11.5px;
            height: 28px;
            min-height: 28px;
            padding: 0 14px;
            line-height: 1;
            border-radius: 4px;
            box-sizing: border-box;
        }
        #rvEditCanvas .chipbtn i {
            font-size: 11px;
            line-height: 1;
        }
        #rvEditCanvas .rv-edit-actions button {
            height: 28px;
            min-height: 28px;
            box-sizing: border-box;
        }
        #rvEditBtnHistory {
            display: none;
        }
        #rvEditBtnHistory.is-visible {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .rv-view-hd {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 18px 1.25rem 14px;
            background: #F8FAFC;
            border-bottom: 1px solid #ddd;
            flex: none;
        }
        .rv-view-hd h2 {
            margin: 0;
            font-family: inherit;
            font-size: 18px;
            font-weight: 600;
            color: #1e40af;
            display: flex;
            align-items: center;
        }
        .rv-view-emp {
            display: flex;
            align-items: center;
            gap: 9px;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 500;
            color: var(--text);
            white-space: nowrap;
        }
        .rv-view-emp-label {
            color: var(--muted);
            font-size: 11.5px;
            font-weight: 500;
        }
        .rv-view-emp #rvViewEmpName {
            font-size: 11.5px;
            font-weight: 500;
            color: var(--text);
        }
        .rv-view-body {
            flex: 1;
            min-height: 0;
            overflow: hidden;
            padding: 16px 1.25rem 1.25rem;
            background: #fff;
            display: flex;
            flex-direction: column;
        }
        #rvViewCanvas #rvViewWidget {
            flex: 1;
            min-height: 0;
            height: auto;
            overflow: hidden;
        }
        #rvViewCanvas #rvViewWidget > .w-body {
            flex: 1;
            min-height: 0;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        .rv-view-toolbar {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 12px;
            flex: none;
        }
        .rv-view-dd { position: relative; }
        .rv-view-dd-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            min-width: 118px;
            height: 34px;
            padding: 6px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #fff;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 500;
            color: var(--text);
            cursor: pointer;
        }
        .rv-view-dd-btn i {
            margin-left: auto;
            font-size: 10px;
            color: #6b7280;
        }
        .rv-view-dd-menu {
            display: none;
            position: absolute;
            top: calc(100% + 4px);
            left: 0;
            min-width: 100%;
            z-index: 20;
            padding: 4px 0;
            background: #fff;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.12);
        }
        .rv-view-dd.open .rv-view-dd-menu { display: block; }
        .rv-view-dd-menu button {
            display: block;
            width: 100%;
            text-align: left;
            padding: 7px 12px;
            border: 0;
            background: transparent;
            color: var(--text);
            font-family: inherit;
            font-size: 11.5px;
            cursor: pointer;
        }
        .rv-view-dd-menu button:hover,
        .rv-view-dd-menu button.active { background: #f3f4f6; color: var(--text); }
        .rv-view-dates {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .rv-view-dates .datebtn { margin: 0; }
        .rv-view-date-nav {
            width: 34px;
            min-width: 34px;
            padding: 0;
            justify-content: center;
        }
        .rv-view-table-wrap {
            flex: 1 1 auto;
            min-height: 0;
            min-width: 0;
            overflow-x: auto !important;
            overflow-y: auto;
            max-height: none;
        }
        .rv-view-table-wrap::-webkit-scrollbar { height: 12px; width: 12px; }
        .rv-view-table-wrap::-webkit-scrollbar-thumb {
            background: #c5cdd6;
            border-radius: 99px;
            border: 2px solid transparent;
            background-clip: content-box;
        }
        .rv-view-table-wrap .tbl {
            width: max-content;
            min-width: 100%;
            table-layout: auto;
            border-collapse: separate;
            border-spacing: 0;
        }
        .rv-view-table-wrap .tbl th,
        .rv-view-table-wrap .tbl td {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .rv-view-table-wrap .tbl col.rv-col-name { width: 240px; min-width: 240px; }
        .rv-view-table-wrap .tbl col.rv-col-date { width: 108px; min-width: 108px; }
        .rv-view-table-wrap .tbl col.rv-col-period { width: 72px; min-width: 72px; }
        .rv-view-table-wrap .tbl col.rv-col-avg { width: 88px; min-width: 88px; }
        .rv-view-table-wrap .tbl col.rv-col-action { width: 72px; min-width: 72px; }
        /* Added By Vyankat B. on 25th Aug 2026
           Action is a plain View link (no icon, no button border). */
        .rv-view-table-wrap .tbl td:last-child a {
            color: #2563eb;
            text-decoration: none;
            background: none;
            border: none;
            box-shadow: none;
            padding: 0;
            display: inline;
        }
        .rv-view-table-wrap .tbl td:last-child a:hover {
            text-decoration: underline;
        }
        /* End of Added By Vyankat B. on 25th Aug 2026 */
        .rv-view-table-wrap .tbl th:nth-child(n+4):nth-last-child(n+3),
        .rv-view-table-wrap .tbl td:nth-child(n+4):nth-last-child(n+3) {
            min-width: 72px;
            width: 72px;
        }
        #rvViewCanvas .rv-grid-footer {
            margin-top: auto;
            flex: none;
        }
        .rv-view-table-wrap thead th {
            position: sticky;
            top: 0;
            z-index: 4;
            background: #f8f9fa;
        }
        #rvViewCanvas tfoot,
        #rvViewCanvas tfoot tr,
        #rvViewCanvas tfoot th,
        #rvViewCanvas tfoot td {
            position: static !important;
            bottom: auto !important;
        }
        body.rv-hist-open { overflow: hidden; }
        #rvHistBackdrop {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.38);
            z-index: 434;
        }
        #rvHistBackdrop.open { display: block; }
        #rvHistCanvas {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            width: 70%;
            max-width: 1040px;
            z-index: 435;
            display: flex;
            flex-direction: column;
            background: #fff;
            box-shadow: -12px 0 32px rgba(15, 23, 42, 0.18);
            transform: translateX(100%);
            transition: transform 0.28s ease;
            font-family: inherit;
            font-size: 11.5px;
            color: var(--text);
        }
        #rvHistCanvas.open { transform: translateX(0); }
        .rv-hist-hd {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 12px 1.25rem;
            background: #F8FAFC;
            border-bottom: 1px solid #ddd;
            flex: none;
        }
        .rv-hist-hd h2 {
            margin: 0;
            font-family: inherit;
            font-size: 16px;
            font-weight: 600;
            color: #1359a6;
        }
        .rv-hist-body {
            flex: 1;
            min-height: 0;
            overflow: auto;
            padding: 16px 1.25rem 18px;
            background: #fff;
        }
        .rv-hist-filters {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 36px;
            flex-wrap: wrap;
            margin-bottom: 16px;
        }
        .rv-hist-filter {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .rv-hist-filter label {
            margin: 0;
            white-space: nowrap;
            font-family: inherit;
            font-size: 11.5px;
            font-weight: 400;
            color: var(--text);
        }
        .rv-hist-filter select {
            min-width: 180px;
            height: 34px;
            padding: 4px 10px;
            border: 1px solid #d1d5db;
            border-radius: 4px;
            background: #fff;
            font-family: inherit;
            font-size: 11.5px;
            color: var(--text);
        }
        .rv-hist-filter select:focus {
            outline: none;
            border-color: #93c5fd;
            box-shadow: 0 0 0 3px rgba(147, 197, 253, 0.1);
        }
        .rv-hist-table-wrap {
            overflow-x: auto;
            border: 1px solid #e5e7eb;
            border-radius: 4px;
        }
        .rv-hist-table {
            width: 100%;
            border-collapse: collapse;
            font-family: inherit;
            font-size: 11.5px;
        }
        .rv-hist-table th,
        .rv-hist-table td {
            padding: 8px 10px;
            border: 1px solid #e5e7eb;
            text-align: left;
            vertical-align: middle;
        }
        .rv-hist-table thead th {
            background: #f8fafc;
            color: #374151;
            font-weight: 600;
            font-size: 11.5px;
        }
        .rv-hist-table td.rv-hist-empty {
            text-align: center;
            color: var(--muted);
            padding: 22px 8px;
        }
        .rv-hist-ft {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 12px;
        }
        @media (max-width: 768px) {
            #rvViewCanvas,
            #rvEditCanvas,
            #rvHistCanvas { width: 96%; max-width: none; }
            .rv-edit-grid { grid-template-columns: 1fr; }
            .rv-edit-mandatory { width: auto; }
            .rv-hist-filters { gap: 12px; }
        }

        /* Added By Vyankat B. on 26th Aug 2026
           Same page-load preloader as DeveloperDashEnView. GIF path is relative to this aspx. */
        body.analytics-pva .loader-overlay {
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
        body.analytics-pva .loader-overlay .loader {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 100px;
            height: 100px;
            margin: -50px 0 0 -50px;
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) no-repeat center center;
        }
        body.analytics-pva .preloader {
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
        /* End of Added By Vyankat B. on 26th Aug 2026 */
        /* Added By Vyankat B. on 26th Aug 2026
           styles.css sets .ga-cals to 238px, so the second month (e.g. July)
           is clipped under the first. Let both months show. */
        body.analytics-pva .ga-cals {
            height: auto !important;
            max-height: none !important;
            overflow: visible !important;
        }
        /* End of Added By Vyankat B. on 26th Aug 2026 */
    </style>

    <!-- ChartJS 1.0.1 -->
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>

    <!-- jQuery, loaded in noConflict mode so it never clobbers app.js's own $ helper.
         Use whizJQ (not $) anywhere on this page that needs real jQuery, e.g. whizJQ.ajax(...) -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <script>
        var whizJQ = jQuery.noConflict(true);
    </script>


</head>
<body data-page="resources" class="analytics-pva">
    <form id="form1" runat="server">
        <span id="crumbPage" hidden>Resource Allocation</span>
        <!-- Added By Vyankat B. on 26th Aug 2026
             Own id so app.js does not hide this GIF before first data load. -->
        <div id="RvPagePreloader" class="preloader" aria-label="Loading"></div>
        <div class="loader-overlay" id="loaderOverlay" style="display: none;">
            <div class="loader"></div>
        </div>
        <!-- End of Added By Vyankat B. on 26th Aug 2026 -->
        <div class="bgwhite" id="AnalyticsWrapper" style="display:none;">
          <div class="page-header-section" style="background:white;">
            <div class="graybg" style="padding:0.4rem 1rem; margin-left:0;">
              <h2 style="color:#1e40af; font-weight:600; font-size:18px; margin:0 0 0.25rem 0; display:flex; align-items:center;">
                <i class="fas fa-th-list" style="color:#1e40af; font-size:1.5rem; margin-right:0.75rem;"></i>
                Resource Allocation View
              </h2>
              <p style="color:#6b7280; margin:0;">Monitor employee utilization across projects and timeframes</p>
            </div>
          </div>

          <div class="app no-sidebar">
            <div class="main">
              <!-- ============ GLOBAL FILTERS ============ -->
              <div class="filterbar" id="filterbar">
                <button class="datebtn" id="dateBtn" type="button">
                  <i class="far fa-calendar-alt"></i>
                  <span id="dateLabel">Current Quarter</span>
                  <small id="dateRangeTxt">Apr 1 – Jun 30, 2026</small>
                  <i class="fas fa-chevron-down" style="font-size:10px;margin-left:4px;"></i>
                </button>
                <span class="compare-tag" id="compareTag" style="display:none">vs previous period</span>
                <span id="chips"></span>
                <button class="chipbtn" type="button" onclick="toast('27 more dimensions available: Program, BU, Practice, Skill, Contract Type, Vendor, Currency…')">
                  <i class="fas fa-plus"></i> More filters
                </button>
                <button class="filter-clear" id="clearFilters" type="button">Reset all</button>
                <span style="flex:1"></span>
                <button class="ghostbtn" type="button" onclick="toast('View saved to My Views')">
                  <i class="far fa-star"></i> Save view
                </button>
                <button class="ghostbtn" type="button" onclick="openCopilot()">
                  <i class="fas fa-magic"></i> Copilot
                </button>
              </div>

              <div class="trail" id="trail">
                <span class="trail-label">Drill trail</span>
                <span class="t-chip" style="cursor:default;color:var(--faint)">Click any KPI or allocation cell to start a cross-module drill-through →</span>
              </div>

              <!-- ============ PAGE ============ -->
              <main>
                <section class="content active" id="page-resources">

                  <!-- ================= LIST VIEW ================= -->
                  <div id="rvList">

                    <div class="page-hd cxo-toolbar">
                      <p>Allocation grid responds to the filters above</p>
                      <div class="hd-actions">
                        <button class="ghostbtn" type="button" onclick="openCopilot('Who is unallocated next month and where can I place them?')"><i class="fas fa-magic"></i> AI staffing</button>
                        <button class="ghostbtn" type="button" onclick="exportMenu(event,'allocWidget')"><i class="fas fa-file-excel"></i> Export to Excel</button>
                      </div>
                    </div>

                    <!-- summary KPIs — clickable, they filter the grid -->
                    <div class="grid kpi-grid" id="rvKpis"></div>

                    <!-- allocation grid -->
                    <div class="mt">
                      <div class="widget" id="allocWidget">
                        <div class="w-hd">
                          <div>
                            <div class="w-title">Employee allocation grid</div>
                            <div class="w-sub" id="rvGridSub">% of capacity allocated per period</div>
                          </div>
                          <div class="w-tools">
                            <button class="w-tool" title="Drill into utilization" type="button" onclick="drill('util')"><i class="fas fa-filter"></i></button>
                            <button class="w-tool" title="Reset filters" type="button" onclick="rvReset()"><i class="fas fa-sync-alt"></i></button>
                            <button class="w-tool" title="Export / share / schedule" type="button" onclick="exportMenu(event,'allocWidget')"><i class="fas fa-download"></i></button>
                            <button class="w-tool" title="Expand to full screen" type="button" onclick="toggleFS('allocWidget')"><i class="fas fa-expand"></i></button>
                          </div>
                        </div>

                        <div class="w-body">
                          <div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;margin-bottom:12px">
                            <span class="hours-quick-label">View</span>
                            <div class="seg" id="rvSeg" role="tablist" aria-label="Allocation granularity" style="margin-bottom:0"></div>
                            <button class="datebtn" type="button" onclick="document.getElementById('dateBtn').click()">
                              <i class="far fa-calendar-alt"></i>
                              <span id="rvPeriod">01-Jan-2026 To 30-Mar-2026</span>
                              <i class="fas fa-chevron-down" style="font-size:10px;margin-left:4px;"></i>
                            </button>
                            <span style="flex:1"></span>
                            <div class="hours-table-tools" style="margin-bottom:0">
                              <input id="rvSearch" type="search" aria-label="Search employees" placeholder="Search employees…" oninput="rvSetSearch(this.value)">
                            </div>
                          </div>

                          <div class="grid-scroll rv-grid-scroll">
                            <table class="tbl" id="rvTable">
                              <thead id="rvHead"></thead>
                              <tbody id="rvBody"></tbody>
                            </table>
                          </div>

                          <div class="rv-grid-footer">
                            <div class="rv-alloc-legend">
                              <span><i style="background:var(--good)"></i>100% — fully allocated</span>
                              <span><i style="background:var(--warn)"></i>1–99% — partially allocated</span>
                              <span><i style="background:var(--risk)"></i>0% — unallocated</span>
                            </div>
                            <!-- Added By Vyankat B. on 24th Aug 2026 -->
                            <div class="cstm_pagination rv-cstm-pagination" id="rvPagerControls" style="display:none;">
                              <div class="rv-cstm-pagination-inner">
                                <span class="spntotal">Total Records:</span>
                                <span class="spntotal" id="rvTotalRecords">0</span>
                                <nav aria-label="Employee list pagination">
                                  <ul class="pagination justify-content-end">
                                    <li class="page-item" id="rvBtnPrevious">
                                      <a class="page-link" href="javascript:void(0)" id="rvLinkPrevious" onclick="rvPrevPage()" aria-label="Previous" title="Previous">
                                        <i class="fas fa-angle-double-left"></i>
                                      </a>
                                    </li>
                                    <li class="page-item" id="rvBtnNext">
                                      <a class="page-link" href="javascript:void(0)" id="rvLinkNext" onclick="rvNextPage()" aria-label="Next" title="Next">
                                        <i class="fas fa-angle-double-right"></i>
                                      </a>
                                    </li>
                                  </ul>
                                </nav>
                              </div>
                            </div>
                            <!-- End of Added By Vyankat B. on 24th Aug 2026 -->
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div id="rvDetail" hidden></div>

                </section>
              </main>
            </div>
          </div>
        </div>

        <div id="rvViewBackdrop" onclick="rvCloseView()"></div>
        <aside id="rvViewCanvas" aria-label="Resource allocation details" aria-hidden="true">
          <div class="rv-view-hd">
            <h2>Resource Allocation View</h2>
            <div class="rv-view-emp">
              <span class="rv-view-emp-label">Employee Name :</span>
              <span id="rvViewEmpName">–</span>
              <button type="button" class="icon-btn" onclick="rvCloseView()" data-tooltip="Close" aria-label="Close">✕</button>
            </div>
          </div>
          <div class="rv-view-body" id="rvViewBody"></div>
        </aside>

        <div id="rvEditBackdrop" onclick="rvCloseEdit()"></div>
        <aside id="rvEditCanvas" class="rv-view-only" aria-label="View resource allocation" aria-hidden="true">
          <div class="rv-edit-hd">
            <div class="rv-edit-hd-left">
              <h2>Resources</h2>
            </div>
            <div class="rv-view-emp">
              <span class="rv-view-emp-label">Resource :</span>
              <span id="rvEditEmpName">–</span>
              <button type="button" class="icon-btn" onclick="rvCloseEdit()" data-tooltip="Close" aria-label="Close">✕</button>
            </div>
          </div>
          <div class="rv-edit-body">
            <div class="rv-edit-toolbar">
              <span class="rv-edit-mandatory">(* Mandatory)</span>
              <div class="rv-edit-actions">
                <!-- Added By Vyankat B. on 25th Aug 2026 - Release and Save removed -->
                <button type="button" id="rvEditBtnHistory" class="chipbtn" onclick="rvOpenHist()"><i class="far fa-clock"></i> Show History</button>
                <!-- End of Added By Vyankat B. on 25th Aug 2026 -->
              </div>
            </div>
            <div class="rv-edit-banner">
              <span class="rv-view-emp">
                <span class="rv-view-emp-label">Project Name :</span>
                <span id="rvEditProjectName">–</span>
              </span>
            </div>

            <section class="rv-edit-card">
              <h3><i class="fas fa-user-tag"></i> Select Role</h3>
              <div class="rv-edit-card-body">
                <div class="rv-edit-grid">
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditRole">Role <span class="rv-edit-req">*</span></label>
                    <select id="rvEditRole" class="rv-edit-control" disabled>
                      <option value="">—</option>
                    </select>
                  </div>
                </div>
              </div>
            </section>

            <section class="rv-edit-card">
              <h3><i class="fas fa-user"></i> Select Resource</h3>
              <div class="rv-edit-card-body">
                <div class="rv-edit-grid">
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditResource">Resource</label>
                    <input id="rvEditResource" class="rv-edit-control" type="text" readonly disabled>
                  </div>
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditPct">% Allocation <span class="rv-edit-req">*</span></label>
                    <input id="rvEditPct" class="rv-edit-control" type="number" min="0" max="100" step="1" readonly disabled>
                  </div>
                </div>
              </div>
            </section>

            <section class="rv-edit-card">
              <h3><i class="far fa-calendar-alt"></i> Choose the Start date and End date</h3>
              <div class="rv-edit-card-body">
                <div class="rv-edit-grid">
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditStart">Start Date <span class="rv-edit-req">*</span></label>
                    <div class="rv-edit-datewrap">
                      <input id="rvEditStart" class="rv-edit-control" type="date" readonly disabled>
                      <button type="button" class="rv-edit-cal" onclick="document.getElementById('rvEditStart').showPicker ? document.getElementById('rvEditStart').showPicker() : document.getElementById('rvEditStart').focus()" title="Select date"><i class="fas fa-calendar-alt"></i></button>
                    </div>
                  </div>
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditEnd">End Date <span class="rv-edit-req">*</span></label>
                    <div class="rv-edit-datewrap">
                      <input id="rvEditEnd" class="rv-edit-control" type="date" readonly disabled>
                      <button type="button" class="rv-edit-cal" onclick="document.getElementById('rvEditEnd').showPicker ? document.getElementById('rvEditEnd').showPicker() : document.getElementById('rvEditEnd').focus()" title="Select date"><i class="fas fa-calendar-alt"></i></button>
                    </div>
                  </div>
                </div>
              </div>
            </section>

            <section class="rv-edit-card">
              <h3><i class="fas fa-clipboard-list"></i> Status and Responsibility of the Resource</h3>
              <div class="rv-edit-card-body">
                <div class="rv-edit-grid">
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditStatus">Status <span class="rv-edit-req">*</span></label>
                    <select id="rvEditStatus" class="rv-edit-control" disabled>
                      <option value="">—</option>
                    </select>
                  </div>
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditBillable">Billable</label>
                    <label class="rv-edit-check"><input id="rvEditBillable" type="checkbox" disabled></label>
                  </div>
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditWorkHm">Work (H:M) <span class="rv-edit-req">*</span></label>
                    <input id="rvEditWorkHm" class="rv-edit-control" type="text" placeholder="00:00" readonly disabled>
                  </div>
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditReportingTo">Reporting To</label>
                    <select id="rvEditReportingTo" class="rv-edit-control" disabled>
                      <option value="">—</option>
                    </select>
                  </div>
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditResponsibility">Responsibility</label>
                    <div id="rvEditResponsibility" class="rv-edit-control rv-resp-wrap"><span class="rv-resp-text">—</span></div>
                  </div>
                  <div class="rv-edit-field">
                    <label class="rv-edit-label" for="rvEditDefaultApprover">Is Default Approver</label>
                    <label class="rv-edit-check"><input id="rvEditDefaultApprover" type="checkbox" disabled></label>
                  </div>
                </div>
              </div>
            </section>

            <section class="rv-edit-card">
              <h3><i class="fas fa-cog"></i> Custom Fields</h3>
              <div class="rv-edit-card-body">
                <div class="rv-edit-empty">No custom fields have been defined</div>
              </div>
            </section>
          </div>
        </aside>

        <div id="rvHistBackdrop" onclick="rvCloseHist()"></div>
        <aside id="rvHistCanvas" aria-label="Allocation history" aria-hidden="true">
          <div class="rv-hist-hd">
            <h2 id="rvHistTitle">History</h2>
            <button type="button" class="icon-btn" onclick="rvCloseHist()" data-tooltip="Close" aria-label="Close">✕</button>
          </div>
          <div class="rv-hist-body">
            <div class="rv-hist-filters">
              <div class="rv-hist-filter">
                <label for="rvHistField">Modified Field :</label>
                <select id="rvHistField">
                  <option value="">Select ModifiedField</option>
                </select>
              </div>
              <div class="rv-hist-filter">
                <label for="rvHistBy">Modified By :</label>
                <select id="rvHistBy">
                  <option value="">Select ModifiedBy</option>
                </select>
              </div>
            </div>
            <div class="rv-hist-table-wrap">
              <table class="rv-hist-table">
                <thead>
                  <tr>
                    <th>Modified Field</th>
                    <th>Modified Date</th>
                    <th>Old Value</th>
                    <th>New Value</th>
                    <th>Modified By</th>
                  </tr>
                </thead>
                <tbody id="rvHistBody">
                  <tr><td colspan="5" class="rv-hist-empty">No data available in table</td></tr>
                </tbody>
              </table>
            </div>
            <div class="rv-hist-ft">
              <!-- Added By Vyankat B. on 24th Aug 2026 -->
              <div class="cstm_pagination rv-cstm-pagination" id="rvHistPagerControls" style="display:none;">
                <div class="rv-cstm-pagination-inner">
                  <span class="spntotal">Total Records:</span>
                  <span class="spntotal" id="rvHistTotalRecords">0</span>
                  <nav aria-label="History pagination">
                    <ul class="pagination justify-content-end">
                      <li class="page-item" id="rvHistBtnPrevious">
                        <a class="page-link" href="javascript:void(0)" id="rvHistLinkPrevious" onclick="rvHistPrevPage()" aria-label="Previous" title="Previous">
                          <i class="fas fa-angle-double-left"></i>
                        </a>
                      </li>
                      <li class="page-item" id="rvHistBtnNext">
                        <a class="page-link" href="javascript:void(0)" id="rvHistLinkNext" onclick="rvHistNextPage()" aria-label="Next" title="Next">
                          <i class="fas fa-angle-double-right"></i>
                        </a>
                      </li>
                    </ul>
                  </nav>
                </div>
              </div>
              <!-- End of Added By Vyankat B. on 24th Aug 2026 -->
            </div>
          </div>
        </aside>

        <!-- ============ ALLOCATE OFFCANVAS (reuses .copilot panel styling) ============ -->
        <aside class="copilot" id="rvAlloc" aria-label="Allocate on project" aria-hidden="true">
          <div class="cp-hd">
            <div class="avatar" id="rvAllocAv">–</div>
            <div style="flex:1">
              <b style="font-size:13.5px" id="rvAllocName">Allocate on project</b>
              <div style="font-size:11px;color:var(--muted)" id="rvAllocRole">–</div>
            </div>
            <button type="button" class="icon-btn" onclick="rvCloseAlloc()" title="Close" aria-label="Close panel">✕</button>
          </div>
          <div class="cp-log" id="rvAllocBody"></div>
          <div class="cp-in">
            <button type="button" class="ghostbtn" style="flex:1;justify-content:center" onclick="rvCloseAlloc()">Cancel</button>
            <button type="button" onclick="rvSaveAlloc()">Save allocation</button>
          </div>
        </aside>

        <!-- ============ DRILL MODAL ============ -->
        <div class="overlay" id="overlay">
          <div class="modal" role="dialog" aria-modal="true">
            <div class="m-hd">
              <div style="flex:1">
                <h3 id="mTitle">Drill-down</h3>
                <div class="m-crumbs" id="mCrumbs"></div>
              </div>
              <button class="icon-btn" onclick="exportDrillMenu(event)" title="Export this view">⤓</button>
              <button class="icon-btn" onclick="closeModal()" title="Close">✕</button>
            </div>
            <div class="m-body" id="mBody"></div>
          </div>
        </div>

        <!-- ============ AI COPILOT ============ -->
        <aside class="copilot" id="copilot" aria-label="AI Copilot">
          <div class="cp-hd">
            <div class="logo-mark">✦</div>
            <div style="flex:1"><b style="font-size:13.5px">Whizible Copilot</b><div style="font-size:11px;color:var(--muted)">Grounded in your filtered data · Fable-5 class model</div></div>
            <button class="icon-btn" onclick="document.getElementById('copilot').classList.remove('open')">✕</button>
          </div>
          <div class="cp-log" id="cpLog"></div>
          <div class="cp-quick">
            <button onclick="askCopilot('Who is unallocated this quarter?')">Unallocated this quarter</button>
            <button onclick="askCopilot('Where is my bench and what should I do with it?')">Bench strategy</button>
            <button onclick="askCopilot('Show projects at risk in the Banking portfolio')">At-risk in Banking</button>
            <button onclick="askCopilot('Forecast revenue for next quarter')">Revenue forecast</button>
          </div>
          <div class="whatif">
            <h4>Scenario planner · What-if</h4>
            <div class="wi-row">Add hires <input type="range" id="wiHires" min="0" max="25" value="0"><b id="wiHiresV">0</b></div>
            <div class="wi-row">Bill-rate change <input type="range" id="wiRate" min="-10" max="15" value="0"><b id="wiRateV">0%</b></div>
            <div class="wi-out">
              <div><b id="wiUtil">—</b><span>Utilization</span></div>
              <div><b id="wiRev">—</b><span>Qtr revenue</span></div>
              <div><b id="wiMargin">—</b><span>Margin</span></div>
            </div>
          </div>
          <div class="cp-in">
            <input id="cpInput" placeholder="Ask in natural language…">
            <button onclick="sendCopilot()">Send</button>
          </div>
        </aside>

        <div class="toasts" id="toasts"></div>

        <!-- capture the static shell before app.js boots (see glue at the bottom) -->
        <script>const RV_MARKUP = document.getElementById("page-resources").innerHTML;</script>
        <script src="js/app.js"></script>
        <script src="js/search-select.js"></script>

        <script>
            /* =====================================================================
               RESOURCE ALLOCATION — page controller
               Reuses PROJECTS / toast() / drill() / exportMenu() / toggleFS() from
               js/app.js, and every class from css/styles.css. No new CSS.
            ===================================================================== */

            /* ---------- data: filled by GetResourceAllocationDashboard ---------- */
            var RV_EMP = [];
            var rvSummary = {
                totalEmployees: 0,
                fullyAllocated: 0,
                fullyAllocatedPct: 0,
                partiallyAllocated: 0,
                partiallyAllocatedPct: 0,
                unallocated: 0,
                unallocatedPct: 0
            };

            const RV_MONTHS = ["Apr 2026", "May 2026", "Jun 2026"];
            const rvState = { gran: "", financialPeriod: "", periodCols: [], q: "", status: "all", page: 1, per: 10, totalEmployees: 0, totalPages: 1, sortKey: "none", sortDir: 1, allocId: null, viewId: null, detailPeriod: "", detailPeriodOffset: 0, detailFrom: null, detailTo: null, detailPage: 1, detailPer: 5, detailTotal: 0, detailPages: 1, detailEmp: null, editAllocIdx: null, editPerId: null, editRow: null, release: null, histPage: 1, histPer: 10, histTotal: 0, histPages: 1 };
            var rvFinancialTypes = [];

            /* ---------- derived helpers ---------- */
            const rvTotals = e => {
                if (e && e.percentages && e.percentages.length) {
                    return e.percentages.map(v => Number(v) || 0);
                }
                if (!e || !e.alloc || !e.alloc.length) return [];
                const n = e.alloc[0].m ? e.alloc[0].m.length : 0;
                return Array.from({ length: n }, (_, i) => e.alloc.reduce((s, a) => s + (a.m[i] || 0), 0));
            };
            const rvAvg = e => {
                const t = rvTotals(e);
                if (!t.length) return 0;
                return t.reduce((a, b) => a + b, 0) / t.length;
            };
            const rvStat = e => { const a = rvAvg(e); return a >= 100 ? "full" : a > 0 ? "partial" : "none"; };
            const rvCls = v => v > 100 ? "b-over" : v >= 90 ? "b-good" : v > 0 ? "b-warn" : "b-risk";
            const rvColor = v => v > 100 ? "var(--risk)" : v >= 90 ? "var(--good)" : v > 0 ? "var(--warn)" : "var(--risk)";
            const rvFmtPct = v => {
                const n = Number(v) || 0;
                return n === 0 ? "0" : n.toFixed(2);
            };
            const rvProj = pid => (typeof PROJECTS !== "undefined" && PROJECTS.find(p => p.id === pid)) || { id: pid, name: pid, customer: "—" };
            const rvEsc = s => String(s).replace(/[&<>"]/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
            const rvInit = n => n.split(/\s+/).filter(Boolean).map(w => w[0]).slice(0, 2).join("").toUpperCase();

            /* granularity → column labels + derived series */
            const RV_GRAN = {
                quarter: { cols: RV_MONTHS, period: "Apr – Jun 2026" },
                month: { cols: ["Wk 1", "Wk 2", "Wk 3", "Wk 4", "Wk 5"], period: "Jun 2026" },
                week: { cols: ["Mon", "Tue", "Wed", "Thu", "Fri"], period: "Jun 22 – 26, 2026" },
                day: { cols: ["Jun 30"], period: "Jun 30, 2026" }
            };
            function rvDateRange() {
                const s = (typeof state !== "undefined" && state.date && state.date.s instanceof Date) ? state.date.s : null;
                const e = (typeof state !== "undefined" && state.date && state.date.e instanceof Date) ? state.date.e : null;
                return (s && e) ? [s, e] : null;
            }
            function rvFormatPeriodLabel(s, e) {
                if (!s || !e) return "—";
                if (typeof rvFmtDashDate === "function") {
                    return rvFmtDashDate(s) + " To " + rvFmtDashDate(e);
                }
                return s.toLocaleDateString("en-GB", { day: "2-digit", month: "short", year: "numeric" }).replace(/ /g, "-")
                    + " To "
                    + e.toLocaleDateString("en-GB", { day: "2-digit", month: "short", year: "numeric" }).replace(/ /g, "-");
            }
            function rvMonthCols(s, e) {
                const cols = [];
                const d = new Date(s.getFullYear(), s.getMonth(), 1);
                const last = new Date(e.getFullYear(), e.getMonth(), 1);
                while (d <= last && cols.length < 12) {
                    cols.push(d.toLocaleDateString("en-US", { month: "short", year: "numeric" }));
                    d.setMonth(d.getMonth() + 1);
                }
                return cols;
            }
            function rvSyncGranFromState() {
                const gran = RV_GRAN[rvState.gran] ? rvState.gran : "quarter";
                const range = rvDateRange();
                if (!range) return RV_GRAN[gran].period;
                const [s, e] = range;
                const period = rvFormatPeriodLabel(s, e);
                if (rvState.periodCols && rvState.periodCols.length) {
                    RV_MONTHS.length = 0;
                    rvState.periodCols.forEach(m => RV_MONTHS.push(m));
                    RV_GRAN[gran].cols = RV_MONTHS;
                } else {
                    const months = rvMonthCols(s, e);
                    if (months.length) {
                        RV_MONTHS.length = 0;
                        months.forEach(m => RV_MONTHS.push(m));
                    }
                }
                RV_GRAN.quarter.period = period;
                RV_GRAN.month.period = period;
                RV_GRAN.week.period = period;
                RV_GRAN.day.period = period;
                return period;
            }
            function rvCurrentPeriod() {
                return rvSyncGranFromState();
            }
            function rvGranFromCode(code) {
                const c = String(code || "").toUpperCase();
                if (c === "Q") return "quarter";
                if (c === "M") return "month";
                if (c === "W") return "week";
                if (c === "D") return "day";
                return "";
            }
            function rvCodeFromGran(gran) {
                if (gran === "quarter") return "Q";
                if (gran === "month") return "M";
                if (gran === "week") return "W";
                if (gran === "day") return "D";
                return rvState.financialPeriod || "";
            }
            function rvOrderOneFinancialType() {
                if (!rvFinancialTypes || !rvFinancialTypes.length) return null;
                var ordered = rvFinancialTypes.slice().sort(function (a, b) { return a.orderBy - b.orderBy; });
                var first = ordered[0];
                for (var i = 0; i < ordered.length; i++) {
                    if (Number(ordered[i].orderBy) === 1) {
                        first = ordered[i];
                        break;
                    }
                }
                return first || null;
            }
            function rvRenderGranButtons() {
                const box = document.getElementById("rvSeg");
                if (!box) return;
                if (!rvFinancialTypes.length) return;
                box.innerHTML = rvFinancialTypes.map(t => {
                    const gran = rvGranFromCode(t.code);
                    if (!gran) return "";
                    const on = rvState.gran === gran;
                    return `<button class="seg-btn${on ? " active" : ""}" type="button" role="tab" data-gran="${gran}" data-code="${rvEsc(t.code)}" aria-selected="${on}" onclick="rvSetGran('${gran}')">${rvEsc(t.financialType)}</button>`;
                }).join("");
            }
            function rvSeries(e) {
                const gran = RV_GRAN[rvState.gran] ? rvState.gran : "month";
                const cols = (RV_GRAN[gran] && RV_GRAN[gran].cols) ? RV_GRAN[gran].cols : RV_MONTHS;
                const t = rvTotals(e);
                return cols.map((_, i) => t[i] != null ? t[i] : 0);
            }

            /* ---------- filtering / sorting ---------- */
            function rvFiltered() {
                const rows = RV_EMP.filter(e => {
                    const okS = rvState.status === "all" || rvStat(e) === rvState.status;
                    return okS;
                });
                if (rvState.sortKey === "name") rows.sort((a, b) => a.name.localeCompare(b.name) * rvState.sortDir);
                if (rvState.sortKey === "avg") rows.sort((a, b) => (rvAvg(a) - rvAvg(b)) * rvState.sortDir);
                return rows;
            }

            /* ---------- KPI cards ---------- */
            function rvFmtSummaryPct(v) {
                const n = Number(v) || 0;
                if (n === 0) return "0%";
                return (Math.round(n * 100) / 100) + "%";
            }
            function rvRenderKpis() {
                const box = document.getElementById("rvKpis"); if (!box) return;
                const card = (label, badge, val, pctTxt, delta, status, ai) => `
            <div class="kpi" role="button" tabindex="0" title="Click to filter the grid"
                 onclick="rvSetStatus('${status}')" onkeydown="if(event.key==='Enter')rvSetStatus('${status}')"
                 ${rvState.status === status ? 'style="box-shadow:inset 0 0 0 1px var(--accent)"' : ""}>
              <div class="kpi-top"><span class="kpi-label">${label}</span>${badge}</div>
              <div class="kpi-val">${val}</div>
              <div><span class="kpi-delta ${delta}">${pctTxt}</span><span class="kpi-vs">${status === "all" ? rvCurrentPeriod() : "of all employees"}</span></div>
              ${ai ? `<div class="kpi-ai"><span class="sp">✦</span><span>${ai}</span></div>` : ""}
            </div>`;
                box.innerHTML =
                    card("Total Employees", rvState.status === "all" ? '<span class="badge b-info">All</span>' : "", rvSummary.totalEmployees, "In scope", "flat", "all", "") +
                    card("Fully Allocated", '<span class="badge b-good">100%</span>', rvSummary.fullyAllocated, rvFmtSummaryPct(rvSummary.fullyAllocatedPct), "up", "full", "") +
                    card("Partially Allocated", '<span class="badge b-warn">1–99%</span>', rvSummary.partiallyAllocated, rvFmtSummaryPct(rvSummary.partiallyAllocatedPct), "flat", "partial", "") +
                    card("Unallocated", '<span class="badge b-risk">0%</span>', rvSummary.unallocated, rvFmtSummaryPct(rvSummary.unallocatedPct), "down", "none", "");
            }

            /* ---------- allocation grid ---------- */
            function rvRenderTable() {
                rvSyncGranFromState();
                const gran = RV_GRAN[rvState.gran] ? rvState.gran : "month";
                const cols = (rvState.periodCols && rvState.periodCols.length) ? rvState.periodCols : RV_GRAN[gran].cols;
                const rows = rvFiltered();
                const total = (typeof rvState.totalEmployees === "number" && rvState.totalEmployees > 0)
                    ? rvState.totalEmployees
                    : rows.length;
                const pages = Math.max(1, (typeof rvState.totalPages === "number" && rvState.totalPages > 0)
                    ? rvState.totalPages
                    : Math.ceil(total / rvState.per));
                if (rvState.page > pages) rvState.page = pages;
                const start = total ? ((rvState.page - 1) * rvState.per) : 0;
                const slice = rows;

                document.getElementById("rvHead").innerHTML = `<tr>
            <th scope="col">Employee Name</th>
            ${cols.map(c => `<th scope="col">${rvEsc(c)}</th>`).join("")}
            <th scope="col">Average</th>
            <th scope="col">Action</th></tr>`;

                document.getElementById("rvBody").innerHTML = slice.length ? slice.map(e => {
                    const s = rvSeries(e), avg = s.length ? (s.reduce((a, b) => a + b, 0) / s.length) : 0;
                    return `<tr>
              <td><span style="display:flex;align-items:center;gap:9px"><span class="avatar">${rvInit(e.name)}</span>${rvEsc(e.name)}</span></td>
              ${s.map(v => `<td><span class="badge ${rvCls(v)} num">${rvFmtPct(v)}</span></td>`).join("")}
              <td><span class="num ${avg > 100 ? "b-over" : ""}">${rvFmtPct(avg)}</span><div class="pbar" style="margin-top:5px"><i style="width:${Math.min(100, avg)}%;background:${rvColor(avg)}"></i></div></td>
              <td><a href="javascript:void(0)" onclick="rvOpenView('${e.id}', event)">View</a></td>
            </tr>`;
                }).join("") : `<tr><td colspan="${cols.length + 3}" style="text-align:center;color:var(--muted);padding:26px">No employees match this filter.</td></tr>`;

                rvApplyPagerState("rvPagerControls", "rvTotalRecords", "rvBtnPrevious", "rvLinkPrevious", "rvBtnNext", "rvLinkNext", rvState.page, pages, total);

                const periodLabel = rvCurrentPeriod();
                const rvPeriodEl = document.getElementById("rvPeriod");
                if (rvPeriodEl) rvPeriodEl.textContent = periodLabel;
                document.getElementById("rvGridSub").textContent =
                    `% of capacity allocated per ${rvState.gran} · ${periodLabel}` +
                    (rvState.status !== "all" ? ` · filtered: ${({ full: "fully allocated", partial: "partially allocated", none: "unallocated" })[rvState.status]}` : "");

                rvRenderGranButtons();
                document.querySelectorAll("#rvSeg .seg-btn").forEach(b => {
                    const on = b.dataset.gran === rvState.gran;
                    b.classList.toggle("active", on); b.setAttribute("aria-selected", on);
                });
                const box = document.getElementById("rvSearch");
                if (box && box.value !== rvState.q) box.value = rvState.q;
            }

            function rvFmtDashDate(value) {
                let d = value instanceof Date ? value : null;
                if (!d && typeof parseApiDate === "function") d = parseApiDate(value);
                if (!d && value) {
                    const parsed = new Date(value);
                    if (!isNaN(parsed.getTime())) d = parsed;
                }
                if (!d) return "—";
                const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                const dd = String(d.getDate()).padStart(2, "0");
                return dd + "-" + months[d.getMonth()] + "-" + d.getFullYear();
            }
            function rvQuarterIndex(d) {
                return d.getFullYear() * 4 + Math.floor(d.getMonth() / 3);
            }
            function rvPeriodOffsetFromDate(fromDate, code) {
                if (!(fromDate instanceof Date) || isNaN(fromDate.getTime())) return 0;
                const now = new Date();
                const c = String(code || "M").toUpperCase();
                if (c === "Q") {
                    return rvQuarterIndex(fromDate) - rvQuarterIndex(now);
                }
                if (c === "M" || c === "D" || c === "W") {
                    return (fromDate.getFullYear() - now.getFullYear()) * 12 + (fromDate.getMonth() - now.getMonth());
                }
                if (c === "Y") {
                    return fromDate.getFullYear() - now.getFullYear();
                }
                return 0;
            }
            function rvFmtMdY(value) {
                let d = value instanceof Date ? value : null;
                if (!d && typeof parseApiDate === "function") d = parseApiDate(value);
                if (!d && value) {
                    const parsed = new Date(value);
                    if (!isNaN(parsed.getTime())) d = parsed;
                }
                if (!d) return "—";
                const mm = String(d.getMonth() + 1).padStart(2, "0");
                const dd = String(d.getDate()).padStart(2, "0");
                return mm + "/" + dd + "/" + d.getFullYear();
            }
            function rvViewDateLabel() {
                const from = rvState.detailFrom;
                const to = rvState.detailTo;
                if (from && to) {
                    return rvFmtDashDate(from) + " To " + rvFmtDashDate(to);
                }
                const range = (typeof rvDateRange === "function") ? rvDateRange() : null;
                if (!range || !range[0] || !range[1]) return "—";
                return rvFmtDashDate(range[0]) + " To " + rvFmtDashDate(range[1]);
            }
            function rvViewPctCell(v, withBar) {
                const n = Number(v) || 0;
                const cls = n > 100 ? "over" : n > 0 ? "good" : "";
                const txt = n === 0 ? "0" : (withBar ? (n.toFixed(n % 1 ? 2 : 0) + " %") : n.toFixed(2));
                const bar = withBar && n > 0
                    ? `<div class="rv-view-pbar"><i style="width:${Math.min(100, n)}%;background:${n > 100 ? "var(--risk)" : "var(--good)"}"></i></div>`
                    : "";
                return `<td class="rv-view-pct"><span class="num ${cls}">${txt}</span>${bar}</td>`;
            }
            function rvShowViewCanvas() {
                const canvas = document.getElementById("rvViewCanvas");
                const backdrop = document.getElementById("rvViewBackdrop");
                if (canvas) {
                    canvas.classList.add("open");
                    canvas.setAttribute("aria-hidden", "false");
                }
                if (backdrop) backdrop.classList.add("open");
                document.body.classList.add("rv-view-open");
                if (typeof rvCloseAlloc === "function") rvCloseAlloc();
                const copilot = document.getElementById("copilot");
                if (copilot) copilot.classList.remove("open");
            }
            function rvSetViewEmp(name) {
                const nameEl = document.getElementById("rvViewEmpName");
                if (nameEl) nameEl.textContent = name || "Employee";
            }
            function rvOpenView(id, ev) {
                if (ev && typeof ev.preventDefault === "function") {
                    ev.preventDefault();
                    ev.stopPropagation();
                }
                rvState.viewId = String(id || "");
                rvState.detailPage = 1;
                rvState.detailPeriod = rvState.financialPeriod || rvState.detailPeriod || "";
                const range = (typeof rvDateRange === "function") ? rvDateRange() : null;
                if (range) {
                    rvState.detailFrom = range[0];
                    rvState.detailTo = range[1];
                    rvState.detailPeriodOffset = rvPeriodOffsetFromDate(range[0], rvState.detailPeriod);
                } else {
                    rvState.detailPeriodOffset = (typeof rvState.periodOffset === "number") ? rvState.periodOffset : 0;
                }
                const gridEmp = RV_EMP.find(x => String(x.id) === String(id));
                rvSetViewEmp(gridEmp ? gridEmp.name : "Employee");
                const body = document.getElementById("rvViewBody");
                if (body) body.innerHTML = `<div class="widget"><div class="w-body"><p class="m-note" style="padding:18px">Loading allocation details…</p></div></div>`;
                rvShowViewCanvas();
                if (typeof GetFinancialType === "function" && (!rvFinancialTypes || !rvFinancialTypes.length)) {
                    GetFinancialType();
                }
                // Use the main grid From/To dates. Do not call GetViewFromAndToDates here —
                // that API shifts Month by quarter and was adding Feb/Mar.
                if (typeof GetResourceAllocationDetails === "function") {
                    GetResourceAllocationDetails(id);
                } else {
                    rvRenderDetail(id);
                }
            }
            function rvCloseView() {
                if (typeof rvCloseEdit === "function") rvCloseEdit();
                const canvas = document.getElementById("rvViewCanvas");
                const backdrop = document.getElementById("rvViewBackdrop");
                if (canvas) {
                    canvas.classList.remove("open");
                    canvas.setAttribute("aria-hidden", "true");
                }
                if (backdrop) backdrop.classList.remove("open");
                document.body.classList.remove("rv-view-open");
                rvState.viewId = null;
            }
            function rvToggleViewGran(ev) {
                if (ev && typeof ev.preventDefault === "function") {
                    ev.preventDefault();
                    ev.stopPropagation();
                }
                const dd = document.getElementById("rvViewGranDd");
                if (dd) dd.classList.toggle("open");
            }
            function rvCloseViewGran() {
                const dd = document.getElementById("rvViewGranDd");
                if (dd) dd.classList.remove("open");
            }
            function rvSetViewGran(code) {
                rvCloseViewGran();
                rvState.detailPeriod = String(code || "").toUpperCase();
                rvState.detailPeriodOffset = 0;
                rvState.detailPage = 1;
                if (typeof GetFinancialType === "function" && (!rvFinancialTypes || !rvFinancialTypes.length)) {
                    GetFinancialType();
                }
                if (typeof GetViewFromAndToDates === "function") {
                    GetViewFromAndToDates();
                } else if (rvState.viewId && typeof GetResourceAllocationDetails === "function") {
                    GetResourceAllocationDetails(rvState.viewId);
                }
            }
            function rvShiftViewDate(delta) {
                rvState.detailPeriodOffset = (rvState.detailPeriodOffset || 0) + (Number(delta) || 0);
                rvState.detailPage = 1;
                if (typeof GetViewFromAndToDates === "function") {
                    GetViewFromAndToDates();
                }
            }

            /* ---------- detail view (off-canvas) ---------- */
            function rvRenderDetail(emp, cols) {
                const body = document.getElementById("rvViewBody");
                if (!body) return;
                rvShowViewCanvas();

                if (!emp || typeof emp !== "object") {
                    const found = RV_EMP.find(x => x.id === String(emp));
                    emp = found || null;
                }
                if (!emp) {
                    body.innerHTML = `<div class="widget"><div class="w-body"><p class="m-note" style="padding:18px">No allocation details were returned for this employee.</p></div></div>`;
                    return;
                }

                rvSetViewEmp(emp.name || "Employee");
                rvState.detailEmp = emp;

                const periodCols = (cols && cols.length) ? cols : ((rvState.periodCols && rvState.periodCols.length) ? rvState.periodCols : RV_MONTHS);
                const t = (emp.percentages && emp.percentages.length) ? emp.percentages : rvTotals(emp);
                const totAvg = t.length ? (t.reduce((a, b) => a + b, 0) / t.length) : 0;
                const detailTotal = (typeof rvState.detailTotal === "number" && rvState.detailTotal > 0)
                    ? rvState.detailTotal
                    : emp.alloc.length;
                const detailPages = Math.max(1, (typeof rvState.detailPages === "number" && rvState.detailPages > 0)
                    ? rvState.detailPages
                    : Math.ceil(detailTotal / (rvState.detailPer || 5)));
                if (rvState.detailPage > detailPages) rvState.detailPage = detailPages;
                const detailStart = detailTotal ? ((rvState.detailPage - 1) * (rvState.detailPer || 5)) : 0;
                const atFirst = rvState.detailPage <= 1;
                const atLast = rvState.detailPage >= detailPages;
                const selectedPeriod = (rvState.detailPeriod || rvState.financialPeriod || "").toUpperCase();
                const types = (rvFinancialTypes && rvFinancialTypes.length) ? rvFinancialTypes : [];
                const selectedType = types.filter(function (ft) {
                    return String(ft.code || "").toUpperCase() === selectedPeriod;
                })[0] || types[0];
                const selectedLabel = selectedType ? selectedType.financialType : "Month";
                const granOptions = types.map(function (ft) {
                    const code = String(ft.code || "").toUpperCase();
                    const on = code === selectedPeriod;
                    return `<button type="button" role="option" class="${on ? "active" : ""}" aria-selected="${on}" onclick="rvSetViewGran('${rvEsc(code)}')">${rvEsc(ft.financialType)}</button>`;
                }).join("");

                body.innerHTML = `
            <div class="widget" id="rvViewWidget">
              <div class="w-body">
              <div class="rv-view-toolbar">
                <span class="hours-quick-label">View</span>
                <div class="rv-view-dd" id="rvViewGranDd">
                  <button type="button" class="rv-view-dd-btn" aria-haspopup="listbox" onclick="rvToggleViewGran(event)">
                    ${rvEsc(selectedLabel)} <i class="fas fa-chevron-down"></i>
                  </button>
                  <div class="rv-view-dd-menu" role="listbox">${granOptions}</div>
                </div>
                <div class="rv-view-dates">
                  <button type="button" class="datebtn rv-view-date-nav" onclick="rvShiftViewDate(-1)" title="Previous period" aria-label="Previous period"><i class="fas fa-chevron-left"></i></button>
                  <button class="datebtn" type="button">
                    <i class="far fa-calendar-alt"></i>
                    <span>${rvEsc(rvViewDateLabel())}</span>
                  </button>
                  <button type="button" class="datebtn rv-view-date-nav" onclick="rvShiftViewDate(1)" title="Next period" aria-label="Next period"><i class="fas fa-chevron-right"></i></button>
                </div>
                <span style="flex:1"></span>
                <button type="button" class="ghostbtn" onclick="exportMenu(event,'rvViewWidget')"><i class="fas fa-file-excel"></i> Export to Excel</button>
              </div>
              <div class="rv-view-table-wrap">
                <table class="tbl">
                  <colgroup>
                    <col class="rv-col-name">
                    <col class="rv-col-date">
                    <col class="rv-col-date">
                    ${periodCols.map(function () { return '<col class="rv-col-period">'; }).join("")}
                    <col class="rv-col-avg">
                    <col class="rv-col-action">
                  </colgroup>
                  <thead><tr>
                    <th scope="col">Project Name</th>
                    <th scope="col">Start Date</th>
                    <th scope="col">End Date</th>
                    ${periodCols.map(m => `<th scope="col">${rvEsc(m)}</th>`).join("")}
                    <th scope="col">Average</th>
                    <th scope="col">Action</th>
                  </tr></thead>
                  <tbody>${emp.alloc.length ? emp.alloc.map((a, i) => {
                    const rowAvg = a.m && a.m.length ? (a.m.reduce((s, v) => s + (Number(v) || 0), 0) / a.m.length) : 0;
                    return `<tr>
                        <td>${rvEsc(a.name || "—")}</td>
                        <td>${rvEsc(rvFmtMdY(a.expectedStart))}</td>
                        <td>${rvEsc(rvFmtMdY(a.expectedEnd))}</td>
                        ${(a.m || []).map(v => `<td><span class="badge ${rvCls(v)} num">${rvFmtPct(v)}</span></td>`).join("")}
                        <td><span class="num ${rowAvg > 100 ? "b-over" : ""}">${rvFmtPct(rowAvg)}</span><div class="pbar" style="margin-top:5px"><i style="width:${Math.min(100, rowAvg)}%;background:${rvColor(rowAvg)}"></i></div></td>
                        <td><a href="javascript:void(0)" onclick="rvOpenEdit(event,'${rvEsc(emp.id)}',${i})">View</a></td>
                      </tr>`;
                }).join("")
                        : `<tr><td colspan="${periodCols.length + 5}" style="text-align:center;color:var(--muted);padding:26px">No allocations yet for this period.</td></tr>`
                    }</tbody>
                  ${emp.alloc.length ? `<tfoot><tr>
                    <th>Total</th><th></th><th></th>
                    ${t.map(v => `<th><span class="badge ${rvCls(v)} num">${rvFmtPct(v)}</span></th>`).join("")}
                    <th><span class="num ${totAvg > 100 ? "b-over" : ""}">${rvFmtPct(totAvg)}</span></th><th></th>
                  </tr></tfoot>` : ""}
                </table>
              </div>
              <div class="rv-grid-footer">
                <div class="cstm_pagination rv-cstm-pagination" id="rvViewPagerControls" style="${detailTotal ? "" : "display:none;"}">
                  <div class="rv-cstm-pagination-inner">
                    <span class="spntotal">Total Records:</span>
                    <span class="spntotal" id="rvViewTotalRecords">${detailTotal || 0}</span>
                    <nav aria-label="Project list pagination">
                      <ul class="pagination justify-content-end">
                        <li class="page-item${atFirst ? " fa-disabled" : ""}" id="rvViewBtnPrevious">
                          <a class="page-link${atFirst ? " disabled" : ""}" href="javascript:void(0)" id="rvViewLinkPrevious" onclick="rvPrevDetail()" aria-label="Previous" title="Previous">
                            <i class="fas fa-angle-double-left"></i>
                          </a>
                        </li>
                        <li class="page-item${atLast ? " fa-disabled" : ""}" id="rvViewBtnNext">
                          <a class="page-link${atLast ? " disabled" : ""}" href="javascript:void(0)" id="rvViewLinkNext" onclick="rvNextDetail()" aria-label="Next" title="Next">
                            <i class="fas fa-angle-double-right"></i>
                          </a>
                        </li>
                      </ul>
                    </nav>
                  </div>
                </div>
              </div>
              </div>
            </div>`;
            }

            /* ---------- edit resource panel ---------- */
            function rvToInputDate(value) {
                let d = value instanceof Date ? value : null;
                if (!d && typeof parseApiDate === "function") d = parseApiDate(value);
                if (!d && value) {
                    const parsed = new Date(value);
                    if (!isNaN(parsed.getTime())) d = parsed;
                }
                if (!d) return "";
                const mm = String(d.getMonth() + 1).padStart(2, "0");
                const dd = String(d.getDate()).padStart(2, "0");
                return d.getFullYear() + "-" + mm + "-" + dd;
            }
            function rvEditAllocPct(alloc) {
                if (!alloc || !alloc.m || !alloc.m.length) return "";
                const raw = alloc.m.find(function (v) { return Number(v) > 0; });
                const n = Number(raw != null ? raw : alloc.m[0]) || 0;
                if (n <= 0) return "";
                return n > 0 && n <= 10 ? Math.round(n * 100) : Math.round(n);
            }
            function rvSetSelectValue(id, value, label) {
                const el = document.getElementById(id);
                if (!el) return;
                const val = value == null ? "" : String(value);
                if (val && !Array.prototype.some.call(el.options, function (o) { return o.value === val; })) {
                    const opt = document.createElement("option");
                    opt.value = val;
                    opt.textContent = label || val;
                    el.appendChild(opt);
                }
                el.value = val;
            }
            function rvOpenEdit(ev, empId, allocIdx) {
                if (ev && typeof ev.preventDefault === "function") {
                    ev.preventDefault();
                    ev.stopPropagation();
                }
                const emp = (rvState.detailEmp && String(rvState.detailEmp.id) === String(empId))
                    ? rvState.detailEmp
                    : RV_EMP.find(function (x) { return String(x.id) === String(empId); });
                if (!emp) return;
                const alloc = emp.alloc && emp.alloc[allocIdx] ? emp.alloc[allocIdx] : null;
                rvState.editAllocIdx = allocIdx;
                rvState.editPerId = alloc && alloc.projectEmployeeRoleId ? String(alloc.projectEmployeeRoleId) : "";
                rvState.editRow = {
                    projectEmployeeRoleId: rvState.editPerId,
                    employeeID: emp && emp.id ? String(emp.id) : "",
                    projectID: alloc && alloc.pid ? String(alloc.pid) : "",
                    cost: 0,
                    rate: 0,
                    reportingTo: "",
                    isDefaultApprover: false
                };
                if (typeof rvCloseAlloc === "function") rvCloseAlloc();

                const name = emp.name || "—";
                const empName = document.getElementById("rvEditEmpName");
                const projectName = document.getElementById("rvEditProjectName");
                const resource = document.getElementById("rvEditResource");
                const pct = document.getElementById("rvEditPct");
                const start = document.getElementById("rvEditStart");
                const end = document.getElementById("rvEditEnd");
                const work = document.getElementById("rvEditWorkHm");
                const billable = document.getElementById("rvEditBillable");
                const responsibility = document.getElementById("rvEditResponsibility");
                const approver = document.getElementById("rvEditDefaultApprover");

                if (empName) empName.textContent = name;
                if (projectName) projectName.textContent = (alloc && alloc.name) ? alloc.name : "—";
                if (resource) resource.value = name;
                if (pct) pct.value = "";
                if (start) start.value = "";
                if (end) end.value = "";
                if (work) work.value = "";
                if (billable) billable.checked = false;
                if (typeof rvSetResponsibilityText === "function") {
                    rvSetResponsibilityText("");
                } else if (responsibility) {
                    var respText = responsibility.querySelector(".rv-resp-text");
                    if (respText) respText.textContent = "—";
                    else responsibility.textContent = "—";
                    responsibility.removeAttribute("data-tooltip");
                    responsibility.removeAttribute("title");
                }
                if (approver) approver.checked = false;
                rvFillDropdown("rvEditRole", [], "", "—");
                rvFillDropdown("rvEditStatus", [], "", "—");
                rvFillDropdown("rvEditReportingTo", [], "", "—");

                const canvas = document.getElementById("rvEditCanvas");
                const backdrop = document.getElementById("rvEditBackdrop");
                if (canvas) {
                    canvas.classList.add("open");
                    canvas.setAttribute("aria-hidden", "false");
                }
                if (backdrop) backdrop.classList.add("open");

                if (typeof LoadEditResourceDetails === "function") {
                    LoadEditResourceDetails(rvState.editPerId, alloc, emp);
                }
            }
            function rvFillDropdown(selectId, rows, selectedValue, placeholder) {
                const el = document.getElementById(selectId);
                if (!el) return;
                // Added By Vyankat B. on 25th Aug 2026
                // View panel: empty / 0 / N/A shows "—" instead of "-- Select --".
                var raw = selectedValue == null ? "" : String(selectedValue).trim();
                var selected = (raw === "" || raw === "0" || raw.toLowerCase() === "n/a") ? "" : raw;
                const ph = placeholder === undefined ? "—" : placeholder;
                // End of Added By Vyankat B. on 25th Aug 2026
                el.innerHTML = ph === null ? "" : '<option value="">' + ph + "</option>";
                (rows || []).forEach(function (r) {
                    const id = r.id != null ? r.id
                        : (r.ID != null ? r.ID
                        : (r.employeeID != null ? r.employeeID
                        : (r.EmployeeID != null ? r.EmployeeID
                        : (r.roleID != null ? r.roleID : r.RoleID))));
                    const text = r.fieldName != null ? r.fieldName
                        : (r.FieldName != null ? r.FieldName
                        : (r.employeeName || r.EmployeeName
                        || r.roleDescription || r.RoleDescription || String(id)));
                    if (id == null || id === "") return;
                    const opt = document.createElement("option");
                    opt.value = String(id);
                    opt.textContent = text;
                    el.appendChild(opt);
                });
                if (selected) rvSetSelectValue(selectId, selected);
            }
            function rvCloseEdit() {
                if (typeof rvCloseHist === "function") rvCloseHist();
                const canvas = document.getElementById("rvEditCanvas");
                const backdrop = document.getElementById("rvEditBackdrop");
                if (canvas) {
                    canvas.classList.remove("open");
                    canvas.setAttribute("aria-hidden", "true");
                }
                if (backdrop) backdrop.classList.remove("open");
                rvState.editAllocIdx = null;
                rvState.editPerId = null;
                rvState.editRow = null;
                if (typeof rvHistShowButton === "function") rvHistShowButton(false);
            }
            /* ---------- offcanvas ---------- */
            function rvMountProjSelect(selected) {
                if (typeof SearchSelect === "undefined") return;
                const projects = (typeof PROJECTS !== "undefined" ? PROJECTS : []).map(function (p) {
                    return { value: p.id, label: p.id + " · " + p.name };
                });
                const value = selected != null ? selected : (projects[0] ? projects[0].value : "");
                const hidden = document.getElementById("rvAllocProj");
                if (hidden) hidden.value = value;
                SearchSelect.render("rvAllocProjHost", {
                    key: "rvAllocProj",
                    options: projects,
                    value: value,
                    placeholder: "Select Project",
                    searchPlaceholder: "Search Project...",
                    onChange: function (v) { rvMountProjSelect(v); }
                });
            }
            function rvOpenAlloc(id, ev) {
                if (ev && typeof ev.preventDefault === "function") {
                    ev.preventDefault();
                    ev.stopPropagation();
                }
                const e = RV_EMP.find(x => String(x.id) === String(id));
                if (!e) return;
                rvState.allocId = id;
                document.getElementById("rvAllocAv").textContent = rvInit(e.name);
                document.getElementById("rvAllocName").textContent = e.name;
                document.getElementById("rvAllocRole").textContent = e.role + " · " + e.skill;

                const firstPid = (typeof PROJECTS !== "undefined" && PROJECTS[0]) ? PROJECTS[0].id : "";
                const t = rvTotals(e);

                document.getElementById("rvAllocBody").innerHTML = `
            <div>
              <div class="hours-quick-label" style="margin-bottom:8px">Current allocations</div>
              ${e.alloc.length ? e.alloc.map((a, i) => {
                    const p = rvProj(a.pid); return `
                <div class="hours-ex" style="margin-bottom:8px">
                  <div style="display:flex;align-items:center;gap:8px">
                    <div style="flex:1"><div class="t">${rvEsc(p.name)}</div><div class="d">${rvEsc(p.id)} · ${rvEsc(p.customer)}</div></div>
                    <button type="button" class="chipbtn" onclick="rvRemove('${e.id}',${i})">Remove</button>
                  </div>
                  <div style="display:flex;gap:6px;margin-top:8px;flex-wrap:wrap">
                    ${a.m.map((v, j) => `<span class="badge ${rvCls(v)} num">${RV_MONTHS[j].slice(0, 3)} ${v}%</span>`).join("")}
                  </div>
                </div>`;
                }).join("")
                        : `<div class="m-note" style="padding:0 0 4px">No project allocations yet for this quarter.</div>`}
              <div class="legend" style="margin-top:4px">
                ${t.map((v, i) => `<span><i style="background:${rvColor(v)}"></i>${RV_MONTHS[i]}: ${v}%</span>`).join("")}
              </div>
            </div>

            <div style="border-top:1px solid var(--border);padding-top:12px">
              <div class="hours-quick-label" style="margin-bottom:8px">Add allocation</div>
              <div class="hours-field" style="margin-bottom:10px">
                <label>Project</label>
                <div id="rvAllocProjHost" class="ss-host"></div>
                <input type="hidden" id="rvAllocProj" value="${rvEsc(firstPid)}">
              </div>
              <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:8px">
                ${RV_MONTHS.map((m, i) => `<div class="hours-field">
                  <label for="rvAllocM${i}">${m}</label>
                  <input id="rvAllocM${i}" type="number" min="0" max="100" step="5" value="100" aria-label="${m} percentage">
                </div>`).join("")}
              </div>
              <div class="m-note">Capacity is capped at 100% per month across all projects.</div>
            </div>`;

                const el = document.getElementById("rvAlloc");
                el.classList.add("open"); el.setAttribute("aria-hidden", "false");
                document.getElementById("copilot").classList.remove("open");
                rvMountProjSelect(firstPid);
            }
            function rvCloseAlloc() {
                const el = document.getElementById("rvAlloc");
                el.classList.remove("open"); el.setAttribute("aria-hidden", "true");
                rvState.allocId = null;
            }
            function rvSaveAlloc() {
                const e = RV_EMP.find(x => x.id === rvState.allocId); if (!e) return;
                const pid = (document.getElementById("rvAllocProj") || {}).value;
                if (!pid) { toast("Select a project"); return; }
                const m = [0, 1, 2].map(i => Math.max(0, Math.min(100, +document.getElementById("rvAllocM" + i).value || 0)));
                if (!m.some(Boolean)) { toast("Enter at least one month above 0%"); return; }
                const hit = e.alloc.find(a => a.pid === pid);
                if (hit) hit.m = hit.m.map((v, i) => Math.min(100, v + m[i]));
                else e.alloc.push({ pid, m });
                toast(`${rvProj(pid).name} allocated to ${e.name} · ${m.join("% / ")}%`);
                rvCloseAlloc(); rvHydrate();
            }
            function rvRemove(id, idx) {
                const e = RV_EMP.find(x => x.id === id); if (!e || !e.alloc[idx]) return;
                const p = rvProj(e.alloc[idx].pid);
                e.alloc.splice(idx, 1);
                toast(`${p.name} removed from ${e.name}`);
                if (rvState.allocId === id) rvOpenAlloc(id);
                rvHydrate();
            }

            /* ---------- toolbar actions ---------- */
            function rvSetGran(g) {
                rvState.gran = g;
                rvState.financialPeriod = rvCodeFromGran(g);
                rvState.page = 1;
                if (typeof GetFromAndToDates === "function") {
                    GetFromAndToDates();
                }
                rvHydrate();
                toast("Granularity: " + g[0].toUpperCase() + g.slice(1) + " · " + rvCurrentPeriod());
            }
            var rvSearchTimer = null;
            function rvSetSearch(v) {
                rvState.q = v || "";
                rvState.page = 1;
                if (rvSearchTimer) {
                    clearTimeout(rvSearchTimer);
                }
                rvSearchTimer = setTimeout(function () {
                    rvSearchTimer = null;
                    if (typeof GetResourceAllocationDashboard === "function") {
                        GetResourceAllocationDashboard({ skipSummary: true });
                    } else {
                        rvRenderTable();
                    }
                }, 400);
            }
            function rvSetStatus(s) { rvState.status = (rvState.status === s ? "all" : s); rvState.page = 1; rvHydrate(); }
            function rvSort(k) { rvState.sortDir = rvState.sortKey === k ? -rvState.sortDir : 1; rvState.sortKey = k; rvRenderTable(); }
            // Added By Vyankat B. on 24th Aug 2026
            function rvApplyPagerState(rootId, totalId, prevLiId, prevLinkId, nextLiId, nextLinkId, page, pages, total) {
                var root = document.getElementById(rootId);
                var totalEl = document.getElementById(totalId);
                var prevLi = document.getElementById(prevLiId);
                var nextLi = document.getElementById(nextLiId);
                var prevLink = document.getElementById(prevLinkId);
                var nextLink = document.getElementById(nextLinkId);
                if (totalEl) totalEl.textContent = String(total || 0);
                if (root) root.style.display = total > 0 ? "" : "none";
                var atFirst = page <= 1;
                var atLast = pages <= 1 || page >= pages;
                if (prevLi) prevLi.classList.toggle("fa-disabled", atFirst);
                if (nextLi) nextLi.classList.toggle("fa-disabled", atLast);
                if (prevLink) prevLink.classList.toggle("disabled", atFirst);
                if (nextLink) nextLink.classList.toggle("disabled", atLast);
            }
            function rvPrevPage() {
                var prevLi = document.getElementById("rvBtnPrevious");
                var prevLink = document.getElementById("rvLinkPrevious");
                if ((prevLi && prevLi.classList.contains("fa-disabled")) || (prevLink && prevLink.classList.contains("disabled"))) return;
                if (rvState.page <= 1) return;
                rvGo(rvState.page - 1);
            }
            function rvNextPage() {
                var nextLi = document.getElementById("rvBtnNext");
                var nextLink = document.getElementById("rvLinkNext");
                if ((nextLi && nextLi.classList.contains("fa-disabled")) || (nextLink && nextLink.classList.contains("disabled"))) return;
                var total = (typeof rvState.totalEmployees === "number" && rvState.totalEmployees > 0)
                    ? rvState.totalEmployees
                    : (typeof rvFiltered === "function" ? rvFiltered().length : 0);
                var pages = Math.max(1, (typeof rvState.totalPages === "number" && rvState.totalPages > 0)
                    ? rvState.totalPages
                    : Math.ceil(total / (rvState.per || 10)));
                if (rvState.page >= pages) return;
                rvGo(rvState.page + 1);
            }
            function rvPrevDetail() {
                var prevLi = document.getElementById("rvViewBtnPrevious");
                var prevLink = document.getElementById("rvViewLinkPrevious");
                if ((prevLi && prevLi.classList.contains("fa-disabled")) || (prevLink && prevLink.classList.contains("disabled"))) return;
                if (rvState.detailPage <= 1) return;
                rvGoDetail(rvState.detailPage - 1);
            }
            function rvNextDetail() {
                var nextLi = document.getElementById("rvViewBtnNext");
                var nextLink = document.getElementById("rvViewLinkNext");
                if ((nextLi && nextLi.classList.contains("fa-disabled")) || (nextLink && nextLink.classList.contains("disabled"))) return;
                var pages = Math.max(1, (typeof rvState.detailPages === "number" && rvState.detailPages > 0) ? rvState.detailPages : 1);
                if (rvState.detailPage >= pages) return;
                rvGoDetail(rvState.detailPage + 1);
            }
            // End of Added By Vyankat B. on 24th Aug 2026
            function rvGo(p) {
                rvState.page = p;
                if (typeof GetResourceAllocationDashboard === "function") {
                    GetResourceAllocationDashboard({ skipSummary: true });
                } else {
                    rvRenderTable();
                }
                const widget = document.getElementById("allocWidget");
                if (widget) widget.scrollIntoView({ behavior: "smooth", block: "start" });
            }
            function rvGoDetail(p) {
                rvState.detailPage = p;
                if (rvState.viewId && typeof GetResourceAllocationDetails === "function") {
                    GetResourceAllocationDetails(rvState.viewId);
                }
            }
            function rvReset() {
                Object.assign(rvState, { q: "", status: "all", page: 1, sortKey: "none", sortDir: 1 });
                const box = document.getElementById("rvSearch");
                if (box) box.value = "";
                if (typeof GetResourceAllocationDashboard === "function") {
                    GetResourceAllocationDashboard();
                } else {
                    rvHydrate();
                }
                toast("Filters reset");
            }

            /* ---------- routing + hydration ---------- */
            function rvHydrate() {
                const list = document.getElementById("rvList"), detail = document.getElementById("rvDetail");
                if (!list) return;
                if (detail) detail.hidden = true;
                list.hidden = false;
                rvRenderKpis(); rvRenderTable();
                const crumb = document.getElementById("crumbPage");
                if (crumb) crumb.textContent = "Resource Allocation";
            }

            /* =====================================================================
               GLUE — app.js owns rendering: renderPage() rewrites #page-resources from
               its PAGES map on boot, on theme toggle and on persona switch. We hand it
               this page's static shell, then re-hydrate our data immediately after so
               no state is lost. Nothing inside js/app.js is modified.
            ===================================================================== */
            PAGE_NAMES.resources = "Resource Allocation";
            PAGES.resources = () => RV_MARKUP;
            const rvBaseRenderPage = window.renderPage;
            window.renderPage = function () { rvBaseRenderPage(); rvHydrate(); };

            window.addEventListener("hashchange", () => { rvHydrate(); window.scrollTo({ top: 0, behavior: "smooth" }); });
            document.addEventListener("click", e => {
                const dd = document.getElementById("rvViewGranDd");
                if (dd && dd.classList.contains("open") && !dd.contains(e.target)) {
                    rvCloseViewGran();
                }
            });
            document.addEventListener("keydown", e => {
                if (e.key !== "Escape") return;
                const dd = document.getElementById("rvViewGranDd");
                if (dd && dd.classList.contains("open")) {
                    rvCloseViewGran();
                    return;
                }
                const canvas = document.getElementById("rvViewCanvas");
                if (canvas && canvas.classList.contains("open")) {
                    rvCloseView();
                    return;
                }
                rvCloseAlloc();
            });

            renderPage();
        </script>

        <script>
               var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W27_Dashboard").ToString%>';
               var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
               var defaultProjectID = '<%= Session("intProjectID")%>';

        if (!defaultProjectID) {
            defaultProjectID = null;
        }

        var defaultEmployeeID = '<%=If(Session("intUserID") Is Nothing, "", Session("intUserID").ToString())%>';
        var defaultEmployeeName = '<%=If(Session("strUserName") Is Nothing, "", Session("strUserName").ToString())%>';
        var defaultLoginType = '<%=If(Session("LoginType") Is Nothing, "E", Session("LoginType").ToString())%>';
        var defaultLoginId = '<%=If(Session("intLoginID") Is Nothing, "0", Session("intLoginID").ToString())%>';

               var loaderShown = false;
               var loaderStartTime = 0;

               whizJQ(document).ready(function () {
                   if (typeof alertify !== "undefined") {
                       alertify.set('notifier', 'position', 'top-right');
                   }
                   GetFinancialType();
                   GetFromAndToDates();
                   bindDateApplyToDashboard();

                   // Added By Vyankat B. on 26th Aug 2026
                   // Initial page load complete: hide preloader and show main content
                   var preloader = document.getElementById("RvPagePreloader");
                   var wrapper = document.getElementById("AnalyticsWrapper");
                   if (preloader) {
                       preloader.style.display = "none";
                   }
                   if (wrapper) {
                       wrapper.style.display = "";
                   }
                   // End of Added By Vyankat B. on 26th Aug 2026
               });

               function rvNotify(type, message) {
                   if (typeof alertify === "undefined") {
                       if (typeof toast === "function") toast(message);
                       return;
                   }
                   alertify.set('notifier', 'position', 'top-right');
                   if (type === "success") {
                       alertify.success(message);
                   } else {
                       alertify.error(message);
                   }
               }

               function bindDateApplyToDashboard() {
                   var dateBtn = document.getElementById("dateBtn");
                   if (!dateBtn || dateBtn.getAttribute("data-rv-apply-bound") === "1") {
                       return;
                   }

                   dateBtn.setAttribute("data-rv-apply-bound", "1");
                   var originalDateClick = dateBtn.onclick;
                   dateBtn.onclick = function (e) {
                       if (typeof originalDateClick === "function") {
                           originalDateClick.call(this, e);
                       }
                       hookGaApply();
                       bindGaStartDateFocus();
                       requestAnimationFrame(function () {
                           rvSyncGaCalendar(true);
                       });
                   };
               }

               // Added By Vyankat B. on 26th Aug 2026
               // Do not edit js/app.js. After the picker paints from the end date,
               // move to the start month with the existing Prev/Next buttons.
               var rvGaSyncing = false;

               function rvParseGaMonthLabel(text) {
                   if (!text) {
                       return null;
                   }
                   var parsed = new Date(String(text).replace(/\s+/g, " ") + " 1");
                   if (isNaN(parsed.getTime())) {
                       return null;
                   }
                   return parsed.getFullYear() * 12 + parsed.getMonth();
               }

               function rvParseGaFieldDate(fieldId) {
                   var span = document.querySelector("#" + fieldId + " span");
                   if (!span) {
                       return null;
                   }
                   var parsed = new Date(span.textContent);
                   if (isNaN(parsed.getTime())) {
                       return null;
                   }
                   return parsed;
               }

               function rvGaShownMonthIndex() {
                   var el = document.querySelector("#gaCals .ga-mon");
                   return el ? rvParseGaMonthLabel(el.textContent) : null;
               }

               function rvFocusGaStartDate() {
                   var pop = document.querySelector(".ga-pop");
                   if (!pop) {
                       return;
                   }
                   var gaS = pop.querySelector("#gaS");
                   var gaE = pop.querySelector("#gaE");
                   if (gaS) {
                       gaS.classList.add("active");
                   }
                   if (gaE) {
                       gaE.classList.remove("active");
                   }
               }

               function rvFocusGaEndDate() {
                   var pop = document.querySelector(".ga-pop");
                   if (!pop) {
                       return;
                   }
                   var gaS = pop.querySelector("#gaS");
                   var gaE = pop.querySelector("#gaE");
                   if (gaS) {
                       gaS.classList.remove("active");
                   }
                   if (gaE) {
                       gaE.classList.add("active");
                   }
               }

               function rvMoveGaCalendarTo(targetIndex, focusStart) {
                   if (targetIndex == null || rvGaSyncing) {
                       if (focusStart) {
                           rvFocusGaStartDate();
                       }
                       return;
                   }
                   rvGaSyncing = true;
                   var guard = 0;
                   while (guard++ < 36) {
                       var shown = rvGaShownMonthIndex();
                       if (shown == null || shown === targetIndex) {
                           break;
                       }
                       var btn = document.getElementById(shown > targetIndex ? "gaPrev" : "gaNext");
                       if (!btn) {
                           break;
                       }
                       btn.click();
                   }
                   rvGaSyncing = false;
                   if (focusStart) {
                       rvFocusGaStartDate();
                   } else {
                       rvFocusGaEndDate();
                   }
               }

               function rvSyncGaCalendar(focusStart) {
                   var fieldDate = rvParseGaFieldDate(focusStart ? "gaS" : "gaE");
                   if (!fieldDate && typeof state !== "undefined" && state.date) {
                       fieldDate = focusStart ? state.date.s : state.date.e;
                       if (fieldDate && !(fieldDate instanceof Date)) {
                           fieldDate = new Date(fieldDate);
                       }
                   }
                   if (!fieldDate || isNaN(fieldDate.getTime())) {
                       if (focusStart) {
                           rvFocusGaStartDate();
                       }
                       return;
                   }
                   rvMoveGaCalendarTo(fieldDate.getFullYear() * 12 + fieldDate.getMonth(), focusStart);
               }

               function bindGaStartDateFocus() {
                   if (document.body.getAttribute("data-rv-ga-start-focus") === "1") {
                       return;
                   }
                   document.body.setAttribute("data-rv-ga-start-focus", "1");
                   // Capture: app.js stops click bubbling on .ga-pop, so a bubble
                   // listener never sees preset / Start date clicks.
                   document.addEventListener("click", function (e) {
                       if (rvGaSyncing) {
                           return;
                       }
                       var t = e.target;
                       if (!t || !t.closest) {
                           return;
                       }
                       if (!t.closest(".ga-pop")) {
                           return;
                       }
                       if (t.closest(".ga-preset") || t.closest("#gaS")) {
                           setTimeout(function () {
                               rvSyncGaCalendar(true);
                           }, 0);
                           return;
                       }
                       if (t.closest("#gaE")) {
                           setTimeout(function () {
                               rvSyncGaCalendar(false);
                           }, 0);
                       }
                   }, true);
               }
               // End of Added By Vyankat B. on 26th Aug 2026

               function hookGaApply() {
                   var applyBtn = document.getElementById("gaApply");
                   if (!applyBtn || applyBtn.getAttribute("data-rv-bound") === "1") {
                       return;
                   }

                   applyBtn.setAttribute("data-rv-bound", "1");
                   var originalApply = applyBtn.onclick;
                   applyBtn.onclick = function (ev) {
                       if (typeof originalApply === "function") {
                           originalApply.call(this, ev);
                       }
                       if (typeof rvState !== "undefined") {
                           rvState.page = 1;
                       }
                       GetResourceAllocationDashboard();
                   };
               }

               function showLoader() {
                   var loader = document.getElementById('loaderOverlay');

                   if (!loader) {
                       return;
                   }

                   loader.style.display = 'block';
                   loaderShown = true;
                   loaderStartTime = Date.now();
               }

               function hideLoader() {
                   var loader = document.getElementById('loaderOverlay');
                   var preloader = document.getElementById('RvPagePreloader');

                   if (loader) {
                       loader.style.display = 'none';
                   }
                   if (preloader) {
                       preloader.style.display = 'none';
                   }

                   loaderShown = false;
               }
             
               function AJAXCallWithResult(url, param, async) {
                   var $ = (typeof whizJQ !== "undefined") ? whizJQ : jQuery;
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
                               xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                           }
                       },
                       success: function (data) {
                           result = data;
                       },
                       error: function (xhr, status, error) {
                           if (xhr.status === 401) {
                               alertify.set('notifier', 'position', 'top-right');
                               // This dashboard page has no PM ResourceAllocationView.resx, so GetResourceString cannot be used here.
                               alertify.notify('Authentication Failed', 'error', 5);
                           } else {
                               window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + "";
                           }
                       }
                   });

                   if (!async) {
                       return result;
                   }

                   return AjaxResult;
               }
               // End of Added By Vyankat B. on 26th Aug 2026

               function parseApiDate(value) {
                   if (!value) {
                       return null;
                   }

                   var match = String(value).match(/^(\d{4})-(\d{2})-(\d{2})/);
                   if (match) {
                       return new Date(parseInt(match[1], 10), parseInt(match[2], 10) - 1, parseInt(match[3], 10));
                   }

                   var parsed = new Date(value);
                   if (isNaN(parsed.getTime())) {
                       return null;
                   }

                   return new Date(parsed.getFullYear(), parsed.getMonth(), parsed.getDate());
               }

               function bindFromAndToDates(data) {
                   if (!data || typeof state === "undefined" || !state.date) {
                       return;
                   }

                   var fromDate = parseApiDate(data.fromDate || data.FromDate);
                   var toDate = parseApiDate(data.toDate || data.ToDate);
                   if (!fromDate || !toDate) {
                       return;
                   }

                   var days = Math.round((toDate - fromDate) / 864e5) + 1;
                   state.date.s = fromDate;
                   state.date.e = toDate;
                   state.date.range = (typeof rangeLbl === "function") ? rangeLbl(fromDate, toDate) : "";
                   state.date.months = Math.max(days / 30.42, 0.1);

                   if (typeof syncDateUI === "function") {
                       syncDateUI();
                   }

                   var fromToLabel = (typeof rvFmtDashDate === "function")
                       ? (rvFmtDashDate(fromDate) + " To " + rvFmtDashDate(toDate))
                       : "";
                   var rangeTxt = document.getElementById("dateRangeTxt");
                   if (rangeTxt && fromToLabel) {
                       rangeTxt.textContent = fromToLabel;
                   }
                   var rvPeriodEl = document.getElementById("rvPeriod");
                   if (rvPeriodEl && fromToLabel) {
                       rvPeriodEl.textContent = fromToLabel;
                   }

                   var gaS = document.getElementById("gaS");
                   var gaE = document.getElementById("gaE");
                   if (gaS && gaS.querySelector("span") && typeof fmtD === "function") {
                       gaS.querySelector("span").textContent = fmtD(fromDate);
                   }
                   if (gaE && gaE.querySelector("span") && typeof fmtD === "function") {
                       gaE.querySelector("span").textContent = fmtD(toDate);
                   }

                   if (typeof GetResourceAllocationDashboard === "function") {
                       GetResourceAllocationDashboard();
                   } else if (typeof rvHydrate === "function") {
                       rvHydrate();
                   }
               }

               function GetFromAndToDates() {
                   var orderOne = (typeof rvOrderOneFinancialType === "function") ? rvOrderOneFinancialType() : null;
                   var financialPeriod = (rvState && rvState.financialPeriod)
                       ? rvState.financialPeriod
                       : (orderOne && orderOne.code ? String(orderOne.code).toUpperCase() : "");

                   if (!financialPeriod) {
                       return null;
                   }

                   var param = {
                       financialPeriod: financialPeriod,
                       period: 0,
                       specificDate: null
                   };

                   var url = "api/PM_ResourceAllocationView/GetFromAndToDates";

                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);

                   if (response && response.data) {
                       bindFromAndToDates(response.data);
                       return response.data;
                   }

                   return null;
               }

               function bindViewFromAndToDates(data) {
                   if (!data || typeof data !== "object") {
                       return;
                   }
                   var fromDate = parseApiDate(data.fromDate || data.FromDate);
                   var toDate = parseApiDate(data.toDate || data.ToDate);
                   if (!fromDate || !toDate) {
                       return;
                   }
                   rvState.detailFrom = fromDate;
                   rvState.detailTo = toDate;
               }

               function GetViewFromAndToDates() {
                   var financialPeriod = (rvState && (rvState.detailPeriod || rvState.financialPeriod))
                       ? (rvState.detailPeriod || rvState.financialPeriod)
                       : "";

                   if (!financialPeriod) {
                       if (rvState.viewId && typeof GetResourceAllocationDetails === "function") {
                           GetResourceAllocationDetails(rvState.viewId);
                       }
                       return null;
                   }

                   var param = {
                       financialPeriod: financialPeriod,
                       period: (rvState && typeof rvState.detailPeriodOffset === "number")
                           ? rvState.detailPeriodOffset
                           : 0,
                       specificDate: null
                   };

                   var url = "api/PM_ResourceAllocationView/GetFromAndToDates";
                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);
                   var data = response && (response.data || response.Data);
                   if (data && (data.fromDate || data.FromDate || data.toDate || data.ToDate)) {
                       bindViewFromAndToDates(data);
                   } else if (data && (data.data || data.Data)) {
                       bindViewFromAndToDates(data.data || data.Data);
                   }

                   if (rvState.viewId && typeof GetResourceAllocationDetails === "function") {
                       GetResourceAllocationDetails(rvState.viewId);
                   }
                   return data;
               }

               function formatDashboardDate(value) {
                   var d = value instanceof Date ? value : parseApiDate(value);
                   if (!d) {
                       return null;
                   }

                   var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                   var day = ("0" + d.getDate()).slice(-2);
                   return day + "-" + months[d.getMonth()] + "-" + d.getFullYear();
               }

               function rvPeriodLabelFromDate(d, code) {
                   if (!d) {
                       return "";
                   }

                   var c = String(code || rvState.financialPeriod || "M").toUpperCase();
                   if (c === "D") {
                       return d.toLocaleDateString("en-US", { month: "short", day: "numeric", year: "numeric" });
                   }
                   if (c === "W") {
                       return d.toLocaleDateString("en-US", { month: "short", day: "numeric" });
                   }

                   return d.toLocaleDateString("en-US", { month: "short", year: "numeric" });
               }

               function bindResourceAllocationDashboard(list, paging) {
                   RV_EMP.length = 0;
                   rvState.periodCols = [];

                   if (paging) {
                       rvState.totalEmployees = Number(paging.totalEmployees != null ? paging.totalEmployees : paging.TotalEmployees) || 0;
                       rvState.totalPages = Number(paging.totalPages != null ? paging.totalPages : paging.TotalPages) || 0;
                       var pageNo = Number(paging.pageNo != null ? paging.pageNo : paging.PageNo);
                       if (pageNo > 0) {
                           rvState.page = pageNo;
                       }
                   } else {
                       rvState.totalEmployees = 0;
                       rvState.totalPages = 0;
                   }

                   if (!Array.isArray(list) || !list.length) {
                       if (typeof rvHydrate === "function") {
                           rvHydrate();
                       }
                       return;
                   }

                   var code = rvState.financialPeriod || "";
                   var periodMap = {};
                   var periodList = [];
                   var byEmp = {};
                   var empOrder = [];

                   function periodKey(row) {
                       var title = String(row.title || row.Title || "").trim();
                       if (title) {
                           return title;
                       }
                       return rvPeriodLabelFromDate(parseApiDate(row.startDate || row.StartDate), code);
                   }

                   list.forEach(function (row) {
                       var start = parseApiDate(row.startDate || row.StartDate);
                       var key = periodKey(row);
                       if (key && !periodMap[key]) {
                           periodMap[key] = true;
                           periodList.push({ key: key, date: start });
                       }
                   });

                   periodList.sort(function (a, b) {
                       return (a.date && b.date) ? (a.date - b.date) : String(a.key).localeCompare(String(b.key));
                   });

                   rvState.periodCols = periodList.map(function (p) { return p.key; });
                   if (rvState.periodCols.length) {
                       RV_MONTHS.length = 0;
                       rvState.periodCols.forEach(function (col) { RV_MONTHS.push(col); });
                       var gran = RV_GRAN[rvState.gran] ? rvState.gran : "month";
                       RV_GRAN[gran].cols = RV_MONTHS;
                   }

                   list.forEach(function (row) {
                       var employeeId = row.employeeId != null ? row.employeeId : row.EmployeeId;
                       var id = String(employeeId != null ? employeeId : "");
                       if (!id) {
                           return;
                       }

                       if (!byEmp[id]) {
                           byEmp[id] = {
                               id: id,
                               employeeId: employeeId,
                               name: row.employeeName || row.EmployeeName || "",
                               role: "",
                               skill: "",
                               alloc: [],
                               pctByPeriod: {}
                           };
                           empOrder.push(id);
                       }

                       var key = periodKey(row);
                       var pct = Number(row.resourcePercentage != null ? row.resourcePercentage : row.ResourcePercentage);
                       if (isNaN(pct)) {
                           pct = 0;
                       }
                       byEmp[id].pctByPeriod[key] = (byEmp[id].pctByPeriod[key] || 0) + pct;
                   });

                   empOrder.forEach(function (id) {
                       var emp = byEmp[id];
                       emp.percentages = RV_MONTHS.map(function (col) {
                           return emp.pctByPeriod[col] || 0;
                       });
                       RV_EMP.push(emp);
                   });

                   RV_EMP.sort(function (a, b) {
                       return String(a.name || "").localeCompare(String(b.name || ""), undefined, { sensitivity: "base" });
                   });

                   if (!paging) {
                       rvState.totalEmployees = RV_EMP.length;
                       rvState.totalPages = Math.max(1, Math.ceil(RV_EMP.length / (rvState.per || 10)));
                   }

                   if (typeof rvHydrate === "function") {
                       rvHydrate();
                   }
               }

               function GetResourceAllocationDashboard(options) {
                   var range = (typeof rvDateRange === "function") ? rvDateRange() : null;
                   var fromDate = range ? formatDashboardDate(range[0]) : null;
                   var toDate = range ? formatDashboardDate(range[1]) : null;
                   var financialPeriod = (rvState && rvState.financialPeriod) ? rvState.financialPeriod : "";
                   var employeeName = (rvState && rvState.q) ? String(rvState.q).trim() : "";

                   if (!financialPeriod || !fromDate || !toDate) {
                       return null;
                   }

                   var param = {
                       userID: defaultEmployeeID ? String(defaultEmployeeID) : null,
                       loginType: defaultLoginType || null,
                       userName: defaultEmployeeName || null,
                       loginId: defaultLoginId ? String(defaultLoginId) : null,
                       financialPeriod: financialPeriod,
                       fromDate: fromDate,
                       toDate: toDate,
                       businessGroupID: null,
                       locationID: null,
                       roleId: null,
                       gradeId: null,
                       employeeName: employeeName ? employeeName : null,
                       deployable: null,
                       allocationPercentage: null,
                       pageNo: (rvState && rvState.page) ? rvState.page : 1,
                       pageSize: (rvState && rvState.per) ? rvState.per : 10
                   };

                   var url = "api/PM_ResourceAllocationView/GetResourceAllocationDashboard";
                   showLoader();
                   if (!options || !options.skipSummary) {
                       GetResourceAllocationSummary(param);
                   }
                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);
                   hideLoader();

                   var payload = response && (response.data || response.Data);
                   if (payload && (payload.data || payload.Data) && !payload.items && !payload.Items
                       && !payload.resourceAllocationDashboardResponse
                       && !payload.ResourceAllocationDashboardResponse) {
                       payload = payload.data || payload.Data;
                   }

                   var list = [];
                   var paging = null;
                   if (Array.isArray(payload)) {
                       list = payload;
                   } else if (payload && typeof payload === "object") {
                       list = payload.items
                           || payload.Items
                           || payload.resourceAllocationDashboardResponse
                           || payload.ResourceAllocationDashboardResponse
                           || [];
                       var pagingRows = payload.resourceAllocationPaginationEntity
                           || payload.ResourceAllocationPaginationEntity;
                       var pagingRow = Array.isArray(pagingRows) && pagingRows.length
                           ? pagingRows[0]
                           : (payload.items || payload.Items ? payload : null);
                       if (pagingRow) {
                           paging = {
                               totalEmployees: pagingRow.totalRecords != null ? pagingRow.totalRecords
                                   : (pagingRow.TotalRecords != null ? pagingRow.TotalRecords
                                   : (pagingRow.totalEmployees != null ? pagingRow.totalEmployees : pagingRow.TotalEmployees)),
                               totalPages: pagingRow.totalPages != null ? pagingRow.totalPages : pagingRow.TotalPages,
                               pageNo: pagingRow.currentPage != null ? pagingRow.currentPage
                                   : (pagingRow.CurrentPage != null ? pagingRow.CurrentPage
                                   : (pagingRow.pageNo != null ? pagingRow.pageNo : pagingRow.PageNo)),
                               pageSize: pagingRow.pageSize != null ? pagingRow.pageSize : pagingRow.PageSize
                           };
                       }
                   }

                   bindResourceAllocationDashboard(list, paging);
                   return list;
               }

               function formatDetailDate(value) {
                   var d = parseApiDate(value);
                   if (!d) {
                       return "";
                   }
                   return d.toLocaleDateString("en-US", { day: "numeric", month: "short", year: "numeric" });
               }

               function bindResourceAllocationDetails(employeeId, rows, paging) {
                   var list = Array.isArray(rows) ? rows : [];
                   var name = "";
                   var periodMap = {};
                   var periodList = [];
                   var byProj = {};
                   var projOrder = [];
                   var code = (rvState && (rvState.detailPeriod || rvState.financialPeriod))
                       ? (rvState.detailPeriod || rvState.financialPeriod)
                       : "";

                   list.forEach(function (row) {
                       if (!name) {
                           name = row.employeeName || row.EmployeeName || "";
                       }
                       var start = parseApiDate(row.startDate || row.StartDate);
                       var title = String(row.title || row.Title || "").trim();
                       if (!title) {
                           title = typeof rvPeriodLabelFromDate === "function"
                               ? rvPeriodLabelFromDate(start, code)
                               : "";
                       }
                       if (title && !periodMap[title]) {
                           periodMap[title] = true;
                           periodList.push({ key: title, date: start });
                       }

                       var pid = row.projectID != null ? row.projectID : row.ProjectID;
                       var roleId = row.projectEmployeeroleId != null ? row.projectEmployeeroleId : row.ProjectEmployeeroleId;
                       var key = String(pid != null ? pid : "") + ":" + String(roleId != null ? roleId : "");
                       if (!byProj[key]) {
                           var startTxt = formatDetailDate(row.expectedStartDate || row.ExpectedStartDate);
                           var endTxt = formatDetailDate(row.expectedEndDate || row.ExpectedEndDate);
                           byProj[key] = {
                               pid: String(pid != null ? pid : ""),
                               projectEmployeeRoleId: roleId != null ? String(roleId) : "",
                               name: row.projectName || row.ProjectName || "",
                               customer: row.allocationType || row.AllocationType || "",
                               expectedStart: row.expectedStartDate || row.ExpectedStartDate,
                               expectedEnd: row.expectedEndDate || row.ExpectedEndDate,
                               dateRange: (startTxt && endTxt) ? (startTxt + " – " + endTxt) : (startTxt || endTxt || ""),
                               pctByPeriod: {}
                           };
                           projOrder.push(key);
                       }

                       var pct = Number(row.resourcePercentage != null ? row.resourcePercentage : row.ResourcePercentage);
                       if (isNaN(pct)) {
                           pct = 0;
                       }
                       if (title) {
                           byProj[key].pctByPeriod[title] = (byProj[key].pctByPeriod[title] || 0) + pct;
                       }
                   });

                   periodList.sort(function (a, b) {
                       return (a.date && b.date) ? (a.date - b.date) : String(a.key).localeCompare(String(b.key));
                   });
                   var cols = periodList.map(function (p) { return p.key; });
                   if (!cols.length && rvState.periodCols && rvState.periodCols.length) {
                       cols = rvState.periodCols.slice();
                   }

                   var gridEmp = RV_EMP.find(function (x) { return String(x.id) === String(employeeId); });
                   var emp = {
                       id: String(employeeId),
                       name: name || (gridEmp ? gridEmp.name : ("Employee " + employeeId)),
                       role: gridEmp ? gridEmp.role : "",
                       skill: gridEmp ? gridEmp.skill : "",
                       alloc: projOrder.map(function (key) {
                           var p = byProj[key];
                           return {
                               pid: p.pid,
                               projectEmployeeRoleId: p.projectEmployeeRoleId || "",
                               name: p.name,
                               customer: p.customer,
                               expectedStart: p.expectedStart,
                               expectedEnd: p.expectedEnd,
                               dateRange: p.dateRange,
                               m: cols.map(function (c) { return p.pctByPeriod[c] || 0; })
                           };
                       })
                   };
                   emp.percentages = cols.map(function (_, i) {
                       return emp.alloc.reduce(function (sum, a) { return sum + (a.m[i] || 0); }, 0);
                   });

                   if (paging) {
                       rvState.detailTotal = Number(paging.totalRecords != null ? paging.totalRecords
                           : (paging.TotalRecords != null ? paging.TotalRecords : paging.totalEmployees)) || 0;
                       rvState.detailPages = Number(paging.totalPages != null ? paging.totalPages : paging.TotalPages) || 0;
                       var pageNo = Number(paging.pageNo != null ? paging.pageNo
                           : (paging.CurrentPage != null ? paging.CurrentPage : paging.currentPage)) || 0;
                       if (pageNo > 0) {
                           rvState.detailPage = pageNo;
                       }
                       var pageSize = Number(paging.pageSize != null ? paging.pageSize : paging.PageSize) || 0;
                       if (pageSize > 0) {
                           rvState.detailPer = pageSize;
                       }
                   } else {
                       rvState.detailTotal = emp.alloc.length;
                       rvState.detailPages = Math.max(1, Math.ceil(emp.alloc.length / (rvState.detailPer || 5)));
                   }

                   if (typeof rvRenderDetail === "function") {
                       rvRenderDetail(emp, cols);
                   }
                   return emp;
               }

               function GetResourceAllocationDetails(employeeId) {
                   var fromDate = rvState.detailFrom ? formatDashboardDate(rvState.detailFrom) : null;
                   var toDate = rvState.detailTo ? formatDashboardDate(rvState.detailTo) : null;
                   if (!fromDate || !toDate) {
                       var range = (typeof rvDateRange === "function") ? rvDateRange() : null;
                       fromDate = range ? formatDashboardDate(range[0]) : null;
                       toDate = range ? formatDashboardDate(range[1]) : null;
                   }
                   var financialPeriod = (rvState && (rvState.detailPeriod || rvState.financialPeriod))
                       ? (rvState.detailPeriod || rvState.financialPeriod)
                       : "";

                   if (!employeeId || !financialPeriod || !fromDate || !toDate) {
                       if (typeof rvRenderDetail === "function") {
                           rvRenderDetail({ id: String(employeeId || ""), name: "Employee", alloc: [], percentages: [] }, []);
                       }
                       return null;
                   }

                   var param = {
                       userID: defaultEmployeeID ? String(defaultEmployeeID) : null,
                       loginType: defaultLoginType || null,
                       userName: defaultEmployeeName || null,
                       loginId: defaultLoginId ? String(defaultLoginId) : null,
                       financialPeriod: financialPeriod,
                       fromDate: fromDate,
                       toDate: toDate,
                       employeeID: String(employeeId),
                       pageNo: (rvState && rvState.detailPage) ? rvState.detailPage : 1,
                       pageSize: (rvState && rvState.detailPer) ? rvState.detailPer : 5
                   };

                   var url = "api/PM_ResourceAllocationView/GetResourceAllocationDetails";
                   showLoader();
                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);
                   hideLoader();

                   var payload = response && (response.data || response.Data);
                   if (payload && (payload.data || payload.Data) && !payload.items && !payload.Items
                       && !payload.resourceAllocationDetailsResponse
                       && !payload.ResourceAllocationDetailsResponse) {
                       payload = payload.data || payload.Data;
                   }
                   var list = [];
                   var paging = null;
                   if (Array.isArray(payload)) {
                       list = payload;
                   } else if (payload && typeof payload === "object") {
                       list = payload.items
                           || payload.Items
                           || payload.resourceAllocationDetailsResponse
                           || payload.ResourceAllocationDetailsResponse
                           || [];
                       var pagingRows = payload.resourceAllocationPaginationEntity
                           || payload.ResourceAllocationPaginationEntity;
                       var pagingRow = Array.isArray(pagingRows) && pagingRows.length
                           ? pagingRows[0]
                           : (payload.items || payload.Items ? payload : null);
                       if (pagingRow) {
                           paging = {
                               totalRecords: pagingRow.totalRecords != null ? pagingRow.totalRecords : pagingRow.TotalRecords,
                               totalPages: pagingRow.totalPages != null ? pagingRow.totalPages : pagingRow.TotalPages,
                               pageNo: pagingRow.currentPage != null ? pagingRow.currentPage
                                   : (pagingRow.CurrentPage != null ? pagingRow.CurrentPage
                                   : (pagingRow.pageNo != null ? pagingRow.pageNo : pagingRow.PageNo)),
                               pageSize: pagingRow.pageSize != null ? pagingRow.pageSize : pagingRow.PageSize
                           };
                       }
                   }
                   return bindResourceAllocationDetails(employeeId, list, paging);
               }

               function bindResourceAllocationSummary(data) {
                   rvSummary.totalEmployees = 0;
                   rvSummary.fullyAllocated = 0;
                   rvSummary.fullyAllocatedPct = 0;
                   rvSummary.partiallyAllocated = 0;
                   rvSummary.partiallyAllocatedPct = 0;
                   rvSummary.unallocated = 0;
                   rvSummary.unallocatedPct = 0;

                   if (!data || typeof data !== "object") {
                       return;
                   }

                   rvSummary.totalEmployees = Number(data.totalEmployees != null ? data.totalEmployees : data.TotalEmployees) || 0;
                   rvSummary.fullyAllocated = Number(data.fullyAllocated != null ? data.fullyAllocated : data.FullyAllocated) || 0;
                   rvSummary.fullyAllocatedPct = Number(data.fullyAllocatedPct != null ? data.fullyAllocatedPct : data.FullyAllocatedPct) || 0;
                   rvSummary.partiallyAllocated = Number(data.partiallyAllocated != null ? data.partiallyAllocated : data.PartiallyAllocated) || 0;
                   rvSummary.partiallyAllocatedPct = Number(data.partiallyAllocatedPct != null ? data.partiallyAllocatedPct : data.PartiallyAllocatedPct) || 0;
                   rvSummary.unallocated = Number(data.unallocated != null ? data.unallocated : data.Unallocated) || 0;
                   rvSummary.unallocatedPct = Number(data.unallocatedPct != null ? data.unallocatedPct : data.UnallocatedPct) || 0;
               }

               function GetResourceAllocationSummary(baseParam) {
                   var param = baseParam ? Object.assign({}, baseParam) : null;
                   if (!param) {
                       return null;
                   }

                   delete param.fromDate;
                   delete param.toDate;
                   delete param.employeeName;
                   param.aggregationMethod = "AVG";

                   var url = "api/PM_ResourceAllocationView/GetResourceAllocationSummary";
                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);
                   var data = response && (response.data || response.Data);
                   bindResourceAllocationSummary(data);
                   return data;
               }

               function bindFinancialTypes(list) {
                   if (!Array.isArray(list)) {
                       return;
                   }

                   rvFinancialTypes = list.map(function (item) {
                       return {
                           code: item.code || item.Code || "",
                           financialType: item.financialType || item.FinancialType || "",
                           orderBy: item.orderBy != null ? item.orderBy : (item.OrderBy != null ? item.OrderBy : 0)
                       };
                   }).filter(function (item) {
                       return item.code && typeof rvGranFromCode === "function" && rvGranFromCode(item.code);
                   }).sort(function (a, b) {
                       return a.orderBy - b.orderBy;
                   });

                   var orderOne = rvOrderOneFinancialType();
                   if (orderOne && orderOne.code) {
                       rvState.financialPeriod = String(orderOne.code).toUpperCase();
                       rvState.gran = rvGranFromCode(orderOne.code) || "";
                   }

                   if (typeof rvRenderGranButtons === "function") {
                       rvRenderGranButtons();
                   }
               }

               function GetFinancialType() {
                   var url = "api/PM_ResourceAllocationView/GetFinancialType";
                   var response = AJAXCallWithResult(url, JSON.stringify({}), false);
                   var list = response && (response.data || response.Data);

                   if (list) {
                       bindFinancialTypes(list);
                       return list;
                   }

                   return null;
               }

               function rvUnwrapApiData(response) {
                   var payload = response && (response.data != null ? response.data : response.Data);
                   if (payload && typeof payload === "object" && !Array.isArray(payload)
                       && (payload.data != null || payload.Data != null)
                       && payload.items == null && payload.Items == null) {
                       payload = payload.data != null ? payload.data : payload.Data;
                   }
                   return payload;
               }

               function rvUnwrapApiList(response) {
                   var payload = rvUnwrapApiData(response);
                   if (Array.isArray(payload)) {
                       return payload;
                   }
                   if (payload && typeof payload === "object") {
                       if (Array.isArray(payload.items)) return payload.items;
                       if (Array.isArray(payload.Items)) return payload.Items;
                   }
                   return [];
               }

               function GetAllDropdown(fieldName, inputParameterJson) {
                   var param = {
                       fieldName: fieldName,
                       inputParameterJson: inputParameterJson || null
                   };
                   var url = "api/PM_ResourceAllocationView/GetAllDropdown";
                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);
                   return rvUnwrapApiList(response);
               }

               function GetProjectEmployeeRole(projectEmployeeRoleId) {
                   if (!projectEmployeeRoleId) {
                       return null;
                   }
                   var param = { projectEmployeeRoleID: String(projectEmployeeRoleId) };
                   var url = "api/PM_ResourceAllocationView/GetProjectEmployeeRole";
                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);
                   var payload = rvUnwrapApiData(response);
                   if (Array.isArray(payload)) {
                       return payload.length ? payload[0] : null;
                   }
                   if (payload && typeof payload === "object") {
                       return payload;
                   }
                   return null;
               }

               // Added By Vyankat B. on 24th Aug 2026
               function GetEmployeeNameById(employeeID) {
                   if (employeeID == null || employeeID === "" || Number(employeeID) === 0) {
                       return "";
                   }
                   var url = "api/PM_ResourceAllocationView/GetEmployeeName";
                   var response = AJAXCallWithResult(url, JSON.stringify({ employeeID: String(employeeID) }), false);
                   var list = typeof rvUnwrapApiList === "function" ? rvUnwrapApiList(response) : [];
                   var row = list && list.length ? list[0] : null;
                   if (!row) {
                       var data = typeof rvUnwrapApiData === "function" ? rvUnwrapApiData(response) : null;
                       if (Array.isArray(data) && data.length) row = data[0];
                       else if (data && typeof data === "object") row = data;
                   }
                   if (!row) return "";
                   return row.employeeName || row.EmployeeName || "";
               }

               function GetRowWiseExternalApprovers(projectID) {
                   if (!projectID) {
                       return [];
                   }
                   var param = {
                       projectID: String(projectID),
                       paging: false,
                       strPaging: "-1"
                   };
                   var url = "api/PM_ResourceAllocationView/GetRowWiseExternalApprovers";
                   var response = AJAXCallWithResult(url, JSON.stringify(param), false);
                   return typeof rvUnwrapApiList === "function" ? rvUnwrapApiList(response) : [];
               }
               // End of Added By Vyankat B. on 24th Aug 2026

               // Added By Vyankat B. on 26th Aug 2026
               // Clamp Responsibility to 2 lines; full text is the hover tooltip.
               function rvSetResponsibilityText(text) {
                   var el = document.getElementById("rvEditResponsibility");
                   if (!el) {
                       return;
                   }

                   var textEl = el.querySelector(".rv-resp-text") || el;
                   var value = text == null ? "" : String(text).trim();
                   el.removeAttribute("title");
                   el.removeAttribute("data-tooltip");

                   if (!value) {
                       textEl.textContent = "—";
                       return;
                   }

                   textEl.textContent = value;
                   requestAnimationFrame(function () {
                       if (textEl.scrollHeight > textEl.clientHeight + 1) {
                           el.setAttribute("data-tooltip", value);
                       }
                   });
               }

               function bindProjectEmployeeRole(row, alloc, emp) {
                   if (!row) {
                       return;
                   }
                   var empNameTxt = row.employeeName || row.EmployeeName || (emp && emp.name) || "";
                   var empNameEl = document.getElementById("rvEditEmpName");
                   var resource = document.getElementById("rvEditResource");
                   var pct = document.getElementById("rvEditPct");
                   var start = document.getElementById("rvEditStart");
                   var end = document.getElementById("rvEditEnd");
                   var billable = document.getElementById("rvEditBillable");
                   var approver = document.getElementById("rvEditDefaultApprover");
                   var work = document.getElementById("rvEditWorkHm");

                   if (empNameEl && empNameTxt) empNameEl.textContent = empNameTxt;
                   if (resource && empNameTxt) resource.value = empNameTxt;

                   var pctVal = row.resourcePercentage != null ? row.resourcePercentage : row.ResourcePercentage;
                   if (pct && pctVal != null && pctVal !== "") {
                       pct.value = Number(pctVal);
                   }

                   var startVal = row.expectedStartDate != null ? row.expectedStartDate : row.ExpectedStartDate;
                   var endVal = row.expectedEndDate != null ? row.expectedEndDate : row.ExpectedEndDate;
                   if (start) start.value = typeof rvToInputDate === "function" ? rvToInputDate(startVal) : "";
                   if (end) end.value = typeof rvToInputDate === "function" ? rvToInputDate(endVal) : "";

                   var billableVal = row.isResourceBillable != null ? row.isResourceBillable : row.IsResourceBillable;
                   if (billable) billable.checked = billableVal === true || billableVal === 1 || String(billableVal).toLowerCase() === "true";

                   var respVal = row.responsibility != null ? row.responsibility : row.Responsibility;
                   rvSetResponsibilityText(respVal);

                   var approverVal = row.isDefaultApprover != null ? row.isDefaultApprover : row.IsDefaultApprover;
                   if (approver) approver.checked = approverVal === true || approverVal === 1 || String(approverVal).toLowerCase() === "true";

                   var hours = row.budgetedHours != null ? row.budgetedHours : row.BudgetedHours;
                   if (work && hours != null && hours !== "") {
                       var n = Number(hours);
                       if (!isNaN(n) && n >= 0) {
                           var h = Math.floor(n);
                           var m = Math.round((n - h) * 60);
                           if (m === 60) { h += 1; m = 0; }
                           work.value = h + ":" + String(m).padStart(2, "0");
                       }
                   }

                   var statusVal = row.resourceStatus != null ? row.resourceStatus : row.ResourceStatus;
                   var statusTxt = statusVal == null ? "" : String(statusVal).trim();
                   if (statusTxt && statusTxt !== "0" && statusTxt.toLowerCase() !== "n/a" && typeof rvSetSelectValue === "function") {
                       rvSetSelectValue("rvEditStatus", statusVal, statusVal);
                   }
                   var reportingTo = row.reportingTo != null ? row.reportingTo : row.ReportingTo;
                   if (reportingTo != null && reportingTo !== "" && Number(reportingTo) !== 0 && typeof rvSetSelectValue === "function") {
                       // Added By Vyankat B. on 24th Aug 2026
                       var reportingToName = row.reportingToName || row.ReportingToName || "";
                       if (!reportingToName && typeof GetEmployeeNameById === "function") {
                           reportingToName = GetEmployeeNameById(reportingTo);
                       }
                       rvSetSelectValue("rvEditReportingTo", reportingTo, reportingToName || String(reportingTo));
                       // End of Added By Vyankat B. on 24th Aug 2026
                   }

                   rvState.editRow = {
                       projectEmployeeRoleId: String(row.projectEmployeeRoleId != null ? row.projectEmployeeRoleId
                           : (row.ProjectEmployeeRoleId != null ? row.ProjectEmployeeRoleId : (rvState.editPerId || ""))),
                       employeeID: String(row.employeeID != null ? row.employeeID
                           : (row.EmployeeID != null ? row.EmployeeID : ((emp && emp.id) || ""))),
                       projectID: String(row.projectID != null ? row.projectID
                           : (row.ProjectID != null ? row.ProjectID : ((alloc && alloc.pid) || ""))),
                       cost: Number(row.cost != null ? row.cost : row.Cost) || 0,
                       rate: Number(row.rate != null ? row.rate : row.Rate) || 0,
                       reportingTo: reportingTo != null ? String(reportingTo) : ""
                   };
                   if (rvState.editRow.projectEmployeeRoleId) {
                       rvState.editPerId = rvState.editRow.projectEmployeeRoleId;
                   }
               }

               function LoadEditResourceDetails(projectEmployeeRoleId, alloc, emp) {
                   if (typeof showLoader === "function") showLoader();
                   if (typeof rvHistShowButton === "function") rvHistShowButton(false);
                   var details = typeof GetProjectEmployeeRole === "function"
                       ? GetProjectEmployeeRole(projectEmployeeRoleId)
                       : null;
                   var roleId = details
                       ? (details.role != null ? details.role : details.Role)
                       : "";
                   var statusVal = details
                       ? (details.resourceStatus != null ? details.resourceStatus : details.ResourceStatus)
                       : "";
                   var roles = typeof GetAllDropdown === "function"
                       ? GetAllDropdown("RolePopulateCombo", null)
                       : [];
                   var statuses = typeof GetAllDropdown === "function"
                       ? GetAllDropdown("ProjectGroupResourcesStatus", null)
                       : [];
                   var reportingToId = details
                       ? (details.reportingTo != null ? details.reportingTo : details.ReportingTo)
                       : "";
                   var projectId = details
                       ? (details.projectID != null ? details.projectID : details.ProjectID)
                       : (alloc && alloc.pid ? alloc.pid : "");
                   var reportingRows = typeof GetRowWiseExternalApprovers === "function"
                       ? GetRowWiseExternalApprovers(projectId)
                       : [];
                   if (typeof rvFillDropdown === "function") {
                       rvFillDropdown("rvEditRole", roles, roleId, "—");
                       rvFillDropdown("rvEditStatus", statuses, statusVal, "—");
                       rvFillDropdown("rvEditReportingTo", reportingRows, reportingToId, "—");
                   }
                   if (details && roleId && typeof rvSetSelectValue === "function") {
                       rvSetSelectValue("rvEditRole", roleId, details.roleDescription || details.RoleDescription || String(roleId));
                   }
                   if (details) {
                       bindProjectEmployeeRole(details, alloc, emp);
                   } else if (alloc) {
                       var pct = document.getElementById("rvEditPct");
                       var start = document.getElementById("rvEditStart");
                       var end = document.getElementById("rvEditEnd");
                       if (pct && typeof rvEditAllocPct === "function") pct.value = rvEditAllocPct(alloc);
                       if (start && typeof rvToInputDate === "function") start.value = rvToInputDate(alloc.expectedStart);
                       if (end && typeof rvToInputDate === "function") end.value = rvToInputDate(alloc.expectedEnd);
                   }
                   rvHistShowButton(rvHasAllocationHistory(projectEmployeeRoleId));
                   if (typeof hideLoader === "function") hideLoader();
               }

               function rvRelEsc(value) {
                   return String(value == null ? "" : value).replace(/[&<>"]/g, function (c) {
                       return ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c];
                   });
               }
               function rvRelApiList(endpoint, param) {
                   var url = "api/PM_ResourceAllocationView/" + endpoint;
                   var response = AJAXCallWithResult(url, JSON.stringify(param || {}), false);
                   var list = typeof rvUnwrapApiList === "function" ? rvUnwrapApiList(response) : [];
                   if (list && list.length) return list;
                   var data = typeof rvUnwrapApiData === "function" ? rvUnwrapApiData(response) : null;
                   if (data && typeof data === "object" && !Array.isArray(data)) return [data];
                   return list || [];
               }
               function rvRelField(row, names) {
                   if (!row || !names) return "";
                   var keys = Object.keys(row);
                   for (var n = 0; n < names.length; n++) {
                       var want = String(names[n]).toLowerCase();
                       for (var i = 0; i < keys.length; i++) {
                           if (String(keys[i]).toLowerCase() === want) {
                               var val = row[keys[i]];
                               return val == null ? "" : val;
                           }
                       }
                   }
                   return "";
               }
               function rvOpenHist() {
                   if (!rvState.editRow && !rvState.editPerId) {
                       rvNotify("error", "Open a resource first");
                       return;
                   }
                   rvState.histPage = 1;
                   LoadHistFilters();
                   LoadHistTrail();
                   rvHistBindFilters();

                   var canvas = document.getElementById("rvHistCanvas");
                   var backdrop = document.getElementById("rvHistBackdrop");
                   if (canvas) {
                       canvas.classList.add("open");
                       canvas.setAttribute("aria-hidden", "false");
                   }
                   if (backdrop) backdrop.classList.add("open");
                   document.body.classList.add("rv-hist-open");
               }
               function rvCloseHist() {
                   var canvas = document.getElementById("rvHistCanvas");
                   var backdrop = document.getElementById("rvHistBackdrop");
                   if (canvas) {
                       canvas.classList.remove("open");
                       canvas.setAttribute("aria-hidden", "true");
                   }
                   if (backdrop) backdrop.classList.remove("open");
                   document.body.classList.remove("rv-hist-open");
               }
               function rvHistRoleId() {
                   var row = rvState.editRow || {};
                   return rvState.editPerId || row.projectEmployeeRoleId || "";
               }
               function rvHistShowButton(show) {
                   var btn = document.getElementById("rvEditBtnHistory");
                   if (!btn) return;
                   if (show) btn.classList.add("is-visible");
                   else btn.classList.remove("is-visible");
               }
               function rvHasAllocationHistory(roleId) {
                   if (!roleId) return false;
                   var url = "api/PM_ResourceAllocationView/GetResourceAllocationAuditTrail";
                   var response = AJAXCallWithResult(url, JSON.stringify({
                       pageNumber: 1,
                       pageSize: 1,
                       projectEmployeeRoleID: String(roleId)
                   }), false);
                   var payload = typeof rvUnwrapApiData === "function" ? rvUnwrapApiData(response) : response;
                   if (!payload || typeof payload !== "object") return false;
                   var total = Number(payload.totalRecords != null ? payload.totalRecords : payload.TotalRecords) || 0;
                   if (total > 0) return true;
                   var records = Array.isArray(payload.records) ? payload.records
                       : (Array.isArray(payload.Records) ? payload.Records : []);
                   return records.length > 0;
               }
               function rvHistFillSelect(selectId, rows, keys, placeholder) {
                   var el = document.getElementById(selectId);
                   if (!el) return;
                   var current = el.value || "";
                   var ph = placeholder || "Select Option";
                   el.innerHTML = '<option value="">' + ph + "</option>";
                   (rows || []).forEach(function (r) {
                       var val = typeof rvRelField === "function" ? rvRelField(r, keys) : "";
                       if (!val) return;
                       var opt = document.createElement("option");
                       opt.value = String(val);
                       opt.textContent = String(val);
                       el.appendChild(opt);
                   });
                   if (current) el.value = current;
               }
               function LoadHistFilters() {
                   var roleId = rvHistRoleId();
                   var param = { projectEmployeeRoleID: roleId ? String(roleId) : null };
                   var fields = typeof rvRelApiList === "function"
                       ? rvRelApiList("GetResourceAllocationAuditModifiedField", param)
                       : [];
                   var people = typeof rvRelApiList === "function"
                       ? rvRelApiList("GetResourceAllocationAuditModifiedBy", param)
                       : [];
                   rvHistFillSelect("rvHistField", fields, ["ModifiedFieldName", "modifiedFieldName"], "Select ModifiedField");
                   rvHistFillSelect("rvHistBy", people, ["ModifiedBy", "modifiedBy"], "Select ModifiedBy");
               }
               function LoadHistTrail() {
                   var body = document.getElementById("rvHistBody");
                   var roleId = rvHistRoleId();
                   if (!roleId) {
                       if (body) body.innerHTML = '<tr><td colspan="5" class="rv-hist-empty">No data available in table</td></tr>';
                       rvHistRenderPager(0, 1);
                       return;
                   }
                   var fieldEl = document.getElementById("rvHistField");
                   var byEl = document.getElementById("rvHistBy");
                   var fieldVal = fieldEl ? String(fieldEl.value || "").trim() : "";
                   var byVal = byEl ? String(byEl.value || "").trim() : "";
                   var page = rvState.histPage > 0 ? rvState.histPage : 1;
                   var size = rvState.histPer > 0 ? rvState.histPer : 10;
                   var url = "api/PM_ResourceAllocationView/GetResourceAllocationAuditTrail";
                   var response = AJAXCallWithResult(url, JSON.stringify({
                       pageNumber: page,
                       pageSize: size,
                       projectEmployeeRoleID: String(roleId),
                       modifiedBy: byVal || null,
                       modifiedFieldName: fieldVal || null
                   }), false);
                   var payload = typeof rvUnwrapApiData === "function" ? rvUnwrapApiData(response) : response;
                   var records = [];
                   if (payload) {
                       if (Array.isArray(payload)) records = payload;
                       else if (Array.isArray(payload.records)) records = payload.records;
                       else if (Array.isArray(payload.Records)) records = payload.Records;
                   }
                   var total = 0;
                   var pages = 1;
                   if (payload && typeof payload === "object" && !Array.isArray(payload)) {
                       total = Number(payload.totalRecords != null ? payload.totalRecords : payload.TotalRecords) || 0;
                       pages = Number(payload.totalPages != null ? payload.totalPages : payload.TotalPages) || 0;
                       var current = Number(payload.currentPage != null ? payload.currentPage : payload.CurrentPage) || page;
                       if (current > 0) rvState.histPage = current;
                   }
                   if (!pages) pages = Math.max(1, Math.ceil(total / size));
                   pages = Math.max(1, Math.ceil(pages));
                   rvState.histTotal = total;
                   rvState.histPages = pages;
                   if (!body) return;
                   if (!records.length) {
                       body.innerHTML = '<tr><td colspan="5" class="rv-hist-empty">No data available in table</td></tr>';
                   } else {
                       body.innerHTML = records.map(function (row) {
                           var field = rvRelField(row, ["ModifiedFieldName", "modifiedFieldName"]) || "–";
                           var dateVal = rvRelField(row, ["ModifiedDate", "modifiedDate"]);
                           var dateText = dateVal && typeof rvFmtDashDate === "function" ? rvFmtDashDate(dateVal) : (dateVal || "–");
                           var oldVal = rvRelField(row, ["OldValue", "oldValue"]) || "–";
                           var newVal = rvRelField(row, ["NewValue", "newValue"]) || "–";
                           var by = rvRelField(row, ["ModifiedBy", "modifiedBy"]) || "–";
                           return "<tr>" +
                               "<td>" + rvRelEsc(field) + "</td>" +
                               "<td>" + rvRelEsc(dateText) + "</td>" +
                               "<td>" + rvRelEsc(oldVal) + "</td>" +
                               "<td>" + rvRelEsc(newVal) + "</td>" +
                               "<td>" + rvRelEsc(by) + "</td>" +
                               "</tr>";
                       }).join("");
                   }
                   rvHistRenderPager(total, pages);
               }
               function rvHistRenderPager(total, pages) {
                   var page = rvState.histPage > 0 ? rvState.histPage : 1;
                   var count = Math.max(1, pages || 1);
                   rvApplyPagerState("rvHistPagerControls", "rvHistTotalRecords", "rvHistBtnPrevious", "rvHistLinkPrevious", "rvHistBtnNext", "rvHistLinkNext", page, count, total);
               }
               function rvHistPrevPage() {
                   var prevLi = document.getElementById("rvHistBtnPrevious");
                   var prevLink = document.getElementById("rvHistLinkPrevious");
                   if ((prevLi && prevLi.classList.contains("fa-disabled")) || (prevLink && prevLink.classList.contains("disabled"))) return;
                   var page = rvState.histPage > 0 ? rvState.histPage : 1;
                   if (page <= 1) return;
                   rvHistGo(page - 1);
               }
               function rvHistNextPage() {
                   var nextLi = document.getElementById("rvHistBtnNext");
                   var nextLink = document.getElementById("rvHistLinkNext");
                   if ((nextLi && nextLi.classList.contains("fa-disabled")) || (nextLink && nextLink.classList.contains("disabled"))) return;
                   var page = rvState.histPage > 0 ? rvState.histPage : 1;
                   var pages = rvState.histPages > 0 ? rvState.histPages : 1;
                   if (page >= pages) return;
                   rvHistGo(page + 1);
               }
               function rvHistGo(page) {
                   var pages = rvState.histPages > 0 ? rvState.histPages : 1;
                   var next = Number(page) || 1;
                   if (next < 1) next = 1;
                   if (next > pages) next = pages;
                   rvState.histPage = next;
                   LoadHistTrail();
               }
               function rvHistBindFilters() {
                   var fieldEl = document.getElementById("rvHistField");
                   var byEl = document.getElementById("rvHistBy");
                   if (fieldEl && fieldEl.getAttribute("data-rv-hist-bound") !== "1") {
                       fieldEl.setAttribute("data-rv-hist-bound", "1");
                       fieldEl.onchange = function () {
                           rvState.histPage = 1;
                           LoadHistTrail();
                       };
                   }
                   if (byEl && byEl.getAttribute("data-rv-hist-bound") !== "1") {
                       byEl.setAttribute("data-rv-hist-bound", "1");
                       byEl.onchange = function () {
                           rvState.histPage = 1;
                           LoadHistTrail();
                       };
                   }
               }
           </script>

    </form>
</body>
</html>
