<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IR_Approval.aspx.vb" Inherits="PbNIT.IR_Approval" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Project Financial Approval")%> 
<head runat="server">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <style type="text/css">

        /*Added by Vishal Mane on 20/03/2026 to fix newly added changes from Phase I issue list*/
        .offcanvas-close-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            padding: 0;
            background: transparent;
            border: none;
            border-radius: 4px;
            color: #374151;
            font-size: 18px;
            line-height: 1;
            cursor: pointer;
            opacity: 0.6;
            transition: opacity 0.15s ease, background 0.15s ease;
            flex-shrink: 0;
        }

        .note-banner {
            background: #fff3cd;
            border: 1px solid #ffe69c;
            color: #664d03;
            border-radius: 4px;
            padding: 6px 10px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
        }
        .offcanvas-close-btn:hover {
            opacity: 1;
            background: rgba(0, 0, 0, 0.08);
        }
        .offcanvas-close-btn:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(19, 89, 166, 0.25);
        }
        /* Prevent checklist scroll from propagating to parent IR offcanvas */
        #offcvsViewChecklist .offcanvas-body {
            overscroll-behavior: contain;
        }
        /* Subtle borders for Checklist table and columns */
        #IR_ChecklistTbl {
            border: 1px solid #dee2e6;
            border-collapse: collapse !important;
            background: #fff;
        }
        #IR_ChecklistTbl th,
        #IR_ChecklistTbl td {
            border: 1px solid #e9ecef !important;
        }
        .ir-longtext-tip {
            cursor: default;
        }
        #IR_ItemsHeaderValue {
            display: block;
            max-width: 100%;
        }
        #IR_ItemsHeaderValue .ir-longtext-tip {
            display: inline-block;
            max-width: 100%;
            vertical-align: bottom;
        }
        /* Invoice Items section: outer frame + grid lines (same style as Checklist) */
        #offcvsIRPIR_Edit_Screen .invoiceTabs + .tab-content.mt-2 > .tab-pane.active {
            border: 1px solid #dee2e6;
            border-radius: 4px;
            background: #fff;
        }
        #IRPIR_EditDetailsTbl th,
        #IRPIR_EditDetailsTbl td,
        #IRPIR_EditDetailsTotalTbl td {
            border: 1px solid #e9ecef !important;
        }
        /* Parent IR offcanvas base opacity (background page only) */
        body.ir-parent-offcanvas-open::before {
            content: "";
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.22);
            z-index: 1040; /* below Bootstrap offcanvas (1045) */
            pointer-events: none;
        }
        /* Keep parent visibly dimmed when child offcanvas opens. */
        body.ir-parent-offcanvas-open.ir-child-offcanvas-open::after {
            content: "";
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.14);
            z-index: 1065; /* above parent offcanvas, below child offcanvas */
            pointer-events: none;
        }
        #offcvsViewChecklist,
        #offcvsIRShowHistory,
        #offcvsCustomerAddress,
        #offcvsIRShowHistory_MainPageNow {
            z-index: 1070;
        }
        /* Main page IR-PIR status history: stable columns, date on one line, comments ellipsis + tooltip */
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage {
            table-layout: fixed;
            width: 100% !important;
            border-collapse: collapse !important;
        }
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage th,
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage td {
            border: 1px solid #e9ecef !important;
            vertical-align: top;
        }
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage th:nth-child(1),
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage td:nth-child(1) {
            width: 24%;
        }
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage th:nth-child(2),
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage td:nth-child(2) {
            width: 18%;
        }
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage th:nth-child(3),
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage td:nth-child(3) {
            width: 22%;
            white-space: nowrap;
        }
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage th:nth-child(4),
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage td:nth-child(4) {
            width: 36%;
            overflow: hidden;
            text-align: center;
        }
        #offcvsIRShowHistory_MainPageNow #PIRstatushistoryTbl_MainPage .ir-status-hist-comment-tip {
            display: inline-block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            max-width: 100%;
            cursor: default;
            text-align: center;
        }
        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
        }
        body,
        .table,
        h5.pgtitle {
            font-family: 'Roboto', sans-serif;
        }
        body::-webkit-scrollbar {
            display: none;
        }
        .btn-default {
            background-color: #f4f4f4;
            color: #444;
            border-color: #ddd;
        }
        .btn-default:hover,
        .btn-default:active,
        .btn-default.hover {
            background-color: #e7e7e7;
        }
        /* Added By Vyankat B. on 24 th April 2026 for showing Change Status blue style only on hover */
        #ChangStatusEdtIRBtn {
            background-color: #fff !important;
            color: #0d5cab !important;
            border-color: #0d5cab !important;
            box-shadow: none !important;
        }
        #ChangStatusEdtIRBtn:hover {
            background-color: #0d5cab !important;
            color: #fff !important;
            border-color: #0d5cab !important;
        }
        #ChangStatusEdtIRBtn:focus,
        #ChangStatusEdtIRBtn:active,
        #ChangStatusEdtIRBtn.active,
        #ChangStatusEdtIRBtn:not(:disabled):not(.disabled):active,
        #ChangStatusEdtIRBtn:not(:disabled):not(.disabled):active:focus,
        #ChangStatusEdtIRBtn.show {
            background-color: #fff !important;
            color: #0d5cab !important;
            border-color: #0d5cab !important;
            box-shadow: none !important;
            outline: none !important;
        }
        #ChangStatusEdtIRBtn:focus:hover,
        #ChangStatusEdtIRBtn:active:hover,
        #ChangStatusEdtIRBtn.active:hover,
        #ChangStatusEdtIRBtn:not(:disabled):not(.disabled):active:hover,
        #ChangStatusEdtIRBtn:not(:disabled):not(.disabled):active:focus:hover,
        #ChangStatusEdtIRBtn.show:hover {
            background-color: #0d5cab !important;
            color: #fff !important;
            border-color: #0d5cab !important;
        }
        #ViewChecklistEditIRBtn,
        #ShowHisEditIRBtn {
            background-color: #fff !important;
            color: #0d5cab !important;
            border-color: #0d5cab !important;
            box-shadow: none !important;
        }
        #ViewChecklistEditIRBtn:hover,
        #ShowHisEditIRBtn:hover {
            background-color: #0d5cab !important;
            color: #fff !important;
            border-color: #0d5cab !important;
        }
        #ViewChecklistEditIRBtn:focus,
        #ViewChecklistEditIRBtn:active,
        #ViewChecklistEditIRBtn.active,
        #ViewChecklistEditIRBtn:not(:disabled):not(.disabled):active,
        #ViewChecklistEditIRBtn:not(:disabled):not(.disabled):active:focus,
        #ViewChecklistEditIRBtn.show,
        #ShowHisEditIRBtn:focus,
        #ShowHisEditIRBtn:active,
        #ShowHisEditIRBtn.active,
        #ShowHisEditIRBtn:not(:disabled):not(.disabled):active,
        #ShowHisEditIRBtn:not(:disabled):not(.disabled):active:focus,
        #ShowHisEditIRBtn.show {
            background-color: #fff !important;
            color: #0d5cab !important;
            border-color: #0d5cab !important;
            box-shadow: none !important;
            outline: none !important;
        }
        #ViewChecklistEditIRBtn:focus:hover,
        #ViewChecklistEditIRBtn:active:hover,
        #ViewChecklistEditIRBtn.active:hover,
        #ViewChecklistEditIRBtn:not(:disabled):not(.disabled):active:hover,
        #ViewChecklistEditIRBtn:not(:disabled):not(.disabled):active:focus:hover,
        #ViewChecklistEditIRBtn.show:hover,
        #ShowHisEditIRBtn:focus:hover,
        #ShowHisEditIRBtn:active:hover,
        #ShowHisEditIRBtn.active:hover,
        #ShowHisEditIRBtn:not(:disabled):not(.disabled):active:hover,
        #ShowHisEditIRBtn:not(:disabled):not(.disabled):active:focus:hover,
        #ShowHisEditIRBtn.show:hover {
            background-color: #0d5cab !important;
            color: #fff !important;
            border-color: #0d5cab !important;
        }
        /* Added By Vyankat B. on 27 th April 2026 for keeping status text and history icon in one line */
        .ir-status-inline {
            display: inline-flex;
            align-items: center;
            white-space: nowrap;
        }
        .ir-status-inline .statusBox {
            margin-right: 4px !important;
        }
        .ir-status-inline .fa-history {
            color: #0d5cab !important;
        }
        /* End of Added By Vyankat B. on 27 th April 2026 for keeping status text and history icon in one line */
        /* End of Added By Vyankat B. on 24 th April 2026 for showing Change Status blue style only on hover */
        .table thead tr th span {
            display: inline;
        }
        h5.pgtitle {
            margin: 0;
            font-weight: 600;
            color: #2563eb;
            font-size: 16px;
        }
        .pgheader-icon-wrap {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            min-width: 36px;
            border-radius: 8px;
            background: #2563eb;
            margin-right: 12px;
            flex-shrink: 0;
        }
        .pgheader-icon-wrap .pgheader-icon {
            font-size: 18px;
            color: #ffffff;
        }
        .pgheader-title-block {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .pgsubtitle {
            font-size: 13px;
            color: #6b7280;
            font-weight: 400;
            margin: 2px 0 0 0;
        }
        .form-group label {
            line-height: 1.2;
        }
        .custmodal .modal-content .modal-body {
            padding: 20px;
        }
        .dblock {
            display: block;
        }
        .mb-1 {
            margin-bottom: 10px
        }
        .toplinks {
            border-top: 1px solid #eee;
        }
        .topfltr .form-group select.form-control,
        .topfltr .form-group select.form-control {
            width: 200px
        }
        .rowheading {
            background: #e7edf0
        }
        .rowheading td {
            font-weight: 600; /* reduce heaviness of summary row */
        }

        tfoot tr {
            background: #e7edf0
        }

        tfoot tr td {
            font-weight: 600; /* slightly lighter footer totals */
        }

        .PIRinfo {
            margin-top: 0;
            border: none;
            padding: 0;
            border-radius: 4px
        }

        .PIRinfo .custom_chckbox label:before {
            margin-right: 10px
        }

        .PIRinfo a {
            text-decoration: underline
        }

        .PIRinfo label {
            text-align: right;
            padding-right: 0
        }

        .nostylebtn {
            background: none;
            border: none
        }

        .filedownload {
            margin-left: 10px
        }

        .filedownload img {
            margin-right: 10px
        }

        .filedownload .dropdown-menu>li>a {
            padding: 3px 10px
        }

        .dataTables_paginate a.paginate_button.disabled {
            cursor: no-drop
        }

        .dataTables_paginate a.paginate_button {
            border: 1px solid #e9e9e9;
            min-width: 40px;
            display: inline-block;
            text-align: center;
            height: 32px;
            padding: 8px;
            line-height: 14px;
            color: #1359a6;
            margin-left: -1px;
            cursor: pointer
        }

        .dataTables_paginate a.paginate_button.current {
            background: #1359a6;
            color: #fff;
            cursor: pointer
        }

        /* Custom pagination container for IRPIR_ApprovalTbl (styled similar to Training Plan) */
        .ir-pagination-container {
            background: #ffffff;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 0.75rem 1rem;
            gap: 1rem;
            margin-top: 0;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to keep main IR list pagination fixed at lower position */
        .ir-main-list-panel {
            min-height: calc(100vh - 140px);
            display: flex;
            flex-direction: column;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to keep main IR list pagination fixed at lower position */
        .ir-main-list-panel .ir-pagination-container {
            margin-top: auto;
            position: sticky;
            bottom: 0;
            z-index: 2;
            background: #fff;
        }

        .ir-pagination-container .ir-pagination-info {
            color: #374151;
            font-size: 0.875rem;
        }

        .ir-pagination-container .ir-pagination-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .ir-pagination-container .ir-page-btn {
            background: #ffffff;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            padding: 0.5rem 0.75rem;
            color: #3b82f6;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            position: relative;
        }

        .ir-pagination-container .ir-page-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Hide default DataTables pagination for custom-paginated grids (kept base styles above) */
        #IRPIR_ApprovalTbl_wrapper .dataTables_paginate,
        #IR_StatusHistoryTbl_wrapper .dataTables_paginate,
        #IRPIR_EditDetailsTbl_wrapper .dataTables_paginate,
        #IR_ChecklistTbl_wrapper .dataTables_paginate,
        #IRAShowHistoryTable_wrapper .dataTables_paginate,
        #PIRstatushistoryTbl_wrapper .dataTables_paginate,
        #PIRstatushistoryTbl_MainPage_wrapper .dataTables_paginate,
        #ContractAttachTbl_wrapper .dataTables_paginate {
            display: none !important;
        }

        /* Hide sorting indicator for PIR status history header */
        #PIRstatushistoryTbl thead th.sorting::before,
        #PIRstatushistoryTbl thead th.sorting::after,
        #PIRstatushistoryTbl thead th.sorting_asc::before,
        #PIRstatushistoryTbl thead th.sorting_asc::after,
        #PIRstatushistoryTbl thead th.sorting_desc::before,
        #PIRstatushistoryTbl thead th.sorting_desc::after,
        #PIRstatushistoryTbl_wrapper thead th.sorting::before,
        #PIRstatushistoryTbl_wrapper thead th.sorting::after,
        #PIRstatushistoryTbl_wrapper thead th.sorting_asc::before,
        #PIRstatushistoryTbl_wrapper thead th.sorting_asc::after,
        #PIRstatushistoryTbl_wrapper thead th.sorting_desc::before,
        #PIRstatushistoryTbl_wrapper thead th.sorting_desc::after {
            display: none !important;
            content: none !important;
        }

        /* Keep Invoice Items table width stable inside the edit offcanvas */
        #IRPIR_EditDetailsTbl,
        #IRPIR_EditDetailsTbl_wrapper,
        #IRPIR_EditDetailsTbl_wrapper .dataTables_scroll,
        #IRPIR_EditDetailsTbl_wrapper .dataTables_scrollHead,
        #IRPIR_EditDetailsTbl_wrapper .dataTables_scrollHeadInner,
        #IRPIR_EditDetailsTbl_wrapper .dataTables_scrollBody,
        #IRPIR_EditDetailsTbl_wrapper .dataTables_scrollFoot,
        #IRPIR_EditDetailsTbl_wrapper .dataTables_scrollFootInner {
            width: 100% !important;
        }

        /* Match RFI_IR_PIR invoice grid: avoid breaking numbers across lines; description may wrap */
        #IRPIR_EditDetailsTbl {
            table-layout: auto;
            min-width: 720px;
            border-collapse: collapse !important;
            border-spacing: 0;
        }

        #IRPIR_EditDetailsTbl th,
        #IRPIR_EditDetailsTbl td {
            vertical-align: middle;
        }

        #IRPIR_EditDetailsTbl th:nth-child(2),
        #IRPIR_EditDetailsTbl td:nth-child(2) {
            word-wrap: break-word;
            overflow-wrap: break-word;
            white-space: normal;
            text-align: center;
            max-width: 14rem;
        }

        #IRPIR_EditDetailsTbl th:nth-child(1),
        #IRPIR_EditDetailsTbl td:nth-child(1),
        #IRPIR_EditDetailsTbl th:nth-child(3),
        #IRPIR_EditDetailsTbl td:nth-child(3),
        #IRPIR_EditDetailsTbl th:nth-child(4),
        #IRPIR_EditDetailsTbl td:nth-child(4),
        #IRPIR_EditDetailsTbl th:nth-child(5),
        #IRPIR_EditDetailsTbl td:nth-child(5),
        #IRPIR_EditDetailsTbl th:nth-child(6),
        #IRPIR_EditDetailsTbl td:nth-child(6),
        #IRPIR_EditDetailsTbl th:nth-child(7),
        #IRPIR_EditDetailsTbl td:nth-child(7),
        #IRPIR_EditDetailsTbl th:nth-child(8),
        #IRPIR_EditDetailsTbl td:nth-child(8) {
            white-space: nowrap;
            word-wrap: normal;
            text-align: center;
        }

        #IRPIR_EditDetailsTbl th:nth-child(5),
        #IRPIR_EditDetailsTbl td:nth-child(5),
        #IRPIR_EditDetailsTbl th:nth-child(6),
        #IRPIR_EditDetailsTbl td:nth-child(6) {
            min-width: 7.5rem;
        }

        #IRPIR_EditDetailsTbl th:nth-child(7),
        #IRPIR_EditDetailsTbl td:nth-child(7),
        #IRPIR_EditDetailsTbl th:nth-child(8),
        #IRPIR_EditDetailsTbl td:nth-child(8) {
            min-width: 8.75rem;
        }

        /* Stabilize sticky header for Invoice Items table while scrolling */
        #IRPIR_EditDetailsTbl thead.stickyTblHeader,
        #IRPIR_EditDetailsTbl thead.stickyTblHeader tr,
        #IRPIR_EditDetailsTbl thead.stickyTblHeader th {
            position: static;
        }

        #IRPIR_EditDetailsTbl thead th {
            position: sticky;
            top: 0;
            z-index: 2;
            background: #fbfdff;
            vertical-align: middle;
        }

        #IRPIR_EditDetailsTbl_wrapper .dataTables_scrollBody {
            overflow-x: auto !important;
        }

        #IRPIR_EditDetailsTotalTbl {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse !important;
            border-spacing: 0;
            margin-top: -1px;
        }

        #IRPIR_EditDetailsTotalTbl td {
            background: #e7edf0;
            font-weight: 600;
            vertical-align: middle;
            box-shadow: 0 -1px 0 #d9e2ea;
            padding: 10px 12px;
        }

        #IRPIR_EditDetailsTotalTbl td:nth-child(1) {
            text-align: left;
        }

        #IRPIR_EditDetailsTotalTbl td:nth-child(6),
        #IRPIR_EditDetailsTotalTbl td:nth-child(7),
        #IRPIR_EditDetailsTotalTbl td:nth-child(8) {
            white-space: nowrap;
            text-align: center;
        }

        .ui-datepicker {
            z-index: 9999 !important;
        }

        .pr0 {
            padding-right: 0;
        }

        .custom_radio input[type="radio"] {
            display: none
        }

        .custom_radio input[type="radio"]+label span {
            display: inline-block;
            width: 15px;
            height: 15px;
            background: transparent;
            vertical-align: middle;
            border: 1px solid #464a4c;
            border-radius: 50%;
            padding: 2px;
            margin: 0 12px
        }

        .custom_radio input[type="radio"]:checked+label span {
            width: 15px;
            height: 15px;
            background: #464a4c;
            background-clip: content-box
        }

        .custom_radio span {
            margin: 0px 10px 0px 0px !important;
        }

        table tr th,
        table tr td {
            text-align: center !important;
            border-color: #e4e7f0; /* subtle row/column grid lines similar to Profitability page */
        }

        table tr th:last-child,
        table tr td:last-child {
            text-align: center;
        }

        .modalDTtabl {
            width: 100% !important;
        }

        .stastusbtn {
            display: block;
            cursor: auto;
        }

        .actionTD a {
            margin: 0px 5px;
        }
        .custom_chckbox label:before {
            margin-right: 0;
        }
        .table-fixed-header thead tr th,
        .table thead tr th {
            font-size: 13px; /* slightly larger for better readability */
        }
        /* .statusDiv {
            width: unset;
        } */
        .bootstrap-select .dropdown-menu{
            max-width: 100%;
        }
        /* Scrollbars for bootstrap-select dropdown list (Project and other selectpickers) */
        .bootstrap-select .dropdown-menu .inner,
        .bootstrap-select .inner[role="listbox"] {
            overflow-y: auto;   /* Y scroller - vertical scroll when many options */
            overflow-x: hidden;   /* X scroller - horizontal scroll when names are long */
            max-height: 300px;  /* optional: cap height so Y scroll appears */
        }
        .legendsDiv label{
            font-size: 12px;
        }
        .statusDiv a{
            color: unset;
        }

        /* Added or Modified by Vishal Mane on 27/03/2026 to support child canvas over parent offcanvas */
        .contract-details-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.35);
            z-index: 1078;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.2s ease;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to support child canvas over parent offcanvas */
        .contract-details-backdrop.open {
            opacity: 1;
            pointer-events: auto;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to support child canvas over parent offcanvas */
        .contract-details-canvas {
            position: fixed;
            top: 0;
            right: 0;
            width: 70%;
            height: 100vh;
            z-index: 1080;
            background: #fff;
            overflow-y: auto;
            box-shadow: -8px 0 24px rgba(0,0,0,.2);
            transform: translateX(100%);
            transition: transform 0.25s ease;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to support child canvas over parent offcanvas */
        .contract-details-canvas.open {
            transform: translateX(0);
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to style child canvas like IR Approval header and add top spacing */
        #ShowContractDtlsModal .modal-header {
            background: #f0f0f0 !important;
            color: #5361d9 !important;
            border-bottom: 1px solid #d9dde7 !important;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to style child canvas like IR Approval header and add top spacing */
        #ShowContractDtlsModal .modal-header .modal-title {
            font-weight: 600;
            margin: 0;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to style child canvas like IR Approval header and add top spacing */
        #ShowContractDtlsModal .modal-body {
            padding-top: 22px !important;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to style child canvas like IR Approval header and add top spacing */
        #ShowContractDtlsModal .Init_acordian_panel {
            margin-top: 0 !important;
            padding-top: 8px !important;
        }
        /* Added or Modified by Vishal Mane on 27/03/2026 to keep child panel background visually same as parent IR Approval section */
        #ShowContractDtlsModal .offcanvas-body {
            background: #ffffff;
            padding-top: 0 !important;
        }        
    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
     <%If m_blnViewAccess = True Then%>
    <div class="bgwhite">
        <div class="container-fluid py-2 graybg d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center">
                <span class="pgheader-icon-wrap">
                    <%--<i class="fas fa-file-invoice-dollar pgheader-icon"></i>--%>
                    <i class="fas fa-file-invoice pgheader-icon"></i>
                </span>
                <div class="pgheader-title-block">
                    <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ProjectFinancialsApproval")%></h5>
                    <div class="pgsubtitle"><%=MyBase.GetResourceString("C_ManageInvoiceRequestsApprovalsBillingStatus")%></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>

        <!--Added by Aditya J. on 24-04-2026 for adding note for default filter-->
        <div class="container-fluid px-3">
      <%--  <div class="text mb-2" style="font-size: 12px; color:#6c757d;">
            <b class="alignmt">Note :</b>
            <span class="alignmt">
                Default filter is set to <strong>"Submitted"</strong>.
            </span>
        </div>--%>

              <div class="text mb-2" style="font-size: 12px;">
                                <span class="note-banner">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <span class="note-title">Note :</span>
                                    <span>Default filter is set to <strong>"Submitted"</strong>.</span>
                                </span>
                            </div>

          


    </div>
        <!--End of Added by Aditya J. on 24-04-2026 for adding note for default filter-->

        <!--filter panel-->
        <div id="IR_Filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="nav-item dropdown" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_MyFilters")%>" style="display:none;">
                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"
                                aria-expanded="false"><%=MyBase.GetResourceString("C_MyFilters")%> </a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip"
                                            data-bs-placement="bottom" id="project2" type="checkbox" name="project2"
                                            onchange="cbChange(this)" title="" />
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" class="checkmark"
                                            title="<%=MyBase.GetResourceString("C_SetDefaultFilter")%>"></span>
                                    </label>
                                    <label>
                                        <span for="project2" class="radiotextsty filtername"><%=MyBase.GetResourceString("C_Project2and3")%></span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproOne" type="checkbox" name="" />
                                            <label data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" for="IssueselproOne"
                                                title="<%=MyBase.GetResourceString("C_ApplyFilter")%>"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16"
                                                data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" title="<%=MyBase.GetResourceString("C_EditFilter")%>" />
                                        </span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" class="far fa-trash-alt"
                                                title="<%=MyBase.GetResourceString("C_DeleteFilter")%>"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip"
                                            data-bs-placement="bottom" id="task" type="checkbox" name="task"
                                            onchange="cbChange(this)" title="" />
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" class="checkmark"
                                            title="<%=MyBase.GetResourceString("C_SetDefaultFilter")%>"></span>
                                    </label>
                                    <label>
                                        <span for="task" class="radiotextsty"><%=MyBase.GetResourceString("C_TaskAndMilestones")%></span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproTwo" type="checkbox" name="" />
                                            <label data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" for="IssueselproTwo"
                                                title="<%=MyBase.GetResourceString("C_ApplyFilter")%>"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16"
                                                data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" title="<%=MyBase.GetResourceString("C_EditFilter")%>" />
                                        </span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" class="far fa-trash-alt"
                                                title="<%=MyBase.GetResourceString("C_DeleteFilter")%>"></i></span>
                                    </div>
                                </li>
                                <li>
                                    <label class="customradio">
                                        <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip"
                                            data-bs-placement="bottom" id="groupcompany" type="checkbox"
                                            name="groupcompany" onchange="cbChange(this)" title="" />
                                        <span data-bs-toggle="tooltip" data-bs-placement="right" class="checkmark"
                                            title="<%=MyBase.GetResourceString("C_SetDefaultFilter")%>"></span>
                                    </label>
                                    <label>
                                        <span for="groupcompany" class="radiotextsty"><%=MyBase.GetResourceString("C_ForGroupCompany")%></span>
                                    </label>

                                    <div class="issfilter_actiondropdown">
                                        <div class="custom_chckbox_markblue">
                                            <input id="IssueselproThree" type="checkbox" name="" />
                                            <label data-bs-container="body" data-bs-toggle="tooltip"
                                                data-bs-placement="bottom" for="IssueselproThree"
                                                title="<%=MyBase.GetResourceString("C_ApplyFilter")%>"></label>
                                        </div>
                                        <span class="edit_filter">
                                            <img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16"
                                                data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" title="<%=MyBase.GetResourceString("C_EditFilter")%>" />
                                        </span>
                                        <span><i data-bs-toggle="tooltip" data-bs-container="body"
                                                data-bs-placement="bottom" class="far fa-trash-alt"
                                                title="<%=MyBase.GetResourceString("C_DeleteFilter")%>"></i></span>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item active" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_BasicFilters")%>">
                            <a class="nav-link" href="#IR_BasicFilters" data-bs-toggle="tab" aria-expanded="true"><%=MyBase.GetResourceString("C_BasicFilters")%></a>
                        </li>
                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="IR_BasicFilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal"
                                        data-bs-target="#Issuesavefilter" data-bs-dismiss="modal"><%=MyBase.GetResourceString("C_SaveAndApply")%></button>
                                    <button class="btn btnyellow"><%=MyBase.GetResourceString("C_Apply")%></button>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-sm-8">
                                        <div class="IRPIR_filterSec pt-3">
                                            <div class="row">
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="ProjectNameFilter" class="text-end"><%=MyBase.GetResourceString("C_ProjectName")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <select class="selectpicker" data-live-search="true"
                                                                id="ProjectNameFilter">                                                                
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="CustomerNameFilter" class="text-end"><%=MyBase.GetResourceString("C_CustomerName")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <select class="selectpicker" data-live-search="true"
                                                                id="CustomerNameFilter">                                                                
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="IRID_Filter" class="text-end"><%=MyBase.GetResourceString("C_IRID")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <input id="IRID_Filter" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="IRPIR_Filter" class="text-end"><%=MyBase.GetResourceString("C_IRPIR")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <select class="selectpicker" data-live-search="true"
                                                                id="IRPIR_Filter">                                                                
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">                                                            
                                                            <label for="RaisedOnDateFilter" class="text-end"><%=MyBase.GetResourceString("C_RaisedOn")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <div class="input-group">
                                                                <input id="RaisedOnDateFilter" class="form-control">
                                                                <span class="input-group-btn">
                                                                    <button class="btn btncalendar" type="button"><i
                                                                            class="fas fa-calendar-alt"></i></button>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">                                                            
                                                            <label for="AmountFilter" class="text-end"><%=MyBase.GetResourceString("C_Amount")%></label>
                                                       </div>
                                                        <div class="col-sm-8">
                                                            <div class="row">
                                                                <div class="col-sm-6 pe-0">
                                                                    <input id="AmountFilter" type="text"
                                                                        class="form-control" />
                                                                </div>
                                                                <div class="col-sm-6 ps-0">
                                                                    <select class="selectpicker" data-live-search="true"
                                                                        id="CurrencyFilter">                                                                        
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="StatusFilter" class="text-end"><%=MyBase.GetResourceString("C_Status")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <select class="selectpicker statusColors" aria-label="Select Status"
                                                                data-live-search="true" id="StatusFilter">
                                                                <option><%=MyBase.GetResourceString("C_SelectStatus")%></option>
                                                                <option data-content="<span class='statusBox statusApproved mx-2'>&nbsp;</span> Approved"> </option>
                                                                <option data-content="<span class='statusBox statusCancelled mx-2'>&nbsp;</span> Cancelled"> </option>
                                                                <option data-content="<span class='statusBox statusRejected mx-2'>&nbsp;</span> Rejected"></option>
                                                                <option data-content="<span class='statusBox statusSubmitted mx-2'>&nbsp;</span> Submitted"></option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-4 d-flex justify-content-end">
                                                            <label for="IR_TypeFilter" class="text-end"><%=MyBase.GetResourceString("C_IRType")%></label>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <select class="selectpicker" aria-label="Select Type"
                                                                data-live-search="true" id="IR_TypeFilter">                                                                
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="amtFilSection pt-3">
                                            <div class="row">
                                                <div class="col-12 col-sm-12 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-6 d-flex justify-content-end">
                                                            <label for="AmountCB_Filter" class="text-end"><%=MyBase.GetResourceString("C_AmountCompanyBase")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <input id="AmountCB_Filter" type="text" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-6 d-flex justify-content-end">
                                                            <label for="EquivAmountFilter" class="text-end"><%=MyBase.GetResourceString("C_EquivAmount")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <input id="EquivAmountFilter" type="text"
                                                                class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-12 form-group mb-3">
                                                    <div class="row">
                                                        <div class="col-sm-6 d-flex justify-content-end">
                                                            <label for="Fil_EquivAmount" class="text-end"><%=MyBase.GetResourceString("C_AmountWillBeIn")%></label>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <label id="AMtCurrencyVal">
                                                                INR (<span class="INRCurncy"></span>)
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>

                <div class="clearfix"></div>
            </div>
        </div>
        <div class="clearfix"></div>

    <div class="content pt-0 ir-main-list-panel">
            <!-- Top filters -->
            <div class="py-2 my-2 col-sm-12 toplinks lightGrey topFilters">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                             <div class="col-sm-3">
                                <div class="row">
                                    <div class="col-sm-3 d-flex justify-content-end">
                                        <label for="cboCustomer"><%=MyBase.GetResourceString("C_Customer")%></label>
                                    </div>
                                    <div class="col-sm-9">
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "usp_Whizible2_Sel_Customer",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,, ) %>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="row">
                                    <div class="col-sm-3 d-flex justify-content-end">
                                        <label for="cboProject"><%=MyBase.GetResourceString("C_Project")%></label>
                                    </div>
                                    <div class="col-sm-9">
                                     <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='selectpicker' data-live-search='true'",,, ) %>--%>
                                     <%CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Whizible2_Sel_AccessibleProjects_LoginResource " & Session("intUserID") & ",'" & Session("LoginType") & "', 1, 0,'[Over] = ''0''','ProjectName ASC'",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,, ) %>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="col-sm-3">
                                <div class="row">
                                    <div class="col-sm-4 d-flex justify-content-end">
                                        <label for="cboIRType"><%=MyBase.GetResourceString("C_IRType")%></label>
                                    </div>
                                    <div class="col-sm-8">                                        
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboIRType", "usp_Whizible2_Sel_Type_IR_PIR",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,, ) %>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="row">
                                    <div class="col-sm-3 d-flex justify-content-end">
                                        <label for="cboStatus"><%=MyBase.GetResourceString("C_Status")%></label>
                                    </div>
                                    <div class="col-sm-9">
                                        <%--<%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_Sel_Status",,, "class='selectpicker' data-live-search='true'",,,) %>--%>
                                        <%'CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_Sel_tbl_PM_RFIStatus",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,,) %>
                                        <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_Whizible2_Sel_tbl_PM_RFIStatus_Approval",,, "onchange='PlotProjectonChange();' class='selectpicker' data-live-search='true'",,,) %>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<div class="col-sm-1">
                        <button class="btn btnyellow me-2" id="showIRFilterBtn" data-bs-toggle="tooltip" data-bs-original-title="<%=MyBase.GetResourceString("C_Show")%>" onclick="ShowStaticFilterData();"><%=MyBase.GetResourceString("C_Show")%></button>
                    </div>--%>
                </div>
            </div>
            <!-- Legends for Currency start here -->
            <div class="legendsDiv">
                <div class="row align-items-center py-2">
                    <div class="col-sm-5 col-md-7 col-lg-8">
                        &nbsp;
                    </div>
                    <div class="col-sm-7 col-md-5 col-lg-4 text-end">
                        <div class="row">
                            <div class="col-sm-6">
                                <label class="font-weight-500">Corp -</label>
                                <label><%=MyBase.GetResourceString("C_CorporateBase")%></label>
                            </div>
                            <div class="col-sm-6">
                                <label class="font-weight-500">Comp -</label>
                                <label><%=MyBase.GetResourceString("C_CompanyBase")%></label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Legends for Currency end here -->
            <!-- IR Approval List View starts here -->
        <style>
            /* Summary cards */
            #irSummaryCards .ir-card{border-radius:12px;padding:7px 9px;display:flex;align-items:center;gap:10px;box-shadow:0 6px 18px rgba(15,37,70,0.03);border:1px solid rgba(0,0,0,0.04);background:transparent;}
            #irSummaryCards .ir-card .icon{width:54px;height:49px;border-radius:14px;display:flex;align-items:center;justify-content:center;flex:0 0 41px;background:transparent;position:relative}
            /* small inner square for icon contrast */
            #irSummaryCards .ir-card .icon:before{content:'';position:absolute;inset:10px;border-radius:8px;background:#ffffff;box-shadow:0 1px 4px rgba(15,37,70,0.04)}
            #irSummaryCards .ir-card .icon i{font-size:20px;position:relative;z-index:2}
            #irSummaryCards .ir-card .label{font-size:13px;color:#6c757d;margin:0 0 6px 0}
            #irSummaryCards .ir-card .value{font-size:24px;font-weight:700;margin:0}
            /* Full-card gradients (use !important to override theme) */
            #irSummaryCards .card-blue{background:linear-gradient(90deg,#eef6ff,#f6fbff) !important;border-color:rgba(20,98,179,0.08) !important}
            #irSummaryCards .card-blue .icon:before{background:linear-gradient(90deg,#eaf4ff,#f7fbff) !important}
            #irSummaryCards .card-blue .icon i{color:#1967d2 !important}
            #irSummaryCards .card-blue .label{color:#1c4f87 !important}
            #irSummaryCards .card-blue .value{color:#0f3f73 !important}

            /* Unique Month card (intentionally not blue like Submitted) */
            #irSummaryCards .card-month{background:linear-gradient(90deg,#f1fbf8,#f8fefd) !important;border-color:rgba(0,136,125,0.16) !important}
            #irSummaryCards .card-month .icon:before{background:linear-gradient(90deg,#e8f8f4,#f5fdfb) !important}
            #irSummaryCards .card-month .icon i{color:#00887d !important}
            #irSummaryCards .card-month .label{color:#1f6f68 !important}
            #irSummaryCards .card-month .value{color:#0b6f65 !important}

            #irSummaryCards .card-green{background:linear-gradient(90deg,#edf6fb,#f7fbfe) !important;border-color:rgba(60,141,188,0.16) !important}
            #irSummaryCards .card-green .icon:before{background:linear-gradient(90deg,#e4f1f8,#f4fafe) !important}
            #irSummaryCards .card-green .icon i{color:#3c8dbc !important}
            #irSummaryCards .card-green .label{color:#3a7697 !important}
            #irSummaryCards .card-green .value{color:#2f7ea9 !important}

            #irSummaryCards .card-yellow{background:linear-gradient(90deg,#fffaf0,#fffcf5) !important;border-color:rgba(179,107,0,0.06) !important}
            #irSummaryCards .card-yellow .icon:before{background:linear-gradient(90deg,#fff8eb,#fffdf5) !important}
            #irSummaryCards .card-yellow .icon i{color:#b36b00 !important}
            #irSummaryCards .card-yellow .label{color:#8a6a1a !important}
            #irSummaryCards .card-yellow .value{color:#b36b00 !important}

            #irSummaryCards .card-light{background:linear-gradient(90deg,#f7ffe0,#fcffef) !important;border-color:rgba(164,208,0,0.22) !important}
            #irSummaryCards .card-light .icon:before{background:linear-gradient(90deg,#f2ffd0,#fbffe8) !important}
            #irSummaryCards .card-light .icon i{color:#7aa300 !important}
            #irSummaryCards .card-light .label{color:#6e9400 !important}
            #irSummaryCards .card-light .value{color:#6b8f00 !important}

            #irSummaryCards .card-red{background:linear-gradient(90deg,#fff3f4,#fff7f8) !important;border-color:rgba(194,31,58,0.06) !important}
            #irSummaryCards .card-red .icon:before{background:linear-gradient(90deg,#fff1f2,#fff8f9) !important}
            #irSummaryCards .card-red .icon i{color:#c21f3a !important}
            #irSummaryCards .card-red .label{color:#9b2b39 !important}
            #irSummaryCards .card-red .value{color:#c21f3a !important}

            /* Unique Cancelled card (different from Rejected) */
            #irSummaryCards .card-cancel{background:linear-gradient(90deg,#f4f5f7,#fbfcfd) !important;border-color:rgba(95,107,122,0.10) !important}
            #irSummaryCards .card-cancel .icon:before{background:linear-gradient(90deg,#eff1f4,#f9fafb) !important}
            #irSummaryCards .card-cancel .icon i{color:#5f6b7a !important}
            #irSummaryCards .card-cancel .label{color:#4e5968 !important}
            #irSummaryCards .card-cancel .value{color:#5f6b7a !important}

            /* Table compact styling */
            .newTblStyle{background:#fff;border-radius:10px;border:1px solid #eef2f5}
            .newTblStyle thead th{background:#fbfdff;border-bottom:1px solid #eef2f5;color:#6b7a90;font-weight:600;padding:12px}
            .newTblStyle th, .newTblStyle td{padding:10px 12px;vertical-align:middle}
            .newTblStyle tbody tr{height:54px}
            .newTblStyle tbody tr:hover{background:#fafcff}

            /* Status badges */
            .newTblStyle .ir-status-badge{display:inline-block;padding:6px 12px;border-radius:20px;font-size:13px;font-weight:600;min-width:86px;text-align:center}
            .newTblStyle .ir-status-badge:before{content:'';display:inline-block;width:8px;height:8px;border-radius:50%;margin-right:8px;vertical-align:middle}
            .newTblStyle .ir-status-Submitted{background:#eaf7ee !important;color:#238b4b !important}
            .newTblStyle .ir-status-Submitted:before{background:#238b4b !important}
            .newTblStyle .ir-status-Pending{background:#fff7ea !important;color:#b37a00 !important}
            .newTblStyle .ir-status-Pending:before{background:#b37a00 !important}
            .newTblStyle .ir-status-Approved{background:#eaf4ff !important;color:#1672b8 !important}
            .newTblStyle .ir-status-Approved:before{background:#1672b8 !important}
            .newTblStyle .ir-status-Rejected{background:#fff0f2 !important;color:#c21f3a !important}
            .newTblStyle .ir-status-Rejected:before{background:#c21f3a !important}

            /* IR/PIR pill */
            .newTblStyle .irp-pill{display:inline-block;padding:6px 9px;border-radius:8px;background:linear-gradient(90deg,#eef8ff,#f7fbff) !important;color:#1462b3 !important;font-weight:700;font-size:13px;border:1px solid rgba(20,98,179,0.08) !important}
            .kpis{
            margin-top: 12px;
            display: grid;
            grid-template-columns: repeat(6, minmax(0, 1fr));
            gap: 10px;
            width: 100%;
            }
            .kpis > div{
            min-width: 0;
            }
       </style>
            <div class="kpis mb-3" id="irSummaryCards">
                <%--<div class="">
                    <div class="ir-card card-month">
                        <div class="icon"><i class="fas fa-calendar-alt fa-lg"></i></div>
                        <div>
                            <p class="label">Total Requests</p>
                            <p class="value" id="irTotalCount"></p>
                        </div>
                    </div>
                </div>--%>
                <div class="">
                    <div class="ir-card card-blue">
                        <div class="icon"><i class="fas fa-file-invoice fa-lg"></i></div>
                        <div>
                            <p class="label"></p>
                            <p class="value" id="txtMonthData"></p>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="ir-card card-green">
                        <div class="icon"><i class="fas fa-check fa-lg"></i></div>
                        <div>
                            <p class="label"><%=MyBase.GetResourceString("C_Submitted")%></p>
                            <p class="value" id="irSubmittedCount"></p>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="ir-card card-yellow">
                        <div class="icon"><i class="fas fa-clock fa-lg"></i></div>
                        <div>
                            <p class="label"><%=MyBase.GetResourceString("C_Pending")%></p>                           
                            <p class="value" id="irPendingCount"></p>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="ir-card card-light">
                        <div class="icon"><i class="fas fa-thumbs-up fa-lg"></i></div>
                        <div>                            
                            <p class="label"><%=MyBase.GetResourceString("C_Approved")%></p>
                            <p class="value" id="irApprovedCount"></p>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="ir-card card-red">
                        <div class="icon"><i class="fas fa-times-circle fa-lg"></i></div>
                        <div>
                            <p class="label"><%=MyBase.GetResourceString("C_Rejected")%></p>
                            <p class="value" id="irRejectedCount"></p>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="ir-card card-cancel">
                        <div class="icon"><i class="fas fa-ban fa-lg"></i></div>
                        <div>
                            <p class="label"><%=MyBase.GetResourceString("C_Cancelled1")%></p>
                            <p class="value" id="irCancelledCount"></p>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                function transformTableBadges(){
                    $('#IRPIR_ApprovalTbl tbody tr').each(function(){
                        // IR/PIR pill in 2nd column
                        var $col2 = $(this).find('td:nth-child(2) a');
                        if($col2.length){
                            var txt = $col2.text().trim();
                            if(txt.length){
                                var pill = $('<span>').addClass('irp-pill').text(txt);
                                $col2.replaceWith(pill);
                            }
                        }

                        // Status label => colored badge
                        var $lbl = $(this).find('.statusDiv label, .statusDiv .crsrLink');
                        if($lbl.length){
                            var s = $lbl.text().trim();
                            var cls = 'ir-status-';
                            if(/submitted/i.test(s)) cls += 'Submitted';
                            else if(/pending/i.test(s)) cls += 'Pending';
                            else if(/approved/i.test(s)) cls += 'Approved';
                            else if(/rejected/i.test(s)) cls += 'Rejected';
                            else cls = '';
                            if(cls){
                                var badge = $('<span>').addClass('ir-status-badge').addClass(cls).text(s);
                                $lbl.replaceWith(badge);
                            }
                        }
                    });
                }
                function updateIRCounts(){
                    var rows = $('#IRPIR_ApprovalTbl tbody tr');
                    var total = rows.length;
                    var submitted = 0, pending = 0, approved = 0, rejected = 0;
                    rows.each(function(){
                        var txt = $(this).find('.ir-status-badge').text().trim().toLowerCase();
                        if(txt.indexOf('submitted') !== -1) submitted++;
                        else if(txt.indexOf('pending') !== -1) pending++;
                        else if(txt.indexOf('approved') !== -1) approved++;
                        else if(txt.indexOf('rejected') !== -1) rejected++;
                    });
                    //$('#irTotalCount').text(total);
                    $('#irSubmittedCount').text(submitted);
                    $('#irPendingCount').text(pending);
                    $('#irApprovedCount').text(approved);
                    $('#irRejectedCount').text(rejected);
                    $('#irCancelledCount').text(cancelled);
                }
                //$(document).ready(function(){
                //    transformTableBadges();
                //    updateIRCounts();
                //    // Recompute counts and re-transform if table data is reloaded via AJAX elsewhere
                //    $(document).on('click', '#showIRFilterBtn, .page-link, .dataTableRefresh', function(){
                //        setTimeout(function(){ transformTableBadges(); updateIRCounts(); }, 250);
                //    });
                //});
            </script>

            <table id="IRPIR_ApprovalTbl" class="table table-stripped newTblStyle" style="width:100%;">
                <thead>
                    <tr>
                        <th><%=MyBase.GetResourceString("C_IRID")%></th>
                        <th><%=MyBase.GetResourceString("C_IRPIR")%></th>
                        <th class="col-sm-2"><%=MyBase.GetResourceString("C_ProjectName")%></th>
                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_CustomerName")%></th>
                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_IRType")%></th>
                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_RaisedOn")%></th>
                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_Amount")%></th>                        
                        <th id="txtCorpCurrencyCode" class="col-sm-2"></th>
                        <th id="txtCompCurrencyCode" class="col-sm-2"></th>
                        <th class="col-sm-1"><%=MyBase.GetResourceString("C_Status")%></th>
                        <th><%=MyBase.GetResourceString("C_ChangeStatus")%></th>
                        <th><i class="fas fa-print text-danger"></i>&nbsp; <%=MyBase.GetResourceString("C_IRReport")%></th>
                    </tr>
                </thead>
                <tbody id="IRPIR_ApprovalTbl_Body">
                
                </tbody>
            </table>
            <!-- Custom pagination for IRPIR_ApprovalTbl (styled similar to Training Plan) -->
            <div class="ir-pagination-container">
                <div class="ir-pagination-info">
                    <span id="irTotalRecordsText"></span>
                </div>
                <div class="ir-pagination-buttons">
                    <button id="irPrevPageBtn" type="button" class="ir-page-btn" title="Previous Page">
                        <i class="fas fa-angle-double-left"></i>
                    </button>
                    <button id="irNextPageBtn" type="button" class="ir-page-btn" title="Next Page">
                        <i class="fas fa-angle-double-right"></i>
                    </button>
                </div>
            </div>
            <!-- IR Approval List View end here -->
        </div>

        <!-- Show IR Approval Details Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="true" tabindex="-1"
            id="offcvsIRPIR_Edit_Screen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center justify-content-between ">
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IRApproval")%></h5>              
                                <button type="button" class="offcanvas-close-btn"
                                    data-bs-dismiss="offcanvas" aria-label="Close" title="Close">
                                    &#x2715;               
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="IRPIR_DetailEditTab" class="IRPIR_EditDetailinfo">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="row d-flex">
                                <div class="col-sm-3 text-end pe-0">
                                    <label for="IR_ID_Filter"><%=MyBase.GetResourceString("C_IRID")%> :</label>
                                </div>
                                <div class="col-sm-4">
                                     <select id="IR_ID_Filter" class="selectpicker form-control" data-live-search="true" data-width="100%"></select>
                                </div>
                                <div class="col-sm-5">
                                    <a href="javascript:;" id="showEditIRBtn" class="textUndrln" data-bs-toggle="tooltip"
                                        title="<%=MyBase.GetResourceString("C_Show")%>"><%=MyBase.GetResourceString("C_Show")%></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8 d-flex justify-content-end">
                            <div class="nextBtnDiv">
                                <%If m_blnEditAccess = True Or m_blnAddAccess = True Then%>
                                <button class="btn borderbtn" id="ChangStatusEdtIRBtn" data-bs-toggle="modal"
                                    data-bs-target="#ChangeIRPIR_StatusModal" onclick="ChangeStatusRFIIDEdit()"><span data-bs-toggle="tooltip"
                                        title="Change Status">Change Status</span></button>
                                <button class="btn borderbtn" id="ViewChecklistEditIRBtn" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcvsViewChecklist"><span data-bs-toggle="tooltip"
                                        title="View Checklist">View Checklist</span></button>
                                <button class="btn borderbtn" id="ShowHisEditIRBtn" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcvsIRShowHistory">                                    
                                    <span data-bs-toggle="tooltip"
                                        title="Show History">Show History</span></button>
                                <%End If %>
                            </div>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-sm-12 text-end">
                            <label class="form-label ">(<font color="red">*</font>
                                Mandatory)</label>
                        </div>
                    </div>
                    <div class="accordion Off_acordian_panel my-3 " id="EditDetailsAcc">
                        <div class="accordion-item mb-3">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#EditDetailsTab" aria-expanded="true">
                                    <%=MyBase.GetResourceString("C_Details")%>
                                </button>
                            </h2>
                            <div id="EditDetailsTab" class="accordion-collapse collapse show" data-bs-parent="#EditDetailsAcc">
                                <div class="accordion-body">
                                    <div class="d-flex justify-content-around mb-4">
                                        <div>
                                            <input type="radio" id="IR_Edit" name="IRPIR_Edit" value="IR" disabled>
                                            <label for="IR_Edit"><%=MyBase.GetResourceString("C_IRInvoiceRequest")%></label><br>
                                        </div>
                                        <div>
                                            <input type="radio" id="PIR_Edit" name="IRPIR_Edit" value="PIR" disabled>
                                            <label for="PIR_Edit"><%=MyBase.GetResourceString("C_PIRProformaInvoiceRequest")%></label><br>
                                        </div>
                                    </div>
                                    <div class="editContent">
                                        <div class="row form-group mt-3">
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label><%=MyBase.GetResourceString("C_Type")%>:</label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="IR_TypeValue">Invoicing</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label><%=MyBase.GetResourceString("C_CreditDays")%>:</label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="creditDaysValue">30</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label><%=MyBase.GetResourceString("C_Customer")%>:</label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <div>
                                                            <label id="customerValue">British Telecommunication</label>
                                                        </div>
                                                        <div>
                                                            <a href="javascript:;" id="AddressEditIRBtn" class="linkTxt textUndrln"
                                                                data-bs-toggle="offcanvas"
                                                                data-bs-target="#offcvsCustomerAddress">
                                                                <span data-bs-toggle="tooltip"
                                                                    title="Address">Address</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label>Currency:</label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="currencyValue">INR (<span class="INRCurncy"></span>)</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label>Contact
                                                            Person: </label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="conrctPersonValue">Ameya Paratkar</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label>Sales Period:</label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="salesPeriodValue">2022/001</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label>Email confirm: </label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="EmailConfirmValue">customer.success@whizible.com</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label>Sales
                                                            Person:</label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="salesPersonValue">Admin</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label>Contract:</label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <div>
                                                            <label id="ContrctValue">British Telecommunication</label>
                                                        </div>
                                                        <div>
                                                            <a href="javascript:;" class="linkTxt textUndrln" onclick="ShowContractDetails(); return false;">
                                                                <span data-bs-toggle="tooltip" title="Show Details">Show
                                                                    Details
                                                                </span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mb-2">
                                                <div class="row">
                                                    <div class="col-sm-4 text-end">
                                                        <label>IR
                                                            Items Header: </label>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <label id="IR_ItemsHeaderValue"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="invoiceTabs">
                            <ul class="nav nav-tabs main_graybgtbs" style="pointer-events: auto;">
                                <li class="nav-item"><a class="nav-link active" href="#TabInvoiceItems" rol="tab"
                                    data-bs-toggle="tab" id=""><span data-bs-toggle="tooltip" title="Invoice Items">Invoice Items</span></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-content mt-2">
                        <!--Invoice Items tab start here-->
                        <div class="tab-pane active">
                            <table id="IRPIR_EditDetailsTbl" class="table table-bordered table-stripped newTblStyle IRPIR_EdtDetlsTable"
                                style="width:100%;">
                                <thead class="stickyTblHeader">
                                    <tr>
                                        <th class="col-sm-1">Sr.No.</th>
                                        <th class="col-sm-3">Description</th>
                                        <th class="col-sm-1">Discount</th>
                                        <th class="col-sm-1">Quantity</th>
                                        <th class="col-sm-1">Rate (<span class="amountCurrency"></span>)</th>
                                        <th class="col-sm-1">Amount <br>(<span class="amountCurrency"></span>)</th>
                                        <th class="col-sm-2">Equiv. <span id="corpCurrency"></span> <br> Amount (Corp)
                                        </th>
                                        <th class="col-sm-2">Equiv. <span id="compCurrency"></span> <br> Amount (Comp) </th>
                                    </tr>
                                </thead>
                                <tbody>                                  
                                </tbody>
                                <tfoot>
                                    <tr class="lightGrey">
                                        <td>Total Amount</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>70.00</td>
                                        <td>140.00</td>
                                        <td>210.00</td>
                                    </tr>
                                </tfoot>
                            </table>
                            <table id="IRPIR_EditDetailsTotalTbl" class="table table-stripped newTblStyle IRPIR_EdtDetlsTable"
                                style="width:100%;">
                                <tbody>
                                    <tr class="lightGrey">
                                        <td class="col-sm-1">Total Amount</td>
                                        <td class="col-sm-3">&nbsp;</td>
                                        <td class="col-sm-1">&nbsp;</td>
                                        <td class="col-sm-1">&nbsp;</td>
                                        <td class="col-sm-1">&nbsp;</td>
                                        <td class="col-sm-1" id="irEditTotalAmountInr">&nbsp;</td>
                                        <td class="col-sm-2" id="irEditTotalAmountCorp">&nbsp;</td>
                                        <td class="col-sm-2" id="irEditTotalAmountComp">&nbsp;</td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="ir-pagination-container">
                                <div class="ir-pagination-info">
                                    <span id="irEditTotalRecordsText"><%-- Total Records: 0 --%></span>
                                </div>
                                <div class="ir-pagination-buttons">
                                    <button id="irEditPrevPageBtn" type="button" class="ir-page-btn" title="Previous Page">
                                        <i class="fas fa-angle-double-left"></i>
                                    </button>
                                    <button id="irEditNextPageBtn" type="button" class="ir-page-btn" title="Next Page">
                                        <i class="fas fa-angle-double-right"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Show IR Approval Details Section ends -->

        <!-- IR-PIR Print report Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-50" data-bs-scroll="true" tabindex="-1" id="offcanvas_ViewReport">
            <div class="offcanvas-body">
                <div id="View_Report_Details" class="View_Report_Details">
                    <div class="graybg container-fluid py-1 mb-2">
                        <div class="row">
                            <%-- Added By Vyankat B. on 24 th April 2026 for aligning IR Report close icon on right side of heading --%>
                            <div class="col-sm-12 d-flex justify-content-between align-items-center">
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ReportBuilder")%></h5>
                                <button type="button" class="offcanvas-close-btn"
                                    data-bs-dismiss="offcanvas" aria-label="Close" title="Close">
                                    &#x2715;
                                </button>
                            </div>
                            <%-- End of Added By Vyankat B. on 24 th April 2026 for aligning IR Report close icon on right side of heading --%>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-sm-12 ">
                            <div class="row">
                                <div class="col-sm-6">
                                </div>
                                <div class="col-sm-6 text-end">
                                   <%-- <button type="button" class="btn borderbtn closebtn text-end" id="IR_ReportCloseBtn"
                                        data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="<%=MyBase.GetResourceString("C_Close")%>">
                                        <%=MyBase.GetResourceString("C_Close")%>
                                    </button>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="Print_Report_Details_content">
                        <div class="BasicDetailsContent">
                            <div class="graybg py-2 my-2">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <strong> <%=MyBase.GetResourceString("C_Invoice")%> </strong>
                                    </div>
                                    <div class="col-sm-6 text-end">
                                        <div class="dropdown filedownload">
                                            <button type="button" class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown">
                                                <i data-bs-toggle="tooltip" title="Click here to Export" id="ExportDataIRBtn" class="fas fa-download"></i>
                                            </button>
                                            <ul class="dropdown-menu"> 
                                                <li><a href="#" id="txtPrintPdf" onclick="GenerateIRApprovalPdf('PDF')">
                                                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_Pdf")%></a></li>
                                                <li><a href="#" onclick="GenerateIRApprovalPdf('EXCEL')">
                                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg"
                                                            width="18"><%=MyBase.GetResourceString("C_Excel")%></a></li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-5 text-end">
                                            <label for="cboInvoiceNumber1" class="required"><%=MyBase.GetResourceString("C_InvoiceNumber")%></label>
                                        </div>
                                        <div class="col-sm-6">
                                           <%CommonFunctions.HTMLControls.DrawComboBox("cboInvoiceNumber1", "usp_Whizible2_Sel_tbl_PM_RFIInvoices",,, "class='selectpicker' data-live-search='true'",,,) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="container-fluid py-1 graybg clearfix bottom-note">
                                <div id="IM_Report_Footer">
                                    <span class="note-title"><%=MyBase.GetResourceString("C_Note")%></span>
                                    <%=MyBase.GetResourceString("C_ReportBuilderNoteText")%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- IR-PIR Print report Section ends -->

        <!--IR-PIR Status History Modal start here-->
        <div class="modal custmodal fade" id="IRPIR_StatHistorymodal" aria-hidden="true" data-bs-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header graybg">
                        <h5 class="modal-title"><%=MyBase.GetResourceString("C_IRPIRStatusHistory")%></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table id="PIRstatushistoryTbl" class="table table-stripped" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_ChangeToStatus")%></th>
                                    <th><%=MyBase.GetResourceString("C_ChangedBy")%></th>
                                    <th><%=MyBase.GetResourceString("C_ChangedOn")%></th>
                                    <th><%=MyBase.GetResourceString("C_Comments")%></th>
                                </tr>
                            </thead>
                            <tbody id="PIRstatushistoryTbl_Body">
                               
                            </tbody>
                        </table>
                        <div class="ir-pagination-container">
                            <div class="ir-pagination-info">
                                <span id="pirStatusTotalRecordsText">Total Records: 0</span>
                            </div>
                            <div class="ir-pagination-buttons">
                                <button id="pirStatusPrevPageBtn" type="button" class="ir-page-btn" title="Previous Page">
                                    <i class="fas fa-angle-double-left"></i>
                                </button>
                                <button id="pirStatusNextPageBtn" type="button" class="ir-page-btn" title="Next Page">
                                    <i class="fas fa-angle-double-right"></i>
                                </button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <%--<div class="btnrow text-center">
                            <button data-bs-dismiss="modal" class="btn borderbtn" data-bs-toggle="tooltip" title="Cancel" id="IR_statHisCancelBtn">Cancel</button>
                        </div>--%>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- IR-PIR Status History Modal End here-->
        <!--Change IR-PIR Status Modal start here-->
        <div class="modal custmodal fade" id="ChangeIRPIR_StatusModal" aria-hidden="true" data-bs-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%=MyBase.GetResourceString("C_ChangeIRPIRStatus")%></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="IRPIR_StatusDiv">
                            <div class="row ">
                                <div class="col-sm-12 text-end">
                                    <label class="form-label ">(<font color="red">*</font>
                                        Mandatory)</label>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 d-flex justify-content-end">
                                    <label for="statusHisInput" class="required"><%=MyBase.GetResourceString("C_Status")%></label>
                                </div>
                                <div class="col-sm-6">
                                    <%--<select class="selectpicker statusColors" data-live-search="true" id="statusHisInput">
                                        <option>Select Status</option>
                                        <option data-content="<span class='statusBox statusApproved mx-2'>&nbsp;</span> Approved"> </option>
                                        <option data-content="<span class='statusBox statusCancelled mx-2'>&nbsp;</span> Cancelled"> </option>
                                        <option data-content="<span class='statusBox statusRejected mx-2'>&nbsp;</span> Rejected"></option>
                                    </select>--%>
                                    <select class="selectpicker statusColors" data-live-search="true" id="statusHisInput">
                                        <option value=""><%=MyBase.GetResourceString("C_SelectStatus")%></option>
                                        <option value="Approved"> <%=MyBase.GetResourceString("C_Approved")%></option>
                                        <option value="Cancelled"> <%=MyBase.GetResourceString("C_Cancelled")%></option>
                                        <option value="Rejected"> <%=MyBase.GetResourceString("C_Rejected")%></option>
                                    </select>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4 d-flex justify-content-end">
                                    <label for="commentStatHisInput" class="required"><%=MyBase.GetResourceString("C_Comments")%></label>
                                </div>
                                <div class="col-sm-7">
                                    <textarea class="form-control" id="commentStatHisInput" maxlength="2000"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="btnrow text-center">
                            <%If m_blnEditAccess = True Or m_blnAddAccess = True Then%>
                            <button id="saveIRStatusHisBtn" class="btn btnyellow" onclick="InsertRFIStatusHistory()">Save</button>
                            <%End If %>
                            <button id="cancelIRStatHisBtn" data-bs-dismiss="modal" class="btn borderbtn" hidden>Cancel</button>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Change IR-PIR Status Modal End here-->
        <!-- View Checklist offcanvas start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="true" tabindex="-1" id="offcvsViewChecklist">
            <div class="offcanvas-header graybg">
                <h5 class="offcanvas-title pgtitle "><%=MyBase.GetResourceString("C_Checklist")%></h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <table class="table table-stripped" style="width: 100%;" id="IR_ChecklistTbl">
                    <thead>
                        <tr>
                            <th class="col-sm-1"><%=MyBase.GetResourceString("C_SrNo")%></th>
                            <th class="col-sm-6"><%=MyBase.GetResourceString("C_ChecklistItem")%></th>
                            <th class="col-sm-2"><%=MyBase.GetResourceString("C_Yes")%></th>
                            <th class="col-sm-3"><%=MyBase.GetResourceString("C_Comments")%></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <!-- Custom pagination for IR_ChecklistTbl -->
                <div class="ir-pagination-container">
                    <div class="ir-pagination-info">
                        <span id="irChecklistTotalRecordsText"><%-- Total Records: 0 --%></span>
                    </div>
                    <div class="ir-pagination-buttons">
                        <button id="irChecklistPrevPageBtn" type="button" class="ir-page-btn" title="Previous Page">
                            <i class="fas fa-angle-double-left"></i>
                        </button>
                        <button id="irChecklistNextPageBtn" type="button" class="ir-page-btn" title="Next Page">
                            <i class="fas fa-angle-double-right"></i>
                        </button>
                    </div>
                </div>

                <div class="clearfix"></div>
                <div class="text-center">
                </div>
            </div>
        </div>
        <!-- View Checklist offcanvas end here -->
        <!-- Show History offcanvas start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="true" tabindex="-1" id="offcvsIRShowHistory">
            <div class="offcanvas-header graybg">
                <h5 class="offcanvas-title pgtitle"><%=MyBase.GetResourceString("C_ShowHistory")%></h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <div class="py-1 form-inline hstryfltr">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <div class="col-sm-6 d-flex justify-content-end">
                                    <label for="IR_ModifiedHisField"><%=MyBase.GetResourceString("C_ModifiedField")%> : </label>
                                </div>
                                <div class="col-sm-6">
                                    <select class="selectpicker" data-live-search="true" id="IR_ModifiedHisField">
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <div class="col-sm-6 d-flex justify-content-end">
                                    <label for="IR_ModifiedHisBy"><%=MyBase.GetResourceString("C_ModifiedBy")%> : </label>
                                </div>
                                <div class="col-sm-6">
                                    <select class="selectpicker" data-live-search="true" id="IR_ModifiedHisBy">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex">
                                <span><%=MyBase.GetResourceString("C_AuditTrail")%></span>
                                <span><%=MyBase.GetResourceString("C_IRPIRDash")%></span>
                            </div>
                        </div>
                    </div>
                </div>

                <table id="IRAShowHistoryTable" class="table table-bordered table-sm" style="width: 100%;">
                    <thead>
                        <tr>
                            <th><%=MyBase.GetResourceString("C_ModifiedField")%></th>
                            <th><%=MyBase.GetResourceString("C_OldValue")%></th>
                            <th><%=MyBase.GetResourceString("C_NewValue")%></th>
                            <th><%=MyBase.GetResourceString("C_ModifiedDate")%></th>
                            <th><%=MyBase.GetResourceString("C_ModifiedBy")%></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <!-- Custom pagination for IRAShowHistoryTable -->
                <div class="ir-pagination-container">
                    <div class="ir-pagination-info">
                        <span id="irHistoryTotalRecordsText"><%=MyBase.GetResourceString("C_TotalRecords")%>: 0</span>
                    </div>
                    <div class="ir-pagination-buttons">
                        <button id="irHistoryPrevPageBtn" type="button" class="ir-page-btn" title="Previous Page">
                            <i class="fas fa-angle-double-left"></i>
                        </button>
                        <button id="irHistoryNextPageBtn" type="button" class="ir-page-btn" title="Next Page">
                            <i class="fas fa-angle-double-right"></i>
                        </button>
                    </div>
                </div>

                <br>
                <div class="clearfix"></div>
                <div class="text-center">
                </div>
            </div>
        </div>
        
        <!--Select Customer Address offcanvas start here-->
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="true" tabindex="-1" id="offcvsCustomerAddress">
            <div class="offcanvas-header graybg">
                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_SelectCustomerAddress")%></h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <div class="row ">
                    <div class="col-sm-12 text-end">
                        <label class="form-label ">(<font color="red">*</font> <%=MyBase.GetResourceString("C_Mandatory")%>)</label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row my-3">
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-6 text-end">
                                    <label><%=MyBase.GetResourceString("C_CustomerName")%> :</label>
                                </div>
                                <div class="col-sm-6">
                                    <label id="custNameInfo">Alcon Research, Ltd.</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="row">
                                <div class="col-sm-6 text-end">
                                    <label class="required"><%=MyBase.GetResourceString("C_CustomerAddress")%> :</label>
                                </div>
                                <div class="col-sm-6">
                                    <select class="selectpicker" data-live-search="true" id="custAddressInfo" disabled>                                       
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row graybg mb-3">
                    <div class="col-sm-12">
                        <label class="py-1 d-block"><%=MyBase.GetResourceString("C_Address_Details")%></label>
                    </div>
                </div>
                <div id="AddrDetlsSec">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row mb-1">
                                <div class="col-sm-2 text-end">
                                    <label><%=MyBase.GetResourceString("C_Address")%></label>
                                </div>
                                <div class="col-sm-10 text-start">
                                    <label id="addrDetlsInfo">20511 Lake Forest Drive, Lake Forest, CA 92630, USA</label>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-sm-2 text-end">
                                    <label><%=MyBase.GetResourceString("C_City")%></label>
                                </div>
                                <div class="col-sm-10 text-start">
                                    <label id="addrCityInfo">Austin</label>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-sm-2 text-end">
                                    <label><%=MyBase.GetResourceString("C_State")%></label>
                                </div>
                                <div class="col-sm-10 text-start">
                                    <label id="addrStateInfo">Texas</label>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-sm-2 text-end">
                                    <label><%=MyBase.GetResourceString("C_Country")%></label>
                                </div>
                                <div class="col-sm-10 text-start">
                                    <label id="addrCountryInfo">United States</label>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-sm-2 text-end">
                                    <label><%=MyBase.GetResourceString("C_ZipCode")%></label>
                                </div>
                                <div class="col-sm-10 text-start">
                                    <label id="addrZipCodeInfo">78716</label>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-sm-2 text-end">
                                    <label><%=MyBase.GetResourceString("C_FaxNo")%></label>
                                </div>
                                <div class="col-sm-10 text-start">
                                    <label id="addrFaxNoInfo"></label>
                                </div>
                            </div>
                            <div class="row mb-1">
                                <div class="col-sm-2 text-end">
                                    <label><%=MyBase.GetResourceString("C_TelephoneNo")%></label>
                                </div>
                                <div class="col-sm-10 text-start">
                                    <label id="addrTelNoInfo"></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="javascript:;" class="btn btnyellow" id="custAddrSaveBtn" data-bs-toggle="tooltip" title="Save" style="display: none;">Save</a>
                </div>
            </div>
        </div>
         <!--Show Details Modal start here-->
        <div id="contractDetailsBackdrop" class="contract-details-backdrop" onclick="HideContractDetailsCanvas();"></div>
        <div id="ShowContractDtlsModal" class="contract-details-canvas" aria-hidden="true">
            <div class="offcanvas-body">
                <div class="container-fluid py-2 graybg mb-2">
                    <div class="row align-items-center">
                        <div class="col-sm-12">
                            <div class="d-flex align-items-center justify-content-between font-weight-600">
                                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_ContractDetailsCanvas")%></h5>   
                                  <button type="button" class="offcanvas-close-btn"
                                    data-bs-dismiss="offcanvas" aria-label="Close" onclick="HideContractDetailsCanvas();" title="Close">
                                    &#x2715;               
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="accordion Init_acordian_panel my-3 " id="contractMasterAcc">--%>
                <div class="accordion Off_acordian_panel my-3  " id="contractMasterAcc">
                    <div class="accordion-item mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#contractMasterTab" aria-expanded="true">
                                <%=MyBase.GetResourceString("C_ContractMaster")%>
                            </button>
                        </h2>
                        <div id="contractMasterTab" class="accordion-collapse collapse show"
                            aria-labelledby="contractMasterHeading">
                            <div class="accordion-body">
                                <div class="contractMasterDiv">
                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class="" id="lblContractSummary"><%=MyBase.GetResourceString("C_ContractSummaryLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class="" id="lblCurrencyChange"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="row">
                                                    <div class="col-sm-3 text-end ">
                                                        <label class="" id="lblContractDetails"><%=MyBase.GetResourceString("C_ContractDetailsLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <label class="" id="lblContractDetail"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=" " id="lblCustomer"><%=MyBase.GetResourceString("C_CustomerLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class=" " id="lblCustomerName"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=" "><%=MyBase.GetResourceString("C_ContractTypeLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class=" " id="lblContractType"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=" "><%=MyBase.GetResourceString("C_CommencementDateLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class="" id="lblCommencementDate"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=" "><%=MyBase.GetResourceString("C_ContractSigningDateLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class="" id="lblContrctSignDate"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end ">
                                                        <label class=""><%=MyBase.GetResourceString("C_ContractExpiryDateLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class="" id="lblContrctEndDate"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end ">
                                                        <label class=""><%=MyBase.GetResourceString("C_POSOWNumberLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class="" id="lblPOSOWNumber"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=" "><%=MyBase.GetResourceString("C_POSOWValueLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class=" " id="lblPOSOWValue"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=" "><%=MyBase.GetResourceString("C_CurrencyLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class=" " id="lblContcurrency"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=""><%=MyBase.GetResourceString("C_CRMRefNo")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class=" " id="lblCRMNO"></label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <div class="col-sm-6 text-end">
                                                        <label class=""><%=MyBase.GetResourceString("C_RemainingPOValueLabel")%></label>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label class=" " id="lbl_RemainPOVal"></label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item mb-3">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                data-bs-target="#ContractAttachmentsTab" aria-expanded="false">
                                <%=MyBase.GetResourceString("C_ContractAttachments")%>
                            </button>
                        </h2>
                        <div id="ContractAttachmentsTab" class="accordion-collapse collapse">
                            <div class="accordion-body">
                                <div class="ContractAttachmentsDiv">
                                    <div class="row">
                                        <table class="table table-stripped mb-2" id="ContractAttachTbl" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th><%=MyBase.GetResourceString("C_SrNo")%></th>
                                                    <th><%=MyBase.GetResourceString("C_FileName")%></th>
                                                    <th><%=MyBase.GetResourceString("C_AttachedBy")%></th>
                                                    <th><%=MyBase.GetResourceString("C_AttachedDate")%></th>
                                                    <th><%=MyBase.GetResourceString("C_Description")%></th>
                                                </tr>
                                            </thead>
                                            <tbody id="ContractAttachTblBody">
                                            </tbody>
                                        </table>
                                        <div class="ir-pagination-container">
                                            <div class="ir-pagination-info">
                                                <span id="irContractTotalRecordsText"></span>
                                            </div>
                                            <div class="ir-pagination-buttons">
                                                <button id="irContractPrevPageBtn" type="button" class="ir-page-btn" title="<%=MyBase.GetResourceString("C_PreviousPage")%>">
                                                    <i class="fas fa-angle-double-left"></i>
                                                </button>
                                                <button id="irContractNextPageBtn" type="button" class="ir-page-btn" title="<%=MyBase.GetResourceString("C_NextPage")%>">
                                                    <i class="fas fa-angle-double-right"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Show Details modal end here-->

        <%-- Added By Vishal Mane on 01/04/2026 - Dedicated main page status history offcanvas with unique IDs. --%>
        <div class="offcanvas offcanvas-end offcanvas-70" data-bs-scroll="true" tabindex="-1" id="offcvsIRShowHistory_MainPageNow">           
            <div class="d-flex align-items-center justify-content-between font-weight-600 mt-3 ml-1">
                <h5 class="pgtitle"><%=MyBase.GetResourceString("C_IRPIRStatusHistory")%></h5>   
                    <button type="button" class="offcanvas-close-btn" data-bs-dismiss="offcanvas" aria-label="Close" onclick="HideContractDetailsCanvas();" title="Close">&#x2715;               
                </button>
            </div>

            <div class="offcanvas-body">                
                <%-- Added By Vishal Mane on 01/04/2026 - Unique history table ID for main page offcanvas. --%>
                <table id="PIRstatushistoryTbl_MainPage" class="table table-bordered table-sm" style="width: 100%;">
                            <thead>
                                <tr>
                                    <th><%=MyBase.GetResourceString("C_ChangeToStatus")%></th>
                                    <th><%=MyBase.GetResourceString("C_ChangedBy")%></th>
                                    <th><%=MyBase.GetResourceString("C_ChangedOn")%></th>
                                    <th><%=MyBase.GetResourceString("C_Comments")%></th>
                                </tr>
                            </thead>
                            <%-- Added By Vishal Mane on 01/04/2026 - Unique history tbody ID for main page offcanvas. --%>
                            <tbody id="PIRstatushistoryTbl_Body_MainPage">
                               
                            </tbody>
                        </table>
                        <div class="ir-pagination-container">
                            <div class="ir-pagination-info">
                                <%-- Added By Vishal Mane on 01/04/2026 - Unique total records label for main page offcanvas. --%>
                                <span id="pirStatusTotalRecordsText_MainPage">Total Records: 0</span>
                            </div>
                            <div class="ir-pagination-buttons">
                                <%-- Added By Vishal Mane on 01/04/2026 - Unique previous button for main page offcanvas. --%>
                                <button id="pirStatusPrevPageBtn_MainPage" type="button" class="ir-page-btn" title="Previous Page">
                                    <i class="fas fa-angle-double-left"></i>
                                </button>
                                <%-- Added By Vishal Mane on 01/04/2026 - Unique next button for main page offcanvas. --%>
                                <button id="pirStatusNextPageBtn_MainPage" type="button" class="ir-page-btn" title="Next Page">
                                    <i class="fas fa-angle-double-right"></i>
                                </button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <%--<div class="btnrow text-center">
                            <button data-bs-dismiss="modal" class="btn borderbtn" data-bs-toggle="tooltip" title="Cancel" id="IR_statHisCancelBtn">Cancel</button>
                        </div>--%>
                        <div class="clearfix"></div>
                <br>
                <div class="clearfix"></div>
                <div class="text-center">
                </div>
            </div>
        </div>

        <div class="clearfix"></div>
    </div>
     <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess")%></p>
        </div>
    </div>
    <%End If %>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script>
        // Added by Vyankat B. on 10-03-2026 - API base URL and user context for Project dropdown binding (refer Profitability page)
        var strUrl = '<%= System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString() %>';
        var irApprovalUserID = parseInt('<%= Session("intUserID") %>', 10) || 0;
        var irApprovalLoginType = '<%= Session("LoginType") %>' || 'E';
        // End of Added by Vyankat B. on 10-03-2026
        function refreshPage() {
            window.location.reload();
        }
        //change date format
        var months = ["January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };
        //datepicker
        $('#RaisedOnDateFilter').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd MM yy'
        });
        //datatable
        $('#IRPIR_ApprovalTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "scrollCollapse": true,
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });
        // Get DataTables API instance for custom pagination
        var irMainTable = $('#IRPIR_ApprovalTbl').DataTable();
        $('#IRPIR_ApprovalTbl').wrap('<div class="dataTables_scroll" />');

        //datatable
        $('#IR_StatusHistoryTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 10,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });
        $('#IR_StatusHistoryTbl').wrap('<div class="dataTables_scroll" />');
        // Get DataTables API instance for custom pagination
        var irStatusTable = $('#IR_StatusHistoryTbl').DataTable();
        var pirStatusHistoryTable = null;
        // Added By Vishal Mane on 01/04/2026 - Separate DataTable instance for main page status history offcanvas.
        var pirStatusHistoryMainPageTable = null;

        //datatable
        $('#IRPIR_EditDetailsTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": false,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "autoWidth": false,
            "info": false,
        });
        $('#IRPIR_EditDetailsTbl').wrap('<div class="dataTables_scroll" />');
        // Get DataTables API instance for custom pagination
        var irEditDetailsTable = $('#IRPIR_EditDetailsTbl').DataTable();

        //datatable
        $('#IR_ChecklistTbl').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
        });
        $('#IR_ChecklistTbl').wrap('<div class="dataTables_scroll" />');
        // Get DataTables API instance for custom pagination
        var irChecklistTable = $('#IR_ChecklistTbl').DataTable();

        //datatable - Show History modal (must be before its pagination wiring)
        $('#IRAShowHistoryTable').dataTable({
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "info": false,
            "columnDefs": [
                {
                    "targets": [1, 2],
                    "render": function (data, type) {
                        if (type === "display" || type === "filter") {
                            return data;
                        }
                        if (typeof data === "string" && data.indexOf("<") >= 0) {
                            var d = document.createElement("div");
                            d.innerHTML = data;
                            return (d.textContent || d.innerText || "").trim();
                        }
                        return data;
                    }
                }
            ]
        });
        $('#IRAShowHistoryTable').wrap('<div class="dataTables_scroll" />');
        var irShowHistoryTable = $('#IRAShowHistoryTable').DataTable();

        //datatable - Contract Attachments (must be before its pagination wiring)
        $('#ContractAttachTbl').dataTable({
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "info": false,
        });
        $('#ContractAttachTbl').wrap('<div class="dataTables_scroll" />');
        var irContractAttachTable = $('#ContractAttachTbl').DataTable();

        // Custom pagination wiring for IRPIR_ApprovalTbl (previous/next + total records)
        function updateIrMainPagination() {
            if (!irMainTable) return;
            var info = irMainTable.page.info();
            var total = info.recordsDisplay; // after filtering
            var page = info.page + 1;
            var pages = info.pages;
            // Show only total records text (e.g. \"Total Records: 6\")
            var $infoSpan = $('#irTotalRecordsText');
            if ($infoSpan.length) {
                $infoSpan.text('Total Records: ' + total);
            }
            $('#irPrevPageBtn').prop('disabled', page <= 1 || pages === 0);
            $('#irNextPageBtn').prop('disabled', page >= pages || pages === 0);
        }

        if (irMainTable) {
            irMainTable.on('draw', function () {
                updateIrMainPagination();
            });
            updateIrMainPagination();
        }

        $('#irPrevPageBtn').on('click', function () {
            if (!irMainTable) return;
            irMainTable.page('previous').draw('page');
        });

        $('#irNextPageBtn').on('click', function () {
            if (!irMainTable) return;
            irMainTable.page('next').draw('page');
        });
        
        $('#irStatusPrevPageBtn').on('click', function () {
            if (!irStatusTable) return;
            irStatusTable.page('previous').draw('page');
        });

        $('#irStatusNextPageBtn').on('click', function () {
            if (!irStatusTable) return;
            irStatusTable.page('next').draw('page');
        });

        function updatePirStatusPagination() {
            if (!pirStatusHistoryTable) return;
            var info = pirStatusHistoryTable.page.info();
            var total = info.recordsDisplay;
            var page = info.page + 1;
            var pages = info.pages;

            $('#pirStatusTotalRecordsText').text('Total Records: ' + total);
            $('#pirStatusPrevPageBtn').prop('disabled', page <= 1 || pages === 0);
            $('#pirStatusNextPageBtn').prop('disabled', page >= pages || pages === 0);
        }

        $('#pirStatusPrevPageBtn').on('click', function () {
            if (!pirStatusHistoryTable) return;
            pirStatusHistoryTable.page('previous').draw('page');
        });

        $('#pirStatusNextPageBtn').on('click', function () {
            if (!pirStatusHistoryTable) return;
            pirStatusHistoryTable.page('next').draw('page');
        });

        // Added By Vishal Mane on 01/04/2026 - Custom pagination updater for main page status history offcanvas.
        function updatePirStatusPagination_MainPage() {
            // Added By Vishal Mane on 01/04/2026 - Exit safely when offcanvas DataTable is not initialized.
            if (!pirStatusHistoryMainPageTable) return;
            // Added By Vishal Mane on 01/04/2026 - Read DataTables paging information for the main page offcanvas.
            var info = pirStatusHistoryMainPageTable.page.info();
            // Added By Vishal Mane on 01/04/2026 - Get filtered total records for the offcanvas history table.
            var total = info.recordsDisplay;
            // Added By Vishal Mane on 01/04/2026 - Convert zero-based page index to one-based display page.
            var page = info.page + 1;
            // Added By Vishal Mane on 01/04/2026 - Total page count for the offcanvas history table.
            var pages = info.pages;
            // Added By Vishal Mane on 01/04/2026 - Update total records label in the main page offcanvas.
            $('#pirStatusTotalRecordsText_MainPage').text('Total Records: ' + total);
            // Added By Vishal Mane on 01/04/2026 - Disable previous button on first page.
            $('#pirStatusPrevPageBtn_MainPage').prop('disabled', page <= 1 || pages === 0);
            // Added By Vishal Mane on 01/04/2026 - Disable next button on last page.
            $('#pirStatusNextPageBtn_MainPage').prop('disabled', page >= pages || pages === 0);
        }

        // Added By Vishal Mane on 01/04/2026 - Previous page click handler for main page status history offcanvas.
        $('#pirStatusPrevPageBtn_MainPage').on('click', function () {
            // Added By Vishal Mane on 01/04/2026 - Exit when the main page offcanvas table is unavailable.
            if (!pirStatusHistoryMainPageTable) return;
            // Added By Vishal Mane on 01/04/2026 - Move to previous page in the main page offcanvas history table.
            pirStatusHistoryMainPageTable.page('previous').draw('page');
        });

        // Added By Vishal Mane on 01/04/2026 - Next page click handler for main page status history offcanvas.
        $('#pirStatusNextPageBtn_MainPage').on('click', function () {
            // Added By Vishal Mane on 01/04/2026 - Exit when the main page offcanvas table is unavailable.
            if (!pirStatusHistoryMainPageTable) return;
            // Added By Vishal Mane on 01/04/2026 - Move to next page in the main page offcanvas history table.
            pirStatusHistoryMainPageTable.page('next').draw('page');
        });

        // Custom pagination wiring for IRPIR_EditDetailsTbl
        function updateIrEditPagination() {
            if (!irEditDetailsTable) return;
            var info = irEditDetailsTable.page.info();
            var total = info.recordsDisplay;
            var page = info.page + 1;
            var pages = info.pages;

            var $infoSpan = $('#irEditTotalRecordsText');
            if ($infoSpan.length) {
                $infoSpan.text('Total Records: ' + total);
            }

            $('#irEditPrevPageBtn').prop('disabled', page <= 1 || pages === 0);
            $('#irEditNextPageBtn').prop('disabled', page >= pages || pages === 0);
        }

        if (irEditDetailsTable) {
            irEditDetailsTable.on('draw', function () {
                updateIrEditPagination();
            });
            updateIrEditPagination();
        }

        $('#irEditPrevPageBtn').on('click', function () {
            if (!irEditDetailsTable) return;
            irEditDetailsTable.page('previous').draw('page');
        });

        $('#irEditNextPageBtn').on('click', function () {
            if (!irEditDetailsTable) return;
            irEditDetailsTable.page('next').draw('page');
        });

        // Custom pagination wiring for IR_ChecklistTbl
        function updateIrChecklistPagination() {
            if (!irChecklistTable) return;
            var info = irChecklistTable.page.info();
            var total = info.recordsDisplay;
            var page = info.page + 1;
            var pages = info.pages;
            var $infoSpan = $('#irChecklistTotalRecordsText');
            if ($infoSpan.length) {
                $infoSpan.text('Total Records: ' + total);
            }
            $('#irChecklistPrevPageBtn').prop('disabled', page <= 1 || pages === 0);
            $('#irChecklistNextPageBtn').prop('disabled', page >= pages || pages === 0);
        }

        if (irChecklistTable) {
            irChecklistTable.on('draw', function () {
                updateIrChecklistPagination();
            });
            updateIrChecklistPagination();
        }

        $('#irChecklistPrevPageBtn').on('click', function () {
            if (!irChecklistTable) return;
            irChecklistTable.page('previous').draw('page');
        });

        $('#irChecklistNextPageBtn').on('click', function () {
            if (!irChecklistTable) return;
            irChecklistTable.page('next').draw('page');
        });

        // Custom pagination wiring for IRAShowHistoryTable
        function updateIrShowHistoryPagination() {
            if (!irShowHistoryTable) return;
            var info = irShowHistoryTable.page.info();
            var total = info.recordsDisplay;
            var page = info.page + 1;
            var pages = info.pages;
            var $infoSpan = $('#irHistoryTotalRecordsText');
            if ($infoSpan.length) {
                $infoSpan.text('Total Records: ' + total);
            }
            $('#irHistoryPrevPageBtn').prop('disabled', page <= 1 || pages === 0);
            $('#irHistoryNextPageBtn').prop('disabled', page >= pages || pages === 0);
        }

        if (irShowHistoryTable) {
            irShowHistoryTable.on('draw', function () {
                updateIrShowHistoryPagination();
                irInitTableTooltips($('#IRAShowHistoryTable'));
            });
            updateIrShowHistoryPagination();
        }

        $('#irHistoryPrevPageBtn').on('click', function () {
            if (!irShowHistoryTable) return;
            irShowHistoryTable.page('previous').draw('page');
        });

        $('#irHistoryNextPageBtn').on('click', function () {
            if (!irShowHistoryTable) return;
            irShowHistoryTable.page('next').draw('page');
        });

        // Custom pagination wiring for ContractAttachTbl
        function updateIrContractPagination() {
            if (!irContractAttachTable) return;
            var info = irContractAttachTable.page.info();
            var total = info.recordsDisplay;
            var page = info.page + 1;
            var pages = info.pages;

            var $infoSpan = $('#irContractTotalRecordsText');
            if ($infoSpan.length) {
                $infoSpan.text('Total Records: ' + total);
            }

            $('#irContractPrevPageBtn').prop('disabled', page <= 1 || pages === 0);
            $('#irContractNextPageBtn').prop('disabled', page >= pages || pages === 0);
        }

        if (irContractAttachTable) {
            irContractAttachTable.on('draw', function () {
                updateIrContractPagination();
            });
            updateIrContractPagination();
        }

        $('#irContractPrevPageBtn').on('click', function () {
            if (!irContractAttachTable) return;
            irContractAttachTable.page('previous').draw('page');
        });

        $('#irContractNextPageBtn').on('click', function () {
            if (!irContractAttachTable) return;
            irContractAttachTable.page('next').draw('page');
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".modal").on('show.bs.modal', function (e) {
            $(".table").resize();
        });
        // Added By Vyankat B. on 26th Mar 2026 for binding Show History dropdowns from API.
        // Changed By Vyankat B. on 24 th April 2026 for preferring row/edit context project and IR IDs.
        function getShowHistoryProjectAndRfiId() {
            var projectId = 0;
            var rfiId = 0;

            if (typeof EditGlobalProjectID !== "undefined" && EditGlobalProjectID !== null && EditGlobalProjectID !== "" && !isNaN(EditGlobalProjectID)) {
                projectId = parseInt(String(EditGlobalProjectID), 10) || 0;
            }
            if (typeof EditGlobalIRID !== "undefined" && EditGlobalIRID !== null && EditGlobalIRID !== "" && !isNaN(EditGlobalIRID)) {
                rfiId = parseInt(String(EditGlobalIRID), 10) || 0;
            }

            if (!projectId) {
                var projectFromDropdown = $("#cboProject").val();
                if (projectFromDropdown !== null && projectFromDropdown !== undefined && projectFromDropdown !== "" && !isNaN(projectFromDropdown)) {
                    projectId = parseInt(projectFromDropdown, 10) || 0;
                }
            }
            if (!projectId) {
                projectId = parseInt(SessionProjectID, 10) || 0;
            }

            if (!rfiId) {
                var rfiFromDropdown = $.trim($("#IR_ID_Filter").val());
                if (rfiFromDropdown !== "" && !isNaN(rfiFromDropdown)) {
                    rfiId = parseInt(rfiFromDropdown, 10) || 0;
                }
            }

            return {
                projectId: projectId,
                rfiId: rfiId
            };
        }
        // End of Changed By Vyankat B. on 24 th April 2026 for preferring row/edit context project and IR IDs.

        /** Audit trail Modified Date: "3 Apr 2026" (no time). Handles ISO and "Mar 27 2026 10:56AM"-style strings. */
        function irFormatAuditModifiedDate(v) {
            if (v === null || v === undefined || v === '') return '';
            var s = String(v).trim();
            var d = new Date(s);
            if (!isNaN(d.getTime())) {
                var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                return d.getDate() + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
            }
            var m = s.match(/^([A-Za-z]{3})\s+(\d{1,2})\s+(\d{4})/);
            if (m) {
                var mon = m[1].charAt(0).toUpperCase() + m[1].slice(1).toLowerCase();
                return parseInt(m[2], 10) + ' ' + mon + ' ' + m[3];
            }
            return s;
        }

        function bindIRModifiedFieldDropdown(projectId, rfiId) {
            var param = {
                projectId: projectId,
                rfiid: rfiId
            };
            var result = AJAXCallWithResult('api/IRApproval/GetIRPIRModifiedField', JSON.stringify(param), false);
            var list = (result &&
                result.irPIRModifiedField &&
                Array.isArray(result.irPIRModifiedField.IRPIRModifiedFieldResponse))
                ? result.irPIRModifiedField.IRPIRModifiedFieldResponse
                : [];

            var strHTML = "<option value=''>Select Field Name</option>";
            for (var i = 0; i < list.length; i++) {
                var fieldName = (list[i].fieldName || list[i].FieldName || "").trim();
                if (fieldName && fieldName.toLowerCase() !== "select field name") {
                    strHTML += "<option value='" + fieldName.replace(/'/g, "&#39;") + "'>" + fieldName + "</option>";
                }
            }
            $("#IR_ModifiedHisField").html(strHTML);
            $("#IR_ModifiedHisField").selectpicker('refresh');
        }

        function bindIRModifiedByDropdown(projectId, rfiId) {
            var param = {
                projectId: projectId,
                rfiid: rfiId
            };
            var result = AJAXCallWithResult('api/IRApproval/GetIRPIRModifiedBy', JSON.stringify(param), false);
            var list = (result &&
                result.irPIRModifiedBy &&
                Array.isArray(result.irPIRModifiedBy.IRPIRModifiedByResponse))
                ? result.irPIRModifiedBy.IRPIRModifiedByResponse
                : [];

            var strHTML = "<option value='0'>Select Modified By</option>";
            for (var i = 0; i < list.length; i++) {
                var employeeId = list[i].employeeId || list[i].EmployeeId || 0;
                var modifiedBy = (list[i].modifiedBy || list[i].ModifiedBy || "").trim();
                if (modifiedBy && modifiedBy.toLowerCase() !== "select modified by") {
                    strHTML += "<option value='" + employeeId + "'>" + modifiedBy + "</option>";
                }
            }
            $("#IR_ModifiedHisBy").html(strHTML);
            $("#IR_ModifiedHisBy").selectpicker('refresh');
        }

        function bindIRAuditTrailHistory(projectId, rfiId, selectedEmployeeId, selectedFieldName) {
            //debugger
            var employeeId = selectedEmployeeId;
            var fieldName = selectedFieldName;

            if (employeeId === undefined || employeeId === null || employeeId === "" || employeeId === "0") {
                employeeId = null;
            }
            if (fieldName === undefined || fieldName === null || fieldName === "" || fieldName === "Select Field Name") {
                fieldName = null;
            }

            var param = {
                projectId: projectId,
                rfiid: rfiId,
                employeeId: employeeId,
                fieldName: fieldName
            };
            var result = AJAXCallWithResult('api/IRApproval/GetRFIsAuditTrail', JSON.stringify(param), false);
            var list = (result &&
                result.rfisAuditTrail &&
                Array.isArray(result.rfisAuditTrail.RFIsAuditTrailResponse))
                ? result.rfisAuditTrail.RFIsAuditTrailResponse
                : [];

            if (irShowHistoryTable) {
                irShowHistoryTable.clear();
                for (var i = 0; i < list.length; i++) {
                    var row = list[i];
                    var oldVal = row.value != null ? row.value : row.Value;
                    var newVal = row.newValue != null ? row.newValue : row.NewValue;
                    irShowHistoryTable.row.add([
                        row.fieldName || row.FieldName || "",
                        irFormatLongTextTooltip(oldVal != null ? oldVal : "", 50),
                        irFormatLongTextTooltip(newVal != null ? newVal : "", 50),
                        irFormatAuditModifiedDate(row.modifiedDate || row.ModifiedDate || ""),
                        row.modifiedBy || row.ModifiedBy || ""
                    ]);
                }
                irShowHistoryTable.draw();
                if (typeof updateIrShowHistoryPagination === 'function') {
                    updateIrShowHistoryPagination();
                }
                irInitTableTooltips($('#IRAShowHistoryTable'));
            }
        }
        // Added By Vyankat B. on 27th March
        //$('#IR_ShowHistorymodal').on('shown.bs.modal', function () {
        $('#offcvsIRShowHistory').on('shown.bs.offcanvas', function () {
           // debugger
        // End of Added By Vyankat B. on 27th March
            var ids = getShowHistoryProjectAndRfiId();
            if (ids.projectId > 0 && ids.rfiId > 0) {
                bindIRModifiedFieldDropdown(ids.projectId, ids.rfiId);
                bindIRModifiedByDropdown(ids.projectId, ids.rfiId);
                bindIRAuditTrailHistory(ids.projectId, ids.rfiId, null, null);
            }
            if (typeof updateIrShowHistoryPagination === 'function') {
                updateIrShowHistoryPagination();
            }
        });

        // Changed By Vyankat B. On 27th Mar 2026 - Rebind history table on filter change.
        $("#IR_ModifiedHisBy, #IR_ModifiedHisField").on("change", function () {
            var ids = getShowHistoryProjectAndRfiId();
            if (ids.projectId <= 0 || ids.rfiId <= 0) return;

            var selectedEmployeeId = $("#IR_ModifiedHisBy").val();
            var selectedFieldName = $("#IR_ModifiedHisField").val();

            bindIRAuditTrailHistory(ids.projectId, ids.rfiId, selectedEmployeeId, selectedFieldName);
        });
        // End of Changed By Vyankat B. On 27th Mar 2026 - Rebind history table on filter change.
        // End of Added By Vyankat B. on 26th Mar 2026 for binding Show History dropdowns from API.
        $(".collapse").on('hidden.bs.modal', function (e) {
            $(".table").resize();
        });
        // Added By Vyankat B. on 24 th April 2026 for clearing sticky blue state on Change Status button after modal close
        $('#ChangeIRPIR_StatusModal').on('hidden.bs.modal', function () {
            var $changeBtn = $('#ChangStatusEdtIRBtn');
            $changeBtn.removeClass('active show');
            $changeBtn.attr('aria-expanded', 'false');
            $changeBtn.blur();
        });
        // End of Added By Vyankat B. on 24 th April 2026 for clearing sticky blue state on Change Status button after modal close

        function resizeSection() {
            var tblheight = $(window).height();
            $('#IRPIR_ApprovalTbl_wrapper .dataTables_scroll').css({ 'height': tblheight - 150, "overflow-y": "auto" });
            // $('#IRPIR_EditDetailsTbl .dataTables_scroll').css({ 'height': tblheight - 200, "overflow-y": "auto" });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });     

        $(document).ready(function () {

            $('#cboStatus').val(1).selectpicker('refresh');

            $("[data-bs-toggle='tooltip']").tooltip();

            $("#IRPIR_ApprovalTbl_wrapper .dataTable").resize();

            $("span.INRCurncy").append('<i class="fas fa-rupee-sign iconBlue"></i>');
            $("span.USDCurncy").append('<i class="fas fa-dollar-sign iconBlue"></i>');

        });

        $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open', function (e) {
            e.stopPropagation();
        });

         // Added By Vyankat B. on 10th March 2026 for fetching the data
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
                         alertify.notify('<%=MyBase.GetResourceString("A_AuthenticationFailed")%>', 'error', 5);
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
         // End of Added By Vyankat B. on 10th March 2026 for fetching the data

         // Added by Vyankat B. on 10-03-2026 - Bind Project dropdown from GetAccessibleProjects API (refer Profitability page binding process)

         function loadAccessibleProjects() {
             //debugger
             var $projDropdown = $('#cboProject');
             if (!$projDropdown.length) return;
             if (irApprovalUserID <= 0) {
                 $projDropdown.html('<option value="">Select Project</option>').selectpicker('refresh');
                 return;
             }
             var param = {
                 UserID: irApprovalUserID
                
             };
             try {
                 var result = AJAXCallWithResult('api/IRApproval/GetAccessibleProjects', JSON.stringify(param), false);
                 var data = result.accessibleProjects.AccessibleProjectsResponse;
                 // API returns array at data.accessibleProjects.AccessibleProjectsResponse (or data.AccessibleProjects.AccessibleProjectsResponse)
                 var list = (data || Array.isArray(data)) ? data : [];
                 $projDropdown.empty().append($('<option value="">Select Project</option>'));
                 for (var i = 0; i < list.length; i++) {
                     var p = list[i];
                     var id = (p.projectID !== undefined) ? p.projectID : (p.ProjectID !== undefined) ? p.ProjectID : '';
                     var name = (p.projectName !== undefined) ? p.projectName : (p.ProjectName !== undefined) ? p.ProjectName : '';
                     if (id !== '' && id !== undefined) {
                         $projDropdown.append($('<option></option>').attr('value', id).text(name || ('Project ' + id)));
                     }
                 }
                 $projDropdown.selectpicker('refresh');
             } catch (e) {
                 console.error('Error loading accessible projects:', e);
                 $projDropdown.html('<option value="">Select Project</option>').selectpicker('refresh');
             }
         }

        // End of Added by Vyankat B. on 10-03-2026 - Bind Project dropdown

        //Added by Vishal Mane on 17/03/2026 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionProjectId = '<%= Session("intProjectID") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';
        var SessionProjectID = '<%= Session("intProjectID") %>';
        //var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl_Invoice").ToString%>';
        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var AddAccess = '<%=m_blnAddAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var GFlag = 0;
        var Cust_Flag = 0;
        // Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
        function irGetStatusDotClass(statusText) {
            var s = String(statusText || '').trim().toLowerCase();
            if (!s) return '';
            if (s === 'approved') return 'statusApproved';
            if (s === 'rejected') return 'statusRejected';
            if (s === 'cancelled') return 'statusCancelled';
            if (s === 'submitted') return 'statusSubmitted';
            if (s === 're-submitted' || s === 'resubmitted') return 'statusReSubmitted';
            if (s === 'pending') return 'statusPending';
            if (s === 'closed') return 'statusClosed';
            if (s === 'draft' || s === 'revenue reversed') return 'statusDraft';
            return '';
        }
        function irEscapeStatusOptionHtml(s) {
            return String(s || '')
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;');
        }
        function irApplyStatusDotsToSelect($select) {
            if (!$select || !$select.length) return;
            var changed = false;
            $select.find('option').each(function () {
                var $opt = $(this);
                var label = String($opt.text() || '').trim();
                var cls = irGetStatusDotClass(label);
                if (!cls) return;
                var content = "<span class='statusBox " + cls + " mx-2'>&nbsp;</span> " + irEscapeStatusOptionHtml(label);
                if ($opt.attr('data-content') !== content) {
                    $opt.attr('data-content', content);
                    changed = true;
                }
            });
            if (changed) $select.selectpicker('refresh');
        }
        function irApplyStatusDotsToAllStatusSelects() {
            $('select.selectpicker').each(function () {
                irApplyStatusDotsToSelect($(this));
            });
        }
        // End of Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
        function setCurrentMonthData() {
            var monthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"];
            var now = new Date();
            $("#txtMonthData").text(monthNames[now.getMonth()] + " " + now.getFullYear());
        }

        window.onload = function GetSessionProject(changeProjectID) {
            if (SessionProjectID.length) {
                $("#cboProject").val(SessionProjectID);
                $(".selectpicker").selectpicker('refresh');
                // Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
                irApplyStatusDotsToAllStatusSelects();
                // End of Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
            }
            else {
            }
        }
        $(document).ready(function () {
            //debugger
            $("#IRPIRAprvltbl_wrapper .dataTable").resize();
            setCurrentMonthData();
            GetCurrencyCodes();
            //GetProjectCurrency(0);
            //var FilterID = UpdateDefaultFilter();
            //MyFilters(SessionProjectID, FilterID);
            //GetGlobalCurrencies(SessionProjectID);
            GetIRPIRList(SessionProjectId);
            let isFilChecked = $(".setDefaultFilter").is(":checked");
            if (isFilChecked) {
                $("#AdvanceFilterIcon").attr("aria-expanded", "true");
                //$("#PMProjectReviewClearAllFilter").show();
            }
            else {
                $("#AdvanceFilterIcon").attr("aria-expanded", "false");
                //$("#PMProjectReviewClearAllFilter").hide();
            }
            // Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
            irApplyStatusDotsToAllStatusSelects();
            // End of Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
        });
        //Added by Vishal Mane on 30/03/2026 to plot onchange projects by Customer ID
        function PlotProjectonChange(CustomerFlag) {
            var ProjectID = $("#cboProject").val();
            //MyFilters(ProjectID);
            //GetProjectCurrency(0);
            //GetGlobalCurrencies(ProjectID);
            GetIRPIRList(ProjectID);
            if (CustomerFlag == 1) {
                var CustomerID = $("#cboCustomer").val();
                BindCustomerProjects(CustomerID);
            }
            //$(".selectpicker").selectpicker('refresh');
            // Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
            irApplyStatusDotsToAllStatusSelects();
            // End of Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
        }

        function ShowStaticFilterData() {
            var ProjectID = $("#cboProject").val();
            GetIRPIRList(ProjectID)
        }

        var BaseCurrency = "";
        var LocalCurrency = "";
        var CorpCurrencyID = "";
        var CorpCurrencySymbol = "";
        function GetCurrencyCodes() {
           // debugger
            var Result = AJAXCallWithResult("api/IRApproval/GetCurrencyCodes", '', false);
            //var Result = AJAXCallWithResult('api/IRApproval/GetRFIsApprovalCounts', param, false);
            BaseCurrency = Result.baseCurncy;
            LocalCurrency = Result.localCurncy;
            CorpCurrencySymbol = Result.corpCurrencySymbol;
            CorpCurrencyID = Result.baseCurncyID;
        }

        function GetIRPIRList(ID) {
            //debugger
            var strHTML = "";
            var IR = "IR";
            var PIR = "PIR";
            var NA = "NA";
            var ProjectID;
            $("#IRPIR_ApprovalTbl").dataTable().fnDestroy();
            if (ID == null || ID == "" || ID == undefined || ID == "0") {
                ProjectID = $("#cboProject").val();
                if (ProjectID == null || ProjectID == undefined || ProjectID == 0) {
                    //ProjectID = SessionProjectID;
                    ProjectID = 0;
                    $("#cboProject").val(ProjectID);
                }
            }
            else {
                ProjectID = ID;
            }
            GetGlobalCurrencies(ProjectID);
            var CustomerID = $("#cboCustomer").val();
            var RFITypeID = $("#cboIRType").val();
            var Status = $("#cboStatus").find(":selected").text();

            var ProjectDetails = {
                ProjectID: 0,
                //RFIID: encodeURI(RFIID),
                RFITypeID: null,
                Status: null,
                CustomerID: null,
                ApproverID: irApprovalUserID
            }
            var param = JSON.stringify(ProjectDetails)

            var strResultCount = AJAXCallWithResult('api/IRApproval/GetRFIsApprovalCounts', param, false);
            strResultCount = strResultCount?.RFIsApprovalResponseCount || [];
            if (strResultCount.length != 0) {
                $.each(strResultCount, function (index, obj) {
                    //$("#irTotalCount").text(obj.totalRequests || 0);
                    $("#irSubmittedCount").text(obj.submitted || 0);
                    $("#irPendingCount").text(obj.pending || 0);
                    $("#irApprovedCount").text(obj.approved || 0);
                    $("#irRejectedCount").text(obj.rejected || 0);
                    $("#irCancelledCount").text(obj.cancelled || 0);
                });
            }
            else {
                //$("#irTotalCount").text(0);
                $("#irSubmittedCount").text(0);
                $("#irPendingCount").text(0);
                $("#irApprovedCount").text(0);
                $("#irRejectedCount").text(0);
                $("#irCancelledCount").text(0);
            }

            var ProjectDetails = {
                 ProjectID: encodeURI(ProjectID),
                //RFIID: encodeURI(RFIID),
                RFITypeID: encodeURI(RFITypeID),
                Status: Status,
                CustomerID: CustomerID,
                ApproverID: irApprovalUserID
            }
            var param = JSON.stringify(ProjectDetails)

           


            var strResult = AJAXCallWithResult('api/IRApproval/GetRFIsApproval', param, false);
            strResult = strResult?.RFIsApprovalResponse || []; 
            // Added or Modified by Vishal Mane on 26/03/2026 to keep currency headers visible even when no records
            var corpCurrencyCode = CompanyBaseCurrencyCode || "INR";
            var compCurrencyCode = CompanyBaseCurrencyCode || "INR";
            var corpCurrencySymbol = CompanyBaseCurrencySymbol || "Rs.";
            var compCurrencySymbol = CompanyBaseCurrencySymbol || "Rs.";
            //$("#txtCorpCurrencyCode").html(
            //    'Equiv. ' + corpCurrencyCode + ' (<span class="blue-text">' + corpCurrencySymbol + '</span>) Amount (Corp)'
            //);
            //$("#txtCompCurrencyCode").html(
            //    'Amount ' + compCurrencyCode + ' (<span class="blue-text">' + compCurrencySymbol + '</span>) (Comp)'
            //);

            $("#txtCorpCurrencyCode").html(
                'Equiv. Amount (Corp)'
            );
            $("#txtCompCurrencyCode").html(
                'Amount (Comp)'
            );

            if (strResult.length != 0) {
                // Added or Modified by Vishal Mane on 26/03/2026 to keep currency headers visible even when no records
                var corpCurrencyCode = CompanyBaseCurrencyCode || "INR";
                var compCurrencyCode = CompanyBaseCurrencyCode || "INR";
                var corpCurrencySymbol = CompanyBaseCurrencySymbol || "Rs.";
                var compCurrencySymbol = CompanyBaseCurrencySymbol || "Rs.";
                //$("#txtCorpCurrencyCode").html(
                //    'Equiv. ' + corpCurrencyCode + ' (<span class="blue-text">' + corpCurrencySymbol + '</span>) Amount (Corp)'
                //);
                //$("#txtCompCurrencyCode").html(
                //    'Amount ' + compCurrencyCode + ' (<span class="blue-text">' + compCurrencySymbol + '</span>) (Comp)'
                //);
                $("#txtCorpCurrencyCode").html(
                    'Equiv. Amount (Corp)'
                );
                $("#txtCompCurrencyCode").html(
                    'Amount (Comp)'
                );

                

                if (strResult.length != 0) {
                    $.each(strResult, function (index, obj) {
                        var rowProjectId = obj.projectID;
                        if (rowProjectId == null || rowProjectId === '') rowProjectId = obj.projectId;
                        if (rowProjectId == null || rowProjectId === '') rowProjectId = obj.ProjectID;
                        var rowProjectIdArg = (rowProjectId != null && rowProjectId !== '') ? rowProjectId : 'null';
                        var rowRaisedBy = (obj.rfiRaisedBy !== undefined && obj.rfiRaisedBy !== null) ? String(obj.rfiRaisedBy)
                            : ((obj.rFIRaisedBy !== undefined && obj.rFIRaisedBy !== null) ? String(obj.rFIRaisedBy)
                            : ((obj.RFIRaisedBy !== undefined && obj.RFIRaisedBy !== null) ? String(obj.RFIRaisedBy) : ''));
                        var rowContractId = (obj.contractID != null && obj.contractID !== undefined) ? obj.contractID
                            : ((obj.ContractID != null && obj.ContractID !== undefined) ? obj.ContractID : '');
                        var Invoicegenerated = obj.invoiceGenerated;
                        var CurrentStatus = obj.currentStatus;
                        var Amount = obj.amount;
                        strHTML += '<tr><td class="text-centre">' + obj.rfiid + '<input hidden type="text" value=' + obj.rfiid + '></td>';
                        if (obj.isProforma == false) {
                            if (EditAccess == 'True' || ViewAccess == 'True') {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit" onclick="EditIRPIR(' + obj.rfiid + ', undefined, ' + rowProjectIdArg + ');" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_Edit_Screen" aria-controls="offcanvasWithBothOptions">' + IR + '</a></td>';
                            } else {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit">' + IR + '</a></td>';
                            }
                        } else {
                            if (EditAccess == 'True' || ViewAccess == 'True') {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit" onclick="EditIRPIR(' + obj.rfiid + ', undefined, ' + rowProjectIdArg + ');" data-bs-toggle="offcanvas" data-bs-target="#offcvsIRPIR_Edit_Screen" aria-controls="offcanvasWithBothOptions">' + PIR + '</a></td>';
                            } else {
                                strHTML += '<td class="text-centre"><a href="javascript:;" id="AEdit">' + PIR + '</a></td>';
                            }

                        }
                        strHTML += '<td class="text-centre">' + obj.projectName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.customerName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.rfiTypeName + '</td>';
                        strHTML += '<td class="text-centre">' + obj.rfiRaisedOn + '</td>';
                        strHTML += '<td><span class="blue-text">' + obj.billingCurrencySymbol + '</span> ' + obj.amount + '</td>';
                        //strHTML += '<td><span class="blue-text">' + CompanyBaseCurrencySymbol + '</span> ' + obj.amount + '</td>';
                        strHTML += '<td class="text-centre">' + obj.equivAmount + '</td>';
                        strHTML += '<td><span class="blue-text">' + obj.baseCurrencySymbol + '</span> ' + obj.companyBaseCurrencyAmount + '</td>';
                        //strHTML += '<td><span class="blue-text">' + CompanyBaseCurrencySymbol + '</span> ' + obj.companyBaseCurrencyAmount + '</td>';
                        // Added By Vishal Mane on 01/04/2026 - Open main page status history in dedicated offcanvas instead of modal.
                        // Changed By Vyankat B. on 27 th April 2026 for showing history on icon click next to status.
                        if (obj.currentStatus == "Submitted") {
                            // Added By Vishal Mane on 01/04/2026 - Submitted status now opens the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusSubmitted mx-2' data-bs-toggle='tooltip' title='Submitted'>&nbsp;</span><label data-bs-toggle='tooltip' title='Submitted'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        } else if (obj.currentStatus == "Approved") {
                            // Added By Vishal Mane on 01/04/2026 - Approved status now opens the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusApproved mx-2' data-bs-toggle='tooltip' title='Approved'>&nbsp;</span><label data-bs-toggle='tooltip' title='Approved'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        } else if (obj.currentStatus == "Rejected") {
                            // Added By Vishal Mane on 01/04/2026 - Rejected status now opens the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusRejected mx-2' data-bs-toggle='tooltip' title='Rejected'>&nbsp;</span><label data-bs-toggle='tooltip' title='Rejected'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        } else if (obj.currentStatus == "Re-Submitted") {
                            // Added By Vishal Mane on 01/04/2026 - Re-Submitted status now opens the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusReSubmitted mx-2' data-bs-toggle='tooltip' title='Re-Submitted'>&nbsp;</span><label data-bs-toggle='tooltip' title='Re-Submitted'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        } else if (obj.currentStatus == "Cancelled") {
                            // Added By Vishal Mane on 01/04/2026 - Cancelled status now opens the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusCancelled mx-2' data-bs-toggle='tooltip' title='Cancelled'>&nbsp;</span><label data-bs-toggle='tooltip' title='Cancelled'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        } else if (obj.currentStatus == "Closed") {
                            // Added By Vishal Mane on 01/04/2026 - Closed status now opens the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusClosed mx-2' data-bs-toggle='tooltip' title='Closed'>&nbsp;</span><label data-bs-toggle='tooltip' title='Closed'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        } else if (obj.currentStatus == "Draft") {
                            // Added By Vishal Mane on 01/04/2026 - Draft status now opens the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusDraft mx-2' data-bs-toggle='tooltip' title='Draft'>&nbsp;</span><label data-bs-toggle='tooltip' title='Draft'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        }
                        else if (obj.currentStatus == "Revenue Reversed" || obj.currentStatus == "Partially Reversed") {
                            // Added By Vishal Mane on 01/04/2026 - Reversed statuses now open the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusDraft mx-2' data-bs-toggle='tooltip' title='Revenue Reversed'>&nbsp;</span><label data-bs-toggle='tooltip' title='Revenue Reversed'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        }
                        else {
                            // Added By Vishal Mane on 01/04/2026 - Unknown statuses now open the main page history offcanvas.
                            strHTML += "<td><span class='ir-status-inline'><span class='statusBox statusDraft mx-2' data-bs-toggle='tooltip' title='Draft'>&nbsp;</span><label data-bs-toggle='tooltip' title='Unknown'>" + obj.currentStatus + "</label><a href='javascript: ;' class='ms-1' data-bs-toggle='offcanvas' onclick='GetRFIStatusHistory_MainPage(" + obj.rfiid + "," + rowProjectIdArg + ")' data-bs-target='#offcvsIRShowHistory_MainPageNow'><i class='fas fa-history textOrange crsrLink' data-bs-toggle='tooltip' title='Show History'></i></a></span></td>";
                        }
                        // End of Changed By Vyankat B. on 27 th April 2026 for showing history on icon click next to status.
                        //Commented and Added By Vishal Mane on 30/03/2026
                        //strHTML += `<td>
                        //    <div class="statusDiv d-flex justify-content-start">
                        //        <span class="statusBox statusSubmitted mx-2">&nbsp;</span>
                        //        <a href="javascript:;" data-bs-toggle="modal" data-bs-target="#IRPIR_StatHistorymodal">
                        //            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Submitted">Submitted</label>
                        //        </a>
                        //    </div>
                        //</td>`
                        if (EditAccess == 'True' || AddAccess == 'True') {
                            if (obj.currentStatus == "Submitted" || obj.currentStatus == "Re-Submitted") {
                                strHTML += `<td>
                                            <a href="javascript:;" class="ir-grid-change-status" data-rfi-id="${obj.rfiid}" data-project-id="${(rowProjectId != null && rowProjectId !== '') ? rowProjectId : ''}" data-contract-id="${(rowContractId != null && rowContractId !== '') ? rowContractId : ''}" data-rfi-raised-by="${encodeURIComponent(rowRaisedBy)}" data-bs-toggle="modal" data-bs-target="#ChangeIRPIR_StatusModal" onclick="irChangeStatusFromRow(this);"><img
                                                src="../../../Whizible2.0-new/dist/img/changestatus.svg" alt="change status"
                                                data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Change Status" width="22" /></a>
                                        </td>`
                            }
                            else {
                                strHTML += `<td>
                                            <a href="javascript:;" onclick="return false;" aria-disabled="true" style="cursor: not-allowed;">
                                                <img
                                                src="../../../Whizible2.0-new/dist/img/changestatus.svg" alt="change status"
                                                data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Change Status" width="22" /></a>
                                        </td>`
                            }
                        }
                        else {
                            strHTML += `<td>
                                            <a href="javascript:;" onclick="return false;" aria-disabled="true" style="cursor: not-allowed;">
                                                <img
                                                src="../../../Whizible2.0-new/dist/img/changestatus.svg" alt="change status"
                                                data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Change Status" width="22" /></a>
                                        </td>`
                        }
                        if (EditAccess == 'True' || AddAccess == 'True') {
                            strHTML += `<td>
                                            <a href="javascript:;" data-bs-toggle="offcanvas" data-bs-target="#offcanvas_ViewReport" aria-controls="offcanvasWithBothOptions" onclick="GetInvoiceNo(${obj.rfiid});">
                                                <i class="fas fa-print text-danger" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Print IR Report" title="Print IR Report"></i>
                                            </a>
                                        </td>`
                        } else {
                            strHTML += `<td>
                                            <a href="javascript:;" onclick="return false;" aria-disabled="true" style="cursor: not-allowed;">
                                                <i class="fas fa-print text-danger" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" aria-label="Print IR Report" title="Print IR Report"></i>
                                            </a>
                                        </td>`
                        }
                        //End of Commented and Added By Vishal Mane on 30/03/2026
                        
                    });
                }
            }
            $("#IRPIR_ApprovalTbl_Body").html(strHTML);
            
            $("#IRPIR_ApprovalTbl").DataTable({
                scrollY: true,
                scrollX: true,
                scrollCollapse: true,
                paging: true,
                lengthChange: false,
                searching: false,
                ordering: false,
                responsive: true,
                destroy: true,
                info: false,
                autoWidth: false,
                pageLength: 5
            });
            irMainTable = $("#IRPIR_ApprovalTbl").DataTable();
            irMainTable.off('draw').on('draw', function () {
                updateIrMainPagination();
                irBindBootstrapTooltips($('#IRPIR_ApprovalTbl'));
            });
            updateIrMainPagination();
            irBindBootstrapTooltips($('#IRPIR_ApprovalTbl'));
            resizeSection();
        }

        function GetInvoiceNo(id) {
            $("#cboInvoiceNumber").val(0);
            $(".selectpicker").selectpicker('refresh');
        }

        var G_ChangeStatus_RFIID = 0;
        /** Project ID for the IR row when changing status from the main grid (not the header cboProject filter). */
        var G_ChangeStatus_ProjectID = 0;
        /** Reads data-rfi-id / data-project-id / data-rfi-raised-by so onclick is not broken by quotes inside RFIRaisedBy (JSON.stringify in double-quoted onclick truncates the attribute). */
        function irChangeStatusFromRow(anchorEl) {
            if (!anchorEl) return;
            var id = parseInt(String(anchorEl.getAttribute('data-rfi-id') || ''), 10);
            var projAttr = anchorEl.getAttribute('data-project-id');
            var cidAttr = anchorEl.getAttribute('data-contract-id');
            if (cidAttr != null && String(cidAttr).trim() !== '') {
                var c = parseInt(String(cidAttr).trim(), 10);
                GContractID = (!isNaN(c) && c > 0) ? c : null;
            } else {
                GContractID = null;
            }
            var enc = anchorEl.getAttribute('data-rfi-raised-by');
            var raisedBy = '';
            if (enc != null && enc !== '') {
                try {
                    raisedBy = decodeURIComponent(enc);
                } catch (ignore) {
                    raisedBy = enc;
                }
            }
            ChangeStatusRFIID(id, raisedBy, projAttr);
        }
        function ChangeStatusRFIID(RFIID, rfiRaisedByFromRow, projectIdFromContext) {
            
            G_ChangeStatus_RFIID = RFIID;
            // Grid "Change Status" passes 3 args; edit load passes 1. Clear item IDs when switching from grid so we do not reuse another IR's lines.
            if (arguments.length >= 3) {
                RFIItemAdvisedIDs = [];
            }
            if (arguments.length > 1 && rfiRaisedByFromRow !== undefined) {
                rFIRaisedBy = rfiRaisedByFromRow;
            }
            var parsedProj = 0;
            if (arguments.length > 2 && projectIdFromContext != null && String(projectIdFromContext).trim() !== '') {
                parsedProj = parseInt(String(projectIdFromContext).trim(), 10);
                G_ChangeStatus_ProjectID = isNaN(parsedProj) ? 0 : parsedProj;
            } else if (typeof EditGlobalProjectID !== 'undefined' && EditGlobalProjectID != null && String(EditGlobalProjectID).trim() !== '') {
                parsedProj = parseInt(String(EditGlobalProjectID).trim(), 10);
                G_ChangeStatus_ProjectID = isNaN(parsedProj) ? 0 : parsedProj;
            } else {
                G_ChangeStatus_ProjectID = 0;
            }
            //Added By Vishal Mane on 30/03/2026
            $("#statusHisInput").val("");
            $("#commentStatHisInput").val("");
            $("#statusHisInput").val('').selectpicker('refresh');
            // Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
            irApplyStatusDotsToSelect($("#statusHisInput"));
            // End of Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
            //End of Added By Vishal Mane on 30/03/2026
        }

        function ChangeStatusRFIIDEdit() {
            // Align change-status context with the IR currently open in the edit offcanvas (not a previous grid action).
            if (typeof EditGlobalIRID !== 'undefined' && EditGlobalIRID != null && EditGlobalIRID !== '') {
                G_ChangeStatus_RFIID = EditGlobalIRID;
            }
            var pid = 0;
            if (typeof EditGlobalProjectID !== 'undefined' && EditGlobalProjectID != null && EditGlobalProjectID !== '' && !isNaN(EditGlobalProjectID)) {
                pid = parseInt(String(EditGlobalProjectID), 10);
            }
            if (!pid || isNaN(pid)) {
                pid = parseInt(String($("#cboProject").val() || '0'), 10) || 0;
            }
            if (!pid && typeof SessionProjectID !== 'undefined' && SessionProjectID != null && String(SessionProjectID).trim() !== '') {
                pid = parseInt(String(SessionProjectID).trim(), 10) || 0;
            }
            G_ChangeStatus_ProjectID = pid || 0;
            //Added By Vishal Mane on 30/03/2026
            $("#statusHisInput").val("");
            $("#commentStatHisInput").val("");
            $("#statusHisInput").val('').selectpicker('refresh');
            // Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
            irApplyStatusDotsToSelect($("#statusHisInput"));
            // End of Added By Vyankat B. on 24 th April 2026 for status color dots in status dropdowns
            //End of Added By Vishal Mane on 30/03/2026
        }

        /** Loads RFI line-item IDs for GetValidApprove when Change Status was opened from the grid (edit offcanvas loads them in EditIRPIR). */
        function irEnsureRFIItemAdvisedIDs(rfiId) {
            if (!rfiId) {
                return;
            }
            if (RFIItemAdvisedIDs && RFIItemAdvisedIDs.length > 0) {
                return;
            }
            var param = {
                rfiItemID: null,
                rfiid: rfiId
            };
            try {
                var result = AJAXCallWithResult(
                    'api/IRApproval/GetRFIItems',
                    JSON.stringify(param),
                    false
                );
                var list = [];
                if (result && result.rfiItems && result.rfiItems.RFIItemsResponse) {
                    list = result.rfiItems.RFIItemsResponse;
                }
                RFIItemAdvisedIDs = [];
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var isTotalRow = (item.description === 'Total Amount');
                    var rid = item.rfiItemID != null ? item.rfiItemID : (item.RFIItemID != null ? item.RFIItemID : null);
                    if (!isTotalRow && rid != null && rid !== undefined) {
                        RFIItemAdvisedIDs.push(rid);
                    }
                }
            } catch (e) {
                console.error('irEnsureRFIItemAdvisedIDs', e);
            }
        }

        /** Sets GContractID for GetValidApprove when Change Status was opened from the grid (edit path sets it from GetRFIsDetails). */
        function irEnsureGContractID(rfiId) {
            if (!rfiId) {
                return;
            }
            var gc = GContractID;
            if (gc != null && gc !== '' && !isNaN(gc) && parseInt(String(gc), 10) > 0) {
                return;
            }
            var detailsParam = { rfiid: rfiId };
            try {
                var detailsResult = AJAXCallWithResult(
                    'api/IRApproval/GetRFIsDetails',
                    JSON.stringify(detailsParam),
                    false
                );
                var detailsList = (detailsResult &&
                    detailsResult.rfisDetails &&
                    Array.isArray(detailsResult.rfisDetails.RFIsDetailsResponse))
                    ? detailsResult.rfisDetails.RFIsDetailsResponse
                    : [];
                if (detailsList.length > 0) {
                    var d = detailsList[0];
                    var cid = d.contractID != null ? d.contractID : (d.ContractID != null ? d.ContractID : null);
                    if (cid != null && cid !== '' && !isNaN(cid)) {
                        GContractID = parseInt(String(cid), 10);
                    }
                }
            } catch (e) {
                console.error('irEnsureGContractID', e);
            }
        }

        function InsertRFIStatusHistory() {
            alertify.set('notifier', 'position', 'top-right');
            var status = $('#statusHisInput').val();
            var comments = $('#commentStatHisInput').val().trim();
            if (!status) {
                // Added By Vyankat B. on 30th March 2026 for IR status alert resource
                alertify.error('<%=MyBase.GetResourceString("A_PleaseSelectStatus")%>');
                // End of Added By Vyankat B. on 30th March 2026 for IR status alert resource
                $('#statusHisInput').focus();
                return;
            }
            if (!comments) {
                // Added By Vyankat B. on 30th March 2026 for IR comments alert resource
                alertify.error('<%=MyBase.GetResourceString("A_PleaseEnterComments")%>');
                // End of Added By Vyankat B. on 30th March 2026 for IR comments alert resource
                $('#commentStatHisInput').focus();
                return;
            }

            irEnsureRFIItemAdvisedIDs(G_ChangeStatus_RFIID);
            irEnsureGContractID(G_ChangeStatus_RFIID);

            var Parameters = {
                ContractTypeID: GContractID,              
                AdvisedIDs: RFIItemAdvisedIDs.join(','),
                           
                RFIID: G_ChangeStatus_RFIID,
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult('api/IRApproval/GetValidApprove', param, false);
            var message = strResult?.data?.[0]?.message || "";
            if (message) {
                alertify.notify(message || '', 'error', 5);
            }


            if (!message) {

                var insertProjectID = (G_ChangeStatus_ProjectID > 0)
                    ? G_ChangeStatus_ProjectID
                    : (parseInt(String($("#cboProject").val() || '0'), 10) || 0);
                var ChecklistFields = {
                    RFIID: encodeURI(G_ChangeStatus_RFIID),
                    ProjectID: insertProjectID,
                    CurrentRFIStatus: status,
                    Comments: comments,
                    ChangedBy: UserName,
                    UserID: irApprovalUserID
                };
                var param = JSON.stringify(ChecklistFields);
                var strResult = AJAXCallWithResult('api/IRApproval/InsertRFIStatusHistory', param, false);
                strResult = strResult?.InsertRFIStatusHistoryResponse || [];
                if (strResult.length != 0) {

                    // Added by Vyankat B. on 26-Mar-2026 to show selected status in success message.

                    //alertify.success("IR-PIR"+" "+ + status +""+ "Successfully");
                    var statusText = ($('#statusHisInput option:selected').text() || status || '').trim();
                    alertify.success(`IR-PIR ${statusText} successfully`);

                    // End of Added by Vyankat B. on 26-Mar-2026 to show selected status in success message.

                    $("#cancelIRStatHisBtn").click();
                    GetIRPIRList($("#cboProject").val());
                }
                $("#ChangStatusEdtIRBtn").attr("disabled", true);

                // Send Mail Functionality on Change Status Save
                var msgID = 0;
                if (status === 'Approved') {
                    msgID = 52;
                } else if (status === 'Rejected') {
                    msgID = 53;
                } else if (status === 'Cancelled') {
                    msgID = 54;
                }
                
                var emailResult = null;
                var emailSubject = '';
                var emailBody = '';
                if (msgID > 0) {
                    var emailParam = JSON.stringify({
                        MessageID: msgID
                    });
                    emailResult = AJAXCallWithResult('api/IRApproval/GetEMessage', emailParam, false);
                    var emailRows = emailResult?.data || emailResult?.EMsgEntity || emailResult?.eMsgEntity || [];
                    if (emailRows && emailRows.length > 0) {
                        var firstEmail = emailRows[0] || {};
                        emailSubject = firstEmail.subject || firstEmail.Subject || firstEmail.emailSubject || firstEmail.EmailSubject || '';
                        emailBody = firstEmail.body || firstEmail.Body || firstEmail.emailBody || firstEmail.EmailBody || '';
                    }
                }
                var toParam = JSON.stringify({
                    UserName: String(rFIRaisedBy || ''),
                    RFIID: G_ChangeStatus_RFIID
                });
                var toMailResult = AJAXCallWithResult('api/IRApproval/GetToMail', toParam, false);
                var toMailRows = toMailResult?.data?.data || toMailResult?.data || toMailResult?.employeeToMailResponse || [];

                var fromParam = JSON.stringify({
                    EmpID: irApprovalUserID
                });
                var fromMailResult = AJAXCallWithResult('api/IRApproval/GetFromMail', fromParam, false);
                var fromMailRows = fromMailResult?.data?.data || fromMailResult?.data || fromMailResult?.employeeToMailResponse || [];


                var CCParam = JSON.stringify({
                    EmpID: irApprovalUserID,
                    RFIID: encodeURI(G_ChangeStatus_RFIID),
                });
                var CCMailResult = AJAXCallWithResult('api/IRApproval/GetCCMail', CCParam, false);
                var ccEmailID = CCMailResult?.data?.data || CCMailResult?.data || CCMailResult?.employeeCCMailResponse || [];


                var ProjName = (ccEmailID && ccEmailID.length > 0)
                    ? (ccEmailID[0].projectName || ccEmailID[0].projectName || ccEmailID[0].projectName || '')
                    : '';
                
                var ccEmailID = (ccEmailID && ccEmailID.length > 0)
                    ? (ccEmailID[0].emailID || ccEmailID[0].EmailID || ccEmailID[0].emailId || '')
                    : '';

                //var cancelledChangedOn = (ccEmailID && ccEmailID.length > 0)
                //    ? (ccEmailID[0].cancelledChangedOn || ccEmailID[0].cancelledChangedOn || ccEmailID[0].cancelledChangedOn || '')
                //    : '';

                //var rejectedChangedOn = (ccEmailID && ccEmailID.length > 0)
                //    ? (ccEmailID[0].rejectedChangedOn || ccEmailID[0].rejectedChangedOn || ccEmailID[0].rejectedChangedOn || '')
                //    : '';

                //if (status === 'Rejected') {
                   
                //    rFIRaisedOn = rejectedChangedOn;
                //} else if (status === 'Cancelled') {
                 
                //    rFIRaisedOn = cancelledChangedOn;
                //}

                var toEmailID = (toMailRows && toMailRows.length > 0)
                    ? (toMailRows[0].emailID || toMailRows[0].EmailID || toMailRows[0].emailId || '')
                    : '';
                var fromEmailID = (fromMailRows && fromMailRows.length > 0)
                    ? (fromMailRows[0].emailID || fromMailRows[0].EmailID || fromMailRows[0].emailId || '')
                    : '';
                var senderName = (fromMailRows && fromMailRows.length > 0)
                    ? (fromMailRows[0].userName || fromMailRows[0].UserName || fromMailRows[0].employeeName || fromMailRows[0].EmployeeName || UserName || '')
                    : (UserName || '');
                var projectName = ProjName;
                var irID = String(G_ChangeStatus_RFIID || '');
                // Human-readable date for mail body (API may return "2025-12-17 00:00:00.000" or ISO).
                var raisedOnText = '';
                (function () {
                    var raw = String(rFIRaisedOn || '').trim();
                    if (!raw) return;
                    var norm = raw.indexOf('T') >= 0 ? raw : raw.replace(' ', 'T');
                    var d = new Date(norm);
                    raisedOnText = isNaN(d.getTime())
                        ? raw
                        : d.toLocaleString('en-US', { month: 'short', day: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', hour12: true });
                })();
                var commentPlain = String(comments || '').trim();

                if (msgID > 0 && emailSubject && emailBody) {
                    // Mail subject cannot contain CR/LF or tab characters.
                    var finalSubject = String(emailSubject || '')
                        .replace(/<PROJECT_NAME>/g, projectName)
                        .replace(/<RFI_ID>/g, irID)
                        .replace(/[\r\n\t]+/g, ' ')
                        .replace(/\s{2,}/g, ' ')
                        .trim();
                    // SendDevDashEmail uses IsBodyHtml = true: plain \n does not show as line breaks — use <br/>.
                    function irEscapeHtml(s) {
                        return String(s || '')
                            .replace(/&/g, '&amp;')
                            .replace(/</g, '&lt;')
                            .replace(/>/g, '&gt;')
                            .replace(/"/g, '&quot;');
                    }
                    var commentByName = (typeof UserName !== 'undefined' && UserName) ? UserName : String(senderName || '');
                    var commentWhen = new Date().toLocaleString('en-US', {
                        month: 'short',
                        day: '2-digit',
                        year: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit',
                        hour12: true
                    }).replace(',', '');
                    var commentHtml =
                        'Comment added by ' + irEscapeHtml(commentByName) + ' on ' + irEscapeHtml(commentWhen) + '<br/><br/>' +
                        irEscapeHtml(commentPlain)
                            .replace(/\r\n/g, '<br/>')
                            .replace(/\r/g, '<br/>')
                            .replace(/\n/g, '<br/>');
                    var finalBody = String(emailBody || '')
                        .replace(/<NAME>/g, irEscapeHtml(rFIRaisedBy))
                        .replace(/<PROJECT_NAME>/g, irEscapeHtml(projectName))
                        .replace(/<RFI_ID>/g, irEscapeHtml(irID))
                        //.replace(/<RFI_RAISED_ON>/g, irEscapeHtml(raisedOnText))
                        .replace(/<COMMENTS>/g, commentHtml)
                        .replace(/<SENDER_NAME>/g, irEscapeHtml(senderName));
                    finalBody = finalBody
                        .replace(/\r\n/g, '<br/>')
                        .replace(/\r/g, '<br/>')
                        .replace(/\n/g, '<br/>')
                        .replace(/\t/g, '&nbsp;&nbsp;&nbsp;&nbsp;');

                    var postParams = {
                        issueID: 0,
                        ccEmailID: ccEmailID,
                        toEmailID: toEmailID,
                        fromEmailID: fromEmailID,
                        subject: finalSubject,
                        body: finalBody
                    };


                    var postUrl = "api/DeveloperDashEnView/SendDevDashEmail";
                    var sendEmailResult = AJAXCallWithResult(postUrl, JSON.stringify(postParams), false);
                    alertify.set('notifier', 'position', 'top-right');
                    var sendOk = sendEmailResult && (sendEmailResult.status === true || sendEmailResult.Status === true);
                    var sendMsg = (sendEmailResult && (sendEmailResult.message || sendEmailResult.Message)) || '';
                    if (sendOk) {
                        alertify.notify(sendMsg || 'Email sent successfully', 'success', 5);
                    } else {
                        alertify.notify(sendMsg || 'Email could not be sent', 'error', 5);
                    }
                }


            }

            
        }

        function resizeSection() {
            var tblheight = $(window).height();
            // Added or Modified by Vishal Mane on 26/03/2026 to avoid blank space and keep custom footer visible
            $('#IRPIR_ApprovalTbl_wrapper .dataTables_scrollBody').css({ 'height': 'auto', 'max-height': (tblheight - 250), "overflow-y": "auto" });
        }        
        function GetRFIStatusHistory(RFIID) {
            var strHTML = "";
            $("#PIRstatushistoryTbl").dataTable().fnDestroy();
            var ProjectID = $("#cboProject").val();
            var ChecklistFields = {
                RFIID: encodeURI(RFIID),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ChecklistFields)
            //var strResult = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIStatusHistory", param, false);
            var strResult = AJAXCallWithResult('api/IRApproval/GetRFIStatusHistory', param, false);
            strResult = strResult?.RFIStatusHistoryResponse || [];
            if (strResult.length != 0) {
                $.each(strResult, function (index, obj) {
                    if (obj.currentRFIStatus == "Rejected") {
                        strHTML += '<tr><td class="text-centre red-text">' + obj.currentRFIStatus + '</td>';
                    } else {
                        strHTML += '<tr><td class="text-centre">' + obj.currentRFIStatus + '</td>';
                    }
                    //strHTML += '<tr><td class="text-centre">' + obj.CurrentRFIStatus + '</td>';
                    strHTML += '<td class="text-centre">' + obj.changedBy + '</td>';
                    strHTML += '<td class="text-centre">' + obj.changedOn + '</td>';
                    if (obj.comments == null) {
                        strHTML += '<td class="text-centre"></td></tr>';
                    } else {
                        strHTML += '<td class="text-centre">' + obj.comments + '</td></tr>';
                    }

                });
            }
            $("#PIRstatushistoryTbl_Body").html(strHTML);
            $('#PIRstatushistoryTbl').dataTable({
                //scrollY: true,
                //scrollX: true,
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": true,
                "retrieve": false,
                "bFilter": false,
                "ordering": false,
                "info": false
            });
            pirStatusHistoryTable = $('#PIRstatushistoryTbl').DataTable();
            pirStatusHistoryTable.off('draw').on('draw', function () {
                updatePirStatusPagination();
            });
            updatePirStatusPagination();
            //resizeSection();
        }

        // Added By Vishal Mane on 01/04/2026 - Dedicated status history binder for main page offcanvas.
        function GetRFIStatusHistory_MainPage(RFIID, projectIdFromRow) {
            // Added By Vishal Mane on 01/04/2026 - Prepare HTML buffer for main page offcanvas history rows.
            var strHTML = "";
            // Added By Vishal Mane on 01/04/2026 - Safely destroy previous DataTable instance for main page offcanvas history.
            if ($.fn.DataTable.isDataTable('#PIRstatushistoryTbl_MainPage')) {
                $('#PIRstatushistoryTbl_MainPage').DataTable().destroy();
            }
            // Use project from the grid row when provided; otherwise fall back to header dropdown.
            var ProjectID = projectIdFromRow;
            if (ProjectID === null || ProjectID === undefined || ProjectID === "" || ProjectID === "0") {
                ProjectID = $("#cboProject").val();
            }
            // Added By Vishal Mane on 01/04/2026 - Build request payload for main page offcanvas history.
            var ChecklistFields = {
                RFIID: encodeURI(RFIID),
                ProjectID: encodeURI(ProjectID),
            };
            // Added By Vishal Mane on 01/04/2026 - Serialize payload before API call.
            var param = JSON.stringify(ChecklistFields);
            // Added By Vishal Mane on 01/04/2026 - Call status history API for main page offcanvas.
            var strResult = AJAXCallWithResult('api/IRApproval/GetRFIStatusHistory', param, false);
            // Added By Vishal Mane on 01/04/2026 - Normalize API response array for main page offcanvas.
            strResult = strResult?.RFIStatusHistoryResponse || [];
            // Added By Vishal Mane on 01/04/2026 - Build history table rows when response contains data.
            if (strResult.length != 0) {
                $.each(strResult, function (index, obj) {
                    var st = irEscapeHtml(String(obj.currentRFIStatus || ''));
                    var by = irEscapeHtml(String(obj.changedBy || ''));
                    var onText = irEscapeHtml(String(irFormatAuditModifiedDate(obj.changedOn || obj.ChangedOn || '') || ''));
                    if (onText === '') {
                        onText = irEscapeHtml(String(obj.changedOn || obj.ChangedOn || ''));
                    }
                    if (obj.currentRFIStatus == "Rejected") {
                        strHTML += '<tr><td class="text-centre red-text">' + st + '</td>';
                    } else {
                        strHTML += '<tr><td class="text-centre">' + st + '</td>';
                    }
                    strHTML += '<td class="text-centre">' + by + '</td>';
                    strHTML += '<td class="text-centre">' + onText + '</td>';
                    var cm = (obj.comments == null || obj.comments === undefined) ? '' : String(obj.comments).trim();
                    if (cm === '') {
                        strHTML += '<td class="text-centre"></td></tr>';
                    } else {
                        strHTML += '<td class="text-centre">' + irStatusHistoryCommentHtml(obj.comments) + '</td></tr>';
                    }
                });
            }
            // Added By Vishal Mane on 01/04/2026 - Inject built rows into the main page offcanvas history tbody.
            $("#PIRstatushistoryTbl_Body_MainPage").html(strHTML);
            // Added By Vishal Mane on 01/04/2026 - Initialize DataTable for main page offcanvas history.
            pirStatusHistoryMainPageTable = $('#PIRstatushistoryTbl_MainPage').DataTable({
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": false,
                "autoWidth": false,
                "destroy": true,
                "retrieve": false,
                "info": false
            });
            pirStatusHistoryMainPageTable.off('draw').on('draw', function () {
                updatePirStatusPagination_MainPage();
                irBindBootstrapTooltips($('#PIRstatushistoryTbl_MainPage'));
            });
            updatePirStatusPagination_MainPage();
            irBindBootstrapTooltips($('#PIRstatushistoryTbl_MainPage'));
        }
        var BillingCurrencyID = "";
        var BillingCurrencyCode = "";
        var BillingCurrencySymbol = "";
        var CorporateBaseCurrencyID = "";
        var CorporateBaseCurrencyCode = "";
        var CorporateBaseCurrencySymbol = "";
        var CompanyBaseCurrencyID = "";
        var CompanyBaseCurrencyCode = "";
        var CompanyBaseCurrencySymbol = "";        
        var BillingToBaseConversionRate = "";
        var LocalToBaseConversionRate = "";
        var CompanyBaseCurrencyConversionRate = "";        
        var BaseCurrencyAmount = "";
        var CompanyBaseCurrencyAmount = "";

        function GetGlobalCurrencies(ProjectID) {
            var ProjectID = $("#cboProject").val();
            var RequestParameters = {
                ProjectID: ProjectID
            }
            var param = JSON.stringify(RequestParameters);
            //var Result =  AJAXCallWithResult("/api/RFI_IR_PIR/GetGlobalCurrencies", param, false);
            var Result = AJAXCallWithResult('api/IRApproval/GetGlobalCurrencies', param, false);            
            var currencyData = Result?.rfiApprovals?.RFIsGlobalCurrencies;
            if (currencyData && currencyData.length > 0) {
                var data = currencyData[0];
                BillingCurrencyID = data.billingCurrencyID;
                BillingCurrencyCode = data.billingCurrencyCode;
                CorporateBaseCurrencyID = data.corporateBaseCurrencyID;
                CorporateBaseCurrencyCode = data.corporateBaseCurrencyCode;
                CompanyBaseCurrencyID = data.companyBaseCurrencyID;
                CompanyBaseCurrencyCode = data.companyBaseCurrencyCode;
                BillingCurrencySymbol = data.billingCurrencySymbol;
                CorporateBaseCurrencySymbol = data.corporateBaseCurrencySymbol;
                CompanyBaseCurrencySymbol = data.companyBaseCurrencySymbol;
            }
            else {
                console.error("No currency data found");
            }
        }
        function showLoader() {
            document.getElementById('loaderOverlay').style.display = 'block';
            loaderShown = true;
            loaderStartTime = Date.now();
        }
        function GenerateIRApprovalPdf(format) {
            
            var IsInvoiceValidated = ValidateInvoiceNumber();
            if (IsInvoiceValidated == 0) {
                //showLoader();
                var apiUrl = (format === 'PDF')
                    ? 'api/IRApproval/GenerateIRApprovalPdf'
                    : (format === 'EXCEL')
                        ? 'api/IRApproval/GenerateIRApprovalExcel'
                        : null;
                if (!apiUrl) {
                    hideLoader();
                    console.error('Unsupported export format:', format);
                    return;
                }
                var InvoiceNumber = $("#cboInvoiceNumber1").val();
                var param = {
                    InvoiceNumber: InvoiceNumber,
                    ReportFormat: format
                };
                var ext = (format === 'PDF') ? 'pdf' : 'xlsx';
                var today = getTodayYYYYMMDD(); // e.g. 20251223
                //var proj = defaultProjectName || getCurrentProjectName() || 'Project';
                var proj = 'IR_PIR';
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
                        // Keep Params header aligned with existing API calling pattern on this page.
                        if (typeof encryptString === 'function') {
                            xhr.setRequestHeader("Params", encryptString(JSON.stringify(param)));
                        }
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
                        console.error(`${format} export failed:`, xhr.status);
                        // Added By Vyankat B. on 30th March 2026 for IR PDF/Excel no-items alert resource
                        alertify.error('<%=MyBase.GetResourceString("A_NoItemsToShow")%>');
                        // End of Added By Vyankat B. on 30th March 2026 for IR PDF/Excel no-items alert resource
                    },

                    complete: function () {
                        if (typeof hideLoader === 'function') {
                            hideLoader();
                        }
                    }
                });
            }
        }

        var IsInvoiceValidated;
        function ValidateInvoiceNumber() {
            var IsInvoiceValidated = 0;
            var InvoiceNumber = $("#cboInvoiceNumber1").val();
            if (InvoiceNumber == 0) {
                alertify.set('notifier', 'position', 'top-right');
                // Added By Vyankat B. on 30th March 2026 for Invoice number blank alert resource
                alertify.error('<%=MyBase.GetResourceString("A_InvoiceNumberCannotBeBlank")%>');
                // End of Added By Vyankat B. on 30th March 2026 for Invoice number blank alert resource
                $("#cboInvoiceNumber1").focus();
                IsInvoiceValidated = 1;
                return IsInvoiceValidated;
            } else {
                return IsInvoiceValidated;
            }
        }
        //End of Added by Vishal Mane on 17/03/2026 

        var IR_LONGTEXT_TOOLTIP_MAX = 50;
        function irEscapeHtml(s) {
            if (s == null || s === undefined) return '';
            return String(s)
                .replace(/&/g, '&amp;')
                .replace(/"/g, '&quot;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;');
        }
        /** Bootstrap 5 tooltips on dynamic table rows (same look as rest of page; avoids native title popup). */
        function irBindBootstrapTooltips($root) {
            if (!$root || !$root.length) return;
            if (typeof bootstrap === 'undefined' || !bootstrap.Tooltip) return;
            $root.find('[data-bs-toggle="tooltip"]').each(function () {
                var el = this;
                try {
                    var inst = bootstrap.Tooltip.getInstance(el);
                    if (inst) inst.dispose();
                } catch (ignore) { }
                new bootstrap.Tooltip(el, { container: 'body', placement: 'top', html: false, trigger: 'hover focus' });
            });
        }

        /** Main page status history: comments ellipsis in cell; full text in Bootstrap tooltip on hover. */
        function irStatusHistoryCommentHtml(raw) {
            var t = (raw == null || raw === undefined) ? '' : String(raw);
            if (!t) return '';
            var esc = irEscapeHtml(t);
            return '<span class="ir-status-hist-comment-tip" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" data-bs-html="false" title="' + esc + '">' + esc + '</span>';
        }

        /** Show full text in Bootstrap tooltip when longer than maxLen characters. */
        function irFormatLongTextTooltip(text, maxLen) {
            maxLen = maxLen || IR_LONGTEXT_TOOLTIP_MAX;
            var t = (text == null || text === undefined) ? '' : String(text);
            if (t.length <= maxLen) {
                return irEscapeHtml(t);
            }
            return '<span class="ir-longtext-tip" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" data-bs-html="false" title="' + irEscapeHtml(t) + '">'
                + irEscapeHtml(t.substring(0, maxLen)) + '...</span>';
        }
        function irInitTableTooltips($table) {
            if (!$table || !$table.length) return;
            $table.find('.ir-longtext-tip').each(function () {
                var el = this;
                if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
                    var inst = bootstrap.Tooltip.getInstance(el);
                    if (inst) inst.dispose();
                    new bootstrap.Tooltip(el, { container: 'body', html: false });
                } else if (typeof $(el).tooltip === 'function') {
                    try { $(el).tooltip('dispose'); } catch (x) { }
                    $(el).tooltip({ container: 'body' });
                }
            });
        }

        //Added By Vaibhav K on 18-03-2026 - Bind IR_ChecklistTbl from GetRFIChecklistInstanceItems API
        function loadRFIChecklistItems() {
            var $tbody = $('#IR_ChecklistTbl tbody');
            $tbody.html('<tr><td colspan="4" class="text-center">Loading...</td></tr>');
            var param = {
                rfiid: EditGlobalIRID,
            };
            try {
                var result = AJAXCallWithResult(
                    'api/IRApproval/GetRFIChecklistInstanceItems',
                    JSON.stringify(param),
                    false
                );
                var list = [];
                if (
                    result &&
                    result.rfiChecklistInstanceItems &&
                    result.rfiChecklistInstanceItems.RFIChecklistInstanceItemsResponse
                ) {
                    list = result.rfiChecklistInstanceItems.RFIChecklistInstanceItemsResponse;
                }
                // Destroy existing DataTable instance before touching the DOM
                if (irChecklistTable) {
                    irChecklistTable.destroy();
                    irChecklistTable = null;
                }
                $tbody.empty();
                if (!list.length) {
                    $tbody.html('<tr><td colspan="4" class="text-center">No records found.</td></tr>');
                    updateIrChecklistPagination();
                    return;
                }
                for (var i = 0; i < list.length; i++) {
                    var item = list[i];
                    var srNo = i + 1;
                    var desc = item.rfiChecklistItem || item.RFIChecklistItem || '';
                    var resp = item.rfiChecklistItemResponse || item.RFIChecklistItemResponse || '';
                    var comment = item.comments != null ? item.comments : (item.Comments != null ? item.Comments : '');
                    $tbody.append(
                        '<tr>'
                        + '<td>' + srNo + '</td>'
                        + '<td>' + irFormatLongTextTooltip(desc, 50) + '</td>'
                        + '<td>' + irEscapeHtml(String(resp)) + '</td>'
                        + '<td>' + irFormatLongTextTooltip(comment, 50) + '</td>'
                        + '</tr>'
                    );
                }
                // Re-initialise DataTable
                irChecklistTable = $('#IR_ChecklistTbl').DataTable({
                    "paging": true,
                    "pageLength": 5,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "info": false
                });
                irChecklistTable.on('draw', function () {
                    updateIrChecklistPagination();
                    irInitTableTooltips($('#IR_ChecklistTbl'));
                });
                updateIrChecklistPagination();
                irInitTableTooltips($('#IR_ChecklistTbl'));
            } catch (e) {
                console.error('Error loading RFI checklist items:', e);
                $tbody.html('<tr><td colspan="4" class="text-center text-danger">Failed to load checklist items.</td></tr>');
            }
        }
        // Trigger on View Checklist offcanvas open
        $('#offcvsViewChecklist').on('shown.bs.offcanvas', function () {
            loadRFIChecklistItems();
        });
        // Keep opacity state in sync with actual offcanvas visibility (prevents first-click flicker/race).
        function syncIROffcanvasOpacityState() {
            var isParentOpen = $('#offcvsIRPIR_Edit_Screen').hasClass('show');
            var isChildOpen =
                $('#offcvsViewChecklist').hasClass('show') ||
                $('#offcvsIRShowHistory').hasClass('show') ||
                $('#offcvsCustomerAddress').hasClass('show') ||
                $('#ShowContractDtlsModal').hasClass('open');
            $('body').toggleClass('ir-parent-offcanvas-open', isParentOpen);
            $('body').toggleClass('ir-child-offcanvas-open', isParentOpen && isChildOpen);
        }
        $('#offcvsIRPIR_Edit_Screen, #offcvsViewChecklist, #offcvsIRShowHistory, #offcvsCustomerAddress')
            .on('show.bs.offcanvas shown.bs.offcanvas hide.bs.offcanvas hidden.bs.offcanvas', function () {
                // Bootstrap updates .show during transition; queue sync to next tick for correct state.
                setTimeout(syncIROffcanvasOpacityState, 0);
            });
        // Close nested offcanvas on outside click: child first, then parent.
        $(document).on('mousedown', function (e) {
            // Modals (e.g. Change IR-PIR Status) are rendered outside the offcanvas in the DOM.
            // Clicks on the modal or its backdrop must not be treated as "outside parent" or the IR offcanvas closes too.
            if ($(e.target).closest('.modal.show').length > 0 || $(e.target).closest('.modal-backdrop').length > 0) {
                return;
            }
            // Customer Address offcanvas is a sibling of IR Approval in the DOM (not inside #offcvsIRPIR_Edit_Screen).
            // Clicks on its close (X) or body were treated as "outside parent" and closed IR Approval — skip while it is open.
            if ($('#offcvsCustomerAddress').hasClass('show')) {
                return;
            }
            var $checklist = $('#offcvsViewChecklist');
            var $history = $('#offcvsIRShowHistory');
            var $parent = $('#offcvsIRPIR_Edit_Screen');
            var checklistOpen = $checklist.hasClass('show');
            var historyOpen = $history.hasClass('show');
            var parentOpen = $parent.hasClass('show');
            var contractDetailsOpen = $('#ShowContractDtlsModal').hasClass('open');
            if (!checklistOpen && !historyOpen && !parentOpen && !contractDetailsOpen) return;

            var clickedInsideChecklist = $(e.target).closest('#offcvsViewChecklist').length > 0;
            var clickedInsideHistory = $(e.target).closest('#offcvsIRShowHistory').length > 0;
            var clickedInsideParent = $(e.target).closest('#offcvsIRPIR_Edit_Screen').length > 0;
            // Show Details uses a custom canvas + backdrop outside the parent offcanvas in the DOM.
            // Without this branch, backdrop clicks look "outside parent" and close IR Approval too.
            if (contractDetailsOpen) {
                var clickedInsideContract = $(e.target).closest('#ShowContractDtlsModal').length > 0;
                if (clickedInsideContract) return;
                if (typeof HideContractDetailsCanvas === 'function') {
                    HideContractDetailsCanvas();
                }
                return;
            }
            // If any child is open, first click outside child should close child
            // (even if that click is inside parent panel).
            if (checklistOpen || historyOpen) {
                if (clickedInsideChecklist || clickedInsideHistory) return;
                if (checklistOpen) {
                    bootstrap.Offcanvas.getOrCreateInstance($checklist[0]).hide();
                }
                if (historyOpen) {
                    bootstrap.Offcanvas.getOrCreateInstance($history[0]).hide();
                }
                return;
            }

            // No child open: close parent only when clicking outside parent.
            if (!clickedInsideParent && parentOpen) {
                bootstrap.Offcanvas.getOrCreateInstance($parent[0]).hide();
            }
        });
        var EditGlobalIRID;
        /** Project for the IR open in edit (from grid row click or GetRFIsDetails). */
        var EditGlobalProjectID = null;
        var customerID = null;
        var customerAddressID = null;
        var customerAddressList = [];
        /** Select/dropdown values are strings; empty string must not be sent as CustomerAddressID (API expects null). */
        function irNormalizeCustomerAddressId(v) {
            if (v === null || v === undefined) return null;
            if (v === '') return null;
            if (typeof v === 'string' && v.trim() === '') return null;
            var n = parseInt(String(v), 10);
            return isNaN(n) ? null : n;
        }

        var rFIRaisedBy;
        var rFIRaisedOn = '';
        var GContractID;

        var RFIItemAdvisedIDs = [];

        function EditIRPIR(IRID, flag, projectIdFromRow) {
            //debugger
            var offcanvasElement = document.getElementById('offcvsIRPIR_Edit_Screen');
            var bsOffcanvas = bootstrap.Offcanvas.getOrCreateInstance(offcanvasElement);
            // Prevent duplicate offcanvas show calls that can stack backdrops.
            if (!$(offcanvasElement).hasClass('show')) {
                bsOffcanvas.show();
            }
            EditGlobalIRID = IRID;
            EditGlobalProjectID = null;
            if (projectIdFromRow !== undefined && projectIdFromRow !== null && projectIdFromRow !== '' && !isNaN(projectIdFromRow)) {
                var _ep = parseInt(String(projectIdFromRow), 10);
                if (!isNaN(_ep)) {
                    EditGlobalProjectID = _ep;
                }
            }
            //Added By Vyankat B. on 26-Mar-2026 for binding IR IDs (before reading IR_ID_Filter so list is filled first).

            if (!flag) {

                var projectIdForRfIs = null;
                if (EditGlobalProjectID !== null && EditGlobalProjectID !== undefined && EditGlobalProjectID !== '' && !isNaN(EditGlobalProjectID)) {
                    projectIdForRfIs = parseInt(String(EditGlobalProjectID), 10);
                }
                if (projectIdForRfIs === null || isNaN(projectIdForRfIs) || projectIdForRfIs === 0) {
                    var cboVal = $("#cboProject").val();
                    projectIdForRfIs = cboVal ? parseInt(cboVal, 10) : null;
                }
                if (projectIdForRfIs === null || isNaN(projectIdForRfIs) || projectIdForRfIs === 0) {
                    var sp = (typeof SessionProjectID !== "undefined" && SessionProjectID !== null && SessionProjectID !== undefined)
                        ? String(SessionProjectID).trim()
                        : "";
                    if (sp !== "") {
                        var psi = parseInt(sp, 10);
                        if (!isNaN(psi) && psi > 0) {
                            projectIdForRfIs = psi;
                        }
                    }
                }

                var param1 = {
                    rfiid: null,
                    projectID: projectIdForRfIs,
                    isProforma: null,
                    rfiTypeID: null,
                    currentStatus: null,
                    customerID: null,
                    salesPeriodID: null,
                    userType: "Approver",
                    employeeID: irApprovalUserID,
                    applySubmittedOrResubmittedOrSpecificRFI: true,
                    specificRFIID: EditGlobalIRID,
                    applyIRApproverProjectFilter: true,
                    pageNumber: null
                };


                var result = AJAXCallWithResult(
                    'api/IRApproval/GetRFIs',
                    JSON.stringify(param1),
                    false
                );



                var list = [];
                if (result) {
                    if (result.rfis && Array.isArray(result.rfis.RFIsResponse)) {
                        list = result.rfis.RFIsResponse;
                    } else if (result.RFIs && Array.isArray(result.RFIs.RFIsResponse)) {
                        list = result.RFIs.RFIsResponse;
                    } else if (result.data && result.data.rfIs && Array.isArray(result.data.rfIs.rFIsResponse)) {
                        list = result.data.rfIs.rFIsResponse;
                    } else if (Array.isArray(result.RFIsResponse)) {
                        list = result.RFIsResponse;
                    }
                }
                var strHTML = "";
                for (var i = 0; i < list.length; i++) {
                    var id = list[i].rfiid;
                    if (id == null) id = list[i].rfiId;
                    if (id == null) id = list[i].RFIID;
                    if (id == null) continue;
                    strHTML += "<option value='" + id + "'>" + id + "</option>";
                }
                if (strHTML === '' && EditGlobalIRID) {
                    strHTML = "<option value='" + EditGlobalIRID + "'>" + EditGlobalIRID + "</option>";
                }
                try {
                    $("#IR_ID_Filter").selectpicker("destroy");
                } catch (irIdSpErr) { }
                $("#IR_ID_Filter").html(strHTML);
                $("#IR_ID_Filter").addClass("selectpicker form-control");
                $("#IR_ID_Filter").selectpicker({ width: "100%", liveSearch: true });
                if (strHTML !== "") {
                    $("#IR_ID_Filter").val(String(IRID));
                    $("#IR_ID_Filter").selectpicker("refresh");
                }
            }

            var irID = $.trim($('#IR_ID_Filter').val());
            var rfiItemIDValue = IRID;
            // Validation — kept in place for when rfiItemID becomes dynamic from #IR_ID_Filter
            if (irID !== '') {
                if (isNaN(irID) || parseInt(irID, 10) <= 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    // Added By Vyankat B. on 30th March 2026 for IR ID invalid alert resource
                    alertify.notify('<%=MyBase.GetResourceString("A_InvalidIRID")%>', 'error', 5);
                    // End of Added By Vyankat B. on 30th March 2026 for IR ID invalid alert resource
                    return;
                }
                // Once dynamic: rfiItemIDValue = parseInt(irID, 10);
            }
            var $tbody = $('#IRPIR_EditDetailsTbl tbody');
            var $tfoot = $('#IRPIR_EditDetailsTbl tfoot');
            $('#irEditTotalAmountInr').html('&nbsp;');
            $('#irEditTotalAmountCorp').html('&nbsp;');
            $('#irEditTotalAmountComp').html('&nbsp;');
            $tbody.html('<tr><td colspan="8" class="text-center">Loading...</td></tr>');
            $tfoot.empty();
            var param = {
                rfiItemID: null,
                rfiid: EditGlobalIRID
            };
            try {
                
                var result = AJAXCallWithResult(
                    'api/IRApproval/GetRFIItems',
                    JSON.stringify(param),
                    false
                );
                var list = [];
                if (
                    result &&
                    result.rfiItems &&
                    result.rfiItems.RFIItemsResponse
                ) {
                    list = result.rfiItems.RFIItemsResponse;
                }
                // Destroy existing DataTable instance before touching the DOM
                if (irEditDetailsTable) {
                    irEditDetailsTable.destroy();
                    irEditDetailsTable = null;
                }
                $tbody.empty();
                $tfoot.empty();
                if (!list.length) {
                    $tbody.html('<tr><td colspan="8" class="text-center">No records found.</td></tr>');
                    // irEditDetailsTable is null here (destroyed above); updateIrEditPagination() would no-op — set label and buttons explicitly.
                    $('#irEditTotalRecordsText').text('Total Records: 0');
                    $('#irEditPrevPageBtn').prop('disabled', true);
                    $('#irEditNextPageBtn').prop('disabled', true);
                } else {

                    RFIItemAdvisedIDs = [];
                    var srNo = 1;
                    for (var i = 0; i < list.length; i++) {
                        var item = list[i];
                        // The API always returns the Total Amount row as the last entry
                        var isTotalRow = (item.description === 'Total Amount');
                     
                        // ✅ Store IDs (only for normal rows)
                        if (!isTotalRow && item.rfiItemID !== null && item.rfiItemID !== undefined) {
                            RFIItemAdvisedIDs.push(item.rfiItemID);
                        }


                        if (isTotalRow) {
                            $('#irEditTotalAmountInr').text(item.amountINR !== null ? item.amountINR : '');
                            $('#irEditTotalAmountCorp').text(item.equivINRAmountCorporateBase !== null ? item.equivINRAmountCorporateBase : '');
                            $('#irEditTotalAmountComp').text(item.equivINRAmountCompanyBase !== null ? item.equivINRAmountCompanyBase : '');
                        }
                        else {
                            // Render data rows in tbody
                            $tbody.append(
                                '<tr>'
                                + '<td>' + srNo + '</td>'
                                + '<td>' + irFormatLongTextTooltip(item.description !== null ? item.description : '') + '</td>'
                                + '<td>' + (item.discount !== null ? item.discount : '') + '</td>'
                                + '<td>' + (item.quantity !== null ? item.quantity : '') + '</td>'
                                + '<td>' + (item.rateINR !== null ? item.rateINR : '') + '</td>'
                                + '<td>' + (item.amountINR !== null ? item.amountINR : '') + '</td>'
                                + '<td>' + (item.equivINRAmountCorporateBase !== null ? item.equivINRAmountCorporateBase : '') + '</td>'
                                + '<td>' + (item.equivINRAmountCompanyBase !== null ? item.equivINRAmountCompanyBase : '') + '</td>'
                                + '</tr>'
                            );
                            srNo++;
                        }
                    }
                    irEditDetailsTable = $('#IRPIR_EditDetailsTbl').DataTable({
                        "paging": true,
                        "pageLength": 5,
                        "bLengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": false,
                        "destroy": true,
                        "autoWidth": false,
                        "info": false
                    });
                    irEditDetailsTable.on('draw', function () {
                        updateIrEditPagination();
                        irInitTableTooltips($('#IRPIR_EditDetailsTbl'));
                    });
                    updateIrEditPagination();
                    // Keep edit items grid width stable inside offcanvas after refresh/rebind.
                    setTimeout(function () {
                        if (irEditDetailsTable) {
                            $('#IRPIR_EditDetailsTbl').css('width', '100%');
                            irEditDetailsTable.columns.adjust().draw(false);
                            irInitTableTooltips($('#IRPIR_EditDetailsTbl'));
                        }
                    }, 0);

                }
            } catch (e) {
                console.error('Error loading RFI items:', e);
                $tbody.html('<tr><td colspan="8" class="text-center text-danger">Failed to load items.</td></tr>');
                if (irEditDetailsTable) {
                    try { irEditDetailsTable.destroy(); } catch (ignore) { }
                    irEditDetailsTable = null;
                }
                $('#irEditTotalRecordsText').text('Total Records: 0');
                $('#irEditPrevPageBtn').prop('disabled', true);
                $('#irEditNextPageBtn').prop('disabled', true);
            }

            // Added By Vyankat B. on 27-Mar-2026 for binding details section from GetRFIsDetails API.
            var detailsParam = {
                rfiid: EditGlobalIRID

            };

            var detailsResult = AJAXCallWithResult(
                'api/IRApproval/GetRFIsDetails',
                JSON.stringify(detailsParam),
                false
            );

            var detailsList = (detailsResult &&
                detailsResult.rfisDetails &&
                Array.isArray(detailsResult.rfisDetails.RFIsDetailsResponse))
                ? detailsResult.rfisDetails.RFIsDetailsResponse
                : [];
            if (detailsList.length > 0) {
                var details = detailsList[0];
                var detPid = details.projectID != null ? details.projectID
                    : (details.projectId != null ? details.projectId
                    : (details.ProjectID != null ? details.ProjectID
                    : (details.intProjectID != null ? details.intProjectID
                    : (details.rfiProjectID != null ? details.rfiProjectID : details.RFIProjectID))));
                if (detPid != null && detPid !== "" && !isNaN(detPid)) {
                    EditGlobalProjectID = parseInt(String(detPid), 10);
                }
                var isProforma = details.isProforma === true || details.isProforma === 1 || details.isProforma === "1";
                $('#PIR_Edit').prop('checked', isProforma);
                $('#IR_Edit').prop('checked', !isProforma);
                $("#IR_TypeValue").text(details.rfiTypeName || "");
                $("#creditDaysValue").text(details.creditDays ?? "");
                $("#customerValue").text(details.customerName || "");
                $("#conrctPersonValue").text(details.contactPerson || "");
                $("#salesPeriodValue").text(details.salesPeriod || "");
                $("#EmailConfirmValue").text(details.confirmEmailID || "");
                $("#ContrctValue").text(details.invoiceingMilestones || "");
                $("#currencyValue").text(
                    (details.billingCurrencyCode || "") + " (" + (details.billingCurrencySymbol || "") + ")"
                );
                $("#salesPersonValue").text(details.salesPerson || "");
                $("#IR_ItemsHeaderValue").html(irFormatLongTextTooltip(details.rfiHeader || "", 50));
                irInitTableTooltips($("#IR_ItemsHeaderValue"));
                // Added By Vyankat B. on 27-Mar-2026 for Customer Address modal API parameters.
                customerID = details.customerID || details.CustomerID || null;
                customerAddressID = irNormalizeCustomerAddressId(details.customerAddressID || details.CustomerAddressID || null);
                // End of Added By Vyankat B. on 27-Mar-2026 for Customer Address modal API parameters.
                rFIRaisedBy = details.rfiRaisedBy;
                rFIRaisedOn = details.rfiRaisedOn || details.RFIRaisedOn || '';
                GContractID = details.contractID || details.ContractID;
                var Status = details.currentStatus;
                if (Status == "Approved" || Status == "Rejected" || Status == "Approved") {
                    $("#ChangStatusEdtIRBtn").attr("disabled", true);
                } else {
                    $("#ChangStatusEdtIRBtn").attr("disabled", false);
                }
            }
            ChangeStatusRFIID(EditGlobalIRID);

            // Show "Show History" button only if history/audit trail exists for this IR/PIR.
            // Uses existing API bound in bindIRAuditTrailHistory().
            try {
               // debugger
                var $hisBtn = $("#ShowHisEditIRBtn");
                if ($hisBtn.length) {
                    var projectId = EditGlobalProjectID;
                    if (projectId === null || projectId === undefined || projectId === "" || isNaN(projectId)) {
                        projectId = $("#cboProject").val();
                    }
                    if (projectId === null || projectId === undefined || projectId === "" || isNaN(projectId)) {
                        projectId = (typeof SessionProjectID !== "undefined" && SessionProjectID !== null && SessionProjectID !== undefined)
                            ? String(SessionProjectID).trim()
                            : "";
                    }
                    projectId = parseInt(projectId, 10) || 0;

                    var auditParam = {
                        projectId: projectId,
                        rfiid: EditGlobalIRID,
                        employeeId: null,
                        fieldName: null
                    };

                    var auditResult = AJAXCallWithResult(
                        "api/IRApproval/GetRFIsAuditTrail",
                        JSON.stringify(auditParam),
                        false
                    );

                    var auditList = (auditResult &&
                        auditResult.rfisAuditTrail &&
                        Array.isArray(auditResult.rfisAuditTrail.RFIsAuditTrailResponse))
                        ? auditResult.rfisAuditTrail.RFIsAuditTrailResponse
                        : [];

                    if (auditList.length === 0) {
                        $hisBtn.hide();
                    } else {
                        $hisBtn.show();
                    }
                }
            } catch (e) {
                // If history check fails, keep button visible rather than blocking access.
                $("#ShowHisEditIRBtn").show();
            }


            

            var projectId = EditGlobalProjectID;
            if (projectId === null || projectId === undefined || projectId === "" || isNaN(projectId)) {
                projectId = $("#cboProject").val();
            }
            if (projectId === null || projectId === undefined || projectId === "" || isNaN(projectId)) {
                projectId = (typeof SessionProjectID !== "undefined" && SessionProjectID !== null && SessionProjectID !== undefined)
                    ? String(SessionProjectID).trim()
                    : "";
            }
            projectId = parseInt(projectId, 10) || 0;

            var auditParam = {
                projectId: projectId,

            };

            var auditResult = AJAXCallWithResult(
                "api/IRApproval/GetCorpCompCurrency",
                JSON.stringify(auditParam),
                false
            );

            var currencyData = auditResult.corpCompCurrencies?.CorpCompCurrencyResponse || [];

            var corp = currencyData.find(x => x.currencyType === "Corporate");
            var comp = currencyData.find(x => x.currencyType === "Company");

            // Set Corporate
            if (corp) {
                $("#corpCurrency").text(`${corp.currencyCode} (${corp.currencySymbol})`);
            }

            // Set Company
            if (comp) {
                $("#compCurrency").text(`${comp.currencyCode} (${comp.currencySymbol})`);
            }

            // Billing currency
            $(".amountCurrency").text(details.billingCurrencySymbol || "");
           

        }

        // Added By Vyankat B. on 27-Mar-2026 for opening selected IR from Show link.
        $('#showEditIRBtn').on('click', function (e) {
            //debugger
            e.preventDefault();
            var selectedIRID = $.trim($('#IR_ID_Filter').val());
            if (selectedIRID === '' || isNaN(selectedIRID) || parseInt(selectedIRID, 10) <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                // Added By Vyankat B. on 30th March 2026 for selected valid IR ID alert resource
                alertify.notify('<%=MyBase.GetResourceString("A_PleaseSelectValidIRID")%>', 'error', 5);
                // End of Added By Vyankat B. on 30th March 2026 for selected valid IR ID alert resource
                return;
            }
            EditIRPIR(parseInt(selectedIRID, 10),true);
        });
        // End of Added By Vyankat B. on 27-Mar-2026 for opening selected IR from Show link.

        // Added By Vyankat B. on 27-Mar-2026 to keep offcanvas open on View Checklist click.
        $('#ViewChecklistEditIRBtn').on('click', function () {
            var offcanvasElement = document.getElementById('offcvsIRPIR_Edit_Screen');
            if (offcanvasElement) {
                bootstrap.Offcanvas.getOrCreateInstance(offcanvasElement).show();
            }
        });
        // End of Added By Vyankat B. on 27-Mar-2026 to keep offcanvas open on View Checklist click.

        // Added By Vyankat B. on 27-Mar-2026 to keep offcanvas open on Address click (same as Checklist).
        $('#AddressEditIRBtn').on('click', function () {
            var offcanvasElement = document.getElementById('offcvsIRPIR_Edit_Screen');
            if (offcanvasElement) {
                bootstrap.Offcanvas.getOrCreateInstance(offcanvasElement).show();
            }
        });
        // End of Added By Vyankat B. on 27-Mar-2026 to keep offcanvas open on Address click (same as Checklist).

        // Added By Vyankat B. on 27-Mar-2026 to keep offcanvas open on Show History click (same as Checklist).
        $('#ShowHisEditIRBtn').on('click', function () {
            var offcanvasElement = document.getElementById('offcvsIRPIR_Edit_Screen');
            if (offcanvasElement) {
                bootstrap.Offcanvas.getOrCreateInstance(offcanvasElement).show();
            }
        });
        // End of Added By Vyankat B. on 27-Mar-2026 to keep offcanvas open on Show History click (same as Checklist).

        // Stop wheel/touch scroll chaining from Checklist child offcanvas to parent IR offcanvas.
        $('#offcvsViewChecklist .offcanvas-body').on('wheel touchmove', function (e) {
            e.stopPropagation();
        });
        
        $('#offcvsIRPIR_Edit_Screen').on('show.bs.offcanvas', function () {
            syncIROffcanvasOpacityState();
        });
        $('#offcvsIRPIR_Edit_Screen').on('shown.bs.offcanvas', function () {
            // Safety cleanup: keep only one backdrop and normalize table width.
            var $backdrops = $('.offcanvas-backdrop');
            if ($backdrops.length > 1) {
                $backdrops.not(':last').remove();
            }
            if (irEditDetailsTable) {
                irEditDetailsTable.columns.adjust().draw(false);
            }
        });
        // Added or Modified by Vishal Mane on 27/03/2026 to prevent black overlay after closing parent offcanvas
        $('#offcvsIRPIR_Edit_Screen').on('hidden.bs.offcanvas', function () {
            HideContractDetailsCanvas();
            $('.offcanvas-backdrop').remove();
            $('body').removeClass('offcanvas-open');
            syncIROffcanvasOpacityState();
            $('body').css({ overflow: '', 'padding-right': '' });
        });

        function getTodayYYYYMMDD() {
            var d = new Date();
            var yyyy = d.getFullYear();
            var mm = String(d.getMonth() + 1).padStart(2, '0');
            var dd = String(d.getDate()).padStart(2, '0');
            return `${yyyy}${mm}${dd}`;
        }
        function joinUrl(base, path) {
            return base.replace(/\/+$/, '') + '/' + path.replace(/^\/+/, '');
        }
    //End of Added By Vaibhav K on 18-03-2026 - Bind IRPIR_EditDetailsTbl from GetRFIItems API

        // Added or Modified by Vishal Mane on 27/03/2026 to open Show Details as child canvas without hiding parent offcanvas
        function ShowContractDetails() {
            syncContractDetailsCanvasWithParent();
            $("#contractDetailsBackdrop").addClass("open");
            $("#ShowContractDtlsModal").addClass("open").attr("aria-hidden", "false"); 
            syncIROffcanvasOpacityState();
            var ProjectDetails = {
                RFIID: encodeURI(EditGlobalIRID),
            }
            var param = JSON.stringify(ProjectDetails)
            var strResult = AJAXCallWithResult('api/IRApproval/ShowRFIContract', param, false);
            $("#lblCurrencyChange").text(strResult[0].contractSummary);
            $("#lblCustomerName").text(strResult[0].customerName);
            $("#lblCommencementDate").text(strResult[0].contractStartDate);
            $("#lblContrctEndDate").text(strResult[0].contractEndDate);
            $("#lblContractDetail").text(strResult[0].invoiceingMilestones);
            $("#lblPOSOWNumber").text(strResult[0].poNumber);
            $("#lblPOSOWValue").text(strResult[0].poValue);
            $("#lblCRMNO").text(strResult[0].crmno);
            $("#lblContractType").text(strResult[0].contractTypeName);
            $("#lblContrctSignDate").text(strResult[0].contractSummaryDate);
            $("#lblContcurrency").text(strResult[0].currencyCode);
            if (strResult[0].remainingPOWVal < 0) {
                $("#lbl_RemainPOVal").css('color', 'red');
                $("#lbl_RemainPOVal").text(strResult[0].remainingPOWVal);
            }
            else {
                $("#lbl_RemainPOVal").css('color', 'green');
                $("#lbl_RemainPOVal").text(strResult[0].remainingPOWVal);
            }
            GetRFIContractDocument(strResult[0].contractID);
        }

        function GetRFIContractDocument(ContractID) {
            var strHTML = "";
            var RequestParameters = {
                ContractID: ContractID
            }
            var param = JSON.stringify(RequestParameters);
            //var Result = AJAXCallWithResult("/api/RFI_IR_PIR/GetRFIContractDocument", param, false);
            var Result = AJAXCallWithResult('api/IRApproval/GetRFIContractDocument', param, false);
            if (Result.length > 0 && Result.length != null && Result != undefined) {
                for (var i = 0; i < Result.length; i++) {
                    var ContractAttachmentID = Result[i]["contractAttachmentID"];
                    var ContractID = Result[i]["contractID"];
                    var OriginalFileName = Result[i]["originalFileName"];
                    var FileSize = Result[i]["fileSize"];
                    var AttachedBy = Result[i]["attachedBy"];
                    var AttachedOn = Result[i]["attachedOn"];
                    var Description = Result[i]["description"] != null ? Result[i]["description"] : Result[i]["Description"];
                    var SystemFileName = Result[i]["systemFileName"];
                    strHTML += '<tr>'
                    strHTML += '<td> ' + (i + 1) + '</td>'
                    strHTML += '<td> <a href="javascript:;" class="textUndrln" onclick="DownloadFile(\'' + OriginalFileName + '\',\'' + SystemFileName + '\') ">' + OriginalFileName + '</a></td>'
                    strHTML += '<td>' + AttachedBy + '</td>'
                    strHTML += '<td>' + AttachedOn + '</td>'
                    strHTML += '<td>' + irFormatLongTextTooltip(Description != null ? Description : '', 50) + '</td>'
                    strHTML += '</tr>'
                }
            }
            $('#ContractAttachTbl').dataTable().fnDestroy();
            $("#ContractAttachTblBody").html(strHTML);
            // Added or Modified by Vishal Mane on 27/03/2026 to keep Contract Attachments pagination same as other custom table structures
            irContractAttachTable = $('#ContractAttachTbl').DataTable({
                "paging": true,
                "pageLength": 5,
                "bLengthChange": false,
                "bFilter": false,
                // Added By Vyankat B. on 30th March 2026 to hide sorting arrows in Contract Attachments grid.
                "ordering": false,
                // End of Added By Vyankat B. on 30th March 2026 to hide sorting arrows in Contract Attachments grid.
                "responsive": true,
                "destroy": true,
                "bFilter": false,
                "info": false
            });
            // Added or Modified by Vishal Mane on 27/03/2026 to keep Contract Attachments pagination same as other custom table structures
            if (irContractAttachTable) {
                irContractAttachTable.off('draw').on('draw', function () {
                    updateIrContractPagination();
                    irInitTableTooltips($('#ContractAttachTbl'));
                });
                updateIrContractPagination();
            }
            irInitTableTooltips($('#ContractAttachTbl'));
            $(".table").resize();
        }
        function DownloadFile(OriginalFileName, SystemFileName) {
            if (SystemFileName == null) {
                SystemFileName = '';
            }
            var strTemp = '../../General/ViewAttachment.aspx?FromWhere=Contracts&FileName=' + OriginalFileName + '&SystemFileName=' + SystemFileName;
            window.open(strTemp);
        }

        // Added or Modified by Vishal Mane on 27/03/2026 to open Show Details as child canvas without hiding parent offcanvas
        function HideContractDetailsCanvas() {
            $("#ShowContractDtlsModal").removeClass("open").attr("aria-hidden", "true");
            $("#contractDetailsBackdrop").removeClass("open");
            syncIROffcanvasOpacityState();
        }
        // Added or Modified by Vishal Mane on 27/03/2026 to align child canvas with parent offcanvas
        function syncContractDetailsCanvasWithParent() {
            var $parent = $("#offcvsIRPIR_Edit_Screen");
            var $child = $("#ShowContractDtlsModal");
            var $backdrop = $("#contractDetailsBackdrop");
            if (!$parent.length || !$child.length || !$backdrop.length) return;
            var rect = $parent[0].getBoundingClientRect();
            $child.css({
                top: rect.top + "px",
                height: rect.height + "px"
            });
            $backdrop.css({
                top: rect.top + "px",
                height: rect.height + "px"
            });
        }
        // Added or Modified by Vishal Mane on 27/03/2026 to keep child canvas aligned on resize
        $(window).on("resize", function () {
            if ($("#ShowContractDtlsModal").hasClass("open")) {
                syncContractDetailsCanvasWithParent();
            }
        });
        // Added or Modified by Vishal Mane on 27/03/2026 to support ESC close for child canvas
        $(document).on('keydown', function (e) {
            if (e.key === "Escape" && $("#ShowContractDtlsModal").hasClass("open")) {
                HideContractDetailsCanvas();
            }
        });

        function setCustomerAddressDetails(selectedAddressId) {
            if (!customerAddressList || customerAddressList.length === 0) {
                $("#addrDetlsInfo, #addrCityInfo, #addrStateInfo, #addrCountryInfo, #addrZipCodeInfo, #addrFaxNoInfo, #addrTelNoInfo").text("");
                return;
            }
            var selected = null;
            for (var i = 0; i < customerAddressList.length; i++) {
                var row = customerAddressList[i];
                var rowAddressId = row.customerAddressID || row.CustomerAddressID || 0;
                if (String(rowAddressId) === String(selectedAddressId)) {
                    selected = row;
                    break;
                }
            }
            if (!selected) {
                selected = customerAddressList[0];
            }
            $("#custNameInfo").text(selected.customerName || selected.CustomerName || $("#customerValue").text() || "");
            $("#addrDetlsInfo").text(selected.address || selected.Address || "");
            $("#addrCityInfo").text(selected.city || selected.City || "");
            $("#addrStateInfo").text(selected.state || selected.State || "");
            $("#addrCountryInfo").text(selected.country || selected.Country || "");
            $("#addrZipCodeInfo").text(selected.pinCode || selected.PinCode || "");
            $("#addrFaxNoInfo").text(selected.faxNumber || selected.FaxNumber || "");
            $("#addrTelNoInfo").text(selected.telephoneNumber || selected.TelephoneNumber || "");
        }

        function loadCustomerDetails() {
            var param = {
                CustomerID: customerID,
                CustomerAddressID: irNormalizeCustomerAddressId(customerAddressID)
            };
            var result = AJAXCallWithResult(
                'api/IRApproval/GetCustomerAddresses',
                JSON.stringify(param),
                false
            );
            var list = (result &&
                result.customerAddresses &&
                Array.isArray(result.customerAddresses.CustomerAddressesResponse))
                ? result.customerAddresses.CustomerAddressesResponse
                : [];

            customerAddressList = list || [];
            var strHTML = "<option value=''>Select Address</option>";

            if (customerAddressList.length > 0) {
                for (var i = 0; i < customerAddressList.length; i++) {
                    var row = customerAddressList[i];
                    var rowAddressId = row.customerAddressID || row.CustomerAddressID || 0;
                    var addressCode = row.addressCode || row.AddressCode || "";
                    var selectedAttr = (customerAddressID !== null && String(rowAddressId) === String(customerAddressID)) ? " selected" : "";
                    strHTML += "<option value='" + rowAddressId + "'" + selectedAttr + ">" + (addressCode || "Address " + rowAddressId) + "</option>";
                }
                $("#custAddressInfo").html(strHTML);
                $("#custAddressInfo").selectpicker('refresh');

                if (customerAddressID === null || customerAddressID === undefined || customerAddressID === '') {
                    customerAddressID = irNormalizeCustomerAddressId($("#custAddressInfo").val());
                } else {
                    customerAddressID = irNormalizeCustomerAddressId(customerAddressID);
                }
                setCustomerAddressDetails(customerAddressID);
            } else {
                $("#custAddressInfo").html("<option value=''>No Address Found</option>");
                $("#custAddressInfo").selectpicker('refresh');
                setCustomerAddressDetails(null);
            }
        }

        var isEditOffcanvasOpenBeforeAddress = false;
        $('#offcvsCustomerAddress').on('show.bs.offcanvas', function () {
            isEditOffcanvasOpenBeforeAddress = $('#offcvsIRPIR_Edit_Screen').hasClass('show');
        });

        $('#offcvsCustomerAddress').on('shown.bs.offcanvas', function () {
            if (isEditOffcanvasOpenBeforeAddress && !$('#offcvsIRPIR_Edit_Screen').hasClass('show')) {
                bootstrap.Offcanvas.getOrCreateInstance(document.getElementById('offcvsIRPIR_Edit_Screen')).show();
            }
            loadCustomerDetails();

            // Added By Vyankat B. on 30th March 2026 to close Address offcanvas on outside click.
            setTimeout(function () {
                $(document).off('mousedown.addressOutsideClose').on('mousedown.addressOutsideClose', function (e) {
                    var $addressOffcanvas = $('#offcvsCustomerAddress');
                    if (!$addressOffcanvas.hasClass('show')) return;

                    var clickedInsideAddress = $(e.target).closest('#offcvsCustomerAddress').length > 0;
                    var clickedAddressTrigger = $(e.target).closest('#AddressEditIRBtn').length > 0;
                    if (!clickedInsideAddress && !clickedAddressTrigger) {
                        bootstrap.Offcanvas.getOrCreateInstance(document.getElementById('offcvsCustomerAddress')).hide();
                    }
                });
            }, 0);
            // End of Added By Vyankat B. on 30th March 2026 to close Address offcanvas on outside click.
        });

        $('#offcvsCustomerAddress').on('hidden.bs.offcanvas', function () {
            $(document).off('mousedown.addressOutsideClose');
            if (isEditOffcanvasOpenBeforeAddress && !$('#offcvsIRPIR_Edit_Screen').hasClass('show')) {
                bootstrap.Offcanvas.getOrCreateInstance(document.getElementById('offcvsIRPIR_Edit_Screen')).show();
            }
        });

        $('#custAddressInfo').on('change', function () {
            customerAddressID = irNormalizeCustomerAddressId($(this).val());
            setCustomerAddressDetails(customerAddressID);
        });

        //Added by Vishal Mane on 30/03/2026 to bind Customere Projects
        function BindCustomerProjects(CustomerID) {
            var $projDropdown = $('#cboProject');
            if (!$projDropdown.length) return;
            if (irApprovalUserID <= 0) {
                $projDropdown.html('<option value="">Select Project</option>').selectpicker('refresh');
                return;
            }
            var intCustomerID = parseInt(CustomerID, 10) || 0;
            var param = {
                UserID: irApprovalUserID,
                LoginType: irApprovalLoginType,
                // Matches the legacy stored procedure filters:
                // usp_Whizible2_Sel_Accessible_CustomerWise_Projects <UserID>, <LoginType>, 1, 0, '[Over] = ''0'', 'ProjectName ASC'
                ShowReleasedProjects: true,
                LoginID: 0,
                WhereCriteria: "P.[Over] = '0'",
                OrderBy: "ProjectName ASC",
                CustomerID: intCustomerID
            };
            try {
                var result = AJAXCallWithResult('api/IRApproval/GetCustomerProjects', JSON.stringify(param), false);                
                var data = result.accessibleProjects;
                var list = (data || Array.isArray(data)) ? data : [];
                //$projDropdown.empty().append($('<option value="">Select Project</option>'));
                $projDropdown.empty();
                for (var i = 0; i < list.length; i++) {
                    var p = list[i];
                    var id = (p.projectID !== undefined) ? p.projectID : (p.ProjectID !== undefined) ? p.ProjectID : '';
                    var name = (p.projectName !== undefined) ? p.projectName : (p.ProjectName !== undefined) ? p.ProjectName : '';
                    if (id !== '' && id !== undefined) {
                        $projDropdown.append($('<option></option>').attr('value', id).text(name || ('Project ' + id)));
                    }
                }
                $projDropdown.selectpicker('refresh');
            } catch (e) {
                console.error('Error loading accessible projects:', e);
                $projDropdown.html('<option value="">Select Project</option>').selectpicker('refresh');
            }
        }
    </script>


</body>

</html>
